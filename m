Return-Path: <linux-kernel+bounces-527690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 437A4A40E38
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 12:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD1963BD5FC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 11:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8662040AF;
	Sun, 23 Feb 2025 11:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cbNDR1Z2"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C112063EB
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 11:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740308554; cv=none; b=fQkFC2GZ0+8TiCIiJ59cDuw1aKKvb+PGMZwedZBXkGYMvXb1A4Jz8Zpq4WIGUho/K6FlpfG57U6JHyxxtY/HHFou+tsfODfMYhoLe4txYXtfOyAcz8Sg6ZZAR88UzR5r9WDvLmOHH+9TvD6uGVSRzCu9lCSpQ/yira/P5ovRVtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740308554; c=relaxed/simple;
	bh=wi5gL1MuujVnvpKHlNtHCdmjCVgPVDm9mY+mNnIouZw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bnhuahLnuVGPzZTgArC2fA6Mmk8bfN918/goTibWhMTPgy4jYRrmnM7yUhcFebZVSgkz7kGlppf5knmL+u5jvZChOx3zhJyRdp8ysNp1HeE5r6SuWQrGAs4ubKBiLXZOURNkLgttHCI/2XDjt4AWxeYSamtCRMSkxvVweYL+h7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cbNDR1Z2; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740308550;
	bh=wi5gL1MuujVnvpKHlNtHCdmjCVgPVDm9mY+mNnIouZw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cbNDR1Z2WcSH6Bp+0ozgwgcnL8D4NvzT6LrFA8JAx5sLFHuVYGq6sFHB+ZxASsIoy
	 xrVvaYMKdqFJmH8sYsfMuOsn2MHpz+hePXlZgC4qC4g3HMhl3e0N72jHGKEGn+Zf2l
	 a5gMRniXYoJGPtQOddrGaxpK2MYMkaqbp4zUNHo0qhMG2qcd2bpf+8zhJYB0Egb4F5
	 uPWlhu4fKoeOzHr4xDWv13kltlBFJbBuAXKkWHyQEt9rcY8lBzhuw6sWi1hhOMeQOr
	 0nmZrO+Y57IKnWeXwYCh6iud3ynwe3+IWI41O1j3nGy6+Vi3mK5H+/g2sInw39n1ll
	 eNyMzbIDZ9V7w==
Received: from localhost (unknown [188.27.58.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id BF71F17E0199;
	Sun, 23 Feb 2025 12:02:30 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sun, 23 Feb 2025 13:02:13 +0200
Subject: [PATCH v3 6/8] phy: rockchip: samsung-hdptx: Add high color depth
 management
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250223-phy-sam-hdptx-bpc-v3-6-66a5c8e68327@collabora.com>
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

Add support for 8-bit, 10-bit, 12-bit and 16-bit color depth setup.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index dd91a7272e246b2133112effdb080a847fd15abe..792ed3d1459f84e735041f55cac15941f6f785ef 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -404,6 +404,7 @@ struct rk_hdptx_phy {
 
 	/* PHY config opts */
 	unsigned long tmds_char_rate;
+	unsigned int bpc;
 
 	/* clk provider */
 	struct clk_hw hw;
@@ -1032,6 +1033,9 @@ static int rk_hdptx_ropll_tmds_cmn_config(struct rk_hdptx_phy *hdptx,
 	regmap_update_bits(hdptx->regmap, CMN_REG(0086), PLL_PCG_POSTDIV_SEL_MASK,
 			   FIELD_PREP(PLL_PCG_POSTDIV_SEL_MASK, cfg->pms_sdiv));
 
+	regmap_update_bits(hdptx->regmap, CMN_REG(0086), PLL_PCG_CLK_SEL_MASK,
+			   FIELD_PREP(PLL_PCG_CLK_SEL_MASK, (hdptx->bpc - 8) >> 1));
+
 	regmap_update_bits(hdptx->regmap, CMN_REG(0086), PLL_PCG_CLK_EN_MASK,
 			   FIELD_PREP(PLL_PCG_CLK_EN_MASK, 0x1));
 
@@ -1430,7 +1434,7 @@ static int rk_hdptx_phy_power_on(struct phy *phy)
 		rate = phy_get_bus_width(hdptx->phy) & 0xfffffff;
 	}
 
-	dev_dbg(hdptx->dev, "%s rate=%u\n", __func__, rate);
+	dev_dbg(hdptx->dev, "%s rate=%u bpc=%u\n", __func__, rate, hdptx->bpc);
 
 	ret = rk_hdptx_phy_consumer_get(hdptx, rate);
 	if (ret)
@@ -1741,6 +1745,19 @@ static int rk_hdptx_phy_configure(struct phy *phy, union phy_configure_opts *opt
 
 	if (mode != PHY_MODE_DP) {
 		hdptx->tmds_char_rate = opts->hdmi.tmds_char_rate;
+
+		switch (opts->hdmi.bpc) {
+		case 8:
+		case 10:
+		case 12:
+		case 16:
+			hdptx->bpc = opts->hdmi.bpc;
+			break;
+		default:
+			dev_warn(hdptx->dev, "Discarded unsupported bpc: %u\n",
+				 opts->hdmi.bpc);
+		};
+
 		return 0;
 	}
 
@@ -1922,6 +1939,7 @@ static int rk_hdptx_phy_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	hdptx->dev = dev;
+	hdptx->bpc = 8;
 
 	regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(regs))

-- 
2.48.1


