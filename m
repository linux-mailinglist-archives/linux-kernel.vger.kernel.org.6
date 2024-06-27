Return-Path: <linux-kernel+bounces-232757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E856F91AE01
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 19:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 698CE1F2883C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5CC19ADA4;
	Thu, 27 Jun 2024 17:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NI6BBW6a"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC87E19A298
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 17:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719509018; cv=none; b=HpHthpxpR1SfpI4aPm/3lFzUOYHMioM/5J5Jq1Lu6QXS2QKEW/v8chcc2aYwHci5iHUIYM1TdPdqFd7Wv4jzaMqpJuqa8WNsr1LtOiB9z/MNwV7kzGRsSqP3JV0ZENcBGC2ZCa/QRCL90H+NXKijj4YfhzMYV4aypDMBjyu7F6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719509018; c=relaxed/simple;
	bh=ZhttSAUNuIqpeid9QS4tSvqMmXfUkhdqqFtdbqe1VM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AvHlgc5ZPokf0SJr02PwGOZkKOBw/7vPezg/ukzwvImuJG9pnzWlp3VVO24hVkDEYTNtBpn50WghXKpMaHGqckc87AYQ3l8R40vMpyWDH9wAJzBL3a3sCc6HMPmv3YAvb8H2nT9B3fttilHAqXn1CXeBCknu5lY+PUfczGr3xbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NI6BBW6a; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=HeHrf
	KXlbI04kg3cNGeUN3w8P4AOyI3+OZmwJAc+axY=; b=NI6BBW6aovaOCYUudN+7t
	jvYWGtLZGUFDrrclbMDMVgqIoqIco+zyHgsPFGRIPP4BGaY1vxfFwh6N2AzpHW9V
	RcxIj2Ho9bvDrQzZn/oUinMeNKlX/qvunJwi7y0SnC6x+kAWhxIwTRfN8UOEaeOk
	uOJ4qI3ML+qYBt4Mv9/hOs=
Received: from localhost (unknown [101.132.132.191])
	by gzga-smtp-mta-g2-3 (Coremail) with SMTP id _____wDX32q+n31m4LvgAQ--.63259S2;
	Fri, 28 Jun 2024 01:22:07 +0800 (CST)
From: Xavier <xavier_qy@163.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org
Cc: dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org,
	Xavier <xavier_qy@163.com>
Subject: [PATCH-RT sched v1 1/2] RT SCHED: Optimize the enqueue and dequeue operations for rt_se
Date: Fri, 28 Jun 2024 01:21:55 +0800
Message-Id: <20240627172156.235421-2-xavier_qy@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627172156.235421-1-xavier_qy@163.com>
References: <20240627172156.235421-1-xavier_qy@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX32q+n31m4LvgAQ--.63259S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3KFWrZw47WF4UZr1fCrW3ZFb_yoW8XFyruo
	WxtrsFqa97Gw1kA34fGFy0yrWfZa1YvF13AayYkws5Jw1qqF1DZ3y5uw13Aa4Sq398KFZF
	vF18Xa48tFsrGFWfn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUUkucDUUUU
X-CM-SenderInfo: 50dyxvpubt5qqrwthudrp/1tbiYwkLEGV4I-nEcwABsA

This patch optimizes the enqueue and dequeue of rt_se, the strategy employs
a bottom-up removal approach. Specifically, when removing an rt_se at a
certain level, if it is determined that the highest priority of the rq
associated with that rt_se has not changed, there is no need to continue
removing rt_se at higher levels. At this point, only the total number
of removed rt_se needs to be recorded, and the rt_nr_running count of
higher-level rq should be removed accordingly.

Signed-off-by: Xavier <xavier_qy@163.com>
---
 kernel/sched/debug.c |  50 ++++++++
 kernel/sched/rt.c    | 277 ++++++++++++++++++++++++++++++++++++-------
 kernel/sched/sched.h |   1 +
 3 files changed, 286 insertions(+), 42 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index c1eb9a1afd13..d823280c0e73 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -712,6 +712,56 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 #endif
 }
 
