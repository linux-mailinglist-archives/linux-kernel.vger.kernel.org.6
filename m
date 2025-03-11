Return-Path: <linux-kernel+bounces-556506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E30AA5CACF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E8757A834F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C846A25F990;
	Tue, 11 Mar 2025 16:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ByFWe6ff"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F8E25F790
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 16:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741710494; cv=none; b=I+8QOJf3IPRB+1oUUchoNbzrcgol3R+XvhB9s/r37YFXih4hiunGUKDHNtNwDbmI2OKVuvC9EL+zAD0kClvp7o/JoTLQA4KIcXAi/sSzdP2/0w4K+tcW97uKHhZ+n4aEckY8Tbd6aDBhnD0sdoPFp380OzUGt0EUVdZ5uP+Hj2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741710494; c=relaxed/simple;
	bh=x+wpmtAYgSc+pe4W1R7hHOB2+1F3s2w0i+kgH7KmulQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eTLjmusDGz5cYBIly8J6UK2DCUJenDA440cNBcumBeYqSvMvnhAmMlySgWWi2K8rXvU1B8oDdpYnka8dBlDAJRGkT+EdoYfyE+Hy9Px+sIdOgWHE+t1lenOMmEp7WstD6pkvU7xQc3Sxdo+hVvYCin9XZuJ5v8ngVlbFKwrPuFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ByFWe6ff; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2c663a3daso152396566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 09:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741710491; x=1742315291; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oXkZmkekDF4erQW4L8Wd+Ws9eCP3QjYuHoEqnb/QOwc=;
        b=ByFWe6ffwqwMSvx964Qe5UtrJCvpHdHD0Yw4tkyciPZXgPkBtSyvbKQ00AuJUDbqif
         NZQnYfS36DE1L3pXwFPAj/lbxwK+E2YotN31e6KuiaiDeSRtMQfjCGc//+/x3X77/3ou
         2vPvyoOkSFXA0eqVqvANKbDX57VHLT5325OTsEldX7pS91EgWU5neS5LVQWoL6J3W7Pc
         qz6JctF16ECbDOZRky+VBnZfxv2tAMxnfb8ueD9kIPFiIXAw9kUOQQbXVJjJh9F3EnZK
         tuJHuXx+2PE8Y9yBg6Vl0GOas5U+pSGsL9Z6wTzqt3Z6bz2MXJiczDIp6lse6NGu3cPQ
         Korw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741710491; x=1742315291;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oXkZmkekDF4erQW4L8Wd+Ws9eCP3QjYuHoEqnb/QOwc=;
        b=LanqjOBi483Z4RGN8/Q0yhlkYeviSkl6cUznjjDxTHdEL3SPkv2aeRg2rBnF3krdxs
         whwz+FzSfmFgcx51ehKlHCGU6BrVNGqFggUdH2gL/SheQvCl1ZNCJmQM3o/G5HtJroLL
         X6egXzxufz1t8dnLUFhJyVfS6GuoU76T4qKkvp0V4VtVZgeERz0pD6sumoUN+7OBQyyX
         bLaYQjcScJMMBfszGR6hUscksBqXyryiO76rGrYA2iPp8cOQXIVlDx5Cvmi1ipOGeRI0
         sEcpd3HWS0OPD3I4ca+UmGCPvGecS7M4EcAydYv77/DHbBZVqB+xtGNfRhZZwAjmuvei
         sBPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvlSn8+fSXNwBpgrpxevJ6UcQyEljIO6S9CwnQbk560q99CdQcRjfSjtibyRjFN0EWeipD+Ff3ci7x6IQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2GmzQaK0axRAeYpU9ql2HMY/oWawS57LoSFKh4zI7hW5XzxCk
	do3th2f7cSUPLwhPOc8HXj1QK+CGJgpymi5pG17qYSHD+g+DlfwiSy5sHut8C5PjQSOsulZqUkG
	cj/jmMkf/vMwfGPRPtHhIPkkcRsdSDvT7o5iToQ==
X-Gm-Gg: ASbGncvT9f2DJ3dhziVXGaHsDYFGuIMoXv8jxlLv765HulZpRcxFU7xkgW4U59llfhn
	RnjMZW6a5I+SNKlxcf0HHtNmYkRKwy5V2Lt/RhExJQ4VRGv4o9zo8d8Pos/coVQTJ8/DvA7Z9DR
	8fYYLhkp/CueXOPdiVXFmaR04AjW5BGaJ2K8RwVvY3Mzoc19XI9ApcFrA=
