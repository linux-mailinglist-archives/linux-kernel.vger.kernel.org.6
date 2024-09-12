Return-Path: <linux-kernel+bounces-326473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C21409768C7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E4431F28A5F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 12:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE1B1A262B;
	Thu, 12 Sep 2024 12:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L1czOMYF"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBC32C6BB
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 12:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726143137; cv=none; b=hsI3kOPM53uSKAsxzMUSVNEKYoTCOeGvxYrZnsapV4vMkARgSV8Gk/dH6bf7lPQQUVC9vku4Oxkq/vWuh8Av6vw8KAZbuLDdsIxL+eTQ3fYySWwoP8aJlMtTsLKzLsEmW9WAA7X2zaVVaLSyv86KNLayMSCgKYhi1s/BBOsK3T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726143137; c=relaxed/simple;
	bh=jG5hLEP5lR1ltdMONz2p+5dLpDZNiNRpVUM/wNTpS2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sEEbygHJ13YXjKfFVcrsupYZg/hzkIwT7r43YrvET4kYrKYMR05IND+UkG94yZ7fLezbPkZj+pubqXEP0aWcTXDULuN+UqM/OTzRKp1J+bOigEASeZCs2OggugwEks0L8X7Vb4IlqFbyJvoWzt/UD3b/vblsG/lIW7ywXtTGvQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L1czOMYF; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d88690837eso707952a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 05:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726143135; x=1726747935; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3iTxC8Z/dBwPiof/Avh5XOptashpVsQzWJIkwdHu+UA=;
        b=L1czOMYF0Ouf1FKiMXn+k8Y7/V4//uboVxD5GLwKa1DaPv2kYegXTPMsuGcENmUtel
         A6YpocZe7t32YgZUhCNDx/5XSVM/G2TZBkVzuTtExFpmRJVAUlqRJEtKiBsP4xdiOYqA
         GVV4OwHxhQabeCSG7TJCpjHBGLtsX0Arh8TDsPJUaJLIW+VRq5nZaKi+EwhzEj1jiqXz
         mia5XRyJIt9hCXdg36ofakX8IdGjeQXuipSBZeVqNcfF3swx3tywJRBfBht9+yjAJJd8
         Fos6LITyBX4ciGa0gBK3t4cvVD+0tAYQt4j5yrB2D1KXHWPlQjXcKtEGqg5TR6F+nuhK
         uEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726143135; x=1726747935;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3iTxC8Z/dBwPiof/Avh5XOptashpVsQzWJIkwdHu+UA=;
        b=E+mduF1HGQfQ8XUk/PBGdIeQivcIv30Qn/fIMPvXKkaPjuiF+4GfeOY1MdCFLPSsP5
         InTtgBmwbBtcxv0Jpfs7smXvi9Qdly1xRwarWW8sbPXj/162ntZXVCKTu/Vsa9kTruh8
         Eg1OsSAih+CGL4jQQtn4co7dsfaymuqyWWL22mVo8dG/rOKILWyDN7TJjT+MRqsR0Iwk
         86rEBnXHkVu5i3X94d40qkCpqUh5Gw7pVNAiU4fzip6PHtW/EslrnQCu/1QCieky9P2z
         PAXdztzjXU2CZOnM5lv6zGlP/zbDDGb4rAeESd/Yd5TizhFmINUj0p9ZMDN496/bb4Xa
         Fuag==
X-Gm-Message-State: AOJu0YyGIqeVIcCz1ZdFYEmgBWLgAYyoLcSQZu3BMnGdpbYw3rEhWP97
	L3OyN2odW4sAms9rFDX926VqJZPUSwrxOV21rihPC8wElSXg1Hhs27O4eAJ4eBaSmKtkAAlgNat
	ZHrlp11NVLgZPz7IUgWc7spwa8cDLx09OWkwMlA==
X-Google-Smtp-Source: AGHT+IGxiJTTC3EVX6jlXRs5cpIALDc1iMDC74qlNCErbEtPLyIJODz0oYrR1DXFH2QQsUyqSfJU0CjHrt7pdm2IBks=
X-Received: by 2002:a17:90a:77cb:b0:2d8:8681:44ba with SMTP id
 98e67ed59e1d1-2db9ffbccb4mr2670529a91.15.1726143134846; Thu, 12 Sep 2024
 05:12:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
 <20240830130309.2141697-4-vincent.guittot@linaro.org> <066b7de8-0854-424b-8888-b18fc61ec21c@arm.com>
 <CAKfTPtAX22QPPfA1smH9eOWpqBzXZ=enUOAE8zscEFY9wBbkZQ@mail.gmail.com> <27e1b3c6-7e5b-4e52-9ba4-4e08fe7a11fc@arm.com>
In-Reply-To: <27e1b3c6-7e5b-4e52-9ba4-4e08fe7a11fc@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 12 Sep 2024 14:12:03 +0200
Message-ID: <CAKfTPtD1VZ2Janmioi5Mz47oG6MFyXzRV72MeqfOwdHFkq5NKg@mail.gmail.com>
Subject: Re: [PATCH 3/5] sched/fair: Rework feec() to use cost instead of
 spare capacity
To: Hongyan Xia <hongyan.xia2@arm.com>
Cc: linux-kernel@vger.kernel.org, qyousef@layalina.io, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, vschneid@redhat.com, 
	lukasz.luba@arm.com, mgorman@suse.de, rafael.j.wysocki@intel.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Sept 2024 at 17:32, Hongyan Xia <hongyan.xia2@arm.com> wrote:
>
> On 06/09/2024 08:08, Vincent Guittot wrote:
> > On Mon, 2 Sept 2024 at 13:03, Hongyan Xia <hongyan.xia2@arm.com> wrote:
> >>
> >> On 30/08/2024 14:03, Vincent Guittot wrote:
> >>> feec() looks for the CPU with highest spare capacity in a PD assuming that
> >>> it will be the best CPU from a energy efficiency PoV because it will
> >>> require the smallest increase of OPP. Although this is true generally
> >>> speaking, this policy also filters some others CPUs which will be as
> >>> efficients because of using the same OPP.
> >>> In fact, we really care about the cost of the new OPP that will be
> >>> selected to handle the waking task. In many cases, several CPUs will end
> >>> up selecting the same OPP and as a result using the same energy cost. In
> >>> these cases, we can use other metrics to select the best CPU for the same
> >>> energy cost.
> >>>
> >>> Rework feec() to look 1st for the lowest cost in a PD and then the most
> >>> performant CPU between CPUs.
> >>>
> >>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> >>> ---
> >>>    kernel/sched/fair.c | 466 +++++++++++++++++++++++---------------------
> >>>    1 file changed, 244 insertions(+), 222 deletions(-)
> >>>
> >>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>> index e67d6029b269..2273eecf6086 100644
> >>> --- a/kernel/sched/fair.c
> >>> +++ b/kernel/sched/fair.c
> >>> [...]
> >>>
> >>> -     energy = em_cpu_energy(pd->em_pd, max_util, busy_time, eenv->cpu_cap);
> >>> +/* For a same cost, select the CPU that will povide best performance for the task */
> >>> +static bool select_best_cpu(struct energy_cpu_stat *target,
> >>> +                         struct energy_cpu_stat *min,
> >>> +                         int prev, struct sched_domain *sd)
> >>> +{
> >>> +     /*  Select the one with the least number of running tasks */
> >>> +     if (target->nr_running < min->nr_running)
> >>> +             return true;
> >>> +     if (target->nr_running > min->nr_running)
> >>> +             return false;
> >>>
> >> This makes me a bit worried about systems with coarse-grained OPPs. All
> >> my dev boards and one of my old phones have <= 3 OPPs. On my Juno board,
> >> the lowest OPP on the big core spans across 512 utilization, half of the
> >> full capacity. Assuming a scenario where there are 4 tasks, each with
> >> 300, 100, 100, 100 utilization, the placement should be 300 on one core
> >> and 3 tasks with 100 on another, but the nr_running check here would
> >> give 2 tasks (300 + 100) on one CPU and 2 tasks (100 + 100) on another
> >> because they are still under the lowest OPP on Juno. The second CPU will
> >> also finish faster and idle more than the first one.
> >
> > By balancing the number of tasks on each cpu, I try to minimize the
> > scheduling latency. In your case above, tasks will wait for no more
> > than a slice before running whereas it might have to wait up to 2
> > slices if I put all the (100 utilization) tasks on the same CPU.
>
> If viewed in another angle, we are now asking the 300 task (which
> potentially has a heavier workload to finish) to compete with a 100
> task, and now one core finishes faster and the other takes longer time,
> making the overall execution time longer.

The main problem with utilization is that it also reflects the recent
past and it can screw up task placement as well as I presented at
OSPM. Imagine that a long running  "400 task" just went back to sleep
before placing the "300 task" and the 3 "100 tasks" then you can end
up putting 3 tasks on one core as well.
The goal here is to optimize scheduling latency which is a problem
that has never been really taken into account so far with the problem
of several tasks being stacked on the same cpu which increases the
scheduling latency . A next step after this patchset will be to take
into account the sched slice in addition to the number of tasks to
optimize the scheduling latency of some tasks. The fact that a cpu
will run longer should be taken into account in the energy model when
we compute the energy cost which is not the case for now because of
the complexity to now when cpus will be really idle and which state
will be selected

>
> >>
> >> To give an extreme example, assuming the system has only one OPP (such a
> >> system is dumb to begin with, but just to make a point), before this
> >> patch EAS would still work okay in task placement, but after this patch,
> >
> > Not sure what you mean by would still work okay. Do you have an
> > example in mind that would not work correctly ?
>
> With only one OPP, this patch will balance task placement purely on the
> number of tasks without considering utilization, and I don't think
> that's entirely acceptable (I actually need to deal with such a device
> with only one OPP in real life, although that's the fault of that
> device). Before, we are still balancing on total utilization, which
> results in the lowest execution time.
>
> >
> >> EAS would just balance on the number of tasks, regardless of utilization
> >> of tasks on wake-up.
> >
> > You have to keep in mind that utilization is already taken into
> > account to check if the task fits the CPU and by selecting the OPP
> > (which is a nope in case of one OPP). So we know that there is enough
> > capacity for the waking task
>
> Still, taking my Juno board as an example where the 1st OPP is at
> utilization 512. Assuming no 25% margin, four tasks with utilization
> 200, 200, 50, 50 and two CPUs, I would strongly favor 200 + 50 on one
> CPU and same on the other, than 200 + 200 on one, 50 + 50 on the other.
> However, with this patch, these two scheduling decisions are the same,
> as long as both are under the 512 OPP.

