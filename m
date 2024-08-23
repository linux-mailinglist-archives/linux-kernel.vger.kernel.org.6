Return-Path: <linux-kernel+bounces-299644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CF395D80E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 22:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4E8A1F22D0D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 20:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70D01C7B9D;
	Fri, 23 Aug 2024 20:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="npx5LQns"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906C21C6F74
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 20:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724446318; cv=none; b=m6Ti7eed226Vw142/vVySFCL5CQ6CzozQoKLjkfSaj0EdG5jMeW+/5iKSGQB+MSxfbz+PhcDRLtxEGjg55dm5RWCIQH7Q67vsTZPsRju9OdmGSJItPzYsYru7/jR36+9gJ4n9E++D/ul1dyxKMeqauu0jqdXQam+/gTfwx4EKIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724446318; c=relaxed/simple;
	bh=bKd1KFIsTfdo0frRE8bJ8i0KEJ/2iwudwsdn/26fG+g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D7M9aV2WEa8uqY+i7nsuWocfw/Lq+RRvzjOam2EOz4ezt4dMget6lukPIo26u60lXUsCmCn7+hrzNqaQllOT5tRWst3gvSor2ffve09c+soVYNITpDdpe3j05BltZKf+ruz1gn/vD8+0LycupS3blg/h8Q5rwtUYSnIkJKQuMVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=npx5LQns; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7141d43582cso2324038b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 13:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724446316; x=1725051116; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3ctQASBnAfMkHAKJOQaWxeii39ASnQwWqjqj9rHx00g=;
        b=npx5LQnsQJ87FPGqJITy6BO6GdWWEk4d1LjP7N56NN5Q6nRTabGqy+Lz/8ISye0yHa
         q7YHnKgoc3KxZhXQLKl8tPZS2S6g05WfjVRjwbzao2T3ZJMVeyUe1aNuyuGxqO2sldj7
         g85o0vVkSWDmK9f05hN7aaWqioHKQikskW2U+gy4SKar1U7HdpMuEi1w/vNhkqz/nYwb
         98j4WrpdNrF/cWeDOuArCuniYQAwv035OaC5QyplddGh1dP+zhSKhSkSDRqo8J7LDEQR
         EXnQyc5XNkoo/7/Fff3SAjlZ+SuVC/mQY6G78ss50W9jEljOki2eC6aBi9Xzbqn4vIyq
         K5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724446316; x=1725051116;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ctQASBnAfMkHAKJOQaWxeii39ASnQwWqjqj9rHx00g=;
        b=N0xzWQAiYsHqBF7awScuRLVrAlzCMXgrv1lWurRmeN/OcAlhSSKKSzSBbpiMJ8a9T/
         X0EGcm3v3EQlHkdDok4MkmbnGFKZrXKNMOQ5GTX7UmNwIwMwapLRXbILzPMiTMxtebTo
         DNSZrIA5jRqHOJJ+XOBj2r7Djx7mlidwf6gHt9ki7luqNOf79I/5r+6DWcXRyxsLVxKC
         Qkt/ASG4xA8B4MtB3esPdnBV/EFz505GcMPFdP2qmqbnVJEdFev+vegqF2DbICo3dXw8
         q7aaLIZx9j2mGs+2/edJMB+FeyHwzkfBrb17bd0VcaBz2I1xoUUnPjoI5T0CkkFbTXxs
         32ag==
X-Forwarded-Encrypted: i=1; AJvYcCWu4cfjzUOG1N2P0P7TyhZlP6UrKaWXIiyQLL2cv7lJO7Hffla6hyPexI/5OFwTh8qq+c8ndXy0UbkR0t4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXI7tmEjQ116AUhwc9wc/s3kydpJPZn6qV8ciK9WogJv3VD6Xy
	til4XUTxdCGgSFvJ1M5fE2kI3BQuqsgjnYVyVpiD+eT6b+AVi0X/Esd/8K2HDxnOPW/wPlfWlUf
	EAw==
X-Google-Smtp-Source: AGHT+IFbru/8gFjKaY81EkFinVTdW1msPDmscCyfWgoiWQ/qtgYtS0UPrE0L1yvmUuYMHt9kmGMF67CMfdQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:914d:b0:705:ca19:2d08 with SMTP id
 d2e1a72fcca58-71445af579dmr25489b3a.6.1724446315529; Fri, 23 Aug 2024
 13:51:55 -0700 (PDT)
