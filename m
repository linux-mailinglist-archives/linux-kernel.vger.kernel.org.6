Return-Path: <linux-kernel+bounces-212935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C2B90686D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB51B1C21156
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F56113E020;
	Thu, 13 Jun 2024 09:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLiZJBkI"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4018E13D26B;
	Thu, 13 Jun 2024 09:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718270431; cv=none; b=E1FW7N/lZZV6GAtRqXbUWNayvGtF1D9N0vWxfkPandNFw0zGGOawtR2Qt2ApWTDQx0h+Qnu45znqPZyoZcMQ6RNpb2dwQd4Qvb5Xblkg6SuB6wHqGo42fsMJC8lfzuoFkmv2UG7qbOufpcGNifuN2IHXqHtCegTd9Om8oMZ826Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718270431; c=relaxed/simple;
	bh=nwIWyEx/7teWV5FWMzmwa4MnROj8ZAkaiOIAWcLazkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MfRvNEQcvJoLtKwXg5lVyiCcfsU0FGkC/HhNJOp8oxES2NTPXMnnlVJ44JSHVVnolqn8cobO/N413CR9zbkg/67MjqAcQ6IFB+OSOq3xrwI7qRtWsUM5hymRqdtzwvu5iHCIC5waVnR9fDKXJvHRgh24kJpC52SCMlMOrtC4jeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLiZJBkI; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7ebcc7676c3so29358339f.0;
        Thu, 13 Jun 2024 02:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718270429; x=1718875229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csLKQFD6Tcenf8eJdKO/adEt8f/6C41cqRO+iDbL3zg=;
        b=DLiZJBkIUF/b7O2Jrl9dC6ElNDHBZw6QcZL6HCM4WAn/vhrjNToRGDdlrRIiuwryYs
         VXF4IepebRLt4J7YiZDd6/2qaUedwRoJFKPmIgStdN+LFVUtjfTW90g82NWoQam2lP4p
         oWIvF4QjmQhr5zd1QXUrLwj8mpz1eV60232KZ2r2kYp2PZwhc3rgEh1LfBVZC1/ugTFy
         rAFGn+qFEsD9mLCOfyRbB4wB3SKK0lMA4h7c5n9vxFml0Tg86XlJqzs4B1JzWJiPwWuy
         ua79jybPAL8jrVvfQp9aUemdvcti5SdRvOxLRwlOFCy07HtFSouF1A2w6oxc4GN/H3wd
         /68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718270429; x=1718875229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=csLKQFD6Tcenf8eJdKO/adEt8f/6C41cqRO+iDbL3zg=;
        b=nOUXetTsDUuzooZ94h/AGGcEX3o6O8Aop7l1N/iDXnL4ocC6ESzqeR+ZNnNMpL9LGI
         LJBu9kGLdm2fVlwkdATNNnjzZGj0HaulU6O6aghHESKeJ9GOgwIxgqKV9WH788c1Cx+c
         VjhzUqSgGQu+6BPF+/k5y72HsceTH+SsW4QQQrp3SYwycsdLpMd4kWtlWB5T1Z97LZku
         qeOL1G+7Bxjrc91xBRSQpIHU4XVo2hgOAhwpuckKX50q1v0cyUNjHkP02VHwZafqL9/O
         vKZoqVs4daZYKCf/MAyTfYOrVoTMwJcPjwlg8w8yChCopC/SYiZnXYCot5Cka/9s2Gut
         I1LA==
X-Forwarded-Encrypted: i=1; AJvYcCUaKM5tQqyQS3rGR04DgW75EVW24CbTpccbEHO2t5X3DKH8U5va7QL20k8MVJF7ZI8iniAicqoa3n3ysGgMBsHd0fN33bFLZKuFGInKNdmoI1BkOHK+Cf2gSjSdADCoxHWLBkMRBr2RLVfp7BNhib2lXGwtM4Nir0tloKw0/DofSW0NNw==
X-Gm-Message-State: AOJu0YxS+JDoVNxu7MxiVui8GXdJ0sl1lrEyh8WanZnWGijaWcZzJScA
	79mQ4Z7R4EhPaDfXoq1qo2QU+mPwfQ3Ls3hOPX8bmFOJj1nTbWhAzM5r2aeUxDRzLASX+wGoU84
	MKfsFzuB54MWb3OW1H0GgPnBgK8g=
X-Google-Smtp-Source: AGHT+IFed9H5JM1SrGJtb2+Kf28Ibrp0V6KX2iqKvtXKbBzLKEMT/llRVLx61dEjDWZmVwx1MrI8K71JhP7Jr+l1hlY=
X-Received: by 2002:a92:ca06:0:b0:375:a994:6de0 with SMTP id
 e9e14a558f8ab-375cd177970mr48444765ab.13.1718270429288; Thu, 13 Jun 2024
 02:20:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1718243482-18552-1-git-send-email-shengjiu.wang@nxp.com>
 <1718243482-18552-3-git-send-email-shengjiu.wang@nxp.com> <20240613081949.yty3hznopp3u2qwq@pengutronix.de>
In-Reply-To: <20240613081949.yty3hznopp3u2qwq@pengutronix.de>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Thu, 13 Jun 2024 17:20:18 +0800
Message-ID: <CAA+D8AMc9=bzHKNXyMH5LLerr2kgmKTxacP=1LhocTHgP9Thfw@mail.gmail.com>
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

