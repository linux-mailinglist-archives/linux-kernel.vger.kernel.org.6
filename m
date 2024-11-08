Return-Path: <linux-kernel+bounces-401814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE409C1F8D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07CD1F21E35
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B972F1F428F;
	Fri,  8 Nov 2024 14:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="MvMdEwof"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B931EABC3
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 14:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731077094; cv=none; b=TcCJa4UroQVlDq3wiQAGvdjUDP7b+45jNPzk/1QzkMcpv29XtLFHJcfQEJ8ZeX80Y0UY2Ok7+c2TNwj1EsLh4KRFMficN2QLQKa8MJiy+rROKqSnCuMI0cvxvJJtLueOLx4iLT05q+hLyq4NTSQJCXo++UkZV4KTA0WeDiEKthI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731077094; c=relaxed/simple;
	bh=NLFsUDQHHIJthk3yE3ViXPuGXrak49j5c5doVsfu1Vs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NOsuxCRU7xU3vS68b2v2M7xnaZH5Wxf5jpOYesj+CaaZjoZ2cJl2v1+P2XRo/pUiv1n99m/tuklTUJk3ArqlCs0qgJjY+3t+D09vUkoVK45Opq68sedg+j/nCz8WSyumNmVjt8muO+vImpoQmIKEjPh2m5Xry3Ysau3i3yvk13s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=MvMdEwof; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Sq1qOtFF69mFoOsytrqshcI4Hj0x/QP2wi6DnImQLW0=; b=MvMdEwofqR70BiYpz8W5OuxiTU
	IZl4ZZvbUwoKHNlHHa01BLTEi6HQuNVZwVPgq38ZoafCnWhP5u8tTLPH0EQHhf2+TRH6UmL/rqjRr
	lvUR+tCJOMb509mHndLjI248FXt1NJkbWR73JLHcQPz1EhKogwCHbShLoqp+1YFQRI6yd351rbVyA
	hjLeTGgLuEjxHPP4GbC46MQVD6x+zW6sL17Ez9NVOo0K/27bKgu4v5QbV6P4hBrWVhjmu9MBWh2qa
	+yoypA7Fi65U1Ph7jvNG+G4t1AReyjTxozhbT00vhuw6UFIbGA5ejm5fqQgn3VkKig3/OEurwKnCy
	DxRJOdHw==;
Received: from i53875b28.versanet.de ([83.135.91.40] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t9QE1-0006ov-Mk; Fri, 08 Nov 2024 15:44:37 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org,
	dri-devel@lists.freedesktop.org
Cc: dsimic@manjaro.org,
	andy.yan@rock-chips.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH] drm/rockchip: dsi: convert to dev_err_probe in probe function
Date: Fri,  8 Nov 2024 15:44:24 +0100
Message-ID: <20241108144425.1009916-1-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

DRM_DEV_ERROR is deprecated and using dev_err_probe saves quite a number
of lines too, so convert the error prints for the dsi-driver.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   | 80 ++++++-------------
 1 file changed, 26 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index 58a44af0e9ad..3224ab749352 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -1356,17 +1356,15 @@ static int dw_mipi_dsi_rockchip_probe(struct platform_device *pdev)
 	struct resource *res;
 	const struct rockchip_dw_dsi_chip_data *cdata =
 				of_device_get_match_data(dev);
-	int ret, i;
+	int i;
 
 	dsi = devm_kzalloc(dev, sizeof(*dsi), GFP_KERNEL);
 	if (!dsi)
 		return -ENOMEM;
 
 	dsi->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
-	if (IS_ERR(dsi->base)) {
-		DRM_DEV_ERROR(dev, "Unable to get dsi registers\n");
-		return PTR_ERR(dsi->base);
-	}
+	if (IS_ERR(dsi->base))
+		return dev_err_probe(dev, PTR_ERR(dsi->base), "Unable to get dsi registers\n");
 
 	i = 0;
 	while (cdata[i].reg) {
@@ -1378,67 +1376,47 @@ static int dw_mipi_dsi_rockchip_probe(struct platform_device *pdev)
 		i++;
 	}
 
-	if (!dsi->cdata) {
-		DRM_DEV_ERROR(dev, "no dsi-config for %s node\n", np->name);
-		return -EINVAL;
-	}
+	if (!dsi->cdata)
+		return dev_err_probe(dev, -EINVAL, "No dsi-config for %s node\n", np->name);
 
 	/* try to get a possible external dphy */
 	dsi->phy = devm_phy_optional_get(dev, "dphy");
