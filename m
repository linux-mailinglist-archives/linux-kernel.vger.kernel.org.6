Return-Path: <linux-kernel+bounces-291559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA00956411
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 09:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D110DB20FCD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 07:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3ED156677;
	Mon, 19 Aug 2024 07:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="u5z02DLQ"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB721B960
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 07:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724051117; cv=none; b=nWwFy13dBVrXT6w9gO5nk2ffo8BM+JcB81VnIpffbgTnsskvt7Ydm/2W+e1+tfnIIca9igFMrh70GDnO9d7EqiLhvyUb4Unq+/M39bEhyD/WroCnubJM7XSfhqW/zTVnBnwwQv3CgETnNDxJV8qzc9Q4bbHg0+9PJEWNTMcGQR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724051117; c=relaxed/simple;
	bh=X/GxZDdUwPUySnXZRZNn2nVDKu56nGlu6pNfAu49glw=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=apIfDCBZsgutmjJfHBMoUC6sC75SVzJt8wqYMtORsuxVt+N0HTvojT6DYRoWdbXXMLbJGkaQ3AKLEjlkPL9PNNWjUN17+L3A3BsoVsnu5TDgnNmRw8SRscaSE1VimnLpF8tV3qVOGwDfKcgGjb554wQhMdqqc3RMzzNEOzC2qjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=u5z02DLQ; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 775B83FD42
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 06:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1724050641;
	bh=w8L5CFHCyutNw4jBovw3yNQlJyyC7H3ApazpWmsE09Y=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=u5z02DLQXWf0Zit70yerupGaoikYE62HEGzV+h+3O8R/XeJrK9sPtcVOlg4Oua1Lf
	 uyrAUGvFErm+4QPANQGnLJU00bIVikbfTEo/qnCbwR54mkNsIEmzTC5rxveuYBlbch
	 yUL1PPpXU+i7J4wdum99bvq6elpGfpqy2L0E24zihdiR2+d0FYcd2q77uc6DiIg4W9
	 5Fio8HMtDv7ev8Fw9cB/Av0rgqTR2nIFHeeaeNhzW/ifif7okl5LNzYjYgCQpZUI33
	 qRhgbb860hiVV4aYnxGy0TL+/iphW3FIgIeMXYylR5yWsAHMAlw3vqDa7Ouk63YYuE
	 sAXD/5ACsB88Q==
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6bd94069ceeso89987776d6.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 23:57:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724050640; x=1724655440;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w8L5CFHCyutNw4jBovw3yNQlJyyC7H3ApazpWmsE09Y=;
        b=HtZGxBVA+Yrw4K0nNM/GA60ZvZRvQz1go342+UPFb0JKGpPbp5boj5SIBJnMK/ARgh
         jWFn44K3QIeBL11w0hPxEarLsmEFKIp2kmfMQ/SxnM4LgB5VMYiUXn66m5yOFxriu9n+
         mdXvfTViFNVjefurLAH+5r2pOcqVPcbuTo9inQoclQ1qlxszqtmHiU5yM9yfZXQdHUK1
         RZ4KtIQK/PLvwt51mGSUhzuZzVzOrpskU8hhIzqXsJWb50VDaqpbSpjKrmMmR1Xfq1JP
         ojtH39rRAdzLc8m7Fyc2HRgzKU8Ai5gxUYT91Aa1aglLgAXOJNP8Zlbm6vf8+nlvt8PC
         xrCA==
X-Forwarded-Encrypted: i=1; AJvYcCVuB/joFe2cSWo1/jfg4G1Cv/PUnML+rBQHG108Z9Z/dGfuN+kTlDWl+BwquDxFBDJn4aPjehQZNiPeYueu5y9LDmCPB+ESV3Qa5FkK
X-Gm-Message-State: AOJu0YyoPIYUO1mW3RGElM1x6qAN1VZBhMwShJRPI5eJ0Gsz3QFLsO5I
	tFZ8xm2JCuOXrpjf1qkE7snhaxhPSJLZMQt46McQ/sQyeNX8gRapH0B7le9c4+lN3yVTRmVWobk
	8Nfqg20RZ52yx/f9E5rqceE3gOhQi6mxvITcmgU0e9bf6LcUJMz8sCnE6/EU4Hl4UcnG0hVO9Bj
	scVnQVwMZG+/D0NK+R72eYsLK74APdEu9VzJ9mt7KKgZs0RAA7XjrT0habf+h+
