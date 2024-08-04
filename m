Return-Path: <linux-kernel+bounces-273978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF85A94704B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 21:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 436C61F21304
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 19:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA693137C2A;
	Sun,  4 Aug 2024 19:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iny6BX1H"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713762FB6;
	Sun,  4 Aug 2024 19:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722798175; cv=none; b=sZv+uwWhNt5n4EtQiCEhl7/s3Kf0PfqRE2UU5ZtF5Q8ZNMR3SWoc/fflf4UQhaG5UM+FbxFHP9CGyo2FNQUEYqkySHxh56BLSa3m9304Ghrml1xmkxtF80CGJ4p64PQv+pjoShavhc4Faj1T4u40taN91o/3/1YtSj5nGFmrtx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722798175; c=relaxed/simple;
	bh=1nA02rIFvo5t0pF1s8mAUEzzSh0h26YjGZyM1+ancMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H4gsJN2ZbDl0VJY97wOeMyVnELWueurDTtnb8AUt62jRUyBHiM5GW7pqGHQOUbSUkq7mzL6wEtur3t0+QMCnBqaR3qLkW5ykQCpL9fYXnwQtvYMokfEqrIv0FRJF1QIvLzH9iLGTb/EkMV2/ymrkzmvxvLhpUXHaqyPDUzdMKvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iny6BX1H; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-428e3129851so23932265e9.3;
        Sun, 04 Aug 2024 12:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722798172; x=1723402972; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hz7R2Ty5rI644L+aZRwcCu+6JYHROtbtRIc+iiT+6Oo=;
        b=iny6BX1Hpeu4u6qwLcf6sMGd9D2ta/djLVk9iPjZAmBeTg9jdUTVYuXaNUKAlDQraz
         w76MixKWOPcsmfOtD8BZK/QyjOhdL9zUaAUT86xsF04rG8dEsVD9JRrPqAq/O2cOwR3l
         jrOw9OakisSRJTmsEM+shXAN2oEvxvR/hrHtVGtbI3II9VPUkqmPLOBLYiryh2TKP6Tw
         lFdANwZLiQoAC+N77nZwCX6ETyw+UQqg/NBXcqgH1k8kpAgJFZUNWW6CbHO7vkKFB4Ne
         IsVcFEy+iGSwUf3DswiquiRY7E3Bf++RpfzX9LiDpUQR8fx6+82oaaZZBdDIfVYPOhl3
         +d0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722798172; x=1723402972;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hz7R2Ty5rI644L+aZRwcCu+6JYHROtbtRIc+iiT+6Oo=;
        b=uQV3DTTeFg4p+Nd+AMQQGM0F4VaNw+of75whQ5fjrR82HzBg0jdEwfv+ih/S/wVRCx
         /72i+CsIjnGnN/tRslOZVkCPP33UVobiiZJvriHFRUS+3kOMQoK+XQgx0EVEVtd+mJwg
         +hHki1ea284e4eSxZni0fXd4YhX+uo2LVeDgoLVZJnJciz/rPZADukgaUI604gAmDFl5
         OXz8BnfK5qBzzyKhVib546XhL34BCWW/u/mKTZzhWs0moK81oCCtt72les4mY1KmDHny
         UkWtIk8XztbH/+lK8ajh2OMbe7ttpR4xFvVgzIofGw2jDQuioVZqy5wA1CgXR1YrM1iD
         dP9A==
X-Forwarded-Encrypted: i=1; AJvYcCUPB1QT5hdAZszEU4wM0xztTTcjFn+9n0P0suLEBVQdDqTYwcKtYPSFcWvdzsj3qvfJeiqaSDigWZZ78bqTPxB2EMJhi8s1NPz1yxNsg3ZkiLPCbzv8Cy1UNcEokVl2dzdRECP8g/j2
X-Gm-Message-State: AOJu0YxuxawT6GshA0RMLXUZZSlorvzTGQrxAVc44OvX3U36Cj5FYzAk
	rJEk9Pf7KopbD/N7tMGps3x8fjh50acrUzOORjFPqkOZ8OCFqzUj
