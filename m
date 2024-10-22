Return-Path: <linux-kernel+bounces-376447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 086909AB1B6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D09A1F24248
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 15:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BEC1A2C0E;
	Tue, 22 Oct 2024 15:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j+vBb1v5"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BDC1A257A
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 15:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729609735; cv=none; b=PUV64SCAuMgKD4YOFYChgzkEuu6yX2JX+4lRtYiYF9qgighLttVY6Mtfx+jLlZ0EBmJ0gShNIuzurXz4iraxykMooRNtjpVBtoOA4A91xJmzTz8BpdmAws8Qm/TCXdw4BtSUWyIgGDcKFyVvfQMUg/BOyxaRdbF12/bS6LFkWII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729609735; c=relaxed/simple;
	bh=F5GtqapFxHdcdH8bjmB/xNAObkdxC408A3YWRggND3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=haxZ0zDjJQaX6FdwoNIv8rEAx3JbDydpmgF3djkg35IZVJNacXHan2EtDC5vkJlgi3aJ89UYa3w5SzfuDACzYFjqqKOdAg1/RWdCDTcwPzV/QzrdlFQTcnx+Pyw4qVokwoTheM3wevJ12CrTiFz1sVFMYyf9+9lBkWhWKawK9Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j+vBb1v5; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so4295334a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 08:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729609733; x=1730214533; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mku5pRY4j9r+Rq73n7YKu1xqjHAkR8dsAeaFYNdRYFE=;
        b=j+vBb1v59UOu29s7+ICnhccq2yH8HES27zSs6YXb9s3iCP6N4LK8ouh0NStsRQNBB0
         jHxG1UQ2kW7NJbM1VV+rEM9llAg46rGVWERNmjY0S8jfItcylZsfqXIlJzF0TKpS+9EI
         lvJrgg/JyG2lbMGGUSXN+JGej02w3uHJCJqTPsvR7oFE0P2MCJhtL06N48AnBKTySbzm
         TNZxJj/y9YCUejqL1oddcHfebF+iEtfVcCzxc87jIYJZ0u60S5KlD4rR5HXRFOffneYB
         tNUIBEtFxD/w+MVasKEYDle9v73zByNG1AvHnxin8TkyziuiFzeQ/QZkPgxsyJ8iB20g
         VQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729609733; x=1730214533;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mku5pRY4j9r+Rq73n7YKu1xqjHAkR8dsAeaFYNdRYFE=;
        b=OoA8uDnHsK4qYUdYc84RfdEikTlaQKPV6ehg0NIx3TavVCZ97HYkNNNEInDo3XPhN3
         XABO/OH4vqsFYEoCvjSz44vN/YwOnQqA4AySgZAcf17NJ3x8HKbYntIHjg+zK6rgwLUk
         p+uQtr+o/09poZehhMs5C0G+2m9VJRbwfr5Q3Kv68xREdXKxpFyVvBIH9KVHCYTuCqYc
         f0DPttRdfC6NLP2PVlrAiz4wOHLZLJK94HfxfdtMO7bN5gan5V0YW53Il3DcJOi8/hMR
         ABr1pZ1djg+WSTuJfEYh35r1rgQPrg7p5/3wOVR10TQOezrvJmlgM93n8W/hR8Jo86Pc
         DHQQ==
X-Gm-Message-State: AOJu0YzqcLx+o4TvpGxeH1F2Kfy/DNCZp4qGnvlTWeO3rWLiowFP2LVd
	Y2pZ7xrlxweGvrkddAtkSZ3Z17fN8GPA4EgDseTboamuaRWj/iHHFdcRnomJeRgHzAMtJEe5pYF
	JKRNiab59YgBzdz+7K6YMyRzVelFO8MbNOWbEyw==
X-Google-Smtp-Source: AGHT+IHBk1gz/7unXkcbRX0ispDcGOzxo95Sj1fIjT8QBjez3JdOabO8EbkxzpmQu0/sTgvS1wDEd8rggALFAfPV2yM=
X-Received: by 2002:a05:6a20:cd91:b0:1d9:1cea:2e3d with SMTP id
 adf61e73a8af0-1d96df145fdmr2888640637.40.1729609732623; Tue, 22 Oct 2024
 08:08:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011123222.1282936-1-pierre.gondois@arm.com>
 <20241011123222.1282936-2-pierre.gondois@arm.com> <CAKfTPtBo7Kny0r15ik07pMLCjETw7UQo=ypbXww22fMLHzQkgA@mail.gmail.com>
 <7dcb39bb-7647-4d54-a28f-4bebdf40b8e9@arm.com>
In-Reply-To: <7dcb39bb-7647-4d54-a28f-4bebdf40b8e9@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 22 Oct 2024 17:08:40 +0200
Message-ID: <CAKfTPtBw6MLuJoEF09airBXOFTEciM5Bd-inu5q1aNkVn+HTng@mail.gmail.com>
Subject: Re: [PATCH 1/1] sched/fair: Update blocked averages on tick
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Hongyan Xia <hongyan.xia2@arm.com>, 
	Chritian Loehle <christian.loehle@arm.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Oct 2024 at 11:47, Pierre Gondois <pierre.gondois@arm.com> wrote:
>
> Hello Vincent,
>
> On 10/15/24 14:44, Vincent Guittot wrote:
> > On Fri, 11 Oct 2024 at 14:32, Pierre Gondois <pierre.gondois@arm.com> wrote:
> >>
> >> The Energy Aware Scheduler (EAS) relies on CPU/tasks utilization
> >> signals. On an idle CPU, the blocked load is updated during
> >> load balancing.
> >>
> >> sd->balance_interval increases with the number of CPUs in the domain.
> >> On an Arm DynamIQ system, sched domains containing CPUs with the same
> >> capacity do not exist. On a Pixel6 with 4 little, 2 mid, 2 big CPUs:
> >> - sd->min_interval = 8
> >> - sd->min_interval = 16
> >>
> >> The balance interval is doubled if the system is balanced, meaning
> >> that a balanced system will likely update blocked load every 16ms.
> >
> > The real max boundary is LOAD_AVG_PERIOD that is used to update
> > nohz.next_blocked. This is the max between 2 updates of blocked load.
> > The other ones are opportunistics updates when a normal load balance
> > is triggered.
>
> I wanted to mean that on an idle CPU with ticks still on, the cfs_rq load
> is only updated through this path:
> sched_balance_trigger() {
>    if (time_after_eq(jiffies, rq->next_balance))
>      raise_softirq(SCHED_SOFTIRQ);
> }
>
> ...
>
> sched_balance_softirq()
> \-sched_balance_update_blocked_averages()
>
> If the next_balance happens every 16ms, this means feec() might operate
> its task placement using an (up to) 16ms old util signal. The CPU might

This is true for all idle CPUs and not only the local one with tick
still firing when idle

> thus look busier than what it actually is.

yes and it can be up to 32 ms because the real max limit between 2
updates is currently set to LOAD_AVG_PERIOD.  You can probably find a
unitary test on a board that takes advantage of some "random" update
during idle ticks but you will still have some old values on the
system and you don't have any control of their max period.

You could also reduce min_interval to a lower value but this will not
take care of other idle cpus

>
> >
> >>
> >> The find_energy_efficient_cpu() function might thus relies on outdated
> >> util signals to place tasks, leading to bad energy placement.
> >
> > Moving from 8ms to 16 ms is what makes the difference for you ?
>
> With this patch, the cfs_rq signal of an idle CPU is updated every tick,
> so every 4ms.

If the CPU is kept in the shallowest idle state then it is not
expected to stay for a long time which also means not that old
outdated value.

And what if the tick is 1ms or 10ms ?

>
> >
> > The LOAD_AVG_PERIOD mas period has been used as a default value but if
> > it's too long, we could consider changing the max period between 2
> > updates
> >
> >>
> >> Update blocked load on sched tick if:
> >> - the rq is idle
> >> - the load balancer will not be triggered.
> >>
> >> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> >> ---
> >>   kernel/sched/fair.c | 21 ++++++++++++++++-----
> >>   1 file changed, 16 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index 225b31aaee55..2f03bd10ac7a 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -9841,15 +9841,12 @@ static unsigned long task_h_load(struct task_struct *p)
> >>   }
> >>   #endif
> >>
> >> -static void sched_balance_update_blocked_averages(int cpu)
> >> +static void update_blocked_averages(struct rq *rq)
> >>   {
> >>          bool decayed = false, done = true;
> >> -       struct rq *rq = cpu_rq(cpu);
> >> -       struct rq_flags rf;
> >>
> >> -       rq_lock_irqsave(rq, &rf);
> >> -       update_blocked_load_tick(rq);
> >>          update_rq_clock(rq);
> >> +       update_blocked_load_tick(rq);
> >>
> >>          decayed |= __update_blocked_others(rq, &done);
> >>          decayed |= __update_blocked_fair(rq, &done);
> >> @@ -9857,6 +9854,18 @@ static void sched_balance_update_blocked_averages(int cpu)
> >>          update_blocked_load_status(rq, !done);
> >>          if (decayed)
> >>                  cpufreq_update_util(rq, 0);
> >> +}
> >> +
> >> +static void sched_balance_update_blocked_averages(int cpu)
> >> +{
> >> +       struct rq *rq = cpu_rq(cpu);
> >> +       struct cfs_rq *cfs_rq;
> >> +       struct rq_flags rf;
> >> +
> >> +       cfs_rq = &rq->cfs;
> >> +
> >> +       rq_lock_irqsave(rq, &rf);
> >> +       update_blocked_averages(rq);
> >>          rq_unlock_irqrestore(rq, &rf);
> >>   }
> >>
> >> @@ -12877,6 +12886,8 @@ void sched_balance_trigger(struct rq *rq)
> >>
> >>          if (time_after_eq(jiffies, rq->next_balance))
> >>                  raise_softirq(SCHED_SOFTIRQ);
> >> +       else if (idle_cpu(rq->cpu))
> >> +               update_blocked_averages(rq);
> >
> > would be good to explain why you don't need rq lock here
>
> This is a mistake, the lock is indeed required.

update_blocked_averages() can take time as we go through all cgroups
and interrupts are still disabled here whereas they are not during
softirq. Some already complained that running
update_blocked_averages() can impact the system latency that is why we
moved the update out of schedler path for the newly idle case for
example.

IMO, you should keep the update in the softirq and take advantage if
this tick to update other idle CPUs which don't have idle tick.

>
> >
> > There is no rate limit so we can do this every tick (possibly  1ms)
> > when staying in shallowest state
>
> I'm not sure we understood each other as this patch should no be related
> to NOHZ CPUs. So please let me know if I used a wrong path as you said,
> or if a rate limit would be needed.

If your problem is about too old pelt value for idle CPUs because the
load balance interval and the next_block period are too high then you
should fix it for all idle CPUs with the  next_block period probably

>
> >
> > So it's looks better to update the period between 2 update of blocked
> > load instead of adding a new path
> >
> >>
> >>          nohz_balancer_kick(rq);
> >>   }
> >> --
> >> 2.25.1
> >>
>
> Regards,
> Pierre

