Return-Path: <linux-kernel+bounces-209681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9811903953
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D9941F24620
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A441A1791FC;
	Tue, 11 Jun 2024 10:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1Mmx+6L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E006B54750;
	Tue, 11 Jun 2024 10:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718103169; cv=none; b=FPw7kRw2LW3dpOsb+ywFCyj5sY2GKuRLXpC78Z+rqrR/nw+7xrMn7S/OLLjS2X8MPoHU2cThibdLx5UF3o5FdAXkw1f4r0vsei1aZMDHsPfZoRYu64psHaC9HI1sMaMZd9YPeSCNFe3eTcNYKgF47hLyUYNZV7CLm0DKVhd4bOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718103169; c=relaxed/simple;
	bh=SPGCvg8oBcYG36Y3k+TqNNr972Be3vD+h4h2HMX0I+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsGVU02lv5kflv6bgAb8dSnHEo2jbQHqhFCQOZNX386bntRmzje0tK+/uIAZ4fCEs16r8KikXof8y6fuELpcMQLODMh9mdkqlPJ6jYqfrheJG9pCP8enpGP3LPbQYclw/K6PHfmQZK8Hp7g8KyEQQqlI0sCxguydSdW2Xt89UPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1Mmx+6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91A1C32786;
	Tue, 11 Jun 2024 10:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718103168;
	bh=SPGCvg8oBcYG36Y3k+TqNNr972Be3vD+h4h2HMX0I+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P1Mmx+6LI3tk0HEjNzIWO+vEfjmp/DZPYSQcOZI7tx2yZfoJqmZ6wKRkgd38O6e7r
	 HEttIG0vIBXdIGA/fDvEjgeLkpx3Klp9wvgq19w3wUXleABJZ8xXWL+DAFuzdSB3id
	 453SozEM6s9m+dQHHq9YObW62o1hid0EXxkU8Dg/gf23lVTP9tZqolYBRjS4TcmgWZ
	 FgUxYvko7qKsDm1pXWL+msrl447F7WTfnv4nTd/PLZ/uPHNO8Y/1s+3TBKEv01xRBb
	 MtWvPK/elrOqJ7grP5KlooTl6loyozwUciL5FqfYyRmj8sGtNcGGSTWbQ6wVUlHFSm
	 Kt5jpwCXl+Xkw==
Date: Tue, 11 Jun 2024 11:52:45 +0100
From: Mark Brown <broonie@kernel.org>
To: Rui Zhou <zhourui@huaqin.corp-partner.google.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	trevor.wu@mediatek.com, allen-kh.cheng@mediatek.com,
	kuninori.morimoto.gx@renesas.com, maso.huang@mediatek.com,
	linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v1] ASoC:  support machine driver with TAS2781
Message-ID: <Zmgsfafmfedd9_MV@finisterre.sirena.org.uk>
References: <20240611022227.2508354-1-zhourui@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="K85sZsmQcdfrCDzv"
Content-Disposition: inline
In-Reply-To: <20240611022227.2508354-1-zhourui@huaqin.corp-partner.google.com>
X-Cookie: Your love life will be... interesting.


--K85sZsmQcdfrCDzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 10:22:27AM +0800, Rui Zhou wrote:
> Support amp TAS2781 for mt8188 platform
>=20
> Signed-off-by: Rui Zhou <zhourui@huaqin.corp-partner.google.com>
> ---
>  sound/soc/mediatek/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
> index 5a8476e1ecca..07f67f96c889 100644
> --- a/sound/soc/mediatek/Kconfig
> +++ b/sound/soc/mediatek/Kconfig
> @@ -233,6 +233,7 @@ config SND_SOC_MT8188_MT6359
>  	select SND_SOC_HDMI_CODEC
>  	select SND_SOC_DMIC
>  	select SND_SOC_MAX98390
> +	select SND_SOC_TAS2781_I2C
>  	select SND_SOC_NAU8315
>  	select SND_SOC_NAU8825

Ideally this would be sorted to avoid spurious merge conficts.  Also do
we really have dependencies here or should these just be being enabled
by users - these drivers are all pretty generic now?  Not that this
change in itself makes a huge difference to the existing state.

--K85sZsmQcdfrCDzv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZoLHwACgkQJNaLcl1U
h9AAVgf/TWEQisVxEaf1frM1/D3qcobxJ6efWsgIv3IU+Pg4hw/ZG/TRDwKrGkj3
htAD+n9XXY85OzGfILsjRExZ+WDaULAYnvBoJpml5QqvJPQJ3hdFVeAP+oyZ3uwa
ueaNc253irzMPAtO6FUe4KrJSLXGWTWfiliOS3p6ntj8HuuLO0IaXw2r/9Qedf2l
HLVobEfd4G0nC68K75qt0El0Dl+8vJMKa4NHL75A1Zdj0WHBNC5pbCB1q1SNIKWB
xpWuo7HPpof5ewkH4wE/ej3Ug25R0yw6UbMUSl2GVkAqY4n7nF2GKoO7O3uZ+yvG
HGdLYOln52AYmZDRc1mkwDvKazuvwA==
=rSC4
-----END PGP SIGNATURE-----

--K85sZsmQcdfrCDzv--

