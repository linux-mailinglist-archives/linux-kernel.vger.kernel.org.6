Return-Path: <linux-kernel+bounces-540994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5D3A4B743
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 05:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EF7C3A9B09
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 04:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9593A1E0B91;
	Mon,  3 Mar 2025 04:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ViU0dSQ4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5184E1DDC23
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 04:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740977338; cv=none; b=Gm/PNqyq4Z0RvdJucDi9uSw3MuexTL+BYXYfFpfYjbHMfIb5avYbRi+WJUiGHY7oB1kxvpFikUnac2VEwhbqrWUTAebpxXM5eHC5QRmvqedjezfxKMCsIU3VthO/UCY6dPlEX7W1LZhQgTdqWjN5rGxhJteSISfDHld5Ja3gTF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740977338; c=relaxed/simple;
	bh=zGU7A3mRvM1g91UEynHedjBx/bXUZ7w7qLMnWHvuBwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L0kgUJsqLCQIWW2HpZxRSwdFnuSmMC2vYJwrd4IwL6DrlAEtQwt0/0gGwYdKVDrUTfLNolU8mdyjjLzb0NoPyBXedRVkYE/MXaKG5pio/uiHCPQnnxzcQo62J+oKo8NWwJ5YxLRAO7xKstEzlh8HSo0gFhbumq1Vw3PWhsDLEmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ViU0dSQ4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740977336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=szUhRzEc3gD/KXfeBaNWZbbt2DelRUyv9Ye2MPiDleo=;
	b=ViU0dSQ4VYznw5zuLAZoWWzkYc1BoCP1nOly2nlryCwOO6jZRU2JenN5yqc18YYvPGU599
	YsiL8czkWZiBjolqkqk5Wc4k0+q7hb4mSkv6n3MA3xfxFILGU5LYJUGu8Zb/iYYL9NzbCp
	5Ja5AV6JaBbYxkE7skQV8O4IXue0kNw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-HSZFqULBOxGJA2RjssZF3A-1; Sun, 02 Mar 2025 23:48:55 -0500
X-MC-Unique: HSZFqULBOxGJA2RjssZF3A-1
X-Mimecast-MFC-AGG-ID: HSZFqULBOxGJA2RjssZF3A_1740977334
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fed20dd70cso3235364a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 20:48:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740977333; x=1741582133;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=szUhRzEc3gD/KXfeBaNWZbbt2DelRUyv9Ye2MPiDleo=;
        b=t6kEvJ4pMNS/1AVN1F4LSDfIqEYngscMpBqJJMv4O0hGq3rNB1gyaIiL3TM+M2AThF
         GHRLpgoaNIT52B/B8k/OxpwkLqFEE7TkljBTP7tn+nWtITE/asl21Gek8UJd+8uBzhwS
         Dmu5HL8YO7YABvZ0581sx7w/OIk59k0bK1LfEmXXB1BeT8PSttly/58coGrTNHRNZQoX
         s//ebMLW/kgdmEW4JYDjTmeW1rx0gS/9llWNwVXb4YtJqd2PFLWCSYIjjMpmcerYoo74
         FcYrw2b3sfReZgCkPlIdoOxP3wPY/B/674sAUmaBVyz+Am0FDz+qLNJgcj5US7clhlK1
         AkXg==
X-Forwarded-Encrypted: i=1; AJvYcCXIbUY3G8a2/HyVImhBcFjuDDdThS2umXONDD5YYrAcV+xWSOJi4EQGSohqMaw2cApZ5+H7NCygRF5SV0c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7U+oPhNlCrQ61jKutcGZDhrd35uSGdKs2mf1QanJmYtiJAW+0
	A9jgD3cJdO8ZvtO5ZsoLGW06gD6C5cnA5o4+XAIdEgnKiMyOukaypNJSGucbusEr9LcV9IE1zSZ
	TeuwK3xSL/oyWYbTY2/xkc5JGtEE93Nmn/jQEPoN2Lb1yj1VeXG90HMJu2gOwkbSmAhji/w==
X-Gm-Gg: ASbGncvvIEIFk5qx3h40m88xoLBbl405uvWvARrjwYhK9FoFD+IivEDAGT2zPKrKdbQ
	Qx3fEvXJ694eRgISFHg+Mbyh2DYWKS1lSp3M9zocYWFCCXf7aEfeBfuX9JQ2vfnTYCPB7ScYwwa
	MK02/a73B2o9Xy4KWbluKpjPFMAf5MJfEpATSrX/7HQOdlXC8LUahWiV+Q/mqSCwKWpxLr6Ip5z
	C7mT8SmbP4SqjTZ5eDRrwgh0+ksmxX7piZB3SN4ouofjln5lJS4P1+ok/ggiU7eoqUVjFytiyan
	/dRZJqGlkStLq6OMDg==
