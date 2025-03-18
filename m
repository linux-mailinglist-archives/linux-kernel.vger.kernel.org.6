Return-Path: <linux-kernel+bounces-566168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7BCA6740A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8E0116AE3C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4CD20F069;
	Tue, 18 Mar 2025 12:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EUNzSZos"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5ED820E335
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 12:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742301436; cv=none; b=b/4y4XIJyKKaTY68FnYE0N1NVPM7mDWNWSdDTKFgaalqfTK1gX7pscXXpJgTJ4J+giAxIu4qAD6daEFxvAnsoaUG4z36xRR0DOa4NCiTtqKXAj+Lnh1vu2Nf1R1sgTViYu1JvfwI67EWD5GPkr11FofdakNQDIsj3OakeU1dyOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742301436; c=relaxed/simple;
	bh=VOuKK5+hZ0fQfSXAh7JI1QFVO+uVpyFrh+6nCIcBxpY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a2LZKkO6dagmbaUX2wWxj6mDIgFqpGOQh25HAyOVOEN5tbu6dk+KvY7sd+hW2KHuwjgjP4H2r6+T+7uw8b6LwLGYExWZN7bUeUGbhhKv9Pl+C60MeXX2qfe4eYqFsRJX6rAPSZG3bnBkjrHDSq2OYTsmL6Lo0Qxemj+oh8OlkqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EUNzSZos; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742301432;
	bh=VOuKK5+hZ0fQfSXAh7JI1QFVO+uVpyFrh+6nCIcBxpY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EUNzSZosixopc8esuhIUZjCsrB56pa2clpNycG56btuBOr8ppGW71rugopimaOTcA
	 U8tNdglyDtGODZaYCWuOdF+gWE45fYENSEpXoehJ4dMiWjolizaLKJtbdG3YIAchgp
	 xkyhf0brVx2muE2BU2hpai6QL9P8vheeQr4S2g7wjjN6kcFZfQpYXRADSSEQO9rK2C
	 lnCK3h9xLCW4bs+pNjCsbiugx7iRvP4+2BprFSrUtylCBKRi9pqK8X/j1cosmW7q3y
	 IMKJD1K7a3+TwvqsCDQAV4sjbT//yz0bdIdUMvCrVuSL8wELScH4Qt1jCbouy+BrPR
	 qYeVI1zks+SlQ==
