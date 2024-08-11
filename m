Return-Path: <linux-kernel+bounces-282398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 195FF94E352
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 23:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48186B211F6
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 21:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A834115C120;
	Sun, 11 Aug 2024 21:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E9l63VT9"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93200165EF0
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 21:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723411303; cv=none; b=e42zOwtBmqQbVYMxIu6Pp6AmyKRHBWWLdPFi/5fuqW1UkkGCENs34W3Dsy0b+BhhN/cAkAoSsaAEl2V05QQo7utSqgu1QottFXtUtxf8IKjfwDgUJxHf6bB70lUzB3Qs5SHFiHBeJ3uDAr61A7O1DwYUPH6qyY/S9ipH/BFCvDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723411303; c=relaxed/simple;
	bh=rX/uyGK859Qv0c/8SCHhsaXgw8NXAEtdAyPwFlV/th8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jmWEarIMxsOyasOq4MDzMvxqbNSIIF+LgNqA1tKbl2yZmlq+MVwSZ8EmXPshpM3jLrnA+m7J9CeuEv4dY38x2uQsx+0R4YK8CA4WorRba4CxMzYRtVU8WSwgtFsu3qelcBT5kOJfNZgBTStM/2J1zhTmS1R7J5R8INPuumtmAZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E9l63VT9; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-654d96c2bb5so71759517b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 14:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723411300; x=1724016100; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=plPNUwSc20wvxDLG/5V4ONiycR26+90aEQUlSgRQtvI=;
        b=E9l63VT9e91/MxKGZp02kE0MK5vH7t4CcV1mPs88z+waj062iJejvzuwInKABnG3Tr
         WF+nFKZ2C8Ol4x1Y5yOeCUwmrT/12Q6kAzkInAhktCiq0f7/2cSRhb/vZFvjvQzeiYJ7
         /1puVbwvEvEa1ndM8w5/IkQO3jnmoM9GDXdHg01lIMBuEnki47ZYdsvoWjQVFFJGvmvt
         Fgl8NCuyT1RmNSE8O/+Qxtg4onuHc7DXOHnI3XbQP3lftgzC+if2bS8Mj8yzzQ5o8Utg
         afvwrHpI3OwtT8IiY9UoH5EkTjYI87yOS2gbnoyV2b3j1FEqJkkmumdLMDApWUqPjD9v
         6YYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723411300; x=1724016100;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=plPNUwSc20wvxDLG/5V4ONiycR26+90aEQUlSgRQtvI=;
        b=G9oIfwa7GoYFzYn3wTsma+i4XDmg4+OVp0ppMOEabqc1GfZ6gOtphnSYG4OSE6Gdvg
         xNWi86CW2jJv1IFz20AhfJ6y7RSTOUdHjeoNAwBHDl6H5nVWmqFmWvCzHEMSDfHZIoaw
         kzxbM6J417EM9xsrQ7K9OQLltOUjCMglkhoqF41+82xwdcddKGuhtab8ICcc1syAcwpg
         Ddl5uc5AX31UiKW355DyBjYYYK6IAg02v5dPzoCL71a/fH586YEgh0pEews8XaKx68T6
         iK+DZ5q1qHJcgahY31wr5rQ9Y1m+dwvyw7TW4bfZDurv/xdbIrtOQ1JRc6gfZcCKTQKC
         FjOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWocmHhUD1WtQb3Vh4dTWiQPGdgfRFXKoCLrVD5OkhSqjuZpug0TuHq3mszZN9lbwC1acsA5D/esUAzdAGnQz6KtDNCh02B7wcSPwgv
X-Gm-Message-State: AOJu0YxG3jaSoDaKaGxm3lytAXQRpTGZ+Pw9gU4IjV2Nt2IEun3Xr5fq
	0nIBQ+uY/jKlQVRr4y3wDrRM6xdOdZE0LYk3A9whPR7PiJoYuDrQBq0opDxMv9y4EdP1dSmKKy7
	nGw==
