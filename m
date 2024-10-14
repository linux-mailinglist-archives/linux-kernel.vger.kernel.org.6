Return-Path: <linux-kernel+bounces-363494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 374BC99C315
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAFE02817BF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6EB1514F8;
	Mon, 14 Oct 2024 08:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLtFceQ3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C20B14D70B
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728894204; cv=none; b=Z79lCILCro3rAZSXI1MO5IGpA+ogmk/mUAX01AGYQTv7FbY30xDQ8qsbtd4kjVm9ZV9IuocZeo2cRiQXwQ8LG9RiozDUz5+BGQ0PYGV8+WdBO98jFyRSNtln/9jrAdy2OIsRagC6m7goTTZKiXihPFQbOJ5cXiimrvP/MoVncqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728894204; c=relaxed/simple;
	bh=9mA8AaUmchnfF2qhcV9gtbwfXEQCEWwq8dE88hy1+no=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QMPRcjTJJGD3gyWsFS90zPW+I5E0fOFjhZW9YqXaYpu58a4B9eBM3lwnVvN+OGKLrHlGGeHlk03qiYI+BOF+qeorkuy7N6txToC8upAPZT7pTxyXk9e/neojE3tlgup6qjYAiGgZCrirFCtYpYPPCHpkRmG1SbUdfrCiz2BCtiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLtFceQ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1E8C4CEC3
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728894204;
	bh=9mA8AaUmchnfF2qhcV9gtbwfXEQCEWwq8dE88hy1+no=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hLtFceQ3ixwQ9lkspmWflGECibR6QcPwqSPSqQqvQj1dWtWTiS/Sz9ub2HaicflAJ
	 UBOwWGTr9HOVpJZbwpfqFXv7N+5ywFssuZuSLMR+tYaWsSSAO13iHxsp4P9fF3+5Ik
	 B1bm0pds+g7hqaGRjAo9XSYstTW+2Pv28WxSL9M4qk41RZ4wTjWQ5XMUM2BEq7a6md
	 W3enTdt2WvC67SNJjSCATG3VW895cyRPdLiBsqjQQ0Lcc/FlZczNmcTre8HxA1Oemv
	 4CQeN9foOYnH+osu/rsD3ohDb9qGBAd3Vc4FnMHyOoDTivn09IuEbocyJ+9WqqcFwK
	 HgUpmBaYu3tTA==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9952ea05c5so619176666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 01:23:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUap9owIct5jhzj0rOMw1yGotRLknDgCedZpJ/QkN+kNEaEaU4T4s2WhwUjYeWjA7KGaZ1yJllxIF6umCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPfldnpM7oJO0HEX3lGBfnv+lvKzKrlS1lwAXUOasROcfJia/c
	+7ErMekTG6Dv5H3m5DDW7CIZ2zXbBOLE7qsffk2s6zHMBFSBFLh2uh52iUijFjw3173XL7j80l4
	Mzaf6iQ4Cw9CQfe02kg1NpcEyCZw=
X-Google-Smtp-Source: AGHT+IEAX1babB4ZxNcCopIY49tKCSXyzO1kJ6eClhmFjfoDbQH4e2FlUTkjdvYhH3sI0hp+4ww7sLBhxUMonckSD34=
X-Received: by 2002:a17:906:d552:b0:a99:ff2c:78fc with SMTP id
 a640c23a62f3a-a99ff2c7a1amr440746266b.57.1728894202617; Mon, 14 Oct 2024
 01:23:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014063328.1216497-1-maobibo@loongson.cn> <CAAhV-H5_SUnrf0PwOUFOA0EumKvGOmgqUq=Cx61Ub5AW=MPo=A@mail.gmail.com>
 <24ea8b02-8c94-d561-cef0-01044b610a1e@loongson.cn> <CAAhV-H7NqzO-FLmYoUySp5KYKJM+aN_s7g4i+qBixx5jwnbW=Q@mail.gmail.com>
 <5c1e0199-24ce-50d2-1cbc-5c9949a17563@loongson.cn>
