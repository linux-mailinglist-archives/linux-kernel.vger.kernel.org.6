Return-Path: <linux-kernel+bounces-557755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F20EA5DD47
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ACAE1773E2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8034245017;
	Wed, 12 Mar 2025 13:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PtFkb0KY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9C02E401
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 13:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741784655; cv=none; b=WvkRCo7WeQ36utsXm+VFAnNCgyKMVRcB/TY1UqEYRHxgIXB7NwZ68Hc5puj8QdweRt6P2X11Yo+OunuuW/8r6wtlKZbEqj3s6/L0HZ+RJ9Ry7/xhQqQA3P4Hz52hRpuaS4Eohyh6tuuwXIKiu+lcVSlLd6o+mCZAdVaionTswLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741784655; c=relaxed/simple;
	bh=cObaZzr2CxM6tbdDgGthqP/pV1wY2mPaL6snGQGs99I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XdcW3aoG7S2ixhYVM5st+fQwCh/ac7d/O1+Efk2nlk+3szJzZ2fSvCeSgydF+F3WvVgbVWP+IUh1M+nxKqIxg18A44XKbm6UPgk8uv0ONmFPbW8Z9mwOPRdQuwk/vl5sZxjDTAPxTr+PkUWuCBzUnXUrHdFVozFZdpzRtnea9p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PtFkb0KY; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741784654; x=1773320654;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cObaZzr2CxM6tbdDgGthqP/pV1wY2mPaL6snGQGs99I=;
  b=PtFkb0KYQV1NhIDiMtauIrBleSHMDdyW0lqRqM+J79PQIlVMDK1Fxywc
   9lJLHF9Rymg7rHOJTun6p+jCPvMy7Z6Iwun1YLSlUIYvqh0R+ZtbjJmAb
   ZO1FGaPf/AVFYjLHaSWBUXJCRZFrZmVNCkgu4DXODBZ3g7HPDHBMnxHJt
   e3SmE3mwtcrLpbIs/r6Xbhb+T1d2Cl2n+Sr29x1lASaRrYZI54pAwdBM5
   MhLSHrw4q8uuJALPQZKBQYsDpAsGcU1lbF71Zp1jcL8vratN2yXO6/Gf1
   FA7rmoU0X/v2CUdv+xJtHH6atJl90Ae2TuHjfQiv+1IinuZeo36o/YrsU
   w==;
X-CSE-ConnectionGUID: t3nW6N2nRIyxxrRvKSr52A==
X-CSE-MsgGUID: nfYCYZAOR8WUolg1P69wtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="43064974"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="43064974"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 06:04:12 -0700
X-CSE-ConnectionGUID: MdKcI7FgQxiUmyoEsvoibA==
X-CSE-MsgGUID: 28HoE0vOQPerT7hGWrmf2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="120650304"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa007.fm.intel.com with ESMTP; 12 Mar 2025 06:04:12 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	tglx@linutronix.de,
	bp@alien8.de,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	linux-kernel@vger.kernel.org
Cc: ak@linux.intel.com,
	eranian@google.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V7 2/6] perf: attach/detach PMU specific data
Date: Wed, 12 Mar 2025 06:04:20 -0700
Message-Id: <20250312130424.3863916-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250312130424.3863916-1-kan.liang@linux.intel.com>
References: <20250312130424.3863916-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The LBR call stack data has to be saved/restored during context switch
to fix the shorter LBRs call stacks issue in the  system-wide mode.
Allocate PMU specific data and attach them to the corresponding
task_struct during LBR call stack monitoring.

When a LBR call stack event is accounted, the perf_ctx_data for the
related tasks will be allocated/attached by attach_perf_ctx_data().
When a LBR call stack event is unaccounted, the perf_ctx_data for
related tasks will be detached/freed by detach_perf_ctx_data().

The LBR call stack event could be a per-task event or a system-wide
event.
- For a per-task event, perf only allocates the perf_ctx_data for the
  current task. If the allocation fails, perf will error out.
- For a system-wide event, perf has to allocate the perf_ctx_data for
  both the existing tasks and the upcoming tasks.
  The allocation for the existing tasks is done in perf_event_alloc().
  If any allocation fails, perf will error out.
  The allocation for the new tasks will be done in perf_event_fork().
  A global reader/writer semaphore, global_ctx_data_rwsem, is added to
  address the global race.
- The perf_ctx_data only be freed by the last LBR call stack event.
  The number of the per-task events is tracked by refcount of each task.
  Since the system-wide events impact all tasks, it's not practical to
  go through the whole task list to update the refcount for each
  system-wide event. The number of system-wide events is tracked by a
  global variable global_ctx_data_ref.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 kernel/events/core.c | 284 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 284 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index ffa5d848890e..58bb46dce0ce 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -55,6 +55,7 @@
 #include <linux/pgtable.h>
 #include <linux/buildid.h>
 #include <linux/task_work.h>
+#include <linux/percpu-rwsem.h>
 
 #include "internal.h"
 
