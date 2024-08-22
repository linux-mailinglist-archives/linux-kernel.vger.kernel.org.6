Return-Path: <linux-kernel+bounces-297056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6239C95B267
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 11:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEA3F1F24959
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4413D175D3F;
	Thu, 22 Aug 2024 09:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZaAfkEqc"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B03015F3F0
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 09:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724320405; cv=none; b=qNb6qzANy6SlQY94N4EpZq+n4hQM3MuYvxa0ueTqvIo5SUd4DUCBQSzFRpbVHczjwJmUNdhsqg02deStBatohRCOiJv+VdSImHV+w9ontnyGpj4n8p+MubmN2B399aPZ1sFX1RQDIu0tNfvdpqfYu00UO7VHnwTGZOne1d/FOFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724320405; c=relaxed/simple;
	bh=kjxJT0PufR2fBZ6eWMYdVwEKUblb9lUuf7DPVKPS12Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QFePWE3fVX6IXVf01RqkrWjnbRYZlzWG70ma9/t7mBIVsPuZgX9CYEe9JGmnzhNyaITcx0F+tIsAgVz9zgUzzGPPatr/l1dB85ng2rFLrgHQVx+2FD781+jqaE8XoOLA2xOP7y1cyuOmD21aRCBB4UhQqEbYZYctJSEmmSECRzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZaAfkEqc; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7cd830e0711so585279a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 02:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724320403; x=1724925203; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k6v89rhrKyUhVgO1w6bbOml5um8TYxqEfF5vzO7isEI=;
        b=ZaAfkEqcIo3rp1zI0iLd9yvQr4fi4IO0T8JMMMyU0SCYFwCKZsvowJ+zJ5TLFZE+O7
         NbYCTeda6mPC/NBlQBvE3sir5vVNZZjP+w8npV/KZaTPybizCjQr/YD8Sl9jAU+IsRDh
         hlXZnP0JhyWUqAm3QFSTrM17l/1vE+rUTdAPgp+bKU4jXtx1F5GTn44Fhk8SYt1rycAS
         jVxFZ3c5nW3OwlHcASM6GyMWKaWrVd49YxJFiqJ2MKOBSiFA9R9SFu1lxVqIoccjpSFP
         G4pf116JSj73KGae2ykk3v6zRca8hkvTPGyzyvklGBJ2ToeWocue0J65qYKXKaXFeH51
         qzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724320403; x=1724925203;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k6v89rhrKyUhVgO1w6bbOml5um8TYxqEfF5vzO7isEI=;
        b=VTdT/IAdMKuXzKMthwtwN3GD6DTx4ALC8+kTRRUetrqttEl0ONFZwum1FxPvSVWShP
         d7KDz2HpakHxBGX/OYEl/kGkDBov+oaVH7PwocVBEt09FJU4XerQhQH+Pld4y9amywzt
         aFsKS4I44i4fvqG75mdw33kLd8bRBD/0Pq6tFgCZsvzzDMyzSjUiu3VMvfkWn4tlRrTC
         j6REk3o6nETMysVHGxiqgDo3cZTVJsCJrPmvhfLd+hKuHx2o3h6EVPoZxnOAlEYTEbRC
         H6/0ITfGHXHmuqGDMirTYIKxD4tHcXRlMIShlwvHf/EDoBiA8UApkd5diml6/oHPonZF
         PAew==
X-Forwarded-Encrypted: i=1; AJvYcCUHDla71h387r1NkKYzMOSJqDg+5O4eAUFuupz3IaQYFPrvC+n6aFk+hKPErO0Sj4sAQpx3e58E+b43UG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqMQrHJmRluXuy15WQQJtsUZp83xJMdgRZYhsQKh+w64z2uLTe
	2r0JTEcyU6QPf+VvnFLX1kbxowNKI3uiT+5Ew8WvaIvVtg8IuPseXwKGQrc88kzRa4Z3CGOr6/b
	UFqCypUhK78ylGhkP4KMdcIe8lhimgTSA7lLCrw==
