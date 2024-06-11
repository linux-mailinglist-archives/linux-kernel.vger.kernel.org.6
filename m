Return-Path: <linux-kernel+bounces-209224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 994A3902F2A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 05:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4E80281D10
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 03:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299A116F90A;
	Tue, 11 Jun 2024 03:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ljG03P5C"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4469613DDCC
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 03:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718077124; cv=none; b=ZM91fdkUg46wV6jlk4opzUCgfags356edxUNvW3r+1tyR40Ui9AOjC7JUz3M8NxLMm6ALtCi+ZXK/5d/yhG5ACJ4BV2nqGGKsYajFZu2pc6qCPuFAmRRrZ8Ty+8bPD+fAn5cUgN04LFNWw9EzcGSzKH7ZZ/jo9X3Arah0V5zGKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718077124; c=relaxed/simple;
	bh=tRwXcd+oqosmm8YcYc7axe7wtapNNoU0sAxBy0na0wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DuVynHv5WESsZug7slLrY6WF7OrsP6EgnNBOh7sWraGkOIytRz2KiigxZbWrmhYa0cUloStSqafONsmm49TrceyO1LbBAWnVZxm9T1mLKHLqD4oKIUpxV2dZ9zBzr/CJfpdbNU4vFGUqmuk1KClezQOmxTy0lC/cDknKYmiKxJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ljG03P5C; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718077114; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=QDcikbdRYxYQ32eA9e+mi5J1LcxsHOoeSQCbKKlUbZ8=;
	b=ljG03P5COHN7MYQa2Xr7pm+Ocy7Cuwk2DmtYNQH4oODQaw7RUl3ebb0USKiuPtagGAZ1ayAoOz5AljS4gj+f4MESndZaEnZTnAIJzA2v90b8H8bVpEoJcCr2slIH/S+rKWDvTbZVkxPL9rAI9uXDQzMsLl4cqWYL08s1yMGkxw8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W8Ezy66_1718077111;
Received: from 30.97.56.68(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W8Ezy66_1718077111)
          by smtp.aliyun-inc.com;
          Tue, 11 Jun 2024 11:38:32 +0800
Message-ID: <1d951d46-8c80-4458-a1bf-b94680c451a6@linux.alibaba.com>
Date: Tue, 11 Jun 2024 11:38:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] mm: add new 'orders' parameter for find_get_entries()
 and find_lock_entries()
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, hughd@google.com, david@redhat.com,
 wangkefeng.wang@huawei.com, chrisl@kernel.org, ying.huang@intel.com,
 21cnbao@gmail.com, ryan.roberts@arm.com, shy828301@gmail.com,
 ziy@nvidia.com, ioworker0@gmail.com, da.gomez@samsung.com,
 p.raghav@samsung.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1717673614.git.baolin.wang@linux.alibaba.com>
 <5304c4c54868336985b396d2c46132c2e0cdf803.1717673614.git.baolin.wang@linux.alibaba.com>
 <Zmcw-DymPwFcOqOY@casper.infradead.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <Zmcw-DymPwFcOqOY@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/11 00:59, Matthew Wilcox wrote:
> On Thu, Jun 06, 2024 at 07:58:55PM +0800, Baolin Wang wrote:
>> In the following patches, shmem will support the swap out of large folios,
>> which means the shmem mappings may contain large order swap entries, so an
>> 'orders' array is added for find_get_entries() and find_lock_entries() to
>> obtain the order size of shmem swap entries, which will help in the release
>> of shmem large folio swap entries.
> 
> I am not a fan.

With Daniel's suggestion, I think I can drop the 'order' parameter if 
you don't like it.

I was hoping that 'order' would be encoded in the swap
> entry, not passed as a separate parameter.
> 
> As I understand it, we currently have a free bit, or
> swp_to_radix_entry() would not work.  We can use that as detailed
> here to encode the order in a single bit.
> 
> https://kernelnewbies.org/MatthewWilcox/NaturallyAlignedOrder

OK. This seems to deserve a separate patch set. I will look at your 
suggestion in detail. Thanks.

