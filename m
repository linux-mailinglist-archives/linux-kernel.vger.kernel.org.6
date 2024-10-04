Return-Path: <linux-kernel+bounces-350062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A201D98FF3D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 11:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63BA32818F2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 09:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437B0146D78;
	Fri,  4 Oct 2024 09:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDUCMRMd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BC2146000
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 09:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728032561; cv=none; b=LOvFU2S6yT7QNVCo4RERCh2khzrOJL7YkxCzR9Y7hAGBmTVxv7yty4b/gjRFB/6uYbefS7s6yC9EcvHgNujESE54gbZEcvTeW1dwfMBH4lHE3ajCCdmnAWj1ERyzWsJVaGai27V6C/7+lzT0FZmP4De1fJn8g/wWi48ePNOHrvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728032561; c=relaxed/simple;
	bh=tTiuQbOvL9AdUeu7T1xwByTBdlsojimyxTeIk9sRfd8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mMFLg7rQxe6G/INaOj2s+m969XqZ1iA445XNX0SZULrMce252K+s3PBQBzC/HNM8RBVsPn2o1NcOsDwMMo3EKnpyrvhDe+Ns1TfFJnJTAPzSPDPdmEZ3Lsbu7mtGFPlFToYu+4L7shmxH+CbWiL4tv3tQNey+zt0kG9GpQm5mSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WDUCMRMd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728032558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jsVLntDknwR3ZIZ5/Rs9mBAyTnWF8CfMXf/W+Xr+SlE=;
	b=WDUCMRMdeXyw5J0dkFa0L/HCz2hz67qYFEfavbXznH+W4BkbOENbTnWEQ+IPW7aQ3vUaiH
	joLXlc/BKg8R3aVa5jTvcypa6QuSSgvV6f6bFImWoWMdx+OT7+wmH+mNuXcZGdhAqW4BrM
	dg1csFAiGaC9AZTzsT6Mn1ih9P2WKP8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-fGaha6SXObuEHHRnyLSFJA-1; Fri, 04 Oct 2024 05:02:37 -0400
X-MC-Unique: fGaha6SXObuEHHRnyLSFJA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cb479fab2so12815585e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 02:02:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728032556; x=1728637356;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jsVLntDknwR3ZIZ5/Rs9mBAyTnWF8CfMXf/W+Xr+SlE=;
        b=ka29tA52EJno7hql9kLXApioQntNy3OoUpzsiG9VpfyC4pqiu/ePf070i+ZZn8LLfT
         Ad7uQLZDq5TceY8Ylz2bj9fxIAUrZP3muXi0DQ963Oim1eSvT3svvOK6N/ZtXzwU901s
         rfDWpKtivGCFtqzX1PsyDyDMQ+GSFpF5/etIm72wzJbM2kIaRpMr53aWgc62iAfVPUU+
         81ilPir/XX4Lqco4gP4CiQRejFOf4ti3BQS7WNMuQpSCEfTy6T1GAYBPDJfKEl+kbFQX
         A4IWJNHqVHzEpq0upPfHpoyKezLDkZJ+NNYdG7iOjEZP/9eaN/Yp3YxA+b9t1I8ZZP+6
         Rolw==
X-Forwarded-Encrypted: i=1; AJvYcCWi7XoRa7eENTVdwNT+GPr83g2iOf1MADWkQGknYF4lGbcmdIo7u+G8kCkd3ginFbxwtY++OrGH64k0eFc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7YJNBTlHc9D3OaBLto7oXOX3DrYx0dbRRw35LsCT6Y6MOjv/l
	4sEBxx/ywhsLJ9O7p7ZL8bQ3u0RLfv4e9+V0lmv3EZxB1EkxHiG3bD6250nSNyi93jMNt74hSiQ
	6JmFVhJ0NAe7Ep0MwK4mz9F685D+PVpqzfRSDgFmyBPfUkZQbfJmA2zZhHN993ZIIRzxpHxQmtP
	w3OtbBt/TUvTLL6Rbq4f1PdCIk5Yvvz3qEP5VeO1XSCPR1WA==
X-Received: by 2002:a05:600c:4695:b0:426:67f9:a7d8 with SMTP id 5b1f17b1804b1-42f856acb18mr11357395e9.9.1728032556429;
        Fri, 04 Oct 2024 02:02:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFg+sWKYjtYU1MQAG3fGLPD9CyiQBb6WVI+lLTykJmY7Kbr7Sk6rgO9vD8KLX6KFP9FdYhtOw==
X-Received: by 2002:a05:600c:4695:b0:426:67f9:a7d8 with SMTP id 5b1f17b1804b1-42f856acb18mr11357115e9.9.1728032555991;
        Fri, 04 Oct 2024 02:02:35 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f8599487fsm14464875e9.0.2024.10.04.02.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 02:02:35 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Sean Christopherson
 <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] KVM: selftests: Rework OSXSAVE CR4=>CPUID test to
 play nice with AVX insns
