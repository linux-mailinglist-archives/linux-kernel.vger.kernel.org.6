Return-Path: <linux-kernel+bounces-316642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADCF96D246
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A9FE1C24E40
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3762194C6E;
	Thu,  5 Sep 2024 08:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="rlAgLGN9"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D49194AD6
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 08:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725525392; cv=none; b=SKEuozEmrXLYXJcUebYvpypgs2YWMQQr+6TWfDaduAZVhV9nQHx1W2Yv3NcirIiWAFNXZ7MK7+u4LPp/3HA0yy7CHKJr6gdjxByZKtcdPl/uMwm4O/LWZJfkXblCkfi3uNXn55nuM0U3nMPIkGHjWJE79keR4mM/8vRiVSBv9HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725525392; c=relaxed/simple;
	bh=jJ7kPLskOw9Hth7L6QnpCBjEqdbh5g8PiUWVEsTN6c8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ttzTssgfCkbMvXtDPITwwQr/LfAYJBoRHXYdDkl/bsok7A/NhKjyLST3/Q3qfF0ESmby9RgOp1PROXrNjtdz8vVHWgQP1y5ogp72EvrFCN+LAqIOhYmfY8jYnNtk7tHRBWAfPX4SZWNLaR19wZX242T25ZR8+F69PjbEy/+dwYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=rlAgLGN9; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1725524911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LKQyp3YpQxjcuqGPlEIjyuaJl+vnUPygQPPMGal7PhU=;
	b=rlAgLGN98UKkJke94KHptuvM3DTMh0X4zZ3vpJvME5OUjBlFDXcF+jDysU7SvWXs1AOyme
	iRwbgVUjc/AGCJuqBUUg6VPk1c/tGMta84iwhcL3b2pnfubYJXAE2VbVboBDmBONB7i2Ih
	JrZUDuH1srVoh1L2ewfBBli9LNNy3TThoHu9z6lFnvOl521pMgylNcP8Zdfl5Ex6ZzrOkm
	qsiupyP8lZI/fDblJOU7OajAeIrANB6/fx5awvcxBuwnDfsSg4fUWSbiISxkH4b6d2fr23
	K6N8TKJU9nm9JDilSbSVjVxZgzPUTgQKHC7xStQ+ZoDeu9UCcDc+UbbdupPfFA==
To: linux-rockchip@lists.infradead.org,
	linux-phy@lists.infradead.org
Cc: vkoul@kernel.org,
	kishon@kernel.org,
	heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] phy: phy-rockchip-inno-usb2: Use dev_err_probe() in the probe path
Date: Thu,  5 Sep 2024 10:28:24 +0200
Message-Id: <d4ccd9fc278fb46ea868406bf77811ee507f0e4e.1725524803.git.dsimic@manjaro.org>
In-Reply-To: <cover.1725524802.git.dsimic@manjaro.org>
References: <cover.1725524802.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Improve error handling in the probe path by using function dev_err_probe()
instead of function dev_err(), where appropriate.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 27 +++++++------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index cf6b67dd9f10..6e5214862b8a 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -424,25 +424,22 @@ static int rockchip_usb2phy_extcon_register(struct rockchip_usb2phy *rphy)
 
 	if (of_property_read_bool(node, "extcon")) {
 		edev = extcon_get_edev_by_phandle(rphy->dev, 0);
-		if (IS_ERR(edev)) {
-			if (PTR_ERR(edev) != -EPROBE_DEFER)
-				dev_err(rphy->dev, "Invalid or missing extcon\n");
-			return PTR_ERR(edev);
-		}
+		if (IS_ERR(edev))
+			return dev_err_probe(rphy->dev, PTR_ERR(edev),
+					     "invalid or missing extcon\n");
 	} else {
 		/* Initialize extcon device */
 		edev = devm_extcon_dev_allocate(rphy->dev,
 						rockchip_usb2phy_extcon_cable);
 
 		if (IS_ERR(edev))
 			return dev_err_probe(rphy->dev, PTR_ERR(edev),
 					     "failed to allocate extcon device\n");
 
 		ret = devm_extcon_dev_register(rphy->dev, edev);
-		if (ret) {
-			dev_err(rphy->dev, "failed to register extcon device\n");
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(rphy->dev, ret,
+					     "failed to register extcon device\n");
 	}
 
 	rphy->edev = edev;
@@ -1408,10 +1405,8 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 				     "failed to get phyclk\n");
 
 	ret = rockchip_usb2phy_clk480m_register(rphy);
-	if (ret) {
-		dev_err(dev, "failed to register 480m output clock\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register 480m output clock\n");
 
 	if (rphy->phy_cfg->phy_tuning) {
 		ret = rphy->phy_cfg->phy_tuning(rphy);
@@ -1431,8 +1426,7 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 
 		phy = devm_phy_create(dev, child_np, &rockchip_usb2phy_ops);
 		if (IS_ERR(phy)) {
-			dev_err_probe(dev, PTR_ERR(phy), "failed to create phy\n");
-			ret = PTR_ERR(phy);
+			ret = dev_err_probe(dev, PTR_ERR(phy), "failed to create phy\n");
 			goto put_child;
 		}
 
@@ -1467,8 +1461,7 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 						"rockchip_usb2phy",
 						rphy);
 		if (ret) {
-			dev_err(rphy->dev,
-				"failed to request usb2phy irq handle\n");
+			dev_err_probe(rphy->dev, ret, "failed to request usb2phy irq handle\n");
 			goto put_child;
 		}
 	}

