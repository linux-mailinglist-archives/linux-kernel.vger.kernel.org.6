Return-Path: <linux-kernel+bounces-244823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7575D92A9EE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 21:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F5192847FB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 19:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8334A1F956;
	Mon,  8 Jul 2024 19:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Im+HCHeM"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B928110953
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 19:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720467674; cv=none; b=dR0fFq+niimIgWj9sjBmlEkdtA14F2lixj0Ak7bCjvxhYgKpKcfh+3yNl7EV7xTPZvnizNYDH2c9ra4j3elrCQYYBtnZXzwjSSzPGN9dyQuKmf++1HU+PQE2wyyyQRRw0yDTgSiC5WKVgvGQZfKblTMzBIMYEYrS5eVf37mYk5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720467674; c=relaxed/simple;
	bh=uzPDa0Np8qC+TLTSUkk8dR6tfeK/qdyJTrKTfMAJ42c=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WMVOheH0AVICYMZpD3eH0Y3pERfsa8DCGSvz3kudjzQn11ixz5AbDh+oC4nLNZtk/WNCbUFZ9WgHc8A1/xAhA7Dy2PJ2XVvuj7m4iYq43qFdPS9VpajRyWkdT9FCudh8WDC4hP/A2XCuYYd9PlCTThtjDfeaw1He4qMVbE15gVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Im+HCHeM; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70afe18837cso2528978b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 12:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720467672; x=1721072472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zegj0vHwvFcBDG9p0jNscCdiRakO7M/ZJVoOLI21Ek8=;
        b=Im+HCHeMcm64g5H8WKFfm/snRZocDrHV2CGUN6l+2x7/lUKOE/Cz3IJSdLZmTTR8nW
         aJ5j3qxk6V+kVlZ5zoO0lL7Q7Z4QFeIn0EW6p5FjFNkCcOA0Bozh/VbvktYpLT3XDG3s
         ff9oz1Y8ZiPJj0vHWDlBGFm4gLis571K91BkouPDS0pZSi0+Ccv1kKX2A+AA9T4MiwRY
         AsUUYzCa8T2jsZsadVUomEOYGp1Prhx0eYXxcCYX8nqFv/MTDCOgY4TolW5iPpiP4NtD
         nSpySFuBFtNXz2zWYU5innR/kQm49VcV9p5s/MbAXwyXVB3zroJUC+WiBQxDmNbRUsS1
         AoGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720467672; x=1721072472;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zegj0vHwvFcBDG9p0jNscCdiRakO7M/ZJVoOLI21Ek8=;
        b=edb5TFsoj+fcuthYckcluzY+I1D90jYV7lgMscKC9fKNzOWjcYW12EiGtXZRqoOaO9
         WaeSXHvo24Ex1wi1HcSC1rqrlYKKSwUdtafDRuEPMLl6eCdQojFH8B1crK8thVapipTo
         lSfO5fjAsxIQjyA1F6JiRY3gG0UqEL6KKkOl6LbIWOlogDv0yUdYEr79v+STM06mtgU+
         gsi9xX5W++KLhODt41G2ta3EAZ8sbR7J/5Ry06ielSrP8GCe9s4+FkWwooIRnAlOGMZR
         PvDDBdY8itrvMA3e/gZEXZ8zSQu878m0l4qfGQ4DzL2+yTLiOTb8K5DEE0YDRGAVL/rE
         YY5g==
X-Forwarded-Encrypted: i=1; AJvYcCUg6x3TZP4ZRa7mkg16DT5WbcxjG8vjX08zow+coyzXtWFhHFjOX+fe8KcQkvGATrJlhR1eIdzl82pvcSqKHCioeD0QP4Ymw+4U4fb/
X-Gm-Message-State: AOJu0YyTJcenFvwRv9UrzxgAWZ+mAGuvdRc1dEqri4EBllRxqprCVKNI
	HKZiOJPCEaO1DClwD0CQ4TFf7V4XrAjmJJ+vait6MJZ9sVJ8t23J
X-Google-Smtp-Source: AGHT+IHf0BiQoDOCgC2P8pLuSrnDLeK+K34eYlkwiI311WbRMPDqHnFw1JG/IzsPO5M8yT0aqh7taw==
X-Received: by 2002:a05:6a00:ccd:b0:706:8a67:c3a0 with SMTP id d2e1a72fcca58-70b434f64b1mr696228b3a.5.1720467671758;
        Mon, 08 Jul 2024 12:41:11 -0700 (PDT)
