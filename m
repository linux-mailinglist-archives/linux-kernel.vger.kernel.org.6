Return-Path: <linux-kernel+bounces-190185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A0D8CFAD3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B8FBB21367
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09FE3A8D0;
	Mon, 27 May 2024 08:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="elp+v57s"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80463381C7
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 08:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716796930; cv=none; b=CN7oHl5mHnxBqkQPh0EOeTK1RZ+MPX710ieSphjllrh/DYAfdBXFRAlUr/QDdhSXJM5GYAocIyeWijTlUwAdiALIaT9SwbPso+wOunXsyKYxKKGyDeYF2QGUlcNgpfkxbRiNvnS2l+M8PPRpmEMcn4/049zzyst2Qt+nJBm7Kpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716796930; c=relaxed/simple;
	bh=/5dCFk8NJutKLk8sOq8BBO8b9omPKKTT2EVYTUJuQSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fFr0yKvKa9QzOz6TVSyFIcCf2dUoS5Ahid+BTdEPliI8pECbhByI77Qq/263WSSMXochIFpKS0S1m94QDRt+4DaIkzKJ6gJ4mG7yNsafei0gq5+ujBWCks5GB59lnz4XcY0E4LCLfZxO6jH8KnzIUxbAIghP+vKSg5F1Hn2gNDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=elp+v57s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716796927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uvfwrl6p2lQsgl+KleP9a2wnuX8rEgYeIsrgIbVtEzc=;
	b=elp+v57smXZw17ObPavEB44ZESv7gp9dbP3M/8D9S/HqD/JkFa5fCDXb3MQVXXlihIPqlK
	HnkOx42IPSIjfYi+nFImqeNmKk/pI75w83N55PhLJSkVR3BpMq4HBCQ07On37SwALQECvG
	g+sRS/mDU/Hvz5794iRERD6vut0cqVA=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-0hLr0G6JPRiJFWTITJEWWQ-1; Mon, 27 May 2024 04:02:01 -0400
X-MC-Unique: 0hLr0G6JPRiJFWTITJEWWQ-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1f48ff3084bso1988925ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 01:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716796920; x=1717401720;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uvfwrl6p2lQsgl+KleP9a2wnuX8rEgYeIsrgIbVtEzc=;
        b=ssjK1usqd0ARy40oxufFiEzrpqTgKZl5jBEe2K/Cgf1Nl8di/Km85YBWxpNJFisaox
         808zjtCQRDOgub6QJj1T90bjKXcFpRCqzF0yNxbe+uM9fE7AzrXrNs0YA3KKJixrtj8/
         urDW0i4nCVL3DsGUBFmzYRD5nVdAXoYZGw4Ddj+fLLzJRBDXGBq7jzZPr+yqblKs6bor
         PYJRAVU1zFoQrbmGGYdm8cQErg/Lf0uk/Dmq3o/bHTyEeovi1akKPDLkeWBhXYddfMbM
         pr8KnFxL3bq+KgN3Av6+OXAmMpCyg1jSIZe94pT8PGQx1huVyNCwynhVUpDu3QMX5IP2
         RZng==
X-Forwarded-Encrypted: i=1; AJvYcCW8bTkI8CFlpQL2BWKdq6jgR0ceNhtq7ILEblqZA/cV147E5YG5MYos4uJ0mqygDUGNrBUIbZ69hW+mYg4loTa0AEqlhIgcb34XiXYA
X-Gm-Message-State: AOJu0Yzb4iXUORwRwamyYRN3tdkEB2rmPBzB3DaO2kFe4g2wyU3JyMRp
	Gn3RZN47qGKZbzfwq0EsWISV9v77U6VLuqGfffJGdivhz9r5GpwLsrD2kb2nfrt5IdsFAeL6pDK
	KduOj1ZRIlYUH6g1qwzxKfMXT/HA2p53uU/7P50F5CHf2ZuVhW4NDzcyt4FUv8w==
X-Received: by 2002:a17:902:f686:b0:1f3:3d5a:e864 with SMTP id d9443c01a7336-1f4494f3db4mr104388895ad.3.1716796920518;
        Mon, 27 May 2024 01:02:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHF3rE4zknZaL/MbeTcB4O+dg0lxcgIOI7m687W5ZMfoqZe5Kp8mqpHr49c8XbjyjPX1Jyg4A==
