Return-Path: <linux-kernel+bounces-403762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8549C3A6D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 562F4B215E8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 09:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB5215CD41;
	Mon, 11 Nov 2024 09:08:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECC961FE9
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 09:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731316137; cv=none; b=TaL8jOkAYxCLvz0BY5DNMS+k+fy4hnp4vAzhoM9+3K4KmRI5ipwfd8vH1vzHRp7yzKOZwBl+8BvEfqgHwupJkj8gFTZFHQsqWreAsL9SN1VFfo+jW9Sr9LJ1WsVzrtKbQ3NgheGz3GR9e7is3iN+mwF/7o37FNczEigospbrbAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731316137; c=relaxed/simple;
	bh=2lCJglJUcQkki23tQyaEoIjLwl7iVavye3bRZSbbRFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZAf+kvKTQrBEdXkymgSgq9glP42kLbIOAOyf6FS6+IZy9paMvonf/bBFVZkPfZDCXy8HHRmTYcOdyAwjyPb6WtRvMAT8GZGeuRsyfyOdrNsgjv7UdfQLj++XYJOjpIjA3ywpUDSBplATbDxvI+uBGDV3XFalIEZ5HSpfNKiLjxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51E941D14;
	Mon, 11 Nov 2024 01:09:23 -0800 (PST)
Received: from [10.1.36.17] (e127648.arm.com [10.1.36.17])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 88EA83F66E;
	Mon, 11 Nov 2024 01:08:49 -0800 (PST)
Message-ID: <98fa6dc9-b7e1-4bc4-911a-2febc652e07d@arm.com>
Date: Mon, 11 Nov 2024 09:08:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Very high scheduling delay with plenty of idle CPUs
To: Saravana Kannan <saravanak@google.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Benjamin Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, wuyun.abel@bytedance.com,
 youssefesmat@chromium.org, Thomas Gleixner <tglx@linutronix.de>,
 efault@gmx.de, John Stultz <jstultz@google.com>,
 Vincent Palomares <paillon@google.com>,
 Tobias Huschle <huschle@linux.ibm.com>
References: <CAGETcx830PZyr_oZAkghR=CLsThLUX1hZRxrNK_FNSLuF2TBAw@mail.gmail.com>
 <20241108083133.GD38786@noisy.programming.kicks-ass.net>
 <CAGETcx-CvWVc=TP5OmUL_iF7fSb1awJB1G8NghM1q_6dYKXkQQ@mail.gmail.com>
 <cc8831c7-8ea2-0ee7-061f-73352d7832ad@amd.com>
 <CAGETcx9qDK+QUiP8z1iNYXwjHz39oZzOZmhj4p=icU1BuVtcug@mail.gmail.com>
 <6eb8c1ce-9823-4d6a-a04c-6a9dc1c346c8@arm.com>
 <CAGETcx9ByrhRzpVo_5akoxx3NqjpxVHbPJrC-yq7xoYcb6+3qA@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAGETcx9ByrhRzpVo_5akoxx3NqjpxVHbPJrC-yq7xoYcb6+3qA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/11/24 09:02, Saravana Kannan wrote:
> On Mon, Nov 11, 2024 at 12:25 AM Christian Loehle
> <christian.loehle@arm.com> wrote:
>>
>> On 11/11/24 06:15, Saravana Kannan wrote:
>> [...]
>>>>> Can we tell the scheduler to just spread out all the tasks during
>>>>> suspend/resume? Doesn't make a lot of sense to try and save power
>>>>> during a suspend/resume. It's almost always cheaper/better to do those
>>>>> quickly.
>>>>
>>>> That would increase the resume latency right since each runnable task
>>>> needs to go through a full idle CPU selection cycle? Isn't time a
>>>> consideration / concern in the resume path? Unless we go through the
>>>> slow path, it is very likely we'll end up making the same task
>>>> placement decisions again?
>>>
>>> I actually quickly hacked up the cpu_overutilized() function to return
>>> true during suspend/resume and the threads are nicely spread out and
>>> running in parallel. That actually reduces the total of the
>>> dpm_resume*() phases from 90ms to 75ms on my Pixel 6.
>>>
>>> Also, this whole email thread started because I'm optimizing the
>>> suspend/resume code to reduce a lot of sleeps/wakeups and the number
>>> of kworker threads. And with that + over utilization hack, resume time
>>> has dropped to 60ms.
>>>
>>> Peter,
>>>
>>> Would you be open to the scheduler being aware of
>>> dpm_suspend*()/dpm_resume*() phases and triggering the CPU
>>> overutilized behavior during these phases? I know it's a very use case
>>> specific behavior but how often do we NOT want to speed up
>>> suspend/resume? We can make this a CONFIG or a kernel command line
>>> option -- say, fast_suspend or something like that.
>>>
>>
>> Just to confirm, you essentially want to disable EAS during
>> suspend/resume, or does sis also not give you an acceptable
>> placement?
> 
> If I effectively disable EAS during the dpm_resume/no_irq/early()
> phases (the past of the resume where devices are resumed and can run
> in parallel), that gives the best results. It shaves 15ms off.
> 
> More important than disabling EAS, I think the main need is to not
> preempt a runnable thread or delay scheduling a runnable thread. But
> yes, effectively, all CPUs end up getting used because there's enough
> work to keep all the CPUs busy for 5ms. With the current behavior (is
> it solely because of EAS?), some of the 5ms runs get stacked in one
> CPU and it ends up taking 5ms longer. And this happens in multiple
> phases and bumps it up by 15ms today. And this is all data averaged
> over 100+ samples. So it's very clear cut data and not just noise.

"Is it only EAS?"
I would hope so, EAS should be responsible for all placement in your
case.
Right, but potential latency costs are a side-effect of co-scheduling,
so I'm not sure I understand why you'd rather make EAS work for this
specific use-case instead of just disabling it for phases we know
it can't do the best job?
The entire post-EEVDF discussions are all about "Some workloads like
preemption, other's don't", but as long as we have plenty of idle
CPUs all that seems like unnecessary effort, am I missing something?

Regards,
Christian

