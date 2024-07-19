Return-Path: <linux-kernel+bounces-257659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC8B937D1D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 22:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 446FFB21D67
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 20:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9744696;
	Fri, 19 Jul 2024 20:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="bd2lPpLJ"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C533B145B25
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 20:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721419281; cv=none; b=X5+zdMCIokhC/+L5GfgWDydrftSwgYfcSGpP0RvRHDR1LbcFVCY/EEgDpPeifwH9bMQUkIChdkpj0H2RQHBGeW4kzbRWYRRQ7BePgg/FUYkmgSkOLWPJjy1XUNqXGaG8jtdu5T4JUZTQ4P6/j9ZzLRJ/apS+UiYiBiz08uYE5u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721419281; c=relaxed/simple;
	bh=nQ7BMSLoVWkoNRdVbksR5lAjQ/BiSF9QaDG5ggaLX6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJCRvjq121PdJ9lMCUb/ANPAlmhvvx0rR/2ZH8IJUkci4At1t2Tq6y3uKYXedLZ3y7Pec+UbE/seS+A/IxIpOTyximuXgXypYHuJCNW6XDqniHwsAPKODkk5C4et913v7OltG7ZppDgLFRzxRyYVsYrGM4iEuEFn+36gI/tQDLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=bd2lPpLJ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a77c1658c68so252373766b.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 13:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721419278; x=1722024078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQN/2tDh+sSLvXIwOxJnjG6tOl3wiLz/Ncfg5fVdJ8Y=;
        b=bd2lPpLJCMZ5/MoqQKNIKInUHhYoxUQycD3rMPZNMYUMFEW2v4cLXY8DE25J9GVhBE
         3CSblOJT3LCwlrlNrk/G263uYvoRYy7gxjgNE+8Sk30Y7OcjW526/3J7/R5kiGMoCNKr
         N7Qkd+7kk1ASZ3p/HqnVY6EYCtC2VW8J7R89VHQsYOSdW/2xDsjHkB+eM5qeJqRV4EJS
         MrxxZ8Ma/+u6oJ+IlNUfWgYJeyIXCXD2kIgTVDl43cWZNsMKa/XpOGitDPO5qjqD/j5w
         Kz6eXUzQ06tTz6Zf/RpdNhB/gdbOld5kAp9yyqEGe97NYvVZGgIIouObBK4JqhWEXfeg
         VmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721419278; x=1722024078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQN/2tDh+sSLvXIwOxJnjG6tOl3wiLz/Ncfg5fVdJ8Y=;
        b=B01XAvByaKOMmhHuI1uG7na0gsu4f6a6EWc56ucusy2wPWe2gUAA2Uh6u2TlfOHtQQ
         rm9CN5C4G3ufXZUEcw0T23mAiuWXlijoRohp81ahbyLckXZ5d/LYZPK+7+lTbwT1UheH
         mPO9eoaJNPHoIQqXtgjiLKbNaGPi8KihfVo6ryK+plukLpdsDUC6gd80yUZizctV7BCz
         WH2qv2K0R2rQMYrp6kzkV6GZR+lOSqTN75oqAqyy2hFwS4ZosrlNrA6zemRxCTZKda7y
         RGdh6lrmFlGlPYbHIgOFiB3v3K/rSAl+mnqGZGWmytUeT1TPtsNxAyOrTRxYfduMBAKc
         FIcw==
X-Forwarded-Encrypted: i=1; AJvYcCW4cK1qc6AVAyDL33JEpbK3vhrJi44vDh8bq3DZgoZcY9cD1+w40LHKRzC7mPfqKjeEcrh3XrsyNKASAinII0Z8s8WQOs8+U5Nu8M5k
X-Gm-Message-State: AOJu0YzBBsCWnNQdwPuplgbQ6NNsga5k7wFQxqkgWLrxKDveMTp/UFCr
	DNcwu1yv0sZiFwE73+SoUfFWaUMF62QPywsAx+R5X8jxX9a7eVglMfyIsg+h2mf7D2Iv9Pewpg6
	+fdURjpYVOSVPUg2pVrDq+Y6QnvSbreennBGYiw==
X-Google-Smtp-Source: AGHT+IGzYw3NDbd41ijficpd3X643glvwz6NPDfZmil0y/LKlD0gsUdcc5w0jyhoji4qy9VGryWvg6E2zlzqetOtT0w=
X-Received: by 2002:a17:906:7245:b0:a77:de2a:aef8 with SMTP id
 a640c23a62f3a-a7a013372a8mr637838166b.58.1721419277987; Fri, 19 Jul 2024
 13:01:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717180727.4180475-1-jesse@rivosinc.com> <20240717180727.4180475-6-jesse@rivosinc.com>
