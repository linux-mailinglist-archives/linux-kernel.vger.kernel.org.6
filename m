Return-Path: <linux-kernel+bounces-346336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC7698C34B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE7E5B254BB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8808E1CC894;
	Tue,  1 Oct 2024 16:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WcPGsVOO"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098711CB339
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727799617; cv=none; b=VEJtzOg8ficLXWAriNQCvlvgMwALLoOMjjO5I1MpJE5vDjwJ//T1AH9im6FPX/XHi6ho4fMXUJdvyjUUNs/GkWQfN7V9/HucxJMGRz58jH/RyP6T+N6I4ZV/yzUXKDDjM8hP2nAsenSB4z1LYruACAYeoexebIgpnj14wqNNYDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727799617; c=relaxed/simple;
	bh=HXAypAu67r8SaQritYIHJ9dukhURzXnYviEqSBnitLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KnXC7C4x/T56L9k8eYZRoGJnll+ofjHvdR9Zel8RDm6/NzlSMnbmgWEgwbrCDjM/HtOnlAVSkLE/57Sga4731zB4R9xoGSXa7ucZczSLIENnM/bD+0ns+U2vUsvguUuYq0z+9K9ITcuwPMS0vDXbWa/MqfOMEbXMWTRp3MnDXNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WcPGsVOO; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e08085596eso5235661a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 09:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727799615; x=1728404415; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9zDS0+dMmJVmlufOQQSr0/FQ4ues7NtwXZCmiMpp054=;
        b=WcPGsVOOjbeAZ2wunVQbrHVlqXfBokD2hBCKW97Bzlyc7byncoReO0J/1DdMOeqe2s
         v2mHCIvu/ZwD4lK8e+xteIMaSL/mOYJT9tRWeRTh7eY5YCQXtFiHVyh0GSz5jS8RMPyc
         uBdulqG+rVd+wh+oigFJN7GSm9PbRKxGSn/xWD+oty/unPcAoRN5hN/2LARlQMLPVjAN
         +lyliPV2BrbL4rx9ps/JJOhSsukGSrMIOTjX1tnrOV9Bx5DnN3EsXNMtoo1JFBUTbIey
         NtN1DCzXC1qY4wzXaByLspeTIzG1i80Fn3sgpVv5tzS10vQy4AOiCFMhTPZmdBJuoh+Y
         R4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727799615; x=1728404415;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9zDS0+dMmJVmlufOQQSr0/FQ4ues7NtwXZCmiMpp054=;
        b=OX7p3kgZp56wzkCbyhDLn5XTBXlnOHA1wDigxYeM40ftZ4fFF3cdIXO267diQ07UVs
         Ts8ZAUsJ4tmxvnpirA9W+cBCl8+Wuh6R3xE7+rN4mO9iPYuGvPyQLEmsP8eRtK7Udc2o
         1bBG9XzpZzk18Bmawhv7s8VgzCP4dW+PtY7UNQuWMV1gERGKulrOQaHZVhDEMr/XcUMm
         RbVEWqRdfeE8vaGbeXIRqHCRG62g2s26ogVeHchJexGzo2lrY6hJR5ArDXbB+Q9icCM/
         xKplWPgFGEDZl0UaGNRaF94GiJ54r17x2QDlzObemVrJwNwZbk3lRPd+w+SJ7Wd9ytcr
         o6Mg==
X-Forwarded-Encrypted: i=1; AJvYcCVzISav3SKFCaeT7WWq6gSsFxKbO114ICnySQZk1SULYDQvaga9gmeLzHQ7hPoaRlDJfJzsRtps0q2S4ik=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFsbrH7wFHRZd2t14UaC/aiwDLJxPHYm7K+hkSazfe7BVPSzwg
	CAHsxGucAr9JWRNrH1mTrcsH1bkmZ4gCyZrA5wIoBWtNMGz9+8npw68EiV6NkoQc9FG5qWk3fV0
	ymjNgLMcmLV90mF5SGVfzv3dkKzNqmTvqgZO6SA==
X-Google-Smtp-Source: AGHT+IHjbO9qCs+qHmEJsT2LBD9iUNk52EDALIUxZieteDa3lQXgNMmYuY+f/SlsvR44tUYqeXwFkfADRF1JIqOBo+g=
X-Received: by 2002:a17:90a:bb04:b0:2d8:8991:211f with SMTP id
 98e67ed59e1d1-2e18490a137mr267814a91.28.1727799615279; Tue, 01 Oct 2024
 09:20:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
 <20240830130309.2141697-5-vincent.guittot@linaro.org> <Zu2gHOv7mqArWXLZ@google.com>
 <CAKfTPtCvwPq+8pQcTZePiee9EXxKAQS=J57X2OavWFrQwkDt5A@mail.gmail.com> <ZvUlB8s-zIkDQji7@google.com>
In-Reply-To: <ZvUlB8s-zIkDQji7@google.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 1 Oct 2024 18:20:03 +0200
Message-ID: <CAKfTPtAzG7u0+e=8skMhnCETVxbDTOxT-zLaoqUXB-Zz5=4t+A@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] sched/fair: Use EAS also when overutilized
To: Quentin Perret <qperret@google.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, lukasz.luba@arm.com, 
	rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, qyousef@layalina.io, 
	hongyan.xia2@arm.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Sept 2024 at 11:10, Quentin Perret <qperret@google.com> wrote:
>
> Hi Vincent,
>
> On Wednesday 25 Sep 2024 at 15:27:45 (+0200), Vincent Guittot wrote:
> > On Fri, 20 Sept 2024 at 18:17, Quentin Perret <qperret@google.com> wrote:
> > >
> > > Hi Vincent,
> > >
> > > On Friday 30 Aug 2024 at 15:03:08 (+0200), Vincent Guittot wrote:
> > > > Keep looking for an energy efficient CPU even when the system is
> > > > overutilized and use the CPU returned by feec() if it has been able to find
> > > > one. Otherwise fallback to the default performance and spread mode of the
> > > > scheduler.
> > > > A system can become overutilized for a short time when workers of a
> > > > workqueue wake up for a short background work like vmstat update.
> > > > Continuing to look for a energy efficient CPU will prevent to break the
> > > > power packing of tasks.
> > > >
> > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > ---
> > > >  kernel/sched/fair.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index 2273eecf6086..e46af2416159 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -8505,7 +8505,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
> > > >                   cpumask_test_cpu(cpu, p->cpus_ptr))
> > > >                       return cpu;
> > > >
> > > > -             if (!is_rd_overutilized(this_rq()->rd)) {
> > > > +             if (sched_energy_enabled()) {
> > >
> > > As mentioned during LPC, when there is no idle time on a CPU, the
> > > utilization value of the tasks running on it is no longer a good
> > > approximation for how much the tasks want, it becomes an image of how
> > > much CPU time they were given. That is particularly problematic in the
> > > co-scheduling case, but not just.
> >
> > Yes, this is not always true when overutilized and  true after a
> > certain amount of time. When a CPU is fully utilized without any idle
> > time anymore, feec() will not find a CPU for the task
>
> Well the problem is that is might actually find a CPU for the task -- a
> co-scheduled task can obviously look arbitrarily small from a util PoV.

With commit 50181c0cff31 ("sched/pelt: Avoid underestimation of task
utilization"), the util_est remains set the value before having to
share the cpu with other tasks which means that the util_est remains
correct even if its util_avg decrease because of sharing the cpu with
other task. This has been done to cover the cases that you mention
above whereboth util_avg and util_est where decreasing when tasks
starts to  share  the CPU bandwidth with others

>
> > >
> > > IOW, when we're OU, the util values are bogus, so using feec() is frankly
> > > wrong IMO. If we don't have a good idea of how long tasks want to run,
> >
> > Except that the CPU is not already fully busy without idle time when
> > the system is overutilized. We have  ~20% margin on each CPU which
> > means that system are overutilized as soon as one CPU is more than 80%
> > utilized which is far from not having idle time anymore. So even when
> > OU, it doesn't mean that all CPUs don't have idle time and most of the
> > time the opposite happens and feec() can still make a useful decision.
>
> My problem with the proposed change here is that it doesn't at all
> distinguish between the truly overloaded case (when we have more compute
> demand that resources) from a system with a stable-ish utilization at
> 90%. If you're worried about the latter, then perhaps we should think
> about redefining the OU threshold some other way (either by simply
> making higher or configurable, or changing its nature to look at the

we definitely increase the OU threshold but we still have case with
truly overutilized CPU but still good utilization value

> last time we actually got idle time in the system). But I'm still rather
> opinionated that util-based placement is wrong for the former.

And feec() will return -1 for that case because util_est remains high

>
> And for what it's worth, in my experience if any of the big CPUs get
> anywhere near the top of their OPP range, given that the power/perf
> curve is exponential it's being penny-wise and pound-foolish to
> micro-optimise the placement of the other smaller tasks from an energy
> PoV at the same time. But if we can show that it helps real use-cases,
> then why not.

The thermal mitigation and/or power budget policy quickly reduce the
max compute capacity of such big CPUs becomes overutilized with lower
OPP which reduce the diff between big/medium/little

>
> > Also, when there is no idle time on a CPU, the task doesn't fit and
> > feec() doesn't return a CPU.
>
> It doesn't fit on that CPU but might still (incorrectly) fit on another
> CPU right?

the commit that I mentioned above covers those cases and the task will
not incorrectly fit to another smaller CPU because its util_est is
preserved during the overutilized phase

>
> > Then, the old way to compute invariant utilization was particularly
> > sensible to the overutilized state because the utilization was capped
> > and asymptotically converging to max cpu compute capacity but this is
> > not true with the new pelt and we can go above compute capacity of the
> > cpu and remain correct as long as we are able to increase the compute
> > capacity before that there is no idle time. In theory, the utilization
> > "could" be correct until we reach 1024 (for utilization or runnable)
> > and there is no way to catch up the temporary under compute capacity.
> >
> > > the EM just can't help us with anything so we should stay away from it.
> > >
> > > I understand how just plain bailing out as we do today is sub-optimal,
> > > but whatever we do to improve on that can't be doing utilization-based
> > > task placement.
> > >
> > > Have you considered making the default (non-EAS) wake-up path a little
> > > more reluctant to migrations when EAS is enabled? That should allow us
> > > to maintain a somewhat stable task placement when OU is only transient
> > > (e.g. due to misfit), but without using util values when we really
> > > shouldn't.
> > >
> > > Thoughts?
> >
> > As mentioned above OU doesn't mean no idle time anymore and in this
> > case utilization is still relevant
>
> OK, but please distinguish this from the truly overloaded case somehow,
> I really don't think we can 'break' it just to help with the corner case
> when we've got 90% ish util.
>
> > In would be in favor of adding
> > more performance related decision into feec() similarly to have is
> > done in patch 3 which would be for example that if a cpu doesn't fit
> > we could still return  a CPU with more performance focus
>
> Fine with me in principle as long as we stop using utilization as a
> proxy for how much a task wants when it really isn't that any more.
>
> Thanks!
> Quentin
>
> > >
> > > Thanks,
> > > Quentin
> > >
> > > >                       new_cpu = find_energy_efficient_cpu(p, prev_cpu);
> > > >                       if (new_cpu >= 0)
> > > >                               return new_cpu;
> > > > --
> > > > 2.34.1
> > > >
> > > >

