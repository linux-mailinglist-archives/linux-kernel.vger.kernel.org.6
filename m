Return-Path: <linux-kernel+bounces-532155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D4BA44961
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CA731894475
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E85820E6F2;
	Tue, 25 Feb 2025 17:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDEKAWZy"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A33520B1E2
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506397; cv=none; b=NCZ2H5UVX+zJWnyl5MuqNqCc8hqjruwj7aJY34lmcozScFC7exSqyjd4iN/IgkaXHYbXopfBVYJRpukotjDl5PqYu5r9MOQI5ExCVwNFW4rcnFnvGJKB1WrNHpprkLljRtAOG/1AQ1N38xBTU71S8KZwhHKhrClIWYp8SKwDIp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506397; c=relaxed/simple;
	bh=zCp71uFAdalem5CHS8hBoSJC8yM/83uObY+zMk03qZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PHWMBtUgqIbo1zMaNvfcRWNr14xDBEG6kpj8ZGK5T+8VBnPzdJWQggMsykV4k2AgrPDTGeT8ZJKBANImNbD9conFH2Y/MrS1JSgH9vas/06mxIejWIbXD0z4dcTsZGv5uHOjsXI1WfQrfnBPDfBrUKh9PiyMTTBuRe0Li9NlSUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDEKAWZy; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4398e839cd4so453495e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740506392; x=1741111192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WseHHM1e/WuDgTg/fwsfkleyEd/vJ3pyq4Ce8rsGHo=;
        b=FDEKAWZyqgYDZobe4KS284aBDzDgvXjZ5AB+48qf5Morn/99SAGKgvSJHS4qO2rZSb
         aQ1DqlcVjjWs7DAXr3C/5N7NsBb6WTgLrECyeOy3y4AUm0h1r/MV2haibSBIzeb7BAhb
         5pxa3W+ASXkXuN6Z/4s3PfnkmJIUopgPHlZSEGqJ8cWwXKxWnyPO+X3cRCFVZlvAR6/X
         PgHTFd3FRd1HISYvIvHKO/1Cn7N6sm+gnHUUl47t+8bfTdOMR6QG8LVYVYJIHrwPKY/y
         VSc5l4obiA/ylMyaI/PU2Mmhk1kJ78jneMuqq0vo7XyxDodPvLYSnrZoa27KTeIObkcY
         ajLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740506392; x=1741111192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WseHHM1e/WuDgTg/fwsfkleyEd/vJ3pyq4Ce8rsGHo=;
        b=Y9jxzgo8z4eLNulJKsosPRalOPID0Bpb1mAUzf5h3BsuDrX/9ISK9k5PTlCIWUB5jR
         Gu2RRF5rfGn5oymPQi/n6XxZ7fGW5jUzRzS/3Aq+HlCGTliLyoPvjW1pNoZdhkYevzLD
         bA8BuDzByD1G9LZNmxrw2ZsEYQWnqvVVK0yhWS/qOxtUHiVe1gqReVqIVxJ4HIzPJLAj
         Pm/tLXh7sRZ65zUIyNfnlWu76b8+9nBnlo0C8yNJDGkPIy4B3euskmhCMRuf8pzyAxgG
         em1vG9XlY6CzFLMCDFrZthnxQcNRFrE7zijZEMLfHNq3YJjbMMX4avBdCfrFlPeOxI/H
         IQgw==
X-Forwarded-Encrypted: i=1; AJvYcCXyzTmuVboTKVIiwArg7ZaAtaOD+x6xkDgCoxgFt9Ln2PLnmMzH0uQlWm5XpnKgEcpkft/+gFNizabX+gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEHDD1ut8KJv7RIOXz2Jr0M5npBvncmq7D/NRDWRrXf2mFfOb2
	AJ/yVOqDFlaVWlKqaWmXJ3jjLj/8rJhQ8h2yRz6bKHFdgLx4N+Eg
