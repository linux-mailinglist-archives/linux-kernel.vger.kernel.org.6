Return-Path: <linux-kernel+bounces-325557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E496975B48
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02720B20F9A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E01A1BAEFA;
	Wed, 11 Sep 2024 20:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dug/kMRV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543091BA263;
	Wed, 11 Sep 2024 20:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726085026; cv=none; b=DPYgjy8zl+FPQgFt1qY6T1yk7qjvJfD6nC7S9geX1BVoyTGzuiKxix5ou1BJ1w18TgKlJ+z92moRZG29Hf5CWQwu+wJarn0sXUPIm8SS3EjFZG25c9wdSJE8g1uGTLIVlpaEX23IAJEdTe4v5XdfSnSz+g+zz9K8xPfBtuKNoUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726085026; c=relaxed/simple;
	bh=pwfE9Yhhr5wscRu4DjbCZQgmCxbQ3kOu7Rz3CrHCXJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lr3nFs2q8zE4+OYhQnB7B5A92rR7K/OguPuvfZ1ZiNeKLbhT221PvnYoN13HVSrXDeIpIZ1jT7OzHwraLl9Q5qDxGu0gay75y3t2/+Ln+VJ2qw+Ltp0kWgs8S+LmgFikYpQpfA4uBY/PcG17rnOfR35BHaPEiO+3QdITUmYYrmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dug/kMRV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B0FC4CEC0;
	Wed, 11 Sep 2024 20:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726085025;
	bh=pwfE9Yhhr5wscRu4DjbCZQgmCxbQ3kOu7Rz3CrHCXJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dug/kMRV4N3W/8nFF7vy1QFM5s62m0Pb3L2NWkxEXPoHHSLwmj+D8F6LWNIT6C5Qe
	 jR3/lAQGymADOt9q/ZG63IMansCtxtxat3Zkp+oaF+8sCRMd/rXRdbGl9On3elhOIA
	 B0/pf5pUh6T0L356kRmJgu5LhLsGqaS73aW6nSyw=
Date: Wed, 11 Sep 2024 22:03:42 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ayush Singh <ayushdevel1325@gmail.com>
Cc: Ayush Singh <ayush@beagleboard.org>, fabien.parent@linaro.org,
	d-gole@ti.com, lorforlinux@beagleboard.org,
	jkridner@beagleboard.org, robertcnelson@beagleboard.org,
	Andrew Davis <afd@ti.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/8] mikrobus: Add mikrobus driver
Message-ID: <2024091151-hummus-usher-2561@gregkh>
References: <20240911-mikrobus-dt-v1-0-3ded4dc879e7@beagleboard.org>
 <20240911-mikrobus-dt-v1-3-3ded4dc879e7@beagleboard.org>
 <2024091144-glitzy-kindly-fa74@gregkh>
 <ecd1fff8-9c15-496a-982f-36e6c58e906a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecd1fff8-9c15-496a-982f-36e6c58e906a@gmail.com>

