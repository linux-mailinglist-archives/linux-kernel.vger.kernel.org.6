Return-Path: <linux-kernel+bounces-245284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EC892B0AD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 08:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94CED1C216D9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 06:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59ABC13D8A3;
	Tue,  9 Jul 2024 06:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2my5hOVu"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC9C13213A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 06:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720507983; cv=none; b=ltJGNXsLhvOhtLx8a40WD6EdU4x8jtsAOKVujx/o9GN9JCUH6QqJf8uq/+QpfaTCO1aQQkxz/2VUJx7u6P/knKHP7mhhdC4pQ53WQHsv7E5YU7rUMK6XZU6FMaIATpDRXEBXcbtW7ctxFjcP4m/1NW6Q0HnEXyZZBZcCVrvfzF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720507983; c=relaxed/simple;
	bh=Oo/ifZl9VysOblFKxIKXILDSQRq7huKzpeurEjX/2Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISXNiKdkxqwd/+qjRIaAUjEBh8ax//WC5/U8yt9Uk6aqgG/L/SXYu/VuXj8TfJdYUGrHXXWCeF5+Qc5gQFVb+CkX2uC1YY7GLnP4H8FOz8km83ajTZdTL/eh7WZEHXGL12pDUrdf2otgm/esJW5kKBeV8ckEAr29/TNgzUpih20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2my5hOVu; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-58bac81f419so6236847a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 23:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720507977; x=1721112777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H+FqXIOW4eq0FTjKoPxaWl8FH4GGF28lavLviPGVW9M=;
        b=2my5hOVu5DalFVbZ0S+XIbiRk5earlEbNZpGE6wYFfjOMRarAhDOCTxeOnan4nfUsD
         EzCwP//sF4riOGoJa/17IaWicfev5fDjoVCwJq3Fj4vJlNR9FhnxxNkRkVWk7aOpI3uL
         qLYcls0+GN7bwiRuIe+P3vixXCmuk+bZDz3BONNV544XnfMC8D8P5czuTR1wboAj9qcq
         TVW4pwjOcIrRrYTJfUva+jfxqB1W7ZEiUl3Vq+rOtEFItQa/T6dM0qMEbMqk6w952fOS
         C03lY3mvXEyfxomkUmmHA+J64Ry4clTVOFYrYzl79vmsHSo5buvEdWkr9Y3HJ4luc5R+
         NsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720507977; x=1721112777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+FqXIOW4eq0FTjKoPxaWl8FH4GGF28lavLviPGVW9M=;
        b=IfyiyYrA7dLTyRBMP2kiQc0htp4gMH/qRMRUFfpM7RZDxiEvXRHO9EWbDijhVyKyvc
         HaH1xcyI5nQaslo011gq7st1URS7vloYP4tH6lF+ycw7fHNHci17d4CE27X3ue4tvQPT
         HQ+/BMXthWA8+QaPgLnr+gBRmUQHx8VIe8P0uFF76lAlRzLLHzR3Ntk0oufkWgLDaLYb
         Fo59uKLWMWL0ZP7Wc6QMMYHkBU4tNXz2dH01b+zJMhaQWukMhwhmEN7yHotLdOB9XQlm
         LfZ4aH7waHJaAGOZGNsLLuj/WbVKu9/2EcBnhOyA4F/W6h+eLcrRZ3KXluYcaSsYj8mO
         HXHw==
X-Forwarded-Encrypted: i=1; AJvYcCUe8dJyupq0qjtfrhnVo2DjosxE693McFW8pj4oiQXFZb2mn+QssXNzp6qEtA1+7zeM+ai5/DTsW7FIgFkB+XEjEZEPt/aRSNC4U8DH
X-Gm-Message-State: AOJu0Yw5QjKZEV3z21HW3Ut1DAYrCQUoG0Auih/MUddeGLcS3Iad65z5
	L7r2uF6zmufFOKQDz9s9UslY3oa0GUrksTq9C8Ukuue6K0GC68Q9bhodW8924SI=
X-Google-Smtp-Source: AGHT+IFUGecas1XpDKtbncJ0sLgtHSviuD5HJjYVObKWBAsgUfB2PlnVGm+SI54Hx/zkQU4wRv7ywQ==
X-Received: by 2002:a17:906:3710:b0:a72:8a62:65e7 with SMTP id a640c23a62f3a-a780b87f063mr98360166b.57.1720507977107;
        Mon, 08 Jul 2024 23:52:57 -0700 (PDT)
