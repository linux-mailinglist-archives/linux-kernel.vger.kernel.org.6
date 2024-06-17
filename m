Return-Path: <linux-kernel+bounces-218359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7992E90BD3C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 063251F22421
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 22:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4131991B0;
	Mon, 17 Jun 2024 22:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aW8nhXxn"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CB07492;
	Mon, 17 Jun 2024 22:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718661950; cv=none; b=r196KMF7/lmxSBxlVGWr0Lm/gapBYktxi+xMvxyc9eIhQWkkoWuIaBkmpbEFVRC47NNiavT1DWkXpMNw1PZgglMtWUuA+sIdl/lLXbwZRkUyRA2pFNGgrEYdjqkNonW5ui82cKYxxC9+w2vtg/8JRpxh+w9BeTMybf6Ocadf77w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718661950; c=relaxed/simple;
	bh=7R+guiV/wux1cWkOhuAuMdkPTBsT01uwASX1THSYKk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RayuuBU9jicykH6QyYTq2XfUt+EvLiUGyincWGLXtB/Y7WcG9Oy9NjLATZY9eOFPwnv7GZbynVJK9J9T+R2rChD1A5gye7QIgQJTH1aoVg3XotHllQuBOuQK2s8aOQ95z10hTZjVUlkwz95iTzBZARgwjBeLl2y/7sSMa3IrTTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aW8nhXxn; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4405cf0cb1eso23809781cf.1;
        Mon, 17 Jun 2024 15:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718661947; x=1719266747; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuYFprv0GR/M+oPWiYKqx3TRu5G5LG5KQUFGeOZic5o=;
        b=aW8nhXxnJLlIhRrG+XRcc1X/lPkG3bhTREISpSiqaexGBZKlEM6sZvtpWuRKw6oEea
         0OqfupvXcfHejbCEAdmVtEZ6BMj2GE+gp/OlvhN2ZNAP5s155mEMVO7TmlD2IM16z/9F
         ClMXAt/jJYN9n3KisxdW8TaRvRcAlq7uLeZ+MSCMSNwnBBpeSB4u/yXjRJMgVoxJzy8j
         NoV+Y6FO849RG5C/Tll35+8iUmv48ZTXa8g34g+9Iba0DKhTIJoMdvyemTUO7jIPxGe6
         fUjVMN2efmnqCymMxeljukf48XAMo+QTji67lZ1bFj39dYGpM7TbC/eNwIIsaNchpI6h
         4KAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718661947; x=1719266747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PuYFprv0GR/M+oPWiYKqx3TRu5G5LG5KQUFGeOZic5o=;
        b=LWj8G3XBT372L8sXdUGblaoLBqrQJcb5Y+2jRom0VB/Sbqq9DsXByJFHodtEzMA0yr
         ii4OMxoBNawCEqTPL44NRxBJxZWB5XM3LtkJjQuePmi6fmXBKKRhpa6NNkwY+2yixKiD
         L4OGsDjQjfohhSzq1FkxOkgoI6PcXf3FusOM1Qi+1TmiL3CMBbxuDe+bfIJmrzKkS1q0
         HoLx5rvtZDS4TBy2pnkV08HWXutD0QpEmfjLkZJNPDNzIgzONULJUQUAIhZ8882BnchY
         bDfkoXuFvJD94FTyc1N3mjKP2/51VJRcUZYlY8ukwrKuMDbn6seBb8QJTKKbMcta5cea
         orJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFi/YbIFl5LGjSB14ia5qKGEn99CjN/w6w6wmvbv1f1PM375FYlJWsIDy/PmBxXidFVEBukJR3/m3tQ60pid2Ha0JcKqBNi54lYLzYMlEsFaIM8CdvRbhTyABtkyqYy1IU7LjCWQLIB4tOpsI=
X-Gm-Message-State: AOJu0Yz4Wt399MV9zQ3vMxx6rKWeaUWyr3ifssoILLEvYTRy5bdSXNlo
	5hdwgkImQvLfrpN7rNF485p1fgE06VE2GzQ7bL7hnZQAtLF2rRo6
