Return-Path: <linux-kernel+bounces-519152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3328A3989D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 250363B8B8B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113DB2405E6;
	Tue, 18 Feb 2025 10:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KI3BwauH"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E3D239595
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873554; cv=none; b=ecDXxKtq9Lo8I/BGNJPAR3SViFUi0y7cfLR+VJoGORo5w5r/6aGOtsa3qbi7p2zeO1Fw2CsxoS+PNIdj9l8paGwQ/5MiKzBQO9SaRzLzk3NSjfnOT0hh9l+T5wV6h7FlsDSNAqMFYMu7EZVH3CV+iix+KSYwYAZp5h5/tLeFxEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873554; c=relaxed/simple;
	bh=huf2dr0rnrn+qSAiniwyzYfjmcDfzmFX9b8o7j22qsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ghTf8CGDuktFX4jhPFZwjIGp3zhIsJ4m5LtFqNI2v0RbxS63A9F7M1sx54QUPMXp3G6ImXsyAvcIKS038EVGIVRDr1vx9X5QL9FHsp8dpWh8yRlsc8goqE3K8O0xbydAitv+R1e7YDTsLGLmcAWnbBy314TIZJNudDoW+NJClaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KI3BwauH; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38f2b7ce2e5so2096193f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 02:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739873550; x=1740478350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sp3iHvZITaZ2UTkf5VLRrARO1d57llPyzlqb0Su9fc=;
        b=KI3BwauHIh0VhO3qXkhf9p7Q4Bb7kZTDr83fiATyTRiYLDXsp2dYVGd7CgvjUgvzLG
         tYe2toJREmTfgh4IpWaEuic8EniNRit21Vo5yBN1HrwwVguRzgtqLNOAmZ0AQTV4a8Da
         kFgr3xr+WhtBeC5pW6Roha1R3yFH66YIWFwpJM4459RkWRkw240OUGm87Aac6cBxoDmv
         4fa9HukyY24Te6TmhZlED0n03HN5UQGugNVkepk0/z6b3LmQsf9n8AwfFL9F74PapYHR
         DCHKjpb/JT01z/CT058XijqHmPD1EUnmltjKJ+Zqi7mBUS9wvQOlU73qFmYqFmcoBquI
         FiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739873550; x=1740478350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8sp3iHvZITaZ2UTkf5VLRrARO1d57llPyzlqb0Su9fc=;
        b=laMofhyWPck0ddv0qGkdF4ptKTclynXMNqd+pRQE3qZXB6whIR0BVvUbt16azZ2BoQ
         dZ8mNxug9Zc8b0pDZJyDiR3u5znBrmXhvC9sxio0+G+FnvXBu7iGE0imif9eSkccFknJ
         fYxkxcm4dUh9rdLbOwczy48PpfsdQhxq9zolxFYGGHfyDDL/Lvsjn3ohoCkbI5cl8dCk
         agCEfLWVUu2QLCo7u1y1XHrDuIy9inbc27PZ3DV8psdL34liVV2a+xJ2IpNE9ct0Sa+3
         BtPZw+vUdbRIniUKC/xFke41HvFh/6p75iCByz+bjtsOPcPThHBHCQrMLCe6owLPxx5U
         YYzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUc3cNTClqBb5t++9Ke9zKy8KmFe3PQlI/n87ybA+cBT+MYxPonr8ViKzhKjQKvvd6GKz5SyCcClY9SyOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy33yDmaXdpnRxre1B5y79zJHBXG2jL+Epp0b4TnqQCrarntyKp
	48G8qGN28NbFj93zqX3shuZOlrrM6OiTW0jnQF0vkbR8LEpFJoP0
X-Gm-Gg: ASbGncsI+c5kWiDZWgsa/c03jgNzy659S/S/HkTbrK/tCdAKOG+6OQbPDtJTWSkKs1Y
	KpNTbQYwRhqqF9YVBTLDd/Q+UX35v50kK9kIaeweHy8xBTwNPJk/9ZElztwp/m8N4l7c71z2NRV
	LM4s985HoxQuL6I2iz2ycyd6/U2TfCgvtRsEcNQ5imYjjvDeoEsoeRkup14vLDVDFT2ttc1Pk/w
	5H/rtUdJt85TUu1jgW/8f8nFtpyKLpZXY/sUVCfA1FOKauUL1GjyONP151ZrUmZQ4zgYjO6fsyd
	EcCFF3L/1eQSS6u94g==
