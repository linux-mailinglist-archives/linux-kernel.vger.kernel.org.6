Return-Path: <linux-kernel+bounces-169912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C418BCF3B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 967BA1C21807
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 13:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79467E590;
	Mon,  6 May 2024 13:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1lVik91"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B60C7F476
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 13:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715002582; cv=none; b=DxDXULyDbWzcG01TCFBplLWadVrYdtdSkLbmwL3PX3aTjy5PJEDurGwTErLe0Iu6PRBRYWQAUDvVETkhep6CdM0rc29yTDQZY1rLZNCs+GLf+QV1BWYB202654jvLojtR+uKcLA8SYlw9iun9Rr+RiKGHIiCc30T+i/gzsWdTgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715002582; c=relaxed/simple;
	bh=MJDOXWqTjpbjsQTnGrv4MfUIC0eogdPWXfz9qOdcOCA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OXJ/V5N+APgo5B2Ltm7XOEZACBctmjaHEU8nEyij3AG+NKOZu9mOxccS6tcbGYGB2DCoV1/levnIWFufQQ3zUJyaeAgvuLy1WqnNUqSl+7aSdo1J8XzMDU8tmD22fKJCrWp/oyNhtvUSWCxfCV2LsBlWAm+OQtzlxR6+++MtrPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1lVik91; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466E6C3277B;
	Mon,  6 May 2024 13:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715002581;
	bh=MJDOXWqTjpbjsQTnGrv4MfUIC0eogdPWXfz9qOdcOCA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=K1lVik91lKB3BsVDt1TF6+YiO2iiiAcRRDupmDnuWDqXPQ8Od8Umgmb4EtrUlopDN
	 TsljnH30VDHb9P+oXMK37QRBqO5oRv6/iX8acZo2y6Yj1ilVudcgi2/5dhVKB6zuU1
	 8p28dpI+vQ1zLpqoQlNQvyptH0Di2CH2ZoyZcDbhk2ZnQ0bdp3AgZBWM+CE927F1+E
	 g3Pz48GTKs6FSdKTWpCdxE9cHzcI4mKi7htABfoi1FWHs4RFYma2htWtzGeGhx/ztz
	 y+g8VuQy5lKed4jXxjd1GUueDfwtuHIn8ERKlXRwtJfHgN27jbkcAqzRaKGXO13TAr
	 05eXigYD3g/ng==
From: Michael Walle <mwalle@kernel.org>
Date: Mon, 06 May 2024 15:34:45 +0200
Subject: [PATCH 16/20] drm/bridge: tc358775: use proper defines to
 configure LVDS timings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-tc358775-fix-powerup-v1-16-545dcf00b8dd@kernel.org>
References: <20240506-tc358775-fix-powerup-v1-0-545dcf00b8dd@kernel.org>
In-Reply-To: <20240506-tc358775-fix-powerup-v1-0-545dcf00b8dd@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sam Ravnborg <sam@ravnborg.org>, Vinay Simha BN <simhavcs@gmail.com>, 
 Tony Lindgren <tony@atomide.com>
Cc: Daniel Semkowicz <dse@thaumatec.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, Michael Walle <mwalle@kernel.org>
X-Mailer: b4 0.12.4

Provide bitfield macros for the individual fields in the LVDS timing
registers and get rid of the magic values.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/gpu/drm/bridge/tc358775.c | 52 +++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
index 33a97ddba7b5..c50554ec4b28 100644
--- a/drivers/gpu/drm/bridge/tc358775.c
+++ b/drivers/gpu/drm/bridge/tc358775.c
@@ -111,11 +111,19 @@
 #define VPCTRL_OPXLFMT	BIT(8)
 #define VPCTRL_EVTMODE	BIT(5)  /* Video event mode enable, tc35876x only */
 #define HTIM1           0x0454  /* Horizontal Timing Control 1 */
+#define HTIM1_HPW	GENMASK(8, 0)
+#define HTIM1_HBPR	GENMASK(24, 16)
 #define HTIM2           0x0458  /* Horizontal Timing Control 2 */
+#define HTIM2_HACT	GENMASK(10, 0)
+#define HTIM2_HFPR	GENMASK(24, 16)
 #define VTIM1           0x045C  /* Vertical Timing Control 1 */
+#define VTIM1_VPW	GENMASK(7, 0)
+#define VTIM1_VBPR	GENMASK(23, 16)
 #define VTIM2           0x0460  /* Vertical Timing Control 2 */
