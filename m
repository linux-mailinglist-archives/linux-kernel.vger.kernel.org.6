Return-Path: <linux-kernel+bounces-551382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 652BEA56BC1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 516923B24A6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B5A21CFFA;
	Fri,  7 Mar 2025 15:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rEDTa4tF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9628221C9FD;
	Fri,  7 Mar 2025 15:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360774; cv=none; b=bqnQ7/g8o1VmHWTG4W/NrlWEPIJwEooQ/+/eYLkjkxZY6d74v+2karN1LPOHRhyQRoDoBtu+iXJFAX49Q7w5myFrgDrAf9fsXzF4K3i75FYgtg+64mucDHqwHOituWfeV9pE8m7yTfIy2qeBHz9E/U4NvA5Y46js16SiY01d6ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360774; c=relaxed/simple;
	bh=segi232KmrexYad75hk2+4+LsAxjj931hFv+eA6sXTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/IF7tFHyh9fmo6oRnTNqOPpCnJAlcY8gE6oGLPtRk/xBMT9e7yDEFN04v/sWFTlzAskjvijhq4WTzyG1J9BZAAW1gd+HS7UQxvB/k1D4co5YGTI4UulniRbZ1eR/WhZ12xtfXcc2igEH/c5PDc5HLtOWxF6ah9EH0/0Q1/fZic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rEDTa4tF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676F2C4CEE7;
	Fri,  7 Mar 2025 15:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741360774;
	bh=segi232KmrexYad75hk2+4+LsAxjj931hFv+eA6sXTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rEDTa4tFmzGkVEBT8/wN5XbDIOQwdpmNXz1XE9GAMIirUhfDM+cmAJ8EmVWvu9/6O
	 8eY3Nez6DTvGyXuPHGHIyXXXKKAeaK/T6sTsLxb2UzJBoVuKFC3ezmVGEiKIoSK9iA
	 MOEf9htTB+jL7j+4ew23goe3H/wRvGg1L3SX20Ao=
Date: Fri, 7 Mar 2025 16:19:30 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Danilo Krummrich <dakr@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Dave Airlie <airlied@gmail.com>, Gary Guo <gary@garyguo.net>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>, Ben Skeggs <bskeggs@nvidia.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	paulmck@kernel.org
Subject: Re: [RFC PATCH 0/3] gpu: nova-core: add basic timer subdevice
 implementation
Message-ID: <2025030749-pulp-juniper-c35e@gregkh>
References: <Z8cmBWB8rl97-zSG@phenom.ffwll.local>
 <20250304164201.GN133783@nvidia.com>
 <Z8f9mgD4LUJN_dWw@phenom.ffwll.local>
 <20250305151012.GW133783@nvidia.com>
 <Z8l8HgZOV7sDWqBh@phenom.ffwll.local>
 <20250306153236.GE354511@nvidia.com>
 <Z8rKVZolu8n6lB1P@phenom.ffwll.local>
 <20250307123255.GK354511@nvidia.com>
 <2025030753-celtic-quarry-1799@gregkh>
 <20250307144629.GN354511@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307144629.GN354511@nvidia.com>

On Fri, Mar 07, 2025 at 10:46:29AM -0400, Jason Gunthorpe wrote:
> On Fri, Mar 07, 2025 at 03:00:09PM +0100, Greg KH wrote:
> > On Fri, Mar 07, 2025 at 08:32:55AM -0400, Jason Gunthorpe wrote:
> > > On Fri, Mar 07, 2025 at 11:28:37AM +0100, Simona Vetter wrote:
> > > 
> > > > > I wouldn't say it is wrong. It is still the correct thing to do, and
> > > > > following down the normal cleanup paths is a good way to ensure the
> > > > > special case doesn't have bugs. The primary difference is you want to
> > > > > understand the device is dead and stop waiting on it faster. Drivers
> > > > > need to consider these things anyhow if they want resiliency against
> > > > > device crashes, PCI link wobbles and so on that don't involve
> > > > > remove().
> > > > 
> > > > Might need to revisit that discussion, but Greg didn't like when we asked
> > > > for a pci helper to check whether the device is physically gone (at least
> > > > per the driver model). Hacking that in drivers is doable, but feels
> > > > icky.
> > > 
> > > I think Greg is right here, the driver model has less knowledge than
> > > the driver if the device is alive.
> > 
> > That's not why I don't want this.  Think about this sequence:
> > 	if (!device_is_gone(dev)) {
> > 		// do something
> > 	}
> > right after you check it, the value can change. 
> 
> Oh, I imagined this would latch off. For instance if you hotunplug a
> PCI struct device then that struct device will be destroyed
> eventually.

That is true.

> If in the meantime a PCI device is re-discovered at the
> same BDF it would have to wait until the prior one is sufficiently
> destroyed before creating a new struct device and getting plugged in.

I think we just create a new one and away you go!  :)

Just like other busses, if PCI can't handle this at the core hotplug
layer (i.e. by giving up new resources to new devices) then the bus core
for it should handle this type of locking scheme as really, that feels
wrong.  A new device is a new device, should have nothing to do with any
old previous one ever plugged in.

> > Handle the real cases, like you are are saying here, and then all should
> > be ok.
> 
> Yes, if you handle physical device unplug, PCI device unplug, and PCI
> device failure recovery then you cover all the actual production use
> cases. That is already so comprehesive and hard that driver writers
> will be overjoyed with the result anyhow :)

Kernel programming is hard, let's go shopping :)

greg k-h

