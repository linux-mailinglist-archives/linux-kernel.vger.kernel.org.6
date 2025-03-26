Return-Path: <linux-kernel+bounces-576808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D45E3A714B4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5EAF189BE1C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2411E1E1E;
	Wed, 26 Mar 2025 10:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fT88P8DW"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A3E1DE3B7
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742984413; cv=none; b=ZnrhHN/aG+bAuvlmrDcrpGeSX5MqfQfz5yKt31HBE5OuKZknh/h9Y/OTAotg0PCIPNGfnzFO/7Jrd8ihLBtZ7ZCrmFEM+WKgsrjQLy+8FsFqPQVwouDabeVCt+YIbffXqMoH2O1njl6tBLVkMwktLrN+5iYFx1N4PnKAoTV99Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742984413; c=relaxed/simple;
	bh=JY0o5v2vlBhjkX9Cg9CiF7H42fvwkyULxa0W+g4684g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=st1DC5Hxiw0lxahaVmgXLMO2ImN1IVeMtFMZa0FpcGvf4BUDaHea+l165JlpZVgRh0ADyOMD0hadt9Ths7UzATejEttxGeemIHY/l89g+TOBq76bmb+ASxAQqbsN1xIB+CsLwT4qsNP2c3pfBNsdUCTa5rrBd4VfID02zBqiSSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fT88P8DW; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742984409;
	bh=JY0o5v2vlBhjkX9Cg9CiF7H42fvwkyULxa0W+g4684g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fT88P8DWjUEgr4L9frZioVeQjoaQWBNH1SZjmeNb9JyMM1eA13eJYdLhz8OmtJIXQ
	 RctLkJnhviR/w9E5+al/KNZx4Lc6rMoY6tNSBKjD69HXNe/Lbiy938ZqTibeTB+mpf
	 GXa7kr8fBfDEQUje17NoP5XiRBibUmXTSI/VuFqGRNGDIcakn+ICvSitxtwqJ5w6v3
	 PPZC9l4D3ZVMyQoLKVy1jWVaUBdCoijiWBDJlvAFtiOQtHpCjVjhHBT6obuic/a65k
	 4cGe2EXYRbrqrBH5VrniqAeyQTmBhqXVRNq9AYlv2YO3MsGwo1GfO4K4TopWmTXq8K
	 NUuna5ld/MP/w==
