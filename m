Return-Path: <linux-kernel+bounces-363384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D365699C19B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92C94281539
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 07:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2713314F9EE;
	Mon, 14 Oct 2024 07:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPxGGohB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6719014F114
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 07:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728891574; cv=none; b=hiVHstRpwu+CUul8rxqr+370jgOt7TYwP5xcstQS2rRqOPi34zTkM7otuh1jiMLN36mz5B9GMa07oIQUJeQneQPtvd6XFtda9M+2DoW0geLehK3nJ5KYJGW/mr0simMzvpjd35iQ/JNjxh0TIFyY9OuWSr4j/QSSenTk3VZMEJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728891574; c=relaxed/simple;
	bh=GR0az3UEtCyyj+RUKPs772wcvQl66iq5weS5vgYqo8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AwzsU9Tog65pC9EvRrU1CP4580xL4yeZ2NlzLv520LGiz+3yW2ue7cAqZD0XGdK1vyPUHS1t9WzXEusHyPsFauucS2FLZ7sEnNH43dZEJmTqWOfR2CckzdzTVYBXx65GWHgGzhfCdX+ZjjEYvUtO7GX2neXRV1yz1VhzTwxqYdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPxGGohB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A51C4CED0
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 07:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728891574;
	bh=GR0az3UEtCyyj+RUKPs772wcvQl66iq5weS5vgYqo8Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cPxGGohBl4q6z6+7AzTAv3w0IfaziZVYP6KdihKceKIP/QNRRmP2CLJo2fILC9m9M
	 9v/85hQRtqKphkSq9VJB98zuTwbxX7V9BA7c4pSLN4KXgdYijHRpE/B4g1jcre9GD5
	 jW3Os0mt4MQctygrXt6UFwKKJosCV5coEFjC2fif5NlXwHoFRlXxZdbBjIV/cOX3RQ
	 5Azj2UEiPRcDgfuv8V06RYT9iTvUvsd48AjSQJoYyTN4OB/ibjv8lB9A7J3Vzv4LLS
	 PBLX8soM9CPE+9hdEjaYdJG464VWdN8oMjnTAYW9ObCxPM6O0+u+5E3MnyWD6gHEk2
	 9zkYfCn6zj8GQ==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a0f198d38so104363966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 00:39:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZ/Oz2QgbFZrM7mDntUhLoGWQe2ODdDlc2UuTWSE/HIquexMsrRJD46FveKRPCi2h9Tpe5JoEZfwk0MKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiK7rcZvxe3Es9Q5HB6xg+SiJ5yjIzscaM8Tg2USXTVHmls7TT
	8jt9+AF5x4DuyFFha4pefxPy0bvaSW3Np6qLQShW2LZfeHgzDcSZ3v1wuU4jQVTeGd6luiNcbM1
	ROtvnvNilj8y+hg+566Z0qUUQ7ns=
X-Google-Smtp-Source: AGHT+IEjY6u9Fkcl+eowT6Tu2oNhk2Z28XN8H4LTU2WmYhNMLX2Ln0WTm9UAcE9rSdbuPtn8oU8WWzQR6nw69p87og4=
X-Received: by 2002:a17:907:3f25:b0:a99:537d:5d14 with SMTP id
 a640c23a62f3a-a99e3b77da6mr538906966b.28.1728891572622; Mon, 14 Oct 2024
 00:39:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014063328.1216497-1-maobibo@loongson.cn> <CAAhV-H5_SUnrf0PwOUFOA0EumKvGOmgqUq=Cx61Ub5AW=MPo=A@mail.gmail.com>
 <24ea8b02-8c94-d561-cef0-01044b610a1e@loongson.cn>
