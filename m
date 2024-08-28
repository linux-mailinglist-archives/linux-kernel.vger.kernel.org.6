Return-Path: <linux-kernel+bounces-305051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1128D9628AB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88E611F23579
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDE017839E;
	Wed, 28 Aug 2024 13:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="CTotflh6"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4273E1C69C
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 13:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724851950; cv=none; b=ub+eDxAe9Oo1o8RlPWqHvnyjDkuEWxKH1HPOy0XNBRDWOKPcJppRn+dgYU4opSHKCaqH9FXP60aNX3a2u+pYqMD/7G6ktvlAotsX4maN1wEL/OdHcO8jcNnUNCLeEejs+laje8cO/jE6Rzb0lwz6V3xFp4Fq2UCsTDPU4VCOzLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724851950; c=relaxed/simple;
	bh=XZKTfpypozM1kgyEt3aUPENstjOFnT9QP6diuQGoO3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tOvIm3O+5j7scZyguiHDiokL007nTx8c7Kuc95BWYMy9I+rA4n0Ny0+O8W7KbnAy9hXc6jKgAhFMaJ1clJG4wLHz6m1HqDpp1XiPd0F3xbkIyxpy8eeYtRG+mm30KPJPzeHbmCB3cT7fgNJZaRa4BZxL27tUnURbP1aJCAlLQaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=CTotflh6; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-371c5187198so3814623f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 06:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724851946; x=1725456746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2/q+7PFaGhwDmuDePCrfQEaUGhDbKSLiyMlbMA+FeY=;
        b=CTotflh6xeWYWOpUwKB80kVTEZ4Oq0CVWVbGTBN+JY5tu9lBLFgNbM3H5EEnSNHMte
         6utp3EDJklOIaiUuPIX8GxYUYgQSHEyfhpynK63g9CdPkUSeSt45JO6rmmbyJAR/MQpm
         94eRZj9B3ayxV46Ewv3MX7F4y8XKAUpZd8/6hZjZ9fBDdXua69m7vSq1hBQJuyj4qfBR
         xlgpgQmTYVMph90qV9HLobmm3jkVjTEl4EnR3pqc4kTA8nbQsF39gBmWz6BWs0A1VnOe
         hoy9V1jT589O2MIqCQkbB5pFt9ccibyxdkrrEDfiABOUdF9S0gBKVIOAg1PVHxcRLOkh
         NzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724851946; x=1725456746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z2/q+7PFaGhwDmuDePCrfQEaUGhDbKSLiyMlbMA+FeY=;
        b=XJ0K+lBMy3bTK6DRqSLG0yE3/WbGND+rjD+2UKLRWJ6iojiOIL0mRVn8PmkNXMMEsj
         pJxDTB6KSE3r+EP+hnah4Jn+bDXxl/uuwVooPqaOm5wVpLMvhefUQep+OP6r1WDwY9E/
         bvEzFeHEX38zOwXiFULE8KD45SGFP6XyZM4hRcqEgnDUG9QB7SZzuN5J01vHG4eL+hhv
         HkaeHv2bhgYimaNLC7/H84CpVFIwUow3KHujM42k68vjvYhpcMbGcKJw125qJqKoZAJ0
         OrVM/fRNjj2mWn/62E2HLrB/t1Nh4IkvAnXcwvcFIK3ptRPx9MjGsiSRU99m4vhOGNRy
         4l0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWb0x9Hyi2LOYjpcjRYsDSAwB+QBrAJLV+0/0y9JiRSU2XE8Bw1rNhemwIoZfFLbR+2F+ZRP2D1AyjGKvs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxiv8jxiby90FeJUffCenozE6wBeHkgQTVGZSzcvB8wf51e7QJC
	0rmN7vgpZBsHvKokkdYLmda1saI7kCmYt729r3q5YS3xsWF3K1StMwyE80/N+vlws0T6czT4bBX
	PU/apBZ87PNx3aCavvVPRBjpGukU8MIqo0NBZfQ==
