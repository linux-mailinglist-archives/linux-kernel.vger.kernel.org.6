Return-Path: <linux-kernel+bounces-290617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E404955657
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 10:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28DD81C210A2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 08:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761451422C7;
	Sat, 17 Aug 2024 08:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ZB4+pskd"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1466378C7D
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 08:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723882215; cv=none; b=CH8FgnsLKHWCIMAU/frjX94DR5JNpV6uq4VDDxk49J9sA7U6ntOlGVUeHPsi/r5WYw87+sN75uYOHz+nhfiSYXQlfODMiR8ZRS0TDs69zMqiukr7YP11L1ZKqbwXdQyS7hr6al3ly/hsJkVYkDuCRY76YiF3lqG4cc70vWV0Fuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723882215; c=relaxed/simple;
	bh=Vnd5fw2Bbw50bRAsytjM5ixPFCI24Uf8RbRR4T5s71Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c4eUzt+1KXk5vavqIV1qjjhy9Ss/JApc2VroZthchf7YbnEwsZgE0vpEHSyQ96Dzbk8Kh9EBg2CMAz5t/r2O0a8sKnT2LZOzDi/JSobrvjqsq59aGumA9T9qo1GArdVQmVRnwaLVF0yBTJAqih0BjiTHTMMMAMRhMNvhKgXrL2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ZB4+pskd; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52f04150796so3212807e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 01:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723882211; x=1724487011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wte9xBirS0BpajfuB/jFzBpMKXPbC5jTT6wNLB8eq78=;
        b=ZB4+pskdTj02P1OU/Ef+4oZsI/lUAqnyj4zsW9zH0FiFxR5Ll/b+XWbpwUZdD9YMI2
         hliOMCnpDmZbgC82mlsRCACperSuz39os/BT1P8nZFPCb4SNRdQWth8sgQpK4GK2YqY2
         R0REBs+J69pjdY/1+dw3kvPIHvYiR677u1dOT5k2JDdxIBPOpSZjpm7I0SLoPuNrT2PO
         KMvajpwHUzmVDolroe9UaCV+JOswNPwoeGPlUc+3cuZOgP+CpcR1+sAAuwoyopVBWXth
         SbFjcU4+rCX3cSXIiGPShFOkoWWcZBxUannMvdG4Ty9O76285zF1Zj84dh5+M0ilij9O
         fEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723882211; x=1724487011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wte9xBirS0BpajfuB/jFzBpMKXPbC5jTT6wNLB8eq78=;
        b=IsqGFHhUFEo5wzJPqcxZ8fj6XwIy3r9GqwFiTITJQVl3pIvl6fklUhpncCkvbYSKth
         Yly6IiXHul0SC1elzCqsCxyUPdy03rrC4ljlm52XtSWsRxQXyj2jMZyAzPkGWjpahffX
         XmwSPpfRQ9cuXCRVcxz5BSyiZp5pmizdgpo4wZXLul7dpx8/gIDtLEa/pBLx8+c6QJKB
         B6N8bDfgcyPDzzCS9F3pRzGYUsW1FKpUt/QbuUNNOCr+07nJhhse9xJbdN77Bd8DDdDy
         BY5Nsh4R+GaOEhH3eAOQLOwGROfpazKfOOHW3WfK6V3TSpNvdzHe3EvpurSSCxZ7XArV
         Yk4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUkG48TyI0hfg4Lbjv4TP5q0aMCsRdkziGn2/d7bMZXm9F2L0ktosb5hZVNv9zXyh1drLYaRPLj/Xa9kUmrtHTk51SkU5DkdXpPQdyd
X-Gm-Message-State: AOJu0YzneVY7jSDWbGA+Wgm/HAE91zDRkosYLXON22PQOWBt9HdoPgZi
	TP+YQqB8bMUWXcq83cZeXsWT3pg/Np/rd9D9oD+T7gdDQw68YlxZ8hXfIcFeiZv5J032EImNtNY
	H2ddD1M3PS3DIHfqEd+GyFH2CmPNxKich6OnoONN3Htv7OvPSGEwfkA==
