Return-Path: <linux-kernel+bounces-327160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C135977150
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA6781F24DAD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F311C2452;
	Thu, 12 Sep 2024 19:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOEN9t+D"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B64E1C243B;
	Thu, 12 Sep 2024 19:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168336; cv=none; b=uRZNEt/HyV60ll+lxagnoVAVvmxcV6kg6wMM6n5ktWt/miUrYBlWjdesa9CDu8rP85pTnEjjoEHYT05kX8jW/zQnJJG8ExG+z0CvJnhHKL/dTlM9Au7tCcAhTcPo4hYUbb5N36v2pbila0FkDb3AbgUV96ZGn3msf845uhJ7JxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168336; c=relaxed/simple;
	bh=bbrO80+c+MIzbYvl9OoDf7CZBzNkwCsHjwYfrJddkw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rpKGGZ5Se4OQxe2jl+KRWgnyZ16+Kjyc1TbR1IQi7TUotqyADJ8eJuaIIW9wp9fPeL7F/fEc8NinM1Vj2aIucSW4fbaji2Jvjt86WrW16LLnFyvG+4h6zOZyotp2xE/zOWPosR55AOB9wnAYIlS7XRb2sR3j4C6IcNolnzeO5cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOEN9t+D; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6c49c9018ebso12295057b3.3;
        Thu, 12 Sep 2024 12:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726168334; x=1726773134; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8NMJSqTKRUoPdKRSlr4boJM9fnxyrG/NqcM0uOw1EuI=;
        b=aOEN9t+DRJz3vNFcd1GFC26n64PJl6vtWM16NRjXRyfOp0kHqYbSq17nbknnvAJBYA
         2P1hm7qy4paNtAKxYUxIKcwVPRlY3JCQFXXMqKa5wPX8Km0VuY/qwys4SQFHjNEcoXSP
         OkF5kfqKsb0Zb2PPLhNUxab0gxW4KQFMuzWhtOB78wk/fx2ej+kdBOVWy72GrVSxWNYt
         8HIkGzjiImxhqKrI4/iGH9x8Lc+t9YkOV3zc1V0EnIwoMXw1L+bckv6GcYrsSgXS0KdP
         q6EdG87Cx3pp1+Qza2sJIGcDgwwUHzjRAfRqULGmxbacHugkj4FurPuQ0S/Zr71Co3+A
         eFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726168334; x=1726773134;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8NMJSqTKRUoPdKRSlr4boJM9fnxyrG/NqcM0uOw1EuI=;
        b=Bxd+86R3chVtLAxct8KHaYamQcxJgKeNTUciFxBqSOd+nmi0lB1YWPH8O6jLLxz7eF
         66st2CNmicFpRt7ak8OELGH7kxV1WPpjMA4VN0IVeapuwmXt5z497n/7mizfn8F43Ate
         /jYWq16vSQXU79cRs5Ff43s6fvtQo255ghU91riuG7PNI1SOKmU0MBxe0enDc+mCBfTi
         NF4EKdN5SDIn8CY3V/T4zcT4F4aCLZeciXi4UOpvCv1EWyOlR9ZurwQ2ShQXBLj93Orj
         vMTJnUWR8plDC3lDPG4SgxXQCn68HQ6TFogL+Fvv5lPhs4QvujqTbBY0ls/iwPDcQWNZ
         V8zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwUfmuFOaOyJkDPn2VU1WUlPZv2b7XEeQ41Z6suA58zBgPEAawJ0FTCF94gJIYwVLpPud3pyUfH1hVe9q6@vger.kernel.org, AJvYcCVRHQXqDSQva5sLIdyL1M0OSC/kmZ6MvK4GUNDov5LVJyx5IQKVvy1vD5S364R7DCxY6YqIPzJSs/9K@vger.kernel.org, AJvYcCW1eAamjm5jB1bASFghLo4IU6vBFpcbtwsihyBfbEoVLhVjl/ROVi6jPifsLjZcpgLgkzi3SzD3V8kx@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7awHdhUm5TMGBxrejCsdlALG+WJrRn1vqfYWWGQOhnStKmISs
	i0lDSJa/ej4LcoH98cJjFI0wbKGsQCEHVdOWFdgzXkE/tyMd+E9VniEv2PqiEN/flj0XX+WRjOw
	knPDAJ9yUvDmukYEdHxoSnWh0yQE=
