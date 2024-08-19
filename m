Return-Path: <linux-kernel+bounces-292327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E756956E03
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A23C71F23E64
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4AF174ED0;
	Mon, 19 Aug 2024 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="RVJaNN5t"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67E3156C78
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724079469; cv=none; b=dmV3I+T49DSo4DRZl6wBauGSpYC014q8GEXm6caoBxMWp3HkR2L1RIJOtcEFYKtZA8AuTBoDqyvYqKOyFKrXNmsGn+UPYthpPptMOLp07WBV3oBvheSOX+4w6qiHoH3amyjQWlRrV8F+qL00ceJZIQtRLUfRWrv9cb0qnduIUEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724079469; c=relaxed/simple;
	bh=hfBM6byS151SDIT/Lo9EmbO3VG6oeyV7DDbhGMHitBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c85uoGod/wRIArZfCJkarGuHOrjto3YEsglEW8w0tgHA4N40LbAxLDmESkLUiN0rj7OmHR7jEMt3+WP596YwGSk9oYbbm9AcGOxDT5mXVlGPMLSwZhxE9ZCtfqKANjM1vepFwKVU9IuilQVxj/MEgovAjS7ccsC1oegwf7rJkyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=RVJaNN5t; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ef7fef3ccfso48927041fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 07:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1724079466; x=1724684266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bBHKuRyYTq5U4UTOCuv2MxoiBi+poeRNtIkpZeardw=;
        b=RVJaNN5toLNyLK8Dg2pV4vXYjiUBNu2RQfwterj6oLEN6J9rpTkL5peMyPGrFAbdSv
         LanOOU2swGh3UGGDoEN+xCVtsKnGgQCLAx83D0nj+YBIfEh+yLCW4x9T3DYjMYt4t54D
         pCmGEeIe78slQhQbb5jM4q/fw+4xcn2SPxfo+ktsglv9jG1J4BJ4sNf0W8O/bA0HOZlH
         5yA5llUsYieG3Li/yebr/oOEiaLKyrFccdZPAaERWTJyarDn66OI7vReM9n3/Ifunx5Y
         THPslomVCUw4MmWZMxX+5QzrVdANgpBwk42j3TAycCfgQ7xfEydXwB3N/l3+BuTqESb9
         /oDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724079466; x=1724684266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bBHKuRyYTq5U4UTOCuv2MxoiBi+poeRNtIkpZeardw=;
        b=ItxXCYjMEcH74TxUx05efMHqvHhyLKvfDC0sqic/zc6WeIsNv+8Od3SlFgODqKzwLF
         TlsCL6sFYzMvVtePc1GE6J1Oz6ihdcpMhvuiSrQY7zGpJEo8Pt8B+iUKKwFD+5xe2FkL
         FQEruQtd9/2FBjFXJxGvd8xZs9qk8e0LghzAJ4Y3f0mPU1QpDz7tW/OL6HJ2zgIJ4e4s
         a0QSl+h/MPsDUF2HmUChoKm/qPRCY8wgA9UwavwfR+bCcOP3J2lcEDFb0ufsOjOwYEVh
         FRdRyiZgFG9gAje6xpU/7LDORDzvXgtjQJYSdAFWa56hoMbHoSfdkii7PE1cEPnEQbPq
         3Krg==
X-Forwarded-Encrypted: i=1; AJvYcCUHQL92yEenKhrhoNmmu4UR28cX5ApXXk0na6cuqiI/K7c8ufUzQ3bwoHd49BH9lFGkJdqO9LrEjKMHaRAIME3bcllT+yZrPLQq9zI0
X-Gm-Message-State: AOJu0YzHtsh5DGzG4lFDnmmwj675yuEjeIrFD0w2YLQ/4yMAOmFKqxwz
	yMnDf4QOgEITWdO2/sBRARJ0SuMgeUC6GTjwy06I2EPIkd8x0WUGU+EPp3LxUlvZoj6YDEL/39u
	W5c/4J3J6Sf84fV9MS0HRJ8YmO8+BrJ/NZ6tCThKAo91emLLoiI6rtw==
