Return-Path: <linux-kernel+bounces-427807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F769E0675
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AC2EBA221F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED4320013D;
	Mon,  2 Dec 2024 15:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ZmrkIN6s"
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4CD1FCF6B
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 15:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733151721; cv=none; b=EaN7jaiwPtCIFCOT7d3/aCRMSHMID+NaPlRn0ZMhf4sQsX6kCjD/6RG+poRIry7215nuKAPrWMIC5lipwVgQnT5LtCXGshpc4wy8Bj2NosByJJXZhEmdF71WP6VpEUcfsTFDqB48sopOgq7HqlJQ8a3vr3BXwuqhc679idx0AFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733151721; c=relaxed/simple;
	bh=nGPG/Vcjoft/iNxGDHuUEa1hc+0dmpqhRpjO9bSlPYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=X+z9VhwtnwkGipOch4mDTOya9hgiiXYCWBnb1DizHVAbuatoPadXCt4HP34IszK3n0eM0aPnyHx2QrT5r6sUhngejXNg4PQE0pxs+jHWxLNYru3F0pqrl1aSM7wnUMgz6EyzgHT4MjIKsHzpKRq010xQjFao0g+wUb1fJzQw6j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=ZmrkIN6s; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1733151718;
	bh=nGPG/Vcjoft/iNxGDHuUEa1hc+0dmpqhRpjO9bSlPYc=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=ZmrkIN6splAe0hlW8vsVtTspUjTgK1fjH/TmC82l1WtlMUzBG2pLY5OA7fizDu6so
	 pd4udl8UUw1pzN9QUeAQ/MpbcRR0bmIpzObVrXbl2miR2rMJ0xYL2sBFJ4p4dW5iQF
	 Sqm/dlyyHlay1xfvYEqjgubhIeIjT+iv4Fy7TWsg5hwH78AktUakXwEX5NhVCttKv3
	 pjMTt9hUkszZHIv6dYVjGCve8SdO77v9leG3MTxRYO/WjIWtRn3K12UH/0tatAs1jj
	 77RuD9GmXwA/KuluGG9rjLgn6IOi+z8ywtxdZNRedwu6ATAoJYmuME8BC55jFGoKii
	 xZCfr6CswNKDQ==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Y26Sj6xS7zTY9;
	Mon,  2 Dec 2024 10:01:57 -0500 (EST)
Message-ID: <21a18b1c-b5ae-410c-8d1f-3b63358b0e61@efficios.com>
Date: Mon, 2 Dec 2024 10:01:57 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched: Optimise task_mm_cid_work duration
To: Gabriele Monaco <gmonaco@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20241202140735.56368-1-gmonaco@redhat.com>
 <20241202140735.56368-2-gmonaco@redhat.com>
 <c9a39d2e-6829-4bc5-b560-347ee79ff2e8@efficios.com>
 <6b7b30528893b091b21a06ead610709219cd9ba0.camel@redhat.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <6b7b30528893b091b21a06ead610709219cd9ba0.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-12-02 09:56, Gabriele Monaco wrote:
> Hi Mathieu,
> 
> thanks for the quick reply.
> 
>> Thanks for looking into this. I understand that you are after
>> minimizing the
>> latency introduced by task_mm_cid_work on isolated cores. I think
>> we'll need
>> to think a bit harder, because the proposed solution does not work:
>>
>>    * for_each_cpu_from - iterate over CPUs present in @mask, from @cpu
>> to the end of @mask.
>>
>> cpu is uninitialized. So this is completely broken.
> 
> My bad, wrong macro.. Should be for_each_cpu
> 
>> Was this tested
>> against a workload that actually uses concurrency IDs to ensure it
>> does
>> not break the whole thing ? Did you run the rseq selftests ?
>>
> 
> I did run the stress-ng --rseq command for a while and didn't see any
> error reported, but it's probably not bulletproof. I'll use the
> selftests for the next iterations.
> 
>> Also, the mm_cidmask is a mask of concurrency IDs, not a mask of
>> CPUs. So
>> using it to iterate on CPUs is wrong.
>>
> 
> Mmh I get it, during my tests I was definitely getting better results
> than using the mm_cpus_allowed mask, but I guess that was a broken test
> so it just doesn't count..
> Do you think using mm_cpus_allowed would make more sense, with the
> /risk/ of being a bit over-cautious?

mm_cpus_allowed can be updated dynamically by setting cpu affinity
and changing the cpusets. If we change the iteration from each possible
cpus to allowed cpus, then we need to adapt the allowed cpus updates
with the associated updates to the mm_cid as well. This is adding
complexity.

I understand that you wish to offload this task_work to a non-isolated
CPU (non-RT). If you do so, do you really care about the duration of
task_mm_cid_work enough to justify the added complexity to the
cpu affinity/cpusets updates ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


