Return-Path: <linux-kernel+bounces-269826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEB0943739
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 22:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72219282776
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 20:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB7116C437;
	Wed, 31 Jul 2024 20:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUr/d+Qa"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B631160860;
	Wed, 31 Jul 2024 20:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722458515; cv=none; b=D1S1btLjN5m8S3CFOpgL9T7EKKGdJehtfKR4060rPSm5+xtEE2ZbQlwbtY7Rqlcn5PEixxzsTA/W9GQ8ajEAwGV1GlijAF7gSXjMayudW7ayGdm53lRnfuoAVH1gh2xUtb1pbwT1UJHtuEPPKrzN9Vg1IkXqYidz0/Avl5PnRZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722458515; c=relaxed/simple;
	bh=iOSlMXX89XlnnxEimxWcPlrG8N3L7GEkrhA7OdDiT6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D+X9VRepmn9QBgYpZklVQG2tVZIe3B+HGByi9TKXL/vag3isQJHE+WBWkyom29ZoYfd+fmhif03UGa4DB4EzeTIqesKrXbdcqmizxI+hUxI5GImaZqWFYPDmjyfZuhvQJ2oyJYVirAVJwtkBhSiCQZgwf0iIV4JKxcmQBBwWfcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUr/d+Qa; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4280ee5f1e3so40622175e9.0;
        Wed, 31 Jul 2024 13:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722458511; x=1723063311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=48wMLDUwvHTBVpqJShP8QrDfFrPD8F6V0Js/BwI1e4c=;
        b=TUr/d+QaRZdQncnQWBWa3Ib+1iMxs5QJMP6TwJNVRNVpnT2dLDWBtvwR5R7nMazjp+
         ZqmSDZ+oAguTztd/04QVcAksD017hYNnFqqPfEbfX/3lBG5XbjDnMC9L8DChq2LaMd8p
         /aPVwPJpFhFukWDtj1cu2AhC/7i2xIZ7PR4qjAWhmSCWXVZnBE2Akgxt+Lf7h/F/Hr8C
         YExXFTuuBWil+HOMOT7wfQyi6SAEobgRZZUW/433ViSl4b23DdFsVmSTlYzwQGXpGM1G
         /zYUyRrhMLr+DUx6yeEx3oI4aI1bAhErJNC+aoLTj1Hduth+qdixs21k6k6363/xKXji
         hS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722458511; x=1723063311;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=48wMLDUwvHTBVpqJShP8QrDfFrPD8F6V0Js/BwI1e4c=;
        b=nSZVVVLJTpYhdZXCumFZLsHiReO4HudHyqYLK6Ty3L79p+Th8x8KLbqvmx1wfrKmyg
         PHki5tmqvN6w92ukLV6tc9oKeXoYf/MtBbmmVR5zjgV99yqCRY0JufOSnKS5IFqxx3qR
         lcVFWeghh55ceUKYUwqARRpjh4GgKAdyR36mYDSt6ur4jS0FXjOaSJRsKbzmTWj4r/7q
         l3jTwDJRTlvQ22E/REBZswB5rjQr4KymEU51CHMnrvHG5XXnNyW/PVuD6yivep3a10+/
         OAs3VO5NAH8LCMfnLZkIJKgn/5FiAmB3tHlqV9BOKCl86SzaXUxsHITRQFBYDmNmGztc
         tvVQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9QCo0WaCu5dyQqXGldsrYTZCQC6NvKf9BOfMSPOFtYz2aeK7EizY52knPe04lVKirgzVnFqzg+NFxxXViXZg0T1iZS1x0VcdOZP9bpyOX4Pbta1LMIrzDYqidLj8Y1Xg2Avx7f2m7
X-Gm-Message-State: AOJu0Yx5IQW7mGBmGLzhmXpJAoYrUhESF6fSTeMUJ720CtnmjAKa+JB5
	sYK8hyEkZLhQkMMNIyNb1CJCpEIDxlGLgfzIoIhDi77Isn9C2/8u
X-Google-Smtp-Source: AGHT+IFAo6amvsmE9eVBhwGyCxKmi6bhzB57nVym5OiRkMQBasCPRdZQ9RsP6jp835YRQqoRB8wHkA==
X-Received: by 2002:a05:600c:4684:b0:427:ff3b:7a20 with SMTP id 5b1f17b1804b1-428b4ad2a55mr3500495e9.27.1722458510997;
        Wed, 31 Jul 2024 13:41:50 -0700 (PDT)
