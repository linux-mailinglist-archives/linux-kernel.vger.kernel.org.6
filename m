Return-Path: <linux-kernel+bounces-577013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D28A7174F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75024188CE09
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA491E1E0D;
	Wed, 26 Mar 2025 13:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5qdfKNjk"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02A61AE876;
	Wed, 26 Mar 2025 13:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742995138; cv=none; b=RI1ReaCmGS/o12FKN8jzQNRXuKtictmfuZs9vJyRm1Z/TVrgEg3PeYlPcxNkMcqSjvvKgbN3tjz/6+Tj0jad0sh4RsLGI4Wl7SyBRApANMffq9Aid7y3cAvYJG+i1L41EJZfw7bhH107WgWQnaHZ+24+qvI4zlAEu/GJ8p8Tzp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742995138; c=relaxed/simple;
	bh=Fv+h0IU4woze0qj7ljpu3wH02eAbeJv44mcoYbUDYoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwvVb6+OnrUlT++UDlWtZ8vfbZlYjn/6ci2d+D8bLHuHCIrgWheUVTTuWTDPC5XZFCQ89bQ78X9FPSa3YEK3zGyrjfOluUZ3DUbA7McP8GXcq8RmS7asZS1UQDqlySJ7pdRsbrFbHUzDADj4ngrKiooVxV4LDSo/J9p+tjFVd8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5qdfKNjk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=woq4Ws3S18XYVJpP2olLOVDzz5HvlN2ip72DX9s9ClY=; b=5qdfKNjkUR8BygJiqjz9XfexAv
	AbsoIPNCFJCwMXoAhJl7jNzVt71lOlp+G5deiQ/UtJWilSkwghbaRZLcTncOX6xCorfibWtpRU4eG
	TME82MvdisQ8vvxubngwX8u6nF21fPTMS7TJJqf6hdWCp2V7FGs1ISbzafn8xKnWlEnY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1txQeU-007Ach-9u; Wed, 26 Mar 2025 14:18:38 +0100
Date: Wed, 26 Mar 2025 14:18:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, tudor.ambarus@linaro.org,
	pratyush@kernel.org, mwalle@kernel.org, miquel.raynal@bootlin.com,
	richard@nod.at, vigneshr@ti.com, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 3/3] ARM: dts: microchip: sama5d29_curiosity: Add
 nvmem-layout in QSPI for EUI48 MAC Address
Message-ID: <eed1531a-353a-4244-a10a-95e67c8416ae@lunn.ch>
References: <20250326072140.172244-1-manikandan.m@microchip.com>
 <20250326072140.172244-4-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326072140.172244-4-manikandan.m@microchip.com>

On Wed, Mar 26, 2025 at 12:51:40PM +0530, Manikandan Muralidharan wrote:
> Add nvmem-layout in QSPI to read the EUI48 Mac address by the
> net drivers using the nvmem property.The offset is set to 0x0
> since the factory programmed address is available in the
> resource managed space and the size determine if the requested
> address is of EUI48 (0x6) or EUI-64 (0x8) type.
> This is useful for cases where U-Boot is skipped and the Ethernet
> MAC address is needed to be configured by the kernel
> 
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---
>  .../arm/boot/dts/microchip/at91-sama5d29_curiosity.dts | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
> index 35756cc01e68..6c5ff08f0b3f 100644
> --- a/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
> +++ b/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
> @@ -478,6 +478,16 @@ flash@0 {
>  		label = "atmel_qspi1";
>  		status = "okay";
>  
> +		nvmem-layout {
> +			compatible = "fixed-layout";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			mac_address_eui48: mac-address@0 {
> +				reg = <0x0 0x6>;
> +			};
> +		};
> +

I've not looked too deeply how this all works. Don't you need a
reference in the ethernet node pointing to this?

And are there ordering issues? Boards used to use the MAC address from
somewhere else now start using this address, causing a change in
behaviour. I would expect somewhere a comment that this MAC address
will be used last, after all other options have been tried, in order
to avoid regressions.

   Andrew

