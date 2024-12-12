Return-Path: <linux-kernel+bounces-443867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5039EFCF3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D352188DB70
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0731D88DD;
	Thu, 12 Dec 2024 20:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pvpmLsnl"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F22E1B3942
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 20:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734033848; cv=none; b=S+lIm8y8m76AwrpbBzrmO8yEOdX8G1tml8Zqv4oa63MRrPMYgrPkiRDqQh6Osv2gM/uJztGrjTNMtKwUtZruMzOdu0pIDEyR2zAJX1FcFXM/5iOWa9g6RA32457IQ+kfCL5eTSufAbzyjLe23U/FXgk3k+8QOICkvxo5V/jv5i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734033848; c=relaxed/simple;
	bh=0KBDAKlS6OTWKJsepDHtAwj7Of1rpZ03O65zQOei1Q0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O3HEeyJOV53bl7+oH3j4bJat09XF+NKFUcKEALN+J/0+EAZFQomhA8jHHsQBbp4y1i61snWZ5IG5g4uLZ3S8TRC6BzS9KC5oDLAOg9lxohQ9VeABRXm9OUeWzTIFLJQySjnBtGzM6upCZb+dsogBHADU/o4HFXHxe10z8o3+sXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pvpmLsnl; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734033839;
	bh=0KBDAKlS6OTWKJsepDHtAwj7Of1rpZ03O65zQOei1Q0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pvpmLsnlAopc9qomZW/3qhi0MIBoJx3de9mjXNgBIaQIniAV2umZv8dQhqfCwCgVN
	 kamh5ZFgzGX16C/u2LVaW8WwDrQdJJXpcglGSMUEyPbhi0ffUNlebEQRaHjQmlt96U
	 jvIf+ot4z7BjoIMbwzEczrmpCxrqFgj1kj++7Y4G2Z/SLNE7dN1rPqpnfrcyr/Rlk8
	 FY051B5A9zTZqvz69s9umooGut/CvZWQbCp503GbrFUhCiu7tVG6Ta7MrY5pZ0fk8q
	 QRL3MixMXgpeifLacKqM8GhzFpcDGg9SUbO4vpUVJHTXTWlDxMhTEMh5Jf5m7IJyq9
	 jrkq8V0K8LC7Q==
Received: from localhost (unknown [188.27.48.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 42ADF17E3802;
	Thu, 12 Dec 2024 21:03:59 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 12 Dec 2024 22:03:37 +0200
Subject: [PATCH v2 6/8] phy: rockchip: samsung-hdptx: Add high color depth
 management
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-phy-sam-hdptx-bpc-v2-6-57e672c7c7c4@collabora.com>
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

Add support for 8-bit, 10-bit, 12-bit and 16-bit color depth setup.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index bf0c7d74e70b9204c97c571e08cb0c140131acb9..d90d89cfdff561e13ac3db3f143a4eef9cc85a03 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -246,6 +246,7 @@ struct rk_hdptx_phy {
 
 	/* PHY config opts */
 	unsigned long tmds_char_rate;
+	unsigned int bpc;
 
 	/* clk provider */
 	struct clk_hw hw;
@@ -786,6 +787,9 @@ static int rk_hdptx_ropll_tmds_cmn_config(struct rk_hdptx_phy *hdptx,
 	regmap_update_bits(hdptx->regmap, CMN_REG(0086), PLL_PCG_POSTDIV_SEL_MASK,
 			   FIELD_PREP(PLL_PCG_POSTDIV_SEL_MASK, cfg->pms_sdiv));
 
+	regmap_update_bits(hdptx->regmap, CMN_REG(0086), PLL_PCG_CLK_SEL_MASK,
+			   FIELD_PREP(PLL_PCG_CLK_SEL_MASK, (hdptx->bpc - 8) >> 1));
+
 	regmap_update_bits(hdptx->regmap, CMN_REG(0086), PLL_PCG_CLK_EN,
 			   PLL_PCG_CLK_EN);
 
@@ -888,7 +892,7 @@ static int rk_hdptx_phy_power_on(struct phy *phy)
 		rate = phy_get_bus_width(hdptx->phy) & 0xfffffff;
 	}
 
-	dev_dbg(hdptx->dev, "%s rate=%u\n", __func__, rate);
+	dev_dbg(hdptx->dev, "%s rate=%u bpc=%u\n", __func__, rate, hdptx->bpc);
 
 	ret = rk_hdptx_phy_consumer_get(hdptx, rate);
 	if (ret)
@@ -915,6 +919,18 @@ static int rk_hdptx_phy_configure(struct phy *phy,
 
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
 
@@ -1062,6 +1078,7 @@ static int rk_hdptx_phy_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	hdptx->dev = dev;
+	hdptx->bpc = 8;
 
 	regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(regs))

-- 
2.47.0


