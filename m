Return-Path: <linux-kernel+bounces-266024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1E093F969
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 17:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A25BD28268C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599EB158A26;
	Mon, 29 Jul 2024 15:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="REncmxJ6"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129691586C9
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 15:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722266930; cv=none; b=oVjzRHfO9c4/D1Z1bxvQyrOBIW1nCuiYU8P21QR+k12Zx9TutrrU0VnD3lZYJXW+N3uUxVt059he4gUY4PLAcN+36DGHAUuLdf3WQsa44GexbFtqKdTziNFxmrArgK+JLffvRkapLaMqw2L3BOt5AB1BVB0yMkio9epQ/fQdVvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722266930; c=relaxed/simple;
	bh=hxb71KjmppfeCkOjSZfptmJo6KNzdhG83T7R83xQWPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cLpdPOsUjv6FovvKaAaXBC2C1DNrV4E/GG0WjzsQjrB30WwbPU/6zS0VVdfN/vbR//1pAp19Jup5Pmn8DLrRQwOrHfEnoJppyKFcDNPS7L5CmVxTz4g3cBm6nsZgMLwef+NlgPeGbrfD047zngan95YLT8rG5nINZ+UD6FDnfzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=REncmxJ6; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3daf0e73a5bso2480322b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 08:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722266928; x=1722871728; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ROO+CeqLd21JRRNrzbkdGSEbhE/xzmfp1XGEer8URUg=;
        b=REncmxJ6l+I8jUE41GFArqM0tOZXyqwNYiHUdiJRuO5jNNNEWfk9huJZLyud3VYdKn
         WKhtQZ3dmas42ahHLrfXPdOgbb5kOY8lBtP7UWWLlnWkwQ2er9/m7hvVvutSxQmu+0WL
         53dwkRZio7nXT+Mr8WbJ+60Px7VoZAOPozwXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722266928; x=1722871728;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ROO+CeqLd21JRRNrzbkdGSEbhE/xzmfp1XGEer8URUg=;
        b=UnurvKqBuY8Fcyt7dCythet1AWuz3Q7HMoUVSzNWjONL/wt7AbzDwpgs2cuaPmRZcp
         XVIVmz4DlH3y77P1LTc7oR57SIA8yocvJwBwJv4nbINfzfyDfYin7oYxmJMlaU43i+Yj
         GNimsVo7AfTjviHITVdWwfb3h5kVFcIF/miCvcdwlMdwHbChlZlsAvnLGS7jJyty5II8
         tVXepAAfNpdbCWg4wfLso0ttycfj1Aro9OYJMao98UE2kNns5kBeBhcD17DIgRezEyWh
         z1X8Umav+WdWoLG+/E+0D0PnSZIw4xsphrImrumMvmoHg0n9eJEdhxtx79B/FKNypOAd
         sPPw==
X-Forwarded-Encrypted: i=1; AJvYcCW83lEOhltkBk+niF1BJFOwDCNFP1ydGpPHGuWbJGDSDtMVBqpZJVMYtW0gTqkHhU310aNjXjunwvHqvhcHxKDbXw6b9CMirdf2Ugim
X-Gm-Message-State: AOJu0Yz1uJmY4fNgtlvVJgxFjXsosh1kcTXqjeqLi97bmi3GerAYUzx+
	AhFrJNiDIefyEs6WicCIr1wDy+nVGI4tJTD22KHhpqgtZY0fDfC/dNGvXwyGVAaY04c2BLflNtk
	dJHEjrh56AOne2Cp2uzXLVcgYSbhjfx0Nf1Qo
X-Google-Smtp-Source: AGHT+IE/tNGxMukADRuvrh8txTrc0m/BuQNqi4uiyzXwuHfagWvcyPHJf0LkDR+8YzBPoFf7IKjIPGTXxDcRmP+BsAI=
X-Received: by 2002:a05:6808:178d:b0:3da:e08d:888e with SMTP id
 5614622812f47-3db23d5d278mr9867749b6e.38.1722266928044; Mon, 29 Jul 2024
 08:28:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727071742.1735703-1-patrick.rudolph@9elements.com> <20240727071742.1735703-8-patrick.rudolph@9elements.com>
In-Reply-To: <20240727071742.1735703-8-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:28:37 -0600
Message-ID: <CAFLszTh+B=7Y8HyCX20+rX2rse-y7KCH14zLwk-wxUQFXBWHmw@mail.gmail.com>
Subject: Re: [PATCH 07/17] arm: acpi: Add generic ACPI methods
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, mbrugger@suse.com, 
	pbrobinson@gmail.com, trini@konsulko.com, bmeng.cn@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Patrick,

