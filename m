Return-Path: <linux-kernel+bounces-240361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB344926CBE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 02:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 241C4B21C50
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 00:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB7A4A31;
	Thu,  4 Jul 2024 00:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k3+S1qz/"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9812D632
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 00:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720052847; cv=none; b=Dj0KUTzzqQb/n5323LzUfkyIhAFVD61CPeSaFl80aXDG+T8Trg3/Z69NTP/BGdYUahNn6c7a4eaWMy8VEKH+UuJ7srQBwiVOzKK/XEZKo60IVTfpQs1JWXmc2C30rbHX51OTPmzqSuQWbLUAQ17Zhw2GIjjDajFpfkWLvyrFWfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720052847; c=relaxed/simple;
	bh=eDk86HvwIY5jK/ZmCOCfXK9DrProMXfGKUwB+C611rY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oYirg1Birnh13cAKSbq3iGkZ0etWoFJaPSKdjqeuoTfJPKqc5E/How9gbk7UidWEqth4hI3zbXL1zqHE51d4apXy922HCz0sjcWjqSEF1qU0DoocZgCBzQnYTUh4NmtGP6AK/KwsaTO6QLxhdJLVZBZVHUJzMnAz+qJxaSYN6+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k3+S1qz/; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720052841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=18SXq9zdacMnKFolMWLOVh2I+0mEmI4Fh14/DgUnfRo=;
	b=k3+S1qz/sE1uhjVXG/0uXEKKTowa54j/Khu/XHDQRhRwqLt05ACF2p99NiCQLWW9R436NB
	LPp4LIulNJ59MIFZypB5s9kuFWq0XN1H2jicrFXlARMwxxnEF4D1vl6n7GGAxrjY0dSrtW
	XUi8XzZ+5XZcV8gm/Q1Obgelt7MhmAg=
X-Envelope-To: shakeel.butt@linux.dev
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: roman.gushchin@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH] mm: memcg: move cgroup v1 oom handling code into memcontrol-v1.c: fixup
Date: Thu,  4 Jul 2024 00:27:12 +0000
Message-ID: <20240704002712.2077812-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This is a small fixup for the commit
"mm: memcg: move cgroup v1 oom handling code into memcontrol-v1.c".

I forgot to actually move two functions mem_cgroup_node_nr_lru_pages()
and mem_cgroup_nr_lru_pages() into mm/memcontrol-v1.c, so that they remain
in mm/memcontrol.c and their commented out duplicated versions in
mm/memcontrol-v1.c.

Andrew, can you, please, squash it into the original commit?

