Return-Path: <linux-kernel+bounces-380883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFA19AF744
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 04:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 902B51C2177C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 02:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C596A54727;
	Fri, 25 Oct 2024 02:11:02 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026F14409
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 02:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729822262; cv=none; b=gGkwGx/OanmldqocCQvKyCEn1EwOWItL3OcEr4ckz5QMVN0F83NmoxE+YysunHdH9U8ajclKFMVUCk1onAwlhpzr4ORFCU7nrIfsllzRAibPzA3xTZK2mkwKwekFWSMCyWQiYpKD3WRU3ATy310GSuhoLqFpDjbGq5WGxXPa61U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729822262; c=relaxed/simple;
	bh=d3Da7q3PcdTnA7z1IqUx2DTYwTSrQVOBqs0AHA9bhrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KrPvNhGKyehlnU0cmsRh+UX/+JjgM9qv0b7HM7d1FnQWq7ilubBEqrZuXN1MTZbhBdCHTq4FPecy65M5a2efjMrowvNk59Bvwzpm8rpk5Sq4fUjdKRClCENw6qzzsyFd2ry04SpJOFn8btgAE4b0ygNx1xU38QiHAfNdWHL9xw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XZR666nKLz10NrW;
	Fri, 25 Oct 2024 10:08:46 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id 07D0B1401F3;
	Fri, 25 Oct 2024 10:10:51 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemg200008.china.huawei.com (7.202.181.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 25 Oct 2024 10:10:50 +0800
Message-ID: <511392f2-8e94-d2fc-63a6-ac3b4cac10e1@huawei.com>
Date: Fri, 25 Oct 2024 10:10:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 3/3] mm/slub: Fix memory leak of kobj->name in
 sysfs_slab_add()
Content-Language: en-US
To: Vlastimil Babka <vbabka@suse.cz>, Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC: Liu Shixin <liushixin2@huawei.com>, Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton
	<akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>, Linux
 Memory Management List <linux-mm@kvack.org>, LKML
	<linux-kernel@vger.kernel.org>
References: <20221112114602.1268989-1-liushixin2@huawei.com>
 <20221112114602.1268989-4-liushixin2@huawei.com>
 <3780a622-03f2-4cfe-5705-0e9d0be61d57@huawei.com>
 <CAB=+i9SiiH7JN1tTrmO6FS+HqQcKnwoAs3O2PKxfPy2parM8WA@mail.gmail.com>
 <68b86f66-cd00-bb7d-b8bb-5a94e8dd1ea2@huawei.com>
 <02820eb8-0b8f-4aa8-9315-85368e9c331e@suse.cz>
 <0F94364A-F0C8-4C0A-B38D-3DDEA653B6B7@gmail.com>
 <7707ff34-16e1-4f8c-9af6-8b5b6591c77e@suse.cz>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <7707ff34-16e1-4f8c-9af6-8b5b6591c77e@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg200008.china.huawei.com (7.202.181.35)



