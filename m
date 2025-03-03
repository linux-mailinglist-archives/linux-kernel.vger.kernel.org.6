Return-Path: <linux-kernel+bounces-542241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0A4A4C776
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31C6C18844D7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902A223E242;
	Mon,  3 Mar 2025 16:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PPHSbnln"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F48C23A9B0
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019435; cv=none; b=k/9gCgEpYAXbyHlpGZodlF/7WRkrv1hNjvxPApnsqObUsncNCN/xEzRJi6y7fPd4jTprZYz0GqJURlACO9z/728+bpJpuwxRQt1/6/IVUSEZfqE9M+5wsVYJBng9XUaPWMoTfLovqEVkuqQHVGvZFNOyydDxFX4ja7rgG9+LH3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019435; c=relaxed/simple;
	bh=CBy9KDDS4DSmHwlsP4Ue0ubLvN7R0is6yQy4i2JW8zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QDiJtWGC8b9QNzTrjLCO2/2Krj6I1zg3npEe9g8FwzCwpz6Px8P7qduoU1t/sTzONoV3Dk5SXu9Bky7xItfGxFKgQ+SmsLaHU+OLo7jUfa+PYArM//SIQ+IcMx3rFnFYkWXjgQznA97dss6i6h+Pzx355btpYABoUohZxcUnyNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PPHSbnln; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741019432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0VohxUkhEcl68WNDuA0eZYZJxa5JX4ZCeZ0UqfdwFdI=;
	b=PPHSbnlnjUAeXlk64WpDDTeV87/W+QnwyhwF70PYDm1cKoDaBuvmCDUhmNvMaez9HjVEqC
	FTjzC19HFaE5Ajv6wsM2zgk9tXaRrV/43yhnPrbwmv7AEV5dTqg38mfzKDZhupdWIRbbjc
	Y/E8XSycJc/cL3RGnPdJG95xxGK6RyY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-dyxgSc8NPM68P9kNxt_R0Q-1; Mon, 03 Mar 2025 11:30:25 -0500
X-MC-Unique: dyxgSc8NPM68P9kNxt_R0Q-1
X-Mimecast-MFC-AGG-ID: dyxgSc8NPM68P9kNxt_R0Q_1741019424
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-438da39bb69so33335325e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:30:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741019424; x=1741624224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0VohxUkhEcl68WNDuA0eZYZJxa5JX4ZCeZ0UqfdwFdI=;
        b=Qx+QeM0fl0D+bcfFyKuT04O+DmgJVlGmGeMqgqO/T0F2fGDqS/daDvS/UP+YwbSvc+
         FyUC2z2DecrCTt1CHsL4D0dDZMcKlk7PJlGd21UqSlcAveTTPuGTS7+IQx37lAQhQtrX
         MFvcTT84xSPJbni724ONHoPLkXWjN1A7YVeTt1x4HxehB/Dsg4Tsviyxl8WPt31+nwjy
         cEAROh6uo4FpELK5mVUBEMsefQbnBfpLYuKUaQf+erru25YPY1iNEKR5z+ik7ttoocc9
         fm4R7/zIiHt2N+vuC3RPNx1qSAcVwxYRb/WunnQVgW+IH0HVEu70Z6jt+IJLbQII98Mz
         LpTw==
X-Gm-Message-State: AOJu0Yxh51tbJsRgv3rLBpu2X3Z5Iq0mTuG0rAiCf+hRGehM3zSEfV3z
	zf8QNiPBsZREV3sSGAEt9jEdFdubTlaIqRNa3GZsiiQRu3GCN/FIrJgFWOZ821lSlMfXXolCgax
	ZMEaw0xLmYQAI2ZHroKzSGREA6omSvyaSqmI+8/H0G9R2+VIXQQQxWbv3diAZLv5KXKrd9Yuv6U
	4O/IxasgzjkbgyOof1nKY6H+NlLWpDSeuVQ1w4ZMpv2sdE
X-Gm-Gg: ASbGncuiML47QeLudHN4Sfw8+P+RnvSlDDeg2YGP8ZvplWEtM7aETBKl/BPZywXfT+r
	jowlXGWhleTGZGX1K525SdxJ8invHF7DGVgmglaC0IXCQKWUHsVsKeAL/ACswsmId3Sr4tOD/0P
	JwUj8xqGrrtcMUnI8suxeqMXIwf5znEH65BJ8NtqeOPh9gS3KKBP5iqMJm+xdztEjmHc5r4dy++
	5JqeCwHKQV3EYVa4CwO6JetFmyk/i9QxsguBUn8/lcFf8GFTD8RsaWLiZYnfzcSYKkTFA2CQs8F
	623q4j8QEN+UddRJxg8ryCz6kt+udrhCEbIDKuUzggVlIG+JLPs96Ib/Vyhb54K7vCbBQy1VlY0
	5
