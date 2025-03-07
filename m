Return-Path: <linux-kernel+bounces-551226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 381D8A569D6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AF60189584B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68B921B191;
	Fri,  7 Mar 2025 14:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fzFiMSof"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BAC21ABA4;
	Fri,  7 Mar 2025 14:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741356014; cv=none; b=T8LBSRGktI28B16R78MdZa5gEmgv9nEarTEhSTNxWKLPsK8wz3dVvVWgsHDUot8d+fk1DoEOXUNS/yrJwyVYB2SnyvBsumjBIHmzCV80h+Xlrm3/Mu1kEgFfYg1YevBseejjjN1o+1qXDKCU43bYPiiS8cTKupfpwp40Fi7skwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741356014; c=relaxed/simple;
	bh=MU+C8WbcetcKkddPtvMu8XaFGjwcxIw90GFaJbuu6iU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXE+D6rr0rwLOtTsGCXw8lR8pqnPVpiI6p12SsQZSxCtzoQsJMAthvA0kAuzPtWFddrtuuA5lsXRQbYR+7mVursPwNVuW2M4XUXejOwPRvogb5/PbkKe5+Xg0aU6kxRDKdryDtUJsc3WG7IWd1yUYlcutrfApN9rGtMzBIhv5ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fzFiMSof; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1DC0C4CED1;
	Fri,  7 Mar 2025 14:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741356013;
	bh=MU+C8WbcetcKkddPtvMu8XaFGjwcxIw90GFaJbuu6iU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fzFiMSof2btrCftHqZlPnCqV4m8aPjlsYpYVE4kM2KWMwlfZErFmROsc/m1CNRawK
	 sz/IaKUDxRYmVvRkNGh9ZQV6kjwTZTg1UP/znLOqw5g3WOljGOYwUlz7Nc0ENu2GAq
	 mDevphihXfBNLZZnDLk6xJQjJcMEd5+t1JiT/MOk=
Date: Fri, 7 Mar 2025 15:00:09 +0100
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
Message-ID: <2025030753-celtic-quarry-1799@gregkh>
References: <Z8GViQzZJVFPxfNd@phenom.ffwll.local>
 <20250228184013.GF39591@nvidia.com>
 <Z8cmBWB8rl97-zSG@phenom.ffwll.local>
 <20250304164201.GN133783@nvidia.com>
 <Z8f9mgD4LUJN_dWw@phenom.ffwll.local>
 <20250305151012.GW133783@nvidia.com>
 <Z8l8HgZOV7sDWqBh@phenom.ffwll.local>
 <20250306153236.GE354511@nvidia.com>
 <Z8rKVZolu8n6lB1P@phenom.ffwll.local>
 <20250307123255.GK354511@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307123255.GK354511@nvidia.com>

On Fri, Mar 07, 2025 at 08:32:55AM -0400, Jason Gunthorpe wrote:
> On Fri, Mar 07, 2025 at 11:28:37AM +0100, Simona Vetter wrote:
> 
> > > I wouldn't say it is wrong. It is still the correct thing to do, and
> > > following down the normal cleanup paths is a good way to ensure the
> > > special case doesn't have bugs. The primary difference is you want to
> > > understand the device is dead and stop waiting on it faster. Drivers
> > > need to consider these things anyhow if they want resiliency against
> > > device crashes, PCI link wobbles and so on that don't involve
> > > remove().
> > 
> > Might need to revisit that discussion, but Greg didn't like when we asked
> > for a pci helper to check whether the device is physically gone (at least
> > per the driver model). Hacking that in drivers is doable, but feels
> > icky.
> 
> I think Greg is right here, the driver model has less knowledge than
> the driver if the device is alive.

That's not why I don't want this.  Think about this sequence:
	if (!device_is_gone(dev)) {
		// do something
	}
right after you check it, the value can change.  So all you really can
check for is:
	if (device_is_gone(dev)) {
		// clean up
	}
which is going to be racy as well, because you should already be
handling this if you care about it because the device could be gone but
not yet told the driver core / bus yet.

So this type of check can't really work, which is why I don't want
people to even consider it.

> The resiliency/fast-failure issue is not just isolated to having
> observed a proper hot-unplug, but there are many classes of failure
> that cause the device HW to malfunction that a robust driver can
> detect and recover from. mlx5 attempts to do this for instance.
> 
> It turns out when you deploy clusters with 800,000 NICs in them there
> are weird HW fails constantly and you have to be resilient on the SW
> side and try to recover from them when possible.
> 
> So I'd say checking for a -1 read return on PCI is a sufficient
> technique for the driver to use to understand if it's device is still
> present. mlx5 devices further have an interactive register operation
> "health check" that proves the device and it's PCI path is alive.

The -1 read is what PCI says will happen if the device is gone, so all
drivers have to do this if they care about it.  USB does something
different, as does all other busses.  So this is a very driver/bus
specific thing as you say.

> Failing health checks trigger recovery, which shoot downs sleeps,
> cleanly destroys stuff, resets the device, and starts running
> again. IIRC this is actually done with a rdma hot unplug/plug sequence
> autonomously executed inside the driver.
> 
> A driver can do a health check immediately in remove() and make a
> decision if the device is alive or not to speed up removal in the
> hostile hot unplug case.

Agreed.

But really, all these gyrations just to attempt to make it easier for
driver developers, the smallest number of people who will ever interact
with the device in the world, just to prevent rebooting, seems not
really all that important.

Handle the real cases, like you are are saying here, and then all should
be ok.

thanks,

greg k-h

