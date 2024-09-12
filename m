Return-Path: <linux-kernel+bounces-326504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FB597692E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ADBDB212AE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 12:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062F91A0BC5;
	Thu, 12 Sep 2024 12:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g4muzwlk"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F50A47
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 12:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726144263; cv=none; b=l0OlOobaBq9ctSZw1geN1NicVGexzUfULfZXOMklqUr3/8fbX4SJBulf3FXEH+SE0abuVXerAoMhqTcK7sBoCy73krKzXNvuVxq0StKsBfS6NEtAvJ/l9n0WqMdV+/TsGhBE2eYLekN+ff933L8H2nY5QR10pjK4j8Kv02Odt7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726144263; c=relaxed/simple;
	bh=ypfhf4rMxR6lr4q8W4SwWe/uXxVs+utbA5uCei2u930=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fv9JheIc5LGy/NWOqSv7VTKmt6hg4Y2Je5yA543IBOe8GJusUVDUNwmCAdsstqsJ1ccXCM0MWI1xAuliociQmMPYvCT8OU0Uy7hyoOqB9mGtobK8Hns4J/CBeow19JQKNrhflhf1b5k5tKAvNJ0AMBSufkGoFnPBxD5PsySco1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g4muzwlk; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d8fa2ca5b1so718980a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 05:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726144261; x=1726749061; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kgTK2QnG0+iKmVKeShtiGZan+2/Q7TbF2kF0e2VUzG8=;
        b=g4muzwlkxANkJc2Iy96tVKnnABvSBhVG/tVeY6tc57SbyzXZSGgFj6I526ex5nqPFM
         bhiQqHCuLhUV+LKj+yHwuumsEZaXNaB7dh98SxNHJJ++VGAd4nPvuylGf7Z9sPTX4P7o
         R02FmhWDI/pOu+4sPE8Qxd3n5QXSTd64ML5/AqPr1O4cTsj/CBCwLvXzVDfPD5W0rwdn
         Ei7ftcAHqDmiJwUuDQG3LtiF/CWDKAyTLiknzY5+8K4k/UMD6a7AvUyv7/rjofVppKxe
         1NVWU7sG2SLgo2Peq50AmrR/82YCy7cF4FFFon+sWa70dew8NehXOsPEslzK9KsWiifE
         +jyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726144261; x=1726749061;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kgTK2QnG0+iKmVKeShtiGZan+2/Q7TbF2kF0e2VUzG8=;
        b=VaDwd1NVb/C7Cz5CPh4tfy+ZGRB8x5IJBYJa2ypTPQNsqB2qlazm6tpBxDOtdd/npN
         mCvagnwmAIJ2fUf+VDmc7aaLriqCTBqsOPxhYP1jwvx/igwd8jQurMlJIgx7gk6Jr/v7
         W7eMhlWhHD/2EGeDFCo3YecCszWa3LRN4z6vAdyvNdyccsuDYfAUf3fwaKRvbsEkrgIU
         UwLwRYQhtSMqhWtqFDSy5EuycDJuJgewku8/cR12OcIfvFe2tUCZZwMOrm74+caYzodk
         prog8tn7fr/ThqBlbZmcx9sVSKVKZ9pVnvnWxx34X+6Y0Y3Nq7CXtCA2PQby5ly+5m3k
         q/3w==
X-Forwarded-Encrypted: i=1; AJvYcCVmk0igQlkxVfhq+DIzA+dDT/hXs0REzcuAIDH2a1OGj0/q61AIBuI1e1/1tHi9XUPRVykqxsF8Hl1b8/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPhUG47g1NLiMvwPiC4K0V2VqFXQbUD6LsmDi41PZ1m57wOnzH
	v+bAHAC8t/xvqVr+fNcnXP2iy3QAnsBbbo4kegfvMaHA9+8tdtfvqBgPEwGsGfx4aA5M7XBHceR
	4qKDV+PbzY+qkpWSZH1N13ofsUyTSFvwnty3N2Q==
X-Google-Smtp-Source: AGHT+IGWO/KmZajpa6DdgT4HJwICA0A3wZb4ycRVmxIerveiQ9fpqJr2aYUggxRaAnfHmmdYeEOf2fyuJpuLZlrVz04=
X-Received: by 2002:a17:90b:1e4d:b0:2d3:bc5f:715f with SMTP id
 98e67ed59e1d1-2db9ff96352mr3450800a91.10.1726144260295; Thu, 12 Sep 2024
 05:31:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
 <20240830130309.2141697-6-vincent.guittot@linaro.org> <ccf4095f-5fca-42f4-b9fe-aa93e703016e@arm.com>
