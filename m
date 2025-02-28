Return-Path: <linux-kernel+bounces-538621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5073A49B05
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18E10174691
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FEF26E15A;
	Fri, 28 Feb 2025 13:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="shIDGphM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE1D26D5A4;
	Fri, 28 Feb 2025 13:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740750845; cv=none; b=RM1KzRKvtH7MWhUk7ULOpM38xxnSRceByNwuEHyCviLeuzhm6MneuLPGQBFcaNeOpA7VjWuo4ozqT3bDByZ1rlYWhFgkQCcAwBiB36w1MymOC4WE30PbdF6aClHZYQP5wZuRxlXwtl7QisuZ6wNDXA7piVelIoZWeMsIEzgbjHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740750845; c=relaxed/simple;
	bh=PJN2LJY1zOX4ftevEUh2wxj5EtexemsOWVyrqD0LUbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXuTGrTGVLq9EdpPsyYm7402HUKnRQx27Ny6NR6QqcYcl2sXPnfq0/jW6+qiYJUrJvEXNp3p5IBB0jgwOKdNmMRFQ+1g58YM3YJ4jHeInOiUq6hIfwu0mFnJ5o4NAMmzumGczfSHxr+NSIxiIODMgVngcjOAM4SY9sDfl7ktcpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=shIDGphM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EEB4C4CED6;
	Fri, 28 Feb 2025 13:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740750844;
	bh=PJN2LJY1zOX4ftevEUh2wxj5EtexemsOWVyrqD0LUbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=shIDGphM7vaQLJjGY/X+Rjd1UxdtYZIba70NWQYhJqxq4Q86mmQVOUfyj62fr49Fz
	 8DVr7L0ygLbvElSK9WkCjpu9HVBcCK5+22/GTC5TMkuqNcEobyqkGoW+Dx0+aH2aiC
	 3g2tRmJdWli2Ebknj5FMhCb4fLZneK1Wrx1D3IapW6R/QGrXD772kBvcreXr1YSKF+
	 CRaJojXLJnYkGuH/E69dPJxNH8VpBSUWvMOiasc1avt7t5tMYQ48AkCLtq6FWP/ie+
	 KDZ28MnDAhMvpDkI5kNQetuDcbP3N0gGubPYDe2G8JDIyaXa8Z1nsaWtUi2UsAXU+P
	 MAA0znUrFB5BA==
Date: Fri, 28 Feb 2025 13:53:56 +0000
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
Subject: Re: [PATCH v3 15/20] ASoC: tas2764: Enable main IRQs
Message-ID: <ba20e709-517b-441a-8f89-37518d0a1d4f@sirena.org.uk>
References: <20250227-apple-codec-changes-v3-0-cbb130030acf@gmail.com>
 <20250227-apple-codec-changes-v3-15-cbb130030acf@gmail.com>
 <f3eecce4-51d1-4414-af85-680d51e588fa@sirena.org.uk>
 <CAHgNfTx_kMj=rsd4nUCiX_PvgC4GX3DsPDwXHdEyEeLMbDFccw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YYYkVjdyM/0A8vBd"
Content-Disposition: inline
In-Reply-To: <CAHgNfTx_kMj=rsd4nUCiX_PvgC4GX3DsPDwXHdEyEeLMbDFccw@mail.gmail.com>
X-Cookie: Avoid gunfire in the bathroom tonight.


--YYYkVjdyM/0A8vBd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 07:58:33AM +1000, James Calligeros wrote:
> On Fri, Feb 28, 2025 at 2:23=E2=80=AFAM Mark Brown <broonie@kernel.org> w=
rote:
> > On Thu, Feb 27, 2025 at 10:07:42PM +1000, James Calligeros wrote:

> > > IRQ handling was added in commit dae191fb957f ("ASoC: tas2764: Add IRQ
> > > handling") however that same commit masks all interrupts coming from
> > > the chip. Unmask the "main" interrupts so that we can see and
> > > deal with a number of errors including clock, voltage, and current.

> > Shouldn't this also be a fix?

> I don't think so. The referenced commit only says that it adds an IRQ han=
dler.
> I don't think this commit is actually "fixing" anything - it's just
> enabling previously
> masked interrupts.

I think the expectation would be that when the interrupt handler was
added it would've been possible for it to fire.

--YYYkVjdyM/0A8vBd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfBv/MACgkQJNaLcl1U
h9DAZAf/ZrFnKZ/FuBMjARilKSLNHLOP7jWlIxEpAeaOpAnoNzqydRcLKZFmfObm
X3k/p5RujSvvZykZfpl21qgxEJeeN3q9mCoWd5QebZTJa4GljGyM2gMDGwQE+wcx
dKGCDAZwyiwwKSd1UML9U+Gjqb5WcouYMXC+nJM3xoauhz615Kz8JsIsOo9nZ2Jp
KrQQ83tZD59O81MOL3glAMJ9wDIj7kpQRHMJkXfQYYN1794HK0h6hfgdni1n3ij9
Bi2+Vzxw+f+wVRZVNFydQPOBeDca1aihac4QngDHbcRCP+ngYkJ7mvV+vFWhleJg
5VOFhK/5/NxifNyAKRWkUWX9BP2Xrg==
=9AfO
-----END PGP SIGNATURE-----

--YYYkVjdyM/0A8vBd--

