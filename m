Return-Path: <linux-kernel+bounces-271596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E4F945089
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFFF8284785
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9141E1B3F27;
	Thu,  1 Aug 2024 16:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gMh9Qf6y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC341B3F05
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 16:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722529649; cv=none; b=ZfBk3iNOh4uxQZCsad3aiZF0UW//nxmijJatGP0NsY+/Nbt12/LYwNyemRsL58ThnncdBHQZsBWDp1razwlUr4Ts56b5M9dA9U+t1crvGkkH2WzWZHIu3cRN1l0K7zlE8/6ZRky/yCvDl8LTT3twFHk1SYF6W1HCQTPD0DaRx0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722529649; c=relaxed/simple;
	bh=sYZ5bKEa2vwocH1T3XJin/eJ+KiByIs/PbJvP+pbNWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u682IwQhuVIDA4dTHtpElMEJRoThcnA66OxZeeF1ndmrZDjzhdPaHrSH3NkvzMcuYcNUR3uqwqXbi0aBWJl/zSy+7gWx8WulaeulOPSJmzK59Oi1t7YDb6nPu66i+141OhhnqXekSzLQ3hq4iQ1iR7V5e9scYX/3Zqzs5VIMC/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gMh9Qf6y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722529646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sGT3n6LoTx3/d3SyMjvU1a53qjkkl05R7B/3FJ3JRRc=;
	b=gMh9Qf6ycE6oZ7/csdeVA5MxJIy/DQ6ss2SrZTFCSLUtB1jEBfaQY97bLL3Hb31hq+i1++
	uPGqcm1Jbc/wbzkPy6duQvguh6fWm+lIJydpTkCx0PGSH+pHPxCMz72hq/V6BOfPZOobBn
	BuodViHX/vGhprZGJJAFddKu4Pg296M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-Smu90cE0Nn2dt9KalurfYw-1; Thu, 01 Aug 2024 12:27:25 -0400
X-MC-Unique: Smu90cE0Nn2dt9KalurfYw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-427ffa0c9c7so66849055e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 09:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722529644; x=1723134444;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sGT3n6LoTx3/d3SyMjvU1a53qjkkl05R7B/3FJ3JRRc=;
        b=u2xOcrs+VqO+xzefwQzZRxGVp9v6o4ajlcjopLdSC/ANngrdawamb7LNE/acFz09Us
         baYhUXc/CXrqEi+I7yqaGG+OJ/8VWj22h3JfMzFIMuxpiFglJLnHMvh7KETNNcbgHl26
         kzNa2Da56fTd/qnrslzo5gWyB5mUDMsKD0TWoM7tC1xmHyAN6S8Aaj9LuhEAek3sm0WJ
         31dJ9+xJPk3Ej7dRWS7Gk5vlIEgmuCXewmtgMFma8tAaR4pHo1h+fCK1Bus6XZmILLAE
         ghGfiG/+Jdon3DfWIMm8TUr8Duj4HsXHwWn4GdS0pI5dPyw6SraI2NRyyvsP0bsXz1eo
         utSw==
X-Forwarded-Encrypted: i=1; AJvYcCVFMIKR/2Aa95Rbl7i8dBCp6VmPUDBTCi9L8c5Cd/d7eACxIFH7XThtukbT6Kzo6/wUkfUHfnSN7N9lxXIrwTstOqIxtqEck8dFrSsz
X-Gm-Message-State: AOJu0Yw1F0ogMsgWMTUC/jhGikNPk6tY4HSO/h14On5N0iS4G1ThOoz4
	4SCs5y3PjuopK3tPSG8n5ENdUZwCD5jnlJlXqzZl+WAJ5c1DiPOUZgrNrT5qFk/UAqWu+NGp7aE
	SK0VlNs+r3iDvq1XmV/5ZpKmgEbHCl9rnbM/+6gf6PeZ1dpqibX1XG/m/KyMQNQ==
