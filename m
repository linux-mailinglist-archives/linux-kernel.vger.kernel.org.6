Return-Path: <linux-kernel+bounces-262616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B76F93C99A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 22:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0E171F23556
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 20:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910B213B7AE;
	Thu, 25 Jul 2024 20:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="sPlLYhTs"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958BB78289
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 20:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721939732; cv=none; b=gqPHisKzCUsgCfAoQFjmHfesKNuh5NebzJBIXCcA60Npe0wntQ0eTIi+1X5z9MhcuJHhUX3dOh5O74f3/65cSH/zzqBMlrnTgIc5DyEaWhzHmiJ6ZT/suMJiaaKD2e7MN8GhHEGUQr34N+0uyDHsS0x7F4CBM2Mq3rft8k7lKwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721939732; c=relaxed/simple;
	bh=qX862kPlLFGObpePSMu0QP9k86yITr/QBKxFaKe7HiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jzp+t27neqFIXB/+12gE2zP0Ebu5zQV8R9QIWYfqYaOsvVKUzamcshnEuw/h+t0P0qxJ+TXcfwjVtoFeTn28VJFYfFv98lj/mThwmK6FX/tjfi6l4KZW6NDJ2Y3kRl8GykMQIGngo+K8dT7ow4rs2J7KzZZtZiS3LaVyAi+TLY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=sPlLYhTs; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f01e9f53ebso6732071fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 13:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721939728; x=1722544528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOpJ+Sm8I5iZP0KxzIi4DB1AAq1pm6RKhg8ls3bkMNQ=;
        b=sPlLYhTspR4lMIQCJujFXkLlv4GzkzRk2J0Nky19G04nDqGJrGRISJym3f4qny05V5
         tqLKzr8r7cCiuIRt7UPONN2hjQbTDedexuDxM9tAp23e0NpIHCOCw4QWcRoEcvLje3DN
         iCg6nmQBsgPmBgUBCADdAOjV8HUo2vwD3t3ubeurioa5F0mFonADUSPeQjcbSdDH4a+6
         BMyOtNo2bYnTmbVNCz8Y2BWG59k8AJ+c74MyLRThlpbXYVgpRMLDqwwbStGEQ+0x+TnX
         /DtIJx3+uaLmWC3NTY3tTGygc2awm2CLQJMjZ3WyT1G79cGxt4UrDZhPkaMDnmf7Su6/
         4Hfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721939728; x=1722544528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vOpJ+Sm8I5iZP0KxzIi4DB1AAq1pm6RKhg8ls3bkMNQ=;
        b=ug4xFAWZ1lzjr3/7sO0q7g+aoECjPaqYOS9xEAnj1DgNNeF7lAzQ6I+EjGHgpx5uIw
         UgvhA7XuP/LEqtVi0NjqR6Zr6vbOVEXgHqIzSWc8NqVVoU2nxbStYpNL/n72aTZ5EJac
         Vp+vB3x6jWJ3vID0/3cWslU7KYPA0x0GGxqPtdrpFgzAcpdB0qGtOAwWfqDtWufHKK/l
         PgZFWeHXM8pZda4JgfDleF2UZOUR02pmhDTLXMaWm4tFx3TfUsk+WqLxrPb3BgyfKx+7
         nPrb9hsbcYqEaCQjLVPt95RtfxXn3EJKQlGD9mw/vqDEDa9eUc7XY8zQ2FJ98ukQ48k2
         HN5w==
X-Forwarded-Encrypted: i=1; AJvYcCUBFFibod9B/GNPK2aLQ8Y07+nXbYZtVP7c40gJMIS6yMFJr/8VXteWW6c4I7G2SBssiUiagyLstygZ1TCdjussP+nbb6/DG4z08Wtu
X-Gm-Message-State: AOJu0YzkmlAOB/zAPBbYtOoh+ujs2mcvKEVhEk6bmf3ZE0K7wfeYg456
	jdlpswam0oSylW/ErSMQlk3kBPmaF2TUG9eKYAaH1UWnU6Wf235kSOKPnP8yl8OaAobE13PtBnH
	ag9kIV8/7dc+9rToDTsnhk9qPcjLFTEv8ewHDaQ==
