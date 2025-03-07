Return-Path: <linux-kernel+bounces-551538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6B9A56DD7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EB361899C79
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FBA23E34E;
	Fri,  7 Mar 2025 16:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5hBehDD"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC66723CEF9
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 16:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741365244; cv=none; b=KUvBx7VyHWOYxdPuqJYesbefk/BbiYM4EUmE4WFhT+80VwEw7jmvM9S5TWtii9kCa5dTvlTERE3T/4iR7D8NfXIeXyd7K+6TlFReAA23O0VoMm5wsmQao2oDNWKf637kSstx1yCt7FswVDHYtOhz9PBumTdIC178KcdLbE+dQ9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741365244; c=relaxed/simple;
	bh=UKfStJgBfY7Lv0PW30uJF9waC9ZrSy8EL0S7fgmmY5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SvfuGi3eRQO05FeSKUdLe6HQIsFggV1wfXjp7aGFjzoXXCmGLdoM/WmXkN+IQf+cmi1thyLoagGAbcMy9UVE2EV7Vp3kSdlpvGHLCB1pAVMkAcZzmY8rmPiw7baWD+2sAS8no7faPZ8h6IPq6wzhEiMNRSsjKG1K0BX1lVKdNMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5hBehDD; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3910e101d0fso1169079f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 08:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741365241; x=1741970041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OehO6Qhr6WGHbOewVFsNr8BMqlTR3xPb+7+1msX4IOo=;
        b=Q5hBehDDm3v7JL46kEzeSSaB5jxb1MNvJZhUxsdrzudZGgOAiJEk9bCyDzF2HAkiPO
         82Ivd6u3tKzoIds2OmPZuQnCL/GXytbrAJBULk9y7nburJLUfr2rpgfOmTWBSAZvyHL0
         M9NgCvIXZ2wAkP+U4ciHN2V3moXkr/Y41iDyVO94kSePtsnlu6d+SPJWg2vIZAYn3NKb
         B419geqwaS5KoivgBlnBO+0jpK67KH5S6g5hoAnztOPZzJCFej8MShqxdXgeXdpvPKgk
         O+GYFJ8sGE9HpGoYfFfQ/wXyKK0L6IuotCjGjtiURMD+pYB+NP6kQzs5H/RVZXf0Qke2
         PVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741365241; x=1741970041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OehO6Qhr6WGHbOewVFsNr8BMqlTR3xPb+7+1msX4IOo=;
        b=F6ljmrFJJAowvqGNucfqZN/6uBHYYb/5e6ekWmYVCOPcy81/sqhrQCFbtn+HV/gz8r
         4gYiKMmsTrdi5GWG/BBP0lhFbJ03uunHZlAP5Y+XYCJooP2fQ2L28d0+7LKC1Qv6Od/U
         0eJIMmcF3C5RKEOwIuwEc2MLq18klDmKZIpooH2tZkzzLEGItVFMBsNEg+YuQoS2RdCk
         wyZBII2aesjMpl0EmUDJ9GvXqGsnfvkbGFwQgsqQ07l34hOpg15Z47yHEVUMTEH098UE
         Tq0Jr7KdC/8C+dUE/7e2QtJSxP7kT6r2OkUEBtn88lgTPSeptYlpqw+60rc18g/wfHsR
         N9/A==
X-Forwarded-Encrypted: i=1; AJvYcCVYtrOsczyZdJSa0hWckaYg7NLOve/Ud88JwUDNYFSRm8GL6Te32t8/EbgYv1gB3/gTSs9Ogl3+QSq+y4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu8Upz3/g96vDJMXLMCtl6yJKq8E4CVxZTLN3pqbKe9m6UIvDk
	jCORb0EDbxyMpXOFx9RY6JX7lFlxdb+qqWnPj1oDv8WUIspwEtfo
X-Gm-Gg: ASbGncvNg6QQT2PagcyNZaDjFulUP5dWod4i5bttSoGwNsNNTLyLH2+kk56xAhTTH/U
	tAyII0DLVjfQ/xcs/4/jd9pk1ntJYjW7xbBK0atj5A4+wI8xWMXyV6HxH05kM0oQ6jouX/zSto7
	5y7DeErwLoV5HYdfSo0cV3t+y3beQ/+hW3HY2679RGgv87fvDRbHka6jfhCh9aGHKBaiBkBJ/rg
	e/D9VzTCx5hy966O3Yr/vpJrl9fN4l3K2iBB6GsxTTqVU1sir1P1kgn88OgaIZIcjgNE0bQCqbP
	3KQ0I6JxmUsh7cAWlOF3dwh99RY0e2d+048l9wCl4CycvB8=
X-Google-Smtp-Source: AGHT+IHsYe0vbQupMHSrJP5IQwdIqh/U3A41zvaZCt9hGpwRD8kj241TXz1aUDolhkgB/jb73AxAIQ==
X-Received: by 2002:a05:6000:402b:b0:38d:e401:fd61 with SMTP id ffacd0b85a97d-39132db746amr2524803f8f.49.1741365240541;
        Fri, 07 Mar 2025 08:34:00 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c019557sm6031436f8f.50.2025.03.07.08.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 08:33:59 -0800 (PST)
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
Subject: [PATCH v3 02/16] drm/vkms: Add and remove VKMS instances via configfs
Date: Fri,  7 Mar 2025 17:33:39 +0100
Message-ID: <20250307163353.5896-3-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307163353.5896-1-jose.exposito89@gmail.com>
References: <20250307163353.5896-1-jose.exposito89@gmail.com>
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
 drivers/gpu/drm/vkms/vkms_configfs.c | 172 +++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_configfs.h |   8 ++
 drivers/gpu/drm/vkms/vkms_drv.c      |   7 ++
 6 files changed, 222 insertions(+), 1 deletion(-)
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
index 000000000000..ee186952971b
--- /dev/null
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -0,0 +1,172 @@
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
+	bool enabled;
+
+	dev = device_item_to_vkms_configfs_device(item);
+
+	scoped_guard(mutex, &dev->lock)
+		enabled = dev->enabled;
+
+	return sprintf(page, "%d\n", enabled);
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
+	scoped_guard(mutex, &dev->lock) {
+		if (!dev->enabled && enabled) {
+			if (!vkms_config_is_valid(dev->config))
+				return -EINVAL;
+
+			ret = vkms_create(dev->config);
+			if (ret)
+				return ret;
+		} else if (dev->enabled && !enabled) {
+			vkms_destroy(dev->config);
+		}
+
+		dev->enabled = enabled;
+	}
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


