Return-Path: <linux-kernel+bounces-518924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE522A39620
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E8481886648
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4882022DF8D;
	Tue, 18 Feb 2025 08:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GHXFY5AC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0871E25F7
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 08:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739868766; cv=none; b=SbNU+O1rwboOV6ClUxBVTJPhdOa9Pe/4AsLqB8eG2AgFlxaHDm/xgPW19UhtJ3Ll8OVXpBF2p0MHfh49rpcfNhrvPyUlgE5WZ3ckB6ctTIakLvvMXVAUl0GD8wyPdEBORU7KuEWRGEn1WJ8jnTDOfxZW0CQLEC13VTE0aywoyXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739868766; c=relaxed/simple;
	bh=G+b3AMl/lwxCw6Eepo0DQA+66LF2t2+m7h9xHzR283o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f4DfSbG7Rg/NkE3+fXoLX3kkWl8i3s9SVWg5buvhsuadNtOWjiQQrXl2fL6iIwIa7vDIwG89inbBlTPIVGLVKsfcSnnSXdEeBVticrVp16jUidrMpQx2WnKEKH0ufuh30pCr7JHITUoZZiHd0k19dW6d76sq+HduDCLivjtqSvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GHXFY5AC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739868763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2frebQnqMc6hxQDPqDsXQU7D0udfRwHJSyhka35xuOo=;
	b=GHXFY5ACbmWyVNqv1YQZOwm2ytnudW/kjr9/9agGcBSygodK3nM1yQtlyXw9O+Mb+RwdO/
	90A2PH6wCV2cLFj9zhdojbGt0u0rgRV/eso8Zopsg54WOaKV4aFRynWesq9LH0mJ9ciWDc
	Vg6ZywKeOSNCmeW/itV1dLV54BeRmL8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-palemZA8MZGMHh1PCi0dIw-1; Tue, 18 Feb 2025 03:52:40 -0500
X-MC-Unique: palemZA8MZGMHh1PCi0dIw-1
X-Mimecast-MFC-AGG-ID: palemZA8MZGMHh1PCi0dIw_1739868759
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-438da39bb69so46214825e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 00:52:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739868759; x=1740473559;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2frebQnqMc6hxQDPqDsXQU7D0udfRwHJSyhka35xuOo=;
        b=L2GphoHeB9LqvXn6sLHRMcEtDVcoILWUQ6EnvB66GS/T+f2UZjXKJx+tWekQBVkBZE
         svNd4lJQBP74St7QDtTXJGMq42sE+ER3j+G78qtMlwteK6UvaMgJy7OUEjUgRGzeqHSk
         NTg8NL5LabQznuJy2br4BQsSQ7NWfrODuhUJQT8GWo77ZYGMHcxuvx6tivuxJnN06ey5
         0XlMnq9+zw6/7CPG3dxS0CcsAeUWVNFIjtzIO8EVgjuo+WDtpB35FhxqGE1fVPFb10gu
         FRbVMO8YbULFJtbuB55F0OZAjbnLQBYCdos4HX48rAojNe0I/+sQk5Il8y3Zhm47VfHh
         momg==
X-Forwarded-Encrypted: i=1; AJvYcCXuUXtzOF2lPTXUx9QmY0YCEoVOuFpVPQsy02WPoloahQFSJ7bTPHpm7MwXnE9zvtsEpmaAP2TtjJ+cKPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJqMKytNSbw34FHQr9clnCYCdUmIrq8BicUUQZy9dULUdBcPHa
	2p+lusb8oABNdzqmNKE8iwqCQofrne4Otw253v2j2csUcfQIfGu7x+xS2y/5IDwoGM1A3/I3bx5
	02VopXbnTM4GqNkwimE6SHeXKSTQ+9XAfV5BtHgX0WdWLHz3H2hqt8hw8H0vCxHzShdm2Oend
X-Gm-Gg: ASbGncuO8Y/DoUjk2S5jGaC1DAQvBp+m6wYO2nfDRNWeg6tcsqymCbLns/rZA60i04M
	QQTNB7PGtgGzoZbQeyuQ4XFFfzPXYkzf1NfmlOviyLZRAaFvd1hDqFHKnCFx8DiqS78CaW+h3/8
	Kfpr2XEM0+X0nL7fQ7XF1Zc1Ho9gQTEv/yf6BXCQI3XR0VS4SnD2VJ63Jx7zxd9R86gxckW4XM4
	zT8kaVqzsQkMWKBfPTfKwJtNVl8CADJw104CAA9gy0zKt62GQ/0E9OsL/65bs8IBxDQ6PuE4A4h
	i5Sil6oF8FaVV1bXCL299ehOPnzRmYtpNFuk4k5tMU63cMew2QxW2OtpwD4hcUHwPi3hVzlk8cR
	4xy6E6wOfSR3lTBEuItQnzAHX+7KeRTxl
X-Received: by 2002:a05:600c:1c26:b0:439:6332:2780 with SMTP id 5b1f17b1804b1-4396e71af3emr107752895e9.27.1739868758909;
        Tue, 18 Feb 2025 00:52:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoPPOB3fuMKZXw4GrJyQvgTZAlqeWM8yMEKhdoCWszKpanye4Hc0odm6s5bCjp2xQD6AncbQ==
