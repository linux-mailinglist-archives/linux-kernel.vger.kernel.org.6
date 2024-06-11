Return-Path: <linux-kernel+bounces-209187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF8E902E74
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 04:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5DA7B22DEA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 02:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BEF16F859;
	Tue, 11 Jun 2024 02:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cv0kkC45"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0DA16F847;
	Tue, 11 Jun 2024 02:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718073305; cv=none; b=MLhBAN2a5Y/4bPKdBeRWfOt+rovKBTtPNA42vIsPeV8cDFHfjEMaDAWmUMkQoUqeZrqOSE+8Tts02U2CU7Q+6fPWiIq5lorw9D8SY0z8xXK5/YCFcY3nUpsFyiphJEd0XXqCaCCwGDjVim8otY9HVDR5QoqA5hLosMqYDGVEhS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718073305; c=relaxed/simple;
	bh=uX23ExG6CnBtKrCFcOoTf4iiV2uXPJwIj4H+fGp/ph8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L87jCjGmJOe10UKSzQGQ3SW0aZ3WeQg3fZYaBLtI2H0iFaukcAds1ZwF0wINFkF/aRyOpOlYOkxmRU/mvX8a5kFm5b2TIb/zhtGkdpc+dKZe1DruhWeKFsjnylPIIQbPLcOvnu+O3GWJpA2C2YuMujhTNkJmZMNbJBr8qjVisKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cv0kkC45; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3737dc4a669so3109545ab.0;
        Mon, 10 Jun 2024 19:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718073302; x=1718678102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Gfi1U2YocN7eKZd+4TAjGD3Blv7pzKIBpTmBX7SoCw=;
        b=Cv0kkC45AbIB8qZfkBxjGB/uY47FiMFZ4m/BFpOa806f7BkXLME3lDBp9vER5wzQXb
         LwBIxi6sBmgjOhG93kzB1dtXb+sxe56ZtwbpcZVquNBHPSfaTG5g0S79Wd0VUkrV81Xw
         zSNHTZgMEhwG28xwYaQswNaW8rk5yYtHViFe/+pSw63kBP02ytPNXaKhmpSMBa3Hu4BT
         c1F2d0+KVrSGcTVt5+rR6g6++MWZCftdQ8CAo0/sggVsjUKDx6StSQAkZdsHk0FNaA2u
         vZWA7ynpyIoKwQEPStrIPAZBUWqnIIw3v8NJdgwAm3e4+fea3a4RLHF4nSPAAmPdNdbQ
         AMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718073302; x=1718678102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Gfi1U2YocN7eKZd+4TAjGD3Blv7pzKIBpTmBX7SoCw=;
        b=Awg0PF22R6SYi/wbjiIrnzPFZv6ri2KLR2qqO2IN+eh7zFS04qc7wDWhwisNLdgnhV
         fXhhGisdyNZ2ipC5iARq2HLmLdAlsgvRIGPDK7AJlmzRq7mxYb4Xz7yNXyD6pgpxByoK
         2XAk1oymQMqxOlPYDMMUeeJ67Z86dxkivFWroVqbKgQLMk2KwBwJO2D1x1nTDstR2dtK
         sbyTjbtuXvFDp3kTO1KS52YyjV+48IUDadYZovm7fZL7PrCT1QcxlsB3m0UwK41ugSUG
         MusXw9s9uRELXyvdkBzjiAb442hpn0HGwOu6Rhqqm6qa+8Q9SkmEmN0BL0xoJykpmApK
         Gd6w==
X-Forwarded-Encrypted: i=1; AJvYcCUrqxG3yyYtwx1Ba+D6wpWhdcIFrPc/5jPLu/6dmKQJiHDWIW9qmt3ml0bii+VgTH3pXakUYZRhRHR+tXdtkDW2HtxR6pUPimP1nJTGho2T+AqlEnmPxSDzR7Tv4JxFDWL2VUnXw5zopWmbwGoBpL7AIR/3vYCwlSk6QSf30HBOEHhOig==
X-Gm-Message-State: AOJu0YxGZUVVuVHKtExYT5pXXqhs6HKS0r4mx0CQHM67GKtgKrD/44gW
	8IBhTHSNlVDT4f/T94jc8YeqZSzfWa+UFT9gcwa0U2IKFcjRVvD7OAxBWxb7w9DnhRUu3LEWtMQ
	bV5wl9Kx1ffzR/ns7oKsPNqraX8U=
X-Google-Smtp-Source: AGHT+IFMzXCoGvT54xrVUmElOG6ITA/pDCGx5P7kEv4zMKFvgLbChT4GvzIFhyASquV0eQSJFmz3vN3JDrgQJHAkFK0=
X-Received: by 2002:a92:dac1:0:b0:375:88ec:811b with SMTP id
 e9e14a558f8ab-37588ec880emr95209215ab.10.1718073301702; Mon, 10 Jun 2024
 19:35:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1717036278-3515-1-git-send-email-shengjiu.wang@nxp.com>
 <1717036278-3515-3-git-send-email-shengjiu.wang@nxp.com> <20240530085115.ttmzx4dve4x6nep2@pengutronix.de>
In-Reply-To: <20240530085115.ttmzx4dve4x6nep2@pengutronix.de>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 11 Jun 2024 10:34:50 +0800
Message-ID: <CAA+D8AP++bNzE4cccKP_NaxDK-MWN3jtkcB_P5jj0tNiZYYFSg@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] clk: imx: clk-audiomix: Add reset controller
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

On Thu, May 30, 2024 at 4:51=E2=80=AFPM Marco Felsch <m.felsch@pengutronix.=
de> wrote:
>
> On 24-05-30, Shengjiu Wang wrote:
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
> >  drivers/clk/imx/clk-imx8mp-audiomix.c | 60 +++++++++++++++++++++++++++
> >  2 files changed, 61 insertions(+)
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
> >       help
> >           Build the driver for i.MX8MP CCM Clock Driver
> >
> > diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/cl=
k-imx8mp-audiomix.c
> > index b381d6f784c8..a3dc2f3606ee 100644
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
> >
> >  #include <dt-bindings/clock/imx8mp-clock.h>
> >
> > @@ -217,6 +219,60 @@ struct clk_imx8mp_audiomix_priv {
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
>
> Since the reset-controller is optional you need to check the existence
> of the '#reset-cells' property before you register it.
>

ok, will add it.

best regards
Shengjiu Wang

> Regards,
>   Marco
>
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
> > @@ -337,6 +393,10 @@ static int clk_imx8mp_audiomix_probe(struct platfo=
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

