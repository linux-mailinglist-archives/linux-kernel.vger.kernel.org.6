Return-Path: <linux-kernel+bounces-432765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 415A29E4FFC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAFBE2859BC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D82B1D45FB;
	Thu,  5 Dec 2024 08:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCP68KFo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2341D358F;
	Thu,  5 Dec 2024 08:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733388066; cv=none; b=q+0VL1IBiE+zKAUZZnZGKHN3rt7wO02e4M3OfS7Y1g4G4ZEIyt1uekRcLmAXGhgD76EZ5Ty/ebf2GvJV8NdDRtjdbpH9s9L13wz+uiZOS603QYyeZycYE0/wbpuWyTe88ZFQffIrNU/TxtTTOKnYBBc/6CRo3gg1GJES0gZLHqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733388066; c=relaxed/simple;
	bh=WYpbDWRtvOOHP+CzCeri9xxwbKUUtMqW3Q/EKdGc6xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlNGkh3RyeFb8zkvnKFNjPTLrd+IjxdP4A0fxUHo2IOI8Wb9p+7fwKUybZdOUCgPpZcMm0WC/5VxtH0+uGDTQzZJ46hLAySk33r+RG0kHpKF1yo5m64m86MDA5pVgPdQ1jeVCE8Peu7gYXUAQhd9RvHNp/Tb8IaLPrTnMBGRQ5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCP68KFo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7ECC4CED1;
	Thu,  5 Dec 2024 08:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733388066;
	bh=WYpbDWRtvOOHP+CzCeri9xxwbKUUtMqW3Q/EKdGc6xc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NCP68KFoAZzpghFtITq6Gd8lUmfrY+TdR5YugXOjvNXMPhjEwStMTHeFM3hrSovLf
	 y4bWNc3L4Il3BbBH0SLLgQ4gL4uvQDajfYCNdRPAxl4BoaScWSVmtaxm6XTmDB5GZk
	 /8hgtsixQEoWknOYMrF4/8WGYXf36fzVfeVgrwyZTCc7wDLjkoLu39CcELNH5FpBnw
	 uyuqWFBVtT5etU8UlB4F4+Cg5rGP2EqoNsY1ciNcxiSUZTzBbR5TzQtPeYZykTd2sV
	 V4FFQxE+duk+gpo17bJ0oXO+7MpzsffLApceWDRpMWLTNnIBBkN2Wv/ve8+XcMLQre
	 euQHiMMlx1nrw==
Date: Thu, 5 Dec 2024 08:41:01 +0000
From: Lee Jones <lee@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] samples: rust: Provide example using the new Rust
 MiscDevice abstraction
Message-ID: <20241205084101.GE7451@google.com>
References: <20241204174627.1151288-1-lee@kernel.org>
 <2024120427-scurvy-fidgety-06fc@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024120427-scurvy-fidgety-06fc@gregkh>

On Wed, 04 Dec 2024, Greg KH wrote:

> On Wed, Dec 04, 2024 at 05:46:24PM +0000, Lee Jones wrote:
> > This sample driver demonstrates the following basic operations:
> > 
> > * Register a Misc Device
> > * Create /dev/rust-misc-device
> > * Open the aforementioned character device
> > * Operate on the character device via a simple ioctl()
> > * Close the character device
> > 
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > ---
> >  samples/rust/Kconfig             | 10 ++++
> >  samples/rust/Makefile            |  1 +
> >  samples/rust/rust_misc_device.rs | 84 ++++++++++++++++++++++++++++++++
> >  3 files changed, 95 insertions(+)
> >  create mode 100644 samples/rust/rust_misc_device.rs
> > 
> > diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
> > index b0f74a81c8f9..df384e679901 100644
> > --- a/samples/rust/Kconfig
> > +++ b/samples/rust/Kconfig
> > @@ -20,6 +20,16 @@ config SAMPLE_RUST_MINIMAL
> >  
> >  	  If unsure, say N.
> >  
> > +config SAMPLE_RUST_MISC_DEVICE
> > +	tristate "Misc device"
> > +	help
> > +	  This option builds the Rust misc device.
> > +
> > +	  To compile this as a module, choose M here:
> > +	  the module will be called rust_misc_device.
> > +
> > +	  If unsure, say N.
> > +
> >  config SAMPLE_RUST_PRINT
> >  	tristate "Printing macros"
> >  	help
> > diff --git a/samples/rust/Makefile b/samples/rust/Makefile
> > index c1a5c1655395..ad4b97a98580 100644
> > --- a/samples/rust/Makefile
> > +++ b/samples/rust/Makefile
> > @@ -2,6 +2,7 @@
> >  ccflags-y += -I$(src)				# needed for trace events
> >  
> >  obj-$(CONFIG_SAMPLE_RUST_MINIMAL)		+= rust_minimal.o
> > +obj-$(CONFIG_SAMPLE_RUST_MISC_DEVICE)		+= rust_misc_device.o
> >  obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
> >  
> >  rust_print-y := rust_print_main.o rust_print_events.o
> > diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
> > new file mode 100644
> > index 000000000000..5f1b69569ef7
> > --- /dev/null
> > +++ b/samples/rust/rust_misc_device.rs
> > @@ -0,0 +1,84 @@
> > +// SPDX-License-Identifier: GPL-2.0
> 
> Nit, you forgot a copyright line here :)

