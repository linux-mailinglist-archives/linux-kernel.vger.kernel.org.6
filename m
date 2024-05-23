Return-Path: <linux-kernel+bounces-186959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DF08CCB3F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 05:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1B95281B86
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 03:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44F937141;
	Thu, 23 May 2024 03:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0FCuuJY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93408273FD
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 03:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716435970; cv=none; b=UuyhMaWcxCUjj53hIRJ0WNlrnoU9TCRzhWH1qMnNVNOriyncijmy5RXK191aPmGQrDvnrO4Cmubq2fy+sxWdG7jltF6oxzQ36tf+/gJyfeYYJGcCXzbBW/CLehiVWMC++uzpK+aJZ/LNowu5XUXSGhrSGmtp4ehTMBvULlxmqp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716435970; c=relaxed/simple;
	bh=EyVr2NENjXx1Jmoa3e7xaOpzy3YvpYHAy5fqestrjfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VtdwNyh59Eo1qB+8NLueP39CU9eGfsm0z6WbEOutYIuXAr9yKDAW+2fco/nIDGoE3GTUoiYhCBYe4hMgkjPlFsJDGy4whKH6OfMNyegbvziKa1My/1LqN65KgApL16EcQuuYi8ABIdEHTPz5JhDuN4zvHNrfCcVvJMRzbUDLtaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0FCuuJY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E25FC32789
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 03:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716435970;
	bh=EyVr2NENjXx1Jmoa3e7xaOpzy3YvpYHAy5fqestrjfo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r0FCuuJYA5R3PKnutlYcC6wu5fZTaEnyKLS9KQUGPnNjbZn/V9N33K41YIS1TwHLW
	 k7bXSSIcld+Z7+Mt6m9d60kNMvfN2dZafshNJaCpfLhvO9dfF2I3Np9pImueqpPNTK
	 Hy0zeU8ziQRyFnqbFxYQv3jlvg7YFE3XHW3MLmkwLgaoHbgYG4fVWzTEjueSJ19d9I
	 IlqJ5nb82xoF3DzZb2an++D8+uySz6k9vqmtcc9LArK1YPqZbm0HMvpJLny7eJ4W4a
	 nniCy3SO23iro7Jb5CsUmXweZl7kqsCnbPpXhf+Lyk9Uy2AF7DOmUn/+uBSWr0agkP
	 itq/kOe1sFx/w==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52388d9ca98so10681362e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 20:46:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXpJMX4aof8EIIB7tgKcZDVgLrr9fjE5zFhghSIUCl8jSR1Tq1KFLcj3vHQnvlPFT6CjgKKCFi8euDZTwWcvkR/NNxAgdvL7ebO947
X-Gm-Message-State: AOJu0YxnWwCdhRGXaFE1p9PFvvrrQpDyTlvuUZllzlcUOYNzf8Waj2wu
	4ZzaultKZSSA04QPYEtAATyI1IyzhwOGwS830FCucFnjPgecOHaEjJllxRurhelGdh8fUIOzy1Y
	T4DZQqibAwNDx+igSykxJdgdor1Y=
X-Google-Smtp-Source: AGHT+IHyVLzrLGqBEHFLdE8BPigvvHczdw5zkq9lsH2+AATUAqxFfwP6ISAnCp0q5SioCZJSjXL7sbOw13BY5+ZGNQo=
X-Received: by 2002:ac2:5ded:0:b0:523:97bc:ea88 with SMTP id
 2adb3069b0e04-526c0b5db3amr2739388e87.51.1716435968653; Wed, 22 May 2024
 20:46:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <mhng-e73e59bf-92fc-4122-9f9e-a329d20eba55@palmer-ri-x1c9>
