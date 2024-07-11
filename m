Return-Path: <linux-kernel+bounces-249688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E523B92EE8B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58B91B21482
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D718D16D9DE;
	Thu, 11 Jul 2024 18:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x6c9Ar9c"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3919816D307
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 18:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720721604; cv=none; b=nH/6z/652CYkP8iKaYKdFivJzdgYqrncNJ7vQGQrDeKy4Ix5MicatK5QPPCWOVtHaBZGUH06MiG+gSKFWWZ6FEYj0ZaK9CJisZdZCs/p0PgYhg8djwq36Uwrm2DrE/swoPpMSAZkltD1ehF9tGNjscCKkh5n/lqfnDmsg/NK+e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720721604; c=relaxed/simple;
	bh=/dG2UvQ+EH+yqXZlVbqRDI/un7i5XAyyN6aOd95/g/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SQZuOW56UOB/0/1OvzN3f3xs9C5Tyo9UXQWDKr305xr/TiQvB6W1s466t6GhvGz3AXZtdRb2wSC3KGA4mpMEm++maYwuzxhCQYoQhQ+A+51ZkxnlMkPR0pIhSKGJ97STiDy3C9XqbPjy9DBkPYm4JndHluQaTtBfPp6M3bbRDRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x6c9Ar9c; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6510c0c8e29so11537017b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 11:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720721600; x=1721326400; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nyJ6P+FkdwGhVRPUnMvVBafw0z1eayMg2GyL0TyLrvU=;
        b=x6c9Ar9ckdFW3hKUFiVdTDuAj9/vIslMcR8xWNTjijnNRO94C5jfz24UgpVzmUEr6R
         TzgxuyVAWkE198HkDME6Xtw9PVLSqWzQXmUjF77njHs81cF6EEkDUXG36+rOKtKgfP6n
         oSP3V+lJVOK/QzHWXXN+61b8gCWzFJLbc9JlyrBzrliBMSSKluZ5YIR/KnpoE1QZsjIi
         KCJuu32G55jiu0B81CH8sr6aGh77uIiZCxioiB/hh4Mz21jA/fd7Y1OVHnl6uwKc7svr
         c+Lb/hgzbPoWpYcOmHnmXgJ7qH4K8r76vRFs/qR/jJqO1VzNCfP9LANAulNBE5rXeo8o
         RCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720721600; x=1721326400;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nyJ6P+FkdwGhVRPUnMvVBafw0z1eayMg2GyL0TyLrvU=;
        b=CKnDmGXtqXpTlBbBKxp7sduR/5u7Bh8mfhFoeD5vmKYsdhrM2+ap9EgT2nhzN3yJ1f
         a+vA3T7yxg5KfptN/kfxlWShgP1lZ9QSjemXovDX1VMlF9g/yMJD+rur6eSxmEVLmlZB
         EXppJ/ZlAw71f24JC7zjtKRoWx+3W9JxwfSRYNyVHdFT77HI6XWj16zV0pBxsyZEIev0
         CzzvwaYR1NCRdyAzEI+0NM1PXObQpTW9Go1Ha5HgNWNJKLV4HCuwB9HcF7XhFAcPv77Q
         j3JwMVvg/yMQpcjbfuW5Y7J+ZP8d0aKxLdjb3jLOmWIG/RB+sPLOQ7CgmhrKIDBmih+z
         7Ipw==
X-Forwarded-Encrypted: i=1; AJvYcCUo7BP9dvWaRQUVgfAwvDuiy9kfya/EMZnz+0H+DJJ2GYLNcRmK02Mr/sFNMIWmCCs1WiAHSY7Jw4Usr5QYtUMzOKMKpe8ie3RC6TWo
X-Gm-Message-State: AOJu0YxUZjn2n6By2O39Bm3m5u/Q0cndYW1bk6XxK1zna44vr6rVdlmX
	0bZsaOr25kJIfJRfbbGngDLDKCptF+st2T653Z5W06a3TQaqRXf3sKwcLioTNWh9AcQfsen5dl0
	bDYXQ7N/aktoMl297pnnMYxYtPtbjsKp4wCqc
