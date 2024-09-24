Return-Path: <linux-kernel+bounces-337265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B15F9847CC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33FAC2843C0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A592C1A7273;
	Tue, 24 Sep 2024 14:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b/t/0e7E"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271D2154C07
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 14:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727188766; cv=none; b=G679jet+phzbh8yyxEG7VU57rdKH1t7Lc1+LVvA4ZpNvaZGYtpWz2W3wqb5ruZJzmlAgPeo/rqnXrH4vzIxGv+uZEMSaZAAutf8ta5wt7Uoy/09EASw9Mw0D47MTdUoOnw5pkPlUWPnV1rM5by1tU++xmCbSNmzXMT/E3YPBGU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727188766; c=relaxed/simple;
	bh=4Ejy1MBa+YLEsVIdkGKZ9Wsis6ge+cFRC0DJlAtG+Lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VLM7SwegT3lNPdvCvxk/+90wrP8Wsa2y08qlbNH5dcUMdTyepJNUwT1//L06JAAfwW6JWISp88x3nXs5un0bdyMIzDkCiBuq4LAYks3Ad6n6u2OQDm+voivlhHsUrMKXwQNyXEl4mPYtCxawrIv6ITiKRqiUI7UOpUZ6NG6Noao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b/t/0e7E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727188763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PsmcvLVkjE6/ckGRL2QCn7BJoIjKbiBXB5thQo86V4k=;
	b=b/t/0e7EONpDtENUS0tFTeFu4nGVdlFryryC4caWsjqDJxmdEDN7y0cPXYBVvk6PLXdiCZ
	/pRkztaWGeSkr9hPg+PGDsNCIeJKXy8acTuVhCN0DYsdR7qHYpi3+zg7pvl15xHCHmXofS
	9A7lUJp+rhhK2Krf/sjmzW6MgWy3xB8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-qsiXb8Y5Pfq8ckybymY_EQ-1; Tue, 24 Sep 2024 10:39:20 -0400
X-MC-Unique: qsiXb8Y5Pfq8ckybymY_EQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7a9a6634b08so916838585a.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 07:39:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727188760; x=1727793560;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PsmcvLVkjE6/ckGRL2QCn7BJoIjKbiBXB5thQo86V4k=;
        b=RqeG6pd2XksYBmFCft4fHayqiDM/Rccka0HqADFjRSpB5rULZTJPvQUDNSyfZpVSXF
         wKAAa6xaElvN0kczCciB6akXhQybNX0y+QThx5fZBXwVG38K2MmHA9mgVpE5rA2v/dY+
         Os4AA8uNnHRaUCw61c2z9og9e0Gq0EgtA/pUXjsw4NdUaiJap1Xmoz1LylImn3A8ECgN
         tqjX4/Ikd61eWfUdkK5UwGisSOH/9dDn9ub0K1Js91kTdrDM+Ln8Ai3iRx07zYplQJKx
         cFmqktDbrghUR2gFv9q89ltn8YBIa+n36fdGnUjRgKCLlmjBUqBUoflaebkvSgSsDsSU
         URsQ==
X-Gm-Message-State: AOJu0YyStpa8ZEaxSkz93Aj2k3php5XlotflAKShgxQ3rqf5WqKmc6cU
	8JOj1B2YvTD3txD3KXy7kAPXdlNPWXUFRiA0iDZ9FX/xburWaeD6t8lRRYZ3A5wRbF6LkboW3Ro
	XokqZaaAGO8XmPf5ZCP9wLV/CViN8nRLafgC7etjsq5gV8garGK37b6ZiToqsag==
X-Received: by 2002:a05:620a:690d:b0:7a9:a356:a5dd with SMTP id af79cd13be357-7acdcd9f591mr604769685a.20.1727188760243;
        Tue, 24 Sep 2024 07:39:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaayEMlbll4GHZtNgISNw9URza1YiygQ6mUO1RvDz0LPs/VlktjcliZ89Xp/h+M2T3awsWcQ==
X-Received: by 2002:a05:620a:690d:b0:7a9:a356:a5dd with SMTP id af79cd13be357-7acdcd9f591mr604765785a.20.1727188759894;
        Tue, 24 Sep 2024 07:39:19 -0700 (PDT)
Received: from [10.202.151.204] (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acde6259e8sm73066485a.132.2024.09.24.07.39.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 07:39:19 -0700 (PDT)
Message-ID: <090c6ebc-c5cd-4d72-989d-40ee03ec1297@redhat.com>
Date: Tue, 24 Sep 2024 16:39:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/13] mm: multi-gen LRU: walk_pte_range() use
 pte_offset_map_rw_nolock()
To: Qi Zheng <zhengqi.arch@bytedance.com>, hughd@google.com,
 willy@infradead.org, muchun.song@linux.dev, vbabka@kernel.org,
 akpm@linux-foundation.org, rppt@kernel.org, vishal.moola@gmail.com,
 peterx@redhat.com, ryan.roberts@arm.com, christophe.leroy2@cs-soprasteria.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1727148662.git.zhengqi.arch@bytedance.com>
 <6efef5316d7468d13ed5f344452a0b872481972b.1727148662.git.zhengqi.arch@bytedance.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
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
In-Reply-To: <6efef5316d7468d13ed5f344452a0b872481972b.1727148662.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.09.24 08:10, Qi Zheng wrote:
> In walk_pte_range(), we may modify the pte entry after holding the ptl, so
> convert it to using pte_offset_map_rw_nolock(). At this time, the
> pte_same() check is not performed after the ptl held, so we should get
> pmdval and do pmd_same() check to ensure the stability of pmd entry.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Muchun Song <muchun.song@linux.dev>
> ---
>   mm/vmscan.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 749cdc110c745..bdca94e663bc5 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3375,8 +3375,10 @@ static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
>   	struct pglist_data *pgdat = lruvec_pgdat(walk->lruvec);
>   	DEFINE_MAX_SEQ(walk->lruvec);
>   	int old_gen, new_gen = lru_gen_from_seq(max_seq);
> +	pmd_t pmdval;
>   
> -	pte = pte_offset_map_nolock(args->mm, pmd, start & PMD_MASK, &ptl);
> +	pte = pte_offset_map_rw_nolock(args->mm, pmd, start & PMD_MASK, &pmdval,
> +				       &ptl);
>   	if (!pte)
>   		return false;
>   	if (!spin_trylock(ptl)) {
> @@ -3384,6 +3386,11 @@ static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
>   		return false;
>   	}
>   
> +	if (unlikely(!pmd_same(pmdval, pmdp_get_lockless(pmd)))) {
> +		pte_unmap_unlock(pte, ptl);
> +		return false;
> +	}

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


