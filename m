Return-Path: <linux-kernel+bounces-425493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E62FC9DC2D6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 12:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A719F2820AF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 11:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3B116190B;
	Fri, 29 Nov 2024 11:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fn2OBtXY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96851132C38
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 11:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732879835; cv=none; b=MZVti4ANVmyaQGARx+C4QzHy4VfLhid+Mw5gVvcRdJIzzkWt4EmU7vodNU7aQJZnJIEaA0Bl7Y6pcKhIPy0NsxMk7z2Iuv/BHLlraDI5BehwSDs6dihYUng+M4m4iZQmPtfpncSoVUHScuQo6aO58IXHBtM9cI1eB9Psrfo7cTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732879835; c=relaxed/simple;
	bh=G/6IFrY/AkFCZkYT9KDc8OHOPvruUkgSKtuS2eYnWuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mcu2muarwBgUgY5yy03FjX0o2elveuuvf9Sm34DKrgxJQNBr5r9llwQz+wUhuf8vybwGyRC2CDwiHnaDElVvhqbI8meZm87HphIHEz2saqw2Glt5RNKVEeF+rQu7o+dy/PT30aZGAXSRkd+CpmZeWSi6FGNIvlM1UUYTx2eySL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fn2OBtXY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732879831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eVIcuQHeXps9S+tdyENW/+0LGIfDIUQGu9FOs70muaY=;
	b=fn2OBtXYzQTDPF8++ivm68tpUzpD8yIdIA66vgUZYbs9AwLjpUxQ/qtYMdaF0oFRR++yFp
	teEVk2jQBDSsq9VPwJAvYVUI0PMJzEv22KKm4045yJN4mX+1jmW8w/f8ChXtFccqg/mV29
	av4HCARSCvLdGB2uHauCqllMvEpHu6U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-FLN2K8idPFO-oJGr6RZCeg-1; Fri, 29 Nov 2024 06:30:30 -0500
X-MC-Unique: FLN2K8idPFO-oJGr6RZCeg-1
X-Mimecast-MFC-AGG-ID: FLN2K8idPFO-oJGr6RZCeg
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-434a90fecfeso13427305e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 03:30:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732879829; x=1733484629;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVIcuQHeXps9S+tdyENW/+0LGIfDIUQGu9FOs70muaY=;
        b=F2b9D9Xk0kE0MYjKh4OU+7sohTFl/2XenqyAF5zXcwld9oj36qJHXKruGU6g81bMrN
         5HcjvAwVb4h2+InMiFskRk5Hwl0Mw0QG6Oc+UIXGgvsuJYsqcGQnkaV6zCzlC274q0uH
         5wcNY/Ud3B2xA/+XvzrjEomK2i5xOMrZH2nCeM8ZmsWnt7itLxTza9MorJrxOi+zK6uK
         7t8DNE0agempA1adNbEHPWkrAp75iBuW3YjUP6X+zX5TF5i9DvRtFEsfB9o2t420BD0m
         zFefu1mjDjRPC7OXGHhHsJGVkj2XrlXvnDF0OoQBZKGcy80EbtRd/dHyYTJ9cpUGszeX
         Uang==
X-Forwarded-Encrypted: i=1; AJvYcCW+QTzVwpIvGKM+jmsBU62v0GzoSuvf9N530RIrWRzCVGm4s6WsFwAFRIkGhyDNmzZy7mq7sTctMmbZvWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfJj/DL2eODzWzeEtTXY6Ax7GEDn8SOYNwzBTS8wrn2DUdtH6K
	KrBwWVHmyZ+9b1UuRnK7OxnZk22hPkw2Hg5vlB+QeI1bfo906kOHBHq3UGRSmI7H2TkurAGyCuw
	2z160AeDX8Z/5SAyEgapvKyR35CziUpwQhFfG9QtH3D2PTfdgZZUgYnBTgPKOAA==
X-Gm-Gg: ASbGncvC5MnUR3OZWxisGRKMiIY5rbc8iXKaV2njr7Pc+6IG0mHk+yyFtHVvZsHp2qP
	AyrN0qVbGjOU7HG7wg4Cq9Gdc7dvSOzRFGOvBKm+Ait22JYsLfhfXcRFQODb+s9yMfPIfiHuA+J
	bOm1upjmQZS5JX5eGZbRPC/Bzbuwij0l5aQskQn72dKm9KHk0Vp3h+0jWyxQ4dygUMEKHRPNsF7
	9oj1CuHpWwZO7xw/mVigLdcsxklP62MJ1ZRKSOYRSELUhN4OZCFAaDPspkuYu+KhjuqOpX2GDXY
	3lnmeUJo5Ig+mnVNo5sTuYXt4JNnBtG6FYlC+TYpG+MDN5tk8HN83dhma+UKnKMaTSLxP5mpt+j
	bjQ==
X-Received: by 2002:a05:600c:1c88:b0:434:a0a0:3660 with SMTP id 5b1f17b1804b1-434a9dfbbffmr107977585e9.31.1732879828704;
        Fri, 29 Nov 2024 03:30:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNHe98IHmxEp5YZso2uGdAIWGtdYH5mzVBX+GrKyjyQgki4y1rh5jk27+Kr40MJEX5+nrOuA==
