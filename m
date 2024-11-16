Return-Path: <linux-kernel+bounces-411757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAB79CFF3A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 15:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B0C8B25B24
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 14:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61AAFC12;
	Sat, 16 Nov 2024 14:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="LEgYeP0B"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91020944E
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 14:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731766600; cv=none; b=lYT6g6OtiszIioK6WdKyimD48IshMSaamH1nSk2nVMC3cf616xQe6epH4peNe/av3Gmxi0rHQ+LNVMNFV9r83DgYoGdwm+fxXRtWha2x3JFZwlB20V1Khv29jyGs0aYD6uBM+KIhsuULoU1AYN3guD1EnxtEo7c7vdEBt8eF08w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731766600; c=relaxed/simple;
	bh=EDqQFesJN34lNLxyGsRsUXIzZOr9GJSQxQNJwYkMA5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O0fUHCluja9/2ohrGnYdDrdfvRAcBwnQeYHQbPUw9EK/3PBxCfsNDAvjsIqpAv2j07Emhwa9IM0N1HtzuNu/anLBa6KKcet7NMnHtHQWZhGfA7xAPVCg5qmhcHGgJJo78HsPyLiojZPZJTX6psZRF4McppcNoDQZxPf1JnH1Zoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=LEgYeP0B; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53b13ea6b78so719511e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 06:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1731766597; x=1732371397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dp7h1fSu+Ng4BJcK+E3IUSI0yen9g6mTcXMg7WpXtUQ=;
        b=LEgYeP0BPxbtUccxE1nZoKME6ubDAZ76GxIMXjw4t98Y8jygwyXQ8LfPAEgkIQXx25
         9h7Z6Qos0nRBSuIMQFyfRQv68Iipk3ra3TknJRJVkiVdNEd3K+lAlXCUbcSzK34U+ny1
         IrnKELhUOU50amFSSnVJI8XkRYfe0mS/gsFfKrqvRaiX8HgWLcHOWEKS5td/lnO60818
         cWPgY4AjOKGxIZqF5PsqqUuxrPgZmSsPN3TdDP8/kzoQrsUQEd3uRfukQt2h2RKt5/tv
         BF00A3euVbbsN+y7DuYBYSxxKEUoK6xXW9CsYAEOGqdWbtRJFDgKwWO3UMm4yOjChen9
         NCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731766597; x=1732371397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dp7h1fSu+Ng4BJcK+E3IUSI0yen9g6mTcXMg7WpXtUQ=;
        b=X3uI8aKiFh85a1lRIwIMbA7wNolkaCeji3bsscEg0MtAMKSPiS1ODH7hm/qyFdgwVs
         UPqiXbftgqDegD8u2ANCSczDEHnTd6uWIKpuuPenzAGZ5iQO9HqcaNhmvQgYeBZlmPby
         xa7wnIpas4Km38bRu+Il38Gf+F1khTtck3n3ParQsHrklF0FCcr9/iDM3hpBsTISZUA1
         1fDOGQTOJn+39eu/r5bO6PbiJUTWTjJzv5yt97vqZ6j0/S99ndOHIC95J4y5fosi2UBM
         dKCgmxyCAZVNxSnLQmtzSeDAbFuD0FmLJSrL/518/bATY7hUUlby1xJJg3zriH6/8d97
         8+iQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+p+3sDoigjLNx83e3XE5WlGlpQ0oe9osNbszmudSF7PvSxy5b2FEWLUumFjk8EufOttsEnNf71WsSieY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQe+Rylg7i2QIvLKxfDaQciSJPxOBupRjWZvP/WD6VECDTrpc2
	kTNIF9RmJlMKMWvwcKh1zu7zoxR1crWjn881Aq5yRcY6GmmWyNKOj4TjMBOt4vnT5B1WdKS96kc
	YG/hDz8FMGtJSuKL5GVkLrgq7dJbdKJ4XkxHOeg==
X-Google-Smtp-Source: AGHT+IEmG3wuQGHNH0+RsM/AXkFymWtVLLWBzy4In/qD+OqgXD9KRZnheQ+iIYops3oQy0gOQnB5rxzVhZyKhRrR7Hk=
X-Received: by 2002:a05:6512:2315:b0:53d:a00d:e7c3 with SMTP id
 2adb3069b0e04-53dab3b9ecamr4340863e87.48.1731766596695; Sat, 16 Nov 2024
 06:16:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115123816.3906238-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20241115123816.3906238-1-andriy.shevchenko@linux.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sat, 16 Nov 2024 15:16:25 +0100
Message-ID: <CAMRc=Mff+1Yau2w2W3MvFVq4e=xBMnGqfOvBPfH9XjsbJWvBvg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: zevio: Add missed label initialisation
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 1:38=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Initialise the GPIO chip label correctly.
>

Same as altera - please improve the commit message by saying that this
was previously done by gpiolib-of.

Bart

> Fixes: cf8f4462e5fa ("gpio: zevio: drop of_gpio.h header")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpio-zevio.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpio/gpio-zevio.c b/drivers/gpio/gpio-zevio.c
> index 2de61337ad3b..d7230fd83f5d 100644
> --- a/drivers/gpio/gpio-zevio.c
> +++ b/drivers/gpio/gpio-zevio.c
> @@ -11,6 +11,7 @@
>  #include <linux/io.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>
> @@ -169,6 +170,7 @@ static const struct gpio_chip zevio_gpio_chip =3D {
>  /* Initialization */
>  static int zevio_gpio_probe(struct platform_device *pdev)
>  {
> +       struct device *dev =3D &pdev->dev;
>         struct zevio_gpio *controller;
>         int status, i;
>
> @@ -180,6 +182,10 @@ static int zevio_gpio_probe(struct platform_device *=
pdev)
>         controller->chip =3D zevio_gpio_chip;
>         controller->chip.parent =3D &pdev->dev;
>
> +       controller->chip.label =3D devm_kasprintf(dev, GFP_KERNEL, "%pfw"=
, dev_fwnode(dev));
> +       if (!controller->chip.label)
> +               return -ENOMEM;
> +
>         controller->regs =3D devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(controller->regs))
>                 return dev_err_probe(&pdev->dev, PTR_ERR(controller->regs=
),
> --
> 2.43.0.rc1.1336.g36b5255a03ac
>

