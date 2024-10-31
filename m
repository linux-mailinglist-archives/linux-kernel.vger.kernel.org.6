Return-Path: <linux-kernel+bounces-391074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC829B8255
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 19:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B39A28117C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 18:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE621C4614;
	Thu, 31 Oct 2024 18:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mLLlGnsR"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69D81BE87C
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 18:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730398286; cv=none; b=UKrCzQwy+MaVVLjaQBSV6a6QAcOJ+MtG455g3RanxmQj3o+zcHzebU2eFJqfC9Fn7o5I8o3un6DmzQOlaiK0kFe71RirTCe2vRA7PkjDvPkIXuqlgbIl50fTlyOfH9+fUzd9A/A7vXZPmkNS+2EYBypEUMtaTdmkGNAFUxSj2Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730398286; c=relaxed/simple;
	bh=fnNpnfHRE0vYCRV46i8eY6cK3lpmBO1j66nEx/P8Hh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ElcQD4BRP3j5wzdM6WNcjpGFnxBotZxog2CJXxQbpgUVl5q3b/A+dE2/L29qcJd1IcYi3AMSxho+NPmrUPuFOGRyLsRIl4hy53VQmY8+pCVEW4B+BIx78mwjFo0TqkrqmyNu1iz41grQaKr/mOppjKbrOVz59qs9LQHnmnHkXVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mLLlGnsR; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3e6010a3bbfso784694b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 11:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730398283; x=1731003083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zifDQr8Gy9ICyc3p2ENuZG+aDhE1SHEQ39uTi6PmnYo=;
        b=mLLlGnsR/yU8z3ZEWtlpl0MOMgqPFmu8JWie+hZyL62Jx8gjLGqZCQBDnV4aVpRNKA
         VCr1r4MRuIbPHAcRFKOVWoCpSbOtQYICZgAyVU+Sz0dP05L+K8Of2dQILpp7Bag4LOi5
         Wis4L/RMNoeAjSBcfbM9F7SAmMRJ1KSwhI3CCeVgcGPaE/TMV+76wA6lw4SGb3kWoDPr
         Cu+Wfb66TcHnlatuJbuCnXX3Yr8kIwxOA58dzR6Z6cxffv9c0S5wXV3w0uHYvDWhh7Np
         iqETKo2kEuLJ/vN8K2wGJnQWpCGZXKv20KQzTnVExpE0NXZbCQOgDNr8zAevtzmNZ1Do
         8YDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730398283; x=1731003083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zifDQr8Gy9ICyc3p2ENuZG+aDhE1SHEQ39uTi6PmnYo=;
        b=TUvBunbClSNUCjeTLg8fV1EF2aa55b85JbzO+duKRwrraIhiF8BYC4/I/UHZQdTmJP
         MJBVf3LgHlJNnojaRfXj+/j/z2olVLfWBeHt7WfjN1dB8nZS16NIXM5y00j47577nytX
         W3so/yhi4AP5v1qO6DucR6qJ099OITzSdpjJnq4dLcX9JFy+jHBHwFcBvbmrvfx2d5el
         D5/ZOtMpNWWz6Nq0hqv0EJoE4v7roKchR3IuB7yui/r5mztgkmn8+NvH20XmSjRuiT2k
         JakdXQGOb6GdODMfCNbpIdhCeOxcazyI/rqcKj/2pUPqQj2vQbgO0Y0ZXeL98U6G9eex
         ZU4g==
X-Forwarded-Encrypted: i=1; AJvYcCUHptQ2buFwaT3vPoa5duwGl5sebaRxGlJPEg9bj1+JyiRXyeLiZWP1EFuzjUGdqveNHv3fAuIEGmIEvLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL9ZpTO/HJl0LIIJ018Sw78n5lTM9Mk9L5bPxaTy4MOwoYpw2m
	EoyHNNxBKxefTX0PUd8jqvjvABO5SEyB8vBm6kwsrn39mRKWkLWBAFtZoA2gp9Xt8ZkIohHet5J
	mJe9buwhEOXaGg3qSA0844vIeRuEIehqYuytg
