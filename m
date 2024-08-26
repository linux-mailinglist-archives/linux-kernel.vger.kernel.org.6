Return-Path: <linux-kernel+bounces-301646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0057F95F397
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 840311F23610
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46174189911;
	Mon, 26 Aug 2024 14:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IocZ5KLa"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81C2154456
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 14:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724681354; cv=none; b=N489f+/QUdjVNYe3VSSQtkf5uT4MfRB3vOPeIu6LhxdDe3eU9+i1H8cRVnPA7NRRm/ivLKfaXtzzEQY4/xGmN00XUsgLaqA5WXmB2BbdQZlh+FabwpGO8R/0fZ0627qMznqqn2EkWIR0wf17db4hmnBob+c/6ehmQwMNFsSuVvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724681354; c=relaxed/simple;
	bh=XvMomLbp+Utw2v7rKqRoOL4vRnSW2uiHImQ6kaNfPYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gip9DzHmEIfJpZfaI/O0+9dcvXimNLMwB7yMvXvfcPtCuGv4UWpmlegnsGJr8j7bHiIUwptkOScvpYSTcLmXdvaSzsoOOw763kVJnMR9MNgGF3WKvEavUG8ZPw6k7wpXKrAtLWKn1r8eyYsOhljoRwFzZm1JCeZJqjfRmi1uRL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IocZ5KLa; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-428119da952so39148275e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 07:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724681349; x=1725286149; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JOlPOukelc3E1XWw2/xouoTXedAW+iaLXT8hTINFd2g=;
        b=IocZ5KLaF96qg4bZJtCkW/DoTewV5F7Y0CXBh6wW82ZFh6jGOSKAgrvU67i5Uqtzu5
         8sMLgp1JuQkwRhZKt8dCXb7AcFGq1af5pgrnJiUiR9YVtbM828n+yETAe4W2VnS72iKu
         yGXUWX4N8ShJQQYpOYbhM0YDCtNjhwv/ET992uNvfKYbfYACZRlf1aspZz2Vtk53b2MV
         pYhUlZbuVI3ha4rqldTiJzs3siiZYFK04ozXQSrv0t33t0S23aoMdLN0TAnQ0rQVm1te
         QcjhUKBkxSXb3/54igCWnGK2ZDgdeVRbSQ7HzDwZx9PirIn66maBiABgaFHAA2nZ6Bq0
         NxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724681349; x=1725286149;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JOlPOukelc3E1XWw2/xouoTXedAW+iaLXT8hTINFd2g=;
        b=LwBFu19rFoDu8XN6bam81Smf5JlGjYJX8crFjmqx38sL5lGEgUcZJM3oHQlrC8oWdj
         UYS9HNDHsyqwz5FWAi2Rt6LwrCo5ZsC2TGgo95gzttNE14wqBBMSxS9jVYfNXb0jJtyK
         gWBaBCV6adNkfzbV+WVfQ9rzSAWRmQsyBDmu8qRmaaK/nQ3LKvk2G2cY1HM0SxKwpzqr
         7Kt3TsW4v5UZ74/kEluVbI3n+yD2eXnUC9m1c5PCEZLO0Erx3PbTSHqywGMQoOKKzUt0
         qVU9qO9fC508sUn6j+su4+8YyaaWt1Ts2DxBxbUPr1YpmUz2S/NpKk+0gJCu6FWKebl0
         9ntQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqSW+SOE+aOd4Cbm8FLrOhzAkcP5NBj0d3yI5bBzORcFW5hhR+e8VQVcepCptvOeZBjAD5WYkwnIFegaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAOWRwjZY9iBPE1OMN6WkXVgQ+DDfb5u1x+8IyUO83TxX6wHBg
	9OWq6Hkkt5TnX5/92Txo+P58WfJ2V7XUoNHxGi6maQf+KXs1Tu9ZN3e/3NR95Vs=
X-Google-Smtp-Source: AGHT+IHs8/DJQ/kQBlrbHNO8RLT4vXIQlYKCngTeVFgUlJz82GvhYzErNP34fdr+2lFz7C7z2EmZeQ==
X-Received: by 2002:a05:600c:1e01:b0:428:f79:1836 with SMTP id 5b1f17b1804b1-42acc9f66bemr73666255e9.26.1724681348835;
        Mon, 26 Aug 2024 07:09:08 -0700 (PDT)
