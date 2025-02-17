Return-Path: <linux-kernel+bounces-517316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BBAA37F46
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE4D61650C1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA7F217715;
	Mon, 17 Feb 2025 10:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgCSB/ke"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182CC217640
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786493; cv=none; b=hyt5mREMB9cYEPExT138EYVZP8o/2g8mZo/D12l1RQTpU9eoTrjZdSNaNHHLIAdjWF7Nur+qRn0wgRJVYhsTkYNUrCkV+u+Iq3dp5nGo78vVUcRriyXXtJ2QizfO9IECa8TA+4I9oX1M5rXn6fdUvZ24txTUGwZ/dh/aFAN6x0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786493; c=relaxed/simple;
	bh=lE2dcBc64Q45pDXeulBAcyc2a1SFMDFApIAknsuoPPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o0q5VCtdICRfEqLIaofYYnKZGL2CN1RuEFD9hluI40e3F9hggvrUFXrQP18sqYGY7rMaoPP5gUP3/imXFSE3zVN8b6Edd/3pW3FKnuIyzDnzJfp0NMMcLgdGDvDbOSJVcld/NnvUByh7WN4IKs8Mbr8ALAgcfnnCkXe9beeRNX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgCSB/ke; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38f31f7732dso1349987f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739786489; x=1740391289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmDfaEOjc70HjJgnj7sLGaZRyHuUKTvYVGnXm2VRbiY=;
        b=CgCSB/kebREW3YATw9drUaYKdhkkCqn1bmkUOn3WN//XtW7vDvFnNlz425ciqJ87Dz
         5iqrerdaUl8pixYvzK4PP8n2Md4rOghUEMvzVt8eDKPTe1UznwYvLRR7WZpX+/8k8R87
         lpuZkqyJRD8y5PsRKcTKowClNz33R5+GUNub2IbqN9w6J/YMHhWf6yRTJZubSYtqkf8i
         7NYecXvZqLhtxlMZ+6r1rBe8WjKcN3QfO6YaLNpR/4L0F4OwmZpcV3gTtyLZwfT/C1dN
         gQ7/VWtema2qrTUsm/RZIdXMMP3ezxZqk2bTraIpMnnY/7zvkFyK0EXeiURaKwOE+DeJ
         BKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739786489; x=1740391289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LmDfaEOjc70HjJgnj7sLGaZRyHuUKTvYVGnXm2VRbiY=;
        b=EV9L/EYHCsofwKLtmI6IgnTRX/iknAsCO3hmFxqRiHlSr3YfAJvWg1/dk6kKQwoUR3
         8n8UV4pTQnir9Xn6W2d5Vi7p6/y9PIn+PG1qni7HEwuZBmd5wj/DnfsDelR1JzecySgm
         m+hlSH3M1xpc8cOnys0HhEt9AoSwwWWb2kAKhwCVyvZoaPIhEGy4QCPWDF+u3XXGT+3+
         sXT2ViGkfTt376QBvQkGjTsvgWYX31K8Eh+eafAzmEFOvbP7zhYJhiAdeDG3GUJyHZCR
         F5Pa4Ytheg024mXDI1p20A/AbJ8kavfT8iZ3DGivryu1mi6fBVFIStmSDuWv9v5RYIXn
         PucA==
X-Forwarded-Encrypted: i=1; AJvYcCVbO57LqLLlPvT/uIuoopSAiDhWjZRLzREQD0MTXzffm/9fv0DChMeouXXOu4lzndX+iMWZhg8fDJKeDaE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfdjc416CY91GXk9HcPm6Rl0OYzQ0LvEgHuMrGKGaIu6poEppU
	PgIoTCbppiGnVruvFCwIsSHmfpQXkWxl5emDRdkYAW4ASyxPD0gR
X-Gm-Gg: ASbGncs4LsRhY5az6GzfcZm3Yj1CKNX+u/ZvlyANFeOq879rFO1AE8CPb7jihFilagc
	htNiqnXxJo8qgJmXIvVbBlBUtwy3BuVAIMRirHSRXywYTKfMDSvbuiG3OIMmQ9bpHb49mBDEdn9
	VbGfzLZA/09fHEQCbzq+Bwkh5IeMjWcjNerh/Pj2edQpGr3httVVEd3j3fbslPq6+cQXyu5dQzq
	Zad+lEEnWYEQMzhlmhWjGdavtYZyqybWSU15KnEFuRpBCPWckq26Ggnh31ciGKXx4augRD1hq+n
	UmFBsE/Jv+e2s4dseA==
