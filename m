Return-Path: <linux-kernel+bounces-267958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAB0941DE2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A8CB1F27B94
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F75A1A76BF;
	Tue, 30 Jul 2024 17:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BV9NiEb9"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892131A76A1;
	Tue, 30 Jul 2024 17:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722360172; cv=none; b=RCcu0vWHbmjb2h/En0J/pYB0ipfwlwmBikMTW+E7CmeHX9h7RS7l4xN0o2S9sfO6U5GdjnFMLu1DURLBQzbzzeV8QSNZi2JpUBHgVZZ6ybW3oQTZAwpY7ZSsKIHHJWJxDN9P00JWDFk2uV8a1LhC9qu5+XwEyy+aScRkjcgCQcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722360172; c=relaxed/simple;
	bh=Vw/GjoCR4tfIIcezM9LS1NKEKDR9mj8TB2z4q2kAW9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jMY2Qg6qZZRR0Kz5K4D1O9GuTxI/uvTNUtq9taCP+oLSP+dqslconac1I9Z219jZnyzXyyKSLCKgugiByUzQPwUr37RmsWo/WdkElVIJT7vZl1xT2BchZFK1TPHVuXnkiLcby+TFe7BftPk/2vXyw78hkTnuGlumr3f7LXUh+ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BV9NiEb9; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52efa9500e0so5960489e87.3;
        Tue, 30 Jul 2024 10:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722360169; x=1722964969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9SrOWLauCw0n1dZB3h45/pyK2Bmr2sMoKoIxGkx4yOw=;
        b=BV9NiEb9jAPic+xGLe52Ivz10GH3b5z+Q8IDz6zsukt81dTtRALqxBymnSd/8lmwlO
         jcYy+uJLGi2wM7yVNl6vlR+WLx24X+zhXdWApc1zA4blBkqoL14nJwXr9g53kOX4I5TG
         r2792eKSFBqPLzxQy6sMJwLNPbv1eLhctWIsdthXjgi+OUqyW1/akV2qhy7inz4ozaY9
         vV7TjrR8JAcnu1rN/ijVg8pKbtZ2blONY/5wzO2WkTqSMSvkwCbSqXkhM+PoGOpOpldd
         o8eJyT77HfbReD5dcMwqVJG03vON/3UqlKc7c5hb+WRTUE094K98VfzN3W+ji8Pfxzrm
         0DDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722360169; x=1722964969;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9SrOWLauCw0n1dZB3h45/pyK2Bmr2sMoKoIxGkx4yOw=;
        b=YK4BKvwST6F8VhYZ/Jxgf8MJI1JFTwLkarVScV9OAMVI3RxhzoxAg5YuFFdEYGoY6b
         YpTPJDwluuVQ+nfLijVA0jHNcsS5pmm4EAJ/To+cVItMPPtHcRV9hPJUuEGUMATpyFo+
         uWPp9Zs0bY5hWnr/Ya05ojQ/YDGtQaju4vW7aIfazI0ZsbwebcHP6BnSz6p+yIhqLdsR
         M4imqlDlC6xSso9uKKx33Fddld2/53IlTJHF//KBrQj4F1LPT5FZdV0pfeSPeOqTGbgF
         jEzbHj79X1CUXmE5GH9vxTQDcFzF7ut6NfQMOkElwaXGgeyo4oqp7YKnmEAAJccdfynT
         naNg==
X-Forwarded-Encrypted: i=1; AJvYcCVFgwlXygHYrz0D+veOYdczcF+R+TZQsUJGavKWQbDyXLBrJYRV8MI3ogsmyqSFtriJbhjmDNWQYDx0EqBN@vger.kernel.org, AJvYcCXQHco1l/l3xNRAQwDn4dpbbgRewDrvUE4jluszhJJhOYXRcGH7y+Kjjqn91lUEuJ3eSsDqgkkNBNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOfk3AgGzn8LxAzV5K7KPnkMDNy7e4kpHThetFHt0sKs7KeQyu
	l7Oa2gSlOjBYNZyTOvDV3LYpa1J3yCbvDCzZ52qkGnzwNTwYlog4WR6sM7wpbnE=
X-Google-Smtp-Source: AGHT+IGJtevap8SjGgLimtdXlsjljiFbrSf8UAhsdPH88eKRaqwyIl+zlGuqwGhOP+K8Zc+fGj+UwQ==
X-Received: by 2002:ac2:4e05:0:b0:52e:969c:db83 with SMTP id 2adb3069b0e04-5309b26bf0emr7926267e87.17.1722360168092;
        Tue, 30 Jul 2024 10:22:48 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::4:6947])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad414d7sm665498766b.110.2024.07.30.10.22.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 10:22:47 -0700 (PDT)
