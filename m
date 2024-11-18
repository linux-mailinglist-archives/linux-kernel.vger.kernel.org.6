Return-Path: <linux-kernel+bounces-412735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AC19D0E94
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C20EDB2F505
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131361946A8;
	Mon, 18 Nov 2024 10:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJCCrg9b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F2F25760;
	Mon, 18 Nov 2024 10:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731925517; cv=none; b=HQggiMl3LY/KNzjMjtvnm+7bHM4xEVDeus1hsu9fxdlivAcEHwyo9OY5GLQW+3hNpDeEW1dhFEsL6V4oIJiMhnNe+7PN09U+JftOq2W/DEubXCEDmgFt5AnQEjlKa1Qhre4qBc3j4BNLSMB4kkHDl05C4+XLGmTZf2cHVHb9uFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731925517; c=relaxed/simple;
	bh=ggXBfg4okLKWMAgjg72jaDL3DCA1UF4GqsJy38hSKnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abV465xEQhLffh2onGMFd8SRx3z+6q9A+d8tbjHSPB5juO9Cq/trlquSxCS+V6eAc170Zs/5UB+2M9wlrwTgce4sFC9dZLBAzKYzUF+CcrnsJneFNz5dgMMJkj6zZJnxaPsVUQxSKHcY0UTNXFF7ZYRlC0OKBSuiOGvzUEulX8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJCCrg9b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2136EC4CECC;
	Mon, 18 Nov 2024 10:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731925516;
	bh=ggXBfg4okLKWMAgjg72jaDL3DCA1UF4GqsJy38hSKnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sJCCrg9bvID2IyZQEAeQeREC3tc+Lc7oWwX4q7GVqzfB7U2G0UxpqoKMwl6LYHt7D
	 0/LqX4mgHcylmECKoDG9/grRXGMeDTD3uL5Haf/Ou9cuO42a2U2Yvkl7/HRHonK/l3
	 cJ0MoOCJ+7GBMj9HHGFX5anGLRBmh4z0s2BGT2x98azXgcAWx/fYFgAi7Ys6FI5vn6
	 qJKiCWMw26fUyWrb1PmEmb+KI8/VCGGpl3Fb+TEnmVrJzyamH1l5ddbG4DUq99Csgw
	 w7jpdRqgpzHbTHJub4CEzXj/2veMUuSIUcFIUlQ4cqiH1n9n27a4Qr34D6ZbuTH3ZN
	 3L7+V/h9OwKDw==
Date: Mon, 18 Nov 2024 10:25:08 +0000
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Peng Fan <peng.fan@nxp.com>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_scmi: fix i.MX build dependency
Message-ID: <5b8e7658-85bd-4f08-b535-49dd228badd1@sirena.org.uk>
References: <20241115230555.2435004-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QAxsM1bWuCAH5DLb"
Content-Disposition: inline
In-Reply-To: <20241115230555.2435004-1-arnd@kernel.org>
X-Cookie: Used staples are good with SOY SAUCE!


--QAxsM1bWuCAH5DLb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2024 at 12:05:18AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The newly added SCMI vendor driver references functions in the
> protocol driver but needs a Kconfig dependency to ensure it can link,
> essentially the Kconfig dependency needs to be reversed to match the
> link time dependency:

Acked-by: Mark Brown <broonie@kernel.org>

--QAxsM1bWuCAH5DLb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmc7FgMACgkQJNaLcl1U
h9AHygf+I9zVvzEwmUe8hbkMAhNzupktcwow3B9jxslgerjTscA5tuygFib3caoG
anu+zdsOxBLh/pYdc/MrKXBEt5Avbe7rK+hXv7po0spzAX/Z45NyvuZ0wsQjm43E
0PbRY139l03Y93jWXC5YEupS9M9p7/Fh0JdTn+qSca1jT8P0B+/OZTHGghRLteLZ
1qTG77fhn4ru60+MADnLvYqw47eVOgcykhZJSCA3qSfkekSxypAvq13lvyBSiPgj
lVEjzhWsaaAzfI1q4u+TcsPbuuMoLk6uFX1HBwSAeD+DUePRPuoPg+jRVEjUf08/
66z5nRhBiYqT06/LiOjkjLecgy/K+g==
=Rp8x
-----END PGP SIGNATURE-----

--QAxsM1bWuCAH5DLb--

