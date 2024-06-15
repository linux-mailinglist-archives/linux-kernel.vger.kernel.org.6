Return-Path: <linux-kernel+bounces-215944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDCA909920
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 19:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C50D51F21A22
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 17:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326D549656;
	Sat, 15 Jun 2024 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="RYMWVOAZ"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1788061FEC
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 17:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718471116; cv=none; b=XwDiXmiBbhQGwfmiCyhDRjv6astgLpepQlMVDETKZ8bx0PbDAxKQ3NPfQ/bqTcys5DnG9k9LmiTMG5u1LjwYn12q2rbEYJh8KLAFx0ILEy5x7fBkgXmsCYLG0fEc7n5J5rysOVWnwHVrkI4HItSOiDf5gmwM2itqinejLcxAIws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718471116; c=relaxed/simple;
	bh=QEKhhTCST9KoZlTMRI3A6oOse8N77JMUC3LrD+P8oko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESZz18m49H85iVLwk8ieFknEPpMRnD5ythuZFynd/ZN9BHha9JbvGSjBrlcFPI44l6ZP5/U3s82bQd3MiOHnveGlW0/TGlF20z/PYdWLvbPPIRmnojEmyMSMMABX8lWmTwqI69cJ+IxnYLIiT5JVuDm9u08ndis4xYg4QHbk+Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=RYMWVOAZ; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1718471099; bh=GI0v1s8ba9SK2ZoNJqavRuohwLSEeWbP8DGokxC9tW4=;
 b=RYMWVOAZ5kB+dNdeVN9+EVw4xWPsjtu8LvSzkDFR4POoYVfeoqNw2mgQKa7Ywefjcib06gxbv
 zs/VpXvp7qYu1XiOPwfcYLm+KH6cC0qJ+z93m+g7EvPW5LG/VBoVr8J+7O+sM6iryN0rgvwvxxt
 PyU5etW9Pb+Fbs48XXrKflpRmcL9WW5BxnYrISEHhuZTCXfDiMqxKzPQ4T3pcAMMSqx0F31shJ0
 v8eEQfKN24WkalSiJQiui3G0F5PL1n+wJrJXQOphHRvxUx+ohxcDGOdEdG3AzkOMIrY1wQyJdCP
 nnM/rLk3oCdOD9s1bD/OP3ncsKcI3/LUFSmtoUWfaccg==
From: Jonas Karlman <jonas@kwiboo.se>
To: dri-devel@lists.freedesktop.org, Sandy Huang <hjc@rock-chips.com>,
 "=?UTF-8?q?Heiko=20St=C3=BCbner?=" <heiko@sntech.de>, Andy Yan
 <andy.yan@rock-chips.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Jonas
 Karlman <jonas@kwiboo.se>
Subject: [PATCH 07/13] drm/rockchip: dw_hdmi: Filter modes based on hdmiphy_clk
Date: Sat, 15 Jun 2024 17:03:58 +0000
Message-ID: <20240615170417.3134517-8-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240615170417.3134517-1-jonas@kwiboo.se>
References: <20240615170417.3134517-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 666dc9b824e0254b39804051

RK3228 and RK3328 clock rate is being validated against a mpll config
table intended for Synopsys phy, and not the inno-hdmi-phy used.

Instead get a reference to the hdmiphy clk and validate rates against
it to enable use of HDMI2.0 modes, e.g. 4K@60Hz, on RK3228 and RK3328.

For Synopsis phy the max_tmds_clock validation is sufficient.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 35 ++++++++++-----------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 75b5d63ec570..4acf73b5692a 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -76,6 +76,7 @@ struct rockchip_hdmi {
 	struct rockchip_encoder encoder;
 	const struct rockchip_hdmi_chip_data *chip_data;
 	const struct dw_hdmi_plat_data *plat_data;
+	struct clk *hdmiphy_clk;
 	struct clk *ref_clk;
 	struct clk *grf_clk;
 	struct dw_hdmi *hdmi;
@@ -256,10 +257,7 @@ dw_hdmi_rockchip_mode_valid(struct dw_hdmi *dw_hdmi, void *data,
 			    const struct drm_display_mode *mode)
 {
 	struct rockchip_hdmi *hdmi = data;
-	const struct dw_hdmi_mpll_config *mpll_cfg = rockchip_mpll_cfg;
 	int pclk = mode->clock * 1000;
-	bool exact_match = hdmi->plat_data->phy_force_vendor;
-	int i;
 
 	if (hdmi->chip_data->max_tmds_clock &&
 	    mode->clock > hdmi->chip_data->max_tmds_clock)
@@ -268,26 +266,18 @@ dw_hdmi_rockchip_mode_valid(struct dw_hdmi *dw_hdmi, void *data,
 	if (hdmi->ref_clk) {
 		int rpclk = clk_round_rate(hdmi->ref_clk, pclk);
 
-		if (abs(rpclk - pclk) > pclk / 1000)
+		if (rpclk < 0 || abs(rpclk - pclk) > pclk / 1000)
 			return MODE_NOCLOCK;
 	}
 
-	for (i = 0; mpll_cfg[i].mpixelclock != (~0UL); i++) {
-		/*
-		 * For vendor specific phys force an exact match of the pixelclock
-		 * to preserve the original behaviour of the driver.
-		 */
-		if (exact_match && pclk == mpll_cfg[i].mpixelclock)
-			return MODE_OK;
-		/*
-		 * The Synopsys phy can work with pixelclocks up to the value given
-		 * in the corresponding mpll_cfg entry.
-		 */
-		if (!exact_match && pclk <= mpll_cfg[i].mpixelclock)
-			return MODE_OK;
+	if (hdmi->hdmiphy_clk) {
+		int rpclk = clk_round_rate(hdmi->hdmiphy_clk, pclk);
+
+		if (rpclk < 0 || abs(rpclk - pclk) > pclk / 1000)
+			return MODE_NOCLOCK;
 	}
 
-	return MODE_BAD;
+	return MODE_OK;
 }
 
 static void dw_hdmi_rockchip_encoder_disable(struct drm_encoder *encoder)
@@ -638,6 +628,15 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 		goto err_clk;
 	}
 
+	if (hdmi->phy) {
+		struct of_phandle_args clkspec;
+
+		clkspec.np = hdmi->phy->dev.of_node;
+		hdmi->hdmiphy_clk = of_clk_get_from_provider(&clkspec);
+		if (IS_ERR(hdmi->hdmiphy_clk))
+			hdmi->hdmiphy_clk = NULL;
+	}
+
 	if (hdmi->chip_data == &rk3568_chip_data) {
 		regmap_write(hdmi->regmap, RK3568_GRF_VO_CON1,
 			     HIWORD_UPDATE(RK3568_HDMI_SDAIN_MSK |
-- 
2.45.2


