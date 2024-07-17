Return-Path: <linux-kernel+bounces-255189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 422C0933D41
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 14:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72EE61C2353C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 12:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7894B1802A7;
	Wed, 17 Jul 2024 12:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNWNWAsK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C4717F398;
	Wed, 17 Jul 2024 12:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721221022; cv=none; b=TRgEzZVYoo41V6Burk/NmYnuiEt0lKTTBmwOaAqWAzSz6qrIO1ZKzjYldrAlmrdysCTY0mrPa+15DvGG4O5pBuoZjFldWLAQyIJ/WMCEaHifhJdMrfvdMT91jL1iffSHOrZAKeAcGqdvgKVdPgDyI9e0+F3zLFzd7yKN41Tg45k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721221022; c=relaxed/simple;
	bh=ltIMVCVyMrMVWojTEwyWM1KWwVsiHMSs7gCVcfmYgjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dE6v5t6/pXaaBz7gMyzq44xou8al1Y7W0eqo/cE1SjdPCWp5wpvvrS1jQKLZfu6oqs3YPUgGwT5Or6RJ/nytFRZo+LWc2l3ibaqw20+0WLabAGjDEx/hwdaK+I1uLSQM3nbZIQd/r0VoGkoXLal1C1LHwAo87YgqEUsR9+nfOX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNWNWAsK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC487C4AF0B;
	Wed, 17 Jul 2024 12:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721221022;
	bh=ltIMVCVyMrMVWojTEwyWM1KWwVsiHMSs7gCVcfmYgjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mNWNWAsKou7Q/lGOHX63fHxiOC4RpOi+d3dyLBD666sRjrrCELCr8dFpS/AHQsk1N
	 VFoVdMRuD5yiThrvmT4GYzBl9qqKtQIPqhGr3JEwtIWmtp1PKvMybr1gMkiKlMA8nz
	 y0ND5oGpnT1VOanM+IXnd9N7lJ4ntqN+Hx8SsGh1wE2opxSKg1kd243K8QMa0mgrJD
	 fKUgD2VDviNKgs3n4WwTz6dmPkKjkfsEmXJQNUS0+L0yyfflk4j4mmPGY+GcQOzSYj
	 cGTRwvDBkxg2d61pp75jnmRxp4jSgdTTXzweJQuvS7H1L4qW5nK9XWQ3a0XXMPN5ma
	 ngjMfaLSPWWlA==
Date: Wed, 17 Jul 2024 13:56:57 +0100
From: Mark Brown <broonie@kernel.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
	biju.das.jz@bp.renesas.com, jernej.skrabec@gmail.com,
	claudiu.beznea@tuxon.dev, robh@kernel.org,
	kuninori.morimoto.gx@renesas.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: ak4642: Return of_clk_add_provider to transfer the
 error
Message-ID: <9861bf67-8b26-40a6-a7bf-875536ebe597@sirena.org.uk>
References: <20240717114024.3441163-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="X7p90v88k/KRvG/f"
Content-Disposition: inline
In-Reply-To: <20240717114024.3441163-1-make24@iscas.ac.cn>
X-Cookie: You should go home.


--X7p90v88k/KRvG/f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 17, 2024 at 07:40:24PM +0800, Ma Ke wrote:

>  	clk = clk_register_fixed_rate(dev, clk_name, parent_clk_name, 0, rate);
> -	if (!IS_ERR(clk))
> -		of_clk_add_provider(np, of_clk_src_simple_get, clk);
> +	if (!IS_ERR(clk)) {
> +		ret = of_clk_add_provider(np, of_clk_src_simple_get, clk);
> +		if (ret)
> +			return ERR_PTR(ret);
> +	}

This will leak clk if adding the provider fails.

--X7p90v88k/KRvG/f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaXv5gACgkQJNaLcl1U
h9BGCQf/X02VcYtRBKcX8Pi62wfF7E145RuGrPbUFYWtF/l16nK7hhxaA3QyC+W+
CTz4WKJ+XtIUNz96fzslq0VJ6sRN2KUW0/lhm7uvGSM1/mi+md2/8TfpQiVBxtlL
uhs9CTYxQotAYhhBa/Z9Yu1UmkIbWOtvaII4dY5gx5THs6/0KY+IrCrD6RQSb+K/
jrdEqsx9ORUvlrXnIqAoTbAUUkr2crZ3U4dEMMqBtoNYIC00J1rsUDn5hTPu4l3W
xclhW45aCgZVkVEGjRO7rIRlYYCZ1KTPYLdvuNP9uXPJDVYJFJCgWwFy2TQcjZvu
0ZY27DyXa6gHGF8I1ZdTGKnQO1llig==
=17Cs
-----END PGP SIGNATURE-----

--X7p90v88k/KRvG/f--

