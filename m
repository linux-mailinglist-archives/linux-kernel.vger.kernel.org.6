Return-Path: <linux-kernel+bounces-365810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D39A499EA35
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 925EA288470
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB9E1AF0A7;
	Tue, 15 Oct 2024 12:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AQ9cYTXX"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FF11AF0A3
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 12:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728996269; cv=none; b=kPbuFG2TqcY71fyUp8BJ+yAeuxCiHh7wuNMZ3kjriKMW09iWfParTNa42nc/pl+F4c42o5p/N3v42RHVrhR7U/d4eNpeymr2kVIPBSOCFlAiie00XpuAtWnrGlhANSHHhG0HwVib0Odaz5JXiUX/WOgzhOG50yabmZPFnmzFv3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728996269; c=relaxed/simple;
	bh=T8RSJR69mxHDUiIEjop3DqUxGi5B5AvodZnQs9oSpYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qdepXLfn7raYaAa+4Fqv8tcsoYI4SOgMEpSe9n4AhZw24/kLTtItIjxl2/I67UB+DGSlvrQikI7zGeeMpF+t8aGEnlATRPpmpwmWrBUd5teGFPRV7L/rOUjKaCb9XGfqxX0aTyYQMIgQzrfb/xXoGyNqCt8MVXfQCu0DKDcYeyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AQ9cYTXX; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e49ad46b1so2236714b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 05:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728996267; x=1729601067; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o4UVWgvFBlhC2COhu564Xh9g/hnGuzzU+FwXXtGqKz0=;
        b=AQ9cYTXXjryRDQTWniMkcFAuV+c7IESD0L3SFnBfwRJ44H6rNzvkJAEO0hYNqyoKDb
         fyWTFCSrMZDYUJLRR63WlhhP/WYfbimKeZsw4UVYNAeTCAOkGDYQrYgnnhVwivRentke
         /lkjdGIeRrfmcV7fLShlrogilHHkaW1q0f3reU+S/3jUtZmvfdJnHgXVDdhJE5pvS1Bz
         eaBGR28821UWx4e6a+4rgtgY49lL+36ZmbrqdfINjam83yh+hGeL3SVv9h+Jr0vt2RQt
         LljxQrgv1co9NEQbrkuyDEhNxLZOSDT3q27dJ7mRoZ33Juv6PKp1+41iq79u37rGvHvH
         nr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728996267; x=1729601067;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o4UVWgvFBlhC2COhu564Xh9g/hnGuzzU+FwXXtGqKz0=;
        b=RWpW54aQfVNX4HHGXsWdwuuSnky1bV8HdpmfpqeDLbKNeS6TFpccjZ/TjCOoQL5Vib
         ZWU6LRFsVwOm3kOTlZyaF1JHiB0D7U3DUs7i742nrX8heVJhRtc6apXAve9K+5RjaOcZ
         51C+o4JcDhwCZrpHWkR7t8b+ovxGp9nuU8n/JaYwRPxgn9AvlCzWbtGbYDQbWfruF/Yk
         8Qc7QyltE9bhhhCjnFKYV6qeRgdYYIg4WHaPS49eHQT/wPB6N2iLcq2ZurUDh2mpA9ej
         cHsxnWRNcj0vcDZ7xJS7M+ve+VgHfQrfnLizUYkOHMeO4Ob5PisLehdgZoCbBgHDnAMp
         mDVw==
X-Gm-Message-State: AOJu0YyxLigpORgmHlqzgj/YYW8bIauD/dYw/oGCagq0Qfyg7yZ3ELsd
	R23k+b4Ok6Q5WyeQNHnFAj8vvjfvOWsAhHMulQZgZSt/Yvj8idCDXIPVS5ik9belUqWEnRXaatS
	QXDD/PU9bDxE/tIxJcmzeu9X6ut4XiQvC3cHQ3A==
X-Google-Smtp-Source: AGHT+IGGfBF5GJ3rkzmesBcVBd4PZHZ1QdPDAspiW4Lqw9pi/PsT4GhC9RfyfTK7+rx1+l+elKcmpPd+qY9XaX/mK2s=
X-Received: by 2002:a05:6a00:9159:b0:71e:cf8:d6fa with SMTP id
 d2e1a72fcca58-71e7da61f1amr392455b3a.15.1728996266735; Tue, 15 Oct 2024
 05:44:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011123222.1282936-1-pierre.gondois@arm.com> <20241011123222.1282936-2-pierre.gondois@arm.com>
