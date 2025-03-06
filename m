Return-Path: <linux-kernel+bounces-549831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82576A557BB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F3851888622
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1116D1FCFCA;
	Thu,  6 Mar 2025 20:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N81foBq1"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5D81A2C3A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 20:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294035; cv=none; b=EBUmOnU8H/Z0mo7JwMwpGj2fdpIs/D8EPpgzneiWat4Jp1vjQsDwORrTAgE/zmi+mZxugvP/AEZfepo9itO+R8fXACCpykORz5usYqYSwW8trdsGd/OeI66wJCGn4jvK/epdpi1/TUTQ8o9dBiLlF3+4jPpnJIZICFhd234KooI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294035; c=relaxed/simple;
	bh=F/yTe+7ytDx5TVsg6P6mwWif48KiQU3byslKQvjC9KI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ca+7ikaNBNaYMp4AZz5/IzGY1vgsGX2ENerxEn+nxILKRq/tiouODQMSC+Msnn8qfXfkJLXzKAEqwYRJmEmlo0jV1/MHdhaycXUSkR7bdNszGePl7vO4IfC12rm4hqAXkpZ7QqH1r/7bLSU4BFPuNtRRJvlg/jIcsu88mIb0E5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N81foBq1; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3f66dfc205dso739414b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 12:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741294032; x=1741898832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQGznoKYgEiJF2ZocxS6IIWGkMMW2W5YhUK2yHHLs5U=;
        b=N81foBq1OY5A4fcg029dwzl54sIQf+0QZiRsg15WTJlXeShfYh1KHWMlzqyVg6ma9b
         pEbmPeQ51v8Dpnxx4p18FgiIcYob0FezDNQfXVogng1oJJDFy9iUy8t1hYFp2bcIdxd0
         H8pPTH8vcTcsksHLpD7YYb89kkkhyXglWHEK2/uMaiQ+3RK0Mb/i4PTtteY+3kbX+2DT
         6rEI8Rp/9EoIysCQxslEbGOs3ggEFOMTMUXx0ERe+5SwCnSJe9jEuY4ohOWqF1qYvbd4
         i6AWBrkLOP5zetZFajlRzAq3UO1wJqicfewLPOv8X7nai94aKK5DKY9HTCV+/VaY8VeJ
         f3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741294032; x=1741898832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQGznoKYgEiJF2ZocxS6IIWGkMMW2W5YhUK2yHHLs5U=;
        b=WeC/IpoikvohqJuLZJRa/domO5q/6uRQNX1nx0wTfJgw77MKJ0/obs0oN/gNJnAukj
         eCmvsxNDXaxBrsP+pdU04fCNGWoWNc9axxxbuAcuiRA8wNwGnO+w/fH7kumq4izBhTB3
         TjfFoq3mcaQOd83L+mP9evNOKX452Nad0q7AZX0y0PnOOiU+TlqiUROJ5c8E5lLg0zmM
         W0u9WRZEaaHx+QSD/305SubKuTjrydVvMdyoVcDg1by0hMTO1KYdLt8tpR78fYv/rGqj
         sQxtbU84KYcim0AaD3L4vPd1nQ7XvW1YqqaLD9MwP4mSzFzhM2nz/Gz1d6vpVwOeFePn
         yQhw==
X-Forwarded-Encrypted: i=1; AJvYcCWE5ntr8H2OZOWAErxke4YeyiL3ZxULh1elcmhICFo1OYNpR4si+tFXD4kim5F6e57BY4FMrCvTIpmabSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXx0tjdW4Sqg7g69B6q5297YMK8md/RP0DGaL9qDJ2gbYudKXQ
	pM9zZ0e5tIp3ykF/LojxddWHWyRS1tC+4mqvAmkZB/MUgNF8i54h4EvN9PzTQLQ3y0g8dWDpnfT
	gK32RUShk8SU28e3BYkACKJSLOWgERWwnZPFSOQ==
