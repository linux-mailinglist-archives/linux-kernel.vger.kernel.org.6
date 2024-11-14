Return-Path: <linux-kernel+bounces-409284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 999119C8A01
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28F051F225F5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D672E1F9EDA;
	Thu, 14 Nov 2024 12:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZ/7QgNw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B241F9402
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 12:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731587550; cv=none; b=gTX0B8fdSyhbDL4Il7Rwp5V08/kWpYLcM+evjtc4SrvsIziZPCeWONts8Dygrnwg24tq6Ra6p+tj+erH61CF24kvrI/TwDugfooXf+JcjJ7PWgJxjYFXOaEEeIF69sweyn8+y4onsHhOSnRlvpQwzm4q4qtrhYRl1sXrtmClnqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731587550; c=relaxed/simple;
	bh=v+mB0Em3G2SgQM7YzQ1tRh1SrtceZclT2Ny+GkyfruI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kAzyFiFVJGWoJfFnbPBmJ20RHrdKNRdmUnXPxEPVxQS4/kVKaaZLRq8xButVxi/mOVkF/faoa/mD2modDVQt13F/jSUuwFOn9YjkvFeLRDxmzirj4qupoWEPSE2t6xFoP1hvNO/LYRna3mfVtcQ4GS0zx2UogY343tfwgvqG9kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IZ/7QgNw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731587547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8pF/zHNWZ4PMwC1AR7XfdcmDdlhA8diJTJA9QYg9vKM=;
	b=IZ/7QgNwtd5oRYuiXdCBgWMvIa4rb1JhRQqofTIUpxMWQ9trIdpbHJVdj/zEsRDOQwxsxw
	DV9P0TCjPS+0YdgVHSf/gobQujuiXxOcJ6YmUTrTUfB6G4Ey6zmKR3PwLonWov7DxMQXtS
	cuwTvMsdiqhMyiZVgnCA+ArrHqP1eSE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-TjNOlH44MkGvAgk47qPjBA-1; Thu, 14 Nov 2024 07:32:26 -0500
X-MC-Unique: TjNOlH44MkGvAgk47qPjBA-1
X-Mimecast-MFC-AGG-ID: TjNOlH44MkGvAgk47qPjBA
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43159603c92so4220665e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 04:32:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731587545; x=1732192345;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8pF/zHNWZ4PMwC1AR7XfdcmDdlhA8diJTJA9QYg9vKM=;
        b=kB4nxGqAlsLFqGl7WmUixKGe7UxWAl9MNwa3blHFA/ExQTxPo8w9zPp+jhZ90BFoJd
         ZjZb/wRTcUb5U+iHMFhj04LYMQsmRZcriwUSGSo7CeZt7Rh5cOtYzqvSn6zk9+qiW2R4
         1Z6wozSSqm7VZS0YAs8flsBKKnsEcjlVdIDJZVAamVGSkuElV3kb+MAu4s+6JitdnXsY
         XmBoovjsnxcI6SwixJr4BikdeA4G6gNaHFwcC85ugjRGvg8DjZGedA4lulgY/H3vcNSe
         O+kIn2yft3ZoJ4jY8zJDc01/2zfsdAEb3q9MFiypELmU8FyjH/ASFIi5PU33D/g+mdLh
         41ww==
X-Forwarded-Encrypted: i=1; AJvYcCVZzxhX0oYLs74uWYPfJmhIn+ixE/2r1v11NLPqQc4Gsue6z0Gjzwp5zHQROQr/vNhHMTtADMgw3GDIwII=@vger.kernel.org
X-Gm-Message-State: AOJu0YwogR1cLwon2sKi0x3MkwYhtyNOnbgjU0UhwxMSjCXDt2BMNwm+
	dpigaOlH0hypfpcQ2vQzZIvYIQpuG59uYHdta1RXz1JcgLPMUdRYCA4KpKlIT1fcl0WFBZ5SYZe
	c1zbxNTCV0iTGQTg1SLnlMr3n8swmJJL0jYtrdd9MsgqVARAz4PEnTpg23GV7Ig==
X-Received: by 2002:a05:600c:4f06:b0:42b:a7c7:5667 with SMTP id 5b1f17b1804b1-432da7cbb72mr17910215e9.25.1731587544776;
        Thu, 14 Nov 2024 04:32:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5H2Uxth5DHVclFFMRZh4KFHdC6qJuBCu3xB2C4GpzDAwBhcmiHVcQJ5I1+EbuHQ2c5nULTw==
