Return-Path: <linux-kernel+bounces-373097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4719A5228
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 06:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF65E1F22632
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 04:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5CA523A;
	Sun, 20 Oct 2024 04:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKsMQxYc"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28F23FE4;
	Sun, 20 Oct 2024 04:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729396922; cv=none; b=RJprghqwNzLlIC9yXwuhHaUpbJI0vN4Oyodvr/GH7M8+TSKr2mxgy8M7+fIsMnlIOsc3mtq+6Ggnm+nU0t7rKlE2bNLrRHMl6GBy16z7bt/+nI8gW6I0S+f+hy4f/FTFxsFFDQ4dX33z7HCAcoZTwyfbfmaYoM5VvIoTpZ7yH0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729396922; c=relaxed/simple;
	bh=NoV4O8ZuP+aPYGx4FibMFNq2seb49Ic4L7UD6RDgZI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGAUgnZ2E6PrEOKo2p2VIJoqcgobvFlnV/Lvjm9T1kTEvxgOFZqZqzxg3SrNfXXhrs2tmjjzV/GFczm3+rf9w9KvpAjuLt/094HKxXXfwjQSR0cThCJZVwfcZfK+G16fM8MiH7SvF0lkRCSwnTRhBSuA8yhxaTkpfUdCXQuUJ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKsMQxYc; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e2b549799eso2514763a91.3;
        Sat, 19 Oct 2024 21:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729396920; x=1730001720; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MSzJap4VF2arKN21AI1bmmuABr739UlYYr388X/kIrU=;
        b=nKsMQxYc8LakZC+bu7a3Oie9mhDLFL/tEae0qs5hzfwcawxIRl1M0g4XK9aK+KkXfu
         10oTAilsfiTPEDkUoL54OgVWkTM0dAfv3b5xm7eyuuxdD4hyXPhOr6Uw57YU5TxSLnot
         bwSRCXvkgyHuKgu2sRvC8KuyoGXEJf5yq63RIHycZKA4OpYiSLq9HeG1uqiRmzgl8RUK
         wukF8XOaOLHbArDAcYehLR42lzubwpgG/dXMM5K/4iPtZ+Y4vbsbgz7vzklMQZT2NPp5
         PVsGuCE/kORdjb7qxBTH8Q1CRwys7gc6R3RHYGnSj5alezPoHt7ajjwwc3db7syV3vzZ
         1DBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729396920; x=1730001720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSzJap4VF2arKN21AI1bmmuABr739UlYYr388X/kIrU=;
        b=X6y2puV/dT+US3opSfqRid5ALx8UAAeA4uuKBbfoIvwOVRE0elMqBtWr3i6mZ1lI5m
         MulpXDIGFFdmzA2q2Mo+uXxgPgGwFH9QtOStjynGZ/6m9Bck/cJQP1Ct3KRUMS2h6zO7
         qv8YVVBJvPOnEiXmbg4iKKpffsgg/cY2ZMfrEqyueRNi5CYKtjUk8v7B+xQFCViWM6gE
         f1Uqj+Nw0Pmfti3Wmvf9gcRv4ab490cOkHreGhJ7s7YDHAfAhR3ZtxALy4jZv4MmRLZ+
         EBCSJrPdRwX63qEmN7t7k9w7w8uVeetsjFFejKssSaDB2VkC0hP3k1+zHcUHpsQimSEp
         Nz0A==
X-Forwarded-Encrypted: i=1; AJvYcCVMfo5KSFWOWucCjgnLqKvSEfpOhLE8ztOYF0zfMrR8VYNtH5L15PE7Xx2lsl7h5adntKmo81yAMsEW@vger.kernel.org, AJvYcCXxRYEiMUaWult2oIDxGbbYcU3Qm/BQnahnSqVLzOuyDmeIyr32jSGensVFNPbwWAWr1TJGZFRb+gUN27BM@vger.kernel.org
X-Gm-Message-State: AOJu0YyUHirBcOBzqBCUfoKQo8IhCqMEGjUHxqk5TBqJhRDEODU1Qmlj
	vIycj0/rOUKumnrhZZnMIXdUWkgP0dU6NMbLWApPvUPfZ0QhUzUI
X-Google-Smtp-Source: AGHT+IHa+/R1vOcy9hZbasSKlAuCSaJeX7+ZMoIp2v7OaYhwl8lZwwRMRQmeQuppLOJHDpVMbB4EOA==
X-Received: by 2002:a17:90b:4c0b:b0:2e2:a667:1a18 with SMTP id 98e67ed59e1d1-2e5616c4509mr9915506a91.5.1729396920043;
        Sat, 19 Oct 2024 21:02:00 -0700 (PDT)
