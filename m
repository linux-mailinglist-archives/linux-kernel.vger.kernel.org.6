Return-Path: <linux-kernel+bounces-522988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE84A3D0DD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85DDA17AD01
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7BA1E98E1;
	Thu, 20 Feb 2025 05:36:07 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE571E04AE
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740029764; cv=none; b=hACxblWlbjpg5K40n2ZZPNB5QMy7EePhHIQ+mchLG4fKA4duq6vnhyoe61F+gQTkXSx5rA6UakAMhiqCuhte1BuI5yu30VTjMCNepo1yHXcd4OOIHxByxbf9m/lN/siwpU84I4naH8UDJgw+2J8E19wQgIYgJuEv/N83XM0HWAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740029764; c=relaxed/simple;
	bh=dFw/xsnT4MNREXbLJjOCEGbGptaqRGQf56Z0hBIHWrg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=lHSAR///eaOc6u5MkLw/8CmAc/D/LaF5opaZ7fvgSqtJ2/t2zJ12dnQ8dg/wc+y/wn2IdVWysv6pH0FIOYwt9+04RJ0ShVTsDtDvkpR0B20TL+RV5DXAREk3JIim7vXa8HV/5JSLk5dN3Fd3npk22l2jcdyh0NcOascc4PV5Zj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-c6-67b6bba6280f
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
Subject: [RFC PATCH v12 05/26] mm/buddy: make room for a new variable, luf_key, in struct page
Date: Thu, 20 Feb 2025 14:20:06 +0900
Message-Id: <20250220052027.58847-6-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250220052027.58847-1-byungchul@sk.com>
References: <20250220052027.58847-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsXC9ZZnoe6y3dvSDe61yljMWb+GzeLzhn9s
	Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8Xx3gNMFvPvfWaz
	2LxpKrPF8SlTGS1+/wAqPjlrMouDgMf31j4Wj52z7rJ7LNhU6rF5hZbH4j0vmTw2repk89j0
	aRK7x7tz59g9Tsz4zeIx72Sgx/t9V9k8tv6y82iceo3N4/MmuQC+KC6blNSczLLUIn27BK6M
	042yBWtkKt4deczUwDhXrIuRg0NCwETi5ELBLkZOMLPnXz87iM0moC5x48ZPZhBbRMBM4mDr
	H7A4s8BdJokD/WwgtrBAnMTGuzfAalgEVCUer9jDAmLzCphK3Fu4kBFiprzE6g0HwGo4geb8
	mNEL1isEVPNuwSWmLkYuoJr3bBKLj3+EapCUOLjiBssERt4FjAyrGIUy88pyEzNzTPQyKvMy
	K/SS83M3MQLDflntn+gdjJ8uBB9iFOBgVOLhndG6LV2INbGsuDL3EKMEB7OSCG9b/ZZ0Id6U
	xMqq1KL8+KLSnNTiQ4zSHCxK4rxG38pThATSE0tSs1NTC1KLYLJMHJxSDYyuHI8eKvIKlV4o
	nhut7fXo+BYDc0WVDr+qExpbnk46dPyVxQGZw3oxvzsalizsfZjed0xZjU033u8vo6vJRotP
	5XHZqoFeO75JMBoHbBbNFnohFPpx+R9/lutGVkqfHrmy6Ro1cS7Y4HptXZ3t6T2iivVL9jEe
	PWL0oatC+0nQQZcDOuv7jyixFGckGmoxFxUnAgC5URuDdwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsXC5WfdrLts97Z0g3WLBC3mrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XhuSdZLS7vmsNmcW/Nf1aL87vWslrsWLqPyeLSgQVMFsd7DzBZ
	zL/3mc1i86apzBbHp0xltPj9A6j45KzJLA6CHt9b+1g8ds66y+6xYFOpx+YVWh6L97xk8ti0
	qpPNY9OnSewe786dY/c4MeM3i8e8k4Ee7/ddZfNY/OIDk8fWX3YejVOvsXl83iQXwB/FZZOS
	mpNZllqkb5fAlXG6UbZgjUzFuyOPmRoY54p1MXJySAiYSPT862cHsdkE1CVu3PjJDGKLCJhJ
	HGz9AxZnFrjLJHGgnw3EFhaIk9h49wZYDYuAqsTjFXtYQGxeAVOJewsXMkLMlJdYveEAWA0n
	0JwfM3rBeoWAat4tuMQ0gZFrASPDKkaRzLyy3MTMHFO94uyMyrzMCr3k/NxNjMAwXlb7Z+IO
	xi+X3Q8xCnAwKvHwPni8NV2INbGsuDL3EKMEB7OSCG9b/ZZ0Id6UxMqq1KL8+KLSnNTiQ4zS
	HCxK4rxe4akJQgLpiSWp2ampBalFMFkmDk6pBsbat9XpU4JPzLIs3KJn8aru4HQ3LsuvVy+a
	JB6qWdprHxrP86KmmXnCUkaNHd4HhKUMIuyWdD1zfmacVJI+X1NI2adfavucGs+yI+LdGfWR
	iZ9cJnw+p3/8bn5E9qt1nNYx90+aF7NsjHu2QWR7xC5n3SnB0xa8fuZp1RvnfGjX7tYV3AdE
	tyqxFGckGmoxFxUnAgAAgnVcXwIAAA==
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
index 80fef38d9d645..20d85c4e609de 100644
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
@@ -537,6 +551,20 @@ static inline void set_page_private(struct page *page, unsigned long private)
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
index 5a7302baeed7c..754f1dd763448 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -541,7 +541,7 @@ struct alloc_context {
 static inline unsigned int buddy_order(struct page *page)
 {
 	/* PageBuddy() must be checked by the caller */
-	return page_private(page);
+	return page_buddy_order(page);
 }
 
 /*
@@ -555,7 +555,7 @@ static inline unsigned int buddy_order(struct page *page)
  * times, potentially observing different values in the tests and the actual
  * use of the result.
  */
-#define buddy_order_unsafe(page)	READ_ONCE(page_private(page))
+#define buddy_order_unsafe(page)	READ_ONCE(page_buddy_order(page))
 
 /*
  * This function checks whether a page is free && is the buddy
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 839708353cb77..59c26f59db3d6 100644
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


