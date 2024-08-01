Return-Path: <linux-kernel+bounces-271531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B11944F9C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6497D1C22CC0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59B013D2AF;
	Thu,  1 Aug 2024 15:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jfwkgktl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B46D19478
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722527237; cv=none; b=LAiCYcWC4C3g/A+8hP1BO9fj+x+vBldFTdHdNblHIba7GJqk7Z1Vh4IZ9eA4GomnXvmmChRycHF9i3o0fMaAI0a/yuxhBcM5j1Kcr/+dXVyLXrPlcpOEj14dT/FO6YhDLK1ETBHIG7+Nb95LtiEF0oVQ6keB8vHPFwBv+wIY1C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722527237; c=relaxed/simple;
	bh=ilZfXcO6hJA208IVXGrqXYcPS1Sb3+huWsZWxE45Zu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bgYdSY590ZUIJgctj8Asd++6Diq51XJ52cxYzIAgEg4vW/RHv0VTPkVsrkURGMbEhoOACz/Ap6OQHHxOYOttxEyRwJv7EqEoMyisPhYO6F0AY7eeTKYm9s3e1vGNf5gd4OYYhy6tlTGhoIhjigVLtns3yvo+WlRinvodoDod/cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jfwkgktl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722527234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ewe0F8RHcsWNAOv/6wp3EHuEcI8EE8F+ESfbBnzRHNA=;
	b=Jfwkgktl2witNHxzYmCZukT5auvxhW8mIf4XMohXGp3SuKKq9yc7BBZhQl50uq77Zh6dAT
	YFzhlJyCqvwuweK6E08SNA6BQdlkuZDqME/MdY2YMFiI1AzBh9Njl8II6+hBhMC5zTNmNk
	3ZX5TAHOaaAqxgIiDjcaf5S59dYedGs=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-DuMf5YiQOO6WBw3OMdGxqw-1; Thu, 01 Aug 2024 11:47:12 -0400
X-MC-Unique: DuMf5YiQOO6WBw3OMdGxqw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ef31dbc770so68591781fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 08:47:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722527231; x=1723132031;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ewe0F8RHcsWNAOv/6wp3EHuEcI8EE8F+ESfbBnzRHNA=;
        b=MnMaF4HchlYI0L/6vegPw5RkFUwL3E/bZaztGa1w1FG6DYhhG/X1TtTVIxX4QrVV35
         pZl20+OTHp98jNtjKDZBZ5UFrIEFwhhLwgUCvAFXDf+9LF2vBaWQCk21k6WhTKu0mcbW
         wNyjrd3S0O/Dnhb/qUZUPAmUWSrnocVr3t+Q7DBSc1Ezfs+2/7oXtPZ0tl+laG4kOXMb
         MDpqrKjhUYkmx2uNCdK9oXo/wFv8U8IpS/xHIGCZ6ETOKIS6pDTNwuvFqWK2OmlvuMRO
         083OU5eeodKXgiH5h6UrSxIAoVJpNWjvusGpfR2/IQMY+k2B1rVGJQ/ARzRHnPNxmulp
         n4Eg==
X-Forwarded-Encrypted: i=1; AJvYcCWr5drtSvs0QOZwLI8EW36iA9AbKsVvsXz28fKCmNbjfpogwgu4BXkJZ2028EpJwSeG9EJGQKDbWt9krqByBJXWROfpdcee4ThsYDS+
X-Gm-Message-State: AOJu0YwPNASAqBf2YtVSuQ9s10gqEbFecYphKgWaro6seFnu18XGXO9i
	lJuIx7DC86a0wgvnSEzeABkWVVZVcMxwc/q79QVyGsUlwHdGtxIj0Wd3iQ7miqUY6OstMKd/dtK
	kj61qMto4CIMc7jWuJKrt9a/IYLxxYfR4BhGLCi1cjDsP/Q2Zl4afXfSCMcJt/g==
X-Received: by 2002:a2e:988d:0:b0:2ef:248a:aed4 with SMTP id 38308e7fff4ca-2f15ab530a4mr4884881fa.42.1722527231226;
        Thu, 01 Aug 2024 08:47:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5D9Qf22isUn/qIPSJKFlRTUhRHS1FC8fnZFiTlSa9rUzwVvalNpih/lMsHHWZ9ysCUpY1Ig==
X-Received: by 2002:a2e:988d:0:b0:2ef:248a:aed4 with SMTP id 38308e7fff4ca-2f15ab530a4mr4884681fa.42.1722527230602;
        Thu, 01 Aug 2024 08:47:10 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:5c00:e650:bcd7:e2a0:54fe? (p200300cbc7075c00e650bcd7e2a054fe.dip0.t-ipconnect.de. [2003:cb:c707:5c00:e650:bcd7:e2a0:54fe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6cd8d67sm1542685e9.0.2024.08.01.08.47.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 08:47:10 -0700 (PDT)
Message-ID: <aea333fb-44ab-41eb-9060-472b08e3010d@redhat.com>
Date: Thu, 1 Aug 2024 17:47:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] mm: split underutilized THPs
To: Yu Zhao <yuzhao@google.com>, Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org,
 riel@surriel.com, shakeel.butt@linux.dev, roman.gushchin@linux.dev,
 baohua@kernel.org, ryan.roberts@arm.com, rppt@kernel.org,
 willy@infradead.org, cerasuolodomenico@gmail.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kernel-team@meta.com
References: <20240730125346.1580150-1-usamaarif642@gmail.com>
 <CAOUHufb7z13u51VCTGZMimoCXpmfT5AOAbrUpAvJjTx5+AXwew@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAOUHufb7z13u51VCTGZMimoCXpmfT5AOAbrUpAvJjTx5+AXwew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01.08.24 08:09, Yu Zhao wrote:
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
>>                              | THP=madvise |  THP=always   | THP=always
>>                              |             |               | + shrinker series
>>                              |             |               | + max_ptes_none=409
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
>>    mm: add selftests to split_huge_page() to verify unmap/zap of zero
>>      pages
>>
>> Usama Arif (3):
>>    Revert "memcg: remove mem_cgroup_uncharge_list()"
>>    Revert "mm: remove free_unref_page_list()"
>>    mm: split underutilized THPs
>>
>> Yu Zhao (2):
>>    mm: free zapped tail pages when splitting isolated thp
>>    mm: don't remap unused subpages when splitting isolated thp
> 
>   I would recommend shatter [1] instead of splitting so that
> 1) whoever underutilized their THPs get punished for the overhead;
> 2) underutilized THPs are kept intact and can be reused by others.
> 
> [1] https://lore.kernel.org/20240229183436.4110845-3-yuzhao@google.com/
> 

Do you have any plans to upstream the shattering also during "ordinary" 
deferred splitting?

-- 
Cheers,

David / dhildenb


