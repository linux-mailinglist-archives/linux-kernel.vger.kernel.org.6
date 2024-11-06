Return-Path: <linux-kernel+bounces-398512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D253B9BF23C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 023501C23553
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEB120127C;
	Wed,  6 Nov 2024 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2r01wSfU"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844522EAE0
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 15:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730908377; cv=none; b=E1LRXyO6JQuC6Y4HsduQMHXUFtioCJnCT1rA5ZvplqX8oei+HVpDTv3HChLuJAPZ/aFOLamUdWTyiS+jWRaSSIl7wtt1C1XlPA7Clh68sB1b4nZ0bpsp4G7wDJV4DpkzJv97T/wdCcqBlvBs0FnFMuQgWvnOm1obT4JZzlg2eWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730908377; c=relaxed/simple;
	bh=77FKdwMXthSAkOFykXBBs0el/6wCErzqQfWS967tiEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NmEfBW9Z+JAng/mqVArVfMDQL0I6xrLuLtEChe9bKjvn/eDb38781UoSs3TZlH2HZiSs/hFefi3riZxfFLAXx0euhWillXxJRSNZIOv3j09Qd5RHJEUrKydiAt7LCc6r13a33S49rhugKehbjR8xmQ+V6qYii8xBV8HXc8+uA4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2r01wSfU; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9a6b4ca29bso881253366b.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 07:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730908374; x=1731513174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVjwj77z7TD7jHedx6XeNVyFBolLQf1b5Pxid0JiQ2A=;
        b=2r01wSfU4LxMOxkwtvGf/oniOprYzjYN025TyNUgO1Gs/NtN+ax46LiNUE2bE/08ap
         iNVFoUqBH9Oe5pQeYpv7MHuc8g3+2X0EQ3Ut3eSYbOGrsAedW2hsRc9fw7T7m14IXsWl
         O2qWNYKcUPghBzEfs7SccRUvZGwnoSdDRkeEkTrWguk6nJurZeyDrri7mu1zvxN/Bfda
         H84K1fYJN/dI6qu5TpCmjxcg4HcbBjZRZIt1dmmPsPI3OHyS2znfoEinqwOsTlj8PEcH
         JynGp1hV3R7Hbsey+sn88l6k2aXfINQmJr1Y28WQfD3T5bptLVCjSgbAECxBQDupPcqE
         QDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730908374; x=1731513174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DVjwj77z7TD7jHedx6XeNVyFBolLQf1b5Pxid0JiQ2A=;
        b=buueabZNOCqMSe8Cr/pVp1EWzqQ/E2L4e9j0clA0EiGC9sSnq4qvUdLTEd1jwaacHL
         ZQAitmJjLUwFTLIDyBk+X18Df4owjaMEnzplu8GqIYt/DORwGJzwmg2nkzcjCVXLojdg
         T17gUQQp9rL9qvHuZWxPS4e1gYKPMaQhOsSaUrmXbHp70+AuAjAP6lW6JNKGfNOvmqix
         m3x4PkAmyQgFMmdpFvJOEWbsUw08dSCpOTZJDOGpAW/TQFizlfcqNIxAAGDoDWVJ9SfM
         q9gfkDn3TrN4Foga2Jx5SSt79szGgjYLuPIfHeY6ZKmbQ5MFXV52FdMsLsc0i/ijqZGP
         Zdww==
X-Forwarded-Encrypted: i=1; AJvYcCXCf0C6SYXHHfbs66LuynmSkmCTALkr48EkCuH3EQdDOCv9b3whnkj5cLORBLlhX/5q77LSg6ufkigDUR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC/zCcdo2heHGtKmdVAgR8WElG9FRxlLe7OHlRNuuqAKWHuRDD
	i5jF4vY4Ne/hEtCHBMr0L4p41errDviYHikwn0MYLboW0JgmbTdSIsRzTCSII/d2/cjrw9lKhiW
	mGHdsjGgYp4Ytb44ayC+CTWAtbibrAowI8xLK
X-Google-Smtp-Source: AGHT+IE0vLSdJdCsW70pWfJiCpT4w8OilAbiTiK5oBce1naa6uq7RmWdPuSK43Wk2PEcE/8xaKD272R8Qxiz3P3CfcQ=
X-Received: by 2002:a17:906:f585:b0:a9a:a5c:e23b with SMTP id
 a640c23a62f3a-a9e50b9e32fmr2305821366b.58.1730908373745; Wed, 06 Nov 2024
 07:52:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031142553.3963058-1-peternewman@google.com>
 <20241031142553.3963058-2-peternewman@google.com> <b3a52af9-e298-7baa-19b3-8931d03731d1@intel.com>
 <CALPaoCgc13hS64mSWvn6zYQWwVKzcyF8xueWsaP62ZZJiv+nog@mail.gmail.com>
