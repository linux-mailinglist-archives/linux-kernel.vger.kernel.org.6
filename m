Return-Path: <linux-kernel+bounces-569156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8637EA69F46
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 06:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8EBD4201BE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 05:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816521DF25A;
	Thu, 20 Mar 2025 05:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="0gqLig9S"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D33C1C6F55
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 05:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742448419; cv=none; b=LwjLUzU1xx041vMzfMWGQDbNZUEPCDkgFANGlFUBHL9eTeKGejiTlD1ZYYQOZLQRq+ynYrOPYvbDnY/xQSXIxtZw7ISnEbOG5FXxmjUnOyxs/zT2/NGX+WFUvAL9rDybKovbo3ZvCL6xEB/CekwO4VzGo5gf9eT01+zvQYx8huw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742448419; c=relaxed/simple;
	bh=7EDK8TNZC7QNYkliZGzF/aVp+o1Ytm9QNdH1obmsEAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=plsabGnQN6mzRTlCgi+M2sgVFDC+sA7vFx8bhDdkLEkEiqvFtrlWKsCPCW6i8v9MtYKRPw4n2pApK5eXoIBwAxi3ZOJ9jLG7pWSd53MEaGvmCVp3dJfsylrw6WBUt1eisK7A7MQdsZ73/eHvQQoifYZ5Klc1IzLVcWHyRy6KXTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=0gqLig9S; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-854a68f5a9cso35008339f.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 22:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1742448414; x=1743053214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TuFECIK3z+HNqsrJE6LNBjL0DFsqowu4YzYMG1uLjk=;
        b=0gqLig9SPPHgzVI0pXw0ER+DRJrmwuMGvTsK64ECsdRVMtZyUG43g6HN2lQNp2Mf40
         3AloDRZKNOTSXam5npGHsqpSlpCUMRHXgp5U9pRuiYeL/HjB9FP8MVpm006MoEQkrNp0
         WCxe20cRuMahbjBVOoNQA5BIcaWOJNq9iFJrV61mYUn6kwg9PBMCTn+xTn5Bb1RyxToU
         IJTt990RReqmIPZDmBXuyWXlVdDhXrQLwz9royX/+eVNDPzhmRY1lDjGXtZxKdGTks34
         nxhT72cMYTLTfRhbzYj1EUTyrdpvJzmSKYyPxgA0QBNpVLa9DuWWIFpjRDBOwU/+JBl5
         fU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742448414; x=1743053214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6TuFECIK3z+HNqsrJE6LNBjL0DFsqowu4YzYMG1uLjk=;
        b=q+1BoQ1+PRYiQQJVpYH9YAcUyB8ny8jkOzKjvjL16L+Kzeq6DK1W2qyBULz++sihM0
         b2WHrkhMDxyQC9MA2fEZ5ATWovIV6waIcL1HILROJuGNQhzp5kMoAgeGXhYhEMVkDJUA
         QNu5ZrxIR+J3Q5tEUTDIvxa74SocS1m43NoUWnwxCpj/K1MwWBT98UIJVmsGh4AnYHn8
         GmbyGo5cjIAQIeO/0iZ60uOxlJyEAc3ll3is6v7oPy7Xw+IYqrZVjepj+Sfvqz4Q47de
         /zvJlrhKBPPwgOr2HK7DVuk/KFITS8LDozfDJY+gaOu8/zUQgeclq4Vk0tAZMRGlCIC1
         P76Q==
X-Forwarded-Encrypted: i=1; AJvYcCWlWvlqB19bnjTkquOeoThiCkMa2Q1TwSMMpkabXTWjGVcg8MyOxZ9xqsuySMYgc4bGhB0yTKXRqs2HNxs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6ty1sLBiytv9tuxrPFuJQD13hwdL72FbOSXwROnkhmcXBzDnt
	NcsXG5q3OPGc/Lwp5QyUdibNe6j3OVoJ5hYL5DSnV/ueUsb/8KFAMyEk1MPPPJiIEVibwY/JjUD
	wHY2UgJdfvf6wF9BNnMjHUUzHefKh6fAVaRfLmQ==