X-Google-Smtp-Source: AGHT+IGVIbz7zcIzouhxIU1rOKsCuhu6okcCA9Iu62QCwg8Cl+dquW/3CqqFNfLCcG0OYGAnxdlFjQz+yH6OkDilRfo=
X-Received: by 2002:a05:6512:3e23:b0:52c:dfa2:5ac1 with SMTP id
 2adb3069b0e04-5331c6b0122mr2963186e87.24.1723882210438; Sat, 17 Aug 2024
 01:10:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816161828.2979143-1-apatel@ventanamicro.com> <a13e8ddc-20d2-4d4d-8975-4352c38bbe69@sifive.com>
In-Reply-To: <a13e8ddc-20d2-4d4d-8975-4352c38bbe69@sifive.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Sat, 17 Aug 2024 13:39:58 +0530
Message-ID: <CAK9=C2VKwr0-+4txZhJKOZARvEOMgQ1cE5BZnaa9Km60gbxWyg@mail.gmail.com>
Subject: Re: [PATCH] irqchip/sifive-plic: Probe plic driver early for
 Allwinner D1 platform
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Atish Patra <atishp@atishpatra.org>, 
	Andrew Jones <ajones@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, Anup Patel <anup@brainfault.org>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 10:13=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> Hi Anup,
