Return-Path: <linux-kernel+bounces-214583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D850B9086C1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1CC81C22699
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 08:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77D51922CC;
	Fri, 14 Jun 2024 08:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AK0OW/FC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79F6187546
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 08:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718355079; cv=none; b=LqkpcKJYIX3ThOQ/WWTVzmdfl9olenWia9dJeimt0AMM7T+AHa4Pa8azlMAZCmskBB4qnU470O52MZ8F0xEztuZcs0lRJSUtDBm4/oeBentCNyPnS0Qi8xYZSKa8MedJX3vgfLGEc/8/hrffUBoRmaOGHkA2+wJIaeoYfclDeFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718355079; c=relaxed/simple;
	bh=8fldpzu5YQHbVabTBE5i4/pUEh6EW9y8eP3q9nv8yGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FxjVe5/n4vySgRuQU8/lDwSRHlvcG0yuEQICJ/QTOC5ucy9TPQWuosffVy+JHkJG3U3QpuT5mQ3Oy2LAMrW9xFn0vjyezyFeyarpLakxyeIpJI/GdO1RETbOTcOgWbo8yeuzKkB/J68X9sQvzueUwmL2cU8MkJ5P0CdszD5bme4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AK0OW/FC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718355076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PsytS7a/+imSTfzmJw541GS5vJYBUHRv7S94N80bBaQ=;
	b=AK0OW/FCCfUfVj95T7DSw4Rl/nytcyM/J3yRJyqL2lpctzao3J2R9d8qsmRcfkoWPNE0Og
	+lDkhX8lfcjJ+uc6Y9uS/Wg1bmPQuuJd6YVcUDDriuhXeKxHp9PzGFlWy75zvBtj6mxO3H
	5oQcbF9MCx3Ak2nFdbrPfUgSOYx0YRc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-D3qQ1NP5P8KLVS1_sB-A5g-1; Fri, 14 Jun 2024 04:51:13 -0400
X-MC-Unique: D3qQ1NP5P8KLVS1_sB-A5g-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4218447b900so10366505e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 01:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718355072; x=1718959872;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PsytS7a/+imSTfzmJw541GS5vJYBUHRv7S94N80bBaQ=;
        b=WEegFRJb0BLi89nD/IC8jWfY3NDh4S8k+8ezQ07s9dgWHcvfcq/O8T2B9F3HrfoN90
         WB8sLhz/EuPCYegF5I0sxY1ZLrUBCBf367LUbs8aHGaqZAcfFMz8Q9Fwf0LwKfTVY2MJ
         irQ0r0s4ybNgEg0fysIoKkce2RYCCMFnyUhs5ziexvvZLKOFPu7ZePT3KQ5ts6cOhVPm
         /B+eN8mHNzOSpj5oY9hHvZrflAO7QqK1GL+wKFosp/MIO//1O29pQVgYrNYLFQdaScjN
         oehhZVLcSosGCekbYLJWXiXjWvlZ+nDHk66cuP/NhDskS1CuMx3dycQ/NrQO3fNRCv3C
         uPYw==
X-Forwarded-Encrypted: i=1; AJvYcCWR9bGV/6t0QMFtXMMX+6PHaSY83XC2iXWhuPRXkCNmv+iTj6nHqGqSp62tD+vaVhGfsZo5K4A7OexbaggtR3axn41qKLs4LAwU/S9q
X-Gm-Message-State: AOJu0YzuXNrr/vaSvM9+IInCTBgUFuTEDwRsYMEA3dd/ybydldrEnRQf
	/PZUIpZBlvxqA8lZsp0wN8CAse2R03G0HtfhSN1kFEZfXkDiVBHhDXN2ZggoIx+LyJDKZ2H+TB6
	GClLdA3xbj+etAfsNTMkPn5DTnhNjaoHzmqslnHSZ0cq4zzQOpZUgT5aTnGOiNA==
