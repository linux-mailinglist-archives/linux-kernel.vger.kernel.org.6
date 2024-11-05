Return-Path: <linux-kernel+bounces-396331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D199BCBC1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4DD1F245D2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C3E1D362B;
	Tue,  5 Nov 2024 11:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oyHzSTvW"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16601D278B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 11:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730805923; cv=none; b=RDk+YZHZn6BllZHzQrVJp8zKAtERMoU9jXstP1bg2j69CjImwpnHFAQ5uGS0C4JQ4lyLnuGH2OWMUsOg2W+k6eX3HijuFdpsGfJZPL28rGggEG4b5wh43viDTsZaO1F9XoVckkQgvZQxk+m4/dKXAjqBUbnF/Nv1lYX7d9eMTUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730805923; c=relaxed/simple;
	bh=hWDy9osdQqCeMpsrYOwOniEyenJGEZiDF3vErB45Iik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMLWYvOfdmPO1Mfc8VGUWuaxkt1p0QEOTq+7hLDSZyaixLHHclqa1ELrj/u9n9kanonQrYKJ1bZkJxiRPKrXwmnZisTBtxb41SiNBcblNSdJDyR4wrZ+/U6/+19BCy0JTWdzDSc/ONJM6ksKtrAnsBKWDBq30LI7wtiQam3r2Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oyHzSTvW; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9aa8895facso933463966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 03:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730805920; x=1731410720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEBT2n6DbjlakaN1uzarNpqMC0UR3n3RXvPqLyaSvaE=;
        b=oyHzSTvWBbEI9fNHguys11LIwGKePrw+vyPAWxx9VeY185UK0plHPut2sFSlf4iy3V
         qUfabgPhhHpho3G7Rjb4WaASnAsfPkpF5QoES/25AHouF5UBBh8DvjnjdbD2EQ+sbLOA
         uqF0Um6yPPuRE/BseOMTFsgLf5ocIUMbPuKU/bR/bmhPf7o7mVbpyv/7Cd+g9tEQ5wmu
         KAmkP21sA9es9AAarBERCwHIhygix9WQLp31xGfiF4r91QUmck0Woshm99E5uu8ESbP3
         KhYM2jcA1essjJRy2j3M3dxCDgu3owsFPX7D9E/wTv4M7fB9TichS8MVx14hVGMyrrC8
         gTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730805920; x=1731410720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tEBT2n6DbjlakaN1uzarNpqMC0UR3n3RXvPqLyaSvaE=;
        b=cex4LGUHHwE217JYPEVqebCDqkMMChwx5Srd3lO0SFR5VqL0jWR36a5yJb0uL6qpRX
         G821aQDE4gjMsfaBX0eyOB6I96peEHyqeep+SkhAkesQV6owlw1+qMtWYcew9xxcjGFU
         pC36/dXJK1f3ZMoOC8palhVygIxieAvcKx9zN2RetdIR8PKn0Ta1uluKdWlrJ9mgaBvv
         qz6qEQ8STtZkv1sZtmke6aYeJOIkp+NhbHv7cPzVcOCG7phrUjZvqH/RMIloioLVnKJr
         3nwWitJ+VV0q9lxZ01qJV5C+Wva729DoTShyFSoJIJPbdZEXpIGEwRjDvxYeghe+HhNL
         3WQg==
X-Forwarded-Encrypted: i=1; AJvYcCXNccSstEhhzxw3TTLNVS8uVuGo8/yIVNCROaUPNQ/eTYIb8SEhMKFGSdEAXf54F6VZsNaWKdhGjR8ZtXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4IM16c9ddCRxZWbr5T8ApSpdvrxXgwSIjwJ80PG10ywIo2WiT
	mRRz5M79lZfwdIqp9Ln34lEDH3kebI/wJdU19xTZF9X7rGdOSbna8oGButrtX3WOCCBLg3lCTSe
	FNx2oRpfOx7DuHY6qPaVapma0YL04ocHQBOo/
X-Google-Smtp-Source: AGHT+IHwQMuVDcrBhbWEyBNztwq/o2rKOCi61HFrY7fbUOoy7f5WZQiZifnABPZt6XxEL/s4zTrxjeGjXMoYvwNTkf8=
X-Received: by 2002:a17:906:c109:b0:a9a:1094:55de with SMTP id
 a640c23a62f3a-a9de5d6fademr3304920166b.13.1730805919933; Tue, 05 Nov 2024
 03:25:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031142553.3963058-1-peternewman@google.com>
 <20241031142553.3963058-2-peternewman@google.com> <b3a52af9-e298-7baa-19b3-8931d03731d1@intel.com>
