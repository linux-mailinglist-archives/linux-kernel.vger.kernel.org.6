Return-Path: <linux-kernel+bounces-261497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E0193B7F4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E1351F21E75
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C9816F0C3;
	Wed, 24 Jul 2024 20:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XFA8jIM6"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9122616D4D5
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 20:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721852485; cv=none; b=mkpNChr/GXBGnibHCr0ejM/a05l8gwq2qBTtIVcGJLQjTXk4ExJxnOS9VaWLxDYzrul03Di+fQmn1LdHtZWQhW3/AC+VTvoNlJ0gRD2Qz0pF0bEsu1np7UHrlK/6To65ExYMpsyWV4uRrakH9ifNENIu114wO+Wzt7i8i+kNypo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721852485; c=relaxed/simple;
	bh=pBXBCth5rni6dSYWlCTmH3DLMu62cInuEbg7GF/CVA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QqaWbFobQzlUEAqFbseh/uTiMx4HTbvWSiFsoASNu3NeUj6Ay5rDldgqyxqO8lvUXg1vBcZRUOoLCDI4ytiLk/a1TM9GlfX69fftaYAym+KCJhPFlDRAIt15e6Z/aSQXdAWi6CAbhb0GFwrYbGgiHtJAbI0Amz3mY+viix0QGlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XFA8jIM6; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721852481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RbJVQD3TgI+54uWuq60CTiNA5H84vr1UFlO22URjpZw=;
	b=XFA8jIM6d6YlZvs65lqN/esSuPBx0o9tFNHsXfxctPo1QVUt3t4LZ/Po0rHiqPuE6VV37t
	FLQGGNtpnaOtHHfvriDKQk6v8RDs8U8jNlo+8Q13YXXDeXy6z3urqp8AxhnEqTepPWFW6I
	1NAO7KX+aLhwM9nZvAWFgp3X3Eu0Tko=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v2 5/5] mm: memcg: convert enum res_type to mem_counter_type
Date: Wed, 24 Jul 2024 20:21:03 +0000
Message-ID: <20240724202103.1210065-6-roman.gushchin@linux.dev>
In-Reply-To: <20240724202103.1210065-1-roman.gushchin@linux.dev>
References: <20240724202103.1210065-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The res_type enum is listing all types of memory tracked by memory
cgroups: generic memory, swap, kernel memory, tcp etc; and it's
currently used only for dealing with corresponding sysfs files.

To prepare for tracking of various types of memory by a single
page_counter structure, a similar enumeration is needed. Instead
of introducing a completely new enumeration, let's re-purpose
the existing one: rename it into mem_counter_type, change items
names to be more meaningful and move to page_counter.h. The latter
is needed to have the total number of different memory types
available.

