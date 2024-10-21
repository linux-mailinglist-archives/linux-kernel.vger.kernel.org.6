Return-Path: <linux-kernel+bounces-373613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6956D9A5965
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 06:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9792A1C20EF6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 04:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C111946CA;
	Mon, 21 Oct 2024 04:01:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5972BB15
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 04:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729483310; cv=none; b=HCGi0mmC+8MWmVgg4UvmN+zXiwh9yVNNZEPyKYDAS/5j2t5Zse2vTWkA/Eg3AT48mFhio1TGGQZ9jR1SKzizdrJOURDicmejVlQD55WjtQhJAAsCXxRTTIZ/hwq8Qfx5UJ9nzv1qOcHG6GU+8UWsj25FMhs//zAOdI2fwj6453Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729483310; c=relaxed/simple;
	bh=Ts2Vy9YEIjysg0wB78lMVASaMah/0dG6SjxF6FWO1zQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rfOVDFQ/qQVqTnt1r9dob9LlqvFXVcKVX6+oapgl0P2LgPl8iLNM7wspmfIMc8Kf18FsShc9pxlFYTCwN2Z0iZBOZhTa63JLo3yH5n1tZ0NSWTBRHjVjk3SbAuNw7/xrUtaP1m2Vcf1ChRFauUH7Grm1exDhJSnSZamqejFB3Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3853DA7;
	Sun, 20 Oct 2024 21:02:17 -0700 (PDT)
Received: from [10.162.16.109] (a077893.blr.arm.com [10.162.16.109])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 798753F73B;
	Sun, 20 Oct 2024 21:01:45 -0700 (PDT)
Message-ID: <8c14a3ca-2986-484f-9bc1-c2cf4aa08211@arm.com>
Date: Mon, 21 Oct 2024 09:31:42 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 47/47] KVM: arm64: nv: Add trap forwarding for FEAT_FGT2
 described registers
To: Oliver Upton <oliver.upton@linux.dev>
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, maz@kernel.org,
 James Morse <james.morse@arm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>
References: <20241001024356.1096072-1-anshuman.khandual@arm.com>
 <20241001024356.1096072-48-anshuman.khandual@arm.com>
 <ZvwLRWOKpggCvmH4@linux.dev> <cae8c6ca-d999-4b93-a82d-7a1f9924fcee@arm.com>
 <Zv92nsoLxbfI45Ji@linux.dev>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Zv92nsoLxbfI45Ji@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/4/24 10:31, Oliver Upton wrote:
> On Thu, Oct 03, 2024 at 09:46:08AM +0530, Anshuman Khandual wrote:
>>> I have a patch in the nested PMU series that uses a single complex trap
>>> ID to evaluate HPMN, and derives the index from ESR_EL2. I think it
>>> could also be extended to the PMEVCNTSVR<n> range as well.
>>
>> Just for reference - the mentioned complex trap ID function from the
>> given link below.
>>
>> static enum trap_behaviour check_mdcr_hpmn(struct kvm_vcpu *vcpu)
>> {
>> 	u32 sysreg = esr_sys64_to_sysreg(kvm_vcpu_get_esr(vcpu));
>> 	u64 mask = kvm_pmu_accessible_counter_mask(vcpu);
>> 	unsigned int idx;
>>
>>
>> 	switch (sysreg) {
>> 	case SYS_PMEVTYPERn_EL0(0) ... SYS_PMEVTYPERn_EL0(30):
>> 	case SYS_PMEVCNTRn_EL0(0) ... SYS_PMEVCNTRn_EL0(30):
>>
>> ---------------------------------------------------------------------
>> Just add the new system register range here ?
>>
>> +	case SYS_PMEVCNTSVR_EL1(0)... SYS_PMEVCNTSVR_EL1(31):
>> ---------------------------------------------------------------------
>>
>> 		idx = (sys_reg_CRm(sysreg) & 0x3) << 3 | sys_reg_Op2(sysreg);
>> 		break;
> 
> Yes, so long as the layout of encodings matches the established pattern
> for value / type registers (I haven't checked this).
> 
>>>
>>> Also, keep in mind that the HPMN trap is annoying since it affects Host
>>> EL0 in addition to 'guest' ELs.
>>
>> Does this require any more special handling other than the above complex trap
>> ID function ?
> 
> There's another patch in that series I linked that allows EL2 traps to
> describe behavior that takes effect in host EL0.
> 
> So I don't believe there's anything in particular related to HPMN that
> you need to evaluate. I wanted to mention it because some of the PMU
> related traps besides HPMN take effect in Host EL0, so do keep it in
> mind.
> 
> With that said, I haven't seen an FGT yet that applies to Host EL0.
> 

Hello Oliver,

Should I rebase this series on the latest series you have posted earlier this
month [1] ? Also wondering if you had a chance to look into other KVM patches
here ? Please do let me know if they too need any modification.

  KVM: arm64: nv: Add FEAT_FGT2 registers access from virtual EL2
  KVM: arm64: nv: Add FEAT_FGT2 registers based FGU handling
  KVM: arm64: nv: Add trap forwarding for FEAT_FGT2 described registers

[1] https://lore.kernel.org/kvmarm/20241007174559.1830205-1-oliver.upton@linux.dev/

- Anshuman

