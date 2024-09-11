Return-Path: <linux-kernel+bounces-324619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54700974EE5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 799AE1C21D9F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BD1155A52;
	Wed, 11 Sep 2024 09:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIz5pQbi"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1E845C18
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 09:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047757; cv=none; b=A/2Ms3rm3W9rPccclzsnH59p/WcMu9jo90odCjZIoEtSRlOqsHbbFc7JhZrVghWWTeXDvs4pBPr9U8oMleJQWZrzy5FsckMtBUflRt5Mf/0PM2Nh7xVHFUy1P8nm8qvpUjhHXV2/qhbMZ8Ghb8b6x948hWjTuXSqT6mMNeA3nYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047757; c=relaxed/simple;
	bh=u7adCr2/AVh8dqUOTa6WfjvqAM+UNdlwuqeUwQZjyZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZlF5T7U0ipmomZdaJ4/sQnObrUXVbtgw9CGZACAZhf1oY+kJe5csReUICIFaDS/cQeTLtCv6vOzu4Yz2LibvTA4bI9CtXdWvKo5ZZhLSwf2+sq4/W+nJ/nW9eW5rdWjxu2ZsJg9kFV6gitV+cRVmqP9YOdK9Z8FECGc9paXz+Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIz5pQbi; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c25554ec1eso8479772a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 02:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726047754; x=1726652554; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=863DgLCAp35A9za5tANeGLW6hjLjEYBPTqOZ90HuJVk=;
        b=hIz5pQbiem98Jm1bCmnF0mJPTGgTqwyzGviRi7Ho7ZH85LzElRlDy4F/cXqdP4rfy0
         r4OFITK3RXGgkMOyMRncwicWuDe0iFvVaTZA4TAi9swL5HdHvZUc4+DfaLBIflMNibcS
         BuQUL+/nFfZRbpCA3OAHEO8RArg4aTob2w6fF8gZEKcNUk/DODoffIuqXKmFCWQaGs1B
         vON4dYE6Rff5/gc2xbebx2EYv7AWs5OqSpZFyNuLErLyj6eYDwwKB8FTz9wSaJyEecaz
         cnB60EZZhnncE0IclebnmDz+s9Ya9GjkV4gGWthsH+foUtjkyZxWeZJaie8eoMt7DaZo
         LpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726047754; x=1726652554;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=863DgLCAp35A9za5tANeGLW6hjLjEYBPTqOZ90HuJVk=;
        b=AjVJwEuMGGoPWKM0vZXhFU+GznK1DbZsYe3aXH5Ae1773q6MD8WZMzNgshi4xc0p02
         6Lzuf6fXkzwseYq93HNHCa8QDHHbC/M7MiUB0Mi4Zz692UaUBmpmugCgVJ3aMPu+GlfF
         z8MBtrtRzuzGqo3kZOJbhmq4xFi/1d5pEqwwWBH0kj1cPzyJGmidJW5C8p08U5+emvV/
         yS0alVYpf9BnW0nQupcuhkWlfxrxC36VL65I14N8JKTwKeJokyWmChuQ16JbUQpsLGOt
         7XsJhbdwvA5z5wS+OnbA9wYRdV6C3u++6XrzoxpLZ3iTubkINAA1QmAmK1UxXq3c2caE
         mqzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4v6q6lFKNq7LHTnzB1YjScYr+JAHWx+x56XEGgfwR3FbFNlnmuiO6RHDaf4VsYlGj7qZ3zebj0aqu6I0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwaQ+5MMxnlopGrExmjxxWhLJtgOsaEwofv/x8IjG5Cm905Gc8
	0sC6g3gG2vhlNqZf0SG9xRnJrcQn+qeAXZaRd6FCs0hkBXCErgPDZds2ssZgGBh1Wm0PmEgh/qK
	DmY2llT0lEtV3mZdfqVArOb89Sg0=
X-Google-Smtp-Source: AGHT+IFlzKbZTWZD4vQvI+BO7TG/R19WxE+MW48UFKQCe3ho7FxcSIasgfu8CiBhh/krbj2bBUDbU6FePGGJEF9hu6k=
X-Received: by 2002:a05:6402:1d4d:b0:5c4:95d:da34 with SMTP id
 4fb4d7f45d1cf-5c4095ddb7cmr3553185a12.26.1726047752883; Wed, 11 Sep 2024
 02:42:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com> <20240911062511.494855-19-patrick.rudolph@9elements.com>
In-Reply-To: <20240911062511.494855-19-patrick.rudolph@9elements.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 11 Sep 2024 10:41:59 +0100
Message-ID: <CALeDE9Mgpdg7CFJtosOT3fJBnQdrx-D7Rp91ownaGxKrwLfu3Q@mail.gmail.com>
Subject: Re: [PATCH v3 18/30] drivers/cpu: Add generic armv8 cpu driver
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, 
	Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Hi Patrick,

> Add a generic driver that binds to armv8 CPU nodes.

What is the purpose of this driver? Someone reading this should be
able to ascertain the point of this from the git log at some point in
the future, what does binding a generic driver to the cpu nodes
achieve?

> TEST: Booted on QEMU sbsa and verify the driver binds to CPU nodes.
>       Confirmed with FWTS that all ACPI processor devices are present.

This comment I think should be below the -- bit

> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  drivers/cpu/Kconfig     |  6 +++
>  drivers/cpu/Makefile    |  2 +
>  drivers/cpu/armv8_cpu.c | 90 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 98 insertions(+)
>  create mode 100644 drivers/cpu/armv8_cpu.c
>
> diff --git a/drivers/cpu/Kconfig b/drivers/cpu/Kconfig
> index 5c06cd9f60..9c0df331d7 100644
> --- a/drivers/cpu/Kconfig
> +++ b/drivers/cpu/Kconfig
> @@ -26,6 +26,12 @@ config CPU_RISCV
>         help
>           Support CPU cores for RISC-V architecture.
>
> +config CPU_ARMV8
> +       bool "Enable generic ARMv8 CPU driver"
> +       depends on CPU && ARM64
> +       help
> +         Support CPU cores for armv8 architecture.
> +
>  config CPU_MICROBLAZE
>         bool "Enable Microblaze CPU driver"
>         depends on CPU && MICROBLAZE
> diff --git a/drivers/cpu/Makefile b/drivers/cpu/Makefile
> index bc75d9b974..773395693a 100644
> --- a/drivers/cpu/Makefile
> +++ b/drivers/cpu/Makefile
> @@ -6,10 +6,12 @@
>
>  obj-$(CONFIG_CPU) += cpu-uclass.o
>
> +
>  obj-$(CONFIG_ARCH_BMIPS) += bmips_cpu.o
>  obj-$(CONFIG_ARCH_IMX8) += imx8_cpu.o
>  obj-$(CONFIG_ARCH_AT91) += at91_cpu.o
>  obj-$(CONFIG_ARCH_MEDIATEK) += mtk_cpu.o
> +obj-$(CONFIG_CPU_ARMV8) += armv8_cpu.o
>  obj-$(CONFIG_CPU_IMX) += imx8_cpu.o
>  obj-$(CONFIG_CPU_MPC83XX) += mpc83xx_cpu.o
>  obj-$(CONFIG_CPU_RISCV) += riscv_cpu.o
> diff --git a/drivers/cpu/armv8_cpu.c b/drivers/cpu/armv8_cpu.c
> new file mode 100644
> index 0000000000..08b8d45f6f
> --- /dev/null
> +++ b/drivers/cpu/armv8_cpu.c
> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2019 Broadcom.
> + */
> +#include <acpi/acpigen.h>
> +#include <asm/armv8/cpu.h>
> +#include <cpu.h>
> +#include <dm.h>
> +#include <dm/acpi.h>
> +#include <asm/io.h>
> +#include <linux/bitops.h>
> +#include <linux/printk.h>
> +#include <linux/sizes.h>
> +
> +static int armv8_cpu_get_desc(const struct udevice *dev, char *buf, int size)
> +{
> +       int cpuid;
> +
> +       cpuid = (read_midr() & MIDR_PARTNUM_MASK) >> MIDR_PARTNUM_SHIFT;
> +
> +       snprintf(buf, size, "CPU MIDR %04x", cpuid);
> +
> +       return 0;
> +}
> +
> +static int armv8_cpu_get_info(const struct udevice *dev,
> +                             struct cpu_info *info)
> +{
> +       info->cpu_freq = 0;
> +       info->features = BIT(CPU_FEAT_L1_CACHE) | BIT(CPU_FEAT_MMU);
> +
> +       return 0;
> +}
> +
> +static int armv8_cpu_get_count(const struct udevice *dev)
> +{
> +       ofnode node;
> +       int num = 0;
> +
> +       ofnode_for_each_subnode(node, dev_ofnode(dev->parent)) {
> +               const char *device_type;
> +
> +               if (!ofnode_is_enabled(node))
> +                       continue;
> +
> +               device_type = ofnode_read_string(node, "device_type");
> +               if (!device_type)
> +                       continue;
> +
> +               if (!strcmp(device_type, "cpu"))
> +                       num++;
> +       }
> +
> +       return num;
> +}
> +
> +#ifdef CONFIG_ACPIGEN
> +static int acpi_cpu_fill_ssdt(const struct udevice *dev, struct acpi_ctx *ctx)
> +{
> +       uint core_id = dev_seq(dev);
> +
> +       acpigen_write_processor_device(ctx, core_id);
> +
> +       return 0;
> +}
> +
> +struct acpi_ops armv8_cpu_acpi_ops = {
> +       .fill_ssdt      = acpi_cpu_fill_ssdt,
> +};
> +#endif
> +
> +static const struct cpu_ops cpu_ops = {
> +       .get_count = armv8_cpu_get_count,
> +       .get_desc  = armv8_cpu_get_desc,
> +       .get_info  = armv8_cpu_get_info,
> +};
> +
> +static const struct udevice_id cpu_ids[] = {
> +       { .compatible = "arm,armv8" },
> +       {}
> +};
> +
> +U_BOOT_DRIVER(arm_cpu) = {
> +       .name           = "arm-cpu",
> +       .id             = UCLASS_CPU,
> +       .of_match       = cpu_ids,
> +       .ops            = &cpu_ops,
> +       .flags          = DM_FLAG_PRE_RELOC,
> +       ACPI_OPS_PTR(&armv8_cpu_acpi_ops)
> +};
> --
> 2.46.0
>