X-Google-Smtp-Source: AGHT+IEEQU5biwkInlxNgBrM2IpMWrKKZsCPM/P2i2VC7zYaPlXK0eCVtc6vDTBA+rUofvGyIoZFTCjIctuVqbLEHM4=
X-Received: by 2002:a05:690c:6112:b0:631:ffc1:4397 with SMTP id
 00721157ae682-658ef34a2e9mr120082367b3.29.1720721599990; Thu, 11 Jul 2024
 11:13:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702191650.57364-1-tmaimon77@gmail.com> <20240702191650.57364-3-tmaimon77@gmail.com>
In-Reply-To: <20240702191650.57364-3-tmaimon77@gmail.com>
From: Benjamin Fair <benjaminfair@google.com>
Date: Thu, 11 Jul 2024 11:12:42 -0700
Message-ID: <CADKL2t4F20iFdwxDH0PXCa8-HO_cDhYzu+ObyzwaazWWkKj-tg@mail.gmail.com>
Subject: Re: [PATCH v26 2/3] reset: npcm: register npcm8xx clock auxiliary bus device
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, tali.perry1@gmail.com, 
	joel@jms.id.au, venture@google.com, yuenn@google.com, 
	openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jul 2024 at 12:17, Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> Add NPCM8xx clock controller auxiliary bus device registration.
>
> The NPCM8xx clock controller is registered as an aux device because the
> reset and the clock controller share the same register region.
>
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>

I booted a kernel with this driver and verified that basic
functionality works fine.

Tested-by: Benjamin Fair <benjaminfair@google.com>

