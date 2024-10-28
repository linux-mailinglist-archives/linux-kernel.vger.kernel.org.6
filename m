Return-Path: <linux-kernel+bounces-385964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1155A9B3D8B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD4D8282448
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7EB1EE021;
	Mon, 28 Oct 2024 22:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D9pbPpQh"
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20CC1EE015
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 22:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730153553; cv=none; b=iB/g0OI0hdimDJ/gMm0tCnRvpMB0tq0TCbN4h73md4JBGxtPl+ZUWJAenoPij5ApvsFYpRrAerl6RmZV5n1WexGHrrLWeUKMA4yl1AQmdAqq0Bxbk9qIxYtnjSfdWVwkTEpZ0LfoglDxImJaABccbEuj5GDOJnbzwW5w4BL+LyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730153553; c=relaxed/simple;
	bh=hhs0utQtD+384xAHaF5FZAquaCI6CWjmvEnhz8nqyD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E89uFAgenxDKapjpx7Gt3Lrhz8lQdkVvLUE/lsBA0Cl6L+iqmg2o9RjD1b0zdorOr6GpxW8sPlUWSLoTgGIw0C9Ww/AZ1SrLS/tvbI9pQXZjq08aXItZpJlCY9tdVfUmUXtzjzkKbRpy5x/f3W+BQRlum8v9+AFhSW3Ylawt9VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D9pbPpQh; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4a47d70cd8aso1454422137.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730153549; x=1730758349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLJb+MSFeIuMjaWbZFbinF8pHkgM5h+mk8sFEoJ/Tys=;
        b=D9pbPpQh3MozMH5g/33hG+aJmDKUvBzTZEOc93zEQ/eQq6+lXRh2FPpHXmUq/TYrlL
         E8EErj0x/D3xl4xjEYgMuhul0o3hst1I6mrSi9QHuggU3QTktNG6KNsteVyTmcW+2t57
         aVSmlPuR1DcsMJEPzVOM8eZ6LMU2wNSUlI/tIJYyDsn1xgj1a7PhGWJSixTRFykdvpU9
         EVEffcwKhzSmxdKSBJrkrnMIaQH4xcXdc8VyaEqag34LHB1agps+JMm9SNow2AAQKDrA
         wgPCX257Be+kOxy/2PNAkCPHMVZAaGJUx+QIArtpB8/2wm5gT/zBNputl7WpNGV6MQRN
         jeyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730153549; x=1730758349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mLJb+MSFeIuMjaWbZFbinF8pHkgM5h+mk8sFEoJ/Tys=;
        b=Yvk55bNSDKprmbKdP+xDciEdH5M4IPDb+sBUWTp/KIbdXxjz9XFrqHHq8SyJwP6ZRG
         OBPf1HjnOczyR6pbEZn85DSFkY8L4z5NwvKImH5+J0aJAkxPW7xF6n+cuYYvtelYUknW
         OWWgYDCqUD25nlLeS3KnmYpiyQlQTtP/fz4iOZP+6ensbJ4mQSycR2ZxDWMDGLqGBWgK
         ZrPn0Se8IWOZHQWjXy0Ir62zBYjgk1auRXC1UXi+NATB7kacVFW1396eZttr67VpaF2N
         U6Lhx5cqoTIRSsiUy9d0AQJfkbYg6f6F2Vv2iCAdG/NoyepPwWvtggz4wRyJC87GnEda
         z4RA==
X-Forwarded-Encrypted: i=1; AJvYcCWHkQgJ/v8J+ALROXe75Itrgfh9ZXA5NaDszERqmCSDcPcu/yk13uGRcAcD7WXvQIToR1/XbbTrseUuQZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfvHhz5azXH0RHxQq5elKg7RgnCgOnFDAkFyDy8yLRAnBSfMfs
	YWUikXYZz9MrLgLg+7TFs08homjwW4uGv1JiRQ0Fyv1CyFEFdyxphUpsvPSvqpPfYpFi17Yvj6l
	a0PiQJQkM747+1grkmYNITn+lSkQLdI71qHYJ
X-Google-Smtp-Source: AGHT+IGhZjhk8TWm4Ox13TlDPCl1f+no887h0FoY5bya9X/aDkGoU1CVHkU9ScAAG7rcSvUbBqANUY0rSjFirr2oCPk=
X-Received: by 2002:a05:6102:290e:b0:4a5:e63f:3655 with SMTP id
 ada2fe7eead31-4a8cfb27a53mr8607614137.1.1730153549305; Mon, 28 Oct 2024
 15:12:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021042218.746659-1-yuzhao@google.com> <20241021042218.746659-5-yuzhao@google.com>
 <868qug3yig.wl-maz@kernel.org>
In-Reply-To: <868qug3yig.wl-maz@kernel.org>
From: Yu Zhao <yuzhao@google.com>
Date: Mon, 28 Oct 2024 16:11:52 -0600
Message-ID: <CAOUHufabSWTZ+cBjXEDTRh61GeALL5b6uh0M76=2ninZP3KAzQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] arm64: broadcast IPIs to pause remote CPUs
To: Marc Zyngier <maz@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Muchun Song <muchun.song@linux.dev>, Thomas Gleixner <tglx@linutronix.de>, 
	Will Deacon <will@kernel.org>, Douglas Anderson <dianders@chromium.org>, 
	Mark Rutland <mark.rutland@arm.com>, Nanyong Sun <sunnanyong@huawei.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 10:15=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrot=
