Return-Path: <linux-kernel+bounces-540998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB732A4B74D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 05:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5869F3A5326
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 04:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AB61DED5C;
	Mon,  3 Mar 2025 04:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QsG8RQtM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07444AEE2
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 04:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740977648; cv=none; b=psMctQUQfoa7NdGX7IUb0VEHa81O5wXzv/Gl2CEoGDxhXSanDGQUdybzftrFSm0XaSLy0kl4VxNo4wZApPpedNToovHVronjSiewncqkIzsigQXf3RAODV3LXg6hr3KooyW0zEfkygCmBHKP9GXlz2dR80Uh5CWMj/qoKq2+dFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740977648; c=relaxed/simple;
	bh=/Q3d4gUCjX1Ns3emiF4KTsF0mBF/50bMqjvHn7VKOsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rN3VWpbS41UfuFQvzyX8O7/QXbQW1ydcSBFp26ERBxhIW1bh+41I42AblnprXVdKlSEaDAt3ATpFy61K+L7LwhBZ4dwDamGLGyMCc9mLVV/TwtlWcAgavOhxI+y/FQdbC2aI+C6QmfPswasf6Nrif01km7HHftkp50QMFWaUql8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QsG8RQtM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740977645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gOpndmvGS2CTNAq9sooQow9PnGsS4iRFoQMUou58z7M=;
	b=QsG8RQtM+H8CTJYCviWVW7aX6QC5zkCrO65CrXEYpDNpVdUVDiGic1P/2vm62Ci72mSY3V
	1CTZBMnYYvj/MpFZboYoCuQoGQ+I1mKaGyD/x5jKyddeIfrr9fvuvR+/IsR8rhQ7HLfyFo
	XzEzvyDU+V+KncT7uAfBQOs66HVrZyk=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-WxWRvufbPcqk1si8JSrMCw-1; Sun, 02 Mar 2025 23:53:49 -0500
X-MC-Unique: WxWRvufbPcqk1si8JSrMCw-1
X-Mimecast-MFC-AGG-ID: WxWRvufbPcqk1si8JSrMCw_1740977628
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2233b154004so76360725ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 20:53:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740977628; x=1741582428;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gOpndmvGS2CTNAq9sooQow9PnGsS4iRFoQMUou58z7M=;
        b=rcpACcAnCf5CPl2xZgtqmpPdlJzVSUDNfRqXQT14D/IXBdnXS6Cn2wd3wTV8YmfgdG
         4QlrXsTViTCWGNqI46cXCSgQNsI+w3DJS+X2n0dLhpPZzNhGHYPW9MySU2HWvByiWvWM
         k++CWMBk9h9I/3kFuhjThvbvU0OuJf8RlitMbjwBqAvdMIp+hEMAA/+iv+MJMpc5WHvj
         ac3bmfdyrm3DecmI/EU45DDnz7Phm6iWW67QD0let4+mve86XwC1uP2f4jyrPwfPMZuo
         Qyb15g+0kY169TV73lC5wMSUXKXhPMftO/gdV5yDsl6FaToSVwWLsRNOpYKZ61hWmbZP
         L88Q==
X-Forwarded-Encrypted: i=1; AJvYcCXHUnQew2GaO7ZOft0teGXzFY9iHLyjCxfeJ1kz7Sg/vRcDPavuzj5fb3NeujdIfYe1+r7K7+CZB0NFCWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjqZO72nLgcdmRxo95nZg/n270/pDBBTCU8/1dk6TK0AM0OCG4
	/+jj+ArdwFK7NncNwRHO/dXVTghjTomgYSaI2e4+d2Z00ma2v9k54mW0dNO9hX5KeJl3q6BBHbJ
	piLVmDjs2MpHgvHARJkEiNABN8HhqXPmZGvxACon2i0AqFnDZWC0XSgh5hI32sQ==
X-Gm-Gg: ASbGnct2RlsAGs4KZwU9hLiCHnKVK6dwr/zl0ZvHF8wNIJuxkQT33RisE7UtHBgff/R
	ldit+9sJyMN2I+pcNmV515yOmZlxvK4NUfGQKxw6M1HUfuAEKNfVKub5M2MAU+SFDUtGCiYph4Y
	s2sQ8tdmmDaQwfWPgjOyqZnKkC7VLuHfpy5MOAYueqaMagNfYGXlGf28oLQ9xQKxRb199B8equr
	0fyM0eYKAhonvC6LqDHRJ/SSGmJzQSMyrpOKa4TPcEBxiyubn6gkO3AFiRFr1WcdiwRPjiumhBq
	uM5yQ4N0DinQXqPXyA==
X-Received: by 2002:a17:903:41cb:b0:223:3781:b600 with SMTP id d9443c01a7336-2236920acb2mr202357125ad.45.1740977628213;
        Sun, 02 Mar 2025 20:53:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLRAVnzN70JdT8ECZbLP+/KQdRigH/UQkGxmw0H8i5HF/nVSSmnBIohZTsVrXlcl3ik9AvfQ==
