Return-Path: <linux-kernel+bounces-519730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA9AA3A122
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A75F8188BA0C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0F926B978;
	Tue, 18 Feb 2025 15:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXUy3UKX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6527B26B959;
	Tue, 18 Feb 2025 15:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739892407; cv=none; b=Yv+qgHQxCyi+f2j6j8EfHAg793P5EYznv2QT/bSLiHSWSg4Z++aFAjCSdoRTTM4cguoUMkBaI5rnKhmhWOzpqR9mbOnyi/FQ0DnOfVvBWikhttO+Gv0ehCBYN0o9TViJ5k6XwV/8AdYcZ6rnbUAKHJbq4xc8O+P/u5VfNrcwWlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739892407; c=relaxed/simple;
	bh=LWSV7MB4eJu1tqu5Q170zpgZP/W+2kInVZagPTOniBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FD/cnzZWhDAmF1GvrNWx23/cyWm8mdfjn0nMk7FO+s9jCKE/mpiiSMNd6lGg7bWkUndzXdmWQZzHzeaV1yMnnUhTJetPvA8HpEjdZH5UCmw6hRhS/F3IbqDcCxEXwSeFFZwURaKjukW7WqeUqcKhWtlox5pgZ/1RAC8iWm0dUaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXUy3UKX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F6CC4CEE2;
	Tue, 18 Feb 2025 15:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739892406;
	bh=LWSV7MB4eJu1tqu5Q170zpgZP/W+2kInVZagPTOniBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pXUy3UKXHnjQgbV2FTzwjWkHaOCratj36yPVoENHIy7BjXIY7xIVhg704+QhmX6rT
	 8chBmY050QL8PUql17EXYYDOvVYSEotIaHqe5UYGe8qsOf1/NFR6cexizvp5gWSO9U
	 yKo4PsAVPx+jCdm2bRyZUsBCBl0n5aEHyf8WRBKJfFix0YqoEjicrtKW3LuQq2PcLr
	 w2xejyJXmm24BG5SwzBMtxnKutczF9/Bvs4DhjxrWY1CoH29fVfP0hDkZagErV2fxd
	 CQnyfNKMjX1/k0xdZQ2UI/XTL1Y5i2SC8v8uLjuqzlbGdEXRhp0VThgfCsyMQkUX8J
	 4GeRdtvhxaEEA==
Date: Tue, 18 Feb 2025 15:26:43 +0000
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
Subject: Re: [PATCH v2 18/29] ASoC: tas2764: Enable main IRQs
Message-ID: <Z7Sms4UNIlnXF4PO@finisterre.sirena.org.uk>
References: <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
 <20250218-apple-codec-changes-v2-18-932760fd7e07@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="O2C8HfUUYwxVhEqa"
Content-Disposition: inline
In-Reply-To: <20250218-apple-codec-changes-v2-18-932760fd7e07@gmail.com>
X-Cookie: Editing is a rewording activity.


--O2C8HfUUYwxVhEqa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 06:35:52PM +1000, James Calligeros wrote:
> From: Hector Martin <marcan@marcan.st>
>=20
> Reviewed-by: Neal Gompa <neal@gompa.dev>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: James Calligeros <jcalligeros99@gmail.com>

Changelogs please...

>  	if (tas2764->irq) {
> -		ret =3D snd_soc_component_write(tas2764->component, TAS2764_INT_MASK0,=
 0xff);
> +		ret =3D snd_soc_component_write(tas2764->component, TAS2764_INT_MASK0,=
 0x00);
>  		if (ret < 0)
>  			return ret;

Do we have handling for these interrupts already?

--O2C8HfUUYwxVhEqa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme0prIACgkQJNaLcl1U
h9C5kwf/X9/bi4tQifqyw5/dU9vsseyU71R+vXaTffMTXnzmsw1YLfalQtN9fGvy
BWhmJq+smVISlHZllomwmlJV4woiR/JU4rgODylTpjUHASuiWuqo3s0ClPvoDaIY
UW6uAn/qe6I8k+HwrfMU4IvaYFBBOdmVnVLH+9J4iIQ3hnY0xxaaSjxpPWq7u3CK
vgqeLvK8vfseHNnq4sLdMU0ZIrBV7Fg22jW9DG6l2er4Yl/BJJtdSAVttb9lAKHM
WQIqUb+8UpY88gyzoJNKzisolQB0pqdEuMhfaplF6t+4dJPqvHLEaaxvpbZ4L5TX
GAru/nQ91CR3us9+nQcBKQoXxpFd8w==
=1Fx7
-----END PGP SIGNATURE-----

--O2C8HfUUYwxVhEqa--

