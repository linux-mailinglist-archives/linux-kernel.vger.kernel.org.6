Return-Path: <linux-kernel+bounces-226672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA0D914209
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 07:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BBAC1C22B1A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 05:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FB817C9B;
	Mon, 24 Jun 2024 05:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="m5MFIb1H"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469F917BB6
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 05:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719207265; cv=none; b=G9kBY+shr7ry9Cq9GmkSuWSnsmnktrgzztqsxV9yEdhi6VA4pgMfHCW3yCzAmLF1DLBRzgJEoBBEZVaglPu2JSd/UptQl0TRqICUJqIglpu7ZKG57bDcjsdvqnvNwyb2BbTy76ZrSN9p9HD550IUR5Q5srwCmVW8DrXkdt7qARI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719207265; c=relaxed/simple;
	bh=ze6yANGsbKRWJjJ5N6YFDadZu7gYJSQs8eGFPuJoRUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jwvs8xi6rGsPJz8pTZrmPvI7RqJItg+seqqBFe5RBVz6Nn2T/RjaD+8KogB4lN5y2Jta2iS6TvhQDcZevvzaHTIodFCfaY8gD1lSry102F6xnQOZUyjGPwVcXrLj5xQulhRyir+Z+CS+Jfbn3N59GCO/662OQnyieMuqfE7dEs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=m5MFIb1H; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-643f1ee4b3cso7844817b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 22:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1719207261; x=1719812061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UeWyyfkb7a4207kwnEGRo4PB2tXmIdzzpoMSmt9wUU=;
        b=m5MFIb1HRfXcwkecr+B90vEXcHUXWOpErQur037UEVtnWB4ATjnbUvLQ1+ZpUYDwY0
         I5BCuhPBWJOpVAlA1bhGZ/CbdyxFYR7CQm3HwKkPruw0Hw8ek5P/MOXlVC3U3m9vbnWA
         nxXSZZzRmCdELO2zfKJX1kNw+9IVGazG0hWO5H1XV6XKTHAuW9whyfdwUM8yJjS7G0/W
         2qlq9N4RhUswtmYDoXoHPz1nzErT997HzXm5ytmcZIaHnCf+lXjrtlcKq02+GaSafUXJ
         Sa8MtyP3Db1pggM9ErwLQNCOCcRnOKn9QY80gbdXHs46xB0Fc2Cp9ndhYv52Si+dT006
         obfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719207261; x=1719812061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+UeWyyfkb7a4207kwnEGRo4PB2tXmIdzzpoMSmt9wUU=;
        b=EX7ee5s8tClbwIv5K7vIRTiqpksdE1kc8XkT5hhXqa72YARQ1B70QGZE3t3FtR1fuM
         cau/P4zSSNLEq0CBo2O1zUer1c19/t9DeIizhPcRX2w7xPxjSSTUzo5zSzvLh8reRlCN
         zyRM0QjKsjFJiq90bkNni5zf+pHWniQaE/1FyrnwvzDKyKjTixsAFInzAM+bfHrWAS6V
         Dm9D82TZutUcaI1UxjcrxJXosVrYB39B+bJj88ahbJsoQw5ZLOtjQyby77IJs5MfnVPx
         yEkipqFaDkw00rmyqqUr0K5/0TxWW3c4LNkdHQPgm1tYqGGPpHFLqcadgK25EtXI8Q+i
         iMZg==
X-Forwarded-Encrypted: i=1; AJvYcCWcI0csbEmC+x7ndb/s4PSsWAUhddt7FStZgKtNnxSuwaUIdck8a1QFpBWgssAe72/eHcgxHMl6LtlBGhAs4nsprjKtwrqAhygae4YK
X-Gm-Message-State: AOJu0YwfCUPci9FGvuL2CMctdLG0dxoShGeIbMOUuDX6/zGPpxrIY8c/
	LllnqCIenvYbxaRmaQGNH72xvIw4qbxE3KKFNpujKfM7u+1jnpSpFLY0RXKYn7kdHG7ADn5P14f
	A8SHbjTl8X9HTj7vnTMbKnMcWtB9rWJAU1y3HFA==
