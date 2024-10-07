Return-Path: <linux-kernel+bounces-352673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E3E99227D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 02:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36D9C1C217F9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 00:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356C7DDC7;
	Mon,  7 Oct 2024 00:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMIkkcqD"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160584C6D;
	Mon,  7 Oct 2024 00:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728261557; cv=none; b=e2a6K+Owac+E9asOwpypVZac7fHW0fYRuzHdKRYVon6kuhAvqptpkcz4cPe3qP1IjZIEm/Tf7GTV9nrSyVyg6yZtqX0TmeAxMyeTlRA35+8ky7DriEZ8jLnOirVUXvXQakbPpOgGGfRuqai03fDEkXWldinXPhQqeADWAqufyco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728261557; c=relaxed/simple;
	bh=8KmDNbVCbHPyEuF9mE84VMsrpXyk6nvKPWwDu4SAreM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rG2+3Vwv5OIadplywTn04x+U9tpgY9ZzFK5VJ0uRCKh2K1+4TZRrgGJVV0JwdngCXiP7UZCVsDMZx28x6etlo7DmtOIO6IqhRfcPe5t5AVvVJhlKrMGZCUdykaMjTQW5UIR1b1RXSkK/vnJ1hfcUEA3ayyNx1sDcEW7Rftpsihg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMIkkcqD; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71df1fe11c1so1074305b3a.2;
        Sun, 06 Oct 2024 17:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728261555; x=1728866355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3uXCASsRqzWjb2Kpf3PXTREN4vfbVwBRJV25WvPZa1s=;
        b=BMIkkcqDIF5ZUnPemPRAuiWzSO/ho+LkIdwsdkvzIbqjb4TVACOxzz8FyjMuOcOwlR
         3IMMe6Osr1xtAgTLpThMcyHjNSjeojqtXSSzqgoSs4vLAKxcDH5VQraJMB2wLRXZZYsT
         k7tIRf3YRN/9IQQFbnCczQXnA1+rjCirIne70SrTRH97DpQJ3kmkP3nq9smfBlABXSbj
         6udAsFV0uApyJ6vM1uLeDH7M0tKKUtqN5pXy70kV+ZK+7jUMUbu7fXzNs1NsBfq2nju3
         Y6OdnC4LmeKT9ngKzrWWAoCC0DLHddVUIOwiq2DSznf5XlBeT+OWnCJy/Y1pVDglJThy
         eY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728261555; x=1728866355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3uXCASsRqzWjb2Kpf3PXTREN4vfbVwBRJV25WvPZa1s=;
        b=CsqVrzom6jr3SmemVtJu8FEP1KHVi3+Sk6WyOBF2oAaxY9opGxtklurEjpgvQTb0Z7
         0aiaG5+GxAzsjh+lNJ/fHV8XOFYjCjX3kU1kb/WoLCZf03cW6JCJiqqGl1iUrkYULmb3
         ATAK4/4HRxTY+pBswbVIjeoCtxyEfLvVOKt2mZYEJGnWVkBiul12vt5PyDGdUUKx/HI5
         qej1ScnpxYA4XcZFZ/0ORUsjzMs/EeY9CcktGQe2QbaURBmurTbXy/CNPFJdwHJx/PJe
         OXCH7msPf3pN3ySX1nriErrwPvGAPHfCcbi++oYwpw7wMCLJbNCm+Syq752ZpwKCrZ+N
         fGpg==
X-Forwarded-Encrypted: i=1; AJvYcCUf0sd1WRalkaF/lPVlh/PKGOaK3226TV/cT/Z/AokeBjKLu/QH1aqyg+DdpYQQHMzc5/la1B0Kg7vc@vger.kernel.org, AJvYcCWIsN20f099V9RU98tMDhLRhqEotiR4jdrayA6Ah20bjTqTYCgO0F3HkjrwmeGbom4TEjwSiHXN76/jAMjK@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ+0AhVv7by8x+YmSOoVfyxTpkd8Nn2c5WLQXW9nekSkW17pIT
	HF/Gqcj5e+yTPrG+JEhBLQVThpPhki42U98T5LW0V8EhcbHBGV5Y
X-Google-Smtp-Source: AGHT+IH2IpLXsDe8zQHUYo3XulPP7+4/6XzH/QWIllC9nYhuRzOru6FuIuX06gO4kzYy6vb2/t4syA==
X-Received: by 2002:a05:6a00:3e1b:b0:71d:fb29:9edc with SMTP id d2e1a72fcca58-71dfb29a2acmr7540926b3a.3.1728261555211;
        Sun, 06 Oct 2024 17:39:15 -0700 (PDT)
