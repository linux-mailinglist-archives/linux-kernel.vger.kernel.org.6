Return-Path: <linux-kernel+bounces-394865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B444A9BB510
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1086BB22F03
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6722F1B394D;
	Mon,  4 Nov 2024 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GRg3UNVE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A74F1B81DC
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 12:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730724624; cv=none; b=B7+Sxftb2RKNxnEbTmdzhKKlHxrh+yvjBKGLqAWqP/0KJrwar8vAY0ts+3wJrkQh1qldLr3RRqJTwlHhOd9IH1h0Ul6vrBqXwFu4YstmVMqTsxefSLYkl2Isxs/qbZk3SwYjqkc3eXWi0Pk79MkYykju6O/8TvA/RcQLJUzNOL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730724624; c=relaxed/simple;
	bh=6Vs7RnxM0PPIPR176+jQh/FJYFtgzgGBYS8ERCBs6p0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GiRXSyArCUeiAJS2XR9PQHhlWds8aAA9ymvVghFTOT8v7K+rGWYJYK3dNyJXo2t0SrA9P+y9ppBKUpSGRsrD3VL4pEujQ9zukpNraMzQCokb8jTkm529qU6BUL4MK3I0suzBpgpPoDGsTvQEi2GhwhXfxPjEMhOQ5k4bTKikN/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GRg3UNVE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730724622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8E/nhGgU8US2+ryP2QOllx2j4qex9yMTF6GATQv1ReY=;
	b=GRg3UNVEYu5UQSymivC98O/8jVEjyAHkuXmnmqGHfwEUsvf1X9PYjkpntKeDZ/F12IWunK
	KL7uSh7YZkgSpGsN3m4aT/IljH+3NyZVzCJgjdjb6SWaJNgTB9Up7d+HsteKlynqvDAfL5
	7w02uZbdSt9zjSbg4fXjR5njlgYNfx0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-ejJBPdydOJiMoZdYpLmomQ-1; Mon,
 04 Nov 2024 07:50:18 -0500
X-MC-Unique: ejJBPdydOJiMoZdYpLmomQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D22271955F2C;
	Mon,  4 Nov 2024 12:50:16 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.88.138])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D42BD300018D;
	Mon,  4 Nov 2024 12:50:12 +0000 (UTC)
Date: Mon, 4 Nov 2024 07:50:09 -0500
From: Phil Auld <pauld@redhat.com>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de
Subject: Re: [PATCH 17/24] sched/fair: Implement delayed dequeue
Message-ID: <20241104125009.GA749675@pauld.westford.csb>
References: <20240727102732.960974693@infradead.org>
 <20240727105030.226163742@infradead.org>
 <20241101124715.GA689589@pauld.westford.csb>
 <ed46d844-e0b0-46fd-a164-9bfad538a7a9@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed46d844-e0b0-46fd-a164-9bfad538a7a9@arm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4


Hi Dietmar,

On Mon, Nov 04, 2024 at 10:28:37AM +0100 Dietmar Eggemann wrote:
> Hi Phil,
> 
> On 01/11/2024 13:47, Phil Auld wrote:
> > 
> > Hi Peterm
> > 
> > On Sat, Jul 27, 2024 at 12:27:49PM +0200 Peter Zijlstra wrote:
> >> Extend / fix 86bfbb7ce4f6 ("sched/fair: Add lag based placement") by
> >> noting that lag is fundamentally a temporal measure. It should not be
> >> carried around indefinitely.
> >>
> >> OTOH it should also not be instantly discarded, doing so will allow a
> >> task to game the system by purposefully (micro) sleeping at the end of
> >> its time quantum.
> >>
> >> Since lag is intimately tied to the virtual time base, a wall-time
> >> based decay is also insufficient, notably competition is required for
> >> any of this to make sense.
> >>
> >> Instead, delay the dequeue and keep the 'tasks' on the runqueue,
> >> competing until they are eligible.
> >>
> >> Strictly speaking, we only care about keeping them until the 0-lag
> >> point, but that is a difficult proposition, instead carry them around
> >> until they get picked again, and dequeue them at that point.
> > 
> > This one is causing a 10-20% performance hit on our filesystem tests.
> > 
> > On 6.12-rc5 (so with the latest follow ons) we get:
> > 
> > with DELAY_DEQUEUE the bandwidth is 510 MB/s
> > with NO_DELAY_DEQUEUE the bandwidth is 590 MB/s
> > 
> > The test is fio, something like this:
> > 
> > taskset -c 1,2,3,4,5,6,7,8 fio --rw randwrite --bs 4k --runtime 1m --fsync 0 --iodepth 32 --direct 1 --ioengine libaio --numjobs 8 --size 30g --nrfiles 1 --loops 1 --name default --randrepeat 1 --time_based --group_reporting --directory /testfs
> 
> I'm not seeing this on my i7-13700K running tip sched/core (1a6151017ee5
> - sched: psi: pass enqueue/dequeue flags to psi callbacks directly
> (2024-10-26 Johannes Weiner)) (6.12.0-rc4 - based)
> 
> Using 'taskset 0xaaaaa' avoiding SMT and running only on P-cores.
> 
> vanilla features: 990MB/s (mean out of 5 runs, σ:  9.38)
> NO_DELAY_DEQUEUE: 992MB/s (mean out of 5 runs, σ: 10.61)
> 
> # sudo lshw -class disk -class storage
>   *-nvme                    
>        description: NVMe device
>        product: GIGABYTE GP-ASM2NE6500GTTD
>        vendor: Phison Electronics Corporation
>        physical id: 0
>        bus info: pci@0000:01:00.0
>        logical name: /dev/nvme0
>        version: EGFM13.2
>        ...
>        capabilities: nvme pciexpress msix msi pm nvm_express bus_master cap_list
>        configuration: driver=nvme latency=0 nqn=nqn.2014.08.org.nvmexpress:19871987SN215108954872 GIGABYTE GP-ASM2NE6500GTTD state=live
>        resources: irq:16 memory:70800000-70803fff
> 
> # mount | grep ^/dev/nvme0
> /dev/nvme0n1p2 on / type ext4 (rw,relatime,errors=remount-ro)
> 
> Which disk device you're using?

Most of the reports are on various NVME drives (samsung mostly I think).


One thing I should add is that it's all on LVM: 


vgcreate vg /dev/nvme0n1 -y
lvcreate -n thinMeta -L 3GB vg -y
lvcreate -n thinPool -l 99%FREE vg -y
lvconvert --thinpool /dev/mapper/vg-thinPool --poolmetadata /dev/mapper/vg-thinMeta -Zn -y
lvcreate -n testLV -V 1300G --thinpool thinPool vg
wipefs -a /dev/mapper/vg-testLV
mkfs.ext4 /dev/mapper/vg-testLV -E lazy_itable_init=0,lazy_journal_init=0 -F
mount /dev/mapper/vg-testLV /testfs 


With VDO or thinpool (as above) it shows on both ext4 and xfs. With fs on
drive directly it's a little more variable. Some it shows on xfs, some it show
on ext4 and not vice-versa, seems to depend on the drive or hw raid. But when
it shows it's 100% reproducible on that setup. 

It's always the randwrite numbers. The rest look fine.

Also, as yet I'm not personally doing this testing, just looking into it and
passing on the information I have. 


Thanks for taking a look. 

Cheers,
Phil

> 
> > 
> > In this case it's ext4, but I'm not sure it will be FS specific.
> > 
> > I should have the machine and setup next week to poke further but I wanted
> > to mention it now just in case any one has an "aha" moment.
> > 
> > It seems to only effect these FS loads. Other perf tests are not showing any
> > issues that I am aware of.
> 
> [...]
> 

-- 


