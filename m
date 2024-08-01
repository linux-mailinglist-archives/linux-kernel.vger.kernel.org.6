Return-Path: <linux-kernel+bounces-271590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C40B94506B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F5C51C23BC7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24F71B3754;
	Thu,  1 Aug 2024 16:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtiE8fvE"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBD813D89B;
	Thu,  1 Aug 2024 16:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722529330; cv=none; b=WXiss3Wp5gTRVQdc8yNkyoL8kzaE8IWnj3jdCUjE5powmYaDt0n1wTHee3loWDij88SaKHg4G1TXZABrJWnLld9xB5veURaP5DlaBQHHFu2/uzLdi4X5rHhYypixqsfDC8lKHEMymdRUY0qg1vOLw9W22e5I89+E5b9p3Ms8G/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722529330; c=relaxed/simple;
	bh=9l2hGzFuYfYspjnyCv/zS9Ms2PduMXdky+3rv4ZVb18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OcEc1IZqxt5m7WtCH/UANsAZC6s7skP1MPAtiSPje4f/xCAxTn6jX3JaLqkgFNK+6waqOhYuWOxUhb00NeymPMYj9b7dhFDZs3pqFFruF/Mru3/yWtVh0x9Ag+pFxbSOVNWA0F4FI+7HwtQsHqeLlRL6ljt3sJsk46KOmFzZccY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtiE8fvE; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7a9a7af0d0so939959166b.3;
        Thu, 01 Aug 2024 09:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722529326; x=1723134126; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PuJ6lXbYLk7DX9qMsWnojirrTp2KPxnd0ZQH8Ct4y8Q=;
        b=mtiE8fvEbeWroSdipVJgvN0uMv2+O6PgthQGtm+4AjSz9UVsk6INtkidtYRHJGnS+7
         1cyNxrEKYsPIbJvFctWwGNWgOxBNOBqx+A44+pgPvZSH6IR6euF5pm+7R5WDkYgu/dzO
         gbBPLS6XJFCaZFeJBuf4z4UlvgkDYp6C9aa/7pr+flOByC0mQySZHLSMdoOGwtsJjXnj
         500TXMSKHg6yyokONt28h9BQLO/JEKt9ICKjsFvp9N+z6Re1gCY2+ly7L206kCuVutOb
         113JtkIp3jzLsVp/KqUs8mLJEnXVB6ihO8Wp2SaoQE3At7NlCXD/8mMvKyr1Pcz3rdMU
         evmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722529326; x=1723134126;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PuJ6lXbYLk7DX9qMsWnojirrTp2KPxnd0ZQH8Ct4y8Q=;
        b=mUZMGX7qPR3SbhM2rH6aooLCyOrn0jkM0UVDj0NeFoqnFxIkdTLdyKiT6Mph+v7QDq
         P5YXX0O78a/mmNquNu5cn61zQvlUCQmshaAfJLN+tpOkwHF+BPy8yMghdSYOt/3QYmuK
         Vmv+kJc1iunORgfg1I9bseqLrxWv1yvozIJZPfryii6C9Uzf+AU1yEnaK2P7JBixnuA/
         bKOpm9Wqu3SDrn8hgWEAWprOb7Fvvs0yrgLnkPUv4JZXkJT7enM77UgGn160lB9aCgjd
         2xgctrqC41b4FP55IFbcCLhOH+aUSiR+D6BsrLKZGSPHoz5MEod4lQMdaDcpX7NLREQx
         0dFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzgudLSASYodfIrk8AAoHV5Lgd0Lu/H8iin/KUvs0fz3XnwDaVY34BOds2/znLTjIP07IA2oCM3auQCDXC0nhfv1n/LXtoOf0AREZbY0qG69e4bMhytElZGs+oOFRvTp14qj0t78WH
X-Gm-Message-State: AOJu0Yx6EkEzDrfj4HgGjejnGb1rjpIGMT+lpiuNSJflXq3H/lEPk+fe
	SJ+A6oZ1AYx5gx7loCf9slYEXuMooKWry9UBhX7BkhdDyzG+1Vms
X-Google-Smtp-Source: AGHT+IHUF86fV2+L7QYO8RxkMKSYjX9iXLEtL6b3ZfmbzbJ7ry+ksWZVdOONka7cVveOF84vxazpIA==
X-Received: by 2002:a17:907:7f17:b0:a7d:2bf7:5619 with SMTP id a640c23a62f3a-a7dc50fda98mr53761666b.58.1722529326055;
        Thu, 01 Aug 2024 09:22:06 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::4:1f87])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb9dd3sm921008466b.220.2024.08.01.09.22.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 09:22:05 -0700 (PDT)
Message-ID: <f5c5f602-718a-4408-95d3-ed114398ac26@gmail.com>
Date: Thu, 1 Aug 2024 17:22:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] mm: split underutilized THPs
To: Yu Zhao <yuzhao@google.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org,
 riel@surriel.com, shakeel.butt@linux.dev, roman.gushchin@linux.dev,
 david@redhat.com, baohua@kernel.org, ryan.roberts@arm.com, rppt@kernel.org,
 willy@infradead.org, cerasuolodomenico@gmail.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kernel-team@meta.com
References: <20240730125346.1580150-1-usamaarif642@gmail.com>
 <CAOUHufb7z13u51VCTGZMimoCXpmfT5AOAbrUpAvJjTx5+AXwew@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAOUHufb7z13u51VCTGZMimoCXpmfT5AOAbrUpAvJjTx5+AXwew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 01/08/2024 07:09, Yu Zhao wrote:
> On Tue, Jul 30, 2024 at 6:54 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>
>> The current upstream default policy for THP is always. However, Meta
>> uses madvise in production as the current THP=always policy vastly
>> overprovisions THPs in sparsely accessed memory areas, resulting in
>> excessive memory pressure and premature OOM killing.
>> Using madvise + relying on khugepaged has certain drawbacks over
>> THP=always. Using madvise hints mean THPs aren't "transparent" and
>> require userspace changes. Waiting for khugepaged to scan memory and
>> collapse pages into THP can be slow and unpredictable in terms of performance
>> (i.e. you dont know when the collapse will happen), while production
>> environments require predictable performance. If there is enough memory
>> available, its better for both performance and predictability to have
>> a THP from fault time, i.e. THP=always rather than wait for khugepaged
>> to collapse it, and deal with sparsely populated THPs when the system is
>> running out of memory.
>>
>> This patch-series is an attempt to mitigate the issue of running out of
>> memory when THP is always enabled. During runtime whenever a THP is being
>> faulted in or collapsed by khugepaged, the THP is added to a list.
>> Whenever memory reclaim happens, the kernel runs the deferred_split
>> shrinker which goes through the list and checks if the THP was underutilized,
>> i.e. how many of the base 4K pages of the entire THP were zero-filled.
>> If this number goes above a certain threshold, the shrinker will attempt
>> to split that THP. Then at remap time, the pages that were zero-filled are
>> not remapped, hence saving memory. This method avoids the downside of
>> wasting memory in areas where THP is sparsely filled when THP is always
>> enabled, while still providing the upside THPs like reduced TLB misses without
>> having to use madvise.
>>
>> Meta production workloads that were CPU bound (>99% CPU utilzation) were
>> tested with THP shrinker. The results after 2 hours are as follows:
>>
>>                             | THP=madvise |  THP=always   | THP=always
>>                             |             |               | + shrinker series
>>                             |             |               | + max_ptes_none=409
>> -----------------------------------------------------------------------------
>> Performance improvement     |      -      |    +1.8%      |     +1.7%
>> (over THP=madvise)          |             |               |
>> -----------------------------------------------------------------------------
>> Memory usage                |    54.6G    | 58.8G (+7.7%) |   55.9G (+2.4%)
>> -----------------------------------------------------------------------------
>> max_ptes_none=409 means that any THP that has more than 409 out of 512
>> (80%) zero filled filled pages will be split.
>>
>> To test out the patches, the below commands without the shrinker will
>> invoke OOM killer immediately and kill stress, but will not fail with
>> the shrinker:
>>
>> echo 450 > /sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_none
>> mkdir /sys/fs/cgroup/test
>> echo $$ > /sys/fs/cgroup/test/cgroup.procs
>> echo 20M > /sys/fs/cgroup/test/memory.max
>> echo 0 > /sys/fs/cgroup/test/memory.swap.max
>> # allocate twice memory.max for each stress worker and touch 40/512 of
>> # each THP, i.e. vm-stride 50K.
>> # With the shrinker, max_ptes_none of 470 and below won't invoke OOM
>> # killer.
>> # Without the shrinker, OOM killer is invoked immediately irrespective
>> # of max_ptes_none value and kill stress.
>> stress --vm 1 --vm-bytes 40M --vm-stride 50K
>>
>> Patches 1-2 add back helper functions that were previously removed
>> to operate on page lists (needed by patch 3).
>> Patch 3 is an optimization to free zapped tail pages rather than
>> waiting for page reclaim or migration.
>> Patch 4 is a prerequisite for THP shrinker to not remap zero-filled
>> subpages when splitting THP.
>> Patches 6 adds support for THP shrinker.
>>
>> (This patch-series restarts the work on having a THP shrinker in kernel
>> originally done in
>> https://lore.kernel.org/all/cover.1667454613.git.alexlzhu@fb.com/.
>> The THP shrinker in this series is significantly different than the
>> original one, hence its labelled v1 (although the prerequisite to not
>> remap clean subpages is the same).)
>>
>> Alexander Zhu (1):
>>   mm: add selftests to split_huge_page() to verify unmap/zap of zero
>>     pages
>>
>> Usama Arif (3):
>>   Revert "memcg: remove mem_cgroup_uncharge_list()"
>>   Revert "mm: remove free_unref_page_list()"
>>   mm: split underutilized THPs
>>
>> Yu Zhao (2):
>>   mm: free zapped tail pages when splitting isolated thp
>>   mm: don't remap unused subpages when splitting isolated thp
> 
>  I would recommend shatter [1] instead of splitting so that
> 1) whoever underutilized their THPs get punished for the overhead;
> 2) underutilized THPs are kept intact and can be reused by others.
> 
> [1] https://lore.kernel.org/20240229183436.4110845-3-yuzhao@google.com/

The objective of this series is to reduce memory usage, while trying to keep the performance benefits you get of using THP=always. Punishing any applications performance is the opposite of what I am trying to do here.
For e.g. if there is only one main application running in production, and its using majority of the THPs, then reducing its performance doesn't make sense.

Also, just going through the commit, and found the line "The advantage of shattering is that it keeps the original THP intact" a bit confusing. I am guessing the THP is freed? i.e. if a 2M THP has 10 non-zero filled base pages and the rest are zero-filled, then after shattering we will have 10*4K memory and not 2M+10*4K? Is it the case the THP is reused at next fault?

