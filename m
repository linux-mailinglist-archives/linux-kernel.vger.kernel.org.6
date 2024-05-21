Return-Path: <linux-kernel+bounces-184975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CB48CAEBB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C173281659
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 12:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC8178C6D;
	Tue, 21 May 2024 12:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r4VZVDBk"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB54B78276
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 12:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716296256; cv=none; b=sDNnh1dQJV2tSisTRlYN+sjA4vlCMnEr7ZajZbvW+LMpJb8zhdH3ZpsBHR5xWtg8U+e1a9E/cgnYogwMo9gl7YCy2joJj6Ah+7JdrPAXS0Hk7wEcMQH45zcOuxTXwlK1I0kEXvBPYQpHNY1lnFyM6UOlzOT85lTN7WJKeVDry8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716296256; c=relaxed/simple;
	bh=93AUZuHsMYdlo1uCf+dMfhqztW1LZUVjD9Bz+tQ7t3E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Pb5yLAGyhcm4+4y2CxpO9nUq6dNzS995jIQiT0MWoOXb0QEsjS2QP5Ai9obJQA9urjMrDQ0E4lgwLhGGH5jqM8w/e3siyjcjHT9D1GjuO8VYVQAI6zhn/BsFctVzRKPoCs+Wpo5pvnyimrF1kqZjo9UMC2cOvZW1WRhOHUSzEJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r4VZVDBk; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-41fc5c5cc95so56269615e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 05:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716296253; x=1716901053; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bo9M5YTqR8tTEb+CFvSEPP+Md2sw1AJdmaK3l6GjkIM=;
        b=r4VZVDBkUi/V/UvkoilKZWS5vujuxlln9IYOSCkUVeczJ4x42jLOeh2zyyXuYRuQKX
         OtX7UVl0URAZu9Kc+c7ioGPlLcfmITyBvE573VVvMfvb2QNJMN0BoB7Gcgk3uuS/C0G/
         CNsXV2KCraCWOW/5iRS5PCT73VMcL1KIeox3gMiG080s/xEsXShp7LDaC+l9hBxFHfPH
         hUiIwMDBn0cLVXS/5d02YLIeSOB1zR6SnS8UFg/w9bVwPVk9zNlGcWsfyYlsRVF+Hg/X
         c54QwI3oYibhrkL4ukuucmbvnERkqxNhVYan04AwfXpDBAqzJVrxrV684Y0ygi207NVk
         vstw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716296253; x=1716901053;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bo9M5YTqR8tTEb+CFvSEPP+Md2sw1AJdmaK3l6GjkIM=;
        b=w2Cs0B7idJ/ToHyk7rjaXEjRd5h7WUqBJXRVZ7rpAA35eX6z9rBH7vMYh1MZAYAVdr
         8WvEm5/HTVgtq0mdjDZlSAZOqqnRWRfV0PnER0RylGDwbljFa3hkhiMXKI/RkPsDpwF0
         klHr+Ra/In2Z8zHY3exgT+4I11vKu/nEHBCbRI6ujGqb4Xac96nm0sbWFyvrAvoUqtHM
         z6nK9uT+EfzCCXDq35+fHpKHyoO38mrkqi1MWKjUD1tY3YsvwcUsPZVCtNraDlpeVMA5
         P3zT5v8AsuKmrZ9aGVM1OnvCXc2FeDvv2VVCRUJyKqGBaEySCwdEczTpwpOxGyGJiap6
         CnPg==
X-Forwarded-Encrypted: i=1; AJvYcCViDrUWJ8+OXDt/A2VYpGekvnnn+qb8AK5GunPMvz6lJUJeTJz3CqUKx4dAmr6UirOl2ZudPUIm2HG+/+N92EVPbvMr6zH2QOJVQgl5
X-Gm-Message-State: AOJu0Yx9D4lLJyEtZA+Hd52hWTmOW5Upki9avAckVThHoSopPOj8iWkL
	mxAAeIzBQXpfIZGKHtfilz1vMEKe2weMSrHcQrvyWsimNdO4TkSHR6bQo40rV+g2Ss4tPelX8at
	LOKp7497M2A==
X-Google-Smtp-Source: AGHT+IEqtB7J+eET8jECP6dJaE/vZ4au8St4Y37qZzLM3Wd/fTYl0KhtmsX38BXBJE3VkkIRwseWYmA0Pv3/Xg==
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a05:600c:19c8:b0:418:ee30:3f9e with SMTP
 id 5b1f17b1804b1-41fea92770dmr2110535e9.2.1716296253380; Tue, 21 May 2024
 05:57:33 -0700 (PDT)
