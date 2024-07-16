Return-Path: <linux-kernel+bounces-253400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A099320BB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 08:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BF111F22AAB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 06:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5901CD32;
	Tue, 16 Jul 2024 06:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="S9oJgC54"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFEFE556
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 06:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721112620; cv=none; b=L0vX4QOP8EU9RZiwRGtlj/OZJrph5GhXK1K0bfJn7m9NOJYRSyqWgeu8c8fRH3DoKJIjvtrMrBj+uDWwzynTSjjQobDpQap1jbdyC2lzJTx46tOCToXVA1qZOsUZfdhqmsC23xj+CPDyKVQhvq/5h9t6MKZ3vbRr7ssosVEq01U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721112620; c=relaxed/simple;
	bh=IsLrB6V84NDJ7Dzu3S+6RMKrpsvz+u18MWc5r0FSRa8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ncIIvTn9DXZygiMe3ZXAr+ZyEXfJqSB0HUi12oscY/lvtGQdXfJ7i/f9dPDiwNsG8xf58ObbpeNoEy+FjucCOFPlHt0ow83VephWhzLxQYLEAonKQAvQn38MyiKbRret0WwD4DAHU+eb+v8WdncSMT1y4HBSz0a5z511DMYwOBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=S9oJgC54; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721112616; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=jkThJqmKDwkyN/7qMbadrhTMAv1WtyBe/EOZqvA9Bj8=;
	b=S9oJgC54DHBlrOdYyhXIXWsLHi8ju2Z3LiUAekYlQ2B5bAEvW0uKOA7yy/HQd+jIIaa8w3PjR4xUjAhESwiryNQmSZqvIcA4MnR3TX0tN+EBFfypggqrOZCXiDRG4YP4k3wM1+qjCZ9euBDfCUG7Qk+AbXjSZSPh7SHGJbWDl00=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045220184;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0WAgVEt._1721112614;
Received: from 30.97.48.217(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WAgVEt._1721112614)
          by smtp.aliyun-inc.com;
          Tue, 16 Jul 2024 14:50:16 +0800
Message-ID: <8754d1f7-1180-4a7a-a2c5-40aa9147fad6@linux.alibaba.com>
Date: Tue, 16 Jul 2024 14:50:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: fix schedule while atomic caused by gfp of
 erofs_allocpage
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Gao Xiang
 <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale
 <dhavale@google.com>, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, steve.kang@unisoc.com
References: <20240716054414.2446134-1-zhaoyang.huang@unisoc.com>
 <d3629955-71e5-442f-ad19-e2a4e1e9b04c@linux.alibaba.com>
 <CAGWkznEpn0NNTiYL-VYohcmboQ-kTDssiGZyi84BXf5i8+KA-Q@mail.gmail.com>
 <a41d38bb-756a-4773-8d87-b43b0c5ed9a9@linux.alibaba.com>
 <CAGWkznH4h=B1iUHps6r6DKhx2xt-Pn3-Pd1_fFjabeun6rmO_Q@mail.gmail.com>
 <dedea322-c2c5-4e1b-b5c6-0889a78c19fa@linux.alibaba.com>
In-Reply-To: <dedea322-c2c5-4e1b-b5c6-0889a78c19fa@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/7/16 14:46, Gao Xiang wrote:
> 
> 
> On 2024/7/16 14:43, Zhaoyang Huang wrote:
>> On Tue, Jul 16, 2024 at 2:20 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>>
>>>
>>>
> 
> ...
> 
>>>>>
>>>>> I don't see why it's an atomic context,
>>>>> so this patch is incorrect.
>>>> Sorry, I should provide more details. page_cache_ra_unbounded() will
>>>> call filemap_invalidate_lock_shared(mapping) to ensure the integrity
>>>> of page cache during readahead, which will disable preempt.
>>>
>>> Why a rwsem sleepable lock disable preemption?
>> emm, that's the original design of down_read()
> 
> No.
> 
>>
>>> context should be always non-atomic context, which is applied
>>> to all kernel filesystems.
>>   AFAICT, filemap_fault/read have added the folios of readahead to page
>> cache which means the aops->readahead basically just need to map the
>> block to this folios and then launch the bio. The erofs is a little
>> bit different to others as it has to alloc_pages for decompression
>> when doing this.
> 
> Interesting.  The whole .readahead is sleepable, including
> submit block I/Os to storage.

Also, please don't imagine your stack trace if it's a non-upstream
kernel.

> 
> Nacked-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Thanks,
> Gao Xiang