X-Google-Smtp-Source: AGHT+IFQrU6Ohu9OSx6MkHYkn3TA5jteYBtaZA7eD3svUvBXZMRzMGIFNhmVVtPYBlbfshV5WDoif9sPwVS11J5buP8=
X-Received: by 2002:a2e:b887:0:b0:2ef:392e:e45 with SMTP id
 38308e7fff4ca-2f039db9521mr36466581fa.33.1721939727639; Thu, 25 Jul 2024
 13:35:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724183605.4038597-1-jesse@rivosinc.com> <20240724183605.4038597-7-jesse@rivosinc.com>
 <CALs-Hsvb0A411Dnd3ps=B4-oxM_vz0Bi1Dh1UgiHFYcnjA4v0Q@mail.gmail.com> <CALSpo=YAFLrVgN5Ap+2N9=ubMwxoZ5rGQgSgAhV6KBUjdL8W=Q@mail.gmail.com>
In-Reply-To: <CALSpo=YAFLrVgN5Ap+2N9=ubMwxoZ5rGQgSgAhV6KBUjdL8W=Q@mail.gmail.com>
From: Evan Green <evan@rivosinc.com>
Date: Thu, 25 Jul 2024 13:34:51 -0700
Message-ID: <CALs-Hsv4nfvzbsyEB9Xq1CjjEXX6d0Eqbv8VA1eGQMGqdXywUg@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] RISC-V: Detect unaligned vector accesses supported
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

