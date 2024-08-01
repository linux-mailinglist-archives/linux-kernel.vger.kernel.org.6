Return-Path: <linux-kernel+bounces-271488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE885944EEB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D27D21C20FC5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DEE13C3EE;
	Thu,  1 Aug 2024 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFansC8g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4777B1EB4B5;
	Thu,  1 Aug 2024 15:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722525427; cv=none; b=qvkzhW9wnOmeXpT/5duVhO0ohspssKw/8REWle507Cxu7mRcOff4FVvEHY/ctzpIcNaFW5TiUjSj6ZRURFKoOikq8W9MqvlP1Map7kyPto4pBqWG3E1wu+5wSZj4PnkBNLMYM5AD5CVN65ASZNsfk1sxwveo2NZdIeI2l0twhno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722525427; c=relaxed/simple;
	bh=jyVbta1mUuxwm3u5mh3uM5NIXWN+tTgIG8i6Fx9mbGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kysF4Enk/GkMXC8+rhky4aV2l/s8cA8bpaLDZ3x0kwI6Z+2R+QzA8xFpjCuw0Sa8C50hsX7muNF8d8brO1KVBAqTvk1psq6kE2xs9RMuSRV1wTyKDe9KBmX8WwODMSwHxMmZMOxz5LX+ldksb5r6nqRkTfvowrf6/SynGml4jjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFansC8g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F37C32786;
	Thu,  1 Aug 2024 15:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722525426;
	bh=jyVbta1mUuxwm3u5mh3uM5NIXWN+tTgIG8i6Fx9mbGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZFansC8gaySRnEUbwCH9es1MlvqgFSrTHWUf56BGCUF7djkabx8LfT+ZAEnuE8nca
	 m75hY2YBWwXMMmfOQIiHl/y42Xr3aKyKZmMeiu5PEDM70mpoIpKi/Yu9HONVIjgeHB
	 ZpQKYSP41L6SDXP6KLTnmtyZkNMe7NKGWK0zGMP1xyOeZATCHg+7Y9RglNzmV3eb7Y
	 l5Cb7p2dh05ngOvKfT3x+PG4x5OzjSyKCcpS7aqVZVv/91d1R3BkXmelpFHlrdVeXE
	 qo2ICTY3B8hQKbMAF7OdhNLgG5YmTqkvHjlf2XK0aG6htALLhCX6bhYS7V8rOBbWnY
	 5XCMyflA+eavg==
Date: Thu, 1 Aug 2024 16:17:01 +0100
From: Conor Dooley <conor@kernel.org>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXT] Re: [PATCH v6 2/5] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Message-ID: <20240801-most-greeter-2932bee3879a@spud>
References: <20240722-imx-se-if-v6-2-ee26a87b824a@nxp.com>
 <20240722-popper-comfort-7538ea70c77b@spud>
 <AM9PR04MB8604123E065315093347F66C95A92@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <20240723-smitten-shower-1d15c0f3cf97@spud>
 <AM9PR04MB86043E4B4B2FB206BF9223C695AA2@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <20240724-huddling-neatly-88813c0b1f1d@spud>
 <DU2PR04MB85990A0AB8AF8ABFCDA4CBD995AB2@DU2PR04MB8599.eurprd04.prod.outlook.com>
 <20240725-filled-outscore-24149588d958@spud>
 <AM9PR04MB8604E23D34326C32B76D6F2995B42@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <AM9PR04MB8604087289C777F0F0C7597B95B22@AM9PR04MB8604.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HV45wl+UslN0ZSE8"
Content-Disposition: inline
In-Reply-To: <AM9PR04MB8604087289C777F0F0C7597B95B22@AM9PR04MB8604.eurprd04.prod.outlook.com>


--HV45wl+UslN0ZSE8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 01, 2024 at 08:52:48AM +0000, Pankaj Gupta wrote:
>=20
>=20
> > -----Original Message-----
> > From: Pankaj Gupta
> > Sent: Friday, July 26, 2024 6:06 PM
> > To: Conor Dooley <conor@kernel.org>
> > Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring <robh@kernel.org>;
> > Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> > <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> > <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; Rob
> > Herring <robh+dt@kernel.org>; linux-doc@vger.kernel.org; linux-
> > kernel@vger.kernel.org; devicetree@vger.kernel.org; imx@lists.linux.dev;
> > linux-arm-kernel@lists.infradead.org
> > Subject: RE: [EXT] Re: [PATCH v6 2/5] dt-bindings: arm: fsl: add imx-se=
-fw
> > binding doc

Every single mail I am pointing out your broken mail client, and every
single time you both ignore me and fail to fix it. Fix it.

