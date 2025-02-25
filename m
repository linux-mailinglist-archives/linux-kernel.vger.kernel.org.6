Return-Path: <linux-kernel+bounces-532147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF91A4497F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83C353BD732
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1353419F48D;
	Tue, 25 Feb 2025 17:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjIIeNJU"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EB919D88B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506388; cv=none; b=cFlNFJ+ohMlcxDL35njyW3yWbZBRvQwanhqS1pfRo3Tkz9INSzjSZKh/ePSdxr+G0QcXgYb9RyYi40xFDh2tdJoVZm+wSgmuUAg6c1luEOvdwQaFEWZtPkYf3KxtQ0AvUDdrG59OIXXncLJcqYVtSrT752YMVHrUqVeihmDruk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506388; c=relaxed/simple;
	bh=ctqaUOq1M6An9ej38Z0g62G3F301i5GYhVLvHQCzSdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ohsgVXn6eX+vRMhIeZVfWDfzpmIg1jYSM+xw6iPTiwXO4jQLzgBpfzJFrc7rI3HlhJ0hqG2nGynHkYIsK4e2Bq9ocUZZZUcw+3mG9SItQgUjm+A1Enkr+lElDMwmb10HU7CU9Lha96EShix+HCX4zhRDOh7/xpGPiSCCHVzSg7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjIIeNJU; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-439950a45daso37460655e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740506385; x=1741111185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g4KkuzN3YdsW2noIqZOCpqoqa4GrMlri4rj4Q/z0qqo=;
        b=OjIIeNJUC27Lh4z+U1D6h6W3rYUI6Tv7vyXiz/Y9Yezgw9g6RIubmsrXa4yTv3nPbz
         F62SDntcUkQsQ2BHOtR8kfj9C9hYREppQmnt8kgMNfZ+Ip45VZXmTm+WoN3kExH21yqS
         HZbUTDaGcsu9zZxCvfrTcBI/AFd/y6pOFL60YxmXR3LHdRdDkkV4iHsT9XywJ8DCdicr
         37oVRfwBXt4UDhGMPIm8VfH5GZDt6LWr6QAWxlEX6WYPY64GM1ChyEWNLclBPPsK4/59
         KBc3jPkYotoxmC6XU+EdDQdYfxYjwTgRgHHq4SyieQVWOiG25cgRJeREICNPL4TTP6rq
         1Shg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740506385; x=1741111185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g4KkuzN3YdsW2noIqZOCpqoqa4GrMlri4rj4Q/z0qqo=;
        b=CEeBjkarScLFMuaEA+kafcGKJ0wW0nWtYhm4kb5YMRvinN7q+ScBpk5qBJG+RKZoY0
         wO35MaxRlrsmgiNr/9GvILyXNydnM2B4edQUcVq9xdwvdvugNbjGuazducVsBh8Gzu+I
         ZI380FXaeASNmy3Lfc0DflvURqIo4Euv/HwE4VDSS2xMT2DHUfVRvvwQOO+HUoDoUicd
         AaAH80tkxMef53V1T0ce/FD4s1USbIEPbwFcMWSEIwqhRy+QLQiLEMqEDObEtUX96AjY
         qlx4CihHv1VF5xnRz6rO5gluhW2GQ/nRvFJ1mmDOnWo49ErNBNGALsCm2bsS8GQDyGim
         Z9vA==
X-Forwarded-Encrypted: i=1; AJvYcCUJbOjqxhNl51uUspR6ck8h0vByAaufoEzkvkNlDC3XRoftjR2QC/puZGBh3d+ASNeRxS2DXvGzxI0doI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGrXAvVRFjYTdO8Zfu0tVDrdDLz6fQ5GpHXr0Oj2WGxR9qJ3M6
	obxScgfA6Ti0qigMX2gdImi9putHa0b9aYgiVN2hFwtbc8alfR1L
X-Gm-Gg: ASbGncumVDvnGWNtnnEuCUFmxGESXzgf4KabbW7YB3yzFFRTv6G8BIEUjcfYz6IJ5eg
	qmc1j1x7VnnLUIJOr+OYK/R6E8z8AaATQw3kLCy6BR/aQIrsbW8KJfwfghrfgMzcodpfudPbyAZ
	j7ztmXgXKA50nQiT9yE65zXXuY2SG9PYVJOP6Ap82w2PiZ7l0BBtQ0cSuO7svrYesMeQQ/nLkbS
	N8qR1n4FyYWfq8zFIUOqOJSBs596KpfoqZVGfW1h0jH/EhbVtseOF6qJYxeD7quykUxNzht8pKI
	QQoo70FKdx6xQvdtO5Eognu3plNq
X-Google-Smtp-Source: AGHT+IHo42lY7FnvR0p1Ete6FL/ExPhlesqNSGcsVd2G9FTBSK+yI0MIu82ukvvcb1oHod4TNQdN6A==
X-Received: by 2002:a05:600c:198e:b0:439:9e53:49d8 with SMTP id 5b1f17b1804b1-43ab0f979cdmr45977615e9.30.1740506384463;
        Tue, 25 Feb 2025 09:59:44 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02f3e15sm149063655e9.22.2025.02.25.09.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 09:59:43 -0800 (PST)
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
Subject: [PATCH v2 03/16] drm/vkms: Allow to configure multiple planes via configfs
Date: Tue, 25 Feb 2025 18:59:23 +0100
Message-ID: <20250225175936.7223-4-jose.exposito89@gmail.com>
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

