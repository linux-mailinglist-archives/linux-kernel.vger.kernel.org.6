Return-Path: <linux-kernel+bounces-241815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79427927FE0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 03:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9CF31F233C3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 01:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D1214AB2;
	Fri,  5 Jul 2024 01:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OukcECRJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A171AF9C9
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 01:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720144287; cv=none; b=gAZPqof/bmLWOCE4qm8yedZfYGkshoN+kb965azXqlkmMISZbBoGAo/cIM78UAcERumKgmWBuqp/RMiN80DDUicMj22Utso51LleJGLgjcKdVfPvjoao+uxSAu2HCFrTgLDMLjcstpajYIVfZC7tSNS6QcfFrOKdpb2UXc99aHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720144287; c=relaxed/simple;
	bh=XjZ6pzcNFCoUGcDXnFbuUhEjP1A33bOYiKVrZYpuewE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q2w3miDDJPU6+0foAkK3t9bH+UdFlTA4U0QYBvFTJEpHZ/FdDmlI9+srrnso7x1QijBL8icnabG86h7xEyGvPRedkrjVCsfDYWKl5bGTqEiy5Uq5znHK07f4BzN4Edr31Ng5KkgxDPHrSoi4gpHY5NvxFdNHuLGFW7g2MbZ+cKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OukcECRJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720144283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D8vSsoNcZobrbM8hAcvriCyP9iuCpBhlHA1LnqmlgdY=;
	b=OukcECRJKJiRnusX2tqIpteDREuh7r2JmjoPf/XVPSISxOTm0+D3mhyS5TZxdDD0Xts8uf
	qDbM/FkCCw7l5MQRfQUMDcBy/XaJXYh1C8bnihG8t/iES+aUBCDbU6gXuQuv9HNJ2G4yL8
	00e5KhOrBRbfwNXvNpbG9yW91v0xlOc=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-nnDFJobnPN6mcDOhVj907Q-1; Thu, 04 Jul 2024 21:51:22 -0400
X-MC-Unique: nnDFJobnPN6mcDOhVj907Q-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-64b2a73ad0bso19506787b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 18:51:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720144281; x=1720749081;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D8vSsoNcZobrbM8hAcvriCyP9iuCpBhlHA1LnqmlgdY=;
        b=TPfeb3i0ZmhLPYbq17/H3zvea5YkMCxLtR8RSExM9p4DzLB3d71d5DulDWD5koY4W4
         40/cCZXe59ESIJVn7W6Z8u8vSwFBxVu4TV4sYK/SPI5oaTfG4+ecZ62dvAMoX7qSH4L/
         3phZDvOIGJVkrcxqrIHOe5gFo211J2YSwL7vUJL6MXsZDi0XeXPPJ/ChEQChXp/L68TL
         5O65+MXZ+XipceNu0JHVGgy486qd9HsvfEHJdahemoBKf5Ptu0cQeLf0YbZG/BFAWDAS
         ABzc6xYVurqGYE9DCs60CWsckX3LF1Ryl+3l7Nnso2DTDefThk4dbGvBVxX2eW7BEZuS
         4G9g==
X-Forwarded-Encrypted: i=1; AJvYcCWYcR78najrgbBJ3U82O/qqgjBLdb3MSa3Q1RHQ1y4kjrdU+OkSxVAsgqg93q+gLHyZwgy399bmE0bNw/sqVflTn32RVSegt1Z0YelC
X-Gm-Message-State: AOJu0YxG8u0nxQg3XUOCnWM8W+UrGjqLVs2Yd3L58B0oL9wS0+7LaywD
	8GlY6CXoy86z92X9kbfgD5SiBl3EPAYff3Xn1IH+iDj5cOt2dNki+Sm4qbYFafG15vWlLOc16/L
	wRI/8XuTm1v5OOtGeQyL6PuMfBtW7Umi0MseSkT3cuG/2v05kzqiNi31oZhwuVA==
X-Received: by 2002:a81:848b:0:b0:650:9c5e:f6e2 with SMTP id 00721157ae682-652d7a681aamr31530587b3.34.1720144281588;
        Thu, 04 Jul 2024 18:51:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVKeur05z/2xhfRybr6qg4xeivBpl+zDXHx77mYCfXbQjJDPrbdraw5f6BWGFb30Jr2VeJ+g==
X-Received: by 2002:a81:848b:0:b0:650:9c5e:f6e2 with SMTP id 00721157ae682-652d7a681aamr31530457b3.34.1720144281274;
        Thu, 04 Jul 2024 18:51:21 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d81e66bf9sm564515685a.45.2024.07.04.18.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 18:51:21 -0700 (PDT)
Message-ID: <5b747a9dacb0ead3d16c71192df8a61e8545d0e6.camel@redhat.com>
Subject: Re: [PATCH v2 29/49] KVM: x86: Remove unnecessary caching of KVM's
 PV CPUID base
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Hou Wenlong
 <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, Oliver Upton
 <oliver.upton@linux.dev>, Binbin Wu <binbin.wu@linux.intel.com>, Yang
 Weijiang <weijiang.yang@intel.com>, Robert Hoo <robert.hoo.linux@gmail.com>