X-Received: by 2002:a17:902:f686:b0:1f3:3d5a:e864 with SMTP id d9443c01a7336-1f4494f3db4mr104388545ad.3.1716796919968;
        Mon, 27 May 2024 01:01:59 -0700 (PDT)
Received: from [10.66.61.39] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f478a651f6sm29980435ad.101.2024.05.27.01.01.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 01:01:59 -0700 (PDT)
Message-ID: <080b8820-d665-40d6-9cf2-35e47086d01e@redhat.com>
Date: Mon, 27 May 2024 16:01:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] KVM: arm64: unify code to prepare traps
To: Sebastian Ott <sebott@redhat.com>, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 James Morse <james.morse@arm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>
References: <20240514072252.5657-1-sebott@redhat.com>
 <20240514072252.5657-2-sebott@redhat.com>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <20240514072252.5657-2-sebott@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sebastian,

On 5/14/24 15:22, Sebastian Ott wrote:
> There are 2 functions to calculate traps via HCR_EL2:
> * kvm_init_sysreg() called via KVM_RUN (before the 1st run or when
>    the pid changes)
> * vcpu_reset_hcr() called via KVM_ARM_VCPU_INIT
> 
> To unify these 2 and to support traps that are dependent on the
> ID register configuration, move the code from vcpu_reset_hcr()
> to sys_regs.c and call it via kvm_init_sysreg().
> 
> We still have to keep the non-FWB handling stuff in vcpu_reset_hcr().
> Also the initialization with HCR_GUEST_FLAGS is kept there but guarded
> by !vcpu_has_run_once() to ensure that previous calculated values
> don't get overwritten.
> 
> While at it rename kvm_init_sysreg() to kvm_calculate_traps() to
> better reflect what it's doing.
> 
> Signed-off-by: Sebastian Ott <sebott@redhat.com>
> ---
>   arch/arm64/include/asm/kvm_emulate.h | 40 +++++++---------------------
>   arch/arm64/include/asm/kvm_host.h    |  2 +-
>   arch/arm64/kvm/arm.c                 |  2 +-
>   arch/arm64/kvm/sys_regs.c            | 34 +++++++++++++++++++++--
>   4 files changed, 43 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> index 501e3e019c93..84dc3fac9711 100644
> --- a/arch/arm64/include/asm/kvm_emulate.h
> +++ b/arch/arm64/include/asm/kvm_emulate.h
> @@ -69,39 +69,17 @@ static __always_inline bool vcpu_el1_is_32bit(struct kvm_vcpu *vcpu)
>   
>   static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
>   {
> -	vcpu->arch.hcr_el2 = HCR_GUEST_FLAGS;
> -	if (has_vhe() || has_hvhe())
> -		vcpu->arch.hcr_el2 |= HCR_E2H;
> -	if (cpus_have_final_cap(ARM64_HAS_RAS_EXTN)) {
> -		/* route synchronous external abort exceptions to EL2 */
> -		vcpu->arch.hcr_el2 |= HCR_TEA;
> -		/* trap error record accesses */
> -		vcpu->arch.hcr_el2 |= HCR_TERR;
> -	}
> +	if (!vcpu_has_run_once(vcpu))
> +		vcpu->arch.hcr_el2 = HCR_GUEST_FLAGS;

Could you give more explaination in your comments about why we still 
keep the non-FWB handling in vcpu_reset_hcr()? That would be better for 
understanding the special case.

Thanks,
Shaoqin

>   
> -	if (cpus_have_final_cap(ARM64_HAS_STAGE2_FWB)) {
> -		vcpu->arch.hcr_el2 |= HCR_FWB;
> -	} else {
> -		/*
> -		 * For non-FWB CPUs, we trap VM ops (HCR_EL2.TVM) until M+C
> -		 * get set in SCTLR_EL1 such that we can detect when the guest
> -		 * MMU gets turned on and do the necessary cache maintenance
> -		 * then.
> -		 */
> +	/*
> +	 * For non-FWB CPUs, we trap VM ops (HCR_EL2.TVM) until M+C
> +	 * get set in SCTLR_EL1 such that we can detect when the guest
> +	 * MMU gets turned on and do the necessary cache maintenance
> +	 * then.
> +	 */
> +	if (!cpus_have_final_cap(ARM64_HAS_STAGE2_FWB))
>   		vcpu->arch.hcr_el2 |= HCR_TVM;
> -	}
> -
> -	if (cpus_have_final_cap(ARM64_HAS_EVT) &&
> -	    !cpus_have_final_cap(ARM64_MISMATCHED_CACHE_TYPE))
> -		vcpu->arch.hcr_el2 |= HCR_TID4;
> -	else
> -		vcpu->arch.hcr_el2 |= HCR_TID2;
> -
> -	if (vcpu_el1_is_32bit(vcpu))
> -		vcpu->arch.hcr_el2 &= ~HCR_RW;
> -
> -	if (kvm_has_mte(vcpu->kvm))
> -		vcpu->arch.hcr_el2 |= HCR_ATA;
>   }
>   
>   static inline unsigned long *vcpu_hcr(struct kvm_vcpu *vcpu)
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 8170c04fde91..212ae77eefaf 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -1122,7 +1122,7 @@ int __init populate_nv_trap_config(void);
>   bool lock_all_vcpus(struct kvm *kvm);
>   void unlock_all_vcpus(struct kvm *kvm);
>   
> -void kvm_init_sysreg(struct kvm_vcpu *);
> +void kvm_calculate_traps(struct kvm_vcpu *);
>   
>   /* MMIO helpers */
>   void kvm_mmio_write_buf(void *buf, unsigned int len, unsigned long data);
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 9996a989b52e..6b217afb4e8e 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -797,7 +797,7 @@ int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu)
>   	 * This needs to happen after NV has imposed its own restrictions on
>   	 * the feature set
>   	 */
> -	kvm_init_sysreg(vcpu);
> +	kvm_calculate_traps(vcpu);
>   
>   	ret = kvm_timer_enable(vcpu);
>   	if (ret)
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 22b45a15d068..41741bf4d2b2 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -4041,11 +4041,33 @@ int kvm_vm_ioctl_get_reg_writable_masks(struct kvm *kvm, struct reg_mask_range *
>   	return 0;
>   }
>   
> -void kvm_init_sysreg(struct kvm_vcpu *vcpu)
> +static void vcpu_set_hcr(struct kvm_vcpu *vcpu)
>   {
>   	struct kvm *kvm = vcpu->kvm;
>   
> -	mutex_lock(&kvm->arch.config_lock);
> +	if (has_vhe() || has_hvhe())
> +		vcpu->arch.hcr_el2 |= HCR_E2H;
> +	if (cpus_have_final_cap(ARM64_HAS_RAS_EXTN)) {
> +		/* route synchronous external abort exceptions to EL2 */
> +		vcpu->arch.hcr_el2 |= HCR_TEA;
> +		/* trap error record accesses */
> +		vcpu->arch.hcr_el2 |= HCR_TERR;
> +	}
> +
> +	if (cpus_have_final_cap(ARM64_HAS_STAGE2_FWB))
> +		vcpu->arch.hcr_el2 |= HCR_FWB;
> +
> +	if (cpus_have_final_cap(ARM64_HAS_EVT) &&
> +	    !cpus_have_final_cap(ARM64_MISMATCHED_CACHE_TYPE))
> +		vcpu->arch.hcr_el2 |= HCR_TID4;
> +	else
> +		vcpu->arch.hcr_el2 |= HCR_TID2;
> +
> +	if (vcpu_el1_is_32bit(vcpu))
> +		vcpu->arch.hcr_el2 &= ~HCR_RW;
> +
> +	if (kvm_has_mte(vcpu->kvm))
> +		vcpu->arch.hcr_el2 |= HCR_ATA;
>   
>   	/*
>   	 * In the absence of FGT, we cannot independently trap TLBI
> @@ -4054,6 +4076,14 @@ void kvm_init_sysreg(struct kvm_vcpu *vcpu)
>   	 */
>   	if (!kvm_has_feat(kvm, ID_AA64ISAR0_EL1, TLB, OS))
>   		vcpu->arch.hcr_el2 |= HCR_TTLBOS;
> +}
> +
> +void kvm_calculate_traps(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm *kvm = vcpu->kvm;
> +
> +	mutex_lock(&kvm->arch.config_lock);
> +	vcpu_set_hcr(vcpu);
>   
>   	if (cpus_have_final_cap(ARM64_HAS_HCX)) {
>   		vcpu->arch.hcrx_el2 = HCRX_GUEST_FLAGS;

-- 
Shaoqin


