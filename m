Return-Path: <linux-kernel+bounces-345384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 119B998B59D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8529BB216E7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 07:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A26E1BD034;
	Tue,  1 Oct 2024 07:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="V0bVdl27"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756B11BC072
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 07:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727768043; cv=none; b=rDWwo+5pnhzehMwWYSsiAjxQF/LdG/njWC4xwmJXq3ZJoxU9I8gy473TzU7e99FGto0UJW4EG6XirzFOqw5iC5ugsCdO7tRPUV2rIrPjghiigBqlOA67ls+2yQSbhGEMqqw6pRDuGhjGHWNgwsjdlmhFubBV/tY+9/RWl4wej2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727768043; c=relaxed/simple;
	bh=Lu3lQOD70ISxi2MskQKKv1jotKIDB7GMWyk2Eawsh3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vzqwdf34+THlTWs/axrBFPTqxkbiVta8jiDYVcf41WUBQTwWyewlEHzdsQO9JHx/hlkTpeI+DMoAXXLFyZizvmBf6Ajo+5Yet0O0j1K0ShENz0H2nZRc/Sntpkp4L9OS/VcYYJEoVNBe3IQu7YRUoNquTYpd1XAllHxZaXwXHec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=V0bVdl27; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a93b2070e0cso625538266b.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 00:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727768040; x=1728372840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+uAo9PdDq3lMqJTciz90CVzfl+XSP+noJfFEU5CG5JE=;
        b=V0bVdl27Z/SQXgNern6fu4N5fktPiXO39xMQO3kZkpzwCfmhJSAx2OyERwlaWEeqJ4
         rivhFVYoMKHEHt4dn8gY++0+MiO8vfzGLJfsjjbZOzKJX/ilmdoIPgdK8ZaOHI0uF4F8
         QFihD6ZMvz+knTUFezlic/TPcr2BgtfSqXBXWnBmBFXVtnOt+yUNGA2SzATVIB+B16+h
         tuYgsmWYrc9LATj/4lPcgY690lSjw5TgGgk4VGfVT3owJvZVgUBD6xsBs7Wvp/Rj+fjv
         MOM8Gso6Az0l+yFU1FKgp/cL7XA/4f7CaW6seeMpHaAfjfe0b7UibLknQ1ii70yAzLc4
         Z/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727768040; x=1728372840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+uAo9PdDq3lMqJTciz90CVzfl+XSP+noJfFEU5CG5JE=;
        b=lTXy6jI2QCJ4+0Ex8yGAtRhZoLAEkNxNaS9t4YcyVXrfx//TpRgq0vluaHoO4Wd9KE
         CqpBOW1PVT6WxhQjdAc2y5KSrUZUmF9+T1SOhsC+RIAhcE6lPS+af4TlKxhJT7Dht69s
         JPcl4HTkmg/zL5gOl52ezdcPZlBrRy3szV6e26IHiGTpqm6lpgNprcdZqSgjWQM17R5k
         J6c+OhoLDzVZryCZEn3HPyPQmD3vNG0X0iaMkt3tnqIiVDnH7tXjDREeZW/N2jNvyjcY
         qmQZ/0+4PXHFxV0GFUp8WWoo6qmcInG19zrlWrhF/KeJ2cJlSCDIo8T7tAFoKZrozz3I
         tOXA==
X-Forwarded-Encrypted: i=1; AJvYcCU+btsiUCUJKg/skmU25Abz1ebHjD0Hoea3mId1JkBObABXtXTzeQIBqEmcspI5xXyjqJEOI2MBfHAvoaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiB/y+jqcZUWCmWd695+dCC86gGANebZnIkSKCTXClR+DH4i7h
	+LFwIHaCVtfwV/LC31s68MyAxiPFCQIg7aGxu4ytbUAnOz9z/Hp/iCZB6sZDhg8=
