Return-Path: <linux-kernel+bounces-172790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAB28BF6CF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C61F284D59
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 07:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC0D2745E;
	Wed,  8 May 2024 07:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dsF6p49y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B6F24B21
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 07:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715152537; cv=none; b=SMpIdcaDWdkuRj+sXuf6TS5LXZBC+AuGpe0klQEfkSgAvApSWFkXFmG45XZgloM1z1vBboavyfQTf49C8fE085ECFpgnxt3p40PmKNmdLlXYL/r2buPraIh11uSZeNf7ri693dkY3XetfOed4CPNYo9RuUfgdKm3o7UeoJgcG0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715152537; c=relaxed/simple;
	bh=B59dVRFSR5OMyqXfGLn8y5G5pzyRkE8j02yTnQ2XDbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=doVxw6z4/nvsgigMaoey4Yna35zH4cVvA5eHh5D2vMMpV/KNfp1w4BZ8x+xfSGEjzDCU6SmRiDHiZsWAOe23NenN+lngpyE+8SCTyno2NwMiWprqtH0+BcZUoqLR3XDVcptuOqmqqRQ08FlHB5M7YXn9vYFxK9Vp8PVXoPlt5BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dsF6p49y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715152534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Z5W9Lt98hH1YzpgkYS9g3Dx1MjdAqD8+7OlmZIqsqsk=;
	b=dsF6p49yJnOvnz7MeZW6nQnXsCZojlhRxnagOYd5SLBNSu/1IpKHnN3Fzx7fuV6hXNhGAt
	TR0RzdDCy7aksok/Zjmvd1tRd6TN9Yq2l+8IjRPmcLi4G/muzQRQ50Q5P3pEXfRMtHeSg/
	6dEuWimt84eGaaE40Wdd6foio39whpc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-TJbs7qN7NIyd2TsB8wkXrA-1; Wed, 08 May 2024 03:15:32 -0400
X-MC-Unique: TJbs7qN7NIyd2TsB8wkXrA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-34d9055c7e0so2711993f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 00:15:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715152531; x=1715757331;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z5W9Lt98hH1YzpgkYS9g3Dx1MjdAqD8+7OlmZIqsqsk=;
        b=m8oqk7jwKbxl8CtoA7HYnZiq8LNnw8qWOBY2Cblc6165j1YSbjazL2wF8CcoJuzoL4
         vl4Pl7mMzMq8gI6k98IqoF1T1RogaHaEzofMArgvmGZTToQUCPHvrobELGwoIhztL50Q
         OCZcLYJ8Tz6uFLD1OBbw1OcfhTfswaXjZsHqK6EWI2sv1roMZEH1V1dy79+fFC+o67p8
         aiJYYWWeoSweQf2paT6tdO61MJT2tTiArG7UvhiNbqyVxzWdzWODyHbT9wCNzHNsIO7k
         pma4MPe/wzLN5mSk7sWnK6hlB+EyfNrsQV69W6753mjXov6c9DBHhkOrfOXqcCbTf/c2
         JrHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJSZ/WkOyZJBmHcGdJ+En0JYjdk/tCIdkGzX0DVi5yvud4Bl2avKTic91SbhS2lqbLxqQr59p4zUM38PPLQlJ/bO6C5aE60ZJKu+cN
X-Gm-Message-State: AOJu0Yyf7Ct4oKCH3KmpfXdaRwAvXgzpEktovJnqkXaAfs06T/P1F/Q+
	w9F7A3jQazTYKnfiqIpbppyWdLXu4rFeV3ZfRi21vACxXoSHjsNruskpgJzNJ/94E3f/Zl747nw
	xtkYHPPcA1htUjtWIP6hH0tiTW3+zDVtSe5pdtRQuvPoPrKLPj60VNXfWSVuHIg==
X-Received: by 2002:adf:f203:0:b0:34a:e69b:494e with SMTP id ffacd0b85a97d-34fca24390bmr1349796f8f.23.1715152531207;
        Wed, 08 May 2024 00:15:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4qP2iWJmu0kNqwqkhtZ+two4niS8vuexmaqry4Yd7PgLGyZ17uvjaZ5cjD6/dXQvUy8shTQ==
