Return-Path: <linux-kernel+bounces-364263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C97E799CF59
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FF0CB20E09
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AFC1C689D;
	Mon, 14 Oct 2024 14:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="uvAXqHrY"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060381C32FE
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917425; cv=none; b=ob9SbpSSg5/woiRac1FVopid6Va/2+277s2/D40OVjqF2KCv6m3hPqzRayGHAfpcUNs6PbZoutywta6mhPVC4KAeHVUSoejR86dI9gFM83W+AUkD/0y1MRkR1kt4L1592LkRy6jSwXHdoR3/T95X1FyPUqp/sbG61HDYH/NXdbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917425; c=relaxed/simple;
	bh=Trrsi/1o9flLYLZyOmEYFpYG5mAtmBzFeoelpiRrHHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TAN6hh5IHQzgZV2iYmcOQiKMmwbzLSAnI+jaS7orx0PZNm7aB1jbfN1IqLANrLGKKl9XtGQ+Ex2s0gxKfePlYZmGd9TEO9uYviNWsqir1z+VYzJ8YoDa80YDrIBTQ1RwlAEMzCbht4tJ87Q0rQfMNr04ZnlJoCToi/dEtOW77B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=uvAXqHrY; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e2e6a1042dso3109230a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 07:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728917422; x=1729522222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIcR5NMxedzEz0Rtm+vXdoPtFq9+tXtK//uLKs8wDjY=;
        b=uvAXqHrYytYdoOOAUhBsQXvV6q21qAhv/yVjQg10dFbCvlyPJQrqQtwI1nK9ARDN1t
         L5Y+zKajbDcn3MXD10kRGCc8vqdfYSDw3uJ0zj/wOYKR173NPjC9b6LJgvnfngYdtg5e
         A35AsDplv71NUokIRr6gXAvkknKAgu3d5HXu/VU8Vhn1dSSJEMg4c+gvJtoZZEH0cyO8
         9l7u1lAuS34xIL5FNw6U9tYRY323rQ1SEbsj/ITTCJoCp7mo///FykbtWvcb6tawiPd8
         NtcDvSRXXzlUWw6OU9VMMbiCAGTgtWrwEZ4fVUK6MG2tBZ3Xen/q9OLQ+1Vl5XeR/2HI
         8Lng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728917422; x=1729522222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AIcR5NMxedzEz0Rtm+vXdoPtFq9+tXtK//uLKs8wDjY=;
        b=SqtTredVVlXy6jqtILel3by88NTjvTjgu6oiI+Fn0HbGTSjrH5f3BnfSIYQtRSiBJF
         9FEeYbNcEMqcHMvZHmHQ1wsScjz6nWhSubyt0QgPkYZicMJjDFMSFTvCE/bNGzxDtUFz
         mm95ESfuxsObNrkib4zvHCveVFKbWxFqe4hNCqsVFv0Gqg7JZLKUirljyfbXd9kA9Rak
         mCsHpOyHojOFwAJpsuXPjPoudqtZDVjTwAHzVinX28kUKADiFGkjl/6mGEb4sUSy7Cn0
         cM5xPbPsS9hKnYBPm3YLg0bT0szzFhiDwV6wnhwF3NgdfOnL5G9dEI+PtsB3EuS/bmXq
         5gRA==
X-Forwarded-Encrypted: i=1; AJvYcCUlHnx90OS4jBLsirl0KQp1VDO3pCU/MOUbR+jIkrEb1XPIOIjfX4wcLznxawbdcwIAD+WioNhJkdpW3xs=@vger.kernel.org
X-Gm-Message-State: AOJu0YznZKJoLw0nF8qwLjOau6o5x5uZtAojyFk3ZrCwXZzqa7DNtxk0
	BUHEVxnAFJxG4rC4y+o6RCZJT+pINFSW8nulTZ30s8YqcSZVYLua09+GSyGH/ath0OQos07xyeS
	yWJd+fSqgwQHmiCL2e42HRbVj0ujkMELSbX3hxA==
X-Google-Smtp-Source: AGHT+IG8l3FuScfy0oU94qvypN2fKUFHSDDYJcYPq2rf5sSrETEcw3n899lt8XGJDq2RbOj3IUsonleGQBO6ebdV6GI=
X-Received: by 2002:a17:90b:4b83:b0:2e3:191e:7ef7 with SMTP id
 98e67ed59e1d1-2e3191e80d7mr10242613a91.12.1728917422345; Mon, 14 Oct 2024
 07:50:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014121047.103179-1-brgl@bgdev.pl>
