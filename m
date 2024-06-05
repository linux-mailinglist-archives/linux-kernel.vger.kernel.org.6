Return-Path: <linux-kernel+bounces-202870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8547D8FD223
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F0DB1C22A75
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24031149C77;
	Wed,  5 Jun 2024 15:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="2tNI1PyM"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE42D450EE
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717602902; cv=none; b=Y9a0diz4rtG/IagMTk1NjL8IRnwpYps2cEvNohpot++erN0NlXRPUSw6e5jzq1Ozo7vErFdrk71nM5EicDpfGFBF+0e0nAzByuwqsGQS8eBRtxNGF142LDMcBUNTUW2TnFvhyufYJ2bGadYQVCut9rFl6JIduIgPW+2lMdxT5tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717602902; c=relaxed/simple;
	bh=WhMWvqFaEEz7WliezG9z0BYy16y8dAgCv+WClb5vvKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ti61cnaRuB4zPtX2JkAn/zkdS3127a0u4WF5G8EuDzOvcuqNLV8AbR7VILvE3NendmrE8zUPRn9tusqr1kVr/voRi/HdAvIpo0sEkcKLw8ZBKmB2yzu4LuLzIM6elonoZ4TDIBT+PmeINIufNhpYRRUo5TsRG2ePmP8F4hqGHos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=2tNI1PyM; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6267778b3aso13452966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 08:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717602898; x=1718207698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDF8euc9uUsFbp3ZteE4Lq248jbCQUypYJOerWaQiuw=;
        b=2tNI1PyM6kI27iNuid9D3syKuKcQPU++BE0G66KbH7JOYKT/a6OQsZ0ksEdZTWLy75
         r6i9NoOCFqtkWXGOlwxtyBa4xhIQVNoAX+gKuH2tzUU7c+b6JApQGXSRPqNqJYDDH1D/
         xuVtSwYb90zwBZ228RL/qbJrLrv+N13HTW59hoKOs59/F3TDzj8p5iGyLhzDwUFMlxGZ
         rg1eEKDH3aDxA9BgVqpPFwn7jZFPRBiH7YQEVIaQwdvGkd9LB5TqBpppu906Hbb3pQvY
         Tnj8ceos+v5ksWV9JpRQjsX7ViNX21h0JRuTysG52NjDYoWxL2SEZLFSfL1jxhJkilyy
         ZvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717602898; x=1718207698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YDF8euc9uUsFbp3ZteE4Lq248jbCQUypYJOerWaQiuw=;
        b=KXH9Nhrghu+R1w+MJ9W6TNIwbtj9Iy8r5yA4FozVpEHCEdMMllzMuz5jQAqKGON47Y
         AKkqPdN923qjftA1ENpXxHsR6yLytOqNunUyID2k34c9o0695JkRH8g3MsYevT4BY+wU
         ivJDeSXEaF8DQNKuaZ00PWUwNv4GsHK+K5miMAlBVQc+3r+ShFc8ek9CgqUTm1mu5S+3
         7N5ARGPFMUZwN7zkWORJh/G7CPSePMOjpV+vjzm2phIl2pwp/17l/tKa6iMwkzlStETH
         yF2+8wXsrBbMYcx+2lko5g01AQp6OHJNfDQRGyOgyWbbpObxnwCJDnHVawkHhPgPUzsB
         MKlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXF9W2nHeQqrLudSPYD6sfMNIYsjzYzwl8kVn20MvtScMl/5348qAIAVhwvoPp9ZeiDlsDBqyvNPIelAPf7QLtqzE2QHuXWwEgdn0Mp
X-Gm-Message-State: AOJu0YyefB9Lj74RhJdjB0vaig59UusYaW4Qh3UsPt9+xSgq8nfvOufp
	YxIYmwTtuCGXu5X4gZkA8N7jQ08lpEW83Y8RqbNxSHeU8UexhpIgDz9glfgQrfmYoZrig/iS3ri
	uOkbsk1XlRdVNeqh+vn2Tv1XcVEXaUnMow9Cvgg==
