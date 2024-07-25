Return-Path: <linux-kernel+bounces-262343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 959B293C461
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC1F9B22785
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8439719D074;
	Thu, 25 Jul 2024 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEj72h3Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A041D19AA56;
	Thu, 25 Jul 2024 14:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721918348; cv=none; b=XHU6PY0QH4Tz07GSyTg1/w21YhPrQhObXbn1sh0uPqBk7h1AmIW0ZqUu6ibQFMOjSMtlNYJfYJWtdr4RSvsGqoUIve/68qRbsKvN8lmx4oSbb4sJgUbCGN9GKtDCS1swNKQzBt3Q+uWWTd7xsxnqDE77WofCsUiwrHQefyDGPTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721918348; c=relaxed/simple;
	bh=ZpN2ZJEJffbl5pQjjoIFQo1fZ8paO1e2ecxVl4HvIW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQZiZzREYkg/2skvfmAj95C8C88SPK9eSfbR8YFDOQhmPfumON7x7+bO8xP/nsVdoDzqd6YRoNpz/hqXa51wGJrbmLM5n4KwWMTW1omjYm84RJrm0kescj7a2I4Nh1aao52DKt2402hIaZg4DKodCj5xK2ILiiJZP+KZy7y4CU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEj72h3Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BFB2C32782;
	Thu, 25 Jul 2024 14:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721918348;
	bh=ZpN2ZJEJffbl5pQjjoIFQo1fZ8paO1e2ecxVl4HvIW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZEj72h3ZDXezeNf/UAMg90fRPyND01zgbh194/2NZlbzCI16RuIa9UGzu4g+MjgB3
	 va7ZDr59/mZE77rOcUbcCArK1yAHCafuFZfc2tmdUqGqa9vwB/0r669dHNXjoKaUwo
	 CUupQIQ19WxijEdzmJJ1F+O8N7xd9oof/o/7IRJo11+J0GXqG0zvFaIMqt3S3Ud/Nc
	 MuibNgV/NvkKR6LL6pfqd0SO1WXFytrLrnixCacDc8lvs9Lj3ajQDOpoxnmBXWx2ju
	 9WWWn+j2O19QYx0EwlVhfLeZ5J++e5v5BUimiY1P8fZzKI7+pU7aF9YMlaZ0mIF7V/
	 I/gYx5EiGxocw==
Date: Thu, 25 Jul 2024 15:39:03 +0100
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
Message-ID: <20240725-filled-outscore-24149588d958@spud>
References: <20240722-imx-se-if-v6-0-ee26a87b824a@nxp.com>
 <20240722-imx-se-if-v6-2-ee26a87b824a@nxp.com>
 <20240722-popper-comfort-7538ea70c77b@spud>
 <AM9PR04MB8604123E065315093347F66C95A92@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <20240723-smitten-shower-1d15c0f3cf97@spud>
 <AM9PR04MB86043E4B4B2FB206BF9223C695AA2@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <20240724-huddling-neatly-88813c0b1f1d@spud>
 <DU2PR04MB85990A0AB8AF8ABFCDA4CBD995AB2@DU2PR04MB8599.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DB1xP50rYS+x7RPj"
Content-Disposition: inline
In-Reply-To: <DU2PR04MB85990A0AB8AF8ABFCDA4CBD995AB2@DU2PR04MB8599.eurprd04.prod.outlook.com>


--DB1xP50rYS+x7RPj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 07:06:30AM +0000, Pankaj Gupta wrote:
>=20
>=20
> > -----Original Message-----
> > From: Conor Dooley <conor@kernel.org>
> > Sent: Wednesday, July 24, 2024 9:00 PM
> > To: Pankaj Gupta <pankaj.gupta@nxp.com>
> > Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring <robh@kernel.org>;
> > Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> > <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> > <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; Rob
> > Herring <robh+dt@kernel.org>; linux-doc@vger.kernel.org; linux-
> > kernel@vger.kernel.org; devicetree@vger.kernel.org; imx@lists.linux.dev;
> > linux-arm-kernel@lists.infradead.org
> > Subject: Re: [EXT] Re: [PATCH v6 2/5] dt-bindings: arm: fsl: add imx-se=
-fw
> > binding doc

