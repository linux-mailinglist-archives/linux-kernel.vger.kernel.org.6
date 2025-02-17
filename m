Return-Path: <linux-kernel+bounces-517323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08242A37F3D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB6377A476F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9769B218AD1;
	Mon, 17 Feb 2025 10:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVp2Brgt"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C87D218585
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786501; cv=none; b=XVm6VdDfvwUQLNnNsfsf/Fz40APXWruDZoUce0EpQfwXXAR5lTIBUfWj0AnT5Iwqv8bcpgMYwKYNheNxT65JPfS14VBivmrBGMDPporNPCn/Ot5RcO4B+S6LuWd6+MzMGMYnhrTYs7wpFKG+1QUIdCWKRvrGB5D/cKoEmn4fHYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786501; c=relaxed/simple;
	bh=rlfD5wBucXKnQMZOvsfOoKN8z60IOIehNFdyuewfXQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jZearXcfu4z22+GxoXEIIMKDDwVmEbCZ0vkpcRXtd5dPjxfNWfvzb0EDUshoSGt8KPMyi8uyqf1pT/IewTtidak7npqo696FnBskC/utJThObYMqVwVLIpsGKFM6d4HmT+AcztTroTm6uRbwiDzpmqlzx0Ke1+mG257tlW3HcUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVp2Brgt; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38de1a5f039so3963927f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739786498; x=1740391298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QE/hUz6GYbvwIk0/ln/IOlUTy13vdrYGmRx1J7/N6cw=;
        b=HVp2Brgt/muXaqJ7ZAQ3owaR6OjxcOfwAYAcnKdBCNNnzjisCnBthV4w3aT8aU/aN9
         gEcBLo2n4OTauNYRE8Aa4XZCXNT/Y6jC2oXQbLXHjUbgmHLhAwEvTyDXknILdnbz8Emt
         vLUU4D5bqbs2/yGqTWqlNTad6D8GnmwqtRZd2ldjSI9gv8A1r7/SavMNpwvm6kpqY/8V
         VP+L3/5/tzPBYQcPdLjApRFKd1lIqnWVED4FStrlHTwLQ0O0ea6VHUtx5fwE6ju+AU/2
         dQamSqyLUh0mdg+3ubUuoy4HFUneB9v5C4ipee2rhCwbbtUwNagN+1c1vvY7ElVgUKzH
         YgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739786498; x=1740391298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QE/hUz6GYbvwIk0/ln/IOlUTy13vdrYGmRx1J7/N6cw=;
        b=Rz6WnpLiUgrZHmcCmWJnYrkmGLClxdtZiXk+qQpt2rdtuGhaXYMVMKpK3Pi+q4Aue8
         HwGQ+33WS5wXzq2FgHf7a1pCBVfvt/ZiM425a9JS3UcKJ+3TQY0RIwb9u9FmJwe83yMG
         wDCeL5zYjmM+eZFqRYCnNQZtdb/47OQIuT3kWvkFoqAS7T+NyGiAGL+H6TJX3iSJpwh3
         QLZXeF4TMnbpBQBKSi82Eh4p1uoGMjvlcq7C8mjUYsff9fb4JGoNHnZTmNIJu46gl98k
         Junwhl0dCGp7qQLIsVdM6mS7veBP2pV9q9dnSOcCXNswLYu7XtE/l33b4QVu9RVbNx5t
         VJEw==
X-Forwarded-Encrypted: i=1; AJvYcCW25qEoUteRgdIqSi6PVmXXnpYPvRt+7WVZmdyKwffEWwubRQxR0r4AhW+7REmSISEnL8vSF3DvmHmkC+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEnym13lR6AN1LMn+fMHmBprCxgGqCPQmd/Gjq70CKW1yUSHDw
	DGtciVQoSZbxtWAx17nZ9qdwTiN22+UE0BIhgwgg6hObuEmEJwnF
