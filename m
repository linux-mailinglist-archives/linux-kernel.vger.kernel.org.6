Return-Path: <linux-kernel+bounces-266025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A5A93F96C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 17:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 413A51F226B0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B560915921B;
	Mon, 29 Jul 2024 15:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O835ec6e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C1213C9A7;
	Mon, 29 Jul 2024 15:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722266943; cv=none; b=sU3C4bLQOk3H55hTmEL5CJIkCp6NLpw4j0wdLXPd4xPHs14rUKvIj7YNrtMb/EluqXp+IHSp5IgNC3sLurFUypmHJ+kg5JOgt0T7v4PVituESYWhXuZ9xh08DXKKv8fbIq4fP1T0SyrD8ig2Zlg53b8MfbV3rpbpwepy5pVD11I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722266943; c=relaxed/simple;
	bh=HqkjoguZvqsKPeQskLKsPhwwJrvtg3CvezSRwjNzBws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZw5ErmBUTWjGrenW4Y5QG5IBOcMb0cqhmuV7TtQPaIN945XrIrzmroVhS9yKdGqI6PYlHH+yn+PGghcUX5gPvIMZ/ie1JR5SNTNPS+Fgi+qFwhF/jpAzpg+yW1kvg2MHujX9sKB7AoGLiTeUGlzvC385Ij34CyG23PStXazRLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O835ec6e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E4BC32786;
	Mon, 29 Jul 2024 15:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722266942;
	bh=HqkjoguZvqsKPeQskLKsPhwwJrvtg3CvezSRwjNzBws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O835ec6eJaDgRRqJR5TsUi/ibb7o8jjFGVntcxx6cOdHy75Fs1xm48CJFucmRnZFf
	 HG93JYpoIqtCTzqlpM7SBwg4++uhVy5YCk0hpzkoz6yOv4spu4kYGTS5mHk2p5UzUW
	 svG2EtDnLTM1oS2HeikUj9xQPzjmoDejAmDkLKgh6SMeCJ1FMzN9zL8umauPy9NVcp
	 +dX/cdEn84vpOylMy5wXer0T/L6YgucTgJ7wfpTkuqZkr5pFZTkpIKdhdrYiZkDd5i
	 0viI2rnol21t6NduTcBa6nVQe9F058PEwbQqtKpAc1FbnUPwyFIObVhVhm3yFpaYAX
	 oXG+XE19kyIYA==
Date: Mon, 29 Jul 2024 16:28:56 +0100
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
Message-ID: <7dfdade5-3a57-4883-bfac-067c50ec0ffb@sirena.org.uk>
References: <20240729131652.3012327-1-avkrasnov@salutedevices.com>
 <1ja5i0wags.fsf@starbuckisacylon.baylibre.com>
 <2b16b95e-196e-4d8a-98c3-3be568cdd18a@sirena.org.uk>
 <1j5xsow839.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RyUOgkh7sxl4UhKN"
Content-Disposition: inline
In-Reply-To: <1j5xsow839.fsf@starbuckisacylon.baylibre.com>
X-Cookie: List was current at time of printing.


--RyUOgkh7sxl4UhKN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 29, 2024 at 05:06:50PM +0200, Jerome Brunet wrote:
> On Mon 29 Jul 2024 at 15:44, Mark Brown <broonie@kernel.org> wrote:

> > I don't recall this coming up much TBH.  It may be that people just set
> > raw spinlocks when they need it, or that there's not many people using
> > relevant devices with RT kernels.

> I have not been playing much with RT TBH, but AFAIK, with RT irq
> handlers are threaded unless IRQF_NO_THREAD is set. In this case,
> something preemptible in the handler should not be a problem.

> The axg-fifo drivers do not have IRQF_NO_THREAD so something is a bit
> unclear here.

Yeah, it's definitely likely to happen all the time for people using RT
with relevant devices.  I'm not sure I have a good sense of if it's
likely to be a nasty surprise to switch raw spinlocks on by default when
it's currently controllable, I'd expect it'll generally be fine but it's
possibly a bit rude to any users that don't use interrupts...

--RyUOgkh7sxl4UhKN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmantTgACgkQJNaLcl1U
h9C44Af9HvsmmLk0VmGmh8xg7Qy0Az4bExNuz32UcirchZh1/10ZgzU4P5Z9JMdF
vpHcBjvsrLKNbqzxKAgQEBwkF0DoasgukZsKqYtM+7egDiXPN6KKvM0Uq1f2ZkNY
EhJatJ5UkZHE0Jku8I0eRLkaGi8ERu23A/HkUDa/jZ65v2iUMMxeoFh/D2MxpKU5
VXbuPlITsDbMqXMqfNfUBCT/h1jnSTWPI2bZ/WYky5GEUMfeN9ur4hEkIa+H+qBV
nvMo2aV08EjX0tZ+ZjRmt11xAXhg7CC/2y9/7gqzlZailMmIlrdtL+7fr0DTkIe8
VNsHlUV0/kkcM6F7UijIgO5lQ8Z4nw==
=Q7xF
-----END PGP SIGNATURE-----

--RyUOgkh7sxl4UhKN--

