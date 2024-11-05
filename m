Return-Path: <linux-kernel+bounces-396718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5EA9BD133
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF8131F21C29
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEC014A611;
	Tue,  5 Nov 2024 15:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g5ke2LQZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9B438DD6
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822159; cv=none; b=CCTb6UZZ9YORvobv3xGfS9/ze1BZDEFo8JT/v0sRp3SaNITlmUsWn/ErBp2jVIT8GNm0fIpnKTR61USrEQ9dozJ/QN9hHlvedc3rdVmN/PnrPZriQ2r3YuET9rLDlu2Yc7VGEPojHglco20dOaXHl8Kjy6F53sD4GOU0EKNo5Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822159; c=relaxed/simple;
	bh=yBCgu0cBK6TKXi2qna+AIIArRaBwHhg1D5hN16SsTIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HeLx6OhKjoGMMK/MTfepzKX1IQvKj5QKhIfnmGHcQDukqbDh92V3Hcew6bq7l/hPJUoUD02dVOcYAca26qh/yBI3Yj3X3BZcSJ5gGXhtsy93Uz3M3tLH57KbOJvbPX84pd+LIupR0KlLTsAcZR3+Io2cXcUzAf6y1cr01/Jfco8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g5ke2LQZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730822156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nP9moAG5M5/3yDbA+3U3o1BXa4WTXpfjgS/p50H0JGU=;
	b=g5ke2LQZPdFCu0AZhJ7YzXzL/PawjxF0sLIFM5hNXPwNHsXdv61SYrTfzcmNS/cgyycH3v
	0DeNTzKMH8mpBj0yNVFEW0/PEgbzlbWDjDcrcAhNMZJfVic9z5ky0WDvnXOSoJQ787Rcrr
	+6Q1k/U+CQ9G1TxRMz0iIqnZ/1Zs2Fw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-WnsfwOQpOlqKPwA43QAnKw-1; Tue,
 05 Nov 2024 10:55:53 -0500
X-MC-Unique: WnsfwOQpOlqKPwA43QAnKw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB16D1955F79;
	Tue,  5 Nov 2024 15:55:50 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.64.146])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 912B71955F43;
	Tue,  5 Nov 2024 15:55:46 +0000 (UTC)
Date: Tue, 5 Nov 2024 10:55:43 -0500
From: Phil Auld <pauld@redhat.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de
Subject: Re: [PATCH 17/24] sched/fair: Implement delayed dequeue
Message-ID: <20241105155543.GB33795@pauld.westford.csb>
References: <20240727102732.960974693@infradead.org>
 <20240727105030.226163742@infradead.org>
 <20241101124715.GA689589@pauld.westford.csb>
 <ed46d844-e0b0-46fd-a164-9bfad538a7a9@arm.com>
 <20241104125009.GA749675@pauld.westford.csb>
 <93e73a42-0afc-4749-89db-73b9f72c8b0b@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <93e73a42-0afc-4749-89db-73b9f72c8b0b@arm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15


Hi Christian,

