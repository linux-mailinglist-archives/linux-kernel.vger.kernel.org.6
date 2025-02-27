Return-Path: <linux-kernel+bounces-537442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDEAA48BE2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F36447A480E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7702E274248;
	Thu, 27 Feb 2025 22:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmfKIOC7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A6F23E343;
	Thu, 27 Feb 2025 22:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740696059; cv=none; b=FtTHz3xYhqzQuhen62b0afsfnSE7lx1S3/XgUwTMRBDz5W2YRtwFtLWAFw4dcmN9UUK7unvR/i/MMAeAfUJLoBsmH54XbSexAqtOIgTg+tq/d+zexdJwGjNcnKfYSHmxgysCNvZTc6oWeRQAQCKyp+3l6uQ6RCNeP+8v0hi8kJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740696059; c=relaxed/simple;
	bh=LaGdAUd/RllEkxWfeRFsyYdY2vwu+WCIEmuoB0PLBOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S60Qc6TLWcTad3QSdCz5iy7rNngKzywGf+FXicMISKbgemK7/Fdro6yrLr3A+N3v3lQls/Yhp5foxIRCyyRJYKlpKRX3ByRELuTWuYMPfCCnitP4iOCzG4UaewMpZd7y0ykzpnDiR5g1pItbh6X3a7cUqQocOqMGFcT3WchXQWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmfKIOC7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA23C4CEDD;
	Thu, 27 Feb 2025 22:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740696059;
	bh=LaGdAUd/RllEkxWfeRFsyYdY2vwu+WCIEmuoB0PLBOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DmfKIOC7yMzI1djFJKofbZgE/fmbeUKNGGsDEVl3q6ViaHXGl30u2+2oXYoyhO5vJ
	 ON9Fq8ghpAyrhI/ebpTLV5PSFWqmYGKnRULuR2Ns6FC4UUN4bIIbOJqyagQbol0PUT
	 VFWKQlVR+wZ6e8oswZQS0lVa64ckn5FouAMJp4e4WJOmLcYbbRxgYQWVQNvhSWA0Vs
	 O42DCyNMyy0sL0AyIsAwgTk7cBgz2H17ifAWz3hThWIpVc1oDbza12ZBlhhYpUfWtL
	 lzDcqUvwz88KbhJO3WDl7Pggoga3AmaiSYOHBKj//I9L6kxma9UzuQDxQurEvoBUtD
	 rCZSdQLbsru7Q==
Date: Thu, 27 Feb 2025 23:40:53 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Dave Airlie <airlied@gmail.com>, Gary Guo <gary@garyguo.net>,
	Joel Fernandes <joel@joelfernandes.org>,
	John Hubbard <jhubbard@nvidia.com>, Ben Skeggs <bskeggs@nvidia.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	paulmck@kernel.org
Subject: Re: [RFC PATCH 0/3] gpu: nova-core: add basic timer subdevice
 implementation
Message-ID: <Z8Dp9dM1MxhzuvmR@pollux>
References: <20250226234730.GC39591@nvidia.com>
 <Z7-0pOmWO6r_KeQI@boqun-archlinux>
 <20250227144618.GE39591@nvidia.com>
 <Z8CCKl_yA74WjpQ1@Mac.home>
 <20250227161733.GH39591@nvidia.com>
 <Z8CY7fqbtbO4v1jv@Mac.home>
 <Z8ChnwPC0UwM8xBe@cassiopeiae>
 <20250227192321.GA67615@nvidia.com>
 <Z8DYNszfONdsKZsl@boqun-archlinux>
 <20250227220013.GQ39591@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227220013.GQ39591@nvidia.com>

On Thu, Feb 27, 2025 at 06:00:13PM -0400, Jason Gunthorpe wrote:
> On Thu, Feb 27, 2025 at 01:25:10PM -0800, Boqun Feng wrote:
> > 
> > Most of the cases, it should be naturally achieved, because you already
> > bind the objects into your module or driver, otherwise they would be
> > already cancelled and freed. 
> 
> I'm getting the feeling you can probably naturally achieve the
> required destructors, but I think Danillo is concerned that since it
> isn't *mandatory* it isn't safe/sound.

Of course you can "naturally" achieve the required destructors, I even explained
that in [1]. :-)

And yes, for *device resources* it is unsound if we do not ensure that the
device resource is actually dropped at device unbind.

Maybe some example code does help. Look at this example where we assume that
pci::Device::iomap_region() does return a pci::Bar instead of a
Devres<pci::Bar>, which it actually does. (The example won't compile, since,
for readability, it's heavily simplified.)

    fn probe(pdev: &mut pci::Device, _info: &Self::IdInfo) -> Result<Pin<KBox<Self>>> {
        let bar: pci::Bar = pdev.iomap_region()?;

        let drvdata = Arc::new(bar, GFP_KERNEL)?;

        let drm = drm::device::Device::new(pdev.as_ref(), drvdata)?;
        let reg = drm::drv::Registration::new(drm)?;

        // Everything in `Self` is dropped on remove(), hence the DRM driver is
        // unregistered on remove().
        Ok(KBox::new(Self(reg), GFP_KERNEL)?)
    }

This is already broken, because now the lifetime of the pci::Bar is bound to the
DRM device and the DRM device is allowed to outlive remove().

Subsequently, pci_iounmap() and pci_release_region() are not called in remove(),
but whenever the DRM device is dropped.

The fact that this is possible with safe code, makes this API unsound.

Now let's assume iomap_region() would return a Devres<pci::Device>. That fixes
the problem, because even if the DRM device keeps the Devres<pci::Device> object
alive, it is still dropped when the driver is unbound, and subsequently
pci_iounmap() and pci_release_region() are called when they're supposed to be
called.

Note that this would not be a problem if pci::Device would not be a device
resource. Other stuff may be perfectly fine to bind to the lifetime of the DRM
device.

[1] https://lore.kernel.org/rust-for-linux/Z8CX__mIlFUFEkIh@cassiopeiae/

