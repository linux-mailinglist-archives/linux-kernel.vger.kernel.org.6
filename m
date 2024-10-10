Return-Path: <linux-kernel+bounces-359039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE929986AD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A06C21C2342F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693581C6F40;
	Thu, 10 Oct 2024 12:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FHCtasNx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CCD1C2DC0
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728564835; cv=none; b=MWo0a0Uak36+u1JUiVjj0DcJofev15BILseE09YPIhePht1aNsKyAxlHT2EL3DD8q8aaib/tJHZjmdnupNhD0uZAHM+kHx0SRiUI10jJmkETBDgobCugM6bofIAcGD63SyWSH9I4dKxrII3nVXIEDecBP92NKqzjM9Pct3zCoc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728564835; c=relaxed/simple;
	bh=EFme/4SxALJe+BlJbK7fmuj0KFid9zEOfCzeZRFTRg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OY8a18Ye1+OrbGKysYEC0pqqkPrcU+b4dHpT2rOKiS6N54BvB7Mg2Wd26SlXj9BmSIWqwDe1W6BBC1cnJxNTyNJSvq3O5w6wy1mk9qIywccIRF423MDqcyd9JUo056AefDP4mRpZg3vaCKHkp+rmN6kO2/OSeil3BwNAV9LM2Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FHCtasNx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728564833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Dp6cnJFLdZ5gBOMD1Ds1O6L7Mcku1/oXYrG/mj/D0fw=;
	b=FHCtasNxgSTtV2nHr4M9Ee1HgW7lEGdk+4UbHKCSMDHyjTaStxarbGH12UjxOp8YfVIqNw
	/KnQ/W5jEvkZddZvzdpAkFXp6hiDWdlV+WKY414UZ9++uTiMxOpkDeU4eYYxeNklCChAND
	+5udF27A+HR/YN1WZ7Tk6CUJ97q7Z6Y=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-82aAQZazNb24VAzuxH_q-g-1; Thu, 10 Oct 2024 08:53:51 -0400
X-MC-Unique: 82aAQZazNb24VAzuxH_q-g-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a9959df649aso69507866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 05:53:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728564830; x=1729169630;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dp6cnJFLdZ5gBOMD1Ds1O6L7Mcku1/oXYrG/mj/D0fw=;
        b=smjj+VV6I1MIeElfJJZfx4zSbwENS1nw5yWVuBGpc/vbmUb1Mdr7/FUnwUtaJtC7F3
         5khlX+8q5QRFeDdSJrgYUYivnK03mk8PYLqK5V/Ne2kDNlvD1GlW0PGNtxabqcaGggMT
         NLT3ET/aTGksXBWblzB64H1HPcU6/jfE5INXpxFAGKLohdrgbG5EpKjM8qJhLDGp7VMJ
         TWHZv7MXx4Ljtoblqg+Cwc9uRdFi1RKj5sKFeT4DeE4wWYyLQynF+82m6/QiUsVRBRgI
         JXGWIEZkoIahlodrcu52Mh5RC+8LEFrY2UWSgrVkgCQ0txH0n548YQtSea2bHfmCNXof
         KWCw==
X-Forwarded-Encrypted: i=1; AJvYcCXc0May8BQA3YfZxuWVFZUKdOXcp8q7fNuWF9XQE0pWGoWQPoEn6ahrC2WUvkcTK1YkiMwML7NUae7Ixr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/mHwAP4bO0lfo7Xhf6Qn/2+sNt000Rl3FmLR68+X1jYLtqhG+
	uwEhcDJ8fpV1MSyILfybudL6FE6wtk31sJSbhZW2uucP87xhKXHWclQ8k4pX6pQOHqCcZRqQERp
	EEkQP4VTOfjMO9Y5uPlgDOBEwtrJQhEc4IzFQ3Pmfbqm2yMK3jxXZajgp/zCnOQ==
X-Received: by 2002:a17:907:6e8e:b0:a8d:2b7a:ff44 with SMTP id a640c23a62f3a-a998d1f4ecdmr547192466b.32.1728564830617;
        Thu, 10 Oct 2024 05:53:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFd2Mcs/kk09rIwxZfXjqHQaW8CeS5JeRjB1xiwk5tURERdxopVCJcBGwSOUyc4zOEz9zZmyg==
X-Received: by 2002:a17:907:6e8e:b0:a8d:2b7a:ff44 with SMTP id a640c23a62f3a-a998d1f4ecdmr547190966b.32.1728564830225;
        Thu, 10 Oct 2024 05:53:50 -0700 (PDT)
Received: from [192.168.10.81] ([151.81.124.37])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a99a7ec5894sm85691466b.42.2024.10.10.05.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 05:53:49 -0700 (PDT)
Message-ID: <d31a2049-da55-4ee8-bb73-6304787aa27e@redhat.com>
Date: Thu, 10 Oct 2024 14:53:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] KVM: x86: Rename APIC base setters to better capture
 their relationship
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241009181742.1128779-1-seanjc@google.com>
 <20241009181742.1128779-7-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241009181742.1128779-7-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/9/24 20:17, Sean Christopherson wrote:
> Rename kvm_set_apic_base() and kvm_lapic_set_base() to kvm_apic_set_base()
> and __kvm_apic_set_base() respectively to capture that the underscores
> version is a "special" variant (it exists purely to avoid recalculating
> the optimized map multiple times when stuffing the RESET value).
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/lapic.c | 8 ++++----
>   arch/x86/kvm/lapic.h | 3 +--
>   arch/x86/kvm/x86.c   | 4 ++--
>   3 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 6239cfd89aad..0a73d9a09fe0 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -2577,7 +2577,7 @@ u64 kvm_lapic_get_cr8(struct kvm_vcpu *vcpu)
>   	return (tpr & 0xf0) >> 4;
>   }
>   
> -void kvm_lapic_set_base(struct kvm_vcpu *vcpu, u64 value)
> +static void __kvm_apic_set_base(struct kvm_vcpu *vcpu, u64 value)
>   {
>   	u64 old_value = vcpu->arch.apic_base;
>   	struct kvm_lapic *apic = vcpu->arch.apic;
> @@ -2628,7 +2628,7 @@ void kvm_lapic_set_base(struct kvm_vcpu *vcpu, u64 value)
>   	}
>   }
>   
> -int kvm_set_apic_base(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> +int kvm_apic_set_base(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>   {
>   	enum lapic_mode old_mode = kvm_get_apic_mode(vcpu);
>   	enum lapic_mode new_mode = kvm_apic_mode(msr_info->data);
> @@ -2644,7 +2644,7 @@ int kvm_set_apic_base(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>   			return 1;
>   	}
>   
> -	kvm_lapic_set_base(vcpu, msr_info->data);
> +	__kvm_apic_set_base(vcpu, msr_info->data);
>   	kvm_recalculate_apic_map(vcpu->kvm);
>   	return 0;
>   }
> @@ -2752,7 +2752,7 @@ void kvm_lapic_reset(struct kvm_vcpu *vcpu, bool init_event)
>   		msr_val = APIC_DEFAULT_PHYS_BASE | MSR_IA32_APICBASE_ENABLE;
>   		if (kvm_vcpu_is_reset_bsp(vcpu))
>   			msr_val |= MSR_IA32_APICBASE_BSP;
> -		kvm_lapic_set_base(vcpu, msr_val);
> +		__kvm_apic_set_base(vcpu, msr_val);

Might be worth a comment here, otherwise

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

for the entire series.

Paolo


