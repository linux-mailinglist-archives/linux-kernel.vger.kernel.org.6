Return-Path: <linux-kernel+bounces-181357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D25A18C7AF0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01ED01C21A93
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AB1156249;
	Thu, 16 May 2024 17:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ta6k+4xH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DAB155388;
	Thu, 16 May 2024 17:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715879725; cv=none; b=JCHHo8XGYWxUj1eciE8RgOsm9GN4kiEBIseTEuPPBk1eI3ufOTTJorLrkYXNTWVRr7OZ7pubfo44Utjj/OLKuG2flSAvj/tgz/1VnC5M4to0DKZ7y1zaZMCy6wAqEkP1IyGzlFJAOLEMTu63M6V0zeDdzf/qXGURljm6l4aCjU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715879725; c=relaxed/simple;
	bh=tJHICD/Spu7eyWw+3JsUCt45YC1BDTTlj6WiULrpyjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwUfRCDiETqxM1cks92ApVFgZ68Z8zMxhgmHlqzOo5TAEmlTLcwNY2LKnPqyjBWw9988Ho+ckK445WNbyd/Siy19bI5YqQFKVcH3uGJ1TqZmJsNkbc09eM6+XeanH+bmglSPfqshuFspeMchEeELokToIEO300xy57q3A2UefBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ta6k+4xH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BC2C113CC;
	Thu, 16 May 2024 17:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715879724;
	bh=tJHICD/Spu7eyWw+3JsUCt45YC1BDTTlj6WiULrpyjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ta6k+4xHFjq8OMAL8mQH/vxXeT08gJX4KhTtsBpFPKWTUhfZY8hLfhV33XVBe72r7
	 PokO8N81kRVzAFYmolhItHrFfsih4DSGPiyfmGKxNrjiUxEMF8pqCW5tVSguH+IaNi
	 M1ekGqPXV3U9g1jmNJzaPwG1GAorYN/g+fsQHo+X42EUgErNrZmthTHpm5VDogt1D+
	 a3JMvwY5oVrQF5eHKcTJlzvhkRg2RJwUVRaVmQoItmjvCnTIuOKqtYm/XdANZMBHTq
	 llyeZ3Wqq8Mfrhn5DMlSWrBqo3p4F4cqwgJyMz2qMf4tzl9xawmY2hC3X4BZfPup64
	 XNKCxcoznr2CA==
Date: Thu, 16 May 2024 18:15:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org,
	peng.fan@nxp.com, mturquette@baylibre.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	marex@denx.de, linux-clk@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, p.zabel@pengutronix.de
Subject: Re: [PATCH v3 3/6] dt-bindings: clock: imx8mp: Add reset-controller
 sub-node
Message-ID: <20240516-reversing-demeanor-def651bc82ac@spud>
References: <1715679210-9588-1-git-send-email-shengjiu.wang@nxp.com>
 <1715679210-9588-4-git-send-email-shengjiu.wang@nxp.com>
 <20240514-campus-sibling-21cdf4c78366@spud>
 <b86c83a520f0c45a60249468fa92b1de.sboyd@kernel.org>
 <CAA+D8ANTdvQJVtniyMtqjnJdT4qX+LDGjVuFO6H0RSO+GDw+ng@mail.gmail.com>
 <20240515-unbundle-bubble-8623b495a4f1@spud>
 <ZkT+4yUgcUdB/i2t@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="U2yG7SBZt5e06VSB"
Content-Disposition: inline
In-Reply-To: <ZkT+4yUgcUdB/i2t@lizhi-Precision-Tower-5810>


