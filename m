Return-Path: <linux-kernel+bounces-234392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E2191C60E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BF47285266
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D4257CA2;
	Fri, 28 Jun 2024 18:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tz9qzgO1"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB0D4D8A4
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 18:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719600501; cv=none; b=RvcpfAy7qm7awgSlCu2gh8Fb/QeAtEx5leAx81CHMUB/k/HzUtBZ7FcA/sU73eMMv0BFlSRpua+H9Pd7qd94Fta82N+ao5yqxdcBjZS9CforhnIr78I70a9zF43QGpzqVT9kK4LCti1oztqHMfwxRItVarZECvzWUweU21397XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719600501; c=relaxed/simple;
	bh=ohOu82hKGb5O5vKCUnXPReCL/omt2P2cGsq6dzVpQgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IPpuJUOLv2kUI887xif1gu7P7/U/Gc64gPILkxZxNLQP1JeQ+xF9DRrlnJGLVRLMOME61xry4n9fQIMuDwQY5lfpqfjTPvZSyqwiIybFnLsRzI4OrFBKci3Yt3O/zSwNaTBHKv4pzfVIUxE1KCuTA7cWBMdAn5tl39bkTT8QyFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tz9qzgO1; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso2035a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 11:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719600498; x=1720205298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abJZGCGg9p3AOHP9CmO0KWDwdL1MOoAGeXSRn8P2SRI=;
        b=tz9qzgO1A6KeptWzG/jL4LrAbMgTzkp8d2uaXLFQj2ZCRs/tBxR13Kp0VbLZS+bd7P
         MDeBJtSffSCAqFuR2h4snAaGXcr6SnA9sbhKGdOMcjnuq2ypsoPG7mmsNEGeG/vef4MP
         hTL8SPqOrLsN/V1UkCRa9ZKW3TLPuCzCDiLooPunK3vFtMEoKuyTYVXrzdtkbUh3+6J6
         SHlNUeQLGiAsEausPgkxVmk44T4e68GcLfgtwoyUYwQLW4ieGEfa58xvNlTQ0daQ4aqg
         34swiID1QV+CUWRXVYL3zfZ9iI5ZWucLOevtmUZtuQlazV7cn5YU9tIjY7X9l19vwZL3
         y5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719600498; x=1720205298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abJZGCGg9p3AOHP9CmO0KWDwdL1MOoAGeXSRn8P2SRI=;
        b=ZbKIER7ePHZDGmg1QcJaP2pwZsOxlTjKlkPfPmZL3iVPQnM7KdbLlx/JVVRVw0SGkw
         IsIA5VjHBen90H0AKVVZ/JGsCtPljJKM3dyPHPZ+6oUq7bREMbHCIZybut4+n+sNMXjt
         8OOqNZ7MXZ8P+x9jvxiwZ+5Brc9FZVB24VzVxskfSLnzjyAcAu1pw/pepmTy5rlL+t6R
         EKstS1o2IDkx7EX9LmPBP+q6/D0ajK73n6GGWLmSBmReyA0blC4CyEzJRsQOBKoR5ZSr
         Qh8GdT1YHe/FZMlIkWHzIHlLsZSR/qOgHk/24wb3eW+RRP72BBBPbs9AFyb8KH6HYOUO
         PZwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFmKnfu51ZfQSXcOk8kVTG5BQHmDTBDrygydDRRgdJGh1a3jQgYfga/GtWif+0D9VdUtu0Gd6iEklZ/Y3wiQzuQNo8MGuxFLCyCHZ6
X-Gm-Message-State: AOJu0YzHPWP4pvE+WVbhypd9J57mYsX6T/CxXCtKEKEfE9gy+oZ8PoRU
	CMljH9EQ2WpYFc04HyfWgk++JR0Ww223NWZZ+x7zWM/cAJ9fITqGV+Uc4lZPXWg31Wjt9FWJtrX
	VhPq/z4vaSVmwwTo+8+Ie7pdHcAOmee3xfzv5
X-Google-Smtp-Source: AGHT+IGvihwbUhusHWWPdSiPPgnic5+W6UFEhcbEi6LwWX3TzgMS2Jus/PkdwrB0oVy3pMw/VwbpYLaEqgYy9fp4c1M=
X-Received: by 2002:a50:f68d:0:b0:57c:bb0d:5e48 with SMTP id
 4fb4d7f45d1cf-5872f673e4bmr22935a12.2.1719600498008; Fri, 28 Jun 2024
 11:48:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626073719.5246-1-amit@kernel.org> <Zn7gK9KZKxBwgVc_@google.com>
In-Reply-To: <Zn7gK9KZKxBwgVc_@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 28 Jun 2024 11:48:01 -0700
Message-ID: <CALMp9eSfZsGTngMSaWbFrdvMoWHyVK_SWf9W1Ps4BFdwAzae_g@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: SVM: let alternatives handle the cases when RSB
 filling is required
To: Sean Christopherson <seanjc@google.com>
Cc: Amit Shah <amit@kernel.org>, pbonzini@redhat.com, x86@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, amit.shah@amd.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, kim.phillips@amd.com, 
	david.kaplan@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 9:09=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Wed, Jun 26, 2024, Amit Shah wrote:
> > ---
> >  arch/x86/kvm/svm/vmenter.S | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/x86/kvm/svm/vmenter.S b/arch/x86/kvm/svm/vmenter.S
> > index a0c8eb37d3e1..2ed80aea3bb1 100644
> > --- a/arch/x86/kvm/svm/vmenter.S
> > +++ b/arch/x86/kvm/svm/vmenter.S
> > @@ -209,10 +209,8 @@ SYM_FUNC_START(__svm_vcpu_run)
> >  7:   vmload %_ASM_AX
> >  8:
> >
> > -#ifdef CONFIG_MITIGATION_RETPOLINE
> >       /* IMPORTANT: Stuff the RSB immediately after VM-Exit, before RET=
! */
> > -     FILL_RETURN_BUFFER %_ASM_AX, RSB_CLEAR_LOOPS, X86_FEATURE_RETPOLI=
NE
> > -#endif
> > +     FILL_RETURN_BUFFER %_ASM_AX, RSB_CLEAR_LOOPS, X86_FEATURE_RSB_VME=
XIT
>
> Out of an abundance of paranoia, shouldn't this be?
>
>         FILL_RETURN_BUFFER %_ASM_CX, RSB_CLEAR_LOOPS, X86_FEATURE_RSB_VME=
XIT,\
>                            X86_FEATURE_RSB_VMEXIT_LITE
>
> Hmm, but it looks like that would incorrectly trigger the "lite" flavor f=
or
> families 0xf - 0x12.  I assume those old CPUs aren't affected by whatever=
 on earth
> EIBRS_PBRSB is.
>
>         /* AMD Family 0xf - 0x12 */
>         VULNWL_AMD(0x0f,        NO_MELTDOWN | NO_SSB | NO_L1TF | NO_MDS |=
 NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO | NO_BHI),
>         VULNWL_AMD(0x10,        NO_MELTDOWN | NO_SSB | NO_L1TF | NO_MDS |=
 NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO | NO_BHI),
>         VULNWL_AMD(0x11,        NO_MELTDOWN | NO_SSB | NO_L1TF | NO_MDS |=
 NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO | NO_BHI),
>         VULNWL_AMD(0x12,        NO_MELTDOWN | NO_SSB | NO_L1TF | NO_MDS |=
 NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO | NO_BHI),
>
>         /* FAMILY_ANY must be last, otherwise 0x0f - 0x12 matches won't w=
ork */
>         VULNWL_AMD(X86_FAMILY_ANY,      NO_MELTDOWN | NO_L1TF | NO_MDS | =
NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO | NO_EIBRS_PBRSB | NO_BHI),
>         VULNWL_HYGON(X86_FAMILY_ANY,    NO_MELTDOWN | NO_L1TF | NO_MDS | =
NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO | NO_EIBRS_PBRSB | NO_BHI),

Your assumption is correct. As for why the cpu_vuln_whitelist[]
doesn't say so explicitly, you need to read between the lines...

>        /*
>         * AMD's AutoIBRS is equivalent to Intel's eIBRS - use the Intel f=
eature
>         * flag and protect from vendor-specific bugs via the whitelist.
>         *
>         * Don't use AutoIBRS when SNP is enabled because it degrades host
>         * userspace indirect branch performance.
>         */
>        if ((x86_arch_cap_msr & ARCH_CAP_IBRS_ALL) ||
>            (cpu_has(c, X86_FEATURE_AUTOIBRS) &&
>             !cpu_feature_enabled(X86_FEATURE_SEV_SNP))) {
>                setup_force_cpu_cap(X86_FEATURE_IBRS_ENHANCED);
>                if (!cpu_matches(cpu_vuln_whitelist, NO_EIBRS_PBRSB) &&
>                    !(x86_arch_cap_msr & ARCH_CAP_PBRSB_NO))
>                        setup_force_cpu_bug(X86_BUG_EIBRS_PBRSB);
>        }

Families 0FH through 12H don't have EIBRS or AutoIBRS, so there's no
cpu_vuln_whitelist[] lookup. Hence, no need to set the NO_EIBRS_PBRSB
bit, even if it is accurate.

> >
> >       /* Clobbers RAX, RCX, RDX.  */
> >       RESTORE_HOST_SPEC_CTRL
> > @@ -348,10 +346,8 @@ SYM_FUNC_START(__svm_sev_es_vcpu_run)
> >
> >  2:   cli
> >
> > -#ifdef CONFIG_MITIGATION_RETPOLINE
> >       /* IMPORTANT: Stuff the RSB immediately after VM-Exit, before RET=
! */
> > -     FILL_RETURN_BUFFER %rax, RSB_CLEAR_LOOPS, X86_FEATURE_RETPOLINE
> > -#endif
> > +     FILL_RETURN_BUFFER %rax, RSB_CLEAR_LOOPS, X86_FEATURE_RSB_VMEXIT
> >
> >       /* Clobbers RAX, RCX, RDX, consumes RDI (@svm) and RSI (@spec_ctr=
l_intercepted). */
> >       RESTORE_HOST_SPEC_CTRL
> > --
> > 2.45.2
> >
>

