Return-Path: <linux-kernel+bounces-266501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3D99400D0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 00:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55601283786
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 22:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD7118E743;
	Mon, 29 Jul 2024 22:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stwcx.xyz header.i=@stwcx.xyz header.b="ghiNgKzF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XYDWeQvN"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17A21B86D6;
	Mon, 29 Jul 2024 22:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722290610; cv=none; b=TRulJc607ThYWFjKtFt17UwQleIdithXHuE9tsexD8EVt/f+JhrUYqgB0kqyllwtGNf72sxCO+J+sIcWf+2jDMob6HLWX0/U4Cq6VkGvsArlnlXBNP8aptP4ZAWUqTYqLBbwPN+zEV4Lh7lZdHjPjujw3thEyratKU3OjAGgRzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722290610; c=relaxed/simple;
	bh=ROcRg0KFhN8r6j4xsLw04EX7NmQN33F5dqFZ4waAK7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJ6gWMdIo9Xz+BmcOZ8JugQMXT1OoqpPpCoPQ89GM20eoyp2WoH76PZaVZ4qHwTxbM/n1ET+GBXvVyNVudGmWtK4ljJA2mOQS+NA7OFC0F+JQJ36/yq9JyHz+rl4a6Dd2Uli1pq/8SCf3RgPB3alV+zPiyptOamNgSjJoAEbsRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stwcx.xyz; spf=pass smtp.mailfrom=stwcx.xyz; dkim=pass (2048-bit key) header.d=stwcx.xyz header.i=@stwcx.xyz header.b=ghiNgKzF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XYDWeQvN; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stwcx.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stwcx.xyz
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 50F9C1380098;
	Mon, 29 Jul 2024 18:03:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 29 Jul 2024 18:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1722290606; x=1722377006; bh=VjPyELCCVA
	p8GD4brdOAygR7b9CF1TOQ2OxSnfbzxpc=; b=ghiNgKzFqWCljYzdeutQBEQahf
	w0dMtX7V2LpQhf6DVVUDNa1AMTGSRdVfD1QzbBqV7mPW+2O78KG2P2fbZSIG9RVd
	3JEVVjNj9f6VjqOgNT5rns2nzoaLrECCxW5nJCIJatXEPj2HyX3XZUfUdvsppXI6
	QeGYEJiSGQYkg1onJ0F5gF134EM/xNdrheF1VbzWmoP0zZlE3eOVCc4Il7gl6MPr
	RFhZIPLfkg5JroExmr9poa/TxMvTIbKX+UiNYKjmWOGBuYESLe8lKVcfaHfTq0hb
	HAko1QMFdNvupzx0Ks+viy3DhnBWP/37SyjrHZavCVgUiBNdQj0gWu5KNSZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722290606; x=1722377006; bh=VjPyELCCVAp8GD4brdOAygR7b9CF
	1TOQ2OxSnfbzxpc=; b=XYDWeQvNQdCSJbhAp/9rsl707f+XNxahPc0G+FyRDJ6w
	V/P8CLfLOciyzS85m9lu2C/eCKKwYBIm6oVbC3IqdOzx0y/0NWpvAHy4BMzJ2mU/
	AUlbLj2gQpTSAdux4J6K9+g2Y/koBcvgx0aigKr5vOzHRZhQQTFsPTDOgO0A8/pD
	GWqiMw4xup4kOWd2wDceQvb9NKB8/otFypSzoTAVrWoYtSGmG/ZICBuqNCKM1XE4
	P1ZNiieLdWllVTPktyB5N2iRIcFltD5q/VLCzn9ZU1cBXK1kaITbvY3PFvceBi/0
	heg/MRG6RDkPahclW6OoQHNGlMxjjqsLvkggb+PLiQ==
X-ME-Sender: <xms:rRGoZu0uSsACTw0MSEwhrs6IKpELTZxMJMr7zIA4A28RxF49eXJzEQ>
    <xme:rRGoZhEFMZYuSbDGxl8vqI_zvHdKENwmpm0QWnD_TkH0PdHeTJZux46RhRQuK7F1x
    CBrd2JXiUVJArf7Wj4>
X-ME-Received: <xmr:rRGoZm7GeF5D0a0MeBCbNiPy0jIpfXDP2UXWQpePcgf0nCqsJDSfeHuZYZe3naNreB-GD0BUiFTvJZy8jEJ9dr2rTIMQYv91U4s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeefgddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculddvfedmnecujfgurhepfffhvfevuffkfhggtggujgesghdtreertddt
    vdenucfhrhhomheprfgrthhrihgtkhcuhghilhhlihgrmhhsuceophgrthhrihgtkhessh
    htfigtgidrgiihiieqnecuggftrfgrthhtvghrnhepheefjeehfedtjeeivdefkeffheel
    udekudelleffkefgtdeludelvddtgedtheeknecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphgrthhrihgtkhesshhtfigtgidrgiihiidpnhgs
    pghrtghpthhtoheptd
