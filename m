Return-Path: <linux-kernel+bounces-318310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCD096EB9A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95D09B24209
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 07:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEF014AD24;
	Fri,  6 Sep 2024 07:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JjwLRoSP"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F614437A
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 07:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725606544; cv=none; b=UoY2rFCO3hpCbIJCBBFF52CdWBZvvTUVDHvmCyoBUcZujVbr7s7VLtqsyeuwQet1+lFrmsXpqG8kw5plAl6MJLmMTuWeB799mnD12XPla+2HE8/NAAaV9L9iFV8SX/Z8xDLDi2McgsDi9EaH+s4x8XDmMjBtlZK1akdYyaUudzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725606544; c=relaxed/simple;
	bh=g96poRyN+sAN9RXReYhjk6AVAhuzLeyn/v5iu/JZunI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXElRnRuGAhuF90JMs0/A+jOoc2seMUvA6EhvbmfrRyCWd23WIyCiq7rqq8Su3FkXLTlmbPwycgCvOMdOzkxmiwuFKYUTQvzxrQ5nc3zW5vWQCQbuC+7r9GsQT9BaXeCUUCzWWnCRWd1l92rZD/0RSbLYrp6V6iEj5Sd3Db3wLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JjwLRoSP; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7d4f8a1626cso1290233a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 00:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725606542; x=1726211342; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MMDREcljwxQ/sIkLNDrWkXdCN96AdWqe/99FOLmNWIU=;
        b=JjwLRoSPEBlQl5+CH6VhBocLQWK3KwW+CKID48uGCruMZFtGcghhIo2z2S+omPBBKz
         cLKTzUa12DRHasUuYWszmb114eFH0I3hd1lrjuIeKaZ6gvO5Mnn1rD7LucF8tzDzDHW1
         emY5NsLXH24qQHr51XsP1o5UNUopvuK+GgmGlpxH68T0t1eqNchPXnHrIp86LSY7EkgR
         m8PQoeiLbVD4PxJ3tvMjakgynuTezx4PPt+qDTdkyUQTo0s3QSHb8vuWwI/P1WUPgDPE
         gv1Hfxar622etqplanoEgy82mXzM1uDI1M/YC4ZOo88k2MJI8duW1RhvZN0GGAjxn2gQ
         Fh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725606542; x=1726211342;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MMDREcljwxQ/sIkLNDrWkXdCN96AdWqe/99FOLmNWIU=;
        b=g5Itd5Hd3Q1adIaxOTBjV/Enem6RwQEArogFooSqO4p0qxpAD+Yh1ETHUttCjTtDed
         +tvMO5YKPCssYVN8cTBua/CrmacYA6p8DC56/tTkCEycc02WIgxgugyAIwE5iTLelf7g
         NaP5qwQ9ukpfzDLCKTCqy/EidtjSOOgLXMCFBPynKptU10xNb/CltRtIuUDl5WXTXkZk
         Pg6W85ufyJFLmMcY+GPinZcqhNvU5vo9xlWFMoTe+NnC6+gttiVSlGjSC3goNN4KNuU0
         7MWzZHnicUMIaDcwbXi1MBldLs/Z3P7HnDoXDlvMo5QdkyX2JojYv+eC3khS78fAtoBb
         4JsA==
X-Forwarded-Encrypted: i=1; AJvYcCWlph0b6L/7AfLfHHs7VnzxR/KHuXZRhPaGVdrmHZiLNFKtEX3ouBu9UvmdNj3K7BAjYrSvLHLMYaeSnXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYS9Ig9R9mYfKoyTmtwj6JhgVa+ifCj2iBj921cUGVdLDJwSBw
	I3Pmogpxr0IZIKHvSe7AJNMhM/gZ4BNLISajYtTosRyaO8+O8fbbvuhuR9wdmoz7zpC4KfvBVtn
	wKdgsANlV8YdA+BrjAd+LGsSvXyDijoxPScrerw==
X-Google-Smtp-Source: AGHT+IHLimaqZE9yHMO3rpAiGUFrWQ7xO7AhXBIyv4AGYKrgDTTEr1VhftATIuD8xTtU647sH4oSq9Pq3GMHviv3enA=
X-Received: by 2002:a17:90b:4acd:b0:2cf:c9df:4cc8 with SMTP id
 98e67ed59e1d1-2dad50fa064mr1999857a91.38.1725606541741; Fri, 06 Sep 2024
 00:09:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
 <20240830130309.2141697-4-vincent.guittot@linaro.org> <4b5a6038-3b1e-4983-814b-280938173a2d@arm.com>
In-Reply-To: <4b5a6038-3b1e-4983-814b-280938173a2d@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 6 Sep 2024 09:08:50 +0200
Message-ID: <CAKfTPtDWFe_5Vt8X48ZQLwX1tnjCcktWFOqtacjPhUSpO4Aj3Q@mail.gmail.com>
Subject: Re: [PATCH 3/5] sched/fair: Rework feec() to use cost instead of
 spare capacity
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, lukasz.luba@arm.com, 
	rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, qyousef@layalina.io, 
	hongyan.xia2@arm.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Sept 2024 at 17:07, Pierre Gondois <pierre.gondois@arm.com> wrote:
>
>
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
> > +     /*
> > +      * Skip CPUs that cannot satisfy the capacity request.
> > +      * IOW, placing the task there would make the CPU
> > +      * overutilized. Take uclamp into account to see how
> > +      * much capacity we can get out of the CPU; this is
> > +      * aligned with sched_cpu_util().
> > +      */
> > +     if (uclamp_is_used() && !uclamp_rq_is_idle(rq)) {
> > +             unsigned long rq_util_min, rq_util_max;
> > +             /*
> > +              * Open code uclamp_rq_util_with() except for
> > +              * the clamp() part. I.e.: apply max aggregation
> > +              * only. util_fits_cpu() logic requires to
> > +              * operate on non clamped util but must use the
> > +              * max-aggregated uclamp_{min, max}.
> > +              */
> > +             rq_util_min = uclamp_rq_get(rq, UCLAMP_MIN);
> > +             rq_util_max = uclamp_rq_get(rq, UCLAMP_MAX);
> > +             util_min = max(rq_util_min, p_util_min);
> > +             util_max = max(rq_util_max, p_util_max);
> > +     }
> > +     return util_fits_cpu(util, util_min, util_max, cpu);
> > +}
> >
> > -     energy = em_cpu_energy(pd->em_pd, max_util, busy_time, eenv->cpu_cap);
>
> I think em_cpu_energy() would need to be removed with this patch,
> if there are no more references to it.

Yes, I will add a patch to cleanup unused function

>

