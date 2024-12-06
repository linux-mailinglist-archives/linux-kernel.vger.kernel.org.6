Return-Path: <linux-kernel+bounces-434489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7519E6770
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1B216A7D7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 06:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135071DA619;
	Fri,  6 Dec 2024 06:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yLLLcGmK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E5728684;
	Fri,  6 Dec 2024 06:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733467764; cv=none; b=NIrL/zVnGx+etlT4U5F5TVw6mBrj+G3x9EANjJl94gn2+6OLeGHgrb9WQGQNAcnqT2vraZhTg9yEpB20ogbIK6U2vCVHDpb0pC6BzG0PDmPZ9gFlYZzgYCk0JUjt60canJbjhkuLVUqVkhwC7sV0Twozugnayh7j7YCx6XMbKek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733467764; c=relaxed/simple;
	bh=tJ3wMUFBqlh1riFBZDToE1Db2FSIVqyfpQmviXvNarE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AC30SyXpcVOvi0hjN28hHbZP46mBTiQBGCpaSj5/rZ5no/RwwQ5xJ+4K/01q/QYK0NvECna7w9RKZtSgg7/clVHLokcWnMOZcgLGClZc4nsP5dPd0ssYc49gnJUI5GMkyj9lDLHa6/B0jeLTkw2cCsypxvNZ/Y9IYLhGE6iQ0fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yLLLcGmK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE77C4CED1;
	Fri,  6 Dec 2024 06:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733467763;
	bh=tJ3wMUFBqlh1riFBZDToE1Db2FSIVqyfpQmviXvNarE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yLLLcGmK1w9SOnaR3Vvo166Zne3XJXaBSGqeqHys7T0L8E3f+iwKGxT8IifqoXn3u
	 H2nPt/HsVYTV8OHLFRFqvfe6zTEa+oHkYocstb7Ffs1ITYoreUORCaw1iQ4Xcwdkja
	 ijiIcVReXK5K3vQraWqegbKL2IIyUqwbQ/agV/30=
Date: Fri, 6 Dec 2024 07:49:20 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 3/5] samples: rust: Provide example using the new Rust
 MiscDevice abstraction
Message-ID: <2024120642-trend-omnivore-69d3@gregkh>
References: <20241205162531.1883859-1-lee@kernel.org>
 <20241205162531.1883859-4-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205162531.1883859-4-lee@kernel.org>

On Thu, Dec 05, 2024 at 04:25:20PM +0000, Lee Jones wrote:
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
>  samples/rust/rust_misc_device.rs | 80 ++++++++++++++++++++++++++++++++
>  3 files changed, 91 insertions(+)
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
> index 000000000000..f50925713f1a
> --- /dev/null
> +++ b/samples/rust/rust_misc_device.rs
> @@ -0,0 +1,80 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2024 Google LLC.
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
> +#[vtable]
> +impl MiscDevice for RustMiscDevice {
> +    type Ptr = KBox<Self>;
> +
> +    fn open() -> Result<KBox<Self>> {
> +        pr_info!("Opening Rust Misc Device Sample\n");
> +
> +        Ok(KBox::new(RustMiscDevice, GFP_KERNEL)?)
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
> +                return Err(ENOIOCTLCMD);

To quote errno.h:
	These should never be seen by user programs

The correct value here is ENOTTY.

Yeah, fun stuff.  Not intuitive at all, sorry.

thanks,

greg k-h

