Return-Path: <linux-kernel+bounces-265377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D7A93F057
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 10:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 660651F22DAD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A8713D265;
	Mon, 29 Jul 2024 08:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="SipMmx8X"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1E7139D12
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 08:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722243172; cv=none; b=mxGHavW75Gke+rphTFVFlJF2bFiJ3pJwziKX72SzCsjCYIaL8NeK0ylzgTu30VZy2Cf9R6R7WGBeGpMR7XP+VnA5KFm3CjP23DhWf8vAL+O/Cg3S2QhZe8KbS4FhtMEuCH8A/GMnRiqd/9tAwRbiNe/jHb6aJYQzt2T71hQBH9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722243172; c=relaxed/simple;
	bh=YC++kQDQqPNKLYEc29xmI7hMvB2BFw/pz2yLknbtGJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ghecx26EMHRrfi5qXHuG6fkhjLEf0ynZVvNe7Dkdn5HJM52qvPgrL9bYKBuAzmfiOLcUUY9e88xDpB4nq2qN5IHT0IwifckqvChDXe+LWbXK7MvZICM3oL32BLsA3Nbnb5U5On1dZGsXHEpwVQO3eedpx8lpJsSjr2Qql7miRSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=SipMmx8X; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2cb4e1dca7aso617084a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 01:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722243169; x=1722847969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bwy22zocUuX93+ONQXiNwUNSliVIGdLep8Ilhq4sGGY=;
        b=SipMmx8XFKQ/l43DUW6KVD8g6Nizlmv0PP8AyHcJE7s1vg6QWTHZC9K+ZHnqqo0/TJ
         UTjwOI3B/40p4Y79GhKSzuejGb9hAT5Fv6SZJUum+dyOfVYaYd2EXi450a3rkMT+cbbL
         dUo5bA/pDDiX0rfjZPl82BiE2GwOI+u3xoxS/yo3jrtiMnBvjP/M3St4/FWa43N7upUt
         A27NoUZThKkBCITx1wc55VxX6dlNfZWPgMuEiHi0DIR5yzCtnduXyB3b6vxPPi6gmykz
         dZCHp1pg9XcLKxaTsS0UdbEYgTJ5JeVfKmYb2n9F9lWv6zTZ8nK8jf3J8eEB+U5civi2
         IyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722243169; x=1722847969;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bwy22zocUuX93+ONQXiNwUNSliVIGdLep8Ilhq4sGGY=;
        b=VICw4OsKIRuQNJ/QfhUlq5NfGPvh1EDOAZk15CLSHv5Nir2OAYT+z0g6p+nVLd2Anv
         kXKsW4brigDkViBREl17Y0Vb2PoxIVVKUeI9ePsdkoUlUvj8R7OcRGaWJwXKfA3up0Fx
         exzjK/Y8yRhrB92LG/FR/oPZ8GkdNZb0vR9ptR63fTToomKkxmZPK45Q5CQJ1eGUtHbK
         8qIYwqwCfrGji4WrNWDIUWKBp/h2HaAO9+WA8V9FiPNwM43uLnP3b8PBIoxkQ0XdcpcY
         yJ7buWNMwcN4rmg2gv7HqYMube2/TiSKl36rI3rc933mkxTT+vgNjMdIw+RqbbIdac1a
         Kwqg==
X-Gm-Message-State: AOJu0YxzBALafqxSllDnhbZfwwJFfUcj3z/Ai7GggBu9qzX4NFHh8N2n
	322/HP9IkDvlDOgGxI5b9ZlZN6vbAsp3B77ZrJFM2+HEZMse8y61TyeFv/2ueczZr4PAN3mAzQi
	p
X-Google-Smtp-Source: AGHT+IFkmB1l+wjpZUszQ3u2ixYrhaPDUo4qcydMIVUBmHHd8vkjvarPmTReJYy2tlqntC/cggnGtA==
X-Received: by 2002:a17:902:e544:b0:1fc:5b41:bac9 with SMTP id d9443c01a7336-1fed6cca233mr94301525ad.7.1722243169421;
        Mon, 29 Jul 2024 01:52:49 -0700 (PDT)
Received: from [10.255.168.175] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee15b6sm77097035ad.125.2024.07.29.01.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 01:52:49 -0700 (PDT)
Message-ID: <6edb1aa3-ea72-49fd-9aaf-189ad6b61ee5@bytedance.com>
Date: Mon, 29 Jul 2024 16:52:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] mm: let pte_lockptr() consume a pte_t pointer
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>, Peter Xu <peterx@redhat.com>,
 Oscar Salvador <osalvador@suse.de>
