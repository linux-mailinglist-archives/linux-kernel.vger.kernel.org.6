Return-Path: <linux-kernel+bounces-384681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DD19B2D2A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 430A31C21A32
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39331D8E1E;
	Mon, 28 Oct 2024 10:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uFVucZTZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WwsBABA4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0D71D88B1
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112226; cv=none; b=UKp+MJZVFFCEW3W2WQcrMqI1JDqU5EMJ2jmxMOEWqaEItlzL416k5XXMxpQFmT6JoV62/c7i84nW6K/7sl7f11mAE5gmQ6drswLb/O+N40fJEG90XBWjq1NxRiBqsvXJ1jreGz3AMx7lN5YESpBFCIotKUmTCdqi/TjkpAWWyro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112226; c=relaxed/simple;
	bh=ipQrO0L1c/KaKus/S+ob2UFnyolNm0aZT1lrfgIVT7Q=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=hNXFeVyzYAq6cItuWLM0uWPrR08oIvL2ozr0C8m7/TxtBni+szX5VVqMfY1I3JkLq1n/vFCI3WMppcoFbSXnbH2jAy7lz+RpZs23AYEiUU6DsKOSIeAcrJpfdvkp+iFWo51GHWfY481PYglc/VI+4V3KtDtgCZBCAIkj7zuPF2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uFVucZTZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WwsBABA4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241028103142.359584747@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730112222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=IygJzwRz1dGBlMSu6nhuCmf8n7Jtd/1+VfsTEUY9q7Y=;
	b=uFVucZTZR+4InRh4oIsyea3Tk+ZQCQtJRIejn13qgu8WIAjGxJ5tsgb9Pl+wkCFtnS/FJC
	6wcJwicOImjb9K1ZKYvinzGfvdNRBg3F/NLLsHbhe1vTCu4Fw252X2QCF8pahNBJUD4ufI
	VXdatPkVARH+mncL7ND9+SJ+VQl4DPXW9IiZfilFSlSq2wvlM/4nRJhJjGjHhd5f0DKFEj
	YwPlLne7U65iVFGrFSDeVNur/ounaMXa4P7gtS/b67umrK0sqSuxleBr4K2bO9j72iw7Dg
	mvzgTe9OHMbVCvjIcKns+06qrDudS3uMrEFJzNTvvzHSv3X+ISuzKVM0qpDgkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730112222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=IygJzwRz1dGBlMSu6nhuCmf8n7Jtd/1+VfsTEUY9q7Y=;
	b=WwsBABA4vKDg8E7/elp1uQpqZ2Q18/D1Du8Ds6GhCYLbgUMK3WIYu+otF4yqtbU5i1zdHU
	49b1mrgIMoNm7+BA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>,
 Tejun Heo <tj@kernel.org>,
 David Vernet <void@manifault.com>,
 Ingo Molnar <mingo@kernel.org.com>
Subject: [patch 1/2] sched: Initialize idle tasks only once
References: <20241028103006.008053168@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Oct 2024 11:43:42 +0100 (CET)

Idle tasks are initialized via __sched_fork() twice:

     fork_idle()
        copy_process()
	  sched_fork()
             __sched_fork()
	init_idle()
          __sched_fork()
  
Instead of cleaning this up, sched_ext hacked around it. Even when analyis
and solution were provided in a discussion, nobody cared to clean this up.

init_idle() is also invoked from sched_init() to initialize the boot CPU's
idle task, which requires the __sched_fork() invocation. But this can be
trivially solved by invoking __sched_fork() before init_idle() in
sched_init() and removing the __sched_fork() invocation from init_idle().

Do so and clean up the comments explaining this historical leftover.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/8734p4ymqj.ffs@tglx
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Valentin Schneider <vschneid@redhat.com>
---
 kernel/sched/core.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4424,7 +4424,8 @@ int wake_up_state(struct task_struct *p,
  * Perform scheduler related setup for a newly forked process p.
  * p is forked by current.
  *
- * __sched_fork() is basic setup used by init_idle() too:
+ * __sched_fork() is basic setup which is also used by sched_init() to
+ * initialize the boot CPU's idle task.
  */
 static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 {
@@ -7680,8 +7681,6 @@ void __init init_idle(struct task_struct
 	struct rq *rq = cpu_rq(cpu);
 	unsigned long flags;
 
-	__sched_fork(0, idle);
-
 	raw_spin_lock_irqsave(&idle->pi_lock, flags);
 	raw_spin_rq_lock(rq);
 
@@ -7696,10 +7695,8 @@ void __init init_idle(struct task_struct
 
 #ifdef CONFIG_SMP
 	/*
-	 * It's possible that init_idle() gets called multiple times on a task,
-	 * in that case do_set_cpus_allowed() will not do the right thing.
-	 *
-	 * And since this is boot we can forgo the serialization.
+	 * No validation and serialization required at boot time and for
+	 * setting up the idle tasks of not yet online CPUs.
 	 */
 	set_cpus_allowed_common(idle, &ac);
 #endif
@@ -8543,6 +8540,7 @@ void __init sched_init(void)
 	 * but because we are the idle thread, we just pick up running again
 	 * when this runqueue becomes "idle".
 	 */
+	__sched_fork(0, current);
 	init_idle(current, smp_processor_id());
 
 	calc_load_update = jiffies + LOAD_FREQ;