Received: from ?IPV6:2a02:6b6a:b75d:0:64:3301:4710:ec21? ([2a02:6b6a:b75d:0:64:3301:4710:ec21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b8a257csm34770345e9.6.2024.07.31.13.41.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 13:41:50 -0700 (PDT)
Message-ID: <204af83b-57ec-40d0-98c0-038bfeb393a3@gmail.com>
Date: Wed, 31 Jul 2024 21:41:49 +0100
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
 <01899bc3-1920-4ff2-a470-decd1c282e38@gmail.com>
 <4b9a9546-e97b-4210-979b-262d8cf37ba0@redhat.com>
 <64c3746a-7b44-4dd6-a51b-e5b90557a30a@gmail.com>
 <fc63e14d-8269-4db8-9ed2-feb2c5b38c6c@redhat.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <fc63e14d-8269-4db8-9ed2-feb2c5b38c6c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 31/07/2024 18:51, David Hildenbrand wrote:
> On 31.07.24 19:01, Usama Arif wrote:
>>
>>
>> On 30/07/2024 21:25, David Hildenbrand wrote:
>>> On 30.07.24 19:22, Usama Arif wrote:
>>>>
>>>>
>>>> On 30/07/2024 17:11, David Hildenbrand wrote:
>>>>> On 30.07.24 17:19, Usama Arif wrote:
>>>>>>
>>>>>>
>>>>>> On 30/07/2024 16:14, Usama Arif wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 30/07/2024 15:35, David Hildenbrand wrote:
>>>>>>>> On 30.07.24 14:45, Usama Arif wrote:
>>>>>>>>> The current upstream default policy for THP is always. However, Meta
>>>>>>>>> uses madvise in production as the current THP=always policy vastly
>>>>>>>>> overprovisions THPs in sparsely accessed memory areas, resulting in
>>>>>>>>> excessive memory pressure and premature OOM killing.
>>>>>>>>> Using madvise + relying on khugepaged has certain drawbacks over
>>>>>>>>> THP=always. Using madvise hints mean THPs aren't "transparent" and
>>>>>>>>> require userspace changes. Waiting for khugepaged to scan memory and
>>>>>>>>> collapse pages into THP can be slow and unpredictable in terms of performance
>>>>>>>>> (i.e. you dont know when the collapse will happen), while production
>>>>>>>>> environments require predictable performance. If there is enough memory
>>>>>>>>> available, its better for both performance and predictability to have
>>>>>>>>> a THP from fault time, i.e. THP=always rather than wait for khugepaged
>>>>>>>>> to collapse it, and deal with sparsely populated THPs when the system is
>>>>>>>>> running out of memory.
>>>>>>>>>
>>>>>>>>> This patch-series is an attempt to mitigate the issue of running out of
>>>>>>>>> memory when THP is always enabled. During runtime whenever a THP is being
>>>>>>>>> faulted in or collapsed by khugepaged, the THP is added to a list.
>>>>>>>>> Whenever memory reclaim happens, the kernel runs the deferred_split
>>>>>>>>> shrinker which goes through the list and checks if the THP was underutilized,
>>>>>>>>> i.e. how many of the base 4K pages of the entire THP were zero-filled.
>>>>>>>>> If this number goes above a certain threshold, the shrinker will attempt
>>>>>>>>> to split that THP. Then at remap time, the pages that were zero-filled are
>>>>>>>>> not remapped, hence saving memory. This method avoids the downside of
>>>>>>>>> wasting memory in areas where THP is sparsely filled when THP is always
>>>>>>>>> enabled, while still providing the upside THPs like reduced TLB misses without
>>>>>>>>> having to use madvise.
>>>>>>>>>
>>>>>>>>> Meta production workloads that were CPU bound (>99% CPU utilzation) were
>>>>>>>>> tested with THP shrinker. The results after 2 hours are as follows:
>>>>>>>>>
>>>>>>>>>                                 | THP=madvise |  THP=always   | THP=always
>>>>>>>>>                                 |             |               | + shrinker series
>>>>>>>>>                                 |             |               | + max_ptes_none=409
>>>>>>>>> -----------------------------------------------------------------------------
>>>>>>>>> Performance improvement     |      -      |    +1.8%      |     +1.7%
>>>>>>>>> (over THP=madvise)          |             |               |
>>>>>>>>> -----------------------------------------------------------------------------
>>>>>>>>> Memory usage                |    54.6G    | 58.8G (+7.7%) |   55.9G (+2.4%)
>>>>>>>>> -----------------------------------------------------------------------------
>>>>>>>>> max_ptes_none=409 means that any THP that has more than 409 out of 512
>>>>>>>>> (80%) zero filled filled pages will be split.
>>>>>>>>>
>>>>>>>>> To test out the patches, the below commands without the shrinker will
>>>>>>>>> invoke OOM killer immediately and kill stress, but will not fail with
>>>>>>>>> the shrinker:
>>>>>>>>>
>>>>>>>>> echo 450 > /sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_none
>>>>>>>>> mkdir /sys/fs/cgroup/test
>>>>>>>>> echo $$ > /sys/fs/cgroup/test/cgroup.procs
>>>>>>>>> echo 20M > /sys/fs/cgroup/test/memory.max
>>>>>>>>> echo 0 > /sys/fs/cgroup/test/memory.swap.max
>>>>>>>>> # allocate twice memory.max for each stress worker and touch 40/512 of
>>>>>>>>> # each THP, i.e. vm-stride 50K.
>>>>>>>>> # With the shrinker, max_ptes_none of 470 and below won't invoke OOM
>>>>>>>>> # killer.
>>>>>>>>> # Without the shrinker, OOM killer is invoked immediately irrespective
>>>>>>>>> # of max_ptes_none value and kill stress.
>>>>>>>>> stress --vm 1 --vm-bytes 40M --vm-stride 50K
>>>>>>>>>
>>>>>>>>> Patches 1-2 add back helper functions that were previously removed
>>>>>>>>> to operate on page lists (needed by patch 3).
>>>>>>>>> Patch 3 is an optimization to free zapped tail pages rather than
>>>>>>>>> waiting for page reclaim or migration.
>>>>>>>>> Patch 4 is a prerequisite for THP shrinker to not remap zero-filled
>>>>>>>>> subpages when splitting THP.
>>>>>>>>> Patches 6 adds support for THP shrinker.
>>>>>>>>>
>>>>>>>>> (This patch-series restarts the work on having a THP shrinker in kernel
>>>>>>>>> originally done in
>>>>>>>>> https://lore.kernel.org/all/cover.1667454613.git.alexlzhu@fb.com/.
>>>>>>>>> The THP shrinker in this series is significantly different than the
>>>>>>>>> original one, hence its labelled v1 (although the prerequisite to not
>>>>>>>>> remap clean subpages is the same).)
>>>>>>>>
>>>>>>>> As shared previously, there is one issue with uffd (even when currently not active for a VMA!), where we must not zap present page table entries.
>>>>>>>>
>>>>>>>> Something that is always possible (assuming no GUP pins of course, which) is replacing the zero-filled subpages by shared zeropages.
>>>>>>>>
>>>>>>>> Is that being done in this patch set already, or are we creating pte_none() entries?
>>>>>>>>
>>>>>>>
>>>>>>> I think thats done in Patch 4/6. In function try_to_unmap_unused, we have below which I think does what you are suggesting? i.e. point to shared zeropage and not clear pte for uffd armed vma.
>>>>>>>
>>>>>>>       if (userfaultfd_armed(pvmw->vma)) {
>>>>>>>           newpte = pte_mkspecial(pfn_pte(page_to_pfn(ZERO_PAGE(pvmw->address)),
>>>>>>>                              pvmw->vma->vm_page_prot));
>>>>>>>           ptep_clear_flush(pvmw->vma, pvmw->address, pvmw->pte);
>>>>>>>           set_pte_at(pvmw->vma->vm_mm, pvmw->address, pvmw->pte, newpte);
>>>>>>>       }
>>>>>>
>>>>>>
>>>>>> Ah are you suggesting userfaultfd_armed(pvmw->vma) will evaluate to false even if its uffd? I think something like below would work in that case.
>>>>>
>>>>> I remember one ugly case in QEMU with postcopy live-migration where we must not zap zero-filled pages. I am not 100% regarding THP (if it could be enabled at that point), but imagine the following
>>>>>
>>>>> 1) mmap(), enable THP
>>>>> 2) Migrate a bunch of pages from the source during precopy (writing to
>>>>>      the memory). Might end up creating THPs (during fault/khugepaged)
>>>>> 3) Register UFFD on the VMA
>>>>> 4) Disable new THPs from forming via MADV_NOHUGEPAGE on the VMA
>>>>> 5) Discard any pages that have been re-dirtied or not migrated yet
>>>>> 6) Migrate-on-demand any holes using uffd
>>>>>
>>>>>
>>>>> If we discard zero-filled pages between 2) and 3) we might get wrong uffd notifications in 6 for pages that have already been migrated).
>>>>>
>>>>> I'll have to check if that actually happens in that sequence in QEMU: if QEMU would disable THP right before 2) we would be safe. But I recall that it is not the case :/
>>>>>
>>>>>
>>>>
>>>> Thanks for the example!
>>>>
>>>> Just to understand the issue better, as I am not very familiar with live-migration code, the problem is only for zero-filled pages that were migrated, right? If a THP is created and a subpage of it was a zero-page that was migrated and its split before VMA is armed with uffd, userfaultfd_armed(pvmw->vma) will return false when splitting and it will become pte_none. And afterwards when the destination faults on it, uffd will see that its pte_clear and will request the zero-page back from source. Uffd will then have to get the page again from source.
>>>
>>> Something like that, but I recall that if it detects that it already migrated the page stuff will go wrong.
>>>
>>> IIRC QEMU maintains receive bitmaps about which pages it already received+placed. Staring at migrate_send_rp_req_pages(), QEMU ignores the uffd notification if it finds that the page was already received and would not ask the source again.
>>>
>>> So if we turn some PTEs that map zeroed-pages into pte-none we could run into trouble, because we will never try requesting/placing that page again and our VM will just be stuck forever.
>>>
>>> I wonder if other uffd users could similarly be affected. But maybe they don't place pages into the VMA before registering uffd.
>>>
>>> I'll try to double-check when QEMU would disable THP. But it could also be that that behavior changed between QEMU versions.
>>>
>>>>
>>>> If I understand the example correctly, the below diff over patch 6 should be good? i.e. just point to the empty_zero_page instead of doing pte_clear. This should still use the same amount of memory, although ptep_clear_flush means it might be slighly more expensive.
>>>
>>> There are rare cases where we must not use the shared zeropage (mm_forbids_zeropage()), that must be handled.
>>>
>>> I assume we could optimize here if uffd is not configured in. Further, what QEMU does is sense right at the beginning by temporarily registering uffd on some other VMA if it is even supported. That could be used as an indication ("ever used uffd -> don't turn PTEs none"). But again, no idea what other uffd users might be relying on :/
>>>
>>> In I wonder if some applications could rely on anon memory not suddenly "vanishing" form the PTEs (for example relying on pagemap like tools/testing/selftests/mm/cow.c) would. I don't think a lot of applications would do that, though.
>>>
>>
>>
>> I had a deeper look at how QEMU handles migration and at how kernel handles THPs in other places with respect to uffd. I hope I understood the migration code correctly :)
>>
>> QEMU:
>> There are 2 types of "migrations" [1], migration_thread and bg_migration_thread
>> - migration_thread supports postcopy live migration, but doesn't use uffd. So postcopy live migration doesn't use uffd as far as I can tell looking at the function [2].
>> - bg_migration_thread [3]: this isn't really live migration, but background snapshot. There is no postcopy and it works similar to pre-copy. From what I understand, uffd is registered before any pages are migrated [4].
>>
> 
> Ignore the second. What QEMU ends up using is precopy + postcopy. You can start precopy migration and decide at some point that you want to switch to postcopy (this is what I trigger below, let me know if you want a simple way to reproduce it).
> 
>> So the way these 2 threads work in qemu is: its either postcopy without uffd, or precopy-style snapshot with uffd registered at the start, then the current patch in this series is good, i.e. only use zeropage if userfaultfd_armed(pvmw->vma), otherwise pte_clear. I can't see postcopy with uffd anywhere in qemu which doesn all the steps 1-6 that you mentioned above, but I might not be looking at the right place?
> 
> "I can't see postcopy with uffd anywhere" -- most of it lives in migration/postcopy-ram.c.
> 
> See postcopy_ram_incoming_setup() where most of the UFFD setup logic happens.
> 