+static void print_rt_se(struct seq_file *m, struct sched_rt_entity *rt_se)
+{
+	struct task_struct *task;
+
+	if (rt_se->my_q) {
+#ifdef CONFIG_RT_GROUP_SCHED
+		SEQ_printf_task_group_path(m, rt_se->my_q->tg, "%s\n");
+#endif
+	} else {
+		task = container_of(rt_se, struct task_struct, rt);
+		SEQ_printf(m, "	prio-%d, pid-%d, %s\n", task->prio, task->pid, task->comm);
+	}
+}
+
+/*shall be called in rq lock*/
+void print_rt_rq_task(struct seq_file *m, struct rt_rq *rt_rq)
+{
+	struct rt_prio_array *array = &rt_rq->active;
+	struct sched_rt_entity *rt_se;
+	struct list_head *queue, *head;
+	unsigned long bitmap[2];
+	int idx;
+	int count = 0;
+
+	if (!rt_rq->rt_nr_running)
+		return;
+
+	memcpy(bitmap, array->bitmap, sizeof(unsigned long) * 2);
+	idx = sched_find_first_bit(bitmap);
+	WARN_ON_ONCE(idx >= MAX_RT_PRIO);
+
+	while (1) {
+		clear_bit(idx, bitmap);
+		queue = array->queue + idx;
+		head = queue;
+		queue = queue->next;
+		do {
+			rt_se = list_entry(queue, struct sched_rt_entity, run_list);
+			print_rt_se(m, rt_se);
+			queue = queue->next;
+			count++;
+		} while (queue != head);
+		idx = sched_find_first_bit(bitmap);
+		if (idx >= MAX_RT_PRIO)
+			break;
+	}
+
+	WARN_ON_ONCE(count != rt_rq->rt_nr_running);
+}
+
 void print_rt_rq(struct seq_file *m, int cpu, struct rt_rq *rt_rq)
 {
 #ifdef CONFIG_RT_GROUP_SCHED
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index aa4c1c874fa4..f0b7e094de11 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1113,7 +1113,7 @@ void dec_rt_prio_smp(struct rt_rq *rt_rq, int prio, int prev_prio) {}
 #endif /* CONFIG_SMP */
 
 #if defined CONFIG_SMP || defined CONFIG_RT_GROUP_SCHED
-static void
+static int
 inc_rt_prio(struct rt_rq *rt_rq, int prio)
 {
 	int prev_prio = rt_rq->highest_prio.curr;
@@ -1122,9 +1122,11 @@ inc_rt_prio(struct rt_rq *rt_rq, int prio)
 		rt_rq->highest_prio.curr = prio;
 
 	inc_rt_prio_smp(rt_rq, prio, prev_prio);
+
+	return prev_prio > prio;
 }
 
-static void
+static int
 dec_rt_prio(struct rt_rq *rt_rq, int prio)
 {
 	int prev_prio = rt_rq->highest_prio.curr;
@@ -1149,12 +1151,22 @@ dec_rt_prio(struct rt_rq *rt_rq, int prio)
 	}
 
 	dec_rt_prio_smp(rt_rq, prio, prev_prio);
+	if (rt_rq->highest_prio.curr > prio)
+		return prio;
+	else
+		return 0;
 }
 
 #else
 
-static inline void inc_rt_prio(struct rt_rq *rt_rq, int prio) {}
-static inline void dec_rt_prio(struct rt_rq *rt_rq, int prio) {}
+static inline int inc_rt_prio(struct rt_rq *rt_rq, int prio)
+{
+	return 0;
+}
+static inline int dec_rt_prio(struct rt_rq *rt_rq, int prio)
+{
+	return 0;
+}
 
 #endif /* CONFIG_SMP || CONFIG_RT_GROUP_SCHED */
 
@@ -1218,28 +1230,31 @@ unsigned int rt_se_rr_nr_running(struct sched_rt_entity *rt_se)
 }
 
 static inline
