Return-Path: <linux-kernel+bounces-530272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F47A4314C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 00:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BADF73BBEF7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 23:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4986D20D517;
	Mon, 24 Feb 2025 23:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lS0PoM1g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC1C20C000;
	Mon, 24 Feb 2025 23:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740440697; cv=none; b=kCm6FxJi5/IlIjc7kWVdX2hm68LYWzzpQZ/fwLJ7trwdxU+TifgrW9RJSCcD3UImvaKMovaXGtBJ2pN5vdknEHNtf8td0+P/wUTY0IiZBW14837q5Izcra0bztI4802L/qx0zvJPXVEKJ9haFwHbCrOFbEH8fDmWdlwCRDkHnnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740440697; c=relaxed/simple;
	bh=Kr1rcS4ZMViPxe+TilfErx2vNbgRGnGen+c0co0S3HY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r62StPf/bIG24VI0XfSFFNkav07qr5aSTSvfeUB5NtKLyEfzLdXZkHA8EFz0+/z999lDXOr8FtyQzMKjYsJKlzoEXGxwHIHI2VfsHfvDTv8LvE9hzLK/2SqCCH5oD2wf/sDfk7/FvlT3LBvksGqjEAnLpBJRCxvX5lfyJ2yOJWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lS0PoM1g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A2BC4CED6;
	Mon, 24 Feb 2025 23:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740440697;
	bh=Kr1rcS4ZMViPxe+TilfErx2vNbgRGnGen+c0co0S3HY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lS0PoM1gPsYGz6CL0m4sV/UNKhyh3NDOUWFZhOk7k7RwVpFFDHNFkY2wK1ZsdBZV3
	 AeGefMf/BsacH6jQUEnHnR9do9P3j0e/Oinz9iaDMGyE3V92sg8owwWr86Lvi5wnA5
	 0YxPtdGUCUd25EJOEeAaBjvmMV8tzTJymm6m9gqwQxZ4f0POdPahMHcNoOSbYnnvgs
	 yPZSuiKL1vUjYo4trTbcO4w5TUnCP9sF+kattMFoYYXAkaDhKtx1+ckS4/+IAju1dr
	 rwRO6A8Y6kG5IsxN3ZTVD2wAJgrFFluekHJMa+sauLd/0X08PCafLFWTulb01DlcI5
	 mlKMhPlZ/rByg==
Date: Tue, 25 Feb 2025 00:44:51 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
	Dave Airlie <airlied@gmail.com>, Gary Guo <gary@garyguo.net>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	John Hubbard <jhubbard@nvidia.com>, Ben Skeggs <bskeggs@nvidia.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	paulmck@kernel.org
Subject: Re: [RFC PATCH 0/3] gpu: nova-core: add basic timer subdevice
 implementation
Message-ID: <Z70EcwNIX0KtWy36@cassiopeiae>
References: <20250217-nova_timer-v1-0-78c5ace2d987@nvidia.com>
 <Z7OrKX3zzjrzZdyz@pollux>
 <CAPM=9tyu84z4Xk5X0fykO3Dazby2UqRgwtN4woNKe4Z2yMyDZg@mail.gmail.com>
 <D80AK2CLL4AZ.1G6R7OBHOF08O@nvidia.com>
 <Z7xg8uArPlr2gQBU@pollux>
 <Z7xh5bEyh_MII4WV@pollux>
 <20250224184502.GA1599486@joelnvbox>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224184502.GA1599486@joelnvbox>

On Mon, Feb 24, 2025 at 01:45:02PM -0500, Joel Fernandes wrote:
> Hi Danilo,
> 
> On Mon, Feb 24, 2025 at 01:11:17PM +0100, Danilo Krummrich wrote:
> > On Mon, Feb 24, 2025 at 01:07:19PM +0100, Danilo Krummrich wrote:
> > > CC: Gary
> > > 
> > > On Mon, Feb 24, 2025 at 10:40:00AM +0900, Alexandre Courbot wrote:
> > > > This inability to sleep while we are accessing registers seems very
> > > > constraining to me, if not dangerous. It is pretty common to have
> > > > functions intermingle hardware accesses with other operations that might
> > > > sleep, and this constraint means that in such cases the caller would
> > > > need to perform guard lifetime management manually:
> > > > 
> > > >   let bar_guard = bar.try_access()?;
> > > >   /* do something non-sleeping with bar_guard */
> > > >   drop(bar_guard);
> > > > 
> > > >   /* do something that might sleep */
> > > > 
> > > >   let bar_guard = bar.try_access()?;
> > > >   /* do something non-sleeping with bar_guard */
> > > >   drop(bar_guard);
> > > > 
> > > >   ...
> > > > 
> > > > Failure to drop the guard potentially introduces a race condition, which
> > > > will receive no compile-time warning and potentialy not even a runtime
> > > > one unless lockdep is enabled. This problem does not exist with the
> > > > equivalent C code AFAICT
> > 
> > Without klint [1] it is exactly the same as in C, where I have to remember to
> > not call into something that might sleep from atomic context.
> >
> 
> Sure, but in C, a sequence of MMIO accesses don't need to be constrained to
> not sleeping?

It's not that MMIO needs to be constrained to not sleeping in Rust either. It's
just that the synchronization mechanism (RCU) used for the Revocable type
implies that.

In C we have something that is pretty similar with drm_dev_enter() /
drm_dev_exit() even though it is using SRCU instead and is specialized to DRM.

In DRM this is used to prevent accesses to device resources after the device has
been unplugged.

> 
> I am fairly new to rust, could you help elaborate more about why these MMIO
> accesses need to have RevocableGuard in Rust? What problem are we trying to
> solve that C has but Rust doesn't with the aid of a RCU read-side section? I
> vaguely understand we are trying to "wait for an MMIO access" using
> synchronize here, but it is just a guest.

Similar to the above, in Rust it's a safety constraint to prevent MMIO accesses
to unplugged devices.

The exact type in Rust in this case is Devres<pci::Bar>. Within Devres, the
pci::Bar is placed in a Revocable. The Revocable is revoked when the device
is detached from the driver (for instance because it has been unplugged).

By revoking the Revocable, the pci::Bar is dropped, which implies that it's also
unmapped; a subsequent call to try_access() would fail.

But yes, if the device is unplugged while holding the RCU guard, one is on their
own; that's also why keeping the critical sections short is desirable.

