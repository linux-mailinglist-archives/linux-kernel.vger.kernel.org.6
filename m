Return-Path: <linux-kernel+bounces-543228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E0AA4D2FC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7724C3ADF8C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 05:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18861F4716;
	Tue,  4 Mar 2025 05:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KiI4CmG+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA6E149C7D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 05:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741066195; cv=none; b=fknD9Nvs4SULAQsn9bUM+zbR97VVxGyweqhwzD+K/EjuWhz2kB/GZ3yWaq17ieSurHH50T/qZWBfg07nqtYLcyHYUTAe7WSGLwCh1b37+jsxYl60Hw3Qp0oQBXfwV4CdyLLdCJ39iHG833SCBthOxGlJYJCnGK3r7L6vEyO0XSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741066195; c=relaxed/simple;
	bh=CAzIhVsIFi4/3ByvCvQJWA17BzFjI6peJWwCPB4wM7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AsKpwGt7EpUO4s8G2mma1X9GhoIsmU6ZzqF5u/17QZTtpmuJtkjHs8H5cZVHitpIQSDH0cBF10XbtuvuR5cLsNOXlxLMqlWWzkHL9Fj8yhRg8djr7AIIgyy8b4ulY9w8tpGxcQBNGVD/XytGsIz2cUH1h6uvXz58CHzQ7+pC4Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KiI4CmG+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741066191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K5NVuBpJLlZnTOLyK2ct+nvinMD4r7ch0nzerHgxTzg=;
	b=KiI4CmG+xq0/3CzXrgS3WVJ66qAzgrDMd9fRYE13gyFHcTUp1b1fpUxyV45NCOFyubBmMz
	5c9mIacX63xYUSAiMq21VndX5qYVha1daIDbNzOPtUvl/2MNVghkb2phCwHv1ZRTdj9T3h
	B0KCTvjMOdFdRgcnIhOZXjtZCRKPdeM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-SWRnWQueN4ycagXLaatGkQ-1; Tue, 04 Mar 2025 00:29:49 -0500
X-MC-Unique: SWRnWQueN4ycagXLaatGkQ-1
X-Mimecast-MFC-AGG-ID: SWRnWQueN4ycagXLaatGkQ_1741066189
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2feda4729e9so8633703a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 21:29:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741066189; x=1741670989;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K5NVuBpJLlZnTOLyK2ct+nvinMD4r7ch0nzerHgxTzg=;
        b=s2qve9vME8i5vhteobp0InLhWNR/++uYxmCRg9kFZ6FENGbyq6xxyNuhE1Dj/oCKhD
         I8SJyDMtLGnzf72P+PzuHlIDpJV6RWaUOt7XMaK+DwJbrse7+CXzHBVDabFU/VSPdw1/
         Hf6VSVv6LQ15SOOUunwMKW+CtSxwDXa9usglcl86DY/foFGOwVPJReuZE12jq3ktGp3T
         gpWURNnLzVActzjxlyVQB/TwGIjvw+LcN2SGkldc+ppfevD8/eZ7/SurW7gYaR2rn3z5
         p/Q/Upn7Rfm4FtZjgRZdJUd+zHR31BIB1F0bvAL+FkTOO8VIqRVhQhdMaxSua2x0ySbg
         YmQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPn/kag1Nq1fAD1CAQKqzbWAtZ1fHzoTgC3u99deaZpc2A9D5cEjfPER9jSAehxajSp9WQr3U0SIaIV9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG/vhX4i13Cm33I5zI03ojtxGRN42MYs7s0t50sQim6zQilUWG
	pi62E6RtwoGDdzGYnz/Hb/8P61yD9JAGZUZlijYFPXBBktY3qXpjXshoddt3xYepHGy9odLem8j
	Mj2cwuiLFub6xWHxbd1vnMZBaFiTaY6/w5XXNBuA/F3NdrVaw+SOXps09/ukmXA==
X-Gm-Gg: ASbGncuS8z/Hx4sh/nxoXa5nQJCpGNSQMeJtDnzc+M3o9mX1ka78ydCfrS+5TO0jAbq
	kuGZ2QdFbbMM8fOoNSqlEPJNqyg8UDsMIeq3LCcyV2y+lZjUaPhi0NwkpVuZy2Lmpd1ZzJhdsCf
	b8nUF5ovCe4zuBA3a04eV3rpVD8OlHR8gQ62KkAuA/iIqp4QUtm07oYsGGjnQI4qQlzILMslwlz
	YMWbRWsetOk+ntHxrzuXj9NMlJBANPMyGuS9HZrOJPvOztxS+jnVMTWoyS+ctVXeE3HLDSPBD/g
	jqqA13Kq0qgtyy1ZBw==
