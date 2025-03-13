Return-Path: <linux-kernel+bounces-560170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B14A5FEF1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 121063BF954
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDA31EF088;
	Thu, 13 Mar 2025 18:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fehhMPoC"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F6C1F3B83
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 18:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741889522; cv=none; b=dziKqViFNg+ambLTVOSIllgXeyWsZmvhdxIOpGq5l0hVoWp01s8xlskM5MqBbqCwKU7DlwkYoLYumWbOo6wB0wEVvlcXH81zO735SDvYuTI+4IlKjKYFSWp7wCkWUhUEi5BlAgc6qD8015mN4SBxwuHs1eHWqrCs5vAb+E3VcWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741889522; c=relaxed/simple;
	bh=4U2OQp6CokKOk0d8UXBcXGW+WFDNfme7rxCCHcR0p8k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a5zfRoWaaj3P4cKId0g1WgeIQYBqqB0y+CTyc+3905ac3umy5u6zUukS8DtbtUfeU1VgzA/cY5bNiSyhIP8ct4L2JjZGr5A6Doqkx3bEQhrPnP+bhWQl8UqDw6NW/CCACKxJXLFwbXUexxDGkIvEXL1wqZYgSHSm0BLwFwSZCdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fehhMPoC; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43ceeaf1524so6821705e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741889519; x=1742494319; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GhuPyoh4JQENDoXkPgzWqVfgnUM5Erl7lymo551VcRQ=;
        b=fehhMPoCF0hPLBDlPoyCfhYkyIoujTwBA/4yo9Z0Qi54WGiMJhI93GSeuJB+m1RdMY
         n2ULLtYGyvQpi2rwGzirbjyop13eYxCAj1EaBhj+7T1CTy2BKt3aOnw4ypHCS3KuAH+e
         eJixFpYdKpp9/NQ50x8eULnjHbVMpf2BXyk8PBxX/l7eRH9mFYCEKzTGFgaCMIsFu9rv
         DTNZFnjwkDIIDMM58T++GXL9UW4okz5S2cgQ9EUKWvBUO4mm4Yf3UDgbLcvvxYu690vF
         kpAPV9qmNlsLeK+WR5loHdrfiS/qqWNML+CkzCy1xEzDVU/q5n+91xiT1Fmbz5RPLU27
         ZLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741889519; x=1742494319;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GhuPyoh4JQENDoXkPgzWqVfgnUM5Erl7lymo551VcRQ=;
        b=OZQlDMqLtLNCs9XWAkDOkgsbviyMb65qwzwGxA7kmycSf+CES8gpSYnUJ3792+i1eG
         sDWPtPU9Q0DQkv4fLPkmYGYgGsIuszqOkq61kw6kZGjNwooJqoNSDU2adPs4yu9nnoTT
         Tq/YkOrcSUAva6JaWXcCrd/idTwgvHSsnmexcuvl6PQSPj4fk80582cCr/PJZitPn0ZL
         lybSNHDruIUnj5JPW8IJMEU15T5uZiKobww0sL9BXMrRZ4R/nmPoE1Jd5vl0K7r5qc80
         MeZyrCuHPY6tbRiRE+CcPH+/x67E+X132QP6L1QYIfVkaGFuaV6DrJCgdgdlbwTlOFta
         y2lQ==
X-Gm-Message-State: AOJu0YxVGdm/ur0irTbEYlRRubxHkKSZD7RSpKLzH4fhLqGeuv7oMAr3
	TLuGNMV562u5/8ABf//XvoTmWh0NMIta3nWZcI+rt5GPR/ODttMbEW6YNb2MjG+VT3M2g6Asi4f
	GfiBcFClSvw==