X-Received: by 2002:a05:600c:4f06:b0:42b:a7c7:5667 with SMTP id 5b1f17b1804b1-432da7cbb72mr17910035e9.25.1731587544383;
        Thu, 14 Nov 2024 04:32:24 -0800 (PST)
Received: from ?IPV6:2003:cb:c715:6600:a077:c7da:3362:6896? (p200300cbc7156600a077c7da33626896.dip0.t-ipconnect.de. [2003:cb:c715:6600:a077:c7da:3362:6896])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab80582sm19043785e9.19.2024.11.14.04.32.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 04:32:23 -0800 (PST)
Message-ID: <fa3fc933-cd51-4be5-944e-250da9289eda@redhat.com>
Date: Thu, 14 Nov 2024 13:32:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] mm: introduce skip_none_ptes()
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: jannh@google.com, hughd@google.com, willy@infradead.org,
 muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org,
 peterx@redhat.com, mgorman@suse.de, catalin.marinas@arm.com,
 will@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
 peterz@infradead.org, x86@kernel.org, lorenzo.stoakes@oracle.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, zokeefe@google.com,
 rientjes@google.com
References: <cover.1731566457.git.zhengqi.arch@bytedance.com>
 <574bc9b646c87d878a5048edb63698a1f8483e10.1731566457.git.zhengqi.arch@bytedance.com>
 <c7eeac93-3619-4443-896f-ef2e02f0bef0@redhat.com>
 <617a063e-bd84-4da5-acf4-6ff516512055@bytedance.com>
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
In-Reply-To: <617a063e-bd84-4da5-acf4-6ff516512055@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14.11.24 10:20, Qi Zheng wrote:
> 
> 
> On 2024/11/14 16:04, David Hildenbrand wrote:
>>
>>>    static unsigned long zap_pte_range(struct mmu_gather *tlb,
>>>                    struct vm_area_struct *vma, pmd_t *pmd,
>>>                    unsigned long addr, unsigned long end,
>>> @@ -1682,13 +1704,17 @@ static unsigned long zap_pte_range(struct
>>> mmu_gather *tlb,
>>>            pte_t ptent = ptep_get(pte);
>>>            int max_nr;
>>> -        nr = 1;
>>> -        if (pte_none(ptent))
>>> -            continue;
>>> -
>>>            if (need_resched())
>>>                break;
>>> +        nr = skip_none_ptes(pte, addr, end);
>>> +        if (nr) {
>>> +            addr += PAGE_SIZE * nr;
>>> +            if (addr == end)
>>> +                break;
>>> +            pte += nr;
>>> +        }
>>> +
>>>            max_nr = (end - addr) / PAGE_SIZE;
>>
>> I dislike calculating max_nr twice, once here and once in skip_non_ptes.
>>
>> Further, you're missing to update ptent here.
> 
> Oh, my bad. However, with [PATCH v3 5/9], there will be no problem, but
> there are still two ptep_get() and max_nr calculation.
> 
> If you inline it you can
>> avoid another ptep_get().
> 
> Do you mean to inline the skip_none_ptes() into do_zap_pte_range()?

Effectively moving this patch after #5, and have it be something like:

diff --git a/mm/memory.c b/mm/memory.c
index 1949f5e0fece5..4f5d1e4c6688e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1667,8 +1667,21 @@ static inline int do_zap_pte_range(struct mmu_gather *tlb,
         pte_t ptent = ptep_get(pte);
         int max_nr = (end - addr) / PAGE_SIZE;
  
-       if (pte_none(ptent))
-               return 1;
+       /* Skip all consecutive pte_none(). */
+       if (pte_none(ptent)) {
+               int nr;
+
+               for (nr = 1; nr < max_nr; nr++) {
+                       ptent = ptep_get(pte + nr);
+                       if (!pte_none(ptent))
+                               break;
+               }
+               max_nr -= nr;
+               if (!max_nr)
+                       return nr;
+               pte += nr;
+               addr += nr * PAGE_SIZE;
+       }
  
         if (pte_present(ptent))
                 return zap_present_ptes(tlb, vma, pte, ptent, max_nr,


In the context of this patch this makes most sense.

Regarding "count_pte_none" comment, I assume you talk about patch #7.

Can't you simply return the number of pte_none that you skipped here using another
input variable, if really required?

-- 
Cheers,

David / dhildenb


