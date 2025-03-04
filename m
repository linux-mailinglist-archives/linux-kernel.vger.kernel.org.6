Return-Path: <linux-kernel+bounces-543075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2D4A4D12A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34E67173C0E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E1A1EBA07;
	Tue,  4 Mar 2025 01:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aocf8aFw"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518FE14A60F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 01:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741052672; cv=none; b=OxDzp/WYh7oNDOySeA3vrDnLezBohgCnuautHFQAxL8bW8bnTZyzV8tEQcg5B9fwEaBSAJe5ztPd7wD136yKcWTEY7gbDQS0VBI6mC6MXRUgfTc0TxLeknmuB0PZp7RjTSQGcOkpwogDfFllfgS2U03CyMzAsYdIBICFwnbx8ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741052672; c=relaxed/simple;
	bh=jfd6p5DWajkPySB9m0l6HI8kDxxg6TaqMhpM/+vLwpc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JLJYyVGwBvA3apgg0aeVGA7AsZryjAIGQwx36UnLF36UgQDncpTTF35uiJ+3MpxH7TZ48VUtkdyBqQeeUbBKYxeEh5kjy7b4K8l+XqZo7YLnTsGJa2ER32enSkvfUIDi64roz5lAGQ6E5LlqAEBANVgEQWjz9f4jtft+morrfsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aocf8aFw; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741052666;
	bh=jfd6p5DWajkPySB9m0l6HI8kDxxg6TaqMhpM/+vLwpc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aocf8aFwkn5pRO7JxffV2FcYXh0n3dwMbuEDHijiSRdEByw+KtvJaDGFZg5C+dQcL
	 6auLv7WG34W3q1C5nIrj8cBXjAUD52JG+FmDMg3R0Kd/D0J9FIJ/sYTjunqJ6v4CPg
	 jIxSCMRvhYa+aeQG4h++1WTOWR3j3zfRLnOadjc6458gk79nBq5+j1vyIg/+iwc8Zp
	 wMGcnkJTNZLAfHuKQH/Xh9yVufB6YWVuBBa0hxZYfV81FJwgl7iST2XcX7vxa+oEDz
	 v/89ozT/8cTwT+jQzRBIOV91zs7uylo/YNjZLKDgDiT9k52UTDArH5QlE2O18FtVnN
	 GgmrLN11gRU4g==
Received: from localhost (unknown [188.27.58.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id D791317E1048;
	Tue,  4 Mar 2025 02:44:25 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 04 Mar 2025 03:44:09 +0200
Subject: [PATCH v4 10/12] phy: rockchip: samsung-hdptx: Add high color
 depth management
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-phy-sam-hdptx-bpc-v4-10-8657847c13f7@collabora.com>
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

Add support for 8-bit, 10-bit, 12-bit and 16-bit color depth setup.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 29 +++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index b4d2f04842b5c5b425c5b73a8b27fabecbbbd6bb..c2ad1cb94614711bea13b7259a6b66dbd72d663d 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -1027,6 +1027,9 @@ static int rk_hdptx_ropll_tmds_cmn_config(struct rk_hdptx_phy *hdptx,
 	regmap_update_bits(hdptx->regmap, CMN_REG(0086), PLL_PCG_POSTDIV_SEL_MASK,
 			   FIELD_PREP(PLL_PCG_POSTDIV_SEL_MASK, cfg->pms_sdiv));
 
+	regmap_update_bits(hdptx->regmap, CMN_REG(0086), PLL_PCG_CLK_SEL_MASK,
+			   FIELD_PREP(PLL_PCG_CLK_SEL_MASK, (hdptx->hdmi_cfg.bpc - 8) >> 1));
+
 	regmap_update_bits(hdptx->regmap, CMN_REG(0086), PLL_PCG_CLK_EN_MASK,
 			   FIELD_PREP(PLL_PCG_CLK_EN_MASK, 0x1));
 
@@ -1428,7 +1431,8 @@ static int rk_hdptx_phy_power_on(struct phy *phy)
 		} else {
 			rate = hdptx->hdmi_cfg.tmds_char_rate / 100;
 		}
-		dev_dbg(hdptx->dev, "%s rate=%u\n", __func__, rate);
+		dev_dbg(hdptx->dev, "%s rate=%u bpc=%u\n",
+			__func__, rate, hdptx->hdmi_cfg.bpc);
 	}
 
 	ret = rk_hdptx_phy_consumer_get(hdptx, rate);
@@ -1480,12 +1484,12 @@ static int rk_hdptx_phy_power_off(struct phy *phy)
 static int rk_hdptx_phy_verify_hdmi_config(struct rk_hdptx_phy *hdptx,
 					   struct phy_configure_opts_hdmi *hdmi)
 {
-	if (!hdmi->tmds_char_rate || hdmi->tmds_char_rate > HDMI20_MAX_RATE)
-		return -EINVAL;
-
 	u32 bit_rate = hdmi->tmds_char_rate / 100;
 	int i;
 
+	if (!hdmi->tmds_char_rate || hdmi->tmds_char_rate > HDMI20_MAX_RATE)
+		return -EINVAL;
+
 	for (i = 0; i < ARRAY_SIZE(ropll_tmds_cfg); i++)
 		if (bit_rate == ropll_tmds_cfg[i].bit_rate)
 			break;
@@ -1494,6 +1498,19 @@ static int rk_hdptx_phy_verify_hdmi_config(struct rk_hdptx_phy *hdptx,
 	    !rk_hdptx_phy_clk_pll_calc(bit_rate, NULL))
 		return -EINVAL;
 
+	if (!hdmi->bpc)
+		hdmi->bpc = 8;
+
+	switch (hdmi->bpc) {
+	case 8:
+	case 10:
+	case 12:
+	case 16:
+		break;
+	default:
+		return -EINVAL;
+	};
+
 	return 0;
 }
 
@@ -1766,6 +1783,9 @@ static int rk_hdptx_phy_configure(struct phy *phy, union phy_configure_opts *opt
 			hdptx->hdmi_cfg = opts->hdmi;
 			hdptx->restrict_rate_change = true;
 		}
+
+		dev_dbg(hdptx->dev, "%s tmds_rate=%llu bpc=%u\n", __func__,
+			hdptx->hdmi_cfg.tmds_char_rate, hdptx->hdmi_cfg.bpc);
 		return ret;
 	}
 
@@ -1974,6 +1994,7 @@ static int rk_hdptx_phy_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	hdptx->dev = dev;
+	hdptx->hdmi_cfg.bpc = 8;
 
 	regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(regs))

-- 
2.48.1