For the third time, please fix your mail client so it stops inserting
this garbage.

> >=20
> > On Wed, Jul 24, 2024 at 11:02:21AM +0000, Pankaj Gupta wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Conor Dooley <conor@kernel.org>
> > > > Sent: Tuesday, July 23, 2024 7:38 PM
> > > > To: Pankaj Gupta <pankaj.gupta@nxp.com>
> > > > Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring <robh@kernel.org>;
> > > > Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> > > > <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Sascha
> > Hauer
> > > > <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > > > <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; Rob
> > > > Herring <robh+dt@kernel.org>; linux-doc@vger.kernel.org; linux-
> > > > kernel@vger.kernel.org; devicetree@vger.kernel.org;
> > > > imx@lists.linux.dev; linux-arm-kernel@lists.infradead.org
> > > > Subject: Re: [EXT] Re: [PATCH v6 2/5] dt-bindings: arm: fsl: add
> > > > imx-se-fw binding doc
> >=20
> > Please fix this ^
> >=20
> > > > On Tue, Jul 23, 2024 at 09:28:31AM +0000, Pankaj Gupta wrote:
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Conor Dooley <conor@kernel.org>
> > > > > > Sent: Monday, July 22, 2024 10:20 PM
> > > > > > To: Pankaj Gupta <pankaj.gupta@nxp.com>
> > > > > > Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring
> > > > > > <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>;
> > > > > > Conor Dooley <conor+dt@kernel.org>; Shawn Guo
> > > > > > <shawnguo@kernel.org>; Sascha
> > > > Hauer
> > > > > > <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > > > > > <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; Rob
> > > > > > Herring <robh+dt@kernel.org>; linux-doc@vger.kernel.org; linux-
> > > > > > kernel@vger.kernel.org; devicetree@vger.kernel.org;
> > > > > > imx@lists.linux.dev; linux-arm-kernel@lists.infradead.org
> > > > > > Subject: [EXT] Re: [PATCH v6 2/5] dt-bindings: arm: fsl: add
> > > > > > imx-se-fw binding doc
> > > >
> > > > Please fix this ^
> > > >
> > > > > >
> > > > > > On Mon, Jul 22, 2024 at 10:21:37AM +0530, Pankaj Gupta wrote:
> > > In case of imx8ulp, there is a single node.
> > > Having a same node name for both parent and child, is bit strange.
> > > firmware {
> > > 	firmware {
> > > 	};
> > > };
> > >
> > > Request you to allow to re-evaluate this point.
> >=20
> > I dunno, it's all firmware so I don't really get why it is so strange!
> > Can you remind me again why it is inside a parent node to begin with?
>=20
> Three type of security firmware(s): HSM, V2X-SHE, V2X-HSM, are running at=
 the cores dedicated to the each different secure-enclave hardware IP(s).
> Each firmware receives the message to act and response back with the comp=
leted act.
> This message exchanges happens through the Message-Unit hardware interfac=
e.=20
> There could be multiple MU for multiple security firmware, that would be =
used for respective message exchanges.
>=20
> This node defines the details of each such MU interface.
>=20
> Reason to put under firmware:
> 	Since this node specifies interface details between kernel and firmware,=
 it was put under parent "firmware {".
> 	I am not sure if this reason is correct enough to begin with.
>=20
> Thanks for allowing to revisit.
>=20
> I will make the change to whatever you finalize now. Thanks.

I'm sorry, I still don't understand why you have the parent node. It
seems pointless to me, and this new node could be added at the top
level.

--DB1xP50rYS+x7RPj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZqJjhwAKCRB4tDGHoIJi
0vAQAQDbMuDjmie7EWxnnWqDa2jGC6LmbY6qAHkFO27uKsQt+wD6Ax+NJWtrZz69
lI1yzCU2LhiJN9t8XJxOoMELVtoPsAI=
=qgEY
-----END PGP SIGNATURE-----

--DB1xP50rYS+x7RPj--

