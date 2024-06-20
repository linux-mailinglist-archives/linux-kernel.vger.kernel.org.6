Return-Path: <linux-kernel+bounces-223347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5395B9111D0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 21:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42130B2119B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D151B5824;
	Thu, 20 Jun 2024 18:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="B9+P2Q+5"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F401BA872
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 18:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718909551; cv=none; b=CPHOnmykkAMXg+YF55vRMDgOymk9bXqIo0CcU5YC9VUFw4EgCjdgsspXf/8WJRIw/vWXLz5Cd9tM4stdIM6xN8q0Wefgu7HXWUmvSLZAjoDmsNCOsVgT+DarVWzeh3mGxBEiCohm7WiRRH+UMFKOAn89ecKzKr/53qD69Bcd2tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718909551; c=relaxed/simple;
	bh=6ghkruHJHiXVWHumDPYm43TPgpSv+Q8OXIqJffDcyZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pEA8VSz4QyChEtuaDNGnj4C58NFbtuz/s59/oRiDHz+4bEOEX6OcgRXiW/1Kg6MCIIN5BJIRpWpFzVuhBYnfLoLMd+tj1xs9NvlDXywOIHIvYsOzVmnDQ9JofaxuIVGTDJ801ftvl9SAVQeqxPI8sSHeNnfJs/ibxkzgdmYuVh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=B9+P2Q+5; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2eaae2a6dc1so24032681fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 11:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718909547; x=1719514347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9G5TqQ4KN6hwyQLycXsVBdHW0uSyV4DHepVvCJG5kBg=;
        b=B9+P2Q+5Oxp5Un6VQ5e6tiUf0jwprvZb7YarPO4x19wsE0AolUHwEeIkhYit+7TBIC
         4SjNMScvR4iBfQMgrJ4+qhW7hgTHFqwSxUTk9oZW2Zo3eFkL1tm/w+zRcniipI5qNOyb
         a1Ok8OCUMt5R2BLxca+yKMnms0y/RU+SGqNlm+nyx/64IpMDPsxTkpEtpcRVXsfULh9h
         FZqsyAaMLMZ2i7Ixo5j7/tBbg9vg2S8hAqV/HkZCnSqZiISVvq1FhvlVZSiNp8wcJ6pc
         ZJIJbDQQxSpenFD2k0WVNPEP/IQR9l0ija5mtuTklWt82fMm9Dphtu45K8Bq1shUHNlV
         VJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718909547; x=1719514347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9G5TqQ4KN6hwyQLycXsVBdHW0uSyV4DHepVvCJG5kBg=;
        b=MScJWaMd3Hrw8cCgZrNLtM3v8oVVUNTqRMw71tbPcGnL0xEX24NVgNow63ezOcRe9Q
         Zeejy9oGisfDwDxPtmFEJhYkAVyAO7HAeWz0O5kNxrRPzzaqRXU6saYFjQcBAKPZGRSS
         TWAT2mCSOqLqaAVExcNVtNsKv0gTjCKM78ckkEmmZHAk+PTN5kOn5uAfq1PEn1+NawqQ
         xHZT8Y8Bjs+aUtCv17vORetaWWbPxZHWfo4u0cz3W0FpImCy41i32WR4ceK4pkhnqj/R
         Nu4BXeM2T7L8o3M8Rxfpz2vshgkf3LRyQKzLqQgL5Q71v7+hAVOV7QU25+jpvChFqxKM
         qWtw==
X-Forwarded-Encrypted: i=1; AJvYcCXI+vtIz38Kujh6DoMpY7oupu6lDd0UwOWUCJn8Lf5c65sXndueqr85U4kMe3FT1gQAn68t/s8loug/esTu/q6U/pfSgnacHAxX6J33
X-Gm-Message-State: AOJu0YxHueStZSn2Y0GiMnrryhsmLrQvhgSNMqQf5omkb8TCIG+6fu3Q
	1UNfgHehgeSS1e9YR8klHgUjrligW5W49i66jjnSTPjutk2hdfjuSpFL2UICQqHhXk8mPVo8sWp
	oPVr7fjkpJ78pMSNYG6UhQVkCJPW/6eeVgoMNXA==
