Return-Path: <linux-kernel+bounces-307903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 813A39654D2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 03:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A64CA1C2174D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 01:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7455D8F0;
	Fri, 30 Aug 2024 01:45:05 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB9A4D599
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 01:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724982304; cv=none; b=lsovoyvGLVse5ZeMTjBBRpAOnSptI32YAfchjd1gMc/EqfMhTKM+OlE+wIR9+vUfIAiHOikQEDwnej4Rm0YJLxy7L/968PN1Zjcza0FjX53yPi6wkVwoK2KldVZxe0e3ic7O+GfTJP+94CKgNdV5hkICpbZR1QS6Xwz66lLo3ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724982304; c=relaxed/simple;
	bh=9ndlDQ6oZ5Cy9sa3a+9XJE7xmcpJxHbApW152oHwJSk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mHCvnICwTXeeZYO6oDj515Fu/jz/EL7pmFihi8MsHhk1m8V52EEMuWILw8uTBcaPy5Xl6YePQml5UmNYuMV8ivnKIXw9kqeCBjBXLAp3w+Lgo5Dv3adNhbbLQHpxqGtKCpFPqhxiTNGwDrKaAp0SHycyJiEqYlAZ/whI7E/229Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Ww16t5rTNzQqks;
	Fri, 30 Aug 2024 09:40:06 +0800 (CST)
