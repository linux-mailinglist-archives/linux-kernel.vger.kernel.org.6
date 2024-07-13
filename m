Return-Path: <linux-kernel+bounces-251288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7FD930302
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 03:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA47B1F21461
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 01:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320BCF9FE;
	Sat, 13 Jul 2024 01:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XxdtvK7T"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBB7DDAB
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 01:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720833787; cv=none; b=Y9JP6xYd8eejQ2fZabI8DefNhOSVzwRuMGDBohY0GZ5Z+UYnBEF9QBBrDRlsWF7TSUZmL+IsaeY/ccBhoBcWgqDUQB/NOgJK1XAGiyz0b4U6+1ZxDnHFuhnVM+V1jsVBC/skc2KrWVcdPSCjXWDFIEerMQnRzSXLlq7q/eV6wRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720833787; c=relaxed/simple;
	bh=qTpWHbVJG5EegmdojSgfg3aStOwYpqMLKeRkbhGRZ5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VWlfhqafGJl1uMTu+JDD9DtreC4kMzWe5qbBHDnTJpZkNXbRhghYHCc7qhDJ9A2DKnJeSFEcHzOIz36P9ilCvofs66hWUrbbcrmcc86lt+UkRo7R45dMgLNGmlZoadzLxQ1/Z+3fC86BMrwke7RT7WbxOMLnZvoEKLjB6hlq1J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XxdtvK7T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720833784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=96qXy98er4ppY2GDT/VfSRmz3R2UiUM94nu/XmfrfVU=;
	b=XxdtvK7TAxU4RNb4fnWHiLtJZonbj6AeSJG1SSRXaVfB8FN0U2F+b5AO4oTtZXUV6O1snx
	/GkpuzGct9oiURU2CFZu72HEaB3O+KEBlUbTlgThF9WWdkQQ79veX1KYi/0StR4ICKupb5
	DC1Mf1slzW4BXGDOD0NvvhESqSeJhus=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-W5--2UCVN9qmkoIMADiAag-1; Fri, 12 Jul 2024 21:23:03 -0400
X-MC-Unique: W5--2UCVN9qmkoIMADiAag-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2c96a0c27fcso2278360a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 18:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720833782; x=1721438582;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=96qXy98er4ppY2GDT/VfSRmz3R2UiUM94nu/XmfrfVU=;
        b=N8wofDllcvLwK1rWzEPoYDlataGHuv3+SMV3hKELWlan/RTAzRARL0UB+foYH88kPr
         wGYCwKDrB+/CXovPbQo8dUtAwQPlp+Ll28gxFkiZ0sWFTWLmLnp9qLCH5SslsjpYGtyR
         yahEvESNuN4mJIsWc+YWjV9J7pDteaB4zD6EwONnuTuMe0tk+kwYiAEnEi156OhTrih+
         mM1uNLQZxs2+JVRWtgjou3ssT32oSFMDIK+HnuPgFTvvzhF0qK9rcIdyWesk5JDC2Zwb
         pTS/FzcEz3QYVt0/28k3Vvt2rm8bUC5NYq5a4vtaRhCEy5CSYsQ3bzMeJobmdFmvjN0j
         tiHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTEiQvXtJRGbJgH8N44xPGSHTirjT7qnfRMvAj2/VvauyT/2O1PtTNFV4HJyuN/iZYV2WnDc5K8AGBpgqdWPZpH6PlfMDeIM4uRf6W
X-Gm-Message-State: AOJu0Yyiby7pO78WZ6YkWMMy19LiQY3Qr5ZPi3IsKOTevebtIoiOC9+X
	+18YmtPBltz0opXbg1DrnGq3hI6xopu8/ZNbkAe/hq1nailIZh4tEd2Wr3UOLZpR6WrNDMgZWTO
	XqUpOPJUHNKuRPtd2rZnziqdTme+CoSlERRr4m7QoFFngjO6/AwCsu1ghjQKEPg==
X-Received: by 2002:a05:6a20:914f:b0:1c0:7ec3:c7ae with SMTP id adf61e73a8af0-1c2984cd9f7mr14916652637.47.1720833781934;
        Fri, 12 Jul 2024 18:23:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjdAWavbNKN9EKbB6EMLRBt3ZcXJi9vcmdlFv0oLH8OXnjxQNc+ZObxqtfDZ4jkgfBG7Jd4w==
X-Received: by 2002:a05:6a20:914f:b0:1c0:7ec3:c7ae with SMTP id adf61e73a8af0-1c2984cd9f7mr14916641637.47.1720833781524;
        Fri, 12 Jul 2024 18:23:01 -0700 (PDT)
Received: from [172.20.2.228] ([4.28.11.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc5e904sm612325ad.304.2024.07.12.18.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 18:23:01 -0700 (PDT)
Message-ID: <f8d116fa-ae89-4d1e-a43f-79166c5d3075@redhat.com>
Date: Sat, 13 Jul 2024 03:23:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] memory tiering: read last_cpupid correctly in
 do_huge_pmd_numa_page()
To: Zi Yan <ziy@nvidia.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kernel@vger.kernel.org
References: <20240712024455.163543-1-zi.yan@sent.com>
 <20240712024455.163543-2-zi.yan@sent.com>
 <b62bbc37-ca90-4033-9fca-1cd11015211c@redhat.com>
 <65FBE843-2FEA-400B-9FFA-150E038F7BDA@nvidia.com>
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
In-Reply-To: <65FBE843-2FEA-400B-9FFA-150E038F7BDA@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.07.24 03:18, Zi Yan wrote:
> On 12 Jul 2024, at 21:13, David Hildenbrand wrote:
> 
>> On 12.07.24 04:44, Zi Yan wrote:
>>> From: Zi Yan <ziy@nvidia.com>
>>>
>>> last_cpupid is only available when memory tiering is off or the folio
>>> is in toptier node. Complete the check to read last_cpupid when it is
>>> available.
>>>
>>> Before the fix, the default last_cpupid will be used even if memory
>>> tiering mode is turned off at runtime instead of the actual value. This
>>> can prevent task_numa_fault() from getting right numa fault stats, but
>>> should not cause any crash. User might see performance changes after the
>>> fix.
>>>
>>> Fixes: 33024536bafd ("memory tiering: hot page selection with hint page fault latency")
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>> ---
>>>    mm/huge_memory.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index d7c84480f1a4..07d9dde4ca33 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -1705,7 +1705,8 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>>>    	 * For memory tiering mode, cpupid of slow memory page is used
>>>    	 * to record page access time.  So use default value.
>>>    	 */
>>> -	if (node_is_toptier(nid))
>>> +	if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) ||
>>> +	    node_is_toptier(nid))
>>>    		last_cpupid = folio_last_cpupid(folio);
>>>    	target_nid = numa_migrate_prep(folio, vmf, haddr, nid, &flags);
>>>    	if (target_nid == NUMA_NO_NODE)
>>
>> Reported-by: ...
> 
> Reported-by: David Hildenbrand <david@redhat.com>
> 
> I suppose your email[1] reports the issue based on code inspection.


Yes, thanks for taking care of the fix and cleanups!

-- 
Cheers,

David / dhildenb