X-Google-Smtp-Source: AGHT+IF61pDIZp4JV1y+yCI+Y7/rxQbZzIOQPlfA/NYp0rFg9DJMnWUvBtDooARG1ee4zqcfgN9USmHD1j/7QA==
X-Received: from wmsp2.prod.google.com ([2002:a05:600c:1d82:b0:43c:f517:ac4e])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3143:b0:439:4c1e:d810 with SMTP id 5b1f17b1804b1-43d1808593dmr31744305e9.9.1741889518918;
 Thu, 13 Mar 2025 11:11:58 -0700 (PDT)
Date: Thu, 13 Mar 2025 18:11:28 +0000
In-Reply-To: <20250313-asi-page-alloc-v1-0-04972e046cea@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250313-asi-page-alloc-v1-0-04972e046cea@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250313-asi-page-alloc-v1-9-04972e046cea@google.com>
Subject: [PATCH RFC 09/11] mm/page_alloc: Split MIGRATE_UNMOVABLE by sensitivity
From: Brendan Jackman <jackmanb@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Mike Rapoport <rppt@kernel.org>, Junaid Shahid <junaids@google.com>, Reiji Watanabe <reijiw@google.com>, 
	Patrick Bellasi <derkling@google.com>, Brendan Jackman <jackmanb@google.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="utf-8"

When ASI is compiled in, create two separate unmovable migratetypes.
MIGRATE_UNMOVABLE_NONSENSITIVE represents blocks that are mapped into
ASI's restricted address space.

MIGRATE_UNMOVABLE becomes MIGRATE_UNMOVABLE_SENSITIVE. All other
migratetypes retain their original meaning and gain the additional
implication that the pageblock is not ASI-mapped.

In future extensions it's likely that more migratetypes will need to
support different sensitivities; if and when that happens a more
invasive change will be needed but for now this should allow developing
the necessary allocator logic for flipping sensitivities by modifying
the ASI page tables.

For builds with ASI disabled, the two new migratetypes are aliases for
one another. Some code needs to be aware of this aliasing (for example,
the 'fallbacks' array needs an ifdef for the entries that would
otherwise alias) while others doesn't (for example,
set_pageblock_migratetype() just works regardless).

Since there is now a migratetype below MIGRATE_PCPTYPES with no
fallbacks, the 'fallbacks' arrays are no longer all the same size, so
make them be terminated by a -1 instead of having a fixed size. On
non-ASI builds, the new 'if (fallback_mt < 0)' in
find_suitable_fallback() is provably always false and can be eliminated
by the compiler. Clang 20 seems to be smart enough to do this
regardless, but add a 'const' qualifier to the arrays to try and
increase confidence anyway.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 include/linux/gfp.h    | 21 +++++++++++++++++----
 include/linux/mmzone.h | 19 ++++++++++++++++++-
 mm/memory_hotplug.c    |  2 +-
 mm/page_alloc.c        | 22 +++++++++++++++-------
 mm/show_mem.c          | 13 +++++++------
 5 files changed, 58 insertions(+), 19 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 23289aa54b6c38a71a908e5a6e034828a75a3b66..0253dcfb66cbaa82414528a266271d719bc09d6a 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -20,13 +20,26 @@ static inline int gfp_migratetype(const gfp_t gfp_flags)
 	VM_WARN_ON((gfp_flags & GFP_MOVABLE_MASK) == GFP_MOVABLE_MASK);
 
 	if (unlikely(page_group_by_mobility_disabled))
-		return MIGRATE_UNMOVABLE;
+		goto unmovable;
+
+	/* Only unmovable/unreclaimable pages can be nonsensitive right now. */
+	VM_WARN_ONCE((gfp_flags & GFP_MOVABLE_MASK) && !(gfp_flags & __GFP_SENSITIVE),
+		"%pGg", &gfp_flags);
 
 	switch (gfp_flags & GFP_MOVABLE_MASK) {
-	case __GFP_RECLAIMABLE: return MIGRATE_RECLAIMABLE;
-	case __GFP_MOVABLE: return MIGRATE_MOVABLE;
-	default: return MIGRATE_UNMOVABLE;
+	case __GFP_RECLAIMABLE:
+		return MIGRATE_RECLAIMABLE;
+	case __GFP_MOVABLE:
+		return MIGRATE_MOVABLE;
+	default:
+		break;
 	}
