Return-Path: <linux-kernel+bounces-532146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 640BCA4497A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 598F13BB61F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE6419DF7D;
	Tue, 25 Feb 2025 17:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUGYnstr"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0E219D892
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506386; cv=none; b=F4Fzv9eQeXrcnJ+yvEIiHqSMw5ZHlI+T1MOZqJRsueGMP8xCmrm7WSAAvnN+88JMWCuPU4hEhpVdbyVCrozBB7MW89B5b3C38mi2wuutDokfgRbHlom6ehhBQReC9zul32DRyIU5/4hv1fFXuj6Z8NrXH9L3vNndU9nmNu8cov8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506386; c=relaxed/simple;
	bh=8EDThebWThe1S8U1MYjtnfDUocCJGT116mhpuWBszAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XbdFnklsIkKCWXiB+sev8BfXiOdYC9MfyrUT9QlnZscDDiGsrEhYgUQ7dZ9EFT/NOtYjHOZpxHh3NpWb4qTcQu52P2frVy7wtPrnNk5v8dKTz+zAInTYN4xttWOqO0xhJNuhHlknFgdfE1fQytGUYDUOKF1zC1IBEXyiIIN4kXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUGYnstr; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so3422679f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740506383; x=1741111183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HwUFYj9lX6AbtJacLuV777Jdbit64p1AUoia1eEq0TE=;
        b=JUGYnstrcPeHbSoLSbIgDvoORSlCfTV82ZP+tQfkdsortuEsfaqSmq89HzSuauCbof
         XNYvejsAPUfTvwhlA/ZJiKoBpfx4rvPCItDKr+32HIfyKpoYRUpYcgsnF1S1fcfOBR53
         D++2B/0ZvLw88yjGhIubJgass6FidrPJUWXkVOZz3kUokwpWmdfpCxHZKE878sWzBgdi
         mKawdqjrLNjlottaUk2n+n75Mtk5lxgPJUY0b2UkyzLAWhGQ9fQMLPg4YWqQ2iZSzjkV
         YluzZ85NPQ/dB9NS6HE7AsbJDOljci6n2oaie7OV9dZAzTVu2rmpdoo/6dPFKdtpqk/8
         R3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740506383; x=1741111183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HwUFYj9lX6AbtJacLuV777Jdbit64p1AUoia1eEq0TE=;
        b=DY+IYn4xFmtzHcObMxgt4/XeaQKP/Q/dXYk7LAtx6O9IhTFd93mdWvKASdD2yqjwto
         tMcN/vnChktqHPa4BvLNW+DCzN6KT0GD9EMASBPnMlUjkq9a+iYfOz6YqCfY6ZrHgr46
         JgfpkUin4+BwDOsVUZfa9F8oSnu3vZCFqzcdDuEZ4tx0SnulzemBX8bjfTHV5fJAfO6C
         KARWwzNvLrumQxTsAS9npd8lIE2sruz2BlpLyricHegSKOV6F1B15MbZd0dX67YzNubt
         lE69ZTM2O+/yIyJ29bEkGlxGld2prxBI8Cdwau64tMXDBGhT/VkfwNgVg109DCLRBQay
         ldqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXW8C9207kTAADsnxL7Wm7hjbeG6a+sgoPcKPH4dC5EepAIwiSam9zVu7sozpROi48/yxh3JbMKOyZgZiA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy2Y2Qqg2VPqCeWsThGvyJEIzuC1YXrIpHKMh1S9XXUh/1A1rp
	pXi9jtYULrCxSANGohMv9v/cO+waxSGIzMHMqpkK5G7iRgTDEMW0
X-Gm-Gg: ASbGncs4xIkswuCGV2ax30cSg+jb+8+MAnmd5di4k4Ga90l0W3o642QM4u49+2dsFsT
	mik/LTVQFkK9JcwiSexKcaTouUd/sht/TaPAIMz0IO4hZoJZsq3FMOnX6iiMmTN7uBrF0xqz/81
	2GMf01EDzjmJA4ZBsrw3ie8atnL5sbG8Yi+Icm2VvflJzmBCr3NqtpLWdSTwaXy04ISidPTeNgq
	SeuAIQ7nBKmEuQZQhiAYUdno4BFZDlSmAYNmhiEUDiPGy12PiYHsmBUpNNQD/bR1K7lEThqzoaY
	+ZKuxdSFEf9j/ywCCSDiqm07Tznw
X-Google-Smtp-Source: AGHT+IGmB9ohZkLJUkHLZZRAc91PWdg4gVD+hN0GNDoxwSFhf/3qEImdOZeZRijhFSChhV9ImkzeQg==
X-Received: by 2002:adf:e912:0:b0:38f:24f9:8bac with SMTP id ffacd0b85a97d-390cc60c1f9mr3314768f8f.23.1740506382914;
        Tue, 25 Feb 2025 09:59:42 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02f3e15sm149063655e9.22.2025.02.25.09.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 09:59:42 -0800 (PST)
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
Subject: [PATCH v2 02/16] drm/vkms: Add and remove VKMS instances via configfs
Date: Tue, 25 Feb 2025 18:59:22 +0100
Message-ID: <20250225175936.7223-3-jose.exposito89@gmail.com>
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

