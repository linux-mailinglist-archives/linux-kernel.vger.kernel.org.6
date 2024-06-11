Return-Path: <linux-kernel+bounces-209994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 852AF903DD8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED2BA2847BC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A426B17D34B;
	Tue, 11 Jun 2024 13:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rb8aj9Cy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC4217BB35;
	Tue, 11 Jun 2024 13:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718113488; cv=none; b=sd9nNaSoqcKkXXhHF2aM202lgXCW0Ayop5oF3CGGNbI4XJX0qi1Xt6NOTQJBvPiEVoqmbCZvJ54+qahvKfRA4NNgCMyaxXQkFO8QMTpTbmrBZ+31WTKBi77Ek1d0dVhAzPALE3OKgUL75+XzJsZdVftD8DXykOAETJEidkFbB0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718113488; c=relaxed/simple;
	bh=7ngSoxLZaufS4dE9eWtSM/KyLBIsiZkn3hKOd64rBsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsdEkl/8kFU7BoBP0VOmxcGjIwWlRyfMidJ47cm4t8UsipJ4lBGXv3XayaJA1rhWWj10JiQkFf4skJfol806uEyhjKW/G/+VHxzbv5ZLg21K5C97ou3sw7sZlTO/x9/AfbvXQL0Z3iDwwNj4tTIu4JnS4Y4QDY5iidJy6zv7Oso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rb8aj9Cy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4888C2BD10;
	Tue, 11 Jun 2024 13:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718113488;
	bh=7ngSoxLZaufS4dE9eWtSM/KyLBIsiZkn3hKOd64rBsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rb8aj9CyHMjOQ3rsLMLqJh+C7UCJ+9/ozIMU+dTjJLkT60dTrnj+naKKqcZH11eL5
	 nq9Ug0U+Uea/MyxBXsF/RYzG+VzVWF8MrER+AMd7m+RBOYCXu4ZsVa8+cIZOsVzaAL
	 VZRhDY1T/gMhYDhsjzPvhisFWq7HrPuwTxnTC2OI=
Date: Tue, 11 Jun 2024 15:44:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@redhat.com>
Cc: rafael@kernel.org, mcgrof@kernel.org, russell.h.weight@intel.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, airlied@gmail.com, fujita.tomonori@gmail.com,
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] rust: add firmware abstractions
Message-ID: <2024061126-clang-relax-7875@gregkh>
References: <20240610180318.72152-1-dakr@redhat.com>
 <20240610180318.72152-3-dakr@redhat.com>
 <2024061128-provolone-coyness-1d3c@gregkh>
 <ZmhSXuO_hmV8Tmjx@pollux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmhSXuO_hmV8Tmjx@pollux>

