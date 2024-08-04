Return-Path: <linux-kernel+bounces-273979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F3B94704E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 21:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDFD82811BB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 19:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E9513635F;
	Sun,  4 Aug 2024 19:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7CRGxHX"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61894405;
	Sun,  4 Aug 2024 19:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722798610; cv=none; b=GDw21dTky7Ujz6rpxBd3dFy6XYk5vKy9hSZoPWE9KuvoxupNrupK9qzho4Z7/PvnQsvTWswSoAU57c3I/D6FcgyIHqoq/a5CB4Pg6WnvwwYqMLvXvw2yP9AtXaw40UUMPRF8eFfcT5z3jnvgxrCZRNMIB7qPs6euq1STtzcSiCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722798610; c=relaxed/simple;
	bh=maKgyXHw7PkWpQ8+qYdh87KxeyUsaHMsyay3Vpmii/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IyqulfbF/v13LjEcDz85na4GUxhr6bLxQPcIdd2J+v2+8asmYqKUwpvNQsykMMxHkhaEX8/llvU8pSpkilxvNAqqOwOIoLi1PD+Hi3moKKbQa0EukRsnGsWHmahlxWqijPSxco8utbEAbeftHq4p2fjxBCUvFADxJEUhngi0Vhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7CRGxHX; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4257d5fc9b7so88962795e9.2;
        Sun, 04 Aug 2024 12:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722798607; x=1723403407; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OjpcQuLFfE0naciE0n9rdeGl+Jtzp1VMCC4VkdZxVU8=;
        b=D7CRGxHXIQ7FUyRKW231r7X37EtgbU1upyO+IXtt4nH/ZqahCOI1eToEboL3KNrQgo
         SP7o8xaJ7VFbgOIEdbBod4Xo9Z2nuK96CyxTVXQO1NzsXYU4W02EtZjH1DoJr8nd0iSJ
         442SheYac0btUee/9mM5E48JoUHr8Doz8xqUIvICft/eZUlAgyvEFNWVJekXv7THJsFK
         ATeKsPjHTeicsA+OFctsMzCfxRdET0CaGmECZL3izjEChrxW8SoQ6oGLARwW0b5j5odV
         qDACxbrIwTKmCU6cq4OJ9OoRI2w89jByEtnb8t9u9xe9AxPt3TVLfjQAuj6P+xfo/GcA
         nnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722798607; x=1723403407;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OjpcQuLFfE0naciE0n9rdeGl+Jtzp1VMCC4VkdZxVU8=;
        b=fQ3abV7kyz4uCsuoeWkY4/xoTFSddX4nHV3lcYXXJxoQMtVr8hEhxYKQFeg56cFQ6K
         Mzlr4lRxR47Yl0Ia0BxFjHzTWpaqf9fPlTf6CjGkLo7D5JDoBoxUxnzh1fTl1Coog8u6
         uuYdfwX823Mumkm2UPejshBGtCihufFzo1TDctu6ZO48heijPVcUWwUcJnhq0IFugcXH
         BPOpuyDNfx0VKYWaK1fexO9uwtr8++Iffv+hXAQt6d8X4QNPIOfW7PdVEvuNxwtoTyX3
         NQpA8avChCRHdRnAbSiG+3usNeasnv2V6ZhmxWIHKQRFM+q/P0SP9CgMMM3RsntGnSzJ
         K5PA==
X-Forwarded-Encrypted: i=1; AJvYcCV5JPl0Ep6JAcYc6dUnZ3TYfH9FAk6juVIEgPwpHdJW37xIODOOOJpXqBZmsLnJExOk1xLqIjgdlR8yeJZNCYt5efgUE1KPyAKKNkWDTzhn1r+Jw7SQoDt5FqAMCddUiNyryFi1Mj2w
X-Gm-Message-State: AOJu0Yx2wDFWvDg624G0ijdULeCfJtT5NdeWlT2P3yI5Bsofs51dn4z+
	Q6hYay9rVFvlmsYqJyCNPJcshs55TlgvDLKNdW0ukVa5W8jT8XTU
