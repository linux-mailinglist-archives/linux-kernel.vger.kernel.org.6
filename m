Return-Path: <linux-kernel+bounces-186997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E5C8CCBAC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 07:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0CAE2822C1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 05:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E777CF39;
	Thu, 23 May 2024 05:14:27 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696242F875
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 05:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716441266; cv=none; b=I8LfNlNw9Nd1Oj8dcip4Nwjx/qnzHzlgn2dvUSi1vFX1rFjX0erOMsd5YigSJyRToH9QubYhADZe55o6U/Dc3/k8FiQrubRuYFf/3ueeYgX6o0eguifJSJ51JR4haogdohthrBR53vS0Es2g0N0sdEPaZzDw4JIp7LwcrhVsE0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716441266; c=relaxed/simple;
	bh=UNCirpK/PduTXAlzvqyfm99u491bRG8wt9SwqMkSF4s=;
	h=From:To:Cc:Subject:Date:Message-Id; b=EpvIPWUDnVk2Hl5YbaTFZc7sTqEG/3SUTIcr55tqmvZGvct6RypGiIRgg/+DQb73VxsrGw5Gaw/LwN/pFClIJqQiZV8M7ssECXoXlmlfjQECvtMY0+gc4Q6cgUdtqXSaB7loc/K4R4cevhOJNIDOgRQYvdGRN+wqAGfM2at1F78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-cf-664ed0a93f34
From: Byungchul Park <byungchul@sk.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel_team@skhynix.com
Subject: [PATCH] mm: let kswapd work again for node that used to be hopeless but may not now
Date: Thu, 23 May 2024 14:14:06 +0900
Message-Id: <20240523051406.81053-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOJMWRmVeSWpSXmKPExsXC9ZZnoe7KC35pBrv2sVvMWb+GzeLyrjls
	FvfW/Gd1YPbY9GkSu8eJGb9ZPD5vkgtgjuKySUnNySxLLdK3S+DKOHLDpOC8VsXtd8ENjJuV
	uhg5OSQETCTWnOln7GLkALO/7csGCbMJqEvcuPGTGcQWEZCVmPr3PAuIzSwQKLH80BqwuLBA
	jMTVr3/ZQWwWAVWJfyteMYLYvAKmEt1v1rNDjJeXWL3hAFA9F5C9ilVi+/cHbBAJSYmDK26w
	TGDkXsDIsIpRKDOvLDcxM8dEL6MyL7NCLzk/dxMj0LvLav9E72D8dCH4EKMAB6MSD2+HrF+a
	EGtiWXFl7iFGCQ5mJRHe6JW+aUK8KYmVValF+fFFpTmpxYcYpTlYlMR5jb6VpwgJpCeWpGan
	phakFsFkmTg4pRoYndOX+h3sSGtXS7m4uNI25eWK9Cea5ZUZOgbtKt58GYYRjfkagW1TjJUD
	6i7H83ha80u7Kk00WXRqZ+1Gq98OQZPs1z/4/PtOcuaqwN44jwcPZ22buVTFNPl2/d+omzGn
	Ek/snb53+9wL5bJZ8cnaE147WpRf+nfsfp6py4z4rJC3EfoyatZKLMUZiYZazEXFiQBfdEPn
	6gEAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHJMWRmVeSWpSXmKPExsXC5WfdrLvigl+awa6VVhZz1q9hszg89ySr
	xeVdc9gs7q35z+rA4rHp0yR2jxMzfrN4LH7xgcnj8ya5AJYoLpuU1JzMstQifbsErowjN0wK
	zmtV3H4X3MC4WamLkYNDQsBE4tu+7C5GTg42AXWJGzd+MoPYIgKyElP/nmcBsZkFAiWWH1oD
	FhcWiJG4+vUvO4jNIqAq8W/FK0YQm1fAVKL7zXqwuISAvMTqDQeYJzByLGBkWMUokplXlpuY
	mWOqV5ydUZmXWaGXnJ+7iRHoq2W1fybuYPxy2f0QowAHoxIPb8Iv3zQh1sSy4srcQ4wSHMxK
	IrzRK4FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeb3CUxOEBNITS1KzU1MLUotgskwcnFINjDEf
	+VOfy0/xZBGOFX3kyDln5sfWCYyeVtl8qoXnk6srd3zZHv766LOmRxnf0o40BE34yZrkES3K
	4jR3Hvshjd1x93wFdy+R3dmifNyfxfGcz/Kwu6nrLxYfm5ojcU+v4/mdyWHbjSI7i/UmybrG
	vPtx80Hmi6ui8RoBX3h++8Y8Xnvn0twFK5VYijMSDbWYi4oTAeJ4mHPRAQAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