Thanks for pointing to this, I did not look at this before :( postcopy_ram_incoming_setup clears it up.

>>
>> Kernel:
>>  From a kernel perspective, if we look at khugepaged [5], it just takes into account if the vma is currently registered as uffd. So maybe this scenario can happen?
>> 1) THP is enabled on VMA, UFFD is not yet registered.
>> 2) dest accesses a 4K page (lets call it 4Kpage1), khugepaged collapses that page into 2M THP as the following 511 4K pages were pte_none [5], as VMA is not uffd armed yet.
>> 3) UFFD is registered + MADV_NOHUGEPAGE is set. No further collapse will happen, but the THPs that were created in step 2 will remain. MADV_NOHUGEPAGE doesn't split existing THP created in 2.
>> 4) dest tries to access 4Kpage2, the address right after 4Kpage1. As khugepaged collapsed it, there won't be a pagefault, and dest will read it as a zero-filled page, even if UFFD handler wanted to give some non-zero data filled page. I think anyone who wrote the uffd handler would want there to be a pagefault and give the non-zero data filled page and would not expect dest to see a zero-filled page.
>>
>> What I am trying to say with the above example is:
>> - UFFD registeration + MADV_NOHUGEPAGE should be done by all applications before any data in the region is accessed. Using THPs and accessing data before UFFD registeration + MADV_NOHUGEPAGE can lead to unexpected behaviour and is wrong?
> 
> The important point here is that you discard (MADV_DONTNEED) any pages you want to fault+place later lazily. That must happen after MADV_NOHUGEPAGE but before registering+running userfaultfd.
> 
> Then you don't care if page faults / kuhgepaged gave you THPs before that. In fact, you want to happily use THPs wherever possible and not
> disable them unconditionally right from the start.
> 
>> - even in the current kernel code in other places like khugepaged, its only checked if uffd is enabled currently. It is not tracked if it was ever enabled on any VMA.
> 
> Right, see above, this all works if you MADV_DONTNEED the pages you want to get faults to after disabling THPs.
> 
> 
> I just added a bunch of quick printfs to QEMU and ran a precopy+postcopy live migration. Looks like my assumption was right:
> 
> On the destination:
> 
> Writing received pages during precopy # ram_load_precopy()
> Writing received pages during precopy
> Writing received pages during precopy
> Writing received pages during precopy
> Writing received pages during precopy
> Writing received pages during precopy
> Writing received pages during precopy
> Writing received pages during precopy
> Writing received pages during precopy
> Writing received pages during precopy
> Writing received pages during precopy
> Writing received pages during precopy
> Writing received pages during precopy
> Writing received pages during precopy
> Writing received pages during precopy
> Writing received pages during precopy
> Writing received pages during precopy
> Writing received pages during precopy
> Disabling THP: MADV_NOHUGEPAGE # postcopy_ram_prepare_discard()
> Discarding pages # loadvm_postcopy_ram_handle_discard()
> Discarding pages
> Discarding pages
> Discarding pages
> Discarding pages
> Discarding pages
> Discarding pages
> Registering UFFD # postcopy_ram_incoming_setup()
> 

