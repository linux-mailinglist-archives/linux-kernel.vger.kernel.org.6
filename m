Return-Path: <linux-kernel+bounces-200147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3D48FABCC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB810285DA1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 07:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5332140397;
	Tue,  4 Jun 2024 07:23:44 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843D112C466
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 07:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717485824; cv=none; b=bYJsTtVzWeAA63/1b3lI26pLUb0KuwsGDDYdONZWIMP4TONzY0PyzUs5qMMcIxqcbTna+XOgrvyf9dgthgZ4jcaxKdQU2LotKT3+IvAru4vpK5v+z0zIxL8S/9xY+HjCGT0SzWNnWld+zPlqt1le6u3kKUm72QeGz7lnopYO2+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717485824; c=relaxed/simple;
	bh=5fg8vE5d2ihZd6njkwTGwkgjRTSrYmoR91+fBVonnBA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=gx8RTlsOrV/PWv0pJoHzLv99B+k39J1/2kt3/SmWp8CElzy1v3df6VwvtJwCHidv1ke/SVaaaN+zs5zhZzv1u21OSB7InWpX/kkCW9ahgqrWqMNPjaNzhYDdLwn69QdVdgFDs+iDKdLfeWKxst+z4PT+UTnBPWOZspHkGtjU5Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-c7-665ec0f6918b
From: Byungchul Park <byungchul@sk.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	hannes@cmpxchg.org,
	iamjoonsoo.kim@lge.com,
	rientjes@google.com,
	ying.huang@intel.com
Subject: [PATCH v2] mm: let kswapd work again for node that used to be hopeless but may not now
Date: Tue,  4 Jun 2024 16:23:23 +0900
Message-Id: <20240604072323.10886-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgluLIzCtJLcpLzFFi42LhesuzSPfbgbg0g4U7pSzmrF/DZrF6k6/F
	yu5mNovLu+awWdxb85/Vom3JRiaLk7Mmsziwexx+857ZY8GmUo/Fe14yeWz6NIndo+vtFSaP
	EzN+s3h83iQXwB7FZZOSmpNZllqkb5fAlTH303a2gt1mFV3zshoYH2t3MXJySAiYSMyZ+oQZ
	xt539CMLiM0moC5x48ZPsLiIgKzE1L/ngeJcHMwCGxglNpz9wQqSEBaIl9hwbykjiM0ioCqx
	8eIDsGZeAVOJU9N3sEAMlZdYveEAM0izhMBLVonpZ64yQiQkJQ6uuMEygZF7ASPDKkahzLyy
	3MTMHBO9jMq8zAq95PzcTYzAcFlW+yd6B+OnC8GHGAU4GJV4eA0WxaYJsSaWFVfmHmKU4GBW
	EuHtq4tOE+JNSaysSi3Kjy8qzUktPsQozcGiJM5r9K08RUggPbEkNTs1tSC1CCbLxMEp1cBo
	op3dWa5dfk1s7+OYD4e33t+vWTa3ITxU2vaxrp7xEWmfIvWAj2+sJ623v56WUrz5zdLlS3Zv
	XDt17Zy+V8kCG/tyIsoD3olsVL8w4WTNosWBJ73blJwdVKcc/VlyP4WDc+p+oy+OJ/nj4h7c
	FJGZ7ppdzmfiYHAzdVroIYZFbCed1nHO0n+mxFKckWioxVxUnAgAWqpnDhMCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOJMWRmVeSWpSXmKPExsXC5WfdrPvtQFyawePjHBZz1q9hs1i9yddi
	ZXczm8XhuSdZLS7vmsNmcW/Nf1aLtiUbmSxOzprM4sDhcfjNe2aPBZtKPRbvecnksenTJHaP
	rrdXmDxOzPjN4rH4xQcmj8+b5AI4orhsUlJzMstSi/TtErgy5n7azlaw26yia15WA+Nj7S5G
	Tg4JAROJfUc/soDYbALqEjdu/GQGsUUEZCWm/j0PFOfiYBbYwCix4ewPVpCEsEC8xIZ7SxlB
	bBYBVYmNFx+ANfMKmEqcmr6DBWKovMTqDQeYJzByLGBkWMUokplXlpuYmWOqV5ydUZmXWaGX
	nJ+7iRHo/WW1fybuYPxy2f0QowAHoxIPr8XK2DQh1sSy4srcQ4wSHMxKIrx9ddFpQrwpiZVV
	qUX58UWlOanFhxilOViUxHm9wlMThATSE0tSs1NTC1KLYLJMHJxSDYx15dFNv125rAOWz381
	m98lvNRg7sxPenw3vvofTC5xmVm6N+uPsd/dFZuTnivWrgs7qjP7hl1Oe+m5dHnLtb1a/Sd+
	br231rz2VMe8XJVZyZbfXF+H3xaJ/1nDXPTp8v/DmvNKq/bqT4ux2/RyTYb0ku/qgZFTtnFa
	VlYIHjC9JSDh4Bm9w0OJpTgj0VCLuag4EQBHvAI2+gEAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Changes from v1:
	1. Don't allow to resume kswapd if the system is under memory
	   pressure that might affect direct reclaim by any chance, like
	   if NR_FREE_PAGES is less than (low wmark + min wmark)/2.