On Thu, Jun 13, 2024 at 4:20=E2=80=AFPM Marco Felsch <m.felsch@pengutronix.=
de> wrote:
>
> On 24-06-13, Shengjiu Wang wrote:
> > Audiomix block control can be a reset controller for
> > Enhanced Audio Return Channel (EARC), which is one of
> > modules in this audiomix subsystem.
> >
> > The reset controller is supported by the auxiliary device
> > framework.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/clk/imx/Kconfig               |  1 +
> >  drivers/clk/imx/clk-imx8mp-audiomix.c | 63 +++++++++++++++++++++++++++
> >  2 files changed, 64 insertions(+)
> >
> > diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
> > index 6da0fba68225..9edfb030bea9 100644
> > --- a/drivers/clk/imx/Kconfig
> > +++ b/drivers/clk/imx/Kconfig
> > @@ -81,6 +81,7 @@ config CLK_IMX8MP
> >       tristate "IMX8MP CCM Clock Driver"
> >       depends on ARCH_MXC || COMPILE_TEST
> >       select MXC_CLK
> > +     select AUXILIARY_BUS
>
>         select AUXILIARY_BUS if RESET_CONTROLLER

Do we really need this change?

I checked other drivers like MCHP_CLK_MPFS, but they don't have
this condition also.

>
> >       help
> >           Build the driver for i.MX8MP CCM Clock Driver
> >
> > diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/cl=
k-imx8mp-audiomix.c
> > index b381d6f784c8..517b1f88661b 100644
> > --- a/drivers/clk/imx/clk-imx8mp-audiomix.c
> > +++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
> > @@ -5,6 +5,7 @@
> >   * Copyright (C) 2022 Marek Vasut <marex@denx.de>
> >   */
> >
> > +#include <linux/auxiliary_bus.h>
> >  #include <linux/clk-provider.h>
> >  #include <linux/device.h>
> >  #include <linux/io.h>
> > @@ -13,6 +14,7 @@
> >  #include <linux/of.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pm_runtime.h>
> > +#include <linux/slab.h>
>                 ^
> This is an unrelated change.

This is for the fix of this issue

https://lore.kernel.org/oe-kbuild-all/202405201844.zf7UkDmq-lkp@intel.com/

Best regards
Shengjiu wang

>
> Regards,
>   Marco
>
> >
> >  #include <dt-bindings/clock/imx8mp-clock.h>
> >
> > @@ -217,6 +219,63 @@ struct clk_imx8mp_audiomix_priv {
> >       struct clk_hw_onecell_data clk_data;
> >  };
> >
> > +#if IS_ENABLED(CONFIG_RESET_CONTROLLER)
> > +
> > +static void clk_imx8mp_audiomix_reset_unregister_adev(void *_adev)
> > +{
> > +     struct auxiliary_device *adev =3D _adev;
> > +
> > +     auxiliary_device_delete(adev);
> > +     auxiliary_device_uninit(adev);
> > +}
> > +
> > +static void clk_imx8mp_audiomix_reset_adev_release(struct device *dev)
> > +{
> > +     struct auxiliary_device *adev =3D to_auxiliary_dev(dev);
> > +
> > +     kfree(adev);
> > +}
> > +
> > +static int clk_imx8mp_audiomix_reset_controller_register(struct device=
 *dev,
> > +                                                      struct clk_imx8m=
p_audiomix_priv *priv)
> > +{
> > +     struct auxiliary_device *adev __free(kfree) =3D NULL;
> > +     int ret;
> > +
> > +     if (!of_property_present(dev->of_node, "#reset-cells"))
> > +             return 0;
> > +
> > +     adev =3D kzalloc(sizeof(*adev), GFP_KERNEL);
> > +     if (!adev)
> > +             return -ENOMEM;
> > +
> > +     adev->name =3D "reset";
> > +     adev->dev.parent =3D dev;
> > +     adev->dev.release =3D clk_imx8mp_audiomix_reset_adev_release;
> > +
> > +     ret =3D auxiliary_device_init(adev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D auxiliary_device_add(adev);
> > +     if (ret) {
> > +             auxiliary_device_uninit(adev);
> > +             return ret;
> > +     }
> > +
> > +     return devm_add_action_or_reset(dev, clk_imx8mp_audiomix_reset_un=
register_adev,
> > +                                     no_free_ptr(adev));
> > +}
> > +
> > +#else /* !CONFIG_RESET_CONTROLLER */
> > +
> > +static int clk_imx8mp_audiomix_reset_controller_register(struct clk_im=
x8mp_audiomix_priv *priv)
> > +{
> > +     return 0;
> > +}
> > +
> > +#endif /* !CONFIG_RESET_CONTROLLER */
> > +
> >  static void clk_imx8mp_audiomix_save_restore(struct device *dev, bool =
save)
> >  {
> >       struct clk_imx8mp_audiomix_priv *priv =3D dev_get_drvdata(dev);
> > @@ -337,6 +396,10 @@ static int clk_imx8mp_audiomix_probe(struct platfo=
rm_device *pdev)
> >       if (ret)
> >               goto err_clk_register;
> >
> > +     ret =3D clk_imx8mp_audiomix_reset_controller_register(dev, priv);
> > +     if (ret)
> > +             goto err_clk_register;
> > +
> >       pm_runtime_put_sync(dev);
> >       return 0;
> >
> > --
> > 2.34.1
> >
> >
> >