> ---
>  drivers/reset/Kconfig               |  1 +
>  drivers/reset/reset-npcm.c          | 74 ++++++++++++++++++++++++++++-
>  include/soc/nuvoton/clock-npcm8xx.h | 16 +++++++
>  3 files changed, 90 insertions(+), 1 deletion(-)
>  create mode 100644 include/soc/nuvoton/clock-npcm8xx.h
>
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 7112f5932609..31ec8795c105 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -148,6 +148,7 @@ config RESET_MESON_AUDIO_ARB
>  config RESET_NPCM
>         bool "NPCM BMC Reset Driver" if COMPILE_TEST
>         default ARCH_NPCM
> +       select AUXILIARY_BUS
>         help
>           This enables the reset controller driver for Nuvoton NPCM
>           BMC SoCs.
> diff --git a/drivers/reset/reset-npcm.c b/drivers/reset/reset-npcm.c
> index 8935ef95a2d1..aa68b947226a 100644
> --- a/drivers/reset/reset-npcm.c
> +++ b/drivers/reset/reset-npcm.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  // Copyright (c) 2019 Nuvoton Technology corporation.
>
> +#include <linux/auxiliary_bus.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> @@ -10,11 +11,14 @@
>  #include <linux/property.h>
>  #include <linux/reboot.h>
>  #include <linux/reset-controller.h>
> +#include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/regmap.h>
>  #include <linux/of_address.h>
>
> +#include <soc/nuvoton/clock-npcm8xx.h>
> +
>  /* NPCM7xx GCR registers */
>  #define NPCM_MDLR_OFFSET       0x7C
>  #define NPCM7XX_MDLR_USBD0     BIT(9)
> @@ -89,6 +93,7 @@ struct npcm_rc_data {
>         const struct npcm_reset_info *info;
>         struct regmap *gcr_regmap;
>         u32 sw_reset_number;
> +       struct device *dev;
>         void __iomem *base;
>         spinlock_t lock;
>  };
> @@ -372,6 +377,67 @@ static const struct reset_control_ops npcm_rc_ops = {
>         .status         = npcm_rc_status,
>  };
>
> +static void npcm_clock_unregister_adev(void *_adev)
> +{
> +       struct auxiliary_device *adev = _adev;
> +
> +       auxiliary_device_delete(adev);
> +       auxiliary_device_uninit(adev);
> +}
> +
> +static void npcm_clock_adev_release(struct device *dev)
> +{
> +       struct auxiliary_device *adev = to_auxiliary_dev(dev);
> +       struct npcm_clock_adev *rdev = to_npcm_clock_adev(adev);
> +
> +       kfree(rdev);
> +}
> +
> +static struct auxiliary_device *npcm_clock_adev_alloc(struct npcm_rc_data *rst_data, char *clk_name)
> +{
> +       struct npcm_clock_adev *rdev;
> +       struct auxiliary_device *adev;
> +       int ret;
> +
> +       rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
> +       if (!rdev)
> +               return ERR_PTR(-ENOMEM);
> +
> +       rdev->base = rst_data->base;
> +
> +       adev = &rdev->adev;
> +       adev->name = clk_name;
> +       adev->dev.parent = rst_data->dev;
> +       adev->dev.release = npcm_clock_adev_release;
> +       adev->id = 555u;
> +
> +       ret = auxiliary_device_init(adev);
> +       if (ret) {
> +               kfree(rdev);
> +               return ERR_PTR(ret);
> +       }
> +
> +       return adev;
> +}
> +
> +static int npcm8xx_clock_controller_register(struct npcm_rc_data *rst_data, char *clk_name)
> +{
> +       struct auxiliary_device *adev;
> +       int ret;
> +
> +       adev = npcm_clock_adev_alloc(rst_data, clk_name);
> +       if (IS_ERR(adev))
> +               return PTR_ERR(adev);
> +
> +       ret = auxiliary_device_add(adev);
> +       if (ret) {
> +               auxiliary_device_uninit(adev);
> +               return ret;
> +       }
> +
> +       return devm_add_action_or_reset(rst_data->dev, npcm_clock_unregister_adev, adev);
> +}
> +
>  static int npcm_rc_probe(struct platform_device *pdev)
>  {
>         struct npcm_rc_data *rc;
> @@ -392,6 +458,7 @@ static int npcm_rc_probe(struct platform_device *pdev)
>         rc->rcdev.of_node = pdev->dev.of_node;
>         rc->rcdev.of_reset_n_cells = 2;
>         rc->rcdev.of_xlate = npcm_reset_xlate;
> +       rc->dev = &pdev->dev;
>
>         ret = devm_reset_controller_register(&pdev->dev, &rc->rcdev);
>         if (ret) {
> @@ -413,7 +480,12 @@ static int npcm_rc_probe(struct platform_device *pdev)
>                 }
>         }
>
> -       return ret;
> +       switch (rc->info->bmc_id) {
> +       case BMC_NPCM8XX:
> +               return npcm8xx_clock_controller_register(rc, "clk-npcm8xx");
> +       default:
> +               return ret;
> +       }
>  }
>
>  static struct platform_driver npcm_rc_driver = {
> diff --git a/include/soc/nuvoton/clock-npcm8xx.h b/include/soc/nuvoton/clock-npcm8xx.h
> new file mode 100644
> index 000000000000..139130e98c51
> --- /dev/null
> +++ b/include/soc/nuvoton/clock-npcm8xx.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __SOC_NPCM8XX_CLOCK_H
> +#define __SOC_NPCM8XX_CLOCK_H
> +
> +#include <linux/auxiliary_bus.h>
> +#include <linux/container_of.h>
> +
> +struct npcm_clock_adev {
> +       void __iomem *base;
> +       struct auxiliary_device adev;
> +};
> +
> +#define to_npcm_clock_adev(_adev) \
> +       container_of((_adev), struct npcm_clock_adev, adev)
> +
> +#endif
> --
> 2.34.1
>

