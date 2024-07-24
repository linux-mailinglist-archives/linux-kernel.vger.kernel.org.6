Return-Path: <linux-kernel+bounces-260806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F9F93AEBC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 11:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFD4B282EF4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165621527A2;
	Wed, 24 Jul 2024 09:18:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4BA1514F1
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 09:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721812714; cv=none; b=WUm5o12kDwDXIL9oF+u0XeVLCGteaOh87PxR7lW1OvZxBQm07ylCuTDVhap9IWYFk9i5pAjIRRcN59JA0claltCKIXCrLzkeUmkz3EQL7/vm9ZGKncXE9SYDE32pvmh0ZA+Yy1FS7gEN22k/CKCkE29mFfSkRET0g+BjXddruTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721812714; c=relaxed/simple;
	bh=rfZhVABh7Wwe/ShFSDEEQpF4tUG76ECljQ5DJBVFcXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jj7ei5FV2DOTGtQoM7IaqodUGgz7tv8NYW3lCSQzJAsy+Y4gKQSymNiGNPm6By+Kgi7u3o/1MRwN7eKMXWy/YDNuJ5j4YP5WBye5aOV+j/KwPvyPsh84D9fD1n3tVNzDA9628W/btqNUS34hhr+bctuo9Urd42Gqw9PqoBlJ594=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB5A2106F;
	Wed, 24 Jul 2024 02:18:57 -0700 (PDT)
Received: from [192.168.178.110] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 89B103F5A1;
	Wed, 24 Jul 2024 02:18:30 -0700 (PDT)
Message-ID: <b4e2158e-01bf-47c4-b3cb-b43c726855a6@arm.com>
Date: Wed, 24 Jul 2024 11:18:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/fair: Remove cfs_rq::nr_spread_over and
 cfs_rq::exec_clock
To: Peter Zijlstra <peterz@infradead.org>
Cc: Chuyi Zhou <zhouchuyi@bytedance.com>, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, rostedt@goodmis.org,
 bsegall@google.com, chengming.zhou@linux.dev, linux-kernel@vger.kernel.org,
 Vishal Chourasia <vishalc@linux.ibm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>
References: <20240720031928.406540-1-zhouchuyi@bytedance.com>
 <d4ac0022-5ba4-44b9-ac09-4530a18b0974@arm.com>
 <20240724080109.GN26750@noisy.programming.kicks-ass.net>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <20240724080109.GN26750@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/07/2024 10:01, Peter Zijlstra wrote:
> On Tue, Jul 23, 2024 at 10:47:22PM +0200, Dietmar Eggemann wrote:
>> On 20/07/2024 05:19, Chuyi Zhou wrote:
>>> nr_spread_over tracks the number of instances where the difference
>>> between a scheduling entity's virtual runtime and the minimum virtual
>>> runtime in the runqueue exceeds three times the scheduler latency,
>>> indicating significant disparity in task scheduling.
>>> Commit 5e963f2bd465 ("sched/fair: Commit to EEVDF") removed its usage.
>>>
>>> cfs_rq->exec_clock was used to account for time spent executing tasks.
>>> Commit 5d69eca542ee ("sched: Unify runtime accounting across classes")
>>> removed its usage.
>>
>> I was under the impression this commit removed
>> 'schedstat_add(cfs_rq->exec_clock, delta_exec)' from update_curr() by
>> mistake?
>>
>> That's why I sent out this patch back in May:
>>
>> https://lkml.kernel.org/r/20240503104605.1871571-1-dietmar.eggemann@arm.com
>>
>> to add it back.
> 
> Probably an accident yes. Is that exec_clock thing useful though? I
> mean, I don't much care either way around.
> 
> I had a previous version of this patched lined up, but its easy enough
> to press 'dd' on it.

Not terrible useful I suppose. I had one testcase where I thought it
would be useful to compare those numbers back in May. This was the time
when I realized that .exec_clock stays 0.

But this was the only time I used it. So I'm fine with removing it. Our
ultimate goal should be anyway to reduce the amount of this mildly
useful stuff in this area.

