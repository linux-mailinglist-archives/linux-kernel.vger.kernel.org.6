Return-Path: <linux-kernel+bounces-257119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BD293757E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 11:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40C94282529
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 09:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF5C82889;
	Fri, 19 Jul 2024 09:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Ow3NRqNn"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2507E583
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 09:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721379984; cv=none; b=cFJ+hqTrj3lr9u1TgknQxo9/3vKqTMnLnHcckVwnkT5uh/PycZ3vW92TS63qmEXIapKDKKiTGLflZ8CO3lWno2J0NNt0ez/5nSBk+GN7hoahxGryaqAKHTUV0R/jv/Loh3CR71Eokomt6ZJMUSuROzdvw3Bf4nkQb+ov7yuwamE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721379984; c=relaxed/simple;
	bh=nRj+oSNZfdgUphzSMJs7wRsdWStQkUuRDJfRqKdPF70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nw4cyJfT8r6yOTHEQFwwOQssaCDGA6PKpd4+KOH1ObESxKeyVznyC48Z/3Jn6/w8hNzHweUgByUT2nFXHYbBzPYQHt6EamKAaKGjMO4BhNshjDYHYGGFqaKuODhayAWnwGJsuWwrkL4MH2l8rGidfVnHa+YQSFHBTAN4Uk8q1LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Ow3NRqNn; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a77c9c5d68bso174931666b.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 02:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721379981; x=1721984781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IlAJYpXlAsReiOPXwPJyKZWRf/jLQxJ3AvBnmzMhekg=;
        b=Ow3NRqNnW8ETO2cS6aI2rTqtOPgCAzjrfv+6vzWASIxc2vKuduakkdYeXj0dL+77I9
         G9DEWNnYH1YASQJTfd84RQ0oHEukXcS7tJ75oTnbUMV4wOinccHtq1nulxqMSmMA9rje
         HpNoKPuOeK55MBRmwfAB8sS68XjZ8sPfrf4F3gsovVVVHAS1+cFoNGS3iWs/C35SBtpq
         l2587CSoS1L45MvX+O6piBftCfitiuNNmA2kiBhGZsoxmU63Yyco37qiy3THVc2xI5Gc
         heU4Vf8eZi+DK/+O/TIT7A4C867G2KHaY35SUlm7xdKPCeNQ08PqsickwCyFuPRkqDCK
         qsdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721379981; x=1721984781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IlAJYpXlAsReiOPXwPJyKZWRf/jLQxJ3AvBnmzMhekg=;
        b=gwEOev1OVDU0cOBDnwX6i9AKZHYrpmtj0kPWBjeLVFIfPthE3FbKfdpZWter5OQV7O
         qZ6jxdfCUhM+dQjhOJOohna5lMooLDDdSyQwOIosopKMGirD3lGHCJm7a65nwTSMhV4I
         YMb46mezc4VD0RhcE68CME+EtJbHaed+6tnl6ZAO+Milua18Bq6xhUZnmZEEv37xlTLk
         9qmSMQl+8Ar7PwKtkVaA9UhW2RNX1kftun/qlHv61n8o40C8omkX1231/K8Zr7A6Y8mr
         RLyS1DM3vNOnwvQ09EaWt8uDhKSoZYUJ5pveg9HIwa2ss9LtZxt3G1N1D1n7RogfJrjN
         PNmA==
X-Forwarded-Encrypted: i=1; AJvYcCUpal4/dfCnZAkT/ey2hXLK/QlcS44+kUARq/WQ9s4W1PpcNadKlsTX46UF3lJIJ2Cb7QXGz554CvSbDgFKf04v1zq4CP7ahvvdgi28
X-Gm-Message-State: AOJu0YyTqKXOo6+ypSP5kXISWjFGPGiV7QHtgQjUICvIjesiohn/+3ly
	Vj8+u/ZVWpltqz8GDF57oIskcy/TSIcDRgh6ihUqrWF1J4a1dmblqvGYJ2CfbsnSpq5r3krfQy5
	7kGwrx+zKDWfBTR86GFnk4RApSQ2QgU2aX/2FAQ==
