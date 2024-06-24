Return-Path: <linux-kernel+bounces-227641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A93599154E2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC6581C213A6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5FA19E7FD;
	Mon, 24 Jun 2024 16:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="dBbshNbk"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342C019E7F2
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 16:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719248287; cv=none; b=KLRh15EWmBVjm1G6Yzzu3HykYNoNh5C62J++2xsR6//tT7ce9FLfHOVvXfZOyiv96PbR0ZL0N9dKqRY3234N8g59RE/gD4g83096hSA4rCvV3gjZ+zCbysvUgVAak21xlkkF10/uFLZsd7rGW+9A5fnB3CmP1O39WI1dJOIVmq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719248287; c=relaxed/simple;
	bh=r3nZswJ41E0voi4YXgimaSQlwyVrj5ieX2Y/9xfbl3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PrWF4SRxNLPxVUg8xmP+mzMIO/yiW7BB+sFkvP1Km2f0cQwxn0APxMQnlyIE40hEzawnE/hyYBBZZkZkI4QaLwFhXTfu8W2M7omXZw9XQ1rQBUymzJfgEynkWnNjz5hRiwvIHqGob7MWcTvNuljWacz2Zka83F3uvxPqgSVXYgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=dBbshNbk; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a70c0349b64so211081066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 09:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719248282; x=1719853082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRPCqebu/AX5gc3Uv7ixpDRh6o6MyphSglOvbTCG2W0=;
        b=dBbshNbk0tSM9qrPnQ2gypkgP4QULra5U2yJz/ZrieWAjQer3tuznj8ppqcq7fv/wc
         83cHs/zBh8ljdAUP8x8xFA3taVr6a/1FO9ssH13bNCW5JRgJr5NybvTGHcyRD4nxGo51
         MyKg6qKbaCkGA9zl7Hw2JGjPF5GlFMXkKXPJABkQNDhCv1hJuGqal90pGzO/r5IkYRVj
         9fYVWojQZBpJu/mCwgedSn8pKaO9opIvP4CQHQ/g4APlMBEazKUzxlYmjWlgriL4tN3x
         f+3B49cIwq7ghMIbEkq5qRbNPMHGpGiKGul6nn1bASbAkaCb/pV+W/AfVC46JGyJrHk/
         EwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719248282; x=1719853082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRPCqebu/AX5gc3Uv7ixpDRh6o6MyphSglOvbTCG2W0=;
        b=A819mFUE+dgiRaj1R1ZdYq6HfrnlfDCwWa5ULwF2GNM4Qn3eT7ZGRO4Xz0i39cFoeW
         0p2Kp56DD+xBIhvb5RIGD6WTYuq7nrecDuGjcDEx6NflIWkkD16iH4TZXvS4iN6NDlh0
         FSaPyxZo6z7EJNbJ1+Oq1l78+UzNodV6kqDTdHEh95JLKNgdlkTSGLhgFX566oTWeLgi
         XPAevLO2kbAtHvZ+uIC4gif05caiYbcmOPhLljBMYSg5nqFxMovGA7VF6KqNoyrNYo78
         oJdKRR5Ak9n+yR5QGAUij6ayMmWmH0mBBIl9Vr7wEXNn5eBjFFQdY6/T0DRMktQ5VhQs
         VZ0A==
X-Forwarded-Encrypted: i=1; AJvYcCXIo6ix04/WOiqE8Q0fKAdKdT7wO5jUKse/wlURBePm0KxeVldvES55LeYIjdwT6vwTLr3hloZyUqf0fLQXNK6LEEKroWKSaOVv9Avp
X-Gm-Message-State: AOJu0Yzb04RDXTmI0YW2TLGy/rQcFg+5fFGMG/shRI9kE+E7vxnzvh8V
	G1jPPcv+i8kQb+KmjeO9GKpdQfnKQJFFnSI5rK3crHXrcX23AXQIDgM5jnHWotHk2M+Sbld48yk
	leuOy/kPs88hTRQl1+7e6S7BcX1eZINKFKMNBwg==