X-Google-Smtp-Source: AGHT+IGUAkj5ubvZ0iypTLmstsUvjfdz1Cq9hXfByoaVm+OSZW6ZJxpc4PqrSM84tyF9BiwS2R4Iceoc/9PCIQIJ7lw=
X-Received: by 2002:a05:6000:1f86:b0:371:8c61:5777 with SMTP id
 ffacd0b85a97d-37496813caamr2063221f8f.22.1724851946423; Wed, 28 Aug 2024
 06:32:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826105737.106879-1-alexghiti@rivosinc.com> <869b5faa-82c3-456a-a7b0-6dcc41114280@sifive.com>
In-Reply-To: <869b5faa-82c3-456a-a7b0-6dcc41114280@sifive.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Wed, 28 Aug 2024 15:32:15 +0200
Message-ID: <CAHVXubjv7JKyfK4FBkHUGq+rMTiMExznGEiO8btKkAtg75iqYQ@mail.gmail.com>
Subject: Re: [PATCH -fixes] riscv: Fix RISCV_ALTERNATIVE_EARLY
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

On Wed, Aug 28, 2024 at 3:08=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> Hi Alex,
>
> On 2024-08-26 5:57 AM, Alexandre Ghiti wrote:
> > RISCV_ALTERNATIVE_EARLY will issue sbi_ecall() very early in the boot
> > process, before the first memory mapping is setup so we can't have any
> > instrumentation happening here.
> >
> > In addition, when the kernel is relocatable, we must also not issue any
> > relocation this early since they would have been patched virtually only=
.
> >
> > So, instead of disabling instrumentation for the whole kernel/sbi.c fil=
e
> > and compiling it with -fno-pie, simply move __sbi_ecall() and
> > __sbi_base_ecall() into their own file where this is fixed.
>
> Looking at the baseline disassembly from both LLVM 19 and GCC 13.2.0 with
> RISCV_ALTERNATIVE_EARLY + KASAN + TRACEPOINTS, all of the instrumentation=
 in
> __sbi_ecall() itself is out of line and only executed when the tracepoint=
 static
> branches are enabled. However, there is instrumentation in sbi_get_m*id()=
 from
> the switch table inlined from sbi_err_map_linux_errno(), and some of thos=
e
> memory accesses are done unconditionally.
>
> This change will force sbi_err_map_linux_errno() to be out of line (unles=
s LTO
> is enabled), so it also forces that particular bit of instrumentation to =
be
> executed only in the error path. But we could still crash in the error pa=
th. So
> I think sbi_err_map_linux_errno() needs to be moved to sbi_ecall.c as wel=
l.
>
> Alternatively, sbi_get_m*id() do not have any errors defined (and we don'=
t
> really handle that possibility), so we could drop to the call to
> sbi_err_map_linux_errno() from __sbi_base_ecall().

Damn, I should have checked but I was sure it was a static inline in
sbi.h, which would be another solution. I prefer this solution, WDYT?

Thanks,

Alex

