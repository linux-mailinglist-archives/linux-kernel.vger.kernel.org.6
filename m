Return-Path: <linux-kernel+bounces-512970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A375FA33FE7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 338703A9F6E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35ECE23F41B;
	Thu, 13 Feb 2025 13:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CX5HUkbf"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7944023F406
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 13:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739452067; cv=none; b=hrRpxrz8jzRZtQP2yje2M9F7wOR9IAO3zdbZxpU3oUHwPYz5FhEzgLXRcBOiY3hdnol2IQwNbgardmeQoO3FEDJuElnkZltpbtWUoVikFVk1ggFWu0RtenI9Hd/5Hl6Ic2Hn/wznPQT4v0JwSUQPvibqVNaOI8bSIJ2Flqhaqdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739452067; c=relaxed/simple;
	bh=fXaB8XDraPqWHOFB9nBP2j+m04SbPqPTOpQ1Y5EAc1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dcwvTnbwicDYyZK6x8i0UcNJCIcxrHUXdqSYuuIPqX9FqvVk9IM9pJVas/a68f51iiac7vSsflktbq5o/kwJ/qyPbFgNHokmuQ1BuZ944JI+Td2sF18iEYAORelfXVZVlQAqdjt/mNpm2f4+zOYYKQDTs8m6+sG7ihMMcxn8dfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CX5HUkbf; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54504bf07cdso824609e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 05:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739452064; x=1740056864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1m322IQyc9zOVSGsdHSNz551pCCbcY6hEwhI/Tt92E=;
        b=CX5HUkbfREYVdKMtcaAaadWQyXc2yT5fXA/Lo9jB8OkC8SHbck2bXaizHLOGTs1dGt
         LZgTHrWW+8Crb2KurU9SH3Y2yp/IzoZOiM9hpw1oSm8Z6zoJbhif3D7LwACUmONDXUzS
         JGzW79dK+EuSOeUE5cDqDKp53+NPOn6V2PRBOCu9FsBlBt6zuEZ0bs7AS71bb8j8TQk2
         1+MBsAHaewhaClKFliUqa+Nfidnh2o9NXEjBaG14H1UC+MHRromKk70SWhe2rpGw67kh
         qfIqusDPj5v0siUPJ8O0wiBUYXjy/qRbbde9SHDG73q7cQSw3MRWe5Hq3mLB2vJaeGkL
         GugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739452064; x=1740056864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1m322IQyc9zOVSGsdHSNz551pCCbcY6hEwhI/Tt92E=;
        b=aCck5wnNeRIxtdtWd7c4ojNVJJYuSpJ7n7jQmFpWRUTkTW4Y9Zcqd4ZeqwJgn9Vsz7
         Lb20SRYOX6nt0wfj4uzKILGkYnNylDrG6gdF5zzUsBTo7u8xZ6F0aJOlaIhxu4u2ulMo
         nOTQUKK3mZuA7xMGrMysgcNrtOx1Iej/q+CtCk37Ybm36jr2PKYjY0aUv63vKtWmzMKF
         wS8EV7TgIONpmZgnW/CHF+ahhWJHU9zmQ7eD5+ZBFZZShBzORW5y4eFq5KgB8vNjIM82
         zaJlE/rccT7b68EIqaK6UtVdaBBlIt1/m3I9+GENGUoN/pGtZnWhyaUBsS1mDIsmuwo6
         I/og==
X-Forwarded-Encrypted: i=1; AJvYcCVYOAFUGuNSNdBAmTyQeiUK8I2ojH6dR45VehobgI8lr6Uz+TBc58Kkmv9PpnkFUsSLYP1qQpefUc9vv0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDUn3FrRM8AIkDBe3l5eHqR2sAzVJViOrT6vH8HWMkUpoFlxH8
	MpGcEQkMcyUYvAP+ZxirtMjO4To77GCM775oed/TJgEfR/m6OQGeIe3NrlKqQou3xyPBxWjtuFV
	t4nVE2FieEKQkRgL8+IySVtQ9TCfzpHoaVfpATA==
