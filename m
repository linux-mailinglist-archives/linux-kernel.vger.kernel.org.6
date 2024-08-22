Return-Path: <linux-kernel+bounces-297872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3C195BEBF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91E68285878
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F3B101C8;
	Thu, 22 Aug 2024 19:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZgZBPs5R"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BBC77104
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 19:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724354242; cv=none; b=GnljgsrKQH3SpIc2BvnGZsW+KD+VtdWTlo7f47sLO5oIY6na/tLsqbh7oJwC/X/jLlhy5REi6AiXy/LqbpR05GDRUsDZTeD/9gmimFHixUJYtQiQcp62Lmx4/bj5qU/v9Kz4fIVS7eqmA1yOvtEAGxGUigfob+TWHBSYLwDiGX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724354242; c=relaxed/simple;
	bh=QWzX0b2A6S1PCRi1PGTavwyX2sKwJnu84N2tJk7U/p8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZHgXvCqulmTXzwXuhuv5Uk/ahsn48DEJBYbgRfoKIPH2xr6nPQEg6qPCqTovncXTH2PTc0Oa1Q6o8yn8JkwhTkBK/3SPh9xgTt7LKQkfFNZf+3g61e9q4iUjbojAMWfVsH44BWfp1rq0zGBgxXfDxzgMWt9EUZF4gcWys1bfsts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZgZBPs5R; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7cd8c27fa53so1507693a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 12:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724354240; x=1724959040; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tkGGCdApsO1nBz4ff/iIpdxDUpZm3A4FCUXOxYZtFBg=;
        b=ZgZBPs5Rp+Y04Cz3i1CWwig7L0WFVuoKQ+rpJDs1LSVgv4o0FC6VXOTZI7rh55uHnc
         sqMHH6Mzc5CFtQj+yvMIfnsngBG0S2it3CrAzjcUBNJhVEwGCn+KMOT4gkO6FG3RWU55
         bN4oyuV5vxkPlWEAjKWPsPmkWnaL3q1FNOCCn1rq1Kz/qnOirSfbtcrPqlud9/7nL90r
         dIxe2AWjwCUYjk/nN3wD6kYNvAJp+xbjcYk9yXWVC80Ft6sQhPS9JD8BiuK39O5EVPlU
         Ki+w1S8K+xpaoI3IYInf/pCVzi/efF1DSsfLM2ViB3PvKzQH6MA7MtgD0+NA0ZAuNvLb
         WAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724354240; x=1724959040;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tkGGCdApsO1nBz4ff/iIpdxDUpZm3A4FCUXOxYZtFBg=;
        b=WyWz7NVMUb6S075vTpVGKUnIhvmxphKgcvIvMF90SvgwouyE76dE/kCXd8ojNT8f31
         siI5D6wia0rVkBNHP7JmOj6cdvnuimtY5fCaOt4MUxwc3AsFtIvkuggcJ6wVML0NSGOJ
         3VUySfC7OUn9ozIUmdtOTmlUpRgeD3g0DOKejKrlQsG6943ocvs6KoI2kyw/6UJxyzrL
         ISOQSyaDiniizuS2u/tv+lbl5K+7ruW4ldC6IDyHxc7xxJkbadfEcOLS1Fr/GSL4eE/z
         BtibZYcaT/Ws7HItWEakSGSXDKC8BczM5TnEt5TEq3LuOzo7X3/pu81EKDNdWFriapnU
         85dw==
X-Forwarded-Encrypted: i=1; AJvYcCXQcrPMf5xbgBdbcTE+NAZbkpNiSNZYQqcsEArynKleV+XRjB4ix58f5giu/xQ4E0t/3WlT0uaUzRqrUac=@vger.kernel.org
X-Gm-Message-State: AOJu0YygmR5qjEzznPBY6hIEFwy7n4Nvktb27GtiIL/4pQm4WlRKomi7
	uJhatGUqFoLkpgFh6GbU2ja5441cpzcc2osPLDZx7NjRX60uE+TMnRDChZfRYuptJlWTyV3fU9Q
	PZA==
X-Google-Smtp-Source: AGHT+IFDsZIDo/Am9uWb9UlvaqHhtEqkjDkuMPlMgrUvGu1xoqrBW9zzVUPA7r/A3w4Lvzt3C1l33ljLdso=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:ff14:b0:2ca:7f5a:db6c with SMTP id
 98e67ed59e1d1-2d60a9fa6ccmr35515a91.3.1724354240253; Thu, 22 Aug 2024
 12:17:20 -0700 (PDT)
