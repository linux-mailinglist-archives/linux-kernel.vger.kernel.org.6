Return-Path: <linux-kernel+bounces-516867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F7EA37910
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 00:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78FFC16CCBE
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 23:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637AF19DF40;
	Sun, 16 Feb 2025 23:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dACoSNaX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA0D1A38E1;
	Sun, 16 Feb 2025 23:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739750303; cv=none; b=W/5CqSAdh98kIIuCIRK/jY4JxFNj2sOES/rjPgfWKmDxqcAfgoS6Kuy+jK80/i38WfSoPp53O1PV6Jl5dBAvzpJ/eIedQGcqsCQjdPRe3juISv+BPZNKXlgRi7jWgXAOhPRM0Kl5dytPOQN+8isVI3ri8GcCyMpwyXh8ckDFaFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739750303; c=relaxed/simple;
	bh=NW8y5IgtWJOIbWJ6+WKvwXaEUgAUvbyrTPPzLSFtQS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TqELcvAe+IlHs0evdgVwvRSzqs3B72yKL55P/hMJpM9V79hhTvFstwJubkN2N1O20WQK3RCorvJ9v5hLNQlUS8BByw4b+KqVvZgD499tGmogxMF4tv8N1CXoVv+fM705ealdnKYGxadhSBkKDFulYwb6xIMlVSDAAqsBUFCKaSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dACoSNaX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A8FC4CEDD;
	Sun, 16 Feb 2025 23:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739750303;
	bh=NW8y5IgtWJOIbWJ6+WKvwXaEUgAUvbyrTPPzLSFtQS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dACoSNaXP1tnUuY/1D08IkyLPK59GfyoqOQD6DeVVqPpjLKzHthmQDSB9H/CDk0wZ
	 tc20E5q8JdrlK9TnaftVkxprduiIo7ucittZOqYe0DGyvEBFmfZaDxcHwHrRyrLrk5
	 3WnkXIPnM7HRUAeOnQw+XRwmFDEj+G+lKkCHDpCqO3j0jowK4sQ6g+HRjbDxLQPseb
	 nIqtXgi/SMIV38+B5PUwRzW3xp6kASDJtG0qJOWfnIJevmYdrT4d46RIO395J9QJpw
	 rlxng0Wb0FSv4Ld0EQB1a4ah0s+5EWr2PEpalk9JEdXuS/uTi/tFFhKsPWfm2zikoT
	 Co2+Fp3qXMlDA==
Date: Sun, 16 Feb 2025 23:58:15 +0000
From: Mark Brown <broonie@kernel.org>
To: James Calligeros <jcalligeros99@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>,
	Dan Murphy <dmurphy@ti.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shi Fu <shifu0704@thundersoft.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
	Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	asahi@lists.linux.dev
Subject: Re: [PATCH 19/27] ASoC: tas2764: Fix power control mask
Message-ID: <4b665578-7da7-4a94-a4b8-bbb3196927a1@sirena.org.uk>
References: <20250215-apple-codec-changes-v1-0-723569b21b19@gmail.com>
 <20250215-apple-codec-changes-v1-19-723569b21b19@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3g2f+/Kxo5qlC/ux"
Content-Disposition: inline
In-Reply-To: <20250215-apple-codec-changes-v1-19-723569b21b19@gmail.com>
X-Cookie: This is a good time to punt work.


--3g2f+/Kxo5qlC/ux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 10:02:52AM +1000, James Calligeros wrote:
> From: Hector Martin <marcan@marcan.st>
>=20
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: James Calligeros <jcalligeros99@gmail.com>

Fixes should go at the start of the series so that they don't end up
with spurious dependencies on other non-fix patches.  I did pull some
random fixes out of the Asahi tree the other week which are in CI now,
I can't remember off hand if this was one of them.

--3g2f+/Kxo5qlC/ux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeye5YACgkQJNaLcl1U
h9CjEQf/YDoJJkwN67MI2NSsLjIamXB0d+897tBjYsBbH6UAa9IR9fyEXuzJ+XcR
MxG8DSp6/niCIUpdfz0JLlfVjjthp89L/Q2UOCxRaW3CUwA29BQtJTfFARZpsy4w
/IsJ+XWRhq98GZ2+lDGLWzJ+OX8A/9ea6k8B3chQZjw62qzf/9XDFVKKkt38ElQn
eL+wW1td6LTEtI6G3s54BzLvNUSfc8ddUGyPk+GF9QM+9wgUuPxXi+1jVYVZ/lSK
ZFX2HH8lyYX/aUYCxiU2ODtvKbhpsQlzmhTgSqmh28+ErRGDhmNZ2z8ROxGKyzRL
cmbHtlO4TM2jp3ktemvX7bCVLIZC1Q==
=1sjf
-----END PGP SIGNATURE-----

--3g2f+/Kxo5qlC/ux--

