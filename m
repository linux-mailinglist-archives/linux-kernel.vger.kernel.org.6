Return-Path: <linux-kernel+bounces-543187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75301A4D29A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 05:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC1D23AC036
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 04:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD151F237D;
	Tue,  4 Mar 2025 04:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QSQdsQjH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A30B1D7E4C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 04:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741062925; cv=none; b=JQKIHmYBPPRX0WgBcsCLchAQv9tvMeC0xTps4Z67Han8jLEG3R7wP+HzNeVfQQBx88eE+6D9js1PN82V+fKIC8q+IhRVlr2ZZ/2clIewqWyO+xpl6Y+q+5DGlBOA+wETWCoXQwnduImqnp5zWdYiZa7iWTHZEYAQZRki+k4flb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741062925; c=relaxed/simple;
	bh=eDv7izcYqzv4YAygR57Owiww1VX6TewRxTapsAxTfog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GKyZrD6FYm8PYZ2/4OieXXecP9nz1yuAOKPKKuWL6vVBRGU8TZepDCXQyfb6r9LUJWl8fm7VrdZi0EoHjwQ+Npc+74w/rC9upM+CBp6WHnQnj+UPG4efdL/gGLEdw7o71GXCXnNpJrPnDJ9QsnJEfg2N5PWg7QfX5kg+oxCNEww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QSQdsQjH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741062922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=koAfnbIioMA+14AQ61if+zlW74/NZhlzHrW6k45ApV8=;
	b=QSQdsQjHTBRm+5vFB+VqPC01L4bpNVjluag2oM+99fQKJb3BbD+Xktr6jeqa3sEgNHyF3o
	zOEDnKH4W3yTST+wugYA2n4rRDGdjl2UWJKtKq7mFO/ol3Ps9lOdyxWaqGfTJRwC00olwg
	nXoxH5jAoegRAM9eQaeu/rNqDBwGyAY=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-fy-dIY1BO1uAD8vWJKcHKQ-1; Mon, 03 Mar 2025 23:35:20 -0500
X-MC-Unique: fy-dIY1BO1uAD8vWJKcHKQ-1
X-Mimecast-MFC-AGG-ID: fy-dIY1BO1uAD8vWJKcHKQ_1741062918
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-22366901375so85640625ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 20:35:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741062918; x=1741667718;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=koAfnbIioMA+14AQ61if+zlW74/NZhlzHrW6k45ApV8=;
        b=sZdSpUALa4VDslKq3N1NRD8SAqDXEV97B1erl++XpJ3Op5Icu744Ay1HYiqjzI38en
         Sdct/djiOfiCtN2LQamsKTXZNFA7usI4C8LFDC8ROOkXs8+BOruPKxGrx+xAJSwjr+qq
         4IU1jU2wLtXC5XvWpi2lo/OlqrumjTZcIR2lHg6qdRiPp5bsCwoRWACHMVfgUseO97Ja
         Ft9jzerWOoCjFCmyHNBsTuVktbsH6vGJqVD6+uXQk79wi4VSBPEyTsKNt5cKJ3NmeOId
         pTC1YQLX6SWCGHda4CJHXGvMt3fQp1I9DujqoA5iwnDGv1QSEZIQxxeLyFD8eesjNHVO
         d4WQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDxKqGaubU7yNYqdAoQEHIe1pj4eKmKjiz71Brcfgcr7REkwHGtrSBnYCbz+pvCzFU3RzPE/UA6gyNH10=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy62AEwx7/OkGfPQ5BoiU1c0VQ4gz8WnAG8T3uwFmYC0gu8NjKs
	3dFwgzV0hZMxKLY/Z0oNuRtRsbH30DM7pc0b/ol9XDHnV/cMmfIJarzp06E6Txaz86kwSnGID3z
	ls3MVcjnPiqG3Pzem1e7PRBIkl4pCCS2tAsxrCvEbD6JgalTcCth7GjRMK/NDcw==