X-Received: by 2002:a17:90b:3e84:b0:2ee:8031:cdbc with SMTP id 98e67ed59e1d1-2febac046a6mr14181199a91.23.1740977333518;
        Sun, 02 Mar 2025 20:48:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0bFqBHp5vrV5kno/u9pdc5LbTz/krk4wxyP++znTwdfie+ZMz0iB8kF9GwoMI70Qf1wWKBg==
X-Received: by 2002:a17:90b:3e84:b0:2ee:8031:cdbc with SMTP id 98e67ed59e1d1-2febac046a6mr14181169a91.23.1740977333178;
        Sun, 02 Mar 2025 20:48:53 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2235050d7c1sm68704355ad.198.2025.03.02.20.48.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 20:48:52 -0800 (PST)
Message-ID: <cec600f2-2ddc-4c71-9bab-0a0403132b43@redhat.com>
Date: Mon, 3 Mar 2025 14:48:44 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/45] kvm: arm64: Expose debug HW register numbers for
 Realm
To: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>, Zenghui Yu <yuzenghui@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Gouly <joey.gouly@arm.com>, Alexandru Elisei
 <alexandru.elisei@arm.com>, Christoffer Dall <christoffer.dall@arm.com>,
 Fuad Tabba <tabba@google.com>, linux-coco@lists.linux.dev,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun
 <alpergun@google.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
References: <20250213161426.102987-1-steven.price@arm.com>
 <20250213161426.102987-10-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250213161426.102987-10-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/14/25 2:13 AM, Steven Price wrote:
> From: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> Expose VM specific Debug HW register numbers.
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>   arch/arm64/kvm/arm.c | 24 +++++++++++++++++++++---
>   1 file changed, 21 insertions(+), 3 deletions(-)
> 

Documentation/virt/kvm/api.rst needs to be updated accordingly.

> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index b8fa82be251c..df6eb5e9ca96 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -78,6 +78,22 @@ bool is_kvm_arm_initialised(void)
>   	return kvm_arm_initialised;
>   }
>   
> +static u32 kvm_arm_get_num_brps(struct kvm *kvm)
> +{
> +	if (!kvm_is_realm(kvm))
> +		return get_num_brps();
> +	/* Realm guest is not debuggable. */
> +	return 0;
> +}
> +
> +static u32 kvm_arm_get_num_wrps(struct kvm *kvm)
> +{
> +	if (!kvm_is_realm(kvm))
> +		return get_num_wrps();
> +	/* Realm guest is not debuggable. */
> +	return 0;
> +}
> +

The above two comments "Realm guest is not debuggable." can be dropped since
the code is self-explanatory, and those two functions are unnecessary to be
kept in that way, for example:

	case KVM_CAP_GUEST_DEBUG_HW_BPS:
		return kvm_is_realm(kvm) ? 0 : get_num_brps();
	case KVM_CAP_GUEST_DEBUG_HW_WRPS:
		return kvm_is_realm(kvm) ? 0 : get_num_wrps();


>   int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
>   {
>   	return kvm_vcpu_exiting_guest_mode(vcpu) == IN_GUEST_MODE;
> @@ -323,7 +339,6 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>   	case KVM_CAP_ARM_IRQ_LINE_LAYOUT_2:
>   	case KVM_CAP_ARM_NISV_TO_USER:
>   	case KVM_CAP_ARM_INJECT_EXT_DABT:
> -	case KVM_CAP_SET_GUEST_DEBUG:
>   	case KVM_CAP_VCPU_ATTRIBUTES:
>   	case KVM_CAP_PTP_KVM:
>   	case KVM_CAP_ARM_SYSTEM_SUSPEND:
> @@ -331,6 +346,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>   	case KVM_CAP_COUNTER_OFFSET:
>   		r = 1;
>   		break;
> +	case KVM_CAP_SET_GUEST_DEBUG:
> +		r = !kvm_is_realm(kvm);
> +		break;
>   	case KVM_CAP_SET_GUEST_DEBUG2:
>   		return KVM_GUESTDBG_VALID_MASK;
>   	case KVM_CAP_ARM_SET_DEVICE_ADDR:
> @@ -376,10 +394,10 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>   		r = cpus_have_final_cap(ARM64_HAS_32BIT_EL1);
>   		break;
>   	case KVM_CAP_GUEST_DEBUG_HW_BPS:
> -		r = get_num_brps();
> +		r = kvm_arm_get_num_brps(kvm);
>   		break;
>   	case KVM_CAP_GUEST_DEBUG_HW_WPS:
> -		r = get_num_wrps();
> +		r = kvm_arm_get_num_wrps(kvm);
>   		break;
>   	case KVM_CAP_ARM_PMU_V3:
>   		r = kvm_arm_support_pmu_v3();

Thanks,
Gavin


