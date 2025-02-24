Return-Path: <linux-kernel+bounces-529929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 963D9A42C9C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D904C3AB7A5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FB21C84A6;
	Mon, 24 Feb 2025 19:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=denx.de header.i=@denx.de header.b="JK0O6eJh"
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05C616CD1D;
	Mon, 24 Feb 2025 19:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740424907; cv=none; b=FYqHWO8Qd/cdVsNv8exWS4VOIEh45n1I6RAUyLwvrtzMndW7TLmqaNyDaJobPkHRlLDdpQPYaqUnRLEiNdW4nNJ+uZNaIXcrKD2WxKe3hiBwvHsgIEVEIAq1uYDj6zFP8zhsGPl9UH2GDHDZatz4EWaZE+pqSEo9NFT5mDD5ACQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740424907; c=relaxed/simple;
	bh=SIEX0kmZf7kOO8fpyH4yz9j1aCjbhbyIc/QuGQzWQpo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QiUN8zyyce78gC1/s5cPVdY6gfddfPD+yruzKst84Y0nrh2fGwkIIcRmGxOHXbr+QYhdK9f7Pa+MA+HJl2MDEhOQwQpfjg5QC2er6uaqFz3IFSk1yQUMj6NsOK7Ehxbqcp4+wcQgrvbMzT+XHRUCNdCyJL6zC4wTfWu++TnJTVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=JK0O6eJh; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EF96310382F1F;
	Mon, 24 Feb 2025 20:21:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1740424897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3nBzamUqMdlfRXckkErs4pAv4h1BBEDXXkK/O9CCOAM=;
	b=JK0O6eJhfSu4TpdtUwDEhrK0mu/5Hyn83OEmXIPIGnml2feg6zabE84jltF2BjJGYB6y0M
	tKgypKwHPB7sh2gRY8TDTfIom9GeiB2QbVQmDNgd1QLDU9Mh4sDK91bicjh9lgqb5x/eHM
	y4Y7VPdKroXw7YmnomEPfXXOGTRauGwPY4ujY1Uqtdz5sBJQTNd9HkGlDnMaESerC02O8O
	6tvIlfQ9T1q/F0rSPRL0VLnxpEWcEe8T40GpMSG7OmY4ykXun2m2wl3cqMMKmV1qewV3M5
	iI71fNeH1W49vCTSiL0Oqmt4Xmh7UoF0ABCYkBhaSWfPI+16XyULt0IIcJa4Xg==
Date: Mon, 24 Feb 2025 20:21:31 +0100
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
Subject: Re: [PATCH 2/2] dt-bindings: trivial-devices: Document SPI
 measurement on LWE boards
Message-ID: <20250224202131.1b77a23d@wsk>
In-Reply-To: <20250224-crux-tabasco-4107deee169e@spud>
References: <20250221155418.1167670-1-lukma@denx.de>
	<20250221155418.1167670-2-lukma@denx.de>
	<20250221-scuba-rematch-ada1a9b750b1@spud>
	<20250221215659.61ecc523@wsk>
	<20250224-crux-tabasco-4107deee169e@spud>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8j9ptH5L29iv71L9hMozt_h";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/8j9ptH5L29iv71L9hMozt_h
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Conor,

> On Fri, Feb 21, 2025 at 09:56:59PM +0100, Lukasz Majewski wrote:
> > Hi Conor,
> >  =20
> > > On Fri, Feb 21, 2025 at 04:54:18PM +0100, Lukasz Majewski wrote: =20
> > > > The measurement device on Liebherr's (LWE) boards is used to
> > > > monitor the overall state of the device. It does have SPI
> > > > interface to communicate with Linux host via spidev driver.
> > > > Document the SPI DT binding as trivial SPI device.
> > > >=20
> > > > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > > > ---
> > > >  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >=20
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/trivial-devices.yaml
> > > > b/Documentation/devicetree/bindings/trivial-devices.yaml index
> > > > fadbd3c041c8..5d736a9792c2 100644 ---
> > > > a/Documentation/devicetree/bindings/trivial-devices.yaml +++
> > > > b/Documentation/devicetree/bindings/trivial-devices.yaml @@
> > > > -161,6 +161,8 @@ properties:
> > > >            - jedec,spd5118
> > > >              # Linear Technology LTC2488
> > > >            - lineartechnology,ltc2488
> > > > +            # Liebherr on-board measurement SPI device
> > > > +          - lwe,btt   =20
>                           ^^
> Are these two trailing spaces an artefact of the mail?
>=20

No, there shall not be any.

> > >=20
> > > How does "btt" translate to what the device actually is? Seems
> > > kinda random! =20
> >=20
> > Btt is a family of devices (bttc, btt3, xea) - to control heavy duty
> > machines.
> >=20
> > That was the original codename - conceived probably 30+ years ago. =20
>=20
> If there's 3 different devices, how come there aren't 3 compatibles, 1
> for each?

There are devices from a single "family" of them, but different.

They are using similar approach for spidev devices connected.

>=20
> >  =20
> > > Also, where is patch 3, adding the lwe,btt to the spidev driver so
> > > that it will probe? =20
> >=20
> > I've posted it to Mark Brown (and also linux-spi ML) for review.
> >  =20
> > >=20
> > > Cheers,
> > > Conor.
> > >  =20
> > > >              # 5 Bit Programmable, Pulse-Width Modulator
> > > >            - maxim,ds1050
> > > >              # 10 kOhm digital potentiometer with I2C interface
> > > > --=20
> > > > 2.39.5
> > > >    =20
> >=20
> >=20
> >=20
> >=20
> > Best regards,
> >=20
> > Lukasz Majewski
> >=20
> > --
> >=20
> > DENX Software Engineering GmbH,      Managing Director: Erika Unter
> > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell,
> > Germany Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email:
> > lukma@denx.de =20
>=20
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/8j9ptH5L29iv71L9hMozt_h
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAme8xrsACgkQAR8vZIA0
zr1oKAf/WmdCs73CSvhwPwRIQJMJsk3zq7xeAnmKqwW2DlbbfFjwC/qN9BebVh0/
C00ZxZc8dlOhNjz75f/kuXxGV2V387m3wsh1lNmJ2MdDBnrP76uZgQi9ckNxBcMS
wflcyoBPzuabTCIhOicc+RIbuIT6aYyOh+hTJBf3sU1ZTwMg1CTGIOswjfOXXQlp
bHZvqmhbKcY/DnmiByLO418wSgWMmMNx91hvlY8dxVtibsyyXDiZbDdVd+mR2YIu
W3WEGzSL2sM7a1VIGxYG9bXl6q5PMq/IB82yCJfNP2dcIMLTwue+W0gSiSQEjJZ7
I7Tn/aJRAl/SSNuzt/0ufDgagbGs0g==
=qcwC
-----END PGP SIGNATURE-----

--Sig_/8j9ptH5L29iv71L9hMozt_h--

