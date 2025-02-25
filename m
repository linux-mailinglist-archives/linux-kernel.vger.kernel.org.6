Return-Path: <linux-kernel+bounces-530300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98720A431C0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 01:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 711BB174553
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 00:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9907D7FD;
	Tue, 25 Feb 2025 00:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="zeJL418W"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AC410A1F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 00:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740442246; cv=none; b=nVop8/Z3KVxXlVcAoAwxlqQ1xKcrOCqm5eScPpv2CEJglhRvYzjHaxE/4UlKsmkl+lHgBU6ufPwJnsazKQv0P4Y/+kmmK/Aizyu5MSyvFwrvCWAh23FdinrTEVgGYkUxvtSCgWA2sA9tvr22ziWmlzOXQy2FXDyvdMo/72dlCsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740442246; c=relaxed/simple;
	bh=uJIYBBKABsWx06IUAxuzKVX6yW0jaug2nCyJnRc1UsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BHiaHY2B8vfoseo4vCm2MaXNZnKR+xyRGzXWoPEgYv5IixDAuWWWwfl1UBITuoDNbtJrN7H5xu+7f+K4pX0l5Jc95CRlfLhu5ViGT+/pIrBBqU0ZTLawNefAhA0e0/rdaW+ntVjKmR8QVkqTmbtxlegVOWgX2wOLoSFzRHqfJyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=zeJL418W; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6e41e17645dso52768516d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 16:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1740442242; x=1741047042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2e25n5vpfxDFEGmdOG76BnXvJ2FJi0Uv+lwO0Tt+wqc=;
        b=zeJL418Wpl6jakxYO61WfUMKtRolKcWTQSrAAkWC4u0kQjYr2YVHgevXkR1YW9K5Ja
         5nSfzvsoyXr6qH2WsrxCgvSDR+WDzIrMDPkbJzpPBeVoimPa0MqHfz3ATs/tes2q6ETl
         JB5lss1UN9jhtA6h5wqc0uaeNaUhFIDJ39hAFQViFWXujvrkNeFYRs1Smfztqc/b9tDY
         khbIhP88TtkO7LnRgosIBlU89MesoI0TVTYcCc+AX07+E4TcI3YCRu4/kBYMMBBnDPPn
         TRV+uwFT7ECsk1FNBSrrV3iY2IvQhEvPfj178Cg+K/kW94ADIRu1mxraf0ubmLArqan/
         xJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740442242; x=1741047042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2e25n5vpfxDFEGmdOG76BnXvJ2FJi0Uv+lwO0Tt+wqc=;
        b=lHBbZHHEql+xj/7eOiKyiU5zn/S9cQk+7Po4eeB5W6RvNDMdLkOvv9JxLYCtoaCxMZ
         ke0J7oKyy1fn2p8raSbmVS/+XMXzShD4KiG6bclJiVNaUKBqIICpyxcdlbtU/V7UYjl9
         MP7gUHOsP5j/e+ebmN94tdAper+b7ZyXv3G6DWxzusIVs2di+ZgZYNkmJSkZ3Hy5q9kk
         jWWeJzZRkQsrIBWm7WSAl3OfIZ8rzssfmrpGzVO1Knj56lFwYw8dK5hydQCBhL+u58lw
         Xs00RoMRuRqr6amFt0sy+5Zuc4Aqi61Kiq4BL5aN4ZEkKwGYOMlMV5ry/u95DLS/jx3Q
         Td8g==
X-Forwarded-Encrypted: i=1; AJvYcCWBnNnIME/ddAKdZWVH8sijYVRL29iy+w4dcUQy1/FngO1NuafgvcEzldc0rxPaIqOtV8kTB9FsUkzab1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqGoufXbCfIfD8FoCSa/ExwwkRXMNpKUXqFn+pP3vfZ2d44EKi
	uXYMVEZ3rpTiOwULp1rkFluoO7ginmZwed+GfxjNos2NwkG6s4TY2VBfAE3BdU0=
