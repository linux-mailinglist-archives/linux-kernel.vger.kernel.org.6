Return-Path: <linux-kernel+bounces-219785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 630B990D7B6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB79F28753D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EDA4779D;
	Tue, 18 Jun 2024 15:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="cojZHNZ5"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DAB45C0B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 15:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718725730; cv=none; b=Ds7giVvuWoULaIRyij4+2t6qlYUQ9KevUpFXWTKxfuDb3EsU8RiYR3Oscc+P6nKaJzlj2Uo4P+sHcam/A2a9pxlWMbCwHdnn9JMn1twajNIH3K0IUS6bSIij099xGiQCGs9LNrss/u4R3RhQAyqt6MxAu2VhpI1wunguqpJ8rME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718725730; c=relaxed/simple;
	bh=7nYwdxwp+v0UdRiaHwObwWEhHmUzgbvBhanukfXuTMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CVRh8gTkCrGLTzjCs22JVTShqgGzD4wnPAwh2zvTnQpfKtBhtOMMdTmlK0WkUpoxZkdQqJ2XWELjFf6IpknZEyjovA3G1SRYuROAmw166ZIuAJK7V+5T6FClZ7duzV6Zdl9FUXS4qTRxJw6+OHnYo5EJ9H0pVlvORSNz1iwLyOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=cojZHNZ5; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52c8ddc2b29so6065606e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 08:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1718725727; x=1719330527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+inZ/rA5cGwmfLVrVBxGHIe/ByHkiXTR9D7JYXq2mRY=;
        b=cojZHNZ52K5Ka0AojyyLRyrUQwbjSHMQYL4Gc3bIBY5cT3rek3Kz5xWD2WTaqBe6ft
         c8mZPFC3x3bKIbPueNlHAy69AMgEBQkRjirmpc5wNcfzF4I2HxXKI+blmjsSYenubbIt
         jMnMtBoMSORlvENLYvBl9+GaJls6Tt4teaEFEuYg0XtA2MWNGMXVQ1NcUDqxCt86g8Zg
         Jx2RMnCKu1Uyjov21tsYDjMO3qWjn1Di0Zz4dm1vzxvQBZuKROqNUlxxV63loWCc/v83
         FSg+4UM+9skZ2x6c7tgS2aRGBbsmTfLkM+yVCqb4AYEAFPdbclmmjs2d26yNNivauTdF
         Cvag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718725727; x=1719330527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+inZ/rA5cGwmfLVrVBxGHIe/ByHkiXTR9D7JYXq2mRY=;
        b=Rv/5McYhF9K9C76k5A7KaPlyM9/Oho0AjZSzMDYmws2y+KRRTcRz8glizIRDc9afwt
         iS6sW1WtCp0pFFLvgDkMgX8biTvBLLzEjBm8xNnAENu+1GaK7AH22HqpEnzJtxL4qkyu
         lWuLBdEvYpHnAU71bFmvfkGg7DdUJY0D6ivdJuYfKYzo/mtpHQ5kKS5zY+EYmRT/KuR8
         cZx1XV4QpQaoqlAApu2LcpV3bZkX2Epmn5Vr6N2qeNSEaFlAXbJKPZoJaboeWPH97kGG
         P1dqEb43xEDkRAbRDTo0UwXUph6JpZ646pVp33f5HirjC+pAFXEW/SzEzc1OYuAlpdHH
         vM3g==
X-Forwarded-Encrypted: i=1; AJvYcCX91v1kXDaWBvOpc+KNFPN4nynSc3OHJWijsvKKNNiuZrxfHRNI8fCfyeTt6ATepcemc0RWSBaAW56qa2MrtcAF/0piTXmZJBa/jwV1
X-Gm-Message-State: AOJu0YyANCE9+UZFvdV/tbNnyed83zYdNv5oR9+Z1iLoZJMsO8a/OiTV
	/QH80QnUqx1I1WeNmeDq2oWYwUT5G62ZPo59GnZSfzeNvFC1raZm/TlG48vXshEqesKAw38Tnsa
	RQISfqJnqlQ7Jf6vZqw/V30tZ4GQCwOqWYfWmtg==