Received: from localhost (p50915e7b.dip0.t-ipconnect.de. [80.145.94.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6e37c4sm52440266b.82.2024.07.08.23.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 23:52:56 -0700 (PDT)
Date: Tue, 9 Jul 2024 08:52:55 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Greg KH <greg@kroah.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	David Plowman <david.plowman@raspberrypi.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>, Naushir Patuck <naush@raspberrypi.com>, 
	Nick Hollinghurst <nick.hollinghurst@raspberrypi.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the driver-core tree
Message-ID: <r24ym3ydptp5n7ozsyqslgu7a22toxxgvnl562gnwyubmvb3p4@xy5qqsoxwwsw>
References: <20240709163715.3bcd6ab3@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="reie6nwaydlnyzqs"
Content-Disposition: inline
In-Reply-To: <20240709163715.3bcd6ab3@canb.auug.org.au>


--reie6nwaydlnyzqs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 09, 2024 at 04:37:15PM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> After merging the driver-core tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> drivers/media/platform/raspberrypi/pisp_be/pisp_be.c:1786:27: error: init=
ialization of 'void (*)(struct platform_device *)' from incompatible pointe=
r type 'int (*)(struct platform_device *)' [-Werror=3Dincompatible-pointer-=
types]
>  1786 |         .remove         =3D pispbe_remove,
>       |                           ^~~~~~~~~~~~~
> drivers/media/platform/raspberrypi/pisp_be/pisp_be.c:1786:27: note: (near=
 initialization for 'pispbe_pdrv.<anonymous>.remove')
> cc1: all warnings being treated as errors
>=20
> Caused by commit
>=20
>   0edb555a65d1 ("platform: Make platform_driver::remove() return void")
>=20
> interacting withc commit
>=20
>   12187bd5d4f8 ("media: raspberrypi: Add support for PiSP BE")
>=20
> from the vl4-dvb-next tree.
>=20
> I have applied the following fix up patch.
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 9 Jul 2024 16:03:05 +1000
> Subject: [PATCH] fix up for "platform: Make platform_driver::remove() ret=
urn void"
>=20
> interacting with commit
>=20
>   12187bd5d4f8 ("media: raspberrypi: Add support for PiSP BE")
>=20
> from the v4l-dvb-next tree.
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/media/platform/raspberrypi/pisp_be/pisp_be.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/media/platform/raspberrypi/pisp_be/pisp_be.c b/drive=
rs/media/platform/raspberrypi/pisp_be/pisp_be.c
> index e74df5b116dc..7596ae1f7de6 100644
> --- a/drivers/media/platform/raspberrypi/pisp_be/pisp_be.c
> +++ b/drivers/media/platform/raspberrypi/pisp_be/pisp_be.c
> @@ -1756,7 +1756,7 @@ static int pispbe_probe(struct platform_device *pde=
v)
>  	return ret;
>  }
> =20
> -static int pispbe_remove(struct platform_device *pdev)
> +static void pispbe_remove(struct platform_device *pdev)
>  {
>  	struct pispbe_dev *pispbe =3D platform_get_drvdata(pdev);
> =20
> @@ -1765,8 +1765,6 @@ static int pispbe_remove(struct platform_device *pd=
ev)
>  	pispbe_runtime_suspend(pispbe->dev);
>  	pm_runtime_dont_use_autosuspend(pispbe->dev);
>  	pm_runtime_disable(pispbe->dev);
> -
> -	return 0;
>  }
> =20
>  static const struct dev_pm_ops pispbe_pm_ops =3D {

Looks good, thanks.

Best regards
Uwe

--reie6nwaydlnyzqs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaM3kMACgkQj4D7WH0S
/k6shwf+PMzTT5wTN/1/HDZMOOdnDCPmn36sQXpqK36TWxd3JfEF8ojZJ6u5ZOCv
liS124z4iEBkRH6CHatwA69+n1MpZPfMb9sS8nxt3wZ4IVqak8LUI0pRJvOsTArx
4sWAboZoY7kvw8ei3XawNngN5CERlnoBfFeN66DoLYOvuuSONI642Ju1MOxC/8Qx
NHIdHfP3yTPTt3V7aR9rPJvmS/KWVS00TJULC5Dborh2FnH1A5qMNivm6cAbtliw
/upHOaCnknH45MNMeibyQb/G60KS0JIqj2iFlQDmFwnKMHn0oDw7/FUM+ovu2KJQ
/MYfm8xZWngbLqcRC0unTqCzIBkysA==
=JJXa
-----END PGP SIGNATURE-----

--reie6nwaydlnyzqs--

