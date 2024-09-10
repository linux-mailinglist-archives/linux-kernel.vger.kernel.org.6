Return-Path: <linux-kernel+bounces-323415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD96973D07
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A138E1F24286
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAC41A0716;
	Tue, 10 Sep 2024 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgyNizoF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECA92AEF1;
	Tue, 10 Sep 2024 16:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725984828; cv=none; b=KPZ/VzCy3lI5Z6LAlKGasqEcdYeEK0dBO+pntTJDWV3HUa3kf1QEDJ3aoCA1BDo9Wy77gF3NpmfNwW2wjx+Cu0I+xui5RXh6BIJGBOgY5rDiyPJ/+pJfCwPD8jLgadE7no9UjCVWBK3b3s+H0KRiJwVVVFXLxW4pl2+jx3ShuCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725984828; c=relaxed/simple;
	bh=dOdR3AQgsVyZSdcajtpHjcfvmfwJd54PfZ0HuKjzNEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8UCQcGPTbL0yH3uf8sVKD3+fek0xvJqOwbSleZZNrncvcryiXIw7YIab6MA4HPvUYwZPdhMYQ4NZpqjoPhjd1EvHyiWyvVHqBJEspY8DirHz2Jt14Q3szgW21qtzHgSqnqqCEZn1O+8Zhwf3tCEVzuCA8xDQW0xIE6OK07JhG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgyNizoF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97733C4CEC3;
	Tue, 10 Sep 2024 16:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725984828;
	bh=dOdR3AQgsVyZSdcajtpHjcfvmfwJd54PfZ0HuKjzNEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MgyNizoF746o+zqMHs8s646fq8ley9zuXy4EFkWifAD6Cu/lxJbPvvvMPVfJa0/Sa
	 sTfoEzWXD3D6LH2ClrjDxj4aqvBCe+B+ScS9oIZMj9CPzhkJKmfpj3krvvu8rmbzLu
	 XWj65OOi7IYzjuz/a2An/EHqGn0qrFaXXVBSajydHd5M2eM5ccindUsfPBUyNinuAp
	 avgjOH11E5EkKDG0g7vVscCzp+900SR5nfyMK2f4MAryGjeXrrbkNlzLcRoudJRwud
	 c3bjVEFLmTc6onkATCF/hUEIXOZOA7/ce/Y88AIh3KPJIfkeHFRlsfmONv8he1Z8fM
	 QCiGe40jd0fpA==
Date: Tue, 10 Sep 2024 17:13:43 +0100
From: Conor Dooley <conor@kernel.org>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>,
	Haylen Chu <heylenay@outlook.com>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] riscv: sophgo: Add pinctrl support for CV1800
 series SoC
Message-ID: <20240910-bust-mulled-e45f6f6ef29d@spud>
References: <IA1PR20MB495374DB8C4208575AAC9675BB972@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240909-prowler-renewal-0592d820ccca@spud>
 <IA1PR20MB4953A0D6A2B73D03BF162671BB992@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5rQtVXXUCRQ43X6+"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB4953A0D6A2B73D03BF162671BB992@IA1PR20MB4953.namprd20.prod.outlook.com>


--5rQtVXXUCRQ43X6+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 06:24:34AM +0800, Inochi Amaoto wrote:
> On Mon, Sep 09, 2024 at 03:41:10PM GMT, Conor Dooley wrote:
> > On Sat, Aug 31, 2024 at 06:38:40AM +0800, Inochi Amaoto wrote:
> > > Add basic pinctrl driver for Sophgo CV1800 series SoCs.
> > > This patch series aims to replace the previous patch from Jisheng [1].
> > > Since the pinctrl of cv1800 has nested mux and its pin definination
> > > is discrete, it is not suitable to use "pinctrl-single" to cover the
> > > pinctrl device.
> > >=20
> > > This patch require another patch [2] that provides standard attribute
> > > "input-schmitt-microvolt"
> > >=20
> > > The v4 version is from [3]
> >=20
> > Which version of this ended up in linux-next? I see a link to v4 in
> > what's been applied, but this v5 was sent before that code was
> > committed.
> >=20
> > Either way, what's been applied and what's here produce warnings:
> > cv1812h.dtsi:19.28-24.5: Warning (simple_bus_reg): /soc/pinctrl@3008000=
: simple-bus unit address format error, expected "3001000"
> > cv1800b.dtsi:18.28-23.5: Warning (simple_bus_reg): /soc/pinctrl@3008000=
: simple-bus unit address format error, expected "3001000"
> >=20
> > It's just a copy-paste error I would imagine, but please send a fix.
>=20
> Yes, it is like some copy-paste error, I will fix it.

I'd rather you had sent some follow-up patches, than rebase your tree at
this point in the cycle. I assume you hadn't yet sent that stuff in a PR
to Arnd?

Cheers,
Conor.

--5rQtVXXUCRQ43X6+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuBwNwAKCRB4tDGHoIJi
0t5rAP4upEEdJUW2Gc+Vage29OZ9yngrJUbqENkbK/Ej9TAbRQD+OLDBe2aZ8tIR
uI1kXbmhKJKXdKpQEDrMWeaxtnPUNA0=
=+P8k
-----END PGP SIGNATURE-----

--5rQtVXXUCRQ43X6+--

