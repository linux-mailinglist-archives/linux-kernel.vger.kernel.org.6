Return-Path: <linux-kernel+bounces-543077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B06A4D12C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35D9117235B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A170D1F4603;
	Tue,  4 Mar 2025 01:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ANbkDMCl"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB0D1ACEDC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 01:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741052674; cv=none; b=NrqqYBU9rnrus0+EkW84TZ4n9L0N3+kuURcfIy72vYTdOWbjVhYXM/UL9Of1xoY6A+V76R6qW8gxVxcT+SLI7Zzcxkyvtq1OrYefHDnGW0inPAxl1RWPUgju8Jhq6wqScCCd4Ili8yheqiZ1gMYBviAb4qi4qnNTAoAHbCdAebo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741052674; c=relaxed/simple;
	bh=DUfex9XJcgf138j9NIpzgjYvH+XwkmmguCNRyICKDXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nuUKIW4kBdnUCe7NuOmSru/ehz8Kuah2ZDvJI25eT9EqNPwy9zMpVpXFuzvKjBJ8YNQSUsD9vcbkycVaS5bo0xywrV+uQ0bgEwvc4MU2PdShzbNYrjHMRsQ38H3KBSzOpFewsbQp88JpQIWV8BaWe0QC268u1z6NUz53QWBLVaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ANbkDMCl; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741052667;
	bh=DUfex9XJcgf138j9NIpzgjYvH+XwkmmguCNRyICKDXs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ANbkDMClojw7NcHoF9Gtm2VTYjiYGbJyn2fvRDx9aFlWTWO06rtexJBcFjXVNv3Vr
	 IQ4YjEt/5t7n5hYE2LBwjD3l55De3nnIXGNHjpnPBsrXsI0qWNpiBNViq555cy4Z4l
	 a0UNn2YZ/MbeG7btLf3BGNiCpnuGx/UsCeuon+RodIq/bI4o6syIHi47VQ4i642yrz
	 TYqPpBs50lZ8+SmxOf+wgFMEgOdNN9O2gWS+zDTEyO9X1eYM5j/tEhB8O1cOQP0wK6
	 cxotY6RxLYXXPSb23lpm0xv3OT9amEVrCAyXjk3DkRjwmwA+M/3Q9s5OXkFt2DoPze
	 4JByaCjKbgkng==
Received: from localhost (unknown [188.27.58.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 9A1EC17E0B71;
	Tue,  4 Mar 2025 02:44:27 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 04 Mar 2025 03:44:11 +0200
Subject: [PATCH v4 12/12] phy: rockchip: samsung-hdptx: Avoid Hz-hHz unit
 conversion overhead
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-phy-sam-hdptx-bpc-v4-12-8657847c13f7@collabora.com>
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

The ropll_tmds_cfg table used to identify the configuration params for
the supported rates expects the search keys - bit_rate field - to be
provided in hHz rather than Hz (1 hHz = 100 Hz).  This requires multiple
conversions between these units being performed at runtime.

Improve implementation clarity and efficiency by consistently using the
Hz unit throughout driver's internal data structures and functions.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 68 +++++++++++------------
 1 file changed, 33 insertions(+), 35 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index 54210eaec0c0923b3e8eb8e207632983982bcd2f..8a835f8a5dc82a6d7ce5bdf79ed2773b9a7fa7c5 100644
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
@@ -411,45 +411,45 @@ struct rk_hdptx_phy {
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
 
@@ -895,10 +895,10 @@ static void rk_hdptx_phy_disable(struct rk_hdptx_phy *hdptx)
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
@@ -969,33 +969,32 @@ static bool rk_hdptx_phy_clk_pll_calc(unsigned int data_rate,
 
 static int rk_hdptx_ropll_tmds_cmn_config(struct rk_hdptx_phy *hdptx)
 {
-	unsigned int rate = hdptx->hdmi_cfg.tmds_char_rate / 100;
 	const struct ropll_config *cfg = NULL;
 	struct ropll_config rc = {0};
 	int ret, i;
 
-	if (!rate)
+	if (!hdptx->hdmi_cfg.tmds_char_rate)
 		return 0;
 
 	for (i = 0; i < ARRAY_SIZE(ropll_tmds_cfg); i++)
-		if (rate == ropll_tmds_cfg[i].bit_rate) {
+		if (hdptx->hdmi_cfg.tmds_char_rate == ropll_tmds_cfg[i].rate) {
 			cfg = &ropll_tmds_cfg[i];
 			break;
 		}
 
 	if (!cfg) {
-		if (rk_hdptx_phy_clk_pll_calc(rate, &rc)) {
+		if (rk_hdptx_phy_clk_pll_calc(hdptx->hdmi_cfg.tmds_char_rate, &rc)) {
 			cfg = &rc;
 		} else {
-			dev_err(hdptx->dev, "%s cannot find pll cfg for rate=%u\n",
-				__func__, rate);
+			dev_err(hdptx->dev, "%s cannot find pll cfg for rate=%llu\n",
+				__func__, hdptx->hdmi_cfg.tmds_char_rate);
 			return -EINVAL;
 		}
 	}
 
-	dev_dbg(hdptx->dev, "mdiv=%u, sdiv=%u, sdm_en=%u, k_sign=%u, k=%u, lc=%u\n",
-		cfg->pms_mdiv, cfg->pms_sdiv + 1, cfg->sdm_en,
-		cfg->sdm_num_sign, cfg->sdm_num, cfg->sdm_deno);
+	dev_dbg(hdptx->dev, "%s rate=%llu mdiv=%u sdiv=%u sdm_en=%u k_sign=%u k=%u lc=%u\n",
+		__func__, hdptx->hdmi_cfg.tmds_char_rate, cfg->pms_mdiv, cfg->pms_sdiv + 1,
+		cfg->sdm_en, cfg->sdm_num_sign, cfg->sdm_num, cfg->sdm_deno);
 
 	rk_hdptx_pre_power_up(hdptx);
 
@@ -1483,18 +1482,17 @@ static int rk_hdptx_phy_power_off(struct phy *phy)
 static int rk_hdptx_phy_verify_hdmi_config(struct rk_hdptx_phy *hdptx,
 					   struct phy_configure_opts_hdmi *hdmi)
 {
-	u32 bit_rate = hdmi->tmds_char_rate / 100;
 	int i;
 
 	if (!hdmi->tmds_char_rate || hdmi->tmds_char_rate > HDMI20_MAX_RATE)
 		return -EINVAL;
 
 	for (i = 0; i < ARRAY_SIZE(ropll_tmds_cfg); i++)
-		if (bit_rate == ropll_tmds_cfg[i].bit_rate)
+		if (hdmi->tmds_char_rate == ropll_tmds_cfg[i].rate)
 			break;
 
 	if (i == ARRAY_SIZE(ropll_tmds_cfg) &&
-	    !rk_hdptx_phy_clk_pll_calc(bit_rate, NULL))
+	    !rk_hdptx_phy_clk_pll_calc(hdmi->tmds_char_rate, NULL))
 		return -EINVAL;
 
 	if (!hdmi->bpc)

-- 
2.48.1


