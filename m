Return-Path: <linux-kernel+bounces-284188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 830B394FE1D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A866B1C22443
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355F84317C;
	Tue, 13 Aug 2024 06:53:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224A73BBFB
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 06:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723532021; cv=none; b=RbPSy4RntagbtQbKVtzLV3q8deG3LYvh92/j7uSC150QQm0WSNRK6g0xCbcXUyq6uBNc7uopD1CuKImJqR8loonGWZx3kZhvoozR9/sPc0YgKpsIXRkTM0XpWUJ9YfoeSTNH8LnwYrzd0qp7Zbs+fywLtUDraB8g3XYdE7hyfOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723532021; c=relaxed/simple;
	bh=qemWfSTJHKWEHM94RKC3FR9sl/oT0O+11bgLPLS0EIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pgayxhk4fm+8ej1Pc+kPY6PGtTcTqf0PNmUCfyiJOy8evs/Uc52V++XEWPtR2/C5JZ0P1CM0hulqsRDzPTbMeWC/WshZ1bt3Sn9VdncOtvzDiwhFYmcb1q7cKR5MRLdk2HJ2UOhaK1jON5KMBIBuFTvdvO+/wTgSuEudhnD3fUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3585112FC;
	Mon, 12 Aug 2024 23:54:03 -0700 (PDT)
