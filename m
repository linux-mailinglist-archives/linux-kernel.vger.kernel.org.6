Return-Path: <linux-kernel+bounces-434484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC119E6767
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCBE7169B88
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 06:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FED01DACBB;
	Fri,  6 Dec 2024 06:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FWcNcMU9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683E4195FCE;
	Fri,  6 Dec 2024 06:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733467448; cv=none; b=CiSD/Rn+XgbL8pBHPyWyAIcQmXfBRvf1CtXSr4lOtwnqWw79Zrje3uLUYf6KUbt0OZ2nQgnl9MS1W69DfCgZCIcqJzBE4CvGQ1zZZU3XGI23yFCbN+b+gEM9NJFEJgoqVnJEE8CUJpGLyvqLfGNz0d2agwFxS7TavzrWJlO4dgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733467448; c=relaxed/simple;
	bh=sSz9S/5AX0m6LvmBvtCI2GjifNjxQcoiyYCwaejusVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYhnZKzkgGgUILFLNEMMqg+IiHB6NOXDdoCtu0vEyIcuYKL1Z2ZjoX//nomklnc05KlpMZrCmwY+vFo8DIVjZncs/j3Lb/0cwFZsn0oDKlEKZSHm0UTMiEgJr2xjZ67aJqFnHZ6a642XNMrtyBDIhBpV0LRzJ6+A9zOZTzl9gOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FWcNcMU9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 950D8C4CED1;
	Fri,  6 Dec 2024 06:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733467448;
	bh=sSz9S/5AX0m6LvmBvtCI2GjifNjxQcoiyYCwaejusVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FWcNcMU9ra6X1FWdkKPMkXVOesanvusT82RQ0p7qIK2F8AzPKdWDSXFiTKOK3j0VG
	 RDdJHTMZLVCKkEFjrvjV+OawMjEoVJo41vikyfBujBZww9Lzi2BjBOK19DypQ1uE/B
	 0JBtcp+dLwvoXPYpUZnpQky5wwVAFmaQmfY2ulAk=
Date: Fri, 6 Dec 2024 07:44:05 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 3/5] samples: rust: Provide example using the new Rust
 MiscDevice abstraction
Message-ID: <2024120604-diffusive-reach-6c99@gregkh>
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

Nit, the driver doesn't demonstrate open/close, it "provides" open/close
functionality if someone wants to use it :)

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

I'd prefer this to be dev_info() to start with please.

thanks,

greg k-h

