Return-Path: <linux-kernel+bounces-519713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A159A3A0F4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EE8F3A38E2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C60F26B94C;
	Tue, 18 Feb 2025 15:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4luj5Nv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD01C13DBA0;
	Tue, 18 Feb 2025 15:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739892013; cv=none; b=rocZzhVe3F157HEc84AnkIVV1tRQ4R+rE+o1gXH7m1zJUHxDjMkL0wSUv1E0nlM95ZG3lt54hE1AMWwzM8ROgGYZOvYHAsXIs0fVGLyuA3FDMXxvWS2NQuULQHqx7Muc7g8FTVFB60C4aHwFhbnWLLjdzv9d/estd5xGvpSAVVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739892013; c=relaxed/simple;
	bh=ln1PUJxZfqiWWPEphdn00Icf8fSGiL5hLAULOJ3aWO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZ5cJXC3oiicRzSPCpDgMOENQGDbks/jXvPZ0NjNzXbK2rs8QBlW49JG0MVnlOUFPA8AI7pzAuQ0h2AKhw564Wyq9tzqwRzs8ptpoMg5zLvAhydwPHzyAm8x3WTuysKNk0j2TyMhMPLu/IlfArS5i7bOWPSDQfCyfP/kICD+hhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o4luj5Nv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC88C4CEE2;
	Tue, 18 Feb 2025 15:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739892013;
	bh=ln1PUJxZfqiWWPEphdn00Icf8fSGiL5hLAULOJ3aWO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o4luj5NvZXqiXHT78YP8V8CXthB38tVniOHw5mLx+V6sqjj0H64uLyea8ItrjPpRd
	 2/OI5Cbn0mVq3eaFDT8Xz1VVQDxNRUNKqiWr6v4nI/dYjrWXIgz+fruJku09HppmNJ
	 bOsAjcXLNbLh+TvisHm3nWF3jGB8m5t12Bv/eUX5HAJ36NZySaFKlApDhghixyWepI
	 qtJIxB/Pi0oX/g+kyjZY9YkZNRyw/+ZndcZ84KqPUxy8/t+JV0mrGwUB3ClgtVaz4H
	 eoXCRDhDDxL8k+dzD7hNkLaA4AtOe+eZwtKCH8WKqma4pXk0BzpOB6w5C3U4IkdhLE
	 tLtKdlKq+P7hQ==
Date: Tue, 18 Feb 2025 15:20:09 +0000
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
Subject: Re: [PATCH v2 10/29] ASoC: tas2764: Configure zeroing of SDOUT slots
Message-ID: <Z7SlKbFTcqHCFvt9@finisterre.sirena.org.uk>
References: <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
 <20250218-apple-codec-changes-v2-10-932760fd7e07@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7v2juY1QzUckC6Ui"
Content-Disposition: inline
In-Reply-To: <20250218-apple-codec-changes-v2-10-932760fd7e07@gmail.com>
X-Cookie: Editing is a rewording activity.


--7v2juY1QzUckC6Ui
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 06:35:44PM +1000, James Calligeros wrote:
> From: Martin Povi=C5=A1er <povik+lin@cutebit.org>
>=20
> The codec has an option to zero out certain TDM slots on its SDOUT
> output according to a preconfigured mask (otherwise the output is, for
> the duration of unused slots, in a Hi-Z state). Configure this feature
> based on a mask read from the devicetree.
>=20
> Reviewed-by: Neal Gompa <neal@gompa.dev>
> Signed-off-by: Martin Povi=C5=A1er <povik+lin@cutebit.org>
> Signed-off-by: James Calligeros <jcalligeros99@gmail.com>

This adds a DT property so needs a corresponding binding update.  It'd
be good to note why it's a binding rather than a function usable by
machine drivers too.

--7v2juY1QzUckC6Ui
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme0pSgACgkQJNaLcl1U
h9BDzgf9EI+ZXeyYCjHTs2fqgyON5ovkrp33WLwLsc4YnW8j41iRg0VFVM74gGEX
jzKH842F4f5bpFqkz69j/RUlUsCDEFYN7QmM6c1Arra1PWpqoejPflRYGz2RflrP
+AHw+D3EYUcrzxHV490Rwh10jC7qWZ5vY4h1VuuyM3UpSWzK3P6+ZZ1h/dnCo3rq
X+jWJooNvZbiIWpYInmREYNMhxcjuelVbV+3xzpivmqnXQXtxAKrWEHoy8igA/y3
t4bMyu4y9xBsh3aERyqoE6esyxYSEI8/qHFzE5wtnzDwo2VFth5Apa3He+2qoWzJ
Xr5PfqnNSB7l+Mxpv9Nj5rutFDvfcA==
=5EEu
-----END PGP SIGNATURE-----

--7v2juY1QzUckC6Ui--