X-Google-Smtp-Source: AGHT+IFqoOwhgtbULUrMYL38uL82a8KuC0iQDFg7FGvyBZpJ+ZoXfVL+qRaFBYMkgAnHIz7FEDz7GKmOY5w0nlVeAwM=
X-Received: by 2002:a17:907:874e:b0:a6f:b7a0:3e73 with SMTP id
 a640c23a62f3a-a715f9cb6ebmr364095666b.49.1719248282409; Mon, 24 Jun 2024
 09:58:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613191616.2101821-1-jesse@rivosinc.com> <20240613191616.2101821-5-jesse@rivosinc.com>
 <CALs-HstfgymfToJcQcbpydxSFS4J6HB6Q0auwgrFbudYHV5Y7A@mail.gmail.com> <CABgGipUdO7RpEiQ37NDnqN_E1MiDjR+WfRwzejhY3kKdrx7e-w@mail.gmail.com>
In-Reply-To: <CABgGipUdO7RpEiQ37NDnqN_E1MiDjR+WfRwzejhY3kKdrx7e-w@mail.gmail.com>
From: Evan Green <evan@rivosinc.com>
Date: Mon, 24 Jun 2024 09:57:26 -0700
Message-ID: <CALs-HstXQB1cymNdQU+3g8XKVtyeZ8bZFgPmsO=ShvsAQYcAeg@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] RISC-V: Detect unaligned vector accesses supported.
To: Andy Chiu <andy.chiu@sifive.com>
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

On Sun, Jun 23, 2024 at 10:34=E2=80=AFPM Andy Chiu <andy.chiu@sifive.com> w=
rote:
>
> On Fri, Jun 21, 2024 at 2:52=E2=80=AFAM Evan Green <evan@rivosinc.com> wr=
ote:
> >
> > On Thu, Jun 13, 2024 at 12:17=E2=80=AFPM Jesse Taube <jesse@rivosinc.co=
m> wrote:
> > >
> > > Run a unaligned vector access to test if the system supports
> > > vector unaligned access. Add the result to a new key in hwprobe.
> > > This is useful for usermode to know if vector misaligned accesses are
> > > supported and if they are faster or slower than equivalent byte acces=
ses.
> > >
> > > Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> > > ---
> > > V1 -> V2:
> > >  - Add Kconfig options
> > >  - Add insn_is_vector
> > >  - Add handle_vector_misaligned_load
> > >  - Fix build
> > >  - Seperate vector from scalar misaligned access
> > >  - This patch was almost completely rewritten
> > > ---
> > >  arch/riscv/Kconfig                         |  41 +++++++
> > >  arch/riscv/include/asm/cpufeature.h        |   7 +-
> > >  arch/riscv/include/asm/entry-common.h      |  11 --
> > >  arch/riscv/include/asm/hwprobe.h           |   2 +-
> > >  arch/riscv/include/asm/vector.h            |   1 +
> > >  arch/riscv/include/uapi/asm/hwprobe.h      |   5 +
> > >  arch/riscv/kernel/Makefile                 |   4 +-
> > >  arch/riscv/kernel/sys_hwprobe.c            |  41 +++++++
> > >  arch/riscv/kernel/traps_misaligned.c       | 119 +++++++++++++++++++=
+-
> > >  arch/riscv/kernel/unaligned_access_speed.c |   9 +-
> > >  arch/riscv/kernel/vector.c                 |   2 +-
> > >  11 files changed, 221 insertions(+), 21 deletions(-)
> > >
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index b94176e25be1..f12df0ca6c18 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -723,6 +723,12 @@ config RISCV_MISALIGNED
> > >         help
> > >           Embed support for emulating misaligned loads and stores.
> > >
> > > +config RISCV_VECTOR_MISALIGNED
> > > +       bool
> > > +       depends on RISCV_ISA_V
> > > +       help
> > > +         Enable detecting support for vector misaligned loads and st=
ores.
> > > +
> > >  choice
> > >         prompt "Unaligned Accesses Support"
> > >         default RISCV_PROBE_UNALIGNED_ACCESS
> > > @@ -774,6 +780,41 @@ config RISCV_EFFICIENT_UNALIGNED_ACCESS
> > >
> > >  endchoice
> > >
> > > +choice
> > > +       prompt "Vector unaligned Accesses Support"
> > > +       depends on RISCV_ISA_V
> > > +       default RISCV_PROBE_VECTOR_UNALIGNED_ACCESS
> > > +       help
> > > +         This determines the level of support for vector unaligned a=
ccesses. This
> > > +         information is used by the kernel to perform optimizations.=
 It is also