X-Received: by 2002:a05:600c:3596:b0:439:9494:318 with SMTP id 5b1f17b1804b1-43ba66e252dmr97507845e9.1.1741019424019;
        Mon, 03 Mar 2025 08:30:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEA60b0YZJ7pQqMV6rPSAHKqjeBG5mk2kZJ3T/m9wf5+mg4ZPniiyD7qwD32/lnlnL6IXv1QQ==
X-Received: by 2002:a05:600c:3596:b0:439:9494:318 with SMTP id 5b1f17b1804b1-43ba66e252dmr97507315e9.1.1741019423515;
        Mon, 03 Mar 2025 08:30:23 -0800 (PST)
Received: from localhost (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-390e485ddedsm14691606f8f.89.2025.03.03.08.30.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:30:22 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Muchun Song <muchun.song@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v3 03/20] mm: let _folio_nr_pages overlay memcg_data in first tail page
Date: Mon,  3 Mar 2025 17:29:56 +0100
Message-ID: <20250303163014.1128035-4-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303163014.1128035-1-david@redhat.com>
References: <20250303163014.1128035-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's free up some more of the "unconditionally available on 64BIT"
space in order-1 folios by letting _folio_nr_pages overlay memcg_data in
the first tail page (second folio page). Consequently, we have the
optimization now whenever we have CONFIG_MEMCG, independent of 64BIT.

We have to make sure that page->memcg on tail pages does not return
"surprises". page_memcg_check() already properly refuses PageTail().
Let's do that earlier in print_page_owner_memcg() to avoid printing
wrong "Slab cache page" information. No other code should touch that
field on tail pages of compound pages.

Reset the "_nr_pages" to 0 when splitting folios, or when freeing them
back to the buddy (to avoid false page->memcg_data "bad page" reports).

Note that in __split_huge_page(), folio_nr_pages() would stop working
already as soon as we start messing with the subpages.

Most kernel configs should have at least CONFIG_MEMCG enabled, even if
disabled at runtime. 64byte "struct memmap" is what we usually have
on 64BIT.

While at it, rename "_folio_nr_pages" to "_nr_pages".

Hopefully memdescs / dynamically allocating "strut folio" in the future
will further clean this up, e.g., making _nr_pages available in all
configs and maybe even in small folios. Doing that should be fairly easy
on top of this change.

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h       |  4 ++--
 include/linux/mm_types.h | 30 ++++++++++++++++++++++--------
 mm/huge_memory.c         | 16 +++++++++++++---
 mm/internal.h            |  4 ++--
 mm/page_alloc.c          |  6 +++++-
 mm/page_owner.c          |  2 +-
 6 files changed, 45 insertions(+), 17 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a743321dc1a5d..694704217df8a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1199,10 +1199,10 @@ static inline unsigned int folio_large_order(const struct folio *folio)
 	return folio->_flags_1 & 0xff;
 }
 
-#ifdef CONFIG_64BIT
+#ifdef NR_PAGES_IN_LARGE_FOLIO
 static inline long folio_large_nr_pages(const struct folio *folio)
 {
-	return folio->_folio_nr_pages;
+	return folio->_nr_pages;
 }
 #else
 static inline long folio_large_nr_pages(const struct folio *folio)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 689b2a7461892..e81be20bbabc6 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -287,6 +287,11 @@ typedef struct {
 	unsigned long val;
 } swp_entry_t;
 
+#if defined(CONFIG_MEMCG) || defined(CONFIG_SLAB_OBJ_EXT)
+/* We have some extra room after the refcount in tail pages. */
+#define NR_PAGES_IN_LARGE_FOLIO
+#endif
+
 /**
  * struct folio - Represents a contiguous set of bytes.
  * @flags: Identical to the page flags.
@@ -312,7 +317,7 @@ typedef struct {
  * @_large_mapcount: Do not use directly, call folio_mapcount().
  * @_nr_pages_mapped: Do not use outside of rmap and debug code.
  * @_pincount: Do not use directly, call folio_maybe_dma_pinned().
- * @_folio_nr_pages: Do not use directly, call folio_nr_pages().
+ * @_nr_pages: Do not use directly, call folio_nr_pages().
  * @_hugetlb_subpool: Do not use directly, use accessor in hugetlb.h.
  * @_hugetlb_cgroup: Do not use directly, use accessor in hugetlb_cgroup.h.
  * @_hugetlb_cgroup_rsvd: Do not use directly, use accessor in hugetlb_cgroup.h.
@@ -377,13 +382,20 @@ struct folio {
 			unsigned long _flags_1;
 			unsigned long _head_1;
 	/* public: */
