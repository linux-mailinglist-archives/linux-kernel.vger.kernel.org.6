Return-Path: <linux-kernel+bounces-241806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E67C927FC9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 03:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 502531C2148F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 01:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9278510A24;
	Fri,  5 Jul 2024 01:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TZmrRx1+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12413ECF
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 01:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720143145; cv=none; b=GPA6hXEzV+wj3/nnn9q+P+uSygIMP62hjhovyOYORAJW1W+9mAi3td0z0v0CepocDGyC+2T9rjruvSR/LIq96T6pFbfC7lz23fA+ztcU1bNk/iewFd5j3oUUeMTGWFuHIIJrYhxRmjzPVSFCOiTmNvDAdtgpr2t2KoeCkQQA6cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720143145; c=relaxed/simple;
	bh=294MDntDIuUDurH/toLEY0S5OjKfjE6pwjPcTWDEFnQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gqGj9vdR7gKheXgYxY6Cuhfx6rtke31p8G//nbjt20SeS+fIC8dHCTZjlIXqX/LopEYH+F832kLHLmonNFP28CCZHISOsW4dZI2Y+aE7X7QQKT2UYPf63b2tGGRGgg/UtcEqybIPbx1RYSrHUwr5mLVZLPklgUnjoSDv5ly/uFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TZmrRx1+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720143143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VqkFMx3vv9PFaSZIHQPIdIEf58ZIw0bfSQhUQJTh+jk=;
	b=TZmrRx1+DhZfeH/aDxQj6CuJD3b7axdSZfp4pK7OrDGblTQVyZH3Fw4w9hj7THPaSpiCeF
	6ldP5lHF796Th5G8kOwBLoNoHVdeioMAWseX3BN23nQp5U0+WkMOei/neDzNEpbXBkwihG
	GjGlrDy7r8mpnzR01Kkf/fnzWqM96Ok=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-6A19OFx9OIegMlo2A-fiFg-1; Thu, 04 Jul 2024 21:32:21 -0400
X-MC-Unique: 6A19OFx9OIegMlo2A-fiFg-1
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-4f29f757674so424584e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 18:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720143141; x=1720747941;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VqkFMx3vv9PFaSZIHQPIdIEf58ZIw0bfSQhUQJTh+jk=;
        b=NsC6NFfYEmBxAGXBMdBnSGiXpBqsTiIU2qQMQ7+gnhXRi/OBF0oWp1nP/2rNo0K78P
         weiJ6iU8ffkITpKoP8d5TG1DcQnemOYN1E3jVBJqou+DFy5VyafhzGy06GSu46P1F6b6
         fSJV2dO7vNPQ3WN5/3qqsYdJzEYq5V5q9FRvxnuGmi/eRrcyG1WmcfmA9wNKwLDvBH8l
         3J/+hRWKgbp4Hsg0QjsjOxyeG94MH+ZOd8S3MwRtIK0eq8TjnIo7j1Wtr3/HwKhdPnMI
         nOXZNRfyG5r63j6UQuAQ5dWW6mMM1Q7kDbSoNxar1nfQFJCCri45H3igWQh2PmMY2Spr
         +eqA==
X-Forwarded-Encrypted: i=1; AJvYcCWE++JdEXzju52MLMXusxJF2r1J1zjAHfcPAm+3vNDzvsZ1XAQK5fVV9vtNHGPni0zxLBM5r7edvCJ5Q9KfQsA91OmFcukICrNAvwaQ
X-Gm-Message-State: AOJu0YwvF1b2zxoyWE/3Jq0S7Q5iu86g1kns3vuPyh8QyFa6V4yDnNtk
	KoIiNw/RNnSRwRao0h29u3vbI02bJer9G+HwdcuGVspP9KvboMJ49K6Cv9/SdOlqByHE3EeaWAF
	OsnWbo89VnuksoJHxaxhxFBghXXKKhivvKSwjtGSB5GNl8yufVuUrnd+LPdQS4w==
X-Received: by 2002:a05:6122:3887:b0:4ec:f8e4:e0bf with SMTP id 71dfb90a1353d-4f2f3e9b4a4mr3833197e0c.2.1720143141316;
        Thu, 04 Jul 2024 18:32:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFARe/SiYNaNtEGOJUOSPqaxtIG7Qze5P6uKrBblBXT6tk6utSfrbTbhQMxQvCDCfD6zHfv1w==
X-Received: by 2002:a05:6122:3887:b0:4ec:f8e4:e0bf with SMTP id 71dfb90a1353d-4f2f3e9b4a4mr3833176e0c.2.1720143140910;
        Thu, 04 Jul 2024 18:32:20 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-446513d3601sm64975961cf.17.2024.07.04.18.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 18:32:20 -0700 (PDT)
Message-ID: <376d0c37d0cf4d578fe13be6f2b3599a694040af.camel@redhat.com>
Subject: Re: [PATCH v2 27/49] KVM: x86: Swap incoming guest CPUID into vCPU
 before massaging in KVM_SET_CPUID2
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Hou Wenlong
 <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, Oliver Upton
 <oliver.upton@linux.dev>, Binbin Wu <binbin.wu@linux.intel.com>, Yang
 Weijiang <weijiang.yang@intel.com>, Robert Hoo <robert.hoo.linux@gmail.com>
