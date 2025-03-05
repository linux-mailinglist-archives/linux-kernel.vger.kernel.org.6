Return-Path: <linux-kernel+bounces-546381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9244A4F9E2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0E216E0A3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75763204F82;
	Wed,  5 Mar 2025 09:24:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948D52040A9
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 09:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741166648; cv=none; b=esz8WFnxXdgO35TZbvb7O71J1LRjBkqSflR6RoXL1xyXn49/ToZ3d/Z6T5srUSy3Z3L3qkBFLsca49zV+DJqd6u3wofaw5Tw27jb3wOaJP6t8rP6lPKYtX18RM3HMOyF3lAK9ICnlBq4w9p+p+dHAF5XtcM8lTZR2NoWCrp7COQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741166648; c=relaxed/simple;
	bh=UmY0T/Mbt1Sjuam6l7DCpjDOFDwzesP2bbeFqXrsEf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=shbaO+GHuXLEsc9U5gqFkFrBUnRfw2IDOGvFNF7Z3I/Ij13P0oB8CPyAA+y29Xd5KeugyT6C5vqpxwdzUKZpLbhP8s0+Fr+Y6Bo42O3aFvGOs4Juczl5AZQVrh3MnDv9yKU8WChXdT0Zd7I6BrGqNlbb5aoeeUvB+e1BLKaGnas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31DABFEC;
	Wed,  5 Mar 2025 01:24:19 -0800 (PST)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 171743F66E;
	Wed,  5 Mar 2025 01:24:03 -0800 (PST)
Message-ID: <f1bf21e6-4fd3-4f97-b28f-b0e8dc37ff91@arm.com>
Date: Wed, 5 Mar 2025 10:23:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] sched/fair: Fix invalid pointer dereference in
 child_cfs_rq_on_list()
To: Vincent Guittot <vincent.guittot@linaro.org>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 riel@surriel.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, odin@uged.al, linux-kernel@vger.kernel.org
References: <20250304170007.245261-1-aboorvad@linux.ibm.com>
 <CAKfTPtCJKkwFeMKUrD3o224Nz4N+1qjtq0LvL945k9tJ8t8h-g@mail.gmail.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <CAKfTPtCJKkwFeMKUrD3o224Nz4N+1qjtq0LvL945k9tJ8t8h-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/03/2025 09:21, Vincent Guittot wrote:
> On Tue, 4 Mar 2025 at 18:00, Aboorva Devarajan <aboorvad@linux.ibm.com> wrote:
>>
>> In child_cfs_rq_on_list(), leaf_cfs_rq_list.prev is expected to point to
>> a valid cfs_rq->leaf_cfs_rq_list in the hierarchy. However, when accessed
>> from the first node in a list, leaf_cfs_rq_list.prev can incorrectly point
>> back to the list head (rq->leaf_cfs_rq_list) instead of another
>> cfs_rq->leaf_cfs_rq_list.
>>
>> The function does not handle this case, leading to incorrect pointer
>> calculations and unintended memory accesses, which can result in a kernel
>> crash.
>>
>> A recent attempt to reorder fields in struct rq exposed this issue by
>> modifying memory offsets and affecting how pointer computations are
>> resolved. While the problem existed before, it was previously masked by
>> specific field arrangement. The reordering caused erroneous pointer
>> accesses, leading to a NULL dereference and a crash, as seen in the

I'm running tip/sched/core on arm64 and I still only see the wrong
pointer for 'prev_cfs_rq->tg->parent' in the 'prev ==
&rq->leaf_cfs_rq_list' case?

...
cpu=5 prev_cfs_rq->tg=ffff00097efb63a0 parent=0000000000000010
cfs_rq->tg=ffff000802084000
...

>> following trace:
>>
>> [    2.152852] Call Trace:
>> [    2.152855] __update_blocked_fair+0x45c/0x6a0 (unreliable)
>> [    2.152862] sched_balance_update_blocked_averages+0x11c/0x24c
>> [    2.152869] sched_balance_softirq+0x60/0x9c
>> [    2.152876] handle_softirqs+0x148/0x3b4
>> [    2.152884] do_softirq_own_stack+0x40/0x54
>> [    2.152891] __irq_exit_rcu+0x18c/0x1b4
>> [    2.152897] irq_exit+0x20/0x38
>> [    2.152903] timer_interrupt+0x174/0x30c
>> [    2.152910] decrementer_common_virt+0x28c/0x290
>> [    2.059873] systemd[1]: Hostname set to ...
>> [    2.152682] BUG: Unable to handle kernel data access on read at 0x100000125
>> [    2.152717] Faulting instruction address: 0xc0000000001c0270
>> [    2.152724] Oops: Kernel access of bad area, sig: 7 [#1]
>> ..
>>
>> To fix this, introduce a check to detect when prev points to the list head
>> (&rq->leaf_cfs_rq_list). If this condition is met, return early to prevent
>> the use of an invalid prev_cfs_rq.
>>
>> Fixes: fdaba61ef8a2 ("sched/fair: Ensure that the CFS parent is added after unthrottling")
>> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
>> ---
>>  kernel/sched/fair.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 1c0ef435a7aa..a4daa7a9af0b 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -4045,12 +4045,15 @@ static inline bool child_cfs_rq_on_list(struct cfs_rq *cfs_rq)
>>  {
>>         struct cfs_rq *prev_cfs_rq;
>>         struct list_head *prev;
>> +       struct rq *rq;
>> +
>> +       rq = rq_of(cfs_rq);
>>
>>         if (cfs_rq->on_list) {
>>                 prev = cfs_rq->leaf_cfs_rq_list.prev;
>> +               if (prev == &rq->leaf_cfs_rq_list)
>> +                       return false;
> 
> what about the else case below , prev can also point to rq->leaf_cfs_rq_list

Should be the same issue IMHO. I'm not seeing it on my machine  during
startup or while doing simple taskgroup tests though, 'cfs_rq->on_list'
is always 1 so far.

>>         } else {
>> -               struct rq *rq = rq_of(cfs_rq);
>> -
>>                 prev = rq->tmp_alone_branch;
>>         }
>>
>> --
>> 2.43.5
>>


