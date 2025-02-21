Return-Path: <linux-kernel+bounces-526254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0AEA3FC43
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 465F786510E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938E31F3FD9;
	Fri, 21 Feb 2025 16:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rp2vPOQr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5BA1DE4C4;
	Fri, 21 Feb 2025 16:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740156579; cv=none; b=GKyPOF79p42jwkKvZI1uEXk/yLl4MpDL8k7DgsTo+voo7Gmw3wFoPCie9tG9/zUY2BHYDOvXreM+zHZ1yPwDLT9yuzL2ekInndF2ocZ6Ib1Kqt1mWEEYz+uuaKX7SvAnaXLLXowt+Iw7YLVOWI5dYMcT9WYq0+DJbZO97atR648=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740156579; c=relaxed/simple;
	bh=LZcc3xE+bYEK55np85IMurfVHwUqpCnyi8vtv/PpdQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmcSIwTTGB2CYKPwO5kmP6SOvulRj9K4T2Q+QuvohKPtdY6UoOyPT1jPX3AzpjYg263+DJFwoqdHm9kKgNgI2Wc4svuO4yiRwy0IEZHTTSd2Of4NhiE4HPHzxfzWhEGDsZWNerq7Low8ePCv0s4+XU7dfbfrmtQzDI2DRxtWktk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rp2vPOQr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A5BC4CED6;
	Fri, 21 Feb 2025 16:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740156578;
	bh=LZcc3xE+bYEK55np85IMurfVHwUqpCnyi8vtv/PpdQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rp2vPOQrQ29Vfc3Ynj2C+4zTDvYyvoemivprsObQqI+vqGXZz4g58MEhMx9/Id/o8
	 KD9BDfBAG676amR0oTHqVAKIeTgHvUIhcPv4BJ14ESxbCX7VEknqPf4nHupDZGob1I
	 I5R3CCLdn6eFgZdWa0X0w0a0PMA6dd47prUY+TLWjhU4rSGGIDNLqGwPZP+F6XGQ3Y
	 upQT7kpm0731n6D+yusSeUpjRK7kdo7EqvX9X3X4/dvePt6/IoYquPvf2iAj2B3/G+
	 dYIKOTXIVxzyaYstFvbjhoAd6k2bJQXqtWJPV6vcjB3rE6BBeOT/qCu2dWp6K5xRAb
	 Y5Na8NYVA/dpw==
Date: Fri, 21 Feb 2025 16:49:32 +0000
From: Conor Dooley <conor@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof@spud.smtp.subspace.kernel.org,
	Kozlowski@spud.smtp.subspace.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>, Aradhya Bhatia <a-bhatia1@ti.com>,
	rafal@milecki.pl, devicetree@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Noah Wang <noahwang.wang@outlook.com>, linux-kernel@vger.kernel.org,
	Peter Yin <peteryin.openbmc@gmail.com>,
	Naresh Solanki <naresh.solanki@9elements.com>,
	Alex Vdovydchenko <xzeol@yahoo.com>,
	Grant Peltier <grantpeltier93@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 1/2] dt-bindings: vendor-prefixes: Add prefix for
 Liebherr-Werk Ehingen GmbH
Message-ID: <20250221-seventh-improving-9d22a8dc5108@spud>
References: <20250221155418.1167670-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YxlxIO2ZW2QARODV"
Content-Disposition: inline
In-Reply-To: <20250221155418.1167670-1-lukma@denx.de>


--YxlxIO2ZW2QARODV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 04:54:17PM +0100, Lukasz Majewski wrote:
> This entry adds vendor prefix for Liebherr-Werk Ehingen GmbH.
>=20
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index 5079ca6ce1d1..20ea550ac328 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -882,6 +882,8 @@ patternProperties:
>      description: Shenzhen Lunzn Technology Co., Ltd.
>    "^luxul,.*":
>      description: Lagrand | AV
> +  "^lwe,.*":
> +    description: Liebherr-Werk Ehingen GmbH
>    "^lwn,.*":
>      description: Liebherr-Werk Nenzing GmbH

What's the difference between these two?

>    "^lxa,.*":
> --=20
> 2.39.5
>=20

--YxlxIO2ZW2QARODV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ7iunAAKCRB4tDGHoIJi
0m6PAP4n2q6CP9SXtajAqIwWnkFMsQ5QaG3xI7VxFwiUPl1f4gD+O86x5FLHEMb0
ypIa22KxTxq2ljxYNBobpcV7iyBXtgY=
=2Nd7
-----END PGP SIGNATURE-----

--YxlxIO2ZW2QARODV--

