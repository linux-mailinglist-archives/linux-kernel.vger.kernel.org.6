Return-Path: <linux-kernel+bounces-441811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C23F89ED455
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 19:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31495280DC8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82CF2010F2;
	Wed, 11 Dec 2024 18:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X4rBHx31"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195AE1BBBEA
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 18:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733940140; cv=none; b=EnJLbGERDk9Wiit6WXTOkOFsDTcOTTex6PDusKF+s67p6xXZmLxb0NGoSnqjQ0FEU/MfKrVi3OB+aPe1ZHHcPHI3xyGPW47FdnJzPCc6xd828mXxj4xFXDa53wekGk2KEWDT7mVByOBDutjZ+4Mc0vwmx6df2SxE2ZcWdAnk1W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733940140; c=relaxed/simple;
	bh=asqiJpjLiLhCgnZPbayuiLkQWTg+6hfrolruXld72/s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W7kWHowed0Ux/gycR0l2ubhJotoaNYZDRY9VTmcJ4SWOqiYd/wHdnctDEp5WCefwGSE3RBH0io7/tfwDq+kzVjwtEmyqDRW8i98+dTibarbIjy4Efbc6JqITkz+mswmMvUKYHpALCXYnkBTImoqisSMemFbMzppB5YOA8gH7cLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X4rBHx31; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2efc4196ca0so3063183a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 10:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733940137; x=1734544937; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f1lf4kyl5o8ojaR7yeVD7qLHy8y/n2Kt6+OeU26iF60=;
        b=X4rBHx31fTP/34Lhya3SLBAdkYqjryz6yd4FMt+hv+69XQEYDGT3R7vSVLqAaDxlzz
         7QnA89RWW9HPeHyumm/aoqepXYzK/T7R2ILozbrwMwnNT35RvFMOX/k82Xgup95CSCOo
         Ccicgyx8rWsDj/+S17kJwLxEYmqGikW3pvMGDVVsAlDArEY9GtsPHRjBGei5L6Bc9cGQ
         WGkpNHSjYpPqhLMZsABbJZW+5Nk79tmbs9X1YhZTn+nHOhDuY7rUNSa79BcM+kEcpfzz
         RsPJUsUEEWH53ehJjL4rgrpeJrQygGK8IWmeUKy8/y/SS3nnE7aAn3XIa8BcCNiyeVOx
         gyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733940137; x=1734544937;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f1lf4kyl5o8ojaR7yeVD7qLHy8y/n2Kt6+OeU26iF60=;
        b=X5yaoKRvHpYYAKQU171kBxAD3+LrUK/0ir8X2zcuofzl6qb7HmxTwEDhZpX9TntepK
         /10RQ/RKMTjPGaIC1loj96bEUKyKLmPekMoRFUDciLHi68U8wYdeJ4sRqvEQGx1WXELQ
         HFJO5CJCY79KHbzrc4Ll50qlZtkliPk4H13FS/O6DQo1Jhzki+Ext1Fq90+3D4hzIQjo
         f3qU7kLPZKZFd38HpLdUK/nxETLZGi3ziSlCQqLElj5mFhuP0R4PeChyZQQv4fZ+LDUW
         D3a4sJPfLB9fFk12MJFPw7EdTCjX6avDQ0M2OqJN5mkhFE0mDyfCZ+XMdfMFx3meHnOr
         WSsw==
X-Forwarded-Encrypted: i=1; AJvYcCUUMIYjWHXRuTXKnfbFY69FkKmDyMCFjMgP0ZyAOgdQmiRnUplaX3gPeFOB+jms04aluxGm9l3EQLB0Pz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YytpYduV33T7akKRcxmtVWDeDs3rJGeGX/sfTEcpKpk4OVdhz2P
	0i5kmQJSQSleRsqXaQ2T12bMJomU021sgn6Ouiut4A3532MziDir9hTou1B6nZTdxfgvFP1dOee
	y4Q==
