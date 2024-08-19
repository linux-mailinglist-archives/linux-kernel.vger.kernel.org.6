Return-Path: <linux-kernel+bounces-291294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E8995608B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 02:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294EB1C21147
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 00:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFD516415;
	Mon, 19 Aug 2024 00:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="aAMTDVhz"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C14DDC3;
	Mon, 19 Aug 2024 00:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724027128; cv=none; b=XYlsVkavg75MIfo/1mG/yGH1l6kEsx42BwmvSMrhXHiTeia9PD17Ab8/x+TdESy5308AHk8rU0nFpSV1n12CMn+qLHsJt17OD84aVbt4xvh+i1/DYtw/g4hSuj3SUNG0l+8d2OZHCeXoTxSdz0A6adBuzPEZQcGQwApNB10C5UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724027128; c=relaxed/simple;
	bh=Eyq6wtaq6GXQhaVxZ+sC46NpntbeCVg5YOAsi2lmG1Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ecYEAFVfNprfPwUn/Zqh/bzRX7Awamsoz78TtdP3bzG18T/Hrz1SMt1uX6hM9Ib4g9BbRUtOu1y9nEOJ0zR1vXmxgKZRoEbGc6skz88FOZHeC5diP90OWyeTMijquWCLRwjp5xYX9NNbl4uQiIOgwoVBOQ07kYxLjkZQYDGaVpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=aAMTDVhz; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1724027116;
	bh=YHBMt5YHXuDbAcR41p94v9l4YRaVrhX1zks7CDq6P5Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aAMTDVhzI85lw59mtUzROTQFzPNTIgpqDHJQu7y+nhQZwFslwQRXpAswy6XYhZ3WY
	 kGrYtd5vrioIYWz4XdoWpXHLRtKGCxY+0bi+ajVDHkiKF8vHaidRP6ntEGB82ABMCo
	 ekhOI9JUImztTDWt60/cCisWxvdptHF3Dy+DqLfoMfaDMEhgeKN3LFeEviYiyrADev
	 zwWKxGFSf+i/eP0XHdPPZPY5kikaKbORHvaVkuWlGSvRz1JN0c6EmHO61pTbXTq0Kk
	 2YOauRdYdXvhs5UCBKI/YWU0Bd2tXMEgRHc8McqYvCRBv27JkHUqvOS9du1xjg3qcu
	 rSOvnql0UGfgw==
Received: from [192.168.68.112] (ppp118-210-94-119.adl-adc-lon-bras32.tpg.internode.on.net [118.210.94.119])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 09EF864BE9;
	Mon, 19 Aug 2024 08:25:13 +0800 (AWST)
