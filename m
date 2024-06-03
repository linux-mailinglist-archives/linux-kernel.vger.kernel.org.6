Return-Path: <linux-kernel+bounces-199842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A638FA697
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 01:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73012B2451F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 23:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA9413D24C;
	Mon,  3 Jun 2024 23:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hYd2cOdp"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50336137931
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 23:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717458182; cv=none; b=pS/A599XmLikowB1dh2GDfzOI80z6qO2v6dNHNe2r0lDLluZ7RpUfxOOlI1VGfdWwp9S86AEnuOO+uC2LoOixkfKeXu0tPyiAi4t5pbXdoYEEuCdpeAaJ2Le8zgdEyr7btMXCg4rNddNjKAo6Dj8S3vzDd4AslonURCsf27fj8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717458182; c=relaxed/simple;
	bh=V3fEIuQymV976CLe41KoEQSFCwFNlwcObBa1MX7WNZM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uPorHFFoUMBrEZuTi3WqVo4nftZI5CfZ9hs9XmAOvhGE0TDG9wlw72q/eVlVxbuG7HTh8eSIoqFGyIagrfpO+6qtzP9fInEYW43VMHPeHLRweaqEvpNoHYvFQMkAU3alyTrQOiLGZHboF5ab1KFydFsiwibdowHsy6fhQ/JVYzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hYd2cOdp; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7026fe79eeaso1431986b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 16:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717458180; x=1718062980; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ix1wBJXtB+Dz1uENt+vCOboXGMIz++QIsMDaGY5XcG0=;
        b=hYd2cOdpnCzmLdJLRRINBKE9ll/K0coq7EHE01h2Kr7JbF0I7lp7qVDOyu2jYXl3Vc
         4HWppem3GP2StIs0KtnUNVN0Nw7AASYRN08pheXyVX90hM5sc1DNxxAwrneiFF7EXQIF
         3U0VmiusJiuzZMe0lBnemMDPG/yW34VEM6qpW3Q29bvv0WPnu3q0UhTGLkLjQa4ULAj4
         oIJs56oGOn9PaPUYf1MV7u0uG6ugHHkCG53/TAyTTkx6Ec3YJloky1d6Cik7ocZd9Yqi
         5Yv2zBM/ulvMXm5MI91wm3Y69czS10eLIuvChTXz/h7I3sYgG5grRI+RTynx2GRdsQk+
         9LBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717458180; x=1718062980;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ix1wBJXtB+Dz1uENt+vCOboXGMIz++QIsMDaGY5XcG0=;
        b=STbhaVED1x6YmffNaCr2sIvqjm6eCIFB4FkdxHEY/RUMkXOnXKccN0Gl8ydtx9jdoM
         yWHpSpY6QFLjgZ4NJ3RPjTxKyXYVuqh1EwBdt/uUxmgwQKA7jJD2vC/tORucR5FCAaF+
         YlmEu+2iau0VKq0kLceGZsxl+d/YbpTksH8EeD2zlNDke/3Wt7h4xihipPkwgA4jUOzs
         qW6865bVUS+7mYcEHU/KNz/k24Fw9WY/fNO/GIyhSWgEeK9rholqTXALulKi0lCiFvVf
         xVBk25ozrx5KPPFQ5QzVCIhk+3s84LSo4HHJUaNMSCl6MBOYgiH3/BpIJh/eDCV/nTgH
         26rQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzB3ZjWP8E6a6o9wuZnnIdJbLh7X2ek2P1e/xT+IldHMVFgVqhDTNkYQKao0cgwevLotgCR4f1WRP3wJtOv5yScHIqrIxWQnHZW7qx
X-Gm-Message-State: AOJu0Yw5bBy0Qwk46KN0iZRxWXVixVbDJ3nvNcrwBwxRtGlrZdferDlu
	glL/zSMIEWz2zXwSVn41Kx4tWjQsQcq29bB/cxxU84JPXUmh4FkUFfR6vITeT+2Z3ou7LgWsUuA
	tkg==