Date: Thu, 22 Aug 2024 12:17:18 -0700
In-Reply-To: <20240816182533.2478415-2-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240816182533.2478415-1-jmattson@google.com> <20240816182533.2478415-2-jmattson@google.com>
Message-ID: <ZseOvjOSfvTwmr-6@google.com>
Subject: Re: [PATCH v2 2/2] KVM: x86: AMD's IBPB is not equivalent to Intel's IBPB
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Daniel Sneddon <daniel.sneddon@linux.intel.com>, Kai Huang <kai.huang@intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Venkatesh Srinivas <venkateshs@chromium.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 16, 2024, Jim Mattson wrote:
> >From Intel's documention [1], "CPUID.(EAX=07H,ECX=0):EDX[26]
> enumerates support for indirect branch restricted speculation (IBRS)
> and the indirect branch predictor barrier (IBPB)." Further, from [2],
> "Software that executed before the IBPB command cannot control the
> predicted targets of indirect branches (4) executed after the command
> on the same logical processor," where footnote 4 reads, "Note that
> indirect branches include near call indirect, near jump indirect and
> near return instructions. Because it includes near returns, it follows
> that **RSB entries created before an IBPB command cannot control the
> predicted targets of returns executed after the command on the same
> logical processor.**" [emphasis mine]
> 
> On the other hand, AMD's IBPB "may not prevent return branch
> predictions from being specified by pre-IBPB branch targets" [3].
> 
> However, some AMD processors have an "enhanced IBPB" [terminology
> mine] which does clear the return address predictor. This feature is
> enumerated by CPUID.80000008:EDX.IBPB_RET[bit 30] [4].
> 
> Adjust the cross-vendor features enumerated by KVM_GET_SUPPORTED_CPUID
> accordingly.
> 
> [1] https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/technical-documentation/cpuid-enumeration-and-architectural-msrs.html
> [2] https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/technical-documentation/speculative-execution-side-channel-mitigations.html#Footnotes
> [3] https://www.amd.com/en/resources/product-security/bulletin/amd-sb-1040.html
> [4] https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24594.pdf
> 
> Fixes: 0c54914d0c52 ("KVM: x86: use Intel speculation bugs and features as derived in generic x86 code")
> Suggested-by: Venkatesh Srinivas <venkateshs@chromium.org>
> Signed-off-by: Jim Mattson <jmattson@google.com>

Venkatesh, can I grab a review from you on this?   You know this way better than
I do, and I honestly don't feel like reading mitigation disclosures right now :-)

> ---
>  v2: Use IBPB_RET to identify semantic equality (Venkatesh)
> 
>  arch/x86/kvm/cpuid.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 2617be544480..044bdc9e938b 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -690,7 +690,9 @@ void kvm_set_cpu_caps(void)
>  	kvm_cpu_cap_set(X86_FEATURE_TSC_ADJUST);
>  	kvm_cpu_cap_set(X86_FEATURE_ARCH_CAPABILITIES);
>  
> -	if (boot_cpu_has(X86_FEATURE_IBPB) && boot_cpu_has(X86_FEATURE_IBRS))
> +	if (boot_cpu_has(X86_FEATURE_AMD_IBPB_RET) &&
> +	    boot_cpu_has(X86_FEATURE_AMD_IBPB) &&
> +	    boot_cpu_has(X86_FEATURE_AMD_IBRS))
>  		kvm_cpu_cap_set(X86_FEATURE_SPEC_CTRL);
>  	if (boot_cpu_has(X86_FEATURE_STIBP))
>  		kvm_cpu_cap_set(X86_FEATURE_INTEL_STIBP);
> @@ -759,8 +761,10 @@ void kvm_set_cpu_caps(void)
>  	 * arch/x86/kernel/cpu/bugs.c is kind enough to
>  	 * record that in cpufeatures so use them.
>  	 */
> -	if (boot_cpu_has(X86_FEATURE_IBPB))
> +	if (boot_cpu_has(X86_FEATURE_IBPB)) {
>  		kvm_cpu_cap_set(X86_FEATURE_AMD_IBPB);
> +		kvm_cpu_cap_set(X86_FEATURE_AMD_IBPB_RET);
> +	}
>  	if (boot_cpu_has(X86_FEATURE_IBRS))
>  		kvm_cpu_cap_set(X86_FEATURE_AMD_IBRS);
>  	if (boot_cpu_has(X86_FEATURE_STIBP))
> -- 
> 2.46.0.184.g6999bdac58-goog
>

