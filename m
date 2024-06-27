Return-Path: <linux-kernel+bounces-231805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09136919E50
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 06:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A0441F2566D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 04:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D529A18E28;
	Thu, 27 Jun 2024 04:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4bmCgFYN"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356D61799D
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 04:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719463420; cv=none; b=VCVuD6ppwXhrrPTxGwbMJMmliAAopiJBOETde37KhuM5vs+Ibkc7CN5emnBJCcQyR6WBNfPbkse68acM92TqqRlG4E3YxxAY7QRJ1H/kMNwZokqUpxr1zb+Rx3gTzmZ7+CI0yxes0+VIFJGe2OqNFNR475yaW3qoxK4a0P5kstU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719463420; c=relaxed/simple;
	bh=d8yFX4pftbWbyhnQJoGAUL01yHraB+5XMSuiFs6igLc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JSV6/r6qMJt6or/j7tq0yb93ZIl5611kB/LpAFujEHpVhVgNaCRGzDh4TlequCs8aHXkNaZ5JxeqPRw+WPn5R/VIfiP2JwzqeWcPaDAyJiDT3B3bUQz5CiaxTyRTnb8pPP5FIIfLDdbGG1/C51PS7cJ59ZpS3Cc/NMGZqA2OgqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4bmCgFYN; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0322e5d0daso2480745276.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 21:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719463418; x=1720068218; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hdRtKbQiOkGUeLR6KDBlvVV6ztPezKPNE7EFhbYdET8=;
        b=4bmCgFYNrZ2hUxqiqVCzVZVult9GCNYYDW2KnVAaKUBPoF9l6PV1CEq9uoGiKGMZ2W
         MHWEZSeXvgjqlNuln6eSmhw+O7bAOLk3rg1hFqeBo36clmMQhWMeB9sQLO8mfm/8te9Z
         z7AY6CJMIZTocHXJYHaUYMec4EY0x/QUupFmXdBKywK34ftUmccsFf0k+lci63i4TBW3
         gbhUh/4/mXiO8d0xf5LmEhzzsq8JxxprytzmeD4Ue1CfUuiheggN7GKf//F51fmaZ4T+
         YrlH/CErMSyop/vssP61oPgRwOSuftAGQCWQydCopo2QM3lTqHGJHS/eHo86//HF2mda
         Vvhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719463418; x=1720068218;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hdRtKbQiOkGUeLR6KDBlvVV6ztPezKPNE7EFhbYdET8=;
        b=hJGE5pGmxBvj30gQI4DucI8ZNIv0a5G3vqSFB2T4e6iENj8lDnA5qE5zBkuykl0uJE
         O1xrhv52A/ObuEIK78idQf27vNjXvSTohbwUjo3tCUTVr0Vm8CCr2Lag0ryoMku3BuGO
         hTfMmaa3tQXxh+c5JxfXgXhnPm/YqO+3igu1uXbe/S8uk01hkYgyEs5xHpUbhzKOFOUx
         2pQlTCOXd+d4H+RNcqgVklj3XTaSimrNsNpL9HjniBJAxzHd9pJgxiC0IqlE+MXZShgR
         1uuXoGXaETq2NMPAqnhjPsyw7nBTtiAuTm1Jplo5eWnEzDnJS0Sy/T3MjdCi+D2QnQE7
         TkVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgQkWWBVNuk6ek0mI2YfIIPH8tsHuSCP+Pob1FH3SXkiGJpZTC7Zo5N6XM7ffc/VsLS4C/9Xypn1uEhJPnkjrgb8wUbUBYgy38jof1
X-Gm-Message-State: AOJu0Yzn+2RgAm2vDKp5vRgmOKOkmh959pyCQXxPBVH+i065BSwW+k1H
	HhMz1qtyzW4wMpxC7CqvyI4dqk1nKx/vWMeGjFY3+u9p4y8D/sgjnCuvaL0DWET+yUHVGJ2kcNw
	qTQ==
X-Google-Smtp-Source: AGHT+IELOZfdvbJRxtxyvrlCwB2OQtSBvFck+2H0B3d4kUKw92oWpBAzgjoIfxEO7GlE1eBl4BMLNb7GVJA=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:edf9:510d:6ad1:f544])
 (user=yuzhao job=sendgmr) by 2002:a25:ae07:0:b0:e02:f3cf:9454 with SMTP id
 3f1490d57ef6-e034508affamr5146276.2.1719463418116; Wed, 26 Jun 2024 21:43:38
 -0700 (PDT)
Date: Wed, 26 Jun 2024 22:43:34 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240627044335.2698578-1-yuzhao@google.com>
Subject: [PATCH mm-unstable v1] mm/hugetlb_vmemmap: fix race with speculative
 PFN walkers
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>
Cc: David Hildenbrand <david@redhat.com>, Frank van der Linden <fvdl@google.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Peter Xu <peterx@redhat.com>, 
	Yang Shi <yang@os.amperecomputing.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"

