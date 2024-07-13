Return-Path: <linux-kernel+bounces-251279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 243749302F3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 03:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E0841F224BC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 01:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF1EC2ED;
	Sat, 13 Jul 2024 01:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CxgEBoq+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A2C101C4
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 01:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720833206; cv=none; b=OysQu3KOtpY79VDV6M0jhC8fwzJXA2g+OC36pmMTI+MED1FEsRyJQipY1mdYbdujdeUOmkwE9IW4QAF3usID/b5hN5lv48n5ZY3cUCVPqv1MObmA/eQtZmdryQQU/Mzh+dc5FC5odtYOBX5Q7EgrF9SIaiolgHGZIoAKeepuRtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720833206; c=relaxed/simple;
	bh=1+2tXwDpPMM4tTn7O36vYSwKQpXF//q+OgsT+I97MXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EzPSLbCT3m43K9DuU78BlDsusH61CeWn5u5JqbDqurl0dxmp9Wh8W55OrL9Y/WbWHh19OdL7Pd+gGrwb7uOIUoo6KRz+hcwRee0uicFx0kiiTxJ+mnn3PopsJmw1ocOziFbYijnnf3nY4CZ9hm+Zy0xSjFn8ixkbx+FE0GSicPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CxgEBoq+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720833202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ELYm2ntpkGlZwpzxDvwzBMEib4EzoBXn5PQMycc7g4U=;
	b=CxgEBoq+FzqawicMkqw5m5+ueST27zMkBO7Lm5qQk+Scczv4/E3HqWFM57+6IBnkt1ulz1
	o2G/29hN+x8z7svKTdBkGeWPoBbcTrM4LT8vIkaU18+ipIOs6BKwODWo2Dvuvy2KJM6lHO
	bpkEqgu1C5ITjQ3cS06wska+WhGR3ZM=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-dUPkQb4TNP-yMTMfh9RAaw-1; Fri, 12 Jul 2024 21:13:20 -0400
X-MC-Unique: dUPkQb4TNP-yMTMfh9RAaw-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7044952eed4so3540142a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 18:13:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720833199; x=1721437999;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ELYm2ntpkGlZwpzxDvwzBMEib4EzoBXn5PQMycc7g4U=;
        b=Z4KJGZI6UFIm3n+P5XKFEverGKRZWqvNFBXnWFNWvwAJeBuDzMJM4W85mEmSVBXXrC
         WF96HuKQdyRcDTy/92ROJS4RFVFMLx9AgMJbgDHfhAZsFXu5vUzqsDXvrZ4Wj3Jn9a7x
         Xry30CQKtUHrVA/UBWcBfiFUexJfx20OVXJpdjbNY5gL7UQsnnVfLW0/4ewWQKgiLaJa
         kWHpJvWcgPDcJY5lOhqLGS/lSrQyJ8F6wpuhLcBxh7ICeGoUWQGKU2feHs3wrnZqDolO
         tm39diSozvOgp+gv6h2J9UNpcvlhachNU5T7+k+tNnLr+nG+KSIu1TexUjp+tSOUpfMi
         HLDw==
X-Forwarded-Encrypted: i=1; AJvYcCUM51AlQxA6FgkvG8A9GneSlo0vZTb4AuXGbPFhVufb1WIuN6GEWWqLwmeSW8b3/pP14zMba/phFQ9nifM/tkC7XYnTif0U40uKUZc8
X-Gm-Message-State: AOJu0YzlwOkltz8PebCJtiZH5kO/ayQwnxcyIGxnCSdyaFRn9tJurP4Z
	XovDIkwELUKMRyE7/wrFv/jsds9F2aduuwmXyd2AEyTgvywjJNv1cmzhJMafu5Ydt29nZXr2uaY
	Ti3YW8uq9VkBYOdtpnwnU82Sp/YUAwJxVXGLPdMtvJSOB6GRrhkPT2K2dS5F2hw==
X-Received: by 2002:a05:6871:5c9:b0:25e:128e:609f with SMTP id 586e51a60fabf-25eae822e35mr10994085fac.28.1720833199626;
        Fri, 12 Jul 2024 18:13:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGu4XpQM9Hc1IylMQFqssjFwgn3OVAx1EJewLY8G88TVW+xyP21JRhTLpPSzZ1xcl3EmUJ+rw==
X-Received: by 2002:a05:6871:5c9:b0:25e:128e:609f with SMTP id 586e51a60fabf-25eae822e35mr10994074fac.28.1720833199297;
        Fri, 12 Jul 2024 18:13:19 -0700 (PDT)
Received: from [172.20.2.228] ([4.28.11.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ec7d963sm161469b3a.130.2024.07.12.18.13.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 18:13:18 -0700 (PDT)
Message-ID: <b62bbc37-ca90-4033-9fca-1cd11015211c@redhat.com>
Date: Sat, 13 Jul 2024 03:13:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] memory tiering: read last_cpupid correctly in
 do_huge_pmd_numa_page()
To: Zi Yan <ziy@nvidia.com>, "Huang, Ying" <ying.huang@intel.com>,
 linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kernel@vger.kernel.org
References: <20240712024455.163543-1-zi.yan@sent.com>
 <20240712024455.163543-2-zi.yan@sent.com>
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
In-Reply-To: <20240712024455.163543-2-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.07.24 04:44, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> last_cpupid is only available when memory tiering is off or the folio
> is in toptier node. Complete the check to read last_cpupid when it is
> available.
> 
> Before the fix, the default last_cpupid will be used even if memory
> tiering mode is turned off at runtime instead of the actual value. This
> can prevent task_numa_fault() from getting right numa fault stats, but
> should not cause any crash. User might see performance changes after the
> fix.
> 
> Fixes: 33024536bafd ("memory tiering: hot page selection with hint page fault latency")
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>   mm/huge_memory.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index d7c84480f1a4..07d9dde4ca33 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1705,7 +1705,8 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>   	 * For memory tiering mode, cpupid of slow memory page is used
>   	 * to record page access time.  So use default value.
>   	 */
> -	if (node_is_toptier(nid))
> +	if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) ||
> +	    node_is_toptier(nid))
>   		last_cpupid = folio_last_cpupid(folio);
>   	target_nid = numa_migrate_prep(folio, vmf, haddr, nid, &flags);
>   	if (target_nid == NUMA_NO_NODE)

Reported-by: ...
Closes: ...

If it applies ;)

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


