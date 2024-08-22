Return-Path: <linux-kernel+bounces-296876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FC295B014
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F22D428398A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD2617085A;
	Thu, 22 Aug 2024 08:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bo9QmAZj"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E02616EBED
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 08:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724314913; cv=none; b=Y6VbAyMliWE6QB5lNvzT/boFP4YEB2LcMvvSSmsK4G+RUh6OFaQMFquF01G153ME+trsT5TiVvFoxT7x/UvD15TYb5YVlYoanWsghRdmTlVuBfmrxF+VNc+7w/qkyAoaOgDooGPx7FSlo4rOUvA4yV4MqbAcM0PlT3qrqReuvd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724314913; c=relaxed/simple;
	bh=B1gYHct0l260892Z0M3paFXAcsFoxk2muXS6Ac3o4AE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a2R0PyjNsN8hN/fosreQiSCsFlo6SJfEGQv0DsNdBUXgcLoeN9vnfHwrMZsTqK/oGGeAlbYOcxviIHKGihc1xpz0rmjA+JqR7UrvJ+k8kGZD9+DV3M8eStLM/haJfryqaiIaDHVDD365dG0HaE8vUuPu6KKDHIyq9A9d2Sh0Bw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bo9QmAZj; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d37e5b7b02so378127a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 01:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724314911; x=1724919711; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3dpSzOuftbRJNiLO+xVtoJdw4D15uNgfb12Nq5awHN8=;
        b=Bo9QmAZjC508uAyqLVIyGawc2W+X8tT+mPxrNdsXXsi2lgrxC7O/j/uoSSM4bOqtPL
         gcE1D6NXI+G8jz8JZ5oEGs3Xew4Zkz4X3g7i258KWvw6SxcR/M24VFcb09yBecHwN1bb
         Fy7xZC/nQ89M49LYG/9oXuI++u+yBNxP16PTP4R+Jx/2qAJ22dhiwGDKxX3ufIu6ZeyP
         kamdzzLWYssBWDt6GPNEyUtgOxlK3+xrBRo9PF/FF3KYLlInSWmXxPlxTfll2LrANt5/
         6pDJr8jHCIFz6cxIFM+U25W532LH1UEh83D19VqUZ4cp5so10mvFYOdNNGwq0MeZgszg
         g/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724314911; x=1724919711;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3dpSzOuftbRJNiLO+xVtoJdw4D15uNgfb12Nq5awHN8=;
        b=d/Zp9r9eNf3OeYbcHOqLAEwo2RrILvpBfZ/alHmDIn/u1r4+EFluBCYU+6bX3lGFPY
         XceGAO4MHhF2od14w9XtrzuCFxZx4XAQHgfbG9ZCmlHo9uTm6VeJM10fRzHyZsAHWoGV
         tqe1qoBd7J4pzbZD38Cz7NlsV4OKrqbH3KGDusBFCMnMCird0n6VlrKHfYCybCEgX2qJ
         ubIm1rOmOKqLTD3Jm/nGHbbbWsVvBhyFqgUVzMpcAJhckSiq1J9KM9EtjinoiEBd5ju4
         Pd0vQe2j3AkgnI1Jl4+6uOb/EKAU5i0E2WbueRK5mpN0oFVR1VjUWfb+vsxI30mJLtWR
         oAzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpZ3M/iRMntOfl6YmGMAZgWBRzJjWrOUaWWjg78eTuqOmIJozAKzyA0D5N9m3Ct0zthGPsXPndm6SJuY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzksDXm18ORrPCcRS9qLbTeJM5KQ7r8Bg3pCv5uq67BS4JPX7sf
	NxMUaBmwSJ/4/VXyu1t1eGKpZhrakfbj+IKqH/HsMpmJfgYI7h9ZV9iakfxSNgG2abVfvEJwclb
	d/kYMbMHMjl4kl51AhPo01NxI9rWhmOedV51cwsyVdTF79Qfq
X-Google-Smtp-Source: AGHT+IH/jPuPsThnZl2mTfikaSSqQ/kw2tRND5CFWkeomYdr9Hd98kmB3HTUqt/AOmk9rKrVELpE0VvknzN5dkX0SMc=
X-Received: by 2002:a17:90b:3e81:b0:2c9:8020:1b51 with SMTP id
 98e67ed59e1d1-2d5e99e0b47mr6218346a91.3.1724314910556; Thu, 22 Aug 2024
 01:21:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727102732.960974693@infradead.org> <20240727105029.315205425@infradead.org>
 <6f39e567-fd9a-4157-949d-7a9ccd9c3592@arm.com> <CAKfTPtAS0eSqf5Qoq_rpQC7DbyyGX=GACsB7OPdhi8=HEciPUQ@mail.gmail.com>
