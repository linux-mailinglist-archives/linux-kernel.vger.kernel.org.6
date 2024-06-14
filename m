Return-Path: <linux-kernel+bounces-214814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC352908A70
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFFD61C21F2B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B04419539C;
	Fri, 14 Jun 2024 10:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="d1JBZU9X"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4B3194C8F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 10:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718362191; cv=none; b=DdeLPFhfWQdeTyLsO+CvC0MI3lOC8DDpzGHBtT4L3/HPO9tk/xjW8K2Eef9ZNJ/U2w/7eJRQqmM/X+Cwsc7dcEgP7S9l7qfdowEowBFeaGEnhvwVyBlMTskJTFGTTny42mRmEFBhyTrFvyy9k9ZV0VJspj9yc9axmP1KUvRGOvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718362191; c=relaxed/simple;
	bh=z+Gi4zzeOa9LwC60xY2b81mdL1JzQOP7pMfXreCx7AU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TpNOvKOy1YmUDWu79AVWkhURdETZOfwVl/CAfQQJycGT7OKoJu78d5Ej8hqjjIKHHrqOhFoMntqaYld1rwykGMLos3bv7r15nVa+G9AuUIuhBkN5OAy3esehHquw3jfOoQ74chFaWU2vqClgLy4Qdn2zXFEEUwJ3zfCPjLDIfDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=d1JBZU9X; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-704218fc926so44908b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 03:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1718362189; x=1718966989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hmqCAHcpbwggVjy6exq+YALJF1pljPcusJTHFPXAlKI=;
        b=d1JBZU9XdfaFR2ECvQNSYqKyhw7os2KOUvJdKxCAMzczJwkBJ5M9rJQvssAPZHx+B5
         lPHpUEWBji45nUoAQnOnbVQ9fdzKHZTuKaQOv+uPayS4jv+HebA2BvAku4pyVqkxmrrc
         MuAYuCkTgzFHQMrdrJWUZWDfqDkYnOovzYwenOBZZuHXo7/kmyf47d6E/HXC2agDNbu4
         RGoad80aZGEdqVkIcigviSjOv7FYlarrswIsz0328SxKksrbmPyG9O15cAjCIwtO/1Gt
         pZkGLgL/qLLg6k0tf5SGwdIwjPLRt4eRt/IKG14M8Jrj06vdUQ2Lg7P2O2gX4Uhue4IV
         vY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718362189; x=1718966989;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hmqCAHcpbwggVjy6exq+YALJF1pljPcusJTHFPXAlKI=;
        b=FTLuFxEuNQBBzTNEsxpHbaaUxub/m/UdFz9Qer5e5ss2MObRNIttvrzIe3pE/mKGV8
         VBWc9/tZnSrmGXXthgqaEcvt1ycn9LuhchxaC4N4UhPY7o+wligPwsc+u9r8FPk/5aDM
         es5h1yW6FzlBctJQsTJ/9GpTLi4NQnH+3PDFv03ADu5TTPWLIGsOylcs0y4SxjZKXZnD
         kMz2a7PUozvEUntLfvJGygvXbB59zvnyjqfIVdVzrSD6cO3jc0bjR86ExUAtJV4b/6HU
         sLhDWFVI8yjYgt6YkvW51fnRtEtRB8Hi1XrlwR1g0dQNSBlqkirkZawptVDcT0FD7wzt
         IbMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/JjeQ3WvZKPX4/q1YX+we7MwM8AK/JT5BKxzdBaW8SwbptY7v6h0u3HC6T/+XMSQZ/TXn8woJNfu6p//bRVFK29xIXV4mO7HtZ2/H
X-Gm-Message-State: AOJu0YwT28E81EGImXZkH8VQ/0iunjHnTvgxPyNVihg15k+MP9Lx+juB
	tcSa8OBsY8v6r0SY1+v6vTI4vygsjcauVNxrf4NV5qGiwzJO4ekK2am2sfEVQL4=
