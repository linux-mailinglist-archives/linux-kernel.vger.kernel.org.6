Return-Path: <linux-kernel+bounces-193966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BDC8D34A9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 060DE1C242C0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF73717B4E7;
	Wed, 29 May 2024 10:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="icgKG8Bs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF55F73475
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 10:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716979031; cv=none; b=RlotG9MUKeB+6j6qkz7AtYORySzaqrBA4CNBmH/LrrofZwEO+YlvcYYjHr+bhx9IxVKUguQqVqEO2NPNK4D6Eby4y3L8wDNaHxlaIkpqkbHVX++A+NTfFLVKTEi1xM7DVOkKjzFgUksvA2WtttphRG09RQmYH0FMYTK8ZK+afo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716979031; c=relaxed/simple;
	bh=p1BEXnhw2cEjMFOVZy+OFL7YQynXp+9t0CliU3bLueU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vcn74XvtVxKu38Ltft9feg8lnICXzavVwVCIQrDXKT3ooOQ70vb1k9LAD5zZy3Mc6foaP0bvk1QMmPb9zXGddF09qp5KfwOshYpQFrf37m6wbOpAHURDr764DxB0i+3iaQFdWUOzFUeTaIIuZXuSx8zifJ5K/ZAcLA+ZiVc4GuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=icgKG8Bs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716979028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CpU2Z2y/Dq9mAc3rD+4Oa98jBsSY1tqS5W7YQ5yVdpY=;
	b=icgKG8BsH2oCM1ugG4TuILu1g5uOeoOwnFNi1DWz+9Yua+RpyXt5kZRTNIceDZK81PnBd4
	ECKdijJ4EJBcQNSqbxayg9tdis13EfSIvmmGEpNbcJPI8WWwgiefCA/nHDwQZndvBSHX7r
	15ERyH8l8pj85mmkorQ8noSPVZufmZs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-drsFCTJHN56luaiAtSP_1A-1; Wed, 29 May 2024 06:37:07 -0400
X-MC-Unique: drsFCTJHN56luaiAtSP_1A-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42120a4c56eso5864405e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 03:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716979026; x=1717583826;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CpU2Z2y/Dq9mAc3rD+4Oa98jBsSY1tqS5W7YQ5yVdpY=;
        b=tfdZek1AFHksl+jNOwz+Mw41lpTaI7Uw5JZl95cDmgpEUwzJ3qrka9knPtqkE+qTrk
         qPFYhRXtdc6MAwxXwGjRzZmbCwiDFm8X8thAO2g/5oH8DUT/yB0tpisekqCih7Mz+muE
         6kUh+tt96T688BkSWEvdzH39s6Nn7cxv3lBqaqlkQfaW4VDuAIIch/eBo1cEpvKNWNxy
         zfNcGzK1I4v/tXc9DQzswLTqtChjfRAW5xhagmuGff5ejXRT3AiQBCJ1K9OT3jSiqZty
         lXVF06Shj50OIQGzX3xF2stUY+f1w+01n7hSY3ta18JmxzMF9QGCuCc/l5ZjxmFJKuwn
         z5OQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMKygJW6sy512fFosRwfH+G6lK4imVKBQuKUoZoeBFGm7+pCMP826nwSQYcwfcxvKZJeXqakPMqBqC20zb4cX8f9jWcITMTscQbIgs
X-Gm-Message-State: AOJu0Yx9XzVOIVyrLHrfGp052UXZFx/axqoc0++jYE3nvc6eNOUSXZvV
	KTfR2/r826nBBRBJHudTePFr6sHUgkZ6sa/KoPC8ln0/cGDroF6QY3NlemcOO4usCih6rH9rmmP
	1jzFuqhr03rc0tD87G+9OqsSPoRHKJasBfXnyxbPBE9YpL0KR2sAWA+c2N8+fFQ==
X-Received: by 2002:a05:600c:1d93:b0:420:1a72:69dd with SMTP id 5b1f17b1804b1-42122af2992mr15023185e9.10.1716979026186;
        Wed, 29 May 2024 03:37:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMiOsDUw8h6VNgkHESEJS4VY79Xl3PvqRp9SgguK+PKmVKvFbmTQlWI9/6A1ewVEnFLRo/AA==
