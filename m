Return-Path: <linux-kernel+bounces-372109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FECA9A4488
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CD3FB219BF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F80520401B;
	Fri, 18 Oct 2024 17:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XiBvq8X7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97A42038A3;
	Fri, 18 Oct 2024 17:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729272268; cv=none; b=BF5DltKlNEav+quEi7OOEztn5zyqgAh6yHuHO9Z2u3NREj/rrz+o0KrA7yV3/R95NO2QV4W6KySp5U2aJZQbBh+h/WtaJoAPh2lXSicAU49eM84VEYTedtGCsNavbMTA1qwpx87g1eAckL2mZ1vbC2UJzjsY3KPr+JSmBbOi+cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729272268; c=relaxed/simple;
	bh=UGHLHISoYwkqg+DTIVYr4W8oQySlGfFRFD1iqVqMmgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eEL+EJns3NUytw8dI0uC/0qTvegbKENHYwo0mIdRYPSZsVyl6H04u8b3Ab62OG1nxTnAjesJRjOfEmhOBj0NadbNA94hze9EXGzEYX/XxUPWNeDLY/i0dhSOtM1deIKLDtG5oX26KDFQnsEDVAknOSGBMJKnJfwxsXIKf39xuxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XiBvq8X7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68027C4CEC3;
	Fri, 18 Oct 2024 17:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729272267;
	bh=UGHLHISoYwkqg+DTIVYr4W8oQySlGfFRFD1iqVqMmgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XiBvq8X7aIa0wZEWnG/9imW3rNMoM6AJo0UhETW/fgSaW8EaqNGfJCntNSIQrsReO
	 JSNj3OexlaByHpKtwhxXbFDV1I33PU5PWz5LhGMZkQAvZxGEU23oIhm8twSpKtlaB/
	 t/6fkMSyc8wjjpd+h764qieoaaDF0l37y/M0WS0hrVGx5YCU0olkg1YfYj1YJhNBDO
	 Z4nL7nbKVrq/QHj/HMfECa6WrWmKFJGHrxXAC66B1Nw+Y+P2ywkU7srntwn7plX1q9
	 sOzbCha4EPrri8fLbMYgitYicSvH9ide2QPRmPgtq/Yfzr0HN51UiPFdIETO9LbvcK
	 f2O/YItJs4/4w==
Date: Fri, 18 Oct 2024 18:24:21 +0100
From: Conor Dooley <conor@kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: dlan@gentoo.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
	cyy@cyyself.name, samuel.holland@sifive.com, anup@brainfault.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, inochiama@outlook.com,
	uwu@icenowy.me, zhangmeng.kevin@spacemit.com, kevin.z.m@hotmail.com,
	matthias.bgg@kernel.org, Haylen Chu <heylenay@4d2.org>,
	Troy Mitchell <troymitchell988@gmail.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Jesse T <mr.bossman075@gmail.com>
Subject: Re: [PATCH v5 00/10] riscv: add initial support for SpacemiT K1
Message-ID: <20241018-drapery-stable-cc31a97cda90@spud>
References: <20240730-k1-01-basic-dt-v5-0-98263aae83be@gentoo.org>
 <mhng-5bc45db9-5deb-4db6-8733-561768b2968c@palmer-ri-x1c9>
 <20240917-spoilage-nimble-a8303fd04482@squawk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zVmVDX70lgniahsX"
Content-Disposition: inline
In-Reply-To: <20240917-spoilage-nimble-a8303fd04482@squawk>


--zVmVDX70lgniahsX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2024 at 10:08:03PM +0100, Conor Dooley wrote:
> In other news, nobody has really made an "official" statement about who
> is going to maintain this particular platform. People have expressed
> interest (including the submitter of the series, IIRC) but there's no
> MAINTAINERS entry added here AFAICT. I used to have an entry that
> covered arch/riscv/boot/dts/*, with exclusions for sunxi and renesas,
> but with Drew taking on thead and sophgo being the res=E3=81=BDonsibility=
 of
> Chen Wang and Inochi, I no longer have that wildcard.
>=20
> I'm happy to apply patches for the platform if noone else is interested
> in that side of things, provided there are willing reviewers, but I
> would much rather that someone else took up the responsibility of
> applying patches and sending PRs - and of course I am happy to help
> whoever that is with the process.

On second thoughts (and on a second opinion) I am not actually willing
to apply patches for this platform, since it isn't sustainable to take
on each and every platform that there's no maintainer for.

+CC a few more people that have been involved in the platform.

Yixun Lan, you're kinda the "prime" person to maintain the platform
since you're the one who took up the core support work etc. Is
maintaining the platform, maybe with the help of one of the other folks
working on it something you can do?

Mostly the responsibilities are just applying patches for fixes/new
content and sending PRs to the soc maintainers - but knowing what's
right or not obviously requires familiarity with the platform which
people that work on it are best placed to do. Myself and the soc
maintainers will help if whoever does this runs into any trouble.
There is some documentation here https://docs.kernel.org/process/maintainer=
-soc.html
that will assist somewhat with getting up to speed with the process
also.

Cheers,
Conor.

--zVmVDX70lgniahsX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxKZxQAKCRB4tDGHoIJi
0lfFAP9yFxHQOJ/OkaYQK8k/a0PV/yBA+uo7ifvmKP3Ead3A/QEA9gcX6Ab7ArzU
mZJ8lU8o6rziz2CihRSyejYXShCi7wE=
=vT0s
-----END PGP SIGNATURE-----

--zVmVDX70lgniahsX--

