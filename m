Return-Path: <linux-kernel+bounces-405518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 030CF9C5258
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF5AF1F2287E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCD320DD49;
	Tue, 12 Nov 2024 09:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ROeJjgui"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8835B20CCDC
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 09:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731404835; cv=none; b=ZTHakXFjChSnzKQagt+Ojd7CdE72LDU1tbV3rxgskLnFgAhw+yVImBe44ArLe6ZFwLNuPEV8NMf0vz5EZ2qwNL8TQetrVa9JlGS3aXpyVJfDtZE7MnuafG2S2vFopgfqY0mOEk5unSB8C9w2/9WGn6hGf87azlPoTvRpsEKGONY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731404835; c=relaxed/simple;
	bh=w/dC3jJUophHFtzWJGgT9tHP5RlkQy/6uIdCN6gzIUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tgLgAT3YawtiZLq5iNTIhltzz4xBmfXcoGFklFg3k5qOYc11uilZ0VyaX3s+3Ri0F7ZzYF0n5PaDNR1ZDSkHaKOUwyQ2WO/6W/l6xRwPoAhVEfprygtgRPb48w1nicPjcMf2ooUAyiwKKqLesJO7ulJnd0mLWFJwxnmsLDFu5qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ROeJjgui; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731404823; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=RFjjREpMZxKxsiOJad01yhROc9AzNVhtqJ3oU5t0vhQ=;
	b=ROeJjguin6KcqsvV3/L0zX075EOuDTdDWdSuLvY9WFo+pV1qdyEqVXSduwgnI7z3FtyNbgSJLbzCghNYpHRD562cQXJZx58XR5euLsv/+eH4iVtA0TkPgUKygw60Fcfz7rJhdTxYNvF33dKT7QAtSKnXMZGJmCp0Qh8TL33LSmk=
Received: from 30.74.144.120(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WJGy4ng_1731404822 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 Nov 2024 17:47:03 +0800
Message-ID: <2503b955-79a9-4d21-9a25-34a6c33e688d@linux.alibaba.com>
Date: Tue, 12 Nov 2024 17:47:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/compaction: fix the total_isolated in strict mode
To: "liuq131@chinatelecom.cn" <liuq131@chinatelecom.cn>,
 akpm <akpm@linux-foundation.org>
Cc: linux-mm <linux-mm@kvack.org>, linux-kernel <linux-kernel@vger.kernel.org>
References: <20241102201621.95291-1-liuq131@chinatelecom.cn>
 <055703d7-1434-42fb-8048-add21a9bd44c@linux.alibaba.com>
 <2024111210165296529720@chinatelecom.cn>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <2024111210165296529720@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/11/12 10:16, liuq131@chinatelecom.cn wrote:
> "We assume that the block we are currently processing is distributed as follows:
> 0   1   2                                                            511
> --------------------------------------------------
> |    |    |                                                              |
> ---------------------------------------------------
> Index 0 and 1 are both pages with an order of 0.
> Index 2 has a bogus order (let's assume the order is 9).
> When the for loop reaches index 2, it will enter the following code:
> /*
>   * For compound pages such as THP and hugetlbfs, we can save
>   * potentially a lot of iterations if we skip them at once.
>   * The check is racy, but we can consider only valid values
>   * and the only danger is skipping too much.
>   */
> if (PageCompound(page)) {
>      const unsigned int order = compound_order(page);
>      if (blockpfn + (1UL << order) <= end_pfn) {
>          blockpfn += (1UL << order) - 1;
>          page += (1UL << order) - 1;
>          nr_scanned += (1UL << order) - 1;
>      }
>      goto isolate_fail;
> }
> 
> After exiting the for loop:
> blockpfn =basepfn+ 2+2^9 = basepfn+514
> endpfn  = basepfn +512
> total_isolated = 2
> nr_scanned = 514

In your case, the 'blockpfn' will not be updated to 'basepfn+514', 
because 'blockpfn + (1UL << order) > end_pfn', right? And remember the 
'end_pfn' is the end of the pageblock.

So I'm still confused about your case. Is this from code inspection?

> /*
> * Be careful to not go outside of the pageblock.
> */
> if (unlikely(blockpfn > end_pfn))
> blockpfn = end_pfn;
>   
> So this can happen
> 
> /*
>   * If strict isolation is requested by CMA then check that all the
>   * pages requested were isolated. If there were any failures, 0 is
>   * returned and CMA will fail.
>   */
> if (strict && blockpfn < end_pfn)
> total_isolated = 0;
> 
> If processed according to the old code, it will not enter the if statement to reset total_isolated, but the correct handling is to reset total_isolated to 0.

Please do not top-posting:

"
- Use interleaved ("inline") replies, which makes your response easier 
to read. (i.e. avoid top-posting -- the practice of putting your answer 
above the quoted text you are responding to.) For more details, see
   :ref:`Documentation/process/submitting-patches.rst 
<interleaved_replies>`.
"

