Return-Path: <linux-kernel+bounces-519155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BE7A39886
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7B06176C2A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5091C241112;
	Tue, 18 Feb 2025 10:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpZmlfPH"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F05023AE79
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873558; cv=none; b=nTM5nZKKobuDRFjFXSiOby2PF/hhJSPRPGpexuVnoFjXvUdUyOdt4QIxrjBx9PowlQ+m0F4W02wjsL20rtAMBF/oxo4EtseO6j3ClWEfgLgpXSBP//42rpchvME2NWyPAjUj0tj3XYko0rl3yAJaSBWmT1xBY3h0TWgZ4yt/tiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873558; c=relaxed/simple;
	bh=nulajHEEERR1365r/TFxLjMyBU3+56+P2YeeYKvLVzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oIqMjZQDCLT9VmXHdLEQeEtvOr3n+sBGBncTNuE0eI8gkY3xsK1KbpoIxI5O83FFV78PMuF89Cc+VlGLz5RdmT68QVHKbyBm2/3kPv1XbNctaakeu1JgomUoTXWK442AJIGOgIU67coVbeSo2KAqPj8lMRbnK1Oa4+5SmRXmu4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpZmlfPH; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so35074755e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 02:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739873552; x=1740478352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBjVklZQ9OCwyQwOKI4fxIHrYYWEcFK9JsNbJ51zcI0=;
        b=cpZmlfPHbHNJwsviaf0dtrg0L8L8aqRHwcu7YssHDbPxGdHaU3MoNlIdqWkhCgMLO7
         SXUhQj1nQfBOVxGlgJqmRsGQEkLwsPVBVplzZcDaffIMfMetWGgQM6Svkbb+ezX3zA1e
         9ZpGzUsvkYNTaxvEcrBz9cQQzFZLBq5ESW8GP2MFD8W1yoI4H4X7V4l6rSxp5IY4CyD6
         EISZ4ysiIySEXBAIIBqxQceBlFktDsvihNDs1LOsW0KYur08qyMu2TtntgBjsrzRNihz
         22uTZPcC4Ec4qRZ4Y2guWYOCGpZ0/QNHtZrLlHvVZFY5yep7fmDachZixvd/FoblKKL7
         aDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739873552; x=1740478352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KBjVklZQ9OCwyQwOKI4fxIHrYYWEcFK9JsNbJ51zcI0=;
        b=o1yBTCawXs5G7h88KZIGikcUbBEFuXSfq09gnGzuOx6FTNbJlncVHZXFmSVs0VtFT3
         HufWohfiOQ4ZgVCO6n8GbCoMLZBhwWfF/+zP2RCG2/9elxtvl8OkHNymL314f6ZSYCSR
         RcF9bINmNk1u1N8lT81Q957f7yFzdLDYbNZRHH2i5ZCxh7/RUTNEXXy3D/hZptoubNbn
         xghiVygEBwQ+Kr6eAi0p9DSGYAi/uxGQ7yDBlVQf5ld3MpHDqOyzlATeY0x7Jy99qrSb
         QFsVHYYDDAKq/PTMVoPLaWd9fcFkkAWe1ht1/SsY61cl9LS5aOBBz7Y/rq+DKMeJZDlB
         H5lA==
X-Forwarded-Encrypted: i=1; AJvYcCXaBLaYmZXA+ONejkPoFAL0dPokQaoWXu3gyivAs7GC2apn53QIQS2R2VASgualisKg5cHNiEXi39CJPro=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTILm228BfDEl6p01gssCvQVGgi7LC4LlLcQvsw3jMR3/Hrexu
	bjXUmP1Uv5BoaxGBPUyOw0V2ppfMClE8hejKGE/ctyjoKq+RxyZ3
X-Gm-Gg: ASbGncvQNT6ksELh37Lk/Q0/dLEKm5+JAMmM3lPZZO3beHGgTiIYIvWBameHRCmrsu6
	Ya5I00/gZxmSAWu4pTTiOF0BRrrH9jjdktz/QZzcLoSYIX3n+xwuCna/1Y4PUa9S8Xqz97JFRq7
	GGNd8icU9JIZ+M2ekj/wLOiRfPbO96rqQsQMtSxzEJ+u3AP6jPypNzxghkTBGHrKuh7tNOcXLiN
	PomiQ8p+nbLhAouyaWhjdqzYf5G4k70JNa3aAKLXv1KVCWSCuRcOwkgyBBlKJxDUJVF4w9TwC02
	G3bVtncFEDr6bvjlEw==