X-Google-Smtp-Source: AGHT+IFZFdSY9BaeuXzLSJlaLQ9QUaeHWm9jqkx7BnKMiz/+wLNstEU2XZKv2YTxNpInLHWj+zbOAKIU3GWgHYzsETo=
X-Received: by 2002:a05:690c:ecd:b0:632:5b24:c0c with SMTP id
 00721157ae682-643a990bee0mr38851447b3.5.1719207261022; Sun, 23 Jun 2024
 22:34:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613191616.2101821-1-jesse@rivosinc.com> <20240613191616.2101821-5-jesse@rivosinc.com>
 <CALs-HstfgymfToJcQcbpydxSFS4J6HB6Q0auwgrFbudYHV5Y7A@mail.gmail.com>
In-Reply-To: <CALs-HstfgymfToJcQcbpydxSFS4J6HB6Q0auwgrFbudYHV5Y7A@mail.gmail.com>
From: Andy Chiu <andy.chiu@sifive.com>
Date: Mon, 24 Jun 2024 13:34:09 +0800
Message-ID: <CABgGipUdO7RpEiQ37NDnqN_E1MiDjR+WfRwzejhY3kKdrx7e-w@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] RISC-V: Detect unaligned vector accesses supported.
To: Evan Green <evan@rivosinc.com>
Cc: Jesse Taube <jesse@rivosinc.com>, linux-riscv@lists.infradead.org, 
	Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Xiao Wang <xiao.w.wang@intel.com>, Eric Biggers <ebiggers@google.com>, 
	Greentime Hu <greentime.hu@sifive.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Heiko Stuebner <heiko@sntech.de>, Costa Shulyupin <costa.shul@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Anup Patel <apatel@ventanamicro.com>, Zong Li <zong.li@sifive.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Ben Dooks <ben.dooks@codethink.co.uk>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Erick Archer <erick.archer@gmx.com>, Joel Granados <j.granados@samsung.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 2:52=E2=80=AFAM Evan Green <evan@rivosinc.com> wrot=
e:
>
> On Thu, Jun 13, 2024 at 12:17=E2=80=AFPM Jesse Taube <jesse@rivosinc.com>=
 wrote:
> >
> > Run a unaligned vector access to test if the system supports
> > vector unaligned access. Add the result to a new key in hwprobe.
> > This is useful for usermode to know if vector misaligned accesses are
> > supported and if they are faster or slower than equivalent byte accesse=
s.
> >
> > Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> > ---
> > V1 -> V2:
> >  - Add Kconfig options
> >  - Add insn_is_vector
> >  - Add handle_vector_misaligned_load
> >  - Fix build
> >  - Seperate vector from scalar misaligned access
> >  - This patch was almost completely rewritten
> > ---
> >  arch/riscv/Kconfig                         |  41 +++++++
> >  arch/riscv/include/asm/cpufeature.h        |   7 +-
> >  arch/riscv/include/asm/entry-common.h      |  11 --
> >  arch/riscv/include/asm/hwprobe.h           |   2 +-
> >  arch/riscv/include/asm/vector.h            |   1 +
> >  arch/riscv/include/uapi/asm/hwprobe.h      |   5 +
> >  arch/riscv/kernel/Makefile                 |   4 +-
> >  arch/riscv/kernel/sys_hwprobe.c            |  41 +++++++
> >  arch/riscv/kernel/traps_misaligned.c       | 119 ++++++++++++++++++++-
> >  arch/riscv/kernel/unaligned_access_speed.c |   9 +-
> >  arch/riscv/kernel/vector.c                 |   2 +-
> >  11 files changed, 221 insertions(+), 21 deletions(-)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index b94176e25be1..f12df0ca6c18 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -723,6 +723,12 @@ config RISCV_MISALIGNED
> >         help
> >           Embed support for emulating misaligned loads and stores.
> >
> > +config RISCV_VECTOR_MISALIGNED
> > +       bool
> > +       depends on RISCV_ISA_V
> > +       help
> > +         Enable detecting support for vector misaligned loads and stor=
es.
> > +
> >  choice
> >         prompt "Unaligned Accesses Support"
> >         default RISCV_PROBE_UNALIGNED_ACCESS
> > @@ -774,6 +780,41 @@ config RISCV_EFFICIENT_UNALIGNED_ACCESS
> >
> >  endchoice
> >
> > +choice
> > +       prompt "Vector unaligned Accesses Support"
> > +       depends on RISCV_ISA_V
> > +       default RISCV_PROBE_VECTOR_UNALIGNED_ACCESS
> > +       help
> > +         This determines the level of support for vector unaligned acc=
esses. This
> > +         information is used by the kernel to perform optimizations. I=
t is also
> > +         exposed to user space via the hwprobe syscall. The hardware w=
ill be
> > +         probed at boot by default.
> > +
> > +config RISCV_DETECT_VECTOR_UNALIGNED_ACCESS
> > +       bool "Detect support for vector unaligned accesses"
> > +       select RISCV_VECTOR_MISALIGNED
> > +       help
> > +         During boot, the kernel will detect if the system supports ve=
ctor
> > +         unaligned accesses.
> > +
> > +config RISCV_PROBE_VECTOR_UNALIGNED_ACCESS
> > +       bool "Probe speed of vector unaligned accesses"
> > +       select RISCV_VECTOR_MISALIGNED
> > +       help
> > +         During boot, the kernel will run a series of tests to determi=
ne the
> > +         speed of vector unaligned accesses if they are supported. Thi=
s probing
> > +         will dynamically determine the speed of vector unaligned acce=
sses on
> > +         the underlying system if they are supported.
> > +
> > +config CONFIG_RISCV_UNALIGNED_ACCESS_UNSUPPORTED
> > +       bool "Assume the system does not support vector unaligned memor=
y accesses"
> > +       help
> > +         Assume that the system does not support vector unaligned memo=
ry accesses.
> > +         The kernel and userspace programs may run them successfully o=
n systems
> > +         that do support vector unaligned memory accesses.
> > +
> > +endchoice
> > +
> >  endmenu # "Platform type"
> >
> >  menu "Kernel features"
> > diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/a=
sm/cpufeature.h
> > index 347805446151..d0ea5921ab20 100644
> > --- a/arch/riscv/include/asm/cpufeature.h
> > +++ b/arch/riscv/include/asm/cpufeature.h
> > @@ -33,8 +33,8 @@ extern struct riscv_isainfo hart_isa[NR_CPUS];
> >
> >  void riscv_user_isa_enable(void);
> >
> > -#if defined(CONFIG_RISCV_MISALIGNED)
> >  bool check_unaligned_access_emulated_all_cpus(void);
> > +#if defined(CONFIG_RISCV_MISALIGNED)
> >  void unaligned_emulation_finish(void);
> >  bool unaligned_ctl_available(void);
> >  DECLARE_PER_CPU(long, misaligned_access_speed);
> > @@ -45,6 +45,11 @@ static inline bool unaligned_ctl_available(void)
> >  }
> >  #endif
> >
> > +bool check_vector_unaligned_access_emulated_all_cpus(void);
> > +#if defined(CONFIG_RISCV_VECTOR_MISALIGNED)
> > +DECLARE_PER_CPU(long, vector_misaligned_access);
> > +#endif
> > +
> >  #if defined(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)
> >  DECLARE_STATIC_KEY_FALSE(fast_unaligned_access_speed_key);
> >
> > diff --git a/arch/riscv/include/asm/entry-common.h b/arch/riscv/include=
/asm/entry-common.h
> > index 2293e535f865..7b32d2b08bb6 100644
> > --- a/arch/riscv/include/asm/entry-common.h
> > +++ b/arch/riscv/include/asm/entry-common.h
> > @@ -25,18 +25,7 @@ static inline void arch_exit_to_user_mode_prepare(st=
ruct pt_regs *regs,
> >  void handle_page_fault(struct pt_regs *regs);
> >  void handle_break(struct pt_regs *regs);
> >
> > -#ifdef CONFIG_RISCV_MISALIGNED
> >  int handle_misaligned_load(struct pt_regs *regs);
> >  int handle_misaligned_store(struct pt_regs *regs);
> > -#else
> > -static inline int handle_misaligned_load(struct pt_regs *regs)
> > -{
> > -       return -1;
> > -}
> > -static inline int handle_misaligned_store(struct pt_regs *regs)
> > -{
> > -       return -1;
> > -}
> > -#endif
> >
> >  #endif /* _ASM_RISCV_ENTRY_COMMON_H */
> > diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/=
hwprobe.h
> > index 150a9877b0af..ef01c182af2b 100644
> > --- a/arch/riscv/include/asm/hwprobe.h
> > +++ b/arch/riscv/include/asm/hwprobe.h
> > @@ -8,7 +8,7 @@
> >
> >  #include <uapi/asm/hwprobe.h>
> >
> > -#define RISCV_HWPROBE_MAX_KEY 7
> > +#define RISCV_HWPROBE_MAX_KEY 8
> >
> >  static inline bool riscv_hwprobe_key_is_valid(__s64 key)
> >  {
> > diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/v=
ector.h
> > index be7d309cca8a..99b0f91db9ee 100644
> > --- a/arch/riscv/include/asm/vector.h
> > +++ b/arch/riscv/include/asm/vector.h
> > @@ -21,6 +21,7 @@
> >
> >  extern unsigned long riscv_v_vsize;
> >  int riscv_v_setup_vsize(void);
> > +bool insn_is_vector(u32 insn_buf);
> >  bool riscv_v_first_use_handler(struct pt_regs *regs);
> >  void kernel_vector_begin(void);
> >  void kernel_vector_end(void);
> > diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include=
/uapi/asm/hwprobe.h
> > index 023b7771d1b7..2fee870e41bb 100644
> > --- a/arch/riscv/include/uapi/asm/hwprobe.h
> > +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> > @@ -75,6 +75,11 @@ struct riscv_hwprobe {
> >  #define                RISCV_HWPROBE_MISALIGNED_MASK           (7 << 0=
)
> >  #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE    6
> >  #define RISCV_HWPROBE_KEY_MISALIGNED_PERF      7
> > +#define RISCV_HWPROBE_KEY_VEC_MISALIGNED_PERF  8
> > +#define                RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN           =
 0
> > +#define                RISCV_HWPROBE_VEC_MISALIGNED_SLOW              =
 2
> > +#define                RISCV_HWPROBE_VEC_MISALIGNED_FAST              =
 3
> > +#define                RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED       =
 4
> >  /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
> >
> >  /* Flags */
> > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > index 5b243d46f4b1..62ac19c029f1 100644
> > --- a/arch/riscv/kernel/Makefile
> > +++ b/arch/riscv/kernel/Makefile
> > @@ -62,8 +62,8 @@ obj-y +=3D probes/
> >  obj-y  +=3D tests/
> >  obj-$(CONFIG_MMU) +=3D vdso.o vdso/
> >
> > -obj-$(CONFIG_RISCV_MISALIGNED) +=3D traps_misaligned.o
> > -obj-$(CONFIG_RISCV_MISALIGNED) +=3D unaligned_access_speed.o
> > +obj-y  +=3D traps_misaligned.o
> > +obj-y  +=3D unaligned_access_speed.o
> >  obj-$(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)     +=3D copy-unaligned.o
> >
> >  obj-$(CONFIG_FPU)              +=3D fpu.o
> > diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hw=
probe.c
> > index e910e2971984..c40df314058b 100644
> > --- a/arch/riscv/kernel/sys_hwprobe.c
> > +++ b/arch/riscv/kernel/sys_hwprobe.c
> > @@ -194,6 +194,43 @@ static u64 hwprobe_misaligned(const struct cpumask=
 *cpus)
> >  }
> >  #endif
> >
> > +#ifdef CONFIG_RISCV_VECTOR_MISALIGNED
> > +static u64 hwprobe_vec_misaligned(const struct cpumask *cpus)
> > +{
> > +       int cpu;
> > +       u64 perf =3D -1ULL;
> > +
> > +       if (IS_ENABLED(CONFIG_RISCV_UNALIGNED_ACCESS_UNSUPPORTED))
> > +               return RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED;
> > +
> > +       /* Return if supported or not even if speed wasn't probed */
> > +       for_each_cpu(cpu, cpus) {
> > +               int this_perf =3D per_cpu(vector_misaligned_access, cpu=
);
> > +
> > +               if (perf =3D=3D -1ULL)
> > +                       perf =3D this_perf;
> > +
> > +               if (perf !=3D this_perf) {
> > +                       perf =3D RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
> > +                       break;
> > +               }
> > +       }
> > +
> > +       if (perf =3D=3D -1ULL)
> > +               return RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
> > +
> > +       return perf;
> > +}
> > +#else
> > +static u64 hwprobe_vec_misaligned(const struct cpumask *cpus)
> > +{
> > +       if (IS_ENABLED(CONFIG_RISCV_UNALIGNED_ACCESS_UNSUPPORTED))
> > +               return RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED;
> > +
> > +       return RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
> > +}
> > +#endif
> > +
> >  static void hwprobe_one_pair(struct riscv_hwprobe *pair,
> >                              const struct cpumask *cpus)
> >  {
> > @@ -222,6 +259,10 @@ static void hwprobe_one_pair(struct riscv_hwprobe =
*pair,
> >                 pair->value =3D hwprobe_misaligned(cpus);
> >                 break;
> >
> > +       case RISCV_HWPROBE_KEY_VEC_MISALIGNED_PERF:
> > +               pair->value =3D hwprobe_vec_misaligned(cpus);
> > +               break;
> > +
> >         case RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE:
> >                 pair->value =3D 0;
> >                 if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOZ))
> > diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/t=
raps_misaligned.c
> > index 8fadbe00dd62..6f0264a8c9de 100644
> > --- a/arch/riscv/kernel/traps_misaligned.c
> > +++ b/arch/riscv/kernel/traps_misaligned.c
> > @@ -16,6 +16,7 @@
> >  #include <asm/entry-common.h>
> >  #include <asm/hwprobe.h>
> >  #include <asm/cpufeature.h>
> > +#include <asm/vector.h>
> >
> >  #define INSN_MATCH_LB                  0x3
> >  #define INSN_MASK_LB                   0x707f
> > @@ -322,12 +323,37 @@ union reg_data {
> >         u64 data_u64;
> >  };
> >
> > -static bool unaligned_ctl __read_mostly;
> > -
> >  /* sysctl hooks */
> >  int unaligned_enabled __read_mostly =3D 1;       /* Enabled by default=
 */
> >
> > -int handle_misaligned_load(struct pt_regs *regs)
> > +#ifdef CONFIG_RISCV_VECTOR_MISALIGNED
> > +static int handle_vector_misaligned_load(struct pt_regs *regs)
> > +{
> > +       unsigned long epc =3D regs->epc;
> > +       unsigned long insn;
> > +
> > +       if (get_insn(regs, epc, &insn))
> > +               return -1;
> > +
> > +       /* Only return 0 when in check_vector_unaligned_access_emulated=
 */
> > +       if (*this_cpu_ptr(&vector_misaligned_access) =3D=3D RISCV_HWPRO=
BE_VEC_MISALIGNED_UNKNOWN) {
> > +               *this_cpu_ptr(&vector_misaligned_access) =3D RISCV_HWPR=
OBE_VEC_MISALIGNED_UNSUPPORTED;
> > +               regs->epc =3D epc + INSN_LEN(insn);
> > +               return 0;
> > +       }
> > +
> > +       /* If vector instruction we don't emulate it yet */
> > +       regs->epc =3D epc;
> > +       return -1;
> > +}
> > +#else
> > +static int handle_vector_misaligned_load(struct pt_regs *regs)
> > +{
> > +       return -1;
> > +}
> > +#endif
> > +
> > +static int handle_scalar_misaligned_load(struct pt_regs *regs)
> >  {
> >         union reg_data val;
> >         unsigned long epc =3D regs->epc;
> > @@ -435,7 +461,7 @@ int handle_misaligned_load(struct pt_regs *regs)
> >         return 0;
> >  }
> >
> > -int handle_misaligned_store(struct pt_regs *regs)
> > +static int handle_scalar_misaligned_store(struct pt_regs *regs)
> >  {
> >         union reg_data val;
> >         unsigned long epc =3D regs->epc;
> > @@ -526,6 +552,85 @@ int handle_misaligned_store(struct pt_regs *regs)
> >         return 0;
> >  }
> >
> > +int handle_misaligned_load(struct pt_regs *regs)
> > +{
> > +       unsigned long epc =3D regs->epc;
> > +       unsigned long insn;
> > +
> > +       if (IS_ENABLED(CONFIG_RISCV_VECTOR_MISALIGNED)) {
> > +               if (get_insn(regs, epc, &insn))
> > +                       return -1;
> > +
> > +               if (insn_is_vector(insn))
> > +                       return handle_vector_misaligned_load(regs);
> > +       }
> > +
> > +       if (IS_ENABLED(CONFIG_RISCV_MISALIGNED))
> > +               return handle_scalar_misaligned_load(regs);
> > +
> > +       return -1;
> > +}
> > +
> > +int handle_misaligned_store(struct pt_regs *regs)
> > +{
> > +       if (IS_ENABLED(CONFIG_RISCV_MISALIGNED))
> > +               return handle_scalar_misaligned_store(regs);
> > +
> > +       return -1;
> > +}
> > +
> > +#ifdef CONFIG_RISCV_VECTOR_MISALIGNED
> > +static void check_vector_unaligned_access_emulated(struct work_struct =
*unused)
> > +{
> > +       long *mas_ptr =3D this_cpu_ptr(&vector_misaligned_access);
> > +       unsigned long tmp_var;
> > +
> > +       *mas_ptr =3D RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
> > +
> > +       local_irq_enable();
>
> Generally if a function is called with interrupts disabled there's a
> reason for it, like the system will crash if an interrupt fires during
> execution of this region. I haven't researched this, but to feel
> comfortable I'd want to know why interrupts were disabled on entry
> here, why it's safe to enable them now, and why it's safe to return
> from the function with them still enabled.
>
> I'm guessing this was added because may_use_simd() was blowing up for
> you without it. If that's the case, I think we'll need to reconcile
> that in a different way. From a quick glance at kernel_mode_vector.c,
> I was originally thinking may_use_simd() enforces this because there's

Current nesting support of kernel mode vector only allows softirq
context to use v context nesting on top of kernel thread's v context.
I did not expect the use of v in the interrupt handler but I am open
to discussions if it is needed.

The reason why may_use_simd() checks for irq_disabled() is that
local_bh_enable later in kernel_vector_end() expects running with irq
on. Although the success path of preemptible v does not require
!irq_disabled(), the kernel falls back to non-preemptible v
(get_cpu_vector_context) in some cases. First is the nesting softirq
case, or a rare case where an exception handler uses v in a kernel
fault that also uses v. The second is when memory allocation for
kernel_vstate fails. The fall back uses the non-preemptible v, so it
is linked to bh_*.

We can get rid of the last case by failing the launch of a kernel
thread when the allocation fails.

> only a single instance of current->thread.kernel_vstate. So if you
> tried to start a v context from an interrupt, you may land on top of
> another kernel user, and there's nowhere to save that kernel user's
> old state. But there does seem to be some support for nested V context
> associated with CONFIG_RISCV_ISA_V_PREEMPTIVE, so I'm a little
> confused. It seems like your options are to try and get running on
> each CPU in a different manner (such that you're not stuck in irq
> context by the time you first run), or try and dive into the kernel V
> context code to enable support for starting a V context in irq land.
>
>
> > +       kernel_vector_begin();
> > +       __asm__ __volatile__ (
> > +               ".balign 4\n\t"
> > +               ".option push\n\t"
> > +               ".option arch, +zve32x\n\t"
> > +               "       vsetivli zero, 1, e16, m1, ta, ma\n\t"  // Vect=
ors of 16b
> > +               "       vle16.v v0, (%[ptr])\n\t"               // Load=
 bytes
> > +               ".option pop\n\t"
> > +               : : [ptr] "r" ((u8 *)&tmp_var + 1) : "v0");
> > +       kernel_vector_end();
> > +}
> > +
> > +bool check_vector_unaligned_access_emulated_all_cpus(void)
> > +{
> > +       int cpu;
> > +       bool ret =3D true;
> > +
> > +       if (!has_vector()) {
> > +               for_each_online_cpu(cpu)
> > +                       per_cpu(vector_misaligned_access, cpu) =3D RISC=
V_HWPROBE_VEC_MISALIGNED_UNSUPPORTED;
> > +               return false;
> > +       }
> > +
> > +       schedule_on_each_cpu(check_vector_unaligned_access_emulated);
> > +
> > +       for_each_online_cpu(cpu)
> > +               if (per_cpu(vector_misaligned_access, cpu)
> > +                   !=3D RISCV_HWPROBE_VEC_MISALIGNED_SLOW)
> > +                       return false;
> > +
> > +       return ret;
> > +}
> > +#else
> > +bool check_vector_unaligned_access_emulated_all_cpus(void)
> > +{
> > +       return false;
> > +}
> > +#endif
> > +
> > +#ifdef CONFIG_RISCV_MISALIGNED
> > +
> > +static bool unaligned_ctl __read_mostly;
> > +
> >  static void check_unaligned_access_emulated(struct work_struct *unused=
)
> >  {
> >         int cpu =3D smp_processor_id();
> > @@ -563,3 +668,9 @@ bool unaligned_ctl_available(void)
> >  {
> >         return unaligned_ctl;
> >  }
> > +#else
> > +bool check_unaligned_access_emulated_all_cpus(void)
> > +{
> > +       return false;
> > +}
> > +#endif
> > diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/ke=
rnel/unaligned_access_speed.c
> > index 70c1588fc353..c6106bd4a25a 100644
> > --- a/arch/riscv/kernel/unaligned_access_speed.c
> > +++ b/arch/riscv/kernel/unaligned_access_speed.c
> > @@ -19,7 +19,8 @@
> >  #define MISALIGNED_BUFFER_ORDER get_order(MISALIGNED_BUFFER_SIZE)
> >  #define MISALIGNED_COPY_SIZE ((MISALIGNED_BUFFER_SIZE / 2) - 0x80)
> >
> > -DEFINE_PER_CPU(long, misaligned_access_speed);
> > +DEFINE_PER_CPU(long, misaligned_access_speed) =3D RISCV_HWPROBE_MISALI=
GNED_UNKNOWN;
> > +DEFINE_PER_CPU(long, vector_misaligned_access) =3D RISCV_HWPROBE_VEC_M=
ISALIGNED_UNSUPPORTED;
> >
> >  #ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
> >  static cpumask_t fast_misaligned_access;
> > @@ -268,12 +269,18 @@ static int check_unaligned_access_all_cpus(void)
> >
> >         if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICCLSM)) {
> >                 for_each_online_cpu(cpu) {
> > +#ifdef CONFIG_RISCV_VECTOR_MISALIGNED
> > +                       per_cpu(vector_misaligned_access, cpu) =3D RISC=
V_HWPROBE_VEC_MISALIGNED_FAST;
> > +#endif
> > +#ifdef CONFIG_RISCV_MISALIGNED
> >                         per_cpu(misaligned_access_speed, cpu) =3D RISCV=
_HWPROBE_MISALIGNED_FAST;
> > +#endif
> >                 }
> >                 return 0;
> >         }
> >
> >         all_cpus_emulated =3D check_unaligned_access_emulated_all_cpus(=
);
> > +       check_vector_unaligned_access_emulated_all_cpus();
> >
> >  #ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
> >         if (!all_cpus_emulated)
> > diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
> > index 682b3feee451..821818886fab 100644
> > --- a/arch/riscv/kernel/vector.c
> > +++ b/arch/riscv/kernel/vector.c
> > @@ -66,7 +66,7 @@ void __init riscv_v_setup_ctx_cache(void)
> >  #endif
> >  }
> >
> > -static bool insn_is_vector(u32 insn_buf)
> > +bool insn_is_vector(u32 insn_buf)
> >  {
> >         u32 opcode =3D insn_buf & __INSN_OPCODE_MASK;
> >         u32 width, csr;
> > --
> > 2.43.0
> >

Thanks,
Andy

