Return-Path: <linux-kernel+bounces-532953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBFEA4541B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 04:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0494F3A6C23
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 03:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901F725A634;
	Wed, 26 Feb 2025 03:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="daExpCAW"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424DE25A347
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 03:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740541283; cv=none; b=aVIrTsWyDgHFcllYlS2BI260RVAvfitxrUshBBfKxsIHQyAIaNWetOCx4Y9JrcukHNbR22FXXNFDY2rwVRXM0jl1EwsGUlh3OjxcVUszMlyC2qlkwu+8p0IsQvjonzKS4sCaJvL/OKRDBjw1k5oxdLp7BkAvMzL92w6hE+8OF30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740541283; c=relaxed/simple;
	bh=TIMgNlldN09jbcda0Ldg3qHCU6hLWY7tlkr9P0SXZus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6O7l+9dK6iSFpcXlf9yc1+HMqcrK1pz76kavEUJj4RcSnkXe5ZUad6ceebZ4YKF0z92sQGAFWZvWHSVfaCcMwckghsi0zAqsAK+2Rg36wx1fVS4PF67fIAMW89Zn6npuGWW7jeWZv4A9j54Cqa51tBoAnBGn3vvs7WthR8zxyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=daExpCAW; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 26 Feb 2025 03:41:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740541269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1ApV4Mgd4hGqFpTtNaZay3c4iLK5Xdk13X7QQhQ4Iuo=;
	b=daExpCAWQwtF7tSesKiz7ATNB3s/cboe16ZErPKAivt9U9jEYF5TU5z9yGLrVP794lJaEb
	d/DdptFu+mBnFknKyRd3wRhkzCSe6SCxblt4rkUaZzrm/1DJ0a/DXqJrw7S8D+kUmPy9QD
	JTs/G9Li+/ApSC3SiZvqjMFS5GVHo+g=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Parav Pandit <parav@mellanox.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Maher Sanalla <msanalla@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/core: fix a NULL-pointer dereference in
 hw_stat_device_show()
Message-ID: <Z76NUKn6SCrrw1vt@google.com>
References: <Z7gARTF0mpbOj7gN@google.com>
 <CY8PR12MB7195F3ACB8CFA05C4B8D26D3DCC72@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250221174347.GA314593@nvidia.com>
 <CY8PR12MB7195A82F6CE17D9BDC674D72DCC62@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250224151127.GT50639@nvidia.com>
 <CY8PR12MB7195E91917FD5329932FA3FCDCC02@CY8PR12MB7195.namprd12.prod.outlook.com>
 <Z7z_NcGWIr3_Dxtt@google.com>
 <20250224233004.GD520155@nvidia.com>
 <Z708JNt6-vPIuDBm@google.com>
 <CY8PR12MB71952D004721897B816B1385DCC32@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB71952D004721897B816B1385DCC32@CY8PR12MB7195.namprd12.prod.outlook.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 25, 2025 at 04:34:11AM +0000, Parav Pandit wrote:
> 
> 
> > From: Roman Gushchin <roman.gushchin@linux.dev>
> > Sent: Tuesday, February 25, 2025 9:12 AM
> > 
> > On Mon, Feb 24, 2025 at 07:30:04PM -0400, Jason Gunthorpe wrote:
> > > On Mon, Feb 24, 2025 at 11:22:29PM +0000, Roman Gushchin wrote:
> > > > On Mon, Feb 24, 2025 at 03:16:46PM +0000, Parav Pandit wrote:
> > > > >
> > > > >
> > > > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > > > Sent: Monday, February 24, 2025 8:41 PM
> > > > > >
> > > > > > On Sat, Feb 22, 2025 at 06:34:21PM +0000, Parav Pandit wrote:
> > > > > > > ib_setup_device_attrs() should be merged to
> > > > > > > ib_setup_port_attrs() by renaming ib_setup_port_attrs() to be
> > > > > > > generic.  To utilize the group initialization
> > > > > > > ib_setup_port_attrs() needs to move up before device_add().
> > > > > >
> > > > > > It needs more than that, somehow you have to maintain two groups
> > > > > > list or somehow remove the coredev->dev.groups assignment..
> > > > > >
> > > > > I was thinking that if both device and port attr setup is done in
> > > > > same function, there is knowledge of is_full_dev that can be used
> > > > > for device level hw_stats setup. (similar to how its done at port
> > > > > level).
> > > >
> > > > Given that there is a bit of discussion on how to move forward with
> > > > this, can we please merge the trivial fix in the mean time? (Just
> > > > sent out v2 with the fixed commit log).
> > >
> > > Well, the issue now is the ABI break
> > >
> > > If the right answer is to remove the sysfs entirely then it doesn't
> > > make sense to make it work in the stable and LTS kernels since that
> > > would create users. Currently it is fully broken so there are no
> > > users. Can we say that so certainly after it is fixed?
> > 
> > It's a good point.
> > 
> > Ok, then we need something like this (obviously, coded more nicely):
> > 
> Yes, this is my suggestion too in little more detail at [1].
> 
> [1] https://lore.kernel.org/linux-rdma/20250224233109.GE520155@nvidia.com/T/#m43a5974cad17566080eeb64c6d5327aad4f0a852

I tried to implement what you suggested, but apparently it's complicated.
You can't call ib_setup_port_attrs() before device_add() because
kobject_init_and_add() fails. Maybe an option is to add "hw_counters"
dynamically similar to ports, Idk.

Anyway, sent a slightly different version, please, take a look.

Thanks!

