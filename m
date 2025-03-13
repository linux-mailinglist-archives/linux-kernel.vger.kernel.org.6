Return-Path: <linux-kernel+bounces-560371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DF7A60339
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 22:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8044719C357E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 21:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C741F5853;
	Thu, 13 Mar 2025 21:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="shxmU4oS"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B050F1F584F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 21:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741900033; cv=none; b=HxwZCkSffrgrS/LILeCw/sHqmzxPlYJ+oU5fBRu8/tYiJOigIJIDUPshVIBzE2CUnXaIR12A9YMrQ1gtlsrS2oojLStW5ngIkq7NRRja9MHF2KUUliKS+4J5GmoPcyUdeJsGASdH3NI6Noxvo1qxW4k2YxKOdnTMpJC/DvJhCC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741900033; c=relaxed/simple;
	bh=h9NgYKwsAoW1G9lRKhZDPMw2Rwi0/+g2kl3mRilnujQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/vasiPXiD5K5MWSaCuq4xJ2p+t7qGesiSu+DssANOIvBLoJykzFtsggJMOezLJWHElXhczKKZeUYrJDTWhinxr6QSNcYlFmZhWzW5Mz9dwFY9YeUsgSgMEwVlF23re6lW8OZQE4Li+ldw0Vtui2xv1Y+g+5wGFdmRUq7ZD7Hao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=shxmU4oS; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e8fd49b85eso21058966d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1741900030; x=1742504830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omkCeK6Z+5R8kI2i4e0zD4yPuPDofJe9UMJlISCGlWc=;
        b=shxmU4oSLlvGmnNyfB8Y/qf5Kq3hvrFHK68nIOuyTZi3GTngiw2sNEW46bceFc+Ydl
         LbH6xshGxwUS5HQDGiRen+zzqjv2z7Iu/0h8hrQAsvPX3D2xCHSPB87CAMZpyIjdcNyO
         nZa8Id34C9K2n8MUa++FuLKh3FgGfT7huhPdvmhkm470ojl6Q9fdbH+66swxsR6YS35w
         GYkvQ5XFuRRZSvIThzrh65azoWP28q4O6MnDL3/voRgousXtMKoe7f2jp44L0vKaEGI2
         d3lbTxqMCudu2U4N9kJuZATfQ37hzP5vj/HS2wy8wYmGAVwt6hZgD654MqxkE8NTTVQ1
         25Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741900030; x=1742504830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=omkCeK6Z+5R8kI2i4e0zD4yPuPDofJe9UMJlISCGlWc=;
        b=rUh4jCF7WwWi0QbK8ejV8j7s/Mn9RfJku31NKjHkRDmu8GGaITXgWhCsvbIMRh7DXk
         XtpmavSV0pOyxUJUfqJDDxI7lf2hptwTl2qJfEmkIfbv5pS6dfwJOPXnwheuNY/28Hr/
         6JKQuFlTMsXc7mJOG8WwymRWau5aVkSO34FnrP8Wpl/cLmly54g/6UoQo31he50vlHWo
         LMIARI7NTcs/Hy5qAiEmHmZs7RWwnuqwtGU7uyBCuTa58ne/5a2qs2Cq6CnoXZo1gVn9
         CIwnLCAPgUukdo5v0erVqqBFyKsXCUHvd2mm7D5gXASE8NXPG0nGdVD5u7F0nfE9Bb2G
         vexg==
X-Forwarded-Encrypted: i=1; AJvYcCUeI84V417z5okQEGiPYCEIM6nq7LhOEbzf3ucrEgsXwNBp6m5UfZ+TYJN04gyUwJp9Zgpz7pVQQSBq+ws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6ZOD2CFVuXPovmjfnd0NHylSrwDgpGJJFClyHp7Cj5InqW9AI
	5cqynZ1zdsYtROMHFBI+LIhn5Ih9bSw7vWKTZAtezVFPnwCJh6Uq00CasXEk4nc=
X-Gm-Gg: ASbGncuDK9e0NUNRdEaLpCZ85VXTalnwgZ5Aok/xryP2wXSATT5bcOvc50dpSqHEOU1
	eWTU7Duw7FNlXPzti3+zLEYdILlCx6Dlrx7pRtSn9UvLrtSqAhpKsIkTOKVo0/bfZ+rwfSKSz/q
	iZOsDx0fvNoOUzbb4xmiIofHqW8b2xfVZUwdp497ojcOYW3FJa8PrFPCPz5l4qssBN8iOeS19oX
	qziPBeT+Y6yJEevr17/K6pbFg2D8XzVlo/Z7qSb25btMmslecFapfTTghJlEpqTvC0/gNSkSKM9
	duUphmuOSs79ZmObtTnEMFCqQN4bXB99+ldWpB24YwIMtUh/Ew3tUA==
