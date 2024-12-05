Return-Path: <linux-kernel+bounces-432917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A799E51DA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0C86167EBD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E679214A88;
	Thu,  5 Dec 2024 10:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvVBnBCp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA26C214A7D;
	Thu,  5 Dec 2024 10:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733393003; cv=none; b=ApwxfBD95tf9naRY+YVHSlaNY1dNRXNlbt9Wpbw/0FOUcHTHZ6j0SnuoDnrN/yGh7CZNV8364e1Ie9/XP90SPRil1AZlZh1SDG30ZcPLIprSb6jcNY4fPQ3G8UgN+eD1SbDHHksH6Gz12MOXR64QhjksmMCP41/CD0h0G1sePdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733393003; c=relaxed/simple;
	bh=Xe6VNiv2jn4NXgxPnO4tW3pO+iMwQ+p05ds3Fx7wYeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1upXJZgeBZy35rRPDRVn6skXDHwqDC3wMbW61H9r9Mkz3TIO3EPNPsFxK6xpmm86HYtfeTPZIRfUrWKcj0+K/pgVtC/mKvUae12MIGjWKCzqt6t0eOdcVwtf15omuL5xq4WhChWtYL+TwsjIrX+o3ZF8luNheH8yqI6/Jrzm/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvVBnBCp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0753EC4CED1;
	Thu,  5 Dec 2024 10:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733393002;
	bh=Xe6VNiv2jn4NXgxPnO4tW3pO+iMwQ+p05ds3Fx7wYeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pvVBnBCpwl7rUf/+f2h1UG2sOTftKOx3/cyoGo7CfhARQzJs23GeHd/qNlVunpJ8P
	 9HJq8elmHlWrHlcU2ka28bf2uKg0RuC4/PhrUN5UqpPfXG2OukXVzYM896eQJ31E2D
	 UtOlDsW83aAzxM/Q+xpJ9xDfObY6Iduq9T3+0YfQSyZkd+rj32JAv/YM/ge8Nglcie
	 zbeZOCSTEQQ/PjmgEBtIwW/kkJBN9i5w/TdoePUILptoUx2OwzhFspVzBitgeJ1K3f
	 4Ifg3ldO9ucN+sGouY6zYLst/0Y4gaF97AfuoeV/Z2AMJWnpJvhi9rpbDLbByAdYBq
	 fhrPsQw1/6yPA==
Date: Thu, 5 Dec 2024 10:03:17 +0000
From: Lee Jones <lee@kernel.org>
To: =?iso-8859-1?Q?Beno=EEt?= du Garreau <benoit@dugarreau.fr>
Cc: linux-kernel@vger.kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, rust-for-linux@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 1/2] samples: rust: Provide example using the new Rust
 MiscDevice abstraction
Message-ID: <20241205100317.GI7451@google.com>
References: <20241204174627.1151288-1-lee@kernel.org>
 <20241205092135.48978-1-benoit@dugarreau.fr>
 <20241205094610.GH7451@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241205094610.GH7451@google.com>

On Thu, 05 Dec 2024, Lee Jones wrote:

> On Thu, 05 Dec 2024, Benoît du Garreau wrote:
> 
> > On Wed, 4 Dec 2024 17:46:24 +0000 Lee Jones <lee@kernel.org> wrote:
> > 
> > > This sample driver demonstrates the following basic operations:
> > >
> > > * Register a Misc Device
> > > * Create /dev/rust-misc-device
> > > * Open the aforementioned character device
> > > * Operate on the character device via a simple ioctl()
> > > * Close the character device
> > >
> > > Signed-off-by: Lee Jones <lee@kernel.org>
> > > ---
> > >  samples/rust/Kconfig             | 10 ++++
> > >  samples/rust/Makefile            |  1 +
> > >  samples/rust/rust_misc_device.rs | 84 ++++++++++++++++++++++++++++++++
> > >  3 files changed, 95 insertions(+)
> > >  create mode 100644 samples/rust/rust_misc_device.rs
> > >
> > > diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
> > > index b0f74a81c8f9..df384e679901 100644
> > > --- a/samples/rust/Kconfig
> > > +++ b/samples/rust/Kconfig
> > > @@ -20,6 +20,16 @@ config SAMPLE_RUST_MINIMAL
> > >
> > >  	  If unsure, say N.
> > >
> > > +config SAMPLE_RUST_MISC_DEVICE
> > > +	tristate "Misc device"
> > > +	help
> > > +	  This option builds the Rust misc device.
> > > +
> > > +	  To compile this as a module, choose M here:
> > > +	  the module will be called rust_misc_device.
> > > +
> > > +	  If unsure, say N.
> > > +
> > >  config SAMPLE_RUST_PRINT
> > >  	tristate "Printing macros"
> > >  	help
> > > diff --git a/samples/rust/Makefile b/samples/rust/Makefile
> > > index c1a5c1655395..ad4b97a98580 100644
> > > --- a/samples/rust/Makefile
> > > +++ b/samples/rust/Makefile
> > > @@ -2,6 +2,7 @@
> > >  ccflags-y += -I$(src)				# needed for trace events
> > >
> > >  obj-$(CONFIG_SAMPLE_RUST_MINIMAL)		+= rust_minimal.o
> > > +obj-$(CONFIG_SAMPLE_RUST_MISC_DEVICE)		+= rust_misc_device.o
> > >  obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
> > >
> > >  rust_print-y := rust_print_main.o rust_print_events.o
> > > diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
> > > new file mode 100644
> > > index 000000000000..5f1b69569ef7
> > > --- /dev/null
> > > +++ b/samples/rust/rust_misc_device.rs
> > > @@ -0,0 +1,84 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +//! Rust misc device sample.
> > > +
> > > +use kernel::{
> > > +    c_str,
> > > +    ioctl::_IO,
> > > +    miscdevice::{MiscDevice, MiscDeviceOptions, MiscDeviceRegistration},
> > > +    prelude::*,
> > > +};
> > > +
> > > +const RUST_MISC_DEV_HELLO: u32 = _IO('R' as u32, 9);
> > > +
> > > +module! {
> > > +    type: RustMiscDeviceModule,
> > > +    name: "rust_misc_device",
> > > +    author: "Lee Jones",
> > > +    description: "Rust misc device sample",
> > > +    license: "GPL",
> > > +}
> > > +
> > > +struct RustMiscDeviceModule {
> > > +    _miscdev: Pin<KBox<MiscDeviceRegistration<RustMiscDevice>>>,
> > > +}
> > > +
> > > +impl kernel::Module for RustMiscDeviceModule {
> > 
> > This could probably use `kernel::InPlaceModule` and avoid allocating
> > the registration.
> 
> Is there a way to do this and keep the print?

Seeing as this is the concept/API demonstrator, I think what I'd sooner
do, is demonstrate some actual initialisation.  Maybe with a head-nod to
`kernel::InPlaceModule` in a comment.

-- 
Lee Jones [李琼斯]

