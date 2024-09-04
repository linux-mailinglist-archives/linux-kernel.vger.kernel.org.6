Return-Path: <linux-kernel+bounces-314747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDAF96B7EE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EA781C24795
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C6F1CEEB7;
	Wed,  4 Sep 2024 10:10:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99231CC16B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 10:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725444603; cv=none; b=K3LIK6dsZ6uTcYp9AYmdEl/QnAmWFXuSKgqEob7bJuuyq4fNUCfhUN68fyLvUlwrh3tp+AXHm43W8xpb+C/go0FVpxvgqYp2H8OF4b+OPb817fyWsBB8W6SeQhcr/yYaszANMYmaeivjCRfJLzxA9+363JKEzQzKNPcAMBWXJBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725444603; c=relaxed/simple;
	bh=wdjTJ6/cIZpF1sNXD5he56c6m2NRRcUAvqeORXpl9ZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hhe6uGkJi2jvRTV0AlG05yI5UsF17o/SBIOaMYDYM3f1mx6ClMGxsLuwiThuJP1Ud/gKtRzJw5/LwR1VA54HWijtmRE709RCbfRMb21e/4Lvqs19BvwsfVFo1cZzqFsMbeOuHLpDeEt/CDdyPMORvVg8Lo3gOLjWo4f6bBAmgqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DEC1FEC;
	Wed,  4 Sep 2024 03:10:27 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.43.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9251E3F66E;
	Wed,  4 Sep 2024 03:09:52 -0700 (PDT)
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
Subject: [PATCH v2 2/2] mm: Allocate THP on hugezeropage wp-fault
Date: Wed,  4 Sep 2024 15:39:23 +0530
Message-Id: <20240904100923.290042-3-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240904100923.290042-1-dev.jain@arm.com>
References: <20240904100923.290042-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce do_huge_zero_wp_pmd() to handle wp-fault on a hugezeropage and
replace it with a PMD-mapped THP. Change the helpers introduced in the
previous patch to flush TLB entry corresponding to the hugezeropage,
and preserve PMD uffd-wp marker. In case of failure, fallback to
splitting the PMD.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 include/linux/huge_mm.h |  6 ++++
 mm/huge_memory.c        | 79 +++++++++++++++++++++++++++++++++++------
 mm/memory.c             |  5 +--
 3 files changed, 78 insertions(+), 12 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index e25d9ebfdf89..fdd2cf473a3c 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -9,6 +9,12 @@
 #include <linux/kobject.h>
 
 vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf);
+vm_fault_t thp_fault_alloc(gfp_t gfp, int order, struct vm_area_struct *vma,
+			   unsigned long haddr, struct folio **foliop,
+			   unsigned long addr);
+void map_pmd_thp(struct folio *folio, struct vm_fault *vmf,
+		 struct vm_area_struct *vma, unsigned long haddr,
+		 pgtable_t pgtable);
 int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		  pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
 		  struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 58125fbcc532..150163ad77d3 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -943,9 +943,9 @@ unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
 }
 EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
 
-static vm_fault_t thp_fault_alloc(gfp_t gfp, int order, struct vm_area_struct *vma,
-				  unsigned long haddr, struct folio **foliop,
-				  unsigned long addr)
+vm_fault_t thp_fault_alloc(gfp_t gfp, int order, struct vm_area_struct *vma,
+			   unsigned long haddr, struct folio **foliop,
+			   unsigned long addr)
 {
 	struct folio *folio = vma_alloc_folio(gfp, order, vma, haddr, true);
 
@@ -984,21 +984,29 @@ static void __thp_fault_success_stats(struct vm_area_struct *vma, int order)
 	count_memcg_event_mm(vma->vm_mm, THP_FAULT_ALLOC);
 }
 
