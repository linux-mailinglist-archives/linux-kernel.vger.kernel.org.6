Return-Path: <linux-kernel+bounces-205264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F26C8FFA1E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 05:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C095E285071
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 03:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162841B27D;
	Fri,  7 Jun 2024 03:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNuWIh0o"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48F117BBA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 03:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717730080; cv=none; b=m0mn+FQBtrizwWS2aY+1fPGgoIXXCiOEgt+jjl/7T2dAl7V05FAgfDMgMKQxLsYn8DEqLfaS9cx/jyeHVf7pK/o9yMKhQjAyFUAgl7V9iRBZoNlJOrWa/z1vUhWHK7Ln7FW+Fh1ztCSZoLigopqU0RXj5gCAqW8qhlXSnTDbZVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717730080; c=relaxed/simple;
	bh=f+eNVJse7pWYfTCncjFT4wT88ALxdREYpXmNJs+gULU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=TxbSNjyPh/ms/cyGfP642uIBGOfEHwhe5OcwNGb1OEOUJg+WfDoHd5CQibWbRJOsO+NS0tKz+7bSFtUsgz1lnbA0VrYN0uc2MpbiIEzBrqfWjYJaaUxyVtIgHDjPxzD4aORtUddXHwGK2mhlQjDwjgxoJyyHqP99G/K+jePsBzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNuWIh0o; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f480624d0dso16069095ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 20:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717730078; x=1718334878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S6sq1v/HYVth5hgL6aHLmT9s4dMG30DKkez74RK4Byw=;
        b=jNuWIh0oYhff4XQV+pgjo/LK2l42xzj8YWwSJmRvao/1IBDYClOumMGthXI1aY0WTk
         BW8/Aft4L7Vv4bbE5ySoqEkG3zQzYHfzRv16gkGHnENjkMRFgHLPigqK+CX3cedLyXep
         fjBCXHTC2/PRo8cuB96676UrOEPTiZbFH+4LkgKORocW3+Cg6a/LaiW622wMhPnmjFPX
         UM7jre31cIaeSD2zRxFqgoGrOBV8dfxsi1duvXTc91gGIcqD7z23NnqBZuSwcD+2bt82
         RPoU2aRBI39FrsQ2vjByX36XY9Uw1WWv7WpdpAS/8+uhHC9symVwhDMsCPAADS0bq+At
         959A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717730078; x=1718334878;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6sq1v/HYVth5hgL6aHLmT9s4dMG30DKkez74RK4Byw=;
        b=csA0OphVHQWeOuniPJyRKfza9w5EAGNPbQouxNoSdOo6z/wIudxNym5H1hGKJ3OUak
         OXQf5sZMbA+pqM+rUUEpzjcltQwqciA8+Ueryse4nHtQO+MT56r5KUAfv1Ry/hwT/T0R
         qbnCGtlsdbtXZ3sypCwWb4CV4e59fyoswX8erPrFEt6zk0ymq1wwoTbR7pVhg40YZHFV
         sMJMGwayZ25xZYu0Vm3lXWXBfonBnueZNuk3hHZMzAyDV2/iNuq/Z8pBA2G6OENfPPM4
         YfNVh5SKpdE1rppgiVlEKujYQqeb58BTj+E70DmT2FtmWKoLGC0RnL14Xv33V7da3nlC
         95LA==
X-Forwarded-Encrypted: i=1; AJvYcCXT+QZkrZTidGd1YNpe+8yFy3THwF54kE30mifeDL1CQYHiBlEgKrYu9ml0RxLc2iAj7jjLMCNVFU2a/YZs9RuWEgLNFYTzObevjtqP
X-Gm-Message-State: AOJu0YxPrQ3jjGMSdsJrCyHq1XkVPT5VPGFAS4H0gXWxAu01QxqundZF
	R87pY0xkXhy6oth+kHDWnpcbj2LJtYFN82lBHnelXMBqf8kD79Xy