X-Google-Smtp-Source: AGHT+IE0pgmpJ7iYZdsbDD5GRPXRpzmD9Mb8iJmN9X7Z8Y97UKXrjLpuHa7ASqYiLMkPwrW1/Ylm4w==
X-Received: by 2002:a05:6214:212b:b0:6e8:f470:2b0d with SMTP id 6a1803df08f44-6eae7a3f38cmr22090436d6.19.1741900030398;
        Thu, 13 Mar 2025 14:07:10 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eade235f9bsm14078246d6.29.2025.03.13.14.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 14:07:08 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Mel Gorman <mgorman@techsingularity.net>,
	Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] mm: page_alloc: defrag_mode kswapd/kcompactd watermarks
Date: Thu, 13 Mar 2025 17:05:36 -0400
Message-ID: <20250313210647.1314586-6-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313210647.1314586-1-hannes@cmpxchg.org>
References: <20250313210647.1314586-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous patch added pageblock_order reclaim to kswapd/kcompactd,
which helps, but produces only one block at a time. Allocation stalls
and THP failure rates are still higher than they could be.

To adequately reflect ALLOC_NOFRAGMENT demand for pageblocks, change
the watermarking for kswapd & kcompactd: instead of targeting the high
watermark in order-0 pages and checking for one suitable block, simply
require that the high watermark is entirely met in pageblocks.

To this end, track the number of free pages within contiguous
pageblocks, then change pgdat_balanced() and compact_finished() to
check watermarks against this new value.

This further reduces THP latencies and allocation stalls, and improves
THP success rates against the previous patch:

                                       DEFRAGMODE-ASYNC DEFRAGMODE-ASYNC-WMARKS
Hugealloc Time mean               34300.36 (    +0.00%)   28904.00 (   -15.73%)
Hugealloc Time stddev             36390.42 (    +0.00%)   33464.37 (    -8.04%)
Kbuild Real time                    196.13 (    +0.00%)     196.59 (    +0.23%)
Kbuild User time                   1234.74 (    +0.00%)    1231.67 (    -0.25%)
Kbuild System time                   62.62 (    +0.00%)      59.10 (    -5.54%)
THP fault alloc                   57054.53 (    +0.00%)   63223.67 (   +10.81%)
THP fault fallback                11581.40 (    +0.00%)    5412.47 (   -53.26%)
Direct compact fail                 107.80 (    +0.00%)      59.07 (   -44.79%)
Direct compact success                4.53 (    +0.00%)       2.80 (   -31.33%)
Direct compact success rate %         3.20 (    +0.00%)       3.99 (   +18.66%)
Compact daemon scanned migrate  5461033.93 (    +0.00%) 2267500.33 (   -58.48%)
Compact daemon scanned free     5824897.93 (    +0.00%) 2339773.00 (   -59.83%)
Compact direct scanned migrate    58336.93 (    +0.00%)   47659.93 (   -18.30%)
Compact direct scanned free       32791.87 (    +0.00%)   40729.67 (   +24.21%)
Compact total migrate scanned   5519370.87 (    +0.00%) 2315160.27 (   -58.05%)
Compact total free scanned      5857689.80 (    +0.00%) 2380502.67 (   -59.36%)
Alloc stall                        2424.60 (    +0.00%)     638.87 (   -73.62%)
Pages kswapd scanned            2657018.33 (    +0.00%) 4002186.33 (   +50.63%)
Pages kswapd reclaimed           559583.07 (    +0.00%)  718577.80 (   +28.41%)
Pages direct scanned             722094.07 (    +0.00%)  355172.73 (   -50.81%)
Pages direct reclaimed           107257.80 (    +0.00%)   31162.80 (   -70.95%)
Pages total scanned             3379112.40 (    +0.00%) 4357359.07 (   +28.95%)
Pages total reclaimed            666840.87 (    +0.00%)  749740.60 (   +12.43%)
Swap out                          77238.20 (    +0.00%)  110084.33 (   +42.53%)
Swap in                           11712.80 (    +0.00%)   24457.00 (  +108.80%)
File refaults                    143438.80 (    +0.00%)  188226.93 (   +31.22%)

Also of note is that compaction work overall is reduced. The reason
for this is that when free pageblocks are more readily available,
allocations are also much more likely to get physically placed in LRU
order, instead of being forced to scavenge free space here and there.
This means that reclaim by itself has better chances of freeing up
whole blocks, and the system relies less on compaction.

