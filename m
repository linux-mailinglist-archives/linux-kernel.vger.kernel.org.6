Return-Path: <linux-kernel+bounces-169910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D92548BCF37
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BFA01F2130A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 13:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D480A84FC5;
	Mon,  6 May 2024 13:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKoAURvJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226537E79F
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 13:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715002572; cv=none; b=CW+JWSvVrpY9xl8kqoUrPi6q0FN5Kio/G7UkgIfEjMXISK6eiP/4dzwcxZEEEPyi6w8N74E1U0/qjlpyDWjpDO8gkiPq46qm0liGjpg9KGd78eyk+l0XS37nhcnsB6DmsD/KQTFyKezSqK0DqWkAm9UHwRm9umkU8uws7yol1vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715002572; c=relaxed/simple;
	bh=2qrwEGgpJfR6a/ANS2qyau3152FW/n1Efs/NSwqyfq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EzfzACJzDM5NkXwMJ9cHzOar7Op58xIRNzEVEYyH/ZqfBLB1EUIhjMkx+sJLjpEXndOi+CESnQNHDjv9n+OY3Y1ertw58OONEapi9id+P1Y+lJOsAaWOKIKzdeDUfLIQMlJW/x3BGTYXlkWxlXZDbUb3cG1Z4OzfwECB5cMvpUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKoAURvJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C6DC4AF63;
	Mon,  6 May 2024 13:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715002572;
	bh=2qrwEGgpJfR6a/ANS2qyau3152FW/n1Efs/NSwqyfq0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fKoAURvJwU7PQ7A60+LC3D9rbSoxh2IprTicgx6iHdgw3xbzOSx2GCVLTVCbZ8djJ
	 H9QxnH6/50KnMgSdXODGrFTgXNaVh9GCX11xdLqtPLL0iGtFXOL3dSlsLoulF5vDF3
	 ZEmnFSoveKIZMx4szbIqoGWCBIDh9KHXRTpqaisLILlO3XoCb7AEfM/nw7QQlD8Uhe
	 ZWqLFtr4EhSi+HBShK4RKdoEAeZNdCSECkUVRdry/lyn7nV0AlWtNJT0sxJ98/W8dc
	 4BbBk9pO1I5pGtzn3vjfJ4DYAAjyDVGkAhO5dZCJ2xPkjdUB3dniX81Xw5BffzQXjX
	 n7Yyvgt4OaJPw==
From: Michael Walle <mwalle@kernel.org>
Date: Mon, 06 May 2024 15:34:43 +0200
Subject: [PATCH 14/20] drm/bridge: tc358775: configure PLL depending on the
 LVDS clock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-tc358775-fix-powerup-v1-14-545dcf00b8dd@kernel.org>
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

The PLL setting was hardcoded to a LVDS clock between 60MHz and 135MHz.
This adds support for slower frequencies. Also, rework the reset
sequence to match the initialization sequence provided by the vendor.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/gpu/drm/bridge/tc358775.c | 50 ++++++++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
index 4ec059531c5f..e3fba7ac71ec 100644
--- a/drivers/gpu/drm/bridge/tc358775.c
+++ b/drivers/gpu/drm/bridge/tc358775.c
@@ -30,8 +30,6 @@
 #include <drm/drm_panel.h>
 #include <drm/drm_probe_helper.h>
 
-#define FLD_VAL(val, start, end) FIELD_PREP(GENMASK(start, end), val)
-
 /* Registers */
 
 /* DSI D-PHY Layer Registers */
@@ -146,10 +144,10 @@ enum {
 #define PCLKSEL_HSRCK	0	/* DSI clock */
 
 #define LVPHY0          0x04A0  /* LVDS PHY 0 */
-#define LV_PHY0_RST(v)          FLD_VAL(v, 22, 22) /* PHY reset */
-#define LV_PHY0_IS(v)           FLD_VAL(v, 15, 14)
-#define LV_PHY0_ND(v)           FLD_VAL(v, 4, 0) /* Frequency range select */
-#define LV_PHY0_PRBS_ON(v)      FLD_VAL(v, 20, 16) /* Clock/Data Flag pins */
+#define LVPHY0_LV_ND	GENMASK(4, 0)
+#define LVPHY0_LV_FS	GENMASK(6, 5)
+#define LVPHY0_LV_IS	GENMASK(15, 14) /* charge pump current */
+#define LVPHY0_LV_RST	BIT(22)
 
 #define LVPHY1          0x04A4  /* LVDS PHY 1 */
 #define SYSSTAT         0x0500  /* System Status  */
@@ -223,6 +221,14 @@ struct tc_data {
 	enum tc3587x5_type	type;
 };
 
+struct tc358775_pll_settings {
+	unsigned int min_khz;
+	unsigned int max_khz;
+	u8 fs;
+	u8 nd;
+	u8 is;
+};
+
 static inline struct tc_data *bridge_to_tc(struct drm_bridge *b)
 {
 	return container_of(b, struct tc_data, bridge);
@@ -371,10 +377,38 @@ static void tc358775_configure_lvds_timings(struct tc_data *tc,
 	regmap_write(tc->regmap, VFUEN, VFUEN_EN);
 }
 
-static void tc358775_configure_pll(struct tc_data *tc, int pixelclk)
+static const struct tc358775_pll_settings tc358775_pll_settings[] = {
+	{ 25000, 30000, 2, 27, 1 },
+	{ 30000, 60000, 1, 13, 1 },
+	{ 60000, 135000, 0, 6, 1 },
+	{}
+};
+
+static void tc358775_configure_pll(struct tc_data *tc, unsigned int pixelclk)
 {
+	const struct tc358775_pll_settings *settings;
+	unsigned int val;
+
+	if (tc->lvds_dual_link)
+		pixelclk /= 2;
+
+	for (settings = tc358775_pll_settings; settings->min_khz; settings++)
+		if (pixelclk > settings->min_khz &&
+		    pixelclk < settings->max_khz)
+			break;
+
+	if (!settings->min_khz)
+		return;
+
+	val = u32_encode_bits(settings->fs, LVPHY0_LV_FS);
+	val |= u32_encode_bits(settings->nd, LVPHY0_LV_ND);
+	val |= u32_encode_bits(settings->is, LVPHY0_LV_IS);
+
+	regmap_write(tc->regmap, LVPHY0, val | LVPHY0_LV_RST);
+	usleep_range(100, 150);
+	regmap_write(tc->regmap, LVPHY0, val);
+
 	regmap_write(tc->regmap, SYSRST, SYS_RST_LCD);
-	regmap_write(tc->regmap, LVPHY0, LV_PHY0_PRBS_ON(4) | LV_PHY0_ND(6));
 }
 
 static void tc358775_configure_color_mapping(struct tc_data *tc, u32 fmt)

-- 
2.39.2


