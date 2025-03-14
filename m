Return-Path: <linux-kernel+bounces-560539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F20EA60659
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 01:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AA6719C592A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 00:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1790CA4B;
	Fri, 14 Mar 2025 00:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ih+O1VUi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F46215D1
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 00:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741910555; cv=none; b=YkpFvO0L/sRT/F86K6xGC6/475epO/KA0zcmpTwAKt00zY95KcqCtKOFbH5JnCbwVEk6SZfKHG94qgpkjttC1Wy9h/SyWf/mLs9LHwqo+DgpfDj8rGfA0nJbRu01SsgXrKmi7KN0TwPVGMZGj5D4ouH/LZFB3+g/ZEtHQE9Ha0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741910555; c=relaxed/simple;
	bh=ddlU3uCWIy0JLBrSjZX2hg33GvWghng0Tcct8/x9G3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C1OSg2hFQCZEHBpLcM9DTz4S0rhy4IMa8RCxAgjIknFwPNOsxjEqbHUGnnWdbjkFKLADa7n/mGuOwsBff0/lr96T30i6hI0w88+JHsR3Sc6QSD3/mc4Tz/N64qb1knU+qLSkQtfTcAJ2x1o85W9bLtRM2ZhpZUfc2zHJzwogx0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ih+O1VUi; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741910555; x=1773446555;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ddlU3uCWIy0JLBrSjZX2hg33GvWghng0Tcct8/x9G3A=;
  b=Ih+O1VUiOD133onVBVlz2pHapEnANLjFlsqZIu/RUUleiogNLUHLt8si
   blvTayLG3H/UrjUiLUVlVj9HpTa29Lzf1wAazEUGZgvA/RiL83JFT5WU1
   fYRcZ0IS7iDtY7UgqQEn9R8pCbioRIa4rCPfH+cs02U+BuDDjw73j6aVT
   4Bz8UI4iwNvI9DEfr6dScNxt7PexarAG1OSXkNGecuATG0crkTUeenoRf
   J95qg8PEsj20emy+Nozw3WQpq954oCmvb2TBFgkvlTlvREtt3tgtC5PIQ
   iy212Ek0ys/z5othjK2pRR9mY+zMzZq0W48sDGQmVDO0/G6qnhPLxSOfu
   g==;
X-CSE-ConnectionGUID: BUAuspKhT1eQSoNF+BINag==
X-CSE-MsgGUID: 3vu0bN18RZGtoLoReX0rLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="43160662"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="43160662"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 17:02:31 -0700
X-CSE-ConnectionGUID: BXq7sXyJSQqwVHR3gmWFjA==
X-CSE-MsgGUID: 58dmASXoSOO+sv1wjzPAMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="125986545"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa003.jf.intel.com with ESMTP; 13 Mar 2025 17:02:31 -0700
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
Subject: [PATCH V9 3/7] perf: attach/detach PMU specific data
Date: Thu, 13 Mar 2025 17:02:38 -0700
Message-Id: <20250314000242.323199-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250314000242.323199-1-kan.liang@linux.intel.com>
References: <20250314000242.323199-1-kan.liang@linux.intel.com>
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

Changes since V8
- Apply guard for rw semaphore and rcu lock

 kernel/events/core.c | 276 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 276 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2e5f0a204484..d2bef9dfe23b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -55,6 +55,7 @@
 #include <linux/pgtable.h>
 #include <linux/buildid.h>
 #include <linux/task_work.h>
+#include <linux/percpu-rwsem.h>
 
 #include "internal.h"
 