Create a default subgroup at /config/vkms/planes to allow to create as
many planes as required.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst           | 16 ++++-
 drivers/gpu/drm/vkms/vkms_configfs.c | 87 ++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 423bdf86b5b1..bf23d0da33fe 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -71,6 +71,19 @@ By default, the instance is disabled::
   cat /config/vkms/my-vkms/enabled
   0
 
+And directories are created for each configurable item of the display pipeline::
+
+  tree /config/vkms/my-vkms
+  ├── enabled
+  └── planes
+
+To add items to the display pipeline, create one or more directories under the
+available paths.
+
+Start by creating one or more planes::
+
+  sudo mkdir /config/vkms/my-vkms/planes/plane0
+
 Once you are done configuring the VKMS instance, enable it::
 
   echo "1" | sudo tee /config/vkms/my-vkms/enabled
@@ -79,8 +92,9 @@ Finally, you can remove the VKMS instance disabling it::
 
   echo "0" | sudo tee /config/vkms/my-vkms/enabled
 
-And removing the top level directory::
+And removing the top level directory and its subdirectories::
 
+  sudo rmdir /config/vkms/my-vkms/planes/*
   sudo rmdir /config/vkms/my-vkms
 
 Testing With IGT
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index 92512d52ddae..4f9d3341e6c0 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -16,6 +16,7 @@ static bool is_configfs_registered;
  *
  * @group: Top level configuration group that represents a VKMS device.
  * Initialized when a new directory is created under "/config/vkms/"
+ * @planes_group: Default subgroup of @group at "/config/vkms/planes"
  * @lock: Lock used to project concurrent access to the configuration attributes
  * @config: Protected by @lock. Configuration of the VKMS device
  * @enabled: Protected by @lock. The device is created or destroyed when this
@@ -23,16 +24,98 @@ static bool is_configfs_registered;
  */
 struct vkms_configfs_device {
 	struct config_group group;
+	struct config_group planes_group;
 
 	struct mutex lock;
 	struct vkms_config *config;
 	bool enabled;
 };
 
+/**
+ * struct vkms_configfs_plane - Configfs representation of a plane
+ *
+ * @group: Top level configuration group that represents a plane.
+ * Initialized when a new directory is created under "/config/vkms/planes"
+ * @dev: The vkms_configfs_device this plane belongs to
+ * @config: Configuration of the VKMS plane
+ */
+struct vkms_configfs_plane {
+	struct config_group group;
+	struct vkms_configfs_device *dev;
+	struct vkms_config_plane *config;
+};
+
 #define device_item_to_vkms_configfs_device(item) \
 	container_of(to_config_group((item)), struct vkms_configfs_device, \
 		     group)
 
+#define child_group_to_vkms_configfs_device(group) \
+	device_item_to_vkms_configfs_device((&(group)->cg_item)->ci_parent)
+
+#define plane_item_to_vkms_configfs_plane(item) \
+	container_of(to_config_group((item)), struct vkms_configfs_plane, group)
+
+static void plane_release(struct config_item *item)
+{
+	struct vkms_configfs_plane *plane;
+	struct mutex *lock;
+
+	plane = plane_item_to_vkms_configfs_plane(item);
+	lock = &plane->dev->lock;
+
+	guard(mutex)(lock);
+	vkms_config_destroy_plane(plane->config);
+	kfree(plane);
+}
+
+static struct configfs_item_operations plane_item_operations = {
+	.release	= &plane_release,
+};
+
+static const struct config_item_type plane_item_type = {
+	.ct_item_ops	= &plane_item_operations,
+	.ct_owner	= THIS_MODULE,
+};
+
+static struct config_group *make_plane_group(struct config_group *group,
+					     const char *name)
+{
+	struct vkms_configfs_device *dev;
+	struct vkms_configfs_plane *plane;
+
+	dev = child_group_to_vkms_configfs_device(group);
+
+	guard(mutex)(&dev->lock);
+
+	if (dev->enabled)
+		return ERR_PTR(-EBUSY);
+
+	plane = kzalloc(sizeof(*plane), GFP_KERNEL);
+	if (!plane)
+		return ERR_PTR(-ENOMEM);
+
+	plane->dev = dev;
+
+	plane->config = vkms_config_create_plane(dev->config);
+	if (IS_ERR(plane->config)) {
+		kfree(plane);
+		return ERR_CAST(plane->config);
+	}
+
+	config_group_init_type_name(&plane->group, name, &plane_item_type);
+
+	return &plane->group;
+}
+
+static struct configfs_group_operations planes_group_operations = {
+	.make_group	= &make_plane_group,
+};
+
+static const struct config_item_type plane_group_type = {
+	.ct_group_ops	= &planes_group_operations,
+	.ct_owner	= THIS_MODULE,
+};
+
 static ssize_t device_enabled_show(struct config_item *item, char *page)
 {
 	struct vkms_configfs_device *dev;
@@ -125,6 +208,10 @@ static struct config_group *make_device_group(struct config_group *group,
 	config_group_init_type_name(&dev->group, name, &device_item_type);
 	mutex_init(&dev->lock);
 
+	config_group_init_type_name(&dev->planes_group, "planes",
+				    &plane_group_type);
+	configfs_add_default_group(&dev->planes_group, &dev->group);
+
 	return &dev->group;
 }
 
-- 
2.48.1


