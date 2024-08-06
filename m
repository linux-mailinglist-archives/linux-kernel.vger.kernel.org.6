Return-Path: <linux-kernel+bounces-276035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BC5948D8A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20F49B22A27
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C451C0DCF;
	Tue,  6 Aug 2024 11:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGAF4v2t"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E31149C45;
	Tue,  6 Aug 2024 11:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722943091; cv=none; b=V2MNqu7UfAAoeMtOFW6d0SYYvRBhGLRr8QMdwYaTJQHtOZkDmMbOsxjxGaaUQhszS9gb9iMmj2H3YBKnGUsBVDc/wdVzbjSH88mF1SAA9KvIw9fBzi/NC2REXc00e/QI0LcvqS9Cg1d39AiKtPyYAqkhMb3VL9yynbmJXRwC9t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722943091; c=relaxed/simple;
	bh=Lewtl8mxiqopsLHNwf1jFNAdeED31SHaC+EoK/d3fVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uOC1Ots/aGqLkBr8yMHbnIAAuD8PMHrmk4dEGGHKquPS/kkCPE3mYhKjaQA39pZi790Ej2ZBXT0JwdV8vLKRjFNTLxR3JSXAXvX3X7YTqj/VvPHSbP+aroJUmENYX2wWu5LWwPQ8CQs3ojlCHKDYY3jgNDfnXztHb55JAgFQCXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGAF4v2t; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52efbb55d24so876165e87.1;
        Tue, 06 Aug 2024 04:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722943088; x=1723547888; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pdZmIlmEl/z5USosoXB4iHqbx3ZAMH4Dl+lwOwX8j6A=;
        b=MGAF4v2tGDbkoCApvGMbrI/frYxhM/bAIJhO+szaBpoz/bbm+JQkEDFRqPqtPxT/Cp
         bOuMQR0cauCbpHuIOBhUgB1LOhSIk/IH9Wb8E1zgnXvAqWtvbVVXZEj0AJUQyQH2Eq6G
         aH2cPWmQ2fzNhbIAQcWIoNxBva93nfzYLm43pBqByI8eN1+H+IJ1Jlclj7NzsLxfBdCY
         i2FNFDMMcEbZSQpWGBFf9AnnKm9YFgWerrmUSj8NCCLn3I8SqaVkqdyI7mnRfnPdHZTB
         guyubYAusolW+JKn6uoTGixuDTD6v/QQwoaGIfhShFyBUDMMs01u8DN2n+YZGB4UAj5L
         vfnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722943088; x=1723547888;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pdZmIlmEl/z5USosoXB4iHqbx3ZAMH4Dl+lwOwX8j6A=;
        b=ujVu/8ury5MNqfcXWEV/cMteX95pcflU3J9I+MgZJxzef4dyrvhZahgdRcZFE8nlcR
         RIZVtsviPaGs/l5oAVSj3T68SDNLX/3X6zl8WAzMegjAFgIUv36CXTriJ3uXpnohyHGY
         k4oAgAQG1+JlyOYfp9EEy2Yg0V0u0dQ/Wj075yhjUuqMNlXIX6Ue9QI4140JLxydbvfU
         R6QE3I88QlMIa7G2J6jM1w+6LnpdLek8bnZZilnf3z9XJ+NiQqL2LSx1pG1owryBRVXy
         IpUHZiPvXLAH8+dbyTJPKfySLXOgsD1vpBS74nOakWSmXGZLF8cu4Ro6z1L5dQuBfVbP
         rRpg==
X-Forwarded-Encrypted: i=1; AJvYcCW71xv+MyTvWspoCAkzu3xT5kFdikypDTA2NxIjP5YEDI2xRxPRDtbXpigKbv79obqR6u/MkEIIZeSEHGEGzLBwdAc+aAPkGouat9+EEz599aC7VMfGDFie+1CzRBu36jmxlTmn4ulB
X-Gm-Message-State: AOJu0Ywu/G9QYL1iQvC7Y9N4H3E3W03CeNi3Ry6M9ZiEuvxq6/GRUCpr
	wAJ5U9IHGhXP3mOWuoAXk8NeJcpaiKVylFdvgBB8as3MXSptPCRI
X-Google-Smtp-Source: AGHT+IGh3JogPgDcEth2xxsigXyXrQun6H4DpMT8X7FGQBPiQ7Tsax7chUQ9M9K8qgETdvi6Dn17ng==
X-Received: by 2002:a05:6512:1092:b0:52e:976a:b34b with SMTP id 2adb3069b0e04-530bb381012mr10644770e87.15.1722943087518;
        Tue, 06 Aug 2024 04:18:07 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::7:c24b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e85286sm548986966b.171.2024.08.06.04.18.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 04:18:07 -0700 (PDT)