e:
>
> On Mon, 21 Oct 2024 05:22:16 +0100,
> Yu Zhao <yuzhao@google.com> wrote:
> >
> > Broadcast pseudo-NMI IPIs to pause remote CPUs for a short period of
> > time, and then reliably resume them when the local CPU exits critical
> > sections that preclude the execution of remote CPUs.
> >
> > A typical example of such critical sections is BBM on kernel PTEs.
> > HugeTLB Vmemmap Optimization (HVO) on arm64 was disabled by
> > commit 060a2c92d1b6 ("arm64: mm: hugetlb: Disable
> > HUGETLB_PAGE_OPTIMIZE_VMEMMAP") due to the folllowing reason:
> >
> >   This is deemed UNPREDICTABLE by the Arm architecture without a
> >   break-before-make sequence (make the PTE invalid, TLBI, write the
> >   new valid PTE). However, such sequence is not possible since the
> >   vmemmap may be concurrently accessed by the kernel.
> >
> > Supporting BBM on kernel PTEs is one of the approaches that can make
> > HVO theoretically safe on arm64.
>
> Is the safety only theoretical? I would have expected that we'd use an
> approach that is absolutely rock-solid.

We've been trying to construct a repro against the original HVO
(missing BBM), but so far no success. Hopefully a repro does exist,
and then we'd be able to demonstrate the effectiveness of this series,
which is only theoretical at the moment.

> > Note that it is still possible for the paused CPUs to perform
> > speculative translations. Such translations would cause spurious
> > kernel PFs, which should be properly handled by
> > is_spurious_el1_translation_fault().
>
> Speculative translation faults are never reported, that'd be a CPU
> bug.

Right, I meant to say "speculative accesses that cause translations".

> *Spurious* translation faults can be reported if the CPU doesn't
> implement FEAT_ETS2, for example, and that has to do with the ordering
> of memory access wrt page-table walking for the purpose of translations.

Just want to make sure I fully understand: after the local CPU sends
TLBI (followed by DSB & ISB), FEAT_ETS2 would act like DSB & ISB on
remote CPUs when they perform the invalidation, and therefore
speculative accesses are ordered as well on remote CPUs.

Also I'm assuming IPIs on remote CPUs don't act like a full barrier,
and whatever they interrupt still can be speculatively executed even
though the IPI hander itself doesn't access the vmemmap area
undergoing BBM. Is this correct?

> > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > ---
> >  arch/arm64/include/asm/smp.h |  3 ++
> >  arch/arm64/kernel/smp.c      | 92 +++++++++++++++++++++++++++++++++---
> >  2 files changed, 88 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.=
h
> > index 2510eec026f7..cffb0cfed961 100644
> > --- a/arch/arm64/include/asm/smp.h
> > +++ b/arch/arm64/include/asm/smp.h
> > @@ -133,6 +133,9 @@ bool cpus_are_stuck_in_kernel(void);
> >  extern void crash_smp_send_stop(void);
> >  extern bool smp_crash_stop_failed(void);
> >
> > +void pause_remote_cpus(void);
> > +void resume_remote_cpus(void);
> > +
> >  #endif /* ifndef __ASSEMBLY__ */
> >
> >  #endif /* ifndef __ASM_SMP_H */
> > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> > index 3b3f6b56e733..68829c6de1b1 100644
> > --- a/arch/arm64/kernel/smp.c
> > +++ b/arch/arm64/kernel/smp.c
> > @@ -85,7 +85,12 @@ static int ipi_irq_base __ro_after_init;
> >  static int nr_ipi __ro_after_init =3D NR_IPI;
> >  static struct irq_desc *ipi_desc[MAX_IPI] __ro_after_init;
> >
> > -static bool crash_stop;
> > +enum {
> > +     SEND_STOP =3D BIT(0),
> > +     CRASH_STOP =3D BIT(1),
> > +};
> > +
> > +static unsigned long stop_in_progress;
> >
> >  static void ipi_setup(int cpu);
> >
> > @@ -917,6 +922,79 @@ static void __noreturn ipi_cpu_crash_stop(unsigned=
 int cpu, struct pt_regs *regs
> >  #endif
> >  }
> >
> > +static DEFINE_SPINLOCK(cpu_pause_lock);
>
> PREEMPT_RT will turn this into a sleeping lock. Is it safe to sleep as
> you are dealing with kernel mappings?

Right, it should be a raw spinlock -- the caller disabled preemption,
which as you said is required when dealing with the kernel mappings.

> > +static cpumask_t paused_cpus;
> > +static cpumask_t resumed_cpus;
> > +
> > +static void pause_local_cpu(void)
> > +{
> > +     int cpu =3D smp_processor_id();
> > +
> > +     cpumask_clear_cpu(cpu, &resumed_cpus);
> > +     /*
> > +      * Paired with pause_remote_cpus() to confirm that this CPU not o=
nly
> > +      * will be paused but also can be reliably resumed.
> > +      */
> > +     smp_wmb();
> > +     cpumask_set_cpu(cpu, &paused_cpus);
> > +     /* paused_cpus must be set before waiting on resumed_cpus. */
> > +     barrier();
>
> I'm not sure what this is trying to enforce. Yes, the compiler won't
> reorder the set and the test.

Sorry I don't follow: does cpumask_set_cpu(), i.e., set_bit(), already
contain a compiler barrier?

My understanding is that the compiler is free to reorder the set and
test on those two independent variables, and make it like this:

  while (!cpumask_test_cpu(cpu, &resumed_cpus))
      cpu_relax();
  cpumask_set_cpu(cpu, &paused_cpus);

So the CPU sent the IPI would keep waiting on paused_cpus being set,
and this CPU would keep waiting on resumed_cpus being set, which would
end up with a deadlock.

> But your comment seems to indicate that
> also need to make sure the CPU preserves that ordering
> and short of a
> DMB, the test below could be reordered.

If this CPU reorders the set and test like above, it wouldn't be a
problem because the set would eventually appear on the other CPU that
sent the IPI.

> > +     while (!cpumask_test_cpu(cpu, &resumed_cpus))
> > +             cpu_relax();
> > +     /* A typical example for sleep and wake-up functions. */
>
> I'm not sure this is "typical",...

Sorry, this full barrier isn't needed. Apparently I didn't properly
fix this from the previous attempt to use wfe()/sev() to make this
function the sleeper for resume_remote_cpus() to wake up.

> > +     smp_mb();
> > +     cpumask_clear_cpu(cpu, &paused_cpus);
> > +}
> > +
> > +void pause_remote_cpus(void)
> > +{
> > +     cpumask_t cpus_to_pause;
> > +
> > +     lockdep_assert_cpus_held();
> > +     lockdep_assert_preemption_disabled();
> > +
> > +     cpumask_copy(&cpus_to_pause, cpu_online_mask);
> > +     cpumask_clear_cpu(smp_processor_id(), &cpus_to_pause);
>
> This bitmap is manipulated outside of your cpu_pause_lock. What
> guarantees you can't have two CPUs stepping on each other here?

Do you mean cpus_to_pause? If so, that's a local bitmap.

> > +
> > +     spin_lock(&cpu_pause_lock);
> > +
> > +     WARN_ON_ONCE(!cpumask_empty(&paused_cpus));
> > +
> > +     smp_cross_call(&cpus_to_pause, IPI_CPU_STOP_NMI);
> > +
> > +     while (!cpumask_equal(&cpus_to_pause, &paused_cpus))
> > +             cpu_relax();
>
> This can be a lot of things to compare, specially that you are
> explicitly mentioning large systems. Why can't this be implemented as
> a counter instead?

Agreed - that'd be sufficient and simpler.

> Overall, this looks like stop_machine() in disguise. Why can't this
> use the existing infrastructure?

This came up during the previous discussion [1]. There are
similarities. The main concern with reusing stop_machine() (or part of
its current implementation) is that it may not meet the performance
requirements. Refactoring might be possible, however, it seems to me
(after checking the code again) that such a refactoring unlikely ends
up cleaner or simpler codebase, especially after I got rid of CPU
masks, as you suggested.

[1] https://lore.kernel.org/all/ZbKjHHeEdFYY1xR5@arm.com/

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 3b3f6b56e733..b672af2441a3 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -917,6 +922,64 @@ static void __noreturn
ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs
 #endif
 }

+static DEFINE_RAW_SPINLOCK(cpu_pause_lock);
+static bool __cacheline_aligned_in_smp cpu_paused;
+static atomic_t __cacheline_aligned_in_smp nr_cpus_paused;
+
+static void pause_local_cpu(void)
+{
+ atomic_inc(&nr_cpus_paused);
+
+ while (READ_ONCE(cpu_paused))
+ cpu_relax();
+
+ atomic_dec(&nr_cpus_paused);
+}
+
+void pause_remote_cpus(void)
+{
+ cpumask_t cpus_to_pause;
+ int nr_cpus_to_pause =3D num_online_cpus() - 1;
+
+ lockdep_assert_cpus_held();
+ lockdep_assert_preemption_disabled();
+
+ if (!nr_cpus_to_pause)
+ return;
+
+ cpumask_copy(&cpus_to_pause, cpu_online_mask);
+ cpumask_clear_cpu(smp_processor_id(), &cpus_to_pause);
+
+ raw_spin_lock(&cpu_pause_lock);
+
+ WARN_ON_ONCE(cpu_paused);
+ WARN_ON_ONCE(atomic_read(&nr_cpus_paused));
+
+ cpu_paused =3D true;
+
+ smp_cross_call(&cpus_to_pause, IPI_CPU_STOP_NMI);
+
+ while (atomic_read(&nr_cpus_paused) !=3D nr_cpus_to_pause)
+ cpu_relax();
+
+ raw_spin_unlock(&cpu_pause_lock);
+}
+
+void resume_remote_cpus(void)
+{
+ if (!cpu_paused)
+ return;
+
+ raw_spin_lock(&cpu_pause_lock);
+
+ WRITE_ONCE(cpu_paused, false);
+
+ while (atomic_read(&nr_cpus_paused))
+ cpu_relax();
+
+ raw_spin_unlock(&cpu_pause_lock);

+}
+
 static void arm64_backtrace_ipi(cpumask_t *mask)
 {
  __ipi_send_mask(ipi_desc[IPI_CPU_BACKTRACE], mask);