Thanks for this, yes it makes sense after you mentioned postcopy_ram_incoming_setup. 
postcopy_ram_incoming_setup happens in the Listen phase, which is after the discard phase, so I was able to follow in code in qemu the same sequence of events that the above prints show.
> 
> Let me know if you need more information.
> 
>> Thanks for pointing to mm_forbids_zeropage. Incorporating that into the code, and if I am (hopefully :)) right about qemu and kernel above, then I believe the right code should be:
> 
> I'm afraid you are not right about the qemu code :)
> 

Yes, and also didn't consider MADV_DONTNEED! Thanks for explaining both of these things clearly. Its clear that pte_clear won't work in this case. 

We don't need to clear_pte, just use zero_page for all cases. The original series from Alex did tlb flush, but looking further at the code, thats not needed. try_to_migrate() flushes tlb and installs migration entries which are not ‘present’ so will never be tlb cached. remove_migration_ptes() restores page pointers so tlb flushing is not needed. When using zeropage, we don't need make a distinction if uffd is used or not. i.e. we can just do below:

	if (contains_data || mm_forbids_zeropage(pvmw->vma->vm_mm))
		return false;

	newpte = pte_mkspecial(pfn_pte(page_to_pfn(ZERO_PAGE(pvmw->address)),
					pvmw->vma->vm_page_prot));

	set_pte_at(pvmw->vma->vm_mm, pvmw->address, pvmw->pte, newpte); 