X-Google-Smtp-Source: AGHT+IH6xS0lvOK3WKF6bFIOGHypQSv5YZT35t/Y2KN2Y3jrmkHPq0ctUhqqrGxjT28QQvI+IoQExA==
X-Received: by 2002:a05:622a:594:b0:441:56cf:cf45 with SMTP id d75a77b69052e-44216892fb4mr141719221cf.19.1718661947235;
        Mon, 17 Jun 2024 15:05:47 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4449a1d67dasm5327731cf.44.2024.06.17.15.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 15:05:46 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id B0A46120006A;
	Mon, 17 Jun 2024 18:05:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 17 Jun 2024 18:05:45 -0400
X-ME-Sender: <xms:ObNwZjdiGq4mYj0RxIXxmDShWKIS0JML3WpeWRfnEBHFZHpAHpYXzg>
    <xme:ObNwZpNXI1p_KhX9MpvqNx3bP9-DooGkluZFGTC59m-Bvb3MfNPXjWjftaagJRy1F
    UCHHNr1RQaZw0f9ig>
X-ME-Received: <xmr:ObNwZsiznk6C_GNUpx_SjqHIuz8wWlGOaZ4MFOESgGLVPxQwrafwJuZdQAmEig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedviedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeelffektdeifefgkeffueeugeefhfevgfdutdeigfehgeejteeukeethedv
    keeuleenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgrshgprhgrfidruggrthgrne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgv
X-ME-Proxy: <xmx:ObNwZk-oW4A6dozzEFJtqFeWK51l2IMEH2MifJ-Kv8Tz2sqyCC3qZw>
    <xmx:ObNwZvtnVefjtPux4O9VLbDVuHcdYbbW9UvEen2YnrSUSObnsuv8Kw>
    <xmx:ObNwZjFkE0HYYDCTff2qB1xgJ88kpYjhHM5exiw1jgw7z9lEt5vCdg>
    <xmx:ObNwZmNAD2_a8X3s3hNyoXC3KynVSfvMOISB2JCu7tLqMQakk05mdQ>
    <xmx:ObNwZgMpTDvfYI2_1NWTdi-9A72Mp--cIPBPvNko4t3zTIkr1YjBPiAc>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Jun 2024 18:05:44 -0400 (EDT)
Date: Mon, 17 Jun 2024 15:05:32 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Danilo Krummrich <dakr@redhat.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, mcgrof@kernel.org,
	russ.weight@linux.dev, ojeda@kernel.org, alex.gaynor@gmail.com,
	wedsonaf@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, airlied@gmail.com, fujita.tomonori@gmail.com,
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] rust: add firmware abstractions
Message-ID: <ZnCzLIly3DRK2eab@boqun-archlinux>
References: <20240617203010.101452-1-dakr@redhat.com>
 <20240617203010.101452-3-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617203010.101452-3-dakr@redhat.com>

