Return-Path: <linux-kernel+bounces-533718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB8AA45E15
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F9CB3ADD6B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3B321CA02;
	Wed, 26 Feb 2025 12:01:50 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1CD211A31
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571308; cv=none; b=uPg5u5da7GGozd55QhSa11WJTqXJSWnoMOk15Mf8uCOh8AQMUd7mRIMh7TqSjUQvuAcBj4no20J+x4gsP+dryYGn6fMf+jxeLAHlPGiACDo4g+i+ZyvRSBWULt2GXvI3flFlzHdoD4DFVRWQ3TaZN4hzIlLxCo4IvR3bvlfEi3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571308; c=relaxed/simple;
	bh=7QhseHPCi+UOmWXtn5V9DOemXEr8BLB83Uy4G7N8sjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=QOKR8EfD/p2HjqmcFdBx94UR1qLbxC0Lh0xr1wlhrtwmCR1xSIVrmXBCcCUvEsdCnWHi2t3GLPjA4S5OuE1PeVvZyi/DDU/eTUmJL9CPe2K4fL+UHpCLX9xLh8nvFkOBbU2P0zs5yrnrsiLokxTqag+UEIE1C+0ME5N0vxjD7nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-db-67bf02a6e88f
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
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
	rjgolo@gmail.com
Subject: [RFC PATCH v12 based on mm-unstable as of Feb 21, 2025 05/25]  mm/buddy: make room for a new variable, luf_key, in struct page
Date: Wed, 26 Feb 2025 21:01:12 +0900
Message-Id: <20250226120132.28469-5-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226120132.28469-1-byungchul@sk.com>
References: <20250226113342.GB1935@system.software.com>
 <20250226120132.28469-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsXC9ZZnke4ypv3pBtOeyFnMWb+GzeLzhn9s
	Fl/X/2K2ePqpj8Xi8q45bBb31vxntTi/ay2rxY6l+5gsLh1YwGRxvPcAk8X8e5/ZLDZvmsps
	cXzKVEaL3z/msDnweXxv7WPx2DnrLrvHgk2lHptXaHlsWtXJ5rHp0yR2j3fnzrF7nJjxm8Xj
	/b6rbB5bf9l5NE69xubxeZNcAE8Ul01Kak5mWWqRvl0CV8bGR3sZC9bIVPTtb2JtYJwr1sXI
	ySEhYCIx/2EbG4zdv+wqC4jNJqAucePGT2YQW0TATOJg6x/2LkYuDmaBZUwSe080sIE4wgLt
	jBJd77+BVbEIqEp8nfYerJtXwFTieMdzdoip8hKrNxwAq+EEmvRv92+wuJBAskTL+t8sIIMk
	BG6zSUx70QF1hqTEwRU3WCYw8i5gZFjFKJSZV5abmJljopdRmZdZoZecn7uJERjYy2r/RO9g
	/HQh+BCjAAejEg/vgzN704VYE8uKK3MPMUpwMCuJ8HJm7kkX4k1JrKxKLcqPLyrNSS0+xCjN
	waIkzmv0rTxFSCA9sSQ1OzW1ILUIJsvEwSnVwChcYvCwoK9EMqOuKnlNbWPGnwdzpaQrHvd+
	c32xa8t3s2i/xb8M8u5WPEtVm//44fb4ueXF0Q1Ga8x6y+ZqL1E5H+yWf9a39XecvtLqVe+X
	qG5/fIo3obKU0+OvDadgxUuNTds2ePszuh+8elYg59q3d2zSjpOrLE/WiUU2uqt9mMK6+Zn+
	WyWW4oxEQy3mouJEAFLeKnxoAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDLMWRmVeSWpSXmKPExsXC5WfdrLuMaX+6QVufqMWc9WvYLD5v+Mdm
	8XX9L2aLp5/6WCwOzz3JanF51xw2i3tr/rNanN+1ltVix9J9TBaXDixgsjjee4DJYv69z2wW
	mzdNZbY4PmUqo8XvH3PYHPg9vrf2sXjsnHWX3WPBplKPzSu0PDat6mTz2PRpErvHu3Pn2D1O
	zPjN4vF+31U2j8UvPjB5bP1l59E49Rqbx+dNcgG8UVw2Kak5mWWpRfp2CVwZGx/tZSxYI1PR
	t7+JtYFxrlgXIyeHhICJRP+yqywgNpuAusSNGz+ZQWwRATOJg61/2LsYuTiYBZYxSew90cAG
	4ggLtDNKdL3/BlbFIqAq8XXae7BuXgFTieMdz9khpspLrN5wAKyGE2jSv92/weJCAskSLet/
	s0xg5FrAyLCKUSQzryw3MTPHVK84O6MyL7NCLzk/dxMjMEyX1f6ZuIPxy2X3Q4wCHIxKPLwP
	zuxNF2JNLCuuzD3EKMHBrCTCy5m5J12INyWxsiq1KD++qDQntfgQozQHi5I4r1d4aoKQQHpi
	SWp2ampBahFMlomDU6qBUS+ZieNlcOKk5LookfCjW3bvy/HjcI2dsDhB0Yen0ajvut+NbSVz
	vx7R/roh4/PzF7qqC/WTNt2tPD79UJ11xeLaIl2hKKVby7KT1jT+S1H8mirVcdwwI2vOP6En
	P07a1D3z9Hs5f9YatTfy8Ytqk4/1szQJpZT9OFAenH9KPPD3nR0imtnLlViKMxINtZiLihMB
	1g+7Ok8CAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Functionally, no change.  This is a preparation for luf mechanism that
