Return-Path: <linux-kernel+bounces-290071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 085EF954F15
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4E86286AF3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AB21BE87A;
	Fri, 16 Aug 2024 16:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="MG1Mitsj"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406741BE238
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 16:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723826600; cv=none; b=ANaJgJBx45dVNG7lEPYujyKQfOOU5LXxaawo4slrP4RU+4JMeS4OrV4dhj2fdkzlmbSKm2zozctzsLib9GyI0Gsy3u9TWbYYlB8xqHd8x5VspcY9nRkOCwkNiDFpCfzzTeQSZSqdCeThThekIwYaVTy71W4TMbYECv+lbS9ssE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723826600; c=relaxed/simple;
	bh=pzegc0w6VUTzZPR5INRQlX57MBSW5lQ3GntfoQKzMfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cSb8aCI1obWnFCVW3Ixd7fSMK8aNPvhkSFtgbkovNz604woFGDEJF3gN9jMo8gNei73LO4t7KeD0DVeR0vplx/TgERj5vdGtqDMOZv4FXQ2O9IDP5KgiNY50mr/amxS70vQhX+tbfMgZLDG3vAKQvM+N1sQPPUg5n0QTATeINjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=MG1Mitsj; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-39b3cae5675so6270755ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 09:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1723826597; x=1724431397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0MfQcLd63ii/bmjsa/lyPKgdDyOlZYmQpscvNUj55Ss=;
        b=MG1MitsjZIWzd1ewFIm277XbGzXYTXARmDjRhWH5ELbouHjiHoNq2A9sB9pxyq3gEZ
         Zwx88tth6/j5DTsyoE+fh9tvZjTOSoAB10eF/SdJLdFQlJCNgsvXGuiCs3fJMrM8M5Q3
         +dwP+iKQho63zTSeb6n4j6wwlMywXgtkHkDTfLOJ1cWBdWOIHkH8tjKFPbnQUHFgVHZR
         u13v4aRA0GMrfxe+4ZKefcISXyiy07Ujd19dh4+0BIXJ+QN0hNTURJVB+Z0jne7fkzCS
         BoLoT8B8NA6VK8rWBJdDHeD7Dlu3bdf1NiveTdMHzQ8v19unfvU1y8sRcOOb772HZG76
         lhMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723826597; x=1724431397;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0MfQcLd63ii/bmjsa/lyPKgdDyOlZYmQpscvNUj55Ss=;
        b=nKiciH46wgc1WxS11KStWePXl4gkF6mQ3tipeINil4HfFA7fwhzvIndVRNg0YzW1t0
         rk9hQyNCuOU5GJa8pbpY/0Qsam9AmHp67WiDtG5FnafzncXRFltoyW8fjuwYPovxCKej
         xRQApu6RaefkuM4thPsoqSariOwTMhS7CpTjcKdWq30qoERYgu9yWZJJWUWeNMwd0vcb
         JE4r1TH4lWJO19P95QD7L3Q3dERP21kZ5XkZojrYYwiDnomDH2M1uBjOFoj+Nwaaj9Uy
         ayDi7uq4W1aHVOHNGMW+QIWCLNkk8qpmytN8Fy8wZ9j8ro/fg4hwcLrncSyu3iAUTCR3
         8HuA==
X-Forwarded-Encrypted: i=1; AJvYcCXZm7w31/XZzAuHqcXdys6qXPT1nq5qPXjqgQOMywt/IFSUwUYP7GNGBNuUAliHD1KYcJK8Rzii6UMPLJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDcz7z52b2z8kw8rEkFoQ5Z0a1i8afQ0pO2wCvBgmcKCjjS1z+
	zf6sxCa4SzdvMUb9ictAHt/LoV7B5Uv5sqadC0tyEpdE+uEMcFAb35p7HXOvc8A=
