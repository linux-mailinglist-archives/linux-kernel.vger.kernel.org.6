Return-Path: <linux-kernel+bounces-300163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C74A95DFB1
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 20:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CAE41C20DE1
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 18:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663B57DA6A;
	Sat, 24 Aug 2024 18:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3krLGVWa"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3411978C7B
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 18:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724525300; cv=none; b=b4ar3OGHQMdmpdCeIjPIzMQl5f/5JAYx1KvFlJ+LGChHmeehhKovbB08CmpeK6oOB0OrVDR3q2mUakw+FmZVYVSseNba4etUqIDHrQ4t4WyqRxpqX36D/46M7sDCC3RDoFHl2tNzoVRLEVJ6EetiL6M96tDTnLqGzQgmIy4jbQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724525300; c=relaxed/simple;
	bh=yA2fkVxKFAd8XVVfl317pROI8z7mRTJGobq+mL3kWk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PICdkaNo09O9ODZu4aF/y3SyZ0tZvlA06piRKglVNiykSZz76waWZaDA5/WfITVx4C/tLRovIZhrDEvoI47MuedDYtWkyQsfWRg6/9xdlGCR9OCwviNaz4Y2keAiuOjLlASbiOrtfsvZNozjzUSwX2h82ZLi11mYCe+dNeO3WYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3krLGVWa; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-201fed75b38so127765ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 11:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724525298; x=1725130098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKErnblzu3qV8jlaIU+bnU6QfXKqC2FHZXzJA/CSZ8w=;
        b=3krLGVWaXMzZ+1eiqigTJmZ7IjqWAaqiuY7z5ArBVs8QCMiCBXyNP3fdGdkUKJcSiq
         4zH2vRNJeXfTeS545/L7tqYI5GAB3JOiC674aGiLdpDHkZKm/4hI0EumYV7Leeyphwpx
         I5RQhHZzCTo2hd00CJaOlB20exT5IBmGBZNP89am5w/9kdZmwKxeBSdR19NwX1PvudOL
         rA0P2Xr/cdsx8DX6BDT6xhEl3WedAjcZEh96dRmmsGpi2DlLu8vpW+OQIEz24mDHlzDa
         nblvcbsq7u9GKTt94mucNQfV2iw0Q86wusenkyiiW8lvCfeGaMG+wt5cw1BqZ/LFehZZ
         gN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724525298; x=1725130098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jKErnblzu3qV8jlaIU+bnU6QfXKqC2FHZXzJA/CSZ8w=;
        b=ZHAlYNMcDjs3b5IkH6UDAE/QD+f6D4wSQZhnrRZ9m7Kr1H1nhSEiFTOCzFZ+QqM8+l
         LXAG/zJfOYS1nxcCX3UTeeiyeXV7oSY/gcZ5SlxoLV6HbEkjj7t4wYXQ6mr1XwBPxIUe
         6U2LOL4fO59XrEDGt0tSPZRPg6ucQanYT36MqVyEIRcvI0KQVlO2mmImHj+Sd3gBvq94
         s/ZN4ry5GMD6jcls81foOaPPcoRPujc/pwmh9EnMAEtl7OKZogavDwa7rNC+U0dbDRNW
         6sZigaOflXUM5JjHVPoFJ6bEEikS41z1w/2+mpGW+XvD4d7TE4Rn18dPibsWuODqTVOk
         KnbQ==
X-Forwarded-Encrypted: i=1; AJvYcCV91M7cg7/dP+mVnzhoVt/yBrDK6TUYp9FAMr47bES/4vbKL3oKp9Kd3ElMcnlTO9P6V1+sHhsKEMrN/v0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLGnnIjwJ9N3WgpHdNz44Ye88oOd59pIYVXOv2/VL3Ll+kMn63
	eHMgzDid69e37LwRMfEHS00i2GLUsAgqbsap0RSxj40UFrUKEe2jBBbB2uaHqf7rGDMRqpdlPu6
	TDH3Jz3VrPJVD/GqOUvWV9zrOJ7PmFHtm79zV
X-Google-Smtp-Source: AGHT+IFaNVteBFzMiFWCpgH6wgjjF8w/YnjGBABCXbDl1cpa7wkJBrffPiim9wdqoNrbLhIPnyVyTY+M0+/aZqUMbZ4=
X-Received: by 2002:a17:903:1c4:b0:201:df0b:2b77 with SMTP id
 d9443c01a7336-203b28bc953mr2164215ad.0.1724525298052; Sat, 24 Aug 2024
 11:48:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727071742.1735703-1-patrick.rudolph@9elements.com> <20240727071742.1735703-8-patrick.rudolph@9elements.com>
In-Reply-To: <20240727071742.1735703-8-patrick.rudolph@9elements.com>
From: Moritz Fischer <moritzf@google.com>
Date: Sat, 24 Aug 2024 11:48:07 -0700
Message-ID: <CAFyOScp-gskCBxAsha2tsN83tfTrUtLBnARNpEQ18_ENO+aE6g@mail.gmail.com>
Subject: Re: [PATCH 07/17] arm: acpi: Add generic ACPI methods
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, mbrugger@suse.com, 
	pbrobinson@gmail.com, trini@konsulko.com, sjg@chromium.org, 
	bmeng.cn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Patrick,

On Sat, Jul 27, 2024 at 12:21=E2=80=AFAM Patrick Rudolph
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
> diff --git a/arch/arm/include/asm/acpi_table.h b/arch/arm/include/asm/acp=
i_table.h
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
> +
> +#endif /* !__ACPI__ */
> +
> +#endif /* __ASM_ACPI_TABLE_H__ */
> diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
> index 67275fba61..a7efed6771 100644
> --- a/arch/arm/lib/Makefile
> +++ b/arch/arm/lib/Makefile
> @@ -86,6 +86,7 @@ obj-y +=3D psci-dt.o
>  obj-$(CONFIG_DEBUG_LL) +=3D debug.o
>
>  obj-$(CONFIG_BLOBLIST)  +=3D xferlist.o
> +obj-$(CONFIG_GENERATE_ACPI_TABLE) +=3D acpi_table.o
>
>  # For EABI conformant tool chains, provide eabi_compat()
>  ifneq (,$(findstring -mabi=3Daapcs-linux,$(PLATFORM_CPPFLAGS)))
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
> +       gicc->type =3D ACPI_APIC_GICC;
> +       gicc->length =3D sizeof(struct acpi_madt_gicc);
> +       gicc->cpu_if_num =3D cpu_num;
> +       gicc->processor_id =3D cpu_num;
> +       gicc->flags =3D ACPI_MADTF_ENABLED;
> +       gicc->perf_gsiv =3D perf_gsiv;
> +       gicc->phys_base =3D phys_base;
> +       gicc->gicv =3D gicv;
> +       gicc->gich =3D gich;
> +       gicc->vgic_maint_irq =3D vgic_maint_irq;

I think you're lacking the rdists here?

> +       gicc->mpidr =3D mpidr;
> +       gicc->efficiency =3D efficiency;
> +}
> +
> +void acpi_write_madt_gicd(struct acpi_madt_gicd *gicd, uint gic_id,
> +                         ulong phys_base, uint gic_version)
> +{
> +       memset(gicd, '\0', sizeof(struct acpi_madt_gicd));
> +       gicd->type =3D ACPI_APIC_GICD;
> +       gicd->length =3D sizeof(struct acpi_madt_gicd);
> +       gicd->gic_id =3D gic_id;
> +       gicd->phys_base =3D phys_base;
> +       gicd->gic_version =3D gic_version;
> +}
> --
> 2.45.2
>

Cheers,
Moritz

