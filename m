Return-Path: <linux-kernel+bounces-372556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE069A4A45
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 01:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 019A4B21F98
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 23:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32CB1917EE;
	Fri, 18 Oct 2024 23:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEwhan1H"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E484817;
	Fri, 18 Oct 2024 23:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729295342; cv=none; b=ogJj69zMa0X0qXY6Am1hwFI1GzZWBL8aYnZvfzl+5dj4uHTdE9NWfWi8g5IBO+mCltO84y2N18X60h8kYcKjuw09R26kBGUzWiPLMB6t8+jHH0+lfx4H4IZwyVPfo1vGUf4EkjUbIF3cOAuU8rDDXW0vYCfd0me8DLREuJHT5kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729295342; c=relaxed/simple;
	bh=GhnUNF5iZ3m103WCnhw3Z7FlcFexZ/Vwhx0hR8rVWuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CxaA4GCM+CWglwVV3J7pPan2WLWCPSqWlW3YI8lWgnaiKzk9F2rCz8DXPEkcfFethfOnlaY/rdElIlRMByjduEfXSGykVInxmrLarKzAdairOuW7BxFlIwTxLjpRGa80HiTpAB5jwnf1+vPdeuY39OJ1eQfEvwpSySEhvqLrnrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VEwhan1H; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ea80863f12so1323654a12.1;
        Fri, 18 Oct 2024 16:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729295339; x=1729900139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MawndHlbU9xw39EYUrMR5DZqz4QwAdi7HjZ8xP+fSc=;
        b=VEwhan1HjmPtaaXWLRe9/ny9dArXoVCNcdv/R5JPPmofKH1GCP00sRxqaR/BHUgPkV
         uPakDe3s7tyL9spE1zmCQlspUaTK4uOzlAoNC+4cej27PPChy7NxESKAcaoK8JeKeUny
         OdUWK5ekIxPC4DaMRc7/2lZD8mHhx+diK+iK66Xn/Lg5k/fm36g8j8f2elMr3XlISjMo
         cJAgL4ILepsoGcrCGr7cHRVWFVA8z4cbQ3xVkp5PcJUvAzggeoWP6m5DgMLiaukNBAhD
         dTYvPyrPYVu1AHKnyCmzsAhQtInnyIc9DhAZ63K+rKirScPHvZys7HFRAfgbvR1qOz7a
         f7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729295339; x=1729900139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7MawndHlbU9xw39EYUrMR5DZqz4QwAdi7HjZ8xP+fSc=;
        b=GoM0jrUE7c+KXMk0zRJTwjg8azf+1UkMfpGSj3edXjKnB/c/+paqdFxBc8fC8Z1L0g
         aLZaT6FooXq/qkAounEZGUIdRwtxRS1+uCCp7XfKHIf8bx0HSC8+rjLK5jcayHVnwKkR
         m2xaK9AkdTh0Zl/mizt8BKFHUGBF3iML/0kiq8zoeJaIAYOfkYRXbX3DY47XA1pM8wMf
         RZpUXoEpkb0e+HOf9xGLCZXQojRqRUsWfNgw1+ZnE8qqeLOvOAan1G3LfOkOvTPfBe0B
         FcrJc0/+oCbNKLSfqedHRMxfL4//zoEF6fgNmwWFMs0+PpD8JCrToNQG0odNLbQAd82O
         ScVw==
X-Forwarded-Encrypted: i=1; AJvYcCVJlQlyw/0dgUshO634xIznTevzHvxo0LKHf+zt9i9Po/vEom7EVQsT8ro9PKPB73xfUOW9kHtnPho=@vger.kernel.org, AJvYcCW+yoduY0O5La/YsUU/Y0PFrp/oXK0ozlvSxWwQ7MkU3v0IV4T++I649xzmCF718QCMy7YDihlxFaKBpbVZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxqIbnysl68x4FlGS6OmyxWXwA0VVgus8XH+NeE255XbR+NYdy8
	QAUMuTr5qnnFbcDM+xokRt4G0Pw5ZHcN1KS+qxVsHF0zYgTn54umkdj+pdBFsW/aRh5Ul9bFNBz
	4r5Gx4TnH9k38hPXGdbIrhahStpA=
