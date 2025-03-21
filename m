Return-Path: <linux-kernel+bounces-571208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FFDA6BA5E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96B894A089B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5761227E82;
	Fri, 21 Mar 2025 12:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBU3MMpp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DAF22579E;
	Fri, 21 Mar 2025 12:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742559157; cv=none; b=GP9gKM/vBuDQR5RWyGhV6qc96j/mT8iDxPHzHB4AGpK7XFAxWKCibwFPw3ST4D9zCJ1ov0XeK6YR8KzYFwylJENI7TYNp9/nUtkTehU5BOENdi9cd/Gx7c2Iy1/DUfqNFNWUy2p8UBDNUd/QS2zI9Q/ePGJUVgZHu4rkW8WSQ4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742559157; c=relaxed/simple;
	bh=xK8yauRt6DqRrXTN9T3yXF88FokRjGpUJksc7timWDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HqrRSnwKV4kODTmttcAqSoYAJI5xZjCEabq3+K0zZQU7vkcITZhc14auQ4eWbrFWDzhWFMRi5Pr7RN9ohiCtPzpVd1iMnqFbGMbOAe8h8OtG4YqVGmXJrDeg4o/ewRsuQ6qBQO47JgiareZLoVcZsx20beWLgoT/hs/hr+wlvoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBU3MMpp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AAC3C4CEE3;
	Fri, 21 Mar 2025 12:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742559156;
	bh=xK8yauRt6DqRrXTN9T3yXF88FokRjGpUJksc7timWDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HBU3MMppGANhUorrUWxTV4oLhl5ufEHpbbenijLkSXLuEpiA1GruMTGuGCrQak0/8
	 3DhSToi1AL8CHk8gctVu+ffNJKRVF2aFoLRDjYHnkyvPnjCI7yhD8t2jtVcCjMDEd/
	 Vu+We2Eqo87SVyBFGZbW1+jIzX3iqiMLX6Z7zzgZhYoSIs6GzyKkVLc9s0U/jL0r0n
	 3mDEibV355uIiio8eTY+tm69jZvcyOVyidxCZXsFxyGDMdSKAF3QCwjTOO64dKUaKt
	 +585UUrfrWunD6hSI6Jv3eakc56VNRwIAwPPjgGvsah5J+2+fdqyb1H9xVaJiJu7Xu
	 UpjjR5TbnVO1w==
Date: Fri, 21 Mar 2025 13:12:30 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>,
	Greg KH <gregkh@linuxfoundation.org>,
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
Message-ID: <Z91XrltJYtJdkLUS@pollux>
References: <Z8l8HgZOV7sDWqBh@phenom.ffwll.local>
 <20250306153236.GE354511@nvidia.com>
 <Z8rKVZolu8n6lB1P@phenom.ffwll.local>
 <20250307123255.GK354511@nvidia.com>
 <Z8rv-DQuGdxye28N@phenom.ffwll.local>
 <20250307145557.GO354511@nvidia.com>
 <Z9LsbhzjI-P3-edQ@phenom.ffwll.local>
 <20250319172132.GL9311@nvidia.com>
 <Z91A_Dz-nY2iFqYb@phenom.ffwll.local>
 <20250321120416.GX206770@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321120416.GX206770@nvidia.com>

On Fri, Mar 21, 2025 at 09:04:16AM -0300, Jason Gunthorpe wrote:
> On Fri, Mar 21, 2025 at 11:35:40AM +0100, Simona Vetter wrote:
> > On Wed, Mar 19, 2025 at 02:21:32PM -0300, Jason Gunthorpe wrote:
> > > On Thu, Mar 13, 2025 at 03:32:14PM +0100, Simona Vetter wrote:
> > > 
> > > > So I think you can still achieve that building on top of revocable and a
> > > > few more abstractions that are internally unsafe. Or are you thinking of
> > > > different runtime checks?
> > > 
> > > I'm thinking on the access side of the revocable you don't have a
> > > failure path. Instead you get the access or runtime violation if the
> > > driver is buggy. This eliminates all the objectionable failure paths
> > > and costs on the performance paths of the driver.
> > > 
> > > And perhaps also on the remove path you have runtime checking if
> > > "driver lifetime bound" objects have all been cleaned up.
> > > 
> > > The point is to try to behave more like the standard fence pattern and
> > > get some level of checking that can make r4l comfortable without
> > > inventing new kernel lifecycle models.
> > > 
> > > > Yeah maybe we're not that far really. But I'm still not clear how to do
> > > > an entirely revoke-less world.
> > > 
> > > Not entirely, you end up revoking big things. Like RDMA revokes the
> > > driver ops callbacks using SRCU. It doesn't revoke individual
> > > resources or DMA maps.
> > > 
> > > I have the same feeling about this micro-revoke direction, I don't
> > > know how to implement this. The DMA API is very challenging,
> > > especially the performance use of DMA API.
> > 
> > Ah I think we're in agreement, I think once we get to big subsystems we
> > really want subsystem-level revokes like you describe here. And rust
> > already has this concept of a "having one thing guarantess you access to
> > another". For example an overall lock to a big datastructure gives you
> > access to all the invidiual nodes, see LockedBy. So I think we're covered
> > here.
> 
> Make some sense if Rust can do that.
> 
> > For me the basic Revocable really is more for all the odd-ball
> > random pieces that aren't covered by subsystem constructs already. And
> > maybe drm needs to rethink a bunch of things in this area in general, not
> > just for rust. So maybe we should extend the rustdoc to explain that bare
> > Revocable isn't how entire subsystems rust abstractions should be built?
> 
> Then why provide it? Like why provide revoke for DMA API or MMIO as
> mandatory part of the core kernel rust bindings if it isn't supposed
> to be used and instead rely on this LockedBy sort of thing?

Not all device resources are managed in the context of the subsystem, so
subsystem-level revokes do not apply.

For the DMA coherent allocations, please see my comment in [1]. Revoking the
device resources associated with a DMA coherent allocation should hence never
cause any overhead for accessing DMA memory.

[1] https://github.com/Rust-for-Linux/linux/blob/rust-next/rust/kernel/dma.rs#L120