X-Received: by 2002:a17:903:41cb:b0:223:3781:b600 with SMTP id d9443c01a7336-2236920acb2mr202356895ad.45.1740977627908;
        Sun, 02 Mar 2025 20:53:47 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22350513dd4sm68505855ad.224.2025.03.02.20.53.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 20:53:47 -0800 (PST)
Message-ID: <48b68e9c-e550-4fa9-b479-7b2aad4fd538@redhat.com>
Date: Mon, 3 Mar 2025 14:53:39 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/45] arm64: kvm: Allow passing machine type in KVM
 creation
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
 <20250213161426.102987-11-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250213161426.102987-11-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/14/25 2:13 AM, Steven Price wrote:
> Previously machine type was used purely for specifying the physical
> address size of the guest. Reserve the higher bits to specify an ARM
> specific machine type and declare a new type 'KVM_VM_TYPE_ARM_REALM'
> used to create a realm guest.
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> Changes since v6:
>   * Make the check for kvm_rme_is_available more visible and report an
>     error code of -EPERM (instead of -EINVAL) to make it explicit that
>     the kernel supports RME, but the platform doesn't.
> ---
>   arch/arm64/kvm/arm.c     | 15 +++++++++++++++
>   arch/arm64/kvm/mmu.c     |  3 ---
>   include/uapi/linux/kvm.h | 19 +++++++++++++++----
>   3 files changed, 30 insertions(+), 7 deletions(-)
> 

Section 4.2 of Documentation/virt/kvm/api.rst needs to be updated. Other
than that, it looks good to me:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index df6eb5e9ca96..917ee7c674f5 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -180,6 +180,21 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>   	mutex_unlock(&kvm->lock);
>   #endif
>   
> +	if (type & ~(KVM_VM_TYPE_ARM_MASK | KVM_VM_TYPE_ARM_IPA_SIZE_MASK))
> +		return -EINVAL;
> +
> +	switch (type & KVM_VM_TYPE_ARM_MASK) {
> +	case KVM_VM_TYPE_ARM_NORMAL:
> +		break;
> +	case KVM_VM_TYPE_ARM_REALM:
> +		if (!static_branch_unlikely(&kvm_rme_is_available))
> +			return -EPERM;
> +		kvm->arch.is_realm = true;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
>   	kvm_init_nested(kvm);
>   
>   	ret = kvm_share_hyp(kvm, kvm + 1);
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 8cda128aafef..f8ad8f88bbb8 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -886,9 +886,6 @@ static int kvm_init_ipa_range(struct kvm *kvm,
>   	if (kvm_is_realm(kvm))
>   		kvm_ipa_limit = kvm_realm_ipa_limit();
>   
> -	if (type & ~KVM_VM_TYPE_ARM_IPA_SIZE_MASK)
> -		return -EINVAL;
> -
>   	phys_shift = KVM_VM_TYPE_ARM_IPA_SIZE(type);
>   	if (is_protected_kvm_enabled()) {
>   		phys_shift = kvm_ipa_limit;
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index fa8f45029dff..9cabf9b6a9b4 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -644,14 +644,25 @@ struct kvm_enable_cap {
>   #define KVM_S390_SIE_PAGE_OFFSET 1
>   
>   /*
> - * On arm64, machine type can be used to request the physical
> - * address size for the VM. Bits[7-0] are reserved for the guest
> - * PA size shift (i.e, log2(PA_Size)). For backward compatibility,
> - * value 0 implies the default IPA size, 40bits.
> + * On arm64, machine type can be used to request both the machine type and
> + * the physical address size for the VM.
> + *
> + * Bits[11-8] are reserved for the ARM specific machine type.
> + *
> + * Bits[7-0] are reserved for the guest PA size shift (i.e, log2(PA_Size)).
> + * For backward compatibility, value 0 implies the default IPA size, 40bits.
>    */
> +#define KVM_VM_TYPE_ARM_SHIFT		8
> +#define KVM_VM_TYPE_ARM_MASK		(0xfULL << KVM_VM_TYPE_ARM_SHIFT)
> +#define KVM_VM_TYPE_ARM(_type)		\
> +	(((_type) << KVM_VM_TYPE_ARM_SHIFT) & KVM_VM_TYPE_ARM_MASK)
> +#define KVM_VM_TYPE_ARM_NORMAL		KVM_VM_TYPE_ARM(0)
> +#define KVM_VM_TYPE_ARM_REALM		KVM_VM_TYPE_ARM(1)
> +
>   #define KVM_VM_TYPE_ARM_IPA_SIZE_MASK	0xffULL
>   #define KVM_VM_TYPE_ARM_IPA_SIZE(x)		\
>   	((x) & KVM_VM_TYPE_ARM_IPA_SIZE_MASK)
> +
>   /*
>    * ioctls for /dev/kvm fds:
>    */

Thanks,
Gavin


