Return-Path: <linux-kernel+bounces-559416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45477A5F3A3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 777E317EE58
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F1B266F00;
	Thu, 13 Mar 2025 12:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioLIx3Ck"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9580A2676FF
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741867230; cv=none; b=QoWI1dYne+3DKK5fGNT8aLO8F/fRM9A5qWo//mfBFYO+k6Sq8L36SA3javqzFPZtYoyI461V+DPATSKiXJP4xw7MUdRZqSEwb4Wkn+MyfOR4HoutHXfQyrZ2qwqZtp6SR6Tc+CD1aILbxR6UFZJn+xGuvJU0cZToL6l+IqpN+9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741867230; c=relaxed/simple;
	bh=+LGiRKEcCcITA0C2Yd4YksjVY0vEpo6IKjVYAWJOpdQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dv43egAySWANq0zkXZERrsxB8v7nBfrNDt6GO1WVF/mEUod3QabWgXohjNM19iDkVNba76uN0uxeELI+hjcxBtHGFAfpjXSFehK6iQmz1sKO6GIdsCF97OHHBCOsMvYj1rvOGtueRFK2XMKjR7S5ZEDuiomULtXjJMQVELn186E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioLIx3Ck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7614C4CEF2;
	Thu, 13 Mar 2025 12:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741867230;
	bh=+LGiRKEcCcITA0C2Yd4YksjVY0vEpo6IKjVYAWJOpdQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ioLIx3CkVx8iRV/7QMSe8WFZCEZOOgrMDqk3ZCg2P7T5+tp8P4f1wru7X20SGeV69
	 LibhXFfWuR7ERBGsdpmsv/413JuruuZm7ByUu7gY2xEPUjBWdlm3S3N4HwpKS73B7y
	 zwEcyaRBQ1oDGn5EbaEhtP54ZUf+cbrUke6zf7X6IogUnSGd0xbcvsNkaOV6BvlWIV
	 pAEZRgjyqdO1C7pp60xWUBQWO27MtQ0KUrB0gRRS8hGcPTircL6mOPn9YXVT/1QDZ4
	 W5fw2snlZqNyojKblCNlZsRuVAsfHKrTYBtXTx/7jpieaCZVlAFjMj7yl9hpHCQsW0
	 tMNB8sNrow2lw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 13 Mar 2025 13:00:00 +0100
Subject: [PATCH v6 06/16] drm/tests: hdmi_state_helpers: Switch to new
 helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-bridge-connector-v6-6-511c54a604fb@kernel.org>
References: <20250313-bridge-connector-v6-0-511c54a604fb@kernel.org>
In-Reply-To: <20250313-bridge-connector-v6-0-511c54a604fb@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: Herve Codina <herve.codina@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=15615; i=mripard@kernel.org;
 h=from:subject:message-id; bh=+LGiRKEcCcITA0C2Yd4YksjVY0vEpo6IKjVYAWJOpdQ=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDOmXThy8HaR2OO1Z+s2nf8/F7bvM/NwvQaR6df3DzXNF8
 1YfeenzsaOUhUGMi0FWTJElRth8SdypWa872fjmwcxhZQIZwsDFKQATYT/E8It5/+OYNcbX3865
 z/YwbMdT69NHOMOj533e8MBx/7Q5h6SqGP4KmgT6z6o+Lncg5F/bGxFBBauNxue5so9/Pjsh1KL
 L8wUTAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

We introduced a new helper that supersedes the light_up_connector()
function in drm_hdmi_state_helper_test, so let's convert all our tests
to it.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 158 ++++++++++++---------
 1 file changed, 92 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index e97efd3af9ed18e6cf8ee66b4923dfc805b34e19..7ffd666753b10bc991894e238206a3c5328d0e23 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -53,53 +53,10 @@ static struct drm_display_mode *find_preferred_mode(struct drm_connector *connec
 	mutex_unlock(&drm->mode_config.mutex);
 
 	return preferred;
 }
 
