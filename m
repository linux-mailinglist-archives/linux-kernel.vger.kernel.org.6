Return-Path: <linux-kernel+bounces-196654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D78A08D5F54
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0B8EB22C5F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17789149C76;
	Fri, 31 May 2024 10:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="J3sf852S"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B714152186
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 10:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717150391; cv=none; b=rK1QkXQghiADCqQQci/PJcKm3szqkwKZ8AKOomwfGv+iIIaj1++Xkg2bLsg54vp7tW7nA8jy3iS8wTW8DTJqOj0TSXa46S1Xrlga33M+jncitqIac4dQe2Wo0O4ycgYFGHNgWPEsRswl4NvJwSNvc9yn9fkgz88W6iitm6RsIiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717150391; c=relaxed/simple;
	bh=QCtHZZ14X/rB1pYgsmDPVD/uninqZ3pM1vj5fz8+dkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MX23Y+4hMyB+1a770H+WAcOLn/kfAcnaAmsfCpiAgOO9wzLHNoinurvtAglePpumIoYLOoKsRQhReuccMMOlaAUqZtQrcXKj1bbQrkKugqMSRogJOrzqxUtjAtaxztshOpVSqKeQUbsEvmvUOu/f8v7VUK01r8KM9/2fRWAMe1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=J3sf852S; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717150386; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=4u3Py3hl45dIuxCPAqHpFkSudYL9AInU3+rNe13UhMI=;
	b=J3sf852S7ea4wzm7ZgAG6FZwUAoGgAbnIuB8ryGPJ3djmRK4bZP78Av4vetAl3v4b1cDNN6pHi+GpSFbyr9Es+toLgLAX0yupIwfnbIZAb556q8ki6gpmeX9EyerxQpefZGqUqXrB5IeB79mItVUuziKG6jzYrMxMBYOUZDsSB8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W7ZXhau_1717150384;
Received: from 30.97.56.62(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W7ZXhau_1717150384)
          by smtp.aliyun-inc.com;
          Fri, 31 May 2024 18:13:04 +0800
Message-ID: <db3517d0-54b1-4d3a-b798-1c13572d07be@linux.alibaba.com>
Date: Fri, 31 May 2024 18:13:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] add mTHP support for anonymous shmem
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, wangkefeng.wang@huawei.com, ying.huang@intel.com,
 21cnbao@gmail.com, ryan.roberts@arm.com, shy828301@gmail.com,
 ziy@nvidia.com, ioworker0@gmail.com, da.gomez@samsung.com,
 p.raghav@samsung.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1717033868.git.baolin.wang@linux.alibaba.com>
 <f1783ff0-65bd-4b2b-8952-52b6822a0835@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <f1783ff0-65bd-4b2b-8952-52b6822a0835@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/5/31 17:35, David Hildenbrand wrote:
