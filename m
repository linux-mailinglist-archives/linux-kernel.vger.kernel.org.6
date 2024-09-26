Return-Path: <linux-kernel+bounces-340195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D1E986FAB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 888462853C2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1081ABEB9;
	Thu, 26 Sep 2024 09:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fNVmxQJi"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA6E1AB6CA
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 09:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727341839; cv=none; b=cazqQ/p4hlBOImIp0rgZUZ55wH4xFM9j5VSEgbC4ljeiPC6MbzbWe82twx8y+EM7uvxc6ql0ARa4PYSRN6oT9csGADCjtqa3QXbleLr9WvdubtKVAqx2glhbDIqrmn9/0uvmor0VltvybQLZtdmdT1fewvfrG0U83gIT4SdCvck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727341839; c=relaxed/simple;
	bh=STUbkF2D7PEb9w5HvCgXGFkhOaSDqLJXd2v/oBb+YHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYyIAwFQ6lhaJiB4wl6n6+gHpddKUbAObYTfsoUEX5oTGKQcD743f9RIiq6zKMYrrz48gdkkr+SARPq4qj3ddNcsVC6PKyqad0T4lpxZBr4R87TshN++CgVqKoVP/5XQrH0erAdv5LvxHepGqP/+cquXZIRjlzc6L81pBXC3o8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fNVmxQJi; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8a7903cb7dso51487066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 02:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727341836; x=1727946636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SPCfLW65Bgc+pcLtC24hW0h6koYw5G/rTnRxS3iZa8U=;
        b=fNVmxQJiPqq5a0VAAUtl08DmrlILP3X+QUi++8bOffQxbKlJW6zMvQpZNSbMmh/IND
         5if32OaX3yr+mq/JshSUfCVScR7rVzlUFZ49j5cpBAjFZVyTXA8e1N284FiEzqywNnmx
         dHnspFSU9YRMs8ozcWwtZJJNx4YLmgRAhWatPpQbjV3/80tXpoqDKHV5znNgtLjB43Li
         AHQs3VcF+DyZLidjaeNIsgoyAnGhFlHoum79/tucLUwe0MArnHBTC16Xvgvz9Du1dhHX
         ee8glfixRK9iO2P13NKp+KEM8TnqSx/xPQwNL7KSSn+YmRg2i38pAzRRnwMIXxb0Ae2C
         aK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727341836; x=1727946636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPCfLW65Bgc+pcLtC24hW0h6koYw5G/rTnRxS3iZa8U=;
        b=cC8UUzciXE/UfWFP4S8e12Z9CSEFWE9eis48lX38hLmHiNFU6SxioS5Jpknx0rYTZp
         OMApXa4NTbVOmwfFqF1t2NseywSMnDmgZ1eEjR2tJqqTAye3JyDiTEeNAGtzZeS9qEXv
         kBX098E5ex/PqFRh+jJ6vuSzId/0Q2UsI5Z9UPFA9i38aB4pWQcPqI3WSXRptHLsqyup
         NgFN2LmwF+z913PlYCZ0kZIlzdQditdnixdogX9sFsG0hi3ZvqCWvt3JCScMh+BV/6g4
         PK3n9Zd43uo4Fa60UWdJD5KaMS4LX7hBzSRSTl0ttixxVeOQfgN3JiZs9XwIc1xJMpqS
         ynYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhadEM2PpPRe0EkhqmI+iXjMAPNqD2HXfh3eKdN4OqkPQtr62qeV+McAT/7IljXw+6AQcIlrU/G/KWLYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY6Y5ISyXOav73+q3yyM44e1rNnZPFtH5WeGieEmLLBTBisGJx
	1rVUPrqumbEQSppQoy5ktoeFNWT3VF59iZ9AYIuggGqAOw6her7UpVn0J3CLBg==
X-Google-Smtp-Source: AGHT+IF1zGbZgJtThysJsgJ9f7i/Gra9R+oVe06RBTw0xlDlNU/cBu54lHZO5DFMJCBAU+mCOVYL8Q==
X-Received: by 2002:a05:6402:1e92:b0:5c4:1d22:9f65 with SMTP id 4fb4d7f45d1cf-5c72074d053mr5723990a12.24.1727341835299;
        Thu, 26 Sep 2024 02:10:35 -0700 (PDT)
Received: from google.com (118.240.90.34.bc.googleusercontent.com. [34.90.240.118])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf49dbbdsm2910522a12.57.2024.09.26.02.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 02:10:34 -0700 (PDT)
Date: Thu, 26 Sep 2024 09:10:31 +0000
From: Quentin Perret <qperret@google.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, lukasz.luba@arm.com,
	rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org,
	qyousef@layalina.io, hongyan.xia2@arm.com
Subject: Re: [RFC PATCH 4/5] sched/fair: Use EAS also when overutilized
Message-ID: <ZvUlB8s-zIkDQji7@google.com>
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
 <20240830130309.2141697-5-vincent.guittot@linaro.org>
 <Zu2gHOv7mqArWXLZ@google.com>
 <CAKfTPtCvwPq+8pQcTZePiee9EXxKAQS=J57X2OavWFrQwkDt5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCvwPq+8pQcTZePiee9EXxKAQS=J57X2OavWFrQwkDt5A@mail.gmail.com>

