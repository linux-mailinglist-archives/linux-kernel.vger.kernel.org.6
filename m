Return-Path: <linux-kernel+bounces-518042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D800A38901
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 041841682D2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074B329408;
	Mon, 17 Feb 2025 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="jP8rbDpQ"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF33B224B08
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 16:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739809285; cv=none; b=PJcPXFRTZ2R43dDOu8okKwopTBSoQ50Il+rB0VdAPY7QWl50/IkpwzJZho26f2XIt2PzFq2HDGqVRF/zysDNVs35X5gPVFeEPHhNDFeDeOPux2UxyyPzm7a8SUrYPTUFsPjJkMQx5cSByFqE05rpEDj01KXEuP5xrIgUubvaNQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739809285; c=relaxed/simple;
	bh=7X6eqOEJkPZsrf6kp80SCMXYqXkXyRQicJwz/PFhEyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXNy/1q2jFVBapCLCljMAg+XsJ58kPd6hLIVy4PI5yboOms4oBU0CE+SRc+SfkMKfb49v+g64qyfNwj78i+Lv6fIQspQyXz2+rEskMZ4qm0lo/T5qLGyljCD2Eh/zVZUHNiib/4tVIIktMOEOulA1yJKpTe+Pz8tgAP0aderUB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=jP8rbDpQ; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2B6273F220
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 16:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739809281;
	bh=dLbJ/ru83t63UttBRDVZfjx0n4E1ZYZJiiClKLFM1lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=jP8rbDpQTsPvOjmrT+F/dqOAS55FRvWzJVpdjWNQWjVbov1zVek6qUHNwL2jvasKR
	 YucHKeJBqQDrB3KCbWpa1xq92SRWZ9CQ5ONrn8n7bIqbc5DF8OLTzv2S7qTgmZvurh
	 OYKjjnaypYKPYkjCkI880oUk3ObgNjBlNGKTItxsaVNNKr349BxFT2xWCXR1z7svHf
	 VmItQmhfLfIquaJQpCum7VZsRSHXUsSPHoeI61A8I7pF8a0Q69SEyRPfKDZ2mcPVDE
	 eO0ZSVRRzKjFjJbIV3Yl7oyLoUBldCxyalgd/IqOY4kKZmoyA2XeOT7XGl9Mqgl1Yb
	 0Nyutzerz+Dqg==
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-220d8599659so75057075ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:21:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739809279; x=1740414079;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dLbJ/ru83t63UttBRDVZfjx0n4E1ZYZJiiClKLFM1lg=;
        b=WG0hdFsCeO4UW6YXQqBsRBNDeJQP2U7eKWNz+K8avKFHWZM8g39AkBta0Kg/XPrb+E
         d6Y7urFujC3B/RcxcArWIe8V78RCW8TwrrTUhY0OPf5M7ELeSlnZk7QZj90Xjtt/eBVX
         IRWSLDBX0KXDCMw9bmx6ph7gvIqJRcw5LmQL2nkr/ubcUZEzWT09c9ti7zviQ+Lue3AE
         sGFSx6cVOSj+bQpfldzcbn9rrAQXtbIxKr9CyE77bJXacu5pPOQVOWmm65v62wBqoZJj
         KfAZMYBLz2sF7LaEuFw/OEDpQ/stduvvqQOVs2qo0vsQKRsVYKr5T2hZuvmc3PuzoBvt
         N63w==
X-Forwarded-Encrypted: i=1; AJvYcCVrYnFa2UO59yKymrvBiV5bIYto194BbqYY5UBdoCodQoMArcOsaNZDu4nIifEa4xXYxq7gIz8UEadXusY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj4lHmOjQXzjAUSW2RZ0fMtOVjCm+PciCzTvnRGtSc1cP09TKy
	1xk3A0ZFI2zEKp/rsv91ItgbgpZaTUczUNa7CF2Uj64Ydkwbv/IhNBYq42QCd86aBel2X/Iul5r
	NkKbdb/2pHmXXcjWONxK7ozdiBE5Srfu+mXyi1ubVyF/LDcALogqVycwpBQsjH3oTrLiCU0lB6E
	gBFg==
