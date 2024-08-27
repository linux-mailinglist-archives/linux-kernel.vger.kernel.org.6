Return-Path: <linux-kernel+bounces-302493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CBC95FF69
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 04:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34B0928311D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 02:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6871805E;
	Tue, 27 Aug 2024 02:56:11 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB2B17D2
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 02:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724727371; cv=none; b=WN3+nPW3evSEDeHopazuZ588p8PbVvceIINIA+R4SslJ9ctatpS9p4mWQ5n4RWyWTL8FfWhjcObboLvEBELiQ5L+np6UdKTVRAA3S1XFsuYvvbGqQul3SLTezpIg+ICcQbAwSJ0h3RkiIAC8jW7cFhmACG9xvldxE/7agCaJLLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724727371; c=relaxed/simple;
	bh=naYWxl0nekINbUOUbxT9Nk9f/5B9gkbVPd3U7d8h6b4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NYyqqFQczJe5f12UMVFpWCHWtUvh/JFKjgbR66arNV1mY24JGG4lCcD0Y5Z8AufNCCgYbNulwR4Kw18F1TMImZ5OhjNVYp8MGhtveRQHNjx9iiU8CD1A5v5On+5KWe3tqdWeTgu+an0mR41EPWkXrGjcMktnfWfA+8gCynMy2Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WtBxP3NmTzyRDP;
	Tue, 27 Aug 2024 10:55:37 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 52FEA18007C;
	Tue, 27 Aug 2024 10:56:06 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 27 Aug
 2024 10:56:05 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <hjc@rock-chips.com>, <heiko@sntech.de>, <andy.yan@rock-chips.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<krzk@kernel.org>, <jic23@kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next v2 3/3] drm/rockchip: Simplified with dev_err_probe()
Date: Tue, 27 Aug 2024 11:03:57 +0800
Message-ID: <20240827030357.1006220-4-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827030357.1006220-1-ruanjinjie@huawei.com>
References: <20240827030357.1006220-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Use dev_err_probe to replace deprecated() DRM_DEV_ERROR(), which
can simplfy code.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/gpu/drm/rockchip/rockchip_lvds.c | 30 +++++++++---------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index 700ac730887d..92679e54c71d 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -455,10 +455,8 @@ static int rk3288_lvds_probe(struct platform_device *pdev,
 		return PTR_ERR(lvds->regs);
 
 	lvds->pclk = devm_clk_get(lvds->dev, "pclk_lvds");
-	if (IS_ERR(lvds->pclk)) {
-		DRM_DEV_ERROR(lvds->dev, "could not get pclk_lvds\n");
-		return PTR_ERR(lvds->pclk);
-	}
+	if (IS_ERR(lvds->pclk))
+		return dev_err_probe(lvds->dev, PTR_ERR(lvds->pclk), "could not get pclk_lvds\n");
 
 	lvds->pins = devm_kzalloc(lvds->dev, sizeof(*lvds->pins),
 				  GFP_KERNEL);
@@ -467,24 +465,22 @@ static int rk3288_lvds_probe(struct platform_device *pdev,
 
 	lvds->pins->p = devm_pinctrl_get(lvds->dev);
 	if (IS_ERR(lvds->pins->p)) {
-		DRM_DEV_ERROR(lvds->dev, "no pinctrl handle\n");
+		dev_err(lvds->dev, "no pinctrl handle\n");
 		devm_kfree(lvds->dev, lvds->pins);
 		lvds->pins = NULL;
 	} else {
 		lvds->pins->default_state =
 			pinctrl_lookup_state(lvds->pins->p, "lcdc");
 		if (IS_ERR(lvds->pins->default_state)) {
-			DRM_DEV_ERROR(lvds->dev, "no default pinctrl state\n");
+			dev_err(lvds->dev, "no default pinctrl state\n");
 			devm_kfree(lvds->dev, lvds->pins);
 			lvds->pins = NULL;
 		}
 	}
 
 	ret = clk_prepare(lvds->pclk);
-	if (ret < 0) {
-		DRM_DEV_ERROR(lvds->dev, "failed to prepare pclk_lvds\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(lvds->dev, ret, "failed to prepare pclk_lvds\n");
 
 	return 0;
 }
@@ -700,22 +696,18 @@ static int rockchip_lvds_probe(struct platform_device *pdev)
 
 	lvds->grf = syscon_regmap_lookup_by_phandle(dev->of_node,
 						    "rockchip,grf");
-	if (IS_ERR(lvds->grf)) {
-		DRM_DEV_ERROR(dev, "missing rockchip,grf property\n");
-		return PTR_ERR(lvds->grf);
-	}
+	if (IS_ERR(lvds->grf))
+		return dev_err_probe(dev, PTR_ERR(lvds->grf), "missing rockchip,grf property\n");
 
 	ret = lvds->soc_data->probe(pdev, lvds);
-	if (ret) {
-		DRM_DEV_ERROR(dev, "Platform initialization failed\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Platform initialization failed\n");
 
 	dev_set_drvdata(dev, lvds);
 
 	ret = component_add(&pdev->dev, &rockchip_lvds_component_ops);
 	if (ret < 0) {
-		DRM_DEV_ERROR(dev, "failed to add component\n");
+		dev_err(dev, "failed to add component\n");
 		clk_unprepare(lvds->pclk);
 	}
 
-- 
2.34.1


