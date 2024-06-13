Return-Path: <linux-kernel+bounces-213873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B979907BDE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 20:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 817AC1C24C68
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 18:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5134114BFBF;
	Thu, 13 Jun 2024 18:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tZKlE7mw"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85CA14B064
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 18:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718305187; cv=none; b=tIpjI9Ww4Fjss+xVtI+aVbXWrHJcODeSuk0lqvcRKftAvpI6O7wCgzpfgOemXCECcAnZe5CoRYIw7EqJfv/Y18qj3RVATMLZwJWTRXj9eU1SsaxRu/s2XJluwfEfq6EHVVz4rw9Tv4Vx/YmBke3uFLqLDA6+XbFghAhR7R8yfxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718305187; c=relaxed/simple;
	bh=CmmdZHKeNCqmCWnHJNo64EubgdPx2B4OykikUiH/x7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tr5VBvrmnZS1SYDpJ4lPzARQNuZT066oH3Pt4qAh1AX4R+TGVyRZhA6HKjelKwe09KDec3hmI+SI2nRkrcMSXum+b0X2JVrP04FKjR8CnOJ174rtFNj7O5tE5yaPsT7VTrzk5kVD3TZ0PCYOb/Cr+aN12MWy6ncY7BonTaaM0Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tZKlE7mw; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-422f7c7af49so18785e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 11:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718305184; x=1718909984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zs3WCcd/hAZCp+GQkLGcRHb4OREamzN+Yl1eoZLFn4=;
        b=tZKlE7mwJc6z2BOdqdAOF5A32pLf1VDcMslSdRQpxmE/IPgT2908pl1J9cCfs5BLb+
         Oz17zFuPK0evKFavvrkiAiUuQpOlo1uBjaFirRrmO8Ux2l5bImjmjYSCzGvUIwCInPCs
         SDyLSrthrwBmo4WxJi0sBRgNgYPhGQWFE8nZJU7sXyTCs3TLoAiPavRZOqGjvxVHvsPV
         k5D+gXYLNLN4tfbC0qChfuGeZ7aY5Fgkib+9/cCOV+Rm3VCxI4D31lDntMb7TEofnBnq
         Jzaj3sVdzrq8uCG66A7ZVQuB0TbfVIu23NEnVPEQlyedyUBYCS2BPnCrhQik2cOYNIap
         H0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718305184; x=1718909984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9zs3WCcd/hAZCp+GQkLGcRHb4OREamzN+Yl1eoZLFn4=;
        b=VDpxCSCNfVoDIJ1p6kpvPT8eSU+Sadz4fYtjcdSYagM1oqKZxZ62BJQaCsYznmOnPX
         LupQUrnTYNtFulh27jD3scfcpRWDEUDlSULAmliPg2qT30SCHVm1Wx8Qr0FWKaKPbTTf
         //Rt7GAbWy146gi2evRd19Q6emKsRbPw31t7dtcLdNSvwh6c/pde0PKIsjDi8mlRZylp
         Uu0/5n9ahEoNhddLJlf9JN79JdTUwfAXUioYTxmuogHfVlhWDfzi9dL52biEtgBxq8C4
         EXpIpWvGJJ/bF1fsVee3mlyjrndbVMdHnETVPGutOutZ9Vto2DVlPoyRTatPnNhEK4Mv
         a6iw==
X-Gm-Message-State: AOJu0Yx/V1NL28s8dWGtpVtLBou30QlSfSttFtyufaExM2OI7KDT31vv
	N9DXaNKP3ZpzXOdbfoab6tIGnFQmtk42eOwsLN4l50aBuWrITznLgvqTxOpP+hbKUrQ9Na3MMSu
	4Cm5f9CAVGPWPkqYaAzWr8pVaVuitX3WTmyo=
X-Google-Smtp-Source: AGHT+IGuu6c9DNUmLKI2yz2u6/2pmLH4T44d9pyw4+V8y2WMVF63vdzdV2cr2sOHZ9bWdHl3uO9dvbSv6NYjNu3VNu8=
X-Received: by 2002:a05:600c:1e13:b0:421:8486:7d2d with SMTP id
 5b1f17b1804b1-42305394bfcmr129995e9.1.1718305183883; Thu, 13 Jun 2024
 11:59:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613015837.4132703-1-jstultz@google.com> <20240613100441.GC17707@noisy.programming.kicks-ass.net>
In-Reply-To: <20240613100441.GC17707@noisy.programming.kicks-ass.net>
From: John Stultz <jstultz@google.com>
Date: Thu, 13 Jun 2024 11:59:31 -0700
Message-ID: <CANDhNCo0he-9X2M3nvWoVD3wBgstJqb0n0hfxKT7w3=2sNxEdg@mail.gmail.com>
Subject: Re: [PATCH] RFC: sched: Rework task_sched_runtime to avoid calling update_rq_clock
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	Qais Yousef <qyousef@layalina.io>, Joel Fernandes <joel@joelfernandes.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 3:04=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
> On Wed, Jun 12, 2024 at 06:58:26PM -0700, John Stultz wrote:
> > I recently got a bug report that
> > clock_gettime(CLOCK_THREAD_CPUTIME_ID,...) had regressed between
> > 5.10 and 6.1. Its not a huge regression in absolute time
> > (~30-40ns), but is >10% change.
> >
> > I narrowed the cause down to the addition of
> > psi_account_irqtime() in update_rq_clock_task(), in commit
> > 52b1364ba0b1 ("sched/psi: Add PSI_IRQ to track IRQ/SOFTIRQ
> > pressure")
> >
> > So that explains the behavior change,
>
> It doesn't really... that patch just feeds the irq_time we *already*
> subtracted prior to it, to PSI, such that PSI can also enjoy the 'view'.
>
> The only explanation I have is that interrupts that end up in the
> scheduler (wakeups, tick, etc..) now get to do that PSI cgroup iteration
> and that cost adds up to the IRQ time itself, and as such the task time
> slows down accordingly.
>
> Are you using silly deep cgroup hierarchies?

Not deeply nested. We have a handful of cgroups, but due to
priority-inversion issues we're not putting any tasks in them right
now.

Again, this is only ~30necs delta, so it's not a huge amount of time
we're talking about. The cpu_clock() call in psi_account_irqtime is
probably a reasonable chunk of that (as just the vdso clock_gettime()
takes a similar order of time).

> > but it also seems odd that
> > we're doing psi irq accounting from a syscall that is just
> > trying to read the thread's cputime.
>
> In order to avoid doing all the accounting in the IRQ entry/exit paths,
> those paths only do the bare minimum of tracking how much IRQ time there
> is.
>
> update_rq_clock_task() then looks at the increase of IRQ time and
> subtracts this from the task time -- after all, all time spend in the
> IRQ wasn't spend on the task itself.
>
> It did that prior to the PSI patch, and it does so after. The only
> change is it now feeds this delta into the PSI thing.

Yeah. I don't see the PSI logic as particularly bad, it's just that I
was surprised we were getting into the accounting paths during a read.

Coming from the timekeeping subsystem, we usually do the time
accumulation/accounting (write side) periodically, and on the read
fast-path we avoid anything extra. So it was just a bit unintuitive to
me to find we were doing the accounting/accumulation to the task clock
on each read.

> > NOTE: I'm not 100% sure this is correct yet. There may be some
> > edge cases I've overlooked, so I'd greatly appreciate any
> > review or feedback.
>
> Urgh, you're sprinkling the details of what is clock_task over multiple
> places.

Yeah. Agreed, the base-irq-steal logic I added should have been
wrapped up better.


> Does something like so work?

Yeah, it takes the psi_account_irqtime out of the hotpath, so with it
we're back to ~5.10 numbers.

Qais' correctness concerns seem reasonable, and I fret the second
psi_irq_time accounting base creates multiple irq_time timelines to
manage (and eventually fumble up). So I still think the idea of
separate read/write paths might be an overall improvement. But
obviously your patch seemingly works properly and mine doesn't, so I
can't object too strongly here. :)  Though I may still take another
pass on my patch to see if we can make the clock_gettime read path
avoid the accounting logic, but it can be a throwaway if you really
don't like it.

> ---
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0935f9d4bb7b..d4b87539d72a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -724,7 +724,6 @@ static void update_rq_clock_task(struct rq *rq, s64 d=
elta)
>
>         rq->prev_irq_time +=3D irq_delta;
>         delta -=3D irq_delta;
> -       psi_account_irqtime(rq->curr, irq_delta);
>         delayacct_irq(rq->curr, irq_delta);
>  #endif
>  #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
> @@ -5459,6 +5458,8 @@ void sched_tick(void)
>
>         sched_clock_tick();
>
> +       psi_account_irqtime(curr, &rq->psi_irq_time);
> +
>         rq_lock(rq, &rf);

Should the psi_account_irqtime (and its use of the rq->psi_irq_time)
go under the rq_lock here?  This is the only user, so there isn't any
practical parallel access, but the locking rules are subtle enough
already.

thanks
-john

