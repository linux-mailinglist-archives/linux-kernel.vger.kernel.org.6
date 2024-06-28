Return-Path: <linux-kernel+bounces-234541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEF391C7BF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F4E61C209D7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6F17D06B;
	Fri, 28 Jun 2024 21:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lZwpcIdW"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B958978C99
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719608633; cv=none; b=YGZ98UUmcowU4UwQXUGN2l9K9/q4eilvWLMXOtIzHjv89OtX/UuhJqe1RiFGRIfE0v9XrQKDDhwLswCzGPiAT2co4bPgpPzykBK17C4Bwn+vXdP5ZWhfqj4d3FfwOHoqkqgJWojvihh6M9Q9VnxjH0gpY/ZkcJOuzvVff03ECB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719608633; c=relaxed/simple;
	bh=mdCK89I/EJpO3Ks0Q/lmy2u3/FfVt92nkxhOAySFJno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9tMCOYWssg3/1DecMefMIZCJlU1XS0KyPm75qqTEkD83Fobqk8tzJTclugeC1Dy7UVulSZzxYkyJlwrtgzQonm8glGhMBLNH9cl6lpnC/n04gM66gQcVAA0SRQdFelQFyRLnj3TXF6Hlp15xQc+h/sc/zBOzRXZwEUFLsxjnJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lZwpcIdW; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719608630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RgRJB5ojFnC1EEazDyS1AJJPjVu1TOm/QXaplK0X/Xs=;
	b=lZwpcIdW8TqGKNu091IVqrkYFQAou0Jw6wdWJ44IBEE2EcR7K1Bthx5XJTC93f4pV0sNmo
	Ju27X4CNJNK2KcwGlp2hOd4iCh2dmvSHuE4w6o6tKw6YyQNfKgbQZxUbNWt2HxE+dA7hYn
	mEOzBm4Z5lqqWgKuByG7tdOaT20Wpeo=
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
Subject: [PATCH v1 1/9] mm: memcg: move memcg_account_kmem() to memcontrol-v1.c
Date: Fri, 28 Jun 2024 21:03:09 +0000
Message-ID: <20240628210317.272856-2-roman.gushchin@linux.dev>
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

memcg_account_kmem() consists of a trivial statistics change via
mod_memcg_state() call and a relatively large memcg1-specific part.

Let's factor out the mod_memcg_state() call and move the rest into
the mm/memcontrol-v1.c file. Also rename memcg_account_kmem()
into memcg1_account_kmem() for consistency.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/memcontrol-v1.c | 12 ++++++++++++
 mm/memcontrol-v1.h |  2 ++
 mm/memcontrol.c    | 31 ++++++++++---------------------
 3 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 6ac47954eefc..c73a0ff0cc39 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -2913,6 +2913,18 @@ struct cftype memsw_files[] = {
 	{ },	/* terminate */
 };
 
+#ifdef CONFIG_MEMCG_KMEM
+void memcg1_account_kmem(struct mem_cgroup *memcg, int nr_pages)
+{
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
+		if (nr_pages > 0)
+			page_counter_charge(&memcg->kmem, nr_pages);
+		else
+			page_counter_uncharge(&memcg->kmem, -nr_pages);
+	}
+}
+#endif /* CONFIG_MEMCG_KMEM */
+
 static int __init memcg1_init(void)
 {
 	int node;
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 64b053d7f131..61620e2b0bf0 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -107,6 +107,7 @@ void memcg1_check_events(struct mem_cgroup *memcg, int nid);
 
 void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s);
 
+void memcg1_account_kmem(struct mem_cgroup *memcg, int nr_pages);
 extern struct cftype memsw_files[];
 extern struct cftype mem_cgroup_legacy_files[];
 
@@ -125,6 +126,7 @@ static inline void memcg1_check_events(struct mem_cgroup *memcg, int nid) {}
 
 static inline void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s) {}
 
+static inline void memcg1_account_kmem(struct mem_cgroup *memcg, int nr_pages) {}
 extern struct cftype memsw_files[];
 extern struct cftype mem_cgroup_legacy_files[];
 #endif	/* CONFIG_MEMCG_V1 */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c251bbe35f4b..802a077e2e2f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1718,7 +1718,6 @@ static DEFINE_MUTEX(percpu_charge_mutex);
 static struct obj_cgroup *drain_obj_stock(struct memcg_stock_pcp *stock);
 static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 				     struct mem_cgroup *root_memcg);
-static void memcg_account_kmem(struct mem_cgroup *memcg, int nr_pages);
 
 #else
 static inline struct obj_cgroup *drain_obj_stock(struct memcg_stock_pcp *stock)
@@ -1730,9 +1729,6 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 {
 	return false;
 }
-static void memcg_account_kmem(struct mem_cgroup *memcg, int nr_pages)
-{
-}
 #endif
 
 /**
@@ -2642,18 +2638,6 @@ struct obj_cgroup *get_obj_cgroup_from_folio(struct folio *folio)
 	return objcg;
 }
 
-static void memcg_account_kmem(struct mem_cgroup *memcg, int nr_pages)
-{
-	mod_memcg_state(memcg, MEMCG_KMEM, nr_pages);
-	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
-		if (nr_pages > 0)
-			page_counter_charge(&memcg->kmem, nr_pages);
-		else
-			page_counter_uncharge(&memcg->kmem, -nr_pages);
-	}
-}
-
-
 /*
  * obj_cgroup_uncharge_pages: uncharge a number of kernel pages from a objcg
  * @objcg: object cgroup to uncharge
@@ -2666,7 +2650,8 @@ static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
 
 	memcg = get_mem_cgroup_from_objcg(objcg);
 
-	memcg_account_kmem(memcg, -nr_pages);
+	mod_memcg_state(memcg, MEMCG_KMEM, -nr_pages);
+	memcg1_account_kmem(memcg, -nr_pages);
 	refill_stock(memcg, nr_pages);
 
 	css_put(&memcg->css);
@@ -2692,7 +2677,8 @@ static int obj_cgroup_charge_pages(struct obj_cgroup *objcg, gfp_t gfp,
 	if (ret)
 		goto out;
 
-	memcg_account_kmem(memcg, nr_pages);
+	mod_memcg_state(memcg, MEMCG_KMEM, nr_pages);
+	memcg1_account_kmem(memcg, nr_pages);
 out:
 	css_put(&memcg->css);
 
@@ -2845,7 +2831,8 @@ static struct obj_cgroup *drain_obj_stock(struct memcg_stock_pcp *stock)
 
 			memcg = get_mem_cgroup_from_objcg(old);
 
-			memcg_account_kmem(memcg, -nr_pages);
+			mod_memcg_state(memcg, MEMCG_KMEM, -nr_pages);
+			memcg1_account_kmem(memcg, -nr_pages);
 			__refill_stock(memcg, nr_pages);
 
 			css_put(&memcg->css);
@@ -4806,8 +4793,10 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 		page_counter_uncharge(&ug->memcg->memory, ug->nr_memory);
 		if (do_memsw_account())
 			page_counter_uncharge(&ug->memcg->memsw, ug->nr_memory);
-		if (ug->nr_kmem)
-			memcg_account_kmem(ug->memcg, -ug->nr_kmem);
+		if (ug->nr_kmem) {
+			mod_memcg_state(ug->memcg, MEMCG_KMEM, -ug->nr_kmem);
+			memcg1_account_kmem(ug->memcg, -ug->nr_kmem);
+		}
 		memcg1_oom_recover(ug->memcg);
 	}
 
-- 
2.45.2.803.g4e1b14247a-goog


