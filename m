Return-Path: <linux-kernel+bounces-432869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBA69E5142
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B33F8163D6A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53DE1D5ACD;
	Thu,  5 Dec 2024 09:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u/z1eRJe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465651D5149;
	Thu,  5 Dec 2024 09:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733390786; cv=none; b=jcMqRwlvLnziLPAhoTr/lhjrsXL7DZVXlkUvZo/KOJEn9UL1j8ql4OVpoXVgZwTksWVqe802WkUSQ+5djBgBoZyDwq98TMCc04wW9xvEj6J5d2mdO74NFHauSZOG9byPEqUDVqx6Yxsgp1JxLA8BL9hYVhX1cy08lZ24HVacYUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733390786; c=relaxed/simple;
	bh=G0Io6HRP/GtjXQ5mHEb9WOF/mEVuGUzmcwvORugLAyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMMmgea3KSpnF5D+STR8+U17AEHbKfOmxG3el7aym12FdIP244WvfI5IQnp2hrv/AQZT5LCO+2pu338O2vkdyFb6+s84SaALIV0zFV9SMg9huPoIoYZw3JarPGFjKHa7qXYLJOIPZWYDVmYoFyvDIiR61jB5UZStA0zt18Y/gOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u/z1eRJe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 317DFC4CED1;
	Thu,  5 Dec 2024 09:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733390785;
	bh=G0Io6HRP/GtjXQ5mHEb9WOF/mEVuGUzmcwvORugLAyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u/z1eRJeRZN9NvyfzeI4PdzFM2FJ5AZqtsHlC9zlhasvt+gZc5DTWaHgDY7H5yFz6
	 zotSPussZJZnThcs+yr0n/GPHTTPJDWH6KzaIGeNoZxi8QqJTwbD8OlrZLPSpXBNeY
	 uRLFx3eEvk6hhq9uRJSIXEZ/xDF7uWTB4gJ7nIfk=
Date: Thu, 5 Dec 2024 10:26:22 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] samples: rust: Provide example using the new Rust
 MiscDevice abstraction
Message-ID: <2024120543-mutiny-blank-2c9b@gregkh>
References: <20241204174627.1151288-1-lee@kernel.org>
 <2024120427-scurvy-fidgety-06fc@gregkh>
 <20241205084101.GE7451@google.com>
 <2024120543-bauble-semicolon-639d@gregkh>
 <20241205091704.GF7451@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205091704.GF7451@google.com>

On Thu, Dec 05, 2024 at 09:17:04AM +0000, Lee Jones wrote:
> On Thu, 05 Dec 2024, Greg KH wrote:
> 
> > On Thu, Dec 05, 2024 at 08:41:01AM +0000, Lee Jones wrote:
> > > On Wed, 04 Dec 2024, Greg KH wrote:
> > > 
> > > > On Wed, Dec 04, 2024 at 05:46:24PM +0000, Lee Jones wrote:
> > > > > This sample driver demonstrates the following basic operations:
> > > > > 
> > > > > * Register a Misc Device
> > > > > * Create /dev/rust-misc-device
> > > > > * Open the aforementioned character device
> > > > > * Operate on the character device via a simple ioctl()
> > > > > * Close the character device
> > > > > 
> > > > > Signed-off-by: Lee Jones <lee@kernel.org>
> > > > > ---
> > > > >  samples/rust/Kconfig             | 10 ++++
> > > > >  samples/rust/Makefile            |  1 +
> > > > >  samples/rust/rust_misc_device.rs | 84 ++++++++++++++++++++++++++++++++
> > > > >  3 files changed, 95 insertions(+)
> > > > >  create mode 100644 samples/rust/rust_misc_device.rs
> > > > > 
> > > > > diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
> > > > > index b0f74a81c8f9..df384e679901 100644
> > > > > --- a/samples/rust/Kconfig
> > > > > +++ b/samples/rust/Kconfig
> > > > > @@ -20,6 +20,16 @@ config SAMPLE_RUST_MINIMAL
> > > > >  
> > > > >  	  If unsure, say N.
> > > > >  
> > > > > +config SAMPLE_RUST_MISC_DEVICE
> > > > > +	tristate "Misc device"
> > > > > +	help
> > > > > +	  This option builds the Rust misc device.
> > > > > +
> > > > > +	  To compile this as a module, choose M here:
> > > > > +	  the module will be called rust_misc_device.
> > > > > +
> > > > > +	  If unsure, say N.
> > > > > +
> > > > >  config SAMPLE_RUST_PRINT
> > > > >  	tristate "Printing macros"
> > > > >  	help
> > > > > diff --git a/samples/rust/Makefile b/samples/rust/Makefile
> > > > > index c1a5c1655395..ad4b97a98580 100644
> > > > > --- a/samples/rust/Makefile
> > > > > +++ b/samples/rust/Makefile
> > > > > @@ -2,6 +2,7 @@
> > > > >  ccflags-y += -I$(src)				# needed for trace events
> > > > >  
> > > > >  obj-$(CONFIG_SAMPLE_RUST_MINIMAL)		+= rust_minimal.o
> > > > > +obj-$(CONFIG_SAMPLE_RUST_MISC_DEVICE)		+= rust_misc_device.o
> > > > >  obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
> > > > >  
> > > > >  rust_print-y := rust_print_main.o rust_print_events.o
> > > > > diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
> > > > > new file mode 100644
> > > > > index 000000000000..5f1b69569ef7
> > > > > --- /dev/null
> > > > > +++ b/samples/rust/rust_misc_device.rs
> > > > > @@ -0,0 +1,84 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > 
> > > > Nit, you forgot a copyright line here :)
> > > 
> > > I can add one, but none of the other drivers in this directory has one.
> > 
> > I think the copyright owner of this file will appreciate that.  In fact,
> > I think it might be required by them :)
> 
> I think you're right.  Probably just an oversight from the original.
> 
> > > > Anyway, other than the copyright, this looks good to me.
> > > > 
> > > > Although we should get the "validate the data" rust patch set in here
> > > > soon, so we don't have to go and fix up all users of the miscdev rust
> > > > api at once.  Maybe I'll dig that series up over the holiday break if
> > > > someone doesn't beat me to it.
> > > 
> > > What needs doing?  Do you have a link?
> > 
> > https://lore.kernel.org/r/20240925205244.873020-1-benno.lossin@proton.me
> > 
> > But in thinking about it more, this isn't going to work well with misc
> > devices as the data is coming from userspace, which already goes through
> > the user slice code.  Unless userslice should be marking the data as
> > untrusted?  I think that needs to happen as well.
> 
> Not too relevant here I think.  The data coming in is just a single int
> that is used as-is rather than any kind of index into memory.

For now, yes.  But in reality, the data is "untrusted" as userspace
provided it, and for a sample, we should at least document that
otherwise people will forget.

thanks,

greg k-h

