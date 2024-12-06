Return-Path: <linux-kernel+bounces-434556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFEE9E6836
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90D7128420C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3771DDA20;
	Fri,  6 Dec 2024 07:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIQc8BGt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED8E197548;
	Fri,  6 Dec 2024 07:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733471405; cv=none; b=jrho4k/UAKBOjRBM3DUpHOklOOrSIMpbvlxSziPVZpvtoFG4XcRG9GVHCQNEMQFZSOIEPQgYsY2VwzA1g1LL+Hvedsy+KqEmvdaKwWmoAgxtGxwNYu6v/DjAM424QIjGK3ubth2OROZ9kQMSahy7W0U6jqHTzwh31xGDmqGMl/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733471405; c=relaxed/simple;
	bh=5qohqrW2C5S36QEHyyoNx6PWg6lLbKY+njcv5MoaFPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0beJHksH3k+j/WrttgPwq5nMeS80w5hffwZuTUOllnRBTK/On7Vbj9F/KXba7l/rtIp4ACebSXrCXveghjGPsZgvYdvr5VljbAMjfWtyr/HaDGR/0pUMvFbNv7mZVa0GEig0AwNoIpeyMhaEB8XyBnGjOdHcAJmFIDLNdWkgYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIQc8BGt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49127C4CED1;
	Fri,  6 Dec 2024 07:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733471404;
	bh=5qohqrW2C5S36QEHyyoNx6PWg6lLbKY+njcv5MoaFPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FIQc8BGtQAhiH4JJOAmbVnJS7eOBDYeUIs8VcbSY1Bh7RC0FewpPoRboXrDUlWtVd
	 IXL1YVvUUjTTrVaIFE1KqUyYQRgX8SU8ZRIBGTj0N0ENBaT+e25Z8APG8gpGPptzIF
	 aF/pz2xoW3PC+6QmZE5mJ+70KWi7KjoM06NhBk1DsQ+TWf+NXZS9Y7dyYnVgWaJhsc
	 pYPlVM0TjKc8//qkpn7d9UN5n+zOr3kHXi45hDfr6EJ27LWnAyj1afZSES9htadg1h
	 jrsKaXaQG1B6vdfIIgkdVCJVsTx+vLHSPkDcF2NCWA8zwKq5im38s6HNVP1EknFN2O
	 Qb7OJ6NwmE1lg==
Date: Fri, 6 Dec 2024 07:49:59 +0000
From: Lee Jones <lee@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 1/5] rust: miscdevice: Provide accessor to pull out
 miscdevice::this_device
Message-ID: <20241206074959.GL8882@google.com>
References: <20241205162531.1883859-1-lee@kernel.org>
 <20241205162531.1883859-2-lee@kernel.org>
 <2024120648-finch-shrubbery-c6f5@gregkh>
 <20241206071646.GE8882@google.com>
 <20241206073309.GG8882@google.com>
 <2024120616-endanger-strangely-62b4@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024120616-endanger-strangely-62b4@gregkh>

On Fri, 06 Dec 2024, Greg KH wrote:

> On Fri, Dec 06, 2024 at 07:33:09AM +0000, Lee Jones wrote:
> > On Fri, 06 Dec 2024, Lee Jones wrote:
> > 
> > > On Fri, 06 Dec 2024, Greg KH wrote:
> > > 
> > > > On Thu, Dec 05, 2024 at 04:25:18PM +0000, Lee Jones wrote:
> > > > > There are situations where a pointer to a `struct device` will become
> > > > > necessary (e.g. for calling into dev_*() functions).  This accessor
> > > > > allows callers to pull this out from the `struct miscdevice`.
> > > > > 
> > > > > Signed-off-by: Lee Jones <lee@kernel.org>
> > > > > ---
> > > > >  rust/kernel/miscdevice.rs | 9 +++++++++
> > > > >  1 file changed, 9 insertions(+)
> > > > > 
> > > > > diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
> > > > > index 7e2a79b3ae26..55340f316006 100644
> > > > > --- a/rust/kernel/miscdevice.rs
> > > > > +++ b/rust/kernel/miscdevice.rs
> > > > > @@ -10,11 +10,13 @@
> > > > >  
> > > > >  use crate::{
> > > > >      bindings,
> > > > > +    device::Device,
> > > > >      error::{to_result, Error, Result, VTABLE_DEFAULT_ERROR},
> > > > >      prelude::*,
> > > > >      str::CStr,
> > > > >      types::{ForeignOwnable, Opaque},
> > > > >  };
> > > > > +
> > > > >  use core::{
> > > > >      ffi::{c_int, c_long, c_uint, c_ulong},
> > > > >      marker::PhantomData,
> > > > > @@ -84,6 +86,13 @@ pub fn register(opts: MiscDeviceOptions) -> impl PinInit<Self, Error> {
> > > > >      pub fn as_raw(&self) -> *mut bindings::miscdevice {
> > > > >          self.inner.get()
> > > > >      }
> > > > > +
> > > > > +    /// Returns a pointer to the current Device
> > > > > +    pub fn device(&self) -> &Device {
> > > > > +        // SAFETY: This is only accessible after a successful register() which always
> > > > > +        // initialises this_device with a valid device.
> > > > > +        unsafe { Device::as_ref((*self.as_raw()).this_device) }
> > > > 
> > > > A "raw" pointer that you can do something with without incrementing the
> > > > reference count of it?  Oh wait, no, it's the rust device structure.
> > > > If so, why isn't this calling the get_device() interface instead?  That
> > > > way it's properly incremented and decremented when it "leaves the scope"
> > > > right?
> > > > 
> > > > Or am I missing something here as to why that wouldn't work and this is
> > > > the only way to get access to the 'struct device' of this miscdevice?
> > > 
> > > Fair point.  I'll speak to Alice.
> > 
> > Alice isn't available yet, so I may be talking out of turn at this
> > point, but I just found this is the Device documentation:
> > 
> >   /// A `Device` instance represents a valid `struct device` created by the C portion of the kernel.
> >   ///
> >   /// Instances of this type are always reference-counted, that is, a call to `get_device` ensures
> >   /// that the allocation remains valid at least until the matching call to `put_device`.
> > 
> > And:
> > 
> >   // SAFETY: Instances of `Device` are always reference-counted.
> > 
> > Ready for some analysis from this beginner?
> > 
> > Since this impl for Device is AlwaysRefCounted, when any references are
> > taken i.e. in the Device::as_ref line above, inc_ref() is implicitly
> > called to increase the refcount.  The same will be true of dec_ref()
> > once it goes out of scope.
> > 
> >   // SAFETY: Instances of `Device` are always reference-counted.
> >   unsafe impl crate::types::AlwaysRefCounted for Device {
> >       fn inc_ref(&self) {
> >           // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
> >           unsafe { bindings::get_device(self.as_raw()) };
> >       }
> > 
> >       unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
> >           // SAFETY: The safety requirements guarantee that the refcount is non-zero.
> >           unsafe { bindings::put_device(obj.cast().as_ptr()) }
> >   }
> 
> Ick, really?  So as_ref() implicitly calles inc_ref() and dec_ref()?
> Ah, ok, in digging into AlwaysRefCounted I now see that seems to be
> true.
> 
> So great, this is a reference counted object, so what's preventing it
> from now being used in dev_info()?

We're having this conversation in stereo at this point.

TL;DR, we can't call MiscDeviceRegistration::device() after .init YET.

The longer version of this can be seen in the cover-letter thread.

-- 
Lee Jones [李琼斯]

