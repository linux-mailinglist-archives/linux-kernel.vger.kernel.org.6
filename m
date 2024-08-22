Return-Path: <linux-kernel+bounces-296874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E61695B011
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 069181F2389B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4026116EBEC;
	Thu, 22 Aug 2024 08:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rT4MXe2l"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED0216EBED
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 08:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724314785; cv=none; b=RvTYPXWCRdV2cCrPENP/8g4bxqYCIa8KQgwXM7FQVeBymCZ0uy6j9JX4LEpqnaCTswlHA33OBmIid/p9UeQ38tbyCGKo2V/EG+Wi5H7eUgURjgNhZ/1xT+oHJzx4PkK7IeIC7oZiFcnlojvLLaVVTiS4Dz9araHLIs/ZgtBp21Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724314785; c=relaxed/simple;
	bh=dJ7LuUxEv4Ubr9Mg9S84yXfwRVHbkheGGb/rVD9WOWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MVz/9zp4H9Zhsj6OLeSiEicwKvIeyNxWjsrSNd3h8sbk26FttQdWhRVSFrtuA3JvqK+VwmanvDd/jwzYSrNDBWbhFDueQscly1CTOh7CTUm1eyCQ08kgvUOK80UCEoJ1UBUBzjz8rs5WUZJreHy1IB8dIjkIYnTWnL3GbmZO+Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rT4MXe2l; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7bcf8077742so397617a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 01:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724314783; x=1724919583; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7gD8WW/dw395N2/VFJGvpDLTIoJz/GY9Bh3cjvUOh/U=;
        b=rT4MXe2lcCzT365NGup/ldcUCnEMEqZRQpvg5l+Yu1RIMKdzzqX5uYtMcwl9bnASiI
         ljYuM5QL66qpQY78+Id+XH+eRBHwrRqcXgSJg5AgfwRgwLZ2V117splvW/9GdIewyoFE
         p9DJliUXn/qcSGWaJ1xJhFhczwjP1sCm/eb6yUU9RMzqPACuNTkXL9WponN796+nrsok
         kz4I2QbAmxwNIjAnb7CA3H1OEVqqek3lCp5XzECOaZVwryRd5kEFLbaJPhun88x+SzU4
         owegUncGwhh3jZYDntx9fxapEAoPBpaeva7ocj1e1edR1GhAof/NIlubb/+kz2elQtSN
         aLFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724314783; x=1724919583;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7gD8WW/dw395N2/VFJGvpDLTIoJz/GY9Bh3cjvUOh/U=;
        b=lTXt3qhyC4XnOtx9BMmboK3NnpiOCW15mF6y8O6mJD7Mzgi5ElxivBIAIb0j/KhkK5
         Zn9L2GbJvjitEYtCEtYIPxvRSdFXapqc5bKUnk39vqTaaZdTO4ndr+K0tkRvJafmgJW/
         lNF38vRO/9mUlamh407wn1o7/vGNh9L9AqcVivkUqCB86WDhiHIIlgmosVDrRQUWX/M/
         5ZVQBAn5MEInspVjpbhJqAmr696aZTBEOyxfQ5hSHMWAHF1pVvCpmZ/RUiSmPgh3Kvtl
         S2rENHjjUrZqCwq1gGcMGzboLAjsLbvvZziKUYUQ/dgwNDRtyQrmkwuRN/g+S74irNUW
         i+ng==
X-Forwarded-Encrypted: i=1; AJvYcCUjd1iyOeCTpDwQ1jIHWK13zOibSAawTnUbg/M9r8VG4lIehlqQ4ImTh6uE4LmF+6Yd5u0+Re0lhjwX7zE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA+hoCfk7MAPR/RXmSye1ss2JNid3r4EZ7ud3oGbc7HBAcU/jI
	pBrEt/Bc6neKTf7/7M0PB+idC5enq3fLdOBjuz9DQCpQ2dB2YZTqmycSBKtP1lr6bdyEuoyHA9U
	dexAhUIFcw5xnSQpOsholc7rjQge+hxi/i3lDLQ==
