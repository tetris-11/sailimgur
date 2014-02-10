import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components/storage.js" as Storage

Dialog {
    id: settingsPage;
    allowedOrientations: Orientation.All;

    SilicaFlickable {
        id: settingsFlickable;

        anchors.fill: parent;
        contentHeight: contentArea.height;

        DialogHeader {
            id: header;
            title: qsTr("Settings");
            acceptText: qsTr("Save");
        }

        Column {
            id: contentArea;
            anchors { top: header.bottom; left: parent.left; right: parent.right }
            width: settingsPage.width;
            height: childrenRect.height;

            anchors.leftMargin: constant.paddingMedium;
            anchors.rightMargin: constant.paddingMedium;

            Slider {
                value: settings.albumImagesLimit;
                minimumValue: 1;
                maximumValue: 10;
                stepSize: 1;
                width: parent.width;
                valueText: value;
                label: qsTr("Images shown in album");
                onValueChanged: {
                    settings.albumImagesLimit = value;
                }
            }

            TextSwitch {
                text: qsTr("Show comments");
                checked: settings.showComments;
                onCheckedChanged: {
                    checked ? settings.showComments = true : settings.showComments = false;
                }
            }
        }

        ScrollDecorator {}
    }

    onAccepted: {
        Storage.db = Storage.connect();
        Storage.writeSetting(Storage.db, "albumImagesLimit", settings.albumImagesLimit);
        Storage.writeSetting(Storage.db, "showComments", settings.showComments);
    }

    Component.onCompleted: {
    }
}