X-Google-Smtp-Source: AGHT+IGxC0dQp4jGatj5kDLOsslmQ/seLSUEG3bzO3HT2+3dvWwT3GdkXk02vBvyxkbWsa7MCyjAfOG4vcx+T8xP3y8=
X-Received: by 2002:a17:906:f18d:b0:a77:deb2:8af2 with SMTP id
 a640c23a62f3a-a7a0114a321mr448499066b.16.1721379980653; Fri, 19 Jul 2024
 02:06:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717061957.140712-1-alexghiti@rivosinc.com>
 <20240717061957.140712-12-alexghiti@rivosinc.com> <b28bc3c6-19de-4d40-8af2-6e5ce78ba89c@sifive.com>
In-Reply-To: <b28bc3c6-19de-4d40-8af2-6e5ce78ba89c@sifive.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Fri, 19 Jul 2024 11:06:09 +0200
Message-ID: <CAHVXubh++sjDZLNg47ZUjUiLcABHxBSw9OTCVAO_Oi5Js6nxig@mail.gmail.com>
Subject: Re: [PATCH v3 11/11] riscv: Add qspinlock support
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Andrea Parri <parri.andrea@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

On Fri, Jul 19, 2024 at 3:05=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> Hi Alex,
>
> On 2024-07-17 1:19 AM, Alexandre Ghiti wrote:
> > In order to produce a generic kernel, a user can select
> > CONFIG_COMBO_SPINLOCKS which will fallback at runtime to the ticket
> > spinlock implementation if Zabha or Ziccrse are not present.
> >
> > Note that we can't use alternatives here because the discovery of
> > extensions is done too late and we need to start with the qspinlock
> > implementation because the ticket spinlock implementation would pollute
> > the spinlock value, so let's use static keys.
> >
> > This is largely based on Guo's work and Leonardo reviews at [1].
> >
> > Link: https://lore.kernel.org/linux-riscv/20231225125847.2778638-1-guor=
en@kernel.org/ [1]
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  .../locking/queued-spinlocks/arch-support.txt |  2 +-
> >  arch/riscv/Kconfig                            | 29 ++++++++++++++
> >  arch/riscv/include/asm/Kbuild                 |  4 +-
> >  arch/riscv/include/asm/spinlock.h             | 39 +++++++++++++++++++
> >  arch/riscv/kernel/setup.c                     | 33 ++++++++++++++++
> >  include/asm-generic/qspinlock.h               |  2 +
> >  include/asm-generic/ticket_spinlock.h         |  2 +
> >  7 files changed, 109 insertions(+), 2 deletions(-)
> >  create mode 100644 arch/riscv/include/asm/spinlock.h
> >
> > diff --git a/Documentation/features/locking/queued-spinlocks/arch-suppo=
rt.txt b/Documentation/features/locking/queued-spinlocks/arch-support.txt
> > index 22f2990392ff..cf26042480e2 100644
> > --- a/Documentation/features/locking/queued-spinlocks/arch-support.txt
> > +++ b/Documentation/features/locking/queued-spinlocks/arch-support.txt
> > @@ -20,7 +20,7 @@
> >      |    openrisc: |  ok  |
> >      |      parisc: | TODO |
> >      |     powerpc: |  ok  |
> > -    |       riscv: | TODO |
> > +    |       riscv: |  ok  |
> >      |        s390: | TODO |
> >      |          sh: | TODO |
> >      |       sparc: |  ok  |
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 0bbaec0444d0..5040c7eac70d 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -72,6 +72,7 @@ config RISCV
> >       select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
> >       select ARCH_WANTS_NO_INSTR
> >       select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
> > +     select ARCH_WEAK_RELEASE_ACQUIRE if ARCH_USE_QUEUED_SPINLOCKS
> >       select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
> >       select BUILDTIME_TABLE_SORT if MMU
> >       select CLINT_TIMER if RISCV_M_MODE
> > @@ -482,6 +483,34 @@ config NODES_SHIFT
> >         Specify the maximum number of NUMA Nodes available on the targe=
t
> >         system.  Increases memory reserved to accommodate various table=
s.
> >
> > +choice
> > +     prompt "RISC-V spinlock type"
> > +     default RISCV_COMBO_SPINLOCKS
> > +
> > +config RISCV_TICKET_SPINLOCKS
> > +     bool "Using ticket spinlock"
> > +
> > +config RISCV_QUEUED_SPINLOCKS
> > +     bool "Using queued spinlock"
> > +     depends on SMP && MMU
>
> This needs:
>
>         depends on NONPORTABLE

