Return-Path: <linux-kernel+bounces-200900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 624C78FB635
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F9691C257FC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0410E149C57;
	Tue,  4 Jun 2024 14:50:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101BC131BDF
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717512605; cv=none; b=imdmMxLBGSye3hqh7zS+Ux5aBdxophdPQZ7hrBeWfQ75UmQbbyrXgisuXhXwf5rEK6laV1xA7+8z5UJnsU/5lFTQrcARs56iDNqkM8mxkWwvUx21PladpbEZ84OsTCtzoR7qCtlKAQxXmGgjpGUf/IfIqxk1SBf2poiBLB4IOpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717512605; c=relaxed/simple;
	bh=huKcX3lPoc8fKuCqpvmJ1ahklxAHYZy+1BpmtBD+6VE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AKgNY8ogsMSihpk9/ezkdnKd8OPz47lKt8+wdIumyflngcb5Eq4xGeCOOp7dGA3A6rFUr/kprM67lBb5lzA9a0jDH2fY0ZyUasFQC3Vxm+2BC6bhN3XFsoQJJ7aK/g0yrbgo0cjlrpYrCbgOgu/AVJMIcmnDyR/jxaX4gXY37/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC8921042;
	Tue,  4 Jun 2024 07:50:27 -0700 (PDT)
Received: from [10.1.37.57] (e133649.arm.com [10.1.37.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 011163F762;
	Tue,  4 Jun 2024 07:50:00 -0700 (PDT)
Message-ID: <8052b12a-98ac-4309-8286-a330315d531b@arm.com>
Date: Tue, 4 Jun 2024 15:49:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH 08/10] sched/fair: Implement delayed dequeue
To: Luis Machado <luis.machado@arm.com>, Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
 linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com, tglx@linutronix.de, efault@gmx.de, nd
 <nd@arm.com>, John Stultz <jstultz@google.com>
References: <20240405110010.631664251@infradead.org>
 <3888d7c8-660e-479c-8c10-8295204e5f36@arm.com>
 <1461277e-af68-41e7-947c-9178b55810b1@arm.com>
 <20240425104220.GE21980@noisy.programming.kicks-ass.net>
 <20240425114949.GH12673@noisy.programming.kicks-ass.net>
 <20240426093241.GI12673@noisy.programming.kicks-ass.net>
 <c6152855-ef92-4c24-a3f5-64d4256b6789@arm.com>
 <2fba04b0-e55e-41f4-8b7a-723734fe1ad2@arm.com>
 <20240529225036.GN40213@noisy.programming.kicks-ass.net>
 <7eac0774-0f9d-487c-97b6-ab0e85f0ae3a@arm.com>
 <20240604101107.GO26599@noisy.programming.kicks-ass.net>
 <24e09046-74ee-4ebb-ac1a-bdc84568e825@arm.com>
Content-Language: en-US
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <24e09046-74ee-4ebb-ac1a-bdc84568e825@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/06/2024 15:23, Luis Machado wrote:
> On 6/4/24 11:11, Peter Zijlstra wrote:
>> On Mon, Jun 03, 2024 at 08:30:43PM +0100, Luis Machado wrote:
>>
>>> Exchanging some information with Hongyan today, he was a bit suspicious of the uclamp
>>> behavior with the eevdf complete series applied.
>>>
>>> Checking the uclamp code, I see we have some refcounting tied to enqueuing/dequeuing
>>> of tasks, and the uclamp values are organized in buckets.
>>>
>>> Just for fun I added a few trace_printk's in uclamp_eff_value, uclamp_rq_inc_id and
>>> uclamp_rq_dec_id.
>>>
>>> Booting up the system with delayed_dequeue disabled and running the benchmark, I
>>> see the uclamp bucket management pretty stable. Tasks get added to the uclamp
>>> buckets but then get removed. At the end of the benchmark, the uclamp buckets
>>> are (almost always) clean of tasks.
>>>
>>> Enabling delayed dequeue, I can see the uclamp buckets slowly filling up with
>>> tasks. At the end of the benchmark, I see uclamp buckets with 30, 40 or 50
>>> tasks still. If I do another run, I can see 80, 100 tasks still.
>>>
>>> I suspect refcounting might be going wrong somewhere due to delayed dequeue
>>> tasks, but that's more of a guess right now. Hopefully that is useful
>>> information. I'll resume investigation tomorrow.
>>
>> Thank you both!!
>>
>> Does the below help?
>>
>> Note how dequeue_task() does uclamp_rq_dec() unconditionally, which is
>> then not balanced in the case below.
>>
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -3664,6 +3664,7 @@ static int ttwu_runnable(struct task_str
>>   			/* mustn't run a delayed task */
>>   			SCHED_WARN_ON(task_on_cpu(rq, p));
>>   			enqueue_task(rq, p, ENQUEUE_DELAYED);
>> +			uclamp_rq_inc(rq, p);
>>   		}
>>   		if (!task_on_cpu(rq, p)) {
>>   			/*
> 
> As Hongyan pointed out in a separate message, the above makes things
> worse, as we end up with even more leftover tasks in the uclamp
> buckets.
> 
> I'm trying a fix in kernel/sched/core.c:enqueue_task that only
> calls uclamp_rq_inc if the task is not sched_delayed, so:
> 
> -       uclamp_rq_inc(rq, p);
> +       if (!p->se.sched_delayed)
> +         uclamp_rq_inc(rq, p);
> 
> I'm not entirely sure it is correct, but it seems to fix things,
> but I'm still running some tests.

This seems to so far not trigger any WARN or bad behavior in my tests.

> 
> With the current code, given uclamp_rq_inc and uclamp_rq_dec get
> called in enqueue_task and dequeue_task, the additional enqueue_task
> call from ttwu_runnable for a delayed_dequeue task may do an additional
> unconditional call to uclamp_rq_inc, no?

