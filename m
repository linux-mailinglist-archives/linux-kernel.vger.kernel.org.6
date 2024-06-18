Return-Path: <linux-kernel+bounces-219867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3E890D932
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 18:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A07B81C24872
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A31059164;
	Tue, 18 Jun 2024 16:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhNSThuG"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2964D8B8;
	Tue, 18 Jun 2024 16:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718728067; cv=none; b=cWl7ycNXeXS7Pb/yO9Jq5xCZMYxoPwNzobb/DvG2e0Im/s2lfUSiNNLf0w/uHskW8rcQ/HtiYXyLO4lFFUcMnRjFjQbPZCkcgPKWWRUI1uyNXOclkI03i/w6HOgMDknjLEpDw6pibeARs/9n3xy1bK1i+UmtQT6uPBNXdm3dcPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718728067; c=relaxed/simple;
	bh=xk1eteDDh91RJlmYHOjTcgHEYiJ89rU1D3HcGQA/rCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r51NwzA6kWjx635KysaM2rveqo7l326WbrO41nYCrZGlrbrYXXAelpodFfEvyJjsMqdTdpJyVKmsPFygIzUMy75xmABoe9avKsk3g4+hU7gBKx+wmzQA8OGYvgykf0uCZ2Nglc3XATUqhhBAZsdHczaiGDJNQ0lrjUYlmMJbdcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhNSThuG; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6b063047958so30470976d6.3;
        Tue, 18 Jun 2024 09:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718728065; x=1719332865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2oHa6Q/yu+mHpJNuQvmDw0WjTT0SzGDQU+6s6sa4h2U=;
        b=jhNSThuGgDL6+Q5P4WUQLHkNRnHLRE+mJbww/xBOjKi3Bi4LSLaD/4KrzoCH9D5Ubt
         +o/ASgl1Pd1z/gZ+pNyiwuWdm/1oB5OhGPa160SSy7pPdDy8DVMOBNs4OjKSvgD3Lg+e
         yqvIHC/WFGPnb1eYxUzH/d6rAaudeWNU0ipHjEvPbkcCFKmR2GK8PFKWdu+PhKTyXGIZ
         /5+30O59dcdDI0ATao869tt/YSlubzCcMpN5B4Tj/R3AayrwC3t0FY39ir9Fblq7BVo4
         2F8aqvsXKd+3+WZubbaHAjHI/mh44jcJSHj5P6rCzxpJfpg1Buvo+TCYKiLnQlNauCs0
         nzIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718728065; x=1719332865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2oHa6Q/yu+mHpJNuQvmDw0WjTT0SzGDQU+6s6sa4h2U=;
        b=JKYD7eYsxuHSKBGjoVVIRKb6PX5Ej8+1WG3KLtpSIDWJ5MsBTfGJRwui2nyV97fY3A
         w4IcdvHnlXpR6Yh0Obb4CsMlTrUV7RkaFW351+EOCiDlfoLC8/cSSeN7DdzGO3doZzUb
         7l4CcI4pAGWbpwD5Pmb9wF7A2L1XtYK9x508LZcFLP8KzeygR+V762nwlhGgKhwU/JiG
         2lAO+zXxScd0vLnIPrhuV7kyFpFUNxtSEzO6P4RqihOhbfFUOZk+y1z/twnZk4bMGjlV
         6BPuuytWt2Y0JmzkYyJvp4aHd3RP72Q8GmmmZxlqe3BcMe1pKGIPAbLUlkxZK7Bwdazc
         YJBA==
X-Forwarded-Encrypted: i=1; AJvYcCUGdnRU9B677KrnfYsqakh7iFLW+L/1eIMJMvty2amIMtAX3tk07JP7wgFKL9p/5OQ1ORL/oEN9+V4LgYQvZD5AKMKylxDHVwRFh59qPEZcDstGIlQheYmSH+39/0oURB4GnKofG3eTuQyADhE=
X-Gm-Message-State: AOJu0Ywf/gFx0m4d8rD8sGwQohVO6JThdHrsh8PgsUliIHXoEATrnqDl
	jIABy+YFJGT7CO04mTEh4Li0xjyEmHse7qygp7SJuzGeHPz7Gn4h
