Return-Path: <linux-kernel+bounces-386689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD829B46FC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82788B227B6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5AA204924;
	Tue, 29 Oct 2024 10:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+Y42L2R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDB117A58F
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730198177; cv=none; b=HEpbMEefwhjhA7bWn3BpaEO8kkrY0bgi/VvhT0BV9sGgemMo3Fa5rtoRDqKqsqny7hZJVJiDYQYO5HqABruWWz5vWv5A38hUnWWpjAKm3HVqed5I1BtHK2lt9J/PIAIf1ouxYTT5PqsFaPIVmq/ayIM2eliViPD3VcePbSY358E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730198177; c=relaxed/simple;
	bh=VOOiITcAay3xjPgGq0lXI3S/tyqKH+PnoeC/YgAiolg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PL5hYt5/us1DOHW5kKeLT5pTUiF6MPfOK/Mg5u9hmG3aNI5qDyKajAr4HjzIhFxfS3KgzDNGWrrRYepMYEitlTM3QqinBSGE0KAASyfy59fOSPmE0/x2x5LH67B5pEurur9wR5/AVchog1Blk8XZTLpgmsZHiqk3Y++/VT2fR+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+Y42L2R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A793C4AF0B
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730198177;
	bh=VOOiITcAay3xjPgGq0lXI3S/tyqKH+PnoeC/YgAiolg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=V+Y42L2R2Z7KMm1TLUVVycRPstT6csX5+nzQU0WWfzz1XSu5kmH7i4vVvHY8QixxQ
	 kiN19h4iDkWXOTxymhb7WmjoZSC44PrvDCEqnve1zy19+BhdXEwfN047OHUFEWdUyt
	 mqjkLmyHvFCNZ0Zok/JOO6rEABiZRz5tdAJIaDsFM7keegtQhBUS5Jyy5iTfa2/p2B
	 TPJ/Ay0Xmd4QrykPw1l8o87aueAqPpnKVBGDRP85FV7CT8/HMSooHXLrXvopX1SfXV
	 kgeCfAe+ex5uehAXYLNSTZ4XX7iKpJCAlJXNphkpOC0/21opltf6CeOaN/sz/+m1Ba
	 Ja/iGmufOlAjg==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a26a5d6bfso812746366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:36:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWStgLu3eLX8h59rXz/8WVZXKcY06BFqf1K652uItgA1PH9O4LamCKCT9f2XGHcj+NMdfSEtgWXCUUmup0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcab8BSkQrL6c2CaIMSp6vlkMQE6576p+pOOamNGhXcYnEZElV
	HfaPwcpP1r2q0eQQooQK0v2YhNfnT5XMdC2dXKS7kUSFMW6uREaFclrUoJAmsQc2csEPWCJ4AVH
	U8Q/qFJlOEnZCWEmDyIE29xr9kck=
X-Google-Smtp-Source: AGHT+IHNl8DkiKadgu0GU30lr0RHrN4LFN4yROoo+h5jwOMa2Lb8C+/ApeZDw5+cm0asUUceO3DLw1mpnRfPpykKcDA=
X-Received: by 2002:a17:907:728e:b0:a99:389a:63c2 with SMTP id
 a640c23a62f3a-a9de61997d9mr1111132766b.62.1730198175946; Tue, 29 Oct 2024
 03:36:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021080418.644342-1-maobibo@loongson.cn> <CAAhV-H4anpgfiAnPgm9h-m9pKCW0KUio+E72r1Q3F_0vm+zMRg@mail.gmail.com>
 <8c55c680-48c8-0ba3-c2a1-56dc72929a8d@loongson.cn> <CAAhV-H4wD5fGVgxwmRVpRgvQ-jyUY0t=ewJANbe50vj9_TZDUQ@mail.gmail.com>
 <f7ab6ec1-7a49-2764-7c19-9949ad508e2e@loongson.cn>
