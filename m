Return-Path: <linux-kernel+bounces-298269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE8595C4F1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 07:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18AD6B22363
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 05:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A2E57CA6;
	Fri, 23 Aug 2024 05:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PBMHB1sR"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD0E4D8AF
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 05:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724391795; cv=none; b=FIV66drfrdWGO7bhPtv8lXYaTW7tPLfzINfq59ja5CR/QcArzAl6FYLPsw63EzSAsX++5u43I72ojmFI55gTWl+1bk6sOOC2rE76oeq0/yB4Dvolsmb4r+dwZWH/DYHH/QRtVHa3m1pZnFzObiSfzTSj9TM5QDs98KhV7wORQg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724391795; c=relaxed/simple;
	bh=ykhjlYyxcyN7pzrz6lrlZAJQo+HVYW3Ljq324L0AhKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UeL1H57GpKJVmvrMyPc6po73y1gohC0RXHg/a6smzwAvpOH3IbjylFFhiB++X0i2MmA01rYZodB8+CdKP/LuPL3rs/T7tT8PLAvY8H1tJP4LxOElFPe7MEubsoSnbOtJGiUf+imQ1VsXygP+KOUCecE/bYssMbir4VySHSQm6iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PBMHB1sR; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-450059a25b9so13421601cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 22:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724391791; x=1724996591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9W2beeAjD9qLCpyKv4/ad4dgFRN7iQbmZy3bMH70jX4=;
        b=PBMHB1sRJaZGVKDddx1qft/s+aQK9acVsjTc+i6r+zrAXF+B0Ld4QKvvtOLc0IKcS8
         d2g6Om2FWeA9J+JfCy5PIllKVXwI4f+ckGQ3rqD/4AuTKXF5yyo0NS0WXurL6r0dsMMv
         clFmNllpxEFwPFpowfxP9JaB9fyyznWVZQ+tjTpxV94JcPQHUj1pdlpj4F+gB8PKUAZP
         rbn0CXDQqFPqVSkVm/grnmHGV+N1MKwi6ma1B97BATG2yGP0qCumb/sMfS6k3Muf9M5+
         QetNojpgsACraMVuEJ4cpQOJ5UQB4K1KV37YVXW+ZX69wf4H86r8fkYeVx4RY9rPIzR1
         Un1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724391791; x=1724996591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9W2beeAjD9qLCpyKv4/ad4dgFRN7iQbmZy3bMH70jX4=;
        b=G1Ac8Fc2MjbCe/kzFXek6PZ6gznLMXj0H271Ipg/Y9lWVRIt8skfw3c8ivdGfXmOKb
         J2a09MwlT3Zt93g30GrxXnfKB50lvAX4t0reCFx8rriu49OpE3uvBSCA8yYkqQmK6zyG
         ylYJE8zPkJ1bPv6izEBU+CoF54YnjX5bfs5DTDubn64ogOAJdQ+UchbnOpukAMG8lfzJ
         XOb6eCh+yCXxsfRnPxyKskh14UIrb1Zlb0o4EyBc6oasUfV+br8Bo0gQW6HsCC+ZVGCj
         yBdV7r50pN9Y72/mCsPY/OOWFGLhqEAuQvudNW8AJDFaNPhL/1MweeVYrvdwH7hQ6rqC
         UTlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLdJigiY32Iqo+1R8sQz8X/hMbfkhskqytbKdkETK9RIuqw0tuMEcD78oFeTgpx0XLGi7ThT2OyLZ1Lt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDkJysYC7rXJTk6391d+lQE1lDtT/nq+WCvtB/yKkMeRVLoXa1
	b3sGy8aZXcUDOM3hqwTv4S/156YdFTESeeaGl8HBKIdZhigo92JZ65DZ3UYPqLOFWBIW9Vfv7Qn
	l/WolvekwvD7CO7eNmRDY1nqs/ZSysnVuXWZk
X-Google-Smtp-Source: AGHT+IGhKE7lfw67kM6GRdbIh3E1OqOH39TY+JqF3bKeDOj4H7SSyH7gfj/AR2FVe4LcTS8l+CoS2QbVfICwxkmiJVU=
X-Received: by 2002:ac8:5f07:0:b0:453:749e:9693 with SMTP id
 d75a77b69052e-454fae49cdfmr90576581cf.11.1724391791253; Thu, 22 Aug 2024
 22:43:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820043543.837914-1-suleiman@google.com> <20240820043543.837914-3-suleiman@google.com>
 <ZsWJsPkrhDReU4ez@intel.com> <CABCjUKCBQq9AMCVd0BqOSViPn=Q3wiVByOvJNhNpHvqx=Ef-4g@mail.gmail.com>
 <ZsgdPljClmKrGIff@intel.com>
In-Reply-To: <ZsgdPljClmKrGIff@intel.com>
From: Suleiman Souhlal <suleiman@google.com>
Date: Fri, 23 Aug 2024 14:43:00 +0900
Message-ID: <CABCjUKAV0ycQH9YFXwLAsJDO22=STxFqONAqO=DY3F6bi+3xAA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] KVM: x86: Include host suspended time in steal time.
To: Chao Gao <chao.gao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ssouhlal@freebsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 2:25=E2=80=AFPM Chao Gao <chao.gao@intel.com> wrote=
:
>
> On Fri, Aug 23, 2024 at 01:17:31PM +0900, Suleiman Souhlal wrote:
> >On Wed, Aug 21, 2024 at 3:31=E2=80=AFPM Chao Gao <chao.gao@intel.com> wr=
ote:
> >>
> >> On Tue, Aug 20, 2024 at 01:35:42PM +0900, Suleiman Souhlal wrote:
> >> >When the host resumes from a suspend, the guest thinks any task
> >> >that was running during the suspend ran for a long time, even though
> >> >the effective run time was much shorter, which can end up having
> >> >negative effects with scheduling. This can be particularly noticeable
> >> >if the guest task was RT, as it can end up getting throttled for a
> >> >long time.
> >> >
> >> >To mitigate this issue, we include the time that the host was
> >> >suspended in steal time, which lets the guest subtract the duration f=
rom
> >> >the tasks' runtime.
> >> >
> >> >Note that the case of a suspend happening during a VM migration
> >> >might not be accounted.
> >> >
> >> >Signed-off-by: Suleiman Souhlal <suleiman@google.com>
> >> >---
> >> > arch/x86/include/asm/kvm_host.h |  1 +
> >> > arch/x86/kvm/x86.c              | 11 ++++++++++-
> >> > 2 files changed, 11 insertions(+), 1 deletion(-)
> >> >
> >> >diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/k=
vm_host.h
> >> >index 4a68cb3eba78f8..728798decb6d12 100644
> >> >--- a/arch/x86/include/asm/kvm_host.h
> >> >+++ b/arch/x86/include/asm/kvm_host.h
> >> >@@ -898,6 +898,7 @@ struct kvm_vcpu_arch {
> >> >               u8 preempted;
> >> >               u64 msr_val;
> >> >               u64 last_steal;
> >> >+              u64 last_suspend_ns;
> >> >               struct gfn_to_hva_cache cache;
> >> >       } st;
> >> >
> >> >diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> >> >index 70219e4069874a..104f3d318026fa 100644
> >> >--- a/arch/x86/kvm/x86.c
> >> >+++ b/arch/x86/kvm/x86.c
> >> >@@ -3654,7 +3654,7 @@ static void record_steal_time(struct kvm_vcpu *=
vcpu)
> >> >       struct kvm_steal_time __user *st;
> >> >       struct kvm_memslots *slots;
> >> >       gpa_t gpa =3D vcpu->arch.st.msr_val & KVM_STEAL_VALID_BITS;
> >> >-      u64 steal;
> >> >+      u64 steal, suspend_ns;
> >> >       u32 version;
> >> >
> >> >       if (kvm_xen_msr_enabled(vcpu->kvm)) {
> >> >@@ -3735,6 +3735,14 @@ static void record_steal_time(struct kvm_vcpu =
*vcpu)
> >> >       steal +=3D current->sched_info.run_delay -
> >> >               vcpu->arch.st.last_steal;
> >> >       vcpu->arch.st.last_steal =3D current->sched_info.run_delay;
> >> >+      /*
> >> >+       * Include the time that the host was suspended in steal time.
> >> >+       * Note that the case of a suspend happening during a VM migra=
tion
> >> >+       * might not be accounted.
> >> >+       */
> >> >+      suspend_ns =3D kvm_total_suspend_ns();
> >> >+      steal +=3D suspend_ns - vcpu->arch.st.last_suspend_ns;
> >> >+      vcpu->arch.st.last_suspend_ns =3D suspend_ns;
> >>
> >> The document in patch 3 states:
> >>
> >>   Time during which the vcpu is idle, will not be reported as steal ti=
me
> >>
> >> I'm wondering if all host suspend time should be reported as steal tim=
e,
> >> or if the suspend time during a vCPU halt should be excluded.
> >
> >I think the statement about idle time not being reported as steal isn't
> >completely accurate, so I'm not sure if it's worth the extra complexity.
> >
> >>
> >> >       unsafe_put_user(steal, &st->steal, out);
> >> >
> >> >       version +=3D 1;
> >> >@@ -12280,6 +12288,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcp=
u)
> >> >
> >> >       vcpu->arch.arch_capabilities =3D kvm_get_arch_capabilities();
> >> >       vcpu->arch.msr_platform_info =3D MSR_PLATFORM_INFO_CPUID_FAULT=
;
> >> >+      vcpu->arch.st.last_suspend_ns =3D kvm_total_suspend_ns();
> >>
> >> is this necessary? I doubt this because KVM doesn't capture
> >> current->sched_info.run_delay here.
> >
> >Isn't run_delay being captured by the scheduler at all time?
>
> I meant KVM doesn't do:
>
>         vcpu->arch.st.last_steal =3D current->sched_info.run_delay;
>
> at vCPU creation time.

I think for run_delay it's different because run_delay is a time
difference. It's something that gets added to steal, not relative
to the previous steal value.
From what I can tell, it's correct for last_steal to be initialized to 0.

>
> >
> >We need to initialize last_suspend_ns otherwise the first call to
> >record_steal_time() for a VCPU would report a wrong value if
> >the VCPU is started after the host has already had a suspend.
>
> But initializing last_suspend_ns here doesn't guarantee KVM won't report =
a
> "wrong" value because a suspend can happen after vCPU creation and before
> its first VM-enter.

I see what you're saying.
I'm not sure how much this matters in practice.

-- Suleiman

