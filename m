Return-Path: <linux-kernel+bounces-218401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AACD90BF38
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 153E21C22B48
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 22:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D101993A9;
	Mon, 17 Jun 2024 22:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YTnUzWZ6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9CB19069C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 22:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718664658; cv=none; b=GsLB4BrmfCS5AxmrBPOrQ7cSWZDqxqa+3OJO0854250q+Y4VHLaarWi+Q7WnzwFUDnOfT3Dm+lSMIqeNOFrWpNyuWGVCmUf+x1OxB96Z0TZoCqvE8CIvTqJrRPYqI5Gt6n8+JQSuab6EM77Xetv0GNfunreoWuzLjyIPPt4BzhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718664658; c=relaxed/simple;
	bh=HEWUK6bdL9EW9nryzTZspp0xb1vBnajyA8g5xFQ46GU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjuFpEHkVef5wL7s0xgQAEYIIKTfTrpeTV/1ezXts0evIx+0DH/zeMwo0nLrcsF0o8r9VnZ4vDtnl5cbwbp0H96e9FlI61lXQ8sk7z0fkM/fRb4nvuWw2JFzXGcZuS410cZXEOA9L5/tGbezTdXl3ndyP10MGgcIRIh2jIvf1VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YTnUzWZ6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718664655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FI+Lsreg2NUHIrTwyfhuKoVJ7UaM/v+Wceo88R/pEC0=;
	b=YTnUzWZ6dwrawSaMrpMOaPpHCypKRTBiP5/ygX7NlFz1NzYdqY9hkvYC1kBC/g+/OYYetn
	QkoU3RvWdWZkgIXXK/kV1+KyusxnDTBc4xnqkj1uLdfL3DRPVgpCGLaUPYz3IYZ2PxaIrh
	I/yb8wrTmDF/GlMgi76Sfbs0PEvEDoY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-PIi5-r_2MQCsrVE4yZ7_Ag-1; Mon, 17 Jun 2024 18:50:51 -0400
X-MC-Unique: PIi5-r_2MQCsrVE4yZ7_Ag-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-35f1230659bso3401620f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 15:50:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718664648; x=1719269448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FI+Lsreg2NUHIrTwyfhuKoVJ7UaM/v+Wceo88R/pEC0=;
        b=Zi3SDtEvm70P+ckH+oTJOXX1BCvvri1WxaOy0vKr10bO2w0mWfV+BQJB9TAvwGwv9J
         Fq9PDl+LNi6Czzv5CjvSuZ/gb/6o9Ra5p2FkMhhnh88JK0XeAp58zjIvSVIHFciWmtnT
         +oIqpt+AaXmkqYHcxNl2Q0JxN5M5HF++1QOdYFybnaS5FURRZ9UKA2HP3XhRiRrZ4/JE
         407jOLs4YUjDiF0G7qxvalpoQPlWNFiNZyF5x91P2beoAi/KeHyyhOIYSfCKPUi0i8Tr
         d6pvdQHkWzl2W1IiVGeoE+x3+csuvvfmkknxnqDWyopbj7i0WyPGdJktBmNbU51jSwpK
         o/og==
X-Forwarded-Encrypted: i=1; AJvYcCXmXWcFhgmW8+9qT2n3g9oZkh4TDGseVyOwtQHGt/5V4pIesXaOvlmMHFHswg8BOSoNf3+WOHMXcqjqhsPD08t7KRd8QtETf2GgpYx0
X-Gm-Message-State: AOJu0YyBDquq50aWZ2Ku2z4Hn+TmqaVgXWLEklAKSYTNS2q+HcQcLYTb
	dTOFAjWLOqsD539X4WoxV8fcOlRho7jem1ixyPNnmKrQby8OFinOiJTEN84B7pz6chlJ4KFE3nk
	Zkz+f/eGWWIj+p9eYA4iPjdbTjOOMGNHRbBHJ7cNcFjHVZCqeNRI7df4c7ccuFA==
X-Received: by 2002:a5d:5987:0:b0:35f:f58:38f6 with SMTP id ffacd0b85a97d-3607a7838c6mr8447831f8f.49.1718664648502;
        Mon, 17 Jun 2024 15:50:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiymbbgXEScj4GiC5BPfcwtItANz00+7/xzWt2OIJKKbKFcwmU2cWReGm+WQueVWR6sQGJGw==
