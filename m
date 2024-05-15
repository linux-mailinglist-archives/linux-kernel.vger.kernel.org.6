Return-Path: <linux-kernel+bounces-180088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBEE8C69F6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 296351F237AF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 15:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359BF15623D;
	Wed, 15 May 2024 15:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IM1BJLV4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7951E149DEE;
	Wed, 15 May 2024 15:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715788064; cv=none; b=DE8QjR+nkw9lsHpg6JlTS2bch4NPRky/43BDmSysQM6Od/Qv8vIN+B2G2eQ/EkHzBUErx5yrHvNsDJmfs8qehle/UnIxWVDAfRaxOu+c13+5Qshp7ktWMEVXCvfNgDx9Cr9lShnuChy6jO8/7jDkylQ2ARr8hn+su9AYLJSSHjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715788064; c=relaxed/simple;
	bh=6I+MGZNd4rB5QdCOoR+WpEcEO2EJbxQV0kEaZArJvlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9R1oL1uF7Nnzixw383MtozqwCG+82h8rPYgVf32ycniQIfBLBouTc7YDW6/KbvNKYR9mO6U9hfODhPDZRv3Pf8VVF5AsHHAVC73f7NlgOokzqmBTDK9I+j8BaA8zYR3IjK6ioQ6XFwbq+8zUlyQQ01vgE7tFwTBYTB3B97hx4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IM1BJLV4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B86C116B1;
	Wed, 15 May 2024 15:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715788064;
	bh=6I+MGZNd4rB5QdCOoR+WpEcEO2EJbxQV0kEaZArJvlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IM1BJLV4yLTSFoY54Mhy5LccAi03DsafhNYwwUbkci4vKDoSBordczSmhlk9S6Li7
	 MOLHTKJxxPer/o+0WVYPSqurRfcnagz/4ZKZJtP77rRO6l0bv8ZYVJE9alNfxjcGmB
	 pcCaMVdEc3w4DHvfdMq7qhWnlmdFb3UjdlyondkppZm1mlc9XXil5HOI6f25fnchmT
	 UQrRA2OEK6XKk0bFlDfrs4w2jfdKTK7q1h2psmfgRe1BcV/qRPllNz1+MJUPQ68dWx
	 M7g+d1HulVzGGu/8EDkH+K1+YLudxFhXhhIvNmzsw++b7rCC7+OD/WpWKb9iLHLkKm
	 pI327MDKoJvxA==
Date: Wed, 15 May 2024 16:47:37 +0100
From: Mark Brown <broonie@kernel.org>
To: Alina Yu <alina_yu@richtek.com>
Cc: lgirdwood@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	johnny_lai@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v3 1/6] regulator: rtq2208: Fix invalid memory access
 when devm_of_regulator_put_matches is called
Message-ID: <f86923b8-a8ab-480f-901a-f29b0dbb0df5@sirena.org.uk>
References: <cover.1715340537.git.alina_yu@richtek.com>
 <636cbe817ad61a18f291b5ec8938e79043b8a646.1715340537.git.alina_yu@richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LooefU3oAUw2ONnD"
Content-Disposition: inline
In-Reply-To: <636cbe817ad61a18f291b5ec8938e79043b8a646.1715340537.git.alina_yu@richtek.com>
X-Cookie: When in doubt, lead trump.


--LooefU3oAUw2ONnD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 10, 2024 at 08:06:20PM +0800, Alina Yu wrote:
> In this patch, a software bug has been fixed.
> rtq2208_ldo_match is no longer a local variable.
> It prevents invalid memory access when devm_of_regulator_put_matches
>  is called.

This doesn't apply against current code, please check and resend (on
Linus' tree rather than mine at this point given the merge window).

--LooefU3oAUw2ONnD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZE2RgACgkQJNaLcl1U
h9C5mAf/RLEHA17jLhOJTGLODiEwCkSBeMr4/xARXquSHhkRvqJBPasTnrkFoLm+
YgnG7t4uYvWZPTNNWFfQRx0nFEw/S8EiWm/qOMOzVy49L4/wVgqIWrwfcOnXPB/s
m0JSf58npdHGkdbFbfKK+z2WLYq/UyEYDL6SeqXaw1ThFrxuvOVYs6vEyfIrtb69
5W9XgPgHOVpg+vIsij3BFSM/qv6+xVfmuD0eSNWzjoq8E54ZOKNQtdV+1hN0meKb
NCa5CBxckJM012dbAMZ7tEqAvssevQczYnRxe4DgTwbJZvj/ad9CXeZpFfa9U0y6
k9JdCFOb7+lydkN8NIS/PcZ6JUsp3Q==
=0Dbw
-----END PGP SIGNATURE-----

--LooefU3oAUw2ONnD--