On Mon, Jun 17, 2024 at 10:29:41PM +0200, Danilo Krummrich wrote:
> Add an abstraction around the kernels firmware API to request firmware
> images. The abstraction provides functions to access the firmware's size
> and backing buffer.
> 
> The firmware is released once the abstraction instance is dropped.
> 
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> ---
>  drivers/base/firmware_loader/Kconfig |  7 ++
>  rust/bindings/bindings_helper.h      |  1 +
>  rust/kernel/firmware.rs              | 98 ++++++++++++++++++++++++++++
>  rust/kernel/lib.rs                   |  2 +
>  4 files changed, 108 insertions(+)
>  create mode 100644 rust/kernel/firmware.rs
> 
> diff --git a/drivers/base/firmware_loader/Kconfig b/drivers/base/firmware_loader/Kconfig
> index 5ca00e02fe82..a03701674265 100644
> --- a/drivers/base/firmware_loader/Kconfig
> +++ b/drivers/base/firmware_loader/Kconfig
> @@ -37,6 +37,13 @@ config FW_LOADER_DEBUG
>  	  SHA256 checksums to the kernel log for each firmware file that is
>  	  loaded.
>  
> +config RUST_FW_LOADER_ABSTRACTIONS
> +	bool "Rust Firmware Loader abstractions"
> +	depends on RUST
> +	depends on FW_LOADER=y
> +	help
> +	  This enables the Rust abstractions for the firmware loader API.
> +
>  if FW_LOADER
>  
>  config FW_LOADER_PAGED_BUF
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index ddb5644d4fd9..18a3f05115cb 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -9,6 +9,7 @@
>  #include <kunit/test.h>
>  #include <linux/errname.h>
>  #include <linux/ethtool.h>
> +#include <linux/firmware.h>
>  #include <linux/jiffies.h>
>  #include <linux/mdio.h>
>  #include <linux/phy.h>
> diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
> new file mode 100644
> index 000000000000..05a4f84cfd42
> --- /dev/null
> +++ b/rust/kernel/firmware.rs
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Firmware abstraction
> +//!
> +//! C header: [`include/linux/firmware.h`](srctree/include/linux/firmware.h")
> +
> +use crate::{bindings, device::Device, error::Error, error::Result, str::CStr};
> +use core::ptr::NonNull;
> +
> +// One of the following: `bindings::request_firmware`, `bindings::firmware_request_nowarn`,
> +// `firmware_request_platform`, `bindings::request_firmware_direct`
> +type FwFunc =
> +    unsafe extern "C" fn(*mut *const bindings::firmware, *const i8, *mut bindings::device) -> i32;
> +
> +/// Abstraction around a C `struct firmware`.
> +///
> +/// This is a simple abstraction around the C firmware API. Just like with the C API, firmware can
> +/// be requested. Once requested the abstraction provides direct access to the firmware buffer as
> +/// `&[u8]`. The firmware is released once [`Firmware`] is dropped.
> +///
> +/// # Invariants
> +///
> +/// The pointer is valid, and has ownership over the instance of `struct firmware`.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// # use kernel::{c_str, device::Device, firmware::Firmware};
> +///
> +/// # // SAFETY: *NOT* safe, just for the example to get an `ARef<Device>` instance
> +/// # let dev = unsafe { Device::from_raw(core::ptr::null_mut()) };
> +///
> +/// let fw = Firmware::request(c_str!("path/to/firmware.bin"), &dev).unwrap();
> +/// let blob = fw.data();
> +/// ```
> +pub struct Firmware(NonNull<bindings::firmware>);
> +

I feel like eventually we need a very simple smart pointer type for
these case, for example:

    /// A smart pointer owns the underlying data.
    pub struct Owned<T: Ownable> {
        ptr: NonNull<T>,
    }

    impl<T: Ownable> Owned<T> {
        /// # Safety
	/// `ptr` needs to be a valid pointer, and it should be the
	/// unique owner to the object, in other words, no one can touch
	/// or free the underlying data.
        pub unsafe to_owned(ptr: *mut T) -> Self {
	    // SAFETY: Per function safety requirement.
	    Self { ptr: unsafe { NonNull::new_unchecked(ptr) } }
	}

	/// other safe constructors are available if a initializer (impl
	/// Init) is provided
    }

    /// A Ownable type is a type that can be put into `Owned<T>`, and
    /// when `Owned<T>` drops, `ptr_drop` will be called.
    pub unsafe trait Ownable {
        /// # Safety
	/// This could only be called in the `Owned::drop` function.
        unsafe fn ptr_drop(ptr: *mut Self);
    }

    impl<T: Ownable> Drop for Owned<T> {
        fn drop(&mut self) {
	    /// SAFETY: In Owned<T>::drop.
	    unsafe {
	        <T as Ownable>::ptr_drop(self.as_mut_ptr());
	    }
	}
    }

we can implement Deref and DerefMut easily on `Owned<T>`. And then we
could define Firmware as

    #[repr(transparent)]
    pub struct Firmware(Opaque<bindings::firmware>);

and

    unsafe impl Ownable for Firmware {
        unsafe fn ptr_drop(ptr: *mut Self) {
	    // SAFETY: Per function safety, this is called in
	    // Owned::drop(), so `ptr` is a unique pointer to object,
	    // it's safe to release the firmware.
            unsafe { bindings::release_firmware(ptr.cast()); }
        }
    }

