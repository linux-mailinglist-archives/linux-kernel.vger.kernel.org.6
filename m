Return-Path: <linux-kernel+bounces-320195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51557970745
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 14:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFBFEB2145B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 12:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656BD15D5DE;
	Sun,  8 Sep 2024 12:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xfcRh4PX"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD561607BB
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 12:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725797500; cv=none; b=LjVWRUoBu/E98lgvh455OWVSAFpZ1Ert2wTRPY2qN+USDfSpuZdgGm0PE7f1RQM4UoFqvxJBPSc+5ac4Jjzb2yttJlgrXvKQmNMGIDkvk6KRNDGdxt2yIdLXATu7+wN/Uet+qKF8F7wPkztF5G7s9sBqn42lFzcgU445sq6bI/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725797500; c=relaxed/simple;
	bh=E0i+A0cmnNVB+sxWG2i9Y3utjQkTjzHv6OcrJy4z6GU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AxNnyjQa3wDFNRnZplIChm6HivcgrJWf2OoHkzBPHCdgAc8FtaFfteCbnVjz6lN2bkbhX95hsOAe/Qa+kLREII0+7uihkp7YWAMlUIZh9q6qpVWq5beBalM+tr4IRqwHtUxmjrCdaduXB+KamJYRqh6XW4VJ6HdNpMolJMowsDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xfcRh4PX; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725797497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zp0+gJ8zC1+4EYinnSYnf2yVlAatGRkLD73KizOpAxQ=;
	b=xfcRh4PXGDmceJejZcEs7Ib47DGRqGTT4t4Ajb1hGGUQpRNyB/xfjSS4ZfaVSOT8j4vtvC
	pRYvBgAG3/JnOxqT2R2zFMwlrECbvo7x2QdO/c9q9gmWQL3WN0Hctw0Tjwk7GOr8QakUQC
	siPWWONvvPzl4zJXWXqbzAo8qgCoPFE=
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
Subject: [PATCH v2 4/5] drm/etnaviv: Fix missing mutex_destroy()
Date: Sun,  8 Sep 2024 20:11:06 +0800
Message-ID: <20240908121107.328740-4-sui.jingfeng@linux.dev>
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

Currently, the calling of mutex_destroy() is ignored on error handling
code path. It is safe for now, since mutex_destroy() actually does
nothing in non-debug builds. But the mutex_destroy() is used to mark
the mutex uninitialized on debug builds, and any subsequent use of the
mutex is forbidden.

It also could lead to problems if mutex_destroy() gets extended, add
missing mutex_destroy() to eliminate potential concerns.

Reviewed-by: Christian Gmeiner <cgmeiner@igalia.com>
Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---

 v2: Pick up tags and fix one more missing mutex_destroy() 

 drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c | 2 ++
 drivers/gpu/drm/etnaviv/etnaviv_drv.c    | 1 +
 drivers/gpu/drm/etnaviv/etnaviv_gem.c    | 1 +
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c    | 5 +++++
 drivers/gpu/drm/etnaviv/etnaviv_mmu.c    | 2 +-
 5 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c b/drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c
index 721d633aece9..66a407f1b3ee 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c
@@ -55,6 +55,7 @@ etnaviv_cmdbuf_suballoc_new(struct device *dev)
 	return suballoc;
 
 free_suballoc:
+	mutex_destroy(&suballoc->lock);
 	kfree(suballoc);
 
 	return ERR_PTR(ret);
@@ -79,6 +80,7 @@ void etnaviv_cmdbuf_suballoc_destroy(struct etnaviv_cmdbuf_suballoc *suballoc)
 {
 	dma_free_wc(suballoc->dev, SUBALLOC_SIZE, suballoc->vaddr,
 		    suballoc->paddr);
+	mutex_destroy(&suballoc->lock);
 	kfree(suballoc);
 }
 
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 6500f3999c5f..7844cd961a29 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -564,6 +564,7 @@ static int etnaviv_bind(struct device *dev)
 out_destroy_suballoc:
 	etnaviv_cmdbuf_suballoc_destroy(priv->cmdbuf_suballoc);
 out_free_priv:
+	mutex_destroy(&priv->gem_lock);
 	kfree(priv);
 out_put:
 	drm_dev_put(drm);
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index 4ce3d2ea7767..4247a10f8d4f 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -514,6 +514,7 @@ void etnaviv_gem_free_object(struct drm_gem_object *obj)
 	etnaviv_obj->ops->release(etnaviv_obj);
 	drm_gem_object_release(obj);
 
+	mutex_destroy(&etnaviv_obj->lock);
 	kfree(etnaviv_obj);
 }
 
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 7c7f97793ddd..3c869970cba4 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1929,8 +1929,13 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
 
 static void etnaviv_gpu_platform_remove(struct platform_device *pdev)
 {
+	struct etnaviv_gpu *gpu = dev_get_drvdata(&pdev->dev);
+
 	component_del(&pdev->dev, &gpu_ops);
 	pm_runtime_disable(&pdev->dev);
+
+	mutex_destroy(&gpu->lock);
+	mutex_destroy(&gpu->sched_lock);
 }
 
 static int etnaviv_gpu_rpm_suspend(struct device *dev)
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
index 1661d589bf3e..02d9408d41bc 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
@@ -358,7 +358,7 @@ static void etnaviv_iommu_context_free(struct kref *kref)
 		container_of(kref, struct etnaviv_iommu_context, refcount);
 
 	etnaviv_cmdbuf_suballoc_unmap(context, &context->cmdbuf_mapping);
-
+	mutex_destroy(&context->lock);
 	context->global->ops->free(context);
 }
 void etnaviv_iommu_context_put(struct etnaviv_iommu_context *context)
-- 
2.43.0


