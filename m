Return-Path: <linux-kernel+bounces-549050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 961B0A54C8B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B43753AB001
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E9D6A33F;
	Thu,  6 Mar 2025 13:48:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3091E4AE
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 13:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741268924; cv=none; b=hSHA6tYOo9AAnv03WP/iUgxkdU6ZAvcCXQ0FuN7h5Xs3fhAY82lKoq2Pl+o9VPMHHETTL0U4SAF3HZZrVzAtqIs7wRPxyRzVn1K2AqGGCGH4SRVYQamwAtwAIE6QAD8hSkwbDZ845MTpddTd/otSpGKU9FlkVvfgkPaKOr3PKWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741268924; c=relaxed/simple;
	bh=M6TSQlbH1dkl/KSBHfVrPekuOJPeJ05EoArISbOEECE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pHsCqIBJxycis03XqbkBNSZ39toRpS4nxAo/aBCG5+iqHYyloZqDcND7HOEd5Cb6+1pxJfqJlGuRm/VTb9f1VDGREOE99Hf3+AG3OrNGoV/+vGsCTqLDEaJAQ5dxie8Kq42yV7DHz3Mih4pyXG5J3Ch6ZPDVPP/ik5dCPDtxsd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 186DA1007;
	Thu,  6 Mar 2025 05:48:54 -0800 (PST)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C3823F673;
	Thu,  6 Mar 2025 05:48:39 -0800 (PST)
Message-ID: <0dcf8ac1-29ec-44e8-80ef-4c0f4a6d34e7@arm.com>
Date: Thu, 6 Mar 2025 14:48:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/uclamp: Let each sched_class handle uclamp
To: Hongyan Xia <hongyan.xia2@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org
References: <84441660bef0a5e67fd09dc3787178d0276dad31.1740664400.git.hongyan.xia2@arm.com>
 <4394f2a7-b4e8-419a-a299-f1afa560c944@arm.com>
 <e123524c-8c27-4ee7-8799-10931375712f@arm.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <e123524c-8c27-4ee7-8799-10931375712f@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/03/2025 11:53, Hongyan Xia wrote:
> On 05/03/2025 18:22, Dietmar Eggemann wrote:
>> On 27/02/2025 14:54, Hongyan Xia wrote:
>>
>> [...]
>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 857808da23d8..7e5a653811ad 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -6941,8 +6941,10 @@ enqueue_task_fair(struct rq *rq, struct
>>> task_struct *p, int flags)
>>>        * Let's add the task's estimated utilization to the cfs_rq's
>>>        * estimated utilization, before we update schedutil.
>>>        */
>>> -    if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags
>>> & ENQUEUE_RESTORE))))
>>> +    if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags
>>> & ENQUEUE_RESTORE)))) {
>>> +        uclamp_rq_inc(rq, p);
>>>           util_est_enqueue(&rq->cfs, p);
>>> +    }
>>
>> So you want to have p uclamp-enqueued so that its uclamp_min value
>> counts for the cpufreq_update_util()/cfs_rq_util_change() calls later in
>> enqueue_task_fair?
>>
>>    if (p->in_iowait)
>>      cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
>>
>>    enqueue_entity() -> update_load_avg() -> cfs_rq_util_change() ->
>>    cpufreq_update_util()
>>
>> But if you do this before requeue_delayed_entity() (1) you will not
>> uclamp-enqueue p which got his ->sched_delayed just cleared in (1)?
> 
> Sorry I'm not sure I'm following. The only condition of the
> uclamp_rq_inc() here should be
> 
>     if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags &
> ENQUEUE_RESTORE))))
> 
> Could you elaborate why it doesn't get enqueued?

Let's say 'p->se.sched_delayed = 1' and we are in

enqueue_task()

  enqueue_task_fair()

    if (!(p->se.sched_delayed && ...)

      uclamp_rq_inc(rq, p);

So p wouldn't be included here.

But then p would be requeued in

      requeue_delayed_entity(se)

since you removed the uclamp_rq_inc() from enqueue_task() (after the
p->sched_class->enqueue_task) p will not be considered for uclamp.

[...]

