Return-Path: <linux-kernel+bounces-214304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8461908281
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 05:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA3CE1C22584
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 03:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E310146596;
	Fri, 14 Jun 2024 03:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kF2hlCtR"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079F03D64
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 03:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718335974; cv=none; b=kHWdYM1YEgwPUxySqvTeuAkg9smC6IKXZv0I11eqfZXdZACg1Tqzvjxo7TTbvbcbn0V8oc66XY/CCOKvrorU8tSSIRkPZkhRz00jQFVxDyJIx39SEu2mxqmE3e95TbDmz1P1lnZmrGpREz7xTRd5/hZvhV7bEwu5+HHPOOS8mUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718335974; c=relaxed/simple;
	bh=bG16A9FK1v4jxxSsiDFQVCrN66tQa+ZvVyiRA+abbLc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GIh2eT9t229UB/Ms6sjN4yJ055uciJoJq9o2FyfxeE6LR4XsT+D70kZxLZWQfdsnm5MLUESSR2Bq7OI9NnmLGkM0v8MAJwWM0LJagFz3EB+4nCttKtzJGlEgMuS0MOUnolGy81mVQFcWTFYiENdFKJQcbAYz17162Z74/BIIPp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=kF2hlCtR; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-6e9a52a302dso91900a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 20:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1718335971; x=1718940771; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VOeIsZP1p5TwLxrkuL+tuGN9UG/weTPFqKRDeUmQh0E=;
        b=kF2hlCtRiXWRqZyeWK0XBCLhzL0FCavNix4LhjDHt97ZE/IradSjG91ZT+Uw90CBXj
         F9qTxDv5q+UfBirjtOR5dcysI6yIaWmaZgTQhsiZM+zwr1R+EpesPl+HIcX4DU7RNwFh
         kG2l44jFPgFOahaxRIn+TG11Le8z2Q4ZDn5+ENkuM9+q8+jzgblqDjFGaO6Bq8R1BZPx
         oFjrSk7D01vKu65XEq9lsZKrH2dokoYq9GSiWgabkepDCugqULJxIZvHwA8n1Ta2grWC
         Qbgovo2d2HC205VwmEUAA8NVS1MOEKq2YbesmBeSKooemiTOYey68t/6+3zDEHYMfDAS
         OoZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718335971; x=1718940771;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VOeIsZP1p5TwLxrkuL+tuGN9UG/weTPFqKRDeUmQh0E=;
        b=iiAvP4AW3d9fYysVmBaDZGi+084GhZMrHpc2wdrIbRKBirJmPuI9+RnJOT2NTXGWMf
         OLte8oJ3HP4uDzi8yFbk1KdUnCpBAGv2nvMllXH1wPvCKWMJWjTkcWX52Oc/tM3n4Pry
         trWkX1rfAF90XxD/vGd4THvf3PxgKLOAU0D7ml6BgoeOtwH7ZvJ28e4Ou4Xws0FtzuDK
         uF5bRvtpRAlohz4DLdN0dXSvoaMrVPztViTGnlP45wFqt/6hFxTopxpaOPIcF/eYrmZa
         T60w4sAR/cEpj/zoZSzsyv1PnPTC4TTk9buXn3t23ksMWVakg8tZwLAm9CZR7C/lKmAy
         AQKw==
X-Forwarded-Encrypted: i=1; AJvYcCWRFyB5AE4U5otQN9oNBjoyH1aTL/w06cTArp74M6mbfI5ErKcwH6bFS4tiHkUoTTEOhSFP1dRhh9x+XL1j7jxV6hQR+Uuu2eFEo2Hh
X-Gm-Message-State: AOJu0YwAljimi84Ot84MxqzieDju3dThTX37zb/Xl3wq+IG9jXLwed3T
	St2ZD7x9LClqsFCC4ocdxjJP5QFgwh9P5zkwvTg9oZ+r3bVDWx9A7cx5eVaT0os=
X-Google-Smtp-Source: AGHT+IERYb7eDOf0jIVYAjrj1coheLJXAppcYT1bTuUiG29/BxsiVVswUWz+U0rs2JwS6SD5vZ3ZaA==
X-Received: by 2002:a05:6a21:6d9e:b0:1af:cd45:59a9 with SMTP id adf61e73a8af0-1bae7e1cf3emr2114454637.2.1718335970668;
        Thu, 13 Jun 2024 20:32:50 -0700 (PDT)