In-Reply-To: <24ea8b02-8c94-d561-cef0-01044b610a1e@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 14 Oct 2024 15:39:21 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7NqzO-FLmYoUySp5KYKJM+aN_s7g4i+qBixx5jwnbW=Q@mail.gmail.com>
Message-ID: <CAAhV-H7NqzO-FLmYoUySp5KYKJM+aN_s7g4i+qBixx5jwnbW=Q@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Fix cpu hotplug issue
To: maobibo <maobibo@loongson.cn>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	lixianglai@loongson.cn, WANG Xuerui <kernel@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 3:21=E2=80=AFPM maobibo <maobibo@loongson.cn> wrote=
:
>
> Huacai,
>
> On 2024/10/14 =E4=B8=8B=E5=8D=883:05, Huacai Chen wrote:
> > Hi, Bibo,
> >
> > I'm a little confused, so please correct me if I'm wrong.
> >
> > On Mon, Oct 14, 2024 at 2:33=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> =
wrote:
> >>
> >> On LoongArch system, there are two places to set cpu numa node. One
> >> is in arch specified function smp_prepare_boot_cpu(), the other is
> >> in generic function early_numa_node_init(). The latter will overwrite
> >> the numa node information.
> >>
> >> However for hot-added cpu, cpu_logical_map() fails to its physical
> >> cpuid at beginning since it is not enabled in ACPI MADT table. So
> >> function early_cpu_to_node() also fails to get its numa node for
> >> hot-added cpu, and generic function early_numa_node_init() will
> >> overwrite incorrect numa node.
> > For hot-added cpus, we will call acpi_map_cpu() -->
> > acpi_map_cpu2node() --> set_cpuid_to_node(), and set_cpuid_to_node()
> > operates on __cpuid_to_node[]. So I think early_cpu_to_node() should
> > be correct?
>
> __cpuid_to_node[] is correct which is physical cpuid to numa node,
> however cpu_logical_map(cpu) is not set. It fails to get physical cpuid
> from logic cpu.
>
> int early_cpu_to_node(int cpu)
> {
>          int physid =3D cpu_logical_map(cpu);
>
> <<<<<<<<<<< Here physid is -1.
early_cpu_to_node() is not supposed to be called after boot, and if it
is really needed, I think a better solution is:

diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
index f1a74b80f22c..998cf45fd3b7 100644
--- a/arch/loongarch/kernel/acpi.c
+++ b/arch/loongarch/kernel/acpi.c
@@ -311,6 +311,8 @@ static int __ref acpi_map_cpu2node(acpi_handle
handle, int cpu, int physid)

        nid =3D acpi_get_node(handle);
        if (nid !=3D NUMA_NO_NODE) {
+               __cpu_number_map[physid] =3D cpu;
+               __cpu_logical_map[cpu] =3D physid;
                set_cpuid_to_node(physid, nid);
                node_set(nid, numa_nodes_parsed);
                set_cpu_numa_node(cpu, nid);

Huacai

>
>          if (physid < 0)
>                  return NUMA_NO_NODE;
>
>          return __cpuid_to_node[physid];
> }
>
> Regards
> Bibo Mao
> >
> > Huacai
> >
> >>
> >> Here static array __cpu_to_node and api set_early_cpu_to_node()
> >> is added, so that early_cpu_to_node is consistent with function
> >> cpu_to_node() for hot-added cpu.
> >>
> >> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >> ---
> >>   arch/loongarch/include/asm/numa.h |  2 ++
> >>   arch/loongarch/kernel/numa.c      | 10 +++++++++-
> >>   arch/loongarch/kernel/smp.c       |  1 +
> >>   3 files changed, 12 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/loongarch/include/asm/numa.h b/arch/loongarch/includ=
e/asm/numa.h
> >> index b5f9de9f102e..e8e6fcfb006a 100644
> >> --- a/arch/loongarch/include/asm/numa.h
> >> +++ b/arch/loongarch/include/asm/numa.h
> >> @@ -50,6 +50,7 @@ static inline void set_cpuid_to_node(int cpuid, s16 =
node)
> >>   }
> >>
> >>   extern int early_cpu_to_node(int cpu);
> >> +extern void set_early_cpu_to_node(int cpu, s16 node);
> >>
> >>   #else
> >>
> >> @@ -57,6 +58,7 @@ static inline void early_numa_add_cpu(int cpuid, s16=
 node)    { }
> >>   static inline void numa_add_cpu(unsigned int cpu)              { }
> >>   static inline void numa_remove_cpu(unsigned int cpu)           { }
> >>   static inline void set_cpuid_to_node(int cpuid, s16 node)      { }
> >> +static inline void set_early_cpu_to_node(int cpu, s16 node)    { }
> >>
> >>   static inline int early_cpu_to_node(int cpu)
> >>   {
> >> diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/numa=
.c
> >> index 84fe7f854820..62508aace644 100644
> >> --- a/arch/loongarch/kernel/numa.c
> >> +++ b/arch/loongarch/kernel/numa.c
> >> @@ -34,6 +34,9 @@ static struct numa_meminfo numa_meminfo;
> >>   cpumask_t cpus_on_node[MAX_NUMNODES];
> >>   cpumask_t phys_cpus_on_node[MAX_NUMNODES];
> >>   EXPORT_SYMBOL(cpus_on_node);
> >> +static s16 __cpu_to_node[NR_CPUS] =3D {
> >> +       [0 ... CONFIG_NR_CPUS - 1] =3D NUMA_NO_NODE
> >> +};
> >>
> >>   /*
> >>    * apicid, cpu, node mappings
> >> @@ -117,11 +120,16 @@ int early_cpu_to_node(int cpu)
> >>          int physid =3D cpu_logical_map(cpu);
> >>
> >>          if (physid < 0)
> >> -               return NUMA_NO_NODE;
> >> +               return __cpu_to_node[cpu];
> >>
> >>          return __cpuid_to_node[physid];
> >>   }
> >>
> >> +void set_early_cpu_to_node(int cpu, s16 node)
> >> +{
> >> +       __cpu_to_node[cpu] =3D node;
> >> +}
> >> +
> >>   void __init early_numa_add_cpu(int cpuid, s16 node)
> >>   {
> >>          int cpu =3D __cpu_number_map[cpuid];
> >> diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
> >> index 9afc2d8b3414..998668be858c 100644
> >> --- a/arch/loongarch/kernel/smp.c
> >> +++ b/arch/loongarch/kernel/smp.c
> >> @@ -512,6 +512,7 @@ void __init smp_prepare_boot_cpu(void)
> >>                          set_cpu_numa_node(cpu, node);
> >>                  else {
> >>                          set_cpu_numa_node(cpu, rr_node);
> >> +                       set_early_cpu_to_node(cpu, rr_node);
> >>                          rr_node =3D next_node_in(rr_node, node_online=
_map);
> >>                  }
> >>          }
> >>
> >> base-commit: 6485cf5ea253d40d507cd71253c9568c5470cd27
> >> --
> >> 2.39.3
> >>
> >>
>
>

