Return-Path: <linux-kernel+bounces-178553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 948428C4F88
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 12:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6753281824
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 10:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F64D129E81;
	Tue, 14 May 2024 10:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfFlObsN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98CA53E30;
	Tue, 14 May 2024 10:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715682105; cv=none; b=PwaspXj4Wvqaodc4u+VmcBALOKPlSI9+7nuLfXxLp7044W+gc0A+UfNzAMuYaOlUTLyDQvgX4U0wKEzIN6z3DBOxC562Sn1z5mzqRXZZrwLnRxjtoX0guZt9Xtq91fA1qu4dbU2Lm49D9Op3TP0lt+8HIoihfrfTjE6tG8LYM+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715682105; c=relaxed/simple;
	bh=MlD37PhYaCYGWNXB+XjgAOliaEbuIjPec0duTTv9ngc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlDAY2drVMJIKPebXpIu/UUFglfhUO2YO2DgiYvfp5w+xa+H7/dM3JCHlW74ewxLwNLFFK3lXnxySt9rATj5sD4FvaZ0NakmRVmMk8Z1p9jsfYKWNhQtHp6R5qeeYPgMvcGks3qzKxASmTagacgsWKCZmihInd+tUYNapuFbdto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfFlObsN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5998C32782;
	Tue, 14 May 2024 10:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715682105;
	bh=MlD37PhYaCYGWNXB+XjgAOliaEbuIjPec0duTTv9ngc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gfFlObsNwvICy6Ottyc7oE+Hl8pJyYYXj3h9E3FrxQSo5bRF+KfXayxwDEdKEj7EJ
	 v6DglZeI553eFwOaDRycJC7dXPFIHnLdVZWgDBaRqPsX321Pgc22fpT8+F7xXWnaR/
	 JlG/x6nArF+zpHXEDn9PCZ4WopblfDI6Rtn0G3DmAcKGUch//Bojsm+YYI+D47s3qp
	 H1RHjKC86EtXDkoD9jn2xONn3sYw8dG7u5KEIEhjZchwwZ25j+yr2WHYl4YN3aqL3j
	 NzEOxI9eojQmA8AmCmUBshYnso5aRa504XkUAnCcwVPVYFGSZJtY5YjCHU5Bp7b88m
	 a2XQqlTTNwQHw==
Date: Tue, 14 May 2024 11:21:38 +0100
From: Mark Brown <broonie@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
	cezary.rojewski@intel.com, pierre-louis.bossart@linux.intel.com,
	peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
	srinivas.kandagatla@linaro.org, bgoswami@quicinc.com,
	daniel.baluta@nxp.com, linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org, sound-open-firmware@alsa-project.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/6] ASoC: topology: Constify an argument of
 snd_soc_tplg_component_load()
Message-ID: <1fb69d24-03af-4742-9f44-5a93704f5cfb@sirena.org.uk>
References: <f2f983e791d7f941a95556bb147f426a345d84d4.1715526069.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/yzFNmYb1iOOUdKX"
Content-Disposition: inline
In-Reply-To: <f2f983e791d7f941a95556bb147f426a345d84d4.1715526069.git.christophe.jaillet@wanadoo.fr>
X-Cookie: In the war of wits, he's unarmed.


--/yzFNmYb1iOOUdKX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 13, 2024 at 07:37:20PM +0200, Christophe JAILLET wrote:
> snd_soc_tplg_component_load() does not modify its "*ops" argument. It
> only read some values and stores it in "soc_tplg.ops".

As mentioned in submitting-patches.rst when submitting a patch series
you should supply a cover letter for that patch series which describes
the overall content of the series.  This helps people understand what
they are looking at and how things fit together.

--/yzFNmYb1iOOUdKX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZDOzIACgkQJNaLcl1U
h9D6KAf8D7XMQi5rJoTwxI9Bu02nKcGaXYmMbfHTt9hAM5CY6TONJDV9QVBsu5dj
VaeRt4XMiNUQE5eZMwuVqyEuT6ZOjuZs+A5mZUQ4OZx7GpAW8p4VnkxBVqOoHPCV
Iub0jsw4DBINsrpvtpds6+65rmg6IzZwaZLyc5I4yF7gqJiNRL4II1Wo6mgAGmkX
XmDUP3ViiX5WqbZQNDUYCD/NOHCjTDRqiv+PnRB11iYOiGyThOiEqr8V3mt3o0/H
dZQB82eb+i8O5jnXK222WHcezw9OgJFiEzVmpU0EEooUFmIIh5MZJhqqIdc+w9JB
cqXOrlguU7cXitcrwir2QCzFWKY3Lw==
=Z+z6
-----END PGP SIGNATURE-----

--/yzFNmYb1iOOUdKX--