X-Google-Smtp-Source: AGHT+IHCofJB3nYZ6lnH+ZjdxZ2DthLF1hCVxttcISmMh5ZfJdkYeASXNXsViX1ARHn9yLCyM1WKZsQdPaZ/1TcUt9I=
X-Received: by 2002:a05:6512:3119:b0:52c:8079:b264 with SMTP id
 2adb3069b0e04-52ccaa2c834mr37588e87.9.1718725726403; Tue, 18 Jun 2024
 08:48:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222094006.1030709-1-apatel@ventanamicro.com>
 <20240222094006.1030709-2-apatel@ventanamicro.com> <CAJM55Z9hGKo4784N3s3DhWw=nMRKZKcmvZ58x7uVBghExhoc9A@mail.gmail.com>
In-Reply-To: <CAJM55Z9hGKo4784N3s3DhWw=nMRKZKcmvZ58x7uVBghExhoc9A@mail.gmail.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Tue, 18 Jun 2024 21:18:35 +0530
Message-ID: <CAK9=C2WP2+gKScUFuoE9782gjSfnDtcLAw01eCwram3LMAStBg@mail.gmail.com>
Subject: Re: [PATCH v14 01/18] irqchip/sifive-plic: Convert PLIC driver into a
 platform driver
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand <frowand.list@gmail.com>, 
	Conor Dooley <conor+dt@kernel.org>, Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org, 
	Saravana Kannan <saravanak@google.com>, Marc Zyngier <maz@kernel.org>, Anup Patel <anup@brainfault.org>, 
	linux-kernel@vger.kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Atish Patra <atishp@atishpatra.org>, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 7:00=E2=80=AFPM Emil Renner Berthing
<emil.renner.berthing@canonical.com> wrote:
>
> Anup Patel wrote:
> > The PLIC driver does not require very early initialization so convert
> > it into a platform driver.
> >
> > After conversion, the PLIC driver is probed after CPUs are brought-up
> > so setup cpuhp state after context handler of all online CPUs are
> > initialized otherwise PLIC driver crashes for platforms with multiple
> > PLIC instances.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
>
> Hi Anup,
>
> Sorry for the late reply to the mailing list, but ever since 6.9 where th=
is was
> applied my Allwinner D1 based boards no longer boot. This is the log of m=
y
> LicheeRV Dock booting plain 6.10-rc4, locking up and then rebooting due t=
o the
> the watchdog timing out:
>
> https://pastebin.com/raw/nsbzgEKW
>
> On 6.10-rc4 I can bring the same board to boot by reverting this patch an=
d all
> patches building on it. Eg.:
>
>   git revert e306a894bd51 a7fb69ffd7ce abb720579490 \
>              956521064780 a15587277a24 6c725f33d67b \
>              b68d0ff529a9 25d862e183d4 8ec99b033147

Does your board boot with only SBI timer driver enabled ?

If yes then probing of Allwinner timer driver needs to be fixed since it
depends on PLIC.

Regards,
Anup

