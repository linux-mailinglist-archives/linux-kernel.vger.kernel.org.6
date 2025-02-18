Return-Path: <linux-kernel+bounces-519158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28542A3988A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7768916D60B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9512417DF;
	Tue, 18 Feb 2025 10:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ic93PRDT"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1385F23AE7D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873560; cv=none; b=CQp5cOnBzgzcjpE0AxPXv1ZLGdgRDrrLTqmsCnBBbjIB3KAuQI2dmBLsAL8veqa4puuWyBhgkN+f+39fkwVDDNI31h3AVWo8Jt9416PmjORhdSlo6xJc4JLj/6LnGMh43kqR5w21KVr+XF7PMN1dhoAJQcu1PMRPAj1nUxdkY98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873560; c=relaxed/simple;
	bh=Yq28pqHTePQp7L+t1SrFXFbJAQm7/bMZO8hygotWTW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pp+Pp6Zcp7QZmLm1eE1HHykiVcX+DCLEjWFSv1GXMwMUgtn9vh+RjzcmyrO1mne4ESZmxdJGknoRpiSF7eC765vN6ioRUmOTw2Mx13Rc/CB8NDVOcyTYNar02fCo1e0UVE/olq2pTm4wSOBzKOR79LCXGOJIg+TJbrXLVWM8Ezg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ic93PRDT; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38f325dd9e6so1681464f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 02:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739873556; x=1740478356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+xCFrURTppY63NVOBwqa8Qg4TsqZlxYnGgiayzWMgE=;
        b=ic93PRDTQUdXI85z/G0UCX4jtayNpM4LrrMKkGLkygED2v0TsiyziYtfmrMfVVkHXJ
         gs8j3419U+xTjwAt3ENc0ljlp3LjyUUOdCR+ps7/TcJcw8/NYoRECvMhQrjOykCRljpC
         Ew/m3ZObMazVuAXmyH/OcJp31T2n2UKALT/4KimqEPAbQmCrdWt/1xP5LrPwohttbVMS
         qNndeybSX5/Hib4i/nr43NiXECuivabEssj8QtxNt32lhTpE6EPdfp6U5ce4tD9AN2qe
         LG6GtSpuB00Ki4GAOGLWhLsnMVS+gy23NrcYfDd9tMA5Zyij5pTFleW9KoecQIVdtgpw
         +Imw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739873556; x=1740478356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+xCFrURTppY63NVOBwqa8Qg4TsqZlxYnGgiayzWMgE=;
        b=eqSrEs6fo19dMYcyIt3BRf3TWoLMOFG5NvJ0yUiIlEaTtXSO0tOGjKLpocEFWRJRbo
         ywG10RUFuI7j7Lr4DNKi96Iw7LhHfj2G4DteUNLeDrg7iVxdY7SIZMyAayvoH5oaR0xw
         5UXtHL9T+RIZmCGP+lfdwCNQaMcCYJHqa4jxCxqCrHDCg2YTkeTHMNNt6ezzfnDufidz
         ghXE5AVkpXqulkvFt6PQktcezc2fCt0w4woiTMZQ7NfZtajUJK6+B1FJsYHWjInt9ov/
         DtFgC3RhzOdvNKOSQafP4K6NWHGiP8uBcv83SgMIRQh8ZKp/Kivbdvfto9cobhsYH7jd
         9hKg==
X-Forwarded-Encrypted: i=1; AJvYcCWnit7NI2WDuAMUCXs9XRhEccColGm+cGDzJrUgLJfUdNQLSVx20yGYdRd/FkIcv4idB9PKqmncexgVg9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWDAGBbbq/d0ynduGy3IcwqwonZNdcMCCu0U0TNWqRUpU76TQF
	4BTpfH1OXpl+bu8qZFjwby44v4jiwKrPV1dJhH/eWRwW1spIosba
