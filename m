Return-Path: <linux-kernel+bounces-337400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 101A498498D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83FA1B24BD7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F121AB6EF;
	Tue, 24 Sep 2024 16:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyeZO+mE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02FAD531;
	Tue, 24 Sep 2024 16:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727195185; cv=none; b=uCUqqZ6dkwuLb74YnSUH7cf6iFI4eGUhVDNVClBiVe+KqNdXEh3NuAhZVuU1KCXolVDZjPZcTGcizO+nVrZUeKaybAGreCNqkyg0oaBciDCNjfJL0oPU11Qzc7np2J9X5Qd3l7ugmHy2wr2mbblpjxzawy9936qoNuLexTl+ViU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727195185; c=relaxed/simple;
	bh=DOqNrBus5khy2mu8X0lPPo/d0p67Z7fHJKwABB8mpW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xl1mtege30YUba70hh5y3HnWMbBD/ehI7W/6YJ6VNKFs5Rf4LtY4g/qWq9IM3uMGvyGDckthCDyHjz62s8Aod2msdS2jJq8A4BEuGhwydGynRwKOIn3maEIAvQpxrAu3ClOd19GxbTr4PRAgH3ADJ/axvCbgARxLPybRMbrvmqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyeZO+mE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87435C4CEC4;
	Tue, 24 Sep 2024 16:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727195184;
	bh=DOqNrBus5khy2mu8X0lPPo/d0p67Z7fHJKwABB8mpW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fyeZO+mErroNrBSgULOwcva6kbr76WvSP5MArjfRJ/kNS/YZWjX4sr9KJz58a1z/T
	 /x1eX6pq7RKF9bz/Tztk3WjgN+3BZXBtU+H0QYoHdltwtITBxSHsLeYtWyhbkS4zyI
	 U6QSf7T3aH3WB7Ipe1Jpptj3i1KYZFSO/ZN/VJF9vN7RDMcTu2Jdnr54EBTAC3ygr7
	 8tVOMveqPV0xZfpTzGe2E13C3ztIwlrK96p2qxjQY8hXz8LuP3q6Nqo9RYUTHsOEmQ
	 PUlqjPOLuv8xY5qKsVVL7bLwfcKVmQ8oINOGkGp/chYK+O0cpDcz2bdY9hnx0nixc4
	 aBdC4Bty8Rf8w==
Date: Tue, 24 Sep 2024 17:26:18 +0100
From: Conor Dooley <conor@kernel.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc: Sandie Cao <sandie.cao@deepcomputing.io>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Michael Zhu <michael.zhu@starfivetech.com>,
	Drew Fustini <drew@beagleboard.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, dhs@frame.work, ams@frame.work,
	gregkh@linuxfoundation.org, yuning.liang@deepcomputing.io,
	huiming.qiu@deepcomputing.io
Subject: Re: [patch v2 3/3] riscv: dts: starfive: add framework dts
Message-ID: <20240924-ended-tactics-b2e779875a76@spud>
References: <20240924080650.1345485-4-sandie.cao@deepcomputing.io>
 <75d4f0395187f7950e0450a91fbe087d@milecki.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f5CsaSLaLqFN6mer"
Content-Disposition: inline
In-Reply-To: <75d4f0395187f7950e0450a91fbe087d@milecki.pl>


--f5CsaSLaLqFN6mer
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 11:55:44AM +0200, Rafa=C5=82 Mi=C5=82ecki wrote:
> On 2024-09-24 10:06, Sandie Cao wrote:
> > diff --git a/arch/riscv/boot/dts/starfive/jh7110-framework.dts
> > b/arch/riscv/boot/dts/starfive/jh7110-framework.dts
> > new file mode 100644
> > index 000000000000..ff12c24ebab3
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/starfive/jh7110-framework.dts
> > @@ -0,0 +1,34 @@
> > +// SPDX-License-Identifier: GPL-2.0 OR MIT
> > +/*
> > + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> > + * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
> > + */
> > +
> > +/dts-v1/;
> > +#include "jh7110-common.dtsi"
> > +
> > +/ {
> > +	model =3D "Framework FRANME0000";
> > +	compatible =3D "deepcomputing,fm7110", "starfive,jh7110";
> > +};
>=20
> Nitpicking: property "compatible" should go first.
>=20
> See Documentation/devicetree/bindings/dts-coding-style.rst

I think "model" usually goes before compatible, I wouldn't change it
here.

--f5CsaSLaLqFN6mer
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvLoKgAKCRB4tDGHoIJi
0hEwAP9qlgaPcQGuJMokpi9NuIXGcdP7TrRN34mjUCdLTxXL0QEA0I5qKOqWwcj5
GLvAFrTd6v2Fb1p45ufZ1Vfl/Ff4Jws=
=AnWM
-----END PGP SIGNATURE-----

--f5CsaSLaLqFN6mer--

