Return-Path: <linux-kernel+bounces-196567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F058D5E1A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CE341F2798C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 09:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5468135A58;
	Fri, 31 May 2024 09:20:27 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A3282869
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 09:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717147227; cv=none; b=Ls1tJ3awbsjMtaaOYQ40oCvH1jE4NNn3lNQuXFziagB6b6YDqgscvZhtivTqL9zEO+op7EcGwpbOEoQdhz2CMZlDVfSqLRMFVckbZEPqTfaxBLRh1n3NfIeR1PeyjHpfKOorTKgRGrCKuh4orLJtVFP6DbOW3KX6faM7W6K3C1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717147227; c=relaxed/simple;
	bh=ySyfp9Tsb6A3ifM2kAJNqbEQbETZH/UsyUxprYmMjNw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=PUh3PfBUQyrdvmlFEcvakbees7/ieDSkWh8NxlQUr9e1aw1uPkpPU9Z5S4Eu7m8XIKcA/CwpEbBzfkfEZCQvwesmUO4UWGF0hCmTFEP8GNAEgnGhvNAocKMCO/qrZGTWmqxpwTf5eAy5UpL80MsVlMcjMj5XMm+3mA6OOxWRuAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-57-6659964c6c58
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	ying.huang@intel.com,
	vernhao@tencent.com,
	mgorman@techsingularity.net,
	hughd@google.com,
	willy@infradead.org,
	david@redhat.com,
	peterz@infradead.org,
	luto@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	rjgolo@gmail.com
Subject: [PATCH v11 05/12] mm: buddy: make room for a new variable, ugen, in struct page
Date: Fri, 31 May 2024 18:19:54 +0900
Message-Id: <20240531092001.30428-6-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240531092001.30428-1-byungchul@sk.com>
References: <20240531092001.30428-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsXC9ZZnoa7PtMg0g3nvuC3mrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/fwAVn5w1mcVBwON7ax+Lx85Zd9k9Fmwq9di8Qstj8Z6XTB6bVnWyeWz6
	NInd4925c+weJ2b8ZvGYdzLQ4/2+q2weW3/ZeTROvcbm8XmTXABfFJdNSmpOZllqkb5dAlfG
	k4+/WQuuqlQcn/6VuYGxTbaLkZNDQsBE4tO5A8ww9qXnqxhBbDYBdYkbN36CxUUEzCQOtv5h
	B7GZBe4ySRzoZwOxhQUiJDZd6wSLswioSmz93MwEYvMKmEqsWrWNBWKmvMTqDRDzOYHmHPh7
	B2y+EFDNov+9QDYXUM17Nolfr06xQTRIShxccYNlAiPvAkaGVYxCmXlluYmZOSZ6GZV5mRV6
	yfm5mxiBob+s9k/0DsZPF4IPMQpwMCrx8AZURKQJsSaWFVfmHmKU4GBWEuH9lQ4U4k1JrKxK
	LcqPLyrNSS0+xCjNwaIkzmv0rTxFSCA9sSQ1OzW1ILUIJsvEwSnVwCjryvz40vvJyrdqnzfJ
	uk1n9lu8Oz9HT9XU+5VggRRf1NFJz/cf6bA4d3p2nGbTqs6jog+Cv4YKzRWsOPtnztx9s/lM
	3WPOSR6o2XYh2+DPZ1VB/eQ0YUNzAVmFstMcoe9qA581nuue6PLi6etLpmLn1y58PjNUO/Zq
	3Pf20s0WV59Jf5LhW6bEUpyRaKjFXFScCABLWebVeQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsXC5WfdrOszLTLN4OlFRos569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfHeA0wW
	8+99ZrPYvGkqs8XxKVMZLX7/ACo+OWsyi4Ogx/fWPhaPnbPusnss2FTqsXmFlsfiPS+ZPDat
	6mTz2PRpErvHu3Pn2D1OzPjN4jHvZKDH+31X2TwWv/jA5LH1l51H49RrbB6fN8kF8Edx2aSk
	5mSWpRbp2yVwZTz5+Ju14KpKxfHpX5kbGNtkuxg5OSQETCQuPV/FCGKzCahL3LjxkxnEFhEw
	kzjY+ocdxGYWuMskcaCfDcQWFoiQ2HStEyzOIqAqsfVzMxOIzStgKrFq1TYWiJnyEqs3HACb
	wwk058DfO2DzhYBqFv3vZZzAyLWAkWEVo0hmXlluYmaOqV5xdkZlXmaFXnJ+7iZGYCAvq/0z
	cQfjl8vuhxgFOBiVeHgDKiLShFgTy4orcw8xSnAwK4nw/koHCvGmJFZWpRblxxeV5qQWH2KU
	5mBREuf1Ck9NEBJITyxJzU5NLUgtgskycXBKNTA+fnZK+2ia54ZJppuPr1j2tetYx4HIo7wt
	NTtTVeWLnj/4M2Frv76rQt9fw5IPSv+6F9sfTZ1Tz6uipmwYnnNZrlJl9qxI37DK0qJYFlPv
	niL30xeuX5nvV95jsN5zoc7Wvy5v5Pw8pzbsXj8vXpLjZHzer9fvW89tqz/kvdYmcYKtFGNH
	yUQlluKMREMt5qLiRADuneMJYAIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Functionally, no change.  This is a preparation for luf mechanism that
