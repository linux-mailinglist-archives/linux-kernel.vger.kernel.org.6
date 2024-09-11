Return-Path: <linux-kernel+bounces-325139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE4E97557B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E1FE1C22CCA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4BC1A3047;
	Wed, 11 Sep 2024 14:32:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA60191F8C
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 14:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726065137; cv=none; b=X/jZ58Qa91c0lI5/omTAsUeKMYO9F6e2zLik5sjvVVqRz2hXH4Ey0E354OAkGRjBjmAL9u48AdrGVoMRLTOMjvipvYegXMtMEB+HW4ldsXjJ84m9Lm/wo329E+dh0pGYqBWrSvGo4TLudtInv3MvtFZljuaZNuqtCaNKKe5Ao3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726065137; c=relaxed/simple;
	bh=ZaUhqH2peDz4VHE2HtDI/8mnCLs4am0FQQAdq3dSPKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gRy7GzZgvoO53YKnO/vmz8nrcJtyd2dqTvnzLK9+czEWdOr+7QTeeL9fLfF1QrDbze/eBqnGdpRDqXij9Q9yA/XTR7W+y2OdIleMfZwum2YBzBkbLW34CPx360bfg9vtQ87mv7PMTt5F1uZGr6aN2Hy9s+Wt/CWe/LB05XgFTyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5D611007;
	Wed, 11 Sep 2024 07:32:43 -0700 (PDT)
Received: from [10.1.30.171] (XHFQ2J9959.cambridge.arm.com [10.1.30.171])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E41F3F73B;
	Wed, 11 Sep 2024 07:32:13 -0700 (PDT)
Message-ID: <80d64b74-ae09-4737-8fed-bdc328da71a5@arm.com>
Date: Wed, 11 Sep 2024 15:32:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Drop unused set_pte_safe()
Content-Language: en-GB
To: Matthew Wilcox <willy@infradead.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, linux-kernel@vger.kernel.org
References: <20240910090409.374424-1-anshuman.khandual@arm.com>
 <cae9c32d-c96e-463e-9375-91d9a7ad196a@arm.com>
 <ZuB_524Dd1tezlX6@casper.infradead.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZuB_524Dd1tezlX6@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/09/2024 18:20, Matthew Wilcox wrote:
> On Tue, Sep 10, 2024 at 10:08:10AM +0100, Ryan Roberts wrote:
>> On 10/09/2024 10:04, Anshuman Khandual wrote:
>>> All set_pte_safe() usage have been dropped after the commit eccd906484d1
>>> ("x86/mm: Do not use set_{pud, pmd}_safe() when splitting a large page")
>>> This just drops now unused helper set_pte_safe().
>>
>> It would be good to add some comment here to mention that the macro was buggy
>> due to doing direct dereferencing of the pte, and that if it were to be kept, it
>> should have been updated to use a single call to ptep_get().
> 
> I'm not sure that the _macro_ would have been buggy in such a scenario.
> If I understand correctly, the _caller_ would have been buggy:
> 
> /*
>  * Use set_p*_safe(), and elide TLB flushing, when confident that *no*
>  * TLB flush will be required as a result of the "set". For example, use
>  * in scenarios where it is known ahead of time that the routine is
>  * setting non-present entries, or re-setting an existing entry to the
>  * same value. Otherwise, use the typical "set" helpers and flush the
>  * TLB.
>  */
> 
> so if *ptep changes between the two calls, that's the caller's bug,
> right?

I was referring to the fact that the ptep pointer is being directly dereferenced
by the macro. It should really be using ptep_get(). See commit c33c794828f21
("mm: ptep_get() conversion") for the explanation.

So it really depends on your definition of a bug; arm64 doesn't use this helper
so its not affected by the magic that arm64 does in its ptep_get(). So you'll
never see incorrect behavior as a result (and I suspect in this specific case,
even if arm64 did use it, you probably wouldn't notice a problem in practice).
Perhaps it would have been better described as a code smell.

And yes, it's my bug/code smell; I didn't catch this when doing the conversion;
I guess Coccinelle has no type information so didn't highlight it, and I only
used the compiler trick for arm64, which doesn't use this macro.

> 
> Otherwise, set_pmd_safe() would be buggy ...

arm64 doesn't do any magic in pmdp_get() like it does for ptep_get() (yet ;-) ).
So direct dereference of a pmdp pointer is a less hard requirement.

But there is still the issue of READ_ONCE() vs *pmdp. As I understand it,
technically these should all be READ_ONCE() to ensure single-copy atomicity, as
explained in commit 20a004e7b017c ("arm64: mm: Use READ_ONCE/WRITE_ONCE when
accessing page tables"). Although, probably in practice it doesn't really break
anything here since the PTL is held so the only racing writer is the page table
walker writing access and dirty bits, which shouldn't get in the way of the
tests done here.

Thanks,
Ryan

> 
>> With that:
>>
>> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
>>
>> Thanks,
>> Ryan
>>
>>>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>> Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
>>> Cc: linux-mm@kvack.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>>>  include/linux/pgtable.h | 6 ------
>>>  1 file changed, 6 deletions(-)
>>>
>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>>> index 2a6a3cccfc36..aeabbf0db7c8 100644
>>> --- a/include/linux/pgtable.h
>>> +++ b/include/linux/pgtable.h
>>> @@ -1058,12 +1058,6 @@ static inline int pgd_same(pgd_t pgd_a, pgd_t pgd_b)
>>>   * same value. Otherwise, use the typical "set" helpers and flush the
>>>   * TLB.
>>>   */
>>> -#define set_pte_safe(ptep, pte) \
>>> -({ \
>>> -	WARN_ON_ONCE(pte_present(*ptep) && !pte_same(*ptep, pte)); \
>>> -	set_pte(ptep, pte); \
>>> -})
>>> -
>>>  #define set_pmd_safe(pmdp, pmd) \
>>>  ({ \
>>>  	WARN_ON_ONCE(pmd_present(*pmdp) && !pmd_same(*pmdp, pmd)); \
>>
>>


