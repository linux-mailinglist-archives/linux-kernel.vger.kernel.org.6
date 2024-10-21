Return-Path: <linux-kernel+bounces-374569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D3D9A6C21
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80F761C22742
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7121F4FDE;
	Mon, 21 Oct 2024 14:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4lh3433"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A1810A1E
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 14:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729521141; cv=none; b=ACAv/kuoLlI/mO+QHtyI6CUY+ceHkEqG1+dUgyvdLgpAnmJC1LyOtAEqCYwqxKZQuClDf+uiY2pdNkOBVRax3gW2Emm1ZkHckWqxPV7EpQbxX25e6e+zk0XCHLh27XY9W/+fEUryUM+YG/O5CeDFjjhyYwWRknJawoN9j4avpm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729521141; c=relaxed/simple;
	bh=a3jT6VqF0crh1CnyCShiIfPG8RtRwrQuE5b7q57SVRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q5m6OjSSpo7XMEJ7uWT8dW1aUgSG6vyK/Z6Ofw2vkoGs2BwTi1T+YWyeE9cwhEfTSqGnSQHWjGL9vzIwKTNJrtJb46C4qP+97VCoKyHgk3tmV74i1RoYsa6agHxHwH7bAq6GqlpRHsGYxEbnMLJZHRLRBzq++iZlLQOPgptnY3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4lh3433; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841A1C4CEE4
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 14:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729521140;
	bh=a3jT6VqF0crh1CnyCShiIfPG8RtRwrQuE5b7q57SVRo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=U4lh3433dLJaBJGPwlxHSEXth7m7ERRfhHUmRMEt/0+7gSf6lRlJVbhCtWbr2ev8z
	 uEa++y3pjrbIst0r/88OSOfbxwsv8v6RGlIV4qb3lA71hr6veOYTHvDHisJM6I7PC5
	 CnoEs7M7fzSHmXyzebh1mKaxXGxCfAyn+BH6QvBPE0QtwYU+A2n0pOzEffwC/4NxWR
	 78uv/iPg3PsIioZqWbt0nmEQ0tEjGd6uZF93cQl+uSH2v8jqXQZKv3gunWwbYKzgVo
	 KvbhxZ64Yg4unskUxVvmUm4N/3fNFVTrRtbWca0M7+LAhgxgC6ThRd9RgVTv3Z4G0g
	 HUW5dtJc+jHWw==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a0cee600aso575057866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 07:32:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWQPgNstNlS20cAC4exOPpYGq5XGSSFJR0ZKBMT+2VaXKdFikZJdsR+VoN+KZFuNU6KCUI6UVjhp0kvWPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmCxOYBrWw2UyLYYxq9GuMRdcpqxcE/v91p1VNmG0pADDF7SmK
	xYq5DphAbYjr4v5QJkOBd3bhn4H0oZoyBjcVYPa2lt/Vj/Z274NUqlFywdCwN5qLX1RoB0M1id1
	Pw8cMBM6iqV57L61iVJ7CXVirfs4=
X-Google-Smtp-Source: AGHT+IFHWkjFEm8gr31/AvZMVMzl3XPvp47P8WspcJyiT0mZYJ29tEkcsIvg4XkT+Chzedpup+usfYv6ZzEA+FZOA8s=
X-Received: by 2002:a17:907:7216:b0:a9a:3ca0:d55a with SMTP id
 a640c23a62f3a-a9a69cd411amr1233595966b.57.1729521138957; Mon, 21 Oct 2024
 07:32:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021080418.644342-1-maobibo@loongson.cn>
In-Reply-To: <20241021080418.644342-1-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 21 Oct 2024 22:32:06 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4anpgfiAnPgm9h-m9pKCW0KUio+E72r1Q3F_0vm+zMRg@mail.gmail.com>
Message-ID: <CAAhV-H4anpgfiAnPgm9h-m9pKCW0KUio+E72r1Q3F_0vm+zMRg@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: Fix cpu hotplug issue
To: Bibo Mao <maobibo@loongson.cn>
Cc: Jianmin Lv <lvjianmin@loongson.cn>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, lixianglai@loongson.cn, 
	WANG Xuerui <kernel@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,

This version still doesn't touch the round-robin method, but it
doesn't matter, I think I misunderstood something since V1...

Please correct me if I'm wrong: For cpus without ACPI_MADT_ENABLED, in
smp_prepare_boot_cpu() the round-robin node ids only apply to
cpu_to_node(), but __cpuid_to_node[] still record the right node ids.
early_cpu_to_node() returns NUMA_NO_NODE not because
__cpuid_to_node[] records NUMA_NO_NODE, but because cpu_logical_map()
< 0.

