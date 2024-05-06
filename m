Return-Path: <linux-kernel+bounces-169909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8E28BCF36
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2341C28543C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 13:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3277E0EA;
	Mon,  6 May 2024 13:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVFhg8v8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DA87E576
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 13:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715002567; cv=none; b=foCcPM2dT3zonpUo3q5CO0mN3Ziao5aR3ZATRIcr+gCX2LLJ8IzddP2GcHbb7InzSTWDaeXwPFcEiq7lD9VHoXOAoWF4i3tH58wBqZ1MxwJHT2BrpsBf84L4D/Mtx/tQsG9nKtX2I0gX3xJdV7fM367I6EV51eY6urAjxSgHDKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715002567; c=relaxed/simple;
	bh=U++vjZErufFCzBdu3b4IcIRynyBzsebPGzPRgF2N9j8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y1cifJUeqrorAh19nGTiR4iXo3eumrmMn4kLdMMfV4vzjKtWwiNKnjW8ayhxYLLMCNnuKF/ZJmMGLyBOGuAVU7w2cay9iXJ0IL9WaNOHdXKu/xVl2VBN/zX0V90YEuZzK1DNUPiNI8+43P7yIILMIZLU7KUsouWBqDRjh6b5nfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVFhg8v8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6785C4AF66;
	Mon,  6 May 2024 13:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715002567;
	bh=U++vjZErufFCzBdu3b4IcIRynyBzsebPGzPRgF2N9j8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bVFhg8v8Sjt3je+jx9V+ucQn1tO2VT3Sn8/8uR0jztaop6jADw4URV/VItTkMWpVv
	 yXLl84B1pUIEw50a6eOsJLAgZIvDrPe9QHRXHvVHEXlIYv+pm+2BYfZ7iI6fYt7sbO
	 iWC/zqCo5fkt/DuKjbYsoSIpvrB2sHw+xjajZmc/ftQFCt5g9kFzE9uAsuylRWYJtI
	 P6tZVOhXy8UyTvfOW5HWv9N/t7uM+E2la+YsJqxmef5jbn11skzxpN6rkHFkYs6Wq3
	 /f5RRbBPljplEG39SKnz0EOWndsiaXNwokcouyhZrSFxLQDY6aHUj8dSPsv56DxrU7
	 Dne4rwX77cUjQ==
From: Michael Walle <mwalle@kernel.org>
Date: Mon, 06 May 2024 15:34:42 +0200
Subject: [PATCH 13/20] drm/bridge: tc358775: split the init code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-tc358775-fix-powerup-v1-13-545dcf00b8dd@kernel.org>
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

Split the initialization code in tc_bridge_enable() into specific
functions. This is a preparation for further code cleanup and fixes.

No functional change.

While at it, rename tc_bridge_enable() to the more specific
tc358775_bridge_enable().

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/gpu/drm/bridge/tc358775.c | 106 ++++++++++++++++++++++++--------------
 1 file changed, 66 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
index eea41054c6fa..4ec059531c5f 100644
--- a/drivers/gpu/drm/bridge/tc358775.c
+++ b/drivers/gpu/drm/bridge/tc358775.c
@@ -308,18 +308,30 @@ static const struct reg_sequence tc_lvmux_jeida18_24[] = {
 	{ LV_MX2427, LV_MX(LVI_HS, LVI_VS, LVI_DE, LVI_R0) },
 };
 
