Return-Path: <linux-kernel+bounces-435143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E05CB9E70EF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 480B6163B54
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 14:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F1E1547E7;
	Fri,  6 Dec 2024 14:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b="yJ8Im3m5"
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD481474AF
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 14:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733496566; cv=none; b=RwBMM9Q7pI4zzXNOBVqKy7ZATv3CmL8WpJMFbBpjJalPBHJ2Qf0vYOWu7vGe0Q81okzHM1dZnJPqtWntHYB3aI+NhLefSduY7X2Z/Zwo5t9amCU1fCFvHdgDqaPQML6JPUZZRCS1lYlCDw91eHBxL276xHFRTu8TRIl3M839YaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733496566; c=relaxed/simple;
	bh=+qHBNTSmW89CLLoFjMHUcVLfkLdp0ocvLoXZW5SvP3s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=C2zym/qOFNJGRpe7GZUAP1rH1w9Op2j67UJPOso0JsOc/kopoaYYam7BhxWpqFfhd8P8ArU3q+aahpMsFPKsKiFcV0MJLJLlpu3pz5kx6ehKo6PGc7Ro7tY0JdPZkUwvZGsn/3iEbn5Wjy7gtc8gnFe3yOM6E0PpI/SQo7k13WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org; spf=pass smtp.mailfrom=morinfr.org; dkim=pass (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b=yJ8Im3m5; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morinfr.org
Received: from bender.morinfr.org (unknown [82.66.66.112])
	by smtp2-g21.free.fr (Postfix) with ESMTPS id 22CA92003C3;
	Fri,  6 Dec 2024 15:49:11 +0100 (CET)
Authentication-Results: smtp2-g21.free.fr;
	dkim=pass (1024-bit key; unprotected) header.d=morinfr.org header.i=@morinfr.org header.a=rsa-sha256 header.s=20170427 header.b=yJ8Im3m5;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=morinfr.org
	; s=20170427; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=rtW+89OL3kHNY2f3ZFBSLcpZsPRLhfKsgEViwWMhwZg=; b=yJ8Im3m5RDuXNWQxJmxR93WRXI
	JH8TIUStpjIje6UtgeBZFQXmJ8R+TqI1AiDrmt/eppAyMaaNc9CMFgCd+TOhwe8UOFhNr9l/82eJj
	yjtWd6dqfFPCItc5ctxLR3ULr6zO+EM2LJNWjE7AtHubSvm8sPiOlMeWG8MPNwbnm488=;
Received: from guillaum by bender.morinfr.org with local (Exim 4.96)
	(envelope-from <guillaume@morinfr.org>)
	id 1tJZdm-002IqN-1W;
	Fri, 06 Dec 2024 15:49:10 +0100
Date: Fri, 6 Dec 2024 15:49:10 +0100
From: Guillaume Morin <guillaume@morinfr.org>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
	Eric Hagberg <ehagberg@janestreet.com>
Subject: [PATCH v4] mm/hugetlb: support FOLL_FORCE|FOLL_WRITE
Message-ID: <Z1MO5slZh8uWl8LH@bender.morinfr.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Eric reported that PTRACE_POKETEXT fails when applications use hugetlb
for mapping text using huge pages. Before commit 1d8d14641fd9
("mm/hugetlb: support write-faults in shared mappings"), PTRACE_POKETEXT
worked by accident, but it was buggy and silently ended up mapping pages
writable into the page tables even though VM_WRITE was not set.

In general, FOLL_FORCE|FOLL_WRITE does currently not work with hugetlb.
Let's implement FOLL_FORCE|FOLL_WRITE properly for hugetlb, such that
what used to work in the past by accident now properly works, allowing
applications using hugetlb for text etc. to get properly debugged.

This change might also be required to implement uprobes support for
hugetlb [1].

[1] https://lore.kernel.org/lkml/ZiK50qob9yl5e0Xz@bender.morinfr.org/

Cc: Muchun Song <muchun.song@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Eric Hagberg <ehagberg@janestreet.com>
Signed-off-by: Guillaume Morin <guillaume@morinfr.org>
---
Changes in v2:
 - Improved commit message
Changes in v3:
 - Fix potential unitialized mem access in follow_huge_pud
 - define pud_soft_dirty when soft dirty is not enabled
Changes in v4:
 - Remove the soft dirty pud check
 - Remove the pud_soft_dirty added in v3

 mm/gup.c     | 95 +++++++++++++++++++++++++---------------------------
 mm/hugetlb.c | 20 ++++++-----
 2 files changed, 57 insertions(+), 58 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 746070a1d8bf..63c705ff4162 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -587,6 +587,33 @@ static struct folio *try_grab_folio_fast(struct page *page, int refs,
 }
 #endif	/* CONFIG_HAVE_GUP_FAST */
 
+/* Common code for can_follow_write_* */
+static inline bool can_follow_write_common(struct page *page,
+		struct vm_area_struct *vma, unsigned int flags)
+{
+	/* Maybe FOLL_FORCE is set to override it? */
+	if (!(flags & FOLL_FORCE))
+		return false;
+
+	/* But FOLL_FORCE has no effect on shared mappings */
+	if (vma->vm_flags & (VM_MAYSHARE | VM_SHARED))
+		return false;
+
+	/* ... or read-only private ones */
+	if (!(vma->vm_flags & VM_MAYWRITE))
+		return false;
+
+	/* ... or already writable ones that just need to take a write fault */
+	if (vma->vm_flags & VM_WRITE)
+		return false;
+
+	/*
+	 * See can_change_pte_writable(): we broke COW and could map the page
+	 * writable if we have an exclusive anonymous page ...
+	 */
+	return page && PageAnon(page) && PageAnonExclusive(page);
+}
+
 static struct page *no_page_table(struct vm_area_struct *vma,
 				  unsigned int flags, unsigned long address)
 {
@@ -613,6 +640,18 @@ static struct page *no_page_table(struct vm_area_struct *vma,
 }
 
 #ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
+/* FOLL_FORCE can write to even unwritable PUDs in COW mappings. */
+static inline bool can_follow_write_pud(pud_t pud, struct page *page,
+					struct vm_area_struct *vma,
+					unsigned int flags)
+{
+	/* If the pud is writable, we can write to the page. */
+	if (pud_write(pud))
+		return true;
+
+	return can_follow_write_common(page, vma, flags);
+}
+
 static struct page *follow_huge_pud(struct vm_area_struct *vma,
 				    unsigned long addr, pud_t *pudp,
 				    int flags, struct follow_page_context *ctx)
@@ -625,13 +664,16 @@ static struct page *follow_huge_pud(struct vm_area_struct *vma,
 
 	assert_spin_locked(pud_lockptr(mm, pudp));
 
-	if ((flags & FOLL_WRITE) && !pud_write(pud))
+	pfn += (addr & ~PUD_MASK) >> PAGE_SHIFT;
+	page = pfn_to_page(pfn);
+
+	if ((flags & FOLL_WRITE) &&
+	    !can_follow_write_pud(pud, page, vma, flags))
 		return NULL;
 
 	if (!pud_present(pud))
 		return NULL;
 
-	pfn += (addr & ~PUD_MASK) >> PAGE_SHIFT;
 
 	if (IS_ENABLED(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD) &&
 	    pud_devmap(pud)) {
@@ -653,8 +695,6 @@ static struct page *follow_huge_pud(struct vm_area_struct *vma,
 			return ERR_PTR(-EFAULT);
 	}
 
-	page = pfn_to_page(pfn);
-
 	if (!pud_devmap(pud) && !pud_write(pud) &&
 	    gup_must_unshare(vma, flags, page))
 		return ERR_PTR(-EMLINK);
@@ -677,27 +717,7 @@ static inline bool can_follow_write_pmd(pmd_t pmd, struct page *page,
 	if (pmd_write(pmd))
 		return true;
 
-	/* Maybe FOLL_FORCE is set to override it? */
-	if (!(flags & FOLL_FORCE))
-		return false;
-
-	/* But FOLL_FORCE has no effect on shared mappings */
-	if (vma->vm_flags & (VM_MAYSHARE | VM_SHARED))
-		return false;
-
-	/* ... or read-only private ones */
-	if (!(vma->vm_flags & VM_MAYWRITE))
-		return false;
-
-	/* ... or already writable ones that just need to take a write fault */
-	if (vma->vm_flags & VM_WRITE)
-		return false;
-
-	/*
-	 * See can_change_pte_writable(): we broke COW and could map the page
-	 * writable if we have an exclusive anonymous page ...
-	 */
-	if (!page || !PageAnon(page) || !PageAnonExclusive(page))
+	if (!can_follow_write_common(page, vma, flags))
 		return false;
 
 	/* ... and a write-fault isn't required for other reasons. */
@@ -798,27 +818,7 @@ static inline bool can_follow_write_pte(pte_t pte, struct page *page,
 	if (pte_write(pte))
 		return true;
 
-	/* Maybe FOLL_FORCE is set to override it? */
-	if (!(flags & FOLL_FORCE))
-		return false;
-
-	/* But FOLL_FORCE has no effect on shared mappings */
-	if (vma->vm_flags & (VM_MAYSHARE | VM_SHARED))
-		return false;
-
-	/* ... or read-only private ones */
-	if (!(vma->vm_flags & VM_MAYWRITE))
-		return false;
-
-	/* ... or already writable ones that just need to take a write fault */
-	if (vma->vm_flags & VM_WRITE)
-		return false;
-
-	/*
-	 * See can_change_pte_writable(): we broke COW and could map the page
-	 * writable if we have an exclusive anonymous page ...
-	 */
-	if (!page || !PageAnon(page) || !PageAnonExclusive(page))
+	if (!can_follow_write_common(page, vma, flags))
 		return false;
 
 	/* ... and a write-fault isn't required for other reasons. */
@@ -1285,9 +1285,6 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 		if (!(vm_flags & VM_WRITE) || (vm_flags & VM_SHADOW_STACK)) {
 			if (!(gup_flags & FOLL_FORCE))
 				return -EFAULT;
-			/* hugetlb does not support FOLL_FORCE|FOLL_WRITE. */
-			if (is_vm_hugetlb_page(vma))
-				return -EFAULT;
 			/*
 			 * We used to let the write,force case do COW in a
 			 * VM_MAYWRITE VM_SHARED !VM_WRITE vma, so ptrace could
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ea2ed8e301ef..52517b7ce308 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5169,6 +5169,13 @@ static void set_huge_ptep_writable(struct vm_area_struct *vma,
 		update_mmu_cache(vma, address, ptep);
 }
 
+static void set_huge_ptep_maybe_writable(struct vm_area_struct *vma,
+					 unsigned long address, pte_t *ptep)
+{
+	if (vma->vm_flags & VM_WRITE)
+		set_huge_ptep_writable(vma, address, ptep);
+}
+
 bool is_hugetlb_entry_migration(pte_t pte)
 {
 	swp_entry_t swp;
@@ -5802,13 +5809,6 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
 	if (!unshare && huge_pte_uffd_wp(pte))
 		return 0;
 
-	/*
-	 * hugetlb does not support FOLL_FORCE-style write faults that keep the
-	 * PTE mapped R/O such as maybe_mkwrite() would do.
-	 */
-	if (WARN_ON_ONCE(!unshare && !(vma->vm_flags & VM_WRITE)))
-		return VM_FAULT_SIGSEGV;
-
 	/* Let's take out MAP_SHARED mappings first. */
 	if (vma->vm_flags & VM_MAYSHARE) {
 		set_huge_ptep_writable(vma, vmf->address, vmf->pte);
@@ -5837,7 +5837,8 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
 			SetPageAnonExclusive(&old_folio->page);
 		}
 		if (likely(!unshare))
-			set_huge_ptep_writable(vma, vmf->address, vmf->pte);
+			set_huge_ptep_maybe_writable(vma, vmf->address,
+						     vmf->pte);
 
 		delayacct_wpcopy_end();
 		return 0;
@@ -5943,7 +5944,8 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
 	spin_lock(vmf->ptl);
 	vmf->pte = hugetlb_walk(vma, vmf->address, huge_page_size(h));
 	if (likely(vmf->pte && pte_same(huge_ptep_get(mm, vmf->address, vmf->pte), pte))) {
-		pte_t newpte = make_huge_pte(vma, &new_folio->page, !unshare);
+		const bool writable = !unshare && (vma->vm_flags & VM_WRITE);
+		pte_t newpte = make_huge_pte(vma, &new_folio->page, writable);
 
 		/* Break COW or unshare */
 		huge_ptep_clear_flush(vma, vmf->address, vmf->pte);
-- 
2.39.1

-- 
Guillaume Morin <guillaume@morinfr.org>

