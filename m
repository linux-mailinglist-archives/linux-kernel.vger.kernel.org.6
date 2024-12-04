Return-Path: <linux-kernel+bounces-430541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFD69E3288
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 05:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFBE5167F4F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 04:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4B8170A23;
	Wed,  4 Dec 2024 04:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ixCdqJLs"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328CC38385
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 04:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733284822; cv=none; b=DgE81rhdBBNltQbCMSW82SqbPH7WTdyjg5r7R1wd7sxwv/NLD5Tf6E0EvbCGOfbCiID9vzSJZaAPXQeaFZJtMNP93QlQph8xHQFWP4JFYfcM+clsRDQ3zSMxeFPsl64fP7zB5pzY+UfAHERN9lX2hIzZAQyHDwXVaOA/XVSfylQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733284822; c=relaxed/simple;
	bh=plu8dRbwA//TIE7V3u7EkRjHASWu+GTYdXd54J9egbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KwZK0h4icr0K6qp3p4q2wToYZ+CZbpqgPaNeeM+4BH/DJrIXuoNoQPkkBwqOrVpGD0vxrXMs9cy/RACav4wRJzzQQHCnXY3M0OZOUeTCszlkpNxokcCLi+WgJLgtZEQWsQZpVln73u7vLg2PB4P7jHrBMJlxIeKMigb2PH1v5d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ixCdqJLs; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a77ab3ebfaso57425ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 20:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733284820; x=1733889620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CngGMvpmpyr10C47QW7O8tll8PdmhQ22t96lvuVqUS8=;
        b=ixCdqJLszwdzQwoUWVJOSX5EVQClSBiYYHB5aqLwFrhOjXghzpGkn3RrUYmtKj3yWD
         9D60WEl5Iklp1HM0rQBGvr+H8APj+cPBXLMy8E6rxtSOga29kBH1Xqz5RqSCl9+0mj+m
         /EokJT31NrYeNom6zu2mvTU29BPZ6N5aLWd8gztCzwGQCadcypFxcqYrP2SaKR+WBgKB
         GutZT37xzMHhVMUbKSbphwQKs1rpo4cuDSfBgQAguw7U/qCHVGYzWdPeHKPvTDWBOPzO
         3+n7BqGGAkWa2XZTOgSnfoowU0BLICkQx/AMHNZVCRpLavx/4K36puraljq1CEVBLRRZ
         ib+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733284820; x=1733889620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CngGMvpmpyr10C47QW7O8tll8PdmhQ22t96lvuVqUS8=;
        b=L5cyvS2XU2vqHtXZE2JH+BZOiCLRoz/U/OyAyO/GoVs0RCPmt70CC6rHWrO+o6SjH/
         zVHSJbSimplqedpGZUCg/TbxBsicHG23zDxYnDEAcMQbxSwnDnH4x6kt4PJ4GUmewaYu
         QFl+lk0ulsRSYxTIe3A4HIDhsGy6KueD9JAwXJRsXFLPhbM5UnJlucPcKbnvHmvYdTRJ
         0QOLFRkNtzlXRIeAJ9sH/Eu7Ico8sFpjFXf+T3difCo2QTzR4sqJmXizsypslPyl7dXQ
         qUBuUYZVC9Uo1H+ijTHN2TBdemLtRDwusnnCd9pgyeG9oi+WGB5xh9TTI+9e/I7ZFNgH
         pKqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUo2o1UBLTDOXSpR95IutdhUGwfpn78oaZi630XVBTVUW1S5rYf/VjSJINIRWA4aUyDQyI74+mJ0wHG2Cw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Mo6X+yPrN28A1911VqOJTRnz3JVeztU1mXqjF5w56OGj1XBn
	ppiZPjJLM738hqOyNATaTnsXmXGslI9ZicVy2CEcGLHP0PlG+dz9qokQqpngCdVvyNvZZHJbEcL
	fxdPpzo8dFoJ6fggYfRvoa8u5LVkzw6vp8mhB
X-Gm-Gg: ASbGncuwdLmGA6+Qpq215IknZGCxxDZega9KuBhNBdjKyeUWPv2q4doENfyESnQCu73
	rwbcLPAhDkWz84jLLXj4mEIFmP+05CQ==
X-Google-Smtp-Source: AGHT+IFSAC1wz2QxEeAFRYo7HSv2GzEQcAHLbAsspH6/KMJCC8WlUpKuMmIDvejZ+31FQWIAyUvMlyBEiyGwx5JATfo=
X-Received: by 2002:a05:6e02:3f8d:b0:3a7:cd21:493f with SMTP id
 e9e14a558f8ab-3a8001a949dmr1896425ab.26.1733284820117; Tue, 03 Dec 2024
 20:00:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121185315.3416855-1-mizhang@google.com> <Z0-R-_GPWu-iVAYM@google.com>
 <CALMp9eTCe1-ZA47kcktTQ4WZ=GUbg8x3HpBd0Rf9Yx_pDFkkNg@mail.gmail.com> <Z0-3bc1reu1slCtL@google.com>
In-Reply-To: <Z0-3bc1reu1slCtL@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 3 Dec 2024 20:00:09 -0800
Message-ID: <CALMp9eT9ne4HmwqMED0nGT1aEem7VjTHbehQhb1MPn-Z-Lg9=Q@mail.gmail.com>
Subject: Re: [RFC PATCH 00/22] KVM: x86: Virtualize IA32_APERF and IA32_MPERF MSRs
To: Sean Christopherson <seanjc@google.com>
Cc: Mingwei Zhang <mizhang@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Perry Yuan <perry.yuan@amd.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 5:59=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Tue, Dec 03, 2024, Jim Mattson wrote:
> > On Tue, Dec 3, 2024 at 3:19=E2=80=AFPM Sean Christopherson <seanjc@goog=
le.com> wrote:
> > >
> > > On Thu, Nov 21, 2024, Mingwei Zhang wrote:
> > > > Linux guests read IA32_APERF and IA32_MPERF on every scheduler tick
> > > > (250 Hz by default) to measure their effective CPU frequency. To av=
oid
> > > > the overhead of intercepting these frequent MSR reads, allow the gu=
est
> > > > to read them directly by loading guest values into the hardware MSR=
s.
> > > >
> > > > These MSRs are continuously running counters whose values must be
> > > > carefully tracked during all vCPU state transitions:
> > > > - Guest IA32_APERF advances only during guest execution
> > >
> > > That's not what this series does though.  Guest APERF advances while =
the vCPU is
> > > loaded by KVM_RUN, which is *very* different than letting APERF run f=
reely only
> > > while the vCPU is actively executing in the guest.
> > >
> > > E.g. a vCPU that is memory oversubscribed via zswap will account a si=
gnificant
> > > amount of CPU time in APERF when faulting in swapped memory, whereas =
traditional
> > > file-backed swap will not due to the task being scheduled out while w=
aiting on I/O.
> >
> > Are you saying that APERF should stop completely outside of VMX
> > non-root operation / guest mode?
> > While that is possible, the overhead would be significantly
> > higher...probably high enough to make it impractical.
>
> No, I'm simply pointing out that the cover letter is misleading/inaccurat=
e.
>
> > > In general, the "why" of this series is missing.  What are the use ca=
ses you are
> > > targeting?  What are the exact semantics you want to define?  *Why* d=
id are you
> > > proposed those exact semantics?
> >
> > I get the impression that the questions above are largely rhetorical, a=
nd
>
> Nope, not rhetorical, I genuinely want to know.  I can't tell if ya'll th=
ought
> about the side effects of things like swap and emulated I/O, and if you d=
id, what
> made you come to the conclusion that the "best" boundary is on sched_out(=
) and
> return to userspace.
>
> > that you would not be happy with the answers anyway, but if you really =
are
> > inviting a version 2, I will gladly expound upon the why.
>
> No need for a new version at this time, just give me the details.
>
> > > E.g. emulated I/O that is handled in KVM will be accounted to APERF, =
but I/O that
> > > requires userspace exits will not.  It's not necessarily wrong for he=
avy userspace
> > > I/O to cause observed frequency to drop, but it's not obviously corre=
ct either.
> > >
> > > The use cases matter a lot for APERF/MPERF, because trying to reason =
about what's
> > > desirable for an oversubscribed setup requires a lot more work than d=
efining
> > > semantics for setups where all vCPUs are hard pinned 1:1 and memory i=
s more or
> > > less just partitioned.  Not to mention the complexity for trying to s=
upport all
> > > potential use cases is likely quite a bit higher.
> > >
> > > And if the use case is specifically for slice-of-hardware, hard pinne=
d/partitioned
> > > VMs, does it matter if the host's view of APERF/MPERF is not accurate=
ly captured
> > > at all times?  Outside of maybe a few CPUs running bookkeeping tasks,=
 the only
> > > workloads running on CPUs should be vCPUs.  It's not clear to me that=
 observing
> > > the guest utilization is outright wrong in that case.
> >
> > My understanding is that Google Cloud customers have been asking for th=
is
> > feature for all manner of VM families for years, and most of those VM
> > families are not slice-of-hardware, since we just launched our first su=
ch
> > offering a few months ago.
>
> But do you actually want to expose APERF/MPERF to those VMs?  With my ups=
tream
> hat on, what someone's customers are asking for isn't relevant.  What's r=
elevant
> is what that someone wants to deliver/enable.
>
> > > One idea for supporting APERF/MPERF in KVM would be to add a kernel p=
aram to
> > > disable/hide APERF/MPERF from the host, and then let KVM virtualize/p=
assthrough
> > > APERF/MPERF if and only if the feature is supported in hardware, but =
hidden from
> > > the kernel.  I.e. let the system admin gift APERF/MPERF to KVM.
> >
> > Part of our goal has been to enable guest APERF/MPERF without impacting=
 the
> > use of host APERF/MPERF, since one of the first things our support team=
s look
> > at in response to a performance complaint is the effective frequencies =
of the
> > CPUs as reported on the host.
>
> But is looking at the host's view even useful if (a) the only thing runni=
ng on
> those CPUs is a single vCPU, and (b) host userspace only sees the effecti=
ve
> frequencies when _host_ code is running?  Getting the effective frequency=
 for
> when the userspace VMM is processing emulated I/O probably isn't going to=
 be all
> that helpful.

(a) is your constraint, not mine, and (b) certainly sounds pointless,
but that isn't the behavior of this patch set, so I'm not sure why
you're even going there.

With this patch set, host APERF/MPERF still reports all cycles
accumulated on the logical processor, regardless of whether in the
host or the guest. There will be a small loss every time the MSRs are
written, but that loss is minimized by writing the MSRs as
infrequently as possible.

I get ahead of myself, but I just couldn't let this
mischaracterization stand uncorrected while I get the rest of my
response together.

> And gifting APERF/MPERF to VMs doesn't have to mean the host can't read t=
he MSRs,
> e.g. via turbostat.  It just means the kernel won't use APERF/MPERF for s=
cheduling
> decisions or any other behaviors that rely on an accurate host view.
>
> > I can explain all of this in excruciating detail, but I'm not really
> > motivated by your initial response, which honestly seems a bit hostile.
>
> Probably because this series made me a bit grumpy :-)  As presented, this=
 feels
> way, way too much like KVM's existing PMU "virtualization".  Mostly works=
 if you
> stare at it just so, but devoid of details on why X was done instead of Y=
, and
> seemingly ignores multiple edge cases.
>
> I'm not saying you and Mingwei haven't thought about edge cases and desig=
n
> tradeoffs, but nothing in the cover letter, changelogs, comments (none), =
or
> testcases (also none) communicates those thoughts to others.
>
> > At least you looked at the code, which is a far warmer reception than I
> > usually get.

