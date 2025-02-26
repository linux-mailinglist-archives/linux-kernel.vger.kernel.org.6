Return-Path: <linux-kernel+bounces-533717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A11CCA45E13
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B82F3A626F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E04A21B1A8;
	Wed, 26 Feb 2025 12:01:49 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DEA214817
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571308; cv=none; b=LYFtXZ6HbiU3OqPfnfvomR+xJF8NYfyeTrGoxEmCEiLa+MW7MRZMWfvj+Y7E70a+Wq8fUqz/Cxz1BzJALCcaKQl7QgqdqpekuFonftcnHUSLQkPsUcKZJbH76zsSYTE7HJVcUXbV/8Jj+qrSItnzzv6djHIlCHYjlcOz1fOZ92Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571308; c=relaxed/simple;
	bh=aNVsO+usgBvf/HHZ53huFXEovL4ax/Fd84xoBZ79LSA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=SKTVCDNU3y4pk4pEdQbk3CDBWapW/T/LdDIKjqhqf0r/ybrFQDhZAxBS9OuA5n5/m7IWAcZE0Xp3LoyVPGEz19T6AwLGNjwQ/OUoE90r0pHKs75azPlGu/q8GhDsXFEV3+AOQd8cHGpmsEmrMEyBVeffvA1oRUqU9wlQYZEFa7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-e0-67bf02a6185d
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
Subject: [RFC PATCH v12 based on mm-unstable as of Feb 21, 2025 06/25] mm: move should_skip_kasan_poison() to mm/internal.h
Date: Wed, 26 Feb 2025 21:01:13 +0900
Message-Id: <20250226120132.28469-6-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226120132.28469-1-byungchul@sk.com>
References: <20250226113342.GB1935@system.software.com>
 <20250226120132.28469-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsXC9ZZnke4ypv3pBpf6VCzmrF/DZvF5wz82
	i6/rfzFbPP3Ux2JxedccNot7a/6zWpzftZbVYsfSfUwWlw4sYLI43nuAyWL+vc9sFps3TWW2
	OD5lKqPF7x9z2Bz4PL639rF47Jx1l91jwaZSj80rtDw2repk89j0aRK7x7tz59g9Tsz4zeLx
	ft9VNo+tv+w8GqdeY/P4vEkugCeKyyYlNSezLLVI3y6BK2NB+1fGgoU6FRubv7I2MM5R6WLk
	4JAQMJH4uUS5i5ETzHzxcCkLiM0moC5x48ZPZhBbRMBM4mDrH/YuRi4OZoFlTBJ7TzSwgSSE
	Baol/h3ZxQoyh0VAVWJqgzlImFfAVOLl04VsEDPlJVZvOAA2hxNozr/dv9lBbCGBZImW9b9Z
	QGZKCNxnkzg8o40FokFS4uCKGywTGHkXMDKsYhTKzCvLTczMMdHLqMzLrNBLzs/dxAgM6WW1
	f6J3MH66EHyIUYCDUYmH98GZvelCrIllxZW5hxglOJiVRHg5M/ekC/GmJFZWpRblxxeV5qQW
	H2KU5mBREuc1+laeIiSQnliSmp2aWpBaBJNl4uCUamAMPH1HLnjVo5Zb5m/1d/A/1vhzQUfz
	cPqXCzo1jPsWvlymcajVSfd3/i/roHr293+CY1lDWx7eiLirdHDOj5mMSlKpK9XmqYWmOD16
	dV9VYJ/Sn4Pn/B6+/NzM/Ktw1v/ch1NXJ7IorZv7U93HNYW5dtbnPXdOWNmKMc16LCLk4TC9
	O/GWDkO1EktxRqKhFnNRcSIAnzG2WWUCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLMWRmVeSWpSXmKPExsXC5WfdrLuMaX+6wdSl4hZz1q9hs/i84R+b
	xdf1v5gtnn7qY7E4PPckq8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/f8xhc+D3+N7ax+Kxc9Zddo8Fm0o9Nq/Q8ti0qpPNY9OnSewe786dY/c4
	MeM3i8f7fVfZPBa/+MDksfWXnUfj1GtsHp83yQXwRnHZpKTmZJalFunbJXBlLGj/yliwUKdi
	Y/NX1gbGOSpdjJwcEgImEi8eLmUBsdkE1CVu3PjJDGKLCJhJHGz9w97FyMXBLLCMSWLviQY2
	kISwQLXEvyO7WLsYOThYBFQlpjaYg4R5BUwlXj5dyAYxU15i9YYDYHM4geb82/2bHcQWEkiW
	aFn/m2UCI9cCRoZVjCKZeWW5iZk5pnrF2RmVeZkVesn5uZsYgSG6rPbPxB2MXy67H2IU4GBU
	4uF9cGZvuhBrYllxZe4hRgkOZiURXs7MPelCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeb3CUxOE
	BNITS1KzU1MLUotgskwcnFINjBp/XQ1z4qQ5OyU5xLrC/3555chz5hcj9zuO8NYK42svFm2R
	s3ZjWCqfW/VgXumXPGePezvFLVc8qv54wavLqP+D8lkl3v06jlvu+tv8W5QV9eOpvFqX+gRb
	q++/Z0fNK3vBo7T4/8IbuSzW36MXWex74K4VFTY/X8tDfnPsvaYlbgtjjnueUGIpzkg01GIu
	Kk4EAGS9OkJNAgAA
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
index c4d2018a7cf8e..ee8af97c39f59 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1067,8 +1067,55 @@ static inline void vunmap_range_noflush(unsigned long start, unsigned long end)
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
index 86c9fa45d36fe..f3930a2a05cd3 100644
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


