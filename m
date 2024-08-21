Return-Path: <linux-kernel+bounces-295064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A03D0959638
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 09:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A8B21F223DF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 07:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AA91A2856;
	Wed, 21 Aug 2024 07:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="VAhqzafl"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3D21A7AE9
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 07:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724225983; cv=none; b=mGXU5N38bbn9y6f01FIPkhdOqj8/MhIZMKsmfnJ+qjWsEj4dJoWoRHzsa4m7f/rFo4oZpO4IeZqv/fCbl8f4p33YYut8sdThczUElmzX0oE2X157ZVeUKxHeMM5c78oST03vqx65w3Yi5FjdUXZxu5yrL350jxqVji8BuIKjJmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724225983; c=relaxed/simple;
	bh=6AOg0TGx7zJyk+vrMsVXsqkYgQ3pqFUnc3aNtU6xKC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JHlAnUg7aKHnnptKU4MqE6duqjB6I26k8CaWP0sHtBkBUy7YMM2kc6iJGDl3X2l8JGL8emAnKKZxwSzblmI+jPCU8tCz6zNYlZs+nZ9VVzeGLwO599yTuDA7Lxg35DDM4sTVqh7TwvHv9OuakHPt80SXJiVBWCEIrVWNryWq7gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=VAhqzafl; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1724225884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7mpSgzy1mYsfmRZERxM1qKQwFf2Bvpti+0UrXxT9LS0=;
	b=VAhqzafl1g0io65W7HyURf3pSL/CuyQtt3tQtsLmL6RP/7/Y5D791BM11qXYjdTOzK1Uxd
	rUlZZtpStM7cbXzID5nq2aaFkEOusbAipxhnIUIJSvCs68zSJ8dSNkerAHOXN/A3t6uK1r
	nxx2Abak3LxXCzttOgeF1wkzldIDOQl+uh8B3uEWv66dsOeXBWQQyqLv1AV3AGP7bdbKen
	BZsZCj/L/ai2OosxqRKfLcuNUskNohqchZeEJbHg7AVSweKIJfNQp3jWdM/95k0IDOd5OR
	KSjZCjdexqBVPeZphtsQ9KPqX2t1Ki72Crfle9BHveqVOOsraqle0SOMPgwiug==
To: linux-rockchip@lists.infradead.org,
	linux-phy@lists.infradead.org
Cc: vkoul@kernel.org,
	kishon@kernel.org,
	heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] phy: phy-rockchip-inno-usb2: Improve error handling while probing
Date: Wed, 21 Aug 2024 09:37:55 +0200
Message-Id: <866445027a4f41165c872f494b04c218b6e67b09.1724225528.git.dsimic@manjaro.org>
In-Reply-To: <cover.1724225528.git.dsimic@manjaro.org>
References: <cover.1724225528.git.dsimic@manjaro.org>
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
where appropriate, and by no longer using it rather pointlessly in one place
that actually produces a single, hardcoded error code.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 33 ++++++++-----------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 05af46dda11d..30b6134365ec 100644
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
@@ -1375,8 +1372,10 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 	rphy->irq = platform_get_irq_optional(pdev, 0);
 	platform_set_drvdata(pdev, rphy);
 
-	if (!phy_cfgs)
-		return dev_err_probe(dev, -EINVAL, "phy configs are not assigned!\n");
+	if (!phy_cfgs) {
+		dev_err(dev, "phy configs are not assigned\n");
+		return -EINVAL;
+	}
 
 	ret = rockchip_usb2phy_extcon_register(rphy);
 	if (ret)
@@ -1407,10 +1406,8 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
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
@@ -1430,8 +1427,7 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 
 		phy = devm_phy_create(dev, child_np, &rockchip_usb2phy_ops);
 		if (IS_ERR(phy)) {
-			dev_err_probe(dev, PTR_ERR(phy), "failed to create phy\n");
-			ret = PTR_ERR(phy);
+			ret = dev_err_probe(dev, PTR_ERR(phy), "failed to create phy\n");
 			goto put_child;
 		}
 
@@ -1466,8 +1462,7 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 						"rockchip_usb2phy",
 						rphy);
 		if (ret) {
-			dev_err(rphy->dev,
-				"failed to request usb2phy irq handle\n");
+			dev_err_probe(rphy->dev, ret, "failed to request usb2phy irq handle\n");
 			goto put_child;
 		}
 	}

