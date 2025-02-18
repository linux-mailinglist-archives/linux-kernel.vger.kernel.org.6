Return-Path: <linux-kernel+bounces-519719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FC9A3A10A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A73583AC85A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D8526BD8F;
	Tue, 18 Feb 2025 15:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEFYOcMg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C62626B96C;
	Tue, 18 Feb 2025 15:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739892114; cv=none; b=XHV4RsiOYDvdgTk/U3txFcqRXFlB8lLq6uYpMfNxFOWGyGFPoLCw1NoO8Hr6VNvhWvpeoVSPc0OhPyiw4ofrCBYXaLr+q1cXydasuuETWzKWw5L9NCxL54lNZqtsaGLwLhbC0WpZj3PoLFoyov+E8pbNnrBXU2LhXu+QsObt5Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739892114; c=relaxed/simple;
	bh=1e91/4T4pLHM7/YrlYoghOCDAsiiKI99JxZ9OE0ImT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCXFmaD7QITRFjdAZ6bWn8a4+nY6Gxe2k4wvAmVrb1Svjh7/vtaaDRRmKgOpN0Am1x2mNza7P1yKwXU/mD25J+7oHLImVk9clQJZ2/3AjUfzSzy7xdOGiQFR4YP/RwjepV9+ZaAvuK3MKe6DB2HZzn5fz428VliwC0pdA93ZTv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEFYOcMg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55289C4CEE2;
	Tue, 18 Feb 2025 15:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739892114;
	bh=1e91/4T4pLHM7/YrlYoghOCDAsiiKI99JxZ9OE0ImT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oEFYOcMgHdSETCQfuCwiTOEQO7TON1XRCCxMuQLcO1Y8zgfu4r3fS6SrJMXI8GxYh
	 cMD94yvDSSqKsrDNHcph8pDvPiMIIEO34JDWLZLZlj1oqjhADvbEE5EqYQAS8t0qIQ
	 2knWi5wmYmkCBFCoUA+UF9ZJNcbC5ygf7IChXTrhtDL1apK8LikMnO6r04DNgm1ctL
	 R9XShi/rFZOiY7+3OX3rJkFX+3viOnYxpLGxm6URCxXwPVHmgX0BuUlaGTB4TYmXIl
	 p6/Pw+oz5fxSWwB8rNQJgru2CWykp4b7J3aP66FXnk6rav9lBCM8H75iJGSgfQ81u8
	 RNDbt3IqI97cw==
Date: Tue, 18 Feb 2025 15:21:50 +0000
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
Subject: Re: [PATCH v2 12/29] ASoC: tas2764: Raise regmap range maximum
Message-ID: <Z7SljtZYqDzsUbN1@finisterre.sirena.org.uk>
References: <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
 <20250218-apple-codec-changes-v2-12-932760fd7e07@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4wG70ouX0Ob+MHpP"
Content-Disposition: inline
In-Reply-To: <20250218-apple-codec-changes-v2-12-932760fd7e07@gmail.com>
X-Cookie: Editing is a rewording activity.


--4wG70ouX0Ob+MHpP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 06:35:46PM +1000, James Calligeros wrote:
> From: Martin Povi=C5=A1er <povik+lin@cutebit.org>
>=20
> Reviewed-by: Neal Gompa <neal@gompa.dev>
> Signed-off-by: Martin Povi=C5=A1er <povik+lin@cutebit.org>
> Signed-off-by: James Calligeros <jcalligeros99@gmail.com>

Because...?  At least some changelog would be nice - why are we doing
this, why does the new value make sense?

--4wG70ouX0Ob+MHpP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme0pY0ACgkQJNaLcl1U
h9ALkwf8CvfVKY0yAYKH/w5fgopumQXFZR1LuUZ5TioWg3gBTHN7/LtRSnB/FcMv
Puixl+umIeEJGyACae5KFclXRc8fOBSlDRJTnaxMbUSIgK4l9tzqqhciKqcLes7C
FAMGRNLEXkjYDnSrbTBm4QQcQvklYrP6sF0bgQLo1QmUQpjpzdn4OSudjotyTIre
e8krBytUN+0b7AqaiUrZMQ0vPO1NZUmPqWcIu9eNpV1dhcpr+KuWhg1r5YodHATI
tKqrk6eAYabW5GwVQT7U7hKpGkAsZ7jvULsGe83r/S3iE9uVBqyhVhoJkMiKR+RG
+gZEmeNleE0aiVtbtcGME2xS+zRiDQ==
=wHwz
-----END PGP SIGNATURE-----

--4wG70ouX0Ob+MHpP--

