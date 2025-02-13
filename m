Return-Path: <linux-kernel+bounces-513208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCDEA343CB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAA7A3B0741
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055DD241698;
	Thu, 13 Feb 2025 14:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXnbw9du"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A56F242924
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457936; cv=none; b=C5mjN15flMFL1E4kj7INzV8d9GKVolRPgzKll6e6aqTsuA7MwwsjsX0ey3IpvCmG9UR3LaXHQwg1toPB00Pgv26VxRBipeTVRlX6EXkKIqkLxCnxFwu/r1gz+nJCTcQKNBNF3N6GlewRoKdYJ2AW5awgPl7PBhnNGTvj2MFjJ10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457936; c=relaxed/simple;
	bh=PK2zAFM2ZRvrvU2hnJ7CHHpNERjHdQrZwoJd3TX5Pjc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NWZlY2M+BGR5JoSM9MzKPfFthoWkoheIvCd1bLZU5EuGRHNsQCOpJxKYl8i4HanGlgnZziGyFz05/uG+EnAnYVVBWNEEBOBFDawJ14ueO8Lwc7uRiuEX1pdt3ULbNiN1ddk6TKPfMv5lIZY5NDozqoKpHLg4NSR7+f4aQXfwf1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXnbw9du; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93C8C4CED1;
	Thu, 13 Feb 2025 14:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739457936;
	bh=PK2zAFM2ZRvrvU2hnJ7CHHpNERjHdQrZwoJd3TX5Pjc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SXnbw9duCRYyLxZ+RTCGme6NXm7LFzYzpw/SBaKdWBm+9pycE1qG+ZfdqfXOtDzsc
	 mHmIlD7JIjRcaa0TW5hUvxxlc0mq8dBII8hweGDXhafqArII/lRruXtT7fU2DeF3yL
	 KOH5dj2h4hexKd93ALoLZybHJJTSfLgNpY3JYk7xsqA0QqDKKU93y/pCAsnePkd31U
	 1CmPC+JZeYoNih4pPT5snfQMOg+oRkHVm+O2g8uaHKvTDNUOKUM4dFg9nZNAFcwphJ
	 QNTeF40iAhaAmeKzQJ0hhOtzjd6KkY7pYNqk+fILckEuPlavc3ACxcE2BGhg4b4nvx
	 nd/SBAPh7NyUg==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 13 Feb 2025 15:43:56 +0100
Subject: [PATCH v3 37/37] drm/bridge: ti-sn65dsi86: Use bridge_state crtc
 pointer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-bridge-connector-v3-37-e71598f49c8f@kernel.org>
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
In-Reply-To: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9298; i=mripard@kernel.org;
 h=from:subject:message-id; bh=PK2zAFM2ZRvrvU2hnJ7CHHpNERjHdQrZwoJd3TX5Pjc=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDOnrWNU0NrprMvb7HdlrWp3LMS3e6TTnyTnuzr8ZoiUas
 0OrDrd1TGVhEOZkkBVTZHkiE3Z6efviKgf7lT9g5rAygQxh4OIUgIlYcjI2rDzYN3VPhtRnNc5n
 lR+2dVp93JtS3Z3QZGZ9+GnO4f873kTtPfSQu6H4bXttzoTYR6HTGRteJ6RWP70xa6b3BYPigs2
 xlo5HDSyjD9wLWfpom7i2mtj+nF6Tp2t2rQxJWx7Rf3VjmA0A
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The TI sn65dsi86 driver follows the drm_encoder->crtc pointer that is
deprecated and shouldn't be used by atomic drivers.

This was due to the fact that we did't have any other alternative to
retrieve the CRTC pointer. Fortunately, the crtc pointer is now provided
in the bridge state, so we can move to atomic callbacks and drop that
deprecated pointer usage.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 58 +++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 066a65eb03ede1cb5bcbc4511381adb9406f923b..99b24d2b3e295d1cdfa7b780312d75d3b6fe4903 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -241,15 +241,28 @@ static void ti_sn65dsi86_write_u16(struct ti_sn65dsi86 *pdata,
 	u8 buf[2] = { val & 0xff, val >> 8 };
 
 	regmap_bulk_write(pdata->regmap, reg, buf, ARRAY_SIZE(buf));
 }
 
