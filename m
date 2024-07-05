Return-Path: <linux-kernel+bounces-241863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C40F928068
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 04:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF5D31C22FD0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 02:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDA8175AA;
	Fri,  5 Jul 2024 02:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ILDKTncc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756F01643D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 02:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720146369; cv=none; b=hDU6QsVhBwVpRsQfoubiTl9ZzDUnKSA6grsQk/L2aWUzPnafnkLGgsXrDirm7I6D/AGgeQD2CeXMNbr620sQ+w9OXX+irwwCcVrS/vZ0D/5+SrPNOxh56JRS27bjiub73qtbQoJ5xw92gr/+l6dZ6W+IhFKQLcCjDHRKwzwTZg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720146369; c=relaxed/simple;
	bh=rYJ++bZa0yA7ojMloercr3EzmWnX61lwyq1O/PwAfbg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EAAnCqpJkERjz3CEhggnPK6oyKms72sqm9sQU568XIT53fGAiufSL3Duzg/Gnd/L9AWb9GX7qrOlPBWy7JyYkQYkOu0oI7LFNBtVkItTQKs37NHEWM5eJzHO3J6oGMA9wrjwg8Kjmfxmc8AVhVSJAEEhIvp3IALY7NVO7u+rJ+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ILDKTncc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720146366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2D8qhNLzDbP+EEHFtyIRTsK/xaD/vUNpkVgaMqqlnoY=;
	b=ILDKTnccyjGY3GlFrIwDjHCLXyC5IbRm0G0xScj0m4KhaLRa3TN9c3jZ0QeFU9s2Fk6c9p
	jOWYRbadFIlVPVk7apX5GwawNlKZC8NRQRfkAIEPdonEXh0lCiw4ev07jJsXUWhAtIpSso
	8xb3xJi+0ZOAnhurQbu8K2Wz5YPY4bs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-rkalWVKMOJS4mpOCIUiFAw-1; Thu, 04 Jul 2024 22:26:05 -0400
X-MC-Unique: rkalWVKMOJS4mpOCIUiFAw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4465a29c965so19555451cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 19:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720146364; x=1720751164;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2D8qhNLzDbP+EEHFtyIRTsK/xaD/vUNpkVgaMqqlnoY=;
        b=i5P7DbieyCErqycif84AUrKHvclYwQMhPUnyJBmugtk4J2RZ8e3G1bg+KX0hmdq44r
         mTmc4ea7tD6MiCH3aH/ZQrfl5Q4lOHOKm5q7qwygi83SArVXGX7/rLJljFuK2cDqPbb2
         rhfdBqAewNSptnJymMarIX8uHqtSiN/IIZbDKs8bxZnk2ZTcT1S9kll0JsJXfITNp8e0
         3ebnT+0czspBw0t1w/hJB/FPVe+LrugIwb1+Jk/WvZFQ6UBs6yXFF/v859VsYP9kAn5X
         5YG1cpshXfhM/a9c6mVIxsSnVMlggSIhI8doFBPU3L+zw0tfmeRmKqlgUYGfEMLWOhYr
         vKLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWi1jVqRh2dk7TH6eImv/1oXVvDmH3DZgCyezcYZaXP2n3jCVQj3BHNy/U4uyvQEnb8tSdZ93NyYr1m5IpTF7EAIKfLe/ja2cEfAuUx
X-Gm-Message-State: AOJu0YySP2v/k3KUpBeNm2mLcERwKli+q1jvHoR7Adry81ptSc9+TlZM
	4ovnHsgOgOu3A17yC+XosVatD8r34DDkfD9/4ozxO6lZT1VM2VDxyq7wVqJA/FPrMItY0EVcjVS
	s3pJ8qe3ds3TfWeoPjS3dmMuq0HUwVor7YNdmUjxM2CpLP+izneXOsNJnpVeAXA==
X-Received: by 2002:a05:622a:1445:b0:444:f6d2:be89 with SMTP id d75a77b69052e-447cce878bcmr57375831cf.5.1720146364616;
        Thu, 04 Jul 2024 19:26:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAVNN2j3ROliZOTWzuYp/UeB1ud6wiWQz8FpAPeEJr12P4ax65uTSkWLAQX0+lJrZFMhA1Vw==
X-Received: by 2002:a05:622a:1445:b0:444:f6d2:be89 with SMTP id d75a77b69052e-447cce878bcmr57375651cf.5.1720146364274;
        Thu, 04 Jul 2024 19:26:04 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4465149d530sm65325471cf.77.2024.07.04.19.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 19:26:04 -0700 (PDT)
