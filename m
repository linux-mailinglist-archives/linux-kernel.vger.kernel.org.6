Return-Path: <linux-kernel+bounces-408627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 987489C8139
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 03:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FD951F247D1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 02:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7299A1E6325;
	Thu, 14 Nov 2024 02:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bZaN2Pq6"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574BF433D1
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 02:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731553134; cv=none; b=taqC+RuNsIdZ3FSyl9DyOZsCP65UhtOGyuTEwk69ZXBG3vkQos9rPo1W7jjjjP+rMvIx2t+1xs0/LYCQ4ylBEf50Iz/2sLgoWBHzEebhEe1u2Wsn3d3/AvBxsLWpHbHwS0GFQo+KKRvTINY+y8l76RtVA19X1bm17ZqqENrKyug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731553134; c=relaxed/simple;
	bh=YYYcIejZZ0B5jPTu1g7BPlKFHDHsQJg2nw1+Xvd0Yw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BEl45NsT5evR9+IdR6kpL5DrO9FmWpVwo5mNL0uXv5n2vgEd2nw1NCpxszQw4VQiQf1M89Qp3XVARsXwQ3q9buEswyGOkGRaXNZj4YurRigy0VQKhfY37JS0sOchNLvAr5bi+XRm0uGdbVydiAz40NISUjNaC/U93UP1VqNzjb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bZaN2Pq6; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731553130; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=KRFiIYjYsXClQNA33ST6V6UAYzj5lmjJiOG5AbPovVY=;
	b=bZaN2Pq6OE4+DEu7GbGgRso1iTLgtIk8N33w1NWUGwOr47gFqZpeZZCMgbyDnzROWjweXvL+z1AISb1For24eQ1SM0SO1GXfFmSoBYIqwy4LNPgqMkB206A56xJYWEQB9kwEO4HlUv1m5lzgqkREk1Lhd7UQnDSFZ2099wBflsQ=
Received: from 30.74.144.113(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WJMcp8W_1731553128 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 14 Nov 2024 10:58:49 +0800
Message-ID: <498eb2ea-d3d1-4396-982e-1b81ec161a51@linux.alibaba.com>
Date: Thu, 14 Nov 2024 10:58:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/compaction: fix the total_isolated in strict mode
To: Qiang Liu <liuq131@chinatelecom.cn>, akpm <akpm@linux-foundation.org>
Cc: linux-mm <linux-mm@kvack.org>, linux-kernel <linux-kernel@vger.kernel.org>
References: <20241102201621.95291-1-liuq131@chinatelecom.cn>
 <055703d7-1434-42fb-8048-add21a9bd44c@linux.alibaba.com>
 <2024111210165296529720@chinatelecom.cn>
 <2503b955-79a9-4d21-9a25-34a6c33e688d@linux.alibaba.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <2503b955-79a9-4d21-9a25-34a6c33e688d@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/11/14 10:10, Qiang Liu wrote:
> From: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> 
> On 2024/11/12  17:47, baolin.wang@linux.alibaba.com wrote:
>> On 2024/11/12 10:16, liuq131@chinatelecom.cn wrote:
>>> "We assume that the block we are currently processing is distributed 
>>> as follows:
>>> 0   1   2                                                            511
>>> --------------------------------------------------
>>> |    |    
>>> |                                                              |
>>> ---------------------------------------------------
>>> Index 0 and 1 are both pages with an order of 0.
>>> Index 2 has a bogus order (let's assume the order is 9).
>>> When the for loop reaches index 2, it will enter the following code:
>>> /*
>>>   * For compound pages such as THP and hugetlbfs, we can save
>>>   * potentially a lot of iterations if we skip them at once.
>>>   * The check is racy, but we can consider only valid values
>>>   * and the only danger is skipping too much.
>>>   */
>>> if (PageCompound(page)) {
>>>      const unsigned int order = compound_order(page);
>>>      if (blockpfn + (1UL << order) <= end_pfn) {
>>>          blockpfn += (1UL << order) - 1;
>>>          page += (1UL << order) - 1;
>>>          nr_scanned += (1UL << order) - 1;
>>>      }
>>>      goto isolate_fail;
>>> }
>>>
>>> After exiting the for loop:
>>> blockpfn =basepfn+ 2+2^9 = basepfn+514
>>> endpfn  = basepfn +512
>>> total_isolated = 2
>>> nr_scanned = 514
>>
>> In your case, the 'blockpfn' will not be updated to 'basepfn+514', 
>> because 'blockpfn + (1UL << order) > end_pfn', right? And remember the 
>> 'end_pfn' is the end of the pageblock.
>>
>> So I'm still confused about your case. Is this from code inspection?
> You're right, the situation where blockpfn > end_pfn would not actually 
> occur here.
> I encountered this issue in the 4.19 kernel, which did not have this check.
> I didn't carefully examine this scenario later. Sorry about that.

Never mind:)

> However, when blockpfn == end_pfn, I believe the patch is still applicable,
> but the git log needs to be updated. Is there still an opportunity to 
> submit
> a revised version of the patch?

Of course yes, and please describe your issue clearly in the next 
verion. However, IIUC when blockpfn == end_pfn in your case, the 
'total_isolated' is still 0.

>>> /*
>>> * Be careful to not go outside of the pageblock.
>>> */
>>> if (unlikely(blockpfn > end_pfn))
>>> blockpfn = end_pfn;
>>> So this can happen
>>>
>>> /*
>>>   * If strict isolation is requested by CMA then check that all the
>>>   * pages requested were isolated. If there were any failures, 0 is
>>>   * returned and CMA will fail.
>>>   */
>>> if (strict && blockpfn < end_pfn)
>>> total_isolated = 0;
>>>
>>> If processed according to the old code, it will not enter the if 
>>> statement to reset total_isolated, but the correct handling is to 
>>> reset total_isolated to 0.
>>
>> Please do not top-posting:
>>
>> "
>> - Use interleaved ("inline") replies, which makes your response easier 
>> to read. (i.e. avoid top-posting -- the practice of putting your 
>> answer above the quoted text you are responding to.) For more details, 
>> see
>>   :ref:`Documentation/process/submitting-patches.rst 
>> <interleaved_replies>`.
>> "
>>

