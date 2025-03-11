Return-Path: <linux-kernel+bounces-555733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42513A5BBFD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFE013AC4C0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 09:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157662236E9;
	Tue, 11 Mar 2025 09:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jDmIsaWy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA672222D3
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 09:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741684967; cv=none; b=HpofCjU92ByCGo/maNtsAJb+xqCvdWbMFuXctmkK8pMsc9/xrKJD1PMOBYCBH5H6sxxgRreAkcQTUpQgZ3OxzXJ9f0iiTMA3tcxFFZgu010Io9GbvYZ16qVTv9tw0m0nMd0W5FPwqdJjvbL2RsVsgtkjW4Ieako6HDWaJlnMsuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741684967; c=relaxed/simple;
	bh=BspgR8efAUUZvEUV7Ragma+wogQI2jzTWK2a7NYT03o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p/LT9kBddJHIRZbBfRKSI0huiq1egBt7aZ3SfcM8lERIsjd5Pv4KzSjY/aWiq6cnbFHiLF2+UexEQsOwypG3jNDOhztWD7lprMXVWOSd+BoXzfrKXE/A5RkbXuoU06PimbfjqHSlDOOjno3TaeJrKGgL/jtuJ1cYu4P8BBD27DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jDmIsaWy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741684964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aoowg98qfqmhPGYX9HCQXG0NImnz6BJb3PARBiLP8mk=;
	b=jDmIsaWyggvlF0hAbmdXlKEh4Aq9ojOvK3IHLTtx7qDBGGRVr5WGPSSWUdi22JD4sRS5Z1
	O7SzAw1Dgdul2PJRiG1ivxjTIaWpacUSAaOTi9zHzw7ZqCgfFrhxrnN4xt9ZqDwiCj4EyC
	IEoR+YqgdI+RPdcYKnMRAwEFbR3jO+E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-kPlozSL4MleX1tVOZiin8Q-1; Tue, 11 Mar 2025 05:22:42 -0400
X-MC-Unique: kPlozSL4MleX1tVOZiin8Q-1
X-Mimecast-MFC-AGG-ID: kPlozSL4MleX1tVOZiin8Q_1741684961
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43ce8f82e66so13915345e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 02:22:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741684961; x=1742289761;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aoowg98qfqmhPGYX9HCQXG0NImnz6BJb3PARBiLP8mk=;
        b=iE29j4/IRCkzsSI/NhzRxUCFyBi/A5ZOQpGXKZZCgPKZ9TdedwzRrwZ6+Lk1xxxL5B
         rRc0UDgD31cx1h1hy38xFWkFSKTnAp6K2ixqFAmKTqZk7qT6AsOq72r0Tf4RYo9JM12O
         8u7gGoB061N4aoNqTfE+6T4NOr4omzpfZHIMODS8rgJvDPoi957K4wuKS6LN8IejFQdw
         SNsldl/NcgClzk74yjdpkgPaFzQ5aiCAxooOKJEJHpN3qV2eA9yytPU98gqrDgswnP7T
         N4uKixrMGLwii0aQmDaVddPkF9pOC0El5l2donE4+4BKMCt8YhdVyKKxeeXWQsAwwysQ
         gsWg==
X-Forwarded-Encrypted: i=1; AJvYcCVtmq/9tnKrKMI7iPwwWLde72zBjU4BOkLTHhZYg1pSj+jOgSnSFV5V2QSiwnvFp8DKOhdgvfCKSFoaHJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJC1V/rduU0SLrUXG7g+QYZgzqwX8UbYZ4yNyyU1vJmKjMFH6r
	7th80fFJpjJtCb/hqECAUkjyVj7Jk0tEMAXY1xT04Sp9SaoHM6ME5jYH0Crn7i4YDgx8jeJ75J5
	rYxSuzZwW4S8AwG67GQHhdEy8m6RKn6onqkTlgPHxwNk2VsPfQ/JyVThvmUOuVA==
