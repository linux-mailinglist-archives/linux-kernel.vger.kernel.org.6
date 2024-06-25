Return-Path: <linux-kernel+bounces-229042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E746916A20
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACA8E1F20FC8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FCD16729D;
	Tue, 25 Jun 2024 14:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQP65cfS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B51BE71
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719325183; cv=none; b=iJvl4rg0LK05gkSuwiae6LoH8GqSxiViuBDg5Ea4ppkr0vHaq6tn0lhPCQbDsSIirmyofz9zhnwzeFgOfw4xXQSk3/xZl0fGmAJ+PJpArmNSRYo+RsfXE3PqRpjko5p8H1KIiPjcPLlDVPO8gNiF9H5LH3E+FTrAVjNtvuC7BsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719325183; c=relaxed/simple;
	bh=+nImJv87mkQwaDLLGPgqiEWQb8B/L+is0Fe/EE7EMaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O6PHbRNgU1rng84Jc1tUCPi2uiJWhGDM1qRcFISigHiNR5DjY8Xu8fv8NewIbVHLD1ZwuvnBcNsjKbtwrsNKCDMm6gisb3wVr90dH4hcK4fPmlD/8sNmA5llBoRnARXTv0BwBpAjBuQnUmTqDA23qXWdtpruuNXsrp715uy+pSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQP65cfS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02144C4AF09
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719325183;
	bh=+nImJv87mkQwaDLLGPgqiEWQb8B/L+is0Fe/EE7EMaE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XQP65cfSd+BiCVa9Xg9S10ZTU5o0CNcNEmVzO0+Bc1+Npxau6zCIRbaVp0d5LnALG
	 xWL5YEu0kniko2x2sZEHGD9Gvgoh1gH/6Punogi3++5BWfs87DGca5VsOGpeg9UIts
	 YQM/VVLX98aGWB+jn/6pP2f3dWm21XePYdJj1SgSwEGcr8hmhtDGd0e5dacyzuZeZL
	 u1XPqQZwFyK09Wp7QE4DFR3ioPfeCnaeUWzEFYwYFPiVFfWIKoxr47qajfFJLqhM6E
	 oHwP839TlhT9wPeO5QB47nggfbOMFu34l+dE6rpFIONMUqaAjsAb8F874LsH7LyGs/
	 3iIba7dZGIH1A==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a72420e84feso406134966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 07:19:42 -0700 (PDT)
X-Gm-Message-State: AOJu0YzFlW9AdeTkAF/BLFWDQaWIXUiHbnrACY+SZ2h1Al2khiKMcAjJ
	+iatkWkGBzrIEwDvY290EBIRDJ1oH9x+ao/B9RO/xZz1BVjRzzso+jclMH53lNQd8RK4qXtRcPN
	SNpkvkMrxeqbH7A1Tv/VEokto9fM=
X-Google-Smtp-Source: AGHT+IE0YdY7RKNhGoJtg4xTUl/yPKKgNYAG3ZdG+jW1uCbwWUaFzb93ruEAGDA+oNlmIK7g2zSpnV6nG52jkdzDrjs=
X-Received: by 2002:a17:906:6057:b0:a71:bf5a:3418 with SMTP id
 a640c23a62f3a-a7245c809demr577537366b.53.1719325181473; Tue, 25 Jun 2024
 07:19:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624084410.1026648-1-gaosong@loongson.cn>
In-Reply-To: <20240624084410.1026648-1-gaosong@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 25 Jun 2024 22:19:35 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4KcovRtPqXQfn0TJ1gpM6Hs5=D0Q3KmYi_YYC0BATfEA@mail.gmail.com>
Message-ID: <CAAhV-H4KcovRtPqXQfn0TJ1gpM6Hs5=D0Q3KmYi_YYC0BATfEA@mail.gmail.com>
Subject: Re: [PATCH v3] irqchip/loongson-eiointc: Add extioi virt extension support
To: Song Gao <gaosong@loongson.cn>
Cc: linux-kernel@vger.kernel.org, jiaxun.yang@flygoat.com, tglx@linutronix.de, 
	maobibo@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Song,