In-Reply-To: <ccf4095f-5fca-42f4-b9fe-aa93e703016e@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 12 Sep 2024 14:30:49 +0200
Message-ID: <CAKfTPtDm_e2feardrXN0M3679F67+gys=U7ZHQoyLL_LjzD04w@mail.gmail.com>
Subject: Re: [RFC PATCH 5/5] sched/fair: Add push task callback for EAS
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, lukasz.luba@arm.com, 
	rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, qyousef@layalina.io, 
	hongyan.xia2@arm.com
Content-Type: text/plain; charset="UTF-8"

Hello Pierre,

On Wed, 11 Sept 2024 at 16:03, Pierre Gondois <pierre.gondois@arm.com> wrote:
>
> Hello Vincent,
>
> On 8/30/24 15:03, Vincent Guittot wrote:
> > EAS is based on wakeup events to efficiently place tasks on the system, but
> > there are cases where a task will not have wakeup events anymore or at a
> > far too low pace. For such situation, we can take advantage of the task
> > being put back in the enqueued list to check if it should be migrated on
> > another CPU. When the task is the only one running on the CPU, the tick
> > will check it the task is stuck on this CPU and should migrate on another
> > one.
> >
> > Wake up events remain the main way to migrate tasks but we now detect
> > situation where a task is stuck on a CPU by checking that its utilization
> > is larger than the max available compute capacity (max cpu capacity or
> > uclamp max setting)
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >   kernel/sched/fair.c  | 211 +++++++++++++++++++++++++++++++++++++++++++
> >   kernel/sched/sched.h |   2 +
> >   2 files changed, 213 insertions(+)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index e46af2416159..41fb18ac118b 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
>
> [snip]
>
> > +
> > +static inline void check_misfit_cpu(struct task_struct *p, struct rq *rq)
> > +{
> > +     int new_cpu, cpu = cpu_of(rq);
> > +
> > +     if (!sched_energy_enabled())
> > +             return;
> > +
> > +     if (WARN_ON(!p))
> > +             return;
> > +
> > +     if (WARN_ON(p != rq->curr))
> > +             return;
> > +
> > +     if (is_migration_disabled(p))
> > +             return;
> > +
> > +     if ((rq->nr_running > 1) || (p->nr_cpus_allowed == 1))
> > +             return;
>
> I tried the code on a Pixel6 with the following setup:
> - without the above (rq->nr_running > 1) condition
> - without the push task mechanism
> i.e. tasks without regular wakeups only have the opportunity to
> run feec() via the sched_tick. It seemed sufficient to avoid
> the problematic you mentioned:
> - having unbalanced UCLAMP_MAX tasks in a pd, e.g. 1 UCLAMP_MAX task
>    per little CPU, except one little CPU with N UCLAMP_MAX tasks
> - downgrading UCLAMP_MAX tasks that could run on smaller CPUs
>    but have no wakeups and thus don't run feec()

The main problem with your test is that you always call feec() for the
running task so you always have to wake up the migration thread to
migrate the current running thread which is quite inefficient. The
push mechanism only takes a task which is not the current running one
and we don't need to wake up migration thread which is simpler and
more efficient. We check only one task at a time and will not loop on
an unbounded number of tasks after a task switch or a tick

>
> Thus I was wondering it it would not be better to integrate the
> EAS to the load balancer instead (not my idea, but don't remember
> who suggested that).

My 1st thought was also to use load balance to pull tasks which were
stuck on the wrong CPU (as mentioned in [1]) but this solution is not
scalable as we don't want to test all runnable task on a cpu and it's
not really easy to know which cpu and which tasks should be checked

[1] https://youtu.be/PHEBAyxeM_M?si=ZApIOw3BS4SOLPwp

> Or otherwise if just running feec() through the sched_tick path
> would not be sufficient (i.e. this patch minus the push mechanism).

As mentioned above, the push mechanism is more efficient than active migration.


>
> > +
> > +     if (!task_misfit_cpu(p, cpu))
> > +             return;
> > +
> > +     new_cpu = find_energy_efficient_cpu(p, cpu);
> > +
> > +     if (new_cpu == cpu)
> > +             return;
> > +
> > +     /*
> > +      * ->active_balance synchronizes accesses to
> > +      * ->active_balance_work.  Once set, it's cleared
> > +      * only after active load balance is finished.
> > +      */
> > +     if (!rq->active_balance) {
> > +             rq->active_balance = 1;
> > +             rq->push_cpu = new_cpu;
> > +     } else
> > +             return;
> > +
> > +     raw_spin_rq_unlock(rq);
> > +     stop_one_cpu_nowait(cpu,
> > +             active_load_balance_cpu_stop, rq,
> > +             &rq->active_balance_work);
> > +     raw_spin_rq_lock(rq);
>
> I didn't hit any error, but isn't it eligible to the following ?
>    commit f0498d2a54e7 ("sched: Fix stop_one_cpu_nowait() vs hotplug")
>

I will recheck but being called from the tick, for the local cpu and
with a running thread no being cpu_stopper_thread, should protect us
from the case describe in this commit

>
> > +}
> > +
> > +static inline int has_pushable_tasks(struct rq *rq)
> > +{
> > +     return !plist_head_empty(&rq->cfs.pushable_tasks);
> > +}
> > +
> > +static struct task_struct *pick_next_pushable_fair_task(struct rq *rq)
> > +{
> > +     struct task_struct *p;
> > +
> > +     if (!has_pushable_tasks(rq))
> > +             return NULL;
> > +
> > +     p = plist_first_entry(&rq->cfs.pushable_tasks,
> > +                           struct task_struct, pushable_tasks);
> > +
> > +     WARN_ON_ONCE(rq->cpu != task_cpu(p));
> > +     WARN_ON_ONCE(task_current(rq, p));
> > +     WARN_ON_ONCE(p->nr_cpus_allowed <= 1);
> > +
> > +     WARN_ON_ONCE(!task_on_rq_queued(p));
> > +
> > +     /*
> > +      * Remove task from the pushable list as we try only once after
> > +      * task has been put back in enqueued list.
> > +      */
> > +     plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
> > +
> > +     return p;
> > +}
> > +
> > +/*
> > + * See if the non running fair tasks on this rq
> > + * can be sent to some other CPU that fits better with
> > + * their profile.
> > + */
> > +static int push_fair_task(struct rq *rq)
> > +{
> > +     struct task_struct *next_task;
> > +     struct rq *new_rq;
> > +     int prev_cpu, new_cpu;
> > +     int ret = 0;
> > +
> > +     next_task = pick_next_pushable_fair_task(rq);
> > +     if (!next_task)
> > +             return 0;
> > +
> > +     if (is_migration_disabled(next_task))
> > +             return 0;
> > +
> > +     if (WARN_ON(next_task == rq->curr))
> > +             return 0;
> > +
> > +     /* We might release rq lock */
> > +     get_task_struct(next_task);
> > +
> > +     prev_cpu = rq->cpu;
> > +
> > +     new_cpu = find_energy_efficient_cpu(next_task, prev_cpu);
> > +
> > +     if (new_cpu == prev_cpu)
> > +             goto out;
> > +
> > +     new_rq = cpu_rq(new_cpu);
> > +
> > +     if (double_lock_balance(rq, new_rq)) {
>
>
> I think it might be necessary to check the following:
>    if (task_cpu(next_task) != rq->cpu) {
>      double_unlock_balance(rq, new_rq);

Yes good point

>      goto out;
>    }
>
> Indeed I've been hitting the following warnings:
> - uclamp_rq_dec_id():SCHED_WARN_ON(!bucket->tasks)
> - set_task_cpu()::WARN_ON_ONCE(state == TASK_RUNNING &&
>                      p->sched_class == &fair_sched_class &&
>                      (p->on_rq && !task_on_rq_migrating(p)))
> - update_entity_lag()::SCHED_WARN_ON(!se->on_rq)
>
> and it seemed to be caused by the task not being on the initial rq anymore.

Do you have a particular use case to trigger this ? I haven't faced
this in the various stress tests that  I did


>
> > +
> > +             deactivate_task(rq, next_task, 0);
> > +             set_task_cpu(next_task, new_cpu);
> > +             activate_task(new_rq, next_task, 0);
> > +             ret = 1;
> > +
> > +             resched_curr(new_rq);
> > +
> > +             double_unlock_balance(rq, new_rq);
> > +     }
> > +
> > +out:
> > +     put_task_struct(next_task);
> > +
> > +     return ret;
> > +}
> > +
>
> Regards,
> Pierre