> On 30.05.24 04:04, Baolin Wang wrote:
>> Anonymous pages have already been supported for multi-size (mTHP) 
>> allocation
>> through commit 19eaf44954df, that can allow THP to be configured 
>> through the
>> sysfs interface located at 
>> '/sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled'.
>>
>> However, the anonymous shmem will ignore the anonymous mTHP rule 
>> configured
>> through the sysfs interface, and can only use the PMD-mapped THP, that 
>> is not
>> reasonable. Many implement anonymous page sharing through 
>> mmap(MAP_SHARED |
>> MAP_ANONYMOUS), especially in database usage scenarios, therefore, 
>> users expect
>> to apply an unified mTHP strategy for anonymous pages, also including the
>> anonymous shared pages, in order to enjoy the benefits of mTHP. For 
>> example,
>> lower latency than PMD-mapped THP, smaller memory bloat than 
>> PMD-mapped THP,
>> contiguous PTEs on ARM architecture to reduce TLB miss etc.
>>
>> The primary strategy is similar to supporting anonymous mTHP. Introduce
>> a new interface '/mm/transparent_hugepage/hugepage-XXkb/shmem_enabled',
>> which can have all the same values as the top-level
>> '/sys/kernel/mm/transparent_hugepage/shmem_enabled', with adding a new
>> additional "inherit" option. By default all sizes will be set to "never"
>> except PMD size, which is set to "inherit". This ensures backward 
>> compatibility
>> with the anonymous shmem enabled of the top level, meanwhile also allows
>> independent control of anonymous shmem enabled for each mTHP.
>>
>> Use the page fault latency tool to measure the performance of 1G 
>> anonymous shmem
>> with 32 threads on my machine environment with: ARM64 Architecture, 32 
>> cores,
>> 125G memory:
>> base: mm-unstable
>> user-time    sys_time    faults_per_sec_per_cpu     faults_per_sec
>> 0.04s        3.10s         83516.416                  2669684.890
>>
>> mm-unstable + patchset, anon shmem mTHP disabled
>> user-time    sys_time    faults_per_sec_per_cpu     faults_per_sec
>> 0.02s        3.14s         82936.359                  2630746.027
>>
>> mm-unstable + patchset, anon shmem 64K mTHP enabled
>> user-time    sys_time    faults_per_sec_per_cpu     faults_per_sec
>> 0.08s        0.31s         678630.231                 17082522.495
>>
>>  From the data above, it is observed that the patchset has a minimal 
>> impact when
>> mTHP is not enabled (some fluctuations observed during testing). When 
>> enabling 64K
>> mTHP, there is a significant improvement of the page fault latency.
> 
> Let me summarize the takeaway from the bi-weekly MM meeting as I 
> understood it, that includes Hugh's feedback on per-block tracking vs. 

Thanks David for the summarization.

> mTHP:
> 
> (1) Per-block tracking
> 
> Per-block tracking is currently considered unwarranted complexity in 
> shmem.c. We should try to get it done without that. For any test cases 
> that fail, we should consider if they are actually valid for shmem.
> 
> To optimize FALLOC_FL_PUNCH_HOLE for the cases where splitting+freeing
> is not possible at fallcoate() time, detecting zeropages later and
> retrying to split+free might be an option, without per-block tracking.
> 
> (2) mTHP controls
> 
> As a default, we should not be using large folios / mTHP for any shmem, 
> just like we did with THP via shmem_enabled. This is what this series 
> currently does, and is aprt of the whole mTHP user-space interface design.
> 
> Further, the mTHP controls should control all of shmem, not only 
> "anonymous shmem".

Yes, that's what I thought and in my TODO list.

> 
> Also, we should properly fallback within the configured sizes, and not 
> jump "over" configured sizes. Unless there is a good reason.
> 
> (3) khugepaged
> 
> khugepaged needs to handle larger folios properly as well. Until fixed, 
> using smaller THP sizes as fallback might prohibit collapsing a 
> PMD-sized THP later. But really, khugepaged needs to be fixed to handle 
> that. >
> (4) force/disable
> 
> These settings are rather testing artifacts from the old ages. We should 
> not add them to the per-size toggles. We might "inherit" it from the 
> global one, though.

Sorry, I missed this. So I thould remove the 'force' and 'deny' option 
for each mTHP, right?

> 
> "within_size" might have value, and especially for consistency, we 
> should have them per size.
> 
> 
> 
> So, this series only tackles anonymous shmem, which is a good starting 
> point. Ideally, we'd get support for other shmem (especially during 
> fault time) soon afterwards, because we won't be adding separate toggles 
> for that from the interface POV, and having inconsistent behavior 
> between kernel versions would be a bit unfortunate.
> 
> 
> @Baolin, this series likely does not consider (4) yet. And I suggest we 
> have to take a lot of the "anonymous thp" terminology out of this 
> series, especially when it comes to documentation.

Sure. I will remove the "anonymous thp" terminology from the 
documentation, but want to still keep it in the commit message, cause I 
want to start from the anonymous shmem.

> 
> @Daniel, Pankaj, what are your plans regarding that? It would be great 
> if we could get an understanding on the next steps on !anon shmem.
> 

