Return-Path: <linux-kernel+bounces-371884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6C59A41C2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56D60283E58
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A33F1FF5F0;
	Fri, 18 Oct 2024 14:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="krWwBvip"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB6710E4
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 14:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729263225; cv=none; b=H7tx6qQQYbUKaC2y9Dt7a3ISMhUhLT9dDz+Hufo5hKbSwpbHkchT48QmODptrtxMXE3lQxolUrCmtFmK5p3UMNPqVNnEs/ugIXXWttXO5hIvIVxJVrG48XPjilZxtqJxYcqBZsRet2R0Mu013M6SKlO//HCVN+4yX2czuDWQc2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729263225; c=relaxed/simple;
	bh=TTgcUlAV9bGV+DOK+9HEeNqcQnOVrkv5CMh3NsU3Hzw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hlZVmMKhbcU5D//WX6+59hk9WC332LZY1C2LD0VsHqooKDucWDXrPA2dZoJuIppA/XHzSThdqj6a5hBLdY9jic7b+zWscsxl0oEODIt9Gi43qugnuwWFNMv2zuj8UYjVHaS6SffzARaTu5Q5pFCJZMxTGN0vOyxJfjv7XDLPuOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=krWwBvip; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=q8hANp2XcwaDh96QM7Oc9kDe5x1PwrM2RyXe7XW8blI=;
	b=krWwBvipfcjTqsH59zI8ans8MRX3sjeSoHPs9IRlgxjVa36pP23ST0n2E1+T95
	4mD3xHPvCTkrjrnyGK4ZKAPiO108GIjf3OvUxRgThxL9frq9o/g3aJnHtRAqra75
	d8SvfI4U2KSt/hwjt4lChcrZE33BEcW+W9ESmZ6O0tN/E=
Received: from localhost (unknown [101.132.132.191])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3nxAtdhJnkGvJBw--.31137S2;
	Fri, 18 Oct 2024 22:52:29 +0800 (CST)
From: Xavier <xavier_qy@163.com>
To: oliver.sang@intel.com
Cc: aubrey.li@linux.intel.com,
	bsegall@google.com,
	dietmar.eggemann@arm.com,
	feng.tang@intel.com,
	fengwei.yin@intel.com,
	juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	lkp@intel.com,
	mgorman@suse.de,
	mingo@redhat.com,
	oe-lkp@lists.linux.dev,
	peterz@infradead.org,
	rostedt@goodmis.org,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	xavier_qy@163.com,
	ying.huang@intel.com,
	yu.c.chen@intel.com
Subject: [PATCH v3] sched/eevdf: Remove the consideration of the current task's time in  vruntime_eligible() and avg_vruntime()
Date: Fri, 18 Oct 2024 22:52:16 +0800
Message-Id: <20241018145216.1021494-1-xavier_qy@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <202410171258.5873933a-oliver.sang@intel.com>
References: <202410171258.5873933a-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3nxAtdhJnkGvJBw--.31137S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Jw15ZFW7Ww4DZw17XF1kZrb_yoWfCFyUpF
	WUXay3tr40qr1qvr4DArZrWF9xGr95G3y2qFyvyayIyws8K3s8tFyaqrW3tF1YkrWkCFy7
	ArW0qrW7Cr47KrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi75r7UUUUU=
X-CM-SenderInfo: 50dyxvpubt5qqrwthudrp/1tbiYwx8EGcSZ3vcTwAAs5

The current code subtracts the value of curr from avg_vruntime and
avg_load during runtime. Then, every time avg_vruntime() and
vruntime_eligible() are called, the values of curr need to be added to
the avg_vruntime and avg_load.

There is no need to subtract curr’s load from avg_load during runtime.
Instead, we only need to calculate the incremental change and update
tot_vruntime whenever curr’s time is updated. This can effectively reduce
the number of calculations for curr’s time.

To better represent their functions, rename the original avg_vruntime and
avg_load to tot_vruntime and tot_load, respectively, which more accurately
describes their roles in the computation.

Signed-off-by: Xavier <xavier_qy@163.com>
---

Note:
To address the performance decline in V2, the V3 patch reduces the unnecessary
 calculations of avg_vruntime.


 kernel/sched/fair.c  | 104 ++++++++++++++++++++++++-------------------
 kernel/sched/sched.h |   3 +-
 2 files changed, 59 insertions(+), 48 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6512258dc71..cbcdf8686fe 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -606,8 +606,8 @@ static inline s64 entity_key(struct cfs_rq *cfs_rq, struct sched_entity *se)
  * Which we track using:
  *
  *                    v0 := cfs_rq->min_vruntime
