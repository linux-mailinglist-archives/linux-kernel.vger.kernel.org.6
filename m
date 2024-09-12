Return-Path: <linux-kernel+bounces-325836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1823975ED6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 04:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C66771C229F2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 02:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A827F3CF58;
	Thu, 12 Sep 2024 02:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="nYm0mDHT"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1173B784;
	Thu, 12 Sep 2024 02:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726107569; cv=none; b=PGqC0x8RkicBxRUHr9bJpD4LpsfFerSgg2jutizk/zjmo+rj1uYtIdevA8c+/ZHD3IW2qGoMSvS6w0JtKlXxeOY5A7oOxbjO17+KtlL/KeSp11lyAxzsh9RVeXdLwdNLvcTNGoybJlwAF6hq3RGuolW1dtLmqk+v/QHUR6+V0Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726107569; c=relaxed/simple;
	bh=ApcHvfUEotxvS5e99qlFOrCpTx5gVZ+VOSXG6e0NcV8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M5ghonY/kFRRgyJ8lPPa76jemSUpG2rfdPxNqtnBPlS9gcIzqk7KhkMEQ/Tukyq1h/aC7xc8J1aSUqMVA4BfIFAQsOT6SFyRkGSecN638RSshUdxxg1LRlF8e3t6hb5dZCv5LVJPr9dzt5GZ2YqjzfaU3WgJ9uM+9doGffiCNtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=nYm0mDHT; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1726107565;
	bh=ipltQWMwxD1LeV+oKdLSFHbv43Qowb0JPJe2RinWwYo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nYm0mDHTJQ09HXajwVGyc/Q11zzgDlq+Y8IIwyDDuJeDTAyg/vA5BbpHxdFYEW9Mb
	 AEqUuhEXp/TjE73BF0Z3T64UyZjwJX3IMlH81qoBv5tft/OINmb3addy58zHUiss31
	 8QYjiEEOoP5vlEWVzwsTtG1ZC0hyMx42S6n10EWSf+x4YE3dCQ+NK7Fi60pe/wgGnq
	 zjvEysFysrnifPwx68cA4WHzC4Hqv7oakCfXMEB8A4HiHIISci6CFjhNzenbyRM/1b
	 YbBGg0iBe9mRUItZLcm/RYTkxIoS9q3IvAcPBr+dOeK1U6Vx+U7qWcikfwunFGt1OF
	 sYJiZqMVphLPQ==
Received: from [192.168.68.112] (ppp118-210-89-8.adl-adc-lon-bras32.tpg.internode.on.net [118.210.89.8])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id DED3B650D6;
	Thu, 12 Sep 2024 10:19:24 +0800 (AWST)
Message-ID: <63ce2d4b7edc52952a5f1bb97eb4dc8e7305045f.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1] ARM: dts: aspeed: yosemite4: Enable spi-gpio setting
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 12 Sep 2024 11:49:24 +0930
In-Reply-To: <20240910030324.2256698-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240910030324.2256698-1-Delphine_CC_Chiu@wiwynn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-09-10 at 11:03 +0800, Delphine CC Chiu wrote:
> From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
>=20
> Enable spi-gpio setting for spi flash in yosemite4.

Is there actually a flash chip on the same bus? You've only described a
TPM. If there's no flash then this seems misleading.

Andrew

> Add tpm device under spi.
>=20
> Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts   | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b=
/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index 98477792aa00..fdf9040d655b 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -34,6 +34,24 @@ iio-hwmon {
>  				<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
>  				<&adc1 0>, <&adc1 1>;
>  	};
> +
> +	spi {
> +		compatible =3D "spi-gpio";
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		sck-gpios =3D <&gpio0 ASPEED_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
> +		mosi-gpios =3D <&gpio0 ASPEED_GPIO(X, 4) GPIO_ACTIVE_HIGH>;
> +		miso-gpios =3D <&gpio0 ASPEED_GPIO(X, 5) GPIO_ACTIVE_HIGH>;
> +		cs-gpios =3D <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>;
> +		num-chipselects =3D <1>;
> +
> +		tpm@0 {
> +			reg =3D <0>;
> +			compatible =3D "infineon,slb9670", "tcg,tpm_tis-spi";
> +			spi-max-frequency =3D <33000000>;
> +		};
> +	};
>  };
> =20
>  &uart1 {


