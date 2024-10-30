Return-Path: <linux-kernel+bounces-388355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7D99B5E55
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 855B51F238F2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 09:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C721D1991D7;
	Wed, 30 Oct 2024 09:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlcY371s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB04D1DFE16
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 09:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730278810; cv=none; b=RvBJnNG5czHkwDL+lq3h6dJ0px5PmhUzjA2PksheZSe4ll9qh89pVVNLyKHE6KIbyeQLlgMkZYILf4MiZc5WLMORlXBqrMwJ81zcIoHqOlOJOYqQ2AHCWSv4z509+Hs1dbA1yqCtX5PG5dwzj/xKWHtjnpEIM0U4MjOHVSi1XiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730278810; c=relaxed/simple;
	bh=oVtaDEYWTx7rZuQWiXWWNoh2sXmAyvaMiDuTT9erhL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IdL7yFr9pJNJx0W7xhkPSIXM11dzHgPmHqGqm9aXub1Z1A86piryAWjEGj+MQoTEsMu/AIHynSyJcq8opJn2Ei98Rzzw/XRxreXO8Npf5rSLPN+3xrFDrw22bgvxugyxO21YcI0jmonw9oI64WPxpVPOS4dgb4oEyJp3t1ChuO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlcY371s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F16C4CEE8
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 09:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730278810;
	bh=oVtaDEYWTx7rZuQWiXWWNoh2sXmAyvaMiDuTT9erhL8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DlcY371sqBT7Hr+h8K48kYQIx3JObnOrKUVnlmNlT6MfVMshNiKRCDsok25aUBYDz
	 BzokBr1SsqUQI7q6cE7c4lCSlEh93Doe7d3SF5gZNaau1bmGLYzZizkaJAFjDwYdkA
	 cCfeY2Ug49ySlPMQefqesjGxKy9zHXvLQEFAHmT9mtWDYp5vX5i/Asos5T0UFgPnTS
	 YgTX/OPrOSMYPPER1I41VQ9+ETYa8N6D156QGjIhQu/y+nzYfh9EZOajhyknxbB3mW
	 jNH1ZlR8MJp3yV3aiqXzYGLNr7hqT7f2W1fU0YyGxz/t2+GBhsmY9G4/4SSk0zAwy5
	 NrfOdw4Yb1TrQ==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a99f646ff1bso802671266b.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 02:00:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVdZlZM2uTQRkSwQ0zyOC+atT7mGWq1JwLPtH/2CQUNSaIIAfYrhdd7PmOXJW6m7mbD4/rZ3YL2ATT/odg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoh6jKrjwNr7rv5bpb+0mIkyFJLeK08S3GvO8rME5tH9iVH+rO
	gHfxnzg+gXzmBp8B0cbOCWYG432N9kRHot9f6Rf8ht5+FeBttiUm9TZnbJ+hL4uK7/NB3dXsoQ5
	pQai8jOHcdaORngzPtn/FcZq+T9s=
X-Google-Smtp-Source: AGHT+IGg1rQ6Q+YhBx4lektizlmsgKGAAiZCWqXB3OwLHgFl9PZy3zZmrp51kZoFkMVY0glqa36k8UyMGEhG7CBg77s=
X-Received: by 2002:a17:907:9621:b0:a9a:1585:dd6a with SMTP id
 a640c23a62f3a-a9e3a62561cmr206751766b.36.1730278808842; Wed, 30 Oct 2024
 02:00:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021080418.644342-1-maobibo@loongson.cn> <CAAhV-H4anpgfiAnPgm9h-m9pKCW0KUio+E72r1Q3F_0vm+zMRg@mail.gmail.com>
 <8c55c680-48c8-0ba3-c2a1-56dc72929a8d@loongson.cn> <CAAhV-H4wD5fGVgxwmRVpRgvQ-jyUY0t=ewJANbe50vj9_TZDUQ@mail.gmail.com>
 <f7ab6ec1-7a49-2764-7c19-9949ad508e2e@loongson.cn> <CAAhV-H6+rE_7P_C0MaWzXToVcPqZQX0YMPnhyZV7Pp6aQ01mCQ@mail.gmail.com>
 <39330bb8-d267-ef02-e082-388c7bfa3b43@loongson.cn> <CAAhV-H5jGZz2MeCSuLmJb5b-ugaaj3EECD7Z3mvtHW=OQrhLBw@mail.gmail.com>
 <8d2ab78b-6706-c78d-ffad-835ceef7372c@loongson.cn> <CAAhV-H7bwJwGSyBqY3XZynzGaqamKv3BJjxrqPJ-foaP4dFbAw@mail.gmail.com>
 <f2b7283b-9db3-c961-fa11-f1aeff489479@loongson.cn>