X-Google-Smtp-Source: AGHT+IEWSfqcPK1uijDUTErKoHYAH+v4oQz6W4wRySKk7OoakJWRIlXoPK6BMeqxiIkJ2EsXUZ6JiPn5r+7sbl8FGPE=
X-Received: by 2002:a17:906:cecb:b0:ac2:8118:27e7 with SMTP id
 a640c23a62f3a-ac2811831a3mr1555912566b.50.1741710490636; Tue, 11 Mar 2025
 09:28:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250302210539.1563190-1-vincent.guittot@linaro.org>
 <20250302210539.1563190-6-vincent.guittot@linaro.org> <0dabf19f-96be-4c55-a4bb-8325d288eacc@linux.ibm.com>
In-Reply-To: <0dabf19f-96be-4c55-a4bb-8325d288eacc@linux.ibm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 11 Mar 2025 17:27:59 +0100
X-Gm-Features: AQ5f1JrIKbdiJh3Sve9A94k3mPHFUfr2-C9L_EDsA9sYiJDhUq2ETJLYto2XwRI
Message-ID: <CAKfTPtD+aZwwDo7YP=xvdGBFLSLXEgHcWqmfF5Jo6TWhf4B7CQ@mail.gmail.com>
Subject: Re: [PATCH 5/7 v5] sched/fair: Add push task mechanism for EAS
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: qyousef@layalina.io, hongyan.xia2@arm.com, christian.loehle@arm.com, 
	luis.machado@arm.com, qperret@google.com, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	lukasz.luba@arm.com, rafael.j.wysocki@intel.com, pierre.gondois@arm.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Shrikanth,

