Return-Path: <linux-kernel+bounces-540982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F383A4B72E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 05:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8535016B95E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 04:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95E91C84CE;
	Mon,  3 Mar 2025 04:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GN6VxoCm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075BB13C82E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 04:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740976954; cv=none; b=qZZzjHVhGUmVxslbqvZcOwxyFHStnvAiT1WruhO+zuGX6Qt9s40gidRA5JYRZhFNDxBRDp50SQp8qHczhXDzGd1p4qpHsq3Q/F67fu+HRQ3ewuDqPdHMwPPgCs8OOOYPSQjfbBtmZgp6Ss9SferqOJNcpYfDSqh+lS/6lqRKoro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740976954; c=relaxed/simple;
	bh=d9xG4OwrGjzvhEjvrP19eENQGSWBx98WpPyZysjrJ10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CvbNNH888aUaG/y3Srw8V4hpep+8rREngGab+jb0aQDBtj9lQDoN8mbFs8qQJYhsFvQQOyRB4o+2It8YpzPNdxVIzWGI2jxDjT68UrAw3SaocvTaQ214bAyvp9RboD2yer80LLbNrshaG/3y9poKzizNV6N/GNfaH/S2zgjNKbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GN6VxoCm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740976951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uZWlrNkWyyIdXT2p4tYOkQhHrguS4IQ3yj366dONwt0=;
	b=GN6VxoCml4HOL+t9DfK8hbKqSlrVV7yUa+DsvO+8XQw1M+EJxoD0SIhrUqP2aByBciuhRx
	4SGa60e0psN8RquOKedOvB22IHYKCTKjxmMlPfvgb/Z2mYwuiKj7g9rv+OigAOK6qZl7V9
	ZpARXnqS1k3sRBLnG10iUuUopWnqy0Q=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-HrZokwpgOAahtKgrNqltsQ-1; Sun, 02 Mar 2025 23:42:15 -0500
X-MC-Unique: HrZokwpgOAahtKgrNqltsQ-1
X-Mimecast-MFC-AGG-ID: HrZokwpgOAahtKgrNqltsQ_1740976934
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff0875e92bso1918417a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 20:42:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740976934; x=1741581734;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uZWlrNkWyyIdXT2p4tYOkQhHrguS4IQ3yj366dONwt0=;
        b=KigQj6N+CWRbmtKS9h0kTZruqKC6nIDJf8bpohx6mBGHqRiqEkx4Zc6gRTOhDEzS8+
         7q89vB82YX2lgYV6e7/oIkK76YGUntWzWvd9aP2c7BCsp3besn7KbdrchP1nOH+PUu8r
         ZGi31SluPs9p9PUAjJ8Ck60hA8VgcGvF4BpbbNKbOKgVS2LOnb8pDsae5aH+VRS/Jh+b
         Js23pMq1hG03M0gKuWEp4urE2hlZuTjFWaOpfeOHPZBCVkXNI7gFP0bNL3+Vp62yEH6g
         9siRa15VMM/trGbtdL/r6hkdhYUuoBuEBennWczR8d+EjfnGHp6itkWE6lVxNxbDFAfh
         LMkw==
X-Forwarded-Encrypted: i=1; AJvYcCWkUKrpB3fsrVCd5o/UJtAiwQpy0IgcJP7yUREel93HQzDvrl9xAiTuaOsIVXTh53DBXCOYgO1u29IJko8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFpemeWIyTZLjpl8NsAw/76BOeK34+y7BlVV2bwZelYPWSMoeq
	sbCRy0kAalDVEOoxQL1fCYcIZHVr9Wrxq0WPeCxHXBegRu43RYPCjCFTL4cjsvrQGUbgCgVgQw3
	koDcTOtbgY6FVF62UHWKjj4PedNN1/MLGQyLLe8aNFTcYYN3Eo/lniHPky4iLTw==
X-Gm-Gg: ASbGncubKkXyC5GhC1NlsZIAgusQHFlIdYSAaGvd6wZCl20lzBcb8Iao/q03IeQAfQV
	rrIZEj7ZKIfAqYt5IKr5p6016ivNhJkhN7TvvTk3wyQc8Qi2o+Zur4RhgBF3Ob70IQkrliCNVv6
	Ww2B0h1eGYe2r6FogyBt8vDDxiLiHDG2teqj30zkh21Kc73LOW21IuwTaDgdddmkUoNdWuYbCBw
	sgRlThVGYCGvML0rGS0nfTOidXpdFSJRRiCqVaqeY7CgONpp56K9DOGFLcZzjINoypLQQmDr2+9
	U2RCeGq7B5pT+MjcPQ==
