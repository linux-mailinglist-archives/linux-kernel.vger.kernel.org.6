Return-Path: <linux-kernel+bounces-517963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB14A38804
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32222173BC8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D7F2253E2;
	Mon, 17 Feb 2025 15:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="hhxFh9WK"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3103148FE6
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 15:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807206; cv=none; b=jupuuVpzWIkeO7AfoSG7C7uClWyiQKzCNpRLpJCUvoR05FcbMfxFYNcuKFi/IiyKxnrIypPrDljOEhaXD1Z7vI9eMRtTmD4GvnO0j3Bp3RQulA55scbb5hfwiIo4RdklOJd/6YQ+3LDcek6SIFQbLu9SfCQRrd8warotZMGp5zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807206; c=relaxed/simple;
	bh=XBNS+7YX8NxvYPSZ0+ir90ajkrUU3MIioeWDhnw5Z6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uBomUh1XkHvnwdgXPJqMhDmGTwLqaQ3eOVmmF3vq/IPenPncPNKwH0xI1oiJgt/vVivE4V+NLhaLFndri2Gd6ZkeM0youvz1A1JptGUyzqTr8l7shwgqpZnjl1kDvmsOOas6/F/jqzHWw2BitIKsBW/yapmu3tnKM6I5nLsGPlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=hhxFh9WK; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5461dab4bfdso1662145e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 07:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739807201; x=1740412001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XkzDYN1gGkqO9VyJeQskSv6mbplAgNwciOlRZE/YWls=;
        b=hhxFh9WK0VWQr3q0lCnLyt/I5lyVN8BCIhdEBGeYCdu+gyXKSbu2AYwFD/07YPgwT1
         2k835sc3KIlEk9NxMVWTi3A8zMwPx+t5iJPMuCYZD1HdecoNbQeXxzYW/9bMjq3ReKwY
         eemtY1RkX7kF530U2EmQXE9CM+Q+/6uovUIMFGUHBy3EMTRjP9pUaIdT+EcdEqFTm/Lx
         RNWLhjcmZ0p3Eqcf1hmy8Y+MLide02V6MnSLsKRsdMGP9x+GfqZHAjAwLx2ElXYIzThg
         6QYioy6E4kSoYk+aDlyMBM00sdBrQa0gelnQfz23mgVy18sJ8TwH7XtOKoKjzDWt6zF6
         l5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739807202; x=1740412002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XkzDYN1gGkqO9VyJeQskSv6mbplAgNwciOlRZE/YWls=;
        b=lsJytPHxstEbMTUY4HNMe6TWHWcko1YvblQN7bb94B+GGMxQtQ1/zXyy94DDswlXif
         fTJBpbMzDERNtRDsH7ssnWZunqOjFtwNJp7MFwaYEi0yuhBrYP5MWAGBgMt7/yKz73mh
         ZG2I256nmsTHJdglN++6DSbmrSd4ESLiRK1mjvPemMIVr8VML4sEyN6ltOPqf7bJ9g4F
         mJwBy0cysHNQLnclp5Ap60/tsZaDTcHCXwENZ+Jjo4HZExjgqTYKkCGJl/1pMPubg/q8
         3OFUioOC5l4SJa0YFacSsp2u78tsKYKnh7SKTseAhlo2V3LfayTYi3sD3WItwEtG0PLA
         xIDQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3CBG7R0fnXrYTnDT7v35he14k8kMjCbGF654KgtqyxzIVpwiHvatIVJ6AYPzY9WTlkVPNW/qCNpIjFJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM3IOurj07vqSYUJY3xxPVu8jNnHUyBq3N+2ehg06xuJ+tA5hW
	OzVMSgA4OkppSKsU9JQkprY6bX3/q1vGx5x17Ahoc1cxyHriifGBpM9g4rzPnynxCStbh3v3ftc
	Eae37xydxW/cqSQKFaQ9xgqV+hlMfm8BSOYQ0ag==
X-Gm-Gg: ASbGnctMi7gNrxyxm0Qj2uDLa6l0aF2bWs9V4myboV9sN5butRsmVq5lUMJi8zwguAg
	z5h9cWFJwEAFdRVGBnAVsRozeHHsZa1JDE8hyrMmTvYpqemvVC/B+BKuxs/chEolYo8E7T6pmnR
	Yp8D0kMspnbJzPUaO5aR2XSWxZ7g==
