Return-Path: <linux-kernel+bounces-285826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8910595133F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 05:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ED002853D9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 03:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA91F4D8BA;
	Wed, 14 Aug 2024 03:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qG9cDT9L"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDD93FBB2
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 03:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723607700; cv=none; b=XOeIRjhhsk8VYJgo/edRHPCyK641pwCE9YBKiOdp4m6w1aC5ShVKacRIzJbgH7I14USzdyvQpOHZF2hqFmZUxpr1r0SnnS7Dos/pTlDJmsSxpN/SslQaKIPr+mQNxFHSlZ9VVHy4xEDu9sB1t1xf0/X+aZAykM3n6DUQCqAC8fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723607700; c=relaxed/simple;
	bh=pUCvHNndpaTv519hWrkis78L9CpJ/pGAHkS248phQmI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TR3/D1YPsUZC8Sryc/oQ/gPDlJ3kWP6Vx+1+pmOlV57SSKDs+s+EZSu6t3bAT3hiRX/M3bOcai3typ7DB8HTgo5q+UTk/Cn9y587+XMiyTaoRbdzgN/d9t3lKVrGoi0I2Csg3n8HGs5kX6Xw1YQ9E8zFVJPFzza/V9dEBES5mYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qG9cDT9L; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-690404fd230so130355247b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 20:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723607698; x=1724212498; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BGqmRlGLO1UPrtqcDwqRzTwlBOD38mCYYr0sMrb4o6s=;
        b=qG9cDT9LjKSNAngpMSHW+eu0FszoLgWSiFC9vrsOTc2LXTM06ubUKmWDEPuUeikNEz
         JuA3OmyPSOqyGyUOi1n5ud1jFLyLLvfQCp4NEGySmpRCG+DFiG0JoHIRgCBiqjoe8VTW
         vporll9areUmZGrSOYq1jagzBa9quFQ9TpLfE1Egg84t0wUMOZHEJsORE8Al+t5LYRS6
         JJCg7hoJgxlAkw6oITAZsdR4h1oYyF7jds0vaTSmxBV34usMbiLT8XzuGX94J5VX3XfB
         PDQ4DJ6L4lA0F4Y3lTm733yq8wILu0jzVa5kNjuPjTxsvSfWEZIK4PdPhnPMAOkxH6ff
         VqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723607698; x=1724212498;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BGqmRlGLO1UPrtqcDwqRzTwlBOD38mCYYr0sMrb4o6s=;
        b=SEXAhfmdnjZIY2HYmAtI5BWRZXs8k82LDI/kKiO5SF8I6DD6pw7lkMy2jK/bF1i7Pi
         neFhC+oX2h0z06+usL9fLkMqgqr4iIfbYXAtHVm+srZ8EpLLRo/vRrocjYSecJrtHOgX
         1d2ZzenBqeSg6DvsOFE5l+JucSc50R0BNQZZR3gOVjFYaKPebcWiT9Wvi5CAu8xtCLKv
         alp3PmSN6MHnNYo7SQoEFnRuBY0gVL3K3xHvB/e3+bQ7QJBESr5IXJdXOtPbvOkuI3To
         wFrqQvmNascCw5OplgyoXCJCnqZ/c0nDSX6Xi5iQAx3j/NBV6AQ7ih/qOYenTkx/Vwq+
         PuuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWq0XlaQcO8CO32VULZSbRi7oYkpHjmcyfFWuBB5IUQv9cPDtmeRO253kjFFpF9J4n6FXQvWC/3hEVg0Vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOdheE0rLo1wGW588rI0YbIrv+m0swRZh5cqbaXdGFBI1K4LaE
	p7SkSaTMnLna+luW4aJvVz+SLF/nZ+FNnEPY65QOiV/0ncLJiAaIl4mW2ZgNkbDMn2iAmlthkiu
	RTw==
