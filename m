Return-Path: <linux-kernel+bounces-510771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B48A321B6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0649D18860D3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407A0205ACE;
	Wed, 12 Feb 2025 09:06:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695BB1D86F2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 09:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739351182; cv=none; b=hAqxFfKp4Hsdsjyg15qcQcn6Iq0fHz8j4ss6o7pLenCqqM+sXSzLU/Mz/I6VRvo5/TMcnSFt2N+dL52slvZq8645JesxWc/V6TaqSKNIShnkswZnWg07KQvN0ySQadw4ugUha/YmeExBH5hnPvM/AYxw9a+iWzVBiCkBL7yU5YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739351182; c=relaxed/simple;
	bh=stwLR5GSPXOa5U8+urbEYw7ByWYe8oojGTKQJzML/FY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mje4be2saIRVkCSdJD15SiRIowmfrTKFRoUIjihg3IqWtJe3PXdW+bVyegTeXBIWcywVSgjYaxA7poCHYEo4Ey4Gub5sfTERgMT5lGItfmKm6BSbxl5PfZjlkZ3FNG7XIQw7jdckwBYSokQqWZHF47deYw5pTSTGKIK3eM2pmJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F1EE13D5;
	Wed, 12 Feb 2025 01:06:40 -0800 (PST)
Received: from [10.162.43.26] (K4MQJ0H1H2.blr.arm.com [10.162.43.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 548DF3F58B;
	Wed, 12 Feb 2025 01:06:17 -0800 (PST)
Message-ID: <27db405d-666a-4064-b13c-9f1c81b8512a@arm.com>
Date: Wed, 12 Feb 2025 14:36:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm/mm.h: Write folio->_flags_1 & 0xff as a macro
 definition
To: liuye <liuye@kylinos.cn>, brauner@kernel.org, dhowells@redhat.com,
 akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20250212025843.80283-1-liuye@kylinos.cn>
 <20250212025843.80283-3-liuye@kylinos.cn>
 <1739340112672653.3.seg@mailgw.kylinos.cn>
 <52fcd6b2-bbe1-4de7-85d1-1e5968f87e0d@kylinos.cn>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <52fcd6b2-bbe1-4de7-85d1-1e5968f87e0d@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/02/25 12:37 pm, liuye wrote:
> 
> 
> 在 2025/2/12 13:12, Dev Jain 写道:
>>
>>
>> On 12/02/25 8:28 am, Liu Ye wrote:
>>> There are multiple locations in mm.h where (folio->_flags_1 & 0xff) is
>>> used. Write it as a macro definition to improve the readability and
>>> maintainability of the code.
>>>
>>> Signed-off-by: Liu Ye <liuye@kylinos.cn>
>>> ---
>>>    include/linux/mm.h | 10 ++++++----
>>>    1 file changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>> index 7b1068ddcbb7..750e75f45557 100644
>>> --- a/include/linux/mm.h
>>> +++ b/include/linux/mm.h
>>> @@ -1098,6 +1098,8 @@ int vma_is_stack_for_current(struct vm_area_struct *vma);
>>>    struct mmu_gather;
>>>    struct inode;
>>>    +#define FOLIO_ORDER(folio) ((folio)->_flags_1 & 0xff)
>>> +
>>>    /*
>>>     * compound_order() can be called without holding a reference, which means
>>>     * that niceties like page_folio() don't work.  These callers should be
>>> @@ -1111,7 +1113,7 @@ static inline unsigned int compound_order(struct page *page)
>>>          if (!test_bit(PG_head, &folio->flags))
>>>            return 0;
>>> -    return folio->_flags_1 & 0xff;
>>> +    return FOLIO_ORDER(folio);
>>>    }
>>>      /**
>>> @@ -1127,7 +1129,7 @@ static inline unsigned int folio_order(const struct folio *folio)
>>>    {
>>>        if (!folio_test_large(folio))
>>>            return 0;
>>> -    return folio->_flags_1 & 0xff;
>>> +    return FOLIO_ORDER(folio);
>>>    }
>>>      #include <linux/huge_mm.h>
>>> @@ -2061,7 +2063,7 @@ static inline long folio_nr_pages(const struct folio *folio)
>>>    #ifdef CONFIG_64BIT
>>>        return folio->_folio_nr_pages;
>>>    #else
>>> -    return 1L << (folio->_flags_1 & 0xff);
>>> +    return 1L << FOLIO_ORDER(folio);
>>>    #endif
>>>    }
>>>    @@ -2086,7 +2088,7 @@ static inline unsigned long compound_nr(struct page *page)
>>>    #ifdef CONFIG_64BIT
>>>        return folio->_folio_nr_pages;
>>>    #else
>>> -    return 1L << (folio->_flags_1 & 0xff);
>>> +    return 1L << FOLIO_ORDER(folio);
>>>    #endif
>>>    }
>>>    
>>
>> Personally I do not think this is improving readability. You are introducing one more macro for people to decipher instead of directly seeing folio->_flags_1 & 0xff. This is similar to whether to write
>> if (x) => do_stuff(), or if (x != 0) => do_stuff(). The former is more "readable" by convention but the latter makes it easier and obvious to understand.
>>
> Or simply for maintenance purposes, if the meaning of a bit changes, only the macro definition needs to be modified.

Well, then let us wait for that time to come :) Personally I am not a 
fan of over-abstracting, especially when it is just a single line; one 
benefit I have seen of writing the way it is written right now, is that 
I actually get reminded where the folio order is actually stored. I have 
no objection on getting this patch applied, if someone else thinks this 
is a fruitful abstraction. In any case, you do need to come up with a 
better name than FOLIO_ORDER, as it is confusing.

> 
> Thanks，
> Liu Ye
> 

> 
> 