Message-ID: <983a580f-11a9-442b-8b41-e9c2e4f0d113@gmail.com>
Date: Tue, 6 Aug 2024 12:18:06 +0100
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
 <f5c5f602-718a-4408-95d3-ed114398ac26@gmail.com>
 <CAOUHufY9B6UEgOG1atezS_U7rsfr-1exavccpRUKhmOwUd2kdQ@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAOUHufY9B6UEgOG1atezS_U7rsfr-1exavccpRUKhmOwUd2kdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 05/08/2024 00:23, Yu Zhao wrote:
> On Thu, Aug 1, 2024 at 10:22 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>
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
>>>>                             | THP=madvise |  THP=always   | THP=always
>>>>                             |             |               | + shrinker series
>>>>                             |             |               | + max_ptes_none=409
>>>> -----------------------------------------------------------------------------
>>>> Performance improvement     |      -      |    +1.8%      |     +1.7%
>>>> (over THP=madvise)          |             |               |
>>>> -----------------------------------------------------------------------------
>>>> Memory usage                |    54.6G    | 58.8G (+7.7%) |   55.9G (+2.4%)
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
>>>>   mm: add selftests to split_huge_page() to verify unmap/zap of zero
>>>>     pages
>>>>
>>>> Usama Arif (3):
>>>>   Revert "memcg: remove mem_cgroup_uncharge_list()"
>>>>   Revert "mm: remove free_unref_page_list()"
>>>>   mm: split underutilized THPs
>>>>
>>>> Yu Zhao (2):
>>>>   mm: free zapped tail pages when splitting isolated thp
>>>>   mm: don't remap unused subpages when splitting isolated thp
>>>
>>>  I would recommend shatter [1] instead of splitting so that
>>> 1) whoever underutilized their THPs get punished for the overhead;
>>> 2) underutilized THPs are kept intact and can be reused by others.
>>>
>>> [1] https://lore.kernel.org/20240229183436.4110845-3-yuzhao@google.com/
>>
>> The objective of this series is to reduce memory usage, while trying to keep the performance benefits you get of using THP=always.
> 
> Of course.
> 
>> Punishing any applications performance is the opposite of what I am trying to do here.
> 
> For applications that prefer THP=always, you would punish them more by
> using split.
> 
>> For e.g. if there is only one main application running in production, and its using majority of the THPs, then reducing its performance doesn't make sense.
> 
> Exactly, and that's why I recommended shatter.
> 
> Let's walk through the big picture, and hopefully you'll agree.
> 
> Applications prefer THP=always because they want to allocate THPs. As
> you mentioned above, the majority of their memory would be backed by
> THPs, highly utilized.
> 
> You also mentioned that those applications can run into memory
> pressure or even OOMs, which I agree, and this is essentially what we
> are trying to solve here. Otherwise, with unlimited memory, we
> wouldn't need to worry about internal fragmentation in this context.
> 
> So on one hand, we want to allocate THPs; on the other, we run into
> memory pressure. It's obvious that splitting under this specific
> condition can't fully solve our problem -- after splitting, we still
> have to do compaction to fulfill new THP allocation requests.
> Theoretically, splitting plus compaction is more expensive than
> shattering itself: expressing the efficiency in
> compact_success/(compact_success+fail), the latter is 100%; the former
> is nowhere near it, and our experiments agree with this.
> 
> If applications opt for direct compaction, they'd pay for THP
> allocation latency; if they don't want to wait, i.e., with background
> compaction, but they'd pay for less THP coverage. So they are punished
> either way, not in the THP shrinker path, but in their allocation
> path. In comparison, shattering wins in both cases, as I explained
> above.

Thanks for the explanation. It makes the reason behind shattering much more clearer, and it explains why it could be an improvement over splitting.

As Rik mentioned, I think its best to parallelize the efforts of THP low utilization shrinker and shattering, as we already have the low utilization shrinker tested and ready with splitting.

I did have a question about shattering, I will mention it here but it probably is best to move the discussion over to the shattering patches you sent.

If the system is close to running out of memory and the shrinker has a very large number of folios to shatter, then the initial THPs that are shattered by shrinker will take the order-0 pages for migration of non-zero filled pages. The system could run out of order-0 pages for the latter THPs, so the THPs that were preserved earlier in the shrinker process would need to be split to provide the order-0 pages for migration needed for shattering the latter THPs?
The cost then becomes the cost of migration + the cost of splitting the THPs preserved earlier by the shrinker to provide 4K pages for migration (which means the advantage of preserving these THPs is lost?) + the cost of compaction when we later want THPs.

Hopefully I understood what would happen in the above case correctly with shattering.


> 
>> Also, just going through the commit, and found the line "The advantage of shattering is that it keeps the original THP intact" a bit confusing. I am guessing the THP is freed?
> 
> Yes, so that we don't have to do compaction.
> 
>> i.e. if a 2M THP has 10 non-zero filled base pages and the rest are zero-filled, then after shattering we will have 10*4K memory and not 2M+10*4K?
> 
> Correct.
> 
>> Is it the case the THP is reused at next fault?
> 
> Yes, and this is central to our condition: we are under memory
> pressure with THP=always.

