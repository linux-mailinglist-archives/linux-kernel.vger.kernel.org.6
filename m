Return-Path: <linux-kernel+bounces-532688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE016A450FB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 00:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 101C87AA3DD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507002397B0;
	Tue, 25 Feb 2025 23:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlrNC5hU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9DA19DF8B;
	Tue, 25 Feb 2025 23:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740526669; cv=none; b=A9uGhj0RhrHdiGeYezHqfw5Uf7dnrBhETOhpJZNREva67IF48Ice63Qdgqt0RJjBeQ/eRvnxUT/dv4UXig/VyzeqBdI8Q0T7HePakr5l0OK2i3YuvzF7dRAzIT0iLsqBXMFcrqdsUgBxz0mfClB/1JrHnC3QNCA8qUxhlSInSic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740526669; c=relaxed/simple;
	bh=+2UaCS9C0tprIc6qlT3DNUUiqvQPqsXy1dIZhbtMRP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8qpWuT6491ZLY4tappnSybNdCoJ8DBQ4MUlzPPZAA2FOJQo2rhiz2aFj2h1xI7VV7iExSkFS8CtClf9s4XTJWNL6FNr/j/QIietZOgtIOg1c+EfgcFC0Q37awTDPreX8EdznHPrG/QZW5nYN1msw/MdA9x6NQcQ8o3ce/Rif0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlrNC5hU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C806EC4CEDD;
	Tue, 25 Feb 2025 23:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740526669;
	bh=+2UaCS9C0tprIc6qlT3DNUUiqvQPqsXy1dIZhbtMRP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RlrNC5hUOkhq21nT2EhjOFT3u4jOK2ZBQ69wymd/ky/w1nFU0O/OanQcKI1AhXVfA
	 Wo0meeR7yvnF1+NzbCr4Mb9l9t/yYsNdzoe+X/ednhSfPQXR0IWGbCHbzAbaB10Ux1
	 Vk8iZPyA0y7JDjV/JJEBvn6jHEr4z5lhoSDLh8nH7w11sAdn+KeMmBCl55NoosCLX6
	 1vDekgVWrUu6fIrBTmr5jDopULYHNCkZ1muh2f9JB3/a3CE3VkOqjElZ2Aq10x0rw/
	 AARLlBlN79Sze7vJgDkgKax6Dc2fKUQIWb/CRmMJovqOuCVd7BEdue7+sfPG8UaJzj
	 PcnAtQ5HSb4qw==
Date: Tue, 25 Feb 2025 23:37:43 +0000
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
Message-ID: <20250225-despair-rural-dc10216005f4@spud>
References: <20250221155418.1167670-1-lukma@denx.de>
 <20250221155418.1167670-2-lukma@denx.de>
 <20250221-scuba-rematch-ada1a9b750b1@spud>
 <20250221215659.61ecc523@wsk>
 <20250224-crux-tabasco-4107deee169e@spud>
 <20250224202131.1b77a23d@wsk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rUSLfAnwy4z3eg62"
Content-Disposition: inline
In-Reply-To: <20250224202131.1b77a23d@wsk>


--rUSLfAnwy4z3eg62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 08:21:31PM +0100, Lukasz Majewski wrote:
> Hi Conor,
>=20
> > On Fri, Feb 21, 2025 at 09:56:59PM +0100, Lukasz Majewski wrote:
> > > Hi Conor,
> > >  =20
> > > > On Fri, Feb 21, 2025 at 04:54:18PM +0100, Lukasz Majewski wrote: =
=20
> > > > > The measurement device on Liebherr's (LWE) boards is used to
> > > > > monitor the overall state of the device. It does have SPI
> > > > > interface to communicate with Linux host via spidev driver.
> > > > > Document the SPI DT binding as trivial SPI device.
> > > > >=20
> > > > > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
> > > > >  1 file changed, 2 insertions(+)
> > > > >=20
> > > > > diff --git
> > > > > a/Documentation/devicetree/bindings/trivial-devices.yaml
> > > > > b/Documentation/devicetree/bindings/trivial-devices.yaml index
> > > > > fadbd3c041c8..5d736a9792c2 100644 ---
> > > > > a/Documentation/devicetree/bindings/trivial-devices.yaml +++
> > > > > b/Documentation/devicetree/bindings/trivial-devices.yaml @@
> > > > > -161,6 +161,8 @@ properties:
> > > > >            - jedec,spd5118
> > > > >              # Linear Technology LTC2488
> > > > >            - lineartechnology,ltc2488
> > > > > +            # Liebherr on-board measurement SPI device
> > > > > +          - lwe,btt   =20
> >                           ^^
> > Are these two trailing spaces an artefact of the mail?
> >=20
>=20
> No, there shall not be any.
>=20
> > > >=20
> > > > How does "btt" translate to what the device actually is? Seems
> > > > kinda random! =20
> > >=20
> > > Btt is a family of devices (bttc, btt3, xea) - to control heavy duty
> > > machines.
> > >=20
> > > That was the original codename - conceived probably 30+ years ago. =
=20
> >=20
> > If there's 3 different devices, how come there aren't 3 compatibles, 1
> > for each?
>=20
> There are devices from a single "family" of them, but different.
>=20
> They are using similar approach for spidev devices connected.

"Similar" means different, and therefore you need to differentiate
between devices. In turn that means they should have distinct
compatibles.

--rUSLfAnwy4z3eg62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ75URwAKCRB4tDGHoIJi
0iylAQCDl/urbZDhlaj3/WbGB/SjB98yxW3Sv/8dLlXgRVYqKgD/RGsf8DfTceLQ
6gKIIWY8ebW3lKpdCYdpwYrnwHar0AQ=
=DuIy
-----END PGP SIGNATURE-----

--rUSLfAnwy4z3eg62--

