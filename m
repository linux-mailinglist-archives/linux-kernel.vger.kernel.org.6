Return-Path: <linux-kernel+bounces-279996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E46094C44B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 20:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0D37B23254
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B94148848;
	Thu,  8 Aug 2024 18:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KOX2JyV2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3159147C86
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 18:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723141606; cv=none; b=pgCwFW5N3QvBk0fB8uiuGwLzqmMlWnkaGODwebCle+cond2Hg73jorzOha5q1z7U9KKUEBLjeQFHGel9XkBDCmvjM69EheMhd3mTN0ReDSgz5tDUbSFc9dYltDH7VO57hUMEGAXJE1yE1mN7tUCr1gbNn9kQkV/XmDsCLqp79NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723141606; c=relaxed/simple;
	bh=aGLgDiP/PDM3aKLvPcBwDM071s82L58DhQMCmBzJaPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NKM+ltMjKnbPp1q40kVttQpuuO/LdzkX7aSK1ZQ4CMpS8fpzql4t/UkTsdFOrF3I3ua5brfE1Z6dX8X+NQSPepa31ladUGL0Afi6X+ifLq4TW/DUIlVaU5hANlBnduJ0EIzAcjSvAa+xinizxtrT+A4LdIchCy57C7e/8afh2IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KOX2JyV2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723141603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oPdap2Cj58/bdcNangvbuKkQN3ShkoAAH7Mn0q0r4fY=;
	b=KOX2JyV2Gw5/yhJgR7vxrUfa/2/aDEZifUz0cIlf+ap6l+Nw0D6mzaRaQp2AWPHBaT8IoN
	g737ap0leMzjZq8yVvqHHZ1siRscpFTRNlafEGc7gXa4euvKRafJh/QdJ1z3i4GAb4ED/C
	pz8J7hv6Aru1alCfNhdva2682QGcks4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-9qKy8ZbFO9uai0t9FBII7Q-1; Thu, 08 Aug 2024 14:26:42 -0400
X-MC-Unique: 9qKy8ZbFO9uai0t9FBII7Q-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42808685ef0so8633175e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 11:26:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723141601; x=1723746401;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPdap2Cj58/bdcNangvbuKkQN3ShkoAAH7Mn0q0r4fY=;
        b=iEtsOrOeveoWR4jWKIave8+N5K9JHgqEzdragJ+vkqF4g58hUN/IdlfACN6fjWaqpv
         /5at8idTec2BhWa+V0WtCpGrwb3I954/jDT1hW5f1zryuHSgskAQeHRMtthW6Wl9c3eH
         tucBzGW7tDfgyr/i6qG9wp97CBGpHOpSHAFMZcyaqrWiY4hoCnhcU6LC0PX3GsmJhC8q
         oqSW8ZpMKs27wOnCXhKO92tU1amoOineP0MVIBz13pklAXZzNmsq4sloRdxx3lwJZpNj
         mgo5cjjD6wyNEXE/urOQmBUyS140ImQEYcuG8b09u9wO9Lii7BcMH6AANbxU2S4p+62B
         OftQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJKxvpuXEI4jymghPPYG70mQPWxxc9AfLUcHwSfq7Mn9iLfIW9sBRBVxA/I6ByLlSb9ZcUoWaD+Y5HQgzyjlUYnGFx6Ttz5nn6SWfk
X-Gm-Message-State: AOJu0YzK0SB9/LctX7HtAUzH9rd/W8GpXqRdZFkhhRpKci0aRvRKamBg
	vD6uuCoSHl6JAO/FpMS4kJiF/ZLoGokzZsP747zq9zqMB/OIOnxOnZossM7GIqgCT+afR9nbzwm
	am5esuebOrGOfBvgig7MTU0ffqU88OcW8AXMDHG8fXrTGVQepdcWuCxopBntkBw==
X-Received: by 2002:a05:600c:8515:b0:428:387:79ac with SMTP id 5b1f17b1804b1-4290d7d74e8mr11427575e9.6.1723141600835;
        Thu, 08 Aug 2024 11:26:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHP73emNCQDdWv2KlFW9rCMi1DOUNBEBL6z1+LJwr/UDfUfIx6wmqyICQgAwvUcoNjIIDsz1w==
X-Received: by 2002:a05:600c:8515:b0:428:387:79ac with SMTP id 5b1f17b1804b1-4290d7d74e8mr11427405e9.6.1723141600302;
        Thu, 08 Aug 2024 11:26:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c713:2a00:f151:50f1:7164:32e6? (p200300cbc7132a00f15150f1716432e6.dip0.t-ipconnect.de. [2003:cb:c713:2a00:f151:50f1:7164:32e6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c19a1fe4sm82155e9.0.2024.08.08.11.26.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 11:26:39 -0700 (PDT)
Message-ID: <490ae360-50a4-497f-b148-ef077b73e911@redhat.com>
Date: Thu, 8 Aug 2024 20:26:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] mm: don't account memmap per-node
To: Pasha Tatashin <pasha.tatashin@soleen.com>, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-cxl@vger.kernel.org,
 cerasuolodomenico@gmail.com, hannes@cmpxchg.org, j.granados@samsung.com,
 lizhijian@fujitsu.com, muchun.song@linux.dev, nphamcs@gmail.com,
 rientjes@google.com, rppt@kernel.org, souravpanda@google.com,
 vbabka@suse.cz, willy@infradead.org, dan.j.williams@intel.com,
 yi.zhang@redhat.com, alison.schofield@intel.com, yosryahmed@google.com
References: <20240808154237.220029-1-pasha.tatashin@soleen.com>
 <20240808154237.220029-5-pasha.tatashin@soleen.com>
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
In-Reply-To: <20240808154237.220029-5-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>   #ifdef CONFIG_COMPACTION
>   
>   struct contig_page_info {
> @@ -1255,11 +1272,11 @@ const char * const vmstat_text[] = {
>   	"pgdemote_kswapd",
>   	"pgdemote_direct",
>   	"pgdemote_khugepaged",
> -	"nr_memmap",
> -	"nr_memmap_boot",
>   	/* system-wide enum vm_stat_item counters */
>   	"nr_dirty_threshold",
>   	"nr_dirty_background_threshold",
> +	"nr_memmap",
> +	"nr_memmap_boot",

While we're at it (sorry, I should have found more time revieweing this 
earlier!) ...

What is the unit here? Should this be "nr_memmap_pages" / 
"nr_memmap_boot_pages"? Like

$ cat /proc/vmstat  | grep pages
nr_free_pages 3618323
nr_zspages 3
nr_anon_pages 1053316
nr_file_pages 3199210
nr_shmem_hugepages 546
nr_file_hugepages 0
nr_anon_transparent_hugepages 0
nr_page_table_pages 15215
nr_sec_page_table_pages 0
numa_pages_migrated 0


Nothing else jumped at me.

-- 
Cheers,

David / dhildenb


