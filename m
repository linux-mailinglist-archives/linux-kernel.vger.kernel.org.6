Return-Path: <linux-kernel+bounces-431961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E33C9E4334
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E26D289896
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7511A1A8F76;
	Wed,  4 Dec 2024 18:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cmP5Kfgb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EF823918A;
	Wed,  4 Dec 2024 18:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733336420; cv=none; b=D71g9vy4tQtCg7OsSup9+W4qdfPwsjFfg1Ed8CyhD6tNSoUHaWgdMTwiqDYKqMy2FsZ66JGNidFEMD3rXwfG49N7bUB9EPmTKh1cgYQaZO+V3SZKWYz+s1qQlaBGJZs5GOyskC+aSyhZWpgL+z858hUD35c5eQvfkyP0vWSYaww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733336420; c=relaxed/simple;
	bh=P6438KKT51v9p7iETfDItH/SOoYl6NbvcyH0fhw70/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGB/jfdLyAsBBSILMhWFtiDShPNCKCLP3SO58WUTjUQF0UTWfH+51v9vMDEjhKhAzuzjJlMA+nfxsISmx2uB4EXeS+B7Dgdip/yzvcnQ2U9iE1bqsK+/WVQyjx1xOMCI7INIozznkGgBFYsj0YFNnTYMS8Mot3NyY8CEc/vZ5Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cmP5Kfgb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2341C4CECD;
	Wed,  4 Dec 2024 18:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733336420;
	bh=P6438KKT51v9p7iETfDItH/SOoYl6NbvcyH0fhw70/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cmP5KfgbEb6VpSfNRabdiD/QKQ4S+KYEB3s4WBa2hMfyxxXhxiAhHVgRQxl7Df6vg
	 qZW93eojkjsCf+5aq9I9fgg7xgAurrTRk8Y539reUrNdi6fV4gOJXyCAez3vL+Oy3o
	 UbCCkKiH6cTCSR38p/Hktm/7176/edlQqljkyaeo=
Date: Wed, 4 Dec 2024 19:20:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] samples: rust: Provide example using the new Rust
 MiscDevice abstraction
Message-ID: <2024120427-scurvy-fidgety-06fc@gregkh>
References: <20241204174627.1151288-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204174627.1151288-1-lee@kernel.org>

On Wed, Dec 04, 2024 at 05:46:24PM +0000, Lee Jones wrote:
> This sample driver demonstrates the following basic operations:
> 
> * Register a Misc Device
> * Create /dev/rust-misc-device
> * Open the aforementioned character device
> * Operate on the character device via a simple ioctl()
> * Close the character device
> 
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  samples/rust/Kconfig             | 10 ++++
>  samples/rust/Makefile            |  1 +
>  samples/rust/rust_misc_device.rs | 84 ++++++++++++++++++++++++++++++++
>  3 files changed, 95 insertions(+)
>  create mode 100644 samples/rust/rust_misc_device.rs
> 
> diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
> index b0f74a81c8f9..df384e679901 100644
> --- a/samples/rust/Kconfig
> +++ b/samples/rust/Kconfig
> @@ -20,6 +20,16 @@ config SAMPLE_RUST_MINIMAL
>  
>  	  If unsure, say N.
>  
> +config SAMPLE_RUST_MISC_DEVICE
> +	tristate "Misc device"
> +	help
> +	  This option builds the Rust misc device.
> +
> +	  To compile this as a module, choose M here:
> +	  the module will be called rust_misc_device.
> +
> +	  If unsure, say N.
> +
>  config SAMPLE_RUST_PRINT
>  	tristate "Printing macros"
>  	help
> diff --git a/samples/rust/Makefile b/samples/rust/Makefile
> index c1a5c1655395..ad4b97a98580 100644
> --- a/samples/rust/Makefile
> +++ b/samples/rust/Makefile
> @@ -2,6 +2,7 @@
>  ccflags-y += -I$(src)				# needed for trace events
>  
>  obj-$(CONFIG_SAMPLE_RUST_MINIMAL)		+= rust_minimal.o
> +obj-$(CONFIG_SAMPLE_RUST_MISC_DEVICE)		+= rust_misc_device.o
>  obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
>  
>  rust_print-y := rust_print_main.o rust_print_events.o
> diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
> new file mode 100644
> index 000000000000..5f1b69569ef7
> --- /dev/null
> +++ b/samples/rust/rust_misc_device.rs
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: GPL-2.0

Nit, you forgot a copyright line here :)

> +
> +//! Rust misc device sample.
> +
> +use kernel::{
> +    c_str,
> +    ioctl::_IO,
> +    miscdevice::{MiscDevice, MiscDeviceOptions, MiscDeviceRegistration},
> +    prelude::*,
> +};
> +
> +const RUST_MISC_DEV_HELLO: u32 = _IO('R' as u32, 9);
> +
> +module! {
> +    type: RustMiscDeviceModule,
> +    name: "rust_misc_device",
> +    author: "Lee Jones",
> +    description: "Rust misc device sample",
> +    license: "GPL",
> +}
> +
> +struct RustMiscDeviceModule {
> +    _miscdev: Pin<KBox<MiscDeviceRegistration<RustMiscDevice>>>,
> +}
> +
> +impl kernel::Module for RustMiscDeviceModule {
> +    fn init(_module: &'static ThisModule) -> Result<Self> {
> +        pr_info!("Initialising Rust Misc Device Sample\n");
> +
> +        let options = MiscDeviceOptions {
> +            name: c_str!("rust-misc-device"),
> +        };
> +
> +        Ok(Self {
> +            _miscdev: KBox::pin_init(
> +                MiscDeviceRegistration::<RustMiscDevice>::register(options),
> +                GFP_KERNEL,
> +            )?,
> +        })
> +    }
> +}
> +
> +struct RustMiscDevice;
> +
> +impl RustMiscDevice {
> +    fn new() -> Self {
> +        Self
> +    }
> +}
> +
> +#[vtable]
> +impl MiscDevice for RustMiscDevice {
> +    type Ptr = KBox<Self>;
> +
> +    fn open() -> Result<KBox<Self>> {
> +        pr_info!("Opening Rust Misc Device Sample\n");
> +
> +        Ok(KBox::new(RustMiscDevice::new(), GFP_KERNEL)?)
> +    }
> +
> +    fn ioctl(
> +        _device: <Self::Ptr as kernel::types::ForeignOwnable>::Borrowed<'_>,
> +        cmd: u32,
> +        _arg: usize,
> +    ) -> Result<isize> {
> +        pr_info!("IOCTLing Rust Misc Device Sample\n");
> +
> +        match cmd {
> +            RUST_MISC_DEV_HELLO => pr_info!("Hello from the Rust Misc Device\n"),
> +            _ => {
> +                pr_err!("IOCTL not recognised: {}\n", cmd);
> +                return Err(EINVAL);
> +            }
> +        }
> +
> +        Ok(0)
> +    }
> +}
> +
> +impl Drop for RustMiscDevice {
> +    fn drop(&mut self) {
> +        pr_info!("Exiting the Rust Misc Device Sample\n");
> +    }

Cool!  But no read/write functionality?  :)

Anyway, other than the copyright, this looks good to me.

Although we should get the "validate the data" rust patch set in here
soon, so we don't have to go and fix up all users of the miscdev rust
api at once.  Maybe I'll dig that series up over the holiday break if
someone doesn't beat me to it.

thanks,

greg k-h

