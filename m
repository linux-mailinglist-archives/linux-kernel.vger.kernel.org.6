Return-Path: <linux-kernel+bounces-549670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 074E9A55543
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD3B3189311F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A89A26B957;
	Thu,  6 Mar 2025 18:43:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBED269CE8;
	Thu,  6 Mar 2025 18:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741286635; cv=none; b=e/aHlsXDQjVkjGzmfDD5+wy405tvqV2CgOrDm9jxG5ZK+ibqwl/NT1TROJUmnkjqEciigzIVqM2mQ++/ezyIEQzw9UFjMADpTtAeFSwLwI5a8uUy43ER1iOYXaKq7hZyhA8bdWiGh2tnQwvVj1xG7Ac9I1VyIvAtdEAQ3URzkbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741286635; c=relaxed/simple;
	bh=CnUH+VX9AF2B3Qo/OiIZWOtpvxNv168dZVeCLZvdv6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=InbOZWWFYCrHMJYJznHq5CXAOrtr05K2Rr+Uqiep+iW9R6LW3oNLz1pfm5Xs1StmavJyzFitPOI4YfPNWymB0hT30zLdtu/G77gh0nnPt7jIMy8i5LBgOx90Kj2oRCS9XjVSaX4iHG/X7997xa1mlzt/FgWel32cU40pI+SnsUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59F68169E;
	Thu,  6 Mar 2025 10:44:03 -0800 (PST)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE5EE3F673;
	Thu,  6 Mar 2025 10:43:48 -0800 (PST)
Date: Thu, 6 Mar 2025 18:43:45 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org, arm-scmi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [Bug report] Memory leak in scmi_device_create
Message-ID: <Z8ns4T6pas9DEy8B@pluto>
References: <Z8g8vhS9rqQ_ez48@google.com>
 <Z8iFeEWq16pNQdMa@pluto>
 <Z8mCbc2Z2QGd3f8M@google.com>
 <Z8my4MZ-In0ibxVY@arm.com>
 <Z8nDj129ZVeZBVSp@pluto>
 <Z8nK3uFkspy61yjP@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8nK3uFkspy61yjP@arm.com>

On Thu, Mar 06, 2025 at 04:18:38PM +0000, Catalin Marinas wrote:
> On Thu, Mar 06, 2025 at 03:47:27PM +0000, Cristian Marussi wrote:
> > On Thu, Mar 06, 2025 at 02:36:16PM +0000, Catalin Marinas wrote:
> > > This loop in scmi_device_create() looks strange:
> > > 
> > > 	list_for_each_entry(rdev, phead, node) {
> > > 		struct scmi_device *sdev;
> > > 
> > > 		sdev = __scmi_device_create(np, parent,
> > > 					    rdev->id_table->protocol_id,
> > > 					    rdev->id_table->name);
> > > 		/* Report errors and carry on... */
> > > 		if (sdev)
> > > 			scmi_dev = sdev;
> > > 		else
> > > 			pr_err("(%s) Failed to create device for protocol 0x%x (%s)\n",
> > > 			       of_node_full_name(parent->of_node),
> > > 			       rdev->id_table->protocol_id,
> > > 			       rdev->id_table->name);
> > > 	}
> > > 
> > > We can override scmi_dev a few times in the loop and lose the previous
> > > sdev allocations. Is this intended?
> > 
> > Yes...it is weird..but by design I would say :P ...
> > 
> > ...because this is called to instantiate one single device OR instantiate at
> > once all the multiple devices needed for a protocol: in this latter case it
> > returns just one of the created devices to signal success or NULL if all the
> > devices' creation failed....we dont need to keep the allocated devices references
> > anyway here since on success those devices are now referenced and kept on the
> > SCMI bus, so they can be searched/scanned/destroyed from there.
> 
> Not sure why the pointer isn't found, device_add() should link it with
> the parent. Unless something else fails, the parent is freed and the
> linked devices unreachable. I'm not familiar at all with this code, I
> just saw kmemleak and thought of replying.
> 
> The loop is still weird, scmi_chan_setup() seems to use the pointer to
> scmi_device for something more meaningful than a pass/fail check. Also
> the overall result is based only on what the last __scmi_device_create()
> return value was, irrespective of the previous iterations of the loop.
> You do have a pr_err() but no early bailing out of the loop on failure.
> I'm curious if there are any SCMI errors in the Alice's kernel log.
> 

Yes, the weirdness comes from the fact such function is used alternatively
to create a single named device (and make some use of it, like in
scmi_chan_setup) OR to create a bunch of devices for the same protocol
when no specific device is asked for (name==NULL)...anyway the case at
hand that kmemleak complains about does NOT pass through that weird loop...

...good news is, I was able to reproduce a similar report consistently
with a load/unload/load sequence....the culprit is that when looking for
a device to destroy on unload, the SCMI bus uses device_find_child()
and that bumps the device refcnt implicitly...as a result when the device
is destroyed the refcnt is NEVER found as zero and so NO device_release
is ever called...this results in dev->p private_data to be never released
and that is what kmemleak spotted (at the start of teh chain):


unreferenced object 0xffff00000f583800 (size 512):
      comm "insmod", pid 227, jiffies 4294912190
      hex dump (first 32 bytes):
        00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
        ff ff ff ff ff ff ff ff 60 36 1d 8a 00 80 ff ff  ........`6......
      backtrace (crc 114e2eed):
        kmemleak_alloc+0xbc/0xd8
        __kmalloc_cache_noprof+0x2dc/0x398
        device_add+0x954/0x12d0
        device_register+0x28/0x40
        __scmi_device_create.part.0+0x1bc/0x380
        scmi_device_create+0x2d0/0x390
        scmi_create_protocol_devices+0x74/0xf8
        scmi_device_request_notifier+0x1f8/0x2a8
        notifier_call_chain+0x110/0x3b0
        blocking_notifier_call_chain+0x70/0xb0
        scmi_driver_register+0x350/0x7f0
        0xffff80000a3b3038
        do_one_initcall+0x12c/0x730
        do_init_module+0x1dc/0x640
        load_module+0x4b20/0x5b70
        init_module_from_file+0xec/0x158
    
    $ ./scripts/faddr2line ./vmlinux device_add+0x954/0x12d0
    device_add+0x954/0x12d0:
    kmalloc_noprof at include/linux/slab.h:901
    (inlined by) kzalloc_noprof at include/linux/slab.h:1037
    (inlined by) device_private_init at drivers/base/core.c:3510
    (inlined by) device_add at drivers/base/core.c:3561

I am posting a fix.

Thanks for the report and the help.
Any feedback and testing is much welcomed :D

Cristian