In-Reply-To: <f7ab6ec1-7a49-2764-7c19-9949ad508e2e@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 29 Oct 2024 18:36:03 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6+rE_7P_C0MaWzXToVcPqZQX0YMPnhyZV7Pp6aQ01mCQ@mail.gmail.com>
Message-ID: <CAAhV-H6+rE_7P_C0MaWzXToVcPqZQX0YMPnhyZV7Pp6aQ01mCQ@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: Fix cpu hotplug issue
To: maobibo <maobibo@loongson.cn>
Cc: Jianmin Lv <lvjianmin@loongson.cn>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, lixianglai@loongson.cn, 
	WANG Xuerui <kernel@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 8:38=E2=80=AFPM maobibo <maobibo@loongson.cn> wrote=
:
>
> Hi Huacai,
>
> On 2024/10/22 =E4=B8=8A=E5=8D=889:31, Huacai Chen wrote:
> > On Tue, Oct 22, 2024 at 9:17=E2=80=AFAM maobibo <maobibo@loongson.cn> w=
rote:
> >>
> >>
> >>
> >> On 2024/10/21 =E4=B8=8B=E5=8D=8810:32, Huacai Chen wrote:
> >>> Hi, Bibo,
> >>>
> >>> This version still doesn't touch the round-robin method, but it
> >>> doesn't matter, I think I misunderstood something since V1...
> >> I do not understand why round-robin method need be modified, SRAT may =
be
> >> disabled with general function disable_srat(). Then round-robin method
> >> is required.
> > I don't mean round-robin should be modified, I mean I misunderstand rou=
nd-robin.
> >
> >>
> >>>
> >>> Please correct me if I'm wrong: For cpus without ACPI_MADT_ENABLED, i=
n
> >>> smp_prepare_boot_cpu() the round-robin node ids only apply to
> >>> cpu_to_node(), but __cpuid_to_node[] still record the right node ids.
> >>> early_cpu_to_node() returns NUMA_NO_NODE not because
> >>> __cpuid_to_node[] records NUMA_NO_NODE, but because cpu_logical_map()
> >>> < 0.
> >>>
> >>> If the above is correct, we don't need so complicated, because the
> >>> correct and simplest way is:
> >>> https://lore.kernel.org/loongarch/6b2b3e89-5a46-2d20-3dfb-7aae33839f4=
9@loongson.cn/T/#m950eead5250e5992cc703bbe69622348cecfa465
> >>>
> >> It works also. Only that LoongArch kernel parsing about SRAT/MADT is
> >> badly. If you do not mind, I do not mind neither. It is not my duty fo=
r
> >> kernel side.
> > Yes, I don't mind, please use that simplest way.
> There is another problem with the simple way. eiointc reports error when
> cpu is online. The error message is:
>    Loongson-64bit Processor probed (LA464 Core)
>    CPU2 revision is: 0014c010 (Loongson-64bit)
>    FPU2 revision is: 00000001
>    eiointc: Error: invalid nodemap!
>    CPU 2 UP state irqchip/loongarch/eiointc:starting (100) failed (-1)
>
> The problem is that node_map of eiointc is problematic,
>
>
> static int cpu_to_eio_node(int cpu)
> {
>          return cpu_logical_map(cpu) / CORES_PER_EIO_NODE;
> }
>
> static int __init eiointc_init(struct eiointc_priv *priv, int parent_irq,
>                                 u64 node_map)
> {
>          int i;
>
>          node_map =3D node_map ? node_map : -1ULL;
>          for_each_possible_cpu(i) {
>                  if (node_map & (1ULL << (cpu_to_eio_node(i)))) {
>                          node_set(cpu_to_eio_node(i), priv->node_map);
>           ...
> The cause is that for possible not present cpu, *cpu_logical_map(cpu)*
> is -1, cpu_to_eio_node(i) will be equal to -1, so node_map of eiointc is
> problematic.
The error message seems from eiointc_router_init(), but it is a little
strange. Physical hot-add should be before logical hot-add. So
acpi_map_cpu() is before cpu_up(). acpi_map_cpu() calls
set_processor_mask() to setup logical-physical mapping, so in
eiointc_router_init() which is called by cpu_up(), cpu_logical_map()
should work well.

Maybe in your case a whole node is hot-added? I don't think the
eiointc design can work with this case...

>
> So cpu_logical_map(cpu) should be set during MADT parsing even if it is
> not enabled at beginning, it should not be set at hotplug runtime.
This will cause the logical cpu number be not continuous after boot.
Physical numbers have no requirement, but logical numbers should be
continuous.

Huacai

>
> Regards
> Bibo Mao
>
>
> >
> > Huacai
> >
> >>
> >> Bibo Mao
> >>>
> >>> Huacai
> >>>
> >>> On Mon, Oct 21, 2024 at 4:04=E2=80=AFPM Bibo Mao <maobibo@loongson.cn=
> wrote:
> >>>>
> >>>> On LoongArch system, there are two places to set cpu numa node. One
> >>>> is in arch specified function smp_prepare_boot_cpu(), the other is
> >>>> in generic function early_numa_node_init(). The latter will overwrit=
e
> >>>> the numa node information.
> >>>>
> >>>> With hot-added cpu without numa information, cpu_logical_map() fails
> >>>> to its physical cpuid at beginning since it is not enabled in ACPI
> >>>> MADT table. So function early_cpu_to_node() also fails to get its
> >>>> numa node for hot-added cpu, and generic function
> >>>> early_numa_node_init() will overwrite with incorrect numa node.
> >>>>
> >>>> APIs topo_get_cpu() and topo_add_cpu() is added here, like other
> >>>> architectures logic cpu is allocated when parsing MADT table. When
> >>>> parsing SRAT table or hot-add cpu, logic cpu is acquired by searchin=
g
> >>>> all allocated logical cpu with matched physical id. It solves such
> >>>> problems such as:
> >>>>     1. Boot cpu is not the first entry in MADT table, the first entr=
y
> >>>> will be overwritten with later boot cpu.
> >>>>     2. Physical cpu id not presented in MADT table is invalid, in la=
ter
> >>>> SRAT/hot-add cpu parsing, invalid physical cpu detected is added
> >>>>     3. For hot-add cpu, its logic cpu is allocated in MADT table par=
sing,
> >>>> so early_cpu_to_node() can be used for hot-add cpu and cpu_to_node()
> >>>> is correct for hot-add cpu.
> >>>>
> >>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >>>> ---
> >>>> v1 ... v2:
> >>>>     1. Like other architectures, allocate logic cpu when parsing MAD=
T table.
> >>>>     2. Add invalid or duplicated physical cpuid parsing with SRAT ta=
ble or
> >>>> hot-add cpu DSDT information.
> >>>> ---
> >>>>    arch/loongarch/include/asm/smp.h |  3 ++
> >>>>    arch/loongarch/kernel/acpi.c     | 24 ++++++++++------
> >>>>    arch/loongarch/kernel/setup.c    | 47 +++++++++++++++++++++++++++=
+++++
> >>>>    arch/loongarch/kernel/smp.c      |  9 +++---
> >>>>    4 files changed, 70 insertions(+), 13 deletions(-)
> >>>>
> >>>> diff --git a/arch/loongarch/include/asm/smp.h b/arch/loongarch/inclu=
de/asm/smp.h
> >>>> index 3383c9d24e94..c61b75937a77 100644
> >>>> --- a/arch/loongarch/include/asm/smp.h
> >>>> +++ b/arch/loongarch/include/asm/smp.h
> >>>> @@ -119,4 +119,7 @@ static inline void __cpu_die(unsigned int cpu)
> >>>>    #define cpu_logical_map(cpu)   0
> >>>>    #endif /* CONFIG_SMP */
> >>>>
> >>>> +int topo_add_cpu(int physid);
> >>>> +int topo_get_cpu(int physid);
> >>>> +
> >>>>    #endif /* __ASM_SMP_H */
> >>>> diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/ac=
pi.c
> >>>> index f1a74b80f22c..84d9812d5f38 100644
> >>>> --- a/arch/loongarch/kernel/acpi.c
> >>>> +++ b/arch/loongarch/kernel/acpi.c
> >>>> @@ -78,10 +78,10 @@ static int set_processor_mask(u32 id, u32 flags)
> >>>>                   return -ENODEV;
> >>>>
> >>>>           }
> >>>> -       if (cpuid =3D=3D loongson_sysconf.boot_cpu_id)
> >>>> -               cpu =3D 0;
> >>>> -       else
> >>>> -               cpu =3D find_first_zero_bit(cpumask_bits(cpu_present=
_mask), NR_CPUS);
> >>>> +
> >>>> +       cpu =3D topo_add_cpu(cpuid);
> >>>> +       if (cpu < 0)
> >>>> +               return -EEXIST;
> >>>>
> >>>>           if (!cpu_enumerated)
> >>>>                   set_cpu_possible(cpu, true);
> >>>> @@ -203,8 +203,6 @@ void __init acpi_boot_table_init(void)
> >>>>                   goto fdt_earlycon;
> >>>>           }
> >>>>
> >>>> -       loongson_sysconf.boot_cpu_id =3D read_csr_cpuid();
> >>>> -
> >>>>           /*
> >>>>            * Process the Multiple APIC Description Table (MADT), if =
present
> >>>>            */
> >>>> @@ -257,7 +255,7 @@ void __init numa_set_distance(int from, int to, =
int distance)
> >>>>    void __init
> >>>>    acpi_numa_processor_affinity_init(struct acpi_srat_cpu_affinity *=
pa)
> >>>>    {
> >>>> -       int pxm, node;
> >>>> +       int pxm, node, cpu;
> >>>>
> >>>>           if (srat_disabled())
> >>>>                   return;
> >>>> @@ -286,6 +284,11 @@ acpi_numa_processor_affinity_init(struct acpi_s=
rat_cpu_affinity *pa)
> >>>>                   return;
> >>>>           }
> >>>>
> >>>> +       cpu =3D topo_get_cpu(pa->apic_id);
> >>>> +       /* Check whether apic_id exists in MADT table */
> >>>> +       if (cpu < 0)
> >>>> +               return;
> >>>> +
> >>>>           early_numa_add_cpu(pa->apic_id, node);
> >>>>
> >>>>           set_cpuid_to_node(pa->apic_id, node);
> >>>> @@ -324,12 +327,17 @@ int acpi_map_cpu(acpi_handle handle, phys_cpui=
d_t physid, u32 acpi_id, int *pcpu
> >>>>    {
> >>>>           int cpu;
> >>>>
> >>>> -       cpu =3D set_processor_mask(physid, ACPI_MADT_ENABLED);
> >>>> +       cpu =3D topo_get_cpu(physid);
> >>>> +       /* Check whether apic_id exists in MADT table */
> >>>>           if (cpu < 0) {
> >>>>                   pr_info(PREFIX "Unable to map lapic to logical cpu=
 number\n");
> >>>>                   return cpu;
> >>>>           }
> >>>>
> >>>> +       num_processors++;
> >>>> +       set_cpu_present(cpu, true);
> >>>> +       __cpu_number_map[physid] =3D cpu;
> >>>> +       __cpu_logical_map[cpu] =3D physid;
> >>>>           acpi_map_cpu2node(handle, cpu, physid);
> >>>>
> >>>>           *pcpu =3D cpu;
> >>>> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/s=
etup.c
> >>>> index 00e307203ddb..649e98640076 100644
> >>>> --- a/arch/loongarch/kernel/setup.c
> >>>> +++ b/arch/loongarch/kernel/setup.c
> >>>> @@ -65,6 +65,8 @@ EXPORT_SYMBOL(cpu_data);
> >>>>
> >>>>    struct loongson_board_info b_info;
> >>>>    static const char dmi_empty_string[] =3D "        ";
> >>>> +static int possible_cpus;
> >>>> +static bool bsp_added;
> >>>>
> >>>>    /*
> >>>>     * Setup information
> >>>> @@ -346,10 +348,55 @@ static void __init bootcmdline_init(char **cmd=
line_p)
> >>>>           *cmdline_p =3D boot_command_line;
> >>>>    }
> >>>>
> >>>> +int topo_get_cpu(int physid)
> >>>> +{
> >>>> +       int i;
> >>>> +
> >>>> +       for (i =3D 0; i < possible_cpus; i++)
> >>>> +               if (cpu_logical_map(i) =3D=3D physid)
> >>>> +                       break;
> >>>> +
> >>>> +       if (i =3D=3D possible_cpus)
> >>>> +               return -ENOENT;
> >>>> +
> >>>> +       return i;
> >>>> +}
> >>>> +
> >>>> +int topo_add_cpu(int physid)
> >>>> +{
> >>>> +       int cpu;
> >>>> +
> >>>> +       if (!bsp_added && (physid =3D=3D loongson_sysconf.boot_cpu_i=
d)) {
> >>>> +               bsp_added =3D true;
> >>>> +               return 0;
> >>>> +       }
> >>>> +
> >>>> +       cpu =3D topo_get_cpu(physid);
> >>>> +       if (cpu >=3D 0) {
> >>>> +               pr_warn("Adding duplicated physical cpuid 0x%x\n", p=
hysid);
> >>>> +               return -EEXIST;
> >>>> +       }
> >>>> +
> >>>> +       if (possible_cpus >=3D nr_cpu_ids)
> >>>> +               return -ERANGE;
> >>>> +
> >>>> +       __cpu_logical_map[possible_cpus] =3D physid;
> >>>> +       cpu =3D possible_cpus++;
> >>>> +       return cpu;
> >>>> +}
> >>>> +
> >>>> +static void __init topo_init(void)
> >>>> +{
> >>>> +       loongson_sysconf.boot_cpu_id =3D read_csr_cpuid();
> >>>> +       __cpu_logical_map[0] =3D loongson_sysconf.boot_cpu_id;
> >>>> +       possible_cpus++;
> >>>> +}
> >>>> +
> >>>>    void __init platform_init(void)
> >>>>    {
> >>>>           arch_reserve_vmcore();
> >>>>           arch_reserve_crashkernel();
> >>>> +       topo_init();
> >>>>
> >>>>    #ifdef CONFIG_ACPI
> >>>>           acpi_table_upgrade();
> >>>> diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp=
.c
> >>>> index 9afc2d8b3414..a3f466b89179 100644
> >>>> --- a/arch/loongarch/kernel/smp.c
> >>>> +++ b/arch/loongarch/kernel/smp.c
> >>>> @@ -291,10 +291,9 @@ static void __init fdt_smp_setup(void)
> >>>>                   if (cpuid >=3D nr_cpu_ids)
> >>>>                           continue;
> >>>>
> >>>> -               if (cpuid =3D=3D loongson_sysconf.boot_cpu_id)
> >>>> -                       cpu =3D 0;
> >>>> -               else
> >>>> -                       cpu =3D find_first_zero_bit(cpumask_bits(cpu=
_present_mask), NR_CPUS);
> >>>> +               cpu =3D topo_add_cpu(cpuid);
> >>>> +               if (cpu < 0)
> >>>> +                       continue;
> >>>>
> >>>>                   num_processors++;
> >>>>                   set_cpu_possible(cpu, true);
> >>>> @@ -302,7 +301,7 @@ static void __init fdt_smp_setup(void)
> >>>>                   __cpu_number_map[cpuid] =3D cpu;
> >>>>                   __cpu_logical_map[cpu] =3D cpuid;
> >>>>
> >>>> -               early_numa_add_cpu(cpu, 0);
> >>>> +               early_numa_add_cpu(cpuid, 0);
> >>>>                   set_cpuid_to_node(cpuid, 0);
> >>>>           }
> >>>>
> >>>>
> >>>> base-commit: 42f7652d3eb527d03665b09edac47f85fb600924
> >>>> --
> >>>> 2.39.3
> >>>>
> >>
> >>
>

