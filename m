Return-Path: <linux-kernel+bounces-354687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E2E994109
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4A76284F3D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F1A1D356C;
	Tue,  8 Oct 2024 07:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uQr8WZz8"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC0A14EC59
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 07:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728373092; cv=none; b=qo5MCr6w0Rs7DPHYm6KHuCWH6DW3YDEzeM70rzdHaSXfBDF/6zKYjWxUMbmJf7aWfZlO/R0oC1eBQHNPApOqqHR/sNZ+OVAjFbdK2kE8e13qDkNaiiqxjXABSxJFhwC3c7mILN6Qs5sGG0tsy7XXMjMKDtG8KVXlu6iVUmI406c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728373092; c=relaxed/simple;
	bh=l9I+jQAN+IMdoMVv2U5F22h/T95r4cmgcM93DJA4fi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPES5stPCtwEip4SJh1yeYoNos3BrZAs7b38f6BsnZGLpBod9tlqo1FNaAXaOLGvA1yEXEiyLJntyoI4rLpF8MuMhgv/Fb3pZS0SaTAvZh7F0L8gMuQzjgfIW1IF/YAf26CCxDUTvOTHGoOu/99qjrQLUj9DEMED03xvhxBZkfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uQr8WZz8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vfuI+ZRGT8Db6FVYDPKb7D1u5tyQ0nbSnc2C3/LlhVI=; b=uQr8WZz8C8XYPOGT7IFFEa+Eyu
	01umRNQa3rBedAQMiRWjBPwsR4BlT5vuSsseshdoH7XLqJZQM+L2B8+x/VVJQNUTM9wFBVm+T7Ilh
	24Af52iGPurk8JIwF2AdrGbgFup4e7FPafBTej19Os1yTnmxWVeM/z+bGFX17sTiSnjfbknNBd2Yd
	2STk8Wm6o1tKRH1pBk5/Y5bKl35Vm9+wPS/875jEV9+HhGo1x3VoRfSBHFzep3kTotFEjzxicBg83
	Sdhpqg1AqC+CT8VOigRB+ikAgAMwY5fYCg/Ffcad+UApiOGWJCUUemyiWu/6SLPJpTgHrjb51hlqg
	VDGCW1ww==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sy4nB-00000001mOB-1RoX;
	Tue, 08 Oct 2024 07:38:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C49B5300C1F; Tue,  8 Oct 2024 09:38:00 +0200 (CEST)
Date: Tue, 8 Oct 2024 09:38:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Waiman Long <llong@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Luis Goncalves <lgoncalv@redhat.com>, Chunyu Hu <chuhu@redhat.com>
Subject: Re: [PATCH] locking/rtmutex: Always use trylock in rt_mutex_trylock()
Message-ID: <20241008073800.GD14587@noisy.programming.kicks-ass.net>
References: <20240926151315.507905-1-longman@redhat.com>
 <20241002093745.GO5594@noisy.programming.kicks-ass.net>
 <7918987a-4b66-4191-aa52-798f9434352a@redhat.com>
 <20241007145037.GE4879@noisy.programming.kicks-ass.net>
 <95365aa5-d039-4d09-8191-516ba01c9e5d@redhat.com>
 <20241007153341.GA14587@noisy.programming.kicks-ass.net>
 <13f78472-2fa8-4af9-9d5f-a93cb16cc7ca@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13f78472-2fa8-4af9-9d5f-a93cb16cc7ca@redhat.com>

