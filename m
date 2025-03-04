Return-Path: <linux-kernel+bounces-544169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C672EA4DE33
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B68F8188A843
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40077203707;
	Tue,  4 Mar 2025 12:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="bu7qt+Ve"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A92E8472
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 12:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741092289; cv=none; b=k7+ZG2hYlrdWRpiDpmynsE9DxSjjpkK/w0GaS4KYNgk32Xmoy8FWp32hOKYcvuPC2zW17qNrt2GsibVSemAQ2AP2uwko3DNNc2dhEVs+/ndiAvq7JjtIOPNw3UCDfULuK4t9y3AwTp0Pq3C+kLSjjozgs1RsXLxbqloAtdXAofw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741092289; c=relaxed/simple;
	bh=v5RyqKV/vQ6GDOpVRR6JFOcH0iHM1vJuvY3WW0d4Nic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EiGNG0g4qhhmhH7JAYxjby30tbgyvtPbh3Vf1ZZhVUOqKjJDFbo38+BX7jprxwozf7qBR8rAW3ZrKZ5Eu+X1Vs5LL3AoTfUtHPyuHTNaWoRBhM/FCiz4U/TVpprjASXKefX5LeNc+csq7caQXoiV+3O5IGMDUiGgapJsCbVbpVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=bu7qt+Ve; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SOimxFjP0O74i2+ZLCuEU3KuzT1QQlg4XvqoNtXpw3o=; b=bu7qt+Ve6i7GD+d3Lp7PEEAHQa
	UmvRgCzyBPyZ0GJSgtpye0Z6fUXBQ0x+DMAWX11tAZ4BdcS1zAsHPOjsvzg02Qcuev2iz/EkG+qSI
	sYgP8FFqYnHFZpE3UIOetrOES9qnzjC6aej7whTkqjU82KBcQ4iJW1bBi9a9zreaObl4ZHk8c9aJ5
	2K5OeF4Vh246BNkMeAdRzNQYpRdiHZdndVccZe/x1RzDqnz92jMIwYtWWc2ClORlFglLS7llCdiE3
	WJbTbj3y5FRWT0rgwMlsLqWtdbmMb3DZE+ZY62FOeAZ1vKmwtrScw9Dk88gjbZ9mADlAhi9U7iC6r
	YNaQUtgg==;
Received: from i53875a38.versanet.de ([83.135.90.56] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tpRdR-0003B0-MS; Tue, 04 Mar 2025 13:44:33 +0100
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
Subject: [PATCH v3 1/3] drm/rockchip: lvds: move pclk preparation in with clk_get
Date: Tue,  4 Mar 2025 13:44:16 +0100
Message-ID: <20250304124418.111061-2-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250304124418.111061-1-heiko@sntech.de>
References: <20250304124418.111061-1-heiko@sntech.de>
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

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Andy Yan <andy.yan@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 drivers/gpu/drm/rockchip/rockchip_lvds.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index 385cf6881504..ecfae8d5da89 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -448,15 +448,13 @@ struct drm_encoder_helper_funcs px30_lvds_encoder_helper_funcs = {
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
-		DRM_DEV_ERROR(lvds->dev, "could not get pclk_lvds\n");
+		DRM_DEV_ERROR(lvds->dev, "could not get or prepare pclk_lvds\n");
 		return PTR_ERR(lvds->pclk);
 	}
 
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


