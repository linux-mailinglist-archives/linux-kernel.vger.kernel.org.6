Return-Path: <linux-kernel+bounces-431987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E6F9E4383
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2940928418F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E79B1A8F78;
	Wed,  4 Dec 2024 18:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b="lNCeQ97y"
Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69E326AFC
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 18:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733337418; cv=none; b=bJ8iWd4itZHzlo5k1cO/8CQFn8b2rwtPg01fA7oD4sIJCHtlQ5EqwXpePfGXe/sp95ciDg4Q4RjbARwhWwlYw9KVSrD8x18BU/2FhAikf3uKObdIC6aowNbcH5iSz84fRtdVKTcNsvVAdsEJW5qR5Jp/RzHrwf5/aEhY/EE0kcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733337418; c=relaxed/simple;
	bh=ghiLoX07RTWfnSswfnotD0Xe2MhLm/GNs/JREtKPCBc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UGMeDAE2Feg7Dva5z0aQmw/I0jDNySevsEV7Wf2pC754DlQ7jo+fJDQxUxD5XqZ38pIl8qnsM7dlvo4DBaNcQYzJKtiZX9RwM9tPOTKpT4HJU/Pad9pfX0m5b3mx/1HBkbHNxJiyOzpoBlJfz2AvpCobeTo6FI57avq+1R2e/3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org; spf=pass smtp.mailfrom=morinfr.org; dkim=pass (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b=lNCeQ97y; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morinfr.org
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 0C64E6B9FD7
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 19:27:06 +0100 (CET)
Received: from bender.morinfr.org (unknown [82.66.66.112])
	by smtp2-g21.free.fr (Postfix) with ESMTPS id 2E1E62003F7;
	Wed,  4 Dec 2024 19:26:51 +0100 (CET)
Authentication-Results: smtp2-g21.free.fr;
	dkim=pass (1024-bit key; unprotected) header.d=morinfr.org header.i=@morinfr.org header.a=rsa-sha256 header.s=20170427 header.b=lNCeQ97y;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=morinfr.org
	; s=20170427; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=XvkApVkGOyr97+SFFARJioI95kRCf5IOchx6oG1WUzc=; b=lNCeQ97yoKFTCy0Q32IPzldTmr
	3vNGQf3sQ8esD/GOX/xB74hAovnS0r4FvI3xVZtYUrXnkVPADymVDQ36d1UvO/rOoNEGvujgJgTlN
	9jt7Luo5Q2wVwNk4u9bWuGqJZauX69cXWPJOcTKhK28ZSSdtrWruRjm9quC0PPdaZQCE=;
Received: from guillaum by bender.morinfr.org with local (Exim 4.96)
	(envelope-from <guillaume@morinfr.org>)
	id 1tIu5K-00156h-1R;
	Wed, 04 Dec 2024 19:26:50 +0100
Date: Wed, 4 Dec 2024 19:26:50 +0100
From: Guillaume Morin <guillaume@morinfr.org>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, guillaume@morinfr.org,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
	Eric Hagberg <ehagberg@janestreet.com>
Subject: [PATCH v1] hugetlb: support FOLL_FORCE|FOLL_WRITE
Message-ID: <Z1Ce6j5WiBE3kaGf@bender.morinfr.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

FOLL_FORCE|FOLL_WRITE has never been properly supported for hugetlb
mappings.  Since 1d8d14641fd94, we explicitly reject it. However
running software on hugetlb mappings is a useful optimization.
Multiple tools allow to use that such as Intel iodlr or
libhugetlbfs.

Cc: Muchun Song <muchun.song@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Eric Hagberg <ehagberg@janestreet.com>
Signed-off-by: Guillaume Morin <guillaume@morinfr.org>
---
 mm/gup.c     | 93 ++++++++++++++++++++++++++--------------------------
 mm/hugetlb.c | 20 ++++++-----
 2 files changed, 58 insertions(+), 55 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 746070a1d8bf..c680edf33248 100644
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
@@ -613,6 +640,22 @@ static struct page *no_page_table(struct vm_area_struct *vma,
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
+	if (!can_follow_write_common(page, vma, flags))
+		return false;
+
+	/* ... and a write-fault isn't required for other reasons. */
+	return !vma_soft_dirty_enabled(vma) || pud_soft_dirty(pud);
+}
+
 static struct page *follow_huge_pud(struct vm_area_struct *vma,
 				    unsigned long addr, pud_t *pudp,
 				    int flags, struct follow_page_context *ctx)
@@ -625,7 +668,8 @@ static struct page *follow_huge_pud(struct vm_area_struct *vma,
 
 	assert_spin_locked(pud_lockptr(mm, pudp));
 
-	if ((flags & FOLL_WRITE) && !pud_write(pud))
+	if ((flags & FOLL_WRITE) &&
+	    !can_follow_write_pud(pud, page, vma, flags))
 		return NULL;
 
 	if (!pud_present(pud))
@@ -677,27 +721,7 @@ static inline bool can_follow_write_pmd(pmd_t pmd, struct page *page,
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
@@ -798,27 +822,7 @@ static inline bool can_follow_write_pte(pte_t pte, struct page *page,
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
@@ -1285,9 +1289,6 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
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

