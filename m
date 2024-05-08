Return-Path: <linux-kernel+bounces-173590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D16F8C0288
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEBF91F231A7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD84310A28;
	Wed,  8 May 2024 17:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D54AlkoL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131CE101DA
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 17:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715187845; cv=none; b=ofPsvApJ6ixO19PZjsgLWPCev9mhysZ+CVmQUZZqJjYd0PisXUf+yD7XK1mNLeZIq//+H09s5XlYyla5C6RIFIKNK2tV+WsBdDFQuWMyYb7dicXC5mBoQD4QINKHWliJ1TozjDcEvm/gvR1/UPE6fnCvodbWBRG3UUTO2ll3n9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715187845; c=relaxed/simple;
	bh=vxgBmXclL5XP370yQPorAZqtgx9ILTW6hhP8jsEDukU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AbFU0ZbaQnwWd3F15/8Z2uy5CDh/msJyD+uhWfHRI9BulFR3poXnCusFTaBhU9GE/jV1dtRUZjGOW3c4qaKbwTuu+MxpVXaOT7jS6UZATxNPwEd2H0ufSM4v7xHw9iPmN1v33guUB7IB0iVP0JG88DrZyiMdgrm2TDAc+PxRLJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D54AlkoL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715187842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rcCPo+3cu7idI5ZAWXQbTctQ8e7vzqGNjylW862XvfA=;
	b=D54AlkoL7N7Kri+pIRobNmx8exXb+Xp6rec81NWMkpnjwlbvjZmzzyLOtakOvrPujg4el9
	SCrmeKClkDJtER7r26ZVzwkt6065phwwe4g8NJzH4IxaU14ibc8ayBCTdOqDP/o1rEIKwn
	yRjnvpDWNryOiOSsD2J7VcQAndWokKE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-qTnz-ZW2PxqVxhxHN75Svw-1; Wed, 08 May 2024 13:04:01 -0400
X-MC-Unique: qTnz-ZW2PxqVxhxHN75Svw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-51fd3568b04so3712094e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 10:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715187840; x=1715792640;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rcCPo+3cu7idI5ZAWXQbTctQ8e7vzqGNjylW862XvfA=;
        b=L03aHOreavZbT9ztTCJtiUizaNTmKZFfNTvQiryfrd+uK5KUTZyePPrVVOXFbOuGC3
         5dQd9D0CB/2LnK8EeUqHQtGAm0DjtfpopiKQy4FNYMFor6BdcMav0apvoiRSLD5rTn4q
         s/DlaV7YIiTr8SqR6jiPJyFG3ZZZUG10GF/Xn9QkTyWHCgx9z76MjdQpRDh+MITnEdUX
         8s/qhBz2tKTd09nVK6WobuXePWPd+q+YcFS/2RVQQ3Ng1HtbiWLGJFdwsEtSkmjxEgo5
         c/V/yM/5LddBoQTP04S3ZJQiv5J4YiNfTCO8IbYos1hKB8kuOjNF3dpnmLE1MHyz8Uev
         spdA==
X-Forwarded-Encrypted: i=1; AJvYcCXdr+oZJHGI627wDgLr0JaRzF0X9+busE5KRIKz0L85FuRanzOGiJAnrwlXf3ThoFhJCr+ubzn93LC5cRUbLBm/47zW0PO8Ul8aSR3w
X-Gm-Message-State: AOJu0Yx1XeRxXEWD5re/XR9jOckR8TRbNLzLhogSiQm7/ZHa85JBuUXX
	hmdB1wOfDRf/B6RSfq1Mh2X5wdjCigC/hHVtzWBBHwgi8YPg6bsxS5+eNsYzVVYj9m0qH9g5Nst
	pmkPhV68uBENmwozeYK1nrLri+FjVo5iKfEZ20QLt5SSKnEKyol+t3xwLORoVlg==
X-Received: by 2002:a19:ee04:0:b0:51f:567b:c39b with SMTP id 2adb3069b0e04-5217c567c27mr1778774e87.28.1715187839833;
        Wed, 08 May 2024 10:03:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZJM//vTl/fBSB8ICDIb2GqYbnha27YpgvgG5v6MixBLxzU5Why65bKpXCjnOJGSnaESHi7w==
X-Received: by 2002:a19:ee04:0:b0:51f:567b:c39b with SMTP id 2adb3069b0e04-5217c567c27mr1778746e87.28.1715187839165;
        Wed, 08 May 2024 10:03:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:3100:35c3:fc4b:669f:9ff9? (p200300cbc707310035c3fc4b669f9ff9.dip0.t-ipconnect.de. [2003:cb:c707:3100:35c3:fc4b:669f:9ff9])
        by smtp.gmail.com with ESMTPSA id v20-20020a05600c445400b0041ac5f19213sm2924704wmn.8.2024.05.08.10.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 10:03:58 -0700 (PDT)
Message-ID: <de9f9d07-6534-419b-86a8-628e13020c1e@redhat.com>
Date: Wed, 8 May 2024 19:03:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] add mTHP support for anonymous shmem
To: Daniel Gomez <da.gomez@samsung.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "hughd@google.com" <hughd@google.com>,
 "willy@infradead.org" <willy@infradead.org>,
 "ioworker0@gmail.com" <ioworker0@gmail.com>,
 "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
 "ying.huang@intel.com" <ying.huang@intel.com>,
 "21cnbao@gmail.com" <21cnbao@gmail.com>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
 "shy828301@gmail.com" <shy828301@gmail.com>, "ziy@nvidia.com"
 <ziy@nvidia.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1714978902.git.baolin.wang@linux.alibaba.com>
 <CGME20240508113934eucas1p13a3972f3f9955365f40155e084a7c7d5@eucas1p1.samsung.com>
 <fqtaxc5pgu3zmvbdad4w6xty5iozye7v5z2b5ckqcjv273nz7b@hhdrjwf6rai3>
 <f44dc19a-e117-4418-9114-b723c5dc1178@redhat.com>
 <qye6lbmybiivdrr2vtlwgzzqelp7zoekezgiwo6mpirrl2576z@voszmqjbnm2q>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <qye6lbmybiivdrr2vtlwgzzqelp7zoekezgiwo6mpirrl2576z@voszmqjbnm2q>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.05.24 16:28, Daniel Gomez wrote:
> On Wed, May 08, 2024 at 01:58:19PM +0200, David Hildenbrand wrote:
>> On 08.05.24 13:39, Daniel Gomez wrote:
>>> On Mon, May 06, 2024 at 04:46:24PM +0800, Baolin Wang wrote:
>>>> Anonymous pages have already been supported for multi-size (mTHP) allocation
>>>> through commit 19eaf44954df, that can allow THP to be configured through the
>>>> sysfs interface located at '/sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled'.
>>>>
>>>> However, the anonymous shared pages will ignore the anonymous mTHP rule
>>>> configured through the sysfs interface, and can only use the PMD-mapped
>>>> THP, that is not reasonable. Many implement anonymous page sharing through
>>>> mmap(MAP_SHARED | MAP_ANONYMOUS), especially in database usage scenarios,
>>>> therefore, users expect to apply an unified mTHP strategy for anonymous pages,
>>>> also including the anonymous shared pages, in order to enjoy the benefits of
>>>> mTHP. For example, lower latency than PMD-mapped THP, smaller memory bloat
>>>> than PMD-mapped THP, contiguous PTEs on ARM architecture to reduce TLB miss etc.
>>>>
>>>> The primary strategy is similar to supporting anonymous mTHP. Introduce
>>>> a new interface '/mm/transparent_hugepage/hugepage-XXkb/shmem_enabled',
>>>> which can have all the same values as the top-level
>>>> '/sys/kernel/mm/transparent_hugepage/shmem_enabled', with adding a new
>>>> additional "inherit" option. By default all sizes will be set to "never"
>>>> except PMD size, which is set to "inherit". This ensures backward compatibility
>>>> with the shmem enabled of the top level, meanwhile also allows independent
>>>> control of shmem enabled for each mTHP.
>>>
>>> I'm trying to understand the adoption of mTHP and how it fits into the adoption
>>> of (large) folios that the kernel is moving towards. Can you, or anyone involved
>>> here, explain this? How much do they overlap, and can we benefit from having
>>> both? Is there any argument against the adoption of large folios here that I
>>> might have missed?
>>
>> mTHP are implemented using large folios, just like traditional PMD-sized THP
>> are. (you really should explore the history of mTHP and how it all works
>> internally)
> 
> I'll check more in deep the code. By any chance are any of you going to be at
> LSFMM this year? I have this session [1] scheduled for Wednesday and it would
> be nice to get your feedback on it and if you see this working together with
> mTHP/THP.
>

I'll be around and will attend that session! But note that I am still 
scratching my head what to do with "ordinary" shmem, especially because 
of the weird way shmem behaves in contrast to real files (below). Some 
input from Hugh might be very helpful.

Example: you write() to a shmem file and populate a 2M THP. Then, nobody 
touches that file for a long time. There are certainly other mmap() 
users that could better benefit from that THP ... and without swap that 
THP will be trapped there possibly a long time (unless I am missing an 
important piece of shmem THP design :) )? Sure, if we only have THP's 
it's nice, that's just not the reality unfortunately. IIRC, that's one 
of the reasons why THP for shmem can be enabled/disabled. But again, 
still scratching my head ...


Note that this patch set only tackles anonymous shmem 
(MAP_SHARED|MAP_ANON), which is in 99.999% of all cases only accessed 
via page tables (memory allocated during page faults). I think there are 
ways to grab the fd (/proc/self/fd), but IIRC only corner cases 
read/write that.

So in that sense, anonymous shmem (this patch set) behaves mostly like 
ordinary anonymous memory, and likely there is not much overlap with 
other "allocate large folios during read/write/fallocate" as in [1]. 
swap might have an overlap.


The real confusion begins when we have ordinary shmem: some users never 
mmap it and only read/write, some users never read/write it and only 
mmap it and some (less common?) users do both.

And shmem really is special: it looks like "just another file", but 
memory-consumption and reclaim wise it behaves just like anonymous 
memory. It might be swappable ("usually very limited backing disk space 
available") or it might not.

In a subthread here we are discussing what to do with that special 
"shmem_enabled = force" mode ... and it's all complicated I think.

> [1] https://lore.kernel.org/all/4ktpayu66noklllpdpspa3vm5gbmb5boxskcj2q6qn7md3pwwt@kvlu64pqwjzl/
> 
>>
>> The biggest challenge with memory that cannot be evicted on memory pressure
>> to be reclaimed (in contrast to your ordinary files in the pagecache) is
>> memory waste, well, and placement of large chunks of memory in general,
>> during page faults.
>>
>> In the worst case (no swap), you allocate a large chunk of memory once and
>> it will stick around until freed: no reclaim of that memory.
> 
> I can see that path being triggered by some fstests but only for THP (where we
> can actually reclaim memory).

Is that when we punch-hole a partial THP and split it? I'd be interested 
in what that test does.



-- 
Cheers,

David / dhildenb