In-Reply-To: <20241011123222.1282936-2-pierre.gondois@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 15 Oct 2024 14:44:15 +0200
Message-ID: <CAKfTPtBo7Kny0r15ik07pMLCjETw7UQo=ypbXww22fMLHzQkgA@mail.gmail.com>
Subject: Re: [PATCH 1/1] sched/fair: Update blocked averages on tick
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Hongyan Xia <hongyan.xia2@arm.com>, 
	Chritian Loehle <christian.loehle@arm.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Oct 2024 at 14:32, Pierre Gondois <pierre.gondois@arm.com> wrote:
>
> The Energy Aware Scheduler (EAS) relies on CPU/tasks utilization
> signals. On an idle CPU, the blocked load is updated during
> load balancing.
>
> sd->balance_interval increases with the number of CPUs in the domain.
> On an Arm DynamIQ system, sched domains containing CPUs with the same
> capacity do not exist. On a Pixel6 with 4 little, 2 mid, 2 big CPUs:
> - sd->min_interval = 8
> - sd->min_interval = 16
>
> The balance interval is doubled if the system is balanced, meaning
> that a balanced system will likely update blocked load every 16ms.

The real max boundary is LOAD_AVG_PERIOD that is used to update
nohz.next_blocked. This is the max between 2 updates of blocked load.
The other ones are opportunistics updates when a normal load balance
is triggered.

>
> The find_energy_efficient_cpu() function might thus relies on outdated
> util signals to place tasks, leading to bad energy placement.

Moving from 8ms to 16 ms is what makes the difference for you ?

The LOAD_AVG_PERIOD mas period has been used as a default value but if
it's too long, we could consider changing the max period between 2
updates

>
> Update blocked load on sched tick if:
> - the rq is idle
> - the load balancer will not be triggered.
>
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  kernel/sched/fair.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 225b31aaee55..2f03bd10ac7a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9841,15 +9841,12 @@ static unsigned long task_h_load(struct task_struct *p)
>  }
>  #endif
>
> -static void sched_balance_update_blocked_averages(int cpu)
> +static void update_blocked_averages(struct rq *rq)
>  {
>         bool decayed = false, done = true;
> -       struct rq *rq = cpu_rq(cpu);
> -       struct rq_flags rf;
>
> -       rq_lock_irqsave(rq, &rf);
> -       update_blocked_load_tick(rq);
>         update_rq_clock(rq);
> +       update_blocked_load_tick(rq);
>
>         decayed |= __update_blocked_others(rq, &done);
>         decayed |= __update_blocked_fair(rq, &done);
> @@ -9857,6 +9854,18 @@ static void sched_balance_update_blocked_averages(int cpu)
>         update_blocked_load_status(rq, !done);
>         if (decayed)
>                 cpufreq_update_util(rq, 0);
> +}
> +
> +static void sched_balance_update_blocked_averages(int cpu)
> +{
> +       struct rq *rq = cpu_rq(cpu);
> +       struct cfs_rq *cfs_rq;
> +       struct rq_flags rf;
> +
> +       cfs_rq = &rq->cfs;
> +
> +       rq_lock_irqsave(rq, &rf);
> +       update_blocked_averages(rq);
>         rq_unlock_irqrestore(rq, &rf);
>  }
>
> @@ -12877,6 +12886,8 @@ void sched_balance_trigger(struct rq *rq)
>
>         if (time_after_eq(jiffies, rq->next_balance))
>                 raise_softirq(SCHED_SOFTIRQ);
> +       else if (idle_cpu(rq->cpu))
> +               update_blocked_averages(rq);

would be good to explain why you don't need rq lock here

There is no rate limit so we can do this every tick (possibly  1ms)
when staying in shallowest state

So it's looks better to update the period between 2 update of blocked
load instead of adding a new path

>
>         nohz_balancer_kick(rq);
>  }
> --
> 2.25.1
>

