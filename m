Return-Path: <linux-kernel+bounces-525245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1642A3ECE9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 07:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD0AA7A9F87
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 06:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BE21FF7D6;
	Fri, 21 Feb 2025 06:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLS6oXkp"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C83A1FF5F9;
	Fri, 21 Feb 2025 06:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740119748; cv=none; b=SujHuDLwLqXNfHQoGoChfm/93D/oLUy2oGOEAC0Qkpbpyobp2KJuPKq8vGuleUE+3Yvks6zkALs+HL8fE9+ylezW1qY2MkoTWLgVDh6x7zEXbk+q3vwR0JZhqK/0QdvH/d+3NbiwenG37ysaJaqWGDGPMkL/rTMmNsuskZJh9MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740119748; c=relaxed/simple;
	bh=qJP/wLgDkL5/8/+5R7KkPI4oLbJYh/52RE5xAmoCr24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZxxQ8CTjZkS4FiLwlC28KRscpXAt5VLjL0m1aOBBLxGByQDOk4F61stlt83Uk09yakDTbbYIS60KbzJ4SYU59N09JoRGZrj1QrMRG6rzijFI+Clw+I/xRa2LSfIZd4GgymV4OTQg9nR24W+pgdyplOcradwv408MCPKbvGuDLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLS6oXkp; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6dd1962a75bso13277486d6.3;
        Thu, 20 Feb 2025 22:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740119745; x=1740724545; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GgF+MkPyNemGN6pZlGJKeAwLqALz+oWn8P6tqHlUU2E=;
        b=cLS6oXkp8zgMDt2uJCczYr03ZgGsx9rLMf8Rjwkb4WCDFPVlwTAFwrb2BuGVTPCYBU
         t+Gx04098cZJkOQs14T4QKiqT0PHVY0tZFiIDBt8WUOH5bu6mNmkCAFBAXPYAX+DaBVA
         IM9mFDJr1jo0oelHSLq4awBFysQ1gOtcxouKSv33dZnyR0tG+i4zPzue4NzcF4fao5Fa
         00QtRvIJYSFF2HwvO4xKwknIxRt0hxXO6nbkTP3D5Yl4u8IeRX0mTBclPtr3yVqi2PW8
         1bBUD3RCnvL9DTV0ItuPNU2QMvsMG38aY4XBVKpzIIeLtmR6a/SxmhHRxbJIK5894xyR
         EnFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740119745; x=1740724545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgF+MkPyNemGN6pZlGJKeAwLqALz+oWn8P6tqHlUU2E=;
        b=oEpMoseDeZ2SwiuyNrGGGZM7YPUG6iHAmz83IZgt/z2YtAfmT8uCsmfQEujvHBQS6R
         eN90c56sWM01XAJjGEjfC8UxLYcOdNyQoT6+5izQbqqnOITyDOjgdiHchFkJsYDJdfz2
         /OMqTYSSB2AYKI1/47NjuuChtUS01wuc90P24iJqabh5yL5Z5SOHVd7oBewWuGQgmwuG
         XoSM7b8YnrVDlXzfzAUhvD3o0BeQmlf+5RG0gGHDnijH0UcknCRlHlipy+G/oejqNtap
         g+UTEgRWaqT/N08zxK9zY6uifvinlpCYXAcj3TfpWq5hJxjQBC389FjtTiM55o9PMirI
         R4bw==
X-Forwarded-Encrypted: i=1; AJvYcCUU0x0qPzjXJVtItobgdjD3Fz7LQcNS15sxunfA0eGMpS88fOaPE1jRtYVUGIvMTP+SojiMPXjvZgNeXURp@vger.kernel.org, AJvYcCXo7QP5X5d2Q7aJOKZSzv2u6EDSV+AzTdV/LyeYBY/ZmpAwEdLOZ0b3YafxMitaLVuaOsScUVENF83d@vger.kernel.org
X-Gm-Message-State: AOJu0YzusSpNppXcUZFkmzqGt7wFlwg0H/Jl+R++Ht4Hzpu20G/UwZpc
	avedtjIwOURivjhxglWN+AVQw+y2J1xwVBhusmUywqbe906X5da8