X-Received: by 2002:a05:6a20:7347:b0:1f0:e7e2:b295 with SMTP id adf61e73a8af0-1f2f4c9c884mr15086801637.5.1740976934440;
        Sun, 02 Mar 2025 20:42:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMQAnjp3aPLIp+JkScadGYw1k0nhzSpzFpRULDgvvNejMSWpiBemFKZIbJFmyuqZgvHibZmA==
X-Received: by 2002:a05:6a20:7347:b0:1f0:e7e2:b295 with SMTP id adf61e73a8af0-1f2f4c9c884mr15086777637.5.1740976934109;
        Sun, 02 Mar 2025 20:42:14 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.164])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af221346042sm3304724a12.28.2025.03.02.20.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 20:42:13 -0800 (PST)
Message-ID: <3413f278-2507-4bb5-8904-550abe93e459@redhat.com>
Date: Mon, 3 Mar 2025 14:42:04 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/45] arm64: RME: ioctls to create and configure
 realms
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
 <20250213161426.102987-9-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250213161426.102987-9-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/14/25 2:13 AM, Steven Price wrote:
> Add the KVM_CAP_ARM_RME_CREATE_RD ioctl to create a realm. This involves
> delegating pages to the RMM to hold the Realm Descriptor (RD) and for
> the base level of the Realm Translation Tables (RTT). A VMID also need
> to be picked, since the RMM has a separate VMID address space a
> dedicated allocator is added for this purpose.
> 
> KVM_CAP_ARM_RME_CONFIG_REALM is provided to allow configuring the realm
> before it is created. Configuration options can be classified as:
> 
>   1. Parameters specific to the Realm stage2 (e.g. IPA Size, vmid, stage2
>      entry level, entry level RTTs, number of RTTs in start level, LPA2)
>      Most of these are not measured by RMM and comes from KVM book
>      keeping.
> 
>   2. Parameters controlling "Arm Architecture features for the VM". (e.g.
>      SVE VL, PMU counters, number of HW BRPs/WPs), configured by the VMM
>      using the "user ID register write" mechanism. These will be
>      supported in the later patches.
> 
>   3. Parameters are not part of the core Arm architecture but defined
>      by the RMM spec (e.g. Hash algorithm for measurement,
>      Personalisation value). These are programmed via
>      KVM_CAP_ARM_RME_CONFIG_REALM.
> 
> For the IPA size there is the possibility that the RMM supports a
> different size to the IPA size supported by KVM for normal guests. At
> the moment the 'normal limit' is exposed by KVM_CAP_ARM_VM_IPA_SIZE and
> the IPA size is configured by the bottom bits of vm_type in
> KVM_CREATE_VM. This means that it isn't easy for the VMM to discover
> what IPA sizes are supported for Realm guests. Since the IPA is part of
> the measurement of the realm guest the current expectation is that the
> VMM will be required to pick the IPA size demanded by attestation and
> therefore simply failing if this isn't available is fine. An option
> would be to expose a new capability ioctl to obtain the RMM's maximum
> IPA size if this is needed in the future.
> 
> Co-developed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> Changes since v6:
>   * Separate RMM RTT calculations from host PAGE_SIZE. This allows the
>     host page size to be larger than 4k while still communicating with an
>     RMM which uses 4k granules.
> Changes since v5:
>   * Introduce free_delegated_granule() to replace many
>     undelegate/free_page() instances and centralise the comment on
>     leaking when the undelegate fails.
>   * Several other minor improvements suggested by reviews - thanks for
>     the feedback!
> Changes since v2:
>   * Improved commit description.
>   * Improved return failures for rmi_check_version().
>   * Clear contents of PGD after it has been undelegated in case the RMM
>     left stale data.
>   * Minor changes to reflect changes in previous patches.
> ---
>   arch/arm64/include/asm/kvm_emulate.h |   5 +
>   arch/arm64/include/asm/kvm_rme.h     |  19 ++
>   arch/arm64/kvm/arm.c                 |  16 ++
>   arch/arm64/kvm/mmu.c                 |  22 +-
>   arch/arm64/kvm/rme.c                 | 322 +++++++++++++++++++++++++++
>   5 files changed, 382 insertions(+), 2 deletions(-)
> 

