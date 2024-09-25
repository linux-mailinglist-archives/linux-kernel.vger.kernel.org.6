Return-Path: <linux-kernel+bounces-339300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA35598641A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6497B322A1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783B518CC07;
	Wed, 25 Sep 2024 15:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Oyca0lHS"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573A118BBA5
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 15:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276536; cv=none; b=JSIAWgv1lvWkdR7HMDD4ZO0nvM61NBjhRLGIXp23VBUddjlCe2HldL9QLpI5dd9q+xjpp0ruirYjOsSZA+6czPm4V8M9YYDQlbGfWclfKWjQJKEAM2lEiakuyD9MA6RCPWb+1KojwJQIq00YLEHD5b1A2Iy5yG4lBCROMHafnak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276536; c=relaxed/simple;
	bh=7D0glTmsZexHQSacQdFwY8gTv02ecHvdzfYXGwImFZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p+XT6V7VtxB58NEBnUbm0EX/UPJE5HIl2P+eF8VmQQzF1sU2V7Vf8npxZ8foDX+2K9Zds0r6AVmVn/Xq7Qz1TFJqBstyt3UL68fW9bEE9C8LuFxro4g/+TUtd16xTT3RFtAmZmY9rSsUi1aAlFUNYz12G3BBGRKyjRuzjdrjZig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Oyca0lHS; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5365a9574b6so10037798e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 08:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727276531; x=1727881331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HO/+/lbyK8ksHcPo+SH99FQp4hBv6ylL+MzFpb065DQ=;
        b=Oyca0lHSJ78XSUzef8HpRODUfSCORl/bAUj0sqmDFUMO0iQePgIorbmcnTO7n/wqmS
         HrMgxC6z6fF4m+IrJMaCKAw0b/40/9sBinh8+BRFaR74/1OrOLbWgKxCJPqB/+kq1YKr
         FZMY6YjVupOKTJXLXjt3u2YFoqhhoWBftZWcumYgergqcACmxIDoXnDsoykd0LW4DhoA
         i+7uGKZrG4hmwobj827DnbgfeOxb7vUSICQazxnRdfnI/CoHGB4x5J7DuY3W8gf3p1PM
         ejlnLNOE79r5TsHZqNiO6+lggcqlNnWD3Fn1Pd7ISDfl1WWWUCTIqPiQtsfA7map+Ik0
         Urug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727276531; x=1727881331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HO/+/lbyK8ksHcPo+SH99FQp4hBv6ylL+MzFpb065DQ=;
        b=F/ncUnob6ANf8eZWwavvdpM5bjf9ouOpV3u4MUQjTJzeuE3E8RcDDyNGDnPpb4L3uh
         A24iQpBfBkQDoltT/DB5Fid8kAAHu/+AJChcgNHmqzwsAvq9Bjd/qMfNYT1hzAW5R7cC
         sB5926MiBAzobhGaBeRC1Zkc7AO12SSvKCTRpHlH1qH0LOArQ1eHfSfw5kCWMx7Ei4/+
         sg6IritqV/qWivD0MaJF+3GLKq0LVOcwvUWrJ4Nj31CEvuFxEEIb6L4gbxFmTNw9XAw4
         /omhBUXRldzD1B3Oabsq/omBxZBW+zozuaJNPKFYQgzRsRKwLj0RjBp0F7McN3YwHYc9
         eORg==
X-Forwarded-Encrypted: i=1; AJvYcCUyKNU7xNGDMmpy4386xecbWaHry523ETcsPRJGA2kgt69CftAanMY6jnZUI14f/NpL3y3RBNhKIPlyNgs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz13fFrfz2s2ckmSrpDjLmEPc+beAkf9oXEMnW8aRdzt6Y1ABTq
	OfMU+9dUuejh6LO3AmHLsfsLUR3XC2zsRCOvnlc0XEATXF6SUW5cVy49OUVVEET2VbhG/5ZdEh+
	vxjjaDjLI4QjjQ30bzmLEtOHRAWr2TA9oMray6A==
X-Google-Smtp-Source: AGHT+IEXlP8gBlUBBp0VF550p0+a52bnbtKGUL1au3ez/hcODyDv8IXO/NkHq/Tva2S1xm8hPYAs3Jr8t04j/sUSPqg=
X-Received: by 2002:a05:6512:1310:b0:533:483f:9562 with SMTP id
 2adb3069b0e04-5387755ce6dmr2988884e87.42.1727276530966; Wed, 25 Sep 2024
 08:02:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925131547.42396-1-luxu.kernel@bytedance.com>
 <20240925131547.42396-2-luxu.kernel@bytedance.com> <20240925-2acd8d9743cf40b999172b40@orel>
