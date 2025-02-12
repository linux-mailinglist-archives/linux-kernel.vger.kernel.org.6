Return-Path: <linux-kernel+bounces-511325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA92A32964
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 701EE1880A54
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DAB211492;
	Wed, 12 Feb 2025 14:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKCazHFO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E883211473;
	Wed, 12 Feb 2025 14:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739372331; cv=none; b=K2T4VhWL6K6C2f/z5ZIEYBOutajdZDqze2ZIYLViC1/0Hq3Aj1/oGwCptNQMF/rYiBgNahuPXZwNrT54lee0I6K0LspU6Hmoarfh83h7/33ZZrYzJNbHpzeuVYJ83O6WPqouMjpLY1oiha0NE3naxbXuf2KTNI1gIUP+JqRAwqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739372331; c=relaxed/simple;
	bh=VfPCsV6WWIedIQpMHbXE7Twk3RA4OVR/ycnIBsYi/5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qg8PY/sUa6I+Kq1gD4p/soyasVm3UH6Ec0pUJje2zr8u94QS3ZwcrOjaOid/5auETGFP6vPACr5g4wRa+X+/dxPa1aLq5+C1hzm7Jn7738q6ss3A46zjBOqBFcGiweq/NjGrrSg40+Rmip8YT/qCOjriGpF9+u62bKYE/U+C+cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vKCazHFO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ABD8C4CEDF;
	Wed, 12 Feb 2025 14:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739372330;
	bh=VfPCsV6WWIedIQpMHbXE7Twk3RA4OVR/ycnIBsYi/5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vKCazHFOn2V5aNKha56y6oXj8E3nQcQFhDCe7vTDA6PTEFuURoB42/DkJS1CYL+sq
	 e+f9mX+XUIP4zwMpyjcVwPJTneK1nqUJSwyt3X2M7Guu0ZPB5QWjYu/G5RuxARTXrg
	 SKX++juExqFMlzI9bU0+SaOTvn2UtCu8X81f9/tNE2hICBtd/PAJSi/npE/+ZWNcO3
	 nWR+H9WwO1HcLvwYGsKzdc9sfpk+HL3sL2b14Yn4b+tnpOiR1aDl+SQT9+Wr4cghc8
	 pKhpA5DHRA0yeinKGgWg7kUNWGKCt356sgaGG6suJfPzeC/F0KEZEk8OShe6AHM8D1
	 ylcVRVJAA9aZA==
Date: Wed, 12 Feb 2025 14:58:45 +0000
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
	tiwai@suse.com, linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: imx-audmix: release cpu_mclk clock at failure
Message-ID: <7e37e951-17ad-4cac-a855-33c48ae0a283@sirena.org.uk>
References: <20250212093816.1857188-1-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fAwhL1alp7d3aLFt"
Content-Disposition: inline
In-Reply-To: <20250212093816.1857188-1-shengjiu.wang@nxp.com>
X-Cookie: Reality does not exist -- yet.


--fAwhL1alp7d3aLFt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 05:38:16PM +0800, Shengjiu Wang wrote:
> When defer probe happens, there may be below error:
>=20
> platform 59820000.sai: Resources present before probing
>=20
> The cpu_mclk clock is from the cpu dai device, if it is
> not released, then the cpu dai device probe will fail
> for the second time.

>  	ret =3D devm_snd_soc_register_card(&pdev->dev, &priv->card);
>  	if (ret) {
> +		devm_clk_put(&cpu_pdev->dev, priv->cpu_mclk);

The driver shouldn't be using another driver's device to do devm_
requests (or really to look anything up), that's just going to lead to
trouble like this - if it's got to look up another device's clocks it
should do a regular clk_get().  There will also potentially be problems
if the other device unregisters first and frees our clock underneath us,
and this will request multiple copies of the clock if we unbind and
rebind the imx-audmix driver.

--fAwhL1alp7d3aLFt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmestyQACgkQJNaLcl1U
h9Bjngf/WfuwuKGeK2nB+kS9poygpKCLuG9wbqSJbBo3TWSTk4l/5HcDoYFMf3Qd
DMjzt+C6i1ZKZ3aL7+jm4sQvxWUHX8ciF0FQqarOjN7ZVbCRNQggndMqphCuaNpJ
TMeIlSrKjSEDiajGNLjt0cbusl/CLP6nsHzfp+HCc2WSe6b12QSqndtJCB+seG9c
jVdR6dNZc2yePUIUVP+MeafpbWpru2KS0N+Fg3Fle0VNhs1TJ1+W3qKsLfUQQStR
Xr9JQdSzrjdIw3Vr2jDyKcWGVTh05G0BsZ+OLCAQo3PuaoFg2/lrs4HP7t7KGfnK
i4hrFK/hPV7ZZkWL0NxgTSGVeRjJ3g==
=Of57
-----END PGP SIGNATURE-----

--fAwhL1alp7d3aLFt--