I can add one, but none of the other drivers in this directory has one.

>> > +
> > +//! Rust misc device sample.
> > +
> > +use kernel::{
> > +    c_str,
> > +    ioctl::_IO,
> > +    miscdevice::{MiscDevice, MiscDeviceOptions, MiscDeviceRegistration},
> > +    prelude::*,
> > +};
> > +
> > +const RUST_MISC_DEV_HELLO: u32 = _IO('R' as u32, 9);
> > +
> > +module! {
> > +    type: RustMiscDeviceModule,
> > +    name: "rust_misc_device",
> > +    author: "Lee Jones",
> > +    description: "Rust misc device sample",
> > +    license: "GPL",
> > +}
> > +
> > +struct RustMiscDeviceModule {
> > +    _miscdev: Pin<KBox<MiscDeviceRegistration<RustMiscDevice>>>,
> > +}
> > +
> > +impl kernel::Module for RustMiscDeviceModule {
> > +    fn init(_module: &'static ThisModule) -> Result<Self> {
> > +        pr_info!("Initialising Rust Misc Device Sample\n");
> > +
> > +        let options = MiscDeviceOptions {
> > +            name: c_str!("rust-misc-device"),
> > +        };
> > +
> > +        Ok(Self {
> > +            _miscdev: KBox::pin_init(
> > +                MiscDeviceRegistration::<RustMiscDevice>::register(options),
> > +                GFP_KERNEL,
> > +            )?,
> > +        })
> > +    }
> > +}
> > +
> > +struct RustMiscDevice;
> > +
> > +impl RustMiscDevice {
> > +    fn new() -> Self {
> > +        Self
> > +    }
> > +}
> > +
> > +#[vtable]
> > +impl MiscDevice for RustMiscDevice {
> > +    type Ptr = KBox<Self>;
> > +
> > +    fn open() -> Result<KBox<Self>> {
> > +        pr_info!("Opening Rust Misc Device Sample\n");
> > +
> > +        Ok(KBox::new(RustMiscDevice::new(), GFP_KERNEL)?)
> > +    }
> > +
> > +    fn ioctl(
> > +        _device: <Self::Ptr as kernel::types::ForeignOwnable>::Borrowed<'_>,
> > +        cmd: u32,
> > +        _arg: usize,
> > +    ) -> Result<isize> {
> > +        pr_info!("IOCTLing Rust Misc Device Sample\n");
> > +
> > +        match cmd {
> > +            RUST_MISC_DEV_HELLO => pr_info!("Hello from the Rust Misc Device\n"),
> > +            _ => {
> > +                pr_err!("IOCTL not recognised: {}\n", cmd);
> > +                return Err(EINVAL);
> > +            }
> > +        }
> > +
> > +        Ok(0)
> > +    }
> > +}
> > +
> > +impl Drop for RustMiscDevice {
> > +    fn drop(&mut self) {
> > +        pr_info!("Exiting the Rust Misc Device Sample\n");
> > +    }
> 
> Cool!  But no read/write functionality?  :)

Happy to add it subsequently.

> Anyway, other than the copyright, this looks good to me.
> 
> Although we should get the "validate the data" rust patch set in here
> soon, so we don't have to go and fix up all users of the miscdev rust
> api at once.  Maybe I'll dig that series up over the holiday break if
> someone doesn't beat me to it.

What needs doing?  Do you have a link?

-- 
Lee Jones [李琼斯]

