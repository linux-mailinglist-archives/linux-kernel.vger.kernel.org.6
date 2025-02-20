Return-Path: <linux-kernel+bounces-524696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE35A3E5EF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CD1D188CD83
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33578214210;
	Thu, 20 Feb 2025 20:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GEOiuSWk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BFA1E9B29
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 20:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740083868; cv=none; b=PEhTqqbZXPgugOoUtS5tpSJS7AqLmuEsuYHZRxXDdd01z4K6mfAgmY7IX7chAf/dHAM/DiQMUjONUCc8N/j5nei6RsYYkQT8yWZqL5gGAKE2wRCRij/KiEwHiYElGYVr89VninrC5XZ4blhxNpQI77RVQvSaB9KDKDLw/cMzqnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740083868; c=relaxed/simple;
	bh=VeYwEj+Oulu/vT6AMdDBujciBinxjGVC4xu2APv1nNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TZ2zV8F6mkCcqAfPd0SjhYwawApoWI8SFR0XI+XYXSUHFzaH1B1DGUyQLbJKFcKJx9KRXTHefMPRenwxpuiXnJ+N2oC71/t9VCs7Y3A/iD76dHSqd8VdNvOhCJcdDk2ZL+7GkxQcqx9nyBU86KYWY0GaR6H43Yzk6m+PKDxFzbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GEOiuSWk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740083865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8t4gQ1JMFD1FIhHE3k4ie/A6wJVY2Cs3xyygQZCuQmk=;
	b=GEOiuSWkoxMxPeuI+YOe42BOD2sl+wxr93os9xtL4YDN1dDM53XkDJSPeYbgOmHkJ64d70
	YxnQZ/YHWtzAkNHGvt1KJ9Ifc7kqyrLvbJiBm/BaklNgRWkCgNsLbhOI4zkrbTki12C/mw
	7dzw3BtvZkuzxq5cdUOgBCyIKVN/te8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-S0c3qE5OOOqDeoO2_9mFHw-1; Thu, 20 Feb 2025 15:37:38 -0500
X-MC-Unique: S0c3qE5OOOqDeoO2_9mFHw-1
X-Mimecast-MFC-AGG-ID: S0c3qE5OOOqDeoO2_9mFHw_1740083858
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c09b9c6991so201848885a.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:37:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740083858; x=1740688658;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8t4gQ1JMFD1FIhHE3k4ie/A6wJVY2Cs3xyygQZCuQmk=;
        b=SACMipd7oNNCNjhz+SHu4GSAiM3n/Lag3f93HMYZuZCEV70/VzkadR7nN+wkwiS+5Q
         YQAUADzep8VcTEfDp8nJ/JYK0JiGDn5JsY4mKBZDMIwcLc+W5Dcj8wfVg1VRJi5pn4vp
         TXx9NjyFMpiNtlLDsIlbmW1DEXm1yPCkqgM7sb4pZT+ZeOOm4dQT7wG1fsMBbe9iyB/D
         7nQFnO/XsmlboAe+jlFeKdISR5EV2YlknIfOnKkrUcVW7a2ylqB49srxfQjhrxVvuF3O
         l7Tst5pcUHoZx6zT6/ELQfiM3HYbFwuNXNlAiQDtZ20WxymDVGkNGaIKO36gSASkb7/I
         rZIw==
X-Forwarded-Encrypted: i=1; AJvYcCXfBuO3zc/Euq3QDXdGiZnWw8DXG5hnpTW85ILXeOYIpGEv5qdgLVg06voV1+mmbUFwRDUrjCekBf8cToU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlgdUTMd+eA0Xgc/6KIkH6pDzyr2yrFEHI/cFTL5MYULbCOg32
	xnfSlY4JoqMLoWwF23I5z6gJlVs3XMSFCSd+y8DKDmoUFicp6DxBW9zHtCLMfdJ9MSE/Y6M8brF
	n1RhgyGMmbe5s2Vah7h1zz/yrkQz6kChwqVcz6Tf5J7zHjDqx17BXnKz8JEeDaw==
X-Gm-Gg: ASbGncvl7GWyE9B5sPYOZTYTPXkYXy/IoQhZ/ktqYHq9Xw4lagJH8PUVhPI/pijQGXM
	hA9fw32fQl9Pw7rl91vlqUelSPothZr+SEgTy770Mmb0PibEwBbSEyWPrJ+772on5EyF5HLH5Gj
	l1F6SRnAolP/CGbl74A5Eq2cd+2uDp7b9qXUqugUxu/LJdBNfiw79QWRL57Mv1AM9kL5TAzu0YM
	9OEVWCL8scNgSsmiY9G7yyc9JRmC/l36Pp9ndj1rsS+lIdSAln+EwcJRDyWIkf+uBOYU9VeBxbD
	hglq