Message-ID: <01899bc3-1920-4ff2-a470-decd1c282e38@gmail.com>
Date: Tue, 30 Jul 2024 18:22:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] mm: split underutilized THPs
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev,
 roman.gushchin@linux.dev, yuzhao@google.com, baohua@kernel.org,
 ryan.roberts@arm.com, rppt@kernel.org, willy@infradead.org,
 cerasuolodomenico@gmail.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com
References: <20240730125346.1580150-1-usamaarif642@gmail.com>
 <dc00a32f-e4aa-4f48-b82a-176c9f615f3e@redhat.com>
 <3cd1b07d-7b02-4d37-918a-5759b23291fb@gmail.com>
 <73b97a03-3742-472f-9a36-26ba9009d715@gmail.com>
 <95ed1631-ff62-4627-8dc6-332096e673b4@redhat.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <95ed1631-ff62-4627-8dc6-332096e673b4@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 30/07/2024 17:11, David Hildenbrand wrote:
> On 30.07.24 17:19, Usama Arif wrote:
>>
>>
>> On 30/07/2024 16:14, Usama Arif wrote:
>>>
>>>
>>> On 30/07/2024 15:35, David Hildenbrand wrote:
>>>> On 30.07.24 14:45, Usama Arif wrote:
>>>>> The current upstream default policy for THP is always. However, Meta
>>>>> uses madvise in production as the current THP=always policy vastly
>>>>> overprovisions THPs in sparsely accessed memory areas, resulting in
>>>>> excessive memory pressure and premature OOM killing.
>>>>> Using madvise + relying on khugepaged has certain drawbacks over
>>>>> THP=always. Using madvise hints mean THPs aren't "transparent" and
>>>>> require userspace changes. Waiting for khugepaged to scan memory and
>>>>> collapse pages into THP can be slow and unpredictable in terms of performance
>>>>> (i.e. you dont know when the collapse will happen), while production
>>>>> environments require predictable performance. If there is enough memory
>>>>> available, its better for both performance and predictability to have
>>>>> a THP from fault time, i.e. THP=always rather than wait for khugepaged
>>>>> to collapse it, and deal with sparsely populated THPs when the system is
>>>>> running out of memory.
>>>>>
>>>>> This patch-series is an attempt to mitigate the issue of running out of
>>>>> memory when THP is always enabled. During runtime whenever a THP is being
>>>>> faulted in or collapsed by khugepaged, the THP is added to a list.
>>>>> Whenever memory reclaim happens, the kernel runs the deferred_split
>>>>> shrinker which goes through the list and checks if the THP was underutilized,
>>>>> i.e. how many of the base 4K pages of the entire THP were zero-filled.
>>>>> If this number goes above a certain threshold, the shrinker will attempt
>>>>> to split that THP. Then at remap time, the pages that were zero-filled are
>>>>> not remapped, hence saving memory. This method avoids the downside of
>>>>> wasting memory in areas where THP is sparsely filled when THP is always
>>>>> enabled, while still providing the upside THPs like reduced TLB misses without
>>>>> having to use madvise.
>>>>>
>>>>> Meta production workloads that were CPU bound (>99% CPU utilzation) were
>>>>> tested with THP shrinker. The results after 2 hours are as follows:
>>>>>
>>>>>                               | THP=madvise |  THP=always   | THP=always
>>>>>                               |             |               | + shrinker series
>>>>>                               |             |               | + max_ptes_none=409
>>>>> -----------------------------------------------------------------------------
>>>>> Performance improvement     |      -      |    +1.8%      |     +1.7%
>>>>> (over THP=madvise)          |             |               |
>>>>> -----------------------------------------------------------------------------
>>>>> Memory usage                |    54.6G    | 58.8G (+7.7%) |   55.9G (+2.4%)
>>>>> -----------------------------------------------------------------------------
>>>>> max_ptes_none=409 means that any THP that has more than 409 out of 512
>>>>> (80%) zero filled filled pages will be split.
>>>>>
>>>>> To test out the patches, the below commands without the shrinker will
>>>>> invoke OOM killer immediately and kill stress, but will not fail with
>>>>> the shrinker:
>>>>>
>>>>> echo 450 > /sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_none
>>>>> mkdir /sys/fs/cgroup/test
>>>>> echo $$ > /sys/fs/cgroup/test/cgroup.procs
>>>>> echo 20M > /sys/fs/cgroup/test/memory.max
>>>>> echo 0 > /sys/fs/cgroup/test/memory.swap.max
>>>>> # allocate twice memory.max for each stress worker and touch 40/512 of
>>>>> # each THP, i.e. vm-stride 50K.
>>>>> # With the shrinker, max_ptes_none of 470 and below won't invoke OOM
>>>>> # killer.
>>>>> # Without the shrinker, OOM killer is invoked immediately irrespective
>>>>> # of max_ptes_none value and kill stress.
>>>>> stress --vm 1 --vm-bytes 40M --vm-stride 50K
>>>>>
>>>>> Patches 1-2 add back helper functions that were previously removed
>>>>> to operate on page lists (needed by patch 3).
>>>>> Patch 3 is an optimization to free zapped tail pages rather than
>>>>> waiting for page reclaim or migration.
>>>>> Patch 4 is a prerequisite for THP shrinker to not remap zero-filled
>>>>> subpages when splitting THP.
>>>>> Patches 6 adds support for THP shrinker.
>>>>>
>>>>> (This patch-series restarts the work on having a THP shrinker in kernel
>>>>> originally done in
>>>>> https://lore.kernel.org/all/cover.1667454613.git.alexlzhu@fb.com/.
>>>>> The THP shrinker in this series is significantly different than the
>>>>> original one, hence its labelled v1 (although the prerequisite to not
>>>>> remap clean subpages is the same).)
>>>>
>>>> As shared previously, there is one issue with uffd (even when currently not active for a VMA!), where we must not zap present page table entries.
>>>>
>>>> Something that is always possible (assuming no GUP pins of course, which) is replacing the zero-filled subpages by shared zeropages.
>>>>
>>>> Is that being done in this patch set already, or are we creating pte_none() entries?
>>>>
>>>
>>> I think thats done in Patch 4/6. In function try_to_unmap_unused, we have below which I think does what you are suggesting? i.e. point to shared zeropage and not clear pte for uffd armed vma.
>>>
>>>     if (userfaultfd_armed(pvmw->vma)) {
>>>         newpte = pte_mkspecial(pfn_pte(page_to_pfn(ZERO_PAGE(pvmw->address)),
>>>                            pvmw->vma->vm_page_prot));
>>>         ptep_clear_flush(pvmw->vma, pvmw->address, pvmw->pte);
>>>         set_pte_at(pvmw->vma->vm_mm, pvmw->address, pvmw->pte, newpte);
>>>     }
>>
>>
>> Ah are you suggesting userfaultfd_armed(pvmw->vma) will evaluate to false even if its uffd? I think something like below would work in that case.
> 
> I remember one ugly case in QEMU with postcopy live-migration where we must not zap zero-filled pages. I am not 100% regarding THP (if it could be enabled at that point), but imagine the following
> 
> 1) mmap(), enable THP
> 2) Migrate a bunch of pages from the source during precopy (writing to
>    the memory). Might end up creating THPs (during fault/khugepaged)
> 3) Register UFFD on the VMA
> 4) Disable new THPs from forming via MADV_NOHUGEPAGE on the VMA
> 5) Discard any pages that have been re-dirtied or not migrated yet
> 6) Migrate-on-demand any holes using uffd
> 
> 
> If we discard zero-filled pages between 2) and 3) we might get wrong uffd notifications in 6 for pages that have already been migrated).
> 
> I'll have to check if that actually happens in that sequence in QEMU: if QEMU would disable THP right before 2) we would be safe. But I recall that it is not the case :/
> 
> 