X-Gm-Gg: ASbGncs/M41rKgPDLxVxz56JdF4SvIcPML3L02Lny/YNm9HxLWT7IIn4+r2WTx567dT
	jaxKVCySlGeasBvYSZlfegJusRXzXE6zTVT5kTVa0CVigUgcVgouCKSrj4SMPl94yuQioza/u3a
	NFMGeUveyjqsze+xp+oIFlac8dud/2+MSn50xwM71HhZBhXIE2ushWYx2y1ALlXTrE0Obo7SXF7
	Y5aB8H3Gm5mD/drs1985TyTmeA7g2Mzlso5Ap0cwf6paRteOPOvmNC/ZeHyxb/+lR8mEi7j5Oel
	KX3Zedxlb/1Te+j9eQ==
X-Received: by 2002:a05:6a00:1913:b0:736:3ea8:4813 with SMTP id d2e1a72fcca58-7366e54bffdmr3139291b3a.2.1741062917996;
        Mon, 03 Mar 2025 20:35:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQXRcbRKs/P20up2fdaG8YXNHl5+RMV13H5szfYcd+4TW2P2h1zQR3oil9dzOG5dukT3+nLg==
X-Received: by 2002:a05:6a00:1913:b0:736:3ea8:4813 with SMTP id d2e1a72fcca58-7366e54bffdmr3139257b3a.2.1741062917556;
        Mon, 03 Mar 2025 20:35:17 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.164])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7dcb4611sm9141977a12.0.2025.03.03.20.35.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 20:35:16 -0800 (PST)
Message-ID: <b89caaaf-3d26-4ca4-b395-08bf3f90dd1f@redhat.com>
Date: Tue, 4 Mar 2025 14:35:08 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 18/45] arm64: RME: Handle RMI_EXIT_RIPAS_CHANGE
To: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, Fuad Tabba <tabba@google.com>,
 linux-coco@lists.linux.dev,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun
 <alpergun@google.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
References: <20250213161426.102987-1-steven.price@arm.com>
 <20250213161426.102987-19-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250213161426.102987-19-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/14/25 2:13 AM, Steven Price wrote:
> The guest can request that a region of it's protected address space is
> switched between RIPAS_RAM and RIPAS_EMPTY (and back) using
> RSI_IPA_STATE_SET. This causes a guest exit with the
> RMI_EXIT_RIPAS_CHANGE code. We treat this as a request to convert a
> protected region to unprotected (or back), exiting to the VMM to make
> the necessary changes to the guest_memfd and memslot mappings. On the
> next entry the RIPAS changes are committed by making RMI_RTT_SET_RIPAS
> calls.
> 
> The VMM may wish to reject the RIPAS change requested by the guest. For
> now it can only do with by no longer scheduling the VCPU as we don't
> currently have a usecase for returning that rejection to the guest, but
> by postponing the RMI_RTT_SET_RIPAS changes to entry we leave the door
> open for adding a new ioctl in the future for this purpose.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> New patch for v7: The code was previously split awkwardly between two
> other patches.
> ---
>   arch/arm64/kvm/rme.c | 87 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 87 insertions(+)
> 