I suffered from kswapd stopped in the following scenario:

   CONFIG_NUMA_BALANCING enabled
   sysctl_numa_balancing_mode set to NUMA_BALANCING_MEMORY_TIERING
   numa node0 (500GB local DRAM, 128 CPUs)
   numa node1 (100GB CXL memory, no CPUs)
   swap off

   1) Run any workload using a lot of anon pages e.g. mmap(200GB).
   2) Keep adding another workload using a lot of anon pages.
   3) The DRAM becomes filled with only anon pages through promotion.
   4) Demotion barely works due to severe memory pressure.
   5) kswapd for node0 stops because of the unreclaimable anon pages.
   6) Manually kill the memory hoggers.
   7) kswapd is still stopped even though the system got back to normal.

From now on, the system should run without reclaim service in background
served by kswapd until direct reclaim will do for that.  Even worse,
tiering mechanism is no longer able to work because kswapd has stopped
that the mechanism relies on.

However, after 6), the DRAM will be filled with pages that might or
might not be reclaimable, that depends on how those are going to be used.
Since those are potentially reclaimable anyway, it's worth hopefully
trying reclaim by allowing kswapd to work again if needed.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/mmzone.h |  4 ++++
 mm/page_alloc.c        | 12 ++++++++++++
 mm/vmscan.c            | 21 ++++++++++++++++-----
 3 files changed, 32 insertions(+), 5 deletions(-)

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
index 3ef654addd44..5b39090c4ef1 100644
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
 
@@ -6636,6 +6638,11 @@ static void clear_pgdat_congested(pg_data_t *pgdat)
 	clear_bit(PGDAT_WRITEBACK, &pgdat->flags);
 }
 
+static bool may_recaimable(pg_data_t *pgdat, int order)
+{
+	return pgdat->nr_may_reclaimable >= 1 << order;
+}
+
 /*
  * Prepare kswapd for sleeping. This verifies that there are no processes
  * waiting in throttle_direct_reclaim() and that watermarks have been met.
@@ -6662,7 +6669,8 @@ static bool prepare_kswapd_sleep(pg_data_t *pgdat, int order,
 		wake_up_all(&pgdat->pfmemalloc_wait);
 
 	/* Hopeless node, leave it to direct reclaim */
-	if (pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES)
+	if (pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES &&
+	    !may_recaimable(pgdat, order))
 		return true;
 
 	if (pgdat_balanced(pgdat, order, highest_zoneidx)) {
@@ -6940,8 +6948,10 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 		goto restart;
 	}
 
-	if (!sc.nr_reclaimed)
+	if (!sc.nr_reclaimed) {
 		pgdat->kswapd_failures++;
+		pgdat->nr_may_reclaimable = 0;
+	}
 
 out:
 	clear_reclaim_active(pgdat, highest_zoneidx);
@@ -7204,7 +7214,8 @@ void wakeup_kswapd(struct zone *zone, gfp_t gfp_flags, int order,
 		return;
 
 	/* Hopeless node, leave it to direct reclaim if possible */
-	if (pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES ||
+	if ((pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES &&
+	     !may_recaimable(pgdat, order)) ||
 	    (pgdat_balanced(pgdat, order, highest_zoneidx) &&
 	     !pgdat_watermark_boosted(pgdat, highest_zoneidx))) {
 		/*
-- 
2.17.1


