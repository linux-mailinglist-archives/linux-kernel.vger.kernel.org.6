Return-Path: <linux-kernel+bounces-212103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA76905B3F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D197128BF8A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82354CB23;
	Wed, 12 Jun 2024 18:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ik+gRK9+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7975157CAE
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 18:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718217714; cv=none; b=lG3Lw+VS7A14RfYIlvZbb5z9OqEZxH/dfcf/R6E4xQVDlubLgwV5e/A3uUS9W7J7fQ7NpFLeOyNG9AMcFYp8PKWuLG06j55MX1f0RIILQwDKs0jG9SLPkDL0q+SVqMa/HRo7J0oJlznmclZOfi26gHVAMh+kfchfci4+PLumvM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718217714; c=relaxed/simple;
	bh=rT+bqSpH7aCiW6fjAQaFhgE+DvgQnZRBKK3VlRk16BQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=asjBcX0QY/8KZK0ITMs/v5qAV4CRNkgm/6s/x9ZJfB92/WV16ynCEPrWaX7tjIfXenGro9OqyLkcuNoCkiA7uUnjIKuQaMWapW5N5/LXO3XiaJQRlKSVzcfNqMagNmbJs5Yc48Izrv3B/mdagSAjd/ngdu6ZoNi3JN9oDMzZSQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ik+gRK9+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718217711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Tt5ThilReFbEyA5Et8oCAm3CfkmDTGwtO66aN/4s1zQ=;
	b=ik+gRK9+lo2pNKcDKu2sacnOLQP9rygG9aJhyDrhyc7ddWQmNQ8Yvzr4YTwxL2yVpIRYvm
	GAflikoOxF1HnL4EFauGDD03ShITGSisUUXF2NLku58HdOQ1rMVgtORg2aIX1DZTvtTCsC
	4ZHjczBWzHMK7nKst8VYLfKEKG4LzvI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-Q15qK4AuPKGtfiAWJln0aA-1; Wed, 12 Jun 2024 14:41:49 -0400
X-MC-Unique: Q15qK4AuPKGtfiAWJln0aA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42153125d3eso1241185e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 11:41:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718217708; x=1718822508;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Tt5ThilReFbEyA5Et8oCAm3CfkmDTGwtO66aN/4s1zQ=;
        b=QwrquD/nigpY272SrK8HMFJ1WYgmYmpwjkwF9rokRisxXIv8VTXGJEwJsLfT9iOCRl
         JzndgXF2BZW6cuh+NXrNcM3o91yE2oyu/LlnNJdK+E1yvIJov5f1McNN4BLkwUSIsC0k
         UJhBIMjQ4SEJi3GRuq6pW2TnHz7RCQHZSUy7ZGHpMa6pXVH2w80gry6a+niNAWfNQfvQ
         1WD/tl0NaG21TqTh5+TMhzFF+M1JbqaePHSNqpihYvZTQhHIBFenYRdzsyNdSzASfExV
         VKUv/w7/BamItelroNC3CQAWQPLXmX4VRuV2qLbxrQbcDKHrjFHnbifV/HchNGCeCDCH
         jIsg==
X-Forwarded-Encrypted: i=1; AJvYcCU8sE5tgbSNj0p+Mp884EzRgs4utLFkXuimGIzOlSlwn5ma9t5LOs75GKmf8EF8bIO5be90M7ay6vM4bDZAsAQEI/JRsZPYZpIZop/0
X-Gm-Message-State: AOJu0Yx7k+IjiUutuMFtNw9a0CJI/S4s2hNSutQga+SueUxBzT/rN+Ti
	oJTWlPHWiak4ZYazucWjcsJcenwZHlFU6dtwWUb7P+IxGTNyrBM1mL8xy8DQSQPfUzeohFntO0t
	q+/Y87VjZAMZzxhLkVszQuIKUyj92J/eQQ8a0ZHNA6frawvulMO2QDCsUzIRqMQ==
X-Received: by 2002:a05:600c:2154:b0:421:7cab:3b16 with SMTP id 5b1f17b1804b1-422863ae810mr18582835e9.23.1718217708680;
        Wed, 12 Jun 2024 11:41:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhbzqHIldrlKoQ5aUT9R7op4I+kGF9D3ZZspkrOmzP25Ia0brJwFTBQwPEzsNvUMK10MVEsw==
