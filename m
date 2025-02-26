Return-Path: <linux-kernel+bounces-533747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C9CA45E35
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2FDA189D118
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F85E22157E;
	Wed, 26 Feb 2025 12:03:54 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B467E21B9E1
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571433; cv=none; b=a8FVd349SdXetb/APDI3LNwB50EDwjq9TvZoNy3n+vlzleunVSHTlLl4sYRqRGPRVfOjmClGZI0PUFj5JOgSxr1td3lm3tXIoVuuuhY07VKwG1fEUyn9ajYn4+MOzTxvc/JCyWB6XlJLTAu4gKRzbXLkl1sp8cikPWdQc2AMZ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571433; c=relaxed/simple;
	bh=OJuzgkN+IsXOPgz1DjIkAJztclDSa15vEKhFF5PJJws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=XCwW6mpoeqY0I90fVQKuBi6vH6cq9a3LAF3fNtOmLW+22O4XMdOuawhcUh4qM4pQF/zog7XKkvkUa4CVFYQFXXm4iDefoItVBmDh4GQGBYvlaZpcf65P8vAVxJWE44v8wqILkVX/ehlQI3pHMf7ll1mnHnUVUdB5OHTj/nJhoZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-0f-67bf0322004f
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
Subject: [RFC PATCH v12 based on v6.14-rc4 06/25] mm: move should_skip_kasan_poison() to mm/internal.h
Date: Wed, 26 Feb 2025 21:03:17 +0900
Message-Id: <20250226120336.29565-6-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226120336.29565-1-byungchul@sk.com>
References: <20250226113024.GA1935@system.software.com>
 <20250226120336.29565-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsXC9ZZnka4S8/50gys7FC3mrF/DZvF5wz82
	i6/rfzFbPP3Ux2JxedccNot7a/6zWpzftZbVYsfSfUwWlw4sYLI43nuAyWL+vc9sFps3TWW2
	OD5lKqPF7x9z2Bz4PL639rF47Jx1l91jwaZSj80rtDw2repk89j0aRK7x7tz59g9Tsz4zeLx
	ft9VNo+tv+w8GqdeY/P4vEkugCeKyyYlNSezLLVI3y6BK2P/+7PsBQt1Ku73/2ZuYJyj0sXI
	ySEhYCKx/V4/G4x94vFbdhCbTUBd4saNn8wgtoiAmcTB1j9AcS4OZoFlTBJ7TzQANXBwCAuk
	Say9JQlSwyKgKrGpaRJYL6+AqcSfXQtZIWbKS6zecABsDifQnE/TjoHtEhJIltj5+w8TyEwJ
	gftsEk9XNDFDNEhKHFxxg2UCI+8CRoZVjEKZeWW5iZk5JnoZlXmZFXrJ+bmbGIFBvaz2T/QO
	xk8Xgg8xCnAwKvHwPjizN12INbGsuDL3EKMEB7OSCC9n5p50Id6UxMqq1KL8+KLSnNTiQ4zS
	HCxK4rxG38pThATSE0tSs1NTC1KLYLJMHJxSDYy1LmaMCnelbmxlrfpuEFwd6ncz1F4meNna
	hMPVLrbezb16hw9vk779TddFU2Kv4iPlkA1TO3PfxR4qf6Vw9fGpt3sTHq1rCH6R9EfbY9pb
	nxVB01zlNDZUhDEs2GH3p7/6ypWFIsf2LX0QOMv13rvN71/p13PoLvKq/cMmLX8g+sKhurtP
	WBYrsRRnJBpqMRcVJwIAXY/5umYCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLMWRmVeSWpSXmKPExsXC5WfdrKvEvD/d4MVlMYs569ewWXze8I/N
	4uv6X8wWTz/1sVgcnnuS1eLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHG89wCTxfx7n9ks
	Nm+aymxxfMpURovfP+awOfB7fG/tY/HYOesuu8eCTaUem1doeWxa1cnmsenTJHaPd+fOsXuc
	mPGbxeP9vqtsHotffGDy2PrLzqNx6jU2j8+b5AJ4o7hsUlJzMstSi/TtErgy9r8/y16wUKfi
	fv9v5gbGOSpdjJwcEgImEicev2UHsdkE1CVu3PjJDGKLCJhJHGz9AxTn4mAWWMYksfdEA1sX
	IweHsECaxNpbkiA1LAKqEpuaJoH18gqYSvzZtZAVYqa8xOoNB8DmcALN+TTtGBuILSSQLLHz
	9x+mCYxcCxgZVjGKZOaV5SZm5pjqFWdnVOZlVugl5+duYgSG6LLaPxN3MH657H6IUYCDUYmH
	98GZvelCrIllxZW5hxglOJiVRHg5M/ekC/GmJFZWpRblxxeV5qQWH2KU5mBREuf1Ck9NEBJI
	TyxJzU5NLUgtgskycXBKNTDW8i4PXHj84t83p7/4CQvNFcgS4Jk5eXcD5+EYi0W7PjP3Ftfn
	XYzvj3m0rOuv56zZV8KnO878vfLkBkmRMh/ntiDHEs7S3z+8nZ4rihdM+7RJP8pin8vUoiil
	xwZWi3M4terlPS+zPX9jGHz9orGa3aHjXgzMp7Zs2D7hX0Ha8p9uMTVaNRJKLMUZiYZazEXF
	iQCrjtWPTQIAAA==
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
index d7161a6e0b352..4c8ed93a792ec 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1051,8 +1051,55 @@ static inline void vunmap_range_noflush(unsigned long start, unsigned long end)
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
index c08b1389d5671..27aeee0cfcf8f 100644
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