X-Gm-Gg: ASbGncsNfsKqwyNZd5TJ0hqdpB1JPHWf40l0ddNInSa3JygKjslEuQDX8A2qwqJAs3B
	6hjcWC1y+VtpqwXCaSfeI1O4kFCRXZNmlbSkAqjSx0KsHar1LcyEGxKAIwmDGAAusDzzACsRC2s
	f0yOEz+BJqp9FmtnZYu+wYlKJKCwdoaMAsSPvj46qjLO+RJkOBRsjsboHpAyryvNvneLGNHbx57
	6nhlhz1R+kDomArp4YdRHM0snbGtEoAB2dWxadfB2P6B4Ggb1C3H4sLVQmlCpM2+Hk4QMVUieiY
	HiOQoRQuVvAuw46VHg==
X-Google-Smtp-Source: AGHT+IGyqqXdCDlpGFfiHEQ2LUXkFawndXkHby5XB87IbcBSHCsBW62ArJ64y5Rm2Ma51E8LAMaxFw==
X-Received: by 2002:a05:6000:18a9:b0:38f:2990:c091 with SMTP id ffacd0b85a97d-38f33f1224bmr8086177f8f.6.1739786496997;
        Mon, 17 Feb 2025 02:01:36 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f7fe6sm11591901f8f.86.2025.02.17.02.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:01:36 -0800 (PST)
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
Subject: [PATCH v3 11/14] drm/vkms: Allow to configure multiple encoders
Date: Mon, 17 Feb 2025 11:01:17 +0100
Message-ID: <20250217100120.7620-12-jose.exposito89@gmail.com>
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

Add a list of encoders to vkms_config and helper functions to add and
remove as many encoders as wanted.

For backwards compatibility, add one encoder to the default
configuration.

A future patch will allow to attach encoders and CRTCs, but for the
moment there are no changes in the way the output is configured.

Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 .clang-format                                 |  1 +
 drivers/gpu/drm/vkms/tests/vkms_config_test.c | 73 +++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_config.c            | 54 ++++++++++++++
 drivers/gpu/drm/vkms/vkms_config.h            | 46 ++++++++++++
 4 files changed, 174 insertions(+)

diff --git a/.clang-format b/.clang-format
index 6f944fa39841..c355a2f58eed 100644
--- a/.clang-format
+++ b/.clang-format
@@ -691,6 +691,7 @@ ForEachMacros:
   - 'v4l2_m2m_for_each_src_buf_safe'
   - 'virtio_device_for_each_vq'
   - 'vkms_config_for_each_crtc'
+  - 'vkms_config_for_each_encoder'
   - 'vkms_config_for_each_plane'
   - 'vkms_config_plane_for_each_possible_crtc'
   - 'while_for_each_ftrace_op'
diff --git a/drivers/gpu/drm/vkms/tests/vkms_config_test.c b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
index b7a0a8202819..92926972c64c 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_config_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
@@ -26,6 +26,7 @@ static void vkms_config_test_empty_config(struct kunit *test)
 
 	KUNIT_EXPECT_TRUE(test, list_empty(&config->planes));
 	KUNIT_EXPECT_TRUE(test, list_empty(&config->crtcs));
+	KUNIT_EXPECT_TRUE(test, list_empty(&config->encoders));
 
 	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
 
@@ -99,6 +100,9 @@ static void vkms_config_test_default_config(struct kunit *test)
 		KUNIT_EXPECT_EQ(test, n_possible_crtcs, 1);
 	}
 
+	/* Encoders */
+	KUNIT_EXPECT_EQ(test, list_count_nodes(&config->encoders), 1);
+
 	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
 
 	vkms_config_destroy(config);
@@ -184,6 +188,50 @@ static void vkms_config_test_get_crtcs(struct kunit *test)
 	vkms_config_destroy(config);
 }
 