Received: from [10.20.4.146] (212-5-158-72.ip.btc-net.bg. [212.5.158.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abefc61dbsm191236985e9.33.2024.08.26.07.09.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 07:09:08 -0700 (PDT)
Message-ID: <a52010f2-d71c-47ee-aa56-b74fd716ec7b@suse.com>
Date: Mon, 26 Aug 2024 17:09:06 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/25] KVM: x86: Introduce KVM_TDX_GET_CPUID
To: Rick Edgecombe <rick.p.edgecombe@intel.com>, seanjc@google.com,
 pbonzini@redhat.com, kvm@vger.kernel.org
Cc: kai.huang@intel.com, isaku.yamahata@gmail.com,
 tony.lindgren@linux.intel.com, xiaoyao.li@intel.com,
 linux-kernel@vger.kernel.org
References: <20240812224820.34826-1-rick.p.edgecombe@intel.com>
 <20240812224820.34826-22-rick.p.edgecombe@intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20240812224820.34826-22-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 13.08.24 г. 1:48 ч., Rick Edgecombe wrote:
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> 
> Implement an IOCTL to allow userspace to read the CPUID bit values for a
> configured TD.
> 
> The TDX module doesn't provide the ability to set all CPUID bits. Instead
> some are configured indirectly, or have fixed values. But it does allow
> for the final resulting CPUID bits to be read. This information will be
> useful for userspace to understand the configuration of the TD, and set
> KVM's copy via KVM_SET_CPUID2.
> 
> To prevent userspace from starting to use features that might not have KVM
> support yet, filter the reported values by KVM's support CPUID bits.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
> uAPI breakout v1:
>   - New patch
> ---
>   arch/x86/include/uapi/asm/kvm.h |   1 +
>   arch/x86/kvm/vmx/tdx.c          | 131 ++++++++++++++++++++++++++++++++
>   arch/x86/kvm/vmx/tdx.h          |   5 ++
>   arch/x86/kvm/vmx/tdx_arch.h     |   5 ++
>   arch/x86/kvm/vmx/tdx_errno.h    |   1 +
>   5 files changed, 143 insertions(+)
> 
> diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
> index b4f12997052d..39636be5c891 100644
> --- a/arch/x86/include/uapi/asm/kvm.h
> +++ b/arch/x86/include/uapi/asm/kvm.h
> @@ -931,6 +931,7 @@ enum kvm_tdx_cmd_id {
>   	KVM_TDX_CAPABILITIES = 0,
>   	KVM_TDX_INIT_VM,
>   	KVM_TDX_INIT_VCPU,
> +	KVM_TDX_GET_CPUID,
>   
>   	KVM_TDX_CMD_NR_MAX,
>   };
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index b2ed031ac0d6..fe2bbc2ced41 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -813,6 +813,76 @@ static int __tdx_td_init(struct kvm *kvm, struct td_params *td_params,
>   	return ret;
>   }
>   
> +static u64 tdx_td_metadata_field_read(struct kvm_tdx *tdx, u64 field_id,
> +				      u64 *data)
> +{
> +	u64 err;
> +
> +	err = tdh_mng_rd(tdx, field_id, data);
> +
> +	return err;
> +}
> +
> +#define TDX_MD_UNREADABLE_LEAF_MASK	GENMASK(30, 7)
> +#define TDX_MD_UNREADABLE_SUBLEAF_MASK	GENMASK(31, 7)
> +
> +static int tdx_mask_cpuid(struct kvm_tdx *tdx, struct kvm_cpuid_entry2 *entry)
> +{
> +	u64 field_id = TD_MD_FIELD_ID_CPUID_VALUES;
> +	u64 ebx_eax, edx_ecx;
> +	u64 err = 0;
> +
> +	if (entry->function & TDX_MD_UNREADABLE_LEAF_MASK ||
> +	    entry->index & TDX_MD_UNREADABLE_SUBLEAF_MASK)
> +		return -EINVAL;
> +
> +	/*
> +	 * bit 23:17, REVSERVED: reserved, must be 0;
> +	 * bit 16,    LEAF_31: leaf number bit 31;
> +	 * bit 15:9,  LEAF_6_0: leaf number bits 6:0, leaf bits 30:7 are
> +	 *                      implicitly 0;
> +	 * bit 8,     SUBLEAF_NA: sub-leaf not applicable flag;
> +	 * bit 7:1,   SUBLEAF_6_0: sub-leaf number bits 6:0. If SUBLEAF_NA is 1,
> +	 *                         the SUBLEAF_6_0 is all-1.
> +	 *                         sub-leaf bits 31:7 are implicitly 0;
> +	 * bit 0,     ELEMENT_I: Element index within field;
> +	 */
> +	field_id |= ((entry->function & 0x80000000) ? 1 : 0) << 16;
> +	field_id |= (entry->function & 0x7f) << 9;
> +	if (entry->flags & KVM_CPUID_FLAG_SIGNIFCANT_INDEX)
> +		field_id |= (entry->index & 0x7f) << 1;
> +	else
> +		field_id |= 0x1fe;
> +
> +	err = tdx_td_metadata_field_read(tdx, field_id, &ebx_eax);
> +	if (err) //TODO check for specific errors
> +		goto err_out;
> +
> +	entry->eax &= (u32) ebx_eax;
> +	entry->ebx &= (u32) (ebx_eax >> 32);
> +
> +	field_id++;
> +	err = tdx_td_metadata_field_read(tdx, field_id, &edx_ecx);
> +	/*
> +	 * It's weird that reading edx_ecx fails while reading ebx_eax
> +	 * succeeded.
> +	 */
> +	if (WARN_ON_ONCE(err))
> +		goto err_out;
> +
> +	entry->ecx &= (u32) edx_ecx;
> +	entry->edx &= (u32) (edx_ecx >> 32);
> +	return 0;
> +
> +err_out:
> +	entry->eax = 0;
> +	entry->ebx = 0;
> +	entry->ecx = 0;
> +	entry->edx = 0;
> +
> +	return -EIO;
> +}
> +
>   static int tdx_td_init(struct kvm *kvm, struct kvm_tdx_cmd *cmd)
>   {
>   	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
> @@ -1038,6 +1108,64 @@ static int __maybe_unused tdx_get_kvm_supported_cpuid(struct kvm_cpuid2 **cpuid)
>   	return r;
>   }
>   
> +static int tdx_vcpu_get_cpuid(struct kvm_vcpu *vcpu, struct kvm_tdx_cmd *cmd)
> +{
> +	struct kvm_cpuid2 __user *output, *td_cpuid;
> +	struct kvm_tdx *kvm_tdx = to_kvm_tdx(vcpu->kvm);
> +	struct kvm_cpuid2 *supported_cpuid;
> +	int r = 0, i, j = 0;
> +
> +	output = u64_to_user_ptr(cmd->data);
> +	td_cpuid = kzalloc(sizeof(*td_cpuid) +
> +			sizeof(output->entries[0]) * KVM_MAX_CPUID_ENTRIES,
> +			GFP_KERNEL);
> +	if (!td_cpuid)
> +		return -ENOMEM;
> +
> +	r = tdx_get_kvm_supported_cpuid(&supported_cpuid);
> +	if (r)
> +		goto out;
> +
> +	for (i = 0; i < supported_cpuid->nent; i++) {
> +		struct kvm_cpuid_entry2 *supported = &supported_cpuid->entries[i];
> +		struct kvm_cpuid_entry2 *output_e = &td_cpuid->entries[j];
> +
> +		*output_e = *supported;
> +
> +		/* Only allow values of bits that KVM's supports to be exposed */
> +		if (tdx_mask_cpuid(kvm_tdx, output_e))
> +			continue;
> +
> +		/*
> +		 * Work around missing support on old TDX modules, fetch
> +		 * guest maxpa from gfn_direct_bits.
> +		 */


Define old TDX module? I believe the minimum supported TDX version is 
1.5 as EMR are the first public CPUs to support this, no? Module 1.0 was 
used for private previews etc? Can this be dropped altogether? It is 
much easier to mandate the minimum supported version now when nothing 
has been merged. Furthermore, in some of the earlier patches it's 
specifically required that the TDX module support NO_RBP_MOD which 
became available in 1.5, which already dictates that the minimum version 
we should care about is 1.5.


> +		if (output_e->function == 0x80000008) {
> +			gpa_t gpa_bits = gfn_to_gpa(kvm_gfn_direct_bits(vcpu->kvm));
> +			unsigned int g_maxpa = __ffs(gpa_bits) + 1;
> +
> +			output_e->eax &= ~0x00ff0000;
> +			output_e->eax |= g_maxpa << 16;
> +		}
> +
> +		j++;
> +	}
> +	td_cpuid->nent = j;
> +
> +	if (copy_to_user(output, td_cpuid, sizeof(*output))) {
> +		r = -EFAULT;
> +		goto out;
> +	}
> +	if (copy_to_user(output->entries, td_cpuid->entries,
> +			 td_cpuid->nent * sizeof(struct kvm_cpuid_entry2)))
> +		r = -EFAULT;
> +
> +out:
> +	kfree(td_cpuid);
> +	kfree(supported_cpuid);
> +	return r;
> +}
> +
>   static int tdx_vcpu_init(struct kvm_vcpu *vcpu, struct kvm_tdx_cmd *cmd)
>   {
>   	struct msr_data apic_base_msr;
> @@ -1089,6 +1217,9 @@ int tdx_vcpu_ioctl(struct kvm_vcpu *vcpu, void __user *argp)
>   	case KVM_TDX_INIT_VCPU:
>   		ret = tdx_vcpu_init(vcpu, &cmd);
>   		break;
> +	case KVM_TDX_GET_CPUID:
> +		ret = tdx_vcpu_get_cpuid(vcpu, &cmd);
> +		break;
>   	default:
>   		ret = -EINVAL;
>   		break;
> diff --git a/arch/x86/kvm/vmx/tdx.h b/arch/x86/kvm/vmx/tdx.h
> index 8349b542836e..7eeb54fbcae1 100644
> --- a/arch/x86/kvm/vmx/tdx.h
> +++ b/arch/x86/kvm/vmx/tdx.h
> @@ -25,6 +25,11 @@ struct kvm_tdx {
>   	bool finalized;
>   
>   	u64 tsc_offset;
> +
> +	/* For KVM_MAP_MEMORY and KVM_TDX_INIT_MEM_REGION. */
> +	atomic64_t nr_premapped;
> +
> +	struct kvm_cpuid2 *cpuid;
>   };
>   
>   struct vcpu_tdx {
> diff --git a/arch/x86/kvm/vmx/tdx_arch.h b/arch/x86/kvm/vmx/tdx_arch.h
> index d2d7f9cab740..815e74408a34 100644
> --- a/arch/x86/kvm/vmx/tdx_arch.h
> +++ b/arch/x86/kvm/vmx/tdx_arch.h
> @@ -157,4 +157,9 @@ struct td_params {
>   
>   #define MD_FIELD_ID_FEATURES0_TOPOLOGY_ENUM	BIT_ULL(20)
>   
> +/*
> + * TD scope metadata field ID.
> + */
> +#define TD_MD_FIELD_ID_CPUID_VALUES		0x9410000300000000ULL
> +
>   #endif /* __KVM_X86_TDX_ARCH_H */
> diff --git a/arch/x86/kvm/vmx/tdx_errno.h b/arch/x86/kvm/vmx/tdx_errno.h
> index dc3fa2a58c2c..f9dbb3a065cc 100644
> --- a/arch/x86/kvm/vmx/tdx_errno.h
> +++ b/arch/x86/kvm/vmx/tdx_errno.h
> @@ -23,6 +23,7 @@
>   #define TDX_FLUSHVP_NOT_DONE			0x8000082400000000ULL
>   #define TDX_EPT_WALK_FAILED			0xC0000B0000000000ULL
>   #define TDX_EPT_ENTRY_STATE_INCORRECT		0xC0000B0D00000000ULL
> +#define TDX_METADATA_FIELD_NOT_READABLE		0xC0000C0200000000ULL
>   
>   /*
>    * TDX module operand ID, appears in 31:0 part of error code as

