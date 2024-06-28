Return-Path: <linux-kernel+bounces-234542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7569F91C7C0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCEBBB23F90
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0357F48C;
	Fri, 28 Jun 2024 21:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J4erkf2Y"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E76D79945
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719608635; cv=none; b=FUi9A6r8/7z3sAEfQ8COKbZm856UUcGjHSrtYHuSXKr6aV0nnvBx2m+qgjkeFqtmKpdgxYNLGkK724/BB8TGpHzg8zei2zsFE+DHCcjb9hjmVZqBan8VscrppmJVAoq7fk6n78p1k/5gUiCLUnYhbOOW6/rl+aFX/HB9zFzs++U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719608635; c=relaxed/simple;
	bh=R1uEJzw6GN2XqPwwpYXnuia4NWHNqszDL7hESnZOzfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qIgA28aCErdpXqxQu9J89EevImJPvzxhkC8cuC3PQlSf5z4s8sxqUnfHvV+LYGiXu/PV3l45cUY84gSXjM1lv5N3EjTeERR00O0ZMW3NgjjU0W4jgR9GOELlcMOrMcEFYlGL0FlJtVgX9xTm/WiAB1PMkJILCX1CWwOQ5XdWAvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J4erkf2Y; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719608631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xMDF+K4BIl7gcrHo2WUEmAHLFHOqrbM2Rc/7npZEcT8=;
	b=J4erkf2YjUTiJUMZYB1J0+yCmRXUnc59RpTJ8yK14OwGb7VFouZgBj42vekY+DDYdgNdig
	Ex07/kd5xqqsR3UtmucYNSKqSFqszQLIeVJs8dybLz17eb6z3H7M2D1joHukOI44bfUF+G
	jCt42MhduBjyhLVrKK6fNNHBrWvoAFA=
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: shakeel.butt@linux.dev
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: roman.gushchin@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v1 2/9] mm: memcg: factor out legacy socket memory accounting code
Date: Fri, 28 Jun 2024 21:03:10 +0000
Message-ID: <20240628210317.272856-3-roman.gushchin@linux.dev>
In-Reply-To: <20240628210317.272856-1-roman.gushchin@linux.dev>
References: <20240628210317.272856-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Move out the legacy cgroup v1 socket memory accounting code into
mm/memcontrol-v1.c.

This commit introduces three new functions: memcg1_tcpmem_active(),
memcg1_charge_skmem() and memcg1_uncharge_skmem(), which contain
all cgroup v1-specific code and become trivial if CONFIG_MEMCG_V1
isn't set.

Note, that !!memcg->tcpmem_pressure check in
mem_cgroup_under_socket_pressure() can't be easily moved into
memcontrol-v1.h without including memcontrol-v1.h from memcontrol.h
which isn't a good idea, so it's better to just #ifdef it.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/memcontrol.h |  2 ++
 mm/memcontrol-v1.c         | 17 +++++++++++++++++
 mm/memcontrol-v1.h         | 16 ++++++++++++++++
 mm/memcontrol.c            | 22 +++++-----------------
 4 files changed, 40 insertions(+), 17 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 796cfa842346..44ab6394c9ed 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1650,8 +1650,10 @@ void mem_cgroup_sk_alloc(struct sock *sk);
 void mem_cgroup_sk_free(struct sock *sk);
 static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
 {
+#ifdef CONFIG_MEMCG_V1
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return !!memcg->tcpmem_pressure;
+#endif /* CONFIG_MEMCG_V1 */
 	do {
 		if (time_before(jiffies, READ_ONCE(memcg->socket_pressure)))
 			return true;
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index c73a0ff0cc39..c9b4c3e4797d 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -2925,6 +2925,23 @@ void memcg1_account_kmem(struct mem_cgroup *memcg, int nr_pages)
 }
 #endif /* CONFIG_MEMCG_KMEM */
 
+bool memcg1_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages,
+			 gfp_t gfp_mask)
+{
+	struct page_counter *fail;
+
+	if (page_counter_try_charge(&memcg->tcpmem, nr_pages, &fail)) {
+		memcg->tcpmem_pressure = 0;
+		return true;
+	}
+	memcg->tcpmem_pressure = 1;
+	if (gfp_mask & __GFP_NOFAIL) {
+		page_counter_charge(&memcg->tcpmem, nr_pages);
+		return true;
+	}
+	return false;
+}
+
 static int __init memcg1_init(void)
 {
 	int node;
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 61620e2b0bf0..c8e5119223bb 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -108,6 +108,17 @@ void memcg1_check_events(struct mem_cgroup *memcg, int nid);
 void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s);
 
 void memcg1_account_kmem(struct mem_cgroup *memcg, int nr_pages);
