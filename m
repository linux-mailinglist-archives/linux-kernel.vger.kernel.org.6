Return-Path: <linux-kernel+bounces-184974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C568CAEBA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B8741F2279C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 12:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B9477F2F;
	Tue, 21 May 2024 12:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ptlBK/pd"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF24770F2
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 12:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716296253; cv=none; b=OStOHYlmD0/WR2iRZZlDLMZz+iHaFXRAKiEw7iPGe4sZ7OXnT1pXrOws0hXO1x33D9Wz5CjeH48IELjNObj91v2U6wFkkMqhWlf1kugkreIJutzgPBRsbHYfekPdOmuC1axXGybQ+3OdoOR5OmsqP7scB1uwlvf23lTER8Qdl6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716296253; c=relaxed/simple;
	bh=K8hyEWt5P6rEtT4czAWRxHMZfJ5snUjMLM4ck6p0xes=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CoVFqduWm4ctxgyAlQt8aqG4ROkWq9++2jA6SILs3SVSDrMhaxCfDMKdd33bqtc9kEqFXzUoOo2Heu7AFMn//xkyrW/uraLH0CovU9sl2gCkItfbEx8xWpKOWp24npgIRyeJQAhgQdzHhZVjM522LtjbhqurTnWW3UvZQ+CntSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ptlBK/pd; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de615257412so22370905276.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 05:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716296251; x=1716901051; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tRM9o0p6I8YJ1VI9X9CkGkomZF/jTW7vEZ+k3El+rfw=;
        b=ptlBK/pddu3QSMgrQ2Q1eJYMzyYTFnOrLNz1DJFL5CSjdJIJestRrIpFELgbiVLHpO
         N0EWRTgzuzOt5eftyoWm4WTl1RPmi5ggAg1VzQrqxSZ4LVniuvFE9PFshJAmPQF68cj8
         i+CLFdkJjsLd6COVgL9xJRrFTd3ruy4kNEqqA3vYR5p9nTA6zj9cnq/P6QH5E0Q6CyGF
         3B9lCJAP+syWIW4q/09sao1nwlrXiNikqPuMNGom/G8wwDtb10tdM3ii49wKsD5dIg4R
         TTsWimEPy2ZQGb0xPxCtu4UEOE7/aHVwrBmQzhOXm+pxR0I9EbTWo86Pbow/NyQWiQY6
         l1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716296251; x=1716901051;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tRM9o0p6I8YJ1VI9X9CkGkomZF/jTW7vEZ+k3El+rfw=;
        b=KDXxdk5Q/I1xOOtiuQGaD6oyTG9bY2m5voCv2FlCjde2xFXdLZM+BGkU8vuv2Jmpss
         tjO+0MnAsrFboaSjviLm/Zsi0VqyzH8PuJn72UwLJgoVQnmlhXXaq18ZtAAeQlGtb8cR
         zSdObo86gQSeOAR8JR9wT2KWThtdOgR18yKnQW1CODhD61l8N3jtezgvUqnxV1ALmANG
         7DJZxHtAwjQ/DxvDqEO6QJj3VDQAWoH8RyvEn6HCjfu2iB4IB4OJkyWHdr2vwuv6Vt5j
         enlkNFfg4uABwa6pwHsumQ65stirVBISghQ4/yD2T+6rAritDAOAqLhAFvIfQRqEZ2jA
         7NmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVy/gdwVGElDysbY5jz8jve0InfzWSw4N9qp8xTElWQ62VMFsUSNLH1AxWA/iXxT4GK+yfpgN02T2OILv1xWzdbu8fOA9GL62IrfGqV
X-Gm-Message-State: AOJu0Yxdi4qY9nC3E8CBK2ktgjWXmskgVqPKBA0qZ7CrEZEszArg06Gy
	4MB+4b2MUI0TdpFDIY9H/fdYS1bc11zIkNLP8QpYZ0qkq99wpjjrJYJ700um9w6WnpvTdFvS7Ql
	eEkJTwFeWEg==