On Sat, 27 Jul 2024 at 01:20, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Add generic ACPI code to generate
> - MADT GICC
> - MADT GICD
>
> as commonly used on arm platforms.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  arch/arm/include/asm/acpi_table.h | 18 +++++++++++++
>  arch/arm/lib/Makefile             |  1 +
>  arch/arm/lib/acpi_table.c         | 44 +++++++++++++++++++++++++++++++
>  3 files changed, 63 insertions(+)
>  create mode 100644 arch/arm/lib/acpi_table.c
>
> diff --git a/arch/arm/include/asm/acpi_table.h b/arch/arm/include/asm/acpi_table.h
> index e69de29bb2..8a25e93847 100644
> --- a/arch/arm/include/asm/acpi_table.h
> +++ b/arch/arm/include/asm/acpi_table.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#ifndef __ASM_ACPI_TABLE_H__
> +#define __ASM_ACPI_TABLE_H__
> +
> +#ifndef __ACPI__
> +
> +void acpi_write_madt_gicc(struct acpi_madt_gicc *gicc, uint cpu_num,
> +                         uint perf_gsiv, ulong phys_base, ulong gicv,
> +                         ulong gich, uint vgic_maint_irq, ulong mpidr,
> +                         uint efficiency);
> +
> +void acpi_write_madt_gicd(struct acpi_madt_gicd *gicd, uint gic_id,
> +                         ulong phys_base, uint gic_version);

Exported function should have full comments.

> +
> +#endif /* !__ACPI__ */
> +
> +#endif /* __ASM_ACPI_TABLE_H__ */
> diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
> index 67275fba61..a7efed6771 100644
> --- a/arch/arm/lib/Makefile
> +++ b/arch/arm/lib/Makefile
> @@ -86,6 +86,7 @@ obj-y += psci-dt.o
>  obj-$(CONFIG_DEBUG_LL) += debug.o
>
>  obj-$(CONFIG_BLOBLIST)  += xferlist.o
> +obj-$(CONFIG_GENERATE_ACPI_TABLE) += acpi_table.o
>
>  # For EABI conformant tool chains, provide eabi_compat()
>  ifneq (,$(findstring -mabi=aapcs-linux,$(PLATFORM_CPPFLAGS)))
> diff --git a/arch/arm/lib/acpi_table.c b/arch/arm/lib/acpi_table.c
> new file mode 100644
> index 0000000000..ea3a6343c9
> --- /dev/null
> +++ b/arch/arm/lib/acpi_table.c
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Based on acpi.c from coreboot
> + *
> + * Copyright (C) 2024 9elements GmbH
> + */
> +
> +#define LOG_CATEGORY LOGC_ACPI
> +
> +#include <acpi/acpigen.h>
> +#include <acpi/acpi_device.h>
> +#include <acpi/acpi_table.h>
> +#include <string.h>
> +
> +void acpi_write_madt_gicc(struct acpi_madt_gicc *gicc, uint cpu_num,
> +                         uint perf_gsiv, ulong phys_base, ulong gicv,
> +                         ulong gich, uint vgic_maint_irq, ulong mpidr,
> +                         uint efficiency)
> +{
> +       memset(gicc, '\0', sizeof(struct acpi_madt_gicc));
> +       gicc->type = ACPI_APIC_GICC;
> +       gicc->length = sizeof(struct acpi_madt_gicc);
> +       gicc->cpu_if_num = cpu_num;
> +       gicc->processor_id = cpu_num;
> +       gicc->flags = ACPI_MADTF_ENABLED;
> +       gicc->perf_gsiv = perf_gsiv;
> +       gicc->phys_base = phys_base;
> +       gicc->gicv = gicv;
> +       gicc->gich = gich;
> +       gicc->vgic_maint_irq = vgic_maint_irq;
> +       gicc->mpidr = mpidr;
> +       gicc->efficiency = efficiency;
> +}
> +
> +void acpi_write_madt_gicd(struct acpi_madt_gicd *gicd, uint gic_id,
> +                         ulong phys_base, uint gic_version)
> +{
> +       memset(gicd, '\0', sizeof(struct acpi_madt_gicd));
> +       gicd->type = ACPI_APIC_GICD;
> +       gicd->length = sizeof(struct acpi_madt_gicd);
> +       gicd->gic_id = gic_id;
> +       gicd->phys_base = phys_base;
> +       gicd->gic_version = gic_version;
> +}
> --
> 2.45.2
>

REgards,
Simon

