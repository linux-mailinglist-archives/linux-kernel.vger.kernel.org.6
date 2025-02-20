Return-Path: <linux-kernel+bounces-522983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FC8A3D0D8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAD5E189DB34
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7471E32BE;
	Thu, 20 Feb 2025 05:36:04 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC351A9B4E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740029763; cv=none; b=cZt/tp7G1ih+pSmNF8NgMG3gSg7iE4kgPf4Oq4Q6zJwl3q8yj5DJ0mZ27tv1zwwu1Spnhqu/bqJYJp/1S35JRno90NmzS8v1qUHtlXbpEtSyjhPxi39sKXY1ILWY5rKI5SW9D7PGyIFegzdnXK0tc3JxZ/HzYnq8FcbgTMU+y9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740029763; c=relaxed/simple;
	bh=x5P/59Gr/bGb0CCHWfnSxFZ0UEKQuXMdmHzpaAhjp3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=rxtNQLl92iUtfdigkuvubsLha89OyhThXeQ4+mb/fa8Yk5Ahlmq4QVLznLIjk2nfikJADteEOHw4X0itWeg6TY4785RP+VitvfvAGoJPpfjIqvcYyMZpog15rLKB+kaOaD30l5eIoTbzhqV1iyegcGOsJ+pbLFFbIxDvps6UyJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-cb-67b6bba62acc
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
Subject: [RFC PATCH v12 06/26] mm: move should_skip_kasan_poison() to mm/internal.h
Date: Thu, 20 Feb 2025 14:20:07 +0900
Message-Id: <20250220052027.58847-7-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250220052027.58847-1-byungchul@sk.com>
References: <20250220052027.58847-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsXC9ZZnoe6y3dvSDa53K1jMWb+GzeLzhn9s
	Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8Xx3gNMFvPvfWaz
	2LxpKrPF8SlTGS1+/wAqPjlrMouDgMf31j4Wj52z7rJ7LNhU6rF5hZbH4j0vmTw2repk89j0
	aRK7x7tz59g9Tsz4zeIx72Sgx/t9V9k8tv6y82iceo3N4/MmuQC+KC6blNSczLLUIn27BK6M
	5ocnWQoW6lQce/6MtYFxjkoXIyeHhICJxPUlW5i7GDnA7I9NqSBhNgF1iRs3fjKD2CICZhIH
	W/+wg9jMAneZJA70s4HYwgLBEuf2nAKrYRFQlZi04gxYnFfAVGLGhNnMEOPlJVZvOABmcwLN
	+TGjF6xGCKjm3YJLTF2MXEA179kkftw7wg7RIClxcMUNlgmMvAsYGVYxCmXmleUmZuaY6GVU
	5mVW6CXn525iBAb+sto/0TsYP10IPsQowMGoxMM7o3VbuhBrYllxZe4hRgkOZiUR3rb6LelC
	vCmJlVWpRfnxRaU5qcWHGKU5WJTEeY2+lacICaQnlqRmp6YWpBbBZJk4OKUaGBPX886puR3r
	IndcS81q0Z6aUL1JSsnCesnTZb1V5sf/ePKtbJKjwZ+5Nf2LVf34lJ8flhTZqvNi+fGeI7wm
	mTE3jr+vDn/4+lzUxhOsla239/z6xtK864FCRdKT+ohXGWZMIVxSyuuyRY588PNSDyn5kXA2
	4eh8a8W1E3+EMF5ln6dl5BZiq8RSnJFoqMVcVJwIAFMqBtZ4AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsXC5WfdrLts97Z0g0mzxCzmrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XhuSdZLS7vmsNmcW/Nf1aL87vWslrsWLqPyeLSgQVMFsd7DzBZ
	zL/3mc1i86apzBbHp0xltPj9A6j45KzJLA6CHt9b+1g8ds66y+6xYFOpx+YVWh6L97xk8ti0
	qpPNY9OnSewe786dY/c4MeM3i8e8k4Ee7/ddZfNY/OIDk8fWX3YejVOvsXl83iQXwB/FZZOS
	mpNZllqkb5fAldH88CRLwUKdimPPn7E2MM5R6WLk4JAQMJH42JTaxcjJwSagLnHjxk9mEFtE
	wEziYOsfdhCbWeAuk8SBfjYQW1ggWOLcnlNgNSwCqhKTVpwBi/MKmErMmDAbLC4hIC+xesMB
	MJsTaM6PGb1gNUJANe8WXGKawMi1gJFhFaNIZl5ZbmJmjqlecXZGZV5mhV5yfu4mRmAYL6v9
	M3EH45fL7ocYBTgYlXh4Hzzemi7EmlhWXJl7iFGCg1lJhLetfku6EG9KYmVValF+fFFpTmrx
	IUZpDhYlcV6v8NQEIYH0xJLU7NTUgtQimCwTB6dUA2NZ+A6jo08ilpoIanJ3xVt93d+3XEl3
	zpXJ7tbWf2ZkxWY/iF0kXjozZM65IzuvNS9VZ//nJyT67aTWkxK7eNs5HFv6WNXdT9i4z4/v
	naIjFTAr71dDw8KfSdsYJ9x1avacrMCQHPPF68r35qjGrKf3j0VXHPc+261ikRxvOne+/eoJ
	MR5HpZRYijMSDbWYi4oTAa2FdxpfAgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Functionally, no change.  This is a preparation for luf mechanism that
