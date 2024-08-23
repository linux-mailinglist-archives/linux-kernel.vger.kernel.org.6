Return-Path: <linux-kernel+bounces-299424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F130795D463
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 19:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C3FBB21CF1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A683192B79;
	Fri, 23 Aug 2024 17:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CcciBic4"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E14192597
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 17:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724434424; cv=none; b=CbFbFBWO/3lExNcNWMN9jReQyfOJsLnowQxFnAwQ27Fq1l3UTDidu/tPvFU2Q/eI6O1DwMy5RiWHSly2J0aiP+o0U0rO1RdOpKRgNhBiO8UTzsA6AFkevIVBLfgT+arPPBf8yto56C+aS+4lNUpyESmogPTT20YNJ4D99hJkreA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724434424; c=relaxed/simple;
	bh=qcQ+kss4ewa/66kGgpNaE9eqqDVNwNbhn7AywTnrHtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DFAhWfOe5rIaYk8o840pm1YsNUjLOL/WWq/4kplcfTUOKIsQ0WmNa2VVO/uGw4MqQGXKqkt5wYDKyZGHgkx4X6beuCxjDQGBZuiQ7UQJBdDyj7LJylJW+Ooqob640Fl0XQQT0Myk85n2RceFuwa2iUa9i7pLmN14rM2MINIyLNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CcciBic4; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-44fee2bfd28so15801cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 10:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724434421; x=1725039221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrDhJJ/5EwfF2mTCDXTG+gotDkVPsxK/KucvLDLQTiE=;
        b=CcciBic4zvRVLh33+8o2yMSFUGLiiTUr58ji+H5HnsPcZ20CHgx7ZKpT+e7Gq84xEv
         NjLNGEyTwUG883V/NOlqxEaekGDKwfvMLMODCTLx6adZxtnFX68sqM31CyTPmAaUAM9o
         2nZf+uzfEASqWzP6lhUEXaUM6l2ZzvCFVaX/ONJ0UCYEv7790WvKaC5d2lxCab0tGt0h
         Y5Ecy8CsaBpSLYbaZlsMDovlN7aucp5SLMP9t1Rjy+RuCUnn9oeTDOvuqHNJkKVcpk8Y
         5MHOV0Y56xHJsW3ZKD0Nyj3HaBq74I7XVWPLvBYG2kyxdyBmPrru+q158ovpfcibHogx
         5Zjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724434421; x=1725039221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yrDhJJ/5EwfF2mTCDXTG+gotDkVPsxK/KucvLDLQTiE=;
        b=pGD7pncIRC6q0Hukjz+wp+LP6cmMkM+M3dheOmu9D8V3yLnshnRHAHdikGV/O5E3IB
         YN4Nx0k39tRkhkU5t8W0x9jzWGMkUQIZDmcr1d0UIJVUec4rcwrPTi9Qlpm1ExGdmjVQ
         PSbL4nHA91T7fnOGXhsH26A7WyyyeGoJD0bSX+Ahoqd2wu65Kqdu/ZHFc4xxbQqMmqs7
         XKF4WLs3T0uBQJLhL+r4zNh9O5ylIp2O3IDGsvWVWUZHAqCft+eWtblee9VqYfYurR2e
         D0sfIJFcHBS9wCYs75FYhUSqT+Fx85WNVYWtX6mTRKRWJeC4Y0wBq5EVVUkZNIpk0tZl
         X1qg==
X-Forwarded-Encrypted: i=1; AJvYcCXrGjxpy5UaU4ViDMPCCDfslw/ag4TSIaCCLUHraUnTyT2mo4CwGIOkLixLwMGhp7xEaYSrExasYeXktXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlv/+l2xxA9bgCt6WUx0csapibrkkdhtgPCBQgSeFdbP0DFquT
	fsvX4wuxS9Q9/Gf4THz8c+bVspkiRVXQHl7Ds7S7NTKyMuVWvBqW/RtzxORBTP5xNrSZBxfifMa
	TwVIHd+2oHxszmw//VhA394N89YdVcg6p1tFS
X-Google-Smtp-Source: AGHT+IGvAzMr5/ZaOUktkFhC0qDUCbo7Vm+q/xR1nu+IqMWWE+GBkW4jlqZo/fn8sWKxDdXpRsMmFHVkI6I4KCCgk7I=
X-Received: by 2002:a05:622a:1443:b0:447:d7ff:961d with SMTP id
 d75a77b69052e-45509e77b0emr3262991cf.9.1724434420482; Fri, 23 Aug 2024
 10:33:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816182533.2478415-1-jmattson@google.com> <20240816182533.2478415-2-jmattson@google.com>
 <93effd6c-124e-07fd-57ca-ed271fb50665@amd.com>