X-Google-Smtp-Source: AGHT+IFEjDunKO7FuLmAVbA0S4GhfeKyoIBfZfOuH1Y7VhtWBEvKPh9/gNXv/hZcjNEQydZW76vBiP9nmsUnmfZgGWg=
X-Received: by 2002:a05:6512:1189:b0:545:62c:4b13 with SMTP id
 2adb3069b0e04-5452fe8bf40mr2322208e87.40.1739807201425; Mon, 17 Feb 2025
 07:46:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217142758.540601-1-koichiro.den@canonical.com> <20250217142758.540601-2-koichiro.den@canonical.com>
In-Reply-To: <20250217142758.540601-2-koichiro.den@canonical.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 17 Feb 2025 16:46:30 +0100
X-Gm-Features: AWEUYZmqKu83WUquhnqeLmh4c0N9vNxtgT5ARMzuMvdWk7DaSn4dAL-oJmH34IY
Message-ID: <CAMRc=McB0bcG4jERmUyrQ=eTP+kcfLBBAOaT7mCMKbgUB1W5nw@mail.gmail.com>
Subject: Re: [PATCH 1/3] gpio: pseudo: common helper functions for pseudo gpio devices
To: Koichiro Den <koichiro.den@canonical.com>
Cc: linux-gpio@vger.kernel.org, geert+renesas@glider.be, 
	linus.walleij@linaro.org, maciej.borzecki@canonical.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 3:28=E2=80=AFPM Koichiro Den <koichiro.den@canonica=
l.com> wrote:
>
> Both gpio-sim and gpio-virtuser share a mechanism to instantiate a
> platform device and wait synchronously for probe completion.
> With gpio-aggregator adopting the same approach in a later commit for
> its configfs interface, it's time to factor out the common code.
>
> Add gpio-pseudo.[ch] to house helper functions used by all the pseudo
> GPIO device implementations.
>
> No functional change.
>
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> ---

Looking at this patch now, I've realized that there is nothing
GPIO-specific here. It's a mechanism for synchronous platform device
probing. I don't think its place is in drivers/gpio/ if we're making
it a set of library functions. Can I suggest moving it to lib/ and
renaming the module as pdev_sync_probe or something else that's
expressive enough to tell users what it does? You can make me the
maintainer of that module if you wish (feel free to add yourself
too!).

>  drivers/gpio/Kconfig       |  4 ++
>  drivers/gpio/Makefile      |  1 +
>  drivers/gpio/gpio-pseudo.c | 86 ++++++++++++++++++++++++++++++++++++++
>  drivers/gpio/gpio-pseudo.h | 24 +++++++++++
>  4 files changed, 115 insertions(+)
>  create mode 100644 drivers/gpio/gpio-pseudo.c
>  create mode 100644 drivers/gpio/gpio-pseudo.h
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 56c1f30ac195..1e2c95e03a95 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -1863,6 +1863,10 @@ config GPIO_MPSSE
>
>  endmenu
>
> +# This symbol is selected by some pseudo gpio device implementations
> +config GPIO_PSEUDO
> +       bool

Please make it tristate - modules that use it are already tristate.

> +
>  menu "Virtual GPIO drivers"
>
>  config GPIO_AGGREGATOR
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index af3ba4d81b58..5eb54147a1ab 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -136,6 +136,7 @@ obj-$(CONFIG_GPIO_PISOSR)           +=3D gpio-pisosr.=
o
>  obj-$(CONFIG_GPIO_PL061)               +=3D gpio-pl061.o
>  obj-$(CONFIG_GPIO_PMIC_EIC_SPRD)       +=3D gpio-pmic-eic-sprd.o
>  obj-$(CONFIG_GPIO_POLARFIRE_SOC)       +=3D gpio-mpfs.o
> +obj-$(CONFIG_GPIO_PSEUDO)              +=3D gpio-pseudo.o
>  obj-$(CONFIG_GPIO_PXA)                 +=3D gpio-pxa.o
>  obj-$(CONFIG_GPIO_RASPBERRYPI_EXP)     +=3D gpio-raspberrypi-exp.o
>  obj-$(CONFIG_GPIO_RC5T583)             +=3D gpio-rc5t583.o
> diff --git a/drivers/gpio/gpio-pseudo.c b/drivers/gpio/gpio-pseudo.c
> new file mode 100644
> index 000000000000..6e3da05440d8
> --- /dev/null
> +++ b/drivers/gpio/gpio-pseudo.c
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Helper functions for Pseudo GPIOs
> + *
> + * Copyright 2025 Canonical Ltd.

