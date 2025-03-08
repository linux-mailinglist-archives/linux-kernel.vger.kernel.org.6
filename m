Return-Path: <linux-kernel+bounces-552472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CC7A57A21
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 13:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9545A16F27C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 12:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194FA1E520D;
	Sat,  8 Mar 2025 12:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VjDqM1TU"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58A71DF73C
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 12:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741436507; cv=none; b=tWmkLr6UwTZgAXLWH6ljg9H2mTPucqzD5lrWYjmgCzcU2k9s00SaRMTs3BYUGNTA/1GD8YJ8CkUq2s2GuNIvzSIpZHprIJiNRQzt1sTu9WvwYJqaJsAtuE6M0Z5euYaqwTuZN1qlUb8ozCs/lGexwHcXd2/uMUBiVDvnT753lSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741436507; c=relaxed/simple;
	bh=lml/dpWS51d1l7pxeFA3I8arwVEqHo/afRbukZAkt8Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NE+mMYDzpFYzblCHFhu54QptzYan0clvA41VuAxfzI/LfzdsHw3vlaK8cLGEy28UiERfHl2St1gSD8yiWd1a+p5SiIjT90Y2X8yDhnPA3WeiiAiM+G49xjPFKJpwF95Ppk0+XikwKKub6JjcPaBZE3qa4NA1ws3w3CiTIDraGSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VjDqM1TU; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741436504;
	bh=lml/dpWS51d1l7pxeFA3I8arwVEqHo/afRbukZAkt8Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VjDqM1TUvLUofFOdAwLKcwBLB4fwP3QQZK/Cs4OwXvIu2y5aYh1RO70YdLxw6VHP/
	 60TlK+bKztDXcMQaWjpvMKLXrHf4jsTVt3Lk2F4JLEMiiEdazyKdOfGPi3OXpjLcNX
	 IeqiKlVjEkfgr6B3TK584ovM9EBOXeJMEu7s9RxSXqSUwr5wwvyBvxUIT3HOTqXznQ
	 CBjrBqMjXDlS99CzVPGlUQxcoP7oozfQQNgltejyuaYe9K+Nt/hu1p1ZoWCRY+JJAg
	 xmRWacuxifkb4GU+woToupytLsuKFjPcypHT3dXd7vz8ZFoFxo59nDM2m6OP4rA4Pp
	 oGbiMOUb0weVg==
Received: from localhost (unknown [84.232.140.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 2829917E0F75;
	Sat,  8 Mar 2025 13:21:44 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 08 Mar 2025 14:21:21 +0200
Subject: [PATCH v5 12/12] phy: rockchip: samsung-hdptx: Add high color
 depth management
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250308-phy-sam-hdptx-bpc-v5-12-35087287f9d1@collabora.com>
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

Add support for 8-bit, 10-bit, 12-bit and 16-bit color depth setup.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index 98f831c3704f5cd65dcf29a4f0a12862a4aa0482..d115a026f013fdbcd025626bccaa30639856fad7 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -1028,6 +1028,9 @@ static int rk_hdptx_ropll_tmds_cmn_config(struct rk_hdptx_phy *hdptx)
 	regmap_update_bits(hdptx->regmap, CMN_REG(0086), PLL_PCG_POSTDIV_SEL_MASK,
 			   FIELD_PREP(PLL_PCG_POSTDIV_SEL_MASK, cfg->pms_sdiv));
 
+	regmap_update_bits(hdptx->regmap, CMN_REG(0086), PLL_PCG_CLK_SEL_MASK,
+			   FIELD_PREP(PLL_PCG_CLK_SEL_MASK, (hdptx->hdmi_cfg.bpc - 8) >> 1));
+
 	regmap_update_bits(hdptx->regmap, CMN_REG(0086), PLL_PCG_CLK_EN_MASK,
 			   FIELD_PREP(PLL_PCG_CLK_EN_MASK, 0x1));
 
@@ -1427,7 +1430,8 @@ static int rk_hdptx_phy_power_on(struct phy *phy)
 			hdptx->hdmi_cfg.tmds_char_rate *= 100;
 		}
 
-		dev_dbg(hdptx->dev, "%s rate=%llu\n", __func__, hdptx->hdmi_cfg.tmds_char_rate);
+		dev_dbg(hdptx->dev, "%s rate=%llu bpc=%u\n", __func__,
+			hdptx->hdmi_cfg.tmds_char_rate, hdptx->hdmi_cfg.bpc);
 	}
 
 	ret = rk_hdptx_phy_consumer_get(hdptx);
@@ -1492,6 +1496,19 @@ static int rk_hdptx_phy_verify_hdmi_config(struct rk_hdptx_phy *hdptx,
 	    !rk_hdptx_phy_clk_pll_calc(hdmi->tmds_char_rate, NULL))
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
 
@@ -1764,6 +1781,9 @@ static int rk_hdptx_phy_configure(struct phy *phy, union phy_configure_opts *opt
 			hdptx->hdmi_cfg = opts->hdmi;
 			hdptx->restrict_rate_change = true;
 		}
+
+		dev_dbg(hdptx->dev, "%s rate=%llu bpc=%u\n", __func__,
+			hdptx->hdmi_cfg.tmds_char_rate, hdptx->hdmi_cfg.bpc);
 		return ret;
 	}
 
@@ -1972,6 +1992,7 @@ static int rk_hdptx_phy_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	hdptx->dev = dev;
+	hdptx->hdmi_cfg.bpc = 8;
 
 	regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(regs))

-- 
2.48.1