-static int light_up_connector(struct kunit *test,
-			      struct drm_device *drm,
-			      struct drm_crtc *crtc,
-			      struct drm_connector *connector,
-			      struct drm_display_mode *mode,
-			      struct drm_modeset_acquire_ctx *ctx)
-{
-	struct drm_atomic_state *state;
-	struct drm_connector_state *conn_state;
-	struct drm_crtc_state *crtc_state;
-	int ret;
-
-	state = drm_kunit_helper_atomic_state_alloc(test, drm, ctx);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
-
-retry:
-	conn_state = drm_atomic_get_connector_state(state, connector);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
-
-	ret = drm_atomic_set_crtc_for_connector(conn_state, crtc);
-	if (ret == -EDEADLK) {
-		drm_atomic_state_clear(state);
-		ret = drm_modeset_backoff(ctx);
-		if (!ret)
-			goto retry;
-	}
-	KUNIT_EXPECT_EQ(test, ret, 0);
-
-	crtc_state = drm_atomic_get_crtc_state(state, crtc);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
-
-	ret = drm_atomic_set_mode_for_crtc(crtc_state, mode);
-	KUNIT_EXPECT_EQ(test, ret, 0);
-
-	crtc_state->enable = true;
-	crtc_state->active = true;
-
-	ret = drm_atomic_commit(state);
-	KUNIT_ASSERT_EQ(test, ret, 0);
-
-	return 0;
-}
-
 static int set_connector_edid(struct kunit *test, struct drm_connector *connector,
 			      const char *edid, size_t edid_len)
 {
 	struct drm_atomic_helper_connector_hdmi_priv *priv =
 		connector_to_priv(connector);
@@ -296,11 +253,14 @@ static void drm_test_check_broadcast_rgb_crtc_mode_changed(struct kunit *test)
 	preferred = find_preferred_mode(conn);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 
 	drm_modeset_acquire_init(&ctx, 0);
 
-	ret = light_up_connector(test, drm, crtc, conn, preferred, &ctx);
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
+						     crtc, conn,
+						     preferred,
+						     &ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
@@ -362,11 +322,14 @@ static void drm_test_check_broadcast_rgb_crtc_mode_not_changed(struct kunit *tes
 	preferred = find_preferred_mode(conn);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 
 	drm_modeset_acquire_init(&ctx, 0);
 
-	ret = light_up_connector(test, drm, crtc, conn, preferred, &ctx);
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
+						     crtc, conn,
+						     preferred,
+						     &ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
@@ -430,11 +393,14 @@ static void drm_test_check_broadcast_rgb_auto_cea_mode(struct kunit *test)
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 	KUNIT_ASSERT_NE(test, drm_match_cea_mode(preferred), 1);
 
 	drm_modeset_acquire_init(&ctx, 0);
 
-	ret = light_up_connector(test, drm, crtc, conn, preferred, &ctx);
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
+						     crtc, conn,
+						     preferred,
+						     &ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
@@ -487,11 +453,14 @@ static void drm_test_check_broadcast_rgb_auto_cea_mode_vic_1(struct kunit *test)
 
 	mode = drm_kunit_display_mode_from_cea_vic(test, drm, 1);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
 	crtc = priv->crtc;
-	ret = light_up_connector(test, drm, crtc, conn, mode, &ctx);
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
+						     crtc, conn,
+						     mode,
+						     &ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
@@ -545,11 +514,14 @@ static void drm_test_check_broadcast_rgb_full_cea_mode(struct kunit *test)
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 	KUNIT_ASSERT_NE(test, drm_match_cea_mode(preferred), 1);
 
 	drm_modeset_acquire_init(&ctx, 0);
 
-	ret = light_up_connector(test, drm, crtc, conn, preferred, &ctx);
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
+						     crtc, conn,
+						     preferred,
+						     &ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
@@ -604,11 +576,14 @@ static void drm_test_check_broadcast_rgb_full_cea_mode_vic_1(struct kunit *test)
 
 	mode = drm_kunit_display_mode_from_cea_vic(test, drm, 1);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
 	crtc = priv->crtc;
-	ret = light_up_connector(test, drm, crtc, conn, mode, &ctx);
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
+						     crtc, conn,
+						     mode,
+						     &ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
@@ -664,11 +639,14 @@ static void drm_test_check_broadcast_rgb_limited_cea_mode(struct kunit *test)
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 	KUNIT_ASSERT_NE(test, drm_match_cea_mode(preferred), 1);
 
 	drm_modeset_acquire_init(&ctx, 0);
 
-	ret = light_up_connector(test, drm, crtc, conn, preferred, &ctx);
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
+						     crtc, conn,
+						     preferred,
+						     &ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
@@ -723,11 +701,14 @@ static void drm_test_check_broadcast_rgb_limited_cea_mode_vic_1(struct kunit *te
 
 	mode = drm_kunit_display_mode_from_cea_vic(test, drm, 1);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
 	crtc = priv->crtc;
-	ret = light_up_connector(test, drm, crtc, conn, mode, &ctx);
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
+						     crtc, conn,
+						     mode,
+						     &ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
@@ -787,11 +768,14 @@ static void drm_test_check_output_bpc_crtc_mode_changed(struct kunit *test)
 	preferred = find_preferred_mode(conn);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 
 	drm_modeset_acquire_init(&ctx, 0);
 
-	ret = light_up_connector(test, drm, crtc, conn, preferred, &ctx);
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
+						     crtc, conn,
+						     preferred,
+						     &ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
@@ -863,11 +847,14 @@ static void drm_test_check_output_bpc_crtc_mode_not_changed(struct kunit *test)
 	preferred = find_preferred_mode(conn);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 
 	drm_modeset_acquire_init(&ctx, 0);
 
-	ret = light_up_connector(test, drm, crtc, conn, preferred, &ctx);
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
+						     crtc, conn,
+						     preferred,
+						     &ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
@@ -939,11 +926,14 @@ static void drm_test_check_output_bpc_dvi(struct kunit *test)
 	preferred = find_preferred_mode(conn);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 
 	drm_modeset_acquire_init(&ctx, 0);
 
-	ret = light_up_connector(test, drm, crtc, conn, preferred, &ctx);
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
+						     crtc, conn,
+						     preferred,
+						     &ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	conn_state = conn->state;
 	KUNIT_ASSERT_NOT_NULL(test, conn_state);
 
@@ -986,11 +976,14 @@ static void drm_test_check_tmds_char_rate_rgb_8bpc(struct kunit *test)
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 	KUNIT_ASSERT_FALSE(test, preferred->flags & DRM_MODE_FLAG_DBLCLK);
 
 	drm_modeset_acquire_init(&ctx, 0);
 
-	ret = light_up_connector(test, drm, crtc, conn, preferred, &ctx);
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
+						     crtc, conn,
+						     preferred,
+						     &ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	conn_state = conn->state;
 	KUNIT_ASSERT_NOT_NULL(test, conn_state);
 
@@ -1035,11 +1028,14 @@ static void drm_test_check_tmds_char_rate_rgb_10bpc(struct kunit *test)
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 	KUNIT_ASSERT_FALSE(test, preferred->flags & DRM_MODE_FLAG_DBLCLK);
 
 	drm_modeset_acquire_init(&ctx, 0);
 
-	ret = light_up_connector(test, drm, crtc, conn, preferred, &ctx);
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
+						     crtc, conn,
+						     preferred,
+						     &ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	conn_state = conn->state;
 	KUNIT_ASSERT_NOT_NULL(test, conn_state);
 
@@ -1084,11 +1080,14 @@ static void drm_test_check_tmds_char_rate_rgb_12bpc(struct kunit *test)
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 	KUNIT_ASSERT_FALSE(test, preferred->flags & DRM_MODE_FLAG_DBLCLK);
 
 	drm_modeset_acquire_init(&ctx, 0);
 
-	ret = light_up_connector(test, drm, crtc, conn, preferred, &ctx);
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
+						     crtc, conn,
+						     preferred,
+						     &ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	conn_state = conn->state;
 	KUNIT_ASSERT_NOT_NULL(test, conn_state);
 
@@ -1132,11 +1131,14 @@ static void drm_test_check_hdmi_funcs_reject_rate(struct kunit *test)
 	preferred = find_preferred_mode(conn);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 
 	drm_modeset_acquire_init(&ctx, 0);
 
-	ret = light_up_connector(test, drm, crtc, conn, preferred, &ctx);
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
+						     crtc, conn,
+						     preferred,
+						     &ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	/* You shouldn't be doing that at home. */
 	conn->hdmi.funcs = &reject_connector_hdmi_funcs;
 
@@ -1206,11 +1208,14 @@ static void drm_test_check_max_tmds_rate_bpc_fallback(struct kunit *test)
 	rate = drm_hdmi_compute_mode_clock(preferred, 10, HDMI_COLORSPACE_RGB);
 	KUNIT_ASSERT_LT(test, rate, info->max_tmds_clock * 1000);
 
 	drm_modeset_acquire_init(&ctx, 0);
 
-	ret = light_up_connector(test, drm, crtc, conn, preferred, &ctx);
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
+						     crtc, conn,
+						     preferred,
+						     &ctx);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 
 	conn_state = conn->state;
 	KUNIT_ASSERT_NOT_NULL(test, conn_state);
 
@@ -1280,11 +1285,14 @@ static void drm_test_check_max_tmds_rate_format_fallback(struct kunit *test)
 	rate = drm_hdmi_compute_mode_clock(preferred, 12, HDMI_COLORSPACE_YUV422);
 	KUNIT_ASSERT_LT(test, rate, info->max_tmds_clock * 1000);
 
 	drm_modeset_acquire_init(&ctx, 0);
 
-	ret = light_up_connector(test, drm, crtc, conn, preferred, &ctx);
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
+						     crtc, conn,
+						     preferred,
+						     &ctx);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 
 	conn_state = conn->state;
 	KUNIT_ASSERT_NOT_NULL(test, conn_state);
 
@@ -1345,11 +1353,14 @@ static void drm_test_check_output_bpc_format_vic_1(struct kunit *test)
 	KUNIT_ASSERT_LT(test, rate, info->max_tmds_clock * 1000);
 
 	drm_modeset_acquire_init(&ctx, 0);
 
 	crtc = priv->crtc;
-	ret = light_up_connector(test, drm, crtc, conn, mode, &ctx);
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
+						     crtc, conn,
+						     mode,
+						     &ctx);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 
 	conn_state = conn->state;
 	KUNIT_ASSERT_NOT_NULL(test, conn_state);
 
