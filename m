Return-Path: <linux-kernel+bounces-418594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4DE9D635E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BBC4B24705
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49A91E0087;
	Fri, 22 Nov 2024 17:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Zv0BUU4d"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693391DE88B
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 17:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732297148; cv=none; b=gEeTBom0g04iZ+NcygJixAAcgkCbVvUuoBbVWFwufCmANCSnWv4f1dcBGISbAynxFen6NXFTK9rM+KBWU4VznVJnsO5Y4j77MwqfOkzjWjpUR1/FxRHcYd9/oGoO7+zi1LnbUV9HMPrpk3Y3oWAXk1xqQo2Q35+QHtjBy1bnIVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732297148; c=relaxed/simple;
	bh=TVSRHX+oI96zpI0b9tInVblON27/3sZGP4z6jTdwubU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KYTb/dWjnKdR8VCf50RcFceBbIH0rffL/UKMLob18wN72kKf/CExKeO4bqNb8u8xZyTMvXQzxTv9BOZiZJSoYCRhk01Vb0GDIbPB71zcj4ajagQ0ONZuFHbFYH7nco6iAPFuFxC12jKn5PiVQWa8XGcM9RC16M39sQuM9P5Iebg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Zv0BUU4d; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 76AF6C0003;
	Fri, 22 Nov 2024 17:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732297139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0C9YB1veERoN1gqcAKiUSPViHEGCVo6K+wlUcDmmo2k=;
	b=Zv0BUU4doGx9xPSRM62Q01p4dZfoOeqWk4OL2qtEm+si61zlht9tfZzcXTFVnM62M/MlV4
	gqDYalvL3dzqkKUyD0JnLZcztanPSl/MBV+6nLkVOtajhWtIV61aLezzeoFvvu8Aq8vGZe
	3ADHCnNn3Uk7qLjRxEzcZEJM8kQ9O7PZyxdHqlzXH6vEec/qUBGP78bbAkq77PnMHvBmGZ
	R7lP+sWbqZ5UJJc2TyqfsgiebMObDCrhIkKsRdNEyg7C65AKRHXm8emxbnjDq9Yv9cYUZJ
	aZc5LC3NfQ2zq3ohBWlLcG92Eo6Xg569LGOPzlhrqBDcd+RQoHLWVGyz7Zz81w==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 22 Nov 2024 18:38:29 +0100
Subject: [PATCH RFC v2 03/16] drm/vkms: Introduce ConfigFS interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241122-google-config-fs-v2-3-4b7e6f183320@bootlin.com>
References: <20241122-google-config-fs-v2-0-4b7e6f183320@bootlin.com>
In-Reply-To: <20241122-google-config-fs-v2-0-4b7e6f183320@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Simona Vetter <simona.vetter@ffwll.ch>
Cc: jose.exposito89@gmail.com, dri-devel@lists.freedesktop.org, 
 arthurgrillo@riseup.net, linux-kernel@vger.kernel.org, 
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
 thomas.petazzoni@bootlin.com, seanpaul@google.com, nicolejadeyee@google.com, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8270;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=TVSRHX+oI96zpI0b9tInVblON27/3sZGP4z6jTdwubU=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnQMGpRy5p4p1cpaQTueHayo7ir3p76af9N7PKt
 yT+xwoR9vCJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZ0DBqQAKCRAgrS7GWxAs
 4mIdD/9BT4PZaJ4VqeZPyeIFvyzeUYT8SvBDaqSDtc9I+iVnsW3tkRJDpeOUwPWXKXJhuXMy+X7
 DnGzwcEoEwE3cRkExJC8N08uv9AbdHkUHi9yuUi7AtIHzVoe5v8YXU0YnkFb6/ccyPZfoav9bGt
 spP050RQYbicevndKX3SfGb2uwGHngYYF0I/H4fYQQDy+5LZfGFAXo2wbCGwBacK/DinpNmhM4G
 bLgyz+oe45BBiDDrmIjeZcO8OMwIIktDS5fl4Kj1rCBHuOoKw/MN/r/q6gGHhULxjmhKcDwyKev
 De09rJ1Bx3KPzYsRaT4EffgcUUAm5w6PX5zh5clO4/LvSmS7xhQsYWOtBhQudr3YQLV1WXQpHWO
 auQNunVySDwdJbWEVewbYKULIy5jSslCHnL8aFOL8Rlx4ZjcWoagVGq+rpaoPpjhzgXn8V3o6nS
 PbUYCCBe+ETU+ksb8ZTBQQEfUsslgZJqfyZsDNpeSodAw/Hrsy8Lzo1JgC0gb8E3CGcgwheNCtX
 fnHlgGBJx6IOHjE1Oub1uUPBfUnH1vAAvna42rBJeinHwCEtR6ej67ghNW+8b3BgvrlulEcVsY+
 HuxctkVAtr5y0davFVRY/HWukx+cAJ6ZMuOwqEUSRy9JfEln91NEriN4NJA6pJZxLO4lNl2fnu3
 gwnksaA0aCFNN+w==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

