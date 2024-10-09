Return-Path: <linux-kernel+bounces-356143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B373995CF7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 03:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2071D1C2197A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 01:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198122D05D;
	Wed,  9 Oct 2024 01:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="O8B216Hv"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD59D18C31
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 01:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728437424; cv=none; b=iIf3ug86RPK0nmd2oZr4MjRlyhVmkctsZRLv0tDLMBHi32LD/JxNZnifBkiFVX0UmYa8eGuIa6Gn/SAKEPLPPf8HediUPTir5ajF03RIc7IZFYfZzJsLdbLWgw3X8Af4fRd4qa6zgvTZqApsqEz1yLndD04V3lwd/h9yP+xGyIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728437424; c=relaxed/simple;
	bh=wgJvcaQxhKTiHtRrxNIY/mEUxwtdDN6LGFLeFPCcf2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Edszs4mmFktfDZqO+4sFXG98o87z94QjB9M2uZSCJj0A/YlR3VP3KmhAKQqGjBBXhm1shpOrm06zfLTWtlKS6liuYsyt6xm35slwGIx9S5WHeyAAhnlZojtPoEbDHn7lgg8jiswtLklqw4+cQgnUKvO0NsNbQbS8htXTzusU0bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=O8B216Hv; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728437421;
	bh=wgJvcaQxhKTiHtRrxNIY/mEUxwtdDN6LGFLeFPCcf2c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=O8B216HvXU9NgRsbrDmn7IjnjUFHg6k6JVMPVaoZw2AUtRvla7UmPe4v/xudh1pZN
	 SYKIElDD787MCFgv98206L8BTJ6IzD6/WDjw1WfKxuP15OF0jCqySnaBEcfPln+VxL
	 +r2bEJEab3dIiDino97YKysu/qL8rfJJss/xEQhaaR3LHE3mc/j9F8mf5cnyQ+mJYL
	 iVommqE2/HTr9wzDvpQclke0JLWhoWeJSZ6a+kmrNetqzWLRUONS29CwCkjl21qaaT
	 AlWzAvxRIf+TFvHDpnSV7kR4NCtDA3IQGHjpJ+RScsunX+7KHVjdnv2NMi95FydDcg
	 3dvWUvPSqOW5A==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XNb194MRRzSQD;
	Tue,  8 Oct 2024 21:30:21 -0400 (EDT)
Message-ID: <a4563c3b-4c15-42eb-9376-525520e4dbdc@efficios.com>
Date: Tue, 8 Oct 2024 21:28:24 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] selftests/rseq: Fix mm_cid test failure
To: Shuah Khan <skhan@linuxfoundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Valentin Schneider <vschneid@redhat.com>,
 Mel Gorman <mgorman@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Carlos O'Donell <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>
References: <20241004004439.1673801-1-mathieu.desnoyers@efficios.com>
 <20241004004439.1673801-3-mathieu.desnoyers@efficios.com>
 <01153485-ea70-47f7-ab6b-2c17496ab8ff@linuxfoundation.org>
 <9c3a8650-c855-41d2-b500-6a72e45c057c@efficios.com>
 <cd1c25bc-8395-4dac-9f03-930a7e221a8b@linuxfoundation.org>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <cd1c25bc-8395-4dac-9f03-930a7e221a8b@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-10-08 23:29, Shuah Khan wrote:
> On 10/8/24 08:56, Mathieu Desnoyers wrote:
>> On 2024-10-04 21:18, Shuah Khan wrote:
>>> On 10/3/24 18:44, Mathieu Desnoyers wrote:
>>>> Adapt the rseq.c/rseq.h code to follow GNU C library changes 
>>>> introduced by:
>>>>
>>>> commit 2e456ccf0c34 ("Linux: Make __rseq_size useful for feature 
>>>> detection (bug 31965)")
>>>>
>>>> Without this fix, rseq selftests for mm_cid fail:
>>>>
>>>> ./run_param_test.sh
>>>> Default parameters
>>>> Running test spinlock
>>>> Running compare-twice test spinlock
>>>> Running mm_cid test spinlock
>>>> Error: cpu id getter unavailable
>>>>
>>>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>> CC: Boqun Feng <boqun.feng@gmail.com>
>>>> CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
>>>> Cc: Shuah Khan <skhan@linuxfoundation.org>
>>>> CC: Carlos O'Donell <carlos@redhat.com>
>>>> CC: Florian Weimer <fweimer@redhat.com>
>>>> ---
>>>>   tools/testing/selftests/rseq/rseq.c | 109 
>>>> +++++++++++++++++++---------
>>>>   tools/testing/selftests/rseq/rseq.h |  10 +--
>>>>   2 files changed, 76 insertions(+), 43 deletions(-)
>>>>
>>>
>>> Looks good to me.
>>>
>>> Acked-by: Shuah Khan <skhan@linuxfoundation.org>
>>>
>>> Peter, Ingo - let me know if you plan to take this through
>>> one of your trees. Otherwise I will pick it up.
>>
>> Hi Shuah,
>>
>> I just discussed with Peter on IRC, and if you can pick up
>> this rseq selftest fix through your tree it would be very much
>> appreciated,
>>
> 
> Thank you for checking. Looks like it doesn't apply to my tree.
> 
> 2e456ccf0c34 isn't in 6.12 yet?

That commit is in the glibc project. I will clarify this in my
commit message.

I'll rebase my patch on:

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
branch: fixes

> 
> Also a couple things you could fix. Please cc linux-kselftest
> when you send the next revision with these fixed.

OK

> 
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> #114: FILE: tools/testing/selftests/rseq/rseq.c:110:
> +unsigned get_rseq_min_alloc_size(void)
> 
> WARNING: Prefer 'fallthrough;' over fallthrough comment
> #221: FILE: tools/testing/selftests/rseq/rseq.c:218:
> +        case ORIG_RSEQ_FEATURE_SIZE:    /* Fallthrough. */
>

OK

Thanks,

Mathieu

  
> thanks,
> -- Shuah
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


