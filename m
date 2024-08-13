Return-Path: <linux-kernel+bounces-285579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74758950FE0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 00:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A31761C23B51
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 22:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBA31AD9CA;
	Tue, 13 Aug 2024 22:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OSSijcG0"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD5B17B515
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 22:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723589441; cv=none; b=e4sncx7u6cRtoQgTFRvKImLfNsSRtS4bYj1G2RE6CrYDHFuZqHQrjuS6KjStSfo8pKTAtWQzyeYN/ZiysBfny9dk7Q2WTlEQd8xFa6UUh/7x/JAuBGmYU3AcvbSs834wFdSgX9q71DdQW28IINe3vnLfQVOhMkeijhIoyfD0BFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723589441; c=relaxed/simple;
	bh=oVc9IqFKqy7QuIG8uxkR7uWuhN+j12qwydbAA7W7k00=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=eo6bwcYrkhPMRCgbwKhVek3gjoiKbSXGxBq8B1hIzeT0MfcwZqbJ4KC3H1QKIBF7jHLO1O+IuLFtqMtux23uBRBL5+RZSLiZTaXRRyXlxRe3FFMnuDLfH9GaynsMNGJ9Ur0QJcVJuvsDB/MXhBfru+gAXyk/b4nXve0JYbPfB6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OSSijcG0; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=LdwJUkU98p+KR13h+P1Cw+rkaPkvIEoyHv2nL1rKICw=; b=OSSijcG01R0yC0N4CYpxpyKazi
	GIgd0Ri5vIdc9iq+flh4mZFdwBrlxbi3Ue/gg8Zegqhs/gPlm4AewYodP/tI/eOQn5nlYMsWMP//U
	Oe8kbWZJrG9bm8uJTynM4nLmVc8J0kg/Ses3YCuluWHbgo56KnMLnmvStyuwT98/OMxsANGoQDwHV
	lX17GToXxFaCkX6fsmY1PgbOCHBs/vQXTq++ffAZeQ73svDJSruurfmMoZL9eFKjoCk0N+rQAbzK9
	R0RHb1aZhlwgobBUBPVvCk6RyBGKqwoh+bjqdtocy7ktnzaPRV4eIzTCftS7URvPoA7s72MTG7FU6
	ygDT5icA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1se0LW-00000007s10-0hqd;
	Tue, 13 Aug 2024 22:50:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 348C3301195; Wed, 14 Aug 2024 00:50:29 +0200 (CEST)
Message-Id: <20240813224015.724111109@infradead.org>
User-Agent: quilt/0.65
Date: Wed, 14 Aug 2024 00:25:50 +0200
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
Subject: [PATCH 2/9] sched: Fixup set_next_task() implementations
References: <20240813222548.049744955@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

The rule is that:

  pick_next_task() := pick_task() + set_next_task(.first = true)

Turns out, there's still a few things in pick_next_task() that are
missing from that combination.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/deadline.c |    6 ++--
 kernel/sched/fair.c     |   62 ++++++++++++++++++++++++------------------------
 2 files changed, 34 insertions(+), 34 deletions(-)

--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2392,6 +2392,9 @@ static void set_next_task_dl(struct rq *
 		update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 0);
 
 	deadline_queue_push_tasks(rq);
+
+	if (hrtick_enabled(rq))
+		start_hrtick_dl(rq, &p->dl);
 }
 
 static struct sched_dl_entity *pick_next_dl_entity(struct dl_rq *dl_rq)
@@ -2458,9 +2461,6 @@ static struct task_struct *pick_next_tas
 	if (!p->dl_server)
 		set_next_task_dl(rq, p, true);
 
-	if (hrtick_enabled(rq))
-		start_hrtick_dl(rq, &p->dl);
-
 	return p;
 }
 
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8758,6 +8758,9 @@ static struct task_struct *pick_task_fai
 	return task_of(se);
 }
 
+static void __set_next_task_fair(struct rq *rq, struct task_struct *p, bool first);
+static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first);
+
 struct task_struct *
 pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
@@ -8806,33 +8809,17 @@ pick_next_task_fair(struct rq *rq, struc
 
 		put_prev_entity(cfs_rq, pse);
 		set_next_entity(cfs_rq, se);
+
+		__set_next_task_fair(rq, p, true);
 	}
 
-	goto done;
+	return p;
+
 simple:
 #endif
 	if (prev)
 		put_prev_task(rq, prev);
-
-	for_each_sched_entity(se)
-		set_next_entity(cfs_rq_of(se), se);
-
-done: __maybe_unused;
-#ifdef CONFIG_SMP
-	/*
-	 * Move the next running task to the front of
-	 * the list, so our cfs_tasks list becomes MRU
-	 * one.
-	 */
-	list_move(&p->se.group_node, &rq->cfs_tasks);
-#endif
-
-	if (hrtick_enabled_fair(rq))
-		hrtick_start_fair(rq, p);
-
-	update_misfit_status(p, rq);
-	sched_fair_update_stop_tick(rq, p);
-
+	set_next_task_fair(rq, p, true);
 	return p;
 
 idle:
@@ -13142,12 +13129,7 @@ static void switched_to_fair(struct rq *
 	}
 }
 
-/* Account for a task changing its policy or group.
- *
- * This routine is mostly called to set cfs_rq->curr field when a task
- * migrates between groups/classes.
- */
-static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
+static void __set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
 {
 	struct sched_entity *se = &p->se;
 
@@ -13160,6 +13142,27 @@ static void set_next_task_fair(struct rq
 		list_move(&se->group_node, &rq->cfs_tasks);
 	}
 #endif
+	if (!first)
+		return;
+
+	SCHED_WARN_ON(se->sched_delayed);
+
+	if (hrtick_enabled_fair(rq))
+		hrtick_start_fair(rq, p);
+
+	update_misfit_status(p, rq);
+	sched_fair_update_stop_tick(rq, p);
+}
+
+/*
+ * Account for a task changing its policy or group.
+ *
+ * This routine is mostly called to set cfs_rq->curr field when a task
+ * migrates between groups/classes.
+ */
+static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
+{
+	struct sched_entity *se = &p->se;
 
 	for_each_sched_entity(se) {
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
@@ -13169,10 +13172,7 @@ static void set_next_task_fair(struct rq
 		account_cfs_rq_runtime(cfs_rq, 0);
 	}
 
-	if (!first)
-		return;
-
-	SCHED_WARN_ON(se->sched_delayed);
+	__set_next_task_fair(rq, p, first);
 }
 
 void init_cfs_rq(struct cfs_rq *cfs_rq)



