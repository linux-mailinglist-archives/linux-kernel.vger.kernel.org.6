Return-Path: <linux-kernel+bounces-172977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A99FE8BF9A5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB4211C2177F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD0076F1D;
	Wed,  8 May 2024 09:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XJ1/7aSq"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38001DFE8
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 09:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715161228; cv=none; b=JKRFjH9GF6oQ3+H84oOxvYkV8+Wc59XmBamhWV2JRW0oGf4YJxROvHZpG1wFacGNaIIQwykROE6l+I2/BzdKoyRI1cFGk0+Pv7VJtNjKpN6Ujayweell5cYPo13+nHFeUXJ9ign7izPeE0B2nT+GBxiJ6eg9w+PQi4wzNYSIZW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715161228; c=relaxed/simple;
	bh=89fF2WUvzEs/BGabOMYifyRgGUfmVocWR9VpboGPG6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hCgSzpQUGb7S9v5DEwU054JHkKU9NsPcQ7rD5hxFa+ey2i265tO1aIdgZKg5ktGB7Er/59iijZJ/igw6aEFiZqjZG7UF/ogBXZBmsY4UFw8DovxQYIll5mtchRrJFuOAiMAC2y5ST1yK+qLAwCTDm1ckdrQdz10hRooqJcupG4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XJ1/7aSq; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715161222; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7PolV6oZOy6l4rky9sVZcKOydBFtU8Dw4oGyzGtNEmk=;
	b=XJ1/7aSqVuFwfQRJ7CXhJ0/NvSX/Hd4MNkMf5DGn63YxLjFIDpVSp9kA4RtsRZY0JSEzfYsgaYEWC4dv3jPOAuKueDzzuEa13KiruigaWIbomcZLTzjzEkulq90FA2bTcNcekBZkgHX4kf/nlv5yrx+kyott16Ae9UCJpRUg0D4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W63EItG_1715161219;
Received: from 30.97.56.69(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W63EItG_1715161219)
          by smtp.aliyun-inc.com;
          Wed, 08 May 2024 17:40:21 +0800
Message-ID: <aedb9063-bdbb-46a6-96ca-0381e7931a0e@linux.alibaba.com>
Date: Wed, 8 May 2024 17:40:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] mm: move highest_order() and next_order() out of the
 THP config
To: Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, david@redhat.com, ioworker0@gmail.com,
 wangkefeng.wang@huawei.com, ying.huang@intel.com, 21cnbao@gmail.com,
 shy828301@gmail.com, ziy@nvidia.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1714978902.git.baolin.wang@linux.alibaba.com>
 <d9c0ac9df6f6e6176b09fc1ae58146ec4f8d73f5.1714978902.git.baolin.wang@linux.alibaba.com>
 <9576c979-8a11-48e2-aec4-646acf0d8e26@arm.com>
 <2fcd6dfc-21b7-4e3f-9741-8f0d23d2da5f@linux.alibaba.com>
 <b5592a14-4add-42a4-89aa-e9a54ed7123c@arm.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <b5592a14-4add-42a4-89aa-e9a54ed7123c@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/5/8 17:06, Ryan Roberts wrote:
> On 08/05/2024 03:13, Baolin Wang wrote:
>>
>>
>> On 2024/5/7 18:21, Ryan Roberts wrote:
>>> On 06/05/2024 09:46, Baolin Wang wrote:
>>>> Move highest_order() and next_order() out of the CONFIG_TRANSPARENT_HUGEPAGE
>>>> macro, which can be common functions to be used.
>>>
>>> Sorry if I haven't kept up with the discussion, but why is this needed? I
>>> wouldn't expect a need to iterate over orders if THP is compile-time disabled
>>> because we will never try to allocate THP?
>>
>> Cause I don't want to add some dummy functions to avoid building errors if
>> CONFIG_TRANSPARENT_HUGEPAGE is not enabled in patch 6. Another thought is that
>> the pagecache can also allocate a large folio even when THP is not enabled, so
>> these helpers may be used in the future (not sure though).
> 
> OK, I'll admit I haven't looked at the latter patches yet - I'd like to conclude
> on the interface and mapping/alignment strategy first.
> 
> But it wasn't necessary to access these functions for the anon/private case
> without CONFIG_TRANSPARENT_HUGEPAGE, so I'm wondering why it's needed for shmem
> case. I would expect that they don't need to be defined at all.

Currently in the shmem_alloc_and_add_folio() function, the hugepage 
allocating is not guarded with '#ifdef CONFIG_TRANSPARENT_HUGEPAGE', but 
rather with 'IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)', which can lead to 
some building errors when CONFIG_TRANSPARENT_HUGEPAGE is not enabled. 
However, this is not a big issue, and I will make some adjustments to 
avoid defining dummy functions.

