Return-Path: <linux-kernel+bounces-443870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9509EFCF4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA56D287C88
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E3F1D9694;
	Thu, 12 Dec 2024 20:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CLARn6Rz"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217F81B3959
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 20:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734033848; cv=none; b=TvLO9LrpfJKYteCJqOSfUnORJpCVAPhf6zE5JuYQr3KEWBTSBg2x7bWGdNfGOQ3W+eDSeV0LdpVIYZqBe9MAS4ifsGaVMIT5K7yrdrqWFiQ2z0m0eAoELQQ/bPmHst144LHkKkzb4j6k8NcjkhmbZInOsEKhDazEkVsEJiHOzfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734033848; c=relaxed/simple;
	bh=nNqHz4NpDHM1KDZ3pSN7cST0Y4OmTrfeNw306jzeaZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MBZUXXg+VpLSPSZvo4b/VmveOUklwFbhmCbZqo0YIlUuZijtUTcb/EYBguyu7S2aJ6lnjyD34jXW4cq79fSDdCQkJYMneDQr9+Esv04I5Q9lOvB/cdimwmvMgYPUMhTHdoWyLLZqwRbqLdc7OuxTLXrxuZGkZvz7iwcRtevqeRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CLARn6Rz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734033841;
	bh=nNqHz4NpDHM1KDZ3pSN7cST0Y4OmTrfeNw306jzeaZI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CLARn6RzmV8a2P44ixHOPfzHrPhaX5P/Dinq5uI7616sxEXZVNeUixyiLUalqBi/f
	 oDLDRSeWQSekWV+6aQcBweESh21OsYzTe8cgdOwOjVyM6gzjLdlOaftuLy/XF/aTAp
	 Ywn03BSbN0TcGQ+kPe98Qx6YLDkpsB73r0PXj7kVyDDy9KuSr8kzKAF2gMYt86kG8N
	 IP2+jACJZ+VnBSbctl3VESoTUJnbydROS2OaY8ANXKuPfHI93ZsMeHBdyuVJVsd64F
	 MKoOug+TfAHu20K7FB9apM7ltXxZKD/ybAAxoJPeX0a56rrOMZn6uLF0E693mFD+Sg
	 nY4b37QFs6W/A==
Received: from localhost (unknown [188.27.48.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DDB9F17E3804;
	Thu, 12 Dec 2024 21:04:00 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 12 Dec 2024 22:03:39 +0200
Subject: [PATCH v2 8/8] phy: rockchip: samsung-hdptx: Avoid Hz-hHz unit
 conversion overhead
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-phy-sam-hdptx-bpc-v2-8-57e672c7c7c4@collabora.com>
References: <20241212-phy-sam-hdptx-bpc-v2-0-57e672c7c7c4@collabora.com>
In-Reply-To: <20241212-phy-sam-hdptx-bpc-v2-0-57e672c7c7c4@collabora.com>
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
Hz units throughout driver's internal data structures and functions.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 61 +++++++++++------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index bc513ddd5c052763856a113a7f1e58660f7372b8..b6120d9ab24eca093180b3af942d7ce2b204d516 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -196,7 +196,7 @@
 #define HDMI20_MAX_RATE			600000000
 
 struct ropll_config {
-	u32 bit_rate;
+	u32 rate;
 	u8 pms_mdiv;
 	u8 pms_mdiv_afc;
 	u8 pms_pdiv;
@@ -256,45 +256,45 @@ struct rk_hdptx_phy {
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
 
@@ -656,10 +656,10 @@ static void rk_hdptx_phy_disable(struct rk_hdptx_phy *hdptx)
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
@@ -729,16 +729,16 @@ static bool rk_hdptx_phy_clk_pll_calc(unsigned int data_rate,
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
@@ -837,7 +837,7 @@ static int rk_hdptx_phy_consumer_get(struct rk_hdptx_phy *hdptx)
 
 	rate = hdptx->tmds_char_rate ?: hdptx->rate;
 	if (rate) {
-		ret = rk_hdptx_ropll_tmds_cmn_config(hdptx, rate / 100);
+		ret = rk_hdptx_ropll_tmds_cmn_config(hdptx, rate);
 		if (ret)
 			goto dec_usage;
 	}
@@ -972,18 +972,17 @@ static unsigned long rk_hdptx_phy_clk_recalc_rate(struct clk_hw *hw,
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
@@ -1004,7 +1003,7 @@ static int rk_hdptx_phy_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 		rate = hdptx->tmds_char_rate;
 	}
 
-	return rk_hdptx_ropll_tmds_cmn_config(hdptx, rate / 100);
+	return rk_hdptx_ropll_tmds_cmn_config(hdptx, rate);
 }
 
 static const struct clk_ops hdptx_phy_clk_ops = {

-- 
2.47.0