> > > +         exposed to user space via the hwprobe syscall. The hardware=
 will be
> > > +         probed at boot by default.
> > > +
> > > +config RISCV_DETECT_VECTOR_UNALIGNED_ACCESS
> > > +       bool "Detect support for vector unaligned accesses"
> > > +       select RISCV_VECTOR_MISALIGNED
> > > +       help
> > > +         During boot, the kernel will detect if the system supports =
vector
> > > +         unaligned accesses.
> > > +
> > > +config RISCV_PROBE_VECTOR_UNALIGNED_ACCESS
> > > +       bool "Probe speed of vector unaligned accesses"
> > > +       select RISCV_VECTOR_MISALIGNED
> > > +       help
> > > +         During boot, the kernel will run a series of tests to deter=
mine the
> > > +         speed of vector unaligned accesses if they are supported. T=
his probing
> > > +         will dynamically determine the speed of vector unaligned ac=
cesses on
> > > +         the underlying system if they are supported.
> > > +
> > > +config CONFIG_RISCV_UNALIGNED_ACCESS_UNSUPPORTED
> > > +       bool "Assume the system does not support vector unaligned mem=
ory accesses"
> > > +       help
> > > +         Assume that the system does not support vector unaligned me=
mory accesses.
> > > +         The kernel and userspace programs may run them successfully=
 on systems