>
> After that it boots but run into this separate issue:
> https://lore.kernel.org/all/DM6PR01MB58047C810DDD5D0AE397CADFF7C22@DM6PR0=
1MB5804.prod.exchangelabs.com/
>
> Samuel: After the reverts above applying this also prevents my board from
> booting:
> https://lore.kernel.org/all/20240312192519.1602493-1-samuel.holland@sifiv=
e.com/
>
> /Emil
>
> > ---
> >  drivers/irqchip/irq-sifive-plic.c | 101 ++++++++++++++++++------------
> >  1 file changed, 61 insertions(+), 40 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-si=
five-plic.c
> > index 5b7bc4fd9517..7400a07fc479 100644
> > --- a/drivers/irqchip/irq-sifive-plic.c
> > +++ b/drivers/irqchip/irq-sifive-plic.c
> > @@ -64,6 +64,7 @@
> >  #define PLIC_QUIRK_EDGE_INTERRUPT    0
> >
> >  struct plic_priv {
> > +     struct device *dev;
> >       struct cpumask lmask;
> >       struct irq_domain *irqdomain;
> >       void __iomem *regs;
> > @@ -406,30 +407,50 @@ static int plic_starting_cpu(unsigned int cpu)
> >       return 0;
> >  }
> >
> > -static int __init __plic_init(struct device_node *node,
> > -                           struct device_node *parent,
> > -                           unsigned long plic_quirks)
> > +static const struct of_device_id plic_match[] =3D {
> > +     { .compatible =3D "sifive,plic-1.0.0" },
> > +     { .compatible =3D "riscv,plic0" },
> > +     { .compatible =3D "andestech,nceplic100",
> > +       .data =3D (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
> > +     { .compatible =3D "thead,c900-plic",
> > +       .data =3D (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
> > +     {}
> > +};
> > +
> > +static int plic_probe(struct platform_device *pdev)
> >  {
> >       int error =3D 0, nr_contexts, nr_handlers =3D 0, i;
> > -     u32 nr_irqs;
> > -     struct plic_priv *priv;
> > +     struct device *dev =3D &pdev->dev;
> > +     unsigned long plic_quirks =3D 0;
> >       struct plic_handler *handler;
> > +     struct plic_priv *priv;
> > +     bool cpuhp_setup;
> >       unsigned int cpu;
> > +     u32 nr_irqs;
> > +
> > +     if (is_of_node(dev->fwnode)) {
> > +             const struct of_device_id *id;
> > +
> > +             id =3D of_match_node(plic_match, to_of_node(dev->fwnode))=
;
> > +             if (id)
> > +                     plic_quirks =3D (unsigned long)id->data;
> > +     }
> >
> >       priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
> >       if (!priv)
> >               return -ENOMEM;
> >
> > +     priv->dev =3D dev;
> >       priv->plic_quirks =3D plic_quirks;
> >
> > -     priv->regs =3D of_iomap(node, 0);
> > +     priv->regs =3D of_iomap(to_of_node(dev->fwnode), 0);
> >       if (WARN_ON(!priv->regs)) {
> >               error =3D -EIO;
> >               goto out_free_priv;
> >       }
> >
> >       error =3D -EINVAL;
> > -     of_property_read_u32(node, "riscv,ndev", &nr_irqs);
> > +     of_property_read_u32(to_of_node(dev->fwnode), "riscv,ndev", &nr_i=
rqs);
> >       if (WARN_ON(!nr_irqs))
> >               goto out_iounmap;
> >
> > @@ -439,13 +460,13 @@ static int __init __plic_init(struct device_node =
*node,
> >       if (!priv->prio_save)
> >               goto out_free_priority_reg;
> >
> > -     nr_contexts =3D of_irq_count(node);
> > +     nr_contexts =3D of_irq_count(to_of_node(dev->fwnode));
> >       if (WARN_ON(!nr_contexts))
> >               goto out_free_priority_reg;
> >
> >       error =3D -ENOMEM;
> > -     priv->irqdomain =3D irq_domain_add_linear(node, nr_irqs + 1,
> > -                     &plic_irqdomain_ops, priv);
> > +     priv->irqdomain =3D irq_domain_add_linear(to_of_node(dev->fwnode)=
, nr_irqs + 1,
> > +                                             &plic_irqdomain_ops, priv=
);
> >       if (WARN_ON(!priv->irqdomain))
> >               goto out_free_priority_reg;
> >
> > @@ -455,7 +476,7 @@ static int __init __plic_init(struct device_node *n=
ode,
> >               int cpu;
> >               unsigned long hartid;
> >
> > -             if (of_irq_parse_one(node, i, &parent)) {
> > +             if (of_irq_parse_one(to_of_node(dev->fwnode), i, &parent)=
) {
> >                       pr_err("failed to parse parent for context %d.\n"=
, i);
> >                       continue;
> >               }
> > @@ -491,7 +512,7 @@ static int __init __plic_init(struct device_node *n=
ode,
> >
> >               /* Find parent domain and register chained handler */
> >               if (!plic_parent_irq && irq_find_host(parent.np)) {
> > -                     plic_parent_irq =3D irq_of_parse_and_map(node, i)=
;
> > +                     plic_parent_irq =3D irq_of_parse_and_map(to_of_no=
de(dev->fwnode), i);
> >                       if (plic_parent_irq)
> >                               irq_set_chained_handler(plic_parent_irq,
> >                                                       plic_handle_irq);
> > @@ -533,20 +554,29 @@ static int __init __plic_init(struct device_node =
*node,
> >
> >       /*
> >        * We can have multiple PLIC instances so setup cpuhp state
> > -      * and register syscore operations only when context handler
> > -      * for current/boot CPU is present.
> > +      * and register syscore operations only once after context
> > +      * handlers of all online CPUs are initialized.
> >        */
> > -     handler =3D this_cpu_ptr(&plic_handlers);
> > -     if (handler->present && !plic_cpuhp_setup_done) {
> > -             cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
> > -                               "irqchip/sifive/plic:starting",
> > -                               plic_starting_cpu, plic_dying_cpu);
> > -             register_syscore_ops(&plic_irq_syscore_ops);
> > -             plic_cpuhp_setup_done =3D true;
> > +     if (!plic_cpuhp_setup_done) {
> > +             cpuhp_setup =3D true;
> > +             for_each_online_cpu(cpu) {
> > +                     handler =3D per_cpu_ptr(&plic_handlers, cpu);
> > +                     if (!handler->present) {
> > +                             cpuhp_setup =3D false;
> > +                             break;
> > +                     }
> > +             }
> > +             if (cpuhp_setup) {
> > +                     cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTI=
NG,
> > +                                       "irqchip/sifive/plic:starting",
> > +                                       plic_starting_cpu, plic_dying_c=
pu);
> > +                     register_syscore_ops(&plic_irq_syscore_ops);
> > +                     plic_cpuhp_setup_done =3D true;
> > +             }
> >       }
> >
> > -     pr_info("%pOFP: mapped %d interrupts with %d handlers for"
> > -             " %d contexts.\n", node, nr_irqs, nr_handlers, nr_context=
s);
> > +     pr_info("%pOFP: mapped %d interrupts with %d handlers for %d cont=
exts.\n",
> > +             to_of_node(dev->fwnode), nr_irqs, nr_handlers, nr_context=
s);
> >       return 0;
> >
> >  out_free_enable_reg:
> > @@ -563,20 +593,11 @@ static int __init __plic_init(struct device_node =
*node,
> >       return error;
> >  }
> >
> > -static int __init plic_init(struct device_node *node,
> > -                         struct device_node *parent)
> > -{
> > -     return __plic_init(node, parent, 0);
> > -}
> > -
> > -IRQCHIP_DECLARE(sifive_plic, "sifive,plic-1.0.0", plic_init);
> > -IRQCHIP_DECLARE(riscv_plic0, "riscv,plic0", plic_init); /* for legacy =
systems */
> > -
> > -static int __init plic_edge_init(struct device_node *node,
> > -                              struct device_node *parent)
> > -{
> > -     return __plic_init(node, parent, BIT(PLIC_QUIRK_EDGE_INTERRUPT));
> > -}
> > -
> > -IRQCHIP_DECLARE(andestech_nceplic100, "andestech,nceplic100", plic_edg=
e_init);
> > -IRQCHIP_DECLARE(thead_c900_plic, "thead,c900-plic", plic_edge_init);
> > +static struct platform_driver plic_driver =3D {
> > +     .driver =3D {
> > +             .name           =3D "riscv-plic",
> > +             .of_match_table =3D plic_match,
> > +     },
> > +     .probe =3D plic_probe,
> > +};
> > +builtin_platform_driver(plic_driver);
> > --
> > 2.34.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

