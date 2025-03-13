Return-Path: <linux-kernel+bounces-560172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2775A5FEF3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1043318908EA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7F51F3FD0;
	Thu, 13 Mar 2025 18:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I/VCXTBP"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49C01EF0B0
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 18:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741889526; cv=none; b=Bgzw2BXzKp+MxjJfag0oTPDWdGqf4SsnrgNBu6XEUPiIDsQycMPzYbKfk3PSJg32UcpuPKBGBmYJFyE0yZ9geQpHeGyqWeXp7hsqiiguslLle5S6m8SuclM1GlieruJioLQkDvAKsvhl75fcDAIYnMtO7X8stUgisbhrau4tCng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741889526; c=relaxed/simple;
	bh=v7imAdqjD4pAPp4qMYhNCQjF4lz5o+NNzBuaHhgAwAw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I83G05zATXeEgCZ4noHrNWMwHFW5FSKA6Leg6sAA64xc+dSagI4cvEM7XpaY1sD7BP+7KQoC1jjxlE1mmDuikbk9bCciEyI0xSBK8KZFmXC27qe9jWZQ9hQeofoP8w6VdnxgKYAaSTScNe27UwHWZxATMmNlxQpXcePsMpWC5D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I/VCXTBP; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43ceeaf1524so6822135e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741889523; x=1742494323; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jZCBSIxQMZuxgPH5nxXznTpvfPN1Wm6wtktBoLoOnVE=;
        b=I/VCXTBPbN6WKMaoiCCAHNuAxqwWMGlbGhRcabqSEk4UV6JBHzOC7IB9w/3HG1n3lF
         5aDn0gYFVC86MU7AU7uOtxXmyMjtyJ784ZMHbYBj2iE7KF+LOh46PRwwIGZk3ceBkyr7
         f6Fqb6LJZMfTMAutKBMezq03I3t9gMXaRs1zcdYD/AG34klSN4vQbajuHq8INcW2yo2C
         MC6yK5EL6cblz9Hv4aMtr7UO/l+sfhdp+PjuppaulDCAXyC0PndSaJyjen79fXyVVa4t
         AsCAv3AOhFdMIuIEYNJOqplCIYEVX/Q1n2kqgZKUrY20gCIPbTAr4FO6oiDTGfr1l+AX
         1eTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741889523; x=1742494323;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jZCBSIxQMZuxgPH5nxXznTpvfPN1Wm6wtktBoLoOnVE=;
        b=wMmH4VU03QI4KWromxmjryQBsHuQ2EhW7IBS3MeNeoWL3ZFcjWeoyc9I8pDAfR1MBN
         BT7edNGqN+I4/EDK1Br3x97Hko6bor7udeCgoA7ocHQVWpzzWMeX2ugwNyCRERrUtgOV
         d1FpNukQtg4YK5WmndoEgJO9elDk4Vw6Xb6i39VQnAaXlruQF+cZsFnwpODpXcNv5iLk
         pV01WCfHv7RaW9Ns4bwu2uvKcxUMJdYkQkoW6z/8iC86obH6FHdQQ0nUzzTqafp8dmPL
         joNY5UytksEReR9LDQ6nE9Yp5l+7v2ZuzVNIY8jDHm72oNDzloZ8vIgXBXmOAfJrYBv/
         kMDA==
X-Gm-Message-State: AOJu0YywIlmYyAebW1M5pNXn6nxrAA7x6nQ+RpwqFmod/RGpdrsiJqet
	vuz48HQ9u2yU74OHwiNqqhadDoBZcqi5OgZkvPIyg8IsQ8B9MBFS1bUX1IaM+DHTNbquJnam240
	7bu+ZX6jsqg==
X-Google-Smtp-Source: AGHT+IFbs6k3vnl5QQ+C0J0hTTMoncea9PLFMkDkNtbfor/v1Jhe1WlJqAJFv/1WYWGnmKJfkaAhbBEhyKJgWQ==
X-Received: from wmrn39.prod.google.com ([2002:a05:600c:5027:b0:43c:f03d:18aa])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3143:b0:439:4c1e:d810 with SMTP id 5b1f17b1804b1-43d1808593dmr31746155e9.9.1741889523325;
 Thu, 13 Mar 2025 11:12:03 -0700 (PDT)
Date: Thu, 13 Mar 2025 18:11:30 +0000
In-Reply-To: <20250313-asi-page-alloc-v1-0-04972e046cea@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250313-asi-page-alloc-v1-0-04972e046cea@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250313-asi-page-alloc-v1-11-04972e046cea@google.com>
Subject: [PATCH RFC 11/11] mm/page_alloc: Add support for ASI-unmapping pages
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

While calling asi_map() is pretty easy, to unmap pages we need to ensure
a TLB shootdown is complete before we allow them to be allocated.

Therefore, treat this as a special case of buddy allocation. Allocate an
entire block, release the zone lock and enable interrupts, then do the
unmap and TLB shootdown. Once that's complete, return any unwanted pages
within the block to the freelists.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/internal.h   |  5 ++++
 mm/page_alloc.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 86 insertions(+), 7 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index b82ab345fb994b7c4971e550556e24bb68f315f6..7904be86fa2c7fded62c100d84fe572c15407ccf 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1189,6 +1189,11 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 #endif
 #define ALLOC_HIGHATOMIC	0x200 /* Allows access to MIGRATE_HIGHATOMIC */
 #define ALLOC_KSWAPD		0x800 /* allow waking of kswapd, __GFP_KSWAPD_RECLAIM set */