X-Received: by 2002:a05:600c:1d93:b0:420:1a72:69dd with SMTP id 5b1f17b1804b1-42122af2992mr15022865e9.10.1716979025686;
        Wed, 29 May 2024 03:37:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100ee954bsm207676175e9.4.2024.05.29.03.37.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 03:37:05 -0700 (PDT)
Message-ID: <312fd3cf-2eb9-4a38-8c50-e3b7639c3cbc@redhat.com>
Date: Wed, 29 May 2024 12:37:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] KVM: arm64: add emulation for CTR_EL0 register
Content-Language: en-US
To: Sebastian Ott <sebott@redhat.com>, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 James Morse <james.morse@arm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>
References: <20240514072252.5657-1-sebott@redhat.com>
 <20240514072252.5657-4-sebott@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20240514072252.5657-4-sebott@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sebastian,
On 5/14/24 09:22, Sebastian Ott wrote:
> CTR_EL0 is currently handled as an invariant register, thus
> guests will be presented with the host value of that register.
> 
> Add emulation for CTR_EL0 based on a per VM value. Userspace can
> switch off DIC and IDC bits and reduce DminLine and IminLine sizes.
> 
> When CTR_EL0 is changed validate that against CLIDR_EL1 and CCSIDR_EL1
> to make sure we present the guest with consistent register values.
> Changes that affect the generated cache topology values are allowed if
> they don't clash with previous register writes.
> 
> Signed-off-by: Sebastian Ott <sebott@redhat.com>
> ---
>  arch/arm64/kvm/sys_regs.c | 130 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 114 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 0213c96f73f2..8e8acf3dd9bd 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -215,13 +215,8 @@ void vcpu_write_sys_reg(struct kvm_vcpu *vcpu, u64 val, int reg)
>  /* CSSELR values; used to index KVM_REG_ARM_DEMUX_ID_CCSIDR */
>  #define CSSELR_MAX 14
>  
> -/*
> - * Returns the minimum line size for the selected cache, expressed as
> - * Log2(bytes).
> - */
> -static u8 get_min_cache_line_size(struct kvm *kvm, bool icache)
> +static u8 __get_min_cache_line_size(u64 ctr, bool icache)
>  {
> -	u64 ctr = kvm->arch.ctr_el0;
>  	u8 field;
>  
>  	if (icache)
> @@ -240,6 +235,15 @@ static u8 get_min_cache_line_size(struct kvm *kvm, bool icache)
>  	return field + 2;
>  }
>  
> +/*
> + * Returns the minimum line size for the selected cache, expressed as
> + * Log2(bytes).
> + */
> +static u8 get_min_cache_line_size(struct kvm *kvm, bool icache)
> +{
> +	return __get_min_cache_line_size(kvm->arch.ctr_el0, icache);
> +}
> +
>  /* Which cache CCSIDR represents depends on CSSELR value. */
>  static u32 get_ccsidr(struct kvm_vcpu *vcpu, u32 csselr)
>  {
> @@ -1880,6 +1884,45 @@ static int set_wi_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
>  	return 0;
>  }
>  
> +static const struct sys_reg_desc *get_sys_reg_desc(u32 encoding);
> +
> +static int validate_clidr_el1(u64 clidr_el1, u64 ctr_el0)
> +{
> +	u64 idc = !CLIDR_LOC(clidr_el1) ||
> +		  (!CLIDR_LOUIS(clidr_el1) && !CLIDR_LOUU(clidr_el1));
This actually computes:
CLIDR_EL1.LoC == 0b000 or (CLIDR_EL1.LoUIS == 0b000 &&
CLIDR_EL1.LoUU == 0b000)

refering to ARM ARM
Terminology for Clean, Invalidate, and Clean and Invalidate instructions

1) If the LoC field value is 0x0, this means that no levels of cache
need to cleaned or invalidated
when cleaning or invalidating to the Point of Coherency.

2) If the LoUU field value is 0x0, this means that no levels of data
cache need to be cleaned or
invalidated when cleaning or invalidating to the Point of Unification.

3) If the LoUIS field value is 0x0, this means that no levels of data or
unified cache need to
cleaned or invalidated when cleaning or invalidating to the Point of
Unification for the Inner Shareable shareability domain.