In-Reply-To: <93effd6c-124e-07fd-57ca-ed271fb50665@amd.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 23 Aug 2024 10:33:29 -0700
Message-ID: <CALMp9eSn_u8add6pT5L8LT1vVqj=2y1zcHvgqxiiW+x-aCjNCA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] KVM: x86: AMD's IBPB is not equivalent to Intel's IBPB
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Daniel Sneddon <daniel.sneddon@linux.intel.com>, Kai Huang <kai.huang@intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Venkatesh Srinivas <venkateshs@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 9:06=E2=80=AFAM Tom Lendacky <thomas.lendacky@amd.c=
om> wrote:
>
> On 8/16/24 13:25, Jim Mattson wrote:
> > From Intel's documention [1], "CPUID.(EAX=3D07H,ECX=3D0):EDX[26]
> > enumerates support for indirect branch restricted speculation (IBRS)
> > and the indirect branch predictor barrier (IBPB)." Further, from [2],
> > "Software that executed before the IBPB command cannot control the
> > predicted targets of indirect branches (4) executed after the command
> > on the same logical processor," where footnote 4 reads, "Note that
> > indirect branches include near call indirect, near jump indirect and
> > near return instructions. Because it includes near returns, it follows
> > that **RSB entries created before an IBPB command cannot control the
> > predicted targets of returns executed after the command on the same
> > logical processor.**" [emphasis mine]
> >
> > On the other hand, AMD's IBPB "may not prevent return branch
> > predictions from being specified by pre-IBPB branch targets" [3].
> >
> > However, some AMD processors have an "enhanced IBPB" [terminology
> > mine] which does clear the return address predictor. This feature is
> > enumerated by CPUID.80000008:EDX.IBPB_RET[bit 30] [4].
> >
> > Adjust the cross-vendor features enumerated by KVM_GET_SUPPORTED_CPUID
> > accordingly.
> >
> > [1] https://www.intel.com/content/www/us/en/developer/articles/technica=
l/software-security-guidance/technical-documentation/cpuid-enumeration-and-=
architectural-msrs.html
> > [2] https://www.intel.com/content/www/us/en/developer/articles/technica=
l/software-security-guidance/technical-documentation/speculative-execution-=
side-channel-mitigations.html#Footnotes
> > [3] https://www.amd.com/en/resources/product-security/bulletin/amd-sb-1=
040.html
> > [4] https://www.amd.com/content/dam/amd/en/documents/processor-tech-doc=
s/programmer-references/24594.pdf
> >
> > Fixes: 0c54914d0c52 ("KVM: x86: use Intel speculation bugs and features=
 as derived in generic x86 code")
> > Suggested-by: Venkatesh Srinivas <venkateshs@chromium.org>
> > Signed-off-by: Jim Mattson <jmattson@google.com>
> > ---
> >  v2: Use IBPB_RET to identify semantic equality (Venkatesh)
> >
> >  arch/x86/kvm/cpuid.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> > index 2617be544480..044bdc9e938b 100644
> > --- a/arch/x86/kvm/cpuid.c
> > +++ b/arch/x86/kvm/cpuid.c
> > @@ -690,7 +690,9 @@ void kvm_set_cpu_caps(void)
> >       kvm_cpu_cap_set(X86_FEATURE_TSC_ADJUST);
> >       kvm_cpu_cap_set(X86_FEATURE_ARCH_CAPABILITIES);
> >
> > -     if (boot_cpu_has(X86_FEATURE_IBPB) && boot_cpu_has(X86_FEATURE_IB=
RS))
> > +     if (boot_cpu_has(X86_FEATURE_AMD_IBPB_RET) &&
> > +         boot_cpu_has(X86_FEATURE_AMD_IBPB) &&
> > +         boot_cpu_has(X86_FEATURE_AMD_IBRS))
> >               kvm_cpu_cap_set(X86_FEATURE_SPEC_CTRL);
> >       if (boot_cpu_has(X86_FEATURE_STIBP))
> >               kvm_cpu_cap_set(X86_FEATURE_INTEL_STIBP);
> > @@ -759,8 +761,10 @@ void kvm_set_cpu_caps(void)
> >        * arch/x86/kernel/cpu/bugs.c is kind enough to
> >        * record that in cpufeatures so use them.
> >        */
> > -     if (boot_cpu_has(X86_FEATURE_IBPB))
> > +     if (boot_cpu_has(X86_FEATURE_IBPB)) {
> >               kvm_cpu_cap_set(X86_FEATURE_AMD_IBPB);
> > +             kvm_cpu_cap_set(X86_FEATURE_AMD_IBPB_RET);
>
> Should IBPB_RET be conditionally set? I would think that you would only
> want to set IBPB_RET if either IBPB_RET or SPEC_CTRL is set on the hyperv=
isor.
>
>                 if (boot_cpu_has(X86_FEATURE_AMD_IBPB_RET) ||
>                     boot_cpu_has(X86_FEATURE_SPEC_CTRL)
>                         kvm_cpu_cap_set(X86_FEATURE_AMD_IBPB_RET);
>
> Right?

Right. This clause is intended to set cross-vendor capabilities, so it
should be:

    if (boot_cpu_has(X86_FEATURE_SPEC_CTRL))
        kvm_cpu_cap_set(X86_FEATURE_AMD_IBPB_RET);

Passing through AMD_IBPB_RET from the hardware should be done by
adding the bit to the mask for CPUID_8000_0008_EBX.

I'll send out a v3.

Thanks!

> Thanks,
> Tom
>
> > +     }
> >       if (boot_cpu_has(X86_FEATURE_IBRS))
> >               kvm_cpu_cap_set(X86_FEATURE_AMD_IBRS);
> >       if (boot_cpu_has(X86_FEATURE_STIBP))

