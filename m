Return-Path: <linux-kernel+bounces-366871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E73199FB9C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 00:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B163B23495
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806721D63C3;
	Tue, 15 Oct 2024 22:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="MjE/JOjO"
Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C948A1B0F0E
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 22:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729032202; cv=none; b=IJUWQaMk9LNjTHT0zmc4pzajFQaPeEPiClK4h85qkaxtzknDAMNPOfG/dEHx68bNF2dLbGPfKZFCXaF/W9/aS2k4SJseypLzMMrTsA9UzS1/LHmvcq0MtjDi/lmPrz1hns+vMLzgehidrtmUCCh2WAXpsdb8QEO6dILKRj2A6iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729032202; c=relaxed/simple;
	bh=Fnz6OZwOCAW6wHx45X+itsCtA2zXYSv34PXfhORB+dU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mrdguies5Bfxq+hPhn3SH7gbi15yzcuWgXoEmDgaSMttWKbDhQR1fotROadXNcHMbWD0ywkS7vVoIcSBrjAj/Kqts4WzE8WSs3/QYmEALTpgRrtd6mezM41p17Vb2VLqSouPJ/bDQcgybZ4IiivOC1MAbhLMKWS2/3/2gRzaxN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=MjE/JOjO; arc=none smtp.client-ip=209.85.219.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-e297bd161e0so243563276.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 15:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1729032198; x=1729636998; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iLa3yK6bQQGOZkFDiv3mQXcVUn0bBI+yeZ+z+r3TlBQ=;
        b=MjE/JOjOckmNGpEyB8BHk/XN0VHmHoRnV5HXnS9QsvxB93mvtzYSExjwqsc0AVMFRL
         yeVo3Hrusft9Xl9Fl4XPbYEC86CzqYwYRH639ZpXWSATIPT+F+bi8QqYSm4RpYR49YsR
         V/71PuKbbuJe8ZrkGv94NpTkA/eik/qdJLh7G3qjK4VJx4CxvXIJY4U5kyMv0lKsUtuj
         tacrz5KWX6aHTAcsyAplJTwls3sjZ1R8PP0xwFHpkSJqqybOJp7nPyPIfmF39WxHGXlZ
         HWhN2oTILR8IJ4N5kvRDCtmCld5Zcjfdm0Ba/RnIDi2yS89BpYJOeJItBUWZe7kCxu2L
         KvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729032198; x=1729636998;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iLa3yK6bQQGOZkFDiv3mQXcVUn0bBI+yeZ+z+r3TlBQ=;
        b=YMIz25jOJNB1UVBs/iqJswm5Iiv0NePuD3kUFOlpRH9OdE8BPrOj2SCD1C820JRJ3n
         z1TQXzFIi43hIGt8Hw5j9DSR/MaayJU6SMqk4EJyjExJelYEsVtPEL1SF6drNzqWJfYK
         Dnfbn5kWQjys5XuAZ1pb5un/sWskFwcsIg4mkj+8duV9aTsv6BqB3kGtfZVwIn57ucV4
         Iq6Zp/bc19vM/OgS9pcMrMXexV7EfsnH9ritMnH0bju+/4T14TEjLYxFnX4FoWhEVNP0
         0QQrugZW2z3fXOBzwSeitLv5N14McZzWEKRzSUnj5fUWYMPQfWq2GijuSkAq8VfcXCOD
         Oy3w==
X-Forwarded-Encrypted: i=1; AJvYcCVoU/7XNu+7stVMmyoY8BBFzYw/0/Pd93QCm4D7LcA03yUVy7Ewd6/wYlG8yFb3rtzKjfwvAuoeYC0Eh9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRvoUHuPQzOiYLJREAisONFJ3Na+BqpC5p2MpUNYIKE5ZKVHCV
	IZOaENXukw7PBG+xGlDob9AegjPVhK+GotN/pGS6XX0AF6k00jRfC/JJ8flpx38=