On Mon, Oct 07, 2024 at 11:54:54AM -0400, Waiman Long wrote:
> 
> On 10/7/24 11:33 AM, Peter Zijlstra wrote:
> > On Mon, Oct 07, 2024 at 11:23:32AM -0400, Waiman Long wrote:
> > 
> > > > Is the problem that:
> > > > 
> > > > 	sched_tick()
> >            raw_spin_lock(&rq->__lock);
> > > > 	  task_tick_mm_cid()
> > > > 	    task_work_add()
> > > > 	      kasan_save_stack()
> > > > 	        idiotic crap while holding rq->__lock ?
> > > > 
> > > > Because afaict that is completely insane. And has nothing to do with
> > > > rtmutex.
> > > > 
> > > > We are not going to change rtmutex because instrumentation shit is shit.
> > > Yes, it is because of KASAN that causes page allocation while holding the
> > > rq->__lock. Maybe we can blame KASAN for this. It is actually not a problem
> > > for non-PREEMPT_RT kernel because only trylock is being used. However, we
> > > don't use trylock all the way when rt_spin_trylock() is being used with
> > > PREEMPT_RT Kernel.
> > It has nothing to do with trylock, an everything to do with scheduler
> > locks being special.
> > 
> > But even so, trying to squirrel a spinlock inside a raw_spinlock is
> > dodgy at the best of times, yes it mostly works, but should be avoided
> > whenever possible.
> > 
> > And instrumentation just doesn't count.
> > 
> > > This is certainly a problem that we need to fix as there
> > > may be other similar case not involving rq->__lock lurking somewhere.
> > There cannot be, lock order is:
> > 
> >    rtmutex->wait_lock
> >      task->pi_lock
> >        rq->__lock
> > 
> > Trying to subvert that order gets you a splat, any other:
> > 
> >    raw_spin_lock(&foo);
> >    spin_trylock(&bar);
> > 
> > will 'work', despite probably not being a very good idea.
> > 
> > Any case involving the scheduler locks needs to be eradicated, not
> > worked around.
> 
> OK, I will see what I can do to work around this issue.

Something like the completely untested below might just work.


---
diff --git a/include/linux/task_work.h b/include/linux/task_work.h
index cf5e7e891a77..6d22414c5a83 100644
--- a/include/linux/task_work.h
+++ b/include/linux/task_work.h
@@ -14,11 +14,14 @@ init_task_work(struct callback_head *twork, task_work_func_t func)
 }
 
 enum task_work_notify_mode {
-	TWA_NONE,
+	TWA_NONE = 0,
 	TWA_RESUME,
 	TWA_SIGNAL,
 	TWA_SIGNAL_NO_IPI,
 	TWA_NMI_CURRENT,
+
+	TWA_FLAGS = 0xff00,
+	TWAF_NO_KASAN = 0x0100,
 };
 
 static inline bool task_work_pending(struct task_struct *task)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 43e453ab7e20..e9b053b403c0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10458,7 +10458,7 @@ void task_tick_mm_cid(struct rq *rq, struct task_struct *curr)
 		return;
 	if (time_before(now, READ_ONCE(curr->mm->mm_cid_next_scan)))
 		return;
-	task_work_add(curr, work, TWA_RESUME);
+	task_work_add(curr, work, TWA_RESUME | TWAF_NO_KASAN);
 }
 
 void sched_mm_cid_exit_signals(struct task_struct *t)
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ab497fafa7be..a58d55bba7a3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3604,7 +3604,7 @@ static void task_tick_numa(struct rq *rq, struct task_struct *curr)
 		curr->node_stamp += period;
 
 		if (!time_before(jiffies, curr->mm->numa_next_scan))
-			task_work_add(curr, work, TWA_RESUME);
+			task_work_add(curr, work, TWA_RESUME | TWAF_NO_KASAN);
 	}
 }
 
diff --git a/kernel/task_work.c b/kernel/task_work.c
index 5d14d639ac71..ff07a77bd7be 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -55,13 +55,18 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
 		  enum task_work_notify_mode notify)
 {
 	struct callback_head *head;
+	int flags = notify & TWA_FLAGS;
+	notify &= ~TWA_FLAGS;
 
 	if (notify == TWA_NMI_CURRENT) {
 		if (WARN_ON_ONCE(task != current))
 			return -EINVAL;
 		if (!IS_ENABLED(CONFIG_IRQ_WORK))
 			return -EINVAL;
-	} else {
+		flags |= TWAF_NO_KASAN;
+	}
+
+	if (!(flags & TWAF_NO_KASAN)) {
 		/* record the work call stack in order to print it in KASAN reports */
 		kasan_record_aux_stack(work);
 	}