X-Google-Smtp-Source: AGHT+IGCZUfA0nt9tbEFHktX/dCx4DkdYhEES5nQZ7wCYXRaHV6mv2O2BXeCcEfn6XydEqak20pVWKM5POqkaQsbpvU=
X-Received: by 2002:a05:6359:4115:b0:1c3:8d57:ea8b with SMTP id
 e5c5f4694b2df-1c5ee96bd85mr291907555d.16.1730398282240; Thu, 31 Oct 2024
 11:11:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021042218.746659-1-yuzhao@google.com> <20241021042218.746659-5-yuzhao@google.com>
 <868qug3yig.wl-maz@kernel.org> <CAOUHufabSWTZ+cBjXEDTRh61GeALL5b6uh0M76=2ninZP3KAzQ@mail.gmail.com>
 <8634ke3dn4.wl-maz@kernel.org>
In-Reply-To: <8634ke3dn4.wl-maz@kernel.org>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 31 Oct 2024 12:10:45 -0600
Message-ID: <CAOUHufZVDsfBVHUV6NjR82uWo602sT8X3sJ8t1Q_Qk2KJzi0mw@mail.gmail.com>
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

On Tue, Oct 29, 2024 at 1:36=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrote=
:
>
> On Mon, 28 Oct 2024 22:11:52 +0000,
> Yu Zhao <yuzhao@google.com> wrote:
> >
> > On Tue, Oct 22, 2024 at 10:15=E2=80=AFAM Marc Zyngier <maz@kernel.org> =
wrote:
> > >
> > > On Mon, 21 Oct 2024 05:22:16 +0100,
> > > Yu Zhao <yuzhao@google.com> wrote:
> > > >
> > > > Broadcast pseudo-NMI IPIs to pause remote CPUs for a short period o=
f
> > > > time, and then reliably resume them when the local CPU exits critic=
al
> > > > sections that preclude the execution of remote CPUs.
> > > >
> > > > A typical example of such critical sections is BBM on kernel PTEs.
> > > > HugeTLB Vmemmap Optimization (HVO) on arm64 was disabled by
> > > > commit 060a2c92d1b6 ("arm64: mm: hugetlb: Disable
> > > > HUGETLB_PAGE_OPTIMIZE_VMEMMAP") due to the folllowing reason:
> > > >
> > > >   This is deemed UNPREDICTABLE by the Arm architecture without a
> > > >   break-before-make sequence (make the PTE invalid, TLBI, write the
> > > >   new valid PTE). However, such sequence is not possible since the
> > > >   vmemmap may be concurrently accessed by the kernel.
> > > >
> > > > Supporting BBM on kernel PTEs is one of the approaches that can mak=
e
> > > > HVO theoretically safe on arm64.
> > >
> > > Is the safety only theoretical? I would have expected that we'd use a=
n
> > > approach that is absolutely rock-solid.
> >
> > We've been trying to construct a repro against the original HVO
> > (missing BBM), but so far no success. Hopefully a repro does exist,
> > and then we'd be able to demonstrate the effectiveness of this series,
> > which is only theoretical at the moment.
>
> That wasn't my question.
>
> Just because your HW doesn't show you a failure mode doesn't mean the
> issue doesn't exist. Or that someone will eventually make use of the
> relaxed aspects of the architecture and turn the behaviour you are
> relying on into the perfect memory corruption  You absolutely cannot
> rely on an implementation-defined behaviour for this stuff.

I agree.

> Hence my question: is your current approach actually safe?

AFAIK, yes.

> In a
> non-theoretical manner?

We are confident enough to try it in our production, but it doesn't
mean it's bug free. It would take more eyeballs and soak time before
it can prove itself.

> > > > Note that it is still possible for the paused CPUs to perform
> > > > speculative translations. Such translations would cause spurious
> > > > kernel PFs, which should be properly handled by
> > > > is_spurious_el1_translation_fault().
> > >
> > > Speculative translation faults are never reported, that'd be a CPU
> > > bug.
> >
> > Right, I meant to say "speculative accesses that cause translations".
> >
> > > *Spurious* translation faults can be reported if the CPU doesn't
> > > implement FEAT_ETS2, for example, and that has to do with the orderin=
g
> > > of memory access wrt page-table walking for the purpose of translatio=
ns.
> >
> > Just want to make sure I fully understand: after the local CPU sends
> > TLBI (followed by DSB & ISB), FEAT_ETS2 would act like DSB & ISB on
> > remote CPUs when they perform the invalidation, and therefore
> > speculative accesses are ordered as well on remote CPUs.
>
> ETS2 has nothing to do with TLBI. It has to do with non-cacheable
> (translation, access and address size) faults, and whether an older
> update to a translation is visible to a younger memory access without
> extra synchronisation.

Is it correct to say that *without* ETS2, we also wouldn't see
spurious faults on the local CPU from the following BBM sequence?
  clear_pte(); dsb(); isb(); tlbi(); dsb(); isb(); set_valid_pte();
dsb(); isb(); ...

> It definitely has nothing to do with remote
> CPUs (and the idea of a remote ISB, while cute, doesn't exist).
>
> > Also I'm assuming IPIs on remote CPUs don't act like a full barrier,
> > and whatever they interrupt still can be speculatively executed even
> > though the IPI hander itself doesn't access the vmemmap area
> > undergoing BBM. Is this correct?
>
> Full barrier *for what*? An interrupt is a CSE, which has the effects
> described in the ARM ARM, but that's about it.

Sorry for the confusion. I hope the following could explain what's in my mi=
nd:

local cpu          remote cpu

send ipi
                   cse (=3D dsb(); isb() ?)
                   enters ipi handler
                   sets cpu_paused
sees cpu_paused
clear_pte()
dsb();
tlbi();
dsb(); isb()
set_valid_pte()
dsb();
sets cpu_resumed
                  sees cpu_resumed
                  No isb()
                  exits ipi handler

My current understanding is:
Because exception exit doesn't have the CSE and there are no isb()s
within the IPI handler running on the remote CPU, it's possible for
the remote CPU to speculative execute the next instruction before it
sees the valid PTE and trigger a spurious fault.

> > > > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > > > ---
> > > >  arch/arm64/include/asm/smp.h |  3 ++
> > > >  arch/arm64/kernel/smp.c      | 92 ++++++++++++++++++++++++++++++++=
+---
> > > >  2 files changed, 88 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/=
smp.h
> > > > index 2510eec026f7..cffb0cfed961 100644
> > > > --- a/arch/arm64/include/asm/smp.h
> > > > +++ b/arch/arm64/include/asm/smp.h
> > > > @@ -133,6 +133,9 @@ bool cpus_are_stuck_in_kernel(void);
> > > >  extern void crash_smp_send_stop(void);
> > > >  extern bool smp_crash_stop_failed(void);
> > > >
> > > > +void pause_remote_cpus(void);
> > > > +void resume_remote_cpus(void);
> > > > +
> > > >  #endif /* ifndef __ASSEMBLY__ */
> > > >
> > > >  #endif /* ifndef __ASM_SMP_H */
> > > > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> > > > index 3b3f6b56e733..68829c6de1b1 100644
> > > > --- a/arch/arm64/kernel/smp.c
> > > > +++ b/arch/arm64/kernel/smp.c
> > > > @@ -85,7 +85,12 @@ static int ipi_irq_base __ro_after_init;
> > > >  static int nr_ipi __ro_after_init =3D NR_IPI;
> > > >  static struct irq_desc *ipi_desc[MAX_IPI] __ro_after_init;
> > > >
> > > > -static bool crash_stop;
> > > > +enum {
> > > > +     SEND_STOP =3D BIT(0),
> > > > +     CRASH_STOP =3D BIT(1),
> > > > +};
> > > > +
> > > > +static unsigned long stop_in_progress;
> > > >
> > > >  static void ipi_setup(int cpu);
> > > >
> > > > @@ -917,6 +922,79 @@ static void __noreturn ipi_cpu_crash_stop(unsi=
gned int cpu, struct pt_regs *regs
> > > >  #endif
> > > >  }
> > > >
> > > > +static DEFINE_SPINLOCK(cpu_pause_lock);
> > >
> > > PREEMPT_RT will turn this into a sleeping lock. Is it safe to sleep a=
s
> > > you are dealing with kernel mappings?
> >
> > Right, it should be a raw spinlock -- the caller disabled preemption,
> > which as you said is required when dealing with the kernel mappings.
> >
> > > > +static cpumask_t paused_cpus;
> > > > +static cpumask_t resumed_cpus;
> > > > +
> > > > +static void pause_local_cpu(void)
> > > > +{
> > > > +     int cpu =3D smp_processor_id();
> > > > +
> > > > +     cpumask_clear_cpu(cpu, &resumed_cpus);
> > > > +     /*
> > > > +      * Paired with pause_remote_cpus() to confirm that this CPU n=
ot only
> > > > +      * will be paused but also can be reliably resumed.
> > > > +      */
> > > > +     smp_wmb();
> > > > +     cpumask_set_cpu(cpu, &paused_cpus);
> > > > +     /* paused_cpus must be set before waiting on resumed_cpus. */
> > > > +     barrier();
> > >
> > > I'm not sure what this is trying to enforce. Yes, the compiler won't
> > > reorder the set and the test.
> >
> > Sorry I don't follow: does cpumask_set_cpu(), i.e., set_bit(), already
> > contain a compiler barrier?
> >
> > My understanding is that the compiler is free to reorder the set and
> > test on those two independent variables, and make it like this:
> >
> >   while (!cpumask_test_cpu(cpu, &resumed_cpus))
> >       cpu_relax();
> >   cpumask_set_cpu(cpu, &paused_cpus);
> >
> > So the CPU sent the IPI would keep waiting on paused_cpus being set,
> > and this CPU would keep waiting on resumed_cpus being set, which would
> > end up with a deadlock.
> >
> > > But your comment seems to indicate that
> > > also need to make sure the CPU preserves that ordering
> > > and short of a
> > > DMB, the test below could be reordered.
> >
> > If this CPU reorders the set and test like above, it wouldn't be a
> > problem because the set would eventually appear on the other CPU that
> > sent the IPI.
>
> I don't get it. You are requiring that the compiler doesn't reorder
> things, but you're happy that the CPU reorders the same things. Surely
> this leads to the same outcome...

I was thinking that the compiler might be able to reorder even if it
can't prove the loop actually terminates. But I now think that
shouldn't happen. So yes, I agree with what you said earlier that "the
compiler won't reorder the set and the test".

> > > > +     while (!cpumask_test_cpu(cpu, &resumed_cpus))
> > > > +             cpu_relax();
> > > > +     /* A typical example for sleep and wake-up functions. */
> > >
> > > I'm not sure this is "typical",...
> >
> > Sorry, this full barrier isn't needed. Apparently I didn't properly
> > fix this from the previous attempt to use wfe()/sev() to make this
> > function the sleeper for resume_remote_cpus() to wake up.
> >
> > > > +     smp_mb();
> > > > +     cpumask_clear_cpu(cpu, &paused_cpus);
> > > > +}
> > > > +
> > > > +void pause_remote_cpus(void)
> > > > +{
> > > > +     cpumask_t cpus_to_pause;
> > > > +
> > > > +     lockdep_assert_cpus_held();
> > > > +     lockdep_assert_preemption_disabled();
> > > > +
> > > > +     cpumask_copy(&cpus_to_pause, cpu_online_mask);
> > > > +     cpumask_clear_cpu(smp_processor_id(), &cpus_to_pause);
> > >
> > > This bitmap is manipulated outside of your cpu_pause_lock. What
> > > guarantees you can't have two CPUs stepping on each other here?
> >
> > Do you mean cpus_to_pause? If so, that's a local bitmap.
>
> Ah yes, sorry.
>
> >
> > > > +
> > > > +     spin_lock(&cpu_pause_lock);
> > > > +
> > > > +     WARN_ON_ONCE(!cpumask_empty(&paused_cpus));
> > > > +
> > > > +     smp_cross_call(&cpus_to_pause, IPI_CPU_STOP_NMI);
> > > > +
> > > > +     while (!cpumask_equal(&cpus_to_pause, &paused_cpus))
> > > > +             cpu_relax();
> > >
> > > This can be a lot of things to compare, specially that you are
> > > explicitly mentioning large systems. Why can't this be implemented as
> > > a counter instead?
> >
> > Agreed - that'd be sufficient and simpler.
> >
> > > Overall, this looks like stop_machine() in disguise. Why can't this
> > > use the existing infrastructure?
> >
> > This came up during the previous discussion [1]. There are
> > similarities. The main concern with reusing stop_machine() (or part of
> > its current implementation) is that it may not meet the performance
> > requirements. Refactoring might be possible, however, it seems to me
> > (after checking the code again) that such a refactoring unlikely ends
> > up cleaner or simpler codebase, especially after I got rid of CPU
> > masks, as you suggested.
>
> I would have expected to see an implementation handling faults during
> the break window. IPIs are slow, virtualised extremely badly, and
> pNMIs are rarely enabled, due to the long history of issues with it.
> At this stage, I'm not sure what you have here is any better than
> stop_machine(). On the other hand, faults should be the rarest thing,

Let me measure stop_machine() and see how that works for our
production. Meanwhile, if you don't mind that we leave the IPI
approach along with the kernel PF approach on the table?

Thanks.