Comparing all changes to the vanilla kernel:

                                                VANILLA DEFRAGMODE-ASYNC-WMARKS
Hugealloc Time mean               52739.45 (    +0.00%)   28904.00 (   -45.19%)
Hugealloc Time stddev             56541.26 (    +0.00%)   33464.37 (   -40.81%)
Kbuild Real time                    197.47 (    +0.00%)     196.59 (    -0.44%)
Kbuild User time                   1240.49 (    +0.00%)    1231.67 (    -0.71%)
Kbuild System time                   70.08 (    +0.00%)      59.10 (   -15.45%)
THP fault alloc                   46727.07 (    +0.00%)   63223.67 (   +35.30%)
THP fault fallback                21910.60 (    +0.00%)    5412.47 (   -75.29%)
Direct compact fail                 195.80 (    +0.00%)      59.07 (   -69.48%)
Direct compact success                7.93 (    +0.00%)       2.80 (   -57.46%)
Direct compact success rate %         3.51 (    +0.00%)       3.99 (   +10.49%)
Compact daemon scanned migrate  3369601.27 (    +0.00%) 2267500.33 (   -32.71%)
Compact daemon scanned free     5075474.47 (    +0.00%) 2339773.00 (   -53.90%)
Compact direct scanned migrate   161787.27 (    +0.00%)   47659.93 (   -70.54%)
Compact direct scanned free      163467.53 (    +0.00%)   40729.67 (   -75.08%)
Compact total migrate scanned   3531388.53 (    +0.00%) 2315160.27 (   -34.44%)
Compact total free scanned      5238942.00 (    +0.00%) 2380502.67 (   -54.56%)
Alloc stall                        2371.07 (    +0.00%)     638.87 (   -73.02%)
Pages kswapd scanned            2160926.73 (    +0.00%) 4002186.33 (   +85.21%)
Pages kswapd reclaimed           533191.07 (    +0.00%)  718577.80 (   +34.77%)
Pages direct scanned             400450.33 (    +0.00%)  355172.73 (   -11.31%)
Pages direct reclaimed            94441.73 (    +0.00%)   31162.80 (   -67.00%)
Pages total scanned             2561377.07 (    +0.00%) 4357359.07 (   +70.12%)
Pages total reclaimed            627632.80 (    +0.00%)  749740.60 (   +19.46%)
Swap out                          47959.53 (    +0.00%)  110084.33 (  +129.53%)
Swap in                            7276.00 (    +0.00%)   24457.00 (  +236.10%)
File refaults                    138043.00 (    +0.00%)  188226.93 (   +36.35%)

THP allocation latencies and %sys time are down dramatically.

THP allocation failures are down from nearly 50% to 8.5%. And to
recall previous data points, the success rates are steady and reliable
without the cumulative deterioration of fragmentation events.

Compaction work is down overall. Direct compaction work especially is
drastically reduced. As an aside, its success rate of 4% indicates
there is room for improvement. For now it's good to rely on it less.

Reclaim work is up overall, however direct reclaim work is down. Part
of the increase can be attributed to a higher use of THPs, which due
to internal fragmentation increase the memory footprint. This is not
necessarily an unexpected side-effect for users of THP.