X-Received: by 2002:a05:600c:1c26:b0:439:6332:2780 with SMTP id 5b1f17b1804b1-4396e71af3emr107752635e9.27.1739868758450;
        Tue, 18 Feb 2025 00:52:38 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af? (p200300cbc70dfb00d3ed5f441b2d12af.dip0.t-ipconnect.de. [2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43993847f39sm13967905e9.14.2025.02.18.00.52.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 00:52:37 -0800 (PST)
Message-ID: <4195424c-3147-402f-bb73-4f7b96f6a9bf@redhat.com>
Date: Tue, 18 Feb 2025 09:52:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] mm/hugetlb: wait for hugepage folios to be freed
To: Muchun Song <muchun.song@linux.dev>, yangge1116@126.com
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, 21cnbao@gmail.com,
 baolin.wang@linux.alibaba.com, osalvador@suse.de, liuzixing@hygon.cn
References: <1739604026-2258-1-git-send-email-yangge1116@126.com>
 <574F9D6A-F370-4A8C-9044-BC0A6189F055@linux.dev>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <574F9D6A-F370-4A8C-9044-BC0A6189F055@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18.02.25 07:52, Muchun Song wrote:
> 
> 
>> On Feb 15, 2025, at 15:20, yangge1116@126.com wrote:
>>
>> ﻿From: Ge Yang <yangge1116@126.com>
>>
>> Since the introduction of commit b65d4adbc0f0 ("mm: hugetlb: defer freeing
>> of HugeTLB pages"), which supports deferring the freeing of HugeTLB pages,
>> the allocation of contiguous memory through cma_alloc() may fail
>> probabilistically.
>>
>> In the CMA allocation process, if it is found that the CMA area is 
>> occupied
>> by in-use hugepage folios, these in-use hugepage folios need to be 
>> migrated
>> to another location. When there are no available hugepage folios in the
>> free HugeTLB pool during the migration of in-use HugeTLB pages, new folios
>> are allocated from the buddy system. A temporary state is set on the newly
>> allocated folio. Upon completion of the hugepage folio migration, the
>> temporary state is transferred from the new folios to the old folios.
>> Normally, when the old folios with the temporary state are freed, it is
>> directly released back to the buddy system. However, due to the deferred
>> freeing of HugeTLB pages, the PageBuddy() check fails, ultimately leading
>> to the failure of cma_alloc().
>>
>> Here is a simplified call trace illustrating the process:
>> cma_alloc()
>>    ->__alloc_contig_migrate_range() // Migrate in-use hugepage
>>        ->unmap_and_move_huge_page()
>>            ->folio_putback_hugetlb() // Free old folios
>>    ->test_pages_isolated()
>>        ->__test_page_isolated_in_pageblock()
>>             ->PageBuddy(page) // Check if the page is in buddy
>>
>> To resolve this issue, we have implemented a function named
>> wait_for_hugepage_folios_freed(). This function ensures that the hugepage
>> folios are properly released back to the buddy system after their 
>> migration
>> is completed. By invoking wait_for_hugepage_folios_freed() before calling
>> PageBuddy(), we ensure that PageBuddy() will succeed.
>>
>> Fixes: b65d4adbc0f0 ("mm: hugetlb: defer freeing of HugeTLB pages")
>> Signed-off-by: Ge Yang <yangge1116@126.com>
>> ---
>>
>> V2:
>> - flush all folios at once suggested by David
>>
>> include/linux/hugetlb.h |  5 +++++
>> mm/hugetlb.c            |  8 ++++++++
>> mm/page_isolation.c     | 10 ++++++++++
>> 3 files changed, 23 insertions(+)
>>
>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>> index 6c6546b..04708b0 100644
>> --- a/include/linux/hugetlb.h
>> +++ b/include/linux/hugetlb.h
>> @@ -697,6 +697,7 @@ bool hugetlb_bootmem_page_zones_valid(int nid, 
>> struct huge_bootmem_page *m);
>>
>> int isolate_or_dissolve_huge_page(struct page *page, struct list_head 
>> *list);
>> int replace_free_hugepage_folios(unsigned long start_pfn, unsigned 
>> long end_pfn);
>> +void wait_for_hugepage_folios_freed(void);
>> struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>>                unsigned long addr, bool cow_from_owner);
>> struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int 
>> preferred_nid,
>> @@ -1092,6 +1093,10 @@ static inline int 
>> replace_free_hugepage_folios(unsigned long start_pfn,
>>    return 0;
>> }
>>
>> +static inline void wait_for_hugepage_folios_freed(void)
>> +{
>> +}
>> +
>> static inline struct folio *alloc_hugetlb_folio(struct vm_area_struct 
>> *vma,
>>                       unsigned long addr,
>>                       bool cow_from_owner)
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 30bc34d..36dd3e4 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -2955,6 +2955,14 @@ int replace_free_hugepage_folios(unsigned long 
>> start_pfn, unsigned long end_pfn)
>>    return ret;
>> }
>>
>> +void wait_for_hugepage_folios_freed(void)
> 
> We usually use the "hugetlb" term now instead of "huge_page" to 
> differentiate with THP. So I suggest naming it as 
> wait_for_hugetlb_folios_freed().

Maybe "wait_for_freed_hugetlb_folios" or "hugetlb_wait_for_freed_folios".

In general, LGTM

-- 
Cheers,

David / dhildenb


