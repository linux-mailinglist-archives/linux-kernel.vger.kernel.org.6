Return-Path: <linux-kernel+bounces-523251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF2EA3D449
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78C1F189AB5D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400B41EBFE0;
	Thu, 20 Feb 2025 09:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRxrbO/y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC7F1F19A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740042724; cv=none; b=AxfzEXCMPAWudYVOUpR53mLVI9rWpEoTnFEjPZY7ECSy+X/8bJxAB8PXhYPPVWx9w0l51fXA7+N3C+1FA3hMgQWhrEqpNY9aMwcku2SFl9DjDX/5MT6cuSBRsdvNoJ0gbSAN4CA9GOx4ptvtPVdt0Q6U5ygwwqM6ujU9v2Iysq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740042724; c=relaxed/simple;
	bh=A3SDf2fynHoAQU2pLneF7+2O7A42EN25IHRWN76gv3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGvOqifCAGjhbISqMa7arvPfgEDSZn6ub4imOWOK/1cwnXX7ahesqeyl9A59tGqH5MV+u7x3NUvu7SwfrACiq7+yaUI6Y/QBZ1fnK47XdOUwgoq5PXdhq8vyUYgB3pLJu86zRId9ii9KQDm+9pbtQquZtdR+RsJlFCVsgY5Ui80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRxrbO/y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBCCFC4CED1;
	Thu, 20 Feb 2025 09:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740042724;
	bh=A3SDf2fynHoAQU2pLneF7+2O7A42EN25IHRWN76gv3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sRxrbO/yU1blb438TmWhKaRp1IYoyRPQ2ufyeK3PbmBEZG9o7j8NeNuYubhuBQHVR
	 Gkd99dwVbV0Hh46/9zLBDfCJN12UJ2wiP9boodXNWAsflQpDrZJQhTDTYE7vBp81Zo
	 Unm8ywXVULgp83Re1xSiFPV6qOX16vUSwlsRX8+BVOuO6XXz1JyQ+3P0Cn/0uLTvyo
	 Rtfgont79qG74IqhnWzolZ81+za3Bt6mB8gcoRBzyayZz9VcUcKKqt6FPX3x/AHpAK
	 BeKIQCwYrD/khMKSkB2Q114/slCPt2Q62+AQS6XXJZwmW8KXzaJP+PANHfoU+noN2/
	 xCmX7+nnPdQQw==
Date: Thu, 20 Feb 2025 10:12:01 +0100
From: Maxime Ripard <mripard@kernel.org>
To: oushixiong1025@163.com
Cc: Liviu Dudau <liviu.dudau@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>
Subject: Re: [PATCH] drm/arm/komeda: Add a condition check before removing
 sysfs attribute
Message-ID: <20250220-tiny-pragmatic-pug-5addfc@houat>
References: <20250220085358.232883-1-oushixiong1025@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="nea7bbphka3uzfl4"
Content-Disposition: inline
In-Reply-To: <20250220085358.232883-1-oushixiong1025@163.com>


--nea7bbphka3uzfl4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/arm/komeda: Add a condition check before removing
 sysfs attribute
MIME-Version: 1.0

On Thu, Feb 20, 2025 at 04:53:58PM +0800, oushixiong1025@163.com wrote:
> From: Shixiong Ou <oushixiong@kylinos.cn>
>=20
> [WHY] If the call to sysfs_create_group() fails, there is
>       no need to call function sysfs_remove_group().
>=20
> [HOW] Add a condition check before removing sysfs attribute.
>=20
> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>

What are you trying to fix exactly? AFAIK, there's no code path that
calls komeda_dev_destroy() after komeda_dev_create() has failed.

Maxime

--nea7bbphka3uzfl4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ7bx3AAKCRAnX84Zoj2+
dpsVAX4n5ug+XXtkZ7/jJB6mvF79+3TNFV6iuKF8Q5Lwgo/medK445plllzmD/yx
zYttIVQBf3AtOn1ulefI/KDN0pfKXstNdRGFhg282mmQd24ZOcB9CetWOy1HO4RI
7ta9fQR11w==
=tf2W
-----END PGP SIGNATURE-----

--nea7bbphka3uzfl4--

