Return-Path: <linux-kernel+bounces-174105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A048C0A41
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 05:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C78F21C21CAD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 03:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058B0148839;
	Thu,  9 May 2024 03:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SpAzl1dV"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466641487E1
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 03:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715226149; cv=none; b=Va6RVZf6lPWQUcOLRsceO8pX4aFc4XjaKBiW0fLx8+cx0iNci6vUuvo1CTs5eGw2NSOLpYNHWe+F/FGbDyMD3IMk/i5iAIzeGhjSS6apI4dZ65fERsAdDq0kkrW0cyBttiuk89ocoemnDHrNQlpPsdpHoMYqsYjtDRKngTeteZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715226149; c=relaxed/simple;
	bh=bTyF+t9QjpdTL+BbqNoUvznJ1O9ci4mnQXMAicSZ+AU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=egPbximVutyEblG0YgGhxOzekxEJEwj4OntFuOZIMwMICoMzIdNDuX1t+etQ7y/wcZsB6mSUNLRuOVrmXHvCMMuPXrUuiomF1y2iojTVB3yXxS1lKuH5BuayixQ9eP0wHE5iMjOpazLRSzX2CEvbm1bLrE+sXgfLCC5iiU0YG2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SpAzl1dV; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715226142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FahYJsnGNMAVOqpqAKoouEmDf+g2I+jBcjHL24grq/o=;
	b=SpAzl1dVlTr/zB9ErJ8MLvGOYTSgQJTkA6MR+Q4IlMLYIQt/NHGlapbqKAiEMT76kZwn5A
	Hkj+wiRs5wOQDcAs5Kyvnlv/R/uJnemJSmwPqQBG6YLs0K/92PCVv7wvlpZZgtOMGWXqA5
	wyooAIWNgnJz/Z2m2GTMnyDb+jyYlvs=
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
Subject: [PATCH rfc 6/9] mm: memcg: move cgroup v1 oom handling code into memcontrol-v1.c
Date: Wed,  8 May 2024 20:41:35 -0700
Message-ID: <20240509034138.2207186-7-roman.gushchin@linux.dev>
In-Reply-To: <20240509034138.2207186-1-roman.gushchin@linux.dev>
References: <20240509034138.2207186-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Cgroup v1 supported a complicated OOM handling mechanism in userspace,
which is not supported by cgroup v2. Let's move the corresponding code
into memcontrol-v1.c.

Aside from mechanical code movement this patch introduces two new
functions: mem_cgroup_v1_oom_prepare() and mem_cgroup_v1_oom_finish().
Those are implementing cgroup v1-specific parts of the common memcg
OOM handling path.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/internal.h      |   4 +-
 mm/memcontrol-v1.c | 229 +++++++++++++++++++++++++++++++++++++++++++++
 mm/memcontrol.c    | 220 +------------------------------------------
 3 files changed, 234 insertions(+), 219 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 533aa999a450..1b94e2169e19 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1614,8 +1614,10 @@ enum res_type {
 };
 
 void memcg_check_events(struct mem_cgroup *memcg, int nid);
-void mem_cgroup_oom_notify(struct mem_cgroup *memcg);
 void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s);
+bool mem_cgroup_v1_oom_prepare(struct mem_cgroup *memcg, gfp_t mask, int order,
+			       bool *locked);
+void mem_cgroup_v1_oom_finish(struct mem_cgroup *memcg, bool *locked);
 void mem_cgroup_v1_offline_memcg(struct mem_cgroup *memcg);
 
 extern struct cftype memsw_files[];
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index cd711f6b8386..15356bbbc058 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -2675,6 +2675,235 @@ struct cftype memsw_files[] = {
 	{ },	/* terminate */
 };
 