X-Received: by 2002:ad4:596d:0:b0:6b7:9a53:70e9 with SMTP id 6a1803df08f44-6bf6de31f99mr160766736d6.17.1724050639698;
        Sun, 18 Aug 2024 23:57:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaF/xIrPgZ8pAIE3XH+9zs5sEhJ/82RgdDvwuO1jCjg0IkvwTPoMxKwAi1AFGhN9X6ZpuuEH+zJUUsk/I1LJI=
X-Received: by 2002:ad4:596d:0:b0:6b7:9a53:70e9 with SMTP id
 6a1803df08f44-6bf6de31f99mr160766536d6.17.1724050639169; Sun, 18 Aug 2024
 23:57:19 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Aug 2024 02:57:18 -0400
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20240817081218.2985171-1-apatel@ventanamicro.com>
References: <20240817081218.2985171-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Mon, 19 Aug 2024 02:57:18 -0400
Message-ID: <CAJM55Z9_7WsqXT5hNuwB9jt31Aayk3kqOV5FDZ9tdcLYhwHTFg@mail.gmail.com>
Subject: Re: [PATCH v2] irqchip/sifive-plic: Probe plic driver early for
 Allwinner D1 platform
To: Anup Patel <apatel@ventanamicro.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Anup Patel <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	linux-kernel@vger.kernel.org, Samuel Holland <samuel.holland@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Atish Patra <atishp@atishpatra.org>, 
	linux-riscv@lists.infradead.org, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"