>
> Regards,
> Samuel
>
> > Fixes: 1745cfafebdf ("riscv: don't use global static vars to store alte=
rnative data")
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/sbi.h  |  2 ++
> >  arch/riscv/kernel/Makefile    |  6 ++++-
> >  arch/riscv/kernel/sbi.c       | 44 --------------------------------
> >  arch/riscv/kernel/sbi_ecall.c | 48 +++++++++++++++++++++++++++++++++++
> >  4 files changed, 55 insertions(+), 45 deletions(-)
> >  create mode 100644 arch/riscv/kernel/sbi_ecall.c
> >
> > diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.=
h
> > index 7cffd4ffecd0..5843a10b380e 100644
> > --- a/arch/riscv/include/asm/sbi.h
> > +++ b/arch/riscv/include/asm/sbi.h
> > @@ -9,6 +9,7 @@
> >
> >  #include <linux/types.h>
> >  #include <linux/cpumask.h>
> > +#include <linux/jump_label.h>
> >
> >  #ifdef CONFIG_RISCV_SBI
> >  enum sbi_ext_id {
> > @@ -304,6 +305,7 @@ struct sbiret {
> >  };
> >
> >  void sbi_init(void);
> > +long __sbi_base_ecall(int fid);
> >  struct sbiret __sbi_ecall(unsigned long arg0, unsigned long arg1,
> >                         unsigned long arg2, unsigned long arg3,
> >                         unsigned long arg4, unsigned long arg5,
> > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > index 06d407f1b30b..7f88cc4931f5 100644
> > --- a/arch/riscv/kernel/Makefile
> > +++ b/arch/riscv/kernel/Makefile
> > @@ -20,17 +20,21 @@ endif
> >  ifdef CONFIG_RISCV_ALTERNATIVE_EARLY
> >  CFLAGS_alternative.o :=3D -mcmodel=3Dmedany
> >  CFLAGS_cpufeature.o :=3D -mcmodel=3Dmedany
> > +CFLAGS_sbi_ecall.o :=3D -mcmodel=3Dmedany
> >  ifdef CONFIG_FTRACE
> >  CFLAGS_REMOVE_alternative.o =3D $(CC_FLAGS_FTRACE)
> >  CFLAGS_REMOVE_cpufeature.o =3D $(CC_FLAGS_FTRACE)
> > +CFLAGS_REMOVE_sbi_ecall.o =3D $(CC_FLAGS_FTRACE)
> >  endif
> >  ifdef CONFIG_RELOCATABLE
> >  CFLAGS_alternative.o +=3D -fno-pie
> >  CFLAGS_cpufeature.o +=3D -fno-pie
> > +CFLAGS_sbi_ecall.o +=3D -fno-pie
> >  endif
> >  ifdef CONFIG_KASAN
> >  KASAN_SANITIZE_alternative.o :=3D n
> >  KASAN_SANITIZE_cpufeature.o :=3D n
> > +KASAN_SANITIZE_sbi_ecall.o :=3D n
> >  endif
> >  endif
> >
> > @@ -88,7 +92,7 @@ obj-$(CONFIG_DYNAMIC_FTRACE)        +=3D mcount-dyn.o
> >
> >  obj-$(CONFIG_PERF_EVENTS)    +=3D perf_callchain.o
> >  obj-$(CONFIG_HAVE_PERF_REGS) +=3D perf_regs.o
> > -obj-$(CONFIG_RISCV_SBI)              +=3D sbi.o
> > +obj-$(CONFIG_RISCV_SBI)              +=3D sbi.o sbi_ecall.o
> >  ifeq ($(CONFIG_RISCV_SBI), y)
> >  obj-$(CONFIG_SMP)            +=3D sbi-ipi.o
> >  obj-$(CONFIG_SMP) +=3D cpu_ops_sbi.o
> > diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> > index 837bdab2601b..ace9e2f59c41 100644
> > --- a/arch/riscv/kernel/sbi.c
> > +++ b/arch/riscv/kernel/sbi.c
> > @@ -14,9 +14,6 @@
> >  #include <asm/smp.h>
> >  #include <asm/tlbflush.h>
> >
> > -#define CREATE_TRACE_POINTS
> > -#include <asm/trace.h>
> > -
> >  /* default SBI version is 0.1 */
> >  unsigned long sbi_spec_version __ro_after_init =3D SBI_SPEC_VERSION_DE=
FAULT;
> >  EXPORT_SYMBOL(sbi_spec_version);
> > @@ -27,36 +24,6 @@ static int (*__sbi_rfence)(int fid, const struct cpu=
mask *cpu_mask,
> >                          unsigned long start, unsigned long size,
> >                          unsigned long arg4, unsigned long arg5) __ro_a=
fter_init;
> >
> > -struct sbiret __sbi_ecall(unsigned long arg0, unsigned long arg1,
> > -                       unsigned long arg2, unsigned long arg3,
> > -                       unsigned long arg4, unsigned long arg5,
> > -                       int fid, int ext)
> > -{
> > -     struct sbiret ret;
> > -
> > -     trace_sbi_call(ext, fid);
> > -
> > -     register uintptr_t a0 asm ("a0") =3D (uintptr_t)(arg0);
> > -     register uintptr_t a1 asm ("a1") =3D (uintptr_t)(arg1);
> > -     register uintptr_t a2 asm ("a2") =3D (uintptr_t)(arg2);
> > -     register uintptr_t a3 asm ("a3") =3D (uintptr_t)(arg3);
> > -     register uintptr_t a4 asm ("a4") =3D (uintptr_t)(arg4);
> > -     register uintptr_t a5 asm ("a5") =3D (uintptr_t)(arg5);
> > -     register uintptr_t a6 asm ("a6") =3D (uintptr_t)(fid);
> > -     register uintptr_t a7 asm ("a7") =3D (uintptr_t)(ext);
> > -     asm volatile ("ecall"
> > -                   : "+r" (a0), "+r" (a1)
> > -                   : "r" (a2), "r" (a3), "r" (a4), "r" (a5), "r" (a6),=
 "r" (a7)
> > -                   : "memory");
> > -     ret.error =3D a0;
> > -     ret.value =3D a1;
> > -
> > -     trace_sbi_return(ext, ret.error, ret.value);
> > -
> > -     return ret;
> > -}
> > -EXPORT_SYMBOL(__sbi_ecall);
> > -
> >  int sbi_err_map_linux_errno(int err)
> >  {
> >       switch (err) {
> > @@ -535,17 +502,6 @@ long sbi_probe_extension(int extid)
> >  }
> >  EXPORT_SYMBOL(sbi_probe_extension);
> >
> > -static long __sbi_base_ecall(int fid)
> > -{
> > -     struct sbiret ret;
> > -
> > -     ret =3D sbi_ecall(SBI_EXT_BASE, fid, 0, 0, 0, 0, 0, 0);
> > -     if (!ret.error)
> > -             return ret.value;
> > -     else
> > -             return sbi_err_map_linux_errno(ret.error);
> > -}
> > -
> >  static inline long sbi_get_spec_version(void)
> >  {
> >       return __sbi_base_ecall(SBI_EXT_BASE_GET_SPEC_VERSION);
> > diff --git a/arch/riscv/kernel/sbi_ecall.c b/arch/riscv/kernel/sbi_ecal=
l.c
> > new file mode 100644
> > index 000000000000..24aabb4fbde3
> > --- /dev/null
> > +++ b/arch/riscv/kernel/sbi_ecall.c
> > @@ -0,0 +1,48 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2024 Rivos Inc. */
> > +
> > +#include <asm/sbi.h>
> > +#define CREATE_TRACE_POINTS
> > +#include <asm/trace.h>
> > +
> > +long __sbi_base_ecall(int fid)
> > +{
> > +     struct sbiret ret;
> > +
> > +     ret =3D sbi_ecall(SBI_EXT_BASE, fid, 0, 0, 0, 0, 0, 0);
> > +     if (!ret.error)
> > +             return ret.value;
> > +     else
> > +             return sbi_err_map_linux_errno(ret.error);
> > +}
> > +EXPORT_SYMBOL(__sbi_base_ecall);
> > +
> > +struct sbiret __sbi_ecall(unsigned long arg0, unsigned long arg1,
> > +                       unsigned long arg2, unsigned long arg3,
> > +                       unsigned long arg4, unsigned long arg5,
> > +                       int fid, int ext)
> > +{
> > +     struct sbiret ret;
> > +
> > +     trace_sbi_call(ext, fid);
> > +
> > +     register uintptr_t a0 asm ("a0") =3D (uintptr_t)(arg0);
> > +     register uintptr_t a1 asm ("a1") =3D (uintptr_t)(arg1);
> > +     register uintptr_t a2 asm ("a2") =3D (uintptr_t)(arg2);
> > +     register uintptr_t a3 asm ("a3") =3D (uintptr_t)(arg3);
> > +     register uintptr_t a4 asm ("a4") =3D (uintptr_t)(arg4);
> > +     register uintptr_t a5 asm ("a5") =3D (uintptr_t)(arg5);
> > +     register uintptr_t a6 asm ("a6") =3D (uintptr_t)(fid);
> > +     register uintptr_t a7 asm ("a7") =3D (uintptr_t)(ext);
> > +     asm volatile ("ecall"
> > +                    : "+r" (a0), "+r" (a1)
> > +                    : "r" (a2), "r" (a3), "r" (a4), "r" (a5), "r" (a6)=
, "r" (a7)
> > +                    : "memory");
> > +     ret.error =3D a0;
> > +     ret.value =3D a1;
> > +
> > +     trace_sbi_return(ext, ret.error, ret.value);
> > +
> > +     return ret;
> > +}
> > +EXPORT_SYMBOL(__sbi_ecall);
>

