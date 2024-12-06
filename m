Return-Path: <linux-kernel+bounces-434549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F5D9E6823
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 805FF168D8A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220B91DB95E;
	Fri,  6 Dec 2024 07:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eImPJvyK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E40A13DDDF;
	Fri,  6 Dec 2024 07:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733471192; cv=none; b=FZyv0XljLHCkLgg+zToi85NEE70W8DpRyCi5AOhNVT047PCyIwjGBwxWqWXj99DAhu6mTpeln43ofLgcsYPeDtcp8wYfjTwhbn05tb/D/sFoPGw2oIJoadziZyi/J85nVDjdunHgxd//elkFktb8ffknCfPmpRguQu01QnMz/34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733471192; c=relaxed/simple;
	bh=SG7Ibmb4t1yzkqqkDLJrBnmSr5QF5Rg634/yycaaTpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8w8vQSH91PaljxZ2JJuKuIdel+zbsqplw7OrL3zEMUkRgJmW/WK6Ez5FcirO/Ew7O/tm144f2OZc10nhNRpcBOeJ2UmblYjeq0xB7r2RfV8nINgUxm55kIONhZTrl8FvF5FZi8337ZdWPjvHJDQ4evBFvJ97uF4kZKrWod5FZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eImPJvyK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E696C4CED1;
	Fri,  6 Dec 2024 07:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733471192;
	bh=SG7Ibmb4t1yzkqqkDLJrBnmSr5QF5Rg634/yycaaTpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eImPJvyKQOVr5v1k1uXxiWiynk0EhxX/2hzakxYhvKfc/FUq7vsly/4lIzHEy2eVA
	 JDKxyWaodi5ewslxZrS4IUcAyXei0J7mx6SU0qfGdx6bJfoCy59EQniA8/Iq0kyKc/
	 mnk1m67/o/jDoIeDhJvQmf/UMxTtcfj1DQt1eRl8=
Date: Fri, 6 Dec 2024 08:46:29 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 1/5] rust: miscdevice: Provide accessor to pull out
 miscdevice::this_device
Message-ID: <2024120616-endanger-strangely-62b4@gregkh>
References: <20241205162531.1883859-1-lee@kernel.org>
 <20241205162531.1883859-2-lee@kernel.org>
 <2024120648-finch-shrubbery-c6f5@gregkh>
 <20241206071646.GE8882@google.com>
 <20241206073309.GG8882@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206073309.GG8882@google.com>

On Fri, Dec 06, 2024 at 07:33:09AM +0000, Lee Jones wrote:
> On Fri, 06 Dec 2024, Lee Jones wrote:
> 
> > On Fri, 06 Dec 2024, Greg KH wrote:
> > 
> > > On Thu, Dec 05, 2024 at 04:25:18PM +0000, Lee Jones wrote:
> > > > There are situations where a pointer to a `struct device` will become
> > > > necessary (e.g. for calling into dev_*() functions).  This accessor
> > > > allows callers to pull this out from the `struct miscdevice`.
> > > > 
> > > > Signed-off-by: Lee Jones <lee@kernel.org>
> > > > ---
> > > >  rust/kernel/miscdevice.rs | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > > 
> > > > diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
> > > > index 7e2a79b3ae26..55340f316006 100644
> > > > --- a/rust/kernel/miscdevice.rs
> > > > +++ b/rust/kernel/miscdevice.rs
> > > > @@ -10,11 +10,13 @@
> > > >  
> > > >  use crate::{
> > > >      bindings,
> > > > +    device::Device,
> > > >      error::{to_result, Error, Result, VTABLE_DEFAULT_ERROR},
> > > >      prelude::*,
> > > >      str::CStr,
> > > >      types::{ForeignOwnable, Opaque},
> > > >  };
> > > > +
> > > >  use core::{
> > > >      ffi::{c_int, c_long, c_uint, c_ulong},
> > > >      marker::PhantomData,
> > > > @@ -84,6 +86,13 @@ pub fn register(opts: MiscDeviceOptions) -> impl PinInit<Self, Error> {
> > > >      pub fn as_raw(&self) -> *mut bindings::miscdevice {
> > > >          self.inner.get()
> > > >      }
> > > > +
> > > > +    /// Returns a pointer to the current Device
> > > > +    pub fn device(&self) -> &Device {
> > > > +        // SAFETY: This is only accessible after a successful register() which always
> > > > +        // initialises this_device with a valid device.
> > > > +        unsafe { Device::as_ref((*self.as_raw()).this_device) }
> > > 
> > > A "raw" pointer that you can do something with without incrementing the
> > > reference count of it?  Oh wait, no, it's the rust device structure.
> > > If so, why isn't this calling the get_device() interface instead?  That
> > > way it's properly incremented and decremented when it "leaves the scope"
> > > right?
> > > 
> > > Or am I missing something here as to why that wouldn't work and this is
> > > the only way to get access to the 'struct device' of this miscdevice?
> > 
> > Fair point.  I'll speak to Alice.
> 
> Alice isn't available yet, so I may be talking out of turn at this
> point, but I just found this is the Device documentation:
> 
>   /// A `Device` instance represents a valid `struct device` created by the C portion of the kernel.
>   ///
>   /// Instances of this type are always reference-counted, that is, a call to `get_device` ensures
>   /// that the allocation remains valid at least until the matching call to `put_device`.
> 
> And:
> 
>   // SAFETY: Instances of `Device` are always reference-counted.
> 
> Ready for some analysis from this beginner?
> 
> Since this impl for Device is AlwaysRefCounted, when any references are
> taken i.e. in the Device::as_ref line above, inc_ref() is implicitly
> called to increase the refcount.  The same will be true of dec_ref()
> once it goes out of scope.
> 
>   // SAFETY: Instances of `Device` are always reference-counted.
>   unsafe impl crate::types::AlwaysRefCounted for Device {
>       fn inc_ref(&self) {
>           // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
>           unsafe { bindings::get_device(self.as_raw()) };
>       }
> 
>       unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
>           // SAFETY: The safety requirements guarantee that the refcount is non-zero.
>           unsafe { bindings::put_device(obj.cast().as_ptr()) }
>   }

Ick, really?  So as_ref() implicitly calles inc_ref() and dec_ref()?
Ah, ok, in digging into AlwaysRefCounted I now see that seems to be
true.

So great, this is a reference counted object, so what's preventing it
from now being used in dev_info()?

thanks,

greg k-h

