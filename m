Return-Path: <linux-kernel+bounces-285578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED8A950FE3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 00:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3CB3B21115
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 22:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DADC1AD9D4;
	Tue, 13 Aug 2024 22:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CjZmpRHR"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AB71AB521
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 22:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723589441; cv=none; b=d+zeVjL5VGZZD5f25NCePBbYGuoSvxahpO+NC/yVkTwkOEbnlpRAu8Op/vfOi4Izp5YlbDmHBbpL3d7CrhdD9eL42SvY5df6jQ0qgtTTW0FqB8gczTRcnExBddGHILEfUE7B3DyVX3l4PUGgh/B1PJaMz6t85IloxZ3FBHSO/BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723589441; c=relaxed/simple;
	bh=hs0O2c+oaqUZ5z6NJS1vZ9jFt7Y19FGt3qinKMe6eb8=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=uVESUlNV18Q2V8DjULu4GUCtII4IIqJZlcAx41YJWnQ92dbC7L+EykWUAWeCO5f9X8oPwhySoBBhKi0qGUNoMHL67vpulvUtd/Am2EOjbWD7CqxuA9fdVZL+0OyhdIN7zQ9K6+JiRT6wEbmI531IedCcTKwq5GchH4WgbG2IZzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CjZmpRHR; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=K6xq1Qbw3/PGWUvKoHwS4tDLQnVlHu3ZZwEzlKsVe/E=; b=CjZmpRHRUh2Zjmcc4oIDFX9gst
	PWQ6T6mwuInZ/Q0oPA1RhgspojtGGN83m8AIJR2p6uvar82Db2saB73zcNxPdeA13AFGJb40BJvOF
	UwA5e67BL0oeS9Z0RcsrMOHBMgturCoGGVx7CjLC8A1rbXS4qnD/JqCXot9c5Uwtwsw/bfkQNqImR
	Fpxog/tmecXvRm1nuhOJOASL/jlKiiR2PPacR7oUOlN1MTU98S+P1KI9iBI6Y2du4Lqvi+7LXssRV
	roEA1+nQ6W9a8pQ30/OnaIbmEawa7+VlkFqF0Yz8rnwtDgVob0LNt2UpxZ3No4AFDsuCB18oxwg7n
	jCKbRnVQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1se0LX-00000007s1F-3ZNJ;
	Tue, 13 Aug 2024 22:50:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 4EDFA302D79; Wed, 14 Aug 2024 00:50:29 +0200 (CEST)
Message-Id: <20240813224016.259853414@infradead.org>
User-Agent: quilt/0.65
Date: Wed, 14 Aug 2024 00:25:55 +0200
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
Subject: [PATCH 7/9] sched: Rework dl_server
References: <20240813222548.049744955@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

When a task is selected through a dl_server, it will have p->dl_server
set, such that it can account runtime to the dl_server, see
update_curr_task().

Currently p->dl_server is set in pick*task() whenever it goes through
the dl_server, clearing it is a bit of a mess though. The trivial
solution is clearing it on the final put (now that we have this
location).

However, this gives a problem when:

	p = pick_task(rq);
	if (p)
		put_prev_set_next_task(rq, prev, next);

picks the same task but through a different path, notably when it goes
from picking through the dl_server to a direct pick or vice-versa. In
that case we cannot readily determine wether we should clear or
preserve p->dl_server.

An additional complication is pick_*task() setting p->dl_server for a
remote pick, it might still need to update runtime before it schedules
the core_pick.

Close all these holes and remove all the random clearing of
p->dl_server by:

 - having pick_*task() manage rq->dl_server

 - having the final put_prev_task() clear p->dl_server

 - having the first set_next_task() set p->dl_server = rq->dl_server

 - complicate the core_sched code to save/restore rq->dl_server where
   appropriate.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c     |   40 +++++++++++++++-------------------------
 kernel/sched/deadline.c |    2 +-
 kernel/sched/fair.c     |   10 ++--------
 kernel/sched/sched.h    |   14 ++++++++++++++
 4 files changed, 32 insertions(+), 34 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3668,8 +3668,6 @@ ttwu_do_activate(struct rq *rq, struct t
 		rq->idle_stamp = 0;
 	}
 #endif
-
-	p->dl_server = NULL;
 }
 
 /*
@@ -5859,14 +5857,6 @@ static void prev_balance(struct rq *rq,
 			break;
 	}
 #endif
-
-	/*
-	 * We've updated @prev and no longer need the server link, clear it.
-	 * Must be done before ->pick_next_task() because that can (re)set
-	 * ->dl_server.
-	 */
-	if (prev->dl_server)
-		prev->dl_server = NULL;
 }
 
 /*
@@ -5878,6 +5868,8 @@ __pick_next_task(struct rq *rq, struct t
 	const struct sched_class *class;
 	struct task_struct *p;
 
+	rq->dl_server = NULL;
+
 	/*
 	 * Optimization: we know that if all tasks are in the fair class we can
 	 * call that function directly, but only if the @prev task wasn't of a
@@ -5897,20 +5889,6 @@ __pick_next_task(struct rq *rq, struct t
 			put_prev_set_next_task(rq, prev, p);
 		}
 
-		/*
-		 * This is a normal CFS pick, but the previous could be a DL pick.
-		 * Clear it as previous is no longer picked.
-		 */
-		if (prev->dl_server)
-			prev->dl_server = NULL;
-
-		/*
-		 * This is the fast path; it cannot be a DL server pick;
-		 * therefore even if @p == @prev, ->dl_server must be NULL.
-		 */
-		if (p->dl_server)
-			p->dl_server = NULL;
-
 		return p;
 	}
 