Message-ID: <bdeba6fae8db2dd73ae668f6e228f8378fa439bd.camel@codeconstruct.com.au>
Subject: Re: [PATCH v12 01/28] ARM: dts: aspeed: yosemite4: Revise i2c-mux
 devices
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Mon, 19 Aug 2024 09:55:11 +0930
In-Reply-To: <20240816092417.3651434-2-Delphine_CC_Chiu@wiwynn.com>
References: <20240816092417.3651434-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240816092417.3651434-2-Delphine_CC_Chiu@wiwynn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-08-16 at 17:23 +0800, Delphine CC Chiu wrote:
> Revise Yosemite 4 devicetree for devices behind i2c-mux
> - Add gpio and eeprom behind i2c-mux
> - Remove redundant idle-state setting for i2c-mux
>=20
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 381 ++++++++++++++++--
>  1 file changed, 347 insertions(+), 34 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b=
/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index 98477792aa00..ce206e2c461b 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -17,6 +17,25 @@ aliases {
>  		serial6 =3D &uart7;
>  		serial7 =3D &uart8;
>  		serial8 =3D &uart9;
> +
> +		i2c16 =3D &imux16;
> +		i2c17 =3D &imux17;
> +		i2c18 =3D &imux18;
> +		i2c19 =3D &imux19;
> +		i2c20 =3D &imux20;
> +		i2c21 =3D &imux21;
> +		i2c22 =3D &imux22;
> +		i2c23 =3D &imux23;
> +		i2c24 =3D &imux24;
> +		i2c25 =3D &imux25;
> +		i2c26 =3D &imux26;
> +		i2c27 =3D &imux27;
> +		i2c28 =3D &imux28;
> +		i2c29 =3D &imux29;
> +		i2c30 =3D &imux30;
> +		i2c31 =3D &imux31;
> +		i2c32 =3D &imux32;
> +		i2c33 =3D &imux33;
>  	};
> =20
>  	chosen {
> @@ -259,9 +278,109 @@ &i2c8 {
>  	bus-frequency =3D <400000>;
>  	i2c-mux@70 {
>  		compatible =3D "nxp,pca9544";
> -		idle-state =3D <0>;
>  		i2c-mux-idle-disconnect;
>  		reg =3D <0x70>;
> +
> +		imux16: i2c@0 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <0>;
> +
> +			gpio@49 {
> +				compatible =3D "nxp,pca9537";
> +				reg =3D <0x49>;
> +			};
> +
> +			eeprom@50 {
> +				compatible =3D "atmel,24c128";
> +				reg =3D <0x50>;
> +			};
> +
> +			eeprom@51 {
> +				compatible =3D "atmel,24c128";
> +				reg =3D <0x51>;
> +			};
> +
> +			eeprom@54 {
> +				compatible =3D "atmel,24c128";
> +				reg =3D <0x54>;
> +			};
> +		};
> +
> +		imux17: i2c@1 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <1>;
> +			gpio@49 {
> +				compatible =3D "nxp,pca9537";
> +				reg =3D <0x49>;
> +			};
> +
> +			eeprom@50 {
> +				compatible =3D "atmel,24c128";
> +				reg =3D <0x50>;
> +			};
> +
> +			eeprom@51 {
> +				compatible =3D "atmel,24c128";
> +				reg =3D <0x51>;
> +			};
> +
> +			eeprom@54 {
> +				compatible =3D "atmel,24c128";
> +				reg =3D <0x54>;
> +			};
> +		};
> +
> +		imux18: i2c@2 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <2>;
> +			gpio@49 {
> +				compatible =3D "nxp,pca9537";
> +				reg =3D <0x49>;
> +			};
> +
> +			eeprom@50 {
> +				compatible =3D "atmel,24c128";
> +				reg =3D <0x50>;
> +			};
> +
> +			eeprom@51 {
> +				compatible =3D "atmel,24c128";
> +				reg =3D <0x51>;
> +			};
> +
> +			eeprom@54 {
> +				compatible =3D "atmel,24c128";
> +				reg =3D <0x54>;
> +			};
> +		};
> +
> +		imux19: i2c@3 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <3>;
> +			gpio@49 {
> +				compatible =3D "nxp,pca9537";
> +				reg =3D <0x49>;
> +			};
> +
> +			eeprom@50 {
> +				compatible =3D "atmel,24c128";
> +				reg =3D <0x50>;
> +			};
> +
> +			eeprom@51 {
> +				compatible =3D "atmel,24c128";
> +				reg =3D <0x51>;
> +			};
> +
> +			eeprom@54 {
> +				compatible =3D "atmel,24c128";
> +				reg =3D <0x54>;
> +			};
> +		};
>  	};
>  };
> =20
> @@ -270,15 +389,174 @@ &i2c9 {
>  	bus-frequency =3D <400000>;
>  	i2c-mux@71 {
>  		compatible =3D "nxp,pca9544";
> -		idle-state =3D <0>;
>  		i2c-mux-idle-disconnect;
>  		reg =3D <0x71>;
> +
> +		imux20: i2c@0 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <0>;
> +			gpio@49 {
> +				compatible =3D "nxp,pca9537";
> +				reg =3D <0x49>;
> +			};
> +
> +			eeprom@50 {
> +				compatible =3D "atmel,24c128";
> +				reg =3D <0x50>;
> +			};
> +
> +			eeprom@51 {
> +				compatible =3D "atmel,24c128";
> +				reg =3D <0x51>;
> +			};
> +
> +			eeprom@54 {
> +				compatible =3D "atmel,24c128";
> +				reg =3D <0x54>;
> +			};
> +		};
> +
> +		imux21: i2c@1 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <1>;
> +			gpio@49 {
> +				compatible =3D "nxp,pca9537";
> +				reg =3D <0x49>;
> +			};
> +
> +			eeprom@50 {
> +				compatible =3D "atmel,24c128";
> +				reg =3D <0x50>;
> +			};
> +
> +			eeprom@51 {
> +				compatible =3D "atmel,24c128";
> +				reg =3D <0x51>;
> +			};
> +
> +			eeprom@54 {
> +				compatible =3D "atmel,24c128";
> +				reg =3D <0x54>;
> +			};
> +		};
> +
> +		imux22: i2c@2 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <2>;
> +			gpio@49 {
> +				compatible =3D "nxp,pca9537";
> +				reg =3D <0x49>;
> +			};
> +
> +			eeprom@50 {
> +				compatible =3D "atmel,24c128";
> +				reg =3D <0x50>;
> +			};
> +
> +			eeprom@51 {
> +				compatible =3D "atmel,24c128";
> +				reg =3D <0x51>;
> +			};
> +
> +			eeprom@54 {
> +				compatible =3D "atmel,24c128";
> +				reg =3D <0x54>;
> +			};
> +		};
> +
> +		imux23: i2c@3 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <3>;
> +
> +			gpio@49 {
> +				compatible =3D "nxp,pca9537";
> +				reg =3D <0x49>;
> +			};
> +
> +			eeprom@50 {
> +				compatible =3D "atmel,24c128";
> +				reg =3D <0x50>;
> +			};
> +
> +			eeprom@51 {
> +				compatible =3D "atmel,24c128";
> +				reg =3D <0x51>;
> +			};
> +
> +			eeprom@54 {
> +				compatible =3D "atmel,24c128";
> +				reg =3D <0x54>;
> +			};
> +		};
>  	};
>  };
> =20
>  &i2c10 {
>  	status =3D "okay";
>  	bus-frequency =3D <400000>;
> +	i2c-mux@74 {
> +		compatible =3D "nxp,pca9544";
> +		i2c-mux-idle-disconnect;
> +		reg =3D <0x74>;
> +
> +		imux28: i2c@0 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <0>;
> +
> +			gpio@20 {
> +				compatible =3D "nxp,pca9506";
> +				reg =3D <0x20>;
> +				gpio-controller;
> +				#gpio-cells =3D <2>;
> +			};
> +
> +			gpio@21 {
> +				compatible =3D "nxp,pca9506";
> +				reg =3D <0x21>;
> +				gpio-controller;
> +				#gpio-cells =3D <2>;
> +			};
> +
> +			gpio@22 {
> +				compatible =3D "nxp,pca9506";
> +				reg =3D <0x22>;
> +				gpio-controller;
> +				#gpio-cells =3D <2>;
> +			};
> +
> +			gpio@23 {
> +				compatible =3D "nxp,pca9506";
> +				reg =3D <0x23>;
> +				gpio-controller;
> +				#gpio-cells =3D <2>;
> +			};
> +
> +			gpio@24 {
> +				compatible =3D "nxp,pca9506";
> +				reg =3D <0x24>;
> +				gpio-controller;
> +				#gpio-cells =3D <2>;
> +				gpio-line-names =3D
> +				"","","","",
> +				"NIC0_MAIN_PWR_EN","NIC1_MAIN_PWR_EN",
> +				"NIC2_MAIN_PWR_EN","NIC3_MAIN_PWR_EN",
> +				"","","","","","","","",
> +				"","","","","","","","",
> +				"","","","","","","","";
> +			};
> +		};
> +
> +		imux29: i2c@1 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <1>;
> +		};
> +	};
>  };
> =20
>  &i2c11 {
> @@ -440,16 +718,14 @@ eeprom@51 {
>  		reg =3D <0x51>;
>  	};
> =20
> -	i2c-mux@71 {
> -		compatible =3D "nxp,pca9846";
> +	i2c-mux@74 {
> +		compatible =3D "nxp,pca9546";
>  		#address-cells =3D <1>;
>  		#size-cells =3D <0>;
> -
> -		idle-state =3D <0>;
>  		i2c-mux-idle-disconnect;
> -		reg =3D <0x71>;
> +		reg =3D <0x74>;
> =20
> -		i2c@0 {
> +		imux30: i2c@0 {
>  			#address-cells =3D <1>;
>  			#size-cells =3D <0>;
>  			reg =3D <0>;
> @@ -457,26 +733,26 @@ i2c@0 {
>  			adc@1f {
>  				compatible =3D "ti,adc128d818";
>  				reg =3D <0x1f>;
> -				ti,mode =3D /bits/ 8 <2>;
> +				ti,mode =3D /bits/ 8 <1>;
>  			};
> =20
>  			pwm@20{
> -				compatible =3D "max31790";
> +				compatible =3D "maxim,max31790";
> +				pwm-as-tach =3D <4 5>;
>  				reg =3D <0x20>;
> -				#address-cells =3D <1>;
> -				#size-cells =3D <0>;
>  			};
> =20
>  			gpio@22{
>  				compatible =3D "ti,tca6424";
>  				reg =3D <0x22>;
> +				gpio-controller;
> +				#gpio-cells =3D <2>;
>  			};
> =20
> -			pwm@23{
> -				compatible =3D "max31790";
> -				reg =3D <0x23>;
> -				#address-cells =3D <1>;
> -				#size-cells =3D <0>;
> +			pwm@2f{
> +				compatible =3D "maxim,max31790";
> +				pwm-as-tach =3D <4 5>;
> +				reg =3D <0x2f>;
>  			};
> =20
>  			adc@33 {
> @@ -499,34 +775,34 @@ gpio@61 {
>  			};
>  		};
> =20
> -		i2c@1 {
> +		imux31: i2c@1 {
>  			#address-cells =3D <1>;
>  			#size-cells =3D <0>;
> -			reg =3D <0>;
> +			reg =3D <1>;
> =20
>  			adc@1f {
>  				compatible =3D "ti,adc128d818";
>  				reg =3D <0x1f>;
> -				ti,mode =3D /bits/ 8 <2>;
> +				ti,mode =3D /bits/ 8 <1>;
>  			};
> =20
>  			pwm@20{
> -				compatible =3D "max31790";
> +				compatible =3D "maxim,max31790";

The max31790 binding isn't yet upstream[1]. Please drop these nodes
entirely until the binding has been accepted. You can send a follow-up
patch adding them once it is merged.

Please make sure to run `./scripts/checkpatch.pl` and `make dtbs_check`
on your changes.

Andrew

[1]: https://lore.kernel.org/all/20240813084152.25002-1-chanh@os.amperecomp=
uting.com/