Received: from kwepemg100017.china.huawei.com (unknown [7.202.181.58])
	by mail.maildlp.com (Postfix) with ESMTPS id 634891800A0;
	Fri, 30 Aug 2024 09:44:58 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemg100017.china.huawei.com (7.202.181.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 30 Aug 2024 09:44:57 +0800
From: Wupeng Ma <mawupeng1@huawei.com>
To: <akpm@linux-foundation.org>, <mgorman@techsingularity.net>,
	<ying.huang@intel.com>, <mhocko@suse.com>, <dmaluka@chromium.org>
CC: <liushixin2@huawei.com>, <wangkefeng.wang@huawei.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, Ma Wupeng
	<mawupeng1@huawei.com>
Subject: [PATCH] mm, proc: collect percpu free pages into the free pages
Date: Fri, 30 Aug 2024 09:44:53 +0800
Message-ID: <20240830014453.3070909-1-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg100017.china.huawei.com (7.202.181.58)

From: Ma Wupeng <mawupeng1@huawei.com>

The introduction of Per-CPU-Pageset (PCP) per zone aims to enhance the
performance of the page allocator by enabling page allocation without
requiring the zone lock. This kind of memory is free memory however is
not included in Memfree or MemAvailable.

With the support of higt-order pcp and pcp auto-tuning, the size of the
pages in this list has become a matter of concern due to the following
patches:

  1. Introduction of Order 1~3 and PMD level PCP in commit 44042b449872
  ("mm/page_alloc: allow high-order pages to be stored on the per-cpu
  lists").
  2. Introduction of PCP auto-tuning in commit 90b41691b988 ("mm: add
  framework for PCP high auto-tuning").

Which lead to the total amount of the pcp can not be ignored just after
booting without any real tasks for as the result show below:

		   w/o patch	  with patch	      diff	diff/total
MemTotal:	525424652 kB	525424652 kB	      0 kB	        0%
MemFree:	517030396 kB	520134136 kB	3103740 kB	      0.6%
MemAvailable:	515837152 kB	518941080 kB	3103928 kB	      0.6%

On a machine with 16 zones and 600+ CPUs, prior to these commits, the PCP
list contained 274368 pages (1097M) immediately after booting. In the
mainline, this number has increased to 3003M, marking a 173% increase.

Since available memory is used by numerous services to determine memory
pressure. A substantial PCP memory volume leads to an inaccurate estimation
of available memory size, significantly impacting the service logic.

Remove the useless CONFIG_HIGMEM in si_meminfo_node since it will always
false in is_highmem_idx if config is not enabled.

Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 mm/show_mem.c | 46 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/mm/show_mem.c b/mm/show_mem.c
index bdb439551eef..08f566c30b3d 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -29,6 +29,26 @@ static inline void show_node(struct zone *zone)
 		printk("Node %d ", zone_to_nid(zone));
 }
 
+static unsigned long nr_free_zone_pcplist_pages(struct zone *zone)
+{
+	unsigned long sum = 0;
+	int cpu;
+
+	for_each_online_cpu(cpu)
+		sum += per_cpu_ptr(zone->per_cpu_pageset, cpu)->count;
+	return sum;
+}
+
+static unsigned long nr_free_pcplist_pages(void)
+{
+	unsigned long sum = 0;
+	struct zone *zone;
+
+	for_each_populated_zone(zone)
+		sum += nr_free_zone_pcplist_pages(zone);
+	return sum;
+}
+
 long si_mem_available(void)
 {
 	long available;
@@ -44,7 +64,8 @@ long si_mem_available(void)
 	 * Estimate the amount of memory available for userspace allocations,
 	 * without causing swapping or OOM.
 	 */
-	available = global_zone_page_state(NR_FREE_PAGES) - totalreserve_pages;
+	available = global_zone_page_state(NR_FREE_PAGES) +
+		    nr_free_pcplist_pages() - totalreserve_pages;
 
 	/*
 	 * Not all the page cache can be freed, otherwise the system will
@@ -76,7 +97,8 @@ void si_meminfo(struct sysinfo *val)
 {
 	val->totalram = totalram_pages();
 	val->sharedram = global_node_page_state(NR_SHMEM);
-	val->freeram = global_zone_page_state(NR_FREE_PAGES);
+	val->freeram =
+		global_zone_page_state(NR_FREE_PAGES) + nr_free_pcplist_pages();
 	val->bufferram = nr_blockdev_pages();
 	val->totalhigh = totalhigh_pages();
 	val->freehigh = nr_free_highpages();
@@ -90,30 +112,27 @@ void si_meminfo_node(struct sysinfo *val, int nid)
 {
 	int zone_type;		/* needs to be signed */
 	unsigned long managed_pages = 0;
+	unsigned long free_pages = sum_zone_node_page_state(nid, NR_FREE_PAGES);
 	unsigned long managed_highpages = 0;
 	unsigned long free_highpages = 0;
 	pg_data_t *pgdat = NODE_DATA(nid);
 
-	for (zone_type = 0; zone_type < MAX_NR_ZONES; zone_type++)
-		managed_pages += zone_managed_pages(&pgdat->node_zones[zone_type]);
-	val->totalram = managed_pages;
-	val->sharedram = node_page_state(pgdat, NR_SHMEM);
-	val->freeram = sum_zone_node_page_state(nid, NR_FREE_PAGES);
-#ifdef CONFIG_HIGHMEM
 	for (zone_type = 0; zone_type < MAX_NR_ZONES; zone_type++) {
 		struct zone *zone = &pgdat->node_zones[zone_type];
 
+		managed_pages += zone_managed_pages(zone);
+		free_pages += nr_free_zone_pcplist_pages(zone);
 		if (is_highmem(zone)) {
 			managed_highpages += zone_managed_pages(zone);
 			free_highpages += zone_page_state(zone, NR_FREE_PAGES);
 		}
 	}
+
+	val->totalram = managed_pages;
+	val->sharedram = node_page_state(pgdat, NR_SHMEM);
+	val->freeram = free_pages;
 	val->totalhigh = managed_highpages;
 	val->freehigh = free_highpages;
-#else
-	val->totalhigh = managed_highpages;
-	val->freehigh = free_highpages;
-#endif
 	val->mem_unit = PAGE_SIZE;
 }
 #endif
@@ -196,8 +215,7 @@ static void show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_z
 		if (show_mem_node_skip(filter, zone_to_nid(zone), nodemask))
 			continue;
 
-		for_each_online_cpu(cpu)
-			free_pcp += per_cpu_ptr(zone->per_cpu_pageset, cpu)->count;
+		free_pcp += nr_free_zone_pcplist_pages(zone);
 	}
 
 	printk("active_anon:%lu inactive_anon:%lu isolated_anon:%lu\n"
-- 
2.25.1


