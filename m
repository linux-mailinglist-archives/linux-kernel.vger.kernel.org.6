Return-Path: <linux-kernel+bounces-285577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 792A3950FDF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 00:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F08E1283DB9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 22:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F291AC43D;
	Tue, 13 Aug 2024 22:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hMIDXkBx"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C351AB51F
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 22:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723589441; cv=none; b=PE7MFeS0RFyHI2SiyJSldBWFicGxGv91I5QeLqeZNkkGwLs/GdcMLdUhaWTrkDNUTKToKzbAunGPuyRuF1a9KCksRJmVsCp0hiJJgNA5m799QfG7yHd4Pt7S3un1DmD6Di71YOr/A+1D9cJw8O6SDZCi//I7SqDeR4p4pDf1oug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723589441; c=relaxed/simple;
	bh=JDVcqKByKpkk/XFjkq6PeFMESkaTJiG8CDpqXb8Zuic=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=kPQqUXHGUyxa9rTPOept8RCZvdXIcHdvghzG/NwoRXVztteG7OsOgvZk7aLhhJcS91AgHgoJakR/DsCcVxQ09/i/9EWcS3Kga++1Kr2FLNPRz19pP1+namuRMtvxlr/v/pPYdCE8Alc/ui4SnacLPdmR90q/uFdR9iCUDqLvwxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hMIDXkBx; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=rPs5bSfp4cnPNS65oXy8urZjJQLEvY/WVkoVOqdQkmU=; b=hMIDXkBxwZ/gQ6mOaj4i3nTxRx
	COOjDGjg4iYVbxD4v2AX9hdLiS33irehZ7nb+ir4bHvqlzBEH8o/pMrxBNSwLVuwTFCSjdEOu3FW3
	TvIfmaXc5+O11grusj4G/6A14YuuH7zMzGCRBwHLB0T0R8/CSGL19e0lKNn4GZE1AszDZXP2PM//W
	00cx6W0ywkTfydlJAXXfZ7ecptxLfxYES/AvrRdm78mz1LBmdUfZcz8TsrStJnIFugNp0FdGQlfgs
	4u7fPGfWnCHYGvPpi6ySgABRlY7IBVIQVc19GW9jg0hvyusJ0pspsHzcdtQB9Jg8Pt1nMNGvZht+8
	KV+dHgNg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1se0LY-0000000H9ZX-097E;
	Tue, 13 Aug 2024 22:50:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 59F17302DB1; Wed, 14 Aug 2024 00:50:29 +0200 (CEST)
Message-Id: <20240813224016.471745809@infradead.org>
User-Agent: quilt/0.65
Date: Wed, 14 Aug 2024 00:25:57 +0200
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
Subject: [PATCH 9/9] sched: Add pick_task(.core)
References: <20240813222548.049744955@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

In order to distinguish between a regular vs a core pick_task()
invocation, add a boolean argument.

Notably SCX seems to need this, since its core pick

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h    |    2 +-
 kernel/sched/core.c      |    8 ++++----
 kernel/sched/deadline.c  |    9 ++-------
 kernel/sched/fair.c      |    9 +++++----
 kernel/sched/idle.c      |    2 +-
 kernel/sched/rt.c        |    2 +-
 kernel/sched/sched.h     |    4 ++--
 kernel/sched/stop_task.c |    2 +-
 8 files changed, 17 insertions(+), 21 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -601,7 +601,7 @@ struct sched_rt_entity {
 } __randomize_layout;
 
 typedef bool (*dl_server_has_tasks_f)(struct sched_dl_entity *);