+#ifdef CONFIG_LOCKDEP
+static struct lockdep_map memcg_oom_lock_dep_map = {
+	.name = "memcg_oom_lock",
+};
+#endif
+
+DEFINE_SPINLOCK(memcg_oom_lock);
+
+/*
+ * Check OOM-Killer is already running under our hierarchy.
+ * If someone is running, return false.
+ */
+static bool mem_cgroup_oom_trylock(struct mem_cgroup *memcg)
+{
+	struct mem_cgroup *iter, *failed = NULL;
+
+	spin_lock(&memcg_oom_lock);
+
+	for_each_mem_cgroup_tree(iter, memcg) {
+		if (iter->oom_lock) {
+			/*
+			 * this subtree of our hierarchy is already locked
+			 * so we cannot give a lock.
+			 */
+			failed = iter;
+			mem_cgroup_iter_break(memcg, iter);
+			break;
+		} else
+			iter->oom_lock = true;
+	}
+
+	if (failed) {
+		/*
+		 * OK, we failed to lock the whole subtree so we have
+		 * to clean up what we set up to the failing subtree
+		 */
+		for_each_mem_cgroup_tree(iter, memcg) {
+			if (iter == failed) {
+				mem_cgroup_iter_break(memcg, iter);
+				break;
+			}
+			iter->oom_lock = false;
+		}
+	} else
+		mutex_acquire(&memcg_oom_lock_dep_map, 0, 1, _RET_IP_);
+
+	spin_unlock(&memcg_oom_lock);
+
+	return !failed;
+}
+
+static void mem_cgroup_oom_unlock(struct mem_cgroup *memcg)
+{
+	struct mem_cgroup *iter;
+
+	spin_lock(&memcg_oom_lock);
+	mutex_release(&memcg_oom_lock_dep_map, _RET_IP_);
+	for_each_mem_cgroup_tree(iter, memcg)
+		iter->oom_lock = false;
+	spin_unlock(&memcg_oom_lock);
+}
+
+static void mem_cgroup_mark_under_oom(struct mem_cgroup *memcg)
+{
+	struct mem_cgroup *iter;
+
+	spin_lock(&memcg_oom_lock);
+	for_each_mem_cgroup_tree(iter, memcg)
+		iter->under_oom++;
+	spin_unlock(&memcg_oom_lock);
+}
+
+static void mem_cgroup_unmark_under_oom(struct mem_cgroup *memcg)
+{
+	struct mem_cgroup *iter;
+
+	/*
+	 * Be careful about under_oom underflows because a child memcg
+	 * could have been added after mem_cgroup_mark_under_oom.
+	 */
+	spin_lock(&memcg_oom_lock);
+	for_each_mem_cgroup_tree(iter, memcg)
+		if (iter->under_oom > 0)
+			iter->under_oom--;
+	spin_unlock(&memcg_oom_lock);
+}
+
+bool mem_cgroup_v1_oom_prepare(struct mem_cgroup *memcg, gfp_t mask, int order,
+			       bool *locked)
+{
+	/*
+	 * We are in the middle of the charge context here, so we
+	 * don't want to block when potentially sitting on a callstack
+	 * that holds all kinds of filesystem and mm locks.
+	 *
+	 * cgroup1 allows disabling the OOM killer and waiting for outside
+	 * handling until the charge can succeed; remember the context and put
+	 * the task to sleep at the end of the page fault when all locks are
+	 * released.
+	 *
+	 * On the other hand, in-kernel OOM killer allows for an async victim
+	 * memory reclaim (oom_reaper) and that means that we are not solely
+	 * relying on the oom victim to make a forward progress and we can
+	 * invoke the oom killer here.
+	 *
+	 * Please note that mem_cgroup_out_of_memory might fail to find a
+	 * victim and then we have to bail out from the charge path.
+	 */
+	if (READ_ONCE(memcg->oom_kill_disable)) {
+		if (current->in_user_fault) {
+			css_get(&memcg->css);
+			current->memcg_in_oom = memcg;
+			current->memcg_oom_gfp_mask = mask;
+			current->memcg_oom_order = order;
+		}
+		return false;
+	}
+
+	mem_cgroup_mark_under_oom(memcg);
+
+	*locked = mem_cgroup_oom_trylock(memcg);
+
+	if (*locked)
+		mem_cgroup_oom_notify(memcg);
+
+	mem_cgroup_unmark_under_oom(memcg);
+
+	return true;
+}
+
+void mem_cgroup_v1_oom_finish(struct mem_cgroup *memcg, bool *locked)
+{
+	if (*locked)
+		mem_cgroup_oom_unlock(memcg);
+}
+
+static DECLARE_WAIT_QUEUE_HEAD(memcg_oom_waitq);
+
+struct oom_wait_info {
+	struct mem_cgroup *memcg;
+	wait_queue_entry_t	wait;
+};
+
+static int memcg_oom_wake_function(wait_queue_entry_t *wait,
+	unsigned mode, int sync, void *arg)
+{
+	struct mem_cgroup *wake_memcg = (struct mem_cgroup *)arg;
+	struct mem_cgroup *oom_wait_memcg;
+	struct oom_wait_info *oom_wait_info;
+
+	oom_wait_info = container_of(wait, struct oom_wait_info, wait);
+	oom_wait_memcg = oom_wait_info->memcg;
+
+	if (!mem_cgroup_is_descendant(wake_memcg, oom_wait_memcg) &&
+	    !mem_cgroup_is_descendant(oom_wait_memcg, wake_memcg))
+		return 0;
+	return autoremove_wake_function(wait, mode, sync, arg);
+}
+
+void memcg_oom_recover(struct mem_cgroup *memcg)
+{
+	/*
+	 * For the following lockless ->under_oom test, the only required
+	 * guarantee is that it must see the state asserted by an OOM when
+	 * this function is called as a result of userland actions
+	 * triggered by the notification of the OOM.  This is trivially
+	 * achieved by invoking mem_cgroup_mark_under_oom() before
+	 * triggering notification.
+	 */
+	if (memcg && memcg->under_oom)
+		__wake_up(&memcg_oom_waitq, TASK_NORMAL, 0, memcg);
+}
+
+/**
+ * mem_cgroup_oom_synchronize - complete memcg OOM handling
+ * @handle: actually kill/wait or just clean up the OOM state
+ *
+ * This has to be called at the end of a page fault if the memcg OOM
+ * handler was enabled.
+ *
+ * Memcg supports userspace OOM handling where failed allocations must
+ * sleep on a waitqueue until the userspace task resolves the
+ * situation.  Sleeping directly in the charge context with all kinds
+ * of locks held is not a good idea, instead we remember an OOM state
+ * in the task and mem_cgroup_oom_synchronize() has to be called at
+ * the end of the page fault to complete the OOM handling.
+ *
+ * Returns %true if an ongoing memcg OOM situation was detected and
+ * completed, %false otherwise.
+ */
+bool mem_cgroup_oom_synchronize(bool handle)
+{
+	struct mem_cgroup *memcg = current->memcg_in_oom;
+	struct oom_wait_info owait;
+	bool locked;
+
+	/* OOM is global, do not handle */
+	if (!memcg)
+		return false;
+
+	if (!handle)
+		goto cleanup;
+
+	owait.memcg = memcg;
+	owait.wait.flags = 0;
+	owait.wait.func = memcg_oom_wake_function;
+	owait.wait.private = current;
+	INIT_LIST_HEAD(&owait.wait.entry);
+
+	prepare_to_wait(&memcg_oom_waitq, &owait.wait, TASK_KILLABLE);
+	mem_cgroup_mark_under_oom(memcg);
+
+	locked = mem_cgroup_oom_trylock(memcg);
+
+	if (locked)
+		mem_cgroup_oom_notify(memcg);
+
+	schedule();
+	mem_cgroup_unmark_under_oom(memcg);
+	finish_wait(&memcg_oom_waitq, &owait.wait);
+
+	if (locked)
+		mem_cgroup_oom_unlock(memcg);
+cleanup:
+	current->memcg_in_oom = NULL;
+	css_put(&memcg->css);
+	return true;
+}
+
 void mem_cgroup_v1_offline_memcg(struct mem_cgroup *memcg)
 {
 	struct mem_cgroup_event *event, *tmp;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index cd7e5f67d9b5..805efc98ae12 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1610,130 +1610,6 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	return ret;
 }
 
