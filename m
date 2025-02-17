Return-Path: <linux-kernel+bounces-517318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDA7A37F48
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B18C5174591
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0FA217F26;
	Mon, 17 Feb 2025 10:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvsnxGt1"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AD621767C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786494; cv=none; b=H4KZtkhsqvJiTkCz4DF6zfN1FI5HwS+V7X0snBzXmQCKq8Fj8Y0Lvv0QgKVyzdbUTZT2IiiXWHWfBz6O3jFl7GgVG/vT8E9ZjEUfEP/2vXk0Oj+XIea5pnVIoLCc08mTieFkWg/6HUlF7CqjPslkKYZNySIaQy5FlK+qdZn6iWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786494; c=relaxed/simple;
	bh=FO0iiUXRhkoGigFFgbjCarBeopu2pFAvqYIozSc40SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qq9Ox7HpZv7BGLbhT+j5+7hCDaBcrsiHqPk1UCSk9JUX/OlYBPVc/oZE/PUlI+ZvihcoabABHvz1fUAWnatGezZbpz8OPHrElUBmT4Meuw+hHo+KUZ2utH2kAVW0Tqv37Dg8bO+gYGlziMDbkoGJd7giU/HddTZUXyYw+dIXkDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvsnxGt1; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38f378498c9so1388565f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739786491; x=1740391291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJKka9BGXo5aWskaWZaSFDrSIvgDMiHYo6XxF9H8dkw=;
        b=QvsnxGt1MwjCVho96wuXJsiTAIyFJmtPQuryXrNItGUGCwTOmyzagGkzBTH8rtgtFc
         xowRNo4VCKIbXmrFqw1S4aUqeKQmPggXL0Kv8oRIPsAWjjLqHylDPTCSxMmNqkT3G18e
         ButRyYLBG5TOROD/xX147rKjn/0WQpd90lm3g6somJp3K0Owq6GZKE9hUpXkEcCKgATM
         nGs3FjQpvRXUgLxAsB1KPa9x74foavoZgFkIQIYrt1TnQMP6B+cBMw1xsfUk6A59V/nj
         XulxBF4b/oqWsBx+zFap90k/SrJzr/BdpRZ2h8N4FMkN0utVefIxbiB0zCnEWlwvcWjZ
         9H9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739786491; x=1740391291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJKka9BGXo5aWskaWZaSFDrSIvgDMiHYo6XxF9H8dkw=;
        b=sDo80I+Lu8niaOGhY//ZhG8fyNFyoX27/h5KNNO3GrtaQD3TG3QkxGwC9K5K/OBy6r
         DV8x0g9zyriZIMJM4xiu8RRRUsGb9lcHl8yHv+pdxeK8QCGFrSMprKrLVGtK95OsA9cZ
         HzsW+2kjbKRFKqO9uD/qpMNbtm8QtmDFS2OjEbUYaJzWU7Rg/j5Gt59NGkEHNJSTvoqw
         4ki4QsSH/8AiqVGpbU53SCV4Y3ICMCP1s/fQ1OTf8mhCpyQhxnBSGS6n3MVrmiDaux7K
         DzAo7n4D69NdNAp4BtKardqHFFP+dV6q79tL6tTp+XdvrsKAmCq9v0EZ9HXCTSnSzMja
         MT4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUkO3VLgsyDrtn8zDFYtavOmOinxV/oHqH8dQeT9HifLjq3j9dmwuPmgm2V/DA+8da8L7z7UoCEtKyOf9g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8FYRHQ87UG/5jQuW+JT8ET5uhelof4a6LWC5WX0gyuP83k37i
	Vmg76/dupJxpktV3s6XU16oEh0N8BmEL0OW0+o7CNuVjDoIFKrL62feamRnv
X-Gm-Gg: ASbGnctcKVOyL05E2Dp7lKpfzJ1X6lyKQl6A3EqWF+OItDb2FFLZLkXtxz8H5lllF6K
	Uhtc+MyvPjrAZ541kBCMcBkvfcuWNCwfVVIRTQ4yHWJQE0T4vKwxSJgyol/TtJ2D7EBuyZPPAdh
	EsCt/Anztr7Wg0IK/J4tPh9zhz2vb38vlqyszZfy5BD0gqJsLTfrR3rPTDdVoOuR3DFR7RQZJg6
	MbYdnCT24i8SAdSMp8DMu24cTCfjeItWuUViCndm8TLJIdgY1czTUAvJR4dqwF7ndVQN1+RmUzP
	dMa/eWYAn+xjYPadvw==
X-Google-Smtp-Source: AGHT+IEvXRu7nQr9abk46p9Flqt3U0L5kaXWVWty1aavdlHs6R4PCjETBRhWfdtHHenUEDLZusXffQ==
X-Received: by 2002:a5d:438c:0:b0:38f:2856:7dc4 with SMTP id ffacd0b85a97d-38f33f62c72mr7168453f8f.55.1739786491049;
        Mon, 17 Feb 2025 02:01:31 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f7fe6sm11591901f8f.86.2025.02.17.02.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:01:30 -0800 (PST)
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
Subject: [PATCH v3 06/14] drm/vkms: Set device name from vkms_config
Date: Mon, 17 Feb 2025 11:01:12 +0100
Message-ID: <20250217100120.7620-7-jose.exposito89@gmail.com>
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

In order to be able to create multiple devices, the device name needs to
be unique.