X-Google-Smtp-Source: AGHT+IHstdjpSigFhN2igJJ+uFQJmFbHjahhv3wT/oTulr2cNaKb5gAC3MJK+5fY4aO6oDo3PD9wcQ==
X-Received: by 2002:a05:6000:154b:b0:38d:a695:6daf with SMTP id ffacd0b85a97d-38f33c20c39mr9565959f8f.19.1739786488810;
        Mon, 17 Feb 2025 02:01:28 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f7fe6sm11591901f8f.86.2025.02.17.02.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:01:28 -0800 (PST)
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
Subject: [PATCH v3 04/14] drm/vkms: Extract vkms_config header
Date: Mon, 17 Feb 2025 11:01:10 +0100
Message-ID: <20250217100120.7620-5-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217100120.7620-1-jose.exposito89@gmail.com>
References: <20250217100120.7620-1-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Creating a new vkms_config structure will be more complex once we
start adding more options.

Extract the vkms_config structure to its own header and source files
and add functions to create and delete a vkms_config and to initialize
debugfs.

Refactor, no functional changes.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/vkms/Makefile                 |  3 +-
 drivers/gpu/drm/vkms/tests/vkms_config_test.c | 13 +++++
 drivers/gpu/drm/vkms/vkms_config.c            | 50 +++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_config.h            | 47 +++++++++++++++++
 drivers/gpu/drm/vkms/vkms_drv.c               | 34 +++----------
 drivers/gpu/drm/vkms/vkms_drv.h               | 15 +-----
 drivers/gpu/drm/vkms/vkms_output.c            |  1 +
 7 files changed, 121 insertions(+), 42 deletions(-)
 create mode 100644 drivers/gpu/drm/vkms/vkms_config.c
 create mode 100644 drivers/gpu/drm/vkms/vkms_config.h

diff --git a/drivers/gpu/drm/vkms/Makefile b/drivers/gpu/drm/vkms/Makefile
index c23eee2f3df4..d657865e573f 100644
--- a/drivers/gpu/drm/vkms/Makefile
+++ b/drivers/gpu/drm/vkms/Makefile
@@ -7,7 +7,8 @@ vkms-y := \
 	vkms_crtc.o \
 	vkms_composer.o \
 	vkms_writeback.o \
-	vkms_connector.o
+	vkms_connector.o \
+	vkms_config.o
 
 obj-$(CONFIG_DRM_VKMS) += vkms.o
 obj-$(CONFIG_DRM_VKMS_KUNIT_TEST) += tests/
diff --git a/drivers/gpu/drm/vkms/tests/vkms_config_test.c b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
index 1177e62e19cb..a7060504f3dc 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_config_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
@@ -2,9 +2,22 @@
 
 #include <kunit/test.h>
 
+#include "../vkms_config.h"
+
 MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
 
+static void vkms_config_test_empty_config(struct kunit *test)
+{
+	struct vkms_config *config;
+
+	config = vkms_config_create();
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
+
+	vkms_config_destroy(config);
+}
+
 static struct kunit_case vkms_config_test_cases[] = {
+	KUNIT_CASE(vkms_config_test_empty_config),
 	{}
 };
 
diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
new file mode 100644
index 000000000000..42caa421876e
--- /dev/null
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/slab.h>
+
+#include <drm/drm_print.h>
+#include <drm/drm_debugfs.h>
+#include <kunit/visibility.h>
+
+#include "vkms_config.h"
+
+struct vkms_config *vkms_config_create(void)
+{
+	struct vkms_config *config;
+
+	config = kzalloc(sizeof(*config), GFP_KERNEL);
+	if (!config)
+		return ERR_PTR(-ENOMEM);
+
+	return config;
+}
+EXPORT_SYMBOL_IF_KUNIT(vkms_config_create);
+
+void vkms_config_destroy(struct vkms_config *config)
+{
+	kfree(config);
+}
+EXPORT_SYMBOL_IF_KUNIT(vkms_config_destroy);
+
+static int vkms_config_show(struct seq_file *m, void *data)
+{
+	struct drm_debugfs_entry *entry = m->private;
+	struct drm_device *dev = entry->dev;
+	struct vkms_device *vkmsdev = drm_device_to_vkms_device(dev);
+
+	seq_printf(m, "writeback=%d\n", vkmsdev->config->writeback);
+	seq_printf(m, "cursor=%d\n", vkmsdev->config->cursor);
+	seq_printf(m, "overlay=%d\n", vkmsdev->config->overlay);
+
+	return 0;
+}
+
+static const struct drm_debugfs_info vkms_config_debugfs_list[] = {
+	{ "vkms_config", vkms_config_show, 0 },
+};
+
+void vkms_config_register_debugfs(struct vkms_device *vkms_device)
+{
+	drm_debugfs_add_files(&vkms_device->drm, vkms_config_debugfs_list,
+			      ARRAY_SIZE(vkms_config_debugfs_list));
+}
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
new file mode 100644
index 000000000000..ced10f56a812
--- /dev/null
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef _VKMS_CONFIG_H_
+#define _VKMS_CONFIG_H_
+
+#include <linux/types.h>
+
+#include "vkms_drv.h"
+
+/**
+ * struct vkms_config - General configuration for VKMS driver
+ *
+ * @writeback: If true, a writeback buffer can be attached to the CRTC
+ * @cursor: If true, a cursor plane is created in the VKMS device
+ * @overlay: If true, NUM_OVERLAY_PLANES will be created for the VKMS device
+ * @dev: Used to store the current VKMS device. Only set when the device is instantiated.
+ */
+struct vkms_config {
+	bool writeback;
+	bool cursor;
+	bool overlay;
+	struct vkms_device *dev;
+};
+
+/**
+ * vkms_config_create() - Create a new VKMS configuration
+ *
+ * Returns:
+ * The new vkms_config or an error. Call vkms_config_destroy() to free the
+ * returned configuration.
+ */
+struct vkms_config *vkms_config_create(void);
+
+/**
+ * vkms_config_destroy() - Free a VKMS configuration
+ * @config: vkms_config to free
+ */
+void vkms_config_destroy(struct vkms_config *config);
+
+/**
+ * vkms_config_register_debugfs() - Register a debugfs file to show the device's
+ * configuration
+ * @vkms_device: Device to register
+ */
+void vkms_config_register_debugfs(struct vkms_device *vkms_device);
+
+#endif /* _VKMS_CONFIG_H_ */
diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index b6de91134a22..37de0658e6ee 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -27,11 +27,9 @@
 #include <drm/drm_gem_shmem_helper.h>
 #include <drm/drm_vblank.h>
 