X-Google-Smtp-Source: AGHT+IHFRpkvfxbmXPRh29eoHXLed7FlXD9Hqza26GhJl+GAf7VYWdaTkmiIEi1s1HzSexLIJzqpQNl2pXdfo4vCdBY=
X-Received: by 2002:a17:90a:ff17:b0:2c8:2cd1:881b with SMTP id
 98e67ed59e1d1-2d60aa0f083mr3591110a91.20.1724320402615; Thu, 22 Aug 2024
 02:53:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727102732.960974693@infradead.org> <20240727105029.315205425@infradead.org>
 <6f39e567-fd9a-4157-949d-7a9ccd9c3592@arm.com> <CAKfTPtAS0eSqf5Qoq_rpQC7DbyyGX=GACsB7OPdhi8=HEciPUQ@mail.gmail.com>
 <1debbea4-a0cf-4de9-9033-4f6135a156ed@arm.com>
In-Reply-To: <1debbea4-a0cf-4de9-9033-4f6135a156ed@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 22 Aug 2024 11:53:11 +0200
Message-ID: <CAKfTPtCEUZxV9zMpguf7RKs6njLsJJUmz8WadyS4ryr+Fqca1Q@mail.gmail.com>
Subject: Re: [PATCH 10/24] sched/uclamg: Handle delayed dequeue
To: Luis Machado <luis.machado@arm.com>
Cc: Hongyan Xia <hongyan.xia2@arm.com>, Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, kprateek.nayak@amd.com, 
	wuyun.abel@bytedance.com, youssefesmat@chromium.org, tglx@linutronix.de, 
	efault@gmx.de
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Aug 2024 at 11:22, Luis Machado <luis.machado@arm.com> wrote:
>
> On 8/22/24 09:19, Vincent Guittot wrote:
> > Hi,
> >
> > On Wed, 21 Aug 2024 at 15:34, Hongyan Xia <hongyan.xia2@arm.com> wrote:
> >>
> >> Hi Peter,
> >>
> >> Sorry for bombarding this thread in the last couple of days. I'm seeing
> >> several issues in the latest tip/sched/core after these patches landed.
> >>
> >> What I'm now seeing seems to be an unbalanced call of util_est. First, I applied
> >
> > I also see a remaining util_est for idle rq because of an unbalance
> > call of util_est_enqueue|dequeue
> >
>
> I can confirm issues with the utilization values and frequencies being driven
> seemingly incorrectly, in particular for little cores.
>
> What I'm seeing with the stock series is high utilization values for some tasks
> and little cores having their frequencies maxed out for extended periods of
> time. Sometimes for 5+ or 10+ seconds, which is excessive as the cores are mostly
> idle. But whenever certain tasks get scheduled there, they have a very high util
> level and so the frequency is kept at max.
>
> As a consequence this drives up power usage.
>
> I gave Hongyan's draft fix a try and observed a much more reasonable behavior for
> the util numbers and frequencies being used for the little cores. With his fix,
> I can also see lower energy use for my specific benchmark.

The main problem is that the util_est of a delayed dequeued task
remains on the rq and keeps the rq utilization high and as a result
the frequency higher than needed.

The below seems to works for me and keep sync the enqueue/dequeue of
uti_test with the enqueue/dequeue of the task as if de dequeue was not
delayed