X-Gm-Gg: ASbGncuVTslhIwkyy++WdygywL+JsnAj8aYa26I2K2TxSk0uOheq37YVPsFy6iB86/7
	V5gc2LFbfHm+M9WjiA6KWMlWafOvv0S4UhFCW4rLN70UwPNgDyFX5IB0581f19NUtjNBEbhFJBd
	ELD833xj59ak4iKTp8DKD0NA81fhA=
X-Google-Smtp-Source: AGHT+IFbStYTQ82zHzWMU0s2nyBJrHic6WzBpBrgrfYFVrSxbmovqNdk/u8qSTHL2YYZCsD6fapJ1eNw98FQBuQ8Kf8=
X-Received: by 2002:a05:6e02:214d:b0:3cf:fe21:af8 with SMTP id
 e9e14a558f8ab-3d586b14d50mr55400165ab.4.1742448414425; Wed, 19 Mar 2025
 22:26:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319092951.37667-1-jirislaby@kernel.org> <20250319092951.37667-7-jirislaby@kernel.org>
In-Reply-To: <20250319092951.37667-7-jirislaby@kernel.org>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 20 Mar 2025 10:56:41 +0530
X-Gm-Features: AQ5f1Jpz4MSHzNnNdAhk3R_No0q-qOTvynTjpqT93LykipnY1ZhgVwUxNozrEWg
Message-ID: <CAAhSdy0dG0nn=-OTULCrzFDdT3E7keLdjxoHAf=s7nVzUSO5YA@mail.gmail.com>
Subject: Re: [PATCH v2 06/57] irqdomain: irqchip: Switch to of_fwnode_handle()
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: tglx@linutronix.de, maz@kernel.org, linux-kernel@vger.kernel.org, 
	Antoine Tenart <atenart@kernel.org>, Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Andrew Lunn <andrew@lunn.ch>, 
	Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Linus Walleij <linusw@kernel.org>, 
	Imre Kaloz <kaloz@openwrt.org>, Herve Codina <herve.codina@bootlin.com>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, asahi@lists.linux.dev, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 3:01=E2=80=AFPM Jiri Slaby (SUSE) <jirislaby@kernel=
.org> wrote:
>
> of_node_to_fwnode() is irqdomain's reimplementation of the "officially"
> defined of_fwnode_handle(). The former is in the process of being
> removed, so use the latter instead.
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Antoine Tenart <atenart@kernel.org>
> Cc: Sven Peter <sven@svenpeter.dev>
> Cc: Janne Grunau <j@jannau.net>
> Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@bootlin.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Linus Walleij <linusw@kernel.org>
> Cc: Imre Kaloz <kaloz@openwrt.org>
> Cc: Herve Codina <herve.codina@bootlin.com>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: WANG Xuerui <kernel@xen0n.name>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: Anup Patel <anup@brainfault.org>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Alexandre Ghiti <alex@ghiti.fr>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Tero Kristo <kristo@kernel.org>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: asahi@lists.linux.dev
> Cc: loongarch@lists.linux.dev
> Cc: linux-mips@vger.kernel.org
> Cc: linux-amlogic@lists.infradead.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-stm32@st-md-mailman.stormreply.com

