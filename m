Return-Path: <linux-kernel+bounces-268813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8548E9429BE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 941C81C219E9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B7E1A8C02;
	Wed, 31 Jul 2024 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BjGohsRH"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3220A1A6166
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 08:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722416210; cv=none; b=Cvh2jtQNxbIfDdr6H+y/E+HJ9+BTAONRDv5CAUs9jAcs5vLh2OCDkSLhUkT7fuUE7PcIbGbsasLZ3aHGf2J9koDCqU6wf7E1Hl2bc0O92h7DlQktHmByh+P66fk46XrC6SX9ukIYGlI6XoW2cRPKTWGAx8MdnFZYw1PrebA+75I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722416210; c=relaxed/simple;
	bh=jAnae7yFC3cvb61ikAkmBnHSdDN5g5vRqTN5EvXfs+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nb1dDVGkOZvZWPeeuOFQiWfmD6Zy7E5CpozOhUp/P9vk2syDqBEwjoyfDX2DxA+lSd7UI+mM0JceB1fU4t9+xeL3UlK5ZTI0HrOBoBnmpnnioVTJl2mKbvhvD/jEfghCG7JYhJaL1WIe6d9t3BJIAg0wRysx2LL8UqDOAsbZWRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BjGohsRH; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722416199; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kpUCMeoZ5dTrePfp/H/ARFKfWPMZO8GvyAL7iVNght0=;
	b=BjGohsRHxTUKdKvYv0KoiXDMFhC2YqLsSDIBTkTf2nuj5FmZO3vGP6MdDq1nrKK5Vth+w9przLc0UbG+5W9jusMgct8JcrsP3PTd7ZhLkz/lSxyt4NjkqsFeHNLFSRDrksymDkHVlvVpvMq1D+gUbmzrQZA1A23fc2cJ4LlSaaA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0WBingo2_1722416197;
Received: from 30.97.56.76(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WBingo2_1722416197)
          by smtp.aliyun-inc.com;
          Wed, 31 Jul 2024 16:56:38 +0800
Message-ID: <c55d7ef7-78aa-4ed6-b897-c3e03a3f3ab7@linux.alibaba.com>
Date: Wed, 31 Jul 2024 16:56:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: shmem: avoid allocating huge pages larger than
 MAX_PAGECACHE_ORDER for shmem
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org,
 david@redhat.com, ryan.roberts@arm.com, ziy@nvidia.com, gshan@redhat.com,
 ioworker0@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <117121665254442c3c7f585248296495e5e2b45c.1722404078.git.baolin.wang@linux.alibaba.com>
 <CAGsJ_4xmHY06VAKzXxCFcovPkrR0WOR28jXbaeD5VyUBHWzn_w@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAGsJ_4xmHY06VAKzXxCFcovPkrR0WOR28jXbaeD5VyUBHWzn_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/7/31 14:18, Barry Song wrote:
> On Wed, Jul 31, 2024 at 1:46 PM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>> Similar to commit d659b715e94ac ("mm/huge_memory: avoid PMD-size page cache
>> if needed"), ARM64 can support 512MB PMD-sized THP when the base page size is
>> 64KB, which is larger than the maximum supported page cache size MAX_PAGECACHE_ORDER.
>> This is not expected. To fix this issue, use THP_ORDERS_ALL_FILE_DEFAULT for
>> shmem to filter allowable huge orders.
>>
>> Fixes: e7a2ab7b3bb5 ("mm: shmem: add mTHP support for anonymous shmem")
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> Reviewed-by: Barry Song <baohua@kernel.org>

Thanks for reviewing.

> 
>> ---
>>   mm/shmem.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 2faa9daaf54b..a4332a97558c 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -1630,10 +1630,10 @@ unsigned long shmem_allowable_huge_orders(struct inode *inode,
>>          unsigned long within_size_orders = READ_ONCE(huge_shmem_orders_within_size);
>>          unsigned long vm_flags = vma->vm_flags;
>>          /*
>> -        * Check all the (large) orders below HPAGE_PMD_ORDER + 1 that
>> +        * Check all the (large) orders below MAX_PAGECACHE_ORDER + 1 that
>>           * are enabled for this vma.
> 
> Nit:
> THP_ORDERS_ALL_FILE_DEFAULT should be self-explanatory enough.
> I feel we don't need this comment?

Sure.

Andrew, please help to squash the following changes into this patch. Thanks.

diff --git a/mm/shmem.c b/mm/shmem.c
index 6e9836b1bd1d..432faec21547 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1629,10 +1629,6 @@ unsigned long shmem_allowable_huge_orders(struct 
inode *inode,
         unsigned long mask = READ_ONCE(huge_shmem_orders_always);
         unsigned long within_size_orders = 
READ_ONCE(huge_shmem_orders_within_size);
         unsigned long vm_flags = vma->vm_flags;
-       /*
-        * Check all the (large) orders below MAX_PAGECACHE_ORDER + 1 that
-        * are enabled for this vma.
-        */
         unsigned long orders = THP_ORDERS_ALL_FILE_DEFAULT;
         loff_t i_size;
         int order;

