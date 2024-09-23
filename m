Return-Path: <linux-kernel+bounces-335606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3658F97E804
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 10:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A00F9B21CB0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 08:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464A01946A2;
	Mon, 23 Sep 2024 08:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ErBlbw9t"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9603019343D
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 08:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727081908; cv=none; b=YQWHiIBhGFalm5ANwTW3RzID4F0lYxqjSVmJ5kRsQkpJXGyU0L7jqWVJzEFZUEh/e1OJPTfV6+5z9nyzEsz+ZGVC5PnmBEvDXGK8cNqdLoSZmgfqojy6l0GRamUcaykVKC4AcYO7SxdyNfN4/ZfIHM8CFKRzBk0LpUxhivNFEec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727081908; c=relaxed/simple;
	bh=kdnLNpiksyAyDdCgLQjNN7iPGmYGohIAUf9by9wS0XQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZJwY8EBDsCgkUumEigjkdl7cfEiX6vsnsNliNTGU5tGrclykqNR52m/m6CAYDEiP3FTjgjkh9azaZtv/cgKXoXRtfjx7fK6ukQ6fybHfXIN10L2bxHlwrB23+cgewNSzztyDRilqkLyCuocOnh6IZkGUQ6Ds/gH7YCCfV8+zcc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ErBlbw9t; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f7ba97ebaaso36181041fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 01:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727081905; x=1727686705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1sQ682pnIkA6X/5BBN5dJdPJY/AuV9vVMjIXL626PQ=;
        b=ErBlbw9tfmx4MBIKXv1tw0UlRBW9Nb1j4rHvWlBfGO9te4vFOrpz/GstyRc8D9pHN6
         mxbtRY7PTxsdbx2rRUbXaOhGWnRJ8i34/1FRTZ8QnoOazVpGMTSq7is946hV9oAKXowI
         jBqKRGRHkcW7E+RxOqxGPIkgnr/NXKvrN+h2duOPA0WAAFr8ZxozMcFgs7azAEDkPWQ5
         9Vj1m3JwJSfP5xJqKM4KQYW2keLL2q15nzoa+7qykcB4+UsHztTKJS0yCs7nCCiIvhtm
         AgOb03XE0TeC5eqr3tjRpK27IXa7sQp0XMownXrw4IUUpsZRlV0G2XuO7G2AkEJ/j1Tc
         l27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727081905; x=1727686705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1sQ682pnIkA6X/5BBN5dJdPJY/AuV9vVMjIXL626PQ=;
        b=E/XbAqZK+x5l7x90ww6g8PFe0BseKrSgI/g6EAfg1WIe+D6QAfz1gVGsYkjFOX9XO8
         BX9Ghf2ELvAeM0EIlBjCTfCe9wyIHDpiGKSc656YBYzCbKMUOtOKdFN2GbqdbX9ZabOd
         aWmHGG+Kry1JwsQpwA8cmHyAom6iDCdhPS4DUwPDHsvuS+UniuNjJaGL5Af0P0FlspBO
         ny2Q4ijk6xse/t8FksxYDyTxqyUWpRK6Pe32/OxWZCxJZvO0NQpW+f0XUXrXvy1x7XYI
         5R16YdbLPgOi0iWZtYQ8MsJFqtctXpa//1/U3Fo2niECuXrBdjASN8yEwEVhNWb0jED+
         I7qA==
X-Forwarded-Encrypted: i=1; AJvYcCWLlVQTWHpNJnKEHBeE46uNHVmKgiVGSoDsLmOYh8/HjN7ICOZ/MEjAXlNl3QG40iTY7ncsADd1FWBBJjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN9WOnK4dd9ad4Ld7oJ6DpMbHlyTvhFYuOXx0rkCPPMHPY7VRG
	tuGXVkcuV7Tw/CUFmVK+AQEXeoLZ9wCXtcMVJeNISrRvq5PUQwyM1bxdT25Tq2vov6WpjVJwd73
	zcObdDzUZPi61oAGYM/TRAbiN9aJNLlQa/VqsXemurSs1exTDomc=