X-Google-Smtp-Source: AGHT+IFk+XDd8A9igBqIFs8RPUhycOEUMUGBOuAMj+7DbWe1oCt7fVrW62zHBAfJWKkF1owZ/3KRKA==
X-Received: by 2002:a05:6e02:5ab:b0:39d:24af:aff8 with SMTP id e9e14a558f8ab-39d24afb1a5mr40168145ab.7.1723826597081;
        Fri, 16 Aug 2024 09:43:17 -0700 (PDT)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39d1ead5447sm14669585ab.18.2024.08.16.09.43.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 09:43:16 -0700 (PDT)
Message-ID: <a13e8ddc-20d2-4d4d-8975-4352c38bbe69@sifive.com>
Date: Fri, 16 Aug 2024 11:43:14 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] irqchip/sifive-plic: Probe plic driver early for
 Allwinner D1 platform
To: Anup Patel <apatel@ventanamicro.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Atish Patra
 <atishp@atishpatra.org>, Andrew Jones <ajones@ventanamicro.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Anup Patel <anup@brainfault.org>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240816161828.2979143-1-apatel@ventanamicro.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <20240816161828.2979143-1-apatel@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Anup,

On 2024-08-16 11:18 AM, Anup Patel wrote:
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
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  drivers/irqchip/irq-sifive-plic.c | 128 +++++++++++++++++++-----------
>  1 file changed, 80 insertions(+), 48 deletions(-)

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Tested-by: Samuel Holland <samuel.holland@sifive.com>

v6.11-rc3 + this patch boots on D1 without CLINT in the devicetree:

[    0.000000][    T0] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000][    T0] riscv-intc: 64 local interrupts mapped
[    0.000000][    T0] riscv-plic: interrupt-controller@10000000: mapped 175 interrupts with 1 handlers for 2 contexts.
[    0.000000][    T0] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.000000][    T0] clocksource: timer: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635851949 ns
[    0.000000][    T0] clocksource: riscv_clocksource: mask: 0xffffffffffffffff max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
[    0.000001][    T0] sched_clock: 64 bits at 24MHz, resolution 41ns, wraps every 4398046511097ns
[    0.009362][    T0] Calibrating delay loop (skipped), value calculated using timer frequency.. 48.00 BogoMIPS (lpj=96000)

> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index 9e22f7e378f5..357d25662718 100644
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
> @@ -554,7 +559,8 @@ static int plic_probe(struct platform_device *pdev)
>  		 */
>  		handler = per_cpu_ptr(&plic_handlers, cpu);
>  		if (handler->present) {
> -			dev_warn(dev, "handler already present for context %d.\n", i);
> +			pr_warn("%pfwP: handler already present for context %d.\n",
> +				fwnode, i);
>  			plic_set_threshold(handler, PLIC_DISABLE_THRESHOLD);
>  			goto done;
>  		}
> @@ -568,8 +574,8 @@ static int plic_probe(struct platform_device *pdev)
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
> @@ -581,7 +587,7 @@ static int plic_probe(struct platform_device *pdev)
>  		nr_handlers++;
>  	}
>  
> -	priv->irqdomain = irq_domain_add_linear(to_of_node(dev->fwnode), nr_irqs + 1,
> +	priv->irqdomain = irq_domain_add_linear(to_of_node(fwnode), nr_irqs + 1,
>  						&plic_irqdomain_ops, priv);
>  	if (WARN_ON(!priv->irqdomain))
>  		goto fail_cleanup_contexts;
> @@ -619,13 +625,13 @@ static int plic_probe(struct platform_device *pdev)
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
> @@ -634,17 +640,43 @@ static int plic_probe(struct platform_device *pdev)
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
>  	},
> -	.probe = plic_probe,
> +	.probe = plic_platform_probe,
>  };
>  builtin_platform_driver(plic_driver);

FWIW, we should probably use the IRQCHIP_PLATFORM_DRIVER_* helpers to get
.suppress_bind_attrs = true, since we no longer use devres for cleanup.

Regards,
Samuel

> +
> +static int __init plic_early_probe(struct device_node *node,
> +				   struct device_node *parent)
> +{
> +	return plic_probe(&node->fwnode);
> +}
> +
> +IRQCHIP_DECLARE(riscv, "thead,c900-plic", plic_early_probe);


