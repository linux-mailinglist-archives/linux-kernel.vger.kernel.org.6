Return-Path: <linux-kernel+bounces-261173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB2193B39C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 17:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941581F222A4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7949715B54C;
	Wed, 24 Jul 2024 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTR8ICKE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FBA15B0FD;
	Wed, 24 Jul 2024 15:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721835026; cv=none; b=jY93bwAxW5nhZ56cwv+IExTdV3ukeQX0nJ4o/yO21xYVS1RKsKbyLeRSPmixnI5Bw5avfJZa4I6PDKgaB7YM+fqVelf54/xQcPeuTlP1oOFDG1ArGHoKNdKwJYUhhcAEIst/q631796IVfs51CGFlSk7Yeo843Cwp+0soNLzAAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721835026; c=relaxed/simple;
	bh=x4JIxYLOL3n4x7H2TiBnN9TVgyp/rQf37dq6ZQicqcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjTDvqK2Snig2UrxhRTKZqU0KLiHf38zz8h9S5DRY1nlO9CpYcoL+2acahmbEUrnKdTQt7k4JpZNiqLuStU8ncKUx1yft0Ss0YxCBwFnPRMJMOZ1eu6xxYljVPScRsGqagKTdu8xPqlhqDThNPeyz14A6AKvtzBb77QGeog6zpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTR8ICKE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6572EC32781;
	Wed, 24 Jul 2024 15:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721835026;
	bh=x4JIxYLOL3n4x7H2TiBnN9TVgyp/rQf37dq6ZQicqcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XTR8ICKEhDJEVqk1lirX/oN9GgnKRLDK+DclpQWVHAOKqB3U594WALPHELVeKLO44
	 TCPxF9Ci4h7C4j69n5HKMxMFcL3T0ED5W+CW3oaLYYVGEdS6B2l01xPmImc8x6sJxq
	 +EAwJ5i+vDIxbAnJ3ftGY/EgnlVtD4WZIgQkB9eVkqCtdPmmR609bCKWVQmC/XS+mL
	 r0yt77KxpFDgJYWxUOAKYmCZsAtUb2Ta0tnGsx9iVg9Hv1cArOeju0HD/OzJToCjOM
	 VBoqPdRZyAo06gubKoI4YkLnynQEoG0mSFWXjJEY0VqqREv4pI6t4RAnTbI4M7abAJ
	 yJVxtWiFdnJ/Q==
Date: Wed, 24 Jul 2024 16:30:21 +0100
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
Message-ID: <20240724-huddling-neatly-88813c0b1f1d@spud>
References: <20240722-imx-se-if-v6-0-ee26a87b824a@nxp.com>
 <20240722-imx-se-if-v6-2-ee26a87b824a@nxp.com>
 <20240722-popper-comfort-7538ea70c77b@spud>
 <AM9PR04MB8604123E065315093347F66C95A92@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <20240723-smitten-shower-1d15c0f3cf97@spud>
 <AM9PR04MB86043E4B4B2FB206BF9223C695AA2@AM9PR04MB8604.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LrpZzGXbuUadIL7a"
Content-Disposition: inline
In-Reply-To: <AM9PR04MB86043E4B4B2FB206BF9223C695AA2@AM9PR04MB8604.eurprd04.prod.outlook.com>


--LrpZzGXbuUadIL7a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 11:02:21AM +0000, Pankaj Gupta wrote:
>=20
>=20
> > -----Original Message-----
> > From: Conor Dooley <conor@kernel.org>
> > Sent: Tuesday, July 23, 2024 7:38 PM
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

Please fix this ^

> > On Tue, Jul 23, 2024 at 09:28:31AM +0000, Pankaj Gupta wrote:
> > >
> > > > -----Original Message-----
> > > > From: Conor Dooley <conor@kernel.org>
> > > > Sent: Monday, July 22, 2024 10:20 PM
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
> > > > Subject: [EXT] Re: [PATCH v6 2/5] dt-bindings: arm: fsl: add
> > > > imx-se-fw binding doc
> >=20
> > Please fix this ^
> >=20
> > > >
> > > > On Mon, Jul 22, 2024 at 10:21:37AM +0530, Pankaj Gupta wrote:
> In case of imx8ulp, there is a single node.
> Having a same node name for both parent and child, is bit strange.=20
> firmware {
> 	firmware {
> 	};
> };
>=20
> Request you to allow to re-evaluate this point.

I dunno, it's all firmware so I don't really get why it is so strange!
Can you remind me again why it is inside a parent node to begin with?

--LrpZzGXbuUadIL7a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZqEeDQAKCRB4tDGHoIJi
0vNLAP9B3+lSmSKeUl35G6VMa+BVoLKLga/voXEFKNXJ8OyYqAEA7mDYMr9euD17
B/tWH+Nm/lWw86ujHuHim+Bh2yyCWg8=
=GNe/
-----END PGP SIGNATURE-----

--LrpZzGXbuUadIL7a--