On Mon, Jun 24, 2024 at 5:01=E2=80=AFPM Song Gao <gaosong@loongson.cn> wrot=
e:
>
> Interrupts can be routed to maximal four virtual CPUs with one external
> hardware interrupt. Add the extioi virt extension support so that
> Interrupts can be routed to 256 vcpus on hypervior mode.
>
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
> v3:
> - Introduce V-EIOINTC and update the Chinese document.
> - Link to v2: https://lore.kernel.org/all/20240611123348.8374-1-gaosong@l=
oongson.cn/
>
> v2:
> - Simplify commit messages and code.
> - Follow the documented tip tree coding style.
> - Add the virtual extended interrupt model to the documentation.
> - Link to v1: https://lore.kernel.org/all/20240605070229.2569875-1-gaoson=
g@loongson.cn/
>
>  .../arch/loongarch/irq-chip-model.rst         |  32 ++++++
>  .../zh_CN/arch/loongarch/irq-chip-model.rst   |  29 +++++
>  arch/loongarch/include/asm/irq.h              |   1 +
>  drivers/irqchip/irq-loongson-eiointc.c        | 104 ++++++++++++++----
>  4 files changed, 146 insertions(+), 20 deletions(-)
>
> diff --git a/Documentation/arch/loongarch/irq-chip-model.rst b/Documentat=
ion/arch/loongarch/irq-chip-model.rst
> index 7988f4192363..36435f29e451 100644
> --- a/Documentation/arch/loongarch/irq-chip-model.rst
> +++ b/Documentation/arch/loongarch/irq-chip-model.rst
> @@ -85,6 +85,38 @@ to CPUINTC directly::
>      | Devices |
>      +---------+
>
> +Virtual extended IRQ model
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +
> +In this model, IPI (Inter-Processor Interrupt) and CPU Local Timer inter=
rupt
> +go to CPUINTC directly, CPU UARTS interrupts go to PCH-PIC, while all ot=
her
> +devices interrupts go to PCH-PIC/PCH-MSI and gathered by V-EIOINTC (Virt=
ual
> +Extended I/O Interrupt Controller), and then go to CPUINTC directly::
> +
> +       +-----+    +-------------------+     +-------+
> +       | IPI |--> | CPUINTC(0-255vcpu)| <-- | Timer |
> +       +-----+    +-------------------+     +-------+
> +                            ^
> +                            |
> +                      +-----------+
> +                      | V-EIOINTC |
> +                      +-----------+
> +                       ^         ^
> +                       |         |
> +                +---------+ +---------+
> +                | PCH-PIC | | PCH-MSI |
> +                +---------+ +---------+
> +                  ^      ^          ^
> +                  |      |          |
> +           +--------+ +---------+ +---------+
> +           | UARTs  | | Devices | | Devices |
> +           +--------+ +---------+ +---------+
> +
> +
> +V-EIOINTC (Virtual Extended I/O Interrupt Controller) is an extension of=
 EIOINTC,
> +it only works in hypervior mode. Interrupts can be routed to up to four =
virtual
> +cpus via EIOINTC, but interrupts can be routed to up to 256 virtual cpus=
 via V-EIOINTC.

If possible, it is a little better to introduce EXTIOI_VIRT_FEATURES
and EXTIOI_VIRT_CONFIG here.