X-ME-Proxy: <xmx:rRGoZv28_lHbPUF0zCB61iGQCpRfMtLgvsLC-gWdOmDpCSu5ppdSKA>
    <xmx:rRGoZhGKwaIuLhqwqypbm5fco7Y4egGtvmdIakKnw8EZ4vHrnuASmw>
    <xmx:rRGoZo-rBbVb04bKi_qOGQq1DJxexwgJ11NWqFC6p7GPSZktCLHCVg>
    <xmx:rRGoZmkX_sccaKUq3ahIw3LTO40H5FspPJSOC8PLdj7V5qMetUV-pA>
    <xmx:rhGoZp_CUlY4yjJ4E3o8jUHF6sDREhUivgZbmwdCasHIU5i5BaDJYqt_>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jul 2024 18:03:25 -0400 (EDT)
Date: Mon, 29 Jul 2024 17:03:23 -0500
From: Patrick Williams <patrick@stwcx.xyz>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 25/27] ARM: dts: aspeed: yosemite4: add RTQ6056
 support
Message-ID: <ZqgRq4h0HWClxSEW@heinlein.vulture-banana.ts.net>
References: <20240723092310.3565410-1-Delphine_CC_Chiu@wiwynn.com>
 <20240723092310.3565410-26-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bXkOT6UHBEHOiAfs"
Content-Disposition: inline
In-Reply-To: <20240723092310.3565410-26-Delphine_CC_Chiu@wiwynn.com>


--bXkOT6UHBEHOiAfs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 05:23:06PM +0800, Delphine CC Chiu wrote:
> Add RTQ6056 (spider board 3rd source) support in yosemite4 DTS.
>=20
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts  | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b=
/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index f73719b3c2f1..03a1e41312e3 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -1240,35 +1240,35 @@ adc@37 {
>  	};
> =20
>  	power-sensor@40 {
> -		compatible =3D "ti,ina233";
> +		compatible =3D "ti,ina233", "richtek,rtq6056";

Is this legal to have two chips both listed as compatible?  I thought
this approach has been rejected before.

>  		reg =3D <0x40>;
>  		resistor-calibration =3D /bits/ 16 <0x0a00>;
>  		current-lsb=3D /bits/ 16 <0x0001>;
>  	};
> =20
>  	power-sensor@41 {
> -		compatible =3D "ti,ina233";
> +		compatible =3D "ti,ina233", "richtek,rtq6056";
>  		reg =3D <0x41>;
>  		resistor-calibration =3D /bits/ 16 <0x0a00>;
>  		current-lsb=3D /bits/ 16 <0x0001>;
>  	};
> =20
>  	power-sensor@42 {
> -		compatible =3D "ti,ina233";
> +		compatible =3D "ti,ina233", "richtek,rtq6056";
>  		reg =3D <0x42>;
>  		resistor-calibration =3D /bits/ 16 <0x0a00>;
>  		current-lsb=3D /bits/ 16 <0x0001>;
>  	};
> =20
>  	power-sensor@43 {
> -		compatible =3D "ti,ina233";
> +		compatible =3D "ti,ina233", "richtek,rtq6056";
>  		reg =3D <0x43>;
>  		resistor-calibration =3D /bits/ 16 <0x0a00>;
>  		current-lsb=3D /bits/ 16 <0x0001>;
>  	};
> =20
>  	power-sensor@44 {
> -		compatible =3D "ti,ina233";
> +		compatible =3D "ti,ina233", "richtek,rtq6056";
>  		reg =3D <0x44>;
>  		resistor-calibration =3D /bits/ 16 <0x0a00>;
>  		current-lsb=3D /bits/ 16 <0x0001>;
> --=20
> 2.25.1
>=20

--=20
Patrick Williams

--bXkOT6UHBEHOiAfs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAmaoEakACgkQqwNHzC0A
wRllJg/8D0+FcC+HnpCDyCMQIlzeZjWQHJwsQ+gAQnniXua4BX1ViSqRQCflaEjq
Ro30E3wAQMWVN9ZnXJ2hUndBEPH+o59gS7iJhrr8pRv7co2yVA7MqgCkK4HD0eWw
NWrguDAy/iPbbzUSQv1S8PVje7YwTOxe/4FZFD7Bv4qQyxvLBXlQpTwk959Rh96M
AD+lflRovhD65652++Y7HjTlT0YYFC9q4nowhm+9Hn7OmE1eevPBL8kuujPTYIgK
0nbcAXB3TkxnKyvjz1R/LBiabphsK/ZKuxBefmQfl+4+PUxibfi/6nqvIBipp6cu
kR7kXYQJ7A+4Al1NSji5in7vj/F5FJDmo+0F3lLfzUZTWk2ObKgdDW96R/xU5r0G
yI5KbKYzfV9maDqx/XBRDmOfAMKb2OSbR2Ssu7FMkI52dKGBlQJB4VW7yqojtfz/
Rin3U0YDKr4QPNTYe8zIzOsy6qOoQRNCrT3dnpCDI8azLVoZ90k5Aw4UIGr1f8uN
1H+CtyxAmsVkd40pD4cgbXcTokTt34l1XGnzij8y2OU+VIOHEo37aR8taYJY7JL5
NIFuyErSfvOHFNzR71H/hkYrqG35e/qm49KJpRx02bMkF0EopPKxucsG35710I2z
9BSnk3xZxDBVvfDjrxl7B4K4kjsDwaJgON2sLyog+rou8+VOOCE=
=auiB
-----END PGP SIGNATURE-----

--bXkOT6UHBEHOiAfs--

