Return-Path: <linux-kernel+bounces-432554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E74359E4CE5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 04:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2DB92859F8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 03:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F3F191F9E;
	Thu,  5 Dec 2024 03:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WXoNeh4T"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E422391A6
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 03:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733370974; cv=none; b=BKdJSGH5v0CxtL9jNvLK3RFhTbBt1YrD3iRQ5nAx2DAmxq+8lVE05Jwymc3LGTlqfJW2KB8KMj2vei/K7MdkMu12a4uvas7MD3URK/dryGP+6fazyx28pnY6YdGIZmS+7TTMmxyhhBzaZPuSlPKLh1bKG7WlVlGKTBQ6ciTpL6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733370974; c=relaxed/simple;
	bh=CZ0Sc1LAhWz1Aa5FyuS8CdVeXwCPYIEBFLzm82C3cE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ff1BzRcw2rd04kKA46K/1v4d06qACdZI+xmeEaOpydq8XhyDdg7bvbo8U1TMNCkrpRzMMZSo+qll7x6ZNZvSX+XM2fHqBAakHM6QHVt791RrmOrPABI+T3JceoMygDP+2s/q9//AlzGIc1+rV6q2mdB0tZtanoNHWfjB5lhkLE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WXoNeh4T; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-71d5ef7daf1so275503a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 19:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733370971; x=1733975771; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D+MHg4FHabFUV6Q6eJzYqt3B02UulSEorGl1Vg94z4o=;
        b=WXoNeh4TGzpKL9+Ytl1W8eEdEWqqOlVz4Rgjxnrgf26RWf3qBrMFnJ96ztK+M2NjlH
         7g6vse7zpdX20BpZcu/gVx+I2qqyBa0L7tKFDeke8IeuzdnSXclZoQfXIdCXFNKND/h8
         0HfJoVjee381kYwTxrATCc+Twd6VOss/LINCNUZatWKAcpa8QVAdgoMbEb2RmjD+jb2k
         uR9i0IROaQ/RhV1fBrcBblTbAX6YougPSScdc3wvyyqexdB5PK0GU5OIXIxa90OZH3sF
         XzJ/m2chMWo2ZfbKYI5/6RWJEGmZZh4wNvylfj2k8WHiDgE0IHa6euA7E0hqq7j1fGWz
         XVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733370971; x=1733975771;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D+MHg4FHabFUV6Q6eJzYqt3B02UulSEorGl1Vg94z4o=;
        b=u/QcVHth9HCubY8DY2IaVZa3l6lb6GQhAbmgbzy880oqU75Wjq6Io5Ywt08teFhvsb
         kWsuqeL7cW75zTMpMYXlVNzWtFcQZi+qs6sBZy0lOmP7y9zGtbP7VvBFrI/UUH8Gt8Nt
         6EpjL+NsN318AxSH9K2tcx58jWi/UNEop1enMDmfQwUzDwlUoq3ySgfHLqBfKfdEvgBA
         7n+yMqecSfS9WRetkMle4+5rrvXSGTMfSmNm/rC5iV8qBi2gYomNGCAlrgq38RqjM2Jw
         lK3DOUBEI9Wps/oVLxf0EGt78nKaCdb6Skkm4czTz4Or3ba4LqumYL+CSAP2Y+HKwoQQ
         8aXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT/g1XMXFASxZ/4Im5YuD/nfUXM6QnpJyEFqs1FzOASTAGev/0LUyl7XFqEnhFf7SYBse+97yZ3Bs4eu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH5xCwOa09u4DMafh/twop0jKmneVCW94d2QU7DBHNkUqxPt2h
	z/V76ZLIwxMDOmQD88dKL/CzCzqh6Tr3ilREIpeaNFBKGV8xooyC0vP/BOtwlTk=
X-Gm-Gg: ASbGnctN855wmtaYprcpiDr8IrppYvY8/0dM2ioBhZBz2VxV/x1Nw5BOSoIdzgmtjXX
	IYoGWjkp8kiY6FItS5fp1iwQXry4/qht+5ELZtE1n2tyI9527E7SF4njRzKEQEjfpESyC+ytaiI
	bhEjMAVXgGGI9rUKY5BPMai/ftDfVlydcJbhw3om8spM0cirw+K2TbYxd1kVm2d0u6ktrfUlTN6
	14PPME56Pfw3S7e6NXxYjGbpqnzzJv4NPzIMFprR7/vbUARDzrG8Aw+HA8YDcFrzGFArsxnP3M=
