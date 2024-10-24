Return-Path: <linux-kernel+bounces-380670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBC39AF460
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 23:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88E671F218CE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EBF21A71B;
	Thu, 24 Oct 2024 21:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="r1zlpjKK"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB84217330
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 21:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729804093; cv=none; b=FiLLjP3i6VNUPGgK3/JCG07L7jvrgBJAR1YwX0ijP4+TWSu4+0JatHPdqmmkumjl5fpq6faJiSUQnGmOg600fx0ac667VPton/U+MFMDvvNcQA7+OoUXjaCsaTSDu2dwmZ24suhMD9Z30c6AjqS+CsNZWJYYNxEFarfOmHWgc/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729804093; c=relaxed/simple;
	bh=qTvX4GUdkV9jrp2X28kXVCjyTn+6p9HoYruQkR5LkXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbjOouvBLWWrG473ZOrU8PA6SUtpZHGVnGIFCdcj8zpGNrpFLUTQ/mbXPXEv1pAdLVvD1dINjzTRVCs1e2HbumqTMBH54zJAGol6gzBeP/kwXf4ukro7JIUobC0QnjG3e4bo+kLfNvxkvZugpaPeKyXA7PSszpqemlYL+dzX4tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=r1zlpjKK; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43163667f0eso14081025e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729804088; x=1730408888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JXzfJ7cqlnASO1zqkCXSkoonsDfJDkVTL0G0jDOPo4U=;
        b=r1zlpjKKhtUbDGJ6HVoq+W+Dlpk9Deu4QRG2Md9++kTrvpu7ycVchA8hha+1vbXxyT
         LsZV0vdMZiL0wA0Mtw92pkWiNkCcerS+TfdgKHWlyllxdNTZrWNW3fGd1ERH+YZK6AeE
         0i24Ey5Cn3YK0sIE8tA10NnXOlD4/PirCaacEw1SLRJcPw31S7UoPSjINepNgsQidujv
         HqPIbDUAHZvu3prGEfMfwHtjlxbl4eBZu24/jx+djWAu5jBB2jI7ckCJfkGY/lEavrMN
         BBLXLU8wWLjSw/W1es6jAVa2/cye4joZD8aEMEcsj3rwt1eV+6TS/A1SD90VosusIUqx
         +BWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729804088; x=1730408888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXzfJ7cqlnASO1zqkCXSkoonsDfJDkVTL0G0jDOPo4U=;
        b=ZNHmzWHQjUHC/HWx8sPbGRawQCcW1OayCvQ89E+FlmFhj7dsQl8p5CcU+nrOQ3wXQm
         5yq2ms8XHdpvKS91vfaF/Nn0kgRgsTiMFt/UPAaHMBEUGKcGYvBkuJdUBKSsfX7EDc78
         kc4dwhAUjU69yYxCkewlOLw2PSkdN+1ucT+76WkX0V6UydIebv4cBeYJihb6RiXvdcgd
         4cOYFxJfR4WX2/454AaSJJLzse1Oe+X2DSTRQuAtmYP+FW2hXcSHwqOSI7rxyNt1rD7R
         gnWcmnHIRSphchr2zvNPunMphNEbfUhUWEbueRX3M90h3MiU4mw1ZPN6iEjPiZAev6Nk
         Z6EA==
X-Forwarded-Encrypted: i=1; AJvYcCV3TbmyTNJ3yYqh+GLWQ5JGV4QPu6xeKNG4mt3q1v9JYU29PpzYeK+geAxlfd11YBC03DTFwZ9NOLuT+2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YymbBA78OMwrYZQoARXgZu2pOP61O7bR8xUPh84LfcwVd61Dk3q
	D9Csqevnx+F2/NHNaEIZ/kWyTP1+nyjbn21sjU43yjzZSOviXHtX9k9soQa6DVM=