+static inline bool memcg1_tcpmem_active(struct mem_cgroup *memcg)
+{
+	return memcg->tcpmem_active;
+}
+bool memcg1_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages,
+			 gfp_t gfp_mask);
+static inline void memcg1_uncharge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages)
+{
+	page_counter_uncharge(&memcg->tcpmem, nr_pages);
+}
+
 extern struct cftype memsw_files[];
 extern struct cftype mem_cgroup_legacy_files[];
 
@@ -127,6 +138,11 @@ static inline void memcg1_check_events(struct mem_cgroup *memcg, int nid) {}
 static inline void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s) {}
 
 static inline void memcg1_account_kmem(struct mem_cgroup *memcg, int nr_pages) {}
+static inline bool memcg1_tcpmem_active(struct mem_cgroup *memcg) { return false; }
+static inline bool memcg1_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages,
+				       gfp_t gfp_mask) { return true; }
+static inline void memcg1_uncharge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages) {}
+
 extern struct cftype memsw_files[];
 extern struct cftype mem_cgroup_legacy_files[];
 #endif	/* CONFIG_MEMCG_V1 */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 802a077e2e2f..2c0605bbbb31 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3788,7 +3788,7 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys) && !cgroup_memory_nosocket)
 		static_branch_dec(&memcg_sockets_enabled_key);
 
-	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && memcg->tcpmem_active)
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && memcg1_tcpmem_active(memcg))
 		static_branch_dec(&memcg_sockets_enabled_key);
 
 #if defined(CONFIG_MEMCG_KMEM)
@@ -5013,7 +5013,7 @@ void mem_cgroup_sk_alloc(struct sock *sk)
 	memcg = mem_cgroup_from_task(current);
 	if (mem_cgroup_is_root(memcg))
 		goto out;
-	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && !memcg->tcpmem_active)
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && !memcg1_tcpmem_active(memcg))
 		goto out;
 	if (css_tryget(&memcg->css))
 		sk->sk_memcg = memcg;
@@ -5039,20 +5039,8 @@ void mem_cgroup_sk_free(struct sock *sk)
 bool mem_cgroup_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages,
 			     gfp_t gfp_mask)
 {
-	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
-		struct page_counter *fail;
-
-		if (page_counter_try_charge(&memcg->tcpmem, nr_pages, &fail)) {
-			memcg->tcpmem_pressure = 0;
-			return true;
-		}
-		memcg->tcpmem_pressure = 1;
-		if (gfp_mask & __GFP_NOFAIL) {
-			page_counter_charge(&memcg->tcpmem, nr_pages);
-			return true;
-		}
-		return false;
-	}
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		return memcg1_charge_skmem(memcg, nr_pages, gfp_mask);
 
 	if (try_charge(memcg, gfp_mask, nr_pages) == 0) {
 		mod_memcg_state(memcg, MEMCG_SOCK, nr_pages);
@@ -5070,7 +5058,7 @@ bool mem_cgroup_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages,
 void mem_cgroup_uncharge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
-		page_counter_uncharge(&memcg->tcpmem, nr_pages);
+		memcg1_uncharge_skmem(memcg, nr_pages);
 		return;
 	}
 
-- 
2.45.2.803.g4e1b14247a-goog