--U2yG7SBZt5e06VSB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 02:28:51PM -0400, Frank Li wrote:
> On Wed, May 15, 2024 at 05:04:48PM +0100, Conor Dooley wrote:
> > On Wed, May 15, 2024 at 10:47:57AM +0800, Shengjiu Wang wrote:
> > > On Wed, May 15, 2024 at 5:09=E2=80=AFAM Stephen Boyd <sboyd@kernel.or=
g> wrote:
> > > >
> > > > Quoting Conor Dooley (2024-05-14 11:06:14)
> > > > > On Tue, May 14, 2024 at 05:33:27PM +0800, Shengjiu Wang wrote:
> > > > > > diff --git a/Documentation/devicetree/bindings/clock/imx8mp-aud=
iomix.yaml b/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
> > > > > > index 0a6dc1a6e122..a403ace4d11f 100644
> > > > > > --- a/Documentation/devicetree/bindings/clock/imx8mp-audiomix.y=
aml
> > > > > > +++ b/Documentation/devicetree/bindings/clock/imx8mp-audiomix.y=
aml
> > > > > > @@ -15,7 +15,10 @@ description: |
> > > > > >
> > > > > >  properties:
> > > > > >    compatible:
> > > > > > -    const: fsl,imx8mp-audio-blk-ctrl
> > > > > > +    items:
> > > > > > +      - const: fsl,imx8mp-audio-blk-ctrl
> > > > > > +      - const: syscon
> > > > > > +      - const: simple-mfd
> > > > > >
> > > > > >    reg:
> > > > > >      maxItems: 1
> > > > > > @@ -44,6 +47,11 @@ properties:
> > > > > >        ID in its "clocks" phandle cell. See include/dt-bindings=
/clock/imx8mp-clock.h
> > > > > >        for the full list of i.MX8MP IMX8MP_CLK_AUDIOMIX_ clock =
IDs.
> > > > > >
> > > > > > +  reset-controller:
> > > > > > +    type: object
> > > > > > +    $ref: /schemas/reset/fsl,imx8mp-audiomix-reset.yaml#
> > > > > > +    description: The child reset devices of AudioMIX Block Con=
trol.
> > > > >
> > > > > Why not just set #reset-cells =3D <1> in the existing node? IIRC =
it was
> > > > > already suggested to you to do that and use auxdev to set up the =
reset
> > > > > driver.
> > > >
> > > > Yes, do that.
> > >=20
> > > Can I know why sub nodes can't be used? the relationship of parent and
> > > child devices looks better with sub nodes.
> >=20
> > That's pretty subjective. I don't think it looks better to have a clock
> > node that is also a syscon with a reset child node as it is rather
> > inconsistent.
>=20
> I think it is multi function device syscon node. it should be like
>=20
> mfd
> {
> 	clock
> 	{
> 		...
> 	}
>=20
> 	reset
> 	{
> 		...
> 	}
> }
>=20
> clock and reset are difference device node with totally difference's
> compatible string.

Which is I suspect is gonna require a change to your clock driver,
because the range in the existing clock nodes:
	audio_blk_ctrl: clock-controller@30e20000 {
		compatible =3D "fsl,imx8mp-audio-blk-ctrl";
		reg =3D <0x30e20000 0x10000>;
	};
would then have to move to the mfd parent node, and your clock child
would have a reg property that overlaps the reset region. You'd need to
then define a new binding that splits the range in two - obviously
doable, but significantly more work and more disruptive than using an
auxdev.

> > > A further question is can I use the reset-ti-syscon? which is a gener=
ic reset
> > > device for SoCs.  with it I don't even need to write a new reset devi=
ce driver.
> > > it is more simple.
> >=20
> > That is for a TI SoC. You're working on an imx. I don't think that you
> > should be using that...
>=20
> I think this statement violate the linux basic reuse prinicple. If the
> code logic are the same why need duplicate it just because it is differen=
ce
> company. Of coures, if it is generic enough, it'd better to add a more
> generic compatible string.

That's true, but I suspect it only works because only through (ab)use
of the ti,reset-bits property not because you're actually compatible
with TI's reset hardware.

Cheers,
Conor.

--U2yG7SBZt5e06VSB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkY/JgAKCRB4tDGHoIJi
0q+6AQCaCdwhlVdXFZP7SLpIqoKwLTKzXYkUuCLzJaLFquKGEQD9Gnc2Qf41W7Rp
SFmFc2JvIqe5qBGdEVUNt25VHvyqsgA=
=A/oq
-----END PGP SIGNATURE-----

--U2yG7SBZt5e06VSB--

