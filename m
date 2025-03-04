Return-Path: <linux-kernel+bounces-543076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF34A4D136
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56A5A7AA6CE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E0F1F3FEC;
	Tue,  4 Mar 2025 01:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Dz4J1iLy"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA821ACED1
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 01:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741052673; cv=none; b=J8owBa7FTQTLpFGanV0H/kYQtHEsy7lB/8FVU/1XjCjMjlGD0ZUNQaueKbDL9QSN9Cp7eO1/oLa06f8BKyNNYa5Un7JsAQAKfMgJ1PnqYTprx55qSSz6/C6S+F6uI8ol60M8AIe7PmKpKk07lxBsGvIrEUBRC+iQe9WK0ETznhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741052673; c=relaxed/simple;
	bh=kvaCWKqN9whVxrhljrJzN6WwaA/utmHjHEFf17MONyk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N+68WvGrOuzHwCxn/5Xj50zkJWKJ1YLvSseUY0tJgb1bQAjT9Xwu7UEYQgrA9x1xCbAFZLKlE2EBhOOScPLO6sfsjjKn1xSDH4RPaxcAMk1UPHZMUNkAvqLP4NK6p1A5juGZsMw+NYNY6hIcPJ+5vFqOaWe8keFFKb8OQ1rtt4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Dz4J1iLy; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741052666;
	bh=kvaCWKqN9whVxrhljrJzN6WwaA/utmHjHEFf17MONyk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Dz4J1iLyOWlQWBbmfgufRsZOM9pVw1QxR6PDh5Qqe3UHFjTOSec8B9DO/U4WkNAVI
	 P98uzadJscEc889CsgAlFwOUi0Wlw1l883mAPXAse+cufFc06DPgCG7CDqTlCL9u+a
	 Avtqxd64XEU7Nf1qNyboJU1rtUZ3MReFrTt4lsikhNC9eEZcqWKpI0q/hl9aoGhj3A
	 ezw+sl0xBA1HCHyT+vO9XeGVKl2PQbKF1OdoSiuniKrNrmVnHdkfpcRwfsGUmUMaTD
	 DjSBgbQm8DY5sqybWvQ+/TU3XF8QsREaQiKfg/3hItHfBs9o2EZAUwU2sRAv3/6Fj/
	 gff/AdAva7L/Q==