X-Gm-Gg: ASbGnctOUkOFC5aJXGN1jvRDGEDyQFHjvnHG1PiV3PdFTuqr2RKvH2/jNzASchMbvKw
	yUWg5MJeUVkzKcHph2kUoE35Mb1k0j8jnwEsfPaMpU9meGb/kMyP/Pm1TkIz/lzwr2ug7VAC4+n
	sRWSusFdLjJ/T5RGpWy49jT3a9kd2t+42L1oavVmkOM0QdQGnlRuj0carAUru1DazpJrvRcO/PB
	ZXmPOYAbLl7vzNb4VcDab8yj1lith1sonQ3GHSH1kpvXLVdAbg7fbPNQV6GfiJ4a9PHOAMTpAga
	5Fk3vcA=
X-Received: by 2002:a17:902:c94e:b0:21f:6cd4:8c32 with SMTP id d9443c01a7336-22104048f02mr207614745ad.22.1739809279520;
        Mon, 17 Feb 2025 08:21:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPm8ZKdP+shnswYM0xZcUWx5xuUDFP1zzN77Ez0PEbnInxJ9tX0V3PGZZ+EduEhKW+6g3/cQ==
X-Received: by 2002:a17:902:c94e:b0:21f:6cd4:8c32 with SMTP id d9443c01a7336-22104048f02mr207614315ad.22.1739809279114;
        Mon, 17 Feb 2025 08:21:19 -0800 (PST)
Received: from localhost ([240f:74:7be:1:a56a:cda4:c8e9:c45c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5349226sm73913825ad.24.2025.02.17.08.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 08:21:18 -0800 (PST)
Date: Tue, 18 Feb 2025 01:21:16 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, geert+renesas@glider.be, 
	linus.walleij@linaro.org, maciej.borzecki@canonical.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] gpio: pseudo: common helper functions for pseudo
 gpio devices
Message-ID: <uogv4ckqo2e2byspffvfayu44v6fl46sxtu7eudweoye62sofi@5iwsumpttpca>
References: <20250217142758.540601-1-koichiro.den@canonical.com>
 <20250217142758.540601-2-koichiro.den@canonical.com>
 <CAMRc=McB0bcG4jERmUyrQ=eTP+kcfLBBAOaT7mCMKbgUB1W5nw@mail.gmail.com>
 <d2qdoq3f3jk6gzgsjeqszgaqk7z523r7cfnopxfq4ghsbsqgp3@zjw67ewqzi5u>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2qdoq3f3jk6gzgsjeqszgaqk7z523r7cfnopxfq4ghsbsqgp3@zjw67ewqzi5u>

On Tue, Feb 18, 2025 at 01:12:17AM GMT, Koichiro Den wrote:
> On Mon, Feb 17, 2025 at 04:46:30PM GMT, Bartosz Golaszewski wrote:
> > On Mon, Feb 17, 2025 at 3:28 PM Koichiro Den <koichiro.den@canonical.com> wrote:
> > >
> > > Both gpio-sim and gpio-virtuser share a mechanism to instantiate a
> > > platform device and wait synchronously for probe completion.
> > > With gpio-aggregator adopting the same approach in a later commit for
> > > its configfs interface, it's time to factor out the common code.
> > >
> > > Add gpio-pseudo.[ch] to house helper functions used by all the pseudo
> > > GPIO device implementations.
> > >
> > > No functional change.
> > >
> > > Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> > > ---
> > 
> 
> Thanks for the review.
> 
> > Looking at this patch now, I've realized that there is nothing
> > GPIO-specific here. It's a mechanism for synchronous platform device
> > probing. I don't think its place is in drivers/gpio/ if we're making
> > it a set of library functions. Can I suggest moving it to lib/ and
> > renaming the module as pdev_sync_probe or something else that's
> > expressive enough to tell users what it does? You can make me the
> > maintainer of that module if you wish (feel free to add yourself
> > too!).
> 
> I had vaguely envisioned that this might eventually contain some
> GPIO-specific code for some reason, and also it's just a tiny utility to
> reduce code duplication, which is why I placed it in the neighborhood,
> drivers/gpio/. However, of course you’re right, there’s nothing
> GPIO-specific here, so moving it to lib/ makes sense.
> 
> I'm not really sure if this method for synchronous platform device probing
> can be broadly accepted as a general solution, but I have no objections to
> making the change. I'll move it as you suggested and send v2, setting you
> as its maintainer.

Regarding this series, I feel that it might make discussions smoother if
you submit it directly. So if you're okay with it, please go ahead. In
that case, there's even no need to mention me or CC me - I can track it on
ML :)