I checked that the rest of mm-unstable tree can be rebased
automatically without any merge conflicts.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/memcontrol-v1.c | 74 +++++++++++++++++++++++-----------------------
 mm/memcontrol-v1.h |  5 ----
 mm/memcontrol.c    | 38 ------------------------
 3 files changed, 37 insertions(+), 80 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 42829cbf7b48..597b03ee9e35 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -2494,43 +2494,43 @@ static ssize_t mem_cgroup_reset(struct kernfs_open_file *of, char *buf,
 #define LRU_ALL_ANON (BIT(LRU_INACTIVE_ANON) | BIT(LRU_ACTIVE_ANON))
 #define LRU_ALL	     ((1 << NR_LRU_LISTS) - 1)
 
-/* static unsigned long mem_cgroup_node_nr_lru_pages(struct mem_cgroup *memcg, */
-/* 				int nid, unsigned int lru_mask, bool tree) */
-/* { */
-/* 	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid)); */
-/* 	unsigned long nr = 0; */
-/* 	enum lru_list lru; */
-
-/* 	VM_BUG_ON((unsigned)nid >= nr_node_ids); */
-
-/* 	for_each_lru(lru) { */
-/* 		if (!(BIT(lru) & lru_mask)) */
-/* 			continue; */
-/* 		if (tree) */
-/* 			nr += lruvec_page_state(lruvec, NR_LRU_BASE + lru); */
-/* 		else */
-/* 			nr += lruvec_page_state_local(lruvec, NR_LRU_BASE + lru); */
-/* 	} */
-/* 	return nr; */
-/* } */
-
-/* static unsigned long mem_cgroup_nr_lru_pages(struct mem_cgroup *memcg, */
-/* 					     unsigned int lru_mask, */
-/* 					     bool tree) */
-/* { */
-/* 	unsigned long nr = 0; */
-/* 	enum lru_list lru; */
-
-/* 	for_each_lru(lru) { */
-/* 		if (!(BIT(lru) & lru_mask)) */
-/* 			continue; */
-/* 		if (tree) */
-/* 			nr += memcg_page_state(memcg, NR_LRU_BASE + lru); */
-/* 		else */
-/* 			nr += memcg_page_state_local(memcg, NR_LRU_BASE + lru); */
-/* 	} */
-/* 	return nr; */
-/* } */
+static unsigned long mem_cgroup_node_nr_lru_pages(struct mem_cgroup *memcg,
+				int nid, unsigned int lru_mask, bool tree)
+{
+	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
+	unsigned long nr = 0;
+	enum lru_list lru;
+
+	VM_BUG_ON((unsigned)nid >= nr_node_ids);
+
+	for_each_lru(lru) {
+		if (!(BIT(lru) & lru_mask))
+			continue;
+		if (tree)
+			nr += lruvec_page_state(lruvec, NR_LRU_BASE + lru);
+		else
+			nr += lruvec_page_state_local(lruvec, NR_LRU_BASE + lru);
+	}
+	return nr;
+}
+
+static unsigned long mem_cgroup_nr_lru_pages(struct mem_cgroup *memcg,
+					     unsigned int lru_mask,
+					     bool tree)
+{
+	unsigned long nr = 0;
+	enum lru_list lru;
+
+	for_each_lru(lru) {
+		if (!(BIT(lru) & lru_mask))
+			continue;
+		if (tree)
+			nr += memcg_page_state(memcg, NR_LRU_BASE + lru);
+		else
+			nr += memcg_page_state_local(memcg, NR_LRU_BASE + lru);
+	}
+	return nr;
+}
 
 static int memcg_numa_stat_show(struct seq_file *m, void *v)
 {
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 7be4670d9abb..0a4d5092c51b 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -88,11 +88,6 @@ void memcg1_oom_finish(struct mem_cgroup *memcg, bool locked);
 void memcg1_oom_recover(struct mem_cgroup *memcg);
 
 void drain_all_stock(struct mem_cgroup *root_memcg);
-unsigned long mem_cgroup_nr_lru_pages(struct mem_cgroup *memcg,
-				      unsigned int lru_mask, bool tree);
-unsigned long mem_cgroup_node_nr_lru_pages(struct mem_cgroup *memcg,
-					   int nid, unsigned int lru_mask,
-					   bool tree);
 
 unsigned long memcg_events(struct mem_cgroup *memcg, int event);
 unsigned long memcg_events_local(struct mem_cgroup *memcg, int event);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 11e4a3c65437..f35ed6655992 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3188,44 +3188,6 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 }
 #endif /* CONFIG_MEMCG_KMEM */
 
-unsigned long mem_cgroup_node_nr_lru_pages(struct mem_cgroup *memcg,
-					   int nid, unsigned int lru_mask,
-					   bool tree)
-{
-	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
-	unsigned long nr = 0;
-	enum lru_list lru;
-
-	VM_BUG_ON((unsigned)nid >= nr_node_ids);
-
-	for_each_lru(lru) {
-		if (!(BIT(lru) & lru_mask))
-			continue;
-		if (tree)
-			nr += lruvec_page_state(lruvec, NR_LRU_BASE + lru);
-		else
-			nr += lruvec_page_state_local(lruvec, NR_LRU_BASE + lru);
-	}
-	return nr;
-}
-
-unsigned long mem_cgroup_nr_lru_pages(struct mem_cgroup *memcg,
-				      unsigned int lru_mask, bool tree)
-{
-	unsigned long nr = 0;
-	enum lru_list lru;
-
-	for_each_lru(lru) {
-		if (!(BIT(lru) & lru_mask))
-			continue;
-		if (tree)
-			nr += memcg_page_state(memcg, NR_LRU_BASE + lru);
-		else
-			nr += memcg_page_state_local(memcg, NR_LRU_BASE + lru);
-	}
-	return nr;
-}
-
 #ifdef CONFIG_CGROUP_WRITEBACK
 
 #include <trace/events/writeback.h>
-- 
2.45.2.803.g4e1b14247a-goog


