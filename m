Return-Path: <linux-kernel+bounces-360557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5E3999C9D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE872284CA5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 06:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BEA208231;
	Fri, 11 Oct 2024 06:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="D3Kht7xH"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0402581
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 06:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728627996; cv=none; b=eP/20Nn8ncuajIIO1KKiksBwJ3jug3SVQJrOQ9MzRREiMaXcEpS1d6RqYnlQC4bH1f+A8paR7NzbpkT1d6GuGU2d5Vn80iZDByoGzAH8gp6dBe8mxEk7iJ9Qpx03YeQ9N9zHof7viWCCkikK6NEGb4uwHC764lbQFZlJLRW9Vec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728627996; c=relaxed/simple;
	bh=CJymPeP+BWe7dTfJ03rOaCAcd0d09I5d7x6+gqhTZaE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u27ko56Ao9kPiadTGRN+VS0aWK11EAZMeVvbpK9SlamctWeJ5dDe1XD7AwtdZYhO5D6TiRZ6Y+lT4EekrKXa01AGhevOZVduq5heMDJnEGSLbrLff0finVD5mWengl923J4LuApCuxsJ0aQE3ehj86cpw09XaC3apGtVz6OQ600=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=D3Kht7xH; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=C3bMqgBXJZNJkI9ovUcHCYmQ0u0dHNtSfwJWg/F8wKo=;
	b=D3Kht7xH8qvqxDPlLI1AsGrUARCouio2mL3em++Rt5tCFPDcm5jY0dIVsqdMjF
	kmwerYmTPsHBhSe9L/HM0KmH8Ln9hBiFMaCPK9a+ukhjybxheS7GfEVajtelbKIc
	rhvGt5Q3W6xHthPm09f0qPKitj9wFLQuMsUJ29ruifvVE=
Received: from localhost (unknown [101.132.132.191])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDHr9ezxAhnReetAQ--.46327S2;
	Fri, 11 Oct 2024 14:24:51 +0800 (CST)
From: Xavier <xavier_qy@163.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	yu.c.chen@intel.com
Cc: linux-kernel@vger.kernel.org,
	Xavier <xavier_qy@163.com>
Subject: [PATCH v2] sched/eevdf: Reduce the computation frequency of avg_vruntime
Date: Fri, 11 Oct 2024 14:24:49 +0800
Message-Id: <20241011062449.998696-1-xavier_qy@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912091454.801033-1-xavier_qy@163.com>
References: <20240912091454.801033-1-xavier_qy@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHr9ezxAhnReetAQ--.46327S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Gw4xKr1kXFW7CF4UCFW8Crg_yoWfKF1kpF
	WUXay3tr40qr1qvr4kJr9rWF9xGr95G3y2gFykAayIyws8K3s8tFyaqFW7tF1Ykr4kCFy7
	ArW0qrW7Cr17KrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pipVbPUUUUU=
X-CM-SenderInfo: 50dyxvpubt5qqrwthudrp/1tbiYw51EGcIvyWJSgAAs+

The current code subtracts the value of curr from avg_vruntime and avg_load
during runtime. Then, every time avg_vruntime() is called, it adds the
value of curr to the avg_vruntime and avg_load. Afterward, it divides these
and adds min_vruntime to obtain the actual avg_vruntime.

Analysis of the code indicates that avg_vruntime only changes significantly
during update_curr(), update_min_vruntime(), and when tasks are enqueued or
dequeued. Therefore, it is sufficient to recalculate and store avg_vruntime
only in these specific scenarios. This optimization ensures that accessing
avg_vruntime() does not necessitate a recalculation each time, thereby
enhancing the efficiency of the code.

There is no need to subtract curr’s load from avg_load during runtime.
Instead, we only need to calculate the incremental change and update
avg_vruntime whenever curr’s time is updated.

To better represent their functions, rename the original avg_vruntime and
avg_load to tot_vruntime and tot_load, respectively, which more accurately
describes their roles in the computation.

Signed-off-by: Xavier <xavier_qy@163.com>
---

Note:
The patch V2 has been updated based on the latest sched/core branch.

 kernel/sched/fair.c  | 107 ++++++++++++++++++++++++-------------------
 kernel/sched/sched.h |   3 +-
 2 files changed, 61 insertions(+), 49 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5a621210c9c..fb0434dd0a8 100644
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
@@ -617,14 +617,29 @@ static inline s64 entity_key(struct cfs_rq *cfs_rq, struct sched_entity *se)
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
+	avg_vruntime_update(cfs_rq);
 }
 
 static void
@@ -633,17 +648,29 @@ avg_vruntime_sub(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	unsigned long weight = scale_load_down(se->load.weight);
 	s64 key = entity_key(cfs_rq, se);
 
-	cfs_rq->avg_vruntime -= key * weight;
-	cfs_rq->avg_load -= weight;
+	cfs_rq->tot_vruntime -= key * weight;
+	cfs_rq->tot_load -= weight;
+	avg_vruntime_update(cfs_rq);
+}
+
+static inline
+void avg_vruntime_update_for_curr(struct cfs_rq *cfs_rq, s64 delta)
+{
+	struct sched_entity *curr = cfs_rq->curr;
+	unsigned long weight = scale_load_down(curr->load.weight);
+
+	cfs_rq->tot_vruntime += delta * weight;
+	avg_vruntime_update(cfs_rq);
 }
 
 static inline