X-Google-Smtp-Source: AGHT+IHJC1ByGIX1z9OVlh16VS4LiaX4eyKthsNzPXOgFC97fhU0S3oxz12tutVqdaCqGewFseuBrg==
X-Received: by 2002:a5d:59a7:0:b0:38f:3009:61d7 with SMTP id ffacd0b85a97d-38f33f11a04mr8854988f8f.4.1739873552409;
        Tue, 18 Feb 2025 02:12:32 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5e92sm14749720f8f.66.2025.02.18.02.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 02:12:32 -0800 (PST)
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
Subject: [PATCH v4 11/14] drm/vkms: Allow to configure multiple encoders
Date: Tue, 18 Feb 2025 11:12:11 +0100
Message-ID: <20250218101214.5790-12-jose.exposito89@gmail.com>
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

Add a list of encoders to vkms_config and helper functions to add and
remove as many encoders as wanted.

For backwards compatibility, add one encoder to the default
configuration.

A future patch will allow to attach encoders and CRTCs, but for the
moment there are no changes in the way the output is configured.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 .clang-format                                 |  1 +
 drivers/gpu/drm/vkms/tests/vkms_config_test.c | 94 +++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_config.c            | 54 +++++++++++
 drivers/gpu/drm/vkms/vkms_config.h            | 46 +++++++++
 4 files changed, 195 insertions(+)

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
index 0997ea924ab7..fa8b4f23cb49 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_config_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
@@ -17,6 +17,17 @@ static size_t vkms_config_get_num_planes(struct vkms_config *config)
 	return count;
 }
 
+static size_t vkms_config_get_num_encoders(struct vkms_config *config)
+{
+	struct vkms_config_encoder *encoder_cfg;
+	size_t count = 0;
+
+	vkms_config_for_each_encoder(config, encoder_cfg)
+		count++;
+
+	return count;
+}
+
 static struct vkms_config_plane *get_first_plane(struct vkms_config *config)
 {
 	struct vkms_config_plane *plane_cfg;
@@ -37,6 +48,16 @@ static struct vkms_config_crtc *get_first_crtc(struct vkms_config *config)
 	return NULL;
 }
 
+static struct vkms_config_encoder *get_first_encoder(struct vkms_config *config)
+{
+	struct vkms_config_encoder *encoder_cfg;
+
+	vkms_config_for_each_encoder(config, encoder_cfg)
+		return encoder_cfg;
+
+	return NULL;
+}
+
 struct default_config_case {
 	bool enable_cursor;
 	bool enable_writeback;
@@ -57,6 +78,7 @@ static void vkms_config_test_empty_config(struct kunit *test)
 
 	KUNIT_EXPECT_EQ(test, vkms_config_get_num_planes(config), 0);
 	KUNIT_EXPECT_EQ(test, vkms_config_get_num_crtcs(config), 0);
+	KUNIT_EXPECT_EQ(test, vkms_config_get_num_encoders(config), 0);
 
 	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
 
@@ -130,6 +152,9 @@ static void vkms_config_test_default_config(struct kunit *test)
 		KUNIT_EXPECT_EQ(test, n_possible_crtcs, 1);
 	}
 
+	/* Encoders */
+	KUNIT_EXPECT_EQ(test, vkms_config_get_num_encoders(config), 1);
+
 	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
 
 	vkms_config_destroy(config);
@@ -215,6 +240,50 @@ static void vkms_config_test_get_crtcs(struct kunit *test)
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
@@ -350,6 +419,29 @@ static void vkms_config_test_invalid_crtc_number(struct kunit *test)
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
+	encoder_cfg = get_first_encoder(config);
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
@@ -514,10 +606,12 @@ static struct kunit_case vkms_config_test_cases[] = {
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