Hi Vincent,

On Wednesday 25 Sep 2024 at 15:27:45 (+0200), Vincent Guittot wrote:
> On Fri, 20 Sept 2024 at 18:17, Quentin Perret <qperret@google.com> wrote:
> >
> > Hi Vincent,
> >
> > On Friday 30 Aug 2024 at 15:03:08 (+0200), Vincent Guittot wrote:
> > > Keep looking for an energy efficient CPU even when the system is
> > > overutilized and use the CPU returned by feec() if it has been able to find
> > > one. Otherwise fallback to the default performance and spread mode of the
> > > scheduler.
> > > A system can become overutilized for a short time when workers of a
> > > workqueue wake up for a short background work like vmstat update.
> > > Continuing to look for a energy efficient CPU will prevent to break the
> > > power packing of tasks.
> > >
> > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > ---
> > >  kernel/sched/fair.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 2273eecf6086..e46af2416159 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -8505,7 +8505,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
> > >                   cpumask_test_cpu(cpu, p->cpus_ptr))
> > >                       return cpu;
> > >
> > > -             if (!is_rd_overutilized(this_rq()->rd)) {
> > > +             if (sched_energy_enabled()) {
> >
> > As mentioned during LPC, when there is no idle time on a CPU, the
> > utilization value of the tasks running on it is no longer a good
> > approximation for how much the tasks want, it becomes an image of how
> > much CPU time they were given. That is particularly problematic in the
> > co-scheduling case, but not just.
> 
> Yes, this is not always true when overutilized and  true after a
> certain amount of time. When a CPU is fully utilized without any idle
> time anymore, feec() will not find a CPU for the task

Well the problem is that is might actually find a CPU for the task -- a
co-scheduled task can obviously look arbitrarily small from a util PoV.

> >
> > IOW, when we're OU, the util values are bogus, so using feec() is frankly
> > wrong IMO. If we don't have a good idea of how long tasks want to run,
> 
> Except that the CPU is not already fully busy without idle time when
> the system is overutilized. We have  ~20% margin on each CPU which
> means that system are overutilized as soon as one CPU is more than 80%
> utilized which is far from not having idle time anymore. So even when
> OU, it doesn't mean that all CPUs don't have idle time and most of the
> time the opposite happens and feec() can still make a useful decision.

My problem with the proposed change here is that it doesn't at all
distinguish between the truly overloaded case (when we have more compute
demand that resources) from a system with a stable-ish utilization at
90%. If you're worried about the latter, then perhaps we should think
about redefining the OU threshold some other way (either by simply
making higher or configurable, or changing its nature to look at the
last time we actually got idle time in the system). But I'm still rather
opinionated that util-based placement is wrong for the former.

And for what it's worth, in my experience if any of the big CPUs get
anywhere near the top of their OPP range, given that the power/perf
curve is exponential it's being penny-wise and pound-foolish to
micro-optimise the placement of the other smaller tasks from an energy
PoV at the same time. But if we can show that it helps real use-cases,
then why not.

> Also, when there is no idle time on a CPU, the task doesn't fit and
> feec() doesn't return a CPU.

It doesn't fit on that CPU but might still (incorrectly) fit on another
CPU right?

> Then, the old way to compute invariant utilization was particularly
> sensible to the overutilized state because the utilization was capped
> and asymptotically converging to max cpu compute capacity but this is
> not true with the new pelt and we can go above compute capacity of the
> cpu and remain correct as long as we are able to increase the compute
> capacity before that there is no idle time. In theory, the utilization
> "could" be correct until we reach 1024 (for utilization or runnable)
> and there is no way to catch up the temporary under compute capacity.
> 
> > the EM just can't help us with anything so we should stay away from it.
> >
> > I understand how just plain bailing out as we do today is sub-optimal,
> > but whatever we do to improve on that can't be doing utilization-based
> > task placement.
> >
> > Have you considered making the default (non-EAS) wake-up path a little
> > more reluctant to migrations when EAS is enabled? That should allow us
> > to maintain a somewhat stable task placement when OU is only transient
> > (e.g. due to misfit), but without using util values when we really
> > shouldn't.
> >
> > Thoughts?
> 
> As mentioned above OU doesn't mean no idle time anymore and in this
> case utilization is still relevant

OK, but please distinguish this from the truly overloaded case somehow,
I really don't think we can 'break' it just to help with the corner case
when we've got 90% ish util.

> In would be in favor of adding
> more performance related decision into feec() similarly to have is
> done in patch 3 which would be for example that if a cpu doesn't fit
> we could still return  a CPU with more performance focus

Fine with me in principle as long as we stop using utilization as a
proxy for how much a task wants when it really isn't that any more.

Thanks!
Quentin

> >
> > Thanks,
> > Quentin
> >
> > >                       new_cpu = find_energy_efficient_cpu(p, prev_cpu);
> > >                       if (new_cpu >= 0)
> > >                               return new_cpu;
> > > --
> > > 2.34.1
> > >
> > >