With the following comments addressed:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/arch/arm64/kvm/rme.c b/arch/arm64/kvm/rme.c
> index 507eb4b71bb7..f965869e9ef7 100644
> --- a/arch/arm64/kvm/rme.c
> +++ b/arch/arm64/kvm/rme.c
> @@ -624,6 +624,64 @@ void kvm_realm_unmap_range(struct kvm *kvm, unsigned long start, u64 size,
>   		realm_unmap_private_range(kvm, start, end);
>   }
>   
> +static int realm_set_ipa_state(struct kvm_vcpu *vcpu,
> +			       unsigned long start,
> +			       unsigned long end,
> +			       unsigned long ripas,
> +			       unsigned long *top_ipa)
> +{
> +	struct kvm *kvm = vcpu->kvm;
> +	struct realm *realm = &kvm->arch.realm;
> +	struct realm_rec *rec = &vcpu->arch.rec;
> +	phys_addr_t rd_phys = virt_to_phys(realm->rd);
> +	phys_addr_t rec_phys = virt_to_phys(rec->rec_page);
> +	struct kvm_mmu_memory_cache *memcache = &vcpu->arch.mmu_page_cache;
> +	unsigned long ipa = start;
> +	int ret = 0;
> +
> +	while (ipa < end) {
> +		unsigned long next;
> +
> +		ret = rmi_rtt_set_ripas(rd_phys, rec_phys, ipa, end, &next);
> +

This doesn't look correct to me. Looking at RMM::smc_rtt_set_ripas(), it's possible
the SMC call is returned without updating 'next' to a valid address. In this case,
the garbage content resident in 'next' can be used to updated to 'ipa' in next
iternation. So we need to initialize it in advance, like below.

	unsigned long ipa = start;
	unsigned long next = start;

	while (ipa < end) {
		ret = rmi_rtt_set_ripas(rd_phys, rec_phys, ipa, end, &next);

> +		if (RMI_RETURN_STATUS(ret) == RMI_ERROR_RTT) {
> +			int walk_level = RMI_RETURN_INDEX(ret);
> +			int level = find_map_level(realm, ipa, end);
> +
> +			/*
> +			 * If the RMM walk ended early then more tables are
> +			 * needed to reach the required depth to set the RIPAS.
> +			 */
> +			if (walk_level < level) {
> +				ret = realm_create_rtt_levels(realm, ipa,
> +							      walk_level,
> +							      level,
> +							      memcache);
> +				/* Retry with RTTs created */
> +				if (!ret)
> +					continue;
> +			} else {
> +				ret = -EINVAL;
> +			}
> +
> +			break;
> +		} else if (RMI_RETURN_STATUS(ret) != RMI_SUCCESS) {
> +			WARN(1, "Unexpected error in %s: %#x\n", __func__,
> +			     ret);
> +			ret = -EINVAL;

			ret = -ENXIO;

> +			break;
> +		}
> +		ipa = next;
> +	}
> +
> +	*top_ipa = ipa;
> +
> +	if (ripas == RMI_EMPTY && ipa != start)
> +		realm_unmap_private_range(kvm, start, ipa);
> +
> +	return ret;
> +}
> +
>   static int realm_init_ipa_state(struct realm *realm,
>   				unsigned long ipa,
>   				unsigned long end)
> @@ -863,6 +921,32 @@ void kvm_destroy_realm(struct kvm *kvm)
>   	kvm_free_stage2_pgd(&kvm->arch.mmu);
>   }
>   
> +static void kvm_complete_ripas_change(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm *kvm = vcpu->kvm;
> +	struct realm_rec *rec = &vcpu->arch.rec;
> +	unsigned long base = rec->run->exit.ripas_base;
> +	unsigned long top = rec->run->exit.ripas_top;
> +	unsigned long ripas = rec->run->exit.ripas_value;
> +	unsigned long top_ipa;
> +	int ret;
> +

Some checks are needed here to ensure the addresses (@base and @top) falls inside
the protected (private) space for two facts: (1) Those parameters originates from
the guest, which can be misbehaving. (2) RMM::smc_rtt_set_ripas() isn't limited to
the private space, meaning it also can change RIPAS for the ranges in the shared
space.

> +	do {
> +		kvm_mmu_topup_memory_cache(&vcpu->arch.mmu_page_cache,
> +					   kvm_mmu_cache_min_pages(vcpu->arch.hw_mmu));
> +		write_lock(&kvm->mmu_lock);
> +		ret = realm_set_ipa_state(vcpu, base, top, ripas, &top_ipa);
> +		write_unlock(&kvm->mmu_lock);
> +
> +		if (WARN_RATELIMIT(ret && ret != -ENOMEM,
> +				   "Unable to satisfy RIPAS_CHANGE for %#lx - %#lx, ripas: %#lx\n",
> +				   base, top, ripas))
> +			break;
> +
> +		base = top_ipa;
> +	} while (top_ipa < top);
> +}
> +
>   int kvm_rec_enter(struct kvm_vcpu *vcpu)
>   {
>   	struct realm_rec *rec = &vcpu->arch.rec;
> @@ -873,6 +957,9 @@ int kvm_rec_enter(struct kvm_vcpu *vcpu)
>   		for (int i = 0; i < REC_RUN_GPRS; i++)
>   			rec->run->enter.gprs[i] = vcpu_get_reg(vcpu, i);
>   		break;
> +	case RMI_EXIT_RIPAS_CHANGE:
> +		kvm_complete_ripas_change(vcpu);
> +		break;
>   	}
>   
>   	if (kvm_realm_state(vcpu->kvm) != REALM_STATE_ACTIVE)

Thanks,
Gavin


