Return-Path: <linux-kernel+bounces-330442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2795979E9D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 11:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A46462842A2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 09:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6EB14A0A3;
	Mon, 16 Sep 2024 09:43:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F81E1487D6
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 09:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726479839; cv=none; b=lfvJl43hom2ziRcPDfNxdOzYGa9A+GRjnA1S4qtWGhZntfQ9EhU/K5o6isKpB5IuiU8cU2Ah8+9EmKfPr1/kn5K8pfdgr3i5FZ6Jh+UPhyKRUnS8XJlGHDhGcEdGZKomfgSSj22COj8TYGK68IDJT7TNfgn+i7sZ1pkv1ZzqqTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726479839; c=relaxed/simple;
	bh=EZ0sltEDKN2sWJX1G0+hRLjUyfZizmh6hi5xxBhB2sw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rf/IWiz2jju57+J1zOEBne7YaRI1KxWwkQoj9sE5i3/ClyyUVRTgL8MqulzQzeV/5oGOamDrdMuWVlpMcJBJ1ig6ot7zyTaqVZunoqX6SmIoCAFTlmddvBAQeBibNgtLb3fPFjrGCIxGFD1YhmRgo0KD+OQzsljMH5G/HA4KSe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7918012FC;
	Mon, 16 Sep 2024 02:44:25 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.42.11])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7FB153F66E;
	Mon, 16 Sep 2024 02:43:47 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH v4 1/2] mm: Abstract THP allocation
Date: Mon, 16 Sep 2024 15:13:08 +0530
Message-Id: <20240916094309.1226908-2-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916094309.1226908-1-dev.jain@arm.com>
References: <20240916094309.1226908-1-dev.jain@arm.com>
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

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 mm/huge_memory.c | 108 +++++++++++++++++++++++++++++------------------
 1 file changed, 66 insertions(+), 42 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2a73efea02d7..cdc632b8dc9c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1146,47 +1146,88 @@ unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
 }
 EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
 
-static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
-			struct page *page, gfp_t gfp)
+static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
+					      unsigned long addr)
 {
-	struct vm_area_struct *vma = vmf->vma;
-	struct folio *folio = page_folio(page);
-	pgtable_t pgtable;
-	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
-	vm_fault_t ret = 0;
+	unsigned long haddr = addr & HPAGE_PMD_MASK;
+	gfp_t gfp = vma_thp_gfp_mask(vma);
+	const int order = HPAGE_PMD_ORDER;
+	struct folio *folio = vma_alloc_folio(gfp, order, vma, haddr, true);
 
-	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
+	if (unlikely(!folio)) {
+		count_vm_event(THP_FAULT_FALLBACK);
+		count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK);
+		goto out;
+	}
 
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
+out:
+	return folio;
+}
+
+static void __pmd_thp_fault_success_stats(struct vm_area_struct *vma)
+{
+	count_vm_event(THP_FAULT_ALLOC);
+	count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_ALLOC);
+	count_memcg_event_mm(vma->vm_mm, THP_FAULT_ALLOC);
+}
+
+static void map_anon_folio_pmd(struct folio *folio, pmd_t *pmd,
+			       struct vm_area_struct *vma, unsigned long haddr)
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
+	__pmd_thp_fault_success_stats(vma);
+}
+
+static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf)
+{
+	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
+	struct vm_area_struct *vma = vmf->vma;
+	pgtable_t pgtable = NULL;
+	struct folio *folio;
+	vm_fault_t ret = 0;
+
+	folio = vma_alloc_anon_folio_pmd(vma, vmf->address);
+	if (unlikely(!folio)) {
+		ret = VM_FAULT_FALLBACK;
+		goto release;
+	}
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
@@ -1200,21 +1241,11 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
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
@@ -1223,7 +1254,8 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 release:
 	if (pgtable)
 		pte_free(vma->vm_mm, pgtable);
-	folio_put(folio);
+	if (folio)
+		folio_put(folio);
 	return ret;
 
 }
@@ -1281,8 +1313,6 @@ static void set_huge_zero_folio(pgtable_t pgtable, struct mm_struct *mm,
 vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
-	gfp_t gfp;
-	struct folio *folio;
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
 	vm_fault_t ret;
 
@@ -1333,14 +1363,8 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
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