X-Google-Smtp-Source: AGHT+IG3UBFjjpNjfCkciQmHx67BD5Kxu4AYnE3/HFdgtuwzCgXp79IVB1vN+tAEgJYejdIjkM9LKA==
X-Received: by 2002:a05:6000:1b02:b0:38f:2bee:e112 with SMTP id ffacd0b85a97d-38f341708a2mr11199986f8f.45.1739873549512;
        Tue, 18 Feb 2025 02:12:29 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5e92sm14749720f8f.66.2025.02.18.02.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 02:12:28 -0800 (PST)
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
Subject: [PATCH v4 08/14] drm/vkms: Allow to configure multiple planes
Date: Tue, 18 Feb 2025 11:12:08 +0100
Message-ID: <20250218101214.5790-9-jose.exposito89@gmail.com>
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

Add a list of planes to vkms_config and create as many planes as
configured during output initialization.

For backwards compatibility, add one primary plane and, if configured,
one cursor plane and NUM_OVERLAY_PLANES planes to the default
configuration.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 .clang-format                                 |   1 +
 drivers/gpu/drm/vkms/tests/vkms_config_test.c | 161 +++++++++++++++++-
 drivers/gpu/drm/vkms/vkms_config.c            | 127 +++++++++++++-
 drivers/gpu/drm/vkms/vkms_config.h            |  75 +++++++-
 drivers/gpu/drm/vkms/vkms_output.c            |  42 ++---
 5 files changed, 370 insertions(+), 36 deletions(-)

diff --git a/.clang-format b/.clang-format
index fe1aa1a30d40..c585d2a5b395 100644
--- a/.clang-format
+++ b/.clang-format
@@ -690,6 +690,7 @@ ForEachMacros:
   - 'v4l2_m2m_for_each_src_buf'
   - 'v4l2_m2m_for_each_src_buf_safe'
   - 'virtio_device_for_each_vq'
+  - 'vkms_config_for_each_plane'
   - 'while_for_each_ftrace_op'
   - 'xa_for_each'
   - 'xa_for_each_marked'
diff --git a/drivers/gpu/drm/vkms/tests/vkms_config_test.c b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
index 6e07139d261c..116db01ba8a0 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_config_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
@@ -6,6 +6,27 @@
 
 MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
 
+static size_t vkms_config_get_num_planes(struct vkms_config *config)
+{
+	struct vkms_config_plane *plane_cfg;
+	size_t count = 0;
+
+	vkms_config_for_each_plane(config, plane_cfg)
+		count++;
+
+	return count;
+}
+
+static struct vkms_config_plane *get_first_plane(struct vkms_config *config)
+{
+	struct vkms_config_plane *plane_cfg;
+
+	vkms_config_for_each_plane(config, plane_cfg)
+		return plane_cfg;
+
+	return NULL;
+}
+
 struct default_config_case {
 	bool enable_cursor;
 	bool enable_writeback;
@@ -24,6 +45,10 @@ static void vkms_config_test_empty_config(struct kunit *test)
 	dev_name = NULL;
 	KUNIT_EXPECT_STREQ(test, vkms_config_get_device_name(config), "test");
 
+	KUNIT_EXPECT_EQ(test, vkms_config_get_num_planes(config), 0);
+
+	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
+
 	vkms_config_destroy(config);
 }
 