X-Google-Smtp-Source: AGHT+IFPD1/8m7Hsha9KdxajU1P1rbyaitEfowedegYL3ikz3BOnud7i8xwSlMTzFILBgSYBentRcg==
X-Received: by 2002:a05:600c:4e8e:b0:426:64a2:5362 with SMTP id 5b1f17b1804b1-431841fd6b6mr59065025e9.8.1729804088119;
        Thu, 24 Oct 2024 14:08:08 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:b203:5494:7e5a:8c7b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b56facasm28351265e9.33.2024.10.24.14.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 14:08:07 -0700 (PDT)
Date: Thu, 24 Oct 2024 23:08:05 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Mehdi Djait <mehdi.djait@bootlin.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] drm/sharp-memory: Fix some checks in
 sharp_memory_probe()
Message-ID: <hojly7qagyszxbgonzqmuuxucdfqwovrjyiktdxpibku6yodum@n7algnce2tts>
References: <0d307349-c141-49ee-8b34-67caf5f8b638@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3hjnzdxx2pfoo4ij"
Content-Disposition: inline
In-Reply-To: <0d307349-c141-49ee-8b34-67caf5f8b638@stanley.mountain>


--3hjnzdxx2pfoo4ij
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH next] drm/sharp-memory: Fix some checks in
 sharp_memory_probe()
MIME-Version: 1.0

On Wed, Oct 23, 2024 at 11:30:31AM +0300, Dan Carpenter wrote:
> The devm_drm_dev_alloc() function returns error pointers, it never
> returns NULL.  Change that check to IS_ERR().
>=20
> The devm_gpiod_get_optional() function returns a mix of error pointers
> if there is an error, or NULL if there is no GPIO assigned.  Add a check
> for error pointers.
>=20
> Fixes: b8f9f21716fe ("drm/tiny: Add driver for Sharp Memory LCD")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/gpu/drm/tiny/sharp-memory.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/tiny/sharp-memory.c b/drivers/gpu/drm/tiny/s=
harp-memory.c
> index 2d2315bd6aef..1bcdd79166a4 100644
> --- a/drivers/gpu/drm/tiny/sharp-memory.c
> +++ b/drivers/gpu/drm/tiny/sharp-memory.c
> @@ -543,8 +543,8 @@ static int sharp_memory_probe(struct spi_device *spi)
> =20
>  	smd =3D devm_drm_dev_alloc(dev, &sharp_memory_drm_driver,
>  				 struct sharp_memory_device, drm);
> -	if (!smd)
> -		return -ENOMEM;
> +	if (IS_ERR(smd))
> +		return PTR_ERR(smd);
> =20
>  	spi_set_drvdata(spi, smd);
> =20
> @@ -555,6 +555,8 @@ static int sharp_memory_probe(struct spi_device *spi)
>  		return dev_err_probe(dev, ret, "Failed to initialize drm config\n");
> =20
>  	smd->enable_gpio =3D devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_H=
IGH);
> +	if (IS_ERR(smd->enable_gpio))
> +		return PTR_ERR(smd->enable_gpio);
>  	if (!smd->enable_gpio)
>  		dev_warn(dev, "Enable gpio not defined\n");

Use dev_err_probe() instead of plain returns?

Best regards
Uwe

--3hjnzdxx2pfoo4ij
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcatzIACgkQj4D7WH0S
/k7sjQf9HxKcouACQt7j/TiWaHv1n9Dw59KVCBvbJ3GvxCTuBeRG+1KI9cKTeumE
Rm91JB1wya0l0o1QaaYbTq80gBNLIQ+tyVtdhtDh4jJ4gIvtjx6UavyWogj7UQvf
prverPw2PSS6EMPpeqbJhRFPSsi9Hq6ihXSrm13E5OADjQL3hAof/rDGhCLvf+PH
9tyFiOFdoQW7WuZHgQ2I+XWj6U/kSPquAA/D6Uf6PlYDEAyUvPcRvC4dMD7GpZ2K
Y3OxXMcnTSopDGovPgTpiFR9RySYF1+3A5kqz2EFqnytZVZ7+GmsWctY4ZB8F67i
bL1/7QVqC49NKvRGbl/jE5DHw0/cDA==
=dMac
-----END PGP SIGNATURE-----

--3hjnzdxx2pfoo4ij--

