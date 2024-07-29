Return-Path: <linux-kernel+bounces-266513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7969400F3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 00:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D291B2273D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 22:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D824518EFCF;
	Mon, 29 Jul 2024 22:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stwcx.xyz header.i=@stwcx.xyz header.b="FU7ooVkD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EDM/bfA4"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED4B13CA95;
	Mon, 29 Jul 2024 22:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722291158; cv=none; b=um5fsOSY1ar1bRdS7lyEd6OmFjrL4W1sWTp4VXLyY+jZp7m5vBAWAsX0wTSVGmarRxwKA37K0P5TB9iuYJpOzE4KS/ad5cA/77gjCnRJEh+RioK9eUJNjiNDX5oUYXTl4WJDBMXWin3AEKdRcs3WLlxCWLPHv5Wm5gs8F4BOyUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722291158; c=relaxed/simple;
	bh=VN5zTflg1jjWlfp/fF008FBYl9dsSQNtOqnO5TqVFcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRNj7MPRCPaBv6RHKbUtSxPa6t63dk4AN9jqznxEWSR8bQZgkmcen5QAqxMa3/HAO6XeQeWvYbAL3UGPiKtlXL2moceFrlCP/fP4Ta40kDBKlU7q3suEU9q613g0NieeXvX60gM9Kqx8VXV91FhfxweCd0WA8fy/U+eCUffORHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stwcx.xyz; spf=pass smtp.mailfrom=stwcx.xyz; dkim=pass (2048-bit key) header.d=stwcx.xyz header.i=@stwcx.xyz header.b=FU7ooVkD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EDM/bfA4; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stwcx.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stwcx.xyz
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 359AE1140181;
	Mon, 29 Jul 2024 18:12:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 29 Jul 2024 18:12:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1722291154; x=1722377554; bh=E5F+gREmpO
	3rfAm2W13DEU5cr4oXc+JQE+AADW55Xew=; b=FU7ooVkDhnAAHk6+aQ+UnODqVc
	MQOZoDdWuvEjFP6FJSXRWerLYqXJXdMPaIQ2+04mvq4igEYqvdNNsBuM0EIih0GW
	bGhwIbKq+5513ES6b9C7cMiCMwcSBsXoZwhyLFcpjiW2gJeMGu0HS7URqSfMYj+o
	Qt2LShPUEIm3VHgpnGZKoZzfQniAU3R/SnqZu2BlacM9jztXaFGXrz2FLfphZwmX
	li3EmkF1dw87dQsOUIuRYcoxXzdrc5pYVDaDvcdfb3ZEE04iboOLGSQC5YDhDPMg
	/LKz1eTpV4IfGeKVz2d8km93W4vwZeyJTiRRBK70t7/DeGJ4LZBi9h7VnRFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722291154; x=1722377554; bh=E5F+gREmpO3rfAm2W13DEU5cr4oX
	c+JQE+AADW55Xew=; b=EDM/bfA4CH1FxweSeLWSi4smUOOBfdklY9YFCIISfMNa
	bNSPhdeR0WosLuUS7TsejXditj/EtBnOjrwZ3y/y8aF7m0j8KjIeTILb/ANioy2S
	kU/DijvcX0J2CXuGrE1BeEZgutZXbt9BJ1RHXNGmwiCgLUc54SkVts1w8Nk7aFch
	paRAB1b+ycFysfV5DtVvxoMw/i0DI8j7pl0Vnh9UKERcjyLboFqiFOrfDI8gawS2
	ABeJdo0v/yIOX/lofG4lhYf/V72aENIv9fda1MAxF+dYM1X4C6H4xENItXEKN4Wl
	ouxVrNg35KXMJdPssTOcS5fxxthGtg3L3S0DVbzTNg==
X-ME-Sender: <xms:0hOoZv7MFQsUALLTs8FueGpmN7qA7s2_D7wgyXBKmS-_DxL4vpVHfA>
    <xme:0hOoZk6YktRzeq9fi3ZZi5wMyuGRUQn9hvP64dfolLxPKzpzMf8SthC4V0p0scob1
    DQiu7HZ4XRgbi3td_Y>
