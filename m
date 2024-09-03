Return-Path: <linux-kernel+bounces-312426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 356FE969676
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC26C2836B7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD0C200108;
	Tue,  3 Sep 2024 08:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fkhnyRQu"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB69200137
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 08:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725350701; cv=none; b=eDXRIpl04+tkdjxGgV31kf63/mymaaKkwdGyBUha9BPBxcjJGDgD9ZsTG1Kl9psfuwmaem8oYq53FSsqTYDHM4jly5a/Bl72N8cSJTxGDfWAQGT/WMHelI9zTCEnMQ3uzJuNBLiQj42b6uRg2Hyw/hJ5D01ZdsZakD1O+vGt8lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725350701; c=relaxed/simple;
	bh=RGrXmOgnowhVVrC98wd7LmXc2+AtmOoOXLgpAsJYIvE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oiJZCbLeswM6xgQuFh65AbAMeVIzOXXIHHXx2O0+EWyzo/ugZeVpS0NjnKLiXMmR1RuTRGfXOWN60Q6rCvKTTruQGrjQImB8teVcr0ONE/TVr3WXSr27pINCPXxPFDJ3DSk2iloqySyOw39mAaG24lOGGNAnCqqhyrDQI7XIq/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fkhnyRQu; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-374c1963cb6so1608505f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 01:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725350696; x=1725955496; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/qX1A/V+EALCgcOKuHmLgiczal6z3/FCXnWffvTVJQM=;
        b=fkhnyRQuovm3QcuRDpCTr6eoUzh/0abHI3arhZgb/VcF8dCr6+pSVgFx0esRpIDjzT
         8ckoZMCKB1CPff4q2er+vTDdFg9dI/46NkYZn5WL0V/LtXbfcXFxfKpxsnm44lObt6gs
         MsjLHLYSgGmzj7oalRoPRK30FK0F+ZVzgmF5/qa4i6HmPv73os8QjS/Ne/34qgZimivL
         uxqkQzrlr4cPDfVghfdnLLRtaZxMhEut50NMbcUVZwOvzp2TvjLCnVANamI42igKTgIu
         ZCLAixu0jSDoOyRtpHNoyqFvb6z8pnIIXLPVU2o6FM11+b+XbrQUnP11yrLPjzgzHGmP
         S7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725350696; x=1725955496;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/qX1A/V+EALCgcOKuHmLgiczal6z3/FCXnWffvTVJQM=;
        b=jHUnz+h1YIVJxIx/UFWOa1bImyzYLQNn3T5Ufaef+FpGGvIfhzdJegHZeIYb1ebR/r
         duqHbpZuUo0qlCl6mldK8IHJ+XWcKN/TMmFBe7oTx2Z++cRaIR5dbPgUy8kpPkQkAr/F
         2C7gxDWkz58rZPB1SzzblynDbYsTdogXLZ3lw9vKKcR1eXYdheakaLBbC763YG9yUxZQ
         /rjDQu0KTr1r4GedKj+aC8qlxe3IvS2Gm0gGjEsMoawOyROXthBKdS+XJ1MkTNKff3lp
         PF7DnXWoh7JFc1bx2c7+5XMgV5+GDkGiV3bVfcJ5BRoA5IlMZAwqUcPbtKntA52MoUg/
         KOCw==
X-Forwarded-Encrypted: i=1; AJvYcCWFBMfSiBqCtaiLrUWCgohJ3F+RKSAx+qeuJXcSaEl1ofnrsYX75mALURYKZpx5Kh5bTbYPP8213UaFYqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG2HpPsyWXRX2MCEq1NjacbLS1pE4Krvlzrkl5ck4HF6OytOjH
	JLplCK7+JzlBEEf2JrlSr9fZ5SK8fCXtkZmphcXg3S7k3jaProvQZcHou2oydW79sVjKU4OGEQp
	d
