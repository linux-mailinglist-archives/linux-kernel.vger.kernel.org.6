Return-Path: <linux-kernel+bounces-519744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FE0A3A161
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CC1C166367
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0133826D5C4;
	Tue, 18 Feb 2025 15:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9u4tCHt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E50526B977;
	Tue, 18 Feb 2025 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739892788; cv=none; b=E5BocJp4fu5wrrNHhNld6ZzuTzHlDQ6W7s4kNXgiCWazXeUTg7GwiVvTBgY5p+jazLHLcSwotv+XYTzbxv9HhAdc5ZyGAjOpwxIMCvkRkZG7G+uQGfa/kEHhbVuye5Y8Ht7IokAJ7L1RPbwXRwI64F2Q7vuQsL4OREErBTFyakw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739892788; c=relaxed/simple;
	bh=SEcSvGqFeJ11Iq08rF601HaLImuJ1qHcDIFRTq6KKsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HkeKezPkv8kAGfoAw47g+mMZFnxGYX6NyiO1vDpHQI/QrKv8lu/8JA/EbXbn6yr+s9sxJ7Rh4l9253vDFGGoLxGPCSnFgDqYJ2nGLij0FHwe8zChfHiq5PfwN23EqDKr9h2LcIpc8fgIbqUBqi64am9Cy3mIDCUgdfL8uiziGDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9u4tCHt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A493C4CEE7;
	Tue, 18 Feb 2025 15:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739892787;
	bh=SEcSvGqFeJ11Iq08rF601HaLImuJ1qHcDIFRTq6KKsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A9u4tCHtAnA1yRYSYs5MGup5zXlFZF2N0RKjFuJWt3+zhjmN/mH3MpqzYXwcXyld7
	 tDt5MQOM8m4GTC8cibArGv43BFdgt9KoZTJeDxGXxMBEUJeay8fYOKwYDzIg/BoHhi
	 rdo02+pJKEz5p1f1sc6IDy4rG9SkgxzCXFlEXTJQ+YFeMzXBvX2IEv4iqR7Eo2DahP
	 E/KJJ7LGbjAcxwCcvC2+dIo4oym6jUrUwnnJI81+VU6/BecYaV4lZBc3esaUOSiews
	 B7D8A+1pChNWaQlQpwIoreLHOTfG5uNg1MeGhcX7N7zNI6zfGZE1yKXGoO7SkaCif9
	 /m7o62wiaTkiQ==
Date: Tue, 18 Feb 2025 15:33:03 +0000
From: Mark Brown <broonie@kernel.org>
To: James Calligeros <jcalligeros99@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>,
	Dan Murphy <dmurphy@ti.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shi Fu <shifu0704@thundersoft.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
	Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	asahi@lists.linux.dev, linux-hwmon@vger.kernel.org,
	Neal Gompa <neal@gompa.dev>
Subject: Re: [PATCH v2 20/29] ASoC: tas2764: Add SDZ regulator
Message-ID: <Z7SoL3HN7Xb3HUTm@finisterre.sirena.org.uk>
References: <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
 <20250218-apple-codec-changes-v2-20-932760fd7e07@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pWAmxsziw6n29cMf"
Content-Disposition: inline
In-Reply-To: <20250218-apple-codec-changes-v2-20-932760fd7e07@gmail.com>
X-Cookie: Editing is a rewording activity.


--pWAmxsziw6n29cMf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 06:35:54PM +1000, James Calligeros wrote:

> Multiple amps can be connected to the same SDZ GPIO. Using raw GPIOs for
> this breaks, as there is no concept of refcounting/sharing. In order to
> model these platforms, introduce support for an SDZ "regulator". This
> allows us to represent the SDZ GPIO as a simple regulator-fixed, and
> then the regulator core takes care of refcounting so that all codecs are
> only powered down once all the driver instances are in the suspend
> state.

I get that the reference counting that the regulator API does is useful
here but this isn't a regulator so shouldn't be exposed as such,
particularly since this winds up being visible in the DT ABI.  I
could've sworn that someone did some helpers for this case but now I go
looking I can't find them, we certainly don't use any in the regulator
core.

> @@ -210,7 +220,7 @@ static const struct snd_soc_dapm_widget tas2764_dapm_=
widgets[] =3D {
>  	SND_SOC_DAPM_DAC("DAC", NULL, SND_SOC_NOPM, 0, 0),
>  	SND_SOC_DAPM_OUTPUT("OUT"),
>  	SND_SOC_DAPM_SIGGEN("VMON"),
> -	SND_SOC_DAPM_SIGGEN("IMON")
> +	SND_SOC_DAPM_SIGGEN("IMON"),
>  };
> =20
Spurious unrelated change.


--pWAmxsziw6n29cMf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme0qC8ACgkQJNaLcl1U
h9D0zgf5AQykdBizrukXzPnimCpFL/x4jnIllW3wFPfrmEQhfMMZwNMCSS7Vjq/5
BBAYZry7PEXAVMGVnv2DthOvUrAH7LxyDiZ2p/RGmTSp4+0pujUznfB49hIl3oVQ
t47FKBghaQKV23zIyzLqRRL/DkP33/jcH2cXg1DKGIuaXtocGvHgAzB7GUEXnKM2
0X5hYFntNU19CmrW5Z9469/bLwVQMJb16MeoLRhxh0/5Wz3ZF88ReujhUdyVZZMs
3R9Dxrw4Bfp0V541KOwy6S0Cz/M2XYS1DqA2eIRPE3AmjftI+mnW9xpLXZqglW+D
D9yoJcQZCmlka3jnqIAdKXjBqe6xqg==
=IM1z
-----END PGP SIGNATURE-----

--pWAmxsziw6n29cMf--