+static void vkms_config_test_get_encoders(struct kunit *test)
+{
+	struct vkms_config *config;
+	struct vkms_config_encoder *encoder_cfg;
+	struct vkms_config_encoder *encoder_cfg1, *encoder_cfg2;
+	int n_encoders = 0;
+
+	config = vkms_config_create("test");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
+
+	vkms_config_for_each_encoder(config, encoder_cfg)
+		n_encoders++;
+	KUNIT_ASSERT_EQ(test, n_encoders, 0);
+
+	encoder_cfg1 = vkms_config_create_encoder(config);
+	vkms_config_for_each_encoder(config, encoder_cfg) {
+		n_encoders++;
+		if (encoder_cfg != encoder_cfg1)
+			KUNIT_FAIL(test, "Unexpected encoder");
+	}
+	KUNIT_ASSERT_EQ(test, n_encoders, 1);
+	n_encoders = 0;
+
+	encoder_cfg2 = vkms_config_create_encoder(config);
+	vkms_config_for_each_encoder(config, encoder_cfg) {
+		n_encoders++;
+		if (encoder_cfg != encoder_cfg1 && encoder_cfg != encoder_cfg2)
+			KUNIT_FAIL(test, "Unexpected encoder");
+	}
+	KUNIT_ASSERT_EQ(test, n_encoders, 2);
+	n_encoders = 0;
+
+	vkms_config_destroy_encoder(config, encoder_cfg2);
+	vkms_config_for_each_encoder(config, encoder_cfg) {
+		n_encoders++;
+		if (encoder_cfg != encoder_cfg1)
+			KUNIT_FAIL(test, "Unexpected encoder");
+	}
+	KUNIT_ASSERT_EQ(test, n_encoders, 1);
+	n_encoders = 0;
+
+	vkms_config_destroy(config);
+}
+
 static void vkms_config_test_invalid_plane_number(struct kunit *test)
 {
 	struct vkms_config *config;
@@ -319,6 +367,29 @@ static void vkms_config_test_invalid_crtc_number(struct kunit *test)
 	vkms_config_destroy(config);
 }
 
+static void vkms_config_test_invalid_encoder_number(struct kunit *test)
+{
+	struct vkms_config *config;
+	struct vkms_config_encoder *encoder_cfg;
+	int n;
+
+	config = vkms_config_default_create(false, false, false);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
+
+	/* Invalid: No encoders */
+	encoder_cfg = list_first_entry(&config->encoders, typeof(*encoder_cfg), link);
+	vkms_config_destroy_encoder(config, encoder_cfg);
+	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
+
+	/* Invalid: Too many encoders */
+	for (n = 0; n <= 32; n++)
+		vkms_config_create_encoder(config);
+
+	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
+
+	vkms_config_destroy(config);
+}
+
 static void vkms_config_test_attach_different_configs(struct kunit *test)
 {
 	struct vkms_config *config1, *config2;
@@ -483,10 +554,12 @@ static struct kunit_case vkms_config_test_cases[] = {
 			 default_config_gen_params),
 	KUNIT_CASE(vkms_config_test_get_planes),
 	KUNIT_CASE(vkms_config_test_get_crtcs),
+	KUNIT_CASE(vkms_config_test_get_encoders),
 	KUNIT_CASE(vkms_config_test_invalid_plane_number),
 	KUNIT_CASE(vkms_config_test_valid_plane_type),
 	KUNIT_CASE(vkms_config_test_valid_plane_possible_crtcs),
 	KUNIT_CASE(vkms_config_test_invalid_crtc_number),
+	KUNIT_CASE(vkms_config_test_invalid_encoder_number),
 	KUNIT_CASE(vkms_config_test_attach_different_configs),
 	KUNIT_CASE(vkms_config_test_plane_attach_crtc),
 	KUNIT_CASE(vkms_config_test_plane_get_possible_crtcs),
diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index 458385413648..db8be054f6f4 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -24,6 +24,7 @@ struct vkms_config *vkms_config_create(const char *dev_name)
 
 	INIT_LIST_HEAD(&config->planes);
 	INIT_LIST_HEAD(&config->crtcs);
+	INIT_LIST_HEAD(&config->encoders);
 
 	return config;
 }
