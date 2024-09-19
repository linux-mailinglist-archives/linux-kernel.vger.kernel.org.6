Return-Path: <linux-kernel+bounces-333027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B3697C268
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 03:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0B6928376F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 01:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17C0171A1;
	Thu, 19 Sep 2024 01:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="nQiCg+Jw"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C060DBA42;
	Thu, 19 Sep 2024 01:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726708966; cv=none; b=HoAyed71JVjYY3ggIlSuhOCMTID5wSOCb89o1vEvjc4W4+HJ4gMB9TTwtgsBfcGuuo0v4aOrR0KhD5J1mB7vKCCghhmS2CfKLBgdJnqOUoP9mZovaEt6y5FHelj6NmJjLSkyHpcq9ysJrhcp95jvp2p+VeNWGfHd5ljGoeFKt/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726708966; c=relaxed/simple;
	bh=HjPUrKu+j/D2JEYbilGLkObOoJh09svt2PAMGh/GDQ8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KrnVteHww8KjBjZVjnAftOLL2o+Pa87qYTHD78+1nUZDl8E6Z5xtqqzeG0xN3q0gw3cl20N/rLhrJiSxuIusUkm8+ZfW89A0POp1h++8Ou67X/xbT/4XWvZ7gYs78zUkIevTPMa3RTZdW1UHpvhVhtAxGLrn98I0a2n6MOpAf1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=nQiCg+Jw; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1726708955;
	bh=Q9bLimoZ5dqO/v/xStiEtBFXXxiEU7NxX3hkGV7VX/4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nQiCg+JwJb/V4sGdSmNJ3xEHu9mtyIOtCwDxbSWQ76UXYP+XVeBk3rKqwz3OUw26i
	 B3Uh7p7Se6Kk15jEjrlERxP3FOSn6Zt5lzNMa24SUk4h4e0qHs0L3q4z9PfgyDQjI8
	 yA0bfCBJKbplMl2lfcqTQp9psRYryV8O+ZVrPHXLQ1npr5RLO8e/443pDH9rjKgSCA
	 eOWLb2Khz8AWakal2b8PCLPnsRtfwVcJZFJehBxlwyIG+UpyZQyPFD4z4ACEpwy35b
	 3wPFTTJMAALOCNdH3wB5GYm5oQ3kc5t06MfUk8RXNtVCIg84TTKV93++/sZDLFTf8L
	 w3qPq6AubH1vw==
Received: from [192.168.238.88] (ppp118-210-188-185.adl-adc-lon-bras34.tpg.internode.on.net [118.210.188.185])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 5A09965027;
	Thu, 19 Sep 2024 09:22:27 +0800 (AWST)
Message-ID: <11a0ae09bc722b1f21ae76df99bd8c1d885c85d1.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 3/3] ARM: dts: aspeed: yosemite4: Add power module
 and ADC on Medusa Board
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, Guenter Roeck
 <linux@roeck-us.net>, Noah Wang <noahwang.wang@outlook.com>, Peter Yin
 <peteryin.openbmc@gmail.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>,  Lukas Wunner <lukas@wunner.de>, Laurent
 Pinchart <laurent.pinchart@ideasonboard.com>,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org
Date: Thu, 19 Sep 2024 10:52:24 +0930
In-Reply-To: <20240918095438.1345886-4-Delphine_CC_Chiu@wiwynn.com>
References: <20240918095438.1345886-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240918095438.1345886-4-Delphine_CC_Chiu@wiwynn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Ricky,

On Wed, 2024-09-18 at 17:54 +0800, Delphine CC Chiu wrote:
> From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
>=20
> Add RTQ6056 as 2nd source ADC sensor on Medusa Board.

Can you unpack why this is related in the commit message? I assume it's
for something like battery monitoring? An explanation would help
though.

> Add power sensors on Medusa board:
> - Add XDP710 as 2nd source HSC to monitor P48V PSU power.
> - Add MP5023 as P12V efuse (Driver exists but un-documented).
> - Add PMBUS sensors as P12V Delta Module.

Generally if you're listing multiple things the change does in the
commit message you should have split the patch up accordingly.

There's some good advice here:

https://docs.kernel.org/process/5.Posting.html#patch-preparation

and here:

https://github.com/axboe/liburing/blob/master/CONTRIBUTING.md?plain=3D1#L21=
-L32

>=20
> Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 45 ++++++++++++++++++-
>  1 file changed, 43 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b=
/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index 98477792aa00..e486b9d78f61 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -284,15 +284,25 @@ &i2c10 {
>  &i2c11 {
>  	status =3D "okay";
>  	power-sensor@10 {
> -		compatible =3D "adi, adm1272";
> +		compatible =3D "adi,adm1272";
>  		reg =3D <0x10>;
>  	};

This was outright busted. The hunk is a fix, as is the second instance
below. Please separate these out into their own patch and add a Fixes:
tag to it.

> =20
> +	power-sensor@11 {
> +		compatible =3D "infineon,xdp710";
> +		reg =3D <0x11>;
> +	};
> +
>  	power-sensor@12 {
> -		compatible =3D "adi, adm1272";
> +		compatible =3D "adi,adm1272";

(i.e. this one also)

>  		reg =3D <0x12>;
>  	};
> =20
> +	power-sensor@13 {
> +		compatible =3D "infineon,xdp710";
> +		reg =3D <0x13>;
> +	};
> +
>  	gpio@20 {
>  		compatible =3D "nxp,pca9555";
>  		reg =3D <0x20>;
> @@ -321,6 +331,17 @@ gpio@23 {
>  		#gpio-cells =3D <2>;
>  	};
> =20
> +	power-sensor@40 {
> +		compatible =3D "mps,mp5023";
> +		reg =3D <0x40>;
> +	};
> +
> +	adc@41 {
> +		compatible =3D "richtek,rtq6056";
> +		reg =3D <0x41>;
> +		#io-channel-cells =3D <1>;
> +	};
> +
>  	temperature-sensor@48 {
>  		compatible =3D "ti,tmp75";
>  		reg =3D <0x48>;
> @@ -345,6 +366,26 @@ eeprom@54 {
>  		compatible =3D "atmel,24c256";
>  		reg =3D <0x54>;
>  	};
> +
> +	power-sensor@62 {
> +		compatible =3D "pmbus";
> +		reg =3D <0x62>;
> +	};
> +
> +	power-sensor@64 {
> +		compatible =3D "pmbus";
> +		reg =3D <0x64>;
> +	};
> +
> +	power-sensor@65 {
> +		compatible =3D "pmbus";
> +		reg =3D <0x65>;
> +	};
> +
> +	power-sensor@68 {
> +		compatible =3D "pmbus";
> +		reg =3D <0x68>;
> +	};

See the discussion on your proposed DT binding document; I expect these
will need to change.

Andrew