X-Google-Smtp-Source: AGHT+IGUiF3SK+LvZfYqhzb2T0k6C8cDKYi6l1lavCj5lHAZLRuEB5sHRrKdnbOYjSLrvhVonK2yzw==
X-Received: by 2002:a05:6902:250c:b0:e28:6b10:51b5 with SMTP id 3f1490d57ef6-e2931b62769mr9926138276.32.1729032198487;
        Tue, 15 Oct 2024 15:43:18 -0700 (PDT)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e296cbfaf03sm390123276.7.2024.10.15.15.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 15:43:17 -0700 (PDT)
Message-ID: <35d288d3-56dd-4018-8b98-78311c29a25d@sifive.com>
Date: Tue, 15 Oct 2024 17:43:16 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] irqchip: add T-HEAD C900 ACLINT SSWI driver
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Yixun Lan <dlan@gentoo.org>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Peter Zijlstra <peterz@infradead.org>, Chen Wang <unicorn_wang@outlook.com>,
 Inochi Amaoto <inochiama@outlook.com>, Guo Ren <guoren@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Yangyu Chen <cyy@cyyself.name>, Jinyu Tang <tangjinyu@tinylab.org>,
 Hal Feng <hal.feng@starfivetech.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>
References: <20241009224410.53188-1-inochiama@gmail.com>
 <20241009224410.53188-3-inochiama@gmail.com>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20241009224410.53188-3-inochiama@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Inochi,