> > > +         that do support vector unaligned memory accesses.
> > > +
> > > +endchoice
> > > +
> > >  endmenu # "Platform type"
> > >
> > >  menu "Kernel features"
> > > diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include=
/asm/cpufeature.h
> > > index 347805446151..d0ea5921ab20 100644
> > > --- a/arch/riscv/include/asm/cpufeature.h
> > > +++ b/arch/riscv/include/asm/cpufeature.h
> > > @@ -33,8 +33,8 @@ extern struct riscv_isainfo hart_isa[NR_CPUS];
> > >
> > >  void riscv_user_isa_enable(void);
> > >
> > > -#if defined(CONFIG_RISCV_MISALIGNED)
> > >  bool check_unaligned_access_emulated_all_cpus(void);
> > > +#if defined(CONFIG_RISCV_MISALIGNED)
> > >  void unaligned_emulation_finish(void);
> > >  bool unaligned_ctl_available(void);
> > >  DECLARE_PER_CPU(long, misaligned_access_speed);
> > > @@ -45,6 +45,11 @@ static inline bool unaligned_ctl_available(void)
> > >  }
> > >  #endif
> > >
> > > +bool check_vector_unaligned_access_emulated_all_cpus(void);
> > > +#if defined(CONFIG_RISCV_VECTOR_MISALIGNED)
> > > +DECLARE_PER_CPU(long, vector_misaligned_access);
> > > +#endif
> > > +
> > >  #if defined(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)
> > >  DECLARE_STATIC_KEY_FALSE(fast_unaligned_access_speed_key);
> > >
> > > diff --git a/arch/riscv/include/asm/entry-common.h b/arch/riscv/inclu=
de/asm/entry-common.h
> > > index 2293e535f865..7b32d2b08bb6 100644
> > > --- a/arch/riscv/include/asm/entry-common.h
> > > +++ b/arch/riscv/include/asm/entry-common.h
> > > @@ -25,18 +25,7 @@ static inline void arch_exit_to_user_mode_prepare(=
struct pt_regs *regs,
> > >  void handle_page_fault(struct pt_regs *regs);
> > >  void handle_break(struct pt_regs *regs);
> > >
> > > -#ifdef CONFIG_RISCV_MISALIGNED
> > >  int handle_misaligned_load(struct pt_regs *regs);
> > >  int handle_misaligned_store(struct pt_regs *regs);
> > > -#else
> > > -static inline int handle_misaligned_load(struct pt_regs *regs)
> > > -{
> > > -       return -1;
> > > -}
> > > -static inline int handle_misaligned_store(struct pt_regs *regs)
> > > -{
> > > -       return -1;
> > > -}
> > > -#endif
> > >
> > >  #endif /* _ASM_RISCV_ENTRY_COMMON_H */
> > > diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/as=
m/hwprobe.h
> > > index 150a9877b0af..ef01c182af2b 100644
> > > --- a/arch/riscv/include/asm/hwprobe.h
> > > +++ b/arch/riscv/include/asm/hwprobe.h
> > > @@ -8,7 +8,7 @@
> > >
> > >  #include <uapi/asm/hwprobe.h>
> > >
> > > -#define RISCV_HWPROBE_MAX_KEY 7
> > > +#define RISCV_HWPROBE_MAX_KEY 8
> > >
> > >  static inline bool riscv_hwprobe_key_is_valid(__s64 key)
> > >  {
> > > diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm=
/vector.h
> > > index be7d309cca8a..99b0f91db9ee 100644
> > > --- a/arch/riscv/include/asm/vector.h
> > > +++ b/arch/riscv/include/asm/vector.h
> > > @@ -21,6 +21,7 @@
> > >
> > >  extern unsigned long riscv_v_vsize;
> > >  int riscv_v_setup_vsize(void);
> > > +bool insn_is_vector(u32 insn_buf);
> > >  bool riscv_v_first_use_handler(struct pt_regs *regs);
> > >  void kernel_vector_begin(void);
> > >  void kernel_vector_end(void);
> > > diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/inclu=
de/uapi/asm/hwprobe.h
> > > index 023b7771d1b7..2fee870e41bb 100644
> > > --- a/arch/riscv/include/uapi/asm/hwprobe.h
> > > +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> > > @@ -75,6 +75,11 @@ struct riscv_hwprobe {
> > >  #define                RISCV_HWPROBE_MISALIGNED_MASK           (7 <<=
 0)
> > >  #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE    6
> > >  #define RISCV_HWPROBE_KEY_MISALIGNED_PERF      7
> > > +#define RISCV_HWPROBE_KEY_VEC_MISALIGNED_PERF  8
> > > +#define                RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN         =
   0
> > > +#define                RISCV_HWPROBE_VEC_MISALIGNED_SLOW            =
   2
> > > +#define                RISCV_HWPROBE_VEC_MISALIGNED_FAST            =
   3
> > > +#define                RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED     =
   4
> > >  /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
> > >
> > >  /* Flags */
> > > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > > index 5b243d46f4b1..62ac19c029f1 100644
> > > --- a/arch/riscv/kernel/Makefile
> > > +++ b/arch/riscv/kernel/Makefile
> > > @@ -62,8 +62,8 @@ obj-y +=3D probes/
> > >  obj-y  +=3D tests/
> > >  obj-$(CONFIG_MMU) +=3D vdso.o vdso/
> > >
> > > -obj-$(CONFIG_RISCV_MISALIGNED) +=3D traps_misaligned.o
> > > -obj-$(CONFIG_RISCV_MISALIGNED) +=3D unaligned_access_speed.o
> > > +obj-y  +=3D traps_misaligned.o
> > > +obj-y  +=3D unaligned_access_speed.o
> > >  obj-$(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)     +=3D copy-unaligned.o
> > >
> > >  obj-$(CONFIG_FPU)              +=3D fpu.o
> > > diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_=
hwprobe.c
> > > index e910e2971984..c40df314058b 100644
> > > --- a/arch/riscv/kernel/sys_hwprobe.c
> > > +++ b/arch/riscv/kernel/sys_hwprobe.c
> > > @@ -194,6 +194,43 @@ static u64 hwprobe_misaligned(const struct cpuma=
sk *cpus)
> > >  }
> > >  #endif
> > >
> > > +#ifdef CONFIG_RISCV_VECTOR_MISALIGNED
> > > +static u64 hwprobe_vec_misaligned(const struct cpumask *cpus)
> > > +{
> > > +       int cpu;
> > > +       u64 perf =3D -1ULL;
> > > +
> > > +       if (IS_ENABLED(CONFIG_RISCV_UNALIGNED_ACCESS_UNSUPPORTED))
> > > +               return RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED;
> > > +
> > > +       /* Return if supported or not even if speed wasn't probed */
> > > +       for_each_cpu(cpu, cpus) {
> > > +               int this_perf =3D per_cpu(vector_misaligned_access, c=
pu);
> > > +
> > > +               if (perf =3D=3D -1ULL)
> > > +                       perf =3D this_perf;
> > > +
> > > +               if (perf !=3D this_perf) {
> > > +                       perf =3D RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN=
;
> > > +                       break;
> > > +               }
> > > +       }
> > > +
> > > +       if (perf =3D=3D -1ULL)
> > > +               return RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
> > > +
> > > +       return perf;
> > > +}
> > > +#else
> > > +static u64 hwprobe_vec_misaligned(const struct cpumask *cpus)
> > > +{
> > > +       if (IS_ENABLED(CONFIG_RISCV_UNALIGNED_ACCESS_UNSUPPORTED))
> > > +               return RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED;
> > > +
> > > +       return RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
> > > +}
> > > +#endif
> > > +
> > >  static void hwprobe_one_pair(struct riscv_hwprobe *pair,
> > >                              const struct cpumask *cpus)
> > >  {
> > > @@ -222,6 +259,10 @@ static void hwprobe_one_pair(struct riscv_hwprob=
e *pair,
> > >                 pair->value =3D hwprobe_misaligned(cpus);
> > >                 break;
> > >
> > > +       case RISCV_HWPROBE_KEY_VEC_MISALIGNED_PERF:
> > > +               pair->value =3D hwprobe_vec_misaligned(cpus);
> > > +               break;
> > > +
> > >         case RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE:
> > >                 pair->value =3D 0;
> > >                 if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOZ))
> > > diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel=
/traps_misaligned.c
> > > index 8fadbe00dd62..6f0264a8c9de 100644
> > > --- a/arch/riscv/kernel/traps_misaligned.c
> > > +++ b/arch/riscv/kernel/traps_misaligned.c
> > > @@ -16,6 +16,7 @@
> > >  #include <asm/entry-common.h>
> > >  #include <asm/hwprobe.h>
> > >  #include <asm/cpufeature.h>
> > > +#include <asm/vector.h>
> > >
> > >  #define INSN_MATCH_LB                  0x3
> > >  #define INSN_MASK_LB                   0x707f
> > > @@ -322,12 +323,37 @@ union reg_data {
> > >         u64 data_u64;
> > >  };
> > >
> > > -static bool unaligned_ctl __read_mostly;
> > > -
> > >  /* sysctl hooks */
> > >  int unaligned_enabled __read_mostly =3D 1;       /* Enabled by defau=
lt */
> > >
> > > -int handle_misaligned_load(struct pt_regs *regs)
> > > +#ifdef CONFIG_RISCV_VECTOR_MISALIGNED
> > > +static int handle_vector_misaligned_load(struct pt_regs *regs)
> > > +{
> > > +       unsigned long epc =3D regs->epc;
> > > +       unsigned long insn;
> > > +
> > > +       if (get_insn(regs, epc, &insn))
> > > +               return -1;
> > > +
> > > +       /* Only return 0 when in check_vector_unaligned_access_emulat=
ed */
> > > +       if (*this_cpu_ptr(&vector_misaligned_access) =3D=3D RISCV_HWP=
ROBE_VEC_MISALIGNED_UNKNOWN) {
> > > +               *this_cpu_ptr(&vector_misaligned_access) =3D RISCV_HW=
PROBE_VEC_MISALIGNED_UNSUPPORTED;
> > > +               regs->epc =3D epc + INSN_LEN(insn);
> > > +               return 0;
> > > +       }
> > > +
> > > +       /* If vector instruction we don't emulate it yet */
> > > +       regs->epc =3D epc;
> > > +       return -1;
> > > +}
> > > +#else
> > > +static int handle_vector_misaligned_load(struct pt_regs *regs)
> > > +{
> > > +       return -1;
> > > +}
> > > +#endif
> > > +
> > > +static int handle_scalar_misaligned_load(struct pt_regs *regs)
> > >  {
> > >         union reg_data val;
> > >         unsigned long epc =3D regs->epc;
> > > @@ -435,7 +461,7 @@ int handle_misaligned_load(struct pt_regs *regs)
> > >         return 0;
> > >  }
> > >
> > > -int handle_misaligned_store(struct pt_regs *regs)
> > > +static int handle_scalar_misaligned_store(struct pt_regs *regs)
> > >  {
> > >         union reg_data val;
> > >         unsigned long epc =3D regs->epc;
> > > @@ -526,6 +552,85 @@ int handle_misaligned_store(struct pt_regs *regs=
)
> > >         return 0;
> > >  }
> > >
> > > +int handle_misaligned_load(struct pt_regs *regs)
> > > +{
> > > +       unsigned long epc =3D regs->epc;
> > > +       unsigned long insn;
> > > +
> > > +       if (IS_ENABLED(CONFIG_RISCV_VECTOR_MISALIGNED)) {
> > > +               if (get_insn(regs, epc, &insn))
> > > +                       return -1;
> > > +
> > > +               if (insn_is_vector(insn))
> > > +                       return handle_vector_misaligned_load(regs);
> > > +       }
> > > +
> > > +       if (IS_ENABLED(CONFIG_RISCV_MISALIGNED))
> > > +               return handle_scalar_misaligned_load(regs);
> > > +
> > > +       return -1;
> > > +}
> > > +
> > > +int handle_misaligned_store(struct pt_regs *regs)
> > > +{
> > > +       if (IS_ENABLED(CONFIG_RISCV_MISALIGNED))
> > > +               return handle_scalar_misaligned_store(regs);
> > > +
> > > +       return -1;
> > > +}
> > > +
> > > +#ifdef CONFIG_RISCV_VECTOR_MISALIGNED
> > > +static void check_vector_unaligned_access_emulated(struct work_struc=
t *unused)
> > > +{
> > > +       long *mas_ptr =3D this_cpu_ptr(&vector_misaligned_access);
> > > +       unsigned long tmp_var;
> > > +
> > > +       *mas_ptr =3D RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
> > > +
> > > +       local_irq_enable();
> >
> > Generally if a function is called with interrupts disabled there's a
> > reason for it, like the system will crash if an interrupt fires during
> > execution of this region. I haven't researched this, but to feel
> > comfortable I'd want to know why interrupts were disabled on entry
> > here, why it's safe to enable them now, and why it's safe to return
> > from the function with them still enabled.
> >
> > I'm guessing this was added because may_use_simd() was blowing up for
> > you without it. If that's the case, I think we'll need to reconcile
> > that in a different way. From a quick glance at kernel_mode_vector.c,
> > I was originally thinking may_use_simd() enforces this because there's
>
> Current nesting support of kernel mode vector only allows softirq
> context to use v context nesting on top of kernel thread's v context.
> I did not expect the use of v in the interrupt handler but I am open
> to discussions if it is needed.
>
> The reason why may_use_simd() checks for irq_disabled() is that
> local_bh_enable later in kernel_vector_end() expects running with irq
> on. Although the success path of preemptible v does not require
> !irq_disabled(), the kernel falls back to non-preemptible v
> (get_cpu_vector_context) in some cases. First is the nesting softirq
> case, or a rare case where an exception handler uses v in a kernel
> fault that also uses v. The second is when memory allocation for
> kernel_vstate fails. The fall back uses the non-preemptible v, so it
> is linked to bh_*.
>
> We can get rid of the last case by failing the launch of a kernel
> thread when the allocation fails.

Thanks for the context Andy, that fills in a couple of "wait why" gaps
I had in my brain while reading that code.

My understanding is Jesse skated around this issue by using
schedule_on_each_cpu(), which gets the function running on each cpu in
a nicer worker context where kernel_vector_begin() will work as is.
This local_irq_enable() was a leftover from when she was originally
experimenting with on_each_cpu(), which invokes the callback from a
harsher IPI context. So I think we can just remove the
local_irq_enable() and not have to modify the kernel V context code.
-Evan