@@ -36,6 +37,7 @@ struct vkms_config *vkms_config_default_create(bool enable_cursor,
 	struct vkms_config *config;
 	struct vkms_config_plane *plane_cfg;
 	struct vkms_config_crtc *crtc_cfg;
+	struct vkms_config_encoder *encoder_cfg;
 	int n;
 
 	config = vkms_config_create(DEFAULT_DEVICE_NAME);
@@ -80,6 +82,10 @@ struct vkms_config *vkms_config_default_create(bool enable_cursor,
 			goto err_alloc;
 	}
 
+	encoder_cfg = vkms_config_create_encoder(config);
+	if (IS_ERR(encoder_cfg))
+		goto err_alloc;
+
 	return config;
 
 err_alloc:
@@ -92,6 +98,7 @@ void vkms_config_destroy(struct vkms_config *config)
 {
 	struct vkms_config_plane *plane_cfg, *plane_tmp;
 	struct vkms_config_crtc *crtc_cfg, *crtc_tmp;
+	struct vkms_config_encoder *encoder_cfg, *encoder_tmp;
 
 	list_for_each_entry_safe(plane_cfg, plane_tmp, &config->planes, link)
 		vkms_config_destroy_plane(plane_cfg);
@@ -99,6 +106,9 @@ void vkms_config_destroy(struct vkms_config *config)
 	list_for_each_entry_safe(crtc_cfg, crtc_tmp, &config->crtcs, link)
 		vkms_config_destroy_crtc(config, crtc_cfg);
 
+	list_for_each_entry_safe(encoder_cfg, encoder_tmp, &config->encoders, link)
+		vkms_config_destroy_encoder(config, encoder_cfg);
+
 	kfree_const(config->dev_name);
 	kfree(config);
 }
@@ -192,6 +202,20 @@ static bool valid_crtc_number(const struct vkms_config *config)
 	return true;
 }
 
+static bool valid_encoder_number(const struct vkms_config *config)
+{
+	struct drm_device *dev = config->dev ? &config->dev->drm : NULL;
+	size_t n_encoders;
+
+	n_encoders = list_count_nodes((struct list_head *)&config->encoders);
+	if (n_encoders <= 0 || n_encoders >= 32) {
+		drm_info(dev, "The number of encoders must be between 1 and 31\n");
+		return false;
+	}
+
+	return true;
+}
+
 bool vkms_config_is_valid(const struct vkms_config *config)
 {
 	struct vkms_config_crtc *crtc_cfg;
@@ -202,6 +226,9 @@ bool vkms_config_is_valid(const struct vkms_config *config)
 	if (!valid_crtc_number(config))
 		return false;
 
+	if (!valid_encoder_number(config))
+		return false;
+
 	if (!valid_plane_possible_crtcs(config))
 		return false;
 
@@ -222,6 +249,7 @@ static int vkms_config_show(struct seq_file *m, void *data)
 	const char *dev_name;
 	struct vkms_config_plane *plane_cfg;
 	struct vkms_config_crtc *crtc_cfg;
+	struct vkms_config_encoder *encoder_cfg;
 
 	dev_name = vkms_config_get_device_name((struct vkms_config *)vkmsdev->config);
 	seq_printf(m, "dev_name=%s\n", dev_name);
@@ -238,6 +266,9 @@ static int vkms_config_show(struct seq_file *m, void *data)
 			   vkms_config_crtc_get_writeback(crtc_cfg));
 	}
 
+	vkms_config_for_each_encoder(vkmsdev->config, encoder_cfg)
+		seq_puts(m, "encoder\n");
+
 	return 0;
 }
 
