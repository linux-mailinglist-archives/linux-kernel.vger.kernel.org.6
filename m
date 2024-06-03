Return-Path: <linux-kernel+bounces-199122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA8D8D8290
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7F71F25761
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C40A12C47D;
	Mon,  3 Jun 2024 12:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tDB4cice"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A795D83CAE
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 12:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717418491; cv=none; b=ZtUgj2tLb0FL49ZUfdyGzAzeVm9u7exUFk7rGmu64BF5jREn3snso7H0f6D/zpxJ60XQQ3Zvre9Oy475G12lgP7h/TH/pNOO19W/46ClvctaCdd/SeKlz+YDPLrUfwybGIkgQS42LBN0lUh46WCr0ddSjxElyFkL8kxF1SnlPJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717418491; c=relaxed/simple;
	bh=pw7/zYtOWsqdcg5Rb5GIBVjlAHj3ZBd1Pr2in+MLPNg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U7NyOfFuDkHdwATXiqPYzs3HhFYr4MKHPYfY7bFejyXEITCMn1P6gJT8RcDs32B78TjZo9Xzrnvq60f/yUPUBpG+XRyVAdSK8DruCB31aXJVw4dZeqNStlbOOLOpdwqcxwIld6bnHxDg7rY6nf1WVLaAH4IG2KE69+D4/BA9WvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tDB4cice; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717418486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r9ORv+D4KXvQw4kDs7LTGsygzFqYpk/yJ4Bzv0bGNrk=;
	b=tDB4ciceghAj/5wh/U5v3RkLjY6MlxxUatHh8wJtp+DjEwwESQu+JHk0ILtWTJpF3a9rjL
	VHbO2J0PHNrrWu8tLe5f/7bQFZv+b0nFpxmrtJdCIaWXwxmiXUklwRMRVOIBcl/iWqFuG9
	ndQbs2tpG22gH4zKmemKBAMvRxPO20U=
X-Envelope-To: rppt@kernel.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: yajun.deng@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yajun Deng <yajun.deng@linux.dev>
To: akpm@linux-foundation.org,
	rppt@kernel.org,
	hannes@cmpxchg.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] mm: pass the pfn to set_pageblock_migratetype
Date: Mon,  3 Jun 2024 20:41:00 +0800
Message-Id: <20240603124100.2834-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

It is necessary to calculate the pfn in the set_pageblock_migratetype(),
but most of the callers already have the pfn.

To reduce the calculation, pass the pfn to set_pageblock_migratetype().

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 include/linux/page-isolation.h |  2 +-
 mm/mm_init.c                   | 10 +++++-----
 mm/page_alloc.c                | 18 +++++++++---------
 mm/page_isolation.c            |  2 +-
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
index c16db0067090..b7d55f35eac0 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -33,7 +33,7 @@ static inline bool is_migrate_isolate(int migratetype)
 #define MEMORY_OFFLINE	0x1
 #define REPORT_FAILURE	0x2
 
-void set_pageblock_migratetype(struct page *page, int migratetype);
+void set_pageblock_migratetype(struct page *page, unsigned long pfn, int migratetype);
 
 bool move_freepages_block_isolate(struct zone *zone, struct page *page,
 				  int migratetype);
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 426314eeecec..85a98d3b8c0e 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -901,7 +901,7 @@ void __meminit memmap_init_range(unsigned long size, int nid, unsigned long zone
 		 * over the place during system boot.
 		 */
 		if (pageblock_aligned(pfn)) {
-			set_pageblock_migratetype(page, migratetype);
+			set_pageblock_migratetype(page, pfn, migratetype);
 			cond_resched();
 		}
 		pfn++;
@@ -1005,7 +1005,7 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 	 * because this is done early in section_activate()
 	 */
 	if (pageblock_aligned(pfn)) {
-		set_pageblock_migratetype(page, MIGRATE_MOVABLE);
+		set_pageblock_migratetype(page, pfn, MIGRATE_MOVABLE);
 		cond_resched();
 	}
 
@@ -1927,7 +1927,7 @@ static void __init deferred_free_range(unsigned long pfn,
 	/* Free a large naturally-aligned chunk if possible */
 	if (nr_pages == MAX_ORDER_NR_PAGES && IS_MAX_ORDER_ALIGNED(pfn)) {
 		for (i = 0; i < nr_pages; i += pageblock_nr_pages)
-			set_pageblock_migratetype(page + i, MIGRATE_MOVABLE);
+			set_pageblock_migratetype(page + i, pfn + i, MIGRATE_MOVABLE);
 		__free_pages_core(page, MAX_PAGE_ORDER);
 		return;
 	}
@@ -1937,7 +1937,7 @@ static void __init deferred_free_range(unsigned long pfn,
 
 	for (i = 0; i < nr_pages; i++, page++, pfn++) {
 		if (pageblock_aligned(pfn))
-			set_pageblock_migratetype(page, MIGRATE_MOVABLE);
+			set_pageblock_migratetype(page, pfn, MIGRATE_MOVABLE);
 		__free_pages_core(page, 0);
 	}
 }
@@ -2291,7 +2291,7 @@ void __init init_cma_reserved_pageblock(struct page *page)
 		set_page_count(p, 0);
 	} while (++p, --i);
 
-	set_pageblock_migratetype(page, MIGRATE_CMA);
+	set_pageblock_migratetype(page, page_to_pfn(page), MIGRATE_CMA);
 	set_page_refcounted(page);
 	__free_pages(page, pageblock_order);
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3734fe7e67c0..fe9d37f1b1e4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -412,14 +412,14 @@ void set_pfnblock_flags_mask(struct page *page, unsigned long flags,
 	} while (!try_cmpxchg(&bitmap[word_bitidx], &word, (word & ~mask) | flags));
 }
 