-			atomic_t _large_mapcount;
-			atomic_t _entire_mapcount;
-			atomic_t _nr_pages_mapped;
-			atomic_t _pincount;
-#ifdef CONFIG_64BIT
-			unsigned int _folio_nr_pages;
-#endif
+			union {
+				struct {
+					atomic_t _large_mapcount;
+					atomic_t _entire_mapcount;
+					atomic_t _nr_pages_mapped;
+					atomic_t _pincount;
+				};
+				unsigned long _usable_1[4];
+			};
+			atomic_t _mapcount_1;
+			atomic_t _refcount_1;
+#ifdef NR_PAGES_IN_LARGE_FOLIO
+			unsigned int _nr_pages;
+#endif /* NR_PAGES_IN_LARGE_FOLIO */
 	/* private: the union with struct page is transitional */
 		};
 		struct page __page_1;
@@ -435,6 +447,8 @@ FOLIO_MATCH(_last_cpupid, _last_cpupid);
 			offsetof(struct page, pg) + sizeof(struct page))
 FOLIO_MATCH(flags, _flags_1);
 FOLIO_MATCH(compound_head, _head_1);
+FOLIO_MATCH(_mapcount, _mapcount_1);
+FOLIO_MATCH(_refcount, _refcount_1);
 #undef FOLIO_MATCH
 #define FOLIO_MATCH(pg, fl)						\
 	static_assert(offsetof(struct folio, fl) ==			\
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 6ac6d468af0d4..07d43ca6db1c6 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3307,10 +3307,11 @@ bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins)
  * It splits @folio into @new_order folios and copies the @folio metadata to
  * all the resulting folios.
  */
-static void __split_folio_to_order(struct folio *folio, int new_order)
+static void __split_folio_to_order(struct folio *folio, int old_order,
+		int new_order)
 {
-	long nr_pages = folio_nr_pages(folio);
 	long new_nr_pages = 1 << new_order;
+	long nr_pages = 1 << old_order;
 	long index;
 
 	/*
@@ -3528,12 +3529,21 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 			}
 		}
 
+		/*
+		 * Reset any memcg data overlay in the tail pages.
+		 * folio_nr_pages() is unreliable until prep_compound_page()
+		 * was called again.
+		 */
+#ifdef NR_PAGES_IN_LARGE_FOLIO
+		folio->_nr_pages = 0;
+#endif
+
 		/* complete memcg works before add pages to LRU */
 		split_page_memcg(&folio->page, old_order, split_order);
 		split_page_owner(&folio->page, old_order, split_order);
 		pgalloc_tag_split(folio, old_order, split_order);
 
-		__split_folio_to_order(folio, split_order);
+		__split_folio_to_order(folio, old_order, split_order);
 
 after_split:
 		/*
diff --git a/mm/internal.h b/mm/internal.h
index bb9f3624cf952..bcda1f604038f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -682,8 +682,8 @@ static inline void folio_set_order(struct folio *folio, unsigned int order)
 		return;
 
 	folio->_flags_1 = (folio->_flags_1 & ~0xffUL) | order;
-#ifdef CONFIG_64BIT
-	folio->_folio_nr_pages = 1U << order;
+#ifdef NR_PAGES_IN_LARGE_FOLIO
+	folio->_nr_pages = 1U << order;
 #endif
 }
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index dd7e280a61c69..ae0f2a2e87369 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1178,8 +1178,12 @@ __always_inline bool free_pages_prepare(struct page *page,
 	if (unlikely(order)) {
 		int i;
 
-		if (compound)
+		if (compound) {
 			page[1].flags &= ~PAGE_FLAGS_SECOND;
+#ifdef NR_PAGES_IN_LARGE_FOLIO
+			folio->_nr_pages = 0;
+#endif
+		}
 		for (i = 1; i < (1 << order); i++) {
 			if (compound)
 				bad += free_tail_page_prepare(page, page + i);
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 2d6360eaccbb6..a409e2561a8fd 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -507,7 +507,7 @@ static inline int print_page_owner_memcg(char *kbuf, size_t count, int ret,
 
 	rcu_read_lock();
 	memcg_data = READ_ONCE(page->memcg_data);
-	if (!memcg_data)
+	if (!memcg_data || PageTail(page))
 		goto out_unlock;
 
 	if (memcg_data & MEMCG_DATA_OBJEXTS)
-- 
2.48.1


