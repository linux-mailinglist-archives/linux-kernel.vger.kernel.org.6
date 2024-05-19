Return-Path: <linux-kernel+bounces-183170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A6A8C9586
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 19:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E8F91C20D90
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 17:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEEC4D9FE;
	Sun, 19 May 2024 17:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="QrtWXu4a"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC36C1DFCB
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 17:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716139686; cv=none; b=j4nR6/oCoRGo2Qw+yO9jA47GTxHsGElXaklu5FT+mcI/KwhbRZjuMuMKUNXWlx9UjmAFm5h01R/lsBMWvbPhl9iL/U5vq/rDRcCL3zz6ORPsaaJVfx9FL92Bb+psn5FW4bW6xdrShtxr2YFirnvQamJ9gwsXPrBwhF1ltNwvAvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716139686; c=relaxed/simple;
	bh=C7Bo8yy7avAwm4E3qVaujOfZItIgyC/ssTWzng36bw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VxcoXXFqBA1HMy4kUfXoiUtFMdkn/+iN6qVUhQ+DkC24t+K8xE4+vRU7r8gIklKO/dwHxnuutct85BnkTmd+ZmfJdDBqR+em93mRUGwzCMpBcdYrz6bc+V2gcMhkhNgYgywSyv0fuYOanD+y1+kyJkp8M5W5fI3TdTCZQNooF6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=QrtWXu4a; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51f60817e34so4179038e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 10:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1716139683; x=1716744483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfftBWeVqaeieWMDwDgaFTXo1TkiwE5SU6imM85kzuY=;
        b=QrtWXu4aR5F9UcSLPaA01efyHlCTiid74CEVnSI7licYxhkKDF1uBBd7+cFo2L9YgE
         TEeaGI0vP4SVF5LBZb/3QpGUFPo8cwQmJWONaGnKejyLPYA+Y0Fne2Zf0e8jmCHsM322
         9TnoQ3VyhIZ20Dx+AKRvD6+H4jVUIxknmpRSgFCMo5nbsTbKp0ayQ07UCYkqp7AX3yFS
         dzj/OXq7q6kNVGRls+sTAwtSpc9lp7zRFz9qPi0lGU4iZrxfhTzE7wUpjVjI5zQMSV4c
         VWCia82c6AqZ5/7bBKHstwNZwT6+ZL3OYwUQM71B5Ru1iCqDsK+WxSbIFyPQQzmwUi3y
         MmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716139683; x=1716744483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfftBWeVqaeieWMDwDgaFTXo1TkiwE5SU6imM85kzuY=;
        b=vYeP7K7XK0gDU4neObOYAlSArzVmkA483tq5L2kYxfYWmtt0Y5ph1BnP5E5NDqdmFO
         Fr3rmJ5mgr2+tB4p0+bww01gJNuKU5Z8O7exNvS4XeOimxFCz3I7GztubgWQrzv7LThW
         V/KJhzJYoQX5W+2xnrOB0ubD2ZGkaRJw6m07xaKg3El/QaeI30nbrwK30OYozBFwtv3B
         cryRvXFMf5SExdVMsQFoIROYKIauJgQcMrZOGLau+tWHICc/e3zGxGmzhnsgNqPlN3gp
         ox2hP81mZuyhHIjHMq8fj8rlOM21vtqvZvUvTk3oPQacWPkMmrlp/BbRwG7ErgcA1H5s
         Sn+A==
X-Forwarded-Encrypted: i=1; AJvYcCU/WFUS/vdkJbDgP2pD2E3Fzkqnwe/+BAlkCedz92+EZSS/8vrMN+kLH6XeS3c09xuuFr/sSgmwBHqZFbPmUI35MzTILtr4VkntYJbq
X-Gm-Message-State: AOJu0Yx45iDVbOAGJq+NloNuEsg95jw0qV34wYTmr9C7W6/wJbKltjpp
	8GEjtWOh+W0nJ0twx4VxP1UVciyy5BMOO+M+fsqhszTdO42J33qd4K5KggbK04ZzjTCRxONe5bX
	MkPKanH3ARaxsPnwV/qJXRabUKUf7Lh7uTYEIMg==
X-Google-Smtp-Source: AGHT+IGD+GgVDLIiKKswOsHFmDBuBrzI2l17OB+2USkIGab8PvZL3e9XE/DZZS3iluh1MJ32jR6QDGZFzo4MA2wTzqg=
X-Received: by 2002:a19:8c4d:0:b0:51f:2709:3641 with SMTP id
 2adb3069b0e04-5220fb72e2fmr16098806e87.26.1716139682752; Sun, 19 May 2024
 10:28:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240519144920.14804-1-egyszeregy@freemail.hu>
In-Reply-To: <20240519144920.14804-1-egyszeregy@freemail.hu>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sun, 19 May 2024 19:27:51 +0200
Message-ID: <CAMRc=MctEsMiRgaV5UTiaxjoFDa2izX9wnLAU07=G8gBEcSKoQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Introduce "linux,gpiochip-name" property for
 device tree of GPIO controller.
To: egyszeregy@freemail.hu
Cc: linus.walleij@linaro.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 19, 2024 at 4:49=E2=80=AFPM <egyszeregy@freemail.hu> wrote:
>
> From: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
>
> Optionally, a GPIO controller may have a "linux,gpiochip-name" property.

Oh, may it really?

$ git grep "linux,gpiochip-name" Documentation/devicetree/bindings/
$

Doesn't look like it.

> This is a string which is defining a custom suffix name for gpiochip in
> /dev/gpiochip-<name> format. It helps to improve software portability
> between various SoCs and reduce complexities of hardware related codes
> in SWs.
>
> Signed-off-by: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
> ---
>  drivers/gpio/gpiolib.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index ce94e37bcbee..e24d8db1d054 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -860,6 +860,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, =
void *data,
>                                struct lock_class_key *lock_key,
>                                struct lock_class_key *request_key)
>  {
> +       const char *name;
>         struct gpio_device *gdev;
>         unsigned int desc_index;
>         int base =3D 0;
> @@ -896,7 +897,16 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc,=
 void *data,
>                 goto err_free_gdev;
>         }
>
> -       ret =3D dev_set_name(&gdev->dev, GPIOCHIP_NAME "%d", gdev->id);
> +       /*
> +        * If "linux,gpiochip-name" is specified in device tree, use /dev=
/gpiochip-<name>
> +        * in Linux userspace, otherwise use /dev/gpiochip<id>.
> +        */
> +       ret =3D device_property_read_string(gc->parent, "linux,gpiochip-n=
ame", &name);
> +       if (ret < 0)
> +               ret =3D dev_set_name(&gdev->dev, GPIOCHIP_NAME "%d", gdev=
->id);
> +       else
> +               ret =3D dev_set_name(&gdev->dev, GPIOCHIP_NAME "-%s", nam=
e);
> +
>         if (ret)
>                 goto err_free_ida;
>
> --
> 2.39.3
>

NAK, this is udev's task in user-space if you need this.

Bart