@@ -1412,11 +1423,14 @@ static void drm_test_check_output_bpc_format_driver_rgb_only(struct kunit *test)
 	rate = drm_hdmi_compute_mode_clock(preferred, 12, HDMI_COLORSPACE_YUV422);
 	KUNIT_ASSERT_LT(test, rate, info->max_tmds_clock * 1000);
 
 	drm_modeset_acquire_init(&ctx, 0);
 
-	ret = light_up_connector(test, drm, crtc, conn, preferred, &ctx);
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
+						     crtc, conn,
+						     preferred,
+						     &ctx);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 
 	conn_state = conn->state;
 	KUNIT_ASSERT_NOT_NULL(test, conn_state);
 
@@ -1481,11 +1495,14 @@ static void drm_test_check_output_bpc_format_display_rgb_only(struct kunit *test
 	rate = drm_hdmi_compute_mode_clock(preferred, 12, HDMI_COLORSPACE_YUV422);
 	KUNIT_ASSERT_LT(test, rate, info->max_tmds_clock * 1000);
 
 	drm_modeset_acquire_init(&ctx, 0);
 
-	ret = light_up_connector(test, drm, crtc, conn, preferred, &ctx);
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
+						     crtc, conn,
+						     preferred,
+						     &ctx);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 
 	conn_state = conn->state;
 	KUNIT_ASSERT_NOT_NULL(test, conn_state);
 