In-Reply-To: <20240717180727.4180475-6-jesse@rivosinc.com>
From: Evan Green <evan@rivosinc.com>
Date: Fri, 19 Jul 2024 13:00:42 -0700
Message-ID: <CALs-HsvOwvCs=WSrDhkJiGc3cwa7OgCzks6HOv=RpYjT1dpTtA@mail.gmail.com>
Subject: Re: [PATCH v5 5/7] RISC-V: Detect unaligned vector accesses supported
To: Jesse Taube <jesse@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Xiao Wang <xiao.w.wang@intel.com>, Andy Chiu <andy.chiu@sifive.com>, 
	Eric Biggers <ebiggers@google.com>, Greentime Hu <greentime.hu@sifive.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Heiko Stuebner <heiko@sntech.de>, Costa Shulyupin <costa.shul@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Anup Patel <apatel@ventanamicro.com>, Zong Li <zong.li@sifive.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Ben Dooks <ben.dooks@codethink.co.uk>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Erick Archer <erick.archer@gmx.com>, Joel Granados <j.granados@samsung.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 11:07=E2=80=AFAM Jesse Taube <jesse@rivosinc.com> w=
rote:
>
> Run a unaligned vector access to test if the system supports
> vector unaligned access. Add the result to a new key in hwprobe.
> This is useful for usermode to know if vector misaligned accesses are
> supported and if they are faster or slower than equivalent byte accesses.
>
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
> V1 -> V2:
>  - Add Kconfig options
>  - Add insn_is_vector
>  - Add handle_vector_misaligned_load
>  - Fix build
>  - Seperate vector from scalar misaligned access
>  - This patch was almost completely rewritten
> V2 -> V3:
>  - Fixed CONFIG_ in Kconfig
>  - Fixed check_vector_unaligned_access_emulated leaving
>      vector_misaligned_access as unknown.
>  - Remove local_irq_enable
>  - Remove RISCV_DETECT_VECTOR_UNALIGNED_ACCESS
>  - Remove RISCV_VEC_UNALIGNED_ACCESS_UNSUPPORTED
> V3 -> V4:
>  - Spell out _VECTOR_ in macros
> V4 -> V5:
>  - Change work_struct *unused to work_struct *work __always_unused
>  - Add insn_is_vector definition to vector.h when V is not defined
> ---
>  arch/riscv/Kconfig                         |  35 ++++++
>  arch/riscv/include/asm/cpufeature.h        |   5 +
>  arch/riscv/include/asm/entry-common.h      |  11 --
>  arch/riscv/include/asm/hwprobe.h           |   2 +-
>  arch/riscv/include/asm/vector.h            |   2 +
>  arch/riscv/include/uapi/asm/hwprobe.h      |   5 +
>  arch/riscv/kernel/Makefile                 |   4 +-
>  arch/riscv/kernel/sys_hwprobe.c            |  35 ++++++
>  arch/riscv/kernel/traps_misaligned.c       | 120 ++++++++++++++++++++-
>  arch/riscv/kernel/unaligned_access_speed.c |  22 ++--
>  arch/riscv/kernel/vector.c                 |   2 +-
>  11 files changed, 214 insertions(+), 29 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 34d24242e37a..ffbe0fdd7fb3 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -717,12 +717,26 @@ config THREAD_SIZE_ORDER
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
> @@ -774,6 +788,27 @@ config RISCV_EFFICIENT_UNALIGNED_ACCESS
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
>  endmenu # "Platform type"
>
>  menu "Kernel features"
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm=
/cpufeature.h
> index 0ed7d99c14dd..f25f56f9bfaa 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -45,6 +45,11 @@ static inline bool unaligned_ctl_available(void)
>  }
>  #endif
>
> +bool check_vector_unaligned_access_emulated_all_cpus(void);
> +#if defined(CONFIG_RISCV_VECTOR_MISALIGNED)
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
> index 150a9877b0af..ef01c182af2b 100644
> --- a/arch/riscv/include/asm/hwprobe.h
> +++ b/arch/riscv/include/asm/hwprobe.h
> @@ -8,7 +8,7 @@
>
>  #include <uapi/asm/hwprobe.h>
>
> -#define RISCV_HWPROBE_MAX_KEY 7
> +#define RISCV_HWPROBE_MAX_KEY 8
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
> index 023b7771d1b7..48b92fb07edf 100644
> --- a/arch/riscv/include/uapi/asm/hwprobe.h
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -75,6 +75,11 @@ struct riscv_hwprobe {
>  #define                RISCV_HWPROBE_MISALIGNED_MASK           (7 << 0)
>  #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE    6
>  #define RISCV_HWPROBE_KEY_MISALIGNED_PERF      7
> +#define RISCV_HWPROBE_KEY_VECTOR_MISALIGNED_PERF       8
> +#define                RISCV_HWPROBE_VECTOR_MISALIGNED_UNKNOWN         0
> +#define                RISCV_HWPROBE_VECTOR_MISALIGNED_SLOW            2
> +#define                RISCV_HWPROBE_VECTOR_MISALIGNED_FAST            3
> +#define                RISCV_HWPROBE_VECTOR_MISALIGNED_UNSUPPORTED     4
>  /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
>
>  /* Flags */
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 8d4e7d40e42f..5b243d46f4b1 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -62,8 +62,8 @@ obj-y +=3D probes/
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
> index e910e2971984..2e3e324bad38 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -194,6 +194,37 @@ static u64 hwprobe_misaligned(const struct cpumask *=
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
> +                       perf =3D RISCV_HWPROBE_VECTOR_MISALIGNED_UNKNOWN;
> +                       break;
> +               }
> +       }
> +
> +       if (perf =3D=3D -1ULL)
> +               return RISCV_HWPROBE_VECTOR_MISALIGNED_UNKNOWN;
> +
> +       return perf;
> +}
> +#else
> +static u64 hwprobe_vec_misaligned(const struct cpumask *cpus)
> +{
> +       return RISCV_HWPROBE_VECTOR_MISALIGNED_UNKNOWN;
> +}
> +#endif
> +
>  static void hwprobe_one_pair(struct riscv_hwprobe *pair,
>                              const struct cpumask *cpus)
>  {
> @@ -222,6 +253,10 @@ static void hwprobe_one_pair(struct riscv_hwprobe *p=
air,
>                 pair->value =3D hwprobe_misaligned(cpus);
>                 break;
>
> +       case RISCV_HWPROBE_KEY_VECTOR_MISALIGNED_PERF:
> +               pair->value =3D hwprobe_vec_misaligned(cpus);
> +               break;
> +
>         case RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE:
>                 pair->value =3D 0;
>                 if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOZ))
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/tra=
ps_misaligned.c
> index 9a1e94383d6d..6bccf5c9fe84 100644
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
_VECTOR_MISALIGNED_UNKNOWN) {
> +               *this_cpu_ptr(&vector_misaligned_access) =3D RISCV_HWPROB=
E_VECTOR_MISALIGNED_UNSUPPORTED;
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
> @@ -526,6 +552,86 @@ int handle_misaligned_store(struct pt_regs *regs)
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
> +static void check_vector_unaligned_access_emulated(struct work_struct *w=
ork __always_unused)
> +{
> +       long *mas_ptr =3D this_cpu_ptr(&vector_misaligned_access);
> +       unsigned long tmp_var;
> +
> +       *mas_ptr =3D RISCV_HWPROBE_VECTOR_MISALIGNED_UNKNOWN;
> +
> +       kernel_vector_begin();
> +       __asm__ __volatile__ (
> +               ".balign 4\n\t"
> +               ".option push\n\t"
> +               ".option arch, +zve32x\n\t"
> +               "       vsetivli zero, 1, e16, m1, ta, ma\n\t"  // Vector=
s of 16b
> +               "       vle16.v v0, (%[ptr])\n\t"               // Load b=
ytes
> +               ".option pop\n\t"
> +               : : [ptr] "r" ((u8 *)&tmp_var + 1) : "v0");
> +       kernel_vector_end();
> +
> +       if (*mas_ptr =3D=3D RISCV_HWPROBE_VECTOR_MISALIGNED_UNKNOWN)
> +               *mas_ptr =3D RISCV_HWPROBE_VECTOR_MISALIGNED_SLOW;

This is the spot I was talking about in patch 6. It looks like we're
saying if it's not emulated, and we didn't measure it, and nobody
overrode it via config, it must be slow. But really we don't know.




> +}
> +
> +bool check_vector_unaligned_access_emulated_all_cpus(void)
> +{
> +       int cpu;
> +
> +       if (!has_vector()) {
> +               for_each_online_cpu(cpu)
> +                       per_cpu(vector_misaligned_access, cpu) =3D RISCV_=
HWPROBE_VECTOR_MISALIGNED_UNSUPPORTED;
> +               return false;
> +       }
> +
> +       schedule_on_each_cpu(check_vector_unaligned_access_emulated);
> +
> +       for_each_online_cpu(cpu)
> +               if (per_cpu(vector_misaligned_access, cpu)
> +                   =3D=3D RISCV_HWPROBE_VECTOR_MISALIGNED_SLOW)
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
>  static void check_unaligned_access_emulated(struct work_struct *work __a=
lways_unused)
>  {
>         int cpu =3D smp_processor_id();
> @@ -574,3 +680,9 @@ bool unaligned_ctl_available(void)
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
> index a9a6bcb02acf..24b8883a23f0 100644
> --- a/arch/riscv/kernel/unaligned_access_speed.c
> +++ b/arch/riscv/kernel/unaligned_access_speed.c
> @@ -19,7 +19,8 @@
>  #define MISALIGNED_BUFFER_ORDER get_order(MISALIGNED_BUFFER_SIZE)
>  #define MISALIGNED_COPY_SIZE ((MISALIGNED_BUFFER_SIZE / 2) - 0x80)
>
> -DEFINE_PER_CPU(long, misaligned_access_speed);
> +DEFINE_PER_CPU(long, misaligned_access_speed) =3D RISCV_HWPROBE_MISALIGN=
ED_UNKNOWN;
> +DEFINE_PER_CPU(long, vector_misaligned_access) =3D RISCV_HWPROBE_VECTOR_=
MISALIGNED_UNSUPPORTED;
>
>  #ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
>  static cpumask_t fast_misaligned_access;
> @@ -259,23 +260,24 @@ static int check_unaligned_access_speed_all_cpus(vo=
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
> --
> 2.45.2
>

