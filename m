Return-Path: <linux-kernel+bounces-249732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0CC92EF1A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E965F283AA2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BFE16EB5B;
	Thu, 11 Jul 2024 18:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmWBJHUn"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3089816E88D;
	Thu, 11 Jul 2024 18:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720723594; cv=none; b=JwG08d+rtMNFrx9aF+aBL5vVIfw/i8PBftwXRco+du75z6GJ/e/2V/U1QGxcpCx0lHsoOXpAF+DwDvdTSUBHW5yfYKKftNLLna31IbIVeQxkp1czd/1sF24OhmSrsgO8nC/TGqIr5cuurV0oltFBlOQ7XH19jJ574H237MVnYUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720723594; c=relaxed/simple;
	bh=g1szUU6O5h5jZ13hX7mdGpmDkL9RT5EpovYh9YOU2+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ag9HAA8TvgP4KMEb6QQ1d2pqHv/fqU8+tyRBOVBQ/iZSiFRops2d53XMEbVIyg70McYX9fdcSMJ1dSYgzcyyBY4HpqbqCR4yGcovEM9SXXBNx+chKBgx3+XOoPtYKvkYq0V4INu0R90uBpMMZUsB8fZFKuAcmQxpVQGk+WCF5Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmWBJHUn; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-63036fa87dbso8736827b3.1;
        Thu, 11 Jul 2024 11:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720723591; x=1721328391; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7AnrZ08vTP6o9S9SQ4qP+LVla/5fbZ409g1w9Y/pgfo=;
        b=RmWBJHUnn6CFV8Bc1eIEGWZF7UeDRYfKZi4QRTSauZUQmrJ9CzTAZYq7anX8gUBkGL
         IFJz5eawl0YA+zlZzwHzTw91MoGv/6B44N0rjviUcsoGGCKFSllskdInQwnWMsaegY33
         LWKNaIGXsZzNmQ2AK2Lzhd1fweGCJRwO67nwirjwaNrCDv+S3SmDYUIyOy9w3Zn1NAY+
         EJL2jpUT54jpAoReo2f1dXT9VV07Aix5MuUPyaIS36Ca0z1MeTpMZ7ymtven3TDeQsSH
         WlUbNXKgK7sEi1ObKWmU6TVSl1BkY8L8cp9Hm3p8Sul/r9MU1ygFPfzg8V8T3nTP6crG
         xAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720723591; x=1721328391;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7AnrZ08vTP6o9S9SQ4qP+LVla/5fbZ409g1w9Y/pgfo=;
        b=bF0YAPZPg23g/yIWBWzM3cPjiIDI9ylM1No3kWj6yQ/PlCTLpCT3Io91Hu9EE9YO8Y
         xwfHGlc1xm5nUcYtsVt7+Gu5O7mSki6wf9PTyH7gHhu7H6MpRTrwUq61HwI4rnp5hXIw
         Lj7Cvp7qKG6g2zAXw23La58SacPYhShMhJrZYGJeDeWuuVV9b3L5dA28kh2TGzbIugzL
         CxbnQ4ce/b3e46WNECxmfmh6hHli9+NFrQVbMvcj2Ia+vV0UftD74iF5TvPIcnKM48VH
         rCu2b4YbzI+L9Q3+Xklmg9g04YCY1ewmSP2mXrL+Kk+22R250Rlt1YCBVRNGV+m2jRLX
         +m6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXV3BYi1ToaGhOcuflXV+V5ccxHj+vC1RNPQDkUMHkMbW8uomS0ad06hL1NH5APBypXfAbytdnFxBSNON4XzAV0nrY78KeqndFW+c9UrgtmcemiJ4MQz7ai0EkIfls17F+6QI9ICnNy4zDz0N23nNUsbyxSK/n0XGVfT58V6ZybKTFWIg==
