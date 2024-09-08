Return-Path: <linux-kernel+bounces-320196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B99EE970746
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 14:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D32D1F2150C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 12:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BE815E5CF;
	Sun,  8 Sep 2024 12:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QGV9ju/l"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0157E160887
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 12:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725797505; cv=none; b=aQcmU/tI/TU/ANQSLEn9FwMlkxAWpsrSs0dZgNgHwmksGGA5RZRUsKG2J/A3qOHrwOLSGdvKE/I1gvzRupZ0RE3bVPWXvF8qQU4J4FO33Gn4wcotp1TB+oCegjVUNTwXNPljpVU/92yiMWdrx1wCro2NYxWipvyCJz5gEQknfY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725797505; c=relaxed/simple;
	bh=hFrsyhyrmjmy0it0UfFVUJiSXkbV+PyoAF0ve9xM/mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RkzwaLwrzAiuzE1uP5B/HaCmrn7iYiD+MSSH+dUEKZ6dAGinv6pPg3ggQo3snzbytR4Mc3lnRYD1l0Ob/gsPbdslS4yKhMNIjU0gRrEvebZ7lFi7vPgGO3JHWQfijv2y9yvPeUjdotTc2bwSBD+iRRDV42/uiKlLlqCwSXxWdn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QGV9ju/l; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725797502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eZZRYHosjOP12sXZTztLeX53ogVSB/zJnzTtl6YWZvQ=;
	b=QGV9ju/l+8DcXKr1muYF99ggepZEi9YXBOyIp48r5uRC5lYgQ8oQB6B0g3gASnkllNAoEo
	YxnS2IOa13jrycI/lKeCXqfAQIrZQAicnClewDHSBjYUaoT4qs0ufnd6cnl+2Dg2rBGKaF
	lhmEdrmkiMdV/1hMEPk5NA9CdYu04Uw=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>,
	dri-devel@lists.freedesktop.org,
	etnaviv@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>,
	Christian Gmeiner <cgmeiner@igalia.com>
Subject: [PATCH v2 5/5] drm/etnaviv: Replace the '&pdev->dev' with 'dev'
Date: Sun,  8 Sep 2024 20:11:07 +0800
Message-ID: <20240908121107.328740-5-sui.jingfeng@linux.dev>
In-Reply-To: <20240908121107.328740-1-sui.jingfeng@linux.dev>
References: <20240908121107.328740-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In the etnaviv_pdev_probe() and etnaviv_gpu_platform_probe() function, the
value of '&pdev->dev' has been cached to the local auto variable 'dev'.
But some callers use 'dev', while the rest use '&pdev->dev'. To keep it
consistent, use 'dev' uniformly.

Tested-by: Christian Gmeiner <cgmeiner@igalia.com>
Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 10 +++++-----
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 16 ++++++++--------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 7844cd961a29..6591e420a051 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -609,7 +609,7 @@ static int etnaviv_pdev_probe(struct platform_device *pdev)
 			if (!of_device_is_available(core_node))
 				continue;
 
-			drm_of_component_match_add(&pdev->dev, &match,
+			drm_of_component_match_add(dev, &match,
 						   component_compare_of, core_node);
 		}
 	} else {
@@ -632,9 +632,9 @@ static int etnaviv_pdev_probe(struct platform_device *pdev)
 	 * bit to make sure we are allocating the command buffers and
 	 * TLBs in the lower 4 GiB address space.
 	 */
-	if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(40)) ||
-	    dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32))) {
-		dev_dbg(&pdev->dev, "No suitable DMA available\n");
+	if (dma_set_mask(dev, DMA_BIT_MASK(40)) ||
+	    dma_set_coherent_mask(dev, DMA_BIT_MASK(32))) {
+		dev_dbg(dev, "No suitable DMA available\n");
 		return -ENODEV;
 	}
 
@@ -645,7 +645,7 @@ static int etnaviv_pdev_probe(struct platform_device *pdev)
 	 */
 	first_node = etnaviv_of_first_available_node();
 	if (first_node) {
-		of_dma_configure(&pdev->dev, first_node, true);
+		of_dma_configure(dev, first_node, true);
 		of_node_put(first_node);
 	}
 
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 3c869970cba4..d0df5c53a829 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1862,7 +1862,7 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
 	if (!gpu)
 		return -ENOMEM;
 
-	gpu->dev = &pdev->dev;
+	gpu->dev = dev;
 	mutex_init(&gpu->lock);
 	mutex_init(&gpu->sched_lock);
 
@@ -1876,8 +1876,8 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
 	if (gpu->irq < 0)
 		return gpu->irq;
 
-	err = devm_request_irq(&pdev->dev, gpu->irq, irq_handler, 0,
-			       dev_name(gpu->dev), gpu);
+	err = devm_request_irq(dev, gpu->irq, irq_handler, 0,
+			       dev_name(dev), gpu);
 	if (err) {
 		dev_err(dev, "failed to request IRQ%u: %d\n", gpu->irq, err);
 		return err;
@@ -1914,13 +1914,13 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
 	 * autosuspend delay is rather arbitary: no measurements have
 	 * yet been performed to determine an appropriate value.
 	 */
-	pm_runtime_use_autosuspend(gpu->dev);
-	pm_runtime_set_autosuspend_delay(gpu->dev, 200);
-	pm_runtime_enable(gpu->dev);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_set_autosuspend_delay(dev, 200);
+	pm_runtime_enable(dev);
 
-	err = component_add(&pdev->dev, &gpu_ops);
+	err = component_add(dev, &gpu_ops);
 	if (err < 0) {
-		dev_err(&pdev->dev, "failed to register component: %d\n", err);
+		dev_err(dev, "failed to register component: %d\n", err);
 		return err;
 	}
 
-- 
2.43.0


