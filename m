Return-Path: <linux-kernel+bounces-377381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7289ABE1F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 07:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB6A01C226D5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 05:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9D51448C1;
	Wed, 23 Oct 2024 05:48:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA70113BAD5
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 05:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729662502; cv=none; b=hAYRfkB8iCY44BI52YiRRfCXm/wuscNKUi9GDWC3RW08Z/FJkedymREsp+xgKFIW6IZwFteL6gX05HWH5MPWpEMuPpcPkm6fOEGAfqe/7FHRa89kHbNxUc/R2XGHNx+Vjg+dBzDh1sHrD/Rtp9w9DuhhXsFyBQamd6I31Xa9Yrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729662502; c=relaxed/simple;
	bh=aaPwevr6v1PfMGjnSoFoEwA1ISOVj24SqNBu8NB2Apc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d3p94/nFENM5TcEypMYx0bGLM0o+lDr6ksrALpN4MFBsWFHmsLA3kvKLMaNEIQp+nIlNjh9s5o+e1+XbB7nestTq7TRRvzRm+tdWjoOn80YVG1U7SA/e5MROWiDkmjVZLguKCJcDzan3ZoUzHEtKv1mQ+lohAXT+dkAHWdnxqw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAED7339;
	Tue, 22 Oct 2024 22:48:47 -0700 (PDT)
Received: from [10.163.41.228] (unknown [10.163.41.228])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42C003F528;
	Tue, 22 Oct 2024 22:48:13 -0700 (PDT)
Message-ID: <2c51de68-fcca-4457-b8e9-b488d8030738@arm.com>
Date: Wed, 23 Oct 2024 11:18:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64/cpufeature: Add field details for
 ID_AA64DFR1_EL1 register
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Brown <broonie@kernel.org>, kvmarm@lists.linux.dev
References: <20241001043602.1116991-1-anshuman.khandual@arm.com>
 <20241001043602.1116991-2-anshuman.khandual@arm.com>
 <ZxfLEqlbGLnK15sf@J2N7QTR9R3>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <ZxfLEqlbGLnK15sf@J2N7QTR9R3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/22/24 21:26, Mark Rutland wrote:
> On Tue, Oct 01, 2024 at 10:06:00AM +0530, Anshuman Khandual wrote:
>> This adds required field details for ID_AA64DFR1_EL1, and also drops dummy
>> ftr_raz[] array which is now redundant. These register fields will be used
>> to enable increased breakpoint and watchpoint registers via FEAT_Debugv8p9
>> later.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> cc: Mark Brown <broonie@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/kernel/cpufeature.c | 21 ++++++++++++++++-----
>>  1 file changed, 16 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index 718728a85430..bd4d85f5dd92 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -530,6 +530,21 @@ static const struct arm64_ftr_bits ftr_id_aa64dfr0[] = {
>>  	ARM64_FTR_END,
>>  };
>>  
>> +static const struct arm64_ftr_bits ftr_id_aa64dfr1[] = {
>> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64DFR1_EL1_ABL_CMPs_SHIFT, 8, 0),
>> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64DFR1_EL1_DPFZS_SHIFT, 4, 0),
>> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR1_EL1_EBEP_SHIFT, 4, 0),
>> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR1_EL1_ITE_SHIFT, 4, 0),
>> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR1_EL1_ABLE_SHIFT, 4, 0),
>> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64DFR1_EL1_PMICNTR_SHIFT, 4, 0),
>> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR1_EL1_SPMU_SHIFT, 4, 0),
>> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64DFR1_EL1_CTX_CMPs_SHIFT, 8, 0),
>> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64DFR1_EL1_WRPs_SHIFT, 8, 0),
>> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64DFR1_EL1_BRPs_SHIFT, 8, 0),
>> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR1_EL1_SYSPMUID_SHIFT, 8, 0),
>> +	ARM64_FTR_END,
>> +};
>> +
> 
> Is there some general principle that has been applied here? e.g. is this
> STRICT unless we know of variation in practice?

Yes, that's correct. STRICT unless there is a known variation in practice.

> 
> e.g. it seems a bit odd that ABLE cannot vary while the number of
> breakpoints can...
But all these (ABL_CMPs, CTX_CMPs, WRPs, BRPs) are marked as FTR_NONSTRICT.
Would not that allow ABL_CMPs to vary as well ?

Although the existing break-point numbers are currently marked FTR_STRICT,
should they be changed first ?

static const struct arm64_ftr_bits ftr_id_aa64dfr0[] = {
	...................
	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_EL1_CTX_CMPs_SHIFT, 4, 0),
        ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_EL1_WRPs_SHIFT, 4, 0),
        ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_EL1_BRPs_SHIFT, 4, 0),
	...................
}

> 
> I suspect we will see systems with mismatched EBEP too, but maybe I'm
> wrong.

Should that be marked FTR_NONSTRICT as well ? But is there a definite way
to confirm if systems could/might come up with such variations in features
between different cpus ?

> 
> Mark.
> 
>>  static const struct arm64_ftr_bits ftr_mvfr0[] = {
>>  	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, MVFR0_EL1_FPRound_SHIFT, 4, 0),
>>  	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, MVFR0_EL1_FPShVec_SHIFT, 4, 0),
>> @@ -708,10 +723,6 @@ static const struct arm64_ftr_bits ftr_single32[] = {
>>  	ARM64_FTR_END,
>>  };
>>  
>> -static const struct arm64_ftr_bits ftr_raz[] = {
>> -	ARM64_FTR_END,
>> -};
>> -
>>  #define __ARM64_FTR_REG_OVERRIDE(id_str, id, table, ovr) {	\
>>  		.sys_id = id,					\
>>  		.reg = 	&(struct arm64_ftr_reg){		\
>> @@ -784,7 +795,7 @@ static const struct __ftr_reg_entry {
>>  
>>  	/* Op1 = 0, CRn = 0, CRm = 5 */
>>  	ARM64_FTR_REG(SYS_ID_AA64DFR0_EL1, ftr_id_aa64dfr0),
>> -	ARM64_FTR_REG(SYS_ID_AA64DFR1_EL1, ftr_raz),
>> +	ARM64_FTR_REG(SYS_ID_AA64DFR1_EL1, ftr_id_aa64dfr1),
>>  
>>  	/* Op1 = 0, CRn = 0, CRm = 6 */
>>  	ARM64_FTR_REG(SYS_ID_AA64ISAR0_EL1, ftr_id_aa64isar0),
>> -- 
>> 2.25.1
>>

