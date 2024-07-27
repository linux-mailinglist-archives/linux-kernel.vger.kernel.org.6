Return-Path: <linux-kernel+bounces-264096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCB393DEF8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 13:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD1891F22AA6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 11:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C5F7D3EC;
	Sat, 27 Jul 2024 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q0MppEeT"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA22F20DE8
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 11:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722078146; cv=none; b=oqVJEAWt1bOBOuz1ht1wAx8z/pX3XPdlMEtZVs2lVkJoeunB4B8DBW+hdtktpmylzrLfGAknqtfG9WpNcUT4fmgMyK6yT+yt5CTQIyzxMvtVIkaoupIIOmNLMcFZwFPYMsgPlxao4aoiLYeqvbu99TM5znrl1QYRG2YaX/d3H1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722078146; c=relaxed/simple;
	bh=A2CZohtVVQVvdFwTyK6Q/keDVxatN8INOXhy5uX3XdE=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=kwvYVuL5zMLEVC/sYq9e6uPdPztGBOO1lqCD2eJWCpoKA9yYo7x7/MgVFsMl+ev1ZxEGiwJ7qWZr/grcW/8wmjW6wwVO7I1Zbgsu3GucIrRyaJDCR4ye8OR3LNwLT36NFcXIl6YRIIejJf6f5J0eeaBmFHcv8PL74QiTvqfiSNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=q0MppEeT; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=Jwg5pijGEsgzZg4N0bmmotKdfYZQrvKWZdWkHQdbCk8=; b=q0MppEeTrji6u4UU3vlyyzBcDt
	Pg3B84116ibp+Q3ZcyqTxujAv6vYcWBClxks9pFOmO/hm074Cc35DnZepeLR9GS3YuFugfRSfzEq2
	3RjwBJbDCHL6pfkx9Ci9Aa80l3Uvxp2SkpxgGFwrnd+g2hauoSBwVquLiD0TSHxFn+v9d1FzPUmJ0
	K4X+T4R/iCKSVXuHAfv00HKvlIVES5DFFRyrieN/v0/Z262dILrYjPv1OR7+eXuiu3//CUcEVcneM
	Y8L/M9Y6kJsBKOt460IO31curZA6/pj3VDf130ymX4fw++MXMONvTFiwrx2AWQGE+hK0tnjhmYpoj
	tMkwoy6w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXfBg-00000004QMh-0iVm;
	Sat, 27 Jul 2024 11:02:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id B1C01302DF4; Sat, 27 Jul 2024 13:02:06 +0200 (CEST)
Message-Id: <20240727105029.200000445@infradead.org>
User-Agent: quilt/0.65
Date: Sat, 27 Jul 2024 12:27:41 +0200
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
Subject: [PATCH 09/24] sched: Prepare generic code for delayed dequeue
References: <20240727102732.960974693@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

While most of the delayed dequeue code can be done inside the
sched_class itself, there is one location where we do not have an
appropriate hook, namely ttwu_runnable().

Add an ENQUEUE_DELAYED call to the on_rq path to deal with waking
delayed dequeue tasks.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h |    1 +
 kernel/sched/core.c   |   17 ++++++++++++++++-
 kernel/sched/sched.h  |    2 ++
 3 files changed, 19 insertions(+), 1 deletion(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -542,6 +542,7 @@ struct sched_entity {
 
 	struct list_head		group_node;
 	unsigned int			on_rq;
+	unsigned int			sched_delayed;
 
 	u64				exec_start;
 	u64				sum_exec_runtime;
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2036,6 +2036,8 @@ void activate_task(struct rq *rq, struct
 
 void deactivate_task(struct rq *rq, struct task_struct *p, int flags)
 {
+	SCHED_WARN_ON(flags & DEQUEUE_SLEEP);
+
 	WRITE_ONCE(p->on_rq, TASK_ON_RQ_MIGRATING);
 	ASSERT_EXCLUSIVE_WRITER(p->on_rq);
 
@@ -3677,12 +3679,14 @@ static int ttwu_runnable(struct task_str
 
 	rq = __task_rq_lock(p, &rf);
 	if (task_on_rq_queued(p)) {
+		update_rq_clock(rq);
+		if (p->se.sched_delayed)
+			enqueue_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_DELAYED);
 		if (!task_on_cpu(rq, p)) {
 			/*
 			 * When on_rq && !on_cpu the task is preempted, see if
 			 * it should preempt the task that is current now.
 			 */
-			update_rq_clock(rq);
 			wakeup_preempt(rq, p, wake_flags);
 		}
 		ttwu_do_wakeup(p);
@@ -4062,11 +4069,16 @@ int try_to_wake_up(struct task_struct *p
 		 * case the whole 'p->on_rq && ttwu_runnable()' case below
 		 * without taking any locks.
 		 *
+		 * Specifically, given current runs ttwu() we must be before
+		 * schedule()'s block_task(), as such this must not observe
+		 * sched_delayed.
+		 *
 		 * In particular:
 		 *  - we rely on Program-Order guarantees for all the ordering,
 		 *  - we're serialized against set_special_state() by virtue of
 		 *    it disabling IRQs (this allows not taking ->pi_lock).
 		 */
+		SCHED_WARN_ON(p->se.sched_delayed);
 		if (!ttwu_state_match(p, state, &success))
 			goto out;
 
@@ -4358,6 +4370,9 @@ static void __sched_fork(unsigned long c
 	p->se.slice			= sysctl_sched_base_slice;
 	INIT_LIST_HEAD(&p->se.group_node);
 
+	/* A delayed task cannot be in clone(). */
+	SCHED_WARN_ON(p->se.sched_delayed);
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	p->se.cfs_rq			= NULL;
 #endif
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2258,6 +2258,7 @@ extern const u32		sched_prio_to_wmult[40
 #define DEQUEUE_MOVE		0x04 /* Matches ENQUEUE_MOVE */
 #define DEQUEUE_NOCLOCK		0x08 /* Matches ENQUEUE_NOCLOCK */
 #define DEQUEUE_MIGRATING	0x100 /* Matches ENQUEUE_MIGRATING */
+#define DEQUEUE_DELAYED		0x200 /* Matches ENQUEUE_DELAYED */
 
 #define ENQUEUE_WAKEUP		0x01
 #define ENQUEUE_RESTORE		0x02
@@ -2273,6 +2274,7 @@ extern const u32		sched_prio_to_wmult[40
 #endif
 #define ENQUEUE_INITIAL		0x80
 #define ENQUEUE_MIGRATING	0x100
+#define ENQUEUE_DELAYED		0x200
 
 #define RETRY_TASK		((void *)-1UL)
 