X-Received: by 2002:a05:620a:1b94:b0:7c0:c7c7:5b08 with SMTP id af79cd13be357-7c0cf8aee9bmr41207685a.5.1740083858219;
        Thu, 20 Feb 2025 12:37:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQnPB9fIqgx7TSd4yBAmNnmM+SXL1P3mBIPVdAnB4Bp74kZ5q41R7E3sPDOBIl20xeYuY8gQ==
X-Received: by 2002:a05:620a:1b94:b0:7c0:c7c7:5b08 with SMTP id af79cd13be357-7c0cf8aee9bmr41203985a.5.1740083857850;
        Thu, 20 Feb 2025 12:37:37 -0800 (PST)
Received: from [192.168.2.110] ([70.52.22.87])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d9f3458sm89316446d6.92.2025.02.20.12.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 12:37:37 -0800 (PST)
Message-ID: <45f945af-d1f4-4509-841b-1199288d12c0@redhat.com>
Date: Thu, 20 Feb 2025 15:37:26 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] mm: page_table_check: use new iteration API
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, yuzhao@google.com, pasha.tatashin@soleen.com
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, muchun.song@linux.dev
References: <cover.1739931468.git.luizcap@redhat.com>
 <85f11743d259d5e4a1f47456fbcda82ff6db9ab3.1739931468.git.luizcap@redhat.com>
 <fdef74f3-ada8-40c7-afea-9a0105f5c05f@redhat.com>
Content-Language: en-US, en-CA
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <fdef74f3-ada8-40c7-afea-9a0105f5c05f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-02-20 06:05, David Hildenbrand wrote:
> On 19.02.25 03:17, Luiz Capitulino wrote:
>> The page_ext_next() function assumes that page extension objects for a
>> page order allocation always reside in the same memory section, which
>> may not be true and could lead to crashes. Use the new page_ext
>> iteration API instead.
>>
>> Fixes: cf54f310d0d3 ("mm/hugetlb: use __GFP_COMP for gigantic folios")
>> Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
>> ---
>>   mm/page_table_check.c | 39 ++++++++++++---------------------------
>>   1 file changed, 12 insertions(+), 27 deletions(-)
>>
>> diff --git a/mm/page_table_check.c b/mm/page_table_check.c
>> index 509c6ef8de400..b52e04d31c809 100644
>> --- a/mm/page_table_check.c
>> +++ b/mm/page_table_check.c
>> @@ -62,24 +62,20 @@ static struct page_table_check *get_page_table_check(struct page_ext *page_ext)
>>    */
>>   static void page_table_check_clear(unsigned long pfn, unsigned long pgcnt)
>>   {
>> +    struct page_ext_iter iter;
>>       struct page_ext *page_ext;
>>       struct page *page;
>> -    unsigned long i;
>>       bool anon;
>>       if (!pfn_valid(pfn))
>>           return;
>>       page = pfn_to_page(pfn);
>> -    page_ext = page_ext_get(page);
>> -
>> -    if (!page_ext)
>> -        return;
>> -
>>       BUG_ON(PageSlab(page));
>>       anon = PageAnon(page);
>> -    for (i = 0; i < pgcnt; i++) {
>> +    rcu_read_lock();
>> +    for_each_page_ext(page, pgcnt, page_ext, iter) {
>>           struct page_table_check *ptc = get_page_table_check(page_ext);
>>           if (anon) {
>> @@ -89,9 +85,8 @@ static void page_table_check_clear(unsigned long pfn, unsigned long pgcnt)
>>               BUG_ON(atomic_read(&ptc->anon_map_count));
>>               BUG_ON(atomic_dec_return(&ptc->file_map_count) < 0);
>>           }
>> -        page_ext = page_ext_next(page_ext);
>>       }
>> -    page_ext_put(page_ext);
>> +    rcu_read_unlock();
>>   }
> 
> [...]
> 
>>   /*
>> @@ -140,24 +130,19 @@ static void page_table_check_set(unsigned long pfn, unsigned long pgcnt,
>>    */
>>   void __page_table_check_zero(struct page *page, unsigned int order)
>>   {
>> +    struct page_ext_iter iter;
>>       struct page_ext *page_ext;
>> -    unsigned long i;
>>       BUG_ON(PageSlab(page));
>> -    page_ext = page_ext_get(page);
>> -
>> -    if (!page_ext)
>> -        return;
>> -
>> -    for (i = 0; i < (1ul << order); i++) {
>> +    rcu_read_lock();
>> +    for_each_page_ext_order(page, order, page_ext, iter) {
> 
> I would avoid introducing for_each_page_ext_order() and just pass "1 << order" as the page count.

OK, I'll drop it.

> 
>>           struct page_table_check *ptc = get_page_table_check(page_ext);
>>           BUG_ON(atomic_read(&ptc->anon_map_count));
>>           BUG_ON(atomic_read(&ptc->file_map_count));
>> -        page_ext = page_ext_next(page_ext);
>>       }
>> -    page_ext_put(page_ext);
>> +    rcu_read_unlock();
>>   }
>>   void __page_table_check_pte_clear(struct mm_struct *mm, pte_t pte)
> 
> Apart from that, this looks very nice to me
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 