tracks need of tlb flush for each page residing in buddy.

Since the private field in struct page is used only to store page order
in buddy, ranging from 0 to MAX_PAGE_ORDER, that can be covered with
unsigned short.  So splitted it into two smaller ones, order and luf_key,
so that the both can be used in buddy at the same time.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/mm_types.h | 42 +++++++++++++++++++++++++++++++++-------
 mm/internal.h            |  4 ++--
 mm/page_alloc.c          |  2 +-
 3 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 689b2a7461892..7b15efbe9f529 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -107,13 +107,27 @@ struct page {
 				pgoff_t index;		/* Our offset within mapping. */
 				unsigned long share;	/* share count for fsdax */
 			};
-			/**
-			 * @private: Mapping-private opaque data.
-			 * Usually used for buffer_heads if PagePrivate.
-			 * Used for swp_entry_t if swapcache flag set.
-			 * Indicates order in the buddy system if PageBuddy.
-			 */
-			unsigned long private;
+			union {
+				/**
+				 * @private: Mapping-private opaque data.
+				 * Usually used for buffer_heads if PagePrivate.
+				 * Used for swp_entry_t if swapcache flag set.
+				 * Indicates order in the buddy system if PageBuddy.
+				 */
+				unsigned long private;
+				struct {
+					/*
+					 * Indicates order in the buddy system if PageBuddy.
+					 */
+					unsigned short order;
+
+					/*
+					 * For tracking need of tlb flush,
+					 * by luf(lazy unmap flush).
+					 */
+					unsigned short luf_key;
+				};
+			};
 		};
 		struct {	/* page_pool used by netstack */
 			/**
@@ -577,6 +591,20 @@ static inline void set_page_private(struct page *page, unsigned long private)
 	page->private = private;
 }
 
+#define page_buddy_order(page)		((page)->order)
+
+static inline void set_page_buddy_order(struct page *page, unsigned int order)
+{
+	page->order = (unsigned short)order;
+}
+
+#define page_luf_key(page)		((page)->luf_key)
+
+static inline void set_page_luf_key(struct page *page, unsigned short luf_key)
+{
+	page->luf_key = luf_key;
+}
+
 static inline void *folio_get_private(struct folio *folio)
 {
 	return folio->private;
diff --git a/mm/internal.h b/mm/internal.h
index b07550db2bfd1..c4d2018a7cf8e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -543,7 +543,7 @@ struct alloc_context {
 static inline unsigned int buddy_order(struct page *page)
 {
 	/* PageBuddy() must be checked by the caller */
-	return page_private(page);
+	return page_buddy_order(page);
 }
 
 /*
@@ -557,7 +557,7 @@ static inline unsigned int buddy_order(struct page *page)
  * times, potentially observing different values in the tests and the actual
  * use of the result.
  */
-#define buddy_order_unsafe(page)	READ_ONCE(page_private(page))
+#define buddy_order_unsafe(page)	READ_ONCE(page_buddy_order(page))
 
 /*
  * This function checks whether a page is free && is the buddy
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 16dfcf7ade74a..86c9fa45d36fe 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -576,7 +576,7 @@ void prep_compound_page(struct page *page, unsigned int order)
 
 static inline void set_buddy_order(struct page *page, unsigned int order)
 {
-	set_page_private(page, order);
+	set_page_buddy_order(page, order);
 	__SetPageBuddy(page);
 }
 
-- 
2.17.1


