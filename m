Return-Path: <linux-kernel+bounces-557616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C692A5DB99
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69B9189A68B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FE823E335;
	Wed, 12 Mar 2025 11:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bUXOkLmN"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7881A256B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 11:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741779082; cv=none; b=UsXFwsl+WvbI/MjU5Ic9tw7zsI0i2Ug4AV0dT1JSwiztQiE/PeOPAsd3IFdClklFRluiQoW7bsS02rqQ7Hf5kdjJ+XQc+yGsUTJBUi9UG79SOBVmw2xlErLCPvypwczjFTasmGkJwXykzmup6yHdBT3BZ8ZcYTaEeOpaR4AK+Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741779082; c=relaxed/simple;
	bh=LamZ1dekJFD1CplIqMFq82A+Hivmj1FNR9Ba1K2yv3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YYiUl5FXd/+nYGLpj6dBT3wJ9lAklo/Gi5j6OcWMANnhX4yT+SV9fbFScVyWNs8vVYsyd/OBGArpEOlB3wfYZRdnlDezWkr+CQNYjFK1N7Wyrec8FQ0clzILi2NLv8C/GuW1tdI9RbM1+amyfQJEKN+lwp7sZnwIUXhRXY3K3/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bUXOkLmN; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-72b0626c785so2833159a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 04:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741779078; x=1742383878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UdPvnPkDYszULhre/XOAdt2THz5zT2TlDbP/t1A4yE=;
        b=bUXOkLmN9a33mGpf9s4rT1BooLhOYIPBOVmm6ayBsCc0+1CAqb+WjfNank8ls8vxMb
         WaFR5mI8j+j8hvhAlCrUt9qBwj8rIXWzd9yEOLErhbwHgJAQTJ0qZvLOwWtnFdO/WgZ5
         gt5PGqyE557M3IXeC3q/H9M4ATmk3ee5PMbMeZPBSQJ7wsIFLRtQjkN6X5SXcEY12wq7
         +X5C9RXZama5wC8l8XpriL5Eshd/BvLONvohndp54syjOn/mykX+nCPBHgag44g3xdE2
         45JWE3zGYbDWURwuKt//aam8PcCTiRaLFp05Ksht27kN4XF0d71BxWF92mtex7zS8+Ki
         TC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741779078; x=1742383878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9UdPvnPkDYszULhre/XOAdt2THz5zT2TlDbP/t1A4yE=;
        b=usStAEuRaFUT6e1Xhemu4P1RCWKfqcLfpY3zSfMm2+SzJs4LGG6iSgN0/0NYhuOLO+
         FkGpDIArXSy8+E/EaGgVOgW2824U4CftNeolN/x9anHsxfC1t0fonpjp/4jkOzcSAoZn
         ZKjZ2CkYCWTgPWT0BK+tz0lARjIxc0j9KGBA6LxZQ4CxNKbrt9n5gFAuK51hURVe179S
         lKza3oVy4vDFKIKN4iOFG1xiXObxltEuZYqMJFK6gLLVrmg9/HPlF54GlChxGYTrJcrE
         Cm7HrH3Tl4ray7WVgrRAVpPzGkzyutQfS53e3tCYfIdI18Inz/CUa986oVplekBQnUNW
         zriQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaNBg72qNgj/fp08SC38lUQtsQdefVLR0T6vrPD8RDhnyLj5aI1z4l875XP0yJzmqaK0NPjsI8BXbEZeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/FBODrPHHQ2e/gCqnoGxomVtYtWctOOgNChAeQwldFXOxxEfU
	O9JU63GCoqM3spLurHMb0MLUPm5tSTaekfCYV45vvJwL0NmpA5DxVc96xXyeQUYzssjG4v0KKpd
	TegsYd5X2RocRIm3UDt26405DX0CvPI1DU58M/w==
X-Gm-Gg: ASbGnctAuLsaaNWy+hRC39GZWPUy9NhMj0IGf5RVz8Mjie5jhGuu/lzajMVsnhGzjPa
	3DpbHrMX6Ev6KNcIcrKW4BU6SDVWv6zqqkjmGmO7YlEnWYq4tj+yYKBO16uK0vbGl+mGNdbISSm
	adb/U8U7lYR7qHzolXEflq+p812KZg
