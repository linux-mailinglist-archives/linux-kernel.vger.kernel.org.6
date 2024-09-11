Return-Path: <linux-kernel+bounces-325385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8EC9758F9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 19:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C09C287C82
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C581B2ECC;
	Wed, 11 Sep 2024 17:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPyJXXbR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED761A3044;
	Wed, 11 Sep 2024 17:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726074166; cv=none; b=Ay3cVDPcAI5OWIUt9pJSflDcPh7WjtOACx2HMWimCu+tR18nnUDQ/g+7TyrtmPZQggoSdOQlNv/KUr+dH7dEe4F/iqb/55H6KGWLYix5IerA7t+mAPSNS3BTUNuvc61FT5T5pK/71UTTu5eM5SUGO7VpHx/K/noIgpDCoQNWBhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726074166; c=relaxed/simple;
	bh=mh2Qo493SEzH4afd1y74n9VtxlUeYGRc0YzrmKJqHIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTEy90/PUuf+B8qMal6hUeaE5CTLDqDOyZxkoozEs+HVcfl725xZA5dMoZGYmEmoJanwR0ILnLrya4jJppmKwUYfthUJz9y5S43H3ATjN10zGpVuIewRrIrvlKwAolfAOArbbmTqm+xhBWRIvfEtuXZtHyuOcGimwluyTWNF2Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPyJXXbR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4827C4CEC0;
	Wed, 11 Sep 2024 17:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726074166;
	bh=mh2Qo493SEzH4afd1y74n9VtxlUeYGRc0YzrmKJqHIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rPyJXXbRrYeHY/eUa+OW9d8xMgGC6LG3KpYibaQIDjLasqADBvgTcT8XqdFSWkKKW
	 0kG8u8UcJhS0DZRBAg8/Jh+3PiZR8kJKcHwgYaUdzxvEkqjBLnTleiJ9uP3laB8XyI
	 9oCzXetrlcwZosk1iuDh+DAw44asno71HDHJBB8pl8w0TEAtM8PpyWG8iYgJEIOR5+
	 sOEvnxLYCHHRGwoFCmG2FdVSGw70tqcUxAQncOOvYh+N1S1R6HhxCYwxcUkE/ohVI+
	 +TQCverzlA+nXhNhCvopDTDPdcXidaaweg+lt2xA2emzLz8Py6l75GlHSxgchs/446
	 8QLYF34/546Qg==
Date: Wed, 11 Sep 2024 12:02:45 -0500
From: Rob Herring <robh@kernel.org>
To: Ayush Singh <ayush@beagleboard.org>
Cc: fabien.parent@linaro.org, d-gole@ti.com, lorforlinux@beagleboard.org,
	jkridner@beagleboard.org, robertcnelson@beagleboard.org,
	Andrew Davis <afd@ti.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/8] Add generic overlay for MikroBUS addon boards
Message-ID: <20240911170245.GA915638-robh@kernel.org>
References: <20240911-mikrobus-dt-v1-0-3ded4dc879e7@beagleboard.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911-mikrobus-dt-v1-0-3ded4dc879e7@beagleboard.org>