@@ -44,16 +69,145 @@ static void vkms_config_test_default_config(struct kunit *test)
 {
 	const struct default_config_case *params = test->param_value;
 	struct vkms_config *config;
+	struct vkms_config_plane *plane_cfg;
+	int n_primaries = 0;
+	int n_cursors = 0;
+	int n_overlays = 0;
 
 	config = vkms_config_default_create(params->enable_cursor,
 					    params->enable_writeback,
 					    params->enable_overlay);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
 
-	KUNIT_EXPECT_EQ(test, config->cursor, params->enable_cursor);
 	KUNIT_EXPECT_EQ(test, config->writeback, params->enable_writeback);
-	KUNIT_EXPECT_EQ(test, config->overlay, params->enable_overlay);
 
+	/* Planes */
+	vkms_config_for_each_plane(config, plane_cfg) {
+		switch (vkms_config_plane_get_type(plane_cfg)) {
+		case DRM_PLANE_TYPE_PRIMARY:
+			n_primaries++;
+			break;
+		case DRM_PLANE_TYPE_CURSOR:
+			n_cursors++;
+			break;
+		case DRM_PLANE_TYPE_OVERLAY:
+			n_overlays++;
+			break;
+		default:
+			KUNIT_FAIL_AND_ABORT(test, "Unknown plane type");
+		}
+	}
+	KUNIT_EXPECT_EQ(test, n_primaries, 1);
+	KUNIT_EXPECT_EQ(test, n_cursors, params->enable_cursor ? 1 : 0);
+	KUNIT_EXPECT_EQ(test, n_overlays, params->enable_overlay ? 8 : 0);
+
+	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
+
+	vkms_config_destroy(config);
+}
+
+static void vkms_config_test_get_planes(struct kunit *test)
+{
+	struct vkms_config *config;
+	struct vkms_config_plane *plane_cfg;
+	struct vkms_config_plane *plane_cfg1, *plane_cfg2;
+	int n_planes = 0;
+
+	config = vkms_config_create("test");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
+
+	vkms_config_for_each_plane(config, plane_cfg)
+		n_planes++;
+	KUNIT_ASSERT_EQ(test, n_planes, 0);
+
+	plane_cfg1 = vkms_config_create_plane(config);
+	vkms_config_for_each_plane(config, plane_cfg) {
+		n_planes++;
+		if (plane_cfg != plane_cfg1)
+			KUNIT_FAIL(test, "Unexpected plane");
+	}
+	KUNIT_ASSERT_EQ(test, n_planes, 1);
+	n_planes = 0;
+
+	plane_cfg2 = vkms_config_create_plane(config);
+	vkms_config_for_each_plane(config, plane_cfg) {
+		n_planes++;
+		if (plane_cfg != plane_cfg1 && plane_cfg != plane_cfg2)
+			KUNIT_FAIL(test, "Unexpected plane");
+	}
+	KUNIT_ASSERT_EQ(test, n_planes, 2);
+	n_planes = 0;
+
+	vkms_config_destroy_plane(plane_cfg1);
+	vkms_config_for_each_plane(config, plane_cfg) {
+		n_planes++;
+		if (plane_cfg != plane_cfg2)
+			KUNIT_FAIL(test, "Unexpected plane");
+	}
+	KUNIT_ASSERT_EQ(test, n_planes, 1);
+
+	vkms_config_destroy(config);
+}
+
+static void vkms_config_test_invalid_plane_number(struct kunit *test)
+{
+	struct vkms_config *config;
+	struct vkms_config_plane *plane_cfg;
+	int n;
+
+	config = vkms_config_default_create(false, false, false);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
+
+	/* Invalid: No planes */
+	plane_cfg = get_first_plane(config);
+	vkms_config_destroy_plane(plane_cfg);
+	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
+
+	/* Invalid: Too many planes */
+	for (n = 0; n <= 32; n++)
+		vkms_config_create_plane(config);
+
+	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
+
+	vkms_config_destroy(config);
+}
+
+static void vkms_config_test_valid_plane_type(struct kunit *test)
+{
+	struct vkms_config *config;
+	struct vkms_config_plane *plane_cfg;
+
+	config = vkms_config_default_create(false, false, false);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
+
+	plane_cfg = get_first_plane(config);
+	vkms_config_destroy_plane(plane_cfg);
+
+	/* Invalid: No primary plane */
+	plane_cfg = vkms_config_create_plane(config);
+	vkms_config_plane_set_type(plane_cfg, DRM_PLANE_TYPE_OVERLAY);
+	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
+
+	/* Invalid: Multiple primary planes */
+	plane_cfg = vkms_config_create_plane(config);
+	vkms_config_plane_set_type(plane_cfg, DRM_PLANE_TYPE_PRIMARY);
+	plane_cfg = vkms_config_create_plane(config);
+	vkms_config_plane_set_type(plane_cfg, DRM_PLANE_TYPE_PRIMARY);
+	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
+
+	/* Valid: One primary plane */
+	vkms_config_destroy_plane(plane_cfg);
+	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
+
+	/* Invalid: Multiple cursor planes */
+	plane_cfg = vkms_config_create_plane(config);
+	vkms_config_plane_set_type(plane_cfg, DRM_PLANE_TYPE_CURSOR);
+	plane_cfg = vkms_config_create_plane(config);
+	vkms_config_plane_set_type(plane_cfg, DRM_PLANE_TYPE_CURSOR);
+	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
+
+	/* Valid: One primary and one cursor plane */
+	vkms_config_destroy_plane(plane_cfg);
 	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
 
 	vkms_config_destroy(config);
@@ -63,6 +217,9 @@ static struct kunit_case vkms_config_test_cases[] = {
 	KUNIT_CASE(vkms_config_test_empty_config),
 	KUNIT_CASE_PARAM(vkms_config_test_default_config,
 			 default_config_gen_params),
+	KUNIT_CASE(vkms_config_test_get_planes),
+	KUNIT_CASE(vkms_config_test_invalid_plane_number),
+	KUNIT_CASE(vkms_config_test_valid_plane_type),
 	{}
 };
 
diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index d1947537834c..3c3f5cf79058 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -22,6 +22,8 @@ struct vkms_config *vkms_config_create(const char *dev_name)
 		return ERR_PTR(-ENOMEM);
 	}
 
