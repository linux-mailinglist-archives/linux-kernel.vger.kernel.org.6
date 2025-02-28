Return-Path: <linux-kernel+bounces-538993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2066A49FA2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EB8C3BDCD7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A192B1F099D;
	Fri, 28 Feb 2025 16:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="qCZpn5kP"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C231F0981
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 16:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740761911; cv=none; b=hGlMj5qh+bqnmrPVfBYmhUM1wHibe2uixb5bj7qhFSKBUlS2PIN5J61F/PAnHylXA6tGW3EHfUE/sdqoLM0F05FQYDQkXm1/zD2iZTByy16+BLgJib0GtTfeufaeb80Eo9yVAUMWMZ5Cw+lUpNXdq2QbuBkeomKsQN7fHhSTDe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740761911; c=relaxed/simple;
	bh=j9YPP8V3hmfdeVy7SH4mjGu+s13zo0yLIeUx45p+eSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dCZM8hNAsMQ26Zuq3/4Mq91fcTcwAbT4Mt7D534CRX5fm34yj56xjxAmrlzQBYSVdyGH3UjlQs3jICj9OFhr/qC6dTW3y3KnLqCmOApvCfKD8m9g03iZtc8F7p7masrMLUMf32mzAiX2v469lldSkMmZ5zK9IXGjTw+x/vAmj2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=qCZpn5kP; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eyvQ0/Z7QTBfO6CGrJXY2+e55dObdyQNr27A1fDZuvY=; b=qCZpn5kP3AmOL4XNREB1JHUcVk
	zdURugz3vhK0Yjh1pHiqNWNf7RPvmhw2cmaAIvlIJpfLIDreTy6yEGIDVKBan2QrrVAtBVRGajJEE
	dor13iJ7yX+ZBQcnBtCF8A7W+x8OrXMYRcgWtTvM5/zH69VaPZqFhMjjBznaUDPhrUxWJU2liPvRj
	Nsrc1FWO2dWtPXY6yj8rlA/5F9bqwilOIxyzWPqIVcfXt9eNLI0n0ZM0oOCigrkcoT88ioB7gHLsg
	sqaA4hg34AxLUCr3jKja5IqLRChfwq3aqoFkXzk4YK2FNpUPLaiDso0YSfKBcmp9XgQEiti5gwdg+
	eqQYvNdQ==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1to3gh-00029i-84; Fri, 28 Feb 2025 17:58:11 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: andy.yan@rock-chips.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	quentin.schulz@cherry.de,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 1/2] drm/rockchip: lvds: move pclk preparation in with clk_get
Date: Fri, 28 Feb 2025 17:57:54 +0100
Message-ID: <20250228165755.405138-2-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250228165755.405138-1-heiko@sntech.de>
References: <20250228165755.405138-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

The LVDS block needs a separate pclk only on some socs, so currently
requests and prepares it in the soc-specific probe function, but common
code is required to unprepare it in the error path or on driver remove.

While this works because clk_unprepare just does nothing if clk is NULL,
this mismatch of who is responsible still is not very nice.
The clock-framework already has a helper for clk-get-and-prepare even
with devres support in devm_clk_get_prepared().

This will get and prepare the clock and also unprepare it on driver
removal, saving the driver from having to handle it "manually".

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 drivers/gpu/drm/rockchip/rockchip_lvds.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index 385cf6881504..c19b7b1f6cb5 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -448,13 +448,11 @@ struct drm_encoder_helper_funcs px30_lvds_encoder_helper_funcs = {
 static int rk3288_lvds_probe(struct platform_device *pdev,
 			     struct rockchip_lvds *lvds)
 {
-	int ret;
-
 	lvds->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(lvds->regs))
 		return PTR_ERR(lvds->regs);
 
-	lvds->pclk = devm_clk_get(lvds->dev, "pclk_lvds");
+	lvds->pclk = devm_clk_get_prepared(lvds->dev, "pclk_lvds");
 	if (IS_ERR(lvds->pclk)) {
 		DRM_DEV_ERROR(lvds->dev, "could not get pclk_lvds\n");
 		return PTR_ERR(lvds->pclk);
@@ -480,12 +478,6 @@ static int rk3288_lvds_probe(struct platform_device *pdev,
 		}
 	}
 
-	ret = clk_prepare(lvds->pclk);
-	if (ret < 0) {
-		DRM_DEV_ERROR(lvds->dev, "failed to prepare pclk_lvds\n");
-		return ret;
-	}
-
 	return 0;
 }
 
@@ -728,20 +720,15 @@ static int rockchip_lvds_probe(struct platform_device *pdev)
 	dev_set_drvdata(dev, lvds);
 
 	ret = component_add(&pdev->dev, &rockchip_lvds_component_ops);
-	if (ret < 0) {
+	if (ret < 0)
 		DRM_DEV_ERROR(dev, "failed to add component\n");
-		clk_unprepare(lvds->pclk);
-	}
 
 	return ret;
 }
 
 static void rockchip_lvds_remove(struct platform_device *pdev)
 {
-	struct rockchip_lvds *lvds = platform_get_drvdata(pdev);
-
 	component_del(&pdev->dev, &rockchip_lvds_component_ops);
-	clk_unprepare(lvds->pclk);
 }
 
 struct platform_driver rockchip_lvds_driver = {
-- 
2.47.2


