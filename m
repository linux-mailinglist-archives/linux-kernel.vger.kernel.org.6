Return-Path: <linux-kernel+bounces-432070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFCD9E449A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 20:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 469892815B5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6F114287;
	Wed,  4 Dec 2024 19:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b66lqrq+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECFE2391B3
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 19:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733340622; cv=none; b=uXVz735eYI7dnxjJEDtW7O18lzZ4zyGrIyJv3lvfKs51t5e+Pd+CbSz6Sa2Jk9HI4r7JPWyGS1OoG9Qc0fFzPtMyTgWSwNEiFkU8Z6UJzAAAUx9+1jFzI8mO4yWz50t+m5D67gZHHtJ4VjzlRPaoueyZcUPBbeLt3v42ldMC7EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733340622; c=relaxed/simple;
	bh=LDeMGWFzanbiZik0caldA2uOK7WUQXmNJjmYy6Sv72U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S85jgRrKSYb75FnZpSiLB9IJJGWypCiNxGiTkoPlVScio+2sEEmsx2xPW85RuRlJxbiK+gdugEbb/4gl0IdthJEefiRMgQbssHGZE9fm6iIStvdzfVVkrt9z73snIr3qTCbSZOa5ENwijaqH1XA13Fo5WcJkE7/O9FOtbxVx+lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b66lqrq+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733340619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=m9MdFt6v636sUVoVzmRfndSH9FM602N6LogN8wveooc=;
	b=b66lqrq+4k0bnrvPClPDBKmSBciljIChgRmNdIlOcXFioo3NOCJyFyjE5GqZ1GEoisFyeZ
	NPfks8nzs2nT3iGzTSLePCEZgLlK+qGJNBMXHbqDIhIOhsIVFEBidUdXzCOL/sKp6iTjCu
	luOIeaOdUj5myNCiYaTg2c9M2YWHuo0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-NvNkBeFJOoS_fEKTohYQNg-1; Wed, 04 Dec 2024 14:30:18 -0500
X-MC-Unique: NvNkBeFJOoS_fEKTohYQNg-1
X-Mimecast-MFC-AGG-ID: NvNkBeFJOoS_fEKTohYQNg
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-434941aa9c2so828085e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 11:30:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733340617; x=1733945417;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m9MdFt6v636sUVoVzmRfndSH9FM602N6LogN8wveooc=;
        b=WgQ+pJGpb+/2XckDvPxTMjxHf6i5tugPaLDoMGvplTJKAFczwh9kSgI0KMPpQZurwa
         PwG8eeEF/DXc3gAtfhtyHo00fXz8I0qHIgmHaZA5zp4XgrWttlfRSyQa4LtzlfrRRiVJ
         UsvBFBNHog52iVuw3r0jxECo1UHS6h6uhtOFc6IgkSv7brZ/L0ln3RaLyAba7yGYOxAc
         KgjgM2X5lOMe4fAOgXw7K/srczxHjxIlj3YvZOlbPsgX4Ivb5agBBqgWLmNKcoZk+Z+e
         yjsHi/ooIzmiEkSNJi+fFFieK/T8U9gIS1C+U2fJbirIEFCWx9H6Cfo5999qGj2pjOgw
         TVgQ==
X-Gm-Message-State: AOJu0Yz9ySLH7LT7Io/DbE7290HZaRPKqIbE+zDUmsScUB0Di/amZrkW
	Evc2sizPhLGbtzrtCq9hgMu6lW+X2aejHqQGvTXdEul4t7l6xcMWhxsCkedYWu2jE2Zl/eLXrgu
	dZshWzuk3Ws0M9ccT4XF71o/vwwdVZ7nYxe3nGWAtCeqG+NAJ4A5nSMreoWAOqp/6aloOF1+7
X-Gm-Gg: ASbGncvC9DHJt9MYRh1WyJYa6Rvnw7GMedTRKLE9Bp4C4Ayr8FvaAh3hJQZHZbDpYvI
	vpnhUFCGh5rMsRzX+GXi16wug2yMPe9K7h1MMtAIf+pl65TXfZT2QpPpjzOUqbzUu/MzWbNcehW
	IAt+N0ZZhWaNkDA1/PgJju+myxbhNKqlgA42KiUKMIkZ/sfKkTP9Y4XzYe849LtsWcvjafjWc7f
	CelTBRKAuDRfJe/EAJenHNltzVZCz+tsmtepcbTH3sDaKPXNPmY6XEjeYEqxOMqsECk+HT4TIFP
	/RnrHvRE9hzrh27FGLVxmW2fB87bYxUZ3IX0W8XiPj/cHKHAr9BFyhlRjoLAQ+tQiW3aLxXOghH
	hhg==
