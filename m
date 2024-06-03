Return-Path: <linux-kernel+bounces-198613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8ADB8D7AFD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 07:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18A101F21AA8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 05:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DED52231F;
	Mon,  3 Jun 2024 05:31:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5A518E3F;
	Mon,  3 Jun 2024 05:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717392682; cv=none; b=ZoCGsGxlIGYYPtcCNt5nxcl2mzrQlRiDdUyrSynSsnINH8TC6t5Ht0i1qTN03wdmvP4tS//tDpbciSZyaEwcm+j9RFVv4PFstwu2s0CEy2B2IHKrHEmlySSbkIzErTNnvQ9NW3cFO5AL8BBrQ1caQ59CfSYgWcsGtInKmDphIC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717392682; c=relaxed/simple;
	bh=/g2Gy1tVZ7oXBm4NOKsE0BsVNmAYkBeAS/Ro+GSSyvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rgqgtfXRwlt6NOfhUSENGBlIQfTFXOC4vQW4lBG55L+tbUDeGarzWq9TYRGDqGOlUgscBiShMQ663DZ9Pcv9HK56zkWbFih2TS9HcXuFo2AMVIYuP3JuMkoQ/fFEzhvyNEz15ALZuIaq4E5xWEFWGQBzBqevs5jC6QCHB0WimnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A46161042;
	Sun,  2 Jun 2024 22:31:43 -0700 (PDT)