In-Reply-To: <CAKfTPtAS0eSqf5Qoq_rpQC7DbyyGX=GACsB7OPdhi8=HEciPUQ@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 22 Aug 2024 10:21:39 +0200
Message-ID: <CAKfTPtBPhDQD7XLcqpS_oX68GZ49=kOkhtnKHNT2NoPSN8rR2w@mail.gmail.com>
Subject: Re: [PATCH 10/24] sched/uclamg: Handle delayed dequeue
To: Hongyan Xia <hongyan.xia2@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org, 
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com, youssefesmat@chromium.org, 
	tglx@linutronix.de, efault@gmx.de, Luis Machado <luis.machado@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Aug 2024 at 10:19, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Hi,
>
> On Wed, 21 Aug 2024 at 15:34, Hongyan Xia <hongyan.xia2@arm.com> wrote:
> >
> > Hi Peter,
> >
> > Sorry for bombarding this thread in the last couple of days. I'm seeing
> > several issues in the latest tip/sched/core after these patches landed.
> >
> > What I'm now seeing seems to be an unbalanced call of util_est. First, I applied
>
> I also see a remaining util_est for idle rq because of an unbalance
> call of util_est_enqueue|dequeue
>
> > the following diff to warn against util_est != 0 when no tasks are on
> > the queue:
> >
> > https://lore.kernel.org/all/752ae417c02b9277ca3ec18893747c54dd5f277f.1724245193.git.hongyan.xia2@arm.com/
> >
> > Then, I'm reliably seeing warnings on my Juno board during boot in
> > latest tip/sched/core.
> >
> > If I do the same thing to util_est just like what you did in this uclamp
> > patch, like this:
>
> I think that the solution is simpler than your proposal and we just
> need to always call util_est_enqueue() before the
> requeue_delayed_entity

