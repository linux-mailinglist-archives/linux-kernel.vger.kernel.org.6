Return-Path: <linux-kernel+bounces-566186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7503BA67474
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DCE6189F86E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB9F13DBA0;
	Tue, 18 Mar 2025 13:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lcc++r1F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEBE2D78A
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742302952; cv=none; b=cMh7myQ6++FdU+j48llVEVvOnYcft0fMx0cKccQGqq9zL71wEDn0pjufnI1g+eVtywZuGS1aITOtyMi0G+h/bPxYhx9xFpnBRX4OvTdvCvKRBybqdxUZCOhhs51XJwwQVts5V3YfYS5+hW4NOjxvewtve6GMUlfhvYwG8GZmtT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742302952; c=relaxed/simple;
	bh=IdJ2ONajhAv5kQdtPi9xERBFI80ila/fItBB4oUmnS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B198GeVbFnAhtVXCUhgjz3XKPMTpJD3fYwZpblNFTMyeqjE1Wpx2kH/PGeoJ8Z6clXK8LrVgn5zKHvSQgXwwswDLaLuMcqn+R/+g+SIPsjovVJUX4VwSrxIpOUM/iJBZZHVwo6ACwwH4/MCiBs8TU8taDhZCJJ1qNL9PtatuL5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lcc++r1F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742302949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xW5OBVXPhqq9ABnyxoNdtp6YlFFu+4p5FZNij3IBCh8=;
	b=Lcc++r1Ft0ruc4wo87RlXIlL8brY77oo7KtnYTzb/1J4MDNMhgShs2/eh+OrwHlz2pdUK5
	sO+C4T7Z+FWRl/7AFSwzv1AMpOzupuIid0+w7Ez4SSKb7cAEbr10UUu/NzTI8sZfXpTYdR
	saei9DN/QjLAAzRMTka6FVbT1c1XEx8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-YjkuD7NVPA6zxAvYGU49fg-1; Tue, 18 Mar 2025 09:02:26 -0400
X-MC-Unique: YjkuD7NVPA6zxAvYGU49fg-1
X-Mimecast-MFC-AGG-ID: YjkuD7NVPA6zxAvYGU49fg_1742302944
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-391425471d6so2280846f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742302944; x=1742907744;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xW5OBVXPhqq9ABnyxoNdtp6YlFFu+4p5FZNij3IBCh8=;
        b=gIZGwFZ1NKUDbdsSHsGbgTSm2H1djn0BLlSSyi9ChgzeBMeiUBalt6KHARoiGqlMAF
         g3pE7WePGyuR1epmxIT+abk1B51fQx6DckpbjGNt5LHKfnK8wqkDIgQV6dEeu6YIW8CB
         /TIL4XMDRcJS97pIFxko1oyswF6ZIYCwKIzdJRUj86sAqQDlYzaRQTXPLx/+QHgX70P6
         uKpHjNrq+X9VUePZNlyRHsysnJKzgQyQIHL1ythhWpfj4fO71/6xBr+7HpLEWi3pfKdb
         zDG5RRWNGH+aOpyk/OtaYtTzMRV/X3JEQFhzY/vbnxtRsDHRHNxW1Jl9ARi5zRag0Waz
         8S0g==
X-Forwarded-Encrypted: i=1; AJvYcCWsCafnSgPt3rpTo+9UpLUVSMhdRCXg2SG4dW8WM11o05qWHH0KSG96zo+mTMP077JLcdlkr+3/QzFlYGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt+PBG5o9hHtyeZoI7rwPaz6xskBaGFwVWJ0X2HP5ugTT5siA1
	WxzN+dE9GvW7mTfpTziRZGfcPD4OSovAQLOki1I9japKnmJ09m95gjJNlWrLxgmNEUdLnqEwRf3
	xd7sNjgf1n1J3DOlTGd70BDmtXjb+1bcisvzuS3awIOKsRK5edJG8OON1FMg+2A==
X-Gm-Gg: ASbGncuA0y1tpjRB8JFFw1YHuN1pohVJIvTs5qHkZ5mFELw5UmOEYpfGxTOjaKoaQXa
	6nV3Jd1SA7+lXVRKVjrtonH3RB7iIEaS3slhVpsZyEUZkrzUX4VNYXHNC/2Hy+anvsiX9WKIKad
	0TftmrwAQ008harmmoM5P4ykwYpmIf7VmUZlyzzauVC8MT2Xo0L2Dv1/pDGvSsnGgnHuCOuYdNs
	VJpRf/OJL6CD8FVT+JzESrKroDdVLk4mNzm032WQ9wa+efbqSVr8DO6a52l29dtlw+idXdzDe8r
	ldaA8otUuH+bjb2wk7nVXLnZZKHIWA5X+YZHgU4vX08aKQ==
X-Received: by 2002:a05:6000:1a87:b0:390:f0ff:2c1c with SMTP id ffacd0b85a97d-3971e96b183mr13704970f8f.18.1742302943903;
        Tue, 18 Mar 2025 06:02:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGw6WoKc9bjShFZwz+2fjZC8XriDevS/TJm3RXl6l6bgTCTE6CoPQdmSeV+Ub+lpbPgZWKRaw==
X-Received: by 2002:a05:6000:1a87:b0:390:f0ff:2c1c with SMTP id ffacd0b85a97d-3971e96b183mr13704923f8f.18.1742302943429;
        Tue, 18 Mar 2025 06:02:23 -0700 (PDT)