Received: from [10.84.144.49] ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f185a8sm21808115ad.235.2024.06.13.20.32.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 20:32:50 -0700 (PDT)
Message-ID: <24480cd6-0a13-4534-8d64-4517e73f0070@bytedance.com>
Date: Fri, 14 Jun 2024 11:32:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] asynchronously scan and free empty user PTE pages
Content-Language: en-US
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: David Hildenbrand <david@redhat.com>
Cc: hughd@google.com, willy@infradead.org, mgorman@suse.de,
 muchun.song@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1718267194.git.zhengqi.arch@bytedance.com>
 <02f8cbd0-8b2b-4c2d-ad96-f854d25bf3c2@redhat.com>
 <efac94f6-2fb3-4682-a894-7c8ffac18d20@bytedance.com>
 <2cda0af6-8fde-4093-b615-7979744d6898@redhat.com>
 <aadae460-3797-4d10-a380-5d4fe8189e20@bytedance.com>
In-Reply-To: <aadae460-3797-4d10-a380-5d4fe8189e20@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi David,

How about starting with this:

a. for MADV_DONTNEED case, try synchronous reclaim as you said
b. for MADV_FREE case, add a madvise(MADV_PT_RECLAIM) option to mark
    this vma, then add its corresponding mm to a global list, and then
    traverse the list and reclaim it when the memory is tight and enters
    the system reclaim path.

    (If this option is for synchronous reclaim as you said, then the
     user-mode program may need to start a thread to make a cyclic call.
     I'm not sure if this usage makes sense. If so, I can also implement
     such an option.)
c. for s390 case you mentioned, maybe we can set a CONFIG_FREE_PT first,
    and then s390 will not select this config until the problem is solved.
d. for lockless scan, we can use pte_offset_map_nolock() instead of
    disabling IRQ to scan, because we hold RCU read lock at this time,
    which can also ensure that the PTE page is not freed.

Thanks,
Qi