- * \Sum (v_i - v0) * w_i := cfs_rq->avg_vruntime
- *              \Sum w_i := cfs_rq->avg_load
+ * \Sum (v_i - v0) * w_i := cfs_rq->tot_vruntime
+ *              \Sum w_i := cfs_rq->tot_load
  *
  * Since min_vruntime is a monotonic increasing variable that closely tracks
  * the per-task service, these deltas: (v_i - v), will be in the order of the
@@ -617,14 +617,28 @@ static inline s64 entity_key(struct cfs_rq *cfs_rq, struct sched_entity *se)
  *
  * As measured, the max (key * weight) value was ~44 bits for a kernel build.
  */
+static inline void avg_vruntime_update(struct cfs_rq *cfs_rq)
+{
+	s64	tot_vruntime = cfs_rq->tot_vruntime;
+
+	/* sign flips effective floor / ceiling */
+	if (cfs_rq->tot_load) {
+		if (tot_vruntime < 0)
+			tot_vruntime -= (cfs_rq->tot_load - 1);
+		cfs_rq->avg_vruntime = div_s64(tot_vruntime, cfs_rq->tot_load);
+	} else {
+		cfs_rq->avg_vruntime = cfs_rq->tot_vruntime;
+	}
+}
+
 static void
 avg_vruntime_add(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	unsigned long weight = scale_load_down(se->load.weight);
 	s64 key = entity_key(cfs_rq, se);
 
-	cfs_rq->avg_vruntime += key * weight;
-	cfs_rq->avg_load += weight;
+	cfs_rq->tot_vruntime += key * weight;
+	cfs_rq->tot_load += weight;
 }
 
 static void
@@ -633,17 +647,26 @@ avg_vruntime_sub(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	unsigned long weight = scale_load_down(se->load.weight);
 	s64 key = entity_key(cfs_rq, se);
 
-	cfs_rq->avg_vruntime -= key * weight;
-	cfs_rq->avg_load -= weight;
+	cfs_rq->tot_vruntime -= key * weight;
+	cfs_rq->tot_load -= weight;
+}
+
+static inline
+void tot_vruntime_update_for_curr(struct cfs_rq *cfs_rq, s64 delta)
+{
+	struct sched_entity *curr = cfs_rq->curr;
+	unsigned long weight = scale_load_down(curr->load.weight);
+
+	cfs_rq->tot_vruntime += delta * weight;
 }
 
 static inline
-void avg_vruntime_update(struct cfs_rq *cfs_rq, s64 delta)
+void tot_vruntime_update_for_minv(struct cfs_rq *cfs_rq, s64 delta)
 {
 	/*
-	 * v' = v + d ==> avg_vruntime' = avg_runtime - d*avg_load
+	 * v' = v + d ==> avg_runtime' = tot_runtime - d*tot_load
 	 */
-	cfs_rq->avg_vruntime -= cfs_rq->avg_load * delta;
+	cfs_rq->tot_vruntime -= cfs_rq->tot_load * delta;
 }
 
 /*
@@ -652,25 +675,9 @@ void avg_vruntime_update(struct cfs_rq *cfs_rq, s64 delta)
  */
 u64 avg_vruntime(struct cfs_rq *cfs_rq)
 {
-	struct sched_entity *curr = cfs_rq->curr;
-	s64 avg = cfs_rq->avg_vruntime;
-	long load = cfs_rq->avg_load;
-
-	if (curr && curr->on_rq) {
-		unsigned long weight = scale_load_down(curr->load.weight);
-
-		avg += entity_key(cfs_rq, curr) * weight;
-		load += weight;
-	}
-
-	if (load) {
-		/* sign flips effective floor / ceiling */
-		if (avg < 0)
-			avg -= (load - 1);
-		avg = div_s64(avg, load);
-	}
+	avg_vruntime_update(cfs_rq);
 
-	return cfs_rq->min_vruntime + avg;
+	return cfs_rq->min_vruntime + cfs_rq->avg_vruntime;
 }
 
 /*
@@ -725,18 +732,8 @@ static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
  */
 static int vruntime_eligible(struct cfs_rq *cfs_rq, u64 vruntime)
 {
-	struct sched_entity *curr = cfs_rq->curr;
-	s64 avg = cfs_rq->avg_vruntime;
-	long load = cfs_rq->avg_load;
-
-	if (curr && curr->on_rq) {
-		unsigned long weight = scale_load_down(curr->load.weight);
-
-		avg += entity_key(cfs_rq, curr) * weight;
-		load += weight;
-	}
-
-	return avg >= (s64)(vruntime - cfs_rq->min_vruntime) * load;
+	return cfs_rq->tot_vruntime >=
+			(s64)(vruntime - cfs_rq->min_vruntime) * (s64)cfs_rq->tot_load;
 }
 
 int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se)
