Return-Path: <linux-kernel+bounces-543212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 765EAA4D2D6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C19116F3D6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 05:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3BF1F4264;
	Tue,  4 Mar 2025 05:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D40czxia"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C641BBBF7
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 05:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741065014; cv=none; b=KVGvyjVy/uKFdYU1zMdItkO3KU4Lh+GGU50ZbCq3dYkQ7Ly3w7LWWrMn8eQ4B38+nbLFeaTXMLI3GquAvZ+Ct/uanPQ7D1P5v+LXGmLExho4Q/V1d7ITftNTiq3X1FZn0VhLJ3+6SVJjvipiVwmBf4G1muLhIiL66BC1SpJu3+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741065014; c=relaxed/simple;
	bh=mo6UEqLjhhD/gYk0pYC+753IVwsq5HZnkglHB39gdLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TLf1TaLAiQ02oiJ1mhfZ9IumftrXd0Lr//qkVvpkQPtJ9RYsHjh5pskcH/ukNtScTlSO3Q2LRz116U5uS5Nrw8PTAST2WDZkq7vPxPEZhqaW7PA2ipZ6FBts3YvTQGrRF8TTdEEG7Ie2UyzeHQMmn9lTyBvv1jJoCJ+IhDYWFWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D40czxia; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741065011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U8NQ+qKZ44E29enCPM7Eb/wfq67YXGlkr0AyFJChf4s=;
	b=D40czxiapcDE/K/leaSeBj6d90O0Xinb40iYNKW98yWsnT389Fzh3P7P5/MZxgbb85MSNA
	GLdsDLLdXYd2c1YFaDyoxrmRm5UoxitqG0MVmgEenEl3cIssaMW1E347uPP7u5tETAov5+
	+dnAbSxltukLgrEeNI9e7AQRzP/uFc4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-mB_biFo2MSiQ4f8GZ_U8UQ-1; Tue, 04 Mar 2025 00:10:09 -0500
X-MC-Unique: mB_biFo2MSiQ4f8GZ_U8UQ-1
X-Mimecast-MFC-AGG-ID: mB_biFo2MSiQ4f8GZ_U8UQ_1741065009
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fed20dd70cso5434927a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 21:10:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741065009; x=1741669809;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U8NQ+qKZ44E29enCPM7Eb/wfq67YXGlkr0AyFJChf4s=;
        b=iRFSoJNIRPTbtXzf1/JuOMxjGpFtXbs78wlXDoyqyIgu+jaMoUPzSqG0C5U5Wr+UNN
         wj3gB8YmHiX+Hhndp690R2qQu73v9zPE5cq0LMHpgJa8w8X3ouIUQggN/JZw+xwn5yQX
         +nwzx/vUo0x5vNxLDpu8etrs+2A6KPokDUze9eoyyteJWrJGUMOMO7+/6zB5iq7OByFI
         34OAiFR+RaunQCavjIC93JYmjakP+W/Xw3GbMyqejI332kTsVXsRD7tHzbxl8qwJv/42
         f4r8o7H+5Wdjv2mnwjPoFbDcaIEq2xKS1plJGhnG6Q0YcoOfJMyb5f1sDxcv9oejHI4Q
         HzBA==
X-Forwarded-Encrypted: i=1; AJvYcCXoHxaquXXgDVvrkaAhwczmpZnYJBLmyLL9O4w6+oGoaSpuYCprLtgjWdk/sRgBWvuMzdS6SSl9mKpJkCI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3UXYSgxPKIjUegUjlBvqvRrXxV4QHnp11Jy3s1KFjU2yr9VuZ
	+znODn+lEd9b+EkP5ERZxb5skF+KYVyvEXM3kKKP4xGSpWaDl0exzk5g89znmQw+wgIIFTdaccG
	H/khg2r82uZ4ZhYsartsGGaS01lcWcfgIyfx6Dvnsk1dAbqTlyJdx84XBOmvokA==