Allow to create, enable, disable and destroy VKMS instances using
configfs.

For the moment, it is not possible to add pipeline items, so trying to
enable the device will fail printing an informative error to the log.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst           |  32 +++++
 drivers/gpu/drm/vkms/Kconfig         |   1 +
 drivers/gpu/drm/vkms/Makefile        |   3 +-
 drivers/gpu/drm/vkms/vkms_configfs.c | 169 +++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_configfs.h |   8 ++
 drivers/gpu/drm/vkms/vkms_drv.c      |   7 ++
 6 files changed, 219 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/vkms/vkms_configfs.c
 create mode 100644 drivers/gpu/drm/vkms/vkms_configfs.h

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index ba04ac7c2167..423bdf86b5b1 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -51,6 +51,38 @@ To disable the driver, use ::
 
   sudo modprobe -r vkms
 
+Configuring With Configfs
+=========================
+
+It is possible to create and configure multiple VKMS instances via configfs.
+
+Start by mounting configfs and loading VKMS::
+
+  sudo mount -t configfs none /config
+  sudo modprobe vkms
+
+Once VKMS is loaded, ``/config/vkms`` is created automatically. Each directory
+under ``/config/vkms`` represents a VKMS instance, create a new one::
+
+  sudo mkdir /config/vkms/my-vkms
+
+By default, the instance is disabled::
+
+  cat /config/vkms/my-vkms/enabled
+  0
+
+Once you are done configuring the VKMS instance, enable it::
+
+  echo "1" | sudo tee /config/vkms/my-vkms/enabled
+
+Finally, you can remove the VKMS instance disabling it::
+
+  echo "0" | sudo tee /config/vkms/my-vkms/enabled
+
+And removing the top level directory::
+
+  sudo rmdir /config/vkms/my-vkms
+
 Testing With IGT
 ================
 
diff --git a/drivers/gpu/drm/vkms/Kconfig b/drivers/gpu/drm/vkms/Kconfig
index 3c02f928ffe6..3977bbb99f7d 100644
--- a/drivers/gpu/drm/vkms/Kconfig
+++ b/drivers/gpu/drm/vkms/Kconfig
@@ -7,6 +7,7 @@ config DRM_VKMS
 	select DRM_KMS_HELPER
 	select DRM_GEM_SHMEM_HELPER
 	select CRC32
+	select CONFIGFS_FS
 	default n
 	help
 	  Virtual Kernel Mode-Setting (VKMS) is used for testing or for
diff --git a/drivers/gpu/drm/vkms/Makefile b/drivers/gpu/drm/vkms/Makefile
index d657865e573f..939991fc8233 100644
--- a/drivers/gpu/drm/vkms/Makefile
+++ b/drivers/gpu/drm/vkms/Makefile
@@ -8,7 +8,8 @@ vkms-y := \
 	vkms_composer.o \
 	vkms_writeback.o \
 	vkms_connector.o \