Message-ID: <2d554577722d30605ecd0f920f4777129fff3951.camel@redhat.com>
Subject: Re: [PATCH v2 44/49] KVM: x86: Update guest cpu_caps at runtime for
 dynamic CPUID-based features
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Hou Wenlong
 <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, Oliver Upton
 <oliver.upton@linux.dev>, Binbin Wu <binbin.wu@linux.intel.com>, Yang
 Weijiang <weijiang.yang@intel.com>, Robert Hoo <robert.hoo.linux@gmail.com>
Date: Thu, 04 Jul 2024 22:26:03 -0400
In-Reply-To: <20240517173926.965351-45-seanjc@google.com>
References: <20240517173926.965351-1-seanjc@google.com>
	 <20240517173926.965351-45-seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Fri, 2024-05-17 at 10:39 -0700, Sean Christopherson wrote:
> When updating guest CPUID entries to emulate runtime behavior, e.g. when
> the guest enables a CR4-based feature that is tied to a CPUID flag, also
> update the vCPU's cpu_caps accordingly.  This will allow replacing all
> usage of guest_cpuid_has() with guest_cpu_cap_has().
> 
> Note, this relies on kvm_set_cpuid() taking a snapshot of cpu_caps before
> invoking kvm_update_cpuid_runtime(), i.e. when KVM is updating CPUID
> entries that *may* become the vCPU's CPUID, so that unwinding to the old
> cpu_caps is possible if userspace tries to set bogus CPUID information.
> 
> Note #2, none of the features in question use guest_cpu_cap_has() at this
> time, i.e. aside from settings bits in cpu_caps, this is a glorified nop.
> 
> Cc: Yang Weijiang <weijiang.yang@intel.com>
> Cc: Robert Hoo <robert.hoo.linux@gmail.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/cpuid.c | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 552e65ba5efa..1424a9d4eb17 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -330,28 +330,38 @@ static u64 cpuid_get_supported_xcr0(struct kvm_vcpu *vcpu)
>  	return (best->eax | ((u64)best->edx << 32)) & kvm_caps.supported_xcr0;
>  }
>  
> +static __always_inline void kvm_update_feature_runtime(struct kvm_vcpu *vcpu,
> +						       struct kvm_cpuid_entry2 *entry,
> +						       unsigned int x86_feature,
> +						       bool has_feature)
> +{
> +	cpuid_entry_change(entry, x86_feature, has_feature);
> +	guest_cpu_cap_change(vcpu, x86_feature, has_feature);
> +}
> +
>  void kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_cpuid_entry2 *best;
>  
>  	best = kvm_find_cpuid_entry(vcpu, 1);
>  	if (best) {
> -		cpuid_entry_change(best, X86_FEATURE_OSXSAVE,
> -				   kvm_is_cr4_bit_set(vcpu, X86_CR4_OSXSAVE));
> +		kvm_update_feature_runtime(vcpu, best, X86_FEATURE_OSXSAVE,
> +					   kvm_is_cr4_bit_set(vcpu, X86_CR4_OSXSAVE));
>  
> -		cpuid_entry_change(best, X86_FEATURE_APIC,
> -			   vcpu->arch.apic_base & MSR_IA32_APICBASE_ENABLE);
> +		kvm_update_feature_runtime(vcpu, best, X86_FEATURE_APIC,
> +					   vcpu->arch.apic_base & MSR_IA32_APICBASE_ENABLE);
>  
>  		if (!kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_MISC_ENABLE_NO_MWAIT))
> -			cpuid_entry_change(best, X86_FEATURE_MWAIT,
> -					   vcpu->arch.ia32_misc_enable_msr &
> -					   MSR_IA32_MISC_ENABLE_MWAIT);
> +			kvm_update_feature_runtime(vcpu, best, X86_FEATURE_MWAIT,
> +						   vcpu->arch.ia32_misc_enable_msr &
> +						   MSR_IA32_MISC_ENABLE_MWAIT);
>  	}
>  
>  	best = kvm_find_cpuid_entry_index(vcpu, 7, 0);
>  	if (best)
> -		cpuid_entry_change(best, X86_FEATURE_OSPKE,
> -				   kvm_is_cr4_bit_set(vcpu, X86_CR4_PKE));
> +		kvm_update_feature_runtime(vcpu, best, X86_FEATURE_OSPKE,
> +					   kvm_is_cr4_bit_set(vcpu, X86_CR4_PKE));
> +
>  
>  	best = kvm_find_cpuid_entry_index(vcpu, 0xD, 0);
>  	if (best)


I am not 100% sure that we need to do this.

Runtime cpuid changes are a hack that Intel did back then,
due to various reasons, These changes don't really change the feature set
that CPU supports, but merly as you like to say 'massage' the output of
the CPUID instruction to make the unmodified OS happy usually.

Thus it feels to me that CPU caps should not include the dynamic features, and neither
KVM should use the value of these as a source for truth, but rather the underlying
source of the truth (e.g CR4).

But if you insist, I don't really have a very strong reason to object this.

Best regards,
	Maxim Levitsky