On Tue, Jun 11, 2024 at 03:34:22PM +0200, Danilo Krummrich wrote:
> On Tue, Jun 11, 2024 at 08:31:46AM +0200, Greg KH wrote:
> > On Mon, Jun 10, 2024 at 08:02:28PM +0200, Danilo Krummrich wrote:
> > > Add an abstraction around the kernels firmware API to request firmware
> > > images. The abstraction provides functions to access the firmware's size
> > > and backing buffer.
> > > 
> > > The firmware is released once the abstraction instance is dropped.
> > > 
> > > Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> > > ---
> > >  rust/bindings/bindings_helper.h |   1 +
> > >  rust/kernel/firmware.rs         | 107 ++++++++++++++++++++++++++++++++
> > >  rust/kernel/lib.rs              |   1 +
> > >  3 files changed, 109 insertions(+)
> > >  create mode 100644 rust/kernel/firmware.rs
> > > 
> > > diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> > > index ddb5644d4fd9..18a3f05115cb 100644
> > > --- a/rust/bindings/bindings_helper.h
> > > +++ b/rust/bindings/bindings_helper.h
> > > @@ -9,6 +9,7 @@
> > >  #include <kunit/test.h>
> > >  #include <linux/errname.h>
> > >  #include <linux/ethtool.h>
> > > +#include <linux/firmware.h>
> > >  #include <linux/jiffies.h>
> > >  #include <linux/mdio.h>
> > >  #include <linux/phy.h>
> > > diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
> > > new file mode 100644
> > > index 000000000000..7ff4c325f670
> > > --- /dev/null
> > > +++ b/rust/kernel/firmware.rs
> > > @@ -0,0 +1,107 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +//! Firmware abstraction
> > > +//!
> > > +//! C header: [`include/linux/firmware.h`](srctree/include/linux/firmware.h")
> > > +
> > > +use crate::{bindings, device::Device, error::Error, error::Result, str::CStr};
> > > +use core::ptr::NonNull;
> > > +
> > > +// One of the following: `bindings::request_firmware`, `bindings::firmware_request_nowarn`,
> > > +// `firmware_request_platform`, `bindings::request_firmware_direct`
> > > +type FwFunc =
> > > +    unsafe extern "C" fn(*mut *const bindings::firmware, *const i8, *mut bindings::device) -> i32;
> > > +
> > > +/// Abstraction around a C `struct firmware`.
> > > +///
> > > +/// This is a simple abstraction around the C firmware API. Just like with the C API, firmware can
> > > +/// be requested. Once requested the abstraction provides direct access to the firmware buffer as
> > > +/// `&[u8]`. The firmware is released once [`Firmware`] is dropped.
> > > +///
> > > +/// # Invariants
> > > +///
> > > +/// The pointer is valid, and has ownership over the instance of `struct firmware`.
> > > +///
> > > +/// # Examples
> > > +///
> > > +/// ```
> > > +/// use kernel::firmware::Firmware;
> > > +///
> > > +/// let fw = Firmware::request("path/to/firmware.bin", dev.as_ref())?;
> > > +/// driver_load_firmware(fw.data());
> > > +/// ```
> > > +pub struct Firmware(NonNull<bindings::firmware>);
> > > +
> > > +impl Firmware {
> > > +    fn request_internal(name: &CStr, dev: &Device, func: FwFunc) -> Result<Self> {
> > > +        let mut fw: *mut bindings::firmware = core::ptr::null_mut();
> > > +        let pfw: *mut *mut bindings::firmware = &mut fw;
> > > +
> > > +        // SAFETY: `pfw` is a valid pointer to a NULL initialized `bindings::firmware` pointer.
> > > +        // `name` and `dev` are valid as by their type invariants.
> > > +        let ret = unsafe { func(pfw as _, name.as_char_ptr(), dev.as_raw()) };
> > > +        if ret != 0 {
> > > +            return Err(Error::from_errno(ret));
> > > +        }
> > > +
> > > +        // SAFETY: `func` not bailing out with a non-zero error code, guarantees that `fw` is a
> > > +        // valid pointer to `bindings::firmware`.
> > > +        Ok(Firmware(unsafe { NonNull::new_unchecked(fw) }))
> > > +    }
> > > +
> > > +    /// Send a firmware request and wait for it. See also `bindings::request_firmware`.
> > > +    pub fn request(name: &CStr, dev: &Device) -> Result<Self> {
> > > +        Self::request_internal(name, dev, bindings::request_firmware)
> > > +    }
> > 
> > How does this handle when CONFIG_FW_LOADER is not enabled?  Why are you
> > building these bindings if that option is not checked?
> 
> Good catch, gonna fix it.
> 
> > 
> > > +
> > > +    /// Send a request for an optional firmware module. See also
> > > +    /// `bindings::firmware_request_nowarn`.
> > > +    pub fn request_nowarn(name: &CStr, dev: &Device) -> Result<Self> {
> > > +        Self::request_internal(name, dev, bindings::firmware_request_nowarn)
> > > +    }
> > > +
> > > +    /// Send a request for a firmware with platform-fw fallback. See also
> > > +    /// `bindings::firmware_request_platform`.
> > > +    pub fn request_platform(name: &CStr, dev: &Device) -> Result<Self> {
> > > +        Self::request_internal(name, dev, bindings::firmware_request_platform)
> > > +    }
> > > +
> > > +    /// Send a request for a firmware directly without usermode helper. See also
> > > +    /// `bindings::request_firmware_direct`.
> > > +    pub fn request_direct(name: &CStr, dev: &Device) -> Result<Self> {
> > > +        Self::request_internal(name, dev, bindings::request_firmware_direct)
> > > +    }
> > 
> > Why just these variants?  Why not just add the ones that people actually
> > need instead of a random assortment like you choose here :)
> 
> Indeed seems a bit random, not entirely though. I chose `request_firmware` and
> `firmware_request_nowarn` since those are the ones we need in Nova, maybe we can
> switch some calls to `request_firmware_into_buf` in the future, once we got the
> allocator API in place.
> 
> I added `firmware_request_platform` and `request_firmware_direct` as well, since
> they share the same function signature as the ones mentioned above and hence all
> four of them share the same implementation through `Firmware::request_internal`,
> just passing a different function pointer.
> 
> If you prefer I can drop the latter for now though.

Yes, please only add bindings that you "know" will be used.  We can
always add new ones later.

thanks,

greg k-h

