Return-Path: <linux-kernel+bounces-399906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D319C0620
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC1E31C21410
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A04E20EA5E;
	Thu,  7 Nov 2024 12:47:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988CA18FDAF
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 12:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730983656; cv=none; b=QsXsYkHDYykCjxylwwwLZOAnK3JXIUBvyJg7xd1oZ6LQj/h8LECcn6mA9fRrS9GNKSk7ibFtJgyDHdQZ6kbPjhrZ8Sl+3qs0FTfMyL4j+kM4fZdyHCBD/8PzwK73xrlr+oGLLGIqR+ZtWBwkqtKVntJGpVQYf3hspwIHeLgRmQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730983656; c=relaxed/simple;
	bh=rQdQRA/g77S2HyInO0KkEdG9Sbr1BAYbr8BqqRiyjIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mNXTIU2wyj4pLUQdKJCaTupGQIRhvtH9RV80dDIonDwxm5FxaQWlPFqgGAtDMiXBgnjFdS1HmIe7phUtxUJJorZs9cVdb4hGdr0F4aZHNG5RIHhQ4MPXdTKRl7R42TPazmQOhf9LCewOzHNqvZ/IYlGF6TSZvJ37EDQpeChJSAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FA7F497;
	Thu,  7 Nov 2024 04:48:02 -0800 (PST)
Received: from [10.57.89.216] (unknown [10.57.89.216])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03C113F66E;
	Thu,  7 Nov 2024 04:47:29 -0800 (PST)
Message-ID: <537c1a6a-6379-4c0e-9a6d-0ceaf2c43633@arm.com>
Date: Thu, 7 Nov 2024 12:47:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 00/57] Boot-time page size selection for arm64
Content-Language: en-GB
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, David Hildenbrand <david@redhat.com>,
 Greg Marsden <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <ZyPxhF34JjT3Ky9K@arm.com> <083d9e98-b6b8-4702-a700-24aea95cef9e@arm.com>
 <Zyy0DpOIu63isKZR@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <Zyy0DpOIu63isKZR@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/11/2024 12:35, Catalin Marinas wrote:
> On Wed, Nov 06, 2024 at 11:37:58AM +0000, Ryan Roberts wrote:
>> On 31/10/2024 21:07, Catalin Marinas wrote:
>>> So, first of all, I'd like to understand the overall maintainability
>>> impact better. I assume you tested mostly defconfig. If you run an
>>> allmodconfig build with make -k, how many build failures do you get with
>>> this patchset? Similarly for some distro configs.
>>
>> I've roughly done:
>>
>>     make alldefconfig &&
>>         ./scripts/config --enable CONFIG_ARM64_BOOT_TIME_PAGE_SIZE &&
>> 	make -s -j`nproc` -k &> allmodconfig.log
> 
> Is it alldefconfig or allmodconfig? The former has a lot less symbols
> enabled than even defconfig (fairly close to allnoconfig actually):

Eek, that was a typo when I wrote the email... I built allmodconfig - the big one.

> 
> $ make defconfig
> $ grep -v "^#\|^$" .config | wc -l
> 4449
> 
> $ make alldefconfig
> $ grep -v "^#\|^$" .config | wc -l
> 713
> 
> $ make allmodconfig
> $ grep -v "^#\|^$" .config | wc -l
> 14401
> 
>> In the end, I decided to go for r'(\S+\.[ch]):.*(error|note):', which is any
>> files described as having an error or being the callsite of the thing with the
>> error. I think this is likely most accurate from eyeballing the log:
> 
> I think that's good enough to give us a rough idea.
> 
>> |            |     C&H files | percentage of |
>> | directory  |      w/ error | all C&H files |
>> |------------|---------------|---------------|
>> | arch/arm64 |             7 |          1.3% |
>> | drivers    |           127 |          0.4% |
>> | fs         |            25 |          1.1% |
>> | include    |            27 |          0.4% |
>> | init       |             1 |          8.3% |
>> | kernel     |             7 |          1.3% |
>> | lib        |             1 |          0.2% |
>> | mm         |             6 |          3.2% |
>> | net        |             7 |          0.4% |
>> | security   |             2 |          0.8% |
>> | sound      |            21 |          0.8% |
>> |------------|---------------|---------------|
>> | TOTAL      |           231 |          0.4% |
>> |------------|---------------|---------------|
> 
> This doesn't look that bad _if_ you actually built most modules. But if
> it was alldefconfig, you likely missed the majority of modules.

I definitely built allmodconfig, so I guess "this doesn't look bad" :)

> 
>>> Do we have any better way to detect this other than actual compilation
>>> on arm64? Can we hack something around COMPILE_TEST like redefine
>>> PAGE_SIZE (for modules only) to a variable so that we have a better
>>> chance of detecting build failures when modules are only tested on other
>>> architectures?
>>
>> I can certainly look into this. But if the concern is that drivers are not being
>> compiled against arm64, what is the likelyhood of them being compiled against
>> COMPILE_TEST?
> 
> Hopefully some CIs out there catching them. Well, if we are to fix them
> anyway, we might as well eventually force a non-const PAGE_SIZE
> generically even if it returns a constant.
> 
> I'm building allmod now with something like below (and some hacks in
> arch and core code to use STATIC_PAGE_* as I did not apply your
> patches). alldefconfig passes with my hacks but, as you can see, the
> non-const PAGE_SIZE kicks in only if MODULE is defined. So, not an
> accurate test, just to get a feel of the modules problem.

Nice. I guess that's pretty much the change we would add for x86 with COMPILE_TEST.

> 
> ----------8<---------------------------
> diff --git a/arch/arm64/include/asm/page-def.h b/arch/arm64/include/asm/page-def.h
> index 792e9fe881dc..71a761f86b15 100644
> --- a/arch/arm64/include/asm/page-def.h
> +++ b/arch/arm64/include/asm/page-def.h
> @@ -12,7 +12,19 @@
>  
>  /* PAGE_SHIFT determines the page size */
>  #define PAGE_SHIFT		CONFIG_PAGE_SHIFT
> -#define PAGE_SIZE		(_AC(1, UL) << PAGE_SHIFT)
> +#define STATIC_PAGE_SIZE	(_AC(1, UL) << PAGE_SHIFT)
> +#define STATIC_PAGE_MASK	(~(STATIC_PAGE_SIZE-1))
> +
> +#if !defined(MODULE) || defined(__ASSEMBLY__)
> +#define PAGE_SIZE		STATIC_PAGE_SIZE
> +#else
> +static inline unsigned long __runtime_page_size(void)
> +{
> +	return 1UL << PAGE_SHIFT;
> +}
> +#define PAGE_SIZE		(__runtime_page_size())
> +#endif
> +
>  #define PAGE_MASK		(~(PAGE_SIZE-1))
>  
>  #endif /* __ASM_PAGE_DEF_H */
> ----------8<---------------------------
> 


