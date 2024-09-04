Return-Path: <linux-kernel+bounces-315462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E42396C2FD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C944C1F25B77
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32A21E1321;
	Wed,  4 Sep 2024 15:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="X+lgpeCj"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359411E0B9A
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 15:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725465069; cv=none; b=XYAb3cHGThGlrdKz62C2518hGq6jU14etM3tkSSmOGuoA3/8x4e6bPq3gNFWfIZ5W/F0JThLtRr9VOw++lF0I/ew8SI6cwJOzeaOOh18H76LbrOiq+g1eRCNh+0qr1wHLNn0J+cNzqB94TexkfIGOVn1pFASkMKuzMR3XHpzk1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725465069; c=relaxed/simple;
	bh=Knj4c7gbofvuSfC2kaHCZZk/vjh0xw15WXSsCoVRd/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HNqOtV1D6i2JTGSXNqOlREu6DlcWCEbG3OmGOCNmYHSGxTMDoiFUvV3IT2OyWJAcfVnuSOT53OJQMh3F1HSDsYLeb7yeQEqQ+MqbGJ2WwYs8+7eN3MhWZZBN4sfsLwl6BVau7GWHMS7+tagnaF6CU7rpQQxDPXGnAJrTy4/0SWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=X+lgpeCj; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1725465064;
	bh=Knj4c7gbofvuSfC2kaHCZZk/vjh0xw15WXSsCoVRd/w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X+lgpeCjzYSXqolvCSyKhyxjiCwnMKr8lY7Tr4cW2Rmr7q4vCLXWR8eRe2SrNAeiM
	 x1+PiBdvaQ4WyNPDbvkt3uXILjvy0Oqh3hSMc64z0Nm2vI/mweTWdZu95xbn1TmVrG
	 5wU5Qg4oWpQqNSg7t5JEIHCaPQdrqXvuv2XgVUJenSPJvzS+BRB/MvWeKfoifdEWy6
	 SGmRFqe7FdLRzeFt2AE/qHAuAfJ8QRoSAr1MNjf4fDzLNPSTZB8ESDnRSsBMZ1gq1C
	 4hm1mawkpvlPcUYE3j3kgfFp+GJCsTViQAIMAZ6QDjiqoC36iRj7koSR3UNrb7V0Zn
	 9fya/b1Jw6MVA==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4WzRmS3C8bz1K6b;
	Wed,  4 Sep 2024 11:51:04 -0400 (EDT)
Message-ID: <46d08f8e-bd68-44a3-9b33-ba029c7e2a10@efficios.com>
Date: Wed, 4 Sep 2024 11:50:45 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] sched: Improve cache locality of RSEQ concurrency
 IDs for intermittent workloads
To: Yury Norov <yury.norov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org, Valentin Schneider <vschneid@redhat.com>,
 Mel Gorman <mgorman@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>
References: <20240903190650.53644-1-mathieu.desnoyers@efficios.com>
 <20240903190650.53644-3-mathieu.desnoyers@efficios.com>
 <ZtdqhmKmbVsCSAkJ@yury-ThinkPad>
 <615f169b-3b24-4661-8a2c-185c6d80f7a4@efficios.com>
 <Zth7tj9Cq-gigTx8@yury-ThinkPad>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <Zth7tj9Cq-gigTx8@yury-ThinkPad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-09-04 11:24, Yury Norov wrote:
> On Tue, Sep 03, 2024 at 07:22:37PM -0400, Mathieu Desnoyers wrote:
>> On 2024-09-03 15:59, Yury Norov wrote:
>>> On Tue, Sep 03, 2024 at 03:06:50PM -0400, Mathieu Desnoyers wrote:
>> [...]
>>>> +
>>>> +static inline void mm_set_cpus_allowed(struct mm_struct *mm, const struct cpumask *cpumask)
>>>> +{
>>>> +	struct cpumask *mm_allowed = mm_cpus_allowed(mm);
>>>> +	int cpu, nr_set = 0;
>>>> +
>>>> +	if (!mm)
>>>> +		return;
>>>> +	/* The mm_cpus_allowed is the union of each thread allowed CPUs masks. */
>>>> +	for (cpu = 0; cpu < nr_cpu_ids; cpu = cpumask_next_andnot(cpu, cpumask, mm_allowed)) {
>>>> +		if (!cpumask_test_and_set_cpu(cpu, mm_allowed))
>>>> +			nr_set++;
>>>> +	}
>>>
>>> You can do the same nicer:
>>>
>>>     for_each_cpu(cpu, cpumask)
>>>     	nr_set += !cpumask_test_and_set_cpu(cpu, mm_allowed);
>>>
>>> This should be faster and a bit simpler, to me.
>>
>> In this scenario, I expect the following per-thread cpumask properties for a
>> given process (typically): those will be typically the same bits
>> set repeated over all threads belonging to a process. There are of
>> course scenarios where specific threads will override the mask, but
>> I don't expect this to be the most frequent case.
>>
>> So we typically have an operation which initially copies the initial
>> thread's allowed cpus mask to the mm allowed cpus mask, and then when
>> additional affinity changes are done, we want to augment the mm allowed
>> cpus masks with any additional cpu that may show up. But again, I expect
>> the initial thread to typically have the complete mask and other
>> operations won't typically change the mm allowed cpumask bits.
>>
>> I also expect the cpumask to be often quite dense (often all bits
>> are set).
>>
>> Now if we look at the operations for your proposal here:
>>
>> - for_each_cpu loads cpumask word-by-word and for each set bit, it
>>    issues cpumask_test_and_set_cpu on mm_allowed, which is really a
>>    test_and_set_bit, a fully ordered atomic operation, on each _bit_
>>    set. That's O(nr_cpus) fully ordered atomic operations, and thus
>>    expensive exclusive cache line accesses.
> 
> Both versions are O(N).

Yes, those are both theoretically O(N), but the cost of
loading/comparing two words compared to the cost of an atomic
test-and-set of each bit within those words is far from being
the same.

>   
>> My approach does:
>>
>> - The equivalent of a for_each_cpu_andnot (actually I should use
>>    exactly that! I just noticed it exists in the API.), which loads
> 
> Yes, you should.
> 
>>    both thread and mm CPUs allowed masks in parallel, word-by-word,
>>    and only issues a cpumask_test_and_set_cpu for CPUs which are set
>>    in the per-thread mask, but not in the mm mask. In the typical cases
>>    discussed above, we pretty much never need to issue the atomic
>>    test-and-set. So all we need to do for the common case is to read
>>    both cpu masks in parallel, no stores/atomic ops needed.
> 
> This all doesn't look like a hot path. And anyways, speculating around
> performance without numbers on hands sounds cheap.

This is done whenever userspace invokes sched_setaffinity, or changes
its cgroup cpuset. It may not be the most important fast-path in the
world, but I expect some workloads to issue sched_setaffinity whenever
they create a thread, so it's not a purely slow-path either.

> In my experience, iterators with a very lightweight payload are ~100
> times slower comparing to dedicated bitmap ops. Check this for example:
> 3cea8d4753277.
> 
> If you're really cared about performance here, I'd suggest you to
> compare your iterators approach with something like this:
> 
>    cpumask_or(mm_allowed, mm_allowed, cpumask);
>    atomic_set(&mm->nr_cpus_allowed, cpumask_weight(mm_allowed);

AFAIU this approach would not work, or then we'd need some kind of
locking to make sure we don't have two concurrent cpumask updates
which happen to do a sequence of atomic_set which move the
nr_cpus_allowed value towards a smaller value due to ordering.

Also, AFAIU cpumask_or is not safe against concurrent updates, so
we'd need locking for that as well.

I'm fine providing performance numbers, but we need to make sure
the alternative we compare against actually works.

A "dedicated" bitmap op that would do what I need would do the
following:

- For each bit set in bitmap A, which are not set in bitmap B,
   atomically test-and-set those bits in bitmap B, and return the
   number of bits that transitioned from 0 to 1 for weighting
   purposes.

In my original attempts I tried using cpumask_weight after altering
the bitmap, but then noticed that it would not work without additional
locking.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