X-Gm-Gg: ASbGnctu+uNw2q0FDbt4GR6nKgt6dUNOFFnkzvGoqGmKfkSZYayXjmaxvM6RGoZosSx
	l2XCZZGwMWH2LRBhQQqsWFUEEwX8REm0hRI2Uzcrk3gtZkpUZzvHfFP78y0XcXpdeqNxlJKZ9aZ
	Lt1pak10aMo47GXGGb4EQ/5hg5Ucs=
X-Google-Smtp-Source: AGHT+IHJ4P4g2Wx4hHtPWxk9XBVqMXx/fsCY8zqlckdOH3NLPOT595ME4iQXcz2mqQ/LDDjT1bmv87qWM7RCy00YEek=
X-Received: by 2002:a05:6808:4490:b0:3f4:f1c:7623 with SMTP id
 5614622812f47-3f697bc3d22mr629301b6e.27.1741294032530; Thu, 06 Mar 2025
 12:47:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250301-pinctrl-fltcon-suspend-v2-0-a7eef9bb443b@linaro.org>
 <20250301-pinctrl-fltcon-suspend-v2-2-a7eef9bb443b@linaro.org> <f7c0101ff26ac0d4ef70a374ae31ee5d23b3c8fc.camel@linaro.org>
In-Reply-To: <f7c0101ff26ac0d4ef70a374ae31ee5d23b3c8fc.camel@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Thu, 6 Mar 2025 20:47:01 +0000
X-Gm-Features: AQ5f1JrMYxcTx_MPnzE2pq7Q0hCMsbcNSijYZXYO_E6tVg6kT7A5TtUkWftcCGQ
Message-ID: <CADrjBPpF0ORvEP3fokS5FaoRtEZyE-xGFAK6uyCqck6+2F-JZg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] pinctrl: samsung: add dedicated SoC eint
 suspend/resume callbacks
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tudor.ambarus@linaro.org, willmcvicker@google.com, semen.protsenko@linaro.org, 
	kernel-team@android.com, jaewon02.kim@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9,

Thanks for the review feedback :)

On Thu, 6 Mar 2025 at 11:57, Andr=C3=A9 Draszik <andre.draszik@linaro.org> =
wrote:
>
> On Sat, 2025-03-01 at 11:43 +0000, Peter Griffin wrote:
> > gs101 needs it's own suspend/resume callbacks to use the newly
> > added eint_fltcon_offset for saving & restoring fltcon0 & fltcon1
> > registers. It also differs to previous SoCs in that fltcon1
> > register doesn't always exist for each bank.
> >
> > exynosautov920 also has dedicated logic for using eint_con_offset
> > and eint_mask_offset for saving & restoring it's registers.
> >
> > Refactor the existing platform specific suspend/resume callback
> > so that each SoC variant has their own callback containing the
> > SoC specific logic.
> >
> > Additionally we now call drvdata->suspend() & drvdata->resume()
> > from within the loop that iterates the banks in
> > samsung_pinctrl_suspend() and samsung_pinctrl_resume().
> >
> > This simplifies the logic, and allows us to remove the
> > clk_enable() and clk_disable() from the callbacks.
> >
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > ---
> > Changes since v1:
> > * Split code refactor & gs101 parts into separate patches (Andre)
> > ---
> >  drivers/pinctrl/samsung/pinctrl-exynos-arm64.c |  28 ++--
> >  drivers/pinctrl/samsung/pinctrl-exynos.c       | 201 ++++++++++-------=
--------
> >  drivers/pinctrl/samsung/pinctrl-exynos.h       |   6 +-
> >  drivers/pinctrl/samsung/pinctrl-samsung.c      |  11 +-
> >  drivers/pinctrl/samsung/pinctrl-samsung.h      |   8 +-
> >  5 files changed, 111 insertions(+), 143 deletions(-)
> >
> > diff --git a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c b/drivers/p=
inctrl/samsung/pinctrl-exynos-arm64.c
> > index e28fe8177646..57c98d2451b5 100644
> > --- a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
> > +++ b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
> > @@ -1112,8 +1112,8 @@ static const struct samsung_pin_ctrl exynosautov9=
20_pin_ctrl[] =3D {
> >               .pin_banks      =3D exynosautov920_pin_banks0,
> >               .nr_banks       =3D ARRAY_SIZE(exynosautov920_pin_banks0)=
,
> >               .eint_wkup_init =3D exynos_eint_wkup_init,
> > -             .suspend        =3D exynos_pinctrl_suspend,
> > -             .resume         =3D exynos_pinctrl_resume,
> > +             .suspend        =3D exynosautov920_pinctrl_suspend,
> > +             .resume         =3D exynosautov920_pinctrl_resume,
> >               .retention_data =3D &exynosautov920_retention_data,
> >       }, {
> >               /* pin-controller instance 1 AUD data */
> > @@ -1124,43 +1124,43 @@ static const struct samsung_pin_ctrl exynosauto=
v920_pin_ctrl[] =3D {
> >               .pin_banks      =3D exynosautov920_pin_banks2,
> >               .nr_banks       =3D ARRAY_SIZE(exynosautov920_pin_banks2)=
,
> >               .eint_gpio_init =3D exynos_eint_gpio_init,
> > -             .suspend        =3D exynos_pinctrl_suspend,
> > -             .resume         =3D exynos_pinctrl_resume,
> > +             .suspend        =3D exynosautov920_pinctrl_suspend,
> > +             .resume         =3D exynosautov920_pinctrl_resume,
> >       }, {
> >               /* pin-controller instance 3 HSI1 data */
> >               .pin_banks      =3D exynosautov920_pin_banks3,
> >               .nr_banks       =3D ARRAY_SIZE(exynosautov920_pin_banks3)=
,
> >               .eint_gpio_init =3D exynos_eint_gpio_init,
> > -             .suspend        =3D exynos_pinctrl_suspend,
> > -             .resume         =3D exynos_pinctrl_resume,
> > +             .suspend        =3D exynosautov920_pinctrl_suspend,
> > +             .resume         =3D exynosautov920_pinctrl_resume,
> >       }, {
> >               /* pin-controller instance 4 HSI2 data */
> >               .pin_banks      =3D exynosautov920_pin_banks4,
> >               .nr_banks       =3D ARRAY_SIZE(exynosautov920_pin_banks4)=
,
> >               .eint_gpio_init =3D exynos_eint_gpio_init,
> > -             .suspend        =3D exynos_pinctrl_suspend,
> > -             .resume         =3D exynos_pinctrl_resume,
> > +             .suspend        =3D exynosautov920_pinctrl_suspend,
> > +             .resume         =3D exynosautov920_pinctrl_resume,
> >       }, {
> >               /* pin-controller instance 5 HSI2UFS data */
> >               .pin_banks      =3D exynosautov920_pin_banks5,
> >               .nr_banks       =3D ARRAY_SIZE(exynosautov920_pin_banks5)=
,
> >               .eint_gpio_init =3D exynos_eint_gpio_init,
> > -             .suspend        =3D exynos_pinctrl_suspend,
> > -             .resume         =3D exynos_pinctrl_resume,
> > +             .suspend        =3D exynosautov920_pinctrl_suspend,
> > +             .resume         =3D exynosautov920_pinctrl_resume,
> >       }, {
> >               /* pin-controller instance 6 PERIC0 data */
> >               .pin_banks      =3D exynosautov920_pin_banks6,
> >               .nr_banks       =3D ARRAY_SIZE(exynosautov920_pin_banks6)=
,
> >               .eint_gpio_init =3D exynos_eint_gpio_init,
> > -             .suspend        =3D exynos_pinctrl_suspend,
> > -             .resume         =3D exynos_pinctrl_resume,
> > +             .suspend        =3D exynosautov920_pinctrl_suspend,
> > +             .resume         =3D exynosautov920_pinctrl_resume,
> >       }, {
> >               /* pin-controller instance 7 PERIC1 data */
> >               .pin_banks      =3D exynosautov920_pin_banks7,
> >               .nr_banks       =3D ARRAY_SIZE(exynosautov920_pin_banks7)=
,
> >               .eint_gpio_init =3D exynos_eint_gpio_init,
> > -             .suspend        =3D exynos_pinctrl_suspend,
> > -             .resume         =3D exynos_pinctrl_resume,
> > +             .suspend        =3D exynosautov920_pinctrl_suspend,
> > +             .resume         =3D exynosautov920_pinctrl_resume,
> >       },
> >  };
> >
> > diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl=
/samsung/pinctrl-exynos.c
> > index ac6dc22b37c9..d65a9fba0781 100644
> > --- a/drivers/pinctrl/samsung/pinctrl-exynos.c
> > +++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
> > @@ -761,153 +761,118 @@ __init int exynos_eint_wkup_init(struct samsung=
_pinctrl_drv_data *d)
> >       return 0;
> >  }
> >
> > -static void exynos_pinctrl_suspend_bank(
> > -                             struct samsung_pinctrl_drv_data *drvdata,
> > -                             struct samsung_pin_bank *bank)
> > +static void exynos_set_wakeup(struct samsung_pin_bank *bank)
> >  {
> > -     struct exynos_eint_gpio_save *save =3D bank->soc_priv;
> > -     const void __iomem *regs =3D bank->eint_base;
> > +     struct exynos_irq_chip *irq_chip =3D NULL;
>
> This is a useless init and the value is overwritten right away.

Will fix
>
> >
> > -     if (clk_enable(bank->drvdata->pclk)) {
> > -             dev_err(bank->gpio_chip.parent,
> > -                     "unable to enable clock for saving state\n");
> > -             return;
> > +     if (bank->eint_type =3D=3D EINT_TYPE_WKUP) {
> > +             if (bank->irq_chip) {
> > +                     irq_chip =3D bank->irq_chip;
> > +                     irq_chip->set_eint_wakeup_mask(bank->drvdata, irq=
_chip);
> > +             }
> >       }
> > -
> > -     save->eint_con =3D readl(regs + EXYNOS_GPIO_ECON_OFFSET
> > -                                             + bank->eint_offset);
> > -     save->eint_fltcon0 =3D readl(regs + EXYNOS_GPIO_EFLTCON_OFFSET
> > -                                             + 2 * bank->eint_offset);
> > -     save->eint_fltcon1 =3D readl(regs + EXYNOS_GPIO_EFLTCON_OFFSET
> > -                                             + 2 * bank->eint_offset +=
 4);
> > -     save->eint_mask =3D readl(regs + bank->irq_chip->eint_mask
> > -                                             + bank->eint_offset);
> > -
> > -     clk_disable(bank->drvdata->pclk);
> > -
> > -     pr_debug("%s: save     con %#010x\n", bank->name, save->eint_con)=
;
> > -     pr_debug("%s: save fltcon0 %#010x\n", bank->name, save->eint_fltc=
on0);
> > -     pr_debug("%s: save fltcon1 %#010x\n", bank->name, save->eint_fltc=
on1);
> > -     pr_debug("%s: save    mask %#010x\n", bank->name, save->eint_mask=
);
> >  }
> >
> > -static void exynosauto_pinctrl_suspend_bank(struct samsung_pinctrl_drv=
_data *drvdata,
> > -                                         struct samsung_pin_bank *bank=
)
> > +void exynos_pinctrl_suspend(struct samsung_pin_bank *bank)
> >  {
> >       struct exynos_eint_gpio_save *save =3D bank->soc_priv;
> >       const void __iomem *regs =3D bank->eint_base;
> >
> > -     if (clk_enable(bank->drvdata->pclk)) {
> > -             dev_err(bank->gpio_chip.parent,
> > -                     "unable to enable clock for saving state\n");
> > -             return;
> > +     exynos_set_wakeup(bank);
> > +
> > +     if (bank->eint_type =3D=3D EINT_TYPE_GPIO) {
>
> Can you swap the order, and make the call to exynos_set_wakeup()
> an else, to avoid some needless tests and make it clearer that
> set_wakeup() is conditional as well, i.e.:
>
>         if (bank->eint_type =3D=3D EINT_TYPE_GPIO) {
>           ...
>         } else {
>           exynos_set_wakeup(bank);
>         }
>
> What makes it hard to read is that as-is, it looks like the
> set_wakeup() is unconditional, while it's also based on
> bank->eint_type (which is also more obvious before your patch).

I've addressed this and the rest of your review feedback in the v3
which I just sent.

Thanks,

Peter.

}
}



>
> Other than that, I think I looks good.
>
> Cheers,
> Andre'
>
> > +             save->eint_con =3D readl(regs + EXYNOS_GPIO_ECON_OFFSET
> > +                                    + bank->eint_offset);
> > +             save->eint_fltcon0 =3D readl(regs + EXYNOS_GPIO_EFLTCON_O=
FFSET
> > +                                        + 2 * bank->eint_offset);
> > +             save->eint_fltcon1 =3D readl(regs + EXYNOS_GPIO_EFLTCON_O=
FFSET
> > +                                        + 2 * bank->eint_offset + 4);
> > +             save->eint_mask =3D readl(regs + bank->irq_chip->eint_mas=
k
> > +                                     + bank->eint_offset);
> > +
> > +             pr_debug("%s: save     con %#010x\n",
> > +                      bank->name, save->eint_con);
> > +             pr_debug("%s: save fltcon0 %#010x\n",
> > +                      bank->name, save->eint_fltcon0);
> > +             pr_debug("%s: save fltcon1 %#010x\n",
> > +                      bank->name, save->eint_fltcon1);
> > +             pr_debug("%s: save    mask %#010x\n",
> > +                      bank->name, save->eint_mask);
> >       }
> > -
> > -     save->eint_con =3D readl(regs + bank->pctl_offset + bank->eint_co=
n_offset);
> > -     save->eint_mask =3D readl(regs + bank->pctl_offset + bank->eint_m=
ask_offset);
> > -
> > -     clk_disable(bank->drvdata->pclk);
> > -
> > -     pr_debug("%s: save     con %#010x\n", bank->name, save->eint_con)=
;
> > -     pr_debug("%s: save    mask %#010x\n", bank->name, save->eint_mask=
);
> >  }
> >
> > -void exynos_pinctrl_suspend(struct samsung_pinctrl_drv_data *drvdata)
> > +void exynosautov920_pinctrl_suspend(struct samsung_pin_bank *bank)
> >  {
> > -     struct samsung_pin_bank *bank =3D drvdata->pin_banks;
> > -     struct exynos_irq_chip *irq_chip =3D NULL;
> > -     int i;
> > +     struct exynos_eint_gpio_save *save =3D bank->soc_priv;
> > +     const void __iomem *regs =3D bank->eint_base;
> >
> > -     for (i =3D 0; i < drvdata->nr_banks; ++i, ++bank) {
> > -             if (bank->eint_type =3D=3D EINT_TYPE_GPIO) {
> > -                     if (bank->eint_con_offset)
> > -                             exynosauto_pinctrl_suspend_bank(drvdata, =
bank);
> > -                     else
> > -                             exynos_pinctrl_suspend_bank(drvdata, bank=
);
> > -             }
> > -             else if (bank->eint_type =3D=3D EINT_TYPE_WKUP) {
> > -                     if (!irq_chip) {
> > -                             irq_chip =3D bank->irq_chip;
> > -                             irq_chip->set_eint_wakeup_mask(drvdata,
> > -                                                            irq_chip);
> > -                     }
> > -             }
> > +     exynos_set_wakeup(bank);
> > +
> > +     if (bank->eint_type =3D=3D EINT_TYPE_GPIO) {
> > +             save->eint_con =3D readl(regs + bank->pctl_offset +
> > +                                    bank->eint_con_offset);
> > +             save->eint_mask =3D readl(regs + bank->pctl_offset +
> > +                                     bank->eint_mask_offset);
> > +             pr_debug("%s: save     con %#010x\n",
> > +                      bank->name, save->eint_con);
> > +             pr_debug("%s: save    mask %#010x\n",
> > +                      bank->name, save->eint_mask);
> >       }
> >  }
> >
> > -static void exynos_pinctrl_resume_bank(
> > -                             struct samsung_pinctrl_drv_data *drvdata,
> > -                             struct samsung_pin_bank *bank)
> > +void exynos_pinctrl_resume(struct samsung_pin_bank *bank)
> >  {
> >       struct exynos_eint_gpio_save *save =3D bank->soc_priv;
> >       void __iomem *regs =3D bank->eint_base;
> >
> > -     if (clk_enable(bank->drvdata->pclk)) {
> > -             dev_err(bank->gpio_chip.parent,
> > -                     "unable to enable clock for restoring state\n");
> > -             return;
> > +     if (bank->eint_type =3D=3D EINT_TYPE_GPIO) {
> > +             pr_debug("%s:     con %#010x =3D> %#010x\n", bank->name,
> > +                      readl(regs + EXYNOS_GPIO_ECON_OFFSET
> > +                            + bank->eint_offset), save->eint_con);
> > +             pr_debug("%s: fltcon0 %#010x =3D> %#010x\n", bank->name,
> > +                      readl(regs + EXYNOS_GPIO_EFLTCON_OFFSET
> > +                            + 2 * bank->eint_offset), save->eint_fltco=
n0);
> > +             pr_debug("%s: fltcon1 %#010x =3D> %#010x\n", bank->name,
> > +                      readl(regs + EXYNOS_GPIO_EFLTCON_OFFSET
> > +                            + 2 * bank->eint_offset + 4),
> > +                            save->eint_fltcon1);
> > +             pr_debug("%s:    mask %#010x =3D> %#010x\n", bank->name,
> > +                      readl(regs + bank->irq_chip->eint_mask
> > +                            + bank->eint_offset), save->eint_mask);
> > +
> > +             writel(save->eint_con, regs + EXYNOS_GPIO_ECON_OFFSET
> > +                    + bank->eint_offset);
> > +             writel(save->eint_fltcon0, regs + EXYNOS_GPIO_EFLTCON_OFF=
SET
> > +                    + 2 * bank->eint_offset);
> > +             writel(save->eint_fltcon1, regs + EXYNOS_GPIO_EFLTCON_OFF=
SET
> > +                    + 2 * bank->eint_offset + 4);
> > +             writel(save->eint_mask, regs + bank->irq_chip->eint_mask
> > +                    + bank->eint_offset);
> >       }
> > -
> > -     pr_debug("%s:     con %#010x =3D> %#010x\n", bank->name,
> > -                     readl(regs + EXYNOS_GPIO_ECON_OFFSET
> > -                     + bank->eint_offset), save->eint_con);
> > -     pr_debug("%s: fltcon0 %#010x =3D> %#010x\n", bank->name,
> > -                     readl(regs + EXYNOS_GPIO_EFLTCON_OFFSET
> > -                     + 2 * bank->eint_offset), save->eint_fltcon0);
> > -     pr_debug("%s: fltcon1 %#010x =3D> %#010x\n", bank->name,
> > -                     readl(regs + EXYNOS_GPIO_EFLTCON_OFFSET
> > -                     + 2 * bank->eint_offset + 4), save->eint_fltcon1)=
;
> > -     pr_debug("%s:    mask %#010x =3D> %#010x\n", bank->name,
> > -                     readl(regs + bank->irq_chip->eint_mask
> > -                     + bank->eint_offset), save->eint_mask);
> > -
> > -     writel(save->eint_con, regs + EXYNOS_GPIO_ECON_OFFSET
> > -                                             + bank->eint_offset);
> > -     writel(save->eint_fltcon0, regs + EXYNOS_GPIO_EFLTCON_OFFSET
> > -                                             + 2 * bank->eint_offset);
> > -     writel(save->eint_fltcon1, regs + EXYNOS_GPIO_EFLTCON_OFFSET
> > -                                             + 2 * bank->eint_offset +=
 4);
> > -     writel(save->eint_mask, regs + bank->irq_chip->eint_mask
> > -                                             + bank->eint_offset);
> > -
> > -     clk_disable(bank->drvdata->pclk);
> >  }
> >
> > -static void exynosauto_pinctrl_resume_bank(struct samsung_pinctrl_drv_=
data *drvdata,
> > -                                        struct samsung_pin_bank *bank)
> > +void exynosautov920_pinctrl_resume(struct samsung_pin_bank *bank)
> >  {
> >       struct exynos_eint_gpio_save *save =3D bank->soc_priv;
> >       void __iomem *regs =3D bank->eint_base;
> >
> > -     if (clk_enable(bank->drvdata->pclk)) {
> > -             dev_err(bank->gpio_chip.parent,
> > -                     "unable to enable clock for restoring state\n");
> > -             return;
> > +     if (bank->eint_type =3D=3D EINT_TYPE_GPIO) {
> > +             /* exynosautov920 has eint_con_offset for all but one ban=
k */
> > +             if (!bank->eint_con_offset)
> > +                     exynos_pinctrl_resume(bank);
> > +
> > +             pr_debug("%s:     con %#010x =3D> %#010x\n", bank->name,
> > +                      readl(regs + bank->pctl_offset + bank->eint_con_=
offset),
> > +                            save->eint_con);
> > +             pr_debug("%s:    mask %#010x =3D> %#010x\n", bank->name,
> > +                      readl(regs + bank->pctl_offset +
> > +                            bank->eint_mask_offset), save->eint_mask);
> > +
> > +             writel(save->eint_con,
> > +                    regs + bank->pctl_offset + bank->eint_con_offset);
> > +             writel(save->eint_mask,
> > +                    regs + bank->pctl_offset + bank->eint_mask_offset)=
;
> >       }
> > -
> > -     pr_debug("%s:     con %#010x =3D> %#010x\n", bank->name,
> > -              readl(regs + bank->pctl_offset + bank->eint_con_offset),=
 save->eint_con);
> > -     pr_debug("%s:    mask %#010x =3D> %#010x\n", bank->name,
> > -              readl(regs + bank->pctl_offset + bank->eint_mask_offset)=
, save->eint_mask);
> > -
> > -     writel(save->eint_con, regs + bank->pctl_offset + bank->eint_con_=
offset);
> > -     writel(save->eint_mask, regs + bank->pctl_offset + bank->eint_mas=
k_offset);
> > -
> > -     clk_disable(bank->drvdata->pclk);
> > -}
> > -
> > -void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
> > -{
> > -     struct samsung_pin_bank *bank =3D drvdata->pin_banks;
> > -     int i;
> > -
> > -     for (i =3D 0; i < drvdata->nr_banks; ++i, ++bank)
> > -             if (bank->eint_type =3D=3D EINT_TYPE_GPIO) {
> > -                     if (bank->eint_con_offset)
> > -                             exynosauto_pinctrl_resume_bank(drvdata, b=
ank);
> > -                     else
> > -                             exynos_pinctrl_resume_bank(drvdata, bank)=
;
> > -             }
> >  }
> >
> >  static void exynos_retention_enable(struct samsung_pinctrl_drv_data *d=
rvdata)
> > diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.h b/drivers/pinctrl=
/samsung/pinctrl-exynos.h
> > index 33df21d5c9d6..35c2bc4ea488 100644
> > --- a/drivers/pinctrl/samsung/pinctrl-exynos.h
> > +++ b/drivers/pinctrl/samsung/pinctrl-exynos.h
> > @@ -221,8 +221,10 @@ struct exynos_muxed_weint_data {
> >
> >  int exynos_eint_gpio_init(struct samsung_pinctrl_drv_data *d);
> >  int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d);
> > -void exynos_pinctrl_suspend(struct samsung_pinctrl_drv_data *drvdata);
> > -void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata);
> > +void exynosautov920_pinctrl_resume(struct samsung_pin_bank *bank);
> > +void exynosautov920_pinctrl_suspend(struct samsung_pin_bank *bank);
> > +void exynos_pinctrl_suspend(struct samsung_pin_bank *bank);
> > +void exynos_pinctrl_resume(struct samsung_pin_bank *bank);
> >  struct samsung_retention_ctrl *
> >  exynos_retention_init(struct samsung_pinctrl_drv_data *drvdata,
> >                     const struct samsung_retention_data *data);
> > diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctr=
l/samsung/pinctrl-samsung.c
> > index 963060920301..375634d8cc79 100644
> > --- a/drivers/pinctrl/samsung/pinctrl-samsung.c
> > +++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
> > @@ -1349,6 +1349,9 @@ static int __maybe_unused samsung_pinctrl_suspend=
(struct device *dev)
> >               const u8 *widths =3D bank->type->fld_width;
> >               enum pincfg_type type;
> >
> > +             if (drvdata->suspend)
> > +                     drvdata->suspend(bank);
> > +
> >               /* Registers without a powerdown config aren't lost */
> >               if (!widths[PINCFG_TYPE_CON_PDN])
> >                       continue;
> > @@ -1373,8 +1376,6 @@ static int __maybe_unused samsung_pinctrl_suspend=
(struct device *dev)
> >
> >       clk_disable(drvdata->pclk);
> >
> > -     if (drvdata->suspend)
> > -             drvdata->suspend(drvdata);
> >       if (drvdata->retention_ctrl && drvdata->retention_ctrl->enable)
> >               drvdata->retention_ctrl->enable(drvdata);
> >
> > @@ -1406,9 +1407,6 @@ static int __maybe_unused samsung_pinctrl_resume(=
struct device *dev)
> >               return ret;
> >       }
> >
> > -     if (drvdata->resume)
> > -             drvdata->resume(drvdata);
> > -
> >       for (i =3D 0; i < drvdata->nr_banks; i++) {
> >               struct samsung_pin_bank *bank =3D &drvdata->pin_banks[i];
> >               void __iomem *reg =3D bank->pctl_base + bank->pctl_offset=
;
> > @@ -1416,6 +1414,9 @@ static int __maybe_unused samsung_pinctrl_resume(=
struct device *dev)
> >               const u8 *widths =3D bank->type->fld_width;
> >               enum pincfg_type type;
> >
> > +             if (drvdata->resume)
> > +                     drvdata->resume(bank);
> > +
> >               /* Registers without a powerdown config aren't lost */
> >               if (!widths[PINCFG_TYPE_CON_PDN])
> >                       continue;
> > diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.h b/drivers/pinctr=
l/samsung/pinctrl-samsung.h
> > index 371e4f02bbfb..e939e5bb0347 100644
> > --- a/drivers/pinctrl/samsung/pinctrl-samsung.h
> > +++ b/drivers/pinctrl/samsung/pinctrl-samsung.h
> > @@ -285,8 +285,8 @@ struct samsung_pin_ctrl {
> >       int             (*eint_gpio_init)(struct samsung_pinctrl_drv_data=
 *);
> >       int             (*eint_wkup_init)(struct samsung_pinctrl_drv_data=
 *);
> >       void            (*pud_value_init)(struct samsung_pinctrl_drv_data=
 *drvdata);
> > -     void            (*suspend)(struct samsung_pinctrl_drv_data *);
> > -     void            (*resume)(struct samsung_pinctrl_drv_data *);
> > +     void            (*suspend)(struct samsung_pin_bank *bank);
> > +     void            (*resume)(struct samsung_pin_bank *bank);
> >  };
> >
> >  /**
> > @@ -335,8 +335,8 @@ struct samsung_pinctrl_drv_data {
> >
> >       struct samsung_retention_ctrl   *retention_ctrl;
> >
> > -     void (*suspend)(struct samsung_pinctrl_drv_data *);
> > -     void (*resume)(struct samsung_pinctrl_drv_data *);
> > +     void (*suspend)(struct samsung_pin_bank *bank);
> > +     void (*resume)(struct samsung_pin_bank *bank);
> >  };
> >
> >  /**
> >
>