-void set_pageblock_migratetype(struct page *page, int migratetype)
+void set_pageblock_migratetype(struct page *page, unsigned long pfn, int migratetype)
 {
 	if (unlikely(page_group_by_mobility_disabled &&
 		     migratetype < MIGRATE_PCPTYPES))
 		migratetype = MIGRATE_UNMOVABLE;
 
 	set_pfnblock_flags_mask(page, (unsigned long)migratetype,
-				page_to_pfn(page), MIGRATETYPE_MASK);
+				pfn, MIGRATETYPE_MASK);
 }
 
 #ifdef CONFIG_DEBUG_VM
@@ -817,7 +817,7 @@ static inline void __free_one_page(struct page *page,
 			 * expand() down the line puts the sub-blocks
 			 * on the right freelists.
 			 */
-			set_pageblock_migratetype(buddy, migratetype);
+			set_pageblock_migratetype(buddy, buddy_pfn, migratetype);
 		}
 
 		combined_pfn = buddy_pfn & pfn;
@@ -1579,7 +1579,7 @@ static int __move_freepages_block(struct zone *zone, unsigned long start_pfn,
 		pages_moved += 1 << order;
 	}
 
-	set_pageblock_migratetype(pfn_to_page(start_pfn), new_mt);
+	set_pageblock_migratetype(pfn_to_page(start_pfn), start_pfn, new_mt);
 
 	return pages_moved;
 }
@@ -1730,7 +1730,7 @@ bool move_freepages_block_isolate(struct zone *zone, struct page *page,
 
 		del_page_from_free_list(buddy, zone, order,
 					get_pfnblock_migratetype(buddy, pfn));
-		set_pageblock_migratetype(page, migratetype);
+		set_pageblock_migratetype(page, page_to_pfn(page), migratetype);
 		split_large_buddy(zone, buddy, pfn, order);
 		return true;
 	}
@@ -1741,7 +1741,7 @@ bool move_freepages_block_isolate(struct zone *zone, struct page *page,
 
 		del_page_from_free_list(page, zone, order,
 					get_pfnblock_migratetype(page, pfn));
-		set_pageblock_migratetype(page, migratetype);
+		set_pageblock_migratetype(page, pfn, migratetype);
 		split_large_buddy(zone, page, pfn, order);
 		return true;
 	}
@@ -1753,14 +1753,14 @@ bool move_freepages_block_isolate(struct zone *zone, struct page *page,
 }
 #endif /* CONFIG_MEMORY_ISOLATION */
 
-static void change_pageblock_range(struct page *pageblock_page,
+static void change_pageblock_range(struct page *page,
 					int start_order, int migratetype)
 {
 	int nr_pageblocks = 1 << (start_order - pageblock_order);
 
 	while (nr_pageblocks--) {
-		set_pageblock_migratetype(pageblock_page, migratetype);
-		pageblock_page += pageblock_nr_pages;
+		set_pageblock_migratetype(page, page_to_pfn(page), migratetype);
+		page += pageblock_nr_pages;
 	}
 }
 
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 042937d5abe4..a436bf4da04e 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -254,7 +254,7 @@ static void unset_migratetype_isolate(struct page *page, int migratetype)
 		 */
 		WARN_ON_ONCE(!move_freepages_block_isolate(zone, page, migratetype));
 	} else {
-		set_pageblock_migratetype(page, migratetype);
+		set_pageblock_migratetype(page, page_to_pfn(page), migratetype);
 		__putback_isolated_page(page, order, migratetype);
 	}
 	zone->nr_isolate_pageblock--;
-- 
2.25.1