On Thu, Jul 25, 2024 at 12:58=E2=80=AFPM Jesse Taube <jesse@rivosinc.com> w=
rote:
>
> On Thu, Jul 25, 2024 at 2:59=E2=80=AFPM Evan Green <evan@rivosinc.com> wr=
ote:
> >
> > On Wed, Jul 24, 2024 at 11:36=E2=80=AFAM Jesse Taube <jesse@rivosinc.co=
m> wrote:
> > >
> > > Run a unaligned vector access to test if the system supports
> > > vector unaligned access. Add the result to a new key in hwprobe.
> > > This is useful for usermode to know if vector misaligned accesses are
> > > supported and if they are faster or slower than equivalent byte acces=
ses.
> > >
> > > Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> > > Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
> > > ---
> > > V1 -> V2:
> > >  - Add Kconfig options
> > >  - Add insn_is_vector
> > >  - Add handle_vector_misaligned_load
> > >  - Fix build
> > >  - Seperate vector from scalar misaligned access
> > >  - This patch was almost completely rewritten
> > > V2 -> V3:
> > >  - Fixed CONFIG_ in Kconfig
> > >  - Fixed check_vector_unaligned_access_emulated leaving
> > >      vector_misaligned_access as unknown.
> > >  - Remove local_irq_enable
> > >  - Remove RISCV_DETECT_VECTOR_UNALIGNED_ACCESS
> > >  - Remove RISCV_VEC_UNALIGNED_ACCESS_UNSUPPORTED
> > > V3 -> V4:
> > >  - Spell out _VECTOR_ in macros
> > > V4 -> V5:
> > >  - Change work_struct *unused to work_struct *work __always_unused
> > >  - Add insn_is_vector definition to vector.h when V is not defined
> > > V5 -> V6:
> > >  - Change check_vector_unaligned_access_emulated to extern
> > >  - Move check_unaligned_access_emulated_all_cpus out of the #ifdef
> > >    see last commit
> > > ---
> > >  arch/riscv/Kconfig                         |  35 ++++++
> > >  arch/riscv/include/asm/cpufeature.h        |   8 +-
> > >  arch/riscv/include/asm/entry-common.h      |  11 --
> > >  arch/riscv/include/asm/hwprobe.h           |   2 +-
> > >  arch/riscv/include/asm/vector.h            |   2 +
> > >  arch/riscv/include/uapi/asm/hwprobe.h      |   5 +
> > >  arch/riscv/kernel/Makefile                 |   4 +-
> > >  arch/riscv/kernel/sys_hwprobe.c            |  35 ++++++
> > >  arch/riscv/kernel/traps_misaligned.c       | 120 +++++++++++++++++++=
+-
> > >  arch/riscv/kernel/unaligned_access_speed.c |  22 ++--
> > >  arch/riscv/kernel/vector.c                 |   2 +-
> > >  11 files changed, 216 insertions(+), 30 deletions(-)
> > >
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index 34d24242e37a..ffbe0fdd7fb3 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -717,12 +717,26 @@ config THREAD_SIZE_ORDER
> > >           Specify the Pages of thread stack size (from 4KB to 64KB), =
which also
> > >           affects irq stack size, which is equal to thread stack size=
.
> > >
> > > +config RISCV_MISALIGNED
> > > +       bool
> > > +       help
> > > +         Embed support for detecting and emulating misaligned
> > > +         scalar or vector loads and stores.
> > > +
> > >  config RISCV_SCALAR_MISALIGNED
> > >         bool
> > > +       select RISCV_MISALIGNED
> > >         select SYSCTL_ARCH_UNALIGN_ALLOW
> > >         help
> > >           Embed support for emulating misaligned loads and stores.
> > >
> > > +config RISCV_VECTOR_MISALIGNED
> > > +       bool
> > > +       select RISCV_MISALIGNED
> > > +       depends on RISCV_ISA_V
> > > +       help
> > > +         Enable detecting support for vector misaligned loads and st=
ores.
> > > +
> > >  choice
> > >         prompt "Unaligned Accesses Support"
> > >         default RISCV_PROBE_UNALIGNED_ACCESS
> > > @@ -774,6 +788,27 @@ config RISCV_EFFICIENT_UNALIGNED_ACCESS
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
> > > +endchoice
> > > +
> > >  endmenu # "Platform type"
> > >
> > >  menu "Kernel features"
> > > diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include=
/asm/cpufeature.h
> > > index 4ade9f87fc55..5634f702f3fe 100644
> > > --- a/arch/riscv/include/asm/cpufeature.h
> > > +++ b/arch/riscv/include/asm/cpufeature.h
> > > @@ -34,8 +34,8 @@ extern struct riscv_isainfo hart_isa[NR_CPUS];
> > >
> > >  void riscv_user_isa_enable(void);
> > >
> > > -#if defined(CONFIG_RISCV_SCALAR_MISALIGNED)
> > >  bool check_unaligned_access_emulated_all_cpus(void);
> > > +#if defined(CONFIG_RISCV_SCALAR_MISALIGNED)
> > >  void check_unaligned_access_emulated(struct work_struct *work __alwa=
ys_unused);
> > >  void unaligned_emulation_finish(void);
> > >  bool unaligned_ctl_available(void);
> > > @@ -47,6 +47,12 @@ static inline bool unaligned_ctl_available(void)
> > >  }
> > >  #endif
> > >
> > > +bool check_vector_unaligned_access_emulated_all_cpus(void);
> > > +#if defined(CONFIG_RISCV_VECTOR_MISALIGNED)
> > > +void check_vector_unaligned_access_emulated(struct work_struct *work=
 __always_unused);