VKMS is manly used to test userspace program and its behavior. The current
implementation is not very configurable as you can only have one device,
with few specific planes.

This is the introduction of a basic interface to dynamically create new
devices.

The new interface is:
/config/vkms
  DEVICE_1
  ┗━ enable
  DEVICE_2
  ┗━ enable

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/Kconfig         |   1 +
 drivers/gpu/drm/vkms/Makefile        |   1 +
 drivers/gpu/drm/vkms/vkms_configfs.c | 144 +++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_configfs.h |  35 +++++++++
 drivers/gpu/drm/vkms/vkms_drv.c      |  15 +++-
 5 files changed, 194 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/Kconfig b/drivers/gpu/drm/vkms/Kconfig
index d4665e913de7702fbd5c0f047876dad9715c690a..71fe9124bf18dd5b17b0989077e1cf1f8f1ee963 100644
--- a/drivers/gpu/drm/vkms/Kconfig
+++ b/drivers/gpu/drm/vkms/Kconfig
@@ -6,6 +6,7 @@ config DRM_VKMS
 	select DRM_CLIENT_SELECTION
 	select DRM_KMS_HELPER
 	select DRM_GEM_SHMEM_HELPER
+    select CONFIGFS_FS
 	select CRC32
 	default n
 	help
diff --git a/drivers/gpu/drm/vkms/Makefile b/drivers/gpu/drm/vkms/Makefile
index 2b6db5870b977f6e5013982af89a48aec6c11983..9ecf6bc4779f81cac2677a3595c0bf4ebd1448bd 100644
--- a/drivers/gpu/drm/vkms/Makefile
+++ b/drivers/gpu/drm/vkms/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 vkms-y := \
+	vkms_configfs.o \
 	vkms_drv.o \
 	vkms_plane.o \
 	vkms_output.o \
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
new file mode 100644
index 0000000000000000000000000000000000000000..6535672f008401cf1ae008ff2ef74452b2575eab
--- /dev/null
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/configfs.h>
+#include <linux/mutex.h>
+#include <drm/drm_print.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include "vkms_configfs.h"
+#include "vkms_drv.h"
+#include "vkms_config.h"
+
+static ssize_t device_enable_show(struct config_item *item, char *page)
+{
+	return sprintf(page, "%d\n",
+		       config_item_to_vkms_configfs_device(item)->enabled);
+}
+
+static ssize_t device_enable_store(struct config_item *item,
+				   const char *page, size_t count)
+{
+	struct vkms_configfs_device *vkms_configfs_device =
+		config_item_to_vkms_configfs_device(item);
+
+	bool value;
+	int ret;
+
+	ret = kstrtobool(page, &value);
+	if (ret)
+		return -EINVAL;
+
+	mutex_lock(&vkms_configfs_device->lock);
+
+	vkms_configfs_device->enabled = value;
+
+	if (value)
+		vkms_create(vkms_configfs_device->vkms_config);
+	else
+		vkms_destroy(vkms_configfs_device->vkms_config);
+
+	mutex_unlock(&vkms_configfs_device->lock);
+
+	return (ssize_t)count;
+}
+
+CONFIGFS_ATTR(device_, enable);
+
+static struct configfs_attribute *device_attrs[] = {
+	&device_attr_enable,
+	NULL,
+};
+
+static void device_release(struct config_item *item)
+{
+	struct vkms_configfs_device *vkms_configfs_device =
+					    config_item_to_vkms_configfs_device(item);
+
+	mutex_destroy(&vkms_configfs_device->lock);
+	vkms_config_destroy(vkms_configfs_device->vkms_config);
+
+	kfree(vkms_configfs_device);
+}
+
+static struct configfs_item_operations device_item_operations = {
+	.release	= &device_release,
+};
+
+static const struct config_item_type device_item_type = {
+	.ct_attrs	= device_attrs,
+	.ct_item_ops	= &device_item_operations,
+	.ct_owner	= THIS_MODULE,
+};
+
+/* Top directory management. Each new directory here is a new device */
+static struct config_group *root_make_group(struct config_group *group,
+					    const char *name)
+{
+	struct vkms_config_plane *plane;
+	struct vkms_config_crtc *crtc;
+	struct vkms_config_encoder *encoder;
+	struct vkms_configfs_device *configfs = kzalloc(sizeof(*configfs), GFP_KERNEL);
+
+	if (!configfs)
+		return ERR_PTR(-ENOMEM);
+
+	mutex_init(&configfs->lock);
+
+	configfs->vkms_config = vkms_config_create();
+
+	if (!configfs->vkms_config) {
+		kfree(configfs);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	plane = vkms_config_create_plane(configfs->vkms_config);
+	crtc = vkms_config_create_crtc(configfs->vkms_config);
+	encoder = vkms_config_create_encoder(configfs->vkms_config);
+
+	if (!plane || !crtc || !encoder ||
+	    vkms_config_plane_attach_crtc(plane, crtc) ||
+	    vkms_config_encoder_attach_crtc(encoder, crtc)) {
+		vkms_config_destroy(configfs->vkms_config);
+		kfree(configfs);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	plane->type = DRM_PLANE_TYPE_PRIMARY;
+
+	config_group_init_type_name(&configfs->group, name,
+				    &device_item_type);
+
+	return &configfs->group;
+}
+
+static struct configfs_group_operations root_group_operations = {
+	.make_group	= &root_make_group,
+};
+
+static struct config_item_type root_item_type = {
+	.ct_group_ops	= &root_group_operations,
+	.ct_owner	= THIS_MODULE,
+};
+
+static struct configfs_subsystem vkms_subsys = {
+	.su_group = {
+		.cg_item = {
+			.ci_name = "vkms",
+			.ci_type = &root_item_type,
+		},
+	},
+	.su_mutex = __MUTEX_INITIALIZER(vkms_subsys.su_mutex),
+};
+
+int vkms_init_configfs(void)
+{
+	config_group_init(&vkms_subsys.su_group);
+
+	return configfs_register_subsystem(&vkms_subsys);
+}
+
+void vkms_unregister_configfs(void)
+{
+	configfs_unregister_subsystem(&vkms_subsys);
+}
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.h b/drivers/gpu/drm/vkms/vkms_configfs.h
new file mode 100644
index 0000000000000000000000000000000000000000..3de89c9c552c6603396f38a98ad35263f04bce26
--- /dev/null
+++ b/drivers/gpu/drm/vkms/vkms_configfs.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#include <linux/configfs.h>
+#include <linux/mutex.h>
+
+#ifndef _VKMS_CONFIGFS_H
+#define _VKMS_CONFIGFS_H
+
+/**
+ * struct vkms_configfs_device - Internal object to manage all the configfs items related to one
+ * device
+ *
+ * @group: Main configfs group for a device
+ * @platform_device: If a device was created (@enabled = true), stores a pointer to it
+ * @lock: Mutex used to avoid conflicting edition of @vkms_config
+ * @enabled: Store if the device was created or not
+ * @vkms_config: Current vkms configuration
+ */
+struct vkms_configfs_device {
+	struct config_group group;
+
+	struct mutex lock;
+	bool enabled;
+
+	struct vkms_config *vkms_config;
+};
+
+#define config_item_to_vkms_configfs_device(item) \
+	container_of(to_config_group((item)), struct vkms_configfs_device, group)
+
+/* ConfigFS Support */
+int vkms_init_configfs(void);
+void vkms_unregister_configfs(void);
+
+#endif /* _VKMS_CONFIGFS_H */
diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 8ffbd5fc65350ba03f870726b669d189f62bad6f..cdf51df78802cd096b71cfc76678a9ebdd06df1a 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -29,6 +29,7 @@
 
 #include "vkms_drv.h"
 #include "vkms_config.h"
+#include "vkms_configfs.h"
 
 #include <drm/drm_print.h>
 #include <drm/drm_debugfs.h>
@@ -158,7 +159,7 @@ int vkms_create(struct vkms_config *config)
 	struct platform_device *pdev;
 	struct vkms_device *vkms_device;
 
-	pdev = platform_device_register_simple(DRIVER_NAME, -1, NULL, 0);
+	pdev = platform_device_register_simple(DRIVER_NAME, PLATFORM_DEVID_AUTO, NULL, 0);
 	if (IS_ERR(pdev))
 		return PTR_ERR(pdev);
 
@@ -219,9 +220,17 @@ static int __init vkms_init(void)
 	if (IS_ERR(default_config))
 		return PTR_ERR(default_config);
 
+	ret = vkms_init_configfs();
+	if (ret) {
+		DRM_ERROR("Unable to initialize configfs\n");
+		vkms_config_destroy(default_config);
+	}
+
 	ret = vkms_create(default_config);
-	if (ret)
+	if (ret) {
+		vkms_unregister_configfs();
 		vkms_config_destroy(default_config);
+	}
 
 	return ret;
 }
@@ -251,6 +260,8 @@ static void __exit vkms_exit(void)
 		vkms_destroy(default_config);
 
 	vkms_config_destroy(default_config);
+
+	vkms_unregister_configfs();
 }
 
 module_init(vkms_init);

-- 
2.47.0


