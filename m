Return-Path: <linux-kernel+bounces-335761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DFB97EA41
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 12:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 399C11F21835
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 10:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BA4197A98;
	Mon, 23 Sep 2024 10:57:39 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F90F17C60
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 10:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727089059; cv=none; b=Ddl5xem0RR3Nk3aCCPypQsNw64WXssWSaxrkFDNfqomjVnBv3vVyRWkhHBOShfDh+rhuqB8JtDw3uG4Azet8+Kz3P078Qbv9v47xAOgEGtRaPkFJAGoZefRLJ4EnP2CnqrnyA2v2Sbv5VIDBG1Z6rRACAIVl8kZYbaAA76VzZc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727089059; c=relaxed/simple;
	bh=0SkozGkj68AZ5hrm4yyVeLoWtR4WfW3Fi7zQndEz+U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwcQVJlhXhbmAwrikgEEdY42L6ffknp4qjY8X59wJwYt8DLWhvPOM32OFh4W8GtJhAczl+pBW8/oijajkVyOXFpC0IZ2+zm2UoAwWsgUCPf3wCS6cTUNud4OcSzD5UWoDo56ZALXKkcHlLD1mLMV1VVK2MagHgLcRfkvpUR8dsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ssgkn-0006MJ-Sf; Mon, 23 Sep 2024 12:57:17 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1ssgkl-000wIO-Hh; Mon, 23 Sep 2024 12:57:15 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 43146341116;
	Mon, 23 Sep 2024 10:57:12 +0000 (UTC)
Date: Mon, 23 Sep 2024 12:57:07 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Charan.Pedumuru@microchip.com
Cc: mailhol.vincent@wanadoo.fr, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: net: can: atmel: Convert to json schema
Message-ID: <20240923-burrowing-poised-taipan-22a14d-mkl@pengutronix.de>
References: <20240912-can-v1-1-c5651b1809bb@microchip.com>
 <20240912-literate-caped-mandrill-4c0c9d-mkl@pengutronix.de>
 <d9987295-74eb-4795-8517-379249cd7626@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pctubu4jhjdunxfu"
Content-Disposition: inline
In-Reply-To: <d9987295-74eb-4795-8517-379249cd7626@microchip.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--pctubu4jhjdunxfu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20.09.2024 04:51:57, Charan.Pedumuru@microchip.com wrote:
> >> +allOf:
> >> +  - $ref: can-controller.yaml#
> >> +  - if:
> >> +      properties:
> >> +        compatible:
> >> +          contains:
> >> +            enum:
> >> +              - microchip,sam9x60-can
> >> +    then:
> >> +      required:
> >> +        - compatible
> >> +        - reg
> >> +        - interrupts
> >> +        - clocks
> >> +        - clock-names
> > AFAICS clock-names is required for all compatibles.
> In our case only sam9x60 is using clock-names property.

No, the driver uses "clk_get(&pdev->dev, "can_clk")", so this property
is mandatory.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--pctubu4jhjdunxfu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbxSX8ACgkQKDiiPnot
vG9+KQf+MKdlOE0m4njNDZ+9Dh5XHsKriEiywBRcKIa9qehl5SENRCEYdBwFLHzL
ifzlF0ypyFhyk/XH6PGQg8/HJ8MCksgKnKdfhUs/Mz75r2iboTsRVwfIlF23U0Ke
/VNEeerkrWTUvBO3vpEiHXWsWwvjqJXE/pD/7DV83wn+78YnQts0lbpAWckj1qZT
5jarfnoRuAuujYoLW2g845Z94y/shUTu3bB6KYNwKJ/ymWeRaEhedzgqe6yiBd4e
SVIx/S6Bl0d+zhwOt6e5svh3bNxdkvxYjk60x9JQr4Sr4eIqKwIHBRWyazxG5Bmn
2Uzm4ClQB4vt/ekEmk4GVIMb0d73ww==
=kWhh
-----END PGP SIGNATURE-----

--pctubu4jhjdunxfu--