X-Gm-Gg: ASbGncvvZm6YYSYs5VJlI8oXnXubO7LaRO59LMJwtfEf2/uVrSB0qkn7mPeNv79bjEf
	hiRGBrtfEdvXceHuYPCnF08yRCOdpkziIp+lzWryX3SCms6RAVmuebL2Map52tAZIOzx/5gBl
X-Google-Smtp-Source: AGHT+IGrhM736BFyGMpNf2ItBB+pdpJ4SiPwkgfbkvqCPSO0yrPV4uYNd3wllzeAV1mMnQTwQL7ndpAU15y6EgrFAw0=
X-Received: by 2002:a05:6512:2215:b0:540:2da2:f282 with SMTP id
 2adb3069b0e04-5451818959bmr1878297e87.42.1739452063461; Thu, 13 Feb 2025
 05:07:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121-03-k1-gpio-v4-0-4641c95c0194@gentoo.org>
 <20250121-03-k1-gpio-v4-1-4641c95c0194@gentoo.org> <Z5FPJLzAEVXGWJnE@chonkvm.lixom.net>
 <20250123113042-GYA38135@gentoo> <Z5LOdh-4UxRtteOy@chonkvm.lixom.net>
 <20250127181726.GA538260-robh@kernel.org> <20250128031712-GYB47737@gentoo>
 <CACRpkdYbSOHD9UH5=+qjztxS3Cq_rxaoOT9tFtD8ZWm9zQGnPw@mail.gmail.com>
 <CACRpkdZa887vx4Lmxk1U_8w5n7AxMnyzGexeYzhsxNGT-DTYcQ@mail.gmail.com> <20250206133156-GYA5687@gentoo>
In-Reply-To: <20250206133156-GYA5687@gentoo>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 13 Feb 2025 14:07:31 +0100
X-Gm-Features: AWEUYZl5mIboPZ2_OX7ZzkKCHtZOEl9dcGB_tfGDF4p9QujG1OrkLL1Y1iNKYJ0
Message-ID: <CACRpkdZYYZ5tUR4gJXuCrix0k56rPPB2TUGP3KpwqMgjs_Vd5w@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: gpio: spacemit: add support for K1 SoC
To: Yixun Lan <dlan@gentoo.org>
Cc: Rob Herring <robh@kernel.org>, Olof Johansson <olof@lixom.net>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Conor Dooley <conor@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Yangyu Chen <cyy@cyyself.name>, 
	Jisheng Zhang <jszhang@kernel.org>, Jesse Taube <mr.bossman075@gmail.com>, 
	Inochi Amaoto <inochiama@outlook.com>, Icenowy Zheng <uwu@icenowy.me>, 
	Meng Zhang <zhangmeng.kevin@linux.spacemit.com>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 2:32=E2=80=AFPM Yixun Lan <dlan@gentoo.org> wrote:

> > > foo-gpios <&gpio 2 7 GPIO_ACTIVE_LOW>;
>
> if we model the dts as above, then "&gpio" will register itself as one so=
le "struct gpio_chip",
>  which mean one gpio chip combine three banks..

Not really: the fact that there is just one gpio node in the device
tree does not
mean that it needs to correspond to one single gpio_chip instance inside th=
e
Linux kernel.

It's just what the current existing bindings and the code in the GPIO subsy=
stem
assumes. It does not have to assume that: we can change it.

I'm sorry if this is not entirely intuitive :(

One node can very well spawn three gpio_chip instances, but it requires
some core changes. But I think it's the most elegant.

> if taking "one gpio chip support multi banks" direction, then it will be =
reverted back as patch V1,
> then, even the three gpio-cells model is unnecessary needed, as we can ma=
p gpio number
>  to the <bank, offset> array in the underlying gpio driver
>
> the v4 patch is very similar to drivers/gpio/gpio-dwapb.c
>
> If had to choose the direction between v1 and v4, I personally would favo=
r the latter,
>  as from hw perspective, each gpio bank is quite indepedent - has its own=
 io/irq registers,
>  merely has interleaved io memory space, one shared IRQ line.. also the p=
atch v4 leverage
>  lots underlying generic gpio APIs, result in much simplified/clean code =
base..