> > > -----Original Message-----
> > > From: Conor Dooley <conor@kernel.org>
> > > Sent: Thursday, July 25, 2024 8:09 PM
> > > To: Pankaj Gupta <pankaj.gupta@nxp.com>
> > > Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring <robh@kernel.org>;
> > > Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> > > <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> > > <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > > <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; Rob
> > > Herring <robh+dt@kernel.org>; linux-doc@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; devicetree@vger.kernel.org;
> > > imx@lists.linux.dev; linux-arm-kernel@lists.infradead.org
> > > Subject: Re: [EXT] Re: [PATCH v6 2/5] dt-bindings: arm: fsl: add
> > > imx-se-fw binding doc
> > >
> > > On Thu, Jul 25, 2024 at 07:06:30AM +0000, Pankaj Gupta wrote:
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Conor Dooley <conor@kernel.org>
> > > > > Sent: Wednesday, July 24, 2024 9:00 PM
> > > > > To: Pankaj Gupta <pankaj.gupta@nxp.com>
> > > > > Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring
> > > > > <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor
> > > > > Dooley <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>;
> > > > > Sascha
> > > Hauer
> > > > > <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > > > > <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; Rob
> > > > > Herring <robh+dt@kernel.org>; linux-doc@vger.kernel.org; linux-
> > > > > kernel@vger.kernel.org; devicetree@vger.kernel.org;
> > > > > imx@lists.linux.dev; linux-arm-kernel@lists.infradead.org
> > > > > Subject: Re: [EXT] Re: [PATCH v6 2/5] dt-bindings: arm: fsl: add
> > > > > imx-se-fw binding doc
> > >
> > > For the third time, please fix your mail client so it stops inserting=
 this garbage.
> > >
> > > > >
> > > > > On Wed, Jul 24, 2024 at 11:02:21AM +0000, Pankaj Gupta wrote:
> > > > > >
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Conor Dooley <conor@kernel.org>
> > > > > > > Sent: Tuesday, July 23, 2024 7:38 PM
> > > > > > > To: Pankaj Gupta <pankaj.gupta@nxp.com>
> > > > > > > Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring
> > > > > > > <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>;
> > > > > > > Conor Dooley <conor+dt@kernel.org>; Shawn Guo
> > > > > > > <shawnguo@kernel.org>; Sascha
> > > > > Hauer
> > > > > > > <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > > > > > > <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>;
> > > Rob
> > > > > > > Herring <robh+dt@kernel.org>; linux-doc@vger.kernel.org;
> > > > > > > linux- kernel@vger.kernel.org; devicetree@vger.kernel.org;
> > > > > > > imx@lists.linux.dev; linux-arm-kernel@lists.infradead.org
> > > > > > > Subject: Re: [EXT] Re: [PATCH v6 2/5] dt-bindings: arm: fsl:
> > > > > > > add imx-se-fw binding doc
> > > > >
> > > > > Please fix this ^
> > > > >
> > > > > > > On Tue, Jul 23, 2024 at 09:28:31AM +0000, Pankaj Gupta wrote:
> > > > > > > >
> > > > > > > > > -----Original Message-----
> > > > > > > > > From: Conor Dooley <conor@kernel.org>
> > > > > > > > > Sent: Monday, July 22, 2024 10:20 PM
> > > > > > > > > To: Pankaj Gupta <pankaj.gupta@nxp.com>
> > > > > > > > > Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring
> > > > > > > > > <robh@kernel.org>; Krzysztof Kozlowski
> > > > > > > > > <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>;
> > > > > > > > > Shawn Guo <shawnguo@kernel.org>; Sascha
> > > > > > > Hauer
> > > > > > > > > <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > > > > > > > > <kernel@pengutronix.de>; Fabio Estevam
> > > > > > > > > <festevam@gmail.com>; Rob Herring <robh+dt@kernel.org>;
> > > > > > > > > linux-doc@vger.kernel.org;
> > > > > > > > > linux- kernel@vger.kernel.org; devicetree@vger.kernel.org;
> > > > > > > > > imx@lists.linux.dev; linux-arm-kernel@lists.infradead.org
> > > > > > > > > Subject: [EXT] Re: [PATCH v6 2/5] dt-bindings: arm: fsl:
> > > > > > > > > add imx-se-fw binding doc
> > > > > > >
> > > > > > > Please fix this ^

> Will use "secure-enclave" as the node name, in the v7 patch.
> Will post the V7 patch-set, by end of the next week.
>=20
> Please reply if anyone think otherwise.

Sure, go for it :+1: And please actually read the comments I have left
on every mail about your mail client being broken. I don't want to see
20 lines of to and cc lists on every response :(


--HV45wl+UslN0ZSE8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZqum7QAKCRB4tDGHoIJi
0i1fAQDARVLAUyl/noJ9pPy4aKx9io7tbLbY8MzHpfH8IY9sUAD8DF0JwpvUr3+S
KT4+8O1kZsRm07SEpIhTNCbOxgYTwAk=
=SbFS
-----END PGP SIGNATURE-----

--HV45wl+UslN0ZSE8--

