Return-Path: <linux-kernel+bounces-264112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9B093DF0E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 13:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA4E6286E3A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 11:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9481113B290;
	Sat, 27 Jul 2024 11:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T0Hhd/lQ"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C47676C61
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 11:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722078149; cv=none; b=UKJtWcxLso3P2IgJiwrH3hDi8RaX+7x2ihUlD/My29T1fIls81LwtqKAWkxNXJJc71G9tNDrsRWZbOGyarTJKBcNQpBZ4Lfj+Q2Y7EHKtPk3v8aA9XBgShwB5i1WCpV3E3aDFd26ffTwvyDQSx4fg8MLFUPFWOCaJUUX5aTPiKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722078149; c=relaxed/simple;
	bh=UjpvSUfzFnwK76Bs7wFDqK5xuHrje2T2yPFj2mB7/4k=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=F9RCfedleXc0QloM7dAkr2gt8Zw7gpHyEYonq9PxRNR4UkdZgxSPRR7W5pmLjyQFxViPIi4IyfqM9Pl1boU+CbHyyWQGcJ5meTof9JGxw4gDoJTfeTUVGpgeoSk3W/IDJVrXZFE+Vw36056uEWvQBMIj02hfwr8gPgwomFUvfZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T0Hhd/lQ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=Wypbsa8TcX0ssA9GJe6UbYub1r9G8dWt4safnPicCkk=; b=T0Hhd/lQOs7Nfrx2Ye5Q9fSmpc
	lpxF2w2pZaksqrXeSTruK8hhZYbdZk0p1DLXVp8KHbnu/tHEXPr8vMf9Cc5A0r3eZH7Vm7px/Hbgg
	Xcn2/jF7GengsO6phxM8NuVbEckbcNjl2yv8Z7rCqbCKG2SkeqBS6p2Hn0KS0VJOOV1IbJxb0qqvp
	+rEg+C8EYPugVEl07WtVECS/EDCLrmIbNtFOvN/EKYJwklvbRovgOL7oebc3QwcMH6R0Bndgdjydu
	PWe1v9PFsNtEU2JyvRvDvE6z6+qo6C337HfQQy0CSUXMRtJHcKPcyIYVDKoc7QBE3YWY7zYZgulHM
	HAL+NF0A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXfBg-00000004QMm-1exh;
	Sat, 27 Jul 2024 11:02:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id C696D306155; Sat, 27 Jul 2024 13:02:06 +0200 (CEST)
Message-Id: <20240727105029.747330118@infradead.org>
User-Agent: quilt/0.65
Date: Sat, 27 Jul 2024 12:27:45 +0200
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
Subject: [PATCH 13/24] sched/fair: Prepare pick_next_task() for delayed dequeue
References: <20240727102732.960974693@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Delayed dequeue's natural end is when it gets picked again. Ensure
pick_next_task() knows what to do with delayed tasks.

Note, this relies on the earlier patch that made pick_next_task()
state invariant -- it will restart the pick on dequeue, because
obviously the just dequeued task is no longer eligible.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c |   23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5453,6 +5453,8 @@ set_next_entity(struct cfs_rq *cfs_rq, s
 	se->prev_sum_exec_runtime = se->sum_exec_runtime;
 }
 
+static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags);
+
 /*
  * Pick the next process, keeping these things in mind, in this order:
  * 1) keep things fair between processes/task groups
@@ -5461,16 +5463,27 @@ set_next_entity(struct cfs_rq *cfs_rq, s
  * 4) do not run the "skip" process, if something else is available
  */
 static struct sched_entity *
-pick_next_entity(struct cfs_rq *cfs_rq)
+pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
 {
 	/*
 	 * Enabling NEXT_BUDDY will affect latency but not fairness.
 	 */
 	if (sched_feat(NEXT_BUDDY) &&
-	    cfs_rq->next && entity_eligible(cfs_rq, cfs_rq->next))
+	    cfs_rq->next && entity_eligible(cfs_rq, cfs_rq->next)) {
+		/* ->next will never be delayed */
+		SCHED_WARN_ON(cfs_rq->next->sched_delayed);
 		return cfs_rq->next;
+	}
+
+	struct sched_entity *se = pick_eevdf(cfs_rq);
+	if (se->sched_delayed) {
+		dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
+		SCHED_WARN_ON(se->sched_delayed);
+		SCHED_WARN_ON(se->on_rq);
 
-	return pick_eevdf(cfs_rq);
+		return NULL;
+	}
+	return se;
 }
 
 static bool check_cfs_rq_runtime(struct cfs_rq *cfs_rq);
@@ -8478,7 +8491,9 @@ static struct task_struct *pick_task_fai
 		if (unlikely(check_cfs_rq_runtime(cfs_rq)))
 			goto again;
 
-		se = pick_next_entity(cfs_rq);
+		se = pick_next_entity(rq, cfs_rq);
+		if (!se)
+			goto again;
 		cfs_rq = group_cfs_rq(se);
 	} while (cfs_rq);
 