Received: from localhost.localdomain (c-67-161-114-176.hsd1.wa.comcast.net. [67.161.114.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b438994d2sm266414b3a.13.2024.07.08.12.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 12:41:11 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: robin.murphy@arm.com,
	joro@8bytes.org,
	will@kernel.org,
	jgross@suse.com,
	sstabellini@kernel.org,
	oleksandr_tyshchenko@epam.com,
	hch@lst.de,
	m.szyprowski@samsung.com,
	petr@tesarici.cz,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org
Subject: [PATCH v3 1/1] swiotlb: Reduce swiotlb pool lookups
Date: Mon,  8 Jul 2024 12:41:00 -0700
Message-Id: <20240708194100.1531-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

With CONFIG_SWIOTLB_DYNAMIC enabled, each round-trip map/unmap pair
in the swiotlb results in 6 calls to swiotlb_find_pool(). In multiple
places, the pool is found and used in one function, and then must
be found again in the next function that is called because only the
tlb_addr is passed as an argument. These are the six call sites:

dma_direct_map_page:
1. swiotlb_map->swiotlb_tbl_map_single->swiotlb_bounce

dma_direct_unmap_page:
2. dma_direct_sync_single_for_cpu->is_swiotlb_buffer
3. dma_direct_sync_single_for_cpu->swiotlb_sync_single_for_cpu->
	swiotlb_bounce
4. is_swiotlb_buffer
5. swiotlb_tbl_unmap_single->swiotlb_del_transient
6. swiotlb_tbl_unmap_single->swiotlb_release_slots

Reduce the number of calls by finding the pool at a higher level, and
passing it as an argument instead of searching again. A key change is
for is_swiotlb_buffer() to return a pool pointer instead of a boolean,
and then pass this pool pointer to subsequent swiotlb functions.

There are 9 occurrences of is_swiotlb_buffer() used to test if a buffer
is a swiotlb buffer before calling a swiotlb function. To reduce code
duplication in getting the pool pointer and passing it as an argument,
introduce inline wrappers for this pattern. The generated code is
essentially unchanged.

Since is_swiotlb_buffer() no longer returns a boolean, rename some
functions to reflect the change:
* swiotlb_find_pool() becomes __swiotlb_find_pool()
* is_swiotlb_buffer() becomes swiotlb_find_pool()
* is_xen_swiotlb_buffer() becomes xen_swiotlb_find_pool()

With these changes, a round-trip map/unmap pair requires only 2 pool
lookups (listed using the new names and wrappers):

dma_direct_unmap_page:
1. dma_direct_sync_single_for_cpu->swiotlb_find_pool
2. swiotlb_tbl_unmap_single->swiotlb_find_pool

These changes come from noticing the inefficiencies in a code review,
not from performance measurements. With CONFIG_SWIOTLB_DYNAMIC,
__swiotlb_find_pool() is not trivial, and it uses an RCU read lock,
so avoiding the redundant calls helps performance in a hot path.
When CONFIG_SWIOTLB_DYNAMIC is *not* set, the code size reduction
is minimal and the perf benefits are likely negligible, but no
harm is done.

No functional change is intended.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---

Changes in v3:
* Add inline wrappers for swiotlb_tbl_unmap_single(),
  swiotlb_sync_single_for_device() and swiotlb_sync_single_for_cpu() to
  commonize the swiotlb_find_pool() tests for whether the buffer is a
  swiotlb buffer [Christoph Hellwig]
* Change most users of __swiotlb_find_pool() to use swiotlb_find_pool(),
  as the extra checks in the latter aren't impactful. Remove v2 change in
  swiotlb_find_pool() to use __swiotlb_find_pool() when
  CONFIG_SWIOTLB_DYNAMIC is not set. [Christoph Hellwig]
* Rework swiotlb_find_pool() to use IS_ENABLED() instead of #ifdef's.
  To make this work, move dma_uses_io_tlb field in struct device out from
  under #ifdef CONFIG_SWIOTLB_DYNAMIC. [Christoph Hellwig]
* Fix line lengths > 80 chars [Christoph Hellwig]
* Update commit message to reflect changes

Changes in v2 vs. RFC version[1]:
* In swiotlb_find_pool(), use __swiotlb_find_pool() instead of open
  coding when CONFIG_SWIOTLB_DYNAMIC is not set [Petr Tesařík]
* Rename functions as described in the commit message to reflect that
  is_swiotlb_buffer() no longer returns a boolean [Petr Tesařík,
  Christoph Hellwig]
* Updated commit message and patch Subject

[1] https://lore.kernel.org/linux-iommu/20240607031421.182589-1-mhklinux@outlook.com/

 drivers/iommu/dma-iommu.c   |  11 ++-
 drivers/xen/swiotlb-xen.c   |  31 +++++---
 include/linux/device.h      |   3 +-
 include/linux/scatterlist.h |   2 +-
 include/linux/swiotlb.h     | 138 +++++++++++++++++++++---------------
 kernel/dma/direct.c         |  10 +--
 kernel/dma/direct.h         |   9 +--
 kernel/dma/swiotlb.c        |  64 +++++++++--------
 8 files changed, 150 insertions(+), 118 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 43520e7275cc..7b4486238427 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1081,8 +1081,7 @@ static void iommu_dma_sync_single_for_cpu(struct device *dev,
 	if (!dev_is_dma_coherent(dev))
 		arch_sync_dma_for_cpu(phys, size, dir);
 
-	if (is_swiotlb_buffer(dev, phys))
-		swiotlb_sync_single_for_cpu(dev, phys, size, dir);
+	swiotlb_sync_single_for_cpu(dev, phys, size, dir);
 }
 
 static void iommu_dma_sync_single_for_device(struct device *dev,
@@ -1094,8 +1093,7 @@ static void iommu_dma_sync_single_for_device(struct device *dev,
 		return;
 
 	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
-	if (is_swiotlb_buffer(dev, phys))
-		swiotlb_sync_single_for_device(dev, phys, size, dir);
+	swiotlb_sync_single_for_device(dev, phys, size, dir);
 
 	if (!dev_is_dma_coherent(dev))
 		arch_sync_dma_for_device(phys, size, dir);
@@ -1189,7 +1187,7 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 		arch_sync_dma_for_device(phys, size, dir);
 
 	iova = __iommu_dma_map(dev, phys, size, prot, dma_mask);
-	if (iova == DMA_MAPPING_ERROR && is_swiotlb_buffer(dev, phys))
+	if (iova == DMA_MAPPING_ERROR)
 		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
 	return iova;
 }
@@ -1209,8 +1207,7 @@ static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
 
 	__iommu_dma_unmap(dev, dma_handle, size);
 
-	if (unlikely(is_swiotlb_buffer(dev, phys)))
-		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
+	swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
 }
 
 /*
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 6579ae3f6dac..35155258a7e2 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -88,7 +88,8 @@ static inline int range_straddles_page_boundary(phys_addr_t p, size_t size)
 	return 0;
 }
 
-static int is_xen_swiotlb_buffer(struct device *dev, dma_addr_t dma_addr)
+static struct io_tlb_pool *xen_swiotlb_find_pool(struct device *dev,
+						 dma_addr_t dma_addr)
 {
 	unsigned long bfn = XEN_PFN_DOWN(dma_to_phys(dev, dma_addr));
 	unsigned long xen_pfn = bfn_to_local_pfn(bfn);
@@ -99,8 +100,8 @@ static int is_xen_swiotlb_buffer(struct device *dev, dma_addr_t dma_addr)
 	 * in our domain. Therefore _only_ check address within our domain.
 	 */
 	if (pfn_valid(PFN_DOWN(paddr)))
-		return is_swiotlb_buffer(dev, paddr);
-	return 0;
+		return swiotlb_find_pool(dev, paddr);
+	return NULL;
 }
 
 #ifdef CONFIG_X86
@@ -227,8 +228,9 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 	 * Ensure that the address returned is DMA'ble
 	 */
 	if (unlikely(!dma_capable(dev, dev_addr, size, true))) {
-		swiotlb_tbl_unmap_single(dev, map, size, dir,
-				attrs | DMA_ATTR_SKIP_CPU_SYNC);
+		__swiotlb_tbl_unmap_single(dev, map, size, dir,
+				attrs | DMA_ATTR_SKIP_CPU_SYNC,
+				swiotlb_find_pool(dev, map));
 		return DMA_MAPPING_ERROR;
 	}
 
@@ -254,6 +256,7 @@ static void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 	phys_addr_t paddr = xen_dma_to_phys(hwdev, dev_addr);
+	struct io_tlb_pool *pool;
 
 	BUG_ON(dir == DMA_NONE);
 
@@ -265,8 +268,10 @@ static void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
 	}
 
 	/* NOTE: We use dev_addr here, not paddr! */
