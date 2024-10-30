Return-Path: <linux-kernel+bounces-388374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 491259B5E98
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C37AA1F219D6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 09:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F2E1E2016;
	Wed, 30 Oct 2024 09:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxKLY94P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A4D1E130D
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 09:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730280018; cv=none; b=Cl6C6AqtaYwEyyKtwVD7fcM75Qw1GDi6Klg1vmBkFWzAJtWJzC9hrrgYTcMkCqfbeyhWb7XE9IX9jIx4+d1WRB1UeQjxP8KH4W6FDU1HwuxizC8MgvFkgP5SSgb4aLeIMd6QOFPxloOCBWjBmL0U+6s1FGlxsA2VARg3oHTBEDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730280018; c=relaxed/simple;
	bh=9RY+7mY3Y8AebSGo8wgKiJi/YNLJFHLNXQtrm2jE/GU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U4kdYcs/h6ExIL3CGMIRuOJ/5+z1lBkf9+C4yCfdL8QK6vM8efkTL/FRF+2h3qlLVTRzt47zle8JSGxomwEAfKVnvuDYEcjPxeEl1s+jjRi53FteonF2xdjOhtrc8tQ/e25xgl5sxcnntGD5BQxDUU8jBVAomPYxQCXq50Bad4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxKLY94P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F40C4CEE4
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 09:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730280017;
	bh=9RY+7mY3Y8AebSGo8wgKiJi/YNLJFHLNXQtrm2jE/GU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UxKLY94PAn525pBo8rDnDiIqKAOt+EzssvZA2p48d3tE0MLQHSaf4b3pMXwduNzwa
	 e8kw27XDRrEJORz5bUokC9xufWDsQN8WrEzYV7QO9rhIz+08EIt3YOkOogmMrLAhY4
	 OUQtak3Wra1G3wKvts6T5Ob5XITmcrdA+uPbJx3cGcUdptkvc89SoJyh530NUOhVwL
	 XBk3X2rY3En9eO0hyuWnX83Cf8kc9pfU1Nkmo/C8ro0mxYbjZ0Pb7JUOb/hf12NYh7
	 trXDD/1K3BfpYzLV08hlfej5bPnP/qLnbSjnm2+Y5Y6CeByjgCtp3rShzuiRpY3n85
	 lzPDuW91lb/MQ==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a99f646ff1bso804981966b.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 02:20:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVvkk2Mew7DaPtLrFV6MDWbFJUfJa5+IxvhbnhkhIdxpFOD8oznuj53zYetGEmFJfc86p3mtapBudNdSyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxoOrqTSls/5CwCbeCxujJUOuEXVYwvvsWf1Ip3b+wJF/Opm36
	LfQeMUIkXeGWmuU84OjlbA+MN+7MtAliU68o/juIVa1A4MttS+J40BmSABMDIEeSPm1rKVnCRKA
	/KXlHSYQAeDp0/ud4QlArRGvRwhE=
X-Google-Smtp-Source: AGHT+IE1vrXYggoc8TR70iXydKQV6uabOYZZBNBd3gBCNXrdk3riVotWrVIfdZ7HIaP5cwtdAtljOSXQpVBFTR0lZfM=
X-Received: by 2002:a17:907:1b81:b0:a9e:471e:ce4a with SMTP id
 a640c23a62f3a-a9e471ed2admr54398866b.11.1730280016017; Wed, 30 Oct 2024
 02:20:16 -0700 (PDT)
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
 <f2b7283b-9db3-c961-fa11-f1aeff489479@loongson.cn> <CAAhV-H4tJJqhJcrERJRVHg_FW4OOEV-OuHkX6PTP9L_ADKgfDg@mail.gmail.com>
 <4172a465-a326-e3fa-ddba-5752a38f7237@loongson.cn>
In-Reply-To: <4172a465-a326-e3fa-ddba-5752a38f7237@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 30 Oct 2024 17:20:02 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6ADGot=LbcPROs-34wZbkYHBOcMgdCw7NErsJqs3hdzA@mail.gmail.com>
Message-ID: <CAAhV-H6ADGot=LbcPROs-34wZbkYHBOcMgdCw7NErsJqs3hdzA@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: Fix cpu hotplug issue
To: maobibo <maobibo@loongson.cn>
Cc: Jianmin Lv <lvjianmin@loongson.cn>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, lixianglai@loongson.cn, 
	WANG Xuerui <kernel@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 5:10=E2=80=AFPM maobibo <maobibo@loongson.cn> wrote=
