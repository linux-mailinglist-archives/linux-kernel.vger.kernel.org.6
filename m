Return-Path: <linux-kernel+bounces-408309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BD89C7D3B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 21:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7012F1F22EE0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 20:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6262076D2;
	Wed, 13 Nov 2024 20:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="h2JHZc3p"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B212064E9
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 20:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731531549; cv=none; b=aMa0M4/0S9NF+92JPZVfWC4lGHp51JmLMzYagx3djuWBQBLbEz8UEcyE7MC84YLG2FXzGbY08QVdrYMYvWWdfdT9a55EMXBYBL70w7/smlG9MOBbZLCNosLilGHEoJgFPfoH40XboaIOxjTFuJGmbxKg3jnj8YeufnG6fXNgSWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731531549; c=relaxed/simple;
	bh=nXz4+smFNWIZ8AnQq1LA9CBs1j2n+MIDJQ9ss1mVUdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NR2kNQ4pKsD4+rv3+aO3NHZV5tEdr31L7L3Boruy1DZOQMHZvHp2G3lmZhZmtXNiF1Ku97AKV6TlnxsjNurgWkokUIVTh8gBW1pp7xl68qfZlAYBY6aQJyF8VrO5AXUQlX25+GquGwS1npWm0+x1HdhYZHd385RIXn5f996PFO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=h2JHZc3p; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1731531544;
	bh=nXz4+smFNWIZ8AnQq1LA9CBs1j2n+MIDJQ9ss1mVUdA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h2JHZc3pVKNkCWMquPVmnyDLMg/F4R4IaGQMbmGRuG/z2pnRwDHizFaWiP3fDo7RK
	 zfvh2SVSLH3RN0CcuBkgzLdLN+TbVdOJIsAS8oKShLF+6I0KHPhFgWBr4/RAbzqqlS
	 8q2kgTw6eR2RWK2figKkV9TmqvKoy2ikyaKakjctoOKmTSb7OX/p12PXmD3Ia4D2YA
	 ji6r6TVtjWAyE5Wq2uqeiPaFY468K0UNak8P2eCTeGONlrrGkY7pnlTPqEmTfkcfk2
	 UR9Jn/dVzGx6pmYxBVg4R/mTMDTIZD7LWuF3JFYu/zqobAwXH6bYYZpd1rlggNB5mS
	 4y0/cZc59SSGw==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XpbHX4vF0zS2M;
	Wed, 13 Nov 2024 15:59:04 -0500 (EST)
Message-ID: <6397d90f-1236-40e8-af8f-d89174ea1d11@efficios.com>
Date: Wed, 13 Nov 2024 15:57:40 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] Scheduler time slice extension
To: Prakash Sangappa <prakash.sangappa@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 Daniel Jordan <daniel.m.jordan@oracle.com>
References: <20241113000126.967713-1-prakash.sangappa@oracle.com>
 <20241113185013.GA22571@noisy.programming.kicks-ass.net>
 <f0f681a0-22b4-45f4-85a1-18f140286cbe@efficios.com>
 <896BA407-E19C-4CEB-BF5E-9707543BA365@oracle.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <896BA407-E19C-4CEB-BF5E-9707543BA365@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-11-13 15:10, Prakash Sangappa wrote:
> 
> 
>> On Nov 13, 2024, at 11:36 AM, Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>>
>> On 2024-11-13 13:50, Peter Zijlstra wrote:
>>> On Wed, Nov 13, 2024 at 12:01:22AM +0000, Prakash Sangappa wrote:
>>>> This patch set implements the above mentioned 50us extension time as posted
>>>> by Peter. But instead of using restartable sequences as API to set the flag
>>>> to request the extension, this patch proposes a new API with use of a per
>>>> thread shared structure implementation described below. This shared structure
>>>> is accessible in both users pace and kernel. The user thread will set the
>>>> flag in this shared structure to request execution time extension.
>>> But why -- we already have rseq, glibc uses it by default. Why add yet
>>> another thing?
>>
>> Indeed, what I'm not seeing in this RFC patch series cover letter is an
>> explanation that justifies adding yet another per-thread memory area
>> shared between kernel and userspace when we have extensible rseq
>> already.
> 
> It mainly provides pinned memory, can be useful for  future use cases where updating user memory in kernel context can be fast or needs to avoid pagefaults.