Another interest is that we will not try to migrate a delayed dequeue
sleeping task that doesn't actually impact the current load of the cpu
and as a result will not help in the load balance. I haven't yet fully
checked what would happen with hotplug

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fea057b311f6..0970bcdc889a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6944,11 +6944,6 @@ enqueue_task_fair(struct rq *rq, struct
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
@@ -6957,6 +6952,11 @@ enqueue_task_fair(struct rq *rq, struct
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
@@ -9276,6 +9276,8 @@ int can_migrate_task(struct task_struct *p,
struct lb_env *env)

        lockdep_assert_rq_held(env->src_rq);

+       if (p->se.sched_delayed)
+               return 0;
        /*
         * We do not migrate tasks that are:
         * 1) throttled_lb_pair, or

>
>
> >> the following diff to warn against util_est != 0 when no tasks are on
> >> the queue:
> >>
> >> https://lore.kernel.org/all/752ae417c02b9277ca3ec18893747c54dd5f277f.1724245193.git.hongyan.xia2@arm.com/
> >>
> >> Then, I'm reliably seeing warnings on my Juno board during boot in
> >> latest tip/sched/core.
> >>
> >> If I do the same thing to util_est just like what you did in this uclamp
> >> patch, like this:
> >
> > I think that the solution is simpler than your proposal and we just
> > need to always call util_est_enqueue() before the
> > requeue_delayed_entity
> >
> > @@ -6970,11 +6970,6 @@ enqueue_task_fair(struct rq *rq, struct
> > task_struct *p, int flags)
> >         int rq_h_nr_running = rq->cfs.h_nr_running;
> >         u64 slice = 0;
> >
> > -       if (flags & ENQUEUE_DELAYED) {
> > -               requeue_delayed_entity(se);
> > -               return;
> > -       }
> > -
> >         /*
> >          * The code below (indirectly) updates schedutil which looks at
> >          * the cfs_rq utilization to select a frequency.
> > @@ -6983,6 +6978,11 @@ enqueue_task_fair(struct rq *rq, struct
> > task_struct *p, int flags)
> >          */
> >         util_est_enqueue(&rq->cfs, p);
> >
> > +       if (flags & ENQUEUE_DELAYED) {
> > +               requeue_delayed_entity(se);
> > +               return;
> > +       }
> > +
> >         /*
> >          * If in_iowait is set, the code below may not trigger any cpufreq
> >          * utilization updates, so do it here explicitly with the IOWAIT flag
> >
> >
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index 574ef19df64b..58aac42c99e5 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -6946,7 +6946,7 @@ enqueue_task_fair(struct rq *rq, struct
> >> task_struct *p, int flags)
> >>
> >>         if (flags & ENQUEUE_DELAYED) {
> >>                 requeue_delayed_entity(se);
> >> -               return;
> >> +               goto util_est;
> >>         }
> >>
> >>         /*
> >> @@ -6955,7 +6955,6 @@ enqueue_task_fair(struct rq *rq, struct
> >> task_struct *p, int flags)
> >>          * Let's add the task's estimated utilization to the cfs_rq's
> >>          * estimated utilization, before we update schedutil.
> >>          */
> >> -       util_est_enqueue(&rq->cfs, p);
> >>
> >>         /*
> >>          * If in_iowait is set, the code below may not trigger any cpufreq
> >> @@ -7050,6 +7049,9 @@ enqueue_task_fair(struct rq *rq, struct
> >> task_struct *p, int flags)
> >>         assert_list_leaf_cfs_rq(rq);
> >>
> >>         hrtick_update(rq);
> >> +util_est:
> >> +       if (!p->se.sched_delayed)
> >> +               util_est_enqueue(&rq->cfs, p);
> >>   }
> >>
> >>   static void set_next_buddy(struct sched_entity *se);
> >> @@ -7173,7 +7175,8 @@ static int dequeue_entities(struct rq *rq, struct
> >> sched_entity *se, int flags)
> >>    */
> >>   static bool dequeue_task_fair(struct rq *rq, struct task_struct *p,
> >> int flags)
> >>   {
> >> -       util_est_dequeue(&rq->cfs, p);
> >> +       if (!p->se.sched_delayed)
> >> +               util_est_dequeue(&rq->cfs, p);
> >>
> >>         if (dequeue_entities(rq, &p->se, flags) < 0) {
> >>                 if (!rq->cfs.h_nr_running)
> >>
> >> which is basically enqueuing util_est after enqueue_task_fair(),
> >> dequeuing util_est before dequeue_task_fair() and double check
> >> p->se.delayed_dequeue, then the unbalanced issue seems to go away.
> >>
> >> Hopefully this helps you in finding where the problem could be.
> >>
> >> Hongyan
> >>
> >> On 27/07/2024 11:27, Peter Zijlstra wrote:
> >>> Delayed dequeue has tasks sit around on the runqueue that are not
> >>> actually runnable -- specifically, they will be dequeued the moment
> >>> they get picked.
> >>>
> >>> One side-effect is that such a task can get migrated, which leads to a
> >>> 'nested' dequeue_task() scenario that messes up uclamp if we don't
> >>> take care.
> >>>
> >>> Notably, dequeue_task(DEQUEUE_SLEEP) can 'fail' and keep the task on
> >>> the runqueue. This however will have removed the task from uclamp --
> >>> per uclamp_rq_dec() in dequeue_task(). So far so good.
> >>>
> >>> However, if at that point the task gets migrated -- or nice adjusted
> >>> or any of a myriad of operations that does a dequeue-enqueue cycle --
> >>> we'll pass through dequeue_task()/enqueue_task() again. Without
> >>> modification this will lead to a double decrement for uclamp, which is
> >>> wrong.
> >>>
> >>> Reported-by: Luis Machado <luis.machado@arm.com>
> >>> Reported-by: Hongyan Xia <hongyan.xia2@arm.com>
> >>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >>> ---
> >>>   kernel/sched/core.c |   16 +++++++++++++++-
> >>>   1 file changed, 15 insertions(+), 1 deletion(-)
> >>>
> >>> --- a/kernel/sched/core.c
> >>> +++ b/kernel/sched/core.c
> >>> @@ -1676,6 +1676,9 @@ static inline void uclamp_rq_inc(struct
> >>>       if (unlikely(!p->sched_class->uclamp_enabled))
> >>>               return;
> >>>
> >>> +     if (p->se.sched_delayed)
> >>> +             return;
> >>> +
> >>>       for_each_clamp_id(clamp_id)
> >>>               uclamp_rq_inc_id(rq, p, clamp_id);
> >>>
> >>> @@ -1700,6 +1703,9 @@ static inline void uclamp_rq_dec(struct
> >>>       if (unlikely(!p->sched_class->uclamp_enabled))
> >>>               return;
> >>>
> >>> +     if (p->se.sched_delayed)
> >>> +             return;
> >>> +
> >>>       for_each_clamp_id(clamp_id)
> >>>               uclamp_rq_dec_id(rq, p, clamp_id);
> >>>   }
> >>> @@ -1979,8 +1985,12 @@ void enqueue_task(struct rq *rq, struct
> >>>               psi_enqueue(p, (flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED));
> >>>       }
> >>>
> >>> -     uclamp_rq_inc(rq, p);
> >>>       p->sched_class->enqueue_task(rq, p, flags);
> >>> +     /*
> >>> +      * Must be after ->enqueue_task() because ENQUEUE_DELAYED can clear
> >>> +      * ->sched_delayed.
> >>> +      */
> >>> +     uclamp_rq_inc(rq, p);
> >>>
> >>>       if (sched_core_enabled(rq))
> >>>               sched_core_enqueue(rq, p);
> >>> @@ -2002,6 +2012,10 @@ inline bool dequeue_task(struct rq *rq,
> >>>               psi_dequeue(p, flags & DEQUEUE_SLEEP);
> >>>       }
> >>>
> >>> +     /*
> >>> +      * Must be before ->dequeue_task() because ->dequeue_task() can 'fail'
> >>> +      * and mark the task ->sched_delayed.
> >>> +      */
> >>>       uclamp_rq_dec(rq, p);
> >>>       return p->sched_class->dequeue_task(rq, p, flags);
> >>>   }
> >>>
> >>>
>

