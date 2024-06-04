Return-Path: <linux-kernel+bounces-200380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 332BD8FAF29
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64E481C20DB0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC551442F7;
	Tue,  4 Jun 2024 09:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FeAVMx5R"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A18143724
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 09:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717494329; cv=none; b=C1RTm/StzJ9Ed9fkjuH0A+/j7WYS/LK0XntYPw0tL1fLtt+Xa2EbVuez3FfBZuvVz8YTi3qVXPByBD+tzgYTgjJAUy4Do40YiywHpa5dh1IcbNXRPZTfSH5woSEqjkYLEBgJlTEukDwLoXd+z4hhWMqRWsWUONa6sXHuTiKqv8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717494329; c=relaxed/simple;
	bh=q6OwPnDB/7iRSRzcquIUgaQdPaEF7T8E9hWdTrF07tU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n5Zg1wYDLoPX2ETE2lfnPjptbhGOSPbDjW5nBjHDwSjN8NFPwXaZbA1Ir0o5gBPozVXGhVTMet1kZavBiGg0UJPdqLVPFNzNVGPQemF2aZJsLd2pM1DHexCmVcyPGVBzYxDBZy9gXEcatER66h/ukY6b3kbrVbWgT8tqNarFvVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FeAVMx5R; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717494323; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=vbTEU+QReOv/YXLhMYe94JXt/EprrLouNKIL/3NbTqU=;
	b=FeAVMx5RZW+bo6Hy9n0D8tG7AKOe/LoXzYAXit7nhq8pf7z7M2R2//lqWPoemiL7z8kGZOmxbkfsopiEnQ0V8WcpsONM7hUlGtwPDyNNzEEFwUyD7umSyh95pKurwCOGjCZEi7j3txdAaQdL+JLgqm2IVtO2ZUtGgSWeBBbHCs4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W7qjMx5_1717494320;
Received: from 30.97.56.67(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W7qjMx5_1717494320)
          by smtp.aliyun-inc.com;
          Tue, 04 Jun 2024 17:45:21 +0800
Message-ID: <f11c1b52-67d1-4c2a-834b-47302b0054bc@linux.alibaba.com>
Date: Tue, 4 Jun 2024 17:45:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] add mTHP support for anonymous shmem
To: Daniel Gomez <da.gomez@samsung.com>, David Hildenbrand <david@redhat.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "hughd@google.com" <hughd@google.com>,
 "willy@infradead.org" <willy@infradead.org>,
 "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
 "ying.huang@intel.com" <ying.huang@intel.com>,
 "21cnbao@gmail.com" <21cnbao@gmail.com>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
 "shy828301@gmail.com" <shy828301@gmail.com>, "ziy@nvidia.com"
 <ziy@nvidia.com>, "ioworker0@gmail.com" <ioworker0@gmail.com>,
 Pankaj Raghav <p.raghav@samsung.com>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1717033868.git.baolin.wang@linux.alibaba.com>
 <f1783ff0-65bd-4b2b-8952-52b6822a0835@redhat.com>
 <db3517d0-54b1-4d3a-b798-1c13572d07be@linux.alibaba.com>
 <CGME20240531111357eucas1p2338be7f326d8d9176d2ee212a10fc9db@eucas1p2.samsung.com>
 <502fb3df-b42b-4f0c-a98d-348c3d544721@redhat.com>
 <slkkien5nc3weyzebdlxs5jjvealqzmctbom7sfvijvkolhsjj@athcc2aqq77p>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <slkkien5nc3weyzebdlxs5jjvealqzmctbom7sfvijvkolhsjj@athcc2aqq77p>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/4 16:18, Daniel Gomez wrote:
> On Fri, May 31, 2024 at 01:13:48PM +0200, David Hildenbrand wrote:
>>>>
>>>> As a default, we should not be using large folios / mTHP for any shmem,
>>>> just like we did with THP via shmem_enabled. This is what this series
>>>> currently does, and is aprt of the whole mTHP user-space interface design.
>>>>
>>>> Further, the mTHP controls should control all of shmem, not only
>>>> "anonymous shmem".
>>>
>>> Yes, that's what I thought and in my TODO list.
>>
>> Good, it would be helpful to coordinate with Daniel and Pankaj.
> 
> I've integrated patches 11 and 12 from the lsf RFC thread [1] on top of Baolin's
> v3 patches. You may find a version in my integration branch here [2]. I can
> attach them here if it's preferred.
> 
> [1] https://lore.kernel.org/all/20240515055719.32577-1-da.gomez@samsung.com/
> [2] https://gitlab.com/dkruces/linux-next/-/commits/next-20240604-shmem-mthp
> 
> The point here is to combine the large folios strategy I proposed with mTHP
> user controls. Would it make sense to limit the orders to the mapping order
> calculated based on the size and index?

IMO, for !anon shmem, this change makes sense to me. We should respect 
the size and mTHP should act as a order filter.

For anon shmem, we should ignore the length, which you always set it to 
PAGE_SIZE in patch [1].

[1] 
https://gitlab.com/dkruces/linux-next/-/commit/edf02311fd6d86b355d3aeb74e67c8da6de3c569

> @@ -1765,6 +1798,10 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
> 
>                  order = highest_order(suitable_orders);
>                  while (suitable_orders) {
> +                       if (order > mapping_order) {
> +                               order = next_order(&suitable_orders, order);
> +                               continue;
> +                       }
>                          pages = 1UL << order;
>                          index = round_down(index, pages);
>                          folio = shmem_alloc_folio(gfp, order, info, index);
> 
> Note: The branch still need to be adapted to include !anon mm.