@@ -5143,6 +5144,222 @@ static void unaccount_freq_event(void)
 		atomic_dec(&nr_freq_events);
 }
 
+
+static struct perf_ctx_data *
+alloc_perf_ctx_data(struct kmem_cache *ctx_cache, bool global)
+{
+	struct perf_ctx_data *cd;
+
+	cd = kzalloc(sizeof(*cd), GFP_KERNEL);
+	if (!cd)
+		return NULL;
+
+	cd->data = kmem_cache_zalloc(ctx_cache, GFP_KERNEL);
+	if (!cd->data) {
+		kfree(cd);
+		return NULL;
+	}
+
+	cd->global = global;
+	cd->ctx_cache = ctx_cache;
+	refcount_set(&cd->refcount, 1);
+
+	return cd;
+}
+
+static void free_perf_ctx_data(struct perf_ctx_data *cd)
+{
+	kmem_cache_free(cd->ctx_cache, cd->data);
+	kfree(cd);
+}
+
+static void __free_perf_ctx_data_rcu(struct rcu_head *rcu_head)
+{
+	struct perf_ctx_data *cd;
+
+	cd = container_of(rcu_head, struct perf_ctx_data, rcu_head);
+	free_perf_ctx_data(cd);
+}
+
+static inline void perf_free_ctx_data_rcu(struct perf_ctx_data *cd)
+{
+	call_rcu(&cd->rcu_head, __free_perf_ctx_data_rcu);
+}
+
+static int
+attach_task_ctx_data(struct task_struct *task, struct kmem_cache *ctx_cache,
+		     bool global)
+{
+	struct perf_ctx_data *cd, *old = NULL;
+
+	cd = alloc_perf_ctx_data(ctx_cache, global);
+	if (!cd)
+		return -ENOMEM;
+
+	for (;;) {
+		if (try_cmpxchg((struct perf_ctx_data **)&task->perf_ctx_data, &old, cd)) {
+			if (old)
+				perf_free_ctx_data_rcu(old);
+			return 0;
+		}
+
+		if (!old) {
+			/*
+			 * After seeing a dead @old, we raced with
+			 * removal and lost, try again to install @cd.
+			 */
+			continue;
+		}
+
+		if (refcount_inc_not_zero(&old->refcount)) {
+			free_perf_ctx_data(cd); /* unused */
+			return 0;
+		}
+
+		/*
+		 * @old is a dead object, refcount==0 is stable, try and
+		 * replace it with @cd.
+		 */
+	}
+	return 0;
+}
+
+static void __detach_global_ctx_data(void);
+DEFINE_STATIC_PERCPU_RWSEM(global_ctx_data_rwsem);
+static refcount_t global_ctx_data_ref;
+
+static int
+attach_global_ctx_data(struct kmem_cache *ctx_cache)
+{
+	if (refcount_inc_not_zero(&global_ctx_data_ref))
+		return 0;
+
+	percpu_down_write(&global_ctx_data_rwsem);
+	if (!refcount_inc_not_zero(&global_ctx_data_ref)) {
+		struct task_struct *g, *p;
+		struct perf_ctx_data *cd;
+		int ret;
+
+again:
+		/* Allocate everything */
+		rcu_read_lock();
+		for_each_process_thread(g, p) {
+			cd = rcu_dereference(p->perf_ctx_data);
+			if (cd && !cd->global) {
+				cd->global = 1;
+				if (!refcount_inc_not_zero(&cd->refcount))
+					cd = NULL;
+			}
+			if (!cd) {
+				get_task_struct(p);
+				rcu_read_unlock();
+
+				ret = attach_task_ctx_data(p, ctx_cache, true);
+				put_task_struct(p);
+				if (ret) {
+					__detach_global_ctx_data();
+					return ret;
+				}
+				goto again;
+			}
+		}
+		rcu_read_unlock();
+
+		refcount_set(&global_ctx_data_ref, 1);
+	}
+	percpu_up_write(&global_ctx_data_rwsem);
+
+	return 0;
+}
+
+static int
+attach_perf_ctx_data(struct perf_event *event)
+{
+	struct task_struct *task = event->hw.target;
+	struct kmem_cache *ctx_cache = event->pmu->task_ctx_cache;
+
+	if (!ctx_cache)
+		return -ENOMEM;
+
+	if (task)
+		return attach_task_ctx_data(task, ctx_cache, false);
+	else
+		return attach_global_ctx_data(ctx_cache);
+}
+
+static void
+detach_task_ctx_data(struct task_struct *p)
+{
+	struct perf_ctx_data *cd;
+
+	rcu_read_lock();
+	cd = rcu_dereference(p->perf_ctx_data);
+	if (!cd || !refcount_dec_and_test(&cd->refcount)) {
+		rcu_read_unlock();
+		return;
+	}
+	rcu_read_unlock();
+
+	/*
+	 * The old ctx_data may be lost because of the race.
+	 * Nothing is required to do for the case.
+	 * See attach_task_ctx_data().
+	 */
+	if (try_cmpxchg((struct perf_ctx_data **)&p->perf_ctx_data, &cd, NULL))
+		perf_free_ctx_data_rcu(cd);
+}
+
+static void __detach_global_ctx_data(void)
+{
+	struct task_struct *g, *p;
+	struct perf_ctx_data *cd;
+
+again:
+	rcu_read_lock();
+	for_each_process_thread(g, p) {
+		cd = rcu_dereference(p->perf_ctx_data);
+		if (!cd || !cd->global)
+			continue;
+		cd->global = 0;
+		get_task_struct(p);
+		rcu_read_unlock();
+
+		detach_task_ctx_data(p);
+		put_task_struct(p);
+		goto again;
+	}
+	rcu_read_unlock();
+}
+
+static void detach_global_ctx_data(void)
+{
+	if (refcount_dec_not_one(&global_ctx_data_ref))
+		return;
+
+	percpu_down_write(&global_ctx_data_rwsem);
+	if (!refcount_dec_and_test(&global_ctx_data_ref))
+		goto unlock;
+
+	/* remove everything */
+	__detach_global_ctx_data();
+
+unlock:
+	percpu_up_write(&global_ctx_data_rwsem);
+}
+
+static void detach_perf_ctx_data(struct perf_event *event)
+{
+	struct task_struct *task = event->hw.target;
+
+	if (!event->pmu->task_ctx_cache)
+		return;
+
+	if (task)
+		detach_task_ctx_data(task);
+	else
+		detach_global_ctx_data();
+}
+
 static void unaccount_event(struct perf_event *event)
 {
 	bool dec = false;
@@ -5180,6 +5397,8 @@ static void unaccount_event(struct perf_event *event)
 		atomic_dec(&nr_bpf_events);
 	if (event->attr.text_poke)
 		atomic_dec(&nr_text_poke_events);
+	if (event->attach_state & PERF_ATTACH_TASK_DATA)
+		detach_perf_ctx_data(event);
 
 	if (dec) {
 		if (!atomic_add_unless(&perf_sched_count, -1, 1))
@@ -8513,10 +8732,62 @@ static void perf_event_task(struct task_struct *task,
 		       task_ctx);
 }
 
+/*
+ * Allocate data for a new task when profiling system-wide
+ * events which require PMU specific data
+ */
+static void
+perf_event_alloc_task_data(struct task_struct *child,
+			   struct task_struct *parent)
+{
+	struct kmem_cache *ctx_cache = NULL;
+	struct perf_ctx_data *cd;
+
+	if (!refcount_read(&global_ctx_data_ref))
+		return;
+
+	rcu_read_lock();
+	cd = rcu_dereference(parent->perf_ctx_data);
+	if (cd)
+		ctx_cache = cd->ctx_cache;
+	rcu_read_unlock();
+
+	if (!ctx_cache)
+		return;
+
+	percpu_down_read(&global_ctx_data_rwsem);
+
+	rcu_read_lock();
+	cd = rcu_dereference(child->perf_ctx_data);
+
+	if (!cd) {
+		/*
+		 * A system-wide event may be unaccount,
+		 * when attaching the perf_ctx_data.
+		 */
+		if (!refcount_read(&global_ctx_data_ref))
+			goto rcu_unlock;
+		rcu_read_unlock();
+		attach_task_ctx_data(child, ctx_cache, true);
+		goto up_rwsem;
+	}
+
+	if (!cd->global) {
+		cd->global = 1;
+		refcount_inc(&cd->refcount);
+	}
+
+rcu_unlock:
+	rcu_read_unlock();
+up_rwsem:
+	percpu_up_read(&global_ctx_data_rwsem);
+}
+
 void perf_event_fork(struct task_struct *task)
 {
 	perf_event_task(task, NULL, 1);
 	perf_event_namespaces(task);
+	perf_event_alloc_task_data(task, current);
 }
 
 /*
@@ -12435,11 +12706,17 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	if (err)
 		goto err_callchain_buffer;
 
+	if ((event->attach_state & PERF_ATTACH_TASK_DATA) &&
+	    attach_perf_ctx_data(event))
+		goto err_task_ctx_data;
+
 	/* symmetric to unaccount_event() in _free_event() */
 	account_event(event);
 
 	return event;
 
+err_task_ctx_data:
+	security_perf_event_free(event);
 err_callchain_buffer:
 	if (!event->parent) {
 		if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
@@ -13536,6 +13813,13 @@ void perf_event_exit_task(struct task_struct *child)
 	 * At this point we need to send EXIT events to cpu contexts.
 	 */
 	perf_event_task(child, NULL, 0);
+
+	/*
+	 * Detach the perf_ctx_data for the system-wide event.
+	 */
+	percpu_down_read(&global_ctx_data_rwsem);
+	detach_task_ctx_data(child);
+	percpu_up_read(&global_ctx_data_rwsem);
 }
 
 static void perf_free_event(struct perf_event *event,
-- 
2.38.1


