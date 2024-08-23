Return-Path: <linux-kernel+bounces-299729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1705095D955
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 00:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E3F61C226CF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 22:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05051C8FB7;
	Fri, 23 Aug 2024 22:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HetAaw1O"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7B8192B6D
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 22:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724453345; cv=none; b=fY5rInGDEmYV00Ih0e+EAwbcaiLe7/wBliF1c8RbbPP7LpAFWqN6XCJfnl7cSt4o/zo52Peh6YVp3UBBxcNcFxbBv+KzilaOnQP36cL8BlKVgrn9Ca1nfUfVAly5giPFVLdCitjhT8zyXkZ3RofVXnd8BZxF97OXSGOVkL2bwco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724453345; c=relaxed/simple;
	bh=BxbVTKfcrEVjaGlyBbRgzsmV2oBpw2iEJhOH8QSMsnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PcqYhmL69yV8McYhmNcrm4qoZFqqu8lJpo6fdh8h5xx/jmngatjY5/+3Suw5PbAGZnhL3Iu9WFo9egGpTslwIf42LHJCzFUK5At6M8Z4y81kVNBeebvl2336myb7SPkq04sAX7TF0UkWseG7LEgCenvK5XDHTQI9VHZbpk7NJcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HetAaw1O; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-39d41b61178so33485ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724453343; x=1725058143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mSDEtxYic5lCbq3mrk6af83rFghOTZGlDbAI56siaA=;
        b=HetAaw1OyQ5tSfgVEgoadWaglkNAb0pUr++Hq0mKDi+ObOIukMBjbrWJ08zUmR2NBw
         QocD3VHcFpDKp/zWGtcC8EGkGkKJBPx5HN51RQVzos0tOyYt5nhAON9eqs9UAVEgx2eh
         4drDHs/VHy8S598TwF+pCCRTI779JhX8TNAKdFodmOMdTPf190pY3+ArAJCqK6Ygptqd
         6vN+jdJ0dsZjOwnl++0wMpHqVZM8xmcuKRH5hXxH/b37AUNE3ZheiAKQ2wGCOR1gd/CM
         CxHAf6MD2dTo9DcDn7srEMWDcNuDzgW3CSWf7hPGzLVSdkYuryCuboI3TBscAhc5gXYu
         cKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724453343; x=1725058143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1mSDEtxYic5lCbq3mrk6af83rFghOTZGlDbAI56siaA=;
        b=JIo5vnvWUIWQn70OsvQOTzpHBCMgpjzR4iZr5XFEhF2mcP4XcA/bygCyw8QNYJSnhT
         suxV0KqkTGvGimhZFVZVWAUQVhCPJZcOW7YCyPPS1R8wuhPKI/aht3XxDd9RFU48vJAc
         IhZtaPD9nLK5D79dkJ8fwAUmcH3ERrQILaDhSJIi4fgWKnz6LRJHhIaCU2Tq5/As/BxZ
         6P1qpM6gHlXPF1TPXvtNXlaJAC4k0phkdNmtEfn2z9weED3GrTBIbV+q5A3wPOVmxtGn
         MP4Ry+HaEsut2krHs96gsuFKJk9NSf3qZ4pqcsT9jlThjeN/LEhdRpz6wwgvzlpRzoUQ
         fJ6g==
X-Forwarded-Encrypted: i=1; AJvYcCWB5Evpy4yITQ/PoVjDuKCeDvRDrmihBCiVTrl/xF32yiEpvjnbKECDTe56cc+QWuKL2+5sqsAXgbWSwrw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlbp+gyl2zZUenI6NlumP4xK4+4oJgXBGjNekRZBHY0d3MaY7x
	xcwIvyDa80VA7VLA0/sXm9BHiQWB49Vtc0/TP0nbstJ6ddTJIxM/3xjd4MZyZ4Aw6VczISqhQWQ
	ruDMNZY238CwyoG+A6IsrXH+49Ky8E6RCRCK7
