Return-Path: <linux-kernel+bounces-213160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E569906DD1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E0241F25F16
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E761448C4;
	Thu, 13 Jun 2024 11:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lWEoEzg+"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3CE146A7D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 11:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279981; cv=none; b=GXUfFPdOVkt9euKEkesZUsYhX5wymgQarlTjZ+uXTSuo9b7pBQRK02xxj263o0zh/VfXeJ6+1H/ZKQE05pwb+q6QXJF4K7Kimn7sHawuR8PjNGLdPI1hIMAQqWyzGdRSDYUufZK+aDCGLfC48nwdJmy+kBt5h3p+gm6HFpy3ob0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279981; c=relaxed/simple;
	bh=o0UKn70cwhSITZY1wYt/53iFXajErut93cW1JbyR9eY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sv7xZjyiT2Z/4f35MIu8gglgzqTo50Jevx1XI/c+cwHjm1owbEckNT8ClLMLzEm091Hc5JjyBziSJu1XTA0koKv8w5olHqnqlwKWrZbAQ/0Of9Sx1RG3Adm0uVpYh2ZA95Tlj+eXQGHk7XfAbgepbc751hXkwl703mVfnEAauUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lWEoEzg+; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-6e316754f65so21344a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 04:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1718279978; x=1718884778; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UVhn3YYdbuI907L2eSwlkSvdhUxxAH/uGHzlYl6KC5E=;
        b=lWEoEzg+ZscmwBSNMluPxgZnO8uFlZHuOGgU3fAbYOgWA8mPx6wDhdQujB6uV7REyX
         PHnThKkKI7t8ncjmxQ7lDDIvjCRNI2xsk1MXxgmmHQhRYe7zxO+2ngUXJVbu/kIa6cTB
         4lWkS4JSUEykFMpQ9/hatk/x9T0sqOwWJf3z1X7EFvy77NkDeWdzqBPgRRf+lTrX8le4
         8CmdUdUR3x7ZwlnQaKeTNxEn7Ba6Vr+FGXy6hWURhD0bzzCZjbTGCCbRCSK3Qm+9C+Fl
         eNR0L0rYxPM7BAel29MMGSYwbuQByRguqSI5Pj2vs+Z3q0D/44f23taWhmwF/G+go3ga
         sQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718279978; x=1718884778;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UVhn3YYdbuI907L2eSwlkSvdhUxxAH/uGHzlYl6KC5E=;
        b=GcFyyYsxxAN09QenfneWUmcVhQy2BLpjVy5qCtESAtqf9j5VP6HVcpBPXrD3hXDVAt
         Ir4d4wV4e3aDEh9TBQHZF/48mdjcpUmowOkHHuskxTJ5RQD0UTlZWxLcmO6JwcYGlSsr
         eQzVFT3aCq6SsCLuOiUIwesf/oZwLD5vUhkXbaZj1kz4xsieEtU3vyXv5Rhvc9D7ZHWv
         ZBiBRXuMljEef7bIlj3DwzylEEHezY6PzTQrdtz3KSG2t43MXFTh5nQ32RLdAocNugs2
         hC+8OZ6ZpoKGA2im7sFrSXHk+bYYeL8YB1obUfzVmMbz9hFrY10Kwl/1/Nbq02ZRXG9O
         KPxg==
X-Forwarded-Encrypted: i=1; AJvYcCUm6p1LwEeoxwtIzFkSrR+tzcAg9mgqg2ezTgsE9ulGWB9EgQrWWPZc+xxs2Tzz3yvzP+rB6HhZl333gJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdaGx/AtEL2zTEUfa1/KZ37uoKaE80TrP7MuMKgtkj0aJ4oJxt
	AU53T3KAVRIXOtxXVqA/lAUMtIRmcBAEoYTNXccnDdDGydZ0Q7F6XNdn5lcVQ3c=
X-Google-Smtp-Source: AGHT+IEoB6ZdWTm9ZhlVYHoAcDjw8or+JbWnKD9N1migDDIY9gWWNfCSV7bx3y3Ea1WyK8sc7ER07w==
X-Received: by 2002:a05:6a00:6902:b0:6f8:582e:6edf with SMTP id d2e1a72fcca58-705d45076a2mr179381b3a.1.1718279978186;
        Thu, 13 Jun 2024 04:59:38 -0700 (PDT)
