Return-Path: <linux-kernel+bounces-543510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E95A4D68F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8EBB3A8B44
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A60D1FAC5B;
	Tue,  4 Mar 2025 08:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="up0Z5QoF"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F401F91F6
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741077298; cv=none; b=S4fMjNmkb+cFWcBri48oLKnC7jvIzxryDeLXpgVu+BpwRTHg0QdAIgzxLuYDqdM/m/5td+m+yABQx9HkFJ0NEOD+EfcoGutkGC26/hlf1N/0O/ZsoS3shKK6ri1Py5GDrvsVxJm/xHlR7yF5kv0JScTaZJD1P5XvV0elgiERn5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741077298; c=relaxed/simple;
	bh=V2KSTpqN9yyPdPBDmFTpPQHR090zUwos7Uqal+nkViE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UniYueQ/rlXMRTUM0P2JeYiAMnYnnF7XLGnElJagZcp2ampx2Ux72zwqJub9MFDW2E8DnR6U8CDQm0Jokq51mTo2APdHVwaCpV7fleynjyG6TTGwLssmN6jhWP/zc8mRYYNVmrGvSGlJM/XraQ9DipW/UUvaxZCS6UhTRa0aFT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=up0Z5QoF; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6f9625c0fccso47627117b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 00:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741077295; x=1741682095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YpYaFgX/DIeu+Y0M+C6PCuEaWiBduI0jsXCByUJfKZk=;
        b=up0Z5QoFeS9MG13eU/opb60ws/3fZAqoYqpjKOCbjeHlnrJAA7/+bUgWK8bC0xyCIU
         SlcgxGmZBpebZFH8dDpw4AD3hipvjF1GgMpr7tAEQ92igx88eGFwS68dQQyH3fVJ8Jby
         bB/KnBnGB7hbbcW6Iv61x7qp5TD5o+TGLyK1+p/i1itP6Qah8cy8/9IkDR/HljDZB6wB
         BFZ0mrihWU4ZyI+wOnbSJP5KPvtB/PSeuxh/HaG8bbi4q8LDbdS9mv0btJbfvVxM+asT
         gsII2XwDE3GQ3qIMzUFVv1/WixEpGL3hoJym7uLRF36loOcd46Or2d/b8C1wG2p7CirI
         VqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741077295; x=1741682095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YpYaFgX/DIeu+Y0M+C6PCuEaWiBduI0jsXCByUJfKZk=;
        b=hD6IYaK7o2m0ChBg9J5OoDIoefsaWroQuvO8zePLLD6pm50gXQxLa3AFfhAHCeY6jv
         eadARgS5R2vSGFDJoiYMeHYrAs5FRqCbcAeixN3l7l0jZZYjl4RrrHnBo6VYbI7dVSEW
         zO3E6Uh/7+Oh09M0szohBuLAP6R5kuc017Ab0Ji7eBxS9bQ4hlr/69V+xE1Cr43/ZZE5
         NjKCe+rCHbJ6FjiCbfscrq0Lqg/X5J6EXCJRshoPsF21j0P3QTqgR/df/oi3UcVeeiRr
         Iq9AJp0uRaFWuPvMVyULcZHQwArH9nDU0hDCztSPKrrwJ9fH8KyE3S5ONHJ4D7Vomigl
         Rvtw==
X-Forwarded-Encrypted: i=1; AJvYcCUAWjqxbPCaLnmTEkD9+S5RnoWZGLVgKFAMUQXOZokjdN7IfMgIGcoqXj/8oNQYLZd+yC3YsFHtiGHdxdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmB8IhNaTqlfUb3+vsnFjnbgJfXb/x4kRPuKvgCtErHqDlSVUy
	vpzuFvFZOk58Eoi1RqK3deAnTkcvHyb/5N61a7l3+y0Hc1IwNdRN+93nYtb8/fyi6JsO/kHShZH
	aLZsci+HoRPjvjPhGzboZNaPbU/Sx6KGkyiRCOQ==
X-Gm-Gg: ASbGnctKuRaJ2zIEXqtNzsj01TP8vdx++eOaFD+hFCtnY9CFayjXWE5O80jwk7gPX0S
	PaDzCs9NcK0paMHUT7OWibQrkm7FSbP/RxQ5XKgGm0EP0qklYetT3HaT1PffbjUbBpGqlHwZiti
	9JE1IG6eQw27qKCUzjMwHRcx/3dg==
X-Google-Smtp-Source: AGHT+IFhGPO8Z+0jx6KGBynNtPT6yYF9xszM4x36wjx9yMMgVztmaWf8Qs8IKShaST2LvOhz0lgri9jNyCWBfrQUF7s=
X-Received: by 2002:a05:690c:7006:b0:6fb:b2c0:71da with SMTP id
 00721157ae682-6fd4a15155bmr214892977b3.36.1741077295472; Tue, 04 Mar 2025
 00:34:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228165749.3476210-1-pratap.nirujogi@amd.com>
In-Reply-To: <20250228165749.3476210-1-pratap.nirujogi@amd.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 4 Mar 2025 09:34:37 +0100
X-Gm-Features: AQ5f1Jr9Zy0fCfWDPGh4yq2xUe8K7tk64A7TE75BVReNHw7SurNadKCZOEUvAVc
Message-ID: <CACRpkdZv6ykTPWUNmbPNv+VS=a_YTFBqiDS0eojt28Myvs-ZZQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: amd: isp411: Add amdisp GPIO pinctrl
To: Pratap Nirujogi <pratap.nirujogi@amd.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	benjamin.chan@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pratap,