+#define VTIM2_VACT	GENMASK(10, 0)
+#define VTIM2_VFPR	GENMASK(23, 16)
 #define VFUEN           0x0464  /* Video Frame Timing Update Enable */
-#define VFUEN_EN	BIT(0)  /* Upload Enable */
+#define VFUEN_VFUEN	BIT(0)  /* Upload Enable */
 
 /* Mux Input Select for LVDS LINK Input */
 #define LV_MX0003        0x0480  /* Bit 0 to 3 */
@@ -346,24 +354,19 @@ static void tc358775_configure_dsi(struct tc_data *tc, unsigned int pixelclk)
 static void tc358775_configure_lvds_timings(struct tc_data *tc,
 					    struct drm_display_mode *mode)
 {
-	u32 hback_porch, hsync_len, hfront_porch, hactive, htime1, htime2;
-	u32 vback_porch, vsync_len, vfront_porch, vactive, vtime1, vtime2;
+	u32 hback_porch, hsync_len, hfront_porch, hactive;
+	u32 vback_porch, vsync_len, vfront_porch, vactive;
+	unsigned int val;
 
 	hback_porch = mode->htotal - mode->hsync_end;
 	hsync_len  = mode->hsync_end - mode->hsync_start;
+	hactive = mode->hdisplay;
+	hfront_porch = mode->hsync_start - mode->hdisplay;
+
 	vback_porch = mode->vtotal - mode->vsync_end;
 	vsync_len  = mode->vsync_end - mode->vsync_start;
-
-	htime1 = (hback_porch << 16) + hsync_len;
-	vtime1 = (vback_porch << 16) + vsync_len;
-
-	hfront_porch = mode->hsync_start - mode->hdisplay;
-	hactive = mode->hdisplay;
-	vfront_porch = mode->vsync_start - mode->vdisplay;
 	vactive = mode->vdisplay;
-
-	htime2 = (hfront_porch << 16) + hactive;
-	vtime2 = (vfront_porch << 16) + vactive;
+	vfront_porch = mode->vsync_start - mode->vdisplay;
 
 	/* Video event mode vs pulse mode bit, does not exist for tc358775 */
 	if (tc->type == TC358765)
@@ -379,12 +382,23 @@ static void tc358775_configure_lvds_timings(struct tc_data *tc,
 	regmap_update_bits(tc->regmap, VPCTRL, val,
 			   VPCTRL_OPXLFMT | VPCTRL_MSF | VPCTRL_EVTMODE);
 
-	regmap_write(tc->regmap, HTIM1, htime1);
-	regmap_write(tc->regmap, VTIM1, vtime1);
-	regmap_write(tc->regmap, HTIM2, htime2);
-	regmap_write(tc->regmap, VTIM2, vtime2);
+	val = u32_encode_bits(hsync_len, HTIM1_HPW);
+	val |= u32_encode_bits(hback_porch, HTIM1_HBPR);
+	regmap_write(tc->regmap, HTIM1, val);
+
+	val = u32_encode_bits(hactive, HTIM2_HACT);
+	val |= u32_encode_bits(hfront_porch, HTIM2_HFPR);
+	regmap_write(tc->regmap, HTIM2, val);
+
+	val = u32_encode_bits(vsync_len, VTIM1_VPW);
+	val |= u32_encode_bits(vback_porch, VTIM1_VBPR);
+	regmap_write(tc->regmap, VTIM1, val);
+
+	val = u32_encode_bits(vactive, VTIM2_VACT);
+	val |= u32_encode_bits(vfront_porch, VTIM2_VFPR);
+	regmap_write(tc->regmap, VTIM2, val);
 
-	regmap_write(tc->regmap, VFUEN, VFUEN_EN);
+	regmap_write(tc->regmap, VFUEN, VFUEN_VFUEN);
 }
 
 static const struct tc358775_pll_settings tc358775_pll_settings[] = {
@@ -475,7 +489,7 @@ static void tc358775_bridge_enable(struct drm_bridge *bridge)
 	tc358775_configure_lvds_timings(tc, mode);
 	tc358775_configure_pll(tc, mode->crtc_clock);
 	tc358775_configure_color_mapping(tc, connector->display_info.bus_formats[0]);
-	regmap_write(tc->regmap, VFUEN, VFUEN_EN);
+	regmap_write(tc->regmap, VFUEN, VFUEN_VFUEN);
 	tc358775_configure_lvds_clock(tc);
 
 	/* Finally, enable the LVDS transmitter */

-- 
2.39.2