X-Google-Smtp-Source: AGHT+IHNrllfRjSQuMnlcItv9GICaHtqFC7j3OYb2ipkMG75SjFCnWvG3zfxlchngKtQF9VeVnYlujAE/eD4in0ib3Q=
X-Received: by 2002:a05:6e02:1582:b0:377:15c7:1aa0 with SMTP id
 e9e14a558f8ab-39e45110653mr304725ab.25.1724453342561; Fri, 23 Aug 2024
 15:49:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823185323.2563194-1-jmattson@google.com> <20240823185323.2563194-5-jmattson@google.com>
 <26e72673-350c-a02d-7b77-ebfd42612ae6@amd.com> <Zsj2anWub8v9kwBA@google.com> <59449778-ad4e-69c6-d1dc-73dacb538e02@amd.com>
In-Reply-To: <59449778-ad4e-69c6-d1dc-73dacb538e02@amd.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 23 Aug 2024 15:48:51 -0700
Message-ID: <CALMp9eTNX7=siC=DtBOSDLr6Aswzsq0d6UAHQpEdTd2J8xXHuQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] KVM: x86: AMD's IBPB is not equivalent to Intel's IBPB
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Sandipan Das <sandipan.das@amd.com>, 
	Kai Huang <kai.huang@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Venkatesh Srinivas <venkateshs@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 3:12=E2=80=AFPM Tom Lendacky <thomas.lendacky@amd.c=
