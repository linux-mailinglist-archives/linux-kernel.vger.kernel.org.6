Return-Path: <linux-kernel+bounces-322895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B1397327D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 12:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1E5C285A3F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31FA192D70;
	Tue, 10 Sep 2024 10:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OeIYCsQH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CE514D431
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 10:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963447; cv=none; b=XKmlQ3LCTCBUcpd3mlydi6GsnhVJewVjt8r8UHlxdcKpMB8NVAdarTMIhqWddYwuMfRQA7JSooEvmS58ibhcLFMN0q/YRZ92Z6MzKCVA5WvpRckyj371A6MvJhXaHAOOWX2YP2aO/mbimNs2FEUqRu5ZIbVWhaztsiMpQ5UxK58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963447; c=relaxed/simple;
	bh=k1dNn/dEyRnOqir9/54sQVyS+6eB1joUeMOQPSPXkoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aHd7/gOqdBY/OXszWpdJhIz2zgOEMg7AV9wCsqjHdqc/ApoFtmn6H8cQEb1H9XeGVw3Q00dUNe0zRAIvFb9WwnKpSCmxMKVuAWyq1uatY/1mdLvYcUpHjE2M9yWrDyPElf/76H1D4EXu1w6hiA1wJjWLVWXmjLNcd9Zikm/8MYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OeIYCsQH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725963444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rZE6nuXCk1DYdKf39Tt4evCM8MFSir6b14+cv9KLOVo=;
	b=OeIYCsQHXUpr9YqLtT06qg79Jqnr129R2Rq5COAe4OnZjcJap07zdOKakmGse4hR2aVDUF
	xB6vjIbXBPSxoA6THcuSVFFJzVqku8tnIg56cyLeTreSBwXQWYWakq9ejrlKBKAtyOmGVU
	i9spnrKDxuRio1CbaiXDJp7FdxVt/Zs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-nX2WaQ7LMGyQMLX9tEq1eg-1; Tue, 10 Sep 2024 06:17:23 -0400
X-MC-Unique: nX2WaQ7LMGyQMLX9tEq1eg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-374b9617ab0so2293925f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 03:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725963441; x=1726568241;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rZE6nuXCk1DYdKf39Tt4evCM8MFSir6b14+cv9KLOVo=;
        b=RQxNRdXIznC7JSvwYMlTDSwYC/SBv3HFNV+L/ZCIvkQWSGnCl8ZjIhiMIftZL5aoDd
         HaAQxQcer9EXPKcD5u5b+M9SLRjS9OwQBGdYHxnEtBBfmh+0iftIKnH4guL1qooXMEIN
         18yajDjvOuhOIAj/E66eZP55RHDKcbQqd62JYkHmFTQ2pjnBoCZWMiF3fH6qSirRj7Kv
         4ZbGeSyaAAMgS8N+A/yqCj6+U4NAVk5tt3KRi8kchWz7rZFf31doM8l7hyrYOzTStBOK
         3OeNzjI1imT/4+jp8pQJ+fmnxD22Jl68jii0nzfEua5xRkXt97ng3gLmrc3uYcvVQ7NF
         /6bw==
X-Forwarded-Encrypted: i=1; AJvYcCXTbbu6oS1tti1DyoHviV20Psh7dtC8nsbdgUl1Y3KU14Rq8OefUB7pfadYwnOy9hkR4bQu4SLTKb4U3DQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQt40iRgj1KVPdS3y9kqTvmeoTzlPZMD7HIVnnnsE1u60VfHkP
	OKgN0jntM6fi0UyFRSvXilOHDtxlkArXOAfjtZ4Q2vgsg2TB1737c/Rv7YPB+MlRobp+jKl/XSa
	o2wscSpuggoCU3UaTEa0k9S0NjOHQuqdpagtcBjWygJNHLtGBwr4oCvB9KABYB4vwMsbHeCcW
X-Received: by 2002:adf:8bd6:0:b0:374:c481:3f6 with SMTP id ffacd0b85a97d-37892685851mr5168274f8f.8.1725963441391;
        Tue, 10 Sep 2024 03:17:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9nUG5hQz0bNlVXEJxnJVlGejSQE0Z+8GhTFxPkpflrZQwB2Bi3EIKWZBZ81p0UPwsAgriVA==
X-Received: by 2002:adf:8bd6:0:b0:374:c481:3f6 with SMTP id ffacd0b85a97d-37892685851mr5168257f8f.8.1725963440842;
        Tue, 10 Sep 2024 03:17:20 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.101.29])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42cb73ab096sm68618645e9.22.2024.09.10.03.17.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 03:17:20 -0700 (PDT)
