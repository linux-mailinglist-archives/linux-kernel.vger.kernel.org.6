Return-Path: <linux-kernel+bounces-241768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 552EB927F72
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 02:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDB111F23C68
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 00:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8176E9474;
	Fri,  5 Jul 2024 00:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BNLusUNL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57895C83
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 00:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720140497; cv=none; b=iexdmItV8QEtIvTCt/FJdHj/3uEG8a7IHcqT32lf06thZCNhZlu9oE8pSSgIizAKKWoDtIgIXdZQsGunSpQgVDjXt0p9/IfqTbW5UWwcB+8kwumI4f54PoFTlC30AzsQRlvUIsBqV5WSFIgRwWfBqgIEvaSx5GFXyLee7BNXBuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720140497; c=relaxed/simple;
	bh=UCYavsOYlDJtoPoG3lzm2cK4S3yoWAf+mGlSkpNPZC8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jFXw44eNHue+Hop8lRWCLNOQMC4btb+4e5IFcYl8F5xNX9z2OGQRDehgiN1g8RatpJez1QavKP39f/1pkAnWLKoapbdAGlJ38o8oZM5slNpeybFKU1HySXC6pjq90uczNIm6C4ZZuDmauE/yaf7YReJ1Qsy4L/MNSCDeS2w71YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BNLusUNL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720140493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1taNz8T2VLQRBGglDYc9q5xdZlahhRSOV1YwKJ4I0vQ=;
	b=BNLusUNLuAzV7fC0WM6dQSn5bmZUr00MgCHObiFGPsh9M8QL70zbegiEpvjXhkdrncIFAF
	BdiKZXfEnIBPRr4ltouIS8lIToWlGBIdbsZds1xo6lY9IueDDVRtt6dR701NvMffonNYhM
	1lQsopV2AAW1lqz/WlxbIc3ifbjfe0U=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-j4pq1SzwMaaxv4l82zPg6g-1; Thu, 04 Jul 2024 20:48:12 -0400
X-MC-Unique: j4pq1SzwMaaxv4l82zPg6g-1
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e03a544b9c8so1821896276.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 17:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720140491; x=1720745291;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1taNz8T2VLQRBGglDYc9q5xdZlahhRSOV1YwKJ4I0vQ=;
        b=JbQofGxeiiKlPzexARSTeScd1fPr5en/T8Kinc1AN3p0GXDJ/NDp6GgYbQdlcCuMJC
         1+LjtTvY+D+dUR1GpHAcXxdwYEHr0CN9T1zLzUWqvD3xcexvqi8mVvP9nYkarTYcwC0S
         9UFpvX4nuhjD+N9QPwTL6qzTNluzQ7NsKNFTmziYynLNXDhYEhyOBZg92j2/8WK7FJpg
         BlawGvS4DXMFWUb4R/+BNWF7wSBVPpT6jKYHV06m6g0Kh+B2utyt/bqloKui83F77z+y
         VQ+/pthPLfJ4vDZnGXVO+IcTTLVMM8YYfFEYhoZfB9QDmEzm2T/jHx2gkGUnLX+Eq9BF
         L5Og==
X-Forwarded-Encrypted: i=1; AJvYcCXQkb2oh67k/NhYg1NaVOYYvZX8ZlxqRuqK2UesmankwtPDWmOtrHr2tiVqxJigZBCgtsy0hXRlvS7KYZI1eQv83D9psUYoiKsIVasj
X-Gm-Message-State: AOJu0YxAQlq9hkGLNz/il4vo8hwt+IowaaJfQAlZNx6f24OAIMeL2D2R
	NNw9pQbrC3dtwh8bYcRFL7QTRGMT2S5Phm4TwmcOVwhfpTrDbT2c2oATO25d9uHLxkK1GkdfMrq
	0hJDhjlBnRGipM4AVFMV1LjaA/uyTCclyAGlRGV+hd5rbIhquCqGUUQ+QEAxmiA==
X-Received: by 2002:a25:ade8:0:b0:e03:a248:7dd3 with SMTP id 3f1490d57ef6-e03c196966fmr3345504276.23.1720140491689;
        Thu, 04 Jul 2024 17:48:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLtTb8qCSDdsaN2DhQVTPgfPMllt0+iLg2fNvdycLvwNeGaSGnRSg7IVAaPsOWTpmD0ep1qg==
