Return-Path: <linux-kernel+bounces-575183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52666A6EFB4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 12:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DB52189C51B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575882561DE;
	Tue, 25 Mar 2025 11:10:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCC633EC
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742901005; cv=none; b=ffhVPCCDWsCk+4kYGf5HE0r4GgDf0shkyVd2TnSsZ6+OFsABRUhg8JtaD+fxXCOyuZ2Y3Y+m8Yfza6f0hKLbi7a1FnAOWnm8XtadH0FahVSefP7xC3iprNlKnESwC0mf7oDCyo8Kzb9z8qrIoYKQ5mPHQsmz2TParGSytSO+XNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742901005; c=relaxed/simple;
	bh=Mlo9nkuf8hVOFYgL7mLgOdK0xFR9i1nTldeCr0R6Aok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kt+ZhjUIAXQEkH26VXKYprOTdBo/A2CtFQxzfgmMzxmN6qlSkopQ6j+fTKloVOLOjQGeO3lqao1RUSolr2hOtdTCQqmlFHACYW7+Rl+aYuEO3cKWyZ7HBpQY3xcYi//m/ACwiS5bmVw/mpGMrMBr/gjxTUG1N5uezBSj+S0kTIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15BBE1756;
	Tue, 25 Mar 2025 04:10:09 -0700 (PDT)
Received: from [10.57.14.116] (unknown [10.57.14.116])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77D013F58B;
	Tue, 25 Mar 2025 04:10:00 -0700 (PDT)
Message-ID: <6b217eb3-f8f5-4a25-8fe9-550cc7a15a81@arm.com>
Date: Tue, 25 Mar 2025 12:09:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7 v5] sched/fair: Rework feec() to use cost instead of
 spare capacity
To: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, lukasz.luba@arm.com, rafael.j.wysocki@intel.com,
 linux-kernel@vger.kernel.org
Cc: qyousef@layalina.io, hongyan.xia2@arm.com, christian.loehle@arm.com,
 luis.machado@arm.com, qperret@google.com
References: <20250302210539.1563190-1-vincent.guittot@linaro.org>
 <20250302210539.1563190-4-vincent.guittot@linaro.org>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20250302210539.1563190-4-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Vincent,

On 3/2/25 22:05, Vincent Guittot wrote:
> feec() looks for the CPU with highest spare capacity in a PD assuming that
> it will be the best CPU from a energy efficiency PoV because it will
> require the smallest increase of OPP. Although this is true generally
> speaking, this policy also filters some others CPUs which will be as
> efficients because of using the same OPP.
> In fact, we really care about the cost of the new OPP that will be
> selected to handle the waking task. In many cases, several CPUs will end
> up selecting the same OPP and as a result using the same energy cost. In
> these cases, we can use other metrics to select the best CPU for the same
> energy cost.
> 
> Rework feec() to look 1st for the lowest cost in a PD and then the most
> performant CPU between CPUs. The cost of the OPP remains the only
> comparison criteria between Performance Domains.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>   kernel/sched/fair.c | 466 +++++++++++++++++++++++---------------------
>   1 file changed, 246 insertions(+), 220 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d3d1a2ba6b1a..a9b97bbc085f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c

[...]

>   
> -	if ((best_fits > prev_fits) ||
> -	    ((best_fits > 0) && (best_delta < prev_delta)) ||
> -	    ((best_fits < 0) && (best_actual_cap > prev_actual_cap)))
> -		target = best_energy_cpu;
> +		/* Add the energy cost of p */
> +		delta_nrg = task_util * min_stat.cost;

Not capping task_util to the target CPU's max capacity when computing energy
means this is ok to have fully-utilized CPUs.

Just to re-advertise what can happen with utilization values of CPUs that are
fully utilized:

On a Pixel6, placing 3 tasks with:
period=16ms, duty_cycle=100%, UCLAMP_MAX=700, cpuset=5,6
I.e. the tasks can run on one medium/big core. UCLAMP_MAX is set such as the
system doesn't become overutilized.

Tasks are going to bounce on the medium CPU as, if we follow one task:
1. The task will grow to reach a maximum utilization of ~340 (=1024/3 due to
the pressure of other tasks)
2. As the big CPU is less energy efficient than the medium CPU, the big CPU
will eventually reach an OPP where it will be better to run on the medium CPU
energy-wise
3. The task is migrated to the medium CPU. However the task can now grow
its utilization since there is no pressure from other tasks. So the
utilization of the task slowly grows.
4. The medium CPU reaches on OPP where it is more energy efficient to migrate
the task on the big CPU. We can go to step 1.

As the utilization is only a reflection of how much CPU time the task received,
util_avg depends on the #tasks/niceness of the co-scheduled tasks. Thus, it is
really hard to make any assumption based on this value. UCLAMP_MAX puts tasks
in the exact situation where util_avg doesn't represent the size of the task
anymore.

------

In this example, niceness is not taken into account, but cf. the other thread,
other scenarios could be created where the task placement is incorrect/un-stable.
EAS mainly relies on util_avg, so having correct task estimations should be the
priority.

------

As you and Christian I think briefly evoked as an idea, setting the SCHED_IDLE
policy to UCLAMP_MAX could maybe help. However, this implies:
1. not being able to set UCLAMP_MIN and UCLAMP_MAX at the same time for a task
Indeed, as someone might want to have SCHED_NORMAL for it UCLAMP_MIN task

2. not using feec() for UCLAMP_MAX tasks.
Indeed, SCHED_IDLE tasks will likely have wrong util_avg values since they don't
have much running time. So doing energy computation using these values would not
work.
Another advantage is that UCLAMP_MAX tasks will impact the util_avg of
non-UCLAMP_MAX tasks only lightly as their running time will be really low.
Balancing CPUs based on h_nr_idle rather than h_nr_runnable would also allow
to have ~the same number of UCLAMP_MAX tasks on all CPUs of the same
type/capacity.

------

At the risk of being a bit insistant, I don't see how UCLAMP_MAX tasks could
be placed using EAS. Either EAS or UCLAMP_MAX needs to change...

