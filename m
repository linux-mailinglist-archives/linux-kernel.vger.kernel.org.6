Return-Path: <linux-kernel+bounces-241825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 447AF928001
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 04:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 746981C21186
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 02:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C186134DE;
	Fri,  5 Jul 2024 02:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZOw+XtJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A6179EF
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 02:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720145064; cv=none; b=gBwBIjNwxswNR1wFsE5Xjz/mfOZraDllX2e/XCRDkXWF+b01R1N4MqRQjC2f+7qaI4MDuJnpKc6rAx/8BU07hzClySRq9I38y0iNmnwpeWUVo6BR4zoCjfLRkUKLOMbGLwlqRREmGNz8nnmVCTmw3BdfOP5+2Z5ae79M75mmuvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720145064; c=relaxed/simple;
	bh=5sxmntopPiro+dAs2d7Dodq7BAt/c25oh/tvEL5NMD4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PEo3zelghQjz6TOVmvte2daP/PD7WlzW8Eop8dAOTt6gWqDVg5DpoNXrw8SK9H9cAftl06AUtSq+LkCIInjtQTbf/xf67A0JzilkgkkYl0dU0V/1DYMSPL2kMtwJ8G1UBfrJx6Kz2He2WkiFgN6DxSu0gyc3s4f66wZ6gFmVO48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iZOw+XtJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720145061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aowq2gEnaeA5ddl8aoPNqVlKxWrjgZgHM1kmUUIcA0A=;
	b=iZOw+XtJP0Jv7KPm+f7cD1Wb7imZSddARq7L9wFhDLxcvFqrbdvH0qFjdgIpql7/wxyZmd
	kLvb29fQRhYfDXYoq/6ZSa0C5/PCoLjRbjD3w4+J/ePuy2ltp5TOgXD9h3ovWtgvzVx/60
	j6PEEM1Hp25GKtz4gjdzHH9B25XmiDk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-oM7dpwCVMgmvsq4v1EFsTA-1; Thu, 04 Jul 2024 22:04:20 -0400
X-MC-Unique: oM7dpwCVMgmvsq4v1EFsTA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-79d5d9b24a7so146016285a.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 19:04:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720145059; x=1720749859;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Aowq2gEnaeA5ddl8aoPNqVlKxWrjgZgHM1kmUUIcA0A=;
        b=O0Q0GnKvyruI5+aV92oqI1GH31chbQSRcSTWKyqkveOJ+md5MNEmTrlGGFrV42/01a
         XbHP5NfoE+abE1bFxpGGeHAD+vsqaj824NedYnaQhaQEObuhfHqlMTZ3M5VzodtpD6l2
         f7UG/zmvRWGbMxcQvCbOUfZGfmPGWQSUKI4Z19qdU9DKQdg3NukQBnw2HAuBPIiW/k3n
         CHeMnrEdvhHLLeHP+m4ya3NbEO2/M24JFfKBfMx+EEwOzmCGXHfMtfbBhfijeFhnzK+v
         quGbRGvHx/lUvny/pz06diIWqs037fzQ0Q7gi5xCYh7KaRVj7vSqp6P93kNSLC4RHoUI
         CQmA==
X-Forwarded-Encrypted: i=1; AJvYcCVnO6hlmmnyxbkyV8D4RwBRpcx2LoUjnivWuTFatwLlSoqRCs9q97d4QwOOew64YZKSyLl4KEUuo2lfiLVkp0uE3aGUCfiiyK2BThAj
X-Gm-Message-State: AOJu0YySGN9ctju6Ik+KN53zvMksdpJpJh/RP4P79ZQ8ib8VtfvWI+j+
	mcqPKxX4cg/QXesL2v3upc7zbtqHXq4N+56jwYlbf+0OmPz8hNTdH+0o1vEDjYzrTG5Ie5rNPRp
	NLCpo7erblYHqzpmHuc0ilud65jsP4DQrRxs6zlKUS3tnm6dppIJc9l8KHRfR8SHPFrAZiw==
X-Received: by 2002:a05:620a:294b:b0:79d:58ac:9168 with SMTP id af79cd13be357-79eee2ace83mr407929785a.67.1720145059584;
        Thu, 04 Jul 2024 19:04:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFM9rxjElwrzqkT3+9N9Tjrxb8rLoVUarUDB11vtraE1M7t24/rqloulV7k9L5NynHbiUoag==
X-Received: by 2002:a05:620a:294b:b0:79d:58ac:9168 with SMTP id af79cd13be357-79eee2ace83mr407927585a.67.1720145059193;
        Thu, 04 Jul 2024 19:04:19 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d6925f58esm726668485a.12.2024.07.04.19.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 19:04:18 -0700 (PDT)