In-Reply-To: <CALPaoCgc13hS64mSWvn6zYQWwVKzcyF8xueWsaP62ZZJiv+nog@mail.gmail.com>
From: Peter Newman <peternewman@google.com>
Date: Wed, 6 Nov 2024 16:52:42 +0100
Message-ID: <CALPaoCjwrp+5B3pQ6C43Mv=x9ZtsoQbvjAqXR+Ujtqb_AQVdcw@mail.gmail.com>
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

On Tue, Nov 5, 2024 at 12:25=E2=80=AFPM Peter Newman <peternewman@google.co=
m> wrote:
>
> Hi Fenghua,
>
> On Mon, Nov 4, 2024 at 11:36=E2=80=AFPM Fenghua Yu <fenghua.yu@intel.com>=
 wrote:
> >
> > Hi, Peter,
> >
> > On 10/31/24 07:25, Peter Newman wrote:
>
> > > diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/ker=
nel/cpu/resctrl/ctrlmondata.c
> > > index 200d89a640270..daaff1cfd3f24 100644
> > > --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> > > +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> > > @@ -541,6 +541,31 @@ void mon_event_read(struct rmid_read *rr, struct=
 rdt_resource *r,
> > >               return;
> > >       }
> > >
> > > +     /*
> > > +      * If a performance-conscious caller has gone to the trouble of=
 binding
> > > +      * their thread to the monitoring domain of the event counter, =
ensure
> > > +      * that the counters are read directly. smp_call_on_cpu()
> > > +      * unconditionally uses a work queue to read the counter, subst=
antially
> > > +      * increasing the cost of the read.
> > > +      *
> > > +      * Preemption must be disabled to prevent a migration out of th=
e domain
> > > +      * after the CPU is checked, which would result in reading the =
wrong
> > > +      * counters. Note that this makes the (slow) remote path a litt=
le slower
> > > +      * by requiring preemption to be reenabled when redirecting the=
 request
> > > +      * to another domain was in fact necessary.
> > > +      *
> > > +      * In the case where all eligible target CPUs are nohz_full and
> > > +      * smp_call_function_any() is used, keep preemption disabled to=
 avoid
> > > +      * the cost of reenabling it twice in the same read.
> > > +      */
> > > +     cpu =3D get_cpu();
> > > +     if (cpumask_test_cpu(cpu, cpumask)) {
> > > +             mon_event_count(rr);
> > > +             resctrl_arch_mon_ctx_free(r, evtid, rr->arch_mon_ctx);
> > > +             put_cpu();
> > > +             return;
> > > +     }
> >
> > This fast path code is a duplicate part of smp_call_funcion_any().
> >
> > In nohz_full() case, the fast path doesn't gain much and even hurts
> > remote domain performance:
> > 1. On local domain, it may gain a little bit because it has a few lines
> > less than directly calling smp_call_function_any(). But the gain is
> > minor due to a lines less code, not due to heavy weight queued work.
> >
> > 2. On remote domain, it degrades performance because get_cpu() and
> > put_cpu() are both called twice: one in the fast path code and one in
> > smp_call_function_any(). As you mentioned earlier, put_cpu() impacts
> > performance. I think get_cpu() has same impact too.
>
> get_cpu() and put_cpu() nest, so only the put_cpu() that reduces the
> preempt count to 0 will call into the scheduler. See the source
> comment I had added below.
>
> But... note that below smp_call_on_cpu() is now called with preemption
> disabled. (Looks like I only benchmarked and never ran a debug
> build...) I will have to change the patch to make sure put_cpu() is
> called before smp_call_on_cpu().
>
>
> >
> > The fast path only gains in none nohz_full() case.
> >
> > So maybe it's better to move the fast path code into the non nohz_full(=
)
> > case? With this change, you may have the following benefits:
> >
> > 1. No performance impact on nohz_full() case (either local or remote
> > domain).
> > 2. Improve performance on non nohz_full() case as you intended in this
> > patch.
> > 3. The fast path focuses on fixing the right performance bottleneck.
>
> The consequence of reusing the current-cpu-in-mask check in
> smp_call_function_any() is that if the check fails, it could cause
> resctrl_arch_rmid_read() to fail by invoking it in an IPI handler when
> it would have succeeded if invoked on a kernel worker, undoing James's
> original work.

I noted in my earlier email to Reinette that this is already a problem
in the fast path case I added.

I ended up creating a resctrl_arch_event_read_blocks() hook for asking
the implementation whether a particular event actually blocks so that
the workqueue is only used when it's really necessary:

https://lore.kernel.org/lkml/20241106154306.2721688-2-peternewman@google.co=
m/

With this, I was able to follow your suggestion of using
smp_call_function_any() for the local counter read.

However, it's worth noting that this ended up making remote reads
faster on AMD but slower on Intel for some reason. I assume it's a
flaw in my benchmark where the IPIs were cross-socket on Intel while
they were only cross-chiplet on AMD.

Thanks!
-Peter