-static void map_pmd_thp(struct folio *folio, struct vm_fault *vmf,
-			struct vm_area_struct *vma, unsigned long haddr,
-			pgtable_t pgtable)
+void map_pmd_thp(struct folio *folio, struct vm_fault *vmf,
+		 struct vm_area_struct *vma, unsigned long haddr,
+		 pgtable_t pgtable)
 {
-	pmd_t entry;
+	pmd_t entry, old_pmd;
+	bool is_pmd_none = pmd_none(*vmf->pmd);
 
 	entry = mk_huge_pmd(&folio->page, vma->vm_page_prot);
 	entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
 	folio_add_new_anon_rmap(folio, vma, haddr, RMAP_EXCLUSIVE);
 	folio_add_lru_vma(folio, vma);
-	pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
+	if (!is_pmd_none) {
+		old_pmd = pmdp_huge_clear_flush(vma, haddr, vmf->pmd);
+		if (pmd_uffd_wp(old_pmd))
+			entry = pmd_mkuffd_wp(entry);
+	}
+	if (pgtable)
+		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
 	set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
 	update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
 	add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
-	mm_inc_nr_ptes(vma->vm_mm);
+	if (is_pmd_none)
+		mm_inc_nr_ptes(vma->vm_mm);
 }
 
 static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf)
@@ -1576,6 +1584,50 @@ void huge_pmd_set_accessed(struct vm_fault *vmf)
 	spin_unlock(vmf->ptl);
 }
 
+static vm_fault_t do_huge_zero_wp_pmd_locked(struct vm_fault *vmf,
+					     unsigned long haddr,
+					     struct folio *folio)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	vm_fault_t ret = 0;
+
+	ret = check_stable_address_space(vma->vm_mm);
+	if (ret)
+		goto out;
+	map_pmd_thp(folio, vmf, vma, haddr, NULL);
+out:
+	return ret;
+}
+
+static vm_fault_t do_huge_zero_wp_pmd(struct vm_fault *vmf, unsigned long haddr)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	gfp_t gfp = vma_thp_gfp_mask(vma);
+	struct mmu_notifier_range range;
+	struct folio *folio = NULL;
+	vm_fault_t ret = 0;
+
+	ret = thp_fault_alloc(gfp, HPAGE_PMD_ORDER, vma, haddr, &folio,
+			      vmf->address);
+	if (ret)
+		goto out;
+
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma->vm_mm, haddr,
+				haddr + HPAGE_PMD_SIZE);
+	mmu_notifier_invalidate_range_start(&range);
+	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
+	if (unlikely(!pmd_same(pmdp_get(vmf->pmd), vmf->orig_pmd)))
+		goto unlock;
+	ret = do_huge_zero_wp_pmd_locked(vmf, haddr, folio);
+	if (!ret)
+		__thp_fault_success_stats(vma, HPAGE_PMD_ORDER);
+unlock:
+	spin_unlock(vmf->ptl);
+	mmu_notifier_invalidate_range_end(&range);
+out:
+	return ret;
+}
+
 vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 {
 	const bool unshare = vmf->flags & FAULT_FLAG_UNSHARE;
@@ -1588,8 +1640,15 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 	vmf->ptl = pmd_lockptr(vma->vm_mm, vmf->pmd);
 	VM_BUG_ON_VMA(!vma->anon_vma, vma);
 
-	if (is_huge_zero_pmd(orig_pmd))
+	if (is_huge_zero_pmd(orig_pmd)) {
+		vm_fault_t ret = do_huge_zero_wp_pmd(vmf, haddr);
+
+		if (!(ret & VM_FAULT_FALLBACK))
+			return ret;
+
+		/* Fallback to splitting PMD if THP cannot be allocated */
 		goto fallback;
+	}
 
 	spin_lock(vmf->ptl);
 
diff --git a/mm/memory.c b/mm/memory.c
index 3c01d68065be..c081a25f5173 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5409,9 +5409,10 @@ static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
 	if (vma_is_anonymous(vma)) {
 		if (likely(!unshare) &&
 		    userfaultfd_huge_pmd_wp(vma, vmf->orig_pmd)) {
-			if (userfaultfd_wp_async(vmf->vma))
+			if (!userfaultfd_wp_async(vmf->vma))
+				return handle_userfault(vmf, VM_UFFD_WP);
+			if (!is_huge_zero_pmd(vmf->orig_pmd))
 				goto split;
-			return handle_userfault(vmf, VM_UFFD_WP);
 		}
 		return do_huge_pmd_wp_page(vmf);
 	}
-- 
2.30.2


