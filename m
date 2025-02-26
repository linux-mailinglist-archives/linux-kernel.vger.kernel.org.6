Return-Path: <linux-kernel+bounces-533742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BECFFA45E2D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ACE2189D8C1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C00521D003;
	Wed, 26 Feb 2025 12:03:51 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63022217718
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571430; cv=none; b=Y/khy5ipZUSEAJ4im1KwIfWRRlI2fHAVwoHn5n3/5jw5vV2XIFJqwZ9a4UDTIjzIRepBYpPp50MQQNJoNkTtyE/sEwa7nsUfl6NJ4J2H5f7JRvN6xKx5ZlBDFAZF78wVxSiGGAknBHQd+P9ikvm+g5YE6oxVkYhNNciQNL3fsL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571430; c=relaxed/simple;
	bh=9CQvfqR9DV/ZJd3E0IkrQ7izEZuN/vNHixGosgFBfA8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=T//OnHIicZU2bDWvBdAKgdIaHzeOOnxOexlhLhMPD8noqOgDSJ6/7fG9cQ0IHQDzZAHJGPOJL1W9sjdHTjuQFRPyP4UbJbX21iYrwmiTqijzr3+kusdLRLGWuN02zYGqMUpLhNB31uYD0UnFWBr4SrXnvJLB+C5CYb7LGgPaoXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-0a-67bf0322c8a4
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
Subject: [RFC PATCH v12 based on v6.14-rc4 05/25] mm/buddy: make room for a new variable, luf_key, in struct page
Date: Wed, 26 Feb 2025 21:03:16 +0900
Message-Id: <20250226120336.29565-5-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226120336.29565-1-byungchul@sk.com>
References: <20250226113024.GA1935@system.software.com>
 <20250226120336.29565-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsXC9ZZnoa4S8/50g7UzFS3mrF/DZvF5wz82
	i6/rfzFbPP3Ux2JxedccNot7a/6zWpzftZbVYsfSfUwWlw4sYLI43nuAyWL+vc9sFps3TWW2
	OD5lKqPF7x9z2Bz4PL639rF47Jx1l91jwaZSj80rtDw2repk89j0aRK7x7tz59g9Tsz4zeLx
	ft9VNo+tv+w8GqdeY/P4vEkugCeKyyYlNSezLLVI3y6BK+Pz/c+sBWtkKpbukWxgnCvWxcjJ
	ISFgInFzynYWGPvbzO/MIDabgLrEjRs/wWwRATOJg61/2LsYuTiYBZYxSew90cAGkhAWKJSY
	P/sHmM0ioCqxZP9Vxi5GDg5eAVOJs81FEDPlJVZvOAA2hxNozqdpx8DKhQSSJXb+/sMEMlNC
	4D6bxKf2HawQDZISB1fcYJnAyLuAkWEVo1BmXlluYmaOiV5GZV5mhV5yfu4mRmBIL6v9E72D
	8dOF4EOMAhyMSjy8D87sTRdiTSwrrsw9xCjBwawkwsuZuSddiDclsbIqtSg/vqg0J7X4EKM0
	B4uSOK/Rt/IUIYH0xJLU7NTUgtQimCwTB6dUA6PqnNzmmLIt1naGx9b/eORz7td8/oeuTw4w
	rt17RFB1S+bsiE+BTownZy1lbmuufbn+N59x30rnxcE1pvpbtbbE8m1k2xVQu1tT4BtPKOMT
	5hQ/HxvrKuaM/WL5kxw2b/8pWpa2YWfODeV9Vev45+eEvN3yoO75w7JJi7ZvbCjQkJU2PbDz
	Y74SS3FGoqEWc1FxIgD26I6RZQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJLMWRmVeSWpSXmKPExsXC5WfdrKvEvD/d4OhBEYs569ewWXze8I/N
	4uv6X8wWTz/1sVgcnnuS1eLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHG89wCTxfx7n9ks
	Nm+aymxxfMpURovfP+awOfB7fG/tY/HYOesuu8eCTaUem1doeWxa1cnmsenTJHaPd+fOsXuc
	mPGbxeP9vqtsHotffGDy2PrLzqNx6jU2j8+b5AJ4o7hsUlJzMstSi/TtErgyPt//zFqwRqZi
	6R7JBsa5Yl2MnBwSAiYS32Z+Zwax2QTUJW7c+AlmiwiYSRxs/cPexcjFwSywjEli74kGNpCE
	sEChxPzZP8BsFgFViSX7rzJ2MXJw8AqYSpxtLoKYKS+xesMBsDmcQHM+TTsGVi4kkCyx8/cf
	pgmMXAsYGVYximTmleUmZuaY6hVnZ1TmZVboJefnbmIEBuiy2j8TdzB+uex+iFGAg1GJh/fB
	mb3pQqyJZcWVuYcYJTiYlUR4OTP3pAvxpiRWVqUW5ccXleakFh9ilOZgURLn9QpPTRASSE8s
	Sc1OTS1ILYLJMnFwSjUwzgz7eXTXDtUfGwVOuRpxPnhu/2Gv0xKlyk+Pp5zNf6sUWhJ+/XDz
	7Ur3vg0umpOiX7/cuezP3NoMn8wpD4zmKq5xZEizaL7/0pP3lJlbtbTz//02Rz5Eztq+S1rv
	cdHkY4ui3Xv07Tds8T/ssfvl86sRk746CTWvLznY/vLEFwmruKkvum6+f6DEUpyRaKjFXFSc
	CADmImAJTAIAAA==
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
index 0234f14f2aa6b..7d78a285e52ca 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -106,13 +106,27 @@ struct page {
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
@@ -566,6 +580,20 @@ static inline void set_page_private(struct page *page, unsigned long private)
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
index 109ef30fee11f..d7161a6e0b352 100644
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
index 579789600a3c7..c08b1389d5671 100644
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