>
> On 2024-08-16 11:18 AM, Anup Patel wrote:
> > The latest Linux RISC-V no longer boots on the Allwinner D1 platform
> > because the sun4i_timer driver fails to get an interrupt from PLIC.
> >
> > The real fix requires enabling the SBI time extension in the platform
> > firmware (OpenSBI) and convert sun4i_timer into platform driver.
> > Unfortunately, the real fix involves changing multiple places and
> > can't be achieved in a short duration.
> >
> > As a work-around, retrofit plic probing such that plic is probed
> > early only for the Allwinner D1 platform and probed as a regular
> > platform driver for rest of the RISC-V platforms. In the process,
> > partially revert some of the previous patches because PLIC device
> > pointer is not available in all probing paths.
> >
> > More detailed discussion can found here:
> > https://lore.kernel.org/lkml/20240814145642.344485-1-emil.renner.berthi=
ng@canonical.com/
> >
> > Fixes: e306a894bd51 ("irqchip/sifive-plic: Chain to parent IRQ after ha=
ndlers are ready")
> > Fixes: 8ec99b033147 ("irqchip/sifive-plic: Convert PLIC driver into a p=
latform driver")
> > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  drivers/irqchip/irq-sifive-plic.c | 128 +++++++++++++++++++-----------
> >  1 file changed, 80 insertions(+), 48 deletions(-)
>
> Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> Tested-by: Samuel Holland <samuel.holland@sifive.com>
>
> v6.11-rc3 + this patch boots on D1 without CLINT in the devicetree:
>
> [    0.000000][    T0] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
> [    0.000000][    T0] riscv-intc: 64 local interrupts mapped
> [    0.000000][    T0] riscv-plic: interrupt-controller@10000000: mapped =
175 interrupts with 1 handlers for 2 contexts.
> [    0.000000][    T0] rcu: srcu_init: Setting srcu_struct sizes based on=
 contention.
> [    0.000000][    T0] clocksource: timer: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 79635851949 ns
> [    0.000000][    T0] clocksource: riscv_clocksource: mask: 0xffffffffff=
ffffff max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
> [    0.000001][    T0] sched_clock: 64 bits at 24MHz, resolution 41ns, wr=
aps every 4398046511097ns
> [    0.009362][    T0] Calibrating delay loop (skipped), value calculated=
 using timer frequency.. 48.00 BogoMIPS (lpj=3D96000)
>
> > diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-si=
five-plic.c
> > index 9e22f7e378f5..357d25662718 100644
> > --- a/drivers/irqchip/irq-sifive-plic.c
> > +++ b/drivers/irqchip/irq-sifive-plic.c
> > @@ -3,6 +3,7 @@
> >   * Copyright (C) 2017 SiFive
> >   * Copyright (C) 2018 Christoph Hellwig
> >   */
> > +#define pr_fmt(fmt) "riscv-plic: " fmt
> >  #include <linux/cpu.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/io.h>
> > @@ -63,7 +64,7 @@
> >  #define PLIC_QUIRK_EDGE_INTERRUPT    0
> >
> >  struct plic_priv {
> > -     struct device *dev;
> > +     struct fwnode_handle *fwnode;
> >       struct cpumask lmask;
> >       struct irq_domain *irqdomain;
> >       void __iomem *regs;
> > @@ -378,8 +379,8 @@ static void plic_handle_irq(struct irq_desc *desc)
> >               int err =3D generic_handle_domain_irq(handler->priv->irqd=
omain,
> >                                                   hwirq);
> >               if (unlikely(err)) {
> > -                     dev_warn_ratelimited(handler->priv->dev,
> > -                                          "can't find mapping for hwir=
q %lu\n", hwirq);
> > +                     pr_warn_ratelimited("%pfwP: can't find mapping fo=
r hwirq %lu\n",
> > +                                         handler->priv->fwnode, hwirq)=
;
> >               }
> >       }
> >
> > @@ -408,15 +409,14 @@ static int plic_starting_cpu(unsigned int cpu)
> >               enable_percpu_irq(plic_parent_irq,
> >                                 irq_get_trigger_type(plic_parent_irq));
> >       else
> > -             dev_warn(handler->priv->dev, "cpu%d: parent irq not avail=
able\n", cpu);
> > +             pr_warn("%pfwP: cpu%d: parent irq not available\n",
> > +                     handler->priv->fwnode, cpu);
> >       plic_set_threshold(handler, PLIC_ENABLE_THRESHOLD);
> >
> >       return 0;
> >  }
> >
> > -static const struct of_device_id plic_match[] =3D {
> > -     { .compatible =3D "sifive,plic-1.0.0" },
> > -     { .compatible =3D "riscv,plic0" },
> > +static const struct of_device_id plic_quirks_match[] =3D {
> >       { .compatible =3D "andestech,nceplic100",
> >         .data =3D (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
> >       { .compatible =3D "thead,c900-plic",
> > @@ -424,38 +424,36 @@ static const struct of_device_id plic_match[] =3D=
 {
> >       {}
> >  };
> >
> > -static int plic_parse_nr_irqs_and_contexts(struct platform_device *pde=
v,
> > +static int plic_parse_nr_irqs_and_contexts(struct fwnode_handle *fwnod=
e,
> >                                          u32 *nr_irqs, u32 *nr_contexts=
)
> >  {
> > -     struct device *dev =3D &pdev->dev;
> >       int rc;
> >
> >       /*
> >        * Currently, only OF fwnode is supported so extend this
> >        * function for ACPI support.
> >        */
> > -     if (!is_of_node(dev->fwnode))
> > +     if (!is_of_node(fwnode))
> >               return -EINVAL;
> >
> > -     rc =3D of_property_read_u32(to_of_node(dev->fwnode), "riscv,ndev"=
, nr_irqs);
> > +     rc =3D of_property_read_u32(to_of_node(fwnode), "riscv,ndev", nr_=
irqs);
> >       if (rc) {
> > -             dev_err(dev, "riscv,ndev property not available\n");
> > +             pr_err("%pfwP: riscv,ndev property not available\n", fwno=
de);
> >               return rc;
> >       }
> >
> > -     *nr_contexts =3D of_irq_count(to_of_node(dev->fwnode));
> > +     *nr_contexts =3D of_irq_count(to_of_node(fwnode));
> >       if (WARN_ON(!(*nr_contexts))) {
> > -             dev_err(dev, "no PLIC context available\n");
> > +             pr_err("%pfwP: no PLIC context available\n", fwnode);
> >               return -EINVAL;
> >       }
> >
> >       return 0;
> >  }
> >
> > -static int plic_parse_context_parent(struct platform_device *pdev, u32=
 context,
> > +static int plic_parse_context_parent(struct fwnode_handle *fwnode, u32=
 context,
> >                                    u32 *parent_hwirq, int *parent_cpu)
> >  {
> > -     struct device *dev =3D &pdev->dev;
> >       struct of_phandle_args parent;
> >       unsigned long hartid;
> >       int rc;
> > @@ -464,10 +462,10 @@ static int plic_parse_context_parent(struct platf=
orm_device *pdev, u32 context,
> >        * Currently, only OF fwnode is supported so extend this
> >        * function for ACPI support.
> >        */
> > -     if (!is_of_node(dev->fwnode))
> > +     if (!is_of_node(fwnode))
> >               return -EINVAL;
> >
> > -     rc =3D of_irq_parse_one(to_of_node(dev->fwnode), context, &parent=
);
> > +     rc =3D of_irq_parse_one(to_of_node(fwnode), context, &parent);
> >       if (rc)
> >               return rc;
> >
> > @@ -480,48 +478,55 @@ static int plic_parse_context_parent(struct platf=
orm_device *pdev, u32 context,
> >       return 0;
> >  }
> >
> > -static int plic_probe(struct platform_device *pdev)
> > +static int plic_probe(struct fwnode_handle *fwnode)
> >  {
> >       int error =3D 0, nr_contexts, nr_handlers =3D 0, cpu, i;
> > -     struct device *dev =3D &pdev->dev;
> >       unsigned long plic_quirks =3D 0;
> >       struct plic_handler *handler;
> >       u32 nr_irqs, parent_hwirq;
> >       struct plic_priv *priv;
> >       irq_hw_number_t hwirq;
> > +     void __iomem *regs;
> >
> > -     if (is_of_node(dev->fwnode)) {
> > +     if (is_of_node(fwnode)) {
> >               const struct of_device_id *id;
> >
> > -             id =3D of_match_node(plic_match, to_of_node(dev->fwnode))=
;
> > +             id =3D of_match_node(plic_quirks_match, to_of_node(fwnode=
));
> >               if (id)
> >                       plic_quirks =3D (unsigned long)id->data;
> > +
> > +             regs =3D of_iomap(to_of_node(fwnode), 0);
> > +             if (!regs)
> > +                     return -ENOMEM;
> > +     } else {
> > +             return -ENODEV;
> >       }
> >
> > -     error =3D plic_parse_nr_irqs_and_contexts(pdev, &nr_irqs, &nr_con=
texts);
> > +     error =3D plic_parse_nr_irqs_and_contexts(fwnode, &nr_irqs, &nr_c=
ontexts);
> >       if (error)
> > -             return error;
> > +             goto fail_free_regs;
> >
> > -     priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > -     if (!priv)
> > -             return -ENOMEM;
> > +     priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
> > +     if (!priv) {
> > +             error =3D -ENOMEM;
> > +             goto fail_free_regs;
> > +     }
> >
> > -     priv->dev =3D dev;
> > +     priv->fwnode =3D fwnode;
> >       priv->plic_quirks =3D plic_quirks;
> >       priv->nr_irqs =3D nr_irqs;
> > +     priv->regs =3D regs;
> >
> > -     priv->regs =3D devm_platform_ioremap_resource(pdev, 0);
> > -     if (WARN_ON(!priv->regs))
> > -             return -EIO;
> > -
> > -     priv->prio_save =3D devm_bitmap_zalloc(dev, nr_irqs, GFP_KERNEL);
> > -     if (!priv->prio_save)
> > -             return -ENOMEM;
> > +     priv->prio_save =3D bitmap_zalloc(nr_irqs, GFP_KERNEL);
> > +     if (!priv->prio_save) {
> > +             error =3D -ENOMEM;
> > +             goto fail_free_priv;
> > +     }
> >
> >       for (i =3D 0; i < nr_contexts; i++) {
> > -             error =3D plic_parse_context_parent(pdev, i, &parent_hwir=
q, &cpu);
> > +             error =3D plic_parse_context_parent(fwnode, i, &parent_hw=
irq, &cpu);
> >               if (error) {
> > -                     dev_warn(dev, "hwirq for context%d not found\n", =
i);
> > +                     pr_warn("%pfwP: hwirq for context%d not found\n",=
 fwnode, i);
> >                       continue;
> >               }
> >
> > @@ -543,7 +548,7 @@ static int plic_probe(struct platform_device *pdev)
> >               }
> >
> >               if (cpu < 0) {
> > -                     dev_warn(dev, "Invalid cpuid for context %d\n", i=
);
> > +                     pr_warn("%pfwP: Invalid cpuid for context %d\n", =
fwnode, i);
> >                       continue;
> >               }
> >
> > @@ -554,7 +559,8 @@ static int plic_probe(struct platform_device *pdev)
> >                */
> >               handler =3D per_cpu_ptr(&plic_handlers, cpu);
> >               if (handler->present) {
> > -                     dev_warn(dev, "handler already present for contex=
t %d.\n", i);
> > +                     pr_warn("%pfwP: handler already present for conte=
xt %d.\n",
> > +                             fwnode, i);
> >                       plic_set_threshold(handler, PLIC_DISABLE_THRESHOL=
D);
> >                       goto done;
> >               }
> > @@ -568,8 +574,8 @@ static int plic_probe(struct platform_device *pdev)
> >                       i * CONTEXT_ENABLE_SIZE;
> >               handler->priv =3D priv;
> >
> > -             handler->enable_save =3D devm_kcalloc(dev, DIV_ROUND_UP(n=
r_irqs, 32),
> > -                                                 sizeof(*handler->enab=
le_save), GFP_KERNEL);
> > +             handler->enable_save =3D kcalloc(DIV_ROUND_UP(nr_irqs, 32=
),
> > +                                            sizeof(*handler->enable_sa=
ve), GFP_KERNEL);
> >               if (!handler->enable_save)
> >                       goto fail_cleanup_contexts;
> >  done:
> > @@ -581,7 +587,7 @@ static int plic_probe(struct platform_device *pdev)
> >               nr_handlers++;
> >       }
> >
> > -     priv->irqdomain =3D irq_domain_add_linear(to_of_node(dev->fwnode)=
, nr_irqs + 1,
> > +     priv->irqdomain =3D irq_domain_add_linear(to_of_node(fwnode), nr_=
irqs + 1,
> >                                               &plic_irqdomain_ops, priv=
);
> >       if (WARN_ON(!priv->irqdomain))
> >               goto fail_cleanup_contexts;
> > @@ -619,13 +625,13 @@ static int plic_probe(struct platform_device *pde=
v)
> >               }
> >       }
> >
> > -     dev_info(dev, "mapped %d interrupts with %d handlers for %d conte=
xts.\n",
> > -              nr_irqs, nr_handlers, nr_contexts);
> > +     pr_info("%pfwP: mapped %d interrupts with %d handlers for %d cont=
exts.\n",
> > +             fwnode, nr_irqs, nr_handlers, nr_contexts);
> >       return 0;
> >
> >  fail_cleanup_contexts:
> >       for (i =3D 0; i < nr_contexts; i++) {
> > -             if (plic_parse_context_parent(pdev, i, &parent_hwirq, &cp=
u))
> > +             if (plic_parse_context_parent(fwnode, i, &parent_hwirq, &=
cpu))
> >                       continue;
> >               if (parent_hwirq !=3D RV_IRQ_EXT || cpu < 0)
> >                       continue;
> > @@ -634,17 +640,43 @@ static int plic_probe(struct platform_device *pde=
v)
> >               handler->present =3D false;
> >               handler->hart_base =3D NULL;
> >               handler->enable_base =3D NULL;
> > +             kfree(handler->enable_save);
> >               handler->enable_save =3D NULL;
> >               handler->priv =3D NULL;
> >       }
> > -     return -ENOMEM;
> > +     bitmap_free(priv->prio_save);
> > +fail_free_priv:
> > +     kfree(priv);
> > +fail_free_regs:
> > +     iounmap(regs);
> > +     return error;
> > +}
> > +
> > +static int plic_platform_probe(struct platform_device *pdev)
> > +{
> > +     return plic_probe(pdev->dev.fwnode);
> >  }
> >
> > +static const struct of_device_id plic_platform_match[] =3D {
> > +     { .compatible =3D "sifive,plic-1.0.0" },
> > +     { .compatible =3D "riscv,plic0" },
> > +     { .compatible =3D "andestech,nceplic100" },
> > +     {}
> > +};
> > +
> >  static struct platform_driver plic_driver =3D {
> >       .driver =3D {
> >               .name           =3D "riscv-plic",
> > -             .of_match_table =3D plic_match,
> > +             .of_match_table =3D plic_platform_match,
> >       },
> > -     .probe =3D plic_probe,
> > +     .probe =3D plic_platform_probe,
> >  };
> >  builtin_platform_driver(plic_driver);
>
> FWIW, we should probably use the IRQCHIP_PLATFORM_DRIVER_* helpers to get
> .suppress_bind_attrs =3D true, since we no longer use devres for cleanup.

The callback registered using IRQCHIP_PLATFORM_DRIVER_*()
assumes OF nodes which creates problems extracting the ACPI
fwnode pointer.

Regarding suppress_bind_attrs, I agree we should set it to true. I
will update and send v2 soon.

Regards,
Anup

>
> Regards,
> Samuel
>
> > +
> > +static int __init plic_early_probe(struct device_node *node,
> > +                                struct device_node *parent)
> > +{
> > +     return plic_probe(&node->fwnode);
> > +}
> > +
> > +IRQCHIP_DECLARE(riscv, "thead,c900-plic", plic_early_probe);
>