X-Received: by 2002:a05:600c:3d0b:b0:428:fcb:962 with SMTP id 5b1f17b1804b1-428e6b956e2mr3187435e9.36.1722529643815;
        Thu, 01 Aug 2024 09:27:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiIXJIphIdlNN8PrOJMV2NgCT5W5MzZlMG7lvlG7J9DdbrNPEccTlGOCkmG9yPPATJOxitCw==
X-Received: by 2002:a05:600c:3d0b:b0:428:fcb:962 with SMTP id 5b1f17b1804b1-428e6b956e2mr3187095e9.36.1722529643242;
        Thu, 01 Aug 2024 09:27:23 -0700 (PDT)
Received: from [192.168.3.141] (p4ff235e4.dip0.t-ipconnect.de. [79.242.53.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36862516sm19749091f8f.104.2024.08.01.09.27.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 09:27:22 -0700 (PDT)
Message-ID: <524fb638-73b2-45e7-ae2c-7445d394ed50@redhat.com>
Date: Thu, 1 Aug 2024 18:27:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] mm: split underutilized THPs
To: Usama Arif <usamaarif642@gmail.com>, Yu Zhao <yuzhao@google.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org,
 riel@surriel.com, shakeel.butt@linux.dev, roman.gushchin@linux.dev,
 baohua@kernel.org, ryan.roberts@arm.com, rppt@kernel.org,
 willy@infradead.org, cerasuolodomenico@gmail.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kernel-team@meta.com
References: <20240730125346.1580150-1-usamaarif642@gmail.com>
 <CAOUHufb7z13u51VCTGZMimoCXpmfT5AOAbrUpAvJjTx5+AXwew@mail.gmail.com>
 <f5c5f602-718a-4408-95d3-ed114398ac26@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <f5c5f602-718a-4408-95d3-ed114398ac26@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01.08.24 18:22, Usama Arif wrote:
> 
> 
> On 01/08/2024 07:09, Yu Zhao wrote:
>> On Tue, Jul 30, 2024 at 6:54 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>>
>>> The current upstream default policy for THP is always. However, Meta
>>> uses madvise in production as the current THP=always policy vastly
>>> overprovisions THPs in sparsely accessed memory areas, resulting in
>>> excessive memory pressure and premature OOM killing.
>>> Using madvise + relying on khugepaged has certain drawbacks over
>>> THP=always. Using madvise hints mean THPs aren't "transparent" and
>>> require userspace changes. Waiting for khugepaged to scan memory and
>>> collapse pages into THP can be slow and unpredictable in terms of performance
>>> (i.e. you dont know when the collapse will happen), while production
>>> environments require predictable performance. If there is enough memory
>>> available, its better for both performance and predictability to have
>>> a THP from fault time, i.e. THP=always rather than wait for khugepaged
>>> to collapse it, and deal with sparsely populated THPs when the system is
>>> running out of memory.
>>>
>>> This patch-series is an attempt to mitigate the issue of running out of
>>> memory when THP is always enabled. During runtime whenever a THP is being
>>> faulted in or collapsed by khugepaged, the THP is added to a list.
>>> Whenever memory reclaim happens, the kernel runs the deferred_split
>>> shrinker which goes through the list and checks if the THP was underutilized,
>>> i.e. how many of the base 4K pages of the entire THP were zero-filled.
>>> If this number goes above a certain threshold, the shrinker will attempt
>>> to split that THP. Then at remap time, the pages that were zero-filled are
>>> not remapped, hence saving memory. This method avoids the downside of
>>> wasting memory in areas where THP is sparsely filled when THP is always
>>> enabled, while still providing the upside THPs like reduced TLB misses without
>>> having to use madvise.
>>>
>>> Meta production workloads that were CPU bound (>99% CPU utilzation) were
>>> tested with THP shrinker. The results after 2 hours are as follows:
>>>
>>>                              | THP=madvise |  THP=always   | THP=always
>>>                              |             |               | + shrinker series
>>>                              |             |               | + max_ptes_none=409
>>> -----------------------------------------------------------------------------
>>> Performance improvement     |      -      |    +1.8%      |     +1.7%
>>> (over THP=madvise)          |             |               |
>>> -----------------------------------------------------------------------------
>>> Memory usage                |    54.6G    | 58.8G (+7.7%) |   55.9G (+2.4%)
>>> -----------------------------------------------------------------------------
>>> max_ptes_none=409 means that any THP that has more than 409 out of 512
>>> (80%) zero filled filled pages will be split.
>>>
>>> To test out the patches, the below commands without the shrinker will
>>> invoke OOM killer immediately and kill stress, but will not fail with
>>> the shrinker:
>>>
>>> echo 450 > /sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_none
>>> mkdir /sys/fs/cgroup/test
>>> echo $$ > /sys/fs/cgroup/test/cgroup.procs
>>> echo 20M > /sys/fs/cgroup/test/memory.max
>>> echo 0 > /sys/fs/cgroup/test/memory.swap.max
>>> # allocate twice memory.max for each stress worker and touch 40/512 of
>>> # each THP, i.e. vm-stride 50K.
>>> # With the shrinker, max_ptes_none of 470 and below won't invoke OOM
>>> # killer.
>>> # Without the shrinker, OOM killer is invoked immediately irrespective
>>> # of max_ptes_none value and kill stress.
>>> stress --vm 1 --vm-bytes 40M --vm-stride 50K
>>>
>>> Patches 1-2 add back helper functions that were previously removed
>>> to operate on page lists (needed by patch 3).
>>> Patch 3 is an optimization to free zapped tail pages rather than
>>> waiting for page reclaim or migration.
>>> Patch 4 is a prerequisite for THP shrinker to not remap zero-filled
>>> subpages when splitting THP.
>>> Patches 6 adds support for THP shrinker.
>>>
>>> (This patch-series restarts the work on having a THP shrinker in kernel
>>> originally done in
>>> https://lore.kernel.org/all/cover.1667454613.git.alexlzhu@fb.com/.
>>> The THP shrinker in this series is significantly different than the
>>> original one, hence its labelled v1 (although the prerequisite to not
>>> remap clean subpages is the same).)
>>>
>>> Alexander Zhu (1):
>>>    mm: add selftests to split_huge_page() to verify unmap/zap of zero
>>>      pages
>>>
>>> Usama Arif (3):
>>>    Revert "memcg: remove mem_cgroup_uncharge_list()"
>>>    Revert "mm: remove free_unref_page_list()"
>>>    mm: split underutilized THPs
>>>
>>> Yu Zhao (2):
>>>    mm: free zapped tail pages when splitting isolated thp
>>>    mm: don't remap unused subpages when splitting isolated thp
>>
>>   I would recommend shatter [1] instead of splitting so that
>> 1) whoever underutilized their THPs get punished for the overhead;
>> 2) underutilized THPs are kept intact and can be reused by others.
>>
>> [1] https://lore.kernel.org/20240229183436.4110845-3-yuzhao@google.com/
> 
> The objective of this series is to reduce memory usage, while trying to keep the performance benefits you get of using THP=always. Punishing any applications performance is the opposite of what I am trying to do here.
> For e.g. if there is only one main application running in production, and its using majority of the THPs, then reducing its performance doesn't make sense.
> 

I'm not sure if there would really be a performance degradation 
regarding the THP, after all we zap PTEs either way.

Shattering will take longer because real migration is involved IIUC.

> Also, just going through the commit, and found the line "The advantage of shattering is that it keeps the original THP intact" a bit confusing. I am guessing the THP is freed? i.e. if a 2M THP has 10 non-zero filled base pages and the rest are zero-filled, then after shattering we will have 10*4K memory and not 2M+10*4K? Is it the case the THP is reused at next fault?

The idea is (as I understand it) to free the full THP abck to the buddy, 
replacing the individual pieces that are kept to freshly allocated 
order-0 pages from the buddy.

-- 
Cheers,

David / dhildenb


