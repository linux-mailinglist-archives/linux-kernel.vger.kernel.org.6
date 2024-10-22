Return-Path: <linux-kernel+bounces-376693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FC29AB4F5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F38B1C2092E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393F81BD50D;
	Tue, 22 Oct 2024 17:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fODqioL5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E531BD4E0;
	Tue, 22 Oct 2024 17:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729617838; cv=none; b=V5hVmgKPsCa78fTDrPsMNrwKvYCjJpRaj1XablQCEyhyQr6k35nN4hig9IvjljTqL+k0uDviYhGFrQo8eGqvQ3b9cnIUfTKaC8+xxIXvlMbZ2+/LQBp4O9cu3Uk++hfF9whOcC287Hb5AoktRBr9RKuIuwLQTe/wgyjPRlHUES4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729617838; c=relaxed/simple;
	bh=u774XJNJoKaoO7NkJoZ6UrZ6tUzrujqv0gRuGOzw/hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shaBt0LF9hSIPgqeqLwWTehV8OP6L6LOf/NuFeYofUO4dMjFgI1u6bMA6Ule8tmZwafSZxpVm3+Huhtffc0qByL09kvaLEOItxvOjv4TbFwaVpmvL3e45YL+rHk3uTGgEsiBsW2X3c++0yJ12tVWK8xay1Fn9J9SFK6ucT76Jtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fODqioL5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96122C4CEC3;
	Tue, 22 Oct 2024 17:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729617838;
	bh=u774XJNJoKaoO7NkJoZ6UrZ6tUzrujqv0gRuGOzw/hg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fODqioL5YDB0GPyFq7GnX4U/RJwKQTIXdfMCHOpPXB8lT0AmCmjbsHBbvb+c33QCD
	 zxieNmT+ESorvyOEpKL6pHuvEKnZ3MXFamJiEA99iS3xUsBwKPOhAqL97AUNyLwosV
	 EJ9Pjg/d9ZmscmCFEqq+PdWyeJyReFUQViKwtf94yzzotdDwEzHu3ogziBN91mIpZQ
	 IDtkhHjrq2vFCLANnec6WtTzXUnky4VckPLJvJHzEs4QmiCTEMmbZXkQTVtTFL9RXT
	 Z8aEjr0NgfHNaHGjv1OeCuQOERkN3fSiSBL8eV3QJTAT2QCbATu2S8Udq07jlMPrwq
	 yxjxt6l6BLw2g==
Date: Tue, 22 Oct 2024 18:23:52 +0100
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Yassine Oudjana <yassine.oudjana@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Sam Shih <sam.shih@mediatek.com>,
	Yassine Oudjana <y.oudjana@protonmail.com>,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: clock: mediatek: Add bindings for
 MT6735 syscon clock and reset controllers
Message-ID: <20241022-map-unsightly-fafb554b8f9b@spud>
References: <20241021121618.151079-1-y.oudjana@protonmail.com>
 <20241021121618.151079-2-y.oudjana@protonmail.com>
 <20241021-goatskin-wafer-7582dbcfe1d1@spud>
 <78f4da13-cbff-415b-a8eb-ec16108b5c00@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MGdtz8fU63TqFAKQ"
Content-Disposition: inline
In-Reply-To: <78f4da13-cbff-415b-a8eb-ec16108b5c00@collabora.com>


--MGdtz8fU63TqFAKQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 11:36:20AM +0200, AngeloGioacchino Del Regno wrote:
> Il 21/10/24 18:56, Conor Dooley ha scritto:
> > On Mon, Oct 21, 2024 at 03:16:15PM +0300, Yassine Oudjana wrote:
> > > From: Yassine Oudjana <y.oudjana@protonmail.com>
> > >=20
> > > Add device tree bindings for syscon clock and reset controllers (IMGS=
YS,
> > > MFGCFG, VDECSYS and VENCSYS).
> > >=20
> > > Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> > > ---
> > >   .../bindings/clock/mediatek,syscon.yaml           |  4 ++++
> > >   MAINTAINERS                                       |  6 ++++++
> > >   .../dt-bindings/clock/mediatek,mt6735-imgsys.h    | 15 ++++++++++++=
+++
> > >   .../dt-bindings/clock/mediatek,mt6735-mfgcfg.h    |  8 ++++++++
> > >   .../dt-bindings/clock/mediatek,mt6735-vdecsys.h   |  9 +++++++++
> > >   .../dt-bindings/clock/mediatek,mt6735-vencsys.h   | 11 +++++++++++
> > >   .../dt-bindings/reset/mediatek,mt6735-mfgcfg.h    |  9 +++++++++
> > >   .../dt-bindings/reset/mediatek,mt6735-vdecsys.h   | 10 ++++++++++
> >=20
> > Is it really necessary to have individual files foe each of these? Seems
> > a bit extra, no?
> >=20
>=20
> It's only good for including smaller headers in each driver (and/or DT, b=
ut
> then the SoC DT will anyway include them all).
>=20
> I'm fine with that, but I'm also fine with one header for clock and one f=
or reset.
>=20
> So.. Conor, it's however you prefer :-)

It's not worth respinning for, IMO, but I think having 8 and 9 line
header files for 2 definitions is silly.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

--MGdtz8fU63TqFAKQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxffqAAKCRB4tDGHoIJi
0jppAQC3jp73TDDQ8ceo7QUcuVoccM5RURc39pRsxAGOCXGfdwEA/dA9MNvMdUWv
jSwY6hOKcpjb/PE5XD01uo3g0gxiBwE=
=3GWk
-----END PGP SIGNATURE-----

--MGdtz8fU63TqFAKQ--