Received: from [10.84.144.49] ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cde0dbdcsm1083295b3a.147.2024.06.13.04.59.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 04:59:37 -0700 (PDT)
Message-ID: <aadae460-3797-4d10-a380-5d4fe8189e20@bytedance.com>
Date: Thu, 13 Jun 2024 19:59:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] asynchronously scan and free empty user PTE pages
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: hughd@google.com, willy@infradead.org, mgorman@suse.de,
 muchun.song@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1718267194.git.zhengqi.arch@bytedance.com>
 <02f8cbd0-8b2b-4c2d-ad96-f854d25bf3c2@redhat.com>
 <efac94f6-2fb3-4682-a894-7c8ffac18d20@bytedance.com>
 <2cda0af6-8fde-4093-b615-7979744d6898@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <2cda0af6-8fde-4093-b615-7979744d6898@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 2024/6/13 18:25, David Hildenbrand wrote:
> On 13.06.24 11:32, Qi Zheng wrote:
>> Hi David,
>>
>> Thanks for such a quick reply!
> 
> I appreciate you working on this :)
> 
>>
>> On 2024/6/13 17:04, David Hildenbrand wrote:
>>> On 13.06.24 10:38, Qi Zheng wrote:
>>>> Hi all,
>>
>> [...]
>>
>>>
>>>
>>>> 3. Implementation
>>>> =================
>>>>
>>>> For empty user PTE pages, we don't actually need to free it
>>>> immediately, nor do
>>>> we need to free all of it.
>>>>
>>>> Therefore, in this patchset, we register a task_work for the user
>>>> tasks to
>>>> asyncronously scan and free empty PTE pages when they return to user
>>>> space.
>>>> (The scanning time interval and address space size can be adjusted.)
>>>
>>> The question is, if we really have to scan asynchronously, or if would
>>> be reasonable for most use cases to trigger a madvise(MADV_PT_RECLAIM)
>>> every now and then. For virtio-mem, and likely most memory allocators,
>>> that might be feasible, and valuable independent of system-wide
>>> automatic scanning.
>>
>> Agree, I also think it is possible to add always && madvise modes
>> simliar to THP.
> 
> My thinking is, we start with a madvise(MADV_PT_RECLAIM) that will
> synchronously try to reclaim page tables without any asynchronous work.
> 
> Similar to MADV_COLLAPSE that only does synchronous work. Of course,

This is feasible, but I worry that some user-mode programs may not be 
able to determine when to call it.

My previous idea was to do something similar to madvise(MADV_HUGEPAGE),
just mark the vma as being able to reclaim the pgtable, and then hand
it over to the background thread for asynchronous reclaim.

> if we don't need any heavy locking for reclaim, we might also just
> try reclaiming during MADV_DONTNEED when spanning a complete page

I think the lock held by the current solution is not too heavy and
should be acceptable.

But for MADV_FREE case, it still needs to be handled by
madvise(MADV_PT_RECLAIM) or asynchronous work.

> table. That won't sort out all cases where reclaim is possible, but
> with both approaches we could cover quite a lot that were discovered
> to really result in a lot of emprt page tables.

Yes, agree.

> 
> On top, we might implement some asynchronous scanning later, This is,
> of course, TBD. Maybe we could wire up other page table scanners
> (khugepaged ?) to simply reclaim empty page tables it finds as well?

This is also an idea. Another option may be some pgtable scanning paths,
such as MGLRU.

> 
>>
>>>
>>>>
>>>> When scanning, we can filter out some unsuitable vmas:
>>>>
>>>>       - VM_HUGETLB vma
>>>>       - VM_UFFD_WP vma
>>>
>>> Why is UFFD_WP unsuitable? It should be suitable as long as you make
>>> sure to really only remove page tables that are all pte_none().
>>
>> Got it, I mistakenly thought pte_none() covered pte marker case until
>> I saw pte_none_mostly().
> 
> I *think* there is one nasty detail, and we might need an arch callback
> to test if a pte is *really* can be reclaimed: for example, s390x might
> require us keeping some !pte_none() page tables.
> 
> While a PTE might be none, the s390x PGSTE (think of it as another
> 8byte per PTE entry stored right next to the actual page table
> entries) might hold data we might have to preserve for our KVM guest.

