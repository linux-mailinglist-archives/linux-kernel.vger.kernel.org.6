Return-Path: <linux-kernel+bounces-285828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB82951341
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 05:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B41DB1F236BB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 03:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6824D8BC;
	Wed, 14 Aug 2024 03:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fGnquox3"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4FA55897
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 03:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723607706; cv=none; b=nJsVUhZfhza+2ScxiYGYLZ5X8nsFG3RDW60I/OA3tycra5yTdJfXvgrWuWPGAvl6G52Vp7HnW6T90CXKphu5/Hv3uuVm0hWCBewIugc4jE+09i7+zjaYmkf+7g1HL0l92HylIdkJ7jEBSpaNOz35cDHGOb2V3K6q9dVs3Fvg3tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723607706; c=relaxed/simple;
	bh=liwPWDuJdhKGA9jzCfGi1YsMlcAe/sxxhEhTvOTxuh8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ehub0hyUoClmoKid8Si64b4FmkjdEvz6qR++1I2n99jkdKGVHiVV0/yagwZIhBQj//n2nd8Y897oVovoiaez0aTRqRlwL3cAm6rSKc2b2xXDyBgcTnyCvFS6uUnOcv0emDDYSP7INHedTYWT9CVaPJCAk1l85lU686NObBWchNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fGnquox3; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-664916e5b40so7253627b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 20:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723607703; x=1724212503; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HkJWh1CGI1FKnB7gI7WJokGF2tPUwAHyBE8neIj6WOo=;
        b=fGnquox3WU98lTwyWpfEKOPZmHFcbSyTlEuinaj7GVD1c7kCAmBvXHJn5xAW8DztiF
         9Iqn3wRCJrATLJBBmc0ocrPf8XdEqWgAqs9pwACCs3Ft2BCu0v5d576SK+b/+aCkenkA
         QmO0YswZzNkfeOmLb9KOVA98PfIjfEDi5NG1H273eQ2tz/mrxPj6iglNopeaFkAtKbNR
         eBnvsdWQl6USmTP3UHjETBzP7dF7DzUXTbq5e9xUoHnDKHYC9ONzQg/75wGCi74Qj1tu
         0MWhUe4ZgwVAXKr87m+l7JwBi+T1jM5N9guitpAZHev2pQYTBbYDJdObYb3VqgS06f5u
         qG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723607703; x=1724212503;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HkJWh1CGI1FKnB7gI7WJokGF2tPUwAHyBE8neIj6WOo=;
        b=sRe/mrcI7qErEsN/F6KDmCX+soBOTCLv9/YzuaQivft+Hbd6sbBWH64GxvAJj4jrI2
         VqIu5Pg5vxX9LaoK9MuHKSm5XplNCGxKdxsj4W38OeaPHBmxz36fbWuLWEcDr3JJnybe
         Ngah875R06ZqZE4aU3QuNGG2v0SPbdMILxIckf483GdQPEu8KCBJeZQdLKmdPZ1m8sPd
         B7cVozf4KVEZH9AboUwq+C32+Ahses19w+quvlNG21ZwzNfCsJIrekRQOaA/TcTf82NZ
         g7EytiWkBs198E5p2HLkNGyNTnYUMPUibZ/qjewR3xU8k1o1CrmXR8GSPz8d1ARcT/1d
         zdIg==
X-Forwarded-Encrypted: i=1; AJvYcCXYiiVWhgREh5GEtGRVRoHD1FrzqHBIJOBKlY4LQ07ci7JPBeMgclZUOhI8Qg4gxYFvswYaQeGQc+fN9L6PcKR2CQ96me9rEpLRJMQ1
X-Gm-Message-State: AOJu0YwKhlJdNBbXicGDAjDxBMfGfP6wkvKZ/BltqKHT1l5L6qrwIa7g
	sUZEk+cNz4WqCjyTNG9/++Dzm4xpCnuvQ131cimeqSEh31upzSso8+cVYcMFPMkrJ5aiQYC0S5l
	Awg==
X-Google-Smtp-Source: AGHT+IHlK/IkcXuFcqXLClLnBVvhuHrceOZTwz1/3YMEoi3KsLnVOrd8HqQm1xPKhmDUfIMOuGUHSIQI8zs=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:c8ad:fcc7:f7cf:f2fd])
 (user=yuzhao job=sendgmr) by 2002:a0d:d147:0:b0:651:2eea:4dfe with SMTP id
 00721157ae682-6a9df63c480mr685617b3.0.1723607703133; Tue, 13 Aug 2024
 20:55:03 -0700 (PDT)