Date: Tue, 21 May 2024 12:57:19 +0000
In-Reply-To: <20240521-mm-hotplug-sync-v1-0-6d53706c1ba8@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240521-mm-hotplug-sync-v1-0-6d53706c1ba8@google.com>
X-Mailer: b4 0.14-dev
Message-ID: <20240521-mm-hotplug-sync-v1-2-6d53706c1ba8@google.com>
Subject: [PATCH 2/2] mm,memory_hotplug: {READ,WRITE}_ONCE unsynchronized zone data
From: Brendan Jackman <jackmanb@google.com>
To: David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

These fields are written by memory hotplug under mem_hotplug_lock but
read without any lock. It seems like reader code is robust against the
value being stale or "from the future", but we also need to account
for:

1. Load/store tearing (according to Linus[1], this really happens,
   even when everything is aligned as you would hope).

2. Invented loads[2] - the compiler can spill and re-read these fields
   ([2] calls this "invented loads") and assume that they have not
   changed.

Note we don't need READ_ONCE in paths that have the mem_hotplug_lock
for write, but we still need WRITE_ONCE to prevent store-tearing.

[1] https://lore.kernel.org/all/CAHk-=wj2t+GK+DGQ7Xy6U7zMf72e7Jkxn4_-kGyfH3WFEoH+YQ@mail.gmail.com/T/#u
    As discovered via the original big-bad article[2]
[2] https://lwn.net/Articles/793253/

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 include/linux/mmzone.h | 14 ++++++++++----
 mm/compaction.c        |  2 +-
 mm/memory_hotplug.c    | 20 ++++++++++++--------
 mm/mm_init.c           |  2 +-
 mm/page_alloc.c        |  2 +-
 mm/show_mem.c          |  8 ++++----
 mm/vmstat.c            |  4 ++--
 7 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 194ef7fed9d6..bdb3be76d10c 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1018,11 +1018,13 @@ static inline unsigned long zone_cma_pages(struct zone *zone)
 #endif
 }
 
+/* This is unstable unless you hold mem_hotplug_lock. */
 static inline unsigned long zone_end_pfn(const struct zone *zone)
 {
-	return zone->zone_start_pfn + zone->spanned_pages;
+	return zone->zone_start_pfn + READ_ONCE(zone->spanned_pages);
 }
 
+/* This is unstable unless you hold mem_hotplug_lock. */
 static inline bool zone_spans_pfn(const struct zone *zone, unsigned long pfn)
 {
 	return zone->zone_start_pfn <= pfn && pfn < zone_end_pfn(zone);
@@ -1033,9 +1035,10 @@ static inline bool zone_is_initialized(struct zone *zone)
 	return zone->initialized;
 }
 
+/* This is unstable unless you hold mem_hotplug_lock. */
 static inline bool zone_is_empty(struct zone *zone)
 {
-	return zone->spanned_pages == 0;
+	return READ_ONCE(zone->spanned_pages) == 0;
 }
 
 #ifndef BUILD_VDSO32_64
@@ -1485,10 +1488,13 @@ static inline bool managed_zone(struct zone *zone)
 	return zone_managed_pages(zone);
 }
 
-/* Returns true if a zone has memory */
+/*
+ * Returns true if a zone has memory.
+ * This is unstable unless you old mem_hotplug_lock.
+ */
 static inline bool populated_zone(struct zone *zone)
 {
-	return zone->present_pages;
+	return READ_ONCE(zone->present_pages);
 }
 
 #ifdef CONFIG_NUMA