In-Reply-To: <20240925-2acd8d9743cf40b999172b40@orel>
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Wed, 25 Sep 2024 23:01:58 +0800
Message-ID: <CAPYmKFuLYyOcVjXrX_cQU-OwUvcFfQcN5GRStS6AyBXpqAVP6g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 1/2] riscv: process: Introduce idle
 thread using Zawrs extension
To: Andrew Jones <ajones@ventanamicro.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	andy.chiu@sifive.com, guoren@kernel.org, christoph.muellner@vrull.eu, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	lihangjing@bytedance.com, dengliang.1214@bytedance.com, 
	xieyongji@bytedance.com, chaiwen.cc@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Thanks a lot for your reply.

On Wed, Sep 25, 2024 at 9:54=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Wed, Sep 25, 2024 at 09:15:46PM GMT, Xu Lu wrote:
> > The Zawrs extension introduces a new instruction WRS.NTO, which will
> > register a reservation set and causes the hart to temporarily stall
> > execution in a low-power state until a store occurs to the reservation
> > set or an interrupt is observed.
> >
> > This commit implements new version of idle thread for RISC-V via Zawrs
> > extension.
> >
> > Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
> > Reviewed-by: Hangjing Li <lihangjing@bytedance.com>
> > Reviewed-by: Liang Deng <dengliang.1214@bytedance.com>
> > Reviewed-by: Wen Chai <chaiwen.cc@bytedance.com>
> > ---
> >  arch/riscv/Kconfig                 | 10 ++++++++
> >  arch/riscv/include/asm/cpuidle.h   | 11 +-------
> >  arch/riscv/include/asm/processor.h | 18 +++++++++++++
> >  arch/riscv/kernel/cpu.c            |  5 ++++
> >  arch/riscv/kernel/process.c        | 41 +++++++++++++++++++++++++++++-
> >  5 files changed, 74 insertions(+), 11 deletions(-)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 939ea7f6a228..56cf6000d286 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -23,6 +23,7 @@ config RISCV
> >       select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
> >       select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
> >       select ARCH_HAS_BINFMT_FLAT
> > +     select ARCH_HAS_CPU_FINALIZE_INIT
> >       select ARCH_HAS_CURRENT_STACK_POINTER
> >       select ARCH_HAS_DEBUG_VIRTUAL if MMU
> >       select ARCH_HAS_DEBUG_VM_PGTABLE
> > @@ -1153,6 +1154,15 @@ endmenu # "Power management options"
> >
> >  menu "CPU Power Management"
> >
> > +config RISCV_ZAWRS_IDLE
> > +     bool "Idle thread using ZAWRS extensions"
> > +     depends on RISCV_ISA_ZAWRS
> > +     default y
> > +     help
> > +             Adds support to implement idle thread using ZAWRS extensi=
on.
> > +
> > +             If you don't know what to do here, say Y.
> > +
> >  source "drivers/cpuidle/Kconfig"
> >
> >  source "drivers/cpufreq/Kconfig"
> > diff --git a/arch/riscv/include/asm/cpuidle.h b/arch/riscv/include/asm/=
cpuidle.h
> > index 71fdc607d4bc..94c9ecb46571 100644
> > --- a/arch/riscv/include/asm/cpuidle.h
> > +++ b/arch/riscv/include/asm/cpuidle.h
> > @@ -10,15 +10,6 @@
> >  #include <asm/barrier.h>
> >  #include <asm/processor.h>
> >
> > -static inline void cpu_do_idle(void)
> > -{
> > -     /*
> > -      * Add mb() here to ensure that all
> > -      * IO/MEM accesses are completed prior
> > -      * to entering WFI.
> > -      */
> > -     mb();
> > -     wait_for_interrupt();
> > -}
> > +void cpu_do_idle(void);
> >
> >  #endif
> > diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/as=
m/processor.h
> > index efa1b3519b23..d0dcdb7e7392 100644
> > --- a/arch/riscv/include/asm/processor.h
> > +++ b/arch/riscv/include/asm/processor.h
> > @@ -12,6 +12,7 @@
> >
> >  #include <vdso/processor.h>
> >
> > +#include <asm/insn-def.h>
> >  #include <asm/ptrace.h>
> >
> >  #define arch_get_mmap_end(addr, len, flags)                  \
> > @@ -148,6 +149,21 @@ static inline void wait_for_interrupt(void)
> >       __asm__ __volatile__ ("wfi");
> >  }
> >
> > +static inline void wrs_nto(unsigned long *addr)
> > +{
> > +     int val;
> > +
> > +     __asm__ __volatile__(
> > +#ifdef CONFIG_64BIT
> > +                     "lr.d %[p], %[v]\n\t"
> > +#else
> > +                     "lr.w %[p], %[v]\n\t"
> > +#endif
>
> val is always 32-bit since it's an int. We should always use lr.w.

The 'int val' is a mistake here. The val can be an unsigned long
(thread_info->flags) when CONFIG_SMP is disabled. So the lr.d is
necessary. I will update the declaration of val from 'int' to
'unsigned long'.

>
> > +                     ZAWRS_WRS_NTO "\n\t"
> > +                     : [p] "=3D&r" (val), [v] "+A" (*addr)
>
> What do 'p' and 'v' represent? If they are pointer and value then they're
> backwards. I would just spell them out [val] and [addr].

Great insight. I will refine the name here to make it more readable.

>
> > +                     : : "memory");
> > +}
> > +
> >  extern phys_addr_t dma32_phys_limit;
> >
> >  struct device_node;
> > @@ -177,6 +193,8 @@ extern int set_unalign_ctl(struct task_struct *tsk,=
 unsigned int val);