On Tue, Nov 05, 2024 at 09:53:49AM +0000 Christian Loehle wrote:
> On 11/4/24 12:50, Phil Auld wrote:
> > 
> > Hi Dietmar,
> > 
> > On Mon, Nov 04, 2024 at 10:28:37AM +0100 Dietmar Eggemann wrote:
> >> Hi Phil,
> >>
> >> On 01/11/2024 13:47, Phil Auld wrote:
> >>>
> >>> Hi Peterm
> >>>
> >>> On Sat, Jul 27, 2024 at 12:27:49PM +0200 Peter Zijlstra wrote:
> >>>> Extend / fix 86bfbb7ce4f6 ("sched/fair: Add lag based placement") by
> >>>> noting that lag is fundamentally a temporal measure. It should not be
> >>>> carried around indefinitely.
> >>>>
> >>>> OTOH it should also not be instantly discarded, doing so will allow a
> >>>> task to game the system by purposefully (micro) sleeping at the end of
> >>>> its time quantum.
> >>>>
> >>>> Since lag is intimately tied to the virtual time base, a wall-time
> >>>> based decay is also insufficient, notably competition is required for
> >>>> any of this to make sense.
> >>>>
> >>>> Instead, delay the dequeue and keep the 'tasks' on the runqueue,
> >>>> competing until they are eligible.
> >>>>
> >>>> Strictly speaking, we only care about keeping them until the 0-lag
> >>>> point, but that is a difficult proposition, instead carry them around
> >>>> until they get picked again, and dequeue them at that point.
> >>>
> >>> This one is causing a 10-20% performance hit on our filesystem tests.
> >>>
> >>> On 6.12-rc5 (so with the latest follow ons) we get:
> >>>
> >>> with DELAY_DEQUEUE the bandwidth is 510 MB/s
> >>> with NO_DELAY_DEQUEUE the bandwidth is 590 MB/s
> >>>
> >>> The test is fio, something like this:
> >>>
> >>> taskset -c 1,2,3,4,5,6,7,8 fio --rw randwrite --bs 4k --runtime 1m --fsync 0 --iodepth 32 --direct 1 --ioengine libaio --numjobs 8 --size 30g --nrfiles 1 --loops 1 --name default --randrepeat 1 --time_based --group_reporting --directory /testfs
> >>
> >> I'm not seeing this on my i7-13700K running tip sched/core (1a6151017ee5
> >> - sched: psi: pass enqueue/dequeue flags to psi callbacks directly
> >> (2024-10-26 Johannes Weiner)) (6.12.0-rc4 - based)
> >>
> >> Using 'taskset 0xaaaaa' avoiding SMT and running only on P-cores.
> >>
> >> vanilla features: 990MB/s (mean out of 5 runs, σ:  9.38)
> >> NO_DELAY_DEQUEUE: 992MB/s (mean out of 5 runs, σ: 10.61)
> >>
> >> # sudo lshw -class disk -class storage
> >>   *-nvme                    
> >>        description: NVMe device
> >>        product: GIGABYTE GP-ASM2NE6500GTTD
> >>        vendor: Phison Electronics Corporation
> >>        physical id: 0
> >>        bus info: pci@0000:01:00.0
> >>        logical name: /dev/nvme0
> >>        version: EGFM13.2
> >>        ...
> >>        capabilities: nvme pciexpress msix msi pm nvm_express bus_master cap_list
> >>        configuration: driver=nvme latency=0 nqn=nqn.2014.08.org.nvmexpress:19871987SN215108954872 GIGABYTE GP-ASM2NE6500GTTD state=live
> >>        resources: irq:16 memory:70800000-70803fff 
> >>
> >> # mount | grep ^/dev/nvme0
> >> /dev/nvme0n1p2 on / type ext4 (rw,relatime,errors=remount-ro)
> >>
> >> Which disk device you're using?
> > 
> > Most of the reports are on various NVME drives (samsung mostly I think).
> > 
> > 
> > One thing I should add is that it's all on LVM: 
> > 
> > 
> > vgcreate vg /dev/nvme0n1 -y
> > lvcreate -n thinMeta -L 3GB vg -y
> > lvcreate -n thinPool -l 99%FREE vg -y
> > lvconvert --thinpool /dev/mapper/vg-thinPool --poolmetadata /dev/mapper/vg-thinMeta -Zn -y
> > lvcreate -n testLV -V 1300G --thinpool thinPool vg
> > wipefs -a /dev/mapper/vg-testLV
> > mkfs.ext4 /dev/mapper/vg-testLV -E lazy_itable_init=0,lazy_journal_init=0 -F
> > mount /dev/mapper/vg-testLV /testfs 
> > 
> > 
> > With VDO or thinpool (as above) it shows on both ext4 and xfs. With fs on
> > drive directly it's a little more variable. Some it shows on xfs, some it show
> > on ext4 and not vice-versa, seems to depend on the drive or hw raid. But when
> > it shows it's 100% reproducible on that setup. 
> > 
> > It's always the randwrite numbers. The rest look fine.
> 
> Hi Phil,
> 
> Thanks for the detailed instructions. Unfortunately even with your LVM setup on
> the platforms I've tried I don't see a regression so far, all the numbers are
> about equal for DELAY_DEQUEUE and NO_DELAY_DEQUEUE.
>

Yeah, that's odd.

Fwiw:

Architecture:             x86_64
  CPU op-mode(s):         32-bit, 64-bit
  Address sizes:          48 bits physical, 48 bits virtual
  Byte Order:             Little Endian
CPU(s):                   32
  On-line CPU(s) list:    0-31
