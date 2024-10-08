Return-Path: <linux-kernel+bounces-354527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A39DB993EA6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310FA1F2549B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 06:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32ABF13D601;
	Tue,  8 Oct 2024 06:18:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52DE13AA47
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 06:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728368300; cv=none; b=tScrLfrQYBNSYkJWVGwsG2hbuzCx/b6kjrXEUxkN9Cpsm7qTffqGAnGdNKltQ+WvJth0FSacuRwrzVIHARjeE/0q0tqd7MSfRY+a3uN7I8aHkkHVFsoR09j9y93AQXyzFbkC7BGLlo4o8BNQMnxnzhv/avZTFH/lO6k6OisfR0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728368300; c=relaxed/simple;
	bh=aL3Dc0Qya4abn7P46D37+Ebc6vndufk/+I0SS47hIrU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LcwaOr406Llt3FnrAdc49VBlqKtbji+O2Hndg3AU3SX6JT3UUZw9rQSY7Nmap8hdZdwTAClg4gLLV/as2N823sYUN9U39jxFB3RgX/4ogb/yzrkc0lNW9uTtv1FHQKn9bUOMJ8a+g+xazu/giTfxl42hdwrR4spTCw47Mh/1qrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C483FEC;
	Mon,  7 Oct 2024 23:18:45 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.43.142])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 168493F73F;
	Mon,  7 Oct 2024 23:18:06 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	willy@infradead.org,
	kirill.shutemov@linux.intel.com
Cc: ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	catalin.marinas@arm.com,
	cl@gentwo.org,
	vbabka@suse.cz,
	mhocko@suse.com,
	apopple@nvidia.com,
	dave.hansen@linux.intel.com,
	will@kernel.org,
	baohua@kernel.org,
	jack@suse.cz,
	mark.rutland@arm.com,
	hughd@google.com,
	aneesh.kumar@kernel.org,
	yang@os.amperecomputing.com,
	peterx@redhat.com,
	ioworker0@gmail.com,
	jglisse@google.com,
	wangkefeng.wang@huawei.com,
	ziy@nvidia.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH v7 1/2] mm: Abstract THP allocation
Date: Tue,  8 Oct 2024 11:47:45 +0530
Message-Id: <20241008061746.285961-2-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008061746.285961-1-dev.jain@arm.com>
References: <20241008061746.285961-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for the second patch, abstract away the THP allocation
logic present in the create_huge_pmd() path, which corresponds to the
faulting case when no page is present.

There should be no functional change as a result of applying this patch,
except that, as David notes at [1], a PMD-aligned address should
be passed to update_mmu_cache_pmd().

[1]: https://lore.kernel.org/all/ddd3fcd2-48b3-4170-bcaa-2fe66e093f43@redhat.com/

Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com> 
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 mm/huge_memory.c | 98 ++++++++++++++++++++++++++++--------------------
 1 file changed, 57 insertions(+), 41 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 3ca89e0279a7..e21c4f759e00 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1148,47 +1148,81 @@ unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
 }
 EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
 
-static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
-			struct page *page, gfp_t gfp)
+static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
+		unsigned long addr)
 {
-	struct vm_area_struct *vma = vmf->vma;
-	struct folio *folio = page_folio(page);
-	pgtable_t pgtable;
-	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
-	vm_fault_t ret = 0;
+	gfp_t gfp = vma_thp_gfp_mask(vma);
+	const int order = HPAGE_PMD_ORDER;
+	struct folio *folio;
 
-	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
+	folio = vma_alloc_folio(gfp, order, vma, addr & HPAGE_PMD_MASK, true);
 
+	if (unlikely(!folio)) {
+		count_vm_event(THP_FAULT_FALLBACK);
+		count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK);
+		return NULL;
+	}
+
+	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
 	if (mem_cgroup_charge(folio, vma->vm_mm, gfp)) {
 		folio_put(folio);
 		count_vm_event(THP_FAULT_FALLBACK);
 		count_vm_event(THP_FAULT_FALLBACK_CHARGE);
-		count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_FALLBACK);
-		count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
-		return VM_FAULT_FALLBACK;
+		count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK);
+		count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
+		return NULL;
 	}
 	folio_throttle_swaprate(folio, gfp);
 
