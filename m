Return-Path: <linux-kernel+bounces-317180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 686EE96DA7F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77248B21557
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B3D19D068;
	Thu,  5 Sep 2024 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="pelCccCE"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CBC1E481
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 13:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725543432; cv=none; b=fDcmUOIWIduUq73JhbnPJFl+ysxVDF/wpWIfht4ixEMJOCEzIkRxQX7c2wkxZSCp3hi/vczb+PfR3rVuZZjSxGFn1o6B0wEq7p93RaMdAje2UF51j5D74VXSEQCdPpBYNIU2rfWUfb2naCn29eo+YADg1EF8t9bxYlLz+sZ1Z44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725543432; c=relaxed/simple;
	bh=xCF4SVAxGXNdrma6eHTvLtr2IUHOBO0DZvrhvql5vUM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MXSfA5O2v22Hx2xCd/beaBy3bjcZTtxxFJnKm/t/eQ8p1WCDBj4Kac4DNIaIrOXsMrQ8Z+7jvJ36yBNVctPcYw1U6HqLWTjSWTVpPjTgJ90+3G/1urkuw8l2WDsnTu0FJsgBaHgz4jyuj3IZdYyafU4vL4U2ozQRAve+hfvq+Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=pelCccCE; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1725543427;
	bh=xCF4SVAxGXNdrma6eHTvLtr2IUHOBO0DZvrhvql5vUM=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=pelCccCEmv6Mp/PlpzBq/PIHP7OljdJmXuMApbd5er5tNPk4NDzuJxrmUoJrF8sOm
	 GV87gRFRwwN/colBVBCXO855qduqfVEmsUbS19yqYk/NYSfUi2dcRfUIFHovTJTxWX
	 HD5CDx2P3V68rpUCyPc4V21Q7lk5xK02CV62TJVEiYR/V53GdlWoeiJw+12lZjdmJa
	 EoDJxL+WHUIzKK60Uv+SN7qL1yByLhhLSjGb+S0K8NvBWW2YbgqECZxTzGnohDG921
	 nMvUuu7bjuB2ixE+rU8ztCVl22J0FhK07G3zHdIH1K5jWhOawlERSH2xr7APLTb3dp
	 zMaaMdW+bnBYA==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4X00lR2MmRz1Jqd;
	Thu,  5 Sep 2024 09:37:07 -0400 (EDT)
Message-ID: <fb2b7e96-23b8-449e-93fe-88ee3ea167d1@efficios.com>
Date: Thu, 5 Sep 2024 09:36:49 -0400
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
 <1a1e06d4-7f41-4f37-a9b5-d1610e8d8669@efficios.com>
Content-Language: en-US
In-Reply-To: <1a1e06d4-7f41-4f37-a9b5-d1610e8d8669@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-09-04 14:28, Mathieu Desnoyers wrote:
> On 2024-09-04 11:50, Mathieu Desnoyers wrote:
>> On 2024-09-04 11:24, Yury Norov wrote:
> [...]
>>>
>>> This all doesn't look like a hot path. And anyways, speculating around
>>> performance without numbers on hands sounds cheap.
>>
>> This is done whenever userspace invokes sched_setaffinity, or changes
>> its cgroup cpuset. It may not be the most important fast-path in the
>> world, but I expect some workloads to issue sched_setaffinity whenever
>> they create a thread, so it's not a purely slow-path either.
>>
>>> In my experience, iterators with a very lightweight payload are ~100
>>> times slower comparing to dedicated bitmap ops. Check this for example:
>>> 3cea8d4753277.
>>>
>>> If you're really cared about performance here, I'd suggest you to
>>> compare your iterators approach with something like this:
>>>
>>>    cpumask_or(mm_allowed, mm_allowed, cpumask);
>>>    atomic_set(&mm->nr_cpus_allowed, cpumask_weight(mm_allowed);
> 
> Here are the benchmark results. Each test use two entirely filled
> bitmaps as input to mimic the common scenario for cpus allowed
> being updated with a subset of the original process CPUs allowed,
> and also the common case where the initial cpumask is filled.
> 
> #define BITMAP_LEN      (4096UL * 8 * 10)
> (len = BITMAP_LEN)
> 
> * Approach 1:
> 
>         int nr_set = 0;
>         for_each_andnot_bit(bit, bitmap, bitmap2, len)
>                 nr_set += !test_and_set_bit(bit, bitmap2);
>         if (nr_set)
>                 atomic_add(nr_set, &total);
> 
> Time: 4680 ns
> 
> * Approach 2:
> 
>         int nr_set = 0;
>         for_each_set_bit(bit, bitmap, len)
>                 nr_set += !test_and_set_bit(bit, bitmap2);
>         if (nr_set)
>                 atomic_add(nr_set, &total);
> 
> Time: 1791537 ns
> 
> * Approach 3:
> 
>         mutex_lock(&lock);
>         bitmap_or(bitmap2, bitmap, bitmap2, len);
>         atomic_set(&total, bitmap_weight(bitmap2, len));
>         mutex_unlock(&lock);
> 
> Time: 79591 ns

The benchmark result is wrong for approach 3, as it was taken with
CONFIG_PROVE_LOCKING=y and lockdep.

Corrected result:

Time: 4500 ns.

So let's go with your approach. I'm wondering whether I should
re-use an existing mutex/spinlock from mm_struct or add a new one.

Thanks,

Mathieu

> 
> The test hardware is a AMD EPYC 9654 96-Core Processor.
> 
> Thanks,
> 
> Mathieu
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


