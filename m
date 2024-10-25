Return-Path: <linux-kernel+bounces-381194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 991C99AFBD1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 583702846F3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B791C4A13;
	Fri, 25 Oct 2024 08:01:07 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AAA199948;
	Fri, 25 Oct 2024 08:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729843267; cv=none; b=lAjcDeXM3R0U/+HL25htZSmKJiJXytZoJvVe84nv+GxizNF9jyNJOH+u7bW8Sv4XNFWUPnMlD4nG8m2TSJ8hqGKlZ9L/v/B0I62Ghu+lVZyjxw0PX55grKETC9nwvj/oPWzNM8s4QHt0TksegHgLxMsdsPJwH0yhqh7dJPWaDXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729843267; c=relaxed/simple;
	bh=j9gjkf9XV2nZESi5Z9A8rCJ0qwQQx0jK647qqJLB7t8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aj3MogMIBFvcei0TzikQTGgS0Yvg5zqCyknE1X6dbh4tDHCMq5/IvKuexT81R5NoLyj/vYeWNXJXBr0Yretm4ERhlVMVm1GkE8IIZMjZk7aoouAPyPm/rT91bXfeivjW6ooqd8hRP87o8sUlGKQSAeYB+eYfmH4jxKjvvh+Z3co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee8671b5034e6b-b5eab;
	Fri, 25 Oct 2024 16:00:52 +0800 (CST)
X-RM-TRANSID:2ee8671b5034e6b-b5eab
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from leadsec.example.com.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee5671b50267c1-2dbc8;
	Fri, 25 Oct 2024 16:00:51 +0800 (CST)
X-RM-TRANSID:2ee5671b50267c1-2dbc8
From: Tang Bin <tangbin@cmss.chinamobile.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] ASoC: mediatek: mt8192-afe-pcm: Simplify probe() with local dev variable
Date: Fri, 25 Oct 2024 16:00:26 +0800
Message-Id: <20241025080026.2393-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify the function mt8192_afe_pcm_dev_probe() by
using local 'dev' instead of '&pdev->dev'.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
index 9b502f4cd..80cda7bf5 100644
--- a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
+++ b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
@@ -2158,27 +2158,26 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 {
 	struct mtk_base_afe *afe;
 	struct mt8192_afe_private *afe_priv;
-	struct device *dev;
+	struct device *dev = &pdev->dev;
 	struct reset_control *rstc;
 	int i, ret, irq_id;
 
-	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(34));
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(34));
 	if (ret)
 		return ret;
 
-	afe = devm_kzalloc(&pdev->dev, sizeof(*afe), GFP_KERNEL);
+	afe = devm_kzalloc(dev, sizeof(*afe), GFP_KERNEL);
 	if (!afe)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, afe);
 
-	afe->platform_priv = devm_kzalloc(&pdev->dev, sizeof(*afe_priv),
+	afe->platform_priv = devm_kzalloc(dev, sizeof(*afe_priv),
 					  GFP_KERNEL);
 	if (!afe->platform_priv)
 		return -ENOMEM;
 	afe_priv = afe->platform_priv;
 
-	afe->dev = &pdev->dev;
-	dev = afe->dev;
+	afe->dev = dev;
 
 	/* init audio related clock */
 	ret = mt8192_init_clock(afe);
@@ -2196,7 +2195,7 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to trigger audio reset\n");
 
-	ret = devm_pm_runtime_enable(&pdev->dev);
+	ret = devm_pm_runtime_enable(dev);
 	if (ret)
 		return ret;
 
@@ -2212,13 +2211,13 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	/* enable clock for regcache get default value from hw */
 	afe_priv->pm_runtime_bypass_reg_ctl = true;
-	pm_runtime_get_sync(&pdev->dev);
+	pm_runtime_get_sync(dev);
 
 	ret = regmap_reinit_cache(afe->regmap, &mt8192_afe_regmap_config);
 	if (ret)
 		return dev_err_probe(dev, ret, "regmap_reinit_cache fail\n");
 
-	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_put_sync(dev);
 	afe_priv->pm_runtime_bypass_reg_ctl = false;
 
 	regcache_cache_only(afe->regmap, true);
@@ -2285,7 +2284,7 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 	afe->runtime_suspend = mt8192_afe_runtime_suspend;
 
 	/* register platform */
-	ret = devm_snd_soc_register_component(&pdev->dev,
+	ret = devm_snd_soc_register_component(dev,
 					      &mtk_afe_pcm_platform,
 					      afe->dai_drivers,
 					      afe->num_dai_drivers);
-- 
2.33.0




