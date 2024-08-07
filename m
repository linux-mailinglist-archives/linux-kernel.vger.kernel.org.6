Return-Path: <linux-kernel+bounces-277277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB552949EB7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 05:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6CA31C210EE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 03:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B850818FDB2;
	Wed,  7 Aug 2024 03:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BwCbmu4G"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B58618D648
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 03:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723003145; cv=none; b=u8YITHWJmr5p/Kirf6pPSXJSC3B3iwRG4Jbo1+YlwvLt7G3Mxj4lx3lvrGho1UqmpIFpMK71tImIlKSm24cYcKNmH1l+NujOCZM9xWJl4Di6GRGRK6uX3ZF2BhPqWpb5J4B+ltuu6V4MrsjFuMMmTYF9MppxKxFodwnlDWpIORc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723003145; c=relaxed/simple;
	bh=9I0prRdqF/d3bJFssGBJAaXxPLWCrnJ0HZ0T7Eeecy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PLVnOU0fbjuT+kFEyHsMvYMaxFfRABRKyAY76nkg/7+PIx9isHl3McQLbdGTQn/LjOW6Pr1pPkMdGBD+GYhi/dDkTkx7+aNBdJn815AW8ljZ7zJ1gjH8vZ470nISMrEcN3gT2IPJF0SLmukH1sIsUSaq3o2vwh190jfwSA2yD9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BwCbmu4G; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70d0fc15efbso12997b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 20:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723003143; x=1723607943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KxgIvXKRdcsrkw1igk9vshNPMIkb4LwqRSbInxcTuzc=;
        b=BwCbmu4GY99euamUoLt+8baBMgUSLs1ZJVahwYZEAFGa+XiI5fDGqq25dBMPIYPRHe
         bOQz/gmR0pexPDeFiuopIToqQS9Ta8GZaZRNzmGWPe0W4EyZCrCHGvAp6/lA9g0eujfj
         j4omIa2Z4zllAKSaXhigfi0o/erf7X79/Z7PJserMCZ2l+UHoAgSGnOaQRPfyo6PtnQ6
         9Il0z3qgJp8rwKQ3SvRoDYzkPYOnBq8/+xDdEN5VywCdpqtN0vOvE7f94SPplWDhfhc+
         kDPAi91UrQn+crSQHQzOr8MW9nqQzsN+avl3dSwYRjA5NUPYRqGI9pABXbJBZZoyuMU4
         A/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723003143; x=1723607943;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KxgIvXKRdcsrkw1igk9vshNPMIkb4LwqRSbInxcTuzc=;
        b=JzaOZs2ePJ0eo7a3DaurNiiFqo/HFrcf9otFixw/b3t9ek4xsdCh+b6gSFViFsvggq
         nPSzsyIfjjLyoOF/T1ZALDHwJp8/CZiizH0Q7ElG1bv6p8TdqsA/C/K6yleKt4TYHf6F
         0AXf6YwW+pIYpS7QKw0Hh8Cqg1RCOz4WrgZDELOQGJKlbAd/KHeppNOFJyc07WGFqBnR
         ersAz2NaC0MF1WjiQ8aFzcINXHYPc3j84h2FIHn5CeBNr8lTRk6lO9/BdQP+JRfm5h1X
         6xmDgZgGCv6yyQRWPC8XpXGWWxgLQgVDVJS61wpLcffFsgqfWolQQEQKrkKID/aHXkRW
         bISQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmZMeN5Z7vE9TDP2r/vaw5SSYNKMcoqGS/a6liIECVopgt9Qr1KHoJux99bM7oogo1XHHxFEkGpG0ZlnFi3Tk6YhaIkAYk0BtwF7te
X-Gm-Message-State: AOJu0YzfvuMaNpuNygADILJchz8xBqf9ys8Z4b+LFK4rx126r4h6hT+/
	Nk2qOPejlu7QZdSIkOY3Nf69x88tb58e9jac8cw6UkElR9BNV8RbVEw4dLrPnq4=
X-Google-Smtp-Source: AGHT+IGJq5ux7MPRCieTZnz92rUsg1i/KPYZvwfQzY8ySGKUpOUxlzQ637Ipachy5MbwL339hBjlsQ==
X-Received: by 2002:a05:6a00:2191:b0:70d:2cf6:598 with SMTP id d2e1a72fcca58-7106d0ac56emr13554224b3a.5.1723003143313;
        Tue, 06 Aug 2024 20:59:03 -0700 (PDT)