Nice, thanks

>
> > +     select ARCH_USE_QUEUED_SPINLOCKS
> > +     help
> > +       The queued spinlock implementation requires the forward progres=
s
> > +       guarantee of cmpxchg()/xchg() atomic operations: CAS with Zabha=
 or
> > +       LR/SC with Ziccrse provide such guarantee.
> > +
> > +       Select this if and only if Zabha or Ziccrse is available on you=
r
> > +       platform.
> > +
> > +config RISCV_COMBO_SPINLOCKS
> > +     bool "Using combo spinlock"
> > +     depends on SMP && MMU
> > +     select ARCH_USE_QUEUED_SPINLOCKS
> > +     help
> > +       Embed both queued spinlock and ticket lock so that the spinlock
> > +       implementation can be chosen at runtime.
> > +endchoice
> > +
> >  config RISCV_ALTERNATIVE
> >       bool
> >       depends on !XIP_KERNEL
> > diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbu=
ild
> > index 504f8b7e72d4..ad72f2bd4cc9 100644
> > --- a/arch/riscv/include/asm/Kbuild
> > +++ b/arch/riscv/include/asm/Kbuild
> > @@ -2,10 +2,12 @@
> >  generic-y +=3D early_ioremap.h
> >  generic-y +=3D flat.h
> >  generic-y +=3D kvm_para.h
> > +generic-y +=3D mcs_spinlock.h
> >  generic-y +=3D parport.h
> > -generic-y +=3D spinlock.h
> >  generic-y +=3D spinlock_types.h
> > +generic-y +=3D ticket_spinlock.h
> >  generic-y +=3D qrwlock.h
> >  generic-y +=3D qrwlock_types.h
> > +generic-y +=3D qspinlock.h
> >  generic-y +=3D user.h
> >  generic-y +=3D vmlinux.lds.h
> > diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm=
/spinlock.h
> > new file mode 100644
> > index 000000000000..4856d50006f2
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/spinlock.h
> > @@ -0,0 +1,39 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef __ASM_RISCV_SPINLOCK_H
> > +#define __ASM_RISCV_SPINLOCK_H
> > +
> > +#ifdef CONFIG_RISCV_COMBO_SPINLOCKS
> > +#define _Q_PENDING_LOOPS     (1 << 9)
> > +
> > +#define __no_arch_spinlock_redefine
> > +#include <asm/ticket_spinlock.h>
> > +#include <asm/qspinlock.h>
> > +#include <asm/alternative.h>
> > +
> > +DECLARE_STATIC_KEY_TRUE(qspinlock_key);
> > +
> > +#define SPINLOCK_BASE_DECLARE(op, type, type_lock)                   \
> > +static __always_inline type arch_spin_##op(type_lock lock)           \
> > +{                                                                    \
> > +     if (static_branch_unlikely(&qspinlock_key))                     \
> > +             return queued_spin_##op(lock);                          \
> > +     return ticket_spin_##op(lock);                                  \
> > +}
> > +
> > +SPINLOCK_BASE_DECLARE(lock, void, arch_spinlock_t *)
> > +SPINLOCK_BASE_DECLARE(unlock, void, arch_spinlock_t *)
> > +SPINLOCK_BASE_DECLARE(is_locked, int, arch_spinlock_t *)
> > +SPINLOCK_BASE_DECLARE(is_contended, int, arch_spinlock_t *)
> > +SPINLOCK_BASE_DECLARE(trylock, bool, arch_spinlock_t *)
> > +SPINLOCK_BASE_DECLARE(value_unlocked, int, arch_spinlock_t)
> > +
> > +#else
> > +
> > +#include <asm/ticket_spinlock.h>
> > +
> > +#endif
> > +
> > +#include <asm/qrwlock.h>
> > +
> > +#endif /* __ASM_RISCV_SPINLOCK_H */
> > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > index 4f73c0ae44b2..d7c31c9b8ead 100644
> > --- a/arch/riscv/kernel/setup.c
> > +++ b/arch/riscv/kernel/setup.c
> > @@ -244,6 +244,38 @@ static void __init parse_dtb(void)
> >  #endif
> >  }
> >
> > +DEFINE_STATIC_KEY_TRUE(qspinlock_key);
> > +EXPORT_SYMBOL(qspinlock_key);
> > +
> > +static void __init riscv_spinlock_init(void)
> > +{
> > +     char *using_ext;
> > +
> > +     if (IS_ENABLED(CONFIG_RISCV_ISA_ZACAS) &&
> > +         IS_ENABLED(CONFIG_RISCV_ISA_ZABHA)) {
> > +             using_ext =3D "using Zabha";
> > +
> > +             asm goto(ALTERNATIVE("j %[no_zacas]", "nop", 0, RISCV_ISA=
_EXT_ZACAS, 1)
> > +                      : : : : no_zacas);
> > +             asm goto(ALTERNATIVE("nop", "j %[qspinlock]", 0, RISCV_IS=
A_EXT_ZABHA, 1)
> > +                      : : : : qspinlock);
> > +     }
> > +
> > +no_zacas:
> > +     using_ext =3D "using Ziccrse";
> > +     asm goto(ALTERNATIVE("nop", "j %[qspinlock]", 0,
> > +                          RISCV_ISA_EXT_ZICCRSE, 1)
> > +              : : : : qspinlock);
> > +
> > +     static_branch_disable(&qspinlock_key);
> > +     pr_info("Ticket spinlock: enabled\n");
> > +
> > +     return;
> > +
> > +qspinlock:
> > +     pr_info("Queued spinlock %s: enabled\n", using_ext);
> > +}
>
> This function would be much easier to read with
> riscv_has_extension_[un]likely(), or even riscv_isa_extension_available()=
 since