-	if (is_xen_swiotlb_buffer(hwdev, dev_addr))
-		swiotlb_tbl_unmap_single(hwdev, paddr, size, dir, attrs);
+	pool = xen_swiotlb_find_pool(hwdev, dev_addr);
+	if (pool)
+		__swiotlb_tbl_unmap_single(hwdev, paddr, size, dir,
+					   attrs, pool);
 }
 
 static void
@@ -274,6 +279,7 @@ xen_swiotlb_sync_single_for_cpu(struct device *dev, dma_addr_t dma_addr,
 		size_t size, enum dma_data_direction dir)
 {
 	phys_addr_t paddr = xen_dma_to_phys(dev, dma_addr);
+	struct io_tlb_pool *pool;
 
 	if (!dev_is_dma_coherent(dev)) {
 		if (pfn_valid(PFN_DOWN(dma_to_phys(dev, dma_addr))))
@@ -282,8 +288,9 @@ xen_swiotlb_sync_single_for_cpu(struct device *dev, dma_addr_t dma_addr,
 			xen_dma_sync_for_cpu(dev, dma_addr, size, dir);
 	}
 
-	if (is_xen_swiotlb_buffer(dev, dma_addr))
-		swiotlb_sync_single_for_cpu(dev, paddr, size, dir);
+	pool = xen_swiotlb_find_pool(dev, dma_addr);
+	if (pool)
+		__swiotlb_sync_single_for_cpu(dev, paddr, size, dir, pool);
 }
 
 static void
@@ -291,9 +298,11 @@ xen_swiotlb_sync_single_for_device(struct device *dev, dma_addr_t dma_addr,
 		size_t size, enum dma_data_direction dir)
 {
 	phys_addr_t paddr = xen_dma_to_phys(dev, dma_addr);
+	struct io_tlb_pool *pool;
 
-	if (is_xen_swiotlb_buffer(dev, dma_addr))
-		swiotlb_sync_single_for_device(dev, paddr, size, dir);
+	pool = xen_swiotlb_find_pool(dev, dma_addr);
+	if (pool)
+		__swiotlb_sync_single_for_device(dev, paddr, size, dir, pool);
 
 	if (!dev_is_dma_coherent(dev)) {
 		if (pfn_valid(PFN_DOWN(dma_to_phys(dev, dma_addr))))
diff --git a/include/linux/device.h b/include/linux/device.h
index ace039151cb8..d8a7f5245b7e 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -778,8 +778,9 @@ struct device {
 #ifdef CONFIG_SWIOTLB_DYNAMIC
 	struct list_head dma_io_tlb_pools;
 	spinlock_t dma_io_tlb_lock;
-	bool dma_uses_io_tlb;
 #endif
+	bool dma_uses_io_tlb;
+
 	/* arch specific additions */
 	struct dev_archdata	archdata;
 
diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 77df3d7b18a6..e61d164622db 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -332,7 +332,7 @@ static inline void sg_dma_unmark_bus_address(struct scatterlist *sg)
  * Description:
  *   Returns true if the scatterlist was marked for SWIOTLB bouncing. Not all
  *   elements may have been bounced, so the caller would have to check
- *   individual SG entries with is_swiotlb_buffer().
+ *   individual SG entries with swiotlb_find_pool().
  */
 static inline bool sg_dma_is_swiotlb(struct scatterlist *sg)
 {
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 14bc10c1bb23..9ee8231e6956 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -42,24 +42,6 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 	int (*remap)(void *tlb, unsigned long nslabs));
 extern void __init swiotlb_update_mem_attributes(void);
 
-phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t phys,
-		size_t mapping_size,
-		unsigned int alloc_aligned_mask, enum dma_data_direction dir,
-		unsigned long attrs);
-
-extern void swiotlb_tbl_unmap_single(struct device *hwdev,
-				     phys_addr_t tlb_addr,
-				     size_t mapping_size,
-				     enum dma_data_direction dir,
-				     unsigned long attrs);
-
-void swiotlb_sync_single_for_device(struct device *dev, phys_addr_t tlb_addr,
-		size_t size, enum dma_data_direction dir);
-void swiotlb_sync_single_for_cpu(struct device *dev, phys_addr_t tlb_addr,
-		size_t size, enum dma_data_direction dir);
-dma_addr_t swiotlb_map(struct device *dev, phys_addr_t phys,
-		size_t size, enum dma_data_direction dir, unsigned long attrs);
-
 #ifdef CONFIG_SWIOTLB
 
 /**
@@ -143,55 +125,48 @@ struct io_tlb_mem {
 #endif
 };
 
-#ifdef CONFIG_SWIOTLB_DYNAMIC
-
-struct io_tlb_pool *swiotlb_find_pool(struct device *dev, phys_addr_t paddr);
-
-#else
-
-static inline struct io_tlb_pool *swiotlb_find_pool(struct device *dev,
-						    phys_addr_t paddr)
-{
-	return &dev->dma_io_tlb_mem->defpool;
-}
-
-#endif
+struct io_tlb_pool *__swiotlb_find_pool(struct device *dev, phys_addr_t paddr);
 
 /**
- * is_swiotlb_buffer() - check if a physical address belongs to a swiotlb
+ * swiotlb_find_pool() - find swiotlb pool to which a physical address belongs
  * @dev:        Device which has mapped the buffer.
  * @paddr:      Physical address within the DMA buffer.
  *
- * Check if @paddr points into a bounce buffer.
+ * Find the swiotlb pool that @paddr points into.
  *
  * Return:
- * * %true if @paddr points into a bounce buffer
- * * %false otherwise
+ * * pool address if @paddr points into a bounce buffer
+ * * NULL if @paddr does not point into a bounce buffer. As such, this function
+ *   can be used to determine if @paddr denotes a swiotlb bounce buffer.
  */
-static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
+static inline struct io_tlb_pool *swiotlb_find_pool(struct device *dev,
+						    phys_addr_t paddr)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 
 	if (!mem)
-		return false;
+		return NULL;
+
+	if (IS_ENABLED(CONFIG_SWIOTLB_DYNAMIC)) {
+		/*
+		 * All SWIOTLB buffer addresses must have been returned by
+		 * swiotlb_tbl_map_single() and passed to a device driver.
+		 * If a SWIOTLB address is checked on another CPU, then it was
+		 * presumably loaded by the device driver from an unspecified
+		 * private data structure. Make sure that this load is ordered
+		 * before reading dev->dma_uses_io_tlb here and mem->pools
+		 * in __swiotlb_find_pool().
+		 *
+		 * This barrier pairs with smp_mb() in swiotlb_find_slots().
+		 */
+		smp_rmb();
+		if (READ_ONCE(dev->dma_uses_io_tlb))
+			return __swiotlb_find_pool(dev, paddr);
+	} else if (paddr >= mem->defpool.start && paddr < mem->defpool.end) {
+		return &mem->defpool;
+	}
 
-#ifdef CONFIG_SWIOTLB_DYNAMIC
-	/*
-	 * All SWIOTLB buffer addresses must have been returned by
-	 * swiotlb_tbl_map_single() and passed to a device driver.
-	 * If a SWIOTLB address is checked on another CPU, then it was
-	 * presumably loaded by the device driver from an unspecified private
-	 * data structure. Make sure that this load is ordered before reading
-	 * dev->dma_uses_io_tlb here and mem->pools in swiotlb_find_pool().
-	 *
-	 * This barrier pairs with smp_mb() in swiotlb_find_slots().
-	 */
-	smp_rmb();
-	return READ_ONCE(dev->dma_uses_io_tlb) &&
-		swiotlb_find_pool(dev, paddr);
-#else
-	return paddr >= mem->defpool.start && paddr < mem->defpool.end;
-#endif
+	return NULL;
 }
 
 static inline bool is_swiotlb_force_bounce(struct device *dev)
@@ -219,9 +194,10 @@ static inline void swiotlb_dev_init(struct device *dev)
 {
 }
 
-static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
+static inline struct io_tlb_pool *swiotlb_find_pool(struct device *dev,
+						    phys_addr_t paddr)
 {
-	return false;
+	return NULL;
 }
 static inline bool is_swiotlb_force_bounce(struct device *dev)
 {
@@ -260,6 +236,56 @@ static inline phys_addr_t default_swiotlb_limit(void)
 }
 #endif /* CONFIG_SWIOTLB */
 
+phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t phys,
+		size_t mapping_size,
+		unsigned int alloc_aligned_mask, enum dma_data_direction dir,
+		unsigned long attrs);
+
+void __swiotlb_tbl_unmap_single(struct device *hwdev,
+				     phys_addr_t tlb_addr,
+				     size_t mapping_size,
+				     enum dma_data_direction dir,
+				     unsigned long attrs,
+				     struct io_tlb_pool *pool);
+
+void __swiotlb_sync_single_for_device(struct device *dev, phys_addr_t tlb_addr,
+				      size_t size, enum dma_data_direction dir,
+				      struct io_tlb_pool *pool);
+void __swiotlb_sync_single_for_cpu(struct device *dev, phys_addr_t tlb_addr,
+				   size_t size, enum dma_data_direction dir,
+				   struct io_tlb_pool *pool);
+dma_addr_t swiotlb_map(struct device *dev, phys_addr_t phys,
+		size_t size, enum dma_data_direction dir, unsigned long attrs);
+
+
+static inline void swiotlb_tbl_unmap_single(struct device *dev,
+			phys_addr_t addr, size_t size,
+			enum dma_data_direction dir, unsigned long attrs)
+{
+	struct io_tlb_pool *pool = swiotlb_find_pool(dev, addr);
+
+	if (unlikely(pool))
+		__swiotlb_tbl_unmap_single(dev, addr, size, dir, attrs, pool);
+}
+
+static inline void swiotlb_sync_single_for_device(struct device *dev,
+		phys_addr_t addr, size_t size, enum dma_data_direction dir)
+{
+	struct io_tlb_pool *pool = swiotlb_find_pool(dev, addr);
+
+	if (unlikely(pool))
+		__swiotlb_sync_single_for_device(dev, addr, size, dir, pool);
+}
+
+static inline void swiotlb_sync_single_for_cpu(struct device *dev,
+		phys_addr_t addr, size_t size, enum dma_data_direction dir)
+{
+	struct io_tlb_pool *pool = swiotlb_find_pool(dev, addr);
+
+	if (unlikely(pool))
+		__swiotlb_sync_single_for_cpu(dev, addr, size, dir, pool);
+}
+
 extern void swiotlb_print_info(void);
 
 #ifdef CONFIG_DMA_RESTRICTED_POOL
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 4d543b1e9d57..4480a3cd92e0 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -404,9 +404,7 @@ void dma_direct_sync_sg_for_device(struct device *dev,
 	for_each_sg(sgl, sg, nents, i) {
 		phys_addr_t paddr = dma_to_phys(dev, sg_dma_address(sg));
 
-		if (unlikely(is_swiotlb_buffer(dev, paddr)))
-			swiotlb_sync_single_for_device(dev, paddr, sg->length,
-						       dir);
+		swiotlb_sync_single_for_device(dev, paddr, sg->length, dir);
 
 		if (!dev_is_dma_coherent(dev))
 			arch_sync_dma_for_device(paddr, sg->length,
@@ -430,9 +428,7 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
 		if (!dev_is_dma_coherent(dev))
 			arch_sync_dma_for_cpu(paddr, sg->length, dir);
 
-		if (unlikely(is_swiotlb_buffer(dev, paddr)))
-			swiotlb_sync_single_for_cpu(dev, paddr, sg->length,
-						    dir);
+		swiotlb_sync_single_for_cpu(dev, paddr, sg->length, dir);
 
 		if (dir == DMA_FROM_DEVICE)
 			arch_dma_mark_clean(paddr, sg->length);
@@ -640,7 +636,7 @@ size_t dma_direct_max_mapping_size(struct device *dev)
 bool dma_direct_need_sync(struct device *dev, dma_addr_t dma_addr)
 {
 	return !dev_is_dma_coherent(dev) ||
-	       is_swiotlb_buffer(dev, dma_to_phys(dev, dma_addr));
+	       swiotlb_find_pool(dev, dma_to_phys(dev, dma_addr));
 }
 
 /**
diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index 18d346118fe8..d2c0b7e632fc 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -58,8 +58,7 @@ static inline void dma_direct_sync_single_for_device(struct device *dev,
 {
 	phys_addr_t paddr = dma_to_phys(dev, addr);
 
-	if (unlikely(is_swiotlb_buffer(dev, paddr)))
-		swiotlb_sync_single_for_device(dev, paddr, size, dir);
+	swiotlb_sync_single_for_device(dev, paddr, size, dir);
 
 	if (!dev_is_dma_coherent(dev))
 		arch_sync_dma_for_device(paddr, size, dir);
@@ -75,8 +74,7 @@ static inline void dma_direct_sync_single_for_cpu(struct device *dev,
 		arch_sync_dma_for_cpu_all();
 	}
 
-	if (unlikely(is_swiotlb_buffer(dev, paddr)))
-		swiotlb_sync_single_for_cpu(dev, paddr, size, dir);
+	swiotlb_sync_single_for_cpu(dev, paddr, size, dir);
 
 	if (dir == DMA_FROM_DEVICE)
 		arch_dma_mark_clean(paddr, size);
@@ -121,8 +119,7 @@ static inline void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		dma_direct_sync_single_for_cpu(dev, addr, size, dir);
 
-	if (unlikely(is_swiotlb_buffer(dev, phys)))
-		swiotlb_tbl_unmap_single(dev, phys, size, dir,
+	swiotlb_tbl_unmap_single(dev, phys, size, dir,
 					 attrs | DMA_ATTR_SKIP_CPU_SYNC);
 }
 #endif /* _KERNEL_DMA_DIRECT_H */
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index fe1ccb53596f..5010812e7da4 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -763,16 +763,18 @@ static void swiotlb_dyn_free(struct rcu_head *rcu)
 }
 
 /**
- * swiotlb_find_pool() - find the IO TLB pool for a physical address
+ * __swiotlb_find_pool() - find the IO TLB pool for a physical address
  * @dev:        Device which has mapped the DMA buffer.
  * @paddr:      Physical address within the DMA buffer.
  *
  * Find the IO TLB memory pool descriptor which contains the given physical
- * address, if any.
+ * address, if any. This function is for use only when the dev is known to
+ * be using swiotlb. Use swiotlb_find_pool() for the more general case
+ * when this condition is not met.
  *
  * Return: Memory pool which contains @paddr, or %NULL if none.
  */
-struct io_tlb_pool *swiotlb_find_pool(struct device *dev, phys_addr_t paddr)
+struct io_tlb_pool *__swiotlb_find_pool(struct device *dev, phys_addr_t paddr)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 	struct io_tlb_pool *pool;
@@ -855,9 +857,8 @@ static unsigned int swiotlb_align_offset(struct device *dev,
  * Bounce: copy the swiotlb buffer from or back to the original dma location
  */
 static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size,
-			   enum dma_data_direction dir)
+			   enum dma_data_direction dir, struct io_tlb_pool *mem)
 {
-	struct io_tlb_pool *mem = swiotlb_find_pool(dev, tlb_addr);
 	int index = (tlb_addr - mem->start) >> IO_TLB_SHIFT;
 	phys_addr_t orig_addr = mem->slots[index].orig_addr;
 	size_t alloc_size = mem->slots[index].alloc_size;
@@ -1243,7 +1244,7 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 	 * that was made by swiotlb_dyn_alloc() on a third CPU (cf. multicopy
 	 * atomicity).
 	 *
-	 * See also the comment in is_swiotlb_buffer().
+	 * See also the comment in swiotlb_find_pool().
 	 */
 	smp_mb();
 
@@ -1435,13 +1436,13 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	 * hardware behavior.  Use of swiotlb is supposed to be transparent,
 	 * i.e. swiotlb must not corrupt memory by clobbering unwritten bytes.
 	 */
-	swiotlb_bounce(dev, tlb_addr, mapping_size, DMA_TO_DEVICE);
+	swiotlb_bounce(dev, tlb_addr, mapping_size, DMA_TO_DEVICE, pool);
 	return tlb_addr;
 }
 
-static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
+static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr,
+				  struct io_tlb_pool *mem)
 {
-	struct io_tlb_pool *mem = swiotlb_find_pool(dev, tlb_addr);
 	unsigned long flags;
 	unsigned int offset = swiotlb_align_offset(dev, 0, tlb_addr);
 	int index, nslots, aindex;
@@ -1505,11 +1506,9 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
  *
  * Return: %true if @tlb_addr belonged to a transient pool that was released.
  */
-static bool swiotlb_del_transient(struct device *dev, phys_addr_t tlb_addr)
+static bool swiotlb_del_transient(struct device *dev, phys_addr_t tlb_addr,
+				  struct io_tlb_pool *pool)
 {
-	struct io_tlb_pool *pool;
-
-	pool = swiotlb_find_pool(dev, tlb_addr);
 	if (!pool->transient)
 		return false;
 
@@ -1522,7 +1521,8 @@ static bool swiotlb_del_transient(struct device *dev, phys_addr_t tlb_addr)
 #else  /* !CONFIG_SWIOTLB_DYNAMIC */
 
 static inline bool swiotlb_del_transient(struct device *dev,
-					 phys_addr_t tlb_addr)
+					 phys_addr_t tlb_addr,
+					 struct io_tlb_pool *pool)
 {
 	return false;
 }
@@ -1532,36 +1532,39 @@ static inline bool swiotlb_del_transient(struct device *dev,
 /*
  * tlb_addr is the physical address of the bounce buffer to unmap.
  */
-void swiotlb_tbl_unmap_single(struct device *dev, phys_addr_t tlb_addr,
+void __swiotlb_tbl_unmap_single(struct device *dev, phys_addr_t tlb_addr,
 			      size_t mapping_size, enum dma_data_direction dir,
-			      unsigned long attrs)
+			      unsigned long attrs, struct io_tlb_pool *pool)
 {
 	/*
 	 * First, sync the memory before unmapping the entry
 	 */
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL))
-		swiotlb_bounce(dev, tlb_addr, mapping_size, DMA_FROM_DEVICE);
+		swiotlb_bounce(dev, tlb_addr, mapping_size,
+						DMA_FROM_DEVICE, pool);
 
-	if (swiotlb_del_transient(dev, tlb_addr))
+	if (swiotlb_del_transient(dev, tlb_addr, pool))
 		return;
-	swiotlb_release_slots(dev, tlb_addr);
+	swiotlb_release_slots(dev, tlb_addr, pool);
 }
 
-void swiotlb_sync_single_for_device(struct device *dev, phys_addr_t tlb_addr,
-		size_t size, enum dma_data_direction dir)
+void __swiotlb_sync_single_for_device(struct device *dev, phys_addr_t tlb_addr,
+		size_t size, enum dma_data_direction dir,
+		struct io_tlb_pool *pool)
 {
 	if (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL)
-		swiotlb_bounce(dev, tlb_addr, size, DMA_TO_DEVICE);
+		swiotlb_bounce(dev, tlb_addr, size, DMA_TO_DEVICE, pool);
 	else
 		BUG_ON(dir != DMA_FROM_DEVICE);
 }
 
-void swiotlb_sync_single_for_cpu(struct device *dev, phys_addr_t tlb_addr,
-		size_t size, enum dma_data_direction dir)
+void __swiotlb_sync_single_for_cpu(struct device *dev, phys_addr_t tlb_addr,
+		size_t size, enum dma_data_direction dir,
+		struct io_tlb_pool *pool)
 {
 	if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL)
-		swiotlb_bounce(dev, tlb_addr, size, DMA_FROM_DEVICE);
+		swiotlb_bounce(dev, tlb_addr, size, DMA_FROM_DEVICE, pool);
 	else
 		BUG_ON(dir != DMA_TO_DEVICE);
 }