X-Gm-Gg: ASbGncufKeZA4s2m8qELzgYhrnD1SWCEbSrndrUeU5j7YXNOmLoXo+VlJknglqRLI07
	uGdp3k4AmlHF9cYESQPOvrYomAPY955ZAuzXs1RC2gDWTxj/vzGjaBVjN9FeS1XpRSQfPXV071Z
	AJNSwqoZCaNicK4Q1z5yFmt1rNIdYzLJSIAB8ATKtP1oIQLC6g8CMWgo6I2OD2y+qOJkp1ovJ2f
	oHru9gZ4GSp1F1/VjQC45yOQiWNz6phQLXcRqKI26rton1BGgikKQJqkb7FSy2SgNHu8Hi2Tiiy
	gI+Jpiz78nFSz+ba7w==
X-Google-Smtp-Source: AGHT+IH1fgM5ly1pG4PQnHCQHvU2qjuyGPQ9TH5SuTOagsYNNt7IikoLHxrhYwZdCW6vd8EuNSSdpQ==
X-Received: by 2002:a5d:598b:0:b0:38f:4e6e:22 with SMTP id ffacd0b85a97d-38f4e6e01a3mr4986452f8f.48.1739873556184;
        Tue, 18 Feb 2025 02:12:36 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5e92sm14749720f8f.66.2025.02.18.02.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 02:12:35 -0800 (PST)
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
Subject: [PATCH v4 14/14] drm/vkms: Allow to attach connectors and encoders
Date: Tue, 18 Feb 2025 11:12:14 +0100
Message-ID: <20250218101214.5790-15-jose.exposito89@gmail.com>
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

Add a list of possible encoders to the connector configuration and
helpers to attach and detach them.

Now that the default configuration has its connector and encoder
correctly, configure the output following the configuration.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 .clang-format                                 |   1 +
 drivers/gpu/drm/vkms/tests/vkms_config_test.c | 102 ++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_config.c            |  64 +++++++++++
 drivers/gpu/drm/vkms/vkms_config.h            |  29 +++++
 drivers/gpu/drm/vkms/vkms_output.c            |  33 +++---
 5 files changed, 216 insertions(+), 13 deletions(-)

diff --git a/.clang-format b/.clang-format
index ca49832993c5..7630990aa07a 100644
--- a/.clang-format
+++ b/.clang-format
@@ -694,6 +694,7 @@ ForEachMacros:
   - 'vkms_config_for_each_crtc'
   - 'vkms_config_for_each_encoder'
   - 'vkms_config_for_each_plane'
+  - 'vkms_config_connector_for_each_possible_encoder'
   - 'vkms_config_encoder_for_each_possible_crtc'
   - 'vkms_config_plane_for_each_possible_crtc'
   - 'while_for_each_ftrace_op'
diff --git a/drivers/gpu/drm/vkms/tests/vkms_config_test.c b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
index 610bcde3e018..ff4566cf9925 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_config_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
@@ -584,12 +584,32 @@ static void vkms_config_test_invalid_connector_number(struct kunit *test)
 	vkms_config_destroy(config);
 }
 