X-Google-Smtp-Source: AGHT+IHjKGWvVLSZr5Jp6N5uZety4NP33CYCaZ8/cPHbGuqVSnFYytje0tGqdTZ1pw83kclAjUd4JY/OhersyoeqfSY=
X-Received: by 2002:a17:906:ee89:b0:a68:379d:d623 with SMTP id
 a640c23a62f3a-a699fac0c4amr220812066b.36.1717602897899; Wed, 05 Jun 2024
 08:54:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604162457.3757417-1-jesse@rivosinc.com>
In-Reply-To: <20240604162457.3757417-1-jesse@rivosinc.com>
From: Evan Green <evan@rivosinc.com>
Date: Wed, 5 Jun 2024 08:54:21 -0700
Message-ID: <CALs-Hsu5LakOVKvGRP0-sbq5ptH8FLPGhBAkupv3tRLKVAdnUA@mail.gmail.com>
Subject: Re: [RFC PATCH v0] RISCV: Report vector unaligned accesses hwprobe
To: Jesse Taube <jesse@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor.dooley@microchip.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Andrew Jones <ajones@ventanamicro.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Xiao Wang <xiao.w.wang@intel.com>, Andy Chiu <andy.chiu@sifive.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Ben Dooks <ben.dooks@codethink.co.uk>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Erick Archer <erick.archer@gmx.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 9:25=E2=80=AFAM Jesse Taube <jesse@rivosinc.com> wro=
te:
>
> Detected if a system traps into the kernel on an vector unaligned access.
> Add the result to a new key in hwprobe.
>
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>

For the scalar world, we wanted to know whether misaligned accesses
were faster or slower than equivalent byte accesses, so usermode could
know for something like memcpy which option had better bandwidth. Is
the motivation here the same, where we're going to use vector
registers for memcpy and we want to know which size load to use? Or
will usermode be consuming this info for a different purpose as well?
I know this is a basic question, but having the motivation helps me
get the right lens for reviewing it. Perhaps that should be added to
the commit message as well.