X-Google-Smtp-Source: AGHT+IHabmrGk91oLaByBgnfM+5JbvP9zqcwTHpzXiVoA50OMZR/9U6IX+5qqzgzKEbG6UqMgpxrz3SgVrA=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:c9c:12b4:a1e3:7f10])
 (user=yuzhao job=sendgmr) by 2002:a81:c64b:0:b0:62f:a56a:cee8 with SMTP id
 00721157ae682-69ec54adf13mr3154657b3.3.1723411300470; Sun, 11 Aug 2024
 14:21:40 -0700 (PDT)
Date: Sun, 11 Aug 2024 15:21:29 -0600
In-Reply-To: <20240811212129.3074314-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240811212129.3074314-1-yuzhao@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240811212129.3074314-4-yuzhao@google.com>
Subject: [PATCH mm-unstable v1 3/3] mm/hugetlb: use __GFP_COMP for gigantic folios
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"

Use __GFP_COMP for gigantic folios to greatly reduce not only the code
but also the allocation and free time.

LOC (approximately): -200, +50

Allocate and free 500 1GB hugeTLB memory without HVO by:
  time echo 500 >/sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
  time echo 0 >/sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages

       Before  After
Alloc  ~13s    ~10s
Free   ~15s    <1s

The above magnitude generally holds for multiple x86 and arm64 CPU
models.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/hugetlb.h |   9 +-
 mm/hugetlb.c            | 244 ++++++++--------------------------------
 2 files changed, 50 insertions(+), 203 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 3100a52ceb73..98c47c394b89 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -896,10 +896,11 @@ static inline bool hugepage_movable_supported(struct hstate *h)
 /* Movability of hugepages depends on migration support. */
 static inline gfp_t htlb_alloc_mask(struct hstate *h)
 {
-	if (hugepage_movable_supported(h))
-		return GFP_HIGHUSER_MOVABLE;
-	else
-		return GFP_HIGHUSER;
+	gfp_t gfp = __GFP_COMP | __GFP_NOWARN;
+
+	gfp |= hugepage_movable_supported(h) ? GFP_HIGHUSER_MOVABLE : GFP_HIGHUSER;
+
+	return gfp;
 }
 
 static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1c13e65ab119..691f63408d50 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1512,43 +1512,7 @@ static int hstate_next_node_to_free(struct hstate *h, nodemask_t *nodes_allowed)
 		((node = hstate_next_node_to_free(hs, mask)) || 1);	\
 		nr_nodes--)
 
-/* used to demote non-gigantic_huge pages as well */
-static void __destroy_compound_gigantic_folio(struct folio *folio,
-					unsigned int order, bool demote)
-{
-	int i;
-	int nr_pages = 1 << order;
-	struct page *p;
-
-	atomic_set(&folio->_entire_mapcount, 0);
-	atomic_set(&folio->_large_mapcount, 0);
-	atomic_set(&folio->_pincount, 0);
-
-	for (i = 1; i < nr_pages; i++) {
-		p = folio_page(folio, i);
-		p->flags &= ~PAGE_FLAGS_CHECK_AT_FREE;
-		p->mapping = NULL;
-		clear_compound_head(p);
-		if (!demote)
-			set_page_refcounted(p);
-	}
-
-	__folio_clear_head(folio);
-}
-
-static void destroy_compound_hugetlb_folio_for_demote(struct folio *folio,
-					unsigned int order)
-{
-	__destroy_compound_gigantic_folio(folio, order, true);
-}
-
 #ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