+
+unmovable:
+	if (gfp_flags & __GFP_SENSITIVE)
+		return MIGRATE_UNMOVABLE_SENSITIVE;
+	else
+		return MIGRATE_UNMOVABLE_NONSENSITIVE;
 }
 
 static inline bool gfpflags_allow_blocking(const gfp_t gfp_flags)
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 9540b41894da6d67751506614e90bed142e127b4..b8215b921b71c0b1cbda2d262664b1ee2a0cb750 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -46,7 +46,19 @@
 #define PAGE_ALLOC_COSTLY_ORDER 3
 
 enum migratetype {
-	MIGRATE_UNMOVABLE,
+	/*
+	 * All movable pages are sensitive for ASI. Unmovable pages might be
+	 * either; the migratetype reflects whether they are mapped into the
+	 * global-nonsensitive address space.
+	 *
+	 * TODO: what about HIGHATOMIC/RECLAIMABLE?
+	 */
+	MIGRATE_UNMOVABLE_SENSITIVE,
+#ifdef CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
+	MIGRATE_UNMOVABLE_NONSENSITIVE,
+#else
+	MIGRATE_UNMOVABLE_NONSENSITIVE = MIGRATE_UNMOVABLE_SENSITIVE,
+#endif
 	MIGRATE_MOVABLE,
 	MIGRATE_RECLAIMABLE,
 	MIGRATE_PCPTYPES,	/* the number of types on the pcp lists */
@@ -89,6 +101,11 @@ static inline bool is_migrate_movable(int mt)
 	return is_migrate_cma(mt) || mt == MIGRATE_MOVABLE;
 }
 
+static inline bool is_migrate_unmovable(int mt)
+{
+	return mt == MIGRATE_UNMOVABLE_SENSITIVE || mt == MIGRATE_UNMOVABLE_NONSENSITIVE;
+}
+
 /*
  * Check whether a migratetype can be merged with another migratetype.
  *
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 16cf9e17077e359b98a69dc4bca48f4575b9a28c..28092c51c7a49546f5b7961aaf1500c72de88337 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1127,7 +1127,7 @@ int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
 	if (mhp_off_inaccessible)
 		page_init_poison(pfn_to_page(pfn), sizeof(struct page) * nr_pages);
 
-	move_pfn_range_to_zone(zone, pfn, nr_pages, NULL, MIGRATE_UNMOVABLE);
+	move_pfn_range_to_zone(zone, pfn, nr_pages, NULL, MIGRATE_UNMOVABLE_SENSITIVE);
 
 	for (i = 0; i < nr_pages; i++) {
 		struct page *page = pfn_to_page(pfn + i);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index aa54ef95233a052b5e79b4994b2879a72ff9acfd..ae711025da15823e97cc8b63e0277fc41b5ca0f8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -418,8 +418,9 @@ void set_pfnblock_flags_mask(struct page *page, unsigned long flags,
 void set_pageblock_migratetype(struct page *page, int migratetype)
 {
 	if (unlikely(page_group_by_mobility_disabled &&
-		     migratetype < MIGRATE_PCPTYPES))
-		migratetype = MIGRATE_UNMOVABLE;
+		     migratetype < MIGRATE_PCPTYPES &&
+		     migratetype != MIGRATE_UNMOVABLE_NONSENSITIVE))
+		migratetype = MIGRATE_UNMOVABLE_SENSITIVE;
 
 	set_pfnblock_flags_mask(page, (unsigned long)migratetype,
 				page_to_pfn(page), MIGRATETYPE_MASK);
@@ -1610,10 +1611,14 @@ struct page *__rmqueue_smallest(struct zone *zone, unsigned int order,
  *
  * The other migratetypes do not have fallbacks.
  */