> +
>  ACPI-related definitions
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> diff --git a/Documentation/translations/zh_CN/arch/loongarch/irq-chip-mod=
el.rst b/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.rst
> index f1e9ab18206c..f211ed192bfc 100644
> --- a/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.rst
> +++ b/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.rst
> @@ -87,6 +87,35 @@ PCH-LPC/PCH-MSI=EF=BC=8C=E7=84=B6=E5=90=8E=E8=A2=ABEIO=
INTC=E7=BB=9F=E4=B8=80=E6=94=B6=E9=9B=86=EF=BC=8C=E5=86=8D=E7=9B=B4=E6=8E=
=A5=E5=88=B0=E8=BE=BECPUINTC::
>      | Devices |
>      +---------+
>
> +=E8=99=9A=E6=8B=9F=E6=89=A9=E5=B1=95IRQ=E6=A8=A1=E5=9E=8B
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +=E5=9C=A8=E8=BF=99=E7=A7=8D=E6=A8=A1=E5=9E=8B=E9=87=8C=E9=9D=A2, IPI(Int=
er-Processor Interrupt) =E5=92=8CCPU=E6=9C=AC=E5=9C=B0=E6=97=B6=E9=92=9F=E4=
=B8=AD=E6=96=AD=E7=9B=B4=E6=8E=A5=E5=8F=91=E9=80=81=E5=88=B0CPUINTC,
> +CPU=E4=B8=B2=E5=8F=A3 (UARTs) =E4=B8=AD=E6=96=AD=E5=8F=91=E9=80=81=E5=88=
=B0PCH-PIC, =E8=80=8C=E5=85=B6=E4=BB=96=E6=89=80=E6=9C=89=E8=AE=BE=E5=A4=87=
=E7=9A=84=E4=B8=AD=E6=96=AD=E5=88=99=E5=88=86=E5=88=AB=E5=8F=91=E9=80=81=E5=
=88=B0=E6=89=80=E8=BF=9E=E6=8E=A5=E7=9A=84PCH_PIC/
> +PCH-MSI, =E7=84=B6=E5=90=8EV-EIOINTC=E7=BB=9F=E4=B8=80=E6=94=B6=E9=9B=86=
=EF=BC=8C=E5=86=8D=E7=9B=B4=E6=8E=A5=E5=88=B0=E8=BE=BECPUINTC::
> +
> +        +-----+    +-------------------+     +-------+
> +        | IPI |--> | CPUINTC(0-255vcpu)| <-- | Timer |
> +        +-----+    +-------------------+     +-------+
> +                             ^
> +                             |
> +                       +-----------+
> +                       | V-EIOINTC |
> +                       +-----------+
> +                        ^         ^
> +                        |         |
> +                 +---------+ +---------+
> +                 | PCH-PIC | | PCH-MSI |
> +                 +---------+ +---------+
> +                   ^      ^          ^
> +                   |      |          |
> +            +--------+ +---------+ +---------+
> +            | UARTs  | | Devices | | Devices |
> +            +--------+ +---------+ +---------+
> +
> +V-EIOINTC =E6=98=AFEIOINTC=E7=9A=84=E6=89=A9=E5=B1=95, =E4=BB=85=E5=B7=
=A5=E4=BD=9C=E5=9C=A8hyperisor=E6=A8=A1=E5=BC=8F=E4=B8=8B, =E4=B8=AD=E6=96=
=AD=E7=BB=8FEIOINTC=E6=9C=80=E5=A4=9A=E5=8F=AF=E4=B8=AA=E8=B7=AF=E7=94=B1=
=E5=88=B0=EF=BC=94=E4=B8=AA
> +=E8=99=9A=E6=8B=9Fcpu. =E4=BD=86=E4=B8=AD=E6=96=AD=E7=BB=8FV-EIOINTC=E6=
=9C=80=E5=A4=9A=E5=8F=AF=E4=B8=AA=E8=B7=AF=E7=94=B1=E5=88=B0256=E4=B8=AA=E8=
=99=9A=E6=8B=9Fcpu.
> +
>  ACPI=E7=9B=B8=E5=85=B3=E7=9A=84=E5=AE=9A=E4=B9=89
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/as=
m/irq.h
> index 480418bc5071..c97a7ab0e56f 100644
> --- a/arch/loongarch/include/asm/irq.h
> +++ b/arch/loongarch/include/asm/irq.h
> @@ -53,6 +53,7 @@ struct acpi_vector_group {
>  extern struct acpi_vector_group pch_group[MAX_IO_PICS];
>  extern struct acpi_vector_group msi_group[MAX_IO_PICS];
>
> +#define MAX_CORES_PER_EIO_NODE 256
Rename it to CORES_PER_VEIO_NODE and put it after CORES_PER_EIO_NODE is bet=
ter.

>  #define CORES_PER_EIO_NODE     4
>
>  #define LOONGSON_CPU_UART0_VEC         10 /* CPU UART0 */
> diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq=
-loongson-eiointc.c
> index c7ddebf312ad..430fda9e8ce5 100644
> --- a/drivers/irqchip/irq-loongson-eiointc.c
> +++ b/drivers/irqchip/irq-loongson-eiointc.c
> @@ -23,15 +23,43 @@
>  #define EIOINTC_REG_ISR                0x1800
>  #define EIOINTC_REG_ROUTE      0x1c00
>
> +#define EXTIOI_VIRT_FEATURES           0x40000000
> +#define  EXTIOI_HAS_VIRT_EXTENSION     BIT(0)
> +#define  EXTIOI_HAS_ENABLE_OPTION      BIT(1)
> +#define  EXTIOI_HAS_INT_ENCODE         BIT(2)
> +#define  EXTIOI_HAS_CPU_ENCODE         BIT(3)
> +#define EXTIOI_VIRT_CONFIG             0x40000004
> +#define  EXTIOI_ENABLE                 BIT(1)
> +#define  EXTIOI_ENABLE_INT_ENCODE      BIT(2)
> +#define  EXTIOI_ENABLE_CPU_ENCODE      BIT(3)
> +
>  #define VEC_REG_COUNT          4
>  #define VEC_COUNT_PER_REG      64
>  #define VEC_COUNT              (VEC_REG_COUNT * VEC_COUNT_PER_REG)
>  #define VEC_REG_IDX(irq_id)    ((irq_id) / VEC_COUNT_PER_REG)
>  #define VEC_REG_BIT(irq_id)     ((irq_id) % VEC_COUNT_PER_REG)
>  #define EIOINTC_ALL_ENABLE     0xffffffff
> +#define EIOINTC_ALL_ENABLE_VEC_MASK(vector)    \
> +       (EIOINTC_ALL_ENABLE & ~BIT(vector & 0x1F))
> +#define EIOINTC_REG_ENABLE_VEC(vector)         \
> +       (EIOINTC_REG_ENABLE + ((vector >> 5) << 2))
>
>  #define MAX_EIO_NODES          (NR_CPUS / CORES_PER_EIO_NODE)
>
> +/*
> + * Routing registers contain four vectors and have an offset of four to
> + * the base. The routing information is 8 bit wide.
> + */
> +
> +#define EIOINTC_REG_ROUTE_VEC(vector)          \
> +       (EIOINTC_REG_ROUTE + (vector & ~0x03))
> +
> +#define EIOINTC_REG_ROUTE_VEC_SHIFT(vector)    \
> +       ((vector & 0x03) << 3)
> +
> +#define EIOINTC_REG_ROUTE_VEC_MASK(vector)     \
> +       (0xff << EIOINTC_REG_ROUTE_VEC_SHIFT(vector))
Line break is unnecessary for these macros.

> +
>  static int nr_pics;
>
>  struct eiointc_priv {
> @@ -41,6 +69,7 @@ struct eiointc_priv {
>         cpumask_t               cpuspan_map;
>         struct fwnode_handle    *domain_handle;
>         struct irq_domain       *eiointc_domain;
> +       bool                    cpu_encoded;
>  };
>
>  static struct eiointc_priv *eiointc_priv[MAX_IO_PICS];
> @@ -56,7 +85,9 @@ static void eiointc_enable(void)
>
>  static int cpu_to_eio_node(int cpu)
>  {
> -       return cpu_logical_map(cpu) / CORES_PER_EIO_NODE;
> +       int cores =3D cpu_has_hypervisor ? MAX_CORES_PER_EIO_NODE : CORES=
_PER_EIO_NODE;
I think the correct condition is not cpu_has_hypervisor, but something
read from the virtual registers?

Huacai
> +
> +       return cpu_logical_map(cpu) / cores;
>  }
>
>  #ifdef CONFIG_SMP
> @@ -88,6 +119,16 @@ static void eiointc_set_irq_route(int pos, unsigned i=
nt cpu, unsigned int mnode,
>
>  static DEFINE_RAW_SPINLOCK(affinity_lock);
>
> +static void virt_extioi_set_irq_route(unsigned int vector, unsigned int =
cpu)
> +{
> +       unsigned long reg =3D EIOINTC_REG_ROUTE_VEC(vector);
> +       u32 data =3D iocsr_read32(reg);
> +
> +       data &=3D ~EIOINTC_REG_ROUTE_VEC_MASK(vector);
> +       data |=3D cpu_logical_map(cpu) << EIOINTC_REG_ROUTE_VEC_SHIFT(vec=
tor);
> +       iocsr_write32(data, reg);
> +}
> +
>  static int eiointc_set_irq_affinity(struct irq_data *d, const struct cpu=
mask *affinity, bool force)
>  {
>         unsigned int cpu;
> @@ -104,18 +145,24 @@ static int eiointc_set_irq_affinity(struct irq_data=
 *d, const struct cpumask *af
>         }
>
>         vector =3D d->hwirq;
> -       regaddr =3D EIOINTC_REG_ENABLE + ((vector >> 5) << 2);
> -
> -       /* Mask target vector */
> -       csr_any_send(regaddr, EIOINTC_ALL_ENABLE & (~BIT(vector & 0x1F)),
> -                       0x0, priv->node * CORES_PER_EIO_NODE);
> -
> -       /* Set route for target vector */
> -       eiointc_set_irq_route(vector, cpu, priv->node, &priv->node_map);
> -
> -       /* Unmask target vector */
> -       csr_any_send(regaddr, EIOINTC_ALL_ENABLE,
> -                       0x0, priv->node * CORES_PER_EIO_NODE);
> +       regaddr =3D EIOINTC_REG_ENABLE_VEC(vector);
> +
> +       if (priv->cpu_encoded) {
> +               iocsr_write32(EIOINTC_ALL_ENABLE_VEC_MASK(vector), regadd=
r);
> +               virt_extioi_set_irq_route(vector, cpu);
> +               iocsr_write32(EIOINTC_ALL_ENABLE, regaddr);
> +       } else {
> +               /* Mask target vector */
> +               csr_any_send(regaddr, EIOINTC_ALL_ENABLE_VEC_MASK(vector)=
,
> +                            0x0, priv->node * CORES_PER_EIO_NODE);
> +
> +               /* Set route for target vector */
> +               eiointc_set_irq_route(vector, cpu, priv->node, &priv->nod=
e_map);
> +
> +               /* Unmask target vector */
> +               csr_any_send(regaddr, EIOINTC_ALL_ENABLE,
> +                            0x0, priv->node * CORES_PER_EIO_NODE);
> +       }
>
>         irq_data_update_effective_affinity(d, cpumask_of(cpu));
>
> @@ -139,17 +186,20 @@ static int eiointc_index(int node)
>
>  static int eiointc_router_init(unsigned int cpu)
>  {
> -       int i, bit;
> -       uint32_t data;
> -       uint32_t node =3D cpu_to_eio_node(cpu);
> -       int index =3D eiointc_index(node);
> +       uint32_t data, node;
> +       int i, bit, cores, index;
> +
> +       node =3D cpu_to_eio_node(cpu);
> +       index =3D eiointc_index(node);
>
>         if (index < 0) {
>                 pr_err("Error: invalid nodemap!\n");
> -               return -1;
> +               return -EINVAL;
>         }
>
> -       if ((cpu_logical_map(cpu) % CORES_PER_EIO_NODE) =3D=3D 0) {
> +       cores =3D (cpu_has_hypervisor ? MAX_CORES_PER_EIO_NODE : CORES_PE=
R_EIO_NODE);
> +
> +       if ((cpu_logical_map(cpu) % cores) =3D=3D 0) {
>                 eiointc_enable();
>
>                 for (i =3D 0; i < eiointc_priv[0]->vec_count / 32; i++) {
> @@ -165,7 +215,9 @@ static int eiointc_router_init(unsigned int cpu)
>
>                 for (i =3D 0; i < eiointc_priv[0]->vec_count / 4; i++) {
>                         /* Route to Node-0 Core-0 */
> -                       if (index =3D=3D 0)
> +                       if (eiointc_priv[index]->cpu_encoded)
> +                               bit =3D cpu_logical_map(0);
> +                       else if (index =3D=3D 0)
>                                 bit =3D BIT(cpu_logical_map(0));
>                         else
>                                 bit =3D (eiointc_priv[index]->node << 4) =
| 1;
> @@ -369,6 +421,7 @@ static int __init acpi_cascade_irqdomain_init(void)
>  static int __init eiointc_init(struct eiointc_priv *priv, int parent_irq=
,
>                                u64 node_map)
>  {
> +       u32 val;
>         int i;
>
>         node_map =3D node_map ? node_map : -1ULL;
> @@ -389,6 +442,17 @@ static int __init eiointc_init(struct eiointc_priv *=
priv, int parent_irq,
>                 return -ENOMEM;
>         }
>
> +       if (cpu_has_hypervisor) {
> +               val =3D iocsr_read32(EXTIOI_VIRT_FEATURES);
> +               if (val & BIT(EXTIOI_HAS_CPU_ENCODE)) {
> +                       val =3D iocsr_read32(EXTIOI_VIRT_CONFIG);
> +                       val |=3D BIT(EXTIOI_ENABLE_CPU_ENCODE);
> +                       iocsr_write32(val, EXTIOI_VIRT_CONFIG);
> +                       priv->cpu_encoded =3D true;
> +                       pr_info("loongson-extioi: enable cpu encodig \n")=
;
> +               }
> +       }
> +
>         eiointc_priv[nr_pics++] =3D priv;
>         eiointc_router_init(0);
>         irq_set_chained_handler_and_data(parent_irq, eiointc_irq_dispatch=
, priv);
> --
> 2.39.3
>