X-Gm-Gg: ASbGncssnOpzB3IDGeU5tfXICnrILXvSGI8j+VlKxDHYl5N4xOs7YyWDgxHNx1wVdiz
	D3aG9dlBWoeKlGB1UbduzEv95a6+5P7GLY1MSIH3Vfp/uDnzIhJiFqOtptbwAZoqAOKHmXZRiYj
	C4M2zdqlM0ITcG2jTXvROjhjQ8nliclbYOpnh10/bVflCVfYMLNlmR+0ztDvEtxUkqY7DbAE1Om
	o01MMR+f9l8nCLmqWCOlmznxoJt1xEet/ystx0/BMKNTATfThJGY0LQrrqnLrrT4T0oMng9AT/h
	WA==
X-Google-Smtp-Source: AGHT+IHPzc9DLKjCuZh/6Ap8Kbdi/V/+WJ+ejMMs7iMspJsfIlQ8pbtavtfDzNcgx7Aon2zxus+6Dg==
X-Received: by 2002:a05:6214:130d:b0:6e6:5f0b:94bc with SMTP id 6a1803df08f44-6e6b008636bmr20413876d6.11.1740119745126;
        Thu, 20 Feb 2025 22:35:45 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e65d785c1fsm94051126d6.35.2025.02.20.22.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 22:35:44 -0800 (PST)
Date: Fri, 21 Feb 2025 14:35:26 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicornxw@gmail.com>, u.kleine-koenig@baylibre.com, 
	aou@eecs.berkeley.edu, arnd@arndb.de, unicorn_wang@outlook.com, conor+dt@kernel.org, 
	guoren@kernel.org, inochiama@outlook.com, krzk+dt@kernel.org, palmer@dabbelt.com, 
	paul.walmsley@sifive.com, robh@kernel.org, tglx@linutronix.de, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, chao.wei@sophgo.com, 
	xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com
Cc: Inochi Amaoto <inochiama@gmail.com>
Subject: Re: [PATCH v4 2/3] irqchip: Add the Sophgo SG2042 MSI interrupt
 controller
Message-ID: <nmr5qzvxxw7psymykjsaivmamt3icj6jqx6qmneofsnp33faf5@p7z6kqumfljn>
References: <cover.1740116190.git.unicorn_wang@outlook.com>
 <f438742bdf7bf3ef8a65e1d88ad57fd1ac66273f.1740116190.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f438742bdf7bf3ef8a65e1d88ad57fd1ac66273f.1740116190.git.unicorn_wang@outlook.com>