X-Google-Smtp-Source: AGHT+IGMgaDR6i8vIDPdf4lHjCF1sEnHO5o7jV9vVJhCZSO8DcW5EOCsq0hqxfuvoL6cfFvHUZNsXBaxffk81VhCPCM=
X-Received: by 2002:a05:6512:3141:b0:52c:823f:2a10 with SMTP id
 2adb3069b0e04-52ccaa2a921mr4304599e87.1.1718909546600; Thu, 20 Jun 2024
 11:52:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613191616.2101821-1-jesse@rivosinc.com> <20240613191616.2101821-5-jesse@rivosinc.com>
In-Reply-To: <20240613191616.2101821-5-jesse@rivosinc.com>
From: Evan Green <evan@rivosinc.com>
Date: Thu, 20 Jun 2024 11:51:50 -0700
Message-ID: <CALs-HstfgymfToJcQcbpydxSFS4J6HB6Q0auwgrFbudYHV5Y7A@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] RISC-V: Detect unaligned vector accesses supported.
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

On Thu, Jun 13, 2024 at 12:17=E2=80=AFPM Jesse Taube <jesse@rivosinc.com> w=
rote:
>
> Run a unaligned vector access to test if the system supports
> vector unaligned access. Add the result to a new key in hwprobe.
> This is useful for usermode to know if vector misaligned accesses are
> supported and if they are faster or slower than equivalent byte accesses.
>
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> ---
> V1 -> V2:
>  - Add Kconfig options
>  - Add insn_is_vector
>  - Add handle_vector_misaligned_load
>  - Fix build
>  - Seperate vector from scalar misaligned access
>  - This patch was almost completely rewritten
> ---
>  arch/riscv/Kconfig                         |  41 +++++++
>  arch/riscv/include/asm/cpufeature.h        |   7 +-
>  arch/riscv/include/asm/entry-common.h      |  11 --
>  arch/riscv/include/asm/hwprobe.h           |   2 +-
>  arch/riscv/include/asm/vector.h            |   1 +
>  arch/riscv/include/uapi/asm/hwprobe.h      |   5 +
>  arch/riscv/kernel/Makefile                 |   4 +-
>  arch/riscv/kernel/sys_hwprobe.c            |  41 +++++++
>  arch/riscv/kernel/traps_misaligned.c       | 119 ++++++++++++++++++++-
>  arch/riscv/kernel/unaligned_access_speed.c |   9 +-
>  arch/riscv/kernel/vector.c                 |   2 +-
>  11 files changed, 221 insertions(+), 21 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index b94176e25be1..f12df0ca6c18 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -723,6 +723,12 @@ config RISCV_MISALIGNED
>         help
>           Embed support for emulating misaligned loads and stores.
>
> +config RISCV_VECTOR_MISALIGNED
> +       bool
> +       depends on RISCV_ISA_V
> +       help
> +         Enable detecting support for vector misaligned loads and stores=
.
> +
>  choice
>         prompt "Unaligned Accesses Support"
>         default RISCV_PROBE_UNALIGNED_ACCESS
> @@ -774,6 +780,41 @@ config RISCV_EFFICIENT_UNALIGNED_ACCESS
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
> +config RISCV_DETECT_VECTOR_UNALIGNED_ACCESS
> +       bool "Detect support for vector unaligned accesses"
> +       select RISCV_VECTOR_MISALIGNED
> +       help
> +         During boot, the kernel will detect if the system supports vect=
or
> +         unaligned accesses.
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
> +config CONFIG_RISCV_UNALIGNED_ACCESS_UNSUPPORTED
> +       bool "Assume the system does not support vector unaligned memory =
accesses"
> +       help
> +         Assume that the system does not support vector unaligned memory=
 accesses.
