Return-Path: <linux-kernel+bounces-325796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A669975E4E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 03:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF2181F229E3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 01:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CA43C39;
	Thu, 12 Sep 2024 01:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bAqaktV0"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F642207A
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 01:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726102916; cv=none; b=rrj0dC1rVHhmbRIUQ/nxW3BxV1ang/ToPl94BePaFUvZV5Y/igCiQSr+0EsNsqf4RLfuPU0fqXVyuniir/e/WpaYGg4rYYtsPgOsxkCLS/v926unZXZpo6dxKkFiZl6CnD1hKAlrU67Cws3LcSWvIU6PumGvoFZ+lnTIpD8dK9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726102916; c=relaxed/simple;
	bh=kJU26pPRhGToUKUFi85skQeav+xd7AnLywRWtRm7W18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YMFssbAtU3bnyIlk9C7ebM4Kh15mARvySXjiOBa9dJ19abaVGKXbEJ4xrx4QEHpJP7gf8KJfz3lyU4jwxqRK/6K7mzmdBzLmNyWxui+FwKnK3XHO2swE1xswNbBytLKaaIw72aZjcvpl4uTm+hlZE41WgHxoCfPFG3U3G34I5zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bAqaktV0; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d8abac30ddso331545a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 18:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726102914; x=1726707714; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tRjDvU6aAi48YkHtJhRhvOJBbiA6iwkoeMSU2WRRnBo=;
        b=bAqaktV0tnknWDNrcF8F+1hjZSlJgRwb/hlQZt0kvAu1tVnNYeJ4kyQXYGwMjK5Xi+
         TS0KZSmfsS3QbBlKQ5fCN+0ibi8CA9zHAVuk26Kg6e5sFrUxa1hLlfswz+U59VJhRRrE
         drV8H4lSpA29xANdxhilmJZQWU5/iWPnDfxxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726102914; x=1726707714;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tRjDvU6aAi48YkHtJhRhvOJBbiA6iwkoeMSU2WRRnBo=;
        b=SgIIvTN53gUwhxSAYYNrL6dA0GikPEYLpDIdzRePNxuAnnWAkTQ5owV9VUytEvbe5U
         CLfEbcB38xIgNcfqnll5qRT4fO2tQl8F3FAg9/V48s3WQhK26sbiNUfitR610IhoH6WF
         HOD86LXHwZ9nGm84JfrDobvesIBQimxHp2N5VMB/W7+JgW3esK5tfymxx5k7HvcGMeW4
         b6w7Xv0K8TYjJ7zKDR9dsAAPHWGrBcMANMnYvwedHuaa1wlVzMO2m6yhP2/TAbG1LxOq
         N+NeAPJYyNye3Tk2et/UNMiezz5hZXCc4iAKmHAP6JGODmDSKHJlIlcDLlkhVUU9fL71
         Pq8w==
X-Forwarded-Encrypted: i=1; AJvYcCV2Svr0OEFtaHPZG488qhWsTd6YMd3mjecqwELDV7e4VXm5cHSnAeBUdZLwDLfWLUmYwaKHWIqInSd6kt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYaGgqiaulIaGHl7ThSJ+OR6d3rtnqbYx8E+r+c3+oWKvKJFkS
	3MNO/WtB2B6tqNEiOL9/vUAwuDfFEpEBpwCq6gBhDHlGmXxrX7RfA79WvoJngzVhBrfXqnq46Ux
	90Rncp+Yx9NXJ34yJcuOs2zZIwgW5sIDe5BFL
X-Google-Smtp-Source: AGHT+IF31TUjDo7KUcJ4eOYRKugBkkOAMYiZLxRJOWoEIybKSjD8iJNIZbH1qMVevkKdfr2Tt0Enj2PXz2RlvPMrbDw=
X-Received: by 2002:a17:90a:f2cd:b0:2d3:ca3f:7f2a with SMTP id
 98e67ed59e1d1-2db9ffdcdcbmr1199052a91.22.1726102914193; Wed, 11 Sep 2024
 18:01:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com> <20240911062511.494855-19-patrick.rudolph@9elements.com>
In-Reply-To: <20240911062511.494855-19-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 19:01:40 -0600
Message-ID: <CAFLszTgqRMqbkQuMkyeQqKK2eNe=d6cEiS7TTV0qbm8vUZgPtg@mail.gmail.com>
Subject: Re: [PATCH v3 18/30] drivers/cpu: Add generic armv8 cpu driver
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, 
	Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"

Hi Patrick,

On Wed, 11 Sept 2024 at 00:25, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Add a generic driver that binds to armv8 CPU nodes.
>
> TEST: Booted on QEMU sbsa and verify the driver binds to CPU nodes.
>       Confirmed with FWTS that all ACPI processor devices are present.
>
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

add more detail (as per Peter's comments)

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

drop

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

Isn't this uclass_id_count(UCLASS_CPU) ?

> +}
> +
> +#ifdef CONFIG_ACPIGEN
> +static int acpi_cpu_fill_ssdt(const struct udevice *dev, struct acpi_ctx *ctx)
> +{
> +       uint core_id = dev_seq(dev);
> +
> +       acpigen_write_processor_device(ctx, core_id);

error checking?

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

Regards,
Simon

