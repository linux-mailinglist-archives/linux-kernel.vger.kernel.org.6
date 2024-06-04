Return-Path: <linux-kernel+bounces-200613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C6A8FB264
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C17441F24D70
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B5F146D49;
	Tue,  4 Jun 2024 12:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="qEKfa4hJ"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259E0146581
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 12:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504700; cv=none; b=QXSt3m9hVkJlVjeFPZ7wZVMcDa6OVJozbhs1jEBzUzEBVo3B2X+4eBM7b0hKF4dfBZtaADQ1bVjIvYgYNxje0BdUOyt4bzeTjlahAQkYEfYJDpuplP60x2+/rOEEyrbehpz7zJNsG53aIu5azFIBjQmT8Ae6pQsuZREyocoaLLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504700; c=relaxed/simple;
	bh=P2rsMJYGn1q5f04Jnsis5cuJ/h6fsZUX4OcVg4s0LLM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VZxlGU4blP4Rkdw9DxmwIOz0Z+tq4HKD56rGypIHNeohxhVLxNORtFv4Ed7UK3qNC2QIX7kvLm0HJpQiYxCD45iCLxNh9X/1g8n0K5vFPwXCpt/GRSidx77sIxgUZh8Hd56Cj2f/YQU/MTYHfP2Fppdx2L0WGNhyEs3aVM7bo7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=qEKfa4hJ; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version:
	Content-Type; bh=0hRvVXncKOkLWsAeCdfmmfKnmhpK+8aJYZ8GA8gjOZ8=;
	b=qEKfa4hJu3SKHci7ZUAPmcekiWYgZ1kdBlSU9rwXgLWm5iFaxF2D4bVaQTi76h
	2U+9KEasDPUy21EYU6UOmPxB4fFixPY+5OxWgyq5j2nTIB8rkQM3xdFy5sP1pfJt
	rUlzgWySe+3G8fccOzZK6EUsgdZhALZwsk4tmfZgYVsp8=
Received: from [172.21.21.216] (unknown [118.242.3.34])
	by gzga-smtp-mta-g0-3 (Coremail) with SMTP id _____wDX_8owCl9mVgncBA--.38032S2;
	Tue, 04 Jun 2024 20:36:02 +0800 (CST)
Subject: Re: [PATCH] mm/page_alloc: skip THP-sized PCP list when allocating
 non-CMA THP-sized page
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, liuzixing@hygon.cn,
 Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@suse.cz>,
 Zi Yan <ziy@nvidia.com>
References: <1717492460-19457-1-git-send-email-yangge1116@126.com>
 <c180d2a0-1e34-41f0-bae8-1205d04a5f6b@linux.alibaba.com>
From: yangge1116 <yangge1116@126.com>
Message-ID: <82d31425-86d7-16fa-d09b-fcb203de0986@126.com>
Date: Tue, 4 Jun 2024 20:36:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c180d2a0-1e34-41f0-bae8-1205d04a5f6b@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX_8owCl9mVgncBA--.38032S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF15Xr17Wr15AFWkur1xZrb_yoW8Ww4xpF
	Z3C3WYyF4rX343C3y7JFn0kFn09w4IkF4xGrWrZr1UZwnxCF4UCr97tFyavF1fZr9rAF10
	yF4vgFyrZF4qyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bFHqcUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiGBrzG2VLblo82QABsU



在 2024/6/4 下午8:01, Baolin Wang 写道:
> Cc Johannes, Zi and Vlastimil.
> 
> On 2024/6/4 17:14, yangge1116@126.com wrote:
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
>>
>> Fixes: 5d0a661d808f ("mm/page_alloc: use only one PCP list for 
>> THP-sized allocations")
>> Signed-off-by: yangge <yangge1116@126.com>
>> ---
>>   mm/page_alloc.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 2e22ce5..0bdf471 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -2987,10 +2987,20 @@ struct page *rmqueue(struct zone *preferred_zone,
>>       WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
>>       if (likely(pcp_allowed_order(order))) {
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +        if (!IS_ENABLED(CONFIG_CMA) || alloc_flags & ALLOC_CMA ||
>> +                        order != HPAGE_PMD_ORDER) {
> 
> Seems you will also miss the non-CMA THP from the PCP, so I wonder if we 
> can add a migratetype comparison in __rmqueue_pcplist(), and if it's not 
> suitable, then fallback to buddy?

Yes, we may miss some non-CMA THPs in the PCP. But, if add a migratetype 
comparison in __rmqueue_pcplist(), we may need to compare many times 
because of pcp batch.


