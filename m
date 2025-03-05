Return-Path: <linux-kernel+bounces-546567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F04A2A4FC53
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A39783A4DFF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F61520968E;
	Wed,  5 Mar 2025 10:31:41 +0000 (UTC)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9631C207666;
	Wed,  5 Mar 2025 10:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170701; cv=none; b=u9ChZe4eK0CN/8wDnjNj8ZaWnccq+hj2yBFnNOw/zps+K1mrtPfmZo2JVnn19tnRRge2CWwNQ7W+lNIbD05BgmiawplX2ebB7iq8fBrtLbSXAyxM/72xzrCkl5WwtQEtoWLbza1flae7tHMBb2UnDm8NRrkX3/rFIYh83IWcCZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170701; c=relaxed/simple;
	bh=g+aI6C8AfThrTwvmMepMOdyRNmLEsNi+5aIpUo6vfj8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:
	 References:In-Reply-To; b=V8sXK+EL5jr9xt+e5/uv/1bsmoGaCpHEoISsonJ2Ub5R3mKysnvQsUIyr4E1S5TPdfqQ5bxxNclQJtkq8H9kqq7nUMfgDl5svd8rgAKCau03Bp7qnGmnhJRAfjn8vmVp/uF0r27seDIib++8cYpUH9ubW5b99NsBGSkOR088qs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4320:1000:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id AEE0B130;
	Wed,  5 Mar 2025 11:31:36 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Mar 2025 11:31:36 +0100
Message-Id: <D889HZF97H8U.1UUX54BAVLAC3@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Manikandan Muralidharan" <manikandan.m@microchip.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <claudiu.beznea@tuxon.dev>, <tudor.ambarus@linaro.org>,
 <pratyush@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
 <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH 2/2] ARM: dts: microchip: sama5d29_curiosity: Add
 nvmem-layout in QSPI to describe EUI48 MAC address region
X-Mailer: aerc 0.16.0
References: <20250305100134.1171124-1-manikandan.m@microchip.com>
 <20250305100134.1171124-2-manikandan.m@microchip.com>
In-Reply-To: <20250305100134.1171124-2-manikandan.m@microchip.com>

On Wed Mar 5, 2025 at 11:01 AM CET, Manikandan Muralidharan wrote:
> Add nvmem-layout in QSPI to describe EUI48 MAC address region.
> This is useful for cases where U-Boot is skipped and the Ethernet
> MAC address is needed to be configured in Linux.
>
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---
>  .../arm/boot/dts/microchip/at91-sama5d29_curiosity.dts | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts b/ar=
ch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
> index 7be215781549..81aca8502195 100644
> --- a/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
> +++ b/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
> @@ -480,6 +480,16 @@ flash@0 {
>  		label =3D "atmel_qspi1";
>  		status =3D "okay";
> =20
> +		nvmem-layout {
> +			compatible =3D "fixed-layout";
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +
> +			mac_address_eui48: mac-address@261 {

I don't think the offset should be hardcoded in the device tree.
Apparently it is a property of this very chip (and not backed up by
a JEDEC standard). What happens if the SFDP are changed for this
flash? I.e. The length of the SFDP region changes.

Also, this looks like it is a layout for the SPI flash contents and
not the SFDP, how do you differentiate between these two? Also
please update your device tree to use 'compatible =3D
"fixed-partitions"'.

-michael

> +				reg =3D <0x261 0x6>;
> +			};
> +		};



> +
>  		at91bootstrap@0 {
>  			label =3D "at91bootstrap";
>  			reg =3D <0x0 0x40000>;