@@ -384,3 +415,26 @@ struct vkms_config_plane *vkms_config_crtc_cursor_plane(const struct vkms_config
 	return vkms_config_crtc_get_plane(config, crtc_cfg, DRM_PLANE_TYPE_CURSOR);
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_crtc_cursor_plane);
+
+struct vkms_config_encoder *vkms_config_create_encoder(struct vkms_config *config)
+{
+	struct vkms_config_encoder *encoder_cfg;
+
+	encoder_cfg = kzalloc(sizeof(*encoder_cfg), GFP_KERNEL);
+	if (!encoder_cfg)
+		return ERR_PTR(-ENOMEM);
+
+	encoder_cfg->config = config;
+	list_add_tail(&encoder_cfg->link, &config->encoders);
+
+	return encoder_cfg;
+}
+EXPORT_SYMBOL_IF_KUNIT(vkms_config_create_encoder);
+
+void vkms_config_destroy_encoder(struct vkms_config *config,
+				 struct vkms_config_encoder *encoder_cfg)
+{
+	list_del(&encoder_cfg->link);
+	kfree(encoder_cfg);
+}
+EXPORT_SYMBOL_IF_KUNIT(vkms_config_destroy_encoder);
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index ad303b34ee03..024cbed0e439 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -15,12 +15,14 @@
  * @dev_name: Name of the device
  * @planes: List of planes configured for the device
  * @crtcs: List of CRTCs configured for the device
+ * @encoders: List of encoders configured for the device
  * @dev: Used to store the current VKMS device. Only set when the device is instantiated.
  */
 struct vkms_config {
 	const char *dev_name;
 	struct list_head planes;
 	struct list_head crtcs;
+	struct list_head encoders;
 	struct vkms_device *dev;
 };
 
@@ -69,6 +71,24 @@ struct vkms_config_crtc {
 	struct vkms_output *crtc;
 };
 
+/**
+ * struct vkms_config_encoder
+ *
+ * @link: Link to the others encoders in vkms_config
+ * @config: The vkms_config this CRTC belongs to
+ * @encoder: Internal usage. This pointer should never be considered as valid.
+ *           It can be used to store a temporary reference to a VKMS encoder
+ *           during device creation. This pointer is not managed by the
+ *           configuration and must be managed by other means.
+ */
+struct vkms_config_encoder {
+	struct list_head link;
+	struct vkms_config *config;
+
+	/* Internal usage */
+	struct drm_encoder *encoder;
+};
+
 /**
  * vkms_config_for_each_plane - Iterate over the vkms_config planes
  * @config: &struct vkms_config pointer
@@ -85,6 +105,14 @@ struct vkms_config_crtc {
 #define vkms_config_for_each_crtc(config, crtc_cfg) \
 	list_for_each_entry((crtc_cfg), &(config)->crtcs, link)
 
+/**
+ * vkms_config_for_each_encoder - Iterate over the vkms_config encoders
+ * @config: &struct vkms_config pointer
+ * @encoder_cfg: &struct vkms_config_encoder pointer used as cursor
+ */
+#define vkms_config_for_each_encoder(config, encoder_cfg) \
+	list_for_each_entry((encoder_cfg), &(config)->encoders, link)
+
 /**
  * vkms_config_plane_for_each_possible_crtc - Iterate over the vkms_config_plane
  * possible CRTCs
@@ -286,4 +314,22 @@ struct vkms_config_plane *vkms_config_crtc_primary_plane(const struct vkms_confi
 struct vkms_config_plane *vkms_config_crtc_cursor_plane(const struct vkms_config *config,
 							struct vkms_config_crtc *crtc_cfg);
 
+/**
+ * vkms_config_create_encoder() - Add a new encoder configuration
+ * @config: Configuration to add the encoder to
+ *
+ * Returns:
+ * The new encoder configuration or an error. Call vkms_config_destroy_encoder()
+ * to free the returned encoder configuration.
+ */
+struct vkms_config_encoder *vkms_config_create_encoder(struct vkms_config *config);
+
+/**
+ * vkms_config_destroy_encoder() - Remove and free a encoder configuration
+ * @config: Configuration to remove the encoder from
+ * @encoder_cfg: Encoder configuration to destroy
+ */
+void vkms_config_destroy_encoder(struct vkms_config *config,
+				 struct vkms_config_encoder *encoder_cfg);
+
 #endif /* _VKMS_CONFIG_H_ */
-- 
2.48.1


