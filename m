Return-Path: <linux-kernel+bounces-196450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFBD8D5C74
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CF9E1F294B0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44ACD82499;
	Fri, 31 May 2024 08:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fJMqoplf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41EF80631
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 08:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717143185; cv=none; b=VbmgNVOTFt/UQMoT2plxJ3KXaeXvf490O2mEFv3oqLuoH/N8IRH773yCrJao4RFanEqUoLOkbUPAGkG7JyHQO65kRunzOYj+BDHie5UlfcFqAqF78c2aIqO2TcXfzIwGZwvbhvQpXelvlUl1gYXp0c3hduuO59AlW9omeF/i/ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717143185; c=relaxed/simple;
	bh=DJJ27LGVAKyFkd3DhLbHS54xSb3Z7Ev5IjhsRkqv+7A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GN4uQA6+gEyB4y9Yc0WMDf/MnvMc2SoTecbUqAs59qKdeDIi88nm6BbbpC33XEA5E18O1svxJzCVIg6AvKWNO6lbjPbhYn+shPIRMbKB0X7dGQPYPAbOX+19X8JoEftxe+wE7bYHYGMN8R1+KKGN/qMHQzGyVO4yICD3mR9fEMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fJMqoplf; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717143184; x=1748679184;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DJJ27LGVAKyFkd3DhLbHS54xSb3Z7Ev5IjhsRkqv+7A=;
  b=fJMqoplfzShj4bhcxBehWuDO8KnCqnXDPK1se6e354obd2sMyeCSy+yK
   JvZ1Sn1yqQXHAE+Ej9T0YuF9JhQMGfu7YLGpaGU7HtLyTrmL6YugN3I3T
   O82Bz+eELkmiHejpDSNJJv2j1u7X29sZ04vjrx/usvEhSfksh1wpwQSYC
   8IgBdBctcL4+hJ3Qu5E7i4PY1JD4OPyBf1+CPA9mvoisdjC07RAiJ8tQZ
   mD5q1PBQJSXCKk5w6X9h0e6e7hjTpGbqwZ0XSQ21iGszR0+c+LzL97P7h
   nK5GmeOxHW2vxOFVzDSa6+Zzy0nrtJkVSEtFd0h68EQmKhqwx4jzkINGi
   A==;
X-CSE-ConnectionGUID: Z+Xz2MPiTvq1cKppoeMB4A==
X-CSE-MsgGUID: cU36IxCNT5al3YICTo8EDw==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="25079761"
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="25079761"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 01:13:03 -0700
X-CSE-ConnectionGUID: Aoj6Nli8Q8y4dEyZsXEN8g==
X-CSE-MsgGUID: OoElfOprR362hwmdpIgRUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="59270947"
Received: from unknown (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.30.35])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 01:12:59 -0700
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
Subject: [PATCH 2/3] mm,swap: remove struct vma_swap_readahead
Date: Fri, 31 May 2024 16:12:29 +0800
Message-Id: <20240531081230.310128-3-ying.huang@intel.com>
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

When VMA based swap readahead is introduced in commit
ec560175c0b6 ("mm, swap: VMA based swap readahead"), "struct
vma_swap_readahead" is defined to describe the readahead window.
Because we wanted to save the PTE entries in the struct at that time.
But after commit 4f8fcf4ced0b ("mm/swap: swap_vma_readahead() do the
pte_offset_map()"), we no longer save PTE entries in the struct.  The
size of the struct becomes so small, that it's better to use the
fields of the struct directly.  This can simplify the code to improve
the code readability.  The line number of source code reduces too.

No functionality change is expected in this patch.

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
 mm/swap_state.c | 48 ++++++++++++++++++++----------------------------
 1 file changed, 20 insertions(+), 28 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 848c167df530..e1dac70198a6 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -42,6 +42,8 @@ struct address_space *swapper_spaces[MAX_SWAPFILES] __read_mostly;
 static unsigned int nr_swapper_spaces[MAX_SWAPFILES] __read_mostly;
 static bool enable_vma_readahead __read_mostly = true;
 
+#define SWAP_RA_ORDER_CEILING	5
+
 #define SWAP_RA_WIN_SHIFT	(PAGE_SHIFT / 2)
 #define SWAP_RA_HITS_MASK	((1UL << SWAP_RA_WIN_SHIFT) - 1)
 #define SWAP_RA_HITS_MAX	SWAP_RA_HITS_MASK
@@ -738,16 +740,9 @@ void exit_swap_address_space(unsigned int type)
 	swapper_spaces[type] = NULL;
 }
 