In-Reply-To: <5c1e0199-24ce-50d2-1cbc-5c9949a17563@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 14 Oct 2024 16:23:11 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6JKNBgsLdAsKHp3rttpY+0KGabac2m87-PsT4FH_H=Ew@mail.gmail.com>
Message-ID: <CAAhV-H6JKNBgsLdAsKHp3rttpY+0KGabac2m87-PsT4FH_H=Ew@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Fix cpu hotplug issue
To: maobibo <maobibo@loongson.cn>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	lixianglai@loongson.cn, WANG Xuerui <kernel@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 4:01=E2=80=AFPM maobibo <maobibo@loongson.cn> wrote=
:
>
> Huacai,
>
> On 2024/10/14 =E4=B8=8B=E5=8D=883:39, Huacai Chen wrote:
> > On Mon, Oct 14, 2024 at 3:21=E2=80=AFPM maobibo <maobibo@loongson.cn> w=
rote:
> >>
> >> Huacai,
> >>
> >> On 2024/10/14 =E4=B8=8B=E5=8D=883:05, Huacai Chen wrote:
> >>> Hi, Bibo,
> >>>
> >>> I'm a little confused, so please correct me if I'm wrong.
> >>>
> >>> On Mon, Oct 14, 2024 at 2:33=E2=80=AFPM Bibo Mao <maobibo@loongson.cn=
> wrote:
> >>>>
> >>>> On LoongArch system, there are two places to set cpu numa node. One
> >>>> is in arch specified function smp_prepare_boot_cpu(), the other is
> >>>> in generic function early_numa_node_init(). The latter will overwrit=
e
> >>>> the numa node information.
> >>>>
> >>>> However for hot-added cpu, cpu_logical_map() fails to its physical
> >>>> cpuid at beginning since it is not enabled in ACPI MADT table. So
> >>>> function early_cpu_to_node() also fails to get its numa node for
> >>>> hot-added cpu, and generic function early_numa_node_init() will
> >>>> overwrite incorrect numa node.
> >>> For hot-added cpus, we will call acpi_map_cpu() -->
> >>> acpi_map_cpu2node() --> set_cpuid_to_node(), and set_cpuid_to_node()
> >>> operates on __cpuid_to_node[]. So I think early_cpu_to_node() should
> >>> be correct?
> >>
> >> __cpuid_to_node[] is correct which is physical cpuid to numa node,
> >> however cpu_logical_map(cpu) is not set. It fails to get physical cpui=
d
> >> from logic cpu.
> >>
> >> int early_cpu_to_node(int cpu)
> >> {
> >>           int physid =3D cpu_logical_map(cpu);
> >>
> >> <<<<<<<<<<< Here physid is -1.
> > early_cpu_to_node() is not supposed to be called after boot, and if it
> Which calls early_cpu_to_node() after boot?
>
> > is really needed, I think a better solution is:
> >
> > diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.=
c
> > index f1a74b80f22c..998cf45fd3b7 100644
> > --- a/arch/loongarch/kernel/acpi.c
> > +++ b/arch/loongarch/kernel/acpi.c
> > @@ -311,6 +311,8 @@ static int __ref acpi_map_cpu2node(acpi_handle
> > handle, int cpu, int physid)
> >
> >          nid =3D acpi_get_node(handle);
> >          if (nid !=3D NUMA_NO_NODE) {
> > +               __cpu_number_map[physid] =3D cpu;
> > +               __cpu_logical_map[cpu] =3D physid;
> This does not solve the problem. The above has been done in function
> cpu =3D set_processor_mask(physid, ACPI_MADT_ENABLED);
>
> static int set_processor_mask(u32 id, u32 flags)
> {
> ...
>          if (flags & ACPI_MADT_ENABLED) {
>                  num_processors++;
>                  set_cpu_present(cpu, true);
>                  __cpu_number_map[cpuid] =3D cpu;
>                  __cpu_logical_map[cpu] =3D cpuid;
>          }
>
> The problem is that
>          smp_prepare_boot_cpu(); /* arch-specific boot-cpu hooks */
> <<<<<<<<<<<<<<<<
> set_cpu_numa_node() is called in function smp_prepare_boot_cpu()
>
>          early_numa_node_init();
>
> static void __init early_numa_node_init(void)
> {
> #ifdef CONFIG_USE_PERCPU_NUMA_NODE_ID
> #ifndef cpu_to_node
>          int cpu;
>
>          /* The early_cpu_to_node() should be ready here. */
>          for_each_possible_cpu(cpu)
>                  set_cpu_numa_node(cpu, early_cpu_to_node(cpu));
> <<<<<<<<<<<<<<<<
> * however here early_cpu_to_node is -1, so that cpu_to_node(cpu) will
> always return -1 in late. *, which causes cpu hotadd problem.
Still confused. For ACPI_MADT_ENABLED cpus, everything is right after
early_numa_node_init(). For !ACPI_MADT_ENABLED cpus, cpu_to_node()
returns -1 after early_numa_node_init() and before hot-add, but if
acpi_map_cpu() do things right, cpu_to_node() should still work well
after hot-add.

Huacai
>
> Regards
> Bibo Mao
>
>
> >                  set_cpuid_to_node(physid, nid);
> >                  node_set(nid, numa_nodes_parsed);
> >                  set_cpu_numa_node(cpu, nid);
> >
> > Huacai
> >
> >>
> >>           if (physid < 0)
> >>                   return NUMA_NO_NODE;
> >>
> >>           return __cpuid_to_node[physid];
> >> }
> >>
> >> Regards
> >> Bibo Mao
> >>>
> >>> Huacai
> >>>
> >>>>
> >>>> Here static array __cpu_to_node and api set_early_cpu_to_node()
> >>>> is added, so that early_cpu_to_node is consistent with function
> >>>> cpu_to_node() for hot-added cpu.
> >>>>
> >>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >>>> ---
> >>>>    arch/loongarch/include/asm/numa.h |  2 ++
> >>>>    arch/loongarch/kernel/numa.c      | 10 +++++++++-
> >>>>    arch/loongarch/kernel/smp.c       |  1 +
> >>>>    3 files changed, 12 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/arch/loongarch/include/asm/numa.h b/arch/loongarch/incl=
ude/asm/numa.h
> >>>> index b5f9de9f102e..e8e6fcfb006a 100644
> >>>> --- a/arch/loongarch/include/asm/numa.h
> >>>> +++ b/arch/loongarch/include/asm/numa.h
> >>>> @@ -50,6 +50,7 @@ static inline void set_cpuid_to_node(int cpuid, s1=
6 node)
> >>>>    }
> >>>>
> >>>>    extern int early_cpu_to_node(int cpu);
> >>>> +extern void set_early_cpu_to_node(int cpu, s16 node);
> >>>>
> >>>>    #else
> >>>>
> >>>> @@ -57,6 +58,7 @@ static inline void early_numa_add_cpu(int cpuid, s=
16 node)    { }
> >>>>    static inline void numa_add_cpu(unsigned int cpu)              { =
}
> >>>>    static inline void numa_remove_cpu(unsigned int cpu)           { =
}
> >>>>    static inline void set_cpuid_to_node(int cpuid, s16 node)      { =
}
> >>>> +static inline void set_early_cpu_to_node(int cpu, s16 node)    { }
> >>>>
> >>>>    static inline int early_cpu_to_node(int cpu)
> >>>>    {
> >>>> diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/nu=
ma.c
> >>>> index 84fe7f854820..62508aace644 100644
> >>>> --- a/arch/loongarch/kernel/numa.c
> >>>> +++ b/arch/loongarch/kernel/numa.c
> >>>> @@ -34,6 +34,9 @@ static struct numa_meminfo numa_meminfo;
> >>>>    cpumask_t cpus_on_node[MAX_NUMNODES];
> >>>>    cpumask_t phys_cpus_on_node[MAX_NUMNODES];
> >>>>    EXPORT_SYMBOL(cpus_on_node);
> >>>> +static s16 __cpu_to_node[NR_CPUS] =3D {
> >>>> +       [0 ... CONFIG_NR_CPUS - 1] =3D NUMA_NO_NODE
> >>>> +};
> >>>>
> >>>>    /*
> >>>>     * apicid, cpu, node mappings
> >>>> @@ -117,11 +120,16 @@ int early_cpu_to_node(int cpu)
> >>>>           int physid =3D cpu_logical_map(cpu);
> >>>>
> >>>>           if (physid < 0)
> >>>> -               return NUMA_NO_NODE;
> >>>> +               return __cpu_to_node[cpu];
> >>>>
> >>>>           return __cpuid_to_node[physid];
> >>>>    }
> >>>>
> >>>> +void set_early_cpu_to_node(int cpu, s16 node)
> >>>> +{
> >>>> +       __cpu_to_node[cpu] =3D node;
> >>>> +}
> >>>> +
> >>>>    void __init early_numa_add_cpu(int cpuid, s16 node)
> >>>>    {
> >>>>           int cpu =3D __cpu_number_map[cpuid];
> >>>> diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp=
.c
> >>>> index 9afc2d8b3414..998668be858c 100644
> >>>> --- a/arch/loongarch/kernel/smp.c
> >>>> +++ b/arch/loongarch/kernel/smp.c
> >>>> @@ -512,6 +512,7 @@ void __init smp_prepare_boot_cpu(void)
> >>>>                           set_cpu_numa_node(cpu, node);
> >>>>                   else {
> >>>>                           set_cpu_numa_node(cpu, rr_node);
> >>>> +                       set_early_cpu_to_node(cpu, rr_node);
> >>>>                           rr_node =3D next_node_in(rr_node, node_onl=
ine_map);
> >>>>                   }
> >>>>           }
> >>>>
> >>>> base-commit: 6485cf5ea253d40d507cd71253c9568c5470cd27
> >>>> --
> >>>> 2.39.3
> >>>>
> >>>>
> >>
> >>
>
>

