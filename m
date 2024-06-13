Return-Path: <linux-kernel+bounces-212912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E77290681B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 043281C2194C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F98113D60D;
	Thu, 13 Jun 2024 09:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QyuCzgRw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1CC84D03
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 09:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718269506; cv=none; b=MQqBPTcwGXEEHDx1ySfAcsVN5nLrG9SFwOS9LI6HAI50ki4uFjcwQIVOurQYQ/5aPNir8isNYHxZFTMqWG05O8YdPm8v84eXLjWTF7obL1mEn6Yan+MiJY2ThH9CqurunOciX2rnkSwY8l6orGage1859izntKXFQd8rg7jvL6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718269506; c=relaxed/simple;
	bh=MdhqihriGSyyzJGW+XsVT1Bju1yDrGMTk2k3v0AS3T8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=unUY+EcKgC5mpcNvdcegW8QG5fHtVmO7L2O1YHJ6KjBhxfHTOY0sPcpOf6GMt8moP6szU+a7GiNf/sq1CXd7FrT2EzHUyn0zwRO5W6WxVwEg+DmguHczwFs9uF9+Fjd9eatW8m/or7x+MTbuC6FXdSfRc4sVu6ual69Q7zFLsA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QyuCzgRw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718269503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=L2iCLCOjcA1YBzku/Q3XnBLnag2/sQG3QlilivKaTcA=;
	b=QyuCzgRwmlRc+jQM+mpdeuiNwd90UzlMSzoOMyS2Lxjj0J2yavKGCEWC5a55D+K8G2OxEy
	rCtdFqcYoR1gPMAwGUKAAsg754c18aauM/PRTjt1ZCf62dTBPKySMLqSoJoL+fpxogGJTN
	UjRkc0jTUD3VfviNkx8V1TToHFoq71w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-pMjEcJRIMJqqx285JTDIEA-1; Thu, 13 Jun 2024 05:05:01 -0400
X-MC-Unique: pMjEcJRIMJqqx285JTDIEA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4227e29cd39so4901275e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 02:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718269500; x=1718874300;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2iCLCOjcA1YBzku/Q3XnBLnag2/sQG3QlilivKaTcA=;
        b=fRsBeCodm0Cf7GHIDq5WjXhxrG0hdneNFufiJhiEQ3s0hfKShCU7eA5bVgZLCHL+GY
         wdLydluv4Jf/PJucVBS/yDNL5ONQk5EBZSsxOO5SfU/hFYlxUxgBj2lrReXNXqkF190i
         uGV9HiowAFm8kx1butsN4aEoXXgWjz7qYH3TYM8/yqaGWRh1WwFIeeiVIRULqOM7XDLm
         g2QkjUd/wpOSIMGsHCddeZ5e7TmXk+MT8rEP3UXfQcKJwrddMt0ZGtiG/ScIiMuwEIhA
         xFUOz2v3hkRrV7FR9F7hL1PkH92TFXSnX3PKvXF7K+g5EP8RxKux1YJ2s6QaDTyuxPI4
         4VHw==
X-Forwarded-Encrypted: i=1; AJvYcCUYbaQM6lQnCwDI98onMerCFU0p4LoUvDDuhZAYafnclBjai7RZ+moSgvcu72GiRB52/mTS142AkhevM9K1kxBrZN3K6Teqbi7Fd8lw
X-Gm-Message-State: AOJu0YwDz9sExrX7cf4vMy1Ob+Sq4nNSaJpuiIYMc/DIl7miA+8wr2P3
	4O3//IKeeWySF0TCU5Alr8b4hBTdHnS31UrS9Bzw+chzFeHwfrKGm8ZZfmomUlAFb0YnE+4FKbl
	p2jwZyvdqvOt8r9O9fN2kpa+3Vy2tOaAHCyo4PfRBMc8E45vb5JQOzMhzl63OvA==
X-Received: by 2002:a05:600c:4691:b0:422:5d3c:3c97 with SMTP id 5b1f17b1804b1-422861aeccbmr34068085e9.5.1718269499690;
        Thu, 13 Jun 2024 02:04:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJn9hV1Vb4RGn/i4U1oaPDdafMU20s7OZY2Z2MHCPMO5gbyrfuyWBbYtwRM696gw1QvOuUSg==
