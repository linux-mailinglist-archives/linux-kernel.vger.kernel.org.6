Return-Path: <linux-kernel+bounces-437334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CB79E91F1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC04C161CBB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8641C21767E;
	Mon,  9 Dec 2024 11:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="gkNTOy1i"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561D72147FF;
	Mon,  9 Dec 2024 11:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742983; cv=none; b=W038mxq6BMT6EjcFZUSc+lToMk59GOjYAZzNkZCcvx4PPf1PppeUXLlkC5owv37Lg9NiVvOSSs5ixxYQ7nJnHAZUZDPNeyhOSejexIFmrmAohevQb/JfOHk4c/pHExijlvznpUkb1ilqbL/FLCAzzRmwNl4pzwpAPqyg9ccZz30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742983; c=relaxed/simple;
	bh=VXDgpV43oBqhloYTfWbndUbcKl+eiskjcLfIgvtPKVI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DiCO1pOadM5jNnf37ELILw3sxhamnot8jo6FbR8qQ2qgDAoutcFi3A7QRgrP14XtLrJTFihGMuWDwVfEhePlFvtJKTRl2y8xmxF6kXcYFdOUQEAd9mp0AHonjxSpX1xPJ+NN3ikrvGJZ83lRop251k9pGvSn1BdE/9+zmvXSXNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=gkNTOy1i; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (095160158109.dynamic-2-waw-k-4-2-0.vectranet.pl [95.160.158.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 7BDE6888D5;
	Mon,  9 Dec 2024 12:16:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1733742980;
	bh=BuMhiC0OhEfpPn44QIc8qMlaFvp2wk3+ZDJWj+PnNQI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gkNTOy1idlOOFdrQ8uawL2OO6XsQ3+vYNDYjvlh5yAxwGmyL3ojcnrV880kfujf1o
	 Oa6EjJ1p9HieoK3rQhHyB0hzjIkitFlBRJzm2CAaMIicc0ioQIrL9iRJTYq2RVktDm
	 sSC7aCb4crgGekjuQbs9yhMI1rA+HuvyehXvi/oTJjgNM6EEARaAeSMwBQ9Lh/kcVh
	 D+Lx6PdOWcGpX/ikTclmufyxRJYo47yAI0D0g6Uqi6jRa2/O5BA2LuimbuTqjn0zNT
	 FvZTJU0YGZI76OJfALGsITRdJxH//e2mbjp8wqwEfu8TYztbI/fDxfQu7saINd2hco
	 QmVZ+lobvzuoQ==
Date: Mon, 9 Dec 2024 12:16:19 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 3/3] ARM: dts: mxs: Add descriptions for imx287
 based btt3-[012] devices
Message-ID: <20241209121619.623886a4@wsk>
In-Reply-To: <c8fd371f-fd36-48c4-ad49-1e8f8db01383@gmx.net>
References: <20241107085705.490940-1-lukma@denx.de>
	<20241107085705.490940-3-lukma@denx.de>
	<20241119165236.69438f75@wsk>
	<c8fd371f-fd36-48c4-ad49-1e8f8db01383@gmx.net>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jBN468d=YevV1Tnfk/xCbGe";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/jBN468d=YevV1Tnfk/xCbGe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

> Am 19.11.24 um 16:52 schrieb Lukasz Majewski:
> > Dear Community,
> > =20
> >> The btt3 device' HW revisions from 0 to 2 use imx287 SoC and are to
> >> some extend similar to already upstreamed XEA devices, hence are
> >> using common imx28-lwe.dtsi file.
> >>
> >> New, imx28-btt3.dtsi has been added to embrace common DTS
> >> properties for different HW revisions for this device.
> >>
> >> As a result - changes introduced in imx28-btt3-[012].dts are
> >> minimal.
> >> =20
> > Are there any more comments / suggestions for this patch set? =20
> I've send my RB for this patch on October 31th for V10, but it didn't
> made it into V11.

Sorry, I've just noticed it.

When the yaml patches are applied/accepted, I will either resend the
dts patches with your Reviewed-by or maybe this tag can be added when
applying the code by the maintainer (Shawn).


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/jBN468d=YevV1Tnfk/xCbGe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmdW0YMACgkQAR8vZIA0
zr2THAf+JgmJiwwSis3XQnIdKHJG+zMF3IYWmEQqljal+UWYz6CmPygErJFdSZI9
p7Nj+OtF4Vnv4gCGw2WSRHiQD4tA1gjFXmLByhkaTke1vKEa6kSbQTb9kvFAT6Ss
O95SBMZoePdu4c1uEYpSvuYNUVPkImpw+Is20TjrLHm/Jepxbpjh445DaKhNYQQR
kC9Hb1i1uum13rH0gRwT0HRCXqlBwAYZTMXdqR4gwc3ogJVLsvuY0ujC+1JNNmmp
BkYM22XM7CY5qeIa0PUEBwS9C2UQwsPWw1KQ4NgZ/1uEN+4iFkNNFGBgWzqeL+wn
pmTLrePIuUqCthhv5c83HpXCfamRVQ==
=8U55
-----END PGP SIGNATURE-----

--Sig_/jBN468d=YevV1Tnfk/xCbGe--

