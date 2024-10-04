Return-Path: <linux-kernel+bounces-350294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1009902FF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 14:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EEB8B21CA8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 12:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246321D270A;
	Fri,  4 Oct 2024 12:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oH9Qd+ec"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7356D1D2705;
	Fri,  4 Oct 2024 12:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728045321; cv=none; b=JRnjz/JTrE3UqZ3FUf2KPyZkDQxQC5AaAmnQJRAuy//aPAnf7FOUj2ciJBMuMtIOXNuFRgGSbu95EWjjeo+jm+55Vmd1kRm19KiQalytP1wgKeLh45PB7TEGBGx+XOLu42HmvHrqoVopB7aTcdfMiQDhx6MzzKChMbmn6uV0RRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728045321; c=relaxed/simple;
	bh=83qhVAAiNn5E7slJ/gpJ29Nn8CyJePG9NrZ+lFOGaNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bHHRpwxh74S481/gfeRTvcIHJk5DqHnxFtm1EUTShg3ATWKyT9oarz+CLUnuUNMRzZRhEG8AzGFPITq8qwu+bxhy53AnCb28+JPncoBzj4Kb+3tyIZPuwTl/nIwLtGI1P1TOTpoy9lrbYm4J2RzvBBRWooUcILeloOfRVq1Dj34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oH9Qd+ec; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=NKo4edYmhguvqof8T9sOpMaPxlwKVxZ0R86uU/jJjAY=; b=oH9Qd+ecEbYiKIuAt83eYT1bnJ
	McRJDpFRuthBImC5SmQhCicyffpIfO1G85yXHoVmHWfKaoX+wm3TAKyKplIN/Yij//DaWYAJFZJsh
	k2kdZ84sOU4uE7pLGoU9/IeCD1Y2DrWXHqbqpxi2HnM/3UsqKMth6xPtRgvCV84jSDfrLGQ06dCbr
	Y52HiZDFrJ0S4K0gWFK8ZRR+tg9JYT9ozoXc7iFgiwTF2dWlWfmB6eoW/X3D2X3MmynJnC2k6+SDi
	MGFESNujKiFZ5ylKPqqPLP9Ms8r0Pixe3cg4lnNh9HVs8OmwN7EUwMC2WfG9s0l6oCgwH7UQxS1bL
	x/Lju6ug==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1swhWT-0000000AOrA-4ANO;
	Fri, 04 Oct 2024 12:35:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 361AD30083E; Fri,  4 Oct 2024 14:35:06 +0200 (CEST)
Date: Fri, 4 Oct 2024 14:35:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Klaus Kudielka <klaus.kudielka@gmail.com>,
	Chris Bainbridge <chris.bainbridge@gmail.com>,
	linux-kernel@vger.kernel.org, bsegall@google.com,
	dietmar.eggemann@arm.com, efault@gmx.de, juri.lelli@redhat.com,
	mgorman@suse.de, mingo@redhat.com, rostedt@goodmis.org,
	tglx@linutronix.de, vincent.guittot@linaro.org, vschneid@redhat.com,
	wuyun.abel@bytedance.com, youssefesmat@chromium.org,
	spasswolf@web.de, regressions@lists.linux.dev,
	Johannes Weiner <hannes@cmpxchg.org>,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>
Subject: Re: [REGRESSION] Re: [PATCH 17/24] sched/fair: Implement delayed
 dequeue
Message-ID: <20241004123506.GR18071@noisy.programming.kicks-ass.net>
References: <20240830123458.3557-1-spasswolf@web.de>
 <ZvA7n9GNoD-ipjkj@debian.local>
 <1ee5f5828e2021bf1051dc1f9b6f01a8c061ffb1.camel@gmail.com>
 <2128d714-90f7-1598-b32b-559206fce5de@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2128d714-90f7-1598-b32b-559206fce5de@amd.com>