Received: from [10.163.57.59] (unknown [10.163.57.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B169D3F40C;
	Mon, 12 Aug 2024 23:53:33 -0700 (PDT)
Message-ID: <6c479aba-10b9-46ba-92fa-d3b20cc82d61@arm.com>
Date: Tue, 13 Aug 2024 12:23:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 10/10] KVM: arm64: nv: Add new HDFGRTR2_GROUP &
 HDFGRTR2_GROUP based FGU handling
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Brown <broonie@kernel.org>, kvmarm@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240620065807.151540-1-anshuman.khandual@arm.com>
 <20240620065807.151540-11-anshuman.khandual@arm.com>
 <865xu3kh4r.wl-maz@kernel.org> <4d256df7-1ec7-4300-b5c8-355f46c0e869@arm.com>
 <878qyy35e5.wl-maz@kernel.org> <47dc4299-52cc-4f98-929b-fb86bd9757ae@arm.com>
 <86tthhi0nz.wl-maz@kernel.org> <c84d0081-5afa-4bc2-82f4-a6dd07b8ab87@arm.com>
 <86o76c1b8p.wl-maz@kernel.org> <d56735e2-3fee-4d91-84e1-a5b480ec0ce1@arm.com>
 <86bk2b198o.wl-maz@kernel.org> <fb9bef18-adf2-4d3a-8205-b22a65b0c6db@arm.com>
 <87sevk4kgr.wl-maz@kernel.org>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <87sevk4kgr.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/4/24 16:35, Marc Zyngier wrote:
> On Sat, 03 Aug 2024 11:38:11 +0100,
> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>>
>> On 8/2/24 16:29, Marc Zyngier wrote:
>>> On Fri, 02 Aug 2024 10:25:44 +0100,
>>> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>>>> On 8/1/24 21:33, Marc Zyngier wrote:
>>>>> On Thu, 01 Aug 2024 11:46:22 +0100,
>>>>> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>>> [...]
>>>
>>>>>> +	SR_FGT(SYS_SPMACCESSR_EL1,	HDFGRTR2, nSPMACCESSR_EL1, 0),
>>>>> This (and I take it most of the stuff here) is also gated by
>>>>> MDCR_EL2.SPM, which is a coarse grained trap. That needs to be
>>>>> described as well. For every new register that you add here.
>>>> I did not find a SPM field in MDCR_EL2 either in latest ARM ARM or in
>>>> the latest XML. But as per current HDFGRTR2_EL2 description the field
>>>> nSPMACCESSR_EL1 is gated by FEAT_SPMU feature, which is being checked
>>>> via ID_AA64DFR1_EL1.PMU when required. So could you please give some
>>>> more details.
>>> I misspelled it. It is MDCR_EL2.EnSPM.
>>>
>>> And you are completely missing the point. It is not about
>>> HDFGRTR2_EL2, but about SPMACCESSR_EL1 (and all its little friends).
>>>
>>> To convince yourself, just look at the pseudocode for SPMACCESSR_EL1,
>>> limited to an EL1 access:
>>>
>>> elsif PSTATE.EL == EL1 then
>>>     if HaveEL(EL3) && EL3SDDUndefPriority() && MDCR_EL3.EnPM2 == '0' then
>>>         UNDEFINED;
>>>     elsif EL2Enabled() && IsFeatureImplemented(FEAT_FGT2) && ((HaveEL(EL3) && SCR_EL3.FGTEn2 == '0') || HDFGRTR2_EL2.nSPMACCESSR_EL1 == '0') then
>>>         AArch64.SystemAccessTrap(EL2, 0x18);
>>>     elsif EL2Enabled() && MDCR_EL2.EnSPM == '0' then
>>>         AArch64.SystemAccessTrap(EL2, 0x18);
>>>     elsif HaveEL(EL3) && MDCR_EL3.EnPM2 == '0' then
>>>         if EL3SDDUndef() then
>>>             UNDEFINED;
>>>         else
>>>             AArch64.SystemAccessTrap(EL3, 0x18);
>>>     elsif EffectiveHCR_EL2_NVx() IN {'111'} then
>>>         X[t, 64] = NVMem[0x8E8];
>>>     else
>>>         X[t, 64] = SPMACCESSR_EL1;
>>>
>>>
>>> Can you spot the *TWO* conditions where we take an exception to EL2
>>> with 0x18 as the EC?
>>>
>>> - One is when HDFGxTR2_EL2.nSPMACCESSR_EL1 == '0': that's a fine
>>>   grained trap.
>>> - The other is when MDCR_EL2.EnSPM == '0': that's a coarse grained
>>>   trap.
>>>
>>> Both conditions need to be captured in the various tables in this
>>> file, for each and every register that you describe.
>> Ahh, got it now. Because now KVM knows about SPMACCESSR_EL1 register,
>> access to that register must also be enabled via both fine grained trap
>> (HDFGxTR2_EL2.nSPMACCESSR_EL1) and coarse grained trap (MDCR_EL2.EnSPM).
>>
>> For all the registers that are being added via FEAT_FGT2 here in this
>> patch, their corresponding CGT based path also needs to be enabled via
>> corresponding CGT_MDCR_XXX groups.
> Exactly.
> 
>>> [...]
>>>
>>>>> Now, the main issues are that:
>>>>>
>>>>> - you're missing the coarse grained trapping for all the stuff you
>>>>>   have just added. It's not a huge amount of work, but you need, for
>>>>>   each register, to describe what traps apply to it. The fine grained
>>>>>   stuff is most, but not all of it. There should be enough of it
>>>>>   already to guide you through it.
>>>> Coarse grained trapping for FEAT_FGT2 based fine grained registers ?
>>> Not for FEAT_FGT2. For the registers that FEAT_FGT2 traps. Can you see
>>> the difference?
>> Understood, for example PMIAR_EL1 register which FEAT_FGT2 now traps via
>>
>> SR_FGT(SYS_PMIAR_EL1,           HDFGRTR2, nPMIAR_EL1, 0),
>>
>> also needs to have corresponding coarse grained trap.
>>
>> SR_TRAP(SYS_PMIAR_EL1,          CGT_MDCR_TPM),
> Yup.
> 
>> Similarly corresponding SR_TRAP() needs to be covered for all registers
>> that are now being trapped with FEAT_FGT2.
>>
>> Example code snippet.
>>
>> ........
>> +       SR_TRAP(SYS_SPMEVFILT2R_EL0(8), CGT_MDCR_EnSPM),
>> +       SR_TRAP(SYS_SPMEVFILT2R_EL0(9), CGT_MDCR_EnSPM),
>> +       SR_TRAP(SYS_SPMEVFILT2R_EL0(10),        CGT_MDCR_EnSPM),
>> +       SR_TRAP(SYS_SPMEVFILT2R_EL0(11),        CGT_MDCR_EnSPM),
>> +       SR_TRAP(SYS_SPMEVFILT2R_EL0(12),        CGT_MDCR_EnSPM),
>> +       SR_TRAP(SYS_SPMEVFILT2R_EL0(13),        CGT_MDCR_EnSPM),
>> +       SR_TRAP(SYS_SPMEVFILT2R_EL0(14),        CGT_MDCR_EnSPM),
>> +       SR_TRAP(SYS_SPMEVFILT2R_EL0(15),        CGT_MDCR_EnSPM),
> I think it is a bit more complicated than just that. Again, look at
> the pseudocode:
> 
> elsif PSTATE.EL == EL1 then
>     if HaveEL(EL3) && EL3SDDUndefPriority() && MDCR_EL3.EnPM2 == '0' then
>         UNDEFINED;
>     elsif HaveEL(EL3) && EL3SDDUndefPriority() && SPMACCESSR_EL3<(UInt(SPMSELR_EL0.SYSPMUSEL) * 2) + 1:UInt(SPMSELR_EL0.SYSPMUSEL) * 2> == '00' then
>         UNDEFINED;
>     elsif EL2Enabled() && IsFeatureImplemented(FEAT_FGT2) && ((HaveEL(EL3) && SCR_EL3.FGTEn2 == '0') || HDFGRTR2_EL2.nSPMEVTYPERn_EL0 == '0') then
>         AArch64.SystemAccessTrap(EL2, 0x18);
>     elsif EL2Enabled() && MDCR_EL2.EnSPM == '0' then
>         AArch64.SystemAccessTrap(EL2, 0x18);
>     elsif EL2Enabled() && SPMACCESSR_EL2<(UInt(SPMSELR_EL0.SYSPMUSEL) * 2) + 1:UInt(SPMSELR_EL0.SYSPMUSEL) * 2> == '00' then
>         AArch64.SystemAccessTrap(EL2, 0x18);
>     elsif HaveEL(EL3) && MDCR_EL3.EnPM2 == '0' then
>         if EL3SDDUndef() then
>             UNDEFINED;
>         else
>             AArch64.SystemAccessTrap(EL3, 0x18);
>     elsif HaveEL(EL3) && SPMACCESSR_EL3<(UInt(SPMSELR_EL0.SYSPMUSEL) * 2) + 1:UInt(SPMSELR_EL0.SYSPMUSEL) * 2> == '00' then
>         if EL3SDDUndef() then
>             UNDEFINED;
>         else
>             AArch64.SystemAccessTrap(EL3, 0x18);
>     elsif !IsSPMUCounterImplemented(UInt(SPMSELR_EL0.SYSPMUSEL), (UInt(SPMSELR_EL0.BANK) * 16) + m) then
>         X[t, 64] = Zeros(64);
>     else
>         X[t, 64] = SPMEVFILT2R_EL0[UInt(SPMSELR_EL0.SYSPMUSEL), (UInt(SPMSELR_EL0.BANK) * 16) + m];
> 
> which shows that an SPMEVFILT2Rn_EL0 access from EL1 traps to EL2 if:
> 
> - either HDFGRTR2_EL2.nSPMEVTYPERn_EL0 == '0', (check)
> - or MDCR_EL2.EnSPM == '0', (check)
> - or SPMACCESSR_EL2<(UInt(SPMSELR_EL0.SYSPMUSEL) * 2) + 1:UInt(SPMSELR_EL0.SYSPMUSEL) * 2> == '00'
> 
> and that last condition requires some more handling as you need to
> evaluate both SPMSELR_EL0.SYSPMUSEL and the corresponding field of
> SPMACCESSR_EL2 to make a decision. It's not majorly complicated, but
> it isn't solved by simply setting a static attribute.

So IIUC you are suggesting to handle SYS_SPMEVFILT2R_EL0() registers via
complex condition checks where the CGT_XXX can be directed to a function
callback instead ? For example, something like the following (untested).

--- a/arch/arm64/kvm/emulate-nested.c
+++ b/arch/arm64/kvm/emulate-nested.c
@@ -116,6 +116,7 @@ enum cgt_group_id {
        __COMPLEX_CONDITIONS__,
        CGT_CNTHCTL_EL1PCTEN = __COMPLEX_CONDITIONS__,
        CGT_CNTHCTL_EL1PTEN,
+       CGT_TEST,
 
        CGT_CPTR_TTA,
 
@@ -486,6 +487,23 @@ static enum trap_behaviour check_cptr_tta(struct kvm_vcpu *vcpu)
        return BEHAVE_HANDLE_LOCALLY;
 }
 
+static enum trap_behaviour check_test(struct kvm_vcpu *vcpu)
+{
+       u64 spmaccessr_el2 = __vcpu_sys_reg(vcpu, SPMACCESSR_EL2);
+       u64 spmselr_el2 = __vcpu_sys_reg(vcpu, SPMSELR_EL0);
+       u64 mdcr_el2 = __vcpu_sys_reg(vcpu, MDCR_EL2);
+       int syspmusel, spmaccessr_idx;
+
+       if (!(mdcr_el2 & MDCR_EL2_EnSPM)) {
+               syspmusel = FIELD_GET(SPMSELR_EL0_SYSPMUSEL_MASK, spmselr_el2);
+               spmaccessr_idx = syspmusel * 2;
+
+               if (((spmaccessr_el2 >> spmaccessr_idx) & 0x3) == 0x0)
+                       return BEHAVE_FORWARD_ANY;
+       }
+       return BEHAVE_HANDLE_LOCALLY;
+}
+
 #define CCC(id, fn)                            \
        [id - __COMPLEX_CONDITIONS__] = fn
 
@@ -493,6 +511,7 @@ static const complex_condition_check ccc[] = {
        CCC(CGT_CNTHCTL_EL1PCTEN, check_cnthctl_el1pcten),
        CCC(CGT_CNTHCTL_EL1PTEN, check_cnthctl_el1pten),
        CCC(CGT_CPTR_TTA, check_cptr_tta),
+       CCC(CGT_TEST, check_test),
 };
 
 /*
@@ -1163,7 +1182,7 @@ static const struct encoding_to_trap_config encoding_to_cgt[] __initconst = {
        SR_TRAP(SYS_SPMEVFILTR_EL0(14), CGT_MDCR_EnSPM),
        SR_TRAP(SYS_SPMEVFILTR_EL0(15), CGT_MDCR_EnSPM),
 
-       SR_TRAP(SYS_SPMEVFILT2R_EL0(0), CGT_MDCR_EnSPM),
+       SR_TRAP(SYS_SPMEVFILT2R_EL0(0), CGT_TEST),
        SR_TRAP(SYS_SPMEVFILT2R_EL0(1), CGT_MDCR_EnSPM),
        SR_TRAP(SYS_SPMEVFILT2R_EL0(2), CGT_MDCR_EnSPM),
        SR_TRAP(SYS_SPMEVFILT2R_EL0(3), CGT_MDCR_EnSPM),