On Wed, Sep 11, 2024 at 07:57:17PM +0530, Ayush Singh wrote:
> Hello all,
> 
> This is an attempt to add MikroBUS addon support using the approach
> described by Grove connector patch series [0].
> 
> The patch series tests out 2 addon boards + pwm and GPIO on the MikroBUS
> connector. The boards used are GPS3 Click (for UART) [1] and Weather
> Click (for I2C) [2]. Additionally, I have tested relative GPIO numbering
> using devicetree nexus nodes [3].
> 
> The patch series does not attempt to do any dynamic discovery for 1-wire
> eeprom MikroBUS addon boards, nor does it provide any sysfs entry for
> board addition/removal. The connector driver might include them after
> the basic support is ironed out, but the existing patches for dynamic
> overlays work fine.
> 
> The patch series has been tested on BeaglePlay [4].
> 
> I will now go over individual parts of the patch series, but for a
> better picture of the approach, it would be best to checkout [0] first.
> 
> MikroBUS connector driver
> -------------------------
> 
> Just a stub platform driver for now. Will be extended in the future for
> dynamic board discovery using 1-wire eeprom present in some MikroBUS
> addon boards.
> 
> While it is a stub driver, disabling it will make the GPIO connector
> nexus node unreachable (any driver attempting to use it will enter
> differed probing). So it is required.
> 
> MikroBUS connector Devicetree
> ------------------------------
> 
> The connector devicetree defines the MikroBUS GPIO nexus node. This
> allows using pin numbering relative to MikroBUS connector pins in the
> addon boards overlay. Currently, the patch uses a clockwise numbering:
> 
>   0: PWM
>   1: INT
>   2: RX
>   3: TX
>   4: SCL
>   5: SDA
>   6: MOSI
>   7: MISO
>   8: SCK
>   9: CS
>   10: RST
>   11: AN
> 
> Additionally, in case PWM pin is not using channel 0, a nexus node for pwm
> should also be used and go in the connector devicetree.
> 
> MikroBUS connector symbols overlay
> ----------------------------------
> 
> To make an overlay generic we need a standard name scheme which we
> use across base boards. For the connector pins the pinmux phandle
> shall be:
> 
> <connector-name>_<pin-name>_mux_<pin-function>
> 
> For the parent provider phandle, we use a similar naming scheme:
> 
> <connector-name>_<pin-name>_<pin-function>
> 
> For GPIO controller, I am using `MIKROBUS_GPIO` name since with nexus
> nodes, we do not need to define individual pin gpio controllers.
> 
> The string symbols can be replaced with phandles once [5] is accepted.
> That will make connector stacking much simpler.
> 
> MikroBUS addon board overlay
> ----------------------------
> 
> The patch puts the addon board overlays in their own directory. I am
> using the following naming scheme for MikroBUS addon boards:
> 
> <vendor>-<product_id>.dtso
> 
> Mikroe [6] lists this for all boards in their website, but I am not sure
> if other vendors have a product_id.
> 
> This naming also makes future dynamic discovery easier, since click id
> spec [7] contains vendor_id and product_id in the header.
> 
> Usage
> -----
> 
> So what does this all look like? Let's take an example of a BeaglePlay
> with one MikroBUS connectors for which we have physically attached a
> Wather click module to the first connector. Doing ahead of time
> command-line DT overlay application:
> 
> ./fdtoverlay \
> 	-o output.dtb \
> 	-i k3-am625-beagleplay.dtb \
> 		k3-am625-beagleplay-mikrobus-connector0.dtbo mikroe-5761.dtbo
> 
> Open Items
> ----------
> 
> - SPI Support: 
>   Currently SPI dt requires `reg` property to specify the
>   chipselect to use. This, makes the SPI device overlay dependent on the
>   SPI controller. Thus for SPI support, we need a way to allow defining
>   SPI chipselect relative to MikroBUS pins, and not the actual device
>   controller.
> 
>   One possible solution is to introduce something like `named-reg` and
>   allow selecting the chipselect by string array. But this probably
>   requires more discussion so I have left out SPI support for now.
> 
>   NOTE: pins other than the CS MikroBUS pin can be used as chipselect.
>   See [8].
> 
> - Controller symbol duplication
>   The current symbol scheme has multiple symbols for the same underlying
>   controller (Eg: MIKROBUS_SCL_MUX_I2C_SCL and MIKROBUS_SDA_MUX_I2C_SDA)
>   point to the same i2c controller.
> 
>   I think both of them will always use the same i2c controller, but
>   maybe there are some exceptions? So I have left it as it is for this
>   patch series. The same thing also applies to UART and SPI.
> 
>   NOTE: with the use of nexus node for GPIO, the GPIO controller symbol
>   will be the same for all pins.
> 
> - Nexus node dt-bindings
>   I am not quite sure how to deal with the nexus node properties
>   (#gpio-cells, gpio-map, gpio-map-mask, gpio-map-pass-thru) since they
>   seem to conflict with upstream gpio schema (gpio-controller is a
>   dependency of #gpio-cells).

Please submit a fix to dtschema. Either GH PR or patch to 
devicetree-spec list.

Rob

