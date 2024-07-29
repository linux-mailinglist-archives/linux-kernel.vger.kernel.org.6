Return-Path: <linux-kernel+bounces-266514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B4E9400F8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 00:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16533B2296B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 22:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220B218EFD3;
	Mon, 29 Jul 2024 22:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stwcx.xyz header.i=@stwcx.xyz header.b="SIpU2toi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ETzh5aNT"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A571B13CA95;
	Mon, 29 Jul 2024 22:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722291241; cv=none; b=VmQ/sy7o8b55F0SxlFNtxXuln3GyPtrbfs+x7YQ7U11uhpKyw+T+7USnsWz+Op+SamQNJ49buBLUcodqUUnROLEVVFmtiw8HkPSl/4fbjlDJky6bD4cAo0VeNnZeP8gG+6m1nMWQd6xs9e8IXh9RH3YL7BuH0uApfVyu+T6VVoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722291241; c=relaxed/simple;
	bh=/GiqBUZ+b/VHuExA13zrP02UK/q78wz/oS37DGrIJWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4qJ+dYZ30At/IUpIm8qxe6i7wWgBBmAAYLLIaDAW8C9y1THyCogHIxS7ZEGi+qVtKdbwS7qKwFbAtHh+7USFIMGg32/r7EG33SV69gZvGAKub1twoEUSBMiBw6OdM+JXCWT7YC5MWViYGrrh7h2Sj1H+3T9b+xEemyad8+slYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stwcx.xyz; spf=pass smtp.mailfrom=stwcx.xyz; dkim=pass (2048-bit key) header.d=stwcx.xyz header.i=@stwcx.xyz header.b=SIpU2toi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ETzh5aNT; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stwcx.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stwcx.xyz
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id AEB271140173;
	Mon, 29 Jul 2024 18:13:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 29 Jul 2024 18:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1722291238; x=1722377638; bh=o6f35FGbRX
	3HYwT2sGwTeX0CuYGqxQLvmZNgaY9UvWc=; b=SIpU2toiS/hfjKdiqmChfTADi9
	hsOjixaK1p4zZv7FT3iuL3+vnyw1YvsCsCs8B+i1gZ06psszUM9FgLT38S4Pim/s
	Mza17g6V3hgY4AplD/sSsIRVGski3Xs/M6m9xcZhnxU3EzBk32JFfxxJjhQ4IQ/8
	vrlGTug/Fo6H4emHraZI/U8XOYvZ2DJIP1irHf8Qm4IujRKfsxVIelGztFfcEdmT
	BCOQYnqM3rsO6GneeAAlFwdJh2yXZVfAXhdL47FR/Q4zxdvlzNiFlNkS4+3+B+wb
	ED0gsGuZJjWC7m8klG4kbM835UU/zMvxkmxVPDTRJuYEmZ7FaEznHWq1lcWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722291238; x=1722377638; bh=o6f35FGbRX3HYwT2sGwTeX0CuYGq
	xQLvmZNgaY9UvWc=; b=ETzh5aNTS79WcY6DtcK9ce0ny0XcetsmX+OimnnZ1di9
	JLbpxz4WvMf59XUysj+KThigxS1mh3FcXPnOaliGgfHLo3EcuVx1rFjU1s5/niWn
	3HnRdzHEXewGR2tCtIcsr1gAVaT4S55UOo3V/OSJwmd2rN3/Xn03Q5wU5qdtxCrz
	MYX4kevO9zcCKyqOgS/ijF/6aFrLmlD37iLruI/dsVZVl9RidSAZ9vvNoCeh12aU
	WiFsH3nd+0MDocHuMr7TtwguD7kIL/+9H9JgCcjpPdtIoEG5D66hwGcEhCRmiEzy
	3qmt4N6LyoMweLWHl2tdxEKoOJxPdOTf0hw+Ilcapg==
X-ME-Sender: <xms:JhSoZvnkpW7G8zptuumaxcomhIu5CX1sHS72BB_b9gEgqIW5quCYIg>
    <xme:JhSoZi1Q3HMKyY-MThkfoihvcASvSLMqy8ylOQ54d8_H_WKxF6DWsOoHAcHvUK9zc
    fcLVzS3Jq6j3fSUrYk>
X-ME-Received: <xmr:JhSoZlrpsiuu_JgZtEfjbkEVQ7X9Rmp-Rg9L2Bj54Mwf3_G5zSsvK7z2WNwWO4XdSs7ICU8v_xGbfraGl4zFZngR-9hSlFUT04E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeefgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculddujedmnecujfgurhepfffhvfevuffkfhggtggujgesghdtreertddt
    vdenucfhrhhomheprfgrthhrihgtkhcuhghilhhlihgrmhhsuceophgrthhrihgtkhessh
    htfigtgidrgiihiieqnecuggftrfgrthhtvghrnhepjefgtdelledvfedtgeegffefueef
    veegjeekleegueejveevueefiefgiedvjeejnecuffhomhgrihhnpehkvghrnhgvlhdroh
    hrghenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehp
    rghtrhhitghksehsthiftgigrdighiiipdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:JhSoZnmjr8hHI1jDOOrGbffy60qMrc0h85L42FmgR8neXI3LPDjqhA>
    <xmx:JhSoZt0Udx00YIvO3AJjlqAswmLiRp7k3GBov6M4QJ_yY8JnbLSZ8A>
    <xmx:JhSoZmsMFevb-J9zlZH9iKak3o6JN951qLRYEAFL7Go_AvOH8CLZpw>
    <xmx:JhSoZhX9X7DkWCBzBO0Y_eU67MmSbHQU4XdHBTJGEwELrrLN3_jmOA>
    <xmx:JhSoZmuY8E3WXhnnosL9mEGzeY4Hokak1jC86Sr-cW2qhYDiweshaIKZ>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jul 2024 18:13:58 -0400 (EDT)