needs to use should_skip_kasan_poison() function in mm/internal.h.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 mm/internal.h   | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 mm/page_alloc.c | 47 -----------------------------------------------
 2 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 754f1dd763448..e3084d32272e3 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1038,8 +1038,55 @@ static inline void vunmap_range_noflush(unsigned long start, unsigned long end)
 DECLARE_STATIC_KEY_TRUE(deferred_pages);
 
 bool __init deferred_grow_zone(struct zone *zone, unsigned int order);
+
+static inline bool deferred_pages_enabled(void)
+{
+	return static_branch_unlikely(&deferred_pages);
+}
+#else
+static inline bool deferred_pages_enabled(void)
+{
+	return false;
+}
 #endif /* CONFIG_DEFERRED_STRUCT_PAGE_INIT */
 
+/*
+ * Skip KASAN memory poisoning when either:
+ *
+ * 1. For generic KASAN: deferred memory initialization has not yet completed.
+ *    Tag-based KASAN modes skip pages freed via deferred memory initialization
+ *    using page tags instead (see below).
+ * 2. For tag-based KASAN modes: the page has a match-all KASAN tag, indicating
+ *    that error detection is disabled for accesses via the page address.
+ *
+ * Pages will have match-all tags in the following circumstances:
+ *
+ * 1. Pages are being initialized for the first time, including during deferred
+ *    memory init; see the call to page_kasan_tag_reset in __init_single_page.
+ * 2. The allocation was not unpoisoned due to __GFP_SKIP_KASAN, with the
+ *    exception of pages unpoisoned by kasan_unpoison_vmalloc.
+ * 3. The allocation was excluded from being checked due to sampling,
+ *    see the call to kasan_unpoison_pages.
+ *
+ * Poisoning pages during deferred memory init will greatly lengthen the
+ * process and cause problem in large memory systems as the deferred pages
+ * initialization is done with interrupt disabled.
+ *
+ * Assuming that there will be no reference to those newly initialized
+ * pages before they are ever allocated, this should have no effect on
+ * KASAN memory tracking as the poison will be properly inserted at page
+ * allocation time. The only corner case is when pages are allocated by
+ * on-demand allocation and then freed again before the deferred pages
+ * initialization is done, but this is not likely to happen.
+ */
+static inline bool should_skip_kasan_poison(struct page *page)
+{
+	if (IS_ENABLED(CONFIG_KASAN_GENERIC))
+		return deferred_pages_enabled();
+
+	return page_kasan_tag(page) == KASAN_TAG_KERNEL;
+}
+
 enum mminit_level {
 	MMINIT_WARNING,
 	MMINIT_VERIFY,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 59c26f59db3d6..244cb30496be5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -299,11 +299,6 @@ int page_group_by_mobility_disabled __read_mostly;
  */
 DEFINE_STATIC_KEY_TRUE(deferred_pages);
 
-static inline bool deferred_pages_enabled(void)
-{
-	return static_branch_unlikely(&deferred_pages);
-}
-
 /*
  * deferred_grow_zone() is __init, but it is called from
  * get_page_from_freelist() during early boot until deferred_pages permanently
@@ -316,11 +311,6 @@ _deferred_grow_zone(struct zone *zone, unsigned int order)
 	return deferred_grow_zone(zone, order);
 }
 #else
-static inline bool deferred_pages_enabled(void)
-{
-	return false;
-}
-
 static inline bool _deferred_grow_zone(struct zone *zone, unsigned int order)
 {
 	return false;
@@ -993,43 +983,6 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
 	return ret;
 }
 
-/*
- * Skip KASAN memory poisoning when either:
- *
- * 1. For generic KASAN: deferred memory initialization has not yet completed.
- *    Tag-based KASAN modes skip pages freed via deferred memory initialization
- *    using page tags instead (see below).
- * 2. For tag-based KASAN modes: the page has a match-all KASAN tag, indicating
- *    that error detection is disabled for accesses via the page address.
- *
- * Pages will have match-all tags in the following circumstances:
- *
- * 1. Pages are being initialized for the first time, including during deferred
- *    memory init; see the call to page_kasan_tag_reset in __init_single_page.
- * 2. The allocation was not unpoisoned due to __GFP_SKIP_KASAN, with the
- *    exception of pages unpoisoned by kasan_unpoison_vmalloc.
- * 3. The allocation was excluded from being checked due to sampling,
- *    see the call to kasan_unpoison_pages.
- *
- * Poisoning pages during deferred memory init will greatly lengthen the
- * process and cause problem in large memory systems as the deferred pages
- * initialization is done with interrupt disabled.
- *
- * Assuming that there will be no reference to those newly initialized
- * pages before they are ever allocated, this should have no effect on
- * KASAN memory tracking as the poison will be properly inserted at page
- * allocation time. The only corner case is when pages are allocated by
- * on-demand allocation and then freed again before the deferred pages
- * initialization is done, but this is not likely to happen.
- */
-static inline bool should_skip_kasan_poison(struct page *page)
-{
-	if (IS_ENABLED(CONFIG_KASAN_GENERIC))
-		return deferred_pages_enabled();
-
-	return page_kasan_tag(page) == KASAN_TAG_KERNEL;
-}
-
 static void kernel_init_pages(struct page *page, int numpages)
 {
 	int i;
-- 
2.17.1


