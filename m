Return-Path: <linux-kernel+bounces-549240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1AAA54F75
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7B7A3B0F60
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9A5192D8F;
	Thu,  6 Mar 2025 15:47:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0975C148FF5;
	Thu,  6 Mar 2025 15:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741276069; cv=none; b=pk+D+hue2UFMyysvC03sdYwYFsyPyetvvESykDhoAOkWewDeYnQW3W03U5J/O3ZhSUv4KS3hkJ2ccKuZ5gFyATwpPBnte00/gbczxR6YXxRm9eoAAwkbOQkZQwEkG+amAn8sv0lYpVDAAahL41beX2A1ymWD5b5NmYJUlf4tvE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741276069; c=relaxed/simple;
	bh=WIZBv40mWlqcIydIqglr2m4fLMN4do/AmNfg9Mw2EhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzO/+zUBxVkvKisZh9ueqikMBmR1F3T4BFk2GFWKVAvTbDIb5j4iPT0nkuA80i46UrnELrOKEd1aLr0uTXnjvsChi6IJCoMRWY0+FrxmRTDamwZG6e9VCPqchhp1vbPA1f2eF2uRck5YWbVB0z/3vTRz7NxhuK6yTt8McBZwsGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FB111007;
	Thu,  6 Mar 2025 07:47:51 -0800 (PST)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3C213F66E;
	Thu,  6 Mar 2025 07:47:36 -0800 (PST)
Date: Thu, 6 Mar 2025 15:47:27 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org, arm-scmi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [Bug report] Memory leak in scmi_device_create
Message-ID: <Z8nDj129ZVeZBVSp@pluto>
References: <Z8g8vhS9rqQ_ez48@google.com>
 <Z8iFeEWq16pNQdMa@pluto>
 <Z8mCbc2Z2QGd3f8M@google.com>
 <Z8my4MZ-In0ibxVY@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8my4MZ-In0ibxVY@arm.com>

On Thu, Mar 06, 2025 at 02:36:16PM +0000, Catalin Marinas wrote:
> On Thu, Mar 06, 2025 at 11:09:33AM +0000, Alice Ryhl wrote:
> > On Wed, Mar 05, 2025 at 05:10:16PM +0000, Cristian Marussi wrote:
> > > On Wed, Mar 05, 2025 at 11:59:58AM +0000, Alice Ryhl wrote:
> > > > This was with a kernel running v6.13-rc3, but as far as I can tell, no
> > > > relevant changes have landed since v6.13-rc3. My tree *does* include
> > > > commit 295416091e44 ("firmware: arm_scmi: Fix slab-use-after-free in
> > > > scmi_bus_notifier()"). I've only seen this kmemleak report once, so it's
> > > > not happening consistently.
> > > > 
> > > > See below for the full kmemleak report.
> > > > 
> > > > Alice
> > > > 
> > > > $ sudo cat /sys/kernel/debug/kmemleak
> > > > unreferenced object 0xffffff8106c86000 (size 2048):
> > > >   comm "swapper/0", pid 1, jiffies 4294893094
> > > >   hex dump (first 32 bytes):
> > > >     02 00 00 00 10 00 00 00 c0 01 bc 03 81 ff ff ff  ................
> > > >     60 67 ba 03 81 ff ff ff 18 60 c8 06 81 ff ff ff  `g.......`......
> > > >   backtrace (crc feae9680):
> > > >     [<00000000197aa008>] kmemleak_alloc+0x34/0xa0
> > > >     [<0000000056fe02c9>] __kmalloc_cache_noprof+0x1e0/0x450
> > > >     [<00000000a8b3dfe1>] __scmi_device_create+0xb4/0x2b4
> > > >     [<000000008714917b>] scmi_device_create+0x40/0x194
> > > >     [<000000001818f3cf>] scmi_chan_setup+0x144/0x3b8
> > > >     [<00000000970bad38>] scmi_probe+0x584/0xa78
> > > >     [<000000002600d2fd>] platform_probe+0xbc/0xf0
> > > >     [<00000000f6f556b4>] really_probe+0x1b8/0x520
> > > >     [<00000000eed93d59>] __driver_probe_device+0xe0/0x1d8
> > > >     [<00000000d613b754>] driver_probe_device+0x6c/0x208
> > > >     [<00000000187a9170>] __driver_attach+0x168/0x328
> > > >     [<00000000e3ff1834>] bus_for_each_dev+0x14c/0x178
> > > >     [<00000000984a3176>] driver_attach+0x34/0x44
> > > >     [<00000000fc35bf2a>] bus_add_driver+0x1bc/0x358
> > > >     [<00000000747fce19>] driver_register+0xc0/0x1a0
> > > >     [<0000000081cb8754>] __platform_driver_register+0x40/0x50
> > > > unreferenced object 0xffffff8103bc01c0 (size 32):
> > > 
> > > I could not reproduce on my setup, even though I run a system with
> > > all the existent SCMI protocols (and related drivers) enabled (and
> > > so a lot of device creations) and a downstream test driver that causes
> > > even more SCMI devices to be created/destroyed at load/unload.
> > > 
> > > Coming down the path from scmi_chan_setup(), it seems something around
> > > transport devices creation, but it is not obvious to me where the leak
> > > could hide....
> > > 
> > > ...any particular setup on your side ? ...using LKMs, loading/unloading,
> > > any usage pattern that could help me reproduce ?
> > 
> > I looked into this a bit more, and actually it does happen consistently.
> > It's just that kmemleak doesn't report it until 10 minutes after
> > booting, so I did not notice it.
> 
> You can force the scanning with:
> 
>   echo scan > /sys/kernel/debug/kmemleak
> 
> Just do it a couple of times after boot, no need to wait 10 min for the
> default background scanning.
> 
> > user@rk3588-ci:~$ sudo cat /sys/kernel/debug/kmemleak
> > unreferenced object 0xffffff81068c0000 (size 2048):
> >   comm "swapper/0", pid 1, jiffies 4294893128
> >   hex dump (first 32 bytes):
> >     02 00 00 00 10 00 00 00 40 a3 7a 03 81 ff ff ff  ........@.z.....
> >     60 c8 79 03 81 ff ff ff 18 00 8c 06 81 ff ff ff  `.y.............
> >   backtrace (crc 60df30fb):
> >     kmemleak_alloc+0x34/0xa0
> >     __kmalloc_cache_noprof+0x1e0/0x450
> >     __scmi_device_create+0xb4/0x2b4
> 
> Is this the kzalloc() for sizeof(*scmi_dev)? It's surprisingly large, I
> thought it would go for the kmalloc-1k slab as struct device is below
> this side, at least for my builds. Anyway...
> 
> >     scmi_device_create+0x40/0x194
> >     scmi_chan_setup+0x144/0x3b8
> >     scmi_probe+0x51c/0x9fc
> >     platform_probe+0xbc/0xf0
> >     really_probe+0x1b8/0x520
> >     __driver_probe_device+0xe0/0x1d8
> >     driver_probe_device+0x6c/0x208
> >     __driver_attach+0x168/0x328
> >     bus_for_each_dev+0x14c/0x178
> >     driver_attach+0x34/0x44
> >     bus_add_driver+0x1bc/0x358
> >     driver_register+0xc0/0x1a0
> >     __platform_driver_register+0x40/0x50
> > unreferenced object 0xffffff81037aa340 (size 32):
> >   comm "swapper/0", pid 1, jiffies 4294893128
> >   hex dump (first 32 bytes):
> >     5f 5f 73 63 6d 69 5f 74 72 61 6e 73 70 6f 72 74  __scmi_transport
> >     5f 64 65 76 69 63 65 5f 72 78 5f 31 30 00 ff ff  _device_rx_10...
> >   backtrace (crc 8dab7ca7):
> >     kmemleak_alloc+0x34/0xa0
> >     __kmalloc_node_track_caller_noprof+0x234/0x528
> >     kstrdup+0x48/0x80
> >     kstrdup_const+0x30/0x3c
> 
> These are referenced from the main structure above, so they'd be
> reported as leaks as well.
> 
> This loop in scmi_device_create() looks strange:
> 
> 	list_for_each_entry(rdev, phead, node) {
> 		struct scmi_device *sdev;
> 
> 		sdev = __scmi_device_create(np, parent,
> 					    rdev->id_table->protocol_id,
> 					    rdev->id_table->name);
> 		/* Report errors and carry on... */
> 		if (sdev)
> 			scmi_dev = sdev;
> 		else
> 			pr_err("(%s) Failed to create device for protocol 0x%x (%s)\n",
> 			       of_node_full_name(parent->of_node),
> 			       rdev->id_table->protocol_id,
> 			       rdev->id_table->name);
> 	}
> 
> We can override scmi_dev a few times in the loop and lose the previous
> sdev allocations. Is this intended?

Yes...it is weird..but by design I would say :P ...

...because this is called to instantiate one single device OR instantiate at
once all the multiple devices needed for a protocol: in this latter case it
returns just one of the created devices to signal success or NULL if all the
devices' creation failed....we dont need to keep the allocated devices references
anyway here since on success those devices are now referenced and kept on the
SCMI bus, so they can be searched/scanned/destroyed from there.

But maybe this is the crux of the matter, or what fools kmemleak...I
will try to reproduce again.

Thanks,
Cristian