> +         The kernel and userspace programs may run them successfully on =
systems
> +         that do support vector unaligned memory accesses.
> +
> +endchoice
> +
>  endmenu # "Platform type"
>
>  menu "Kernel features"
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm=
/cpufeature.h
> index 347805446151..d0ea5921ab20 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -33,8 +33,8 @@ extern struct riscv_isainfo hart_isa[NR_CPUS];
>
>  void riscv_user_isa_enable(void);
>
> -#if defined(CONFIG_RISCV_MISALIGNED)
>  bool check_unaligned_access_emulated_all_cpus(void);
> +#if defined(CONFIG_RISCV_MISALIGNED)
>  void unaligned_emulation_finish(void);
>  bool unaligned_ctl_available(void);
>  DECLARE_PER_CPU(long, misaligned_access_speed);
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
> index 2293e535f865..7b32d2b08bb6 100644
> --- a/arch/riscv/include/asm/entry-common.h
> +++ b/arch/riscv/include/asm/entry-common.h
> @@ -25,18 +25,7 @@ static inline void arch_exit_to_user_mode_prepare(stru=
ct pt_regs *regs,
>  void handle_page_fault(struct pt_regs *regs);
>  void handle_break(struct pt_regs *regs);
>
> -#ifdef CONFIG_RISCV_MISALIGNED
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
> index be7d309cca8a..99b0f91db9ee 100644
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
> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/u=
api/asm/hwprobe.h
> index 023b7771d1b7..2fee870e41bb 100644
> --- a/arch/riscv/include/uapi/asm/hwprobe.h
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -75,6 +75,11 @@ struct riscv_hwprobe {
>  #define                RISCV_HWPROBE_MISALIGNED_MASK           (7 << 0)
>  #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE    6
>  #define RISCV_HWPROBE_KEY_MISALIGNED_PERF      7
> +#define RISCV_HWPROBE_KEY_VEC_MISALIGNED_PERF  8
> +#define                RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN            0
> +#define                RISCV_HWPROBE_VEC_MISALIGNED_SLOW               2
> +#define                RISCV_HWPROBE_VEC_MISALIGNED_FAST               3
> +#define                RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED        4
>  /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
>
>  /* Flags */
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 5b243d46f4b1..62ac19c029f1 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -62,8 +62,8 @@ obj-y +=3D probes/
>  obj-y  +=3D tests/
>  obj-$(CONFIG_MMU) +=3D vdso.o vdso/
>
> -obj-$(CONFIG_RISCV_MISALIGNED) +=3D traps_misaligned.o
> -obj-$(CONFIG_RISCV_MISALIGNED) +=3D unaligned_access_speed.o
> +obj-y  +=3D traps_misaligned.o
> +obj-y  +=3D unaligned_access_speed.o
>  obj-$(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)     +=3D copy-unaligned.o
>
>  obj-$(CONFIG_FPU)              +=3D fpu.o
> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwpr=
obe.c
> index e910e2971984..c40df314058b 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -194,6 +194,43 @@ static u64 hwprobe_misaligned(const struct cpumask *=
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
> +       if (IS_ENABLED(CONFIG_RISCV_UNALIGNED_ACCESS_UNSUPPORTED))
> +               return RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED;
> +
> +       /* Return if supported or not even if speed wasn't probed */
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
> +       if (IS_ENABLED(CONFIG_RISCV_UNALIGNED_ACCESS_UNSUPPORTED))
> +               return RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED;
> +
> +       return RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
> +}
> +#endif
> +
>  static void hwprobe_one_pair(struct riscv_hwprobe *pair,
>                              const struct cpumask *cpus)
>  {
> @@ -222,6 +259,10 @@ static void hwprobe_one_pair(struct riscv_hwprobe *p=
air,
>                 pair->value =3D hwprobe_misaligned(cpus);
>                 break;
>
> +       case RISCV_HWPROBE_KEY_VEC_MISALIGNED_PERF:
> +               pair->value =3D hwprobe_vec_misaligned(cpus);
> +               break;
> +
>         case RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE:
>                 pair->value =3D 0;
>                 if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOZ))
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/tra=
ps_misaligned.c
> index 8fadbe00dd62..6f0264a8c9de 100644
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
_VEC_MISALIGNED_UNKNOWN) {
> +               *this_cpu_ptr(&vector_misaligned_access) =3D RISCV_HWPROB=
E_VEC_MISALIGNED_UNSUPPORTED;
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
> @@ -526,6 +552,85 @@ int handle_misaligned_store(struct pt_regs *regs)
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
> +       if (IS_ENABLED(CONFIG_RISCV_MISALIGNED))
> +               return handle_scalar_misaligned_load(regs);
> +
> +       return -1;
> +}
> +
> +int handle_misaligned_store(struct pt_regs *regs)
> +{
> +       if (IS_ENABLED(CONFIG_RISCV_MISALIGNED))
> +               return handle_scalar_misaligned_store(regs);
> +
> +       return -1;
> +}
> +
> +#ifdef CONFIG_RISCV_VECTOR_MISALIGNED
> +static void check_vector_unaligned_access_emulated(struct work_struct *u=
nused)
> +{
> +       long *mas_ptr =3D this_cpu_ptr(&vector_misaligned_access);
> +       unsigned long tmp_var;
> +
> +       *mas_ptr =3D RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
> +
> +       local_irq_enable();

Generally if a function is called with interrupts disabled there's a
reason for it, like the system will crash if an interrupt fires during
execution of this region. I haven't researched this, but to feel
comfortable I'd want to know why interrupts were disabled on entry
here, why it's safe to enable them now, and why it's safe to return
from the function with them still enabled.

I'm guessing this was added because may_use_simd() was blowing up for
you without it. If that's the case, I think we'll need to reconcile
that in a different way. From a quick glance at kernel_mode_vector.c,
I was originally thinking may_use_simd() enforces this because there's
only a single instance of current->thread.kernel_vstate. So if you
tried to start a v context from an interrupt, you may land on top of
another kernel user, and there's nowhere to save that kernel user's
old state. But there does seem to be some support for nested V context
associated with CONFIG_RISCV_ISA_V_PREEMPTIVE, so I'm a little
confused. It seems like your options are to try and get running on
each CPU in a different manner (such that you're not stuck in irq
context by the time you first run), or try and dive into the kernel V
context code to enable support for starting a V context in irq land.


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
> +}
> +
> +bool check_vector_unaligned_access_emulated_all_cpus(void)
> +{
> +       int cpu;
> +       bool ret =3D true;
> +
> +       if (!has_vector()) {
> +               for_each_online_cpu(cpu)
> +                       per_cpu(vector_misaligned_access, cpu) =3D RISCV_=
HWPROBE_VEC_MISALIGNED_UNSUPPORTED;
> +               return false;
> +       }
> +
> +       schedule_on_each_cpu(check_vector_unaligned_access_emulated);
> +
> +       for_each_online_cpu(cpu)
> +               if (per_cpu(vector_misaligned_access, cpu)
> +                   !=3D RISCV_HWPROBE_VEC_MISALIGNED_SLOW)
> +                       return false;
> +
> +       return ret;
> +}
> +#else
> +bool check_vector_unaligned_access_emulated_all_cpus(void)
> +{
> +       return false;
> +}
> +#endif
> +
> +#ifdef CONFIG_RISCV_MISALIGNED
> +
> +static bool unaligned_ctl __read_mostly;
> +
>  static void check_unaligned_access_emulated(struct work_struct *unused)
>  {
>         int cpu =3D smp_processor_id();
> @@ -563,3 +668,9 @@ bool unaligned_ctl_available(void)
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
> index 70c1588fc353..c6106bd4a25a 100644
> --- a/arch/riscv/kernel/unaligned_access_speed.c
> +++ b/arch/riscv/kernel/unaligned_access_speed.c
> @@ -19,7 +19,8 @@
>  #define MISALIGNED_BUFFER_ORDER get_order(MISALIGNED_BUFFER_SIZE)
>  #define MISALIGNED_COPY_SIZE ((MISALIGNED_BUFFER_SIZE / 2) - 0x80)
>
> -DEFINE_PER_CPU(long, misaligned_access_speed);
> +DEFINE_PER_CPU(long, misaligned_access_speed) =3D RISCV_HWPROBE_MISALIGN=
ED_UNKNOWN;
> +DEFINE_PER_CPU(long, vector_misaligned_access) =3D RISCV_HWPROBE_VEC_MIS=
ALIGNED_UNSUPPORTED;
>
>  #ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
>  static cpumask_t fast_misaligned_access;
> @@ -268,12 +269,18 @@ static int check_unaligned_access_all_cpus(void)
>
>         if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICCLSM)) {
>                 for_each_online_cpu(cpu) {
> +#ifdef CONFIG_RISCV_VECTOR_MISALIGNED
> +                       per_cpu(vector_misaligned_access, cpu) =3D RISCV_=
HWPROBE_VEC_MISALIGNED_FAST;
> +#endif
> +#ifdef CONFIG_RISCV_MISALIGNED
>                         per_cpu(misaligned_access_speed, cpu) =3D RISCV_H=
WPROBE_MISALIGNED_FAST;
> +#endif
>                 }
>                 return 0;
>         }
>
>         all_cpus_emulated =3D check_unaligned_access_emulated_all_cpus();
> +       check_vector_unaligned_access_emulated_all_cpus();
>
>  #ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
>         if (!all_cpus_emulated)
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
> 2.43.0
>

