Return-Path: <linux-kernel+bounces-326236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA55976550
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 11:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9922EB228FA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02ED1925BC;
	Thu, 12 Sep 2024 09:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WXifMMw2"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A319D18BBBD
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 09:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726132584; cv=none; b=Tdw40aU4qDsXu+aDOo1T7SZz8WZdCjyQlBvcr4uZjMLwkxxYe8iA0Oh+04budlZhMgMhSuKm3wDtCxh1RfISc2RJtwyjO1orQiI7IMgZ0XAHIqVJPc/UkwbM+F70nALouzj5IQsmfTd50ceFr50mHEKvY63evSpsPtwj4p16Vf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726132584; c=relaxed/simple;
	bh=kt/XulNNeQyUKDboXSEW4SyQbkWmmU4ZPuEXsNl4G9E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=BVsI+VsmWOfgNpgoVgTV8megbVesxQRKl6Muu7e17n7bc3zcp41/IIT9RR5FvWeVEnzBFoD6D6jzEYTEVUQwtDzkOdjTnsYwW/vTimoPulLOgSo8ssVDuRiWcPTzKLyq04mxapxvq3KsJRgK+vPcM28KzzQvr7xNtgNm1g5BwAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WXifMMw2; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=xW3u8po0Cnl9re6zuoev3DC+Hw1S3qz8t+ZT6zWK0us=;
	b=WXifMMw2YhTA/jMAzUwIdkcCrXUdiSt4BpoI6FAwqpnSmJUTzCsvP+mP/WwG8m
	goDVLTJvtTjpS7zDijprZ2g7EY8t7nwUs1HFad7gQyhITBAuyKeI57tXUakoiWSL
	KIG+EncHh4Vnzv9fdZFrxBc61eUlWo6Vad+d03jssrE5I=
Received: from localhost (unknown [101.132.132.191])
	by gzga-smtp-mta-g3-0 (Coremail) with SMTP id _____wD33ysSseJmxNkCAQ--.28066S2;
	Thu, 12 Sep 2024 17:14:58 +0800 (CST)
From: Xavier <xavier_qy@163.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org,
	Xavier <xavier_qy@163.com>
Subject: [PATCH v1] sched/eevdf: Reduce the computation frequency of avg_vruntime
Date: Thu, 12 Sep 2024 17:14:54 +0800
Message-Id: <20240912091454.801033-1-xavier_qy@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD33ysSseJmxNkCAQ--.28066S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Gw4xKr1kXFW7CF4UuFyrCrg_yoWfCw4rpF
	WUXayxtr40qr1qvr4kJr9rWF9xGr95G3y2gFyvyayIyws8K3s8tFyaqFW7tF1Ykr4kCFy7
	ArW0qrW7Cr47KrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piHa0PUUUUU=
X-CM-SenderInfo: 50dyxvpubt5qqrwthudrp/1tbiZQJREGXAoO+TPQABsj

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
 kernel/sched/fair.c  | 101 +++++++++++++++++++++++--------------------
 kernel/sched/sched.h |   3 +-
 2 files changed, 56 insertions(+), 48 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9057584ec06d..308d4bc3f40d 100644
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
@@ -725,18 +734,10 @@ static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
  */
 static int vruntime_eligible(struct cfs_rq *cfs_rq, u64 vruntime)
 {
-	struct sched_entity *curr = cfs_rq->curr;
-	s64 avg = cfs_rq->avg_vruntime;
-	long load = cfs_rq->avg_load;
+	s64 total = cfs_rq->tot_vruntime;
+	long load = cfs_rq->tot_load;
 
-	if (curr && curr->on_rq) {
-		unsigned long weight = scale_load_down(curr->load.weight);
-
-		avg += entity_key(cfs_rq, curr) * weight;
-		load += weight;
-	}
-
-	return avg >= (s64)(vruntime - cfs_rq->min_vruntime) * load;
+	return total >= (s64)(vruntime - cfs_rq->min_vruntime) * load;
 }
 
 int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se)