X-Google-Smtp-Source: AGHT+IHGJD2TDiukpf+j25hF1PEZ/MoKXUvZZuVW1Xi4qK3m0kbgdM7hCYKonAOLBp55EYMPxCFrWQ==
X-Received: by 2002:a17:906:fe04:b0:a8b:6ee7:ba29 with SMTP id a640c23a62f3a-a93c4ac9401mr1541437366b.44.1727768039653;
        Tue, 01 Oct 2024 00:33:59 -0700 (PDT)
Received: from localhost (p5dc68d3d.dip0.t-ipconnect.de. [93.198.141.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27c70d3sm656913366b.78.2024.10.01.00.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 00:33:59 -0700 (PDT)
Date: Tue, 1 Oct 2024 09:33:57 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 2/2] gpio: mvebu: use generic device properties
Message-ID: <u7o3fq6b2rlq6e6wwk3axxxpljx5u7o2mc35skg63houf3mhyn@h27t3uubopqo>
References: <20240930091111.32010-1-brgl@bgdev.pl>
 <20240930091111.32010-2-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ntmur5knp4oe5idh"
Content-Disposition: inline
In-Reply-To: <20240930091111.32010-2-brgl@bgdev.pl>


--ntmur5knp4oe5idh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Bart,

On Mon, Sep 30, 2024 at 11:11:11AM +0200, Bartosz Golaszewski wrote:
> diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> index 8cfd3a89c018..5ffb332e9849 100644
> --- a/drivers/gpio/gpio-mvebu.c
> +++ b/drivers/gpio/gpio-mvebu.c
> @@ -794,8 +794,8 @@ static int mvebu_pwm_probe(struct platform_device *pd=
ev,
>  	u32 set;
> =20
>  	if (mvchip->soc_variant =3D=3D MVEBU_GPIO_SOC_VARIANT_A8K) {
> -		int ret =3D of_property_read_u32(dev->of_node,
> -					       "marvell,pwm-offset", &offset);
> +		int ret =3D device_property_read_u32(dev, "marvell,pwm-offset",
> +						   &offset);
>  		if (ret < 0)
>  			return 0;
>  	} else {
> @@ -1106,7 +1106,7 @@ static int mvebu_gpio_probe_syscon(struct platform_=
device *pdev,
>  	if (IS_ERR(mvchip->regs))
>  		return PTR_ERR(mvchip->regs);
> =20
> -	if (of_property_read_u32(pdev->dev.of_node, "offset", &mvchip->offset))
> +	if (device_property_read_u32(&pdev->dev, "offset", &mvchip->offset))
>  		return -EINVAL;
> =20
>  	return 0;
> @@ -1147,7 +1147,7 @@ static int mvebu_gpio_probe(struct platform_device =
*pdev)
> =20
>  	platform_set_drvdata(pdev, mvchip);
> =20
> -	if (of_property_read_u32(pdev->dev.of_node, "ngpios", &ngpios)) {
> +	if (device_property_read_u32(&pdev->dev, "ngpios", &ngpios)) {
>  		dev_err(&pdev->dev, "Missing ngpios OF property\n");
>  		return -ENODEV;
>  	}

I didn't look closely, but I wonder if GPIO_MVEBU depending on OF_GPIO
can be softened with this change?!

Best regards
Uwe

--ntmur5knp4oe5idh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmb7pdsACgkQj4D7WH0S
/k433gf7BbbqBejVomJjj3n6Mj8VJzuv+ZDXLiu4czbBM5hYKS++9JHRQAkqKUMn
CGYEHd4qPGZ8n1jzvoiHzKs0v7XWgqRKVhk7MLdJwQbZj5k2eDCyVYU/OTgVl1ys
KsIFUQrqxM56nQx8BRR0roJtpGyDKty3VhEoOgqkJzf4LR9LlOSrCiX3sDPmtsWu
8zgMdyAbX5sTiTlo313XIlPu+6KqFwJz8+RStXznrnaN7re49fHzjU6/EFe5oUqb
nHJC71qS5jzIidursjG7EiggBrINZHFwOu3PfXiOR/wwnw2DjWXxlXClU6+gL72O
zSefpX4aOCaWXlIg944CgnUbiXyTXg==
=Py4Y
-----END PGP SIGNATURE-----

--ntmur5knp4oe5idh--