Received: from localhost (unknown [84.232.140.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id EB84417E0A5D;
	Wed, 26 Mar 2025 11:20:08 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Wed, 26 Mar 2025 12:19:59 +0200
Subject: [PATCH v3 10/15] drm/tests: hdmi: Replace open coded EDID setup
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-hdmi-conn-yuv-v3-10-294d3ebbb4b2@collabora.com>
References: <20250326-hdmi-conn-yuv-v3-0-294d3ebbb4b2@collabora.com>
In-Reply-To: <20250326-hdmi-conn-yuv-v3-0-294d3ebbb4b2@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Make use of the recently introduced macros to reduce boilerplate code
around EDID setup. This also helps dropping the redundant calls to
set_connector_edid().

No functional changes intended.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 220 ++++++++-------------
 1 file changed, 78 insertions(+), 142 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index 284bd9b1418a454d05c4a38263519eb8ae450090..7b2aaee5009ce58e6edf2649e2182c43ba834523 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -751,19 +751,15 @@ static void drm_test_check_output_bpc_crtc_mode_changed(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(HDMI_COLORSPACE_RGB),
-						    10);
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid(test,
+				BIT(HDMI_COLORSPACE_RGB),
+				10,
+				test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm = &priv->drm;
 	crtc = priv->crtc;
 	conn = &priv->connector;
-	ret = set_connector_edid(test, conn,
-				 test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz,
-				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz));
-	KUNIT_ASSERT_GT(test, ret, 0);
-
 	preferred = find_preferred_mode(conn);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 
@@ -830,19 +826,15 @@ static void drm_test_check_output_bpc_crtc_mode_not_changed(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(HDMI_COLORSPACE_RGB),
-						    10);
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid(test,
+				BIT(HDMI_COLORSPACE_RGB),
+				10,
+				test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm = &priv->drm;
 	crtc = priv->crtc;
 	conn = &priv->connector;
-	ret = set_connector_edid(test, conn,
-				 test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz,
-				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz));
-	KUNIT_ASSERT_GT(test, ret, 0);
-
 	preferred = find_preferred_mode(conn);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 
@@ -904,21 +896,17 @@ static void drm_test_check_output_bpc_dvi(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(HDMI_COLORSPACE_RGB) |
-						    BIT(HDMI_COLORSPACE_YUV422) |
-						    BIT(HDMI_COLORSPACE_YUV444),
-						    12);
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid(test,
+					BIT(HDMI_COLORSPACE_RGB) |
+					BIT(HDMI_COLORSPACE_YUV422) |
+					BIT(HDMI_COLORSPACE_YUV444),
+					12,
+					test_edid_dvi_1080p);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm = &priv->drm;
 	crtc = priv->crtc;
 	conn = &priv->connector;
-	ret = set_connector_edid(test, conn,
-				 test_edid_dvi_1080p,
-				 ARRAY_SIZE(test_edid_dvi_1080p));
-	KUNIT_ASSERT_GT(test, ret, 0);
-
 	info = &conn->display_info;
 	KUNIT_ASSERT_FALSE(test, info->is_hdmi);
 
@@ -958,19 +946,15 @@ static void drm_test_check_tmds_char_rate_rgb_8bpc(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(HDMI_COLORSPACE_RGB),
-						    8);
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid(test,
+				BIT(HDMI_COLORSPACE_RGB),
+				8,
+				test_edid_hdmi_1080p_rgb_max_200mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm = &priv->drm;
 	crtc = priv->crtc;
 	conn = &priv->connector;
-	ret = set_connector_edid(test, conn,
-				 test_edid_hdmi_1080p_rgb_max_200mhz,
-				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_max_200mhz));
-	KUNIT_ASSERT_GT(test, ret, 0);
-
 	preferred = find_preferred_mode(conn);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 	KUNIT_ASSERT_FALSE(test, preferred->flags & DRM_MODE_FLAG_DBLCLK);
@@ -1010,19 +994,15 @@ static void drm_test_check_tmds_char_rate_rgb_10bpc(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(HDMI_COLORSPACE_RGB),
-						    10);
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid(test,
+				BIT(HDMI_COLORSPACE_RGB),
+				10,
+				test_edid_hdmi_1080p_rgb_yuv_dc_max_340mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm = &priv->drm;
 	crtc = priv->crtc;
 	conn = &priv->connector;
-	ret = set_connector_edid(test, conn,
-				 test_edid_hdmi_1080p_rgb_yuv_dc_max_340mhz,
-				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_yuv_dc_max_340mhz));
-	KUNIT_ASSERT_GT(test, ret, 0);
-
 	preferred = find_preferred_mode(conn);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 	KUNIT_ASSERT_FALSE(test, preferred->flags & DRM_MODE_FLAG_DBLCLK);
@@ -1062,19 +1042,15 @@ static void drm_test_check_tmds_char_rate_rgb_12bpc(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(HDMI_COLORSPACE_RGB),
-						    12);
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid(test,
+				BIT(HDMI_COLORSPACE_RGB),
+				12,
+				test_edid_hdmi_1080p_rgb_yuv_dc_max_340mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm = &priv->drm;
 	crtc = priv->crtc;
 	conn = &priv->connector;
-	ret = set_connector_edid(test, conn,
-				 test_edid_hdmi_1080p_rgb_yuv_dc_max_340mhz,
-				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_yuv_dc_max_340mhz));
-	KUNIT_ASSERT_GT(test, ret, 0);
-
 	preferred = find_preferred_mode(conn);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 	KUNIT_ASSERT_FALSE(test, preferred->flags & DRM_MODE_FLAG_DBLCLK);
@@ -1180,19 +1156,15 @@ static void drm_test_check_max_tmds_rate_bpc_fallback(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(HDMI_COLORSPACE_RGB),
-						    12);
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid(test,
+				BIT(HDMI_COLORSPACE_RGB),
+				12,
+				test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm = &priv->drm;
 	crtc = priv->crtc;
 	conn = &priv->connector;
-	ret = set_connector_edid(test, conn,
-				 test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz,
-				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz));
-	KUNIT_ASSERT_GT(test, ret, 0);
-
 	info = &conn->display_info;
 	KUNIT_ASSERT_TRUE(test, info->is_hdmi);
 	KUNIT_ASSERT_GT(test, info->max_tmds_clock, 0);
@@ -1252,21 +1224,17 @@ static void drm_test_check_max_tmds_rate_format_fallback(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(HDMI_COLORSPACE_RGB) |
-						    BIT(HDMI_COLORSPACE_YUV422) |
-						    BIT(HDMI_COLORSPACE_YUV444),
-						    12);
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid(test,
+				BIT(HDMI_COLORSPACE_RGB) |
+				BIT(HDMI_COLORSPACE_YUV422) |
+				BIT(HDMI_COLORSPACE_YUV444),
+				12,
+				test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm = &priv->drm;
 	crtc = priv->crtc;
 	conn = &priv->connector;
-	ret = set_connector_edid(test, conn,
-				 test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz,
-				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz));
-	KUNIT_ASSERT_GT(test, ret, 0);
-
 	info = &conn->display_info;
 	KUNIT_ASSERT_TRUE(test, info->is_hdmi);
 	KUNIT_ASSERT_GT(test, info->max_tmds_clock, 0);
@@ -1320,20 +1288,16 @@ static void drm_test_check_output_bpc_format_vic_1(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(HDMI_COLORSPACE_RGB) |
-						    BIT(HDMI_COLORSPACE_YUV422) |
-						    BIT(HDMI_COLORSPACE_YUV444),
-						    12);
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid(test,
+				BIT(HDMI_COLORSPACE_RGB) |
+				BIT(HDMI_COLORSPACE_YUV422) |
+				BIT(HDMI_COLORSPACE_YUV444),
+				12,
+				test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm = &priv->drm;
 	conn = &priv->connector;
-	ret = set_connector_edid(test, conn,
-				 test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz,
-				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz));
-	KUNIT_ASSERT_GT(test, ret, 0);
-
 	info = &conn->display_info;
 	KUNIT_ASSERT_TRUE(test, info->is_hdmi);
 	KUNIT_ASSERT_GT(test, info->max_tmds_clock, 0);
@@ -1387,19 +1351,15 @@ static void drm_test_check_output_bpc_format_driver_rgb_only(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(HDMI_COLORSPACE_RGB),
-						    12);
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid(test,
+				BIT(HDMI_COLORSPACE_RGB),
+				12,
+				test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm = &priv->drm;
 	crtc = priv->crtc;
 	conn = &priv->connector;
-	ret = set_connector_edid(test, conn,
-				 test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz,
-				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz));
-	KUNIT_ASSERT_GT(test, ret, 0);
-
 	info = &conn->display_info;
 	KUNIT_ASSERT_TRUE(test, info->is_hdmi);
 	KUNIT_ASSERT_GT(test, info->max_tmds_clock, 0);
@@ -1457,21 +1417,17 @@ static void drm_test_check_output_bpc_format_display_rgb_only(struct kunit *test
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(HDMI_COLORSPACE_RGB) |
-						    BIT(HDMI_COLORSPACE_YUV422) |
-						    BIT(HDMI_COLORSPACE_YUV444),
-						    12);
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid(test,
+				BIT(HDMI_COLORSPACE_RGB) |
+				BIT(HDMI_COLORSPACE_YUV422) |
+				BIT(HDMI_COLORSPACE_YUV444),
+				12,
+				test_edid_hdmi_1080p_rgb_max_200mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm = &priv->drm;
 	crtc = priv->crtc;
 	conn = &priv->connector;
-	ret = set_connector_edid(test, conn,
-				 test_edid_hdmi_1080p_rgb_max_200mhz,
-				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_max_200mhz));
-	KUNIT_ASSERT_GT(test, ret, 0);
-
 	info = &conn->display_info;
 	KUNIT_ASSERT_TRUE(test, info->is_hdmi);
 	KUNIT_ASSERT_GT(test, info->max_tmds_clock, 0);
@@ -1530,19 +1486,15 @@ static void drm_test_check_output_bpc_format_driver_8bpc_only(struct kunit *test
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(HDMI_COLORSPACE_RGB),
-						    8);
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid(test,
+				BIT(HDMI_COLORSPACE_RGB),
+				8,
+				test_edid_hdmi_1080p_rgb_yuv_dc_max_340mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm = &priv->drm;
 	crtc = priv->crtc;
 	conn = &priv->connector;
-	ret = set_connector_edid(test, conn,
-				 test_edid_hdmi_1080p_rgb_yuv_dc_max_340mhz,
-				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_yuv_dc_max_340mhz));
-	KUNIT_ASSERT_GT(test, ret, 0);
-
 	info = &conn->display_info;
 	KUNIT_ASSERT_TRUE(test, info->is_hdmi);
 	KUNIT_ASSERT_GT(test, info->max_tmds_clock, 0);
@@ -1593,21 +1545,17 @@ static void drm_test_check_output_bpc_format_display_8bpc_only(struct kunit *tes
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(HDMI_COLORSPACE_RGB) |
-						    BIT(HDMI_COLORSPACE_YUV422) |
-						    BIT(HDMI_COLORSPACE_YUV444),
-						    12);
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid(test,
+				BIT(HDMI_COLORSPACE_RGB) |
+				BIT(HDMI_COLORSPACE_YUV422) |
+				BIT(HDMI_COLORSPACE_YUV444),
+				12,
+				test_edid_hdmi_1080p_rgb_max_340mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm = &priv->drm;
 	crtc = priv->crtc;
 	conn = &priv->connector;
-	ret = set_connector_edid(test, conn,
-				 test_edid_hdmi_1080p_rgb_max_340mhz,
-				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_max_340mhz));
-	KUNIT_ASSERT_GT(test, ret, 0);
-
 	info = &conn->display_info;
 	KUNIT_ASSERT_TRUE(test, info->is_hdmi);
 	KUNIT_ASSERT_GT(test, info->max_tmds_clock, 0);
@@ -1926,28 +1874,20 @@ static void drm_test_check_mode_valid(struct kunit *test)
 static void drm_test_check_mode_valid_reject_rate(struct kunit *test)
 {
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
-	struct drm_connector *conn;
 	struct drm_display_mode *preferred;
-	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init_funcs(test,
-							  BIT(HDMI_COLORSPACE_RGB),
-							  8,
-							  &reject_100mhz_connector_hdmi_funcs);
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
+					BIT(HDMI_COLORSPACE_RGB),
+					8,
+					&reject_100mhz_connector_hdmi_funcs,
+					test_edid_hdmi_1080p_rgb_max_200mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
-	conn = &priv->connector;
-
-	ret = set_connector_edid(test, conn,
-				 test_edid_hdmi_1080p_rgb_max_200mhz,
-				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_max_200mhz));
-	KUNIT_ASSERT_GT(test, ret, 0);
-
 	/*
 	 * Unlike the drm_test_check_mode_valid() here 1080p is rejected, but
 	 * 480p is allowed.
 	 */
-	preferred = find_preferred_mode(conn);
+	preferred = find_preferred_mode(&priv->connector);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 	KUNIT_EXPECT_EQ(test, preferred->hdisplay, 640);
 	KUNIT_EXPECT_EQ(test, preferred->vdisplay, 480);
@@ -1965,12 +1905,14 @@ static void drm_test_check_mode_valid_reject(struct kunit *test)
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_connector *conn;
 	struct drm_display_mode *preferred;
+	unsigned char no_edid[] = {};
 	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init_funcs(test,
-							  BIT(HDMI_COLORSPACE_RGB),
-							  8,
-							  &reject_connector_hdmi_funcs);
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
+					BIT(HDMI_COLORSPACE_RGB),
+					8,
+					&reject_connector_hdmi_funcs,
+					no_edid);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	conn = &priv->connector;
@@ -1995,20 +1937,14 @@ static void drm_test_check_mode_valid_reject_max_clock(struct kunit *test)
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_connector *conn;
 	struct drm_display_mode *preferred;
-	int ret;
 
-	priv = drm_kunit_helper_connector_hdmi_init(test,
-						    BIT(HDMI_COLORSPACE_RGB),
-						    8);
+	priv = drm_kunit_helper_connector_hdmi_init_with_edid(test,
+				BIT(HDMI_COLORSPACE_RGB),
+				8,
+				test_edid_hdmi_1080p_rgb_max_100mhz);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	conn = &priv->connector;
-
-	ret = set_connector_edid(test, conn,
-				 test_edid_hdmi_1080p_rgb_max_100mhz,
-				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_max_100mhz));
-	KUNIT_ASSERT_GT(test, ret, 0);
-
 	KUNIT_ASSERT_EQ(test, conn->display_info.max_tmds_clock, 100 * 1000);
 
 	preferred = find_preferred_mode(conn);

-- 
2.49.0