X-Received: by 2002:a05:600c:2944:b0:434:a1d3:a30f with SMTP id 5b1f17b1804b1-434d3f8e490mr48705385e9.6.1733340616821;
        Wed, 04 Dec 2024 11:30:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdEKgDpNCFrNX7uaBWkJ2BBs/oVnzOBHGuaR8FaMXUvS0uv/EZ9IwiBVhhdxLvF6Op0da4XQ==
X-Received: by 2002:a05:600c:2944:b0:434:a1d3:a30f with SMTP id 5b1f17b1804b1-434d3f8e490mr48705205e9.6.1733340616434;
        Wed, 04 Dec 2024 11:30:16 -0800 (PST)
Received: from ?IPV6:2003:cb:c70b:e100:38d6:8aa1:11b0:a20a? (p200300cbc70be10038d68aa111b0a20a.dip0.t-ipconnect.de. [2003:cb:c70b:e100:38d6:8aa1:11b0:a20a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52725b2sm33902215e9.5.2024.12.04.11.30.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 11:30:15 -0800 (PST)
Message-ID: <77838f94-f333-4973-858f-ea2964ea7b9e@redhat.com>
Date: Wed, 4 Dec 2024 20:30:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] hugetlb: support FOLL_FORCE|FOLL_WRITE
To: Guillaume Morin <guillaume@morinfr.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
 Eric Hagberg <ehagberg@janestreet.com>
References: <Z1Ce6j5WiBE3kaGf@bender.morinfr.org>
 <0dc516ab-b2b0-414d-868e-880bd13b5cdd@redhat.com>
 <Z1Cp2t6LNf3trdNf@bender.morinfr.org>
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
In-Reply-To: <Z1Cp2t6LNf3trdNf@bender.morinfr.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.12.24 20:13, Guillaume Morin wrote:
> On 04 Dec 20:01, David Hildenbrand wrote:
>>
>> On 04.12.24 19:26, Guillaume Morin wrote:
>>
>> Patch prefix should likely be "mm/hugetlb: ..."
>>
>>> FOLL_FORCE|FOLL_WRITE has never been properly supported for hugetlb
>>> mappings.  Since 1d8d14641fd94, we explicitly reject it. However
>>
>> "Since commit 1d8d14641fd9 ("mm/hugetlb: support write-faults in shared
>> mappings") ..."
> 
> Will fix in v2.
> 
>>
>>> running software on hugetlb mappings is a useful optimization.
>>> Multiple tools allow to use that such as Intel iodlr or
>>> libhugetlbfs.
>>
>> It would be better to link to the actual request where people ran into that
>> when using PTRACE_POKETEXT
>>
>> That hugetlb is getting used is rather obvious :)
> 
> Well, allow me to point out that I said running software on a hugetlb
> mapping, not generally using hugetlb.

Well, yes, but that's not really big news. People have been doing that 
(and rewriting their apps using libhugetlbfs to place text on huge pages 
pre file THP) for decades. :)

See below.

> 
> That said, which link are you referring to? The only discussion I am
> aware of is off mailing lists.

Oh, indeed, I could have sworn it was public.

I'd write something like

"Eric reported that PTRACE_POKETEXT fails when applications use hugetlb 
for mapping text using huge pages. Before commit 1d8d14641fd9, 
PTRACE_POKETEXT worked by accident, but it was buggy and silently ended 
up mapping pages writable into the page tables even though VM_WRITE was 
not set.

In general, FOLL_FORCE|FOLL_WRITE does currently not work with hugetlb. 
Let's implement FOLL_FORCE|FOLL_WRITE properly for hugetlb, such that 
what used to work in the past by accident now properly works, allowing 
applications using hugetlb for text etc. to get properly debugged.

This change might also be required to implement uprobes support for 
hugetlb [1].

[1] link to our discussion
"

-- 
Cheers,

David / dhildenb


