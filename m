Return-Path: <linux-kernel+bounces-532033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1121CA447C6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 981E9188B9ED
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DD5198831;
	Tue, 25 Feb 2025 17:13:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D414C21ABC6
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503628; cv=none; b=CQN+pKI1qa6E9y3nA8GzyugErEdxYERS6xUXC/vcFD86RNPppoNXwNGevJEFurq8lsQHZXZYThdJ0qB9Iqj87GUxkAlS2c9koRD93KuZh5H5YApbY91M4fS5DnADlNZuC+rlMLy2pqGyljqOzZU4F7Qi+OZqTobivYXIug88W24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503628; c=relaxed/simple;
	bh=A67OgOjUw1iCAHEONgsT/PsGYj7lxY22hjgvApCbFq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dlzqjSJHwDuja6ogfVPsq59Keqw1TYs6+nkV5VBC5UCtl0wNfPcN+sQif1QNYPfKWV6wXIVWnzVfhSFh3Jl3dOS1c1eh/sX90st9Urjy0j4Vjtso72R66QF9+Iy16FxsB9+sfffBIptU/WNbujmnyJz/PTK8NKDTxp9W8cvbN7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F09B1BCB;
	Tue, 25 Feb 2025 09:14:02 -0800 (PST)
Received: from [10.1.27.154] (XHFQ2J9959.cambridge.arm.com [10.1.27.154])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BC123F5A1;
	Tue, 25 Feb 2025 09:13:44 -0800 (PST)
Message-ID: <1847fc09-a394-40ad-b66f-1afe1964a061@arm.com>
Date: Tue, 25 Feb 2025 17:13:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64/mm: Fix Boot panic on Ampere Altra
Content-Language: en-GB
To: Luiz Capitulino <luizcap@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250225114638.2038006-1-ryan.roberts@arm.com>
 <f53be9d0-524e-4bae-8994-aa2baa1b36d3@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <f53be9d0-524e-4bae-8994-aa2baa1b36d3@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/02/2025 16:57, Luiz Capitulino wrote:
> On 2025-02-25 06:46, Ryan Roberts wrote:
>> When the range of present physical memory is sufficiently small enough
>> and the reserved address space for the linear map is sufficiently large
>> enough, The linear map base address is randomized in
>> arm64_memblock_init().
>>
>> Prior to commit 62cffa496aac ("arm64/mm: Override PARange for !LPA2 and
>> use it consistently"), we decided if the sizes were suitable with the
>> help of the raw mmfr0.parange. But the commit changed this to use the
>> sanitized version instead. But the function runs before the register has
>> been sanitized so this returns 0, interpreted as a parange of 32 bits.
>> Some fun wrapping occurs and the logic concludes that there is enough
>> room to randomize the linear map base address, when really there isn't.
>> So the top of the linear map ends up outside the reserved address space.
>>
>> Fix this by intoducing a helper, cpu_get_parange() which reads the raw
>> parange value and overrides it with any early override (e.g. due to
>> arm64.nolva).
>>
>> Reported-by: Luiz Capitulino <luizcap@redhat.com>
>> Closes: https://lore.kernel.org/all/a3d9acbe-07c2-43b6-9ba9-
>> a7585f770e83@redhat.com/
>> Fixes: 62cffa496aac ("arm64/mm: Override PARange for !LPA2 and use it
>> consistently")
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>
>> This applies on top of v6.14-rc4. I'm hoping this can be merged for v6.14 since
>> it's fixing a regression introduced in v6.14-rc1.
>>
>> Luiz, are you able to test this to make sure it's definitely fixing your
>> original issue. The symptom I was seeing was slightly different.
> 
> Yes, this fixes it for me!

Great!
> 
> I was able to boot v6.14-rc4 one time without your patch, this is probably
> what messed up my bisection. 

Yes the operation is also dependent on the value of the kaslr seed (which is why
you don't see the issue when kaslr is disabled). So sometimes a random kaslr
seed will be the right value to mask the issue. Another benefit of running this
in kvmtool is that I could pass the same seed in every time.

> But I booted v6.14-rc4 with this patch
> multiple times without an issue. I agree this needs to be in for
> v6.14 and huge thanks for jumping in and getting this fixed.

No worries!

> 
> Tested-by: Luiz Capitulino <luizcap@redhat.com>

Thanks!

> 
>>
>> I'm going to see if it's possible for read_sanitised_ftr_reg() to warn about use
>> before initialization. I'll send a follow up patch for that.
>>
>> Thanks,
>> Ryan
>>
>>
>>   arch/arm64/include/asm/cpufeature.h | 9 +++++++++
>>   arch/arm64/mm/init.c                | 8 +-------
>>   2 files changed, 10 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/
>> cpufeature.h
>> index e0e4478f5fb5..2335f44b9a4d 100644
>> --- a/arch/arm64/include/asm/cpufeature.h
>> +++ b/arch/arm64/include/asm/cpufeature.h
>> @@ -1066,6 +1066,15 @@ static inline bool cpu_has_lpa2(void)
>>   #endif
>>   }
>>
>> +static inline u64 cpu_get_parange(void)
>> +{
>> +    u64 mmfr0 = read_cpuid(ID_AA64MMFR0_EL1);
>> +
>> +    return arm64_apply_feature_override(mmfr0,
>> +                        ID_AA64MMFR0_EL1_PARANGE_SHIFT, 4,
>> +                        &id_aa64mmfr0_override);
>> +}
>> +
>>   #endif /* __ASSEMBLY__ */
>>
>>   #endif
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index 9c0b8d9558fc..1b1a61191b9f 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -280,13 +280,7 @@ void __init arm64_memblock_init(void)
>>       if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
>>           extern u16 memstart_offset_seed;
>>
>> -        /*
>> -         * Use the sanitised version of id_aa64mmfr0_el1 so that linear
>> -         * map randomization can be enabled by shrinking the IPA space.
>> -         */
>> -        u64 mmfr0 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
>> -        int parange = cpuid_feature_extract_unsigned_field(
>> -                    mmfr0, ID_AA64MMFR0_EL1_PARANGE_SHIFT);
>> +        int parange = cpu_get_parange();
>>           s64 range = linear_region_size -
>>                   BIT(id_aa64mmfr0_parange_to_phys_shift(parange));
>>
>> -- 
>> 2.43.0
>>
> 


