Return-Path: <linux-kernel+bounces-180106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A528C6A2A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 18:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25B50B237A9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB053156253;
	Wed, 15 May 2024 16:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCcSlwu0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE31F156230;
	Wed, 15 May 2024 16:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715789095; cv=none; b=OczOJo4lCs0JXWHcVr4gXqDcHQK5eBcK1cwaIRHMeilKQd2/JDAk5LbUIFiN4tBEqjupXx/gtyc3TmYm2yk5I9KHtitjMlJp7F9KsAVKshjqPPIkf0+3UNAaPGe9POgm2T0fqZugmAGfM3eNsOdye1GSuTOvVx/199/agKlfYy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715789095; c=relaxed/simple;
	bh=kycUkpRBcEikOS2uUOytIdiW0vootLzo+kRSUZqPy74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpYCrJOPxRWOiSKwaW6iFmh3kvcSNhHOgZu/tLyknD1f9qZLtSLBAnbigJwBsaVKZeka7A7oWUsitj3SPhNo3Q0VCRHInf4KMZhdSwHRRe+R+Pjts0I/Y1Kkpjqh1IbIERFMSmuYb306E28riC7MhSxubYONr6it66fIvru9TKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCcSlwu0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32CDC116B1;
	Wed, 15 May 2024 16:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715789094;
	bh=kycUkpRBcEikOS2uUOytIdiW0vootLzo+kRSUZqPy74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GCcSlwu0Q1/BIvPguL9ykFpvGDB2rB0mNxZugMR4JErdsSybEMwsnH+kD4jm55LOV
	 S57Vv9wDidtYn/yVdM6wZD0NURFEddwGlz3slZ02HIR/giNMbynTMgxVnCVGW6WSbF
	 ICWck8njLb+XWO79UraQpW/k6zSJDzw3CefFySezm7wWZVhw2Cqk1WsB60ixo7rrwK
	 yK+IPO3c1UTjfm1S2w3SIAsOR+notDXFoyRpbxX/mYAhE1Nj0LWepFnsw52LJDWASe
	 Uvnh/kNRZQpy0gzQo1refhavCN8Hk8CljYYjQhj1gzZdzFBCc2eyxkGQkK9RD5Wcj6
	 6htRJ70HCYbGg==
Date: Wed, 15 May 2024 17:04:48 +0100
From: Conor Dooley <conor@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>,
	abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, marex@denx.de, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	p.zabel@pengutronix.de
Subject: Re: [PATCH v3 3/6] dt-bindings: clock: imx8mp: Add reset-controller
 sub-node
Message-ID: <20240515-unbundle-bubble-8623b495a4f1@spud>
References: <1715679210-9588-1-git-send-email-shengjiu.wang@nxp.com>
 <1715679210-9588-4-git-send-email-shengjiu.wang@nxp.com>
 <20240514-campus-sibling-21cdf4c78366@spud>
 <b86c83a520f0c45a60249468fa92b1de.sboyd@kernel.org>
 <CAA+D8ANTdvQJVtniyMtqjnJdT4qX+LDGjVuFO6H0RSO+GDw+ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GkjvzzTYbAGBWol4"
Content-Disposition: inline
In-Reply-To: <CAA+D8ANTdvQJVtniyMtqjnJdT4qX+LDGjVuFO6H0RSO+GDw+ng@mail.gmail.com>


--GkjvzzTYbAGBWol4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 10:47:57AM +0800, Shengjiu Wang wrote:
> On Wed, May 15, 2024 at 5:09=E2=80=AFAM Stephen Boyd <sboyd@kernel.org> w=
rote:
> >
> > Quoting Conor Dooley (2024-05-14 11:06:14)
> > > On Tue, May 14, 2024 at 05:33:27PM +0800, Shengjiu Wang wrote:
> > > > diff --git a/Documentation/devicetree/bindings/clock/imx8mp-audiomi=
x.yaml b/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
> > > > index 0a6dc1a6e122..a403ace4d11f 100644
> > > > --- a/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
> > > > +++ b/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
> > > > @@ -15,7 +15,10 @@ description: |
> > > >
> > > >  properties:
> > > >    compatible:
> > > > -    const: fsl,imx8mp-audio-blk-ctrl
> > > > +    items:
> > > > +      - const: fsl,imx8mp-audio-blk-ctrl
> > > > +      - const: syscon
> > > > +      - const: simple-mfd
> > > >
> > > >    reg:
> > > >      maxItems: 1
> > > > @@ -44,6 +47,11 @@ properties:
> > > >        ID in its "clocks" phandle cell. See include/dt-bindings/clo=
ck/imx8mp-clock.h
> > > >        for the full list of i.MX8MP IMX8MP_CLK_AUDIOMIX_ clock IDs.
> > > >
> > > > +  reset-controller:
> > > > +    type: object
> > > > +    $ref: /schemas/reset/fsl,imx8mp-audiomix-reset.yaml#
> > > > +    description: The child reset devices of AudioMIX Block Control.
> > >
> > > Why not just set #reset-cells =3D <1> in the existing node? IIRC it w=
as
> > > already suggested to you to do that and use auxdev to set up the reset
> > > driver.
> >
> > Yes, do that.
>=20
> Can I know why sub nodes can't be used? the relationship of parent and
> child devices looks better with sub nodes.

That's pretty subjective. I don't think it looks better to have a clock
node that is also a syscon with a reset child node as it is rather
inconsistent.
>=20
> A further question is can I use the reset-ti-syscon? which is a generic r=
eset
> device for SoCs.  with it I don't even need to write a new reset device d=
river.
> it is more simple.

That is for a TI SoC. You're working on an imx. I don't think that you
should be using that...

--GkjvzzTYbAGBWol4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkTdIAAKCRB4tDGHoIJi
0m6SAP9agCG57rgGJON9yd0a66dM6NoL7HfdAEzVst0qNsrwUwD+PuKQSxOna4Jj
BC+nCXgi21EE+l22nlaOgorkcGibTA4=
=3gXG
-----END PGP SIGNATURE-----

--GkjvzzTYbAGBWol4--

