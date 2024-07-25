Return-Path: <linux-kernel+bounces-262600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA82593C93A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 21:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A6151C21C04
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 19:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41D23FBB2;
	Thu, 25 Jul 2024 19:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Su4n4GwV"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062EC1F934
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 19:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721937523; cv=none; b=c3hUVRU9wSoKx8AXt+NKUDn5s94egQpznF2q19R7T51rzUQj5PAuPW/HvRRnagi2HdesSajJLZzwRn02UdwkAv/pEl0u2DzTDFO9pu/is+bZtjKRxXl9x4rc3sRdJtYBQOZoiRgHh/nR3ARcfAPLyPDpGl48zrvb42rKNlRAaLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721937523; c=relaxed/simple;
	bh=wOpXjoJR/xpbRx6KhN3aTBJ0R9Ps52PGpG8L/xMSEKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hK2d7AM5JVQffOmi1hLSDvEIZh+XS/FwIx4HkfIMfmOhn3oYTNysJO6/3yVnDF2GP7AMQ8QLcGDKLSn8Ut9MO8rAGOz5K7ES01accFBckduTayeUIZXrSj7m/1tYGbEbtTDkxbOfP3elMnMC3B7ifVXgS7YAKooLD1YilW4FSg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Su4n4GwV; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4f6be9d13cdso418757e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 12:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721937520; x=1722542320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZ5Q6+2BjCvr02Zc54CeJkALkUmW5Rp9Cb6u//skcEs=;
        b=Su4n4GwVQGYSn3unpiylcv56qoyt8ouMkQYb2tE9sfu4JjaSXPhrQT/hLwsXdTLmmE
         azImpe8TM42Uxr67Z4Vdv/P0qXBsqH/NTTWB+V9c09bQ5X/7PuBtU4qAS4LDmXxFGCFC
         bN+MymcfJ/WodeGsnDuaazAdfUxUw8QpM4evOZnjKUnPZoXAR/fzw+4swyrQn0dHjuS1
         1QFBwvwkaVRU7eycw2K5InVVLAsTsFG0Ol94JCbahJ/012dP7kbiMwepRmtR+eNzmKyu
         k++Y1cN2RuTG7W4Xjd8sZTsniYEG7EvienM649cwxUb7l+qp1haqjGgHEhRnjLR2A6RS
         dY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721937520; x=1722542320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZ5Q6+2BjCvr02Zc54CeJkALkUmW5Rp9Cb6u//skcEs=;
        b=d86D8BbC92wHRLEw1AtwjIpHbVz3o8br7UGJ/e765CWaUNHN5qzIQwV9RCWwNnMSHB
         xbnVuDpg7+WHgo+bMBSd8iJ02loCY2ERSJ8kgPbvj2fRibChYRbipdJaNOJkUczzwv4D
         X5HajLhk4xLcsn0qsNnULPnzKYvr/wlBiEDnEmNHQeOJabLwBdJ2NmMHICk7LlFzN0NR
         dO94eav7brhsLfZHBZ2hmlVtF+BoG/3vSR+AadbMjpPwvNH+1vze9tq7bL4Aqd5Fh4+n
         0242uvQsT+zhaBCf/Y0rex6BWbWtLE0E807+HeV+77tjNXj2Fe8tDMkbpqiN0hfEtIuG
         xj8g==
X-Forwarded-Encrypted: i=1; AJvYcCXkCZ/wr9PIqn5/p3SHl1Tjc5yRHPU3R7PmR+9F5RnYMN94G0rSnbE2QdqZHKizQc53ZQV59dU1rrmQ4ozaCcBFawiNBcetJaFZbbF/
X-Gm-Message-State: AOJu0YwjPSoeGKjVIUdQI9if9H9AS8Zc7DJsib34zCMd0eSLlKnuZb9F
	5QM2FU/NKeuirwOXj0XQvDBpd8nSFBosUaS+l3eynV0cf8fDSNljNQ/rfTu1VceKWlOOQmQyqxe
	xNIgsMlwnTOKmhuFf0CKrUjzbeQeudQMcR2MI8A==
X-Google-Smtp-Source: AGHT+IEwIrLalW+vd/O5VIeOx8O287aqzlULAlNtxMgr9/qGhm5Fz1DJgCes/8fD90lvb5ttdkfSKjZ9OJqnnrU/kjc=
X-Received: by 2002:a05:6122:2916:b0:4f5:199b:2a7f with SMTP id
 71dfb90a1353d-4f6c5bd649cmr4537000e0c.8.1721937519818; Thu, 25 Jul 2024
 12:58:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724183605.4038597-1-jesse@rivosinc.com> <20240724183605.4038597-7-jesse@rivosinc.com>
 <CALs-Hsvb0A411Dnd3ps=B4-oxM_vz0Bi1Dh1UgiHFYcnjA4v0Q@mail.gmail.com>