X-Google-Smtp-Source: AGHT+IFnS8Uir8S2VdjQzm/wY2vQOaM7bczdFgE53se0+6PVYmAxhWGlxvXEYv0J4NgdRvzTLlztkg==
X-Received: by 2002:adf:fed1:0:b0:374:d157:c019 with SMTP id ffacd0b85a97d-374d157c565mr2256086f8f.12.1725350696235;
        Tue, 03 Sep 2024 01:04:56 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df0a42sm159513565e9.11.2024.09.03.01.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 01:04:55 -0700 (PDT)
Date: Tue, 3 Sep 2024 11:04:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Anup Patel <apatel@ventanamicro.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Charlie Jenkins <charlie@rivosinc.com>
Subject: drivers/irqchip/irq-sifive-plic.c:581 plic_probe() warn: missing
 error code 'error'
Message-ID: <3277cc38-a074-4d75-b2fe-11e0700edddb@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   67784a74e258a467225f0e68335df77acd67b7ab
commit: 4d936f10ff80274841537a26d1fbfe9984de0ef9 irqchip/sifive-plic: Probe plic driver early for Allwinner D1 platform
date:   2 weeks ago
config: riscv-randconfig-r072-20240901 (https://download.01.org/0day-ci/archive/20240903/202409031122.yBh8HrxA-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 6f682c26b04f0b349c4c473756cb8625b4f37c6d)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202409031122.yBh8HrxA-lkp@intel.com/

smatch warnings:
drivers/irqchip/irq-sifive-plic.c:581 plic_probe() warn: missing error code 'error'

vim +/error +581 drivers/irqchip/irq-sifive-plic.c

4d936f10ff80274 Anup Patel        2024-08-20  483  static int plic_probe(struct fwnode_handle *fwnode)
8237f8bc4f6eb7e Christoph Hellwig 2018-07-26  484  {
a15587277a246c3 Anup Patel        2024-02-22  485  	int error = 0, nr_contexts, nr_handlers = 0, cpu, i;
8ec99b033147ef3 Anup Patel        2024-02-22  486  	unsigned long plic_quirks = 0;
2234ae846ccb9eb Anup Patel        2020-05-18  487  	struct plic_handler *handler;
a15587277a246c3 Anup Patel        2024-02-22  488  	u32 nr_irqs, parent_hwirq;
8ec99b033147ef3 Anup Patel        2024-02-22  489  	struct plic_priv *priv;
8237f8bc4f6eb7e Christoph Hellwig 2018-07-26  490  	irq_hw_number_t hwirq;
4d936f10ff80274 Anup Patel        2024-08-20  491  	void __iomem *regs;
8237f8bc4f6eb7e Christoph Hellwig 2018-07-26  492  
4d936f10ff80274 Anup Patel        2024-08-20  493  	if (is_of_node(fwnode)) {
8ec99b033147ef3 Anup Patel        2024-02-22  494  		const struct of_device_id *id;
8ec99b033147ef3 Anup Patel        2024-02-22  495  
4d936f10ff80274 Anup Patel        2024-08-20  496  		id = of_match_node(plic_match, to_of_node(fwnode));
8ec99b033147ef3 Anup Patel        2024-02-22  497  		if (id)
8ec99b033147ef3 Anup Patel        2024-02-22  498  			plic_quirks = (unsigned long)id->data;
4d936f10ff80274 Anup Patel        2024-08-20  499  
4d936f10ff80274 Anup Patel        2024-08-20  500  		regs = of_iomap(to_of_node(fwnode), 0);
4d936f10ff80274 Anup Patel        2024-08-20  501  		if (!regs)
4d936f10ff80274 Anup Patel        2024-08-20  502  			return -ENOMEM;
4d936f10ff80274 Anup Patel        2024-08-20  503  	} else {
4d936f10ff80274 Anup Patel        2024-08-20  504  		return -ENODEV;
8ec99b033147ef3 Anup Patel        2024-02-22  505  	}
8237f8bc4f6eb7e Christoph Hellwig 2018-07-26  506  
4d936f10ff80274 Anup Patel        2024-08-20  507  	error = plic_parse_nr_irqs_and_contexts(fwnode, &nr_irqs, &nr_contexts);
95652106478030f Anup Patel        2024-02-22  508  	if (error)
4d936f10ff80274 Anup Patel        2024-08-20  509  		goto fail_free_regs;
95652106478030f Anup Patel        2024-02-22  510  
4d936f10ff80274 Anup Patel        2024-08-20  511  	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
4d936f10ff80274 Anup Patel        2024-08-20  512  	if (!priv) {
4d936f10ff80274 Anup Patel        2024-08-20  513  		error = -ENOMEM;
4d936f10ff80274 Anup Patel        2024-08-20  514  		goto fail_free_regs;
4d936f10ff80274 Anup Patel        2024-08-20  515  	}
8237f8bc4f6eb7e Christoph Hellwig 2018-07-26  516  
4d936f10ff80274 Anup Patel        2024-08-20  517  	priv->fwnode = fwnode;
dd46337ca69662b Lad Prabhakar     2022-06-30  518  	priv->plic_quirks = plic_quirks;
95652106478030f Anup Patel        2024-02-22  519  	priv->nr_irqs = nr_irqs;
4d936f10ff80274 Anup Patel        2024-08-20  520  	priv->regs = regs;
dd46337ca69662b Lad Prabhakar     2022-06-30  521  
4d936f10ff80274 Anup Patel        2024-08-20  522  	priv->prio_save = bitmap_zalloc(nr_irqs, GFP_KERNEL);
4d936f10ff80274 Anup Patel        2024-08-20  523  	if (!priv->prio_save) {
4d936f10ff80274 Anup Patel        2024-08-20  524  		error = -ENOMEM;
4d936f10ff80274 Anup Patel        2024-08-20  525  		goto fail_free_priv;
4d936f10ff80274 Anup Patel        2024-08-20  526  	}
e80f0b6a2cf302b Mason Huo         2023-04-04  527  
6adfe8d2f5b3535 Anup Patel        2019-02-12  528  	for (i = 0; i < nr_contexts; i++) {
4d936f10ff80274 Anup Patel        2024-08-20  529  		error = plic_parse_context_parent(fwnode, i, &parent_hwirq, &cpu);
a15587277a246c3 Anup Patel        2024-02-22  530  		if (error) {
4d936f10ff80274 Anup Patel        2024-08-20  531  			pr_warn("%pfwP: hwirq for context%d not found\n", fwnode, i);
8237f8bc4f6eb7e Christoph Hellwig 2018-07-26  532  			continue;
8237f8bc4f6eb7e Christoph Hellwig 2018-07-26  533  		}
8237f8bc4f6eb7e Christoph Hellwig 2018-07-26  534  
a4c3733d32a72f1 Christoph Hellwig 2019-10-28  535  		/*
a4c3733d32a72f1 Christoph Hellwig 2019-10-28  536  		 * Skip contexts other than external interrupts for our
a4c3733d32a72f1 Christoph Hellwig 2019-10-28  537  		 * privilege level.
a4c3733d32a72f1 Christoph Hellwig 2019-10-28  538  		 */
a15587277a246c3 Anup Patel        2024-02-22  539  		if (parent_hwirq != RV_IRQ_EXT) {
098fdbc3531f06a Niklas Cassel     2022-03-02  540  			/* Disable S-mode enable bits if running in M-mode. */
098fdbc3531f06a Niklas Cassel     2022-03-02  541  			if (IS_ENABLED(CONFIG_RISCV_M_MODE)) {
098fdbc3531f06a Niklas Cassel     2022-03-02  542  				void __iomem *enable_base = priv->regs +
098fdbc3531f06a Niklas Cassel     2022-03-02  543  					CONTEXT_ENABLE_BASE +
098fdbc3531f06a Niklas Cassel     2022-03-02  544  					i * CONTEXT_ENABLE_SIZE;
098fdbc3531f06a Niklas Cassel     2022-03-02  545  
098fdbc3531f06a Niklas Cassel     2022-03-02  546  				for (hwirq = 1; hwirq <= nr_irqs; hwirq++)
098fdbc3531f06a Niklas Cassel     2022-03-02  547  					__plic_toggle(enable_base, hwirq, 0);
098fdbc3531f06a Niklas Cassel     2022-03-02  548  			}
8237f8bc4f6eb7e Christoph Hellwig 2018-07-26  549  			continue;
098fdbc3531f06a Niklas Cassel     2022-03-02  550  		}
8237f8bc4f6eb7e Christoph Hellwig 2018-07-26  551  
fc03acaeab358c0 Atish Patra       2019-02-12  552  		if (cpu < 0) {
4d936f10ff80274 Anup Patel        2024-08-20  553  			pr_warn("%pfwP: Invalid cpuid for context %d\n", fwnode, i);
fc03acaeab358c0 Atish Patra       2019-02-12  554  			continue;
fc03acaeab358c0 Atish Patra       2019-02-12  555  		}
fc03acaeab358c0 Atish Patra       2019-02-12  556  
9ce06497c2722a0 Christoph Hellwig 2019-09-03  557  		/*
9ce06497c2722a0 Christoph Hellwig 2019-09-03  558  		 * When running in M-mode we need to ignore the S-mode handler.
9ce06497c2722a0 Christoph Hellwig 2019-09-03  559  		 * Here we assume it always comes later, but that might be a
9ce06497c2722a0 Christoph Hellwig 2019-09-03  560  		 * little fragile.
9ce06497c2722a0 Christoph Hellwig 2019-09-03  561  		 */
8237f8bc4f6eb7e Christoph Hellwig 2018-07-26  562  		handler = per_cpu_ptr(&plic_handlers, cpu);
3fecb5aac288881 Anup Patel        2019-02-12  563  		if (handler->present) {
4d936f10ff80274 Anup Patel        2024-08-20  564  			pr_warn("%pfwP: handler already present for context %d.\n", fwnode, i);
ccbe80bad571c2f Atish Patra       2020-03-02  565  			plic_set_threshold(handler, PLIC_DISABLE_THRESHOLD);
9ce06497c2722a0 Christoph Hellwig 2019-09-03  566  			goto done;

This is a success path so that's okay.

3fecb5aac288881 Anup Patel        2019-02-12  567  		}
3fecb5aac288881 Anup Patel        2019-02-12  568  
f1ad1133b18f2ae Atish Patra       2020-03-02  569  		cpumask_set_cpu(cpu, &priv->lmask);
8237f8bc4f6eb7e Christoph Hellwig 2018-07-26  570  		handler->present = true;
0d3616bbd03cdfa Niklas Cassel     2022-03-02  571  		handler->hart_base = priv->regs + CONTEXT_BASE +
0d3616bbd03cdfa Niklas Cassel     2022-03-02  572  			i * CONTEXT_SIZE;
86c7cbf1e8d1d4f Anup Patel        2019-02-12  573  		raw_spin_lock_init(&handler->enable_lock);
0d3616bbd03cdfa Niklas Cassel     2022-03-02  574  		handler->enable_base = priv->regs + CONTEXT_ENABLE_BASE +
0d3616bbd03cdfa Niklas Cassel     2022-03-02  575  			i * CONTEXT_ENABLE_SIZE;
f1ad1133b18f2ae Atish Patra       2020-03-02  576  		handler->priv = priv;
e80f0b6a2cf302b Mason Huo         2023-04-04  577  
4d936f10ff80274 Anup Patel        2024-08-20  578  		handler->enable_save = kcalloc(DIV_ROUND_UP(nr_irqs, 32),
e80f0b6a2cf302b Mason Huo         2023-04-04  579  					       sizeof(*handler->enable_save), GFP_KERNEL);
e80f0b6a2cf302b Mason Huo         2023-04-04  580  		if (!handler->enable_save)
a15587277a246c3 Anup Patel        2024-02-22 @581  			goto fail_cleanup_contexts;

error = -ENOMEM;

9ce06497c2722a0 Christoph Hellwig 2019-09-03  582  done:
a1706a1c5062e09 Samuel Holland    2022-07-01  583  		for (hwirq = 1; hwirq <= nr_irqs; hwirq++) {
86c7cbf1e8d1d4f Anup Patel        2019-02-12  584  			plic_toggle(handler, hwirq, 0);
a1706a1c5062e09 Samuel Holland    2022-07-01  585  			writel(1, priv->regs + PRIORITY_BASE +
a1706a1c5062e09 Samuel Holland    2022-07-01  586  				  hwirq * PRIORITY_PER_ID);
a1706a1c5062e09 Samuel Holland    2022-07-01  587  		}
6adfe8d2f5b3535 Anup Patel        2019-02-12  588  		nr_handlers++;
8237f8bc4f6eb7e Christoph Hellwig 2018-07-26  589  	}
8237f8bc4f6eb7e Christoph Hellwig 2018-07-26  590  
4d936f10ff80274 Anup Patel        2024-08-20  591  	priv->irqdomain = irq_domain_add_linear(to_of_node(fwnode), nr_irqs + 1,
b68d0ff529a939a Anup Patel        2024-02-22  592  						&plic_irqdomain_ops, priv);
b68d0ff529a939a Anup Patel        2024-02-22  593  	if (WARN_ON(!priv->irqdomain))
a15587277a246c3 Anup Patel        2024-02-22  594  		goto fail_cleanup_contexts;

error code.

regards,
dan carpenter

b68d0ff529a939a Anup Patel        2024-02-22  595  
2234ae846ccb9eb Anup Patel        2020-05-18  596  	/*
e306a894bd51180 Samuel Holland    2024-05-29  597  	 * We can have multiple PLIC instances so setup global state
8ec99b033147ef3 Anup Patel        2024-02-22  598  	 * and register syscore operations only once after context
8ec99b033147ef3 Anup Patel        2024-02-22  599  	 * handlers of all online CPUs are initialized.
2234ae846ccb9eb Anup Patel        2020-05-18  600  	 */
e306a894bd51180 Samuel Holland    2024-05-29  601  	if (!plic_global_setup_done) {
e306a894bd51180 Samuel Holland    2024-05-29  602  		struct irq_domain *domain;
e306a894bd51180 Samuel Holland    2024-05-29  603  		bool global_setup = true;
e306a894bd51180 Samuel Holland    2024-05-29  604  
8ec99b033147ef3 Anup Patel        2024-02-22  605  		for_each_online_cpu(cpu) {
8ec99b033147ef3 Anup Patel        2024-02-22  606  			handler = per_cpu_ptr(&plic_handlers, cpu);
8ec99b033147ef3 Anup Patel        2024-02-22  607  			if (!handler->present) {
e306a894bd51180 Samuel Holland    2024-05-29  608  				global_setup = false;
8ec99b033147ef3 Anup Patel        2024-02-22  609  				break;
8ec99b033147ef3 Anup Patel        2024-02-22  610  			}
8ec99b033147ef3 Anup Patel        2024-02-22  611  		}
e306a894bd51180 Samuel Holland    2024-05-29  612  
e306a894bd51180 Samuel Holland    2024-05-29  613  		if (global_setup) {
e306a894bd51180 Samuel Holland    2024-05-29  614  			/* Find parent domain and register chained handler */
e306a894bd51180 Samuel Holland    2024-05-29  615  			domain = irq_find_matching_fwnode(riscv_get_intc_hwnode(), DOMAIN_BUS_ANY);
e306a894bd51180 Samuel Holland    2024-05-29  616  			if (domain)
e306a894bd51180 Samuel Holland    2024-05-29  617  				plic_parent_irq = irq_create_mapping(domain, RV_IRQ_EXT);
e306a894bd51180 Samuel Holland    2024-05-29  618  			if (plic_parent_irq)
e306a894bd51180 Samuel Holland    2024-05-29  619  				irq_set_chained_handler(plic_parent_irq, plic_handle_irq);
e306a894bd51180 Samuel Holland    2024-05-29  620  
ccbe80bad571c2f Atish Patra       2020-03-02  621  			cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
ccbe80bad571c2f Atish Patra       2020-03-02  622  					  "irqchip/sifive/plic:starting",
ccbe80bad571c2f Atish Patra       2020-03-02  623  					  plic_starting_cpu, plic_dying_cpu);
f99b926f6543fae Anup Patel        2023-10-25  624  			register_syscore_ops(&plic_irq_syscore_ops);
e306a894bd51180 Samuel Holland    2024-05-29  625  			plic_global_setup_done = true;
2234ae846ccb9eb Anup Patel        2020-05-18  626  		}
8ec99b033147ef3 Anup Patel        2024-02-22  627  	}
2234ae846ccb9eb Anup Patel        2020-05-18  628  
4d936f10ff80274 Anup Patel        2024-08-20  629  	pr_info("%pfwP: mapped %d interrupts with %d handlers for %d contexts.\n",
4d936f10ff80274 Anup Patel        2024-08-20  630  		fwnode, nr_irqs, nr_handlers, nr_contexts);
8237f8bc4f6eb7e Christoph Hellwig 2018-07-26  631  	return 0;
8237f8bc4f6eb7e Christoph Hellwig 2018-07-26  632  
a15587277a246c3 Anup Patel        2024-02-22  633  fail_cleanup_contexts:
a15587277a246c3 Anup Patel        2024-02-22  634  	for (i = 0; i < nr_contexts; i++) {
4d936f10ff80274 Anup Patel        2024-08-20  635  		if (plic_parse_context_parent(fwnode, i, &parent_hwirq, &cpu))
a15587277a246c3 Anup Patel        2024-02-22  636  			continue;
a15587277a246c3 Anup Patel        2024-02-22  637  		if (parent_hwirq != RV_IRQ_EXT || cpu < 0)
a15587277a246c3 Anup Patel        2024-02-22  638  			continue;
8237f8bc4f6eb7e Christoph Hellwig 2018-07-26  639  
a15587277a246c3 Anup Patel        2024-02-22  640  		handler = per_cpu_ptr(&plic_handlers, cpu);
a15587277a246c3 Anup Patel        2024-02-22  641  		handler->present = false;
a15587277a246c3 Anup Patel        2024-02-22  642  		handler->hart_base = NULL;
a15587277a246c3 Anup Patel        2024-02-22  643  		handler->enable_base = NULL;
4d936f10ff80274 Anup Patel        2024-08-20  644  		kfree(handler->enable_save);
a15587277a246c3 Anup Patel        2024-02-22  645  		handler->enable_save = NULL;
a15587277a246c3 Anup Patel        2024-02-22  646  		handler->priv = NULL;
dd46337ca69662b Lad Prabhakar     2022-06-30  647  	}
4d936f10ff80274 Anup Patel        2024-08-20  648  	bitmap_free(priv->prio_save);
4d936f10ff80274 Anup Patel        2024-08-20  649  fail_free_priv:
4d936f10ff80274 Anup Patel        2024-08-20  650  	kfree(priv);
4d936f10ff80274 Anup Patel        2024-08-20  651  fail_free_regs:
4d936f10ff80274 Anup Patel        2024-08-20  652  	iounmap(regs);
4d936f10ff80274 Anup Patel        2024-08-20  653  	return error;
4d936f10ff80274 Anup Patel        2024-08-20  654  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