X-Google-Smtp-Source: AGHT+IGVLbOop05kbtCd0vA2QzX1cxZyTlSfbXjA3G457nSL5A9bMH4Wmsybo0Hjsa4Y5lzdKheiWA==
X-Received: by 2002:a17:902:ea0b:b0:1f6:92f1:b01c with SMTP id d9443c01a7336-1f6d03b9604mr16907795ad.69.1717730077750;
        Thu, 06 Jun 2024 20:14:37 -0700 (PDT)
Received: from localhost.localdomain (c-67-161-114-176.hsd1.wa.comcast.net. [67.161.114.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7f7ec1sm23027405ad.271.2024.06.06.20.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 20:14:37 -0700 (PDT)
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
Subject: [RFC 1/1] swiotlb: Reduce calls to swiotlb_find_pool()
Date: Thu,  6 Jun 2024 20:14:21 -0700
Message-Id: <20240607031421.182589-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

With CONFIG_SWIOTLB_DYNAMIC enabled, each round-trip map/unmap pair
in the swiotlb results in 6 calls to swiotlb_find_pool(). In multiple
places, the pool is found and used in one function, and then must
found again in the next function that is called because only the
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
With these changes, a round-trip map/unmap pair requires only 2 calls
to swiotlb_find_pool():

dma_direct_unmap_page:
1. dma_direct_sync_single_for_cpu->is_swiotlb_buffer
2. is_swiotlb_buffer

These changes come from noticing the inefficiencies in a code review,
not from performance measurements. With CONFIG_SWIOTLB_DYNAMIC,
swiotlb_find_pool() is not trivial, and it uses an RCU read lock,
so avoiding the redundant calls helps performance in a hot path.
When CONFIG_SWIOTLB_DYNAMIC is *not* set, the code size reduction
is minimal and the perf benefits are likely negligible, but no
harm is done.

No functional change is intended.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
This patch trades off making many of the core swiotlb APIs take
an additional argument in order to avoid duplicating calls to
swiotlb_find_pool(). The current code seems rather wasteful in
making 6 calls per round-trip, but I'm happy to accept others'
judgment as to whether getting rid of the waste is worth the
additional code complexity.

 drivers/iommu/dma-iommu.c | 27 ++++++++++++++------
 drivers/xen/swiotlb-xen.c | 25 +++++++++++-------
 include/linux/swiotlb.h   | 54 +++++++++++++++++++++------------------
 kernel/dma/direct.c       | 12 ++++++---
 kernel/dma/direct.h       | 18 ++++++++-----
 kernel/dma/swiotlb.c      | 43 ++++++++++++++++---------------
 6 files changed, 106 insertions(+), 73 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index f731e4b2a417..ab6bc37ecf90 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1073,6 +1073,7 @@ static void iommu_dma_sync_single_for_cpu(struct device *dev,
 		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
 {
 	phys_addr_t phys;
+	struct io_tlb_pool *pool;
 
 	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev, size, dir))
 		return;
@@ -1081,21 +1082,25 @@ static void iommu_dma_sync_single_for_cpu(struct device *dev,
 	if (!dev_is_dma_coherent(dev))
 		arch_sync_dma_for_cpu(phys, size, dir);
 
-	if (is_swiotlb_buffer(dev, phys))
-		swiotlb_sync_single_for_cpu(dev, phys, size, dir);
+	pool = is_swiotlb_buffer(dev, phys);
+	if (pool)
+		swiotlb_sync_single_for_cpu(dev, phys, size, dir, pool);
 }
 
 static void iommu_dma_sync_single_for_device(struct device *dev,
 		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
 {
 	phys_addr_t phys;
+	struct io_tlb_pool *pool;
 
 	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev, size, dir))
 		return;
 
 	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
-	if (is_swiotlb_buffer(dev, phys))
-		swiotlb_sync_single_for_device(dev, phys, size, dir);
+
+	pool = is_swiotlb_buffer(dev, phys);
+	if (pool)
+		swiotlb_sync_single_for_device(dev, phys, size, dir, pool);
 
 	if (!dev_is_dma_coherent(dev))
 		arch_sync_dma_for_device(phys, size, dir);
@@ -1189,8 +1194,12 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 		arch_sync_dma_for_device(phys, size, dir);
 
 	iova = __iommu_dma_map(dev, phys, size, prot, dma_mask);
-	if (iova == DMA_MAPPING_ERROR && is_swiotlb_buffer(dev, phys))
-		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
+	if (iova == DMA_MAPPING_ERROR) {
+		struct io_tlb_pool *pool = is_swiotlb_buffer(dev, phys);
+
+		if (pool)
+			swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs, pool);
+	}
 	return iova;
 }
 