:
>
>
>
> On 2024/10/30 =E4=B8=8B=E5=8D=884:59, Huacai Chen wrote:
> > On Wed, Oct 30, 2024 at 4:48=E2=80=AFPM maobibo <maobibo@loongson.cn> w=
rote:
> >>
> >>
> >>
> >> On 2024/10/30 =E4=B8=8B=E5=8D=884:34, Huacai Chen wrote:
> >>> On Wed, Oct 30, 2024 at 4:25=E2=80=AFPM maobibo <maobibo@loongson.cn>=
 wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 2024/10/30 =E4=B8=8B=E5=8D=884:12, Huacai Chen wrote:
> >>>>> On Tue, Oct 29, 2024 at 7:49=E2=80=AFPM maobibo <maobibo@loongson.c=
n> wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> On 2024/10/29 =E4=B8=8B=E5=8D=886:36, Huacai Chen wrote:
> >>>>>>> On Mon, Oct 28, 2024 at 8:38=E2=80=AFPM maobibo <maobibo@loongson=
.cn> wrote:
> >>>>>>>>
> >>>>>>>> Hi Huacai,
> >>>>>>>>
> >>>>>>>> On 2024/10/22 =E4=B8=8A=E5=8D=889:31, Huacai Chen wrote:
> >>>>>>>>> On Tue, Oct 22, 2024 at 9:17=E2=80=AFAM maobibo <maobibo@loongs=
on.cn> wrote:
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> On 2024/10/21 =E4=B8=8B=E5=8D=8810:32, Huacai Chen wrote:
> >>>>>>>>>>> Hi, Bibo,
> >>>>>>>>>>>
> >>>>>>>>>>> This version still doesn't touch the round-robin method, but =
it
> >>>>>>>>>>> doesn't matter, I think I misunderstood something since V1...
> >>>>>>>>>> I do not understand why round-robin method need be modified, S=
RAT may be
> >>>>>>>>>> disabled with general function disable_srat(). Then round-robi=
n method
> >>>>>>>>>> is required.
> >>>>>>>>> I don't mean round-robin should be modified, I mean I misunders=
tand round-robin.
> >>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> Please correct me if I'm wrong: For cpus without ACPI_MADT_EN=
ABLED, in
> >>>>>>>>>>> smp_prepare_boot_cpu() the round-robin node ids only apply to
> >>>>>>>>>>> cpu_to_node(), but __cpuid_to_node[] still record the right n=
ode ids.
> >>>>>>>>>>> early_cpu_to_node() returns NUMA_NO_NODE not because
> >>>>>>>>>>> __cpuid_to_node[] records NUMA_NO_NODE, but because cpu_logic=
al_map()
> >>>>>>>>>>> < 0.
> >>>>>>>>>>>
> >>>>>>>>>>> If the above is correct, we don't need so complicated, becaus=
e the
> >>>>>>>>>>> correct and simplest way is:
> >>>>>>>>>>> https://lore.kernel.org/loongarch/6b2b3e89-5a46-2d20-3dfb-7aa=
e33839f49@loongson.cn/T/#m950eead5250e5992cc703bbe69622348cecfa465
> >>>>>>>>>>>
> >>>>>>>>>> It works also. Only that LoongArch kernel parsing about SRAT/M=
ADT is
> >>>>>>>>>> badly. If you do not mind, I do not mind neither. It is not my=
 duty for
