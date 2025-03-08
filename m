Return-Path: <linux-kernel+bounces-552468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A89A57A1D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 13:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9487D3ABE0C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 12:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B43D1DE2C3;
	Sat,  8 Mar 2025 12:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Th2XO3yd"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930451DC994
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 12:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741436503; cv=none; b=iiy0fpu6WUK0VkagQfJtas202fppMwS+vAxa2ImQWfsXhYvpS7V84yT0pc18TgM4DcafEPTHGk6O05vPA0YgVYbhjuPsT/jBMplQ6v4zDgwh3ojgxDS6fATuSVrMLIH9P96rSQFETXeQK9vvWC+M39ILzn3kVNeWhhVrXE6IVyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741436503; c=relaxed/simple;
	bh=UbAzCVGg/XvhzHinLmwrAdKcW4kyawxk0cVGJmy3vJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WOOlpkQ7dYG1a9H4qK0DH0h3t5zJjkmOpZwvqA+KIlSn8ur8xFozTuDCB6g0b27WR0AGlCim0l9U0HttqTI5ROBNg9GsKi1WJ8du+W8owlh9KAwVNwsvqUMefj3H4fXG5lrjO4iMh1DqA8Mq7TVUtbQkPf9P7nB3O1QzJcBX3WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Th2XO3yd; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741436499;
	bh=UbAzCVGg/XvhzHinLmwrAdKcW4kyawxk0cVGJmy3vJg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Th2XO3yd/W5Oq35sRrWtpv12UT18Zd5bmtp+s7K9aUG4PhoJ+Hpw7cq0wiHSWEcty
	 UUYoz33wx24qTDDCV9H5xHmNfE0IBRjegBaHvJt57ZbOP4y8dHAmkPfbCl/1xFPOum
	 krMHBAJ1vQYztL6M4IMAexbWee2xo7tzUA8nQvnBxkEHr0k1fE3HaD/yRyppQ8KKC3
	 SZIk2/bM0THuwvymKDtmS9m1NP0cn2gXeFeIfPESgYsDCvNeclg4mJkeNYvJfXDjlI
	 go2K3I99yF/sODodTrv7NgyhZOJcn8lHDKUK08KgDH/JW2Qq1/iefjl4Py4ggWqDWn
	 434yynY/JSmLA==