-static void tc_bridge_enable(struct drm_bridge *bridge)
+static void tc358775_configure_dsi(struct tc_data *tc)
+{
+	unsigned int val;
+
+	regmap_write(tc->regmap, PPI_TX_RX_TA, TTA_GET | TTA_SURE);
+	regmap_write(tc->regmap, PPI_LPTXTIMECNT, LPX_PERIOD);
+	regmap_write(tc->regmap, PPI_D0S_CLRSIPOCOUNT, 3);
+	regmap_write(tc->regmap, PPI_D1S_CLRSIPOCOUNT, 3);
+	regmap_write(tc->regmap, PPI_D2S_CLRSIPOCOUNT, 3);
+	regmap_write(tc->regmap, PPI_D3S_CLRSIPOCOUNT, 3);
+
+	val = ((L0EN << tc->num_dsi_lanes) - L0EN) | DSI_CLEN_BIT;
+	regmap_write(tc->regmap, PPI_LANEENABLE, val);
+	regmap_write(tc->regmap, DSI_LANEENABLE, val);
+
+	regmap_write(tc->regmap, PPI_STARTPPI, PPI_START_FUNCTION);
+	regmap_write(tc->regmap, DSI_STARTDSI, DSI_RX_START);
+}
+
+static void tc358775_configure_lvds_timings(struct tc_data *tc,
+					    struct drm_display_mode *mode)
 {
-	struct tc_data *tc = bridge_to_tc(bridge);
 	u32 hback_porch, hsync_len, hfront_porch, hactive, htime1, htime2;
 	u32 vback_porch, vsync_len, vfront_porch, vactive, vtime1, vtime2;
-	int bpp = mipi_dsi_pixel_format_to_bpp(tc->dsi->format);
-	int clkdiv;
-	unsigned int val = 0;
-	struct drm_display_mode *mode;
-	struct drm_connector *connector = get_connector(bridge->encoder);
-
-	mode = &bridge->encoder->crtc->state->adjusted_mode;
 
 	hback_porch = mode->htotal - mode->hsync_end;
 	hsync_len  = mode->hsync_end - mode->hsync_start;
@@ -337,30 +349,6 @@ static void tc_bridge_enable(struct drm_bridge *bridge)
 	htime2 = (hfront_porch << 16) + hactive;
 	vtime2 = (vfront_porch << 16) + vactive;
 
-	regmap_read(tc->regmap, IDREG, &val);
-
-	dev_info(tc->dev, "DSI2LVDS Chip ID.%02x Revision ID. %02x **\n",
-		 (val >> 8) & 0xFF, val & 0xFF);
-
-	regmap_write(tc->regmap, SYSRST,
-		     SYS_RST_REG | SYS_RST_DSIRX | SYS_RST_BM | SYS_RST_LCD |
-		     SYS_RST_I2CM);
-	usleep_range(30000, 40000);
-
-	regmap_write(tc->regmap, PPI_TX_RX_TA, TTA_GET | TTA_SURE);
-	regmap_write(tc->regmap, PPI_LPTXTIMECNT, LPX_PERIOD);
-	regmap_write(tc->regmap, PPI_D0S_CLRSIPOCOUNT, 3);
-	regmap_write(tc->regmap, PPI_D1S_CLRSIPOCOUNT, 3);
-	regmap_write(tc->regmap, PPI_D2S_CLRSIPOCOUNT, 3);
-	regmap_write(tc->regmap, PPI_D3S_CLRSIPOCOUNT, 3);
-
-	val = ((L0EN << tc->num_dsi_lanes) - L0EN) | DSI_CLEN_BIT;
-	regmap_write(tc->regmap, PPI_LANEENABLE, val);
-	regmap_write(tc->regmap, DSI_LANEENABLE, val);
-
-	regmap_write(tc->regmap, PPI_STARTPPI, PPI_START_FUNCTION);
-	regmap_write(tc->regmap, DSI_STARTDSI, DSI_RX_START);
-
 	/* Video event mode vs pulse mode bit, does not exist for tc358775 */
 	if (tc->type == TC358765)
 		val = VPCTRL_EVTMODE;
@@ -381,20 +369,31 @@ static void tc_bridge_enable(struct drm_bridge *bridge)
 	regmap_write(tc->regmap, VTIM2, vtime2);
 
 	regmap_write(tc->regmap, VFUEN, VFUEN_EN);
+}
+
+static void tc358775_configure_pll(struct tc_data *tc, int pixelclk)
+{
 	regmap_write(tc->regmap, SYSRST, SYS_RST_LCD);
 	regmap_write(tc->regmap, LVPHY0, LV_PHY0_PRBS_ON(4) | LV_PHY0_ND(6));
+}
 
