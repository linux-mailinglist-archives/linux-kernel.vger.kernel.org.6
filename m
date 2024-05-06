Return-Path: <linux-kernel+bounces-169905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 758448BCF2E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 032C51F21622
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 13:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE2078C8B;
	Mon,  6 May 2024 13:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9hLaZa9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC43C78C89
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 13:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715002547; cv=none; b=COWxCp/Oji4HNfAVtv3E6C0CL3fZlPxkoBZ9cPXX3T4oP1B6q0CrJw8z5LSoZXxtOk5cRusQ1OW/vGM3UI9vNg7LynZeuqWgC8F7xNIA9AkxNZa3JX5YQUlxSYXp/Yx8z9jW6cLyXwJTXQA9AQBCi7lbHON+oavQJTwV8dwUDNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715002547; c=relaxed/simple;
	bh=gBI1ftlJZK9GLIPJr/NbCBA/Qls8YZkI0rH9liGw82E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TjN/wzv7y6+WMqIoq03Gs0RaotAGVqLxqQK9dSI6Owr3bFgxz7TX7NmJu4le8mGuEaYQfoccN6ZUdF04hnuRnqJeJ5snKsgbQmMJqlEc20BsmNy7Eavo5qmO1jfibuwIaiPJjitmpKt7xoKtqI1a05h+u8Uuy+25k+I98Ltp2NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9hLaZa9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2EAC4AF67;
	Mon,  6 May 2024 13:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715002547;
	bh=gBI1ftlJZK9GLIPJr/NbCBA/Qls8YZkI0rH9liGw82E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=h9hLaZa9H6GjxzIZRfYYsRrPiaEmUBLgk6uaHxdbdFwp22Q8cgdEsaIYiY/Rf9Ypn
	 lKfCsi5ROojUiHyhphcOKtuGgMn09uF3w7sGI7DHHmw2wJfmOSWNqILS6JyTqtR9mI
	 vTuU+4CE27bz6NZqk7YLmD41xVHbRzFLlUmbvDv8txUgLoEyF8D9AvcZ7zPiVB+ui8
	 TvBIrBVQR0u5CFL8Bwl8nowBUbU/Ns+7KxHFwvblEdcotqt5Gym8KN1BTbu6g1+FR8
	 AGjo26xCkv+3PXBt4SaWMbcRwgdKOz6aL0v5qHB8opihXv97Ht6PM7oKtG2bMOFK4c
	 cxXwl1Tzm7rXg==
From: Michael Walle <mwalle@kernel.org>
Date: Mon, 06 May 2024 15:34:38 +0200
Subject: [PATCH 09/20] drm/bridge: tc358775: remove complex vsdelay
 calculation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240506-tc358775-fix-powerup-v1-9-545dcf00b8dd@kernel.org>
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

To cite the datasheet on VSDELAY:
  During DSI link speed is slower than that of LVDS link’s, data needs
  to be buffer within 775XBG before outputting to prevent data from
  underflow. Register field VPCTRL[VSDELAY] is used to for this purpose

This driver assumes that the DSI link speed is the pixel clock (as does
every DSI bridge driver), after all the LVDS clock is derived from the
DSI clock. Thus we know for a fact, that the DSI link is not slower than
the LVDS side. Just use the (sane) default value of the bridge and drop
the complicated calculation here.

While at it, replace the TC358775_VPCTRL_MSF() and
TC358775_VPCTRL_OPXLFMT() inline functions by the usual macros for a bit
flag.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/gpu/drm/bridge/tc358775.c | 49 +++++++--------------------------------
 1 file changed, 8 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
index 54aea58a3406..a9d731e87970 100644
--- a/drivers/gpu/drm/bridge/tc358775.c
+++ b/drivers/gpu/drm/bridge/tc358775.c
@@ -109,7 +109,9 @@
 #define RDPKTLN         0x0404  /* Command Read Packet Length */
 
 #define VPCTRL          0x0450  /* Video Path Control */
-#define EVTMODE		BIT(5)  /* Video event mode enable, tc35876x only */
+#define VPCTRL_MSF	BIT(0)
+#define VPCTRL_OPXLFMT	BIT(8)
+#define VPCTRL_EVTMODE	BIT(5)  /* Video event mode enable, tc35876x only */
 #define HTIM1           0x0454  /* Horizontal Timing Control 1 */
 #define HTIM2           0x0458  /* Horizontal Timing Control 2 */
 #define VTIM1           0x045C  /* Vertical Timing Control 1 */