X-ME-Received: <xmr:0hOoZmdFiTpDfXV4veBqqo32hlP9MatAKFjCII3ZxKZxoZ4602ufxgRD-_gsWJS_LuAmAiCrhuTRGtI7dvf3zAZVwz-MAKG88Xk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeefgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculddujedmnecujfgurhepfffhvfevuffkfhggtggujgesghdtreertddt
    vdenucfhrhhomheprfgrthhrihgtkhcuhghilhhlihgrmhhsuceophgrthhrihgtkhessh
    htfigtgidrgiihiieqnecuggftrfgrthhtvghrnhepjefgtdelledvfedtgeegffefueef
    veegjeekleegueejveevueefiefgiedvjeejnecuffhomhgrihhnpehkvghrnhgvlhdroh
    hrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehp
    rghtrhhitghksehsthiftgigrdighiiipdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:0hOoZgKDpNLRH1A_r4gMtk3908yiF647j9hYTzyhxVE0O6UXnZrTcg>
    <xmx:0hOoZjJY2zvJ2rBgwTVfMzmNFG50kKNtr8THiTaj5fl0fXNeXYFeow>
    <xmx:0hOoZpwVoLh78DRBtTe4MHzZve3OpfBEwMxQyOqSJDYbKyRd-rhc9A>
    <xmx:0hOoZvLsABapgAvRmTh5j6HRDbLwq5op42zngMcm-8ygXIA2xtU-nw>
    <xmx:0hOoZgBbcDCJASf9TI8G8XK0JtJO9-XjdPZ1DMcuGIcL_ppGrDDioSp4>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jul 2024 18:12:33 -0400 (EDT)
Date: Mon, 29 Jul 2024 17:12:31 -0500
From: Patrick Williams <patrick@stwcx.xyz>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 20/27] ARM: dts: aspeed: yosemite4: support medusa
 board adc sensors
Message-ID: <ZqgTz9DVPcqtTfUC@heinlein.vulture-banana.ts.net>
References: <20240723092310.3565410-1-Delphine_CC_Chiu@wiwynn.com>
 <20240723092310.3565410-21-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eSsDpaX8ks55v2Tl"
Content-Disposition: inline
In-Reply-To: <20240723092310.3565410-21-Delphine_CC_Chiu@wiwynn.com>


--eSsDpaX8ks55v2Tl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 05:23:01PM +0800, Delphine CC Chiu wrote:
> Add ina233/ina28 support for medusa board adc sensors
>=20
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../dts/aspeed/aspeed-bmc-facebook-yosemite4.dts    | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b=
/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index 98eeee49b082..49500db53a13 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -915,6 +915,19 @@ power-sensor@40 {
>  		reg =3D <0x40>;
>  	};
> =20
> +	power-sensor@41 {
> +			compatible =3D "ti,ina233";
> +			resistor-calibration =3D /bits/ 16 <0x0a00>;
> +			current-lsb=3D /bits/ 16 <0x0001>;
> +			reg =3D <0x41>;
> +	};

This depends on this unmerged patchset, right?

https://lore.kernel.org/lkml/4a1cb223-448c-3e93-eb38-d86f543659e3@roeck-us.=
net/

Please resolve the issues Guenter raised.

> +
> +	power-sensor@44 {
> +			compatible =3D "ti,ina238";
> +			shunt-resistor =3D <1000>;
> +			reg =3D <0x44>;
> +	};
> +
>  	temperature-sensor@48 {
>  		compatible =3D "ti,tmp75";
>  		reg =3D <0x48>;
> --=20
> 2.25.1
>=20

--=20
Patrick Williams

--eSsDpaX8ks55v2Tl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAmaoE88ACgkQqwNHzC0A
wRnlOQ//aSDDwetaxVuBFIXvnhb6qUZljuoBopqlxpXwzllq1kf49dytSuzQ2QNF
USKmp2hnM7LZEBKJWvp0GSnt5Lw7y4jcTmPcvVwB99kV3295Tz5tv8QteCG5vzaH
3DoXI3fNuM8NOa3gR6iOjPm9SP6IBkkN8i4pgVzoa20McRjCGhJotCXUUO1GD9Sq
zIf+abvejMNN8EY+sdoVtR2PdvGLe2F3vheb7glV+NSXjnWZGK/NF4/NIEi95L4y
FP1TG6aW6xgxoX+MnPwuHySobvw7qaXb2n7DTIzXsFpLb3mcOkaz6Qx1/BlDvmXP
ymiPtPhFrWyjCWB3ozKtssWxfB0OU/KVMfxYabqzzMIWZ5A/dFf4IgS4qfGp/9Tl
sI052J6/6En/l4MgsiAEfxPxknhsbmKk92/kMLoBrBvgImx+lL07Ce2RR+j25iNN
LZiqay9b+PecdW6AKcelHV8MGTAgQ61ZsjDYm+eRomCR9fKrEvUmagAXGEF0UxWt
eBR9DnMu8enst+Q4Lmej9+K2xAgm4l4wMiVYCUjTfe/7UOh0RoM2zwn2kpue73sD
EtxgX1njoNP0y3+S5/WK7337Pd2UvbvuqOwJ49w6PgvBwwQPqMwEq2jFUA+nOmv0
pLJCuQv18lf6UhiVisdV6hJe6xZ3R8VnChGPpyO+yoD4oavcA7k=
=AbXz
-----END PGP SIGNATURE-----

--eSsDpaX8ks55v2Tl--

