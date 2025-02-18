Return-Path: <linux-kernel+bounces-519148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E92A3987E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F1C2174DF8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35D323BFBC;
	Tue, 18 Feb 2025 10:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrKoZfDE"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C213723875D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873548; cv=none; b=eSraGf0UeQdfct/TArdamm5t6X6J0yv4Ccvt9bqWqIOUK/sIkJns1XrCMx36ca4zvk06jwvVb85nCQvE+DqbiXkN+6hrZE8IrsGg/idg61f6c8C4Q9KwziJ32qHbUmgmtlpyTMSBONL3oEKMVmAo7ZkoAwrJ+JDjtXWRXoO/8QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873548; c=relaxed/simple;
	bh=lE2dcBc64Q45pDXeulBAcyc2a1SFMDFApIAknsuoPPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q7mTcIewWCPfhLYnlAKGXiiWor1BqCP0IuSscBVEoCepZEImtHoVDjM2pi3+ud9he+uopNU0/R5hA7WJTHMEQ3NkmWlO7r1VDZA8ziTe4sIxulYY7eMhxdPR0twX0TPrEJ1FsaNVG7ToHwD6axUggXAEUrXwyFWMA3nQnCiE4fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrKoZfDE; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38dd9b3419cso2765903f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 02:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739873545; x=1740478345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmDfaEOjc70HjJgnj7sLGaZRyHuUKTvYVGnXm2VRbiY=;
        b=PrKoZfDE4csk0Zgx5H8W9wNKE9PctYr/KSO0XWQHsqr/nQLPCrXGfDMj5LQL5NGz4O
         RkLWBFCv5IZCd/hDa7a0UKfHlrkuj4njHoIkaXm3TSaWmiUDVdDDY9+c01C5nfOxszqr
         vshabRgAhRAuuoL/tWw9d7gcGvW8WVjOJDzWvTDSh3WYUh2F069IJuGQD7vcd4Op5fyl
         sYq16ErKUkUXRcKV5LdltitHoEWNoZOryyzEBcb6aXt56sswkdnqO46ke5obVOdWt+gr
         e8EWij4s6gtlhd8aatWPbOhyQ1qTjZK9LocCnrT80f+ES+S1pAvWc9yPWQsB0lHr40my
         TY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739873545; x=1740478345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LmDfaEOjc70HjJgnj7sLGaZRyHuUKTvYVGnXm2VRbiY=;
        b=uIeq3BBJgfhPsyEBuxESsztQrfSTj8m+Tqg31Fv3uoICB1fzXaKcNoktrXQO1yhA+e
         LA3cWMKjeHJIVANOf/zKYxBomgAOzeduyFXW8Okwj5lrhhm26wtdkebIMOs93yKYXDpY
         8Sdx7dIzVFRDJNAfeItn1LTE05qoHU/Q0ESMJSgpZ8O6fqzCHRKsiYTX8NDBdCkCVs7Z
         ct1BedQ+RZjGBBbOeQl+k6NqQGXsZMmvItc0lwm62rOF8oPlhVRdJJBuiUVCY1o3Wo3b
         vm7rk+vcdVb/TmRfBqKSdFmv18afEo2pLlaQZlbb4rK78d+Xx5arB+ONzDdlKUj+UrFx
         2yHg==
X-Forwarded-Encrypted: i=1; AJvYcCVTveFniZvB+l+cAoeE3deRzvpJ2R5jtTA3pNcnlDnqv2KH3qIGTozZe/DNnrOQ2WIkV3Itgdt104qVpYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzQcvrIwTExYCgo1qZgjyQXSkPPyG1uJpUbviLDBNQwgtxCj77
	q6nGkjk0NFHKWPmnm5kyOuwNyefTK19v2rk+BjoIjpH1dXsEO9U+
X-Gm-Gg: ASbGnctMFbf037aDQCDJNbvGfI2pzxG0uEzmXDhf4FZIO1qVXfBjdm/AIex/G3Hf28Z
	6i4kFzNd+hwoDPFakPjt2fyPbEzYWXd5EZGy60LXBkS/uEkfT+s7tH7bKhgoGdp0WFAS9d/bXJg
	GuRJAwyYmPe2faZNzOYObjC5JVbrAl04FOd77EXG0E55ptOiMXlA3UudsCyQyRQNtpotYXTkSCh
	SgR4Y4hbX73uyIBXJijyR9U3seUzJGBycOUZLl1pQm7tfkhaOvZK30P47LGBJdgPi+8iOJ3Mtk8
	1mjFGvoRVa9SHYWOSQ==
X-Google-Smtp-Source: AGHT+IFmXSGkB4xpAzaHAsX4XcGtZCuBZxviDINWjxwvydlcFSLk0TMWD+DRz0g9pVwMGJ2kObvZXw==
X-Received: by 2002:a05:6000:1863:b0:38f:4263:9d62 with SMTP id ffacd0b85a97d-38f42639e66mr6729434f8f.27.1739873545011;
        Tue, 18 Feb 2025 02:12:25 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5e92sm14749720f8f.66.2025.02.18.02.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 02:12:24 -0800 (PST)
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
Subject: [PATCH v4 04/14] drm/vkms: Extract vkms_config header
Date: Tue, 18 Feb 2025 11:12:04 +0100
Message-ID: <20250218101214.5790-5-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218101214.5790-1-jose.exposito89@gmail.com>
References: <20250218101214.5790-1-jose.exposito89@gmail.com>
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


