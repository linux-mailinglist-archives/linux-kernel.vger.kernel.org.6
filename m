Return-Path: <linux-kernel+bounces-439915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C787E9EB5EC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2028E188B8CF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745871BC09A;
	Tue, 10 Dec 2024 16:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dNrXjuY5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C754A19D884
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 16:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733847430; cv=none; b=ND4lAbxrJThGYDgePPXXV1gunHRtZfZUVRP7cM28sCNS/DAFTgAJuwS1tAjI08nI8G25fzJWXLgmoRD9mqKdgD1oWxrUyWdvFtZXUiXieuRlS/5l2VVSMhK8WQpuoP1uCoE8vy6j0kEXpz6sM+uYNmMh37tA7suli3QOslgd90Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733847430; c=relaxed/simple;
	bh=GDzQs+SNHNin4mfGV3zy+lXixMavnp1hCZwuygPgoxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hWE8pRRo5xTfiPWAImqCVDbnebRC6D9R830Q+TAnZGX58bbH5yiyDc8FG3MzEub7+Zmwi+1ha7lwTpanUHIeWmxRqlLMI3GFdB+fOlUjbv8zjwE3dj/G16pIBh5RZUQ5Ng0NdwGIZKaBSE0D/GZZLUahBsCTUViQ8dDFERZ9TEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dNrXjuY5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733847427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XfALtMUh9MOAw5Gj55FoOho3EnhbH5ZZei5PUEAPRnI=;
	b=dNrXjuY5XNBxgaTad9Hvpk6+U6OTl/zMYIWsL3cEzE78AOxetLPiCmaOnO7Nx7cL4cEZXF
	Y3apPX79NJv2adb56Ky1V9eM6LIOHoekPYYFgRBr9fdV6Rr+wQOv9pCX+zORiNevOtmnmA
	idxnJRH1CBsV493gPau4ivOOWkrQR4g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-xv3tllK5NkujtfaWQZYDzQ-1; Tue, 10 Dec 2024 11:17:06 -0500
X-MC-Unique: xv3tllK5NkujtfaWQZYDzQ-1
X-Mimecast-MFC-AGG-ID: xv3tllK5NkujtfaWQZYDzQ
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-434f15b4b6fso17746025e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 08:17:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733847425; x=1734452225;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XfALtMUh9MOAw5Gj55FoOho3EnhbH5ZZei5PUEAPRnI=;
        b=sUkQtIxwCzYHFxKwkt+sRSb4gx/GabsJE42LxY0qR0vE4oaVc887ENGf0tWl43wdJg
         efSUCbw/Mwppms+tIKElGNIqiJ7tDpaCPNBHA5g0xy/G6ZvrA95ckSJgfaENTJq9daDz
         qivjy/HOrd39dpbUJ8da8akFgg10l5vp7sZC3PtQepSnt1hF71W0kLB0NCEmVqOjpSl0
         V1vrHCWCPWV+gsuQscCTxH5MCj7HRGTb27SjwpUuk7Q+D3aMIGdtTLW59Tvvn6Gp720t
         HNDmUL36XjNndU3ihCNeROdee0iZBYFHssouvzQpFI1/PEKwsy4E1SdXRrPLCEtuGqbD
         7Aow==
X-Forwarded-Encrypted: i=1; AJvYcCXMgf3gua9xJNziYI2cI9pPiIcwAGIcQ7Wij5/SvLqe/PkEVjgAw282pBHnAlUiMhXuf3FnxvE42dpTqQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZRg43w10hyzBHfIurFO/PQyz6jpPcA+VcXTc+azaaHES1k3X3
	OEZ769lT1lAT4Q7VhyPGPAqvtangVj9IjkZ+GFO+1zo5LthBZuqL09zZUS1TRF+VhsOLkiSOsEM
	IE2gXUZrBxmXoWFo+NKmoFFY646mSzRz5g8FHhJlYUx2dwH1c3EqrDwvCvQ21IA==