-static void destroy_compound_gigantic_folio(struct folio *folio,
-					unsigned int order)
-{
-	__destroy_compound_gigantic_folio(folio, order, false);
-}
-
 static void free_gigantic_folio(struct folio *folio, unsigned int order)
 {
 	/*
@@ -1569,38 +1533,52 @@ static void free_gigantic_folio(struct folio *folio, unsigned int order)
 static struct folio *alloc_gigantic_folio(struct hstate *h, gfp_t gfp_mask,
 		int nid, nodemask_t *nodemask)
 {
-	struct page *page;
-	unsigned long nr_pages = pages_per_huge_page(h);
+	struct folio *folio;
+	int order = huge_page_order(h);
+	bool retry = false;
+
 	if (nid == NUMA_NO_NODE)
 		nid = numa_mem_id();
-
+retry:
+	folio = NULL;
 #ifdef CONFIG_CMA
 	{
 		int node;
 
-		if (hugetlb_cma[nid]) {
-			page = cma_alloc(hugetlb_cma[nid], nr_pages,
-					huge_page_order(h), true);
-			if (page)
-				return page_folio(page);
-		}
+		if (hugetlb_cma[nid])
+			folio = cma_alloc_folio(hugetlb_cma[nid], order, gfp_mask);
 
-		if (!(gfp_mask & __GFP_THISNODE)) {
+		if (!folio && !(gfp_mask & __GFP_THISNODE)) {
 			for_each_node_mask(node, *nodemask) {
 				if (node == nid || !hugetlb_cma[node])
 					continue;
 
-				page = cma_alloc(hugetlb_cma[node], nr_pages,
-						huge_page_order(h), true);
-				if (page)
-					return page_folio(page);
+				folio = cma_alloc_folio(hugetlb_cma[node], order, gfp_mask);
+				if (folio)
+					break;
 			}
 		}
 	}
 #endif
+	if (!folio) {
+		struct page *page = alloc_contig_pages(1 << order, gfp_mask, nid, nodemask);
 
-	page = alloc_contig_pages(nr_pages, gfp_mask, nid, nodemask);
-	return page ? page_folio(page) : NULL;
+		if (!page)
+			return NULL;
+
+		folio = page_folio(page);
+	}
+
+	if (folio_ref_freeze(folio, 1))
+		return folio;
+
+	pr_warn("HugeTLB: unexpected refcount on PFN %lu\n", folio_pfn(folio));
+	free_gigantic_folio(folio, order);
+	if (!retry) {
+		retry = true;
+		goto retry;
+	}
+	return NULL;
 }
 
 #else /* !CONFIG_CONTIG_ALLOC */
@@ -1619,8 +1597,6 @@ static struct folio *alloc_gigantic_folio(struct hstate *h, gfp_t gfp_mask,
 }
 static inline void free_gigantic_folio(struct folio *folio,
 						unsigned int order) { }
-static inline void destroy_compound_gigantic_folio(struct folio *folio,
-						unsigned int order) { }
 #endif
 
 /*
@@ -1747,19 +1723,17 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 		folio_clear_hugetlb_hwpoison(folio);
 
 	folio_ref_unfreeze(folio, 1);
+	INIT_LIST_HEAD(&folio->_deferred_list);
 
 	/*
 	 * Non-gigantic pages demoted from CMA allocated gigantic pages
 	 * need to be given back to CMA in free_gigantic_folio.
 	 */
 	if (hstate_is_gigantic(h) ||
-	    hugetlb_cma_folio(folio, huge_page_order(h))) {
-		destroy_compound_gigantic_folio(folio, huge_page_order(h));
+	    hugetlb_cma_folio(folio, huge_page_order(h)))
 		free_gigantic_folio(folio, huge_page_order(h));
-	} else {
-		INIT_LIST_HEAD(&folio->_deferred_list);
+	else
 		folio_put(folio);
-	}
 }
 
 /*
@@ -2032,95 +2006,6 @@ static void prep_new_hugetlb_folio(struct hstate *h, struct folio *folio, int ni
 	spin_unlock_irq(&hugetlb_lock);
 }
 
-static bool __prep_compound_gigantic_folio(struct folio *folio,
-					unsigned int order, bool demote)
-{
-	int i, j;
-	int nr_pages = 1 << order;
-	struct page *p;
-
-	__folio_clear_reserved(folio);
-	for (i = 0; i < nr_pages; i++) {
-		p = folio_page(folio, i);
-
-		/*
-		 * For gigantic hugepages allocated through bootmem at
-		 * boot, it's safer to be consistent with the not-gigantic
-		 * hugepages and clear the PG_reserved bit from all tail pages
-		 * too.  Otherwise drivers using get_user_pages() to access tail
-		 * pages may get the reference counting wrong if they see
-		 * PG_reserved set on a tail page (despite the head page not
-		 * having PG_reserved set).  Enforcing this consistency between
-		 * head and tail pages allows drivers to optimize away a check
-		 * on the head page when they need know if put_page() is needed
-		 * after get_user_pages().
-		 */
-		if (i != 0)	/* head page cleared above */
-			__ClearPageReserved(p);
-		/*
-		 * Subtle and very unlikely
-		 *
-		 * Gigantic 'page allocators' such as memblock or cma will
-		 * return a set of pages with each page ref counted.  We need
-		 * to turn this set of pages into a compound page with tail
-		 * page ref counts set to zero.  Code such as speculative page
-		 * cache adding could take a ref on a 'to be' tail page.
-		 * We need to respect any increased ref count, and only set
-		 * the ref count to zero if count is currently 1.  If count
-		 * is not 1, we return an error.  An error return indicates
-		 * the set of pages can not be converted to a gigantic page.
-		 * The caller who allocated the pages should then discard the
-		 * pages using the appropriate free interface.
-		 *
-		 * In the case of demote, the ref count will be zero.
-		 */
-		if (!demote) {
-			if (!page_ref_freeze(p, 1)) {
-				pr_warn("HugeTLB page can not be used due to unexpected inflated ref count\n");
-				goto out_error;
-			}
-		} else {
-			VM_BUG_ON_PAGE(page_count(p), p);
-		}
-		if (i != 0)
-			set_compound_head(p, &folio->page);
-	}
-	__folio_set_head(folio);
-	/* we rely on prep_new_hugetlb_folio to set the hugetlb flag */
-	folio_set_order(folio, order);
-	atomic_set(&folio->_entire_mapcount, -1);
-	atomic_set(&folio->_large_mapcount, -1);
-	atomic_set(&folio->_pincount, 0);
-	return true;
-
-out_error:
-	/* undo page modifications made above */
-	for (j = 0; j < i; j++) {
-		p = folio_page(folio, j);
-		if (j != 0)
-			clear_compound_head(p);
-		set_page_refcounted(p);
-	}
-	/* need to clear PG_reserved on remaining tail pages  */
-	for (; j < nr_pages; j++) {
-		p = folio_page(folio, j);
-		__ClearPageReserved(p);
-	}
-	return false;
-}
-
-static bool prep_compound_gigantic_folio(struct folio *folio,
-							unsigned int order)
-{
-	return __prep_compound_gigantic_folio(folio, order, false);
-}
-
-static bool prep_compound_gigantic_folio_for_demote(struct folio *folio,
-							unsigned int order)
-{
-	return __prep_compound_gigantic_folio(folio, order, true);
-}
-
 /*
  * Find and lock address space (mapping) in write mode.
  *
@@ -2159,7 +2044,6 @@ static struct folio *alloc_buddy_hugetlb_folio(struct hstate *h,
 	 */
 	if (node_alloc_noretry && node_isset(nid, *node_alloc_noretry))
 		alloc_try_hard = false;