+	INIT_LIST_HEAD(&config->planes);
+
 	return config;
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_create);
@@ -31,28 +33,116 @@ struct vkms_config *vkms_config_default_create(bool enable_cursor,
 					       bool enable_overlay)
 {
 	struct vkms_config *config;
+	struct vkms_config_plane *plane_cfg;
+	int n;
 
 	config = vkms_config_create(DEFAULT_DEVICE_NAME);
 	if (IS_ERR(config))
 		return config;
 
-	config->cursor = enable_cursor;
 	config->writeback = enable_writeback;
-	config->overlay = enable_overlay;
+
+	plane_cfg = vkms_config_create_plane(config);
+	if (IS_ERR(plane_cfg))
+		goto err_alloc;
+	vkms_config_plane_set_type(plane_cfg, DRM_PLANE_TYPE_PRIMARY);
+
+	if (enable_overlay) {
+		for (n = 0; n < NUM_OVERLAY_PLANES; n++) {
+			plane_cfg = vkms_config_create_plane(config);
+			if (IS_ERR(plane_cfg))
+				goto err_alloc;
+			vkms_config_plane_set_type(plane_cfg,
+						   DRM_PLANE_TYPE_OVERLAY);
+		}
+	}
+
+	if (enable_cursor) {
+		plane_cfg = vkms_config_create_plane(config);
+		if (IS_ERR(plane_cfg))
+			goto err_alloc;
+		vkms_config_plane_set_type(plane_cfg, DRM_PLANE_TYPE_CURSOR);
+	}
 
 	return config;
+
+err_alloc:
+	vkms_config_destroy(config);
+	return ERR_PTR(-ENOMEM);
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_default_create);
 
 void vkms_config_destroy(struct vkms_config *config)
 {
+	struct vkms_config_plane *plane_cfg, *plane_tmp;
+
+	list_for_each_entry_safe(plane_cfg, plane_tmp, &config->planes, link)
+		vkms_config_destroy_plane(plane_cfg);
+
 	kfree_const(config->dev_name);
 	kfree(config);
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_destroy);
 
+static bool valid_plane_number(const struct vkms_config *config)
+{
+	struct drm_device *dev = config->dev ? &config->dev->drm : NULL;
+	size_t n_planes;
+
+	n_planes = list_count_nodes((struct list_head *)&config->planes);
+	if (n_planes <= 0 || n_planes >= 32) {
+		drm_info(dev, "The number of planes must be between 1 and 31\n");
+		return false;
+	}
+
+	return true;
+}
+
+static bool valid_plane_type(const struct vkms_config *config)
+{
+	struct drm_device *dev = config->dev ? &config->dev->drm : NULL;
+	struct vkms_config_plane *plane_cfg;
+	bool has_primary_plane = false;
+	bool has_cursor_plane = false;
+
+	vkms_config_for_each_plane(config, plane_cfg) {
+		enum drm_plane_type type;
+
+		type = vkms_config_plane_get_type(plane_cfg);
+
+		if (type == DRM_PLANE_TYPE_PRIMARY) {
+			if (has_primary_plane) {
+				drm_info(dev, "Multiple primary planes\n");
+				return false;
+			}
+
+			has_primary_plane = true;
+		} else if (type == DRM_PLANE_TYPE_CURSOR) {
+			if (has_cursor_plane) {
+				drm_info(dev, "Multiple cursor planes\n");
+				return false;
+			}
+
+			has_cursor_plane = true;
+		}
+	}
+
+	if (!has_primary_plane) {
+		drm_info(dev, "Primary plane not found\n");
+		return false;
+	}
+
+	return true;
+}
+
 bool vkms_config_is_valid(const struct vkms_config *config)
 {
+	if (!valid_plane_number(config))
+		return false;
+
+	if (!valid_plane_type(config))
+		return false;
+
 	return true;
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_is_valid);
@@ -63,12 +153,17 @@ static int vkms_config_show(struct seq_file *m, void *data)
 	struct drm_device *dev = entry->dev;
 	struct vkms_device *vkmsdev = drm_device_to_vkms_device(dev);
 	const char *dev_name;
