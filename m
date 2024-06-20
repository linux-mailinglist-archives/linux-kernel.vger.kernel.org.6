Return-Path: <linux-kernel+bounces-222246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B3290FEC7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B634D2886FF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EAB18EFEE;
	Thu, 20 Jun 2024 08:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KwPjxEsz"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7810D18EFEC
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718872001; cv=none; b=nZPPobIf335L8oaiE6+HWrqkXW3+OeR+4473fMwVDl+h5Bwt0czOArimW2a6YZ6qQJxpNGodc3e4zMHFrpVnMgek7/+zcs7KsUqzFRtTwCHnrCqDWU6RzaRW6/G13yt4rPKHth7Ti3zOabNX+zzu95qK9LfwCXlO1jL+JxUhhuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718872001; c=relaxed/simple;
	bh=v/K4VQme0bvsViQPwjOHP3RbmQFWbhgWUAPcoTTrvYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FQGU5W92lk+8vlR9P8ZZ1nQIXfS8heF1YVhwV0c+/TxTEGC+N9u4yl4RSLnxSxOHak93ar7pGW/UZ8uxdnkf6Qdj3Bdga6rEFCoUsdZnygzshUCMZwGfMwfCHPID7uT3yaMVs66uSkcT8JkNsH7s4xYZ+lSThE6Zh0pplkbtEBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KwPjxEsz; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718871996; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ygC+TzlChiS7e/5qCa3pXxwNm9uFHomfKyMe5wbEsQY=;
	b=KwPjxEsz6sXh8ovh3uPVQytTdZQYYXWN1oSD78UnJ7i/yZiLihQAJsjOzSOA0qxbt2+9BFPgI3yuCtVFMeQVAJ7eA5tvlLvx6MhKe7fTNBUdj9xzgtHm2ju9eH1eL9mSCxzW/Fdck+5kfd5nzGEZmnzc1o2U9Z7AHpk4pdEZfFA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0W8qePrm_1718871994;
Received: from 30.97.56.69(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W8qePrm_1718871994)
          by smtp.aliyun-inc.com;
          Thu, 20 Jun 2024 16:26:35 +0800
Message-ID: <2d778151-9b8c-4be8-a4d3-bafcc1f09778@linux.alibaba.com>
Date: Thu, 20 Jun 2024 16:26:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] mm: vmscan: add validation before spliting shmem
 large folio
To: Yu Zhao <yuzhao@google.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org,
 david@redhat.com, wangkefeng.wang@huawei.com, chrisl@kernel.org,
 ying.huang@intel.com, 21cnbao@gmail.com, ryan.roberts@arm.com,
 shy828301@gmail.com, ziy@nvidia.com, ioworker0@gmail.com,
 da.gomez@samsung.com, p.raghav@samsung.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1718690645.git.baolin.wang@linux.alibaba.com>
 <413866f2f2d996cfbb5c906467b36c96b1a82e2d.1718690645.git.baolin.wang@linux.alibaba.com>
 <CAOUHufavGxeE4nyBnjRMo+BqFyTRUJMyoqBkEDV_c=x-PibvEg@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAOUHufavGxeE4nyBnjRMo+BqFyTRUJMyoqBkEDV_c=x-PibvEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/6/20 14:12, Yu Zhao wrote:
> On Tue, Jun 18, 2024 at 12:54 AM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>> Add swap available space validation before spliting shmem large folio to
>> avoid redundant split, since we can not write shmem folio to the swap device
>> in this case.
> 
> We don't scan anon LRU unless we know we may be able to swap. Even if
> there is swap space, we may still not be able to swap. See
> can_reclaim_anon_pages().

Right. Another case is MADV_PAGEOUT can still split a large shmem folio 
even without a swap device. I know this is not a common case, and I can 
drop this patch if it is less helpful.

Thanks for your input.

>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   mm/vmscan.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 1807e5d95dda..61465f92283f 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1237,6 +1237,14 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>>                          }
>>                  } else if (folio_test_swapbacked(folio) &&
>>                             folio_test_large(folio)) {
>> +
>> +                       /*
>> +                        * Do not split shmem folio if no swap memory
>> +                        * available.
>> +                        */
>> +                       if (!total_swap_pages)
>> +                               goto activate_locked;
>> +
>>                          /* Split shmem folio */
>>                          if (split_folio_to_list(folio, folio_list))
>>                                  goto keep_locked;
>> --
>> 2.39.3
>>
>>