With below comments addressed:

Reviewed-by: Gavin Shan <gshan@redhat.com>

[...]

> +
> +static int realm_create_rd(struct kvm *kvm)
> +{
> +	struct realm *realm = &kvm->arch.realm;
> +	struct realm_params *params = realm->params;
> +	void *rd = NULL;
> +	phys_addr_t rd_phys, params_phys;
> +	size_t pgd_size = kvm_pgtable_stage2_pgd_size(kvm->arch.mmu.vtcr);
> +	int i, r;
> +	int rtt_num_start;
> +
> +	realm->ia_bits = VTCR_EL2_IPA(kvm->arch.mmu.vtcr);
> +	rtt_num_start = realm_num_root_rtts(realm);
> +
> +	if (WARN_ON(realm->rd) || WARN_ON(!realm->params))
> +		return -EEXIST;
> +

Two WARN_ON() can be combined into one.

	if (WARN_ON(realm->rd || !realm->param))

> +	if (pgd_size / RMM_PAGE_SIZE < rtt_num_start)
> +		return -EINVAL;
> +
> +	rd = (void *)__get_free_page(GFP_KERNEL);
> +	if (!rd)
> +		return -ENOMEM;
> +
> +	rd_phys = virt_to_phys(rd);
> +	if (rmi_granule_delegate(rd_phys)) {
> +		r = -ENXIO;
> +		goto free_rd;
> +	}
> +
> +	for (i = 0; i < pgd_size; i += RMM_PAGE_SIZE) {
> +		phys_addr_t pgd_phys = kvm->arch.mmu.pgd_phys + i;
> +
> +		if (rmi_granule_delegate(pgd_phys)) {
> +			r = -ENXIO;
> +			goto out_undelegate_tables;
> +		}
> +	}
> +
> +	params->s2sz = VTCR_EL2_IPA(kvm->arch.mmu.vtcr);
> +	params->rtt_level_start = get_start_level(realm);
> +	params->rtt_num_start = rtt_num_start;
> +	params->rtt_base = kvm->arch.mmu.pgd_phys;
> +	params->vmid = realm->vmid;
> +
> +	params_phys = virt_to_phys(params);
> +
> +	if (rmi_realm_create(rd_phys, params_phys)) {
> +		r = -ENXIO;
> +		goto out_undelegate_tables;
> +	}
> +
> +	if (WARN_ON(rmi_rec_aux_count(rd_phys, &realm->num_aux))) {
> +		WARN_ON(rmi_realm_destroy(rd_phys));
> +		goto out_undelegate_tables;
> +	}
> +
> +	realm->rd = rd;
> +
> +	return 0;
> +
> +out_undelegate_tables:
> +	while (i > 0) {
> +		i -= RMM_PAGE_SIZE;
> +
> +		phys_addr_t pgd_phys = kvm->arch.mmu.pgd_phys + i;
> +
> +		if (WARN_ON(rmi_granule_undelegate(pgd_phys))) {
> +			/* Leak the pages if they cannot be returned */
> +			kvm->arch.mmu.pgt = NULL;
> +			break;
> +		}
> +	}
> +	if (WARN_ON(rmi_granule_undelegate(rd_phys))) {
> +		/* Leak the page if it isn't returned */
> +		return r;
> +	}
> +free_rd:
> +	free_page((unsigned long)rd);
> +	return r;
> +}
> +

[...]

> +
> +int kvm_init_realm_vm(struct kvm *kvm)
> +{
> +	struct realm_params *params;
> +
> +	params = (struct realm_params *)get_zeroed_page(GFP_KERNEL);
> +	if (!params)
> +		return -ENOMEM;
> +
> +	kvm->arch.realm.params = params;
> +	return 0;
> +}
> +

The local variable @params is unnecessary, something like below.

	kvm->arch.realm.params = (struct realm_parms *)get_zeroed_page(GFP_KERNEL);

>   void kvm_init_rme(void)
>   {
>   	if (PAGE_SIZE != SZ_4K)
> @@ -52,5 +368,11 @@ void kvm_init_rme(void)
>   		/* Continue without realm support */
>   		return;
>   
> +	if (WARN_ON(rmi_features(0, &rmm_feat_reg0)))
> +		return;
> +
> +	if (rme_vmid_init())
> +		return;
> +
>   	/* Future patch will enable static branch kvm_rme_is_available */
>   }

Thanks,
Gavin