X-Received: by 2002:a05:6a21:3d83:b0:1f3:289e:36d9 with SMTP id adf61e73a8af0-1f3289e3a2fmr9220363637.40.1741066188751;
        Mon, 03 Mar 2025 21:29:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWg73A+PEVA+mHDKOgju64xlHqN6DY26ozmlm+MoWJ+dQTX/kJaWOUjo5QtcrSQGbf6nj6HQ==
X-Received: by 2002:a05:6a21:3d83:b0:1f3:289e:36d9 with SMTP id adf61e73a8af0-1f3289e3a2fmr9220343637.40.1741066188462;
        Mon, 03 Mar 2025 21:29:48 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.164])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af174933aa5sm6247124a12.46.2025.03.03.21.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 21:29:47 -0800 (PST)
Message-ID: <b4cc58db-b9d8-4cdb-8954-8697972a54ae@redhat.com>
Date: Tue, 4 Mar 2025 15:29:38 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 23/45] KVM: arm64: Validate register access for a Realm
 VM
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
 <20250213161426.102987-24-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250213161426.102987-24-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/14/25 2:14 AM, Steven Price wrote:
> The RMM only allows setting the GPRS (x0-x30) and PC for a realm
> guest. Check this in kvm_arm_set_reg() so that the VMM can receive a
> suitable error return if other registers are accessed.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> Changes since v5:
>   * Upper GPRS can be set as part of a HOST_CALL return, so fix up the
>     test to allow them.
> ---
>   arch/arm64/kvm/guest.c | 40 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 40 insertions(+)
> 

The subject isn't 100% matching with what has been done in this patch.
It's actually to limit the scope for the write operations. The question
is do we need similar limitation for the read operations? If not, it's
nice to explain in the change log :)

> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index 2196979a24a3..ff0306650b39 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c
> @@ -73,6 +73,24 @@ static u64 core_reg_offset_from_id(u64 id)
>   	return id & ~(KVM_REG_ARCH_MASK | KVM_REG_SIZE_MASK | KVM_REG_ARM_CORE);
>   }
>   
> +static bool kvm_realm_validate_core_reg(u64 off)
> +{
> +	/*
> +	 * Note that GPRs can only sometimes be controlled by the VMM.
> +	 * For PSCI only X0-X6 are used, higher registers are ignored (restored
> +	 * from the REC).
> +	 * For HOST_CALL all of X0-X30 are copied to the RsiHostCall structure.
> +	 * For emulated MMIO X0 is always used.
> +	 */
> +	switch (off) {
> +	case KVM_REG_ARM_CORE_REG(regs.regs[0]) ...
> +	     KVM_REG_ARM_CORE_REG(regs.regs[30]):
> +	case KVM_REG_ARM_CORE_REG(regs.pc):
> +		return true;
> +	}
> +	return false;
> +}
> +
>   static int core_reg_size_from_offset(const struct kvm_vcpu *vcpu, u64 off)
>   {
>   	int size;
> @@ -783,12 +801,34 @@ int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>   	return kvm_arm_sys_reg_get_reg(vcpu, reg);
>   }
>   
> +/*
> + * The RMI ABI only enables setting some GPRs and PC. The selection of GPRs
> + * that are available depends on the Realm state and the reason for the last
> + * exit.  All other registers are reset to architectural or otherwise defined
> + * reset values by the RMM, except for a few configuration fields that
> + * correspond to Realm parameters.
> + */
> +static bool validate_realm_set_reg(struct kvm_vcpu *vcpu,
> +				   const struct kvm_one_reg *reg)
> +{
> +	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_CORE) {
> +		u64 off = core_reg_offset_from_id(reg->id);
> +
> +		return kvm_realm_validate_core_reg(off);
> +	}
> +
> +	return false;
> +}
> +
>   int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>   {
>   	/* We currently use nothing arch-specific in upper 32 bits */
>   	if ((reg->id & ~KVM_REG_SIZE_MASK) >> 32 != KVM_REG_ARM64 >> 32)
>   		return -EINVAL;
>   
> +	if (kvm_is_realm(vcpu->kvm) && !validate_realm_set_reg(vcpu, reg))
> +		return -EINVAL;
> +
>   	switch (reg->id & KVM_REG_ARM_COPROC_MASK) {
>   	case KVM_REG_ARM_CORE:	return set_core_reg(vcpu, reg);
>   	case KVM_REG_ARM_FW:

Thanks,
Gavin