X-Gm-Message-State: AOJu0Yxp3nuXrSicHwGjLsIk+P7eBAqKxOvZZHn63OAHbc8OGuT6hc0f
	Blz6x2nFDMpaiRKm3woHsis/Bm3ZWZI2hkAlu/T+54/b5gdY+eFj6ezwXYnAEZ0Rp/Bx70+4r6m
	loUaIk/xBkYqWi46Y8flGq7tpei4=
X-Google-Smtp-Source: AGHT+IHyLGQM0uxkb0nc5QlB4xpEbd2pIqu3s2+nZvwNa5poPdc6GJlQIotFJGHAEgTCVpB/d8dZ/M0Dd5AajU7oZKg=
X-Received: by 2002:a05:690c:6385:b0:64b:82d6:75b9 with SMTP id
 00721157ae682-65dfcf9ba67mr4192027b3.7.1720723591129; Thu, 11 Jul 2024
 11:46:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702191650.57364-1-tmaimon77@gmail.com> <20240702191650.57364-3-tmaimon77@gmail.com>
 <CADKL2t4F20iFdwxDH0PXCa8-HO_cDhYzu+ObyzwaazWWkKj-tg@mail.gmail.com>
In-Reply-To: <CADKL2t4F20iFdwxDH0PXCa8-HO_cDhYzu+ObyzwaazWWkKj-tg@mail.gmail.com>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Thu, 11 Jul 2024 21:46:20 +0300
Message-ID: <CAP6Zq1irF7iZkH6kTCfTNRWY0bzoRv5W65QKwXyDCfUU5TrQCA@mail.gmail.com>
Subject: Re: [PATCH v26 2/3] reset: npcm: register npcm8xx clock auxiliary bus device
To: Benjamin Fair <benjaminfair@google.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, tali.perry1@gmail.com, 
	joel@jms.id.au, venture@google.com, yuenn@google.com, 
	openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Benjamin,

Highly appreciated!

Thanks a lot

Tomer