X-Google-Smtp-Source: AGHT+IHqaNu096+Zwzp8CVw1P6SzEE6P0P87czRc7jhnRB8aCHCFmhBfG3lGqTDH2L6pdWw4pe0K6jzFHnw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:847:b0:6f4:47dd:5f41 with SMTP id
 d2e1a72fcca58-70247a9eb6bmr511116b3a.6.1717458179407; Mon, 03 Jun 2024
 16:42:59 -0700 (PDT)
Date: Mon, 3 Jun 2024 16:42:57 -0700
In-Reply-To: <20240503142548.194585-1-wei.w.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240503142548.194585-1-wei.w.wang@intel.com>
Message-ID: <Zl5VAWlw5XfkqLC-@google.com>
Subject: Re: [PATCH v1] KVM: x86: 0-initialize kvm_caps.supported_xss on definition
From: Sean Christopherson <seanjc@google.com>
To: Wei Wang <wei.w.wang@intel.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, May 03, 2024, Wei Wang wrote:
> 0-initialize kvm_caps.supported_xss on definition, so that it doesn't
> need to be explicitly zero-ed either in the common x86 or VMX/SVM
> initialization paths. This simplifies the code and reduces LOCs.

Heh, nope, see commit 40269c03fdbf ("KVM: x86: Explicitly zero kvm_caps during
vendor module load").

I do agree the code in kvm_x86_vendor_init() in particular is a bit odd, but it's
there because KVM support for XSAVES could be cleared by ->hardware_setup()
(XSAVES has a VMX knob, XSAVE for XCR0 does not).

And while I agree it's also odd that vendor code explicitly zeros supported_xss,
that too serves a purpose.  It reduces the probability of advertising XSS support
in vendor code that doesn't yet fully support the feature, e.g. if KVM VMX supports
CET before KVM SVM, then KVM SVM "needs" to clear supported_xss.  In quotes because
common KVM should also do the clearing based on CET CPUID features.  But, it's
still a nice reminder that vendor code likely needs additional support.

> No functional changes intended.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>  arch/x86/kvm/svm/svm.c | 1 -
>  arch/x86/kvm/vmx/vmx.c | 2 --
>  arch/x86/kvm/x86.c     | 4 +---
>  3 files changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 9aaf83c8d57d..8105e5383b62 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -5092,7 +5092,6 @@ static __init void svm_set_cpu_caps(void)
>  	kvm_set_cpu_caps();
>  
>  	kvm_caps.supported_perf_cap = 0;
> -	kvm_caps.supported_xss = 0;
>  
>  	/* CPUID 0x80000001 and 0x8000000A (SVM features) */
>  	if (nested) {
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 22411f4aff53..495125723c15 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7952,8 +7952,6 @@ static __init void vmx_set_cpu_caps(void)
>  	if (vmx_umip_emulated())
>  		kvm_cpu_cap_set(X86_FEATURE_UMIP);
>  
> -	/* CPUID 0xD.1 */
> -	kvm_caps.supported_xss = 0;
>  	if (!cpu_has_vmx_xsaves())
>  		kvm_cpu_cap_clear(X86_FEATURE_XSAVES);
>  
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 91478b769af0..6a97592950ff 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -94,6 +94,7 @@
>  
>  struct kvm_caps kvm_caps __read_mostly = {
>  	.supported_mce_cap = MCG_CTL_P | MCG_SER_P,
> +	.supported_xss = 0,
>  };
>  EXPORT_SYMBOL_GPL(kvm_caps);
>  
> @@ -9795,9 +9796,6 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
>  
>  	kvm_register_perf_callbacks(ops->handle_intel_pt_intr);
>  
> -	if (!kvm_cpu_cap_has(X86_FEATURE_XSAVES))
> -		kvm_caps.supported_xss = 0;
> -
>  #define __kvm_cpu_cap_has(UNUSED_, f) kvm_cpu_cap_has(f)
>  	cr4_reserved_bits = __cr4_reserved_bits(__kvm_cpu_cap_has, UNUSED_);
>  #undef __kvm_cpu_cap_has
> 
> base-commit: 16c20208b9c2fff73015ad4e609072feafbf81ad
> -- 
> 2.27.0
> 

