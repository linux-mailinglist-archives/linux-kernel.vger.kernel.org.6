Return-Path: <linux-kernel+bounces-213018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E9B9069E6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C674B1F27824
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E39E1422DA;
	Thu, 13 Jun 2024 10:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fmAiOIzR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAE4140391
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 10:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718274312; cv=none; b=Ya4mVKPrKj66JwEjlm2/QlQBCYbDIZgKKLIGyltMD/y/bMOSpah4SpNc/vrLhB8zD24EokdoWOsUsa5XhSAQ5+eH6NiIlc5mFx2eB0JdiVLrZqQJcFi7HDO1iva2ohCDn4unvMHadB/3dPPgd1kEW38VkRqB71SDDCUfiiNDkFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718274312; c=relaxed/simple;
	bh=8nCBf8bEhB2WtKyVdQhC/e7Cjm7uHdfgvIitHCe17Rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gN9ZMso6FDms7toq5yc+vjGYC+p8ojO9yRmg/60pw+6MuCXQLAti5HBoLvGo6UJCLOmR2tW+56omjm92QUFjoaXTI1A7ggV+qhvNYSrqWSWW8Pe8t25rv02JMsj7ygdB7LEkDvhCVDZMY48X17G48zZIeQKOK6FflI7hcJi218k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fmAiOIzR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718274309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ho8Kpk0aUZIKw48DC2NVjVs35V72Tj2xunIz7ueuPc4=;
	b=fmAiOIzRzzu5D0qk1nUa3GwdcR8PxPAii6D6yPIJY0xL2GdS4N64HSYdWsTFl3iStMH+/b
	kOHZVAEwJqiRsUNbsaQ3IMkQHrnLZFRATVOp46jMDGHB+XZDroOP54acBkTknlr33NYWcZ
	lxTmsXu7ZX123Lr7Wv93X7+GcDmuvoA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-xj7STMeOO46pqOv_vWTfeA-1; Thu, 13 Jun 2024 06:25:08 -0400
X-MC-Unique: xj7STMeOO46pqOv_vWTfeA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3605cad23e0so827953f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 03:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718274307; x=1718879107;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ho8Kpk0aUZIKw48DC2NVjVs35V72Tj2xunIz7ueuPc4=;
        b=rPeiqmoci+nWiu1E0QpkPSCKgQyYY4NHaLkcSwgMXMulG0L3yDjLeOEqUbgIRozKQy
         RWVN4deuASmmBM4Ptb44epOy7SgHn1w6MIHW0ZrCK4SCbSMsZczdYDDRGB6U1V4IoNGZ
         /u9k7COwT8p44RDLlc/CFld4W89pEwo6esZzZJ1qFaQFj+byQvq97CH+AaP2IrmRf8W/
         9mn5f4gTvSlgoMupmii5Xty8y7mSWOQCSgyawxzXd13kEymnwD/Aw2dM9ePIMMEoah4r
         UIZaWMP7LSSWYKf0rRAwzOmuAsUqjRZrzbLCuKRz4mG9J5If2EFWvqMU1o/daKL/RP97
         EV4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWkfrgh9msB8p4MSDnnbcwm9BSl9dedKSUm3ZDlYmgBFvHiG4ixxtk9Gj9c+DQJY0xg0f35dv46ZvVdSEb+k5+0Vxe5lJY2/VA5MpPj
X-Gm-Message-State: AOJu0YyBtJvEU3T9Dr89pvzAyLRopbtQcMADXH537siRIzn9EGuPnM9U
	pmnXhRRNriKeiJFoeBrk+Qwv2+1kTawpTsPnQgL/1OGYkyAwwI7xLt/jrkiwbL3WVcDjDRfv/Cy
	KZdtsHo5qD4MTW4wY23eLFCLeNeodBS9OwfLeH6DGm5CGRTITgrYc5JpPj7JWdw==
X-Received: by 2002:adf:f24d:0:b0:35f:3145:a097 with SMTP id ffacd0b85a97d-36071901378mr2175848f8f.23.1718274306988;
        Thu, 13 Jun 2024 03:25:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrfYQM4J4hVbTLQj9YXcY4p1x5Jv0gmABzoPMjgjZG+4q0uRzPQseoOXyO4NOMKfuKOEvvOg==
X-Received: by 2002:adf:f24d:0:b0:35f:3145:a097 with SMTP id ffacd0b85a97d-36071901378mr2175818f8f.23.1718274306534;
        Thu, 13 Jun 2024 03:25:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:fe00:10fe:298:6bf1:d163? (p200300cbc703fe0010fe02986bf1d163.dip0.t-ipconnect.de. [2003:cb:c703:fe00:10fe:298:6bf1:d163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075093a13sm1295166f8f.9.2024.06.13.03.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 03:25:06 -0700 (PDT)
Message-ID: <2cda0af6-8fde-4093-b615-7979744d6898@redhat.com>
Date: Thu, 13 Jun 2024 12:25:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] asynchronously scan and free empty user PTE pages
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: hughd@google.com, willy@infradead.org, mgorman@suse.de,
 muchun.song@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1718267194.git.zhengqi.arch@bytedance.com>
 <02f8cbd0-8b2b-4c2d-ad96-f854d25bf3c2@redhat.com>
 <efac94f6-2fb3-4682-a894-7c8ffac18d20@bytedance.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <efac94f6-2fb3-4682-a894-7c8ffac18d20@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13.06.24 11:32, Qi Zheng wrote:
> Hi David,
> 
> Thanks for such a quick reply!

I appreciate you working on this :)

