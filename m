Return-Path: <linux-kernel+bounces-201114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D348FB9C0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D8D81C23278
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DAF1494DB;
	Tue,  4 Jun 2024 17:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ip1BNRF/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDB64A11;
	Tue,  4 Jun 2024 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717520489; cv=none; b=m6BETPiIlTq14lu6hG+XlwlQHsdINbsjG9Sa3p0rQ5G3KzsuEeFn/OLY7FYITrL7eqc3sbMvPLBcK6fd+MgimMQieF+PjSO3mSHMheS4/hqCGSrEK9iTZyJ0UMCfaSB4sp7msXiQGiynB19L67OSwh0Mai8jKnSgmdmjNs5/zzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717520489; c=relaxed/simple;
	bh=R6BbQWmZ4P9fschyN5itAlWnBsUdPsq0nefia1AQqJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCWCDM1SaJ8j4QK7IkWaROFiyBuMGJE8GrIvDryv3OGVX1sq6o6efLdLh5aYeIZGLnAQQjsaATRZliMdln5vimjmEcV3JL4f37NV4VgA+2rntbwxz5+AD91XTEzDGobNBvVMELSc65VK0r6PREE4Ua4oU2Vf5Pg7aP+uHq1XKnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ip1BNRF/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D40C2BBFC;
	Tue,  4 Jun 2024 17:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717520488;
	bh=R6BbQWmZ4P9fschyN5itAlWnBsUdPsq0nefia1AQqJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ip1BNRF/dND0ElXHf+t3tJJ9w39d706EeHlpD8aicjNPUPRAQKV1tZn3o8oe0G6i9
	 Zc7suHix4wIxOTZ3KsvuBg9DIKFwDR05kqn3rnIuH5l0VQ3D0YJvFlGfplOUHdh7GM
	 Zwc95653ntre+06ZScGg3XT8JwDnX+VFVBJ19hZx1EiAm+8Faz7bLuty58k+1vIV05
	 bhQQa/hpD8CWXsul+EQoTlhF5fQUH96vAoC+UtmvijgO49t/FFhiPp4/FGEB2s4Wjn
	 CJnbBCJvjEDub39mjIdALz7Fh01rbRZy8IvrQTnDT2QVjGCQrsQAd0WwDnOEoI26Lk
	 7lguoLO8//HdQ==
Date: Tue, 4 Jun 2024 18:01:23 +0100
From: Conor Dooley <conor@kernel.org>
To: Michael Walle <mwalle@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Thorsten Scherer <t.scherer@eckelmann.de>,
	Marek Vasut <marex@denx.de>, Imre Kaloz <kaloz@openwrt.org>,
	Andrew Lunn <andrew@lunn.ch>, Flavio Suligoi <f.suligoi@asem.it>
Subject: Re: [PATCH] dt-bindings: mtd: spi-nor: deprecate Everspin MRAM
 devices
Message-ID: <20240604-ladylike-gout-6fd6ae992712@spud>
References: <20240604074231.1874972-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HGv9EZxHu5PamIl2"
Content-Disposition: inline
In-Reply-To: <20240604074231.1874972-1-mwalle@kernel.org>


--HGv9EZxHu5PamIl2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2024 at 09:42:31AM +0200, Michael Walle wrote:
> These devices are more like an AT25 compatible EEPROM instead of
> flashes. Like an EEPROM the user doesn't need to explicitly erase the
> memory, nor are there sectors or pages. Thus, instead of the SPI-NOR
> (flash) driver, one should instead use the at25 EEPROM driver.
>=20
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Cc: Thorsten Scherer <t.scherer@eckelmann.de>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Imre Kaloz <kaloz@openwrt.org>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Flavio Suligoi <f.suligoi@asem.it>
> ---
> The referenced binding only supports the true AT25 compatible EEPROMs
> where you have to specify additional properties like size and page size
> or cypress FRAM devices where all the properties are discovered by the
> driver. I don't have the actual hardware, therefore I can't work on a
> proper driver and binding. But I really want to deprecate the use of
> these EEPROM like devices in SPI-NOR. So as a first step, mark the
> devices in the DT bindings as deprecated.
>=20
> There are three in-tree users of this. I hope I've CCed all the relevant
> people. With the switch to the at25 driver also comes a user-space
> facing change: there is no more MTD device. Instead there is an "eeprom"
> file in /sys now, just like for every other EEPROM.
>=20
> Marek already expressed, that the sps1 dts can likely be removed
> altogether. I'd like to hear from the other board DTS maintainers if
> they seem some problems moving to the EEPROM interface - or maybe that
> device isn't used at all anyway. So in the end, we can hopefully move
> all the users over to the at25 driver.
> ---
>  Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/D=
ocumentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> index 6e3afb42926e..2dccb6b049ea 100644
> --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> @@ -21,7 +21,6 @@ properties:
>                (m25p(40|80|16|32|64|128)|\
>                n25q(32b|064|128a11|128a13|256a|512a|164k)))|\
>                atmel,at25df(321a|641|081a)|\
> -              everspin,mr25h(10|40|128|256)|\
>                (mxicy|macronix),mx25l(4005a|1606e|6405d|8005|12805d|25635=
e)|\
>                (mxicy|macronix),mx25u(4033|4035)|\
>                (spansion,)?s25fl(128s|256s1|512s|008k|064k|164k)|\
> @@ -42,6 +41,14 @@ properties:
>                - spansion,s25fs512s
>            - const: jedec,spi-nor
>        - const: jedec,spi-nor
> +
> +      # Deprecated bindings
> +      - items:
> +          - pattern: "^everspin,mr25h(10|40|128|256)$"
> +          - const: jedec,spi-nor
> +        description:
> +          Deprecated binding, use Documentation/devicetree/bindings/eepr=
om/at25.yaml.
> +        deprecated: true

The idea here seems okay, but directing people to use the at25 binding,
without actually documenting the replacement compatibles etc is far from
ideal. I think even a wording change that points out that that these
devices need to be documented in that file would be an improvement, the
current wording makes it seem like the works been done.
Until there's a replacement driver, I don't think you could really
expect anyone to move to a new binding anyway.

--HGv9EZxHu5PamIl2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZl9IYwAKCRB4tDGHoIJi
0teVAP9+WE9Aa+SjNHv9SwetwqU+ib6o+pUyU7AnhGLRW5bKSgD/Q9iMrnHzSIg3
MshQhm2puWAwgGZUaoE1eXPubreqxww=
=z7/H
-----END PGP SIGNATURE-----

--HGv9EZxHu5PamIl2--