X-Google-Smtp-Source: AGHT+IELhj748F6SgeaEJfutWFt3ozm7X+t736qOr2yK5dsPlYPqcc0/Ms9TEI5h9cMJ659WQfUT6SLlSMs=
X-Received: from pjbqa6.prod.google.com ([2002:a17:90b:4fc6:b0:2ef:79ee:65c0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:544b:b0:2ee:b2be:f390
 with SMTP id 98e67ed59e1d1-2f13930a57bmr1094830a91.28.1733940137438; Wed, 11
 Dec 2024 10:02:17 -0800 (PST)
Date: Wed, 11 Dec 2024 10:02:15 -0800
In-Reply-To: <20241111102749.82761-2-iorlov@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241111102749.82761-1-iorlov@amazon.com> <20241111102749.82761-2-iorlov@amazon.com>
Message-ID: <Z1nTp82wgSGe4AmV@google.com>
Subject: Re: [PATCH v2 1/6] KVM: x86: Add function for vectoring error generation
From: Sean Christopherson <seanjc@google.com>
To: Ivan Orlov <iorlov@amazon.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, mingo@redhat.com, 
	pbonzini@redhat.com, shuah@kernel.org, tglx@linutronix.de, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, x86@kernel.org, pdurrant@amazon.co.uk, 
	dwmw@amazon.co.uk
Content-Type: text/plain; charset="us-ascii"

On Mon, Nov 11, 2024, Ivan Orlov wrote:
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index f6900bec4874..f92740e7e107 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6452,6 +6452,7 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
>  	union vmx_exit_reason exit_reason = vmx->exit_reason;
>  	u32 vectoring_info = vmx->idt_vectoring_info;
>  	u16 exit_handler_index;
> +	gpa_t gpa;

I've gone back and forth on where to declare scoped varaibles, but in this case,
I think it makes sense to declare "gpa" inside the if-statement.  Making it
visible at the function scope when it's valid in a _super_ limited case is bound
to cause issues.

Of course, this code goes away by the end of the series, so that point is moot.
But on the other hand, declaring the variable in the if-statement is desirable
as the churn is precisely limited to the code that's being changed.

>  	/*
>  	 * Flush logged GPAs PML buffer, this will make dirty_bitmap more
> @@ -6550,19 +6551,10 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
>  	     exit_reason.basic != EXIT_REASON_APIC_ACCESS &&
>  	     exit_reason.basic != EXIT_REASON_TASK_SWITCH &&
>  	     exit_reason.basic != EXIT_REASON_NOTIFY)) {
> -		int ndata = 3;
> +		gpa = exit_reason.basic == EXIT_REASON_EPT_MISCONFIG
> +		      ? vmcs_read64(GUEST_PHYSICAL_ADDRESS) : INVALID_GPA;

Again a moot point, but IMO using a ternary operator here makes it unnecessarily
difficult to see that gpa is valid if and only if the exit was an EPT misconfig.

		gpa_t gpa = INVALID_GPA;

		if (exit_reason.basic == EXIT_REASON_EPT_MISCONFIG)
			gpa = vmcs_read64(GUEST_PHYSICAL_ADDRESS);


> -		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
> -		vcpu->run->internal.suberror = KVM_INTERNAL_ERROR_DELIVERY_EV;
> -		vcpu->run->internal.data[0] = vectoring_info;
> -		vcpu->run->internal.data[1] = exit_reason.full;
> -		vcpu->run->internal.data[2] = vmx_get_exit_qual(vcpu);
> -		if (exit_reason.basic == EXIT_REASON_EPT_MISCONFIG) {
> -			vcpu->run->internal.data[ndata++] =
> -				vmcs_read64(GUEST_PHYSICAL_ADDRESS);
> -		}
> -		vcpu->run->internal.data[ndata++] = vcpu->arch.last_vmentry_cpu;
> -		vcpu->run->internal.ndata = ndata;
> +		kvm_prepare_event_vectoring_exit(vcpu, gpa);
>  		return 0;
>  	}
>  
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 83fe0a78146f..e338d583f48f 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -8828,6 +8828,28 @@ void kvm_prepare_emulation_failure_exit(struct kvm_vcpu *vcpu)
>  }
>  EXPORT_SYMBOL_GPL(kvm_prepare_emulation_failure_exit);
>  
> +void kvm_prepare_event_vectoring_exit(struct kvm_vcpu *vcpu, gpa_t gpa)
> +{
> +	u32 reason, intr_info, error_code;
> +	struct kvm_run *run = vcpu->run;
> +	u64 info1, info2;
> +	int ndata = 0;
> +
> +	kvm_x86_call(get_exit_info)(vcpu, &reason, &info1, &info2,
> +				    &intr_info, &error_code);
> +
> +	run->internal.data[ndata++] = info2;
> +	run->internal.data[ndata++] = reason;
> +	run->internal.data[ndata++] = info1;
> +	run->internal.data[ndata++] = (u64)gpa;

No need for the cast.

> +	run->internal.data[ndata++] = vcpu->arch.last_vmentry_cpu;
> +
> +	run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
> +	run->internal.suberror = KVM_INTERNAL_ERROR_DELIVERY_EV;
> +	run->internal.ndata = ndata;
> +}
> +EXPORT_SYMBOL_GPL(kvm_prepare_event_vectoring_exit);
> +
>  static int handle_emulation_failure(struct kvm_vcpu *vcpu, int emulation_type)
>  {
>  	struct kvm *kvm = vcpu->kvm;
> -- 
> 2.43.0
> 