Received: from localhost (unknown [188.27.58.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id BC83A17E1067;
	Tue,  4 Mar 2025 02:44:26 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 04 Mar 2025 03:44:10 +0200
Subject: [PATCH v4 11/12] phy: rockchip: samsung-hdptx: Optimize internal
 rate handling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-phy-sam-hdptx-bpc-v4-11-8657847c13f7@collabora.com>
References: <20250304-phy-sam-hdptx-bpc-v4-0-8657847c13f7@collabora.com>
In-Reply-To: <20250304-phy-sam-hdptx-bpc-v4-0-8657847c13f7@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: Algea Cao <algea.cao@rock-chips.com>, Sandor Yu <Sandor.yu@nxp.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Maxime Ripard <mripard@kernel.org>, kernel@collabora.com, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
X-Mailer: b4 0.14.2

Drop the rate parameter from a bunch of internal helpers and, instead,
make better use of the newly introduced ->hdmi_cfg.tmds_char_rate driver
data.

Additionally, rename the rather ambiguous ->rate member of struct
rk_hdptx_phy to ->hw_rate and ensure rk_hdptx_ropll_tmds_cmn_config()
updates it only after all the other operations have been successful.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 59 +++++++++++------------
 1 file changed, 29 insertions(+), 30 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index c2ad1cb94614711bea13b7259a6b66dbd72d663d..54210eaec0c0923b3e8eb8e207632983982bcd2f 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -401,9 +401,8 @@ struct rk_hdptx_phy {
 
 	/* clk provider */
 	struct clk_hw hw;
-	unsigned long rate;
+	unsigned long hw_rate;
 	bool restrict_rate_change;
-
 	atomic_t usage_count;
 
 	/* used for dp mode */
@@ -968,14 +967,15 @@ static bool rk_hdptx_phy_clk_pll_calc(unsigned int data_rate,
 	return true;
 }
 
-static int rk_hdptx_ropll_tmds_cmn_config(struct rk_hdptx_phy *hdptx,
-					  unsigned int rate)
+static int rk_hdptx_ropll_tmds_cmn_config(struct rk_hdptx_phy *hdptx)
 {
+	unsigned int rate = hdptx->hdmi_cfg.tmds_char_rate / 100;
 	const struct ropll_config *cfg = NULL;
 	struct ropll_config rc = {0};
-	int i;
+	int ret, i;
 
-	hdptx->rate = rate * 100;
+	if (!rate)
+		return 0;
 
 	for (i = 0; i < ARRAY_SIZE(ropll_tmds_cfg); i++)
 		if (rate == ropll_tmds_cfg[i].bit_rate) {
@@ -987,7 +987,8 @@ static int rk_hdptx_ropll_tmds_cmn_config(struct rk_hdptx_phy *hdptx,
 		if (rk_hdptx_phy_clk_pll_calc(rate, &rc)) {
 			cfg = &rc;
 		} else {
-			dev_err(hdptx->dev, "%s cannot find pll cfg\n", __func__);
+			dev_err(hdptx->dev, "%s cannot find pll cfg for rate=%u\n",
+				__func__, rate);
 			return -EINVAL;
 		}
 	}
@@ -1033,17 +1034,20 @@ static int rk_hdptx_ropll_tmds_cmn_config(struct rk_hdptx_phy *hdptx,
 	regmap_update_bits(hdptx->regmap, CMN_REG(0086), PLL_PCG_CLK_EN_MASK,
 			   FIELD_PREP(PLL_PCG_CLK_EN_MASK, 0x1));
 
-	return rk_hdptx_post_enable_pll(hdptx);
+	ret = rk_hdptx_post_enable_pll(hdptx);
+	if (!ret)
+		hdptx->hw_rate = hdptx->hdmi_cfg.tmds_char_rate;
+
+	return ret;
 }
 
-static int rk_hdptx_ropll_tmds_mode_config(struct rk_hdptx_phy *hdptx,
-					   unsigned int rate)
+static int rk_hdptx_ropll_tmds_mode_config(struct rk_hdptx_phy *hdptx)
 {
 	rk_hdptx_multi_reg_write(hdptx, rk_hdtpx_common_sb_init_seq);
 
 	regmap_write(hdptx->regmap, LNTOP_REG(0200), 0x06);
 
-	if (rate > HDMI14_MAX_RATE / 100) {
+	if (hdptx->hdmi_cfg.tmds_char_rate > HDMI14_MAX_RATE) {
 		/* For 1/40 bitrate clk */
 		rk_hdptx_multi_reg_write(hdptx, rk_hdtpx_tmds_lntop_highbr_seq);
 	} else {
@@ -1095,8 +1099,7 @@ static void rk_hdptx_dp_reset(struct rk_hdptx_phy *hdptx)
 		     HDPTX_I_BGR_EN << 16 | FIELD_PREP(HDPTX_I_BGR_EN, 0x0));
 }
 
-static int rk_hdptx_phy_consumer_get(struct rk_hdptx_phy *hdptx,
-				     unsigned int rate)
+static int rk_hdptx_phy_consumer_get(struct rk_hdptx_phy *hdptx)
 {
 	enum phy_mode mode = phy_get_mode(hdptx->phy);
 	u32 status;
@@ -1115,11 +1118,9 @@ static int rk_hdptx_phy_consumer_get(struct rk_hdptx_phy *hdptx,
 	if (mode == PHY_MODE_DP) {
 		rk_hdptx_dp_reset(hdptx);
 	} else {
-		if (rate) {
-			ret = rk_hdptx_ropll_tmds_cmn_config(hdptx, rate);
-			if (ret)
-				goto dec_usage;
-		}
+		ret = rk_hdptx_ropll_tmds_cmn_config(hdptx);
+		if (ret)
+			goto dec_usage;
 	}
 
 	return 0;
@@ -1415,7 +1416,6 @@ static int rk_hdptx_phy_power_on(struct phy *phy)
 {
 	struct rk_hdptx_phy *hdptx = phy_get_drvdata(phy);
 	enum phy_mode mode = phy_get_mode(phy);
-	unsigned int rate = 0;
 	int ret, lane;
 
 	if (mode != PHY_MODE_DP) {
@@ -1426,16 +1426,15 @@ static int rk_hdptx_phy_power_on(struct phy *phy)
 			 * Will be removed as soon the switch to the HDMI PHY
 			 * configuration API has been completed on both ends.
 			 */
-			rate = phy_get_bus_width(hdptx->phy) & 0xfffffff;
-			hdptx->hdmi_cfg.tmds_char_rate = rate * 100;
-		} else {
-			rate = hdptx->hdmi_cfg.tmds_char_rate / 100;
+			hdptx->hdmi_cfg.tmds_char_rate = phy_get_bus_width(hdptx->phy) & 0xfffffff;
+			hdptx->hdmi_cfg.tmds_char_rate *= 100;
 		}
-		dev_dbg(hdptx->dev, "%s rate=%u bpc=%u\n",
-			__func__, rate, hdptx->hdmi_cfg.bpc);
+
+		dev_dbg(hdptx->dev, "%s tmds_rate=%llu bpc=%u\n", __func__,
+			hdptx->hdmi_cfg.tmds_char_rate, hdptx->hdmi_cfg.bpc);
 	}
 
-	ret = rk_hdptx_phy_consumer_get(hdptx, rate);
+	ret = rk_hdptx_phy_consumer_get(hdptx);
 	if (ret)
 		return ret;
 
@@ -1466,7 +1465,7 @@ static int rk_hdptx_phy_power_on(struct phy *phy)
 		regmap_write(hdptx->grf, GRF_HDPTX_CON0,
 			     HDPTX_MODE_SEL << 16 | FIELD_PREP(HDPTX_MODE_SEL, 0x0));
 
-		ret = rk_hdptx_ropll_tmds_mode_config(hdptx, rate);
+		ret = rk_hdptx_ropll_tmds_mode_config(hdptx);
 		if (ret)
 			rk_hdptx_phy_consumer_put(hdptx, true);
 	}
@@ -1851,7 +1850,7 @@ static int rk_hdptx_phy_clk_prepare(struct clk_hw *hw)
 {
 	struct rk_hdptx_phy *hdptx = to_rk_hdptx_phy(hw);
 
-	return rk_hdptx_phy_consumer_get(hdptx, hdptx->rate / 100);
+	return rk_hdptx_phy_consumer_get(hdptx);
 }
 
 static void rk_hdptx_phy_clk_unprepare(struct clk_hw *hw)
@@ -1866,7 +1865,7 @@ static unsigned long rk_hdptx_phy_clk_recalc_rate(struct clk_hw *hw,
 {
 	struct rk_hdptx_phy *hdptx = to_rk_hdptx_phy(hw);
 
-	return hdptx->rate;
+	return hdptx->hw_rate;
 }
 
 static long rk_hdptx_phy_clk_round_rate(struct clk_hw *hw, unsigned long rate,
@@ -1918,7 +1917,7 @@ static int rk_hdptx_phy_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	 * while the latter being executed only once, i.e. when clock remains
 	 * in the prepared state during rate changes.
 	 */
-	return rk_hdptx_ropll_tmds_cmn_config(hdptx, rate / 100);
+	return rk_hdptx_ropll_tmds_cmn_config(hdptx);
 }
 
 static const struct clk_ops hdptx_phy_clk_ops = {

-- 
2.48.1