On 2024/10/2 19:35, Vlastimil Babka wrote:
> On 9/13/24 17:00, Hyeonggon Yoo wrote:
>>
>>
>>> On Sep 13, 2024, at 11:10 PM, Vlastimil Babka <vbabka@suse.cz> wrote:
>>>
>>> On 9/6/24 10:10, Jinjie Ruan wrote:
>>>>
>>>>
>>>> On 2024/9/5 21:59, Hyeonggon Yoo wrote:
>>>>> On Thu, Sep 5, 2024 at 12:41 PM Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 2022/11/12 19:46, Liu Shixin wrote:
>>>>>>> There is a memory leak of kobj->name in sysfs_slab_add():
>>>>>>>
>>>>>>> unreferenced object 0xffff88817e446440 (size 32):
>>>>>>>   comm "insmod", pid 4085, jiffies 4296564501 (age 126.272s)
>>>>>>>   hex dump (first 32 bytes):
>>>>>>>     75 62 69 66 73 5f 69 6e 6f 64 65 5f 73 6c 61 62  ubifs_inode_slab
>>>>>>>     00 65 44 7e 81 88 ff ff 00 00 00 00 00 00 00 00  .eD~............
>>>>>>>   backtrace:
>>>>>>>     [<000000005b30fbbd>] __kmalloc_node_track_caller+0x4e/0x150
>>>>>>>     [<000000002f70da0c>] kstrdup_const+0x4b/0x80
>>>>>>>     [<00000000c6712c61>] kobject_set_name_vargs+0x2f/0xb0
>>>>>>>     [<00000000b151218e>] kobject_init_and_add+0xb0/0x120
>>>>>>>     [<00000000e56a4cf5>] sysfs_slab_add+0x17d/0x220
>>>>>>>     [<000000009326fd57>] __kmem_cache_create+0x406/0x590
>>>>>>>     [<00000000dde33cff>] kmem_cache_create_usercopy+0x1fc/0x300
>>>>>>>     [<00000000fe90cedb>] kmem_cache_create+0x12/0x20
>>>>>>>     [<000000007a6531c8>] 0xffffffffa02d802d
>>>>>>>     [<000000000e3b13c7>] do_one_initcall+0x87/0x2a0
>>>>>>>     [<00000000995ecdcf>] do_init_module+0xdf/0x320
>>>>>>>     [<000000008821941f>] load_module+0x2f98/0x3330
>>>>>>>     [<00000000ef51efa4>] __do_sys_finit_module+0x113/0x1b0
>>>>>>>     [<000000009339fbce>] do_syscall_64+0x35/0x80
>>>>>>>     [<000000006b7f2033>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
>>>>>>
>>>>>>
>>>>>> Hi，every one,
>>>>>
>>>>> Hi.
>>>>>
>>>>>> I found the same problem and it solve this problem with the patch, is
>>>>>> there any plan to update the patch and solve it.
>>>
>>> Hmm looks like back in 2022, Hyeonggon had some feedback to the series which
>>> was not answered and then it got forgotten. Feel free to take over and send
>>> an updated version.
>>
>>
>> I was thinking of what the fix would be with my feedback,
>> and I still think passing different kobj_type (with a dummy release function) for early kmem_caches
>> will be a more appropriate approach.
>>
>> However, there is one concern: people that wrote kobject.rst might not like it :(
>>
>> in Documentation/core-api/kobject.rst:
>>> One important point cannot be overstated: every kobject must have a release() method,
>>> and the kobject must persist (in a consistent state) until that method is called. If these constraints are not met,
>>> the code is flawed. Note that the kernel will warn you if you forget to provide a release() method.
>>> Do not try to get rid of this warning by providing an "empty" release function.
>>
>> But obviously we don't want to release caches just because the kernel failed to add it to sysfs.
>>
>>>>> What kernel version do you use,
>>>>
>>>> 6.11.0-rc6
>>>>
>>>>> and when do you encounter it or how do you reproduce it?
>>>>
>>>> Hi, Hyeonggon,
>>>>
>>>> Thank you, I encounter it when doing inject fault test while modprobe
>>>> amdgpu.ko.
>>>
>>> So I wonder where's the problem that results in kobject_init_and_add()
>>> failing. If it's genuinely duplicate name as commit 80da026a8e5d suggests,
>>> 6.12-rc1 will have a warning to prevent that. Delayed destruction of
>>> SLAB_TYPESAFE_BY_RCU caches should also no longer happen with 6.12-rc1. So
>>> worth retrying with that and if it's still failing, we should look at the
>>> root cause perhaps.
>>
>> I thought it was because the memory allocation for a name string failed due to fault injection?
> 
> Well in any case 6.12-rc1 introduced a new one, fixed by:
> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/commit/?h=slab/for-6.12-rc1/fixes&id=77ced98f0f03fdc196561d1afbe652899c318073
> 
> So once that's mainline, we can see if anything remains

Using the newest 6.12.0-rc4, the issue still exists in slab:

unreferenced object 0xffffff80ce6da9c0 (size 16):
  comm "modprobe", pid 12782, jiffies 4299073226
  hex dump (first 16 bytes):
    6f 76 6c 5f 69 6e 6f 64 65 00 6d ce 80 ff ff ff  ovl_inode.m.....
  backtrace (crc 1a460899):
    [<00000000edf3be8b>] kmemleak_alloc+0x34/0x40
    [<0000000004121c8d>] __kmalloc_node_track_caller_noprof+0x304/0x3e8
    [<00000000515e9eda>] kstrdup+0x48/0x84
    [<000000005d2d0c1a>] kstrdup_const+0x34/0x40
    [<00000000d14076ce>] kvasprintf_const+0x170/0x1e0
    [<0000000060f79972>] kobject_set_name_vargs+0x5c/0x12c
    [<00000000299f544a>] kobject_init_and_add+0xd4/0x168
    [<000000008ceb40f4>] sysfs_slab_add+0x190/0x21c
    [<00000000027371b9>] do_kmem_cache_create+0x354/0x5cc
    [<00000000cc9eb2aa>] __kmem_cache_create_args+0x1b8/0x2c8
    [<000000006a3e21cc>] 0xffffffea545a409c
    [<0000000002f945b3>] do_one_initcall+0x110/0x77c
    [<0000000024f23211>] do_init_module+0x1dc/0x5c8
    [<00000000a16337d6>] load_module+0x4acc/0x4e90
    [<00000000be447e77>] init_module_from_file+0xd4/0x128
    [<0000000048065de1>] idempotent_init_module+0x2d4/0x57c

> 
>>>
>>>>>
>>>>> --
>>>>> Hyeonggon
>>
>>
> 

