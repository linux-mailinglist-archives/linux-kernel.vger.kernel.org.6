Return-Path: <linux-kernel+bounces-183343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A15F28C97D4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 04:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E93801F21DB6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 02:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FEB14AA0;
	Mon, 20 May 2024 02:17:59 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16C99461
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 02:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716171478; cv=none; b=r9FV9cuEH6Z/+Z/nSetRA3Xuv1WTdnPJcumiHWE/31/8D5zL4AdtXipBTpsU2cm2p2Qjeu6JTUvU3j0Vf0+TlvjPXa0xQ9y7ddQ2tojD2HyLZkA19w1YdJGDvAcTIeQ2jRvIT+KdrsNuZbcp3amqDLwG4QeIIaYXqX7+yS2H0Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716171478; c=relaxed/simple;
	bh=jZYYEN22FwfgAv99f+tq0XQ/kj/yrRu6yCvqz8y5jmU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=IpQ+0G7ME7vc6aqZ3yA3sFhqWSsENSjbzxxt9mbObeQULNULIhpDt+mKscAsQaawnxNmaT56xlQPtPu5esuRv+tOk41drYdmQSMOyGt5MkcE04gm0X5UUlQY5b6+/OmpQvzhwW59Lsh2PU8LJs3I//ArGJTaVkjkclMleMfHfL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-ae-664ab2c88e13
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
Subject: [RESEND PATCH v10 05/12] mm: buddy: make room for a new variable, ugen, in struct page
Date: Mon, 20 May 2024 11:17:27 +0900
Message-Id: <20240520021734.21527-6-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240520021734.21527-1-byungchul@sk.com>
References: <20240520021734.21527-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsXC9ZZnoe7JTV5pBsdus1jMWb+GzeLzhn9s
	Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8Xx3gNMFvPvfWaz
	2LxpKrPF8SlTGS1+/wAqPjlrMouDgMf31j4Wj52z7rJ7LNhU6rF5hZbH4j0vmTw2repk89j0
	aRK7x7tz59g9Tsz4zeIx72Sgx/t9V9k8tv6y82iceo3N4/MmuQC+KC6blNSczLLUIn27BK6M
	Bd8eshVcVak43DmJpYGxTbaLkZNDQsBEonvlRBYYe+rrZlYQm01AXeLGjZ/MILaIgJnEwdY/
	7CA2s8BdJokD/WwgtrBAvMTfOzvBbBYBVYn13Z1g9bwCphKLb15hgpgpL7F6wwGwOCfQnBmr
	doLtEgKq+XH0K1AvF1DNezaJi6eOsUI0SEocXHGDZQIj7wJGhlWMQpl5ZbmJmTkmehmVeZkV
	esn5uZsYgaG/rPZP9A7GTxeCDzEKcDAq8fDueOSZJsSaWFZcmXuIUYKDWUmEd9MWoBBvSmJl
	VWpRfnxRaU5q8SFGaQ4WJXFeo2/lKUIC6YklqdmpqQWpRTBZJg5OqQZG/v/3r/10/bc1JHse
	a7XXV8bXGWEd3s6bo7xE5oZKTVbemPFn6at161w+xx99IKD3d9Htg4r7j8S++BBrVhC6K+fE
	n9VTuwo+ns9eMu1NfO/Po85fLmZYzN/J1JmjOLnMiD/ha/x0YVbZDddDTVk+p7Hc55ywbevG
	nRfttkxuj+xXjt8hKWW2RYmlOCPRUIu5qDgRADq+n6F5AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsXC5WfdrHtik1eawYQbZhZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLw3JOsFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+O9B5gs
	5t/7zGaxedNUZovjU6YyWvz+AVR8ctZkFgdBj++tfSweO2fdZfdYsKnUY/MKLY/Fe14yeWxa
	1cnmsenTJHaPd+fOsXucmPGbxWPeyUCP9/uusnksfvGByWPrLzuPxqnX2Dw+b5IL4I/isklJ
	zcksSy3St0vgyljw7SFbwVWVisOdk1gaGNtkuxg5OSQETCSmvm5mBbHZBNQlbtz4yQxiiwiY
	SRxs/cMOYjML3GWSONDPBmILC8RL/L2zE8xmEVCVWN/dCVbPK2AqsfjmFSaImfISqzccAItz
	As2ZsWonC4gtBFTz4+hXtgmMXAsYGVYximTmleUmZuaY6hVnZ1TmZVboJefnbmIEBvKy2j8T
	dzB+uex+iFGAg1GJh3fDbc80IdbEsuLK3EOMEhzMSiK8m7YAhXhTEiurUovy44tKc1KLDzFK
	c7AoifN6hacmCAmkJ5akZqemFqQWwWSZODilGhinrg2xCigXv7j77lRNn2ciXUfnbrnRYzpv
	j0f6ey+N2MWvjWfk/lG89kte/ckCqzkTTrhNO/aopCvVO/bSkuIHXxRZ+nJWTVZ4MktpysFL
	RcsWT069s6OXwyQ74vPiWCf/vbd4xDb+v/Ar0znZ+NifCW1X2I/mvPmk8nc3Y9XfOULr5Td5
	RK5mUWIpzkg01GIuKk4EAClSB6NgAgAA
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
index db0adf5721cc..cd4ec0d10ffb 100644
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
index c6483f73ec13..eb9c7d8650fc 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -453,7 +453,7 @@ struct alloc_context {
 static inline unsigned int buddy_order(struct page *page)
 {
 	/* PageBuddy() must be checked by the caller */
-	return page_private(page);
+	return page_buddy_order(page);
 }
 
 /*
@@ -467,7 +467,7 @@ static inline unsigned int buddy_order(struct page *page)
  * times, potentially observing different values in the tests and the actual
  * use of the result.
  */
-#define buddy_order_unsafe(page)	READ_ONCE(page_private(page))
+#define buddy_order_unsafe(page)	READ_ONCE(page_buddy_order(page))
 
 /*
  * This function checks whether a page is free && is the buddy
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 33d4a1be927b..917b22b429d1 100644
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
 
@@ -834,7 +837,7 @@ static inline void __free_one_page(struct page *page,
 	}
 
 done_merging:
-	set_buddy_order(page, order);
+	set_buddy_order_ugen(page, order, 0);
 
 	if (fpi_flags & FPI_TO_TAIL)
 		to_tail = true;
@@ -1344,7 +1347,7 @@ static inline void expand(struct zone *zone, struct page *page,
 			continue;
 
 		__add_to_free_list(&page[size], zone, high, migratetype, false);
-		set_buddy_order(&page[size], high);
+		set_buddy_order_ugen(&page[size], high, 0);
 		nr_added += size;
 	}
 	account_freepages(zone, nr_added, migratetype);
@@ -6802,7 +6805,7 @@ static void break_down_buddy_pages(struct zone *zone, struct page *page,
 			continue;
 
 		add_to_free_list(current_buddy, zone, high, migratetype, false);
-		set_buddy_order(current_buddy, high);
+		set_buddy_order_ugen(current_buddy, high, 0);
 	}
 }
 
-- 
2.17.1