> > > +DECLARE_PER_CPU(long, vector_misaligned_access);
> > > +#endif
> > > +
> > >  #if defined(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)
> > >  DECLARE_STATIC_KEY_FALSE(fast_unaligned_access_speed_key);
> > >
> > > diff --git a/arch/riscv/include/asm/entry-common.h b/arch/riscv/inclu=
de/asm/entry-common.h
> > > index 0a4e3544c877..7b32d2b08bb6 100644
> > > --- a/arch/riscv/include/asm/entry-common.h
> > > +++ b/arch/riscv/include/asm/entry-common.h
> > > @@ -25,18 +25,7 @@ static inline void arch_exit_to_user_mode_prepare(=
struct pt_regs *regs,
> > >  void handle_page_fault(struct pt_regs *regs);
> > >  void handle_break(struct pt_regs *regs);
> > >
> > > -#ifdef CONFIG_RISCV_SCALAR_MISALIGNED
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
> > > index be7d309cca8a..c7c023afbacd 100644
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
> > > @@ -268,6 +269,7 @@ struct pt_regs;
> > >
> > >  static inline int riscv_v_setup_vsize(void) { return -EOPNOTSUPP; }
> > >  static __always_inline bool has_vector(void) { return false; }
> > > +static __always_inline bool insn_is_vector(u32 insn_buf) { return fa=
lse; }
> > >  static inline bool riscv_v_first_use_handler(struct pt_regs *regs) {=
 return false; }
> > >  static inline bool riscv_v_vstate_query(struct pt_regs *regs) { retu=
rn false; }
> > >  static inline bool riscv_v_vstate_ctrl_user_allowed(void) { return f=
alse; }
> > > diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/inclu=
de/uapi/asm/hwprobe.h
> > > index 023b7771d1b7..48b92fb07edf 100644
> > > --- a/arch/riscv/include/uapi/asm/hwprobe.h
> > > +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> > > @@ -75,6 +75,11 @@ struct riscv_hwprobe {
> > >  #define                RISCV_HWPROBE_MISALIGNED_MASK           (7 <<=
 0)
> > >  #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE    6
> > >  #define RISCV_HWPROBE_KEY_MISALIGNED_PERF      7
> > > +#define RISCV_HWPROBE_KEY_VECTOR_MISALIGNED_PERF       8
> > > +#define                RISCV_HWPROBE_VECTOR_MISALIGNED_UNKNOWN      =
   0
> > > +#define                RISCV_HWPROBE_VECTOR_MISALIGNED_SLOW         =
   2
> > > +#define                RISCV_HWPROBE_VECTOR_MISALIGNED_FAST         =
   3
> > > +#define                RISCV_HWPROBE_VECTOR_MISALIGNED_UNSUPPORTED  =
   4
> > >  /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
> > >
> > >  /* Flags */
> > > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > > index 8d4e7d40e42f..5b243d46f4b1 100644
> > > --- a/arch/riscv/kernel/Makefile
> > > +++ b/arch/riscv/kernel/Makefile
> > > @@ -62,8 +62,8 @@ obj-y +=3D probes/
> > >  obj-y  +=3D tests/
> > >  obj-$(CONFIG_MMU) +=3D vdso.o vdso/
> > >
> > > -obj-$(CONFIG_RISCV_SCALAR_MISALIGNED)  +=3D traps_misaligned.o
> > > -obj-$(CONFIG_RISCV_SCALAR_MISALIGNED)  +=3D unaligned_access_speed.o
> > > +obj-$(CONFIG_RISCV_MISALIGNED) +=3D traps_misaligned.o
> > > +obj-$(CONFIG_RISCV_MISALIGNED) +=3D unaligned_access_speed.o
> > >  obj-$(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)     +=3D copy-unaligned.o
> > >
> > >  obj-$(CONFIG_FPU)              +=3D fpu.o
> > > diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_=
hwprobe.c
> > > index e910e2971984..2e3e324bad38 100644
> > > --- a/arch/riscv/kernel/sys_hwprobe.c
> > > +++ b/arch/riscv/kernel/sys_hwprobe.c
> > > @@ -194,6 +194,37 @@ static u64 hwprobe_misaligned(const struct cpuma=
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
> > > +       /* Return if supported or not even if speed wasn't probed */
> > > +       for_each_cpu(cpu, cpus) {
> > > +               int this_perf =3D per_cpu(vector_misaligned_access, c=
pu);
> > > +
> > > +               if (perf =3D=3D -1ULL)
> > > +                       perf =3D this_perf;
> > > +
> > > +               if (perf !=3D this_perf) {
> > > +                       perf =3D RISCV_HWPROBE_VECTOR_MISALIGNED_UNKN=
OWN;
> > > +                       break;
> > > +               }
> > > +       }
> > > +
> > > +       if (perf =3D=3D -1ULL)
> > > +               return RISCV_HWPROBE_VECTOR_MISALIGNED_UNKNOWN;
> > > +
> > > +       return perf;
> > > +}
> > > +#else
> > > +static u64 hwprobe_vec_misaligned(const struct cpumask *cpus)
> > > +{
> > > +       return RISCV_HWPROBE_VECTOR_MISALIGNED_UNKNOWN;
> > > +}
> > > +#endif
> > > +
> > >  static void hwprobe_one_pair(struct riscv_hwprobe *pair,
> > >                              const struct cpumask *cpus)
> > >  {
> > > @@ -222,6 +253,10 @@ static void hwprobe_one_pair(struct riscv_hwprob=
e *pair,
> > >                 pair->value =3D hwprobe_misaligned(cpus);
> > >                 break;
> > >
> > > +       case RISCV_HWPROBE_KEY_VECTOR_MISALIGNED_PERF:
> > > +               pair->value =3D hwprobe_vec_misaligned(cpus);
> > > +               break;
> > > +
> > >         case RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE:
> > >                 pair->value =3D 0;
> > >                 if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOZ))
> > > diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel=
/traps_misaligned.c
> > > index bb09357778c5..817496a6a2d5 100644
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
ROBE_VECTOR_MISALIGNED_UNKNOWN) {
> > > +               *this_cpu_ptr(&vector_misaligned_access) =3D RISCV_HW=
PROBE_VECTOR_MISALIGNED_UNSUPPORTED;
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
> > > @@ -526,6 +552,86 @@ int handle_misaligned_store(struct pt_regs *regs=
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
> > > +       if (IS_ENABLED(CONFIG_RISCV_SCALAR_MISALIGNED))
> > > +               return handle_scalar_misaligned_load(regs);
> > > +
> > > +       return -1;
> > > +}
> > > +
> > > +int handle_misaligned_store(struct pt_regs *regs)
> > > +{
> > > +       if (IS_ENABLED(CONFIG_RISCV_SCALAR_MISALIGNED))
> > > +               return handle_scalar_misaligned_store(regs);
> > > +
> > > +       return -1;
> > > +}
> > > +
> > > +#ifdef CONFIG_RISCV_VECTOR_MISALIGNED
> > > +void check_vector_unaligned_access_emulated(struct work_struct *work=
 __always_unused)
> > > +{
> > > +       long *mas_ptr =3D this_cpu_ptr(&vector_misaligned_access);
> > > +       unsigned long tmp_var;
> > > +
> > > +       *mas_ptr =3D RISCV_HWPROBE_VECTOR_MISALIGNED_UNKNOWN;
> > > +
> > > +       kernel_vector_begin();
> > > +       __asm__ __volatile__ (
> > > +               ".balign 4\n\t"
> > > +               ".option push\n\t"
> > > +               ".option arch, +zve32x\n\t"
> > > +               "       vsetivli zero, 1, e16, m1, ta, ma\n\t"  // Ve=
ctors of 16b
> > > +               "       vle16.v v0, (%[ptr])\n\t"               // Lo=
ad bytes
> > > +               ".option pop\n\t"
> > > +               : : [ptr] "r" ((u8 *)&tmp_var + 1) : "v0");
> > > +       kernel_vector_end();
> > > +
> > > +       if (*mas_ptr =3D=3D RISCV_HWPROBE_VECTOR_MISALIGNED_UNKNOWN)
> > > +               *mas_ptr =3D RISCV_HWPROBE_VECTOR_MISALIGNED_SLOW;
> >
> > I'm still not a fan of this "if we don't know, say it's slow" thing.
> > Most consumers of this key will do something like "if
> > (misaligned_access =3D=3D FAST) install_fast_functions()", and that'll
> > work here too. But for usermode that really cares and is trying to
> > interpret the other values, they're now forced to treat SLOW and
> > UNKNOWN as the same value, since we sometimes return SLOW when we mean
> > UNKNOWN. It seems better to me if the kernel is honestly reporting the
> > information, and then usermode can extract real meaning from each of
> > these values to the extent they care to.
>
> I'm a massive idiot. I thought I had changed it to be UNKNOWN and not
> SLOW before I sent it.
> I'm very sorry.
>
> I'll send a V7 ; ( if necessary.

No worries at all. You are competent.

Seems like we can simply remove this conditional.

There was also a spot (I think in the next patch) where you compare
directly against =3D=3D SLOW, which we can change to !=3D UNKNOWN.
-Evan

>
> Thanks,
> Jesse Taube