-void avg_vruntime_update(struct cfs_rq *cfs_rq, s64 delta)
+void avg_vruntime_update_for_minv(struct cfs_rq *cfs_rq, s64 delta)
 {
 	/*
-	 * v' = v + d ==> avg_vruntime' = avg_runtime - d*avg_load
+	 * v' = v + d ==> avg_runtime' = tot_runtime - d*tot_load
 	 */
-	cfs_rq->avg_vruntime -= cfs_rq->avg_load * delta;
+	cfs_rq->tot_vruntime -= cfs_rq->tot_load * delta;
+	avg_vruntime_update(cfs_rq);
 }
 
 /*
@@ -652,25 +679,7 @@ void avg_vruntime_update(struct cfs_rq *cfs_rq, s64 delta)
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
-
-	return cfs_rq->min_vruntime + avg;
+	return cfs_rq->min_vruntime + cfs_rq->avg_vruntime;
 }
 
 /*
@@ -725,18 +734,8 @@ static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
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
@@ -752,7 +751,7 @@ static u64 __update_min_vruntime(struct cfs_rq *cfs_rq, u64 vruntime)
 	 */
 	s64 delta = (s64)(vruntime - min_vruntime);
 	if (delta > 0) {
-		avg_vruntime_update(cfs_rq, delta);
+		avg_vruntime_update_for_minv(cfs_rq, delta);
 		min_vruntime = vruntime;
 	}
 	return min_vruntime;
@@ -851,7 +850,6 @@ RB_DECLARE_CALLBACKS(static, min_vruntime_cb, struct sched_entity,
  */
 static void __enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	avg_vruntime_add(cfs_rq, se);
 	se->min_vruntime = se->vruntime;
 	se->min_slice = se->slice;
 	rb_add_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
@@ -862,7 +860,6 @@ static void __dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	rb_erase_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
 				  &min_vruntime_cb);
-	avg_vruntime_sub(cfs_rq, se);
 }
 
 struct sched_entity *__pick_root_entity(struct cfs_rq *cfs_rq)
@@ -1219,6 +1216,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	s64 delta_exec;
 	bool resched;
+	s64 vdelta_exec;
 
 	if (unlikely(!curr))
 		return;
@@ -1227,8 +1225,10 @@ static void update_curr(struct cfs_rq *cfs_rq)
 	if (unlikely(delta_exec <= 0))
 		return;
 
-	curr->vruntime += calc_delta_fair(delta_exec, curr);
+	vdelta_exec = calc_delta_fair(delta_exec, curr);
+	curr->vruntime += vdelta_exec;
 	resched = update_deadline(cfs_rq, curr);
+	avg_vruntime_update_for_curr(cfs_rq, vdelta_exec);
 	update_min_vruntime(cfs_rq);
 
 	if (entity_is_task(curr)) {
@@ -3883,6 +3883,8 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 		avruntime = avg_vruntime(cfs_rq);
 		if (!curr)
 			__dequeue_entity(cfs_rq, se);
+
+		avg_vruntime_sub(cfs_rq, se);
 		update_load_sub(&cfs_rq->load, se->load.weight);
 	}
 	dequeue_load_avg(cfs_rq, se);
@@ -3913,6 +3915,8 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 		if (!curr)
 			__enqueue_entity(cfs_rq, se);
 
+		avg_vruntime_add(cfs_rq, se);
+
 		/*
 		 * The entity's vruntime has been adjusted, so let's check
 		 * whether the rq-wide min_vruntime needs updated too. Since
@@ -5281,7 +5285,6 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * EEVDF: placement strategy #1 / #2
 	 */
 	if (sched_feat(PLACE_LAG) && cfs_rq->nr_running && se->vlag) {
-		struct sched_entity *curr = cfs_rq->curr;
 		unsigned long load;
 
 		lag = se->vlag;
@@ -5338,9 +5341,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		 *
 		 *   vl_i = (W + w_i)*vl'_i / W
 		 */
-		load = cfs_rq->avg_load;
-		if (curr && curr->on_rq)
-			load += scale_load_down(curr->load.weight);
+		load = cfs_rq->tot_load;
 
 		lag *= load + scale_load_down(se->load.weight);
 		if (WARN_ON_ONCE(!load))
@@ -5427,6 +5428,8 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	update_stats_enqueue_fair(cfs_rq, se, flags);
 	if (!curr)
 		__enqueue_entity(cfs_rq, se);
+
+	avg_vruntime_add(cfs_rq, se);
 	se->on_rq = 1;
 
 	if (cfs_rq->nr_running == 1) {
@@ -5530,6 +5533,8 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 	if (se != cfs_rq->curr)
 		__dequeue_entity(cfs_rq, se);
+
+	avg_vruntime_sub(cfs_rq, se);
 	se->on_rq = 0;
 	account_entity_dequeue(cfs_rq, se);
 
@@ -6924,11 +6929,17 @@ requeue_delayed_entity(struct sched_entity *se)
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
index b1c3588a8f0..7f7c93518c7 100644
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