X-Received: by 2002:a05:600c:2154:b0:421:7cab:3b16 with SMTP id 5b1f17b1804b1-422863ae810mr18582705e9.23.1718217708262;
        Wed, 12 Jun 2024 11:41:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:bf00:abf6:cc3a:24d6:fa55? (p200300cbc702bf00abf6cc3a24d6fa55.dip0.t-ipconnect.de. [2003:cb:c702:bf00:abf6:cc3a:24d6:fa55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422871f8dcdsm35010835e9.40.2024.06.12.11.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 11:41:47 -0700 (PDT)
Message-ID: <9419ce11-08b5-4f80-9dc6-8551a7b8daea@redhat.com>
Date: Wed, 12 Jun 2024 20:41:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/memory: Don't require head page for do_set_pmd()
To: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>,
 Andrew Bresticker <abrestic@rivosinc.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240611153216.2794513-1-abrestic@rivosinc.com>
 <8040793f-e9e9-4a2e-807c-afcb310a48f5@redhat.com>
 <20240611110622.8e9892e92618ddc36bca11b7@linux-foundation.org>
 <ZmiVy8iE93HGkBWv@casper.infradead.org>
 <20240611130729.d53cbcd1767f917b47540cca@linux-foundation.org>
 <1786b46a-ab24-6032-6a60-93b3e3870c7c@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1786b46a-ab24-6032-6a60-93b3e3870c7c@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.06.24 23:18, Hugh Dickins wrote:
> On Tue, 11 Jun 2024, Andrew Morton wrote:
>> On Tue, 11 Jun 2024 19:22:03 +0100 Matthew Wilcox <willy@infradead.org> wrote:
>>> On Tue, Jun 11, 2024 at 11:06:22AM -0700, Andrew Morton wrote:
>>>> On Tue, 11 Jun 2024 17:33:17 +0200 David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>>> On 11.06.24 17:32, Andrew Bresticker wrote:
>>>>>> The requirement that the head page be passed to do_set_pmd() was added
>>>>>> in commit ef37b2ea08ac ("mm/memory: page_add_file_rmap() ->
>>>>>> folio_add_file_rmap_[pte|pmd]()") and prevents pmd-mapping in the
>>>>>> finish_fault() and filemap_map_pages() paths if the page to be inserted
>>>>>> is anything but the head page for an otherwise suitable vma and pmd-sized
>>>>>> page.
>>>>>>
>>>>>> Fixes: ef37b2ea08ac ("mm/memory: page_add_file_rmap() -> folio_add_file_rmap_[pte|pmd]()")
>>>>>> Signed-off-by: Andrew Bresticker <abrestic@rivosinc.com>
>>>>>> ---
>>>>>>    mm/memory.c | 3 ++-
>>>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>>> index 0f47a533014e..a1fce5ddacb3 100644
>>>>>> --- a/mm/memory.c
>>>>>> +++ b/mm/memory.c
>>>>>> @@ -4614,8 +4614,9 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
>>>>>>    	if (!thp_vma_suitable_order(vma, haddr, PMD_ORDER))
>>>>>>    		return ret;
>>>>>>    
>>>>>> -	if (page != &folio->page || folio_order(folio) != HPAGE_PMD_ORDER)
>>>>>> +	if (folio_order(folio) != HPAGE_PMD_ORDER)
>>>>>>    		return ret;
>>>>>> +	page = &folio->page;
>>>>>>    
>>>>>>    	/*
>>>>>>    	 * Just backoff if any subpage of a THP is corrupted otherwise
>>>>>
>>>>> Acked-by: David Hildenbrand <david@redhat.com>
> 
> Acked-by: Hugh Dickins <hughd@google.com>
> 
>>>>
>>>> You know what I'm going to ask ;) I'm assuming that the runtime effects
>>>> are "small performance optimization" and that "should we backport the
>>>> fix" is "no".
>>>
>>> We're going to stop using PMDs to map large folios unless the fault is
>>> within the first 4KiB of the PMD.  No idea how many workloads that
>>> affects, but it only needs to be backported as far as v6.8, so we
>>> may as well backport it.
>>
>> OK, thanks, I pasted the above text and added the cc:stable.
> 
> Yes please. My interest in this being that yesterday I discovered
> the large drop in ShmemPmdMapped between v6.7 and v6.8, bisected,
> and was testing overnight with a patch very much like this one of
> Andrew's. I'd been hoping to send mine today, but now no need.
> 
>>
>> I didn't move it into the hotfixes queue - it's a non-trivial
>> behavioral change and extra test time seems prudent(?).
> 
> It is certainly worth some test soak time, and the bug might have
> been masking other issues which may now emerge; but the fix is
> just reverting to the old pre-v6.8 behaviour.

Right, I don't expect surprises, really. I'm rather surprised that 
nobody noticed and that the usual 0-day benchmarks don't trigger that case.

-- 
Cheers,

David / dhildenb


