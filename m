Return-Path: <linux-kernel+bounces-211265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B10904F43
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A784E1F27E9D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9831116DEAE;
	Wed, 12 Jun 2024 09:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SHocLqJg"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911A21CFB5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718184510; cv=none; b=qCLmlNiqp7bEarzrN8F87w0FZuISh7Imw8DsFXsGrovnPT68qrVv6d5jSIXn34aP7Rh90PqoRjvX3Xi5di1RN/HwlPETaZeMmvmOm8NzJ296txBZZnR/OglSOqWDs4gTLYwTXqEcbVdi/PDIbgDTMzcBi0/3FYDHxev2Op0oUhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718184510; c=relaxed/simple;
	bh=EUldknPCxcYd2b2Atec9Jy63ezEUQfQhWRCrWrNX5N4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dwJLbp1ayf4tnlqhbZkN0ges+aTeNdYFQ9CnNpZpiLlNoqDppIo3BHOr6qIVg3EfWnN/ncFvc4nLmCEqv8FyMgIqR1uyfo2DyMaZ1blj7p0KSXXq7t7ErHu073osc2WKafq44ckbMe2qeXxmWJON3y7Er3cKCtQ6/1P5qaUfuzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SHocLqJg; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718184505; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=EHjZSLjaXmqO3nCJmphf3wWKY9Z7DZNq9QkKmioWbMo=;
	b=SHocLqJgLvHNHCxcmzmRa9VzFUN3EIwMkQohDvlowFHjukVz7DwdJh3ifFirIDkBjm598OIM2a1N1GGPSPi2VkIS/u7FNknuTS9ntub1CBUwcBbkF+SIcvSHiB5HmxYCbT7N/y7m+Wlb3aYhkeNMXCDaopUmHJKSruktPNFhj8s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8KLpTV_1718184502;
Received: from 30.97.56.60(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W8KLpTV_1718184502)
          by smtp.aliyun-inc.com;
          Wed, 12 Jun 2024 17:28:23 +0800
Message-ID: <df06474c-110f-459d-a093-76074e0b5666@linux.alibaba.com>
Date: Wed, 12 Jun 2024 17:28:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] mm: shmem: add mTHP counters for anonymous shmem
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org,
 david@redhat.com, wangkefeng.wang@huawei.com, ying.huang@intel.com,
 21cnbao@gmail.com, ryan.roberts@arm.com, shy828301@gmail.com,
 ziy@nvidia.com, da.gomez@samsung.com, p.raghav@samsung.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1718090413.git.baolin.wang@linux.alibaba.com>
 <4fd9e467d49ae4a747e428bcd821c7d13125ae67.1718090413.git.baolin.wang@linux.alibaba.com>
 <CAK1f24=Rz4qPyw9pfTHTAuQO6Yv9mFHccjCd75a0kvHvCBH3uA@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAK1f24=Rz4qPyw9pfTHTAuQO6Yv9mFHccjCd75a0kvHvCBH3uA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/6/12 16:04, Lance Yang wrote:
> Hi Baolin,
> 
> On Tue, Jun 11, 2024 at 6:11 PM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>> Add mTHP counters for anonymous shmem.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   include/linux/huge_mm.h |  3 +++
>>   mm/huge_memory.c        |  6 ++++++
>>   mm/shmem.c              | 18 +++++++++++++++---
>>   3 files changed, 24 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index 909cfc67521d..212cca384d7e 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -281,6 +281,9 @@ enum mthp_stat_item {
>>          MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
>>          MTHP_STAT_SWPOUT,
>>          MTHP_STAT_SWPOUT_FALLBACK,
>> +       MTHP_STAT_FILE_ALLOC,
>> +       MTHP_STAT_FILE_FALLBACK,
>> +       MTHP_STAT_FILE_FALLBACK_CHARGE,
>>          __MTHP_STAT_COUNT
>>   };
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 1360a1903b66..3fbcd77f5957 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -555,6 +555,9 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
>>   DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
>>   DEFINE_MTHP_STAT_ATTR(swpout, MTHP_STAT_SWPOUT);
>>   DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK);
>> +DEFINE_MTHP_STAT_ATTR(file_alloc, MTHP_STAT_FILE_ALLOC);
>> +DEFINE_MTHP_STAT_ATTR(file_fallback, MTHP_STAT_FILE_FALLBACK);
>> +DEFINE_MTHP_STAT_ATTR(file_fallback_charge, MTHP_STAT_FILE_FALLBACK_CHARGE);
>>
>>   static struct attribute *stats_attrs[] = {
>>          &anon_fault_alloc_attr.attr,
>> @@ -562,6 +565,9 @@ static struct attribute *stats_attrs[] = {
>>          &anon_fault_fallback_charge_attr.attr,
>>          &swpout_attr.attr,
>>          &swpout_fallback_attr.attr,
>> +       &file_alloc_attr.attr,
>> +       &file_fallback_attr.attr,
>> +       &file_fallback_charge_attr.attr,
>>          NULL,
>>   };
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index f5469c357be6..99bd3c34f0fb 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -1773,6 +1773,9 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
>>
>>                          if (pages == HPAGE_PMD_NR)
>>                                  count_vm_event(THP_FILE_FALLBACK);
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +                       count_mthp_stat(order, MTHP_STAT_FILE_FALLBACK);
>> +#endif
> 
> Using the conditional compilation directives here is a bit weird :)
> Would there be any issues if we were to drop them?

Will cause building errors if CONFIG_TRANSPARENT_HUGEPAGE is not enabled.

> 
> Since THP_FILE_FALLBACK is working as expected, MTHP_STAT_FILE_FALLBACK
> should work as well without the conditional compilation directives, IIUC.

No, you should take a look at how count_mthp_stat() is defined :)