X-Google-Smtp-Source: AGHT+IH8rl6oioJzwuIha3eBEKULsc/zbjawWz8m+Wo3X1L2+OtK3dxoNg1CVqJo9IJnTjqXtrG2fon3N0fMo7runfg=
X-Received: by 2002:a17:90b:20a:b0:2d3:d7e4:6800 with SMTP id
 98e67ed59e1d1-2d5e9b9a1f5mr5846114a91.22.1724314782728; Thu, 22 Aug 2024
 01:19:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727102732.960974693@infradead.org> <20240727105029.315205425@infradead.org>
 <6f39e567-fd9a-4157-949d-7a9ccd9c3592@arm.com>
In-Reply-To: <6f39e567-fd9a-4157-949d-7a9ccd9c3592@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 22 Aug 2024 10:19:31 +0200
Message-ID: <CAKfTPtAS0eSqf5Qoq_rpQC7DbyyGX=GACsB7OPdhi8=HEciPUQ@mail.gmail.com>
Subject: Re: [PATCH 10/24] sched/uclamg: Handle delayed dequeue
To: Hongyan Xia <hongyan.xia2@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org, 
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com, youssefesmat@chromium.org, 
	tglx@linutronix.de, efault@gmx.de, Luis Machado <luis.machado@arm.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

On Wed, 21 Aug 2024 at 15:34, Hongyan Xia <hongyan.xia2@arm.com> wrote:
>
> Hi Peter,
>
> Sorry for bombarding this thread in the last couple of days. I'm seeing
> several issues in the latest tip/sched/core after these patches landed.
>
> What I'm now seeing seems to be an unbalanced call of util_est. First, I applied

I also see a remaining util_est for idle rq because of an unbalance
call of util_est_enqueue|dequeue

> the following diff to warn against util_est != 0 when no tasks are on
> the queue:
>
> https://lore.kernel.org/all/752ae417c02b9277ca3ec18893747c54dd5f277f.1724245193.git.hongyan.xia2@arm.com/
>
> Then, I'm reliably seeing warnings on my Juno board during boot in
> latest tip/sched/core.
>
> If I do the same thing to util_est just like what you did in this uclamp
> patch, like this:

I think that the solution is simpler than your proposal and we just
need to always call util_est_enqueue() before the
requeue_delayed_entity

@@ -6970,11 +6970,6 @@ enqueue_task_fair(struct rq *rq, struct
task_struct *p, int flags)
        int rq_h_nr_running = rq->cfs.h_nr_running;
        u64 slice = 0;

-       if (flags & ENQUEUE_DELAYED) {
-               requeue_delayed_entity(se);
-               return;
-       }
-
        /*
         * The code below (indirectly) updates schedutil which looks at
         * the cfs_rq utilization to select a frequency.
@@ -6983,6 +6978,11 @@ enqueue_task_fair(struct rq *rq, struct
task_struct *p, int flags)
         */
        util_est_enqueue(&rq->cfs, p);