Date: Fri, 23 Aug 2024 13:51:54 -0700
In-Reply-To: <26e72673-350c-a02d-7b77-ebfd42612ae6@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240823185323.2563194-1-jmattson@google.com> <20240823185323.2563194-5-jmattson@google.com>
 <26e72673-350c-a02d-7b77-ebfd42612ae6@amd.com>
Message-ID: <Zsj2anWub8v9kwBA@google.com>
Subject: Re: [PATCH v3 4/4] KVM: x86: AMD's IBPB is not equivalent to Intel's IBPB
From: Sean Christopherson <seanjc@google.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Jim Mattson <jmattson@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Sandipan Das <sandipan.das@amd.com>, 
	Kai Huang <kai.huang@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Venkatesh Srinivas <venkateshs@chromium.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 23, 2024, Tom Lendacky wrote:
> On 8/23/24 13:53, Jim Mattson wrote:
> > From Intel's documention [1], "CPUID.(EAX=07H,ECX=0):EDX[26]
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
> > [1] https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/technical-documentation/cpuid-enumeration-and-architectural-msrs.html
> > [2] https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/technical-documentation/speculative-execution-side-channel-mitigations.html#Footnotes
> > [3] https://www.amd.com/en/resources/product-security/bulletin/amd-sb-1040.html
> > [4] https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24594.pdf
> > 
> > Fixes: 0c54914d0c52 ("KVM: x86: use Intel speculation bugs and features as derived in generic x86 code")
> > Suggested-by: Venkatesh Srinivas <venkateshs@chromium.org>
> > Signed-off-by: Jim Mattson <jmattson@google.com>
> > ---
> >  arch/x86/kvm/cpuid.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> > index ec7b2ca3b4d3..c8d7d928ffc7 100644
> > --- a/arch/x86/kvm/cpuid.c
> > +++ b/arch/x86/kvm/cpuid.c
> > @@ -690,7 +690,9 @@ void kvm_set_cpu_caps(void)
> >  	kvm_cpu_cap_set(X86_FEATURE_TSC_ADJUST);
> >  	kvm_cpu_cap_set(X86_FEATURE_ARCH_CAPABILITIES);
> >  
> > -	if (boot_cpu_has(X86_FEATURE_IBPB) && boot_cpu_has(X86_FEATURE_IBRS))
> > +	if (boot_cpu_has(X86_FEATURE_AMD_IBPB_RET) &&
> > +	    boot_cpu_has(X86_FEATURE_AMD_IBPB) &&
> > +	    boot_cpu_has(X86_FEATURE_AMD_IBRS))
> >  		kvm_cpu_cap_set(X86_FEATURE_SPEC_CTRL);
> >  	if (boot_cpu_has(X86_FEATURE_STIBP))
> >  		kvm_cpu_cap_set(X86_FEATURE_INTEL_STIBP);
> > @@ -759,6 +761,8 @@ void kvm_set_cpu_caps(void)
> >  	 * arch/x86/kernel/cpu/bugs.c is kind enough to
> >  	 * record that in cpufeatures so use them.
> >  	 */
> > +	if (boot_cpu_has(X86_FEATURE_SPEC_CTRL))
> > +		kvm_cpu_cap_set(X86_FEATURE_AMD_IBPB_RET);
> 
> If SPEC_CTRL is set, then IBPB is set, so you can't have AMD_IBPB_RET
> without AMD_IBPB, but it just looks odd seeing them set with separate
> checks with no relationship dependency for AMD_IBPB_RET on AMD_IBPB.
> That's just me, though, not worth a v4 unless others feel the same.

You thinking something like this (at the end, after the dust settles)?

	if (WARN_ON_ONCE(kvm_cpu_cap_has(X86_FEATURE_AMD_IBPB_RET) &&
			 !kvm_cpu_cap_has(X86_FEATURE_AMD_IBPB)))
		kvm_cpu_cap_clear(X86_FEATURE_AMD_IBPB_RET);		
> 

> Thanks,
> Tom
> 
> >  	if (boot_cpu_has(X86_FEATURE_IBPB))
> >  		kvm_cpu_cap_set(X86_FEATURE_AMD_IBPB);
> >  	if (boot_cpu_has(X86_FEATURE_IBRS))