-	dev_dbg(tc->dev, "bus_formats %04x bpc %d\n",
-		connector->display_info.bus_formats[0],
-		tc->bpc);
-	if (connector->display_info.bus_formats[0] == MEDIA_BUS_FMT_RGB888_1X7X4_SPWG)
+static void tc358775_configure_color_mapping(struct tc_data *tc, u32 fmt)
+{
+	dev_dbg(tc->dev, "bus_formats %04x bpc %d\n", fmt, tc->bpc);
+
+	if (fmt == MEDIA_BUS_FMT_RGB888_1X7X4_SPWG)
 		regmap_multi_reg_write(tc->regmap, tc_lvmux_vesa24,
 				       ARRAY_SIZE(tc_lvmux_vesa24));
 	else
 		regmap_multi_reg_write(tc->regmap, tc_lvmux_jeida18_24,
 				       ARRAY_SIZE(tc_lvmux_jeida18_24));
+}
 
-	regmap_write(tc->regmap, VFUEN, VFUEN_EN);
+static void tc358775_configure_lvds_clock(struct tc_data *tc)
+{
+	int bpp = mipi_dsi_pixel_format_to_bpp(tc->dsi->format);
+	unsigned int val;
+	int clkdiv;
 
 	/* Configure LVDS clock */
 	clkdiv = bpp / tc->num_dsi_lanes;
@@ -407,9 +406,36 @@ static void tc_bridge_enable(struct drm_bridge *bridge)
 		val |= LVCFG_LVDLINK;
 
 	regmap_write(tc->regmap, LVCFG, val);
+}
+
+static void tc358775_bridge_enable(struct drm_bridge *bridge)
+{
+	struct tc_data *tc = bridge_to_tc(bridge);
+	unsigned int val = 0;
+	struct drm_display_mode *mode;
+	struct drm_connector *connector = get_connector(bridge->encoder);
+
+	mode = &bridge->encoder->crtc->state->adjusted_mode;
+
+	regmap_read(tc->regmap, IDREG, &val);
+
+	dev_info(tc->dev, "DSI2LVDS Chip ID.%02x Revision ID. %02x **\n",
+		 (val >> 8) & 0xFF, val & 0xFF);
+
+	regmap_write(tc->regmap, SYSRST,
+		     SYS_RST_REG | SYS_RST_DSIRX | SYS_RST_BM | SYS_RST_LCD |
+		     SYS_RST_I2CM);
+	usleep_range(30000, 40000);
+
+	tc358775_configure_dsi(tc);
+	tc358775_configure_lvds_timings(tc, mode);
+	tc358775_configure_pll(tc, mode->crtc_clock);
+	tc358775_configure_color_mapping(tc, connector->display_info.bus_formats[0]);
+	regmap_write(tc->regmap, VFUEN, VFUEN_EN);
+	tc358775_configure_lvds_clock(tc);
 
 	/* Finally, enable the LVDS transmitter */
-	regmap_write(tc->regmap, LVCFG, val | LVCFG_LVEN);
+	regmap_update_bits(tc->regmap, LVCFG, LVCFG_LVEN, LVCFG_LVEN);
 }
 
 /*
@@ -543,7 +569,7 @@ static int tc_bridge_attach(struct drm_bridge *bridge,
 static const struct drm_bridge_funcs tc_bridge_funcs = {
 	.attach = tc_bridge_attach,
 	.pre_enable = tc_bridge_pre_enable,
-	.enable = tc_bridge_enable,
+	.enable = tc358775_bridge_enable,
 	.mode_fixup = tc_mode_fixup,
 	.mode_valid = tc_mode_valid,
 	.post_disable = tc_bridge_post_disable,

-- 
2.39.2