X-Google-Smtp-Source: AGHT+IFKvW17cyHTfXk6YU9Q8yG/FxLnFgF8sLgFg1f39v7WjuChFpb6DZYvll2Hf0VBbY6ayMwpi+4PiBqeh2OyuXA=
X-Received: by 2002:a05:6a21:a343:b0:1d2:bc91:d49 with SMTP id
 adf61e73a8af0-1d92c5729b6mr5882722637.31.1729295339218; Fri, 18 Oct 2024
 16:48:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017-jesse_unaligned_vector-v10-0-5b33500160f8@rivosinc.com> <20241017-jesse_unaligned_vector-v10-4-5b33500160f8@rivosinc.com>
In-Reply-To: <20241017-jesse_unaligned_vector-v10-4-5b33500160f8@rivosinc.com>
From: Jesse T <mr.bossman075@gmail.com>
Date: Fri, 18 Oct 2024 19:48:23 -0400
Message-ID: <CAJFTR8QX4mcaMnRKFZx9wrA8vg3qDdqUDXPoCDs8=-JV+kPAXA@mail.gmail.com>
Subject: Re: [PATCH v10 4/6] RISC-V: Detect unaligned vector accesses supported
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Evan Green <evan@rivosinc.com>, Jonathan Corbet <corbet@lwn.net>, Palmer Dabbelt <palmer@rivosinc.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Jesse Taube <jesse@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 3:02=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> From: Jesse Taube <jesse@rivosinc.com>
>
> Run an unaligned vector access to test if the system supports
> vector unaligned access. Add the result to a new key in hwprobe.
> This is useful for usermode to know if vector misaligned accesses are
> supported and if they are faster or slower than equivalent byte accesses.
>
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/Kconfig                         |  36 +++++++++
>  arch/riscv/include/asm/cpufeature.h        |   8 +-
>  arch/riscv/include/asm/entry-common.h      |  11 ---
>  arch/riscv/include/asm/hwprobe.h           |   2 +-
>  arch/riscv/include/asm/vector.h            |   2 +
>  arch/riscv/include/uapi/asm/hwprobe.h      |   5 ++
>  arch/riscv/kernel/Makefile                 |   4 +-
>  arch/riscv/kernel/sys_hwprobe.c            |  35 ++++++++
>  arch/riscv/kernel/traps_misaligned.c       | 125 +++++++++++++++++++++++=
+++++-
>  arch/riscv/kernel/unaligned_access_speed.c |  22 ++---
>  arch/riscv/kernel/vector.c                 |   2 +-
>  11 files changed, 222 insertions(+), 30 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 2d963d4a26d7..93f9a2958de7 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -765,12 +765,26 @@ config THREAD_SIZE_ORDER
>           Specify the Pages of thread stack size (from 4KB to 64KB), whic=
h also
>           affects irq stack size, which is equal to thread stack size.
>
> +config RISCV_MISALIGNED
> +       bool
> +       help
> +         Embed support for detecting and emulating misaligned
> +         scalar or vector loads and stores.
> +
>  config RISCV_SCALAR_MISALIGNED
>         bool
> +       select RISCV_MISALIGNED
>         select SYSCTL_ARCH_UNALIGN_ALLOW
>         help
>           Embed support for emulating misaligned loads and stores.
>
> +config RISCV_VECTOR_MISALIGNED
> +       bool
> +       select RISCV_MISALIGNED
> +       depends on RISCV_ISA_V
> +       help
> +         Enable detecting support for vector misaligned loads and stores=
.
> +
>  choice
>         prompt "Unaligned Accesses Support"
>         default RISCV_PROBE_UNALIGNED_ACCESS
> @@ -822,6 +836,28 @@ config RISCV_EFFICIENT_UNALIGNED_ACCESS
>
>  endchoice
>
> +choice
> +       prompt "Vector unaligned Accesses Support"
> +       depends on RISCV_ISA_V
> +       default RISCV_PROBE_VECTOR_UNALIGNED_ACCESS
> +       help
> +         This determines the level of support for vector unaligned acces=
ses. This
> +         information is used by the kernel to perform optimizations. It =
is also
> +         exposed to user space via the hwprobe syscall. The hardware wil=
l be
> +         probed at boot by default.
> +
> +config RISCV_PROBE_VECTOR_UNALIGNED_ACCESS
> +       bool "Probe speed of vector unaligned accesses"
> +       select RISCV_VECTOR_MISALIGNED
> +       depends on RISCV_ISA_V
> +       help
> +         During boot, the kernel will run a series of tests to determine=
 the