So what I would suggest is a combination of the two.

One gpio node in the device tree, like the DT maintainers want it.

Three struct gpio_chip instances inside the driver, all three spawn from
that single gpio device, and from that single platform_device.

What we are suggesting is a three-cell phandle in the device tree:

foo-gpios =3D <&gpio 0 7 GPIO_ACTIVE_HIGH>;
bar-gpios =3D <&gpio 2 31 GPIO_ACTIVE_HIGH>;

Notice the new first cell which is 0 or 2.

The first one is what was previously called gpio 7.
The second one is what was 2*32+31 =3D gpio 95.

So internally in the driver it is easy to use the first cell (0 or 2) to ma=
p to
the right struct gpio_chip if you have it in your driver something like thi=
s:

struct spacemit_gpio {
    struct gpio_chip gcs[3];
...
};

struct spacemit_gpio *sg;
struct gpio_chip *gc;
int ret;

for (i =3D 0; i++; i < 3) {
     ret =3D devm_gpiochip_add_data(dev, &sg->gcs[i], sg);
     if (ret)
        return ret;
     gc =3D sg->gcs[i];
     .... do stuff with this instance ....
}

Callbacks etc should work as before.

Then these phandles needs to be properly translated, which is done with the
struct gpio_chip .of_xlate() callback. (If you look inside gpiolib-of.c
you will see that chip->of_xlate() is called to map the phandle cells
to a certain GPIO line).

In most cases, drivers do not assign the chip->of_xlate callback
(one exception is gpio-pxa.c) and then it is default-assigned to
of_gpio_simple_xlate() which you can find in gpiolib-of.c as well.

You need to copy this callback to your driver and augment it
properly.

The xlate callback is used to locate the struct gpio_chip and
struct gpio_device as well, by just calling the xlate callback, so if
you code up the right xlate callback, everything should just
work by itself.

this is a guess on what it would look like (just dry coding,
but hopefully the idea works!):

static int spacemit_gpio_xlate(struct gpio_chip *gc,
                                const struct of_phandle_args *gpiospec,
                                u32 *flags)
{
        struct spacemit_gpio *sg =3D gpiochip_get_data(gc);
        int i;

        if (gc->of_gpio_n_cells !=3D 3)
                return -EINVAL;

        if (gpiospec->args_count < gc->of_gpio_n_cells)
                return -EINVAL;

        /* We support maximum 3 gpio_chip instances */
        i =3D gpiospec->args[0];
        if (i >=3D 3)
                return -EINVAL;

        /* OK is this the right gpio_chip out of the three ? */
        if (gc !=3D sg->gcs[i])
                return -EINVAL;

        /* Are we in range for this GPIO chip */
        if (gpiospec->args[1] >=3D gc->ngpio)
                return -EINVAL;

        if (flags)
                *flags =3D gpiospec->args[2];

        /* Return the hw index */
        return gpiospec->args[1];
}

...
gc->of_gpio_n_cells =3D 3;
gc->of_xlate =3D spacemit_gpio_xlate;

If it works as I hope, this will make the code in gpiolib-of.c in
of_find_gpio_device_by_xlate() calling gpio_device_find()
(which will iterate over all registered gpio_chips and then
of_gpiochip_match_node_and_xlate() will call this custom function
to see if it's the right one and return > 0 when we have the right
chip.

This should work for gpios *only*. When we then come to irqs,
these assume (see gpiolib.c) that we are using
irq_domain_xlate_twocell() when using GPIOLIB_IRQCHIP, so
you either need to roll your own irqchip code or we should fix
the core (I can help with this if the above works).

Several gpio chips use their own domain translation outside
of the gpiolib so you can use this as an intermediate step:
git grep irq_domain_ops drivers/gpio/
... but if you get here, let's patch the core to deal with custom
irqdomain xlate functions in the same manner as above.

I hope this isn't terribly unclear or complicated?
Otherwise tell me and I will try to ... explain more or give
up and say you can use a single 96-pin gpio_chip.

Yours,
Linus Walleij

