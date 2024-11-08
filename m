Return-Path: <linux-kernel+bounces-402174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D170E9C24B9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91771282206
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE31193075;
	Fri,  8 Nov 2024 18:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CcNLfsrE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4BB233D8A
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 18:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731089792; cv=none; b=Hr7L+1inLIYduVUl/bckhLXNIEGk4/++WX/lQRSyBfCP+XuX8EIw5swB9vsej5Ehd6SfMr8/PPsPXOPBqlJMP58tLHe6LHtasiNFQBK56dFrCJnw6/ppaW0454jLAxGvU5i7osffqEOrFBZHk6VtGRywoYNh59lhsCyVvl/Z57M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731089792; c=relaxed/simple;
	bh=oFbYw6WflbGHDMEYsX8lbZ/J9AVFzkBBW2pvo5RH+II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1DI9p0ZsAGUZUFEfGl+e8XbRpEChw2FTWN6zQnx2Glf9JEe5sKNAD6fg/a80I5vM9k+r6u9jNbJ2IMyhwevT/OUeAgCnwIQfOEXDeqK5Rv/C6f3D7rbgF+7LYr59FIaXATEFbhrzLNP/ZJig0WSXBL8WPrsQcVr4qJIbSdI+IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CcNLfsrE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731089789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ze5fscWKzRGkFfcvybXF5paV/LpptQEaIH4I/hX2L0=;
	b=CcNLfsrEWrG1O18XPgKLfltqMYbFSN1sJPMawX1W28sxXpDdoVyTIaV9BrgPqTP41mp4rN
	5kYW+HyAJ3Qq0mKk57AXAudGtGzpUAq+Z4jycqd4lpUPBaEFfeLWXtWlgtCjqMyGszHtDD
	aoFdpwxJmjuR4EWJTU9pHPQFAKeBRM0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-M8us77tYNPyeN-uI35GRnw-1; Fri,
 08 Nov 2024 13:16:26 -0500
X-MC-Unique: M8us77tYNPyeN-uI35GRnw-1
X-Mimecast-MFC-AGG-ID: M8us77tYNPyeN-uI35GRnw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0CAD919560AA;
	Fri,  8 Nov 2024 18:16:24 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.64.129])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 614B7195E480;
	Fri,  8 Nov 2024 18:16:20 +0000 (UTC)
Date: Fri, 8 Nov 2024 13:16:17 -0500
From: Phil Auld <pauld@redhat.com>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de
Subject: Re: [PATCH 17/24] sched/fair: Implement delayed dequeue
Message-ID: <20241108181617.GC43508@pauld.westford.csb>
References: <20240727102732.960974693@infradead.org>
 <20240727105030.226163742@infradead.org>
 <20241101124715.GA689589@pauld.westford.csb>
 <ed46d844-e0b0-46fd-a164-9bfad538a7a9@arm.com>
 <20241104125009.GA749675@pauld.westford.csb>
 <f340b1c4-f1ed-4c9f-adbb-b10cd3a17a85@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f340b1c4-f1ed-4c9f-adbb-b10cd3a17a85@arm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Nov 08, 2024 at 03:53:26PM +0100 Dietmar Eggemann wrote:
> On 04/11/2024 13:50, Phil Auld wrote:
> > 
> > Hi Dietmar,
> > 
> > On Mon, Nov 04, 2024 at 10:28:37AM +0100 Dietmar Eggemann wrote:
> >> Hi Phil,
> >>
> >> On 01/11/2024 13:47, Phil Auld wrote:
> >>>
> >>> Hi Peterm
> 
> [...]
> 
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
> > 
> > Also, as yet I'm not personally doing this testing, just looking into it and
> > passing on the information I have. 
> 
> One reason I don't see the difference between DELAY_DEQUEUE and
> NO_DELAY_DEQUEUE could be because of the affinity of the related
> nvme interrupts: 
> 
> $ cat /proc/interrupts
> 
>      CPU0 CPU1    CPU2 CPU3 CPU4    CPU5 CPU6 CPU7    CPU8 ...
> 132:   0    0  1523653    0   0        0   0    0       0  ... IR-PCI-MSIX-0000:01:00.0 1-edge nvme0q1
> 133:   0    0        0    0   0  1338451   0    0       0  ... IR-PCI-MSIX-0000:01:00.0 2-edge nvme0q2
> 134:   0    0        0    0   0        0   0    0  2252297 ... IR-PCI-MSIX-0000:01:00.0 3-edge nvme0q3
> 
> $ cat /proc/irq/132/smp_affinity_list 
> 0-2
> cat /proc/irq/133/smp_affinity_list 
> 3-5
> cat /proc/irq/134/smp_affinity_list 
> 6-8
> 
> So the 8 fio tasks from: 
> 
> # fio --cpus_allowed 1,2,3,4,5,6,7,8 --rw randwrite --bs 4k
>   --runtime 8s --iodepth 32 --direct 1 --ioengine libaio
>   --numjobs 8 --size 30g --name default --time_based
>   --group_reporting --cpus_allowed_policy shared
>   --directory /testfs
> 
> don't have to fight with per-CPU kworkers on each CPU.
> 
> e.g. 'nvme0q3 interrupt -> queue on workqueue dio/nvme0n1p2 -> 
>       run iomap_dio_complete_work() in kworker/8:x'
> 
> In case I trace the 'task_on_rq_queued(p) && p->se.sched_delayed &&
> rq->nr_running > 1) condition in ttwu_runnable() condition i only see
> the per-CPU kworker in there, so p->nr_cpus_allowed == 1.
> 
> So the patch shouldn't make a difference for this scenario?
>

If the kworker is waking up an fio task it could.  I don't think
they are bound to a single cpu.

But yes if your trace is only showing the kworker there then it would
not help.  Are you actually able to reproduce the difference?


> But maybe your VDO or thinpool setup creates waker/wakee pairs with
> wakee->nr_cpus_allowed > 1? 
>

That's certainly possible but I don't know for sure. There are well more
dio kworkers on the box than cpus though if I recall. I don't know
if they all have singel cpu affinities. 


> Does your machine has single CPU smp_affinity masks for these nvme
> interrupts?
>

I don't know. I had to give the machine back. 



Cheers,
Phil


> [...]
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 

-- 


