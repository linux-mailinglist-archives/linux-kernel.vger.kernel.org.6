Return-Path: <linux-kernel+bounces-389274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD10C9B6ADA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 685FC1F22141
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2668E2185B8;
	Wed, 30 Oct 2024 17:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtaftdpB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800F921859E;
	Wed, 30 Oct 2024 17:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730308649; cv=none; b=GJaDpPiS5otUuiWUFuGaU1I+9GFGEOLOAV8qV6iUd2bdSKGnM03kfD3flJqwblwUxPEpRZlWmbK6/nqWkI7a8jCQZ0lZxGiT8Y8zN/E6g8fVq2lCHg9d0gS8c8RHiBWftvw/3uNFZY3mPBW90/D2aDPzp2l2l6sAdndAfH/qREE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730308649; c=relaxed/simple;
	bh=JT7qXkQuscgr0+ce/MwGlczUVnZinXxGiUnrotEMLV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8EnXLO+M4iOcYmCfNot9QS+MLe000XXq4EJf2p6TLmu3dpChD5IxfjIOrtKYpbTGXnf6buByn6llWy5rEvD54ZX7iuImBZ2WjQMwfTfBOrdG9F3TuCGswg5tFH21kioFQxLB/3b1sEhMXwl17bAvRAZhKXC/oLLAKLn1zlPCB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtaftdpB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E54CC4CECE;
	Wed, 30 Oct 2024 17:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730308649;
	bh=JT7qXkQuscgr0+ce/MwGlczUVnZinXxGiUnrotEMLV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NtaftdpBJTD3sau/XuQ6euvEZtgvqoRv2kMwpkheUEu9f3cA0F/XPpZ/kx3c2QUxQ
	 37X3wyWqHqHEyh+ucaFsU0xFcXZn+NLq5t2W1tc7GhdwVYBGB0qYQc0JMT/GWOVl/Q
	 vp8gatiqWSzEiS8IM4FQ83BLrE0REm+2Lr6nRZfD/SkslA4TCglHcujssieRg2an9X
	 u8hlF/uoITJ69UbhqtKcICZmDpRZnq/WFEoO7R3PUhk5C+RFgHDB5e0nYObmftM6hy
	 2ZpFL656a1bSvUWHkT6L33yOhN8hJwsWnTGCKcT3o5elHA/j5Jf+Fndu5Ya0omKZw8
	 YI2izW0SYBR6A==
Date: Wed, 30 Oct 2024 17:17:23 +0000
From: Mark Brown <broonie@kernel.org>
To: Suraj Sonawane <surajsonawane0215@gmail.com>
Cc: lgirdwood@gmail.com, peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
	daniel.baluta@nxp.com, kai.vehmanen@linux.intel.com,
	pierre-louis.bossart@linux.dev, perex@perex.cz, tiwai@suse.com,
	sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sound: fix uninit-value in
 sof_ipc4_pcm_dai_link_fixup_rate
Message-ID: <7794115e-607f-4ba9-b833-a45b500f46b6@sirena.org.uk>
References: <20241030155705.31327-1-surajsonawane0215@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eq/9Gla+Cd+CzODI"
Content-Disposition: inline
In-Reply-To: <20241030155705.31327-1-surajsonawane0215@gmail.com>
X-Cookie: I feel partially hydrogenated!


--eq/9Gla+Cd+CzODI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 09:27:05PM +0530, Suraj Sonawane wrote:

> These errors occurred because the variable 'be_rate' is declared but
> may not be assigned a value before it is used. Specifically, if the
> loop that assigns values to 'be_rate' does not execute (for example,
> when 'num_input_formats' is zero), 'be_rate' remains uninitialized,
> leading to potential undefined behavior.
>=20
> To resolve this issue, initialize 'be_rate' to 0 at the point of
> declaration. This ensures that 'be_rate' has a defined value before
> it is used in subsequent calculations, preventing any warnings or
> undefined behavior in cases where the loop does not run.

Again, this shuts the warning up but is this actually a good fix?

--eq/9Gla+Cd+CzODI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmciaiIACgkQJNaLcl1U
h9AB3Qf/RaoCEib6C/hIkccuynIcQZ3dJDntt7e9tAcwS1MXJV1on/U83ASLN6tf
O+64INfsTLUmADLP+HJtjCUbxvNreIPqdImNEaaeOMv3IKQjeDSHw3JhI/1wqVa0
jkkea9qyuob/dA+aHj3RarImmNiL/jIJdgbJ6TM059dSxhEdsYYAyzxmdeRQuN0W
Fdw8kgKqec+YUooAQPfIxU7nZxkAqON4j8T19EMtq06w6vMkeCUPfI2aDOElWps5
Utzr/R9DgdepcmKyStC842FaEoydCUEph0SVt1RYBY4FIlLB45/L/lGPdBwmqG/V
2z/Y5+W0b9NYLHVt8+H4wfs3fWBN/w==
=E56S
-----END PGP SIGNATURE-----

--eq/9Gla+Cd+CzODI--

