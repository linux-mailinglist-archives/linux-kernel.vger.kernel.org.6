Return-Path: <linux-kernel+bounces-382605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF56C9B10F7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 22:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E8821F21D37
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D084521E62C;
	Fri, 25 Oct 2024 20:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QoeNWVEt"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9B921E609
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 20:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729889071; cv=none; b=PAWnOsW+Mp3YF4L37caKMe2rxuJ96ILGaEvo68FnviXtlJOZvUyZhtJpnywDdh1hgh6hjjQSLV+dTp2SNLHXAYJCYV6o/25wXZJQsI7VAiZIyLuIgpDopqWEGpf2s3AEPDX0EA/SMqNFK2bLMHE/qrHxJkpusfGeGg1PqOqSIlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729889071; c=relaxed/simple;
	bh=k4f66iZ2fv4fhq1QRX1Ek1uZ0lHnBYAvCswuVJMJc5o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ttyVlVMjwXxUlN4Mi7bdfg9ilApxHg9c1fXI4cZDYbzyOt/D/y3HaqPCriiUamMqlST6UN0gcIwcCjaBDR7OP7SJRExE3LNRHiL3DY2d699+jN/aJ/yJ2wpTSVCJ6FFj9OY4f3FgS3btE1FwTe7cBBBiO+dEw7IteOAX37KLYbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QoeNWVEt; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729889065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+962+r2Cmig/FghXZjEwbQhCwYeyPYtwliaBbnwkoQA=;
	b=QoeNWVEt8LiByi9WMf3TXS8kEmo3fnlbfDJ4UlLhi1KXnCSB8EIN96t4ucyc3iPDbEYA9k
	sjqsMKNMZhlFevVDZ190+PuEStPiQKfCw7/5q3uaLJy7NYx/jiCkDLTIPlqsX2DN8G2bJt
	BsL8BzOiwVCePd+bKrdYK+Hcq7xymFY=
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
Subject: [PATCH v2 2/2] drm/etnaviv: Map and unmap GPUVA range with respect to the GPUVA size
Date: Sat, 26 Oct 2024 04:43:55 +0800
Message-Id: <20241025204355.595805-3-sui.jingfeng@linux.dev>
In-Reply-To: <20241025204355.595805-1-sui.jingfeng@linux.dev>
References: <20241025204355.595805-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Etnaviv assumes that GPU page size is 4KiB, however, GPUVA ranges collision
when using softpin capable GPUs on a non 4KiB CPU page size configuration.
The root cause is that kernel side BO takes up bigger address space than
userspace expect, the size of backing memory of GEM buffer objects are
required to align to the CPU PAGE_SIZE. Therefore, results in userspace
allocated GPUVA range fails to be inserted to the specified hole exactly.

To solve this problem, record the GPU visiable size of a BO firstly, then
map and unmap the SG entry strictly with respect to the total GPUVA size.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/etnaviv/etnaviv_mmu.c | 36 +++++++++------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
index 1661d589bf3e..a2cd64bd2dc0 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
@@ -70,8 +70,10 @@ static int etnaviv_context_map(struct etnaviv_iommu_context *context,
 }
 
 static int etnaviv_iommu_map(struct etnaviv_iommu_context *context, u32 iova,
+			     unsigned int va_len,
 			     struct sg_table *sgt, int prot)
-{	struct scatterlist *sg;
+{
+	struct scatterlist *sg;
 	unsigned int da = iova;
 	unsigned int i;
 	int ret;
@@ -81,14 +83,16 @@ static int etnaviv_iommu_map(struct etnaviv_iommu_context *context, u32 iova,
 
 	for_each_sgtable_dma_sg(sgt, sg, i) {
 		phys_addr_t pa = sg_dma_address(sg) - sg->offset;
-		size_t bytes = sg_dma_len(sg) + sg->offset;
+		unsigned int da_len = sg_dma_len(sg) + sg->offset;
+		unsigned int bytes = min_t(unsigned int, da_len, va_len);
 
-		VERB("map[%d]: %08x %pap(%zx)", i, iova, &pa, bytes);
+		VERB("map[%d]: %08x %pap(%x)", i, iova, &pa, bytes);
 
 		ret = etnaviv_context_map(context, da, pa, bytes, prot);
 		if (ret)
 			goto fail;
 
+		va_len -= bytes;
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
+			    etnaviv_obj->sgt, etnaviv_obj->size);
 	drm_mm_remove_node(&mapping->vram_node);
 }
 
@@ -305,16 +295,14 @@ int etnaviv_iommu_map_gem(struct etnaviv_iommu_context *context,
 	node = &mapping->vram_node;
 
 	if (va)
-		ret = etnaviv_iommu_insert_exact(context, node,
-						 etnaviv_obj->base.size, va);
+		ret = etnaviv_iommu_insert_exact(context, node, etnaviv_obj->size, va);
 	else
-		ret = etnaviv_iommu_find_iova(context, node,
-					      etnaviv_obj->base.size);
+		ret = etnaviv_iommu_find_iova(context, node, etnaviv_obj->size);
 	if (ret < 0)
 		goto unlock;
 
 	mapping->iova = node->start;
-	ret = etnaviv_iommu_map(context, node->start, sgt,
+	ret = etnaviv_iommu_map(context, node->start, etnaviv_obj->size, sgt,
 				ETNAVIV_PROT_READ | ETNAVIV_PROT_WRITE);
 
 	if (ret < 0) {
-- 
2.34.1


