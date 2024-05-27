Return-Path: <linux-kernel+bounces-190228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 598098CFBA5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0860B282350
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9849869D31;
	Mon, 27 May 2024 08:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QLC2tl7y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1494D60B96
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 08:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716799068; cv=none; b=ecF7I6y9N8ocyYaaMqPJODXlVjv/ZO/kQ0uFAYoEei7Dzo2Bg4KnIlowqkcVZAD/uSk9p5NxuZkdmvrvBngfeMlWBTbfNjPmWyPQFCbOw0E1z6s35g3VPNuEctuA26vf+sAaerKi/W6pgJAGTZSTNVWgOdcqidFqrP9nV3W6bRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716799068; c=relaxed/simple;
	bh=XSj0u9ZXJq+7eaf8CcbjM7rxWFfV/W6a4v1ocsfitkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bqF5bhxqbMlZrGHg/d8U16kJhVmZfGJyVqtorhIyRqmRFmssTDgp5J2yhWcMIBZpFLChHPNDU7koz0wgunvI0zVzO2izNB1y4pPc0qA68XrpcGbM3bJPyNJY+kYeSv/w3prryjM7YWJOUIjNF4scHJoLlfPPtg8s6kFOcCld5Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QLC2tl7y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716799065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D/RhgMwEECZFR61s8FYcjWW0awngsyyphJgJ6n/lYf0=;
	b=QLC2tl7ysR9GYBT/UJbeM1ffDcQ1J51u5taf2BLrayxg1uFpfMSq56EqOP92OAOW77yFnh
	R7+0rJZhZLctj/62NEosyzJ/sAEVR7rdC+l/BwNfMIi52MhuG3VkHPtHvOLfDnUHwmXSqj
	9OaBwVhk7mIbwuT90Dh0HhXBANqoZKs=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-RblCSnoSMBCOc2DRxMkSFA-1; Mon, 27 May 2024 04:37:43 -0400
X-MC-Unique: RblCSnoSMBCOc2DRxMkSFA-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-6819d78567bso353841a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 01:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716799063; x=1717403863;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D/RhgMwEECZFR61s8FYcjWW0awngsyyphJgJ6n/lYf0=;
        b=iG2ay7yjFBv8xfl/BgqZvPAIo9ov41mmexEWNkcSxbHdU350ECsUW/osbkX2Ix7upy
         YlA/2PARR0hrbZF31GinoIgy6FZpUBn4RdfnUV3IykC5ejGgcmfNam3FPW5irqCl1o2f
         0GPl4uFvoCO+DB16NQCoHzNAfgwitrY3kaQuozVwWjZKjyW+smNCkC3TvPaRPQWILrd+
         Ak1oDDk8Ogn+hENaG0JpEBsB4RyuPfjwZfNzToAd0gdvRuETke+cWIzo/gVnW2ksXB7P
         biufN2c2/GEsrYun1GUx981lpweEsdChj1b1fX0W715iNBANnxYD/Jqh/4Mh6j3OK2Gi
         q8Jg==
X-Forwarded-Encrypted: i=1; AJvYcCXHG+QZGFdWgl6UDXODPwT4/DEWE1MPb/zTLh5UQrWnqzhFkl8jZ3g244S2mISd6/hSKyoT/kWb4IJkwaUMRakfFITqpumBiMdVYA7T
X-Gm-Message-State: AOJu0YxcvGAysCDPAAnKib/jY1UAlK2SHo+/8DhvadkzMTuUNXmxcimt
	39cOewBGHZsgy0qGLRdPM2wBvs4OlLUKTpYPlsvRBzdl+daySs/QpklMNqa6Ru1fM5ge71S+hnJ
	VvisL75aDWNmDAAL/U0oPsZyP1hghsfyhMD+SC3NnzHBENYBKgKI8EbrDWjT3Lg==
X-Received: by 2002:a17:902:d503:b0:1f4:81ab:7574 with SMTP id d9443c01a7336-1f481ab85b9mr41684735ad.5.1716799062532;
        Mon, 27 May 2024 01:37:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGscjyoiNahK4cBQM5AzDuutXhTg6JzVpYGLAK35GPyBGADXPe1FF2yh44qdXXpiGi7ipjNyQ==
X-Received: by 2002:a17:902:d503:b0:1f4:81ab:7574 with SMTP id d9443c01a7336-1f481ab85b9mr41684485ad.5.1716799061972;
        Mon, 27 May 2024 01:37:41 -0700 (PDT)
Received: from [10.66.61.39] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f4ae2cc802sm7096095ad.17.2024.05.27.01.37.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 01:37:41 -0700 (PDT)
Message-ID: <f96971e3-f92a-4dca-8e74-a00c9a8505f0@redhat.com>
Date: Mon, 27 May 2024 16:37:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] KVM: arm64: maintain per VM value for CTR_EL0
To: Sebastian Ott <sebott@redhat.com>, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 James Morse <james.morse@arm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>
References: <20240514072252.5657-1-sebott@redhat.com>
 <20240514072252.5657-3-sebott@redhat.com>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <20240514072252.5657-3-sebott@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sebastian,

On 5/14/24 15:22, Sebastian Ott wrote:
> In preparation for CTR_EL0 emulation maintain a per VM for this
s/per VM/per VM value/     would be better
> register and use it where appropriate.
> 
> Signed-off-by: Sebastian Ott <sebott@redhat.com>
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>

Thanks,
Shaoqin
> ---
>   arch/arm64/include/asm/kvm_host.h |  2 ++
>   arch/arm64/kvm/sys_regs.c         | 21 ++++++++++++++-------
>   2 files changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 212ae77eefaf..1259be5e2f3e 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -331,6 +331,8 @@ struct kvm_arch {
>   #define KVM_ARM_ID_REG_NUM	(IDREG_IDX(sys_reg(3, 0, 0, 7, 7)) + 1)
>   	u64 id_regs[KVM_ARM_ID_REG_NUM];
>   
> +	u64 ctr_el0;
> +
>   	/* Masks for VNCR-baked sysregs */
>   	struct kvm_sysreg_masks	*sysreg_masks;
>   
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 41741bf4d2b2..0213c96f73f2 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -219,9 +219,9 @@ void vcpu_write_sys_reg(struct kvm_vcpu *vcpu, u64 val, int reg)
>    * Returns the minimum line size for the selected cache, expressed as
>    * Log2(bytes).
>    */
> -static u8 get_min_cache_line_size(bool icache)
> +static u8 get_min_cache_line_size(struct kvm *kvm, bool icache)
>   {
> -	u64 ctr = read_sanitised_ftr_reg(SYS_CTR_EL0);
> +	u64 ctr = kvm->arch.ctr_el0;
>   	u8 field;
>   
>   	if (icache)
> @@ -248,7 +248,7 @@ static u32 get_ccsidr(struct kvm_vcpu *vcpu, u32 csselr)
>   	if (vcpu->arch.ccsidr)
>   		return vcpu->arch.ccsidr[csselr];
>   
> -	line_size = get_min_cache_line_size(csselr & CSSELR_EL1_InD);
> +	line_size = get_min_cache_line_size(vcpu->kvm, csselr & CSSELR_EL1_InD);
>   
>   	/*
>   	 * Fabricate a CCSIDR value as the overriding value does not exist.
> @@ -283,7 +283,7 @@ static int set_ccsidr(struct kvm_vcpu *vcpu, u32 csselr, u32 val)
>   	u32 i;
>   
>   	if ((val & CCSIDR_EL1_RES0) ||
> -	    line_size < get_min_cache_line_size(csselr & CSSELR_EL1_InD))
> +	    line_size < get_min_cache_line_size(vcpu->kvm, csselr & CSSELR_EL1_InD))
>   		return -EINVAL;
>   
>   	if (!ccsidr) {
> @@ -1886,7 +1886,7 @@ static bool access_ctr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
>   	if (p->is_write)
>   		return write_to_read_only(vcpu, p, r);
>   
> -	p->regval = read_sanitised_ftr_reg(SYS_CTR_EL0);
> +	p->regval = vcpu->kvm->arch.ctr_el0;
>   	return true;
>   }
>   
> @@ -1906,7 +1906,7 @@ static bool access_clidr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
>    */
>   static u64 reset_clidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
>   {
> -	u64 ctr_el0 = read_sanitised_ftr_reg(SYS_CTR_EL0);
> +	u64 ctr_el0 = vcpu->kvm->arch.ctr_el0;
>   	u64 clidr;
>   	u8 loc;
>   
> @@ -1959,8 +1959,8 @@ static u64 reset_clidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
>   static int set_clidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
>   		      u64 val)
>   {
> -	u64 ctr_el0 = read_sanitised_ftr_reg(SYS_CTR_EL0);
>   	u64 idc = !CLIDR_LOC(val) || (!CLIDR_LOUIS(val) && !CLIDR_LOUU(val));
> +	u64 ctr_el0 = vcpu->kvm->arch.ctr_el0;
>   
>   	if ((val & CLIDR_EL1_RES0) || (!(ctr_el0 & CTR_EL0_IDC) && idc))
>   		return -EINVAL;
> @@ -3557,6 +3557,13 @@ void kvm_reset_sys_regs(struct kvm_vcpu *vcpu)
>   	struct kvm *kvm = vcpu->kvm;
>   	unsigned long i;
>   
> +	if (!kvm_vcpu_initialized(vcpu))
> +		/*
> +		 * Make sure CTR_EL0 is initialized before registers
> +		 * that depend on it are reset.
> +		 */
> +		kvm->arch.ctr_el0 = read_sanitised_ftr_reg(SYS_CTR_EL0);
> +
>   	for (i = 0; i < ARRAY_SIZE(sys_reg_descs); i++) {
>   		const struct sys_reg_desc *r = &sys_reg_descs[i];
>   

-- 
Shaoqin


