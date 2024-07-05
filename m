Return-Path: <linux-kernel+bounces-241898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8C09280D8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 05:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CEB31F2571D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 03:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7264249654;
	Fri,  5 Jul 2024 03:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="R+eDdP3D"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB794405F8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 03:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720148484; cv=none; b=Er9ZS6KXpJiRqXmIYEyiUwmnPMqTbcR0gdowGTO4jVXxFIeerq+kAAvSt+Di6AZr77I2Oqvyu8kcH/dNx+VY9uQsRgf7nJ4N82W9WuJFmtP2NzckQoa85UiaqdAVFkwnJsAHW1u1w1aycNILyJfQHYaCTt2AyoxEKLr70gh/clA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720148484; c=relaxed/simple;
	bh=Rby4W6dT5vYCFMwd+iCGfbKcFb0WKw73+FI15LqfUj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fQyuyS9HBYZLaV/sKnCZKQVe5n8aeZMkdR1hJwMD6F8JPfLNEBcCFzY8N7AC2faZJn5WDe6nC+IyNHvfINYI1jhqLxxPhexImKarfeDphqAymAHEYGf0Me05cLdPmRa05wFmOZNBnO9Rfz4TEgq8hIFiALLJgmkyjDvqRAPY1oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=R+eDdP3D; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720148474; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=RXHUr7dIEjsbQruRykvzvbQCHWUjTYhMyKV4za3Jfiw=;
	b=R+eDdP3DAc7LhtfsB8hgGws+ruccWiJVX6vZzNgs39tICAAfFe1kxhUsd5F3VC/YAhQ0mclpmx7qDEQE05UefMmYV9xtRqS2sClSl9yJ5H9M1GvR2BBzrUU1RfnoOlCweE49O2ldWE+A8Bjqs+SV1sPFaYgGb8zTpEabqcF5+ms=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W9tBVtX_1720148471;
Received: from 30.97.56.65(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W9tBVtX_1720148471)
          by smtp.aliyun-inc.com;
          Fri, 05 Jul 2024 11:01:13 +0800
Message-ID: <076550c4-0e8a-4344-9f8a-31ae9e1051b5@linux.alibaba.com>
Date: Fri, 5 Jul 2024 11:01:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] mm: shmem: add mTHP support for anonymous shmem
To: Bang Li <libang.linux@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>,
 akpm@linux-foundation.org, hughd@google.com
Cc: willy@infradead.org, david@redhat.com, wangkefeng.wang@huawei.com,
 ying.huang@intel.com, 21cnbao@gmail.com, shy828301@gmail.com,
 ziy@nvidia.com, ioworker0@gmail.com, da.gomez@samsung.com,
 p.raghav@samsung.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1718090413.git.baolin.wang@linux.alibaba.com>
 <65796c1e72e51e15f3410195b5c2d5b6c160d411.1718090413.git.baolin.wang@linux.alibaba.com>
 <65c37315-2741-481f-b433-cec35ef1af35@arm.com>
 <475332ea-a80b-421c-855e-a663d1d5bfc7@linux.alibaba.com>
 <a3910f60-6e2e-4ede-b3f3-47d8dfe9f23b@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <a3910f60-6e2e-4ede-b3f3-47d8dfe9f23b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/7/4 22:46, Bang Li wrote:
> Hi Bao lin,
> 
> On 2024/7/4 19:15, Baolin Wang wrote:
>>
>>>> +
>>>> +    /*
>>>> +     * Only allow inherit orders if the top-level value is 'force', 
>>>> which
>>>> +     * means non-PMD sized THP can not override 'huge' mount option 
>>>> now.
>>>> +     */
>>>> +    if (shmem_huge == SHMEM_HUGE_FORCE)
>>>> +        return READ_ONCE(huge_shmem_orders_inherit);
>>>
>>> I vaguely recall that we originally discussed that trying to set 
>>> 'force' on the
>>> top level control while any per-size controls were set to 'inherit' 
>>> would be an
>>> error, and trying to set 'force' on any per-size control except the 
>>> PMD-size
>>> would be an error?
>>
>> Right.
>>
>>> I don't really understand this logic. Shouldn't we just be looking at 
>>> the
>>> per-size control settings (or the top-level control as a proxy for every
>>> per-size control that has 'inherit' set)?
>>
>> ‘force’ will apply the huge orders for anon shmem and tmpfs, so now we 
>> only allow pmd-mapped THP to be forced. We should not look at per-size 
>> control settings for tmpfs now (mTHP for tmpfs will be discussed in 
>> future).
>>
>>>
>>> Then for tmpfs, which doesn't support non-PMD-sizes yet, we just 
>>> always use the
>>> PMD-size control for decisions.
>>>
>>> I'm also really struggling with the concept of shmem_is_huge() 
>>> existing along
>>> side shmem_allowable_huge_orders(). Surely this needs to all be 
>>> refactored into
>>> shmem_allowable_huge_orders()?
>>
>> I understood. But now they serve different purposes: shmem_is_huge() 
>> will be used to check the huge orders for the top level, for *tmpfs* 
>> and anon shmem; whereas shmem_allowable_huge_orders() will only be 
>> used to check the per-size huge orders for anon shmem (excluding tmpfs 
>> now). However, as I plan to add mTHP support for tmpfs, I think we can 
>> perform some cleanups. 
> 
> Please count me in, I'd be happy to contribute to the cleanup and 
> enhancement
> process if I can.

Good. If you have time, I think you can look at the shmem khugepaged 
issue from the previous discussion [1], which I don't have time to look 
at now.

"
(3) khugepaged

khugepaged needs to handle larger folios properly as well. Until fixed,
using smaller THP sizes as fallback might prohibit collapsing a
PMD-sized THP later. But really, khugepaged needs to be fixed to handle
that.
"

[1] 
https://lore.kernel.org/all/f1783ff0-65bd-4b2b-8952-52b6822a0835@redhat.com/T/#u

