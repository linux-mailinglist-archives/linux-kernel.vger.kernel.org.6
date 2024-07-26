Return-Path: <linux-kernel+bounces-263729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA63993D9CB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 22:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A9851C22ABB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D13149C65;
	Fri, 26 Jul 2024 20:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q5tpDC4X"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CE3146A8A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 20:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722025887; cv=none; b=ZXZ2ok91/2KvSnFrEiTCkhEdFsWrj9u5zzbnZfvpdPuD5Vv4kIyNhOVoQLHcUlA1RigC+3XqFToXdHlezCjOuABhbpF/u/wiLCgzHNPAX7XSQncS46Edx8qZksm4yyaeT1z2QaJ5Qr2OXpq2sHOTk9LFPBspVWlcsYp6T4RK7/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722025887; c=relaxed/simple;
	bh=2j00hdjco43fCfmdLWNv1e8uy78WNRBqiGlKU0sWnpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JLnEuG+AOjtSi/6+hy52EA6maYcvpWKbOHbyD+YKBm5v4AOtWxMdohXXXYak/u2mHHjzE8l066PYlpvCSiP0DWN4Uaq7/GdsQTlHTZGEWHJBsoGmh4q5qyq08wH+6jyUIU7Wm5Urr6OiYaniG8B/FXO3H8lBJd+JUGPPQk1pilA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q5tpDC4X; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722025883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Ma39JIt9UMBhtRRWP/3mWelLcidI6/lxwwSADCSCQQ=;
	b=q5tpDC4XomuJOhtLaY+kadmUPS+OMFMVzClcXxawG2eHzIaiy1oyqfDg30EKaEDyW0wRmu
	dabktA+KuLySiabaO8AcCcwBpKFTqII+nklD1yNK2RRCgK3p+XewC720u1iMe6urpV+RIO
	UPsNGo4NoXLOxUsSqeFHwf1yIm7PtOw=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v3 1/3] mm: memcg: don't call propagate_protected_usage() needlessly
Date: Fri, 26 Jul 2024 20:31:08 +0000
Message-ID: <20240726203110.1577216-2-roman.gushchin@linux.dev>
In-Reply-To: <20240726203110.1577216-1-roman.gushchin@linux.dev>
References: <20240726203110.1577216-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Memory protection (min/low) requires a constant tracking of
protected memory usage. propagate_protected_usage() is called
on each page counters update and does a number of operations
even in cases when the actual memory protection functionality
is not supported (e.g. hugetlb cgroups or memcg swap counters).

It's obviously inefficient and leads to a waste of CPU cycles.
It can be addressed by calling propagate_protected_usage() only
for the counters which do support memory guarantees. As of now
it's only memcg->memory - the unified memory memcg counter.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/page_counter.h |  8 +++++++-
 mm/hugetlb_cgroup.c          |  4 ++--
 mm/memcontrol.c              | 16 ++++++++--------
 mm/page_counter.c            | 16 +++++++++++++---
 4 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
