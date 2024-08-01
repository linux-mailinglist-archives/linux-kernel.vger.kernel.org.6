Return-Path: <linux-kernel+bounces-271005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A569944843
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 012531F2951E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AA0170A27;
	Thu,  1 Aug 2024 09:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="j/3GgWr8"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D123D97F
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 09:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722504390; cv=none; b=leWeIq6KqHPf2OsqWVwDfLGdeSHesJ0S6Wd0ZV+bGPlbgXbnxSm/L5UtI7ZXSTRvyf5WCsn5OYpyUahkSxbuSuocg/z4GvnMA3iBW2tRD5rWLmBFR8f0gwTHLRhWbL588TudieSwYrdtq+uUMo8hKh2QBPEOBA4GvM6yL7cd1sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722504390; c=relaxed/simple;
	bh=yc27dtpWweaXQh+fHjdx54N4dlVP+eR3XGm152K/xkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCj0hmoSfSbffkTbnc9DPhuJXEOxRj4TW73yTkyZ61p9lhD2PByGbOhDahjy1Tenofw5lSHo+W7ZyhlxVIGaA7I3m8+E8BJHJqNYPD5DQHGNuzm3aah+4qrtP0FPuiV7R+2++510sjebWmdIeSfVJgVuFB7U6jR2+TRXg9BmwmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=j/3GgWr8; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5b01af9b0c9so5782543a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 02:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722504385; x=1723109185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g3JZO8ZSFVuF+hnQnOqfsoJXypTyECUCeoc6zZyCuAc=;
        b=j/3GgWr8ZNAUE8EpJTkozRJd8HFKgi68oQXRCCf4BAXTUOyTPcLiwLzy9tw+fMkBk0
         eb1qy9VGNTVw3Pjy/iD+DgwZvH7v1InkIv79TqXNDM4DtJ3mxJa8KyyFPX/8oFr9+/Sp
         cBLlupdcu0EUBaqjZeDvYKb0b7JBkXW97I4XT0zRp930PjQ9OfKLaiUGiGoPSrcnF4V7
         qFUtwPyLtZaORRxESmXvstS38IhpKSfR2D4xhMtTKPTxkTBporWB7ksYYFQc6VftLoed
         uIr6ximBMJppnfBzRYIc0e1w9KpPXw4cG8IaTgsulyI4ZppkJyiHN+5eSahrZ6XdNjUR
         mB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722504385; x=1723109185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3JZO8ZSFVuF+hnQnOqfsoJXypTyECUCeoc6zZyCuAc=;
        b=JVqo5+SS/ytAXVyCHZzcuwbCk/EJFwGMIklGF1MP271hYgW7J1Baw6/AlKVDe+9M+X
         t01SsC20nS0sxL6jm83hKdTnGbVw1PtIueU09PlOAdV3utfZiwtVBWGSkoXA+pCCV0YJ
         GOPIa4BmVKilEtnO9HU9sTYcK3PnGkJYnww8LTKqXZ2yVT2ih5CLIZImQFx3wYh+1WyP
         NJxT1IlmNVqiyFVTFb9Y13MtKdIFIyFzFRpaBnr/WsjhGOu27eBcAMO99fVDYgwYwNQ9
         YuNJwJjmoVjG4EUBrtwq1cwOsSsoGX/Ys2Zk7YqcgOMnWwrGmZfTtaBjPg3d31OMsPOE
         k+xw==
X-Forwarded-Encrypted: i=1; AJvYcCV+uqHx+oVjvosGqJmSe/607N2Yvnn3qZnGH8dlv5su7288RTswm3+bjVWRRbAPLG1YtBRrelKi3goo3uprTeQTSZ6lXPDDoGRwNufk
X-Gm-Message-State: AOJu0YwGmi6NM4fqVyjSwLPnAaR75U98Mz8zNyAoz3lJX2QY7AqGfCZE
	ddaAcNddBgXZn7IxpkX/MZctzsond3ikqcXZAhUOdyPQcbxGf9b7eZBL23s78Oc=
X-Google-Smtp-Source: AGHT+IEVYXao/o41Djqdn17wcaP7RJtqK8n/QFbWtaCDyvUeQykgiFPJr+pTJuMhEJEC6R2BaL6qyg==
X-Received: by 2002:aa7:c74a:0:b0:58b:2d93:ad83 with SMTP id 4fb4d7f45d1cf-5b6ff2f48d9mr1187110a12.21.1722504384678;
        Thu, 01 Aug 2024 02:26:24 -0700 (PDT)
Received: from localhost ([193.196.194.3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac6377d005sm9821822a12.38.2024.08.01.02.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 02:26:24 -0700 (PDT)
Date: Thu, 1 Aug 2024 11:26:22 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: 
	Martin =?utf-8?Q?Kepplinger-Novakovi=C4=87?= <martin.kepplinger-novakovic@ginzinger.com>
Cc: lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, 
	linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: pwm_bl: print errno for probe errors
Message-ID: <fjke5js43aqxdxmoau2l275a26o52sq7hyjgzwxnnsrptqlcvs@mohkvblfqkhg>
References: <20240801091255.1410027-1-martin.kepplinger-novakovic@ginzinger.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o3qvcdtm3cmcqg2x"
Content-Disposition: inline
In-Reply-To: <20240801091255.1410027-1-martin.kepplinger-novakovic@ginzinger.com>


--o3qvcdtm3cmcqg2x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Martin,

On Thu, Aug 01, 2024 at 11:12:55AM +0200, Martin Kepplinger-Novakovi=C4=87 =
wrote:
> This makes debugging often easier.
>=20
> Signed-off-by: Martin Kepplinger-Novakovi=C4=87 <martin.kepplinger-novako=
vic@ginzinger.com>
> ---
>  drivers/video/backlight/pwm_bl.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/p=
wm_bl.c
> index f1005bd0c41e3..cc7e7af71891f 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -502,7 +502,8 @@ static int pwm_backlight_probe(struct platform_device=
 *pdev)
>  						  GPIOD_ASIS);
>  	if (IS_ERR(pb->enable_gpio)) {
>  		ret =3D dev_err_probe(&pdev->dev, PTR_ERR(pb->enable_gpio),
> -				    "failed to acquire enable GPIO\n");
> +				    "failed to acquire enable GPIO: %ld\n",
> +				    PTR_ERR(pb->enable_gpio));

AFAIK dev_err_probe already emits the error code passed as 2nd
parameter. So I wonder about this patch's benefit.

Best regards
Uwe

--o3qvcdtm3cmcqg2x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmarVLwACgkQj4D7WH0S
/k4/3QgAiFoRKzJukU86K6iZEdrgbKL22xCsLB7W/ia/eBkBsscxYJG42UY3+WR8
j2mf2vRqS3G80eP/KK04dxbGrlsAkM7HubO8KxMMS9CZKz7BwfTOyP93alHUhrZ1
TUdMfceaT+dSkyha+cbucRYgZDW1BEEP9R5vy9+9SSdMZc/CsLMWU92MMA26wcye
t3BbMMvP5CGsnvcoWd8oCk7rdaD2pnbdLEYsR9bVsEr/g6dQooRBPsOoBkX7a1Au
06peYq525VSe9CLNWUFziGB+A31LPaSMzgWu9bdyG/7nxiHhMEwNMdXXT3x4PZtd
ILzQY1JcBlYzwMSNG30jtTNb9exWQg==
=U2oR
-----END PGP SIGNATURE-----

--o3qvcdtm3cmcqg2x--

