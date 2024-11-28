Return-Path: <linux-kernel+bounces-425082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0B59DBD41
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 22:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5FF9B21C18
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 21:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DA11C9DD7;
	Thu, 28 Nov 2024 21:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Z2ejdybj"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E511C760A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 21:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732828391; cv=pass; b=p75zHcW43T7EmEzqYyPm7Ht4PhklgpWFFvI0IXY5GonexKmWXD296ko7CJql5oTJMiy7ngEdDxfJtbp6dSar7GxJBgUgYCD4Wrep5j0fR8uWFt+dXtbrZvGWDgW5dRMLLDoXC1RQrUIwJZNJ4EQK5ru5W5N96DSGhCLTl64OWGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732828391; c=relaxed/simple;
	bh=3ipTqGiruk2z0sEQ2XCkWrB++61h9aNP6aic2wX2y3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OsF1yqi0gF3f/k9k73P+DaFKNkXRDMauYfNCTuB/oAND3XhVerMc9mdlEJnp3vuC9PUWI+Xv8h/fkN835f7PsZO3ReU1nrMZQUuY8v1YB2Qf8awqwVZ5Sy2FL3Tj8BGDFQS8wiW3PmUXwFtyBBuZ2gL0fDhG1hoBGJsGKaLVOO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=Z2ejdybj; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1732828368; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=V2IRM7qky4mW+J0o6xJptzbQxmAfoDMvzCP7rqcy8whGin4IxwU2PZRVk0bUHYC64gQwJ4zDKUYc0mL/rnSoh4/foLwdMcanRgPJJYWobkrbqApF6Ujwnvhj+L9vRWy60Zf68AcIzWpp+9vN9So3N42WDX10LNvaK1LcHaWRDfQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732828368; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=puqGqEGvhCHRg7oLThh1hFUv/PwfEleC2DPSwEtBjEc=; 
	b=Jg9F0p19IPQw4gBid7CQisbvyn66FCYZUYgn+T6Qoc1j4kwrZ8sOr82nqViA5OJ6bS/sWKhI5caMBFKKGySBoyZbQa8tXRGAopDmlI3xD37XWKKfy+1S81R49XHDljJ2vzvipjBtAK+f5tomolu4Jm3vLAvxoPRlSyrwy6aJTbw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732828368;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=puqGqEGvhCHRg7oLThh1hFUv/PwfEleC2DPSwEtBjEc=;
	b=Z2ejdybj6JqoisZD1tegC3DpRkeSsh+71o4PBI01MXxos5cxWDxzxE3Rsupx+mjM
	svPqrALhibxsH5ogO4v1ZfSSJ42ZYgLGtkLcSZMZ6CUneV2qHEP58N1Nrnr6lnQgYGn
	rDn4VpCX0dHCmvkN6uG1JIhqAYnH9i3wCDLpXay0=
Received: by mx.zohomail.com with SMTPS id 173282836848383.19268185540102;
	Thu, 28 Nov 2024 13:12:48 -0800 (PST)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/8] drm/panfrost: Handle page mapping failure
Date: Thu, 28 Nov 2024 21:06:20 +0000
Message-ID: <20241128211223.1805830-6-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241128211223.1805830-1-adrian.larumbe@collabora.com>
References: <20241128211223.1805830-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When mapping the pages of a BO, either a heap type at page fault time or
else a non-heap BO at object creation time, if the ARM page table mapping
function fails, we unmap what had been mapped so far and bail out.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 44 ++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index 03ac527b35e7..5e30888bea0e 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -290,13 +290,31 @@ static void panfrost_mmu_flush_range(struct panfrost_device *pfdev,
 	pm_runtime_put_autosuspend(pfdev->base.dev);
 }
 
+static void mmu_unmap_range(size_t len, u64 iova, struct io_pgtable_ops *ops)
+{
+	size_t pgsize, unmapped_len = 0;
+	size_t unmapped_page, pgcount;
+
+	while (unmapped_len < len) {
+		pgsize = get_pgsize(iova, len - unmapped_len, &pgcount);
+
+		unmapped_page = ops->unmap_pages(ops, iova, pgsize, pgcount, NULL);
+		WARN_ON(unmapped_page != pgsize * pgcount);
+
+		iova += pgsize * pgcount;
+		unmapped_len += pgsize * pgcount;
+	}
+}
+
 static int mmu_map_sg(struct panfrost_device *pfdev, struct panfrost_mmu *mmu,
 		      u64 iova, int prot, struct sg_table *sgt)
 {
 	unsigned int count;
 	struct scatterlist *sgl;
 	struct io_pgtable_ops *ops = mmu->pgtbl_ops;
+	size_t total_mapped = 0;
 	u64 start_iova = iova;
+	int ret = 0;
 
 	for_each_sgtable_dma_sg(sgt, sgl, count) {
 		unsigned long paddr = sg_dma_address(sgl);
@@ -310,10 +328,15 @@ static int mmu_map_sg(struct panfrost_device *pfdev, struct panfrost_mmu *mmu,
 			size_t pgcount, mapped = 0;
 			size_t pgsize = get_pgsize(iova | paddr, len, &pgcount);
 
-			ops->map_pages(ops, iova, paddr, pgsize, pgcount, prot,
+			ret = ops->map_pages(ops, iova, paddr, pgsize, pgcount, prot,
 				       GFP_KERNEL, &mapped);
+			if (ret) {
+				mmu_unmap_range(total_mapped, start_iova, ops);
+				return ret;
+			}
 			/* Don't get stuck if things have gone wrong */
 			mapped = max(mapped, pgsize);
+			total_mapped += mapped;
 			iova += mapped;
 			paddr += mapped;
 			len -= mapped;
@@ -333,6 +356,7 @@ int panfrost_mmu_map(struct panfrost_gem_mapping *mapping)
 	struct panfrost_device *pfdev = to_panfrost_device(obj->dev);
 	struct sg_table *sgt;
 	int prot = IOMMU_READ | IOMMU_WRITE;
+	int ret;
 
 	if (WARN_ON(mapping->active))
 		return 0;
@@ -344,8 +368,13 @@ int panfrost_mmu_map(struct panfrost_gem_mapping *mapping)
 	if (WARN_ON(IS_ERR(sgt)))
 		return PTR_ERR(sgt);
 
-	mmu_map_sg(pfdev, mapping->mmu, mapping->mmnode.start << PAGE_SHIFT,
-		   prot, sgt);
+	ret = mmu_map_sg(pfdev, mapping->mmu, mapping->mmnode.start << PAGE_SHIFT,
+			 prot, sgt);
+	if (ret) {
+		drm_gem_shmem_put_pages(shmem);
+		return ret;
+	}
+
 	mapping->active = true;
 
 	return 0;
@@ -532,8 +561,10 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
 	if (ret)
 		goto err_map;
 
-	mmu_map_sg(pfdev, bomapping->mmu, addr,
-		   IOMMU_WRITE | IOMMU_READ | IOMMU_NOEXEC, sgt);
+	ret = mmu_map_sg(pfdev, bomapping->mmu, addr,
+			 IOMMU_WRITE | IOMMU_READ | IOMMU_NOEXEC, sgt);
+	if (ret)
+		goto err_mmu_map_sg;
 
 	bomapping->active = true;
 	bo->heap_rss_size += SZ_2M;
@@ -547,6 +578,9 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
 
 	return 0;
 
+err_mmu_map_sg:
+	dma_unmap_sgtable(pfdev->base.dev, sgt,
+			  DMA_BIDIRECTIONAL, 0);
 err_map:
 	sg_free_table(sgt);
 err_unlock:
-- 
2.47.0