+#ifdef CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
+#define ALLOC_ASI_UNMAP	       0x1000 /* allow asi_unmap(), requiring TLB shootdown. */
+#else
+#define ALLOC_ASI_UNMAP		0x0
+#endif
 
 /* Flags that allow allocations below the min watermark. */
 #define ALLOC_RESERVES (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0d8bbad8675c99282f308c4a4122d5d9c4b14dae..9ac883d7a71387d291bc04bad675e2545dd7ba0f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1627,6 +1627,7 @@ struct page *__rmqueue_smallest(struct zone *zone, unsigned int order,
  * The other migratetypes do not have fallbacks.
  *
  * Note there are no fallbacks from sensitive to nonsensitive migratetypes.
+ * That's instead handled as a totally special case in __rmqueue_asi_unmap().
  */
 #ifdef CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
 #define TERMINATE_FALLBACK -1
@@ -2790,7 +2791,77 @@ static inline void zone_statistics(struct zone *preferred_zone, struct zone *z,
 #endif
 }
 
-static __always_inline
+#ifdef CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
+/*
+ * Allocate a page by converting some memory to sensitive, by doing an ASI
+ * unmap. This can't be done via __rmqueue_fallback because that unmap requires
+ * a TLB flush which can only be done with interrupts on.
+ */
+static inline
+struct page *__rmqueue_asi_unmap(struct zone *zone, unsigned int request_order,
+				 unsigned int alloc_flags, int migratetype)
+{
+	struct page *page;
+	int alloc_order;
+	int i;
+
+	lockdep_assert_irqs_enabled();
+
+	if (!(alloc_flags & ALLOC_ASI_UNMAP))
+		return NULL;
+
+	VM_WARN_ON_ONCE(migratetype == MIGRATE_UNMOVABLE_NONSENSITIVE);
+
+	/*
+	 * Need to unmap a whole pageblock (otherwise it might require
+	 * allocating pagetables). Can't do that with the zone lock held, but we
+	 * also can't flip the block's migratetype until the flush is complete,
+	 * otherwise any concurrent sensitive allocations could momentarily leak
+	 * data into the restricted address space. As a simple workaround,
+	 * "allocate" at least the whole block, unmap it (with IRQs enabled),
+	 * then free any remainder of the block again.
+	 *
+	 * An alternative to this could be to synchronize an intermediate state
+	 * on the pageblock (since since this code can't be called in an IRQ,
+	 * this shouldn't be too bad - it's likely OK to just busy-wait until
+	 * any conurrent TLB flush completes.).
+	 */
+
+	alloc_order = max(request_order, pageblock_order);
+	spin_lock_irq(&zone->lock);
+	page = __rmqueue_smallest(zone, alloc_order, MIGRATE_UNMOVABLE_NONSENSITIVE);
+	spin_unlock_irq(&zone->lock);
+	if (!page)
+		return NULL;
+
+	asi_unmap(page, 1 << alloc_order);
+
+	change_pageblock_range(page, alloc_order, migratetype);
+
+	if (request_order >= alloc_order)
+		return page;
+
+	spin_lock_irq(&zone->lock);
+	for (i = request_order; i < alloc_order; i++) {
+		struct page *page_to_free = page + (1 << i);
+
+		__free_one_page(page_to_free, page_to_pfn(page_to_free), zone, i,
+			migratetype, FPI_SKIP_REPORT_NOTIFY);
+	}
+	spin_unlock_irq(&zone->lock);
+
+	return page;
+}
+#else
+static inline
+struct page *__rmqueue_asi_unmap(struct zone *zone, unsigned int order,
+				unsigned int alloc_flags, int migratetype)
+{
+	return NULL;
+}
+#endif
+
+static noinline
 struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 			   unsigned int order, unsigned int alloc_flags,
 			   int migratetype)
@@ -2814,13 +2885,14 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 			 */
 			if (!page && (alloc_flags & (ALLOC_OOM|ALLOC_NON_BLOCK)))
 				page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
-
-			if (!page) {
-				spin_unlock_irqrestore(&zone->lock, flags);
-				return NULL;
-			}
 		}
 		spin_unlock_irqrestore(&zone->lock, flags);
+
+		if (!page)
+			page = __rmqueue_asi_unmap(zone, order, alloc_flags, migratetype);
+
+		if (!page)
+			return NULL;
 	} while (check_new_pages(page, order));
 
 	__count_zid_vm_events(PGALLOC, page_zonenum(page), 1 << order);
@@ -3356,6 +3428,8 @@ static inline unsigned int gfp_to_alloc_flags_cma(gfp_t gfp_mask,
 	if (gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE)
 		alloc_flags |= ALLOC_CMA;
 #endif
+	if (gfp_mask & __GFP_SENSITIVE && gfpflags_allow_blocking(gfp_mask))
+		alloc_flags |= ALLOC_ASI_UNMAP;
 	return alloc_flags;
 }
 
@@ -4382,7 +4456,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	reserve_flags = __gfp_pfmemalloc_flags(gfp_mask);
 	if (reserve_flags)
 		alloc_flags = gfp_to_alloc_flags_cma(gfp_mask, reserve_flags) |
-					  (alloc_flags & ALLOC_KSWAPD);
+					  (alloc_flags & (ALLOC_KSWAPD | ALLOC_ASI_UNMAP));
 
 	/*
 	 * Reset the nodemask and zonelist iterators if memory policies can be

-- 
2.49.0.rc1.451.g8f38331e32-goog