X-Gm-Gg: ASbGncu/vmvnKKOnDO7PFQugljCnijFU+UGhecFxroATIUKCDRkaAY7/eJe182k6o/K
	CphV14yw6CnlOA6mtS4KHAnHpz3qUeGa/Ox/Aqi5kzXUWnHfkvbmoFERPkF1ES2qkKDhrOi0mtV
	0WxAaqVfjSWZTagICJuh0h1VQX+LxxuA9TRLKlRxyREGciouaqK0mWqvMtV/940lKUYcFWdW56V
	Sb+Gb1TkQqwZk6ZmArASpkcFb8hJ4lG3kRIHyLz3/+e97Pg6SJGXGN/dSGpf1q88OmJBM8PpKyH
	AuUTXYeuVLQ43pf03A==
X-Received: by 2002:a17:90b:4c4d:b0:2fa:e9b:33ab with SMTP id 98e67ed59e1d1-2febab7878bmr27494278a91.16.1741065008850;
        Mon, 03 Mar 2025 21:10:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiZnTyS+PczRxTvLSMdHTFs/jB2+JERIbLYMAxRPKra+AaKI0Fes/aNpheWezo+oJpvWNtmw==
X-Received: by 2002:a17:90b:4c4d:b0:2fa:e9b:33ab with SMTP id 98e67ed59e1d1-2febab7878bmr27494245a91.16.1741065008475;
        Mon, 03 Mar 2025 21:10:08 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe825d2b85sm12057524a91.26.2025.03.03.21.10.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 21:10:07 -0800 (PST)
Message-ID: <8e852bc0-9a02-42d9-8d56-712c11508626@redhat.com>
Date: Tue, 4 Mar 2025 15:09:59 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 20/45] arm64: RME: Allow populating initial contents
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
 <20250213161426.102987-21-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250213161426.102987-21-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/14/25 2:14 AM, Steven Price wrote:
> The VMM needs to populate the realm with some data before starting (e.g.
> a kernel and initrd). This is measured by the RMM and used as part of
> the attestation later on.
> 
> Co-developed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> Changes since v6:
>   * Handle host potentially having a larger page size than the RMM
>     granule.
>   * Drop historic "par" (protected address range) from
>     populate_par_region() - it doesn't exist within the current
>     architecture.
>   * Add a cond_resched() call in kvm_populate_realm().
> Changes since v5:
>   * Refactor to use PFNs rather than tracking struct page in
>     realm_create_protected_data_page().
>   * Pull changes from a later patch (in the v5 series) for accessing
>     pages from a guest memfd.
>   * Do the populate in chunks to avoid holding locks for too long and
>     triggering RCU stall warnings.
> ---
>   arch/arm64/kvm/rme.c | 234 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 234 insertions(+)
> 

