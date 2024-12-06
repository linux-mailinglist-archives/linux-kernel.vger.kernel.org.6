Return-Path: <linux-kernel+bounces-435721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFA09E7B5E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 23:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB36216149B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4693213E8A;
	Fri,  6 Dec 2024 22:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OKPBZ4WM"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90821212FA3
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 22:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733522643; cv=none; b=mguaAtYXugHs/WT8E7Yhwgv19EL3x9hoIDbpFpHYUZ3PAksgsFQH80quvayxf7jS7FMoZKAI06FUvGtNuT5r5m2Bwb2oIsGkXbKn6EyHIp3keiJt8vHOlWeMdaP77mme6L4O3nFv1D8haXXxdG0g/PZH35ZYDEuoVLs95t3yU0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733522643; c=relaxed/simple;
	bh=w5/YY2wqmqV6QgwYuiXdkpRkQEFMfdXMRewTbnvqfOI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YeOZF1acvMywdqswfJnZwXhK57cuQuHxIm3Z8OEu52Pc711/qLIqIrOYZPvyafgKNaGlk8d+1uWI5azhWBFnBbJgBWy4p87XHQuN8iKSbe7NgnxZrGY6WJ/W/ZPjTG7J0F/jRGdM6FV0te10T9bEQy/pqzlrGtJdEqSbkNpbXm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OKPBZ4WM; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733522639;
	bh=w5/YY2wqmqV6QgwYuiXdkpRkQEFMfdXMRewTbnvqfOI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OKPBZ4WMhNwG9mP28+hs255Bl43GBXU0J7Y6V/Zv7fVi7YetP3gcicm+iFbD3Vzmo
	 0yIjljXtMdXwMjBgcDygWRpSlH235euZZWFWS9w/BfZ8TCWSaz+7AjiApqUtN2XbHE
	 dFGBCJpuEeKqfAEExSIofSXUUK+9WIW6BanRhlGt3inywEicNxx6NqmVmZ1N923AS0
	 k8jO/9g/G/WWiWyqphfVjJqoqP2XZ9Pv4EvAtCOjbL5aX9Ym1ryhEXzGoRshhNR/yl
	 iS+L82AgkDLAwdBt36RXzAYRLpeuFaxV680IK+CadB5+oWoxk8geM5zAD7LqSCHab6
	 aNCXY9XcnDlvw==
Received: from localhost (unknown [188.27.48.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B1DF817E380C;
	Fri,  6 Dec 2024 23:03:59 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 07 Dec 2024 00:03:44 +0200
Subject: [PATCH 4/4] phy: rockchip: samsung-hdptx: Add high color depth
 management
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241207-phy-sam-hdptx-bpc-v1-4-03c2e4d6d797@collabora.com>
References: <20241207-phy-sam-hdptx-bpc-v1-0-03c2e4d6d797@collabora.com>
In-Reply-To: <20241207-phy-sam-hdptx-bpc-v1-0-03c2e4d6d797@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: Sandor Yu <Sandor.yu@nxp.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Maxime Ripard <mripard@kernel.org>, kernel@collabora.com, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
X-Mailer: b4 0.14.2

Add support for 8-bit, 10-bit, 12-bit and 16-bit color depth setup.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index eeadebdc476caa87aebbbd82f7102b62b22a0ea6..76c30c4ad6768679c3e36e3d0789e716afc0bc30 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -274,6 +274,7 @@ struct rk_hdptx_phy {
 	int nr_clks;
 	struct reset_control_bulk_data rsts[RST_MAX];
 	unsigned long tmds_char_rate;
+	unsigned int bpc;
 
 	/* clk provider */
 	struct clk_hw hw;
@@ -814,6 +815,9 @@ static int rk_hdptx_ropll_tmds_cmn_config(struct rk_hdptx_phy *hdptx,
 	regmap_update_bits(hdptx->regmap, CMN_REG(0086), PLL_PCG_POSTDIV_SEL_MASK,
 			   FIELD_PREP(PLL_PCG_POSTDIV_SEL_MASK, cfg->pms_sdiv));
 
+	regmap_update_bits(hdptx->regmap, CMN_REG(0086), PLL_PCG_CLK_SEL_MASK,
+			   FIELD_PREP(PLL_PCG_CLK_SEL_MASK, (hdptx->bpc - 8) >> 1));
+
 	regmap_update_bits(hdptx->regmap, CMN_REG(0086), PLL_PCG_CLK_EN,
 			   PLL_PCG_CLK_EN);
 
@@ -916,7 +920,7 @@ static int rk_hdptx_phy_power_on(struct phy *phy)
 		rate = phy_get_bus_width(hdptx->phy) & 0xfffffff;
 	}
 
-	dev_dbg(hdptx->dev, "%s rate=%u\n", __func__, rate);
+	dev_dbg(hdptx->dev, "%s rate=%u bpc=%u\n", __func__, rate, hdptx->bpc);
 
 	ret = rk_hdptx_phy_consumer_get(hdptx, rate);
 	if (ret)
@@ -943,6 +947,18 @@ static int rk_hdptx_phy_configure(struct phy *phy,
 
 	hdptx->tmds_char_rate = opts->hdmi.tmds_char_rate;
 
+	switch (opts->hdmi.bpc) {
+	case 8:
+	case 10:
+	case 12:
+	case 16:
+		hdptx->bpc = opts->hdmi.bpc;
+		break;
+	default:
+		dev_warn(hdptx->dev, "Discarded unsupported bpc: %u\n",
+			 opts->hdmi.bpc);
+	};
+
 	return 0;
 }
 
@@ -1090,6 +1106,7 @@ static int rk_hdptx_phy_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	hdptx->dev = dev;
+	hdptx->bpc = 8;
 
 	regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(regs))

-- 
2.47.0