However, taken both points together, there may well be some
opportunities for fine tuning in the reclaim/compaction coordination.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/mmzone.h |  1 +
 mm/compaction.c        | 37 ++++++++++++++++++++++++++++++-------
 mm/internal.h          |  1 +
 mm/page_alloc.c        | 29 +++++++++++++++++++++++------
 mm/vmscan.c            | 15 ++++++++++++++-
 mm/vmstat.c            |  1 +
 6 files changed, 70 insertions(+), 14 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index dbb0ad69e17f..37c29f3fbca8 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -138,6 +138,7 @@ enum numa_stat_item {
 enum zone_stat_item {
 	/* First 128 byte cacheline (assuming 64 bit words) */
 	NR_FREE_PAGES,
+	NR_FREE_PAGES_BLOCKS,
 	NR_ZONE_LRU_BASE, /* Used only for compaction and reclaim retry */
 	NR_ZONE_INACTIVE_ANON = NR_ZONE_LRU_BASE,
 	NR_ZONE_ACTIVE_ANON,
diff --git a/mm/compaction.c b/mm/compaction.c
index 036353ef1878..4a2ccb82d0b2 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2329,6 +2329,22 @@ static enum compact_result __compact_finished(struct compact_control *cc)
 	if (!pageblock_aligned(cc->migrate_pfn))
 		return COMPACT_CONTINUE;
 
+	/*
+	 * When defrag_mode is enabled, make kcompactd target
+	 * watermarks in whole pageblocks. Because they can be stolen
+	 * without polluting, no further fallback checks are needed.
+	 */
+	if (defrag_mode && !cc->direct_compaction) {
+		if (__zone_watermark_ok(cc->zone, cc->order,
+					high_wmark_pages(cc->zone),
+					cc->highest_zoneidx, cc->alloc_flags,
+					zone_page_state(cc->zone,
+							NR_FREE_PAGES_BLOCKS)))
+			return COMPACT_SUCCESS;
+
+		return COMPACT_CONTINUE;
+	}
+
 	/* Direct compactor: Is a suitable page free? */
 	ret = COMPACT_NO_SUITABLE_PAGE;
 	for (order = cc->order; order < NR_PAGE_ORDERS; order++) {
@@ -2496,13 +2512,19 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 static enum compact_result
 compaction_suit_allocation_order(struct zone *zone, unsigned int order,
 				 int highest_zoneidx, unsigned int alloc_flags,
-				 bool async)
+				 bool async, bool kcompactd)
 {
+	unsigned long free_pages;
 	unsigned long watermark;
 
+	if (kcompactd && defrag_mode)
+		free_pages = zone_page_state(zone, NR_FREE_PAGES_BLOCKS);
+	else
+		free_pages = zone_page_state(zone, NR_FREE_PAGES);
+
 	watermark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
-	if (zone_watermark_ok(zone, order, watermark, highest_zoneidx,
-			      alloc_flags))
+	if (__zone_watermark_ok(zone, order, watermark, highest_zoneidx,
+				alloc_flags, free_pages))
 		return COMPACT_SUCCESS;
 
 	/*
@@ -2558,7 +2580,8 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 		ret = compaction_suit_allocation_order(cc->zone, cc->order,
 						       cc->highest_zoneidx,
 						       cc->alloc_flags,
-						       cc->mode == MIGRATE_ASYNC);
+						       cc->mode == MIGRATE_ASYNC,
+						       !cc->direct_compaction);
 		if (ret != COMPACT_CONTINUE)
 			return ret;
 	}
@@ -3062,7 +3085,7 @@ static bool kcompactd_node_suitable(pg_data_t *pgdat)
 		ret = compaction_suit_allocation_order(zone,
 				pgdat->kcompactd_max_order,
 				highest_zoneidx, ALLOC_WMARK_MIN,
-				false);
+				false, true);
 		if (ret == COMPACT_CONTINUE)
 			return true;
 	}
@@ -3085,7 +3108,7 @@ static void kcompactd_do_work(pg_data_t *pgdat)
 		.mode = MIGRATE_SYNC_LIGHT,
 		.ignore_skip_hint = false,
 		.gfp_mask = GFP_KERNEL,
-		.alloc_flags = ALLOC_WMARK_MIN,
+		.alloc_flags = ALLOC_WMARK_HIGH,
 	};
 	enum compact_result ret;
 
@@ -3105,7 +3128,7 @@ static void kcompactd_do_work(pg_data_t *pgdat)
 
 		ret = compaction_suit_allocation_order(zone,
 				cc.order, zoneid, cc.alloc_flags,
-				false);
+				false, true);
 		if (ret != COMPACT_CONTINUE)
 			continue;
 
diff --git a/mm/internal.h b/mm/internal.h
index 2f52a65272c1..286520a424fe 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -536,6 +536,7 @@ extern char * const zone_names[MAX_NR_ZONES];
 DECLARE_STATIC_KEY_MAYBE(CONFIG_DEBUG_VM, check_pages_enabled);
 
 extern int min_free_kbytes;
+extern int defrag_mode;
 
 void setup_per_zone_wmarks(void);
 void calculate_min_free_kbytes(void);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4a0d8f871e56..c33c08e278f9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -273,7 +273,7 @@ int min_free_kbytes = 1024;
 int user_min_free_kbytes = -1;
 static int watermark_boost_factor __read_mostly = 15000;
 static int watermark_scale_factor = 10;
-static int defrag_mode;
+int defrag_mode;
 
 /* movable_zone is the "real" zone pages in ZONE_MOVABLE are taken from */
 int movable_zone;
@@ -660,16 +660,20 @@ static inline void __add_to_free_list(struct page *page, struct zone *zone,
 				      bool tail)
 {
 	struct free_area *area = &zone->free_area[order];
+	int nr_pages = 1 << order;
 
 	VM_WARN_ONCE(get_pageblock_migratetype(page) != migratetype,
 		     "page type is %lu, passed migratetype is %d (nr=%d)\n",
-		     get_pageblock_migratetype(page), migratetype, 1 << order);
+		     get_pageblock_migratetype(page), migratetype, nr_pages);
 
 	if (tail)
 		list_add_tail(&page->buddy_list, &area->free_list[migratetype]);
 	else
 		list_add(&page->buddy_list, &area->free_list[migratetype]);
 	area->nr_free++;
+
+	if (order >= pageblock_order && !is_migrate_isolate(migratetype))
+		__mod_zone_page_state(zone, NR_FREE_PAGES_BLOCKS, nr_pages);
 }
 
 /*
@@ -681,24 +685,34 @@ static inline void move_to_free_list(struct page *page, struct zone *zone,
 				     unsigned int order, int old_mt, int new_mt)
 {
 	struct free_area *area = &zone->free_area[order];
+	int nr_pages = 1 << order;
 
 	/* Free page moving can fail, so it happens before the type update */
 	VM_WARN_ONCE(get_pageblock_migratetype(page) != old_mt,
 		     "page type is %lu, passed migratetype is %d (nr=%d)\n",
-		     get_pageblock_migratetype(page), old_mt, 1 << order);
+		     get_pageblock_migratetype(page), old_mt, nr_pages);
 
 	list_move_tail(&page->buddy_list, &area->free_list[new_mt]);
 
-	account_freepages(zone, -(1 << order), old_mt);
-	account_freepages(zone, 1 << order, new_mt);
+	account_freepages(zone, -nr_pages, old_mt);
+	account_freepages(zone, nr_pages, new_mt);
+
+	if (order >= pageblock_order &&
+	    is_migrate_isolate(old_mt) != is_migrate_isolate(new_mt)) {
+		if (!is_migrate_isolate(old_mt))
+			nr_pages = -nr_pages;
+		__mod_zone_page_state(zone, NR_FREE_PAGES_BLOCKS, nr_pages);
+	}
 }
 
 static inline void __del_page_from_free_list(struct page *page, struct zone *zone,
 					     unsigned int order, int migratetype)
 {
+	int nr_pages = 1 << order;
+
         VM_WARN_ONCE(get_pageblock_migratetype(page) != migratetype,
 		     "page type is %lu, passed migratetype is %d (nr=%d)\n",
-		     get_pageblock_migratetype(page), migratetype, 1 << order);
+		     get_pageblock_migratetype(page), migratetype, nr_pages);
 
 	/* clear reported state and update reported page count */
 	if (page_reported(page))