On 2024-10-09 5:44 PM, Inochi Amaoto wrote:
> Add a driver for the T-HEAD C900 ACLINT SSWI device, which is an
> enhanced implementation of the RISC-V ACLINT SSWI specification.
> This device allows the system to send ipi via fast device interface.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  drivers/irqchip/Kconfig                      |  10 ++
>  drivers/irqchip/Makefile                     |   1 +
>  drivers/irqchip/irq-thead-c900-aclint-sswi.c | 166 +++++++++++++++++++
>  include/linux/cpuhotplug.h                   |   1 +
>  4 files changed, 178 insertions(+)
>  create mode 100644 drivers/irqchip/irq-thead-c900-aclint-sswi.c
> 
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 341cd9ca5a05..32671385cbb7 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -611,6 +611,16 @@ config STARFIVE_JH8100_INTC
>  
>  	  If you don't know what to do here, say Y.
>  
> +config THEAD_C900_ACLINT_SSWI
> +	bool "THEAD C9XX ACLINT S-mode IPI Interrupt Controller"
> +	depends on RISCV
> +	select IRQ_DOMAIN_HIERARCHY
> +	help
> +	  This enables support for T-HEAD specific ACLINT SSWI device
> +	  support.
> +
> +	  If you don't know what to do here, say Y.
> +
>  config EXYNOS_IRQ_COMBINER
>  	bool "Samsung Exynos IRQ combiner support" if COMPILE_TEST
>  	depends on (ARCH_EXYNOS && ARM) || COMPILE_TEST
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index e3679ec2b9f7..583418261253 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -101,6 +101,7 @@ obj-$(CONFIG_RISCV_APLIC_MSI)		+= irq-riscv-aplic-msi.o
>  obj-$(CONFIG_RISCV_IMSIC)		+= irq-riscv-imsic-state.o irq-riscv-imsic-early.o irq-riscv-imsic-platform.o
>  obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
>  obj-$(CONFIG_STARFIVE_JH8100_INTC)	+= irq-starfive-jh8100-intc.o
> +obj-$(CONFIG_THEAD_C900_ACLINT_SSWI)	+= irq-thead-c900-aclint-sswi.o
>  obj-$(CONFIG_IMX_IRQSTEER)		+= irq-imx-irqsteer.o
>  obj-$(CONFIG_IMX_INTMUX)		+= irq-imx-intmux.o
>  obj-$(CONFIG_IMX_MU_MSI)		+= irq-imx-mu-msi.o
> diff --git a/drivers/irqchip/irq-thead-c900-aclint-sswi.c b/drivers/irqchip/irq-thead-c900-aclint-sswi.c
> new file mode 100644
> index 000000000000..b96d3b81dc14
> --- /dev/null
> +++ b/drivers/irqchip/irq-thead-c900-aclint-sswi.c
> @@ -0,0 +1,166 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 Inochi Amaoto <inochiama@gmail.com>
> + */
> +
> +#define pr_fmt(fmt) "thead-c900-aclint-sswi: " fmt
> +#include <linux/cpu.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/pci.h>
> +#include <linux/spinlock.h>
> +#include <linux/smp.h>
> +#include <linux/string_choices.h>
> +
> +#define ACLINT_xSWI_REGISTER_SIZE	4
> +
> +static int sswi_ipi_virq __ro_after_init;
> +static DEFINE_PER_CPU(void __iomem *, sswi_cpu_regs);
> +
> +static void thead_aclint_sswi_ipi_send(unsigned int cpu)
> +{
> +	writel_relaxed(0x1, per_cpu(sswi_cpu_regs, cpu));
> +}
> +
> +static void thead_aclint_sswi_ipi_clear(void)
> +{
> +	writel_relaxed(0x0, this_cpu_read(sswi_cpu_regs));

This isn't quite compliant with the ACLINT spec[1], which states: "Writing 0 to
the least significant bit of a SETSSIP register has no effect". In a RISC-V
ACLINT, only the CSR write is required to clear the interrupt.

This implementation does match the behavior of the T-HEAD CLINT extensions which
are also present in C906/C910[2][3][4].

This raises the question: in the older CPUs, using this functionality requires
setting the mxstatus.CLINTEE bit from M-mode. Is this still the case for the
C920 CPU in SG2044? If so, the driver should check sxstatus.CLINTEE when probing.

It would also be ideal if we could support the other SoCs that use this same IP
block, but with the other CLINT binding.

Regards,
Samuel

[1]: https://github.com/riscv/riscv-aclint/blob/main/riscv-aclint.adoc
[2]:
https://occ-intl-prod.oss-ap-southeast-1.aliyuncs.com/resource/XuanTie-OpenC906-UserManual.pdf
[3]:
https://github.com/XUANTIE-RV/openc906/blob/main/C906_RTL_FACTORY/gen_rtl/clint/rtl/clint_func.v#L285
[4]:
https://github.com/XUANTIE-RV/openc906/blob/main/C906_RTL_FACTORY/gen_rtl/cp0/rtl/aq_cp0_trap_csr.v#L1240

> +}
> +
> +static void thead_aclint_sswi_ipi_handle(struct irq_desc *desc)
> +{
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +
> +	chained_irq_enter(chip, desc);
> +
> +	csr_clear(CSR_IP, IE_SIE);
> +	thead_aclint_sswi_ipi_clear();
> +
> +	ipi_mux_process();
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
> +static int thead_aclint_sswi_starting_cpu(unsigned int cpu)
> +{
> +	enable_percpu_irq(sswi_ipi_virq, irq_get_trigger_type(sswi_ipi_virq));
> +
> +	return 0;
> +}
> +
> +static int thead_aclint_sswi_dying_cpu(unsigned int cpu)
> +{
> +	thead_aclint_sswi_ipi_clear();
> +
> +	disable_percpu_irq(sswi_ipi_virq);
> +
> +	return 0;
> +}
> +
> +static int __init aclint_sswi_parse_irq(struct fwnode_handle *fwnode,
> +					void __iomem *reg)
> +{
> +	struct of_phandle_args parent;
> +	unsigned long hartid;
> +	u32 contexts, i;
> +	int rc, cpu;
> +
> +	contexts = of_irq_count(to_of_node(fwnode));
> +	if (!(contexts)) {
> +		pr_err("%pfwP: no ACLINT SSWI context available\n", fwnode);
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < contexts; i++) {
> +		rc = of_irq_parse_one(to_of_node(fwnode), i, &parent);
> +		if (rc)
> +			return rc;
> +
> +		rc = riscv_of_parent_hartid(parent.np, &hartid);
> +		if (rc)
> +			return rc;
> +
> +		if (parent.args[0] != RV_IRQ_SOFT)
> +			return -ENOTSUPP;
> +
> +		cpu = riscv_hartid_to_cpuid(hartid);
> +
> +		per_cpu(sswi_cpu_regs, cpu) = reg + i * ACLINT_xSWI_REGISTER_SIZE;
> +	}
> +
> +	pr_info("%pfwP: register %u CPU%s\n", fwnode, contexts, str_plural(contexts));
> +
> +	return 0;
> +}
> +
> +static int __init aclint_sswi_probe(struct fwnode_handle *fwnode)
> +{
> +	struct irq_domain *domain;
> +	void __iomem *reg;
> +	int virq, rc;
> +
> +	if (!is_of_node(fwnode))
> +		return -EINVAL;
> +
> +	reg = of_iomap(to_of_node(fwnode), 0);
> +	if (!reg)
> +		return -ENOMEM;
> +
> +	/* Parse SSWI setting */
> +	rc = aclint_sswi_parse_irq(fwnode, reg);
> +	if (rc < 0)
> +		return rc;
> +
> +	/* If mulitple SSWI devices are present, do not register irq again */
> +	if (sswi_ipi_virq)
> +		return 0;
> +
> +	/* Find riscv intc domain and create IPI irq mapping */
> +	domain = irq_find_matching_fwnode(riscv_get_intc_hwnode(), DOMAIN_BUS_ANY);
> +	if (!domain) {
> +		pr_err("%pfwP: Failed to find INTC domain\n", fwnode);
> +		return -ENOENT;
> +	}
> +
> +	sswi_ipi_virq = irq_create_mapping(domain, RV_IRQ_SOFT);
> +	if (!sswi_ipi_virq) {
> +		pr_err("unable to create ACLINT SSWI IRQ mapping\n");
> +		return -ENOMEM;
> +	}
> +
> +	/* Register SSWI irq and handler */
> +	virq = ipi_mux_create(BITS_PER_BYTE, thead_aclint_sswi_ipi_send);
> +	if (virq <= 0) {
> +		pr_err("unable to create muxed IPIs\n");
> +		irq_dispose_mapping(sswi_ipi_virq);
> +		return virq < 0 ? virq : -ENOMEM;
> +	}
> +
> +	irq_set_chained_handler(sswi_ipi_virq, thead_aclint_sswi_ipi_handle);
> +
> +	cpuhp_setup_state(CPUHP_AP_IRQ_THEAD_ACLINT_SSWI_STARTING,
> +			  "irqchip/thead-aclint-sswi:starting",
> +			  thead_aclint_sswi_starting_cpu,
> +			  thead_aclint_sswi_dying_cpu);
> +
> +	riscv_ipi_set_virq_range(virq, BITS_PER_BYTE);
> +
> +	/* Announce that SSWI is providing IPIs */
> +	pr_info("providing IPIs using THEAD ACLINT SSWI\n");
> +
> +	return 0;
> +}
> +
> +static int __init aclint_sswi_early_probe(struct device_node *node,
> +					  struct device_node *parent)
> +{
> +	return aclint_sswi_probe(&node->fwnode);
> +}
> +IRQCHIP_DECLARE(thead_aclint_sswi, "thead,c900-aclint-sswi", aclint_sswi_early_probe);
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 2361ed4d2b15..799052249c7b 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -147,6 +147,7 @@ enum cpuhp_state {
>  	CPUHP_AP_IRQ_EIOINTC_STARTING,
>  	CPUHP_AP_IRQ_AVECINTC_STARTING,
>  	CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
> +	CPUHP_AP_IRQ_THEAD_ACLINT_SSWI_STARTING,
>  	CPUHP_AP_IRQ_RISCV_IMSIC_STARTING,
>  	CPUHP_AP_IRQ_RISCV_SBI_IPI_STARTING,
>  	CPUHP_AP_ARM_MVEBU_COHERENCY,


