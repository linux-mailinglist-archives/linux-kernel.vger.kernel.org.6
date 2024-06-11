Return-Path: <linux-kernel+bounces-209327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A809032AA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 08:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C79BE1C23483
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 06:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64E5171E4A;
	Tue, 11 Jun 2024 06:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0JPPfuGX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F5A13F43E;
	Tue, 11 Jun 2024 06:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718087510; cv=none; b=anKaPje5ltc9Afwpp08kMI4mh7rC55nvugidmJxXqreNpgXUMQ9Y/YxzBthpMgP6/x6MF3PNSFV3XDW/orH++5Ws8DsCwS1U8f+6ZAhz+qMsVrzid5SMgrCNJXlfLsndZZ5cqKhcj+lSJT40KW8zopOgGkPnzO+3qRjAL2Qsut0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718087510; c=relaxed/simple;
	bh=2ZPT3S+8HRYZ+/M0fqX0hFmUPpAO06wEJb3duJQkoAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PclHaKvNWwoYsdycEaaPUxteTty+JiaYoj7G7sVYL2Y1RnmbeOK21mkUV/wllPqGau1vvgbJR4B4WEoVJ3GvtgvNHvSs1y6L2SIxVHqOmIZHVQy7P1EOPU4oMVKquihc5RUOihD5XUiyZHUkxdvsPyObW3RAV5jZRtDsjwlIhEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0JPPfuGX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F72BC2BD10;
	Tue, 11 Jun 2024 06:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718087509;
	bh=2ZPT3S+8HRYZ+/M0fqX0hFmUPpAO06wEJb3duJQkoAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0JPPfuGXCrZ6lXFH3MNQIVzydNYC1Ez7pLYaDlhmGhBeO/gQR1uq6ZpiIXlVW1wLP
	 q9KJ+LIe/vdCP1qGQllOpuwHaFTakhpNIBKfjpoGkbscZ04wjb0Updauu86oFlq54B
	 95DRMaFmFRTTD1b9Il4u9ZK7C1TpnQdnL9brKK1M=
Date: Tue, 11 Jun 2024 08:31:46 +0200
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
Message-ID: <2024061128-provolone-coyness-1d3c@gregkh>
References: <20240610180318.72152-1-dakr@redhat.com>
 <20240610180318.72152-3-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610180318.72152-3-dakr@redhat.com>

On Mon, Jun 10, 2024 at 08:02:28PM +0200, Danilo Krummrich wrote:
> Add an abstraction around the kernels firmware API to request firmware
> images. The abstraction provides functions to access the firmware's size
> and backing buffer.
> 
> The firmware is released once the abstraction instance is dropped.
> 
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> ---
>  rust/bindings/bindings_helper.h |   1 +
>  rust/kernel/firmware.rs         | 107 ++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs              |   1 +
>  3 files changed, 109 insertions(+)
>  create mode 100644 rust/kernel/firmware.rs
> 
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
> index 000000000000..7ff4c325f670
> --- /dev/null
> +++ b/rust/kernel/firmware.rs
> @@ -0,0 +1,107 @@
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
> +/// use kernel::firmware::Firmware;
> +///
> +/// let fw = Firmware::request("path/to/firmware.bin", dev.as_ref())?;
> +/// driver_load_firmware(fw.data());
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

How does this handle when CONFIG_FW_LOADER is not enabled?  Why are you
building these bindings if that option is not checked?

> +
> +    /// Send a request for an optional firmware module. See also
> +    /// `bindings::firmware_request_nowarn`.
> +    pub fn request_nowarn(name: &CStr, dev: &Device) -> Result<Self> {
> +        Self::request_internal(name, dev, bindings::firmware_request_nowarn)
> +    }
> +
> +    /// Send a request for a firmware with platform-fw fallback. See also
> +    /// `bindings::firmware_request_platform`.
> +    pub fn request_platform(name: &CStr, dev: &Device) -> Result<Self> {
> +        Self::request_internal(name, dev, bindings::firmware_request_platform)
> +    }
> +
> +    /// Send a request for a firmware directly without usermode helper. See also
> +    /// `bindings::request_firmware_direct`.
> +    pub fn request_direct(name: &CStr, dev: &Device) -> Result<Self> {
> +        Self::request_internal(name, dev, bindings::request_firmware_direct)
> +    }

Why just these variants?  Why not just add the ones that people actually
need instead of a random assortment like you choose here :)

thanks,

greg k-h

