Return-Path: <linux-kernel+bounces-294316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE225958C23
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 18:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ACA82856D6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC231ABEBD;
	Tue, 20 Aug 2024 16:23:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40988190671
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 16:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724170991; cv=none; b=vA/EdaI8ZgHxU+VfHpF9ogJ1wvKBTje4918/+wiSW1h2rAYOTz7/RYJdG+IyOMUD906oGVlo8vg92OGjjRbhclk9mjdoTbbrJMGm2HMeIY1ST1gI98siAFm3BV++4HskPi8dd+0ejd0Y+odS0GDFpVqVeLX5jCVOHwVcx6VY9Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724170991; c=relaxed/simple;
	bh=LOGGOqz4c+rzqgfRib/PGPrQddfX/jFaBc3ab7Twwac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e2bmgq5TVmKPD5dWSUUF5xcItZNdgqp1bC/JNXTPdab9kS/6iMm/jtErfL2ciP1Jk0+jmZfe4mFV0wAtfgOtgaZwFputSRN4bEBUzcFA1t5Z1Ac3FLtanXbWTvFcsxw0sHLRoolPs1MYcGZC2tz5WOWaRnrTM0ryf6uL/MsrUOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40D98DA7;
	Tue, 20 Aug 2024 09:23:33 -0700 (PDT)
Received: from [10.57.47.46] (unknown [10.57.47.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3AE313F73B;
	Tue, 20 Aug 2024 09:23:05 -0700 (PDT)
Message-ID: <7ed142f6-ec00-4cd2-ac26-eff198d6a4d4@arm.com>
Date: Tue, 20 Aug 2024 17:23:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/24] sched/uclamg: Handle delayed dequeue
To: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
 youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de,
 Luis Machado <luis.machado@arm.com>
References: <20240727102732.960974693@infradead.org>
 <20240727105029.315205425@infradead.org>
Content-Language: en-US
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <20240727105029.315205425@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/07/2024 11:27, Peter Zijlstra wrote:
> Delayed dequeue has tasks sit around on the runqueue that are not
> actually runnable -- specifically, they will be dequeued the moment
> they get picked.
> 
> One side-effect is that such a task can get migrated, which leads to a
> 'nested' dequeue_task() scenario that messes up uclamp if we don't
> take care.
> 
> Notably, dequeue_task(DEQUEUE_SLEEP) can 'fail' and keep the task on
> the runqueue. This however will have removed the task from uclamp --
> per uclamp_rq_dec() in dequeue_task(). So far so good.
> 
> However, if at that point the task gets migrated -- or nice adjusted
> or any of a myriad of operations that does a dequeue-enqueue cycle --
> we'll pass through dequeue_task()/enqueue_task() again. Without
> modification this will lead to a double decrement for uclamp, which is
> wrong.
> 
> Reported-by: Luis Machado <luis.machado@arm.com>
> Reported-by: Hongyan Xia <hongyan.xia2@arm.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   kernel/sched/core.c |   16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1676,6 +1676,9 @@ static inline void uclamp_rq_inc(struct
>   	if (unlikely(!p->sched_class->uclamp_enabled))
>   		return;
>   
> +	if (p->se.sched_delayed)
> +		return;
> +
>   	for_each_clamp_id(clamp_id)
>   		uclamp_rq_inc_id(rq, p, clamp_id);
>   
> @@ -1700,6 +1703,9 @@ static inline void uclamp_rq_dec(struct
>   	if (unlikely(!p->sched_class->uclamp_enabled))
>   		return;
>   
> +	if (p->se.sched_delayed)
> +		return;
> +
>   	for_each_clamp_id(clamp_id)
>   		uclamp_rq_dec_id(rq, p, clamp_id);
>   }
> @@ -1979,8 +1985,12 @@ void enqueue_task(struct rq *rq, struct
>   		psi_enqueue(p, (flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED));
>   	}
>   
> -	uclamp_rq_inc(rq, p);
>   	p->sched_class->enqueue_task(rq, p, flags);
> +	/*
> +	 * Must be after ->enqueue_task() because ENQUEUE_DELAYED can clear
> +	 * ->sched_delayed.
> +	 */
> +	uclamp_rq_inc(rq, p);

Apart from the typo in the title, this is a notable functional change.

Both classes that support uclamp update the CPU frequency in 
enqueue_task(). Before, a task that have uclamp_min will immediately 
drive up the frequency the moment it is enqueued. Now, driving up the 
frequency is delayed until the next util update.

I do not yet have evidence suggesting this is quantitatively bad, like 
first frame drops, but we might want to keep an eye on this, and switch 
back to the old way if possible.

>   
>   	if (sched_core_enabled(rq))
>   		sched_core_enqueue(rq, p);
> @@ -2002,6 +2012,10 @@ inline bool dequeue_task(struct rq *rq,
>   		psi_dequeue(p, flags & DEQUEUE_SLEEP);
>   	}
>   
> +	/*
> +	 * Must be before ->dequeue_task() because ->dequeue_task() can 'fail'
> +	 * and mark the task ->sched_delayed.
> +	 */
>   	uclamp_rq_dec(rq, p);
>   	return p->sched_class->dequeue_task(rq, p, flags);
>   }
> 
> 

