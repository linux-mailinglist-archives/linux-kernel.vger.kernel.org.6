Return-Path: <linux-kernel+bounces-187978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F10DD8CDB77
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 22:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A875B21E28
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 20:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4C384DFA;
	Thu, 23 May 2024 20:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lncx3PmN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF7384DE8
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 20:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716496729; cv=none; b=fom79trlUxYBzE7QyIccQ5ovi3Szg0jdbxJOyuL7Th5oI7idyXBhrUcC9ZEgvghajXcX23TJlxv9I7trXFIquLDWVCjJNIFWOibz4XZA3ZOOJIaCCM1aX6BwDia8iosUEHrs7K1ihTwoYwm1RapFOJsx4/TP9TIh2OYM7v9kDrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716496729; c=relaxed/simple;
	bh=fVRE/rGUXxaKt47jTJPSKiqvM3pCZWqr80ozSRk6koY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RijPqIp8qGFOga8jrZVWz3n5XmnahwYjD/3Ne7/tOES592H8cN2wN+796aPZ9DChLDWdnNWLAyPiujv3k9sToeSyLpR1oqMeX5C1sZvAV8m87Agh6N5Flahqhh0SPNy2yGI+zkeGkSdGa3FOq1dL2iH9rBENjF2WqwhU4qUZ5KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lncx3PmN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716496726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3bURABEmOAalVdlxFysDSM2l1qXw4LIKCEaoksTPA5Q=;
	b=Lncx3PmNGUWbq+razPhW//NnIeK6wF3QIkIJpvuN3KrDjqiNblleZQAEEHmtKl7KsbhhBk
	mhCT67EPr10lKdXohbQPQV9igd98+85nL/oQD84FKPMu5Q6MPTYvCBTM1uh1rqhmXW5FPL
	13QJCTKvZEUzck4Yp043FV6XCecXUd0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-ap1w04wQOyuF7EhufqC8dA-1; Thu, 23 May 2024 16:38:45 -0400
X-MC-Unique: ap1w04wQOyuF7EhufqC8dA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-354e0805ef3so1346846f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 13:38:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716496724; x=1717101524;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3bURABEmOAalVdlxFysDSM2l1qXw4LIKCEaoksTPA5Q=;
        b=uxzcserUA3GWcbGDSDQ+3oKhvLpSyOnXrlH+weWM/FoknSWcMwsQfkUYVO3TAifF13
         PS+y4V02BAYTCf5Q//E0WSLYwj7IuQBHaPAHzJm9ntvB6d6pyiAxzVt14jjVnOxgKXqz
         4WCpdW7oTNDGU2OtEqV5+pGi/5jM1Oft26TpWr3f5YwJKvV0zBRpHPaEtyvjr+XPbfN/
         ubLRkMftiBegrjsZ5AIFHOOBJ3k0SJBFz0kzyfbvjNAOZvTjXutPB46nfpIZAZfUWU1S
         MdAx66QOzb7uXrn5Y/yWXeUpxK5adut5waQZt+mefc1PFsfOUtoeejE7gxqDKG0GnFQW
         UGuQ==
X-Gm-Message-State: AOJu0YzFRgCqzRqDfPM3pCdWseBOsPG7mWLRHe2MhDvJHFsHpeBFdluL
	uPwsdE8acH40UkCNfufPcHw6qdZEiZftR52pPG8gdj8PBoTJrMLaAFQp1/6/0oSqD6CWDBu5khE
	cquF4knAz7c4MrEDCjZUk1xBOVeQgaLW18j3QK/ki4UtFZIhgaiLmWVROf7gjSSs2mz39Kr4Gx2
	gQuHvuaECm8g0i3PYiY+emMX4aXG4Wo7LYv0cQEyV4KQ==
X-Received: by 2002:a05:6000:1001:b0:354:fc89:5432 with SMTP id ffacd0b85a97d-355245df640mr106712f8f.5.1716496723892;
        Thu, 23 May 2024 13:38:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvxodiYwIWA1LEP9wnZBPIDknhssbMqh39LveZVoBNYPO9BTDMrR886EQdx++w7edejCYldA==
