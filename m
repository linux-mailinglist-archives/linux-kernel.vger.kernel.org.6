Return-Path: <linux-kernel+bounces-291079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB7F955D01
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 16:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C27128191D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 14:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FC7139580;
	Sun, 18 Aug 2024 14:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y9YXuniO"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E807449652
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 14:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723992105; cv=none; b=tIHiv10uOaE8NEjnxCUBkwLekd7xq6KukU2FVa4h2Je3jW6iKPjWShzoyA8zvEY36/m87KI+9/Kwqh+aviYK5rS2zD8R1gVHlPYk9EciylpJNhHRLaGCZcBp+cFg2JRoKbLqPF7LIaKtCvziVHuTpYC8e1zoq5r92gS0PhcjOXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723992105; c=relaxed/simple;
	bh=f/Yyh1SQiz037i+coZ5d5gnMdIEpE5sBF1HqgTYcoPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rWgxnuvRB3B7Pe8KE3OPluwQbV4DqV73gXTRBdhmm3+Fc/7NFBM8bcoT1SgE1rBMO8sdSwT5biSrSe5cT2wM+qXActo0u8AyXw60vj/nmAG/atVfYHELe7g1U5aaB6EqHcuNNumgJwB8tPLQKCYe/H28bvKwskcpGxI3Tc9VbGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y9YXuniO; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4a50889c-aa90-4a99-b3d9-45d5666b3171@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723992100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oPs/TgqEJtnJfx1BsHQyi/jmTIqnp3sMt5LKa8FQ7vg=;
	b=Y9YXuniODlvYIxuioQ4x6VUkcnKCIAxWiuv9SoLe13t7cEkLVCIM5YKppOqjZfWZLTlDZR
	fjFg0EvtmipEogfdvkm02pz15Fsa+BMHObb6RqfYNsrC1W+eo0i/QIx6WDi14oOkng12Mk
	c0N05ZdRec6wtPrXoKUAwb5MFgt/Wcg=
Date: Sun, 18 Aug 2024 22:41:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RESEND PATCH v2] eventfd: introduce ratelimited wakeup for
 non-semaphore eventfd
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
 Dylan Yudaken <dylany@fb.com>, David Woodhouse <dwmw@amazon.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>, Dave Young <dyoung@redhat.com>,
 kernel test robot <lkp@intel.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240811085954.17162-1-wen.yang@linux.dev>
 <w7ldxi4jcdizkefv7musjwxblwu66pg3rfteprfymqoxaev6by@ikvzlsncihbr>
 <f21b635e-3bd7-48c3-b257-dde1b9f49c6c@linux.dev>
 <CAGudoHFQtxU7r+Y9AV2yPc+JrTdMtzJopsjUinFK8uE5h7cbTQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <CAGudoHFQtxU7r+Y9AV2yPc+JrTdMtzJopsjUinFK8uE5h7cbTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2024/8/15 04:58, Mateusz Guzik wrote:
> On Wed, Aug 14, 2024 at 6:15 PM Wen Yang <wen.yang@linux.dev> wrote:
>>
>>
>>
>> On 2024/8/11 18:26, Mateusz Guzik wrote:
>>> On Sun, Aug 11, 2024 at 04:59:54PM +0800, Wen Yang wrote:
>>>> For the NON-SEMAPHORE eventfd, a write (2) call adds the 8-byte integer
>>>> value provided in its buffer to the counter, while a read (2) returns the
>>>> 8-byte value containing the value and resetting the counter value to 0.
>>>> Therefore, the accumulated value of multiple writes can be retrieved by a
>>>> single read.
>>>>
>>>> However, the current situation is to immediately wake up the read thread
>>>> after writing the NON-SEMAPHORE eventfd, which increases unnecessary CPU
>>>> overhead. By introducing a configurable rate limiting mechanism in
>>>> eventfd_write, these unnecessary wake-up operations are reduced.
>>>>
>>>>
>>> [snip]
>>>
>>>>       # ./a.out  -p 2 -s 3
>>>>       The original cpu usage is as follows:
>>>> 09:53:38 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
>>>> 09:53:40 PM    2   47.26    0.00   52.74    0.00    0.00    0.00    0.00    0.00    0.00    0.00
>>>> 09:53:40 PM    3   44.72    0.00   55.28    0.00    0.00    0.00    0.00    0.00    0.00    0.00
>>>>
>>>> 09:53:40 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
>>>> 09:53:42 PM    2   45.73    0.00   54.27    0.00    0.00    0.00    0.00    0.00    0.00    0.00
>>>> 09:53:42 PM    3   46.00    0.00   54.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00
>>>>
>>>> 09:53:42 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
>>>> 09:53:44 PM    2   48.00    0.00   52.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00
>>>> 09:53:44 PM    3   45.50    0.00   54.50    0.00    0.00    0.00    0.00    0.00    0.00    0.00
>>>>
>>>> Then enable the ratelimited wakeup, eg:
>>>>       # ./a.out  -p 2 -s 3  -r1000 -c2
>>>>
>>>> Observing a decrease of over 20% in CPU utilization (CPU # 3, 54% ->30%), as shown below:
>>>> 10:02:32 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
>>>> 10:02:34 PM    2   53.00    0.00   47.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00
>>>> 10:02:34 PM    3   30.81    0.00   30.81    0.00    0.00    0.00    0.00    0.00    0.00   38.38
>>>>
>>>> 10:02:34 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
>>>> 10:02:36 PM    2   48.50    0.00   51.50    0.00    0.00    0.00    0.00    0.00    0.00    0.00
>>>> 10:02:36 PM    3   30.20    0.00   30.69    0.00    0.00    0.00    0.00    0.00    0.00   39.11
>>>>
>>>> 10:02:36 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
>>>> 10:02:38 PM    2   45.00    0.00   55.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00
>>>> 10:02:38 PM    3   27.08    0.00   30.21    0.00    0.00    0.00    0.00    0.00    0.00   42.71
>>>>
>>>>
>>>
>>> Where are these stats from? Is this from your actual program you coded
>>> the feature for?
>>>
>>> The program you inlined here does next to nothing in userspace and
>>> unsurprisingly the entire thing is dominated by kernel time, regardless
>>> of what event rate can be achieved.
>>>
>>> For example I got: /a.out -p 2 -s 3  5.34s user 60.85s system 99% cpu 66.19s (1:06.19) total
>>>
>>> Even so, looking at perf top shows me that a significant chunk is
>>> contention stemming from calls to poll -- perhaps the overhead will
>>> sufficiently go down if you epoll instead?
>>
>> We have two threads here, one publishing and one subscribing, running on
>> CPUs 2 and 3 respectively. If we further refine and collect performance
>> data on CPU 2, we will find that a large amount of CPU is consumed on
>> the spin lock of the wake-up logic of event write, for example:
>>
>>    # perf top  -C 2  -e cycles:k
>>
>>       65.80%  [kernel]       [k] do_syscall_64
>>       14.71%  [kernel]       [k] _raw_spin_unlock_irq
>>        7.54%  [kernel]       [k] __fget_light
>>        4.52%  [kernel]       [k] ksys_write
>>        1.94%  [kernel]       [k] vfs_write
>>        1.43%  [kernel]       [k] _copy_from_user
>>        0.87%  [kernel]       [k] common_file_perm
>>        0.61%  [kernel]       [k] aa_file_perm
>>        0.46%  [kernel]       [k] eventfd_write
>>
>>
>> One of its call stacks:
>>
>> |--6.39%--vfs_write
>> |           --5.46%--eventfd_write
>> |                      --4.73%--_raw_spin_unlock_irq
>>
>>
>>>   > I think the idea is pretty dodgey. If the consumer program can tolerate
>>> some delay in event processing, this probably can be massaged entirely in
>>> userspace.
>>>
>>> If your real program has the wake up rate so high that it constitutes a
>>> tangible problem I wonder if eventfd is even the right primitive to use
>>> -- perhaps something built around shared memory and futexes would do the
>>> trick significantly better?
>>
>> Thank you for your feedback.
>>
>> This demo comes from the real world: the test vehicle has sensors with
>> multiple cycles (such as 1ms, 5ms, 10ms, etc.), and due to the large
>> number of sensors, data is reported at all times. The publisher reported
>> data through libzmq and went to the write logic of eventfd, frequently
>> waking up the receiver. We collected flame graph and observed that a
>> significant amount of CPU was consumed in this path: eventfd_write ->
>> _raw_spin_unlock_irq.
>>
>> We did modify a lot of code in user mode on the test vehicle to avoid
>> this issue, such as not using wake-up, not using eventfd, the publisher
>> writing shared memory directly, the receiver periodically extracting the
>> content of shared memory, and so on.
>>
> 
> Well I don't have the full picture and whatnot, but given the
> additional info you posted here I even more strongly suspect eventfd
> is a bad fit. AFAICS this boils down to batching a number of updates
> and collecting them at some interval.
> 
> With the assumption that updates to the eventfd counter are guaranteed
> to not overflow within the wakeup delay and that there is constant
> traffic, I'm suspect you would get the expected speed up by using
> timerfd to wake the consumer up periodically. Then you would only
> issue an eventfd read when the timerfd tells you time is up. You would
> (e)poll only on that as well, never on the eventfd.
> 
> Even so, as is I think this wants a page shared between producer(s)
> and the consumer updating everything with atomics and the consumer
> collecting it periodically (atomic add on one side, atomic swap with 0
> on the consumer, I don't know the c11 intrinsics). It would be
> drastically cheaper all around.
> 

Thank you for your suggestion.

By using these methods above instead of eventfd, CPU consumption can 
indeed be reduced.

But this requires modifying some user mode programs. Some of the 
programs on the test vehicle are our own and can be modified; But there 
is still a portion from various suppliers, and some even only deliver 
binary, which is difficult to change.

And the kernel is open source, if it can be optimized, all user mode 
programs can benefit from it.

You also mentioned that "AFAICS this boils down to batching a number of 
updates and collecting them at some interval."
Yes, it's also similar to 'TCP's silly windw syndrome':
Every time the counter is incremented by 1, the read side process needs 
to be awakened. When such operations are frequently performed, a lot of 
time is wasted on awakening.

This patch is also inspired by algorithms such as Nagle and Cork. It 
attempts to delay wake-up, accumulate a larger counter value, and then 
wake up the reader process to consume the accumulated counter value at once.

Eventfd has already provided the NON-SEMAPHORE attribute, but it has not 
been used yet. We look forward to your collaboration in using it 
together to solve such problems.

--
Best wishes,
Wen