Received: from [192.168.3.141] (p5b0c65e3.dip0.t-ipconnect.de. [91.12.101.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df34eesm18336971f8f.18.2025.03.18.06.02.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 06:02:22 -0700 (PDT)
Message-ID: <24ca760c-a861-4797-a434-d91a59513b12@redhat.com>
Date: Tue, 18 Mar 2025 14:02:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] mm/cma: using per-CMA locks to improve concurrent
 allocation performance
To: Andrew Morton <akpm@linux-foundation.org>, yangge1116@126.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 21cnbao@gmail.com,
 baolin.wang@linux.alibaba.com, aisheng.dong@nxp.com, liuzixing@hygon.cn
References: <1739152566-744-1-git-send-email-yangge1116@126.com>
 <20250317204325.99b45373023ad2f901c1152e@linux-foundation.org>
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
In-Reply-To: <20250317204325.99b45373023ad2f901c1152e@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.03.25 04:43, Andrew Morton wrote:
> On Mon, 10 Feb 2025 09:56:06 +0800 yangge1116@126.com wrote:
> 
>> From: yangge <yangge1116@126.com>
>>
>> For different CMAs, concurrent allocation of CMA memory ideally should not
>> require synchronization using locks. Currently, a global cma_mutex lock is
>> employed to synchronize all CMA allocations, which can impact the
>> performance of concurrent allocations across different CMAs.
>>
>> To test the performance impact, follow these steps:
>> 1. Boot the kernel with the command line argument hugetlb_cma=30G to
>>     allocate a 30GB CMA area specifically for huge page allocations. (note:
>>     on my machine, which has 3 nodes, each node is initialized with 10G of
>>     CMA)
>> 2. Use the dd command with parameters if=/dev/zero of=/dev/shm/file bs=1G
>>     count=30 to fully utilize the CMA area by writing zeroes to a file in
>>     /dev/shm.
>> 3. Open three terminals and execute the following commands simultaneously:
>>     (Note: Each of these commands attempts to allocate 10GB [2621440 * 4KB
>>     pages] of CMA memory.)
>>     On Terminal 1: time echo 2621440 > /sys/kernel/debug/cma/hugetlb1/alloc
>>     On Terminal 2: time echo 2621440 > /sys/kernel/debug/cma/hugetlb2/alloc
>>     On Terminal 3: time echo 2621440 > /sys/kernel/debug/cma/hugetlb3/alloc
>>
>> We attempt to allocate pages through the CMA debug interface and use the
>> time command to measure the duration of each allocation.
>> Performance comparison:
>>               Without this patch      With this patch
>> Terminal1        ~7s                     ~7s
>> Terminal2       ~14s                     ~8s
>> Terminal3       ~21s                     ~7s
>>
>> To slove problem above, we could use per-CMA locks to improve concurrent
>> allocation performance. This would allow each CMA to be managed
>> independently, reducing the need for a global lock and thus improving
>> scalability and performance.
> 
> This patch was in and out of mm-unstable for a while, as Frank's series
> "hugetlb/CMA improvements for large systems" was being added and
> dropped.
> 
> Consequently it hasn't received any testing for a while.
> 
> Below is the version which I've now re-added to mm-unstable.  Can
> you please check this and retest it?
> 
> Thanks.
> 
> From: Ge Yang <yangge1116@126.com>
> Subject: mm/cma: using per-CMA locks to improve concurrent allocation performance
> Date: Mon, 10 Feb 2025 09:56:06 +0800
> 
> For different CMAs, concurrent allocation of CMA memory ideally should not
> require synchronization using locks.  Currently, a global cma_mutex lock
> is employed to synchronize all CMA allocations, which can impact the
> performance of concurrent allocations across different CMAs.
> 
> To test the performance impact, follow these steps:
> 1. Boot the kernel with the command line argument hugetlb_cma=30G to
>     allocate a 30GB CMA area specifically for huge page allocations. (note:
>     on my machine, which has 3 nodes, each node is initialized with 10G of
>     CMA)
> 2. Use the dd command with parameters if=/dev/zero of=/dev/shm/file bs=1G
>     count=30 to fully utilize the CMA area by writing zeroes to a file in
>     /dev/shm.
> 3. Open three terminals and execute the following commands simultaneously:
>     (Note: Each of these commands attempts to allocate 10GB [2621440 * 4KB
>     pages] of CMA memory.)
>     On Terminal 1: time echo 2621440 > /sys/kernel/debug/cma/hugetlb1/alloc
>     On Terminal 2: time echo 2621440 > /sys/kernel/debug/cma/hugetlb2/alloc
>     On Terminal 3: time echo 2621440 > /sys/kernel/debug/cma/hugetlb3/alloc
> 
> We attempt to allocate pages through the CMA debug interface and use the
> time command to measure the duration of each allocation.
> Performance comparison:
>               Without this patch      With this patch
> Terminal1        ~7s                     ~7s
> Terminal2       ~14s                     ~8s
> Terminal3       ~21s                     ~7s
> 
> To solve problem above, we could use per-CMA locks to improve concurrent
> allocation performance.  This would allow each CMA to be managed
> independently, reducing the need for a global lock and thus improving
> scalability and performance.
> 
> Link: https://lkml.kernel.org/r/1739152566-744-1-git-send-email-yangge1116@126.com
> Signed-off-by: Ge Yang <yangge1116@126.com>
> Reviewed-by: Barry Song <baohua@kernel.org>
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Cc: Aisheng Dong <aisheng.dong@nxp.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


