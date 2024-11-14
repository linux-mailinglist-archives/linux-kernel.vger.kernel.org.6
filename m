Return-Path: <linux-kernel+bounces-409050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AF29C8725
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C301CB2867B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 10:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF8B1F7540;
	Thu, 14 Nov 2024 10:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kT9hhjNI"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0471DFE28
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 10:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578787; cv=none; b=H8RQVsySiZxl97OKWdksm8IPDtu7noeusDzO13y0GaeUBcvhNXh7Wvhy44gakajy1Xl6FmlR115DeSZrlQbogPoTYmzc+vFZU9JazuUoHjler6rYarJepzNdS6U6MJOrHaJYYW2joYSdncjDaaj6KFmkSkHtSuyyFqo+P03bSoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578787; c=relaxed/simple;
	bh=U2CHXqebNLagg90BrUSnaijMVrBi/LYnvFhIyWcX6+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cHPqTP4q4JYmRoSxfyCPvSyjKeaCWWZXa/gdLeofTaqfKT6hRIAkUTUHP/Jn5WNluPWohPbNew42OOX5ctRzR3zgG8KVyNqqSsucTDF8z/qFPU4UGPWl2aStyzPgPu86AU23urSQTv8x23KNzxLViWOsUjOtg+VcDrKo6inyizE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kT9hhjNI; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731578781; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=RpYxXblopuDmU3s1fEaqbX/dtjxKSQygA/T4iP3xf64=;
	b=kT9hhjNIS1alraWWPOKN+XBTNafetMiyn+fHDYSgRGbdv3+I1i+fB87IqfAwy+63/ey7h66Dv76g2xP5DYOnJfsFyFTOKek/ofQJ/5Mhozerw96D9zSMZIUQF6lfc/HoH+0TH8ZYAk++ZDNa40RH9glJc1m1SHitLcWlXpWtfj0=
Received: from 30.74.144.113(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WJOLxnT_1731578779 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 14 Nov 2024 18:06:20 +0800
Message-ID: <bd962c73-5362-479f-9e03-6fbda4e3727e@linux.alibaba.com>
Date: Thu, 14 Nov 2024 18:06:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/compaction: remove unnecessary detection code.
To: Vlastimil Babka <vbabka@suse.cz>, Qiang Liu <liuq131@chinatelecom.cn>,
 Kemeng Shi <shikemeng@huaweicloud.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20241114065720.3665-1-liuq131@chinatelecom.cn>
 <2b6ca5b1-f421-4dda-a2a2-865af97b2db8@suse.cz>
 <f1cdc0e0-6704-4dc4-a3cf-158fc867db56@suse.cz>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <f1cdc0e0-6704-4dc4-a3cf-158fc867db56@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/11/14 15:52, Vlastimil Babka wrote:
> On 11/14/24 08:44, Vlastimil Babka wrote:
>> On 11/14/24 07:57, Qiang Liu wrote:
>>> It is impossible for the situation where blockpfn > end_pfn to arise,
>>> The if statement here is not only unnecessary, but may also lead to
>>> a misunderstanding that blockpfn > end_pfn could potentially happen.
>>> so these unnecessary checking code should be removed.
>>>
>>> Signed-off-by: Qiang Liu <liuq131@chinatelecom.cn>
>>
>> I see that's since 3da0272a4c7d ("mm/compaction: correctly return failure
>> with bogus compound_order in strict mode")
> 
> Hm but we still have:
> 
> for (; blockpfn < end_pfn; blockpfn += stride, page += stride) {
> 
> and this advance by stride can mix up with advance by isolated, initial pfn
> might not be aligned... I don't see any guarantee that the for loop will
> exit with exactly blockpfn == end_pfn, it may easily advance beyond end_pfn
> so we shouldn't remove the check?

Agreed.

>> I think that commit introduced a risk of overflow due to a bogus order
>> (which we read in a racy way), and once blockpfn overflows it will satisfy
>> <= end_pfn and might e.g. end up scanning a completely different zone?
>>
>>                          if (blockpfn + (1UL << order) <= end_pfn) {
>>
>>                                  blockpfn += (1UL << order) - 1;
>>                                  page += (1UL << order) - 1;
>>                                  nr_scanned += (1UL << order) - 1;
>>                          }
>>
>> We should better add back the MAX_ORDER sanity check?
>>
>>> ---
>>>   mm/compaction.c | 6 ------
>>>   1 file changed, 6 deletions(-)
>>>
>>> diff --git a/mm/compaction.c b/mm/compaction.c
>>> index a2b16b08cbbf..baeda7132252 100644
>>> --- a/mm/compaction.c
>>> +++ b/mm/compaction.c
>>> @@ -682,12 +682,6 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
>>>   	if (locked)
>>>   		spin_unlock_irqrestore(&cc->zone->lock, flags);
>>>   
>>> -	/*
>>> -	 * Be careful to not go outside of the pageblock.
>>> -	 */
>>> -	if (unlikely(blockpfn > end_pfn))
>>> -		blockpfn = end_pfn;
>>> -
>>>   	trace_mm_compaction_isolate_freepages(*start_pfn, blockpfn,
>>>   					nr_scanned, total_isolated);
>>>   
>>
>>