Date: Tue, 13 Aug 2024 21:54:51 -0600
In-Reply-To: <20240814035451.773331-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240814035451.773331-1-yuzhao@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240814035451.773331-4-yuzhao@google.com>
Subject: [PATCH mm-unstable v2 3/3] mm/hugetlb: use __GFP_COMP for gigantic folios
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>, 
	Frank van der Linden <fvdl@google.com>
Content-Type: text/plain; charset="UTF-8"

Use __GFP_COMP for gigantic folios to greatly reduce not only the
amount of code but also the allocation and free time.

LOC (approximately): +60, -240

Allocate and free 500 1GB hugeTLB memory without HVO by:
  time echo 500 >/sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
  time echo 0 >/sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages

       Before  After
Alloc  ~13s    ~10s
Free   ~15s    <1s

The above magnitude generally holds for multiple x86 and arm64 CPU
models.

Signed-off-by: Yu Zhao <yuzhao@google.com>
Reported-by: Frank van der Linden <fvdl@google.com>
---
 include/linux/hugetlb.h |   9 +-
 mm/hugetlb.c            | 293 ++++++++--------------------------------
 2 files changed, 62 insertions(+), 240 deletions(-)

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
index 71d469c8e711..efa77ce87dcc 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -56,16 +56,6 @@ struct hstate hstates[HUGE_MAX_HSTATE];
 #ifdef CONFIG_CMA
 static struct cma *hugetlb_cma[MAX_NUMNODES];
 static unsigned long hugetlb_cma_size_in_node[MAX_NUMNODES] __initdata;
-static bool hugetlb_cma_folio(struct folio *folio, unsigned int order)
-{
-	return cma_pages_valid(hugetlb_cma[folio_nid(folio)], &folio->page,
-				1 << order);
-}
-#else
-static bool hugetlb_cma_folio(struct folio *folio, unsigned int order)
-{
-	return false;
-}
 #endif
 static unsigned long hugetlb_cma_size __initdata;
 
@@ -100,6 +90,17 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
 		unsigned long start, unsigned long end);
 static struct resv_map *vma_resv_map(struct vm_area_struct *vma);
 
+static void hugetlb_free_folio(struct folio *folio)
+{
+#ifdef CONFIG_CMA
+	int nid = folio_nid(folio);
+
+	if (cma_free_folio(hugetlb_cma[nid], folio))
+		return;
+#endif
+	folio_put(folio);
+}
+
 static inline bool subpool_is_free(struct hugepage_subpool *spool)
 {
 	if (spool->count)
@@ -1512,95 +1513,54 @@ static int hstate_next_node_to_free(struct hstate *h, nodemask_t *nodes_allowed)
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
-static void free_gigantic_folio(struct folio *folio, unsigned int order)
-{
-	/*
-	 * If the page isn't allocated using the cma allocator,
-	 * cma_release() returns false.
-	 */
-#ifdef CONFIG_CMA
-	int nid = folio_nid(folio);
-
-	if (cma_release(hugetlb_cma[nid], &folio->page, 1 << order))
-		return;
-#endif
-
-	free_contig_range(folio_pfn(folio), 1 << order);
-}
-
 #ifdef CONFIG_CONTIG_ALLOC
 static struct folio *alloc_gigantic_folio(struct hstate *h, gfp_t gfp_mask,
 		int nid, nodemask_t *nodemask)
 {
-	struct page *page;
-	unsigned long nr_pages = pages_per_huge_page(h);
+	struct folio *folio;
+	int order = huge_page_order(h);
+	bool retried = false;
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
+		folio = folio_alloc_gigantic(order, gfp_mask, nid, nodemask);
+		if (!folio)
+			return NULL;
+	}
 
-	page = alloc_contig_pages(nr_pages, gfp_mask, nid, nodemask);
-	return page ? page_folio(page) : NULL;
+	if (folio_ref_freeze(folio, 1))
+		return folio;
+
+	pr_warn("HugeTLB: unexpected refcount on PFN %lu\n", folio_pfn(folio));
+	hugetlb_free_folio(folio);
+	if (!retried) {
+		retried = true;
+		goto retry;
+	}
+	return NULL;
 }
 
 #else /* !CONFIG_CONTIG_ALLOC */
