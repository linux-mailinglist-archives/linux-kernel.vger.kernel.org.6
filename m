Return-Path: <linux-kernel+bounces-422289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B959D9722
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 13:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE3D028332F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 12:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F801CEE88;
	Tue, 26 Nov 2024 12:18:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0D91CBE8C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 12:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732623498; cv=none; b=eH1kmGbgkKdM4ZL5yZs72ErVBycqys6ePM3PmWBiTaUhurPl5f5PPHMaBIS6Rs2Ec1a/ALSedmfA5sRn4Jqxpc8jPJ12DOFcmuj8ZJqU9azJfUsxnvrmdBjPI/ajD++ijCeGiK3rBo9/Gf82+ojyUhGLuR1r2ho9wetNjt2iJts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732623498; c=relaxed/simple;
	bh=rq4GZqbGJZiK9iIYVLyKZz94uPO93WqM83KGwpYj/+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=alY0VgGhdR4krOwh/EcN07MLJMWYQ6hWJVSHmMTMBXvssbY2wLOb/nwEoibbMyFS4CtMTPIxddvWTae2uZqb74XlaDlJFu9I3wJHoz12UIQLNdl9Zu5AWMgFO6wNeAsXj506JhhEddfnwSYWXYZUGsR1sqHS9TpbcMy91Khwl1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A889F153B;
	Tue, 26 Nov 2024 04:18:44 -0800 (PST)
Received: from [10.1.29.199] (XHFQ2J9959.cambridge.arm.com [10.1.29.199])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6E433F58B;
	Tue, 26 Nov 2024 04:18:13 -0800 (PST)
Message-ID: <7fb6c5a2-b9ae-4a29-a871-2f0bdc636e41@arm.com>
Date: Tue, 26 Nov 2024 12:18:12 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm/slab: Avoid build bug for calls to kmalloc with a
 large constant
Content-Language: en-GB
To: Vlastimil Babka <vbabka@suse.cz>, Dave Kleikamp
 <dave.kleikamp@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-6-ryan.roberts@arm.com>
 <44312f4a-8b9c-49ce-9277-5873a94ca1bb@oracle.com>
 <cb9cabed-0038-42b3-b9fc-c9ba62b12781@suse.cz>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <cb9cabed-0038-42b3-b9fc-c9ba62b12781@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/11/2024 10:09, Vlastimil Babka wrote:
> On 11/1/24 21:16, Dave Kleikamp wrote:
>> When boot-time page size is enabled, the test against KMALLOC_MAX_CACHE_SIZE
>> is no longer optimized out with a constant size, so a build bug may
>> occur on a path that won't be reached.
> 
> That's rather unfortunate, the __builtin_constant_p(size) part of
> kmalloc_noprof() really expects things to resolve at compile time and it
> would be better to keep it that way.
> 
> I think it would be better if we based KMALLOC_MAX_CACHE_SIZE itself on
> PAGE_SHIFT_MAX and kept it constant, instead of introducing
> KMALLOC_SHIFT_HIGH_MAX only for some sanity checks.
> 
> So if the kernel was built to support 4k to 64k, but booted as 4k, it would
> still create and use kmalloc caches up to 128k. SLUB should handle that fine
> (if not, please report it :)

So when PAGE_SIZE_MAX=64K and PAGE_SIZE=4K, kmalloc will support up to 128K
whereas before it only supported up to 8K. I was trying to avoid that since I
assumed that would be costly in terms of extra memory allocated for those higher
order buckets that will never be used. But I have no idea how SLUB works in
practice. Perhaps memory for the cache is only lazily allocated so we won't see
an issue in practice?

I'm happy to make this change if you're certain it's the right approach; please
confirm.

> 
> Maybe we could also stop adding + 1 to PAGE_SHIFT_MAX if it's >=64k, so the
> cache size is max 64k and not 128k but that should be probably evaluated
> separately from this series.

I'm inferring from this that perhaps there is a memory cost with having the
higher orders defined but unused.

Thanks,
Ryan

> 
> Vlastimil
> 
>> Found compiling drivers/net/ethernet/qlogic/qed/qed_sriov.c
>>
>> Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
>> ---
>>
>> Ryan,
>>
>> Please consider incorporating this fix or something similar into your
>> mm patch in the boot-time pages size patches.
>>
>>   include/linux/slab.h | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/slab.h b/include/linux/slab.h
>> index 9848296ca6ba..a4c7507ab8ec 100644
>> --- a/include/linux/slab.h
>> +++ b/include/linux/slab.h
>> @@ -685,7 +685,8 @@ static __always_inline unsigned int __kmalloc_index(size_t size,
>>   	if (size <= 1024 * 1024) return 20;
>>   	if (size <=  2 * 1024 * 1024) return 21;
>>   
>> -	if (!IS_ENABLED(CONFIG_PROFILE_ALL_BRANCHES) && size_is_constant)
>> +	if (!IS_ENABLED(CONFIG_ARM64_BOOT_TIME_PAGE_SIZE) &&
>> +	    !IS_ENABLED(CONFIG_PROFILE_ALL_BRANCHES) && size_is_constant)
>>   		BUILD_BUG_ON_MSG(1, "unexpected size in kmalloc_index()");
>>   	else
>>   		BUG();
> 


