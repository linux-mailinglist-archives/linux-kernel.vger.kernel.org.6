Return-Path: <linux-kernel+bounces-394849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F28E9BB4D4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 156561F21672
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED641B0F33;
	Mon,  4 Nov 2024 12:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F3ccnEBl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FDB18DF85
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 12:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730724136; cv=none; b=J+IN9vlgDn8Ti6veupfsaUytWeRQivEPt9toN7qWShpwrbOHLQY9LkMr5PHaTTFeqfNNp4Ptm+XyoQzQUQ7N7qFKPKcY3OKWvKD91emdsU0iEvm8joWd/voCAyxe+kqdwLKSnZEe/xrwZPkUFCn0VHjNHFvcER6M0vpX+tFx8Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730724136; c=relaxed/simple;
	bh=juC2/8mEtrBKv1BFu9ui8/tm+ihZ8Fhb6sJJoyOewSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ltvYlHMqFJmKlq/6LGslHp4DQe1ymVoJN3BYZnVkIYWL7Sj5HHo47qU0HDsUkZrPO0eFpDG4JsyEmwu5vhWW8tYsl5PNAE7XULphO5N+Pmtfv4tpZLYd8QEQZB1o4AJjng/b4nNxqg4RTIqHrJ2s+Ft+CMU0rgAuKJOj77cWKjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F3ccnEBl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730724133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eDd0KxjJu86IwOwMzxFa6FRdzavFonq/Ryl2BYNzOfs=;
	b=F3ccnEBlSuI39DV4hrbgX0h8zX37VWfzEhNLtCvjEA3ATD8iNa7+LfwXyEGz9V+jOYgdJW
	fM0i1l8DO+LTITetddUlyTzxGd1nI4FAJAueqb5e77GUXHGD8itRb5fhkGx8ZqLrOswyKt
	f/D18ctAv97GZ4lgpsVVpVd9I72WiB8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-xB-ObDMUMXGWkiqBalXjDg-1; Mon, 04 Nov 2024 07:42:11 -0500
X-MC-Unique: xB-ObDMUMXGWkiqBalXjDg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d47127e69so1748083f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 04:42:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730724130; x=1731328930;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eDd0KxjJu86IwOwMzxFa6FRdzavFonq/Ryl2BYNzOfs=;
        b=A0k87Duq/AdQduO2vkzvJa1+x3ZCgBaxe1hFbS8Uao5jkZZraeBPR4SPtXu306FWNH
         KCDx1SVH94kmnHnJ2rNAPxWbNxUW90mt9vwtb0EOzHccD9QiwWMGo69gkiPylD+2U2N1
         kmDEz9RIR86FAO7Tzx0nAX3iJ38Mdce0rea2DHkI2xRfAscOfmf4TArrYEfZt8KGsvj2
         j6PKApcn6d3u5UH8UwnyruxhiK1TDWLcA7rNR1QyW2SGaDK+yZZJWteoxKONVmqxQhkI
         Fj7UXT94qK7n500cU8DAKzAg+ZC8MVvSjJfgGFXmB/4uxn5PEDvf/dFM7fJ0x1ldoAnX
         WOfQ==
X-Gm-Message-State: AOJu0YwvKuHmWY4NmqrzzergniGFK4nJ2vLbhdSnjabcy9jaU5036sq7
	9onrKjm0dJw6zbBvz6yxjJUODRGr6BN0nRX/CX4rLX5G9Tb6CzofnBIeD71kWax+jwyrlzfXoqm
	3zzdxkQ3fovjoeAIK/8q+6R4agjiUrOY9U877Y5io5QMFs67cLkNrWIP49XTUWg==
X-Received: by 2002:a5d:6585:0:b0:37d:4e74:684 with SMTP id ffacd0b85a97d-38061220a76mr24641238f8f.52.1730724130613;
        Mon, 04 Nov 2024 04:42:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJhNySyirZaB9jbY+VsaQ0cZcKnAopNI5Gi4jbY35qkLlmBOJpVSKcWm481TZyC0ODd1OuWA==