The runnable avg test should handle this when there is the same number
of tasks on both CPUs then we select the one with lowest contention so
one 200 task should end up on each CPU


>
> Of course, this becomes less of a problem with fine-grained OPPs. On my
> Pixel 6 with 18 OPPs on one CPU, I don't have such concerns.
>
> >>
> >> I wonder if there is a way to still take total utilization as a factor.
> >
> > utilization is still used to check that the task utilization fits with
> > current cpu utilization and then to select the OPP. At this step we
> > know that there is enough capacity for everybody
> >
> >> It used to be 100% of the decision making, but maybe now it is only 60%,
> >> and the other 40% are things like number of tasks and contention.
> >>
> >>> -     trace_sched_compute_energy_tp(p, dst_cpu, energy, max_util, busy_time);
> >>> +     /* Favor previous CPU otherwise */
> >>> +     if (target->cpu == prev)
> >>> +             return true;
> >>> +     if (min->cpu == prev)
> >>> +             return false;
> >>>
> >>> -     return energy;
> >>> +     /*
> >>> +      * Choose CPU with lowest contention. One might want to consider load instead of
> >>> +      * runnable but we are supposed to not be overutilized so there is enough compute
> >>> +      * capacity for everybody.
> >>> +      */
> >>> +     if ((target->runnable * min->capa * sd->imbalance_pct) >=
> >>> +                     (min->runnable * target->capa * 100))
> >>> +             return false;
> >>> +
> >>> +     return true;
> >>>    }
> >>> [...]
> >>

