Return-Path: <linux-kernel+bounces-249267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7EF92E8FE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E312928860B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CA115ECCA;
	Thu, 11 Jul 2024 13:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q1sDKwhx"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F8914C587
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720703668; cv=none; b=dxGVCDbMFqAWS1uGeA7ZzOrIMXUv7JWzk2S3sDsYYNqKKeUGk8cbWeBVnrsHS3u8HWwtX6CE93lx5z9RsSC5PhRlb2hMh0ZIPuyWODIfMzg3nVHaXHUiAOuhtCf+c8cYaGHVpZCRzy5rBQnVzKT80oYRjDBwPk8hl67cuoZyDNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720703668; c=relaxed/simple;
	bh=rX2o5TNF2sxFdJGUuLW3hs3BgO6xhdaxeIGoh+lsZRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pmynwaD1pF5QsoXE2bwVfNLlCF908ijO3/Sh2obFe8V+AGPMn0zmhSNYGOLe9pGJYqEyOfgDDNntFXH2F+KuXeyXG0neskhgSBVqcFSAx8esdVgpCmmva7C14CK7Y0LhE63nv9/4VvqbmA+W4xiZiHwVkb39ue8CKlf0pzfS9iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q1sDKwhx; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2c983d8bdc7so737820a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 06:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720703666; x=1721308466; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2D4aHwswwM4NqPAOXG3fEumKo2hscS5ep5Tu5PbXU/c=;
        b=q1sDKwhxCmdcVo7Tz/WarJs2WMKOmZVutloBQJ+cT6DuktoHVKTDolE2sWcVWSBDXQ
         em7xs55UO5c4bQtEtUCmSVH/jTwAVqjmPHvFNHmTSc+jCglEg8uoAOyX5XXgMnw3sJKA
         NHUsSvwT/jJ0lne+cxGyQ8Sdp8aNQleKW/2bOVbCdiIS1Zu8j0yqcbM6eGos5PF1Yv5U
         DTqGjwweStycyuHkNjj7nVtoLU4dBog2LvGkrwCIX/EK0C1HLrvO/0s30XNZFRK9MUIw
         FGNtigNxebuiFizwgpy07HjxgmTigVj1TZ1WGxJvletQBiu+mvVpk6QrtudNNkEgq1oX
         siYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720703666; x=1721308466;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2D4aHwswwM4NqPAOXG3fEumKo2hscS5ep5Tu5PbXU/c=;
        b=ep2NetmWyKWwO/y+ftWd5Ojnw/UJHTCHz7cNp/ksyYsFbHvoBFblbMnXXvUL7j2rHC
         eYtwY4vOj5YMXSjJuVn7togDVP6AqjFJp7R61oQizXO3E1RegF4VSU2qeMok70BrLUiL
         CQVWMiAlKyJB9RN4u+rv8FUS9kDchHtYa7/+AmD56nKY7z1yaVitqHbp3Piys9JrtT2W
         s6iX+OHA3yLEKPMgheL0KlroNCWpIzTD4i3NVi7WSQub/vUDhOQVTrAs6ENNjDK0Jk/q
         6Zj+kdngtjFJG8MZ9lodDGTiNMuAQn3Uh5jcLR/ffM7I8HWNdM41QUvDhc3Vz7WvfTn/
         itSg==
X-Forwarded-Encrypted: i=1; AJvYcCX06mkasoIUqOEZiphm1jgnMpbDcggIz1od7OkQCSICMyThS/+jP8OC1pinI2XiAAbkC2JgPuTs4KkUcbzbUvN9GnI6oM0CF9tAcMn6
X-Gm-Message-State: AOJu0YyUHybrhHrRPoX/cZ0U19bpQcp88Vc2SnlXGj0AIw8m9L83kXkB
	21VaNO+QsjymDSfYRKbaioq5RdTlMgJNue0YiPBUHuL65mPYH8fXrBAf5Es6b039CjruHp9sLxp
	YibPQpLBhzydOHKFqsGeBFBdPFSvO3a4fUnsybQ==
X-Google-Smtp-Source: AGHT+IErQLzLlTEDyE3WJuQw4hks/9BAeR6qnkZb/+NCoxRAyea5EDRu7Q8Z1cTAIYj4PS4tLHbvPQsOY9wJYD6oOtQ=
X-Received: by 2002:a17:90b:1c0e:b0:2c9:9f50:466a with SMTP id
 98e67ed59e1d1-2ca35d5c570mr6528843a91.48.1720703666451; Thu, 11 Jul 2024
 06:14:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710090210.41856-1-kprateek.nayak@amd.com>
 <20240710090210.41856-3-kprateek.nayak@amd.com> <CAKfTPtCNJUC-gNNPkEBRT5a2UVcPUHLdzUJ+-egZGQ5ihnU0Kw@mail.gmail.com>
 <20240711091936.GJ4587@noisy.programming.kicks-ass.net>