+       if (flags & ENQUEUE_DELAYED) {
+               requeue_delayed_entity(se);
+               return;
+       }
+
        /*
         * If in_iowait is set, the code below may not trigger any cpufreq
         * utilization updates, so do it here explicitly with the IOWAIT flag


>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 574ef19df64b..58aac42c99e5 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6946,7 +6946,7 @@ enqueue_task_fair(struct rq *rq, struct
> task_struct *p, int flags)
>
>         if (flags & ENQUEUE_DELAYED) {
>                 requeue_delayed_entity(se);
> -               return;
> +               goto util_est;
>         }
>
>         /*
> @@ -6955,7 +6955,6 @@ enqueue_task_fair(struct rq *rq, struct
> task_struct *p, int flags)
>          * Let's add the task's estimated utilization to the cfs_rq's
>          * estimated utilization, before we update schedutil.
>          */
> -       util_est_enqueue(&rq->cfs, p);
>
>         /*
>          * If in_iowait is set, the code below may not trigger any cpufreq
> @@ -7050,6 +7049,9 @@ enqueue_task_fair(struct rq *rq, struct
> task_struct *p, int flags)
>         assert_list_leaf_cfs_rq(rq);
>
>         hrtick_update(rq);
> +util_est:
> +       if (!p->se.sched_delayed)
> +               util_est_enqueue(&rq->cfs, p);
>   }
>
>   static void set_next_buddy(struct sched_entity *se);
> @@ -7173,7 +7175,8 @@ static int dequeue_entities(struct rq *rq, struct
> sched_entity *se, int flags)
>    */
>   static bool dequeue_task_fair(struct rq *rq, struct task_struct *p,
> int flags)
>   {
> -       util_est_dequeue(&rq->cfs, p);
> +       if (!p->se.sched_delayed)
> +               util_est_dequeue(&rq->cfs, p);
>
>         if (dequeue_entities(rq, &p->se, flags) < 0) {
>                 if (!rq->cfs.h_nr_running)
>
> which is basically enqueuing util_est after enqueue_task_fair(),
> dequeuing util_est before dequeue_task_fair() and double check
> p->se.delayed_dequeue, then the unbalanced issue seems to go away.
>
> Hopefully this helps you in finding where the problem could be.
>
> Hongyan
>
> On 27/07/2024 11:27, Peter Zijlstra wrote:
> > Delayed dequeue has tasks sit around on the runqueue that are not
> > actually runnable -- specifically, they will be dequeued the moment
> > they get picked.
> >
> > One side-effect is that such a task can get migrated, which leads to a
> > 'nested' dequeue_task() scenario that messes up uclamp if we don't
> > take care.
> >
> > Notably, dequeue_task(DEQUEUE_SLEEP) can 'fail' and keep the task on
> > the runqueue. This however will have removed the task from uclamp --
> > per uclamp_rq_dec() in dequeue_task(). So far so good.
> >
> > However, if at that point the task gets migrated -- or nice adjusted
> > or any of a myriad of operations that does a dequeue-enqueue cycle --
> > we'll pass through dequeue_task()/enqueue_task() again. Without
> > modification this will lead to a double decrement for uclamp, which is
> > wrong.
> >
> > Reported-by: Luis Machado <luis.machado@arm.com>
> > Reported-by: Hongyan Xia <hongyan.xia2@arm.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >   kernel/sched/core.c |   16 +++++++++++++++-
> >   1 file changed, 15 insertions(+), 1 deletion(-)
> >
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1676,6 +1676,9 @@ static inline void uclamp_rq_inc(struct
> >       if (unlikely(!p->sched_class->uclamp_enabled))
> >               return;
> >
> > +     if (p->se.sched_delayed)
> > +             return;
> > +
> >       for_each_clamp_id(clamp_id)
> >               uclamp_rq_inc_id(rq, p, clamp_id);
> >
> > @@ -1700,6 +1703,9 @@ static inline void uclamp_rq_dec(struct
> >       if (unlikely(!p->sched_class->uclamp_enabled))
> >               return;
> >
> > +     if (p->se.sched_delayed)
> > +             return;
> > +
> >       for_each_clamp_id(clamp_id)
> >               uclamp_rq_dec_id(rq, p, clamp_id);
> >   }
> > @@ -1979,8 +1985,12 @@ void enqueue_task(struct rq *rq, struct
> >               psi_enqueue(p, (flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED));
> >       }
> >
> > -     uclamp_rq_inc(rq, p);
> >       p->sched_class->enqueue_task(rq, p, flags);
> > +     /*
> > +      * Must be after ->enqueue_task() because ENQUEUE_DELAYED can clear
> > +      * ->sched_delayed.
> > +      */
> > +     uclamp_rq_inc(rq, p);
> >
> >       if (sched_core_enabled(rq))
> >               sched_core_enqueue(rq, p);
> > @@ -2002,6 +2012,10 @@ inline bool dequeue_task(struct rq *rq,
> >               psi_dequeue(p, flags & DEQUEUE_SLEEP);
> >       }
> >
> > +     /*
> > +      * Must be before ->dequeue_task() because ->dequeue_task() can 'fail'
> > +      * and mark the task ->sched_delayed.
> > +      */
> >       uclamp_rq_dec(rq, p);
> >       return p->sched_class->dequeue_task(rq, p, flags);
> >   }
> >
> >