-	if (IS_ERR(dsi->phy)) {
-		ret = PTR_ERR(dsi->phy);
-		DRM_DEV_ERROR(dev, "failed to get mipi dphy: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(dsi->phy))
+		return dev_err_probe(dev, PTR_ERR(dsi->phy), "Failed to get mipi dphy\n");
 
 	dsi->pclk = devm_clk_get(dev, "pclk");
-	if (IS_ERR(dsi->pclk)) {
-		ret = PTR_ERR(dsi->pclk);
-		DRM_DEV_ERROR(dev, "Unable to get pclk: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(dsi->pclk))
+		return dev_err_probe(dev, PTR_ERR(dsi->pclk), "Unable to get pclk\n");
 
 	dsi->pllref_clk = devm_clk_get(dev, "ref");
 	if (IS_ERR(dsi->pllref_clk)) {
-		if (dsi->phy) {
+		if (dsi->phy)
 			/*
 			 * if external phy is present, pll will be
 			 * generated there.
 			 */
 			dsi->pllref_clk = NULL;
-		} else {
-			ret = PTR_ERR(dsi->pllref_clk);
-			DRM_DEV_ERROR(dev,
-				      "Unable to get pll reference clock: %d\n",
-				      ret);
-			return ret;
-		}
+		else
+			return dev_err_probe(dev, PTR_ERR(dsi->pllref_clk),
+					     "Unable to get pll reference clock\n");
 	}
 
 	if (dsi->cdata->flags & DW_MIPI_NEEDS_PHY_CFG_CLK) {
 		dsi->phy_cfg_clk = devm_clk_get(dev, "phy_cfg");
-		if (IS_ERR(dsi->phy_cfg_clk)) {
-			ret = PTR_ERR(dsi->phy_cfg_clk);
-			DRM_DEV_ERROR(dev,
-				      "Unable to get phy_cfg_clk: %d\n", ret);
-			return ret;
-		}
+		if (IS_ERR(dsi->phy_cfg_clk))
+			return dev_err_probe(dev, PTR_ERR(dsi->phy_cfg_clk),
+					     "Unable to get phy_cfg_clk\n");
 	}
 
 	if (dsi->cdata->flags & DW_MIPI_NEEDS_GRF_CLK) {
 		dsi->grf_clk = devm_clk_get(dev, "grf");
-		if (IS_ERR(dsi->grf_clk)) {
-			ret = PTR_ERR(dsi->grf_clk);
-			DRM_DEV_ERROR(dev, "Unable to get grf_clk: %d\n", ret);
-			return ret;
-		}
+		if (IS_ERR(dsi->grf_clk))
+			return dev_err_probe(dev, PTR_ERR(dsi->grf_clk), "Unable to get grf_clk\n");
 	}
 
 	dsi->grf_regmap = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
-	if (IS_ERR(dsi->grf_regmap)) {
-		DRM_DEV_ERROR(dev, "Unable to get rockchip,grf\n");
-		return PTR_ERR(dsi->grf_regmap);
-	}
+	if (IS_ERR(dsi->grf_regmap))
+		return dev_err_probe(dev, PTR_ERR(dsi->grf_regmap), "Unable to get rockchip,grf\n");
 
 	dsi->dev = dev;
 	dsi->pdata.base = dsi->base;
@@ -1451,24 +1429,18 @@ static int dw_mipi_dsi_rockchip_probe(struct platform_device *pdev)
 	mutex_init(&dsi->usage_mutex);
 
 	dsi->dphy = devm_phy_create(dev, NULL, &dw_mipi_dsi_dphy_ops);
-	if (IS_ERR(dsi->dphy)) {
-		DRM_DEV_ERROR(&pdev->dev, "failed to create PHY\n");
-		return PTR_ERR(dsi->dphy);
-	}
+	if (IS_ERR(dsi->dphy))
+		return dev_err_probe(dev, PTR_ERR(dsi->dphy), "Failed to create PHY\n");
 
 	phy_set_drvdata(dsi->dphy, dsi);
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
 	if (IS_ERR(phy_provider))
-		return PTR_ERR(phy_provider);
+		return dev_err_probe(dev, PTR_ERR(phy_provider),
+				     "Failed to register phy-provider\n");
 
 	dsi->dmd = dw_mipi_dsi_probe(pdev, &dsi->pdata);
-	if (IS_ERR(dsi->dmd)) {
-		ret = PTR_ERR(dsi->dmd);
-		if (ret != -EPROBE_DEFER)
-			DRM_DEV_ERROR(dev,
-				      "Failed to probe dw_mipi_dsi: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(dsi->dmd))
+		return dev_err_probe(dev, PTR_ERR(dsi->dmd), "Failed to probe dw_mipi_dsi\n");
 
 	return 0;
 }
-- 
2.45.2


