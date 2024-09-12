Return-Path: <linux-kernel+bounces-326994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 250EA976F98
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7281285CE4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E466D1B1402;
	Thu, 12 Sep 2024 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="pZEv7G/h"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9BC17C9B3
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 17:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726162487; cv=none; b=rvJ3j1YwmjfFJKomS186QM5y8OYtn28mMOQan+xNGVTKqMlrHVPP9rjquJKOQOH0X0bVuJuxbuoeYcX2O+4zUixpiNbd1raV4Hxq0DPn/OIx6t5OlC3uC20eTN4pSKU7kp16zVvycLKlmQX549jgiR46TpT3pvjl1ERVtu8DI6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726162487; c=relaxed/simple;
	bh=20ONqV9OHgHhjNQ/3/YCB8bQQrGkG1HMsFG2b060IiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PSnMfSs9SkkPwG6KeABmmyfxgfgmD4x5lS9qS6jkvH33CsIQWlMIGTaP0QltS4nzCzMSkgrkAMJzJB/lGSPC9ycFhpdT3Tg9lCTx0mfBYl0yPP0ibs7UUW3AHHhl2FRFB7vk9sMTCXjV3E86NXzFWEy1XcIbQAe5FjawUBwjQm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=pZEv7G/h; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1726162476;
	bh=20ONqV9OHgHhjNQ/3/YCB8bQQrGkG1HMsFG2b060IiM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pZEv7G/hFBKm4+5yowYcGCvOwfixrMmvrhuIZzssz8rdnRCNe4cvq8KbpiupnmgPp
	 SNLPjvJXEnwvqusPJSAaZ0WKU19NRRmKuM+yC4ZtxNFiJMZJdH+hwzULXPQFH7yX7I
	 NAUO2Wzr83b/R7ysGfgtqWIEwRMIX89UlBaXxsAyQzL6/9SJLFKmYWQDnNxoQSsTIc
	 6MpEBmEIKLEJxExtNkkvYgdAObDptDAgIdl5aol7XniZJpgVbleb4gHlHbdsC79Dxr
	 tLPkkY2Vbx7eAiJhZpILq9ne3kC3I7v7VEfprWqdwmhoLD+fHtFHnrDR1Ob5VVPktU
	 k+vgw6z4/yRaQ==
Received: from [192.168.0.178] (unknown [109.183.98.80])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4X4PhB3kLLz1LKJ;
	Thu, 12 Sep 2024 13:34:34 -0400 (EDT)
Message-ID: <0edc398e-d193-4c2d-907e-f5db93143f79@efficios.com>
Date: Thu, 12 Sep 2024 07:33:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] sched: Improve cache locality of RSEQ concurrency
 IDs for intermittent workloads
To: Marco Elver <elver@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org, Valentin Schneider <vschneid@redhat.com>,
 Mel Gorman <mgorman@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Dmitry Vyukov <dvyukov@google.com>
References: <20240909211506.326648-1-mathieu.desnoyers@efficios.com>
 <20240909211506.326648-2-mathieu.desnoyers@efficios.com>
 <CANpmjNMjndyBAO3HKHkC+v7zNZv1XHvH5Fjd9S5q0Jj-sEkx-w@mail.gmail.com>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <CANpmjNMjndyBAO3HKHkC+v7zNZv1XHvH5Fjd9S5q0Jj-sEkx-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-09-12 12:38, Marco Elver wrote:
> On Mon, 9 Sept 2024 at 23:15, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> commit 223baf9d17f25 ("sched: Fix performance regression introduced by mm_cid")
>> introduced a per-mm/cpu current concurrency id (mm_cid), which keeps
>> a reference to the concurrency id allocated for each CPU. This reference
>> expires shortly after a 100ms delay.
>>
>> These per-CPU references keep the per-mm-cid data cache-local in
>> situations where threads are running at least once on each CPU within
>> each 100ms window, thus keeping the per-cpu reference alive.
> 
> One orthogonal idea that I recall: If a thread from a different thread
> group (i.e. another process) was scheduled on that CPU, the CID can
> also be invalidated because the caches are likely polluted. Fixed
> values like 100ms seem rather arbitrary and it may work for one system
> but not another.

That depends on the cache usage pattern of the different thread group:
it's also possible that the other thread group does not perform that
many stores to memory before the original thread group is scheduled
back, thus keeping the cache content untouched.

The ideal metric there would probably be based on PMU counters, but
I doubt we want to go there.

[...]
> 
> I like the simpler and more general approach vs. the NUMA-only
> approach! Attempting to reallocate the previously assigned CID seems
> to go a long way.

Indeed it does!

> 
> However, this doesn't quite do L3-awareness as mentioned in [1], right?
> What I can tell is that this patch improves cache locality for threads
> scheduled back on the _same CPU_, but not if those threads are
> scheduled on a _set of CPUs_ sharing the _same L3_ cache. So if e.g. a
> thread is scheduled from CPU2 to CPU3, but those 2 CPUs share the same
> L3 cache, that thread will get a completely new CID and is unlikely to
> hit in the L3 cache when accessing the per-CPU data.
> 
> [1] https://github.com/google/tcmalloc/issues/144#issuecomment-2307739715
> 
> Maybe I missed it, or you are planning to add it in future?

In my benchmarks, I noticed that preserving cache-locality at the L1 and
L2 levels was important as well.

I would like to understand better the use-case you refer to for L3
locality. AFAIU, this implies a scenario where the scheduler migrates
a thread from CPU 2 to CPU 3 (both with the same L3), and you would
like to migrate the concurrency ID along.

When the number of threads is < number of mm allowed cpus, the
migrate hooks steal the concurrency ID from CPU 2 and moves it to
CPU 3 if there is only a single thread from that mm on CPU 2, which
does what you wish.

When the number of threads is >= number of mm allowed cpus, the
migrate hook is skipped, and the concurrency ID from CPU 2 is
left in place, favoring cache locality at L1/L2 levels. In that
case it's the scheduler's decision to migrate the thread from
CPU 2 to CPU 3, so I would think improving the scheduler decisions
about migration and minimizing thread movement would be more
relevant than trying to optimize concurrency ID movement.

But I may not be fully understanding your use-case.

> 
> In any case, the current patch is definitely an improvement:
> 
> Acked-by: Marco Elver <elver@google.com>

Thanks a lot for your feedback!

Mathieu

> 
> Thanks,
> -- Marco

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


