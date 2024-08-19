Return-Path: <linux-kernel+bounces-292948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7839576CC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 23:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFFA41C23B30
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 21:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5A915C15C;
	Mon, 19 Aug 2024 21:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ARenZIVE"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A293F9CC
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 21:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724104045; cv=none; b=KW2usd70l9DS9sPXGeE+2pvCklTVbeQFILOqeF5dzMrC5H1Y1k9+5s1+jxOb6GAaTqqA1kcYmT5CvCgomIx2opuSZZujnW+jsHGKneuq88ptXeIvOxXVfax5m/oBJupGjATKgURUWzOPoiXqaYMtustIKYpvlm21gXTRmio8O/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724104045; c=relaxed/simple;
	bh=Gyc2UrL1ENV59090R5zlnEmz6QEldc6C3EJMSOBaZLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmAbCRmm3zMiyOZdvvEHvRPEfgnGB9RNTrXXsgEHW5A/lqq04r+2mX+CqOjZkCP5cmcCBbR6ko27U1dsmtyCa/FlXs/9B2p1c3BWoKy4g2u8HXHkwqsfo0VtFTY5/x8dRC1buLANMIq3tYc0ZSHxd7xHK41G2kbogfJ4KVxYYXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ARenZIVE; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70d399da0b5so4107815b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 14:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724104042; x=1724708842; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YAIpKwWRKKlilWVBBY+nEUF6W52ydp0wp2I/YH4MPRg=;
        b=ARenZIVEpTK3HbnPXU7duC8fEuNrc050zY2wqIpHM6vpGJOdMfkFozAluekq+NoScR
         cdVj4nO3BlMP7erR+gOL3IyXiLsdv/7T8n89JAYzhgLGAYAHL8wSyQ6Z4FjIvUwun98w
         t3E0f7e7Slfdy3SMJv0PoLnZOqXAxvGiYkCWqEgXLCLa8WVIumc4/kq8Gl42HNm57V/S
         jF4RuQH+UFuRCBAvkxtl2axj1aNtsr9XtqXCuivfUWhkV56ZBFBlbdIklZFmCKrnUyka
         Mm13mk+naayBMwfnk3p47V34K9IxB3NlV+Z5e18ZCi5U2PhDov2TPzXzPQIgRvF+N9Cw
         ChyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724104042; x=1724708842;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YAIpKwWRKKlilWVBBY+nEUF6W52ydp0wp2I/YH4MPRg=;
        b=fALPmzz7xVR4Ylv8GkTwUCq8szo6p1qr33CI8+GYcLG6/1DJQ3NxHaNZyMIPVUBi/j
         YbFk07yR/LLh32JDYtZK1wWqgVlCNcgUcRiExQsHilEnYugoZlu2W3JuqipaeuMgqqmc
         VuGSmVueweLbMcKdv4GIuyn6X5LQS9je9DjEuFNAgFv/0dmWGv7AbvKqDSIdaq+mM+a+
         3yZ/F5VchCVbNZKeWUf2/6GBji7/C8mCPGrI8xs1gpeCM2TFQOWDtgNAH4xa+XwqGmd7
         41yUgvwc9vHKI45zhuLWmJfaShQQxhLsX4q6qPnDlh1qAsHU1UPezPMqpAdx8ExXhidD
         L2PQ==
X-Forwarded-Encrypted: i=1; AJvYcCWF6NTaxsJ52S8wPn9mOeeKr+Px97GWJ9ogjZzPdF97XrPyurWzZkd0Aq7RUlVwwBXjqm7jI7cMiYVIe0aY3pNTJ1S0Tlb2sEDx9lNZ
X-Gm-Message-State: AOJu0Yz6VW93F89sHQU/Wiyc/vJZa6MP1cRo33JBxU9x27+3rnwTK4vT
	CgTeVgMFFftYgu9iFlHE54ejz+9r3UBvL7RWStAFqnwcWOEeotnwVXk8yjUB6T0=
X-Google-Smtp-Source: AGHT+IGhe40HZJYU3TXvbpXci7yynru6I/nJh1BQm9O/6IPDEaLrJH/3SG9nDoUD2mtPbVkSMh7q6Q==
X-Received: by 2002:a05:6a20:3141:b0:1ca:31dd:6a0e with SMTP id adf61e73a8af0-1ca31dd6b29mr10845204637.1.1724104041872;
        Mon, 19 Aug 2024 14:47:21 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af416fbsm6999741b3a.207.2024.08.19.14.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 14:47:21 -0700 (PDT)
