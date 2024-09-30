Return-Path: <linux-kernel+bounces-344877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 355FC98AF2C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E15C51F22792
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6040418892E;
	Mon, 30 Sep 2024 21:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rw4MlEot"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB960183CCA;
	Mon, 30 Sep 2024 21:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727731862; cv=none; b=q9iby5UZi4wycpQ/qqPT2kEi6WSCBd0mIT4PEwfvkCxRHr9LNFcRvhztvdfOFiGm1FITQgYyKPS+XwykqZFqWViDs0GCXR1HBZvjodlur29hkuEoDc8Dsnn4pBTPxh7A/f7BuHzyWVB5T8fwgEzk1uKS3AT0lUPb+Kwnnh8TsuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727731862; c=relaxed/simple;
	bh=sG0WjLTVUV4DLkeZIrde7W6dgLLQSQa+eK0I6BJYcWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fplMJZ5Uc5CXAn0UDkLqjva3KQw9nyeWz1QPhcGqFlysOCxw2MDsYGrDiuICZY+zywdU2YPVrYnCf/eYCNVKoJ0pPVOMnfryQmJ4XqCl0eNkK863MhOneFdfUdGs3hzAYqWvEFNBrU5T+/Od4CNJo2oYwCOq9xNJESZN/dkpyf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rw4MlEot; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4759C4CECD;
	Mon, 30 Sep 2024 21:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727731862;
	bh=sG0WjLTVUV4DLkeZIrde7W6dgLLQSQa+eK0I6BJYcWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rw4MlEotZEFE5Npk0WTvCl1Fvj9NKs0Gg30zelvD9leBFFOzoYZbKcblUYbQ46VBa
	 abAXJ7v9Pznolkbs4xHDTfm09ofvSUt5R+14FGbMxCGD6yeoAN8p5Q6PU2MY0K2PBS
	 DJmvz1+gjt6iKyplREY8EMYD9FXssBJwW2OWV5bV8iPlA63/3F7LNDBmuFuShyFJ6T
	 NNzaFSgYIB4/lVJkNcw9U85MQmq+Rbgd9x6rfFZHB8Y6YBos5RCp7UOTc8+lxH9sYg
	 MP/J2eagbdSEVNY6csQvo1z8Eyyl21Mqaq/9JdaBwW/tdO2uJY0YMCjQKyHFvIfv2h
	 DqVLfiwzQcIpg==
Date: Mon, 30 Sep 2024 22:30:59 +0100
From: Mark Brown <broonie@kernel.org>
To: Benjamin Hahn <B.Hahn@phytec.de>
Cc: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Teresa Remmet <t.remmet@phytec.de>, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de
Subject: Re: [PATCH] sound: soc: codecs: tlv320aic3x: Fix codec gpio-reset
Message-ID: <ZvsYk4aGCPvR2kyf@finisterre.sirena.org.uk>
References: <20240930-wip-bhahn-tlv320aic3x_fix_reset-v1-1-c040d86a4b93@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ss51HuvtAhdbVrv8"
Content-Disposition: inline
In-Reply-To: <20240930-wip-bhahn-tlv320aic3x_fix_reset-v1-1-c040d86a4b93@phytec.de>
X-Cookie: Editing is a rewording activity.


--ss51HuvtAhdbVrv8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 09:16:46AM +0200, Benjamin Hahn wrote:

> The TLV320AIC3007 requires a hardware reset after power-up for proper
> operation. After all power supplies are at their specified values,
> the RESET pin must be driven low for at least 10 ns. Even though the
> datasheet sais min 10ns, I needed more than 10ns when testing this out.
> 15ns worked for me.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

> -		if (aic3x->gpio_reset)
> +		if (aic3x->gpio_reset) {
>  			gpiod_set_value(aic3x->gpio_reset, 1);
> +			ndelay(15);
> +			gpiod_set_value(aic3x->gpio_reset, 0);
> +		}

This seems obviously buggy, it leaves the GPIO with the opposite state
to that it would have prior to the patch.  It's also not joined up with
your changelog, that talks about actions taken after powering up the
device but this is a callback run after power has been removed from the
device so nothing in your changelog motivates leaving reset deasserted.

>  		regcache_mark_dirty(aic3x->regmap);
>  	}
> =20
> @@ -1813,6 +1816,10 @@ int aic3x_probe(struct device *dev, struct regmap =
*regmap, kernel_ulong_t driver
> =20
>  	gpiod_set_consumer_name(aic3x->gpio_reset, "tlv320aic3x reset");
> =20
> +	/* CODEC datasheet says minimum of 10ns */
> +	ndelay(15);
> +	gpiod_set_value(aic3x->gpio_reset, 0);
> +

This seems more relevant to your changelog, but I don't understand why
aic3x_set_power() is not also (instead?) updated?

--ss51HuvtAhdbVrv8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmb7GJMACgkQJNaLcl1U
h9BieAf/Vp5HfjKUfjOE+hQQ22cmOPcRL2UDliOw+WcX/kxj1TfBpi34eMlq9njN
D/tYemfgRJ6+oro0mi3vBb+tETc3XkQWqOXBEtogrOmQyjZLRW3SBYqcFUX2rwBA
iG2U+132Mw6cGF6HA9obD+W9zIlB8vDg+FktjJ1FTkyo2Wjk7IFgkbNl1q+V5gk5
5t2PIRfDuxCG9GwN8QZzDXZUlsN9Q8kF647JXP3CezOxr8UwUfjZENRD/UaENwol
rUW+5drNKUk+brOMPKGSD2IRY6nE9rnWpGRkoNQuFbwZgyALOZ5NHpJdBsHrV8hc
aUvt4u7yfr6Q1+pM2GT8sO9lSABsWQ==
=+A+z
-----END PGP SIGNATURE-----

--ss51HuvtAhdbVrv8--