Oh, thanks for adding this background information!

> 
> But that should be easy to wire up.

That's good!

> 
>>
>>>
>>>>       - etc
>>>> And for some PTE pages that spans multiple vmas, we can also skip.
>>>>
>>>> For locking:
>>>>
>>>>       - use the mmap read lock to traverse the vma tree and pgtable
>>>>       - use pmd lock for clearing pmd entry
>>>>       - use pte lock for checking empty PTE page, and release it after
>>>> clearing
>>>>         pmd entry, then we can capture the changed pmd in
>>>> pte_offset_map_lock()
>>>>         etc after holding this pte lock. Thanks to this, we don't need
>>>> to hold the
>>>>         rmap-related locks.
>>>>       - users of pte_offset_map_lock() etc all expect the PTE page to
>>>> be stable by
>>>>         using rcu lock, so use pte_free_defer() to free PTE pages.
>>>
>>> I once had a protoype that would scan similar to GUP-fast, using the
>>> mmap lock in read mode and disabling local IRQs and then walking the
>>> page table locklessly (no PTLs). Only when identifying an empty page and
>>> ripping out the page table, it would have to do more heavy locking (back
>>> when we required the mmap lock in write mode and other things).
>>
>> Maybe mmap write lock is not necessary, we can protect it using pmd lock
>> && pte lock as above.
> 
> Yes, I'm hoping we can do that, that will solve a lot of possible issues.

Yes, I think the protection provided by the locks above is enough. Of
course, it would be better if more people could double-check it.

> 
>>
>>>
>>> I can try digging up that patch if you're interested.
>>
>> Yes, that would be better, maybe it can provide more inspiration!
> 
> I pushed it to
>      https://github.com/davidhildenbrand/linux/tree/page_table_reclaim
> 
> I suspect it's a non-working version (and I assume the locking is 
> broken, there
> are no VMA checks, etc), it's an old prototype. Just to give you an idea 
> about the
> lockless scanning and how I started by triggering reclaim only when 
> kicked-off by
> user space.

Many thanks! But I'm worried that on some platforms disbaling the IRQ
might be more expensive than holding the lock, such as arm64? Not sure.

> 
>>
>>>
>>> We'll have to double check whether all anon memory cases can *properly*
>>> handle pte_offset_map_lock() failing (not just handling it, but doing
>>> the right thing; most of that anon-only code didn't ever run into that
>>> issue so far, so these code paths were likely never triggered).
>>
>> Yeah, I'll keep checking this out too.
>>
>>>
>>>
>>>> For the path that will also free PTE pages in THP, we need to recheck
>>>> whether the
>>>> content of pmd entry is valid after holding pmd lock or pte lock.
>>>>
>>>> 4. TODO
>>>> =======
>>>>
>>>> Some applications may be concerned about the overhead of scanning and
>>>> rebuilding
>>>> page tables, so the following features are considered for
>>>> implementation in the
>>>> future:
>>>>
>>>>       - add per-process switch (via prctl)
>>>>       - add a madvise option (like THP)
>>>>       - add MM_PGTABLE_SCAN_DELAY/MM_PGTABLE_SCAN_SIZE control (via
>>>> procfs file)
>>>> Perhaps we can add the refcount to PTE pages in the future as well,
>>>> which would
>>>> help improve the scanning speed.
>>>
>>> I didn't like the added complexity last time, and the problem of
>>> handling situations where we squeeze multiple page tables into a single
>>> "struct page".
>>
>> OK, except for refcount, do you think the other three todos above are
>> still worth doing?
> 
> I think the question is from where we start: for example, only synchronous
> reclaim vs. asynchonous reclaim. Synchronous reclaim won't really affect
> workloads that do not actively trigger it, so it raises a lot less 
> eyebrows. ...
> and some user space might have a good idea where it makes sense to try to
> reclaim, and when.
> 
> So the other things you note here rather affect asynchronous reclaim, and
> might be reasonable in that context. But not sure if we should start 
> with doing
> things asynchronously.

I think synchronous and asynchronous have their own advantages and
disadvantages, and are complementary. Perhaps they can be implemented at
the same time?

Thanks,
Qi

> 