@@ -752,7 +749,7 @@ static u64 __update_min_vruntime(struct cfs_rq *cfs_rq, u64 vruntime)
 	 */
 	s64 delta = (s64)(vruntime - min_vruntime);
 	if (delta > 0) {
-		avg_vruntime_update(cfs_rq, delta);
+		tot_vruntime_update_for_minv(cfs_rq, delta);
 		min_vruntime = vruntime;
 	}
 	return min_vruntime;
@@ -851,7 +848,6 @@ RB_DECLARE_CALLBACKS(static, min_vruntime_cb, struct sched_entity,
  */
 static void __enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	avg_vruntime_add(cfs_rq, se);
 	se->min_vruntime = se->vruntime;
 	se->min_slice = se->slice;
 	rb_add_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
@@ -862,7 +858,6 @@ static void __dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	rb_erase_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
 				  &min_vruntime_cb);
-	avg_vruntime_sub(cfs_rq, se);
 }
 
 struct sched_entity *__pick_root_entity(struct cfs_rq *cfs_rq)
@@ -1219,6 +1214,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	s64 delta_exec;
 	bool resched;
+	s64 vdelta_exec;
 
 	if (unlikely(!curr))
 		return;
@@ -1227,8 +1223,11 @@ static void update_curr(struct cfs_rq *cfs_rq)
 	if (unlikely(delta_exec <= 0))
 		return;
 
-	curr->vruntime += calc_delta_fair(delta_exec, curr);
+	vdelta_exec = calc_delta_fair(delta_exec, curr);
+	curr->vruntime += vdelta_exec;
 	resched = update_deadline(cfs_rq, curr);
+
+	tot_vruntime_update_for_curr(cfs_rq, vdelta_exec);
 	update_min_vruntime(cfs_rq);
 
 	if (entity_is_task(curr)) {
@@ -3883,6 +3882,8 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 		avruntime = avg_vruntime(cfs_rq);
 		if (!curr)
 			__dequeue_entity(cfs_rq, se);
+
+		avg_vruntime_sub(cfs_rq, se);
 		update_load_sub(&cfs_rq->load, se->load.weight);
 	}
 	dequeue_load_avg(cfs_rq, se);
@@ -3913,6 +3914,8 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 		if (!curr)
 			__enqueue_entity(cfs_rq, se);
 
+		avg_vruntime_add(cfs_rq, se);
+
 		/*
 		 * The entity's vruntime has been adjusted, so let's check
 		 * whether the rq-wide min_vruntime needs updated too. Since
@@ -5281,7 +5284,6 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * EEVDF: placement strategy #1 / #2
 	 */
 	if (sched_feat(PLACE_LAG) && cfs_rq->nr_running && se->vlag) {
-		struct sched_entity *curr = cfs_rq->curr;
 		unsigned long load;
 
 		lag = se->vlag;
@@ -5338,9 +5340,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		 *
 		 *   vl_i = (W + w_i)*vl'_i / W
 		 */
-		load = cfs_rq->avg_load;
-		if (curr && curr->on_rq)
-			load += scale_load_down(curr->load.weight);
+		load = cfs_rq->tot_load;
 
 		lag *= load + scale_load_down(se->load.weight);
 		if (WARN_ON_ONCE(!load))
@@ -5427,6 +5427,8 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	update_stats_enqueue_fair(cfs_rq, se, flags);
 	if (!curr)
 		__enqueue_entity(cfs_rq, se);
+
+	avg_vruntime_add(cfs_rq, se);
 	se->on_rq = 1;
 
 	if (cfs_rq->nr_running == 1) {
@@ -5530,6 +5532,8 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 	if (se != cfs_rq->curr)
 		__dequeue_entity(cfs_rq, se);
+
+	avg_vruntime_sub(cfs_rq, se);
 	se->on_rq = 0;
 	account_entity_dequeue(cfs_rq, se);
 
@@ -6927,11 +6931,17 @@ requeue_delayed_entity(struct sched_entity *se)
 			cfs_rq->nr_running--;
 			if (se != cfs_rq->curr)
 				__dequeue_entity(cfs_rq, se);
+			avg_vruntime_sub(cfs_rq, se);
+
 			se->vlag = 0;
 			place_entity(cfs_rq, se, 0);
+
 			if (se != cfs_rq->curr)
 				__enqueue_entity(cfs_rq, se);
+			avg_vruntime_add(cfs_rq, se);
 			cfs_rq->nr_running++;
+
+			update_min_vruntime(cfs_rq);
 		}
 	}
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5f3de82ec9c..b5b4062db3e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -650,8 +650,9 @@ struct cfs_rq {
 	unsigned int		idle_nr_running;   /* SCHED_IDLE */
 	unsigned int		idle_h_nr_running; /* SCHED_IDLE */
 
+	s64			tot_vruntime;
 	s64			avg_vruntime;
-	u64			avg_load;
+	u64			tot_load;
 
 	u64			min_vruntime;
 #ifdef CONFIG_SCHED_CORE
-- 
2.45.2