In-Reply-To: <mhng-e73e59bf-92fc-4122-9f9e-a329d20eba55@palmer-ri-x1c9>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 23 May 2024 12:45:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNASVhbtJ2=72TsCu1C7+uLsXySNffPcNZU2NiFKitM6-Ew@mail.gmail.com>
Message-ID: <CAK7LNASVhbtJ2=72TsCu1C7+uLsXySNffPcNZU2NiFKitM6-Ew@mail.gmail.com>
Subject: Re: [GIT PULL] RISC-V Patches for the 6.10 Merge Window, Part 1
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 1:13=E2=80=AFAM Palmer Dabbelt <palmer@rivosinc.com=
> wrote:
>
> The following changes since commit 4cece764965020c22cff7665b18a0120063590=
95:
>
>   Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/risc=
v-for-linus-6.10-mw1
>
> for you to fetch changes up to 92cce91949a497a8a4615f9ba5813b03f7a1f1d5:
>
>   riscv: defconfig: Enable CONFIG_CLK_SOPHGO_CV1800 (2024-05-13 14:26:34 =
-0700)
>
> ----------------------------------------------------------------
> RISC-V Patches for the 6.10 Merge Window, Part 1
>
> * Support for byte/half-word compare-and-exchange, emulated via LR/SC
>   loops.
> * Support for Rust.
> * Support for Zihintpause in hwprobe.
> * Support for the PR_RISCV_SET_ICACHE_FLUSH_CTX prctl().
> * Support for lockless lockrefs.
>
> ----------------------------------------------------------------
> This was really meant to be last week's PR, but due to a handful of small
> issues.  There's a pair of driver build fixes that are already on the lis=
ts and
> a report of a ftrace failure that might be triggered by the ftrace/AIA fi=
x, but
> seems like we're better off with these than without.  I've got a few othe=
r
> smaller things queued up for Friday, but I figured it'd be best to get th=
is
> moving because there's a handful of merge conflicts.
>
> This first one isn't showing up in a in-flight merge `git diff`, but it l=
ooks
> pretty straight-forward
>
>     diff --git a/Documentation/rust/arch-support.rst b/Documentation/rust=
/arch-support.rst
>     index c9137710633a..4d1495ded2aa 100644
>     --- a/Documentation/rust/arch-support.rst
>     +++ b/Documentation/rust/arch-support.rst
>     @@ -16,7 +16,8 @@ support corresponds to ``S`` values in the ``MAINTA=
INERS`` file.
>      Architecture   Level of support  Constraints
>      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>      ``arm64``      Maintained        Little Endian only.
>     -``loongarch``  Maintained        \-
>     +``loongarch``  Maintained        -
>     +``riscv``      Maintained        ``riscv64`` only.
>      ``um``         Maintained        ``x86_64`` only.
>      ``x86``        Maintained        ``x86_64`` only.
>      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
> There's also one in the IMSIC driver where there's really no way for git =
to
> pick up the conflict, as it's a far-away API change.  Here's my resolutio=
n,
> Anup likes it as well
> <https://lore.kernel.org/all/CAK9=3DC2UkTD0hYymjow-yHHfBDh4CtRv-G2BPt=3Dn=
cstLRmpYgyg@mail.gmail.com/>:
>
>     diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchi=
p/irq-riscv-imsic-early.c
>     index 886418ec06cb..4fbb37074d29 100644
>     --- a/drivers/irqchip/irq-riscv-imsic-early.c
>     +++ b/drivers/irqchip/irq-riscv-imsic-early.c
>     @@ -49,7 +49,7 @@ static int __init imsic_ipi_domain_init(void)
>                 return virq < 0 ? virq : -ENOMEM;
>
>         /* Set vIRQ range */
>     -   riscv_ipi_set_virq_range(virq, IMSIC_NR_IPI, true);
>     +   riscv_ipi_set_virq_range(virq, IMSIC_NR_IPI);
>
>         /* Announce that IMSIC is providing IPIs */
>         pr_info("%pfwP: providing IPIs using interrupt %d\n", imsic->fwno=
de, IMSIC_IPI_ID);
>
> The rest show up pretty normally, so here's the regular merge diff output=
 from