index e1295e3e1f19..aadd42f5ab7b 100644
--- a/include/linux/page_counter.h
+++ b/include/linux/page_counter.h
@@ -32,6 +32,7 @@ struct page_counter {
 	/* Keep all the read most fields in a separete cacheline. */
 	CACHELINE_PADDING(_pad2_);
 
+	bool protection_support;
 	unsigned long min;
 	unsigned long low;
 	unsigned long high;
@@ -45,12 +46,17 @@ struct page_counter {
 #define PAGE_COUNTER_MAX (LONG_MAX / PAGE_SIZE)
 #endif
 
+/*
+ * Protection is supported only for the first counter (with id 0).
+ */
 static inline void page_counter_init(struct page_counter *counter,
-				     struct page_counter *parent)
+				     struct page_counter *parent,
+				     bool protection_support)
 {
 	atomic_long_set(&counter->usage, 0);
 	counter->max = PAGE_COUNTER_MAX;
 	counter->parent = parent;
+	counter->protection_support = protection_support;
 }
 
 static inline unsigned long page_counter_read(struct page_counter *counter)
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index f443a56409a9..d8d0e665caed 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -114,10 +114,10 @@ static void hugetlb_cgroup_init(struct hugetlb_cgroup *h_cgroup,
 		}
 		page_counter_init(hugetlb_cgroup_counter_from_cgroup(h_cgroup,
 								     idx),
-				  fault_parent);
+				  fault_parent, false);
 		page_counter_init(
 			hugetlb_cgroup_counter_from_cgroup_rsvd(h_cgroup, idx),
-			rsvd_parent);
+			rsvd_parent, false);
 
 		limit = round_down(PAGE_COUNTER_MAX,
 				   pages_per_huge_page(&hstates[idx]));
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index eb92c21615eb..58169c34ae55 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3585,21 +3585,21 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 	if (parent) {
 		WRITE_ONCE(memcg->swappiness, mem_cgroup_swappiness(parent));
 
-		page_counter_init(&memcg->memory, &parent->memory);
-		page_counter_init(&memcg->swap, &parent->swap);
+		page_counter_init(&memcg->memory, &parent->memory, true);
+		page_counter_init(&memcg->swap, &parent->swap, false);
 #ifdef CONFIG_MEMCG_V1
 		WRITE_ONCE(memcg->oom_kill_disable, READ_ONCE(parent->oom_kill_disable));
-		page_counter_init(&memcg->kmem, &parent->kmem);
-		page_counter_init(&memcg->tcpmem, &parent->tcpmem);
+		page_counter_init(&memcg->kmem, &parent->kmem, false);
+		page_counter_init(&memcg->tcpmem, &parent->tcpmem, false);
 #endif
 	} else {
 		init_memcg_stats();
 		init_memcg_events();
-		page_counter_init(&memcg->memory, NULL);
-		page_counter_init(&memcg->swap, NULL);
+		page_counter_init(&memcg->memory, NULL, true);
+		page_counter_init(&memcg->swap, NULL, false);
 #ifdef CONFIG_MEMCG_V1
-		page_counter_init(&memcg->kmem, NULL);
-		page_counter_init(&memcg->tcpmem, NULL);
+		page_counter_init(&memcg->kmem, NULL, false);
+		page_counter_init(&memcg->tcpmem, NULL, false);
 #endif
 		root_mem_cgroup = memcg;
 		return &memcg->css;
diff --git a/mm/page_counter.c b/mm/page_counter.c
index ad9bdde5d5d2..a54382a58ace 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -13,6 +13,11 @@
 #include <linux/bug.h>
 #include <asm/page.h>
 
+static bool track_protection(struct page_counter *c)
+{
+	return c->protection_support;
+}
+
 static void propagate_protected_usage(struct page_counter *c,
 				      unsigned long usage)
 {
@@ -57,7 +62,8 @@ void page_counter_cancel(struct page_counter *counter, unsigned long nr_pages)
 		new = 0;
 		atomic_long_set(&counter->usage, new);
 	}
-	propagate_protected_usage(counter, new);
+	if (track_protection(counter))
+		propagate_protected_usage(counter, new);
 }
 
 /**
@@ -70,12 +76,14 @@ void page_counter_cancel(struct page_counter *counter, unsigned long nr_pages)
 void page_counter_charge(struct page_counter *counter, unsigned long nr_pages)
 {
 	struct page_counter *c;
+	bool protection = track_protection(counter);
 
 	for (c = counter; c; c = c->parent) {
 		long new;
 
 		new = atomic_long_add_return(nr_pages, &c->usage);
-		propagate_protected_usage(c, new);
+		if (protection)
+			propagate_protected_usage(c, new);
 		/*
 		 * This is indeed racy, but we can live with some
 		 * inaccuracy in the watermark.
@@ -112,6 +120,7 @@ bool page_counter_try_charge(struct page_counter *counter,
 			     struct page_counter **fail)
 {
 	struct page_counter *c;
+	bool protection = track_protection(counter);
 
 	for (c = counter; c; c = c->parent) {
 		long new;
@@ -141,7 +150,8 @@ bool page_counter_try_charge(struct page_counter *counter,
 			*fail = c;
 			goto failed;
 		}
-		propagate_protected_usage(c, new);
+		if (protection)
+			propagate_protected_usage(c, new);
 
 		/* see comment on page_counter_charge */
 		if (new > READ_ONCE(c->local_watermark)) {
-- 
2.46.0.rc1.232.g9752f9e123-goog