This change doesn't bring any functional difference, it's a pure
refactoring.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/memcontrol-v1.c | 66 +++++++++++++++++++++++-----------------------
 mm/memcontrol-v1.h |  8 ------
 2 files changed, 33 insertions(+), 41 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index d8bf89c76cc5..05433c0a73dc 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1497,7 +1497,7 @@ static void mem_cgroup_oom_notify(struct mem_cgroup *memcg)
 }
 
 static int __mem_cgroup_usage_register_event(struct mem_cgroup *memcg,
-	struct eventfd_ctx *eventfd, const char *args, enum res_type type)
+	struct eventfd_ctx *eventfd, const char *args, enum mem_counter_type type)
 {
 	struct mem_cgroup_thresholds *thresholds;
 	struct mem_cgroup_threshold_ary *new;
@@ -1511,10 +1511,10 @@ static int __mem_cgroup_usage_register_event(struct mem_cgroup *memcg,
 
 	mutex_lock(&memcg->thresholds_lock);
 
-	if (type == _MEM) {
+	if (type == MCT_MEM) {
 		thresholds = &memcg->thresholds;
 		usage = mem_cgroup_usage(memcg, false);
-	} else if (type == _MEMSWAP) {
+	} else if (type == MCT_MEMSW) {
 		thresholds = &memcg->memsw_thresholds;
 		usage = mem_cgroup_usage(memcg, true);
 	} else
@@ -1522,7 +1522,7 @@ static int __mem_cgroup_usage_register_event(struct mem_cgroup *memcg,
 
 	/* Check if a threshold crossed before adding a new one */
 	if (thresholds->primary)
-		__mem_cgroup_threshold(memcg, type == _MEMSWAP);
+		__mem_cgroup_threshold(memcg, type == MCT_MEMSW);
 
 	size = thresholds->primary ? thresholds->primary->size + 1 : 1;
 
@@ -1579,17 +1579,17 @@ static int __mem_cgroup_usage_register_event(struct mem_cgroup *memcg,
 static int mem_cgroup_usage_register_event(struct mem_cgroup *memcg,
 	struct eventfd_ctx *eventfd, const char *args)
 {
-	return __mem_cgroup_usage_register_event(memcg, eventfd, args, _MEM);
+	return __mem_cgroup_usage_register_event(memcg, eventfd, args, MCT_MEM);
 }
 
 static int memsw_cgroup_usage_register_event(struct mem_cgroup *memcg,
 	struct eventfd_ctx *eventfd, const char *args)
 {
-	return __mem_cgroup_usage_register_event(memcg, eventfd, args, _MEMSWAP);
+	return __mem_cgroup_usage_register_event(memcg, eventfd, args, MCT_MEMSW);
 }
 
 static void __mem_cgroup_usage_unregister_event(struct mem_cgroup *memcg,
-	struct eventfd_ctx *eventfd, enum res_type type)
+	struct eventfd_ctx *eventfd, enum mem_counter_type type)
 {
 	struct mem_cgroup_thresholds *thresholds;
 	struct mem_cgroup_threshold_ary *new;
@@ -1598,10 +1598,10 @@ static void __mem_cgroup_usage_unregister_event(struct mem_cgroup *memcg,
 
 	mutex_lock(&memcg->thresholds_lock);
 
-	if (type == _MEM) {
+	if (type == MCT_MEM) {
 		thresholds = &memcg->thresholds;
 		usage = mem_cgroup_usage(memcg, false);
-	} else if (type == _MEMSWAP) {
+	} else if (type == MCT_MEMSW) {
 		thresholds = &memcg->memsw_thresholds;
 		usage = mem_cgroup_usage(memcg, true);
 	} else
@@ -1611,7 +1611,7 @@ static void __mem_cgroup_usage_unregister_event(struct mem_cgroup *memcg,
 		goto unlock;
 
 	/* Check if a threshold crossed before removing */
-	__mem_cgroup_threshold(memcg, type == _MEMSWAP);
+	__mem_cgroup_threshold(memcg, type == MCT_MEMSW);
 
 	/* Calculate new number of threshold */
 	size = entries = 0;
@@ -1676,13 +1676,13 @@ static void __mem_cgroup_usage_unregister_event(struct mem_cgroup *memcg,
 static void mem_cgroup_usage_unregister_event(struct mem_cgroup *memcg,
 	struct eventfd_ctx *eventfd)
 {
-	return __mem_cgroup_usage_unregister_event(memcg, eventfd, _MEM);
+	return __mem_cgroup_usage_unregister_event(memcg, eventfd, MCT_MEM);
 }
 
 static void memsw_cgroup_usage_unregister_event(struct mem_cgroup *memcg,
 	struct eventfd_ctx *eventfd)
 {
-	return __mem_cgroup_usage_unregister_event(memcg, eventfd, _MEMSWAP);
+	return __mem_cgroup_usage_unregister_event(memcg, eventfd, MCT_MEMSW);
 }
 
 static int mem_cgroup_oom_register_event(struct mem_cgroup *memcg,
@@ -2414,20 +2414,20 @@ static ssize_t mem_cgroup_write(struct kernfs_open_file *of,
 			break;
 		}
 		switch (MEMFILE_TYPE(of_cft(of)->private)) {
-		case _MEM:
+		case MCT_MEM:
 			ret = mem_cgroup_resize_max(memcg, nr_pages, false);
 			break;
-		case _MEMSWAP:
+		case MCT_MEMSW:
 			ret = mem_cgroup_resize_max(memcg, nr_pages, true);
 			break;
-		case _KMEM:
+		case MCT_KMEM:
 			pr_warn_once("kmem.limit_in_bytes is deprecated and will be removed. "
 				     "Writing any value to this file has no effect. "
 				     "Please report your usecase to linux-mm@kvack.org if you "
 				     "depend on this functionality.\n");
 			ret = 0;
 			break;
-		case _TCP:
+		case MCT_TCPMEM:
 			ret = memcg_update_tcp_max(memcg, nr_pages);
 			break;
 		}
@@ -2738,30 +2738,30 @@ static int mem_cgroup_slab_show(struct seq_file *m, void *p)
 struct cftype mem_cgroup_legacy_files[] = {
 	{
 		.name = "usage_in_bytes",
-		.private = MEMFILE_PRIVATE(_MEM, RES_USAGE),
+		.private = MEMFILE_PRIVATE(MCT_MEM, RES_USAGE),
 		.read_u64 = mem_cgroup_read_u64,
 	},
 	{
 		.name = "max_usage_in_bytes",
-		.private = MEMFILE_PRIVATE(_MEM, RES_MAX_USAGE),
+		.private = MEMFILE_PRIVATE(MCT_MEM, RES_MAX_USAGE),
 		.write = mem_cgroup_reset,
 		.read_u64 = mem_cgroup_read_u64,
 	},
 	{
 		.name = "limit_in_bytes",
-		.private = MEMFILE_PRIVATE(_MEM, RES_LIMIT),
+		.private = MEMFILE_PRIVATE(MCT_MEM, RES_LIMIT),
 		.write = mem_cgroup_write,
 		.read_u64 = mem_cgroup_read_u64,
 	},
 	{
 		.name = "soft_limit_in_bytes",
-		.private = MEMFILE_PRIVATE(_MEM, RES_SOFT_LIMIT),
+		.private = MEMFILE_PRIVATE(MCT_MEM, RES_SOFT_LIMIT),
 		.write = mem_cgroup_write,
 		.read_u64 = mem_cgroup_read_u64,
 	},
 	{
 		.name = "failcnt",
-		.private = MEMFILE_PRIVATE(_MEM, RES_FAILCNT),
+		.private = MEMFILE_PRIVATE(MCT_MEM, RES_FAILCNT),
 		.write = mem_cgroup_reset,
 		.read_u64 = mem_cgroup_read_u64,
 	},
@@ -2810,24 +2810,24 @@ struct cftype mem_cgroup_legacy_files[] = {
 #endif
 	{
 		.name = "kmem.limit_in_bytes",
-		.private = MEMFILE_PRIVATE(_KMEM, RES_LIMIT),
+		.private = MEMFILE_PRIVATE(MCT_KMEM, RES_LIMIT),
 		.write = mem_cgroup_write,
 		.read_u64 = mem_cgroup_read_u64,
 	},
 	{
 		.name = "kmem.usage_in_bytes",
-		.private = MEMFILE_PRIVATE(_KMEM, RES_USAGE),
+		.private = MEMFILE_PRIVATE(MCT_KMEM, RES_USAGE),
 		.read_u64 = mem_cgroup_read_u64,
 	},
 	{
 		.name = "kmem.failcnt",
-		.private = MEMFILE_PRIVATE(_KMEM, RES_FAILCNT),
+		.private = MEMFILE_PRIVATE(MCT_KMEM, RES_FAILCNT),
 		.write = mem_cgroup_reset,
 		.read_u64 = mem_cgroup_read_u64,
 	},
 	{
 		.name = "kmem.max_usage_in_bytes",
-		.private = MEMFILE_PRIVATE(_KMEM, RES_MAX_USAGE),
+		.private = MEMFILE_PRIVATE(MCT_KMEM, RES_MAX_USAGE),
 		.write = mem_cgroup_reset,
 		.read_u64 = mem_cgroup_read_u64,
 	},
@@ -2839,24 +2839,24 @@ struct cftype mem_cgroup_legacy_files[] = {
 #endif
 	{
 		.name = "kmem.tcp.limit_in_bytes",
-		.private = MEMFILE_PRIVATE(_TCP, RES_LIMIT),
+		.private = MEMFILE_PRIVATE(MCT_TCPMEM, RES_LIMIT),
 		.write = mem_cgroup_write,
 		.read_u64 = mem_cgroup_read_u64,
 	},
 	{
 		.name = "kmem.tcp.usage_in_bytes",
-		.private = MEMFILE_PRIVATE(_TCP, RES_USAGE),
+		.private = MEMFILE_PRIVATE(MCT_TCPMEM, RES_USAGE),
 		.read_u64 = mem_cgroup_read_u64,
 	},
 	{
 		.name = "kmem.tcp.failcnt",
-		.private = MEMFILE_PRIVATE(_TCP, RES_FAILCNT),
+		.private = MEMFILE_PRIVATE(MCT_TCPMEM, RES_FAILCNT),
 		.write = mem_cgroup_reset,
 		.read_u64 = mem_cgroup_read_u64,
 	},
 	{
 		.name = "kmem.tcp.max_usage_in_bytes",
-		.private = MEMFILE_PRIVATE(_TCP, RES_MAX_USAGE),
+		.private = MEMFILE_PRIVATE(MCT_TCPMEM, RES_MAX_USAGE),
 		.write = mem_cgroup_reset,
 		.read_u64 = mem_cgroup_read_u64,
 	},
@@ -2866,24 +2866,24 @@ struct cftype mem_cgroup_legacy_files[] = {
 struct cftype memsw_files[] = {
 	{
 		.name = "memsw.usage_in_bytes",
-		.private = MEMFILE_PRIVATE(_MEMSWAP, RES_USAGE),
+		.private = MEMFILE_PRIVATE(MCT_MEMSW, RES_USAGE),
 		.read_u64 = mem_cgroup_read_u64,
 	},
 	{
 		.name = "memsw.max_usage_in_bytes",
-		.private = MEMFILE_PRIVATE(_MEMSWAP, RES_MAX_USAGE),
+		.private = MEMFILE_PRIVATE(MCT_MEMSW, RES_MAX_USAGE),
 		.write = mem_cgroup_reset,
 		.read_u64 = mem_cgroup_read_u64,
 	},
 	{
 		.name = "memsw.limit_in_bytes",
-		.private = MEMFILE_PRIVATE(_MEMSWAP, RES_LIMIT),
+		.private = MEMFILE_PRIVATE(MCT_MEMSW, RES_LIMIT),
 		.write = mem_cgroup_write,
 		.read_u64 = mem_cgroup_read_u64,
 	},
 	{
 		.name = "memsw.failcnt",
-		.private = MEMFILE_PRIVATE(_MEMSWAP, RES_FAILCNT),
+		.private = MEMFILE_PRIVATE(MCT_MEMSW, RES_FAILCNT),
 		.write = mem_cgroup_reset,
 		.read_u64 = mem_cgroup_read_u64,
 	},
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 9a4d8205aed5..b2795c0493f8 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -87,14 +87,6 @@ void memcg1_cancel_attach(struct cgroup_taskset *tset);
 void memcg1_move_task(void);
 void memcg1_css_offline(struct mem_cgroup *memcg);
 
-/* for encoding cft->private value on file */
-enum res_type {
-	_MEM,
-	_MEMSWAP,
-	_KMEM,
-	_TCP,
-};
-
 bool memcg1_oom_prepare(struct mem_cgroup *memcg, bool *locked);
 void memcg1_oom_finish(struct mem_cgroup *memcg, bool locked);
 void memcg1_oom_recover(struct mem_cgroup *memcg);
-- 
2.46.0.rc1.232.g9752f9e123-goog


