Return-Path: <linux-kernel+bounces-527693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1F9A40E34
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 12:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB0D37AC379
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 11:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1722080C1;
	Sun, 23 Feb 2025 11:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cXVP6LIR"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149D9206F22
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 11:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740308556; cv=none; b=krII5g+KzzYJ1+MRL3wVtjgw7zsECzUOOuzfzBpwMrIlz5xDCrowItAzJdvp0DnCDEOl39roBJHZ80qWt3EDE0sk3Hivcac0zgDYtJJMaztLSjd2byhT4jqMRKJ0G8R9/pu4cY87kqrGLb13hJaCmGlHQEEgew3ZM8ysc5n/F/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740308556; c=relaxed/simple;
	bh=OixaKCYI+zZ7pHBGcv4bDQvYd77BgWqW1bdYwXbp3Gw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e7I7wMo9jjJVU/zKGUeTnVrqgRM7RYvXfwNNrLp8Z8q+6SRpHfPXl7sopzKDdwXQHYf8VexDZ36Mosa34edBKG2S26dzPDcJ1/I/AnuTS948psPP7Ck7qaE9S16o2OLBX210P4rfBEHxsSJ0N1hX5XgztLSPKWvdssHfC9F2W5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cXVP6LIR; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740308552;
	bh=OixaKCYI+zZ7pHBGcv4bDQvYd77BgWqW1bdYwXbp3Gw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cXVP6LIRbZgzRfytxHXs44IUk3ZX4sDMe/v/NU+HnckIuh0K/hyamRajv2S12fj9J
	 KCczFt5C5sDTvAJbZURo7ticlNOsg4NPRPknhaMiDGFuLPzBzCqCBdj0Kyh6Fizplj
	 avySUdQUX8U9yF42QDA5F+8BX6JMHhLnE380v2M3y9zHelLF6yQT9FHtn2jouILuQi
	 Kh9KZl9uJAFNhs6F9ham/thBiLiO0Z4W9B/BjcZ/WH1gDWzrAsXCi4YplPjcgoolqW
	 57CTzctAjCkSRhEBWqPRT8SqehqgkSZC6vB1mpVxXur7TbKu50XXlomubbDwSgoQu9
	 VO44q3fECQM0g==
Received: from localhost (unknown [188.27.58.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 76B0C17E0CFA;
	Sun, 23 Feb 2025 12:02:32 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sun, 23 Feb 2025 13:02:15 +0200
Subject: [PATCH v3 8/8] phy: rockchip: samsung-hdptx: Avoid Hz-hHz unit
 conversion overhead
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250223-phy-sam-hdptx-bpc-v3-8-66a5c8e68327@collabora.com>
References: <20250223-phy-sam-hdptx-bpc-v3-0-66a5c8e68327@collabora.com>
In-Reply-To: <20250223-phy-sam-hdptx-bpc-v3-0-66a5c8e68327@collabora.com>
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
index fdac60bb87510002626735e0e9f18ad5de9a6642..991ff4a2e7613dd4bb2c9cf5443d44794d0eb752 100644
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
@@ -418,45 +418,45 @@ struct rk_hdptx_phy {
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
 
@@ -902,10 +902,10 @@ static void rk_hdptx_phy_disable(struct rk_hdptx_phy *hdptx)
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
@@ -975,16 +975,16 @@ static bool rk_hdptx_phy_clk_pll_calc(unsigned int data_rate,
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
@@ -1122,7 +1122,7 @@ static int rk_hdptx_phy_consumer_get(struct rk_hdptx_phy *hdptx)
 	} else {
 		rate = hdptx->tmds_char_rate ?: hdptx->rate;
 		if (rate) {
-			ret = rk_hdptx_ropll_tmds_cmn_config(hdptx, rate / 100);
+			ret = rk_hdptx_ropll_tmds_cmn_config(hdptx, rate);
 			if (ret)
 				goto dec_usage;
 		}
@@ -1833,18 +1833,17 @@ static unsigned long rk_hdptx_phy_clk_recalc_rate(struct clk_hw *hw,
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
@@ -1865,7 +1864,7 @@ static int rk_hdptx_phy_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 		rate = hdptx->tmds_char_rate;
 	}
 
-	return rk_hdptx_ropll_tmds_cmn_config(hdptx, rate / 100);
+	return rk_hdptx_ropll_tmds_cmn_config(hdptx, rate);
 }
 
 static const struct clk_ops hdptx_phy_clk_ops = {

-- 
2.48.1


