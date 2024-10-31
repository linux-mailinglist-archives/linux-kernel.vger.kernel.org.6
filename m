Return-Path: <linux-kernel+bounces-390977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED549B80C9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 18:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5AF9B22015
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3161BD4E5;
	Thu, 31 Oct 2024 17:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Z4jMgQG2"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEC31990C7
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 17:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730394178; cv=none; b=kfkmJmObxcXI8idWfERtDva5inAQOhvJ68mGh4Qna99EVt3Qrd7pUHHdMhvNgREVfOCeV2WnLcMyc1T364JF4yLWJOqaDEz9DEw6H0EnWkxWnifJ4lmcTY4VcHgvafScdgwDQzF78KIeDyG1T/ZmKed9C6rkduDbkGj1oix6vlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730394178; c=relaxed/simple;
	bh=rkD19Bqc79gsPO5JVFTOqLgcccwuavxcVndttCcVjlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N/MEsu+qNV6QmtnI8uWmqQHWtCgnETrlsdDVWBADiOUTC/oyJSm5149SvKPNRWZDP3MF9ODW7YGcKw4GHJ5kcaTu+9+51kBqyyWijInkYfMH2QYMqe7enY9qE0G1HDxbOkMupNJ81tCS1jBczI8OLTsA0WkVwSkmkiSlkU6NSmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Z4jMgQG2; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539f58c68c5so2192710e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 10:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1730394175; x=1730998975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itclNzkuhsNhu+rLimeOXz9VP4f+jH+BEVTSGay6rCw=;
        b=Z4jMgQG22yeSNkBwV+gYoJ2j2ep0LXQMNzfTrLdGWKmj8a+HpKvCuPOEu74hahtPZC
         yvCsrFpvieMYs/dm8OdTlW7WLWhRayqM8hcMBLYwPyteZnKBBFKs1kOzwPOvmbg9Zv1o
         J3VeQ2TiNf7+Q0dVkmXESoODFZjeONZR5Qn9Q6Ao+RD+0A/QARduMBOdQDS0IZ8ifK91
         JaxyduackvfjcGbX9DWTWHJkNHzERp5TQCG5YaVztfqiDAlyA1krBxQGxlzW8EjIqbEg
         Hygc2TC4Fzw+2jbZ2+orotyviyL2tzEs0NHFb/9cgZwjQk4+vxNq3KFX7EeUxI+Q6l1m
         aolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730394175; x=1730998975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=itclNzkuhsNhu+rLimeOXz9VP4f+jH+BEVTSGay6rCw=;
        b=FgjnaoFdwdLlvhbOOktQdAtzi2Ks7QwekYnjAPdTeVQa89cS4xWZ6SVYBHDaUbIyXm
         4+6pagkZ0zaR5IEwc3gJVnXhd5wx6OMc3cAxuQshNCPYRFBZwHBgvDdCRu4dYb3LQZe/
         dYbHp4ol90lBluHRsZEdbMYW1qgVOREP0NYE/q30/hC0BNR0jFP70XRRnJLQbPUjIHkG
         IWO87oNg7AKv05tYotFpn85mN731MNADwolZRj2DFtOsZxfjgysT+SqXYwtATyMh9nP7
         xNJwp+5btzye4OgtfmxDf5sorn3xTx2OWYLpNqjQrl4sfL9p7YZaI9Z0th1w9/eWySVr
         gVbA==
X-Forwarded-Encrypted: i=1; AJvYcCX0chJCPj+VgtSbHeT8oLKT44VrfIZ8/CsU2sZD/In4x/umfroIqu7WA9YoDAM8/omghX7gzDqFCxoFgfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9eSX+w/5XALTiH0U5KE5ZQ8ae01FQ1oMh31YtnDdu5KjI6v4g
	8sNvcoK5xoSpmQPTx15LWdRxRlrfTikOy2LrZ/tCZFzUkr321wXxzHb2hwcYSy54OYjvb1X+8Sc
	B2Gz9ynZYcSs1vZPFpb98un8uLPMSDwr8EzIOrfZYiT2TnWl7kJI=
X-Google-Smtp-Source: AGHT+IFkGhs17fk1WNgW2Lc1+p4at0/K/jnNWJKMySLeyD5thsCli3RrFU2Jul/rDz+A9y3BBriis/mOAyCzaxsMr+U=
X-Received: by 2002:a05:6512:3a8b:b0:539:89a8:600f with SMTP id
 2adb3069b0e04-53d65de5298mr761196e87.23.1730394174627; Thu, 31 Oct 2024
 10:02:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028125000.24051-1-johan+linaro@kernel.org> <20241028125000.24051-3-johan+linaro@kernel.org>
In-Reply-To: <20241028125000.24051-3-johan+linaro@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 31 Oct 2024 18:02:43 +0100
Message-ID: <CAMRc=Mf6yaZMsF5x=vPet=y9fa5ZTuWSAA=oi+Qw07TF8GEFbA@mail.gmail.com>
Subject: Re: [PATCH 2/3] gpiolib: fix debugfs dangling chip separator
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 1:50=E2=80=AFPM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> Add the missing newline after entries for recently removed gpio chips
> so that the chip sections are separated by a newline as intended.
>
> Fixes: e348544f7994 ("gpio: protect the list of GPIO devices with SRCU")
> Cc: stable@vger.kernel.org      # 6.9
> Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/gpio/gpiolib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index e27488a90bc9..2b02655abb56 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -4971,7 +4971,7 @@ static int gpiolib_seq_show(struct seq_file *s, voi=
d *v)
>
>         gc =3D srcu_dereference(gdev->chip, &gdev->srcu);
>         if (!gc) {
> -               seq_printf(s, "%s%s: (dangling chip)",
> +               seq_printf(s, "%s%s: (dangling chip)\n",
>                            priv->newline ? "\n" : "",
>                            dev_name(&gdev->dev));
>                 return 0;
> --
> 2.45.2
>

But with this change we go from an incorrect:

# cat /sys/kernel/debug/gpio
gpiochip0: (dangling chip)
gpiochip1: (dangling chip)
gpiochip2: (dangling chip)root@qemux86-64:~#

to still incorrect:

# cat /sys/kernel/debug/gpio
gpiochip0: (dangling chip)

gpiochip1: (dangling chip)

gpiochip2: (dangling chip)

Bart