-	pgtable = pte_alloc_one(vma->vm_mm);
-	if (unlikely(!pgtable)) {
-		ret = VM_FAULT_OOM;
-		goto release;
-	}
-
-	folio_zero_user(folio, vmf->address);
+	folio_zero_user(folio, addr);
 	/*
 	 * The memory barrier inside __folio_mark_uptodate makes sure that
 	 * folio_zero_user writes become visible before the set_pmd_at()
 	 * write.
 	 */
 	__folio_mark_uptodate(folio);
+	return folio;
+}
+
+static void map_anon_folio_pmd(struct folio *folio, pmd_t *pmd,
+		struct vm_area_struct *vma, unsigned long haddr)
+{
+	pmd_t entry;
+
+	entry = mk_huge_pmd(&folio->page, vma->vm_page_prot);
+	entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
+	folio_add_new_anon_rmap(folio, vma, haddr, RMAP_EXCLUSIVE);
+	folio_add_lru_vma(folio, vma);
+	set_pmd_at(vma->vm_mm, haddr, pmd, entry);
+	update_mmu_cache_pmd(vma, haddr, pmd);
+	add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
+	count_vm_event(THP_FAULT_ALLOC);
+	count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_ALLOC);
+	count_memcg_event_mm(vma->vm_mm, THP_FAULT_ALLOC);
+}
+
+static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf)
+{
+	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
+	struct vm_area_struct *vma = vmf->vma;
+	struct folio *folio;
+	pgtable_t pgtable;
+	vm_fault_t ret = 0;
+
+	folio = vma_alloc_anon_folio_pmd(vma, vmf->address);
+	if (unlikely(!folio))
+		return VM_FAULT_FALLBACK;
+
+	pgtable = pte_alloc_one(vma->vm_mm);
+	if (unlikely(!pgtable)) {
+		ret = VM_FAULT_OOM;
+		goto release;
+	}
 
 	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
 	if (unlikely(!pmd_none(*vmf->pmd))) {
 		goto unlock_release;
 	} else {
-		pmd_t entry;
-
 		ret = check_stable_address_space(vma->vm_mm);
 		if (ret)
 			goto unlock_release;
@@ -1202,21 +1236,11 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 			VM_BUG_ON(ret & VM_FAULT_FALLBACK);
 			return ret;
 		}
-
-		entry = mk_huge_pmd(page, vma->vm_page_prot);
-		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
-		folio_add_new_anon_rmap(folio, vma, haddr, RMAP_EXCLUSIVE);
-		folio_add_lru_vma(folio, vma);
 		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
-		set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
-		update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
-		add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
+		map_anon_folio_pmd(folio, vmf->pmd, vma, haddr);
 		mm_inc_nr_ptes(vma->vm_mm);
 		deferred_split_folio(folio, false);
 		spin_unlock(vmf->ptl);
-		count_vm_event(THP_FAULT_ALLOC);
-		count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_ALLOC);
-		count_memcg_event_mm(vma->vm_mm, THP_FAULT_ALLOC);
 	}
 
 	return 0;
@@ -1283,8 +1307,6 @@ static void set_huge_zero_folio(pgtable_t pgtable, struct mm_struct *mm,
 vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
-	gfp_t gfp;
-	struct folio *folio;
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
 	vm_fault_t ret;
 
@@ -1335,14 +1357,8 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 		}
 		return ret;
 	}
-	gfp = vma_thp_gfp_mask(vma);
-	folio = vma_alloc_folio(gfp, HPAGE_PMD_ORDER, vma, haddr, true);
-	if (unlikely(!folio)) {
-		count_vm_event(THP_FAULT_FALLBACK);
-		count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_FALLBACK);
-		return VM_FAULT_FALLBACK;
-	}
-	return __do_huge_pmd_anonymous_page(vmf, &folio->page, gfp);
+
+	return __do_huge_pmd_anonymous_page(vmf);
 }
 
 static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
-- 
2.30.2


