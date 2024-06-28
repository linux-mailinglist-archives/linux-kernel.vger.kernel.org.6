Return-Path: <linux-kernel+bounces-234546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 234B691C7C4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46A351C26730
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D487FBDF;
	Fri, 28 Jun 2024 21:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mHSdMIeh"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED5581729
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719608642; cv=none; b=gO3HimJF/MvCcqYZyAdzzzSSXh31rx+r5w/IxCyJzXW3YRGelzh74lsZRiJf2ulRH5XHfxtCu36GgJRlNb76jXshRXui3DdR5ebW+NXcnqsrJKuH2R1bpS+DDcVHs+2mtrGz64/6ZDswjhQYShuuSVVY5uu7Q8epCxTQ8uwQZnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719608642; c=relaxed/simple;
	bh=LFDcnvom4A3harH/oWVHWh8am3iFDSFlyxPORw3NHtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O97ucAgyqSwnZX3VWSJEIJtzYDT5ruMcbe9BZC/f1ZpM2KwUes68XzKkhILTvYSTt9Z2ZMF86X7442FNQEDg9cJ3ndMYu+XbIiq9uO5MVtjTyI/kaIZlHIaptWrkDpumX8EJfaZhpzHAzv86bCd9pK2hzMxWshEzo2A/I8KUX9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mHSdMIeh; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719608639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9l0JWNwiJR4vL4yVXqOBdtMhTUxMdQRWjUtEfPwLXqg=;
	b=mHSdMIehmfU80tUJ13pZQ5VJl08J44pqQFvWQh7HCi0HobI2vAa9le3PXL2LVITuRM7jfV
	ZbPYZXPvjueIrJ5ZFTUtdCNBYN0/RQ7nwmOF7mYOr06/IRW9+FAPlz3QzGyQ6PGml9o/HS
	9EKtVQoUKle2Fb8KcYURkjqecYYRsic=
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
Subject: [PATCH v1 6/9] mm: memcg: put memcg1-specific struct mem_cgroup's members under CONFIG_MEMCG_V1
Date: Fri, 28 Jun 2024 21:03:14 +0000
Message-ID: <20240628210317.272856-7-roman.gushchin@linux.dev>
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

Put memcg1-specific members of struct mem_cgroup under the
CONFIG_MEMCG_V1 config option. Also group them close to the end
of struct mem_cgroup just before the dynamic per-node part.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/memcontrol.h | 103 +++++++++++++++++++------------------
 1 file changed, 53 insertions(+), 50 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 44ab6394c9ed..107b0c5d6eab 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -188,10 +188,6 @@ struct mem_cgroup {
 		struct page_counter memsw;	/* v1 only */
 	};
 
-	/* Legacy consumer-oriented counters */
-	struct page_counter kmem;		/* v1 only */
-	struct page_counter tcpmem;		/* v1 only */
-
 	/* Range enforcement for interrupt charges */
 	struct work_struct high_work;
 