@@ -1199,6 +1208,7 @@ static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
 {
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	phys_addr_t phys;
+	struct io_tlb_pool *pool;
 
 	phys = iommu_iova_to_phys(domain, dma_handle);
 	if (WARN_ON(!phys))
@@ -1209,8 +1219,9 @@ static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
 
 	__iommu_dma_unmap(dev, dma_handle, size);
 
-	if (unlikely(is_swiotlb_buffer(dev, phys)))
-		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
+	pool = is_swiotlb_buffer(dev, phys);
+	if (unlikely(pool))
+		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs, pool);
 }
 
 /*
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 6579ae3f6dac..7af8c8466e1d 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -88,7 +88,7 @@ static inline int range_straddles_page_boundary(phys_addr_t p, size_t size)
 	return 0;
 }
 
-static int is_xen_swiotlb_buffer(struct device *dev, dma_addr_t dma_addr)
+static struct io_tlb_pool *is_xen_swiotlb_buffer(struct device *dev, dma_addr_t dma_addr)
 {
 	unsigned long bfn = XEN_PFN_DOWN(dma_to_phys(dev, dma_addr));
 	unsigned long xen_pfn = bfn_to_local_pfn(bfn);
@@ -100,7 +100,7 @@ static int is_xen_swiotlb_buffer(struct device *dev, dma_addr_t dma_addr)
 	 */
 	if (pfn_valid(PFN_DOWN(paddr)))
 		return is_swiotlb_buffer(dev, paddr);
-	return 0;
+	return NULL;
 }
 
 #ifdef CONFIG_X86
@@ -228,7 +228,8 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 	 */
 	if (unlikely(!dma_capable(dev, dev_addr, size, true))) {
 		swiotlb_tbl_unmap_single(dev, map, size, dir,
-				attrs | DMA_ATTR_SKIP_CPU_SYNC);
+				attrs | DMA_ATTR_SKIP_CPU_SYNC,
+				swiotlb_find_pool(dev, map));
 		return DMA_MAPPING_ERROR;
 	}
 
@@ -254,6 +255,7 @@ static void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 	phys_addr_t paddr = xen_dma_to_phys(hwdev, dev_addr);
+	struct io_tlb_pool *pool;
 
 	BUG_ON(dir == DMA_NONE);
 
@@ -265,8 +267,9 @@ static void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
 	}
 
 	/* NOTE: We use dev_addr here, not paddr! */
-	if (is_xen_swiotlb_buffer(hwdev, dev_addr))
-		swiotlb_tbl_unmap_single(hwdev, paddr, size, dir, attrs);
+	pool = is_xen_swiotlb_buffer(hwdev, dev_addr);
+	if (pool)
+		swiotlb_tbl_unmap_single(hwdev, paddr, size, dir, attrs, pool);
 }
 
 static void
@@ -274,6 +277,7 @@ xen_swiotlb_sync_single_for_cpu(struct device *dev, dma_addr_t dma_addr,
 		size_t size, enum dma_data_direction dir)
 {
 	phys_addr_t paddr = xen_dma_to_phys(dev, dma_addr);
+	struct io_tlb_pool *pool;
 
 	if (!dev_is_dma_coherent(dev)) {
 		if (pfn_valid(PFN_DOWN(dma_to_phys(dev, dma_addr))))
@@ -282,8 +286,9 @@ xen_swiotlb_sync_single_for_cpu(struct device *dev, dma_addr_t dma_addr,
 			xen_dma_sync_for_cpu(dev, dma_addr, size, dir);
 	}
 
-	if (is_xen_swiotlb_buffer(dev, dma_addr))
-		swiotlb_sync_single_for_cpu(dev, paddr, size, dir);
+	pool = is_xen_swiotlb_buffer(dev, dma_addr);
+	if (pool)
+		swiotlb_sync_single_for_cpu(dev, paddr, size, dir, pool);
 }
 
 static void
@@ -291,9 +296,11 @@ xen_swiotlb_sync_single_for_device(struct device *dev, dma_addr_t dma_addr,
 		size_t size, enum dma_data_direction dir)
 {
 	phys_addr_t paddr = xen_dma_to_phys(dev, dma_addr);
+	struct io_tlb_pool *pool;
 
-	if (is_xen_swiotlb_buffer(dev, dma_addr))
-		swiotlb_sync_single_for_device(dev, paddr, size, dir);
+	pool = is_xen_swiotlb_buffer(dev, dma_addr);
+	if (pool)
+		swiotlb_sync_single_for_device(dev, paddr, size, dir, pool);
 
 	if (!dev_is_dma_coherent(dev)) {
 		if (pfn_valid(PFN_DOWN(dma_to_phys(dev, dma_addr))))
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 14bc10c1bb23..ce8651949123 100644
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
@@ -168,12 +150,12 @@ static inline struct io_tlb_pool *swiotlb_find_pool(struct device *dev,
  * * %true if @paddr points into a bounce buffer
  * * %false otherwise
  */
-static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
+static inline struct io_tlb_pool *is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 
 	if (!mem)
-		return false;
+		return NULL;
 
 #ifdef CONFIG_SWIOTLB_DYNAMIC
 	/*
@@ -187,10 +169,13 @@ static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
 	 * This barrier pairs with smp_mb() in swiotlb_find_slots().
 	 */
 	smp_rmb();
-	return READ_ONCE(dev->dma_uses_io_tlb) &&
-		swiotlb_find_pool(dev, paddr);
+	if (READ_ONCE(dev->dma_uses_io_tlb))
+		return swiotlb_find_pool(dev, paddr);
+	return NULL;
 #else
-	return paddr >= mem->defpool.start && paddr < mem->defpool.end;
+	if (paddr >= mem->defpool.start && paddr < mem->defpool.end)
+		return &mem->defpool;
+	return NULL;
 #endif
 }
 
@@ -201,6 +186,25 @@ static inline bool is_swiotlb_force_bounce(struct device *dev)
 	return mem && mem->force_bounce;
 }
 
+phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t phys,
+		size_t mapping_size,
+		unsigned int alloc_aligned_mask, enum dma_data_direction dir,
+		unsigned long attrs);
+
+extern void swiotlb_tbl_unmap_single(struct device *hwdev,
+				     phys_addr_t tlb_addr,
+				     size_t mapping_size,
+				     enum dma_data_direction dir,
+				     unsigned long attrs,
+				     struct io_tlb_pool *pool);
+
+void swiotlb_sync_single_for_device(struct device *dev, phys_addr_t tlb_addr,
+		size_t size, enum dma_data_direction dir, struct io_tlb_pool *pool);
+void swiotlb_sync_single_for_cpu(struct device *dev, phys_addr_t tlb_addr,
+		size_t size, enum dma_data_direction dir, struct io_tlb_pool *pool);
+dma_addr_t swiotlb_map(struct device *dev, phys_addr_t phys,
+		size_t size, enum dma_data_direction dir, unsigned long attrs);
+
 void swiotlb_init(bool addressing_limited, unsigned int flags);
 void __init swiotlb_exit(void);
 void swiotlb_dev_init(struct device *dev);
@@ -219,9 +223,9 @@ static inline void swiotlb_dev_init(struct device *dev)
 {
 }
 
-static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
+static inline struct io_tlb_pool *is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
 {
-	return false;
+	return NULL;
 }
 static inline bool is_swiotlb_force_bounce(struct device *dev)
 {
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 4d543b1e9d57..50689afb0ffd 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -399,14 +399,16 @@ void dma_direct_sync_sg_for_device(struct device *dev,
 		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
 {
 	struct scatterlist *sg;
+	struct io_tlb_pool *pool;
 	int i;
 
 	for_each_sg(sgl, sg, nents, i) {
 		phys_addr_t paddr = dma_to_phys(dev, sg_dma_address(sg));
 
-		if (unlikely(is_swiotlb_buffer(dev, paddr)))
+		pool = is_swiotlb_buffer(dev, paddr);
+		if (unlikely(pool))
 			swiotlb_sync_single_for_device(dev, paddr, sg->length,
-						       dir);
+						       dir, pool);
 
 		if (!dev_is_dma_coherent(dev))
 			arch_sync_dma_for_device(paddr, sg->length,
@@ -422,6 +424,7 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
 		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
 {
 	struct scatterlist *sg;
+	struct io_tlb_pool *pool;
 	int i;
 
 	for_each_sg(sgl, sg, nents, i) {
@@ -430,9 +433,10 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
 		if (!dev_is_dma_coherent(dev))
 			arch_sync_dma_for_cpu(paddr, sg->length, dir);
 
-		if (unlikely(is_swiotlb_buffer(dev, paddr)))
+		pool = is_swiotlb_buffer(dev, paddr);
+		if (unlikely(pool))
 			swiotlb_sync_single_for_cpu(dev, paddr, sg->length,
-						    dir);
+						    dir, pool);
 
 		if (dir == DMA_FROM_DEVICE)
 			arch_dma_mark_clean(paddr, sg->length);
diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index 18d346118fe8..72aa65558e07 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -57,9 +57,11 @@ static inline void dma_direct_sync_single_for_device(struct device *dev,
 		dma_addr_t addr, size_t size, enum dma_data_direction dir)
 {
 	phys_addr_t paddr = dma_to_phys(dev, addr);
+	struct io_tlb_pool *pool;
 
-	if (unlikely(is_swiotlb_buffer(dev, paddr)))
-		swiotlb_sync_single_for_device(dev, paddr, size, dir);
+	pool = is_swiotlb_buffer(dev, paddr);
+	if (unlikely(pool))
+		swiotlb_sync_single_for_device(dev, paddr, size, dir, pool);
 
 	if (!dev_is_dma_coherent(dev))
 		arch_sync_dma_for_device(paddr, size, dir);
@@ -69,14 +71,16 @@ static inline void dma_direct_sync_single_for_cpu(struct device *dev,
 		dma_addr_t addr, size_t size, enum dma_data_direction dir)
 {
 	phys_addr_t paddr = dma_to_phys(dev, addr);
+	struct io_tlb_pool *pool;
 
 	if (!dev_is_dma_coherent(dev)) {
 		arch_sync_dma_for_cpu(paddr, size, dir);
 		arch_sync_dma_for_cpu_all();
 	}
 
-	if (unlikely(is_swiotlb_buffer(dev, paddr)))
-		swiotlb_sync_single_for_cpu(dev, paddr, size, dir);
+	pool = is_swiotlb_buffer(dev, paddr);
+	if (unlikely(pool))
+		swiotlb_sync_single_for_cpu(dev, paddr, size, dir, pool);
 
 	if (dir == DMA_FROM_DEVICE)
 		arch_dma_mark_clean(paddr, size);
@@ -117,12 +121,14 @@ static inline void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 	phys_addr_t phys = dma_to_phys(dev, addr);
+	struct io_tlb_pool *pool;
 
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		dma_direct_sync_single_for_cpu(dev, addr, size, dir);
 
-	if (unlikely(is_swiotlb_buffer(dev, phys)))
+	pool = is_swiotlb_buffer(dev, phys);
+	if (unlikely(pool))
 		swiotlb_tbl_unmap_single(dev, phys, size, dir,
-					 attrs | DMA_ATTR_SKIP_CPU_SYNC);
+					 attrs | DMA_ATTR_SKIP_CPU_SYNC, pool);
 }
 #endif /* _KERNEL_DMA_DIRECT_H */
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index fe1ccb53596f..59b3e333651d 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -855,9 +855,8 @@ static unsigned int swiotlb_align_offset(struct device *dev,
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
@@ -1435,13 +1434,13 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
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
@@ -1505,11 +1504,9 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
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
 
@@ -1522,7 +1519,8 @@ static bool swiotlb_del_transient(struct device *dev, phys_addr_t tlb_addr)
 #else  /* !CONFIG_SWIOTLB_DYNAMIC */
 
 static inline bool swiotlb_del_transient(struct device *dev,
-					 phys_addr_t tlb_addr)
+					 phys_addr_t tlb_addr,
+					 struct io_tlb_pool *pool)
 {
 	return false;
 }
@@ -1534,34 +1532,34 @@ static inline bool swiotlb_del_transient(struct device *dev,
  */
 void swiotlb_tbl_unmap_single(struct device *dev, phys_addr_t tlb_addr,
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
+		swiotlb_bounce(dev, tlb_addr, mapping_size, DMA_FROM_DEVICE, pool);
 
-	if (swiotlb_del_transient(dev, tlb_addr))
+	if (swiotlb_del_transient(dev, tlb_addr, pool))
 		return;
-	swiotlb_release_slots(dev, tlb_addr);
+	swiotlb_release_slots(dev, tlb_addr, pool);
 }
 
 void swiotlb_sync_single_for_device(struct device *dev, phys_addr_t tlb_addr,
-		size_t size, enum dma_data_direction dir)
+		size_t size, enum dma_data_direction dir, struct io_tlb_pool *pool)
 {
 	if (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL)
-		swiotlb_bounce(dev, tlb_addr, size, DMA_TO_DEVICE);
+		swiotlb_bounce(dev, tlb_addr, size, DMA_TO_DEVICE, pool);
 	else
 		BUG_ON(dir != DMA_FROM_DEVICE);
 }
 
 void swiotlb_sync_single_for_cpu(struct device *dev, phys_addr_t tlb_addr,
-		size_t size, enum dma_data_direction dir)
+		size_t size, enum dma_data_direction dir, struct io_tlb_pool *pool)
 {
 	if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL)
-		swiotlb_bounce(dev, tlb_addr, size, DMA_FROM_DEVICE);
+		swiotlb_bounce(dev, tlb_addr, size, DMA_FROM_DEVICE, pool);
 	else
 		BUG_ON(dir != DMA_TO_DEVICE);
 }
@@ -1586,7 +1584,8 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
 	dma_addr = phys_to_dma_unencrypted(dev, swiotlb_addr);
 	if (unlikely(!dma_capable(dev, dma_addr, size, true))) {
 		swiotlb_tbl_unmap_single(dev, swiotlb_addr, size, dir,
-			attrs | DMA_ATTR_SKIP_CPU_SYNC);
+			attrs | DMA_ATTR_SKIP_CPU_SYNC,
+			swiotlb_find_pool(dev, swiotlb_addr));
 		dev_WARN_ONCE(dev, 1,
 			"swiotlb addr %pad+%zu overflow (mask %llx, bus limit %llx).\n",
 			&dma_addr, size, *dev->dma_mask, dev->bus_dma_limit);
@@ -1774,11 +1773,13 @@ struct page *swiotlb_alloc(struct device *dev, size_t size)
 bool swiotlb_free(struct device *dev, struct page *page, size_t size)
 {
 	phys_addr_t tlb_addr = page_to_phys(page);
+	struct io_tlb_pool *pool;
 
-	if (!is_swiotlb_buffer(dev, tlb_addr))
+	pool = is_swiotlb_buffer(dev, tlb_addr);
+	if (!pool)
 		return false;
 
-	swiotlb_release_slots(dev, tlb_addr);
+	swiotlb_release_slots(dev, tlb_addr, pool);
 
 	return true;
 }
-- 
2.25.1


