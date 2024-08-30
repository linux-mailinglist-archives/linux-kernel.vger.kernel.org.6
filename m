Return-Path: <linux-kernel+bounces-308346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 247B1965A98
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 493BE1C21C4E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9636F16DC24;
	Fri, 30 Aug 2024 08:42:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ABF16726E
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725007337; cv=none; b=HD6vZ14x2vy4lMgfvuQCEddCXpEnp9Iq1cDqs5lIs9v/QCLy3ksNKIroet5WgOJgKEhWHidlLRylkEMqaKRDLlP19KLzm+EugkkzPq5W/qeZreEb14VTaFauXWJp9E4dQyrxjkETKZEa50fBgz9gWGFeoxWVFKD8y95Mwm0obL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725007337; c=relaxed/simple;
	bh=yqZR4d6sfB78SV6nbnnsR9ZhRGZccqnOa0XipqdioF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bx2/J4Zi1ul4MTSV2YeSGu9NWmvDGAlZpzmQaGbl1Td0t+4sKOaa3Ke3qFQ7DPNBjZ5yK69srlYrhMcjKYGqsU+/vCODLZJ0hJ5bcYdzYuCzZKTz5UJ7K547ld4DBOrrqMCXFXtVzLpxdfHHYCMTjWqu995JYYDrq///Ah500uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A87481063;
	Fri, 30 Aug 2024 01:42:40 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.40.24])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 249723F762;
	Fri, 30 Aug 2024 01:42:05 -0700 (PDT)
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
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH 1/2] mm: Abstract THP allocation
Date: Fri, 30 Aug 2024 14:11:16 +0530
Message-Id: <20240830084117.4079805-2-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830084117.4079805-1-dev.jain@arm.com>
References: <20240830084117.4079805-1-dev.jain@arm.com>
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

There should be no functional change as a result of applying
this patch.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 mm/huge_memory.c | 113 +++++++++++++++++++++++++++++------------------
 1 file changed, 69 insertions(+), 44 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 67c86a5d64a6..e5b568e2bb34 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -943,47 +943,92 @@ unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
 }
 EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
 
-static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
-			struct page *page, gfp_t gfp)
+static vm_fault_t thp_fault_alloc(gfp_t gfp, int order, struct vm_area_struct *vma,
+				  unsigned long haddr, struct folio **foliop,
+				  unsigned long addr)
 {
-	struct vm_area_struct *vma = vmf->vma;
-	struct folio *folio = page_folio(page);
-	pgtable_t pgtable;
-	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
-	vm_fault_t ret = 0;
+	struct folio *folio = vma_alloc_folio(gfp, order, vma, haddr, true);
 
-	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
+	*foliop = folio;
+	if (unlikely(!folio)) {
+		count_vm_event(THP_FAULT_FALLBACK);
+		count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK);
+		return VM_FAULT_FALLBACK;
+	}
 
+	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
 	if (mem_cgroup_charge(folio, vma->vm_mm, gfp)) {
 		folio_put(folio);
 		count_vm_event(THP_FAULT_FALLBACK);
 		count_vm_event(THP_FAULT_FALLBACK_CHARGE);
-		count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_FALLBACK);
-		count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
+		count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK);
+		count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
 		return VM_FAULT_FALLBACK;
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
+	return 0;
+}
+
+static void __thp_fault_success_stats(struct vm_area_struct *vma, int order)
+{
+	count_vm_event(THP_FAULT_ALLOC);
+	count_mthp_stat(order, MTHP_STAT_ANON_FAULT_ALLOC);
+	count_memcg_event_mm(vma->vm_mm, THP_FAULT_ALLOC);
+}
+
+static void map_pmd_thp(struct folio *folio, struct vm_fault *vmf,
+			struct vm_area_struct *vma, unsigned long haddr,
+			pgtable_t pgtable)
+	__releases(vmf->ptl)
+{
+	pmd_t entry;
+
+	entry = mk_huge_pmd(&folio->page, vma->vm_page_prot);
+	entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
+	folio_add_new_anon_rmap(folio, vma, haddr, RMAP_EXCLUSIVE);
+	folio_add_lru_vma(folio, vma);
+	pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
+	set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
+	update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
+	add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
+	mm_inc_nr_ptes(vma->vm_mm);
+	spin_unlock(vmf->ptl);
+	__thp_fault_success_stats(vma, HPAGE_PMD_ORDER);
+}
+
+static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct folio *folio = NULL;
+	pgtable_t pgtable;
+	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
+	vm_fault_t ret = 0;
+	gfp_t gfp = vma_thp_gfp_mask(vma);
+
+	pgtable = pte_alloc_one(vma->vm_mm);
+	if (unlikely(!pgtable)) {
+		ret = VM_FAULT_OOM;
+		goto release;
+	}
+
+	ret = thp_fault_alloc(gfp, HPAGE_PMD_ORDER, vma, haddr, &folio,
+			      vmf->address);
+	if (ret)
+		goto release;
 
 	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
+
 	if (unlikely(!pmd_none(*vmf->pmd))) {
 		goto unlock_release;
 	} else {
-		pmd_t entry;
-
 		ret = check_stable_address_space(vma->vm_mm);
 		if (ret)
 			goto unlock_release;
@@ -997,20 +1042,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 			VM_BUG_ON(ret & VM_FAULT_FALLBACK);
 			return ret;
 		}
-
-		entry = mk_huge_pmd(page, vma->vm_page_prot);
-		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
-		folio_add_new_anon_rmap(folio, vma, haddr, RMAP_EXCLUSIVE);
-		folio_add_lru_vma(folio, vma);
-		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
-		set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
-		update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
-		add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
-		mm_inc_nr_ptes(vma->vm_mm);
-		spin_unlock(vmf->ptl);
-		count_vm_event(THP_FAULT_ALLOC);
-		count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_ALLOC);
-		count_memcg_event_mm(vma->vm_mm, THP_FAULT_ALLOC);
+		map_pmd_thp(folio, vmf, vma, haddr, pgtable);
 	}
 
 	return 0;
@@ -1019,7 +1051,8 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 release:
 	if (pgtable)
 		pte_free(vma->vm_mm, pgtable);
-	folio_put(folio);
+	if (folio)
+		folio_put(folio);
 	return ret;
 
 }
@@ -1077,8 +1110,6 @@ static void set_huge_zero_folio(pgtable_t pgtable, struct mm_struct *mm,
 vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
-	gfp_t gfp;
-	struct folio *folio;
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
 	vm_fault_t ret;
 
@@ -1129,14 +1160,8 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
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