X-Google-Smtp-Source: AGHT+IEMLXwtZcqtBqEnlV8z+R1encQdJiwkQymliNGWyWZdYEt5wfHLsr+0MqUlzc53E2Uoo3EKJw==
X-Received: by 2002:a05:600c:3504:b0:427:f196:c549 with SMTP id 5b1f17b1804b1-428e6b7e954mr89635965e9.23.1722798606501;
        Sun, 04 Aug 2024 12:10:06 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e750:7600:c5:51ce:2b5:970b? ([2a02:6b6f:e750:7600:c5:51ce:2b5:970b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e7cc3asm110306365e9.34.2024.08.04.12.10.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Aug 2024 12:10:06 -0700 (PDT)
Message-ID: <c617e6f2-f7a8-4f84-9458-6e69d7fe64e3@gmail.com>
Date: Sun, 4 Aug 2024 20:10:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] mm: split underutilized THPs
To: David Hildenbrand <david@redhat.com>, Yu Zhao <yuzhao@google.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org,
 riel@surriel.com, shakeel.butt@linux.dev, roman.gushchin@linux.dev,
 baohua@kernel.org, ryan.roberts@arm.com, rppt@kernel.org,
 willy@infradead.org, cerasuolodomenico@gmail.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kernel-team@meta.com
References: <20240730125346.1580150-1-usamaarif642@gmail.com>
 <CAOUHufb7z13u51VCTGZMimoCXpmfT5AOAbrUpAvJjTx5+AXwew@mail.gmail.com>
 <f5c5f602-718a-4408-95d3-ed114398ac26@gmail.com>
 <524fb638-73b2-45e7-ae2c-7445d394ed50@redhat.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <524fb638-73b2-45e7-ae2c-7445d394ed50@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 01/08/2024 17:27, David Hildenbrand wrote:
> On 01.08.24 18:22, Usama Arif wrote:
>>
>>
>> On 01/08/2024 07:09, Yu Zhao wrote:
>>> On Tue, Jul 30, 2024 at 6:54 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>>>
>>>> The current upstream default policy for THP is always. However, Meta
>>>> uses madvise in production as the current THP=always policy vastly
>>>> overprovisions THPs in sparsely accessed memory areas, resulting in
>>>> excessive memory pressure and premature OOM killing.
>>>> Using madvise + relying on khugepaged has certain drawbacks over
>>>> THP=always. Using madvise hints mean THPs aren't "transparent" and
>>>> require userspace changes. Waiting for khugepaged to scan memory and
>>>> collapse pages into THP can be slow and unpredictable in terms of performance
>>>> (i.e. you dont know when the collapse will happen), while production
>>>> environments require predictable performance. If there is enough memory
>>>> available, its better for both performance and predictability to have
>>>> a THP from fault time, i.e. THP=always rather than wait for khugepaged
>>>> to collapse it, and deal with sparsely populated THPs when the system is
>>>> running out of memory.
>>>>
>>>> This patch-series is an attempt to mitigate the issue of running out of
>>>> memory when THP is always enabled. During runtime whenever a THP is being
>>>> faulted in or collapsed by khugepaged, the THP is added to a list.
>>>> Whenever memory reclaim happens, the kernel runs the deferred_split
>>>> shrinker which goes through the list and checks if the THP was underutilized,
>>>> i.e. how many of the base 4K pages of the entire THP were zero-filled.
>>>> If this number goes above a certain threshold, the shrinker will attempt
>>>> to split that THP. Then at remap time, the pages that were zero-filled are
>>>> not remapped, hence saving memory. This method avoids the downside of
>>>> wasting memory in areas where THP is sparsely filled when THP is always
>>>> enabled, while still providing the upside THPs like reduced TLB misses without
>>>> having to use madvise.
>>>>
>>>> Meta production workloads that were CPU bound (>99% CPU utilzation) were
>>>> tested with THP shrinker. The results after 2 hours are as follows:
>>>>
>>>>                              | THP=madvise |  THP=always   | THP=always
>>>>                              |             |               | + shrinker series
>>>>                              |             |               | + max_ptes_none=409
>>>> -----------------------------------------------------------------------------
>>>> Performance improvement     |      -      |    +1.8%      |     +1.7%
>>>> (over THP=madvise)          |             |               |
>>>> -----------------------------------------------------------------------------
>>>> Memory usage                |    54.6G    | 58.8G (+7.7%) |   55.9G (+2.4%)
>>>> -----------------------------------------------------------------------------
>>>> max_ptes_none=409 means that any THP that has more than 409 out of 512
>>>> (80%) zero filled filled pages will be split.
>>>>
>>>> To test out the patches, the below commands without the shrinker will
>>>> invoke OOM killer immediately and kill stress, but will not fail with
>>>> the shrinker:
>>>>
>>>> echo 450 > /sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_none
>>>> mkdir /sys/fs/cgroup/test
>>>> echo $$ > /sys/fs/cgroup/test/cgroup.procs
>>>> echo 20M > /sys/fs/cgroup/test/memory.max
>>>> echo 0 > /sys/fs/cgroup/test/memory.swap.max
>>>> # allocate twice memory.max for each stress worker and touch 40/512 of
>>>> # each THP, i.e. vm-stride 50K.
>>>> # With the shrinker, max_ptes_none of 470 and below won't invoke OOM
>>>> # killer.
>>>> # Without the shrinker, OOM killer is invoked immediately irrespective
>>>> # of max_ptes_none value and kill stress.
>>>> stress --vm 1 --vm-bytes 40M --vm-stride 50K
>>>>
>>>> Patches 1-2 add back helper functions that were previously removed
>>>> to operate on page lists (needed by patch 3).
>>>> Patch 3 is an optimization to free zapped tail pages rather than
>>>> waiting for page reclaim or migration.
>>>> Patch 4 is a prerequisite for THP shrinker to not remap zero-filled
>>>> subpages when splitting THP.
>>>> Patches 6 adds support for THP shrinker.
>>>>
>>>> (This patch-series restarts the work on having a THP shrinker in kernel
>>>> originally done in
>>>> https://lore.kernel.org/all/cover.1667454613.git.alexlzhu@fb.com/.
>>>> The THP shrinker in this series is significantly different than the
>>>> original one, hence its labelled v1 (although the prerequisite to not
>>>> remap clean subpages is the same).)
>>>>
>>>> Alexander Zhu (1):
>>>>    mm: add selftests to split_huge_page() to verify unmap/zap of zero
>>>>      pages
>>>>
>>>> Usama Arif (3):
>>>>    Revert "memcg: remove mem_cgroup_uncharge_list()"
>>>>    Revert "mm: remove free_unref_page_list()"
>>>>    mm: split underutilized THPs
>>>>
>>>> Yu Zhao (2):
>>>>    mm: free zapped tail pages when splitting isolated thp
>>>>    mm: don't remap unused subpages when splitting isolated thp
>>>
>>>   I would recommend shatter [1] instead of splitting so that
>>> 1) whoever underutilized their THPs get punished for the overhead;
>>> 2) underutilized THPs are kept intact and can be reused by others.
>>>
>>> [1] https://lore.kernel.org/20240229183436.4110845-3-yuzhao@google.com/
>>
>> The objective of this series is to reduce memory usage, while trying to keep the performance benefits you get of using THP=always. Punishing any applications performance is the opposite of what I am trying to do here.
>> For e.g. if there is only one main application running in production, and its using majority of the THPs, then reducing its performance doesn't make sense.
>>
> 
> I'm not sure if there would really be a performance degradation regarding the THP, after all we zap PTEs either way.
>

By performance I meant time/CPU used up for migration.
 
> Shattering will take longer because real migration is involved IIUC.
>

Yes, so thats what I want to avoid. If the system is CPU bound like the production workload I am testing, then spending any cycles on migration is going to make time/CPU performance worse.
 
Also, shattering isn't merged upstream, and it wouldn't make sense to make this series dependent on shattering.

>> Also, just going through the commit, and found the line "The advantage of shattering is that it keeps the original THP intact" a bit confusing. I am guessing the THP is freed? i.e. if a 2M THP has 10 non-zero filled base pages and the rest are zero-filled, then after shattering we will have 10*4K memory and not 2M+10*4K? Is it the case the THP is reused at next fault?
> 
> The idea is (as I understand it) to free the full THP abck to the buddy, replacing the individual pieces that are kept to freshly allocated order-0 pages from the buddy.
> 

