Return-Path: <linux-kernel+bounces-233096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D6691B231
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 00:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B56E11F21A86
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 22:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E441A2557;
	Thu, 27 Jun 2024 22:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qh5c1FSj"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0378119AD93
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 22:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719527232; cv=none; b=uWcQxlAQfwrFEGlO2EPpORmGdx42cxBZ+W4LlqUrXG8K9GkFiKhdRvWBKONM1dF545VmdmZf/NcNhhC7kZqmhld1kXaDnmXj80FhwSOGpuwTj/rg217KATjzcygLLXmmO7Gr5R3Y7DmbgCOrJxwg1ACQDJmY0u9uXLOaydgDewg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719527232; c=relaxed/simple;
	bh=6Z7vU+AwB92+tGMfeJacTuXWpeMr+PIuCkmBgEtVytk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jZMfHurvJQzJtmiTnGca8WbOnaEemTZgrEjouEbC4cCVKhGRwHD+YImvRdEFkDPYIFa39nv+1PHfu+aPYbOhj0p7dltX9rbQJekEAyDYaLIeTPVOkAHw65OjcEnP0aEyYjl2eoQIaOhh5VziwLQsS1ArmJBajOTMnBSimYKXIe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qh5c1FSj; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e023e936ac4so17309097276.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 15:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719527230; x=1720132030; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jy0eCPosTDsC4ow54f9quqwWAcJUb14iJ68K4X0ZvNg=;
        b=qh5c1FSjxwHJ8cRhgSCI2oCLzuxlbZqwAJht5lG5kzRhvLOD51nW7/1MKolOfn++6z
         bvFYlQOFR47PUZYQFXRF0nwKx4lgpiGf77siyKtp7BZtZdQEAda65NC99FOQCmXHdGOJ
         Icy6JG1bFM3H4xP1JEK7k7MnfDtHk6Y/RE4OMo9cO65TM+pz1Vo+BIBwiufb1aKoJwJe
         mlM7+g++RICMO7B0A1WOJPU9nFOLTIRbbq1Z5eV2ofgDaC/glKdktABnzDHgdCh83uQZ
         beERzMzn8qQMAp18GhsOxjMd7+S9I3jt/gZffGhYASNk13mHR1xJy71o2IRkV4wekjpZ
         Elaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719527230; x=1720132030;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jy0eCPosTDsC4ow54f9quqwWAcJUb14iJ68K4X0ZvNg=;
        b=JYM72LiaaAXFTj/ex/sccbtnLa80inhDyfb0uXLZ8GbWiga6vRDZ0eWNi4ew25kAuN
         2dZ9z1pevKqsJshYLaBLs6LEzneILfEE7nWECJQt7pE9PUEnTND1Zql9rc/S+0dA4SqG
         oYqWZtPmSMuF55F1CwhayhubesKgZtQPvxhSoOXNJgln956iX/RyqNSeQm/6VEBDiI0l
         QtGdKZEj6oxVhIaaRco5TeWNiEtRGkAmaKSVBYajhT5q/gmCbMHFjL4yqWD/iyl9CqeY
         EamdO+QFNUYs6NXsP/9wF18S621izJ+2bzrNekIVwggsgE8B8rCqkyr6m9K2WZd3MDFq
         FBNw==
X-Forwarded-Encrypted: i=1; AJvYcCXrX+O+fARN3Uq3xlPK1joWzjYFQMMCxqHv5wjLg/iLbX9q3tN8vWCgfFHR4Za0OpJq8Rie8JEPbE3BKwsgvNIsLdljhzS47VpxL/oI
X-Gm-Message-State: AOJu0Yw8D1hr807eLHCWfu/IA3dvugfJjqVbV3qLbFyJuxvjpyY9LUpf
	HkgR6VPL/o2yDEHV34mQooUphAwGgDF76aN0ovbk5qvdQOd42rzAOK66gqLEUgOolkO1HbKbdM6
	npQ==
X-Google-Smtp-Source: AGHT+IHKkfFE8FHutXWkOYnP7SfL+FYGxMkE+fzToL7noNtogZPbrka7P7HYXKY3gz94n2IYJBynrkt5Kv0=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:bbec:6bf1:2652:4697])
 (user=yuzhao job=sendgmr) by 2002:a05:6902:114b:b0:dfd:9e19:7e0f with SMTP id
 3f1490d57ef6-e0303fe39cbmr511346276.11.1719527229941; Thu, 27 Jun 2024
 15:27:09 -0700 (PDT)
Date: Thu, 27 Jun 2024 16:27:05 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240627222705.2974207-1-yuzhao@google.com>
Subject: [PATCH mm-unstable v2] mm/hugetlb_vmemmap: fix race with speculative
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

According to the hugetlb_optimize_vmemmap section in
Documentation/admin-guide/sysctl/vm.rst, enabling HVO makes allocating
or freeing hugeTLB pages "~2x slower than before". Having
synchronize_rcu() on top makes those operations even worse, and this
also affects the user interface /proc/sys/vm/nr_overcommit_hugepages.

[1] https://lore.kernel.org/20240229183436.4110845-4-yuzhao@google.com/
[2] https://lore.kernel.org/917FFC7F-0615-44DD-90EE-9F85F8EA9974@linux.dev/
[3] https://lore.kernel.org/be130a96-a27e-4240-ad78-776802f57cad@redhat.com/

Signed-off-by: Yu Zhao <yuzhao@google.com>
Acked-by: Muchun Song <muchun.song@linux.dev>
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
index 9691624fcb79..0a69e194b517 100644
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
 
@@ -1649,6 +1646,7 @@ static void __remove_hugetlb_folio(struct hstate *h, struct folio *folio,
 	list_del(&folio->lru);
 
 	if (folio_test_hugetlb_freed(folio)) {
+		folio_clear_hugetlb_freed(folio);
 		h->free_huge_pages--;
 		h->free_huge_pages_node[nid]--;
 	}
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