References: <20240725183955.2268884-1-david@redhat.com>
 <20240725183955.2268884-2-david@redhat.com>
 <100ecc66-c2ce-4dbb-8600-d782e75ab69c@bytedance.com>
 <498c936f-fa30-4670-9bbc-4cd8b7995091@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <498c936f-fa30-4670-9bbc-4cd8b7995091@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/7/29 16:46, David Hildenbrand wrote:
> On 29.07.24 09:48, Qi Zheng wrote:
>>
>>
>> On 2024/7/26 02:39, David Hildenbrand wrote:
>>> pte_lockptr() is the only *_lockptr() function that doesn't consume
>>> what would be expected: it consumes a pmd_t pointer instead of a pte_t
>>> pointer.
>>>
>>> Let's change that. The two callers in pgtable-generic.c are easily
>>> adjusted. Adjust khugepaged.c:retract_page_tables() to simply do a
>>> pte_offset_map_nolock() to obtain the lock, even though we won't 
>>> actually
>>> be traversing the page table.
>>>
>>> This makes the code more similar to the other variants and avoids other
>>> hacks to make the new pte_lockptr() version happy. pte_lockptr() users
>>> reside now only in  pgtable-generic.c.
>>>
>>> Maybe, using pte_offset_map_nolock() is the right thing to do because
>>> the PTE table could have been removed in the meantime? At least it 
>>> sounds
>>> more future proof if we ever have other means of page table reclaim.
>>
>> Agree, this helps us recheck the pmd entry.
>>
>>>
>>> It's not quite clear if holding the PTE table lock is really required:
>>> what if someone else obtains the lock just after we unlock it? But we'll
>>> leave that as is for now, maybe there are good reasons.
>>>
>>> This is a preparation for adapting hugetlb page table locking logic to
>>> take the same locks as core-mm page table walkers would.
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>    include/linux/mm.h   |  7 ++++---
>>>    mm/khugepaged.c      | 21 +++++++++++++++------
>>>    mm/pgtable-generic.c |  4 ++--
>>>    3 files changed, 21 insertions(+), 11 deletions(-)
>>
>> Since pte_lockptr() no longer has a pmd parameter, it is best to modify
>> the comments above __pte_offset_map_lock() as well:
>>
>> ```
>> This helps the caller to avoid a later pte_lockptr(mm, *pmd), which
>> might by that time act on a changed *pmd ...
>> ```
> 
> Right, thanks a lot for the review!
> 
> The following on top;
> 
> 
>  From a46b16aa9bfa02ffb425d364d7f00129a8e803ad Mon Sep 17 00:00:00 2001
> From: David Hildenbrand <david@redhat.com>
> Date: Mon, 29 Jul 2024 10:43:34 +0200
> Subject: [PATCH] fixup: mm: let pte_lockptr() consume a pte_t pointer
> 
> Let's adjust the comment, passing a pte to pte_lockptr() and dropping
> a detail about changed *pmd, which no longer applies.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   mm/pgtable-generic.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
> index 13a7705df3f87..f17465b43d344 100644
> --- a/mm/pgtable-generic.c
> +++ b/mm/pgtable-generic.c
> @@ -350,11 +350,11 @@ pte_t *pte_offset_map_nolock(struct mm_struct *mm, 
> pmd_t *pmd,
>    * pte_offset_map_nolock(mm, pmd, addr, ptlp), above, is like 
> pte_offset_map();
>    * but when successful, it also outputs a pointer to the spinlock in 
> ptlp - as
>    * pte_offset_map_lock() does, but in this case without locking it.  
> This helps
> - * the caller to avoid a later pte_lockptr(mm, *pmd), which might by 
> that time
> - * act on a changed *pmd: pte_offset_map_nolock() provides the correct 
> spinlock
> - * pointer for the page table that it returns.  In principle, the 
> caller should
> - * recheck *pmd once the lock is taken; in practice, no callsite needs 
> that -
> - * either the mmap_lock for write, or pte_same() check on contents, is 
> enough.
> + * the caller to avoid a later pte_lockptr(mm, pte): 
> pte_offset_map_nolock()
> + * provides the correct spinlock pointer for the page table that it 
> returns.
> + * In principle, the caller should recheck *pmd once the lock is taken; in
> + * practice, no callsite needs that - either the mmap_lock for write, or
> + * pte_same() check on contents, is enough.
>    *
>    * Note that free_pgtables(), used after unmapping detached vmas, or when
>    * exiting the whole mm, does not take page table lock before freeing 
> a page

LGTM. Thanks!