om> wrote:
>
> On 8/23/24 15:51, Sean Christopherson wrote:
> > On Fri, Aug 23, 2024, Tom Lendacky wrote:
> >> On 8/23/24 13:53, Jim Mattson wrote:
> >>> From Intel's documention [1], "CPUID.(EAX=3D07H,ECX=3D0):EDX[26]
> >>> enumerates support for indirect branch restricted speculation (IBRS)
> >>> and the indirect branch predictor barrier (IBPB)." Further, from [2],
> >>> "Software that executed before the IBPB command cannot control the
> >>> predicted targets of indirect branches (4) executed after the command
> >>> on the same logical processor," where footnote 4 reads, "Note that
> >>> indirect branches include near call indirect, near jump indirect and
> >>> near return instructions. Because it includes near returns, it follow=
s
> >>> that **RSB entries created before an IBPB command cannot control the
> >>> predicted targets of returns executed after the command on the same
> >>> logical processor.**" [emphasis mine]
> >>>
> >>> On the other hand, AMD's IBPB "may not prevent return branch
> >>> predictions from being specified by pre-IBPB branch targets" [3].
> >>>
> >>> However, some AMD processors have an "enhanced IBPB" [terminology
> >>> mine] which does clear the return address predictor. This feature is
> >>> enumerated by CPUID.80000008:EDX.IBPB_RET[bit 30] [4].
> >>>
> >>> Adjust the cross-vendor features enumerated by KVM_GET_SUPPORTED_CPUI=
D
> >>> accordingly.
> >>>
> >>> [1] https://www.intel.com/content/www/us/en/developer/articles/techni=
cal/software-security-guidance/technical-documentation/cpuid-enumeration-an=
d-architectural-msrs.html
> >>> [2] https://www.intel.com/content/www/us/en/developer/articles/techni=
cal/software-security-guidance/technical-documentation/speculative-executio=
n-side-channel-mitigations.html#Footnotes
> >>> [3] https://www.amd.com/en/resources/product-security/bulletin/amd-sb=
-1040.html
> >>> [4] https://www.amd.com/content/dam/amd/en/documents/processor-tech-d=
ocs/programmer-references/24594.pdf
> >>>
> >>> Fixes: 0c54914d0c52 ("KVM: x86: use Intel speculation bugs and featur=
es as derived in generic x86 code")
> >>> Suggested-by: Venkatesh Srinivas <venkateshs@chromium.org>
> >>> Signed-off-by: Jim Mattson <jmattson@google.com>
> >>> ---
> >>>  arch/x86/kvm/cpuid.c | 6 +++++-
> >>>  1 file changed, 5 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> >>> index ec7b2ca3b4d3..c8d7d928ffc7 100644
> >>> --- a/arch/x86/kvm/cpuid.c
> >>> +++ b/arch/x86/kvm/cpuid.c
> >>> @@ -690,7 +690,9 @@ void kvm_set_cpu_caps(void)
> >>>     kvm_cpu_cap_set(X86_FEATURE_TSC_ADJUST);
> >>>     kvm_cpu_cap_set(X86_FEATURE_ARCH_CAPABILITIES);
> >>>
> >>> -   if (boot_cpu_has(X86_FEATURE_IBPB) && boot_cpu_has(X86_FEATURE_IB=
RS))
> >>> +   if (boot_cpu_has(X86_FEATURE_AMD_IBPB_RET) &&
> >>> +       boot_cpu_has(X86_FEATURE_AMD_IBPB) &&
> >>> +       boot_cpu_has(X86_FEATURE_AMD_IBRS))
> >>>             kvm_cpu_cap_set(X86_FEATURE_SPEC_CTRL);
> >>>     if (boot_cpu_has(X86_FEATURE_STIBP))
> >>>             kvm_cpu_cap_set(X86_FEATURE_INTEL_STIBP);
> >>> @@ -759,6 +761,8 @@ void kvm_set_cpu_caps(void)
> >>>      * arch/x86/kernel/cpu/bugs.c is kind enough to
> >>>      * record that in cpufeatures so use them.
> >>>      */
> >>> +   if (boot_cpu_has(X86_FEATURE_SPEC_CTRL))
> >>> +           kvm_cpu_cap_set(X86_FEATURE_AMD_IBPB_RET);
> >>
> >> If SPEC_CTRL is set, then IBPB is set, so you can't have AMD_IBPB_RET
> >> without AMD_IBPB, but it just looks odd seeing them set with separate
> >> checks with no relationship dependency for AMD_IBPB_RET on AMD_IBPB.
> >> That's just me, though, not worth a v4 unless others feel the same.
> >
> > You thinking something like this (at the end, after the dust settles)?
> >
> >       if (WARN_ON_ONCE(kvm_cpu_cap_has(X86_FEATURE_AMD_IBPB_RET) &&
> >                        !kvm_cpu_cap_has(X86_FEATURE_AMD_IBPB)))
> >               kvm_cpu_cap_clear(X86_FEATURE_AMD_IBPB_RET);
>
> I was just thinking more along the lines of:
>
>         if (boot_cpu_has(X86_FEATURE_IBPB)) {
>                 kvm_cpu_cap_set(X86_FEATURE_AMD_IBPB);
>                 if (boot_cpu_has(X86_FEATURE_SPEC_CTRL))
>                         kvm_cpu_cap_set(X86_FEATURE_AMD_IBPB_RET);
>         }

AFAICT, there are just two reasons that X86_FEATURE_IBPB gets set:
1. The CPU reports CPUID.(EAX=3D7,ECX=3D0):EDX[bit 26] (aka X86_FEATURE_SPE=
C_CTRL)
2. The CPU reports CPUID Fn8000_0008_EBX[IBPB] (aka X86_FEATURE_AMD_IBPB)

Clearly, in the second case, the KVM cpu capability for AMD_IBPB will
already be set, since it's specified in the mask for
CPUID_8000_0008_EBX.

If this block of code is just trying to populate CPUID Fn8000_0008_EBX
on Intel processors, I'd rather change all of the predicates to test
for Intel features, rather than vendor-neutral features, so that the
derivation is clear. But maybe this block of code is also trying to
populate CPUID Fn8000_0008_EBX on AMD processors that may have some of
these features, but don't enumerate them via CPUID?

> Thanks,
> Tom
>
> >>
> >
> >> Thanks,
> >> Tom
> >>
> >>>     if (boot_cpu_has(X86_FEATURE_IBPB))
> >>>             kvm_cpu_cap_set(X86_FEATURE_AMD_IBPB);
> >>>     if (boot_cpu_has(X86_FEATURE_IBRS))