In-Reply-To: <f2b7283b-9db3-c961-fa11-f1aeff489479@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 30 Oct 2024 16:59:56 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4tJJqhJcrERJRVHg_FW4OOEV-OuHkX6PTP9L_ADKgfDg@mail.gmail.com>
Message-ID: <CAAhV-H4tJJqhJcrERJRVHg_FW4OOEV-OuHkX6PTP9L_ADKgfDg@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: Fix cpu hotplug issue
To: maobibo <maobibo@loongson.cn>
Cc: Jianmin Lv <lvjianmin@loongson.cn>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, lixianglai@loongson.cn, 
	WANG Xuerui <kernel@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 4:48=E2=80=AFPM maobibo <maobibo@loongson.cn> wrote=
:
>
>
>
> On 2024/10/30 =E4=B8=8B=E5=8D=884:34, Huacai Chen wrote:
> > On Wed, Oct 30, 2024 at 4:25=E2=80=AFPM maobibo <maobibo@loongson.cn> w=
rote:
> >>
> >>
> >>
> >> On 2024/10/30 =E4=B8=8B=E5=8D=884:12, Huacai Chen wrote:
> >>> On Tue, Oct 29, 2024 at 7:49=E2=80=AFPM maobibo <maobibo@loongson.cn>=
 wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 2024/10/29 =E4=B8=8B=E5=8D=886:36, Huacai Chen wrote:
> >>>>> On Mon, Oct 28, 2024 at 8:38=E2=80=AFPM maobibo <maobibo@loongson.c=
n> wrote:
> >>>>>>
> >>>>>> Hi Huacai,
> >>>>>>
> >>>>>> On 2024/10/22 =E4=B8=8A=E5=8D=889:31, Huacai Chen wrote:
> >>>>>>> On Tue, Oct 22, 2024 at 9:17=E2=80=AFAM maobibo <maobibo@loongson=
.cn> wrote:
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> On 2024/10/21 =E4=B8=8B=E5=8D=8810:32, Huacai Chen wrote:
> >>>>>>>>> Hi, Bibo,
> >>>>>>>>>
> >>>>>>>>> This version still doesn't touch the round-robin method, but it
> >>>>>>>>> doesn't matter, I think I misunderstood something since V1...
> >>>>>>>> I do not understand why round-robin method need be modified, SRA=
T may be
> >>>>>>>> disabled with general function disable_srat(). Then round-robin =
method
> >>>>>>>> is required.
> >>>>>>> I don't mean round-robin should be modified, I mean I misundersta=
nd round-robin.
> >>>>>>>
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Please correct me if I'm wrong: For cpus without ACPI_MADT_ENAB=
LED, in
> >>>>>>>>> smp_prepare_boot_cpu() the round-robin node ids only apply to
> >>>>>>>>> cpu_to_node(), but __cpuid_to_node[] still record the right nod=
e ids.
> >>>>>>>>> early_cpu_to_node() returns NUMA_NO_NODE not because
> >>>>>>>>> __cpuid_to_node[] records NUMA_NO_NODE, but because cpu_logical=
_map()
> >>>>>>>>> < 0.
> >>>>>>>>>
> >>>>>>>>> If the above is correct, we don't need so complicated, because =
the
> >>>>>>>>> correct and simplest way is:
> >>>>>>>>> https://lore.kernel.org/loongarch/6b2b3e89-5a46-2d20-3dfb-7aae3=
3839f49@loongson.cn/T/#m950eead5250e5992cc703bbe69622348cecfa465
> >>>>>>>>>
> >>>>>>>> It works also. Only that LoongArch kernel parsing about SRAT/MAD=
T is
> >>>>>>>> badly. If you do not mind, I do not mind neither. It is not my d=
uty for
> >>>>>>>> kernel side.
> >>>>>>> Yes, I don't mind, please use that simplest way.
> >>>>>> There is another problem with the simple way. eiointc reports erro=
r when
> >>>>>> cpu is online. The error message is:
> >>>>>>       Loongson-64bit Processor probed (LA464 Core)
> >>>>>>       CPU2 revision is: 0014c010 (Loongson-64bit)
> >>>>>>       FPU2 revision is: 00000001
> >>>>>>       eiointc: Error: invalid nodemap!
> >>>>>>       CPU 2 UP state irqchip/loongarch/eiointc:starting (100) fail=
ed (-1)
> >>>>>>
> >>>>>> The problem is that node_map of eiointc is problematic,
> >>>>>>
> >>>>>>
> >>>>>> static int cpu_to_eio_node(int cpu)
> >>>>>> {
> >>>>>>             return cpu_logical_map(cpu) / CORES_PER_EIO_NODE;
> >>>>>> }
> >>>>>>
> >>>>>> static int __init eiointc_init(struct eiointc_priv *priv, int pare=
nt_irq,
> >>>>>>                                    u64 node_map)
> >>>>>> {
> >>>>>>             int i;
> >>>>>>
> >>>>>>             node_map =3D node_map ? node_map : -1ULL;
> >>>>>>             for_each_possible_cpu(i) {
> >>>>>>                     if (node_map & (1ULL << (cpu_to_eio_node(i))))=
 {
> >>>>>>                             node_set(cpu_to_eio_node(i), priv->nod=
e_map);
> >>>>>>              ...
> >>>>>> The cause is that for possible not present cpu, *cpu_logical_map(c=
pu)*
> >>>>>> is -1, cpu_to_eio_node(i) will be equal to -1, so node_map of eioi=
ntc is
> >>>>>> problematic.
> >>>>> The error message seems from eiointc_router_init(), but it is a lit=
tle
> >>>>> strange. Physical hot-add should be before logical hot-add. So
> >>>>> acpi_map_cpu() is before cpu_up(). acpi_map_cpu() calls
> >>>>> set_processor_mask() to setup logical-physical mapping, so in
> >>>>> eiointc_router_init() which is called by cpu_up(), cpu_logical_map(=
)
> >>>>> should work well.
> >>>>>
> >>>>> Maybe in your case a whole node is hot-added? I don't think the
> >>>>> eiointc design can work with this case...
> >>>>>
> >>>>>>
> >>>>>> So cpu_logical_map(cpu) should be set during MADT parsing even if =
it is
> >>>>>> not enabled at beginning, it should not be set at hotplug runtime.
> >>>>> This will cause the logical cpu number be not continuous after boot=
.
> >>>>> Physical numbers have no requirement, but logical numbers should be
> >>>>> continuous.
> >>>> I do not understand such requirement about logical cpu should be
> >>>> continuous. You can check logical cpu allocation method on other
> >>>> architectures, or what does the requirement about logical cpu contin=
uous
> >>>> come from.
> >>> 1, In an internal conference, it is said that non-continuous cpu
> >>> numbers make users think our processors have bugs.
> >>> 2, See prefill_possible_map(), it assumes logical numbers continuous
> >>> cpu_possible_mask and cpu_present_mask, which make it convenient for
> >>> "nr_cpus=3Dxxx".
> >>> 3, Can you show me an example in a real machine that "processor" in
> >>> /proc/cpuinfo non-continues after boot and before soft hotplug?
> >> It is really wasting my time to discuss with you. You does not
> >> investigating implementation of other architectures, fully thinking in
> >> yourself way.
> > Totally wrong, I have implemented what you need, but you should make
> > other colleagues (not me) agree with your idea.
> > https://github.com/chenhuacai/linux/commit/d8dcf2844d5878b3ac5a42d074e7=
81fe2ebfbae7
> So do you mean we should internal discuss inside and post outside? You
> can not decide this since you do not know. And actual code writer (lv
> jianjin) does not reply to you still :(
"Non-continuous number is unacceptable" is an internal decision, if
you want to break this decision, you should let other colleagues
agree, otherwise that is the real thing wastes your time.

>
> >
> > Imagine that the cpu_possible_mask is 0b11111111, cpu_present_mask is
> > 0b10101010 (non-continuous), how to make "nr_cpus=3D3" work in a simple
> > way?
> if (bitmap_weight(cpu_present_mask) >=3D  nr_cpus))
>     then new cpu fails to add.
No,  I means cpu_possible_mask =3D 0b11111111, cpu_present_mask =3D
0b10101010 after MADT parsing, if you need to make "nr_cpus=3D3" work,
you should modify them to cpu_possible_mask =3D 0b10101000,
cpu_present_mask =3D 0b10101000 before smp_init(). But it is difficult
to implement the modification.

> >
> >>
> >> Does the real machines support real cpu hotplug and memory hotplug?
> > ACPI_MADT_ENABLED is designed for virtual machines only?
> It is the HW board problem, the HW does not support cpu hotplug, neither
> memory hotplug and PCIE hotplug. HW board does not support.
So we cannot see non-continuous CPU numbers just because all HW boards
have problems that don't support CPU hotplug, even on x86?

Huacai

>
> Regards
> Bibo Mao
>
> >
> > Huacai
> >
> >>
> >> Regards
> >> Bibo Mao
> >>>
> >>>
> >>>
> >>>
> >>> Huacai
> >>>>
> >>>> Regards
> >>>> Bibo Mao
> >>>>
> >>>>>
> >>>>> Huacai
> >>>>>
> >>>>>>
> >>>>>> Regards
> >>>>>> Bibo Mao
> >>>>>>
> >>>>>>
> >>>>>>>
> >>>>>>> Huacai
> >>>>>>>
> >>>>>>>>
> >>>>>>>> Bibo Mao
> >>>>>>>>>
> >>>>>>>>> Huacai
> >>>>>>>>>
> >>>>>>>>> On Mon, Oct 21, 2024 at 4:04=E2=80=AFPM Bibo Mao <maobibo@loong=
son.cn> wrote:
> >>>>>>>>>>
> >>>>>>>>>> On LoongArch system, there are two places to set cpu numa node=
. One
> >>>>>>>>>> is in arch specified function smp_prepare_boot_cpu(), the othe=
r is
> >>>>>>>>>> in generic function early_numa_node_init(). The latter will ov=
erwrite
> >>>>>>>>>> the numa node information.
> >>>>>>>>>>
> >>>>>>>>>> With hot-added cpu without numa information, cpu_logical_map()=
 fails
> >>>>>>>>>> to its physical cpuid at beginning since it is not enabled in =
ACPI
> >>>>>>>>>> MADT table. So function early_cpu_to_node() also fails to get =
its
> >>>>>>>>>> numa node for hot-added cpu, and generic function
> >>>>>>>>>> early_numa_node_init() will overwrite with incorrect numa node=
.
> >>>>>>>>>>
> >>>>>>>>>> APIs topo_get_cpu() and topo_add_cpu() is added here, like oth=
er
> >>>>>>>>>> architectures logic cpu is allocated when parsing MADT table. =
When
> >>>>>>>>>> parsing SRAT table or hot-add cpu, logic cpu is acquired by se=
arching
> >>>>>>>>>> all allocated logical cpu with matched physical id. It solves =
such
> >>>>>>>>>> problems such as:
> >>>>>>>>>>        1. Boot cpu is not the first entry in MADT table, the f=
irst entry
> >>>>>>>>>> will be overwritten with later boot cpu.
> >>>>>>>>>>        2. Physical cpu id not presented in MADT table is inval=
id, in later
> >>>>>>>>>> SRAT/hot-add cpu parsing, invalid physical cpu detected is add=
ed
> >>>>>>>>>>        3. For hot-add cpu, its logic cpu is allocated in MADT =
table parsing,
> >>>>>>>>>> so early_cpu_to_node() can be used for hot-add cpu and cpu_to_=
node()
> >>>>>>>>>> is correct for hot-add cpu.
> >>>>>>>>>>
> >>>>>>>>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >>>>>>>>>> ---
> >>>>>>>>>> v1 ... v2:
> >>>>>>>>>>        1. Like other architectures, allocate logic cpu when pa=
rsing MADT table.
> >>>>>>>>>>        2. Add invalid or duplicated physical cpuid parsing wit=
h SRAT table or
> >>>>>>>>>> hot-add cpu DSDT information.
> >>>>>>>>>> ---
> >>>>>>>>>>       arch/loongarch/include/asm/smp.h |  3 ++
> >>>>>>>>>>       arch/loongarch/kernel/acpi.c     | 24 ++++++++++------
> >>>>>>>>>>       arch/loongarch/kernel/setup.c    | 47 ++++++++++++++++++=
++++++++++++++
> >>>>>>>>>>       arch/loongarch/kernel/smp.c      |  9 +++---
> >>>>>>>>>>       4 files changed, 70 insertions(+), 13 deletions(-)
> >>>>>>>>>>
> >>>>>>>>>> diff --git a/arch/loongarch/include/asm/smp.h b/arch/loongarch=
/include/asm/smp.h
> >>>>>>>>>> index 3383c9d24e94..c61b75937a77 100644
> >>>>>>>>>> --- a/arch/loongarch/include/asm/smp.h
> >>>>>>>>>> +++ b/arch/loongarch/include/asm/smp.h
> >>>>>>>>>> @@ -119,4 +119,7 @@ static inline void __cpu_die(unsigned int =
cpu)
> >>>>>>>>>>       #define cpu_logical_map(cpu)   0
> >>>>>>>>>>       #endif /* CONFIG_SMP */
> >>>>>>>>>>
> >>>>>>>>>> +int topo_add_cpu(int physid);
> >>>>>>>>>> +int topo_get_cpu(int physid);
> >>>>>>>>>> +
> >>>>>>>>>>       #endif /* __ASM_SMP_H */
> >>>>>>>>>> diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/ker=
nel/acpi.c
> >>>>>>>>>> index f1a74b80f22c..84d9812d5f38 100644
> >>>>>>>>>> --- a/arch/loongarch/kernel/acpi.c
> >>>>>>>>>> +++ b/arch/loongarch/kernel/acpi.c
> >>>>>>>>>> @@ -78,10 +78,10 @@ static int set_processor_mask(u32 id, u32 =
flags)
> >>>>>>>>>>                      return -ENODEV;
> >>>>>>>>>>
> >>>>>>>>>>              }
> >>>>>>>>>> -       if (cpuid =3D=3D loongson_sysconf.boot_cpu_id)
> >>>>>>>>>> -               cpu =3D 0;
> >>>>>>>>>> -       else
> >>>>>>>>>> -               cpu =3D find_first_zero_bit(cpumask_bits(cpu_p=
resent_mask), NR_CPUS);
> >>>>>>>>>> +
> >>>>>>>>>> +       cpu =3D topo_add_cpu(cpuid);
> >>>>>>>>>> +       if (cpu < 0)
> >>>>>>>>>> +               return -EEXIST;
> >>>>>>>>>>
> >>>>>>>>>>              if (!cpu_enumerated)
> >>>>>>>>>>                      set_cpu_possible(cpu, true);
> >>>>>>>>>> @@ -203,8 +203,6 @@ void __init acpi_boot_table_init(void)
> >>>>>>>>>>                      goto fdt_earlycon;
> >>>>>>>>>>              }
> >>>>>>>>>>
> >>>>>>>>>> -       loongson_sysconf.boot_cpu_id =3D read_csr_cpuid();
> >>>>>>>>>> -
> >>>>>>>>>>              /*
> >>>>>>>>>>               * Process the Multiple APIC Description Table (M=
ADT), if present
> >>>>>>>>>>               */
> >>>>>>>>>> @@ -257,7 +255,7 @@ void __init numa_set_distance(int from, in=
t to, int distance)
> >>>>>>>>>>       void __init
> >>>>>>>>>>       acpi_numa_processor_affinity_init(struct acpi_srat_cpu_a=
ffinity *pa)
> >>>>>>>>>>       {
> >>>>>>>>>> -       int pxm, node;
> >>>>>>>>>> +       int pxm, node, cpu;
> >>>>>>>>>>
> >>>>>>>>>>              if (srat_disabled())
> >>>>>>>>>>                      return;
> >>>>>>>>>> @@ -286,6 +284,11 @@ acpi_numa_processor_affinity_init(struct =
acpi_srat_cpu_affinity *pa)
> >>>>>>>>>>                      return;
> >>>>>>>>>>              }
> >>>>>>>>>>
> >>>>>>>>>> +       cpu =3D topo_get_cpu(pa->apic_id);
> >>>>>>>>>> +       /* Check whether apic_id exists in MADT table */
> >>>>>>>>>> +       if (cpu < 0)
> >>>>>>>>>> +               return;
> >>>>>>>>>> +
> >>>>>>>>>>              early_numa_add_cpu(pa->apic_id, node);
> >>>>>>>>>>
> >>>>>>>>>>              set_cpuid_to_node(pa->apic_id, node);
> >>>>>>>>>> @@ -324,12 +327,17 @@ int acpi_map_cpu(acpi_handle handle, phy=
s_cpuid_t physid, u32 acpi_id, int *pcpu
> >>>>>>>>>>       {
> >>>>>>>>>>              int cpu;
> >>>>>>>>>>
> >>>>>>>>>> -       cpu =3D set_processor_mask(physid, ACPI_MADT_ENABLED);
> >>>>>>>>>> +       cpu =3D topo_get_cpu(physid);
> >>>>>>>>>> +       /* Check whether apic_id exists in MADT table */
> >>>>>>>>>>              if (cpu < 0) {
> >>>>>>>>>>                      pr_info(PREFIX "Unable to map lapic to lo=
gical cpu number\n");
> >>>>>>>>>>                      return cpu;
> >>>>>>>>>>              }
> >>>>>>>>>>
> >>>>>>>>>> +       num_processors++;
> >>>>>>>>>> +       set_cpu_present(cpu, true);
> >>>>>>>>>> +       __cpu_number_map[physid] =3D cpu;
> >>>>>>>>>> +       __cpu_logical_map[cpu] =3D physid;
> >>>>>>>>>>              acpi_map_cpu2node(handle, cpu, physid);
> >>>>>>>>>>
> >>>>>>>>>>              *pcpu =3D cpu;
> >>>>>>>>>> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/ke=
rnel/setup.c
> >>>>>>>>>> index 00e307203ddb..649e98640076 100644
> >>>>>>>>>> --- a/arch/loongarch/kernel/setup.c
> >>>>>>>>>> +++ b/arch/loongarch/kernel/setup.c
> >>>>>>>>>> @@ -65,6 +65,8 @@ EXPORT_SYMBOL(cpu_data);
> >>>>>>>>>>
> >>>>>>>>>>       struct loongson_board_info b_info;
> >>>>>>>>>>       static const char dmi_empty_string[] =3D "        ";
> >>>>>>>>>> +static int possible_cpus;
> >>>>>>>>>> +static bool bsp_added;
> >>>>>>>>>>
> >>>>>>>>>>       /*
> >>>>>>>>>>        * Setup information
> >>>>>>>>>> @@ -346,10 +348,55 @@ static void __init bootcmdline_init(char=
 **cmdline_p)
> >>>>>>>>>>              *cmdline_p =3D boot_command_line;
> >>>>>>>>>>       }
> >>>>>>>>>>
> >>>>>>>>>> +int topo_get_cpu(int physid)
> >>>>>>>>>> +{
> >>>>>>>>>> +       int i;
> >>>>>>>>>> +
> >>>>>>>>>> +       for (i =3D 0; i < possible_cpus; i++)
> >>>>>>>>>> +               if (cpu_logical_map(i) =3D=3D physid)
> >>>>>>>>>> +                       break;
> >>>>>>>>>> +
> >>>>>>>>>> +       if (i =3D=3D possible_cpus)
> >>>>>>>>>> +               return -ENOENT;
> >>>>>>>>>> +
> >>>>>>>>>> +       return i;
> >>>>>>>>>> +}
> >>>>>>>>>> +
> >>>>>>>>>> +int topo_add_cpu(int physid)
> >>>>>>>>>> +{
> >>>>>>>>>> +       int cpu;
> >>>>>>>>>> +
> >>>>>>>>>> +       if (!bsp_added && (physid =3D=3D loongson_sysconf.boot=
_cpu_id)) {
> >>>>>>>>>> +               bsp_added =3D true;
> >>>>>>>>>> +               return 0;
> >>>>>>>>>> +       }
> >>>>>>>>>> +
> >>>>>>>>>> +       cpu =3D topo_get_cpu(physid);
> >>>>>>>>>> +       if (cpu >=3D 0) {
> >>>>>>>>>> +               pr_warn("Adding duplicated physical cpuid 0x%x=
\n", physid);
> >>>>>>>>>> +               return -EEXIST;
> >>>>>>>>>> +       }
> >>>>>>>>>> +
> >>>>>>>>>> +       if (possible_cpus >=3D nr_cpu_ids)
> >>>>>>>>>> +               return -ERANGE;
> >>>>>>>>>> +
> >>>>>>>>>> +       __cpu_logical_map[possible_cpus] =3D physid;
> >>>>>>>>>> +       cpu =3D possible_cpus++;
> >>>>>>>>>> +       return cpu;
> >>>>>>>>>> +}
> >>>>>>>>>> +
> >>>>>>>>>> +static void __init topo_init(void)
> >>>>>>>>>> +{
> >>>>>>>>>> +       loongson_sysconf.boot_cpu_id =3D read_csr_cpuid();
> >>>>>>>>>> +       __cpu_logical_map[0] =3D loongson_sysconf.boot_cpu_id;
> >>>>>>>>>> +       possible_cpus++;
> >>>>>>>>>> +}
> >>>>>>>>>> +
> >>>>>>>>>>       void __init platform_init(void)
> >>>>>>>>>>       {
> >>>>>>>>>>              arch_reserve_vmcore();
> >>>>>>>>>>              arch_reserve_crashkernel();
> >>>>>>>>>> +       topo_init();
> >>>>>>>>>>
> >>>>>>>>>>       #ifdef CONFIG_ACPI
> >>>>>>>>>>              acpi_table_upgrade();
> >>>>>>>>>> diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kern=
el/smp.c
> >>>>>>>>>> index 9afc2d8b3414..a3f466b89179 100644
> >>>>>>>>>> --- a/arch/loongarch/kernel/smp.c
> >>>>>>>>>> +++ b/arch/loongarch/kernel/smp.c
> >>>>>>>>>> @@ -291,10 +291,9 @@ static void __init fdt_smp_setup(void)
> >>>>>>>>>>                      if (cpuid >=3D nr_cpu_ids)
> >>>>>>>>>>                              continue;
> >>>>>>>>>>
> >>>>>>>>>> -               if (cpuid =3D=3D loongson_sysconf.boot_cpu_id)
> >>>>>>>>>> -                       cpu =3D 0;
> >>>>>>>>>> -               else
> >>>>>>>>>> -                       cpu =3D find_first_zero_bit(cpumask_bi=
ts(cpu_present_mask), NR_CPUS);
> >>>>>>>>>> +               cpu =3D topo_add_cpu(cpuid);
> >>>>>>>>>> +               if (cpu < 0)
> >>>>>>>>>> +                       continue;
> >>>>>>>>>>
> >>>>>>>>>>                      num_processors++;
> >>>>>>>>>>                      set_cpu_possible(cpu, true);
> >>>>>>>>>> @@ -302,7 +301,7 @@ static void __init fdt_smp_setup(void)
> >>>>>>>>>>                      __cpu_number_map[cpuid] =3D cpu;
> >>>>>>>>>>                      __cpu_logical_map[cpu] =3D cpuid;
> >>>>>>>>>>
> >>>>>>>>>> -               early_numa_add_cpu(cpu, 0);
> >>>>>>>>>> +               early_numa_add_cpu(cpuid, 0);
> >>>>>>>>>>                      set_cpuid_to_node(cpuid, 0);
> >>>>>>>>>>              }
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> base-commit: 42f7652d3eb527d03665b09edac47f85fb600924
> >>>>>>>>>> --
> >>>>>>>>>> 2.39.3
> >>>>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>
> >>>>
> >>>>
> >>
>