> >  #define RISCV_SET_ICACHE_FLUSH_CTX(arg1, arg2)       riscv_set_icache_=
flush_ctx(arg1, arg2)
> >  extern int riscv_set_icache_flush_ctx(unsigned long ctx, unsigned long=
 per_thread);
> >
> > +extern void select_idle_routine(void);
> > +
> >  #endif /* __ASSEMBLY__ */
> >
> >  #endif /* _ASM_RISCV_PROCESSOR_H */
> > diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> > index f6b13e9f5e6c..97a7144fa6cd 100644
> > --- a/arch/riscv/kernel/cpu.c
> > +++ b/arch/riscv/kernel/cpu.c
> > @@ -23,6 +23,11 @@ bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
> >       return phys_id =3D=3D cpuid_to_hartid_map(cpu);
> >  }
> >
> > +void __init arch_cpu_finalize_init(void)
> > +{
> > +     select_idle_routine();
> > +}
>
> Is there a reason we need to do this at arch_cpu_finalize_init() time?
> This seems like the type of thing we have typically done at the bottom of
> setup_arch().

Actually, there is no special reason here. Just imitated the placement
of x86. It works well too if we put it at the end of setup_arch().

>
> > +
> >  /*
> >   * Returns the hart ID of the given device tree node, or -ENODEV if th=
e node
> >   * isn't an enabled and valid RISC-V hart node.
> > diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> > index e4bc61c4e58a..77769965609e 100644
> > --- a/arch/riscv/kernel/process.c
> > +++ b/arch/riscv/kernel/process.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/tick.h>
> >  #include <linux/ptrace.h>
> >  #include <linux/uaccess.h>
> > +#include <linux/static_call.h>
> >
> >  #include <asm/unistd.h>
> >  #include <asm/processor.h>
> > @@ -35,11 +36,49 @@ EXPORT_SYMBOL(__stack_chk_guard);
> >
> >  extern asmlinkage void ret_from_fork(void);
> >
> > -void noinstr arch_cpu_idle(void)
> > +static __cpuidle void default_idle(void)
> > +{
> > +     /*
> > +      * Add mb() here to ensure that all
> > +      * IO/MEM accesses are completed prior
> > +      * to entering WFI.
> > +      */
> > +     mb();
> > +     wait_for_interrupt();
> > +}
> > +
> > +static __cpuidle void wrs_idle(void)
> > +{
> > +     /*
> > +      * Add mb() here to ensure that all
> > +      * IO/MEM accesses are completed prior
> > +      * to entering WRS.NTO.
> > +      */
> > +     mb();
> > +     wrs_nto(&current_thread_info()->flags);
> > +}
> > +
> > +DEFINE_STATIC_CALL_NULL(riscv_idle, default_idle);
> > +
> > +void __cpuidle cpu_do_idle(void)
> > +{
> > +     static_call(riscv_idle)();
> > +}
> > +
> > +void __cpuidle arch_cpu_idle(void)
>
> Switching the section of this from '.noinstr.text' to 'cpuidle.text'
> should probably be a separate patch.
>
> >  {
> >       cpu_do_idle();
> >  }
> >
> > +void __init select_idle_routine(void)
> > +{
> > +     if (IS_ENABLED(CONFIG_RISCV_ZAWRS_IDLE) &&
> > +                     riscv_has_extension_likely(RISCV_ISA_EXT_ZAWRS))
> > +             static_call_update(riscv_idle, wrs_idle);
> > +     else
> > +             static_call_update(riscv_idle, default_idle);
>
> Do we need this 'else'? Can't we set the default at DEFINE_STATIC_CALL*
> time?

Yes, the 'else' branch can be canceled if we set the default idle
function to 'wfi' one using DEFINE_STATIC_CALL. Just not sure which
code looks better.

>
> > +}
> > +
> >  int set_unalign_ctl(struct task_struct *tsk, unsigned int val)
> >  {
> >       if (!unaligned_ctl_available())
> > --
> > 2.20.1
> >
>
> Thanks,
> drew

Best regards,

Xu Lu.

