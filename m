Return-Path: <linux-kernel+bounces-245164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A3192AF25
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 06:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11E102824DE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 04:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A9012C80F;
	Tue,  9 Jul 2024 04:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="DyESMjq+"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDEC29CEA
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 04:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720500602; cv=none; b=McZFPFAJK2mCF62HbDuuGk74yHZ+7roEN2i2UE5IbDJUj0DEGeyBZeSXDF940VdtUVhpiUbTY/UzxyFr9iC8Ffz66ci+f+7AjrcCVzfQk4eWoX1aC2LN6sPLbmOng5iyVObawpRsLHJ1jE8Q7XxvvXe6KHvgXIVHirTjqPEzLlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720500602; c=relaxed/simple;
	bh=RKZ8riPKBOMmnRu0Y0V//mjlAySDsObIvoqoBrnxGdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIAKXRW7d8eeH3zU/gdO+H1WN0ZAegMI4UqJvpbjkhg/Wabi/QQuPciBebQclj4+JyZcQDIE06GN+1yPVQvYGphC2oOmgpOIseAbY7xeMH7HZtujNoFXxZXh0Tn3dWvE3fT2ApYdFlXqb56EOnx64SVstQ842Q4Mrv6viZmRrAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=DyESMjq+; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-70362cae7e1so1331962a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 21:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1720500600; x=1721105400; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ycv9RhTx/iOnhQoNsrsfVpohBzhfYYYI7kq2z4uFvQM=;
        b=DyESMjq+ca6rcIDY3obrSDqDCb/4Rm3KvqfVG/+gk9U9WvKqYYr+4WzJ7dy5oxg5Zv
         ZyqxNo0uVYFjvgZaczRc9gAVs4HG8WkCuDrQBKXJoPiAHbtSLxa8PQcVAcchbjZ6f++s
         xqcL8R+ydTtvw4YFeCzHuAHiJ5cmVUdZ424VYl8bf/TWIgffiGo8H1+qdKhiGpLRf2oc
         TuUKQrFi+3X9MI/us5eLXHF47wKhkGTaMxh1tSrWkV+qheS1SaaNK+x7u4Q7IvzY1DYF
         rVRW65RZGpfEURGoRplyi4CtIzAmqwcYjxcQ6q5Hz/dxR6n9OPPqTl6tUbsrzEujSB5v
         yC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720500600; x=1721105400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ycv9RhTx/iOnhQoNsrsfVpohBzhfYYYI7kq2z4uFvQM=;
        b=PHvN3I7Xyix6XDg+uyL1TjsXFyGW5cUQ9qFfSdfIrF7PhLBIrqkQOQ2AZ32l4NvBAz
         fp5wAzOOIWFy1XS4WMmlJ74/8zqkgFXe5P8ADqsE+R1eYwy80VkVLJySFfNbJ8gQX31p
         Dw82zBERmOGs5/xBoCLwA7eoKHgzXZd7Ad4tjN6E0ZQOyO7no4E68vmtKDXHwDcx98Y5
         XQVeduLsiF0/gYZWkdhzfIhWrnwrmgysf9+RCjSY7XMIQIdjxGUgE5DS9iC14F33Lg8r
         R+WF3zagnydgpNe+NelUPegT9cRbGYLvhNbwC+ofYR+0izCsD10Q9QeN3rsYO88DfBa2
         UXKA==
X-Gm-Message-State: AOJu0YykAQLue1kCh8I3U8nCkYcyr0LzFFh6yooIcSHCxJtZ880x4IwS
	bJDkiCGDQC0jKQyqe17jQ2C4cfuFao4EKggR9rhEdD4BQRu/hTa4sufeMLAwKEg=
X-Google-Smtp-Source: AGHT+IEUrIMXwNj2TxtgtdUBPo5hBWRpqg2MgnyY1yttQtF1VzkezDbpHzFV8pIGCqU1nGPoUfx/1w==
X-Received: by 2002:a05:6830:22fb:b0:703:6dce:3ad5 with SMTP id 46e09a7af769-70375a17ad6mr1607568a34.22.1720500599721;
        Mon, 08 Jul 2024 21:49:59 -0700 (PDT)
Received: from sunil-laptop ([106.51.187.237])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70374f6b5easm302098a34.14.2024.07.08.21.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 21:49:59 -0700 (PDT)
Date: Tue, 9 Jul 2024 10:19:50 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	rafael.j.wysocki@intel.com, ajones@ventanamicro.com,
	conor.dooley@microchip.com, aou@eecs.berkeley.edu,
	palmer@dabbelt.com, paul.walmsley@sifive.com
Subject: Re: [PATCH v2 1/1] RISC-V: ACPI: Enable SPCR table for console
 output on RISC-V
Message-ID: <ZozBbibw+CyYsqeR@sunil-laptop>
References: <20240502073751.102093-1-jeeheng.sia@starfivetech.com>
 <20240502073751.102093-2-jeeheng.sia@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502073751.102093-2-jeeheng.sia@starfivetech.com>

On Thu, May 02, 2024 at 12:37:51AM -0700, Sia Jee Heng wrote:
> The ACPI SPCR code has been used to enable console output for ARM64 and
> X86. The same code can be reused for RISC-V. Furthermore, SPCR table is
> mandated for headless system as outlined in the RISC-V BRS
> Specification, chapter 6.
> 
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> ---
>  arch/riscv/Kconfig       |  1 +
>  arch/riscv/kernel/acpi.c | 12 +++++++++++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index be09c8836d56..ff2e270bbe01 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -14,6 +14,7 @@ config RISCV
>  	def_bool y
>  	select ACPI_GENERIC_GSI if ACPI
>  	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
> +	select ACPI_SPCR_TABLE if ACPI
>  	select ARCH_DMA_DEFAULT_COHERENT
>  	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
>  	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
> diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
> index e619edc8b0cc..43a12c00ae8b 100644
> --- a/arch/riscv/kernel/acpi.c
> +++ b/arch/riscv/kernel/acpi.c
> @@ -17,7 +17,9 @@
>  #include <linux/efi.h>
>  #include <linux/io.h>
>  #include <linux/memblock.h>
> +#include <linux/of_fdt.h>
>  #include <linux/pci.h>
> +#include <linux/serial_core.h>
>  
>  int acpi_noirq = 1;		/* skip ACPI IRQ initialization */
>  int acpi_disabled = 1;
> @@ -131,7 +133,7 @@ void __init acpi_boot_table_init(void)
>  	if (param_acpi_off ||
>  	    (!param_acpi_on && !param_acpi_force &&
>  	     efi.acpi20 == EFI_INVALID_TABLE_ADDR))
> -		return;
> +		goto done;
>  
>  	/*
>  	 * ACPI is disabled at this point. Enable it in order to parse
> @@ -151,6 +153,14 @@ void __init acpi_boot_table_init(void)
>  		if (!param_acpi_force)
>  			disable_acpi();
>  	}
> +
> +done:
> +	if (acpi_disabled) {
> +		if (earlycon_acpi_spcr_enable)
> +			early_init_dt_scan_chosen_stdout();
> +	} else {
> +		acpi_parse_spcr(earlycon_acpi_spcr_enable, true);
> +	}
LGTM.

Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>

Thanks,
Sunil
>  }
>  
>  static int acpi_parse_madt_rintc(union acpi_subtable_headers *header, const unsigned long end)
> -- 
> 2.34.1
> 