-#ifdef CONFIG_LOCKDEP
-static struct lockdep_map memcg_oom_lock_dep_map = {
-	.name = "memcg_oom_lock",
-};
-#endif
-
-DEFINE_SPINLOCK(memcg_oom_lock);
-
-/*
- * Check OOM-Killer is already running under our hierarchy.
- * If someone is running, return false.
- */
-static bool mem_cgroup_oom_trylock(struct mem_cgroup *memcg)
-{
-	struct mem_cgroup *iter, *failed = NULL;
-
-	spin_lock(&memcg_oom_lock);
-
-	for_each_mem_cgroup_tree(iter, memcg) {
-		if (iter->oom_lock) {
-			/*
-			 * this subtree of our hierarchy is already locked
-			 * so we cannot give a lock.
-			 */
-			failed = iter;
-			mem_cgroup_iter_break(memcg, iter);
-			break;
-		} else
-			iter->oom_lock = true;
-	}
-
-	if (failed) {
-		/*
-		 * OK, we failed to lock the whole subtree so we have
-		 * to clean up what we set up to the failing subtree
-		 */
-		for_each_mem_cgroup_tree(iter, memcg) {
-			if (iter == failed) {
-				mem_cgroup_iter_break(memcg, iter);
-				break;
-			}
-			iter->oom_lock = false;
-		}
-	} else
-		mutex_acquire(&memcg_oom_lock_dep_map, 0, 1, _RET_IP_);
-
-	spin_unlock(&memcg_oom_lock);
-
-	return !failed;
-}
-
-static void mem_cgroup_oom_unlock(struct mem_cgroup *memcg)
-{
-	struct mem_cgroup *iter;
-
-	spin_lock(&memcg_oom_lock);
-	mutex_release(&memcg_oom_lock_dep_map, _RET_IP_);
-	for_each_mem_cgroup_tree(iter, memcg)
-		iter->oom_lock = false;
-	spin_unlock(&memcg_oom_lock);
-}
-
-static void mem_cgroup_mark_under_oom(struct mem_cgroup *memcg)
-{
-	struct mem_cgroup *iter;
-
-	spin_lock(&memcg_oom_lock);
-	for_each_mem_cgroup_tree(iter, memcg)
-		iter->under_oom++;
-	spin_unlock(&memcg_oom_lock);
-}
-
-static void mem_cgroup_unmark_under_oom(struct mem_cgroup *memcg)
-{
-	struct mem_cgroup *iter;
-
-	/*
-	 * Be careful about under_oom underflows because a child memcg
-	 * could have been added after mem_cgroup_mark_under_oom.
-	 */
-	spin_lock(&memcg_oom_lock);
-	for_each_mem_cgroup_tree(iter, memcg)
-		if (iter->under_oom > 0)
-			iter->under_oom--;
-	spin_unlock(&memcg_oom_lock);
-}
-
-static DECLARE_WAIT_QUEUE_HEAD(memcg_oom_waitq);
-
-struct oom_wait_info {
-	struct mem_cgroup *memcg;
-	wait_queue_entry_t	wait;
-};
-
-static int memcg_oom_wake_function(wait_queue_entry_t *wait,
-	unsigned mode, int sync, void *arg)
-{
-	struct mem_cgroup *wake_memcg = (struct mem_cgroup *)arg;
-	struct mem_cgroup *oom_wait_memcg;
-	struct oom_wait_info *oom_wait_info;
-
-	oom_wait_info = container_of(wait, struct oom_wait_info, wait);
-	oom_wait_memcg = oom_wait_info->memcg;
-
-	if (!mem_cgroup_is_descendant(wake_memcg, oom_wait_memcg) &&
-	    !mem_cgroup_is_descendant(oom_wait_memcg, wake_memcg))
-		return 0;
-	return autoremove_wake_function(wait, mode, sync, arg);
-}
-
-void memcg_oom_recover(struct mem_cgroup *memcg)
-{
-	/*
-	 * For the following lockless ->under_oom test, the only required
-	 * guarantee is that it must see the state asserted by an OOM when
-	 * this function is called as a result of userland actions
-	 * triggered by the notification of the OOM.  This is trivially
-	 * achieved by invoking mem_cgroup_mark_under_oom() before
-	 * triggering notification.
-	 */
-	if (memcg && memcg->under_oom)
-		__wake_up(&memcg_oom_waitq, TASK_NORMAL, 0, memcg);
-}
-
 /*
  * Returns true if successfully killed one or more processes. Though in some
  * corner cases it can return true even without killing any process.
@@ -1747,106 +1623,14 @@ static bool mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int order)
 
 	memcg_memory_event(memcg, MEMCG_OOM);
 
-	/*
-	 * We are in the middle of the charge context here, so we
-	 * don't want to block when potentially sitting on a callstack
-	 * that holds all kinds of filesystem and mm locks.
-	 *
-	 * cgroup1 allows disabling the OOM killer and waiting for outside
-	 * handling until the charge can succeed; remember the context and put
-	 * the task to sleep at the end of the page fault when all locks are
-	 * released.
-	 *
-	 * On the other hand, in-kernel OOM killer allows for an async victim
-	 * memory reclaim (oom_reaper) and that means that we are not solely
-	 * relying on the oom victim to make a forward progress and we can
-	 * invoke the oom killer here.
-	 *
-	 * Please note that mem_cgroup_out_of_memory might fail to find a
-	 * victim and then we have to bail out from the charge path.
-	 */
-	if (READ_ONCE(memcg->oom_kill_disable)) {
-		if (current->in_user_fault) {
-			css_get(&memcg->css);
-			current->memcg_in_oom = memcg;
-			current->memcg_oom_gfp_mask = mask;
-			current->memcg_oom_order = order;
-		}
+	if (!mem_cgroup_v1_oom_prepare(memcg, mask, order, &locked))
 		return false;
-	}
-
-	mem_cgroup_mark_under_oom(memcg);
-
-	locked = mem_cgroup_oom_trylock(memcg);
-
-	if (locked)
-		mem_cgroup_oom_notify(memcg);
-
-	mem_cgroup_unmark_under_oom(memcg);
 	ret = mem_cgroup_out_of_memory(memcg, mask, order);