-static int fallbacks[MIGRATE_PCPTYPES][MIGRATE_PCPTYPES - 1] = {
-	[MIGRATE_UNMOVABLE]   = { MIGRATE_RECLAIMABLE, MIGRATE_MOVABLE   },
-	[MIGRATE_MOVABLE]     = { MIGRATE_RECLAIMABLE, MIGRATE_UNMOVABLE },
-	[MIGRATE_RECLAIMABLE] = { MIGRATE_UNMOVABLE,   MIGRATE_MOVABLE   },
+static const int fallbacks[MIGRATE_PCPTYPES][MIGRATE_PCPTYPES - 1] = {
+	[MIGRATE_UNMOVABLE_SENSITIVE]    = { MIGRATE_RECLAIMABLE, MIGRATE_MOVABLE   },
+#ifdef CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
+	/* TODO: Cannot fallback from nonsensitive */
+	[MIGRATE_UNMOVABLE_NONSENSITIVE] = { -1 },
+#endif
+	[MIGRATE_MOVABLE]                = { MIGRATE_RECLAIMABLE, MIGRATE_UNMOVABLE_SENSITIVE },
+	[MIGRATE_RECLAIMABLE]            = { MIGRATE_UNMOVABLE_SENSITIVE,   MIGRATE_MOVABLE   },
 };
 
 #ifdef CONFIG_CMA
@@ -1893,7 +1898,7 @@ static bool should_try_claim_block(unsigned int order, int start_mt)
 	 * allocation size. Later movable allocations can always steal from this
 	 * block, which is less problematic.
 	 */
-	if (start_mt == MIGRATE_RECLAIMABLE || start_mt == MIGRATE_UNMOVABLE)
+	if (start_mt == MIGRATE_RECLAIMABLE || is_migrate_unmovable(start_mt))
 		return true;
 
 	if (page_group_by_mobility_disabled)
@@ -1929,6 +1934,9 @@ int find_suitable_fallback(struct free_area *area, unsigned int order,
 	*claim_block = false;
 	for (i = 0; i < MIGRATE_PCPTYPES - 1 ; i++) {
 		fallback_mt = fallbacks[migratetype][i];
+		if (fallback_mt < 0)
+			return fallback_mt;
+
 		if (free_area_empty(area, fallback_mt))
 			continue;
 
diff --git a/mm/show_mem.c b/mm/show_mem.c
index 43afb56abbd3e1f436452ef551dd8149545ccb13..59af6fb286354156cc2aa258fdd78c85797248a6 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -141,15 +141,16 @@ static bool show_mem_node_skip(unsigned int flags, int nid, nodemask_t *nodemask
 static void show_migration_types(unsigned char type)
 {
 	static const char types[MIGRATE_TYPES] = {
-		[MIGRATE_UNMOVABLE]	= 'U',
-		[MIGRATE_MOVABLE]	= 'M',
-		[MIGRATE_RECLAIMABLE]	= 'E',
-		[MIGRATE_HIGHATOMIC]	= 'H',
+		[MIGRATE_UNMOVABLE_SENSITIVE]		= 'S',
+		[MIGRATE_UNMOVABLE_NONSENSITIVE]	= 'N',
+		[MIGRATE_MOVABLE]			= 'M',
+		[MIGRATE_RECLAIMABLE]			= 'E',
+		[MIGRATE_HIGHATOMIC]			= 'H',
 #ifdef CONFIG_CMA
-		[MIGRATE_CMA]		= 'C',
+		[MIGRATE_CMA]				= 'C',
 #endif
 #ifdef CONFIG_MEMORY_ISOLATION
-		[MIGRATE_ISOLATE]	= 'I',
+		[MIGRATE_ISOLATE]			= 'I',
 #endif
 	};
 	char tmp[MIGRATE_TYPES + 1];

-- 
2.49.0.rc1.451.g8f38331e32-goog