X-Received: by 2002:a5d:5987:0:b0:35f:f58:38f6 with SMTP id ffacd0b85a97d-3607a7838c6mr8447798f8f.49.1718664647968;
        Mon, 17 Jun 2024 15:50:47 -0700 (PDT)
Received: from cassiopeiae ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874de607sm210127145e9.34.2024.06.17.15.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 15:50:47 -0700 (PDT)
Date: Tue, 18 Jun 2024 00:50:45 +0200
From: Danilo Krummrich <dakr@redhat.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, mcgrof@kernel.org,
	russ.weight@linux.dev, ojeda@kernel.org, alex.gaynor@gmail.com,
	wedsonaf@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, airlied@gmail.com, fujita.tomonori@gmail.com,
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] rust: add firmware abstractions
Message-ID: <ZnC9xajuhN6nSQb-@cassiopeiae>
References: <20240617203010.101452-1-dakr@redhat.com>
 <20240617203010.101452-3-dakr@redhat.com>
 <ZnCzLIly3DRK2eab@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnCzLIly3DRK2eab@boqun-archlinux>

On Mon, Jun 17, 2024 at 03:05:32PM -0700, Boqun Feng wrote:
> On Mon, Jun 17, 2024 at 10:29:41PM +0200, Danilo Krummrich wrote:
> > Add an abstraction around the kernels firmware API to request firmware
> > images. The abstraction provides functions to access the firmware's size
> > and backing buffer.
> > 
> > The firmware is released once the abstraction instance is dropped.
> > 
> > Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> > ---
> >  drivers/base/firmware_loader/Kconfig |  7 ++
> >  rust/bindings/bindings_helper.h      |  1 +
> >  rust/kernel/firmware.rs              | 98 ++++++++++++++++++++++++++++
> >  rust/kernel/lib.rs                   |  2 +
> >  4 files changed, 108 insertions(+)
> >  create mode 100644 rust/kernel/firmware.rs
> > 
> > diff --git a/drivers/base/firmware_loader/Kconfig b/drivers/base/firmware_loader/Kconfig
> > index 5ca00e02fe82..a03701674265 100644
> > --- a/drivers/base/firmware_loader/Kconfig
> > +++ b/drivers/base/firmware_loader/Kconfig
> > @@ -37,6 +37,13 @@ config FW_LOADER_DEBUG
> >  	  SHA256 checksums to the kernel log for each firmware file that is
> >  	  loaded.
> >  
> > +config RUST_FW_LOADER_ABSTRACTIONS
> > +	bool "Rust Firmware Loader abstractions"
> > +	depends on RUST
> > +	depends on FW_LOADER=y
> > +	help
> > +	  This enables the Rust abstractions for the firmware loader API.
> > +
> >  if FW_LOADER
> >  
> >  config FW_LOADER_PAGED_BUF
> > diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> > index ddb5644d4fd9..18a3f05115cb 100644
> > --- a/rust/bindings/bindings_helper.h
> > +++ b/rust/bindings/bindings_helper.h
> > @@ -9,6 +9,7 @@
> >  #include <kunit/test.h>
> >  #include <linux/errname.h>
> >  #include <linux/ethtool.h>
> > +#include <linux/firmware.h>
> >  #include <linux/jiffies.h>
> >  #include <linux/mdio.h>
> >  #include <linux/phy.h>
> > diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
> > new file mode 100644
> > index 000000000000..05a4f84cfd42
> > --- /dev/null
> > +++ b/rust/kernel/firmware.rs
> > @@ -0,0 +1,98 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! Firmware abstraction
> > +//!
> > +//! C header: [`include/linux/firmware.h`](srctree/include/linux/firmware.h")
> > +
> > +use crate::{bindings, device::Device, error::Error, error::Result, str::CStr};
> > +use core::ptr::NonNull;
> > +
> > +// One of the following: `bindings::request_firmware`, `bindings::firmware_request_nowarn`,
> > +// `firmware_request_platform`, `bindings::request_firmware_direct`
> > +type FwFunc =
> > +    unsafe extern "C" fn(*mut *const bindings::firmware, *const i8, *mut bindings::device) -> i32;
> > +
> > +/// Abstraction around a C `struct firmware`.
> > +///
> > +/// This is a simple abstraction around the C firmware API. Just like with the C API, firmware can
> > +/// be requested. Once requested the abstraction provides direct access to the firmware buffer as
> > +/// `&[u8]`. The firmware is released once [`Firmware`] is dropped.
> > +///
> > +/// # Invariants
> > +///
> > +/// The pointer is valid, and has ownership over the instance of `struct firmware`.
> > +///
> > +/// # Examples
> > +///
> > +/// ```
> > +/// # use kernel::{c_str, device::Device, firmware::Firmware};
> > +///
> > +/// # // SAFETY: *NOT* safe, just for the example to get an `ARef<Device>` instance
> > +/// # let dev = unsafe { Device::from_raw(core::ptr::null_mut()) };
> > +///
> > +/// let fw = Firmware::request(c_str!("path/to/firmware.bin"), &dev).unwrap();
> > +/// let blob = fw.data();
> > +/// ```
> > +pub struct Firmware(NonNull<bindings::firmware>);
> > +
> 
> I feel like eventually we need a very simple smart pointer type for
> these case, for example:
> 
>     /// A smart pointer owns the underlying data.
>     pub struct Owned<T: Ownable> {
>         ptr: NonNull<T>,
>     }
> 
>     impl<T: Ownable> Owned<T> {
>         /// # Safety
> 	/// `ptr` needs to be a valid pointer, and it should be the
> 	/// unique owner to the object, in other words, no one can touch
> 	/// or free the underlying data.
>         pub unsafe to_owned(ptr: *mut T) -> Self {
> 	    // SAFETY: Per function safety requirement.
> 	    Self { ptr: unsafe { NonNull::new_unchecked(ptr) } }
> 	}
> 
> 	/// other safe constructors are available if a initializer (impl
> 	/// Init) is provided
>     }
> 
>     /// A Ownable type is a type that can be put into `Owned<T>`, and
>     /// when `Owned<T>` drops, `ptr_drop` will be called.
>     pub unsafe trait Ownable {
>         /// # Safety
> 	/// This could only be called in the `Owned::drop` function.
>         unsafe fn ptr_drop(ptr: *mut Self);
>     }
> 
>     impl<T: Ownable> Drop for Owned<T> {
>         fn drop(&mut self) {
> 	    /// SAFETY: In Owned<T>::drop.
> 	    unsafe {
> 	        <T as Ownable>::ptr_drop(self.as_mut_ptr());
> 	    }
> 	}
>     }
> 
> we can implement Deref and DerefMut easily on `Owned<T>`. And then we
> could define Firmware as
> 
>     #[repr(transparent)]
>     pub struct Firmware(Opaque<bindings::firmware>);
> 
> and
> 
>     unsafe impl Ownable for Firmware {
>         unsafe fn ptr_drop(ptr: *mut Self) {
> 	    // SAFETY: Per function safety, this is called in
> 	    // Owned::drop(), so `ptr` is a unique pointer to object,
> 	    // it's safe to release the firmware.
>             unsafe { bindings::release_firmware(ptr.cast()); }
>         }
>     }
> 
> and the request_*() will return a `Result<Owned<Self>>`. 
> 
> Alice mentioned the need of this in page as well:
> 
> 	https://lore.kernel.org/rust-for-linux/CAH5fLgjrt0Ohj1qBv=GrqZumBTMQ1jbsKakChmxmG2JYDJEM8w@mail.gmail.com		