X-Received: by 2002:adf:f203:0:b0:34a:e69b:494e with SMTP id ffacd0b85a97d-34fca24390bmr1349774f8f.23.1715152530767;
        Wed, 08 May 2024 00:15:30 -0700 (PDT)
Received: from [192.168.3.108] (p5b0c6bc3.dip0.t-ipconnect.de. [91.12.107.195])
        by smtp.gmail.com with ESMTPSA id o10-20020a5d47ca000000b0034d9e5411ebsm14666395wrc.45.2024.05.08.00.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 00:15:30 -0700 (PDT)
Message-ID: <5564e708-4a9f-4010-806e-4c5a7a5d2ebe@redhat.com>
Date: Wed, 8 May 2024 09:15:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] mm: memory: extend finish_fault() to support large
 folio
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, ioworker0@gmail.com, wangkefeng.wang@huawei.com,
 ying.huang@intel.com, 21cnbao@gmail.com, shy828301@gmail.com,
 ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1714978902.git.baolin.wang@linux.alibaba.com>
 <e3f4ae78ef2d565a65fadaa843e53a24bf5b57e4.1714978902.git.baolin.wang@linux.alibaba.com>
 <13939ade-a99a-4075-8a26-9be7576b7e03@arm.com>
 <d2bd3277-7ef5-4909-a149-6895ad95459e@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <d2bd3277-7ef5-4909-a149-6895ad95459e@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.05.24 05:44, Baolin Wang wrote:
> 
> 
> On 2024/5/7 18:37, Ryan Roberts wrote:
>> On 06/05/2024 09:46, Baolin Wang wrote:
>>> Add large folio mapping establishment support for finish_fault() as a preparation,
>>> to support multi-size THP allocation of anonymous shmem pages in the following
>>> patches.
>>>
>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> ---
>>>    mm/memory.c | 43 +++++++++++++++++++++++++++++++++----------
>>>    1 file changed, 33 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index eea6e4984eae..936377220b77 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -4747,9 +4747,12 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>>>    {
>>>    	struct vm_area_struct *vma = vmf->vma;
>>>    	struct page *page;
>>> +	struct folio *folio;
>>>    	vm_fault_t ret;
>>>    	bool is_cow = (vmf->flags & FAULT_FLAG_WRITE) &&
>>>    		      !(vma->vm_flags & VM_SHARED);
>>> +	int type, nr_pages, i;
>>> +	unsigned long addr = vmf->address;
>>>    
>>>    	/* Did we COW the page? */
>>>    	if (is_cow)
>>> @@ -4780,24 +4783,44 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>>>    			return VM_FAULT_OOM;
>>>    	}
>>>    
>>> +	folio = page_folio(page);
>>> +	nr_pages = folio_nr_pages(folio);
>>> +
>>> +	if (unlikely(userfaultfd_armed(vma))) {
>>> +		nr_pages = 1;
>>> +	} else if (nr_pages > 1) {
>>> +		unsigned long start = ALIGN_DOWN(vmf->address, nr_pages * PAGE_SIZE);
>>> +		unsigned long end = start + nr_pages * PAGE_SIZE;
>>> +
>>> +		/* In case the folio size in page cache beyond the VMA limits. */
>>> +		addr = max(start, vma->vm_start);
>>> +		nr_pages = (min(end, vma->vm_end) - addr) >> PAGE_SHIFT;
>>> +
>>> +		page = folio_page(folio, (addr - start) >> PAGE_SHIFT);
>>
>> I still don't really follow the logic in this else if block. Isn't it possible
>> that finish_fault() gets called with a page from a folio that isn't aligned with
>> vmf->address?
>>
>> For example, let's say we have a file who's size is 64K and which is cached in a
>> single large folio in the page cache. But the file is mapped into a process at
>> VA 16K to 80K. Let's say we fault on the first page (VA=16K). You will calculate
> 
> For shmem, this doesn't happen because the VA is aligned with the
> hugepage size in the shmem_get_unmapped_area() function. See patch 7.

Does that cover mremap() and MAP_FIXED as well.

We should try doing this as cleanly as possible, to prepare for the 
future / corner cases.

-- 
Cheers,

David / dhildenb