X-Google-Smtp-Source: AGHT+IGh2tp+pVzEke/ezAOKVA16saOxak1tg0Yxh9VN5xk2GfwEcelkgEAfMGxTFzaJKEdpBaW5Ww==
X-Received: by 2002:a05:6830:6319:b0:71a:4b13:c561 with SMTP id 46e09a7af769-71dad652b59mr10641522a34.16.1733370971372;
        Wed, 04 Dec 2024 19:56:11 -0800 (PST)
Received: from [10.84.148.23] ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd157d87d2sm268234a12.70.2024.12.04.19.56.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 19:56:10 -0800 (PST)
Message-ID: <0ca36b2e-463e-493f-aede-aff9aec3c7fa@bytedance.com>
Date: Thu, 5 Dec 2024 11:56:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/11] synchronously scan and reclaim empty user PTE
 pages
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
Cc: david@redhat.com, jannh@google.com, hughd@google.com,
 willy@infradead.org, muchun.song@linux.dev, vbabka@kernel.org,
 peterx@redhat.com, mgorman@suse.de, catalin.marinas@arm.com,
 will@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
 peterz@infradead.org, x86@kernel.org, lorenzo.stoakes@oracle.com,
 zokeefe@google.com, rientjes@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1733305182.git.zhengqi.arch@bytedance.com>
 <20241204144918.b08dbdd99903d3e18a27eb44@linux-foundation.org>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20241204144918.b08dbdd99903d3e18a27eb44@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/12/5 06:49, Andrew Morton wrote:
> On Wed,  4 Dec 2024 19:09:40 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
>>
>> ...
>>
>> Previously, we tried to use a completely asynchronous method to reclaim empty
>> user PTE pages [1]. After discussing with David Hildenbrand, we decided to
>> implement synchronous reclaimation in the case of madvise(MADV_DONTNEED) as the
>> first step.
> 
> Please help us understand what the other steps are.  Because we dont
> want to commit to a particular partial implementation only to later
> discover that completing that implementation causes us problems.

Although it is the first step, it is relatively independent because it
solve the problem (huge PTE memory usage) in the case of
madvise(MADV_DONTNEED), while the other steps are to solve the problem
in other cases.

I can briefly describe all the plans in my mind here:

First step
==========

I plan to implement synchronous empty user PTE pages reclamation in
madvise(MADV_DONTNEED) case for the following reasons:

1. It covers most of the known cases. (On ByteDance server, all the
    problems of huge PTE memory usage are in this case)
2. It helps verify the lock protection scheme and other infrastructure.

This is what this patch is doing (only support x86). Once this is done,
support for more architectures will be added.

Second step
===========

I plan to implement asynchronous reclamation for madvise(MADV_FREE) and
other cases. The initial idea is to mark vma first, then add the
corresponding mm to a global linked list, and then perform asynchronous
scanning and reclamation in the memory reclamation process.

Third step
==========

Based on the above infrastructure, we may try to reclaim all full-zero
PTE pages (all pte entries map zero page), which will be beneficial to
the memory balloon case mentioned by David Hildenbrand.

Another plan
============

Currently, page table modification are protected by page table locks
(page_table_lock or split pmd/pte lock), but the life cycle of page
table pages are protected by mmap_lock (and vma lock). For more details,
please refer to the latest added Documentation/mm/process_addrs.rst file.

Currently we try to free the PTE pages through RCU when
CONFIG_PT_RECLAIM is turned on. In this case, we will no longer
need to hold mmap_lock for the read/write op on the PTE pages.

So maybe we can remove the page table from the protection of the mmap
lock (which is too big), like this:

1. free all levels of page table pages by RCU, not just PTE pages, but
    also pmd, pud, etc.
2. similar to pte_offset_map/pte_unmap, add
    [pmd|pud]_offset_map/[pmd|pud]_unmap, and make them all contain
    rcu_read_lock/rcu_read_unlcok, and make them accept failure.

In this way, we no longer need the mmap lock. For readers, such as page
table wallers, we are already in the critical section of RCU. For
writers, we only need to hold the page table lock.

But there is a difficulty here, that is, the RCU critical section is not
allowed to sleep, but it is possible to sleep in the callback function
of .pmd_entry, such as mmu_notifier_invalidate_range_start().

Use SRCU instead? Or use RCU + refcount method? Not sure. But I think
it's an interesting thing to try.

Thanks!