-	vkms_config.o
+	vkms_config.o \
+	vkms_configfs.o
 
 obj-$(CONFIG_DRM_VKMS) += vkms.o
 obj-$(CONFIG_DRM_VKMS_KUNIT_TEST) += tests/
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
new file mode 100644
index 000000000000..92512d52ddae
--- /dev/null
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include <linux/cleanup.h>
+#include <linux/configfs.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+
+#include "vkms_drv.h"
+#include "vkms_config.h"
+#include "vkms_configfs.h"
+
+/* To avoid registering configfs more than once or unregistering on error */
+static bool is_configfs_registered;
+
+/**
+ * struct vkms_configfs_device - Configfs representation of a VKMS device
+ *
+ * @group: Top level configuration group that represents a VKMS device.
+ * Initialized when a new directory is created under "/config/vkms/"
+ * @lock: Lock used to project concurrent access to the configuration attributes
+ * @config: Protected by @lock. Configuration of the VKMS device
+ * @enabled: Protected by @lock. The device is created or destroyed when this
+ * option changes
+ */
+struct vkms_configfs_device {
+	struct config_group group;
+
+	struct mutex lock;
+	struct vkms_config *config;
+	bool enabled;
+};
+
+#define device_item_to_vkms_configfs_device(item) \
+	container_of(to_config_group((item)), struct vkms_configfs_device, \
+		     group)
+
+static ssize_t device_enabled_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_device *dev;
+
+	dev = device_item_to_vkms_configfs_device(item);
+
+	guard(mutex)(&dev->lock);
+	return sprintf(page, "%d\n", dev->enabled);
+}
+
+static ssize_t device_enabled_store(struct config_item *item, const char *page,
+				    size_t count)
+{
+	struct vkms_configfs_device *dev;
+	bool enabled;
+	int ret = 0;
+
+	dev = device_item_to_vkms_configfs_device(item);
+
+	if (kstrtobool(page, &enabled))
+		return -EINVAL;
+
+	guard(mutex)(&dev->lock);
+
+	if (!dev->enabled && enabled) {
+		if (!vkms_config_is_valid(dev->config))
+			return -EINVAL;
+
+		ret = vkms_create(dev->config);
+		if (ret)
+			return ret;
+	} else if (dev->enabled && !enabled) {
+		vkms_destroy(dev->config);
+	}
+
+	dev->enabled = enabled;
+
+	return (ssize_t)count;
+}
+
+CONFIGFS_ATTR(device_, enabled);
+
+static struct configfs_attribute *device_item_attrs[] = {
+	&device_attr_enabled,
+	NULL,
+};
+
+static void device_release(struct config_item *item)
+{
+	struct vkms_configfs_device *dev;
+
+	dev = device_item_to_vkms_configfs_device(item);
+
+	if (dev->enabled)
+		vkms_destroy(dev->config);
+
+	mutex_destroy(&dev->lock);
+	vkms_config_destroy(dev->config);
+	kfree(dev);
+}
+
+static struct configfs_item_operations device_item_operations = {
+	.release	= &device_release,
+};
+
+static const struct config_item_type device_item_type = {
+	.ct_attrs	= device_item_attrs,
+	.ct_item_ops	= &device_item_operations,
+	.ct_owner	= THIS_MODULE,
+};
+
+static struct config_group *make_device_group(struct config_group *group,
+					      const char *name)
+{
+	struct vkms_configfs_device *dev;
+
+	if (strcmp(name, DEFAULT_DEVICE_NAME) == 0)
+		return ERR_PTR(-EINVAL);
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return ERR_PTR(-ENOMEM);
+
+	dev->config = vkms_config_create(name);
+	if (IS_ERR(dev->config)) {
+		kfree(dev);
+		return ERR_CAST(dev->config);
+	}
+
+	config_group_init_type_name(&dev->group, name, &device_item_type);
+	mutex_init(&dev->lock);
+
+	return &dev->group;
+}
+
+static struct configfs_group_operations device_group_ops = {
+	.make_group = &make_device_group,
+};
+
+static const struct config_item_type device_group_type = {
+	.ct_group_ops	= &device_group_ops,
+	.ct_owner	= THIS_MODULE,
+};
+
+static struct configfs_subsystem vkms_subsys = {
+	.su_group = {
+		.cg_item = {
+			.ci_name = "vkms",
+			.ci_type = &device_group_type,
+		},
+	},
+	.su_mutex = __MUTEX_INITIALIZER(vkms_subsys.su_mutex),
+};
+
+int vkms_configfs_register(void)
+{
+	int ret;
+
+	if (is_configfs_registered)
+		return 0;
+
+	config_group_init(&vkms_subsys.su_group);
+	ret = configfs_register_subsystem(&vkms_subsys);
+
+	is_configfs_registered = ret == 0;
+
+	return ret;
+}
+
+void vkms_configfs_unregister(void)
+{
+	if (is_configfs_registered)
+		configfs_unregister_subsystem(&vkms_subsys);
+}
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.h b/drivers/gpu/drm/vkms/vkms_configfs.h
new file mode 100644
index 000000000000..e9020b0043db
--- /dev/null
+++ b/drivers/gpu/drm/vkms/vkms_configfs.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+#ifndef _VKMS_CONFIGFS_H_
+#define _VKMS_CONFIGFS_H_
+
+int vkms_configfs_register(void);
+void vkms_configfs_unregister(void);
+
+#endif /* _VKMS_CONFIGFS_H_ */
diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 23817c7b997e..5bcfbcb6c0c5 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -28,6 +28,7 @@
 #include <drm/drm_vblank.h>
 
 #include "vkms_config.h"
+#include "vkms_configfs.h"
 #include "vkms_drv.h"
 
 #define DRIVER_NAME	"vkms"
@@ -214,6 +215,10 @@ static int __init vkms_init(void)
 	int ret;
 	struct vkms_config *config;
 
+	ret = vkms_configfs_register();
+	if (ret)
+		return ret;
+
 	config = vkms_config_default_create(enable_cursor, enable_writeback, enable_overlay);
 	if (IS_ERR(config))
 		return PTR_ERR(config);
@@ -250,6 +255,8 @@ void vkms_destroy(struct vkms_config *config)
 
 static void __exit vkms_exit(void)
 {
+	vkms_configfs_unregister();
+
 	if (!default_config)
 		return;
 
-- 
2.48.1


