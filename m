Return-Path: <linux-kernel+bounces-434571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B699E686F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39AA418859A6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9515D1DE2B3;
	Fri,  6 Dec 2024 08:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFhhaO1L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7C9328B6;
	Fri,  6 Dec 2024 08:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733472477; cv=none; b=LNuutq6rdwikW9Ulaoo2tQufXmR96M2T8VJX783O2guMTDS7OszGrnNAoHMIgZdjMhEsgumGAE0k8BpXvVn10qgwSEfPx6oO2FIAF9NmRpFKUCJoFAZfgYA+N+IBrWWsQb6nLeO7+oXMhAkLtH8DgLlx9Ei57RHWOOdbBfNaDvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733472477; c=relaxed/simple;
	bh=VVjeTLw06e49HILCXDutSGBKgHH95vHDfuw49h7qGUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cN6b1OFMAHeIDOrBEUArG6xHW16b7eVkaoRHlWWlM1E3iqSG+KATFlbCSqBRe3DwCA4U4IrWu0zEUNOszqfyWlr9X6FB9I1pQD0SFHPdYG8tRN6VYQ6FnR3p0Ee9sfXzzIkfOXyX7S4W9zrVRXEac/jwJX6wmKARomay57K07Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFhhaO1L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA9EC4CED1;
	Fri,  6 Dec 2024 08:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733472476;
	bh=VVjeTLw06e49HILCXDutSGBKgHH95vHDfuw49h7qGUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XFhhaO1L4R950UjqTiKjRb3wjy2M6ixlzw1dQlEsg9LJwQk6Xjiaj99rEJY9BLz/B
	 Lg3MKel4VEzIHT9gw8OQd2zbCq7aUxzqkpy10TykwUNDgak3FxLQYjH1myG77CYWDF
	 m7KmDmhGYrGK4KEjINHDFTFZTjA1cll2LGKjAWNdbL6UXaUgn0A4BCquUcb9fgeqKC
	 QQWY1BrNo9zAFXF2zv6jYArIqzGxMve/p8OxHXfdq9SyZmdgPngXz1AvIzxeJDdwlB
	 H/4+Mj9Oq23oAVPCdKEVTc8PxrSZU/KR+wrpQRIlgRLbBkx2Y5n3NKaMNQmcBsLsHr
	 wh8cA3xC3XVlQ==
Date: Fri, 6 Dec 2024 08:07:51 +0000
From: Lee Jones <lee@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
	arnd@arndb.de, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 1/5] rust: miscdevice: Provide accessor to pull out
 miscdevice::this_device
Message-ID: <20241206080751.GN8882@google.com>
References: <20241205162531.1883859-1-lee@kernel.org>
 <20241205162531.1883859-2-lee@kernel.org>
 <2024120648-finch-shrubbery-c6f5@gregkh>
 <20241206071646.GE8882@google.com>
 <20241206073309.GG8882@google.com>
 <Z1KvNQUUStyLjpwz@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1KvNQUUStyLjpwz@boqun-archlinux>

On Fri, 06 Dec 2024, Boqun Feng wrote:

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
> 
> No, inc_ref() is not called implicitly in Device::as_ref().
> 
> The thing that might "keep" the original `miscdevice::Device` alive is
> the lifetime, since the returned `device::Device` reference has the
> same life at the input parameter `miscdevice::Device` reference (i.e.
> `&self`), so the returned reference cannot outlive `&self`. That means
> if compilers find `&self` go out of scope while the returned reference
> be still alive, it will report an error.

Okay, so is there something I need to do to ensure we increase the
refcount?  Does inc_ref() need calling manually?

-- 
Lee Jones [李琼斯]

