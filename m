Return-Path: <linux-kernel+bounces-210772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E0F90487E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDF07285448
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 01:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58794C63;
	Wed, 12 Jun 2024 01:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nNbtfUT8"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEA023CE
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 01:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718156459; cv=none; b=g/9IskMxpkjRhjKESRu22ifAxMZLCgW3osxUI4ZMQm7OeEkT8/ywvoD+h/+y+7zmlq9Cm4GXez4qkImjOEIYe0R0MeAB2bSXS6mPIUUR5Rj3A9DNcx9pmelPrfqnQefXEcoc4qG3ivaSsZlhffpq/skfP5b2VO/T+XiWwYPOL9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718156459; c=relaxed/simple;
	bh=8LosHYHTG9RbVy0F9ZTMuUgNALa2Ur9R8zNb7JuWaOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JO7Fbkxkqbdn7cWxOySRB8m6Ry47NBD5iyb9b2qjVYeuD0ur/3/3E5tg/0Lqo/8OucKfTX9tmlhdP4+Tq2HP1gMwQCx64zFK1svpOUhj+VviDXqwspkUfQMqpdVQozEvqn9QKnMs9UAg/+Z/RY7+QeBue7rR5bKnVJEXf465hXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nNbtfUT8; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718156453; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=1/401mu9gQEGLWBhJwl/y7E9wdlX+Wwp801PQuc4g0Q=;
	b=nNbtfUT8Qj5NXjY1HyD6j0Tya6A2PGvtnUnZH8CJVW37lYsPudS9BM+MLZ/ImvJ+ILEUuAqXYdoo/zKkSbMqTqVSURRwz02ziIFgtwWaI28N+YiNS8Y5NttZx8M7prIqiK7Z067ZZt+czUPWICljgWKp9vlQQ6vnNLbKTR5VAuA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8I3m95_1718156451;
Received: from 30.97.56.60(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W8I3m95_1718156451)
          by smtp.aliyun-inc.com;
          Wed, 12 Jun 2024 09:40:52 +0800
Message-ID: <7cfe60a2-cd8e-4af2-a5d9-6c790b6dd665@linux.alibaba.com>
Date: Wed, 12 Jun 2024 09:40:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LTP: fork13: kernel panic on rk3399-rock-pi-4 running mainline
 6.10.rc3
To: David Hildenbrand <david@redhat.com>,
 Naresh Kamboju <naresh.kamboju@linaro.org>,
 open list <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song <baohua@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Anders Roxell <anders.roxell@linaro.org>
References: <CA+G9fYvKmr84WzTArmfaypKM9+=Aw0uXCtuUKHQKFCNMGJyOgQ@mail.gmail.com>
 <e8c10a52-61f9-4b46-bc50-e2c267b1aa56@redhat.com>
 <80a05784-21dd-4f20-b441-1e2a2be0e0ff@linux.alibaba.com>
 <3ce90ee2-f51b-49fc-b010-f97e61e617f4@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <3ce90ee2-f51b-49fc-b010-f97e61e617f4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/6/11 20:09, David Hildenbrand wrote:
> On 11.06.24 13:39, Baolin Wang wrote:
>>
>>
>> On 2024/6/11 18:32, David Hildenbrand wrote:
>>> On 11.06.24 12:14, Naresh Kamboju wrote:
>>>> The kernel panic was noticed while running LTP syscalls fork13 (long
>>>> running) on
>>>> the mainline master 6.10.rc3 kernel on arm64 rk3399-rock-pi-4 device.
>>>>
>>>> Please find detailed logs in the links,
>>>>
>>>> As you know fork13 is a stress test case trying to generate a maximum
>>>> number
>>>> of PID's in a 100,000 loop.
>>>>
>>>> This device is running via NFS mounted filesystem.
>>>>
>>>> I have tried to reproduce this problem in a loop but failed to
>>>> reproduce the
>>>> crash.
>>>>
>>>>
>>>> Crash flow:
>>>> ------
>>>> fork13 run started
>>>> BUG: Bad page map in process fork13
>>>> BUG: Bad rss-counter state mm:
>>>> Unable to handle kernel paging request at virtual address
>>>> Internal error: Oops: 0000000096000046
>>>> run for 800 secs ( 13 minutes) and more.
>>>> fork14 run started and completed
>>>>
>>>> fpathconf01 run started and completed
>>>> sugov:
>>>>
>>>> Unable to handle kernel NULL pointer dereference at virtual address
>>>>
>>>> Insufficient stack space to handle exception!
>>>> end Kernel panic - not syncing: kernel stack overflow
>>>>
>>>> I have tried to decode stack dump by not being useful [1].
>>>> [1] https://people.linaro.org/~naresh.kamboju/output-rk3399.txt
>>>>
>>>> Test log :
>>>> --------
>>>> tst_test.c:1733: TINFO: LTP version: 20240524
>>>> tst_test.c:1617: TINFO: Timeout per run is 0h 15m 00s
>>>> [  904.280569] BUG: Bad page map in process fork13  pte:2000000019ffc3
>>>> pmd:80000000df55003
>>>> [  904.281397] page: refcount:1 mapcount:-1 mapping:0000000000000000
>>>> index:0x0 pfn:0x19f
>>>
>>> Mapcount underflow on a small folio (head: not printed).
>>>
>>> [...]
>>>
>>>> [  904.294564] BUG: Bad page map in process fork13  pte:200000002e4fc3
>>>> pmd:80000000df55003
>>>> [  904.295275] page: refcount:2 mapcount:-1 mapping:000000007885152f
>>>> index:0x6 pfn:0x2e4
>>>
>>> Another mapcount underflow on a small folio (head: not printed).
>>>
>>>
>>>> [  904.309309] BUG: Bad page map in process fork13  pte:20000000cc6fc3
>>>> pmd:80000000df55003
>>>> [  904.310031] page: refcount:1 mapcount:-1 mapping:0000000000000000
>>>> index:0x6 pfn:0xcc6
>>>> [  904.310728] head: order:3 mapcount:-1 entire_mapcount:0
>>>> nr_pages_mapped:8388607 pincount:0
>>>
>>> Mapcount underflow on a large folio.
>>>
>>> ...
>>>
>>>> [  904.326666] BUG: Bad page map in process fork13  pte:20000000268fc3
>>>> pmd:80000000df55003
>>>> [  904.327390] page: refcount:1 mapcount:-1 mapping:00000000f0624181
>>>> index:0x1b pfn:0x268
>>>
>>> Another mapcount underflow on a small folio (head: not printed).
>>>
>>>> [  904.328094] memcg:ffff0000016b4000
>>>> [  904.328401] aops:nfs_file_aops ino:8526e6 dentry
>>>> name:"libgpg-error.so.0.36.0"
>>>> [  904.329051] flags:
>>>> 0x3fffe000000002c(referenced|uptodate|lru|node=0|zone=0|lastcpupid=0x1ffff)
>>>> [  904.329878] raw: 03fffe000000002c fffffdffc0009a48 fffffdffc022f3c8
>>>> ffff00000688bd60
>>>> [  904.330561] raw: 000000000000001b 0000000000000000 00000001fffffffe
>>>> ffff0000016b4000
>>>> [  904.331240] page dumped because: bad pte
>>>> [  904.331590] addr:0000aaaad9afe000 vm_flags:00000075
>>>> anon_vma:0000000000000000 mapping:ffff0000300d4188 index:2e
>>>> [  904.332476] file:fork13 fault:filemap_fault mmap:nfs_file_mmap
>>>> read_folio:nfs_read_folio
>>>> [  904.333245] CPU: 5 PID: 22685 Comm: fork13 Tainted: G    B
>>>
>>>
>>> Are these maybe side-effects due to
>>>
>>> https://lkml.kernel.org/r/20240607103241.1298388-1-wangkefeng.wang@huawei.com
>>
>> IIUC, the rk3399-rock-pi-4b device has no NUMA nodes (6 arm64 cores), so
>> I don't think the numa balancing will cause this issue.
>>
>> Anyway, I will run fork13 test case on my arm64 server to try.
> 
> I have the faint recollection that we can (or at least could in the 
> past) end up in do_numa_page() also without NUMA hinting.
> 
> I documented in 51d3d5eb74ff53b92dcff48b30ae2ed8edd85a32:
> 
> "
> Note that do_numa_page() / do_huge_pmd_numa_page() can be reached even
> without NUMA hinting (which currently doesn't seem to be applicable to
> shmem), for example, by using uffd-wp with a PROT_WRITE shmem VMA.
> "

I see. Thanks for explanation.

