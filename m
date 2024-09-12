Return-Path: <linux-kernel+bounces-326492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E26976909
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BDB01C234DB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 12:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8671A3039;
	Thu, 12 Sep 2024 12:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ToH2HX92"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF001A304C
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 12:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726143774; cv=none; b=AI2FKW5QsNkFdw0xX5iKas8LIF9+9kj58vHtqHxicFWCd9C1M7AE3Gyv0+uzCiNTvdYEx6Rp89+oiNgpCdVzyf/fIRCX7SPswjo9bQtwzWSD16bcbU7K/2yZp2QhkCt1wLAF+WIDdR6WjaDhNCtOTVER0fxEKBvzCjuTS3v8rcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726143774; c=relaxed/simple;
	bh=2aw+LkFOZZF6DWLRcMoUTrSP14lZjCMA6rFT/XYG9l0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R+LD47ll1DZ0VOOqt2aIqVmAH4Zeo9UUNcmiqHhG3tiJis0IiKZ6oNEuWiDQL2otmdd7I0SzLOJhLD5G6CxrrygWQ4GvM1nT3inO9CRwzyE4Sunaefe/Ip3AsHnZq6SAHykVnyyEwGGW/iuMiy10mskZVVxsUJRpZh6WtyZkr08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ToH2HX92; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d86f71353dso640935a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 05:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726143772; x=1726748572; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xi1Q30Sbe+IgUvqBaAMh1o9/ruuD/5ypFDsRozNBL0w=;
        b=ToH2HX92VccnJNqBQImPS37bRP4JYy+WgYuSz2DWWYRJISXmdxizUBY5TdAzTqHR4L
         5YnuDtGn3WeQ+JaFWdqc1c9EKVNMOPHk3rOGaJzgVY9gAxRdLV4Ol4e2YeygZtjq7FMr
         D6yktaLTPlV0OiXvkdnHZXstu40cBpxysOmDm6LhfcVIC7WYrMA7HCHjczrgamaUE4S5
         VBS2HvzlCc8p9bUZcR3Ye5km/9nhdoQ+CC6ztikEfXI7m2YA06oo7AeGM94QPo03qbZu
         3bbxASYEvCLrznSkyrhG1ZehbJsoEh8i9d071cmu8UE9dbdQEg46S9/FUUkq2wErzufy
         h8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726143772; x=1726748572;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xi1Q30Sbe+IgUvqBaAMh1o9/ruuD/5ypFDsRozNBL0w=;
        b=m3VtAW8BMS7Bg6/Dhw/pI/DfoZkHNOeHTpCmFJmq8NCUiXQwbjZMSbwZHOZ37sIy8F
         Kmx7OrnfDO+XPJVNaKkCtx4GG3aPztefy1fK7ifUmVTGZUkvP73JaaQnWTsRC/32e/8x
         ix+2fliCFtMskO0MnOsrcKHwctW+n9BlBGLOpYR4AFpQz4EghJTJH5hHmZ+LkyobryAu
         FZgVNTH4Cb2VLlM/G9Mu/rdOQf3mOWN9/v/5CssFrGjdwxiAXFL9Nt/2cWdkMr3TLJ5I
         jfB7Q/KLiyNnGf5wkWjgETXbG4JlmzXPjgmIzVumeQ715q65nIYWMbXb0sUi7MDDuxsC
         w97g==
X-Forwarded-Encrypted: i=1; AJvYcCVspW1jqrpwIr+g9CZ8TUdN00IUFjcjUzi9KbVVqLPNrhKUODeeIXKNwGB70OjDUkrqTcgCYzvAsbvrwmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAUxEuaId8ecMkdDcY7kSRiUDn9ywHjYDsNDMXaQvRRcqnZvYk
	zcncrtxJMGZhGBo8kbDnZ5NjcsS2PbCCd8zAlYHlJLjZo5N+yxvPAqNsxllSwq5zivm7nLRjslE
	9gZZ2kW0ERi6DOi3K9Uw2Cq3235vtxZArLPk81w==
X-Google-Smtp-Source: AGHT+IHwDMbs6fOyDAS56jV5Ld3LHjSQBuab0X5m1tCMLhY6+Vu5CHTht/TUt0sw5aOcpMT1cmeRK1BOL6+/MYiEapo=
X-Received: by 2002:a17:90b:1c0a:b0:2d8:f11e:f7e with SMTP id
 98e67ed59e1d1-2db9ff93003mr2385944a91.12.1726143771253; Thu, 12 Sep 2024
 05:22:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
 <20240830130309.2141697-4-vincent.guittot@linaro.org> <52274486-b385-4080-9938-399d601fe892@arm.com>
In-Reply-To: <52274486-b385-4080-9938-399d601fe892@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 12 Sep 2024 14:22:40 +0200
Message-ID: <CAKfTPtD3skwkhRUNOnfheK+bUxYgXvPQT-RWT_SQ+C3uK4kS8w@mail.gmail.com>
Subject: Re: [PATCH 3/5] sched/fair: Rework feec() to use cost instead of
 spare capacity
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, lukasz.luba@arm.com, 
	rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, qyousef@layalina.io, 
	hongyan.xia2@arm.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Sept 2024 at 16:03, Pierre Gondois <pierre.gondois@arm.com> wrote:
>
> Hello Vincent,
>
> On 8/30/24 15:03, Vincent Guittot wrote:
> > feec() looks for the CPU with highest spare capacity in a PD assuming that
> > it will be the best CPU from a energy efficiency PoV because it will
> > require the smallest increase of OPP. Although this is true generally
> > speaking, this policy also filters some others CPUs which will be as
> > efficients because of using the same OPP.
> > In fact, we really care about the cost of the new OPP that will be
> > selected to handle the waking task. In many cases, several CPUs will end
> > up selecting the same OPP and as a result using the same energy cost. In
> > these cases, we can use other metrics to select the best CPU for the same
> > energy cost.
> >
> > Rework feec() to look 1st for the lowest cost in a PD and then the most
> > performant CPU between CPUs.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >   kernel/sched/fair.c | 466 +++++++++++++++++++++++---------------------
> >   1 file changed, 244 insertions(+), 222 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index e67d6029b269..2273eecf6086 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
>
> [snip]
>
> >
> > -/*
> > - * compute_energy(): Use the Energy Model to estimate the energy that @pd would
> > - * consume for a given utilization landscape @eenv. When @dst_cpu < 0, the task
> > - * contribution is ignored.
> > - */
> > -static inline unsigned long
> > -compute_energy(struct energy_env *eenv, struct perf_domain *pd,
> > -            struct cpumask *pd_cpus, struct task_struct *p, int dst_cpu)
> > +/*Check if the CPU can handle the waking task */
> > +static int check_cpu_with_task(struct task_struct *p, int cpu)
> >   {
> > -     unsigned long max_util = eenv_pd_max_util(eenv, pd_cpus, p, dst_cpu);
> > -     unsigned long busy_time = eenv->pd_busy_time;
> > -     unsigned long energy;
> > +     unsigned long p_util_min = uclamp_is_used() ? uclamp_eff_value(p, UCLAMP_MIN) : 0;
> > +     unsigned long p_util_max = uclamp_is_used() ? uclamp_eff_value(p, UCLAMP_MAX) : 1024;
> > +     unsigned long util_min = p_util_min;
> > +     unsigned long util_max = p_util_max;
> > +     unsigned long util = cpu_util(cpu, p, cpu, 0);
> > +     struct rq *rq = cpu_rq(cpu);
> >
> > -     if (dst_cpu >= 0)
> > -             busy_time = min(eenv->pd_cap, busy_time + eenv->task_busy_time);
>
> I think you should mention that the energy computation is not capped anymore.
> It used to be:
> pd_util: sum of the CPU's util for the pd considered, without task_util
> pd_cap: sum of the CPU's capacity for the pd
>
> (a)
> busy_time = min(pd_cap, pd_util);
> prev_energy = busy_time * OPP[prev_max_util].cost;
>
> busy_time = min(pd_cap, pd_util + task_util);
> new_energy = busy_time * OPP[new_max_util].cost;
>
> delta_energy = new_energy - prev_energy;
>
> Note that when computing busy_time, task_util is not capped to one CPU's
> max_cap. This means that in empty pd, a task can 'steal' capacity from
> CPUs during the energy computation.
> Cf. [1]
>
> and it is now:
> (b)
> delta_energy = task_util * OPP[new_max_util].cost;
> delta_energy += pd_util * (OPP[new_max_util].cost - OPP[prev_max_util].cost);
>
> Note that the busy_time (task_util + pd_util) is now not capped by anything.

As discussed in [1], capping utilization with max capacity is a
mistake because we lost  the information that this will run longer

>
> ---
>
> Not capping the task_util is discussed in [1][3] and [2] (at 21:15).
> IIUC, UCLAMP_MAX tasks are the only case leveraging this. Indeed,
> non-clamped tasks will not fit and be placed on a bigger CPU. Same for
> UCLAMP_MIN tasks.
> FWIU, not capping the utilization of tasks during the energy computation
> allows to reflect that a task will (likely) run longer. However the
> task's performance would likely decrease as the other tasks on the target
> CPU are not taken into account (it is assumed the task to be placed will
> receive the compute power it requires).
>
> ---
> Case A:
>
> Assuming we have an empty system with:
> - 4 little CPUs (max_capa=512, first OPP as [capa=256, cost=10])
> - 2 big CPUs (max_capa=1024, first OPP as [capa=512, cost=10])

Quite an inefficient hardware design here where the big core provides
twice more capacity for the same cost of the little for their 1st OPP
!!!

> i.e. the first OPP of all the CPU consumes the same amount of energy.
> And a task with: [UCLAMP_MIN=0, UCLAMP_MAX=10, util = 1000]
>
> Then feec() would have no reason to prefer a big CPU over a little CPU,
> even though the big CPU would provide more performance.

As mentioned in the comment of feec(), I don't expect to face a
situation where the delta energy is equal for 2 PDs especially with
the uWatt that has been introduced to prevent such situation. But if
this should happen, it is in the TODO to add margin and to take other
stats into account like compute capacity. Also, the PDs are sorted by
max capacity so we currently keep the one with highest capacity ie big
CPU in your case

>
> ---
> Case B:
>
> (This is not especially related to this patch.)
> Another case that might be problematic:
> - 4 little CPUs (max_capa=512, first OPP as [capa=256])
> - 2 big CPUs (max_capa=1024, first OPP as [capa=512])
> - little CPUs consume less than big CPUs, but the highest OPP
>    of the little CPUs consume more than the lowest of the big CPUs.
> And tasks:
> - 3 tasks with [UCLAMP_MIN=0, UCLAMP_MAX=10, util = 1000]
> - 1 task with [UCLAMP_MIN=0, UCLAMP_MAX=1024, util = 50]
>
> Then
> - the 3 UCLAMP_MAX tasks will be placed on the little CPUs. Indeed,
>    due to the last patch of the serie, these tasks have now an opportunity
>    to run feec() and be placed on a more energy efficient CPU.
> - the 'normal' task will be placed on a big CPU. Indeed, placing
>    it on a little CPU would raise the OPP of the little cluster.
>
> This means that the 'normal' task is prevented to run the remaining little
> CPU even though:
> - the little CPU can provide the compute capacity
> - the little CPU would consume less energy
>
> In other terms, using UCLAMP_MAX on some tasks makes the system consume
> more energy.

You have probably noticed that this patchset doesn't make any
assumption about uclamp_max/min behavior and the below doesn't seem to
be related to this patchset but to the uclamp_max behavior so I don't
think it's the right place to discuss this. A talk or a BoF at LPC
would have been a better place

>
> ---
>
> In my opinion, this last case comes from the difficulty of defining UCLAMP_MAX.
>  From sched-util-clamp.rst (about UCLAMP_MAX):
> - Uclamp is a hinting mechanism that allows the scheduler to understand the
>    performance requirements and restrictions of the tasks
> - The right way to view util clamp is as a mechanism to make request or hint on
>    performance constraints.
> - some tasks should be restricted from consuming too
>    much resources and should not go above a specific performance point.
> -
> Another example is in Android where tasks are classified as background,
> foreground, top-app, etc. Util clamp can be used to constrain how much
> resources background tasks are consuming by capping the performance point they
> can run at. This constraint helps reserve resources for important tasks, like
> the ones belonging to the currently active app (top-app group). Beside this
> helps in limiting how much power they consume. This can be more obvious in
> heterogeneous systems (e.g. Arm big.LITTLE); the constraint will help bias the
> background tasks to stay on the little cores which will ensure that:
>
>          1. The big cores are free to run top-app tasks immediately. top-app
>             tasks are the tasks the user is currently interacting with, hence
>             the most important tasks in the system.
>          2. They don't run on a power hungry core and drain battery even if they
>             are CPU intensive tasks.
> -
> For example, it can be handy to limit performance when running low on battery
> or when the system wants to limit access to more energy hungry performance
> levels when it's in idle state or screen is off.
>
> """
> This constraint helps reserve resources for important tasks, like
> the ones belonging to the currently active app (top-app group).
> """
> It doesn't seem that UCLAMP_MAX does this. This looks more like bandwidth
> control.
>
> """
> They don't run on a power hungry core and drain battery even if they
> are CPU intensive tasks.
> """
> Avoiding mid/big CPUs could be done with tasksets,
>
> I can understand that one might want to run a task at a higher OPP due to
> timing constraints for instance. However I don't see why someone would want
> to run a task at a lower OPP, regarding only the performance and not the
> energy consumption. It thus means that UCLAMP_MAX is an energy hint rather
> of a performance hint.
>
> UCLAMP_MAX could be set for a task to make it spend less energy, but the
> loss in performance would be unknown.
> A case Hongyan mentioned in his uclamp sum aggregation serie [4] is that
> an infinite task with [UCLAMP_MIN=0, UCLAMP_MAX=1, util = 1000] could fit
> in a little CPU. The energy consumption would indeed be very low, but the
> performance would also be very low.
>
> With Hongyan's sum aggregation serie [5]:
> - case B would not happen as the 'normal' task would not raise the OPP of
>    the whole cluster.
> - the 'infinite UCLAMP_MAX tasks' case would not happen as each task would
>    account for 1 util
> - case A would still happen, but could be solved in any case.
>
> I know Hongyan's patchset has already been discussed, but I still don't
> understand why max aggregation is preferred over sum aggregation.
> The definition of UCLAMP_MAX values seems clearer and in effect results in
> a simpler implementation and less corner cases. In simple words:
> "When estimating the CPU frequency to set, for this task,
> account for at most X util."
> rather than:
> "When estimating the CPU frequency to set, the task with the highest
> UCLAMP_MAX of the CPU will cap the requested frequency."
>
> Note that actually I think it's a good idea to run feec() regularly
> and to take into account other parameters like nr_running. I just think
> that UCLAMP_MAX's max aggregation creates corner cases that are difficult
> to solve altogether.
>
> Thanks in advance for the time you will take answering,
> Regards,
> Pierre
>
> [1] https://lore.kernel.org/all/20240606070645.3295-1-xuewen.yan@unisoc.com/
> [2] https://www.youtube.com/watch?v=PHEBAyxeM_M
> [3] https://lore.kernel.org/all/CAKfTPtDPCPYvCi1c_Nh+Cn01ZVS7E=tAHQeNX-mArBt3BXdjYw@mail.gmail.com/
> [4] https://lore.kernel.org/all/b81a5b1c-14de-4232-bee9-ee647355dd8c@arm.com/
> [5] https://lore.kernel.org/all/cover.1706792708.git.hongyan.xia2@arm.com/#t

