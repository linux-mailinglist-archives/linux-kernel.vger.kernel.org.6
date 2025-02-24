Return-Path: <linux-kernel+bounces-529011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1659A41EF8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A71C417B2F6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FD323BD05;
	Mon, 24 Feb 2025 12:18:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A8E219318
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740399519; cv=none; b=nWFeXSys3Vu0t9XBdPiMCCJWI8ETU7SoUrfdGOZSOYWfENmmX5IMd8Joo4YsGEEx285sVdEnJx+Dl3Zj+PjJIUkQ6JyeZDaS9G5B12AEiSwCrflbZ6F6euvgpO8XMaY6yGPHTzV4Ze/+HFsPJhjK76e5TXkpKs4uRWZcKnOxnOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740399519; c=relaxed/simple;
	bh=b93OAySF2grsGEcJBS1Jow13MLA7Wt5wc3bPbytWNWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pgbo84z0XGlxvzImwwnwuvflLrojgnvl6aTOV8dFYjopzj6IGNlFK0RsYzjcmOyrSzQv1dhKFqdBt5Qq2f3oBEa1+rJnmJcAe7RP69GclTbkP+rrhFO3tcYuqLdrR+O4jtsQGD4byVVvqMWqj5zljQe5FUQnxYl66yJkcNKCv5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B76E61756;
	Mon, 24 Feb 2025 04:18:53 -0800 (PST)
Received: from [10.1.27.150] (XHFQ2J9959.cambridge.arm.com [10.1.27.150])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D73FA3F6A8;
	Mon, 24 Feb 2025 04:18:34 -0800 (PST)
Message-ID: <30b3ed49-1e83-40ed-8e59-f891eb416289@arm.com>
Date: Mon, 24 Feb 2025 12:18:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/14] arm64/mm: Hoist barriers out of set_ptes_anysz()
 loop
Content-Language: en-GB
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 David Hildenbrand <david@redhat.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250217140809.1702789-1-ryan.roberts@arm.com>
 <20250217140809.1702789-7-ryan.roberts@arm.com> <Z7m7e1W8LpYvV_h0@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <Z7m7e1W8LpYvV_h0@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/02/2025 11:56, Catalin Marinas wrote:
> On Mon, Feb 17, 2025 at 02:07:58PM +0000, Ryan Roberts wrote:
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index e255a36380dc..e4b1946b261f 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -317,10 +317,8 @@ static inline void __set_pte_nosync(pte_t *ptep, pte_t pte)
>>  	WRITE_ONCE(*ptep, pte);
>>  }
>>  
>> -static inline void __set_pte(pte_t *ptep, pte_t pte)
>> +static inline void __set_pte_complete(pte_t pte)
>>  {
>> -	__set_pte_nosync(ptep, pte);
>> -
>>  	/*
>>  	 * Only if the new pte is valid and kernel, otherwise TLB maintenance
>>  	 * or update_mmu_cache() have the necessary barriers.
> 
> Unrelated to this patch but I just realised that this comment is stale,
> we no longer do anything in update_mmu_cache() since commit 120798d2e7d1
> ("arm64: mm: remove dsb from update_mmu_cache"). If you respin, please
> remove the update_mmu_cache() part as well.

Will do!

> 
> Thanks.
> 