X-Google-Smtp-Source: AGHT+IFBy8scuJ/GQzRK0WT6GhaBlpWir+n42OWFvqw4XJlosh/vu2KEkzFqruhfOcy5stCbRSEDcHJFs8xIaWovjjU=
X-Received: by 2002:a05:690c:4a02:b0:6b5:916d:597 with SMTP id
 00721157ae682-6dbb6b236d4mr41736117b3.22.1726168333942; Thu, 12 Sep 2024
 12:12:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815150255.3996258-1-tmaimon77@gmail.com> <20240815150255.3996258-3-tmaimon77@gmail.com>
 <d003cb854f9aea30c7d26b4d2b7f50cf467bf225.camel@pengutronix.de>
In-Reply-To: <d003cb854f9aea30c7d26b4d2b7f50cf467bf225.camel@pengutronix.de>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Thu, 12 Sep 2024 22:12:03 +0300
Message-ID: <CAP6Zq1go+hxzxaF+ACv-Rhm+=oh7ooLKune6jJtKRGfz9onT7A@mail.gmail.com>
Subject: Re: [PATCH RESEND v27 2/3] reset: npcm: register npcm8xx clock
 auxiliary bus device
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, tali.perry1@gmail.com, joel@jms.id.au, 
	venture@google.com, yuenn@google.com, benjaminfair@google.com, 
	openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Philipp,

Thanks for your review.

Done in Version 28 :-)

Best regards,

Tomer


