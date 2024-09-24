Return-Path: <linux-kernel+bounces-336823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A5F98414F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93A071F22CE0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F5B14F9F7;
	Tue, 24 Sep 2024 08:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZ+eP0No"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7532F154425;
	Tue, 24 Sep 2024 08:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727168392; cv=none; b=Xri/j1j7e2zOEt+6f1E29Yt4ZRbfO2SnYeDjeqggwVjUABnCO6A1XDO8SgkMUyUFq1yVlFDukA92sT70sftkyQUJR6d2TE2DEa+IrpMynDqcU5iDmqQpLUY1QaEh56nPLb7XgCOuITfSigAUiy3VKAbbRmjByyBMQeCZiQNnr/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727168392; c=relaxed/simple;
	bh=TLrkBFemfelhj1kiLCKREGu0cq6ty1MyW7kJpC8QUvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2LzAfolOKodQu0HjJAfdpj8NEVvZH5nPwgruBXFH39zfVT5vEZ0Y7hr8HJRNfPpdCOm602zOyzVyYQkOx8WT8sgXDVZGc9WzD5Soo6rfv9XLi23M9763u56CIn/XZ5nDDu7i6JmgFiHOLfJBbV2JBkx/Eg7fAOPWZrEH/oxdlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZ+eP0No; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7829FC4CEC4;
	Tue, 24 Sep 2024 08:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727168391;
	bh=TLrkBFemfelhj1kiLCKREGu0cq6ty1MyW7kJpC8QUvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gZ+eP0NoOfTUNQ66K/UIvuJN7Z3zonhi9zGaftGYcUuK2cGkUyHjbq4THcYa8Wq4T
	 YwMj9qxVtq7i8TqRZbvWH1mSsXpXs9a0EdXBYrZcLZgGTtaXSBDUIYIhZsAfcn5NtC
	 Q2I8e9nJHzk6CY1ccc57tTmLlByHTC7LsoK45I+75817AWfYA6+DEKw5BTcguQgJO0
	 Y7JbPcwppqCSTucP/rhmG/JQHU2sjVEwrCp51PjqXM+M+VeYPwtdHgSX8oA60PXyLu
	 SPg/ohOUFBU3qtZkdu9aETjIHGzNCWqar0lSkAW1/CJn3zhAUvFoWvz3D6OSBm7JAx
	 Rkx+BzaQzd9Pw==
Date: Tue, 24 Sep 2024 10:59:48 +0200
From: Mark Brown <broonie@kernel.org>
To: Andrei Simion <andrei.simion@microchip.com>
Cc: claudiu.beznea@tuxon.dev, lgirdwood@gmail.com, perex@perex.cz,
	tiwai@suse.com, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: atmel: mchp-pdmc: Skip ALSA restoration if
 substream runtime is uninitialized
Message-ID: <ZvJ_ZFpIiRpD_uzO@finisterre.sirena.org.uk>
References: <20240924081237.50046-1-andrei.simion@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2muQ5kptOkRWm/ZR"
Content-Disposition: inline
In-Reply-To: <20240924081237.50046-1-andrei.simion@microchip.com>
X-Cookie: Editing is a rewording activity.


--2muQ5kptOkRWm/ZR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 11:12:38AM +0300, Andrei Simion wrote:

> Update the driver to prevent alsa-restore.service from failing when
> reading data from /var/lib/alsa/asound.state at boot. Ensure that the
> restoration of ALSA mixer configurations is skipped if substream->runtime
> is NULL.

> +++ b/sound/soc/atmel/mchp-pdmc.c
> @@ -302,6 +302,9 @@ static int mchp_pdmc_chmap_ctl_put(struct snd_kcontro=
l *kcontrol,
>  	if (!substream)
>  		return -ENODEV;
> =20
> +	if (!substream->runtime)
> +		return 0; /* just for avoiding error from alsactl restore */
> +

This then means that control writes are just discarded which presumably
is going to upset things if they actually saved a value here.  Why is
that a good choice, rather than either fixing the race so the card
doesn't come up too early or removing the need for the runtime?

--2muQ5kptOkRWm/ZR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbyf4MACgkQJNaLcl1U
h9Aj1wf9GqdcLwKUvMJqTKMQBr+Edfse4rBuLYpHdRKFkhzXt8AU5W9nPdEuQmC0
AMYaMRv1ego8rh+/0Ie8uhvT8Pn3iXSscTilOmGdqARKSrVY1BjvKT9emM/fElT8
/rFFhWqfCc7nUI+0ICvuDizt6SCd3o9HuyQGSHso1diRrLFWTK0ZCfGhL127ibV5
AQG9W52l/WZ6E5Ter27tUYTzyh5Mh5xGeIxlr49tsZk7kW653CHb3lwYDkKIsQFk
lfeafCz5f8fv6AtlwJ7LSXawYM/9Wx67WawjCpOc9hwP+eCCLnMemZzIDug1Db0s
+bIiayW9Pjhpa7gkDR/JRrfvlj2TvQ==
=AXYI
-----END PGP SIGNATURE-----

--2muQ5kptOkRWm/ZR--