-void inc_rt_tasks(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
+int inc_rt_tasks(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
 {
 	int prio = rt_se_prio(rt_se);
+	int prio_change;
 
 	WARN_ON(!rt_prio(prio));
 	rt_rq->rt_nr_running += rt_se_nr_running(rt_se);
 	rt_rq->rr_nr_running += rt_se_rr_nr_running(rt_se);
 
-	inc_rt_prio(rt_rq, prio);
+	prio_change = inc_rt_prio(rt_rq, prio);
 	inc_rt_group(rt_se, rt_rq);
+	return prio_change;
 }
 
 static inline
-void dec_rt_tasks(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
+int dec_rt_tasks(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq, int prio)
 {
+	int prio_changed;
 	WARN_ON(!rt_prio(rt_se_prio(rt_se)));
-	WARN_ON(!rt_rq->rt_nr_running);
 	rt_rq->rt_nr_running -= rt_se_nr_running(rt_se);
 	rt_rq->rr_nr_running -= rt_se_rr_nr_running(rt_se);
 
-	dec_rt_prio(rt_rq, rt_se_prio(rt_se));
+	prio_changed = dec_rt_prio(rt_rq, prio);
 	dec_rt_group(rt_se, rt_rq);
+	return prio_changed;
 }
 
 /*
@@ -1255,12 +1270,13 @@ static inline bool move_entity(unsigned int flags)
 	return true;
 }
 
-static void __delist_rt_entity(struct sched_rt_entity *rt_se, struct rt_prio_array *array)
+static void __delist_rt_entity(struct sched_rt_entity *rt_se,
+						struct rt_prio_array *array, int last_prio)
 {
 	list_del_init(&rt_se->run_list);
 
-	if (list_empty(array->queue + rt_se_prio(rt_se)))
-		__clear_bit(rt_se_prio(rt_se), array->bitmap);
+	if (list_empty(array->queue + last_prio))
+		__clear_bit(last_prio, array->bitmap);
 
 	rt_se->on_list = 0;
 }
@@ -1371,7 +1387,12 @@ update_stats_dequeue_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se,
 	}
 }
 
-static void __enqueue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flags)
+/*
+ * Returns: -1 indicates that rt_se was not enqueued, 0 indicates that the highest
+ * priority of the rq did not change after enqueue, and 1 indicates that the highest
+ * priority of the rq changed after enqueue.
+ */
+static int __enqueue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flags)
 {
 	struct rt_rq *rt_rq = rt_rq_of_se(rt_se);
 	struct rt_prio_array *array = &rt_rq->active;
@@ -1386,8 +1407,8 @@ static void __enqueue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flag
 	 */
 	if (group_rq && (rt_rq_throttled(group_rq) || !group_rq->rt_nr_running)) {
 		if (rt_se->on_list)
-			__delist_rt_entity(rt_se, array);
-		return;
+			__delist_rt_entity(rt_se, array, rt_se_prio(rt_se));
+		return -1;
 	}
 
 	if (move_entity(flags)) {
@@ -1402,73 +1423,245 @@ static void __enqueue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flag
 	}
 	rt_se->on_rq = 1;
 
-	inc_rt_tasks(rt_se, rt_rq);
+	return inc_rt_tasks(rt_se, rt_rq);
 }
 
-static void __dequeue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flags)
+/**
+ * delete rt_se from rt_rq
+ *
+ * @rt_se		Nodes to be deleted
+ * @last_prio	The highest priority of this rt_se before the previous round
+ *				of deletion
+ * @flags		operation flags
+ *
+ * Returns: =0 indicates that the highest priority of the current rq did not
+ * change during this deletion. >0 indicates it changed, and it returns the
+ * previous highest priority to use in the next round of deletion.
+ */
+static int __dequeue_rt_entity(struct sched_rt_entity *rt_se, int last_prio,
+									unsigned int flags)
 {
 	struct rt_rq *rt_rq = rt_rq_of_se(rt_se);
 	struct rt_prio_array *array = &rt_rq->active;
 
 	if (move_entity(flags)) {
 		WARN_ON_ONCE(!rt_se->on_list);
-		__delist_rt_entity(rt_se, array);
+		__delist_rt_entity(rt_se, array, last_prio);
 	}
 	rt_se->on_rq = 0;
 
-	dec_rt_tasks(rt_se, rt_rq);
+	return dec_rt_tasks(rt_se, rt_rq, last_prio);
+}
+
+static inline void dec_rq_nr_running(struct sched_rt_entity *rt_se,
+						unsigned int rt, unsigned int rr)
+{
+	struct rt_rq *rt_rq = rt_rq_of_se(rt_se);
+
+	rt_rq->rt_nr_running -= rt;
+	rt_rq->rr_nr_running -= rr;
+}
+
+static inline void add_rq_nr_running(struct sched_rt_entity *rt_se,
+						unsigned int rt, unsigned int rr)
+{
+	struct rt_rq *rt_rq = rt_rq_of_se(rt_se);
+
+	rt_rq->rt_nr_running += rt;
+	rt_rq->rr_nr_running += rr;
 }
 
 /*
- * Because the prio of an upper entry depends on the lower
- * entries, we must remove entries top - down.
+ * To optimize the enqueue and dequeue of rt_se, this strategy employs a
+ * bottom-up removal approach. Specifically, when removing an rt_se at a
+ * certain level, if it is determined that the highest priority of the rq
+ * associated with that rt_se has not changed, there is no need to continue
+ * removing rt_se at higher levels. At this point, only the total number
+ * of removed rt_se needs to be recorded, and the rt_nr_running count of
+ * higher-level rq should be removed accordingly.
+ *
+ * For enqueue operations, if an rt_se at a certain level is in the rq,
+ * it is still necessary to check the priority of the higher-level rq.
+ * If the priority of the higher-level rq is found to be lower than that
+ * of the rt_se to be added, it should be removed, as updating the highest
+ * priority of the rq during addition will cause the rq to be repositioned
+ * in the parent rq.
+ *
+ * Conversely, for dequeue operations, if an rt_se at a certain level is
+ * not in the rq, the operation can be exited immediately to reduce
+ * unnecessary checks and handling.
+ *
+ * The return value refers to the last rt_se that was removed for enqueue
+ * operations. And for dequeue operations, it refers to the last rt_se
+ * that was either removed or had its rt_nr_running updated.
  */
-static void dequeue_rt_stack(struct sched_rt_entity *rt_se, unsigned int flags)
+static struct sched_rt_entity *dequeue_rt_stack(struct sched_rt_entity *rt_se,
+						unsigned int flags, int for_enqueue)
 {
-	struct sched_rt_entity *back = NULL;
-	unsigned int rt_nr_running;
+	struct sched_rt_entity *last = rt_se;
+	struct sched_rt_entity *origin = rt_se;
+	unsigned int del_rt_nr = 0;
+	unsigned int del_rr_nr = 0;
+	int prio_changed = rt_se_prio(rt_se);
+	int sub_on_rq = 1;
 
 	for_each_sched_rt_entity(rt_se) {
-		rt_se->back = back;
-		back = rt_se;
-	}
-
-	rt_nr_running = rt_rq_of_se(back)->rt_nr_running;
+		if (on_rt_rq(rt_se)) {
+			if (sub_on_rq) {
+				/*
+				 * The number of tasks removed from the sub-level rt_se also needs
+				 * to be subtracted from the rq of the current rt_se, as the current
+				 * rt_se's rq no longer includes the number of removed tasks.
+				 */
+				dec_rq_nr_running(rt_se, del_rt_nr, del_rr_nr);
+
+				if (prio_changed) {
+					/*
+					 * If the removal of the lower-level rt_se causes the
+					 * highest priority of the current rq to change, then the
+					 * current rt_se also needs to be removed from its parent
+					 * rq, and the number of deleted tasks should be
+					 * accumulated.
+					 */
+					del_rt_nr += rt_se_nr_running(rt_se);
+					del_rr_nr += rt_se_rr_nr_running(rt_se);
+					prio_changed = __dequeue_rt_entity(rt_se,
+									prio_changed, flags);
+					last = rt_se;
+				} else if (!for_enqueue) {
+					/* For dequeue, last may only rt_nr_running was modified.*/
+					last = rt_se;
+				}
+			} else {
+				/*
+				 * Entering this branch must be for enqueue, as dequeue would break
+				 * if an rt_se is not online.
+				 * If the sub-level node is not online, and the current rt_se's
+				 * priority is lower than the one being added, current rt_se need
+				 * to be removed.
+				 */
+				prio_changed = rt_se_prio(rt_se);
+				if (prio_changed > rt_se_prio(origin)) {
+					del_rt_nr += rt_se_nr_running(rt_se);
+					del_rr_nr += rt_se_rr_nr_running(rt_se);
+					prio_changed = __dequeue_rt_entity(rt_se,
+									prio_changed, flags);
+					last = rt_se;
+				} else {
+					prio_changed = 0;
+				}
+			}
 
-	for (rt_se = back; rt_se; rt_se = rt_se->back) {
-		if (on_rt_rq(rt_se))
-			__dequeue_rt_entity(rt_se, flags);
+			/*
+			 * If the current rt_se is on the top rt_rq, then the already deleted
+			 * nodes, plus the count of the rt_rq where current rt_se located,
+			 * need to be removed from the top_rt_rq.
+			 */
+			if (!rt_se->parent) {
+				dequeue_top_rt_rq(rt_rq_of_se(rt_se),
+						del_rt_nr + rt_rq_of_se(rt_se)->rt_nr_running);
+			}
+			sub_on_rq = 1;
+		} else if (for_enqueue) {
+			/*
+			 * In the case of an enqueue operation, if a certain level is found to be
+			 * not online, then the previous counts need to be reset to zero.
+			 */
+			prio_changed = 0;
+			sub_on_rq = 0;
+			del_rt_nr = 0;
+			del_rr_nr = 0;
+
+			if (!rt_se->parent)
+				dequeue_top_rt_rq(rt_rq_of_se(rt_se),
+						rt_rq_of_se(rt_se)->rt_nr_running);
+		} else {
+			last = rt_se;
+			break;
+		}
 	}
 
-	dequeue_top_rt_rq(rt_rq_of_se(back), rt_nr_running);
+	return last;
 }
 
+
 static void enqueue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flags)
 {
 	struct rq *rq = rq_of_rt_se(rt_se);
+	struct sched_rt_entity *last;
+	unsigned int add_rt_nr = 0;
+	unsigned int add_rr_nr = 0;
+	int enqueue = 1;
+	int prio_change = 1;
 
 	update_stats_enqueue_rt(rt_rq_of_se(rt_se), rt_se, flags);
 
-	dequeue_rt_stack(rt_se, flags);
-	for_each_sched_rt_entity(rt_se)
-		__enqueue_rt_entity(rt_se, flags);
+	last = dequeue_rt_stack(rt_se, flags, 1);
+	do {
+		if (enqueue || !on_rt_rq(rt_se) || (prio_change == 1)) {
+			prio_change = __enqueue_rt_entity(rt_se, flags);
+			if (prio_change >= 0) {
+				add_rt_nr = rt_se_nr_running(rt_se);
+				add_rr_nr = rt_se_rr_nr_running(rt_se);
+			} else {
+				add_rt_nr = add_rr_nr = 0;
+			}
+		} else {
+			add_rq_nr_running(rt_se, add_rt_nr, add_rr_nr);
+		}
+
+		if (rt_se == last)
+			enqueue = 0;
+
+		rt_se = rt_se->parent;
+	} while (rt_se);
+
 	enqueue_top_rt_rq(&rq->rt);
 }
 
 static void dequeue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flags)
 {
 	struct rq *rq = rq_of_rt_se(rt_se);
+	struct sched_rt_entity *last;
+	unsigned int add_rt_nr = 0;
+	unsigned int add_rr_nr = 0;
+	int prio_change = 1;
 
 	update_stats_dequeue_rt(rt_rq_of_se(rt_se), rt_se, flags);
 
-	dequeue_rt_stack(rt_se, flags);
-
-	for_each_sched_rt_entity(rt_se) {
+	last = dequeue_rt_stack(rt_se, flags, 0);
+	do {
 		struct rt_rq *rt_rq = group_rt_rq(rt_se);
+		if (rt_rq && rt_rq->rt_nr_running) {
+			if (on_rt_rq(rt_se)) {
+				add_rq_nr_running(rt_se, add_rt_nr, add_rr_nr);
+			} else {
+				prio_change = __enqueue_rt_entity(rt_se, flags);
+				if (prio_change == 0) {
+					/*
+					 * If enqueue is successful and the priority of the rq has
+					 * not changed, then the parent node only needs to add the
+					 * count of the current rt_se. Otherwise, the parent node
+					 * will also need to enqueue.
+					 */
+					add_rt_nr = rt_se_nr_running(rt_se);
+					add_rr_nr = rt_se_rr_nr_running(rt_se);
+				}
+			}
+		} else {
+			add_rt_nr = add_rr_nr = 0;
+		}
+
+		/*
+		 * last is the rt_se of the last deletion or modification of the
+		 * count, so the subsequent rt_se does not need to be updated.
+		 */
+		if (rt_se == last)
+			break;
+
+		rt_se = rt_se->parent;
+	} while (rt_se);
 
-		if (rt_rq && rt_rq->rt_nr_running)
-			__enqueue_rt_entity(rt_se, flags);
-	}
 	enqueue_top_rt_rq(&rq->rt);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a831af102070..b634153aacf0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2878,6 +2878,7 @@ extern void print_rt_stats(struct seq_file *m, int cpu);
 extern void print_dl_stats(struct seq_file *m, int cpu);
 extern void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq);
 extern void print_rt_rq(struct seq_file *m, int cpu, struct rt_rq *rt_rq);
+extern void print_rt_rq_task(struct seq_file *m, struct rt_rq *rt_rq);
 extern void print_dl_rq(struct seq_file *m, int cpu, struct dl_rq *dl_rq);
 
 extern void resched_latency_warn(int cpu, u64 latency);
-- 
2.45.2


