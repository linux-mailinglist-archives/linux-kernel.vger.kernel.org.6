Return-Path: <linux-kernel+bounces-315743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEB996C666
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62F591C25202
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4CE1E132C;
	Wed,  4 Sep 2024 18:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="IRqWWEoA"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFB01CC8A2
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 18:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725474508; cv=none; b=KO/XWJuKjWVSrAIcBEQd6yNDyZexH4kuglZ6IH9ch3jZwDaZfio/zK7EoQ3vPX0RTStmFzZM5jt19nRaOgIV/Zx+X5Cgto0Dozinem2KHzn8QlHFIYpFNj6Wt2QeeM4LOlw+N/zPUNR6Y5M6nLV9BqZH7MsueIWMCJA55cdgToc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725474508; c=relaxed/simple;
	bh=Qd8VgL2Ks5KdercZ70zIRXfs890LWeESMa/nViFKg2Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rfELt+7tLdajrTNPvyjmxzxI7OqEA4R4N92JCJjHtc9DUp6XAIbW3CY0LeCpKBEJi2o1+ru/LsO4/6rJX0pUes3gnEfZXvcR6GhVo8IsLV6hFA9zfksElQBLWVhSCWk+0a54HN77dLjohcc5oX1RfBOf1IE4tCPy5iLDpK782tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=IRqWWEoA; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1725474504;
	bh=Qd8VgL2Ks5KdercZ70zIRXfs890LWeESMa/nViFKg2Q=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=IRqWWEoA6ezJnBGZ+/07sDvr/EEmhcL4YIQafTeeypAObAzxN7SV/qrkDIwoYv/mY
	 sjC9g0GfMCGv9arSIYVgN6fUmWAGbIQEw/DlAEFORuuIw2ccNbyS1/XMLrVxxsgVQv
	 WF0Xz3bnCwW08cUXJ87QUg0+ydUhQGrADATD4Gz2hQHgN1fRj6Eu2wLnz2uFQ//oNd
	 WkjGJ5MqxZ2rLT2V3sS+y53r1F5X6+v8QF6PgmUsEcbs/PC8ulim5CzuLJ8mdNUhtY
	 0Yr4udNPMRasOfnwdaZUwS5142wILrS2glMaaiu9lj9/skPdpioNzjt05C+QGrSrsQ
	 O8yVcP5EJDHcg==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4WzWG035Mwz1Jpw;
	Wed,  4 Sep 2024 14:28:24 -0400 (EDT)
Message-ID: <1a1e06d4-7f41-4f37-a9b5-d1610e8d8669@efficios.com>
Date: Wed, 4 Sep 2024 14:28:05 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] sched: Improve cache locality of RSEQ concurrency
 IDs for intermittent workloads
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
 <46d08f8e-bd68-44a3-9b33-ba029c7e2a10@efficios.com>
Content-Language: en-US
In-Reply-To: <46d08f8e-bd68-44a3-9b33-ba029c7e2a10@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-09-04 11:50, Mathieu Desnoyers wrote:
> On 2024-09-04 11:24, Yury Norov wrote:
[...]
>>
>> This all doesn't look like a hot path. And anyways, speculating around
>> performance without numbers on hands sounds cheap.
> 
> This is done whenever userspace invokes sched_setaffinity, or changes
> its cgroup cpuset. It may not be the most important fast-path in the
> world, but I expect some workloads to issue sched_setaffinity whenever
> they create a thread, so it's not a purely slow-path either.
> 
>> In my experience, iterators with a very lightweight payload are ~100
>> times slower comparing to dedicated bitmap ops. Check this for example:
>> 3cea8d4753277.
>>
>> If you're really cared about performance here, I'd suggest you to
>> compare your iterators approach with something like this:
>>
>>    cpumask_or(mm_allowed, mm_allowed, cpumask);
>>    atomic_set(&mm->nr_cpus_allowed, cpumask_weight(mm_allowed);

Here are the benchmark results. Each test use two entirely filled
bitmaps as input to mimic the common scenario for cpus allowed
being updated with a subset of the original process CPUs allowed,
and also the common case where the initial cpumask is filled.

#define BITMAP_LEN      (4096UL * 8 * 10)
(len = BITMAP_LEN)

* Approach 1:

        int nr_set = 0;
        for_each_andnot_bit(bit, bitmap, bitmap2, len)
                nr_set += !test_and_set_bit(bit, bitmap2);
        if (nr_set)
                atomic_add(nr_set, &total);

Time: 4680 ns

* Approach 2:

        int nr_set = 0;
        for_each_set_bit(bit, bitmap, len)
                nr_set += !test_and_set_bit(bit, bitmap2);
        if (nr_set)
                atomic_add(nr_set, &total);

Time: 1791537 ns

* Approach 3:

        mutex_lock(&lock);
        bitmap_or(bitmap2, bitmap, bitmap2, len);
        atomic_set(&total, bitmap_weight(bitmap2, len));
        mutex_unlock(&lock);

Time: 79591 ns

So approach 1 is 382 times faster than approach 2, and 17 times
faster than approach 3. And this is only single-threaded,
I expect approaches 2&3 to perform even worse when contended
due to the many fully ordered test_and_set_bit (2) and due to
locking (3).

The test hardware is a AMD EPYC 9654 96-Core Processor.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


