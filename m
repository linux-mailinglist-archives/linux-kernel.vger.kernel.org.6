Return-Path: <linux-kernel+bounces-536456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D94D7A47FCC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C62D1883581
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D592922FF4F;
	Thu, 27 Feb 2025 13:42:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6491D22F17B
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 13:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663723; cv=none; b=t4VO8g1QbWX3uzWgRD0F3xIelEJyU7jYe/ovODcj9C9OOL6Z7ZCZD259hLYzyMwNXORjm5G+H9k9BTD4wEukSlRxKSDWYH/xFNLHnwSIMIDB5X23GsApblWt7qrUMmgJe6inMJUaOJgPKCrMEE3UPJYzxkJ+q8RxYJcJUxJl0fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663723; c=relaxed/simple;
	bh=FqkVZ9N5sVxtHT/0IiVOXSX2gSGdJkAYfTI8YOUrb2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=baMQ7JYY5AS/w8nz3CTFuWQBqbRLLNnxb0EdqkjC9zxHN6St6T14lf1NTpoAqMKNN1IQ1Q7PsWz6jDmxZxKfs5rbtw2MzqhagBPuAnyMcgX6Rpvorz1TFXRA6U/8XfXBzm7FuBkYWtrDe6lZsTQ5DXRM9IUIW+Ic9HjWW8wTARE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1076C2BCA;
	Thu, 27 Feb 2025 05:42:15 -0800 (PST)
Received: from [10.57.36.78] (unknown [10.57.36.78])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A27F43F5A1;
	Thu, 27 Feb 2025 05:41:55 -0800 (PST)
Message-ID: <c507c4ce-25c8-45d2-ad27-53ade0a58d40@arm.com>
Date: Thu, 27 Feb 2025 13:41:53 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] sched/fair: Prevent from cpufreq not being updated
 when delayed-task is iowait
To: Christian Loehle <christian.loehle@arm.com>,
 Xuewen Yan <xuewen.yan@unisoc.com>, peterz@infradead.org, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 Pierre Gondois <pierre.gondois@arm.com>, Luis Machado <luis.machado@arm.com>
Cc: rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, ke.wang@unisoc.com, di.shen@unisoc.com,
 xuewen.yan94@gmail.com, linux-kernel@vger.kernel.org
References: <20250226114301.4900-1-xuewen.yan@unisoc.com>
 <7e3b656e-ea65-4441-b08f-062eb0501355@arm.com>
Content-Language: en-US
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <7e3b656e-ea65-4441-b08f-062eb0501355@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/02/2025 12:08, Christian Loehle wrote:
> On 2/26/25 11:43, Xuewen Yan wrote:
>> Because the sched-delayed task maybe in io-wait state,
>> so we should place the requeue_delayed_entity() after the
>> cpufreq_update_util(), to prevent not boosting iowait cpufreq
>> before return.
>>
>> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
>> ---
>>   kernel/sched/fair.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 2d6d5582c3e9..040674734128 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6931,11 +6931,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>   	if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & ENQUEUE_RESTORE))))
>>   		util_est_enqueue(&rq->cfs, p);
>>   
>> -	if (flags & ENQUEUE_DELAYED) {
>> -		requeue_delayed_entity(se);
>> -		return;
>> -	}
>> -
>>   	/*
>>   	 * If in_iowait is set, the code below may not trigger any cpufreq
>>   	 * utilization updates, so do it here explicitly with the IOWAIT flag
>> @@ -6944,6 +6939,11 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>   	if (p->in_iowait)
>>   		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
>>   
>> +	if (flags & ENQUEUE_DELAYED) {
>> +		requeue_delayed_entity(se);
>> +		return;
>> +	}
>> +
>>   	if (task_new && se->sched_delayed)
>>   		h_nr_runnable = 0;
>>   
> 
> I understand that iowait cpufreq update isn't happening now (and that's a bug),
> but if we reorder we may call cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT)
> followed by the cpufreq_update_util() in update_load_avg() of
> requeue_delayed_entity()
> 	update_load_avg()
> 		cpufreq_update_util()
> 
> and the latter will likely be dropped by the governor, so the update
> won't include util of the (re)-enqueuing task, right?
> 
> I'll give it some more thought.

True, but I think the code was like this before anyway. On the 
non-delayed path, the problem you mentioned still exists. Not saying 
this is the right thing, but just saying this is what it has always been 
like.