-
-	if (locked)
-		mem_cgroup_oom_unlock(memcg);
+	mem_cgroup_v1_oom_finish(memcg, &locked);
 
 	return ret;
 }
 
-/**
- * mem_cgroup_oom_synchronize - complete memcg OOM handling
- * @handle: actually kill/wait or just clean up the OOM state
- *
- * This has to be called at the end of a page fault if the memcg OOM
- * handler was enabled.
- *
- * Memcg supports userspace OOM handling where failed allocations must
- * sleep on a waitqueue until the userspace task resolves the
- * situation.  Sleeping directly in the charge context with all kinds
- * of locks held is not a good idea, instead we remember an OOM state
- * in the task and mem_cgroup_oom_synchronize() has to be called at
- * the end of the page fault to complete the OOM handling.
- *
- * Returns %true if an ongoing memcg OOM situation was detected and
- * completed, %false otherwise.
- */
-bool mem_cgroup_oom_synchronize(bool handle)
-{
-	struct mem_cgroup *memcg = current->memcg_in_oom;
-	struct oom_wait_info owait;
-	bool locked;
-
-	/* OOM is global, do not handle */
-	if (!memcg)
-		return false;
-
-	if (!handle)
-		goto cleanup;
-
-	owait.memcg = memcg;
-	owait.wait.flags = 0;
-	owait.wait.func = memcg_oom_wake_function;
-	owait.wait.private = current;
-	INIT_LIST_HEAD(&owait.wait.entry);
-
-	prepare_to_wait(&memcg_oom_waitq, &owait.wait, TASK_KILLABLE);
-	mem_cgroup_mark_under_oom(memcg);
-
-	locked = mem_cgroup_oom_trylock(memcg);
-
-	if (locked)
-		mem_cgroup_oom_notify(memcg);
-
-	schedule();
-	mem_cgroup_unmark_under_oom(memcg);
-	finish_wait(&memcg_oom_waitq, &owait.wait);
-
-	if (locked)
-		mem_cgroup_oom_unlock(memcg);
-cleanup:
-	current->memcg_in_oom = NULL;
-	css_put(&memcg->css);
-	return true;
-}
-
 /**
  * mem_cgroup_get_oom_group - get a memory cgroup to clean up after OOM
  * @victim: task to be killed by the OOM killer
-- 
2.43.2