In-Reply-To: <b3a52af9-e298-7baa-19b3-8931d03731d1@intel.com>
From: Peter Newman <peternewman@google.com>
Date: Tue, 5 Nov 2024 12:25:09 +0100
Message-ID: <CALPaoCgc13hS64mSWvn6zYQWwVKzcyF8xueWsaP62ZZJiv+nog@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/resctrl: Don't workqueue local event counter reads
To: Fenghua Yu <fenghua.yu@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>, Babu Moger <babu.moger@amd.com>, 
	James Morse <james.morse@arm.com>, Martin Kletzander <nert.pinx@gmail.com>, 
	Shaopeng Tan <tan.shaopeng@fujitsu.com>, linux-kernel@vger.kernel.org, eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fenghua,

On Mon, Nov 4, 2024 at 11:36=E2=80=AFPM Fenghua Yu <fenghua.yu@intel.com> w=
rote:
>
> Hi, Peter,
>
> On 10/31/24 07:25, Peter Newman wrote:

> > diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kerne=
l/cpu/resctrl/ctrlmondata.c
> > index 200d89a640270..daaff1cfd3f24 100644
> > --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> > +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> > @@ -541,6 +541,31 @@ void mon_event_read(struct rmid_read *rr, struct r=
dt_resource *r,
> >               return;
> >       }
> >
> > +     /*
> > +      * If a performance-conscious caller has gone to the trouble of b=
inding
> > +      * their thread to the monitoring domain of the event counter, en=
sure
> > +      * that the counters are read directly. smp_call_on_cpu()
> > +      * unconditionally uses a work queue to read the counter, substan=
tially
> > +      * increasing the cost of the read.
> > +      *
> > +      * Preemption must be disabled to prevent a migration out of the =
domain
> > +      * after the CPU is checked, which would result in reading the wr=
ong
> > +      * counters. Note that this makes the (slow) remote path a little=
 slower
> > +      * by requiring preemption to be reenabled when redirecting the r=
equest
> > +      * to another domain was in fact necessary.
> > +      *
> > +      * In the case where all eligible target CPUs are nohz_full and
> > +      * smp_call_function_any() is used, keep preemption disabled to a=
void
> > +      * the cost of reenabling it twice in the same read.
> > +      */
> > +     cpu =3D get_cpu();
> > +     if (cpumask_test_cpu(cpu, cpumask)) {
> > +             mon_event_count(rr);
> > +             resctrl_arch_mon_ctx_free(r, evtid, rr->arch_mon_ctx);
> > +             put_cpu();
> > +             return;
> > +     }
>
> This fast path code is a duplicate part of smp_call_funcion_any().
>
> In nohz_full() case, the fast path doesn't gain much and even hurts
> remote domain performance:
> 1. On local domain, it may gain a little bit because it has a few lines
> less than directly calling smp_call_function_any(). But the gain is
> minor due to a lines less code, not due to heavy weight queued work.
>
> 2. On remote domain, it degrades performance because get_cpu() and
> put_cpu() are both called twice: one in the fast path code and one in
> smp_call_function_any(). As you mentioned earlier, put_cpu() impacts
> performance. I think get_cpu() has same impact too.

get_cpu() and put_cpu() nest, so only the put_cpu() that reduces the
preempt count to 0 will call into the scheduler. See the source
comment I had added below.

But... note that below smp_call_on_cpu() is now called with preemption
disabled. (Looks like I only benchmarked and never ran a debug
build...) I will have to change the patch to make sure put_cpu() is
called before smp_call_on_cpu().


>
> The fast path only gains in none nohz_full() case.
>
> So maybe it's better to move the fast path code into the non nohz_full()
> case? With this change, you may have the following benefits:
>
> 1. No performance impact on nohz_full() case (either local or remote
> domain).
> 2. Improve performance on non nohz_full() case as you intended in this
> patch.
> 3. The fast path focuses on fixing the right performance bottleneck.

The consequence of reusing the current-cpu-in-mask check in
smp_call_function_any() is that if the check fails, it could cause
resctrl_arch_rmid_read() to fail by invoking it in an IPI handler when
it would have succeeded if invoked on a kernel worker, undoing James's
original work.

-Peter


>
> > +
> >       cpu =3D cpumask_any_housekeeping(cpumask, RESCTRL_PICK_ANY_CPU);
> >
> >       /*
> > @@ -554,6 +579,9 @@ void mon_event_read(struct rmid_read *rr, struct rd=
t_resource *r,
> >       else
> >               smp_call_on_cpu(cpu, smp_mon_event_count, rr, false);
> >
> > +     /* If smp_call_function_any() was used, preemption is reenabled h=
ere. */
> > +     put_cpu();
> > +
> >       resctrl_arch_mon_ctx_free(r, evtid, rr->arch_mon_ctx);
> >   }
> >
>
> Thanks.
>
> -Fenghua