-	gfp_mask |= __GFP_COMP|__GFP_NOWARN;
 	if (alloc_try_hard)
 		gfp_mask |= __GFP_RETRY_MAYFAIL;
 	if (nid == NUMA_NO_NODE)
@@ -2206,48 +2090,14 @@ static struct folio *alloc_buddy_hugetlb_folio(struct hstate *h,
 	return folio;
 }
 
-static struct folio *__alloc_fresh_hugetlb_folio(struct hstate *h,
-				gfp_t gfp_mask, int nid, nodemask_t *nmask,
-				nodemask_t *node_alloc_noretry)
-{
-	struct folio *folio;
-	bool retry = false;
-
-retry:
-	if (hstate_is_gigantic(h))
-		folio = alloc_gigantic_folio(h, gfp_mask, nid, nmask);
-	else
-		folio = alloc_buddy_hugetlb_folio(h, gfp_mask,
-				nid, nmask, node_alloc_noretry);
-	if (!folio)
-		return NULL;
-
-	if (hstate_is_gigantic(h)) {
-		if (!prep_compound_gigantic_folio(folio, huge_page_order(h))) {
-			/*
-			 * Rare failure to convert pages to compound page.
-			 * Free pages and try again - ONCE!
-			 */
-			free_gigantic_folio(folio, huge_page_order(h));
-			if (!retry) {
-				retry = true;
-				goto retry;
-			}
-			return NULL;
-		}
-	}
-
-	return folio;
-}
-
 static struct folio *only_alloc_fresh_hugetlb_folio(struct hstate *h,
 		gfp_t gfp_mask, int nid, nodemask_t *nmask,
 		nodemask_t *node_alloc_noretry)
 {
 	struct folio *folio;
 
-	folio = __alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask,
-						node_alloc_noretry);
+	folio = hstate_is_gigantic(h) ? alloc_gigantic_folio(h, gfp_mask, nid, nmask) :
+		alloc_buddy_hugetlb_folio(h, gfp_mask, nid, nmask, node_alloc_noretry);
 	if (folio)
 		init_new_hugetlb_folio(h, folio);
 	return folio;