On Wed, Sep 11, 2024 at 09:32:21PM +0530, Ayush Singh wrote:
> On 9/11/24 20:27, Greg Kroah-Hartman wrote:
> 
> > On Wed, Sep 11, 2024 at 07:57:20PM +0530, Ayush Singh wrote:
> > > A simple platform driver for now that does nothing. This is required
> > > because without a platform driver, the mikrobus_gpio0 nexus node cannot
> > > be used.
> > > 
> > > In future, this driver will also allow for dynamic board detection using
> > > 1-wire eeprom in new mikrobus boards.
> > > 
> > > Signed-off-by: Ayush Singh <ayush@beagleboard.org>
> > > ---
> > >   MAINTAINERS              |  1 +
> > >   drivers/misc/Kconfig     | 17 +++++++++++++++++
> > >   drivers/misc/Makefile    |  1 +
> > >   drivers/misc/mikrobus.rs | 32 ++++++++++++++++++++++++++++++++
> > >   4 files changed, 51 insertions(+)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 0cc27446b18a..d0c18bd7b558 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -15433,6 +15433,7 @@ MIKROBUS CONNECTOR
> > >   M:	Ayush Singh <ayush@beagleboard.org>
> > >   S:	Maintained
> > >   F:	Documentation/devicetree/bindings/connector/mikrobus-connector.yaml
> > > +F:	drivers/misc/mikrobus.rs
> > >   MIKROTIK CRS3XX 98DX3236 BOARD SUPPORT
> > >   M:	Luka Kovacic <luka.kovacic@sartura.hr>
> > > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > > index 3fe7e2a9bd29..30defb522e98 100644
> > > --- a/drivers/misc/Kconfig
> > > +++ b/drivers/misc/Kconfig
> > > @@ -610,6 +610,23 @@ config MARVELL_CN10K_DPI
> > >   	  To compile this driver as a module, choose M here: the module
> > >   	  will be called mrvl_cn10k_dpi.
> > > +menuconfig MIKROBUS
> > > +	tristate "Module for instantiating devices on mikroBUS ports"
> > > +	help
> > > +	  This option enables the mikroBUS driver. mikroBUS is an add-on
> > > +	  board socket standard that offers maximum expandability with
> > > +	  the smallest number of pins. The mikroBUS driver instantiates
> > > +	  devices on a mikroBUS port described by identifying data present
> > > +	  in an add-on board resident EEPROM, more details on the mikroBUS
> > > +	  driver support and discussion can be found in this eLinux wiki :
> > > +	  elinux.org/Mikrobus
> > So you want to be a bus?  Or just a single driver?  I'm confused, what
> > exactly is this supposed to do?
> > 
> > If a bus, great, let's tie into the proper driver core bus code, don't
> > "open code" all of that, as that's just going to make things messier and
> > harder to work overall in the end.
> > 
> > If a single driver, why is it called "bus"?  :)
> > 
> > thanks,
> > 
> > greg k-h
> 
> 
> Well, mikroBUS [0] is the name of the socket standard. It is basically a
> group of following pins:
> 
> Analog - AN
> Reset - RST
> SPI Chip Select - CS
> SPI Clock - SCK
> SPI Master Input Slave Output - MISO
> SPI Master Output Slave Input - MOSI
> VCC-3.3V power - +3.3V
> Reference Ground - GND
> PWM - PWM output
> INT - Hardware Interrupt
> RX - UART Receive
> TX - UART Transmit
> SCL - I2C Clock
> SDA - I2C Data
> +5V - VCC-5V power
> GND - Reference Ground
> 
> 
> I do not think it would qualify as as a "bus" in the Linux driver sense.
> Especially with the devicetree based approach here which applies overlay
> directly to the actual uart/i2c/spi controllers and basically not interact
> with the mikroBUS node much.

It will be a "bus" in the driver sense as you want to have different
drivers bound to devices that are plugged in here, right?  Or if this is
just a single driver for the hardware, then no, as you will not have any
additional drivers for this standard?  It's unclear you want to do here.

> The driver is here to enable the following:
> 
> 1. Enable dynamic board detection using 1-wire eeprom on some addon boards.

Some, not all?

> 2. Provide sysfs entry for runtime board adding/removal

That's not what sysfs is for, but we can get there eventually...

> 3. Enable using mikrobus connector node as nexus node for GPIO (not having a
> platform driver makes any driver trying to use the connector as nexus node
> go into deffered probing state).

Why is this a platform device?  Is this always going to be described by
DT somehow?

> For this patch series, the driver is mostly here due to point 3. Basically a
> stub.

Let's see how this really works before coming to conclusions.

As an example, how do you think sysfs should look for this device?  For
all devices?  Write out the needed sysfs documentation entries first and
then that will help explain things better.

thanks,

greg k-h