X-Gm-Gg: ASbGncuKDeXHbqhwJHoJOGnQo8nyMlgZDvBZyzhFLkUxI42SvWsx4C0dzAdkrgRZ/JW
	oBJ0OSPE1nMr+zQk5t92uVVyqU4qaMVXxZqdy3hTwOljTtvhtRPyZNZfk/ScoICR9DqxdwAnTKI
	dIEfNDE8qzTkgo+maWzREuQcGxlJB+p3H31TF5p3O43ahkm+Qw1RhFbQEpCvlSb07cNurs/XkCa
	UhnMnlXGT4o74rMHmS8+eHOl0VYZUPdfZ1+q2kB3nQqnSwUKzSXWyEGCOJqWqHkeDfMGaT85bQb
	R6uoxtb6UYicZId2pmGJIAHX
X-Google-Smtp-Source: AGHT+IGgkiR9iptSEyFu7U9mGo/QIIVICqxDDnkseqj6QpgDVUGUnhk9KHuZIRF7lIakpsCc0f0yiA==
X-Received: by 2002:a05:6214:2463:b0:6e4:1e1d:10a7 with SMTP id 6a1803df08f44-6e6ae7c6211mr196896276d6.1.1740442241870;
        Mon, 24 Feb 2025 16:10:41 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e87b0871e2sm3224846d6.27.2025.02.24.16.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 16:10:36 -0800 (PST)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Brendan Jackman <jackmanb@google.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] mm: page_alloc: group fallback functions together
Date: Mon, 24 Feb 2025 19:08:26 -0500
Message-ID: <20250225001023.1494422-4-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250225001023.1494422-1-hannes@cmpxchg.org>
References: <20250225001023.1494422-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The way the fallback rules are spread out makes them hard to
follow. Move the functions next to each other at least.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 394 ++++++++++++++++++++++++------------------------
 1 file changed, 197 insertions(+), 197 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 53d315aa69c4..d02edb7d5e21 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1903,6 +1903,43 @@ static void change_pageblock_range(struct page *pageblock_page,
 	}
 }
 