+#include "vkms_config.h"
 #include "vkms_drv.h"
 
-#include <drm/drm_print.h>
-#include <drm/drm_debugfs.h>
-
 #define DRIVER_NAME	"vkms"
 #define DRIVER_DESC	"Virtual Kernel Mode Setting"
 #define DRIVER_MAJOR	1
@@ -81,23 +79,6 @@ static void vkms_atomic_commit_tail(struct drm_atomic_state *old_state)
 	drm_atomic_helper_cleanup_planes(dev, old_state);
 }
 
-static int vkms_config_show(struct seq_file *m, void *data)
-{
-	struct drm_debugfs_entry *entry = m->private;
-	struct drm_device *dev = entry->dev;
-	struct vkms_device *vkmsdev = drm_device_to_vkms_device(dev);
-
-	seq_printf(m, "writeback=%d\n", vkmsdev->config->writeback);
-	seq_printf(m, "cursor=%d\n", vkmsdev->config->cursor);
-	seq_printf(m, "overlay=%d\n", vkmsdev->config->overlay);
-
-	return 0;
-}
-
-static const struct drm_debugfs_info vkms_config_debugfs_list[] = {
-	{ "vkms_config", vkms_config_show, 0 },
-};
-
 static const struct drm_driver vkms_driver = {
 	.driver_features	= DRIVER_MODESET | DRIVER_ATOMIC | DRIVER_GEM,
 	.fops			= &vkms_driver_fops,
@@ -208,8 +189,7 @@ static int vkms_create(struct vkms_config *config)
 	if (ret)
 		goto out_devres;
 
-	drm_debugfs_add_files(&vkms_device->drm, vkms_config_debugfs_list,
-			      ARRAY_SIZE(vkms_config_debugfs_list));
+	vkms_config_register_debugfs(vkms_device);
 
 	ret = drm_dev_register(&vkms_device->drm, 0);
 	if (ret)
@@ -231,9 +211,9 @@ static int __init vkms_init(void)
 	int ret;
 	struct vkms_config *config;
 
-	config = kmalloc(sizeof(*config), GFP_KERNEL);
-	if (!config)
-		return -ENOMEM;
+	config = vkms_config_create();
+	if (IS_ERR(config))
+		return PTR_ERR(config);
 
 	config->cursor = enable_cursor;
 	config->writeback = enable_writeback;
@@ -241,7 +221,7 @@ static int __init vkms_init(void)
 
 	ret = vkms_create(config);
 	if (ret) {
-		kfree(config);
+		vkms_config_destroy(config);
 		return ret;
 	}
 
@@ -275,7 +255,7 @@ static void __exit vkms_exit(void)
 		return;
 
 	vkms_destroy(default_config);
-	kfree(default_config);
+	vkms_config_destroy(default_config);
 }
 
 module_init(vkms_init);
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index abbb652be2b5..af7081c940d6 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -189,20 +189,7 @@ struct vkms_output {
 	spinlock_t composer_lock;
 };
 
-/**
- * struct vkms_config - General configuration for VKMS driver
- *
- * @writeback: If true, a writeback buffer can be attached to the CRTC
- * @cursor: If true, a cursor plane is created in the VKMS device
- * @overlay: If true, NUM_OVERLAY_PLANES will be created for the VKMS device
- * @dev: Used to store the current VKMS device. Only set when the device is instantiated.
- */
-struct vkms_config {
-	bool writeback;
-	bool cursor;
-	bool overlay;
-	struct vkms_device *dev;
-};
+struct vkms_config;
 
 /**
  * struct vkms_device - Description of a VKMS device
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 4b5abe159add..068a7f87ecec 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 
+#include "vkms_config.h"
 #include "vkms_connector.h"
 #include "vkms_drv.h"
 #include <drm/drm_managed.h>
-- 
2.48.1