@@ -2265,7 +2115,8 @@ static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
 {
 	struct folio *folio;
 
-	folio = __alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask, NULL);
+	folio = hstate_is_gigantic(h) ? alloc_gigantic_folio(h, gfp_mask, nid, nmask) :
+		alloc_buddy_hugetlb_folio(h, gfp_mask, nid, nmask, NULL);
 	if (!folio)
 		return NULL;
 
@@ -2549,9 +2400,8 @@ struct folio *alloc_buddy_hugetlb_folio_with_mpol(struct hstate *h,
 
 	nid = huge_node(vma, addr, gfp_mask, &mpol, &nodemask);
 	if (mpol_is_preferred_many(mpol)) {
-		gfp_t gfp = gfp_mask | __GFP_NOWARN;
+		gfp_t gfp = gfp_mask & ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
 
-		gfp &=  ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
 		folio = alloc_surplus_hugetlb_folio(h, gfp, nid, nodemask);
 
 		/* Fallback to all nodes if page==NULL */
@@ -3333,6 +3183,7 @@ static void __init hugetlb_folio_init_tail_vmemmap(struct folio *folio,
 	for (pfn = head_pfn + start_page_number; pfn < end_pfn; pfn++) {
 		struct page *page = pfn_to_page(pfn);
 
+		__ClearPageReserved(folio_page(folio, pfn - head_pfn));
 		__init_single_page(page, pfn, zone, nid);
 		prep_compound_tail((struct page *)folio, pfn - head_pfn);
 		ret = page_ref_freeze(page, 1);
@@ -3949,21 +3800,16 @@ static long demote_free_hugetlb_folios(struct hstate *src, struct hstate *dst,
 			continue;
 
 		list_del(&folio->lru);
-		/*
-		 * Use destroy_compound_hugetlb_folio_for_demote for all huge page
-		 * sizes as it will not ref count folios.
-		 */
-		destroy_compound_hugetlb_folio_for_demote(folio, huge_page_order(src));
+
+		split_page_owner(&folio->page, huge_page_order(src), huge_page_order(dst));
+		pgalloc_tag_split(&folio->page, 1 <<  huge_page_order(src));
 
 		for (i = 0; i < pages_per_huge_page(src); i += pages_per_huge_page(dst)) {
 			struct page *page = folio_page(folio, i);
 
-			if (hstate_is_gigantic(dst))
-				prep_compound_gigantic_folio_for_demote(page_folio(page),
-									dst->order);
-			else
-				prep_compound_page(page, dst->order);
-			set_page_private(page, 0);
+			page->mapping = NULL;
+			clear_compound_head(page);
+			prep_compound_page(page, dst->order);
 
 			init_new_hugetlb_folio(dst, page_folio(page));
 			list_add(&page->lru, &dst_list);
-- 
2.46.0.76.ge559c4bf1a-goog


