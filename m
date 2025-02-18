Return-Path: <linux-kernel+bounces-519728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2004CA3A11B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87AEA188B91C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E68626B96B;
	Tue, 18 Feb 2025 15:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+e4pJrd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9DC26B09B;
	Tue, 18 Feb 2025 15:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739892342; cv=none; b=G/03vPsww4unhOnll4raTFU/LUg5HD5szGSIB9UsfRlp1lm8y8eCQ2UL1zEfUEsode+Hr5BJm4APNseWpC04B6QQGzGlCGQxwfEChD9AeSy8RKS9QHJlveMyK4sQ5zuiut5VepvdotJs/sNMAnGNbSkiXp0HEf0ViXMDc6TR21k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739892342; c=relaxed/simple;
	bh=/PVR7lTm2rCtdnzLAbpvkucX6X5lhta8Uki8XlmijWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ir5A6hMUBP2X8/OQPdlcuUVdT9/PMC0mRg8NgUP7okZ5pe7naz9AuKCTFGRJ54OcLRxwubo3RknAJ195PMdHVQBNJreZ69enEjc7IEFOPTOy92wYxX7XoTTYB4lPVihSngIdZTnrrv7Km//vInirfeyse2ztRge0L8y+K7IQlNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+e4pJrd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D9CC4CEE2;
	Tue, 18 Feb 2025 15:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739892341;
	bh=/PVR7lTm2rCtdnzLAbpvkucX6X5lhta8Uki8XlmijWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T+e4pJrdnfZllE/W7mPFZ38fk6AJ0kPonXn7dGhEcdKamJH7CGhT1jyt2BHExkpn+
	 YKGefwXUur4GJI3SmqKxTDnRmXy0reg0w2ySpTcE52Eq1u0yU9lbEYPsHM3SDjgZks
	 QPzu0qVHDoqSSLo/eyN6r/4FrWaErqOIpEp6w9FLSTDxM+U0gAZuraaZAoqMXDOPNx
	 TldPTRBHikebxqKL7OS5aOX9AAzwGfkthoUMnzJC/vS6x5imG83WYTavF3hSfaIGml
	 3ZHNtTZsnmpuei4ZJlAY4wJly934D0baG9RuSucr6Cgic3J8LKc/nIqFzaxlFPjiCq
	 /4TfiDxfpbQXA==
Date: Tue, 18 Feb 2025 15:25:37 +0000
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
Subject: Re: [PATCH v2 17/29] ASoC: tas2764: Crop SDOUT zero-out mask based
 on BCLK ratio
Message-ID: <Z7SmcfaGQpGG81Pw@finisterre.sirena.org.uk>
References: <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
 <20250218-apple-codec-changes-v2-17-932760fd7e07@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FnjQ69qDhYsOpOBW"
Content-Disposition: inline
In-Reply-To: <20250218-apple-codec-changes-v2-17-932760fd7e07@gmail.com>
X-Cookie: Editing is a rewording activity.


--FnjQ69qDhYsOpOBW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 06:35:51PM +1000, James Calligeros wrote:
> From: Martin Povi=C5=A1er <povik+lin@cutebit.org>
>=20
> Reviewed-by: Neal Gompa <neal@gompa.dev>
> Signed-off-by: Martin Povi=C5=A1er <povik+lin@cutebit.org>
> Signed-off-by: James Calligeros <jcalligeros99@gmail.com>

Again, why do this?  Is this a bug fix of some kind (ie, does the
hardware misbehave if we get this wrong) or is it just for neatness?

--FnjQ69qDhYsOpOBW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme0pnAACgkQJNaLcl1U
h9ABMgf/bqg1mJwUXaQ6K+vLz+U0KeDMxix1PMazVlDjR1N6jYBaTY4shZuES1Lt
6kDs4KHQBqXwUMpc9YvyU46lw5oeWFQPWlOQvc8qw8pK6ugWPB7i+yLzgAGe3Z1e
cdbtHvf9vlC6zsY1bd9JmN9x67T/J0JEsQieVQPb/2zPsjA9+TM2dEuIpcQ8YZWj
yokQDbgk4I1SP+1aLSNkSsU18ujt1ktwKiYSf9KLQPfHvSO5JOg0h8f6FZsLCw0c
JB2uYWFXv5bzJTkuiZOQPGdczIkvEvcIFusDOxNqLBJkjnSNdcXxVhAf5UrPiCiN
VGmr6a4FkieEuGMzXY4T+YbmT23agA==
=0ji4
-----END PGP SIGNATURE-----

--FnjQ69qDhYsOpOBW--

