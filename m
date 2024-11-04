Return-Path: <linux-kernel+bounces-394473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6479BAFA5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 10:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90FD51C20C64
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 09:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57881AC887;
	Mon,  4 Nov 2024 09:28:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2566FC5
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 09:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730712530; cv=none; b=e1Q468RdHCrr0DKvQGJm/VwsIFSDH+brhU7k8l/UG4jPzTC/c73lE97stTBKSrt/Jwh9m6pLZq9QOriAo3m+uH9R60TyFZzXuc400szFZJwTW7m96JcJAhIqJdxtIkUl6cHOOc1HWKfLFykwHfWq9wu3Vm22cA/dIkrUP7uQPr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730712530; c=relaxed/simple;
	bh=/ISMEJMdpURmCFcP3ieimdPjlyxMEpAjqhqp7CNP8Ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OnYMM507yvIT8sBMESByLf4RXOEeSrw+cLkwHyVMZ4BnjQ4O6Bnds3amXawRelYnrIkrvQVH2WrGXUkTV6H1nWsSmWw75wsUjr7KxMpcCDul4LihHn6FJaoLNPulnk1lqMIXSCTFtP/UNQs1OQpI1/wp/wLqa3jdFP5jbhr+hmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AADB0FEC;
	Mon,  4 Nov 2024 01:29:16 -0800 (PST)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFCB53F6A8;
	Mon,  4 Nov 2024 01:28:44 -0800 (PST)
Message-ID: <ed46d844-e0b0-46fd-a164-9bfad538a7a9@arm.com>
Date: Mon, 4 Nov 2024 10:28:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/24] sched/fair: Implement delayed dequeue
To: Phil Auld <pauld@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com, youssefesmat@chromium.org, tglx@linutronix.de,
 efault@gmx.de
References: <20240727102732.960974693@infradead.org>
 <20240727105030.226163742@infradead.org>
 <20241101124715.GA689589@pauld.westford.csb>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <20241101124715.GA689589@pauld.westford.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Phil,

On 01/11/2024 13:47, Phil Auld wrote:
> 
> Hi Peterm
> 
> On Sat, Jul 27, 2024 at 12:27:49PM +0200 Peter Zijlstra wrote:
>> Extend / fix 86bfbb7ce4f6 ("sched/fair: Add lag based placement") by
>> noting that lag is fundamentally a temporal measure. It should not be
>> carried around indefinitely.
>>
>> OTOH it should also not be instantly discarded, doing so will allow a
>> task to game the system by purposefully (micro) sleeping at the end of
>> its time quantum.
>>
>> Since lag is intimately tied to the virtual time base, a wall-time
>> based decay is also insufficient, notably competition is required for
>> any of this to make sense.
>>
>> Instead, delay the dequeue and keep the 'tasks' on the runqueue,
>> competing until they are eligible.
>>
>> Strictly speaking, we only care about keeping them until the 0-lag
>> point, but that is a difficult proposition, instead carry them around
>> until they get picked again, and dequeue them at that point.
> 
> This one is causing a 10-20% performance hit on our filesystem tests.
> 
> On 6.12-rc5 (so with the latest follow ons) we get:
> 
> with DELAY_DEQUEUE the bandwidth is 510 MB/s
> with NO_DELAY_DEQUEUE the bandwidth is 590 MB/s
> 
> The test is fio, something like this:
> 
> taskset -c 1,2,3,4,5,6,7,8 fio --rw randwrite --bs 4k --runtime 1m --fsync 0 --iodepth 32 --direct 1 --ioengine libaio --numjobs 8 --size 30g --nrfiles 1 --loops 1 --name default --randrepeat 1 --time_based --group_reporting --directory /testfs

I'm not seeing this on my i7-13700K running tip sched/core (1a6151017ee5
- sched: psi: pass enqueue/dequeue flags to psi callbacks directly
(2024-10-26 Johannes Weiner)) (6.12.0-rc4 - based)

Using 'taskset 0xaaaaa' avoiding SMT and running only on P-cores.

vanilla features: 990MB/s (mean out of 5 runs, σ:  9.38)
NO_DELAY_DEQUEUE: 992MB/s (mean out of 5 runs, σ: 10.61)

# sudo lshw -class disk -class storage
  *-nvme                    
       description: NVMe device
       product: GIGABYTE GP-ASM2NE6500GTTD
       vendor: Phison Electronics Corporation
       physical id: 0
       bus info: pci@0000:01:00.0
       logical name: /dev/nvme0
       version: EGFM13.2
       ...
       capabilities: nvme pciexpress msix msi pm nvm_express bus_master cap_list
       configuration: driver=nvme latency=0 nqn=nqn.2014.08.org.nvmexpress:19871987SN215108954872 GIGABYTE GP-ASM2NE6500GTTD state=live
       resources: irq:16 memory:70800000-70803fff

# mount | grep ^/dev/nvme0
/dev/nvme0n1p2 on / type ext4 (rw,relatime,errors=remount-ro)

Which disk device you're using?

> 
> In this case it's ext4, but I'm not sure it will be FS specific.
> 
> I should have the machine and setup next week to poke further but I wanted
> to mention it now just in case any one has an "aha" moment.
> 
> It seems to only effect these FS loads. Other perf tests are not showing any
> issues that I am aware of.

[...]