X-Google-Smtp-Source: AGHT+IHUQuVOIfwVncwQOFUHVovBLz5PWrCe4Dx+2LOZnSScbdDQHrTlBjLZBbELeDi9NMGgMHKZKXynUK6x6Q==
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a05:6902:120f:b0:dcb:e982:4e40 with SMTP
 id 3f1490d57ef6-dee4f38b7cbmr8662141276.12.1716296250742; Tue, 21 May 2024
 05:57:30 -0700 (PDT)
Date: Tue, 21 May 2024 12:57:18 +0000
In-Reply-To: <20240521-mm-hotplug-sync-v1-0-6d53706c1ba8@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240521-mm-hotplug-sync-v1-0-6d53706c1ba8@google.com>
X-Mailer: b4 0.14-dev
Message-ID: <20240521-mm-hotplug-sync-v1-1-6d53706c1ba8@google.com>
Subject: [PATCH 1/2] mm,memory_hotplug: Remove un-taken lock
From: Brendan Jackman <jackmanb@google.com>
To: David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

It seems that [1] was acked, and the a v2 was written[2] which improved
upon it, but got bogged down in discussion of other topics, so the
improvements were not included. Then [1] got merged as commit
27cacaad16c5 ("mm,memory_hotplug: drop unneeded locking") and we ended
up with locks that get taken for read but never for write.

So, let's remove the read locking.

Compared to Oscar's original v2[2], I have added a READ_ONCE in
page_outside_zone_boundaries; this is a substitute for the compiler
barrier that was implied by read_seqretry(). I believe this is necessary
to insure against UB, although the value being read here is only used
for a printk so the stakes seem very low (and this is all debug code
anyway). I believe a compiler barrier is also needed in zone_spans_pfn,
but I'll address that in a separate patch.

That read_seqretry() also impleied a CPU-level memory barrier, which I
don't think needs replacing: page_outside_zone_boundaries() is used in
the alloc and free paths, but you can't allocate or free pages from
the span that is in the middle of being added/removed by hotplug.

In other words, page_outside_zone_boundaries() doesn't require a
strictly up-to-date view of spanned_pages, but I think it does require
a value that was once/will eventually be correct, hence READ_ONCE.

[1] https://lore.kernel.org/all/20210531093958.15021-1-osalvador@suse.de/T/#u
[2] https://lore.kernel.org/linux-mm/20210602091457.17772-3-osalvador@suse.de/#t

Cc: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Co-developed-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 include/linux/memory_hotplug.h | 35 -----------------------------------
 include/linux/mmzone.h         | 23 +++++------------------
 mm/mm_init.c                   |  1 -
 mm/page_alloc.c                | 10 +++-------
 4 files changed, 8 insertions(+), 61 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 7a9ff464608d..f9577e67e5ee 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -141,31 +141,7 @@ bool mhp_supports_memmap_on_memory(void);
 
 /*
  * Zone resizing functions
- *
- * Note: any attempt to resize a zone should has pgdat_resize_lock()
- * zone_span_writelock() both held. This ensure the size of a zone
- * can't be changed while pgdat_resize_lock() held.
  */
-static inline unsigned zone_span_seqbegin(struct zone *zone)
-{
-	return read_seqbegin(&zone->span_seqlock);
-}
-static inline int zone_span_seqretry(struct zone *zone, unsigned iv)
-{
-	return read_seqretry(&zone->span_seqlock, iv);
-}
-static inline void zone_span_writelock(struct zone *zone)
-{
-	write_seqlock(&zone->span_seqlock);
-}
-static inline void zone_span_writeunlock(struct zone *zone)
-{
-	write_sequnlock(&zone->span_seqlock);
-}
-static inline void zone_seqlock_init(struct zone *zone)
-{
-	seqlock_init(&zone->span_seqlock);
-}
 extern void adjust_present_page_count(struct page *page,
 				      struct memory_group *group,
 				      long nr_pages);
