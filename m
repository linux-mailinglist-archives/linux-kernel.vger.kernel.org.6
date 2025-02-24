Return-Path: <linux-kernel+bounces-528384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F315BA41729
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADC3417362E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1261194A44;
	Mon, 24 Feb 2025 08:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="RhFY3D8+"
Received: from mail-m32123.qiye.163.com (mail-m32123.qiye.163.com [220.197.32.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3FF5D8F0;
	Mon, 24 Feb 2025 08:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740385164; cv=none; b=FdtpVIaMTZGHuaZU/Onv5QMmDFnZglGs9svQvoYet8eSinFd7Dm0r79VB4PzfzV1mubuDEAKb4ee+TAAVYMNir+tZ0Bg8tIsr+zil4w7KGDxt7NkYy2eqrz3xI4e1EdFYYibUs0VEwSABOkkkGHh3ilIP/AibBLzlNyi/9EzDa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740385164; c=relaxed/simple;
	bh=AEerpXENcstHX1+gXDYcSpc0e7XUtWzyacOmwlgaeUk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k38vaPeyJHXNzq8Uy6f0kl6C1UDmN5nMSMFlyiaDyX9dVFM/tYlN0ZrIwhpRqinkBGRXX/UHX6Rf2N5ycusjQCh8CWeCrociDr4uTSUITNNNUQJvplaaiRYm2oirRU5nS9k+LiHHb4tQKN0sV4CBP/RKNIiPpkgS6Q1M3hTaAy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=RhFY3D8+; arc=none smtp.client-ip=220.197.32.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id bfd287c2;
	Mon, 24 Feb 2025 16:14:03 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: heiko@sntech.de
Cc: andy.yan@rock-chips.com,
	hjc@rock-chips.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	dmitry.baryshkov@linaro.org,
	dianders@chromium.org,
	sebastian.reichel@collabora.com,
	cristian.ciocaltea@collabora.com,
	boris.brezillon@collabora.com,
	l.stach@pengutronix.de,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v7 04/15] drm/bridge: analogix_dp: Remove the unnecessary calls to clk_disable_unprepare() during probing
Date: Mon, 24 Feb 2025 16:13:14 +0800
Message-Id: <20250224081325.96724-5-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224081325.96724-1-damon.ding@rock-chips.com>
References: <20250224081325.96724-1-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ05JSFZPQh8eGhgYSUpPSkNWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a953705365703a3kunmbfd287c2
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pz46FQw4MzIONxNWTT4uETEv
	AzpPCS1VSlVKTE9LSENPQ09OSE1NVTMWGhIXVR8aFhQVVR8SFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJSENONwY+
DKIM-Signature:a=rsa-sha256;
	b=RhFY3D8+01Zany8/FVPwFeNfI8Nep2zTus9v0jfNh2VgjfdPDmvgF9hY0aLTlYEWq47hRGpbrwBns//Y5TcLc7m/GATrGdY2eNDBqE2u/z+yoJPwUmCtKn2/8KHbxb2+S3SW1QWzoB/S0/eoIkVmyXc9wJ98i9/scTJUJRu674M=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=qIDpDUZK6hSel5I8fxZivGCbqLzNct87SHt9UpVS6tg=;
	h=date:mime-version:subject:message-id:from;

With the commit f37952339cc2 ("drm/bridge: analogix_dp: handle clock via
runtime PM"), the PM operations can help enable/disable the clock. The
err_disable_clk label and clk_disable_unprepare() operations are no
longer necessary because the analogix_dp_resume() will not be called
during probing.

Fixes: f37952339cc2 ("drm/bridge: analogix_dp: handle clock via runtime PM")
Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
---
 .../gpu/drm/bridge/analogix/analogix_dp_core.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index e23af674d91c..d9dafb038e7a 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1608,10 +1608,8 @@ analogix_dp_probe(struct device *dev, struct analogix_dp_plat_data *plat_data)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
 	dp->reg_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(dp->reg_base)) {
-		ret = PTR_ERR(dp->reg_base);
-		goto err_disable_clk;
-	}
+	if (IS_ERR(dp->reg_base))
+		return ERR_CAST(dp->reg_base);
 
 	dp->force_hpd = of_property_read_bool(dev->of_node, "force-hpd");
 
@@ -1623,8 +1621,7 @@ analogix_dp_probe(struct device *dev, struct analogix_dp_plat_data *plat_data)
 	if (IS_ERR(dp->hpd_gpiod)) {
 		dev_err(dev, "error getting HDP GPIO: %ld\n",
 			PTR_ERR(dp->hpd_gpiod));
-		ret = PTR_ERR(dp->hpd_gpiod);
-		goto err_disable_clk;
+		return ERR_CAST(dp->hpd_gpiod);
 	}
 
 	if (dp->hpd_gpiod) {
@@ -1644,8 +1641,7 @@ analogix_dp_probe(struct device *dev, struct analogix_dp_plat_data *plat_data)
 
 	if (dp->irq == -ENXIO) {
 		dev_err(&pdev->dev, "failed to get irq\n");
-		ret = -ENODEV;
-		goto err_disable_clk;
+		return ERR_PTR(-ENODEV);
 	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, dp->irq,
@@ -1654,14 +1650,10 @@ analogix_dp_probe(struct device *dev, struct analogix_dp_plat_data *plat_data)
 					irq_flags, "analogix-dp", dp);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to request irq\n");
-		goto err_disable_clk;
+		return ERR_PTR(ret);
 	}
 
 	return dp;
-
-err_disable_clk:
-	clk_disable_unprepare(dp->clock);
-	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(analogix_dp_probe);
 
-- 
2.34.1


