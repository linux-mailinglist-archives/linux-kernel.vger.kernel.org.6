Return-Path: <linux-kernel+bounces-285237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A170C950B0B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D226F1C24E2E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8080F770E9;
	Tue, 13 Aug 2024 17:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFSoJQXR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C648E19D09C
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 17:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723568598; cv=none; b=JOsgVlSRFVMJ5gMYR+AP37yqK7BMZkd1z1RZseTdHRq++N+TdAIDwyxVN07oPyzZNNYVPTLjar2RYCY/bp/iXdgSnc7hkA5dCAJAVwwPvvLChO4rKNnjH7D8+0ei3rvopmgDklpHengHtJLSqqrKtd4Ovp+q16Z+LFdw+jelFVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723568598; c=relaxed/simple;
	bh=zjXhHY/dyo+ZEmSXQqKLQj5vnsg6JIFP0iMe4ldIFIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLNHVD8+g70Pwef3Hr3VkQ3w2/L1/BeQ/w/OGOHR2i8NGkQMmbyV6YMu7yRHe7FGS2mucePIJRkp5oAU4vlOqU7EpPKE6gfMDfeVVWHWr5iswjePw52KiBx/3DVUCA/lskJOQRXH+XYL8I6fiYtzPn00pglFmSlO38fpfW2GIx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFSoJQXR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9836AC4AF09;
	Tue, 13 Aug 2024 17:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723568598;
	bh=zjXhHY/dyo+ZEmSXQqKLQj5vnsg6JIFP0iMe4ldIFIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IFSoJQXRBWHFY/t9qO7LZe9yyZD/OwS4UJdsAZo/Kyirre/FEGxZslCtSnnBcef18
	 Z0KkcJtCZZ0L3ddz3rTC3HwpuSxPeALCA0yrI2VqNiXKJXy6Gby4XiWspY5kea2Gt9
	 Ru1oH5UshfYe3fhIpRdDTCquzm0QxRY3i7WahYjenmsRxmZZfpshvSvuwaofIMS/bq
	 qp9RWfN8NV3NsSaCFf3G4tx48myrvttlh5//zYtTSoXi0eTL4ds02aDFnzUvZlTEAw
	 tKEo8Yi8deDA3PuLASXhslYnwTv522lbUGSCS1Y8J8IiA//iCtg5PY7LIpedC8VKlh
	 4ummdmGG7jIUA==
Date: Tue, 13 Aug 2024 18:03:13 +0100
From: Mark Brown <broonie@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-amlogic@lists.infradead.org, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: Re: [PATCH] ASoC: meson: axg-fifo: fix irq scheduling issue with
 PREEMPT_RT
Message-ID: <1ce67190-0905-4895-af42-13f44b4b638d@sirena.org.uk>
References: <20240806102707.3825703-1-jbrunet@baylibre.com>
 <172356023429.57695.4053614993109219592.b4-ty@kernel.org>
 <20240813152243.2H3-mnx5@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vlnUGC53pdqRsVmq"
Content-Disposition: inline
In-Reply-To: <20240813152243.2H3-mnx5@linutronix.de>
X-Cookie: Say no, then negotiate.


--vlnUGC53pdqRsVmq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 13, 2024 at 05:22:43PM +0200, Sebastian Andrzej Siewior wrote:
> On 2024-08-13 15:43:54 [+0100], Mark Brown wrote:

> > [1/1] ASoC: meson: axg-fifo: fix irq scheduling issue with PREEMPT_RT
> >       commit: 5003d0ce5c7da3a02c0aff771f516f99731e7390

> Didn't you already apply v2 of this?

Perhaps?  There's a decent chance my copy of b4 just didn't spot a
difference between the two versions and acked both.

--vlnUGC53pdqRsVmq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma7kdAACgkQJNaLcl1U
h9AdDwf/RPJNLc/NcopRgM8Ry8xsd9sWTOlXjL62AnYXLeXm9YANI8w3jGiKg1Iz
UvOL9uVAXVGLOxR/WWODaD5j6n0gfEhvI25Bh+f+zoXMPamj0nB4VtlD22tMUCJH
TmS/9VN4V2ndNXYOD+jBQ84bnzurUPyBRysJC2NAPRyHAGTIaV58rBTXiJfMgKMx
z0FwHxXoZy6g6XgzgCTfaegSSe1q2P0b8Jx3EstoRcS/Zk2oepb3FFWzwId2LjKz
gHiaI5NYH1UP1YyQFAPJV0vjqF0EzhcXB/03k6B9KKCxMdqZtETNppmDUH3YGH6j
I3baEoGjJxxkw51mRhHxsqinYZ/NKA==
=1J0B
-----END PGP SIGNATURE-----

--vlnUGC53pdqRsVmq--