On Fri, Feb 21, 2025 at 01:50:19PM +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Add driver for Sophgo SG2042 MSI interrupt controller.
> 
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  drivers/irqchip/Kconfig          |  12 ++
>  drivers/irqchip/Makefile         |   1 +
>  drivers/irqchip/irq-sg2042-msi.c | 264 +++++++++++++++++++++++++++++++
>  3 files changed, 277 insertions(+)
>  create mode 100644 drivers/irqchip/irq-sg2042-msi.c
> 
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index be063bfb50c4..cdb0accd826a 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -751,6 +751,18 @@ config MCHP_EIC
>  	help
>  	  Support for Microchip External Interrupt Controller.
>  
> +config SOPHGO_SG2042_MSI
> +	bool "Sophgo SG2042 MSI Controller"
> +	depends on ARCH_SOPHGO || COMPILE_TEST
> +	depends on PCI
> +	select IRQ_DOMAIN_HIERARCHY
> +	select IRQ_MSI_LIB
> +	select PCI_MSI
> +	help
> +	  Support for the Sophgo SG2042 MSI Controller.
> +	  This on-chip interrupt controller enables MSI sources to be
> +	  routed to the primary PLIC controller on SoC.
> +
>  config SUNPLUS_SP7021_INTC
>  	bool "Sunplus SP7021 interrupt controller" if COMPILE_TEST
>  	default SOC_SP7021
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index 25e9ad29b8c4..dd60e597491d 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -128,4 +128,5 @@ obj-$(CONFIG_WPCM450_AIC)		+= irq-wpcm450-aic.o
>  obj-$(CONFIG_IRQ_IDT3243X)		+= irq-idt3243x.o
>  obj-$(CONFIG_APPLE_AIC)			+= irq-apple-aic.o
>  obj-$(CONFIG_MCHP_EIC)			+= irq-mchp-eic.o
> +obj-$(CONFIG_SOPHGO_SG2042_MSI)		+= irq-sg2042-msi.o
>  obj-$(CONFIG_SUNPLUS_SP7021_INTC)	+= irq-sp7021-intc.o
> diff --git a/drivers/irqchip/irq-sg2042-msi.c b/drivers/irqchip/irq-sg2042-msi.c
> new file mode 100644
> index 000000000000..b7950872ed2e
> --- /dev/null
> +++ b/drivers/irqchip/irq-sg2042-msi.c
> @@ -0,0 +1,264 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * SG2042 MSI Controller
> + *
> + * Copyright (C) 2024 Sophgo Technology Inc.
> + * Copyright (C) 2024 Chen Wang <unicorn_wang@outlook.com>
> + */
> +
> +#include <linux/cleanup.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/msi.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/slab.h>
> +
> +#include "irq-msi-lib.h"
> +
> +#define SG2042_MAX_MSI_VECTOR	32
> +
> +struct sg2042_msi_chipdata {
> +	void __iomem	*reg_clr;	// clear reg, see TRM, 10.1.33, GP_INTR0_CLR
> +
> +	phys_addr_t	doorbell_addr;	// see TRM, 10.1.32, GP_INTR0_SET
> +
> +	u32		irq_first;	// The vector number that MSIs starts
> +	u32		num_irqs;	// The number of vectors for MSIs
> +
> +	DECLARE_BITMAP(msi_map, SG2042_MAX_MSI_VECTOR);
> +	struct mutex	msi_map_lock;	// lock for msi_map
> +};
> +
> +static int sg2042_msi_allocate_hwirq(struct sg2042_msi_chipdata *data, int num_req)
> +{
> +	int first;
> +
> +	guard(mutex)(&data->msi_map_lock);
> +	first = bitmap_find_free_region(data->msi_map, data->num_irqs,
> +					get_count_order(num_req));
> +	return first >= 0 ? first : -ENOSPC;
> +}
> +
> +static void sg2042_msi_free_hwirq(struct sg2042_msi_chipdata *data,
> +				  int hwirq, int num_req)
> +{
> +	guard(mutex)(&data->msi_map_lock);
> +	bitmap_release_region(data->msi_map, hwirq, get_count_order(num_req));
> +}
> +
> +static void sg2042_msi_irq_ack(struct irq_data *d)
> +{
> +	struct sg2042_msi_chipdata *data  = irq_data_get_irq_chip_data(d);
> +	int bit_off = d->hwirq;
> +
> +	writel(1 << bit_off, data->reg_clr);
> +
> +	irq_chip_ack_parent(d);
> +}
> +
> +static void sg2042_msi_irq_compose_msi_msg(struct irq_data *d,
> +					   struct msi_msg *msg)
> +{
> +	struct sg2042_msi_chipdata *data = irq_data_get_irq_chip_data(d);
> +
> +	msg->address_hi = upper_32_bits(data->doorbell_addr);
> +	msg->address_lo = lower_32_bits(data->doorbell_addr);
> +	msg->data = 1 << d->hwirq;
> +}
> +
> +static const struct irq_chip sg2042_msi_middle_irq_chip = {
> +	.name			= "SG2042 MSI",
> +	.irq_ack		= sg2042_msi_irq_ack,
> +	.irq_mask		= irq_chip_mask_parent,
> +	.irq_unmask		= irq_chip_unmask_parent,
> +#ifdef CONFIG_SMP
> +	.irq_set_affinity	= irq_chip_set_affinity_parent,
> +#endif
> +	.irq_compose_msi_msg	= sg2042_msi_irq_compose_msi_msg,
> +};
> +
> +static int sg2042_msi_parent_domain_alloc(struct irq_domain *domain,
> +					  unsigned int virq, int hwirq)
> +{
> +	struct sg2042_msi_chipdata *data = domain->host_data;
> +	struct irq_fwspec fwspec;
> +	struct irq_data *d;
> +	int ret;
> +
> +	fwspec.fwnode = domain->parent->fwnode;
> +	fwspec.param_count = 2;
> +	fwspec.param[0] = data->irq_first + hwirq;
> +	fwspec.param[1] = IRQ_TYPE_EDGE_RISING;
> +
> +	ret = irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
> +	if (ret)
> +		return ret;
> +
> +	d = irq_domain_get_irq_data(domain->parent, virq);
> +	return d->chip->irq_set_type(d, IRQ_TYPE_EDGE_RISING);
> +}
> +
> +static int sg2042_msi_middle_domain_alloc(struct irq_domain *domain,
> +					  unsigned int virq,
> +					  unsigned int nr_irqs, void *args)
> +{
> +	struct sg2042_msi_chipdata *data = domain->host_data;
> +	int hwirq, err, i;
> +
> +	hwirq = sg2042_msi_allocate_hwirq(data, nr_irqs);
> +	if (hwirq < 0)
> +		return hwirq;
> +
> +	for (i = 0; i < nr_irqs; i++) {
> +		err = sg2042_msi_parent_domain_alloc(domain, virq + i, hwirq + i);
> +		if (err)
> +			goto err_hwirq;
> +
> +		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
> +					      &sg2042_msi_middle_irq_chip, data);
> +	}
> +
> +	return 0;
> +
> +err_hwirq:
> +	sg2042_msi_free_hwirq(data, hwirq, nr_irqs);
> +	irq_domain_free_irqs_parent(domain, virq, i);
> +
> +	return err;
> +}
> +
> +static void sg2042_msi_middle_domain_free(struct irq_domain *domain,
> +					  unsigned int virq,
> +					  unsigned int nr_irqs)
> +{
> +	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
> +	struct sg2042_msi_chipdata *data = irq_data_get_irq_chip_data(d);
> +
> +	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
> +	sg2042_msi_free_hwirq(data, d->hwirq, nr_irqs);
> +}
> +
> +static const struct irq_domain_ops sg2042_msi_middle_domain_ops = {
> +	.alloc	= sg2042_msi_middle_domain_alloc,
> +	.free	= sg2042_msi_middle_domain_free,
> +	.select	= msi_lib_irq_domain_select,
> +};
> +
> +#define SG2042_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS |	\
> +				   MSI_FLAG_USE_DEF_CHIP_OPS)
> +
> +#define SG2042_MSI_FLAGS_SUPPORTED MSI_GENERIC_FLAGS_MASK
> +
> +static const struct msi_parent_ops sg2042_msi_parent_ops = {
> +	.required_flags		= SG2042_MSI_FLAGS_REQUIRED,
> +	.supported_flags	= SG2042_MSI_FLAGS_SUPPORTED,
> +	.bus_select_mask	= MATCH_PCI_MSI,
> +	.bus_select_token	= DOMAIN_BUS_NEXUS,
> +	.prefix			= "SG2042-",
> +	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
> +};
> +
> +static int sg2042_msi_init_domains(struct sg2042_msi_chipdata *data,
> +				   struct device *dev)
> +{
> +	struct fwnode_handle *fwnode = dev_fwnode(dev);
> +	struct irq_domain *plic_domain, *middle_domain;
> +	struct fwnode_handle *plic_node;
> +

> +	plic_node = fwnode_find_reference(fwnode, "msi-ranges", 0);
> +	if (IS_ERR(plic_node)) {
> +		pr_err("Failed to find the PLIC node!\n");
> +		return PTR_ERR(plic_node);
> +	}

I think plic_node is just the args.fwnode in the sg2042_msi_probe.
Just reuse it. No need to parse this again.

Otherwise, It looks good to me. With this fix:

Reviewed-by: Inochi Amaoto <inochiama@gmail.com>

> +
> +	plic_domain = irq_find_matching_fwnode(plic_node, DOMAIN_BUS_ANY);
> +	fwnode_handle_put(plic_node);
> +	if (!plic_domain) {
> +		pr_err("Failed to find the PLIC domain\n");
> +		return -ENXIO;
> +	}
> +
> +	middle_domain = irq_domain_create_hierarchy(plic_domain, 0, data->num_irqs,
> +						    fwnode,
> +						    &sg2042_msi_middle_domain_ops,
> +						    data);
> +	if (!middle_domain) {
> +		pr_err("Failed to create the MSI middle domain\n");
> +		return -ENOMEM;
> +	}
> +
> +	irq_domain_update_bus_token(middle_domain, DOMAIN_BUS_NEXUS);
> +
> +	middle_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
> +	middle_domain->msi_parent_ops = &sg2042_msi_parent_ops;
> +
> +	return 0;
> +}
> +
> +static int sg2042_msi_probe(struct platform_device *pdev)
> +{
> +	struct fwnode_reference_args args = {};
> +	struct sg2042_msi_chipdata *data;
> +	struct device *dev = &pdev->dev;
> +	struct resource *res;
> +	int ret;
> +
> +	data = devm_kzalloc(dev, sizeof(struct sg2042_msi_chipdata), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->reg_clr = devm_platform_ioremap_resource_byname(pdev, "clr");
> +	if (IS_ERR(data->reg_clr)) {
> +		dev_err(dev, "Failed to map clear register\n");
> +		return PTR_ERR(data->reg_clr);
> +	}
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "doorbell");
> +	if (!res) {
> +		dev_err(dev, "Failed get resource from set\n");
> +		return -EINVAL;
> +	}
> +	data->doorbell_addr = res->start;
> +
> +	ret = fwnode_property_get_reference_args(dev_fwnode(dev), "msi-ranges",
> +						 "#interrupt-cells", 0, 0, &args);
> +	if (ret) {
> +		dev_err(dev, "Unable to parse MSI vec base\n");
> +		return ret;
> +	}
> +	fwnode_handle_put(args.fwnode);
> +
> +	ret = fwnode_property_get_reference_args(dev_fwnode(dev), "msi-ranges",
> +						 NULL, args.nargs + 1,
> +						 0, &args);
> +	if (ret) {
> +		dev_err(dev, "Unable to parse MSI vec number\n");
> +		return ret;
> +	}
> +	fwnode_handle_put(args.fwnode);
> +
> +	data->irq_first = (u32)args.args[0];
> +	data->num_irqs = (u32)args.args[args.nargs - 1];
> +
> +	mutex_init(&data->msi_map_lock);
> +
> +	return sg2042_msi_init_domains(data, dev);
> +}
> +
> +static const struct of_device_id sg2042_msi_of_match[] = {
> +	{ .compatible	= "sophgo,sg2042-msi" },
> +	{}
> +};
> +
> +static struct platform_driver sg2042_msi_driver = {
> +	.driver = {
> +		.name		= "sg2042-msi",
> +		.of_match_table	= sg2042_msi_of_match,
> +	},
> +	.probe = sg2042_msi_probe,
> +};
> +builtin_platform_driver(sg2042_msi_driver);
> -- 
> 2.34.1
> 

