Return-Path: <linux-kernel+bounces-401824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8405D9C1FB7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0448B23A37
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4286B1F4282;
	Fri,  8 Nov 2024 14:53:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279F31EABAF
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 14:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731077620; cv=none; b=vBK1ohgn4jQ+40KToLIoaRvfp4gb1DqiEm6Ce+73CZLNcog/Ppf8+wWeJfcPYeuF+NhxUNEFOXSQnyiN8HC17ImbhcoLo8pmrtDxa+F99sWEZyedf7ab3Ne+AderCLO0swuKS76taUP0j/17MVSWOrPyF/sn0TbyGeH4rK7NKiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731077620; c=relaxed/simple;
	bh=fZ5YazTZ03scJmw7IECcxO9xNDB5eI90rCdlN9V/APQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dmxtt4KE5xA/kXtEK9gsdN9aM4KY0AtDExn190bJzTmfeVqNDe9+Xja14Io+nKpiQMwGHpFaudt8frlZQRSjSKvKWH4Z1CV1fmamnuqthlZRE17B7voHUYDTvk5pxqiQL4Hmbp4bFZpuj18JaX3H/YHeaIjlvmDDwZI1/4XBapg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46990339;
	Fri,  8 Nov 2024 06:54:08 -0800 (PST)
Received: from [192.168.178.25] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 852333F528;
	Fri,  8 Nov 2024 06:53:35 -0800 (PST)
Message-ID: <f340b1c4-f1ed-4c9f-adbb-b10cd3a17a85@arm.com>
Date: Fri, 8 Nov 2024 15:53:26 +0100
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
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <20241104125009.GA749675@pauld.westford.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/11/2024 13:50, Phil Auld wrote:
> 
> Hi Dietmar,
> 
> On Mon, Nov 04, 2024 at 10:28:37AM +0100 Dietmar Eggemann wrote:
>> Hi Phil,
>>
>> On 01/11/2024 13:47, Phil Auld wrote:
>>>
>>> Hi Peterm

[...]

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
> 
> Also, as yet I'm not personally doing this testing, just looking into it and
> passing on the information I have. 

One reason I don't see the difference between DELAY_DEQUEUE and
NO_DELAY_DEQUEUE could be because of the affinity of the related
nvme interrupts: 

$ cat /proc/interrupts

     CPU0 CPU1    CPU2 CPU3 CPU4    CPU5 CPU6 CPU7    CPU8 ...
132:   0    0  1523653    0   0        0   0    0       0  ... IR-PCI-MSIX-0000:01:00.0 1-edge nvme0q1
133:   0    0        0    0   0  1338451   0    0       0  ... IR-PCI-MSIX-0000:01:00.0 2-edge nvme0q2
134:   0    0        0    0   0        0   0    0  2252297 ... IR-PCI-MSIX-0000:01:00.0 3-edge nvme0q3

$ cat /proc/irq/132/smp_affinity_list 
0-2
cat /proc/irq/133/smp_affinity_list 
3-5
cat /proc/irq/134/smp_affinity_list 
6-8

So the 8 fio tasks from: 

# fio --cpus_allowed 1,2,3,4,5,6,7,8 --rw randwrite --bs 4k
  --runtime 8s --iodepth 32 --direct 1 --ioengine libaio
  --numjobs 8 --size 30g --name default --time_based
  --group_reporting --cpus_allowed_policy shared
  --directory /testfs

don't have to fight with per-CPU kworkers on each CPU.

e.g. 'nvme0q3 interrupt -> queue on workqueue dio/nvme0n1p2 -> 
      run iomap_dio_complete_work() in kworker/8:x'

In case I trace the 'task_on_rq_queued(p) && p->se.sched_delayed &&
rq->nr_running > 1) condition in ttwu_runnable() condition i only see
the per-CPU kworker in there, so p->nr_cpus_allowed == 1.

So the patch shouldn't make a difference for this scenario?

But maybe your VDO or thinpool setup creates waker/wakee pairs with
wakee->nr_cpus_allowed > 1? 

Does your machine has single CPU smp_affinity masks for these nvme
interrupts?

[...]



































