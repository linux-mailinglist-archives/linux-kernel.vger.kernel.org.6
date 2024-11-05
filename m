Return-Path: <linux-kernel+bounces-396232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D96D09BC9A6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98015280D18
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDF31D1500;
	Tue,  5 Nov 2024 09:53:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71801367
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 09:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730800439; cv=none; b=W9omhvi4TPTRbm6SE/NE9b7DohxVleCzjUBldr9kVbo/mYwzEDG0QjFbjg2vhVmblWt7OO4FptWtQrmIX5kxEQ+0NLgzBkJ+w0KcCObM8MhZ6bo6D/xugxE1Aa405Y7RaaW/2Jis68Bdn+3jLgYX7feVWHZjdSEH2qjY0K0enJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730800439; c=relaxed/simple;
	bh=RFAb2sjKI+T7wNgwyYUDHxoIMPLO3AHqAohN8z5OpHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VqAX80y3+LiwIq9WhmTh0SpEGDaNWNhqX7tLp+9LYymsmGv+4liO2Rk1CasNzJXsKSjbCClD9o7AfzikL1EErfXy623VbdfbPTolS22h9zjBDk18eOfBKiMuDhToIZ3DbYTI3jMOrR09WbnZOuVQ0yWKb2tpqZP4JJXNwLlo7gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2D67FEC;
	Tue,  5 Nov 2024 01:54:24 -0800 (PST)
Received: from [10.1.26.64] (e127648.arm.com [10.1.26.64])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A20573F66E;
	Tue,  5 Nov 2024 01:53:51 -0800 (PST)
Message-ID: <93e73a42-0afc-4749-89db-73b9f72c8b0b@arm.com>
Date: Tue, 5 Nov 2024 09:53:49 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/24] sched/fair: Implement delayed dequeue
To: Phil Auld <pauld@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>
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
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20241104125009.GA749675@pauld.westford.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/4/24 12:50, Phil Auld wrote:
> 
> Hi Dietmar,
> 
> On Mon, Nov 04, 2024 at 10:28:37AM +0100 Dietmar Eggemann wrote:
>> Hi Phil,
>>
>> On 01/11/2024 13:47, Phil Auld wrote:
>>>
>>> Hi Peterm
>>>
>>> On Sat, Jul 27, 2024 at 12:27:49PM +0200 Peter Zijlstra wrote:
>>>> Extend / fix 86bfbb7ce4f6 ("sched/fair: Add lag based placement") by
>>>> noting that lag is fundamentally a temporal measure. It should not be
>>>> carried around indefinitely.
>>>>
>>>> OTOH it should also not be instantly discarded, doing so will allow a
>>>> task to game the system by purposefully (micro) sleeping at the end of
>>>> its time quantum.
>>>>
>>>> Since lag is intimately tied to the virtual time base, a wall-time
>>>> based decay is also insufficient, notably competition is required for
>>>> any of this to make sense.
>>>>
>>>> Instead, delay the dequeue and keep the 'tasks' on the runqueue,
>>>> competing until they are eligible.
>>>>
>>>> Strictly speaking, we only care about keeping them until the 0-lag
>>>> point, but that is a difficult proposition, instead carry them around
>>>> until they get picked again, and dequeue them at that point.
>>>
>>> This one is causing a 10-20% performance hit on our filesystem tests.
>>>
>>> On 6.12-rc5 (so with the latest follow ons) we get:
>>>
>>> with DELAY_DEQUEUE the bandwidth is 510 MB/s
>>> with NO_DELAY_DEQUEUE the bandwidth is 590 MB/s
>>>
>>> The test is fio, something like this:
>>>
>>> taskset -c 1,2,3,4,5,6,7,8 fio --rw randwrite --bs 4k --runtime 1m --fsync 0 --iodepth 32 --direct 1 --ioengine libaio --numjobs 8 --size 30g --nrfiles 1 --loops 1 --name default --randrepeat 1 --time_based --group_reporting --directory /testfs
>>
>> I'm not seeing this on my i7-13700K running tip sched/core (1a6151017ee5
>> - sched: psi: pass enqueue/dequeue flags to psi callbacks directly
>> (2024-10-26 Johannes Weiner)) (6.12.0-rc4 - based)
>>
>> Using 'taskset 0xaaaaa' avoiding SMT and running only on P-cores.
>>
>> vanilla features: 990MB/s (mean out of 5 runs, σ:  9.38)
>> NO_DELAY_DEQUEUE: 992MB/s (mean out of 5 runs, σ: 10.61)
>>
>> # sudo lshw -class disk -class storage
>>   *-nvme                    
>>        description: NVMe device
>>        product: GIGABYTE GP-ASM2NE6500GTTD
>>        vendor: Phison Electronics Corporation
>>        physical id: 0
>>        bus info: pci@0000:01:00.0
>>        logical name: /dev/nvme0
>>        version: EGFM13.2
>>        ...
>>        capabilities: nvme pciexpress msix msi pm nvm_express bus_master cap_list
>>        configuration: driver=nvme latency=0 nqn=nqn.2014.08.org.nvmexpress:19871987SN215108954872 GIGABYTE GP-ASM2NE6500GTTD state=live
>>        resources: irq:16 memory:70800000-70803fff 
>>
>> # mount | grep ^/dev/nvme0
>> /dev/nvme0n1p2 on / type ext4 (rw,relatime,errors=remount-ro)
>>
>> Which disk device you're using?
> 
> Most of the reports are on various NVME drives (samsung mostly I think).
> 
> 
> One thing I should add is that it's all on LVM: 
> 
> 
> vgcreate vg /dev/nvme0n1 -y
> lvcreate -n thinMeta -L 3GB vg -y
> lvcreate -n thinPool -l 99%FREE vg -y
> lvconvert --thinpool /dev/mapper/vg-thinPool --poolmetadata /dev/mapper/vg-thinMeta -Zn -y
> lvcreate -n testLV -V 1300G --thinpool thinPool vg
> wipefs -a /dev/mapper/vg-testLV
> mkfs.ext4 /dev/mapper/vg-testLV -E lazy_itable_init=0,lazy_journal_init=0 -F
> mount /dev/mapper/vg-testLV /testfs 
> 
> 
> With VDO or thinpool (as above) it shows on both ext4 and xfs. With fs on
> drive directly it's a little more variable. Some it shows on xfs, some it show
> on ext4 and not vice-versa, seems to depend on the drive or hw raid. But when
> it shows it's 100% reproducible on that setup. 
> 
> It's always the randwrite numbers. The rest look fine.