Received: from localhost (unknown [84.232.140.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 08F8017E157A;
	Tue, 18 Mar 2025 13:37:12 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 18 Mar 2025 14:35:47 +0200
Subject: [PATCH v6 13/14] phy: rockchip: samsung-hdptx: Optimize internal
 rate handling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-phy-sam-hdptx-bpc-v6-13-8cb1678e7663@collabora.com>
References: <20250318-phy-sam-hdptx-bpc-v6-0-8cb1678e7663@collabora.com>
In-Reply-To: <20250318-phy-sam-hdptx-bpc-v6-0-8cb1678e7663@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: Algea Cao <algea.cao@rock-chips.com>, Sandor Yu <Sandor.yu@nxp.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Maxime Ripard <mripard@kernel.org>, kernel@collabora.com, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2

Drop the rate parameter from a bunch of internal helpers and, instead,
make better use of the newly introduced ->hdmi_cfg.tmds_char_rate driver
data.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 47 +++++++++++------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index a19a89233d808e2b38f6e7e58a1dc38ddd7cadd3..d09e1f7b25ec131d3c40fb52564cad27dce3b2d4 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -968,31 +968,34 @@ static bool rk_hdptx_phy_clk_pll_calc(unsigned long long rate,
 	return true;
 }
 
-static int rk_hdptx_ropll_tmds_cmn_config(struct rk_hdptx_phy *hdptx,
-					  unsigned long long rate)
+static int rk_hdptx_ropll_tmds_cmn_config(struct rk_hdptx_phy *hdptx)
 {
 	const struct ropll_config *cfg = NULL;
 	struct ropll_config rc = {0};
 	int ret, i;
 
+	if (!hdptx->hdmi_cfg.tmds_char_rate)
+		return 0;
+
 	for (i = 0; i < ARRAY_SIZE(ropll_tmds_cfg); i++)
-		if (rate == ropll_tmds_cfg[i].rate) {
+		if (hdptx->hdmi_cfg.tmds_char_rate == ropll_tmds_cfg[i].rate) {
 			cfg = &ropll_tmds_cfg[i];
 			break;
 		}
 
 	if (!cfg) {
-		if (rk_hdptx_phy_clk_pll_calc(rate, &rc)) {
-			cfg = &rc;
-		} else {
-			dev_err(hdptx->dev, "%s cannot find pll cfg\n", __func__);
+		if (!rk_hdptx_phy_clk_pll_calc(hdptx->hdmi_cfg.tmds_char_rate, &rc)) {
+			dev_err(hdptx->dev, "%s cannot find pll cfg for rate=%llu\n",
+				__func__, hdptx->hdmi_cfg.tmds_char_rate);
 			return -EINVAL;
 		}
+
+		cfg = &rc;
 	}
 
 	dev_dbg(hdptx->dev, "%s rate=%llu mdiv=%u sdiv=%u sdm_en=%u k_sign=%u k=%u lc=%u\n",
-		__func__, rate, cfg->pms_mdiv, cfg->pms_sdiv + 1, cfg->sdm_en,
-		cfg->sdm_num_sign, cfg->sdm_num, cfg->sdm_deno);
+		__func__, hdptx->hdmi_cfg.tmds_char_rate, cfg->pms_mdiv, cfg->pms_sdiv + 1,
+		cfg->sdm_en, cfg->sdm_num_sign, cfg->sdm_num, cfg->sdm_deno);
 
 	rk_hdptx_pre_power_up(hdptx);
 
@@ -1030,19 +1033,18 @@ static int rk_hdptx_ropll_tmds_cmn_config(struct rk_hdptx_phy *hdptx,
 
 	ret = rk_hdptx_post_enable_pll(hdptx);
 	if (!ret)
-		hdptx->hw_rate = rate;
+		hdptx->hw_rate = hdptx->hdmi_cfg.tmds_char_rate;
 
 	return ret;
 }
 
-static int rk_hdptx_ropll_tmds_mode_config(struct rk_hdptx_phy *hdptx,
-					   unsigned long long rate)
+static int rk_hdptx_ropll_tmds_mode_config(struct rk_hdptx_phy *hdptx)
 {
 	rk_hdptx_multi_reg_write(hdptx, rk_hdtpx_common_sb_init_seq);
 
 	regmap_write(hdptx->regmap, LNTOP_REG(0200), 0x06);
 
-	if (rate > HDMI14_MAX_RATE) {
+	if (hdptx->hdmi_cfg.tmds_char_rate > HDMI14_MAX_RATE) {
 		/* For 1/40 bitrate clk */
 		rk_hdptx_multi_reg_write(hdptx, rk_hdtpx_tmds_lntop_highbr_seq);
 	} else {
@@ -1094,8 +1096,7 @@ static void rk_hdptx_dp_reset(struct rk_hdptx_phy *hdptx)
 		     HDPTX_I_BGR_EN << 16 | FIELD_PREP(HDPTX_I_BGR_EN, 0x0));
 }
 
-static int rk_hdptx_phy_consumer_get(struct rk_hdptx_phy *hdptx,
-				     unsigned long long rate)
+static int rk_hdptx_phy_consumer_get(struct rk_hdptx_phy *hdptx)
 {
 	enum phy_mode mode = phy_get_mode(hdptx->phy);
 	u32 status;
@@ -1114,11 +1115,9 @@ static int rk_hdptx_phy_consumer_get(struct rk_hdptx_phy *hdptx,
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
@@ -1431,7 +1430,7 @@ static int rk_hdptx_phy_power_on(struct phy *phy)
 		dev_dbg(hdptx->dev, "%s rate=%llu\n", __func__, hdptx->hdmi_cfg.tmds_char_rate);
 	}
 
-	ret = rk_hdptx_phy_consumer_get(hdptx, hdptx->hdmi_cfg.tmds_char_rate);
+	ret = rk_hdptx_phy_consumer_get(hdptx);
 	if (ret)
 		return ret;
 
@@ -1462,7 +1461,7 @@ static int rk_hdptx_phy_power_on(struct phy *phy)
 		regmap_write(hdptx->grf, GRF_HDPTX_CON0,
 			     HDPTX_MODE_SEL << 16 | FIELD_PREP(HDPTX_MODE_SEL, 0x0));
 
-		ret = rk_hdptx_ropll_tmds_mode_config(hdptx, hdptx->hdmi_cfg.tmds_char_rate);
+		ret = rk_hdptx_ropll_tmds_mode_config(hdptx);
 		if (ret)
 			rk_hdptx_phy_consumer_put(hdptx, true);
 	}
@@ -1830,7 +1829,7 @@ static int rk_hdptx_phy_clk_prepare(struct clk_hw *hw)
 {
 	struct rk_hdptx_phy *hdptx = to_rk_hdptx_phy(hw);
 
-	return rk_hdptx_phy_consumer_get(hdptx, hdptx->hw_rate);
+	return rk_hdptx_phy_consumer_get(hdptx);
 }
 
 static void rk_hdptx_phy_clk_unprepare(struct clk_hw *hw)
@@ -1897,7 +1896,7 @@ static int rk_hdptx_phy_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	 * while the latter being executed only once, i.e. when clock remains
 	 * in the prepared state during rate changes.
 	 */
-	return rk_hdptx_ropll_tmds_cmn_config(hdptx, rate);
+	return rk_hdptx_ropll_tmds_cmn_config(hdptx);
 }
 
 static const struct clk_ops hdptx_phy_clk_ops = {

-- 
2.48.1