X-Received: by 2002:a05:600c:1c88:b0:434:a0a0:3660 with SMTP id 5b1f17b1804b1-434a9dfbbffmr107977095e9.31.1732879828186;
        Fri, 29 Nov 2024 03:30:28 -0800 (PST)
Received: from ?IPV6:2003:cb:c71c:a700:bba7:849a:ecf1:5404? (p200300cbc71ca700bba7849aecf15404.dip0.t-ipconnect.de. [2003:cb:c71c:a700:bba7:849a:ecf1:5404])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0dbe40csm49883405e9.10.2024.11.29.03.30.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 03:30:27 -0800 (PST)
Message-ID: <d5b827a4-81ae-4283-9bb4-2e38adc47d71@redhat.com>
Date: Fri, 29 Nov 2024 12:30:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QUESTION] mmap lock in khugepaged
To: Dev Jain <dev.jain@arm.com>, ryan.roberts@arm.com,
 kirill.shutemov@linux.intel.com, willy@infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, ziy@nvidia.com
References: <20241128062641.59096-1-dev.jain@arm.com>
 <d8d29152-ce3f-406d-9e95-a0e8ea2eabbf@redhat.com>
 <4cb26a06-d982-4ca3-a5f7-7c6a6c63428c@arm.com>
 <3d4c57dd-0821-4684-9018-db8274c170ec@redhat.com>
 <66bb7496-a445-4ad7-8e56-4f2863465c54@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <66bb7496-a445-4ad7-8e56-4f2863465c54@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>
>> Thinking about it, I am also not sure if most other code can deal with
>> temporary pmd_none(). These don't necessarily take the PMD lock,
>> because "why would they" right now.
>>
>> See walk_pmd_range() as one example, if it spots pmd_none() it assumes
>> "there really is nothing" without checking the PMD lock.
>>
>> As a more concrete example, assume someone calls MADV_DONTNEED and we
>> end up in zap_pmd_range(). If we assume "pmd_none() == really nothing"
>> we'll skip that entry without getting the PMD lock involved. That
>> would mean that you would be breaking MADV_DONTNEED if you managed to
>> collapse or not -- memory would not get discarded.
>>
>> This is a real problem with anonymous memory.
>>
> Yes, I thought of different locking fashions but the problem seems to be
> that any pagetable walker will choose an action path according to the value
> it sees.
> 
>>
>> Unless I am missing something it's all very tricky and there might be
>> a lot of such code that assumes "if I hold a mmap lock / VMA lock in
>> read mode, pmd_none() means there is nothing even without holding the
>> PMD lock when checking".
> 
> Yes, I was betting on the fact that, if the code assumes that pmd_none()
> means there is nothing, eventually when it will take the PMD lock to
> write to it, it will check whether
> the PMD changed, and back off. I wasn't aware of the MADV_DONTNEED
> thingy, thanks.

Note that this is just the tip of the iceberg. Most page table walkers 
that deal with anonymous memory have the same requirement.

>>>>
>>>>
>>>> I recall that for shmem that's "easier", because we don't have to
>>>> reinstall a PMD immediately, we cna be sure that the page table is
>>>> kept empty/unmodified, ...
>>>>
>>>
> 
> All in all, the general solution seems to be that, if I can take all
> pagetable walkers into an invalid state and make them backoff, then I am
> safe.
 > For example, we do not zero out the PMD, we take the pte PTL, we do> 
stuff, then instead of setting the PTEs to zero, we set it to a universal
> invalid state upon which no pagetable walker can take an action; an
> instance of that can be to set the PTE to a swap entry such that the fault
> handler ends up in do_swap_page() ->print_bad_pte(). So now we can take
> the PMD lock (in fact we don't need it since any pagetable walking
> is rendered useless) and populate the PMD to resume the new pagetable
> walking. Another *ridiculous* idea may be to remember the PGD we
> came from and nuke it (but I guess there is an alternate path for that
> in walk_pgd_range() and so on?)


What might work is introducing a PMD marker (note: we don't have PMD 
markers yet) for that purpose. Likely, the PMD marker may only be set 
while the PMD lock is being held, and we must not drop the PMD lock 
temporarily (otherwise people will spin on the value by repeadetly 
(un)locking the PMD lock, which is stupid).


Then you have to make sure that each and every page table walker handles 
that properly.

Then, there is the problem with holding the PMD lock for too long as I 
mentioned.

Last but not least, there are more issues that I haven't even described 
before (putting aside the other issue):


Our page table walkers can handle the transitions:

PMD leaf -> PMD none
* concurrent zap / MADV_DONTNEED / !anon PMD split

PMD leaf -> PTE table
* concurrent anon PMD split
* concurrent zap / MADV_DONTNEED / !anon PMD split + PTE table
   allocation

PTE table (empty) -> PMD none
* concurrent page table reclaim, part of collapsing file THPs
  * collapse_pte_mapped_thp()
  * retract_page_tables()


I think they *cannot* tolerate the transition *properly*:

PTE table (non-empty) -> PMD leaf
* what you want do do ;)

-> Observe how we skip to the next PMD in all page table walkers /  give 
up if pte_offset_map_lock() and friends fail! I even think there are 
more issues hiding there with pte_offset_map_ro_nolock().


Of course, on top of all of this, you should net significantly degrade 
the ordinary page table walker performance ...


I don't want to discourage you, but it's all extremely complicated.

-- 
Cheers,

David / dhildenb


