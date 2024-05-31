Return-Path: <linux-kernel+bounces-196835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B228D625A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 15:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC9FEB25A87
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 13:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA21815886E;
	Fri, 31 May 2024 13:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C+vq4C7Y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673411581FB
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 13:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717160751; cv=none; b=n64FhTnyVtra+OH7WabalasFRp0OYMbdCtZhF+fSHhTDsqDuxwgmVpTMW7eUGg03M/uKTkXreysojDaiMZkULfkDuk3JysEepWfHOXJHJCJ4zsPkRKlTk6kZqCGnCgvP0ijcll9Yp+iHQ+gsL+qYXeVksWxghH5OfWFl7DmTR5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717160751; c=relaxed/simple;
	bh=anptV1IFlCGdEypnDaHiVZxoXNrqlJIVQoFTA/Fc8O0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=h2weDJxsp9zCDlQoTalsu0J+QAUWVnb1dUUf6KwsiJyt75o4MOjBJ2cr7Clf98zOQCWtjCbDRgcRoLsyVGyUbLBmWCsuock5EPtjsUmbbzuo5OMwq4VeeMm6Te5DR9LRd0rxIJHD7VKpTqH+mQv8PEGzTtqfav/VwJc5ngRvaEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C+vq4C7Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717160748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eWPJprElNMXCXo9iDiQXBGc5GCfw1pS39+lgF8K2K38=;
	b=C+vq4C7Y0KR3k6cyTIjt4M7D5ZTyW711+03sMV4+2CIvccPu1hzIr1ykfyy20fhF3LFHfi
	7nxqwE1Remilo7JAwZNN8HLyF0uq8ht+jV5bv6GF0ltFupseGqtYHkqnF9qKK/CuGuv/BZ
	ui+e7aQQM0cB/ww70Ld97icKKrrRw8E=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-5xaB6eUEMIimkuiTT2PkIA-1; Fri, 31 May 2024 09:05:46 -0400
X-MC-Unique: 5xaB6eUEMIimkuiTT2PkIA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ea839a481bso15332191fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 06:05:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717160744; x=1717765544;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eWPJprElNMXCXo9iDiQXBGc5GCfw1pS39+lgF8K2K38=;
        b=invSfZP7xZVEnl9B3HtoVDtGvDNxu4aU8N8kL4A3xzC6pzKh6Slq/bNvMTUyMtsPqo
         cYk30WK2XM2LJKvkzV110XdpXNXMzParQtuDOTn61BLMdY5+/xNOZUgZPHUZK8iXhURb
         Reo2zyQfA6/l9lYWihGM/X3AEFoP9vm2pQHWq5bySKyr0BEN1wVC/P3SIJP7nEBbQqao
         S5OAd/rWMkN/rZf/i7DRFLcsoGtj+NuUXXw2RZ2ukOaLbkKpRZ37zSFFRDtSx/z2wK9L
         SOeoHWtQACMLKTqhmty/FTzneqI5yp+cLilxQJLrbJyR31uEbvQ57VIg/LGSjzmph8IL
         L4dQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDlZd5K03bHY/cV2/0HjpXM0vzLtE1GfshDPqZ+REjUl7MsqkbSEe/2nMgCdUrb04Z/dWsuwEnSNOxDb2st7kVy5Nsl2r9ZPlmVk9L
X-Gm-Message-State: AOJu0Yx7t130D0Nhbj7E+sQMAL6Jh0e7rgs452NZ0vfCMbTAZ+jFrSTe
	Z+wAF6BbfKJQUduGeYY3hem557TjPZsJGbaFbs0Z7ZA7iWF88FlxGcK4Cuxvdn6jd2JdmrgYoRp
	0khhwEXKmlFvJgCwMXTethRMOJiEjUIAWRctnF+Wl1hQsFnCj3s/E8W6qAujeVA==
X-Received: by 2002:a05:651c:1a12:b0:2e5:67bc:739 with SMTP id 38308e7fff4ca-2ea950b55b0mr16523361fa.2.1717160744643;
        Fri, 31 May 2024 06:05:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHN7764g19nHVJQIhrnIPAoZI4/o58tCleNGHZw+vpvy2hTCND3S/CXd5/Pgm1sbitKw9cz8w==