@@ -5958,6 +5936,8 @@ static inline struct task_struct *pick_t
 	const struct sched_class *class;
 	struct task_struct *p;
 
+	rq->dl_server = NULL;
+
 	for_each_class(class) {
 		p = class->pick_task(rq);
 		if (p)
@@ -5996,6 +5976,7 @@ pick_next_task(struct rq *rq, struct tas
 		 * another cpu during offline.
 		 */
 		rq->core_pick = NULL;
+		rq->core_dl_server = NULL;
 		return __pick_next_task(rq, prev, rf);
 	}
 
@@ -6014,7 +5995,9 @@ pick_next_task(struct rq *rq, struct tas
 		WRITE_ONCE(rq->core_sched_seq, rq->core->core_pick_seq);
 
 		next = rq->core_pick;
+		rq->dl_server = rq->core_dl_server;
 		rq->core_pick = NULL;
+		rq->core_dl_server = NULL;
 		goto out_set_next;
 	}
 
@@ -6059,6 +6042,7 @@ pick_next_task(struct rq *rq, struct tas
 		next = pick_task(rq);
 		if (!next->core_cookie) {
 			rq->core_pick = NULL;
+			rq->core_dl_server = NULL;
 			/*
 			 * For robustness, update the min_vruntime_fi for
 			 * unconstrained picks as well.
@@ -6086,7 +6070,9 @@ pick_next_task(struct rq *rq, struct tas
 		if (i != cpu && (rq_i != rq->core || !core_clock_updated))
 			update_rq_clock(rq_i);
 
-		p = rq_i->core_pick = pick_task(rq_i);
+		rq_i->core_pick = p = pick_task(rq_i);
+		rq_i->core_dl_server = rq_i->dl_server;
+
 		if (!max || prio_less(max, p, fi_before))
 			max = p;
 	}
@@ -6110,6 +6096,7 @@ pick_next_task(struct rq *rq, struct tas
 		}
 
 		rq_i->core_pick = p;
+		rq_i->core_dl_server = NULL;
 
 		if (p == rq_i->idle) {
 			if (rq_i->nr_running) {
@@ -6170,6 +6157,7 @@ pick_next_task(struct rq *rq, struct tas
 
 		if (i == cpu) {
 			rq_i->core_pick = NULL;
+			rq_i->core_dl_server = NULL;
 			continue;
 		}
 
@@ -6178,6 +6166,7 @@ pick_next_task(struct rq *rq, struct tas
 
 		if (rq_i->curr == rq_i->core_pick) {
 			rq_i->core_pick = NULL;
+			rq_i->core_dl_server = NULL;
 			continue;
 		}
 
@@ -8401,6 +8390,7 @@ void __init sched_init(void)
 #ifdef CONFIG_SCHED_CORE
 		rq->core = rq;
 		rq->core_pick = NULL;
+		rq->core_dl_server = NULL;
 		rq->core_enabled = 0;
 		rq->core_tree = RB_ROOT;
 		rq->core_forceidle_count = 0;
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2429,7 +2429,7 @@ static struct task_struct *__pick_task_d
 			update_curr_dl_se(rq, dl_se, 0);
 			goto again;
 		}
-		p->dl_server = dl_se;
+		rq->dl_server = dl_se;
 	} else {
 		p = dl_task_of(dl_se);
 	}
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8747,14 +8747,6 @@ static struct task_struct *pick_task_fai
 		cfs_rq = group_cfs_rq(se);
 	} while (cfs_rq);
 
-	/*
-	 * This can be called from directly from CFS's ->pick_task() or indirectly
-	 * from DL's ->pick_task when fair server is enabled. In the indirect case,
-	 * DL will set ->dl_server just after this function is called, so its Ok to
-	 * clear. In the direct case, we are picking directly so we must clear it.
-	 */
-	task_of(se)->dl_server = NULL;
-
 	return task_of(se);
 }
 
@@ -8778,6 +8770,8 @@ pick_next_task_fair(struct rq *rq, struc
 	if (prev->sched_class != &fair_sched_class)
 		goto simple;
 
+	__put_prev_set_next_dl_server(rq, prev, p);
+
 	/*
 	 * Because of the set_next_buddy() in dequeue_task_fair() it is rather
 	 * likely that a next task is from the same cgroup as the current.
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1066,6 +1066,7 @@ struct rq {
 	unsigned int		nr_uninterruptible;
 
 	struct task_struct __rcu	*curr;
+	struct sched_dl_entity	*dl_server;
 	struct task_struct	*idle;
 	struct task_struct	*stop;
 	unsigned long		next_balance;
@@ -1193,6 +1194,7 @@ struct rq {
 	/* per rq */
 	struct rq		*core;
 	struct task_struct	*core_pick;
+	struct sched_dl_entity	*core_dl_server;
 	unsigned int		core_enabled;
 	unsigned int		core_sched_seq;
 	struct rb_root		core_tree;
@@ -2370,12 +2372,24 @@ static inline void set_next_task(struct
 	next->sched_class->set_next_task(rq, next, false);
 }
 
+static inline void
+__put_prev_set_next_dl_server(struct rq *rq,
+			      struct task_struct *prev,
+			      struct task_struct *next)
+{
+	prev->dl_server = NULL;
+	next->dl_server = rq->dl_server;
+	rq->dl_server = NULL;
+}
+
 static inline void put_prev_set_next_task(struct rq *rq,
 					  struct task_struct *prev,
 					  struct task_struct *next)
 {
 	WARN_ON_ONCE(rq->curr != prev);
 
+	__put_prev_set_next_dl_server(rq, prev, next);
+
 	if (next == prev)
 		return;
 