X-Google-Smtp-Source: AGHT+IGtCcMdp4KkgsUlEmyCdU6iXnl4cUS8Wg4L+AA4odNhkkdCncUU4TqYUpiClGd3D4OkYRrqlQ==
X-Received: by 2002:a05:6a00:8995:b0:705:bf53:aa8d with SMTP id d2e1a72fcca58-705d71c7ef2mr2298021b3a.3.1718362189063;
        Fri, 14 Jun 2024 03:49:49 -0700 (PDT)
Received: from [10.84.144.49] ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc96b65asm2771727b3a.74.2024.06.14.03.49.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 03:49:48 -0700 (PDT)
Message-ID: <f2fbf466-f722-4fd3-9883-189145e599f4@bytedance.com>
Date: Fri, 14 Jun 2024 18:49:40 +0800
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
 <aadae460-3797-4d10-a380-5d4fe8189e20@bytedance.com>
 <aaf9a7d7-647f-41bf-91b4-e362ff5df6b0@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <aaf9a7d7-647f-41bf-91b4-e362ff5df6b0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi David,

On 2024/6/14 15:53, David Hildenbrand wrote:
>>> My thinking is, we start with a madvise(MADV_PT_RECLAIM) that will
>>> synchronously try to reclaim page tables without any asynchronous work.
>>>
>>> Similar to MADV_COLLAPSE that only does synchronous work. Of course,
>>
>> This is feasible, but I worry that some user-mode programs may not be
>> able to determine when to call it.
> 
> Some yes, but others clearly :) Meaning, it's one step into the right 
> direction without having to worry about asynchronous work in the kernel 
> for now. That doesn't mean that asynchronous option is off the table.

Got it. I will try to implement a synchronous madvise option in the
next version.

> 
>>
>> My previous idea was to do something similar to madvise(MADV_HUGEPAGE),
>> just mark the vma as being able to reclaim the pgtable, and then hand
>> it over to the background thread for asynchronous reclaim.
> 
> That's one option, although there might be workloads where you really 
> don't have to scan asynchronously and possibly repeatedly.
> 
> For example, after virtio-mem discarded some memory it hotunplugged from 
> a VM using MADV_DONTNEED (in a sequence of multiple steps), it could 
> just setup a timer to free up page tables after a while exactly once. No 
> need to scan repeatedly / multiple times if virtio-mem didn't remove any 
> memory from a VM.
> 
> For memory allocators it could be similar: trigger it once (from another 
> thread?) on a range after sufficient freeing happened. If the workload 
> is mostly idle, there might not be a need to free up memory.

Thanks for adding this information!

> 
> (mostly focused on anonymous memory + shmem for now. With file-backed 
> memory it might be different, but that has so far not been the biggest 
> consumer we saw regarding page tables.)

OK.

> 
> Of course, for real asynchronous/automatic scanning in the kernel, one 
> could try finding clues when scanning is reasonable: for example, mark 
> page tables that have been scanned and there was nothing to reclaim, and 
> mark page tables when modifying them. But such optimizations are rather 
> future work I guess, because devil is in the detail.

Yes, we can optimize it step by step.

> 
>>
>>> if we don't need any heavy locking for reclaim, we might also just
>>> try reclaiming during MADV_DONTNEED when spanning a complete page
>>
>> I think the lock held by the current solution is not too heavy and
>> should be acceptable.
>>
>> But for MADV_FREE case, it still needs to be handled by
>> madvise(MADV_PT_RECLAIM) or asynchronous work.
> 
> Yes. Interestingly, reclaim code might be able to do that scanning + 
> reclaim if locking is cheap.

Yes, I am also considering implementing another madvise option in the
next version:

    mark the vma, then add its corresponding mm to a global list, and
    then traverse the list and reclaim it when the memory is tight and
    enters the system reclaim path.


> 
>>
>>> table. That won't sort out all cases where reclaim is possible, but
>>> with both approaches we could cover quite a lot that were discovered
>>> to really result in a lot of emprt page tables.
>>

[...]

>>>
>>> I pushed it to
>>>       https://github.com/davidhildenbrand/linux/tree/page_table_reclaim
>>>
>>> I suspect it's a non-working version (and I assume the locking is
>>> broken, there
>>> are no VMA checks, etc), it's an old prototype. Just to give you an idea
>>> about the
>>> lockless scanning and how I started by triggering reclaim only when
>>> kicked-off by
>>> user space.
>>
>> Many thanks! But I'm worried that on some platforms disbaling the IRQ
>> might be more expensive than holding the lock, such as arm64? Not sure.
> 
> Scanning completely lockless (no mmap lock, not PT locks), means that -- 
> as long as there is not much to reclaim (for most workloads the common 
> case!) -- you would not affect the workload at all.
> 
> Take a look at the khugepaged logic that does mmap_read_trylock(mm) and 
> makes sure to drop the mmap lock frequently due to 
> khugepaged_pages_to_scan, to not affect the workload too much while 
> scanning.
> 

OK, I will take a look.

>>
>>>
>>>>
>>>>>
>>>>> We'll have to double check whether all anon memory cases can 
>>>>> *properly*
>>>>> handle pte_offset_map_lock() failing (not just handling it, but doing
>>>>> the right thing; most of that anon-only code didn't ever run into that
>>>>> issue so far, so these code paths were likely never triggered).
>>>>
>>>> Yeah, I'll keep checking this out too.
>>>>
>>>>>
>>>>>
>>>>>> For the path that will also free PTE pages in THP, we need to recheck
>>>>>> whether the
>>>>>> content of pmd entry is valid after holding pmd lock or pte lock.
>>>>>>
>>>>>> 4. TODO
>>>>>> =======
>>>>>>
>>>>>> Some applications may be concerned about the overhead of scanning and
>>>>>> rebuilding
>>>>>> page tables, so the following features are considered for
>>>>>> implementation in the
>>>>>> future:
>>>>>>
>>>>>>        - add per-process switch (via prctl)
>>>>>>        - add a madvise option (like THP)
>>>>>>        - add MM_PGTABLE_SCAN_DELAY/MM_PGTABLE_SCAN_SIZE control (via
>>>>>> procfs file)
>>>>>> Perhaps we can add the refcount to PTE pages in the future as well,
>>>>>> which would
>>>>>> help improve the scanning speed.
>>>>>
>>>>> I didn't like the added complexity last time, and the problem of
>>>>> handling situations where we squeeze multiple page tables into a 
>>>>> single
>>>>> "struct page".
>>>>
>>>> OK, except for refcount, do you think the other three todos above are
>>>> still worth doing?
>>>
>>> I think the question is from where we start: for example, only 
>>> synchronous
>>> reclaim vs. asynchonous reclaim. Synchronous reclaim won't really affect
>>> workloads that do not actively trigger it, so it raises a lot less
>>> eyebrows. ...
>>> and some user space might have a good idea where it makes sense to 
>>> try to
>>> reclaim, and when.
>>>
>>> So the other things you note here rather affect asynchronous reclaim, 
>>> and
>>> might be reasonable in that context. But not sure if we should start
>>> with doing
>>> things asynchronously.
>>
>> I think synchronous and asynchronous have their own advantages and
>> disadvantages, and are complementary. Perhaps they can be implemented at
>> the same time?
> 
> 
> No strong opinion, something synchronous sounds to me like the 
> low-hanging fruit, that could add the infrastructure to be used by 
> something more advanced/synchronously :)

Got it, I will try to do the following in the next version.

a. for MADV_DONTNEED case, try synchronous reclaim as you said

b. for MADV_FREE case:

	- add a madvise option for synchronous reclaim

	- add another madvise option to mark the vma, then add its
           corresponding mm to a global list, and then traverse
           the list and reclaim it when the memory is tight and
           enters the system reclaim path.
           (maybe there is an option to unmark)

c. for s390 case you mentioned, create a CONFIG_FREE_PT first, and
    then s390 will not select this config until the problem is solved.

d. for lockless scan, try using disabling IRQ or (mmap read lock + 
pte_offset_map_nolock).

Thanks,
Qi

> 

