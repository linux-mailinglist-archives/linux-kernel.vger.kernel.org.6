Return-Path: <linux-kernel+bounces-180981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 885E38C75BB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA3981C20F3D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 12:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B81145B3D;
	Thu, 16 May 2024 12:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQmjf34/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04C04EB30;
	Thu, 16 May 2024 12:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715861606; cv=none; b=Vn0ozosppSnSzUS64XLNstVh+Dlv00FupCnFNfvHJLEU0mNvJPypLz8udONLRjSmF1DIU1TCPBypNrF934dLqcdJQsM0euFw1kmXGHLlqoxMz3bLwj7YX7/udmp3r2vml8/o9/63oPRBlYBA/xZ4TtFiPe4ODwlfoX4acu+pq80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715861606; c=relaxed/simple;
	bh=PgBb5IuMLJI8Ia1873iobO8fM2Zu/m/kbxqQ5D7vmUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8S4B1y6ADxcta0NREPR6CJAdra+jQ5DMt4zIhaE2NPYk55IuQssSvWbjugJfr69/XVBbKKTen/QbhgsWaU34odm6Dj8avOkot/14de0g52i8HVPiZhl5TtEsMelnMXKneGNh+e9QdmKCpOeM6LhtvbpsdI4H1GY4Cn6zDTrikk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQmjf34/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473CFC113CC;
	Thu, 16 May 2024 12:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715861605;
	bh=PgBb5IuMLJI8Ia1873iobO8fM2Zu/m/kbxqQ5D7vmUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tQmjf34/DI3xuTTNyYHqNO9Y/SzC1Ul8Bh5Hu+0vGFB8gLlzi8DfFjCbxwFVAkksY
	 7pbHIbnuztMGwl4OwgLI/36pKCrOIFMgMHKkd2CAbCjoDZq4R9w9r1uvbWavioECN0
	 7IDtEej3Hn1PQZd5zakbze5ot2Mt8tcpCPVlfHUufn+mMeNc4bCOdOEg+cilymEIAu
	 IXq/FaXZVwMirysn/WaRj5qqNYqcmP8kQZQ30eGDhnsSTL2uWwQSILi6K2rXm49Bpt
	 tlIxPQImgZFBFIaGoNowYSElmiroyRw6bNrdeMgUGWgVmAbIAyOTC5xnftJaB0IRwd
	 GtyYNhZE87yrA==
Date: Thu, 16 May 2024 13:13:19 +0100
From: Mark Brown <broonie@kernel.org>
To: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCHv4 7/9] ASoC: fsl-asoc-card: add DT clock "cpu_sysclk"
 with generic codec
Message-ID: <ffb3624f-2170-4642-aaa5-fb6736a75d59@sirena.org.uk>
References: <20240515135411.343333-1-elinor.montmasson@savoirfairelinux.com>
 <20240515135411.343333-8-elinor.montmasson@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LqD9gI/K1pmwN8AU"
Content-Disposition: inline
In-Reply-To: <20240515135411.343333-8-elinor.montmasson@savoirfairelinux.com>
X-Cookie: I'm having a MID-WEEK CRISIS!


--LqD9gI/K1pmwN8AU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 15, 2024 at 03:54:09PM +0200, Elinor Montmasson wrote:

> Add an optional DT clock "cpu_sysclk" to get the CPU DAI system-clock
> frequency when using the generic codec.
> It is set for both Tx and Rx.
> The way the frequency value is used is up to the CPU DAI driver
> implementation.

> +		struct clk *cpu_sysclk = clk_get(&pdev->dev, "cpu_sysclk");
> +		if (!IS_ERR(cpu_sysclk)) {
> +			priv->cpu_priv.sysclk_freq[TX] = clk_get_rate(cpu_sysclk);
> +			priv->cpu_priv.sysclk_freq[RX] = priv->cpu_priv.sysclk_freq[TX];
> +			clk_put(cpu_sysclk);
> +		}

I don't really understand the goal here - this is just reading whatever
frequency happens to be set in the hardware when the driver starts up
which if nothing else seems rather fragile?

--LqD9gI/K1pmwN8AU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZF+F4ACgkQJNaLcl1U
h9AXTAf/eg99B2kknpaDwJ9DZYFFkcxJ6324qRL4RTcRJNsgycwZKlovGPFG7PVB
29K3gLq85wh/oTwmaxu0ytCzdOUaYcKNAec6vzs2Ro15xt1N728lxhxfM1JnH4F3
0WTtEvxm1RB//7l8dl3SNGm+tZEPMZZf5vjpDhYF0KctVTrlgekUNwQvSXbEpi9T
Xpxz8LYxSROWirKxovgWZefVgP9CDqERbTny2dUnaFZJUwV1CZg33QsIL6S6Szg1
+6XGOwJ1XLprfuqZlcejaGFjAcaaYyscdyypTVEFxfZrm9O1sy40NL+z/QEksF7r
/BTWFjcskN42Qd4lgOeScS/BzpHJ8A==
=filG
-----END PGP SIGNATURE-----

--LqD9gI/K1pmwN8AU--