+static void vkms_config_test_valid_connector_possible_encoders(struct kunit *test)
+{
+	struct vkms_config *config;
+	struct vkms_config_encoder *encoder_cfg;
+	struct vkms_config_connector *connector_cfg;
+
+	config = vkms_config_default_create(false, false, false);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
+
+	encoder_cfg = get_first_encoder(config);
+	connector_cfg = get_first_connector(config);
+
+	/* Invalid: Connector without a possible encoder */
+	vkms_config_connector_detach_encoder(connector_cfg, encoder_cfg);
+	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
+
+	vkms_config_destroy(config);
+}
+
 static void vkms_config_test_attach_different_configs(struct kunit *test)
 {
 	struct vkms_config *config1, *config2;
 	struct vkms_config_plane *plane_cfg1, *plane_cfg2;
 	struct vkms_config_crtc *crtc_cfg1, *crtc_cfg2;
 	struct vkms_config_encoder *encoder_cfg1, *encoder_cfg2;
+	struct vkms_config_connector *connector_cfg1, *connector_cfg2;
 	int err;
 
 	config1 = vkms_config_create("test1");
@@ -601,10 +621,12 @@ static void vkms_config_test_attach_different_configs(struct kunit *test)
 	plane_cfg1 = vkms_config_create_plane(config1);
 	crtc_cfg1 = vkms_config_create_crtc(config1);
 	encoder_cfg1 = vkms_config_create_encoder(config1);
+	connector_cfg1 = vkms_config_create_connector(config1);
 
 	plane_cfg2 = vkms_config_create_plane(config2);
 	crtc_cfg2 = vkms_config_create_crtc(config2);
 	encoder_cfg2 = vkms_config_create_encoder(config2);
+	connector_cfg2 = vkms_config_create_connector(config2);
 
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_cfg1);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_cfg2);
@@ -612,6 +634,8 @@ static void vkms_config_test_attach_different_configs(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_cfg2);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, encoder_cfg1);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, encoder_cfg2);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector_cfg1);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector_cfg2);
 
 	err = vkms_config_plane_attach_crtc(plane_cfg1, crtc_cfg2);
 	KUNIT_EXPECT_NE(test, err, 0);
@@ -623,6 +647,11 @@ static void vkms_config_test_attach_different_configs(struct kunit *test)
 	err = vkms_config_encoder_attach_crtc(encoder_cfg2, crtc_cfg1);
 	KUNIT_EXPECT_NE(test, err, 0);
 
+	err = vkms_config_connector_attach_encoder(connector_cfg1, encoder_cfg2);
+	KUNIT_EXPECT_NE(test, err, 0);
+	err = vkms_config_connector_attach_encoder(connector_cfg2, encoder_cfg1);
+	KUNIT_EXPECT_NE(test, err, 0);
+
 	vkms_config_destroy(config1);
 	vkms_config_destroy(config2);
 }
@@ -816,6 +845,77 @@ static void vkms_config_test_encoder_get_possible_crtcs(struct kunit *test)
 	vkms_config_destroy(config);
 }
 
