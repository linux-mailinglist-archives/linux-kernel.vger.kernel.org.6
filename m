Return-Path: <linux-kernel+bounces-403977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A04079C3D51
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 557031F25501
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42E319CC27;
	Mon, 11 Nov 2024 11:29:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F96919B586
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 11:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731324578; cv=none; b=Ho6EByDiihE2UVvAwreaMXub4lgTwWy9momSmdB4sxfviP6cIgq2pAPLH4KpXCFehgKXRxaQaNDfifMSNZHuOm7UWWII94KLUjpQqGSJd2Ug6CxPbDWMKMVyIAav7QpEmQXr20GPYjcfsg1vJ4DiS0lXpbW+W4PllXSa8BRAXZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731324578; c=relaxed/simple;
	bh=6bCv4gw+4zrnonhC5A5JIp2A37vQ1Um/HQdfbDVs+yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dxdc+LbyNPHjALDUg5+FB94JwwaHJEg4KY0uBfNIk8LBs1WcA9qpdkS9TSoWZzmKVf9VaH1NkBD27N79jis6MEZt1/cWqI+sh6FcLMtbY5PhcXnFb9l+qDUSWuqT/wz1kZDNRB5gdAfvAYdS2cclRIvX/67P/LLmz3ZZzwcKsfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 635851D14;
	Mon, 11 Nov 2024 03:30:02 -0800 (PST)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55AF73F6A8;
	Mon, 11 Nov 2024 03:29:30 -0800 (PST)
Message-ID: <388f8fc1-2ba0-4b15-ab71-adfe07705229@arm.com>
Date: Mon, 11 Nov 2024 12:29:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/24] sched/fair: Implement delayed dequeue
To: Phil Auld <pauld@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com, youssefesmat@chromium.org, tglx@linutronix.de,
 efault@gmx.de
References: <20240727102732.960974693@infradead.org>
 <20240727105030.226163742@infradead.org>
 <20241101124715.GA689589@pauld.westford.csb>
 <ed46d844-e0b0-46fd-a164-9bfad538a7a9@arm.com>
 <20241104125009.GA749675@pauld.westford.csb>
 <f340b1c4-f1ed-4c9f-adbb-b10cd3a17a85@arm.com>
 <20241108181617.GC43508@pauld.westford.csb>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <20241108181617.GC43508@pauld.westford.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/11/2024 19:16, Phil Auld wrote:
> On Fri, Nov 08, 2024 at 03:53:26PM +0100 Dietmar Eggemann wrote:
>> On 04/11/2024 13:50, Phil Auld wrote:
>>>
>>> Hi Dietmar,
>>>
>>> On Mon, Nov 04, 2024 at 10:28:37AM +0100 Dietmar Eggemann wrote:
>>>> Hi Phil,
>>>>
>>>> On 01/11/2024 13:47, Phil Auld wrote:

[...]

>> One reason I don't see the difference between DELAY_DEQUEUE and
>> NO_DELAY_DEQUEUE could be because of the affinity of the related
>> nvme interrupts: 
>>
>> $ cat /proc/interrupts
>>
>>      CPU0 CPU1    CPU2 CPU3 CPU4    CPU5 CPU6 CPU7    CPU8 ...
>> 132:   0    0  1523653    0   0        0   0    0       0  ... IR-PCI-MSIX-0000:01:00.0 1-edge nvme0q1
>> 133:   0    0        0    0   0  1338451   0    0       0  ... IR-PCI-MSIX-0000:01:00.0 2-edge nvme0q2
>> 134:   0    0        0    0   0        0   0    0  2252297 ... IR-PCI-MSIX-0000:01:00.0 3-edge nvme0q3
>>
>> $ cat /proc/irq/132/smp_affinity_list 
>> 0-2
>> cat /proc/irq/133/smp_affinity_list 
>> 3-5
>> cat /proc/irq/134/smp_affinity_list 
>> 6-8
>>
>> So the 8 fio tasks from: 
>>
>> # fio --cpus_allowed 1,2,3,4,5,6,7,8 --rw randwrite --bs 4k
>>   --runtime 8s --iodepth 32 --direct 1 --ioengine libaio
>>   --numjobs 8 --size 30g --name default --time_based
>>   --group_reporting --cpus_allowed_policy shared
>>   --directory /testfs
>>
>> don't have to fight with per-CPU kworkers on each CPU.
>>
>> e.g. 'nvme0q3 interrupt -> queue on workqueue dio/nvme0n1p2 -> 
>>       run iomap_dio_complete_work() in kworker/8:x'
>>
>> In case I trace the 'task_on_rq_queued(p) && p->se.sched_delayed &&
>> rq->nr_running > 1) condition in ttwu_runnable() condition i only see
>> the per-CPU kworker in there, so p->nr_cpus_allowed == 1.
>>
>> So the patch shouldn't make a difference for this scenario?
>>
> 
> If the kworker is waking up an fio task it could.  I don't think
> they are bound to a single cpu.
> 
> But yes if your trace is only showing the kworker there then it would
> not help.  Are you actually able to reproduce the difference?

No, with my setup I don't see any difference running your fio test. But
the traces also show me that there are no scenarios in which this patch
can make a difference in the scores.

>> But maybe your VDO or thinpool setup creates waker/wakee pairs with
>> wakee->nr_cpus_allowed > 1? 
>>
> 
> That's certainly possible but I don't know for sure. There are well more
> dio kworkers on the box than cpus though if I recall. I don't know
> if they all have singel cpu affinities. 

Yeah there must be more tasks (inc. kworkers) w/ 'p->nr_cpus_allowed >
1' involved.

>> Does your machine has single CPU smp_affinity masks for these nvme
>> interrupts?
>>
> 
> I don't know. I had to give the machine back.

Ah, too late then ;-)


