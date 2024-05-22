Return-Path: <linux-kernel+bounces-186134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A09A8CC030
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 13:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039841F21E47
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 11:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A9D824BD;
	Wed, 22 May 2024 11:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="is5fp94B"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A12D824A1
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 11:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716377093; cv=none; b=DDuNUxOeNPBPgXB13bUXLa+VqQdhSxJBud2TBB65PI6LJENCrgybQaGH4HJm0DRic+0zmu80v+NcsJHHg5Y9GBMk1EhF2Kca0BtHoWY+oUYqqSLG0hD9awuSP7RYl++ycyv6CIfiFGEWrFKHCjE8DRHoBOFDvrVY/32153jCWY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716377093; c=relaxed/simple;
	bh=7s3EVsSEdAae3zdQoXSEi1dnM21hfqyM9LApN2IL4nQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DaadN/7qReU+H4FBsS0EuwmteMucTbrUvLIqcRgjBPGBKATXXJmXT3C12sCKclmMXnt3PQX1ZINXEu5lFG9eAMdJwkS/ZPjKHt4wzt5y8Iezd5h/ao97WnFwSqQdMl1WpyLpLe3D5VgiA+PmuYakZxXCaCAWsr0YXj5jrDpxHY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=is5fp94B; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716377087; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=FsfoN0B25x/yfr2/PDmpfakYf9XUAtERkvPB+NSPL1M=;
	b=is5fp94BSPCo3wkAnCUY3k1xcJy3PKYRIQSxFbQdBr2W6ljqbIPjZfoxn0ilEDzH1/ykFC2aJ8i4aDBpdpnWQdaFeaj6gxEP+JkKHQatNtRzSJTf4HO58f2CC/kX1WqzZTCXxk787ANXWM5oMm47VSaCf8mCuFAsxy9CdnawngE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W7.Qpex_1716377085;
Received: from 30.97.56.54(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W7.Qpex_1716377085)
          by smtp.aliyun-inc.com;
          Wed, 22 May 2024 19:24:46 +0800
Message-ID: <c55648d4-cec2-48ca-9ca9-c8fc2aecc741@linux.alibaba.com>
Date: Wed, 22 May 2024 19:24:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: drop the 'anon_' prefix for swap-out mTHP counters
To: Barry Song <21cnbao@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 willy@infradead.org, ying.huang@intel.com, ryan.roberts@arm.com,
 ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <0e2a6f232e7579a2e4407ecf075531980d97f286.1716367360.git.baolin.wang@linux.alibaba.com>
 <22ac01a3-ddbb-4114-88cd-ad1a31982dad@redhat.com>
 <51ba1fc1-fd77-4601-8d27-459162fd008c@linux.alibaba.com>
 <CAGsJ_4zSuOTPi+zkS_kvS5T0MsdMBR+2gpXukJt0aMPrEnCDZg@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAGsJ_4zSuOTPi+zkS_kvS5T0MsdMBR+2gpXukJt0aMPrEnCDZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/5/22 18:40, Barry Song wrote:
> On Wed, May 22, 2024 at 9:38 PM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>>
>>
>> On 2024/5/22 16:58, David Hildenbrand wrote:
>>> On 22.05.24 10:51, Baolin Wang wrote:
>>>> The mTHP swap related counters: 'anon_swpout' and
>>>> 'anon_swpout_fallback' are
>>>> confusing with an 'anon_' prefix, since the shmem can swap out
>>>> non-anonymous
>>>> pages. So drop the 'anon_' prefix to keep consistent with the old swap
>>>> counter
>>>> names.
>>>>
>>>> Suggested-by: "Huang, Ying" <ying.huang@intel.com>
>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>> ---
>>>
>>> Am I daydreaming or did we add the anon_ for a reason and discussed the
>>> interaction with shmem? At least I remember some discussion around that.
>>
>> Do you mean the shmem mTHP allocation counters in previous
>> discussion[1]? But for 'anon_swpout' and 'anon_swpout_fallback', I can
>> not find previous discussions that provided a reason for adding the
>> ‘anon_’ prefix. Barry, any comments? Thanks.
> 
> HI Baolin,
> We had tons of emails discussing about namin and I found this email,
> 
> https://lore.kernel.org/all/bca6d142-15fd-4af5-9f71-821f891e8305@redhat.com/
> 
> David had this comment,
> "I'm wondering if these should be ANON specific for now. We might want to
> add others (shmem, file) in the future."
> 
> This is likely how the 'anon_' prefix started being added, although it
> wasn't specifically
> targeting swapout.

That's what I missed before. Thanks Barry.

> I sense your patch slightly alters the behavior of thp_swpout_fallback
> in /proc/vmstat.
> Previously, we didn't classify them as THP_SWPOUT_FALLBACK, even though we
> always split them.

Sorry I did not get you here. I just re-name the mTHP swpout_fallback, 
how can this patch change the THP_SWPOUT_FALLBACK statistic counted by 
count_vm_event()?

>                  if (folio_test_anon(folio) && folio_test_swapbacked(folio)) {
>                          ...
>                                  if (!add_to_swap(folio)) {
>                                          int __maybe_unused order =
> folio_order(folio);
> 
>                                          if (!folio_test_large(folio))
>                                                  goto activate_locked_split;
>                                          /* Fallback to swap normal pages */
>                                          if (split_folio_to_list(folio,
> folio_list))
>                                                  goto activate_locked;
> #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>                                          if (nr_pages >= HPAGE_PMD_NR) {
>                                                  count_memcg_folio_events(folio,
>                                                          THP_SWPOUT_FALLBACK, 1);
> 
> count_vm_event(THP_SWPOUT_FALLBACK);
>                                          }
>                                          count_mthp_stat(order,
> MTHP_STAT_ANON_SWPOUT_FALLBACK);
> #endif
>                                          if (!add_to_swap(folio))
>                                                  goto activate_locked_split;
>                                  }
>                          }
>                  } else if (folio_test_swapbacked(folio) &&
>                             folio_test_large(folio)) {
>                          /* Split shmem folio */
>                          if (split_folio_to_list(folio, folio_list))
>                                  goto keep_locked;
>                  }
> 
> 
> 
> If the goal is to incorporate pmd-mapped shmem under thp_swpout* in
> /proc/vmstat,
> and if there is consistency between /proc/vmstat and sys regarding
> their definitions,
> then I have no objection to this patch. 

I think this is the goal, moreover shmem will support large folio (not 
only THP) in future, so swpout related counters should be defined as 
clear as possible.

However, shmem_swpout and shmem_swpout_*
> appear more intuitive, given that thp_swpout_* in /proc/vmstat has
> never shown any
> increments for shmem until now - we have been always splitting shmem in vmscan.

This is somewhat similar to our previous discussion on the naming of the 
shmem's mTHP counter[1], as David suggested, we should keep counter name 
consistency for now and add more in the future as needed.

[1] 
https://lore.kernel.org/all/ce6be451-7c5a-402f-8340-be40699829c2@redhat.com/
> 
> By the way, if this patch is accepted, it must be included in version
> 6.10 to maintain
> ABI compatibility. Additionally, documentation must be updated accordingly.

Sure. I missed update the documentation, and will do in next version.