> 
> On 2024/6/13 17:04, David Hildenbrand wrote:
>> On 13.06.24 10:38, Qi Zheng wrote:
>>> Hi all,
> 
> [...]
> 
>>
>>
>>> 3. Implementation
>>> =================
>>>
>>> For empty user PTE pages, we don't actually need to free it
>>> immediately, nor do
>>> we need to free all of it.
>>>
>>> Therefore, in this patchset, we register a task_work for the user
>>> tasks to
>>> asyncronously scan and free empty PTE pages when they return to user
>>> space.
>>> (The scanning time interval and address space size can be adjusted.)
>>
>> The question is, if we really have to scan asynchronously, or if would
>> be reasonable for most use cases to trigger a madvise(MADV_PT_RECLAIM)
>> every now and then. For virtio-mem, and likely most memory allocators,
>> that might be feasible, and valuable independent of system-wide
>> automatic scanning.
> 
> Agree, I also think it is possible to add always && madvise modes
> simliar to THP.

My thinking is, we start with a madvise(MADV_PT_RECLAIM) that will
synchronously try to reclaim page tables without any asynchronous work.

Similar to MADV_COLLAPSE that only does synchronous work. Of course,
if we don't need any heavy locking for reclaim, we might also just
try reclaiming during MADV_DONTNEED when spanning a complete page
table. That won't sort out all cases where reclaim is possible, but
with both approaches we could cover quite a lot that were discovered
to really result in a lot of emprt page tables.

On top, we might implement some asynchronous scanning later, This is,
of course, TBD. Maybe we could wire up other page table scanners
(khugepaged ?) to simply reclaim empty page tables it finds as well?

> 
>>
>>>
>>> When scanning, we can filter out some unsuitable vmas:
>>>
>>>       - VM_HUGETLB vma
>>>       - VM_UFFD_WP vma
>>
>> Why is UFFD_WP unsuitable? It should be suitable as long as you make
>> sure to really only remove page tables that are all pte_none().
> 
> Got it, I mistakenly thought pte_none() covered pte marker case until
> I saw pte_none_mostly().

I *think* there is one nasty detail, and we might need an arch callback
to test if a pte is *really* can be reclaimed: for example, s390x might
require us keeping some !pte_none() page tables.

While a PTE might be none, the s390x PGSTE (think of it as another
8byte per PTE entry stored right next to the actual page table
entries) might hold data we might have to preserve for our KVM guest.

But that should be easy to wire up.

> 
>>
>>>       - etc
>>> And for some PTE pages that spans multiple vmas, we can also skip.
>>>
>>> For locking:
>>>
>>>       - use the mmap read lock to traverse the vma tree and pgtable
>>>       - use pmd lock for clearing pmd entry
>>>       - use pte lock for checking empty PTE page, and release it after
>>> clearing
>>>         pmd entry, then we can capture the changed pmd in
>>> pte_offset_map_lock()
>>>         etc after holding this pte lock. Thanks to this, we don't need
>>> to hold the
>>>         rmap-related locks.
>>>       - users of pte_offset_map_lock() etc all expect the PTE page to
>>> be stable by
>>>         using rcu lock, so use pte_free_defer() to free PTE pages.
>>
>> I once had a protoype that would scan similar to GUP-fast, using the
>> mmap lock in read mode and disabling local IRQs and then walking the
>> page table locklessly (no PTLs). Only when identifying an empty page and
>> ripping out the page table, it would have to do more heavy locking (back
>> when we required the mmap lock in write mode and other things).
> 
> Maybe mmap write lock is not necessary, we can protect it using pmd lock
> && pte lock as above.

Yes, I'm hoping we can do that, that will solve a lot of possible issues.

> 
>>
>> I can try digging up that patch if you're interested.
> 
> Yes, that would be better, maybe it can provide more inspiration!

I pushed it to
	https://github.com/davidhildenbrand/linux/tree/page_table_reclaim

I suspect it's a non-working version (and I assume the locking is broken, there
are no VMA checks, etc), it's an old prototype. Just to give you an idea about the
lockless scanning and how I started by triggering reclaim only when kicked-off by
user space.

> 
>>
>> We'll have to double check whether all anon memory cases can *properly*
>> handle pte_offset_map_lock() failing (not just handling it, but doing
>> the right thing; most of that anon-only code didn't ever run into that
>> issue so far, so these code paths were likely never triggered).
> 
> Yeah, I'll keep checking this out too.
> 
>>
>>
>>> For the path that will also free PTE pages in THP, we need to recheck
>>> whether the
>>> content of pmd entry is valid after holding pmd lock or pte lock.
>>>
>>> 4. TODO
>>> =======
>>>
>>> Some applications may be concerned about the overhead of scanning and
>>> rebuilding
>>> page tables, so the following features are considered for
>>> implementation in the
>>> future:
>>>
>>>       - add per-process switch (via prctl)
>>>       - add a madvise option (like THP)
>>>       - add MM_PGTABLE_SCAN_DELAY/MM_PGTABLE_SCAN_SIZE control (via
>>> procfs file)
>>> Perhaps we can add the refcount to PTE pages in the future as well,
>>> which would
>>> help improve the scanning speed.
>>
>> I didn't like the added complexity last time, and the problem of
>> handling situations where we squeeze multiple page tables into a single
>> "struct page".
> 
> OK, except for refcount, do you think the other three todos above are
> still worth doing?

I think the question is from where we start: for example, only synchronous
reclaim vs. asynchonous reclaim. Synchronous reclaim won't really affect
workloads that do not actively trigger it, so it raises a lot less eyebrows. ...
and some user space might have a good idea where it makes sense to try to
reclaim, and when.

So the other things you note here rather affect asynchronous reclaim, and
might be reasonable in that context. But not sure if we should start with doing
things asynchronously.

-- 
Cheers,

David / dhildenb