diff --git a/mm/compaction.c b/mm/compaction.c
index e731d45befc7..b8066d1fdcf5 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2239,7 +2239,7 @@ static unsigned int fragmentation_score_zone_weighted(struct zone *zone)
 {
 	unsigned long score;
 
-	score = zone->present_pages * fragmentation_score_zone(zone);
+	score = READ_ONCE(zone->present_pages) * fragmentation_score_zone(zone);
 	return div64_ul(score, zone->zone_pgdat->node_present_pages + 1);
 }
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 431b1f6753c0..71b5e3d314a2 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -463,6 +463,8 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
 	int nid = zone_to_nid(zone);
 
 	if (zone->zone_start_pfn == start_pfn) {
+		unsigned long old_end_pfn = zone_end_pfn(zone);
+
 		/*
 		 * If the section is smallest section in the zone, it need
 		 * shrink zone->zone_start_pfn and zone->zone_spanned_pages.
@@ -470,13 +472,13 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
 		 * for shrinking zone.
 		 */
 		pfn = find_smallest_section_pfn(nid, zone, end_pfn,
-						zone_end_pfn(zone));
+						old_end_pfn);
 		if (pfn) {
-			zone->spanned_pages = zone_end_pfn(zone) - pfn;
+			WRITE_ONCE(zone->spanned_pages, old_end_pfn - pfn);
 			zone->zone_start_pfn = pfn;
 		} else {
 			zone->zone_start_pfn = 0;
-			zone->spanned_pages = 0;
+			WRITE_ONCE(zone->spanned_pages, 0);
 		}
 	} else if (zone_end_pfn(zone) == end_pfn) {
 		/*
@@ -488,10 +490,11 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
 		pfn = find_biggest_section_pfn(nid, zone, zone->zone_start_pfn,
 					       start_pfn);
 		if (pfn)
-			zone->spanned_pages = pfn - zone->zone_start_pfn + 1;
+			WRITE_ONCE(zone->spanned_pages,
+				   pfn - zone->zone_start_pfn + 1);
 		else {
 			zone->zone_start_pfn = 0;
-			zone->spanned_pages = 0;
+			WRITE_ONCE(zone->spanned_pages, 0);
 		}
 	}
 }
@@ -710,7 +713,8 @@ static void __meminit resize_zone_range(struct zone *zone, unsigned long start_p
 	if (zone_is_empty(zone) || start_pfn < zone->zone_start_pfn)
 		zone->zone_start_pfn = start_pfn;
 
-	zone->spanned_pages = max(start_pfn + nr_pages, old_end_pfn) - zone->zone_start_pfn;
+	WRITE_ONCE(zone->spanned_pages,
+		   max(start_pfn + nr_pages, old_end_pfn) - zone->zone_start_pfn);
 }
 
 static void __meminit resize_pgdat_range(struct pglist_data *pgdat, unsigned long start_pfn,
@@ -795,7 +799,7 @@ static void auto_movable_stats_account_zone(struct auto_movable_stats *stats,
 					    struct zone *zone)
 {
 	if (zone_idx(zone) == ZONE_MOVABLE) {
-		stats->movable_pages += zone->present_pages;
+		stats->movable_pages += READ_ONCE(zone->present_pages);
 	} else {
 		stats->kernel_early_pages += zone->present_early_pages;
 #ifdef CONFIG_CMA
@@ -1077,7 +1081,7 @@ void adjust_present_page_count(struct page *page, struct memory_group *group,
 	 */
 	if (early_section(__pfn_to_section(page_to_pfn(page))))
 		zone->present_early_pages += nr_pages;
-	zone->present_pages += nr_pages;
+	WRITE_ONCE(zone->present_pages, zone->present_pages + nr_pages);
 	zone->zone_pgdat->node_present_pages += nr_pages;
 
 	if (group && movable)
diff --git a/mm/mm_init.c b/mm/mm_init.c
index c725618aeb58..ec66f2eadb95 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1540,7 +1540,7 @@ void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
 	for (z = 0; z < MAX_NR_ZONES; z++) {
 		struct zone *zone = pgdat->node_zones + z;
 
-		zone->present_pages = 0;
+		WRITE_ONCE(zone->present_pages, 0);
 		zone_init_internals(zone, z, nid, 0);
 	}
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5116a2b9ea6e..1eb9000ec7d7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5728,7 +5728,7 @@ __meminit void zone_pcp_init(struct zone *zone)
 
 	if (populated_zone(zone))
 		pr_debug("  %s zone: %lu pages, LIFO batch:%u\n", zone->name,
-			 zone->present_pages, zone_batchsize(zone));
+			 READ_ONCE(zone->present_pages), zone_batchsize(zone));
 }
 
 void adjust_managed_page_count(struct page *page, long count)
diff --git a/mm/show_mem.c b/mm/show_mem.c
index bdb439551eef..667680a6107b 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -337,7 +337,7 @@ static void show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_z
 			K(zone_page_state(zone, NR_ZONE_INACTIVE_FILE)),
 			K(zone_page_state(zone, NR_ZONE_UNEVICTABLE)),
 			K(zone_page_state(zone, NR_ZONE_WRITE_PENDING)),
-			K(zone->present_pages),
+			K(READ_ONCE(zone->present_pages)),
 			K(zone_managed_pages(zone)),
 			K(zone_page_state(zone, NR_MLOCK)),
 			K(zone_page_state(zone, NR_BOUNCE)),
@@ -407,11 +407,11 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
 
 	for_each_populated_zone(zone) {
 
-		total += zone->present_pages;
-		reserved += zone->present_pages - zone_managed_pages(zone);
+		total += READ_ONCE(zone->present_pages);
+		reserved += READ_ONCE(zone->present_pages) - zone_managed_pages(zone);
 
 		if (is_highmem(zone))
-			highmem += zone->present_pages;
+			highmem += READ_ONCE(zone->present_pages);
 	}
 
 	printk("%lu pages RAM\n", total);
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 8507c497218b..5a9c4b5768e5 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1708,8 +1708,8 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
 		   min_wmark_pages(zone),
 		   low_wmark_pages(zone),
 		   high_wmark_pages(zone),
-		   zone->spanned_pages,
-		   zone->present_pages,
+		   READ_ONCE(zone->spanned_pages),
+		   READ_ONCE(zone->present_pages),
 		   zone_managed_pages(zone),
 		   zone_cma_pages(zone));
 

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


