Return-Path: <linux-kernel+bounces-519712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6931A3A0EE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D96047A220F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8B726B946;
	Tue, 18 Feb 2025 15:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJs+qgNS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC73F13DBA0;
	Tue, 18 Feb 2025 15:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739891897; cv=none; b=bPORkxVM7jo8LBmqriqln4QRmIDDt44TeuCsa4BuIvc8YVXnM6/WNLQKxsHQJoi/xFxznLXtbDzMO00dzE4JDKUd/zM15NGSwFw5cGzkZ2wvNOOEUdUZsS7QorIp7HFfNyS4T9I7rPGQ/4i9Agl2ln/ffeqmsarPJI+4lLcxswc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739891897; c=relaxed/simple;
	bh=WNiRmK4EogoQLQp8Y1WXGzt5lwEyX5i3uO+8yUl4hUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=trwrpL0hzzdCHWozUw+KyXETwfAA9a5ppZ2gg/DICTKgtmTeQhZcTKtITCkMWXymHPh89X0g29Gcc9GvM02/xn1Wz0R0WSKvlOpP/EKMvBzX899Mhm5zalL+z+K6JUu7rLC6jW6SQN+8oqX0eD1zBzE7p7d/xDvwYzAik2uPxcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJs+qgNS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58EB7C4CEE2;
	Tue, 18 Feb 2025 15:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739891897;
	bh=WNiRmK4EogoQLQp8Y1WXGzt5lwEyX5i3uO+8yUl4hUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lJs+qgNS5PeOgjGSKOdxxBdaTb6bVZ0+lbx2qyEtHIG6VZXx23wsx+oPZAxXjXLr0
	 KvtMaVs5IEU2miwHo8Ht/ExjNri4Fm8Gm4TEarJpSzSds2pRCBYDBzdH3op19mCcEQ
	 AyVZGoeE7No9o/znffewjb1nAJdjJn9JzhEbJxHAZw9EdmxHEoUEyVEfhWDGsI0tlx
	 6hKpgzeSmqfGFHQGjwBmjgD8v0mmk8Ig6+RjnLoOXCF/uBwOKih6nSl5zaQmEPiLnt
	 xEPfRXdlMN/ZtTVtiqPznIdhucSM42v+ziCetjFkxq8dipq75VFg8FoXBUqLuRMPyH
	 gBL70RhaLozCg==
Date: Tue, 18 Feb 2025 15:18:12 +0000
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
Subject: Re: [PATCH v2 09/29] ASoC: tas2764: Reinit cache on part reset
Message-ID: <Z7SktJ7Ajw1pmlSt@finisterre.sirena.org.uk>
References: <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
 <20250218-apple-codec-changes-v2-9-932760fd7e07@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="D5JGNK4VoKGS1UkQ"
Content-Disposition: inline
In-Reply-To: <20250218-apple-codec-changes-v2-9-932760fd7e07@gmail.com>
X-Cookie: Editing is a rewording activity.


--D5JGNK4VoKGS1UkQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 06:35:43PM +1000, James Calligeros wrote:
> From: Martin Povi=C5=A1er <povik+lin@cutebit.org>
>=20
> When the part is reset in component_probe, do not forget to reinit the
> regcache, otherwise the cache can get out of sync with the part's
> actual state. This fix is similar to commit 0a0342ede303
> ("ASoC: tas2770: Reinit regcache on reset") which concerned the
> tas2770 driver.

Fixes should go at the start of a series so they can be applied easily
without spurious dependencies.

--D5JGNK4VoKGS1UkQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme0pLQACgkQJNaLcl1U
h9ATvAf+KuTl4o2nwbZbzxU/IP0+CGJWK2DmINuZ1Co5/Cqrb7eiMdqDDeyzXHBG
bjSCOESirN9nH/Plqp9VWSkFwZXn5Vp3jr/lZJMR7ClxfmDBe0izzueM1Q7VXHj8
eeZNXVCquel7RCyS6X18C1fLiJKCP6otwqRF2X0Rka8iEsmtVxlU69r4fTL1xTzy
Hag4VL7xE/8Zr1AqgNAta6zOxyRDXO8nttZzMpIAjm/aPDSCXOMXQiNq2HwXy+hR
5t7djXbRU/mch/kni1iNotp1CuBoDjk+u1Waj920aN/MtUTzK4LaazGP8eFhvTr1
2178F4q/lMhI8WbYAR0DG8OgqkK+1g==
=DhgZ
-----END PGP SIGNATURE-----

--D5JGNK4VoKGS1UkQ--

