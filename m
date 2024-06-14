Return-Path: <linux-kernel+bounces-215287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2ABA9090AC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C0E1283453
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9079192B6B;
	Fri, 14 Jun 2024 16:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0OdEN4a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0156749638;
	Fri, 14 Jun 2024 16:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718383362; cv=none; b=cn9pFRUBVpQ3zsULaUEdFAqrRluwjTTOUdZ6idY2RqVfQ4cjaiJU/3NVrL8Outj+pz/0L35BPi3DyU4zzsWn0HRD5DXIykTLsi3Q7OzoLKCryRpoMYwGUQwiqklCTcPY8bFS22EpXQuAlTRDVdjPkUpJZ/a0AsKVtX3PQ9kAZDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718383362; c=relaxed/simple;
	bh=Tlh8m401RdiRzFymaSJiodIhjjgTmA5lrOXYAZ9uQPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dB6fl8KVAWRfMhNfXfkhg+zP4c5YuSWtWusjoxjAurRN0AlAv8mJ0vGADXju4h59RFZJRakawRRwtmm8AEvU6wCLWUwwxzUEdgG7CiRjBNRI1Edp5rPadv2G4n+KC3G5apGalY6AvoZCBAlApLM/PCRaa3wt4ypc4fMa1K53jPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0OdEN4a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE23C2BD10;
	Fri, 14 Jun 2024 16:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718383361;
	bh=Tlh8m401RdiRzFymaSJiodIhjjgTmA5lrOXYAZ9uQPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q0OdEN4aixWpF1EjydlUMQuTgCaVB7opzXf5XtfbWhOWL/5rJkC9DbQy/IKk36npJ
	 VO2xUxaj17Zam0K3yAqd2B4ugztVtF03BnddXJE598GhRC07J8bVsJhbr02YNtIiVP
	 KMuSF9Y1tZqg6uJAAP0R+GkuOZ9BbSCGEMDkA/c7JAilgfuGQEOW96H2GsERoesEA6
	 BNKrYWBlVWNCPUxYjfxJ0Or1bptyOrzsub6cW3goW7BR36i5B0+yNuRlskCPKlaIuh
	 a9qOBXrltofA9kw6ZGdNZIz3c0wsf6nPUk57dFi0WcWFeYZ7O8X3wEAu6Knm8OM4Ja
	 K/hpG7ZnE/b2Q==
Date: Fri, 14 Jun 2024 17:42:35 +0100
From: Mark Brown <broonie@kernel.org>
To: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Russell King <linux@armlinux.org.uk>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Chancel Liu <chancel.liu@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
	Michael Ellerman <mpe@ellerman.id.au>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [Patch v2 1/2] ASoC: fsl: Add i2s and pcm drivers for LPC32xx
 CPUs
Message-ID: <Zmxy-xA3YDU06Eht@finisterre.sirena.org.uk>
References: <20240611094810.27475-1-piotr.wojtaszczyk@timesys.com>
 <Zmgor8accyAiUkUO@finisterre.sirena.org.uk>
 <CAG+cZ06B+AexqvwZtNP5FX50AmghAFLa=1ebxmKLvMoyVJ529w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0Dizksk5Fs8IGsJP"
Content-Disposition: inline
In-Reply-To: <CAG+cZ06B+AexqvwZtNP5FX50AmghAFLa=1ebxmKLvMoyVJ529w@mail.gmail.com>
X-Cookie: Your love life will be... interesting.


--0Dizksk5Fs8IGsJP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 06:24:50PM +0200, Piotr Wojtaszczyk wrote:
> On Tue, Jun 11, 2024 at 12:36=E2=80=AFPM Mark Brown <broonie@kernel.org> =
wrote:

> > On a quick scan I can't see any architecture dependency for build,
> > please add an || COMPILE_TEST for improved coverage.  As for all the
> > other things enabled in this Kconfig file there is no need to explicitly
> > depend on SND_SOC.

> Ok. Later I will add a sound card driver to phytec3250 board which uses
> arch/arm/configs/lpc32xx_defconfig config file so that the COMPILE_TEST
> won't be needed.

Why would a defconfig affect the Kconfig?

--0Dizksk5Fs8IGsJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZscvoACgkQJNaLcl1U
h9An6Qf/b4JZLW1fJTJNxCgdIhftN7IpeiRX+esOHEeKQtZw3ozptV88AJharZjX
XXZEj/+g1xJK4XcZaoGge+ChSerkFOGA8R47dj26SyDq2YdCKR63s4FxELs8g0Io
uxg/3sS8sltF8LnpH4rEZS8V1yNNAA5WMh8Cxvwf4EX5fJmHPCdpLNtkVOAmvKgU
arRBgU8EHs2YBeDhQZu+HLGFQXKbd4YmIl4ExA+S6xjJoF6nQQA5fuwZKh7H3MgY
/OcHiJ1/7M0NLdLk7tf5uFSwbKUcqnAlVx1OZwg04NmfDdWxxf6u0qO7kg4uO9Td
DHj4z63CGck+G+/Pl0cnpjduUMnsWA==
=kXhB
-----END PGP SIGNATURE-----

--0Dizksk5Fs8IGsJP--

