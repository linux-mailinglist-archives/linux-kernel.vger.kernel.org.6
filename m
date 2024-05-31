Return-Path: <linux-kernel+bounces-196451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF92F8D5C76
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 315741F294B1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AFE8121F;
	Fri, 31 May 2024 08:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R/9WTWu1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2624B824AF
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 08:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717143189; cv=none; b=qpcQdoBpfAOJ/UZFxy6VrX177Ttoj/PmmV0SQrr+zah0nxsPZY71GCK9YLSaTZLbO6hF+QeHhF1W5DaHY/zbHhbfMIaNxCVHUjIQABlOl7C4vr7u9+X9aiy4BDm133pkqKSDRyLdQdPVnLJgSguIH0jplFYkxbUheEqrRU61rlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717143189; c=relaxed/simple;
	bh=XtM1tmkue2R/RWq0rdfSHuRCjgaKpNa2YNSgCs9L/sc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CTNmhWrcIZbADsljZdp37wqdipBJ0dVAF5K27uCicrZ/rS3zGKpyvMPVteEH718sOfOU2I+gjff+fxFlUYhXJaGSe0ILUkGBrD0/uXAPqNRXVNa4N2NbnLwQK7vIKMQSfMuVXZAciwZN6U1vjxeQE49xHpswsRGYRZJDskIQjoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R/9WTWu1; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717143188; x=1748679188;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XtM1tmkue2R/RWq0rdfSHuRCjgaKpNa2YNSgCs9L/sc=;
  b=R/9WTWu1EzTlAB+QM7FQOXTvjBF/ATXu2UeYXda6FNFHmRZqgTFHUCPR
   zW7LoPb/t+NvNXj6u6GLSKvDbIU5H7OARImkLd2pkNETaqwoPOxHMV7aQ
   FiDHDLcnD2483hjOIIMgiVqI4pMq5PelCMYCpezng6FFgd6I7teTnCN1H
   SSs0vTagduQT/m2BuElsEumNITmFLcGauHaBqZblqXj16HWCK9axbj7/O
   rIRmXU9wjuW7dALPP0aJ3OkabLmMXyZoRzRRVkuZUL8vb2y3Nf2vtMvO0
   lka+9rGYMyFUoxrfY5wtqTMCDciPU5cDksD9PJphv9/dT3hFosM+AtAZS
   w==;
X-CSE-ConnectionGUID: t0cJpyHcTo+Ho/wogisORg==
X-CSE-MsgGUID: G5IZg+DBTRO5BL4aSNvR3w==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="25079776"
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="25079776"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 01:13:08 -0700
X-CSE-ConnectionGUID: ObA5obvcTXa5rgNCCMgFCQ==
X-CSE-MsgGUID: rJElwWo5T9qLZMt+cdpi/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="59270962"
Received: from unknown (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.30.35])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 01:13:04 -0700
From: Huang Ying <ying.huang@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Huang Ying <ying.huang@intel.com>,
	Hugh Dickins <hughd@google.com>,
	Alistair Popple <apopple@nvidia.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Minchan Kim <minchan@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yang Shi <shy828301@gmail.com>,
	Yu Zhao <yuzhao@google.com>,
	Kairui Song <kasong@tencent.com>,
	Barry Song <v-songbaohua@oppo.com>,
	Chris Li <chrisl@kernel.org>,
	Yosry Ahmed <yosryahmed@google.com>
Subject: [PATCH 3/3] mm,swap: simplify VMA based swap readahead window calculation
Date: Fri, 31 May 2024 16:12:30 +0800
Message-Id: <20240531081230.310128-4-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240531081230.310128-1-ying.huang@intel.com>
References: <20240531081230.310128-1-ying.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace PFNs with addresses in readahead window calculation.  This
simplified the logic and reduce the code line number.

No functionality change is expected.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Kairui Song <kasong@tencent.com>
Cc: Barry Song <v-songbaohua@oppo.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: Yosry Ahmed <yosryahmed@google.com>
---
 mm/swap_state.c | 66 +++++++++++++++++++------------------------------
 1 file changed, 25 insertions(+), 41 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index e1dac70198a6..d2adbd7b571b 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -740,54 +740,40 @@ void exit_swap_address_space(unsigned int type)
 	swapper_spaces[type] = NULL;
 }
 