> +         speed of vector unaligned accesses if they are supported. This =
probing
> +         will dynamically determine the speed of vector unaligned access=
es on
> +         the underlying system if they are supported.
> +
> +endchoice
> +
>  source "arch/riscv/Kconfig.vendor"
>
>  endmenu # "Platform type"
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm=
/cpufeature.h
> index ccc6cf141c20..85bf1bce51e6 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -59,8 +59,8 @@ void riscv_user_isa_enable(void);
>  #define __RISCV_ISA_EXT_SUPERSET_VALIDATE(_name, _id, _sub_exts, _valida=
te) \
>         _RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts),=
 _validate)
>
> -#if defined(CONFIG_RISCV_SCALAR_MISALIGNED)
>  bool check_unaligned_access_emulated_all_cpus(void);
> +#if defined(CONFIG_RISCV_SCALAR_MISALIGNED)
>  void check_unaligned_access_emulated(struct work_struct *work __always_u=
nused);
>  void unaligned_emulation_finish(void);
>  bool unaligned_ctl_available(void);
> @@ -72,6 +72,12 @@ static inline bool unaligned_ctl_available(void)
>  }
>  #endif
>
> +bool check_vector_unaligned_access_emulated_all_cpus(void);
> +#if defined(CONFIG_RISCV_VECTOR_MISALIGNED)
> +void check_vector_unaligned_access_emulated(struct work_struct *work __a=
lways_unused);
> +DECLARE_PER_CPU(long, vector_misaligned_access);
> +#endif
> +
>  #if defined(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)
>  DECLARE_STATIC_KEY_FALSE(fast_unaligned_access_speed_key);
>
> diff --git a/arch/riscv/include/asm/entry-common.h b/arch/riscv/include/a=
sm/entry-common.h
> index 0a4e3544c877..7b32d2b08bb6 100644
> --- a/arch/riscv/include/asm/entry-common.h
> +++ b/arch/riscv/include/asm/entry-common.h
> @@ -25,18 +25,7 @@ static inline void arch_exit_to_user_mode_prepare(stru=
ct pt_regs *regs,
>  void handle_page_fault(struct pt_regs *regs);
>  void handle_break(struct pt_regs *regs);
>
> -#ifdef CONFIG_RISCV_SCALAR_MISALIGNED
>  int handle_misaligned_load(struct pt_regs *regs);
>  int handle_misaligned_store(struct pt_regs *regs);
> -#else
> -static inline int handle_misaligned_load(struct pt_regs *regs)
> -{
> -       return -1;
> -}
> -static inline int handle_misaligned_store(struct pt_regs *regs)
> -{
> -       return -1;
> -}
> -#endif
>
>  #endif /* _ASM_RISCV_ENTRY_COMMON_H */
> diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hw=
probe.h
> index ffb9484531af..1ce1df6d0ff3 100644
> --- a/arch/riscv/include/asm/hwprobe.h
> +++ b/arch/riscv/include/asm/hwprobe.h
> @@ -8,7 +8,7 @@
>
>  #include <uapi/asm/hwprobe.h>
>
> -#define RISCV_HWPROBE_MAX_KEY 9
> +#define RISCV_HWPROBE_MAX_KEY 10
>
>  static inline bool riscv_hwprobe_key_is_valid(__s64 key)
>  {
> diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vec=
tor.h
> index be7d309cca8a..c7c023afbacd 100644
> --- a/arch/riscv/include/asm/vector.h
> +++ b/arch/riscv/include/asm/vector.h
> @@ -21,6 +21,7 @@
>
>  extern unsigned long riscv_v_vsize;
>  int riscv_v_setup_vsize(void);
> +bool insn_is_vector(u32 insn_buf);
>  bool riscv_v_first_use_handler(struct pt_regs *regs);
>  void kernel_vector_begin(void);
>  void kernel_vector_end(void);
> @@ -268,6 +269,7 @@ struct pt_regs;
>
>  static inline int riscv_v_setup_vsize(void) { return -EOPNOTSUPP; }
>  static __always_inline bool has_vector(void) { return false; }
> +static __always_inline bool insn_is_vector(u32 insn_buf) { return false;=
 }
>  static inline bool riscv_v_first_use_handler(struct pt_regs *regs) { ret=
urn false; }
>  static inline bool riscv_v_vstate_query(struct pt_regs *regs) { return f=
alse; }
>  static inline bool riscv_v_vstate_ctrl_user_allowed(void) { return false=
; }
> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/u=
api/asm/hwprobe.h
> index 1e153cda57db..34c88c15322c 100644
> --- a/arch/riscv/include/uapi/asm/hwprobe.h
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -88,6 +88,11 @@ struct riscv_hwprobe {
>  #define                RISCV_HWPROBE_MISALIGNED_SCALAR_SLOW            2
>  #define                RISCV_HWPROBE_MISALIGNED_SCALAR_FAST            3
>  #define                RISCV_HWPROBE_MISALIGNED_SCALAR_UNSUPPORTED     4
> +#define RISCV_HWPROBE_KEY_MISALIGNED_VECTOR_PERF       10
> +#define                RISCV_HWPROBE_MISALIGNED_VECTOR_UNKNOWN         0
> +#define                RISCV_HWPROBE_MISALIGNED_VECTOR_SLOW            2
> +#define                RISCV_HWPROBE_MISALIGNED_VECTOR_FAST            3
> +#define                RISCV_HWPROBE_MISALIGNED_VECTOR_UNSUPPORTED     4
>  /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
>
>  /* Flags */
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 45624c5ea86c..7f88cc4931f5 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -68,8 +68,8 @@ obj-y +=3D probes/
>  obj-y  +=3D tests/
>  obj-$(CONFIG_MMU) +=3D vdso.o vdso/
>
> -obj-$(CONFIG_RISCV_SCALAR_MISALIGNED)  +=3D traps_misaligned.o
> -obj-$(CONFIG_RISCV_SCALAR_MISALIGNED)  +=3D unaligned_access_speed.o
> +obj-$(CONFIG_RISCV_MISALIGNED) +=3D traps_misaligned.o
> +obj-$(CONFIG_RISCV_MISALIGNED) +=3D unaligned_access_speed.o
>  obj-$(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)     +=3D copy-unaligned.o
>
>  obj-$(CONFIG_FPU)              +=3D fpu.o
> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwpr=
obe.c
> index cea0ca2bf2a2..6441baada36b 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -201,6 +201,37 @@ static u64 hwprobe_misaligned(const struct cpumask *=
cpus)
>  }
>  #endif
>
> +#ifdef CONFIG_RISCV_VECTOR_MISALIGNED
> +static u64 hwprobe_vec_misaligned(const struct cpumask *cpus)
> +{
> +       int cpu;
> +       u64 perf =3D -1ULL;
> +
> +       /* Return if supported or not even if speed wasn't probed */
> +       for_each_cpu(cpu, cpus) {
> +               int this_perf =3D per_cpu(vector_misaligned_access, cpu);
> +
> +               if (perf =3D=3D -1ULL)
> +                       perf =3D this_perf;
> +
> +               if (perf !=3D this_perf) {
> +                       perf =3D RISCV_HWPROBE_MISALIGNED_VECTOR_UNKNOWN;
> +                       break;
> +               }
> +       }
> +
> +       if (perf =3D=3D -1ULL)
> +               return RISCV_HWPROBE_MISALIGNED_VECTOR_UNKNOWN;
> +
> +       return perf;
> +}
> +#else
> +static u64 hwprobe_vec_misaligned(const struct cpumask *cpus)
> +{
> +       return RISCV_HWPROBE_MISALIGNED_VECTOR_UNKNOWN;
> +}
> +#endif
> +
>  static void hwprobe_one_pair(struct riscv_hwprobe *pair,
>                              const struct cpumask *cpus)
>  {
> @@ -229,6 +260,10 @@ static void hwprobe_one_pair(struct riscv_hwprobe *p=
air,
>                 pair->value =3D hwprobe_misaligned(cpus);
>                 break;
>
> +       case RISCV_HWPROBE_KEY_MISALIGNED_VECTOR_PERF:
> +               pair->value =3D hwprobe_vec_misaligned(cpus);
> +               break;
> +
>         case RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE:
>                 pair->value =3D 0;
>                 if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOZ))
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/tra=
ps_misaligned.c
> index d076dde5ad20..ef59ecfc64cb 100644
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
> @@ -322,12 +323,37 @@ union reg_data {
>         u64 data_u64;
>  };
>
> -static bool unaligned_ctl __read_mostly;
> -
>  /* sysctl hooks */
>  int unaligned_enabled __read_mostly =3D 1;       /* Enabled by default *=
/
>
> -int handle_misaligned_load(struct pt_regs *regs)
> +#ifdef CONFIG_RISCV_VECTOR_MISALIGNED
> +static int handle_vector_misaligned_load(struct pt_regs *regs)
> +{
> +       unsigned long epc =3D regs->epc;
> +       unsigned long insn;
> +
> +       if (get_insn(regs, epc, &insn))
> +               return -1;
> +
> +       /* Only return 0 when in check_vector_unaligned_access_emulated *=
/
> +       if (*this_cpu_ptr(&vector_misaligned_access) =3D=3D RISCV_HWPROBE=
_MISALIGNED_VECTOR_UNKNOWN) {
> +               *this_cpu_ptr(&vector_misaligned_access) =3D RISCV_HWPROB=
E_MISALIGNED_VECTOR_UNSUPPORTED;
> +               regs->epc =3D epc + INSN_LEN(insn);
> +               return 0;
> +       }
> +
> +       /* If vector instruction we don't emulate it yet */
> +       regs->epc =3D epc;
> +       return -1;
> +}
> +#else
> +static int handle_vector_misaligned_load(struct pt_regs *regs)
> +{
> +       return -1;
> +}
> +#endif
> +
> +static int handle_scalar_misaligned_load(struct pt_regs *regs)
>  {
>         union reg_data val;
>         unsigned long epc =3D regs->epc;
> @@ -435,7 +461,7 @@ int handle_misaligned_load(struct pt_regs *regs)
>         return 0;
>  }
>
> -int handle_misaligned_store(struct pt_regs *regs)
> +static int handle_scalar_misaligned_store(struct pt_regs *regs)
>  {
>         union reg_data val;
>         unsigned long epc =3D regs->epc;
> @@ -526,6 +552,91 @@ int handle_misaligned_store(struct pt_regs *regs)
>         return 0;
>  }
>
> +int handle_misaligned_load(struct pt_regs *regs)
> +{
> +       unsigned long epc =3D regs->epc;
> +       unsigned long insn;
> +
> +       if (IS_ENABLED(CONFIG_RISCV_VECTOR_MISALIGNED)) {
> +               if (get_insn(regs, epc, &insn))
> +                       return -1;
> +
> +               if (insn_is_vector(insn))
> +                       return handle_vector_misaligned_load(regs);
> +       }
> +
> +       if (IS_ENABLED(CONFIG_RISCV_SCALAR_MISALIGNED))
> +               return handle_scalar_misaligned_load(regs);
> +
> +       return -1;
> +}
> +
> +int handle_misaligned_store(struct pt_regs *regs)
> +{
> +       if (IS_ENABLED(CONFIG_RISCV_SCALAR_MISALIGNED))
> +               return handle_scalar_misaligned_store(regs);
> +
> +       return -1;
> +}
> +
> +#ifdef CONFIG_RISCV_VECTOR_MISALIGNED
> +void check_vector_unaligned_access_emulated(struct work_struct *work __a=
lways_unused)
> +{
> +       long *mas_ptr =3D this_cpu_ptr(&vector_misaligned_access);
> +       unsigned long tmp_var;
> +
> +       *mas_ptr =3D RISCV_HWPROBE_MISALIGNED_VECTOR_UNKNOWN;
> +
> +       kernel_vector_begin();
> +       /*
> +        * In pre-13.0.0 versions of GCC, vector registers cannot appear =
in
> +        * the clobber list. This inline asm clobbers v0, but since we do=
 not
> +        * currently build the kernel with V enabled, the v0 clobber arg =
is not
> +        * needed (as the compiler will not emit vector code itself). If =
the kernel
> +        * is changed to build with V enabled, the clobber arg will need =
to be
> +        * added here.
> +        */

Interesting. thanks for the fix!

> +       __asm__ __volatile__ (
> +               ".balign 4\n\t"
> +               ".option push\n\t"
> +               ".option arch, +zve32x\n\t"
> +               "       vsetivli zero, 1, e16, m1, ta, ma\n\t"  // Vector=
s of 16b
> +               "       vle16.v v0, (%[ptr])\n\t"               // Load b=
ytes
> +               ".option pop\n\t"
> +               : : [ptr] "r" ((u8 *)&tmp_var + 1));
> +       kernel_vector_end();
> +}
> +
> +bool check_vector_unaligned_access_emulated_all_cpus(void)
> +{
> +       int cpu;
> +
> +       if (!has_vector()) {
> +               for_each_online_cpu(cpu)
> +                       per_cpu(vector_misaligned_access, cpu) =3D RISCV_=
HWPROBE_MISALIGNED_VECTOR_UNSUPPORTED;
> +               return false;
> +       }
> +
> +       schedule_on_each_cpu(check_vector_unaligned_access_emulated);
> +
> +       for_each_online_cpu(cpu)
> +               if (per_cpu(vector_misaligned_access, cpu)
> +                   =3D=3D RISCV_HWPROBE_MISALIGNED_VECTOR_UNKNOWN)
> +                       return false;
> +
> +       return true;
> +}
> +#else
> +bool check_vector_unaligned_access_emulated_all_cpus(void)
> +{
> +       return false;
> +}
> +#endif
> +
> +#ifdef CONFIG_RISCV_SCALAR_MISALIGNED
> +
> +static bool unaligned_ctl __read_mostly;
> +
>  void check_unaligned_access_emulated(struct work_struct *work __always_u=
nused)
>  {
>         int cpu =3D smp_processor_id();
> @@ -574,3 +685,9 @@ bool unaligned_ctl_available(void)
>  {
>         return unaligned_ctl;
>  }
> +#else
> +bool check_unaligned_access_emulated_all_cpus(void)
> +{
> +       return false;
> +}
> +#endif
> diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kern=
el/unaligned_access_speed.c
> index f3508cc54f91..0b8b5e17453a 100644
> --- a/arch/riscv/kernel/unaligned_access_speed.c
> +++ b/arch/riscv/kernel/unaligned_access_speed.c
> @@ -19,7 +19,8 @@
>  #define MISALIGNED_BUFFER_ORDER get_order(MISALIGNED_BUFFER_SIZE)
>  #define MISALIGNED_COPY_SIZE ((MISALIGNED_BUFFER_SIZE / 2) - 0x80)
>
> -DEFINE_PER_CPU(long, misaligned_access_speed);
> +DEFINE_PER_CPU(long, misaligned_access_speed) =3D RISCV_HWPROBE_MISALIGN=
ED_SCALAR_UNKNOWN;
> +DEFINE_PER_CPU(long, vector_misaligned_access) =3D RISCV_HWPROBE_MISALIG=
NED_VECTOR_UNSUPPORTED;
>
>  #ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
>  static cpumask_t fast_misaligned_access;
> @@ -260,23 +261,24 @@ static int check_unaligned_access_speed_all_cpus(vo=
id)
>         kfree(bufs);
>         return 0;
>  }
> +#else /* CONFIG_RISCV_PROBE_UNALIGNED_ACCESS */
> +static int check_unaligned_access_speed_all_cpus(void)
> +{
> +       return 0;
> +}
> +#endif
>
>  static int check_unaligned_access_all_cpus(void)
>  {
> -       bool all_cpus_emulated =3D check_unaligned_access_emulated_all_cp=
us();
> +       bool all_cpus_emulated;
> +
> +       all_cpus_emulated =3D check_unaligned_access_emulated_all_cpus();
> +       check_vector_unaligned_access_emulated_all_cpus();
>
>         if (!all_cpus_emulated)
>                 return check_unaligned_access_speed_all_cpus();
>
>         return 0;
>  }
> -#else /* CONFIG_RISCV_PROBE_UNALIGNED_ACCESS */
> -static int check_unaligned_access_all_cpus(void)
> -{
> -       check_unaligned_access_emulated_all_cpus();
> -
> -       return 0;
> -}
> -#endif
>
>  arch_initcall(check_unaligned_access_all_cpus);
> diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
> index 682b3feee451..821818886fab 100644
> --- a/arch/riscv/kernel/vector.c
> +++ b/arch/riscv/kernel/vector.c
> @@ -66,7 +66,7 @@ void __init riscv_v_setup_ctx_cache(void)
>  #endif
>  }
>
> -static bool insn_is_vector(u32 insn_buf)
> +bool insn_is_vector(u32 insn_buf)
>  {
>         u32 opcode =3D insn_buf & __INSN_OPCODE_MASK;
>         u32 width, csr;
>
> --
> 2.45.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

