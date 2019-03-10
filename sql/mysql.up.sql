/*
 * Copyright (c) 2018 Miguel Ángel Ortuño.
 * See the LICENSE file for more information.
 */

-- users

CREATE TABLE IF NOT EXISTS users (
    username         VARCHAR(256) PRIMARY KEY,
    password         TEXT NOT NULL,
    last_presence    TEXT NOT NULL,
    last_presence_at DATETIME NOT NULL,
    updated_at       DATETIME NOT NULL,
    created_at       DATETIME NOT NULL
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- roster_notifications

CREATE TABLE IF NOT EXISTS roster_notifications (
    contact    VARCHAR(256) NOT NULL,
    jid        VARCHAR(512) NOT NULL,
    elements   TEXT NOT NULL,
    updated_at DATETIME NOT NULL,
    created_at DATETIME NOT NULL,
    PRIMARY KEY (contact, jid)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE INDEX IF NOT EXISTS i_roster_notifications_jid ON roster_notifications(jid);

-- roster_items

CREATE TABLE IF NOT EXISTS roster_items (
    username     VARCHAR(256) NOT NULL,
    jid          VARCHAR(512) NOT NULL,
    name         TEXT NOT NULL,
    subscription TEXT NOT NULL,
    `groups`     TEXT NOT NULL,
    ask          BOOL NOT NULL,
    ver          INT NOT NULL DEFAULT 0,
    updated_at   DATETIME NOT NULL,
    created_at   DATETIME NOT NULL,
    PRIMARY KEY (username, jid)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE INDEX IF NOT EXISTS i_roster_items_username ON roster_items(username);
CREATE INDEX IF NOT EXISTS i_roster_items_jid ON roster_items(jid);

-- roster_groups

CREATE TABLE IF NOT EXISTS roster_groups (
    username     VARCHAR(256) NOT NULL,
    jid          VARCHAR(512) NOT NULL,
    `group`      TEXT NOT NULL,
    updated_at   DATETIME NOT NULL,
    created_at   DATETIME NOT NULL
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE INDEX IF NOT EXISTS i_roster_groups_username_jid ON roster_groups(username, jid);

-- roster_versions

CREATE TABLE IF NOT EXISTS roster_versions (
    username          VARCHAR(256) NOT NULL,
    ver               INT NOT NULL DEFAULT 0,
    last_deletion_ver INT NOT NULL DEFAULT 0,
    updated_at        DATETIME NOT NULL,
    created_at        DATETIME NOT NULL,
    PRIMARY KEY (username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- blocklist_items

CREATE TABLE IF NOT EXISTS blocklist_items (
    username   VARCHAR(256) NOT NULL,
    jid        VARCHAR(512) NOT NULL,
    created_at DATETIME NOT NULL,
    PRIMARY KEY(username, jid)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE INDEX IF NOT EXISTS i_blocklist_items_username ON blocklist_items(username);

-- private_storage

CREATE TABLE IF NOT EXISTS private_storage (
    username   VARCHAR(256) NOT NULL,
    namespace  VARCHAR(512) NOT NULL,
    data       MEDIUMTEXT NOT NULL,
    updated_at DATETIME NOT NULL,
    created_at DATETIME NOT NULL,
    PRIMARY KEY (username, namespace)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE INDEX IF NOT EXISTS i_private_storage_username ON private_storage(username);

-- vcards

CREATE TABLE IF NOT EXISTS vcards (
    username   VARCHAR(256) PRIMARY KEY,
    vcard      MEDIUMTEXT NOT NULL,
    updated_at DATETIME NOT NULL,
    created_at DATETIME NOT NULL
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- offline_messages

CREATE TABLE IF NOT EXISTS offline_messages (
    username   VARCHAR(256) NOT NULL,
    data       MEDIUMTEXT NOT NULL,
    created_at DATETIME NOT NULL
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE INDEX IF NOT EXISTS i_offline_messages_username ON offline_messages(username);
