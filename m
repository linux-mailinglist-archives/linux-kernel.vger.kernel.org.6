Return-Path: <linux-kernel+bounces-380113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F31BB9AE919
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DBA41C21FE3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DA21E3765;
	Thu, 24 Oct 2024 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTa5I9R+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF0C1E5735;
	Thu, 24 Oct 2024 14:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780831; cv=none; b=rOBoJBnudzbYPNhHQJGh3cgiTfiOrHkIa+Cmr23p5BfLFO3C10eGpv8pYvnMCFTSTEKImBXVVzw2nMbVn1Q5Z1nwetBi+8/aP1Bh5/E3Lb4Yb/JGlZROofdb4kzKECBi+xKo0oS+pT+YI1n9e3pSHdB4DK/G73NWU1XZksfP64w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780831; c=relaxed/simple;
	bh=PLdPNWEGAxUx7bs29I+xXhoPOoEWXEpUgtcBm+uEJq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPVLeUHFPykKVtn2+AYQNkJXe8RnUS18vc/hEuMluTy8KOF40UIFmzigHK5MGTLS/EqHefRrQLdqsWzjYgeQ/z1XHPQgxQTAbo0R5llWnV7zKLhFy5QB2ms1o70Pm7z9J+8C5n5iy2HPjjqVc11dr4P+4R52uQOn/4d4edEXOkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTa5I9R+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80094C4CEC7;
	Thu, 24 Oct 2024 14:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729780831;
	bh=PLdPNWEGAxUx7bs29I+xXhoPOoEWXEpUgtcBm+uEJq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oTa5I9R+zDvC61UZ/jQMxvUG/O2HJqLMjvYPNxvWoWZRvvUWKA+82QBebsQE4uVWI
	 cPQIsEMF2VEIUjP6vYa6m8QRoSxuqSBBv2zbcYgnKtouSQoHvYzTpJ05nF1lUt/Rr4
	 3oucgT721Ii9Q7Q/C2N7aUFOC7OsXN0MT9uGr9r2HzSYq62Y6ZTdoKQ4BznXZzJzQL
	 4/OgXqYKXftwcyU3F68cLHDuUmaCJgulC0slRXttv88DVD35DHA1rjQTUupm/zeZPW
	 rxVjJJ3R+Rh1IZtk08zn6WYA/gzf4cOfeivuNFzTPr06y9nd1a3LUNt+GO5XRMzZpl
	 kMy+7rETutDsw==
Date: Thu, 24 Oct 2024 16:40:28 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Javier Martinez Canillas <javierm@redhat.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, Dom Cobley <popcornmix@gmail.com>
Subject: Re: [PATCH 31/37] clk: bcm: rpi: Allow cpufreq driver to also adjust
 gpu clocks
Message-ID: <20241024-intelligent-proficient-python-720a0c@houat>
References: <20241023-drm-vc4-2712-support-v1-0-1cc2d5594907@raspberrypi.com>
 <20241023-drm-vc4-2712-support-v1-31-1cc2d5594907@raspberrypi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="osg67ubcsv3cmq32"
Content-Disposition: inline
In-Reply-To: <20241023-drm-vc4-2712-support-v1-31-1cc2d5594907@raspberrypi.com>


--osg67ubcsv3cmq32
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 31/37] clk: bcm: rpi: Allow cpufreq driver to also adjust
 gpu clocks
MIME-Version: 1.0

On Wed, Oct 23, 2024 at 05:50:28PM +0100, Dave Stevenson wrote:
> From: Dom Cobley <popcornmix@gmail.com>
>=20
> For performance/power it is beneficial to adjust gpu clocks with arm cloc=
k.
> This is how the downstream cpufreq driver works
>=20
> Signed-off-by: Dom Cobley <popcornmix@gmail.com>
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> ---
>  drivers/clk/bcm/clk-raspberrypi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-rasp=
berrypi.c
> index 6d5ee1cddded..274176a938c6 100644
> --- a/drivers/clk/bcm/clk-raspberrypi.c
> +++ b/drivers/clk/bcm/clk-raspberrypi.c
> @@ -156,7 +156,7 @@ static int raspberrypi_clock_property(struct rpi_firm=
ware *firmware,
>  	struct raspberrypi_firmware_prop msg =3D {
>  		.id =3D cpu_to_le32(data->id),
>  		.val =3D cpu_to_le32(*val),
> -		.disable_turbo =3D cpu_to_le32(1),
> +		.disable_turbo =3D cpu_to_le32(0),

I guess we can simply remove that line?

Maxime

--osg67ubcsv3cmq32
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZxpcVwAKCRAnX84Zoj2+
dhWuAYD5PMJD9prMYHyBdObDqF92o81SwNrQ04NtnD5jG5jYeEpmA3MzmyqCAh/o
7YBXa68BgIzZ4yp54frmW6KMod1/8J/vZSTgQD/IZkrDqafE7+wZ06WmivkbUo6B
zfJw7nahEg==
=mmzK
-----END PGP SIGNATURE-----

--osg67ubcsv3cmq32--