On Thu, 11 Jul 2024 at 21:13, Benjamin Fair <benjaminfair@google.com> wrote:
>
> On Tue, 2 Jul 2024 at 12:17, Tomer Maimon <tmaimon77@gmail.com> wrote:
> >
> > Add NPCM8xx clock controller auxiliary bus device registration.
> >
> > The NPCM8xx clock controller is registered as an aux device because the
> > reset and the clock controller share the same register region.
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
>
> I booted a kernel with this driver and verified that basic
> functionality works fine.
>
> Tested-by: Benjamin Fair <benjaminfair@google.com>
>
> > ---
> >  drivers/reset/Kconfig               |  1 +
> >  drivers/reset/reset-npcm.c          | 74 ++++++++++++++++++++++++++++-
> >  include/soc/nuvoton/clock-npcm8xx.h | 16 +++++++
> >  3 files changed, 90 insertions(+), 1 deletion(-)
> >  create mode 100644 include/soc/nuvoton/clock-npcm8xx.h
> >
> > diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> > index 7112f5932609..31ec8795c105 100644
> > --- a/drivers/reset/Kconfig
> > +++ b/drivers/reset/Kconfig
> > @@ -148,6 +148,7 @@ config RESET_MESON_AUDIO_ARB
> >  config RESET_NPCM
> >         bool "NPCM BMC Reset Driver" if COMPILE_TEST
> >         default ARCH_NPCM
> > +       select AUXILIARY_BUS
> >         help
> >           This enables the reset controller driver for Nuvoton NPCM
> >           BMC SoCs.
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
> >  #define NPCM_MDLR_OFFSET       0x7C
> >  #define NPCM7XX_MDLR_USBD0     BIT(9)
> > @@ -89,6 +93,7 @@ struct npcm_rc_data {
> >         const struct npcm_reset_info *info;
> >         struct regmap *gcr_regmap;
> >         u32 sw_reset_number;
> > +       struct device *dev;
> >         void __iomem *base;
> >         spinlock_t lock;
> >  };
> > @@ -372,6 +377,67 @@ static const struct reset_control_ops npcm_rc_ops = {
> >         .status         = npcm_rc_status,
> >  };
> >
> > +static void npcm_clock_unregister_adev(void *_adev)
> > +{
> > +       struct auxiliary_device *adev = _adev;
> > +
> > +       auxiliary_device_delete(adev);
> > +       auxiliary_device_uninit(adev);
> > +}
> > +
> > +static void npcm_clock_adev_release(struct device *dev)
> > +{
> > +       struct auxiliary_device *adev = to_auxiliary_dev(dev);
> > +       struct npcm_clock_adev *rdev = to_npcm_clock_adev(adev);
> > +
> > +       kfree(rdev);
> > +}
> > +
> > +static struct auxiliary_device *npcm_clock_adev_alloc(struct npcm_rc_data *rst_data, char *clk_name)
> > +{
> > +       struct npcm_clock_adev *rdev;
> > +       struct auxiliary_device *adev;
> > +       int ret;
> > +
> > +       rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
> > +       if (!rdev)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       rdev->base = rst_data->base;
> > +
> > +       adev = &rdev->adev;
> > +       adev->name = clk_name;
> > +       adev->dev.parent = rst_data->dev;
> > +       adev->dev.release = npcm_clock_adev_release;
> > +       adev->id = 555u;
> > +
> > +       ret = auxiliary_device_init(adev);
> > +       if (ret) {
> > +               kfree(rdev);
> > +               return ERR_PTR(ret);
> > +       }
> > +
> > +       return adev;
> > +}
> > +
> > +static int npcm8xx_clock_controller_register(struct npcm_rc_data *rst_data, char *clk_name)
> > +{
> > +       struct auxiliary_device *adev;
> > +       int ret;
> > +
> > +       adev = npcm_clock_adev_alloc(rst_data, clk_name);
> > +       if (IS_ERR(adev))
> > +               return PTR_ERR(adev);
> > +
> > +       ret = auxiliary_device_add(adev);
> > +       if (ret) {
> > +               auxiliary_device_uninit(adev);
> > +               return ret;
> > +       }
> > +
> > +       return devm_add_action_or_reset(rst_data->dev, npcm_clock_unregister_adev, adev);
> > +}
> > +
> >  static int npcm_rc_probe(struct platform_device *pdev)
> >  {
> >         struct npcm_rc_data *rc;
> > @@ -392,6 +458,7 @@ static int npcm_rc_probe(struct platform_device *pdev)
> >         rc->rcdev.of_node = pdev->dev.of_node;
> >         rc->rcdev.of_reset_n_cells = 2;
> >         rc->rcdev.of_xlate = npcm_reset_xlate;
> > +       rc->dev = &pdev->dev;
> >
> >         ret = devm_reset_controller_register(&pdev->dev, &rc->rcdev);
> >         if (ret) {
> > @@ -413,7 +480,12 @@ static int npcm_rc_probe(struct platform_device *pdev)
> >                 }
> >         }
> >
> > -       return ret;
> > +       switch (rc->info->bmc_id) {
> > +       case BMC_NPCM8XX:
> > +               return npcm8xx_clock_controller_register(rc, "clk-npcm8xx");
> > +       default:
> > +               return ret;
> > +       }
> >  }
> >
> >  static struct platform_driver npcm_rc_driver = {
> > diff --git a/include/soc/nuvoton/clock-npcm8xx.h b/include/soc/nuvoton/clock-npcm8xx.h
> > new file mode 100644
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
> > +       void __iomem *base;
> > +       struct auxiliary_device adev;
> > +};
> > +
> > +#define to_npcm_clock_adev(_adev) \
> > +       container_of((_adev), struct npcm_clock_adev, adev)
> > +
> > +#endif
> > --
> > 2.34.1
> >

