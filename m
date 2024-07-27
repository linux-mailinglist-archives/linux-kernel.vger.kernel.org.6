Return-Path: <linux-kernel+bounces-264103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B0693DEFE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 13:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CFE41F22AFD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 11:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D7D8004F;
	Sat, 27 Jul 2024 11:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IESUCHlN"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8981F4D8D0
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 11:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722078147; cv=none; b=I3oDlFNoG72fMrJKp5nVq2p7QLNoP4mKdnvJYxQEbw+nd6lEFlsZwumT7PWNq9P29JwGqLk0/RgQbV+BLKKEB+ZHYNtioi4OoRPTaUJyf0MLis1dLJF/TQEu9P+wTykUDRmN887AbVC7Z0WUpBMagUEQvDPo0+wcLg9RtbcXr88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722078147; c=relaxed/simple;
	bh=kSvxvy4/yoYnf9FCBRWdJWzSutKP9ReoOQkAiZZfpWw=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ZHh218cU9Xily+djpQdQF/41ovVFuEiSkHzYIsdrp/Ayu+zfq4CjDjc6e5wRnlGPUEFerQ1webBr7TJGzsDGqHjej21XAwjtgwvLpE6JXsdWGNx1iifuOeCfqUh+lEkIpXu48MGwcP93WGnIe8JCM7+rrdsfFo44AMGfECAHBhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IESUCHlN; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=FG3IvHQufE/O/s5O2v8p/EyTrS09xA8nLYQquzdpLRU=; b=IESUCHlNFsxTWaa4o9gPJ5NwmH
	o7+Yi/bI0FmoCGH58MzXqHLcfHsLekutner9ktx5A7iUJ1Q/ccv2SgIyUgxBiA3Ju61uTDDudPDTf
	78YNwWLz5+7P+Y9iw0f2KlbXLDth5DSt8KiYWMrOqJne+gulS1kBn6YyH97NcEgy2KXCzf2tfFmwx
	PaEk6+NSEg/gj/7PpLI455FY9tEPev01HxGkFgVcP4eKQp4Fm2h1oXHLZN3vydle+rNFQ03OqTYEH
	TOCJ5q1d/ILn60ksKvwgGrGeCvjotECmQ1kqC1ZDOGIbhPhxrE2Z572RNjeiiqYFFkXi5wOIBJ6/7
	ZcswPJCQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXfBg-00000004QMd-0fFo;
	Sat, 27 Jul 2024 11:02:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id A069A3011E4; Sat, 27 Jul 2024 13:02:06 +0200 (CEST)
Message-Id: <20240727105028.725062368@infradead.org>
User-Agent: quilt/0.65
Date: Sat, 27 Jul 2024 12:27:37 +0200
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
Subject: [PATCH 05/24] sched/fair: Unify pick_{,next_}_task_fair()
References: <20240727102732.960974693@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Implement pick_next_task_fair() in terms of pick_task_fair() to
de-duplicate the pick loop.

More importantly, this makes all the pick loops use the
state-invariant form, which is useful to introduce further re-try
conditions in later patches.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c |   60 ++++++----------------------------------------------
 1 file changed, 8 insertions(+), 52 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8415,7 +8415,6 @@ static void check_preempt_wakeup_fair(st
 	resched_curr(rq);
 }
 
-#ifdef CONFIG_SMP
 static struct task_struct *pick_task_fair(struct rq *rq)
 {
 	struct sched_entity *se;
@@ -8427,7 +8426,7 @@ static struct task_struct *pick_task_fai
 		return NULL;
 
 	do {
-		/* When we pick for a remote RQ, we'll not have done put_prev_entity() */
+		/* Might not have done put_prev_entity() */
 		if (cfs_rq->curr && cfs_rq->curr->on_rq)
 			update_curr(cfs_rq);
 
@@ -8440,19 +8439,19 @@ static struct task_struct *pick_task_fai
 
 	return task_of(se);
 }
-#endif
 
 struct task_struct *
 pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
-	struct cfs_rq *cfs_rq = &rq->cfs;
 	struct sched_entity *se;
 	struct task_struct *p;
 	int new_tasks;
 
 again:
-	if (!sched_fair_runnable(rq))
+	p = pick_task_fair(rq);
+	if (!p)
 		goto idle;
+	se = &p->se;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	if (!prev || prev->sched_class != &fair_sched_class)
@@ -8464,52 +8463,14 @@ pick_next_task_fair(struct rq *rq, struc
 	 *
 	 * Therefore attempt to avoid putting and setting the entire cgroup
 	 * hierarchy, only change the part that actually changes.
-	 */
-
-	do {
-		struct sched_entity *curr = cfs_rq->curr;
-
-		/*
-		 * Since we got here without doing put_prev_entity() we also
-		 * have to consider cfs_rq->curr. If it is still a runnable
-		 * entity, update_curr() will update its vruntime, otherwise
-		 * forget we've ever seen it.
-		 */
-		if (curr) {
-			if (curr->on_rq)
-				update_curr(cfs_rq);
-			else
-				curr = NULL;
-
-			/*
-			 * This call to check_cfs_rq_runtime() will do the
-			 * throttle and dequeue its entity in the parent(s).
-			 * Therefore the nr_running test will indeed
-			 * be correct.
-			 */
-			if (unlikely(check_cfs_rq_runtime(cfs_rq))) {
-				cfs_rq = &rq->cfs;
-
-				if (!cfs_rq->nr_running)
-					goto idle;
-
-				goto simple;
-			}
-		}
-
-		se = pick_next_entity(cfs_rq);
-		cfs_rq = group_cfs_rq(se);
-	} while (cfs_rq);
-
-	p = task_of(se);
-
-	/*
+	 *
 	 * Since we haven't yet done put_prev_entity and if the selected task
 	 * is a different task than we started out with, try and touch the
 	 * least amount of cfs_rqs.
 	 */
 	if (prev != p) {
 		struct sched_entity *pse = &prev->se;
+		struct cfs_rq *cfs_rq;
 
 		while (!(cfs_rq = is_same_group(se, pse))) {
 			int se_depth = se->depth;
@@ -8535,13 +8496,8 @@ pick_next_task_fair(struct rq *rq, struc
 	if (prev)
 		put_prev_task(rq, prev);
 
-	do {
-		se = pick_next_entity(cfs_rq);
-		set_next_entity(cfs_rq, se);
-		cfs_rq = group_cfs_rq(se);
-	} while (cfs_rq);
-
-	p = task_of(se);
+	for_each_sched_entity(se)
+		set_next_entity(cfs_rq_of(se), se);
 
 done: __maybe_unused;
 #ifdef CONFIG_SMP



