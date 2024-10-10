Return-Path: <linux-kernel+bounces-359340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3A8998A60
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BF3F1C241E0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319C61CDA25;
	Thu, 10 Oct 2024 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4MsvrSj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BD442A8C
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 14:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728571030; cv=none; b=A0vwSdndWo5D7PXkK3itwW8WT5nvgiP/UAzD7POGKe3Mlb/SCHlgaLDQVHeX/ekQdal958IKih9xuLxJuIoV8U/TAfptKYhXPfLlkMBxLl+I67k8YwVFa29GlAV9rJIde2Nmt5orLYVtof3rNErW7JAQ7LM9mfxE9mSJlJz/q/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728571030; c=relaxed/simple;
	bh=/FTPS707Xs8rayd+RhZh4XvyDOzsv5g5GwhOGDY6u9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMUBjVoeHu5SrMHNVlyN0kNgWK3N8A4vWWEJPpJp7Lp5tWUH4hK7vtoelVuzlDr9IZhqmbf/s2X6yQr6RDdDOAop8izRjWwOeYgk0b+f1SDIRDTtAy/XklQq4cw+ahSDSJSPdtUhR5IMRN9sQLLFDbaqMTH6vLePpOXWy2JJqQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4MsvrSj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3226BC4CEC5;
	Thu, 10 Oct 2024 14:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728571030;
	bh=/FTPS707Xs8rayd+RhZh4XvyDOzsv5g5GwhOGDY6u9Q=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=m4MsvrSjNs8aFH0Ukt0vMOvCdJxEE86GIw3pogfA0I63m53151MBlNuJhsxNZnZfT
	 XW79Datj3meCqNeJAfKjio4BWnnmNc4n8b5/tJgaLK0l5FERfLJl0knljlimBNrLV+
	 BtXzbQHOnVS0qC8HAcOw+6YH+7VYoIhL+fUC4zJTfga1w2DgUA/OtMd8PZCc3iuzCP
	 e/WClW2I1cXk8Qn46Z7+B/eykQtIuUNQKGoqo80l2YEV4R4MyOz4JOVlMkbDfeMrvs
	 YOge6WFmHy0MQojnaTRDUZH2BY9qfLdz51oQY9HFo1U0HRG/QXUjQGHsp6wRDLDofo
	 0PGXQOyDi2eJA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BF359CE08E5; Thu, 10 Oct 2024 07:37:09 -0700 (PDT)
Date: Thu, 10 Oct 2024 07:37:09 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
	mingo@kernel.org, bigeasy@linutronix.de, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, frederic@kernel.org, efault@gmx.de
Subject: Re: [PATCH 4/7] rcu: handle quiescent states for PREEMPT_RCU=n,
 PREEMPT_COUNT=y
Message-ID: <bbd35e87-c7ac-4e69-9f82-7c7338307079@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
 <20241009165411.3426937-5-ankur.a.arora@oracle.com>
 <87o73t9jw4.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o73t9jw4.fsf@oracle.com>

On Wed, Oct 09, 2024 at 12:05:47PM -0700, Ankur Arora wrote:
> 
> 
> Ankur Arora <ankur.a.arora@oracle.com> writes:
> 
> > With PREEMPT_RCU=n, cond_resched() provides urgently needed quiescent
> > states for read-side critical sections via rcu_all_qs().
> > One reason why this was needed, was lacking preempt-count, the tick
> > handler has no way of knowing whether it is executing in a read-side
> > critical section or not.
> >
> > With PREEMPT_LAZY=y, there can be configurations with PREEMPT_COUNT=y,
> > PREEMPT_RCU=n, where cond_resched() is a stub that does not provide
> > quiescent states via rcu_all_qs().
> >
> > So, use the availability of preempt_count() to report quiescent states
> > in rcu_flavor_sched_clock_irq().
> 
> A note about the inverse of this case, where we might have long running
> loops which only temporarily enable preemption and thus would be
> unlikely to align themselves with the tick: in prior discussions [1]
> Paul had pointed the need for providing for forcing a context switch
> in such a scenario.
> 
> I had a patch which did that, but I think it is unnecessary since this
> clause in rcu_sched_clock_irq() should already handle it.
> 
>    void rcu_sched_clock_irq(int user) {
>         ...
>         /* The load-acquire pairs with the store-release setting to true. */
>         if (smp_load_acquire(this_cpu_ptr(&rcu_data.rcu_urgent_qs))) {
>                 /* Idle and userspace execution already are quiescent states. */
>                 if (!rcu_is_cpu_rrupt_from_idle() && !user) {
>                         set_tsk_need_resched(current);
>                         set_preempt_need_resched();
>                 }
>                 __this_cpu_write(rcu_data.rcu_urgent_qs, false);
>         }
> 
> Paul?

As long as the tick is actually enabled.

But looking deeper, there is code in force_qs_rnp() and
rcu_watching_snap_recheck() to force the tick on CPUs that don't
response to the grace period soon enough via the -1 return from the
rcu_watching_snap_recheck() function and via resched_cpu().

So we might be covered.  Some serious testing is warranted.

							Thanx, Paul

