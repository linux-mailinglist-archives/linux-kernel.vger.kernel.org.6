Return-Path: <linux-kernel+bounces-212273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54968905D92
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 23:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C0D02839F1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 21:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EE68624A;
	Wed, 12 Jun 2024 21:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2UMGOmvp"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD73084FCC
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 21:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718227254; cv=none; b=qGF3z8Y3A/UgOGuUPFRbdDTRlDXmXS25VS5P/g6YXhw6WBtkWaNO1eNe9vFzdMNt647wVZ+Pji4RynK5QJ48KM1dmueEwnz72ppKho0Y6XsLsD8c2FtH1/cOoZ5Km4UjvTQmkuljsIJZjx1CL5mPXOCNEYpTWWqb5ighWDyOJ78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718227254; c=relaxed/simple;
	bh=1GcSncPwqKEQjxsMosB7/O2aygmUJPI07VDJmC37b5E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F4SHeKISSc1ed0UOhrghHbP5CkI+QTdE47kkYUn6knzTlS+0gXAGdxtHbuRIwUYrqTUYhyzDUPN+4wdyhWSAxrTFqpQdX6A0vJdaxzkeyhKjPbqcJlwHAR9vKkTqm2lx/jCZ2LPnfJNTD3khVECz1FtxNwaSqA63hZ1HNIYgKSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2UMGOmvp; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1f711de167eso2519055ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 14:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718227252; x=1718832052; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a4s5wFvfeNJXCJWEmUtUY237craFIfNnXh+7wQwiZM8=;
        b=2UMGOmvpfuxZFXk9IV9IutXeotId8EYUzKxQe4/pzSKzalDUMuUMEqCZ5S5+bCP5+m
         SSHuT//O0SB2zqV4FxFGPHmmZGLwPSP56Y1+PxVV6hhGDtQ6R2IcJwamT9EcJ7LMdEjO
         HltO6YBhQ5oSis1c/KH9H/H/EXXqwu6pKt6rSzWzEOx+N6ioUBcRUr6UIX4Ak2hqLOS4
         YR1Ka/kf6HBxDtfcKPPQ5TOYZ8bkDAGDxplSzY1EWkF6+3ahoxzvrmZ/5xGlAvT4BWhd
         VQ41E3iDlGaeha/vh3q5coQbWOCCC8yQRr7AcyCV2yD1Hm9oYxHtmdEVxYp0BcielSdp
         jVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718227252; x=1718832052;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a4s5wFvfeNJXCJWEmUtUY237craFIfNnXh+7wQwiZM8=;
        b=Cmrbc/3ZFNFwwew7pnx6MHnEBsyG6kq0OVzACjFY5PkETViAcqP/JXTY19VlpUz1t/
         UqVEj1LjpAgDC6MRUktloxX+8HYsHrJfYa4iLQFyfkn0n7u5g05Qh3rKKSNnVkHGLmRc
         tEFvaqiBtMbaskYabykUJVUl7/cOIKYKRZbeS1c4oy4DDlR3xAAcrggXOI0zvRoiekkz
         3WH9vaG2qhj+A77twPzyEcNaoL+ingAOceeUuww7uneDg16ussbQh/MQy4+qphaVK7SP
         4/k4n04TTLq6MVVafvXlR08LVg7Cm269FgcLP7+JwLTbgh02u3fXco0PlqERJ24IDntc
         g2RQ==
X-Gm-Message-State: AOJu0YzP6qm4gwobbUg6YMBSsPO76Lgr/KZevCW7/xJsDshAwBCS0jKG
	dsgzO9w0KoqBlshYQuZeD44ZNo/v6E/+ZEG3pWwQ/gPeKlp9ZkO5dPbVzNp0QGdn8WNRPxMUoRB
	enw==
X-Google-Smtp-Source: AGHT+IF236fVTqan1xeFH5dPPmgc0NM7zLynRwigfEMIC3iJa54rvvA/hW7i8p+BK04gMU89grxKlGMEn9I=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:234f:b0:1f3:f8c:55d5 with SMTP id
 d9443c01a7336-1f83b55b4b7mr84625ad.2.1718227252048; Wed, 12 Jun 2024 14:20:52
 -0700 (PDT)
Date: Wed, 12 Jun 2024 14:20:50 -0700
In-Reply-To: <20240207172646.3981-8-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207172646.3981-1-xin3.li@intel.com> <20240207172646.3981-8-xin3.li@intel.com>
Message-ID: <ZmoRMp_-CXC9QqPK@google.com>
Subject: Re: [PATCH v2 07/25] KVM: VMX: Set intercept for FRED MSRs
From: Sean Christopherson <seanjc@google.com>
To: Xin Li <xin3.li@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	pbonzini@redhat.com, corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	shuah@kernel.org, vkuznets@redhat.com, peterz@infradead.org, 
	ravi.v.shankar@intel.com, xin@zytor.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Feb 07, 2024, Xin Li wrote:
> @@ -7774,10 +7777,12 @@ static void update_intel_pt_cfg(struct kvm_vcpu *vcpu)
>  static void vmx_vcpu_config_fred_after_set_cpuid(struct kvm_vcpu *vcpu)
>  {
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
> +	bool fred_enumerated;
>  
>  	kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_FRED);
> +	fred_enumerated = guest_can_use(vcpu, X86_FEATURE_FRED);

"enumerated" isn't correct.  Userspace can enumerate FRED to the guest even if
FRED is unsupported in KVM.

Planning for a future where this becomes guest_cpu_cap_has(), maybe "has_fred"?

> -	if (guest_can_use(vcpu, X86_FEATURE_FRED)) {
> +	if (fred_enumerated) {
>  		vm_entry_controls_setbit(vmx, VM_ENTRY_LOAD_IA32_FRED);
>  		secondary_vm_exit_controls_setbit(vmx,
>  						  SECONDARY_VM_EXIT_SAVE_IA32_FRED |
> @@ -7788,6 +7793,16 @@ static void vmx_vcpu_config_fred_after_set_cpuid(struct kvm_vcpu *vcpu)
>  						    SECONDARY_VM_EXIT_SAVE_IA32_FRED |
>  						    SECONDARY_VM_EXIT_LOAD_IA32_FRED);
>  	}
> +
> +	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP0, MSR_TYPE_RW, !fred_enumerated);
> +	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP1, MSR_TYPE_RW, !fred_enumerated);
> +	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP2, MSR_TYPE_RW, !fred_enumerated);
> +	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP3, MSR_TYPE_RW, !fred_enumerated);
> +	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_STKLVLS, MSR_TYPE_RW, !fred_enumerated);
> +	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_SSP1, MSR_TYPE_RW, !fred_enumerated);
> +	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_SSP2, MSR_TYPE_RW, !fred_enumerated);
> +	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_SSP3, MSR_TYPE_RW, !fred_enumerated);
> +	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_CONFIG, MSR_TYPE_RW, !fred_enumerated);
>  }
>  
>  static void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
> -- 
> 2.43.0
> 

