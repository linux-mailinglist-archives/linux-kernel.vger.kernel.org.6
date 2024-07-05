Return-Path: <linux-kernel+bounces-241817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8032927FE4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 03:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55E7F286150
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 01:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7453E1BC43;
	Fri,  5 Jul 2024 01:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dkfMX5Vh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210CF175BE
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 01:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720144320; cv=none; b=m6XPhEaAFN/nJKE2Flwat+tSKFTZOyPCaANK/vfGM+DUY22PTaKHPJUbLWs0f8J9WrC0y5jtCGh44Z/MmsCXwS+A6k4mWKCPw/LetU0lDzTtGHDh9Cm7ca5Pf17drXhiOeEzX7ni0fcKCGgwcfIZ/yga+JKaIznb2GuZkK7f34Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720144320; c=relaxed/simple;
	bh=y1K4/3AKQIY1iPO1F45D2kPBpwd9iasJJv/d3MHXoC0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Asbf9ZqYx9A63qEYf+jdk7n7RVXZwVR9urnXEoJ04iWFKOvGeGSRttDRZw8h3zFq9LSPw83wLLurlpO8W6B2aUx2bl2HyqXFgYLzcm3YJyJQaFDyy4lA7Y0mpZs4kIEh11FLAP1HHT0Dh7BFUUsEcSZ6dEdAp88qnaqRq3wiu/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dkfMX5Vh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720144318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QFEmqM2S4F/fr7Hr4LR2lKfwp8vGDXOGQYSAfcHtT6w=;
	b=dkfMX5VhBFYedHGQVyYONivME3yxsbgumKxlUN5IUvrgUrykYZuZTwjdVfh4+2oZw1Ii6J
	Ywi5EPx8qsL5v+fyI3Iy0PjBLSVghaNPUegjtfUQX2M2cB9Mn3Z3Chg8jY4O3ubUR/H4ol
	K+cNJYzDo1a/ihc4huuoZq5DUrUUEmU=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-ACSxR377MzaNiyj4pjYVRA-1; Thu, 04 Jul 2024 21:51:56 -0400
X-MC-Unique: ACSxR377MzaNiyj4pjYVRA-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-6533680c788so14336007b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 18:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720144315; x=1720749115;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QFEmqM2S4F/fr7Hr4LR2lKfwp8vGDXOGQYSAfcHtT6w=;
        b=URJ8Nsjk4/GmvvwbRQnKewDK7GI1VzAVSB1ltuV0HcYnij22PUPKpVxJFeoE35/Q2d
         RhOuayAmlPaEnqtG02xAMZSTTbF7bWJUPlYiPFL7BQV8Sr9WujAz0qivbu7yE0mgZSGA
         q0NZBTAntOqsnYmSyLL61WDnX4rDHYGFfzUgXuvID846I/piq4NUm/24bBAaxY+tZllm
         Xr7iP+4XPkox0JhwB+O5mUS4507IeB8cA+/M3cr7MSNFmLfNogw1z56nUzyqeTEGNXJe
         Iok/aNvO+Oyy8CfQzrb3aWZqtN5sx7Ijpsg+L6UmRmK1LmvRvQFMB6Qnj+o9Gk45lBF5
         9eZg==
X-Forwarded-Encrypted: i=1; AJvYcCUCOvA9/2wwf7XJz9nb328f8FSiiBtMJ4daUHMdDsFenD6wTQpWtofrcdzHDzSG7tG2KP9eS4cL4ncCtoqrZVfJH21ohQb5epA1EnvN
X-Gm-Message-State: AOJu0Yy8S33TzhOQp7Y1+9ZhFUtRgjdLNZC5deIEfsJF7el31aMkTX6U
	9R0zWqG7G6Ibjr3z/G7JMnXs85lymv6cEwhFkyN6uYKpHHH8XNSrr1QYGJkSYxf27lJ52Pre3z7
	yaPxllqZHoZKFUllEzWxe+GImM0iOhYm2tqbjFxAGpcNu1nEumyakR2/ZLn1ltQ==
