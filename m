Return-Path: <linux-kernel+bounces-449807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 094419F5660
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 19:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A370E1658E1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF6F1F9F51;
	Tue, 17 Dec 2024 18:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qrw/fJ4e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429F71F75A7;
	Tue, 17 Dec 2024 18:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734460400; cv=none; b=im+3uDRjSgm7sl4ISRRCf0MTmDwnae3KSv8sQ+zmWXKs2Is7zo8FWo7wXVrMwPG/Awjc4TjYUN+xSjrMLFzqihXyJjhHir8+BuorDObuABQIA3Wx/KyyoYN5Uq4hTg6S/JCAhRmKxOqPHCbFP+sDXlZS4tuigxc71JMuu2ve3JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734460400; c=relaxed/simple;
	bh=0LJCNoyysYP8N431fASKThLoY2yTIEXftjPpfxsGsqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0ttTpSNBNKnTbguUrDeKOvv6tkK2ElaiuePfAi7W999zBCV2ozAZ7jD21/j+3thFab0/n+5XsGsO1DRWLQCHYntGRQWO0Ab455kUV3n3ck1GMfMd7FoGxJieBvviQPb2JmWkAm9iHXtWByseYVLg7AA3BN19xFzWLqcO8Xfm9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qrw/fJ4e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A324C4CED3;
	Tue, 17 Dec 2024 18:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734460399;
	bh=0LJCNoyysYP8N431fASKThLoY2yTIEXftjPpfxsGsqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qrw/fJ4ehP2/+6XX1m6k5ZoHxty43jYoXBs94Aacn8MwgJFX21xvjtT4BC5CsEanf
	 e4H2pmtX5beery5cYDuj7D7clLV7o0+2vdQ9mWbt6QHvUEF5TIsMvRUyxO0Gn9Mtte
	 BqHiLY1O3xEOokKRqqXj0evcxTl8XfaZlYBKz31idBrrw8+HBy+ikgPVd1CnNwp+iI
	 h+7Rrd1EInJV6VJtMAabVGXtTdCIUapKf7TZuuDm2Yz6JjqUshQ9ManzY33b7uWAwD
	 jGeivwQHcOBUvTF2OafyQUTDI9vhWaW0UjxGTvBP/T7jBLNw9mmvNQcSVgxMzkNF2h
	 0MxgTzy8XD2YA==
Date: Tue, 17 Dec 2024 18:33:14 +0000
From: Conor Dooley <conor@kernel.org>
To: E Shattow <e@freeshell.de>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jianlong Huang <jianlong.huang@starfivetech.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Subject: Re: [PATCH] riscv: dts: starfive: jh7110-common: Use named
 definition for mmc1 card detect
Message-ID: <20241217-strained-latch-52bf7d03716d@spud>
References: <20241210040652.164030-1-e@freeshell.de>
 <20241216-elixir-cupped-f7a83bce4e12@spud>
 <ZQ2PR01MB1307F1FC7EEB8701525AC9DEE604A@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
 <bd4df536-0a5d-4ba9-ad0c-51a7828acd9c@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zM9vNY+QhMihoDl/"
Content-Disposition: inline
In-Reply-To: <bd4df536-0a5d-4ba9-ad0c-51a7828acd9c@freeshell.de>


--zM9vNY+QhMihoDl/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 07:25:59PM -0800, E Shattow wrote:
> Hi, Hal
>=20
> On 12/16/24 18:02, Hal Feng wrote:
> > > On 17.12.24 04:13, Conor Dooley wrote:
> > > On Mon, 09 Dec 2024 20:06:46 -0800, E Shattow wrote:
> > > > Use named definition for mmc1 card detect GPIO instead of numeric l=
iteral.
> > > >=20
> > > >=20
> > >=20
> > > Applied to riscv-dt-for-next, thanks!
> > >=20
> > > [1/1] riscv: dts: starfive: jh7110-common: Use named definition for m=
mc1
> > > card detect
> > >        https://git.kernel.org/conor/c/c96f15d79172
> >=20
> > No, here "41" means the GPIO number, but GPI_SYS_SDIO1_CD means the
> > multiplexed function and should be used by pinctrl pinmux not gpio subs=
ystem.
> > Although GPI-SYS_SDIO1_CD is numerically the same as 41.
> >=20
> > Best regards,
> > Hal
>=20
> You're right, Hal. I'm confused trying to make sense of this.
>=20
> From dts/upstream/src/riscv/starfive/jh7110-pinfunc.h:
>=20
> "gpio nr:  gpio number, 0 - 63"
>=20
> And yet in dts/upstream/src/riscv/starfive/jh7110-common.dtsi there's:
>=20
> >                        pinmux =3D <PINMUX(64, 0)>,
> >                                 <PINMUX(65, 0)>,
> >                                 <PINMUX(66, 0)>,
> >                                 <PINMUX(67, 0)>,
> >                                 <PINMUX(68, 0)>,
> >                                 <PINMUX(69, 0)>,
> >                                 <PINMUX(70, 0)>,
> >                                 <PINMUX(71, 0)>,
> >                                 <PINMUX(72, 0)>,
> >                                 <PINMUX(73, 0)>;
>=20
>=20
> Loosely on the subject of MMC interface and GPIO numbering, what is the
> above code doing? These are not GPIO numbers 0-63 so what is this?
>=20
> I'm trying to understand this so I can write the Mars CM (-Lite) dts.
>=20


> Conor, and Hal: sorry for the mistake there.

No worries, I've dropped the patch.

--zM9vNY+QhMihoDl/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ2HD6gAKCRB4tDGHoIJi
0hx5AQCjUaWDZdSICwuiFgW3qzlx/fAJ5VM/9GybUgK3QXXf2wEA4m4EvN0dnQ9y
4vL2IE0lHykSUmNH+cll76hi+n8ciwY=
=90mb
-----END PGP SIGNATURE-----

--zM9vNY+QhMihoDl/--