+	struct vkms_config_plane *plane_cfg;
 
 	dev_name = vkms_config_get_device_name((struct vkms_config *)vkmsdev->config);
 	seq_printf(m, "dev_name=%s\n", dev_name);
 	seq_printf(m, "writeback=%d\n", vkmsdev->config->writeback);
-	seq_printf(m, "cursor=%d\n", vkmsdev->config->cursor);
-	seq_printf(m, "overlay=%d\n", vkmsdev->config->overlay);
+
+	vkms_config_for_each_plane(vkmsdev->config, plane_cfg) {
+		seq_puts(m, "plane:\n");
+		seq_printf(m, "\ttype=%d\n",
+			   vkms_config_plane_get_type(plane_cfg));
+	}
 
 	return 0;
 }
@@ -82,3 +177,27 @@ void vkms_config_register_debugfs(struct vkms_device *vkms_device)
 	drm_debugfs_add_files(&vkms_device->drm, vkms_config_debugfs_list,
 			      ARRAY_SIZE(vkms_config_debugfs_list));
 }
+
+struct vkms_config_plane *vkms_config_create_plane(struct vkms_config *config)
+{
+	struct vkms_config_plane *plane_cfg;
+
+	plane_cfg = kzalloc(sizeof(*plane_cfg), GFP_KERNEL);
+	if (!plane_cfg)
+		return ERR_PTR(-ENOMEM);
+
+	plane_cfg->config = config;
+	vkms_config_plane_set_type(plane_cfg, DRM_PLANE_TYPE_OVERLAY);
+
+	list_add_tail(&plane_cfg->link, &config->planes);
+
+	return plane_cfg;
+}
+EXPORT_SYMBOL_IF_KUNIT(vkms_config_create_plane);
+
+void vkms_config_destroy_plane(struct vkms_config_plane *plane_cfg)
+{
+	list_del(&plane_cfg->link);
+	kfree(plane_cfg);
+}
+EXPORT_SYMBOL_IF_KUNIT(vkms_config_destroy_plane);
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index 31c758631c37..613e98760640 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -3,6 +3,7 @@
 #ifndef _VKMS_CONFIG_H_
 #define _VKMS_CONFIG_H_
 
+#include <linux/list.h>
 #include <linux/types.h>
 
 #include "vkms_drv.h"
@@ -12,18 +13,46 @@
  *
  * @dev_name: Name of the device
  * @writeback: If true, a writeback buffer can be attached to the CRTC
- * @cursor: If true, a cursor plane is created in the VKMS device
- * @overlay: If true, NUM_OVERLAY_PLANES will be created for the VKMS device
+ * @planes: List of planes configured for the device
  * @dev: Used to store the current VKMS device. Only set when the device is instantiated.
  */
 struct vkms_config {
 	const char *dev_name;
 	bool writeback;
-	bool cursor;
-	bool overlay;
+	struct list_head planes;
 	struct vkms_device *dev;
 };
 
+/**
+ * struct vkms_config_plane
+ *
+ * @link: Link to the others planes in vkms_config
+ * @config: The vkms_config this plane belongs to
+ * @type: Type of the plane. The creator of configuration needs to ensures that
+ *        at least one primary plane is present.
+ * @plane: Internal usage. This pointer should never be considered as valid.
+ *         It can be used to store a temporary reference to a VKMS plane during
+ *         device creation. This pointer is not managed by the configuration and
+ *         must be managed by other means.
+ */
+struct vkms_config_plane {
+	struct list_head link;
+	struct vkms_config *config;
+
+	enum drm_plane_type type;
+
+	/* Internal usage */
+	struct vkms_plane *plane;
+};
+
+/**
+ * vkms_config_for_each_plane - Iterate over the vkms_config planes
+ * @config: &struct vkms_config pointer
+ * @plane_cfg: &struct vkms_config_plane pointer used as cursor
+ */
+#define vkms_config_for_each_plane(config, plane_cfg) \
+	list_for_each_entry((plane_cfg), &(config)->planes, link)
+
 /**
  * vkms_config_create() - Create a new VKMS configuration
  * @dev_name: Name of the device
@@ -84,4 +113,42 @@ bool vkms_config_is_valid(const struct vkms_config *config);
  */
 void vkms_config_register_debugfs(struct vkms_device *vkms_device);
 
