Return-Path: <linux-kernel+bounces-526638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A0AA4016A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F269423C46
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A99253B61;
	Fri, 21 Feb 2025 20:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Y3JLuKp7"
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5D71EE028;
	Fri, 21 Feb 2025 20:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740171262; cv=none; b=PLy8O9zJG+7t6snuj9tfnyUJtoSbGss5tVwqznxkEBFlAN+VohDvieDh1tD3vDsII9tLXKvDDcxFizwEnOpYBI8xHLD0wij71v+pDjnW1Qui/GkLEfqRn63Xi8BdrvnpcAGl2xG5VujdhOFPId0gBNCA2BsZRtCeAr+6S0Z8Zu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740171262; c=relaxed/simple;
	bh=/Zb9STsIj3CsBGRZMggQbFMZ5DVe8kYJ5LIUVz6g5ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bKK6ToxunURgvUOjrdgRSEbTMUb2Fl1EJ47VLK0WdJT7v0gnydbgxFhG+IgoPFStX6jTJFORZNhYvApO7QBN/oCxs0NgJDELmik5APJus4MBxNemwTQOq1hmFmJ9Rw/YoxFA/EK9EWLBiZ7ycdlBrx4g8+MrEN2rk0BALtvYnRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Y3JLuKp7; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7D38110382D37;
	Fri, 21 Feb 2025 21:54:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1740171255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PAAxt964g0fHuI07VOwjZUnGIuvggzVxuUrNu5LbA08=;
	b=Y3JLuKp79OCbE4vU8m8NKnMyvJppTENjBdlQFhW+sBqPYRVVlGj9wsvP4n/B3Op3dI9a/c
	yxY8mUafZyvCs6/9H02eIDA0KSVVhT6OVlWS8dMQzqAWT1PvXGcyZFCoteYCt9vBmz8HES
	Ls9ckMWy68bBtGDRvxASaxJ4dT5joJF1BzTBWNdFQbXT1DwFz7fEfGSxwG+zNQMWhhMDtU
	G7esnWs9paVdYFkn9nc0zFVyr708S0aDufK6PMKA/meqTXyjC9wncuXFHncqGhC7pYy5Ak
	3w+PzN8Up1ksielocg3JqFUvEIrkUB7KOQkdKEguHNMEXVeol6NHQBZpnrJNEg==
Date: Fri, 21 Feb 2025 21:54:10 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Conor Dooley <conor@kernel.org>
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
Message-ID: <20250221215410.06b0a8a6@wsk>
In-Reply-To: <20250221-seventh-improving-9d22a8dc5108@spud>
References: <20250221155418.1167670-1-lukma@denx.de>
	<20250221-seventh-improving-9d22a8dc5108@spud>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_kc4ZzDIIrqOd9QSEZd8KVk";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/_kc4ZzDIIrqOd9QSEZd8KVk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Conor,

> On Fri, Feb 21, 2025 at 04:54:17PM +0100, Lukasz Majewski wrote:
> > This entry adds vendor prefix for Liebherr-Werk Ehingen GmbH.
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> >  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > b/Documentation/devicetree/bindings/vendor-prefixes.yaml index
> > 5079ca6ce1d1..20ea550ac328 100644 ---
> > a/Documentation/devicetree/bindings/vendor-prefixes.yaml +++
> > b/Documentation/devicetree/bindings/vendor-prefixes.yaml @@ -882,6
> > +882,8 @@ patternProperties: description: Shenzhen Lunzn Technology
> > Co., Ltd. "^luxul,.*":
> >      description: Lagrand | AV
> > +  "^lwe,.*":
> > +    description: Liebherr-Werk Ehingen GmbH
> >    "^lwn,.*":
> >      description: Liebherr-Werk Nenzing GmbH =20
>=20
> What's the difference between these two?

They are in fact targetting different types of industrial markets.
Hence, their devices and way of using SPI devs are totally different.

>=20
> >    "^lxa,.*":
> > --=20
> > 2.39.5
> >  =20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/_kc4ZzDIIrqOd9QSEZd8KVk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAme45/IACgkQAR8vZIA0
zr0Jgwf/Uivt2eoyMbrfg8PDKsEdOpP2bguNh8JL20f4solRY0MW89GNIB/3fJMD
u/RSNNjs1fNbKxhsAroO1BEwD61DqqFZL0lKO9lo70buHGqioDXsjnk5br5lKncz
kbpscNkbNp+1a73Hc4J2ZdI+fPuTDP9S4tNjW/jW2JI7BgiB+ZGJ4CryxowQH6It
zYZEQcvNc48ZME0TuQW+SM+vJYxPajNKt6mnv0jnLIOHnbUGz9GY8M3gYqFlsmML
+barUj21TWV+ZIMzindCB6fejrKktPPf0qR3thnH+g2ABbosSBKeuw9lTrFXE3fI
SKh0iTTMYUhGIpAIZwZbnUWYVz2ZMA==
=NbvR
-----END PGP SIGNATURE-----

--Sig_/_kc4ZzDIIrqOd9QSEZd8KVk--

