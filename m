Return-Path: <linux-kernel+bounces-299698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 324B195D8DD
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 00:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7368BB21963
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 22:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508D11C86EE;
	Fri, 23 Aug 2024 22:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PRkEr+Bi"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15FE195
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 22:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724450420; cv=none; b=FgAiE9hewuAI5Ns4HkUuw3yTSDbaowZz+JxnRlB/3wsej7H0c6B6PNc9R2p+sN2HnRY6hKwvE8WLcWwhW+W3119ghuOtSHJPsmFn+/o/c7U7MHPFlNTRerioys8UYxPsAeYeyJYXhBHOZ+KSzadOcOQK/cgAq+IZWY2pL/X9wEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724450420; c=relaxed/simple;
	bh=JuVBh2sHH23by58EOava3Uf5ZMD54p7U0MVqpHAd5AU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oH2BFQxjt8PF6mYAFFYsoKllisbiMB5yTTCpa2xqVBNW5v0V5JA3aPHpp7Mkej767bcj9mUlJEf/andL2+3geQV/m1XwEkGssFsAY+Fwc4hwVyUehb9roZU4s/qbYqT5GVM4TQbaBaFlgj+WEw8Uwu5gSfkAmvfEBqK4nbMZOaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PRkEr+Bi; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4518d9fa2f4so98561cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724450418; x=1725055218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2m8zDpecc/vc8X2Gs6ygNzNynx2gbafiG25RGfeeVZo=;
        b=PRkEr+BiVY5p54ZbW1lwHIHb7AZ/jw3q+I3wOQx3GYls5kaBmtu6O8PWcn3fEvfvSd
         O7pk1XFpSzAHKYvEkzEaqlKmzKoGxcj7CgU03YDauzGzHygIYVABOkUuEqmtnLLnyZN6
         nMDkgIt1JMkMYLv1IV/r9QG5kWp+yjXBmP2GpyUa5+tmhVcLDNNfYJwAOC1ALf+g/13T
         iNBIxcLfs5t4PUm3c5sGytB2suEg2M2nDtJNk565/6HIjdmfnzwbMDSVICRZtgyPw5jm
         46ZGHUKKe0b/FP/qi4WGkDmwvmLhhDXHPH6bnOL48GTGcWYJ1vqmah4o1+cHVHBSjMf7
         rDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724450418; x=1725055218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2m8zDpecc/vc8X2Gs6ygNzNynx2gbafiG25RGfeeVZo=;
        b=fXmXa1q2hZAy+O/nPJPyIBX/hPTfnriFq5/MJEFA1rwgdORaOIXvSa38J0o3yEUAoR
         1KKOnkd7mNehOl4jAkkem/C9IeVgamjr493xT6XP8iXkfSde3i1a2MdY5RG9ko9e7bH2
         BV8Jy9nMZdY2gqgAMoCTKw3/IAGSWj5Sey9Xqvh1TdzcqMrzoPKd/B2IjVrttFyrQ5vv
         X7nIfJ++/KiWB0d+gNtr6cunApPFAZblo+DJGcksOpGeNCb2mfPU4j2rkMcfSPVl3k+Z
         t/wLwstS0+g+IH6gCfvBSi+shhqtBWUe3B7KYgGBC17eGtRA1blmFW4pVGb0VFtzIUSr
         IcDA==
X-Forwarded-Encrypted: i=1; AJvYcCXZXmHb0W/eN+6ptj9dAJlW7nIPRiHafAxV6OTnTYv0PKczCshKoH/DufjivzGPh6RV6diWBvVStes+EPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCIAvX0nNRpeKYd7AqNCVGwAfVV8Az/xxDG7y78uf286hPjE/S
	usRnT19ht3J5Z9PM8FsylJVbofb8/14WoF9REcH8oOOR11RuiTgxkfgMQJWkLPHFQpI4wkzQq9u
	fr8mwQaFeho3GokAtobYQGhaCXHvE/eZsN0Vw
X-Google-Smtp-Source: AGHT+IGIbChkeAjfyim6bm0lFjUP/EExSCYQSQ3ZPQHuCZLMFttQo6patUwallSIwnFe5w96OuhlJvHmeTgNTpn0gSU=
X-Received: by 2002:a05:622a:53ce:b0:447:e04d:51b1 with SMTP id
 d75a77b69052e-45643a720cdmr272571cf.11.1724450417487; Fri, 23 Aug 2024
 15:00:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823185323.2563194-1-jmattson@google.com> <20240823185323.2563194-5-jmattson@google.com>
 <26e72673-350c-a02d-7b77-ebfd42612ae6@amd.com> <Zsj2anWub8v9kwBA@google.com>
In-Reply-To: <Zsj2anWub8v9kwBA@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 23 Aug 2024 15:00:03 -0700
Message-ID: <CALMp9eTcKk-zKTJzD+wkA_5RE=7rs+qcvhF6tgOBoYfw5GetyQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] KVM: x86: AMD's IBPB is not equivalent to Intel's IBPB
To: Sean Christopherson <seanjc@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Sandipan Das <sandipan.das@amd.com>, 
	Kai Huang <kai.huang@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Venkatesh Srinivas <venkateshs@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 1:51=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Fri, Aug 23, 2024, Tom Lendacky wrote:
> > On 8/23/24 13:53, Jim Mattson wrote:
> > > From Intel's documention [1], "CPUID.(EAX=3D07H,ECX=3D0):EDX[26]
> > > enumerates support for indirect branch restricted speculation (IBRS)
> > > and the indirect branch predictor barrier (IBPB)." Further, from [2],
> > > "Software that executed before the IBPB command cannot control the
> > > predicted targets of indirect branches (4) executed after the command
> > > on the same logical processor," where footnote 4 reads, "Note that
> > > indirect branches include near call indirect, near jump indirect and
> > > near return instructions. Because it includes near returns, it follow=
s
> > > that **RSB entries created before an IBPB command cannot control the
> > > predicted targets of returns executed after the command on the same
> > > logical processor.**" [emphasis mine]
> > >
> > > On the other hand, AMD's IBPB "may not prevent return branch
> > > predictions from being specified by pre-IBPB branch targets" [3].
> > >
> > > However, some AMD processors have an "enhanced IBPB" [terminology
> > > mine] which does clear the return address predictor. This feature is
> > > enumerated by CPUID.80000008:EDX.IBPB_RET[bit 30] [4].
> > >
> > > Adjust the cross-vendor features enumerated by KVM_GET_SUPPORTED_CPUI=
D
> > > accordingly.
> > >
> > > [1] https://www.intel.com/content/www/us/en/developer/articles/techni=
cal/software-security-guidance/technical-documentation/cpuid-enumeration-an=
d-architectural-msrs.html
> > > [2] https://www.intel.com/content/www/us/en/developer/articles/techni=
cal/software-security-guidance/technical-documentation/speculative-executio=
n-side-channel-mitigations.html#Footnotes
> > > [3] https://www.amd.com/en/resources/product-security/bulletin/amd-sb=
-1040.html
> > > [4] https://www.amd.com/content/dam/amd/en/documents/processor-tech-d=
ocs/programmer-references/24594.pdf
> > >
> > > Fixes: 0c54914d0c52 ("KVM: x86: use Intel speculation bugs and featur=
es as derived in generic x86 code")
> > > Suggested-by: Venkatesh Srinivas <venkateshs@chromium.org>
> > > Signed-off-by: Jim Mattson <jmattson@google.com>
> > > ---
> > >  arch/x86/kvm/cpuid.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> > > index ec7b2ca3b4d3..c8d7d928ffc7 100644
> > > --- a/arch/x86/kvm/cpuid.c
> > > +++ b/arch/x86/kvm/cpuid.c
> > > @@ -690,7 +690,9 @@ void kvm_set_cpu_caps(void)
> > >     kvm_cpu_cap_set(X86_FEATURE_TSC_ADJUST);
> > >     kvm_cpu_cap_set(X86_FEATURE_ARCH_CAPABILITIES);
> > >
> > > -   if (boot_cpu_has(X86_FEATURE_IBPB) && boot_cpu_has(X86_FEATURE_IB=
RS))
> > > +   if (boot_cpu_has(X86_FEATURE_AMD_IBPB_RET) &&
> > > +       boot_cpu_has(X86_FEATURE_AMD_IBPB) &&
> > > +       boot_cpu_has(X86_FEATURE_AMD_IBRS))
> > >             kvm_cpu_cap_set(X86_FEATURE_SPEC_CTRL);
> > >     if (boot_cpu_has(X86_FEATURE_STIBP))
> > >             kvm_cpu_cap_set(X86_FEATURE_INTEL_STIBP);
> > > @@ -759,6 +761,8 @@ void kvm_set_cpu_caps(void)
> > >      * arch/x86/kernel/cpu/bugs.c is kind enough to
> > >      * record that in cpufeatures so use them.
> > >      */
> > > +   if (boot_cpu_has(X86_FEATURE_SPEC_CTRL))
> > > +           kvm_cpu_cap_set(X86_FEATURE_AMD_IBPB_RET);
> >
> > If SPEC_CTRL is set, then IBPB is set, so you can't have AMD_IBPB_RET
> > without AMD_IBPB, but it just looks odd seeing them set with separate
> > checks with no relationship dependency for AMD_IBPB_RET on AMD_IBPB.
> > That's just me, though, not worth a v4 unless others feel the same.
>
> You thinking something like this (at the end, after the dust settles)?
>
>         if (WARN_ON_ONCE(kvm_cpu_cap_has(X86_FEATURE_AMD_IBPB_RET) &&
>                          !kvm_cpu_cap_has(X86_FEATURE_AMD_IBPB)))
>                 kvm_cpu_cap_clear(X86_FEATURE_AMD_IBPB_RET);
> >

Ugh. No.

I think it would be better to replace the subsequent vendor-neutral
tests with something like:

    if (boot_cpu_has(X86_FEATURE_SPEC_CTRL)) {
        kvm_cpu_cap_set(X86_FEATURE_AMD_IBPB);
        kvm_cpu_cap_set(X86_FEATURE_AMD_IBPB_RET);
        kvm_cpu_cap_set(X86_FEATURE_AMD_IBRS);
    }

Again, my real preference is to leave the cross-vendor enumeration to
userspace, but I guess that ship has sailed.

> > Thanks,
> > Tom
> >
> > >     if (boot_cpu_has(X86_FEATURE_IBPB))
> > >             kvm_cpu_cap_set(X86_FEATURE_AMD_IBPB);
> > >     if (boot_cpu_has(X86_FEATURE_IBRS))

