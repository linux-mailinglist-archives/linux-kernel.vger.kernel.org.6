Return-Path: <linux-kernel+bounces-577028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E45EA71779
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 944AF188BB89
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285141EBFE2;
	Wed, 26 Mar 2025 13:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJrjX8zt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889991EB5EB
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 13:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742995518; cv=none; b=S7DjfPbiTiP+xSYvY5vfghNOKJ+AtUHWPbnlDPiECMqMc3JAlZ70/r1dHvQf5U7qz1VAcpu4UTg4rFRjzVOJ//uC+alFfX+8tbq8Snd47gwXJyvkZfqEeN4DOdRnTvpyG/ERXsaesHO2AjnrV5uiNZbTMuOtVQgRgQiK5PhrNHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742995518; c=relaxed/simple;
	bh=OhIw89YZkaS3K3MXCywHnvtvlklUf24YtHt6tXGm3sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isxTjZ0MRCjR9wgkkv60b9vLoaOkbDqzsuDun2hV/oRSSe9BCuYATlPvh5UQQ2jQcQBSzFmTIFQhqeuAWHmKx7gAadGEPWxqcFt/B1BYpRtCqpKofZdEHVlLF4LgPq1CjGfp+4COgZxSv89huMPaZTUCtgEmaA4GTF7PXPUIUgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJrjX8zt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72030C4CEE2;
	Wed, 26 Mar 2025 13:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742995517;
	bh=OhIw89YZkaS3K3MXCywHnvtvlklUf24YtHt6tXGm3sg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bJrjX8zt+D0Nh9F+su0AXC6mefdS0Fb/VueSXUSlRhiZHOI1YTqX513PKUGwAMEfu
	 ZlCSF4krPTGW+2HcbakE9Qrc5QylZN0U0/uyR4HwAGxodxKGMIOsNPmMBbg5jzrwRm
	 3Nc2d2XI/NI3Us5cyNM7yLHMztypm5F1uaS7M6RYuEYEWFHcDWz20Cz0+xijCaDVE2
	 EliOYCOb/M6/iwpm/bw0rU+nfj9lMR4Q6KcNyMe9MybmTxgKQKNJms1DVE1hFQFwsK
	 XN33SBCK6rDsEkmOiYM7ynonfeTardP8MIP0Ja2BfEbxaX4N5JriMm24oBHFy0aZpc
	 f2VduwlH+5gGQ==
Date: Wed, 26 Mar 2025 13:25:12 +0000
From: Mark Brown <broonie@kernel.org>
To: Brady Norander <bradynorander@gmail.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	u.kleine-koenig@baylibre.com, Wu Bo <bo.wu@vivo.com>
Subject: Re: [PATCH 3/3] ASoC: dwc: always enable/disable i2s irqs
Message-ID: <98b92d09-435b-4aa4-9b21-496b51ce7d5f@sirena.org.uk>
References: <20250325211805.2099278-1-bradynorander@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uz6+6+wQfmh8uPot"
Content-Disposition: inline
In-Reply-To: <20250325211805.2099278-1-bradynorander@gmail.com>
X-Cookie: To err is humor.


--uz6+6+wQfmh8uPot
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 05:18:05PM -0400, Brady Norander wrote:

> Commit a42e988 ("ASoC: dwc: add DMA handshake control") changed the
> behavior of the driver to not enable or disable i2s irqs if using DMA. Th=
is
> breaks platforms such as AMD ACP. Revert to the old behavior by always
> enabling and disabling i2s irqs while keeping DMA handshake control.
>=20
> Fixes: a42e988 ("ASoC: dwc: add DMA handshake control")
> Signed-off-by: Brady Norander <bradynorander@gmail.com>

Same issue with dependencies here - what's going on?  It also doesn't
seem like the changelog is describing what's goin on well, if all AMD
systems were broken by a change from 2023 I'd really expect to have
heard about it by now.  We've had AMD themselves doing fairly extensive
work without reporting any issues.  What specifically is the problem you
are seeing?

--uz6+6+wQfmh8uPot
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfkADcACgkQJNaLcl1U
h9AK/gf9ENDYToKaTXb4Hrcx9P0XxvUvlF84RfS1/ib0Hb8qCgU/lMj8niSuv92B
Fm7tRT82kaMCWuHIJIiB0IoTBd6WTqOiuWM2Tu6xJjhy26FZIGnXFh6Sdsm918iu
qsIFKt1MVJCy21/aDuOvRE6D0ZbPuh98Cz+vG65A5mV3eMNWMCd02bBffcFw/Fvr
ewQ1/Mea4BBPy545Xmq+1EeoBRZL6jAG+lQWlR8Xnn6iPtCIZ7C1YeccUL1SUYU1
oMAr61TtcP+o3vME6qPp3XJVfM+xXR0bDZinSZdzpoBHpPiSSv51eEGz6s06d9Bm
sCvKcd0POaQ8jsWW/Yga9/GVsquIxQ==
=PlC9
-----END PGP SIGNATURE-----

--uz6+6+wQfmh8uPot--