While investigating HVO for THPs [1], it turns out that speculative
PFN walkers like compaction can race with vmemmap modifications, e.g.,

  CPU 1 (vmemmap modifier)         CPU 2 (speculative PFN walker)
  -------------------------------  ------------------------------
  Allocates an LRU folio page1
                                   Sees page1
  Frees page1

  Allocates a hugeTLB folio page2
  (page1 being a tail of page2)

  Updates vmemmap mapping page1
                                   get_page_unless_zero(page1)

Even though page1->_refcount is zero after HVO, get_page_unless_zero()
can still try to modify this read-only field, resulting in a crash.

An independent report [2] confirmed this race.

There are two discussed approaches to fix this race:
1. Make RO vmemmap RW so that get_page_unless_zero() can fail without
   triggering a PF.
2. Use RCU to make sure get_page_unless_zero() either sees zero
   page->_refcount through the old vmemmap or non-zero page->_refcount
   through the new one.

The second approach is preferred here because:
1. It can prevent illegal modifications to struct page[] that has been
   HVO'ed;
2. It can be generalized, in a way similar to ZERO_PAGE(), to fix
   similar races in other places, e.g., arch_remove_memory() on x86
   [3], which frees vmemmap mapping offlined struct page[].

While adding synchronize_rcu(), the goal is to be surgical, rather
than optimized. Specifically, calls to synchronize_rcu() on the error
handling paths can be coalesced, but it is not done for the sake of
Simplicity: noticeably, this fix removes ~50% more lines than it adds.

[1] https://lore.kernel.org/20240229183436.4110845-4-yuzhao@google.com/
[2] https://lore.kernel.org/917FFC7F-0615-44DD-90EE-9F85F8EA9974@linux.dev/
[3] https://lore.kernel.org/be130a96-a27e-4240-ad78-776802f57cad@redhat.com/

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/page_ref.h |  8 +++++-
 mm/hugetlb.c             | 53 ++++++----------------------------------
 mm/hugetlb_vmemmap.c     | 16 ++++++++++++
 3 files changed, 30 insertions(+), 47 deletions(-)

diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
index 490d0ad6e56d..8c236c651d1d 100644
--- a/include/linux/page_ref.h
+++ b/include/linux/page_ref.h
@@ -230,7 +230,13 @@ static inline int folio_ref_dec_return(struct folio *folio)
 
 static inline bool page_ref_add_unless(struct page *page, int nr, int u)
 {
-	bool ret = atomic_add_unless(&page->_refcount, nr, u);
+	bool ret = false;
+
+	rcu_read_lock();
+	/* avoid writing to the vmemmap area being remapped */
+	if (!page_is_fake_head(page) && page_ref_count(page) != u)
+		ret = atomic_add_unless(&page->_refcount, nr, u);
+	rcu_read_unlock();
 
 	if (page_ref_tracepoint_active(page_ref_mod_unless))
 		__page_ref_mod_unless(page, nr, ret);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9691624fcb79..1ddaf25737da 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1629,13 +1629,10 @@ static inline void destroy_compound_gigantic_folio(struct folio *folio,
  * folio appears as just a compound page.  Otherwise, wait until after
  * allocating vmemmap to clear the flag.
  *
- * A reference is held on the folio, except in the case of demote.
- *
  * Must be called with hugetlb lock held.
  */
-static void __remove_hugetlb_folio(struct hstate *h, struct folio *folio,
-							bool adjust_surplus,
-							bool demote)
+static void remove_hugetlb_folio(struct hstate *h, struct folio *folio,
+							bool adjust_surplus)
 {
 	int nid = folio_nid(folio);
 
@@ -1657,6 +1654,7 @@ static void __remove_hugetlb_folio(struct hstate *h, struct folio *folio,
 		h->surplus_huge_pages_node[nid]--;
 	}
 
+	folio_clear_hugetlb_freed(folio);
 	/*
 	 * We can only clear the hugetlb flag after allocating vmemmap
 	 * pages.  Otherwise, someone (memory error handling) may try to write
@@ -1665,33 +1663,13 @@ static void __remove_hugetlb_folio(struct hstate *h, struct folio *folio,
 	if (!folio_test_hugetlb_vmemmap_optimized(folio))
 		__folio_clear_hugetlb(folio);
 
-	 /*
-	  * In the case of demote we do not ref count the page as it will soon
-	  * be turned into a page of smaller size.
-	 */
-	if (!demote)
-		folio_ref_unfreeze(folio, 1);
-
 	h->nr_huge_pages--;
 	h->nr_huge_pages_node[nid]--;
 }
 
-static void remove_hugetlb_folio(struct hstate *h, struct folio *folio,
-							bool adjust_surplus)
-{
-	__remove_hugetlb_folio(h, folio, adjust_surplus, false);
-}
-
-static void remove_hugetlb_folio_for_demote(struct hstate *h, struct folio *folio,
-							bool adjust_surplus)
-{
-	__remove_hugetlb_folio(h, folio, adjust_surplus, true);
-}
-
 static void add_hugetlb_folio(struct hstate *h, struct folio *folio,
 			     bool adjust_surplus)
 {
-	int zeroed;
 	int nid = folio_nid(folio);
 
 	VM_BUG_ON_FOLIO(!folio_test_hugetlb_vmemmap_optimized(folio), folio);
@@ -1715,21 +1693,6 @@ static void add_hugetlb_folio(struct hstate *h, struct folio *folio,
 	 */
 	folio_set_hugetlb_vmemmap_optimized(folio);
 
-	/*
-	 * This folio is about to be managed by the hugetlb allocator and
-	 * should have no users.  Drop our reference, and check for others
-	 * just in case.
-	 */
-	zeroed = folio_put_testzero(folio);
-	if (unlikely(!zeroed))
-		/*
-		 * It is VERY unlikely soneone else has taken a ref
-		 * on the folio.  In this case, we simply return as
-		 * free_huge_folio() will be called when this other ref
-		 * is dropped.
-		 */
-		return;
-
 	arch_clear_hugetlb_flags(folio);
 	enqueue_hugetlb_folio(h, folio);
 }
@@ -1783,6 +1746,8 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 		spin_unlock_irq(&hugetlb_lock);
 	}
 
+	folio_ref_unfreeze(folio, 1);
+
 	/*
 	 * Non-gigantic pages demoted from CMA allocated gigantic pages
 	 * need to be given back to CMA in free_gigantic_folio.
@@ -3106,11 +3071,8 @@ static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
 
 free_new:
 	spin_unlock_irq(&hugetlb_lock);
-	if (new_folio) {
-		/* Folio has a zero ref count, but needs a ref to be freed */
-		folio_ref_unfreeze(new_folio, 1);
+	if (new_folio)
 		update_and_free_hugetlb_folio(h, new_folio, false);
-	}
 
 	return ret;
 }