Anup Patel wrote:
> The latest Linux RISC-V no longer boots on the Allwinner D1 platform
> because the sun4i_timer driver fails to get an interrupt from PLIC.
>
> The real fix requires enabling the SBI time extension in the platform
> firmware (OpenSBI) and convert sun4i_timer into platform driver.
> Unfortunately, the real fix involves changing multiple places and
> can't be achieved in a short duration.
>
> As a work-around, retrofit plic probing such that plic is probed
> early only for the Allwinner D1 platform and probed as a regular
> platform driver for rest of the RISC-V platforms. In the process,
> partially revert some of the previous patches because PLIC device
> pointer is not available in all probing paths.
>
> More detailed discussion can found here:
> https://lore.kernel.org/lkml/20240814145642.344485-1-emil.renner.berthing@canonical.com/
>
> Fixes: e306a894bd51 ("irqchip/sifive-plic: Chain to parent IRQ after handlers are ready")
> Fixes: 8ec99b033147 ("irqchip/sifive-plic: Convert PLIC driver into a platform driver")
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> Tested-by: Samuel Holland <samuel.holland@sifive.com>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
> Changes since v1:
>  - Set suppress_bind_attrs for PLIC platform driver
> ---
>  drivers/irqchip/irq-sifive-plic.c | 128 +++++++++++++++++++-----------
>  1 file changed, 80 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index 9e22f7e378f5..33395c5a9b5b 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -3,6 +3,7 @@
>   * Copyright (C) 2017 SiFive
>   * Copyright (C) 2018 Christoph Hellwig
>   */
> +#define pr_fmt(fmt) "riscv-plic: " fmt
>  #include <linux/cpu.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> @@ -63,7 +64,7 @@
>  #define PLIC_QUIRK_EDGE_INTERRUPT	0
>
>  struct plic_priv {
> -	struct device *dev;
> +	struct fwnode_handle *fwnode;
>  	struct cpumask lmask;
>  	struct irq_domain *irqdomain;
>  	void __iomem *regs;
> @@ -378,8 +379,8 @@ static void plic_handle_irq(struct irq_desc *desc)
>  		int err = generic_handle_domain_irq(handler->priv->irqdomain,
>  						    hwirq);
>  		if (unlikely(err)) {
> -			dev_warn_ratelimited(handler->priv->dev,
> -					     "can't find mapping for hwirq %lu\n", hwirq);
> +			pr_warn_ratelimited("%pfwP: can't find mapping for hwirq %lu\n",
> +					    handler->priv->fwnode, hwirq);
>  		}
>  	}
>
> @@ -408,15 +409,14 @@ static int plic_starting_cpu(unsigned int cpu)
>  		enable_percpu_irq(plic_parent_irq,
>  				  irq_get_trigger_type(plic_parent_irq));
>  	else
> -		dev_warn(handler->priv->dev, "cpu%d: parent irq not available\n", cpu);
> +		pr_warn("%pfwP: cpu%d: parent irq not available\n",
> +			handler->priv->fwnode, cpu);
>  	plic_set_threshold(handler, PLIC_ENABLE_THRESHOLD);
>
>  	return 0;
>  }
>
> -static const struct of_device_id plic_match[] = {
> -	{ .compatible = "sifive,plic-1.0.0" },
> -	{ .compatible = "riscv,plic0" },
> +static const struct of_device_id plic_quirks_match[] = {
>  	{ .compatible = "andestech,nceplic100",
>  	  .data = (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
>  	{ .compatible = "thead,c900-plic",
> @@ -424,38 +424,36 @@ static const struct of_device_id plic_match[] = {
>  	{}
>  };
>
> -static int plic_parse_nr_irqs_and_contexts(struct platform_device *pdev,
> +static int plic_parse_nr_irqs_and_contexts(struct fwnode_handle *fwnode,
>  					   u32 *nr_irqs, u32 *nr_contexts)
>  {
> -	struct device *dev = &pdev->dev;
>  	int rc;
>
>  	/*
>  	 * Currently, only OF fwnode is supported so extend this
>  	 * function for ACPI support.
>  	 */
> -	if (!is_of_node(dev->fwnode))
> +	if (!is_of_node(fwnode))
>  		return -EINVAL;
>
> -	rc = of_property_read_u32(to_of_node(dev->fwnode), "riscv,ndev", nr_irqs);
> +	rc = of_property_read_u32(to_of_node(fwnode), "riscv,ndev", nr_irqs);
>  	if (rc) {
> -		dev_err(dev, "riscv,ndev property not available\n");
> +		pr_err("%pfwP: riscv,ndev property not available\n", fwnode);
>  		return rc;
>  	}
>
> -	*nr_contexts = of_irq_count(to_of_node(dev->fwnode));
> +	*nr_contexts = of_irq_count(to_of_node(fwnode));
>  	if (WARN_ON(!(*nr_contexts))) {
> -		dev_err(dev, "no PLIC context available\n");
> +		pr_err("%pfwP: no PLIC context available\n", fwnode);
>  		return -EINVAL;
>  	}
>
>  	return 0;
>  }
>
> -static int plic_parse_context_parent(struct platform_device *pdev, u32 context,
> +static int plic_parse_context_parent(struct fwnode_handle *fwnode, u32 context,
>  				     u32 *parent_hwirq, int *parent_cpu)
>  {
> -	struct device *dev = &pdev->dev;
>  	struct of_phandle_args parent;
>  	unsigned long hartid;
>  	int rc;
> @@ -464,10 +462,10 @@ static int plic_parse_context_parent(struct platform_device *pdev, u32 context,
>  	 * Currently, only OF fwnode is supported so extend this
>  	 * function for ACPI support.
>  	 */
> -	if (!is_of_node(dev->fwnode))
> +	if (!is_of_node(fwnode))
>  		return -EINVAL;
>
> -	rc = of_irq_parse_one(to_of_node(dev->fwnode), context, &parent);
> +	rc = of_irq_parse_one(to_of_node(fwnode), context, &parent);
>  	if (rc)
>  		return rc;
>
> @@ -480,48 +478,55 @@ static int plic_parse_context_parent(struct platform_device *pdev, u32 context,
>  	return 0;
>  }
>
> -static int plic_probe(struct platform_device *pdev)
> +static int plic_probe(struct fwnode_handle *fwnode)
>  {
>  	int error = 0, nr_contexts, nr_handlers = 0, cpu, i;
> -	struct device *dev = &pdev->dev;
>  	unsigned long plic_quirks = 0;
>  	struct plic_handler *handler;
>  	u32 nr_irqs, parent_hwirq;
>  	struct plic_priv *priv;
>  	irq_hw_number_t hwirq;
> +	void __iomem *regs;
>
> -	if (is_of_node(dev->fwnode)) {
> +	if (is_of_node(fwnode)) {
>  		const struct of_device_id *id;
>
> -		id = of_match_node(plic_match, to_of_node(dev->fwnode));
> +		id = of_match_node(plic_quirks_match, to_of_node(fwnode));
>  		if (id)
>  			plic_quirks = (unsigned long)id->data;
> +
> +		regs = of_iomap(to_of_node(fwnode), 0);
> +		if (!regs)
> +			return -ENOMEM;
> +	} else {
> +		return -ENODEV;

This driver never worked with ACPI anyways?

>  	}
>
> -	error = plic_parse_nr_irqs_and_contexts(pdev, &nr_irqs, &nr_contexts);
> +	error = plic_parse_nr_irqs_and_contexts(fwnode, &nr_irqs, &nr_contexts);
>  	if (error)
> -		return error;
> +		goto fail_free_regs;
>
> -	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> -	if (!priv)
> -		return -ENOMEM;
> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +	if (!priv) {
> +		error = -ENOMEM;
> +		goto fail_free_regs;
> +	}
>
> -	priv->dev = dev;
> +	priv->fwnode = fwnode;
>  	priv->plic_quirks = plic_quirks;
>  	priv->nr_irqs = nr_irqs;
> +	priv->regs = regs;
>
> -	priv->regs = devm_platform_ioremap_resource(pdev, 0);
> -	if (WARN_ON(!priv->regs))
> -		return -EIO;
> -
> -	priv->prio_save = devm_bitmap_zalloc(dev, nr_irqs, GFP_KERNEL);
> -	if (!priv->prio_save)
> -		return -ENOMEM;
> +	priv->prio_save = bitmap_zalloc(nr_irqs, GFP_KERNEL);
> +	if (!priv->prio_save) {
> +		error = -ENOMEM;
> +		goto fail_free_priv;
> +	}
>
>  	for (i = 0; i < nr_contexts; i++) {
> -		error = plic_parse_context_parent(pdev, i, &parent_hwirq, &cpu);
> +		error = plic_parse_context_parent(fwnode, i, &parent_hwirq, &cpu);
>  		if (error) {
> -			dev_warn(dev, "hwirq for context%d not found\n", i);
> +			pr_warn("%pfwP: hwirq for context%d not found\n", fwnode, i);
>  			continue;
>  		}
>
> @@ -543,7 +548,7 @@ static int plic_probe(struct platform_device *pdev)
>  		}
>
>  		if (cpu < 0) {
> -			dev_warn(dev, "Invalid cpuid for context %d\n", i);
> +			pr_warn("%pfwP: Invalid cpuid for context %d\n", fwnode, i);
>  			continue;
>  		}
>
> @@ -554,7 +559,7 @@ static int plic_probe(struct platform_device *pdev)
>  		 */
>  		handler = per_cpu_ptr(&plic_handlers, cpu);
>  		if (handler->present) {
> -			dev_warn(dev, "handler already present for context %d.\n", i);
> +			pr_warn("%pfwP: handler already present for context %d.\n", fwnode, i);
>  			plic_set_threshold(handler, PLIC_DISABLE_THRESHOLD);
>  			goto done;
>  		}
> @@ -568,8 +573,8 @@ static int plic_probe(struct platform_device *pdev)
>  			i * CONTEXT_ENABLE_SIZE;
>  		handler->priv = priv;
>
> -		handler->enable_save = devm_kcalloc(dev, DIV_ROUND_UP(nr_irqs, 32),
> -						    sizeof(*handler->enable_save), GFP_KERNEL);
> +		handler->enable_save = kcalloc(DIV_ROUND_UP(nr_irqs, 32),
> +					       sizeof(*handler->enable_save), GFP_KERNEL);
>  		if (!handler->enable_save)
>  			goto fail_cleanup_contexts;
>  done:
> @@ -581,7 +586,7 @@ static int plic_probe(struct platform_device *pdev)
>  		nr_handlers++;
>  	}
>
> -	priv->irqdomain = irq_domain_add_linear(to_of_node(dev->fwnode), nr_irqs + 1,
> +	priv->irqdomain = irq_domain_add_linear(to_of_node(fwnode), nr_irqs + 1,
>  						&plic_irqdomain_ops, priv);
>  	if (WARN_ON(!priv->irqdomain))
>  		goto fail_cleanup_contexts;
> @@ -619,13 +624,13 @@ static int plic_probe(struct platform_device *pdev)
>  		}
>  	}
>
> -	dev_info(dev, "mapped %d interrupts with %d handlers for %d contexts.\n",
> -		 nr_irqs, nr_handlers, nr_contexts);
> +	pr_info("%pfwP: mapped %d interrupts with %d handlers for %d contexts.\n",
> +		fwnode, nr_irqs, nr_handlers, nr_contexts);
>  	return 0;
>
>  fail_cleanup_contexts:
>  	for (i = 0; i < nr_contexts; i++) {
> -		if (plic_parse_context_parent(pdev, i, &parent_hwirq, &cpu))
> +		if (plic_parse_context_parent(fwnode, i, &parent_hwirq, &cpu))
>  			continue;
>  		if (parent_hwirq != RV_IRQ_EXT || cpu < 0)
>  			continue;
> @@ -634,17 +639,44 @@ static int plic_probe(struct platform_device *pdev)
>  		handler->present = false;
>  		handler->hart_base = NULL;
>  		handler->enable_base = NULL;
> +		kfree(handler->enable_save);
>  		handler->enable_save = NULL;
>  		handler->priv = NULL;
>  	}
> -	return -ENOMEM;
> +	bitmap_free(priv->prio_save);
> +fail_free_priv:
> +	kfree(priv);
> +fail_free_regs:
> +	iounmap(regs);
> +	return error;
> +}
> +
> +static int plic_platform_probe(struct platform_device *pdev)
> +{
> +	return plic_probe(pdev->dev.fwnode);
>  }
>
> +static const struct of_device_id plic_platform_match[] = {
> +	{ .compatible = "sifive,plic-1.0.0" },
> +	{ .compatible = "riscv,plic0" },
> +	{ .compatible = "andestech,nceplic100" },
> +	{}
> +};
> +
>  static struct platform_driver plic_driver = {
>  	.driver = {
>  		.name		= "riscv-plic",
> -		.of_match_table	= plic_match,
> +		.of_match_table	= plic_platform_match,
> +		.suppress_bind_attrs = true,
>  	},
> -	.probe = plic_probe,
> +	.probe = plic_platform_probe,
>  };
>  builtin_platform_driver(plic_driver);
> +
> +static int __init plic_early_probe(struct device_node *node,
> +				   struct device_node *parent)
> +{
> +	return plic_probe(&node->fwnode);
> +}
> +
> +IRQCHIP_DECLARE(riscv, "thead,c900-plic", plic_early_probe);

If this is only needed on the Allwinner D1 maybe this should only match the
more specific "allwinner,sun20i-d1-plic"?

In any case this works by itself, but not with Samuel's patch[1] applied, so
Tested-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

[1]: https://lore.kernel.org/r/20240312192519.1602493-1-samuel.holland@sifive.com