@@ -1541,11 +1558,14 @@ static void drm_test_check_output_bpc_format_driver_8bpc_only(struct kunit *test
 	rate = drm_hdmi_compute_mode_clock(preferred, 12, HDMI_COLORSPACE_RGB);
 	KUNIT_ASSERT_LT(test, rate, info->max_tmds_clock * 1000);
 
 	drm_modeset_acquire_init(&ctx, 0);
 
-	ret = light_up_connector(test, drm, crtc, conn, preferred, &ctx);
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
+						     crtc, conn,
+						     preferred,
+						     &ctx);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 
 	conn_state = conn->state;
 	KUNIT_ASSERT_NOT_NULL(test, conn_state);
 
@@ -1603,11 +1623,14 @@ static void drm_test_check_output_bpc_format_display_8bpc_only(struct kunit *tes
 	rate = drm_hdmi_compute_mode_clock(preferred, 12, HDMI_COLORSPACE_RGB);
 	KUNIT_ASSERT_LT(test, rate, info->max_tmds_clock * 1000);
 
 	drm_modeset_acquire_init(&ctx, 0);
 
-	ret = light_up_connector(test, drm, crtc, conn, preferred, &ctx);
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
+						     crtc, conn,
+						     preferred,
+						     &ctx);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 
 	conn_state = conn->state;
 	KUNIT_ASSERT_NOT_NULL(test, conn_state);
 
@@ -1643,11 +1666,14 @@ static void drm_test_check_disable_connector(struct kunit *test)
 	preferred = find_preferred_mode(conn);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 
 	drm = &priv->drm;
 	crtc = priv->crtc;
-	ret = light_up_connector(test, drm, crtc, conn, preferred, &ctx);
+	ret = drm_kunit_helper_enable_crtc_connector(test, drm,
+						     crtc, conn,
+						     preferred,
+						     &ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 

-- 
2.48.1


