Return-Path: <linux-kernel+bounces-522830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA00FA3CEDD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 02:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DEDE189AC64
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 01:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C1B1C3314;
	Thu, 20 Feb 2025 01:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQR0o9Gv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F771F19A;
	Thu, 20 Feb 2025 01:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740015951; cv=none; b=Cp9jqUdh/HN9HFPeVWgj6TPAxZYK3YI/UegJnqg82Gk3bhb50G7bzK5oOQ66hE/I6A1Rn1JrH2kn44V2DhdvwEugssCqGAk00N6IurBaWTGh3zbG2nnpJ8Pq1dlx/BUVjVKSP4Fw5SiY1AZOy/+JV4cuT8fhdspwpFNUJeuT1H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740015951; c=relaxed/simple;
	bh=9irbtGVWQj8eLhc5O42ch0DohPLL2OQmuJNb1bG37ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XG3goz6Dczz6OqgjkiTKpCB54PM5tjRukSlxuKVJrsBVZT3TFqD4UEBjjdg805/5mQbiRxovGoAsQQPbkPNDW/yWyuYh0+ZEdnOeTyS5yL97M1uus3fqy4O71eEB9eXC/NmaUaUSBdG5/8n+OecQtUrjUuCHw3a7l/CHvJAqJS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQR0o9Gv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17646C4CED1;
	Thu, 20 Feb 2025 01:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740015950;
	bh=9irbtGVWQj8eLhc5O42ch0DohPLL2OQmuJNb1bG37ZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TQR0o9GvMeGIOLknSOOAuwSnE1/m4pSPPZmKSQFEqHVDzAh6g1XNFC82sWuK3BXzh
	 JP8AuxUjse5a6Vx4dcXyuhwZodZD68zz0TmzuGULFHVn5iYzRbdk5eGFaqkYgwCI5r
	 1Ikrzi6cyBWFU13D2fOHcPZtv5tGiLKjj+VawXSoAOXSRCTOMtCHDbDegTVQpY1LGr
	 l8+EzcCb9dk6k6XIDrpEx4RM2PftUlva7qfRs29WTsjW0ThOtT/HY9IouUPUjLGG5F
	 7cg1brC8uiyKa2hM27hfBc0v9jqFPcY0/LqMHSBSwfdzxJYfUX+AdOo88/mf4P+mCo
	 X2aytNNmfzdvw==
Date: Thu, 20 Feb 2025 01:45:47 +0000
From: Mark Brown <broonie@kernel.org>
To: James Calligeros <jcalligeros99@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>,
	Dan Murphy <dmurphy@ti.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shi Fu <shifu0704@thundersoft.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
	Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	asahi@lists.linux.dev, linux-hwmon@vger.kernel.org,
	Neal Gompa <neal@gompa.dev>
Subject: Re: [PATCH v2 20/29] ASoC: tas2764: Add SDZ regulator
Message-ID: <Z7aJS_uq75aKLCht@finisterre.sirena.org.uk>
References: <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
 <20250218-apple-codec-changes-v2-20-932760fd7e07@gmail.com>
 <Z7SoL3HN7Xb3HUTm@finisterre.sirena.org.uk>
 <CAHgNfTwmR57GyiMk+-_x3jVNjxCpgLvS4dY2wbZkJN68PgSdjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="L0ausYZ/FTrIXK1l"
Content-Disposition: inline
In-Reply-To: <CAHgNfTwmR57GyiMk+-_x3jVNjxCpgLvS4dY2wbZkJN68PgSdjQ@mail.gmail.com>
X-Cookie: Editing is a rewording activity.


--L0ausYZ/FTrIXK1l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 02:47:04PM +1000, James Calligeros wrote:
> On Wed, Feb 19, 2025 at 1:33=E2=80=AFAM Mark Brown <broonie@kernel.org> w=
rote:
> > On Tue, Feb 18, 2025 at 06:35:54PM +1000, James Calligeros wrote:

> > I get that the reference counting that the regulator API does is useful
> > here but this isn't a regulator so shouldn't be exposed as such,
> > particularly since this winds up being visible in the DT ABI.  I
> > could've sworn that someone did some helpers for this case but now I go
> > looking I can't find them, we certainly don't use any in the regulator
> > core.

> From what I recall, no attempt at shared GPIO infrastructure has actually
> landed. The multiple {de}assertions of SDZ put each chip on the same line

Yeah, I can't find anything.  Perhaps I was thinking of the reset API,
most of the other users were reset lines so it's plausible someone
started and then just ended up with the reset API instead.

> into an unusable state that requires a full power cycle to clear, so
> we can't live without
> handling the shared GPIO somewhat sensibly.

> One alternative off the top of my head is adding a dummy reset controller
> to the DTs and integrating it into the ASoC machine driver (which we have
> downstream). We could then put the GPIO behind a shared reset line, and h=
it
> that instead of the GPIO. This does seem a little complex/odd, and IIRC we
> considered this at some point and decided against it.

I'm not sure that's particularly better than the regulator version TBH,
it's still got the problem of showing up in the device ABI.

> Is there any other option that may work here? I'm open to ideas.

Perhaps it's time to bite the bullet and do the shared GPIO API?
regulator could certainly use it (and has a bunch of code, we could
probably just pull that out and wrap an API around it?) and now there's
this too.

You could possibly also open code, but that does beg the question about
the shared API.

--L0ausYZ/FTrIXK1l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme2iUoACgkQJNaLcl1U
h9CBlwf/Ub4h2DWpJglm2UVUSMy1p+jAgsQRt9EndRI/Ud+eqYFTizBKQyKwah4/
4BDSMQ0dIjhPBrArdfTm5Vsdj3TqgOyxaVQarJ18XKXoq9TM2JMpNr4xydKb43bl
FvYaraHXdTwE/yx/gWaM5/lfx5JXf4yngatnf1Qz3vec5QeapYywRoWMVtBW1fBB
rkKKv25XTHzG8D6DWK32PQnk1saKSdn6Uwx5f2qcS0OTwxCvK6mTq1/4cWE6JUGl
tmY5wtcVMTSCxcCB3Kmp8y//HbNM+vHVTlm7KUQMg+jhf/Ydkq9CaYVX7A/QV/b2
C1aD3TtPwl5KxBweUygcLU86e2qRQg==
=z1+I
-----END PGP SIGNATURE-----

--L0ausYZ/FTrIXK1l--

