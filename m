Return-Path: <linux-kernel+bounces-182038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A838C856D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 13:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C469E2817A3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 11:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38623D541;
	Fri, 17 May 2024 11:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQy4PIpg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DC93D0A3;
	Fri, 17 May 2024 11:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715944648; cv=none; b=T872AUpFmtthbi2lBXrCaH6jJwScVRULaWQ37XpCgx5fuEDhmpyqAiejzDYepCWVTa0x1wSrFmIXdL5p6+HxzLyYFD867jmxy/PAUy8JNO8Tsp/MEuG3lWVVtWonLLmVJGKXZdmG5MJnWjq7L5aATk9HwAA3n7Wx0zIRF0KKel0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715944648; c=relaxed/simple;
	bh=tz2kY6qZxYu8TUGihVyLmMBdD0mSnRDdr1XJJV0fdqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5cN2G9FqsjZHA8ge7Xh+3z+TW/k9CosVT9J4T1+OrzWdxuazbCon+qI+epvueiVFB5t7gDqou+enVMyRIWO/e8FWOVgj2QC1h8yL+GgZnrkA8oJaZm0csJx1qPmXhE5SOVj/wrFERdwzwcZoT1SJxOMMyKsLc38yV/GBw5oFz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQy4PIpg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29952C2BD10;
	Fri, 17 May 2024 11:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715944647;
	bh=tz2kY6qZxYu8TUGihVyLmMBdD0mSnRDdr1XJJV0fdqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hQy4PIpgYaKxXAHLGvLX+gUDvsDu0a15TR2Y2mPX//3bbTmVe/LF42kVNmBCWnrIF
	 fXggLSUVDlRgG8/nB5tFhPY4GpcIiGYQBQRpMMPvtbclDKqH3Qnab61xQFVGHq2E2B
	 ao1JK8A6/I+vrUgOJv3Dqfry4TbETyrS/EwqZs6+lMa8i3a3TvJF66NVcnL3FOE/d7
	 EKMK8Lf7bk4KqjpHqxIZJonIMDYbfuZMldEu32/tyybWRpV/5PTq4PLsakYSgjOjj/
	 szCeeggBtdpenLeZv1HQ0li+bHqGpiJhMedlDwAJ0RCCwi8ibZnRe2zj8+qUn3xZUy
	 hTr7GqHUkMODg==
Date: Fri, 17 May 2024 12:17:20 +0100
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
Message-ID: <da74d276-b028-448b-bb28-295de49dbcda@sirena.org.uk>
References: <20240515135411.343333-1-elinor.montmasson@savoirfairelinux.com>
 <20240515135411.343333-8-elinor.montmasson@savoirfairelinux.com>
 <ffb3624f-2170-4642-aaa5-fb6736a75d59@sirena.org.uk>
 <822567441.349330.1715936735603.JavaMail.zimbra@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZuqvFG62+4JL9ncV"
Content-Disposition: inline
In-Reply-To: <822567441.349330.1715936735603.JavaMail.zimbra@savoirfairelinux.com>
X-Cookie: Function reject.


--ZuqvFG62+4JL9ncV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 17, 2024 at 05:05:35AM -0400, Elinor Montmasson wrote:
> From: "Mark Brown" <broonie@kernel.org>
> > On Wed, May 15, 2024 at 03:54:09PM +0200, Elinor Montmasson wrote:

> >> +		struct clk *cpu_sysclk = clk_get(&pdev->dev, "cpu_sysclk");
> >> +		if (!IS_ERR(cpu_sysclk)) {
> >> +			priv->cpu_priv.sysclk_freq[TX] = clk_get_rate(cpu_sysclk);
> >> +			priv->cpu_priv.sysclk_freq[RX] = priv->cpu_priv.sysclk_freq[TX];
> >> +			clk_put(cpu_sysclk);
> >> +		}

> > I don't really understand the goal here - this is just reading whatever
> > frequency happens to be set in the hardware when the driver starts up
> > which if nothing else seems rather fragile?

> The driver allow to set the sysclk frequency
> of the CPU DAI through `priv->cpu_priv.sysclk_freq` when calling
> `fsl_asoc_card_hw_params()`.
> Currently it is hard-coded per use-case in the driver.

> My reasoning was that with a generic codec/compatible, there might
> be use-cases needing to use this parameter, so I exposed it here via DT.

> Is it a bad idea to expose this parameter ? This is not a requirement for the
> driver to work, most of the current compatibles do not use this parameter.
> It is currently used only for `fsl,imx-audio-cs42888`.
> In that case I can remove this commit.

I'm having a hard time connecting your reply here with my comment.  This
isn't as far as I can see allowing the frequency to be explicitly
configured, it's just using whatever value happens to be programmed in
the clock when the driver starts.

--ZuqvFG62+4JL9ncV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZHPMAACgkQJNaLcl1U
h9A/Mwf/e8Oa99TU5bBwUqPPv4RdS3EWv4/897XflQzPXjxfkxnMFOUUf0EBVm61
5WnYoirwxy+DfhNF5ubdVm7WNINPuCs1X7mMZcN6aBE4Vo9yw1deDjFV8/s+QSCd
6JpsmssN8sIOQh+w5Axkp+Qk9JuVRbVI8nFDMhD/tPRUMkUG9mjCLjP3xQoV59+d
p9ElIEC+zSBWu9HCQW4i19eO+O53iT/9s7jkpXhFBbai02OOzw5q5LcwyL/qh0Zg
fhOWA9PFrwg7iS7Rknp3Np5Msb09gh86McZtp2htgkkbggFl7ak0nRG+qlfyN0P/
AKOYQ4agvMxC3FKsb/HmPv9Q+Brc5w==
=Zf2Q
-----END PGP SIGNATURE-----

--ZuqvFG62+4JL9ncV--