X-Google-Smtp-Source: AGHT+IGPYbsu7Vn5CAEgdlkW3pqRnZF7mQQ31TPIJrhGD4dXpbxvp4/C/8SvXTIMoXcEgDh7ARRBzdgO2mVEO6KbFlQ=
X-Received: by 2002:a05:6512:3b14:b0:535:d4e9:28bb with SMTP id
 2adb3069b0e04-536ad3b7e10mr4529008e87.46.1727081904496; Mon, 23 Sep 2024
 01:58:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903-02-k1-pinctrl-v4-0-d76c00a33b2b@gentoo.org> <20240903-02-k1-pinctrl-v4-2-d76c00a33b2b@gentoo.org>
In-Reply-To: <20240903-02-k1-pinctrl-v4-2-d76c00a33b2b@gentoo.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 23 Sep 2024 10:58:13 +0200
Message-ID: <CACRpkda2M5kpBi9jJvvAH1SzFurs=c9Z+brSJ_MOkvNz=28t_Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] pinctrl: spacemit: add support for SpacemiT K1 SoC
To: Yixun Lan <dlan@gentoo.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Yangyu Chen <cyy@cyyself.name>, Jisheng Zhang <jszhang@kernel.org>, 
	Inochi Amaoto <inochiama@outlook.com>, Icenowy Zheng <uwu@icenowy.me>, 
	Meng Zhang <zhangmeng.kevin@spacemit.com>, Meng Zhang <kevin.z.m@hotmail.com>, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yixun,

thanks for your patch!

Some comments and suggestions below:

On Tue, Sep 3, 2024 at 2:27=E2=80=AFPM Yixun Lan <dlan@gentoo.org> wrote:

> SpacemiT's K1 SoC has a pinctrl controller which use single register
> to describe all functions, which include bias pull up/down(strong pull),
> drive strength, schmitter trigger, slew rate, mux mode.
>
> Signed-off-by: Yixun Lan <dlan@gentoo.org>


> +config PINCTRL_SPACEMIT_K1
> +       tristate "SpacemiT K1 SoC Pinctrl driver"
> +       depends on ARCH_SPACEMIT || COMPILE_TEST
> +       depends on OF
> +       select GENERIC_PINCTRL_GROUPS
> +       select GENERIC_PINMUX_FUNCTIONS
> +       select GENERIC_PINCONF

(...)

> @@ -0,0 +1,1078 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Yixun Lan <dlan@gentoo.org> */
> +
> +#include <linux/bitfield.h>

I think you really just use <linux/bits.h>

> +#include <linux/export.h>

Why?

> +#include <linux/pinctrl/consumer.h>

Why?

> +#include <linux/pinctrl/machine.h>

Why?

> +#include "../core.h"
> +#include "../pinctrl-utils.h"
> +#include "../pinconf.h"
> +#include "../pinmux.h"

All of them, really?

> +static inline void __iomem *spacemit_pin_to_reg(struct spacemit_pinctrl =
*pctrl,
> +                                               unsigned int pin)
> +{
> +       return pctrl->regs + spacemit_pin_to_offset(pin);
> +}

If this is the only user of spacemit_pin_to_offset() then fold it into one
function, I'd say.

> +static unsigned int spacemit_dt_get_pin(u32 value)
> +{
> +       return (value >> 16) & GENMASK(15, 0);
> +}

Make it a static u16 and drop the genmask, shifting 32 bits
16 bits right shifts in zeroes in the top bits.

> +
> +static unsigned int spacemit_dt_get_pin_mux(u32 value)
> +{
> +       return value & GENMASK(15, 0);
> +}

Return static u16

> +static void spacemit_pctrl_dbg_show(struct pinctrl_dev *pctldev,
> +                                   struct seq_file *seq, unsigned int pi=
n)
> +{
> +       struct spacemit_pinctrl *pctrl =3D pinctrl_dev_get_drvdata(pctlde=
v);
> +       const struct spacemit_pin *spin =3D spacemit_get_pin(pctrl, pin);
> +       enum spacemit_pin_io_type type =3D spacemit_to_pin_io_type(spin);
> +       void __iomem *reg;
> +       u32 value;
> +
> +       seq_printf(seq, "offset: 0x%04x ", spacemit_pin_to_offset(pin));
> +       seq_printf(seq, "type: %s ", io_type_desc[type]);
> +
> +       reg =3D spacemit_pin_to_reg(pctrl, pin);
> +       value =3D readl(reg);
> +       seq_printf(seq, "mux: %ld reg: 0x%04x", (value & PAD_MUX), value)=
;
> +}

This is nice and helpful for users and debugging!

