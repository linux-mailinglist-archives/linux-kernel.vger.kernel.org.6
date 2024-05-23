Return-Path: <linux-kernel+bounces-186916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB66A8CCAC1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 04:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E593C1C21256
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 02:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED1B13A275;
	Thu, 23 May 2024 02:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bC1i7g6u"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95E3139D19
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 02:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716431519; cv=none; b=KIsmliGMDtUp2C88Srd8AisVHyioEZuK1hY/Vu5FuZKLl4hegIqPKHQYZDTvEuhkgzk77lIDEXelS3zrrFDANlsISkbcVH91TsxvGJaUJLy4WpbZ7P8g3GbMPwfAybHVRGlIQ6S3blpq0QPT1Qhgf8/x0sQl7EHTm0kHixK23dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716431519; c=relaxed/simple;
	bh=HP2XqW4W+jCxshQoOMFnVzTfRYwt8O0PDxXiJCe02mY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GxsC7QAg/+Syt5PBP/xiTK4D0shnpNutOTtyJcoFO03ZvMiu2yuUrvT3TY4i4kIcRV78A2Uup2Ofs4A+NeFebuQaKTpdX5yI2xNj1B9QFI/5vWEAL6jM4P/qdTRXymC+psT6UopbARUH9huk9MIigKMWDyJiTKt/ZRYEY4R2eoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bC1i7g6u; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716431515; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ack/kVE3TxqOGngSexMdxdtp5NY2ZX4sfLT+4hAq/lQ=;
	b=bC1i7g6uMV5JAGFhhNlrNIud7xG3jIwQ1S25QdNoOExENcQVweT/A0mvcKnPhGY8qSdADqGEb117d1euWZtPoAMY8u/Vs6TMS1BJpzgqKu+gtAMG19/lzU6lkOViJyLsJpJbKQ7gpxx3PL5emJydaxC+JPuQuExOVK1ZY7X5rMI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W718O2a_1716431513;
Received: from 30.97.56.57(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W718O2a_1716431513)
          by smtp.aliyun-inc.com;
          Thu, 23 May 2024 10:31:54 +0800
Message-ID: <2ee94722-456f-4db0-9ed9-3f1c72239a75@linux.alibaba.com>
Date: Thu, 23 May 2024 10:31:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: drop the 'anon_' prefix for swap-out mTHP counters
To: Barry Song <21cnbao@gmail.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, David Hildenbrand
 <david@redhat.com>, akpm@linux-foundation.org, willy@infradead.org,
 ryan.roberts@arm.com, ziy@nvidia.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <0e2a6f232e7579a2e4407ecf075531980d97f286.1716367360.git.baolin.wang@linux.alibaba.com>
 <22ac01a3-ddbb-4114-88cd-ad1a31982dad@redhat.com>
 <51ba1fc1-fd77-4601-8d27-459162fd008c@linux.alibaba.com>
 <CAGsJ_4zSuOTPi+zkS_kvS5T0MsdMBR+2gpXukJt0aMPrEnCDZg@mail.gmail.com>
 <875xv5ba8t.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <18aa865a-6d4a-4dcf-99ce-bcfbc0c92f19@linux.alibaba.com>
 <CAGsJ_4xeuLS9L=ayUSor4kXs8B1c2bY01cGZYrR7QjdwQWu7Lg@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAGsJ_4xeuLS9L=ayUSor4kXs8B1c2bY01cGZYrR7QjdwQWu7Lg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/5/23 10:12, Barry Song wrote:
> On Thu, May 23, 2024 at 1:38 PM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>>
>>
>> On 2024/5/23 09:14, Huang, Ying wrote:
>>> Barry Song <21cnbao@gmail.com> writes:
>>>
>>>> On Wed, May 22, 2024 at 9:38 PM Baolin Wang
>>>> <baolin.wang@linux.alibaba.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 2024/5/22 16:58, David Hildenbrand wrote:
>>>>>> On 22.05.24 10:51, Baolin Wang wrote:
>>>>>>> The mTHP swap related counters: 'anon_swpout' and
>>>>>>> 'anon_swpout_fallback' are
>>>>>>> confusing with an 'anon_' prefix, since the shmem can swap out
>>>>>>> non-anonymous
>>>>>>> pages. So drop the 'anon_' prefix to keep consistent with the old swap
>>>>>>> counter
>>>>>>> names.
>>>>>>>
>>>>>>> Suggested-by: "Huang, Ying" <ying.huang@intel.com>
>>>>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>>>> ---
>>>>>>
>>>>>> Am I daydreaming or did we add the anon_ for a reason and discussed the
>>>>>> interaction with shmem? At least I remember some discussion around that.
>>>>>
>>>>> Do you mean the shmem mTHP allocation counters in previous
>>>>> discussion[1]? But for 'anon_swpout' and 'anon_swpout_fallback', I can
>>>>> not find previous discussions that provided a reason for adding the
>>>>> ‘anon_’ prefix. Barry, any comments? Thanks.
>>>>
>>>> HI Baolin,
>>>> We had tons of emails discussing about namin and I found this email,
>>>>
>>>> https://lore.kernel.org/all/bca6d142-15fd-4af5-9f71-821f891e8305@redhat.com/
>>>>
>>>> David had this comment,
>>>> "I'm wondering if these should be ANON specific for now. We might want to
>>>> add others (shmem, file) in the future."
>>>>
>>>> This is likely how the 'anon_' prefix started being added, although it
>>>> wasn't specifically
>>>> targeting swapout.
>>>>
>>>> I sense your patch slightly alters the behavior of thp_swpout_fallback
>>>> in /proc/vmstat.
>>>> Previously, we didn't classify them as THP_SWPOUT_FALLBACK, even though we
>>>> always split them.
>>>
>>> IIUC, "fallback" means you try to do something, but fail, so try
>>> something else as fallback.  If so, then we don't need to count
>>> splitting shmem large folio as fallback.
>>
>> Agree. In additon, IIUC we have never counted splitting shmem large
>> folio as THP_SWPOUT_FALLBACK before or after this patch.
> 
> Hi Baolin,
> 
> My point is that THP_SWPOUT* has been dedicated to anonymous memory for years
> because we have not had the capability to perform THP_SWPOUT for shared memory
> before. This is the historical context of thp_swpout* in /proc/vmstat,
> even though it is
> not ideal. Therefore, placing shmem sysfs entries in
> /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/stats
> allows us to monitor SWPOUT and SWPOUT FALLBACK for shmem without altering
> the tradition of /proc/vmstat.

OK, I see your point. IMO this patch will not change the behaviors of 
thp_swpout* in /proc/vmstat until adding support for large folio 
swap-out for shmem[1]. Anyway we can talk about this in that thread.

[1] 
https://lore.kernel.org/all/cover.1716285099.git.baolin.wang@linux.alibaba.com/

> But I am not firm on this because I don't see the necessity to
> differentiate shmem's
> swpout from anon's swpout. They basically seem the same while anon mTHP
> faults might be significantly different from file mTHP faults, in which case we
> must distinguish them. So please send version 2 with the updated documentation.
> I believe it should target v6.10-rc rather than v6.11 to avoid ABI
> conflicts if it is
> accepted.

Sure. Will do. Thanks.