Received: from localhost (unknown [84.232.140.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id A71C117E1016;
	Sat,  8 Mar 2025 13:21:39 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 08 Mar 2025 14:21:17 +0200
Subject: [PATCH v5 08/12] phy: rockchip: samsung-hdptx: Setup TMDS char
 rate via phy_configure_opts_hdmi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250308-phy-sam-hdptx-bpc-v5-8-35087287f9d1@collabora.com>
References: <20250308-phy-sam-hdptx-bpc-v5-0-35087287f9d1@collabora.com>
In-Reply-To: <20250308-phy-sam-hdptx-bpc-v5-0-35087287f9d1@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: Algea Cao <algea.cao@rock-chips.com>, Sandor Yu <Sandor.yu@nxp.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Maxime Ripard <mripard@kernel.org>, kernel@collabora.com, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
X-Mailer: b4 0.14.2

The current workaround to setup the TMDS character rate relies on the
unconventional usage of phy_set_bus_width().

Make use of the recently introduced HDMI PHY configuration API to
properly handle the setup.  The workaround will be dropped as soon as
the switch has been completed on both ends.

Rename rk_hdptx_phy_verify_config() to rk_hdptx_phy_verify_dp_config()
and introduce the rk_hdptx_phy_verify_hdmi_config() helper to check the
HDMI parameters during phy_configure().

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 64 +++++++++++++++++------
 1 file changed, 47 insertions(+), 17 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index e58a01bdb3ce82d66acdcb02c06de2816288b574..04c344394cbea89150bc4432cf26530fa9d71678 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -394,6 +394,7 @@ struct rk_hdptx_phy {
 
 	int phy_id;
 	struct phy *phy;
+	struct phy_configure_opts_hdmi hdmi_cfg;
 	struct clk_bulk_data *clks;
 	int nr_clks;
 	struct reset_control_bulk_data rsts[RST_MAX];
@@ -1410,20 +1411,24 @@ static int rk_hdptx_phy_power_on(struct phy *phy)
 {
 	struct rk_hdptx_phy *hdptx = phy_get_drvdata(phy);
 	enum phy_mode mode = phy_get_mode(phy);
-	unsigned long rate;
 	int ret, lane;
 
-	/*
-	 * FIXME: Temporary workaround to pass pixel_clk_rate
-	 * from the HDMI bridge driver until phy_configure_opts_hdmi
-	 * becomes available in the PHY API.
-	 */
-	rate = phy_get_bus_width(hdptx->phy) & 0xfffffff;
-	rate *= 100;
+	if (mode != PHY_MODE_DP) {
+		if (!hdptx->hdmi_cfg.tmds_char_rate) {
+			/*
+			 * FIXME: Temporary workaround to setup TMDS char rate
+			 * from the RK DW HDMI QP bridge driver.
+			 * Will be removed as soon the switch to the HDMI PHY
+			 * configuration API has been completed on both ends.
+			 */
+			hdptx->hdmi_cfg.tmds_char_rate = phy_get_bus_width(hdptx->phy) & 0xfffffff;
+			hdptx->hdmi_cfg.tmds_char_rate *= 100;
+		}
 
-	dev_dbg(hdptx->dev, "%s rate=%lu\n", __func__, rate);
+		dev_dbg(hdptx->dev, "%s rate=%llu\n", __func__, hdptx->hdmi_cfg.tmds_char_rate);
+	}
 
-	ret = rk_hdptx_phy_consumer_get(hdptx, rate);
+	ret = rk_hdptx_phy_consumer_get(hdptx, hdptx->hdmi_cfg.tmds_char_rate);
 	if (ret)
 		return ret;
 
@@ -1454,7 +1459,7 @@ static int rk_hdptx_phy_power_on(struct phy *phy)
 		regmap_write(hdptx->grf, GRF_HDPTX_CON0,
 			     HDPTX_MODE_SEL << 16 | FIELD_PREP(HDPTX_MODE_SEL, 0x0));
 
-		ret = rk_hdptx_ropll_tmds_mode_config(hdptx, rate);
+		ret = rk_hdptx_ropll_tmds_mode_config(hdptx, hdptx->hdmi_cfg.tmds_char_rate);
 		if (ret)
 			rk_hdptx_phy_consumer_put(hdptx, true);
 	}
@@ -1469,8 +1474,27 @@ static int rk_hdptx_phy_power_off(struct phy *phy)
 	return rk_hdptx_phy_consumer_put(hdptx, false);
 }
 
-static int rk_hdptx_phy_verify_config(struct rk_hdptx_phy *hdptx,
-				      struct phy_configure_opts_dp *dp)
+static int rk_hdptx_phy_verify_hdmi_config(struct rk_hdptx_phy *hdptx,
+					   struct phy_configure_opts_hdmi *hdmi)
+{
+	int i;
+
+	if (!hdmi->tmds_char_rate || hdmi->tmds_char_rate > HDMI20_MAX_RATE)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(ropll_tmds_cfg); i++)
+		if (hdmi->tmds_char_rate == ropll_tmds_cfg[i].rate)
+			break;
+
+	if (i == ARRAY_SIZE(ropll_tmds_cfg) &&
+	    !rk_hdptx_phy_clk_pll_calc(hdmi->tmds_char_rate, NULL))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int rk_hdptx_phy_verify_dp_config(struct rk_hdptx_phy *hdptx,
+					 struct phy_configure_opts_dp *dp)
 {
 	int i;
 
@@ -1730,12 +1754,18 @@ static int rk_hdptx_phy_configure(struct phy *phy, union phy_configure_opts *opt
 	enum phy_mode mode = phy_get_mode(phy);
 	int ret;
 
-	if (mode != PHY_MODE_DP)
-		return 0;
+	if (mode != PHY_MODE_DP) {
+		ret = rk_hdptx_phy_verify_hdmi_config(hdptx, &opts->hdmi);
+		if (ret)
+			dev_err(hdptx->dev, "invalid hdmi params for phy configure\n");
+		else
+			hdptx->hdmi_cfg = opts->hdmi;
+		return ret;
+	}
 
-	ret = rk_hdptx_phy_verify_config(hdptx, &opts->dp);
+	ret = rk_hdptx_phy_verify_dp_config(hdptx, &opts->dp);
 	if (ret) {
-		dev_err(hdptx->dev, "invalid params for phy configure\n");
+		dev_err(hdptx->dev, "invalid dp params for phy configure\n");
 		return ret;
 	}
 

-- 
2.48.1


