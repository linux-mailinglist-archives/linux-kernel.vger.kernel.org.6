Return-Path: <linux-kernel+bounces-561787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF5AA61635
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B795188294D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE31A18B494;
	Fri, 14 Mar 2025 16:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LPck+Ymy"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3726B2E3362
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741969509; cv=none; b=pkZKlK6Re1PsKfgvPqqeQ3uymtrY6A3bNnYlrNokau0kQ516NpN6q3pcObBsdyfgfAVvGElUO5/VCaI3MOADN+v86oupI2OzZKgLPQCU9eeszbcGjzCGzmpjm2U6BYu+bVA7LRuIgpcvwxHolozdDCCJ8LRK7VeQDIHPewfUieE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741969509; c=relaxed/simple;
	bh=0TtYOEAsABJQJrAfQKpybnT0H+a0G8O6hrnbw78aT4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NVkrfP02Q2mdcLvTHkunERs/iad2VsgTGuaiPstzXME3Ir6chJiYZxZFCfmsZfv2JrD1VQG8DbYph23zBP13z44BpnbVPCmuD6sDQ3kV/XwYmVZ0H5/r+/0HGQFITYtDF/IPZvSEohRXTthE63A/iOOCFi7xArCDZWA8MbUCwbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LPck+Ymy; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac2a9a74d9cso470824066b.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741969505; x=1742574305; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dsimnS5JfrzuySOmTnCZSejdr1ZQbpEUItt/bOPsELs=;
        b=LPck+YmyAPl0ZxwviI4YpoomzYXmPvn8Cz90ZvPUrrVI2v/Uv22j/WDPcJHyCQP0+e
         4l8tZwFUVhLAWNGjZiGiMuKT2e+3CD/UvNGcahoXJEHHq4bkPMEoxfxsnuvm4rYnENME
         wOF0UPHQepHSSp1GdBIV562huKfAVh5pMNBUTWLOY8hfLd3cdzCRP2fx3givqnsRos0D
         BuQL+lnQGQeGi17+PMs5JgxvT+5XBkBc1WUe1Sk/VJF3nFtXDJ4xBQtPHKol3qrUATs8
         /qzq+iN9lWAtm+LWWd0vaiWkzgp+KfOlS1eaB3rcQTSHvpDk/Sh3bPED3u3I+z17+0PR
         BBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741969505; x=1742574305;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dsimnS5JfrzuySOmTnCZSejdr1ZQbpEUItt/bOPsELs=;
        b=xI4HW9LI/N0OxQD5PYW/FDF62hxcXxEl3BTG1wP/NK/A0iC17jYNaU1jFxBhbzAh01
         pKxFtXKTp1f/+M+vjVNrrxtxP8JxR8JlGwOm7dNtT+3I4KBafpdHf/GWru45JYmSg3nh
         ajYK5u47nlW7Uc0xFU6cSgQE6YIq0/ZP2mQWjZ6UehR4NzSwN/kGq1W+UYPDWxxQKUHL
         DrKYGFJRFFYXmI5OfPKfYeo2M1JTWKL2nt5KP7RC7aGwj4DtyOX0+jzA4bE1WOduIBXJ
         C1tKAye4aQU5eqbs1E7qcjWQ/17CzKdd4d1phRpVG6hQotAzoIQN3G3nDN0l+A6kj40K
         AjDA==
X-Forwarded-Encrypted: i=1; AJvYcCUqE1zkR+sEH+MsNWZfmwVaL0TiNcZWonzNCEMR1HMNSwSUmx8nt4IFrQHNqewlXpgQ4aW3FPgRcU5i7hM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIFYct3S5I6dYJdaOKuf2p6G7h46EagaOD2S9D8ovfVSVJtSKP
	OYUeiYlBVrE6yEGOTw5g80xY8J0YrUEq+G3wWYam0yIYcNqSbKBV4BIG9Xr8GnTfx47YFntWGGB
	G2KTtLgreRl5RSm2vdHZz6YPFAp9ZyO8xlgKXyw==
X-Gm-Gg: ASbGncuwC2I7N8OGV3PmhE3KmKPQMJUBbwqOTNtFV522sWhbK7c3KaOHLOiwVMN4PQp
	roc6PchulAhG8Q/xXQya3Skz3wE/4fhCngUjdcclM8a6sGDXnZ0nXuHIhLdlAzfTVW40FNv7MRo
	DJnwEPNN1FeStsjOhY1rqCRBWkQ8OO37zDWJmaAriNg2zZx4sKj0eKJQ==
X-Google-Smtp-Source: AGHT+IGYGp5PC8W9a6Wtu+VM0bgbZNW6H2oHNscFU2Uc9CI6+ewvthG/0BcMabXT74Q7sjc+ug9/3kjErgehTo6VUE0=
X-Received: by 2002:a17:906:4795:b0:abf:4d27:bddd with SMTP id
 a640c23a62f3a-ac3301e8e0bmr348183566b.26.1741969505174; Fri, 14 Mar 2025
 09:25:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250302210539.1563190-1-vincent.guittot@linaro.org>
 <20250302210539.1563190-4-vincent.guittot@linaro.org> <24bc804e-305f-4273-922a-a24070aa3e56@arm.com>
In-Reply-To: <24bc804e-305f-4273-922a-a24070aa3e56@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 14 Mar 2025 17:24:53 +0100
X-Gm-Features: AQ5f1Jooofq_eNdS6_8RZQkZoFnvnqCvSPJb9HBEYm1IAuJ1jqnXdZQfx7idBok
Message-ID: <CAKfTPtBO_DYM+HK+wWMvunMzDAzHwYghy4ae7GnyQHRe1A8kZg@mail.gmail.com>
Subject: Re: [PATCH 3/7 v5] sched/fair: Rework feec() to use cost instead of
 spare capacity
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, lukasz.luba@arm.com, 
	rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, qyousef@layalina.io, 
	hongyan.xia2@arm.com, christian.loehle@arm.com, luis.machado@arm.com, 
	qperret@google.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Mar 2025 at 15:09, Pierre Gondois <pierre.gondois@arm.com> wrote:
>
> Hello Vincent,
>
> On 3/2/25 22:05, Vincent Guittot wrote:
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
> > performant CPU between CPUs. The cost of the OPP remains the only
> > comparison criteria between Performance Domains.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >   kernel/sched/fair.c | 466 +++++++++++++++++++++++---------------------
> >   1 file changed, 246 insertions(+), 220 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index d3d1a2ba6b1a..a9b97bbc085f 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
>
> [...]
>
> > +static bool update_best_cpu(struct energy_cpu_stat *target,
> > +                         struct energy_cpu_stat *min,
> > +                         int prev, struct sched_domain *sd)
> >   {
> > -     unsigned long max_util = eenv_pd_max_util(eenv, pd_cpus, p, dst_cpu);
> > -     unsigned long busy_time = eenv->pd_busy_time;
> > -     unsigned long energy;
> > -
> > -     if (dst_cpu >= 0)
> > -             busy_time = min(eenv->pd_cap, busy_time + eenv->task_busy_time);
> > +     /*  Select the one with the least number of running tasks */
> > +     if (target->nr_running < min->nr_running)
> > +             return true;
> > +     if (target->nr_running > min->nr_running)
> > +             return false;
> >
> > -     energy = em_cpu_energy(pd->em_pd, max_util, busy_time, eenv->cpu_cap);
> > +     /* Favor previous CPU otherwise */
> > +     if (target->cpu == prev)
> > +             return true;
> > +     if (min->cpu == prev)
> > +             return false;
> >
> > -     trace_sched_compute_energy_tp(p, dst_cpu, energy, max_util, busy_time);
> > +     /*
> > +      * Choose CPU with lowest contention. One might want to consider load
> > +      * instead of runnable but we are supposed to not be overutilized so
> > +      * there is enough compute capacity for everybody.
> > +      */
>
> I'm not sure I understand the comment. With UCLAMP_MAX tasks, a CPU can lack
> compute capacity while not being tagged as overutilized. IIUC this is actually
> the goal of UCLAMP_MAX.

the uclamp_max says that the task doesn't need more than a compute
capacity of 1 so there is no lack

>
> With the following workload:
> - 2 tasks A with duty_cycle=30%, UCLAMP_MIN/MAX=(0,1), niceness=0
> - 2 tasks B with duty_cycle=70%, UCLAMP_MIN/MAX=(0,1), niceness=-10

Does the duty cycle make any difference here ? they won't be able to
run 30% or 70% anyway because of their uclamp_max, will they ?

> The workload runs on a Pixel6 with a reduced cpuset of [1,2,7], i.e. 2 little
> CPUs (1,2) capa=160 and one big CPU (7) capa=1024.
> CPU7 is avoided by the tasks as their UCLAMP_MAX setting make them fit on the
> little CPUs.
>
> select_best_cpu() prefers to place tasks based on nr_running. If the 2 tasks A
> end up being placed on one little CPU, and the 2 tasks B are placed on the
> other little CPU, feec() is theoretically unable to balance the workload.

They will all have 80 compute capacity which is more than their uclamp_max= 1

> In practice, a kworker ends up spawning on one of these 2 little CPUs and tasks
> are shuffled, so the pattern breaks after ~30ms.
>
> This pattern seems problematic as tasks A are:
> - smaller (30% < 70%)
> - nicer (0 > -10)
> than tasks B. So I assume the correct task placement should be one task of each
> type on each little CPU.
>
> ------
>
> There are some comments in the load balancer code:
> 1.
> /* Computing avg_load makes sense only when group is overloaded */
> 2.
> /*
> * Computing avg_load makes sense only when group is fully busy or
> * overloaded
> */
>
> IIUC, the load is only meaningful when there is not enough compute capacity
> to estimate the task size, otherwise util_avg makes more sense. It seems that
> when it comes to UCLAMP_MAX task, CPUs are placed in this exact situation:
> load_avg makes more sense that util_avg.
> However, in this situation, energy computations also lose sense since they
> are based on the util_avg values.
>
> ------
>
> select_best_cpu() could check the CPU load before checking nr_running, but it
> would be meaningless if there is enough CPU time for all the tasks.
>
> Maybe CPU load should then be checked only if the system doesn't have enough
> CPU time. But this would be equivalent to:
> - remove UCLAMP_MAX in cpu_overutilized()
> - when the system is overutilized (no UCLAMP_MAX involved), go back to the
>    load balancer
>
> In other words, I don't really see how it is possible to reconciliate UCLAMP_MAX
> tasks with EAS as EAS relies on util_avg values, and UCLAMP_MAX forces to
> rely on load_avg value rather than util_avg.
>
> Regards,
> Pierre
>
>
> > +     if ((target->runnable * min->capa * sd->imbalance_pct) >=
> > +                     (min->runnable * target->capa * 100))
> > +             return false;
> >
> > -     return energy;
> > +     return true;
> >   }

