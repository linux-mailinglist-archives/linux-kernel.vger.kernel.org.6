Return-Path: <linux-kernel+bounces-169919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C7F8BCF4B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1A72B214A4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 13:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B80A12AADC;
	Mon,  6 May 2024 13:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOxWWLGo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B971D12AACE
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 13:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715002596; cv=none; b=RkVWtz+6pZwMAIV/HVMi0mcxyOrzQekLDwmz/jIh3tR6ZSIdwL4zwmVBZtvYL1MEydcF9k8G/Tw1VqETvCMuAlmq/H79YZDqynNFxEV7X6973Qp5o8dtPNtATxMbj6h4aOJBLSP0MYvPRzu0g6Hs3wWVztotsD9JnuLU1V1SkVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715002596; c=relaxed/simple;
	bh=7pxQETmnu6FGrgnJHaKGqthAffDCBJczpSl2HJqrSW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QeSiZMIxcegNKVFZ7yL+7h8D5UbrBVLKjg3x0qzIMg0hBznTLxX+lMo3eB9d5vCPnLGe8HH6pgYB68hZIJFgA/GIdzLl8MzcjUPqYyb21ZvWkBGeIXuU60/SIXzDM2MClLy53N5Y/N46DXL9sSbJcP71BiJ8AYvLI42kHSLv3vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOxWWLGo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8ABDC3277B;
	Mon,  6 May 2024 13:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715002596;
	bh=7pxQETmnu6FGrgnJHaKGqthAffDCBJczpSl2HJqrSW8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fOxWWLGouwuxi+wtZp8YtrRVkgU+b1Md5gkgRMvCNTI0WHqGG64jKKjij/9oaKJ3s
	 bLoUZW4xYs9HGkNT1sOgk2kdRXx0nh+SNgIWMfWC241S7gj0ytO3pLM2I87IqpkEtM
	 shFabsZBvgkh26S5AbFO07or1s4cpPiBWcGQ5yKzq3ih8/k5d1jh88mC/OlWep+IIo
	 9Rxy9MFQNYGcpksZ/LJSCFboECeTJjGpHDhepQNR8NjByobFeCI+hZqPnt9QGkOtYz
	 XflAsaH3gwmnQfTlJUACPm5BIsGOXS5WfDKQwy/IeeXeFJhdIwM3MoZ8+ukMGCqVUI
	 j9n7oMj01/c1w==
From: Michael Walle <mwalle@kernel.org>
Date: Mon, 06 May 2024 15:34:48 +0200
Subject: [PATCH 19/20] drm/bridge: tc358775: fix power-up sequencing
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-tc358775-fix-powerup-v1-19-545dcf00b8dd@kernel.org>
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

The reset line of this bridge must be released while the DSI data lanes
and DSI clock lane are in LP-11 mode. After that the DSI clock has to be
turned on, which is a requirement to have I2C work.

To achieve this, use the new .lp11_notify() callback where the reset
line is released. Set .pre_enable_prev_first to make sure, there is a
valid DSI clock during the .pre_enabe() op. In .pre_enable() the bridge
will be fully configured but the LVDS transmitter will remain disabled.
It will eventually be enabled in the .enable() op.

With the correct initialization sequence we don't need the additional
reset, nor the additional write to VFUEN. With that fixed, the init
sequence is exactly how the vendor is requiring it.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/gpu/drm/bridge/tc358775.c | 62 +++++++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
index 99dbbb1fee78..31f89b7d5a3a 100644
--- a/drivers/gpu/drm/bridge/tc358775.c
+++ b/drivers/gpu/drm/bridge/tc358775.c
@@ -239,6 +239,9 @@ static void tc358775_power_up(struct tc_data *tc)
 	struct device *dev = &tc->dsi->dev;
 	int ret;
 
+	if (tc->powered)
+		return;
+
 	ret = regulator_enable(tc->vddio);
 	if (ret < 0)
 		dev_err(dev, "regulator vddio enable failed, %d\n", ret);
@@ -252,6 +255,8 @@ static void tc358775_power_up(struct tc_data *tc)
 
 	gpiod_set_value(tc->reset_gpio, 0);
 	usleep_range(200, 250);
+
+	tc->powered = true;
 }
 
 static void tc358775_power_down(struct tc_data *tc)