@@ -205,8 +201,6 @@ struct mem_cgroup {
 	bool zswap_writeback;
 #endif
 
-	unsigned long soft_limit;
-
 	/* vmpressure notifications */
 	struct vmpressure vmpressure;
 
@@ -215,13 +209,7 @@ struct mem_cgroup {
 	 */
 	bool oom_group;
 
-	/* protected by memcg_oom_lock */
-	bool		oom_lock;
-	int		under_oom;
-
-	int	swappiness;
-	/* OOM-Killer disable */
-	int		oom_kill_disable;
+	int swappiness;
 
 	/* memory.events and memory.events.local */
 	struct cgroup_file events_file;
@@ -230,27 +218,6 @@ struct mem_cgroup {
 	/* handle for "memory.swap.events" */
 	struct cgroup_file swap_events_file;
 
-	/* protect arrays of thresholds */
-	struct mutex thresholds_lock;
-
-	/* thresholds for memory usage. RCU-protected */
-	struct mem_cgroup_thresholds thresholds;
-
-	/* thresholds for mem+swap usage. RCU-protected */
-	struct mem_cgroup_thresholds memsw_thresholds;
-
-	/* For oom notifier event fd */
-	struct list_head oom_notify;
-
-	/*
-	 * Should we move charges of a task when a task is moved into this
-	 * mem_cgroup ? And what type of charges should we move ?
-	 */
-	unsigned long move_charge_at_immigrate;
-	/* taken only while moving_account > 0 */
-	spinlock_t		move_lock;
-	unsigned long		move_lock_flags;
-
 	CACHELINE_PADDING(_pad1_);
 
 	/* memory.stat */
@@ -267,10 +234,6 @@ struct mem_cgroup {
 	 */
 	unsigned long		socket_pressure;
 
-	/* Legacy tcp memory accounting */
-	bool			tcpmem_active;
-	int			tcpmem_pressure;
-
 #ifdef CONFIG_MEMCG_KMEM
 	int kmemcg_id;
 	/*
@@ -284,14 +247,6 @@ struct mem_cgroup {
 	struct list_head objcg_list;
 #endif
 
-	CACHELINE_PADDING(_pad2_);
-
-	/*
-	 * set > 0 if pages under this cgroup are moving to other cgroup.
-	 */
-	atomic_t		moving_account;
-	struct task_struct	*move_lock_task;
-
 	struct memcg_vmstats_percpu __percpu *vmstats_percpu;
 
 #ifdef CONFIG_CGROUP_WRITEBACK
@@ -300,10 +255,6 @@ struct mem_cgroup {
 	struct memcg_cgwb_frn cgwb_frn[MEMCG_CGWB_FRN_CNT];
 #endif
 
-	/* List of events which userspace want to receive */
-	struct list_head event_list;
-	spinlock_t event_list_lock;
-
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	struct deferred_split deferred_split_queue;
 #endif
@@ -313,6 +264,58 @@ struct mem_cgroup {
 	struct lru_gen_mm_list mm_list;
 #endif
 
+#ifdef CONFIG_MEMCG_V1
+	/* Legacy consumer-oriented counters */
+	struct page_counter kmem;		/* v1 only */
+	struct page_counter tcpmem;		/* v1 only */
+
+	unsigned long soft_limit;
+
+	/* protected by memcg_oom_lock */
+	bool oom_lock;
+	int under_oom;
+
+	/* OOM-Killer disable */
+	int oom_kill_disable;
+
+	/* protect arrays of thresholds */
+	struct mutex thresholds_lock;
+
+	/* thresholds for memory usage. RCU-protected */
+	struct mem_cgroup_thresholds thresholds;
+
+	/* thresholds for mem+swap usage. RCU-protected */
+	struct mem_cgroup_thresholds memsw_thresholds;
+
+	/* For oom notifier event fd */
+	struct list_head oom_notify;
+
+	/*
+	 * Should we move charges of a task when a task is moved into this
+	 * mem_cgroup ? And what type of charges should we move ?
+	 */
+	unsigned long move_charge_at_immigrate;
+	/* taken only while moving_account > 0 */
+	spinlock_t move_lock;
+	unsigned long move_lock_flags;
+
+	/* Legacy tcp memory accounting */
+	bool tcpmem_active;
+	int tcpmem_pressure;
+
+	CACHELINE_PADDING(_pad2_);
+
+	/*
+	 * set > 0 if pages under this cgroup are moving to other cgroup.
+	 */
+	atomic_t moving_account;
+	struct task_struct *move_lock_task;
+
+	/* List of events which userspace want to receive */
+	struct list_head event_list;
+	spinlock_t event_list_lock;
+#endif /* CONFIG_MEMCG_V1 */
+
 	struct mem_cgroup_per_node *nodeinfo[];
 };
 
-- 
2.45.2.803.g4e1b14247a-goog