On Fri, Oct 04, 2024 at 04:40:08PM +0530, K Prateek Nayak wrote:
> Hello folks,
> 
> On 10/3/2024 11:01 AM, Klaus Kudielka wrote:
> > On Sun, 2024-09-22 at 16:45 +0100, Chris Bainbridge wrote:
> > > On Fri, Aug 30, 2024 at 02:34:56PM +0200, Bert Karwatzki wrote:
> > > > Since linux next-20240820 the following messages appears when booting:
> > > > 
> > > > [    T1] smp: Bringing up secondary CPUs ...
> > > > [    T1] smpboot: x86: Booting SMP configuration:
> > > > [    T1] .... node  #0, CPUs:        #2  #4  #6  #8 #10 #12 #14  #1
> > > > This is the line I'm concerend about:
> > > > [    T1] psi: inconsistent task state! task=61:cpuhp/3 cpu=0 psi_flags=4 clear=0 set=4
> > > > [    T1]   #3  #5  #7  #9 #11 #13 #15
> > > > [    T1] Spectre V2 : Update user space SMT mitigation: STIBP always-on
> > > > [    T1] smp: Brought up 1 node, 16 CPUs
> > > > [    T1] smpboot: Total of 16 processors activated (102216.16 BogoMIPS)
> > > > 
> > > > I bisected this to commit 152e11f6df29 ("sched/fair: Implement delayed dequeue").
> > > > Is this normal or is this something I should worry about?
> > > > 
> > > > Bert Karwatzki
> > > 
> > > I am also getting a similar error on boot, and bisected it to the same commit:
> > > 
> > > [    0.342931] psi: inconsistent task state! task=15:rcu_tasks_trace cpu=0 psi_flags=4 clear=0 set=4
> > > 
> > > #regzbot introduced: 152e11f6df293e816a6a37c69757033cdc72667d
> > 
> > Just another data point, while booting 6.12-rc1 on a Turris Omnia:
> > 
> > [    0.000000] Linux version 6.12.0-rc1 (XXX) (arm-linux-gnueabihf-gcc (Debian 14.2.0-1) 14.2.0, GNU ld (GNU Binutils for Debian) 2.43.1) #1 SMP Thu Oct  3 06:59:25 CEST 2024
> > [    0.000000] CPU: ARMv7 Processor [414fc091] revision 1 (ARMv7), cr=10c5387d
> > [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> > [    0.000000] OF: fdt: Machine model: Turris Omnia
> > ...
> > [    0.000867] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
> > [    0.000876] psi: inconsistent task state! task=2:kthreadd cpu=0 psi_flags=4 clear=0 set=4
> > 
> 
> Not sure if someone took a stab at this but I haven't seen the "psi:

I'm aware of the issue, but since it's just statistics and not
anything 'important', I've been spending my time on those crashing bugs.

> inconsistent task state" warning with the below diff. I'm not sure if my
> approach is right which if why I'm pasting the diff before sending out
> an official series. Any comments or testing is greatly appreciated.
> 
> The diff is based on:
> 
>     git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/urgent
> 
> at commit d4ac164bde7a ("sched/eevdf: Fix wakeup-preempt by checking
> cfs_rq->nr_running")

Thanks, I just pushed all that out to tip/sched/urgent.

> My approach was as follows:
> 
> o psi_dequeue() relied on psi_sched_switch() to set the PSI flags
>   appropriately for a dequeued task. However, psi_sched_switch() used
>   "!task_on_rq_queued(prev)" to judge if the prev task is blocked which
>   is now untrue with DELAYED_DEQUEUE. Fix it by checking
>   "p->se.sched_delayed" as well. I also added a matching check for
>   ENQUEUE_DELAYED for psi_enqueue().

We already determine the whole sleep state earlier, the whole having
called block_task() is a clue, perhaps we should propagate that state
instead of trying to divinate it again.

> o With the above, the warning was put off for a few more seconds but it
>   still appeared. I dumped all PSI flag transition along with
>   "tsk->se.sched_delayed" to see what trips it and I saw the following
>   state changes for the task that finally tripped it:
> 
>     psi: task state: task=18:rcu_preempt cpu=0 psi_flags=0 clear=0 set=0 delayed=1
>     psi: task state: task=18:rcu_preempt cpu=128 psi_flags=0 clear=0 set=4 delayed=1
>     psi: task state: task=18:rcu_preempt cpu=128 psi_flags=4 clear=0 set=4 delayed=0
>     psi: inconsistent task state! task=18:rcu_preempt cpu=128 psi_flags=4 clear=0 set=4 delayed=0
> 
>   Note that cpu switched with "tsk->se.sched_delayed" still set which
>   got me looking at the task migration path. The warning added below
>   in "deactivate_task()" tripped without fail, just before the PSI
>   warning was logged.
> 
>   To prevent migration of a delayed entity (XXX: Is it a good idea?)

It is not. By migrating the entities they can get picked sooner and the
delayed thing gets removed sooner. Less 'hidden' weight.

>   we do a "account_task_dequeue()" in the delayed dequeue case to
>   remove the task from the "rq->cfs_list", thus removing it from the
>   purview of the load balancer.

Anyway, assuming PSI wants to preserve current semantics, does something
like the below work?

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 43e453ab7e20..0d766fb9fbc4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2012,7 +2012,7 @@ void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 	if (!(flags & ENQUEUE_NOCLOCK))
 		update_rq_clock(rq);
 
-	if (!(flags & ENQUEUE_RESTORE)) {
+	if (!(flags & ENQUEUE_RESTORE) && !p->se.sched_delayed) {
 		sched_info_enqueue(rq, p);
 		psi_enqueue(p, (flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED));
 	}
@@ -2039,7 +2039,7 @@ inline bool dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 	if (!(flags & DEQUEUE_NOCLOCK))
 		update_rq_clock(rq);
 
-	if (!(flags & DEQUEUE_SAVE)) {
+	if (!(flags & DEQUEUE_SAVE) && !p->se.sched_delayed) {
 		sched_info_dequeue(rq, p);
 		psi_dequeue(p, flags & DEQUEUE_SLEEP);
 	}
@@ -6537,6 +6537,7 @@ static void __sched notrace __schedule(int sched_mode)
 	 * as a preemption by schedule_debug() and RCU.
 	 */
 	bool preempt = sched_mode > SM_NONE;
+	bool block = false;
 	unsigned long *switch_count;
 	unsigned long prev_state;
 	struct rq_flags rf;
@@ -6622,6 +6623,7 @@ static void __sched notrace __schedule(int sched_mode)
 			 * After this, schedule() must not care about p->state any more.
 			 */
 			block_task(rq, prev, flags);
+			block = true;
 		}
 		switch_count = &prev->nvcsw;
 	}
@@ -6667,7 +6669,7 @@ static void __sched notrace __schedule(int sched_mode)
 
 		migrate_disable_switch(rq, prev);
 		psi_account_irqtime(rq, prev, next);
-		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
+		psi_sched_switch(prev, next, block);
 
 		trace_sched_switch(preempt, prev, next, prev_state);
 

