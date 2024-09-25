Return-Path: <linux-kernel+bounces-339150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 580029860CC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1990E28B5DA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6136C186E26;
	Wed, 25 Sep 2024 13:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZsRXHIPM"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA521CF92
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 13:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727270878; cv=none; b=rBW1LhtOIwHD8Vj8ALRYo8FCOeSAWelp3IlW0uUhTTo3IWLxEciuKWrRoxRYVUmAzMdn6KtNP5I3sb153unsxfBXBPUNyTnftQ72u+g9fA4PfXHNApI5IN0b04SGkN2nVEPkYV+lG1nK70TYbC5vUDePJLkBqgmn29cus5bta0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727270878; c=relaxed/simple;
	bh=tE1B3pWKxAuNCu9sK5lHUDVZmEvavhLfGhso5+qFxwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NwCDbCSI3k7E3QzwLGrXxPJIRvalo2sKx/y7SmvfzFG3Uuh3UTPxNTvbKnSmVZ/AndosHUaMWXy0aHmdu7dcZrFoUv9TXKRjbBtEL+99M9nrRgKKJu6h1WdFWXvBs6WfnGpD0ZyxA6mwKHgg3+0t2BBcgZEVZrVXS9HXsuUo7PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZsRXHIPM; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7db238d07b3so5515503a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 06:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727270876; x=1727875676; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=naGwmZFNxawTX48A6Pc7wa6wGYpROl3F3TeFALx601w=;
        b=ZsRXHIPMwACPIVgifto/mwhY5BBOQTiMcL80WX0c8i2XZBHeZDe7XQfVLN4aFrbI93
         49Qx/0VhVcAzx2WVOHtcf+puJSdVv4pSodbquhjotO+3yweUp38A+XvT99la0d3TYImp
         MjxobAxhK6f02ubRjvP1fYE6l22vmrEUH+/TIY8mlnvsiSF80UuCNIeiDHveBY5NBFIJ
         qNfNtbsf5+WoD8K9JWmvIwa/7AfysCQMCwb45PAwSCN4fc9zpH8Sc8aRm7QWeXDupsPU
         GgeOLkYq4zn3hmYmAxfTNj5Mqyn6+inc3qFKT/59m2lRXoOYqjPe2q3KRQ859Mx+6JZ2
         pRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727270876; x=1727875676;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=naGwmZFNxawTX48A6Pc7wa6wGYpROl3F3TeFALx601w=;
        b=q7+P/lCOP0GzPJskNTfZ1ZfiN18ta+FauhQOHrZeggPgxZBEkyBhFdWr9iH74cSg3O
         4jPIRmd12Eoe4P+vNxoy7Q/G4PZDQ+nklANwvDJdrpj7I/ow6oE80mfh1zqOHQoMS4YT
         OnTFufTRU6HPqEY1SXtlptFHuZb781jxV7C3SdYkykZ1cHnpXWQoQY4DGMOw/s/adZoR
         Vhh3dY+5tlKYCVAcDVBTXi3Wc793MwuJw1PUUEyBc1jOGhB8DOXK9vniSx2EgvztiR2F
         qFi8kFN4Y/m9AwREZ6shH/6v2OcRkiomcz9fkNW/Avqv+RZZc2HHsP8dusoYqU09tjWW
         bSGA==
X-Forwarded-Encrypted: i=1; AJvYcCVH1FIWYjTcy6Owx/UYzKOl9wLw4uSti6MO1+APdyHuEzkiA7gRfQgZhDJwJCMxVNSXD+TYf/pvUtlF1a4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8fmLWNZxR6UKio1G0hnqooxtRLnqGcL5BvsAPpBEQloLVjZGb
	+TrgFfrAyPIKMRGIiOAkJNHBxY+zzHcLZTvnuy7g05+D418Ejr6mfWAePBVLBz3OE6m9O2ibfwl
	X+nCq6RZ8IzJKA8lKIuOFWW1QY7go566qVBD/5w==