X-Gm-Gg: ASbGncvUsDQZvJIBbWvi50KT7R6o108qwoEq5z85dtsgQ3VNjY76TfVhPGiD9NCnrfR
	91SueTW2PiPIgMYUJJDsG7uUM8Qx0rj3ip8ke3+zjwX25JpvAzPYb43uOx0xNrllsRgWND2jvCS
	MoMMsiEMDxcwfc3Kzo4uTaY6lVHLj6P2p4W9SIJHs6Rd3Sxt90lZbOh/wcIUtXuUsxpoSmwNrcN
	6h3HCG5zCWI4UEqZILCv+aApDjBedjI60aLNMjHkEWHoNzwTz3kJJFySlMpEw4/4oLdbWfhHrrb
	jx/dAAa8DUC1/dR+usqBPPqICb9Q
X-Google-Smtp-Source: AGHT+IFMAiFjDJbbuzZZaSIag4FnPbXCSWUSYHSMiX/Uiybv87JNBZ27yyUVQxEKr+V2yQ7kikWXmw==
X-Received: by 2002:a05:600c:88a:b0:439:91c7:895a with SMTP id 5b1f17b1804b1-439a30af6edmr185928635e9.7.1740506392239;
        Tue, 25 Feb 2025 09:59:52 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02f3e15sm149063655e9.22.2025.02.25.09.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 09:59:51 -0800 (PST)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: louis.chauvet@bootlin.com
Cc: hamohammed.sa@gmail.com,
	simona@ffwll.ch,
	melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2 10/16] drm/vkms: Allow to configure multiple connectors via configfs
Date: Tue, 25 Feb 2025 18:59:30 +0100
Message-ID: <20250225175936.7223-11-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250225175936.7223-1-jose.exposito89@gmail.com>
References: <20250225175936.7223-1-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Create a default subgroup at
/config/vkms/connectors to allow to create as many connectors as
required.

Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst           |  6 ++
 drivers/gpu/drm/vkms/vkms_configfs.c | 86 ++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 650dbfa76f59..744e2355db23 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -74,6 +74,7 @@ By default, the instance is disabled::
 And directories are created for each configurable item of the display pipeline::
 
   tree /config/vkms/my-vkms
+  ├── connectors
   ├── crtcs
   ├── enabled
   ├── encoders
@@ -103,6 +104,10 @@ Next, create one or more encoders::
 
   sudo mkdir /config/vkms/my-vkms/encoders/encoder0
 
+Last but not least, create one or more connectors::
+
+  sudo mkdir /config/vkms/my-vkms/connectors/connector0
+
 To finish the configuration, link the different pipeline items::
 
   sudo ln -s /config/vkms/my-vkms/crtcs/crtc0 /config/vkms/my-vkms/planes/plane0/possible_crtcs
@@ -127,6 +132,7 @@ And removing the top level directory and its subdirectories::
   sudo rmdir /config/vkms/my-vkms/planes/*
   sudo rmdir /config/vkms/my-vkms/crtcs/*
   sudo rmdir /config/vkms/my-vkms/encoders/*
+  sudo rmdir /config/vkms/my-vkms/connectors/*
   sudo rmdir /config/vkms/my-vkms
 
 Testing With IGT
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index 64aa10cd3156..bcbf91fbcd44 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -19,6 +19,7 @@ static bool is_configfs_registered;
  * @planes_group: Default subgroup of @group at "/config/vkms/planes"
  * @crtcs_group: Default subgroup of @group at "/config/vkms/crtcs"
  * @encoders_group: Default subgroup of @group at "/config/vkms/encoders"
+ * @connectors_group: Default subgroup of @group at "/config/vkms/connectors"
  * @lock: Lock used to project concurrent access to the configuration attributes
  * @config: Protected by @lock. Configuration of the VKMS device
  * @enabled: Protected by @lock. The device is created or destroyed when this
@@ -29,6 +30,7 @@ struct vkms_configfs_device {
 	struct config_group planes_group;
 	struct config_group crtcs_group;
 	struct config_group encoders_group;
+	struct config_group connectors_group;
 
 	struct mutex lock;
 	struct vkms_config *config;
@@ -81,6 +83,20 @@ struct vkms_configfs_encoder {
 	struct vkms_config_encoder *config;
 };
 
+/**
+ * struct vkms_configfs_connector - Configfs representation of a connector
+ *
+ * @group: Top level configuration group that represents a connector.
+ * Initialized when a new directory is created under "/config/vkms/connectors"
+ * @dev: The vkms_configfs_device this connector belongs to
+ * @config: Configuration of the VKMS connector
+ */
+struct vkms_configfs_connector {
+	struct config_group group;
+	struct vkms_configfs_device *dev;
+	struct vkms_config_connector *config;
+};
+
 #define device_item_to_vkms_configfs_device(item) \
 	container_of(to_config_group((item)), struct vkms_configfs_device, \
 		     group)