-typedef struct task_struct *(*dl_server_pick_f)(struct sched_dl_entity *);
+typedef struct task_struct *(*dl_server_pick_f)(struct sched_dl_entity *, bool);
 
 struct sched_dl_entity {
 	struct rb_node			rb_node;
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5885,7 +5885,7 @@ __pick_next_task(struct rq *rq, struct t
 
 		/* Assume the next prioritized class is idle_sched_class */
 		if (!p) {
-			p = pick_task_idle(rq);
+			p = pick_task_idle(rq, false);
 			put_prev_set_next_task(rq, prev, p);
 		}
 
@@ -5901,7 +5901,7 @@ __pick_next_task(struct rq *rq, struct t
 			if (p)
 				return p;
 		} else {
-			p = class->pick_task(rq);
+			p = class->pick_task(rq, false);
 			if (p) {
 				put_prev_set_next_task(rq, prev, p);
 				return p;
@@ -5939,7 +5939,7 @@ static inline struct task_struct *pick_t
 	rq->dl_server = NULL;
 
 	for_each_class(class) {
-		p = class->pick_task(rq);
+		p = class->pick_task(rq, true);
 		if (p)
 			return p;
 	}
@@ -6092,7 +6092,7 @@ pick_next_task(struct rq *rq, struct tas
 			if (cookie)
 				p = sched_core_find(rq_i, cookie);
 			if (!p)
-				p = idle_sched_class.pick_task(rq_i);
+				p = idle_sched_class.pick_task(rq_i, true);
 		}
 
 		rq_i->core_pick = p;
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2409,7 +2409,7 @@ static struct sched_dl_entity *pick_next
  * __pick_next_task_dl - Helper to pick the next -deadline task to run.
  * @rq: The runqueue to pick the next task from.
  */
-static struct task_struct *__pick_task_dl(struct rq *rq)
+static struct task_struct *pick_task_dl(struct rq *rq, bool core)
 {
 	struct sched_dl_entity *dl_se;
 	struct dl_rq *dl_rq = &rq->dl;
@@ -2423,7 +2423,7 @@ static struct task_struct *__pick_task_d
 	WARN_ON_ONCE(!dl_se);
 
 	if (dl_server(dl_se)) {
-		p = dl_se->server_pick_task(dl_se);
+		p = dl_se->server_pick_task(dl_se, core);
 		if (!p) {
 			dl_se->dl_yielded = 1;
 			update_curr_dl_se(rq, dl_se, 0);
@@ -2437,11 +2437,6 @@ static struct task_struct *__pick_task_d
 	return p;
 }
 
-static struct task_struct *pick_task_dl(struct rq *rq)
-{
-	return __pick_task_dl(rq);
-}
-
 static void put_prev_task_dl(struct rq *rq, struct task_struct *p, struct task_struct *next)
 {
 	struct sched_dl_entity *dl_se = &p->dl;
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8723,7 +8723,7 @@ static void check_preempt_wakeup_fair(st
 	resched_curr(rq);
 }
 
-static struct task_struct *pick_task_fair(struct rq *rq)
+static struct task_struct *pick_task_fair(struct rq *rq, bool core)
 {
 	struct sched_entity *se;
 	struct cfs_rq *cfs_rq;
@@ -8761,7 +8761,7 @@ pick_next_task_fair(struct rq *rq, struc
 	int new_tasks;
 
 again:
-	p = pick_task_fair(rq);
+	p = pick_task_fair(rq, false);
 	if (!p)
 		goto idle;
 	se = &p->se;
@@ -8850,9 +8850,10 @@ static bool fair_server_has_tasks(struct
 	return !!dl_se->rq->cfs.nr_running;
 }
 
-static struct task_struct *fair_server_pick_task(struct sched_dl_entity *dl_se)
+static struct task_struct *
+fair_server_pick_task(struct sched_dl_entity *dl_se, bool core)
 {
-	return pick_task_fair(dl_se->rq);
+	return pick_task_fair(dl_se->rq, core);
 }
 
 void fair_server_init(struct rq *rq)
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -462,7 +462,7 @@ static void set_next_task_idle(struct rq
 	next->se.exec_start = rq_clock_task(rq);
 }
 
-struct task_struct *pick_task_idle(struct rq *rq)
+struct task_struct *pick_task_idle(struct rq *rq, bool core)
 {
 	return rq->idle;
 }
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1736,7 +1736,7 @@ static struct task_struct *_pick_next_ta
 	return rt_task_of(rt_se);
 }
 
-static struct task_struct *pick_task_rt(struct rq *rq)
+static struct task_struct *pick_task_rt(struct rq *rq, bool core)
 {
 	struct task_struct *p;
 
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2302,7 +2302,7 @@ struct sched_class {
 
 	void (*wakeup_preempt)(struct rq *rq, struct task_struct *p, int flags);
 
-	struct task_struct *(*pick_task)(struct rq *rq);
+	struct task_struct *(*pick_task)(struct rq *rq, bool core);
 	/*
 	 * Optional! When implemented pick_next_task() should be equivalent to:
 	 *
@@ -2451,7 +2451,7 @@ static inline bool sched_fair_runnable(s
 }
 
 extern struct task_struct *pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
-extern struct task_struct *pick_task_idle(struct rq *rq);
+extern struct task_struct *pick_task_idle(struct rq *rq, bool core);
 
 #define SCA_CHECK		0x01
 #define SCA_MIGRATE_DISABLE	0x02
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -33,7 +33,7 @@ static void set_next_task_stop(struct rq
 	stop->se.exec_start = rq_clock_task(rq);
 }
 
-static struct task_struct *pick_task_stop(struct rq *rq)
+static struct task_struct *pick_task_stop(struct rq *rq, bool core)
 {
 	if (!sched_stop_runnable(rq))
 		return NULL;