-#define SWAP_RA_ORDER_CEILING	5
-
-struct vma_swap_readahead {
-	unsigned short win;
-	unsigned short offset;
-	unsigned short nr_pte;
-};
-
-static void swap_ra_info(struct vm_fault *vmf,
-			 struct vma_swap_readahead *ra_info)
+static unsigned short swap_vma_ra_win(struct vm_fault *vmf,
+				      unsigned short *offset,
+				      unsigned short *nr_pte)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	unsigned long ra_val;
@@ -757,10 +752,8 @@ static void swap_ra_info(struct vm_fault *vmf,
 
 	max_win = 1 << min_t(unsigned int, READ_ONCE(page_cluster),
 			     SWAP_RA_ORDER_CEILING);
-	if (max_win == 1) {
-		ra_info->win = 1;
-		return;
-	}
+	if (max_win == 1)
+		return 1;
 
 	faddr = vmf->address;
 	fpfn = PFN_DOWN(faddr);
@@ -768,12 +761,11 @@ static void swap_ra_info(struct vm_fault *vmf,
 	pfn = PFN_DOWN(SWAP_RA_ADDR(ra_val));
 	prev_win = SWAP_RA_WIN(ra_val);
 	hits = SWAP_RA_HITS(ra_val);
-	ra_info->win = win = __swapin_nr_pages(pfn, fpfn, hits,
-					       max_win, prev_win);
+	win = __swapin_nr_pages(pfn, fpfn, hits, max_win, prev_win);
 	atomic_long_set(&vma->swap_readahead_info,
 			SWAP_RA_VAL(faddr, win, 0));
 	if (win == 1)
-		return;
+		return 1;
 
 	if (fpfn == pfn + 1) {
 		lpfn = fpfn;
@@ -794,8 +786,10 @@ static void swap_ra_info(struct vm_fault *vmf,
 	end = min3(rpfn, PFN_DOWN(vma->vm_end),
 		   PFN_DOWN((faddr & PMD_MASK) + PMD_SIZE));
 
-	ra_info->nr_pte = end - start;
-	ra_info->offset = fpfn - start;
+	*nr_pte = end - start;
+	*offset = fpfn - start;
+
+	return win;
 }
 
 /**
@@ -826,19 +820,17 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 	pgoff_t ilx;
 	unsigned int i;
 	bool page_allocated;
-	struct vma_swap_readahead ra_info = {
-		.win = 1,
-	};
+	unsigned short win, nr_pte, offset;
 
-	swap_ra_info(vmf, &ra_info);
-	if (ra_info.win == 1)
+	win = swap_vma_ra_win(vmf, &offset, &nr_pte);
+	if (win == 1)
 		goto skip;
 
-	addr = vmf->address - (ra_info.offset * PAGE_SIZE);
-	ilx = targ_ilx - ra_info.offset;
+	addr = vmf->address - offset * PAGE_SIZE;
+	ilx = targ_ilx - offset;
 
 	blk_start_plug(&plug);
-	for (i = 0; i < ra_info.nr_pte; i++, ilx++, addr += PAGE_SIZE) {
+	for (i = 0; i < nr_pte; i++, ilx++, addr += PAGE_SIZE) {
 		if (!pte++) {
 			pte = pte_offset_map(vmf->pmd, addr);
 			if (!pte)
@@ -858,7 +850,7 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 			continue;
 		if (page_allocated) {
 			swap_read_folio(folio, false, &splug);
-			if (i != ra_info.offset) {
+			if (i != offset) {
 				folio_set_readahead(folio);
 				count_vm_event(SWAP_RA);
 			}
-- 
2.39.2


