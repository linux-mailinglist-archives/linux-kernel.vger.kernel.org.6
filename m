Return-Path: <linux-kernel+bounces-193026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 246AE8D25B9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D325B28D6BA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 20:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7AA17BB24;
	Tue, 28 May 2024 20:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LVdjxeY3"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A456617BB04
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 20:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716927709; cv=none; b=buyRLRw1iICzYXz2RPovMKqJNsPZo5LN5q5BXWeIfEtGvW20h8K3J1sQhRuhZV04F5oLj+77MHFifiiQ3p+LazgOiYKo54PlYvbf4fJwP+uvpHNPjj6VfS3plvdWDrFYXSKpD4E0NKuyJCid+erVXXmbGOYlpwg/KhXYGxWlYDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716927709; c=relaxed/simple;
	bh=asMl+3nJ+njC7dTGJOKjATJCxHpb9p1FfHtifMkrktY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNIsO/WVoNrOeClXI9hKjQsK4rsULXbWLZgEXnCWvGkKDyrWJKqL1NF+abK1suiuVKD/a0eVebJNQLI/GVvVxIaTi/a8BA2fSzI2EUR3V6ialT0N/STCD8gadNpd4mYNjsKnVrS4hBvgMqL5E566TZcc2Ldug+7Jo/KMH4z3EaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LVdjxeY3; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716927706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iHmz/4j1k+x1JyR1DIx1IjyudPVgo21HIVNpr+GFlhs=;
	b=LVdjxeY3LUib37ppAfCHlYVPf/yApIN0kLiPB4FhEQDPrNz936dNx1FmhJTTlzA/+vt2ZN
	aNsexft76Fo9VCdnuUG+U5S0qohsfoHgSdvCO/XXJNh02mdFVF9Dne0aDA6WrkIjiCpDnL
	PQGCwOvl7qqurpkyKBNvI3YnND5IhW8=
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
Subject: [PATCH v1 07/14] mm: memcg: rename memcg_check_events()
Date: Tue, 28 May 2024 13:20:59 -0700
Message-ID: <20240528202101.3099300-8-roman.gushchin@linux.dev>
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

Rename memcg_check_events() into memcg1_check_events() for
consistency with other cgroup v1-specific functions.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/memcontrol-v1.c | 6 +++---
 mm/memcontrol-v1.h | 2 +-
 mm/memcontrol.c    | 8 ++++----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index c47ffb6105931..8b8c2c9516349 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -835,9 +835,9 @@ static int mem_cgroup_move_account(struct folio *folio,
 
 	local_irq_disable();
 	mem_cgroup_charge_statistics(to, nr_pages);
-	memcg_check_events(to, nid);
+	memcg1_check_events(to, nid);
 	mem_cgroup_charge_statistics(from, -nr_pages);
-	memcg_check_events(from, nid);
+	memcg1_check_events(from, nid);
 	local_irq_enable();
 out:
 	return ret;
@@ -1424,7 +1424,7 @@ static void mem_cgroup_threshold(struct mem_cgroup *memcg)
  * Check events in order.
  *
  */
-void memcg_check_events(struct mem_cgroup *memcg, int nid)
+void memcg1_check_events(struct mem_cgroup *memcg, int nid)
 {
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		return;
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 524a2c76ffc97..ef1b7037cbdcc 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -12,7 +12,7 @@ static inline void memcg1_soft_limit_reset(struct mem_cgroup *memcg)
 }
 
 void mem_cgroup_charge_statistics(struct mem_cgroup *memcg, int nr_pages);
-void memcg_check_events(struct mem_cgroup *memcg, int nid);
+void memcg1_check_events(struct mem_cgroup *memcg, int nid);
 void memcg_oom_recover(struct mem_cgroup *memcg);
 int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 		     unsigned int nr_pages);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6bc9009bee517..c14b1b01bcf53 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2632,7 +2632,7 @@ void mem_cgroup_commit_charge(struct folio *folio, struct mem_cgroup *memcg)
 
 	local_irq_disable();
 	mem_cgroup_charge_statistics(memcg, folio_nr_pages(folio));
-	memcg_check_events(memcg, folio_nid(folio));
+	memcg1_check_events(memcg, folio_nid(folio));
 	local_irq_enable();
 }
 
@@ -5699,7 +5699,7 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 	local_irq_save(flags);
 	__count_memcg_events(ug->memcg, PGPGOUT, ug->pgpgout);
 	__this_cpu_add(ug->memcg->vmstats_percpu->nr_page_events, ug->nr_memory);
-	memcg_check_events(ug->memcg, ug->nid);
+	memcg1_check_events(ug->memcg, ug->nid);
 	local_irq_restore(flags);
 
 	/* drop reference from uncharge_folio */
@@ -5839,7 +5839,7 @@ void mem_cgroup_replace_folio(struct folio *old, struct folio *new)
 
 	local_irq_save(flags);
 	mem_cgroup_charge_statistics(memcg, nr_pages);
-	memcg_check_events(memcg, folio_nid(new));
+	memcg1_check_events(memcg, folio_nid(new));
 	local_irq_restore(flags);
 }
 
@@ -6106,7 +6106,7 @@ void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry)
 	memcg_stats_lock();
 	mem_cgroup_charge_statistics(memcg, -nr_entries);
 	memcg_stats_unlock();
-	memcg_check_events(memcg, folio_nid(folio));
+	memcg1_check_events(memcg, folio_nid(folio));
 
 	css_put(&memcg->css);
 }
-- 
2.45.1


