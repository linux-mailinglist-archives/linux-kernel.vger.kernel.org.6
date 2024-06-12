Return-Path: <linux-kernel+bounces-210897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9439049D5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 06:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD5301C20D33
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 04:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB6C2031D;
	Wed, 12 Jun 2024 04:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NA6HMCrn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD7F257D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 04:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718164918; cv=none; b=om6DwbZx+mgSPYh2sMjh5A/4ASsnGy9Vt3tpfViLHSSXHXwnj+d1uY1DLn5zXuuqzHPdIaodOtK2H74xjwGzkwJxbDKEmsgrGMUh3bAoBbVbEH263WXenco7DQdbYTadprAxhMCkECZU8SDqVI+b3I6jHRTuCtjWgTfjD4R2ADM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718164918; c=relaxed/simple;
	bh=gjtyHI4QB+FpgOlio3YAsgP32wZTXCkuSmCH1/dYMRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OA/7ACTJ47ztkugRSU7f+OrgXCigMdSEnmS1nCpj/9lD980Q94wxU0gynoGdV/2ADvz3hPdSUSxiJXlXAHwfNkG//10omOxqtwOQ9iRzIYwEwDIVA/T3C6M0zc8plkKAsXaLcRMdQt3txSBFTt+K+H/cvrdhNg2FiPqLa1/GPcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NA6HMCrn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF0DC4AF1A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 04:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718164918;
	bh=gjtyHI4QB+FpgOlio3YAsgP32wZTXCkuSmCH1/dYMRA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NA6HMCrn/rdNEYHOQXKMWvztT72R+kdx2mgDh39bes6y1IIn2vi5BWA5hZhRYJWwS
	 9AfhXHZ1hJGm3UDloQaTn2Ti9IZvOIenS66KFT0xS6SIslxNWSHbV6gp9s/YIffVN0
	 TxYaO8d065usdG3Rv5glLwzkyGU0sSBLfALTBh3pED9AtvrI0KFKPi6bdAQ0l0uAzr
	 F0kSuQBNNYa1j+3SXAIbgEdf5kvvzfeF3JsPdNzQnisXPe6Cm9GPwitNIpPgrWlj4t
	 PU1tJ0PHGLJzhl2l1/SDmcHEssixJDcu40bbAvMcfE6fsc12Fvk+jp44qRlgcjT+RC
	 +OerYHwH8wK6g==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57a1fe63a96so8334460a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 21:01:58 -0700 (PDT)
X-Gm-Message-State: AOJu0YybyrpH4elZbwEeb9jRmFZOtm876XGNngFNVNfW7mxpjVN0Q9xV
	nUvlRg3LoMEKIAdMcRVdiIz1fyfAeuywgfoFkILC0PDdFWfqV5BhyV9wMTL/08QuluSY5QcZfyN
	hD12TPsGbjcRu5EFuOGyL5C/lHks=
X-Google-Smtp-Source: AGHT+IHw36HvpC+MJUZdbfcsxF7w5XwbQWoQIeecCsksTJli3x90sscnNk1xk7j0TN6+QO2kHnzPrnnqtQcz3WCQRoY=
X-Received: by 2002:a50:955b:0:b0:57c:6248:62b7 with SMTP id
 4fb4d7f45d1cf-57ca9750ce6mr294770a12.13.1718164916807; Tue, 11 Jun 2024
 21:01:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611123348.8374-1-gaosong@loongson.cn>
In-Reply-To: <20240611123348.8374-1-gaosong@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 12 Jun 2024 12:01:45 +0800
X-Gmail-Original-Message-ID: <CAAhV-H58j=VBfhCo0Yb5H-pJ1GSfoM-hBMuW5s_TNHEr6Gx74g@mail.gmail.com>
Message-ID: <CAAhV-H58j=VBfhCo0Yb5H-pJ1GSfoM-hBMuW5s_TNHEr6Gx74g@mail.gmail.com>
Subject: Re: [PATCH v2] irqchip/loongson-eiointc: Add extioi virt extension support
To: Song Gao <gaosong@loongson.cn>
Cc: linux-kernel@vger.kernel.org, jiaxun.yang@flygoat.com, tglx@linutronix.de, 
	maobibo@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Song,

On Tue, Jun 11, 2024 at 8:51=E2=80=AFPM Song Gao <gaosong@loongson.cn> wrot=
e:
>
> Interrupts can be routed to maximal four virtual CPUs with one external
> hardware interrupt. Add the extioi virt extension support so that
> Interrupts can be routed to 256 vcpus on hypervior mode.
>
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
> v2:
> - Simplify commit messages and code.
> - Follow the documented tip tree coding style.
> - Add the virtual extended interrupt model to the documentation.
> - Link to v1: https://lore.kernel.org/all/20240605070229.2569875-1-gaoson=
g@loongson.cn/
>
>  .../arch/loongarch/irq-chip-model.rst         |  28 +++++
>  arch/loongarch/include/asm/irq.h              |   1 +
>  drivers/irqchip/irq-loongson-eiointc.c        | 104 ++++++++++++++----
>  3 files changed, 113 insertions(+), 20 deletions(-)
>
> diff --git a/Documentation/arch/loongarch/irq-chip-model.rst b/Documentat=
ion/arch/loongarch/irq-chip-model.rst
> index 7988f4192363..7c10d070b318 100644
> --- a/Documentation/arch/loongarch/irq-chip-model.rst
> +++ b/Documentation/arch/loongarch/irq-chip-model.rst
> @@ -85,6 +85,34 @@ to CPUINTC directly::
>      | Devices |
>      +---------+
>
> +Virt extended IRQ model
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Use "Virtual extended IRQ model".

> +
> +This model only work on hypervior mode. In this model, IPI (Inter-Proces=
sor Interrupt)
> +and CPU Local Timer interrupt go to CPUINTC directly, CPU UARTS interrup=
ts go to
> +PCH_PIC, while all other devices interrupts go to PCH-PIC/PCH-LPC/PCH-MS=
I and
> +gathered by V-EIOINTC(Virt Extended I/O Interrupt Controller), and then =
go to
> +CPUINTC directly::
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
You need to introduce virtual registers here, since there is no other
place to understand them.

And please also update the Chinese document.

Huacai

>  ACPI-related definitions
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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