@@ -1617,10 +1577,6 @@ static struct folio *alloc_gigantic_folio(struct hstate *h, gfp_t gfp_mask,
 {
 	return NULL;
 }
-static inline void free_gigantic_folio(struct folio *folio,
-						unsigned int order) { }
-static inline void destroy_compound_gigantic_folio(struct folio *folio,
-						unsigned int order) { }
 #endif
 
 /*
@@ -1747,20 +1703,9 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 		folio_clear_hugetlb_hwpoison(folio);
 
 	folio_ref_unfreeze(folio, 1);
-
-	/*
-	 * Non-gigantic pages demoted from CMA allocated gigantic pages
-	 * need to be given back to CMA in free_gigantic_folio.
-	 */
-	if (hstate_is_gigantic(h) ||
-	    hugetlb_cma_folio(folio, huge_page_order(h))) {
-		destroy_compound_gigantic_folio(folio, huge_page_order(h));
-		free_gigantic_folio(folio, huge_page_order(h));
-	} else {
-		INIT_LIST_HEAD(&folio->_deferred_list);
-		folio_clear_partially_mapped(folio);
-		folio_put(folio);
-	}
+	INIT_LIST_HEAD(&folio->_deferred_list);
+	folio_clear_partially_mapped(folio);
+	hugetlb_free_folio(folio);
 }
 
 /*
@@ -2033,95 +1978,6 @@ static void prep_new_hugetlb_folio(struct hstate *h, struct folio *folio, int ni
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
@@ -2160,7 +2016,6 @@ static struct folio *alloc_buddy_hugetlb_folio(struct hstate *h,
 	 */
 	if (node_alloc_noretry && node_isset(nid, *node_alloc_noretry))
 		alloc_try_hard = false;
-	gfp_mask |= __GFP_COMP|__GFP_NOWARN;
 	if (alloc_try_hard)
 		gfp_mask |= __GFP_RETRY_MAYFAIL;
 	if (nid == NUMA_NO_NODE)
@@ -2207,48 +2062,16 @@ static struct folio *alloc_buddy_hugetlb_folio(struct hstate *h,
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
+	if (hstate_is_gigantic(h))
+		folio = alloc_gigantic_folio(h, gfp_mask, nid, nmask);
+	else
+		folio = alloc_buddy_hugetlb_folio(h, gfp_mask, nid, nmask, node_alloc_noretry);
 	if (folio)
 		init_new_hugetlb_folio(h, folio);
 	return folio;
@@ -2266,7 +2089,10 @@ static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
 {
 	struct folio *folio;
 
-	folio = __alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask, NULL);
+	if (hstate_is_gigantic(h))
+		folio = alloc_gigantic_folio(h, gfp_mask, nid, nmask);
+	else
+		folio = alloc_buddy_hugetlb_folio(h, gfp_mask, nid, nmask, NULL);
 	if (!folio)
 		return NULL;
 
@@ -2550,9 +2376,8 @@ struct folio *alloc_buddy_hugetlb_folio_with_mpol(struct hstate *h,
 
 	nid = huge_node(vma, addr, gfp_mask, &mpol, &nodemask);
 	if (mpol_is_preferred_many(mpol)) {
-		gfp_t gfp = gfp_mask | __GFP_NOWARN;
+		gfp_t gfp = gfp_mask & ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
 
-		gfp &=  ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
 		folio = alloc_surplus_hugetlb_folio(h, gfp, nid, nodemask);
 
 		/* Fallback to all nodes if page==NULL */
@@ -3334,6 +3159,7 @@ static void __init hugetlb_folio_init_tail_vmemmap(struct folio *folio,
 	for (pfn = head_pfn + start_page_number; pfn < end_pfn; pfn++) {
 		struct page *page = pfn_to_page(pfn);
 
+		__ClearPageReserved(folio_page(folio, pfn - head_pfn));
 		__init_single_page(page, pfn, zone, nid);
 		prep_compound_tail((struct page *)folio, pfn - head_pfn);
 		ret = page_ref_freeze(page, 1);
@@ -3950,21 +3776,16 @@ static long demote_free_hugetlb_folios(struct hstate *src, struct hstate *dst,
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


