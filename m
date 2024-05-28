Return-Path: <linux-kernel+bounces-193022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F118D25B6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1B41F24E47
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 20:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A0817B418;
	Tue, 28 May 2024 20:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ijO+FHfZ"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8840713541F
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 20:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716927700; cv=none; b=quZ9W1nmwXsayxH3rsemAenDE2iyAuRpjBTRLmi74ICcGpWtAVB6LGhjNvFQksTfIKeXuwHSSrjseYtH9gLw0FNlJpXJZMGI1nmFRs7H3oCyiVOkLFo7MLlZpn/ZX5G+JvSz5zTvxYjMekHFzhDI6KrQUnEVUV0ioaULfEB9Y7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716927700; c=relaxed/simple;
	bh=iSWBdokr0DnM9jRzYFkbToiWHV7BglVdtz8OJYFO/AE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bb13KEaC8/xaF178LB3AYZr14CviwiFLo+DkSg6XfMUVUMwdqxTFB6zbWllZ9X8IPjSEvlR8irDK/KRXsWhtZpkFTUxnhbq90JID1GIQY/zAqsum07z0M8PyCuMIRcSdTQ4nQNDA6L0HoGJc3dyUxmc0HCYmvqRZt21muAm7vGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ijO+FHfZ; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716927696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y/IyRDssHrMHkNOV40XaGNGgjC7h+E/txgZ4e1RmFhI=;
	b=ijO+FHfZzox6CnufXeEk7CPNoA3O1/MQLRzOj+KdMN4dJyyPjH9cMVVMna/IaQ5LOeHr4S
	FOlE9zJiodlgVj+FbbHzxKpLryUFAN2kQiR+MeQEKCAPIqA4cYLjZAwfVHcAfeqsGNoM0k
	m3nCL38Tpi4loQmhNfcMUkph7RmTW74=
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: shakeel.butt@linux.dev
X-Envelope-To: willy@infradead.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: roman.gushchin@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Muchun Song <muchun.song@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Matthew Wilcox <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v1 03/14] mm: memcg: rename soft limit reclaim-related functions
Date: Tue, 28 May 2024 13:20:55 -0700
Message-ID: <20240528202101.3099300-4-roman.gushchin@linux.dev>
In-Reply-To: <20240528202101.3099300-1-roman.gushchin@linux.dev>
References: <20240528202101.3099300-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Rename exported function related to the softlimit reclaim
to have memcg1_ prefix.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/memcontrol.h | 12 ++++++------
 mm/memcontrol-v1.c         |  6 +++---
 mm/memcontrol-v1.h         |  4 ++--
 mm/memcontrol.c            |  4 ++--
 mm/vmscan.c                | 10 +++++-----
 5 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 3d1599146afe4..04f9f7b0e7c2f 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1115,9 +1115,9 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
 
 void split_page_memcg(struct page *head, int old_order, int new_order);
 
-unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
-						gfp_t gfp_mask,
-						unsigned long *total_scanned);
+unsigned long memcg1_soft_limit_reclaim(pg_data_t *pgdat, int order,
+					gfp_t gfp_mask,
+					unsigned long *total_scanned);
 
 #else /* CONFIG_MEMCG */
 
@@ -1566,9 +1566,9 @@ static inline void split_page_memcg(struct page *head, int old_order, int new_or
 }
 
 static inline
-unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
-					    gfp_t gfp_mask,
-					    unsigned long *total_scanned)
+unsigned long memcg1_soft_limit_reclaim(pg_data_t *pgdat, int order,
+					gfp_t gfp_mask,
+					unsigned long *total_scanned)
 {
 	return 0;
 }
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 2ccb8406fa84e..68e2f1a718d36 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -100,7 +100,7 @@ static unsigned long soft_limit_excess(struct mem_cgroup *memcg)
 	return excess;
 }
 
-void mem_cgroup_update_tree(struct mem_cgroup *memcg, int nid)
+void memcg1_update_tree(struct mem_cgroup *memcg, int nid)
 {
 	unsigned long excess;
 	struct mem_cgroup_per_node *mz;
@@ -143,7 +143,7 @@ void mem_cgroup_update_tree(struct mem_cgroup *memcg, int nid)
 	}
 }
 
-void mem_cgroup_remove_from_trees(struct mem_cgroup *memcg)
+void memcg1_remove_from_trees(struct mem_cgroup *memcg)
 {
 	struct mem_cgroup_tree_per_node *mctz;
 	struct mem_cgroup_per_node *mz;
@@ -243,7 +243,7 @@ static int mem_cgroup_soft_reclaim(struct mem_cgroup *root_memcg,
 	return total;
 }
 
-unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
+unsigned long memcg1_soft_limit_reclaim(pg_data_t *pgdat, int order,
 					    gfp_t gfp_mask,
 					    unsigned long *total_scanned)
 {
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 4da6fa561c6d4..e37bc7e8d9558 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -3,8 +3,8 @@
 #ifndef __MM_MEMCONTROL_V1_H
 #define __MM_MEMCONTROL_V1_H
 
-void mem_cgroup_update_tree(struct mem_cgroup *memcg, int nid);
-void mem_cgroup_remove_from_trees(struct mem_cgroup *memcg);
+void memcg1_update_tree(struct mem_cgroup *memcg, int nid);
+void memcg1_remove_from_trees(struct mem_cgroup *memcg);
 
 static inline void memcg1_soft_limit_reset(struct mem_cgroup *memcg)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index fa1df6e894787..0fbc4e518222e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1012,7 +1012,7 @@ static void memcg_check_events(struct mem_cgroup *memcg, int nid)
 						MEM_CGROUP_TARGET_SOFTLIMIT);
 		mem_cgroup_threshold(memcg);
 		if (unlikely(do_softlimit))
-			mem_cgroup_update_tree(memcg, nid);
+			memcg1_update_tree(memcg, nid);
 	}
 }
 
@@ -5612,7 +5612,7 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
 
 	vmpressure_cleanup(&memcg->vmpressure);
 	cancel_work_sync(&memcg->high_work);
-	mem_cgroup_remove_from_trees(memcg);
+	memcg1_remove_from_trees(memcg);
 	free_shrinker_info(memcg);
 	mem_cgroup_free(memcg);
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b9170f767353d..3833b11c96f9b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6187,9 +6187,9 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
 			 * and balancing, not for a memcg's limit.
 			 */
 			nr_soft_scanned = 0;
-			nr_soft_reclaimed = mem_cgroup_soft_limit_reclaim(zone->zone_pgdat,
-						sc->order, sc->gfp_mask,
-						&nr_soft_scanned);
+			nr_soft_reclaimed = memcg1_soft_limit_reclaim(zone->zone_pgdat,
+								      sc->order, sc->gfp_mask,
+								      &nr_soft_scanned);
 			sc->nr_reclaimed += nr_soft_reclaimed;
 			sc->nr_scanned += nr_soft_scanned;
 			/* need some check for avoid more shrink_zone() */
@@ -6952,8 +6952,8 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 		/* Call soft limit reclaim before calling shrink_node. */
 		sc.nr_scanned = 0;
 		nr_soft_scanned = 0;
-		nr_soft_reclaimed = mem_cgroup_soft_limit_reclaim(pgdat, sc.order,
-						sc.gfp_mask, &nr_soft_scanned);
+		nr_soft_reclaimed = memcg1_soft_limit_reclaim(pgdat, sc.order,
+							      sc.gfp_mask, &nr_soft_scanned);
 		sc.nr_reclaimed += nr_soft_reclaimed;
 
 		/*
-- 
2.45.1