X-Google-Smtp-Source: AGHT+IFxFEiSfSDroziDIN9XZbFKmcAm8Bzj++hKRbg6hT3hHlFRPs41ex47d6KeFW2tSMYwVmtBK13IZ/veus1jRTg=
X-Received: by 2002:a2e:8717:0:b0:2ef:24e8:fd83 with SMTP id
 38308e7fff4ca-2f3c8f25f54mr49229591fa.38.1724079464832; Mon, 19 Aug 2024
 07:57:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817081218.2985171-1-apatel@ventanamicro.com> <CAJM55Z9_7WsqXT5hNuwB9jt31Aayk3kqOV5FDZ9tdcLYhwHTFg@mail.gmail.com>
In-Reply-To: <CAJM55Z9_7WsqXT5hNuwB9jt31Aayk3kqOV5FDZ9tdcLYhwHTFg@mail.gmail.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Mon, 19 Aug 2024 20:27:33 +0530
Message-ID: <CAK9=C2UbaPgjH8WuHyCvVUoR+AeXu8TD9+QUFOvCV+L9jTJfOw@mail.gmail.com>
Subject: Re: [PATCH v2] irqchip/sifive-plic: Probe plic driver early for
 Allwinner D1 platform
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, linux-kernel@vger.kernel.org, 
	Samuel Holland <samuel.holland@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Atish Patra <atishp@atishpatra.org>, linux-riscv@lists.infradead.org, 
	Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 12:27=E2=80=AFPM Emil Renner Berthing
<emil.renner.berthing@canonical.com> wrote:
>
> Anup Patel wrote:
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
> > Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> > Tested-by: Samuel Holland <samuel.holland@sifive.com>
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> > Changes since v1:
> >  - Set suppress_bind_attrs for PLIC platform driver
> > ---
> >  drivers/irqchip/irq-sifive-plic.c | 128 +++++++++++++++++++-----------
> >  1 file changed, 80 insertions(+), 48 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-si=
five-plic.c
> > index 9e22f7e378f5..33395c5a9b5b 100644
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
>
> This driver never worked with ACPI anyways?
>
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
> > @@ -554,7 +559,7 @@ static int plic_probe(struct platform_device *pdev)
> >                */
> >               handler =3D per_cpu_ptr(&plic_handlers, cpu);
> >               if (handler->present) {
> > -                     dev_warn(dev, "handler already present for contex=
t %d.\n", i);
> > +                     pr_warn("%pfwP: handler already present for conte=
xt %d.\n", fwnode, i);
> >                       plic_set_threshold(handler, PLIC_DISABLE_THRESHOL=
D);
> >                       goto done;
> >               }
> > @@ -568,8 +573,8 @@ static int plic_probe(struct platform_device *pdev)
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
> > @@ -581,7 +586,7 @@ static int plic_probe(struct platform_device *pdev)
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
> > @@ -619,13 +624,13 @@ static int plic_probe(struct platform_device *pde=
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
> > @@ -634,17 +639,44 @@ static int plic_probe(struct platform_device *pde=
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
> > +             .suppress_bind_attrs =3D true,
> >       },
> > -     .probe =3D plic_probe,
> > +     .probe =3D plic_platform_probe,
> >  };
> >  builtin_platform_driver(plic_driver);
> > +
> > +static int __init plic_early_probe(struct device_node *node,
> > +                                struct device_node *parent)
> > +{
> > +     return plic_probe(&node->fwnode);
> > +}
> > +
> > +IRQCHIP_DECLARE(riscv, "thead,c900-plic", plic_early_probe);
>
> If this is only needed on the Allwinner D1 maybe this should only match t=
he
> more specific "allwinner,sun20i-d1-plic"?
>
> In any case this works by itself, but not with Samuel's patch[1] applied,=
 so
> Tested-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
>
> [1]: https://lore.kernel.org/r/20240312192519.1602493-1-samuel.holland@si=
five.com

Thanks for testing.

Can you confirm that using "allwinner,sun20i-d1-plic" for early
probe works on the Allwinner D1 board ? If yes, the I will quickly
send a v3.

Regards,
Anup