I think in the `Page` case this is useful to create `Page` references from
previously allocated memory.

In the case of `Firmware`, I agree it makes sense to use it once we have it,
but other than for consistency, is there any advantage?

> 
> Just bring it up while we are (maybe not? ;-)) at it. Also I would like
> to hear whether this would work for Firmware in the longer-term ;-) But
> yes, I'm not that worried about merging it as it is if others are all
> OK.

I think there's not too much to add here in the future, once we got an allocator
API (I should get back to that soon), I want to add a method that copies the
data to a new buffer allocated with a given allocator. And maybe we want to
support a few other request_firmware_* functions in the future, but none of that
should require the above abstraction.

> 
> > +impl Firmware {
> > +    fn request_internal(name: &CStr, dev: &Device, func: FwFunc) -> Result<Self> {
> > +        let mut fw: *mut bindings::firmware = core::ptr::null_mut();
> > +        let pfw: *mut *mut bindings::firmware = &mut fw;
> > +
> > +        // SAFETY: `pfw` is a valid pointer to a NULL initialized `bindings::firmware` pointer.
> > +        // `name` and `dev` are valid as by their type invariants.
> > +        let ret = unsafe { func(pfw as _, name.as_char_ptr(), dev.as_raw()) };
> > +        if ret != 0 {
> > +            return Err(Error::from_errno(ret));
> > +        }
> > +
> > +        // SAFETY: `func` not bailing out with a non-zero error code, guarantees that `fw` is a
> > +        // valid pointer to `bindings::firmware`.
> > +        Ok(Firmware(unsafe { NonNull::new_unchecked(fw) }))
> > +    }
> > +
> > +    /// Send a firmware request and wait for it. See also `bindings::request_firmware`.
> > +    pub fn request(name: &CStr, dev: &Device) -> Result<Self> {
> > +        Self::request_internal(name, dev, bindings::request_firmware)
> > +    }
> > +
> > +    /// Send a request for an optional firmware module. See also
> > +    /// `bindings::firmware_request_nowarn`.
> > +    pub fn request_nowarn(name: &CStr, dev: &Device) -> Result<Self> {
> > +        Self::request_internal(name, dev, bindings::firmware_request_nowarn)
> > +    }
> > +
> > +    fn as_raw(&self) -> *mut bindings::firmware {
> > +        self.0.as_ptr()
> > +    }
> > +
> > +    /// Returns the size of the requested firmware in bytes.
> > +    pub fn size(&self) -> usize {
> > +        // SAFETY: Safe by the type invariant.
> > +        unsafe { (*self.as_raw()).size }
> > +    }
> > +
> > +    /// Returns the requested firmware as `&[u8]`.
> > +    pub fn data(&self) -> &[u8] {
> > +        // SAFETY: Safe by the type invariant. Additionally, `bindings::firmware` guarantees, if
> 
> Does this "Safe by the type invariant" also covers the following safe
> requirement of `from_raw_parts`?
> 
> 	The memory referenced by the returned slice must not be mutated for the duration of lifetime 'a, except inside an UnsafeCell.
> 
> in that `&[u8]` has the same lifetime as `&self`, and as long as
> `&self` exists, no function can touch the inner `data`? If so, I
> probably want to call this out.

Yes, nothing should ever modify the firmware buffer after it has been requested
successfully. I can add this to the type invariant.

> 
> Regards,
> Boqun
> 
> > +        // successfully requested, that `bindings::firmware::data` has a size of
> > +        // `bindings::firmware::size` bytes.
> > +        unsafe { core::slice::from_raw_parts((*self.as_raw()).data, self.size()) }
> > +    }
> > +}
> > +
> > +impl Drop for Firmware {
> > +    fn drop(&mut self) {
> > +        // SAFETY: Safe by the type invariant.
> > +        unsafe { bindings::release_firmware(self.as_raw()) };
> > +    }
> > +}
> > +
> > +// SAFETY: `Firmware` only holds a pointer to a C `struct firmware`, which is safe to be used from
> > +// any thread.
> > +unsafe impl Send for Firmware {}
> > +
> > +// SAFETY: `Firmware` only holds a pointer to a C `struct firmware`, references to which are safe to
> > +// be used from any thread.
> > +unsafe impl Sync for Firmware {}
> > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > index dd1207f1a873..7707cb013ce9 100644
> > --- a/rust/kernel/lib.rs
> > +++ b/rust/kernel/lib.rs
> > @@ -30,6 +30,8 @@
> >  mod build_assert;
> >  pub mod device;
> >  pub mod error;
> > +#[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
> > +pub mod firmware;
> >  pub mod init;
> >  pub mod ioctl;
> >  #[cfg(CONFIG_KUNIT)]
> > -- 
> > 2.45.1
> > 
> 


