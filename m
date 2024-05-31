Return-Path: <linux-kernel+bounces-196834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDB68D6259
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 15:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F02A71F24A83
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 13:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BCB158A11;
	Fri, 31 May 2024 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsje7/cZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8D91581FB;
	Fri, 31 May 2024 13:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717160735; cv=none; b=c2a0+v3RO0vNEHAOyZlXjXgb7f6xuBjv7BJG9XdeqK9HtljUL6/8zyZQwm2Z2cVpFFmDke9Sbve9UqF5CVzRJshr8cfF6R/CNpyPwz8ovjAOBj6eWd7OSbw5GdJhd0spECG+Zy8Sc8Eo2NUmIE/emLb5XbjzFmrJRndDANl5gvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717160735; c=relaxed/simple;
	bh=dx7sosLdw/sMCS1kUDSuJ+V4bIgBHv6xTIsGonpSXe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2+svzElAIuJ7sCV2kABXd9gQJl+/yze23NKASOH6fTf3fPNiPW9WqwXtzY20+woxOE4ukpC1130/gCr36+T8hKem21m/UC/oJrIqWH4efzYLmXXXq/F2532QLmjQPibjzvJ5M57MMvLQchqTLKoY6lGuObuhwUdno4KmPKQtp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsje7/cZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20734C116B1;
	Fri, 31 May 2024 13:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717160735;
	bh=dx7sosLdw/sMCS1kUDSuJ+V4bIgBHv6xTIsGonpSXe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dsje7/cZyyF91s/HghOChQzu65qzn4qwHQZqMG+7mokDXR7Jfvm7kxU94sajwCuJJ
	 0uPm7PXp/wef7hqUDRdFjTZJQ+2CzrLr4Kx9J4ScNpsgNqIhHGLKwtond52tNpzA9F
	 gtcvjFtw2rJ3AkXJE5CQR263VaNocoIdKMSy0mAFRvhtRQR5OsCRnh0jynSNMgW9qD
	 QpWpnRN9bdws2ZYkuR3ZW5iyjv3Nk0gR/juI86Nn8hKyfMy2lIVCoyPk8LTXTIihOP
	 MFhw/4yL/uqzYm6nmu2C5SptZZVEAsj/4fgQECPspdNjOkih6Bq/tfyhuAEfkIe0sB
	 khJnx69J6Wa0Q==
Date: Fri, 31 May 2024 14:05:28 +0100
From: Mark Brown <broonie@kernel.org>
To: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	shengjiu wang <shengjiu.wang@gmail.com>,
	Xiubo Lee <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound <linux-sound@vger.kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	alsa-devel <alsa-devel@alsa-project.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCHv4 7/9] ASoC: fsl-asoc-card: add DT clock "cpu_sysclk"
 with generic codec
Message-ID: <826f6c22-d1f1-42ce-a8d1-2d5cb894a970@sirena.org.uk>
References: <20240515135411.343333-1-elinor.montmasson@savoirfairelinux.com>
 <20240515135411.343333-8-elinor.montmasson@savoirfairelinux.com>
 <ffb3624f-2170-4642-aaa5-fb6736a75d59@sirena.org.uk>
 <822567441.349330.1715936735603.JavaMail.zimbra@savoirfairelinux.com>
 <da74d276-b028-448b-bb28-295de49dbcda@sirena.org.uk>
 <1660761484.701255.1717159615755.JavaMail.zimbra@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t5IjrPd8avuXZPeL"
Content-Disposition: inline
In-Reply-To: <1660761484.701255.1717159615755.JavaMail.zimbra@savoirfairelinux.com>
X-Cookie: Serving suggestion.


--t5IjrPd8avuXZPeL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 08:46:55AM -0400, Elinor Montmasson wrote:
> From: "Mark Brown" <broonie@kernel.org>
> > On Fri, May 17, 2024 at 05:05:35AM -0400, Elinor Montmasson wrote:
> >> From: "Mark Brown" <broonie@kernel.org>
> >> > On Wed, May 15, 2024 at 03:54:09PM +0200, Elinor Montmasson wrote:

> >> >> +		struct clk *cpu_sysclk =3D clk_get(&pdev->dev, "cpu_sysclk");
> >> >> +		if (!IS_ERR(cpu_sysclk)) {
> >> >> +			priv->cpu_priv.sysclk_freq[TX] =3D clk_get_rate(cpu_sysclk);
> >> >> +			priv->cpu_priv.sysclk_freq[RX] =3D priv->cpu_priv.sysclk_freq[T=
X];
> >> >> +			clk_put(cpu_sysclk);
> >> >> +		}

> >> > I don't really understand the goal here - this is just reading whate=
ver
> >> > frequency happens to be set in the hardware when the driver starts up
> >> > which if nothing else seems rather fragile?

> >> The driver allow to set the sysclk frequency
> >> of the CPU DAI through `priv->cpu_priv.sysclk_freq` when calling
> >> `fsl_asoc_card_hw_params()`.
> >> Currently it is hard-coded per use-case in the driver.

> >> My reasoning was that with a generic codec/compatible, there might
> >> be use-cases needing to use this parameter, so I exposed it here via D=
T.
> >=20
> >> Is it a bad idea to expose this parameter ? This is not a requirement =
for the
> >> driver to work, most of the current compatibles do not use this parame=
ter.
> >> It is currently used only for `fsl,imx-audio-cs42888`.
> >> In that case I can remove this commit.

> > I'm having a hard time connecting your reply here with my comment.  This
> > isn't as far as I can see allowing the frequency to be explicitly
> > configured, it's just using whatever value happens to be programmed in
> > the clock when the driver starts.

> In v3 I used parameters `cpu-sysclk-freq-rx/tx` to explicitly
> set the frequency.
> In its review Rob Herring said that the clock bindings should
> be used, so that's why I changed it to use this `cpu_sysclk` clock.

So you're trying to use this as the audio clock?  There's no code that
enables the clock which seems worrying, and I'd expect that if the
device is using it's own clock the device would be querying it directly
via the clock API rather than this.  This all seems really confused.

--t5IjrPd8avuXZPeL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZZyxcACgkQJNaLcl1U
h9Be4gf/YfLlU8GPgc+J8qnnUXsGMfa3hyDMKKjkChZ7Z2VgGlh61Y8j3nssb5sV
qVQOuuv5hD2jNlTKEYoCiiHNIfmOe9GqRtYmsQkk/UYScO0NwovQ7UYpquVtkJFb
qXgMXiPhACDh+wm1P4G3pHV9gVN/ZOLZcrPtwl2Rv1lK4j7rhZqbT/FD+9aeRu9p
FpUiNfiwP6l6e8KIgPcDb8tBbqqnS/tLrE6xPk6EfflG+fJM9w3eUm4+tlf0uCcN
QldOJ1GhYERqM69Sj1g7TWgh/0BZ59EVD8CtX9HPGC5SBYW7Kyf6ew79K8VCd/CR
TxJMEZjB7AtvR8rBJYzqx8/I1/gToQ==
=CcoA
-----END PGP SIGNATURE-----

--t5IjrPd8avuXZPeL--