-static unsigned short swap_vma_ra_win(struct vm_fault *vmf,
-				      unsigned short *offset,
-				      unsigned short *nr_pte)
+static int swap_vma_ra_win(struct vm_fault *vmf, unsigned long *start,
+			   unsigned long *end)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	unsigned long ra_val;
-	unsigned long faddr, pfn, fpfn, lpfn, rpfn;
-	unsigned long start, end;
+	unsigned long faddr, prev_faddr, left, right;
 	unsigned int max_win, hits, prev_win, win;
 
-	max_win = 1 << min_t(unsigned int, READ_ONCE(page_cluster),
-			     SWAP_RA_ORDER_CEILING);
+	max_win = 1 << min(READ_ONCE(page_cluster), SWAP_RA_ORDER_CEILING);
 	if (max_win == 1)
 		return 1;
 
 	faddr = vmf->address;
-	fpfn = PFN_DOWN(faddr);
 	ra_val = GET_SWAP_RA_VAL(vma);
-	pfn = PFN_DOWN(SWAP_RA_ADDR(ra_val));
+	prev_faddr = SWAP_RA_ADDR(ra_val);
 	prev_win = SWAP_RA_WIN(ra_val);
 	hits = SWAP_RA_HITS(ra_val);
-	win = __swapin_nr_pages(pfn, fpfn, hits, max_win, prev_win);
-	atomic_long_set(&vma->swap_readahead_info,
-			SWAP_RA_VAL(faddr, win, 0));
+	win = __swapin_nr_pages(PFN_DOWN(prev_faddr), PFN_DOWN(faddr), hits,
+				max_win, prev_win);
+	atomic_long_set(&vma->swap_readahead_info, SWAP_RA_VAL(faddr, win, 0));
 	if (win == 1)
 		return 1;
 
-	if (fpfn == pfn + 1) {
-		lpfn = fpfn;
-		rpfn = fpfn + win;
-	} else if (pfn == fpfn + 1) {
-		lpfn = fpfn - win + 1;
-		rpfn = fpfn + 1;
-	} else {
-		unsigned int left = (win - 1) / 2;
-
-		lpfn = fpfn - left;
-		rpfn = fpfn + win - left;
-	}
-	if ((long)lpfn < 0)
-		lpfn = 0;
-	start = max3(lpfn, PFN_DOWN(vma->vm_start),
-		     PFN_DOWN(faddr & PMD_MASK));
-	end = min3(rpfn, PFN_DOWN(vma->vm_end),
-		   PFN_DOWN((faddr & PMD_MASK) + PMD_SIZE));
-
-	*nr_pte = end - start;
-	*offset = fpfn - start;
+	if (faddr == prev_faddr + PAGE_SIZE)
+		left = faddr;
+	else if (prev_faddr == faddr + PAGE_SIZE)
+		left = faddr - (win << PAGE_SHIFT) + PAGE_SIZE;
+	else
+		left = faddr - (((win - 1) / 2) << PAGE_SHIFT);
+	right = left + (win << PAGE_SHIFT);
+	if ((long)left < 0)
+		left = 0;
+	*start = max3(left, vma->vm_start, faddr & PMD_MASK);
+	*end = min3(right, vma->vm_end, (faddr & PMD_MASK) + PMD_SIZE);
 
 	return win;
 }
@@ -815,22 +801,20 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 	struct swap_iocb *splug = NULL;
 	struct folio *folio;
 	pte_t *pte = NULL, pentry;
-	unsigned long addr;
+	int win;
+	unsigned long start, end, addr;
 	swp_entry_t entry;
 	pgoff_t ilx;
-	unsigned int i;
 	bool page_allocated;
-	unsigned short win, nr_pte, offset;
 
-	win = swap_vma_ra_win(vmf, &offset, &nr_pte);
+	win = swap_vma_ra_win(vmf, &start, &end);
 	if (win == 1)
 		goto skip;
 
-	addr = vmf->address - offset * PAGE_SIZE;
-	ilx = targ_ilx - offset;
+	ilx = targ_ilx - PFN_DOWN(vmf->address - start);
 
 	blk_start_plug(&plug);
-	for (i = 0; i < nr_pte; i++, ilx++, addr += PAGE_SIZE) {
+	for (addr = start; addr < end; ilx++, addr += PAGE_SIZE) {
 		if (!pte++) {
 			pte = pte_offset_map(vmf->pmd, addr);
 			if (!pte)
@@ -850,7 +834,7 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 			continue;
 		if (page_allocated) {
 			swap_read_folio(folio, false, &splug);
-			if (i != offset) {
+			if (addr != vmf->address) {
 				folio_set_readahead(folio);
 				count_vm_event(SWAP_RA);
 			}
-- 
2.39.2


