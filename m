Return-Path: <linux-kernel+bounces-264094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A9593DEF6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 13:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7C8D1F22218
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 11:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2422F6F31E;
	Sat, 27 Jul 2024 11:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qypaa9Kr"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA265433BD
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 11:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722078146; cv=none; b=Nv/LLZB0Mv0E5lLASwbMPvraQi/Yer09rD4s62qKFzYGbE4uXeHncK5i7cRNutL1mr70QwJGtDVV2vy+jFL6nwSphSzSpLKF9UqcLPLyO2/693wQHJodyYCg55d+yqcUW4U2XKU+OZ+QfAS2ZH1rrGH8nqsKuT+A0dSQC3B7PJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722078146; c=relaxed/simple;
	bh=Fq2aw5LDEXvtEG/N7DcTZYxUnI4J2dgJCoiX5HpImTU=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=bTY0FFFAxuEgATsEtax4tZ68XvtsCLX0YDRCdYOt6IuF8FMZ/4lFuAAJ7xsuOgcKjcAXrDp7OVnrYkfGiyDSsRc04Dqnky+B0qoU8sKmuEucbZajQjdFSyMIe4f3OqPxxE1Nejm1KfjAdxGmo+5hdidx+X24PAgK9kAaEfAX6+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qypaa9Kr; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=/yEJ1pY+KW0CCS//TLlPHquy6j3QO0ymbu1f54Ni/tc=; b=qypaa9Kr2Ja/gi69iwXnUKkmJJ
	N/w7uFbSmmQDVNaS3MP5HuLEzwmOLyoIOpET6/IH4E2tJY+EWnRT0tP3MyyIOzFLRGeHDA7qgFvhv
	OmvvkLGGRGv/GV+SmrzdvPuRqWjst3mgaxg1WEh+PZUCocmOj2DteGHqAMYBpwHyWVkJmSMdP3Ue3
	wHDb7/0V10V6wsZPyb5cZTETqwU7onSi8CoXvgB1KTsMhrbmjghH7OM8LoM/y3HkR09TuvRQRkcpM
	2ye2efV44mvhtIAbdK7MBha6q1EemFESLIjGssczCfkJ/4vW6oU0Ty37hGNBFBwGvQ5BcOjOlD9a5
	rYTXanEQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXfBg-00000004QMg-0iaG;
	Sat, 27 Jul 2024 11:02:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id AD008302DAF; Sat, 27 Jul 2024 13:02:06 +0200 (CEST)
Message-Id: <20240727105029.086192709@infradead.org>
User-Agent: quilt/0.65
Date: Sat, 27 Jul 2024 12:27:40 +0200
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
Subject: [PATCH 08/24] sched: Split DEQUEUE_SLEEP from deactivate_task()
References: <20240727102732.960974693@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

As a preparation for dequeue_task() failing, and a second code-path
needing to take care of the 'success' path, split out the DEQEUE_SLEEP
path from deactivate_task().

Much thanks to Libo for spotting and fixing a TASK_ON_RQ_MIGRATING
ordering fail.

Fixed-by: Libo Chen <libo.chen@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c  |   23 +++++++++++++----------
 kernel/sched/sched.h |   14 ++++++++++++++
 2 files changed, 27 insertions(+), 10 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2036,12 +2036,23 @@ void activate_task(struct rq *rq, struct
 
 void deactivate_task(struct rq *rq, struct task_struct *p, int flags)
 {
-	WRITE_ONCE(p->on_rq, (flags & DEQUEUE_SLEEP) ? 0 : TASK_ON_RQ_MIGRATING);
+	WRITE_ONCE(p->on_rq, TASK_ON_RQ_MIGRATING);
 	ASSERT_EXCLUSIVE_WRITER(p->on_rq);
 
+	/*
+	 * Code explicitly relies on TASK_ON_RQ_MIGRATING begin set *before*
+	 * dequeue_task() and cleared *after* enqueue_task().
+	 */
+
 	dequeue_task(rq, p, flags);
 }
 
+static void block_task(struct rq *rq, struct task_struct *p, int flags)
+{
+	if (dequeue_task(rq, p, DEQUEUE_SLEEP | flags))
+		__block_task(rq, p);
+}
+
 /**
  * task_curr - is this task currently executing on a CPU?
  * @p: the task in question.
@@ -6486,9 +6497,6 @@ static void __sched notrace __schedule(u
 				!(prev_state & TASK_NOLOAD) &&
 				!(prev_state & TASK_FROZEN);
 
-			if (prev->sched_contributes_to_load)
-				rq->nr_uninterruptible++;
-
 			/*
 			 * __schedule()			ttwu()
 			 *   prev_state = prev->state;    if (p->on_rq && ...)
@@ -6500,12 +6508,7 @@ static void __sched notrace __schedule(u
 			 *
 			 * After this, schedule() must not care about p->state any more.
 			 */
-			deactivate_task(rq, prev, DEQUEUE_SLEEP | DEQUEUE_NOCLOCK);
-
-			if (prev->in_iowait) {
-				atomic_inc(&rq->nr_iowait);
-				delayacct_blkio_start();
-			}
+			block_task(rq, prev, DEQUEUE_NOCLOCK);
 		}
 		switch_count = &prev->nvcsw;
 	}
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -68,6 +68,7 @@
 #include <linux/wait_api.h>
 #include <linux/wait_bit.h>
 #include <linux/workqueue_api.h>
+#include <linux/delayacct.h>
 
 #include <trace/events/power.h>
 #include <trace/events/sched.h>
@@ -2591,6 +2592,19 @@ static inline void sub_nr_running(struct
 	sched_update_tick_dependency(rq);
 }
 
+static inline void __block_task(struct rq *rq, struct task_struct *p)
+{
+	WRITE_ONCE(p->on_rq, 0);
+	ASSERT_EXCLUSIVE_WRITER(p->on_rq);
+	if (p->sched_contributes_to_load)
+		rq->nr_uninterruptible++;
+
+	if (p->in_iowait) {
+		atomic_inc(&rq->nr_iowait);
+		delayacct_blkio_start();
+	}
+}
+
 extern void activate_task(struct rq *rq, struct task_struct *p, int flags);
 extern void deactivate_task(struct rq *rq, struct task_struct *p, int flags);
 