> ---
>  arch/riscv/include/asm/cpufeature.h        |  3 ++
>  arch/riscv/include/asm/hwprobe.h           |  2 +-
>  arch/riscv/include/uapi/asm/hwprobe.h      |  6 +++
>  arch/riscv/kernel/sys_hwprobe.c            | 34 ++++++++++++
>  arch/riscv/kernel/traps_misaligned.c       | 60 ++++++++++++++++++++++
>  arch/riscv/kernel/unaligned_access_speed.c |  4 ++
>  6 files changed, 108 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm=
/cpufeature.h
> index 347805446151..5ad69cf25b25 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -35,9 +35,12 @@ void riscv_user_isa_enable(void);
>
>  #if defined(CONFIG_RISCV_MISALIGNED)
>  bool check_unaligned_access_emulated_all_cpus(void);
> +bool check_vector_unaligned_access_all_cpus(void);
> +
>  void unaligned_emulation_finish(void);
>  bool unaligned_ctl_available(void);
>  DECLARE_PER_CPU(long, misaligned_access_speed);
> +DECLARE_PER_CPU(long, vector_misaligned_access);
>  #else
>  static inline bool unaligned_ctl_available(void)
>  {
> diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hw=
probe.h
> index 630507dff5ea..150a9877b0af 100644
> --- a/arch/riscv/include/asm/hwprobe.h
> +++ b/arch/riscv/include/asm/hwprobe.h
> @@ -8,7 +8,7 @@
>
>  #include <uapi/asm/hwprobe.h>
>
> -#define RISCV_HWPROBE_MAX_KEY 6
> +#define RISCV_HWPROBE_MAX_KEY 7
>
>  static inline bool riscv_hwprobe_key_is_valid(__s64 key)
>  {
> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/u=
api/asm/hwprobe.h
> index 060212331a03..4474e98d17bd 100644
> --- a/arch/riscv/include/uapi/asm/hwprobe.h
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -68,6 +68,12 @@ struct riscv_hwprobe {
>  #define                RISCV_HWPROBE_MISALIGNED_UNSUPPORTED    (4 << 0)
>  #define                RISCV_HWPROBE_MISALIGNED_MASK           (7 << 0)
>  #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE    6
> +#define RISCV_HWPROBE_VEC_KEY_MISALIGNED_PERF  7
> +#define                RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN            0
> +#define                RISCV_HWPROBE_VEC_MISALIGNED_EMULATED           1
> +#define                RISCV_HWPROBE_VEC_MISALIGNED_SLOW               2
> +#define                RISCV_HWPROBE_VEC_MISALIGNED_FAST               3
> +#define                RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED        4

This needs to be added to the documentation as well.

What value should be returned when V is not enabled in the kernel, or
V is not supported in the hardware? Currently in the code it would be
UNKNOWN, right? Is that what we want, or is it worth differentiating
"no support for V" from "I don't know the speed of misaligned loads"?
Maybe UNKNOWN is the right value, as there are other values to tell
you V is not enabled.


>  /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
>
>  /* Flags */
> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwpr=
obe.c
> index b286b73e763e..ce641cc6e47a 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -184,6 +184,36 @@ static u64 hwprobe_misaligned(const struct cpumask *=
cpus)
>  }
>  #endif
>
> +#if defined(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)
> +static u64 hwprobe_vec_misaligned(const struct cpumask *cpus)
> +{
> +       int cpu;
> +       u64 perf =3D -1ULL;
> +
> +       for_each_cpu(cpu, cpus) {
> +               int this_perf =3D per_cpu(vector_misaligned_access, cpu);
> +
> +               if (perf =3D=3D -1ULL)
> +                       perf =3D this_perf;
> +
> +               if (perf !=3D this_perf) {
> +                       perf =3D RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
> +                       break;
> +               }
> +       }
> +
> +       if (perf =3D=3D -1ULL)
> +               return RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
> +
> +       return perf;
> +}
> +#else
> +static u64 hwprobe_vec_misaligned(const struct cpumask *cpus)
> +{
> +       return RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
> +}
> +#endif
> +
>  static void hwprobe_one_pair(struct riscv_hwprobe *pair,
>                              const struct cpumask *cpus)
>  {
> @@ -211,6 +241,10 @@ static void hwprobe_one_pair(struct riscv_hwprobe *p=
air,
>                 pair->value =3D hwprobe_misaligned(cpus);
>                 break;
>
> +       case RISCV_HWPROBE_VEC_KEY_MISALIGNED_PERF:
> +               pair->value =3D hwprobe_vec_misaligned(cpus);
> +               break;
> +
>         case RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE:
>                 pair->value =3D 0;
>                 if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOZ))
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/tra=
ps_misaligned.c
> index 2adb7c3e4dd5..0c07e990e9c5 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -16,6 +16,7 @@
>  #include <asm/entry-common.h>
>  #include <asm/hwprobe.h>
>  #include <asm/cpufeature.h>
> +#include <asm/vector.h>
>
>  #define INSN_MATCH_LB                  0x3
>  #define INSN_MASK_LB                   0x707f
> @@ -426,6 +427,14 @@ int handle_misaligned_load(struct pt_regs *regs)
>         if (get_insn(regs, epc, &insn))
>                 return -1;
>
> +#ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
> +       if (*this_cpu_ptr(&vector_misaligned_access) =3D=3D RISCV_HWPROBE=
_VEC_MISALIGNED_UNKNOWN) {
> +               *this_cpu_ptr(&vector_misaligned_access) =3D RISCV_HWPROB=
E_VEC_MISALIGNED_UNSUPPORTED;

Shouldn't this be EMULATED, given we were just delegated this trap? I
guess it depends on whether you're going to add support for actually
handling the misaligned vector trap, as Cl=C3=A9ment mentioned.

Scalar misaligned loads had a history to lean on since the specs were
always explicit that misaligned loads/store had to be supported one
way or another. So UNSUPPORTED was a future theoretical value. I
haven't dug through the specs yet, do you know what the story is for V
and misaligned loads? My sub-question is what the rules are for
detecting the difference between EMULATED and UNSUPPORTED.

> +               regs->epc =3D epc + INSN_LEN(insn);
> +               return 0;
> +       }
> +#endif
> +
>         regs->epc =3D 0;
>
>         if ((insn & INSN_MASK_LW) =3D=3D INSN_MATCH_LW) {
> @@ -625,6 +634,57 @@ static bool check_unaligned_access_emulated(int cpu)
>         return misaligned_emu_detected;
>  }
>
> +#ifdef CONFIG_RISCV_ISA_V
> +static bool check_vector_unaligned_access(int cpu)
> +{
> +       long *mas_ptr =3D per_cpu_ptr(&vector_misaligned_access, cpu);
> +       struct riscv_isainfo *isainfo =3D &hart_isa[cpu];
> +       unsigned long tmp_var;
> +       bool misaligned_vec_suported;
> +
> +       if (!riscv_isa_extension_available(isainfo->isa, v))
> +               return false;
> +
> +       /* This case will only happen if a unaligned vector load
> +        * was called by the kernel before this check
> +        */
> +       if (*mas_ptr !=3D RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN)
> +               return false;
> +
> +       kernel_vector_begin();
> +       __asm__ __volatile__ (
> +               ".option push\n\t"
> +               ".option arch, +v\n\t"
> +               "       li t1, 0x1\n"                           //size
> +               "       vsetvli t0, t1, e16, m2, ta, ma\n\t"    // Vector=
s of 16b
> +               "       addi t0, %[ptr], 1\n\t"                 // Misali=
gn address
> +               "       vle16.v v0, (t0)\n\t"                   // Load b=
ytes
> +               ".option pop\n\t"
> +               : : [ptr] "r" (&tmp_var) : "v0", "t0", "t1", "memory");
> +       kernel_vector_end();
> +
> +       misaligned_vec_suported =3D (*mas_ptr =3D=3D RISCV_HWPROBE_VEC_MI=
SALIGNED_UNKNOWN);
> +
> +       return misaligned_vec_suported;
> +}
> +#else
> +static bool check_vector_unaligned_access(int cpu)
> +{
> +       return false;
> +}
> +#endif
> +
> +bool check_vector_unaligned_access_all_cpus(void)
> +{
> +       int cpu;
> +
> +       for_each_online_cpu(cpu)
> +               if (!check_vector_unaligned_access(cpu))
> +                       return false;
> +
> +       return true;
> +}

These functions return a bool, but the bool is never checked. I'm
guessing that's because you're going to check it in a future patch
where you decide whether or not to probe for fast/slow?


> +
>  bool check_unaligned_access_emulated_all_cpus(void)
>  {
>         int cpu;
> diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kern=
el/unaligned_access_speed.c
> index a9a6bcb02acf..92a84239beaa 100644
> --- a/arch/riscv/kernel/unaligned_access_speed.c
> +++ b/arch/riscv/kernel/unaligned_access_speed.c
> @@ -20,6 +20,7 @@
>  #define MISALIGNED_COPY_SIZE ((MISALIGNED_BUFFER_SIZE / 2) - 0x80)
>
>  DEFINE_PER_CPU(long, misaligned_access_speed);
> +DEFINE_PER_CPU(long, vector_misaligned_access) =3D RISCV_HWPROBE_VEC_MIS=
ALIGNED_UNKNOWN;
>
>  #ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
>  static cpumask_t fast_misaligned_access;
> @@ -264,6 +265,8 @@ static int check_unaligned_access_all_cpus(void)
>  {
>         bool all_cpus_emulated =3D check_unaligned_access_emulated_all_cp=
us();
>
> +       check_vector_unaligned_access_all_cpus();
> +
>         if (!all_cpus_emulated)
>                 return check_unaligned_access_speed_all_cpus();
>
> @@ -273,6 +276,7 @@ static int check_unaligned_access_all_cpus(void)
>  static int check_unaligned_access_all_cpus(void)
>  {
>         check_unaligned_access_emulated_all_cpus();
> +       check_vector_unaligned_access_all_cpus();
>
>         return 0;
>  }
> --
> 2.43.0
>

