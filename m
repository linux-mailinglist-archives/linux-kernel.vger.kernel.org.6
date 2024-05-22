Return-Path: <linux-kernel+bounces-185677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D7F8CB8D1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 04:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9399280F25
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 02:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB48C8F3;
	Wed, 22 May 2024 02:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZh18nux"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C7E1C680;
	Wed, 22 May 2024 02:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716343563; cv=none; b=dWKtdBacpue6kEUD+8ACUWU2BeWRihmoAod0g76gwfYLgdbRRc0M8qJGIAf3Em6L0z6j3joM2oxt1WZHLpa52kLHKzocjSECPxoHGGOHoE/imWl7IDBT/uYsnWkfsydajYgTzq/AIfLwjrJRZMv/UzikdrvL9REmCu26ikXUP5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716343563; c=relaxed/simple;
	bh=cqKCSGQGjMNfM+jf3RsqKDf/P5FOZraL0UthYMFVnMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ARDPuhkkua/W148N9kLQBiZLmjhG5zjVM+jGzDoAjyYXcnGO0HBeNYsMDsjIjk1lN4Oml11MpNbqT0idgakw75SmOGAaqhyXk++p6W8k7fJoVobj4DHfMvzYIz/1Z+MP1ctr1KNuZ9gVkiCUz4zze4wdBfzTEj1OnlDMAwiYyC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZh18nux; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-36c5d26045bso18977795ab.0;
        Tue, 21 May 2024 19:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716343560; x=1716948360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnv9v2c0E57wPW+4p8ZhEo1c9rdpxtiAjmB2vfpueB4=;
        b=SZh18nuxZ8p9faag6txKxy+Jh+J/6SCAkbSixsfgcdKpGOgyJo15gN+eLaBzkxRVFK
         uihcfyEM//C8Nm/7fQUJIDcaWWOBriwv4G9WQWFkQOizf+BeWSN53s/I+tDBXggF0W8M
         9N5ZAab2LjqHa2C0zz5iiZ8p66k6vQjXmQk30mLSyx1HZituHYj5VuNyGKPOQ42lGCSP
         AFRHECRb/VCk/1y1cL3RTREd4aqABGZRdTDwiEjop0NkCxBXxIgo6Am7ulW2ql22TjSQ
         TuhdWk240hsq1KbBNHEDZRFpGZhMy+HC0NUT2FF6rouN92BlhMSO4VPWtGP0Lz8+h5Jw
         DCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716343560; x=1716948360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xnv9v2c0E57wPW+4p8ZhEo1c9rdpxtiAjmB2vfpueB4=;
        b=tdjK832r2w9HJGfNLKv1vJFshOwm0ojXzy221D0HUPb3/acwSgykydNUk8FjE8njKl
         UZsesjFBjROTDT2xoo4kZXfdUDUghJNOdbT42Vv64RuzwDLGsKC87rtJcjitPQHyscO6
         ruueXezaxYior8essI0bwWPVqL+1Dq4mdWa/3xjGeXXynjF7Jw4J30mSp7wk4o/MzUhy
         K2EmUlgK45DorbKZZU6zqjIDF66P0u0guCHh02EGvjTYlinr38eN3wrbAl/yc23QwiEs
         1U+sqw5dD70+J+o/DZGnlChpHRaKffvbNGFd0sKbIRf2uSXezt6aIxeEM8BuhmhkDlHM
         Ge3g==
X-Forwarded-Encrypted: i=1; AJvYcCUdCmEigaXvxFR4qXAigYuxyT4tA72ACnUXwBEoRoRNPRUK0rhEqgOERQ7o+zuiRyxbpSGidxZZX2kknCWDuUtVa4HmuilgABng8sIwN8/uGpQ//fNRIdpn1Xe+P3KNB5b/WTu1Au1gLepUYhZ+jbSmEkqfLpizJDy9+g+wBTH86x0ZlQ==
X-Gm-Message-State: AOJu0Yz2wFMKmRaVuIXoaaBumTFMC1b5SoWhdbV9cTz9oyHtIDNCHCYB
	Lc2b6lcVAt4AughXslnvAwmPXI2XhhUjMlmiGJNhCyFJqeHitVAPD+TdfiMs9FtWf4LHkgdD5JQ
	HPhaFDQUTzHoxKSEXBHx3x/ciJqw=
X-Google-Smtp-Source: AGHT+IGWau/e/rvvgASCHQCUf6H0cfZp5gpvIsVjqT1ymyJTnGmjRGx0xCNX0GDTJQt5yWuYjLGL7jucwJ/sMEV6Jms=
X-Received: by 2002:a05:6e02:1c02:b0:36c:46bf:4afa with SMTP id
 e9e14a558f8ab-371f99f5e32mr8121285ab.6.1716343559715; Tue, 21 May 2024
 19:05:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1716188963-16175-1-git-send-email-shengjiu.wang@nxp.com>
 <1716188963-16175-3-git-send-email-shengjiu.wang@nxp.com> <Zktv3OcDbV1cggP1@lizhi-Precision-Tower-5810>
In-Reply-To: <Zktv3OcDbV1cggP1@lizhi-Precision-Tower-5810>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Wed, 22 May 2024 10:05:48 +0800
Message-ID: <CAA+D8AMajQn37bH1qrvuUBoUUowMPPwVztRfkCdg5AR8KC0muQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] clk: imx: clk-audiomix: Add reset controller
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

On Mon, May 20, 2024 at 11:44=E2=80=AFPM Frank Li <Frank.li@nxp.com> wrote:
>
> On Mon, May 20, 2024 at 03:09:20PM +0800, Shengjiu Wang wrote:
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
> >  drivers/clk/imx/clk-imx8mp-audiomix.c | 61 +++++++++++++++++++++++++++
> >  2 files changed, 62 insertions(+)
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
> > index b381d6f784c8..d2eaabe431cd 100644
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
> > @@ -217,6 +218,62 @@ struct clk_imx8mp_audiomix_priv {
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
> > +     struct auxiliary_device *adev;
> > +     int ret;
> > +
> > +     adev =3D kzalloc(sizeof(*adev), GFP_KERNEL);
>
>
> You may use scoped free
>
>         struct auxiliary_device *adev __free(kfree) =3D kzalloc(sizeof(*a=
dev), GFP_KERNEL);

Ok, will update the code

best regards
Shengjiu Wang
>
> > +     if (!adev)
> > +             return -ENOMEM;
> > +
> > +     adev->name =3D "reset";
> > +     adev->dev.parent =3D dev;
> > +     adev->dev.release =3D clk_imx8mp_audiomix_reset_adev_release;
> > +
> > +     ret =3D auxiliary_device_init(adev);
> > +     if (ret) {
> > +             kfree(adev);
> > +             return ret;
> > +     }
>
> if use scoped free,
>
>         if (ret)
>                 return ret;
>
> > +
> > +     ret =3D auxiliary_device_add(adev);
> > +     if (ret) {
> > +             auxiliary_device_uninit(adev);
> > +             kfree(adev);
> > +             return ret;
>
> the same here.
>
> > +     }
> > +
> > +     return devm_add_action_or_reset(dev, clk_imx8mp_audiomix_reset_un=
register_adev, adev);
>
> if use scope free
>         return devm_add_action_or_reset(dev, clk_imx8mp_audiomix_reset_un=
register_adev, no_free_ptr(adev));
>
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
> > @@ -337,6 +394,10 @@ static int clk_imx8mp_audiomix_probe(struct platfo=
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