In-Reply-To: <20240711091936.GJ4587@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 11 Jul 2024 15:14:14 +0200
Message-ID: <CAKfTPtCDUhqZz2Q=k--=y8o4iiSeseLXMMruhZAuEd2Bb6iEoA@mail.gmail.com>
Subject: Re: [PATCH 2/3] sched/core: Introduce SM_IDLE and an idle re-entry
 fast-path in __schedule()
To: Peter Zijlstra <peterz@infradead.org>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Imran Khan <imran.f.khan@oracle.com>, 
	Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>, Rik van Riel <riel@surriel.com>, 
	Tejun Heo <tj@kernel.org>, Cruz Zhao <CruzZhao@linux.alibaba.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Zqiang <qiang.zhang1211@gmail.com>, Julia Lawall <julia.lawall@inria.fr>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jul 2024 at 11:19, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Jul 11, 2024 at 10:00:15AM +0200, Vincent Guittot wrote:
> > On Wed, 10 Jul 2024 at 11:03, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index 1e0c77eac65a..417d3ebbdf60 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -6343,19 +6343,12 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> > >   * Constants for the sched_mode argument of __schedule().
> > >   *
> > >   * The mode argument allows RT enabled kernels to differentiate a
> > > - * preemption from blocking on an 'sleeping' spin/rwlock. Note that
> > > - * SM_MASK_PREEMPT for !RT has all bits set, which allows the compiler to
> > > - * optimize the AND operation out and just check for zero.
> > > + * preemption from blocking on an 'sleeping' spin/rwlock.
> > >   */
> > > -#define SM_NONE                        0x0
> > > -#define SM_PREEMPT             0x1
> > > -#define SM_RTLOCK_WAIT         0x2
> > > -
> > > -#ifndef CONFIG_PREEMPT_RT
> > > -# define SM_MASK_PREEMPT       (~0U)
> > > -#else
> > > -# define SM_MASK_PREEMPT       SM_PREEMPT
> > > -#endif
> > > +#define SM_IDLE                        (-1)
> > > +#define SM_NONE                        0
> > > +#define SM_PREEMPT             1
> > > +#define SM_RTLOCK_WAIT         2
> > >
> > >  /*
> > >   * __schedule() is the main scheduler function.
> > > @@ -6396,11 +6389,12 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> > >   *
> > >   * WARNING: must be called with preemption disabled!
> > >   */
> > > -static void __sched notrace __schedule(unsigned int sched_mode)
> > > +static void __sched notrace __schedule(int sched_mode)
> > >  {
> > >         struct task_struct *prev, *next;
> > >         unsigned long *switch_count;
> > >         unsigned long prev_state;
> > > +       bool preempt = sched_mode > 0;
> > >         struct rq_flags rf;
> > >         struct rq *rq;
> > >         int cpu;
> > > @@ -6409,13 +6403,13 @@ static void __sched notrace __schedule(unsigned int sched_mode)
> > >         rq = cpu_rq(cpu);
> > >         prev = rq->curr;
> > >
> > > -       schedule_debug(prev, !!sched_mode);
> > > +       schedule_debug(prev, preempt);
> > >
> > >         if (sched_feat(HRTICK) || sched_feat(HRTICK_DL))
> > >                 hrtick_clear(rq);
> > >
> > >         local_irq_disable();
> > > -       rcu_note_context_switch(!!sched_mode);
> > > +       rcu_note_context_switch(preempt);
> > >
> > >         /*
> > >          * Make sure that signal_pending_state()->signal_pending() below
> > > @@ -6449,7 +6443,12 @@ static void __sched notrace __schedule(unsigned int sched_mode)
> > >          * that we form a control dependency vs deactivate_task() below.
> > >          */
> > >         prev_state = READ_ONCE(prev->__state);
> > > -       if (!(sched_mode & SM_MASK_PREEMPT) && prev_state) {
> > > +       if (sched_mode == SM_IDLE) {
> > > +               if (!rq->nr_running) {
> > > +                       next = prev;
> > > +                       goto picked;
> > > +               }
> > > +       } else if (!preempt && prev_state) {
> >
> > With CONFIG_PREEMPT_RT, it was only for SM_PREEMPT but not for SM_RTLOCK_WAIT
>
> Bah, yes. But then schedule_debug() and rcu_note_context_switch() have
> an argument that is called 'preempt' but is set for SM_RTLOCK_WAIT.
>
> Now, I think the RCU think is actually correct here, it doesn't want to
> consider SM_RTLOCK_WAIT as a voluntary schedule point, because spinlocks
> don't either. But it is confusing as heck.
>
> We can either write things like:
>
>         } else if (sched_mode != SM_PREEMPT && prev_state) {

this would work with something like below

#ifdef CONFIG_PREEMPT_RT
          # define SM_RTLOCK_WAIT       2
#else
         # define SM_RTLOCK_WAIT       SM_PREEMPT
#endif

>
> or do silly things like:
>
> #define SM_IDLE (-16)
>
> keep the SM_MASK_PREEMPT trickery and do:
>
>         } else if (!(sched_mode & SM_MASK_PREEMPT) && prev_state) {
>
> Not sure that is actually going to matter at this point though.