--->8---
From 6c73fc16b75907f5da9e6b33aff86bf7d7c9dd64 Mon Sep 17 00:00:00 2001
From: Byungchul Park <byungchul@sk.com>
Date: Tue, 4 Jun 2024 15:27:56 +0900
Subject: [PATCH v2] mm: let kswapd work again for node that used to be hopeless but may not now

A system should run with kswapd running in background when under memory
pressure, such as when the available memory level is below the low water
mark and there are reclaimable folios.

However, the current code let the system run with kswapd stopped if
kswapd has been stopped due to more than MAX_RECLAIM_RETRIES failures
until direct reclaim will do for that, even if there are reclaimable
folios that can be reclaimed by kswapd.  This case was observed in the
following scenario:

   CONFIG_NUMA_BALANCING enabled
   sysctl_numa_balancing_mode set to NUMA_BALANCING_MEMORY_TIERING
   numa node0 (500GB local DRAM, 128 CPUs)
   numa node1 (100GB CXL memory, no CPUs)
   swap off

   1) Run a workload with big anon pages e.g. mmap(200GB).
   2) Continue adding the same workload to the system.
   3) The anon pages are placed in node0 by promotion/demotion.
   4) kswapd0 stops because of the unreclaimable anon pages in node0.
   5) Kill the memory hoggers to restore the system.

After restoring the system at 5), the system starts to run without
kswapd.  Even worse, tiering mechanism is no longer able to work since
the mechanism relies on kswapd for demotion.

However, the node0 has pages newly allocated after 5), that might or
might not be reclaimable.  Since those are potentially reclaimable, it's
worth hopefully trying reclaim by allowing kswapd to work again.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/mmzone.h |  4 ++++
 mm/page_alloc.c        | 12 ++++++++++
 mm/vmscan.c            | 52 ++++++++++++++++++++++++++++++++++++++----
 3 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index c11b7cde81ef..7c0ba90ea7b4 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1331,6 +1331,10 @@ typedef struct pglist_data {
 	enum zone_type kswapd_highest_zoneidx;
 
 	int kswapd_failures;		/* Number of 'reclaimed == 0' runs */
+	int nr_may_reclaimable;		/* Number of pages that have been
+					   allocated since considered the
+					   node is hopeless due to too many
+					   kswapd_failures. */
 
 #ifdef CONFIG_COMPACTION
 	int kcompactd_max_order;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 14d39f34d336..1dd2daede014 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1538,8 +1538,20 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags,
 							unsigned int alloc_flags)
 {
+	pg_data_t *pgdat = page_pgdat(page);
+
 	post_alloc_hook(page, order, gfp_flags);
 
+	/*
+	 * New pages might or might not be reclaimable depending on how
+	 * these pages are going to be used.  However, since these are
+	 * potentially reclaimable, it's worth hopefully trying reclaim
+	 * by allowing kswapd to work again even if there have been too
+	 * many ->kswapd_failures, if ->nr_may_reclaimable is big enough.
+	 */
+	if (pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES)
+		pgdat->nr_may_reclaimable += 1 << order;
+
 	if (order && (gfp_flags & __GFP_COMP))
 		prep_compound_page(page, order);
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 3ef654addd44..6cf7ff164c2a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4943,6 +4943,7 @@ static void lru_gen_shrink_node(struct pglist_data *pgdat, struct scan_control *
 done:
 	/* kswapd should never fail */
 	pgdat->kswapd_failures = 0;
+	pgdat->nr_may_reclaimable = 0;
 }
 
 /******************************************************************************
@@ -5991,9 +5992,10 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	 * sleep. On reclaim progress, reset the failure counter. A
 	 * successful direct reclaim run will revive a dormant kswapd.
 	 */
-	if (reclaimable)
+	if (reclaimable) {
 		pgdat->kswapd_failures = 0;
-	else if (sc->cache_trim_mode)
+		pgdat->nr_may_reclaimable = 0;
+	} else if (sc->cache_trim_mode)
 		sc->cache_trim_mode_failed = 1;
 }
 
