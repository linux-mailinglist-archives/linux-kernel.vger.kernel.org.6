Return-Path: <linux-kernel+bounces-529882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA53A42C26
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D65173AABED
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDFB266B54;
	Mon, 24 Feb 2025 18:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0PnSkU3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C10266196;
	Mon, 24 Feb 2025 18:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740423496; cv=none; b=DBC9mAoMj/Ycno1pF5LkxsjEA5ZBOe4gP4FRSfCcdx8O/SdN5LLPyVwD8pmUTjf7pC+SE4Tf3GJcfmyQ6ZoDKwc8sTrJOUQPNHpUxIMYKp+F80hlWbOhOTd7sZd0a1EcOArSF+jr8LgTjS065R3zmBucOO2k6Z9bOth6pmniXZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740423496; c=relaxed/simple;
	bh=MGqd6UyFbLEvXbwx8sco4jvnELmzS1EXFIH5OYWVOaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNZ8pgQSAwtggK8geCCJBNNeykq6uubtSGeyJNIK00IVYc11cb0JDQQZMaSp1T/wPa3XEny4bwsgh/p1/COW/n6ZmwgU6VCIrgUOatVfpbTz8lUFLwG2S2fSeZVAhSkkThBUeSRZjrVO353/x06bJbYUYsMDZ+x1+vHnQgSq46c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0PnSkU3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59C1C4CEE7;
	Mon, 24 Feb 2025 18:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740423496;
	bh=MGqd6UyFbLEvXbwx8sco4jvnELmzS1EXFIH5OYWVOaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e0PnSkU3scMtWm3Ig7P0MxfH7yjicqDahqLvSnu4/g4uB6UONsvqBE+4PTfpxkDf6
	 Zyg2ueuZlmzz3eBdsNqcXSykRUP3rOJmVWxz1LVNqUixqdoA3Ecvb61VscmJ+iGINM
	 Jr0rwteU/qRa3roO7Y3tnLhDPg59GDkpvZHBkqpWhnxaXQ+uYdLNULjooZclcnb1L1
	 MZwBu3I7nip9THXJRyXEc+BWG0q0KifPPVitL7s5nc6/ZrVN4UoF+9dgljkxwj1en7
	 sP+mLOAlpGGZbB6EHBEBR7ZS1tAcqsbAXnaf5bDsO9QcRSOFyXZtfUOCo3zG1UXqTV
	 B8bDZkhas+ESQ==
Date: Mon, 24 Feb 2025 18:58:10 +0000
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
Subject: Re: [PATCH 2/2] dt-bindings: trivial-devices: Document SPI
 measurement on LWE boards
Message-ID: <20250224-crux-tabasco-4107deee169e@spud>
References: <20250221155418.1167670-1-lukma@denx.de>
 <20250221155418.1167670-2-lukma@denx.de>
 <20250221-scuba-rematch-ada1a9b750b1@spud>
 <20250221215659.61ecc523@wsk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HqBwAz7wwaok1LZr"
Content-Disposition: inline
In-Reply-To: <20250221215659.61ecc523@wsk>


--HqBwAz7wwaok1LZr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 09:56:59PM +0100, Lukasz Majewski wrote:
> Hi Conor,
>=20
> > On Fri, Feb 21, 2025 at 04:54:18PM +0100, Lukasz Majewski wrote:
> > > The measurement device on Liebherr's (LWE) boards is used to monitor
> > > the overall state of the device. It does have SPI interface to
> > > communicate with Linux host via spidev driver. Document the SPI DT
> > > binding as trivial SPI device.
> > >=20
> > > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > > ---
> > >  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml
> > > b/Documentation/devicetree/bindings/trivial-devices.yaml index
> > > fadbd3c041c8..5d736a9792c2 100644 ---
> > > a/Documentation/devicetree/bindings/trivial-devices.yaml +++
> > > b/Documentation/devicetree/bindings/trivial-devices.yaml @@ -161,6
> > > +161,8 @@ properties:
> > >            - jedec,spd5118
> > >              # Linear Technology LTC2488
> > >            - lineartechnology,ltc2488
> > > +            # Liebherr on-board measurement SPI device
> > > +          - lwe,btt =20
                          ^^
Are these two trailing spaces an artefact of the mail?

> >=20
> > How does "btt" translate to what the device actually is? Seems kinda
> > random!
>=20
> Btt is a family of devices (bttc, btt3, xea) - to control heavy duty
> machines.
>=20
> That was the original codename - conceived probably 30+ years ago.

If there's 3 different devices, how come there aren't 3 compatibles, 1
for each?

>=20
> > Also, where is patch 3, adding the lwe,btt to the spidev driver so
> > that it will probe?
>=20
> I've posted it to Mark Brown (and also linux-spi ML) for review.
>=20
> >=20
> > Cheers,
> > Conor.
> >=20
> > >              # 5 Bit Programmable, Pulse-Width Modulator
> > >            - maxim,ds1050
> > >              # 10 kOhm digital potentiometer with I2C interface
> > > --=20
> > > 2.39.5
> > >  =20
>=20
>=20
>=20
>=20
> Best regards,
>=20
> Lukasz Majewski
>=20
> --
>=20
> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de



--HqBwAz7wwaok1LZr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ7zBQgAKCRB4tDGHoIJi
0vRwAP9N0fVaExnFQCdcKbeMh1BzembuidqTArcQ2Pm/BAWWyAD/cgx5piCsNnfV
1cW1MPvVluWZo6LhaZZwiCnXPAnRqwM=
=3caU
-----END PGP SIGNATURE-----

--HqBwAz7wwaok1LZr--

