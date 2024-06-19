Return-Path: <linux-kernel+bounces-220796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 790F990E739
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BB0B1C20E26
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B02280C07;
	Wed, 19 Jun 2024 09:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PUzJU9ZG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F067E0E8
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 09:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718790272; cv=none; b=cG5Q1ZDW5zFwC8HqIPp8FEHmsnRBpLusSrIJGLF0MK65S/mHuAP5+QNXv34xIELPGKoWik8EszTwON6IVv31AnsR1ipZHroYkrPAJNztvTRPOV3sGJN7DLJwjLXyEOYdjvn1QUj5SCK39rteSE0y4D6pHMwMin5lnTSPvRfRuEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718790272; c=relaxed/simple;
	bh=VMP6mhRgwQY7n/LpInyVNncbyTcsOnGfFQ1jlSOwKk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxNg8L5q0geYQIm/zadX8RXRLV7RcWz8zC5j7Znv8kkbUFR5NAAyQcqWAW0q8v2odME2VBJ2JnuBnjv6FikmVGxmh8R/rU18ROVJEEbequtY7KOPW0nqQ27j49oQ0BxgmsLITQSFkPiAkprQW81BYOAvldZu1SdqvRdf7d/xNyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PUzJU9ZG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718790269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8diI/1+iVj3Udu4e3kTQO2ehU3caQ3L16dUerpou0Mc=;
	b=PUzJU9ZGcYFCu0zGltGhCd0lq6lOPrsFBAlTbjlCIgkwQBu2je/Ij0aBVPXtCF9mJZUPpD
	FPYcLlRask5SLOK0H2JawwV9xo70Km9caDqgwTSN3YdeUXWlmi1Diva0ED1PSJ449BPo56
	om+rcMQdU/TJ2j9OIrd9EQ2BO+AapsY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-1hP9uvrlNXOe5QBg1lK0Ig-1; Wed, 19 Jun 2024 05:44:28 -0400
X-MC-Unique: 1hP9uvrlNXOe5QBg1lK0Ig-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-35f1230659bso4487210f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 02:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718790267; x=1719395067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8diI/1+iVj3Udu4e3kTQO2ehU3caQ3L16dUerpou0Mc=;
        b=HE1M79cu35vkEuGtld6JgZV1mqMcFkw9sIHC1rKkSSm2iF7qVpRQWdh2PQIzABedhP
         cKUKiNPF3rM9KNhBrvRAjcPD1+lULs1DBOJmLbx11P118s+LjsKxD6Z3FPSqqePaYYdU
         LMf97LielOoKsSeWPHaHHT2maJuvPgsXFnFm6fC/lwGzn0/UiTOSxhe7CtyuE84Ezm+d
         4ew5E93h2yajXkMqMSdkJuoS5xyCnXcHJRoGi85e5lQsvluPIcoEsaiWUxa8Gb7RDEKI
         o1XPt/GDexoIy8HX5zy6/t6VtdCd2oisNFUspHs95xlZY1Sx+LbR9+Xl+Gt/tzQ23+9U
         1ODw==
X-Forwarded-Encrypted: i=1; AJvYcCWHk0tTHDYAfzKwlyhlwuTVkssEujU/CWCibddACJ78w6D4ghOcerom02wFSiZsLAjSshkriZO81CWaFttQZFFzEE05QXWPbiyZs5RI
X-Gm-Message-State: AOJu0YxUK/OyhBpD2jgvwtgqFk4GDLyjnSjP8fWIMlUCE3UDQuUNJzpR
	6hGVM87epZosDGjvDglOiB+xNsAnqJcJvubODYnIt9N+ZMI6JIQV6v1lBGUbJ2SFTciqs/mVwI1
	GcRCNAoyQ+rxT2AGupemCo2Fgsvy2TDVQp3OoqeK6JDbxllZgQtVrHPH5uphwXQ==
X-Received: by 2002:a5d:53cd:0:b0:362:5b83:51dd with SMTP id ffacd0b85a97d-363192cdeb4mr1670536f8f.49.1718790266833;
        Wed, 19 Jun 2024 02:44:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5RS7E8zp8zdTdBbL1WHPRHc72MBqW/N8DEob/STZGOgVB+66YWRdUf8oOtYWcNhh/aJEuZw==
X-Received: by 2002:a5d:53cd:0:b0:362:5b83:51dd with SMTP id ffacd0b85a97d-363192cdeb4mr1670499f8f.49.1718790266398;
        Wed, 19 Jun 2024 02:44:26 -0700 (PDT)
Received: from pollux ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075c6fa4esm16532128f8f.67.2024.06.19.02.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 02:44:25 -0700 (PDT)
Date: Wed, 19 Jun 2024 11:44:23 +0200
From: Danilo Krummrich <dakr@redhat.com>
To: Benno Lossin <benno.lossin@proton.me>, gregkh@linuxfoundation.org
Cc: rafael@kernel.org, mcgrof@kernel.org, russ.weight@linux.dev,
	ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, pstanner@redhat.com, ajanulgu@redhat.com,
	lyude@redhat.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] rust: add firmware abstractions
Message-ID: <ZnKod6Wn5louhPu8@pollux>
References: <20240618154841.6716-1-dakr@redhat.com>
 <20240618154841.6716-3-dakr@redhat.com>
 <8d6f98c2-afe2-4e94-b630-96a8fa0b39cf@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d6f98c2-afe2-4e94-b630-96a8fa0b39cf@proton.me>

Greg,

Benno's comments provide some nice hints to further improve the safety comments.
Since I was notified that those patches hit your tree already, how do you want
to proceed?

- Danilo

On Wed, Jun 19, 2024 at 08:58:02AM +0000, Benno Lossin wrote:
> On 18.06.24 17:48, Danilo Krummrich wrote:
> > Add an abstraction around the kernels firmware API to request firmware
> > images. The abstraction provides functions to access the firmware's size
> > and backing buffer.
> > 
> > The firmware is released once the abstraction instance is dropped.
> > 
> > Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> > ---
> >  drivers/base/firmware_loader/Kconfig |   7 ++
> >  rust/bindings/bindings_helper.h      |   1 +
> >  rust/kernel/firmware.rs              | 101 +++++++++++++++++++++++++++
> >  rust/kernel/lib.rs                   |   2 +
> >  4 files changed, 111 insertions(+)
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
> > index 000000000000..b55ea1b45368
> > --- /dev/null
> > +++ b/rust/kernel/firmware.rs
> > @@ -0,0 +1,101 @@
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
> > +/// Once requested, the `Firmware` backing buffer is not modified until it is freed when `Firmware`
> > +/// is dropped.
> 
> This can simply be "The `firmware`'s backing buffer is not modified."
> Since I interpret "Once requested" as "Once created" and you are allowed
> to break invariants as long as nobody can observe that.
> 
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
> I would not write "Safe by ...", since it is important to know what is
> guaranteed by what. Instead I would write "self.as_raw() is valid by the
> type invariant.".
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
> 
> Ditto.
> 
> ---
> Cheers,
> Benno
> 
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