Date: Mon, 29 Jul 2024 17:13:57 -0500
From: Patrick Williams <patrick@stwcx.xyz>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 14/27] ARM: dts: aspeed: yosemite4: Revise ina233
 config for yosemite4 schematic change
Message-ID: <ZqgUJVR-j-Valq0_@heinlein.vulture-banana.ts.net>
References: <20240723092310.3565410-1-Delphine_CC_Chiu@wiwynn.com>
 <20240723092310.3565410-15-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tn2PN9Vkj7ndz+5T"
Content-Disposition: inline
In-Reply-To: <20240723092310.3565410-15-Delphine_CC_Chiu@wiwynn.com>


--tn2PN9Vkj7ndz+5T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 05:22:55PM +0800, Delphine CC Chiu wrote:
> Revise ina233 config for yosemite4 schematic change
>=20
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 20 ++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b=
/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index 1765a0bb70d7..df389b506b4b 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -1034,28 +1034,38 @@ adc@37 {
>  	};
> =20
>  	power-sensor@40 {
> -		compatible =3D "ti,ina230";
> +		compatible =3D "ti,ina233";

Also depends on unmerged code?

https://lore.kernel.org/lkml/4a1cb223-448c-3e93-eb38-d86f543659e3@roeck-us.=
net/

>  		reg =3D <0x40>;
> +		resistor-calibration =3D /bits/ 16 <0x0a00>;
> +		current-lsb=3D /bits/ 16 <0x0001>;
>  	};
> =20
>  	power-sensor@41 {
> -		compatible =3D "ti,ina230";
> +		compatible =3D "ti,ina233";
>  		reg =3D <0x41>;
> +		resistor-calibration =3D /bits/ 16 <0x0a00>;
> +		current-lsb=3D /bits/ 16 <0x0001>;
>  	};
> =20
>  	power-sensor@42 {
> -		compatible =3D "ti,ina230";
> +		compatible =3D "ti,ina233";
>  		reg =3D <0x42>;
> +		resistor-calibration =3D /bits/ 16 <0x0a00>;
> +		current-lsb=3D /bits/ 16 <0x0001>;
>  	};
> =20
>  	power-sensor@43 {
> -		compatible =3D "ti,ina230";
> +		compatible =3D "ti,ina233";
>  		reg =3D <0x43>;
> +		resistor-calibration =3D /bits/ 16 <0x0a00>;
> +		current-lsb=3D /bits/ 16 <0x0001>;
>  	};
> =20
>  	power-sensor@44 {
> -		compatible =3D "ti,ina230";
> +		compatible =3D "ti,ina233";
>  		reg =3D <0x44>;
> +		resistor-calibration =3D /bits/ 16 <0x0a00>;
> +		current-lsb=3D /bits/ 16 <0x0001>;
>  	};
> =20
>  	temperature-sensor@4e {
> --=20
> 2.25.1
>=20

--=20
Patrick Williams

--tn2PN9Vkj7ndz+5T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAmaoFCUACgkQqwNHzC0A
wRkdlQ//Tfv3Pcop9q6NY0vNA8BdnwlPcz/9tbDetHCpb0HAtt6LhhgxzY1WjFpI
4A1KLFIRZmJjSOlon6dhDJB1bVKZbSyftBoQmBB3vE93CH8F+EabLDo+NbCtL0xO
mQiZITAhoS7BDpD7Te8s4jq6Pd7pxB03XR0YuVpWN/yQe7QzJHsHQ2Z96v1yqf07
gcLBGMwvyaQlCVXvBilMaheXRb8Mk49HPW8n/tDi+tD1IEnE9CdnXcsmTThm/uIr
ARAEzPPM9rCKhKVMWKFb4x2bSK3mrGdVZ0LWMycGN498D0n69dDlM2n6V+szbFnZ
G3gDfxsi67i2IJxC27dY48yxSyFfUDWuXTB/nbGGbLfmTsjZ8HtdgjZrewZAPgHG
1G91xHeCtByuaazTSKa2dbBc3R/GwF/S0mB2OyTA2EcWRWY/iju2SQJer5irxSWB
StqQC784DdPpsdwwVS1o6bLiMbHGOM3M8azuuHvUaHQa2XVcYOTQRA02pJKmPbMw
6a/1QKZMfuXjaQFFsezn/tgVJJzEsAmqTanzypPDN6gK/rfYMdNBNYL5/Nid5raG
TlkGV6u3eZDOJSDSH35K8pGsRmEcW/3I+EdyLcFXf7z2blKuGaghfvEBO3qlge2w
fkOj/J17T9R4LwriDEL/86RU/PcnnAFXhlN0T3rLj0NW/HCkjiw=
=0KZW
-----END PGP SIGNATURE-----

--tn2PN9Vkj7ndz+5T--