-static u32 ti_sn_bridge_get_dsi_freq(struct ti_sn65dsi86 *pdata)
+static struct drm_display_mode *
+get_new_adjusted_display_mode(struct drm_bridge *bridge,
+			      struct drm_atomic_state *state)
+{
+	struct drm_bridge_state *bridge_state =
+		drm_atomic_get_new_bridge_state(state, bridge);
+	struct drm_crtc_state *crtc_state =
+		drm_atomic_get_new_crtc_state(state, bridge_state->crtc);
+
+	return &crtc_state->adjusted_mode;
+}
+
+static u32 ti_sn_bridge_get_dsi_freq(struct ti_sn65dsi86 *pdata,
+				     struct drm_atomic_state *state)
 {
 	u32 bit_rate_khz, clk_freq_khz;
 	struct drm_display_mode *mode =
-		&pdata->bridge.encoder->crtc->state->adjusted_mode;
+		get_new_adjusted_display_mode(&pdata->bridge, state);
 
 	bit_rate_khz = mode->clock *
 			mipi_dsi_pixel_format_to_bpp(pdata->dsi->format);
 	clk_freq_khz = bit_rate_khz / (pdata->dsi->lanes * 2);
 
@@ -272,11 +285,12 @@ static const u32 ti_sn_bridge_dsiclk_lut[] = {
 	416000000,
 	486000000,
 	460800000,
 };
 
-static void ti_sn_bridge_set_refclk_freq(struct ti_sn65dsi86 *pdata)
+static void ti_sn_bridge_set_refclk_freq(struct ti_sn65dsi86 *pdata,
+					 struct drm_atomic_state *state)
 {
 	int i;
 	u32 refclk_rate;
 	const u32 *refclk_lut;
 	size_t refclk_lut_size;
@@ -285,11 +299,11 @@ static void ti_sn_bridge_set_refclk_freq(struct ti_sn65dsi86 *pdata)
 		refclk_rate = clk_get_rate(pdata->refclk);
 		refclk_lut = ti_sn_bridge_refclk_lut;
 		refclk_lut_size = ARRAY_SIZE(ti_sn_bridge_refclk_lut);
 		clk_prepare_enable(pdata->refclk);
 	} else {
-		refclk_rate = ti_sn_bridge_get_dsi_freq(pdata) * 1000;
+		refclk_rate = ti_sn_bridge_get_dsi_freq(pdata, state) * 1000;
 		refclk_lut = ti_sn_bridge_dsiclk_lut;
 		refclk_lut_size = ARRAY_SIZE(ti_sn_bridge_dsiclk_lut);
 	}
 
 	/* for i equals to refclk_lut_size means default frequency */
@@ -309,16 +323,17 @@ static void ti_sn_bridge_set_refclk_freq(struct ti_sn65dsi86 *pdata)
 	 * regardless of its actual sourcing.
 	 */
 	pdata->pwm_refclk_freq = ti_sn_bridge_refclk_lut[i];
 }
 
-static void ti_sn65dsi86_enable_comms(struct ti_sn65dsi86 *pdata)
+static void ti_sn65dsi86_enable_comms(struct ti_sn65dsi86 *pdata,
+				      struct drm_atomic_state *state)
 {
 	mutex_lock(&pdata->comms_mutex);
 
 	/* configure bridge ref_clk */
-	ti_sn_bridge_set_refclk_freq(pdata);
+	ti_sn_bridge_set_refclk_freq(pdata, state);
 
 	/*
 	 * HPD on this bridge chip is a bit useless.  This is an eDP bridge
 	 * so the HPD is an internal signal that's only there to signal that
 	 * the panel is done powering up.  ...but the bridge chip debounces
@@ -374,11 +389,11 @@ static int __maybe_unused ti_sn65dsi86_resume(struct device *dev)
 	 * so we can do it in resume which lets us read the EDID before
 	 * pre_enable(). Without a reference clock we need the MIPI reference
 	 * clock so reading early doesn't work.
 	 */
 	if (pdata->refclk)
-		ti_sn65dsi86_enable_comms(pdata);
+		ti_sn65dsi86_enable_comms(pdata, NULL);
 
 	return ret;
 }
 
 static int __maybe_unused ti_sn65dsi86_suspend(struct device *dev)
@@ -820,16 +835,17 @@ static void ti_sn_bridge_atomic_disable(struct drm_bridge *bridge,
 
 	/* disable video stream */
 	regmap_update_bits(pdata->regmap, SN_ENH_FRAME_REG, VSTREAM_ENABLE, 0);
 }
 
-static void ti_sn_bridge_set_dsi_rate(struct ti_sn65dsi86 *pdata)
+static void ti_sn_bridge_set_dsi_rate(struct ti_sn65dsi86 *pdata,
+				      struct drm_atomic_state *state)
 {
 	unsigned int bit_rate_mhz, clk_freq_mhz;
 	unsigned int val;
 	struct drm_display_mode *mode =
-		&pdata->bridge.encoder->crtc->state->adjusted_mode;
+		get_new_adjusted_display_mode(&pdata->bridge, state);
 
 	/* set DSIA clk frequency */
 	bit_rate_mhz = (mode->clock / 1000) *
 			mipi_dsi_pixel_format_to_bpp(pdata->dsi->format);
 	clk_freq_mhz = bit_rate_mhz / (pdata->dsi->lanes * 2);
@@ -855,16 +871,18 @@ static unsigned int ti_sn_bridge_get_bpp(struct drm_connector *connector)
  */
 static const unsigned int ti_sn_bridge_dp_rate_lut[] = {
 	0, 1620, 2160, 2430, 2700, 3240, 4320, 5400
 };
 
-static int ti_sn_bridge_calc_min_dp_rate_idx(struct ti_sn65dsi86 *pdata, unsigned int bpp)
+static int ti_sn_bridge_calc_min_dp_rate_idx(struct ti_sn65dsi86 *pdata,
+					     struct drm_atomic_state *state,
+					     unsigned int bpp)
 {
 	unsigned int bit_rate_khz, dp_rate_mhz;
 	unsigned int i;
 	struct drm_display_mode *mode =
-		&pdata->bridge.encoder->crtc->state->adjusted_mode;
+		get_new_adjusted_display_mode(&pdata->bridge, state);
 
 	/* Calculate minimum bit rate based on our pixel clock. */
 	bit_rate_khz = mode->clock * bpp;
 
 	/* Calculate minimum DP data rate, taking 80% as per DP spec */
@@ -959,14 +977,15 @@ static unsigned int ti_sn_bridge_read_valid_rates(struct ti_sn65dsi86 *pdata)
 	}
 
 	return valid_rates;
 }
 
