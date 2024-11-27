Return-Path: <linux-kernel+bounces-423903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D829DAE15
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F11FFB21BAF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 19:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAEE202F86;
	Wed, 27 Nov 2024 19:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wg3x8J70"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1769202F60;
	Wed, 27 Nov 2024 19:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732736659; cv=none; b=OzpCwPqLWFK2dmHMk0vJ+ZXldnF0bYgdkx1BM5Q7ekvnONrpOUwQprJqcaoDuALzt1cO4VQXxcGBjhYJfAeORBa2n/9tG0r3r6oUPtPbcJGb3gbNa1vqtv+hFx0Rd8lpGM6E0dByGWaXA/eAJrwwAt/15fDCA0Qgkos+hG9B3jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732736659; c=relaxed/simple;
	bh=B99Q4TuUQCBVDCulwhs5KeOYu87zTkzwgednVKDrSFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjEsMrDCEU6Teymutfy1/UA1v6F5IB641iaOARarl++BgDMFBI5D2mb4BUQzdbUOlPHG/1l/mp3CJWbizWsGhBYFGFxIldLLz8IITyI0QyUS4DKVMGKqFJWMTadpqzJ0lYxrE0bYVJXeevqZOSu4xe8G7JnAXJ0+pv/0Oj65NW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wg3x8J70; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3346DC4CECC;
	Wed, 27 Nov 2024 19:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732736657;
	bh=B99Q4TuUQCBVDCulwhs5KeOYu87zTkzwgednVKDrSFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wg3x8J70uo0NcNGP02BmgzmvsBbJ39XPNvBLS8JnMLm2wWqH4dSkJjM09EB/oHwzV
	 tQh2lCSwwL5bf7exd5labZ+zW/Mm66DUrk2jst8i8nJz+h9ex6bnAJjzgabu9OUO7i
	 n2kOALJbi/W8q3nGvCbMcJrh5zyvtBBrZZXkldeyc/bC5lRaCUGkT6+brSFD1210D1
	 5oZDttkjRuPp7/ctAC+K+fbjrqTo1DsGD/BUmvLZFWiMdlKm1DYX07xi2it7nRKXey
	 ERu5VUXglBg2Yn939r6Y/cppVsmBg9RjtwGsRdWrQWV4gPvAierVVE2QFOaGQ8I9EH
	 tDgc56u4qjiqw==
Date: Wed, 27 Nov 2024 19:44:12 +0000
From: Mark Brown <broonie@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Esben Haabendal <esben@geanix.com>,
	linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: imx_*_defconfig: Fix i.MX pinctrl enablement
Message-ID: <23adf02f-68b5-4927-96a9-0793b9a80608@sirena.org.uk>
References: <20241127-imx-pinctrl-enable-v1-1-d3431a98253b@kernel.org>
 <CAOMZO5CbgmGpJvurf0Ctomj5dDOt=dC5X8XvwaqsM9Ce_uXhUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tpxTvM+AVXAWYvlF"
Content-Disposition: inline
In-Reply-To: <CAOMZO5CbgmGpJvurf0Ctomj5dDOt=dC5X8XvwaqsM9Ce_uXhUQ@mail.gmail.com>
X-Cookie: Every path has its puddle.


--tpxTvM+AVXAWYvlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 27, 2024 at 04:36:12PM -0300, Fabio Estevam wrote:

> It will also cause regressions for people that have their own
> defconfigs (where PINCTRL is not selected).

AFACIT we generally just tolerate those.

> Then I came up with a v2 that simply re-select PINCTRL as a minimal
> fix for the regressions:

> https://lore.kernel.org/linux-arm-kernel/f65d65b3-b60c-4c5c-a002-81370821ee1f@app.fastmail.com/T/#u

That also works of course - whatever way we do this it'd be good to get
this fixed for -rc1.

--tpxTvM+AVXAWYvlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdHdosACgkQJNaLcl1U
h9DB0Af/fCc7aDc37iy2DwGKzHqlYm4tYaWEMqyvw+cPSN7QDQXrDZecDrqy2FXQ
bHpjvVOMR023AVHmuvqSCnaAzctb+zacIWAHs/M/0sRDN28wpYVhjUN3cpDc1Ewl
VzoqQ6f3sRR72WzjOp+++zbYLXaKS8DLv3jrwRVBDa70xGVSFPkz0r5m1qxuiYwU
JaN3lBS2yyxPTtcaMsMRAmzC1vR536dtl/eFF75ZTycXG0akP8VKLD1T5GAcdTq1
5VhFY/mv2A7OLqOrScQ/poOuOe7UFLkisFAEGnlVhjNlLJGJTpytPeEAQkS4NN9F
hcnSSDrPCwljg1Agog5RsZObnbjCpw==
=Jw5l
-----END PGP SIGNATURE-----

--tpxTvM+AVXAWYvlF--

