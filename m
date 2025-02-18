Return-Path: <linux-kernel+bounces-519750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D406A3A165
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6958B3AD8F1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C5A26D5A5;
	Tue, 18 Feb 2025 15:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3ni8SRf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AC01990C7;
	Tue, 18 Feb 2025 15:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739892907; cv=none; b=u6ZGeh9IUrIIBMnFg2FVhlv5E1nzrL9iHQGT3kp4e9J+5BSCDS/z7GBzidAr2tQJLKMdgOBaBKaIrByBumQ8456+nuLqQKe1PLbQ8SkHfdrUV4fi6cjq9oRGc2dDZad8kfTACbWjOaMEkq+VMEzw3tRYVE/RdDSuVa3hGkSb600=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739892907; c=relaxed/simple;
	bh=xG4cICiE98lRJZYn34MUYDdZqiy1OLzJL6O9uz4mrTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANEWdmWm48Plci5hnGar5e5XoKl3W8ngzkvTXRi1FdmGbUrqV7xhEpXXpmdO8NQYhP2pVvPF4iG7mnYGpC+ScB4g7vCCTztIbXI9r/ydPCqVBhhiEKSpSF2n/0ak4s+KXRj8F/lBDLHbacWS6SRSikVnxTF4tf09Yfidp+cy5gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3ni8SRf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F7EC4CEE2;
	Tue, 18 Feb 2025 15:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739892906;
	bh=xG4cICiE98lRJZYn34MUYDdZqiy1OLzJL6O9uz4mrTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h3ni8SRfCZanQq2OCYohP6jeCZGqeIzhPlJFYOoVYhxLfdxRgRORFwtqoCQlV7ziG
	 wBDLimSOMcn0tPIjxg/Jd3/1aQvo3OPI6VNOuaGxSL9Vr10TTiHeultntgnZwFTa4z
	 i4R7b1kOqK0YOpc6RCxeVaven2reJEUnFieS9M0gy0FaZGJ/YSY5RXwhUoc35WXWxm
	 uavLpeJkNMLuFS1II3s/L4pXLeE2g7NRFoWam90Xt8o7r94Uo3lOBWF8DmQwwAwiSt
	 qwq2tuMTKOmmmGzl66FgDHlPb/4Ui1DdQoF/5oxemLD//V/PliD6AzEQ9Ymfn7YHt/
	 QJiW7fA7vHN7A==
Date: Tue, 18 Feb 2025 15:35:02 +0000
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
Subject: Re: [PATCH v2 21/29] ASoC: tas2764: Add reg defaults for
 TAS2764_INT_CLK_CFG
Message-ID: <Z7Sopr2V6CzL9eVi@finisterre.sirena.org.uk>
References: <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
 <20250218-apple-codec-changes-v2-21-932760fd7e07@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V9/MPtnfPTWJuqHi"
Content-Disposition: inline
In-Reply-To: <20250218-apple-codec-changes-v2-21-932760fd7e07@gmail.com>
X-Cookie: Editing is a rewording activity.


--V9/MPtnfPTWJuqHi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 06:35:55PM +1000, James Calligeros wrote:
> From: Hector Martin <marcan@marcan.st>
>=20
> Reviewed-by: Neal Gompa <neal@gompa.dev>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: James Calligeros <jcalligeros99@gmail.com>

This is now upstream already, as are another couple of these patches.
If nothing else please base your submissions on current code to avoid
spurious conflicts.

--V9/MPtnfPTWJuqHi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme0qKYACgkQJNaLcl1U
h9A9iQf/WzzFguT3AEkECdXsmlm1cLHB1ASjmxzy7a7RyqWGQCjkplsneb0L+NKj
/rP9bendh+6EzPmADrBRzB7OjzUaOa+cpBXQX9pEqZg3p2sRC+WCKy1rtH5pf7R0
3yRL7h3P+dGaPf8R08SQ32iG8IT2d+M+ly7S5sAegrRf4VOubywTTXWRAYuETEQ+
YMMEEAhmaleOaAmtJQVAfRBvd0/xj1qr6e+j4sslu83kmFdpycfb8bIe80Zr0WJ5
ky2oNf32te0ps+Tc8Zf3Ya3gu+Ny4LF+cglv5FBUwEnNOR2vtFPjCF+f2IsOd9IO
u7SfIAQgTal6r5LdVylz6825na8LUQ==
=ma9b
-----END PGP SIGNATURE-----

--V9/MPtnfPTWJuqHi--