If the above is correct, we don't need so complicated, because the
correct and simplest way is:
https://lore.kernel.org/loongarch/6b2b3e89-5a46-2d20-3dfb-7aae33839f49@loon=
gson.cn/T/#m950eead5250e5992cc703bbe69622348cecfa465


Huacai

On Mon, Oct 21, 2024 at 4:04=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> On LoongArch system, there are two places to set cpu numa node. One
> is in arch specified function smp_prepare_boot_cpu(), the other is
> in generic function early_numa_node_init(). The latter will overwrite
> the numa node information.
>
> With hot-added cpu without numa information, cpu_logical_map() fails
> to its physical cpuid at beginning since it is not enabled in ACPI
> MADT table. So function early_cpu_to_node() also fails to get its
> numa node for hot-added cpu, and generic function
> early_numa_node_init() will overwrite with incorrect numa node.
>
> APIs topo_get_cpu() and topo_add_cpu() is added here, like other
> architectures logic cpu is allocated when parsing MADT table. When
> parsing SRAT table or hot-add cpu, logic cpu is acquired by searching
> all allocated logical cpu with matched physical id. It solves such
> problems such as:
>   1. Boot cpu is not the first entry in MADT table, the first entry
> will be overwritten with later boot cpu.
>   2. Physical cpu id not presented in MADT table is invalid, in later
> SRAT/hot-add cpu parsing, invalid physical cpu detected is added
>   3. For hot-add cpu, its logic cpu is allocated in MADT table parsing,
> so early_cpu_to_node() can be used for hot-add cpu and cpu_to_node()
> is correct for hot-add cpu.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
> v1 ... v2:
>   1. Like other architectures, allocate logic cpu when parsing MADT table=
.
>   2. Add invalid or duplicated physical cpuid parsing with SRAT table or
> hot-add cpu DSDT information.
> ---
>  arch/loongarch/include/asm/smp.h |  3 ++
>  arch/loongarch/kernel/acpi.c     | 24 ++++++++++------
>  arch/loongarch/kernel/setup.c    | 47 ++++++++++++++++++++++++++++++++
>  arch/loongarch/kernel/smp.c      |  9 +++---
>  4 files changed, 70 insertions(+), 13 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/smp.h b/arch/loongarch/include/as=
m/smp.h
> index 3383c9d24e94..c61b75937a77 100644
> --- a/arch/loongarch/include/asm/smp.h
> +++ b/arch/loongarch/include/asm/smp.h
> @@ -119,4 +119,7 @@ static inline void __cpu_die(unsigned int cpu)
>  #define cpu_logical_map(cpu)   0
>  #endif /* CONFIG_SMP */
>
> +int topo_add_cpu(int physid);
> +int topo_get_cpu(int physid);
> +
>  #endif /* __ASM_SMP_H */
> diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
> index f1a74b80f22c..84d9812d5f38 100644
> --- a/arch/loongarch/kernel/acpi.c
> +++ b/arch/loongarch/kernel/acpi.c
> @@ -78,10 +78,10 @@ static int set_processor_mask(u32 id, u32 flags)
>                 return -ENODEV;
>
>         }
> -       if (cpuid =3D=3D loongson_sysconf.boot_cpu_id)
> -               cpu =3D 0;
> -       else
> -               cpu =3D find_first_zero_bit(cpumask_bits(cpu_present_mask=
), NR_CPUS);
> +
> +       cpu =3D topo_add_cpu(cpuid);
> +       if (cpu < 0)
> +               return -EEXIST;
>
>         if (!cpu_enumerated)
>                 set_cpu_possible(cpu, true);
> @@ -203,8 +203,6 @@ void __init acpi_boot_table_init(void)
>                 goto fdt_earlycon;
>         }
>
> -       loongson_sysconf.boot_cpu_id =3D read_csr_cpuid();
> -
>         /*
>          * Process the Multiple APIC Description Table (MADT), if present
>          */
> @@ -257,7 +255,7 @@ void __init numa_set_distance(int from, int to, int d=
istance)
>  void __init
>  acpi_numa_processor_affinity_init(struct acpi_srat_cpu_affinity *pa)
>  {
> -       int pxm, node;
> +       int pxm, node, cpu;
>
>         if (srat_disabled())
>                 return;
> @@ -286,6 +284,11 @@ acpi_numa_processor_affinity_init(struct acpi_srat_c=
pu_affinity *pa)
>                 return;
>         }
>
> +       cpu =3D topo_get_cpu(pa->apic_id);
> +       /* Check whether apic_id exists in MADT table */
> +       if (cpu < 0)
> +               return;
> +
>         early_numa_add_cpu(pa->apic_id, node);
>
>         set_cpuid_to_node(pa->apic_id, node);
> @@ -324,12 +327,17 @@ int acpi_map_cpu(acpi_handle handle, phys_cpuid_t p=
hysid, u32 acpi_id, int *pcpu
>  {
>         int cpu;
>
> -       cpu =3D set_processor_mask(physid, ACPI_MADT_ENABLED);
> +       cpu =3D topo_get_cpu(physid);
> +       /* Check whether apic_id exists in MADT table */
>         if (cpu < 0) {
>                 pr_info(PREFIX "Unable to map lapic to logical cpu number=
\n");
>                 return cpu;
>         }
>
> +       num_processors++;
> +       set_cpu_present(cpu, true);
> +       __cpu_number_map[physid] =3D cpu;
> +       __cpu_logical_map[cpu] =3D physid;
>         acpi_map_cpu2node(handle, cpu, physid);
>
>         *pcpu =3D cpu;
> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.=
c
> index 00e307203ddb..649e98640076 100644
> --- a/arch/loongarch/kernel/setup.c
> +++ b/arch/loongarch/kernel/setup.c
> @@ -65,6 +65,8 @@ EXPORT_SYMBOL(cpu_data);
>
>  struct loongson_board_info b_info;
>  static const char dmi_empty_string[] =3D "        ";
> +static int possible_cpus;
> +static bool bsp_added;
>
>  /*
>   * Setup information
> @@ -346,10 +348,55 @@ static void __init bootcmdline_init(char **cmdline_=
p)
>         *cmdline_p =3D boot_command_line;
>  }
>
> +int topo_get_cpu(int physid)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < possible_cpus; i++)
> +               if (cpu_logical_map(i) =3D=3D physid)
> +                       break;
> +
> +       if (i =3D=3D possible_cpus)
> +               return -ENOENT;
> +
> +       return i;
> +}
> +
> +int topo_add_cpu(int physid)
> +{
> +       int cpu;
> +
> +       if (!bsp_added && (physid =3D=3D loongson_sysconf.boot_cpu_id)) {
> +               bsp_added =3D true;
> +               return 0;
> +       }
> +
> +       cpu =3D topo_get_cpu(physid);
> +       if (cpu >=3D 0) {
> +               pr_warn("Adding duplicated physical cpuid 0x%x\n", physid=
);
> +               return -EEXIST;
> +       }
> +
> +       if (possible_cpus >=3D nr_cpu_ids)
> +               return -ERANGE;
> +
> +       __cpu_logical_map[possible_cpus] =3D physid;
> +       cpu =3D possible_cpus++;
> +       return cpu;
> +}
> +
> +static void __init topo_init(void)
> +{
> +       loongson_sysconf.boot_cpu_id =3D read_csr_cpuid();
> +       __cpu_logical_map[0] =3D loongson_sysconf.boot_cpu_id;
> +       possible_cpus++;
> +}
> +
>  void __init platform_init(void)
>  {
>         arch_reserve_vmcore();
>         arch_reserve_crashkernel();
> +       topo_init();
>
>  #ifdef CONFIG_ACPI
>         acpi_table_upgrade();
> diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
> index 9afc2d8b3414..a3f466b89179 100644
> --- a/arch/loongarch/kernel/smp.c
> +++ b/arch/loongarch/kernel/smp.c
> @@ -291,10 +291,9 @@ static void __init fdt_smp_setup(void)
>                 if (cpuid >=3D nr_cpu_ids)
>                         continue;
>
> -               if (cpuid =3D=3D loongson_sysconf.boot_cpu_id)
> -                       cpu =3D 0;
> -               else
> -                       cpu =3D find_first_zero_bit(cpumask_bits(cpu_pres=
ent_mask), NR_CPUS);
> +               cpu =3D topo_add_cpu(cpuid);
> +               if (cpu < 0)
> +                       continue;
>
>                 num_processors++;
>                 set_cpu_possible(cpu, true);
> @@ -302,7 +301,7 @@ static void __init fdt_smp_setup(void)
>                 __cpu_number_map[cpuid] =3D cpu;
>                 __cpu_logical_map[cpu] =3D cpuid;
>
> -               early_numa_add_cpu(cpu, 0);
> +               early_numa_add_cpu(cpuid, 0);
>                 set_cpuid_to_node(cpuid, 0);
>         }
>
>
> base-commit: 42f7652d3eb527d03665b09edac47f85fb600924
> --
> 2.39.3
>

