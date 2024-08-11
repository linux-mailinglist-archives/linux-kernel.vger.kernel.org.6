Return-Path: <linux-kernel+bounces-282396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F413994E350
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 23:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB3C02816AD
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 21:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3569115FD08;
	Sun, 11 Aug 2024 21:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mr28u22f"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7BA15C137
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 21:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723411298; cv=none; b=GS7BNSGSaZWFWTsKMdA4KP8zBdGhpiKLOhX9U+xzF30XJ+9eKDdK6akjcqhx4CXGQU2q3E+KNRWuCMDFKq78cKvz8911AdD1VXYyhwVIuZPVZ2EQxiekydT8S7w6JCqfHbi2g6jLblUTWqH7SeU48u/CpjLMuoelqLggh4bsCxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723411298; c=relaxed/simple;
	bh=CxucUH6eTkoQX20WqNxvTvPTAh0/zOMUPLj1GJwi7lA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nVQ190U2RqNG/dyVxj7i1u9MW5rXAIaeVggyWkxYWfCcXo1Xz9wnk2zN/u5W+Ix+jodjQrTRy+Zlr6M/AdlFHOE8DtavBLIcK9he4iUN5KowBDPRS/CCrzyVEHFdrINaGPzK/jbofvrJbb0GItHk8tVmX7/ZLBQkAildahBe5qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mr28u22f; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-654d96c2bb5so71758667b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 14:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723411295; x=1724016095; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=THGaYoJGBVo1NFT+ygjobh7TePYwQA+eDE4p3qbAKWk=;
        b=mr28u22fLVZHFPKPupNnpX1VvV0A/jz074pfLA0e/uYL+5OAXng6I+vwPnHpfxBaoT
         hK0iW+XUmMiUzEV42t0jbkjDBrMisBHKIK+icIrZwoFtmn7AEXGfa0ItActVUg4WOvW7
         Xm3objDgMj7vlHghjB3pg29Dulx1bs1x9nF6P8QhlVZGhpBvU2eE2+aVL8By5WHfL/H/
         J6Kp21YAgatpIWJF0rUDYBJmJP6g1TcFoatPBwsQS/uvxcuNc59a8kxT53GrURbpUMrr
         xRz9wgXV2UL1VM9ENUd+adH7FsJrozD9fztQn+roDqURxQqxwHv5SGAZrJGbCjYyk+yk
         rAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723411295; x=1724016095;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=THGaYoJGBVo1NFT+ygjobh7TePYwQA+eDE4p3qbAKWk=;
        b=pA9oHxsE8v2pjZxjAT4qogaQ4Q9mZrminVj1ezT8yNV5znSNX9XISUaKgD0nKFwkVX
         GLHluuKGHk1sqGs1sagf9I4K8b/V3zp/daOdFLhdVB7fW5YFL9nIH1ItePZBypvUiqV6
         KTmafPgSX1QNnSwHWzMYXpWRDZGa3NIHhYx2d55wFQze9cdmEiCS2iCoM3evcLk5Rf2x
         fOLMbZDruYmjqtt0Qos8J3Zv+MGULplpo8BAu5GAdKcslT+n5XWb9mzLRWodd80AjqpW
         yG9Z9f+yQKqfyLGEicvRoiX9QSM1Ue+86ceirdWSOizs4ZShMbLGJSA9IHUTBpr2RtEB
         uEWA==
X-Forwarded-Encrypted: i=1; AJvYcCXJqikFu7ZoQDyTkM3CYWmi3Geq5PiTzgtepS924USuUIRX+5kpdWW6ikSH4I6jKNZMSO1xDsoKNByLZZIlb4iIfj7jdW0aD2osR6m5
X-Gm-Message-State: AOJu0YyKyhQ4vV76fw3ac/pPGOAfgy6L7L50rZ7EXDk0Xc7SlUG2V3Pj
	4D+WfCMKCpXOWHpKgGmbZeC5uypzQL7BT3ebUAsMXStpifn23MbKJmhK1LYnRJwBXwEWLSJoSPg
	24A==
X-Google-Smtp-Source: AGHT+IGkx0nGnqUgrMKet1uE7S+7hqwGUl1ojaHvm5FZlh6Ngw6ccwePmfpItDUFlv/Deh8AXgWhV/Td5YI=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:c9c:12b4:a1e3:7f10])
 (user=yuzhao job=sendgmr) by 2002:a25:dc8d:0:b0:e0e:4350:d7de with SMTP id
 3f1490d57ef6-e0eb9a28207mr13988276.9.1723411295441; Sun, 11 Aug 2024 14:21:35
 -0700 (PDT)
Date: Sun, 11 Aug 2024 15:21:27 -0600
In-Reply-To: <20240811212129.3074314-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240811212129.3074314-1-yuzhao@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240811212129.3074314-2-yuzhao@google.com>
Subject: [PATCH mm-unstable v1 1/3] mm/contig_alloc: support __GFP_COMP
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"

