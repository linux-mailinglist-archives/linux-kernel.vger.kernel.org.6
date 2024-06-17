Return-Path: <linux-kernel+bounces-217868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EF490B55F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CB5C1C2142E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1305513B789;
	Mon, 17 Jun 2024 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXPal40q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EFB13AD0F;
	Mon, 17 Jun 2024 15:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718638855; cv=none; b=Zqo2hMbfQ5682K52MhU1od0MD6nuEVU5M28CEMHsKkLzLJHG4YSXhEmKvUl3WisHeNjyGMY2X2o6N67yEBv5R1riwuMMrbl5nUiLoYOEofoSRjTUcbStNpheDh3prqmSR47dMggcSFoirQMuZJxxw4xZnDJRmA23pv3E1+XXMu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718638855; c=relaxed/simple;
	bh=42hDqBHzInQELIWlWJ6Z/FBQrQe2GH5qVRKdgXovl2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tm3YI8IiotnKsvdHjr0pu4GRl52E1tU4KgWOzmCyR7NlbTD5Qk2X2Iw5xIhRwEIqI2FZoOrpBaDQ9QNwl4EC3PVY/NAK0hfH6PwS4HNqqNavU4HmXVIjoTHbeztUGXfIyCQa3HiUrL0CgVzrNYYWxbnBgPhkaMcjCQrTMN0U/d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXPal40q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63FBC2BD10;
	Mon, 17 Jun 2024 15:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718638854;
	bh=42hDqBHzInQELIWlWJ6Z/FBQrQe2GH5qVRKdgXovl2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BXPal40qQwXg9yBesIIsPIrSQU6dPocxlDznXC5WIw+h/lK+NrfL/Y+5UEDM6sf4z
	 ne0VGv/pBIe8ridyIR95LpL8M8owUAc2lWmfBTi1BrkwNFRSb8ZMbzmf9cKTvOXe+h
	 hwJzj8ASQlc7i64FQwbsp9VqoQ6lDzC/dINSIz5YyD/+Lf1HEWsgYycmT7zDGymzwV
	 xV0GHRKUNoscXTlOEfFA8dH4db8ETiJFWpK7cl0Z8ijIUm4a/RidmdcKSbv75xQp+B
	 FMWstlfXlxvBqpQflidLqtuIutF3KQbqhiYV+ZyrEuivPiMzcQu2wF9bKrW9Ka/jn+
	 AaC4WTDm+0xOQ==
Date: Mon, 17 Jun 2024 16:40:48 +0100
From: Conor Dooley <conor@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Yixun Lan <dlan@gentoo.org>, Inochi Amaoto <inochiama@outlook.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Chao Wei <chao.wei@sophgo.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/6] riscv: dts: sophgo: Put sdhci compatible in dt of
 specific SoC
Message-ID: <20240617-exuberant-protegee-f7d414f0976d@spud>
References: <20240612-sg2002-v2-0-19a585af6846@bootlin.com>
 <20240612-sg2002-v2-1-19a585af6846@bootlin.com>
 <IA1PR20MB49534C9E29E86B478205E4B3BBC02@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240616235829.GA4000183@ofsar>
 <c75601a1-1389-400e-90b9-99c1e775a866@bootlin.com>
 <ZnA3O14HOiV1SBPV@xhacker>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6tC78+3mmqFBDz9z"
Content-Disposition: inline
In-Reply-To: <ZnA3O14HOiV1SBPV@xhacker>


--6tC78+3mmqFBDz9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 09:16:43PM +0800, Jisheng Zhang wrote:
> On Mon, Jun 17, 2024 at 11:16:32AM +0200, Thomas Bonnefille wrote:
> > On 6/17/24 1:58 AM, Yixun Lan wrote:
> > > On 18:47 Wed 12 Jun     , Inochi Amaoto wrote:

> > > > Is this change necessary? IIRC, the sdhci is the same across
> > > > the whole series.

> sorry for being late, I was busy in the past 2.5 month. Per my
> understanding, the sdhci in cv1800b is the same as the one in
> sg200x. Maybe I'm wrong, but this was my impression when I cooked
> the sdhci driver patch for these SoCs.
>=20
> > > I tend to agree with Inochi here, if it's same across all SoC, then n=
o bother to
> > > split, it will cause more trouble to maintain..
> > >=20
> >=20
> > To be honest, I agree with this to, but as a specific compatible for the
> > SG2002 was created in commit 849e81817b9b, I thought that the best prac=
tice
> > was to use it.
>=20
> I'd like to take this chance to query DT maintainers: FWICT, in the past
> even if the PLIC is the same between SoCs, adding a new compatible for
> them seems a must. So when time goes on, the compatbile list would be
> longer and longer, is it really necessary? Can we just use the existing
> compatible string?
> DT maintainers may answered the query in the past, if so, sorry for
> querying again.

For new integrations of an IP, yes, new specific compatibles please. New
integrations may have different bugs etc, even if the IP itself is the
same. If there's different SoCs that are the same die, but with elements
fused off, then sure, use the same compatible.

I expect the list of compatibles in the binding to grow rather large, but
that is fine. No one SoC is going to do anything other than something like
compatible =3D "renesas,$soc-plic", "andestech,corecomplex-plic", "riscv,pl=
ic";
which I think is perfectly fine.


--6tC78+3mmqFBDz9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnBZAAAKCRB4tDGHoIJi
0l7HAP47j2HyEc+VKIMCrgYDBYv2vBXJXmUQgX5EoSTWn2eiggD9HUVWmEdowlqP
9Cn3abEuvtkfKb4yr9voKsKLFHWBsQM=
=hwsr
-----END PGP SIGNATURE-----

--6tC78+3mmqFBDz9z--

