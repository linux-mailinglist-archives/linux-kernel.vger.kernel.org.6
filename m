Return-Path: <linux-kernel+bounces-532682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D696A450E7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 00:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65D657AA0C4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F8A237176;
	Tue, 25 Feb 2025 23:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdofdHDY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50366215164;
	Tue, 25 Feb 2025 23:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740526019; cv=none; b=FNe4uG4bUwIAIG6c4vCrO2fqBH4qbb6Uh57v1Z5/69aVKnFREK8h4nzslg2kfxgmNseF5wSbQhSJOvTNz1xg0JUsOdmTetRB9cmc8oXaZMaHKNjh9CQnzxwDWs6ktQGgwxHW4rrj5hC2OwMagnmNmzrplBqM+PJ6ciOIVrF2jYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740526019; c=relaxed/simple;
	bh=ibAdGeayJwCauyp3OQL2DUFoUDuFf6aXjCY4OlFfh/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ix2bUK8BqYA8ZD1axZ+ptYjPX7s2u3+OzcBvtXaj1o4L3Cv749ZUz4mzNYujOmZ5P7LS04UCTU2HfvmeaiG/2uR9gr+aXCxEvEwTe3xwwFTxwPNuToMoXgevfA1s06IO5q+5333tEv12Ejv1Y8/EO4gQXOt7sXNnf15Ksm7KesI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdofdHDY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A7FC4CEDD;
	Tue, 25 Feb 2025 23:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740526018;
	bh=ibAdGeayJwCauyp3OQL2DUFoUDuFf6aXjCY4OlFfh/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fdofdHDYJmVgwd5SbpoRfwuuUiVWfm0Mgv0L+/ovSo49vnfbP77ctkJCr3rjOC8wq
	 f4O9pk67EBlKjzGrXfKrxCnoBl6vwIfb4urPebINmvWq9Jr6J23B6rURn62m/KklNn
	 3jV9WoJrUSsmYRz2SfRPpQoKwvST+JpVIJRumiylC0+s1SM7awNyhYsHm9t3bjqRKP
	 nyk88IOM+/N70YLZolcMCrlsY1Kobw8VUv6/qscKjBQx4+MkszIs/5MWi+2nY5VN64
	 BAIsj5uw4cVz5Yx1FwPIa+dL8/OxUrd+uKG/Ayiz5LxqQbjWQD3vDoqWTw0hXaNYtr
	 rby230WMJ2n+g==
Date: Wed, 26 Feb 2025 00:26:53 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Dave Airlie <airlied@gmail.com>, Gary Guo <gary@garyguo.net>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	John Hubbard <jhubbard@nvidia.com>, Ben Skeggs <bskeggs@nvidia.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	paulmck@kernel.org
Subject: Re: [RFC PATCH 0/3] gpu: nova-core: add basic timer subdevice
 implementation
Message-ID: <Z75RvU-Yb70iFyor@cassiopeiae>
References: <CAPM=9tyu84z4Xk5X0fykO3Dazby2UqRgwtN4woNKe4Z2yMyDZg@mail.gmail.com>
 <D80AK2CLL4AZ.1G6R7OBHOF08O@nvidia.com>
 <Z7xg8uArPlr2gQBU@pollux>
 <Z7xh5bEyh_MII4WV@pollux>
 <20250224184502.GA1599486@joelnvbox>
 <Z70EcwNIX0KtWy36@cassiopeiae>
 <2f062199-8d69-48a2-baa6-abb755479a16@nvidia.com>
 <Z73rP4secPlUMIoS@cassiopeiae>
 <20250225210228.GA1801922@joelnvbox>
 <20250225225756.GA4959@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225225756.GA4959@nvidia.com>

On Tue, Feb 25, 2025 at 06:57:56PM -0400, Jason Gunthorpe wrote:
> I think this resource-revoke idea is deviating from the normal
> expected driver model by allowing driver code to continue to run in
> other threads once remove completes. That is definitely abnormal at
> least.

No, it simply guarantees that once remove() completed the pointer to the
resource can't be accessed anymore and the resource can't be kept alive
(which includes the actual memory mapping as well as the allocated resource
region).

It also solves the unplug problem, where ioctls can't access the resource
anymore after remove(). This is indeed a problem that does not affect all
subsystems.

> 
> It is not necessarily *wrong*, but it sure is weird and as I explained
> above it has bad system level properties.
> 
> Further, it seems to me there is a very unique DRM specific issue at
> work "time unbounded driver callbacks". A weird solution to this
> should not be baked into the common core kernel rust bindings and
> break the working model of all other subsystems that don't have that
> problem.
> 
> > > Similarly you can have custom functions for short sequences of I/O ops, or use
> > > closures. I don't understand the concern.
> > 
> > Yeah, this is certainly possible. I think one concern is similar to what you
> > raised on the other thread you shared [1]:
> > "Maybe we even want to replace it with SRCU entirely to ensure that drivers
> > can't stall the RCU grace period for too long by accident."
> 
> I'd be worried about introducing a whole bunch more untestable failure
> paths in drivers. Especially in areas like work queue submit that are
> designed not to fail [2]. Non-failing work queues is a critical property
> that I've relied on countless times. I'm not sure you even *can* recover
> from this correctly in all cases.
> 
> Then in the other email did you say that even some memory allocations
> go into this scheme? Yikes!

"For instance, let's take devm_kzalloc(). Once the device is detached
from the driver the memory allocated with this function is freed automatically.

The additional step in Rust is, that we'd not only free the memory, but also
revoke the access to the pointer that has been returned by devm_kzalloc() for
the driver, such that it can't be used by accident anymore."

This was just an analogy to explain what we're doing here. Obviously, memory
allocations can be managed by Rust's object lifetime management.

The reason we have Devres for device resources is that the lifetime of a
pci::Bar is *not* bound to the object lifetime directly, but to the lifetime of
the binding between a device and a driver. That's why it needs to be revoked
(which forcefully drops the object) when the device is unbound *not* when the
pci::Bar object is dropped regularly.

That's all the magic we're doing here. And again, this is not a change to the
device / driver model. It is making use of the device / driver model to ensure
safety.

> 
> Further, hiding a synchronize_rcu in a devm destructor [3], once per
> revocable object is awful. If you imagine having a rcu around each of
> your revocable objects, how many synchronize_rcu()s is devm going to
> call post-remove()?

As many as you have MMIO mappings in your driver. But we can probably optimize
this to just a single synchronize_rcu().