Support __GFP_COMP in alloc_contig_range(). When the flag is set, upon
success the function returns a large folio prepared by
prep_new_page(), rather than a range of order-0 pages prepared by
split_free_pages() (which is renamed from split_map_pages()).

alloc_contig_range() can return folios larger than MAX_PAGE_ORDER,
e.g., gigantic hugeTLB folios. As a result, on the free path
free_one_page() needs to handle this case by split_large_buddy(), in
addition to free_contig_range() properly handling large folios by
folio_put().

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/compaction.c |  48 +++------------------
 mm/internal.h   |   9 ++++
 mm/page_alloc.c | 111 ++++++++++++++++++++++++++++++++++--------------
 3 files changed, 94 insertions(+), 74 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index eb95e9b435d0..1ebfef98e1d0 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -79,40 +79,6 @@ static inline bool is_via_compact_memory(int order) { return false; }
 #define COMPACTION_HPAGE_ORDER	(PMD_SHIFT - PAGE_SHIFT)
 #endif
 
-static struct page *mark_allocated_noprof(struct page *page, unsigned int order, gfp_t gfp_flags)
-{
-	post_alloc_hook(page, order, __GFP_MOVABLE);
-	return page;
-}
-#define mark_allocated(...)	alloc_hooks(mark_allocated_noprof(__VA_ARGS__))
-
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
@@ -742,11 +708,11 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
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
@@ -754,10 +720,9 @@ isolate_freepages_range(struct compact_control *cc,
 {
 	unsigned long isolated, pfn, block_start_pfn, block_end_pfn;
 	int order;
-	struct list_head tmp_freepages[NR_PAGE_ORDERS];
 
 	for (order = 0; order < NR_PAGE_ORDERS; order++)
-		INIT_LIST_HEAD(&tmp_freepages[order]);
+		INIT_LIST_HEAD(&cc->freepages[order]);
 
 	pfn = start_pfn;
 	block_start_pfn = pageblock_start_pfn(pfn);
@@ -788,7 +753,7 @@ isolate_freepages_range(struct compact_control *cc,
 			break;
 
 		isolated = isolate_freepages_block(cc, &isolate_start_pfn,
-					block_end_pfn, tmp_freepages, 0, true);
+					block_end_pfn, cc->freepages, 0, true);
 
 		/*
 		 * In strict mode, isolate_freepages_block() returns 0 if
@@ -807,13 +772,10 @@ isolate_freepages_range(struct compact_control *cc,
 
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
diff --git a/mm/internal.h b/mm/internal.h
index acda347620c6..03e795ce755f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -679,6 +679,15 @@ extern void prep_compound_page(struct page *page, unsigned int order);
 
 extern void post_alloc_hook(struct page *page, unsigned int order,
 					gfp_t gfp_flags);
+
+static inline struct page *post_alloc_hook_noprof(struct page *page, unsigned int order,
+						  gfp_t gfp_flags)
+{
+	post_alloc_hook(page, order, __GFP_MOVABLE);
+	return page;
+}
+#define mark_allocated(...) alloc_hooks(post_alloc_hook_noprof(__VA_ARGS__))
+
 extern bool free_pages_prepare(struct page *page, unsigned int order);
 
 extern int user_min_free_kbytes;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 84a7154fde93..6c801404a108 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1196,16 +1196,36 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 	spin_unlock_irqrestore(&zone->lock, flags);
 }
 
+/* Split a multi-block free page into its individual pageblocks */
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
 
@@ -1697,27 +1717,6 @@ static unsigned long find_large_buddy(unsigned long start_pfn)
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
@@ -1758,7 +1757,7 @@ bool move_freepages_block_isolate(struct zone *zone, struct page *page,
 		del_page_from_free_list(buddy, zone, order,
 					get_pfnblock_migratetype(buddy, pfn));
 		set_pageblock_migratetype(page, migratetype);
-		split_large_buddy(zone, buddy, pfn, order);
+		split_large_buddy(zone, buddy, pfn, order, FPI_NONE);
 		return true;
 	}
 
@@ -1769,7 +1768,7 @@ bool move_freepages_block_isolate(struct zone *zone, struct page *page,
 		del_page_from_free_list(page, zone, order,
 					get_pfnblock_migratetype(page, pfn));
 		set_pageblock_migratetype(page, migratetype);
-		split_large_buddy(zone, page, pfn, order);
+		split_large_buddy(zone, page, pfn, order, FPI_NONE);
 		return true;
 	}
 move:
@@ -6482,6 +6481,31 @@ int __alloc_contig_migrate_range(struct compact_control *cc,
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
+			mark_allocated(page, order, __GFP_MOVABLE);
+			if (!order)
+				continue;
+
+			split_page(page, order);
+
+			/* add all subpages to the order-0 head, in sequence */
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
@@ -6594,12 +6618,25 @@ int alloc_contig_range_noprof(unsigned long start, unsigned long end,
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
@@ -6708,6 +6745,18 @@ struct page *alloc_contig_pages_noprof(unsigned long nr_pages, gfp_t gfp_mask,
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


