Return-Path: <linux-kernel+bounces-190575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8388CFFF3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58CE5280F7E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D801815DBD8;
	Mon, 27 May 2024 12:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9KQmDxn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A011581E2;
	Mon, 27 May 2024 12:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716812684; cv=none; b=lvaaeN0UG787S6GJ1xRAsqWAEV/woSYr88q6nENSfTmvxUZyH56ge61uiyvmspxsjf3vmd5WClZ38junlRa/aUkARxG96v/9+iZTQzgWnXllA+Gw2AvTY8ZukWFRSwqxU+gSsWBma1kTZMsHyEc6iatt9Is7OsI/JLodn1Yn4us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716812684; c=relaxed/simple;
	bh=AC1H0aiKdZcdpc098PhYIZqVMQLoaF+pLuHEt1fMz98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QtdsB8oBaZ2+iW+Fm7sAvdX7n7i4Ld7XNynJ4qjNloiqUFqKIVGOSViN0dui7aRWtyNiQwjlA9xqEE0A7OUIYct1qmJRlm+ddZUOlPEXOJ77s50shbooZCqWY/JVRqJBEYb/Uu2iVq0hZLsi1mbRan39qEVOtKiio3pCNFMDke8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9KQmDxn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B053C2BBFC;
	Mon, 27 May 2024 12:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716812683;
	bh=AC1H0aiKdZcdpc098PhYIZqVMQLoaF+pLuHEt1fMz98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c9KQmDxnOw5TGTXwGxEEcfbgKsoiOBfITuiBO/2/kWfxmcSEsdv5Lp41x3oJZPaYN
	 Ilb4vd8afUoOfTHTjag/aFynY/CMZexYZ/iyjGy/p274N5D9ilvb0cfP3EdSDJ8ue0
	 kgwCB8WJ3vurwnHhTo88smbCv3E09csXENZZRWPzfbMOUX1qM2nJJQ7C51TgJAjtbo
	 XzIlu31EI+KeupJ1ecVMHFIewzSoLhO6/UA4PaiPJ/JqGZvlsN1M20SnaFQeQZec+e
	 arnzHtXgUuCeLi6wvnyUEHqRj3FnOox/aO/vVb+44qa0CU2tRh3WGFY9sPSwGq2Dt9
	 Wi7aV6VhIz8vA==
Date: Mon, 27 May 2024 13:24:37 +0100
From: Mark Brown <broonie@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org,
	peng.fan@nxp.com, mturquette@baylibre.com, sboyd@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-imx@nxp.com, shengjiu.wang@gmail.com,
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] clk: imx: imx8mp: Add pm_runtime support for power
 saving
Message-ID: <f0a38df8-9197-452d-a46f-2bc2697c1186@sirena.org.uk>
References: <1711026842-7268-1-git-send-email-shengjiu.wang@nxp.com>
 <20240424164725.GA18760@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9Jl/B1Q1Lia3QbBq"
Content-Disposition: inline
In-Reply-To: <20240424164725.GA18760@francesco-nb>
X-Cookie: Not every question deserves an answer.


--9Jl/B1Q1Lia3QbBq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 06:47:25PM +0200, Francesco Dolcini wrote:
> On Thu, Mar 21, 2024 at 09:14:02PM +0800, Shengjiu Wang wrote:
> > Add pm_runtime support for power saving. In pm runtime suspend
> > state the registers will be reseted, so add registers save
> > in pm runtime suspend and restore them in pm runtime resume.
> >=20
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > Reviewed-by: Peng Fan <peng.fan@nxp.com>
>=20
> Is this introducing a regression?
>=20
>   800 13:50:19.713052  <6>[   16.531134] clk: Disabling unused clocks
>   801 13:50:19.727524  <2>[   16.535413] SError Interrupt on CPU2, code 0=
x00000000bf000002 -- SError
>   802 13:50:19.731400  <4>[   16.535421] CPU: 2 PID: 1 Comm: swapper/0 No=
t tainted 6.9.0-rc5-next-20240424 #1
>   803 13:50:19.742514  <4>[   16.535428] Hardware name: Toradex Verdin iM=
X8M Plus on Dahlia Board (DT)

I am now seeing this failure in mainline on both the above board and
i.MX8MP-EVK.  There was a fix mentioned in the thread but it's not
landed for -rc1, both boards crash as above.  What's the plan for
getting this fixed, should the patch be reverted for now?

--9Jl/B1Q1Lia3QbBq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZUe4QACgkQJNaLcl1U
h9BZAAf/SwbkQw7xNK6oPYnkKBhetfwKUF87XHoq2QNLdmGrV1nAsXHA+HccQ4P1
CGAxLSlJPtMNnZ4CvqPkNfWTmY61novb449w9cydqCmjeJt9XiR1lXmbskFryEMh
Q/DROuRTtR8TKaSczQii6Cftc88XYTtqb8O1rhl7FLpLliEE6MwW+jDF9xfyq6gs
y10D5yAmXsHxUjob+O5l/uxq64hZhoBF7RaqAGIwwKwTFF2ma7WOPYFar80BaYRg
/Ujrvt+j0BsnLEmmbo0B6QPbeG6u/VhYWw8y2FJVk7FZt20uxSW36luHoKc9Zm/U
f2DKhcL3jyMzwJpxOxxzCfHaF8+Kow==
=QP7g
-----END PGP SIGNATURE-----

--9Jl/B1Q1Lia3QbBq--

