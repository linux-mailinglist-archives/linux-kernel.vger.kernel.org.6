Return-Path: <linux-kernel+bounces-241858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6A292805D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 04:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAAAD1C23BAE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 02:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B88614292;
	Fri,  5 Jul 2024 02:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eBFgZiam"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B611C6A0
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 02:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720146158; cv=none; b=I0VxXU5qdJKnf3+MxR9YYf4muuY/35yCe/2jYJYM97R8tcZjO5L6x+ktQDM53C6XSBvTdwodwyt4AGcAIFUIbFhA5l8xLHip36juXVqkEiFyafXcboNlOVfC5Ay2KZRDjocRnqitOkdFszuhhyVeY9rjmgTYQAtSlMYb1v53v3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720146158; c=relaxed/simple;
	bh=iP4PTnc+JwqINZP62JEJfVsRzgiEnD/hVYcU9FxHyW0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tnQsV3DRuEI4an+LjFrmfDGCyaKkS2pfZxvNsB09Q0yJ/md2pkWdxYwOP3GKiyscSzH2Zvr6gZC7mBnq/pLn97mg2Q/+21/JagZ8tZon86PbB3F7FB7rIu3xk1bFUQtbaooWmI6qkIURoI+koP/ny7o9WtdQoNmJ6tNk/79RkFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eBFgZiam; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720146156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q7szSx4tLcUjlj9JqAzakCICbYrgWRQ4USIrs5Qy/W0=;
	b=eBFgZiamhpXHAxuN4Uj9ZA3bZa7KYm2S8f5r3w6aDInt5j3vF8krgWis9I09Nq3l+dQLGJ
	Rj1zX1axlfGMdOe+9naBNaiyM3XZa+LBgP15p6uPqzXewSjjwJQwlHFwplip8ymUjdTYW5
	Ys5rZP+/uovJDGmWijCZpseZPKgCElk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-67rASjbpNMKARgmtiYSz6A-1; Thu, 04 Jul 2024 22:22:35 -0400
X-MC-Unique: 67rASjbpNMKARgmtiYSz6A-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6b5de5ae24cso13423316d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 19:22:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720146154; x=1720750954;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q7szSx4tLcUjlj9JqAzakCICbYrgWRQ4USIrs5Qy/W0=;
        b=o/rnspWEQOVDooH3JyM0482kOyW0AyQriF/dbEi3MBpDuZVzZeaB5fzjGP83VCJSrL
         6TB19IZzg2ETLE+lMJbjvsqzovIRJekbpy81Y9ZRoZT7cWBI7Y5a2pKzKJJT4nLxGFW3
         7ti8x3GvrBZgHoA5HxNq8oJnoasgu1Rl3dDUSR9dTyUj02DeD0f06KYEApmv9llBLN8O
         TzavxWZeobZaP+X95umH4WMqCqi0oaHS5EoaqKjNe0MSM+xXR/3kppMmSGssI1pSbvtF
         2A6pmsrTkuhq4MDv9Bz7AFnr7lenfMk56IvCYc/lLxPHHoYkE6nUvWvCVrRCRGh+xIiP
         2zMw==
X-Forwarded-Encrypted: i=1; AJvYcCW8XVjmehjULbYyFUEEhiAzUbLzYY11n2BVtwlv10jIABQAxpxsOyrQLoQPEy4GLwliOKZYYSMz1NyGM8x6QT3//PO09ca+uEsUCRw2
X-Gm-Message-State: AOJu0Yy/2qXqKV4IKvqp5ERwX4JXexVUCe4ksJd0rpktBEedWQ/PMl17
	2d6/YKTITcIyDYtsWndpfIuU99gud/TxK87XSHcivF17dxUyusz6g+8I6u6HcnTA8Augi9LvKeP
	6j7N+49fmyGD1tqmCfGHxI2XR58jXBNkJpRcY72OWzHCTwIPG+dq7tKXEWLDFsQ==
X-Received: by 2002:ad4:5c41:0:b0:6b5:e006:11ae with SMTP id 6a1803df08f44-6b5ecfa7b1amr47128686d6.22.1720146154664;
        Thu, 04 Jul 2024 19:22:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4kbA/ede2RPQS5+pjM2192rg6QuAOX6Y2+jKIqVrkNbdROoUJYoeZzed5aZNbNVR6IXzYfg==
X-Received: by 2002:ad4:5c41:0:b0:6b5:e006:11ae with SMTP id 6a1803df08f44-6b5ecfa7b1amr47128396d6.22.1720146154383;
        Thu, 04 Jul 2024 19:22:34 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e564455sm68955926d6.42.2024.07.04.19.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 19:22:34 -0700 (PDT)
Message-ID: <d51310e1a43a1310f8b910f0a2fd7ef0ba886e4a.camel@redhat.com>
Subject: Re: [PATCH v2 43/49] KVM: x86: Update OS{XSAVE,PKE} bits in guest
 CPUID irrespective of host support
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Hou Wenlong
 <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, Oliver Upton
 <oliver.upton@linux.dev>, Binbin Wu <binbin.wu@linux.intel.com>, Yang
 Weijiang <weijiang.yang@intel.com>, Robert Hoo <robert.hoo.linux@gmail.com>
Date: Thu, 04 Jul 2024 22:22:33 -0400
In-Reply-To: <20240517173926.965351-44-seanjc@google.com>
References: <20240517173926.965351-1-seanjc@google.com>
	 <20240517173926.965351-44-seanjc@google.com>
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
> When making runtime CPUID updates, change OSXSAVE and OSPKE even if their
> respective base features (XSAVE, PKU) are not supported by the host.  KVM
> already incorporates host support in the vCPU's effective reserved CR4 bits.
> I.e. OSXSAVE and OSPKE can be set if and only if the host supports them.
> 
> And conversely, since KVM's ABI is that KVM owns the dynamic OS feature
> flags, clearing them when they obviously aren't supported and thus can't
> be enabled is arguably a fix.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/cpuid.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 8256fc657c6b..552e65ba5efa 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -336,10 +336,8 @@ void kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu)
>  
>  	best = kvm_find_cpuid_entry(vcpu, 1);
>  	if (best) {
> -		/* Update OSXSAVE bit */
> -		if (boot_cpu_has(X86_FEATURE_XSAVE))
> -			cpuid_entry_change(best, X86_FEATURE_OSXSAVE,
> -					   kvm_is_cr4_bit_set(vcpu, X86_CR4_OSXSAVE));
> +		cpuid_entry_change(best, X86_FEATURE_OSXSAVE,
> +				   kvm_is_cr4_bit_set(vcpu, X86_CR4_OSXSAVE));
>  
>  		cpuid_entry_change(best, X86_FEATURE_APIC,
>  			   vcpu->arch.apic_base & MSR_IA32_APICBASE_ENABLE);
> @@ -351,7 +349,7 @@ void kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu)
>  	}
>  
>  	best = kvm_find_cpuid_entry_index(vcpu, 7, 0);
> -	if (best && boot_cpu_has(X86_FEATURE_PKU))
> +	if (best)
>  		cpuid_entry_change(best, X86_FEATURE_OSPKE,
>  				   kvm_is_cr4_bit_set(vcpu, X86_CR4_PKE));
>  

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


