Return-Path: <linux-kernel+bounces-389930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B18A19B7320
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 04:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 137FCB214B8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 03:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DFD13A25F;
	Thu, 31 Oct 2024 03:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="C7ZoZKiK"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6149912D1FA
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 03:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730346195; cv=none; b=aERQCixRKsFLRyqES07TI05dmYqoPWf38w2hJmG3knIQAOBykGzhzp9+nBWa51thx7Z9WfCNgZ8q6fWhX+UXSwudpZ0mLOLfH7ikhHs3tBK9/vJtbFKAgtuNmONk0Egh2+WVvmHxVRiWhyVgiJbyucY1x0trz0CGW51WTtdWbAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730346195; c=relaxed/simple;
	bh=jCeFJy/cIpzXwCHzLg5OqehWQ4edXE1UB6a5XNLlazs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cUzF6Aoiv/TfEkhap1MCR6WzZLsFZrHnDSwZNUHHmQEAbK1hx24CXJlUTq13J4TUHAy3EPYTbwRRXyI8PaOZYDqDOf6cu2w8KirzgB1vHzYtja1Bu06v1ZCp5k63IrYKN5Qi/FkyzGMhGw7vjQhWeeTc9tOhulG29Y7rcuzKhgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=C7ZoZKiK; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730346188; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=hY/BROjL9uyLBnQrHr87O2iu41QP3pQ9lVSaFNpvhuM=;
	b=C7ZoZKiK5ViMsK5xgRRlhH3Z6yf+ALBUC6KM9kr4HTDbO3MzKODfeZmnYK3g7m+GD/izZGOqgV8FJ2u5KtzUprZsWBxA5XtrutZ+iSI8HPbvV4oreKxtvZi3uq9fE1NsfqITNKtSrbsgalk2gODc4Te675riv0/fHZ6MHRS48QI=
Received: from 30.74.144.119(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WIGvBCH_1730346185 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 31 Oct 2024 11:43:06 +0800
Message-ID: <0b7671fd-3fea-4086-8a85-fe063a62fa80@linux.alibaba.com>
Date: Thu, 31 Oct 2024 11:43:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/4] Support large folios for tmpfs
To: David Hildenbrand <david@redhat.com>, Daniel Gomez <d@kruces.com>,
 Daniel Gomez <da.gomez@samsung.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
 hughd@google.com, wangkefeng.wang@huawei.com, 21cnbao@gmail.com,
 ryan.roberts@arm.com, ioworker0@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <cover.1728548374.git.baolin.wang@linux.alibaba.com>
 <Zw_IT136rxW_KuhU@casper.infradead.org>
 <e1b6fa05-019c-4a40-afc0-bc1efd15ad42@linux.alibaba.com>
 <6dohx7zna7x6hxzo4cwnwarep3a7rohx4qxubds3uujfb7gp3c@2xaubczl2n6d>
 <8e48cf24-83e1-486e-b89c-41edb7eeff3e@linux.alibaba.com>
 <CGME20241021085439eucas1p10a0b6e7c3b0ace3c9a0402427595875a@eucas1p1.samsung.com>
 <ppgciwd7cxmeqssryshe42lxwb4sdzr6gjhwwbotw4gx2l7vi5@7y4hedxpf4nx>
 <D51IU4N746MI.FDS6C7GYO4RP@samsung.com>
 <c59f2881-fbbb-41b1-830d-9d81f36ecc0b@linux.alibaba.com>
 <486a72c6-5877-4a95-a587-2a32faa8785d@redhat.com>
 <7eb412d1-f90e-4363-8c7b-072f1124f8a6@linux.alibaba.com>
 <1b0f9f94-06a6-48ac-a68e-848bce1008e9@redhat.com>
 <D53Z7I8D6MRB.XN14XUEFQFG7@kruces.com>
 <cbadd5fe-69d5-4c21-8eb8-3344ed36c721@redhat.com>
 <7ca333ba-f9bc-4f78-8f5b-1035ca91c2d5@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <7ca333ba-f9bc-4f78-8f5b-1035ca91c2d5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Sorry for late reply.

On 2024/10/28 17:48, David Hildenbrand wrote:
> On 25.10.24 22:21, David Hildenbrand wrote:
>> Sorry for the late reply!
>>
>>>>>>> IMHO, as I discussed with Kirill, we still need maintain 
>>>>>>> compatibility
>>>>>>> with the 'huge=' mount option. This means that if 'huge=never' is 
>>>>>>> set
>>>>>>> for tmpfs, huge page allocation will still be prohibited (which can
>>>>>>> address Hugh's request?). However, if 'huge=' is not set, we can
>>>>>>> allocate large folios based on the write size.
>>>
>>> So, in order to make tmpfs behave like other filesystems, we need to
>>> allocate large folios by default. Not setting 'huge=' is the same as
>>> setting it to 'huge=never' as per documentation. But 'huge=' is meant to
>>> control THP, not large folios, so it should not have a conflict here, or
>>> else, what case are you thinking?
>>
>> I think we really have to move away from "huge/thp == PMD", that's a
>> historical artifact. Everything else will simply be inconsistent and
>> confusing in the future -- and I don't see any real need for that. For
>> anonymous memory and anon shmem we managed the transition. (there is a
>> longer writeup from me about this topic, so I won't go into detail).
>>
>>
>> I think I raised this in the past, but tmpfs/shmem is just like any
>> other file system .. except it sometimes really isn't and behaves much
>> more like (swappable) anonymous memory. (or mlocked files)
>>
>> There are many systems out there that run without swap enabled, or with
>> extremely minimal swap (IIRC until recently kubernetes was completely
>> incompatible with swapping). Swap can even be disabled today for shmem
>> using a mount option.
>>
>> That's a big difference to all other file systems where you are
>> guaranteed to have backend storage where you can simply evict under
>> memory pressure (might temporarily fail, of course).
>>
>> I *think* that's the reason why we have the "huge=" parameter that also
>> controls the THP allocations during page faults (IOW possible memory
>> over-allocation). Maybe also because it was a new feature, and we only
>> had a single THP size.
>>
>> There is, of course also the "fallocate() might not free up memory if
>> there is an unexpected reference on the page because splitting it will
>> fail" problem, that even exists when not over-allocating memory in the
>> first place ...
>>
>>
>> So ...I don't think tmpfs behaves like other file system in some cases.
>> And I don't think ignoring these points is a good idea.
>>
>> Fortunately I don't maintain that code :)
>>
>>
>> If we don't want to go with the shmem_enabled toggles, we should
>> probably still extend the documentation to cover "all THP sizes", like
>> we did elsewhere.
>>
>> huge=never: no THPs of any size
>> huge=always: THPs of any size (fault/write/etc)
>> huge=fadvise: like "always" but only with fadvise/madvise
>> huge=within_size: like "fadvise" but respect i_size
> 
> Thinking some more about that over the weekend, this is likely the way 
> to go, paired with conditionally changing the default to 
> always/within_size. I suggest a kconfig option for that.

I am still worried about adding a new kconfig option, which might 
complicate the tmpfs controls further.

> That should probably do as a first shot; I assume people will want more 
> control over which size to use, especially during page faults, but that 
> can likely be added later.

After some discussions, I think the first step is to achieve two goals: 
1) Try to make tmpfs use large folios like other file systems, that 
means we should avoid adding more complex control options (per Matthew).
2) Still need maintain compatibility with the 'huge=' mount option (per 
Kirill), as I also remembered we have customers who use 
'huge=within_size' to allocate THPs for better performance.

Based on these considerations, my first step is to neither add a new 
'huge=' option parameter nor introduce the mTHP interfaces control for 
tmpfs, but rather to change the default huge allocation behavior for 
tmpfs. That is to say, when 'huge=' option is not configured, we will 
allow the huge folios allocation based on the write size. As a result, 
the behavior of huge pages for tmpfs will change as follows:

no 'huge=' set: can allocate any size huge folios based on write size
huge=never: no any size huge folios
huge=always: only PMD sized THP allocation as before
huge=fadvise: like "always" but only with fadvise/madvise
huge=within_size: like "fadvise" but respect i_size

The next step is to continue discussing whether to add a new Kconfig 
option or FADV_* in the future.

So what do you think?