X-Received: by 2002:a05:651c:1a12:b0:2e5:67bc:739 with SMTP id 38308e7fff4ca-2ea950b55b0mr16523081fa.2.1717160744085;
        Fri, 31 May 2024 06:05:44 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:a000:d4df:4b8f:37d4:59e4? (p200300cbc717a000d4df4b8f37d459e4.dip0.t-ipconnect.de. [2003:cb:c717:a000:d4df:4b8f:37d4:59e4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04cad2csm1850133f8f.36.2024.05.31.06.05.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 06:05:43 -0700 (PDT)
Message-ID: <dec62086-8170-4fea-987a-9cc514cc4b27@redhat.com>
Date: Fri, 31 May 2024 15:05:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/hugetlb: mm/memory_hotplug: use a folio in
 scan_movable_pages()
From: David Hildenbrand <david@redhat.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, vishal.moola@oracle.com,
 muchun.song@linux.dev, osalvador@suse.de, willy@infradead.org
References: <20240530171427.242018-1-sidhartha.kumar@oracle.com>
 <fe37643c-93a0-4220-b547-a5cae36b3231@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <fe37643c-93a0-4220-b547-a5cae36b3231@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.05.24 15:04, David Hildenbrand wrote:
> On 30.05.24 19:14, Sidhartha Kumar wrote:
>> By using a folio in scan_movable_pages() we convert the last user of the
>> page-based hugetlb information macro functions to the folio version.
>> After this conversion, we can safely remove the page-based definitions
>> from include/linux/hugetlb.h.
>>
>> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>> ---
>>
>> v1 -> v2:
>> 	simplify pfn skipping logic with pfn |= folio_nr_pages(folio) - 1
>> 	per Matthew
>>
>>    include/linux/hugetlb.h |  6 +-----
>>    mm/memory_hotplug.c     | 11 +++++------
>>    2 files changed, 6 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>> index 15a58f69782c..279aca379b95 100644
>> --- a/include/linux/hugetlb.h
>> +++ b/include/linux/hugetlb.h
>> @@ -616,9 +616,7 @@ static __always_inline						\
>>    bool folio_test_hugetlb_##flname(struct folio *folio)		\
>>    	{	void *private = &folio->private;		\
>>    		return test_bit(HPG_##flname, private);		\
>> -	}							\
>> -static inline int HPage##uname(struct page *page)		\
>> -	{ return test_bit(HPG_##flname, &(page->private)); }
>> +	}
>>    
>>    #define SETHPAGEFLAG(uname, flname)				\
>>    static __always_inline						\
>> @@ -637,8 +635,6 @@ void folio_clear_hugetlb_##flname(struct folio *folio)		\
>>    #define TESTHPAGEFLAG(uname, flname)				\
>>    static inline bool						\
>>    folio_test_hugetlb_##flname(struct folio *folio)		\
>> -	{ return 0; }						\
>> -static inline int HPage##uname(struct page *page)		\
>>    	{ return 0; }
>>    
>>    #define SETHPAGEFLAG(uname, flname)				\
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index 431b1f6753c0..9c36eb3bbd3b 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -1731,8 +1731,8 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
>>    	unsigned long pfn;
>>    
>>    	for (pfn = start; pfn < end; pfn++) {
>> -		struct page *page, *head;
>> -		unsigned long skip;
>> +		struct page *page;
>> +		struct folio *folio;
>>    
>>    		if (!pfn_valid(pfn))
>>    			continue;
>> @@ -1753,7 +1753,7 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
>>    
>>    		if (!PageHuge(page))
>>    			continue;
>> -		head = compound_head(page);
>> +		folio = page_folio(page);
>>    		/*
>>    		 * This test is racy as we hold no reference or lock.  The
>>    		 * hugetlb page could have been free'ed and head is no longer
>> @@ -1761,10 +1761,9 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
>>    		 * cases false positives and negatives are possible.  Calling
>>    		 * code must deal with these scenarios.
>>    		 */
>> -		if (HPageMigratable(head))
>> +		if (folio_test_hugetlb_migratable(folio))
>>    			goto found;
>> -		skip = compound_nr(head) - (pfn - page_to_pfn(head));
>> -		pfn += skip - 1;
>> +		pfn |= folio_nr_pages(folio) - 1;
> 
> Likely not exactly what we want?
> 
> pfn |= folio_nr_pages(folio);
> 
> Would make sure that we are "one PFN before the start of the next
> folio". The pfn++ before the next loop iteration would move us to the
> next folio.
> 
> Or am I missing something?

Okay, I got it wrong.

"folio_nr_pages(folio) - 1" gives us the bitmask to land one PFN before 
the end.

Acked-by: David Hildenbrand <david@redhat.com>

> 
> It might be cleaner if we would handle the "pfn++;" on the "continue;"
> paths inmstead, and simply here do something like
> 
> 	pfn = ALIGN(pfn + 1, folio_nr_pages(folio));
> 
> instead.
> 

-- 
Cheers,

David / dhildenb


