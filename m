Return-Path: <linux-kernel+bounces-188217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2F48CDF4B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 03:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A9511F230D7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 01:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1493F2231F;
	Fri, 24 May 2024 01:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X25gAqII"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28C163B8;
	Fri, 24 May 2024 01:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716515362; cv=none; b=MWGuHL1Bne6mIFKUSSXTg+rwwOhbxO/93KdV+IL5/fKQ9HsYl8gIEL7HyojxRfb7X8i9a1cLjxY0jnFMMCkmCm9Lsnja3tNSHELvC7bfeiffkR9nAzKojTU5Krkiy1U0i2weHvUUCbydWq8XaEFrSqGOovqYMxjQN6O77z1riig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716515362; c=relaxed/simple;
	bh=fOK2TCE5oDIMbTwzI9DfT0ukFf7sfhp16ruyzkZnJtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cylVhUSDAUJRRtOFtCn5K3NU1n6csuBbLbZLMdA1F05ysr9i6kM9AqeDeZohUM5Lhsfliun7rVmAyq+hE0QUUKQL2cV1IwK1On0Txr20SrSDIkGaiXMGH0t+42L+jyLzfhhKeVh8pNvIuheiJCH7eCJ5215GeS7GcxRhiNw8bzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X25gAqII; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3737b26657fso2162105ab.0;
        Thu, 23 May 2024 18:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716515360; x=1717120160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaHuh4+m6vv2JYkBPChLg2kvgbF787xvUsagVVKzGy4=;
        b=X25gAqIIN1YjBYrwcAcD824tq3Tf2sO6EVWmrKsuimaKJR7WH/7pB0U2/cqp0xRKx2
         29KEjdCiCx0JiY3qsD1me1sHOQhT5j2b1BoU4ck+rIL7RbxmT4m41DDiQcRaUwx3/PcZ
         k5v2qUBs2GVDk3x/kU4Sbx3GrXxy3Y0vspHiVhx4TzT/gzTJOYFtR9nBL/kTOghT5hC5
         /0P5SCp6prHrtQRjMdfO0/FqA3g6SWnpwAzJMoiDMDM0SaFPKRvrTLXH+o7E6+Dm49El
         ERyn6w1ze541VBKwZvAiqABBhgyBdeskkR+sTOQOX05q0QEqr3ek6TIKkxHxzwwIgOR+
         Yb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716515360; x=1717120160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QaHuh4+m6vv2JYkBPChLg2kvgbF787xvUsagVVKzGy4=;
        b=ucg4UgtEl41KEftqejY6VLcBInETagLyAr+09Jb55zUJt/Yud5ecEXikrsyVb6xVkL
         lXNbFgE8wgqRc/eOpTePnwJVLoUbJJl5l5VK/D7V66/u+LG8byBSqBgqgnGM+Ui+5YnJ
         9WMttVsezVVEnxoNVK3RJYQ8Jp/GFWMN3xW8Vx8U1d+n6anfrL4EMyMigMvQvmeukEUp
         Ov5UO6glQrREJQMZPJdR/aUj69KrN8g4/iaaMwCbM/0a79URfa5wZKSDPeoINnmd+r6C
         RSrLPXjfjJzQf+upKWlTicLFPCCFjsF9EoMLvBBkI8/GO30B9v5KorM8zrceQXk1SDVw
         Ne3A==
X-Forwarded-Encrypted: i=1; AJvYcCXs0O0XIyUFyaSk7JqLVwNoKaFNX2cVF0nnDpWoYerfktF9F65OUgCGQE78c9909zPYRkuhLkBIwjRymPv6oKJabvC09fm5aBJN8cOzsTaVpLjE/eK8B11lmKqFRWRsOz2Wah/86cdX1w041p+HeTiXKwZOujKXzPgSTlrmNCHCydwcMQ==
X-Gm-Message-State: AOJu0YzBXblQIds50KpvuglWCFSyPkycu9oOgSDSlsAZGvtJcR8MrjaT
	7mCFt9bfGRjFzQAdQ61scDuC8KR7N8PeYpL8G5OkNPWJSTQpwsyE8fS6aNd8Lyv6b+HwjGDFR/y
	hoeCyzA2gBhi4LGZdenBG+UH2Vjo=
X-Google-Smtp-Source: AGHT+IEK9vmj8neF4F55N645JBC1EaRdY3npShutVz5Cv3dOxwoge7Qm5GttoeiQi1A3WlSKb4Zn6OT23sNlHff/HF4=
X-Received: by 2002:a92:c249:0:b0:371:b5a7:e44c with SMTP id
 e9e14a558f8ab-3737b35f477mr10159775ab.25.1716515359840; Thu, 23 May 2024
 18:49:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1716458390-20120-1-git-send-email-shengjiu.wang@nxp.com>
 <1716458390-20120-3-git-send-email-shengjiu.wang@nxp.com> <Zk+oxAh9+c0RIQ/t@lizhi-Precision-Tower-5810>
In-Reply-To: <Zk+oxAh9+c0RIQ/t@lizhi-Precision-Tower-5810>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 24 May 2024 09:49:08 +0800
Message-ID: <CAA+D8ANOQ8Pgt8QZWduZoVKCcb8Mdc=Xzotu4zAqakTjHO8pBQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] clk: imx: clk-audiomix: Add reset controller
To: Frank Li <Frank.li@nxp.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org, peng.fan@nxp.com, 
	mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	marex@denx.de, linux-clk@vger.kernel.org, imx@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, p.zabel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 4:36=E2=80=AFAM Frank Li <Frank.li@nxp.com> wrote:
>
> On Thu, May 23, 2024 at 05:59:47PM +0800, Shengjiu Wang wrote:
> > Audiomix block control can be a reset controller for
> > Enhanced Audio Return Channel (EARC), which is one of
> > modules in this audiomix subsystem.
> >
> > The reset controller is supported by the auxiliary device
> > framework.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
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
> > index b381d6f784c8..2ee68f518850 100644
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
> > +     struct auxiliary_device __free(kfree) * adev =3D NULL;
>
> nit:  *adev =3D NULL;

Actually,  the checkpatch.pl told me need to have space after '*'...

Best regards
Shengjiu Wang

>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> > +     int ret;
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

