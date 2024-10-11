Return-Path: <linux-kernel+bounces-361046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CFD99A2BF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B8C21F24CA8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 11:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C40321732C;
	Fri, 11 Oct 2024 11:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eKzyMlNL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3DA216A02
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 11:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728646398; cv=none; b=b/UeZNax+kDscZWKnYiw1bCt3YeJDK5VVX/r2QB74fcYs8Gjj/v0ZFLt/Tg7s878B6/FugRg3knkQ6vQjQPGy29Frbcc5N7PQ7Umk4Dyg1jCHwB1MGJm5O1fHAi+AlIaeFZ/TWeVthPP6io0wx5nYWnW2zTrcGlgT8nQsyE2iXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728646398; c=relaxed/simple;
	bh=0NH7Tp0JLf7v6Fk3IGPBWBxxxGlU4lP5FkUQ0PzkAWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KXWttFNMYoI0P49woqXf6Z5TjRx2IOwddtB7bpSjUKXvNh9CetM8KKoxAg77ot/IvCaJjRi7kPOtkuuq6D5yYcq0nDRYhvtSCIXr8quHMEzVvVydmkzY49MmX8s19JCR5N/JTWNWaa+rrxy71xeXMYkqcTtg6tDxO0E8YkdDhUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eKzyMlNL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728646396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Aqbzb2c5WWVPDUb5fQ29KQ0F4f+JQrPIhyMo9Cv4DN4=;
	b=eKzyMlNLJOVLGtRhrLAkwnGYF/+0FCBE0TUjsTz/HFsLP503fuRcrtzaRptAVWNOJ7m9sK
	Qu26N5TQAXsJ9YRwInnrQt5xr3HMgp/excdqhISZD/T206ngPQnJGh9yX9iWGEXd1sPI50
	FAnAbb2tflOErZLW/ZBjiCL1qwn/1cw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-MkeQocM0NjeVh70auNB1dw-1; Fri, 11 Oct 2024 07:33:15 -0400
X-MC-Unique: MkeQocM0NjeVh70auNB1dw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d49887a2cso1075481f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 04:33:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728646394; x=1729251194;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Aqbzb2c5WWVPDUb5fQ29KQ0F4f+JQrPIhyMo9Cv4DN4=;
        b=EIKdqH3txPyjETcYm0Do3Fp68Oui/gFT1QfcCcKboKhBZqbpTD7Ftb5YfsbsmO43kg
         ZBNn1ZJmhQGLr8WtsDCGN5sox2oD1EXLo6NwhtkyHqy6gCdP5Hnn0bmtSgmYFIkfNZI+
         EFbw0MlP3YzPkzAPRcFJiIBKeGWSAHLfW01FiKEQTZQ5qHEH/pvdvUvJRrWZxt2tQsTT
         7Chs8oxFE7+N3WQDDBz0HcYNHKioLw8/r8UGa5iNAjwF00yJgA5lgFDAL/IP7ovPM3zv
         hPl+mgnG/uQsH2B/qn91g7GFUS/oZmiSxQf2dhz9UJh646apXpRzjdEvX5mPyc9qGiJl
         Wsmg==
X-Forwarded-Encrypted: i=1; AJvYcCUKTLytfkidBvKv7c5O/b9javTdOGxHEHo+f4faWCIFCTOkLZQ2pnWcH8FlIYrz/1o2deotnyNAFX9VbA8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/VI4WOVU/dUZ0Ew0DXCYRvhoND/cOAfzRcffL+aDgNK2NbW2I
	KL+r1WfmWItJ0Ltk1rAaNnTboa/zdb+ERh5mU+S3Xl1Gwo86NZwFH21WrfejJOMivSSzlBWU5ty
	b8EN5UeRByQ+m07my42boBJt+gbBMOTV5nxhIqFVIUThbBwFJrZ8t0EoSooC1rg==
X-Received: by 2002:a5d:5f4b:0:b0:37d:47b5:ba45 with SMTP id ffacd0b85a97d-37d5519b9b3mr2421154f8f.7.1728646394007;
        Fri, 11 Oct 2024 04:33:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJ6KFxMKU+6yFmlWe0ER7O25G0tSntOVOggFqoLe0XpO04At6W9SVcPX121/vjZqcKdziMjA==