I have been too quick and the below doesn't fix the problem
>
> @@ -6970,11 +6970,6 @@ enqueue_task_fair(struct rq *rq, struct
> task_struct *p, int flags)
>         int rq_h_nr_running = rq->cfs.h_nr_running;
>         u64 slice = 0;
>
> -       if (flags & ENQUEUE_DELAYED) {
> -               requeue_delayed_entity(se);
> -               return;
> -       }
> -
>         /*
>          * The code below (indirectly) updates schedutil which looks at
>          * the cfs_rq utilization to select a frequency.
> @@ -6983,6 +6978,11 @@ enqueue_task_fair(struct rq *rq, struct
> task_struct *p, int flags)
>          */
>         util_est_enqueue(&rq->cfs, p);
>
> +       if (flags & ENQUEUE_DELAYED) {
> +               requeue_delayed_entity(se);
> +               return;
> +       }
> +
>         /*
>          * If in_iowait is set, the code below may not trigger any cpufreq
>          * utilization updates, so do it here explicitly with the IOWAIT flag
>
>
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 574ef19df64b..58aac42c99e5 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6946,7 +6946,7 @@ enqueue_task_fair(struct rq *rq, struct
> > task_struct *p, int flags)
> >
> >         if (flags & ENQUEUE_DELAYED) {
> >                 requeue_delayed_entity(se);
> > -               return;
> > +               goto util_est;
> >         }
> >
> >         /*
> > @@ -6955,7 +6955,6 @@ enqueue_task_fair(struct rq *rq, struct
> > task_struct *p, int flags)
> >          * Let's add the task's estimated utilization to the cfs_rq's
> >          * estimated utilization, before we update schedutil.
> >          */
> > -       util_est_enqueue(&rq->cfs, p);
> >
> >         /*
> >          * If in_iowait is set, the code below may not trigger any cpufreq
> > @@ -7050,6 +7049,9 @@ enqueue_task_fair(struct rq *rq, struct
> > task_struct *p, int flags)
> >         assert_list_leaf_cfs_rq(rq);
> >
> >         hrtick_update(rq);
> > +util_est:
> > +       if (!p->se.sched_delayed)
> > +               util_est_enqueue(&rq->cfs, p);
> >   }
> >
> >   static void set_next_buddy(struct sched_entity *se);
> > @@ -7173,7 +7175,8 @@ static int dequeue_entities(struct rq *rq, struct
> > sched_entity *se, int flags)
> >    */
> >   static bool dequeue_task_fair(struct rq *rq, struct task_struct *p,
> > int flags)
> >   {
> > -       util_est_dequeue(&rq->cfs, p);
> > +       if (!p->se.sched_delayed)
> > +               util_est_dequeue(&rq->cfs, p);
> >
> >         if (dequeue_entities(rq, &p->se, flags) < 0) {
> >                 if (!rq->cfs.h_nr_running)
> >
> > which is basically enqueuing util_est after enqueue_task_fair(),
> > dequeuing util_est before dequeue_task_fair() and double check
> > p->se.delayed_dequeue, then the unbalanced issue seems to go away.
> >
> > Hopefully this helps you in finding where the problem could be.
> >
> > Hongyan
> >
> > On 27/07/2024 11:27, Peter Zijlstra wrote:
> > > Delayed dequeue has tasks sit around on the runqueue that are not
> > > actually runnable -- specifically, they will be dequeued the moment
> > > they get picked.
> > >
> > > One side-effect is that such a task can get migrated, which leads to a
> > > 'nested' dequeue_task() scenario that messes up uclamp if we don't
> > > take care.
> > >
> > > Notably, dequeue_task(DEQUEUE_SLEEP) can 'fail' and keep the task on
> > > the runqueue. This however will have removed the task from uclamp --
> > > per uclamp_rq_dec() in dequeue_task(). So far so good.
> > >
> > > However, if at that point the task gets migrated -- or nice adjusted
> > > or any of a myriad of operations that does a dequeue-enqueue cycle --
> > > we'll pass through dequeue_task()/enqueue_task() again. Without
> > > modification this will lead to a double decrement for uclamp, which is
> > > wrong.
> > >
> > > Reported-by: Luis Machado <luis.machado@arm.com>
> > > Reported-by: Hongyan Xia <hongyan.xia2@arm.com>
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >   kernel/sched/core.c |   16 +++++++++++++++-
> > >   1 file changed, 15 insertions(+), 1 deletion(-)
> > >
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -1676,6 +1676,9 @@ static inline void uclamp_rq_inc(struct
> > >       if (unlikely(!p->sched_class->uclamp_enabled))
> > >               return;
> > >
> > > +     if (p->se.sched_delayed)
> > > +             return;
> > > +
> > >       for_each_clamp_id(clamp_id)
> > >               uclamp_rq_inc_id(rq, p, clamp_id);
> > >
> > > @@ -1700,6 +1703,9 @@ static inline void uclamp_rq_dec(struct
> > >       if (unlikely(!p->sched_class->uclamp_enabled))
> > >               return;
> > >
> > > +     if (p->se.sched_delayed)
> > > +             return;
> > > +
> > >       for_each_clamp_id(clamp_id)
> > >               uclamp_rq_dec_id(rq, p, clamp_id);
> > >   }
> > > @@ -1979,8 +1985,12 @@ void enqueue_task(struct rq *rq, struct
> > >               psi_enqueue(p, (flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED));
> > >       }
> > >
> > > -     uclamp_rq_inc(rq, p);
> > >       p->sched_class->enqueue_task(rq, p, flags);
> > > +     /*
> > > +      * Must be after ->enqueue_task() because ENQUEUE_DELAYED can clear
> > > +      * ->sched_delayed.
> > > +      */
> > > +     uclamp_rq_inc(rq, p);
> > >
> > >       if (sched_core_enabled(rq))
> > >               sched_core_enqueue(rq, p);
> > > @@ -2002,6 +2012,10 @@ inline bool dequeue_task(struct rq *rq,
> > >               psi_dequeue(p, flags & DEQUEUE_SLEEP);
> > >       }
> > >
> > > +     /*
> > > +      * Must be before ->dequeue_task() because ->dequeue_task() can 'fail'
> > > +      * and mark the task ->sched_delayed.
> > > +      */
> > >       uclamp_rq_dec(rq, p);
> > >       return p->sched_class->dequeue_task(rq, p, flags);
> > >   }
> > >
> > >

