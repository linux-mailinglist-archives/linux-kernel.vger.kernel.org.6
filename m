Return-Path: <linux-kernel+bounces-275769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFAA948997
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AB0C2857DD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 06:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1141BC9F7;
	Tue,  6 Aug 2024 06:48:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8FDA94A
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 06:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722926925; cv=none; b=ePdmsVrLS6WZvhbMGXM+4FcEEcu2QecrSC9hZhL1RLQ+87E92SfGdna1mAWH+hWiWO9Odd8rurLTe30RN61fEBXy4gupf46kQ57oM4iylHG9Br39Oxy8GrGpLzS/j/g8djFiLeOBB24rps/RiIDUPKqc2wxtex1FErnby44kPgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722926925; c=relaxed/simple;
	bh=Kp+3aTqHgi2cdzPeP+SQuB2/2T0z2os/GtAW4E56NyY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=r8le7IZiFIQWNeYfI3tjJ8bjCZkGTgr3BAp3VkxcsU2Hys793SQBvxvCSwf/hrDrhLka9iZru04cM+fGaYp8X7zKHrRfScCYOjLINvD3Z+L7Mq1McxJ+/QbsZNdUMXrp8hKaDyJYC6WmV4ahb8TZINLpYcGNglP1aeGKHN/X00U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B1E7106F;
	Mon,  5 Aug 2024 23:49:07 -0700 (PDT)
Received: from [10.163.54.208] (unknown [10.163.54.208])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B4693F5A1;
	Mon,  5 Aug 2024 23:48:36 -0700 (PDT)
Message-ID: <bd94503e-9644-4d6e-8835-2a6b523942de@arm.com>
Date: Tue, 6 Aug 2024 12:18:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [RFC V2 1/3] arm64/cpufeature: Add field details for
 ID_AA64DFR1_EL1 register
To: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 James Morse <james.morse@arm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240620092607.267132-1-anshuman.khandual@arm.com>
 <20240620092607.267132-2-anshuman.khandual@arm.com>
 <20240805135942.GA9866@willie-the-truck>
Content-Language: en-US
In-Reply-To: <20240805135942.GA9866@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/5/24 19:29, Will Deacon wrote:
> On Thu, Jun 20, 2024 at 02:56:05PM +0530, Anshuman Khandual wrote:
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
>> index 48e7029f1054..12f0a5181bf2 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -527,6 +527,21 @@ static const struct arm64_ftr_bits ftr_id_aa64dfr0[] = {
>>  	ARM64_FTR_END,
>>  };
>>  
>> +static const struct arm64_ftr_bits ftr_id_aa64dfr1[] = {
>> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR1_EL1_ABL_CMPs_SHIFT, 8, 0),
>> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR1_EL1_DPFZS_SHIFT, 4, 0),
> 
> I only got this far in the patch, but why is this FTR_STRICT +
> FTR_LOWER_SAFE? The behaviour of the cycle counter on an SPE management
> event sounds like it would be fine to differ between cores, no?

You are right I guess, will this change as FTR_NONSTRICT instead.

> 
> Please go through all the new fields, bearing in mind that most of the
> PMU stuff is per-CPU type rather than global.
Looking at all the register fields in ID_AA64DFR1_EL1 as in the latest
ARM ARM DDI 0487K.a.

Overall there are two different register field categories, the first is
whether an arch feature is enabled or not. This should be all the same
across different cpus on the system, hence FTR_STRICT + FTR_LOWER_SAFE
probably makes sense. The second type is number of HW counter or element
entries per CPU/PMU which can be different across cpus, hence
FTR_NONSTRICT + FTR_LOWER_SAFE might be applicable in such cases.

1. ABL_CMPs
	- Number of breakpoints that support address linking, minus 1

	[FTR_NONSTRICT + FTR_LOWER_SAFE]

2. DPFZS
	- Behavior of the cycle counter when event counting is frozen
	  by a Statistical Profiling management event

	[FTR_NONSTRICT + FTR_LOWER_SAFE]

3. EBEP
	- Exception-based event profiling

	[FTR_STRICT + FTR_LOWER_SAFE]

4. ITE
	- Instrumentation Trace Extension

	[FTR_STRICT + FTR_LOWER_SAFE]

5. ABLE
	- Address Breakpoint Linking Extension

	[FTR_STRICT + FTR_LOWER_SAFE]

6. PMICNTR
	- PMU fixed-function instruction counter
	- Could this vary between cpus ?

	[FTR_NONSTRICT + FTR_LOWER_SAFE]

7. SPMU
	- System PMU extension

	[FTR_STRICT + FTR_LOWER_SAFE]

8. CTX_CMPs
	- Context-aware breakpoints

	[FTR_NONSTRICT + FTR_LOWER_SAFE]

9. WRPs
	- Watchpoints

	[FTR_NONSTRICT + FTR_LOWER_SAFE]

10. BRPs
	- Breakpoints

	[FTR_NONSTRICT + FTR_LOWER_SAFE]

11. SYSPMUID
	- System PMU ID

	[FTR_STRICT + FTR_LOWER_SAFE]

Although please note that existing breakpoint/watchpoint numbers are represented
as FTR_STRICT + FTR_LOWER_SAFE. Hence just wondering if these extended watchpoint
or breakpoint numbers should represented any different.

static const struct arm64_ftr_bits ftr_id_aa64dfr0[] = {
..............
ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_EL1_CTX_CMPs_SHIFT, 4, 0),
ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_EL1_WRPs_SHIFT, 4, 0),
ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_EL1_BRPs_SHIFT, 4, 0),
..............
};

Please suggest if any of the above needs change. Thank you.

- Anshuman

