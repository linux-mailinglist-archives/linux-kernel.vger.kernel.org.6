Return-Path: <linux-kernel+bounces-204664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA638FF1EF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 721891F265B6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB53119AA65;
	Thu,  6 Jun 2024 16:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4U0ezGW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D5819AA57;
	Thu,  6 Jun 2024 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717690271; cv=none; b=g8f8JV0Mi4p3GZwpYZG0Lag5t7yYOq+VUUcpiBY3ZZXagdCzt/9VEQjIiD0aXDSkZSQCvJhjawrQhAXvQZYTQcA5dxbOzBjNNXI+7t+80y6sTKnx9hzHnV1t2PhxwuYKS9OiplQ0/n647dW08+ALduLTTLp788MOTBBeCpm/uPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717690271; c=relaxed/simple;
	bh=LMioPdhm8GU+5HKM5CEWwiaydEuPaHLYUpKUi8mNzW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYJqbCH+g52/IMJrFwSTwQGG5duWMYkPj+b5/7q5PVej4t1slF5KXgqFmoaJ/gzTJYDx5TSYB0buIjOP3XQ3YoRmNjo69LrYxrto2TBci9FSmMbsUNyoSr4VCWr5Q0DNWWYsUz4f/hxvJFOi5JmpqW8Wd16nzS9EaKEZQoLevys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4U0ezGW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30BF3C4AF08;
	Thu,  6 Jun 2024 16:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717690270;
	bh=LMioPdhm8GU+5HKM5CEWwiaydEuPaHLYUpKUi8mNzW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y4U0ezGWvlsN3sFRlxF1uzRpu3fxzalM3dAkAuL5UTBiu3Za9g36J/uHbipeI6Oa0
	 WPbnGuJuFifKg5VoPTaqYjFiceSXkWf+ML9oNU+wReJnI3rFZ0E0rM6hsAtDASHptA
	 lDuc9pu2Ki7KKQsw1EU/Fvi48Mhlfgl27L8TjGDDPgTWhZi035gDkN34CWjweKzWg4
	 kV6D2hj2VvTc6yVH/1P8EL/ktTcDN2qjn3K19SoAiPlIbZqsqBBWt4h5YpYDpN9ktH
	 1pD6QUFPKWn5mSUfQzAJW1tviZmQ20nhgv1EjrS+8D8PJnO/U6rf5moU59dDRJ+V4o
	 XctgqxlrcAtWQ==
Date: Thu, 6 Jun 2024 18:11:08 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Marcus Cooper <codekipper@gmail.com>, =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>, 
	linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ASoC: sunxi: sun4i-i2s: fix LRCLK polarity in i2s
 mode
Message-ID: <20240606-savvy-wallaby-of-champagne-d4a50e@houat>
References: <20240529140658.180966-2-matteomartelli3@gmail.com>
 <20240529140658.180966-3-matteomartelli3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="4nk5dehwshah5pj6"
Content-Disposition: inline
In-Reply-To: <20240529140658.180966-3-matteomartelli3@gmail.com>


--4nk5dehwshah5pj6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 29, 2024 at 04:00:15PM GMT, Matteo Martelli wrote:
> This fixes the LRCLK polarity for sun8i-h3 and sun50i-h6 in i2s mode
> which was wrongly inverted.
>=20
> The LRCLK was being set in reversed logic compared to the DAI format:
> inverted LRCLK for SND_SOC_DAIFMT_IB_NF and SND_SOC_DAIFMT_NB_NF; normal
> LRCLK for SND_SOC_DAIFMT_IB_IF and SND_SOC_DAIFMT_NB_IF. Such reversed
> logic applies properly for DSP_A, DSP_B, LEFT_J and RIGHT_J modes but
> not for I2S mode, for which the LRCLK signal results reversed to what
> expected on the bus. The issue is due to a misinterpretation of the
> LRCLK polarity bit of the H3 and H6 i2s controllers. Such bit in this
> case does not mean "0 =3D> normal" or "1 =3D> inverted" according to the
> expected bus operation, but it means "0 =3D> frame starts on low edge" and
> "1 =3D> frame starts on high edge" (from the User Manuals).
>=20
> This commit fixes the LRCLK polarity by setting the LRCLK polarity bit
> according to the selected bus mode and renames the LRCLK polarity bit
> definition to avoid further confusion.
>=20
> Fixes: dd657eae8164 ("ASoC: sun4i-i2s: Fix the LRCK polarity")
> Fixes: 73adf87b7a58 ("ASoC: sun4i-i2s: Add support for H6 I2S")
> Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 143 ++++++++++++++++++------------------
>  1 file changed, 73 insertions(+), 70 deletions(-)
>=20
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index 5f8d979585b6..a200ba41679a 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -100,8 +100,8 @@
>  #define SUN8I_I2S_CTRL_MODE_PCM			(0 << 4)
> =20
>  #define SUN8I_I2S_FMT0_LRCLK_POLARITY_MASK	BIT(19)
> -#define SUN8I_I2S_FMT0_LRCLK_POLARITY_INVERTED		(1 << 19)
> -#define SUN8I_I2S_FMT0_LRCLK_POLARITY_NORMAL		(0 << 19)
> +#define SUN8I_I2S_FMT0_LRCLK_POLARITY_START_HIGH	(1 << 19)
> +#define SUN8I_I2S_FMT0_LRCLK_POLARITY_START_LOW		(0 << 19)
>  #define SUN8I_I2S_FMT0_LRCK_PERIOD_MASK		GENMASK(17, 8)
>  #define SUN8I_I2S_FMT0_LRCK_PERIOD(period)	((period - 1) << 8)
>  #define SUN8I_I2S_FMT0_BCLK_POLARITY_MASK	BIT(7)
> @@ -729,65 +729,37 @@ static int sun4i_i2s_set_soc_fmt(const struct sun4i=
_i2s *i2s,
>  static int sun8i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
>  				 unsigned int fmt)
>  {
> -	u32 mode, val;
> +	u32 mode, lrclk_pol, bclk_pol, val;
>  	u8 offset;
> =20
> -	/*
> -	 * DAI clock polarity
> -	 *
> -	 * The setup for LRCK contradicts the datasheet, but under a
> -	 * scope it's clear that the LRCK polarity is reversed
> -	 * compared to the expected polarity on the bus.
> -	 */

I think we should keep that comment somewhere.

Maxime

--4nk5dehwshah5pj6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZmHflAAKCRAnX84Zoj2+
dkp4AYDD2C89et3GX+eTXxMU3fw2ApYremNJgsBVdE7CDulWRzcHlpW2kUP83Bfd
pT1zxkcBfR2hOGFtRyy3sMoLOytPZezcLRdE7sh1OTYn1SAPA/T5otrsqk1PkCp0
t7BzSI8rzw==
=ri98
-----END PGP SIGNATURE-----

--4nk5dehwshah5pj6--

