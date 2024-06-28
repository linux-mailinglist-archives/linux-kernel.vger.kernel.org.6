Return-Path: <linux-kernel+bounces-233892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBAF91BED0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00A1BB22CDC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7301158A27;
	Fri, 28 Jun 2024 12:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSDstujL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF96615885D;
	Fri, 28 Jun 2024 12:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719578552; cv=none; b=L4GBY+BeiXuuMFNVZr30wTWWm66/MsesgppmA4B59bd52YIu6YrOcVKIB2EzQmscwIwX5C+QfrvFxYgF+CaZzeK/YhCF/rWWNfL45Bl+dITh6L7IXhAGYEYi2HWRf+2l697jrhGLUuh5KRlEzmFR6vWBtHi9Pc8YVL62AlvcR1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719578552; c=relaxed/simple;
	bh=N0otqIc3ONhcPh2fSlqdXklkUC8yTJ+pjdVnueEHiBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDTN6QdzDjY3JNafRl3eAUW8B5rsMX7hQO6154xcML26q9DDeZCLuiWCFO4TJfW+e7ikAii7K3D9F6YG9d+0yzVT8ruAvd4XcwMVDBm5eDbk+AzvDc8bFobReimgqA+9y6Gyx/8dvyh1S/E11TLNHjBgz5HcSmPbqGEkg+x8Dz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSDstujL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D9DC116B1;
	Fri, 28 Jun 2024 12:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719578550;
	bh=N0otqIc3ONhcPh2fSlqdXklkUC8yTJ+pjdVnueEHiBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mSDstujL69YFplT8GMQUW6etXVqYim2UsIpevYJxJHHC7OJCf+oXQfDkAVpvlgAjX
	 oQdKrVah3u/DFIRL4vD7+vZraOfY7NihkywFTeId2c52CgK2NFM0sq/PULKvxqUIhE
	 RqI0usWQdI3h9e+ZOa9aSXrkhG1gJgzaxtBSe4iLlE6M6lMN57g5XMytNRwBFPsn0R
	 wFxGJyNCykH++jhK+GgQm7g8DPVryaI67RQ6kkUR082lMWB1R579E4nMpxtp54uJnP
	 TR/vjyajsKnpKCcywKOpWskjW62Ay+K9rsHlhF+K40dG0+I9xIbcdVq7Wzp/Kx/FIn
	 JbUPIWWZkuZxA==
Date: Fri, 28 Jun 2024 13:42:26 +0100
From: Mark Brown <broonie@kernel.org>
To: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Prasad Kumpatla <quic_pkumpatl@quicinc.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_rohkumar@quicinc.com
Subject: Re: [PATCH v1 3/3] ASoC: codecs: wcd937x: Remove separate handling
 for vdd-buck supply
Message-ID: <53015d64-a194-4596-8950-a55b4b0e429a@sirena.org.uk>
References: <20240628101143.1508513-1-quic_mohs@quicinc.com>
 <20240628101143.1508513-4-quic_mohs@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="moOJjz50aeceZ/EA"
Content-Disposition: inline
In-Reply-To: <20240628101143.1508513-4-quic_mohs@quicinc.com>
X-Cookie: divorce, n:


--moOJjz50aeceZ/EA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 28, 2024 at 03:41:43PM +0530, Mohammad Rafi Shaik wrote:

> Replace free_irq() with devm_free_irq() because irq have been requested
> wth devm_request_threaded_irq().

This seems like an unrelated change, and TBH if explict frees are
required I'd question if devm_ should be being used in the first place.

--moOJjz50aeceZ/EA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ+r7EACgkQJNaLcl1U
h9DDoQf8CENJNEqvh0heJLuo8hBLqvgk9WIppf3jh5PzOjDdRdXS2nahpPtX5PTD
1uTxZdTMlGXpxSlGlXckNbCU9JxM4gWFTwd5Wtda6FH4KNQi6DUlIZJEUvN2w9CG
6up05y4UUj5L9bBJyhypenv/WdWBUmXYKqzHsYw6zMIA9yW1IPiVVSIVK7c7YOKm
a8ItfxzMnfhnfvlsYPnNl4a1PwwY2y/3s97sJqcQM8aVqD+yC1yxOiFZPtyKGjUJ
QrGaLsV85yaQkec8o01fU1G6ZCYAG+Rj/eEci4ydMUQLgwI/G5bTebF9OT+Y/9BY
YoVYikmuGY4eIDvy1p4d7xY89yFUpQ==
=lr/h
-----END PGP SIGNATURE-----

--moOJjz50aeceZ/EA--

