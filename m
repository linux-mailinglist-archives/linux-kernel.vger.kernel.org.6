Return-Path: <linux-kernel+bounces-519150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAC0A39898
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2547E3B7C53
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F03123ED77;
	Tue, 18 Feb 2025 10:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNCzgaCX"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664452397BF
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873551; cv=none; b=eO6WxY3m5yEaSBik3naXjBgiAZNAf0mnAWO9sKb3Lg1xZx0dzK2p6peX6KDItObcoalnSs4NzIJYLgrE9fPOQiAI4oKtNB1cVeyMYQkHyAjijjtk4lIAbuEWM+tmLVH63F61nD6LH0+evvJJ/78q56NIieCJh8B4vgoGWbcCVc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873551; c=relaxed/simple;
	bh=FO0iiUXRhkoGigFFgbjCarBeopu2pFAvqYIozSc40SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nGElSoeOEkY2xp7dmIaYRRlbw9AhWTpTHABVm0woF0YNT27+j66EiHBoSPti510x7rz5PSL5aKPF1p/vGdM2aAFx53Qb5aH7jnFkrAASW0ZNdQzyDGCsnMeNWukZf6v6Bo00EHDDPVO/Z2h3E7mgYdCkUOb63ZVJT/N8llo8jOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNCzgaCX; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4396d2e32b7so22257975e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 02:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739873547; x=1740478347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJKka9BGXo5aWskaWZaSFDrSIvgDMiHYo6XxF9H8dkw=;
        b=fNCzgaCXD/fXRaX8ZycrDrh8//KYsErmoSb1NXi8R/uj3NX9/XF6qoech4zK20XZ9z
         Z50iwv8LcArAL2ve5WDG/n6kf+srdpbNps6sjh72iFxBFoDyCZlGQaG9nAHoaA0AE9HE
         pncRqdsNU3nszetk+ULrTTOLB/871jZkyBnMDB2uKwO4GiydNqPUHbHC3IaiobYvvOQ5
         fXoytbECaD3t5nAjR3i/uWNlDMaCaoJ4WQWv/aDJpq4NQe31YuLKyByd8RJmSlwUh16D
         2pMtCvYyJQy9rx3MPDAbM4mP28y7kUIkXgGQEDs2QYZVMy/fBBCzbe505fdTFl73+CEW
         1H+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739873547; x=1740478347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJKka9BGXo5aWskaWZaSFDrSIvgDMiHYo6XxF9H8dkw=;
        b=wU3T5fEkQ1aPu1QhPmHdLgRMCQ+MjFZgUpceG7t802kyMCeXIPfBj1A4wpRpLJ0G/C
         vfJ5Y0mqQAHmn0rqyoNmU1B9lBissfO8hFPTYJrO1fL/7bvcTyaNkdFvRNY8nqDr9/eM
         6ilaLmS2DgeNfT5zJH1Xrf+HWUqfcGSP17BL4bnw5cTaIjB+smU+8W7CIVGMV8EIzpkT
         xm71d1gXtA3fVZHgjB0wudZEHaOJjG2eyQhAihrE3hecUTMFvRLxtQzyNBvWlrDEpVC8
         Ge7Lzwz0sNUJr9AAGfwkiPR4uboEx6Mlrp0RKf219cMnxfnVDD7/hASVy4NkgneqZx23
         c02g==
X-Forwarded-Encrypted: i=1; AJvYcCV1/6Fh/YrTMh6W8+CbjqmZMQBgjAe+7iZ3Q+In25D9eBqNi2mXLuMn0tbDqjqIXpjT5uKCwynXbS3O5Vc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/xgrECdtMENi91Snu2QjXDK8qK8Yrk3emm7jiyBSJLVZCLQ+C
	o4IyQz/ChVW5TUmLC2jkw/gJf1tCK9qG8coDMZE4FRXU5oUdm/d4
X-Gm-Gg: ASbGncv/ZNn8ssNQKGgeHzZgfk28CCXzCtG11+JSPNB7rfF9yGr650ZyxfZ0sWTXGF5
	ATYMeSslwzD/roCV20Z4vDMqHUAKWBPXW0O/lDevk+lJ1jilbsdUxf6A1R4Taiya0jHrvNfJj9l
	LAkU7jugY2gWHSQ+ZVU5ffnVR0jzbEBUfypBzX0HjWl8jfitIyv2zhNyyDIioZoVMNZpLjJmzpU
	ToyS2ZLM11cBPm0JLmTWlOXJ4yG9uojAl/TlFi+OH/51fepjnqY1hrHo7+Bb1Re4Xk8/3mZ+GGK
	SilKl4EknM7vjCtAgw==
X-Google-Smtp-Source: AGHT+IGWzSNr3kxbNV50jtbq0xbVL8YqiJgdejwz9FCOvAxbLEogzuxer5MPdYZcMn4JCJdbLY2+eg==
X-Received: by 2002:a5d:5a11:0:b0:38f:32a7:b6f3 with SMTP id ffacd0b85a97d-38f33f4b858mr9937330f8f.40.1739873547398;
        Tue, 18 Feb 2025 02:12:27 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5e92sm14749720f8f.66.2025.02.18.02.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 02:12:27 -0800 (PST)
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
Subject: [PATCH v4 06/14] drm/vkms: Set device name from vkms_config
Date: Tue, 18 Feb 2025 11:12:06 +0100
Message-ID: <20250218101214.5790-7-jose.exposito89@gmail.com>
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