Date: Thu, 04 Jul 2024 21:32:19 -0400
In-Reply-To: <20240517173926.965351-28-seanjc@google.com>
References: <20240517173926.965351-1-seanjc@google.com>
	 <20240517173926.965351-28-seanjc@google.com>
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
> When handling KVM_SET_CPUID{,2}, swap the old and new CPUID arrays and
> lengths before processing the new CPUID, and simply undo the swap if
> setting the new CPUID fails for whatever reason.
> 
> To keep the diff reasonable, continue passing the entry array and length
> to most helpers, and defer the more complete cleanup to future commits.
> 
> For any sane VMM, setting "bad" CPUID state is not a hot path (or even
> something that is surviable), and setting guest CPUID before it's known
> good will allow removing all of KVM's infrastructure for processing CPUID
> entries directly (as opposed to operating on vcpu->arch.cpuid_entries).
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/cpuid.c | 49 +++++++++++++++++++++++++++-----------------
>  1 file changed, 30 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 33e3e77de1b7..4ad01867cb8d 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -175,10 +175,10 @@ static inline struct kvm_cpuid_entry2 *cpuid_entry2_find(
>  	return NULL;
>  }
>  
> -static int kvm_check_cpuid(struct kvm_vcpu *vcpu,
> -			   struct kvm_cpuid_entry2 *entries,
> -			   int nent)
> +static int kvm_check_cpuid(struct kvm_vcpu *vcpu)
>  {
> +	struct kvm_cpuid_entry2 *entries = vcpu->arch.cpuid_entries;
> +	int nent = vcpu->arch.cpuid_nent;
>  	struct kvm_cpuid_entry2 *best;
>  	u64 xfeatures;
>  
> @@ -369,9 +369,11 @@ void kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu)
>  }
>  EXPORT_SYMBOL_GPL(kvm_update_cpuid_runtime);
>  
> -static bool kvm_cpuid_has_hyperv(struct kvm_cpuid_entry2 *entries, int nent)
> +static bool kvm_cpuid_has_hyperv(struct kvm_vcpu *vcpu)
>  {
>  #ifdef CONFIG_KVM_HYPERV
> +	struct kvm_cpuid_entry2 *entries = vcpu->arch.cpuid_entries;
> +	int nent = vcpu->arch.cpuid_nent;
>  	struct kvm_cpuid_entry2 *entry;
>  
>  	entry = cpuid_entry2_find(entries, nent, HYPERV_CPUID_INTERFACE,
> @@ -436,8 +438,7 @@ void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>  					 __cr4_reserved_bits(guest_cpuid_has, vcpu);
>  #undef __kvm_cpu_cap_has
>  
> -	kvm_hv_set_cpuid(vcpu, kvm_cpuid_has_hyperv(vcpu->arch.cpuid_entries,
> -						    vcpu->arch.cpuid_nent));
> +	kvm_hv_set_cpuid(vcpu, kvm_cpuid_has_hyperv(vcpu));
>  
>  	/* Invoke the vendor callback only after the above state is updated. */
>  	static_call(kvm_x86_vcpu_after_set_cpuid)(vcpu);
> @@ -478,6 +479,15 @@ static int kvm_set_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
>  {
>  	int r;
>  
> +	/*
> +	 * Swap the existing (old) entries with the incoming (new) entries in
> +	 * order to massage the new entries, e.g. to account for dynamic bits
> +	 * that KVM controls, without clobbering the current guest CPUID, which
> +	 * KVM needs to preserve in order to unwind on failure.
> +	 */
> +	swap(vcpu->arch.cpuid_entries, e2);
> +	swap(vcpu->arch.cpuid_nent, nent);
> +
>  	/*
>  	 * KVM does not correctly handle changing guest CPUID after KVM_RUN, as
>  	 * MAXPHYADDR, GBPAGES support, AMD reserved bit behavior, etc.. aren't
> @@ -497,31 +507,25 @@ static int kvm_set_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
>  		 * only because any change in CPUID is disallowed, i.e. using
>  		 * stale data is ok because KVM will reject the change.
>  		 */
> -		__kvm_update_cpuid_runtime(vcpu, e2, nent);
> +		kvm_update_cpuid_runtime(vcpu);
>  
>  		r = kvm_cpuid_check_equal(vcpu, e2, nent);
>  		if (r)
> -			return r;
> -
> -		kvfree(e2);
> -		return 0;
> +			goto err;
> +		goto success;
>  	}
>  
>  #ifdef CONFIG_KVM_HYPERV
> -	if (kvm_cpuid_has_hyperv(e2, nent)) {
> +	if (kvm_cpuid_has_hyperv(vcpu)) {
>  		r = kvm_hv_vcpu_init(vcpu);
>  		if (r)
> -			return r;
> +			goto err;
>  	}
>  #endif
>  
> -	r = kvm_check_cpuid(vcpu, e2, nent);
> +	r = kvm_check_cpuid(vcpu);
>  	if (r)
> -		return r;
> -
> -	kvfree(vcpu->arch.cpuid_entries);
> -	vcpu->arch.cpuid_entries = e2;
> -	vcpu->arch.cpuid_nent = nent;
> +		goto err;
>  
>  	vcpu->arch.kvm_cpuid = kvm_get_hypervisor_cpuid(vcpu, KVM_SIGNATURE);
>  #ifdef CONFIG_KVM_XEN
> @@ -529,7 +533,14 @@ static int kvm_set_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
>  #endif
>  	kvm_vcpu_after_set_cpuid(vcpu);
>  
> +success:
> +	kvfree(e2);
>  	return 0;
> +
> +err:
> +	swap(vcpu->arch.cpuid_entries, e2);
> +	swap(vcpu->arch.cpuid_nent, nent);
> +	return r;
>  }
>  
>  /* when an old userspace process fills a new kernel module */

Hi,

This IMHO is a good idea. You might consider moving this patch to the beginning of the patch series though,
it will make more sense with the rest of the patches there.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky



