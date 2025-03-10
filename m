Return-Path: <linux-kernel+bounces-553505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDFAA58AB2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 03:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BD82188DC20
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 02:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84BE1B4257;
	Mon, 10 Mar 2025 02:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LsKQHGEr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9691AF0BC
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 02:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741574866; cv=none; b=cTnayR6Rgou/8JeY6/AO4EwcBqQN1nIkeBq+LnZqw663LGiDRT2WlvGgE0tD834V0SLVkPCuLdLDYA6GCgH0vqEeGcJWLU9QCgvC9qZYzOPy7ViG/W62jmzaVuQL92zrJOaxy0oP5dfVyWDNuP56jUPof/g+JfRxjKXJsaHBh1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741574866; c=relaxed/simple;
	bh=tUTDTesMrpiXmjW8gl3QjpxoqRcSuCz7vluHospBe0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eWEOVVM7gspFsczI+siDaf5/W9hOkbMbO5cAc0GLb9ktJ1X5tE2aIlcsqHmapOnRVN1iO6iOcPC0/rfFMR4leAl53M1AuCc3vdX4xXgbsUNLP3tK/nCt1Vj3HNCeeL9DamUNMoBnjqwk4x+AcnswVg3QYPekh6UJ1jMxzEpJ9ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LsKQHGEr; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741574863; x=1773110863;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tUTDTesMrpiXmjW8gl3QjpxoqRcSuCz7vluHospBe0Q=;
  b=LsKQHGErc/ptomXCGguAVGtVOiMYab9VmZtNoK3j/a81r7PFamEUsnq3
   xfC7LO6eHt3A5uF4XYPbnlJBcUGrGT5mery1aMkX3i2k8Csxy0kZw+1Z6
   mF7Q2VBrgk8lbo+bXlldsTRRUgdJs6uFW60DPBJlohilXQU6gzIMDDKCU
   DdSSQV8kaKfgIuOH9JFEHrUNVW52sZLFD1v7wcTiRMxnaYRBdka3h7pd+
   cW+54IpxLV5NJj3ftwQvH9UVCMxTfcKkrF2kBAivSfEFAB6/0exQwcag4
   DUN1ieiQp68MvJThWvr1bR8MStPziHp+S8dEPjZJGxlEXwvtIPvx5RAg0
   w==;
X-CSE-ConnectionGUID: wjNPvrYdRUqAqm5cIdCq1Q==
X-CSE-MsgGUID: e4+Y/VdmSy+zejll9KwddQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="42401596"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="42401596"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 19:47:39 -0700
X-CSE-ConnectionGUID: rUxLmraHSRqi6FBMQ1zLfw==
X-CSE-MsgGUID: w9yPtq5JQCOrUhK5KWWE5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="143079230"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa002.fm.intel.com with ESMTP; 09 Mar 2025 19:47:35 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] iommu/vt-d: Use virt_to_phys()
Date: Mon, 10 Mar 2025 10:47:45 +0800
Message-ID: <20250310024749.3702681-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250310024749.3702681-1-baolu.lu@linux.intel.com>
References: <20250310024749.3702681-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Gunthorpe <jgg@nvidia.com>

If all the inlines are unwound virt_to_dma_pfn() is simply:
   return page_to_pfn(virt_to_page(p)) << (PAGE_SHIFT - VTD_PAGE_SHIFT);

Which can be re-arranged to:
   (page_to_pfn(virt_to_page(p)) << PAGE_SHIFT) >> VTD_PAGE_SHIFT

The only caller is:
   ((uint64_t)virt_to_dma_pfn(tmp_page) << VTD_PAGE_SHIFT)

re-arranged to:
   ((page_to_pfn(virt_to_page(tmp_page)) << PAGE_SHIFT) >> VTD_PAGE_SHIFT)
           << VTD_PAGE_SHIFT

Which simplifies to:
   page_to_pfn(virt_to_page(tmp_page)) << PAGE_SHIFT

That is the same as virt_to_phys(tmp_page), so just remove all of this.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/8-v3-e797f4dc6918+93057-iommu_pages_jgg@nvidia.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c |  3 ++-
 drivers/iommu/intel/iommu.h | 19 -------------------
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 25d31f8c129a..e7152ea77393 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -737,7 +737,8 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
 				return NULL;
 
 			domain_flush_cache(domain, tmp_page, VTD_PAGE_SIZE);
-			pteval = ((uint64_t)virt_to_dma_pfn(tmp_page) << VTD_PAGE_SHIFT) | DMA_PTE_READ | DMA_PTE_WRITE;
+			pteval = virt_to_phys(tmp_page) | DMA_PTE_READ |
+				 DMA_PTE_WRITE;
 			if (domain->use_first_level)
 				pteval |= DMA_FL_PTE_US | DMA_FL_PTE_ACCESS;
 
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 6ea7bbe26b19..dd980808998d 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -953,25 +953,6 @@ static inline unsigned long lvl_to_nr_pages(unsigned int lvl)
 	return 1UL << min_t(int, (lvl - 1) * LEVEL_STRIDE, MAX_AGAW_PFN_WIDTH);
 }
 
-/* VT-d pages must always be _smaller_ than MM pages. Otherwise things
-   are never going to work. */
-static inline unsigned long mm_to_dma_pfn_start(unsigned long mm_pfn)
-{
-	return mm_pfn << (PAGE_SHIFT - VTD_PAGE_SHIFT);
-}
-static inline unsigned long mm_to_dma_pfn_end(unsigned long mm_pfn)
-{
-	return ((mm_pfn + 1) << (PAGE_SHIFT - VTD_PAGE_SHIFT)) - 1;
-}
-static inline unsigned long page_to_dma_pfn(struct page *pg)
-{
-	return mm_to_dma_pfn_start(page_to_pfn(pg));
-}
-static inline unsigned long virt_to_dma_pfn(void *p)
-{
-	return page_to_dma_pfn(virt_to_page(p));
-}
-
 static inline void context_set_present(struct context_entry *context)
 {
 	context->lo |= 1;
-- 
2.43.0