+/**
+ * vkms_config_create_plane() - Add a new plane configuration
+ * @config: Configuration to add the plane to
+ *
+ * Returns:
+ * The new plane configuration or an error. Call vkms_config_destroy_plane() to
+ * free the returned plane configuration.
+ */
+struct vkms_config_plane *vkms_config_create_plane(struct vkms_config *config);
+
+/**
+ * vkms_config_destroy_plane() - Remove and free a plane configuration
+ * @plane_cfg: Plane configuration to destroy
+ */
+void vkms_config_destroy_plane(struct vkms_config_plane *plane_cfg);
+
+/**
+ * vkms_config_plane_type() - Return the plane type
+ * @plane_cfg: Plane to get the type from
+ */
+static inline enum drm_plane_type
+vkms_config_plane_get_type(struct vkms_config_plane *plane_cfg)
+{
+	return plane_cfg->type;
+}
+
+/**
+ * vkms_config_plane_set_type() - Set the plane type
+ * @plane_cfg: Plane to set the type to
+ * @type: New plane type
+ */
+static inline void
+vkms_config_plane_set_type(struct vkms_config_plane *plane_cfg,
+			   enum drm_plane_type type)
+{
+	plane_cfg->type = type;
+}
+
 #endif /* _VKMS_CONFIG_H_ */
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 414cc933af41..08ea691db299 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -11,28 +11,29 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 	struct vkms_connector *connector;
 	struct drm_encoder *encoder;
 	struct vkms_output *output;
-	struct vkms_plane *primary, *overlay, *cursor = NULL;
+	struct vkms_plane *primary = NULL, *cursor = NULL;
+	struct vkms_config_plane *plane_cfg;
 	int ret;
 	int writeback;
-	unsigned int n;
 
 	if (!vkms_config_is_valid(vkmsdev->config))
 		return -EINVAL;
 
-	/*
-	 * Initialize used plane. One primary plane is required to perform the composition.
-	 *
-	 * The overlay and cursor planes are not mandatory, but can be used to perform complex
-	 * composition.
-	 */
-	primary = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_PRIMARY);
-	if (IS_ERR(primary))
-		return PTR_ERR(primary);
+	vkms_config_for_each_plane(vkmsdev->config, plane_cfg) {
+		enum drm_plane_type type;
 
-	if (vkmsdev->config->cursor) {
-		cursor = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_CURSOR);
-		if (IS_ERR(cursor))
-			return PTR_ERR(cursor);
+		type = vkms_config_plane_get_type(plane_cfg);
+
+		plane_cfg->plane = vkms_plane_init(vkmsdev, type);
+		if (IS_ERR(plane_cfg->plane)) {
+			DRM_DEV_ERROR(dev->dev, "Failed to init vkms plane\n");
+			return PTR_ERR(plane_cfg->plane);
+		}
+
+		if (type == DRM_PLANE_TYPE_PRIMARY)
+			primary = plane_cfg->plane;
+		else if (type == DRM_PLANE_TYPE_CURSOR)
+			cursor = plane_cfg->plane;
 	}
 
 	output = vkms_crtc_init(dev, &primary->base,
@@ -42,17 +43,6 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 		return PTR_ERR(output);
 	}
 
-	if (vkmsdev->config->overlay) {
-		for (n = 0; n < NUM_OVERLAY_PLANES; n++) {
-			overlay = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_OVERLAY);
-			if (IS_ERR(overlay)) {
-				DRM_DEV_ERROR(dev->dev, "Failed to init vkms plane\n");
-				return PTR_ERR(overlay);
-			}
-			overlay->base.possible_crtcs = drm_crtc_mask(&output->crtc);
-		}
-	}
-
 	connector = vkms_connector_init(vkmsdev);
 	if (IS_ERR(connector)) {
 		DRM_ERROR("Failed to init connector\n");
-- 
2.48.1