and the request_*() will return a `Result<Owned<Self>>`. 

Alice mentioned the need of this in page as well:

	https://lore.kernel.org/rust-for-linux/CAH5fLgjrt0Ohj1qBv=GrqZumBTMQ1jbsKakChmxmG2JYDJEM8w@mail.gmail.com		

Just bring it up while we are (maybe not? ;-)) at it. Also I would like
to hear whether this would work for Firmware in the longer-term ;-) But
yes, I'm not that worried about merging it as it is if others are all
OK.

> +impl Firmware {
> +    fn request_internal(name: &CStr, dev: &Device, func: FwFunc) -> Result<Self> {
> +        let mut fw: *mut bindings::firmware = core::ptr::null_mut();
> +        let pfw: *mut *mut bindings::firmware = &mut fw;
> +
> +        // SAFETY: `pfw` is a valid pointer to a NULL initialized `bindings::firmware` pointer.
> +        // `name` and `dev` are valid as by their type invariants.
> +        let ret = unsafe { func(pfw as _, name.as_char_ptr(), dev.as_raw()) };
> +        if ret != 0 {
> +            return Err(Error::from_errno(ret));
> +        }
> +
> +        // SAFETY: `func` not bailing out with a non-zero error code, guarantees that `fw` is a
> +        // valid pointer to `bindings::firmware`.
> +        Ok(Firmware(unsafe { NonNull::new_unchecked(fw) }))
> +    }
> +
> +    /// Send a firmware request and wait for it. See also `bindings::request_firmware`.
> +    pub fn request(name: &CStr, dev: &Device) -> Result<Self> {
> +        Self::request_internal(name, dev, bindings::request_firmware)
> +    }
> +
> +    /// Send a request for an optional firmware module. See also
> +    /// `bindings::firmware_request_nowarn`.
> +    pub fn request_nowarn(name: &CStr, dev: &Device) -> Result<Self> {
> +        Self::request_internal(name, dev, bindings::firmware_request_nowarn)
> +    }
> +
> +    fn as_raw(&self) -> *mut bindings::firmware {
> +        self.0.as_ptr()
> +    }
> +
> +    /// Returns the size of the requested firmware in bytes.
> +    pub fn size(&self) -> usize {
> +        // SAFETY: Safe by the type invariant.
> +        unsafe { (*self.as_raw()).size }
> +    }
> +
> +    /// Returns the requested firmware as `&[u8]`.
> +    pub fn data(&self) -> &[u8] {
> +        // SAFETY: Safe by the type invariant. Additionally, `bindings::firmware` guarantees, if

Does this "Safe by the type invariant" also covers the following safe
requirement of `from_raw_parts`?

	The memory referenced by the returned slice must not be mutated for the duration of lifetime 'a, except inside an UnsafeCell.

in that `&[u8]` has the same lifetime as `&self`, and as long as
`&self` exists, no function can touch the inner `data`? If so, I
probably want to call this out.

Regards,
Boqun

> +        // successfully requested, that `bindings::firmware::data` has a size of
> +        // `bindings::firmware::size` bytes.
> +        unsafe { core::slice::from_raw_parts((*self.as_raw()).data, self.size()) }
> +    }
> +}
> +
> +impl Drop for Firmware {
> +    fn drop(&mut self) {
> +        // SAFETY: Safe by the type invariant.
> +        unsafe { bindings::release_firmware(self.as_raw()) };
> +    }
> +}
> +
> +// SAFETY: `Firmware` only holds a pointer to a C `struct firmware`, which is safe to be used from
> +// any thread.
> +unsafe impl Send for Firmware {}
> +
> +// SAFETY: `Firmware` only holds a pointer to a C `struct firmware`, references to which are safe to
> +// be used from any thread.
> +unsafe impl Sync for Firmware {}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index dd1207f1a873..7707cb013ce9 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -30,6 +30,8 @@
>  mod build_assert;
>  pub mod device;
>  pub mod error;
> +#[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
> +pub mod firmware;
>  pub mod init;
>  pub mod ioctl;
>  #[cfg(CONFIG_KUNIT)]
> -- 
> 2.45.1
> 