X-Google-Smtp-Source: AGHT+IHqI5pg8bLubmnTJBa3tFu4gVOzpx6iLgMLNUyiH18NRfNUWmYTMoDoSIEnDb1TO6c4ZQ41AMgvGoIDzkZwOyc=
X-Received: by 2002:a05:6a20:9c8e:b0:1cf:5578:9cba with SMTP id
 adf61e73a8af0-1d4d4aad223mr3937086637.11.1727270876241; Wed, 25 Sep 2024
 06:27:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
 <20240830130309.2141697-5-vincent.guittot@linaro.org> <Zu2gHOv7mqArWXLZ@google.com>
In-Reply-To: <Zu2gHOv7mqArWXLZ@google.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 25 Sep 2024 15:27:45 +0200
Message-ID: <CAKfTPtCvwPq+8pQcTZePiee9EXxKAQS=J57X2OavWFrQwkDt5A@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] sched/fair: Use EAS also when overutilized
To: Quentin Perret <qperret@google.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, lukasz.luba@arm.com, 
	rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, qyousef@layalina.io, 
	hongyan.xia2@arm.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Sept 2024 at 18:17, Quentin Perret <qperret@google.com> wrote:
>
> Hi Vincent,
>
> On Friday 30 Aug 2024 at 15:03:08 (+0200), Vincent Guittot wrote:
> > Keep looking for an energy efficient CPU even when the system is
> > overutilized and use the CPU returned by feec() if it has been able to find
> > one. Otherwise fallback to the default performance and spread mode of the
> > scheduler.
> > A system can become overutilized for a short time when workers of a
> > workqueue wake up for a short background work like vmstat update.
> > Continuing to look for a energy efficient CPU will prevent to break the
> > power packing of tasks.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 2273eecf6086..e46af2416159 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8505,7 +8505,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
> >                   cpumask_test_cpu(cpu, p->cpus_ptr))
> >                       return cpu;
> >
> > -             if (!is_rd_overutilized(this_rq()->rd)) {
> > +             if (sched_energy_enabled()) {
>
> As mentioned during LPC, when there is no idle time on a CPU, the
> utilization value of the tasks running on it is no longer a good
> approximation for how much the tasks want, it becomes an image of how
> much CPU time they were given. That is particularly problematic in the
> co-scheduling case, but not just.

Yes, this is not always true when overutilized and  true after a
certain amount of time. When a CPU is fully utilized without any idle
time anymore, feec() will not find a CPU for the task

>
> IOW, when we're OU, the util values are bogus, so using feec() is frankly
> wrong IMO. If we don't have a good idea of how long tasks want to run,

Except that the CPU is not already fully busy without idle time when
the system is overutilized. We have  ~20% margin on each CPU which
means that system are overutilized as soon as one CPU is more than 80%
utilized which is far from not having idle time anymore. So even when
OU, it doesn't mean that all CPUs don't have idle time and most of the
time the opposite happens and feec() can still make a useful decision.
Also, when there is no idle time on a CPU, the task doesn't fit and
feec() doesn't return a CPU.

Then, the old way to compute invariant utilization was particularly
sensible to the overutilized state because the utilization was capped
and asymptotically converging to max cpu compute capacity but this is
not true with the new pelt and we can go above compute capacity of the
cpu and remain correct as long as we are able to increase the compute
capacity before that there is no idle time. In theory, the utilization
"could" be correct until we reach 1024 (for utilization or runnable)
and there is no way to catch up the temporary under compute capacity.

> the EM just can't help us with anything so we should stay away from it.
>
> I understand how just plain bailing out as we do today is sub-optimal,
> but whatever we do to improve on that can't be doing utilization-based
> task placement.
>
> Have you considered making the default (non-EAS) wake-up path a little
> more reluctant to migrations when EAS is enabled? That should allow us
> to maintain a somewhat stable task placement when OU is only transient
> (e.g. due to misfit), but without using util values when we really
> shouldn't.
>
> Thoughts?

As mentioned above OU doesn't mean no idle time anymore and in this
case utilization is still relevant. In would be in favor of adding
more performance related decision into feec() similarly to have is
done in patch 3 which would be for example that if a cpu doesn't fit
we could still return  a CPU with more performance focus


>
> Thanks,
> Quentin
>
> >                       new_cpu = find_energy_efficient_cpu(p, prev_cpu);
> >                       if (new_cpu >= 0)
> >                               return new_cpu;
> > --
> > 2.34.1
> >
> >

