Return-Path: <linux-kernel+bounces-522621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F203A3CC81
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7B5C3AED07
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357A625A334;
	Wed, 19 Feb 2025 22:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="cbs6+BBZ"
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBD125A2CD;
	Wed, 19 Feb 2025 22:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740004692; cv=none; b=NIPaI1DMakYO6ito2rkSsmStOXZT6G/M3jzJhrZbr5mmMrcUd//d79cp3WI2vFJvm+IW2PV6wg5EyXHH4aBxFsmTWDTHPIwiDb4j+7tCrlVn7X+SXGqhNtFtdEIQdBr5NcI32xUT13SHOI05Jc8vtc7n7nA6EMKfhNSDsr8it48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740004692; c=relaxed/simple;
	bh=3n0Geo1g1jnDSHEKNDbBxRrW0MqCJbEfVtvyC8SrjB4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C463KlwNHprcxyW18WxFJ9MyNR/LfOc6iH7jGOLv2m21Afy281cjtuvZE0XTtVrmwOP4hythXioqICJ3XV3Ra5T3zrmYkaeAaJlfFIPEeYeKv2dLW6T+9PlxMbbJ1ynZodP1isZSgngyeUL8106MvqdnAg6OWa76ZgsKnwH/x5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=cbs6+BBZ; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 47E9D10382D3C;
	Wed, 19 Feb 2025 23:38:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1740004687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3CFR1KvYqGJu5XHi3W+uo1kT/GLaG+YUtUrdXZ244hc=;
	b=cbs6+BBZgqDbJeBfk1zMSTh4bT5RYpQTKivyzc9qbOKAFLxWGjL3TWBCA9D7S4EudNO6QO
	1qK8+7uCSQIWKZsVeyTsNk1h4GWp0mi7RaTlWEuz/9zFjBT3AbKPsucqmCVq8iOYpbdWeK
	QhwSpUpOBMHGiLsLsU7mewNM8gqvkIe/ANVNoqDfSM+HyT3+WeA1K/OythlTpGSph/XPQU
	0MdJa0bsI6eXgWUAGKhfQHWSW6DZRJE2pLBedfhstcUc3kej22U0ClvICtL7w98kjvd2dK
	1uPh963Uoa5yWHVz9/02d+K3LySFYKySUs4L455EUDrna3RQImLLRhS/kVZaUA==
Date: Wed, 19 Feb 2025 23:38:02 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Shawn
 Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
 <festevam@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-clk@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH] arm: clk: Add ETH switch clock description for vf610
 SoC
Message-ID: <20250219233802.20ec53e5@wsk>
In-Reply-To: <3cebe152-6326-454c-9da6-5cf5a64f71c9@lunn.ch>
References: <20250219114936.3546530-1-lukma@denx.de>
	<3cebe152-6326-454c-9da6-5cf5a64f71c9@lunn.ch>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yVJIrYnQ4O8OFO2hSM.94j5";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/yVJIrYnQ4O8OFO2hSM.94j5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> On Wed, Feb 19, 2025 at 12:49:36PM +0100, Lukasz Majewski wrote:
> > The NXP's vf610 soc is equipped with L2 switch IP block from More
> > Than IP (MTIP) vendor.
> >=20
> > It requires special clock (VF610_CLK_ESW) to be operational. =20
>=20
> So you have a driver for this switch? It has been talked about in the
> past, but nobody made any progress with it. Ah, it was you in 2020.

Yes, I'm going to try another time to upstream it.... :-)

> It
> will be interesting to see what you came up with in the end, pure
> switchdev or a DSA driver.

I think it would be:

1. Standalone driver, which would configure the L2 switch from the very
beginning to work (this is different from FEC on imx28/vf610 where
switch is bypassed)

2. It will use the in-switch registers to have two network interfaces
separated. As a result - it may be slower than the fec_main.c in this
use case.

3. When somebody call "bridge ..." on it - then the in-switch
separation would be disabled. This is the "normal" state of operation
for L2 switch, which would be a HW accelerator for bridging.

4. The switchdev would be used to manage it

5. This would be just a very simple driver - just bridging and startup
of the L2 switch.

After we would have a consensus (i.e. it would be pulled to mainline) -
I would proceed further.

I will try to not touch fec_main.c driver - just write standalone, new
for MoreThanIP L2 switch driver.

If somebody would like to use FEC, then he will insert the proper
module. If switch, another one can be inserted, depending o the target
use case.

>=20
> 	Andrew


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/yVJIrYnQ4O8OFO2hSM.94j5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAme2XUoACgkQAR8vZIA0
zr0H2wf+LDKQ2icJROSHbE6zYeCAmI0xkhWHqIw6W8DD1l7o1QJMYLJEsgSp9yP/
UUWsmIh15IoamLIx3zCnhaiXns42Df+DUH7qsiAF8lLW0C11h9WAuVdJWSLNRLW7
GQAuXwPM58hOymK71Cu9Eo1eacZ7vkd3SgZLpUa+7xIPd6Pei10g2VCpFJiv3ICw
KM+lVEpZ93Orq35IGPAwAzTlhi4gGJPIsFez2+NtiW9vJ+KiodIfSb9mWw+bLqUn
u9OY2vKtfVnuX8fYkd+ERBljmSeyR0fzU2ZB1+CbElSwI61y09f+CFBoSNwK4DhA
Zoudj/6ZH6oCoKT6MoAO1nxGaCV49g==
=xb9S
-----END PGP SIGNATURE-----

--Sig_/yVJIrYnQ4O8OFO2hSM.94j5--

