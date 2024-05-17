Return-Path: <linux-kernel+bounces-182385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D87B68C8AA7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7752E1F25704
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEE313DDA9;
	Fri, 17 May 2024 17:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2eDkI91"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977FD12F5A3;
	Fri, 17 May 2024 17:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715966007; cv=none; b=t8wchxe/LXBa0f8m89trit/sAREICHYwUhqOEj+OFJZyOckG8BJHW5nUaJwDEOzQfEfeXNdqtX9n3Sjemq1WoY7inNQhKrr48XK6OVrQCdWplas/UFQDssB00mUcz4P7Fa8xQ9/jii+u6unQx4p3QfXzviTDpUk5jfFmxbyqcKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715966007; c=relaxed/simple;
	bh=eIB82ShxELVgBdcB/A5n4OiJqzz7D53HQjPat52aDwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gu1im1nCzNKcs5ZLSR3P0NlS6ipjfcYn7H+rJR4fKYGt2daNh4fKP7HuwmupYP9yKChAJtcLmEk9i85XIH7GB5HTnFQgauxzykDHYERRTlkiecX5spr9sUb/7vC0Nesnfg+Ksy7CIZIREB4cA/om5Psw/zGMfHHqkeUcM99Jn48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2eDkI91; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F22C2BD10;
	Fri, 17 May 2024 17:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715966007;
	bh=eIB82ShxELVgBdcB/A5n4OiJqzz7D53HQjPat52aDwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p2eDkI91pFS3fnmKgUUxrplDIkMWNwGS9C/lVsb1VRSG9t8FutGodJhWxij5EFYWs
	 aFw2m0F8zvZFEsx8B6TyjoHMTNxQOzr9HTpxniV2Hs09lGjAFA2+WKlASEU3JVKKqa
	 25N5906X9zGn44TPQBbp+lyquyPK3uxzP5RKp+wXfCp6mUepK502VzQgOWMkHCNccp
	 Dn/6+hvv8OMF8kk6Z3zVbvrsl7BtBXXbcNuqNAUrXZLPXlSzgjTNKWOBpI1txPlnvz
	 0wwfcinM1IDUM6NDIz4KMxscp4lkUtuTLygOqPYT28lbGqlweNPRWcnhXyZf+K4ncD
	 ozRd1UhOlRziQ==
Date: Fri, 17 May 2024 18:13:21 +0100
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
Message-ID: <20240517-afterglow-sandstone-076e593fedf8@spud>
References: <1715679210-9588-4-git-send-email-shengjiu.wang@nxp.com>
 <20240514-campus-sibling-21cdf4c78366@spud>
 <b86c83a520f0c45a60249468fa92b1de.sboyd@kernel.org>
 <CAA+D8ANTdvQJVtniyMtqjnJdT4qX+LDGjVuFO6H0RSO+GDw+ng@mail.gmail.com>
 <20240515-unbundle-bubble-8623b495a4f1@spud>
 <ZkT+4yUgcUdB/i2t@lizhi-Precision-Tower-5810>
 <20240516-reversing-demeanor-def651bc82ac@spud>
 <ZkbVa5KvvbnH/tNQ@lizhi-Precision-Tower-5810>
 <20240517-gristle-dealt-56b5299b9cb8@spud>
 <ZkePbZBufOHWQdzM@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xt3yTz/9sLzzf4YV"
Content-Disposition: inline
In-Reply-To: <ZkePbZBufOHWQdzM@lizhi-Precision-Tower-5810>


--xt3yTz/9sLzzf4YV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 01:10:05PM -0400, Frank Li wrote:
> On Fri, May 17, 2024 at 05:21:32PM +0100, Conor Dooley wrote:
> > On Thu, May 16, 2024 at 11:56:27PM -0400, Frank Li wrote:
> >=20
> > > Look like it is easy to register auxdev "reset" devices. But I have a
> > > problem. How to use it by DT phandle?  "reset" devices is service pro=
vider.
> > > Some client will use it.
> > >=20
> > > Generally, reset node will used by other devices nodes. like
> > >=20
> > > ABC: reset {
> > > 	compatible=3D"simple-reset";
> > > 	...
> > > }
> > >=20
> > > other node will use "reset =3D <&ABC 0>".  If use auxdev, how to get =
&ABC
> > > in dts file.
> >=20
> > Whether or not you use auxdev or any other method etc, does not matter
> > in a DT system, the consumer will always have a phandle to the provider
> > node:
> >=20
> > ABC: whatever {
> > 	compatible =3D "whatever";
> > 	#clock-cells =3D <...>;
> > 	#reset-cells =3D <...>;
> > }
> >=20
> > something-else {
> > 	clocks =3D <&ABC ...>;
> > 	resets =3D <&ABC ...>;
> > }
>=20
>=20
> It goes back to old problem, "reset-cells" will be in "clock-controller".
>=20
> clock-controller@30e20000 {
>         compatible =3D "fsl,imx8mp-audio-blk-ctrl", "syscon", "simple-mfd=
";
>         reg =3D <0x30e20000 0x10000>;
> 	...
> =09
> 	#reset-cells =3D <...>;
> 	^^^
>     };
>=20
> If create new "whatever" auxdev bus driver which included two aux devices=
,=20
> (clock and reset).=20
>=20
> it will be similar with mfd. Still need change
> clock-controller@30e20000 drivers.
>=20
> "Which is I suspect is gonna require a change to your clock driver,
> because the range in the existing clock nodes:
> 	audio_blk_ctrl: clock-controller@30e20000 {
> 		compatible =3D "fsl,imx8mp-audio-blk-ctrl";
> 		reg =3D <0x30e20000 0x10000>;
> 	};
> would then have to move to the mfd parent node, and your clock child
> would have a reg property that overlaps the reset region. You'd need to
> then define a new binding that splits the range in two - obviously
> doable, but significantly more work and more disruptive than using an
> auxdev."
>=20
> So I don't know why auxdev will be better than mfd.

I think Stephen and I have spent enough time trying to explain why using
auxdev is beneficial here. I, at least, won't be wasting any more of my
(metaphorical) breath.

> A possible benefit may be that Auxdev needn't binding doc for clock and
> reset node devices.


--xt3yTz/9sLzzf4YV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkeQMQAKCRB4tDGHoIJi
0gYFAPwKc+FHcmVmGrUDsNpNdPs1BSVvTRRziCDnTk17ziMFeAEA6IsAjmQ6/TRJ
PymGCZBH+JT2QFCLdgg7f7nFHjsA2go=
=fmDE
-----END PGP SIGNATURE-----

--xt3yTz/9sLzzf4YV--