@@ -1585,8 +1588,9 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
 	/* Ensure that the address returned is DMA'ble */
 	dma_addr = phys_to_dma_unencrypted(dev, swiotlb_addr);
 	if (unlikely(!dma_capable(dev, dma_addr, size, true))) {
-		swiotlb_tbl_unmap_single(dev, swiotlb_addr, size, dir,
-			attrs | DMA_ATTR_SKIP_CPU_SYNC);
+		__swiotlb_tbl_unmap_single(dev, swiotlb_addr, size, dir,
+			attrs | DMA_ATTR_SKIP_CPU_SYNC,
+			swiotlb_find_pool(dev, swiotlb_addr));
 		dev_WARN_ONCE(dev, 1,
 			"swiotlb addr %pad+%zu overflow (mask %llx, bus limit %llx).\n",
 			&dma_addr, size, *dev->dma_mask, dev->bus_dma_limit);
@@ -1774,11 +1778,13 @@ struct page *swiotlb_alloc(struct device *dev, size_t size)
 bool swiotlb_free(struct device *dev, struct page *page, size_t size)
 {
 	phys_addr_t tlb_addr = page_to_phys(page);
+	struct io_tlb_pool *pool;
 
-	if (!is_swiotlb_buffer(dev, tlb_addr))
+	pool = swiotlb_find_pool(dev, tlb_addr);
+	if (!pool)
 		return false;
 
-	swiotlb_release_slots(dev, tlb_addr);
+	swiotlb_release_slots(dev, tlb_addr, pool);
 
 	return true;
 }
-- 
2.25.1