On Thu, 12 Sept 2024 at 18:18, Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> On Do, 2024-08-15 at 18:02 +0300, Tomer Maimon wrote:
> > Add NPCM8xx clock controller auxiliary bus device registration.
> >
> > The NPCM8xx clock controller is registered as an aux device because the
> > reset and the clock controller share the same register region.
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > Tested-by: Benjamin Fair <benjaminfair@google.com>
> > ---
> >  drivers/reset/Kconfig               |  1 +
> >  drivers/reset/reset-npcm.c          | 74 ++++++++++++++++++++++++++++-
> >  include/soc/nuvoton/clock-npcm8xx.h | 16 +++++++
> >  3 files changed, 90 insertions(+), 1 deletion(-)
> >  create mode 100755 include/soc/nuvoton/clock-npcm8xx.h
> >
> > diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> > index 67bce340a87e..c6bf5275cca2 100644
> > --- a/drivers/reset/Kconfig
> > +++ b/drivers/reset/Kconfig
> > @@ -157,6 +157,7 @@ config RESET_MESON_AUDIO_ARB
> >  config RESET_NPCM
> >       bool "NPCM BMC Reset Driver" if COMPILE_TEST
> >       default ARCH_NPCM
> > +     select AUXILIARY_BUS
> >       help
> >         This enables the reset controller driver for Nuvoton NPCM
> >         BMC SoCs.
> > diff --git a/drivers/reset/reset-npcm.c b/drivers/reset/reset-npcm.c
> > index 8935ef95a2d1..aa68b947226a 100644
> > --- a/drivers/reset/reset-npcm.c
> > +++ b/drivers/reset/reset-npcm.c
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  // Copyright (c) 2019 Nuvoton Technology corporation.
> >
> > +#include <linux/auxiliary_bus.h>
> >  #include <linux/delay.h>
> >  #include <linux/err.h>
> >  #include <linux/io.h>
> > @@ -10,11 +11,14 @@
> >  #include <linux/property.h>
> >  #include <linux/reboot.h>
> >  #include <linux/reset-controller.h>
> > +#include <linux/slab.h>
> >  #include <linux/spinlock.h>
> >  #include <linux/mfd/syscon.h>
> >  #include <linux/regmap.h>
> >  #include <linux/of_address.h>
> >
> > +#include <soc/nuvoton/clock-npcm8xx.h>
> > +
> >  /* NPCM7xx GCR registers */
> >  #define NPCM_MDLR_OFFSET     0x7C
> >  #define NPCM7XX_MDLR_USBD0   BIT(9)
> > @@ -89,6 +93,7 @@ struct npcm_rc_data {
> >       const struct npcm_reset_info *info;
> >       struct regmap *gcr_regmap;
> >       u32 sw_reset_number;
> > +     struct device *dev;
> >       void __iomem *base;
> >       spinlock_t lock;
> >  };
> > @@ -372,6 +377,67 @@ static const struct reset_control_ops npcm_rc_ops = {
> >       .status         = npcm_rc_status,
> >  };
> >
> > +static void npcm_clock_unregister_adev(void *_adev)
> > +{
> > +     struct auxiliary_device *adev = _adev;
> > +
> > +     auxiliary_device_delete(adev);
> > +     auxiliary_device_uninit(adev);
> > +}
> > +
> > +static void npcm_clock_adev_release(struct device *dev)
> > +{
> > +     struct auxiliary_device *adev = to_auxiliary_dev(dev);
> > +     struct npcm_clock_adev *rdev = to_npcm_clock_adev(adev);
> > +
> > +     kfree(rdev);
> > +}
> > +
> > +static struct auxiliary_device *npcm_clock_adev_alloc(struct npcm_rc_data *rst_data, char *clk_name)
> > +{
> > +     struct npcm_clock_adev *rdev;
> > +     struct auxiliary_device *adev;
> > +     int ret;
> > +
> > +     rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
> > +     if (!rdev)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     rdev->base = rst_data->base;
> > +
> > +     adev = &rdev->adev;
> > +     adev->name = clk_name;
> > +     adev->dev.parent = rst_data->dev;
> > +     adev->dev.release = npcm_clock_adev_release;
> > +     adev->id = 555u;
> > +
> > +     ret = auxiliary_device_init(adev);
> > +     if (ret) {
> > +             kfree(rdev);
> > +             return ERR_PTR(ret);
> > +     }
> > +
> > +     return adev;
> > +}
> > +
> > +static int npcm8xx_clock_controller_register(struct npcm_rc_data *rst_data, char *clk_name)
> > +{
> > +     struct auxiliary_device *adev;
> > +     int ret;
> > +
> > +     adev = npcm_clock_adev_alloc(rst_data, clk_name);
> > +     if (IS_ERR(adev))
> > +             return PTR_ERR(adev);
> > +
> > +     ret = auxiliary_device_add(adev);
> > +     if (ret) {
> > +             auxiliary_device_uninit(adev);
> > +             return ret;
> > +     }
> > +
> > +     return devm_add_action_or_reset(rst_data->dev, npcm_clock_unregister_adev, adev);
> > +}
> > +
> >  static int npcm_rc_probe(struct platform_device *pdev)
> >  {
> >       struct npcm_rc_data *rc;
> > @@ -392,6 +458,7 @@ static int npcm_rc_probe(struct platform_device *pdev)
> >       rc->rcdev.of_node = pdev->dev.of_node;
> >       rc->rcdev.of_reset_n_cells = 2;
> >       rc->rcdev.of_xlate = npcm_reset_xlate;
> > +     rc->dev = &pdev->dev;
> >
> >       ret = devm_reset_controller_register(&pdev->dev, &rc->rcdev);
> >       if (ret) {
> > @@ -413,7 +480,12 @@ static int npcm_rc_probe(struct platform_device *pdev)
> >               }
> >       }
> >
> > -     return ret;
> > +     switch (rc->info->bmc_id) {
> > +     case BMC_NPCM8XX:
>
> Here ret is ignored, which may be the return value from
> register_restart_handler() above.
>
> > +             return npcm8xx_clock_controller_register(rc, "clk-npcm8xx");
> > +     default:
> > +             return ret;
> > +     }
> >  }
> >
> >  static struct platform_driver npcm_rc_driver = {
> > diff --git a/include/soc/nuvoton/clock-npcm8xx.h b/include/soc/nuvoton/clock-npcm8xx.h
> > new file mode 100755
> > index 000000000000..139130e98c51
> > --- /dev/null
> > +++ b/include/soc/nuvoton/clock-npcm8xx.h
> > @@ -0,0 +1,16 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __SOC_NPCM8XX_CLOCK_H
> > +#define __SOC_NPCM8XX_CLOCK_H
> > +
> > +#include <linux/auxiliary_bus.h>
> > +#include <linux/container_of.h>
> > +
> > +struct npcm_clock_adev {
> > +     void __iomem *base;
> > +     struct auxiliary_device adev;
> > +};
> > +
> > +#define to_npcm_clock_adev(_adev) \
> > +     container_of((_adev), struct npcm_clock_adev, adev)
>
> Could you make this an inline function instead?
>
> With those two issues addressed,
>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
>
> regards
> Philipp