@@ -271,20 +276,8 @@ static void tc358775_power_down(struct tc_data *tc)
 	ret = regulator_disable(tc->vddio);
 	if (ret < 0)
 		dev_err(dev, "regulator vddio disable failed, %d\n", ret);
-}
 
-static void tc_bridge_pre_enable(struct drm_bridge *bridge)
-{
-	struct tc_data *tc = bridge_to_tc(bridge);
-
-	tc358775_power_up(tc);
-}
-
-static void tc_bridge_post_disable(struct drm_bridge *bridge)
-{
-	struct tc_data *tc = bridge_to_tc(bridge);
-
-	tc358775_power_down(tc);
+	tc->powered = false;
 }
 
 /* helper function to access bus_formats */
@@ -474,12 +467,25 @@ static void tc358775_configure_lvds_clock(struct tc_data *tc)
 	regmap_write(tc->regmap, LVCFG, val);
 }
 
-static void tc358775_bridge_enable(struct drm_bridge *bridge)
+static void tc358775_dsi_lp11_notify(struct drm_bridge *bridge)
 {
 	struct tc_data *tc = bridge_to_tc(bridge);
-	unsigned int val = 0;
-	struct drm_display_mode *mode;
+
+	tc358775_power_up(tc);
+}
+
+static void tc358775_bridge_pre_enable(struct drm_bridge *bridge)
+{
 	struct drm_connector *connector = get_connector(bridge->encoder);
+	struct tc_data *tc = bridge_to_tc(bridge);
+	struct drm_display_mode *mode;
+	unsigned int val = 0;
+
+	/*
+	 * Legacy behavior, make sure this bridge is powered even if
+	 * drm_bridge_dsi_lp11_notify() isn't called by the DSI host
+	 */
+	tc358775_power_up(tc);
 
 	mode = &bridge->encoder->crtc->state->adjusted_mode;
 
@@ -488,22 +494,27 @@ static void tc358775_bridge_enable(struct drm_bridge *bridge)
 	dev_info(tc->dev, "DSI2LVDS Chip ID.%02x Revision ID. %02x **\n",
 		 (val >> 8) & 0xFF, val & 0xFF);
 
-	regmap_write(tc->regmap, SYSRST,
-		     SYS_RST_REG | SYS_RST_DSIRX | SYS_RST_BM | SYS_RST_LCD |
-		     SYS_RST_I2CM);
-	usleep_range(30000, 40000);
-
 	tc358775_configure_dsi(tc, mode->crtc_clock);
 	tc358775_configure_lvds_timings(tc, mode);
 	tc358775_configure_pll(tc, mode->crtc_clock);
 	tc358775_configure_color_mapping(tc, connector->display_info.bus_formats[0]);
-	regmap_write(tc->regmap, VFUEN, VFUEN_VFUEN);
 	tc358775_configure_lvds_clock(tc);
+}
+
+static void tc358775_bridge_enable(struct drm_bridge *bridge)
+{
+	struct tc_data *tc = bridge_to_tc(bridge);
 
-	/* Finally, enable the LVDS transmitter */
 	regmap_update_bits(tc->regmap, LVCFG, LVCFG_LVEN, LVCFG_LVEN);
 }
 
+static void tc358775_bridge_post_disable(struct drm_bridge *bridge)
+{
+	struct tc_data *tc = bridge_to_tc(bridge);
+
+	tc358775_power_down(tc);
+}
+
 /*
  * According to the datasheet, the horizontal back porch, front porch and sync
  * length must be a multiple of 2 and the minimal horizontal pulse width is 8.
@@ -634,11 +645,12 @@ static int tc_bridge_attach(struct drm_bridge *bridge,
 
 static const struct drm_bridge_funcs tc_bridge_funcs = {
 	.attach = tc_bridge_attach,
-	.pre_enable = tc_bridge_pre_enable,
+	.dsi_lp11_notify = tc358775_dsi_lp11_notify,
+	.pre_enable = tc358775_bridge_pre_enable,
 	.enable = tc358775_bridge_enable,
+	.post_disable = tc358775_bridge_post_disable,
 	.mode_fixup = tc_mode_fixup,
 	.mode_valid = tc_mode_valid,
-	.post_disable = tc_bridge_post_disable,
 };
 
 static int tc_attach_host(struct tc_data *tc)

-- 
2.39.2