Koichiro

> 
> > 
> > >  drivers/gpio/Kconfig       |  4 ++
> > >  drivers/gpio/Makefile      |  1 +
> > >  drivers/gpio/gpio-pseudo.c | 86 ++++++++++++++++++++++++++++++++++++++
> > >  drivers/gpio/gpio-pseudo.h | 24 +++++++++++
> > >  4 files changed, 115 insertions(+)
> > >  create mode 100644 drivers/gpio/gpio-pseudo.c
> > >  create mode 100644 drivers/gpio/gpio-pseudo.h
> > >
> > > diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> > > index 56c1f30ac195..1e2c95e03a95 100644
> > > --- a/drivers/gpio/Kconfig
> > > +++ b/drivers/gpio/Kconfig
> > > @@ -1863,6 +1863,10 @@ config GPIO_MPSSE
> > >
> > >  endmenu
> > >
> > > +# This symbol is selected by some pseudo gpio device implementations
> > > +config GPIO_PSEUDO
> > > +       bool
> > 
> > Please make it tristate - modules that use it are already tristate.
> 
> Thanks for pointing that out. I'll fix it.
> 
> > 
> > > +
> > >  menu "Virtual GPIO drivers"
> > >
> > >  config GPIO_AGGREGATOR
> > > diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> > > index af3ba4d81b58..5eb54147a1ab 100644
> > > --- a/drivers/gpio/Makefile
> > > +++ b/drivers/gpio/Makefile
> > > @@ -136,6 +136,7 @@ obj-$(CONFIG_GPIO_PISOSR)           += gpio-pisosr.o
> > >  obj-$(CONFIG_GPIO_PL061)               += gpio-pl061.o
> > >  obj-$(CONFIG_GPIO_PMIC_EIC_SPRD)       += gpio-pmic-eic-sprd.o
> > >  obj-$(CONFIG_GPIO_POLARFIRE_SOC)       += gpio-mpfs.o
> > > +obj-$(CONFIG_GPIO_PSEUDO)              += gpio-pseudo.o
> > >  obj-$(CONFIG_GPIO_PXA)                 += gpio-pxa.o
> > >  obj-$(CONFIG_GPIO_RASPBERRYPI_EXP)     += gpio-raspberrypi-exp.o
> > >  obj-$(CONFIG_GPIO_RC5T583)             += gpio-rc5t583.o
> > > diff --git a/drivers/gpio/gpio-pseudo.c b/drivers/gpio/gpio-pseudo.c
> > > new file mode 100644
> > > index 000000000000..6e3da05440d8
> > > --- /dev/null
> > > +++ b/drivers/gpio/gpio-pseudo.c
> > > @@ -0,0 +1,86 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * Helper functions for Pseudo GPIOs
> > > + *
> > > + * Copyright 2025 Canonical Ltd.
> > 
> > Well, I'd say that most of the code here is still mine, so I'll go
> > ahead and shamelessly claim some credit: it would make sense to keep
> > my copyright.
> 
> Sure, sorry about that. I'll fix it.
> 
> > 
> > > + */
> > > +
> > > +#include "gpio-pseudo.h"
> > > +
> > > +static int pseudo_gpio_notifier_call(struct notifier_block *nb,
> > > +                                    unsigned long action,
> > > +                                    void *data)
> > > +{
> > > +       struct pseudo_gpio_common *common;
> > > +       struct device *dev = data;
> > > +
> > > +       common = container_of(nb, struct pseudo_gpio_common, bus_notifier);
> > > +       if (!device_match_name(dev, common->name))
> > > +               return NOTIFY_DONE;
> > > +
> > > +       switch (action) {
> > > +       case BUS_NOTIFY_BOUND_DRIVER:
> > > +               common->driver_bound = true;
> > > +               break;
> > > +       case BUS_NOTIFY_DRIVER_NOT_BOUND:
> > > +               common->driver_bound = false;
> > > +               break;
> > > +       default:
> > > +               return NOTIFY_DONE;
> > > +       }
> > > +
> > > +       complete(&common->probe_completion);
> > > +       return NOTIFY_OK;
> > > +}
> > > +
> > > +void pseudo_gpio_init(struct pseudo_gpio_common *common)
> > > +{
> > > +       memset(common, 0, sizeof(*common));
> > > +       init_completion(&common->probe_completion);
> > > +       common->bus_notifier.notifier_call = pseudo_gpio_notifier_call;
> > > +}
> > > +EXPORT_SYMBOL_GPL(pseudo_gpio_init);
> > > +
> > > +int pseudo_gpio_register(struct pseudo_gpio_common *common,
> > > +                        struct platform_device_info *pdevinfo)
> > > +{
> > > +       struct platform_device *pdev;
> > > +       char *name;
> > > +
> > > +       name = kasprintf(GFP_KERNEL, "%s.%u", pdevinfo->name, pdevinfo->id);
> > > +       if (!name)
> > > +               return -ENOMEM;
> > > +
> > > +       common->driver_bound = false;
> > > +       common->name = name;
> > > +       reinit_completion(&common->probe_completion);
> > > +       bus_register_notifier(&platform_bus_type, &common->bus_notifier);
> > > +
> > > +       pdev = platform_device_register_full(pdevinfo);
> > > +       if (IS_ERR(pdev)) {
> > > +               bus_unregister_notifier(&platform_bus_type, &common->bus_notifier);
> > > +               kfree(common->name);
> > > +               return PTR_ERR(pdev);
> > > +       }
> > > +
> > > +       wait_for_completion(&common->probe_completion);
> > > +       bus_unregister_notifier(&platform_bus_type, &common->bus_notifier);
> > > +
> > > +       if (!common->driver_bound) {
> > > +               platform_device_unregister(pdev);
> > > +               kfree(common->name);
> > > +               return -ENXIO;
> > > +       }
> > > +
> > > +       common->pdev = pdev;
> > > +       return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(pseudo_gpio_register);
> > > +
> > > +void pseudo_gpio_unregister(struct pseudo_gpio_common *common)
> > > +{
> > > +       platform_device_unregister(common->pdev);
> > > +       kfree(common->name);
> > > +       common->pdev = NULL;
> > > +}
> > > +EXPORT_SYMBOL_GPL(pseudo_gpio_unregister);
> > > diff --git a/drivers/gpio/gpio-pseudo.h b/drivers/gpio/gpio-pseudo.h
> > > new file mode 100644
> > > index 000000000000..093112b6cce5
> > > --- /dev/null
> > > +++ b/drivers/gpio/gpio-pseudo.h
> > > @@ -0,0 +1,24 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +
> > > +#ifndef GPIO_PSEUDO_H
> > > +#define GPIO_PSEUDO_H
> > > +
> > > +#include <linux/completion.h>
> > > +#include <linux/platform_device.h>
> > > +
> > > +struct pseudo_gpio_common {
> > 
> > After moving to lib/ this could be named "pdev_sync_probe_data"?
> 
> Hm, I can't think of anything else right now. I'll use the name. Thanks!
> 
> > 
> > > +       struct platform_device *pdev;
> > > +       const char *name;
> > > +
> > > +       /* Synchronize with probe */
> > > +       struct notifier_block bus_notifier;
> > > +       struct completion probe_completion;
> > > +       bool driver_bound;
> > > +};
> > > +
> > > +void pseudo_gpio_init(struct pseudo_gpio_common *common);
> > > +int pseudo_gpio_register(struct pseudo_gpio_common *common,
> > > +                        struct platform_device_info *pdevinfo);
> > > +void pseudo_gpio_unregister(struct pseudo_gpio_common *common);
> > > +
> > > +#endif /* GPIO_PSEUDO_H */
> > > --
> > > 2.45.2
> > >
> > 
> > Bartosz