X-Gm-Gg: ASbGncvZJ9lLoW/N4kIrs/G6AWzuLgHG+z2orIHQDIEIYoc4j/tb0Hsias5wkKVGuz+
	vlwu9SqWuH87a4iFwnC4hPXqJfcuNoG3+pdyfrFxijUbhifm6N0j3DXzlUyWtGIov+5TGSkNIpc
	4ArY8wBvDmX8S1l3DEewdTQVetrlCr54+6sEzEE4sKGUnl5VLW4Z1wLbpTzgSHw77Lns6mNBVBl
	JnY298fuMx4e4bdLgwSml4dOXdIkAHbOLzMil+D2Cwu0z7E2YQpuQZKXqT9yome3ie4Nc/y0yw+
	gwEdkjdSunY1+sNPZm4YF+iQl7uX/S4I81ACPT1Fytnf2LcdZcWbuXTyDkcF/QXgVSy+zK1elfv
	d6Q0bUbPTZfJ2ZzkYCpVEFES3NGJBtBeojt8K8VDhlbc=
X-Received: by 2002:a05:600c:1d26:b0:43c:f597:d589 with SMTP id 5b1f17b1804b1-43cf597d965mr61902745e9.27.1741684961379;
        Tue, 11 Mar 2025 02:22:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3OeLTnks1AHtv43fnHPcqD//ZPkiszEEwFWvPRWLGfP75AE62MDVat+38GQNeR+vGswVmHg==
X-Received: by 2002:a05:600c:1d26:b0:43c:f597:d589 with SMTP id 5b1f17b1804b1-43cf597d965mr61902505e9.27.1741684960961;
        Tue, 11 Mar 2025 02:22:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c720:ed00:a9b3:5954:823e:3427? (p200300cbc720ed00a9b35954823e3427.dip0.t-ipconnect.de. [2003:cb:c720:ed00:a9b3:5954:823e:3427])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c102db1sm17527475f8f.95.2025.03.11.02.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 02:22:40 -0700 (PDT)
Message-ID: <5f8db79f-5eb3-48f0-a7cd-a903f9cbe75e@redhat.com>
Date: Tue, 11 Mar 2025 10:22:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver/base/node.c: Fix softlockups during the
 initialization of large systems with interleaved memory blocks
To: Donet Tom <donettom@linux.ibm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
References: <20250310115305.13599-1-donettom@linux.ibm.com>
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
In-Reply-To: <20250310115305.13599-1-donettom@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.03.25 12:53, Donet Tom wrote:
> On large systems with more than 64TB of DRAM, if the memory blocks
> are interleaved, node initialization (node_dev_init()) could take
> a long time since it iterates over each memory block. If the memory
> block belongs to the current iterating node, the first pfn_to_nid
> will provide the correct value. Otherwise, it will iterate over all
> PFNs and check the nid. On non-preemptive kernels, this can result
> in a watchdog softlockup warning. Even though CONFIG_PREEMPT_LAZY
> is enabled in kernels now [1], we may still need to fix older
> stable kernels to avoid encountering these kernel warnings during
> boot.

If it's not an issue upstream, there is no need for an upstream patch.

Fix stable kernels separately.

Or did I get you wrong and this can be triggered upstream?

> 
> This patch adds a cond_resched() call in node_dev_init() to avoid
> this warning.
> 
> node_dev_init()
>      register_one_node
>          register_memory_blocks_under_node
>              walk_memory_blocks()
>                  register_mem_block_under_node_early
>                      get_nid_for_pfn
>                          early_pfn_to_nid
> 
> In my system node4 has a memory block ranging from memory30351
> to memory38524, and memory128433. The memory blocks between
> memory38524 and memory128433 do not belong to this node.
> 
> In  walk_memory_blocks() we iterate over all memblocks starting
> from memory38524 to memory128433.
> In register_mem_block_under_node_early(), up to memory38524, the
> first pfn correctly returns the corresponding nid and the function
> returns from there. But after memory38524 and until memory128433,
> the loop iterates through each pfn and checks the nid. Since the nid
> does not match the required nid, the loop continues. This causes
> the soft lockups.
> 
> [1]: https://lore.kernel.org/linuxppc-dev/20241116192306.88217-1-sshegde@linux.ibm.com/
> Fixes: 2848a28b0a60 ("drivers/base/node: consolidate node device subsystem initialization in node_dev_init()")

That commit only moved code; so very likely, that is not the problematic 
commit.


> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> ---
>   drivers/base/node.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 0ea653fa3433..107eb508e28e 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -975,5 +975,6 @@ void __init node_dev_init(void)
>   		ret = register_one_node(i);
>   		if (ret)
>   			panic("%s() failed to add node: %d\n", __func__, ret);
> +		cond_resched();
>   	}
>   }


-- 
Cheers,

David / dhildenb