Date: Thu, 04 Jul 2024 21:51:19 -0400
In-Reply-To: <20240517173926.965351-30-seanjc@google.com>
References: <20240517173926.965351-1-seanjc@google.com>
	 <20240517173926.965351-30-seanjc@google.com>
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
> Now that KVM only searches for KVM's PV CPUID base when userspace sets
> guest CPUID, drop the cache and simply do the search every time.
> 
> Practically speaking, this is a nop except for situations where userspace
> sets CPUID _after_ running the vCPU, which is anything but a hot path,
> e.g. QEMU does so only when hotplugging a vCPU.  And on the flip side,
> caching guest CPUID information, especially information that is used to
> query/modify _other_ CPUID state, is inherently dangerous as it's all too
> easy to use stale information, i.e. KVM should only cache CPUID state when
> the performance and/or programming benefits justify it.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  1 -
>  arch/x86/kvm/cpuid.c            | 34 +++++++--------------------------
>  2 files changed, 7 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index aabf1648a56a..3003e99155e7 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -858,7 +858,6 @@ struct kvm_vcpu_arch {
>  
>  	int cpuid_nent;
>  	struct kvm_cpuid_entry2 *cpuid_entries;
> -	struct kvm_hypervisor_cpuid kvm_cpuid;
>  	bool is_amd_compatible;
>  
>  	/*
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 93a7399dc0db..7290f91c422c 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -269,28 +269,16 @@ static struct kvm_hypervisor_cpuid kvm_get_hypervisor_cpuid(struct kvm_vcpu *vcp
>  					  vcpu->arch.cpuid_nent, sig);
>  }
>  
> -static struct kvm_cpuid_entry2 *__kvm_find_kvm_cpuid_features(struct kvm_cpuid_entry2 *entries,
> -							      int nent, u32 kvm_cpuid_base)
> -{
> -	return cpuid_entry2_find(entries, nent, kvm_cpuid_base | KVM_CPUID_FEATURES,
> -				 KVM_CPUID_INDEX_NOT_SIGNIFICANT);
> -}
> -
> -static struct kvm_cpuid_entry2 *kvm_find_kvm_cpuid_features(struct kvm_vcpu *vcpu)
> -{
> -	u32 base = vcpu->arch.kvm_cpuid.base;
> -
> -	if (!base)
> -		return NULL;
> -
> -	return __kvm_find_kvm_cpuid_features(vcpu->arch.cpuid_entries,
> -					     vcpu->arch.cpuid_nent, base);
> -}
> -
>  static u32 kvm_apply_cpuid_pv_features_quirk(struct kvm_vcpu *vcpu)
>  {
> -	struct kvm_cpuid_entry2 *best = kvm_find_kvm_cpuid_features(vcpu);
> +	struct kvm_hypervisor_cpuid kvm_cpuid;
> +	struct kvm_cpuid_entry2 *best;
>  
> +	kvm_cpuid = kvm_get_hypervisor_cpuid(vcpu, KVM_SIGNATURE);
> +	if (!kvm_cpuid.base)
> +		return 0;
> +
> +	best = kvm_find_cpuid_entry(vcpu, kvm_cpuid.base | KVM_CPUID_FEATURES);
>  	if (!best)
>  		return 0;
>  
> @@ -491,13 +479,6 @@ static int kvm_set_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
>  	 * whether the supplied CPUID data is equal to what's already set.
>  	 */
>  	if (kvm_vcpu_has_run(vcpu)) {
> -		/*
> -		 * Note, runtime CPUID updates may consume other CPUID-driven
> -		 * vCPU state, e.g. KVM or Xen CPUID bases.  Updating runtime
> -		 * state before full CPUID processing is functionally correct
> -		 * only because any change in CPUID is disallowed, i.e. using
> -		 * stale data is ok because KVM will reject the change.
> -		 */
Hi,

Any reason why this comment was removed? As I said earlier in the review.
It might make sense to replace this comment with a comment reflecting on why
we need to call kvm_update_cpuid_runtime, that is solely to allow old == new
compare to succeed.

>  		kvm_update_cpuid_runtime(vcpu);
>  		kvm_apply_cpuid_pv_features_quirk(vcpu);
>  
> @@ -519,7 +500,6 @@ static int kvm_set_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
>  	if (r)
>  		goto err;
>  
> -	vcpu->arch.kvm_cpuid = kvm_get_hypervisor_cpuid(vcpu, KVM_SIGNATURE);
>  #ifdef CONFIG_KVM_XEN
>  	vcpu->arch.xen.cpuid = kvm_get_hypervisor_cpuid(vcpu, XEN_SIGNATURE);
>  #endif



Best regards,
	Maxim Levitsky


