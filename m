Return-Path: <linux-kernel+bounces-291700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 107D29565B5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC2AB284B69
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC39A14EC47;
	Mon, 19 Aug 2024 08:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PYYScp1+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43486C125
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724056598; cv=none; b=lFYniLhhWYgUTPavkkrOQNev2gSGyYCiz9jhoQFbDuLsD++Yq912BCQQK6ehc+H5GijEyD4Lbt47eup02yjLlDuTOnpTfi+CRyYUwtqpok7UcyQbxocLO9OLyYJtl65zW/GSE+KUFzrDx8/5sM6g0l3Omt8ouFI1KWLqNaSsXFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724056598; c=relaxed/simple;
	bh=nNLE4eoqbuu9Ak+gKu7Z23nQWMAS5HDz3UUfx5oAZ44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jc22bLFTt/+c1mzIV+NGFMj62ELYEvu6s76mv3+iYH32sjKcL55Y9lQEm+4y95LIknQoHJz5AyGm0UHtj/L0uNPou1oJgOSQ1O6iSAqsd7+TcJ0AmCXPG967becVOfjyqka80sDcUpssKXMYRm1HbfjAv3NrDJ/ZBwByjd2zzgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PYYScp1+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724056595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ISqrIQKsaqEr77ln38QuXukk21qsyi8yzuO8Lde5KzM=;
	b=PYYScp1+g6aSeaq1JrHMM/Dvqz7xk3QFMTAbSBBzIY980Gli+sM4Nryoz1gJ8B3QnKL1Ug
	I1oL7pM8ii1HGIAjOfBghYsAE3ZTmy6w/7pYGQhk9BL4Yog70E/E6WDzXFMhEPZZq0vcqO
	vYXZf6s0cDmYPMBVyO+wisPHfUog4qQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-E_wQ55W9O86TycF8VFdcxA-1; Mon, 19 Aug 2024 04:36:34 -0400
X-MC-Unique: E_wQ55W9O86TycF8VFdcxA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a7ab644746eso274439066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 01:36:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724056593; x=1724661393;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ISqrIQKsaqEr77ln38QuXukk21qsyi8yzuO8Lde5KzM=;
        b=i5WpcY5PlDzwb+TwIOip5Pjp1nmKLueY08SliVJ6bkrU39zUZQrZWntRGCYOIUUUR+
         bjxThEeyjRO/amOlmu0AvOMD2Hn6yuGNgV5nq1c2i1hrkfXO8UhZ11iiAAu9EuZaeAb0
         lgKIJZhVRjAGEORYxqA69+j1Sl0sFh+ZXcI6JkLPcjJZ2ddnozHs/3FPVwdLIB9nlKrh
         j0aBNEgZ/ESxozbEjjCP96tqbMNNFQ2dYNcuYbQ/mGVYGiYFa46Zfb49dYLSRacLrkb6
         pzXzQZcI7HG8cv2uXdE9zXCOzazjiY1lR2tDqQxsD/JZMLEvBuxyvtpGNM1J1frMFeKg
         M4Ew==
X-Forwarded-Encrypted: i=1; AJvYcCULQfkYIhAbwgoO9AeGMO60b+u7vEotXzTmTSYEqPfjiaKSJyy7RHvq/VayAwWfssBAeynU0yvajwJIxtHTXmQsaciv+jzx/rK98nT3
X-Gm-Message-State: AOJu0YyYukRgA8z58jQkQXsvE+oQcRKjGdQKLeZ6c0B/kHKHlOXaenYx
	f9zAEgmMXFY2/DRkYjGXpVfJpEKucYnnuT/cu2UnyPpq810I2FxrBWoGOaVHq/fYTb6489sSS9/
	WFt5wW93LGbRdGtd74zeCFQ+Sz5cKf6tkZv+i6ei7moOWp1M/0O0dTpvPfVs7pg==
X-Received: by 2002:a17:907:c7e7:b0:a77:e48d:bc8 with SMTP id a640c23a62f3a-a839292f10fmr720130866b.21.1724056592881;
        Mon, 19 Aug 2024 01:36:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWwcbxCxz3Zy38oz3eeNgITHsbVen71EQ/nghFVSqxobixhgS9j5bCtaQkIIaQFRosa15X0A==
X-Received: by 2002:a17:907:c7e7:b0:a77:e48d:bc8 with SMTP id a640c23a62f3a-a839292f10fmr720129266b.21.1724056592343;
        Mon, 19 Aug 2024 01:36:32 -0700 (PDT)
Received: from [100.81.188.195] (ipb218f908.dynamic.kabel-deutschland.de. [178.24.249.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838396d304sm602821266b.212.2024.08.19.01.36.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 01:36:31 -0700 (PDT)
Message-ID: <c53887da-ebbe-432e-bf81-308085215420@redhat.com>
Date: Mon, 19 Aug 2024 10:36:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] mm: khugepaged: expand the is_refcount_suitable() to
 support file folios
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org
Cc: hughd@google.com, willy@infradead.org, 21cnbao@gmail.com,
 ryan.roberts@arm.com, shy828301@gmail.com, ziy@nvidia.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1724054125.git.baolin.wang@linux.alibaba.com>
 <d6f8e4451910da1de0420eb82724dd85c368741c.1724054125.git.baolin.wang@linux.alibaba.com>
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
In-Reply-To: <d6f8e4451910da1de0420eb82724dd85c368741c.1724054125.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.08.24 10:14, Baolin Wang wrote:
> Expand the is_refcount_suitable() to support reference checks for file folios,
> as preparation for supporting shmem mTHP collapse.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>   mm/khugepaged.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index cdd1d8655a76..f11b4f172e61 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -549,8 +549,14 @@ static bool is_refcount_suitable(struct folio *folio)
>   	int expected_refcount;
>   
>   	expected_refcount = folio_mapcount(folio);
> -	if (folio_test_swapcache(folio))
> +	if (folio_test_anon(folio)) {
> +		expected_refcount += folio_test_swapcache(folio) ?
> +					folio_nr_pages(folio) : 0;
> +	} else {
>   		expected_refcount += folio_nr_pages(folio);
> +		if (folio_test_private(folio))
> +			expected_refcount++;
> +	}

Alternatively, a bit neater

if (!folio_test_anon(folio) || folio_test_swapcache(folio))
	expected_refcount += folio_nr_pages(folio);
if (folio_test_private(folio))
	expected_refcount++;

The latter check should be fine even for anon folios (although always false)


>   
>   	return folio_ref_count(folio) == expected_refcount;
>   }
> @@ -2285,8 +2291,7 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
>   			break;
>   		}
>   
> -		if (folio_ref_count(folio) !=
> -		    1 + folio_mapcount(folio) + folio_test_private(folio)) {

The "1" is due to the pagecache, right? IIUC, we don't hold a raised 
folio refcount as we do the xas_for_each().

-- 
Cheers,

David / dhildenb


