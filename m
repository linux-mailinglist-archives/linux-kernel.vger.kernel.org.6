Return-Path: <linux-kernel+bounces-566169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A23A6741B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 125D319A52DB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB24820F06C;
	Tue, 18 Mar 2025 12:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Quh4J8Mp"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC6F20E318
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 12:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742301436; cv=none; b=ewjSPpdV92M7jGWBBUSUnrxsinaIPdSTlGf1AaqR5rEK5yVg8Pp+WjBeuekD+U63FNJIK/4dZDgrxRfl/uanWtw7phwg88SpX3GuNrpplwKUQiNteHSGWtZV0jA9gXuwwQjoeEAZmQ2/0Otj5nKHkZ4Y05TlwnNldNSeY0cqhPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742301436; c=relaxed/simple;
	bh=McNeaXrm4EsMnZWOXEDFXBNpHgJWMUFQS+VAPDQUEm0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b8Db2A4e/2PEjDCM+y3Bz0N1yDiFLAJIGgacOXY+39/SeajZr2qTYXN+n/2CAItwys320P1F6+h69IZHyXaawwyStI6f9EQNdQegdBj5fQEYKYfn3pObFMpIsQSeHnHtshX+wehLmYH7kjSS7i/zZtjDK24SpxDr6XdTtnLY/o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Quh4J8Mp; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742301433;
	bh=McNeaXrm4EsMnZWOXEDFXBNpHgJWMUFQS+VAPDQUEm0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Quh4J8MpdzTsZAEdZd9cxG3/78tUDy5C5nGvMqa2FIplkJfeE1wGhHLZttZhtqNpY
	 TeOZZjme5F6GFSkAnnNEmbMZa6erIC0lsH2sxH+GpAQdYDxIwVKa2cC0icJOtPT06f
	 7qsO2w0n0o1/jJMCtR70rlly42OolBGiNiqsSXjC+mmq57DLIp/AOQz4QsoyTJac+o
	 5uNyvEuZv/TE9ly9089ZWjlfRJ2P/wPjSJ6v3RUyF/tLINoL36c13Up4HYuIDUUKJa
	 rjycxvqa9nqEReA1Tcjc5rug22p6NWCghwre6nU0N9CVnfRpJtNdZkQf0hS2A2Yt2g
	 OiD+cdasZ9oMw==
Received: from localhost (unknown [84.232.140.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id CB80617E1581;
	Tue, 18 Mar 2025 13:37:12 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 18 Mar 2025 14:35:48 +0200
Subject: [PATCH v6 14/14] phy: rockchip: samsung-hdptx: Add high color
 depth management
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-phy-sam-hdptx-bpc-v6-14-8cb1678e7663@collabora.com>
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

Add support for 8-bit, 10-bit, 12-bit and 16-bit color depth setup.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index d09e1f7b25ec131d3c40fb52564cad27dce3b2d4..fc289ed8d915d84916870329101655cd956898e3 100644
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


