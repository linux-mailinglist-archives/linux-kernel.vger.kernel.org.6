Return-Path: <linux-kernel+bounces-262543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CE493C870
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 20:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA3C11F222A5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 18:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41714206D;
	Thu, 25 Jul 2024 18:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GDKOfJrc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A665589C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 18:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721932809; cv=none; b=VWCEa/CDDgynu3wgMW303t5j0FngH7OQRwSaGX83qFYF2zEoRt+h1f8GDO4WUuVJOJ+81N0V8bEmYi/NlJ9x/uSJpbWKiwHv1/B/6UrVwtjrVt0GCRgajzFoAruxDDh5MEoJY3X+pyvG/nITx7xiD3CRE5k5ZrzoFPBA4e6CTlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721932809; c=relaxed/simple;
	bh=Tctn0MuCNk+fsLWl4IQesZKWhGxVgSFeVvBsxQEWM2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pUvw/OPeCwXHaFVd6lnzyEe1wrJ4ISsxz56N6M9kn4oGvqxHa97ZNvApJoGu9tE+VWy6Ou02jVXMLDBJmBtDYyN/wrL8rSYWYewgqGQvmBIkuBFqEOofYKD869k211Suk8r7YCCSlJrd41CHqVmoLkJL6VHEmaMx90YF0m30Fe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GDKOfJrc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721932806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0GBJcFAyEp9mKlk4wzFAOdvBBpNCX3Bqc7ZE541ACRk=;
	b=GDKOfJrcejmm5+zUcQYVw84T7AWPhMdyJ1YZ+pfrAMt7TBSXig1aeH4EKNEhAWs3iDEfSr
	qlNloUsRy6a/p2K8C4gDu6VOsEQa2ebksZy4yzTmcHWcZDGuWJfi9ZOUDBnFa9PC1hFOiq
	sLksuxEa3bqgS4dfVh1H8zTMCWF5qaI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-267-7vvkrTFxPby5uIbRmNc9xQ-1; Thu,
 25 Jul 2024 14:40:04 -0400
X-MC-Unique: 7vvkrTFxPby5uIbRmNc9xQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 39CAE1955D60;
	Thu, 25 Jul 2024 18:40:03 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.30])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 496791955D42;
	Thu, 25 Jul 2024 18:39:59 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Peter Xu <peterx@redhat.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v1 1/2] mm: let pte_lockptr() consume a pte_t pointer
Date: Thu, 25 Jul 2024 20:39:54 +0200
Message-ID: <20240725183955.2268884-2-david@redhat.com>
In-Reply-To: <20240725183955.2268884-1-david@redhat.com>
References: <20240725183955.2268884-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

pte_lockptr() is the only *_lockptr() function that doesn't consume
what would be expected: it consumes a pmd_t pointer instead of a pte_t
pointer.

Let's change that. The two callers in pgtable-generic.c are easily
adjusted. Adjust khugepaged.c:retract_page_tables() to simply do a
pte_offset_map_nolock() to obtain the lock, even though we won't actually
be traversing the page table.

This makes the code more similar to the other variants and avoids other
hacks to make the new pte_lockptr() version happy. pte_lockptr() users
reside now only in  pgtable-generic.c.

Maybe, using pte_offset_map_nolock() is the right thing to do because
the PTE table could have been removed in the meantime? At least it sounds
more future proof if we ever have other means of page table reclaim.

It's not quite clear if holding the PTE table lock is really required:
what if someone else obtains the lock just after we unlock it? But we'll
leave that as is for now, maybe there are good reasons.

This is a preparation for adapting hugetlb page table locking logic to
take the same locks as core-mm page table walkers would.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h   |  7 ++++---
 mm/khugepaged.c      | 21 +++++++++++++++------
 mm/pgtable-generic.c |  4 ++--
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2c6ccf088c7be..0472a5090b180 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2873,9 +2873,10 @@ static inline spinlock_t *ptlock_ptr(struct ptdesc *ptdesc)
 }
 #endif /* ALLOC_SPLIT_PTLOCKS */
 
-static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
+static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pte_t *pte)
 {
-	return ptlock_ptr(page_ptdesc(pmd_page(*pmd)));
+	/* PTE page tables don't currently exceed a single page. */
+	return ptlock_ptr(virt_to_ptdesc(pte));
 }
 
 static inline bool ptlock_init(struct ptdesc *ptdesc)
@@ -2898,7 +2899,7 @@ static inline bool ptlock_init(struct ptdesc *ptdesc)
 /*
  * We use mm->page_table_lock to guard all pagetable pages of the mm.
  */
-static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
+static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pte_t *pte)
 {
 	return &mm->page_table_lock;
 }
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index cdd1d8655a76b..f3b3db1046155 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1697,12 +1697,13 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 	i_mmap_lock_read(mapping);
 	vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff) {
 		struct mmu_notifier_range range;
+		bool retracted = false;
 		struct mm_struct *mm;
 		unsigned long addr;
 		pmd_t *pmd, pgt_pmd;
 		spinlock_t *pml;
 		spinlock_t *ptl;
-		bool skipped_uffd = false;
+		pte_t *pte;
 
 		/*
 		 * Check vma->anon_vma to exclude MAP_PRIVATE mappings that
@@ -1739,9 +1740,17 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 		mmu_notifier_invalidate_range_start(&range);
 
 		pml = pmd_lock(mm, pmd);
-		ptl = pte_lockptr(mm, pmd);
+
+		/*
+		 * No need to check the PTE table content, but we'll grab the
+		 * PTE table lock while we zap it.
+		 */
+		pte = pte_offset_map_nolock(mm, pmd, addr, &ptl);
+		if (!pte)
+			goto unlock_pmd;
 		if (ptl != pml)
 			spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
+		pte_unmap(pte);
 
 		/*
 		 * Huge page lock is still held, so normally the page table
@@ -1752,20 +1761,20 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 		 * repeating the anon_vma check protects from one category,
 		 * and repeating the userfaultfd_wp() check from another.
 		 */
-		if (unlikely(vma->anon_vma || userfaultfd_wp(vma))) {
-			skipped_uffd = true;
-		} else {
+		if (likely(!vma->anon_vma && !userfaultfd_wp(vma))) {
 			pgt_pmd = pmdp_collapse_flush(vma, addr, pmd);
 			pmdp_get_lockless_sync();
+			retracted = true;
 		}
 
 		if (ptl != pml)
 			spin_unlock(ptl);
+unlock_pmd:
 		spin_unlock(pml);
 
 		mmu_notifier_invalidate_range_end(&range);
 
-		if (!skipped_uffd) {
+		if (retracted) {
 			mm_dec_nr_ptes(mm);
 			page_table_check_pte_clear_range(mm, addr, pgt_pmd);
 			pte_free_defer(mm, pmd_pgtable(pgt_pmd));
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index a78a4adf711ac..13a7705df3f87 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -313,7 +313,7 @@ pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd,
 
 	pte = __pte_offset_map(pmd, addr, &pmdval);
 	if (likely(pte))
-		*ptlp = pte_lockptr(mm, &pmdval);
+		*ptlp = pte_lockptr(mm, pte);
 	return pte;
 }
 
@@ -371,7 +371,7 @@ pte_t *__pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
 	pte = __pte_offset_map(pmd, addr, &pmdval);
 	if (unlikely(!pte))
 		return pte;
-	ptl = pte_lockptr(mm, &pmdval);
+	ptl = pte_lockptr(mm, pte);
 	spin_lock(ptl);
 	if (likely(pmd_same(pmdval, pmdp_get_lockless(pmd)))) {
 		*ptlp = ptl;
-- 
2.45.2