X-Received: by 2002:a05:600c:4691:b0:422:5d3c:3c97 with SMTP id 5b1f17b1804b1-422861aeccbmr34067955e9.5.1718269499232;
        Thu, 13 Jun 2024 02:04:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:fe00:10fe:298:6bf1:d163? (p200300cbc703fe0010fe02986bf1d163.dip0.t-ipconnect.de. [2003:cb:c703:fe00:10fe:298:6bf1:d163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f602feb0sm15959035e9.20.2024.06.13.02.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 02:04:58 -0700 (PDT)
Message-ID: <02f8cbd0-8b2b-4c2d-ad96-f854d25bf3c2@redhat.com>
Date: Thu, 13 Jun 2024 11:04:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] asynchronously scan and free empty user PTE pages
To: Qi Zheng <zhengqi.arch@bytedance.com>, hughd@google.com,
 willy@infradead.org, mgorman@suse.de, muchun.song@linux.dev,
 akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1718267194.git.zhengqi.arch@bytedance.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <cover.1718267194.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.06.24 10:38, Qi Zheng wrote:
> Hi all,
> 
> This series aims to asynchronously scan and free empty user PTE pages.
> 
> 1. Background
> =============
> 
> We often find huge user PTE memory usage on our servers, such as the following:
> 
>          VIRT:  55t
>          RES:   590g
>          VmPTE: 110g
>          
> The root cause is that these processes use some high-performance mmeory
> allocators (such as jemalloc, tcmalloc, etc). These memory allocators use
> madvise(MADV_DONTNEED or MADV_FREE) to release physical memory, but neither
> MADV_DONTNEED nor MADV_FREE will release page table memory, which may cause
> huge page table memory usage.
> 
> This issue has been discussed on LSFMM 2022 (led by David Hildenbrand):
> 
>          topic link: https://lore.kernel.org/linux-mm/7b908208-02f8-6fde-4dfc-13d5e00310a6@redhat.com/
>          youtube link: https://www.youtube.com/watch?v=naO_BRhcU68
>          
> In the past, I have tried to introduce refcount for PTE pages to solve this
> problem, but these methods [1][2][3] introduced too much complexity.
> 
> [1]. https://lore.kernel.org/lkml/20211110105428.32458-1-zhengqi.arch@bytedance.com/
> [2]. https://lore.kernel.org/lkml/20220429133552.33768-1-zhengqi.arch@bytedance.com/
> [3]. https://lore.kernel.org/lkml/20220825101037.96517-1-zhengqi.arch@bytedance.com/
> 
> 2. Infrastructure
> =================
> 
> Later, in order to freeing retracted page table, Hugh Dickins added a lot of
> PTE-related infrastructure[4][5][6]:
> 
>      - allow pte_offset_map_lock() etc to fail
>      - make PTE pages can be removed without mmap or rmap locks
>        (see collapse_pte_mapped_thp() and retract_page_tables())
>      - make PTE pages can be freed by RCU (via pte_free_defer())
>      - etc
>      
> These are all beneficial to freeing empty PTE pages.
> 
> [4]. https://lore.kernel.org/all/a4963be9-7aa6-350-66d0-2ba843e1af44@google.com/
> [5]. https://lore.kernel.org/all/c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com/
> [6]. https://lore.kernel.org/all/7cd843a9-aa80-14f-5eb2-33427363c20@google.com/
> 

I'm a big fan for virtio-mem.


> 3. Implementation
> =================
> 
> For empty user PTE pages, we don't actually need to free it immediately, nor do
> we need to free all of it.
> 
> Therefore, in this patchset, we register a task_work for the user tasks to
> asyncronously scan and free empty PTE pages when they return to user space.
> (The scanning time interval and address space size can be adjusted.)

The question is, if we really have to scan asynchronously, or if would 
be reasonable for most use cases to trigger a madvise(MADV_PT_RECLAIM) 
every now and then. For virtio-mem, and likely most memory allocators, 
that might be feasible, and valuable independent of system-wide 
automatic scanning.

> 
> When scanning, we can filter out some unsuitable vmas:
> 
>      - VM_HUGETLB vma
>      - VM_UFFD_WP vma

Why is UFFD_WP unsuitable? It should be suitable as long as you make 
sure to really only remove page tables that are all pte_none().

>      - etc
>      
> And for some PTE pages that spans multiple vmas, we can also skip.
> 
> For locking:
> 
>      - use the mmap read lock to traverse the vma tree and pgtable
>      - use pmd lock for clearing pmd entry
>      - use pte lock for checking empty PTE page, and release it after clearing
>        pmd entry, then we can capture the changed pmd in pte_offset_map_lock()
>        etc after holding this pte lock. Thanks to this, we don't need to hold the
>        rmap-related locks.
>      - users of pte_offset_map_lock() etc all expect the PTE page to be stable by
>        using rcu lock, so use pte_free_defer() to free PTE pages.
>     

I once had a protoype that would scan similar to GUP-fast, using the 
mmap lock in read mode and disabling local IRQs and then walking the 
page table locklessly (no PTLs). Only when identifying an empty page and 
ripping out the page table, it would have to do more heavy locking (back 
when we required the mmap lock in write mode and other things).

I can try digging up that patch if you're interested.

We'll have to double check whether all anon memory cases can *properly* 
handle pte_offset_map_lock() failing (not just handling it, but doing 
the right thing; most of that anon-only code didn't ever run into that 
issue so far, so these code paths were likely never triggered).


> For the path that will also free PTE pages in THP, we need to recheck whether the
> content of pmd entry is valid after holding pmd lock or pte lock.
> 
> 4. TODO
> =======
> 
> Some applications may be concerned about the overhead of scanning and rebuilding
> page tables, so the following features are considered for implementation in the
> future:
> 
>      - add per-process switch (via prctl)
>      - add a madvise option (like THP)
>      - add MM_PGTABLE_SCAN_DELAY/MM_PGTABLE_SCAN_SIZE control (via procfs file)
>      
> Perhaps we can add the refcount to PTE pages in the future as well, which would
> help improve the scanning speed.

I didn't like the added complexity last time, and the problem of 
handling situations where we squeeze multiple page tables into a single 
"struct page".

-- 
Cheers,

David / dhildenb