X-Google-Smtp-Source: AGHT+IEYFVxBAZn8jgwg3zOZshPwhC49GBtiB0BMuf+VxUn1r8UeuVS7x+p/Tbbwy3zRDYbHiRDMRg==
X-Received: by 2002:a0c:df0e:0:b0:6b2:b11b:c32d with SMTP id 6a1803df08f44-6b501eab16fmr2206076d6.52.1718728064721;
        Tue, 18 Jun 2024 09:27:44 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5bf289csm68017476d6.26.2024.06.18.09.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 09:27:44 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 639CB1200043;
	Tue, 18 Jun 2024 12:27:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 18 Jun 2024 12:27:43 -0400
X-ME-Sender: <xms:f7VxZlKx9WBhldblMF_7Fw8sLfbHTUB2ly0r2Uh84Rab2SjNKGwHLw>
    <xme:f7VxZhJIeuHqzOsZQDL4BUa2Vz9EeuSr2462dDtJamDMulkqzAv9rdQp8tZOoaL2G
    SnzVVWh7mdFyzjwug>
X-ME-Received: <xmr:f7VxZtszyeGZ3SgA-ysfEfWIFfihKQNcU2DD8EQQoM__uDB7cw-oka89xwZSyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvkedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehkeehvdeigeetueejleefveekkeevkeegheevueduleeiieehjeevfedu
    jefgveenucffohhmrghinheprghspghrrgifrdgurghtrgenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquh
    hnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:f7VxZmZCCeQcVG9P0r9oMRZ3AGb0j7xTxAG26yofqlsL7nhdNhyYVw>
    <xmx:f7VxZsat5E9ZUFfKJwe6lEzYFICNgsTATSYyossnWAuQBDQn-u-p5Q>
    <xmx:f7VxZqB97N_o3HSZf4Or_yButQk0Uqv3J6qk9iX1l-yDyHOIkzCw5Q>
    <xmx:f7VxZqbOrNKVmZULGaKlLdR_fvHOwRgysdiqfRievrBt9CCOPjHCew>
    <xmx:f7VxZort9XLKrHoXLZOteTmpmXg3d4_s_UWdza3lPPCKa0ITd5O8Qqp0>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Jun 2024 12:27:42 -0400 (EDT)
Date: Tue, 18 Jun 2024 09:27:27 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Danilo Krummrich <dakr@redhat.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, mcgrof@kernel.org,
	russ.weight@linux.dev, ojeda@kernel.org, alex.gaynor@gmail.com,
	wedsonaf@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, airlied@gmail.com, fujita.tomonori@gmail.com,
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] rust: add firmware abstractions
Message-ID: <ZnG1b6XculK88F5S@boqun-archlinux>
References: <20240618154841.6716-1-dakr@redhat.com>
 <20240618154841.6716-3-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618154841.6716-3-dakr@redhat.com>

On Tue, Jun 18, 2024 at 05:48:35PM +0200, Danilo Krummrich wrote:
> Add an abstraction around the kernels firmware API to request firmware
> images. The abstraction provides functions to access the firmware's size
> and backing buffer.
> 
> The firmware is released once the abstraction instance is dropped.
> 
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>

Acked-by: Boqun Feng <boqun.feng@gmail.com>

Thanks!

Regards,
Boqun

> ---
>  drivers/base/firmware_loader/Kconfig |   7 ++
>  rust/bindings/bindings_helper.h      |   1 +
>  rust/kernel/firmware.rs              | 101 +++++++++++++++++++++++++++
>  rust/kernel/lib.rs                   |   2 +
>  4 files changed, 111 insertions(+)
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
> index 000000000000..b55ea1b45368
> --- /dev/null
> +++ b/rust/kernel/firmware.rs
> @@ -0,0 +1,101 @@
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
> +/// Once requested, the `Firmware` backing buffer is not modified until it is freed when `Firmware`
> +/// is dropped.
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