X-Received: by 2002:a25:ade8:0:b0:e03:a248:7dd3 with SMTP id 3f1490d57ef6-e03c196966fmr3345486276.23.1720140491395;
        Thu, 04 Jul 2024 17:48:11 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e5f7e1esm68415876d6.98.2024.07.04.17.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 17:48:11 -0700 (PDT)
Message-ID: <62cbd606f6d636445fd1352ae196a0973c362170.camel@redhat.com>
Subject: Re: [PATCH v2 01/49] KVM: x86: Do all post-set CPUID processing
 during vCPU creation
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Hou Wenlong
 <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, Oliver Upton
 <oliver.upton@linux.dev>, Binbin Wu <binbin.wu@linux.intel.com>, Yang
 Weijiang <weijiang.yang@intel.com>, Robert Hoo <robert.hoo.linux@gmail.com>
Date: Thu, 04 Jul 2024 20:48:10 -0400
In-Reply-To: <20240517173926.965351-2-seanjc@google.com>
References: <20240517173926.965351-1-seanjc@google.com>
	 <20240517173926.965351-2-seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Fri, 2024-05-17 at 10:38 -0700, Sean Christopherson wrote:
> During vCPU creation, process KVM's default, empty CPUID as if userspace
> set an empty CPUID to ensure consistent and correct behavior with respect
> to guest CPUID.  E.g. if userspace never sets guest CPUID, KVM will never
> configure cr4_guest_rsvd_bits, and thus create divergent, incorrect, guest-
> visible behavior due to letting the guest set any KVM-supported CR4 bits
> despite the features not being allowed per guest CPUID.
> 
> Note!  This changes KVM's ABI, as lack of full CPUID processing allowed
> userspace to stuff garbage vCPU state, e.g. userspace could set CR4 to a
> guest-unsupported value via KVM_SET_SREGS.  But it's extremely unlikely
> that this is a breaking change, as KVM already has many flows that require
> userspace to set guest CPUID before loading vCPU state.  E.g. multiple MSR
> flows consult guest CPUID on host writes, and KVM_SET_SREGS itself already
> relies on guest CPUID being up-to-date, as KVM's validity check on CR3
> consumes CPUID.0x7.1 (for LAM) and CPUID.0x80000008 (for MAXPHYADDR).
> 
> Furthermore, the plan is to commit to enforcing guest CPUID for userspace
> writes to MSRs, at which point bypassing sregs CPUID checks is even more
> nonsensical.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/cpuid.c | 2 +-
>  arch/x86/kvm/cpuid.h | 1 +
>  arch/x86/kvm/x86.c   | 1 +
>  3 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index f2f2be5d1141..2b19ff991ceb 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -335,7 +335,7 @@ static bool kvm_cpuid_has_hyperv(struct kvm_cpuid_entry2 *entries, int nent)
>  #endif
>  }
>  
> -static void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
> +void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_lapic *apic = vcpu->arch.apic;
>  	struct kvm_cpuid_entry2 *best;
> diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
> index 23dbb9eb277c..0a8b561b5434 100644
> --- a/arch/x86/kvm/cpuid.h
> +++ b/arch/x86/kvm/cpuid.h
> @@ -11,6 +11,7 @@
>  extern u32 kvm_cpu_caps[NR_KVM_CPU_CAPS] __read_mostly;
>  void kvm_set_cpu_caps(void);
>  
> +void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu);
>  void kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu);
>  void kvm_update_pv_runtime(struct kvm_vcpu *vcpu);
>  struct kvm_cpuid_entry2 *kvm_find_cpuid_entry_index(struct kvm_vcpu *vcpu,
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index d750546ec934..7adcf56bd45d 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -12234,6 +12234,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>  	kvm_xen_init_vcpu(vcpu);
>  	kvm_vcpu_mtrr_init(vcpu);
>  	vcpu_load(vcpu);
> +	kvm_vcpu_after_set_cpuid(vcpu);

This makes me a bit nervous. At this point the vcpu->arch.cpuid_entries is NULL,
but so is vcpu->arch.cpuid_nent so it sort of works but is one mistake away from crash.

Maybe we should add some protection to this, e.g empty zero cpuid or something like that.

Best regards,
	Maxim Levitsky


>  	kvm_set_tsc_khz(vcpu, vcpu->kvm->arch.default_tsc_khz);
>  	kvm_vcpu_reset(vcpu, false);
>  	kvm_init_mmu(vcpu);





