Return-Path: <linux-kernel+bounces-552467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18641A57A1C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 13:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45A52169ECD
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 12:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E53C1DE2A1;
	Sat,  8 Mar 2025 12:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="n4SIjttv"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13881DA116
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 12:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741436502; cv=none; b=dXdzG8/zIbpEvv785zWIgu0BJydSI63y205Z5OXcNZtiZAf4o5c8aB+qgdn3gJk6bCHMBk1NKxADAM7L+gpwg79oMgoYTt8vm8Nwfp/G0IaJBbmNw23yPkBFsmTww+aWplUxcM7YCmQ/YmbRIGSsTy+wnyHZNTyvtfcgTyP+814=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741436502; c=relaxed/simple;
	bh=Nlm3LxLLtctwWLu979h2DkoXTSi+s/ecZdqPE3a69G4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X+Wb1KhdTC08bSgZRbnEqGJVpDnmShozbGfhKFiWve+HA/NWTtsISEYrzoD1oolG+4s2gllI4JEWNmHmoj8NUXAxAbhKa/xQjyeytAMzbaiq4WniVgKwxt3yRvd9V/s9TN/vvF37QDnrUbSgPW0rXoPopXUqB+aN1gWIyABf6s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=n4SIjttv; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741436499;
	bh=Nlm3LxLLtctwWLu979h2DkoXTSi+s/ecZdqPE3a69G4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=n4SIjttvUYEm0I6StoyswtUnY0d1N3YtVrfqjR8y1NjuPokvm7n6a+4N4lfRgtET8
	 qpH9tQGx+tN9zkYxadPbp1P5DzBgnLXU2Rh03+pz8RUV9F1o5d+O/UYKpf3j/cssc7
	 UGXBP1ATXQwtinyDXvpRGq1IQrBQdp9m9250JLVXMoHJW8gKhFzfarEy1WzmcdR1AU
	 l0mqs8fQp1ev7dnUf4PkAbhiXkzk+t/+2wkGhJNk/rZkbTwLnaV2xbo9y5/5ELK5oN
	 2IpT3OIoJQ+EVwKeKTlLk47jrpnKis4yH2jAsMfqotMYTOwd8oMRdugvMDpam0GfZ2
	 VvWtq+WEZjA2Q==
Received: from localhost (unknown [84.232.140.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id DA79A17E0F75;
	Sat,  8 Mar 2025 13:21:38 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 08 Mar 2025 14:21:16 +0200
Subject: [PATCH v5 07/12] phy: rockchip: samsung-hdptx: Avoid Hz<->hHz unit
 conversion overhead
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250308-phy-sam-hdptx-bpc-v5-7-35087287f9d1@collabora.com>
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

The ropll_tmds_cfg table used to identify the configuration params for
the supported rates expects the search key, i.e. bit_rate member of
struct ropll_config, to be provided in hHz rather than Hz (1 hHz = 100
Hz).  This requires multiple conversions between these units being
performed at runtime.

Improve implementation clarity and efficiency by consistently using the
Hz unit throughout driver's internal data structures and functions.
Also rename the rather misleading struct member.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 79 +++++++++++------------
 1 file changed, 39 insertions(+), 40 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index 2bf525514c1991a1299265d12e1e85f66333c604..e58a01bdb3ce82d66acdcb02c06de2816288b574 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -330,7 +330,7 @@ enum dp_link_rate {
 };
 
 struct ropll_config {
-	u32 bit_rate;
+	u32 rate;
 	u8 pms_mdiv;
 	u8 pms_mdiv_afc;
 	u8 pms_pdiv;
@@ -410,45 +410,45 @@ struct rk_hdptx_phy {
 };
 
 static const struct ropll_config ropll_tmds_cfg[] = {
-	{ 5940000, 124, 124, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
+	{ 594000000, 124, 124, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
 	  1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
-	{ 3712500, 155, 155, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
+	{ 371250000, 155, 155, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
 	  1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
-	{ 2970000, 124, 124, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
+	{ 297000000, 124, 124, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
 	  1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
-	{ 1620000, 135, 135, 1, 1, 3, 1, 1, 0, 1, 1, 1, 1, 4, 0, 3, 5, 5, 0x10,
+	{ 162000000, 135, 135, 1, 1, 3, 1, 1, 0, 1, 1, 1, 1, 4, 0, 3, 5, 5, 0x10,
 	  1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
-	{ 1856250, 155, 155, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
+	{ 185625000, 155, 155, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
 	  1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
-	{ 1540000, 193, 193, 1, 1, 5, 1, 1, 1, 1, 1, 1, 1, 193, 1, 32, 2, 1,
+	{ 154000000, 193, 193, 1, 1, 5, 1, 1, 1, 1, 1, 1, 1, 193, 1, 32, 2, 1,
 	  1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
-	{ 1485000, 0x7b, 0x7b, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 4, 0, 3, 5, 5,
+	{ 148500000, 0x7b, 0x7b, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 4, 0, 3, 5, 5,
 	  0x10, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
-	{ 1462500, 122, 122, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 244, 1, 16, 2, 1, 1,
+	{ 146250000, 122, 122, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 244, 1, 16, 2, 1, 1,
 	  1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
-	{ 1190000, 149, 149, 1, 1, 5, 1, 1, 1, 1, 1, 1, 1, 149, 1, 16, 2, 1, 1,
+	{ 119000000, 149, 149, 1, 1, 5, 1, 1, 1, 1, 1, 1, 1, 149, 1, 16, 2, 1, 1,
 	  1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
-	{ 1065000, 89, 89, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 89, 1, 16, 1, 0, 1,
+	{ 106500000, 89, 89, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 89, 1, 16, 1, 0, 1,
 	  1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
-	{ 1080000, 135, 135, 1, 1, 5, 1, 1, 0, 1, 0, 1, 1, 0x9, 0, 0x05, 0,
+	{ 108000000, 135, 135, 1, 1, 5, 1, 1, 0, 1, 0, 1, 1, 0x9, 0, 0x05, 0,
 	  0x14, 0x18, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
-	{ 855000, 214, 214, 1, 1, 11, 1, 1, 1, 1, 1, 1, 1, 214, 1, 16, 2, 1,
+	{ 85500000, 214, 214, 1, 1, 11, 1, 1, 1, 1, 1, 1, 1, 214, 1, 16, 2, 1,
 	  1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
-	{ 835000, 105, 105, 1, 1, 5, 1, 1, 1, 1, 1, 1, 1, 42, 1, 16, 1, 0,
+	{ 83500000, 105, 105, 1, 1, 5, 1, 1, 1, 1, 1, 1, 1, 42, 1, 16, 1, 0,
 	  1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
-	{ 928125, 155, 155, 1, 1, 7, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
+	{ 92812500, 155, 155, 1, 1, 7, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
 	  1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
-	{ 742500, 124, 124, 1, 1, 7, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
+	{ 74250000, 124, 124, 1, 1, 7, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
 	  1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
-	{ 650000, 162, 162, 1, 1, 11, 1, 1, 1, 1, 1, 1, 1, 54, 0, 16, 4, 1,
+	{ 65000000, 162, 162, 1, 1, 11, 1, 1, 1, 1, 1, 1, 1, 54, 0, 16, 4, 1,
 	  1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
-	{ 337500, 0x70, 0x70, 1, 1, 0xf, 1, 1, 1, 1, 1, 1, 1, 0x2, 0, 0x01, 5,
+	{ 33750000, 0x70, 0x70, 1, 1, 0xf, 1, 1, 1, 1, 1, 1, 1, 0x2, 0, 0x01, 5,
 	  1, 1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
-	{ 400000, 100, 100, 1, 1, 11, 1, 1, 0, 1, 0, 1, 1, 0x9, 0, 0x05, 0,
+	{ 40000000, 100, 100, 1, 1, 11, 1, 1, 0, 1, 0, 1, 1, 0x9, 0, 0x05, 0,
 	  0x14, 0x18, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
-	{ 270000, 0x5a, 0x5a, 1, 1, 0xf, 1, 1, 0, 1, 0, 1, 1, 0x9, 0, 0x05, 0,
+	{ 27000000, 0x5a, 0x5a, 1, 1, 0xf, 1, 1, 0, 1, 0, 1, 1, 0x9, 0, 0x05, 0,
 	  0x14, 0x18, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
-	{ 251750, 84, 84, 1, 1, 0xf, 1, 1, 1, 1, 1, 1, 1, 168, 1, 16, 4, 1, 1,
+	{ 25175000, 84, 84, 1, 1, 0xf, 1, 1, 1, 1, 1, 1, 1, 168, 1, 16, 4, 1, 1,
 	  1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
 };
 
@@ -894,10 +894,10 @@ static void rk_hdptx_phy_disable(struct rk_hdptx_phy *hdptx)
 	regmap_write(hdptx->grf, GRF_HDPTX_CON0, val);
 }
 
-static bool rk_hdptx_phy_clk_pll_calc(unsigned int data_rate,
+static bool rk_hdptx_phy_clk_pll_calc(unsigned long rate,
 				      struct ropll_config *cfg)
 {
-	const unsigned int fout = data_rate / 2, fref = 24000;
+	const unsigned int fout = rate / 200, fref = 24000;
 	unsigned long k = 0, lc, k_sub, lc_sub;
 	unsigned int fvco, sdc;
 	u32 mdiv, sdiv, n = 8;
@@ -967,16 +967,16 @@ static bool rk_hdptx_phy_clk_pll_calc(unsigned int data_rate,
 }
 
 static int rk_hdptx_ropll_tmds_cmn_config(struct rk_hdptx_phy *hdptx,
-					  unsigned int rate)
+					  unsigned long rate)
 {
 	const struct ropll_config *cfg = NULL;
 	struct ropll_config rc = {0};
 	int i;
 
-	hdptx->rate = rate * 100;
+	hdptx->rate = rate;
 
 	for (i = 0; i < ARRAY_SIZE(ropll_tmds_cfg); i++)
-		if (rate == ropll_tmds_cfg[i].bit_rate) {
+		if (rate == ropll_tmds_cfg[i].rate) {
 			cfg = &ropll_tmds_cfg[i];
 			break;
 		}
@@ -990,8 +990,8 @@ static int rk_hdptx_ropll_tmds_cmn_config(struct rk_hdptx_phy *hdptx,
 		}
 	}
 
-	dev_dbg(hdptx->dev, "mdiv=%u, sdiv=%u, sdm_en=%u, k_sign=%u, k=%u, lc=%u\n",
-		cfg->pms_mdiv, cfg->pms_sdiv + 1, cfg->sdm_en,
+	dev_dbg(hdptx->dev, "%s rate=%lu mdiv=%u sdiv=%u sdm_en=%u k_sign=%u k=%u lc=%u\n",
+		__func__, rate, cfg->pms_mdiv, cfg->pms_sdiv + 1, cfg->sdm_en,
 		cfg->sdm_num_sign, cfg->sdm_num, cfg->sdm_deno);
 
 	rk_hdptx_pre_power_up(hdptx);
@@ -1032,13 +1032,13 @@ static int rk_hdptx_ropll_tmds_cmn_config(struct rk_hdptx_phy *hdptx,
 }
 
 static int rk_hdptx_ropll_tmds_mode_config(struct rk_hdptx_phy *hdptx,
-					   unsigned int rate)
+					   unsigned long rate)
 {
 	rk_hdptx_multi_reg_write(hdptx, rk_hdtpx_common_sb_init_seq);
 
 	regmap_write(hdptx->regmap, LNTOP_REG(0200), 0x06);
 
-	if (rate > HDMI14_MAX_RATE / 100) {
+	if (rate > HDMI14_MAX_RATE) {
 		/* For 1/40 bitrate clk */
 		rk_hdptx_multi_reg_write(hdptx, rk_hdtpx_tmds_lntop_highbr_seq);
 	} else {
@@ -1091,7 +1091,7 @@ static void rk_hdptx_dp_reset(struct rk_hdptx_phy *hdptx)
 }
 
 static int rk_hdptx_phy_consumer_get(struct rk_hdptx_phy *hdptx,
-				     unsigned int rate)
+				     unsigned long rate)
 {
 	enum phy_mode mode = phy_get_mode(hdptx->phy);
 	u32 status;
@@ -1409,8 +1409,8 @@ static int rk_hdptx_dp_aux_init(struct rk_hdptx_phy *hdptx)
 static int rk_hdptx_phy_power_on(struct phy *phy)
 {
 	struct rk_hdptx_phy *hdptx = phy_get_drvdata(phy);
-	int bus_width = phy_get_bus_width(hdptx->phy);
 	enum phy_mode mode = phy_get_mode(phy);
+	unsigned long rate;
 	int ret, lane;
 
 	/*
@@ -1418,10 +1418,10 @@ static int rk_hdptx_phy_power_on(struct phy *phy)
 	 * from the HDMI bridge driver until phy_configure_opts_hdmi
 	 * becomes available in the PHY API.
 	 */
-	unsigned int rate = bus_width & 0xfffffff;
+	rate = phy_get_bus_width(hdptx->phy) & 0xfffffff;
+	rate *= 100;
 
-	dev_dbg(hdptx->dev, "%s bus_width=%x rate=%u\n",
-		__func__, bus_width, rate);
+	dev_dbg(hdptx->dev, "%s rate=%lu\n", __func__, rate);
 
 	ret = rk_hdptx_phy_consumer_get(hdptx, rate);
 	if (ret)
@@ -1783,7 +1783,7 @@ static int rk_hdptx_phy_clk_prepare(struct clk_hw *hw)
 {
 	struct rk_hdptx_phy *hdptx = to_rk_hdptx_phy(hw);
 
-	return rk_hdptx_phy_consumer_get(hdptx, hdptx->rate / 100);
+	return rk_hdptx_phy_consumer_get(hdptx, hdptx->rate);
 }
 
 static void rk_hdptx_phy_clk_unprepare(struct clk_hw *hw)
@@ -1804,18 +1804,17 @@ static unsigned long rk_hdptx_phy_clk_recalc_rate(struct clk_hw *hw,
 static long rk_hdptx_phy_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 					unsigned long *parent_rate)
 {
-	u32 bit_rate = rate / 100;
 	int i;
 
 	if (rate > HDMI20_MAX_RATE)
 		return rate;
 
 	for (i = 0; i < ARRAY_SIZE(ropll_tmds_cfg); i++)
-		if (bit_rate == ropll_tmds_cfg[i].bit_rate)
+		if (rate == ropll_tmds_cfg[i].rate)
 			break;
 
 	if (i == ARRAY_SIZE(ropll_tmds_cfg) &&
-	    !rk_hdptx_phy_clk_pll_calc(bit_rate, NULL))
+	    !rk_hdptx_phy_clk_pll_calc(rate, NULL))
 		return -EINVAL;
 
 	return rate;
@@ -1826,7 +1825,7 @@ static int rk_hdptx_phy_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct rk_hdptx_phy *hdptx = to_rk_hdptx_phy(hw);
 
-	return rk_hdptx_ropll_tmds_cmn_config(hdptx, rate / 100);
+	return rk_hdptx_ropll_tmds_cmn_config(hdptx, rate);
 }
 
 static const struct clk_ops hdptx_phy_clk_ops = {

-- 
2.48.1


