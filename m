Return-Path: <linux-kernel+bounces-352573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3EA9920EA
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 21:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07E0B1F21303
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 19:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5635918B464;
	Sun,  6 Oct 2024 19:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U5JbwyWP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8Pp7Br4c"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C3218A6A9;
	Sun,  6 Oct 2024 19:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728244244; cv=none; b=hTGbM2Th02TQnADmORdVS5h/ZXewoOkvP33U8hbTbfjIk5AwM4IvC/xg9gW0e4tdN0v9yexpoafbgMuxZRsCN+uk/Cb60dJQY6lVdOs1cwNdGaMsnJwQX1EHKoglvs/y3FfsaHPwwR0ah+5s9zwpM5yrqDH8aq8QGCPt0KJUT6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728244244; c=relaxed/simple;
	bh=uy7X34Ztrc+dmUdMVDxVXnaBQo3HkOdL4XMvahW+JcI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eQsvvHau+gHn+e09ERRHUHefjiC7tJ1GebOFbCGxnHMvwUXhWdvII0IAgnrNM0Qph4N6VYpLqRAJ9/qn9Dl5WzHlbLmjTjnI/Wk5jDk2uePcBGPqo4y964YpLlWrNnl/qIOTDXX2gZmimo5jB8U97Wl3R5CDkLGOC65LuTC5Ldc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U5JbwyWP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8Pp7Br4c; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728244239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nc/JbJH2I7A6byNnWnWc+/cvpnXUco5JrWvK2DyOxAM=;
	b=U5JbwyWPpHNhe0OrPl+S8xv3KngZeKkol+Rjb46t2GP6SNe1lhfVv9iEEoSsLfBCpMktP3
	iPXyIgtklCji08tXYWqSOr2tvpP8rZkCLjZ1yw3hjhKnk09X2LwnLqpt81Na1H4xwX3COb
	JJEfHTfOcYye6b39irxgjwCkfVMH0KKS2WhkW8cOeAy29OMCE9Pz7gljemKOhK+yQY1trt
	mMuoTpdlIhe9jIYyjQcEOMyT8aFQ6UjrRl7wHp8zlrBgmPR56pg9hjBmN+4yumbt2b4M1x
	z/OBysomx69XjtNf+slmHBTbRcydjBQOdPdHtr/S8T9XJFOiXh3d3ErpN2yccw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728244239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nc/JbJH2I7A6byNnWnWc+/cvpnXUco5JrWvK2DyOxAM=;
	b=8Pp7Br4c+zF6PO/aPXwo1ag1XXNlz+hY8H5FUiFi8ej6AB1gFrnOCxrga7xdjCAm7jyWts
	LGbDbycVRcYdj8Dg==
To: Inochi Amaoto <inochiama@gmail.com>, Chen Wang
 <unicorn_wang@outlook.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Peter Zijlstra <peterz@infradead.org>,
 Inochi Amaoto <inochiama@outlook.com>, Guo Ren <guoren@kernel.org>, Lad
 Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Hal Feng
 <hal.feng@starfivetech.com>, Heikki Krogerus
 <heikki.krogerus@linux.intel.com>, Geert Uytterhoeven
 <geert+renesas@glider.be>
Cc: Yixun Lan <dlan@gentoo.org>, Inochi Amaoto <inochiama@gmail.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org
Subject: Re: [PATCH 2/3] irqchip: add T-HEAD C900 ACLINT SSWI driver
In-Reply-To: <20241004080557.2262872-3-inochiama@gmail.com>
References: <20241004080557.2262872-1-inochiama@gmail.com>
 <20241004080557.2262872-3-inochiama@gmail.com>
Date: Sun, 06 Oct 2024 21:50:39 +0200
Message-ID: <87jzelui28.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Oct 04 2024 at 16:05, Inochi Amaoto wrote:

> +#define pr_fmt(fmt) "thead-c900-aclint-sswi: " fmt
> +#include <linux/acpi.h>

What is this header used for?

> +static void thead_aclint_sswi_ipi_clear(void)
> +{
> +	unsigned int cpu = smp_processor_id();
> +	struct aclint_sswi_cpu_config *config = per_cpu_ptr(&sswi_cpus, cpu);

That's an unnecessary indirection.

       *config = __this_cpu_ptr(&sswi_cpus);

is what you want here.

> +	writel_relaxed(0x0, config->reg + config->offset);
> +}

...

> +static int aclint_sswi_parse_irq(struct fwnode_handle *fwnode,
> +				 void __iomem *reg)

Please avoid line breaks and use up to 100 characters per line.

> +{
> +	struct of_phandle_args parent;
> +	unsigned long hartid;
> +	u32 contexts, i;
> +	int rc, cpu;
> +	struct aclint_sswi_cpu_config *config;

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#variable-declarations

> +
> +	contexts = of_irq_count(to_of_node(fwnode));
> +	if (WARN_ON(!(contexts))) {

That WARN_ON() is pointless. The call chain is known and the pr_err() is
sufficient.

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
> +		config = per_cpu_ptr(&sswi_cpus, cpu);
> +
> +		config->offset = i * ACLINT_xSWI_REGISTER_SIZE;
> +		config->reg = reg;

Why do you need config->reg and config->offset? All call sites access
the register via:

    config->reg + config->offset

So you can spare the exercise of adding the offset in the hotpath by
adding it at setup time, no?


> +	}
> +
> +	pr_info("%pfwP: register %u CPU\n", fwnode, contexts);

  ...CPU%s\n", fwnode, contexts, str_plural(contexts));

> +
> +	return 0;
> +}
> +
> +static int __init aclint_sswi_probe(struct fwnode_handle *fwnode)
> +{
> +	void __iomem *reg;
> +	struct irq_domain *domain;
> +	int virq, rc;

See above.

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
> +	/* Find and create irq domain */

Which domain is created here?

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
> +			  aclint_sswi_ipi_starting_cpu, NULL);

The startup callback enables the per CPU interrupt. When a CPU is
offlined then the per CPU interrupt stays enabled because the teardown
callback is NULL. I'm not convinced that this is a good idea.

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

What's the point of this indirection?

> +

Pointless newline.

> +IRQCHIP_DECLARE(thead_aclint_sswi, "thead,c900-aclint-sswi", aclint_sswi_early_probe);

Thanks,

        tglx