@@ -6636,6 +6638,42 @@ static void clear_pgdat_congested(pg_data_t *pgdat)
 	clear_bit(PGDAT_WRITEBACK, &pgdat->flags);
 }
 
+static bool may_reclaimable(pg_data_t *pgdat, int order,
+		int highest_zoneidx)
+{
+	int i;
+	bool may_reclaimable;
+
+	may_reclaimable = pgdat->nr_may_reclaimable >= 1 << order;
+	if (!may_reclaimable)
+		return false;
+
+	/*
+	 * Check watermarks bottom-up as lower zones are more likely to
+	 * meet watermarks.
+	 */
+	for (i = 0; i <= highest_zoneidx; i++) {
+		unsigned long mark;
+		struct zone *zone;
+
+		zone = pgdat->node_zones + i;
+		if (!managed_zone(zone))
+			continue;
+
+		/*
+		 * Don't bother the system by resuming kswapd if the
+		 * system is under memory pressure that might affect
+		 * direct reclaim by any chance.  Conservatively allow it
+		 * unless NR_FREE_PAGES is less than (low + min)/2.
+		 */
+		mark = (low_wmark_pages(zone) + min_wmark_pages(zone)) >> 1;
+		if (zone_watermark_ok_safe(zone, order, mark, highest_zoneidx))
+			return true;
+	}
+
+	return false;
+}
+
 /*
  * Prepare kswapd for sleeping. This verifies that there are no processes
  * waiting in throttle_direct_reclaim() and that watermarks have been met.
@@ -6662,7 +6700,8 @@ static bool prepare_kswapd_sleep(pg_data_t *pgdat, int order,
 		wake_up_all(&pgdat->pfmemalloc_wait);
 
 	/* Hopeless node, leave it to direct reclaim */
-	if (pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES)
+	if (pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES &&
+	    !may_reclaimable(pgdat, order, highest_zoneidx))
 		return true;
 
 	if (pgdat_balanced(pgdat, order, highest_zoneidx)) {
@@ -6940,8 +6979,10 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 		goto restart;
 	}
 
-	if (!sc.nr_reclaimed)
+	if (!sc.nr_reclaimed) {
 		pgdat->kswapd_failures++;
+		pgdat->nr_may_reclaimable = 0;
+	}
 
 out:
 	clear_reclaim_active(pgdat, highest_zoneidx);
@@ -7204,7 +7245,8 @@ void wakeup_kswapd(struct zone *zone, gfp_t gfp_flags, int order,
 		return;
 
 	/* Hopeless node, leave it to direct reclaim if possible */
-	if (pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES ||
+	if ((pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES &&
+	     !may_reclaimable(pgdat, order, highest_zoneidx)) ||
 	    (pgdat_balanced(pgdat, order, highest_zoneidx) &&
 	     !pgdat_watermark_boosted(pgdat, highest_zoneidx))) {
 		/*
-- 
2.17.1