> how I've resolved them:
>
>     diff --cc arch/riscv/Makefile
>     index 1e002d8003c5,321c057e2bdc..000000000000
>     --- a/arch/riscv/Makefile
>     +++ b/arch/riscv/Makefile
>     @@@ -151,20 -166,9 +166,9 @@@ endi
>       endif
>
>       vdso-install-y                    +=3D arch/riscv/kernel/vdso/vdso.=
so.dbg
>      -vdso-install-$(CONFIG_COMPAT)     +=3D arch/riscv/kernel/compat_vds=
o/compat_vdso.so.dbg:../compat_vdso/compat_vdso.so
>      +vdso-install-$(CONFIG_COMPAT)     +=3D arch/riscv/kernel/compat_vds=
o/compat_vdso.so.dbg
>
>     - ifneq ($(CONFIG_XIP_KERNEL),y)
>     - ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_SOC_CANAAN_K210),yy)
>     - KBUILD_IMAGE :=3D $(boot)/loader.bin
>     - else
>     - ifeq ($(CONFIG_EFI_ZBOOT),)
>     - KBUILD_IMAGE :=3D $(boot)/Image.gz
>     - else
>     - KBUILD_IMAGE :=3D $(boot)/vmlinuz.efi
>     - endif
>     - endif
>     - endif
>     - BOOT_TARGETS :=3D Image Image.gz loader loader.bin xipImage vmlinuz=
efi
>     + BOOT_TARGETS :=3D Image Image.gz Image.bz2 Image.lz4 Image.lzma Ima=
ge.lzo Image.zst loader loader.bin xipImage vmlinuz.efi
>
>       all:      $(notdir $(KBUILD_IMAGE))
>
>     diff --cc include/uapi/linux/prctl.h
>     index 713d28788df7,524d546d697b..000000000000
>     --- a/include/uapi/linux/prctl.h
>     +++ b/include/uapi/linux/prctl.h
>     @@@ -306,20 -306,10 +306,26 @@@ struct prctl_mm_map
>       # define PR_RISCV_V_VSTATE_CTRL_NEXT_MASK 0xc
>       # define PR_RISCV_V_VSTATE_CTRL_MASK              0x1f
>
>     + #define PR_RISCV_SET_ICACHE_FLUSH_CTX     71
>     + # define PR_RISCV_CTX_SW_FENCEI_ON        0
>     + # define PR_RISCV_CTX_SW_FENCEI_OFF       1
>     + # define PR_RISCV_SCOPE_PER_PROCESS       0
>     + # define PR_RISCV_SCOPE_PER_THREAD        1
>     +
>      +/* PowerPC Dynamic Execution Control Register (DEXCR) controls */
>      +#define PR_PPC_GET_DEXCR          72
>      +#define PR_PPC_SET_DEXCR          73
>      +/* DEXCR aspect to act on */
>      +# define PR_PPC_DEXCR_SBHE                0 /* Speculative branch h=
int enable */
>      +# define PR_PPC_DEXCR_IBRTPD              1 /* Indirect branch recu=
rrent target prediction disable */
>      +# define PR_PPC_DEXCR_SRAPD               2 /* Subroutine return ad=
dress prediction disable */
>      +# define PR_PPC_DEXCR_NPHIE               3 /* Non-privileged hash =
instruction enable */
>      +/* Action to apply / return */
>      +# define PR_PPC_DEXCR_CTRL_EDITABLE        0x1 /* Aspect can be mod=
ified with PR_PPC_SET_DEXCR */
>      +# define PR_PPC_DEXCR_CTRL_SET             0x2 /* Set the aspect fo=
r this process */
>      +# define PR_PPC_DEXCR_CTRL_CLEAR   0x4 /* Clear the aspect for this=
 process */
>      +# define PR_PPC_DEXCR_CTRL_SET_ONEXEC      0x8 /* Set the aspect on=
 exec */