X-Received: by 2002:a5d:6585:0:b0:37d:4e74:684 with SMTP id ffacd0b85a97d-38061220a76mr24641208f8f.52.1730724130192;
        Mon, 04 Nov 2024 04:42:10 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d4d82sm13124659f8f.45.2024.11.04.04.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 04:42:09 -0800 (PST)
Message-ID: <c7a90ccf-c1b1-480c-9f2a-88ef37c3d89e@redhat.com>
Date: Mon, 4 Nov 2024 13:42:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: count zeromap read and set for swapout and swapin
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 Usama Arif <usamaarif642@gmail.com>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Hugh Dickins <hughd@google.com>,
 Matthew Wilcox <willy@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Andi Kleen <ak@linux.intel.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>,
 "Huang, Ying" <ying.huang@intel.com>, Kairui Song <kasong@tencent.com>,
 Ryan Roberts <ryan.roberts@arm.com>
References: <20241102101240.35072-1-21cnbao@gmail.com>
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
In-Reply-To: <20241102101240.35072-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02.11.24 11:12, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> When the proportion of folios from the zero map is small, missing their
> accounting may not significantly impact profiling. However, it’s easy
> to construct a scenario where this becomes an issue—for example,
> allocating 1 GB of memory, writing zeros from userspace, followed by
> MADV_PAGEOUT, and then swapping it back in. In this case, the swap-out
> and swap-in counts seem to vanish into a black hole, potentially
> causing semantic ambiguity.
> 
> We have two ways to address this:
> 
> 1. Add a separate counter specifically for the zero map.
> 2. Continue using the current accounting, treating the zero map like
> a normal backend. (This aligns with the current behavior of zRAM
> when supporting same-page fills at the device level.)
> 
> This patch adopts option 1 as pswpin/pswpout counters are that they
> only apply to IO done directly to the backend device (as noted by
> Nhat Pham).
> 
> We can find these counters from /proc/vmstat (counters for the whole
> system) and memcg's memory.stat (counters for the interested memcg).
> 
> For example:
> 
> $ grep -E 'swpin_zero|swpout_zero' /proc/vmstat
> swpin_zero 1648
> swpout_zero 33536
> 
> $ grep -E 'swpin_zero|swpout_zero' /sys/fs/cgroup/system.slice/memory.stat
> swpin_zero 3905
> swpout_zero 3985
> 
> Fixes: 0ca0c24e3211 ("mm: store zero pages to be swapped out in a bitmap")
> Cc: Usama Arif <usamaarif642@gmail.com>
> Cc: Chengming Zhou <chengming.zhou@linux.dev>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Cc: Nhat Pham <nphamcs@gmail.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Chris Li <chrisl@kernel.org>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Kairui Song <kasong@tencent.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>   -v2:
>   * add separate counters rather than using pswpin/out; thanks
>   for the comments from Usama, David, Yosry and Nhat;
>   * Usama also suggested a new counter like swapped_zero, I
>   prefer that one be separated as an enhancement patch not
>   a hotfix. will probably handle it later on.
> 
>   Documentation/admin-guide/cgroup-v2.rst | 10 ++++++++++
>   include/linux/vm_event_item.h           |  2 ++
>   mm/memcontrol.c                         |  4 ++++
>   mm/page_io.c                            | 16 ++++++++++++++++
>   mm/vmstat.c                             |  2 ++
>   5 files changed, 34 insertions(+)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index db3799f1483e..984eb3c9d05b 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1599,6 +1599,16 @@ The following nested keys are defined.
>   	  pglazyfreed (npn)
>   		Amount of reclaimed lazyfree pages
>   
> +	  swpin_zero
> +		Number of pages moved into memory with zero content, meaning no
> +		copy exists in the backend swapfile, allowing swap-in to avoid
> +		I/O read overhead.
> +
> +	  swpout_zero
> +		Number of pages moved out of memory with zero content, meaning no
> +		copy is needed in the backend swapfile, allowing swap-out to avoid
> +		I/O write overhead.

Hm, can make it a bit clearer that this is a pure optimization and refer 
to the other counters?

swpin_zero
	Portion of "pswpin" pages for which I/O was optimized out
	because the page content was detected to be zero during swapout.

swpout_zero
	Portion of "pswout" pages for which I/O was optimized out
	because the page content was detected to be zero.


-- 
Cheers,

David / dhildenb


