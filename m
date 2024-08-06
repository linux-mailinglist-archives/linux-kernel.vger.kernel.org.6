Return-Path: <linux-kernel+bounces-276422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E59949368
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D72D81C2148E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E23A1D61B1;
	Tue,  6 Aug 2024 14:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OSJL4m4a"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C2E1C3789
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 14:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722955221; cv=none; b=o5msME6LfSUVmSvYNyJkt2JUCtWLwRi9dALnL8iOuWf8szFhT3rk3xm5VYM9XTy6jYuN4u+3R/k4dnzi29vTHk4Gew7m33rXJRrUQY/faLiHPswdvRewjkMAWrkHOoB6yybMh8hrfqV+23K3r1OF04bm2xmu8diGz7/mq4vKapo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722955221; c=relaxed/simple;
	bh=jWkI+sZaploxJo16FuCiQuCe3BbZBjGU+pZrsNJl+gQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d+Vub7QRge5kV8s3mNv2xa57lIhufRo2k9s59i3cmSZ9yMn7DyGapZRqW/LP0bIr6MSRbPkRBnvCQQSt/uuwyQzsTy7rxWl1wxkGi0Cay9YVnnYQZ8xX3TxWNrL4VoVRt3Ax9uy7LN1mzpaxMY5G8aID7I1NZ/TvaezRPLY8Y5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OSJL4m4a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722955219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=J6Adx0B2CFsrsree1Aord21XBomvfgmn1zXz89+4820=;
	b=OSJL4m4aHOmnGU/hQqP+R5JOvVclPUAiUHhXvPk2BBRC1vcv7CAok9ghojvm+QP6IuypnO
	eBDxeob/CrWBR83IHc5vU/Ure4q4rGsc4H2VEnpSWknDbzosIZP8HC8CoGcEiLJ5GBoC6K
	78yuoNL/GW2wuQn12ZQFKm2alZ0BmZE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-XaI3BVZGOLSsuwC8kXKCKw-1; Tue, 06 Aug 2024 10:40:16 -0400
X-MC-Unique: XaI3BVZGOLSsuwC8kXKCKw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52fcf2b5287so1137595e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 07:40:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722955215; x=1723560015;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J6Adx0B2CFsrsree1Aord21XBomvfgmn1zXz89+4820=;
        b=jrqfnsvkxe8QlBq95Xq2maBNlX0j8lrOV2g7FK+6gMOxJq0ILF6fmDgu750MUO7oFR
         WCno86+6Wob7LqxbijVtA6CXwFPMmM5deFaTiRPYcjffII90A4wJPlEw/BkAeUMGuam8
         gcOPzNjeyJSrXdzU0UC0AT8vHpKMmleizoGs0E9YvOAI0pY8P+J9knGAEUxLJYl9bhiC
         h0WVIFphg5i8ETQ4uhdAwUT2rfLdPbNBD/Q9hO5vY7PC1APHUq4qeutlWQnI4uikzGWb
         rkuoZhZjJMBehXtK2buLzsY/tmgjBGlDen3KhJr8M+hXlirgNqsVDC3GDlX/7lxdBFbB
         /1hg==
X-Forwarded-Encrypted: i=1; AJvYcCVJSrC6qyBriCXAWWRWLxM3fkUhw0qmfXzkrQd8UCdOrMFRDuqLjSIl5GrL6AHccSTZ1i9Y02D0shuLY5tKbDcStDFNpDTOap35phRt
X-Gm-Message-State: AOJu0YyZrKHRqlO1amiZWt+gM6Qk95vCYwe4cCllsjdVv8QNawBgVaGh
	jHHxLJJ9ivWTOH2qn/XDJBa34Y5UC17lOK8gRt0gjHDVdzleyIrD0Qm7V4UppyAx3LTwIBVArQo
	6L3cGZxfdYUC+FhKEfesNMCM27qFzrQzmpzxyzkCBcS/QFYTkNpTP95Z0CUPm4g==
X-Received: by 2002:a2e:2e03:0:b0:2ef:2543:457c with SMTP id 38308e7fff4ca-2f15aab06f2mr95870781fa.24.1722955215020;
        Tue, 06 Aug 2024 07:40:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTSRTwR4vg6qDQJkc79aSqG7JeuIYbH1AYiNNCYk8oHqNzff0UmuuOMAzkLBse1AYZOxAOnw==
X-Received: by 2002:a2e:2e03:0:b0:2ef:2543:457c with SMTP id 38308e7fff4ca-2f15aab06f2mr95870431fa.24.1722955214459;
        Tue, 06 Aug 2024 07:40:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73f:8500:f83c:3602:5300:88af? (p200300cbc73f8500f83c3602530088af.dip0.t-ipconnect.de. [2003:cb:c73f:8500:f83c:3602:5300:88af])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd01e0a7sm13082779f8f.43.2024.08.06.07.40.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 07:40:14 -0700 (PDT)
Message-ID: <2659a0bc-b5a7-43e0-b565-fcb93e4ea2b7@redhat.com>
Date: Tue, 6 Aug 2024 16:40:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 4/7] mm: pgtable: try to reclaim empty PTE pages in
 zap_page_range_single()
To: Qi Zheng <zhengqi.arch@bytedance.com>, hughd@google.com,
 willy@infradead.org, mgorman@suse.de, muchun.song@linux.dev,
 vbabka@kernel.org, akpm@linux-foundation.org, zokeefe@google.com,
 rientjes@google.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1722861064.git.zhengqi.arch@bytedance.com>
 <9fb3dc75cb7f023750da2b4645fd098429deaad5.1722861064.git.zhengqi.arch@bytedance.com>
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
In-Reply-To: <9fb3dc75cb7f023750da2b4645fd098429deaad5.1722861064.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.08.24 14:55, Qi Zheng wrote:
> Now in order to pursue high performance, applications mostly use some
> high-performance user-mode memory allocators, such as jemalloc or
> tcmalloc. These memory allocators use madvise(MADV_DONTNEED or MADV_FREE)
> to release physical memory, but neither MADV_DONTNEED nor MADV_FREE will
> release page table memory, which may cause huge page table memory usage.
> 
> The following are a memory usage snapshot of one process which actually
> happened on our server:
> 
>          VIRT:  55t
>          RES:   590g
>          VmPTE: 110g
> 
> In this case, most of the page table entries are empty. For such a PTE
> page where all entries are empty, we can actually free it back to the
> system for others to use.
> 
> As a first step, this commit attempts to synchronously free the empty PTE
> pages in zap_page_range_single() (MADV_DONTNEED etc will invoke this). In
> order to reduce overhead, we only handle the cases with a high probability
> of generating empty PTE pages, and other cases will be filtered out, such
> as:

It doesn't make particular sense during munmap() where we will just 
remove the page tables manually directly afterwards. We should limit it 
to the !munmap case -- in particular MADV_DONTNEED.

To minimze the added overhead, I further suggest to only try reclaim 
asynchronously if we know that likely all ptes will be none, that is, 
when we just zapped *all* ptes of a PTE page table -- our range spans 
the complete PTE page table.

Just imagine someone zaps a single PTE, we really don't want to start 
scanning page tables and involve an (rather expensive) walk_page_range 
just to find out that there is still something mapped.

Last but not least, would there be a way to avoid the walk_page_range() 
and simply trigger it from zap_pte_range(), possibly still while holding 
the PTE table lock?

We might have to trylock the PMD, but that should be doable.

-- 
Cheers,

David / dhildenb


