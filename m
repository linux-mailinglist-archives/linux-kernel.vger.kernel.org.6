Return-Path: <linux-kernel+bounces-197202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A84C8D677B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF7FB1F26C70
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BAD16F904;
	Fri, 31 May 2024 16:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwJWdVwE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFEA176181;
	Fri, 31 May 2024 16:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717174534; cv=none; b=QHwMoUJzTTcE995XL40a9wGQvAs1C7rYO0rjEVoHGmMP75PXRs6IMZT7JEDX9JyCrfsmhEVMqbBDlJx8M4nRRGMJ9u4GtHZkn+YUpnm8c17AVUiUwuAJ0tGUXsTiK8MRE7IENElypB6BqwYoRFh7Nxxfl2yG2RAF6d/HErJzMmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717174534; c=relaxed/simple;
	bh=RH77djBrTwFxe/ywwViYLxao4C1lTcLNgr3/+jlMw7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpCMKXUnKUwR1v8bNALmyNg/5n+MsFylwQrU1Rd/zb+WpH6eF0wOI/q29Xw/6mYH76FTl4gzLvupL8MuM+TncWHfHa8zlJTyjIGwACgYpL8ZaYerDMwotznTf6Nl/+LwNDksAscPNdkwSUaWoqLwhRWVzwD2w7fe+uYfUQG5pRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwJWdVwE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B972C32786;
	Fri, 31 May 2024 16:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717174533;
	bh=RH77djBrTwFxe/ywwViYLxao4C1lTcLNgr3/+jlMw7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TwJWdVwEKQxLLuT2zhjCTU4ofNhZhMJQVWLYsNllbzmiMq4g+3q/az/Usq4y43LMF
	 hOqKdVWc9tUeRo8JlaOG3viw8wq3006D8Rxih/RtMd6tIkX+7jcI9m3QUyEupqHLb7
	 9/fXTCFvzSKzAnFIyyoQAJl7Sc79Wz2apuktg47kb417rVbeqJUxup0/AHvwrj5R0k
	 JdicKCg+5jWkfBM+/gO/px8hBHvP4bnvaDIlNnSzVr32iJbIuPwq+Htln1qwJS55Uf
	 rQuxZg0TrapwSzjUPs22HW6dEGALSrMySthcq4Y8XGU5ySw0hTiTJdviQTZcsl5hif
	 EoZ1rzO7n4e0w==
Date: Fri, 31 May 2024 17:55:27 +0100
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
Message-ID: <5d98d8b0-dd48-48dc-9552-b2906e31ce05@sirena.org.uk>
References: <20240515135411.343333-1-elinor.montmasson@savoirfairelinux.com>
 <20240515135411.343333-8-elinor.montmasson@savoirfairelinux.com>
 <ffb3624f-2170-4642-aaa5-fb6736a75d59@sirena.org.uk>
 <822567441.349330.1715936735603.JavaMail.zimbra@savoirfairelinux.com>
 <da74d276-b028-448b-bb28-295de49dbcda@sirena.org.uk>
 <1660761484.701255.1717159615755.JavaMail.zimbra@savoirfairelinux.com>
 <826f6c22-d1f1-42ce-a8d1-2d5cb894a970@sirena.org.uk>
 <1200863744.706237.1717166892907.JavaMail.zimbra@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="O3x7E8WE+Xf+WtR6"
Content-Disposition: inline
In-Reply-To: <1200863744.706237.1717166892907.JavaMail.zimbra@savoirfairelinux.com>
X-Cookie: Serving suggestion.


--O3x7E8WE+Xf+WtR6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 31, 2024 at 10:48:12AM -0400, Elinor Montmasson wrote:
> From: "Mark Brown" <broonie@kernel.org>

> > So you're trying to use this as the audio clock?  There's no code that
> > enables the clock which seems worrying, and I'd expect that if the
> > device is using it's own clock the device would be querying it directly
> > via the clock API rather than this.  This all seems really confused.

> It's not specifically the audio clock, I am merely using this
> in the machine driver to let the user the possibility
> to configure the CPU DAI sysclock frequency.
> The CPU DAI and codec drivers already manage their
> own clocks.

I would expect that if the clocks used by the devices are configured via
the clock API then the drivers for those devices will configure
themselves via the clock API.  I still don't understand what this change
is intended to accomplish.

--O3x7E8WE+Xf+WtR6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZaAP4ACgkQJNaLcl1U
h9C7Dwf/VLPq1S4H7OOi5cno1DA8yYITCEnfB9hv+QK0u+IGgQEVBH3ZIHElkzjs
Vqj1WunQBboYBEZjSS67nJ4jCvB6G9AWz8D+yWfWP+YDOs08fCFLNG4pTtc+ooME
lkLEVgJedtSHdOscDTWWlntBQJEXcWtEKccBh4BOPdqlb2zV/fJywO/shUPPksfA
ZW7bi8SFI5chXBl+xgKcYaBXfI306bBmQK3ImFZk5o/6j2izLhL703EZXBRFi0yX
2wjSn+Kxq9sMVe7igXvkQ53pQjVLz+tKaqS0YIEKGVs+nKMs/aihz0ie3wk3yexM
dDL8RGtQmKuDLwU9/pZho2FiLBkLfg==
=xMcC
-----END PGP SIGNATURE-----

--O3x7E8WE+Xf+WtR6--