In-Reply-To: <20241014121047.103179-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 14 Oct 2024 16:50:09 +0200
Message-ID: <CAMRc=McG9a9CKXAdyAwQ=65SUOg32ExgY-YGyCs7Rxb_XjEqDg@mail.gmail.com>
Subject: Re: [PATCH] gpio: create empty /sys/class/gpio with SYSFS disabled
To: Linus Walleij <linus.walleij@linaro.org>, Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 2:10=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> User-space may want to use some kind of a compatibility layer for the
> deprecated GPIO sysfs ABI. This would typically involve mounting
> a fuse-based filesystem using the GPIO character device to emulate the
> sysfs behavior and layout.
>
> With GPIO_SYSFS disabled, the /sys/class/gpio directory doesn't exist
> and user-space cannot create it. In order to facilitate moving away from
> the sysfs, add a new Kconfig option that indicates to GPIOLIB that is
> should create an empty directory where the GPIO class interface would
> exist and enable it by default.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> As I've mentioned under a different patch, I'm working on a user-space
> compatibility layer for the sysfs GPIO interface. FUSE allows us to
> emulate almost all its functionalities using libgpiod except for
> mounting it under /sys/class/gpio if GPIO_SYSFS is disabled. User-space
> cannot create directories in sysfs so if we want to allow users to mount
> the FUSE emulator under the old location, we need to create an empty
> /sys/class/gpio directory from the kernel and this is what is patch is
> for.
>
>  drivers/gpio/Kconfig   | 18 ++++++++++++++++++
>  drivers/gpio/gpiolib.c | 12 ++++++++++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index bfa6b5a2c537..f2e7163cb46c 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -69,6 +69,24 @@ config GPIO_SYSFS
>           use the character device /dev/gpiochipN with the appropriate
>           ioctl() operations instead.
>
> +config GPIO_SYSFS_CLASS_DIR_STUB
> +       bool "Create empty /sys/class/gpio directory" if EXPERT
> +       depends on !GPIO_SYSFS
> +       default y
> +       help
> +         Say Y here to create an empty /sys/class/gpio directory.
> +
> +         User-space may want to use some kind of a compatibility layer f=
or the
> +         deprecated GPIO sysfs ABI. This would typically involve mountin=
g
> +         a fuse-based filesystem using the GPIO character device to emul=
ate
> +         the sysfs behavior and layout.
> +
> +         This option makes GPIOLIB create an empty directory at /sys/cla=
ss/gpio
> +         where user-space can mount the sysfs replacement and avoid havi=
ng to
> +         change existing programs to adjust to different filesystem path=
s.
> +
> +         If unsure, say Y.
> +
>  config GPIO_CDEV
>         bool
>         prompt "Character device (/dev/gpiochipN) support" if EXPERT
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 97346b746ef5..31efb580beb8 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -4873,6 +4873,12 @@ static struct device_driver gpio_stub_drv =3D {
>         .probe =3D gpio_stub_drv_probe,
>  };
>
> +#if IS_ENABLED(CONFIG_GPIO_SYSFS_CLASS_DIR_STUB)
> +static const struct class gpio_class_stub =3D {
> +       .name =3D "gpio",
> +};
> +#endif /* CONFIG_GPIO_SYSFS_CLASS_DIR_STUB */
> +
>  static int __init gpiolib_dev_init(void)
>  {
>         int ret;
> @@ -4899,6 +4905,12 @@ static int __init gpiolib_dev_init(void)
>                 return ret;
>         }
>
> +#if IS_ENABLED(CONFIG_GPIO_SYSFS_CLASS_DIR_STUB)
> +       ret =3D class_register(&gpio_class_stub);

Gah I forgot to unregister the class. Also now that I think about it
we should maybe expose the class kobject in the kobject.h header and
use sysfs_create_mount_point() like what we do for debugfs, configfs
and other mountpoints at /sys/kernel?

In any case: please let me know what you think about this change in general=
.

Bart

> +       if (ret)
> +               pr_err("gpiolib: failed to create the empty gpio class di=
rectory\n");
> +#endif /* CONFIG_GPIO_SYSFS_CLASS_DIR_STUB */
> +
>         gpiolib_initialized =3D true;
>         gpiochip_setup_devs();
>
> --
> 2.43.0
>

