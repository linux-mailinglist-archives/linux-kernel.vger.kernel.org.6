Return-Path: <linux-kernel+bounces-285580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9BE950FE1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 00:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A24911F2452F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 22:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3471AD9CC;
	Tue, 13 Aug 2024 22:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AugU10fV"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D791AB524
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 22:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723589441; cv=none; b=uyB+NZGwWrywTLtqCqzFx4YiqGcOFvq8Xv+f6oarA1Atc/A/so990JXqgJfnFLJABz1BzsP4X99SobItMY+kuIlowhfVDt9H8iHoQewGLYCM6hITSeqw+1++19Kr43uXvHtYwvkHEgAV6lwICLPZ7X1kSzaWAcDbEgwtu/F3ogE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723589441; c=relaxed/simple;
	bh=4EoFx1f69wqqPGysup50POHm+uC/DFxaLP2Z3d8HMD4=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=QgPKCxzSbOhJS09MFzGAcysSLsbvjWjMenrS2U08m1BrMMXA497AuRvEAomieANS9rRzCOELNyM9IlR8h/52JUcHQklkJSr9kJxppN5jf2oHjvKBc8utUmsrAccYqbzjZpsYfQSpMEq1CMDxXbB4FEp5cl5FjB5wd04o1Gd+Oqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AugU10fV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=4g36lKE3UumaT2D2H6UQxYvi04wWUVzx4R2hCuMHUWw=; b=AugU10fVMPB10fW3/qQjEvoAKF
	vaEv0MWfZ5IXLz0RJdM+gfKIzYYxS0O5V7bkLj4yl0Clvh9oQplpRW2xmhb8dIwxdEl3D1eBV5Qwh
	aegGBP7eOatbBXSX359ZXcpHcT9qdrJZ7QQGEOMHL+3OqGmEkfRBRaMyxFH40SnwfaDl7y1DIWN7U
	0q1+XLYATrEQDOvJP48Ia3XF+ZjPKMiEo3Djbjj/LBqbaK+YVDhEYOW0cWww74jHiJM/EAkt3/zVH
	Zl2Yg4Jptg5RRm5ZJc2bn7cunHoR6kiGVU4dC5ER2Z5gW0iBMedE+e2em9+Rm8/B2ATyySUL1FXbA
	KLbmY/dg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1se0LX-0000000H9ZW-3eU1;
	Tue, 13 Aug 2024 22:50:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 54E47302DAB; Wed, 14 Aug 2024 00:50:29 +0200 (CEST)
Message-Id: <20240813224016.367421076@infradead.org>
User-Agent: quilt/0.65
Date: Wed, 14 Aug 2024 00:25:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org,
 tj@kernel.org,
 void@manifault.com
Cc: peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 linux-kernel@vger.kernel.org,
 joelaf@google.com
Subject: [PATCH 8/9] sched: Add put_prev_task(.next)
References: <20240813222548.049744955@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

In order to tell the previous sched_class what the next task is, add
put_prev_task(.next).

Notable SCX will use this to:

 1) determine the next task will leave the SCX sched class and push
    the current task to another CPU if possible.
 2) statistics on how often and which other classes preempt it

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/deadline.c  |    2 +-
 kernel/sched/fair.c      |    2 +-
 kernel/sched/idle.c      |    2 +-
 kernel/sched/rt.c        |    2 +-
 kernel/sched/sched.h     |    6 +++---
 kernel/sched/stop_task.c |    2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2442,7 +2442,7 @@ static struct task_struct *pick_task_dl(
 	return __pick_task_dl(rq);
 }
 
-static void put_prev_task_dl(struct rq *rq, struct task_struct *p)
+static void put_prev_task_dl(struct rq *rq, struct task_struct *p, struct task_struct *next)
 {
 	struct sched_dl_entity *dl_se = &p->dl;
 	struct dl_rq *dl_rq = &rq->dl;
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8867,7 +8867,7 @@ void fair_server_init(struct rq *rq)
 /*
  * Account for a descheduled task:
  */
-static void put_prev_task_fair(struct rq *rq, struct task_struct *prev)
+static void put_prev_task_fair(struct rq *rq, struct task_struct *prev, struct task_struct *next)
 {
 	struct sched_entity *se = &prev->se;
 	struct cfs_rq *cfs_rq;
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -450,7 +450,7 @@ static void wakeup_preempt_idle(struct r
 	resched_curr(rq);
 }
 
-static void put_prev_task_idle(struct rq *rq, struct task_struct *prev)
+static void put_prev_task_idle(struct rq *rq, struct task_struct *prev, struct task_struct *next)
 {
 	dl_server_update_idle_time(rq, prev);
 }
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1748,7 +1748,7 @@ static struct task_struct *pick_task_rt(
 	return p;
 }
 
-static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
+static void put_prev_task_rt(struct rq *rq, struct task_struct *p, struct task_struct *next)
 {
 	struct sched_rt_entity *rt_se = &p->rt;
 	struct rt_rq *rt_rq = &rq->rt;
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2314,7 +2314,7 @@ struct sched_class {
 	 */
 	struct task_struct *(*pick_next_task)(struct rq *rq, struct task_struct *prev);
 
-	void (*put_prev_task)(struct rq *rq, struct task_struct *p);
+	void (*put_prev_task)(struct rq *rq, struct task_struct *p, struct task_struct *next);
 	void (*set_next_task)(struct rq *rq, struct task_struct *p, bool first);
 
 #ifdef CONFIG_SMP
@@ -2364,7 +2364,7 @@ struct sched_class {
 static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 {
 	WARN_ON_ONCE(rq->curr != prev);
-	prev->sched_class->put_prev_task(rq, prev);
+	prev->sched_class->put_prev_task(rq, prev, NULL);
 }
 
 static inline void set_next_task(struct rq *rq, struct task_struct *next)
@@ -2393,7 +2393,7 @@ static inline void put_prev_set_next_tas
 	if (next == prev)
 		return;
 
-	prev->sched_class->put_prev_task(rq, prev);
+	prev->sched_class->put_prev_task(rq, prev, next);
 	next->sched_class->set_next_task(rq, next, true);
 }
 
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -59,7 +59,7 @@ static void yield_task_stop(struct rq *r
 	BUG(); /* the stop task should never yield, its pointless. */
 }
 
-static void put_prev_task_stop(struct rq *rq, struct task_struct *prev)
+static void put_prev_task_stop(struct rq *rq, struct task_struct *prev, struct task_struct *next)
 {
 	update_curr_common(rq);
 }