@@ -251,17 +227,6 @@ static inline void pgdat_kswapd_lock_init(pg_data_t *pgdat)
 	___page;				\
  })
 
-static inline unsigned zone_span_seqbegin(struct zone *zone)
-{
-	return 0;
-}
-static inline int zone_span_seqretry(struct zone *zone, unsigned iv)
-{
-	return 0;
-}
-static inline void zone_span_writelock(struct zone *zone) {}
-static inline void zone_span_writeunlock(struct zone *zone) {}
-static inline void zone_seqlock_init(struct zone *zone) {}
 
 static inline int try_online_node(int nid)
 {
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 8f9c9590a42c..194ef7fed9d6 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -14,7 +14,6 @@
 #include <linux/threads.h>
 #include <linux/numa.h>
 #include <linux/init.h>
-#include <linux/seqlock.h>
 #include <linux/nodemask.h>
 #include <linux/pageblock-flags.h>
 #include <linux/page-flags-layout.h>
@@ -896,18 +895,11 @@ struct zone {
 	 *
 	 * Locking rules:
 	 *
-	 * zone_start_pfn and spanned_pages are protected by span_seqlock.
-	 * It is a seqlock because it has to be read outside of zone->lock,
-	 * and it is done in the main allocator path.  But, it is written
-	 * quite infrequently.
-	 *
-	 * The span_seq lock is declared along with zone->lock because it is
-	 * frequently read in proximity to zone->lock.  It's good to
-	 * give them a chance of being in the same cacheline.
-	 *
-	 * Write access to present_pages at runtime should be protected by
-	 * mem_hotplug_begin/done(). Any reader who can't tolerant drift of
-	 * present_pages should use get_online_mems() to get a stable value.
+	 * Besides system initialization functions, memory-hotplug is the only
+	 * user that can change zone's {spanned,present} pages at runtime, and
+	 * it does so by holding the mem_hotplug_lock lock. Any readers who
+	 * can't tolerate drift values should use {get,put}_online_mems to get
+	 * a stable value.
 	 */
 	atomic_long_t		managed_pages;
 	unsigned long		spanned_pages;
@@ -930,11 +922,6 @@ struct zone {
 	unsigned long		nr_isolate_pageblock;
 #endif
 
-#ifdef CONFIG_MEMORY_HOTPLUG
-	/* see spanned/present_pages for more description */
-	seqlock_t		span_seqlock;
-#endif
-
 	int initialized;
 
 	/* Write-intensive fields used from the page allocator */
diff --git a/mm/mm_init.c b/mm/mm_init.c
index f72b852bd5b8..c725618aeb58 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1383,7 +1383,6 @@ static void __meminit zone_init_internals(struct zone *zone, enum zone_type idx,
 	zone->name = zone_names[idx];
 	zone->zone_pgdat = NODE_DATA(nid);
 	spin_lock_init(&zone->lock);
-	zone_seqlock_init(zone);
 	zone_pcp_init(zone);
 }
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2e22ce5675ca..5116a2b9ea6e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -426,16 +426,12 @@ void set_pageblock_migratetype(struct page *page, int migratetype)
 static int page_outside_zone_boundaries(struct zone *zone, struct page *page)
 {
 	int ret;
-	unsigned seq;
 	unsigned long pfn = page_to_pfn(page);
 	unsigned long sp, start_pfn;
 
-	do {
-		seq = zone_span_seqbegin(zone);
-		start_pfn = zone->zone_start_pfn;
-		sp = zone->spanned_pages;
-		ret = !zone_spans_pfn(zone, pfn);
-	} while (zone_span_seqretry(zone, seq));
+	start_pfn = zone->zone_start_pfn;
+	sp = READ_ONCE(zone->spanned_pages);
+	ret = !zone_spans_pfn(zone, pfn);
 
 	if (ret)
 		pr_err("page 0x%lx outside node %d zone %s [ 0x%lx - 0x%lx ]\n",

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


