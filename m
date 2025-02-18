Return-Path: <linux-kernel+bounces-519752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B5CA3A170
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70CAD16CA1C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2566426D5C0;
	Tue, 18 Feb 2025 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7gLZWau"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775D326AA94;
	Tue, 18 Feb 2025 15:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739893010; cv=none; b=XnBTaO4qpQf+w4mnPjSU6kF98wh9lu5cgapFBtZQR3PwPeoDu0/BWuKqQa43LnGDUhko8cy+pHGnD4UmnwSNRkyNyHK0JHYwftRxv6+6xiWfHqQPFfk/CG0b1sdnus9+FvZ2KDIsTVxgZLWYmJT67320oWqopGPyXn/rgztzxVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739893010; c=relaxed/simple;
	bh=XCzPqqxdiPdXilBJG/k8YxUGAOl+y9G9qdjAJWZl7Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgVTOqUSvRASDCHVphtWza8MBWkWB9w5a0yFW2Be3S/hBOUMlchZze4gKKLXXPdDRko8fsBuO1VxbmgVTOLBm/fdzsYjtfUOF5fiQpZFESfIlERNa6l+SVAhbaPyWlyYiaDeKjpNQ+fx2ooNAcyXBGw98cJF1+ic7hd30IUJ11k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7gLZWau; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D857C4CEE2;
	Tue, 18 Feb 2025 15:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739893009;
	bh=XCzPqqxdiPdXilBJG/k8YxUGAOl+y9G9qdjAJWZl7Xk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r7gLZWauPUP40FqklSs02U6VPX/03uXN2bwpx5u2UzkJ70lP0LKMG0byYHsN/oCkm
	 j75SQzdT12uMOoIAcPRCwUqhSJCoRq8c8UDwtxL7hiz0UcrqigobI405sAVDL5zaSV
	 K8QZ92XSUfOZrYvNl49+l8K3SDwFTW41iky3UqwSHumUWxOgJ6uY3S8RUrJR1bnDlC
	 2tHukX9fysGrpLDqeZ2Tw2qnLN6zxIdJYy/ZZfcivGAOcErhvbMJzDV8E84ig+dEDf
	 HPLOL1q8RsypYM2lUWL1itltTg8+f6Z4ShTfpcBJnm0Tnd1nScIBj1btrNZRXOPSJ+
	 SdWjkw4aM5U1w==
Date: Tue, 18 Feb 2025 15:36:46 +0000
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
Subject: Re: [PATCH v2 24/29] ASoC: tas2770: Add SDZ regulator
Message-ID: <Z7SpDjQnabi0dZ_N@finisterre.sirena.org.uk>
References: <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
 <20250218-apple-codec-changes-v2-24-932760fd7e07@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VbY9DRThDDOXpegf"
Content-Disposition: inline
In-Reply-To: <20250218-apple-codec-changes-v2-24-932760fd7e07@gmail.com>
X-Cookie: Editing is a rewording activity.


--VbY9DRThDDOXpegf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 06:35:58PM +1000, James Calligeros wrote:
> From: Hector Martin <marcan@marcan.st>
>=20
> Multiple amps can be connected to the same SDZ GPIO. Using raw GPIOs for
> this breaks, as there is no concept of refcounting/sharing. In order to
> model these platforms, introduce support for an SDZ "regulator". This
> allows us to represent the SDZ GPIO as a simple regulator-fixed, and
> then the regulator core takes care of refcounting so that all codecs are
> only powered down once all the driver instances are in the suspend
> state.

Same issue with the use of the regulator API winding up as ABI here as
with the earlier patch - I get why you're doing this pragmatically and
we should just have a general helper for refcounted GPIO enables.

--VbY9DRThDDOXpegf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme0qQ0ACgkQJNaLcl1U
h9CGCgf/fxWVZSLwHxh2udtDRheo1UlWDK/xCLvvIxJVLPGaQ0WRoMe3gGYDyvSQ
Qd2S04UxYP6hDsYeIveDM+dslc1MYTKxcMBsauqgrEAKAGlOx/ejwj7gf9I3gMfi
XxUcn7Avat8XX19uVotRpCv0U22+uN0jhDtSF9kkfxfPDnHqzXXoRjZ3ix3qFyem
GvEw9xgjlZxDrrMhuynmdCnh9vS8/Nca9nYO7o5layQTjtau560xdwUtnuaDhYlB
Aa+pcBKRfSoOyxQ6O7p5/P2q2fckkavwy3essd0t5ierc0glakHrKWucZ1c2r70t
liG43Umfen98YLYpt5U8eGDjcjEeDA==
=IH+p
-----END PGP SIGNATURE-----

--VbY9DRThDDOXpegf--