@@ -5212,6 +5213,217 @@ static void unaccount_freq_event(void)
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
+	struct task_struct *g, *p;
+	struct perf_ctx_data *cd;
+	int ret;
+
+	if (refcount_inc_not_zero(&global_ctx_data_ref))
+		return 0;
+
+	guard(percpu_write)(&global_ctx_data_rwsem);
+	if (refcount_inc_not_zero(&global_ctx_data_ref))
+		return 0;
+again:
+	/* Allocate everything */
+	scoped_guard (rcu) {
+		for_each_process_thread(g, p) {
+			cd = rcu_dereference(p->perf_ctx_data);
+			if (cd && !cd->global) {
+				cd->global = 1;
+				if (!refcount_inc_not_zero(&cd->refcount))
+					cd = NULL;
+			}
+			if (!cd) {
+				get_task_struct(p);
+				goto alloc;
+			}
+		}
+	}
+
+	refcount_set(&global_ctx_data_ref, 1);
+
+	return 0;
+alloc:
+	ret = attach_task_ctx_data(p, ctx_cache, true);
+	put_task_struct(p);
+	if (ret) {
+		__detach_global_ctx_data();
+		return ret;
+	}
+	goto again;
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
+	scoped_guard (rcu) {
+		cd = rcu_dereference(p->perf_ctx_data);
+		if (!cd || !refcount_dec_and_test(&cd->refcount))
+			return;
+	}
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
+	scoped_guard (rcu) {
+		for_each_process_thread(g, p) {
+			cd = rcu_dereference(p->perf_ctx_data);
+			if (!cd || !cd->global)
+				continue;
+			cd->global = 0;
+			get_task_struct(p);
+			goto detach;
+		}
+	}
+	return;
+detach:
+	detach_task_ctx_data(p);
+	put_task_struct(p);
+	goto again;
+}
+
+static void detach_global_ctx_data(void)
+{
+	if (refcount_dec_not_one(&global_ctx_data_ref))
+		return;
+
+	guard(percpu_write)(&global_ctx_data_rwsem);
+	if (!refcount_dec_and_test(&global_ctx_data_ref))
+		return;
+
+	/* remove everything */
+	__detach_global_ctx_data();
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
@@ -5249,6 +5461,8 @@ static void unaccount_event(struct perf_event *event)
 		atomic_dec(&nr_bpf_events);
 	if (event->attr.text_poke)
 		atomic_dec(&nr_text_poke_events);
+	if (event->attach_state & PERF_ATTACH_TASK_DATA)
+		detach_perf_ctx_data(event);
 
 	if (dec) {
 		if (!atomic_add_unless(&perf_sched_count, -1, 1))
@@ -8598,10 +8812,58 @@ static void perf_event_task(struct task_struct *task,
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
+	scoped_guard (rcu) {
+		cd = rcu_dereference(parent->perf_ctx_data);
+		if (cd)
+			ctx_cache = cd->ctx_cache;
+	}
+
+	if (!ctx_cache)
+		return;
+
+	guard(percpu_read)(&global_ctx_data_rwsem);
+	scoped_guard (rcu) {
+		cd = rcu_dereference(child->perf_ctx_data);
+		if (!cd) {
+			/*
+			 * A system-wide event may be unaccount,
+			 * when attaching the perf_ctx_data.
+			 */
+			if (!refcount_read(&global_ctx_data_ref))
+				return;
+			goto attach;
+		}
+
+		if (!cd->global) {
+			cd->global = 1;
+			refcount_inc(&cd->refcount);
+		}
+	}
+
+	return;
+attach:
+	attach_task_ctx_data(child, ctx_cache, true);
+}
+
 void perf_event_fork(struct task_struct *task)
 {
 	perf_event_task(task, NULL, 1);
 	perf_event_namespaces(task);
+	perf_event_alloc_task_data(task, current);
 }
 
 /*
@@ -12551,6 +12813,14 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	if (err)
 		return ERR_PTR(err);
 
+	if (event->attach_state & PERF_ATTACH_TASK_DATA) {
+		err = attach_perf_ctx_data(event);
+		if (err) {
+			security_perf_event_free(event);
+			return ERR_PTR(err);
+		}
+	}
+
 	/* symmetric to unaccount_event() in _free_event() */
 	account_event(event);
 
@@ -13628,6 +13898,12 @@ void perf_event_exit_task(struct task_struct *child)
 	 * At this point we need to send EXIT events to cpu contexts.
 	 */
 	perf_event_task(child, NULL, 0);
+
+	/*
+	 * Detach the perf_ctx_data for the system-wide event.
+	 */
+	guard(percpu_read)(&global_ctx_data_rwsem);
+	detach_task_ctx_data(child);
 }
 
 static void perf_free_event(struct perf_event *event,
-- 
2.38.1


