Return-Path: <linux-kernel+bounces-325410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD51F975957
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 19:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84657286555
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25121AC896;
	Wed, 11 Sep 2024 17:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4jvy7Ow"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BCA1B3B2A;
	Wed, 11 Sep 2024 17:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726075588; cv=none; b=IUfQ1mtl7FERNgraAnnS0P8pWDqdHChdpA6PKpYOlLv26B1E/n6P8H41vbyqxsaeSVF/nyE8E0nF3kNdnYHyl9JAp11fLaJYQTqFxCMC/uvPtKl+6sumFt8dSpnI7XfGx+hD0N0+AoyZzKhV4XVTBSYLzKDg/0CsLiJT4Qc84xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726075588; c=relaxed/simple;
	bh=o2NQ7P7ABYg2Zw4KZcHITK9PUPmdqTH02R/Ad7MZb5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zi+RN9ZwN/ekzDWIyT9Gyq8jwAoPXlrn5/UkTX/AarCcK94q4gAbIMcWQiwJYj8YlmlC9H00Yu4bw9N1qQki49dip0pri7zO74FsqUpaP1133yiwThewGcMwVZlOfw52Znj51DNnxOkoNATnfxxjISNuVqboMMbN12b1/GjwK5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4jvy7Ow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6ADC4CECC;
	Wed, 11 Sep 2024 17:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726075587;
	bh=o2NQ7P7ABYg2Zw4KZcHITK9PUPmdqTH02R/Ad7MZb5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h4jvy7OwIrVT70zHVaED2k3JxAQJUwSTyy5XqBPGp8W9UzpQOAvAhTFBG0JGqQlCu
	 OU1HMaWkboY5gBLTi8/cAxr/UzgG5V/SLHyAZkRfm6RNg6llgtoowqQbof+IAr2Igs
	 tomXxrvJUbte7P7po1G2HRNrlaEIb8V3nBwFU11tuubHocOMoGYc1xWhF4nz30CXEO
	 6E3zowvlqKy4GzjQZZx6JLJAuTECTBNPnnfzetbupREFbbEMF1KHU2ecacKQhKJ8t6
	 Ij7cO1ZqYvltFO9AOPCgPMambACpl1m4AUy8DytLE8cGdtWfERiPQAvQShXIR0AyIe
	 SOz/lUkgMhLsw==
Date: Wed, 11 Sep 2024 12:26:26 -0500
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
Subject: Re: [PATCH 2/8] dt-bindings: connector: Add MikorBUS connector
Message-ID: <20240911172626.GB915638-robh@kernel.org>
References: <20240911-mikrobus-dt-v1-0-3ded4dc879e7@beagleboard.org>
 <20240911-mikrobus-dt-v1-2-3ded4dc879e7@beagleboard.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911-mikrobus-dt-v1-2-3ded4dc879e7@beagleboard.org>

On Wed, Sep 11, 2024 at 07:57:19PM +0530, Ayush Singh wrote:
> Add DT bindings for mikroBUS interface. MikroBUS [0] is an open standard
> developed by MikroElektronika for connecting add-on boards to
> microcontrollers or microprocessors.

Typo in the subject...

Isn't this v6? Where's the revision history?

> 
> MikroBUS connector node will optionally act as nexus nodes for routing
> GPIOs and PWM.
> 
> For GPIOs, the following pin numbering should be followed:
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
> For PWM, the PWM pin should be on channel 0.
> 
> I am not quite sure how to deal with the nexus node properties
> (#gpio-cells, gpio-map, gpio-map-mask, gpio-map-pass-thru) since they
> seem to conflict with upstream gpio schema (gpio-controller is a
> dependency of #gpio-cells).
> 
> [0]: https://www.mikroe.com/
> 
> Signed-off-by: Ayush Singh <ayush@beagleboard.org>
> ---
>  .../bindings/connector/mikrobus-connector.yaml     | 40 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 +++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/connector/mikrobus-connector.yaml b/Documentation/devicetree/bindings/connector/mikrobus-connector.yaml
> new file mode 100644
> index 000000000000..603e4627076c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/connector/mikrobus-connector.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +#
> +# Copyright (c) Ayush Singh <ayush@beagleboard.org>
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/connector/mikrobus-connector.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: mikroBUS add-on board socket
> +
> +maintainers:
> +  - Ayush Singh <ayush@beagleboard.org>
> +
> +properties:
> +  compatible:
> +    const: mikrobus-connector
> +
> +required:
> +  - compatible
> +
> +additionalProperties: true

Cannot be true. You're schema must be complete. I don't understand what 
happened to everything else in the binding.

> +
> +examples:
> +  - |
> +    mikrobus_connector0: mikrobus-connector0 {
> +      status = "okay";
> +      compatible = "mikrobus-connector";
> +
> +      #gpio-cells = <2>;
> +      gpio-map =
> +      <0 0 &main_gpio1 11 0>, <1 0 &main_gpio1 9 0>,
> +      <2 0 &main_gpio1 24 0>, <3 0 &main_gpio1 25 0>,
> +      <4 0 &main_gpio1 22 0>, <5 0 &main_gpio1 23 0>,
> +      <6 0 &main_gpio1 7 0>, <7 0 &main_gpio1 8 0>,
> +      <8 0 &main_gpio1 14 0>, <9 0 &main_gpio1 13 0>,
> +      <10 0 &main_gpio1 12 0>, <11 0 &main_gpio1 10 0>;
> +      gpio-map-mask = <0xf 0x0>;
> +      gpio-map-pass-thru = <0x0 0x1>;
> +    };
> +
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0a3d9e17295a..0cc27446b18a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15429,6 +15429,11 @@ M:	Oliver Neukum <oliver@neukum.org>
>  S:	Maintained
>  F:	drivers/usb/image/microtek.*
>  
> +MIKROBUS CONNECTOR
> +M:	Ayush Singh <ayush@beagleboard.org>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/connector/mikrobus-connector.yaml
> +
>  MIKROTIK CRS3XX 98DX3236 BOARD SUPPORT
>  M:	Luka Kovacic <luka.kovacic@sartura.hr>
>  M:	Luka Perkov <luka.perkov@sartura.hr>
> 
> -- 
> 2.46.0
> 

