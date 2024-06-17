Return-Path: <linux-kernel+bounces-217311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1641F90AE2A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEC431F23F46
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9DC197526;
	Mon, 17 Jun 2024 12:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="MHCsWtP1"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C1E186294
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 12:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718628509; cv=none; b=qNDhmBzQDP+gymVpgkGsz5JUReiAq84abiEGza7TDEqO75FbU/mjMOd8noyJq22gdHhVpzAefkohZoFA6qwEfXmd+eLE1Xn/KlEFTGjdjjN9nN/yCC7fuoJvWZcbvFVEdEoowM8Vla767l06txwCodfM4zuv17TNkgVYe9s1KMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718628509; c=relaxed/simple;
	bh=c+4Xw8gNwHIcpCowSmpdjKQV8eXMguYblQIpFtBe2CU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=R+hESlQY+ShMesMmrF0N4dP4yqTyhNIXR+4/Ksw4841tc7E0+ecp3UxjtaogIn+h+uzAE1VGK+j1pueoxuekOCLxFn0QClIhtr1huOE5K8Pm31MX70Ujr9MJI43BAl0/h+hSolVi7w1qarjcp5iR7psMWk1g7A/nhPJnTojYFTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=MHCsWtP1; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version:
	Content-Type; bh=R5LyUIEwiLclBT3CxY82I/xcMzkMOsc/hxhcloLbi+A=;
	b=MHCsWtP1NYRYx+dgG3/2KP9MupkwZOHnrbkr68B1DKsIPv01eeSPrrJFkzq/zX
	qxkb8zJOzLevCpk5zKfFp1nuSoQLS41Kp+O97Eu/skgrPQ26Knw7gYcNAt+BBuB7
	S4LxY7HC/0chsM+NeAM8s4HVgTNeCHus2TFwNeNkRaOoE=
Received: from [172.21.21.216] (unknown [118.242.3.34])
	by gzga-smtp-mta-g0-5 (Coremail) with SMTP id _____wD3X7VNMHBmBbycBg--.64029S2;
	Mon, 17 Jun 2024 20:47:11 +0800 (CST)
Subject: Re: [PATCH] mm/page_alloc: skip THP-sized PCP list when allocating
 non-CMA THP-sized page
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, baolin.wang@linux.alibaba.com,
 liuzixing@hygon.cn
References: <1717492460-19457-1-git-send-email-yangge1116@126.com>
 <CAGsJ_4zvG7gwukioZnqN+GpWHbpK1rkC0Jeqo5VFVL_RLACkaw@mail.gmail.com>
From: yangge1116 <yangge1116@126.com>
Message-ID: <2e3a3a3f-737c-ed01-f820-87efee0adc93@126.com>
Date: Mon, 17 Jun 2024 20:47:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAGsJ_4zvG7gwukioZnqN+GpWHbpK1rkC0Jeqo5VFVL_RLACkaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X7VNMHBmBbycBg--.64029S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF4kJw4rury3WFW8XrWrXwb_yoWrJw1rpF
	WfG3Waka15Xry7C3Z2y3Z0kryF9w1rKrWUGr1rZr18uwnxCFyIy397tFn5XFyrAry5Ja10
	qFWjq3ZxCF4qyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bjiSLUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiWQMBG2VLaxlLXQAAsK



在 2024/6/17 下午6:26, Barry Song 写道:
> On Tue, Jun 4, 2024 at 9:15 PM <yangge1116@126.com> wrote:
>>
>> From: yangge <yangge1116@126.com>
>>
>> Since commit 5d0a661d808f ("mm/page_alloc: use only one PCP list for
>> THP-sized allocations") no longer differentiates the migration type
>> of pages in THP-sized PCP list, it's possible to get a CMA page from
>> the list, in some cases, it's not acceptable, for example, allocating
>> a non-CMA page with PF_MEMALLOC_PIN flag returns a CMA page.
>>
>> The patch forbids allocating non-CMA THP-sized page from THP-sized
>> PCP list to avoid the issue above.
> 
> Could you please describe the impact on users in the commit log?

If a large number of CMA memory are configured in the system (for 
example, the CMA memory accounts for 50% of the system memory), starting 
virtual machine with device passthrough will get stuck.

During starting virtual machine, it will call pin_user_pages_remote(..., 
FOLL_LONGTERM, ...) to pin memory. If a page is in CMA area, 
pin_user_pages_remote() will migrate the page from CMA area to non-CMA 
area because of FOLL_LONGTERM flag. If non-movable allocation requests 
return CMA memory, pin_user_pages_remote() will enter endless loops.

backtrace:
pin_user_pages_remote
----__gup_longterm_locked //cause endless loops in this function
--------__get_user_pages_locked
--------check_and_migrate_movable_pages //always check fail and continue 
to migrate
------------migrate_longterm_unpinnable_pages
----------------alloc_migration_target // non-movable allocation

> Is it possible that some CMA memory might be used by non-movable
> allocation requests? 

Yes.


> If so, will CMA somehow become unable to migrate, causing cma_alloc() to fail?


No, it will cause endless loops in __gup_longterm_locked(). If 
non-movable allocation requests return CMA memory, 
migrate_longterm_unpinnable_pages() will migrate a CMA page to another 
CMA page, which is useless and cause endless loops in 
__gup_longterm_locked().

backtrace:
pin_user_pages_remote
----__gup_longterm_locked //cause endless loops in this function
--------__get_user_pages_locked
--------check_and_migrate_movable_pages //always check fail and continue 
to migrate
------------migrate_longterm_unpinnable_pages





>>
>> Fixes: 5d0a661d808f ("mm/page_alloc: use only one PCP list for THP-sized allocations")
>> Signed-off-by: yangge <yangge1116@126.com>
>> ---
>>   mm/page_alloc.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 2e22ce5..0bdf471 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -2987,10 +2987,20 @@ struct page *rmqueue(struct zone *preferred_zone,
>>          WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
>>
>>          if (likely(pcp_allowed_order(order))) {
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +               if (!IS_ENABLED(CONFIG_CMA) || alloc_flags & ALLOC_CMA ||
>> +                                               order != HPAGE_PMD_ORDER) {
>> +                       page = rmqueue_pcplist(preferred_zone, zone, order,
>> +                                               migratetype, alloc_flags);
>> +                       if (likely(page))
>> +                               goto out;
>> +               }
> 
> This seems not ideal, because non-CMA THP gets no chance to use PCP. But it
> still seems better than causing the failure of CMA allocation.
> 
> Is there a possible approach to avoiding adding CMA THP into pcp from the first
> beginning? Otherwise, we might need a separate PCP for CMA.
> 
>> +#else
>>                  page = rmqueue_pcplist(preferred_zone, zone, order,
>>                                         migratetype, alloc_flags);
>>                  if (likely(page))
>>                          goto out;
>> +#endif
>>          }
>>
>>          page = rmqueue_buddy(preferred_zone, zone, order, alloc_flags,
>> --
>> 2.7.4
> 
> Thanks
> Barry
> 