> >>>>>>>>>> kernel side.
> >>>>>>>>> Yes, I don't mind, please use that simplest way.
> >>>>>>>> There is another problem with the simple way. eiointc reports er=
ror when
> >>>>>>>> cpu is online. The error message is:
> >>>>>>>>        Loongson-64bit Processor probed (LA464 Core)
> >>>>>>>>        CPU2 revision is: 0014c010 (Loongson-64bit)
> >>>>>>>>        FPU2 revision is: 00000001
> >>>>>>>>        eiointc: Error: invalid nodemap!
> >>>>>>>>        CPU 2 UP state irqchip/loongarch/eiointc:starting (100) f=
ailed (-1)
> >>>>>>>>
> >>>>>>>> The problem is that node_map of eiointc is problematic,
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> static int cpu_to_eio_node(int cpu)
> >>>>>>>> {
> >>>>>>>>              return cpu_logical_map(cpu) / CORES_PER_EIO_NODE;
> >>>>>>>> }
> >>>>>>>>
> >>>>>>>> static int __init eiointc_init(struct eiointc_priv *priv, int pa=
rent_irq,
> >>>>>>>>                                     u64 node_map)
> >>>>>>>> {
> >>>>>>>>              int i;
> >>>>>>>>
> >>>>>>>>              node_map =3D node_map ? node_map : -1ULL;
> >>>>>>>>              for_each_possible_cpu(i) {
> >>>>>>>>                      if (node_map & (1ULL << (cpu_to_eio_node(i)=
))) {
> >>>>>>>>                              node_set(cpu_to_eio_node(i), priv->=
node_map);
> >>>>>>>>               ...
> >>>>>>>> The cause is that for possible not present cpu, *cpu_logical_map=
(cpu)*
> >>>>>>>> is -1, cpu_to_eio_node(i) will be equal to -1, so node_map of ei=
ointc is
> >>>>>>>> problematic.
> >>>>>>> The error message seems from eiointc_router_init(), but it is a l=
ittle
> >>>>>>> strange. Physical hot-add should be before logical hot-add. So
> >>>>>>> acpi_map_cpu() is before cpu_up(). acpi_map_cpu() calls
> >>>>>>> set_processor_mask() to setup logical-physical mapping, so in
> >>>>>>> eiointc_router_init() which is called by cpu_up(), cpu_logical_ma=
p()
> >>>>>>> should work well.
> >>>>>>>
> >>>>>>> Maybe in your case a whole node is hot-added? I don't think the
> >>>>>>> eiointc design can work with this case...
> >>>>>>>
> >>>>>>>>
> >>>>>>>> So cpu_logical_map(cpu) should be set during MADT parsing even i=
f it is
> >>>>>>>> not enabled at beginning, it should not be set at hotplug runtim=
e.
> >>>>>>> This will cause the logical cpu number be not continuous after bo=
ot.
> >>>>>>> Physical numbers have no requirement, but logical numbers should =
be
> >>>>>>> continuous.
> >>>>>> I do not understand such requirement about logical cpu should be
> >>>>>> continuous. You can check logical cpu allocation method on other
> >>>>>> architectures, or what does the requirement about logical cpu cont=
inuous
> >>>>>> come from.
> >>>>> 1, In an internal conference, it is said that non-continuous cpu
> >>>>> numbers make users think our processors have bugs.
> >>>>> 2, See prefill_possible_map(), it assumes logical numbers continuou=
s
> >>>>> cpu_possible_mask and cpu_present_mask, which make it convenient fo=
r
> >>>>> "nr_cpus=3Dxxx".
> >>>>> 3, Can you show me an example in a real machine that "processor" in
> >>>>> /proc/cpuinfo non-continues after boot and before soft hotplug?
> >>>> It is really wasting my time to discuss with you. You does not
> >>>> investigating implementation of other architectures, fully thinking =
in
> >>>> yourself way.
> >>> Totally wrong, I have implemented what you need, but you should make
> >>> other colleagues (not me) agree with your idea.
> >>> https://github.com/chenhuacai/linux/commit/d8dcf2844d5878b3ac5a42d074=
e781fe2ebfbae7
> >> So do you mean we should internal discuss inside and post outside? You
> >> can not decide this since you do not know. And actual code writer (lv
> >> jianjin) does not reply to you still :(
> > "Non-continuous number is unacceptable" is an internal decision, if
> > you want to break this decision, you should let other colleagues
> > agree, otherwise that is the real thing wastes your time.
> If so I will not touch any kernel code any more, please write the patch
> to fix it to keep your maintainer position stable. Is that ok for you?
So you mean you are pushing me to do what violates the team decision,
and your original goal is make my position unstable?

Of course I don't really think so, but your sentences look like this.

Please check whether this solution can solve your problem, then let
others agree your idea.
https://github.com/chenhuacai/linux/commit/d8dcf2844d5878b3ac5a42d074e781fe=
2ebfbae7

Huacai

>
>
> >
> >>
> >>>
> >>> Imagine that the cpu_possible_mask is 0b11111111, cpu_present_mask is
> >>> 0b10101010 (non-continuous), how to make "nr_cpus=3D3" work in a simp=
le
> >>> way?
> >> if (bitmap_weight(cpu_present_mask) >=3D  nr_cpus))
> >>      then new cpu fails to add.
> > No,  I means cpu_possible_mask =3D 0b11111111, cpu_present_mask =3D
> > 0b10101010 after MADT parsing, if you need to make "nr_cpus=3D3" work,
> > you should modify them to cpu_possible_mask =3D 0b10101000,
> > cpu_present_mask =3D 0b10101000 before smp_init(). But it is difficult
> > to implement the modification.
> >
> >>>
> >>>>
> >>>> Does the real machines support real cpu hotplug and memory hotplug?
> >>> ACPI_MADT_ENABLED is designed for virtual machines only?
> >> It is the HW board problem, the HW does not support cpu hotplug, neith=
er
> >> memory hotplug and PCIE hotplug. HW board does not support.
> > So we cannot see non-continuous CPU numbers just because all HW boards
> > have problems that don't support CPU hotplug, even on x86?
> >
> > Huacai
> >
> >>
> >> Regards
> >> Bibo Mao
> >>
> >>>
> >>> Huacai
> >>>
> >>>>
> >>>> Regards
> >>>> Bibo Mao
> >>>>>
> >>>>>
> >>>>>
> >>>>>
> >>>>> Huacai
> >>>>>>
> >>>>>> Regards
> >>>>>> Bibo Mao
> >>>>>>
> >>>>>>>
> >>>>>>> Huacai
> >>>>>>>
> >>>>>>>>
> >>>>>>>> Regards
> >>>>>>>> Bibo Mao
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Huacai
> >>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> Bibo Mao
> >>>>>>>>>>>
> >>>>>>>>>>> Huacai
> >>>>>>>>>>>
> >>>>>>>>>>> On Mon, Oct 21, 2024 at 4:04=E2=80=AFPM Bibo Mao <maobibo@loo=
ngson.cn> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>> On LoongArch system, there are two places to set cpu numa no=
de. One
> >>>>>>>>>>>> is in arch specified function smp_prepare_boot_cpu(), the ot=
her is
> >>>>>>>>>>>> in generic function early_numa_node_init(). The latter will =
overwrite
> >>>>>>>>>>>> the numa node information.
> >>>>>>>>>>>>
> >>>>>>>>>>>> With hot-added cpu without numa information, cpu_logical_map=
() fails
> >>>>>>>>>>>> to its physical cpuid at beginning since it is not enabled i=
n ACPI
> >>>>>>>>>>>> MADT table. So function early_cpu_to_node() also fails to ge=
t its
> >>>>>>>>>>>> numa node for hot-added cpu, and generic function
> >>>>>>>>>>>> early_numa_node_init() will overwrite with incorrect numa no=
de.
> >>>>>>>>>>>>
> >>>>>>>>>>>> APIs topo_get_cpu() and topo_add_cpu() is added here, like o=
ther
> >>>>>>>>>>>> architectures logic cpu is allocated when parsing MADT table=
. When
> >>>>>>>>>>>> parsing SRAT table or hot-add cpu, logic cpu is acquired by =
searching
> >>>>>>>>>>>> all allocated logical cpu with matched physical id. It solve=
s such
> >>>>>>>>>>>> problems such as:
> >>>>>>>>>>>>         1. Boot cpu is not the first entry in MADT table, th=
e first entry
> >>>>>>>>>>>> will be overwritten with later boot cpu.
> >>>>>>>>>>>>         2. Physical cpu id not presented in MADT table is in=
valid, in later
> >>>>>>>>>>>> SRAT/hot-add cpu parsing, invalid physical cpu detected is a=
dded
> >>>>>>>>>>>>         3. For hot-add cpu, its logic cpu is allocated in MA=
DT table parsing,
> >>>>>>>>>>>> so early_cpu_to_node() can be used for hot-add cpu and cpu_t=
o_node()
> >>>>>>>>>>>> is correct for hot-add cpu.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >>>>>>>>>>>> ---
> >>>>>>>>>>>> v1 ... v2:
> >>>>>>>>>>>>         1. Like other architectures, allocate logic cpu when=
 parsing MADT table.
> >>>>>>>>>>>>         2. Add invalid or duplicated physical cpuid parsing =
with SRAT table or
> >>>>>>>>>>>> hot-add cpu DSDT information.
> >>>>>>>>>>>> ---
> >>>>>>>>>>>>        arch/loongarch/include/asm/smp.h |  3 ++
> >>>>>>>>>>>>        arch/loongarch/kernel/acpi.c     | 24 ++++++++++-----=
-
> >>>>>>>>>>>>        arch/loongarch/kernel/setup.c    | 47 +++++++++++++++=
+++++++++++++++++
> >>>>>>>>>>>>        arch/loongarch/kernel/smp.c      |  9 +++---
> >>>>>>>>>>>>        4 files changed, 70 insertions(+), 13 deletions(-)
> >>>>>>>>>>>>
> >>>>>>>>>>>> diff --git a/arch/loongarch/include/asm/smp.h b/arch/loongar=
ch/include/asm/smp.h
> >>>>>>>>>>>> index 3383c9d24e94..c61b75937a77 100644
> >>>>>>>>>>>> --- a/arch/loongarch/include/asm/smp.h
> >>>>>>>>>>>> +++ b/arch/loongarch/include/asm/smp.h
> >>>>>>>>>>>> @@ -119,4 +119,7 @@ static inline void __cpu_die(unsigned in=
t cpu)
> >>>>>>>>>>>>        #define cpu_logical_map(cpu)   0
> >>>>>>>>>>>>        #endif /* CONFIG_SMP */
> >>>>>>>>>>>>
> >>>>>>>>>>>> +int topo_add_cpu(int physid);
> >>>>>>>>>>>> +int topo_get_cpu(int physid);
> >>>>>>>>>>>> +
> >>>>>>>>>>>>        #endif /* __ASM_SMP_H */
> >>>>>>>>>>>> diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/k=
ernel/acpi.c
> >>>>>>>>>>>> index f1a74b80f22c..84d9812d5f38 100644
> >>>>>>>>>>>> --- a/arch/loongarch/kernel/acpi.c
> >>>>>>>>>>>> +++ b/arch/loongarch/kernel/acpi.c
> >>>>>>>>>>>> @@ -78,10 +78,10 @@ static int set_processor_mask(u32 id, u3=
2 flags)
> >>>>>>>>>>>>                       return -ENODEV;
> >>>>>>>>>>>>
> >>>>>>>>>>>>               }
> >>>>>>>>>>>> -       if (cpuid =3D=3D loongson_sysconf.boot_cpu_id)
> >>>>>>>>>>>> -               cpu =3D 0;
> >>>>>>>>>>>> -       else
> >>>>>>>>>>>> -               cpu =3D find_first_zero_bit(cpumask_bits(cpu=
_present_mask), NR_CPUS);
> >>>>>>>>>>>> +
> >>>>>>>>>>>> +       cpu =3D topo_add_cpu(cpuid);
> >>>>>>>>>>>> +       if (cpu < 0)
> >>>>>>>>>>>> +               return -EEXIST;
> >>>>>>>>>>>>
> >>>>>>>>>>>>               if (!cpu_enumerated)
> >>>>>>>>>>>>                       set_cpu_possible(cpu, true);
> >>>>>>>>>>>> @@ -203,8 +203,6 @@ void __init acpi_boot_table_init(void)
> >>>>>>>>>>>>                       goto fdt_earlycon;
> >>>>>>>>>>>>               }
> >>>>>>>>>>>>
> >>>>>>>>>>>> -       loongson_sysconf.boot_cpu_id =3D read_csr_cpuid();
> >>>>>>>>>>>> -
> >>>>>>>>>>>>               /*
> >>>>>>>>>>>>                * Process the Multiple APIC Description Table=
 (MADT), if present
> >>>>>>>>>>>>                */
> >>>>>>>>>>>> @@ -257,7 +255,7 @@ void __init numa_set_distance(int from, =
int to, int distance)
> >>>>>>>>>>>>        void __init
> >>>>>>>>>>>>        acpi_numa_processor_affinity_init(struct acpi_srat_cp=
u_affinity *pa)
> >>>>>>>>>>>>        {
> >>>>>>>>>>>> -       int pxm, node;
> >>>>>>>>>>>> +       int pxm, node, cpu;
> >>>>>>>>>>>>
> >>>>>>>>>>>>               if (srat_disabled())
> >>>>>>>>>>>>                       return;
> >>>>>>>>>>>> @@ -286,6 +284,11 @@ acpi_numa_processor_affinity_init(struc=
t acpi_srat_cpu_affinity *pa)
> >>>>>>>>>>>>                       return;
> >>>>>>>>>>>>               }
> >>>>>>>>>>>>
> >>>>>>>>>>>> +       cpu =3D topo_get_cpu(pa->apic_id);
> >>>>>>>>>>>> +       /* Check whether apic_id exists in MADT table */
> >>>>>>>>>>>> +       if (cpu < 0)
> >>>>>>>>>>>> +               return;
> >>>>>>>>>>>> +
> >>>>>>>>>>>>               early_numa_add_cpu(pa->apic_id, node);
> >>>>>>>>>>>>
> >>>>>>>>>>>>               set_cpuid_to_node(pa->apic_id, node);
> >>>>>>>>>>>> @@ -324,12 +327,17 @@ int acpi_map_cpu(acpi_handle handle, p=
hys_cpuid_t physid, u32 acpi_id, int *pcpu
> >>>>>>>>>>>>        {
> >>>>>>>>>>>>               int cpu;
> >>>>>>>>>>>>
> >>>>>>>>>>>> -       cpu =3D set_processor_mask(physid, ACPI_MADT_ENABLED=
);
> >>>>>>>>>>>> +       cpu =3D topo_get_cpu(physid);
> >>>>>>>>>>>> +       /* Check whether apic_id exists in MADT table */
> >>>>>>>>>>>>               if (cpu < 0) {
> >>>>>>>>>>>>                       pr_info(PREFIX "Unable to map lapic to=
 logical cpu number\n");
> >>>>>>>>>>>>                       return cpu;
> >>>>>>>>>>>>               }
> >>>>>>>>>>>>
> >>>>>>>>>>>> +       num_processors++;
> >>>>>>>>>>>> +       set_cpu_present(cpu, true);
> >>>>>>>>>>>> +       __cpu_number_map[physid] =3D cpu;
> >>>>>>>>>>>> +       __cpu_logical_map[cpu] =3D physid;
> >>>>>>>>>>>>               acpi_map_cpu2node(handle, cpu, physid);
> >>>>>>>>>>>>
> >>>>>>>>>>>>               *pcpu =3D cpu;
> >>>>>>>>>>>> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/=
kernel/setup.c
> >>>>>>>>>>>> index 00e307203ddb..649e98640076 100644
> >>>>>>>>>>>> --- a/arch/loongarch/kernel/setup.c
> >>>>>>>>>>>> +++ b/arch/loongarch/kernel/setup.c
> >>>>>>>>>>>> @@ -65,6 +65,8 @@ EXPORT_SYMBOL(cpu_data);
> >>>>>>>>>>>>
> >>>>>>>>>>>>        struct loongson_board_info b_info;
> >>>>>>>>>>>>        static const char dmi_empty_string[] =3D "        ";
> >>>>>>>>>>>> +static int possible_cpus;
> >>>>>>>>>>>> +static bool bsp_added;
> >>>>>>>>>>>>
> >>>>>>>>>>>>        /*
> >>>>>>>>>>>>         * Setup information
> >>>>>>>>>>>> @@ -346,10 +348,55 @@ static void __init bootcmdline_init(ch=
ar **cmdline_p)
> >>>>>>>>>>>>               *cmdline_p =3D boot_command_line;
> >>>>>>>>>>>>        }
> >>>>>>>>>>>>
> >>>>>>>>>>>> +int topo_get_cpu(int physid)
> >>>>>>>>>>>> +{
> >>>>>>>>>>>> +       int i;
> >>>>>>>>>>>> +
> >>>>>>>>>>>> +       for (i =3D 0; i < possible_cpus; i++)
> >>>>>>>>>>>> +               if (cpu_logical_map(i) =3D=3D physid)
> >>>>>>>>>>>> +                       break;
> >>>>>>>>>>>> +
> >>>>>>>>>>>> +       if (i =3D=3D possible_cpus)
> >>>>>>>>>>>> +               return -ENOENT;
> >>>>>>>>>>>> +
> >>>>>>>>>>>> +       return i;
> >>>>>>>>>>>> +}
> >>>>>>>>>>>> +
> >>>>>>>>>>>> +int topo_add_cpu(int physid)
> >>>>>>>>>>>> +{
> >>>>>>>>>>>> +       int cpu;
> >>>>>>>>>>>> +
> >>>>>>>>>>>> +       if (!bsp_added && (physid =3D=3D loongson_sysconf.bo=
ot_cpu_id)) {
> >>>>>>>>>>>> +               bsp_added =3D true;
> >>>>>>>>>>>> +               return 0;
> >>>>>>>>>>>> +       }
> >>>>>>>>>>>> +
> >>>>>>>>>>>> +       cpu =3D topo_get_cpu(physid);
> >>>>>>>>>>>> +       if (cpu >=3D 0) {
> >>>>>>>>>>>> +               pr_warn("Adding duplicated physical cpuid 0x=
%x\n", physid);
> >>>>>>>>>>>> +               return -EEXIST;
> >>>>>>>>>>>> +       }
> >>>>>>>>>>>> +
> >>>>>>>>>>>> +       if (possible_cpus >=3D nr_cpu_ids)
> >>>>>>>>>>>> +               return -ERANGE;
> >>>>>>>>>>>> +
> >>>>>>>>>>>> +       __cpu_logical_map[possible_cpus] =3D physid;
> >>>>>>>>>>>> +       cpu =3D possible_cpus++;
> >>>>>>>>>>>> +       return cpu;
> >>>>>>>>>>>> +}
> >>>>>>>>>>>> +
> >>>>>>>>>>>> +static void __init topo_init(void)
> >>>>>>>>>>>> +{
> >>>>>>>>>>>> +       loongson_sysconf.boot_cpu_id =3D read_csr_cpuid();
> >>>>>>>>>>>> +       __cpu_logical_map[0] =3D loongson_sysconf.boot_cpu_i=
d;
> >>>>>>>>>>>> +       possible_cpus++;
> >>>>>>>>>>>> +}
> >>>>>>>>>>>> +
> >>>>>>>>>>>>        void __init platform_init(void)
> >>>>>>>>>>>>        {
> >>>>>>>>>>>>               arch_reserve_vmcore();
> >>>>>>>>>>>>               arch_reserve_crashkernel();
> >>>>>>>>>>>> +       topo_init();
> >>>>>>>>>>>>
> >>>>>>>>>>>>        #ifdef CONFIG_ACPI
> >>>>>>>>>>>>               acpi_table_upgrade();
> >>>>>>>>>>>> diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/ke=
rnel/smp.c
> >>>>>>>>>>>> index 9afc2d8b3414..a3f466b89179 100644
> >>>>>>>>>>>> --- a/arch/loongarch/kernel/smp.c
> >>>>>>>>>>>> +++ b/arch/loongarch/kernel/smp.c
> >>>>>>>>>>>> @@ -291,10 +291,9 @@ static void __init fdt_smp_setup(void)
> >>>>>>>>>>>>                       if (cpuid >=3D nr_cpu_ids)
> >>>>>>>>>>>>                               continue;
> >>>>>>>>>>>>
> >>>>>>>>>>>> -               if (cpuid =3D=3D loongson_sysconf.boot_cpu_i=
d)
> >>>>>>>>>>>> -                       cpu =3D 0;
> >>>>>>>>>>>> -               else
> >>>>>>>>>>>> -                       cpu =3D find_first_zero_bit(cpumask_=
bits(cpu_present_mask), NR_CPUS);
> >>>>>>>>>>>> +               cpu =3D topo_add_cpu(cpuid);
> >>>>>>>>>>>> +               if (cpu < 0)
> >>>>>>>>>>>> +                       continue;
> >>>>>>>>>>>>
> >>>>>>>>>>>>                       num_processors++;
> >>>>>>>>>>>>                       set_cpu_possible(cpu, true);
> >>>>>>>>>>>> @@ -302,7 +301,7 @@ static void __init fdt_smp_setup(void)
> >>>>>>>>>>>>                       __cpu_number_map[cpuid] =3D cpu;
> >>>>>>>>>>>>                       __cpu_logical_map[cpu] =3D cpuid;
> >>>>>>>>>>>>
> >>>>>>>>>>>> -               early_numa_add_cpu(cpu, 0);
> >>>>>>>>>>>> +               early_numa_add_cpu(cpuid, 0);
> >>>>>>>>>>>>                       set_cpuid_to_node(cpuid, 0);
> >>>>>>>>>>>>               }
> >>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>> base-commit: 42f7652d3eb527d03665b09edac47f85fb600924
> >>>>>>>>>>>> --
> >>>>>>>>>>>> 2.39.3
> >>>>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>
> >>>>>>
> >>>>>>
> >>>>
> >>
>