-static void ti_sn_bridge_set_video_timings(struct ti_sn65dsi86 *pdata)
+static void ti_sn_bridge_set_video_timings(struct ti_sn65dsi86 *pdata,
+					   struct drm_atomic_state *state)
 {
 	struct drm_display_mode *mode =
-		&pdata->bridge.encoder->crtc->state->adjusted_mode;
+		get_new_adjusted_display_mode(&pdata->bridge, state);
 	u8 hsync_polarity = 0, vsync_polarity = 0;
 
 	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
 		hsync_polarity = CHA_HSYNC_POLARITY;
 	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
@@ -1075,21 +1094,22 @@ static int ti_sn_link_training(struct ti_sn65dsi86 *pdata, int dp_rate_idx,
 
 static void ti_sn_bridge_atomic_enable(struct drm_bridge *bridge,
 				       struct drm_atomic_state *state)
 {
 	struct ti_sn65dsi86 *pdata = bridge_to_ti_sn65dsi86(bridge);
+	struct drm_bridge_state *bridge_state;
 	struct drm_connector *connector;
 	const char *last_err_str = "No supported DP rate";
 	unsigned int valid_rates;
 	int dp_rate_idx;
 	unsigned int val;
 	int ret = -EINVAL;
 	int max_dp_lanes;
 	unsigned int bpp;
 
-	connector = drm_atomic_get_new_connector_for_encoder(state,
-							     bridge->encoder);
+	bridge_state = drm_atomic_get_new_bridge_state(state, bridge);
+	connector = bridge_state->connector;
 	if (!connector) {
 		dev_err_ratelimited(pdata->dev, "Could not get the connector\n");
 		return;
 	}
 
@@ -1104,11 +1124,11 @@ static void ti_sn_bridge_atomic_enable(struct drm_bridge *bridge,
 	regmap_write(pdata->regmap, SN_LN_ASSIGN_REG, pdata->ln_assign);
 	regmap_update_bits(pdata->regmap, SN_ENH_FRAME_REG, LN_POLRS_MASK,
 			   pdata->ln_polrs << LN_POLRS_OFFSET);
 
 	/* set dsi clk frequency value */
-	ti_sn_bridge_set_dsi_rate(pdata);
+	ti_sn_bridge_set_dsi_rate(pdata, state);
 
 	/*
 	 * The SN65DSI86 only supports ASSR Display Authentication method and
 	 * this method is enabled for eDP panels. An eDP panel must support this
 	 * authentication method. We need to enable this method in the eDP panel
@@ -1139,11 +1159,11 @@ static void ti_sn_bridge_atomic_enable(struct drm_bridge *bridge,
 			   val);
 
 	valid_rates = ti_sn_bridge_read_valid_rates(pdata);
 
 	/* Train until we run out of rates */
-	for (dp_rate_idx = ti_sn_bridge_calc_min_dp_rate_idx(pdata, bpp);
+	for (dp_rate_idx = ti_sn_bridge_calc_min_dp_rate_idx(pdata, state, bpp);
 	     dp_rate_idx < ARRAY_SIZE(ti_sn_bridge_dp_rate_lut);
 	     dp_rate_idx++) {
 		if (!(valid_rates & BIT(dp_rate_idx)))
 			continue;
 
@@ -1155,11 +1175,11 @@ static void ti_sn_bridge_atomic_enable(struct drm_bridge *bridge,
 		DRM_DEV_ERROR(pdata->dev, "%s (%d)\n", last_err_str, ret);
 		return;
 	}
 
 	/* config video parameters */
-	ti_sn_bridge_set_video_timings(pdata);
+	ti_sn_bridge_set_video_timings(pdata, state);
 
 	/* enable video stream */
 	regmap_update_bits(pdata->regmap, SN_ENH_FRAME_REG, VSTREAM_ENABLE,
 			   VSTREAM_ENABLE);
 }
@@ -1170,11 +1190,11 @@ static void ti_sn_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 	struct ti_sn65dsi86 *pdata = bridge_to_ti_sn65dsi86(bridge);
 
 	pm_runtime_get_sync(pdata->dev);
 
 	if (!pdata->refclk)
-		ti_sn65dsi86_enable_comms(pdata);
+		ti_sn65dsi86_enable_comms(pdata, state);
 
 	/* td7: min 100 us after enable before DSI data */
 	usleep_range(100, 110);
 }
 

-- 
2.48.0