On 2024/6/13 19:59, Qi Zheng wrote:
> Hi,
> 
> On 2024/6/13 18:25, David Hildenbrand wrote:
>> On 13.06.24 11:32, Qi Zheng wrote:
>>> Hi David,
>>>
>>> Thanks for such a quick reply!
>>
>> I appreciate you working on this :)
>>
>>>
>>> On 2024/6/13 17:04, David Hildenbrand wrote:
>>>> On 13.06.24 10:38, Qi Zheng wrote:
>>>>> Hi all,
>>>
>>> [...]
>>>
>>>>
>>>>
>>>>> 3. Implementation
>>>>> =================
>>>>>
>>>>> For empty user PTE pages, we don't actually need to free it
>>>>> immediately, nor do
>>>>> we need to free all of it.
>>>>>
>>>>> Therefore, in this patchset, we register a task_work for the user
>>>>> tasks to
>>>>> asyncronously scan and free empty PTE pages when they return to user
>>>>> space.
>>>>> (The scanning time interval and address space size can be adjusted.)
>>>>
>>>> The question is, if we really have to scan asynchronously, or if would
>>>> be reasonable for most use cases to trigger a madvise(MADV_PT_RECLAIM)
>>>> every now and then. For virtio-mem, and likely most memory allocators,
>>>> that might be feasible, and valuable independent of system-wide
>>>> automatic scanning.
>>>
>>> Agree, I also think it is possible to add always && madvise modes
>>> simliar to THP.
>>
>> My thinking is, we start with a madvise(MADV_PT_RECLAIM) that will
>> synchronously try to reclaim page tables without any asynchronous work.
>>
>> Similar to MADV_COLLAPSE that only does synchronous work. Of course,
> 
> This is feasible, but I worry that some user-mode programs may not be 
> able to determine when to call it.
> 
> My previous idea was to do something similar to madvise(MADV_HUGEPAGE),
> just mark the vma as being able to reclaim the pgtable, and then hand
> it over to the background thread for asynchronous reclaim.
> 
>> if we don't need any heavy locking for reclaim, we might also just
>> try reclaiming during MADV_DONTNEED when spanning a complete page
> 
> I think the lock held by the current solution is not too heavy and
> should be acceptable.
> 
> But for MADV_FREE case, it still needs to be handled by
> madvise(MADV_PT_RECLAIM) or asynchronous work.
> 
>> table. That won't sort out all cases where reclaim is possible, but
>> with both approaches we could cover quite a lot that were discovered
>> to really result in a lot of emprt page tables.
> 
> Yes, agree.
> 
>>
>> On top, we might implement some asynchronous scanning later, This is,
>> of course, TBD. Maybe we could wire up other page table scanners
>> (khugepaged ?) to simply reclaim empty page tables it finds as well?
> 
> This is also an idea. Another option may be some pgtable scanning paths,
> such as MGLRU.
> 
>>
>>>
>>>>
>>>>>
>>>>> When scanning, we can filter out some unsuitable vmas:
>>>>>
>>>>>       - VM_HUGETLB vma
>>>>>       - VM_UFFD_WP vma
>>>>
>>>> Why is UFFD_WP unsuitable? It should be suitable as long as you make
>>>> sure to really only remove page tables that are all pte_none().
>>>
>>> Got it, I mistakenly thought pte_none() covered pte marker case until
>>> I saw pte_none_mostly().
>>
>> I *think* there is one nasty detail, and we might need an arch callback
>> to test if a pte is *really* can be reclaimed: for example, s390x might
>> require us keeping some !pte_none() page tables.
>>
>> While a PTE might be none, the s390x PGSTE (think of it as another
>> 8byte per PTE entry stored right next to the actual page table
>> entries) might hold data we might have to preserve for our KVM guest.
> 
> Oh, thanks for adding this background information!
> 
>>
>> But that should be easy to wire up.
> 
> That's good!
> 
>>
>>>
>>>>
>>>>>       - etc
>>>>> And for some PTE pages that spans multiple vmas, we can also skip.
>>>>>
>>>>> For locking:
>>>>>
>>>>>       - use the mmap read lock to traverse the vma tree and pgtable
>>>>>       - use pmd lock for clearing pmd entry
>>>>>       - use pte lock for checking empty PTE page, and release it after
>>>>> clearing
>>>>>         pmd entry, then we can capture the changed pmd in
>>>>> pte_offset_map_lock()
>>>>>         etc after holding this pte lock. Thanks to this, we don't need
>>>>> to hold the
>>>>>         rmap-related locks.
>>>>>       - users of pte_offset_map_lock() etc all expect the PTE page to
>>>>> be stable by
>>>>>         using rcu lock, so use pte_free_defer() to free PTE pages.
>>>>
>>>> I once had a protoype that would scan similar to GUP-fast, using the
>>>> mmap lock in read mode and disabling local IRQs and then walking the
>>>> page table locklessly (no PTLs). Only when identifying an empty page 
>>>> and
>>>> ripping out the page table, it would have to do more heavy locking 
>>>> (back
>>>> when we required the mmap lock in write mode and other things).
>>>
>>> Maybe mmap write lock is not necessary, we can protect it using pmd lock
>>> && pte lock as above.
>>
>> Yes, I'm hoping we can do that, that will solve a lot of possible issues.
> 
> Yes, I think the protection provided by the locks above is enough. Of
> course, it would be better if more people could double-check it.
> 
>>
>>>
>>>>
>>>> I can try digging up that patch if you're interested.
>>>
>>> Yes, that would be better, maybe it can provide more inspiration!
>>
>> I pushed it to
>>      https://github.com/davidhildenbrand/linux/tree/page_table_reclaim
>>
>> I suspect it's a non-working version (and I assume the locking is 
>> broken, there
>> are no VMA checks, etc), it's an old prototype. Just to give you an 
>> idea about the
>> lockless scanning and how I started by triggering reclaim only when 
>> kicked-off by
>> user space.
> 
> Many thanks! But I'm worried that on some platforms disbaling the IRQ
> might be more expensive than holding the lock, such as arm64? Not sure.
> 
>>
>>>
>>>>
>>>> We'll have to double check whether all anon memory cases can *properly*
>>>> handle pte_offset_map_lock() failing (not just handling it, but doing
>>>> the right thing; most of that anon-only code didn't ever run into that
>>>> issue so far, so these code paths were likely never triggered).
>>>
>>> Yeah, I'll keep checking this out too.
>>>
>>>>
>>>>
>>>>> For the path that will also free PTE pages in THP, we need to recheck
>>>>> whether the
>>>>> content of pmd entry is valid after holding pmd lock or pte lock.
>>>>>
>>>>> 4. TODO
>>>>> =======
>>>>>
>>>>> Some applications may be concerned about the overhead of scanning and
>>>>> rebuilding
>>>>> page tables, so the following features are considered for
>>>>> implementation in the
>>>>> future:
>>>>>
>>>>>       - add per-process switch (via prctl)
>>>>>       - add a madvise option (like THP)
>>>>>       - add MM_PGTABLE_SCAN_DELAY/MM_PGTABLE_SCAN_SIZE control (via
>>>>> procfs file)
>>>>> Perhaps we can add the refcount to PTE pages in the future as well,
>>>>> which would
>>>>> help improve the scanning speed.
>>>>
>>>> I didn't like the added complexity last time, and the problem of
>>>> handling situations where we squeeze multiple page tables into a single
>>>> "struct page".
>>>
>>> OK, except for refcount, do you think the other three todos above are
>>> still worth doing?
>>
>> I think the question is from where we start: for example, only 
>> synchronous
>> reclaim vs. asynchonous reclaim. Synchronous reclaim won't really affect
>> workloads that do not actively trigger it, so it raises a lot less 
>> eyebrows. ...
>> and some user space might have a good idea where it makes sense to try to
>> reclaim, and when.
>>
>> So the other things you note here rather affect asynchronous reclaim, and
>> might be reasonable in that context. But not sure if we should start 
>> with doing
>> things asynchronously.
> 
> I think synchronous and asynchronous have their own advantages and
> disadvantages, and are complementary. Perhaps they can be implemented at
> the same time?
> 
> Thanks,
> Qi
> 
>>