Message-ID: <690bd1cf-e4e9-4008-90d3-adeea047595e@redhat.com>
Date: Tue, 10 Sep 2024 12:17:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/21] KVM: TDX: Implement hook to get max mapping level
 of private pages
To: Rick Edgecombe <rick.p.edgecombe@intel.com>, seanjc@google.com,
 kvm@vger.kernel.org
Cc: kai.huang@intel.com, dmatlack@google.com, isaku.yamahata@gmail.com,
 yan.y.zhao@intel.com, nik.borisov@suse.com, linux-kernel@vger.kernel.org
References: <20240904030751.117579-1-rick.p.edgecombe@intel.com>
 <20240904030751.117579-16-rick.p.edgecombe@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240904030751.117579-16-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/24 05:07, Rick Edgecombe wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> Implement hook private_max_mapping_level for TDX to let TDP MMU core get
> max mapping level of private pages.
> 
> The value is hard coded to 4K for no huge page support for now.
> 
> Co-developed-by: Yan Zhao <yan.y.zhao@intel.com>
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
> TDX MMU part 2 v1:
>   - Split from the big patch "KVM: TDX: TDP MMU TDX support".
>   - Fix missing tdx_gmem_private_max_mapping_level() implementation for
>     !CONFIG_INTEL_TDX_HOST
> 
> v19:
>   - Use gmem_max_level callback, delete tdp_max_page_level.
> ---
>   arch/x86/kvm/vmx/main.c    | 10 ++++++++++
>   arch/x86/kvm/vmx/tdx.c     |  5 +++++
>   arch/x86/kvm/vmx/x86_ops.h |  2 ++
>   3 files changed, 17 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
> index bf6fd5cca1d6..5d43b44e2467 100644
> --- a/arch/x86/kvm/vmx/main.c
> +++ b/arch/x86/kvm/vmx/main.c
> @@ -184,6 +184,14 @@ static int vt_vcpu_mem_enc_ioctl(struct kvm_vcpu *vcpu, void __user *argp)
>   	return tdx_vcpu_ioctl(vcpu, argp);
>   }
>   
> +static int vt_gmem_private_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn)
> +{
> +	if (is_td(kvm))
> +		return tdx_gmem_private_max_mapping_level(kvm, pfn);
> +
> +	return 0;
> +}
> +
>   #define VMX_REQUIRED_APICV_INHIBITS				\
>   	(BIT(APICV_INHIBIT_REASON_DISABLED) |			\
>   	 BIT(APICV_INHIBIT_REASON_ABSENT) |			\
> @@ -337,6 +345,8 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
>   
>   	.mem_enc_ioctl = vt_mem_enc_ioctl,
>   	.vcpu_mem_enc_ioctl = vt_vcpu_mem_enc_ioctl,
> +
> +	.private_max_mapping_level = vt_gmem_private_max_mapping_level
>   };
>   
>   struct kvm_x86_init_ops vt_init_ops __initdata = {
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index b8cd5a629a80..59b627b45475 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -1582,6 +1582,11 @@ int tdx_vcpu_ioctl(struct kvm_vcpu *vcpu, void __user *argp)
>   	return ret;
>   }
>   
> +int tdx_gmem_private_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn)
> +{
> +	return PG_LEVEL_4K;
> +}
> +
>   #define KVM_SUPPORTED_TD_ATTRS (TDX_TD_ATTR_SEPT_VE_DISABLE)
>   
>   static int __init setup_kvm_tdx_caps(void)
> diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
> index d1db807b793a..66829413797d 100644
> --- a/arch/x86/kvm/vmx/x86_ops.h
> +++ b/arch/x86/kvm/vmx/x86_ops.h
> @@ -142,6 +142,7 @@ int tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
>   
>   void tdx_flush_tlb_current(struct kvm_vcpu *vcpu);
>   void tdx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa, int root_level);
> +int tdx_gmem_private_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn);
>   #else
>   static inline int tdx_vm_init(struct kvm *kvm) { return -EOPNOTSUPP; }
>   static inline void tdx_mmu_release_hkid(struct kvm *kvm) {}
> @@ -185,6 +186,7 @@ static inline int tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
>   
>   static inline void tdx_flush_tlb_current(struct kvm_vcpu *vcpu) {}
>   static inline void tdx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa, int root_level) {}
> +static inline int tdx_gmem_private_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn) { return 0; }
>   #endif
>   
>   #endif /* __KVM_X86_VMX_X86_OPS_H */

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>


