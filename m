Return-Path: <linux-kernel+bounces-318309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8B896EB98
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 406CA1F239D0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 07:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358D114A0B9;
	Fri,  6 Sep 2024 07:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dJc0tQUR"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1E7139D03
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 07:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725606495; cv=none; b=gjx8UBP5hai8CMFEUERWZuFllqeUUkNUuRURPsnfkylc0RMUzyjQPe+KylGcBSA457fXt6xPn6fegW3pwF1M5A0MYkCdlL11W5YuHiGKwfEiCENyvc0zD2EThOy2fQbE+vG+asyFLMLgtYBa7VILnZrfIpni4eIW6THMXzS5Hs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725606495; c=relaxed/simple;
	bh=TtVwqE6C81GJvfzJXzeunNjMoqfcJjYtTIDFAzgXKpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CRm4ggCBpzzAIntmkXfYvHChkR8rDcAQv9A9mF/qkcFMPydOG7JGqI438IPDk8ncAWCATIv37Obp19/OF1vSXhfGBO9YF7/+Fq/MgJvcuhJEKj6MkW5T2gVxRf2abEtfWtoKlZGFOQ4rID00pA+YUFvjZ3iZh6p/7BTxH3/xHxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dJc0tQUR; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-70b2421471aso1200391a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 00:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725606493; x=1726211293; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=juLkBwE5q7gzlT2gJlWdyMIZ0hSw1TLpzrJv+a0hqcg=;
        b=dJc0tQURnz6iDX8mtd/QUlmvUFdEuN/xI8NUPeQOFy/tTcBd1V38EwK3GTO+oEAZFf
         wtrzTmu2sE/T2QWQQu7nUJ63q0qmO7YoL5A0aBGbOhcfIK9riJ+f/ErXW6puBuOPJi/a
         6ivmYdggnHiSBhCxKyltO9NZyvPld+lW9E/4fRh/HddUfLGSTKMGJ6r7HPh+UKGXL2yZ
         DOLwOkDoFH3Y9V/9LuQm41R7fohl4Vec/m80KOprgzpGpw7vJV26KvkxIRbQEZEDB7E0
         Fs0G3R9Hz49tC0mt79BHCDXd6TaZUiPVNmxUqg00Z46l4fnoMdnI3PjjE01i6g6WfDSv
         PspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725606493; x=1726211293;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=juLkBwE5q7gzlT2gJlWdyMIZ0hSw1TLpzrJv+a0hqcg=;
        b=OYPq0FPaulGtD/oPh4Uan+DYBLXC1YJHWCWs50Zs2xtTEEJJhA2deXr+yWOJRedJjl
         9im8y4P89lHpn8glKcLIEtWj+NX2GN+oVnMUuolj1QQcqRER/O0ZehB4WIIrAqifWPMA
         QQk/1VLkKe5J0mC9vqmggJRay/TA2bZW5TcaNRBmI5RSIb6bbOIadSCG2qNrnLHQXSZX
         Qs5AFH/Gpszk1fIeb0AgL036xQNBULdJ6rZ2jcX6ZSEMLJRe0d5pehEmBwXTELnMJktQ
         PhJhYpZU6IROpeTrk5AD5ea0JjMyZjImw/lpwHySwMiBqAdygns/c9oZP2DefVrltDOy
         9c7A==
X-Gm-Message-State: AOJu0YzOdKAIC5nhsHAydNNUZ7L6+8uHLGdNgS6lzpyjtEhDnbOAo0Te
	164nSUyf271JbJTCD0tSRu5BzcEpla/0VpIKa9ommiuN+VNY0vp0yBAzdY01iiMkbPpiudzQtpv
	Pn2UrV8SEDnamPjapaI8uZSaKMxFJiw2C4D0AaQ==
X-Google-Smtp-Source: AGHT+IEJEDIqjcqACA37sP1rf2EqPJmGgXUSqj/f1LvRd45ratmeO84wKApXNc6P+Ym1PPzXmPDWbAi5M5BYLwXShV0=
X-Received: by 2002:a05:6a21:3401:b0:1ce:d13d:5e62 with SMTP id
 adf61e73a8af0-1cf1d130fa1mr1447174637.27.1725606492703; Fri, 06 Sep 2024
 00:08:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
 <20240830130309.2141697-4-vincent.guittot@linaro.org> <066b7de8-0854-424b-8888-b18fc61ec21c@arm.com>