Message-ID: <924352564a5ab003b85bf7e2ee422907f9951e26.camel@redhat.com>
Subject: Re: [PATCH v2 33/49] KVM: x86: Advertise TSC_DEADLINE_TIMER in
 KVM_GET_SUPPORTED_CPUID
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Hou Wenlong
 <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, Oliver Upton
 <oliver.upton@linux.dev>, Binbin Wu <binbin.wu@linux.intel.com>, Yang
 Weijiang <weijiang.yang@intel.com>, Robert Hoo <robert.hoo.linux@gmail.com>
Date: Thu, 04 Jul 2024 22:04:18 -0400
In-Reply-To: <20240517173926.965351-34-seanjc@google.com>
References: <20240517173926.965351-1-seanjc@google.com>
	 <20240517173926.965351-34-seanjc@google.com>
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
> Advertise TSC_DEADLINE_TIMER via KVM_GET_SUPPORTED_CPUID when it's
> supported in hardware, as the odds of a VMM emulating the local APIC in
> userspace, not emulating the TSC deadline timer, _and_ reflecting
> KVM_GET_SUPPORTED_CPUID back into KVM_SET_CPUID2 are extremely low.
> 
> KVM has _unconditionally_ advertised X2APIC via CPUID since commit
> 0d1de2d901f4 ("KVM: Always report x2apic as supported feature"), and it
> is completely impossible for userspace to emulate X2APIC as KVM doesn't
> support forwarding the MSR accesses to userspace.  I.e. KVM has relied on
> userspace VMMs to not misreport local APIC capabilities for nearly 13
> years.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  Documentation/virt/kvm/api.rst | 9 ++++++---
>  arch/x86/kvm/cpuid.c           | 4 ++--
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 884846282d06..cb744a646de6 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -1804,15 +1804,18 @@ emulate them efficiently. The fields in each entry are defined as follows:
>           the values returned by the cpuid instruction for
>           this function/index combination
>  
> -The TSC deadline timer feature (CPUID leaf 1, ecx[24]) is always returned
> -as false, since the feature depends on KVM_CREATE_IRQCHIP for local APIC
> -support.  Instead it is reported via::
> +x2APIC (CPUID leaf 1, ecx[21) and TSC deadline timer (CPUID leaf 1, ecx[24])
> +may be returned as true, but they depend on KVM_CREATE_IRQCHIP for in-kernel
> +emulation of the local APIC.  TSC deadline timer support is also reported via::
>  
>    ioctl(KVM_CHECK_EXTENSION, KVM_CAP_TSC_DEADLINE_TIMER)
>  
>  if that returns true and you use KVM_CREATE_IRQCHIP, or if you emulate the
>  feature in userspace, then you can enable the feature for KVM_SET_CPUID2.
>  
> +Enabling x2APIC in KVM_SET_CPUID2 requires KVM_CREATE_IRQCHIP as KVM doesn't
> +support forwarding x2APIC MSR accesses to userspace, i.e. KVM does not support
> +emulating x2APIC in userspace.
>  
>  4.47 KVM_PPC_GET_PVINFO
>  -----------------------
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 699ce4261e9c..d1f427284ccc 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -680,8 +680,8 @@ void kvm_set_cpu_caps(void)
>  		F(FMA) | F(CX16) | 0 /* xTPR Update */ | F(PDCM) |
>  		F(PCID) | 0 /* Reserved, DCA */ | F(XMM4_1) |
>  		F(XMM4_2) | EMUL_F(X2APIC) | F(MOVBE) | F(POPCNT) |
> -		0 /* Reserved*/ | F(AES) | F(XSAVE) | 0 /* OSXSAVE */ | F(AVX) |
> -		F(F16C) | F(RDRAND)
> +		EMUL_F(TSC_DEADLINE_TIMER) | F(AES) | F(XSAVE) |
> +		0 /* OSXSAVE */ | F(AVX) | F(F16C) | F(RDRAND)
>  	);
>  
>  	kvm_cpu_cap_init(CPUID_1_EDX,

Hi,

I have a mixed feeling about this.

First of all KVM_GET_SUPPORTED_CPUID documentation explicitly states that it returns bits
that are supported in *default* configuration
TSC_DEADLINE_TIMER and arguably X2APIC are only supported after enabling various caps,
e.g not default configuration.

However, since X2APIC also in KVM_GET_SUPPORTED_CPUID (also wrongly IMHO), for consistency it does make
sense to add TSC_DEADLINE_TIMER as well.


I do think that we need at least to update the documentation of KVM_GET_SUPPORTED_CPUID
and KVM_GET_EMULATED_CPUID, as I state in a review of a later patch.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky




