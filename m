Return-Path: <linux-kernel+bounces-216738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF3790A5B2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 687191C26C2C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 06:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCE1184129;
	Mon, 17 Jun 2024 06:27:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FD1DDAD;
	Mon, 17 Jun 2024 06:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718605644; cv=none; b=s5/2wV/qjIEFn28mbrKkouG4GW3OUisz7195pMQt8KNci/aQKVZVjzlxqDCyXb2UTtoPSPFx1P5OIUM9v4SjbxJxw5SClDNwMcOTKVmLDUHuAR+tPRgL65lav7LSCRRepANNfJ433EHXXCgSnRwhu5OIUEKezLe4dNXsiQHkGiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718605644; c=relaxed/simple;
	bh=K8+24yKI7+m3hynQfWl4kgiw2Ley3iKSoefTvT71/qY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FNj+0axTULU2D9Z37PQUE+K2WTigj4zcLNrZAsc5h7C51o7rHRK/yOsXuDNemu9lVXKGEta2qg95w2cP4i6Q90c1YR70E2FilcJxsumUwScMjjHk4PE6xUlIEzuWaTt9p8S8adsbgN0A39S9gBXhq2P8W7do0B2eDCuwHfnVIWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB591DA7;
	Sun, 16 Jun 2024 23:27:45 -0700 (PDT)