Vendor ID:                AuthenticAMD
  BIOS Vendor ID:         Advanced Micro Devices, Inc.
  Model name:             AMD EPYC 7313P 16-Core Processor
    BIOS Model name:      AMD EPYC 7313P 16-Core Processor                Unknown CPU @ 3.0GHz
    BIOS CPU family:      107
    CPU family:           25
    ...

16 SMT2 cores (siblings are 16-31)


#lsblk -N
NAME    TYPE MODEL                      SERIAL              REV TRAN   RQ-SIZE  MQ
nvme3n1 disk SAMSUNG MZQL21T9HCJR-00A07 S64GNJ0T605178 GDC5602Q nvme      1023  32
nvme2n1 disk SAMSUNG MZQL21T9HCJR-00A07 S64GNJ0T605128 GDC5602Q nvme      1023  32
nvme0n1 disk SAMSUNG MZQL21T9HCJR-00A07 S64GNJ0T605125 GDC5602Q nvme      1023  32
nvme1n1 disk SAMSUNG MZQL21T9HCJR-00A07 S64GNJ0T605127 GDC5602Q nvme      1023  32

Where nvme0n1 is the one I'm actually using.

I'm on 6.12.0-0.rc5.44.eln143.x86_64  which is v6.12-rc5 with RHEL .config.  This
should have little to no franken-kernel bits but now that I have the machine
I'll build from upstream (with the RHEL .config still) to make sure.

We did see it on all the RCs so far. 


> Anyway I have some follow-ups, first let me trim the fio command for readability:
> fio --rw randwrite --bs 4k --runtime 1m --fsync 0 --iodepth 32 --direct 1 --ioengine libaio --numjobs 8 --size 30g --nrfiles 1 --loops 1 --name default --randrepeat 1 --time_based --group_reporting --directory /testfs
> 
> dropping defaults nr_files, loops, fsync, randrepeat
> fio --rw randwrite --bs 4k --runtime 1m --iodepth 32 --direct 1 --ioengine libaio --numjobs 8 --size 30g --name default --time_based --group_reporting --directory /testfs
> 
> Adding the CPU affinities directly:
> fio --cpus_allowed 1-8 --rw randwrite --bs 4k --runtime 1m --iodepth 32 --direct 1 --ioengine libaio --numjobs 8 --size 30g --name default --time_based --group_reporting --directory /testfs
>

Fair enough.  It should work the same with taskset I suppose except the below bit. I've
been given this from our perforance team. They have a framework that produces nice html
pages with red and green results and graphs and whatnot.  Right now it's in the form of
a script that pulls the KB/s number of out the json output which is nice and keeps me
from going crosseyed looking at the full fio run output.

> Now I was wondering about the following:
> Is it actually the kworker (not another fio) being preempted? (I'm pretty sure it is)
> To test: --cpus_allowed_policy split (each fio process gets it's own CPU).

with  --cpus-allowed and --cpus_allowed_policy split the results with DELAY_DEQUEUE are
better (540MB/s) but with NO_DELAY_DEQUEUE they are also better (640 MB/s). It was
510MB/s and 590MB/s before. 

> 
> You wrote:
> >I was thinking maybe the preemption was preventing some batching of IO completions or
> >initiations. But that was wrong it seems.
> 
> So while it doesn't reproduce for me, the only thing being preempted regularly is
> the kworker (running iomap_dio_complete_work). I don't quite follow the "that was
> wrong it seems" part then. Could you elaborate?
>

I was thinking that the fio batch test along with the disabling WAKEUP_PREEMPTION
was telling me that it wasn't the over preemption issue, but that also I could be
wrong about...


> Could you also post the other benchmark numbers? Does any of them score higher in IOPS?
> Is --rw write the same issue if you set --bs 4k (assuming you set a larger bs for seqwrite).
>

I don't have numbers for all of the other flavors but I ran --rw write --bs 4k:

DELAY_DEQUEUE     ~590MB/s
NO_DELAY_DEQUEUE  ~840MB/s

Those results are not good for DELAY_DEQUEUE either.

> Can you set the kworkers handling completions to SCHED_BATCH too? Just to confirm.

I think I did the wrong kworkes the first time. So I'll try again to figure out which
kworkers to twiddle (or I'll just do all 227 of them...).



Thanks,
Phil


> 
> Regards,
> Christian
> 

-- 


