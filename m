Return-Path: <linux-kernel+bounces-192228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAE78D1A56
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B52A1C22DA3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0951A16C86F;
	Tue, 28 May 2024 11:53:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96A616C841
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 11:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716897208; cv=none; b=SVke/ioJDZZnskGlXDt7osz8BRS5l7kQ2yW3E7CzOjzzLz9btqSyYDqpscdlZJ7fVg6t+kkZ96YwK30Isjry4gB2adHJ2PkXkfoiI2JtW3LlIqjuag4ftZrJbm7BTgsrsjq0GMJbsEdRIZKZ1aV6o3b14mao8eYz3quYfXvluDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716897208; c=relaxed/simple;
	bh=EKRHtF39qAzZAiGhtZHJfZ9j4Jhv419BJMQlTmihAhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aFwHRdD8yrLjYUi95rf46NwODBLlif0aEVcHX4Bj29HZZL0hkdDRP6sHk1fu7mZkU+qyfb2TdMREcEsjUK7BImNhQCege/fmKSHLp2/YJ1AuOHerKvw4OsP3zye6aBDGwvz58g06EXAj/FuoJeY9JU0jhKzgVJDOvIxKCnbRV24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E36D3339;
	Tue, 28 May 2024 04:53:48 -0700 (PDT)
Received: from [10.1.36.57] (e133649.arm.com [10.1.36.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D5573F641;
	Tue, 28 May 2024 04:53:21 -0700 (PDT)
Message-ID: <687a6cda-3c7d-480c-90bc-0987cf48ac7a@arm.com>
Date: Tue, 28 May 2024 12:53:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 6/6] Propagate negative bias
To: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>
Cc: Qais Yousef <qyousef@layalina.io>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Christian Loehle <christian.loehle@arm.com>, pierre.gondois@arm.com,
 linux-kernel@vger.kernel.org
References: <cover.1715082714.git.hongyan.xia2@arm.com>
 <f60a29ac1af5098e0d37d426aec27db05d5d43e1.1715082714.git.hongyan.xia2@arm.com>
 <e308fbfc-d016-4362-998e-e4810321b53a@arm.com>
Content-Language: en-US
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <e308fbfc-d016-4362-998e-e4810321b53a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/05/2024 23:53, Dietmar Eggemann wrote:
> On 07/05/2024 14:50, Hongyan Xia wrote:
>> Negative bias is interesting, because dequeuing such a task will
>> actually increase utilization.
>>
>> Solve by applying PELT decay to negative biases as well. This in fact
>> can be implemented easily with some math tricks.
>>
>> Signed-off-by: Hongyan Xia <hongyan.xia2@arm.com>
>> ---
>>   kernel/sched/fair.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 0177d7e8f364..7259a61e9ae5 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -4863,6 +4863,45 @@ static inline unsigned long task_util_est_uclamp(struct task_struct *p)
>>   {
>>   	return max(task_util_uclamp(p), _task_util_est_uclamp(p));
>>   }
>> +
>> +/*
>> + * Negative biases are tricky. If we remove them right away then dequeuing a
>> + * uclamp_max task has the interesting effect that dequeuing results in a higher
>> + * rq utilization. Solve this by applying PELT decay to the bias itself.
>> + *
>> + * Keeping track of a PELT-decayed negative bias is extra overhead. However, we
>> + * observe this interesting math property, where y is the decay factor and p is
>> + * the number of periods elapsed:
>> + *
>> + *	util_new = util_old * y^p - neg_bias * y^p
>> + *		 = (util_old - neg_bias) * y^p
>> + *
>> + * Therefore, we simply subtract the negative bias from util_avg the moment we
>> + * dequeue, then the PELT signal itself is the total of util_avg and the decayed
>> + * negative bias, and we no longer need to track the decayed bias separately.
>> + */
>> +static void propagate_negative_bias(struct task_struct *p)
>> +{
>> +	if (task_util_bias(p) < 0 && !task_on_rq_migrating(p)) {
>> +		unsigned long neg_bias = -task_util_bias(p);
>> +		struct sched_entity *se = &p->se;
>> +		struct cfs_rq *cfs_rq;
>> +
>> +		p->se.avg.util_avg_bias = 0;
>> +
>> +		for_each_sched_entity(se) {
>> +			u32 divider, neg_sum;
>> +
>> +			cfs_rq = cfs_rq_of(se);
>> +			divider = get_pelt_divider(&cfs_rq->avg);
>> +			neg_sum = neg_bias * divider;
>> +			sub_positive(&se->avg.util_avg, neg_bias);
>> +			sub_positive(&se->avg.util_sum, neg_sum);
>> +			sub_positive(&cfs_rq->avg.util_avg, neg_bias);
>> +			sub_positive(&cfs_rq->avg.util_sum, neg_sum);
>> +		}
>> +	}
> 
> So you remove the 'task bias = clamp(util_avg, uclamp_min, uclamp_max) -
> util_avg' from the se and cfs_rq util_avg' in case it's negative. I.e.
> if the task is capped hard.
> 
> Looks like this is the old issue that PELT has blocked contribution
> whereas uclamp does not (runnable only).
> 
> What's the rationale behind this? Is it because the task didn't get the
> runtime it needed so we can remove this (artificially accrued) util_avg?
> 
> Normally we wouldn't remove blocked util_avg and let it rather decay
> periodically for cfs_rq's and at wakeup for tasks.

Sorry I may not have understood what you asked.

PELT has decaying effect whereas uclamp does not, so you will have the 
effect that dequeuing a task will immediately remove the bias, but 
util_avg won't be immediately gone.

In the case of uclamp_max, assuming an always-running task with 
uclamp_max of 200, which means util_avg 1024 and util_avg_bias of -824. 
The moment this task is dequeued, the rq uclamp util will immediately go 
from 200 to 1024, and then 1024 slowly decay to 0. This patch is to 
mitigate this effect, so that it will just decay from 200 to 0 without 
spiking to 1024 first.

Hopefully this answers your question.

> [...]