On Mon, 10 Mar 2025 at 19:21, Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
>
>
> Hi Vincent, trying to understand this series. I see most of the places
> are with sched_energy_enabled() checks. So it shouldn't affect non-EAS
> systems.
>
> > EAS is based on wakeup events to efficiently place tasks on the system, but
> > there are cases where a task doesn't have wakeup events anymore or at a far
> > too low pace. For such situation, we can take advantage of the task being
> > put back in the enqueued list to check if it should be pushed on another
> > CPU. When the task is alone on the CPU, it's never put back in the enqueued
> > list; In this special case, we use the tick to run the check.
> >
> > Wake up events remain the main way to migrate tasks but we now detect
> > situation where a task is stuck on a CPU by checking that its utilization
> > is larger than the max available compute capacity (max cpu capacity or
> > uclamp max setting)
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >   kernel/sched/fair.c  | 220 +++++++++++++++++++++++++++++++++++++++++++
> >   kernel/sched/sched.h |   2 +
> >   2 files changed, 222 insertions(+)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index a9b97bbc085f..c3e383b86808 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7051,6 +7051,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >       hrtick_update(rq);
> >   }
> >
> > +static void fair_remove_pushable_task(struct rq *rq, struct task_struct *p);
> >   static void set_next_buddy(struct sched_entity *se);
> >
> >   /*
> > @@ -7081,6 +7082,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
> >               h_nr_idle = task_has_idle_policy(p);
> >               if (task_sleep || task_delayed || !se->sched_delayed)
> >                       h_nr_runnable = 1;
> > +
> > +             fair_remove_pushable_task(rq, p);
> >       } else {
> >               cfs_rq = group_cfs_rq(se);
> >               slice = cfs_rq_min_slice(cfs_rq);
> > @@ -8589,6 +8592,197 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >       return target;
> >   }
> >
> > +static inline bool task_stuck_on_cpu(struct task_struct *p, int cpu)
> > +{
> > +     unsigned long max_capa, util;
> > +
> > +     max_capa = min(get_actual_cpu_capacity(cpu),
> > +                    uclamp_eff_value(p, UCLAMP_MAX));
> > +     util = max(task_util_est(p), task_runnable(p));
> > +
> > +     /*
> > +      * Return true only if the task might not sleep/wakeup because of a low
> > +      * compute capacity. Tasks, which wake up regularly, will be handled by
> > +      * feec().
> > +      */
> > +     return (util > max_capa);
> > +}
> > +
> > +static inline bool sched_energy_push_task(struct task_struct *p, struct rq *rq)
> > +{
> > +     if (p->nr_cpus_allowed == 1)
> > +             return false;
> > +
> > +     if (is_rd_overutilized(rq->rd))
> > +             return false;
> > +
> > +     if (task_stuck_on_cpu(p, cpu_of(rq)))
> > +             return true;
> > +
> > +     return false;
> > +}
> > +
> > +static int active_load_balance_cpu_stop(void *data);
> > +
> > +static inline void check_pushable_task(struct task_struct *p, struct rq *rq)
> > +{
> > +     int new_cpu, cpu = cpu_of(rq);
> > +
> > +     if (!sched_energy_enabled())
> > +             return;
> > +
> > +     if (WARN_ON(!p))
> > +             return;
> > +
> > +     if (WARN_ON(!task_current(rq, p)))
> > +             return;
> > +
> > +     if (is_migration_disabled(p))
> > +             return;
> > +
> > +     /* If there are several task, wait for being put back */
> > +     if (rq->nr_running > 1)
> > +             return;
> > +
> > +     if (!sched_energy_push_task(p, rq))
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
>
> Does this need preempt disable/enable guards similar to sched_balance_rq?

Pierre asked me about this in the RFC version [1]. Preempt
enable/disable has been added by commit f0498d2a54e7 ("sched: Fix
stop_one_cpu_nowait() vs hotplug") and AFAIK we are safe with the use
case mentioned in the commit

[1] https://lore.kernel.org/lkml/ccf4095f-5fca-42f4-b9fe-aa93e703016e@arm.com/

>
> > +     raw_spin_rq_unlock(rq);
> > +     stop_one_cpu_nowait(cpu,
> > +             active_load_balance_cpu_stop, rq,
> > +             &rq->active_balance_work);
> > +     raw_spin_rq_lock(rq);
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
> > +     WARN_ON_ONCE(!task_on_rq_queued(p));
> > +
>
> Isnt it better to print it everytime? it could different process each
> time no?

This should never happen so once seems enough and it prevents
overloading the log.

>
> > +     /*
> > +      * Remove task from the pushable list as we try only once after that
> > +      * the task has been put back in enqueued list.
> > +      */
> > +     plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
> > +
> > +     return p;
> > +}
> > +
> > +/*
> > + * See if the non running fair tasks on this rq can be sent on other CPUs
> > + * that fits better with their profile.
> > + */
> > +static bool push_fair_task(struct rq *rq)
> > +{
> > +     struct task_struct *next_task;
> > +     int prev_cpu, new_cpu;
> > +     struct rq *new_rq;
> > +
> > +     next_task = pick_next_pushable_fair_task(rq);
> > +     if (!next_task)
> > +             return false;
> > +
> > +     if (is_migration_disabled(next_task))
> > +             return true;
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
> > +             /* The task has already migrated in between */
> > +             if (task_cpu(next_task) != rq->cpu) {
> > +                     double_unlock_balance(rq, new_rq);
> > +                     goto out;
> > +             }
> > +
> > +             deactivate_task(rq, next_task, 0);
> > +             set_task_cpu(next_task, new_cpu);
> > +             activate_task(new_rq, next_task, 0);
> > +
> > +             resched_curr(new_rq);
> > +
> > +             double_unlock_balance(rq, new_rq);
> > +     }
> > +
> > +out:
> > +     put_task_struct(next_task);
> > +
> > +     return true;
> > +}
> > +
> > +static void push_fair_tasks(struct rq *rq)
> > +{
> > +     /* push_fair_task() will return true if it moved a fair task */
> > +     while (push_fair_task(rq))
> > +             ;
> > +}
> > +
> > +static DEFINE_PER_CPU(struct balance_callback, fair_push_head);
> > +
> > +static inline void fair_queue_pushable_tasks(struct rq *rq)
> > +{
> > +     if (!sched_energy_enabled() || !has_pushable_tasks(rq))
> > +             return;
>
> has_pushable_task has any tasks iff sched_energy_enabled. so this check
> may not be needed. But it shouldnt hurt, since it is static key.

I didn't want to add the useless call of  has_pushable_tasks() even if
it should be cheap

>
> > +
> > +     queue_balance_callback(rq, &per_cpu(fair_push_head, rq->cpu), push_fair_tasks);
> > +}
> > +static void fair_remove_pushable_task(struct rq *rq, struct task_struct *p)
> > +{
> > +     if (sched_energy_enabled())
> > +             plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
> > +}
> > +
> > +static void fair_add_pushable_task(struct rq *rq, struct task_struct *p)
> > +{
> > +     if (sched_energy_enabled() && task_on_rq_queued(p) && !p->se.sched_delayed) {
> > +             if (sched_energy_push_task(p, rq)) {
> > +                     plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
> > +                     plist_node_init(&p->pushable_tasks, p->prio);
> > +                     plist_add(&p->pushable_tasks, &rq->cfs.pushable_tasks);
> > +             }
> > +     }
> > +}
> > +
> >   /*
> >    * select_task_rq_fair: Select target runqueue for the waking task in domains
> >    * that have the relevant SD flag set. In practice, this is SD_BALANCE_WAKE,
> > @@ -8758,6 +8952,10 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> >       return sched_balance_newidle(rq, rf) != 0;
> >   }
> >   #else
> > +static inline void check_pushable_task(struct task_struct *p, struct rq *rq) {}
> > +static inline void fair_queue_pushable_tasks(struct rq *rq) {}
> > +static void fair_remove_pushable_task(struct rq *rq, struct task_struct *p) {}
> > +static inline void fair_add_pushable_task(struct rq *rq, struct task_struct *p) {}
> >   static inline void set_task_max_allowed_capacity(struct task_struct *p) {}
> >   #endif /* CONFIG_SMP */
> >
> > @@ -8947,6 +9145,12 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
> >               put_prev_entity(cfs_rq, pse);
> >               set_next_entity(cfs_rq, se);
> >
> > +             /*
> > +              * The previous task might be eligible for being pushed on
> > +              * another cpu if it is still active.
> > +              */
> > +             fair_add_pushable_task(rq, prev);
> > +
> >               __set_next_task_fair(rq, p, true);
> >       }
> >
> > @@ -9019,6 +9223,13 @@ static void put_prev_task_fair(struct rq *rq, struct task_struct *prev, struct t
> >               cfs_rq = cfs_rq_of(se);
> >               put_prev_entity(cfs_rq, se);
> >       }
> > +
> > +     /*
> > +      * The previous task might be eligible for being pushed on another cpu
> > +      * if it is still active.
> > +      */
> > +     fair_add_pushable_task(rq, prev);
> > +
> >   }
> >
> >   /*
> > @@ -13151,6 +13362,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
> >       if (static_branch_unlikely(&sched_numa_balancing))
> >               task_tick_numa(rq, curr);
> >
> > +     check_pushable_task(curr, rq);
> >       update_misfit_status(curr, rq);
> >       check_update_overutilized_status(task_rq(curr));
> >
> > @@ -13303,6 +13515,8 @@ static void __set_next_task_fair(struct rq *rq, struct task_struct *p, bool firs
> >   {
> >       struct sched_entity *se = &p->se;
> >
> > +     fair_remove_pushable_task(rq, p);
> > +
> >   #ifdef CONFIG_SMP
> >       if (task_on_rq_queued(p)) {
> >               /*
> > @@ -13320,6 +13534,11 @@ static void __set_next_task_fair(struct rq *rq, struct task_struct *p, bool firs
> >       if (hrtick_enabled_fair(rq))
> >               hrtick_start_fair(rq, p);
> >
> > +     /*
> > +      * Try to push prev task before checking misfit for next task as
> > +      * the migration of prev can make next fitting the CPU
> > +      */
> > +     fair_queue_pushable_tasks(rq);
> >       update_misfit_status(p, rq);
> >       sched_fair_update_stop_tick(rq, p);
> >   }
> > @@ -13350,6 +13569,7 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
> >       cfs_rq->tasks_timeline = RB_ROOT_CACHED;
> >       cfs_rq->min_vruntime = (u64)(-(1LL << 20));
> >   #ifdef CONFIG_SMP
> > +     plist_head_init(&cfs_rq->pushable_tasks);
> >       raw_spin_lock_init(&cfs_rq->removed.lock);
> >   #endif
> >   }
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index ab16d3d0e51c..2db198dccf21 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -722,6 +722,8 @@ struct cfs_rq {
> >       struct list_head        leaf_cfs_rq_list;
> >       struct task_group       *tg;    /* group that "owns" this runqueue */
> >
> > +     struct plist_head       pushable_tasks;
> > +
> >       /* Locally cached copy of our task_group's idle value */
> >       int                     idle;
> >
>