In-Reply-To: <CALs-Hsvb0A411Dnd3ps=B4-oxM_vz0Bi1Dh1UgiHFYcnjA4v0Q@mail.gmail.com>
From: Jesse Taube <jesse@rivosinc.com>
Date: Thu, 25 Jul 2024 15:58:28 -0400
Message-ID: <CALSpo=YAFLrVgN5Ap+2N9=ubMwxoZ5rGQgSgAhV6KBUjdL8W=Q@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] RISC-V: Detect unaligned vector accesses supported
To: Evan Green <evan@rivosinc.com>
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

On Thu, Jul 25, 2024 at 2:59=E2=80=AFPM Evan Green <evan@rivosinc.com> wrot=
e:
>
> On Wed, Jul 24, 2024 at 11:36=E2=80=AFAM Jesse Taube <jesse@rivosinc.com>=
 wrote:
> >
> > Run a unaligned vector access to test if the system supports
> > vector unaligned access. Add the result to a new key in hwprobe.
> > This is useful for usermode to know if vector misaligned accesses are
> > supported and if they are faster or slower than equivalent byte accesse=
s.
> >
> > Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> > Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> > V1 -> V2:
> >  - Add Kconfig options
> >  - Add insn_is_vector
> >  - Add handle_vector_misaligned_load
> >  - Fix build
> >  - Seperate vector from scalar misaligned access
> >  - This patch was almost completely rewritten
> > V2 -> V3:
> >  - Fixed CONFIG_ in Kconfig
> >  - Fixed check_vector_unaligned_access_emulated leaving
> >      vector_misaligned_access as unknown.
> >  - Remove local_irq_enable
> >  - Remove RISCV_DETECT_VECTOR_UNALIGNED_ACCESS
> >  - Remove RISCV_VEC_UNALIGNED_ACCESS_UNSUPPORTED
> > V3 -> V4:
> >  - Spell out _VECTOR_ in macros
> > V4 -> V5:
> >  - Change work_struct *unused to work_struct *work __always_unused
> >  - Add insn_is_vector definition to vector.h when V is not defined
> > V5 -> V6:
> >  - Change check_vector_unaligned_access_emulated to extern
> >  - Move check_unaligned_access_emulated_all_cpus out of the #ifdef
> >    see last commit
> > ---
> >  arch/riscv/Kconfig                         |  35 ++++++
> >  arch/riscv/include/asm/cpufeature.h        |   8 +-
> >  arch/riscv/include/asm/entry-common.h      |  11 --
> >  arch/riscv/include/asm/hwprobe.h           |   2 +-
> >  arch/riscv/include/asm/vector.h            |   2 +
> >  arch/riscv/include/uapi/asm/hwprobe.h      |   5 +
> >  arch/riscv/kernel/Makefile                 |   4 +-
> >  arch/riscv/kernel/sys_hwprobe.c            |  35 ++++++
> >  arch/riscv/kernel/traps_misaligned.c       | 120 ++++++++++++++++++++-
> >  arch/riscv/kernel/unaligned_access_speed.c |  22 ++--
> >  arch/riscv/kernel/vector.c                 |   2 +-
> >  11 files changed, 216 insertions(+), 30 deletions(-)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 34d24242e37a..ffbe0fdd7fb3 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -717,12 +717,26 @@ config THREAD_SIZE_ORDER
> >           Specify the Pages of thread stack size (from 4KB to 64KB), wh=
ich also
> >           affects irq stack size, which is equal to thread stack size.
> >
> > +config RISCV_MISALIGNED
> > +       bool
> > +       help
> > +         Embed support for detecting and emulating misaligned
> > +         scalar or vector loads and stores.
> > +
> >  config RISCV_SCALAR_MISALIGNED
> >         bool
> > +       select RISCV_MISALIGNED
> >         select SYSCTL_ARCH_UNALIGN_ALLOW
> >         help
> >           Embed support for emulating misaligned loads and stores.
> >
> > +config RISCV_VECTOR_MISALIGNED
> > +       bool
> > +       select RISCV_MISALIGNED
> > +       depends on RISCV_ISA_V
> > +       help
> > +         Enable detecting support for vector misaligned loads and stor=
es.
> > +
> >  choice
> >         prompt "Unaligned Accesses Support"
> >         default RISCV_PROBE_UNALIGNED_ACCESS
> > @@ -774,6 +788,27 @@ config RISCV_EFFICIENT_UNALIGNED_ACCESS
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
> > +endchoice
> > +
> >  endmenu # "Platform type"
> >
> >  menu "Kernel features"
> > diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/a=
sm/cpufeature.h
> > index 4ade9f87fc55..5634f702f3fe 100644
> > --- a/arch/riscv/include/asm/cpufeature.h
> > +++ b/arch/riscv/include/asm/cpufeature.h
> > @@ -34,8 +34,8 @@ extern struct riscv_isainfo hart_isa[NR_CPUS];
> >
> >  void riscv_user_isa_enable(void);
> >
> > -#if defined(CONFIG_RISCV_SCALAR_MISALIGNED)
> >  bool check_unaligned_access_emulated_all_cpus(void);
> > +#if defined(CONFIG_RISCV_SCALAR_MISALIGNED)
> >  void check_unaligned_access_emulated(struct work_struct *work __always=
_unused);
> >  void unaligned_emulation_finish(void);
> >  bool unaligned_ctl_available(void);
> > @@ -47,6 +47,12 @@ static inline bool unaligned_ctl_available(void)
> >  }
> >  #endif
> >
> > +bool check_vector_unaligned_access_emulated_all_cpus(void);
> > +#if defined(CONFIG_RISCV_VECTOR_MISALIGNED)
> > +void check_vector_unaligned_access_emulated(struct work_struct *work _=
_always_unused);
> > +DECLARE_PER_CPU(long, vector_misaligned_access);
> > +#endif
> > +
> >  #if defined(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)
> >  DECLARE_STATIC_KEY_FALSE(fast_unaligned_access_speed_key);
> >
> > diff --git a/arch/riscv/include/asm/entry-common.h b/arch/riscv/include=
/asm/entry-common.h
> > index 0a4e3544c877..7b32d2b08bb6 100644
> > --- a/arch/riscv/include/asm/entry-common.h
> > +++ b/arch/riscv/include/asm/entry-common.h
> > @@ -25,18 +25,7 @@ static inline void arch_exit_to_user_mode_prepare(st=
ruct pt_regs *regs,
> >  void handle_page_fault(struct pt_regs *regs);
> >  void handle_break(struct pt_regs *regs);
> >
> > -#ifdef CONFIG_RISCV_SCALAR_MISALIGNED
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
> > index be7d309cca8a..c7c023afbacd 100644
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
> > @@ -268,6 +269,7 @@ struct pt_regs;
> >
> >  static inline int riscv_v_setup_vsize(void) { return -EOPNOTSUPP; }
> >  static __always_inline bool has_vector(void) { return false; }
> > +static __always_inline bool insn_is_vector(u32 insn_buf) { return fals=
e; }
> >  static inline bool riscv_v_first_use_handler(struct pt_regs *regs) { r=
eturn false; }
> >  static inline bool riscv_v_vstate_query(struct pt_regs *regs) { return=
 false; }
> >  static inline bool riscv_v_vstate_ctrl_user_allowed(void) { return fal=
se; }
> > diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include=
/uapi/asm/hwprobe.h
> > index 023b7771d1b7..48b92fb07edf 100644
> > --- a/arch/riscv/include/uapi/asm/hwprobe.h
> > +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> > @@ -75,6 +75,11 @@ struct riscv_hwprobe {
> >  #define                RISCV_HWPROBE_MISALIGNED_MASK           (7 << 0=
)
> >  #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE    6
> >  #define RISCV_HWPROBE_KEY_MISALIGNED_PERF      7
> > +#define RISCV_HWPROBE_KEY_VECTOR_MISALIGNED_PERF       8
> > +#define                RISCV_HWPROBE_VECTOR_MISALIGNED_UNKNOWN        =
 0
> > +#define                RISCV_HWPROBE_VECTOR_MISALIGNED_SLOW           =
 2
> > +#define                RISCV_HWPROBE_VECTOR_MISALIGNED_FAST           =
 3
> > +#define                RISCV_HWPROBE_VECTOR_MISALIGNED_UNSUPPORTED    =
 4
> >  /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
> >
> >  /* Flags */
> > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > index 8d4e7d40e42f..5b243d46f4b1 100644
> > --- a/arch/riscv/kernel/Makefile
> > +++ b/arch/riscv/kernel/Makefile
> > @@ -62,8 +62,8 @@ obj-y +=3D probes/
> >  obj-y  +=3D tests/
> >  obj-$(CONFIG_MMU) +=3D vdso.o vdso/
> >
> > -obj-$(CONFIG_RISCV_SCALAR_MISALIGNED)  +=3D traps_misaligned.o
> > -obj-$(CONFIG_RISCV_SCALAR_MISALIGNED)  +=3D unaligned_access_speed.o
> > +obj-$(CONFIG_RISCV_MISALIGNED) +=3D traps_misaligned.o
> > +obj-$(CONFIG_RISCV_MISALIGNED) +=3D unaligned_access_speed.o
> >  obj-$(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)     +=3D copy-unaligned.o
> >
> >  obj-$(CONFIG_FPU)              +=3D fpu.o
> > diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hw=
probe.c
> > index e910e2971984..2e3e324bad38 100644
> > --- a/arch/riscv/kernel/sys_hwprobe.c
> > +++ b/arch/riscv/kernel/sys_hwprobe.c
> > @@ -194,6 +194,37 @@ static u64 hwprobe_misaligned(const struct cpumask=
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
> > +       /* Return if supported or not even if speed wasn't probed */
> > +       for_each_cpu(cpu, cpus) {
> > +               int this_perf =3D per_cpu(vector_misaligned_access, cpu=
);
> > +
> > +               if (perf =3D=3D -1ULL)
> > +                       perf =3D this_perf;
> > +
> > +               if (perf !=3D this_perf) {
> > +                       perf =3D RISCV_HWPROBE_VECTOR_MISALIGNED_UNKNOW=
N;
> > +                       break;
> > +               }
> > +       }
> > +
> > +       if (perf =3D=3D -1ULL)
> > +               return RISCV_HWPROBE_VECTOR_MISALIGNED_UNKNOWN;
> > +
> > +       return perf;
> > +}
> > +#else
> > +static u64 hwprobe_vec_misaligned(const struct cpumask *cpus)
> > +{
> > +       return RISCV_HWPROBE_VECTOR_MISALIGNED_UNKNOWN;
> > +}
> > +#endif
> > +
> >  static void hwprobe_one_pair(struct riscv_hwprobe *pair,
> >                              const struct cpumask *cpus)
> >  {
> > @@ -222,6 +253,10 @@ static void hwprobe_one_pair(struct riscv_hwprobe =
*pair,
> >                 pair->value =3D hwprobe_misaligned(cpus);
> >                 break;
> >
> > +       case RISCV_HWPROBE_KEY_VECTOR_MISALIGNED_PERF:
> > +               pair->value =3D hwprobe_vec_misaligned(cpus);
> > +               break;
> > +
> >         case RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE:
> >                 pair->value =3D 0;
> >                 if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOZ))
> > diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/t=
raps_misaligned.c
> > index bb09357778c5..817496a6a2d5 100644
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
BE_VECTOR_MISALIGNED_UNKNOWN) {
> > +               *this_cpu_ptr(&vector_misaligned_access) =3D RISCV_HWPR=
OBE_VECTOR_MISALIGNED_UNSUPPORTED;
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
> > @@ -526,6 +552,86 @@ int handle_misaligned_store(struct pt_regs *regs)
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
> > +       if (IS_ENABLED(CONFIG_RISCV_SCALAR_MISALIGNED))
> > +               return handle_scalar_misaligned_load(regs);
> > +
> > +       return -1;
> > +}
> > +
> > +int handle_misaligned_store(struct pt_regs *regs)
> > +{
> > +       if (IS_ENABLED(CONFIG_RISCV_SCALAR_MISALIGNED))
> > +               return handle_scalar_misaligned_store(regs);
> > +
> > +       return -1;
> > +}
> > +
> > +#ifdef CONFIG_RISCV_VECTOR_MISALIGNED
> > +void check_vector_unaligned_access_emulated(struct work_struct *work _=
_always_unused)
> > +{
> > +       long *mas_ptr =3D this_cpu_ptr(&vector_misaligned_access);
> > +       unsigned long tmp_var;
> > +
> > +       *mas_ptr =3D RISCV_HWPROBE_VECTOR_MISALIGNED_UNKNOWN;
> > +
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
> > +
> > +       if (*mas_ptr =3D=3D RISCV_HWPROBE_VECTOR_MISALIGNED_UNKNOWN)
> > +               *mas_ptr =3D RISCV_HWPROBE_VECTOR_MISALIGNED_SLOW;
>
> I'm still not a fan of this "if we don't know, say it's slow" thing.
> Most consumers of this key will do something like "if
> (misaligned_access =3D=3D FAST) install_fast_functions()", and that'll
> work here too. But for usermode that really cares and is trying to
> interpret the other values, they're now forced to treat SLOW and
> UNKNOWN as the same value, since we sometimes return SLOW when we mean
> UNKNOWN. It seems better to me if the kernel is honestly reporting the
> information, and then usermode can extract real meaning from each of
> these values to the extent they care to.

I'm a massive idiot. I thought I had changed it to be UNKNOWN and not
SLOW before I sent it.
I'm very sorry.

I'll send a V7 ; ( if necessary.

Thanks,
Jesse Taube

