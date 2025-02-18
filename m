Return-Path: <linux-kernel+bounces-518620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0007FA39206
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 05:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C20E3163F1A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 04:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B973A19F128;
	Tue, 18 Feb 2025 04:02:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111FE192D8A
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 04:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739851349; cv=none; b=QvmTaphwLdhTmBm/9gSu996gZknqEQS5m0iDsm/CiqD1RyXzi+VW9YAYefnCqyCACKqXZ9wP277W61E9IhcXT1un171QlLxK32GOb0E4/UjAw0UO9rNrS+Qnk/KuQ3/H0EmZ6MCpgl9/1sBYFQ5MHbWlcACSCObZ8AjyQ0JUAG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739851349; c=relaxed/simple;
	bh=zgXfcX8cWnp5ttK/cEYFiu0UrdB7Qa86ypq0Ib0fOtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FvtCnUzO7eIF22kWvbV6x04JUj3EYoa8N7hswEf/DuVDngC20weV+PTF6aJbz1WgZex/8SWd0wp1ZS6sZiysiD9zdUOZ7fDAM8imIWfHWYxpy7kb6Pa3Fj+O7ZE2It/smqZjbgTrP34e3m6UHIPNxL33KTbdbXxSE/U6ReVccyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF060152B;
	Mon, 17 Feb 2025 20:02:44 -0800 (PST)
Received: from [10.163.37.233] (unknown [10.163.37.233])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7992F3F5A1;
	Mon, 17 Feb 2025 20:02:23 -0800 (PST)
Message-ID: <110e8959-1d5e-4184-86f8-f4bfbb06e871@arm.com>
Date: Tue, 18 Feb 2025 09:32:21 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/hugetlb: Consistently use pud_sect_supported()
To: Ryan Roberts <ryan.roberts@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20250217065414.49489-1-anshuman.khandual@arm.com>
 <271c6277-baab-4b69-97ea-d6c80f873fe5@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <271c6277-baab-4b69-97ea-d6c80f873fe5@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/17/25 19:51, Ryan Roberts wrote:
> On 17/02/2025 06:54, Anshuman Khandual wrote:
>> Let's be consistent in using pud_sect_supported() for PUD_SIZE sized pages.
>> Hence change hugetlb_mask_last_page() and arch_make_huge_pte() as required.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> This patch applies on v6.14-rc3
>>
>>  arch/arm64/mm/hugetlbpage.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
>> index 98a2a0e64e25..5b7cfdba9c93 100644
>> --- a/arch/arm64/mm/hugetlbpage.c
>> +++ b/arch/arm64/mm/hugetlbpage.c
>> @@ -342,7 +342,9 @@ unsigned long hugetlb_mask_last_page(struct hstate *h)
>>  	switch (hp_size) {
>>  #ifndef __PAGETABLE_PMD_FOLDED
>>  	case PUD_SIZE:
>> -		return PGDIR_SIZE - PUD_SIZE;
>> +		if (pud_sect_supported())
>> +			return PGDIR_SIZE - PUD_SIZE;
>> +		break;
>>  #endif
>>  	case CONT_PMD_SIZE:
>>  		return PUD_SIZE - CONT_PMD_SIZE;
>> @@ -364,7 +366,8 @@ pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
>>  	switch (pagesize) {
>>  #ifndef __PAGETABLE_PMD_FOLDED
>>  	case PUD_SIZE:
>> -		entry = pud_pte(pud_mkhuge(pte_pud(entry)));
>> +		if (pud_sect_supported())
>> +			entry = pud_pte(pud_mkhuge(pte_pud(entry)));
> 
> If this was to get called with PUD_SIZE for a config that doesn't fold the PMD
> and which pud_sect_supported() returns false, we will now return the entry
> unmodified and will not emit the warning that the default case emits. I think we
> should at least either modify the entry (so that it is safe) or emit the
> warning. Doing neither seems less defensive than the current situation.

An warning can be added before breaking when pud_sect_supported() returns false
which will help inform the user that the page table entry did not get modified.

        switch (pagesize) {
#ifndef __PAGETABLE_PMD_FOLDED
        case PUD_SIZE:
                if (pud_sect_supported())
                        entry = pud_pte(pud_mkhuge(pte_pud(entry)));
                else
                        pr_warn("%s: pud huge page not supported\n", __func__);
                break;
#endif

> 
>>  		break;
>>  #endif
>>  	case CONT_PMD_SIZE:
> 