tracks need of tlb flush for each page residing in buddy, using a
generation number in struct page.

Fortunately, since the private field in struct page is used only to
store page order in buddy, ranging from 0 to MAX_PAGE_ORDER, that can be
covered with unsigned short int.  So splitted it into two smaller ones,
order and ugen, so that the both can be used in buddy at the same time.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/mm_types.h | 40 +++++++++++++++++++++++++++++++++-------
 mm/internal.h            |  4 ++--
 mm/page_alloc.c          | 13 ++++++++-----
 3 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 24323c7d0bd4..37eb3000267c 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -108,13 +108,25 @@ struct page {
 				pgoff_t index;		/* Our offset within mapping. */
 				unsigned long share;	/* share count for fsdax */
 			};
-			/**
-			 * @private: Mapping-private opaque data.
-			 * Usually used for buffer_heads if PagePrivate.
-			 * Used for swp_entry_t if PageSwapCache.
-			 * Indicates order in the buddy system if PageBuddy.
-			 */
-			unsigned long private;
+			union {
+				/**
+				 * @private: Mapping-private opaque data.
+				 * Usually used for buffer_heads if PagePrivate.
+				 * Used for swp_entry_t if PageSwapCache.
+				 */
+				unsigned long private;
+				struct {
+					/*
+					 * Indicates order in the buddy system if PageBuddy.
+					 */
+					unsigned short int order;
+					/*
+					 * Tracks need of tlb flush used by luf,
+					 * which stands for lazy unmap flush.
+					 */
+					unsigned short int ugen;
+				};
+			};
 		};
 		struct {	/* page_pool used by netstack */
 			/**
@@ -521,6 +533,20 @@ static inline void set_page_private(struct page *page, unsigned long private)
 	page->private = private;
 }
 
+#define page_buddy_order(page)		((page)->order)
+
+static inline void set_page_buddy_order(struct page *page, unsigned int order)
+{
+	page->order = (unsigned short int)order;
+}
+
+#define page_buddy_ugen(page)		((page)->ugen)
+
+static inline void set_page_buddy_ugen(struct page *page, unsigned short int ugen)
+{
+	page->ugen = ugen;
+}
+
 static inline void *folio_get_private(struct folio *folio)
 {
 	return folio->private;
diff --git a/mm/internal.h b/mm/internal.h
index bbec99cc9d9d..552e1061d36d 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -461,7 +461,7 @@ struct alloc_context {
 static inline unsigned int buddy_order(struct page *page)
 {
 	/* PageBuddy() must be checked by the caller */
-	return page_private(page);
+	return page_buddy_order(page);
 }
 
 /*
@@ -475,7 +475,7 @@ static inline unsigned int buddy_order(struct page *page)
  * times, potentially observing different values in the tests and the actual
  * use of the result.
  */
-#define buddy_order_unsafe(page)	READ_ONCE(page_private(page))
+#define buddy_order_unsafe(page)	READ_ONCE(page_buddy_order(page))
 
 /*
  * This function checks whether a page is free && is the buddy
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b1e3eb5787de..ae57dd8718fe 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -565,9 +565,12 @@ void prep_compound_page(struct page *page, unsigned int order)
 	prep_compound_head(page, order);
 }
 
-static inline void set_buddy_order(struct page *page, unsigned int order)
+static inline void set_buddy_order_ugen(struct page *page,
+					unsigned int order,
+					unsigned short int ugen)
 {
-	set_page_private(page, order);
+	set_page_buddy_order(page, order);
+	set_page_buddy_ugen(page, order);
 	__SetPageBuddy(page);
 }
 
@@ -826,7 +829,7 @@ static inline void __free_one_page(struct page *page,
 	}
 
 done_merging:
-	set_buddy_order(page, order);
+	set_buddy_order_ugen(page, order, 0);
 
 	if (fpi_flags & FPI_TO_TAIL)
 		to_tail = true;
@@ -1336,7 +1339,7 @@ static inline void expand(struct zone *zone, struct page *page,
 			continue;
 
 		__add_to_free_list(&page[size], zone, high, migratetype, false);
-		set_buddy_order(&page[size], high);
+		set_buddy_order_ugen(&page[size], high, 0);
 		nr_added += size;
 	}
 	account_freepages(zone, nr_added, migratetype);
@@ -6801,7 +6804,7 @@ static void break_down_buddy_pages(struct zone *zone, struct page *page,
 			continue;
 
 		add_to_free_list(current_buddy, zone, high, migratetype, false);
-		set_buddy_order(current_buddy, high);
+		set_buddy_order_ugen(current_buddy, high, 0);
 	}
 }
 
-- 
2.17.1