X-Received: by 2002:a05:600c:4f44:b0:421:7d22:321d with SMTP id 5b1f17b1804b1-422b6ec4aafmr47196015e9.6.1718355072319;
        Fri, 14 Jun 2024 01:51:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsu3IWUGSgJrp0I8s6yL0LrXtPPpTU6s+Mm6hpBc3uQGVqH2PWXWu/GcfhrsvdsfJ3aGcQzw==
X-Received: by 2002:a05:600c:4f44:b0:421:7d22:321d with SMTP id 5b1f17b1804b1-422b6ec4aafmr47195715e9.6.1718355071815;
        Fri, 14 Jun 2024 01:51:11 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4f:2b00:69b5:3684:56c:6dd5? (p200300d82f4f2b0069b53684056c6dd5.dip0.t-ipconnect.de. [2003:d8:2f4f:2b00:69b5:3684:56c:6dd5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874de5d5sm89244655e9.33.2024.06.14.01.51.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 01:51:11 -0700 (PDT)
Message-ID: <e151cfd9-c0a5-4536-a490-77dc47aa3ed6@redhat.com>
Date: Fri, 14 Jun 2024 10:51:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/3] mm: remove folio_test_anon(folio)==false path in
 __folio_add_anon_rmap()
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, chrisl@kernel.org,
 linux-kernel@vger.kernel.org, mhocko@suse.com, ryan.roberts@arm.com,
 baolin.wang@linux.alibaba.com, yosryahmed@google.com, shy828301@gmail.com,
 surenb@google.com, v-songbaohua@oppo.com, willy@infradead.org,
 ying.huang@intel.com, yuzhao@google.com
References: <20240613000721.23093-1-21cnbao@gmail.com>
 <20240613000721.23093-4-21cnbao@gmail.com>
 <CAGsJ_4zx3Rp9ye=LFhzEN+JypAq1zb_gLQZgyiRvYJZTMpLCHA@mail.gmail.com>
 <b0b4a134-1d40-4eef-94f3-5c4593b55e78@redhat.com>
 <CAGsJ_4zDoevXiNOTbSefU4WfoPEpbkhArc1niTBFRPsMHu5j8w@mail.gmail.com>
 <cac7d354-bcf3-4d7f-866a-9665568a50a0@redhat.com>
 <CAGsJ_4xfPPz8oOe79nPxues0PkEem8O2Q+0zo6pU8uDGO1kMkg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGsJ_4xfPPz8oOe79nPxues0PkEem8O2Q+0zo6pU8uDGO1kMkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14.06.24 09:56, Barry Song wrote:
> On Thu, Jun 13, 2024 at 9:12 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 13.06.24 11:06, Barry Song wrote:
>>> On Thu, Jun 13, 2024 at 8:49 PM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 13.06.24 10:46, Barry Song wrote:
>>>>> On Thu, Jun 13, 2024 at 12:08 PM Barry Song <21cnbao@gmail.com> wrote:
>>>>>>
>>>>>> From: Barry Song <v-songbaohua@oppo.com>
>>>>>>
>>>>>> The folio_test_anon(folio)==false case within do_swap_page() has been
>>>>>> relocated to folio_add_new_anon_rmap(). Additionally, two other callers
>>>>>> consistently pass anonymous folios.
>>>>>>
>>>>>> stack 1:
>>>>>> remove_migration_pmd
>>>>>>       -> folio_add_anon_rmap_pmd
>>>>>>         -> __folio_add_anon_rmap
>>>>>>
>>>>>> stack 2:
>>>>>> __split_huge_pmd_locked
>>>>>>       -> folio_add_anon_rmap_ptes
>>>>>>          -> __folio_add_anon_rmap
>>>>>>
>>>>>> __folio_add_anon_rmap() only needs to handle the cases
>>>>>> folio_test_anon(folio)==true now.
>>>>>
>>>>> My team reported a case where swapoff() is calling
>>>>> folio_add_anon_rmap_pte *not* folio_add_anon_rmap_ptes
>>>>> with one new anon  (!folio_test_anon(folio)).
>>>>>
>>>>> I will double check all folio_add_anon_rmap_pte() cases.
>>>>
>>>> Right, swapoff() path is a bit special (e.g., we don't do any kind of
>>>> batching on the swapoff() path).
>>>>
>>>> But we should never get a new large anon folio there, or could that now
>>>> happen?
>>>
>>> My team encountered the following issue while testing this RFC
>>> series on real hardware. Let me take a look to identify the
>>> problem.
>>>
>>> [  261.214195][T11285] page:000000004cdd779e refcount:4 mapcount:1
>>> mapping:00000000ba142c22 index:0x1 pfn:0x1b30a6
>>> [  261.214213][T11285] memcg:ffffff8003678000
>>> [  261.214217][T11285] aops:swap_aops
>>> [  261.214233][T11285] flags:
>>> 0x2000000000081009(locked|uptodate|owner_priv_1|swapbacked|zone=1|kasantag=0x0)
>>> [  261.214241][T11285] page_type: 0x0()
>>> [  261.214246][T11285] raw: 2000000000081009 0000000000000000
>>> dead000000000122 0000000000000000
>>> [  261.214251][T11285] raw: 0000000000000001 00000000000d84b3
>>> 0000000400000000 ffffff8003678000
>>> [  261.214254][T11285] page dumped because:
>>> VM_WARN_ON_FOLIO(!folio_test_anon(folio))
>>> [  261.214257][T11285] page_owner tracks the page as allocated
>>> [  261.214260][T11285] page last allocated via order 0, migratetype
>>> Movable, gfp_mask 0x2140cca(GFP_HIGHUSER_MOVABLE|__GFP_COMP), pid
>>> 11285, tgid 11285 (swapoff), ts 261214177545, free_ts 261151875699
>>> [  261.214268][T11285]  post_alloc_hook+0x1b8/0x1c0
>>> [  261.214284][T11285]  prep_new_page+0x28/0x13c
>>> [  261.214291][T11285]  get_page_from_freelist+0x198c/0x1aa4
>>> [  261.214298][T11285]  __alloc_pages+0x15c/0x330
>>> [  261.214304][T11285]  __folio_alloc+0x1c/0x4c
>>> [  261.214310][T11285]  __read_swap_cache_async+0xd8/0x48c
>>> [  261.214320][T11285]  swap_cluster_readahead+0x158/0x324
>>> [  261.214326][T11285]  swapin_readahead+0x64/0x448
>>> [  261.214331][T11285]  __arm64_sys_swapoff+0x6ec/0x14b0
>>> [  261.214337][T11285]  invoke_syscall+0x58/0x114
>>> [  261.214353][T11285]  el0_svc_common+0xac/0xe0
>>> [  261.214360][T11285]  do_el0_svc+0x1c/0x28
>>> [  261.214366][T11285]  el0_svc+0x38/0x68
>>> [  261.214372][T11285]  el0t_64_sync_handler+0x68/0xbc
>>> [  261.214376][T11285]  el0t_64_sync+0x1a8/0x1ac
>>> [  261.214381][T11285] page last free pid 90 tgid 90 stack trace:
>>> [  261.214386][T11285]  free_unref_page_prepare+0x338/0x374
>>> [  261.214395][T11285]  free_unref_page_list+0x84/0x378
>>> [  261.214400][T11285]  shrink_folio_list+0x1234/0x13e4
>>> [  261.214409][T11285]  evict_folios+0x1458/0x19b4
>>> [  261.214417][T11285]  try_to_shrink_lruvec+0x1c8/0x264
>>> [  261.214422][T11285]  shrink_one+0xa8/0x234
>>> [  261.214427][T11285]  shrink_node+0xb38/0xde0
>>> [  261.214432][T11285]  balance_pgdat+0x7a4/0xdb4
>>> [  261.214437][T11285]  kswapd+0x290/0x4e4
>>> [  261.214442][T11285]  kthread+0x114/0x1bc
>>> [  261.214459][T11285]  ret_from_fork+0x10/0x20
>>> [  261.214477][T11285] ------------[ cut here ]------------
>>> [  261.214480][T11285] WARNING: CPU: 3 PID: 11285 at mm/rmap.c:1305
>>> folio_add_anon_rmap_ptes+0x2b4/0x330
>>>
>>> [  261.215403][T11285] pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT
>>> -SSBS BTYPE=--)
>>> [  261.215423][T11285] pc : folio_add_anon_rmap_ptes+0x2b4/0x330
>>> [  261.215428][T11285] lr : folio_add_anon_rmap_ptes+0x2b4/0x330
>>> [  261.215433][T11285] sp : ffffffc0a7dbbbf0
>>> [  261.215437][T11285] x29: ffffffc0a7dbbbf0 x28: ffffff8040860a08
>>> x27: ffffff80db480000
>>> [  261.215445][T11285] x26: fffffffe04cc2980 x25: ffffff808f77f120
>>> x24: 0000007b44941000
>>> [  261.215452][T11285] x23: 0000000000000001 x22: 0000000000000001
>>> x21: fffffffe04cc2980
>>> [  261.215459][T11285] x20: ffffff80db480000 x19: fffffffe04cc2980
>>> x18: ffffffed011dae80
>>> [  261.215465][T11285] x17: 0000000000000001 x16: ffffffffffffffff
>>> x15: 0000000000000004
>>> [  261.215471][T11285] x14: ffffff82fb73fac0 x13: 0000000000000003
>>> x12: 0000000000000003
>>> [  261.215476][T11285] x11: 00000000fffeffff x10: c0000000fffeffff x9
>>> : 0d46c0889b468e00
>>> [  261.215483][T11285] x8 : 0d46c0889b468e00 x7 : 545b5d3935343431 x6
>>> : 322e31363220205b
>>> [  261.215489][T11285] x5 : ffffffed013de407 x4 : ffffffed00698967 x3
>>> : 0000000000000000
>>> [  261.215495][T11285] x2 : 0000000000000000 x1 : ffffffc0a7dbb8c0 x0
>>> : ffffff8068c15c80
>>> [  261.215501][T11285] Call trace:
>>> [  261.215504][T11285]  folio_add_anon_rmap_ptes+0x2b4/0x330
>>> [  261.215509][T11285]  __arm64_sys_swapoff+0x8cc/0x14b0
>>> [  261.215516][T11285]  invoke_syscall+0x58/0x114
>>> [  261.215526][T11285]  el0_svc_common+0xac/0xe0
>>> [  261.215532][T11285]  do_el0_svc+0x1c/0x28
>>> [  261.215539][T11285]  el0_svc+0x38/0x68
>>> [  261.215544][T11285]  el0t_64_sync_handler+0x68/0xbc
>>> [  261.215548][T11285]  el0t_64_sync+0x1a8/0x1ac
>>> [  261.215552][T11285] ---[ end trace 0000000000000000 ]---
>>
>> Ah, yes. in unuse_pte(), you'll have to do the right thing if
>> !folio_test(anon) before doing the folio_add_anon_rmap_pte().
>>
>> You might have a fresh anon folio in the swapcache that was never mapped
>> (hopefully order-0, otherwise we'd likely be in trouble).
> 
> Yes. It is order-0
> 
> [  261.214260][T11285] page last allocated via order 0, migratetype
> 
> Otherwise, we would have encountered this VM_WARN_ON_FOLIO?
> 
> __folio_add_anon_rmap()
> {
> ...
> VM_WARN_ON_FOLIO(folio_test_large(folio) &&
>       level != RMAP_LEVEL_PMD, folio);
> ...
> }
> 
> Given that nobody has ever reported this warning, I assume all callers
> using folio_add_anon_rmap_pte(s) are right now safe to move to ?

Yes, and we should likely add a VM_WARN_ON_ONCE() here that we have a 
small folio if !anon. If that ever changes, we can assess the situation.

Only swap created "new" anon folios without properly calling the right 
function so far, all other code handles that correctly.

-- 
Cheers,

David / dhildenb


