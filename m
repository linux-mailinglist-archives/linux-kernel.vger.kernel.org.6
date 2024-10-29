Return-Path: <linux-kernel+bounces-386619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F639B45EB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C08122844DE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88F71E1C36;
	Tue, 29 Oct 2024 09:46:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FB32AE8B
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 09:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730195167; cv=none; b=ss3LpIjXvtsFtWtKeeqeBIi3PCIncHH6IPaXOpwoIY0aAvIPA0VNBWOGe7PNKtAx8QV8+BkYttfvjnvPCyiH+REPyL8YfksjkjFOOE8mNCKSR7I1qWxipJtENuvp1CHsxO+ZUky2/HAXNpGt/0rCEDXJtMG9wPh1UnWnIlZoB/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730195167; c=relaxed/simple;
	bh=64DtA/PM7AjSGzw76mVUmancwaHgbtYsUk2YRwkbQIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Im0zueaS/j+96YtO1kO63DCIx92JCSg/yVLLK02K22PZOQTWGPWlw42dPaT9MBjbM93/2ERHW9ma2TJbdV6Pjt04cdrSmJ4rcGHA5PMV9pANV+tcUtt9ySsi2opg6Ed/Vijl7MZJ2O1Z3axBFBMYmnL8lVkN+dRgBcONEd/x5IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1422497;
	Tue, 29 Oct 2024 02:46:33 -0700 (PDT)
Received: from [10.163.43.192] (unknown [10.163.43.192])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F8283F528;
	Tue, 29 Oct 2024 02:46:00 -0700 (PDT)
Message-ID: <b85dcdc2-d56d-4bf7-9fa9-222a6f057674@arm.com>
Date: Tue, 29 Oct 2024 15:15:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/18] KVM: arm64: nv: Reinject traps that take effect
 in Host EL0
To: Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, Joey Gouly <joey.gouly@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241025182354.3364124-1-oliver.upton@linux.dev>
 <20241025182354.3364124-9-oliver.upton@linux.dev>
 <87r083th7m.wl-maz@kernel.org> <Zxz-LocgUKuzE3t0@linux.dev>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Zxz-LocgUKuzE3t0@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/26/24 20:05, Oliver Upton wrote:
> Hey,
> 
> On Sat, Oct 26, 2024 at 09:13:17AM +0100, Marc Zyngier wrote:
>> On Fri, 25 Oct 2024 19:23:43 +0100,
>> Oliver Upton <oliver.upton@linux.dev> wrote:
>>>
>>> Wire up the other end of traps that affect host EL0 by actually
>>> injecting them into the guest hypervisor. Skip over FGT entirely, as a
>>> cursory glance suggests no FGT is effective in host EL0.
>>
>> Yes, and this (thankfully) is by design! :-)
>>
>>>
>>> Note that kvm_inject_nested() is already equipped for handling
>>> exceptions while the VM is already in a host context.
>>>
>>> Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
>>> ---
>>>  arch/arm64/include/asm/kvm_emulate.h |  5 +++++
>>>  arch/arm64/kvm/emulate-nested.c      | 29 ++++++++++++++++++++++++----
>>>  2 files changed, 30 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
>>> index a601a9305b10..bf0c48403f59 100644
>>> --- a/arch/arm64/include/asm/kvm_emulate.h
>>> +++ b/arch/arm64/include/asm/kvm_emulate.h
>>> @@ -225,6 +225,11 @@ static inline bool is_hyp_ctxt(const struct kvm_vcpu *vcpu)
>>>  	return vcpu_has_nv(vcpu) && __is_hyp_ctxt(&vcpu->arch.ctxt);
>>>  }
>>>  
>>> +static inline bool vcpu_is_host_el0(const struct kvm_vcpu *vcpu)
>>> +{
>>> +	return is_hyp_ctxt(vcpu) && !vcpu_is_el2(vcpu);
>>> +}
>>> +
>>>  /*
>>>   * The layout of SPSR for an AArch32 state is different when observed from an
>>>   * AArch64 SPSR_ELx or an AArch32 SPSR_*. This function generates the AArch32
>>> diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-nested.c
>>> index e1a30d1bcd06..db3149379a4d 100644
>>> --- a/arch/arm64/kvm/emulate-nested.c
>>> +++ b/arch/arm64/kvm/emulate-nested.c
>>> @@ -20,6 +20,9 @@ enum trap_behaviour {
>>>  	BEHAVE_FORWARD_READ	= BIT(0),
>>>  	BEHAVE_FORWARD_WRITE	= BIT(1),
>>>  	BEHAVE_FORWARD_RW	= BEHAVE_FORWARD_READ | BEHAVE_FORWARD_WRITE,
>>> +
>>> +	/* Traps that take effect in Host EL0, this is rare! */
>>> +	BEHAVE_IN_HOST_EL0	= BIT(2),
>>
>> nit: BEHAVE_IN_HOST_EL0 lacks an action verb (forward?).
> 
> Thinking I'll squash this in (plus renaming in later patches):

Right, the following additional replacements are required for build.


@@ -307,14 +307,14 @@ static const struct trap_bits coarse_trap_bits[] = {
                .value          = MDCR_EL2_TPMCR,
                .mask           = MDCR_EL2_TPMCR,
                .behaviour      = BEHAVE_FORWARD_RW |
-                                 BEHAVE_IN_HOST_EL0,
+                                 BEHAVE_FORWARD_IN_HOST_EL0,
        },
        [CGT_MDCR_TPM] = {
                .index          = MDCR_EL2,
                .value          = MDCR_EL2_TPM,
                .mask           = MDCR_EL2_TPM,
                .behaviour      = BEHAVE_FORWARD_RW |
-                                 BEHAVE_IN_HOST_EL0,
+                                 BEHAVE_FORWARD_IN_HOST_EL0,
        },
        [CGT_MDCR_TDE] = {
                .index          = MDCR_EL2,
@@ -530,7 +530,7 @@ static enum trap_behaviour check_mdcr_hpmn(struct kvm_vcpu *vcpu)
        }
 
        if (kvm_pmu_counter_is_hyp(vcpu, idx))
-               return BEHAVE_FORWARD_RW | BEHAVE_IN_HOST_EL0;
+               return BEHAVE_FORWARD_RW | BEHAVE_FORWARD_IN_HOST_EL0;
 
        return BEHAVE_HANDLE_LOCALLY;
 }

> 
> diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-nested.c
> index db3149379a4d..b072098ee44e 100644
> --- a/arch/arm64/kvm/emulate-nested.c
> +++ b/arch/arm64/kvm/emulate-nested.c
> @@ -22,7 +22,7 @@ enum trap_behaviour {
>  	BEHAVE_FORWARD_RW	= BEHAVE_FORWARD_READ | BEHAVE_FORWARD_WRITE,
>  
>  	/* Traps that take effect in Host EL0, this is rare! */
> -	BEHAVE_IN_HOST_EL0	= BIT(2),
> +	BEHAVE_FORWARD_IN_HOST_EL0	= BIT(2),
>  };
>  
>  struct trap_bits {
> @@ -2279,7 +2279,7 @@ bool triage_sysreg_trap(struct kvm_vcpu *vcpu, int *sr_index)
>  
>  	b = compute_trap_behaviour(vcpu, tc);
>  
> -	if (!(b & BEHAVE_IN_HOST_EL0) && vcpu_is_host_el0(vcpu))
> +	if (!(b & BEHAVE_FORWARD_IN_HOST_EL0) && vcpu_is_host_el0(vcpu))
>  		goto local;
>  
>  	if (((b & BEHAVE_FORWARD_READ) && is_read) ||
> 