>      +# define PR_PPC_DEXCR_CTRL_CLEAR_ONEXEC   0x10 /* Clear the aspect =
on exec */
>      +# define PR_PPC_DEXCR_CTRL_MASK           0x1f
>      +
>       #endif /* _LINUX_PRCTL_H */
>     diff --cc kernel/sys.c
>     index f9c95410278c,1b7bda0722ca..000000000000
>     --- a/kernel/sys.c
>     +++ b/kernel/sys.c
>     @@@ -146,13 -146,10 +146,15 @@@
>       #ifndef RISCV_V_GET_CONTROL
>       # define RISCV_V_GET_CONTROL()            (-EINVAL)
>       #endif
>     + #ifndef RISCV_SET_ICACHE_FLUSH_CTX
>     + # define RISCV_SET_ICACHE_FLUSH_CTX(a, b) (-EINVAL)
>     + #endif
>      -
>      +#ifndef PPC_GET_DEXCR_ASPECT
>      +# define PPC_GET_DEXCR_ASPECT(a, b)       (-EINVAL)
>      +#endif
>      +#ifndef PPC_SET_DEXCR_ASPECT
>      +# define PPC_SET_DEXCR_ASPECT(a, b, c)    (-EINVAL)
>      +#endif
>     -
>       /*
>        * this is where the system-wide overflow UID and GID are defined, =
for
>        * architectures that now have 32-bit UID/GID but didn't in the pas=
t
>
>
> ----------------------------------------------------------------
> Alexandre Ghiti (2):
>       riscv: Remove superfluous smp_mb()
>       riscv: Fix text patching when IPI are used
>
> Charlie Jenkins (4):
>       riscv: Remove unnecessary irqflags processor.h include
>       riscv: Include riscv_set_icache_flush_ctx prctl
>       documentation: Document PR_RISCV_SET_ICACHE_FLUSH_CTX prctl
>       cpumask: Add assign cpu
>
> Cl=C3=A9ment L=C3=A9ger (2):
>       riscv: misaligned: remove CONFIG_RISCV_M_MODE specific code
>       riscv: hwprobe: export Zihintpause ISA extension
>
> Dawei Li (2):
>       riscv: Remove redundant CONFIG_64BIT from pgtable_l{4,5}_enabled
>       riscv: Annotate pgtable_l{4,5}_enabled with __ro_after_init
>
> Inochi Amaoto (1):
>       riscv: defconfig: Enable CONFIG_CLK_SOPHGO_CV1800
>
> Jisheng Zhang (4):
>       riscv: select ARCH_USE_CMPXCHG_LOCKREF
>       riscv: cmpxchg: implement arch_cmpxchg64_{relaxed|acquire|release}
>       riscv: mm: still create swiotlb buffer for kmalloc() bouncing if re=
quired
>       riscv: select ARCH_HAS_FAST_MULTIPLIER
>
> Leonardo Bras (5):
>       riscv/cmpxchg: Deduplicate xchg() asm functions
>       riscv/cmpxchg: Deduplicate cmpxchg() asm and macros
>       riscv/atomic.h : Deduplicate arch_atomic.*
>       riscv/cmpxchg: Implement cmpxchg for variables of size 1 and 2
>       riscv/cmpxchg: Implement xchg for variables of size 1 and 2
>
> Masahiro Yamada (2):
>       riscv: merge two if-blocks for KBUILD_IMAGE
>       export.h: remove include/asm-generic/export.h



I am confused.


This commit was applied two months ago by myself,
and it already existed in the mainline.


After this pull request, I do not see no such a commit
applied by Palmer.

Why did this show up in 'git request-pull' ?


The following is the commit in question.




commit 0316e4b04e0156633df7474bae8e8b0791ce028f
Author:     Masahiro Yamada <masahiroy@kernel.org>
AuthorDate: Sat Mar 23 18:06:15 2024 +0900
Commit:     Masahiro Yamada <masahiroy@kernel.org>
CommitDate: Thu Mar 28 11:04:20 2024 +0900

    export.h: remove include/asm-generic/export.h

    Commit 3a6dd5f614a1 ("riscv: remove unneeded #include
    <asm-generic/export.h>") removed the last use of
    include/asm-generic/export.h.

    This deprecated header can go away.

    Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>







--=20
Best Regards
Masahiro Yamada