Does the targeted use-case (scheduler time slice extension) require
pinned memory, or just future use-cases ?

Does having a missing time slice extension hint for a short while in
case of high memory pressure (rseq page swapped out) have any measurable
impact compared to the overhead of the page faults which will be
happening in case of the high memory pressure required to trigger this
scenario ?

> 
>>
>> Peter, was there anything fundamentally wrong with your approach based
>> on rseq ? https://lore.kernel.org/lkml/20231030132949.GA38123@noisy.programming.kicks-ass.net
>>
>> The main thing I wonder is whether loading the rseq delay resched flag
>> on return to userspace is too late in your patch. Also, I'm not sure it is
>> realistic to require that no system calls should be done within time extension
>> slice. If we have this scenario:
> 
> I am also not sure if we need to prevent system calls in this scenario.

I suspect that if we prohibit system calls from being issued from a
delay-resched userspace critical section, then loading the delay-resched
rseq flag on return to userspace is always fine, because the kernel only
reschedules on return from interrupt or trap.

But I see this no-syscall restriction as being very cumbersome for
userspace.

> Was that restriction mainly because of restartable sequence API implements it?

I suspect that this restriction is just to avoid loading the
delay-resched flag from the scheduler when reschedule is called
from an interrupt handler nested over a system call for preemptible
kernels, but Peter could tell us more.

One open question here is whether we want to pin memory for
each thread in the system to hold this shared data between
userspace and the scheduler. AFAIU, this is a trade-off between
slice extension accuracy in high memory usage scenarios and
pinned memory footprint impact. If the tradeoff goes towards
making this memory pinned, then we may want to consider pinning
the per-thread rseq area on rseq registration.

Another option to consider is to use rseq to index a userspace
per-cpu data structure, which will be used as shared memory
between kernel and userspace. Userspace could store this
delay-resched flag into the current CPU's shared data, and
the scheduler could load it from there. If pinning per-cpu
data is more acceptable than pinning per-thread data, then
it could be an improvement.

This could be a new ABI between kernel and userspace, e.g.:

struct rseq_percpu_area {
     __u32 sched_state;	/* includes time slice extension flag. */
     char end[];
};

Registered to the kernel with the following parameters:

- Address of rseq_percpu_area for CPU 0,
- The stride of the per-cpu indexing (see librseq mempool per-cpu
   allocator [1]),
- offsetof(struct rseq_percpu_area, end) to have the feature size
   for extensibility.

Thanks,

Mathieu

[1] https://lpc.events/event/18/contributions/1720/attachments/1572/3268/presentation-lpc2024-rseq-mempool.pdf

> 
> -Prakash
> 
>>
>> A) userspace grabs lock
>>    - set rseq delay resched flag
>> B) syscall
>>    - reschedule
>>     [...]
>>    - return to userspace, load rseq delay-resched flag from userspace (too late)
>>
>> I would have thought loading the delay resched flag should be attempted much
>> earlier in the scheduler code. Perhaps we could do this from a page fault
>> disable critical section, and accept that this hint may be a no-op if the
>> rseq page happens to be swapped out (which is really unlikely). This is
>> similar to the "on_cpu" sched state rseq extension RFC I posted a while back,
>> which needed to be accessed from the scheduler:
>>
>>   https://lore.kernel.org/lkml/20230517152654.7193-1-mathieu.desnoyers@efficios.com/
>>   https://lore.kernel.org/lkml/20230529191416.53955-1-mathieu.desnoyers@efficios.com/
>>
>> And we'd leave the delay-resched load in place on return to userspace, so
>> in the unlikely scenario where it is swapped out, at least it gets paged
>> back at that point.
>>
>> Feel free to let me know if I'm missing an important point and/or saying
>> nonsense here.
>>
>> Thanks,
>>
>> Mathieu
>>
>> -- 
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> https://www.efficios.com
>>
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