+static inline bool boost_watermark(struct zone *zone)
+{
+	unsigned long max_boost;
+
+	if (!watermark_boost_factor)
+		return false;
+	/*
+	 * Don't bother in zones that are unlikely to produce results.
+	 * On small machines, including kdump capture kernels running
+	 * in a small area, boosting the watermark can cause an out of
+	 * memory situation immediately.
+	 */
+	if ((pageblock_nr_pages * 4) > zone_managed_pages(zone))
+		return false;
+
+	max_boost = mult_frac(zone->_watermark[WMARK_HIGH],
+			watermark_boost_factor, 10000);
+
+	/*
+	 * high watermark may be uninitialised if fragmentation occurs
+	 * very early in boot so do not boost. We do not fall
+	 * through and boost by pageblock_nr_pages as failing
+	 * allocations that early means that reclaim is not going
+	 * to help and it may even be impossible to reclaim the
+	 * boosted watermark resulting in a hang.
+	 */
+	if (!max_boost)
+		return false;
+
+	max_boost = max(pageblock_nr_pages, max_boost);
+
+	zone->watermark_boost = min(zone->watermark_boost + pageblock_nr_pages,
+		max_boost);
+
+	return true;
+}
+
 /*
  * When we are falling back to another migratetype during allocation, try to
  * steal extra free pages from the same pageblocks to satisfy further
@@ -1944,41 +1981,38 @@ static bool can_steal_fallback(unsigned int order, int start_mt)
 	return false;
 }
 
-static inline bool boost_watermark(struct zone *zone)
+/*
+ * Check whether there is a suitable fallback freepage with requested order.
+ * If only_stealable is true, this function returns fallback_mt only if
+ * we can steal other freepages all together. This would help to reduce
+ * fragmentation due to mixed migratetype pages in one pageblock.
+ */
+int find_suitable_fallback(struct free_area *area, unsigned int order,
+			int migratetype, bool only_stealable, bool *can_steal)
 {
-	unsigned long max_boost;
+	int i;
+	int fallback_mt;
 
-	if (!watermark_boost_factor)
-		return false;
-	/*
-	 * Don't bother in zones that are unlikely to produce results.
-	 * On small machines, including kdump capture kernels running
-	 * in a small area, boosting the watermark can cause an out of
-	 * memory situation immediately.
-	 */
-	if ((pageblock_nr_pages * 4) > zone_managed_pages(zone))
-		return false;
+	if (area->nr_free == 0)
+		return -1;
 
-	max_boost = mult_frac(zone->_watermark[WMARK_HIGH],
-			watermark_boost_factor, 10000);
+	*can_steal = false;
+	for (i = 0; i < MIGRATE_PCPTYPES - 1 ; i++) {
+		fallback_mt = fallbacks[migratetype][i];
+		if (free_area_empty(area, fallback_mt))
+			continue;
 
-	/*
-	 * high watermark may be uninitialised if fragmentation occurs
-	 * very early in boot so do not boost. We do not fall
-	 * through and boost by pageblock_nr_pages as failing
-	 * allocations that early means that reclaim is not going
-	 * to help and it may even be impossible to reclaim the
-	 * boosted watermark resulting in a hang.
-	 */
-	if (!max_boost)
-		return false;
+		if (can_steal_fallback(order, migratetype))
+			*can_steal = true;
 
-	max_boost = max(pageblock_nr_pages, max_boost);
+		if (!only_stealable)
+			return fallback_mt;
 
-	zone->watermark_boost = min(zone->watermark_boost + pageblock_nr_pages,
-		max_boost);
+		if (*can_steal)
+			return fallback_mt;
+	}
 
-	return true;
+	return -1;
 }
 
 /*
@@ -2054,175 +2088,6 @@ try_to_steal_block(struct zone *zone, struct page *page,
 	return NULL;
 }
 
-/*
- * Check whether there is a suitable fallback freepage with requested order.
- * If only_stealable is true, this function returns fallback_mt only if
- * we can steal other freepages all together. This would help to reduce
- * fragmentation due to mixed migratetype pages in one pageblock.
- */
-int find_suitable_fallback(struct free_area *area, unsigned int order,
-			int migratetype, bool only_stealable, bool *can_steal)
-{
-	int i;
-	int fallback_mt;
-
-	if (area->nr_free == 0)
-		return -1;
-
-	*can_steal = false;
-	for (i = 0; i < MIGRATE_PCPTYPES - 1 ; i++) {
-		fallback_mt = fallbacks[migratetype][i];
-		if (free_area_empty(area, fallback_mt))
-			continue;
-
-		if (can_steal_fallback(order, migratetype))
-			*can_steal = true;
-
-		if (!only_stealable)
-			return fallback_mt;
-
-		if (*can_steal)
-			return fallback_mt;
-	}
-
-	return -1;
-}
-
-/*
- * Reserve the pageblock(s) surrounding an allocation request for
- * exclusive use of high-order atomic allocations if there are no
- * empty page blocks that contain a page with a suitable order
- */
-static void reserve_highatomic_pageblock(struct page *page, int order,
-					 struct zone *zone)
-{
-	int mt;
-	unsigned long max_managed, flags;
-
-	/*
-	 * The number reserved as: minimum is 1 pageblock, maximum is
-	 * roughly 1% of a zone. But if 1% of a zone falls below a
-	 * pageblock size, then don't reserve any pageblocks.
-	 * Check is race-prone but harmless.
-	 */
-	if ((zone_managed_pages(zone) / 100) < pageblock_nr_pages)
-		return;
-	max_managed = ALIGN((zone_managed_pages(zone) / 100), pageblock_nr_pages);
-	if (zone->nr_reserved_highatomic >= max_managed)
-		return;
-
-	spin_lock_irqsave(&zone->lock, flags);
-
-	/* Recheck the nr_reserved_highatomic limit under the lock */
-	if (zone->nr_reserved_highatomic >= max_managed)
-		goto out_unlock;
-
-	/* Yoink! */
-	mt = get_pageblock_migratetype(page);
-	/* Only reserve normal pageblocks (i.e., they can merge with others) */
-	if (!migratetype_is_mergeable(mt))
-		goto out_unlock;
-
-	if (order < pageblock_order) {
-		if (move_freepages_block(zone, page, mt, MIGRATE_HIGHATOMIC) == -1)
-			goto out_unlock;
-		zone->nr_reserved_highatomic += pageblock_nr_pages;
-	} else {
-		change_pageblock_range(page, order, MIGRATE_HIGHATOMIC);
-		zone->nr_reserved_highatomic += 1 << order;
-	}
-
-out_unlock:
-	spin_unlock_irqrestore(&zone->lock, flags);
-}
-
-/*
- * Used when an allocation is about to fail under memory pressure. This
- * potentially hurts the reliability of high-order allocations when under
- * intense memory pressure but failed atomic allocations should be easier
- * to recover from than an OOM.
- *
- * If @force is true, try to unreserve pageblocks even though highatomic
- * pageblock is exhausted.
- */
-static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
-						bool force)
-{
-	struct zonelist *zonelist = ac->zonelist;
-	unsigned long flags;
-	struct zoneref *z;
-	struct zone *zone;
-	struct page *page;
-	int order;
-	int ret;
-
-	for_each_zone_zonelist_nodemask(zone, z, zonelist, ac->highest_zoneidx,
-								ac->nodemask) {
-		/*
-		 * Preserve at least one pageblock unless memory pressure
-		 * is really high.
-		 */
-		if (!force && zone->nr_reserved_highatomic <=
-					pageblock_nr_pages)
-			continue;
-
-		spin_lock_irqsave(&zone->lock, flags);
-		for (order = 0; order < NR_PAGE_ORDERS; order++) {
-			struct free_area *area = &(zone->free_area[order]);
-			unsigned long size;
-
-			page = get_page_from_free_area(area, MIGRATE_HIGHATOMIC);
-			if (!page)
-				continue;
-
-			/*
-			 * It should never happen but changes to
-			 * locking could inadvertently allow a per-cpu
-			 * drain to add pages to MIGRATE_HIGHATOMIC
-			 * while unreserving so be safe and watch for
-			 * underflows.
-			 */
-			size = max(pageblock_nr_pages, 1UL << order);
-			size = min(size, zone->nr_reserved_highatomic);
-			zone->nr_reserved_highatomic -= size;
-
-			/*
-			 * Convert to ac->migratetype and avoid the normal
-			 * pageblock stealing heuristics. Minimally, the caller
-			 * is doing the work and needs the pages. More
-			 * importantly, if the block was always converted to
-			 * MIGRATE_UNMOVABLE or another type then the number
-			 * of pageblocks that cannot be completely freed
-			 * may increase.
-			 */
-			if (order < pageblock_order)
-				ret = move_freepages_block(zone, page,
-							   MIGRATE_HIGHATOMIC,
-							   ac->migratetype);
-			else {
-				move_to_free_list(page, zone, order,
-						  MIGRATE_HIGHATOMIC,
-						  ac->migratetype);
-				change_pageblock_range(page, order,
-						       ac->migratetype);
-				ret = 1;
-			}
-			/*
-			 * Reserving the block(s) already succeeded,
-			 * so this should not fail on zone boundaries.
-			 */
-			WARN_ON_ONCE(ret == -1);
-			if (ret > 0) {
-				spin_unlock_irqrestore(&zone->lock, flags);
-				return ret;
-			}
-		}
-		spin_unlock_irqrestore(&zone->lock, flags);
-	}
-
-	return false;
-}
-
 /*
  * Try finding a free buddy page on the fallback list.
  *
@@ -3143,6 +3008,141 @@ struct page *rmqueue(struct zone *preferred_zone,
 	return page;
 }
 
+/*
+ * Reserve the pageblock(s) surrounding an allocation request for
+ * exclusive use of high-order atomic allocations if there are no
+ * empty page blocks that contain a page with a suitable order
+ */
+static void reserve_highatomic_pageblock(struct page *page, int order,
+					 struct zone *zone)
+{
+	int mt;
+	unsigned long max_managed, flags;
+
+	/*
+	 * The number reserved as: minimum is 1 pageblock, maximum is
+	 * roughly 1% of a zone. But if 1% of a zone falls below a
+	 * pageblock size, then don't reserve any pageblocks.
+	 * Check is race-prone but harmless.
+	 */
+	if ((zone_managed_pages(zone) / 100) < pageblock_nr_pages)
+		return;
+	max_managed = ALIGN((zone_managed_pages(zone) / 100), pageblock_nr_pages);
+	if (zone->nr_reserved_highatomic >= max_managed)
+		return;
+
+	spin_lock_irqsave(&zone->lock, flags);
+
+	/* Recheck the nr_reserved_highatomic limit under the lock */
+	if (zone->nr_reserved_highatomic >= max_managed)
+		goto out_unlock;
+
+	/* Yoink! */
+	mt = get_pageblock_migratetype(page);
+	/* Only reserve normal pageblocks (i.e., they can merge with others) */
+	if (!migratetype_is_mergeable(mt))
+		goto out_unlock;
+
+	if (order < pageblock_order) {
+		if (move_freepages_block(zone, page, mt, MIGRATE_HIGHATOMIC) == -1)
+			goto out_unlock;
+		zone->nr_reserved_highatomic += pageblock_nr_pages;
+	} else {
+		change_pageblock_range(page, order, MIGRATE_HIGHATOMIC);
+		zone->nr_reserved_highatomic += 1 << order;
+	}
+
+out_unlock:
+	spin_unlock_irqrestore(&zone->lock, flags);
+}
+
+/*
+ * Used when an allocation is about to fail under memory pressure. This
+ * potentially hurts the reliability of high-order allocations when under
+ * intense memory pressure but failed atomic allocations should be easier
+ * to recover from than an OOM.
+ *
+ * If @force is true, try to unreserve pageblocks even though highatomic
+ * pageblock is exhausted.
+ */
+static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
+						bool force)
+{
+	struct zonelist *zonelist = ac->zonelist;
+	unsigned long flags;
+	struct zoneref *z;
+	struct zone *zone;
+	struct page *page;
+	int order;
+	int ret;
+
+	for_each_zone_zonelist_nodemask(zone, z, zonelist, ac->highest_zoneidx,
+								ac->nodemask) {
+		/*
+		 * Preserve at least one pageblock unless memory pressure
+		 * is really high.
+		 */
+		if (!force && zone->nr_reserved_highatomic <=
+					pageblock_nr_pages)
+			continue;
+
+		spin_lock_irqsave(&zone->lock, flags);
+		for (order = 0; order < NR_PAGE_ORDERS; order++) {
+			struct free_area *area = &(zone->free_area[order]);
+			unsigned long size;
+
+			page = get_page_from_free_area(area, MIGRATE_HIGHATOMIC);
+			if (!page)
+				continue;
+
+			/*
+			 * It should never happen but changes to
+			 * locking could inadvertently allow a per-cpu
+			 * drain to add pages to MIGRATE_HIGHATOMIC
+			 * while unreserving so be safe and watch for
+			 * underflows.
+			 */
+			size = max(pageblock_nr_pages, 1UL << order);
+			size = min(size, zone->nr_reserved_highatomic);
+			zone->nr_reserved_highatomic -= size;
+
+			/*
+			 * Convert to ac->migratetype and avoid the normal
+			 * pageblock stealing heuristics. Minimally, the caller
+			 * is doing the work and needs the pages. More
+			 * importantly, if the block was always converted to
+			 * MIGRATE_UNMOVABLE or another type then the number
+			 * of pageblocks that cannot be completely freed
+			 * may increase.
+			 */
+			if (order < pageblock_order)
+				ret = move_freepages_block(zone, page,
+							   MIGRATE_HIGHATOMIC,
+							   ac->migratetype);
+			else {
+				move_to_free_list(page, zone, order,
+						  MIGRATE_HIGHATOMIC,
+						  ac->migratetype);
+				change_pageblock_range(page, order,
+						       ac->migratetype);
+				ret = 1;
+			}
+			/*
+			 * Reserving the block(s) already succeeded,
+			 * so this should not fail on zone boundaries.
+			 */
+			WARN_ON_ONCE(ret == -1);
+			if (ret > 0) {
+				spin_unlock_irqrestore(&zone->lock, flags);
+				return ret;
+			}
+		}
+		spin_unlock_irqrestore(&zone->lock, flags);
+	}
+
+	return false;
+}
+
 static inline long __zone_watermark_unusable_free(struct zone *z,
 				unsigned int order, unsigned int alloc_flags)
 {
-- 
2.48.1


