Return-Path: <linux-kernel+bounces-548942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2918A54B31
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F8553AFBAE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA21E20B7ED;
	Thu,  6 Mar 2025 12:50:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257311FF5FF;
	Thu,  6 Mar 2025 12:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741265438; cv=none; b=I/BmzRz+R9Tl2rWsQpfScyqkFTbt9+fWzx8m2dbrKBlVkq2+dcescI44QlGNSspUcjQmRntUjZMkOmCc2CSZgbQRRqmCSEanwTtxNDZL2bPWfrKs0D04hkq/WWOt6swQL6DEQH+FyLvYQ0HX+p5sBcZWJJ8SiIPxTTxNHac+d+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741265438; c=relaxed/simple;
	bh=qAIaa5YTxPQth20rjdhj3lsn7De7pEvS1miIRXCuVQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vn3mGJmtWvRhgc+zCnHrpUrF7phsmjnuGmYm5fx7Htt5j39QHoFtTVwPhKDmdi63zK7fvdP8zM5VLez4eW/Wrsbz+veaz9jEb5YpIXwXE0KmEpoPyfIqQaIil7uiZM5EonITtFdklZcJUcPix5dZOPqKEh/VHsWNdI72hyOCrYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43E1E1007;
	Thu,  6 Mar 2025 04:50:47 -0800 (PST)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 392143F673;
	Thu,  6 Mar 2025 04:50:33 -0800 (PST)
Date: Thu, 6 Mar 2025 12:50:17 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org, arm-scmi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [Bug report] Memory leak in scmi_device_create
Message-ID: <Z8maCX5QJRqODl6u@pluto>
References: <Z8g8vhS9rqQ_ez48@google.com>
 <Z8iFeEWq16pNQdMa@pluto>
 <Z8mCbc2Z2QGd3f8M@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8mCbc2Z2QGd3f8M@google.com>

On Thu, Mar 06, 2025 at 11:09:33AM +0000, Alice Ryhl wrote:
> On Wed, Mar 05, 2025 at 05:10:16PM +0000, Cristian Marussi wrote:
> > On Wed, Mar 05, 2025 at 11:59:58AM +0000, Alice Ryhl wrote:
> > > Dear SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE (SCPI/SCMI) Message
> > > Protocol drivers maintainers,
> > > 
> > > I flashed a v6.13-rc3 kernel onto a Rock5B board and noticed the
> > > following output in my terminal:
> > > 
> > > [  687.694465] kmemleak: 4 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
> > > 
> > > It seems that there is a memory leak for devices created with
> > > scmi_device_create.
> > > 
> > `
> > Hi Alice,
> > 
> > thanks for this report.
> > 
> > > This was with a kernel running v6.13-rc3, but as far as I can tell, no
> > > relevant changes have landed since v6.13-rc3. My tree *does* include
> > > commit 295416091e44 ("firmware: arm_scmi: Fix slab-use-after-free in
> > > scmi_bus_notifier()"). I've only seen this kmemleak report once, so it's
> > > not happening consistently.
> > > 
> > > See below for the full kmemleak report.
> > > 
> > > Alice
> > > 
> > > $ sudo cat /sys/kernel/debug/kmemleak
> > > unreferenced object 0xffffff8106c86000 (size 2048):
> > >   comm "swapper/0", pid 1, jiffies 4294893094
> > >   hex dump (first 32 bytes):
> > >     02 00 00 00 10 00 00 00 c0 01 bc 03 81 ff ff ff  ................
> > >     60 67 ba 03 81 ff ff ff 18 60 c8 06 81 ff ff ff  `g.......`......
> > >   backtrace (crc feae9680):
> > >     [<00000000197aa008>] kmemleak_alloc+0x34/0xa0
> > >     [<0000000056fe02c9>] __kmalloc_cache_noprof+0x1e0/0x450
> > >     [<00000000a8b3dfe1>] __scmi_device_create+0xb4/0x2b4
> > >     [<000000008714917b>] scmi_device_create+0x40/0x194
> > >     [<000000001818f3cf>] scmi_chan_setup+0x144/0x3b8
> > >     [<00000000970bad38>] scmi_probe+0x584/0xa78
> > >     [<000000002600d2fd>] platform_probe+0xbc/0xf0
> > >     [<00000000f6f556b4>] really_probe+0x1b8/0x520
> > >     [<00000000eed93d59>] __driver_probe_device+0xe0/0x1d8
> > >     [<00000000d613b754>] driver_probe_device+0x6c/0x208
> > >     [<00000000187a9170>] __driver_attach+0x168/0x328
> > >     [<00000000e3ff1834>] bus_for_each_dev+0x14c/0x178
> > >     [<00000000984a3176>] driver_attach+0x34/0x44
> > >     [<00000000fc35bf2a>] bus_add_driver+0x1bc/0x358
> > >     [<00000000747fce19>] driver_register+0xc0/0x1a0
> > >     [<0000000081cb8754>] __platform_driver_register+0x40/0x50
> > > unreferenced object 0xffffff8103bc01c0 (size 32):
> > 
> > I could not reproduce on my setup, even though I run a system with
> > all the existent SCMI protocols (and related drivers) enabled (and
> > so a lot of device creations) and a downstream test driver that causes
> > even more SCMI devices to be created/destroyed at load/unload.
> > 
> > Coming down the path from scmi_chan_setup(), it seems something around
> > transport devices creation, but it is not obvious to me where the leak
> > could hide....
> > 
> > ...any particular setup on your side ? ...using LKMs, loading/unloading,
> > any usage pattern that could help me reproduce ?
> 
> I looked into this a bit more, and actually it does happen consistently.
> It's just that kmemleak doesn't report it until 10 minutes after
> booting, so I did not notice it.
> 
> As for my setup, well, I boot the kernel over pxe and the rootfs is
> mounted over NFSv4. The memory leak happens even if I don't do anything
> at all - I just boot and wait. The device is a Radxa Rock5B.
> 
> Not sure what other information there is to give.
> 

My question as stated above was mainly to understand if the SCMI stack
was built-in or compiled as loadable modules (lsmod|grep -i scmi)...
...I am just to try to pin down a possible 'more-vulnerable' configuration..
..I could not see any report even triggering a kmemleak scan on v6.14-rc5
BUT I only tested with a fully built-in SCMI stack indeed as of now...so
the question.

> I tried again with v6.14-rc5, and I still got the leak:

Ok...thanks I will investigate with different configs.

Thanks,
Cristian