X-Received: by 2002:a05:6000:1001:b0:354:fc89:5432 with SMTP id ffacd0b85a97d-355245df640mr106692f8f.5.1716496723420;
        Thu, 23 May 2024 13:38:43 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:5f00:c949:6700:cce1:e60b? (p200300cbc7175f00c9496700cce1e60b.dip0.t-ipconnect.de. [2003:cb:c717:5f00:c949:6700:cce1:e60b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-354fa39314dsm2112045f8f.112.2024.05.23.13.38.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 13:38:42 -0700 (PDT)
Message-ID: <0d80abd4-fbce-4ac1-b088-ec15dee65a55@redhat.com>
Date: Thu, 23 May 2024 22:38:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/6] mm/zsmalloc: use a proper page type
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Mike Rapoport <rppt@kernel.org>, Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>
References: <20240522210341.1030552-1-david@redhat.com>
 <20240522210341.1030552-4-david@redhat.com>
 <2563ea6b-7c65-46a0-adf3-552f2e863c94@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <2563ea6b-7c65-46a0-adf3-552f2e863c94@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.05.24 16:55, David Hildenbrand wrote:
> On 22.05.24 23:03, David Hildenbrand wrote:
>> Let's clean it up: use a proper page type and store our data (offset
>> into a page) in the lower 16 bit as documented.
>>
>> We'll have to restrict ourselves to <= 64KB base page size (so the offset
>> fits into 16 bit), which sounds reasonable. Unfortunately, we don't have
>> any space to store it elsewhere for now.
>>
>> Based on this, we should do a proper "struct zsdesc" conversion, as
>> proposed in [1].
>>
>> This removes the last _mapcount/page_type offender.
>>
>> [1] https://lore.kernel.org/all/20231130101242.2590384-1-42.hyeyoo@gmail.com/
>>
>> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>    include/linux/page-flags.h |  3 +++
>>    mm/Kconfig                 |  1 +
>>    mm/zsmalloc.c              | 23 +++++++++++++++++++----
>>    3 files changed, 23 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>> index ed9ac4b5233d..ccaf16656de9 100644
>> --- a/include/linux/page-flags.h
>> +++ b/include/linux/page-flags.h
>> @@ -959,6 +959,7 @@ PAGEFLAG_FALSE(HasHWPoisoned, has_hwpoisoned)
>>    #define PG_guard	0x00080000
>>    #define PG_hugetlb	0x00100800
>>    #define PG_slab		0x00200000
>> +#define PG_zsmalloc	0x00400000
>>    
>>    #define PageType(page, flag)						\
>>    	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
>> @@ -1073,6 +1074,8 @@ FOLIO_TYPE_OPS(hugetlb, hugetlb)
>>    FOLIO_TEST_FLAG_FALSE(hugetlb)
>>    #endif
>>    
>> +PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
>> +
>>    /**
>>     * PageHuge - Determine if the page belongs to hugetlbfs
>>     * @page: The page to test.
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index b4cb45255a54..0371d79b1b75 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -190,6 +190,7 @@ config ZSMALLOC
>>    	tristate
>>    	prompt "N:1 compression allocator (zsmalloc)" if ZSWAP
>>    	depends on MMU
>> +	depends on PAGE_SIZE_LESS_THAN_256KB # we want <= 64KB
>>    	help
>>    	  zsmalloc is a slab-based memory allocator designed to store
>>    	  pages of various compression levels efficiently. It achieves
>> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
>> index b42d3545ca85..6f0032e06242 100644
>> --- a/mm/zsmalloc.c
>> +++ b/mm/zsmalloc.c
>> @@ -20,7 +20,8 @@
>>     *	page->index: links together all component pages of a zspage
>>     *		For the huge page, this is always 0, so we use this field
>>     *		to store handle.
>> - *	page->page_type: first object offset in a subpage of zspage
>> + *	page->page_type: PG_zsmalloc, lower 16 bit locate the first object
>> + *		offset in a subpage of a zspage
>>     *
>>     * Usage of struct page flags:
>>     *	PG_private: identifies the first component page
>> @@ -450,14 +451,22 @@ static inline struct page *get_first_page(struct zspage *zspage)
>>    	return first_page;
>>    }
>>    
>> +static inline void reset_first_obj_offset(struct page *page)
>> +{
>> +	page->page_type |= 0xffff;
>> +}
>> +
>>    static inline unsigned int get_first_obj_offset(struct page *page)
>>    {
>> -	return page->page_type;
>> +	return page->page_type & 0xffff;
>>    }
>>    
>>    static inline void set_first_obj_offset(struct page *page, unsigned int offset)
>>    {
>> -	page->page_type = offset;
>> +	BUILD_BUG_ON(PAGE_SIZE & ~0xffff);
> 
> Buildbot is correctly complaining with PAGE_SIZE=64KiB.
> 
> We must check BUILD_BUG_ON((PAGE_SIZE -1) & ~0xffff);

.. and I'll have to resolve the "select ZSMALLOC" situation. :)

-- 
Cheers,

David / dhildenb