With the following comments addressed:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/arch/arm64/kvm/rme.c b/arch/arm64/kvm/rme.c
> index f965869e9ef7..7880894db722 100644
> --- a/arch/arm64/kvm/rme.c
> +++ b/arch/arm64/kvm/rme.c
> @@ -624,6 +624,228 @@ void kvm_realm_unmap_range(struct kvm *kvm, unsigned long start, u64 size,
>   		realm_unmap_private_range(kvm, start, end);
>   }
>   
> +static int realm_create_protected_data_granule(struct realm *realm,
> +					       unsigned long ipa,
> +					       phys_addr_t dst_phys,
> +					       phys_addr_t src_phys,
> +					       unsigned long flags)
> +{
> +	phys_addr_t rd = virt_to_phys(realm->rd);
> +	int ret;
> +
> +	if (rmi_granule_delegate(dst_phys))
> +		return -ENXIO;
> +
> +	ret = rmi_data_create(rd, dst_phys, ipa, src_phys, flags);
> +	if (RMI_RETURN_STATUS(ret) == RMI_ERROR_RTT) {
> +		/* Create missing RTTs and retry */
> +		int level = RMI_RETURN_INDEX(ret);
> +
> +		WARN_ON(level == RMM_RTT_MAX_LEVEL);
> +
> +		ret = realm_create_rtt_levels(realm, ipa, level,
> +					      RMM_RTT_MAX_LEVEL, NULL);
> +		if (ret)
> +			return -EIO;
> +
> +		ret = rmi_data_create(rd, dst_phys, ipa, src_phys, flags);
> +	}
> +	if (ret)
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static int realm_create_protected_data_page(struct realm *realm,
> +					    unsigned long ipa,
> +					    kvm_pfn_t dst_pfn,
> +					    kvm_pfn_t src_pfn,
> +					    unsigned long flags)
> +{
> +	unsigned long rd = virt_to_phys(realm->rd);
> +	phys_addr_t dst_phys, src_phys;
> +	bool undelegate_failed = false;
> +	int ret, offset;
> +
> +	dst_phys = __pfn_to_phys(dst_pfn);
> +	src_phys = __pfn_to_phys(src_pfn);
> +
> +	for (offset = 0; offset < PAGE_SIZE; offset += RMM_PAGE_SIZE) {
> +		ret = realm_create_protected_data_granule(realm,
> +							  ipa,
> +							  dst_phys,
> +							  src_phys,
> +							  flags);
> +		if (ret)
> +			goto err;
> +
> +		ipa += RMM_PAGE_SIZE;
> +		dst_phys += RMM_PAGE_SIZE;
> +		src_phys += RMM_PAGE_SIZE;
> +	}
> +
> +	return 0;
> +
> +err:
> +	if (ret == -EIO) {
> +		/* current offset needs undelegating */
> +		if (WARN_ON(rmi_granule_undelegate(dst_phys)))
> +			undelegate_failed = true;
> +	}
> +	while (offset > 0) {
> +		ipa -= RMM_PAGE_SIZE;
> +		offset -= RMM_PAGE_SIZE;
> +		dst_phys -= RMM_PAGE_SIZE;
> +
> +		rmi_data_destroy(rd, ipa, NULL, NULL);
> +
> +		if (WARN_ON(rmi_granule_undelegate(dst_phys)))
> +			undelegate_failed = true;
> +	}
> +
> +	if (undelegate_failed) {
> +		/*
> +		 * A granule could not be undelegated,
> +		 * so the page has to be leaked
> +		 */
> +		get_page(pfn_to_page(dst_pfn));
> +	}
> +
> +	return -ENXIO;
> +}
> +
> +static int populate_region(struct kvm *kvm,
> +			   phys_addr_t ipa_base,
> +			   phys_addr_t ipa_end,
> +			   unsigned long data_flags)
> +{
> +	struct realm *realm = &kvm->arch.realm;
> +	struct kvm_memory_slot *memslot;
> +	gfn_t base_gfn, end_gfn;
> +	int idx;
> +	phys_addr_t ipa;
> +	int ret = 0;
> +
> +	base_gfn = gpa_to_gfn(ipa_base);
> +	end_gfn = gpa_to_gfn(ipa_end);
> +
> +	idx = srcu_read_lock(&kvm->srcu);
> +	memslot = gfn_to_memslot(kvm, base_gfn);
> +	if (!memslot) {
> +		ret = -EFAULT;
> +		goto out;
> +	}
> +
> +	/* We require the region to be contained within a single memslot */
> +	if (memslot->base_gfn + memslot->npages < end_gfn) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (!kvm_slot_can_be_private(memslot)) {
> +		ret = -EINVAL;
		ret = -EPERM;

> +		goto out;
> +	}
> +
> +	write_lock(&kvm->mmu_lock);
> +
> +	ipa = ALIGN_DOWN(ipa_base, PAGE_SIZE);

The aignment operation is unnecessary since the base/size are ensured
to be aligned to PAGE_SIZE by its caller (kvm_populate_realm()).

> +	while (ipa < ipa_end) {
> +		struct vm_area_struct *vma;
> +		unsigned long hva;
> +		struct page *page;
> +		bool writeable;
> +		kvm_pfn_t pfn;
> +		kvm_pfn_t priv_pfn;
> +		struct page *gmem_page;
> +
> +		hva = gfn_to_hva_memslot(memslot, gpa_to_gfn(ipa));
> +		vma = vma_lookup(current->mm, hva);
> +		if (!vma) {
> +			ret = -EFAULT;
> +			break;
> +		}
> +
> +		pfn = __kvm_faultin_pfn(memslot, gpa_to_gfn(ipa), FOLL_WRITE,
> +					&writeable, &page);
> +
> +		if (is_error_pfn(pfn)) {
> +			ret = -EFAULT;
> +			break;
> +		}
> +
> +		ret = kvm_gmem_get_pfn(kvm, memslot,
> +				       ipa >> PAGE_SHIFT,
> +				       &priv_pfn, &gmem_page, NULL);
> +		if (ret)
> +			break;
> +
> +		ret = realm_create_protected_data_page(realm, ipa,
> +						       priv_pfn,
> +						       pfn,
> +						       data_flags);
> +
> +		kvm_release_faultin_page(kvm, page, false, false);
> +
> +		if (ret)
> +			break;
> +
> +		ipa += PAGE_SIZE;
> +	}
> +
> +	write_unlock(&kvm->mmu_lock);
> +
> +out:
> +	srcu_read_unlock(&kvm->srcu, idx);
> +	return ret;
> +}
> +
> +static int kvm_populate_realm(struct kvm *kvm,
> +			      struct arm_rme_populate_realm *args)
> +{
> +	phys_addr_t ipa_base, ipa_end;
> +	unsigned long data_flags = 0;
> +
> +	if (kvm_realm_state(kvm) != REALM_STATE_NEW)
> +		return -EINVAL;
		return -EPERM;

> +
> +	if (!IS_ALIGNED(args->base, PAGE_SIZE) ||
> +	    !IS_ALIGNED(args->size, PAGE_SIZE))
> +		return -EINVAL;
> +
> +	if (args->flags & ~RMI_MEASURE_CONTENT)
> +		return -EINVAL;

It's perfect to combine those checks:

	if (!IS_ALIGNED(...) ||
	    !IS_ALIGNED(...) ||
	    args->flags & ~RMI_MEASURE_CONTENT)
		return -EINVAL;

> +
> +	ipa_base = args->base;
> +	ipa_end = ipa_base + args->size;
> +
> +	if (ipa_end < ipa_base)
> +		return -EINVAL;
> +
> +	if (args->flags & RMI_MEASURE_CONTENT)
> +		data_flags |= RMI_MEASURE_CONTENT;
> +
> +	/*
> +	 * Perform the populate in parts to ensure locks are not held for too
> +	 * long
> +	 */
	
s/populate/population ?

> +	while (ipa_base < ipa_end) {
> +		phys_addr_t end = min(ipa_end, ipa_base + SZ_2M);
> +
> +		int ret = populate_region(kvm, ipa_base, end,
> +					  args->flags);
> +
> +		if (ret)
> +			return ret;
> +
> +		ipa_base = end;
> +
> +		cond_resched();
> +	}
> +
> +	return 0;
> +}
> +
>   static int realm_set_ipa_state(struct kvm_vcpu *vcpu,
>   			       unsigned long start,
>   			       unsigned long end,
> @@ -873,6 +1095,18 @@ int kvm_realm_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
>   		r = kvm_init_ipa_range_realm(kvm, &args);
>   		break;
>   	}
> +	case KVM_CAP_ARM_RME_POPULATE_REALM: {
> +		struct arm_rme_populate_realm args;
> +		void __user *argp = u64_to_user_ptr(cap->args[1]);
> +
> +		if (copy_from_user(&args, argp, sizeof(args))) {
> +			r = -EFAULT;
> +			break;
> +		}
> +
> +		r = kvm_populate_realm(kvm, &args);
> +		break;
> +	}
>   	default:
>   		r = -EINVAL;
>   		break;

Thanks,
Gavin


