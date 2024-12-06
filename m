Return-Path: <linux-kernel+bounces-434611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A34499E68EC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5496F286125
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B4C1DE2B3;
	Fri,  6 Dec 2024 08:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3kljBk2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E465C3D6B;
	Fri,  6 Dec 2024 08:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733473883; cv=none; b=LX+TgstHfngiXWOis82sPL4sQxBQhA5TxrgHvDVhm+RjYVDyfPpWfvB+ThxDnt0McL32xAuWpt+KiY2MrnSJ6+BhtSR0rjpzeLqvp7mZbYyeR7FBQEyMQ5ehFtJBD1MfNmiGf5Y0pzxXcpL+GRdv/OjK+k+lFu7Rwqdtf2WIWqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733473883; c=relaxed/simple;
	bh=wwVvhOgw3TqhMZRruQ7sCYqRQDH1bBCjL08Ym4VjgvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJpUQq9QEje/2vVx0XZsvDT/4TCAso8Guov+2BGISAAuwDeRGwVbwWv5xMw+yAJLDaUzkoo2Mhn3CQtv7TawpTzvBKuvwtGqSDTZFwIeBt6A+BnwFZSZLL09SNcZwFdfOSuySrZ5pqbFr+wFHPuYX2fRMIg0ig8Eq+qoxr/99Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3kljBk2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5341C4CEDD;
	Fri,  6 Dec 2024 08:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733473882;
	bh=wwVvhOgw3TqhMZRruQ7sCYqRQDH1bBCjL08Ym4VjgvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L3kljBk22ib53sm2gMc8/CWKnxk3bkb6G8LQP9kGEgokpKPz0YPjeebupaNgcB7/g
	 mTsFT5/EURcVIoGg0fhx6tq5kLjCN+2HZYbd96JDu3QYljh1090fXk29BxGrt4fl7c
	 ZKZGT9E+YJ7nZLruVxOjjjJe/i5jENoPWHFp8QMqikVhwvA2CfpcWp2BLufI8FQbd+
	 j4AVz6D67PZ4wB67RBHq4SlkHXFdJ3CnjMRTcBovnuORvfdEvIx7UXQ+WDqJTnc0WY
	 tLinVmkwsgna7/5ozkUv5TDqG+IFjk0NAuYoaJlr9MBM+dGFqpvfu3mMGbiJrGYr49
	 nj7Q60MWq0FPw==
Date: Fri, 6 Dec 2024 08:31:17 +0000
From: Lee Jones <lee@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
	arnd@arndb.de, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 1/5] rust: miscdevice: Provide accessor to pull out
 miscdevice::this_device
Message-ID: <20241206083117.GO8882@google.com>
References: <20241205162531.1883859-1-lee@kernel.org>
 <20241205162531.1883859-2-lee@kernel.org>
 <2024120648-finch-shrubbery-c6f5@gregkh>
 <20241206071646.GE8882@google.com>
 <20241206073309.GG8882@google.com>
 <Z1KvNQUUStyLjpwz@boqun-archlinux>
 <20241206080751.GN8882@google.com>
 <Z1Kynwt4LpWdOiBN@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1Kynwt4LpWdOiBN@boqun-archlinux>

On Fri, 06 Dec 2024, Boqun Feng wrote:

> On Fri, Dec 06, 2024 at 08:07:51AM +0000, Lee Jones wrote:
> > On Fri, 06 Dec 2024, Boqun Feng wrote:
> > 
> > > On Fri, Dec 06, 2024 at 07:33:09AM +0000, Lee Jones wrote:
> > > > On Fri, 06 Dec 2024, Lee Jones wrote:
> > > > 
> > > > > On Fri, 06 Dec 2024, Greg KH wrote:
> > > > > 
> > > > > > On Thu, Dec 05, 2024 at 04:25:18PM +0000, Lee Jones wrote:
> > > > > > > There are situations where a pointer to a `struct device` will become
> > > > > > > necessary (e.g. for calling into dev_*() functions).  This accessor
> > > > > > > allows callers to pull this out from the `struct miscdevice`.
> > > > > > > 
> > > > > > > Signed-off-by: Lee Jones <lee@kernel.org>
> > > > > > > ---
> > > > > > >  rust/kernel/miscdevice.rs | 9 +++++++++
> > > > > > >  1 file changed, 9 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
> > > > > > > index 7e2a79b3ae26..55340f316006 100644
> > > > > > > --- a/rust/kernel/miscdevice.rs
> > > > > > > +++ b/rust/kernel/miscdevice.rs
> > > > > > > @@ -10,11 +10,13 @@
> > > > > > >  
> > > > > > >  use crate::{
> > > > > > >      bindings,
> > > > > > > +    device::Device,
> > > > > > >      error::{to_result, Error, Result, VTABLE_DEFAULT_ERROR},
> > > > > > >      prelude::*,
> > > > > > >      str::CStr,
> > > > > > >      types::{ForeignOwnable, Opaque},
> > > > > > >  };
> > > > > > > +
> > > > > > >  use core::{
> > > > > > >      ffi::{c_int, c_long, c_uint, c_ulong},
> > > > > > >      marker::PhantomData,
> > > > > > > @@ -84,6 +86,13 @@ pub fn register(opts: MiscDeviceOptions) -> impl PinInit<Self, Error> {
> > > > > > >      pub fn as_raw(&self) -> *mut bindings::miscdevice {
> > > > > > >          self.inner.get()
> > > > > > >      }
> > > > > > > +
> > > > > > > +    /// Returns a pointer to the current Device
> > > > > > > +    pub fn device(&self) -> &Device {
> > > > > > > +        // SAFETY: This is only accessible after a successful register() which always
> > > > > > > +        // initialises this_device with a valid device.
> > > > > > > +        unsafe { Device::as_ref((*self.as_raw()).this_device) }
> > > > > > 
> > > > > > A "raw" pointer that you can do something with without incrementing the
> > > > > > reference count of it?  Oh wait, no, it's the rust device structure.
> > > > > > If so, why isn't this calling the get_device() interface instead?  That
> > > > > > way it's properly incremented and decremented when it "leaves the scope"
> > > > > > right?
> > > > > > 
> > > > > > Or am I missing something here as to why that wouldn't work and this is
> > > > > > the only way to get access to the 'struct device' of this miscdevice?
> > > > > 
> > > > > Fair point.  I'll speak to Alice.
> > > > 
> > > > Alice isn't available yet, so I may be talking out of turn at this
> > > > point, but I just found this is the Device documentation:
> > > > 
> > > >   /// A `Device` instance represents a valid `struct device` created by the C portion of the kernel.
> > > >   ///
> > > >   /// Instances of this type are always reference-counted, that is, a call to `get_device` ensures
> > > >   /// that the allocation remains valid at least until the matching call to `put_device`.
> > > > 
> > > > And:
> > > > 
> > > >   // SAFETY: Instances of `Device` are always reference-counted.
> > > > 
> > > > Ready for some analysis from this beginner?
> > > > 
> > > > Since this impl for Device is AlwaysRefCounted, when any references are
> > > > taken i.e. in the Device::as_ref line above, inc_ref() is implicitly
> > > > called to increase the refcount.  The same will be true of dec_ref()
> > > 
> > > No, inc_ref() is not called implicitly in Device::as_ref().
> > > 
> > > The thing that might "keep" the original `miscdevice::Device` alive is
> > > the lifetime, since the returned `device::Device` reference has the
> > > same life at the input parameter `miscdevice::Device` reference (i.e.
> > > `&self`), so the returned reference cannot outlive `&self`. That means
> > > if compilers find `&self` go out of scope while the returned reference
> > > be still alive, it will report an error.
> > 
> > Okay, so is there something I need to do to ensure we increase the
> > refcount?  Does inc_ref() need calling manually?
> > 
> 
> When you convert a `&Device` into a `ARef<Device>`, Device::inc_ref()
> will be called. You can do that with:
> 
> 	ARef::from(Device::as_ref((*self.as_raw()).this_device))
> 
> You will also need to change the return type. And when an `ARef<Device>`
> goes out of scope, dec_ref() will be called. 

I have been reliably assured by Alice that we don't need to refcount here.

> I had an old patch for a bit document on this part:
> 
> 	https://lore.kernel.org/rust-for-linux/20240710032447.2161189-1-boqun.feng@gmail.com/
> 
> maybe I should send a re-spin.

Very nice!  Yeah, it would be a shame for all that work to go to waste.

-- 
Lee Jones [李琼斯]