In-Reply-To: <20241003234337.273364-5-seanjc@google.com>
References: <20241003234337.273364-1-seanjc@google.com>
 <20241003234337.273364-5-seanjc@google.com>
Date: Fri, 04 Oct 2024 11:02:34 +0200
Message-ID: <87r08wi6l1.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sean Christopherson <seanjc@google.com> writes:

> Rework the CR4/CPUID sync test to clear CR4.OSXSAVE, do CPUID, and restore
> CR4.OSXSAVE in assembly, so that there is zero chance of AVX instructions
> being executed while CR4.OSXSAVE is disabled.  This will allow enabling
> CR4.OSXSAVE by default for selftests vCPUs as a general means of playing
> nice with AVX instructions.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  .../kvm/x86_64/cr4_cpuid_sync_test.c          | 46 +++++++++++++------
>  1 file changed, 32 insertions(+), 14 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c b/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
> index 624dc725e14d..da818afb7031 100644
> --- a/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
> @@ -19,15 +19,14 @@
>  #include "kvm_util.h"
>  #include "processor.h"
>  
> -static inline bool cr4_cpuid_is_sync(void)
> -{
> -	uint64_t cr4 = get_cr4();
> -
> -	return (this_cpu_has(X86_FEATURE_OSXSAVE) == !!(cr4 & X86_CR4_OSXSAVE));
> -}
> +#define MAGIC_HYPERCALL_PORT	0x80
>  
>  static void guest_code(void)
>  {
> +	u32 regs[4] = {
> +		[KVM_CPUID_EAX] = X86_FEATURE_OSXSAVE.function,
> +		[KVM_CPUID_ECX] = X86_FEATURE_OSXSAVE.index,
> +	};
>  	uint64_t cr4;
>  
>  	/* turn on CR4.OSXSAVE */
> @@ -36,13 +35,29 @@ static void guest_code(void)
>  	set_cr4(cr4);
>  
>  	/* verify CR4.OSXSAVE == CPUID.OSXSAVE */
> -	GUEST_ASSERT(cr4_cpuid_is_sync());
> +	GUEST_ASSERT(this_cpu_has(X86_FEATURE_OSXSAVE));
>  
> -	/* notify hypervisor to change CR4 */
> -	GUEST_SYNC(0);
> +	/*
> +	 * Notify hypervisor to clear CR4.0SXSAVE, do CPUID and save output,
> +	 * and then restore CR4.  Do this all in  assembly to ensure no AVX
> +	 * instructions are executed while OSXSAVE=0.
> +	 */
> +	asm volatile (
> +		"out %%al, $" __stringify(MAGIC_HYPERCALL_PORT) "\n\t"
> +		"cpuid\n\t"
> +		"mov %%rdi, %%cr4\n\t"
> +		: "+a" (regs[KVM_CPUID_EAX]),
> +		  "=b" (regs[KVM_CPUID_EBX]),
> +		  "+c" (regs[KVM_CPUID_ECX]),
> +		  "=d" (regs[KVM_CPUID_EDX])
> +		: "D" (get_cr4())
> +	);
>  
> -	/* check again */
> -	GUEST_ASSERT(cr4_cpuid_is_sync());
> +	/* Verify KVM cleared OSXSAVE in CPUID when it was cleared in CR4. */
> +	GUEST_ASSERT(!(regs[X86_FEATURE_OSXSAVE.reg] & BIT(X86_FEATURE_OSXSAVE.bit)));
> +
> +	/* Verify restoring CR4 also restored OSXSAVE in CPUID. */
> +	GUEST_ASSERT(this_cpu_has(X86_FEATURE_OSXSAVE));
>  
>  	GUEST_DONE();
>  }
> @@ -62,13 +77,16 @@ int main(int argc, char *argv[])
>  		vcpu_run(vcpu);
>  		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
>  
> -		switch (get_ucall(vcpu, &uc)) {
> -		case UCALL_SYNC:
> +		if (vcpu->run->io.port == MAGIC_HYPERCALL_PORT &&
> +		    vcpu->run->io.direction == KVM_EXIT_IO_OUT) {
>  			/* emulate hypervisor clearing CR4.OSXSAVE */
>  			vcpu_sregs_get(vcpu, &sregs);
>  			sregs.cr4 &= ~X86_CR4_OSXSAVE;
>  			vcpu_sregs_set(vcpu, &sregs);
> -			break;
> +			continue;
> +		}
> +
> +		switch (get_ucall(vcpu, &uc)) {
>  		case UCALL_ABORT:
>  			REPORT_GUEST_ASSERT(uc);
>  			break;

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly


