Return-Path: <linux-kernel+bounces-264099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC7493DEFA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 13:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 356BB1F22B83
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 11:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C4E7D417;
	Sat, 27 Jul 2024 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bIsb1Sk+"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA29A481B7
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 11:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722078147; cv=none; b=rOcroGJudAqAWlUi6jK8UUfAfZLhtzZQjEiVfg9yPjP+kZe8Svqh254uxgBOr1vpTNkDqmt6F3/ltwuXkwlPmzgjXscLoa1dAFxmxTXn8bMCQvg+/C1FueFqV27se7IQuC9oPA0t+MUcTCqKu4c/kfxdSWLwYvfZYo3IOk4QeRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722078147; c=relaxed/simple;
	bh=Op/W2UQMguL4//BkKo3H6WwvAQRTno1SnLTSPqXtkKM=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=W0Jm7sBLZZt3feo8Qy7b0gmGqZvPnpoqcKzcaws3Yfk9Rzawf9qfZ9Esk28iwmagDHcpqIwm2TgSZ/9C2eU8CFzzo49fTpaz1rCSOLnKnGaMHwrszxCwkp2+Qu/dnz2WJ0OSoJNNK/wEWkTp4GgyqlYsFsRGkD3meSwr332C9x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bIsb1Sk+; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=QwzCMHrkYBSbjfUXXH4pXWPLFQlSvaWTAzXPcHOhQoM=; b=bIsb1Sk+0ykHar96ywShbjrCtI
	4WLJfIKqbAkm1W8iPA7OiD0f0QutA7eR1U83EXxuTdpUFY2IfQkcsMzIxZ82mvef8H3Bg5sP2dd4U
	iQnKWkFm0AT3hx4awpiGdcsknt64t6PCk7X+8EwT3yZPgr0taFaq7q437rg+mmVYIbv4m4nxtiXiW
	HHswhV+W/iNiqHl0FtDILxvuZcGN8ApmNbQoqyChH+D5Hj9wY/zbgi5ZwHdTr0PfwcExqQnZfxA66
	T6/dToo+nJd+8Bq4y57wAWXUctR8nw34dq5jtINUsfF9CqBv1kAOpXrVEg2DEPA0fXNaSKoV+vKHg
	imMzZ3Lw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXfBg-00000004QMl-1cRa;
	Sat, 27 Jul 2024 11:02:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id C177C30614E; Sat, 27 Jul 2024 13:02:06 +0200 (CEST)
Message-Id: <20240727105029.631948434@infradead.org>
User-Agent: quilt/0.65
Date: Sat, 27 Jul 2024 12:27:44 +0200
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
Subject: [PATCH 12/24] sched/fair: Prepare exit/cleanup paths for delayed_dequeue
References: <20240727102732.960974693@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

When dequeue_task() is delayed it becomes possible to exit a task (or
cgroup) that is still enqueued. Ensure things are dequeued before
freeing.

NOTE: switched_from_fair() causes spurious wakeups due to clearing
sched_delayed after enqueueing a task in another class that should've
been dequeued. This *should* be harmless.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c |   61 ++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 48 insertions(+), 13 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8318,7 +8318,20 @@ static void migrate_task_rq_fair(struct
 
 static void task_dead_fair(struct task_struct *p)
 {
-	remove_entity_load_avg(&p->se);
+	struct sched_entity *se = &p->se;
+
+	if (se->sched_delayed) {
+		struct rq_flags rf;
+		struct rq *rq;
+
+		rq = task_rq_lock(p, &rf);
+		update_rq_clock(rq);
+		if (se->sched_delayed)
+			dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
+		task_rq_unlock(rq, p, &rf);
+	}
+
+	remove_entity_load_avg(se);
 }
 
 /*
@@ -12817,10 +12830,26 @@ static void attach_task_cfs_rq(struct ta
 static void switched_from_fair(struct rq *rq, struct task_struct *p)
 {
 	detach_task_cfs_rq(p);
+	/*
+	 * Since this is called after changing class, this isn't quite right.
+	 * Specifically, this causes the task to get queued in the target class
+	 * and experience a 'spurious' wakeup.
+	 *
+	 * However, since 'spurious' wakeups are harmless, this shouldn't be a
+	 * problem.
+	 */
+	p->se.sched_delayed = 0;
+	/*
+	 * While here, also clear the vlag, it makes little sense to carry that
+	 * over the excursion into the new class.
+	 */
+	p->se.vlag = 0;
 }
 
 static void switched_to_fair(struct rq *rq, struct task_struct *p)
 {
+	SCHED_WARN_ON(p->se.sched_delayed);
+
 	attach_task_cfs_rq(p);
 
 	set_task_max_allowed_capacity(p);
@@ -12971,28 +13000,33 @@ void online_fair_sched_group(struct task
 
 void unregister_fair_sched_group(struct task_group *tg)
 {
-	unsigned long flags;
-	struct rq *rq;
 	int cpu;
 
 	destroy_cfs_bandwidth(tg_cfs_bandwidth(tg));
 
 	for_each_possible_cpu(cpu) {
-		if (tg->se[cpu])
-			remove_entity_load_avg(tg->se[cpu]);
+		struct cfs_rq *cfs_rq = tg->cfs_rq[cpu];
+		struct sched_entity *se = tg->se[cpu];
+		struct rq *rq = cpu_rq(cpu);
+
+		if (se) {
+			if (se->sched_delayed) {
+				guard(rq_lock_irqsave)(rq);
+				if (se->sched_delayed)
+					dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
+				list_del_leaf_cfs_rq(cfs_rq);
+			}
+			remove_entity_load_avg(se);
+		}
 
 		/*
 		 * Only empty task groups can be destroyed; so we can speculatively
 		 * check on_list without danger of it being re-added.
 		 */
-		if (!tg->cfs_rq[cpu]->on_list)
-			continue;
-
-		rq = cpu_rq(cpu);
-
-		raw_spin_rq_lock_irqsave(rq, flags);
-		list_del_leaf_cfs_rq(tg->cfs_rq[cpu]);
-		raw_spin_rq_unlock_irqrestore(rq, flags);
+		if (cfs_rq->on_list) {
+			guard(rq_lock_irqsave)(rq);
+			list_del_leaf_cfs_rq(cfs_rq);
+		}
 	}
 }
 



