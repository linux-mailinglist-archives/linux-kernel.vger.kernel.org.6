Return-Path: <linux-kernel+bounces-527213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 063F7A40883
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 13:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D823B175EA6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 12:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B936D20AF97;
	Sat, 22 Feb 2025 12:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=denx.de header.i=@denx.de header.b="f/aFhwNa"
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAA7202C41;
	Sat, 22 Feb 2025 12:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740229150; cv=none; b=pON59q8UAlbVrin103yp/kbz+Ob2BsFotiGfshT1guH8fHf28tVMbasrLkrSxAofInukxz+MNec2mY52ebMXFTevkji/GMKIW+qWZI4Cae6namBFDPLX2lYh/6BUuXLsoLAcjObHVD2Xe/Zn9WBy11taWov0AyDCXrGd2kSK6Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740229150; c=relaxed/simple;
	bh=dlUBZqmDd7idwnsDJJgcHQ+qlgLxt/ObEgAfhNEtsPI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jP4jKILZTUmulComBC/uSf36tQJp4Uc/Y5EJ1BLcDS2A88NXrAZocpdX8Rvq9WiJsTWVA/TwK2aTRbN7CO+kgTORRUDce8UIeklv8ULMqC7HbWg3ISX2miaBpkd+Mqfm/DWQvVSEuX+mEXp/oWg1TAT/mjYWezn0XggCvBPngT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=f/aFhwNa; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0474310382D37;
	Sat, 22 Feb 2025 13:58:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1740229144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+QIov7jfoKTEV1cXpEf4aAHlzsFw8NzhysmN76wJEzc=;
	b=f/aFhwNatcODmbj3mzTP7aLbtmPl1xsMMEmcpYH0DwHi9kGmA9xWj3tRujZXfXuzbd13eY
	4Cn1Elo7kiGOsgHsW7cOUsAl3f9dzEnO/hXrszYj5eGcG/1f6kSzoB77IDjMKYc2Ay/eHh
	RgxZO9pI9LF9+gvxe91O24bNgc22LUCb1W55+3vUUq4S7JR58WOJalWNuyz7SJy7m/5vc4
	Isq2/til11S0m81CpgSMkyraffnktz3Cn4GLmtO5YHxkIn78yGWxr6XgYa3JZ9h8DUzl0n
	pYk6ULMkTYV5kUjg3LMgE7C0flKH3+bYLP8fwbtlGXmqR9neCN0ozz1NKTUTNA==
Date: Sat, 22 Feb 2025 13:58:57 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
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
Message-ID: <20250222135857.531dffd3@wsk>
In-Reply-To: <ee9a05a6-f9fb-46d0-80b8-983a318ed7c9@kernel.org>
References: <20250221155418.1167670-1-lukma@denx.de>
	<20250221-seventh-improving-9d22a8dc5108@spud>
	<20250221215410.06b0a8a6@wsk>
	<ee9a05a6-f9fb-46d0-80b8-983a318ed7c9@kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HSbPmo89l0CTy/A/G17AFEQ";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/HSbPmo89l0CTy/A/G17AFEQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

> On 21/02/2025 21:54, Lukasz Majewski wrote:
> > Hi Conor,
> >  =20
> >> On Fri, Feb 21, 2025 at 04:54:17PM +0100, Lukasz Majewski wrote: =20
> >>> This entry adds vendor prefix for Liebherr-Werk Ehingen GmbH.
> >>>
> >>> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> >>> ---
> >>>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
> >>>  1 file changed, 2 insertions(+)
> >>>
> >>> diff --git
> >>> a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> >>> b/Documentation/devicetree/bindings/vendor-prefixes.yaml index
> >>> 5079ca6ce1d1..20ea550ac328 100644 ---
> >>> a/Documentation/devicetree/bindings/vendor-prefixes.yaml +++
> >>> b/Documentation/devicetree/bindings/vendor-prefixes.yaml @@
> >>> -882,6 +882,8 @@ patternProperties: description: Shenzhen Lunzn
> >>> Technology Co., Ltd. "^luxul,.*": description: Lagrand | AV
> >>> +  "^lwe,.*":
> >>> +    description: Liebherr-Werk Ehingen GmbH
> >>>    "^lwn,.*":
> >>>      description: Liebherr-Werk Nenzing GmbH   =20
> >>
> >> What's the difference between these two? =20
> >=20
> > They are in fact targetting different types of industrial markets.
> > Hence, their devices and way of using SPI devs are totally
> > different. =20
>=20
> We don't take multiple samsung or lg vendor prefixes, even though they
> have multiple separate companies, so we shouldn't take these either.
> Both use the same domain (at least first search result pointed me
> there)
> - liebherr - so that's the same entry.
>=20

Ok, so then I will just add "lwn.btt" in the other patches and drop
this particular one.

Thanks for input.

> Best regards,
> Krzysztof




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/HSbPmo89l0CTy/A/G17AFEQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAme5yhEACgkQAR8vZIA0
zr0XfAf9HU9GGwndTQcHdEdADhUFOB6LSdBVAS0dtKD78L0oMXG2vqrvCiEuPOwm
ErhZiKvCk39BGY3WEi73sX4FeqNu6SlxEfs09Qdz1AERNvbqPvtHOESAblzJCkQV
U6ItAk4hPlHuwek31o/Vr+eK1ZkFQnGyaLQg+UbWiN/zMmIHnYIL+ob39H7/bN49
ccy/er9F7E0jEgIsZNBM3qhhp7kpFkSdc+VuXuY+mH7VYPTI8aGlQDbnA21A3x1o
KYPZCdkSbz7WJF2+KfEHRyXwWcQ3QJ3Ac59fQJCOZrV963Ly9uz3UXFGffoyTDXz
7XPq4OmWcJMwwnhrogYTV6Stv2h0PQ==
=Hy1n
-----END PGP SIGNATURE-----

--Sig_/HSbPmo89l0CTy/A/G17AFEQ--

