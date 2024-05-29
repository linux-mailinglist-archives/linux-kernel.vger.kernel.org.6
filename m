Return-Path: <linux-kernel+bounces-194125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 294018D36F8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 15:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D547C28B6B1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 13:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEE9DDC9;
	Wed, 29 May 2024 13:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="V45Jp9Q/"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367E59461
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 13:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716987798; cv=none; b=MqduVeG0HlOGeiH/yz6K0bICC7K6cvseygaxyncVAc+mC93q0sf1n/z5b7lyxeXlYajH+q1YStZhG7st0RgN+pE1V7VLGPwnB4GKN2SpSUyMFZZq91J0n/TXvERkZyMgYMLdnEvUS7nFF7baNigTyH02kKSnQkWeCBwR9zOVjfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716987798; c=relaxed/simple;
	bh=plbm0UwJrFwfzD9Dmtp+AyvK+To9bjohXCP2XDl3dNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KqNToTmMFjgO4e7Cch6zmycZwssksfhTa0xvcjbPV7S+Bnz9nS5Xx7ivL2ODOVrX4jCx7bxvDV6dYG90XK4upAVcZSYdTy8QphbFdVC1K/V8/A1gvRnBvuo+XuxXHM2fyYEs171h0/ndevfxCOLxSk5j+XoMGNcuvl1dBHehsEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=V45Jp9Q/; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-572c65cea55so1640928a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 06:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716987794; x=1717592594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXoFBUxU8GTDCXQrYS3KoHVxekdKDuF8Uub92bjfWis=;
        b=V45Jp9Q/75QGlURbgeBkhtD89d4/IyOF4IC9UCGS2SagOmqBaha2/7SW4onZAp1swA
         iZvybwVLnwAOcUImNO70SqY6cIVD6DXVXmRsHRrFJ8ZGv1EN663GViVR2L7ffPhOlTG/
         MrmWPw0GcIZ3+fZTaXhnYe4+caHF1ldIgvss4pB+DvAF4FCb0j4f324eEL3nlhSZxFtB
         DaEEKjFuS6bEqVDHjqvEg0FdIXePrmJK5dxOn1Ml23vAsoRlMcOH/s5Ix+vsf2z4LLEW
         yskDKi1/ioJ9g8b0/GYJUTQwRDuNRswaEVh+wWO/2gV480LvGN+EnkTaARmR212yAUTR
         AwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716987794; x=1717592594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eXoFBUxU8GTDCXQrYS3KoHVxekdKDuF8Uub92bjfWis=;
        b=hiXkR9VznzjV7guUmqBVMuVE/7jfwyRxz0esaXsQlSYkXMz0VMDBE908fK5eWHXhck
         dfqSFTIriwKbFKYWc2ROMXYkCkwkYriCiBZgGKQNnXShWK4rFJ/1fBFgL8VzL0bFi5od
         8+eDVPLNOPH9nLLW9mmdXZNMWHnbWvwhDl937jvqFobxg+1ZEgLfokIYo8NgChrLpNld
         je7NaCtx/TTbqUjjdNRVUddaorjc5o0Qxxq+62p1cWbJIwS8E3ObeP9MRlKMIwuruqNR
         rUWqzafxLJllpg9T0rmUnFZ1pbEK3KBzMRz/Oh74aG/2LU/g9eVC0T6jpLvU+tI6WQvJ
         jLig==
X-Forwarded-Encrypted: i=1; AJvYcCX9dYnBHZTEWJDcU50zz36XIAggUXifQpvgN3CsLWBp2IZKDr+1psWN03b8EN8HQ9g0NpwKnhU5W7+Be4Wm4B92UGT923PERk0B6UV4
X-Gm-Message-State: AOJu0Yx7bRJbncdscvIaHaInyMKJ3nWJP2X3GejhywMwma7AEC2Qq76b
	ir6C0LDl/BxyAQPMbyaFl7I2n0ZzURJobHBDiHhEFoB0NIAyq7Mk43aoumLTbPncLk2x4+ufBSD
	KIxl6uvfufKzFvyX6miqXOdbFArpDegb5DiwJbQ==
X-Google-Smtp-Source: AGHT+IELUzP/aMrB1shC4uvPl7RzfKxkfOoSQkW19agD11fiCpbbz06vIPabz5DmKggjJsNuRN2YYEdhS59m6Vlln/c=
X-Received: by 2002:a50:8719:0:b0:574:c3e4:1fa3 with SMTP id
 4fb4d7f45d1cf-57a041388d3mr1586088a12.20.1716987793520; Wed, 29 May 2024
 06:03:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528151052.313031-1-alexghiti@rivosinc.com>
 <20240528151052.313031-8-alexghiti@rivosinc.com> <CAJF2gTQgg-7Fzoz9TsjWD-_8ABbS7M66aEztCsZ9Ejk8LOvmiQ@mail.gmail.com>
In-Reply-To: <CAJF2gTQgg-7Fzoz9TsjWD-_8ABbS7M66aEztCsZ9Ejk8LOvmiQ@mail.gmail.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Wed, 29 May 2024 15:03:00 +0200
Message-ID: <CAHVXubg=T3AMER0z8-iRqqFmDQp8iEM92cXwPZcW2Sfm=_KOHQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] riscv: Add qspinlock support based on Zabha extension
To: Guo Ren <guoren@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Leonardo Bras <leobras@redhat.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Guo,

On Wed, May 29, 2024 at 11:24=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote:
>
> On Tue, May 28, 2024 at 11:18=E2=80=AFPM Alexandre Ghiti <alexghiti@rivos=
inc.com> wrote:
> >
> > In order to produce a generic kernel, a user can select
> > CONFIG_QUEUED_SPINLOCKS which will fallback at runtime to the ticket
> > spinlock implementation if Zabha is not present.
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
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  .../locking/queued-spinlocks/arch-support.txt |  2 +-
> >  arch/riscv/Kconfig                            |  1 +
> >  arch/riscv/include/asm/Kbuild                 |  4 +-
> >  arch/riscv/include/asm/spinlock.h             | 39 +++++++++++++++++++
> >  arch/riscv/kernel/setup.c                     | 18 +++++++++
> >  include/asm-generic/qspinlock.h               |  2 +
> >  include/asm-generic/ticket_spinlock.h         |  2 +
> >  7 files changed, 66 insertions(+), 2 deletions(-)
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
> > index 184a9edb04e0..ccf1703edeb9 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -59,6 +59,7 @@ config RISCV
> >         select ARCH_SUPPORTS_SHADOW_CALL_STACK if HAVE_SHADOW_CALL_STAC=
K
> >         select ARCH_USE_MEMTEST
> >         select ARCH_USE_QUEUED_RWLOCKS
> > +       select ARCH_USE_QUEUED_SPINLOCKS if TOOLCHAIN_HAS_ZABHA
> Using qspinlock or not depends on real hardware capabilities, not the
> compiler flag. That's why I introduced combo-spinlock, ticket-spinlock
> & qspinlock three Kconfigs, and the combo-spinlock would compat all
> hardware platforms but waste some qspinlock code size.

You're right, and I think your comment matches what Conor mentioned
about the lack of clarity with some extensions: TOOLCHAIN_HAS_ZABHA
will allow a platform with Zabha capability to use qspinlocks. But if
the hardware does not, it will fallback to the ticket spinlocks.

But I agree that looking at the config alone may be misleading, even
though it will work as expected at runtime. So I agree with you:
unless anyone is strongly against the combo spinlocks, I will do what
you suggest and add them.

Thanks again for your initial work,

Alex

>
> >         select ARCH_USES_CFI_TRAPS if CFI_CLANG
> >         select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH if SMP && MMU
> >         select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
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
> > index 000000000000..e00429ac20ed
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/spinlock.h
> > @@ -0,0 +1,39 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef __ASM_RISCV_SPINLOCK_H
> > +#define __ASM_RISCV_SPINLOCK_H
> > +
> > +#ifdef CONFIG_QUEUED_SPINLOCKS
> > +#define _Q_PENDING_LOOPS       (1 << 9)
> > +
> > +#define __no_arch_spinlock_redefine
> > +#include <asm/ticket_spinlock.h>
> > +#include <asm/qspinlock.h>
> > +#include <asm/alternative.h>
> > +
> > +DECLARE_STATIC_KEY_TRUE(qspinlock_key);
> > +
> > +#define SPINLOCK_BASE_DECLARE(op, type, type_lock)                    =
 \
> > +static __always_inline type arch_spin_##op(type_lock lock)            =
 \
> > +{                                                                     =
 \
> > +       if (static_branch_unlikely(&qspinlock_key))                    =
 \
> > +               return queued_spin_##op(lock);                         =
 \
> > +       return ticket_spin_##op(lock);                                 =
 \
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
> > index 4f73c0ae44b2..31ce75522fd4 100644
> > --- a/arch/riscv/kernel/setup.c
> > +++ b/arch/riscv/kernel/setup.c
> > @@ -244,6 +244,23 @@ static void __init parse_dtb(void)
> >  #endif
> >  }
> >
> > +DEFINE_STATIC_KEY_TRUE(qspinlock_key);
> > +EXPORT_SYMBOL(qspinlock_key);
> > +
> > +static void __init riscv_spinlock_init(void)
> > +{
> > +       asm goto(ALTERNATIVE("nop", "j %[qspinlock]", 0, RISCV_ISA_EXT_=
ZABHA, 1)
> > +                : : : : qspinlock);
> > +
> > +       static_branch_disable(&qspinlock_key);
> > +       pr_info("Ticket spinlock: enabled\n");
> > +
> > +       return;
> > +
> > +qspinlock:
> > +       pr_info("Queued spinlock: enabled\n");
> > +}
> > +
> >  extern void __init init_rt_signal_env(void);
> >
> >  void __init setup_arch(char **cmdline_p)
> > @@ -295,6 +312,7 @@ void __init setup_arch(char **cmdline_p)
> >         riscv_set_dma_cache_alignment();
> >
> >         riscv_user_isa_enable();
> > +       riscv_spinlock_init();
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
> >  #define arch_spin_lock(l)              queued_spin_lock(l)
> >  #define arch_spin_trylock(l)           queued_spin_trylock(l)
> >  #define arch_spin_unlock(l)            queued_spin_unlock(l)
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
> >         return (s16)((val >> 16) - (val & 0xffff)) > 1;
> >  }
> >
> > +#ifndef __no_arch_spinlock_redefine
> >  /*
> >   * Remapping spinlock architecture specific functions to the correspon=
ding
> >   * ticket spinlock functions.
> > @@ -99,5 +100,6 @@ static __always_inline int ticket_spin_is_contended(=
arch_spinlock_t *lock)
> >  #define arch_spin_lock(l)              ticket_spin_lock(l)
> >  #define arch_spin_trylock(l)           ticket_spin_trylock(l)
> >  #define arch_spin_unlock(l)            ticket_spin_unlock(l)
> > +#endif
> >
> >  #endif /* __ASM_GENERIC_TICKET_SPINLOCK_H */
> > --
> > 2.39.2
> >
>
>
> --
> Best Regards
>  Guo Ren

