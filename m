Return-Path: <linux-kernel+bounces-351343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 614B3990FE3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 935F11C232D1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E19B1DF97B;
	Fri,  4 Oct 2024 19:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ftNsIPXu"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041701DFDB0
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 19:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728070961; cv=none; b=WzojCzayVmUTbqVEwAzqtAjVGDolzy5sVDCRLUcV3+ZdYL+z3Jf14OxnnW6hfqEb28e8cHLIZ7oo0vVb3/02809+DsOBjgfH5frn5wSUUXxzEgcDyUWAyR5/xBzQZ2LyEYgql4MQ1N2cLcG1zGmZYHhuLbdEj+p92thWJHEJ8ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728070961; c=relaxed/simple;
	bh=LYsYnXoo3kJoUfPmbMgTjFyMWRRi33MCXZmR5eexX/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fBHIyDyW5KIT8dUGIuD7zPtM8vBmN2jRTzweDjwpJ7Sol/qS9eD7fFFMEDUkHI6ObrqJyW2Jm9oda9kFaWVi/M4cV++SFIqQA2UxVk96APv0hXFUIxuR2lZjzWy9Nv9AwxVehK1+N2fPqCdCzBkbXm5BaOHcMw6uJDUsqdVFT5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ftNsIPXu; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728070956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2EJrsyNwIp588IXKZBIiuIXp7P16IHtnrPh4MNvjTGI=;
	b=ftNsIPXu5yWFK5uGKVBVxFtlhQMVwwI0ePFe+xZi3HbLkOE17uCdKrM1oX6jrWkJ0uZmqW
	aZ97YrwoK0+6sp0lKOurPgC0n50nFt1cHRVbeIQ2qufLOpCNCQj9mX7f50q2BqtVJpPLbb
	id/P7nbCsaZred0PGd95KyMoBWyAFfA=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH 2/3] drm/etnaviv: Map and unmap the GPU VA range with respect to its user size
Date: Sat,  5 Oct 2024 03:42:06 +0800
Message-Id: <20241004194207.1013744-3-sui.jingfeng@linux.dev>
In-Reply-To: <20241004194207.1013744-1-sui.jingfeng@linux.dev>
References: <20241004194207.1013744-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Since the GPU VA space is compact in terms of 4KiB unit, map and/or unmap
the area that doesn't belong to a context breaks the philosophy of PPAS.
That results in severe errors: GPU hang and MMU fault (page not present)
and such.

Shrink the usuable size of etnaviv GEM buffer object to its user size,
instead of the original physical size of its backing memory.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/etnaviv/etnaviv_mmu.c | 28 +++++++++------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
index 6fbc62772d85..a52ec5eb0e3d 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
@@ -70,8 +70,10 @@ static int etnaviv_context_map(struct etnaviv_iommu_context *context,
 }
 
 static int etnaviv_iommu_map(struct etnaviv_iommu_context *context, u32 iova,
+			     unsigned int user_len,
 			     struct sg_table *sgt, int prot)
-{	struct scatterlist *sg;
+{
+	struct scatterlist *sg;
 	unsigned int da = iova;
 	unsigned int i;
 	int ret;
@@ -81,7 +83,8 @@ static int etnaviv_iommu_map(struct etnaviv_iommu_context *context, u32 iova,
 
 	for_each_sgtable_dma_sg(sgt, sg, i) {
 		phys_addr_t pa = sg_dma_address(sg) - sg->offset;
-		size_t bytes = sg_dma_len(sg) + sg->offset;
+		unsigned int phys_len = sg_dma_len(sg) + sg->offset;
+		size_t bytes = MIN(phys_len, user_len);
 
 		VERB("map[%d]: %08x %pap(%zx)", i, iova, &pa, bytes);
 
@@ -89,6 +92,7 @@ static int etnaviv_iommu_map(struct etnaviv_iommu_context *context, u32 iova,
 		if (ret)
 			goto fail;
 
+		user_len -= bytes;
 		da += bytes;
 	}
 
@@ -104,21 +108,7 @@ static int etnaviv_iommu_map(struct etnaviv_iommu_context *context, u32 iova,
 static void etnaviv_iommu_unmap(struct etnaviv_iommu_context *context, u32 iova,
 				struct sg_table *sgt, unsigned len)
 {
-	struct scatterlist *sg;
-	unsigned int da = iova;
-	int i;
-
-	for_each_sgtable_dma_sg(sgt, sg, i) {
-		size_t bytes = sg_dma_len(sg) + sg->offset;
-
-		etnaviv_context_unmap(context, da, bytes);
-
-		VERB("unmap[%d]: %08x(%zx)", i, iova, bytes);
-
-		BUG_ON(!PAGE_ALIGNED(bytes));
-
-		da += bytes;
-	}
+	etnaviv_context_unmap(context, iova, len);
 
 	context->flush_seq++;
 }
@@ -131,7 +121,7 @@ static void etnaviv_iommu_remove_mapping(struct etnaviv_iommu_context *context,
 	lockdep_assert_held(&context->lock);
 
 	etnaviv_iommu_unmap(context, mapping->vram_node.start,
-			    etnaviv_obj->sgt, etnaviv_obj->base.size);
+			    etnaviv_obj->sgt, etnaviv_obj->user_size);
 	drm_mm_remove_node(&mapping->vram_node);
 }
 
@@ -314,7 +304,7 @@ int etnaviv_iommu_map_gem(struct etnaviv_iommu_context *context,
 		goto unlock;
 
 	mapping->iova = node->start;
-	ret = etnaviv_iommu_map(context, node->start, sgt,
+	ret = etnaviv_iommu_map(context, node->start, user_size, sgt,
 				ETNAVIV_PROT_READ | ETNAVIV_PROT_WRITE);
 
 	if (ret < 0) {
-- 
2.34.1