X-Google-Smtp-Source: AGHT+IHF7I7tjKFaxxVwyOf6J4cLNGcmd7dtJ8TUkzqBnzt3BcUh4JMTZUA9JOZpfjEC0zAqGoYWe8MmT6c=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:c8ad:fcc7:f7cf:f2fd])
 (user=yuzhao job=sendgmr) by 2002:a05:690c:2f09:b0:689:315b:cbfc with SMTP id
 00721157ae682-6ac9b7b1a2fmr44757b3.6.1723607697910; Tue, 13 Aug 2024 20:54:57
 -0700 (PDT)
Date: Tue, 13 Aug 2024 21:54:49 -0600
In-Reply-To: <20240814035451.773331-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240814035451.773331-1-yuzhao@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240814035451.773331-2-yuzhao@google.com>
Subject: [PATCH mm-unstable v2 1/3] mm/contig_alloc: support __GFP_COMP
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"

Support __GFP_COMP in alloc_contig_range(). When the flag is set, upon
success the function returns a large folio prepared by
prep_new_page(), rather than a range of order-0 pages prepared by
split_free_pages() (which is renamed from split_map_pages()).

alloc_contig_range() can be used to allocate folios larger than
MAX_PAGE_ORDER, e.g., gigantic hugeTLB folios. So on the free path,
free_one_page() needs to handle that by split_large_buddy().

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/gfp.h |  23 +++++++++
 mm/compaction.c     |  41 ++--------------
 mm/page_alloc.c     | 111 +++++++++++++++++++++++++++++++-------------
 3 files changed, 108 insertions(+), 67 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index f53f76e0b17e..59266df56aeb 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -446,4 +446,27 @@ extern struct page *alloc_contig_pages_noprof(unsigned long nr_pages, gfp_t gfp_
 #endif
 void free_contig_range(unsigned long pfn, unsigned long nr_pages);
 
+#ifdef CONFIG_CONTIG_ALLOC
+static inline struct folio *folio_alloc_gigantic_noprof(int order, gfp_t gfp,
+							int nid, nodemask_t *node)
+{
+	struct page *page;
+
+	if (WARN_ON(!order || !(gfp | __GFP_COMP)))
+		return NULL;
+
+	page = alloc_contig_pages_noprof(1 << order, gfp, nid, node);
+
+	return page ? page_folio(page) : NULL;
+}
+#else
+static inline struct folio *folio_alloc_gigantic_noprof(int order, gfp_t gfp,
+							int nid, nodemask_t *node)
+{
+	return NULL;
+}
+#endif
+/* This should be paired with folio_put() rather than free_contig_range(). */
+#define folio_alloc_gigantic(...) alloc_hooks(folio_alloc_gigantic_noprof(__VA_ARGS__))
+
 #endif /* __LINUX_GFP_H */
diff --git a/mm/compaction.c b/mm/compaction.c
index eb95e9b435d0..d1041fbce679 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -86,33 +86,6 @@ static struct page *mark_allocated_noprof(struct page *page, unsigned int order,
 }
 #define mark_allocated(...)	alloc_hooks(mark_allocated_noprof(__VA_ARGS__))
 
-static void split_map_pages(struct list_head *freepages)
-{
-	unsigned int i, order;
-	struct page *page, *next;
-	LIST_HEAD(tmp_list);
-
-	for (order = 0; order < NR_PAGE_ORDERS; order++) {
-		list_for_each_entry_safe(page, next, &freepages[order], lru) {
-			unsigned int nr_pages;
-
-			list_del(&page->lru);
-
-			nr_pages = 1 << order;
-
-			mark_allocated(page, order, __GFP_MOVABLE);
-			if (order)
-				split_page(page, order);
-
-			for (i = 0; i < nr_pages; i++) {
-				list_add(&page->lru, &tmp_list);
-				page++;
-			}
-		}
-		list_splice_init(&tmp_list, &freepages[0]);
-	}
-}
-
 static unsigned long release_free_list(struct list_head *freepages)
 {
 	int order;
@@ -742,11 +715,11 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
  *
  * Non-free pages, invalid PFNs, or zone boundaries within the
  * [start_pfn, end_pfn) range are considered errors, cause function to
- * undo its actions and return zero.
+ * undo its actions and return zero. cc->freepages[] are empty.
  *
  * Otherwise, function returns one-past-the-last PFN of isolated page
  * (which may be greater then end_pfn if end fell in a middle of
- * a free page).
+ * a free page). cc->freepages[] contain free pages isolated.
  */
 unsigned long
 isolate_freepages_range(struct compact_control *cc,
@@ -754,10 +727,9 @@ isolate_freepages_range(struct compact_control *cc,
 {
 	unsigned long isolated, pfn, block_start_pfn, block_end_pfn;
 	int order;
-	struct list_head tmp_freepages[NR_PAGE_ORDERS];
 
 	for (order = 0; order < NR_PAGE_ORDERS; order++)
-		INIT_LIST_HEAD(&tmp_freepages[order]);
+		INIT_LIST_HEAD(&cc->freepages[order]);
 
 	pfn = start_pfn;
 	block_start_pfn = pageblock_start_pfn(pfn);
@@ -788,7 +760,7 @@ isolate_freepages_range(struct compact_control *cc,
 			break;
 
 		isolated = isolate_freepages_block(cc, &isolate_start_pfn,
-					block_end_pfn, tmp_freepages, 0, true);
+					block_end_pfn, cc->freepages, 0, true);
 
 		/*
 		 * In strict mode, isolate_freepages_block() returns 0 if
@@ -807,13 +779,10 @@ isolate_freepages_range(struct compact_control *cc,
 
 	if (pfn < end_pfn) {
 		/* Loop terminated early, cleanup. */
-		release_free_list(tmp_freepages);
+		release_free_list(cc->freepages);
 		return 0;
 	}
 
-	/* __isolate_free_page() does not map the pages */
-	split_map_pages(tmp_freepages);
-
 	/* We don't use freelists for anything. */
 	return pfn;
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5841bbea482a..0a43e4ea29e4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1197,16 +1197,36 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 	spin_unlock_irqrestore(&zone->lock, flags);
 }
 
+/* Split a multi-block free page into its individual pageblocks. */
+static void split_large_buddy(struct zone *zone, struct page *page,
+			      unsigned long pfn, int order, fpi_t fpi)
+{
+	unsigned long end = pfn + (1 << order);
+
+	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn, 1 << order));
+	/* Caller removed page from freelist, buddy info cleared! */
+	VM_WARN_ON_ONCE(PageBuddy(page));
+
+	if (order > pageblock_order)
+		order = pageblock_order;
+
+	while (pfn != end) {
+		int mt = get_pfnblock_migratetype(page, pfn);
+
+		__free_one_page(page, pfn, zone, order, mt, fpi);
+		pfn += 1 << order;
+		page = pfn_to_page(pfn);
+	}
+}
+
 static void free_one_page(struct zone *zone, struct page *page,
 			  unsigned long pfn, unsigned int order,
 			  fpi_t fpi_flags)
 {
 	unsigned long flags;
-	int migratetype;
 
 	spin_lock_irqsave(&zone->lock, flags);
-	migratetype = get_pfnblock_migratetype(page, pfn);
-	__free_one_page(page, pfn, zone, order, migratetype, fpi_flags);
+	split_large_buddy(zone, page, pfn, order, fpi_flags);
 	spin_unlock_irqrestore(&zone->lock, flags);
 }
 