X-Gm-Gg: ASbGncuzcl1WNJS9SM5hBuE7Uw0tUe5INw48QKjGWSRVCbkdlZVM2TEKc/Bajisa6el
	8UB8XANsLJxqfV77Z39hC6XBwyFA7Zjk4wQ+q13c/6hJyheOMlzKyLCo6w9Cgim7+M9hlITH3VH
	3G7Zt5jIPV0+CJwwPVUUv3Sx4Jz/bbh47gpaKKBHreE6q43Bj8NpKvTczb9LmFpuXaYwSDou1EX
	cojfuXmzArTZda+IWdvJYxdqTDRJEcWgVVU/X2h/rBnxq9Xla+pA6EqSw==
X-Received: by 2002:a05:600c:4f4b:b0:434:f1d5:1453 with SMTP id 5b1f17b1804b1-434ffeb5ebcmr51348735e9.0.1733847425514;
        Tue, 10 Dec 2024 08:17:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZ41cKUASYdlnT5C/Fo8FLlLNEWT6Pp6oUkVkOg8hdXW7xQ9cJLD9eFTzfIB4uvA0mvURE+w==
X-Received: by 2002:a05:600c:4f4b:b0:434:f1d5:1453 with SMTP id 5b1f17b1804b1-434ffeb5ebcmr51348465e9.0.1733847425137;
        Tue, 10 Dec 2024 08:17:05 -0800 (PST)
Received: from [192.168.10.28] ([151.81.118.45])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4361968eed5sm11796975e9.42.2024.12.10.08.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 08:17:04 -0800 (PST)
Message-ID: <ff1d01ff-5aa3-4ef7-a523-6bf4d29be6b6@redhat.com>
Date: Tue, 10 Dec 2024 17:17:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] KVM: x86: Refactor __kvm_emulate_hypercall() into
 a macro
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tom Lendacky <thomas.lendacky@amd.com>, Binbin Wu
 <binbin.wu@linux.intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>,
 Kai Huang <kai.huang@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
References: <20241128004344.4072099-1-seanjc@google.com>
 <20241128004344.4072099-7-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241128004344.4072099-7-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/28/24 01:43, Sean Christopherson wrote:
> Rework __kvm_emulate_hypercall() into a macro so that completion of
> hypercalls that don't exit to userspace use direct function calls to the
> completion helper, i.e. don't trigger a retpoline when RETPOLINE=y.
> 
> Opportunistically take the names of the input registers, as opposed to
> taking the input values, to preemptively dedup more of the calling code
> (TDX needs to use different registers).  Use the direct GPR accessors to
> read values to avoid the pointless marking of the registers as available
> (KVM requires GPRs to always be available).
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> ---
>   arch/x86/kvm/x86.c | 29 +++++++++--------------------
>   arch/x86/kvm/x86.h | 25 ++++++++++++++++++++-----
>   2 files changed, 29 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 39be2a891ab4..fef8b4e63d25 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9982,11 +9982,11 @@ static int complete_hypercall_exit(struct kvm_vcpu *vcpu)
>   	return kvm_skip_emulated_instruction(vcpu);
>   }
>   
> -int __kvm_emulate_hypercall(struct kvm_vcpu *vcpu, unsigned long nr,
> -			    unsigned long a0, unsigned long a1,
> -			    unsigned long a2, unsigned long a3,
> -			    int op_64_bit, int cpl,
> -			    int (*complete_hypercall)(struct kvm_vcpu *))
> +int ____kvm_emulate_hypercall(struct kvm_vcpu *vcpu, unsigned long nr,
> +			      unsigned long a0, unsigned long a1,
> +			      unsigned long a2, unsigned long a3,
> +			      int op_64_bit, int cpl,
> +			      int (*complete_hypercall)(struct kvm_vcpu *))
>   {
>   	unsigned long ret;
>   
> @@ -10073,32 +10073,21 @@ int __kvm_emulate_hypercall(struct kvm_vcpu *vcpu, unsigned long nr,
>   
>   out:
>   	vcpu->run->hypercall.ret = ret;
> -	complete_hypercall(vcpu);
>   	return 1;
>   }
> -EXPORT_SYMBOL_GPL(__kvm_emulate_hypercall);
> +EXPORT_SYMBOL_GPL(____kvm_emulate_hypercall);
>   
>   int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
>   {
> -	unsigned long nr, a0, a1, a2, a3;
> -	int op_64_bit;
> -	int cpl;
> -
>   	if (kvm_xen_hypercall_enabled(vcpu->kvm))
>   		return kvm_xen_hypercall(vcpu);
>   
>   	if (kvm_hv_hypercall_enabled(vcpu))
>   		return kvm_hv_hypercall(vcpu);
>   
> -	nr = kvm_rax_read(vcpu);
> -	a0 = kvm_rbx_read(vcpu);
> -	a1 = kvm_rcx_read(vcpu);
> -	a2 = kvm_rdx_read(vcpu);
> -	a3 = kvm_rsi_read(vcpu);
> -	op_64_bit = is_64_bit_hypercall(vcpu);
> -	cpl = kvm_x86_call(get_cpl)(vcpu);
> -
> -	return __kvm_emulate_hypercall(vcpu, nr, a0, a1, a2, a3, op_64_bit, cpl,
> +	return __kvm_emulate_hypercall(vcpu, rax, rbx, rcx, rdx, rsi,
> +				       is_64_bit_hypercall(vcpu),
> +				       kvm_x86_call(get_cpl)(vcpu),
>   				       complete_hypercall_exit);
>   }
>   EXPORT_SYMBOL_GPL(kvm_emulate_hypercall);
> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> index 28adc8ea04bf..ad6fe6159dea 100644
> --- a/arch/x86/kvm/x86.h
> +++ b/arch/x86/kvm/x86.h
> @@ -617,11 +617,26 @@ static inline bool user_exit_on_hypercall(struct kvm *kvm, unsigned long hc_nr)
>   	return kvm->arch.hypercall_exit_enabled & BIT(hc_nr);
>   }
>   d -
> -int __kvm_emulate_hypercall(struct kvm_vcpu *vcpu, unsigned long nr,
> -			    unsigned long a0, unsigned long a1,
> -			    unsigned long a2, unsigned long a3,
> -			    int op_64_bit, int cpl,
> -			    int (*complete_hypercall)(struct kvm_vcpu *));
> +int ____kvm_emulate_hypercall(struct kvm_vcpu *vcpu, unsigned long nr,
> +			      unsigned long a0, unsigned long a1,
> +			      unsigned long a2, unsigned long a3,
> +			      int op_64_bit, int cpl,
> +			      int (*complete_hypercall)(struct kvm_vcpu *));
> +
> +#define __kvm_emulate_hypercall(_vcpu, nr, a0, a1, a2, a3, op_64_bit, cpl, complete_hypercall)	\
> +({												\
> +	int __ret;										\
> +												\
> +	__ret = ____kvm_emulate_hypercall(_vcpu,						\
> +					  kvm_##nr##_read(_vcpu), kvm_##a0##_read(_vcpu),	\
> +					  kvm_##a1##_read(_vcpu), kvm_##a2##_read(_vcpu),	\
> +					  kvm_##a3##_read(_vcpu), op_64_bit, cpl,		\
> +					  complete_hypercall);					\
> +												\
> +	if (__ret > 0)										\
> +		complete_hypercall(_vcpu);							\

So based on the review of the previous patch this should become

	__ret = complete_hypercall(_vcpu);

Applied with this change to kvm-coco-queue, thanks.

Paolo

> +	__ret;											\
> +})
>   
>   int kvm_emulate_hypercall(struct kvm_vcpu *vcpu);
>   