In-Reply-To: <066b7de8-0854-424b-8888-b18fc61ec21c@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 6 Sep 2024 09:08:01 +0200
Message-ID: <CAKfTPtAX22QPPfA1smH9eOWpqBzXZ=enUOAE8zscEFY9wBbkZQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] sched/fair: Rework feec() to use cost instead of
 spare capacity
To: Hongyan Xia <hongyan.xia2@arm.com>
Cc: linux-kernel@vger.kernel.org, qyousef@layalina.io, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, vschneid@redhat.com, 
	lukasz.luba@arm.com, mgorman@suse.de, rafael.j.wysocki@intel.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Sept 2024 at 13:03, Hongyan Xia <hongyan.xia2@arm.com> wrote:
>
> On 30/08/2024 14:03, Vincent Guittot wrote:
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
> > [...]
> >
> > -     energy = em_cpu_energy(pd->em_pd, max_util, busy_time, eenv->cpu_cap);
> > +/* For a same cost, select the CPU that will povide best performance for the task */
> > +static bool select_best_cpu(struct energy_cpu_stat *target,
> > +                         struct energy_cpu_stat *min,
> > +                         int prev, struct sched_domain *sd)
> > +{
> > +     /*  Select the one with the least number of running tasks */
> > +     if (target->nr_running < min->nr_running)
> > +             return true;
> > +     if (target->nr_running > min->nr_running)
> > +             return false;
> >
> This makes me a bit worried about systems with coarse-grained OPPs. All
> my dev boards and one of my old phones have <= 3 OPPs. On my Juno board,
> the lowest OPP on the big core spans across 512 utilization, half of the
> full capacity. Assuming a scenario where there are 4 tasks, each with
> 300, 100, 100, 100 utilization, the placement should be 300 on one core
> and 3 tasks with 100 on another, but the nr_running check here would
> give 2 tasks (300 + 100) on one CPU and 2 tasks (100 + 100) on another
> because they are still under the lowest OPP on Juno. The second CPU will
> also finish faster and idle more than the first one.

By balancing the number of tasks on each cpu, I try to minimize the
scheduling latency. In your case above, tasks will wait for no more
than a slice before running whereas it might have to wait up to 2
slices if I put all the (100 utilization) tasks on the same CPU.

>
> To give an extreme example, assuming the system has only one OPP (such a
> system is dumb to begin with, but just to make a point), before this
> patch EAS would still work okay in task placement, but after this patch,

Not sure what you mean by would still work okay. Do you have an
example in mind that would not work correctly ?

> EAS would just balance on the number of tasks, regardless of utilization
> of tasks on wake-up.

You have to keep in mind that utilization is already taken into
account to check if the task fits the CPU and by selecting the OPP
(which is a nope in case of one OPP). So we know that there is enough
capacity for the waking task

>
> I wonder if there is a way to still take total utilization as a factor.

utilization is still used to check that the task utilization fits with
current cpu utilization and then to select the OPP. At this step we
know that there is enough capacity for everybody

> It used to be 100% of the decision making, but maybe now it is only 60%,
> and the other 40% are things like number of tasks and contention.
>
> > -     trace_sched_compute_energy_tp(p, dst_cpu, energy, max_util, busy_time);
> > +     /* Favor previous CPU otherwise */
> > +     if (target->cpu == prev)
> > +             return true;
> > +     if (min->cpu == prev)
> > +             return false;
> >
> > -     return energy;
> > +     /*
> > +      * Choose CPU with lowest contention. One might want to consider load instead of
> > +      * runnable but we are supposed to not be overutilized so there is enough compute
> > +      * capacity for everybody.
> > +      */
> > +     if ((target->runnable * min->capa * sd->imbalance_pct) >=
> > +                     (min->runnable * target->capa * 100))
> > +             return false;
> > +
> > +     return true;
> >   }
> > [...]
>