@@ -106,6 +122,10 @@ struct vkms_configfs_encoder {
 	container_of(to_config_group((item)), struct vkms_configfs_encoder, \
 		     possible_crtcs_group)
 
+#define connector_item_to_vkms_configfs_connector(item) \
+	container_of(to_config_group((item)), struct vkms_configfs_connector, \
+		     group)
+
 static ssize_t crtc_writeback_show(struct config_item *item, char *page)
 {
 	struct vkms_configfs_crtc *crtc;
@@ -469,6 +489,68 @@ static const struct config_item_type encoder_group_type = {
 	.ct_owner	= THIS_MODULE,
 };
 
+static void connector_release(struct config_item *item)
+{
+	struct vkms_configfs_connector *connector;
+	struct mutex *lock;
+
+	connector = connector_item_to_vkms_configfs_connector(item);
+	lock = &connector->dev->lock;
+
+	guard(mutex)(lock);
+	vkms_config_destroy_connector(connector->config);
+	kfree(connector);
+}
+
+static struct configfs_item_operations connector_item_operations = {
+	.release	= &connector_release,
+};
+
+static const struct config_item_type connector_item_type = {
+	.ct_item_ops	= &connector_item_operations,
+	.ct_owner	= THIS_MODULE,
+};
+
+static struct config_group *make_connector_group(struct config_group *group,
+						 const char *name)
+{
+	struct vkms_configfs_device *dev;
+	struct vkms_configfs_connector *connector;
+
+	dev = child_group_to_vkms_configfs_device(group);
+
+	guard(mutex)(&dev->lock);
+
+	if (dev->enabled)
+		return ERR_PTR(-EBUSY);
+
+	connector = kzalloc(sizeof(*connector), GFP_KERNEL);
+	if (!connector)
+		return ERR_PTR(-ENOMEM);
+
+	connector->dev = dev;
+
+	connector->config = vkms_config_create_connector(dev->config);
+	if (IS_ERR(connector->config)) {
+		kfree(connector);
+		return ERR_CAST(connector->config);
+	}
+
+	config_group_init_type_name(&connector->group, name,
+				    &connector_item_type);
+
+	return &connector->group;
+}
+
+static struct configfs_group_operations connectors_group_operations = {
+	.make_group	= &make_connector_group,
+};
+
+static const struct config_item_type connector_group_type = {
+	.ct_group_ops	= &connectors_group_operations,
+	.ct_owner	= THIS_MODULE,
+};
+
 static ssize_t device_enabled_show(struct config_item *item, char *page)
 {
 	struct vkms_configfs_device *dev;
@@ -573,6 +655,10 @@ static struct config_group *make_device_group(struct config_group *group,
 				    &encoder_group_type);
 	configfs_add_default_group(&dev->encoders_group, &dev->group);
 
+	config_group_init_type_name(&dev->connectors_group, "connectors",
+				    &connector_group_type);
+	configfs_add_default_group(&dev->connectors_group, &dev->group);
+
 	return &dev->group;
 }
 
-- 
2.48.1