@@ -752,7 +753,7 @@ static u64 __update_min_vruntime(struct cfs_rq *cfs_rq, u64 vruntime)
 	 */
 	s64 delta = (s64)(vruntime - min_vruntime);
 	if (delta > 0) {
-		avg_vruntime_update(cfs_rq, delta);
+		avg_vruntime_update_for_minv(cfs_rq, delta);
 		min_vruntime = vruntime;
 	}
 	return min_vruntime;
@@ -822,7 +823,6 @@ RB_DECLARE_CALLBACKS(static, min_vruntime_cb, struct sched_entity,
  */
 static void __enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	avg_vruntime_add(cfs_rq, se);
 	se->min_vruntime = se->vruntime;
 	rb_add_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
 				__entity_less, &min_vruntime_cb);
@@ -832,7 +832,6 @@ static void __dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	rb_erase_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
 				  &min_vruntime_cb);
-	avg_vruntime_sub(cfs_rq, se);
 }
 
 struct sched_entity *__pick_root_entity(struct cfs_rq *cfs_rq)
@@ -1157,6 +1156,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 {
 	struct sched_entity *curr = cfs_rq->curr;
 	s64 delta_exec;
+	s64 vdelta_exec;
 
 	if (unlikely(!curr))
 		return;
@@ -1165,8 +1165,10 @@ static void update_curr(struct cfs_rq *cfs_rq)
 	if (unlikely(delta_exec <= 0))
 		return;
 
-	curr->vruntime += calc_delta_fair(delta_exec, curr);
+	vdelta_exec = calc_delta_fair(delta_exec, curr);
+	curr->vruntime += vdelta_exec;
 	update_deadline(cfs_rq, curr);
+	avg_vruntime_update_for_curr(cfs_rq, vdelta_exec);
 	update_min_vruntime(cfs_rq);
 
 	if (entity_is_task(curr))
@@ -3794,6 +3796,8 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 		avruntime = avg_vruntime(cfs_rq);
 		if (!curr)
 			__dequeue_entity(cfs_rq, se);
+
+		avg_vruntime_sub(cfs_rq, se);
 		update_load_sub(&cfs_rq->load, se->load.weight);
 	}
 	dequeue_load_avg(cfs_rq, se);
@@ -3824,6 +3828,8 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 		if (!curr)
 			__enqueue_entity(cfs_rq, se);
 
+		avg_vruntime_add(cfs_rq, se);
+
 		/*
 		 * The entity's vruntime has been adjusted, so let's check
 		 * whether the rq-wide min_vruntime needs updated too. Since
@@ -5190,7 +5196,6 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * EEVDF: placement strategy #1 / #2
 	 */
 	if (sched_feat(PLACE_LAG) && cfs_rq->nr_running) {
-		struct sched_entity *curr = cfs_rq->curr;
 		unsigned long load;
 
 		lag = se->vlag;
@@ -5247,9 +5252,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		 *
 		 *   vl_i = (W + w_i)*vl'_i / W
 		 */
-		load = cfs_rq->avg_load;
-		if (curr && curr->on_rq)
-			load += scale_load_down(curr->load.weight);
+		load = cfs_rq->tot_load;
 
 		lag *= load + scale_load_down(se->load.weight);
 		if (WARN_ON_ONCE(!load))
@@ -5327,6 +5330,8 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	update_stats_enqueue_fair(cfs_rq, se, flags);
 	if (!curr)
 		__enqueue_entity(cfs_rq, se);
+
+	avg_vruntime_add(cfs_rq, se);
 	se->on_rq = 1;
 
 	if (cfs_rq->nr_running == 1) {
@@ -5397,6 +5402,8 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	update_entity_lag(cfs_rq, se);
 	if (se != cfs_rq->curr)
 		__dequeue_entity(cfs_rq, se);
+
+	avg_vruntime_sub(cfs_rq, se);
 	se->on_rq = 0;
 	account_entity_dequeue(cfs_rq, se);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4c36cc680361..57f07c56ecda 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -596,8 +596,9 @@ struct cfs_rq {
 	unsigned int		idle_nr_running;   /* SCHED_IDLE */
 	unsigned int		idle_h_nr_running; /* SCHED_IDLE */
 
+	s64			tot_vruntime;
 	s64			avg_vruntime;
-	u64			avg_load;
+	u64			tot_load;
 
 	u64			exec_clock;
 	u64			min_vruntime;
-- 
2.45.2