Received: from localhost ([121.250.214.124])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5ad25caf5sm636425a91.8.2024.10.19.21.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 21:01:59 -0700 (PDT)
Date: Sun, 20 Oct 2024 12:01:43 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Samuel Holland <samuel.holland@sifive.com>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Yixun Lan <dlan@gentoo.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Peter Zijlstra <peterz@infradead.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
	Guo Ren <guoren@kernel.org>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Yangyu Chen <cyy@cyyself.name>, 
	Jinyu Tang <tangjinyu@tinylab.org>, Hal Feng <hal.feng@starfivetech.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v2 2/3] irqchip: add T-HEAD C900 ACLINT SSWI driver
Message-ID: <tgkep7hurskxfgsfe7qogmxmym3im5isfkwhv6qvpa35uzzvkg@7gkplu67ohwf>
References: <20241009224410.53188-1-inochiama@gmail.com>
 <20241009224410.53188-3-inochiama@gmail.com>
 <35d288d3-56dd-4018-8b98-78311c29a25d@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35d288d3-56dd-4018-8b98-78311c29a25d@sifive.com>

On Tue, Oct 15, 2024 at 05:43:16PM -0500, Samuel Holland wrote:
> Hi Inochi,
> 
> On 2024-10-09 5:44 PM, Inochi Amaoto wrote:
> > Add a driver for the T-HEAD C900 ACLINT SSWI device, which is an
> > enhanced implementation of the RISC-V ACLINT SSWI specification.
> > This device allows the system to send ipi via fast device interface.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> >  drivers/irqchip/Kconfig                      |  10 ++
> >  drivers/irqchip/Makefile                     |   1 +
> >  drivers/irqchip/irq-thead-c900-aclint-sswi.c | 166 +++++++++++++++++++
> >  include/linux/cpuhotplug.h                   |   1 +
> >  4 files changed, 178 insertions(+)
> >  create mode 100644 drivers/irqchip/irq-thead-c900-aclint-sswi.c
> > 
> > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> > index 341cd9ca5a05..32671385cbb7 100644
> > --- a/drivers/irqchip/Kconfig
> > +++ b/drivers/irqchip/Kconfig
> > @@ -611,6 +611,16 @@ config STARFIVE_JH8100_INTC
> >  
> >  	  If you don't know what to do here, say Y.
> >  
> > +config THEAD_C900_ACLINT_SSWI
> > +	bool "THEAD C9XX ACLINT S-mode IPI Interrupt Controller"
> > +	depends on RISCV
> > +	select IRQ_DOMAIN_HIERARCHY
> > +	help
> > +	  This enables support for T-HEAD specific ACLINT SSWI device
> > +	  support.
> > +
> > +	  If you don't know what to do here, say Y.
> > +
> >  config EXYNOS_IRQ_COMBINER
> >  	bool "Samsung Exynos IRQ combiner support" if COMPILE_TEST
> >  	depends on (ARCH_EXYNOS && ARM) || COMPILE_TEST
> > diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> > index e3679ec2b9f7..583418261253 100644
> > --- a/drivers/irqchip/Makefile
> > +++ b/drivers/irqchip/Makefile
> > @@ -101,6 +101,7 @@ obj-$(CONFIG_RISCV_APLIC_MSI)		+= irq-riscv-aplic-msi.o
> >  obj-$(CONFIG_RISCV_IMSIC)		+= irq-riscv-imsic-state.o irq-riscv-imsic-early.o irq-riscv-imsic-platform.o
> >  obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
> >  obj-$(CONFIG_STARFIVE_JH8100_INTC)	+= irq-starfive-jh8100-intc.o
> > +obj-$(CONFIG_THEAD_C900_ACLINT_SSWI)	+= irq-thead-c900-aclint-sswi.o
> >  obj-$(CONFIG_IMX_IRQSTEER)		+= irq-imx-irqsteer.o
> >  obj-$(CONFIG_IMX_INTMUX)		+= irq-imx-intmux.o
> >  obj-$(CONFIG_IMX_MU_MSI)		+= irq-imx-mu-msi.o
> > diff --git a/drivers/irqchip/irq-thead-c900-aclint-sswi.c b/drivers/irqchip/irq-thead-c900-aclint-sswi.c
> > new file mode 100644
> > index 000000000000..b96d3b81dc14
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-thead-c900-aclint-sswi.c
> > @@ -0,0 +1,166 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2024 Inochi Amaoto <inochiama@gmail.com>
> > + */
> > +
> > +#define pr_fmt(fmt) "thead-c900-aclint-sswi: " fmt
> > +#include <linux/cpu.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/irq.h>
> > +#include <linux/irqchip.h>
> > +#include <linux/irqchip/chained_irq.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/pci.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/smp.h>
> > +#include <linux/string_choices.h>
> > +
> > +#define ACLINT_xSWI_REGISTER_SIZE	4
> > +
> > +static int sswi_ipi_virq __ro_after_init;
> > +static DEFINE_PER_CPU(void __iomem *, sswi_cpu_regs);
> > +
> > +static void thead_aclint_sswi_ipi_send(unsigned int cpu)
> > +{
> > +	writel_relaxed(0x1, per_cpu(sswi_cpu_regs, cpu));
> > +}
> > +
> > +static void thead_aclint_sswi_ipi_clear(void)
> > +{
> > +	writel_relaxed(0x0, this_cpu_read(sswi_cpu_regs));
> 
> This isn't quite compliant with the ACLINT spec[1], which states: "Writing 0 to
> the least significant bit of a SETSSIP register has no effect". In a RISC-V
> ACLINT, only the CSR write is required to clear the interrupt.
> 
> This implementation does match the behavior of the T-HEAD CLINT extensions which
> are also present in C906/C910[2][3][4].
> 

Yes, this is T-HEAD specific one, it does not match the spec exactly. 
This is why I add "thead" prefix.

> This raises the question: in the older CPUs, using this functionality requires
> setting the mxstatus.CLINTEE bit from M-mode. Is this still the case for the
> C920 CPU in SG2044? If so, the driver should check sxstatus.CLINTEE when probing.
> 

It seems that I forgot this. The SG2044 also needs to check the CLINTEE bit when
probing, it just set this bit in its zsbl. I will fix this in the next version. 
Thanks for points it.

> It would also be ideal if we could support the other SoCs that use this same IP
> block, but with the other CLINT binding.
> 
> Regards,
> Samuel
> 
> [1]: https://github.com/riscv/riscv-aclint/blob/main/riscv-aclint.adoc
> [2]:
> https://occ-intl-prod.oss-ap-southeast-1.aliyuncs.com/resource/XuanTie-OpenC906-UserManual.pdf
> [3]:
> https://github.com/XUANTIE-RV/openc906/blob/main/C906_RTL_FACTORY/gen_rtl/clint/rtl/clint_func.v#L285
> [4]:
> https://github.com/XUANTIE-RV/openc906/blob/main/C906_RTL_FACTORY/gen_rtl/cp0/rtl/aq_cp0_trap_csr.v#L1240
> 
> > +}
> > +
> > +static void thead_aclint_sswi_ipi_handle(struct irq_desc *desc)
> > +{
> > +	struct irq_chip *chip = irq_desc_get_chip(desc);
> > +
> > +	chained_irq_enter(chip, desc);
> > +
> > +	csr_clear(CSR_IP, IE_SIE);
> > +	thead_aclint_sswi_ipi_clear();
> > +
> > +	ipi_mux_process();
> > +
> > +	chained_irq_exit(chip, desc);
> > +}
> > +
> > +static int thead_aclint_sswi_starting_cpu(unsigned int cpu)
> > +{
> > +	enable_percpu_irq(sswi_ipi_virq, irq_get_trigger_type(sswi_ipi_virq));
> > +
> > +	return 0;
> > +}
> > +
> > +static int thead_aclint_sswi_dying_cpu(unsigned int cpu)
> > +{
> > +	thead_aclint_sswi_ipi_clear();
> > +
> > +	disable_percpu_irq(sswi_ipi_virq);
> > +
> > +	return 0;
> > +}
> > +
> > +static int __init aclint_sswi_parse_irq(struct fwnode_handle *fwnode,
> > +					void __iomem *reg)
> > +{
> > +	struct of_phandle_args parent;
> > +	unsigned long hartid;
> > +	u32 contexts, i;
> > +	int rc, cpu;
> > +
> > +	contexts = of_irq_count(to_of_node(fwnode));
> > +	if (!(contexts)) {
> > +		pr_err("%pfwP: no ACLINT SSWI context available\n", fwnode);
> > +		return -EINVAL;
> > +	}
> > +
> > +	for (i = 0; i < contexts; i++) {
> > +		rc = of_irq_parse_one(to_of_node(fwnode), i, &parent);
> > +		if (rc)
> > +			return rc;
> > +
> > +		rc = riscv_of_parent_hartid(parent.np, &hartid);
> > +		if (rc)
> > +			return rc;
> > +
> > +		if (parent.args[0] != RV_IRQ_SOFT)
> > +			return -ENOTSUPP;
> > +
> > +		cpu = riscv_hartid_to_cpuid(hartid);
> > +
> > +		per_cpu(sswi_cpu_regs, cpu) = reg + i * ACLINT_xSWI_REGISTER_SIZE;
> > +	}
> > +
> > +	pr_info("%pfwP: register %u CPU%s\n", fwnode, contexts, str_plural(contexts));
> > +
> > +	return 0;
> > +}
> > +
> > +static int __init aclint_sswi_probe(struct fwnode_handle *fwnode)
> > +{
> > +	struct irq_domain *domain;
> > +	void __iomem *reg;
> > +	int virq, rc;
> > +
> > +	if (!is_of_node(fwnode))
> > +		return -EINVAL;
> > +
> > +	reg = of_iomap(to_of_node(fwnode), 0);
> > +	if (!reg)
> > +		return -ENOMEM;
> > +
> > +	/* Parse SSWI setting */
> > +	rc = aclint_sswi_parse_irq(fwnode, reg);
> > +	if (rc < 0)
> > +		return rc;
> > +
> > +	/* If mulitple SSWI devices are present, do not register irq again */
> > +	if (sswi_ipi_virq)
> > +		return 0;
> > +
> > +	/* Find riscv intc domain and create IPI irq mapping */
> > +	domain = irq_find_matching_fwnode(riscv_get_intc_hwnode(), DOMAIN_BUS_ANY);
> > +	if (!domain) {
> > +		pr_err("%pfwP: Failed to find INTC domain\n", fwnode);
> > +		return -ENOENT;
> > +	}
> > +
> > +	sswi_ipi_virq = irq_create_mapping(domain, RV_IRQ_SOFT);
> > +	if (!sswi_ipi_virq) {
> > +		pr_err("unable to create ACLINT SSWI IRQ mapping\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	/* Register SSWI irq and handler */
> > +	virq = ipi_mux_create(BITS_PER_BYTE, thead_aclint_sswi_ipi_send);
> > +	if (virq <= 0) {
> > +		pr_err("unable to create muxed IPIs\n");
> > +		irq_dispose_mapping(sswi_ipi_virq);
> > +		return virq < 0 ? virq : -ENOMEM;
> > +	}
> > +
> > +	irq_set_chained_handler(sswi_ipi_virq, thead_aclint_sswi_ipi_handle);
> > +
> > +	cpuhp_setup_state(CPUHP_AP_IRQ_THEAD_ACLINT_SSWI_STARTING,
> > +			  "irqchip/thead-aclint-sswi:starting",
> > +			  thead_aclint_sswi_starting_cpu,
> > +			  thead_aclint_sswi_dying_cpu);
> > +
> > +	riscv_ipi_set_virq_range(virq, BITS_PER_BYTE);
> > +
> > +	/* Announce that SSWI is providing IPIs */
> > +	pr_info("providing IPIs using THEAD ACLINT SSWI\n");
> > +
> > +	return 0;
> > +}
> > +
> > +static int __init aclint_sswi_early_probe(struct device_node *node,
> > +					  struct device_node *parent)
> > +{
> > +	return aclint_sswi_probe(&node->fwnode);
> > +}
> > +IRQCHIP_DECLARE(thead_aclint_sswi, "thead,c900-aclint-sswi", aclint_sswi_early_probe);
> > diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> > index 2361ed4d2b15..799052249c7b 100644
> > --- a/include/linux/cpuhotplug.h
> > +++ b/include/linux/cpuhotplug.h
> > @@ -147,6 +147,7 @@ enum cpuhp_state {
> >  	CPUHP_AP_IRQ_EIOINTC_STARTING,
> >  	CPUHP_AP_IRQ_AVECINTC_STARTING,
> >  	CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
> > +	CPUHP_AP_IRQ_THEAD_ACLINT_SSWI_STARTING,
> >  	CPUHP_AP_IRQ_RISCV_IMSIC_STARTING,
> >  	CPUHP_AP_IRQ_RISCV_SBI_IPI_STARTING,
> >  	CPUHP_AP_ARM_MVEBU_COHERENCY,
> 