Thanks for the example!

Just to understand the issue better, as I am not very familiar with live-migration code, the problem is only for zero-filled pages that were migrated, right? If a THP is created and a subpage of it was a zero-page that was migrated and its split before VMA is armed with uffd, userfaultfd_armed(pvmw->vma) will return false when splitting and it will become pte_none. And afterwards when the destination faults on it, uffd will see that its pte_clear and will request the zero-page back from source. Uffd will then have to get the page again from source.

If I understand the example correctly, the below diff over patch 6 should be good? i.e. just point to the empty_zero_page instead of doing pte_clear. This should still use the same amount of memory, although ptep_clear_flush means it might be slighly more expensive.

diff --git a/mm/migrate.c b/mm/migrate.c
index 2731ac20ff33..52aa4770fbed 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -206,14 +206,10 @@ static bool try_to_unmap_unused(struct page_vma_mapped_walk *pvmw,
        if (dirty)
                return false;
 
-       pte_clear_not_present_full(pvmw->vma->vm_mm, pvmw->address, pvmw->pte, false);
-
-       if (userfaultfd_armed(pvmw->vma)) {
-               newpte = pte_mkspecial(pfn_pte(page_to_pfn(ZERO_PAGE(pvmw->address)),
-                                              pvmw->vma->vm_page_prot));
-               ptep_clear_flush(pvmw->vma, pvmw->address, pvmw->pte);
-               set_pte_at(pvmw->vma->vm_mm, pvmw->address, pvmw->pte, newpte);
-       }
+       newpte = pte_mkspecial(pfn_pte(page_to_pfn(ZERO_PAGE(pvmw->address)),
+                                       pvmw->vma->vm_page_prot));
+       ptep_clear_flush(pvmw->vma, pvmw->address, pvmw->pte);
+       set_pte_at(pvmw->vma->vm_mm, pvmw->address, pvmw->pte, newpte);
 
        dec_mm_counter(pvmw->vma->vm_mm, mm_counter(folio));
        return true;