+static void vkms_config_test_connector_get_possible_encoders(struct kunit *test)
+{
+	struct vkms_config *config;
+	struct vkms_config_connector *connector_cfg1, *connector_cfg2;
+	struct vkms_config_encoder *encoder_cfg1, *encoder_cfg2;
+	struct vkms_config_encoder *possible_encoder;
+	unsigned long idx = 0;
+	int n_encoders = 0;
+	int err;
+
+	config = vkms_config_create("test");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
+
+	connector_cfg1 = vkms_config_create_connector(config);
+	connector_cfg2 = vkms_config_create_connector(config);
+	encoder_cfg1 = vkms_config_create_encoder(config);
+	encoder_cfg2 = vkms_config_create_encoder(config);
+
+	/* No possible encoders */
+	vkms_config_connector_for_each_possible_encoder(connector_cfg1, idx,
+							possible_encoder)
+		KUNIT_FAIL(test, "Unexpected possible encoder");
+
+	vkms_config_connector_for_each_possible_encoder(connector_cfg2, idx,
+							possible_encoder)
+		KUNIT_FAIL(test, "Unexpected possible encoder");
+
+	/* Connector 1 attached to encoders 1 and 2 */
+	err = vkms_config_connector_attach_encoder(connector_cfg1, encoder_cfg1);
+	KUNIT_EXPECT_EQ(test, err, 0);
+	err = vkms_config_connector_attach_encoder(connector_cfg1, encoder_cfg2);
+	KUNIT_EXPECT_EQ(test, err, 0);
+
+	vkms_config_connector_for_each_possible_encoder(connector_cfg1, idx,
+							possible_encoder) {
+		n_encoders++;
+		if (possible_encoder != encoder_cfg1 &&
+		    possible_encoder != encoder_cfg2)
+			KUNIT_FAIL(test, "Unexpected possible encoder");
+	}
+	KUNIT_ASSERT_EQ(test, n_encoders, 2);
+	n_encoders = 0;
+
+	vkms_config_connector_for_each_possible_encoder(connector_cfg2, idx,
+							possible_encoder)
+		KUNIT_FAIL(test, "Unexpected possible encoder");
+
+	/* Connector 1 attached to encoder 1 and connector 2 to encoder 2 */
+	vkms_config_connector_detach_encoder(connector_cfg1, encoder_cfg2);
+	vkms_config_connector_for_each_possible_encoder(connector_cfg1, idx,
+							possible_encoder) {
+		n_encoders++;
+		if (possible_encoder != encoder_cfg1)
+			KUNIT_FAIL(test, "Unexpected possible encoder");
+	}
+	KUNIT_ASSERT_EQ(test, n_encoders, 1);
+	n_encoders = 0;
+
+	err = vkms_config_connector_attach_encoder(connector_cfg2, encoder_cfg2);
+	KUNIT_EXPECT_EQ(test, err, 0);
+	vkms_config_connector_for_each_possible_encoder(connector_cfg2, idx,
+							possible_encoder) {
+		n_encoders++;
+		if (possible_encoder != encoder_cfg2)
+			KUNIT_FAIL(test, "Unexpected possible encoder");
+	}
+	KUNIT_ASSERT_EQ(test, n_encoders, 1);
+
+	vkms_config_destroy(config);
+}
+
 static struct kunit_case vkms_config_test_cases[] = {
 	KUNIT_CASE(vkms_config_test_empty_config),
 	KUNIT_CASE_PARAM(vkms_config_test_default_config,
@@ -831,10 +931,12 @@ static struct kunit_case vkms_config_test_cases[] = {
 	KUNIT_CASE(vkms_config_test_invalid_encoder_number),
 	KUNIT_CASE(vkms_config_test_valid_encoder_possible_crtcs),
 	KUNIT_CASE(vkms_config_test_invalid_connector_number),
+	KUNIT_CASE(vkms_config_test_valid_connector_possible_encoders),
 	KUNIT_CASE(vkms_config_test_attach_different_configs),
 	KUNIT_CASE(vkms_config_test_plane_attach_crtc),
 	KUNIT_CASE(vkms_config_test_plane_get_possible_crtcs),
 	KUNIT_CASE(vkms_config_test_encoder_get_possible_crtcs),
+	KUNIT_CASE(vkms_config_test_connector_get_possible_encoders),
 	{}
 };
 
diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index fbbdee6068ce..a1df5659b0fb 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -95,6 +95,9 @@ struct vkms_config *vkms_config_default_create(bool enable_cursor,
 	if (IS_ERR(connector_cfg))
 		goto err_alloc;
 
+	if (vkms_config_connector_attach_encoder(connector_cfg, encoder_cfg))
+		goto err_alloc;
+
 	return config;
 
 err_alloc:
@@ -279,6 +282,22 @@ static bool valid_connector_number(const struct vkms_config *config)
 	return true;
 }
 
+static bool valid_connector_possible_encoders(const struct vkms_config *config)
+{
+	struct drm_device *dev = config->dev ? &config->dev->drm : NULL;
+	struct vkms_config_connector *connector_cfg;
+
+	vkms_config_for_each_connector(config, connector_cfg) {
+		if (xa_empty(&connector_cfg->possible_encoders)) {
+			drm_info(dev,
+				 "All connectors must have at least one possible encoder\n");
+			return false;
+		}
+	}
+
+	return true;
+}
+
 bool vkms_config_is_valid(const struct vkms_config *config)
 {
 	struct vkms_config_crtc *crtc_cfg;
@@ -306,6 +325,9 @@ bool vkms_config_is_valid(const struct vkms_config *config)
 	if (!valid_encoder_possible_crtcs(config))
 		return false;
 
+	if (!valid_connector_possible_encoders(config))
+		return false;
+
 	return true;
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_is_valid);
@@ -513,6 +535,11 @@ EXPORT_SYMBOL_IF_KUNIT(vkms_config_create_encoder);
 void vkms_config_destroy_encoder(struct vkms_config *config,
 				 struct vkms_config_encoder *encoder_cfg)
 {
+	struct vkms_config_connector *connector_cfg;
+
+	vkms_config_for_each_connector(config, connector_cfg)
+		vkms_config_connector_detach_encoder(connector_cfg, encoder_cfg);
+
 	xa_destroy(&encoder_cfg->possible_crtcs);
 	list_del(&encoder_cfg->link);
 	kfree(encoder_cfg);
@@ -561,6 +588,7 @@ struct vkms_config_connector *vkms_config_create_connector(struct vkms_config *c
 		return ERR_PTR(-ENOMEM);
 
 	connector_cfg->config = config;
+	xa_init_flags(&connector_cfg->possible_encoders, XA_FLAGS_ALLOC);
 
 	list_add_tail(&connector_cfg->link, &config->connectors);
 
@@ -570,7 +598,43 @@ EXPORT_SYMBOL_IF_KUNIT(vkms_config_create_connector);
 
 void vkms_config_destroy_connector(struct vkms_config_connector *connector_cfg)
 {
+	xa_destroy(&connector_cfg->possible_encoders);
 	list_del(&connector_cfg->link);
 	kfree(connector_cfg);
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_destroy_connector);
+
+int __must_check vkms_config_connector_attach_encoder(struct vkms_config_connector *connector_cfg,
+						      struct vkms_config_encoder *encoder_cfg)
+{
+	struct vkms_config_encoder *possible_encoder;
+	unsigned long idx = 0;
+	u32 encoder_idx = 0;
+
+	if (connector_cfg->config != encoder_cfg->config)
+		return -EINVAL;
+
+	vkms_config_connector_for_each_possible_encoder(connector_cfg, idx,
+							possible_encoder) {
+		if (possible_encoder == encoder_cfg)
+			return -EEXIST;
+	}
+
+	return xa_alloc(&connector_cfg->possible_encoders, &encoder_idx,
+			encoder_cfg, xa_limit_32b, GFP_KERNEL);
+}
+EXPORT_SYMBOL_IF_KUNIT(vkms_config_connector_attach_encoder);
+
+void vkms_config_connector_detach_encoder(struct vkms_config_connector *connector_cfg,
+					  struct vkms_config_encoder *encoder_cfg)
+{
+	struct vkms_config_encoder *possible_encoder;
+	unsigned long idx = 0;
+
+	vkms_config_connector_for_each_possible_encoder(connector_cfg, idx,
+							possible_encoder) {
+		if (possible_encoder == encoder_cfg)
+			xa_erase(&connector_cfg->possible_encoders, idx);
+	}
+}
+EXPORT_SYMBOL_IF_KUNIT(vkms_config_connector_detach_encoder);
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index 73562c894102..0118e3f99706 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -99,6 +99,7 @@ struct vkms_config_encoder {
  *
  * @link: Link to the others connector in vkms_config
  * @config: The vkms_config this connector belongs to
+ * @possible_encoders: Array of encoders that can be used with this connector
  * @connector: Internal usage. This pointer should never be considered as valid.
  *             It can be used to store a temporary reference to a VKMS connector
  *             during device creation. This pointer is not managed by the
@@ -108,6 +109,8 @@ struct vkms_config_connector {
 	struct list_head link;
 	struct vkms_config *config;
 
+	struct xarray possible_encoders;
+
 	/* Internal usage */
 	struct vkms_connector *connector;
 };
@@ -164,6 +167,16 @@ struct vkms_config_connector {
 #define vkms_config_encoder_for_each_possible_crtc(encoder_cfg, idx, possible_crtc) \
 	xa_for_each(&(encoder_cfg)->possible_crtcs, idx, (possible_crtc))
 
+/**
+ * vkms_config_connector_for_each_possible_encoder - Iterate over the
+ * vkms_config_connector possible encoders
+ * @connector_cfg: &struct vkms_config_connector pointer
+ * @idx: Index of the cursor
+ * @possible_encoder: &struct vkms_config_encoder pointer used as cursor
+ */
+#define vkms_config_connector_for_each_possible_encoder(connector_cfg, idx, possible_encoder) \
+	xa_for_each(&(connector_cfg)->possible_encoders, idx, (possible_encoder))
+
 /**
  * vkms_config_create() - Create a new VKMS configuration
  * @dev_name: Name of the device
@@ -405,4 +418,20 @@ struct vkms_config_connector *vkms_config_create_connector(struct vkms_config *c
  */
 void vkms_config_destroy_connector(struct vkms_config_connector *connector_cfg);
 
+/**
+ * vkms_config_connector_attach_encoder - Attach a connector to an encoder
+ * @connector_cfg: Connector to attach
+ * @encoder_cfg: Encoder to attach @connector_cfg to
+ */
+int __must_check vkms_config_connector_attach_encoder(struct vkms_config_connector *connector_cfg,
+						      struct vkms_config_encoder *encoder_cfg);
+
+/**
+ * vkms_config_connector_detach_encoder - Detach a connector from an encoder
+ * @connector_cfg: Connector to detach
+ * @encoder_cfg: Encoder to detach @connector_cfg from
+ */
+void vkms_config_connector_detach_encoder(struct vkms_config_connector *connector_cfg,
+					  struct vkms_config_encoder *encoder_cfg);
+
 #endif /* _VKMS_CONFIG_H_ */
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 8920d6b5d105..8d7ca0cdd79f 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -8,10 +8,10 @@
 int vkms_output_init(struct vkms_device *vkmsdev)
 {
 	struct drm_device *dev = &vkmsdev->drm;
-	struct vkms_connector *connector;
 	struct vkms_config_plane *plane_cfg;
 	struct vkms_config_crtc *crtc_cfg;
 	struct vkms_config_encoder *encoder_cfg;
+	struct vkms_config_connector *connector_cfg;
 	int ret;
 	int writeback;
 
@@ -83,22 +83,29 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 		}
 	}
 
-	connector = vkms_connector_init(vkmsdev);
-	if (IS_ERR(connector)) {
-		DRM_ERROR("Failed to init connector\n");
-		return PTR_ERR(connector);
-	}
+	vkms_config_for_each_connector(vkmsdev->config, connector_cfg) {
+		struct vkms_config_encoder *possible_encoder;
+		unsigned long idx = 0;
 
-	/* Attach the encoder and the connector */
-	vkms_config_for_each_encoder(vkmsdev->config, encoder_cfg) {
-		ret = drm_connector_attach_encoder(&connector->base, encoder_cfg->encoder);
-		if (ret) {
-			DRM_ERROR("Failed to attach connector to encoder\n");
-			return ret;
+		connector_cfg->connector = vkms_connector_init(vkmsdev);
+		if (IS_ERR(connector_cfg->connector)) {
+			DRM_ERROR("Failed to init connector\n");
+			return PTR_ERR(connector_cfg->connector);
+		}
+
+		vkms_config_connector_for_each_possible_encoder(connector_cfg,
+								idx,
+								possible_encoder) {
+			ret = drm_connector_attach_encoder(&connector_cfg->connector->base,
+							   possible_encoder->encoder);
+			if (ret) {
+				DRM_ERROR("Failed to attach connector to encoder\n");
+				return ret;
+			}
 		}
 	}
 
 	drm_mode_config_reset(dev);
 
-	return ret;
+	return 0;
 }
-- 
2.48.1