@@ -1698,27 +1718,6 @@ static unsigned long find_large_buddy(unsigned long start_pfn)
 	return start_pfn;
 }
 
-/* Split a multi-block free page into its individual pageblocks */
-static void split_large_buddy(struct zone *zone, struct page *page,
-			      unsigned long pfn, int order)
-{
-	unsigned long end_pfn = pfn + (1 << order);
-
-	VM_WARN_ON_ONCE(order <= pageblock_order);
-	VM_WARN_ON_ONCE(pfn & (pageblock_nr_pages - 1));
-
-	/* Caller removed page from freelist, buddy info cleared! */
-	VM_WARN_ON_ONCE(PageBuddy(page));
-
-	while (pfn != end_pfn) {
-		int mt = get_pfnblock_migratetype(page, pfn);
-
-		__free_one_page(page, pfn, zone, pageblock_order, mt, FPI_NONE);
-		pfn += pageblock_nr_pages;
-		page = pfn_to_page(pfn);
-	}
-}
-
 /**
  * move_freepages_block_isolate - move free pages in block for page isolation
  * @zone: the zone
@@ -1759,7 +1758,7 @@ bool move_freepages_block_isolate(struct zone *zone, struct page *page,
 		del_page_from_free_list(buddy, zone, order,
 					get_pfnblock_migratetype(buddy, pfn));
 		set_pageblock_migratetype(page, migratetype);
-		split_large_buddy(zone, buddy, pfn, order);
+		split_large_buddy(zone, buddy, pfn, order, FPI_NONE);
 		return true;
 	}
 
@@ -1770,7 +1769,7 @@ bool move_freepages_block_isolate(struct zone *zone, struct page *page,
 		del_page_from_free_list(page, zone, order,
 					get_pfnblock_migratetype(page, pfn));
 		set_pageblock_migratetype(page, migratetype);
-		split_large_buddy(zone, page, pfn, order);
+		split_large_buddy(zone, page, pfn, order, FPI_NONE);
 		return true;
 	}
 move:
@@ -6440,6 +6439,31 @@ int __alloc_contig_migrate_range(struct compact_control *cc,
 	return (ret < 0) ? ret : 0;
 }
 
+static void split_free_pages(struct list_head *list)
+{
+	int order;
+
+	for (order = 0; order < NR_PAGE_ORDERS; order++) {
+		struct page *page, *next;
+		int nr_pages = 1 << order;
+
+		list_for_each_entry_safe(page, next, &list[order], lru) {
+			int i;
+
+			post_alloc_hook(page, order, __GFP_MOVABLE);
+			if (!order)
+				continue;
+
+			split_page(page, order);
+
+			/* Add all subpages to the order-0 head, in sequence. */
+			list_del(&page->lru);
+			for (i = 0; i < nr_pages; i++)
+				list_add_tail(&page[i].lru, &list[0]);
+		}
+	}
+}
+
 /**
  * alloc_contig_range() -- tries to allocate given range of pages
  * @start:	start PFN to allocate
@@ -6552,12 +6576,25 @@ int alloc_contig_range_noprof(unsigned long start, unsigned long end,
 		goto done;
 	}
 
-	/* Free head and tail (if any) */
-	if (start != outer_start)
-		free_contig_range(outer_start, start - outer_start);
-	if (end != outer_end)
-		free_contig_range(end, outer_end - end);
+	if (!(gfp_mask & __GFP_COMP)) {
+		split_free_pages(cc.freepages);
 
+		/* Free head and tail (if any) */
+		if (start != outer_start)
+			free_contig_range(outer_start, start - outer_start);
+		if (end != outer_end)
+			free_contig_range(end, outer_end - end);
+	} else if (start == outer_start && end == outer_end && is_power_of_2(end - start)) {
+		struct page *head = pfn_to_page(start);
+		int order = ilog2(end - start);
+
+		check_new_pages(head, order);
+		prep_new_page(head, order, gfp_mask, 0);
+	} else {
+		ret = -EINVAL;
+		WARN(true, "PFN range: requested [%lu, %lu), allocated [%lu, %lu)\n",
+		     start, end, outer_start, outer_end);
+	}
 done:
 	undo_isolate_page_range(start, end, migratetype);
 	return ret;
@@ -6666,6 +6703,18 @@ struct page *alloc_contig_pages_noprof(unsigned long nr_pages, gfp_t gfp_mask,
 void free_contig_range(unsigned long pfn, unsigned long nr_pages)
 {
 	unsigned long count = 0;
+	struct folio *folio = pfn_folio(pfn);
+
+	if (folio_test_large(folio)) {
+		int expected = folio_nr_pages(folio);
+
+		if (nr_pages == expected)
+			folio_put(folio);
+		else
+			WARN(true, "PFN %lu: nr_pages %lu != expected %d\n",
+			     pfn, nr_pages, expected);
+		return;
+	}
 
 	for (; nr_pages--; pfn++) {
 		struct page *page = pfn_to_page(pfn);
-- 
2.46.0.76.ge559c4bf1a-goog