Received: from [10.162.40.16] (a077893.blr.arm.com [10.162.40.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B54D23F762;
	Sun,  2 Jun 2024 22:31:13 -0700 (PDT)
Message-ID: <10baf4ee-db5b-4b5f-b618-7daab8aaf741@arm.com>
Date: Mon, 3 Jun 2024 11:01:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V17 2/9] KVM: arm64: Explicitly handle BRBE traps as
 UNDEFINED
Content-Language: en-US
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 will@kernel.org, catalin.marinas@arm.com, Mark Brown <broonie@kernel.org>,
 James Clark <james.clark@arm.com>, Rob Herring <robh@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Suzuki Poulose <suzuki.poulose@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 linux-perf-users@vger.kernel.org, Oliver Upton <oliver.upton@linux.dev>,
 James Morse <james.morse@arm.com>, kvmarm@lists.linux.dev
References: <20240405024639.1179064-1-anshuman.khandual@arm.com>
 <20240405024639.1179064-3-anshuman.khandual@arm.com>
 <Zkyg-xgJHK5D1zFs@J2N7QTR9R3>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Zkyg-xgJHK5D1zFs@J2N7QTR9R3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/21/24 18:56, Mark Rutland wrote:
> Hi Anshuman,
> 
> On Fri, Apr 05, 2024 at 08:16:32AM +0530, Anshuman Khandual wrote:
>> The Branch Record Buffer Extension (BRBE) adds a number of system registers
>> and instructions, which we don't currently intend to expose to guests. Our
>> existing logic handles this safely, but this could be improved with some
>> explicit handling of BRBE.
>>
>> The presence of BRBE is currently hidden from guests as the cpufeature
>> code's ftr_id_aa64dfr0[] table doesn't have an entry for the BRBE field,
>> and so this will be zero in the sanitised value of ID_AA64DFR0 exposed to
>> guests via read_sanitised_id_aa64dfr0_el1(). As the ftr_id_aa64dfr0[] table
>> may gain an entry for the BRBE field in future, for robustness we should
>> explicitly mask out the BRBE field in read_sanitised_id_aa64dfr0_el1().
>>
>> The BRBE system registers and instructions are currently trapped by the
>> existing configuration of the fine-grained traps. As neither the registers
>> are not described in the sys_reg_descs[] nor the instructions are described
>> in the sys_insn_descs[] table, emulate_sys_reg() will warn that these are
>> unknown before injecting an UNDEFINED exception into the guest.
> 
> That last sentence doesn't make sense, and I think it has been mangled.
> My suggested text in v16 was:
> 
> | As the registers and instructions are not described in the
> | sys_reg_descs[] table, emulate_sys_reg() will warn that these are
> | unknown before injecting an UNDEFINED exception into the guest.
> 
> ... and I'd be happy with changing that to:
> 
> | As neither the registers nor the instructions are described in the 
> | sys_reg_descs[] table, emulate_sys_reg() will warn that these are
> | unknown before injecting an UNDEFINED exception into the guest.

Sure, will replace the last sentence as suggested.

> 
>> Well-behaved guests shouldn't try to use the registers or instructions, but
>> badly-behaved guests could use these, resulting in unnecessary warnings.
> 
> I see that I had mangled this sentence originally -- thanks for
> correcting that; this looks fine to me.
> 
>> To avoid those warnings, we should explicitly handle the BRBE
>> registers, and instructions as UNDEFINED.
> 
> I think the added comma is unnecessary and makes this hard to read. My
> suggested text in v16 was:
> 
> | To avoid those warnings, we should explicitly handle the BRBE
> | registers and instructions as UNDEFINED.

Sure, will change.

> 
>> Address the above by having read_sanitised_id_aa64dfr0_el1() mask out the
>> ID_AA64DFR0.BRBE field, and by adding sys_reg_descs entries for all of the
>> BRBE system registers, also by adding sys_insn_descs entries for all of the
>> BRBE instructions, treating these all as UNDEFINED.
> 
> Similarly, I think this was clearer as I originally suggested:
> 
> | Address the above by having read_sanitised_id_aa64dfr0_el1() mask out
> | the ID_AA64DFR0.BRBE field, and by adding sys_reg_desc entries for all
> | of the BRBE system registers and instructions, treating these all as
> | UNDEFINED.
> 
> ... or we can simplify that to:
> 
> | Address the above by having read_sanitised_id_aa64dfr0_el1() mask out
> | the ID_AA64DFR0.BRBE field, and explicitly handling all of the BRBE
> | system registers and instructions as UNDEFINED.

Sure, will change the above as suggested.

After all these changes, final commit message looks like the following.

KVM: arm64: Explicitly handle BRBE traps as UNDEFINED

The Branch Record Buffer Extension (BRBE) adds a number of system registers
and instructions, which we don't currently intend to expose to guests. Our
existing logic handles this safely, but this could be improved with some
explicit handling of BRBE.

The presence of BRBE is currently hidden from guests as the cpufeature
code's ftr_id_aa64dfr0[] table doesn't have an entry for the BRBE field,
and so this will be zero in the sanitised value of ID_AA64DFR0 exposed to
guests via read_sanitised_id_aa64dfr0_el1(). As the ftr_id_aa64dfr0[] table
may gain an entry for the BRBE field in future, for robustness we should
explicitly mask out the BRBE field in read_sanitised_id_aa64dfr0_el1().

The BRBE system registers and instructions are currently trapped by the
existing configuration of the fine-grained traps. As neither the registers
nor the instructions are described in the sys_reg_descs[] table,
emulate_sys_reg() will warn that these are unknown before injecting an
UNDEFINED exception into the guest.

Well-behaved guests shouldn't try to use the registers or instructions, but
badly-behaved guests could use these, resulting in unnecessary warnings. To
avoid those warnings, we should explicitly handle the BRBE registers and
instructions as UNDEFINED.

Address the above by having read_sanitised_id_aa64dfr0_el1() mask out the
ID_AA64DFR0.BRBE field, and explicitly handling all of the BRBE system
registers and instructions as UNDEFINED.

> 
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: Oliver Upton <oliver.upton@linux.dev>
>> Cc: James Morse <james.morse@arm.com>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: kvmarm@lists.linux.dev
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ----
>> Changes in V17:
>>
>> - Updated the commit message including about sys_insn_descs[]
>> - Changed KVM to use existing SYS_BRBSRC/TGT/INF_EL1(n) format
>> - Moved the BRBE instructions into sys_insn_descs[] array
> 
> Aside from my nits on the commit message above, these changes all look
> good to me. So with the commit message cleaned up as above:
> 
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Thanks Mark.

> 
> Mark.
> 
>>
>>  arch/arm64/kvm/sys_regs.c | 56 +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 56 insertions(+)
>>
>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> index c9f4f387155f..3981aa32c5a3 100644
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -1304,6 +1304,11 @@ static int set_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
>>  	return 0;
>>  }
>>  
>> +#define BRB_INF_SRC_TGT_EL1(n)				\
>> +	{ SYS_DESC(SYS_BRBINF_EL1(n)), undef_access },	\
>> +	{ SYS_DESC(SYS_BRBSRC_EL1(n)), undef_access },	\
>> +	{ SYS_DESC(SYS_BRBTGT_EL1(n)), undef_access }	\
>> +
>>  /* Silly macro to expand the DBG{BCR,BVR,WVR,WCR}n_EL1 registers in one go */
>>  #define DBG_BCR_BVR_WCR_WVR_EL1(n)					\
>>  	{ SYS_DESC(SYS_DBGBVRn_EL1(n)),					\
>> @@ -1708,6 +1713,9 @@ static u64 read_sanitised_id_aa64dfr0_el1(struct kvm_vcpu *vcpu,
>>  	/* Hide SPE from guests */
>>  	val &= ~ID_AA64DFR0_EL1_PMSVer_MASK;
>>  
>> +	/* Hide BRBE from guests */
>> +	val &= ~ID_AA64DFR0_EL1_BRBE_MASK;
>> +
>>  	return val;
>>  }
>>  
>> @@ -2226,6 +2234,52 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>>  	{ SYS_DESC(SYS_DBGCLAIMCLR_EL1), trap_raz_wi },
>>  	{ SYS_DESC(SYS_DBGAUTHSTATUS_EL1), trap_dbgauthstatus_el1 },
>>  
>> +	/*
>> +	 * BRBE branch record sysreg address space is interleaved between
>> +	 * corresponding BRBINF<N>_EL1, BRBSRC<N>_EL1, and BRBTGT<N>_EL1.
>> +	 */
>> +	BRB_INF_SRC_TGT_EL1(0),
>> +	BRB_INF_SRC_TGT_EL1(16),
>> +	BRB_INF_SRC_TGT_EL1(1),
>> +	BRB_INF_SRC_TGT_EL1(17),
>> +	BRB_INF_SRC_TGT_EL1(2),
>> +	BRB_INF_SRC_TGT_EL1(18),
>> +	BRB_INF_SRC_TGT_EL1(3),
>> +	BRB_INF_SRC_TGT_EL1(19),
>> +	BRB_INF_SRC_TGT_EL1(4),
>> +	BRB_INF_SRC_TGT_EL1(20),
>> +	BRB_INF_SRC_TGT_EL1(5),
>> +	BRB_INF_SRC_TGT_EL1(21),
>> +	BRB_INF_SRC_TGT_EL1(6),
>> +	BRB_INF_SRC_TGT_EL1(22),
>> +	BRB_INF_SRC_TGT_EL1(7),
>> +	BRB_INF_SRC_TGT_EL1(23),
>> +	BRB_INF_SRC_TGT_EL1(8),
>> +	BRB_INF_SRC_TGT_EL1(24),
>> +	BRB_INF_SRC_TGT_EL1(9),
>> +	BRB_INF_SRC_TGT_EL1(25),
>> +	BRB_INF_SRC_TGT_EL1(10),
>> +	BRB_INF_SRC_TGT_EL1(26),
>> +	BRB_INF_SRC_TGT_EL1(11),
>> +	BRB_INF_SRC_TGT_EL1(27),
>> +	BRB_INF_SRC_TGT_EL1(12),
>> +	BRB_INF_SRC_TGT_EL1(28),
>> +	BRB_INF_SRC_TGT_EL1(13),
>> +	BRB_INF_SRC_TGT_EL1(29),
>> +	BRB_INF_SRC_TGT_EL1(14),
>> +	BRB_INF_SRC_TGT_EL1(30),
>> +	BRB_INF_SRC_TGT_EL1(15),
>> +	BRB_INF_SRC_TGT_EL1(31),
>> +
>> +	/* Remaining BRBE sysreg addresses space */
>> +	{ SYS_DESC(SYS_BRBCR_EL1), undef_access },
>> +	{ SYS_DESC(SYS_BRBFCR_EL1), undef_access },
>> +	{ SYS_DESC(SYS_BRBTS_EL1), undef_access },
>> +	{ SYS_DESC(SYS_BRBINFINJ_EL1), undef_access },
>> +	{ SYS_DESC(SYS_BRBSRCINJ_EL1), undef_access },
>> +	{ SYS_DESC(SYS_BRBTGTINJ_EL1), undef_access },
>> +	{ SYS_DESC(SYS_BRBIDR0_EL1), undef_access },
>> +
>>  	{ SYS_DESC(SYS_MDCCSR_EL0), trap_raz_wi },
>>  	{ SYS_DESC(SYS_DBGDTR_EL0), trap_raz_wi },
>>  	// DBGDTR[TR]X_EL0 share the same encoding
>> @@ -2738,6 +2792,8 @@ static struct sys_reg_desc sys_insn_descs[] = {
>>  	{ SYS_DESC(SYS_DC_CISW), access_dcsw },
>>  	{ SYS_DESC(SYS_DC_CIGSW), access_dcgsw },
>>  	{ SYS_DESC(SYS_DC_CIGDSW), access_dcgsw },
>> +	{ SYS_DESC(OP_BRB_IALL), undef_access },
>> +	{ SYS_DESC(OP_BRB_INJ), undef_access },
>>  };
>>  
>>  static const struct sys_reg_desc *first_idreg;
>> -- 
>> 2.25.1
>>