Received: from [10.255.168.175] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ed2abe2sm7611739b3a.189.2024.08.06.20.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 20:59:02 -0700 (PDT)
Message-ID: <42942b4d-153e-43e2-bfb1-43db49f87e50@bytedance.com>
Date: Wed, 7 Aug 2024 11:58:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 4/7] mm: pgtable: try to reclaim empty PTE pages in
 zap_page_range_single()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: hughd@google.com, willy@infradead.org, mgorman@suse.de,
 muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org,
 zokeefe@google.com, rientjes@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1722861064.git.zhengqi.arch@bytedance.com>
 <9fb3dc75cb7f023750da2b4645fd098429deaad5.1722861064.git.zhengqi.arch@bytedance.com>
 <2659a0bc-b5a7-43e0-b565-fcb93e4ea2b7@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <2659a0bc-b5a7-43e0-b565-fcb93e4ea2b7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi David,

On 2024/8/6 22:40, David Hildenbrand wrote:
> On 05.08.24 14:55, Qi Zheng wrote:
>> Now in order to pursue high performance, applications mostly use some
>> high-performance user-mode memory allocators, such as jemalloc or
>> tcmalloc. These memory allocators use madvise(MADV_DONTNEED or MADV_FREE)
>> to release physical memory, but neither MADV_DONTNEED nor MADV_FREE will
>> release page table memory, which may cause huge page table memory usage.
>>
>> The following are a memory usage snapshot of one process which actually
>> happened on our server:
>>
>>          VIRT:  55t
>>          RES:   590g
>>          VmPTE: 110g
>>
>> In this case, most of the page table entries are empty. For such a PTE
>> page where all entries are empty, we can actually free it back to the
>> system for others to use.
>>
>> As a first step, this commit attempts to synchronously free the empty PTE
>> pages in zap_page_range_single() (MADV_DONTNEED etc will invoke this). In
>> order to reduce overhead, we only handle the cases with a high 
>> probability
>> of generating empty PTE pages, and other cases will be filtered out, such
>> as:
> 
> It doesn't make particular sense during munmap() where we will just 
> remove the page tables manually directly afterwards. We should limit it 
> to the !munmap case -- in particular MADV_DONTNEED.

munmap directly calls unmap_single_vma() instead of
zap_page_range_single(), so the munmap case has already been excluded
here. On the other hand, if we try to reclaim in zap_pte_range(), we
need to identify the munmap case.

Of course, we could just modify the MADV_DONTNEED case instead of all
the callers of zap_page_range_single(), perhaps we could add a new
parameter to identify the MADV_DONTNEED case?

> 
> To minimze the added overhead, I further suggest to only try reclaim 
> asynchronously if we know that likely all ptes will be none, that is, 

asynchronously? What you probably mean to say is synchronously, right?

> when we just zapped *all* ptes of a PTE page table -- our range spans 
> the complete PTE page table.
> 
> Just imagine someone zaps a single PTE, we really don't want to start 
> scanning page tables and involve an (rather expensive) walk_page_range 
> just to find out that there is still something mapped.

In the munmap path, we first execute unmap and then reclaim the page
tables:

unmap_vmas
free_pgtables

Therefore, I think doing something similar in zap_page_range_single()
would be more consistent:

unmap_single_vma
try_to_reclaim_pgtables

And I think that the main overhead should be in flushing TLB and freeing
the pages. Of course, I will do some performance testing to see the
actual impact.

> 
> Last but not least, would there be a way to avoid the walk_page_range() 
> and simply trigger it from zap_pte_range(), possibly still while holding 
> the PTE table lock?

I've tried doing it that way before, but ultimately I did not choose to
do it that way because of the following reasons:

1. need to identify the munmap case
2. trying to record the count of pte_none() within the original
    zap_pte_range() loop is not very convenient. The most convenient
    approach is still to loop 512 times to scan the PTE page.
3. still need to release the pte lock, and then re-acquire the pmd lock
    and pte lock.

> 
> We might have to trylock the PMD, but that should be doable.

Yes, It's doable.

Thanks,
Qi

> 