> +static int spacemit_pctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
> +                                        struct device_node *np,
> +                                        struct pinctrl_map **maps,
> +                                        unsigned int *num_maps)
> +{
> +       struct spacemit_pinctrl *pctrl =3D pinctrl_dev_get_drvdata(pctlde=
v);
> +       struct device *dev =3D pctrl->dev;
> +       struct device_node *child;
> +       struct pinctrl_map *map;
> +       const char **grpnames;
> +       const char *grpname;
> +       int ngroups =3D 0;
> +       int nmaps =3D 0;
> +       int ret;
> +
> +       for_each_available_child_of_node(np, child)
> +               ngroups +=3D 1;
> +
> +       grpnames =3D devm_kcalloc(dev, ngroups, sizeof(*grpnames), GFP_KE=
RNEL);
> +       if (!grpnames)
> +               return -ENOMEM;
> +
> +       map =3D devm_kcalloc(dev, ngroups * 2, sizeof(*map), GFP_KERNEL);
> +       if (!map)
> +               return -ENOMEM;
> +
> +       ngroups =3D 0;
> +       mutex_lock(&pctrl->mutex);

Use a scoped guard in this and other instances:

#include <linux/cleanup.h>

guard(mutex)(&pctrl->mutex);

And just drop the mutex unlock, it will be unlocked when you
exit the function. (narrower scopes are possible consult
git grep guard drivers/gpio).

> +       for_each_available_child_of_node(np, child) {

Instead of the kludgy construction requireing of_node_put at the end of the
function, use for_each_available_child_of_node_scoped().

> +static int spacemit_pmx_set_mux(struct pinctrl_dev *pctldev,
> +                               unsigned int fsel, unsigned int gsel)
> +{
> +       struct spacemit_pinctrl *pctrl =3D pinctrl_dev_get_drvdata(pctlde=
v);
> +       const struct group_desc *group;
> +       const struct spacemit_pin_mux_config *configs;
> +       unsigned int i, mux;
> +       void __iomem *reg;
> +
> +       group =3D pinctrl_generic_get_group(pctldev, gsel);
> +       if (!group)
> +               return -EINVAL;
> +
> +       configs =3D group->data;
> +
> +       for (i =3D 0; i < group->grp.npins; i++) {
> +               const struct spacemit_pin *spin =3D configs[i].pin;
> +               u32 value =3D configs[i].config;
> +               unsigned long flags;
> +
> +               reg =3D spacemit_pin_to_reg(pctrl, spin->pin);
> +               mux =3D spacemit_dt_get_pin_mux(value);
> +
> +               raw_spin_lock_irqsave(&pctrl->lock, flags);
> +               value =3D readl_relaxed(reg) & ~PAD_MUX;
> +               writel_relaxed(mux | value, reg);
> +               raw_spin_unlock_irqrestore(&pctrl->lock, flags);

Use a guard() clause for the lock instead.

> +static int spacemit_request_gpio(struct pinctrl_dev *pctldev,
> +                                struct pinctrl_gpio_range *range,
> +                                unsigned int pin)
> +{
> +       struct spacemit_pinctrl *pctrl =3D pinctrl_dev_get_drvdata(pctlde=
v);
> +       const struct spacemit_pin *spin =3D spacemit_get_pin(pctrl, pin);
> +       void __iomem *reg;
> +
> +       reg =3D spacemit_pin_to_reg(pctrl, pin);
> +       writel(spin->gpiofunc, reg);

Doesn't this register write require any locking?

> +static int spacemit_pin_set_config(struct spacemit_pinctrl *pctrl,
> +                                  unsigned int pin, u32 value)
> +{
> +       const struct spacemit_pin *spin =3D spacemit_get_pin(pctrl, pin);
> +       void __iomem *reg;
> +       unsigned long flags;
> +       unsigned int mux;
> +
> +       if (!pin)
> +               return -EINVAL;
> +
> +       reg =3D spacemit_pin_to_reg(pctrl, spin->pin);
> +
> +       raw_spin_lock_irqsave(&pctrl->lock, flags);
> +       mux =3D readl_relaxed(reg) & PAD_MUX;
> +       writel_relaxed(mux | value, reg);
> +       raw_spin_unlock_irqrestore(&pctrl->lock, flags);

Use a scoped guard.

Yours,
Linus Walleij