X-Received: by 2002:a5d:5f4b:0:b0:37d:47b5:ba45 with SMTP id ffacd0b85a97d-37d5519b9b3mr2421117f8f.7.1728646393620;
        Fri, 11 Oct 2024 04:33:13 -0700 (PDT)
Received: from ?IPV6:2003:cb:c749:9100:c078:eec6:f2f4:dd3b? (p200300cbc7499100c078eec6f2f4dd3b.dip0.t-ipconnect.de. [2003:cb:c749:9100:c078:eec6:f2f4:dd3b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6cf960sm3706563f8f.63.2024.10.11.04.33.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 04:33:13 -0700 (PDT)
Message-ID: <a552416e-fd32-4b84-b5d6-40a27530c939@redhat.com>
Date: Fri, 11 Oct 2024 13:33:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] mm: don't install PMD mappings when THPs are
 disabled by the hw/process/vma
To: Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, kvm@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 Thomas Huth <thuth@redhat.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Leo Fu <bfu@redhat.com>
References: <20241011102445.934409-1-david@redhat.com>
 <20241011102445.934409-3-david@redhat.com>
 <a4ca9422-09f5-4137-88d0-88a7ec836c1a@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <a4ca9422-09f5-4137-88d0-88a7ec836c1a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.10.24 13:29, Ryan Roberts wrote:
> On 11/10/2024 11:24, David Hildenbrand wrote:
>> We (or rather, readahead logic :) ) might be allocating a THP in the
>> pagecache and then try mapping it into a process that explicitly disabled
>> THP: we might end up installing PMD mappings.
>>
>> This is a problem for s390x KVM, which explicitly remaps all PMD-mapped
>> THPs to be PTE-mapped in s390_enable_sie()->thp_split_mm(), before
>> starting the VM.
>>
>> For example, starting a VM backed on a file system with large folios
>> supported makes the VM crash when the VM tries accessing such a mapping
>> using KVM.
>>
>> Is it also a problem when the HW disabled THP using
>> TRANSPARENT_HUGEPAGE_UNSUPPORTED? At least on x86 this would be the case
>> without X86_FEATURE_PSE.
>>
>> In the future, we might be able to do better on s390x and only disallow
>> PMD mappings -- what s390x and likely TRANSPARENT_HUGEPAGE_UNSUPPORTED
>> really wants. For now, fix it by essentially performing the same check as
>> would be done in __thp_vma_allowable_orders() or in shmem code, where this
>> works as expected, and disallow PMD mappings, making us fallback to PTE
>> mappings.
>>
>> Reported-by: Leo Fu <bfu@redhat.com>
>> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
> 
> Will this patch be difficult to backport given it depends on the previous patch
> and that doesn't have a Fixes tag?

"difficult" -- not really. Andrew might want to tag patch #1  with 
"Fixes:" as well, but I can also send simple stable backports that avoid 
patch #1.

(Thinking again, I assume we want to Cc:stable)

> 
>> Cc: Thomas Huth <thuth@redhat.com>
>> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
>> Cc: Janosch Frank <frankja@linux.ibm.com>
>> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   mm/memory.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 2366578015ad..a2e501489517 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -4925,6 +4925,15 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
>>   	pmd_t entry;
>>   	vm_fault_t ret = VM_FAULT_FALLBACK;
>>   
>> +	/*
>> +	 * It is too late to allocate a small folio, we already have a large
>> +	 * folio in the pagecache: especially s390 KVM cannot tolerate any
>> +	 * PMD mappings, but PTE-mapped THP are fine. So let's simply refuse any
>> +	 * PMD mappings if THPs are disabled.
>> +	 */
>> +	if (thp_disabled_by_hw() || vma_thp_disabled(vma, vma->vm_flags))
>> +		return ret;
> 
> Why not just call thp_vma_allowable_orders()?

Why call thp_vma_allowable_orders() that does a lot more work that 
doesn't really apply here? :)

I'd say, just like shmem, we handle this separately here.

-- 
Cheers,

David / dhildenb


