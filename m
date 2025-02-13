Return-Path: <linux-kernel+bounces-512579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBB9A33B03
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA46F1676B0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254C21E376E;
	Thu, 13 Feb 2025 09:17:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1471220DD52
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 09:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739438248; cv=none; b=kPR7JxL6oxX3LljBea+DxL435u3rja6WH8xH9vqgY4fzWu+2xXbGEfs5qplZ/2ikoK1cmv7fz5FrIMj7eCnhrTUcW4/hVrxDcKBzYesUzIRdE9Lh6jp8GGciOjYrNPNKSFa6NIQzpYB/EEp+BwHqjlR+6UEoVV6QHZnkNZ9UULw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739438248; c=relaxed/simple;
	bh=DdugeuxOqHQNZlTbLN5Jexh2Jny3Fy3oSSJCljQIeA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hjg/87LinjjVb6jPwbk57FbJKB1yvBqu5BHYdGLNb7EirFGzd4Akaxclo9BRg40QFb1w23RZdHklok3k8a5AGFcfdnbKy0O3e60oG0BWkzQ3x49BHuy6NuMiZcDAskMRp35/Z9gTjy/8sx4e5nkc7KVceQtC95SMQ4H7/Kg0kEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1F4C16F3;
	Thu, 13 Feb 2025 01:17:46 -0800 (PST)
Received: from [10.57.81.93] (unknown [10.57.81.93])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C1C53F58B;
	Thu, 13 Feb 2025 01:17:23 -0800 (PST)
Message-ID: <67bcb2f2-8cc1-43e3-b5cc-6c8ef5da8a95@arm.com>
Date: Thu, 13 Feb 2025 09:17:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 15/16] mm: Generalize arch_sync_kernel_mappings()
Content-Language: en-GB
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Muchun Song <muchun.song@linux.dev>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Dev Jain <dev.jain@arm.com>, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Steve Capper <steve.capper@linaro.org>, Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250205151003.88959-1-ryan.roberts@arm.com>
 <20250205151003.88959-16-ryan.roberts@arm.com>
 <43c256b6-7e44-41bb-b0c5-866fd4faab5c@arm.com>
 <ff93eb30-ddb6-476b-a209-3329d6e3b06f@arm.com>
 <d7c6edbc-957b-475b-b87c-db246ec1413f@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <d7c6edbc-957b-475b-b87c-db246ec1413f@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

>>>> +/**
>>>> + * arch_update_kernel_mappings_end - A batch of kernel pgtable mappings have
>>>> + * been updated.
>>>> + * @start: Virtual address of start of range that was updated.
>>>> + * @end: Virtual address of end of range that was updated.
>>>> + *
>>>> + * An optional hook to inform architecture code that a batch update is complete.
>>>> + * This balances a previous call to arch_update_kernel_mappings_begin().
>>>> + *
>>>> + * An architecture may override this for any purpose, such as exiting a lazy
>>>> + * mode previously entered with arch_update_kernel_mappings_begin() or syncing
>>>> + * kernel mappings to a secondary pgtable. The default implementation calls an
>>>> + * arch-provided arch_sync_kernel_mappings() if any arch-defined pgtable level
>>>> + * was updated.
>>>> + *
>>>> + * Context: Called in task context and may be preemptible.
>>>> + */
>>>> +static inline void arch_update_kernel_mappings_end(unsigned long start,
>>>> +						   unsigned long end,
>>>> +						   pgtbl_mod_mask mask)
>>>> +{
>>>> +	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
>>>> +		arch_sync_kernel_mappings(start, end);
>>>> +}
>>>
>>> One arch call back calling yet another arch call back sounds bit odd. 
>>
>> It's no different from the default implementation of arch_make_huge_pte()
>> calling pte_mkhuge() is it?
> 
> Agreed. arch_make_huge_pte() ---> pte_mkhuge() where either helpers can be
> customized in the platform is another such example but unless necessary we
> should probably avoid following that. Anyways it's not a big deal I guess.
> 
>>
>>> Also
>>> should not ARCH_PAGE_TABLE_SYNC_MASK be checked both for __begin and __end
>>> callbacks in case a platform subscribes into this framework. 
>>
>> I'm not sure how that would work? The mask is accumulated during the pgtable
>> walk. So we don't have a mask until we get to the end.
> 
> A non-zero ARCH_PAGE_TABLE_SYNC_MASK indicates that a platform is subscribing
> to this mechanism. So could ARCH_PAGE_TABLE_SYNC_MASK != 0 be used instead ?

There are now 2 levels of mechanism:

Either: arch defines ARCH_PAGE_TABLE_SYNC_MASK to be non-zero and provides
arch_sync_kernel_mappings(). This is unchanged from how it was before.

Or: arch defines it's own version of one or both of
arch_update_kernel_mappings_begin() and arch_update_kernel_mappings_end().

So a non-zero ARCH_PAGE_TABLE_SYNC_MASK indicates that a platform is subscribing
to the *first* mechanism. It has nothing to do with the second mechanism. If the
platform defines arch_update_kernel_mappings_begin() it wants it to be called.
If it doesn't define it, then it doesn't get called.

Thanks,
Ryan