thanks for your patch!

On Fri, Feb 28, 2025 at 5:58=E2=80=AFPM Pratap Nirujogi <pratap.nirujogi@am=
d.com> wrote:

> +config PINCTRL_AMDISP
> +       tristate "AMDISP GPIO pin control"
> +       depends on HAS_IOMEM
> +       select GPIOLIB
> +       select PINCONF
> +       select GENERIC_PINCONF
> +       help
> +         The driver for memory mapped GPIO functionality on AMD platform=
s
> +         with ISP support. All the pins are output controlled only
> +
> +         Requires AMDGPU to MFD add device for enumeration to set up as
> +         platform device.

> +/* SPDX-License-Identifier: MIT */

OK we have this...

> +/*
> + * Copyright (C) 2025 Advanced Micro Devices, Inc. All rights reserved.
> + * All Rights Reserved.
> + *

That can be kept

> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the
> + * "Software"), to deal in the Software without restriction, including
> + * without limitation the rights to use, copy, modify, merge, publish,
> + * distribute, sub license, and/or sell copies of the Software, and to
> + * permit persons to whom the Software is furnished to do so, subject to
> + * the following conditions:
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY=
 CLAIM,
> + * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> + * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR=
 THE
> + * USE OR OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * The above copyright notice and this permission notice (including the
> + * next paragraph) shall be included in all copies or substantial portio=
ns
> + * of the Software.

This is already in:
LICENSES/preferred/MIT

Which is referenced by the SPDX tag.

Can we just drop it? It's very annoying with all this boilerplate.

> +#ifdef CONFIG_GPIOLIB

You select GPIOLIB in the Kconfig so drop the ifdef, it's always
available.

> +static int amdisp_gpio_set_config(struct gpio_chip *gc, unsigned int gpi=
o,
> +                                 unsigned long config)
> +{
> +       /* Nothing to do, amdisp gpio has no other config */
> +       return 0;
> +}

Don't even assign the callback then, that's fine.

> +static int amdisp_gpiochip_add(struct platform_device *pdev,
> +                              struct amdisp_pinctrl *pctrl)
> +{
> +       struct gpio_chip *gc =3D &pctrl->gc;
> +       struct pinctrl_gpio_range *grange =3D &pctrl->gpio_range;
> +       int ret;
> +
> +       gc->label               =3D dev_name(pctrl->dev);
> +       gc->owner               =3D THIS_MODULE;

I think the core default-assigns owner so you don't need to
assign this.

> +       gc->parent              =3D &pdev->dev;
> +       gc->names               =3D amdisp_range_pins_name;
> +       gc->request             =3D gpiochip_generic_request;
> +       gc->free                =3D gpiochip_generic_free;
> +       gc->get_direction       =3D amdisp_gpio_get_direction;
> +       gc->direction_input     =3D amdisp_gpio_direction_input;
> +       gc->direction_output    =3D amdisp_gpio_direction_output;
> +       gc->get                 =3D amdisp_gpio_get;
> +       gc->set                 =3D amdisp_gpio_set;
> +       gc->set_config          =3D amdisp_gpio_set_config;

I.e. drop this.

> +       gc->base                =3D -1;
> +       gc->ngpio               =3D ARRAY_SIZE(amdisp_range_pins);
> +#if defined(CONFIG_OF_GPIO)
> +       gc->of_node             =3D pdev->dev.of_node;
> +       gc->of_gpio_n_cells     =3D 2;
> +#endif

Drop the ifdefs.

> +#ifdef CONFIG_GPIOLIB
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (IS_ERR(res))
> +               return PTR_ERR(res);
> +
> +       pctrl->gpiobase =3D devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(pctrl->gpiobase))
> +               return PTR_ERR(pctrl->gpiobase);
> +#endif

Drop ifdefs

> +#ifdef CONFIG_GPIOLIB
> +       ret =3D amdisp_gpiochip_add(pdev, pctrl);
> +       if (ret)
> +               return ret;
> +#endif

Drop ifdefs

> +static int __init amdisp_pinctrl_init(void)
> +{
> +       return platform_driver_register(&amdisp_pinctrl_driver);
> +}
> +arch_initcall(amdisp_pinctrl_init);
> +
> +static void __exit amdisp_pinctrl_exit(void)
> +{
> +       platform_driver_unregister(&amdisp_pinctrl_driver);
> +}
> +module_exit(amdisp_pinctrl_exit);

Why do you need arch_initcall()?

Try to just use module_platform_driver() for the
whole module.

> +MODULE_AUTHOR("Benjamin Chan <benjamin.chan@amd.com>");
> +MODULE_AUTHOR("Pratap Nirujogi <pratap.nirujogi@amd.com>");
> +MODULE_DESCRIPTION("AMDISP pinctrl driver");
> +MODULE_LICENSE("GPL and additional rights");

Well that does not correspond to MIT does it?

> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright (C) 2025 Advanced Micro Devices, Inc. All rights reserved.
> + * All Rights Reserved.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the
> + * "Software"), to deal in the Software without restriction, including
> + * without limitation the rights to use, copy, modify, merge, publish,
> + * distribute, sub license, and/or sell copies of the Software, and to
> + * permit persons to whom the Software is furnished to do so, subject to
> + * the following conditions:
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY=
 CLAIM,
> + * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> + * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR=
 THE
> + * USE OR OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * The above copyright notice and this permission notice (including the
> + * next paragraph) shall be included in all copies or substantial portio=
ns
> + * of the Software.

Can we drop this?

Yours,
Linus Walleij

