Return-Path: <linux-kernel+bounces-285581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D77950FE2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 00:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 644321C2375F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 22:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C301AD9CE;
	Tue, 13 Aug 2024 22:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m39qjLeK"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A341AB522
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 22:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723589441; cv=none; b=DGJEUVOw4XtY0l9/RPIP4DJhhXArWmpcGHxCoav9R6jSvb0JgzTZ65m9UJKlXddnodlVrbVQ05RTtmh9WKxQuilhc/Gf2qw/lieFKMyHvwYunpk4TO5FpfuX27ujW1wJvZazaSjRQd8eKYiIA3YtHnRPCeYJhYwN9bijBEpIVN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723589441; c=relaxed/simple;
	bh=i8a8A/VUcSd/UmUIDuxLs+UOZIAkea+Jb6r9d160Nu4=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=I9yKuzK0/rRpJLZG/qLl7Uh6AgCzwMs9dMHO4FkKWVYxprugB53hNa1THMOfXY1KTSZyD20do9boQjt73qQMy1KSx7PG7HFNqzXOU5G3pPyBc6/+zzGLxDPLsbGlKYcUMB7VRmyleEAFV7+/u5XRVE9TaADw8EFLPd5NDL5YoXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m39qjLeK; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=5S1HikZ9q6jC+sQEh9d0ZhP7cP9EgQzT1qMsQkQw+30=; b=m39qjLeKFe/0SPTBUNhSlnNVyb
	HFvuJuOb4SzhJWYsksysTQHB4wjK4FVHCNyjBe6hB+wtAr1ruUP8ZH3WbVaOc5y73md0lRIlRKFfU
	flU5b8VcbRpwtdaP5mArzA4XvIVrgWTRCSVuPEv298B+gOaiUKYR3qcSFDLpPt1vXj+QviuHveMSP
	TRxSlFkIJhbzzWEc5AtMTkL99VAif0/FqxkAqH0uDF+rYXEZxZxgkKdzcw8PSWCqh1dt3s6ai6Ncm
	9OX+FoeDjPIfBeBU60QS5fsMrXMy6oTxTplxpeS/DUrLXt0IR5wEsGBH64N+LV1EQEzXF20qC+lru
	K/EvXtRw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1se0LW-00000007s11-0aZo;
	Tue, 13 Aug 2024 22:50:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 39750301D1D; Wed, 14 Aug 2024 00:50:29 +0200 (CEST)
Message-Id: <20240813224015.837303391@infradead.org>
User-Agent: quilt/0.65
Date: Wed, 14 Aug 2024 00:25:51 +0200
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
Subject: [PATCH 3/9] sched: Clean up DL server vs core sched
References: <20240813222548.049744955@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Abide by the simple rule:

  pick_next_task() := pick_task() + set_next_task(.first = true)

This allows us to trivially get rid of server_pick_next() and things
collapse nicely.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h   |    1 -
 kernel/sched/deadline.c |   18 +++++++-----------
 kernel/sched/fair.c     |   13 +------------
 kernel/sched/sched.h    |    1 -
 4 files changed, 8 insertions(+), 25 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -692,7 +692,6 @@ struct sched_dl_entity {
 	 */
 	struct rq			*rq;
 	dl_server_has_tasks_f		server_has_tasks;
-	dl_server_pick_f		server_pick_next;
 	dl_server_pick_f		server_pick_task;
 
 #ifdef CONFIG_RT_MUTEXES
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1665,12 +1665,10 @@ void dl_server_stop(struct sched_dl_enti
 
 void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 		    dl_server_has_tasks_f has_tasks,
-		    dl_server_pick_f pick_next,
 		    dl_server_pick_f pick_task)
 {
 	dl_se->rq = rq;
 	dl_se->server_has_tasks = has_tasks;
-	dl_se->server_pick_next = pick_next;
 	dl_se->server_pick_task = pick_task;
 }
 
@@ -2410,9 +2408,8 @@ static struct sched_dl_entity *pick_next
 /*
  * __pick_next_task_dl - Helper to pick the next -deadline task to run.
  * @rq: The runqueue to pick the next task from.
- * @peek: If true, just peek at the next task. Only relevant for dlserver.
  */
-static struct task_struct *__pick_next_task_dl(struct rq *rq, bool peek)
+static struct task_struct *__pick_task_dl(struct rq *rq)
 {
 	struct sched_dl_entity *dl_se;
 	struct dl_rq *dl_rq = &rq->dl;
@@ -2426,10 +2423,7 @@ static struct task_struct *__pick_next_t
 	WARN_ON_ONCE(!dl_se);
 
 	if (dl_server(dl_se)) {
-		if (IS_ENABLED(CONFIG_SMP) && peek)
-			p = dl_se->server_pick_task(dl_se);
-		else
-			p = dl_se->server_pick_next(dl_se);
+		p = dl_se->server_pick_task(dl_se);
 		if (!p) {
 			dl_se->dl_yielded = 1;
 			update_curr_dl_se(rq, dl_se, 0);
@@ -2446,7 +2440,7 @@ static struct task_struct *__pick_next_t
 #ifdef CONFIG_SMP
 static struct task_struct *pick_task_dl(struct rq *rq)
 {
-	return __pick_next_task_dl(rq, true);
+	return __pick_task_dl(rq);
 }
 #endif
 
@@ -2454,11 +2448,13 @@ static struct task_struct *pick_next_tas
 {
 	struct task_struct *p;
 
-	p = __pick_next_task_dl(rq, false);
+	p = __pick_task_dl(rq);
 	if (!p)
 		return p;
 
-	if (!p->dl_server)
+	if (p->dl_server)
+		p->sched_class->set_next_task(rq, p, true);
+	else
 		set_next_task_dl(rq, p, true);
 
 	return p;
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8860,16 +8860,7 @@ static bool fair_server_has_tasks(struct
 
 static struct task_struct *fair_server_pick_task(struct sched_dl_entity *dl_se)
 {
-#ifdef CONFIG_SMP
 	return pick_task_fair(dl_se->rq);
-#else
-	return NULL;
-#endif
-}
-
-static struct task_struct *fair_server_pick_next(struct sched_dl_entity *dl_se)
-{
-	return pick_next_task_fair(dl_se->rq, NULL, NULL);
 }
 
 void fair_server_init(struct rq *rq)
@@ -8878,9 +8869,7 @@ void fair_server_init(struct rq *rq)
 
 	init_dl_entity(dl_se);
 
-	dl_server_init(dl_se, rq, fair_server_has_tasks, fair_server_pick_next,
-		       fair_server_pick_task);
-
+	dl_server_init(dl_se, rq, fair_server_has_tasks, fair_server_pick_task);
 }
 
 /*
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -362,7 +362,6 @@ extern void dl_server_start(struct sched
 extern void dl_server_stop(struct sched_dl_entity *dl_se);
 extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 		    dl_server_has_tasks_f has_tasks,
-		    dl_server_pick_f pick_next,
 		    dl_server_pick_f pick_task);
 
 extern void dl_server_update_idle_time(struct rq *rq,



