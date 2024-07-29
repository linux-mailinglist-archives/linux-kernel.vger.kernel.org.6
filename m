Return-Path: <linux-kernel+bounces-265973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF1D93F880
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 658F2B22B3D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D6915531B;
	Mon, 29 Jul 2024 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMtdyXcr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C3814AD19;
	Mon, 29 Jul 2024 14:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722264286; cv=none; b=jEhy8kvo15O7QNb5Qvl25z9qTxxwroTZJ3TwCWbNAmjBZYlvAzwFhMdLuHJ/gGBzxqB9i6ZXevek6ufYdm7kYMCJQ32NDGtzXN79HaJdaOuJwFBMxixuYuMKr88jtpX42rF3Xyq1TUopis5xSXSRlH03AsyDOt0/yJDDzPcgg2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722264286; c=relaxed/simple;
	bh=KxWBR2WQwkmRfSCkEK5fdabdTfFVBLXY+ljiSnLfdNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvYnlGU01XSBns9ttMD9scXlnHsSDXVTLptrXcCyICspTCU99Moo8bSA3rFbOg5gWjZ7CwECVv6sS8n/xLxKBjQKIra4Uq3hbRVHeWUKGcVjZXSbN02hVS5B9ojK/u9ugx1pGzjTeLSAgQZvgiEdR7oE7by9VC92+oUqElIxwgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMtdyXcr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF204C32786;
	Mon, 29 Jul 2024 14:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722264285;
	bh=KxWBR2WQwkmRfSCkEK5fdabdTfFVBLXY+ljiSnLfdNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FMtdyXcrDjT+14PVlW/6r4syixCSaKqIUXnSi5kCjwQiJj5LOu4ZUqzenz79NmnX7
	 Tg6sEsWl6CUJ/EYNhNBQiwTdMokOfYuEaVXI/JPCH+j84wR8FjKieJ7j5R7DxeTBmU
	 wKREQYsVBwyh3ib3rqriS1HDCQNdeNX22vlq/BNKu4FtT93/GoELWvgBTscEnDCNdG
	 VvMdH+M2ndsoFkjOEwL/XsgnDzb0jiTIfydbxBj6IK4FPJ0zArJKuoWVUQqZYL6Sdb
	 b+s5UF5eYt1RriuBvNDjeRVzkbdV2UDIjHqby0cFZRf+I1GaEu7Rc2/N0DYe+68VWL
	 4yPPeWBVHl/Fw==
Date: Mon, 29 Jul 2024 15:44:38 +0100
From: Mark Brown <broonie@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@sberdevices.ru, oxffffaa@gmail.com
Subject: Re: [PATCH v1] ASoC: meson: axg-fifo: set option to use raw spinlock
Message-ID: <2b16b95e-196e-4d8a-98c3-3be568cdd18a@sirena.org.uk>
References: <20240729131652.3012327-1-avkrasnov@salutedevices.com>
 <1ja5i0wags.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2XEkMrvS0Bz782eU"
Content-Disposition: inline
In-Reply-To: <1ja5i0wags.fsf@starbuckisacylon.baylibre.com>
X-Cookie: List was current at time of printing.


--2XEkMrvS0Bz782eU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 29, 2024 at 04:15:31PM +0200, Jerome Brunet wrote:

> Maybe mmio regmap should '.use_raw_spinlock = true' by default when
> '.fast_io' is set ?

> Mark, what is your opinion on this ? I guess it is not the first time
> this occurs ?

I don't recall this coming up much TBH.  It may be that people just set
raw spinlocks when they need it, or that there's not many people using
relevant devices with RT kernels.

--2XEkMrvS0Bz782eU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmanqtUACgkQJNaLcl1U
h9CHbAf/QzKprEIGtlybUxTku0YVZcAyep64Z+8aqLmUDAfk4G0fPQ8c/sghHsJ+
NlkYK9n5h4eVGX0XEcU0Gh1ScYM6rBG0Xn2iHzN+6RynQTy2jUwCGeNP5HqkZ0H9
GpQgDqYAoslZ86VjMS04UrpgvrzTUz8B0iS3xgAf2E65lLR44GkZXIDtcjSm2/XV
Y3wjjPjiD6km5Y2Z+C0b0Gk2/5jka1JWGk7f4vDnLJKANam8hC7F5500PVV/TY57
xFSlsxbh3qBpCqDPHx/Fpcp3tXpNjVyTRP3LRWGQ1AP9PBXe6/932SYV83k+0r60
lqoZkKKHkfVlHKnHfhfWuswMCX6bAQ==
=187k
-----END PGP SIGNATURE-----

--2XEkMrvS0Bz782eU--