Received: from [10.162.16.42] (a077893.blr.arm.com [10.162.16.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D33F3F73B;
	Sun, 16 Jun 2024 23:27:16 -0700 (PDT)
Message-ID: <df348434-85af-4bae-a31a-4a4a93c3cf49@arm.com>
Date: Mon, 17 Jun 2024 11:57:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V18 2/9] KVM: arm64: Explicitly handle BRBE traps as
 UNDEFINED
Content-Language: en-US
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
 Mark Brown <broonie@kernel.org>, James Clark <james.clark@arm.com>,
 Rob Herring <robh@kernel.org>, Suzuki Poulose <suzuki.poulose@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 linux-perf-users@vger.kernel.org, Oliver Upton <oliver.upton@linux.dev>,
 James Morse <james.morse@arm.com>, kvmarm@lists.linux.dev
References: <20240613061731.3109448-1-anshuman.khandual@arm.com>
 <20240613061731.3109448-3-anshuman.khandual@arm.com>
 <86sexfk8ke.wl-maz@kernel.org> <86r0czk6wd.wl-maz@kernel.org>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <86r0czk6wd.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/14/24 18:39, Marc Zyngier wrote:
> On Fri, 14 Jun 2024 13:33:37 +0100,
> Marc Zyngier <maz@kernel.org> wrote:
>>
>> On Thu, 13 Jun 2024 07:17:24 +0100,
>> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>>>
>>> The Branch Record Buffer Extension (BRBE) adds a number of system registers
>>> and instructions, which we don't currently intend to expose to guests. Our
>>> existing logic handles this safely, but this could be improved with some
>>> explicit handling of BRBE.
>>>
>>> The presence of BRBE is currently hidden from guests as the cpufeature
>>> code's ftr_id_aa64dfr0[] table doesn't have an entry for the BRBE field,
>>> and so this will be zero in the sanitised value of ID_AA64DFR0 exposed to
>>> guests via read_sanitised_id_aa64dfr0_el1(). As the ftr_id_aa64dfr0[] table
>>> may gain an entry for the BRBE field in future, for robustness we should
>>> explicitly mask out the BRBE field in read_sanitised_id_aa64dfr0_el1().
>>>
>>> The BRBE system registers and instructions are currently trapped by the
>>> existing configuration of the fine-grained traps. As neither the registers
>>> nor the instructions are described in the sys_reg_descs[] table,
>>> emulate_sys_reg() will warn that these are unknown before injecting an
>>> UNDEFINED exception into the guest.
>>>
>>> Well-behaved guests shouldn't try to use the registers or instructions, but
>>> badly-behaved guests could use these, resulting in unnecessary warnings. To
>>> avoid those warnings, we should explicitly handle the BRBE registers and
>>> instructions as UNDEFINED.
>>>
>>> Address the above by having read_sanitised_id_aa64dfr0_el1() mask out the
>>> ID_AA64DFR0.BRBE field, and explicitly handling all of the BRBE system
>>> registers and instructions as UNDEFINED.
>>>
>>> Cc: Marc Zyngier <maz@kernel.org>
>>> Cc: Oliver Upton <oliver.upton@linux.dev>
>>> Cc: James Morse <james.morse@arm.com>
>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: kvmarm@lists.linux.dev
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ----
>>> Changes in V18:
>>>
>>> - Updated the commit message
>>>
>>>  arch/arm64/kvm/sys_regs.c | 56 +++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 56 insertions(+)
>>> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
>>> ---
>>>  arch/arm64/kvm/sys_regs.c | 56 +++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 56 insertions(+)
>>>
>>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>>> index 22b45a15d068..3d4686abe5ee 100644
>>> --- a/arch/arm64/kvm/sys_regs.c
>>> +++ b/arch/arm64/kvm/sys_regs.c
>>> @@ -1304,6 +1304,11 @@ static int set_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
>>>  	return 0;
>>>  }
>>>  
>>> +#define BRB_INF_SRC_TGT_EL1(n)				\
>>> +	{ SYS_DESC(SYS_BRBINF_EL1(n)), undef_access },	\
>>> +	{ SYS_DESC(SYS_BRBSRC_EL1(n)), undef_access },	\
>>> +	{ SYS_DESC(SYS_BRBTGT_EL1(n)), undef_access }	\
>>> +
>>>  /* Silly macro to expand the DBG{BCR,BVR,WVR,WCR}n_EL1 registers in one go */
>>>  #define DBG_BCR_BVR_WCR_WVR_EL1(n)					\
>>>  	{ SYS_DESC(SYS_DBGBVRn_EL1(n)),					\
>>> @@ -1722,6 +1727,9 @@ static u64 read_sanitised_id_aa64dfr0_el1(struct kvm_vcpu *vcpu,
>>>  	/* Hide SPE from guests */
>>>  	val &= ~ID_AA64DFR0_EL1_PMSVer_MASK;
>>>  
>>> +	/* Hide BRBE from guests */
>>> +	val &= ~ID_AA64DFR0_EL1_BRBE_MASK;
>>> +
>>>  	return val;
>>>  }
>>>  
>>> @@ -2240,6 +2248,52 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>>>  	{ SYS_DESC(SYS_DBGCLAIMCLR_EL1), trap_raz_wi },
>>>  	{ SYS_DESC(SYS_DBGAUTHSTATUS_EL1), trap_dbgauthstatus_el1 },
>>>  
>>> +	/*
>>> +	 * BRBE branch record sysreg address space is interleaved between
>>> +	 * corresponding BRBINF<N>_EL1, BRBSRC<N>_EL1, and BRBTGT<N>_EL1.
>>> +	 */
>>> +	BRB_INF_SRC_TGT_EL1(0),
>>> +	BRB_INF_SRC_TGT_EL1(16),
>>> +	BRB_INF_SRC_TGT_EL1(1),
>>> +	BRB_INF_SRC_TGT_EL1(17),
>>> +	BRB_INF_SRC_TGT_EL1(2),
>>> +	BRB_INF_SRC_TGT_EL1(18),
>>> +	BRB_INF_SRC_TGT_EL1(3),
>>> +	BRB_INF_SRC_TGT_EL1(19),
>>> +	BRB_INF_SRC_TGT_EL1(4),
>>> +	BRB_INF_SRC_TGT_EL1(20),
>>> +	BRB_INF_SRC_TGT_EL1(5),
>>> +	BRB_INF_SRC_TGT_EL1(21),
>>> +	BRB_INF_SRC_TGT_EL1(6),
>>> +	BRB_INF_SRC_TGT_EL1(22),
>>> +	BRB_INF_SRC_TGT_EL1(7),
>>> +	BRB_INF_SRC_TGT_EL1(23),
>>> +	BRB_INF_SRC_TGT_EL1(8),
>>> +	BRB_INF_SRC_TGT_EL1(24),
>>> +	BRB_INF_SRC_TGT_EL1(9),
>>> +	BRB_INF_SRC_TGT_EL1(25),
>>> +	BRB_INF_SRC_TGT_EL1(10),
>>> +	BRB_INF_SRC_TGT_EL1(26),
>>> +	BRB_INF_SRC_TGT_EL1(11),
>>> +	BRB_INF_SRC_TGT_EL1(27),
>>> +	BRB_INF_SRC_TGT_EL1(12),
>>> +	BRB_INF_SRC_TGT_EL1(28),
>>> +	BRB_INF_SRC_TGT_EL1(13),
>>> +	BRB_INF_SRC_TGT_EL1(29),
>>> +	BRB_INF_SRC_TGT_EL1(14),
>>> +	BRB_INF_SRC_TGT_EL1(30),
>>> +	BRB_INF_SRC_TGT_EL1(15),
>>> +	BRB_INF_SRC_TGT_EL1(31),
>>> +
>>> +	/* Remaining BRBE sysreg addresses space */
>>> +	{ SYS_DESC(SYS_BRBCR_EL1), undef_access },
>>> +	{ SYS_DESC(SYS_BRBFCR_EL1), undef_access },
>>> +	{ SYS_DESC(SYS_BRBTS_EL1), undef_access },
>>> +	{ SYS_DESC(SYS_BRBINFINJ_EL1), undef_access },
>>> +	{ SYS_DESC(SYS_BRBSRCINJ_EL1), undef_access },
>>> +	{ SYS_DESC(SYS_BRBTGTINJ_EL1), undef_access },
>>> +	{ SYS_DESC(SYS_BRBIDR0_EL1), undef_access },
>>> +
>>>  	{ SYS_DESC(SYS_MDCCSR_EL0), trap_raz_wi },
>>>  	{ SYS_DESC(SYS_DBGDTR_EL0), trap_raz_wi },
>>>  	// DBGDTR[TR]X_EL0 share the same encoding
>>> @@ -2751,6 +2805,8 @@ static struct sys_reg_desc sys_insn_descs[] = {
>>>  	{ SYS_DESC(SYS_DC_CISW), access_dcsw },
>>>  	{ SYS_DESC(SYS_DC_CIGSW), access_dcgsw },
>>>  	{ SYS_DESC(SYS_DC_CIGDSW), access_dcgsw },
>>> +	{ SYS_DESC(OP_BRB_IALL), undef_access },
>>> +	{ SYS_DESC(OP_BRB_INJ), undef_access },
>>>  };
>>>  
>>>  static const struct sys_reg_desc *first_idreg;
>>
>> I don't think we need any update to the sys_reg table to handle
>> this. Instead, we should make use of the FGU infrastructure that has
>> been in since 6.9 to make this stuff UNDEF unconditionally.
>>
>> It should be as simple as:
>>
>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> index ee33f5467ce5..7cafe3f72c01 100644
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -4964,6 +4964,11 @@ void kvm_init_sysreg(struct kvm_vcpu *vcpu)
>>  		kvm->arch.fgu[HAFGRTR_GROUP] |= ~(HAFGRTR_EL2_RES0 |
>>  						  HAFGRTR_EL2_RES1);
>>  
>> +	if (!kvm_has_feat(kvm, ID_AA64DFR0_EL1, BRBE, IMP))
>> +		kvm->arch.fgu[HDFGRTR_GROUP] |= (HDFGRTR_nBRBDATA |
>> +						 HDFGRTR_nBRBCTL  |
>> +						 HDFGRTR_nBRBIDR);
>> +
>>  	set_bit(KVM_ARCH_FLAG_FGU_INITIALIZED, &kvm->arch.flags);
>>  out:
>>  	mutex_unlock(&kvm->arch.config_lock);
>>
>> which is of course untested, but that I expect to be correct.
> 
> Actually, to disable the *instructions*, a similar hack must be
> applied to HFGITR_EL2. The resulting patch should be something like:
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index ee33f5467ce5..49d86dae8d80 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -4964,6 +4964,15 @@ void kvm_init_sysreg(struct kvm_vcpu *vcpu)
>  		kvm->arch.fgu[HAFGRTR_GROUP] |= ~(HAFGRTR_EL2_RES0 |
>  						  HAFGRTR_EL2_RES1);
>  
> +	if (!kvm_has_feat(kvm, ID_AA64DFR0_EL1, BRBE, IMP)) {
> +		kvm->arch.fgu[HDFGRTR_GROUP] |= (HDFGRTR_nBRBDATA  |
> +						 HDFGRTR_nBRBCTL   |
> +						 HDFGRTR_nBRBIDR);
> +		kvm->arch.fgu[HFGITR_GROUP] |= (HFGITR_EL2_nBRBINJ |
> +						HFGITR_EL2_nBRBIALL);
> +	}
> +
> +
>  	set_bit(KVM_ARCH_FLAG_FGU_INITIALIZED, &kvm->arch.flags);
>  out:
>  	mutex_unlock(&kvm->arch.config_lock);

This makes sense, will remove all the changes to sys_reg table and
instead fold the above suggestion into the patch.

> 
> The implicit dependency here is that FGT is always present on a system
> that implements BRBE. The architecture supports this assertion:
> 
> - BRBE is not available before ARMv9.1
> - FGT is mandatory from ARMv8.6
> 
> Given that v9.1 is congruent to v8.6, we have the required overlap.

So this overlap need not be asserted in software again ?