X-Google-Smtp-Source: AGHT+IGqNwpIsLePU/mO8k7Ngroe+oB8mKVrvss3k+CKug2OPvlElRGfv6OO825J/c9b1H1bKcvtXQ==
X-Received: by 2002:a05:600c:524f:b0:428:17b6:bcf1 with SMTP id 5b1f17b1804b1-428e6b0a2bcmr73653245e9.22.1722798171311;
        Sun, 04 Aug 2024 12:02:51 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e750:7600:c5:51ce:2b5:970b? ([2a02:6b6f:e750:7600:c5:51ce:2b5:970b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bab9f7esm167222755e9.21.2024.08.04.12.02.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Aug 2024 12:02:51 -0700 (PDT)
Message-ID: <6622b7b4-e558-4d14-bc72-33e8008b06ec@gmail.com>
Date: Sun, 4 Aug 2024 20:02:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] mm: free zapped tail pages when splitting isolated
 thp
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev,
 roman.gushchin@linux.dev, yuzhao@google.com, baohua@kernel.org,
 ryan.roberts@arm.com, rppt@kernel.org, willy@infradead.org,
 cerasuolodomenico@gmail.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com,
 Shuang Zhai <zhais@google.com>
References: <20240730125346.1580150-1-usamaarif642@gmail.com>
 <20240730125346.1580150-4-usamaarif642@gmail.com>
 <3be3dacd-1f45-468f-a363-b9d3a10aeb89@redhat.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <3be3dacd-1f45-468f-a363-b9d3a10aeb89@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 30/07/2024 16:14, David Hildenbrand wrote:
> On 30.07.24 14:46, Usama Arif wrote:
>> From: Yu Zhao <yuzhao@google.com>
>>
>> If a tail page has only two references left, one inherited from the
>> isolation of its head and the other from lru_add_page_tail() which we
>> are about to drop, it means this tail page was concurrently zapped.
>> Then we can safely free it and save page reclaim or migration the
>> trouble of trying it.
>>
>> Signed-off-by: Yu Zhao <yuzhao@google.com>
>> Tested-by: Shuang Zhai <zhais@google.com>
>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>> ---
>>   mm/huge_memory.c | 26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 0167dc27e365..76a3b6a2b796 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -2923,6 +2923,8 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>>       unsigned int new_nr = 1 << new_order;
>>       int order = folio_order(folio);
>>       unsigned int nr = 1 << order;
>> +    LIST_HEAD(pages_to_free);
>> +    int nr_pages_to_free = 0;
>>         /* complete memcg works before add pages to LRU */
>>       split_page_memcg(head, order, new_order);
>> @@ -3007,6 +3009,24 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>>           if (subpage == page)
>>               continue;
>>           folio_unlock(new_folio);
>> +        /*
>> +         * If a tail page has only two references left, one inherited
>> +         * from the isolation of its head and the other from
>> +         * lru_add_page_tail() which we are about to drop, it means this
>> +         * tail page was concurrently zapped. Then we can safely free it
>> +         * and save page reclaim or migration the trouble of trying it.
>> +         */
>> +        if (list && page_ref_freeze(subpage, 2)) {
>> +            VM_BUG_ON_PAGE(PageLRU(subpage), subpage);
>> +            VM_BUG_ON_PAGE(PageCompound(subpage), subpage);
>> +            VM_BUG_ON_PAGE(page_mapped(subpage), subpage);
>> +
> 
> No VM_BUG_*, VM_WARN is good enough.
> 
>> +            ClearPageActive(subpage);
>> +            ClearPageUnevictable(subpage);
>> +            list_move(&subpage->lru, &pages_to_free);
> 
> Most checks here should operate on new_folio instead of subpage.
> 
> 
Do you mean instead of doing the PageLRU, PageCompound and page_mapped check on the subpage, there should be checks on new_folio?
If new_folio is a large folio, then it could be that only some of the subpages were zapped?

Could do below if subpage makes sense

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 3305e6d0b90e..abfcd4b7cbba 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3041,9 +3041,9 @@ static void __split_huge_page(struct page *page, struct list_head *list,
                 * and save page reclaim or migration the trouble of trying it.
                 */
                if (list && page_ref_freeze(subpage, 2)) {
-                       VM_BUG_ON_PAGE(PageLRU(subpage), subpage);
-                       VM_BUG_ON_PAGE(PageCompound(subpage), subpage);
-                       VM_BUG_ON_PAGE(page_mapped(subpage), subpage);
+                       VM_WARN_ON_ONCE_PAGE(PageLRU(subpage), subpage);
+                       VM_WARN_ON_ONCE_PAGE(PageCompound(subpage), subpage);
+                       VM_WARN_ON_ONCE_PAGE(page_mapped(subpage), subpage);
 
                        ClearPageActive(subpage);
                        ClearPageUnevictable(subpage);

