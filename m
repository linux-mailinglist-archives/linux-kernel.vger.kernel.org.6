Return-Path: <linux-kernel+bounces-200687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4BB8FB359
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 814BE1F23E96
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD0D146582;
	Tue,  4 Jun 2024 13:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TQy0k1jE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9C21E519
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 13:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717507102; cv=none; b=EGy4YgA5Bnz+dR4VK975aQBVdJrM8/62VOy3t50/xBdl6hKyY5WV02iVIKjexEhZMrgOadaloD4nPt2BzGccCcw0p9/F37Y8q9/1XtKoBad7l6dfuqsu775UUJC0uKZEoTO4Q9M7/Eq7nQFScjNZMOLvhbScMQLAAXkNrVuVxGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717507102; c=relaxed/simple;
	bh=VDxMR3AorDIoCNqnfNVDNCr3B6yOOxOWJT+CIy6PDCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=g2KbmsEKuOhvAaJ4knatyZoSCdloYn9GooxpHjW4mzSmV16SCpes/Ql98vaIcPq4eAKVr0j+TihwBfnQiPpQuJ5h8Ar3U34LmVkRVttG9p1H3+iiFKJ6qS4mctXMlVrApEo0ESFnF4+ORylaIhlLUbL4YDi85q9ApeGmsDCt6RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TQy0k1jE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717507099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EiYrE/8TjWzRIPpqq/yqqnp1VVjY1fjK18SjvOdopT8=;
	b=TQy0k1jE2LZdEouAFdS0lhss9AOcN39cTdsm2SgQZ7qyKZlCpkFN3383GG8hRj3homdtZV
	3/27pmnsXXgFsRtx6AldqeykeZgIkwuG6vh9foxa+dSjvB3VH1etxgNcU436jyUtKcFJ7k
	1QZB107s35ImUKvjBDLian1oPkWDBJw=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-npP5KpLKMC21eaSOzA3F2A-1; Tue, 04 Jun 2024 09:18:16 -0400
X-MC-Unique: npP5KpLKMC21eaSOzA3F2A-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2eaa77740deso8703551fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 06:18:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717507095; x=1718111895;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EiYrE/8TjWzRIPpqq/yqqnp1VVjY1fjK18SjvOdopT8=;
        b=Pq/qo3k6HkQChhza27NCPjSWtmBNIOhf/A7Z/zutXLH6t/seI3Qpjv+Y8yum/lxcHi
         aCyfNDerqEN/hUQF0Hca5UF6fs6JwtO0k5w5KPHkHjFdE7tB7KjYUB5b1dy6wpN1sFVx
         fQNa5Bt33ckxzoD/L47NCxlDKQG6Rg+dwsM43SrjkC01oVRWfSheyU/5UvG/EvpBZ49M
         psVWmbhLIqsVlzta79t5hZRitaQFV04LCk8MQX+8tEGa+NN3Qa5iWeERYj/Wque/mAmX
         4yq+YaKUQzW1uWQzIvObVi2TmrV52ooIsBJZpnskiIr/MY35nkJYxNgTI80YN4h6PyOQ
         aclw==
X-Forwarded-Encrypted: i=1; AJvYcCWPMdr/xXpgpwEX3ZWi4L58JNlEoRcuDXufXgIRp8Fj215JAZHvsbVDehiW6wYlkanJR282oi6iW2fJgb2T8b6HElv+gAavTR2/HEHm
X-Gm-Message-State: AOJu0YwHe2KBr8bN7RFXJVMkMscYOYd8gp+2+SoLPCWDNW3+DcRgavjB
	PDu0qSnRmEq+rLv/zjcdTETqCF6wbx6CzsGIzqGT5prKYHOmmqEtpB7LDwnar/xtcEdFyFdUzWD
	t5A0plTPTjmsup9AxMH7IPixot6WHQoQYigAwK+nRqwj/caI2wVRumoJ/jURvog==
X-Received: by 2002:a2e:870d:0:b0:2de:73b5:427c with SMTP id 38308e7fff4ca-2ea950b5396mr74938721fa.9.1717507094921;
        Tue, 04 Jun 2024 06:18:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFc8FtSCIGrimFOyzAMyZpApvLn0WSmU3RQODLDr1Zjhs5mSc8kXNRN+R/+HqMDMHyVpnbL9Q==
X-Received: by 2002:a2e:870d:0:b0:2de:73b5:427c with SMTP id 38308e7fff4ca-2ea950b5396mr74938501fa.9.1717507094508;
        Tue, 04 Jun 2024 06:18:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73a:3a00:a025:9b06:549e:c16b? (p200300cbc73a3a00a0259b06549ec16b.dip0.t-ipconnect.de. [2003:cb:c73a:3a00:a025:9b06:549e:c16b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd064bbb1sm11496884f8f.101.2024.06.04.06.18.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 06:18:14 -0700 (PDT)
Message-ID: <ddb33c85-35e4-47c5-8a81-13a2012aac5e@redhat.com>
Date: Tue, 4 Jun 2024 15:18:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] mm/ksm: calc_checksum for folio
To: alexs@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 izik.eidus@ravellosystems.com, willy@infradead.org, aarcange@redhat.com,
 chrisw@sous-sol.org, hughd@google.com
References: <20240604042454.2012091-1-alexs@kernel.org>
 <20240604042454.2012091-10-alexs@kernel.org>
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
In-Reply-To: <20240604042454.2012091-10-alexs@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.06.24 06:24, alexs@kernel.org wrote:
> From: "Alex Shi (tencent)" <alexs@kernel.org>
> 
> Let's check the whole folio for contents change, don't count it if the
> folio changed.
> 
> Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
> ---
>   mm/ksm.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index b9c04ce677b9..dc2b5e6a9659 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -1258,11 +1258,13 @@ static int unmerge_and_remove_all_rmap_items(void)
>   }
>   #endif /* CONFIG_SYSFS */
>   
> -static u32 calc_checksum(struct page *page)
> +static u32 calc_checksum(struct folio *folio)
>   {
>   	u32 checksum;
> -	void *addr = kmap_local_page(page);
> -	checksum = xxhash(addr, PAGE_SIZE, 0);
> +	int nr = folio_nr_pages(folio);
> +	void *addr = kmap_local_page(folio_page(folio, 0));
> +
> +	checksum = xxhash(addr, nr * PAGE_SIZE, 0);
>   	kunmap_local(addr);
>   	return checksum;
>   }
> @@ -2369,7 +2371,7 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
>   	 * don't want to insert it in the unstable tree, and we don't want
>   	 * to waste our time searching for something identical to it there.
>   	 */
> -	checksum = calc_checksum(page);
> +	checksum = calc_checksum(folio);

So for a large folio you suddenly checksum more than a single page? 
That's wrong.

Or am I missing something?


-- 
Cheers,

David / dhildenb