@@ -3965,7 +3927,7 @@ static int demote_free_hugetlb_folio(struct hstate *h, struct folio *folio)
 
 	target_hstate = size_to_hstate(PAGE_SIZE << h->demote_order);
 
-	remove_hugetlb_folio_for_demote(h, folio, false);
+	remove_hugetlb_folio(h, folio, false);
 	spin_unlock_irq(&hugetlb_lock);
 
 	/*
@@ -3979,7 +3941,6 @@ static int demote_free_hugetlb_folio(struct hstate *h, struct folio *folio)
 		if (rc) {
 			/* Allocation of vmemmmap failed, we can not demote folio */
 			spin_lock_irq(&hugetlb_lock);
-			folio_ref_unfreeze(folio, 1);
 			add_hugetlb_folio(h, folio, false);
 			return rc;
 		}
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index fa00d61b6c5a..829112b0a914 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -455,6 +455,8 @@ static int __hugetlb_vmemmap_restore_folio(const struct hstate *h,
 	unsigned long vmemmap_reuse;
 
 	VM_WARN_ON_ONCE_FOLIO(!folio_test_hugetlb(folio), folio);
+	VM_WARN_ON_ONCE_FOLIO(folio_ref_count(folio), folio);
+
 	if (!folio_test_hugetlb_vmemmap_optimized(folio))
 		return 0;
 
@@ -490,6 +492,9 @@ static int __hugetlb_vmemmap_restore_folio(const struct hstate *h,
  */
 int hugetlb_vmemmap_restore_folio(const struct hstate *h, struct folio *folio)
 {
+	/* avoid writes from page_ref_add_unless() while unfolding vmemmap */
+	synchronize_rcu();
+
 	return __hugetlb_vmemmap_restore_folio(h, folio, 0);
 }
 
@@ -514,6 +519,9 @@ long hugetlb_vmemmap_restore_folios(const struct hstate *h,
 	long restored = 0;
 	long ret = 0;
 
+	/* avoid writes from page_ref_add_unless() while unfolding vmemmap */
+	synchronize_rcu();
+
 	list_for_each_entry_safe(folio, t_folio, folio_list, lru) {
 		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
 			ret = __hugetlb_vmemmap_restore_folio(h, folio,
@@ -559,6 +567,8 @@ static int __hugetlb_vmemmap_optimize_folio(const struct hstate *h,
 	unsigned long vmemmap_reuse;
 
 	VM_WARN_ON_ONCE_FOLIO(!folio_test_hugetlb(folio), folio);
+	VM_WARN_ON_ONCE_FOLIO(folio_ref_count(folio), folio);
+
 	if (!vmemmap_should_optimize_folio(h, folio))
 		return ret;
 
@@ -610,6 +620,9 @@ void hugetlb_vmemmap_optimize_folio(const struct hstate *h, struct folio *folio)
 {
 	LIST_HEAD(vmemmap_pages);
 
+	/* avoid writes from page_ref_add_unless() while folding vmemmap */
+	synchronize_rcu();
+
 	__hugetlb_vmemmap_optimize_folio(h, folio, &vmemmap_pages, 0);
 	free_vmemmap_page_list(&vmemmap_pages);
 }
@@ -653,6 +666,9 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 
 	flush_tlb_all();
 
+	/* avoid writes from page_ref_add_unless() while folding vmemmap */
+	synchronize_rcu();
+
 	list_for_each_entry(folio, folio_list, lru) {
 		int ret;
 
-- 
2.45.2.803.g4e1b14247a-goog