@@ -187,30 +189,6 @@ enum {
 
 #define L0EN BIT(1)
 
-#define TC358775_VPCTRL_VSDELAY__MASK	0x3FF00000
-#define TC358775_VPCTRL_VSDELAY__SHIFT	20
-static inline u32 TC358775_VPCTRL_VSDELAY(uint32_t val)
-{
-	return ((val) << TC358775_VPCTRL_VSDELAY__SHIFT) &
-			TC358775_VPCTRL_VSDELAY__MASK;
-}
-
-#define TC358775_VPCTRL_OPXLFMT__MASK	0x00000100
-#define TC358775_VPCTRL_OPXLFMT__SHIFT	8
-static inline u32 TC358775_VPCTRL_OPXLFMT(uint32_t val)
-{
-	return ((val) << TC358775_VPCTRL_OPXLFMT__SHIFT) &
-			TC358775_VPCTRL_OPXLFMT__MASK;
-}
-
-#define TC358775_VPCTRL_MSF__MASK	0x00000001
-#define TC358775_VPCTRL_MSF__SHIFT	0
-static inline u32 TC358775_VPCTRL_MSF(uint32_t val)
-{
-	return ((val) << TC358775_VPCTRL_MSF__SHIFT) &
-			TC358775_VPCTRL_MSF__MASK;
-}
-
 #define TC358775_LVCFG_PCLKDIV__MASK	0x000000f0
 #define TC358775_LVCFG_PCLKDIV__SHIFT	4
 static inline u32 TC358775_LVCFG_PCLKDIV(uint32_t val)
@@ -350,7 +328,6 @@ static void tc_bridge_enable(struct drm_bridge *bridge)
 	u32 hback_porch, hsync_len, hfront_porch, hactive, htime1, htime2;
 	u32 vback_porch, vsync_len, vfront_porch, vactive, vtime1, vtime2;
 	unsigned int val = 0;
-	u16 dsiclk, clkdiv, byteclk, t1, t2, t3, vsdelay;
 	struct drm_display_mode *mode;
 	struct drm_connector *connector = get_connector(bridge->encoder);
 
@@ -398,27 +375,17 @@ static void tc_bridge_enable(struct drm_bridge *bridge)
 
 	/* Video event mode vs pulse mode bit, does not exist for tc358775 */
 	if (tc->type == TC358765)
-		val = EVTMODE;
+		val = VPCTRL_EVTMODE;
 	else
 		val = 0;
 
 	if (tc->bpc == 8)
-		val |= TC358775_VPCTRL_OPXLFMT(1);
+		val |= VPCTRL_OPXLFMT;
 	else /* bpc = 6; */
-		val |= TC358775_VPCTRL_MSF(1);
-
-	dsiclk = mode->crtc_clock * 3 * tc->bpc / tc->num_dsi_lanes / 1000;
-	clkdiv = dsiclk / (tc->lvds_link == DUAL_LINK ? DIVIDE_BY_6 : DIVIDE_BY_3);
-	byteclk = dsiclk / 4;
-	t1 = hactive * (tc->bpc * 3 / 8) / tc->num_dsi_lanes;
-	t2 = ((100000 / clkdiv)) * (hactive + hback_porch + hsync_len + hfront_porch) / 1000;
-	t3 = ((t2 * byteclk) / 100) - (hactive * (tc->bpc * 3 / 8) /
-		tc->num_dsi_lanes);
-
-	vsdelay = (clkdiv * (t1 + t3) / byteclk) - hback_porch - hsync_len - hactive;
+		val |= VPCTRL_MSF;
 
-	val |= TC358775_VPCTRL_VSDELAY(vsdelay);
-	regmap_write(tc->regmap, VPCTRL, val);
+	regmap_update_bits(tc->regmap, VPCTRL, val,
+			   VPCTRL_OPXLFMT | VPCTRL_MSF | VPCTRL_EVTMODE);
 
 	regmap_write(tc->regmap, HTIM1, htime1);
 	regmap_write(tc->regmap, VTIM1, vtime1);

-- 
2.39.2


