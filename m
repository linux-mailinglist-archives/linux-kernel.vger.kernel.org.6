Return-Path: <linux-kernel+bounces-264095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 359F093DEF7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 13:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8F8AB218D0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 11:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497C874076;
	Sat, 27 Jul 2024 11:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bx1+BIwg"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2D4487BF
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 11:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722078146; cv=none; b=mJAqYWJsVHd7E3pDSZmxY6GfRr8XzXVuBiPRf5REBaOwrPi7sXoFysv2BVhuUB/OS1VfPG33AAJl174Vk56zWt7fIRNHhOQIiNia2MjpsaWQ7KYEsxbOI3z0OipJqyiogFEM82Eej5Wtml0HPb55u5uQYfqS5yaLJlBZAVD2/4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722078146; c=relaxed/simple;
	bh=uR7VIeybmmiVmZtIlkQtaC8JrMp3cyacg/DYBlGJ8ms=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=CW6wKGqPtBVBV9OukRJFANyMrXBGEu2uWut6J0T5b9sBV8ZUPUtuHtra7+3mPy672wGV2pGQDJ716F1A52uE1mrQo0yknP2t6L84zGsSKuf8tomiPsqApnzyl0JQLZ7lRibYAntlLQqEA3Tcg16vWjs6O9nSm5UQ3XZtGsBwFQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bx1+BIwg; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=cTU7K6RXzDNlE+8/w9VLYgVsxCh5cOYcd4m1ztxn/yU=; b=bx1+BIwg8de2o0I8O6tJK+8uS9
	n2Svc3LlyDrkQSNs4pYF9t2XoJXR2E8++gWKSHBmL7YU7eJvhKXW2oPHiPiVEz9cM6Ic07h4qfv7w
	BdqSdjJJKF5gtT/7y6qMCx2vIJ6C1w+v6+9QFZHxpD4fxswNKhzhmB1DkEom+722xObTxohy2vna2
	BgBAny77BrG9w8ZpDEDd9vd+lRrrE7AVRldfKy6p+w2Ql78cuR0KvcF2Ch3GyK3aC7KQDn6R9uUjP
	4y2kReSZZW+71xsr4Ef51B2HaNrfO+pCLZKDGLRIOLpn+qrJ26SzR39AxdZqGQrjTSwd5II/CKvyK
	RbEKWBkg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXfBg-00000004QMf-0iSj;
	Sat, 27 Jul 2024 11:02:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id A96EF302182; Sat, 27 Jul 2024 13:02:06 +0200 (CEST)
Message-Id: <20240727105028.977256873@infradead.org>
User-Agent: quilt/0.65
Date: Sat, 27 Jul 2024 12:27:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@redhat.com,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com,
 youssefesmat@chromium.org,
 tglx@linutronix.de,
 efault@gmx.de
Subject: [PATCH 07/24] sched/fair: Re-organize dequeue_task_fair()
References: <20240727102732.960974693@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Working towards delaying dequeue, notably also inside the hierachy,
rework dequeue_task_fair() such that it can 'resume' an interrupted
hierarchy walk.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c |   61 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 21 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6861,34 +6861,43 @@ enqueue_task_fair(struct rq *rq, struct
 static void set_next_buddy(struct sched_entity *se);
 
 /*
- * The dequeue_task method is called before nr_running is
- * decreased. We remove the task from the rbtree and
- * update the fair scheduling stats:
+ * Basically dequeue_task_fair(), except it can deal with dequeue_entity()
+ * failing half-way through and resume the dequeue later.
+ *
+ * Returns:
+ * -1 - dequeue delayed
+ *  0 - dequeue throttled
+ *  1 - dequeue complete
  */
-static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
+static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 {
-	struct cfs_rq *cfs_rq;
-	struct sched_entity *se = &p->se;
-	int task_sleep = flags & DEQUEUE_SLEEP;
-	int idle_h_nr_running = task_has_idle_policy(p);
 	bool was_sched_idle = sched_idle_rq(rq);
 	int rq_h_nr_running = rq->cfs.h_nr_running;
+	bool task_sleep = flags & DEQUEUE_SLEEP;
+	struct task_struct *p = NULL;
+	int idle_h_nr_running = 0;
+	int h_nr_running = 0;
+	struct cfs_rq *cfs_rq;
 
-	util_est_dequeue(&rq->cfs, p);
+	if (entity_is_task(se)) {
+		p = task_of(se);
+		h_nr_running = 1;
+		idle_h_nr_running = task_has_idle_policy(p);
+	}
 
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
 		dequeue_entity(cfs_rq, se, flags);
 
-		cfs_rq->h_nr_running--;
+		cfs_rq->h_nr_running -= h_nr_running;
 		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
 
 		if (cfs_rq_is_idle(cfs_rq))
-			idle_h_nr_running = 1;
+			idle_h_nr_running = h_nr_running;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
-			goto dequeue_throttle;
+			return 0;
 
 		/* Don't dequeue parent if it has other entities besides us */
 		if (cfs_rq->load.weight) {
@@ -6912,20 +6921,18 @@ static bool dequeue_task_fair(struct rq
 		se_update_runnable(se);
 		update_cfs_group(se);
 
-		cfs_rq->h_nr_running--;
+		cfs_rq->h_nr_running -= h_nr_running;
 		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
 
 		if (cfs_rq_is_idle(cfs_rq))
-			idle_h_nr_running = 1;
+			idle_h_nr_running = h_nr_running;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
-			goto dequeue_throttle;
-
+			return 0;
 	}
 
-	/* At this point se is NULL and we are at root level*/
-	sub_nr_running(rq, 1);
+	sub_nr_running(rq, h_nr_running);
 
 	if (rq_h_nr_running && !rq->cfs.h_nr_running)
 		dl_server_stop(&rq->fair_server);
@@ -6934,10 +6941,22 @@ static bool dequeue_task_fair(struct rq
 	if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
 		rq->next_balance = jiffies;
 
-dequeue_throttle:
-	util_est_update(&rq->cfs, p, task_sleep);
-	hrtick_update(rq);
+	return 1;
+}
+/*
+ * The dequeue_task method is called before nr_running is
+ * decreased. We remove the task from the rbtree and
+ * update the fair scheduling stats:
+ */
+static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
+{
+	util_est_dequeue(&rq->cfs, p);
 
+	if (dequeue_entities(rq, &p->se, flags) < 0)
+		return false;
+
+	util_est_update(&rq->cfs, p, flags & DEQUEUE_SLEEP);
+	hrtick_update(rq);
 	return true;
 }
 