LGTM for irq-riscv-intc driver

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  drivers/irqchip/irq-alpine-msi.c            | 2 +-
>  drivers/irqchip/irq-apple-aic.c             | 4 ++--
>  drivers/irqchip/irq-armada-370-xp.c         | 4 ++--
>  drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c | 2 +-
>  drivers/irqchip/irq-gic-v3.c                | 4 ++--
>  drivers/irqchip/irq-ixp4xx.c                | 2 +-
>  drivers/irqchip/irq-lan966x-oic.c           | 2 +-
>  drivers/irqchip/irq-loongarch-cpu.c         | 2 +-
>  drivers/irqchip/irq-loongson-eiointc.c      | 2 +-
>  drivers/irqchip/irq-loongson-htvec.c        | 2 +-
>  drivers/irqchip/irq-loongson-liointc.c      | 2 +-
>  drivers/irqchip/irq-loongson-pch-msi.c      | 2 +-
>  drivers/irqchip/irq-loongson-pch-pic.c      | 2 +-
>  drivers/irqchip/irq-ls-scfg-msi.c           | 2 +-
>  drivers/irqchip/irq-meson-gpio.c            | 2 +-
>  drivers/irqchip/irq-mvebu-gicp.c            | 2 +-
>  drivers/irqchip/irq-mvebu-odmi.c            | 2 +-
>  drivers/irqchip/irq-mvebu-sei.c             | 6 +++---
>  drivers/irqchip/irq-qcom-mpm.c              | 2 +-
>  drivers/irqchip/irq-riscv-intc.c            | 2 +-
>  drivers/irqchip/irq-sni-exiu.c              | 2 +-
>  drivers/irqchip/irq-stm32mp-exti.c          | 2 +-
>  drivers/irqchip/irq-ti-sci-inta.c           | 4 ++--
>  drivers/irqchip/irq-ti-sci-intr.c           | 2 +-
>  drivers/irqchip/irq-uniphier-aidet.c        | 2 +-
>  25 files changed, 31 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/irqchip/irq-alpine-msi.c b/drivers/irqchip/irq-alpin=
e-msi.c
> index a1430ab60a8a..0207d35135da 100644
> --- a/drivers/irqchip/irq-alpine-msi.c
> +++ b/drivers/irqchip/irq-alpine-msi.c
> @@ -213,7 +213,7 @@ static int alpine_msix_init_domains(struct alpine_msi=
x_data *priv,
>                 return -ENOMEM;
>         }
>
> -       msi_domain =3D pci_msi_create_irq_domain(of_node_to_fwnode(node),
> +       msi_domain =3D pci_msi_create_irq_domain(of_fwnode_handle(node),
>                                                &alpine_msix_domain_info,
>                                                middle_domain);
>         if (!msi_domain) {
> diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-=
aic.c
> index 974dc088c853..032d66dceb8e 100644
> --- a/drivers/irqchip/irq-apple-aic.c
> +++ b/drivers/irqchip/irq-apple-aic.c
> @@ -1014,7 +1014,7 @@ static int __init aic_of_ic_init(struct device_node=
 *node, struct device_node *p
>
>         irqc->info.die_stride =3D off - start_off;
>
> -       irqc->hw_domain =3D irq_domain_create_tree(of_node_to_fwnode(node=
),
> +       irqc->hw_domain =3D irq_domain_create_tree(of_fwnode_handle(node)=
,
>                                                  &aic_irq_domain_ops, irq=
c);
>         if (WARN_ON(!irqc->hw_domain))
>                 goto err_unmap;
> @@ -1067,7 +1067,7 @@ static int __init aic_of_ic_init(struct device_node=
 *node, struct device_node *p
>
>         if (is_kernel_in_hyp_mode()) {
>                 struct irq_fwspec mi =3D {
> -                       .fwnode         =3D of_node_to_fwnode(node),
> +                       .fwnode         =3D of_fwnode_handle(node),
>                         .param_count    =3D 3,
>                         .param          =3D {
>                                 [0]     =3D AIC_FIQ, /* This is a lie */
> diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-ar=
mada-370-xp.c
> index 2aa6a51e05d0..de98d16c1718 100644
> --- a/drivers/irqchip/irq-armada-370-xp.c
> +++ b/drivers/irqchip/irq-armada-370-xp.c
> @@ -353,7 +353,7 @@ static int __init mpic_msi_init(struct mpic *mpic, st=
ruct device_node *node,
>         if (!mpic->msi_inner_domain)
>                 return -ENOMEM;
>
> -       mpic->msi_domain =3D pci_msi_create_irq_domain(of_node_to_fwnode(=
node), &mpic_msi_domain_info,
> +       mpic->msi_domain =3D pci_msi_create_irq_domain(of_fwnode_handle(n=
ode), &mpic_msi_domain_info,
>                                                      mpic->msi_inner_doma=
in);
>         if (!mpic->msi_domain) {
>                 irq_domain_remove(mpic->msi_inner_domain);
> @@ -492,7 +492,7 @@ static int __init mpic_ipi_init(struct mpic *mpic, st=
ruct device_node *node)
>  {
>         int base_ipi;
>
> -       mpic->ipi_domain =3D irq_domain_create_linear(of_node_to_fwnode(n=
ode), IPI_DOORBELL_NR,
> +       mpic->ipi_domain =3D irq_domain_create_linear(of_fwnode_handle(no=
de), IPI_DOORBELL_NR,
>                                                     &mpic_ipi_domain_ops,=
 mpic);
>         if (WARN_ON(!mpic->ipi_domain))
>                 return -ENOMEM;
> diff --git a/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c b/drivers/irqchi=
p/irq-gic-v3-its-fsl-mc-msi.c
> index 8e87fc35f8aa..11549d85f23b 100644
> --- a/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
> +++ b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
> @@ -152,7 +152,7 @@ static void __init its_fsl_mc_of_msi_init(void)
>                 if (!of_property_read_bool(np, "msi-controller"))
>                         continue;
>
> -               its_fsl_mc_msi_init_one(of_node_to_fwnode(np),
> +               its_fsl_mc_msi_init_one(of_fwnode_handle(np),
>                                         np->full_name);
>         }
>  }
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 270d7a4d85a6..efc791c43d44 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -1826,7 +1826,7 @@ static int partition_domain_translate(struct irq_do=
main *d,
>
>         ppi_idx =3D __gic_get_ppi_index(ppi_intid);
>         ret =3D partition_translate_id(gic_data.ppi_descs[ppi_idx],
> -                                    of_node_to_fwnode(np));
> +                                    of_fwnode_handle(np));
>         if (ret < 0)
>                 return ret;
>
> @@ -2192,7 +2192,7 @@ static void __init gic_populate_ppi_partitions(stru=
ct device_node *gic_node)
>
>                 part =3D &parts[part_idx];
>
> -               part->partition_id =3D of_node_to_fwnode(child_part);
> +               part->partition_id =3D of_fwnode_handle(child_part);
>
>                 pr_info("GIC: PPI partition %pOFn[%d] { ",
>                         child_part, part_idx);
> diff --git a/drivers/irqchip/irq-ixp4xx.c b/drivers/irqchip/irq-ixp4xx.c
> index f23b02f62a5c..a9a5a52b818a 100644
> --- a/drivers/irqchip/irq-ixp4xx.c
> +++ b/drivers/irqchip/irq-ixp4xx.c
> @@ -261,7 +261,7 @@ static int __init ixp4xx_of_init_irq(struct device_no=
de *np,
>                 pr_crit("IXP4XX: could not ioremap interrupt controller\n=
");
>                 return -ENODEV;
>         }
> -       fwnode =3D of_node_to_fwnode(np);
> +       fwnode =3D of_fwnode_handle(np);
>
>         /* These chip variants have 64 interrupts */
>         is_356 =3D of_device_is_compatible(np, "intel,ixp43x-interrupt") =
||
> diff --git a/drivers/irqchip/irq-lan966x-oic.c b/drivers/irqchip/irq-lan9=
66x-oic.c
> index 41ac880e3b87..9445c3a6b1b0 100644
> --- a/drivers/irqchip/irq-lan966x-oic.c
> +++ b/drivers/irqchip/irq-lan966x-oic.c
> @@ -224,7 +224,7 @@ static int lan966x_oic_probe(struct platform_device *=
pdev)
>                 .exit           =3D lan966x_oic_chip_exit,
>         };
>         struct irq_domain_info d_info =3D {
> -               .fwnode         =3D of_node_to_fwnode(pdev->dev.of_node),
> +               .fwnode         =3D of_fwnode_handle(pdev->dev.of_node),
>                 .domain_flags   =3D IRQ_DOMAIN_FLAG_DESTROY_GC,
>                 .size           =3D LAN966X_OIC_NR_IRQ,
>                 .hwirq_max      =3D LAN966X_OIC_NR_IRQ,
> diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq-lo=
ongarch-cpu.c
> index e62dab4c97fc..950bc087e388 100644
> --- a/drivers/irqchip/irq-loongarch-cpu.c
> +++ b/drivers/irqchip/irq-loongarch-cpu.c
> @@ -100,7 +100,7 @@ static const struct irq_domain_ops loongarch_cpu_intc=
_irq_domain_ops =3D {
>  static int __init cpuintc_of_init(struct device_node *of_node,
>                                 struct device_node *parent)
>  {
> -       cpuintc_handle =3D of_node_to_fwnode(of_node);
> +       cpuintc_handle =3D of_fwnode_handle(of_node);
>
>         irq_domain =3D irq_domain_create_linear(cpuintc_handle, EXCCODE_I=
NT_NUM,
>                                 &loongarch_cpu_intc_irq_domain_ops, NULL)=
;
> diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq=
-loongson-eiointc.c
> index bb79e19dfb59..b2860eb2d32c 100644
> --- a/drivers/irqchip/irq-loongson-eiointc.c
> +++ b/drivers/irqchip/irq-loongson-eiointc.c
> @@ -554,7 +554,7 @@ static int __init eiointc_of_init(struct device_node =
*of_node,
>                 priv->vec_count =3D VEC_COUNT;
>
>         priv->node =3D 0;
> -       priv->domain_handle =3D of_node_to_fwnode(of_node);
> +       priv->domain_handle =3D of_fwnode_handle(of_node);
>
>         ret =3D eiointc_init(priv, parent_irq, 0);
>         if (ret < 0)
> diff --git a/drivers/irqchip/irq-loongson-htvec.c b/drivers/irqchip/irq-l=
oongson-htvec.c
> index 5da02c7ad0b3..d8558eb35044 100644
> --- a/drivers/irqchip/irq-loongson-htvec.c
> +++ b/drivers/irqchip/irq-loongson-htvec.c
> @@ -248,7 +248,7 @@ static int htvec_of_init(struct device_node *node,
>         }
>
>         err =3D htvec_init(res.start, resource_size(&res),
> -                       num_parents, parent_irq, of_node_to_fwnode(node))=
;
> +                       num_parents, parent_irq, of_fwnode_handle(node));
>         if (err < 0)
>                 return err;
>
> diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq=
-loongson-liointc.c
> index 2b1bd4a96665..95cade56e0be 100644
> --- a/drivers/irqchip/irq-loongson-liointc.c
> +++ b/drivers/irqchip/irq-loongson-liointc.c
> @@ -363,7 +363,7 @@ static int __init liointc_of_init(struct device_node =
*node,
>         }
>
>         err =3D liointc_init(res.start, resource_size(&res),
> -                       revision, of_node_to_fwnode(node), node);
> +                       revision, of_fwnode_handle(node), node);
>         if (err < 0)
>                 return err;
>
> diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq=
-loongson-pch-msi.c
> index 9c62108b3ad5..c07876ae7b49 100644
> --- a/drivers/irqchip/irq-loongson-pch-msi.c
> +++ b/drivers/irqchip/irq-loongson-pch-msi.c
> @@ -243,7 +243,7 @@ static int pch_msi_of_init(struct device_node *node, =
struct device_node *parent)
>                 return -EINVAL;
>         }
>
> -       err =3D pch_msi_init(res.start, irq_base, irq_count, parent_domai=
n, of_node_to_fwnode(node));
> +       err =3D pch_msi_init(res.start, irq_base, irq_count, parent_domai=
n, of_fwnode_handle(node));
>         if (err < 0)
>                 return err;
>
> diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq=
-loongson-pch-pic.c
> index 69efda35a8e7..62e6bf3a0611 100644
> --- a/drivers/irqchip/irq-loongson-pch-pic.c
> +++ b/drivers/irqchip/irq-loongson-pch-pic.c
> @@ -392,7 +392,7 @@ static int pch_pic_of_init(struct device_node *node,
>         }
>
>         err =3D pch_pic_init(res.start, resource_size(&res), vec_base,
> -                               parent_domain, of_node_to_fwnode(node), 0=
);
> +                               parent_domain, of_fwnode_handle(node), 0)=
;
>         if (err < 0)
>                 return err;
>
> diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-s=
cfg-msi.c
> index 3cb80796cc7c..cbe11a8afe4f 100644
> --- a/drivers/irqchip/irq-ls-scfg-msi.c
> +++ b/drivers/irqchip/irq-ls-scfg-msi.c
> @@ -225,7 +225,7 @@ static int ls_scfg_msi_domains_init(struct ls_scfg_ms=
i *msi_data)
>         }
>
>         msi_data->msi_domain =3D pci_msi_create_irq_domain(
> -                               of_node_to_fwnode(msi_data->pdev->dev.of_=
node),
> +                               of_fwnode_handle(msi_data->pdev->dev.of_n=
ode),
>                                 &ls_scfg_msi_domain_info,
>                                 msi_data->parent);
>         if (!msi_data->msi_domain) {
> diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson=
-gpio.c
> index 0a25536a5d07..7d177626d64b 100644
> --- a/drivers/irqchip/irq-meson-gpio.c
> +++ b/drivers/irqchip/irq-meson-gpio.c
> @@ -607,7 +607,7 @@ static int meson_gpio_irq_of_init(struct device_node =
*node, struct device_node *
>
>         domain =3D irq_domain_create_hierarchy(parent_domain, 0,
>                                              ctl->params->nr_hwirq,
> -                                            of_node_to_fwnode(node),
> +                                            of_fwnode_handle(node),
>                                              &meson_gpio_irq_domain_ops,
>                                              ctl);
>         if (!domain) {
> diff --git a/drivers/irqchip/irq-mvebu-gicp.c b/drivers/irqchip/irq-mvebu=
-gicp.c
> index d67f93f6d750..521cc265c05e 100644
> --- a/drivers/irqchip/irq-mvebu-gicp.c
> +++ b/drivers/irqchip/irq-mvebu-gicp.c
> @@ -232,7 +232,7 @@ static int mvebu_gicp_probe(struct platform_device *p=
dev)
>
>         inner_domain =3D irq_domain_create_hierarchy(parent_domain, 0,
>                                                    gicp->spi_cnt,
> -                                                  of_node_to_fwnode(node=
),
> +                                                  of_fwnode_handle(node)=
,
>                                                    &gicp_domain_ops, gicp=
);
>         if (!inner_domain)
>                 return -ENOMEM;
> diff --git a/drivers/irqchip/irq-mvebu-odmi.c b/drivers/irqchip/irq-mvebu=
-odmi.c
> index 28f7e81df94f..c1fcd4525e3b 100644
> --- a/drivers/irqchip/irq-mvebu-odmi.c
> +++ b/drivers/irqchip/irq-mvebu-odmi.c
> @@ -207,7 +207,7 @@ static int __init mvebu_odmi_init(struct device_node =
*node,
>
>         inner_domain =3D irq_domain_create_hierarchy(parent_domain, 0,
>                                                    odmis_count * NODMIS_P=
ER_FRAME,
> -                                                  of_node_to_fwnode(node=
),
> +                                                  of_fwnode_handle(node)=
,
>                                                    &odmi_domain_ops, NULL=
);
>         if (!inner_domain) {
>                 ret =3D -ENOMEM;
> diff --git a/drivers/irqchip/irq-mvebu-sei.c b/drivers/irqchip/irq-mvebu-=
sei.c
> index ebd4a9014e8d..5030fcecdcc3 100644
> --- a/drivers/irqchip/irq-mvebu-sei.c
> +++ b/drivers/irqchip/irq-mvebu-sei.c
> @@ -402,7 +402,7 @@ static int mvebu_sei_probe(struct platform_device *pd=
ev)
>         }
>
>         /* Create the root SEI domain */
> -       sei->sei_domain =3D irq_domain_create_linear(of_node_to_fwnode(no=
de),
> +       sei->sei_domain =3D irq_domain_create_linear(of_fwnode_handle(nod=
e),
>                                                    (sei->caps->ap_range.s=
ize +
>                                                     sei->caps->cp_range.s=
ize),
>                                                    &mvebu_sei_domain_ops,
> @@ -418,7 +418,7 @@ static int mvebu_sei_probe(struct platform_device *pd=
ev)
>         /* Create the 'wired' domain */
>         sei->ap_domain =3D irq_domain_create_hierarchy(sei->sei_domain, 0=
,
>                                                      sei->caps->ap_range.=
size,
> -                                                    of_node_to_fwnode(no=
de),
> +                                                    of_fwnode_handle(nod=
e),
>                                                      &mvebu_sei_ap_domain=
_ops,
>                                                      sei);
>         if (!sei->ap_domain) {
> @@ -432,7 +432,7 @@ static int mvebu_sei_probe(struct platform_device *pd=
ev)
>         /* Create the 'MSI' domain */
>         sei->cp_domain =3D irq_domain_create_hierarchy(sei->sei_domain, 0=
,
>                                                      sei->caps->cp_range.=
size,
> -                                                    of_node_to_fwnode(no=
de),
> +                                                    of_fwnode_handle(nod=
e),
>                                                      &mvebu_sei_cp_domain=
_ops,
>                                                      sei);
>         if (!sei->cp_domain) {
> diff --git a/drivers/irqchip/irq-qcom-mpm.c b/drivers/irqchip/irq-qcom-mp=
m.c
> index 7942d8eb3d00..00c770e367d0 100644
> --- a/drivers/irqchip/irq-qcom-mpm.c
> +++ b/drivers/irqchip/irq-qcom-mpm.c
> @@ -447,7 +447,7 @@ static int qcom_mpm_init(struct device_node *np, stru=
ct device_node *parent)
>
>         priv->domain =3D irq_domain_create_hierarchy(parent_domain,
>                                 IRQ_DOMAIN_FLAG_QCOM_MPM_WAKEUP, pin_cnt,
> -                               of_node_to_fwnode(np), &qcom_mpm_ops, pri=
v);
> +                               of_fwnode_handle(np), &qcom_mpm_ops, priv=
);
>         if (!priv->domain) {
>                 dev_err(dev, "failed to create MPM domain\n");
>                 ret =3D -ENOMEM;
> diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv=
-intc.c
> index f653c13de62b..e5805885394e 100644
> --- a/drivers/irqchip/irq-riscv-intc.c
> +++ b/drivers/irqchip/irq-riscv-intc.c
> @@ -242,7 +242,7 @@ static int __init riscv_intc_init(struct device_node =
*node,
>                 chip =3D &andes_intc_chip;
>         }
>
> -       return riscv_intc_init_common(of_node_to_fwnode(node), chip);
> +       return riscv_intc_init_common(of_fwnode_handle(node), chip);
>  }
>
>  IRQCHIP_DECLARE(riscv, "riscv,cpu-intc", riscv_intc_init);
> diff --git a/drivers/irqchip/irq-sni-exiu.c b/drivers/irqchip/irq-sni-exi=
u.c
> index c7db617e1a2f..7d10bf6e5824 100644
> --- a/drivers/irqchip/irq-sni-exiu.c
> +++ b/drivers/irqchip/irq-sni-exiu.c
> @@ -249,7 +249,7 @@ static int __init exiu_dt_init(struct device_node *no=
de,
>                 return -ENXIO;
>         }
>
> -       data =3D exiu_init(of_node_to_fwnode(node), &res);
> +       data =3D exiu_init(of_fwnode_handle(node), &res);
>         if (IS_ERR(data))
>                 return PTR_ERR(data);
>
> diff --git a/drivers/irqchip/irq-stm32mp-exti.c b/drivers/irqchip/irq-stm=
32mp-exti.c
> index cb83d6cc6113..649b84f12efc 100644
> --- a/drivers/irqchip/irq-stm32mp-exti.c
> +++ b/drivers/irqchip/irq-stm32mp-exti.c
> @@ -531,7 +531,7 @@ static int stm32mp_exti_domain_alloc(struct irq_domai=
n *dm,
>                 if (ret)
>                         return ret;
>                 /* we only support one parent, so far */
> -               if (of_node_to_fwnode(out_irq.np) !=3D dm->parent->fwnode=
)
> +               if (of_fwnode_handle(out_irq.np) !=3D dm->parent->fwnode)
>                         return -EINVAL;
>
>                 of_phandle_args_to_fwspec(out_irq.np, out_irq.args,
> diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-s=
ci-inta.c
> index a887efba262c..38dfc1f9a56b 100644
> --- a/drivers/irqchip/irq-ti-sci-inta.c
> +++ b/drivers/irqchip/irq-ti-sci-inta.c
> @@ -233,7 +233,7 @@ static struct ti_sci_inta_vint_desc *ti_sci_inta_allo=
c_parent_irq(struct irq_dom
>         INIT_LIST_HEAD(&vint_desc->list);
>
>         parent_node =3D of_irq_find_parent(dev_of_node(&inta->pdev->dev))=
;
> -       parent_fwspec.fwnode =3D of_node_to_fwnode(parent_node);
> +       parent_fwspec.fwnode =3D of_fwnode_handle(parent_node);
>
>         if (of_device_is_compatible(parent_node, "arm,gic-v3")) {
>                 /* Parent is GIC */
> @@ -709,7 +709,7 @@ static int ti_sci_inta_irq_domain_probe(struct platfo=
rm_device *pdev)
>                 return -ENOMEM;
>         }
>
> -       msi_domain =3D ti_sci_inta_msi_create_irq_domain(of_node_to_fwnod=
e(node),
> +       msi_domain =3D ti_sci_inta_msi_create_irq_domain(of_fwnode_handle=
(node),
>                                                 &ti_sci_inta_msi_domain_i=
nfo,
>                                                 domain);
>         if (!msi_domain) {
> diff --git a/drivers/irqchip/irq-ti-sci-intr.c b/drivers/irqchip/irq-ti-s=
ci-intr.c
> index b49a73106c69..686a8f69fd9c 100644
> --- a/drivers/irqchip/irq-ti-sci-intr.c
> +++ b/drivers/irqchip/irq-ti-sci-intr.c
> @@ -149,7 +149,7 @@ static int ti_sci_intr_alloc_parent_irq(struct irq_do=
main *domain,
>                 goto err_irqs;
>
>         parent_node =3D of_irq_find_parent(dev_of_node(intr->dev));
> -       fwspec.fwnode =3D of_node_to_fwnode(parent_node);
> +       fwspec.fwnode =3D of_fwnode_handle(parent_node);
>
>         if (of_device_is_compatible(parent_node, "arm,gic-v3")) {
>                 /* Parent is GIC */
> diff --git a/drivers/irqchip/irq-uniphier-aidet.c b/drivers/irqchip/irq-u=
niphier-aidet.c
> index 601f9343d5b3..6005c2d28dd9 100644
> --- a/drivers/irqchip/irq-uniphier-aidet.c
> +++ b/drivers/irqchip/irq-uniphier-aidet.c
> @@ -188,7 +188,7 @@ static int uniphier_aidet_probe(struct platform_devic=
e *pdev)
>         priv->domain =3D irq_domain_create_hierarchy(
>                                         parent_domain, 0,
>                                         UNIPHIER_AIDET_NR_IRQS,
> -                                       of_node_to_fwnode(dev->of_node),
> +                                       of_fwnode_handle(dev->of_node),
>                                         &uniphier_aidet_domain_ops, priv)=
;
>         if (!priv->domain)
>                 return -ENOMEM;
> --
> 2.49.0
>