Hi Phil,

Thanks for the detailed instructions. Unfortunately even with your LVM setup on
the platforms I've tried I don't see a regression so far, all the numbers are
about equal for DELAY_DEQUEUE and NO_DELAY_DEQUEUE.

Anyway I have some follow-ups, first let me trim the fio command for readability:
fio --rw randwrite --bs 4k --runtime 1m --fsync 0 --iodepth 32 --direct 1 --ioengine libaio --numjobs 8 --size 30g --nrfiles 1 --loops 1 --name default --randrepeat 1 --time_based --group_reporting --directory /testfs

dropping defaults nr_files, loops, fsync, randrepeat
fio --rw randwrite --bs 4k --runtime 1m --iodepth 32 --direct 1 --ioengine libaio --numjobs 8 --size 30g --name default --time_based --group_reporting --directory /testfs

Adding the CPU affinities directly:
fio --cpus_allowed 1-8 --rw randwrite --bs 4k --runtime 1m --iodepth 32 --direct 1 --ioengine libaio --numjobs 8 --size 30g --name default --time_based --group_reporting --directory /testfs

Now I was wondering about the following:
Is it actually the kworker (not another fio) being preempted? (I'm pretty sure it is)
To test: --cpus_allowed_policy split (each fio process gets it's own CPU).

You wrote:
>I was thinking maybe the preemption was preventing some batching of IO completions or
>initiations. But that was wrong it seems.

So while it doesn't reproduce for me, the only thing being preempted regularly is
the kworker (running iomap_dio_complete_work). I don't quite follow the "that was
wrong it seems" part then. Could you elaborate?

Could you also post the other benchmark numbers? Does any of them score higher in IOPS?
Is --rw write the same issue if you set --bs 4k (assuming you set a larger bs for seqwrite).

Can you set the kworkers handling completions to SCHED_BATCH too? Just to confirm.

Regards,
Christian