Date: Mon, 19 Aug 2024 14:47:18 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anup Patel <anup@brainfault.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Atish Patra <atishp@atishpatra.org>,
	linux-riscv@lists.infradead.org,
	Andrew Jones <ajones@ventanamicro.com>
Subject: Re: [PATCH v2] irqchip/sifive-plic: Probe plic driver early for
 Allwinner D1 platform
Message-ID: <ZsO9ZmNXa3uvzctr@ghost>
References: <20240817081218.2985171-1-apatel@ventanamicro.com>
 <CAJM55Z9_7WsqXT5hNuwB9jt31Aayk3kqOV5FDZ9tdcLYhwHTFg@mail.gmail.com>
 <CAK9=C2UbaPgjH8WuHyCvVUoR+AeXu8TD9+QUFOvCV+L9jTJfOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK9=C2UbaPgjH8WuHyCvVUoR+AeXu8TD9+QUFOvCV+L9jTJfOw@mail.gmail.com>

On Mon, Aug 19, 2024 at 08:27:33PM +0530, Anup Patel wrote:
> On Mon, Aug 19, 2024 at 12:27 PM Emil Renner Berthing
> <emil.renner.berthing@canonical.com> wrote:
> >
> > Anup Patel wrote:
> > > The latest Linux RISC-V no longer boots on the Allwinner D1 platform
> > > because the sun4i_timer driver fails to get an interrupt from PLIC.
> > >
> > > The real fix requires enabling the SBI time extension in the platform
> > > firmware (OpenSBI) and convert sun4i_timer into platform driver.
> > > Unfortunately, the real fix involves changing multiple places and
> > > can't be achieved in a short duration.
> > >
> > > As a work-around, retrofit plic probing such that plic is probed
> > > early only for the Allwinner D1 platform and probed as a regular
> > > platform driver for rest of the RISC-V platforms. In the process,
> > > partially revert some of the previous patches because PLIC device
> > > pointer is not available in all probing paths.
> > >
> > > More detailed discussion can found here:
> > > https://lore.kernel.org/lkml/20240814145642.344485-1-emil.renner.berthing@canonical.com/
> > >
> > > Fixes: e306a894bd51 ("irqchip/sifive-plic: Chain to parent IRQ after handlers are ready")
> > > Fixes: 8ec99b033147 ("irqchip/sifive-plic: Convert PLIC driver into a platform driver")
> > > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> > > Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> > > Tested-by: Samuel Holland <samuel.holland@sifive.com>
> > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > > ---
> > > Changes since v1:
> > >  - Set suppress_bind_attrs for PLIC platform driver
> > > ---
> > >  drivers/irqchip/irq-sifive-plic.c | 128 +++++++++++++++++++-----------
> > >  1 file changed, 80 insertions(+), 48 deletions(-)
> > >
> > > diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> > > index 9e22f7e378f5..33395c5a9b5b 100644
> > > --- a/drivers/irqchip/irq-sifive-plic.c
> > > +++ b/drivers/irqchip/irq-sifive-plic.c
> > > @@ -3,6 +3,7 @@
> > >   * Copyright (C) 2017 SiFive
> > >   * Copyright (C) 2018 Christoph Hellwig
> > >   */
> > > +#define pr_fmt(fmt) "riscv-plic: " fmt
> > >  #include <linux/cpu.h>
> > >  #include <linux/interrupt.h>
> > >  #include <linux/io.h>
> > > @@ -63,7 +64,7 @@
> > >  #define PLIC_QUIRK_EDGE_INTERRUPT    0
> > >
> > >  struct plic_priv {
> > > -     struct device *dev;
> > > +     struct fwnode_handle *fwnode;
> > >       struct cpumask lmask;
> > >       struct irq_domain *irqdomain;
> > >       void __iomem *regs;
> > > @@ -378,8 +379,8 @@ static void plic_handle_irq(struct irq_desc *desc)
> > >               int err = generic_handle_domain_irq(handler->priv->irqdomain,
> > >                                                   hwirq);
> > >               if (unlikely(err)) {
> > > -                     dev_warn_ratelimited(handler->priv->dev,
> > > -                                          "can't find mapping for hwirq %lu\n", hwirq);
> > > +                     pr_warn_ratelimited("%pfwP: can't find mapping for hwirq %lu\n",
> > > +                                         handler->priv->fwnode, hwirq);
> > >               }
> > >       }
> > >
> > > @@ -408,15 +409,14 @@ static int plic_starting_cpu(unsigned int cpu)
> > >               enable_percpu_irq(plic_parent_irq,
> > >                                 irq_get_trigger_type(plic_parent_irq));
> > >       else
> > > -             dev_warn(handler->priv->dev, "cpu%d: parent irq not available\n", cpu);
> > > +             pr_warn("%pfwP: cpu%d: parent irq not available\n",
> > > +                     handler->priv->fwnode, cpu);
> > >       plic_set_threshold(handler, PLIC_ENABLE_THRESHOLD);
> > >
> > >       return 0;
> > >  }
> > >
> > > -static const struct of_device_id plic_match[] = {
> > > -     { .compatible = "sifive,plic-1.0.0" },
> > > -     { .compatible = "riscv,plic0" },
> > > +static const struct of_device_id plic_quirks_match[] = {
> > >       { .compatible = "andestech,nceplic100",
> > >         .data = (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
> > >       { .compatible = "thead,c900-plic",
> > > @@ -424,38 +424,36 @@ static const struct of_device_id plic_match[] = {
> > >       {}
> > >  };
> > >
> > > -static int plic_parse_nr_irqs_and_contexts(struct platform_device *pdev,
> > > +static int plic_parse_nr_irqs_and_contexts(struct fwnode_handle *fwnode,
> > >                                          u32 *nr_irqs, u32 *nr_contexts)
> > >  {
> > > -     struct device *dev = &pdev->dev;
> > >       int rc;
> > >
> > >       /*
> > >        * Currently, only OF fwnode is supported so extend this
> > >        * function for ACPI support.
> > >        */
> > > -     if (!is_of_node(dev->fwnode))
> > > +     if (!is_of_node(fwnode))
> > >               return -EINVAL;
> > >
> > > -     rc = of_property_read_u32(to_of_node(dev->fwnode), "riscv,ndev", nr_irqs);
> > > +     rc = of_property_read_u32(to_of_node(fwnode), "riscv,ndev", nr_irqs);
> > >       if (rc) {
> > > -             dev_err(dev, "riscv,ndev property not available\n");
> > > +             pr_err("%pfwP: riscv,ndev property not available\n", fwnode);
> > >               return rc;
> > >       }
> > >
> > > -     *nr_contexts = of_irq_count(to_of_node(dev->fwnode));
> > > +     *nr_contexts = of_irq_count(to_of_node(fwnode));
> > >       if (WARN_ON(!(*nr_contexts))) {
> > > -             dev_err(dev, "no PLIC context available\n");
> > > +             pr_err("%pfwP: no PLIC context available\n", fwnode);
> > >               return -EINVAL;
> > >       }
> > >
> > >       return 0;
> > >  }
> > >
> > > -static int plic_parse_context_parent(struct platform_device *pdev, u32 context,
> > > +static int plic_parse_context_parent(struct fwnode_handle *fwnode, u32 context,
> > >                                    u32 *parent_hwirq, int *parent_cpu)
> > >  {
> > > -     struct device *dev = &pdev->dev;
> > >       struct of_phandle_args parent;
> > >       unsigned long hartid;
> > >       int rc;
> > > @@ -464,10 +462,10 @@ static int plic_parse_context_parent(struct platform_device *pdev, u32 context,
> > >        * Currently, only OF fwnode is supported so extend this
> > >        * function for ACPI support.
> > >        */
> > > -     if (!is_of_node(dev->fwnode))
> > > +     if (!is_of_node(fwnode))
> > >               return -EINVAL;
> > >
> > > -     rc = of_irq_parse_one(to_of_node(dev->fwnode), context, &parent);
> > > +     rc = of_irq_parse_one(to_of_node(fwnode), context, &parent);
> > >       if (rc)
> > >               return rc;
> > >
> > > @@ -480,48 +478,55 @@ static int plic_parse_context_parent(struct platform_device *pdev, u32 context,
> > >       return 0;
> > >  }
> > >
> > > -static int plic_probe(struct platform_device *pdev)
> > > +static int plic_probe(struct fwnode_handle *fwnode)
> > >  {
> > >       int error = 0, nr_contexts, nr_handlers = 0, cpu, i;
> > > -     struct device *dev = &pdev->dev;
> > >       unsigned long plic_quirks = 0;
> > >       struct plic_handler *handler;
> > >       u32 nr_irqs, parent_hwirq;
> > >       struct plic_priv *priv;
> > >       irq_hw_number_t hwirq;
> > > +     void __iomem *regs;
> > >
> > > -     if (is_of_node(dev->fwnode)) {
> > > +     if (is_of_node(fwnode)) {
> > >               const struct of_device_id *id;
> > >
> > > -             id = of_match_node(plic_match, to_of_node(dev->fwnode));
> > > +             id = of_match_node(plic_quirks_match, to_of_node(fwnode));
> > >               if (id)
> > >                       plic_quirks = (unsigned long)id->data;
> > > +
> > > +             regs = of_iomap(to_of_node(fwnode), 0);
> > > +             if (!regs)
> > > +                     return -ENOMEM;
> > > +     } else {
> > > +             return -ENODEV;
> >
> > This driver never worked with ACPI anyways?
> >
> > >       }
> > >
> > > -     error = plic_parse_nr_irqs_and_contexts(pdev, &nr_irqs, &nr_contexts);
> > > +     error = plic_parse_nr_irqs_and_contexts(fwnode, &nr_irqs, &nr_contexts);
> > >       if (error)
> > > -             return error;
> > > +             goto fail_free_regs;
> > >
> > > -     priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > > -     if (!priv)
> > > -             return -ENOMEM;
> > > +     priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> > > +     if (!priv) {
> > > +             error = -ENOMEM;
> > > +             goto fail_free_regs;
> > > +     }
> > >
> > > -     priv->dev = dev;
> > > +     priv->fwnode = fwnode;
> > >       priv->plic_quirks = plic_quirks;
> > >       priv->nr_irqs = nr_irqs;
> > > +     priv->regs = regs;
> > >
> > > -     priv->regs = devm_platform_ioremap_resource(pdev, 0);
> > > -     if (WARN_ON(!priv->regs))
> > > -             return -EIO;
> > > -
> > > -     priv->prio_save = devm_bitmap_zalloc(dev, nr_irqs, GFP_KERNEL);
> > > -     if (!priv->prio_save)
> > > -             return -ENOMEM;
> > > +     priv->prio_save = bitmap_zalloc(nr_irqs, GFP_KERNEL);
> > > +     if (!priv->prio_save) {
> > > +             error = -ENOMEM;
> > > +             goto fail_free_priv;
> > > +     }
> > >
> > >       for (i = 0; i < nr_contexts; i++) {
> > > -             error = plic_parse_context_parent(pdev, i, &parent_hwirq, &cpu);
> > > +             error = plic_parse_context_parent(fwnode, i, &parent_hwirq, &cpu);
> > >               if (error) {
> > > -                     dev_warn(dev, "hwirq for context%d not found\n", i);
> > > +                     pr_warn("%pfwP: hwirq for context%d not found\n", fwnode, i);
> > >                       continue;
> > >               }
> > >
> > > @@ -543,7 +548,7 @@ static int plic_probe(struct platform_device *pdev)
> > >               }
> > >
> > >               if (cpu < 0) {
> > > -                     dev_warn(dev, "Invalid cpuid for context %d\n", i);
> > > +                     pr_warn("%pfwP: Invalid cpuid for context %d\n", fwnode, i);
> > >                       continue;
> > >               }
> > >
> > > @@ -554,7 +559,7 @@ static int plic_probe(struct platform_device *pdev)
> > >                */
> > >               handler = per_cpu_ptr(&plic_handlers, cpu);
> > >               if (handler->present) {
> > > -                     dev_warn(dev, "handler already present for context %d.\n", i);
> > > +                     pr_warn("%pfwP: handler already present for context %d.\n", fwnode, i);
> > >                       plic_set_threshold(handler, PLIC_DISABLE_THRESHOLD);
> > >                       goto done;
> > >               }
> > > @@ -568,8 +573,8 @@ static int plic_probe(struct platform_device *pdev)
> > >                       i * CONTEXT_ENABLE_SIZE;
> > >               handler->priv = priv;
> > >
> > > -             handler->enable_save = devm_kcalloc(dev, DIV_ROUND_UP(nr_irqs, 32),
> > > -                                                 sizeof(*handler->enable_save), GFP_KERNEL);
> > > +             handler->enable_save = kcalloc(DIV_ROUND_UP(nr_irqs, 32),
> > > +                                            sizeof(*handler->enable_save), GFP_KERNEL);
> > >               if (!handler->enable_save)
> > >                       goto fail_cleanup_contexts;
> > >  done:
> > > @@ -581,7 +586,7 @@ static int plic_probe(struct platform_device *pdev)
> > >               nr_handlers++;
> > >       }
> > >
> > > -     priv->irqdomain = irq_domain_add_linear(to_of_node(dev->fwnode), nr_irqs + 1,
> > > +     priv->irqdomain = irq_domain_add_linear(to_of_node(fwnode), nr_irqs + 1,
> > >                                               &plic_irqdomain_ops, priv);
> > >       if (WARN_ON(!priv->irqdomain))
> > >               goto fail_cleanup_contexts;
> > > @@ -619,13 +624,13 @@ static int plic_probe(struct platform_device *pdev)
> > >               }
> > >       }
> > >
> > > -     dev_info(dev, "mapped %d interrupts with %d handlers for %d contexts.\n",
> > > -              nr_irqs, nr_handlers, nr_contexts);
> > > +     pr_info("%pfwP: mapped %d interrupts with %d handlers for %d contexts.\n",
> > > +             fwnode, nr_irqs, nr_handlers, nr_contexts);
> > >       return 0;
> > >
> > >  fail_cleanup_contexts:
> > >       for (i = 0; i < nr_contexts; i++) {
> > > -             if (plic_parse_context_parent(pdev, i, &parent_hwirq, &cpu))
> > > +             if (plic_parse_context_parent(fwnode, i, &parent_hwirq, &cpu))
> > >                       continue;
> > >               if (parent_hwirq != RV_IRQ_EXT || cpu < 0)
> > >                       continue;
> > > @@ -634,17 +639,44 @@ static int plic_probe(struct platform_device *pdev)
> > >               handler->present = false;
> > >               handler->hart_base = NULL;
> > >               handler->enable_base = NULL;
> > > +             kfree(handler->enable_save);
> > >               handler->enable_save = NULL;
> > >               handler->priv = NULL;
> > >       }
> > > -     return -ENOMEM;
> > > +     bitmap_free(priv->prio_save);
> > > +fail_free_priv:
> > > +     kfree(priv);
> > > +fail_free_regs:
> > > +     iounmap(regs);
> > > +     return error;
> > > +}
> > > +
> > > +static int plic_platform_probe(struct platform_device *pdev)
> > > +{
> > > +     return plic_probe(pdev->dev.fwnode);
> > >  }
> > >
> > > +static const struct of_device_id plic_platform_match[] = {
> > > +     { .compatible = "sifive,plic-1.0.0" },
> > > +     { .compatible = "riscv,plic0" },
> > > +     { .compatible = "andestech,nceplic100" },
> > > +     {}
> > > +};
> > > +
> > >  static struct platform_driver plic_driver = {
> > >       .driver = {
> > >               .name           = "riscv-plic",
> > > -             .of_match_table = plic_match,
> > > +             .of_match_table = plic_platform_match,
> > > +             .suppress_bind_attrs = true,
> > >       },
> > > -     .probe = plic_probe,
> > > +     .probe = plic_platform_probe,
> > >  };
> > >  builtin_platform_driver(plic_driver);
> > > +
> > > +static int __init plic_early_probe(struct device_node *node,
> > > +                                struct device_node *parent)
> > > +{
> > > +     return plic_probe(&node->fwnode);
> > > +}
> > > +
> > > +IRQCHIP_DECLARE(riscv, "thead,c900-plic", plic_early_probe);
> >
> > If this is only needed on the Allwinner D1 maybe this should only match the
> > more specific "allwinner,sun20i-d1-plic"?
> >
> > In any case this works by itself, but not with Samuel's patch[1] applied, so
> > Tested-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> >
> > [1]: https://lore.kernel.org/r/20240312192519.1602493-1-samuel.holland@sifive.com
> 
> Thanks for testing.
> 
> Can you confirm that using "allwinner,sun20i-d1-plic" for early
> probe works on the Allwinner D1 board ? If yes, the I will quickly
> send a v3.

I can confirm that this patch works as-is, and with
"allwinner,sun20i-d1-plic" for early probe on the Allwiner D1 board.
Thank you for this fix Anup!

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Tested-by: Charlie Jenkins <charlie@rivosinc.com>

> 
> Regards,
> Anup
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