@@ -708,6 +722,9 @@ static inline void __del_page_from_free_list(struct page *page, struct zone *zon
 	__ClearPageBuddy(page);
 	set_page_private(page, 0);
 	zone->free_area[order].nr_free--;
+
+	if (order >= pageblock_order && !is_migrate_isolate(migratetype))
+		__mod_zone_page_state(zone, NR_FREE_PAGES_BLOCKS, -nr_pages);
 }
 
 static inline void del_page_from_free_list(struct page *page, struct zone *zone,
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 3370bdca6868..b5c7dfc2b189 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6724,11 +6724,24 @@ static bool pgdat_balanced(pg_data_t *pgdat, int order, int highest_zoneidx)
 	 * meet watermarks.
 	 */
 	for_each_managed_zone_pgdat(zone, pgdat, i, highest_zoneidx) {
+		unsigned long free_pages;
+
 		if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING)
 			mark = promo_wmark_pages(zone);
 		else
 			mark = high_wmark_pages(zone);
-		if (zone_watermark_ok_safe(zone, order, mark, highest_zoneidx))
+
+		/*
+		 * In defrag_mode, watermarks must be met in whole
+		 * blocks to avoid polluting allocator fallbacks.
+		 */
+		if (defrag_mode)
+			free_pages = zone_page_state(zone, NR_FREE_PAGES_BLOCKS);
+		else
+			free_pages = zone_page_state(zone, NR_FREE_PAGES);
+
+		if (__zone_watermark_ok(zone, order, mark, highest_zoneidx,
+					0, free_pages))
 			return true;
 	}
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 16bfe1c694dd..ed49a86348f7 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1190,6 +1190,7 @@ int fragmentation_index(struct zone *zone, unsigned int order)
 const char * const vmstat_text[] = {
 	/* enum zone_stat_item counters */
 	"nr_free_pages",
+	"nr_free_pages_blocks",
 	"nr_zone_inactive_anon",
 	"nr_zone_active_anon",
 	"nr_zone_inactive_file",
-- 
2.48.1