Received: from inochi.infowork ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0ccf01dsm3301354b3a.70.2024.10.06.17.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 17:39:14 -0700 (PDT)
Date: Mon, 7 Oct 2024 08:38:53 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>, 
	Inochi Amaoto <inochiama@gmail.com>, Chen Wang <unicorn_wang@outlook.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Peter Zijlstra <peterz@infradead.org>, Inochi Amaoto <inochiama@outlook.com>, 
	Guo Ren <guoren@kernel.org>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Hal Feng <hal.feng@starfivetech.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Yixun Lan <dlan@gentoo.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 2/3] irqchip: add T-HEAD C900 ACLINT SSWI driver
Message-ID: <krieplgqalbjs7o5ylv5t6x77csuoknnhyc2pzdga4tu4mu73w@vjux46t3ijxr>
References: <20241004080557.2262872-1-inochiama@gmail.com>
 <20241004080557.2262872-3-inochiama@gmail.com>
 <87jzelui28.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzelui28.ffs@tglx>

On Sun, Oct 06, 2024 at 09:50:39PM +0200, Thomas Gleixner wrote:
> On Fri, Oct 04 2024 at 16:05, Inochi Amaoto wrote:
> 
> > +#define pr_fmt(fmt) "thead-c900-aclint-sswi: " fmt
> > +#include <linux/acpi.h>
> 
> What is this header used for?
> 

This is copy-pasted error, I wiil remove it.

> > +static void thead_aclint_sswi_ipi_clear(void)
> > +{
> > +	unsigned int cpu = smp_processor_id();
> > +	struct aclint_sswi_cpu_config *config = per_cpu_ptr(&sswi_cpus, cpu);
> 
> That's an unnecessary indirection.
> 
>        *config = __this_cpu_ptr(&sswi_cpus);
> 
> is what you want here.

Thanks.

> 
> > +	writel_relaxed(0x0, config->reg + config->offset);
> > +}
> 
> ...
> 
> > +static int aclint_sswi_parse_irq(struct fwnode_handle *fwnode,
> > +				 void __iomem *reg)
> 
> Please avoid line breaks and use up to 100 characters per line.
> 
> > +{
> > +	struct of_phandle_args parent;
> > +	unsigned long hartid;
> > +	u32 contexts, i;
> > +	int rc, cpu;
> > +	struct aclint_sswi_cpu_config *config;
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#variable-declarations
> 
> > +
> > +	contexts = of_irq_count(to_of_node(fwnode));
> > +	if (WARN_ON(!(contexts))) {
> 
> That WARN_ON() is pointless. The call chain is known and the pr_err() is
> sufficient.
> 
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
> > +		config = per_cpu_ptr(&sswi_cpus, cpu);
> > +
> > +		config->offset = i * ACLINT_xSWI_REGISTER_SIZE;
> > +		config->reg = reg;
> 
> Why do you need config->reg and config->offset? All call sites access
> the register via:
> 
>     config->reg + config->offset
> 
> So you can spare the exercise of adding the offset in the hotpath by
> adding it at setup time, no?

Thanks, I only consider supporting multiple device, but forgot that it
can be computed earily.

> 
> 
> > +	}
> > +
> > +	pr_info("%pfwP: register %u CPU\n", fwnode, contexts);
> 
>   ...CPU%s\n", fwnode, contexts, str_plural(contexts));
> 
> > +
> > +	return 0;
> > +}
> > +
> > +static int __init aclint_sswi_probe(struct fwnode_handle *fwnode)
> > +{
> > +	void __iomem *reg;
> > +	struct irq_domain *domain;
> > +	int virq, rc;
> 
> See above.
> 
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
> > +	/* Find and create irq domain */
> 
> Which domain is created here?
> 

It will create an IPI domain. I will update the comment.

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
> > +			  aclint_sswi_ipi_starting_cpu, NULL);
> 
> The startup callback enables the per CPU interrupt. When a CPU is
> offlined then the per CPU interrupt stays enabled because the teardown
> callback is NULL. I'm not convinced that this is a good idea.
> 

Yes, I will add the cleanup handle to clear IPI and disable the IPI 
irq for the CPU.

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
> 
> What's the point of this indirection?
> 

This is make room for the future ACPI probe.

> > +
> 
> Pointless newline.
> 
> > +IRQCHIP_DECLARE(thead_aclint_sswi, "thead,c900-aclint-sswi", aclint_sswi_early_probe);
> 
> Thanks,
> 
>         tglx

Regards,
Inochi