X-Received: by 2002:a05:690c:6481:b0:632:b827:a1ba with SMTP id 00721157ae682-654438ce637mr659577b3.7.1720144315709;
        Thu, 04 Jul 2024 18:51:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLE2ITBPr5VAyC3YxZL1I18Xb7Cnl3jcQL4lU5olrNVVDhEPiC780t3ElTIHFx6pImkg7hlg==
X-Received: by 2002:a05:690c:6481:b0:632:b827:a1ba with SMTP id 00721157ae682-654438ce637mr659437b3.7.1720144315430;
        Thu, 04 Jul 2024 18:51:55 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d692613e0sm728418085a.9.2024.07.04.18.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 18:51:55 -0700 (PDT)
Message-ID: <4d8731a21b3a040b92f862efd7032b1823f11235.camel@redhat.com>
Subject: Re: [PATCH v2 31/49] KVM: x86: Move kvm_find_cpuid_entry{,_index}()
 up near cpuid_entry2_find()
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Hou Wenlong
 <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, Oliver Upton
 <oliver.upton@linux.dev>, Binbin Wu <binbin.wu@linux.intel.com>, Yang
 Weijiang <weijiang.yang@intel.com>, Robert Hoo <robert.hoo.linux@gmail.com>
Date: Thu, 04 Jul 2024 21:51:54 -0400
In-Reply-To: <20240517173926.965351-32-seanjc@google.com>
References: <20240517173926.965351-1-seanjc@google.com>
	 <20240517173926.965351-32-seanjc@google.com>
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
> Move kvm_find_cpuid_entry{,_index}() "up" in cpuid.c so that they are
> colocated with cpuid_entry2_find(), e.g. to make it easier to see the
> effective guts of the helpers without having to bounce around cpuid.c.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/cpuid.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 0526f25a7c80..d7390ade1c29 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -175,6 +175,20 @@ static struct kvm_cpuid_entry2 *cpuid_entry2_find(struct kvm_vcpu *vcpu,
>  	return NULL;
>  }
>  
> +struct kvm_cpuid_entry2 *kvm_find_cpuid_entry_index(struct kvm_vcpu *vcpu,
> +						    u32 function, u32 index)
> +{
> +	return cpuid_entry2_find(vcpu, function, index);
> +}
> +EXPORT_SYMBOL_GPL(kvm_find_cpuid_entry_index);
> +
> +struct kvm_cpuid_entry2 *kvm_find_cpuid_entry(struct kvm_vcpu *vcpu,
> +					      u32 function)
> +{
> +	return cpuid_entry2_find(vcpu, function, KVM_CPUID_INDEX_NOT_SIGNIFICANT);
> +}
> +EXPORT_SYMBOL_GPL(kvm_find_cpuid_entry);
> +
>  static int kvm_check_cpuid(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_cpuid_entry2 *best;
> @@ -1511,20 +1525,6 @@ int kvm_dev_ioctl_get_cpuid(struct kvm_cpuid2 *cpuid,
>  	return r;
>  }
>  
> -struct kvm_cpuid_entry2 *kvm_find_cpuid_entry_index(struct kvm_vcpu *vcpu,
> -						    u32 function, u32 index)
> -{
> -	return cpuid_entry2_find(vcpu, function, index);
> -}
> -EXPORT_SYMBOL_GPL(kvm_find_cpuid_entry_index);
> -
> -struct kvm_cpuid_entry2 *kvm_find_cpuid_entry(struct kvm_vcpu *vcpu,
> -					      u32 function)
> -{
> -	return cpuid_entry2_find(vcpu, function, KVM_CPUID_INDEX_NOT_SIGNIFICANT);
> -}
> -EXPORT_SYMBOL_GPL(kvm_find_cpuid_entry);
> -
>  /*
>   * Intel CPUID semantics treats any query for an out-of-range leaf as if the
>   * highest basic leaf (i.e. CPUID.0H:EAX) were requested.  AMD CPUID semantics

Makes sense.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