X-Google-Smtp-Source: AGHT+IHpN3V115z284qmxaOdgGA4PwV3v/6Lpfa9pDfmxTKlcBbQ43+xR982OzrJIgzm+w3NL49THbQiezCdr3Q3kYQ=
X-Received: by 2002:a05:6830:91f:b0:727:2f79:ce33 with SMTP id
 46e09a7af769-72a37c6a7damr12652067a34.28.1741779078312; Wed, 12 Mar 2025
 04:31:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-pinctrl-fltcon-suspend-v4-0-2d775e486036@linaro.org>
 <20250307-pinctrl-fltcon-suspend-v4-3-2d775e486036@linaro.org> <59a1a6eb-d719-49bd-a4b5-bfb9c2817f08@kernel.org>
In-Reply-To: <59a1a6eb-d719-49bd-a4b5-bfb9c2817f08@kernel.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Wed, 12 Mar 2025 11:31:07 +0000
X-Gm-Features: AQ5f1Jq8qDRuo8RWVbqyC-4s6dvJ3zqh5v94onY3xAq0EKJNYhbmQXeDH_scC5U
Message-ID: <CADrjBPqYoHckqr43y1z8UtthZ9DOG15TJWSv_707Jbyf1yforw@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] pinctrl: samsung: add gs101 specific eint
 suspend/resume callbacks
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, andre.draszik@linaro.org, 
	tudor.ambarus@linaro.org, willmcvicker@google.com, semen.protsenko@linaro.org, 
	kernel-team@android.com, jaewon02.kim@samsung.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

Thanks for the review feedback.

On Tue, 11 Mar 2025 at 19:36, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 07/03/2025 11:29, Peter Griffin wrote:
> > gs101 differs to other SoCs in that fltcon1 register doesn't
> > always exist. Additionally the offset of fltcon0 is not fixed
> > and needs to use the newly added eint_fltcon_offset variable.
> >
> > Fixes: 4a8be01a1a7a ("pinctrl: samsung: Add gs101 SoC pinctrl configura=
tion")
> > Cc: stable@vger.kernel.org
>
> It looks this depends on previous commit, right?

Yes that's right, it depends on the refactoring in the previous patch.
To fix the bug (which is an Serror on suspend for gs101), we need the
dedicated gs101 callback so it can have the knowledge that fltcon1
doesn't always exist and it's varying offset.

> That's really not
> optimal, although I understand that if you re-order patches this code
> would be soon changed, just like you changed other suspend/resume
> callbacks in patch #2?

Originally it was just one patch, but the previous review feedback was
to split the refactor into a dedicated patch, and then add gs101
specific parts separately. The refactoring was done primarily so we
can fix this bug without affecting the other platforms, so I don't
re-ordering the patches will help.

Thanks,

Peter
>
>
> > Reviewed-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > ---
> > Changes since v2:
> > * make it clear exynos_set_wakeup(bank) is conditional on bank type (An=
dre)
> > * align style where the '+' is placed (Andre)
> > * remove unnecessary braces (Andre)
> > ---
>
> ...
>
> > +void gs101_pinctrl_suspend(struct samsung_pin_bank *bank)
> > +{
> > +     struct exynos_eint_gpio_save *save =3D bank->soc_priv;
> > +     const void __iomem *regs =3D bank->eint_base;
> > +
> > +     if (bank->eint_type =3D=3D EINT_TYPE_GPIO) {
> > +             save->eint_con =3D readl(regs + EXYNOS_GPIO_ECON_OFFSET
> > +                                    + bank->eint_offset);
> > +
> > +             save->eint_fltcon0 =3D readl(regs + EXYNOS_GPIO_EFLTCON_O=
FFSET
> > +                                        + bank->eint_fltcon_offset);
> > +
> > +             /* fltcon1 register only exists for pins 4-7 */
> > +             if (bank->nr_pins > 4)
> > +                     save->eint_fltcon1 =3D readl(regs +
> > +                                             EXYNOS_GPIO_EFLTCON_OFFSE=
T
> > +                                             + bank->eint_fltcon_offse=
t + 4);
> > +
> > +             save->eint_mask =3D readl(regs + bank->irq_chip->eint_mas=
k
> > +                                     + bank->eint_offset);
> > +
> > +             pr_debug("%s: save     con %#010x\n",
> > +                      bank->name, save->eint_con);
> > +             pr_debug("%s: save fltcon0 %#010x\n",
> > +                      bank->name, save->eint_fltcon0);
> > +             if (bank->nr_pins > 4)
> > +                     pr_debug("%s: save fltcon1 %#010x\n",
> > +                              bank->name, save->eint_fltcon1);
> > +             pr_debug("%s: save    mask %#010x\n",
> > +                      bank->name, save->eint_mask);
> > +     } else if (bank->eint_type =3D=3D EINT_TYPE_WKUP)
> > +             exynos_set_wakeup(bank);
>
> Missing {}. Run checkpatch --strict.
>
>
> Best regards,
> Krzysztof