> it only gets called once. Thankfully the concerns about using those insid=
e
> macros don't apply here :)
>

Yeah, way better, thanks!

Alex

> Regards,
> Samuel
>
> > +
> >  extern void __init init_rt_signal_env(void);
> >
> >  void __init setup_arch(char **cmdline_p)
> > @@ -295,6 +327,7 @@ void __init setup_arch(char **cmdline_p)
> >       riscv_set_dma_cache_alignment();
> >
> >       riscv_user_isa_enable();
> > +     riscv_spinlock_init();
> >  }
> >
> >  bool arch_cpu_is_hotpluggable(int cpu)
> > diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspi=
nlock.h
> > index 0655aa5b57b2..bf47cca2c375 100644
> > --- a/include/asm-generic/qspinlock.h
> > +++ b/include/asm-generic/qspinlock.h
> > @@ -136,6 +136,7 @@ static __always_inline bool virt_spin_lock(struct q=
spinlock *lock)
> >  }
> >  #endif
> >
> > +#ifndef __no_arch_spinlock_redefine
> >  /*
> >   * Remapping spinlock architecture specific functions to the correspon=
ding
> >   * queued spinlock functions.
> > @@ -146,5 +147,6 @@ static __always_inline bool virt_spin_lock(struct q=
spinlock *lock)
> >  #define arch_spin_lock(l)            queued_spin_lock(l)
> >  #define arch_spin_trylock(l)         queued_spin_trylock(l)
> >  #define arch_spin_unlock(l)          queued_spin_unlock(l)
> > +#endif
> >
> >  #endif /* __ASM_GENERIC_QSPINLOCK_H */
> > diff --git a/include/asm-generic/ticket_spinlock.h b/include/asm-generi=
c/ticket_spinlock.h
> > index cfcff22b37b3..325779970d8a 100644
> > --- a/include/asm-generic/ticket_spinlock.h
> > +++ b/include/asm-generic/ticket_spinlock.h
> > @@ -89,6 +89,7 @@ static __always_inline int ticket_spin_is_contended(a=
rch_spinlock_t *lock)
> >       return (s16)((val >> 16) - (val & 0xffff)) > 1;
> >  }
> >
> > +#ifndef __no_arch_spinlock_redefine
> >  /*
> >   * Remapping spinlock architecture specific functions to the correspon=
ding
> >   * ticket spinlock functions.
> > @@ -99,5 +100,6 @@ static __always_inline int ticket_spin_is_contended(=
arch_spinlock_t *lock)
> >  #define arch_spin_lock(l)            ticket_spin_lock(l)
> >  #define arch_spin_trylock(l)         ticket_spin_trylock(l)
> >  #define arch_spin_unlock(l)          ticket_spin_unlock(l)
> > +#endif
> >
> >  #endif /* __ASM_GENERIC_TICKET_SPINLOCK_H */
>