Allow to set it in the VKMS configuration.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/vkms/tests/vkms_config_test.c |  7 ++++++-
 drivers/gpu/drm/vkms/vkms_config.c            | 14 ++++++++++++--
 drivers/gpu/drm/vkms/vkms_config.h            | 18 +++++++++++++++++-
 drivers/gpu/drm/vkms/vkms_drv.c               |  4 +++-
 drivers/gpu/drm/vkms/vkms_drv.h               |  2 ++
 5 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vkms/tests/vkms_config_test.c b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
index d8644a1e3e18..92798590051b 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_config_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
@@ -15,10 +15,15 @@ struct default_config_case {
 static void vkms_config_test_empty_config(struct kunit *test)
 {
 	struct vkms_config *config;
+	const char *dev_name = "test";
 
-	config = vkms_config_create();
+	config = vkms_config_create(dev_name);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
 
+	/* The dev_name string and the config have different lifetimes */
+	dev_name = NULL;
+	KUNIT_EXPECT_STREQ(test, vkms_config_get_device_name(config), "test");
+
 	vkms_config_destroy(config);
 }
 
diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index 0af8e6dc0a01..9fb08d94a351 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -8,7 +8,7 @@
 
 #include "vkms_config.h"
 
-struct vkms_config *vkms_config_create(void)
+struct vkms_config *vkms_config_create(const char *dev_name)
 {
 	struct vkms_config *config;
 
@@ -16,6 +16,12 @@ struct vkms_config *vkms_config_create(void)
 	if (!config)
 		return ERR_PTR(-ENOMEM);
 
+	config->dev_name = kstrdup_const(dev_name, GFP_KERNEL);
+	if (!config->dev_name) {
+		kfree(config);
+		return ERR_PTR(-ENOMEM);
+	}
+
 	return config;
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_create);
@@ -26,7 +32,7 @@ struct vkms_config *vkms_config_default_create(bool enable_cursor,
 {
 	struct vkms_config *config;
 
-	config = vkms_config_create();
+	config = vkms_config_create(DEFAULT_DEVICE_NAME);
 	if (IS_ERR(config))
 		return config;
 
@@ -40,6 +46,7 @@ EXPORT_SYMBOL_IF_KUNIT(vkms_config_default_create);
 
 void vkms_config_destroy(struct vkms_config *config)
 {
+	kfree_const(config->dev_name);
 	kfree(config);
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_destroy);
@@ -49,7 +56,10 @@ static int vkms_config_show(struct seq_file *m, void *data)
 	struct drm_debugfs_entry *entry = m->private;
 	struct drm_device *dev = entry->dev;
 	struct vkms_device *vkmsdev = drm_device_to_vkms_device(dev);
+	const char *dev_name;
 
+	dev_name = vkms_config_get_device_name((struct vkms_config *)vkmsdev->config);
+	seq_printf(m, "dev_name=%s\n", dev_name);
 	seq_printf(m, "writeback=%d\n", vkmsdev->config->writeback);
 	seq_printf(m, "cursor=%d\n", vkmsdev->config->cursor);
 	seq_printf(m, "overlay=%d\n", vkmsdev->config->overlay);
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index d0868750826a..fcaa909fb2e0 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -10,12 +10,14 @@
 /**
  * struct vkms_config - General configuration for VKMS driver
  *
+ * @dev_name: Name of the device
  * @writeback: If true, a writeback buffer can be attached to the CRTC
  * @cursor: If true, a cursor plane is created in the VKMS device
  * @overlay: If true, NUM_OVERLAY_PLANES will be created for the VKMS device
  * @dev: Used to store the current VKMS device. Only set when the device is instantiated.
  */
 struct vkms_config {
+	const char *dev_name;
 	bool writeback;
 	bool cursor;
 	bool overlay;
@@ -24,12 +26,13 @@ struct vkms_config {
 
 /**
  * vkms_config_create() - Create a new VKMS configuration
+ * @dev_name: Name of the device
  *
  * Returns:
  * The new vkms_config or an error. Call vkms_config_destroy() to free the
  * returned configuration.
  */
-struct vkms_config *vkms_config_create(void);
+struct vkms_config *vkms_config_create(const char *dev_name);
 
 /**
  * vkms_config_default_create() - Create the configuration for the default device
@@ -51,6 +54,19 @@ struct vkms_config *vkms_config_default_create(bool enable_cursor,
  */
 void vkms_config_destroy(struct vkms_config *config);
 
+/**
+ * vkms_config_get_device_name() - Return the name of the device
+ * @config: Configuration to get the device name from
+ *
+ * Returns:
+ * The device name. Only valid while @config is valid.
+ */
+static inline const char *
+vkms_config_get_device_name(struct vkms_config *config)
+{
+	return config->dev_name;
+}
+
 /**
  * vkms_config_register_debugfs() - Register a debugfs file to show the device's
  * configuration
diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 582d5825f42b..ba977ef09b2b 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -151,8 +151,10 @@ static int vkms_create(struct vkms_config *config)
 	int ret;
 	struct platform_device *pdev;
 	struct vkms_device *vkms_device;
+	const char *dev_name;
 
-	pdev = platform_device_register_simple(DRIVER_NAME, -1, NULL, 0);
+	dev_name = vkms_config_get_device_name(config);
+	pdev = platform_device_register_simple(dev_name, -1, NULL, 0);
 	if (IS_ERR(pdev))
 		return PTR_ERR(pdev);
 
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index af7081c940d6..a74a7fc3a056 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -12,6 +12,8 @@
 #include <drm/drm_encoder.h>
 #include <drm/drm_writeback.h>
 
+#define DEFAULT_DEVICE_NAME "vkms"
+
 #define XRES_MIN    10
 #define YRES_MIN    10
 
-- 
2.48.1


