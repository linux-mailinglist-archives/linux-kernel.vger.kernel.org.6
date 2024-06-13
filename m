Return-Path: <linux-kernel+bounces-212987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 063A2906969
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FBAB1C22992
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97AB1411CE;
	Thu, 13 Jun 2024 09:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gc9UWQbl"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518291304AA;
	Thu, 13 Jun 2024 09:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718272496; cv=none; b=YYIx//dYhigempq6cyENvhS0dXc8AmsG+pn0pg2B/Kf5Mq8GaDpEY55UaQfsQoLxnMcjoGPb0a2BU4+oKn0jUoSffWIIy/X5E1NM3xyqQwlYNtznKrD4IeZl1/51mHGveuLUbItOmOBde44SwGm45UTtOmbRYwwa/nn3mfcrLBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718272496; c=relaxed/simple;
	bh=nyhD0QEQnN8q2PdwNwl3A2WK3my9sXc9o7+HfIXyEhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cYFBUKQg91KIa9VujSIU2/BoNgdvkdr8WDstilAozftdyNoMg/LjYQDUw6FQysTcSGhHC4CAdf2JvlD1IpceqxGYwxcn+Cqq6Nlzoh2vXXE7OOVrVxpZYN19iOu9xHfua7jxPfOSdSRaQYBa02bfUE4G24Jvj+/c7zHAkSnIMAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gc9UWQbl; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3737b412ad6so2773795ab.2;
        Thu, 13 Jun 2024 02:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718272494; x=1718877294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCTkK4uPvyN5EPmGILT+j3bzlqaQqHiiUqqzBMYByzw=;
        b=gc9UWQblb+7TEr7dxfsAwX9s34Wc/H5Tww87AvfXViDN41tC1LOb/1oAEskk0b7jD0
         6op/xBjKA6x1KUF6ADIhYypPsoL/gYwD6aI6PEj760DY7lv99gFaNQu4+bJ0aXlv4nLO
         p8UrX2lvcXJ9XV3N2oOqvBCOlppnWYEhyTLREI9em6uuTEu6Whpn/ZUbFotXf37KI7jF
         1JsjfcHlYLyiWoSo3XQMpUKtdt3Xqu61j+56E0PsOtJr/MShBE8QLgh5aPp7U1LJ69H0
         9pq9D4gB0VmWbL+bvoO0EKrfuN6N/JC1+fZ9QdOOP+0H+mah0lLWLzJS7Q8XchKXT7Zt
         LNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718272494; x=1718877294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aCTkK4uPvyN5EPmGILT+j3bzlqaQqHiiUqqzBMYByzw=;
        b=U1KXOcOFherf7kLFRSqttGbLeHu9z1RduryJrQeC05LwTQ1+uwZwvZXn6J0zJaSlOc
         kPQA8N4J4dVMiP8HO98fh6BFCy1sa+1tgb+w56kDO8WwPwRu3BaAQq+avsSQf/Q5s9kS
         xnAFfk6YPqey9BY8HjIdQj89vd6A/RHgkhkN4FtLxwhEHb+8NBtcVLLaMeOYjpEqVEHf
         bllK662//EHQuUbtHTGdZ83u9E139ICqN4OdRfWIYLvoAhlgQolp8sKRGB82e5yAMdRH
         B4lQGjN7GfMZYhTnIQfxzK40cbEHMScn7nwG6UM74L4VDBUuzxUhAisCVsC/mMRfx5cD
         yrLA==
X-Forwarded-Encrypted: i=1; AJvYcCUbiDZGCNuXI7tUWN4LLZosYU5wNBA40TOgMIQXRaY7I+7trvfy1vfaQw8oRKSR3Ah+3lIdjOeSaYe6gTphj7S6UW3Zh3kbkg0fk85tOkwlM8R6WxW/yD656xU1sUCsRjLOkOFFIXP9kGMopIp5m+twgv6xr7LQZlP28aW8t7Rjfx3qag==
X-Gm-Message-State: AOJu0YwLvZMb7If5tiylblln1TByuNwt+AxZLNo5NZ8/44+4gT5L/5Ck
	cM6zaMiSFQSowMvGxQLY43vF9h4HyNLJDuZmsNhIRkj6EpcaXvWUZ1xWPUbOGXdaND+G4kY/TPg
	mP7h4hh51pE34C4zZxsRtDyd0ah8=
X-Google-Smtp-Source: AGHT+IFkGYszJ8Pxt+FoagUvuCBZnHXe7jEhNqmAbHSu7AHwUCTs61Vo3LTkzuqt+xiaFuC26Hoyuoh1r6np/kDlF5M=
X-Received: by 2002:a92:cf11:0:b0:375:a04d:e1e0 with SMTP id
 e9e14a558f8ab-375cd1973edmr33811725ab.24.1718272494318; Thu, 13 Jun 2024
 02:54:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1718243482-18552-1-git-send-email-shengjiu.wang@nxp.com>
 <1718243482-18552-3-git-send-email-shengjiu.wang@nxp.com> <20240613081949.yty3hznopp3u2qwq@pengutronix.de>
 <CAA+D8AMc9=bzHKNXyMH5LLerr2kgmKTxacP=1LhocTHgP9Thfw@mail.gmail.com> <20240613093906.trc2rahodmhqd4lt@pengutronix.de>
In-Reply-To: <20240613093906.trc2rahodmhqd4lt@pengutronix.de>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Thu, 13 Jun 2024 17:54:43 +0800
Message-ID: <CAA+D8ANzP1hFGQ0HTtKmwDf4-RnAkZDxpQ5Uf1X7ObiAZGnvWw@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] clk: imx: clk-audiomix: Add reset controller
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, p.zabel@pengutronix.de, abelvesa@kernel.org, 
	peng.fan@nxp.com, mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	marex@denx.de, linux-clk@vger.kernel.org, imx@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 5:39=E2=80=AFPM Marco Felsch <m.felsch@pengutronix.=
de> wrote:
>
> On 24-06-13, Shengjiu Wang wrote:
> > On Thu, Jun 13, 2024 at 4:20=E2=80=AFPM Marco Felsch <m.felsch@pengutro=
nix.de> wrote:
> > >
> > > On 24-06-13, Shengjiu Wang wrote:
> > > > Audiomix block control can be a reset controller for
> > > > Enhanced Audio Return Channel (EARC), which is one of
> > > > modules in this audiomix subsystem.
> > > >
> > > > The reset controller is supported by the auxiliary device
> > > > framework.
> > > >
> > > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > >  drivers/clk/imx/Kconfig               |  1 +
> > > >  drivers/clk/imx/clk-imx8mp-audiomix.c | 63 +++++++++++++++++++++++=
++++
> > > >  2 files changed, 64 insertions(+)
> > > >
> > > > diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
> > > > index 6da0fba68225..9edfb030bea9 100644
> > > > --- a/drivers/clk/imx/Kconfig
> > > > +++ b/drivers/clk/imx/Kconfig
> > > > @@ -81,6 +81,7 @@ config CLK_IMX8MP
> > > >       tristate "IMX8MP CCM Clock Driver"
> > > >       depends on ARCH_MXC || COMPILE_TEST
> > > >       select MXC_CLK
> > > > +     select AUXILIARY_BUS
> > >
> > >         select AUXILIARY_BUS if RESET_CONTROLLER
> >
> > Do we really need this change?
> >
> > I checked other drivers like MCHP_CLK_MPFS, but they don't have
> > this condition also.
>
> Since you made the whole reset optional I would like to pull reset
> dependency optional as well e.g. pulling it only if you really use it.
> In the end the RESET_CONTROLLER is enabled most the time.

ok, will add it.

best regards
Shengjiu Wang
>
> > > >       help
> > > >           Build the driver for i.MX8MP CCM Clock Driver
> > > >
> > > > diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/im=
x/clk-imx8mp-audiomix.c
> > > > index b381d6f784c8..517b1f88661b 100644
> > > > --- a/drivers/clk/imx/clk-imx8mp-audiomix.c
> > > > +++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
> > > > @@ -5,6 +5,7 @@
> > > >   * Copyright (C) 2022 Marek Vasut <marex@denx.de>
> > > >   */
> > > >
> > > > +#include <linux/auxiliary_bus.h>
> > > >  #include <linux/clk-provider.h>
> > > >  #include <linux/device.h>
> > > >  #include <linux/io.h>
> > > > @@ -13,6 +14,7 @@
> > > >  #include <linux/of.h>
> > > >  #include <linux/platform_device.h>
> > > >  #include <linux/pm_runtime.h>
> > > > +#include <linux/slab.h>
> > >                 ^
> > > This is an unrelated change.
> >
> > This is for the fix of this issue
> >
> > https://lore.kernel.org/oe-kbuild-all/202405201844.zf7UkDmq-lkp@intel.c=
om/
>
> Thanks for the link.
>
> Regards,
>   Marco
>
> > Best regards
> > Shengjiu wang
> >
> > >
> > > Regards,
> > >   Marco
> > >
> > > >
> > > >  #include <dt-bindings/clock/imx8mp-clock.h>
> > > >
> > > > @@ -217,6 +219,63 @@ struct clk_imx8mp_audiomix_priv {
> > > >       struct clk_hw_onecell_data clk_data;
> > > >  };
> > > >
> > > > +#if IS_ENABLED(CONFIG_RESET_CONTROLLER)
> > > > +
> > > > +static void clk_imx8mp_audiomix_reset_unregister_adev(void *_adev)
> > > > +{
> > > > +     struct auxiliary_device *adev =3D _adev;
> > > > +
> > > > +     auxiliary_device_delete(adev);
> > > > +     auxiliary_device_uninit(adev);
> > > > +}
> > > > +
> > > > +static void clk_imx8mp_audiomix_reset_adev_release(struct device *=
dev)
> > > > +{
> > > > +     struct auxiliary_device *adev =3D to_auxiliary_dev(dev);
> > > > +
> > > > +     kfree(adev);
> > > > +}
> > > > +
> > > > +static int clk_imx8mp_audiomix_reset_controller_register(struct de=
vice *dev,
> > > > +                                                      struct clk_i=
mx8mp_audiomix_priv *priv)
> > > > +{
> > > > +     struct auxiliary_device *adev __free(kfree) =3D NULL;
> > > > +     int ret;
> > > > +
> > > > +     if (!of_property_present(dev->of_node, "#reset-cells"))
> > > > +             return 0;
> > > > +
> > > > +     adev =3D kzalloc(sizeof(*adev), GFP_KERNEL);
> > > > +     if (!adev)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     adev->name =3D "reset";
> > > > +     adev->dev.parent =3D dev;
> > > > +     adev->dev.release =3D clk_imx8mp_audiomix_reset_adev_release;
> > > > +
> > > > +     ret =3D auxiliary_device_init(adev);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     ret =3D auxiliary_device_add(adev);
> > > > +     if (ret) {
> > > > +             auxiliary_device_uninit(adev);
> > > > +             return ret;
> > > > +     }
> > > > +
> > > > +     return devm_add_action_or_reset(dev, clk_imx8mp_audiomix_rese=
t_unregister_adev,
> > > > +                                     no_free_ptr(adev));
> > > > +}
> > > > +
> > > > +#else /* !CONFIG_RESET_CONTROLLER */
> > > > +
> > > > +static int clk_imx8mp_audiomix_reset_controller_register(struct cl=
k_imx8mp_audiomix_priv *priv)
> > > > +{
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +#endif /* !CONFIG_RESET_CONTROLLER */
> > > > +
> > > >  static void clk_imx8mp_audiomix_save_restore(struct device *dev, b=
ool save)
> > > >  {
> > > >       struct clk_imx8mp_audiomix_priv *priv =3D dev_get_drvdata(dev=
);
> > > > @@ -337,6 +396,10 @@ static int clk_imx8mp_audiomix_probe(struct pl=
atform_device *pdev)
> > > >       if (ret)
> > > >               goto err_clk_register;
> > > >
> > > > +     ret =3D clk_imx8mp_audiomix_reset_controller_register(dev, pr=
iv);
> > > > +     if (ret)
> > > > +             goto err_clk_register;
> > > > +
> > > >       pm_runtime_put_sync(dev);
> > > >       return 0;
> > > >
> > > > --
> > > > 2.34.1
> > > >
> > > >
> > > >
> >