Well, I'd say that most of the code here is still mine, so I'll go
ahead and shamelessly claim some credit: it would make sense to keep
my copyright.

> + */
> +
> +#include "gpio-pseudo.h"
> +
> +static int pseudo_gpio_notifier_call(struct notifier_block *nb,
> +                                    unsigned long action,
> +                                    void *data)
> +{
> +       struct pseudo_gpio_common *common;
> +       struct device *dev =3D data;
> +
> +       common =3D container_of(nb, struct pseudo_gpio_common, bus_notifi=
er);
> +       if (!device_match_name(dev, common->name))
> +               return NOTIFY_DONE;
> +
> +       switch (action) {
> +       case BUS_NOTIFY_BOUND_DRIVER:
> +               common->driver_bound =3D true;
> +               break;
> +       case BUS_NOTIFY_DRIVER_NOT_BOUND:
> +               common->driver_bound =3D false;
> +               break;
> +       default:
> +               return NOTIFY_DONE;
> +       }
> +
> +       complete(&common->probe_completion);
> +       return NOTIFY_OK;
> +}
> +
> +void pseudo_gpio_init(struct pseudo_gpio_common *common)
> +{
> +       memset(common, 0, sizeof(*common));
> +       init_completion(&common->probe_completion);
> +       common->bus_notifier.notifier_call =3D pseudo_gpio_notifier_call;
> +}
> +EXPORT_SYMBOL_GPL(pseudo_gpio_init);
> +
> +int pseudo_gpio_register(struct pseudo_gpio_common *common,
> +                        struct platform_device_info *pdevinfo)
> +{
> +       struct platform_device *pdev;
> +       char *name;
> +
> +       name =3D kasprintf(GFP_KERNEL, "%s.%u", pdevinfo->name, pdevinfo-=
>id);
> +       if (!name)
> +               return -ENOMEM;
> +
> +       common->driver_bound =3D false;
> +       common->name =3D name;
> +       reinit_completion(&common->probe_completion);
> +       bus_register_notifier(&platform_bus_type, &common->bus_notifier);
> +
> +       pdev =3D platform_device_register_full(pdevinfo);
> +       if (IS_ERR(pdev)) {
> +               bus_unregister_notifier(&platform_bus_type, &common->bus_=
notifier);
> +               kfree(common->name);
> +               return PTR_ERR(pdev);
> +       }
> +
> +       wait_for_completion(&common->probe_completion);
> +       bus_unregister_notifier(&platform_bus_type, &common->bus_notifier=
);
> +
> +       if (!common->driver_bound) {
> +               platform_device_unregister(pdev);
> +               kfree(common->name);
> +               return -ENXIO;
> +       }
> +
> +       common->pdev =3D pdev;
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(pseudo_gpio_register);
> +
> +void pseudo_gpio_unregister(struct pseudo_gpio_common *common)
> +{
> +       platform_device_unregister(common->pdev);
> +       kfree(common->name);
> +       common->pdev =3D NULL;
> +}
> +EXPORT_SYMBOL_GPL(pseudo_gpio_unregister);
> diff --git a/drivers/gpio/gpio-pseudo.h b/drivers/gpio/gpio-pseudo.h
> new file mode 100644
> index 000000000000..093112b6cce5
> --- /dev/null
> +++ b/drivers/gpio/gpio-pseudo.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef GPIO_PSEUDO_H
> +#define GPIO_PSEUDO_H
> +
> +#include <linux/completion.h>
> +#include <linux/platform_device.h>
> +
> +struct pseudo_gpio_common {

After moving to lib/ this could be named "pdev_sync_probe_data"?

> +       struct platform_device *pdev;
> +       const char *name;
> +
> +       /* Synchronize with probe */
> +       struct notifier_block bus_notifier;
> +       struct completion probe_completion;
> +       bool driver_bound;
> +};
> +
> +void pseudo_gpio_init(struct pseudo_gpio_common *common);
> +int pseudo_gpio_register(struct pseudo_gpio_common *common,
> +                        struct platform_device_info *pdevinfo);
> +void pseudo_gpio_unregister(struct pseudo_gpio_common *common);
> +
> +#endif /* GPIO_PSEUDO_H */
> --
> 2.45.2
>

Bartosz