so to me if above computation is true this means who have no level of
cache to take care of, so although CTR_EL0.IDC = 0 would normally mean
you must "Data cache clean to the Point of Unification" that is not
needed in that case.

But the spec does not really state that IDC=0 and
no_level_of_cache_to_clean_inv are incompatible as far as I see


> +
> +	if ((clidr_el1 & CLIDR_EL1_RES0) || (!(ctr_el0 & CTR_EL0_IDC) && idc))> +		return -EINVAL;

Isn't (clidr_el1 & CLIDR_EL1_RES0) already checked by

        { SYS_DESC(SYS_CLIDR_EL1), access_clidr, reset_clidr, CLIDR_EL1,
          .set_user = set_clidr, .val = ~CLIDR_EL1_RES0 },

> +
> +	return 0;
> +}
> +
> +static int validate_cache_top(struct kvm_vcpu *vcpu, u64 ctr_el0)
s/top/topology?
> +{
> +	const struct sys_reg_desc *clidr_el1;
> +	unsigned int i;
> +	int ret;
> +
> +	clidr_el1 = get_sys_reg_desc(SYS_CLIDR_EL1);
> +	if (!clidr_el1)
> +		return -ENOENT;
> +
> +	ret = validate_clidr_el1(__vcpu_sys_reg(vcpu, clidr_el1->reg), ctr_el0);
> +	if (ret)
> +		return ret;
> +
> +	if (!vcpu->arch.ccsidr)
> +		return 0;
> +
worth to add a comment about what this does as this is not
straighforward ;-)
> +	for (i = 0; i < CSSELR_MAX; i++) {
> +		if ((FIELD_GET(CCSIDR_EL1_LineSize, get_ccsidr(vcpu, i)) + 4)
maybe use a local variable such as log2_cache_bytes
> +		    < __get_min_cache_line_size(ctr_el0, i & CSSELR_EL1_InD))
I don't get i & CSSELR_EL1_InD, please can you explain?
> +			return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static bool access_ctr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
>  		       const struct sys_reg_desc *r)
>  {
> @@ -1890,6 +1933,55 @@ static bool access_ctr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
>  	return true;
>  }
>  
> +static u64 reset_ctr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd)
> +{
> +	vcpu->kvm->arch.ctr_el0 = read_sanitised_ftr_reg(SYS_CTR_EL0);
> +	return vcpu->kvm->arch.ctr_el0;
> +}
> +
> +static int get_ctr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
> +		   u64 *val)
> +{
> +	*val = vcpu->kvm->arch.ctr_el0;
> +	return 0;
> +}
> +
> +static int set_ctr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
> +		   u64 val)
> +{
don't you need to take the config_lock earlier as in set_id_reg()? isn't
it racy versus has_ran_once?
> +	u64 ctr = vcpu->kvm->arch.ctr_el0;
> +	u64 writable_mask = rd->val;
> +	int ret;
> +
> +	if (val == ctr)
> +		return 0;
> +
> +	if (kvm_vm_has_ran_once(vcpu->kvm))> +		return -EBUSY;> +
> +	if ((ctr & ~writable_mask) != (val & ~writable_mask))
> +		return -EINVAL;
> +
> +	if (((ctr & CTR_EL0_DIC_MASK) < (val & CTR_EL0_DIC_MASK)) ||
> +	    ((ctr & CTR_EL0_IDC_MASK) < (val & CTR_EL0_IDC_MASK)) ||
> +	    ((ctr & CTR_EL0_DminLine_MASK) < (val & CTR_EL0_DminLine_MASK)) ||
> +	    ((ctr & CTR_EL0_IminLine_MASK) < (val & CTR_EL0_IminLine_MASK))) {
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&vcpu->kvm->arch.config_lock);
> +	ret = validate_cache_top(vcpu, val);
> +	if (ret) {
> +		mutex_unlock(&vcpu->kvm->arch.config_lock);
> +		return ret;
nit use a goto out
> +	}
> +
> +	vcpu->kvm->arch.ctr_el0 = val;
out:
> +	mutex_unlock(&vcpu->kvm->arch.config_lock);
> +
> +	return 0;
> +}
> +
>  static bool access_clidr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
>  			 const struct sys_reg_desc *r)
>  {
> @@ -1959,10 +2051,9 @@ static u64 reset_clidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
>  static int set_clidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
>  		      u64 val)
>  {
> -	u64 idc = !CLIDR_LOC(val) || (!CLIDR_LOUIS(val) && !CLIDR_LOUU(val));
>  	u64 ctr_el0 = vcpu->kvm->arch.ctr_el0;
>  
> -	if ((val & CLIDR_EL1_RES0) || (!(ctr_el0 & CTR_EL0_IDC) && idc))
> +	if (validate_clidr_el1(val, ctr_el0))
>  		return -EINVAL;
>  
>  	__vcpu_sys_reg(vcpu, rd->reg) = val;
> @@ -2475,7 +2566,11 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>  	{ SYS_DESC(SYS_CCSIDR2_EL1), undef_access },
>  	{ SYS_DESC(SYS_SMIDR_EL1), undef_access },
>  	{ SYS_DESC(SYS_CSSELR_EL1), access_csselr, reset_unknown, CSSELR_EL1 },
> -	{ SYS_DESC(SYS_CTR_EL0), access_ctr },
> +	{ SYS_DESC(SYS_CTR_EL0), access_ctr, .reset = reset_ctr,
> +	  .get_user = get_ctr, .set_user = set_ctr, .val = (CTR_EL0_DIC_MASK |
> +							    CTR_EL0_IDC_MASK |
> +							    CTR_EL0_DminLine_MASK |
> +							    CTR_EL0_IminLine_MASK)},
>  	{ SYS_DESC(SYS_SVCR), undef_access },
>  
>  	{ PMU_SYS_REG(PMCR_EL0), .access = access_pmcr, .reset = reset_pmcr,
> @@ -3651,6 +3746,13 @@ static bool index_to_params(u64 id, struct sys_reg_params *params)
>  	}
>  }
>  
> +static const struct sys_reg_desc *get_sys_reg_desc(u32 encoding)
> +{
> +	struct sys_reg_params params = encoding_to_params(encoding);
> +
> +	return find_reg(&params, sys_reg_descs, ARRAY_SIZE(sys_reg_descs));
> +}
> +
>  const struct sys_reg_desc *get_reg_by_id(u64 id,
>  					 const struct sys_reg_desc table[],
>  					 unsigned int num)
> @@ -3704,18 +3806,11 @@ FUNCTION_INVARIANT(midr_el1)
>  FUNCTION_INVARIANT(revidr_el1)
>  FUNCTION_INVARIANT(aidr_el1)
>  
> -static u64 get_ctr_el0(struct kvm_vcpu *v, const struct sys_reg_desc *r)
> -{
> -	((struct sys_reg_desc *)r)->val = read_sanitised_ftr_reg(SYS_CTR_EL0);
> -	return ((struct sys_reg_desc *)r)->val;
> -}
> -
>  /* ->val is filled in by kvm_sys_reg_table_init() */
>  static struct sys_reg_desc invariant_sys_regs[] __ro_after_init = {
>  	{ SYS_DESC(SYS_MIDR_EL1), NULL, get_midr_el1 },
>  	{ SYS_DESC(SYS_REVIDR_EL1), NULL, get_revidr_el1 },
>  	{ SYS_DESC(SYS_AIDR_EL1), NULL, get_aidr_el1 },
> -	{ SYS_DESC(SYS_CTR_EL0), NULL, get_ctr_el0 },
>  };
>  
>  static int get_invariant_sys_reg(u64 id, u64 __user *uaddr)
> @@ -4083,6 +4178,9 @@ static void vcpu_set_hcr(struct kvm_vcpu *vcpu)
>  	 */
>  	if (!kvm_has_feat(kvm, ID_AA64ISAR0_EL1, TLB, OS))
>  		vcpu->arch.hcr_el2 |= HCR_TTLBOS;
> +
> +	if (kvm->arch.ctr_el0 != read_sanitised_ftr_reg(SYS_CTR_EL0))
> +		vcpu->arch.hcr_el2 |= HCR_TID2;
>  }
>  
>  void kvm_calculate_traps(struct kvm_vcpu *vcpu)

Thanks

Eric


