Return-Path: <linux-kernel+bounces-379065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F419AD92F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 03:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43F491F2318E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 01:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3578334CDD;
	Thu, 24 Oct 2024 01:26:35 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2064214AA9
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 01:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729733194; cv=none; b=GQ0bKrz9QqLo01vCtJYv5Zl+p3PUFm8bTMV2BBP6WIi0uo5C3/OsrGLV306jUMAofhVwLPfjQcIxfmOIw39ZDj5UE+rOGZ2p4HsIs4UNo8q/3ScC7bulADt0svks/YbhmrPtKMSDpiLbeExUhDBBeTAubvVjTPxCvFn48NgGx6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729733194; c=relaxed/simple;
	bh=WJmDpqiauTxtJFMp+Bn+8YTFP7GC/LJ7aDH3bksuxlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ixCwgCy3BnvE0/TGxUZfD45mrabAhAE5M3pt8WnCdJqknU8KNyN3UnJJKLe/J6Itk575dlbCfyMBr2ZIlV7/72cg6RsyEadPu3lbhNvcWkZvwFEoB3RZRfNOTtM9Fbq01LI8qhX89kq7QUdbRA6rORhCAk2UCXckGDhWU2Yzsgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XYpCQ2C7hz4f3lVs
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 09:26:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 8ED0E1A018D
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 09:26:28 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP2 (Coremail) with SMTP id Syh0CgAHPGFBohlnBra7Ew--.27167S2;
	Thu, 24 Oct 2024 09:26:26 +0800 (CST)
Message-ID: <e919c9ba-1d93-4e68-9146-33d1e28103dc@huaweicloud.com>
Date: Thu, 24 Oct 2024 09:26:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: shrinker: avoid memleak in alloc_shrinker_info
To: Roman Gushchin <roman.gushchin@linux.dev>,
 Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
 david@fromorbit.com
Cc: Muchun Song <muchun.song@linux.dev>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>, akpm@linux-foundation.org,
 david@fromorbit.com, zhengqi.arch@bytedance.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, wangweiyang2@huawei.com
References: <fff87be9-fdc8-4c27-8335-17b0c7e16413@suse.cz>
 <1BD74B20-879A-4159-B957-1223553217C1@linux.dev>
 <0b883f9e-451f-41c2-805f-7f5bc7eebee2@suse.cz> <Zw_4fOm_4ifT1uft@google.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <Zw_4fOm_4ifT1uft@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAHPGFBohlnBra7Ew--.27167S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GFykuF43GF4ktrW5WFW3Wrg_yoWxGFWxpF
	WfGFy2kF4kJr1UJr12q3W5Jr18tw4jy3WUXrn3Jry8Arn09F15Jr17Jr48CryDGryxAr12
	qrZ8XrW2vryUA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2024/10/17 1:31, Roman Gushchin wrote:
> On Wed, Oct 16, 2024 at 07:02:23PM +0200, Vlastimil Babka wrote:
>> On 10/16/24 16:08, Muchun Song wrote:
>>>
>>>
>>>> On Oct 16, 2024, at 19:43, Vlastimil Babka <vbabka@suse.cz> wrote:
>>>> ﻿On 10/16/24 04:21, Muchun Song wrote:
>>>>>
>>>>>
>>>>>> On Oct 16, 2024, at 09:25, chenridong <chenridong@huawei.com> wrote:
>>>>>> On 2024/10/15 14:55, Anshuman Khandual wrote:
>>>>>>> On 10/14/24 16:59, Kirill A. Shutemov wrote:
>>>>>>>> On Mon, Oct 14, 2024 at 03:23:36AM +0000, Chen Ridong wrote:
>>>>>>>>> From: Chen Ridong <chenridong@huawei.com>
>>>>>>>>> A memleak was found as bellow:
>>>>>>>>> unreferenced object 0xffff8881010d2a80 (size 32):
>>>>>>>>>  comm "mkdir", pid 1559, jiffies 4294932666
>>>>>>>>>  hex dump (first 32 bytes):
>>>>>>>>>    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>>>>>>>>    40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  @...............
>>>>>>>>>  backtrace (crc 2e7ef6fa):
>>>>>>>>>    [<ffffffff81372754>] __kmalloc_node_noprof+0x394/0x470
>>>>>>>>>    [<ffffffff813024ab>] alloc_shrinker_info+0x7b/0x1a0
>>>>>>>>>    [<ffffffff813b526a>] mem_cgroup_css_online+0x11a/0x3b0
>>>>>>>>>    [<ffffffff81198dd9>] online_css+0x29/0xa0
>>>>>>>>>    [<ffffffff811a243d>] cgroup_apply_control_enable+0x20d/0x360
>>>>>>>>>    [<ffffffff811a5728>] cgroup_mkdir+0x168/0x5f0
>>>>>>>>>    [<ffffffff8148543e>] kernfs_iop_mkdir+0x5e/0x90
>>>>>>>>>    [<ffffffff813dbb24>] vfs_mkdir+0x144/0x220
>>>>>>>>>    [<ffffffff813e1c97>] do_mkdirat+0x87/0x130
>>>>>>>>>    [<ffffffff813e1de9>] __x64_sys_mkdir+0x49/0x70
>>>>>>>>>    [<ffffffff81f8c928>] do_syscall_64+0x68/0x140
>>>>>>>>>    [<ffffffff8200012f>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>>>>>>> In the alloc_shrinker_info function, when shrinker_unit_alloc return
>>>>>>>>> err, the info won't be freed. Just fix it.
>>>>>>>>> Fixes: 307bececcd12 ("mm: shrinker: add a secondary array for shrinker_info::{map, nr_deferred}")
>>>>>>>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>>>>>>>> ---
>>>>>>>>> mm/shrinker.c | 1 +
>>>>>>>>> 1 file changed, 1 insertion(+)
>>>>>>>>> diff --git a/mm/shrinker.c b/mm/shrinker.c
>>>>>>>>> index dc5d2a6fcfc4..92270413190d 100644
>>>>>>>>> --- a/mm/shrinker.c
>>>>>>>>> +++ b/mm/shrinker.c
>>>>>>>>> @@ -97,6 +97,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>>>>>>>>>   err:
>>>>>>>>>  mutex_unlock(&shrinker_mutex);
>>>>>>>>> + kvfree(info);
>>>>>>>>>  free_shrinker_info(memcg);
>>>>>>>>>  return -ENOMEM;
>>>>>>>>> }
>>>>>>>> NAK. If in the future there going to one more error case after
>>>>>>>> rcu_assign_pointer() we will end up with double free.
>>>>>>>> This should be safer:
>>>>>>>> diff --git a/mm/shrinker.c b/mm/shrinker.c
>>>>>>>> index dc5d2a6fcfc4..763fd556bc7d 100644
>>>>>>>> --- a/mm/shrinker.c
>>>>>>>> +++ b/mm/shrinker.c
>>>>>>>> @@ -87,8 +87,10 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>>>>>>>>  if (!info)
>>>>>>>>  goto err;
>>>>>>>>  info->map_nr_max = shrinker_nr_max;
>>>>>>>> - if (shrinker_unit_alloc(info, NULL, nid))
>>>>>>>> + if (shrinker_unit_alloc(info, NULL, nid)) {
>>>>>>>> + kvfree(info);
>>>>>>>>  goto err;
>>>>>>>> + }
>>>>>>>>  rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
>>>>>>>>  }
>>>>>>>>  mutex_unlock(&shrinker_mutex);
>>>>>>> Agreed, this is what I mentioned earlier as well.
>>>>>>> ------------------------------------------------------------------
>>>>>>> I guess kvfree() should be called just after shrinker_unit_alloc()
>>>>>>> fails but before calling into "goto err"
>>>>>>> ------------------------------------------------------------------
>>>>>> After discussion, it seems that v1 is acceptable.
>>>>>> Hi, Muchun, do you have any other opinions?
>>>>>
>>>>> I insist on my opinion, not mixing two different approaches
>>>>> to do release resources.
>>>>
>>>> So instead we mix the cleanup of the whole function with the cleanup of what
>>>> is effectively a per-iteration temporary variable?
>>>>
>>>> The fact there was already a confusion in this thread about whether it's
>>>> safe and relies on kvfree(NULL) to be a no-op, should be a hint.
>>>
>>> Yes. I think someone is confused about my opinion.
>>> I don’t care about whether we should apply this hit.
>>> If we think the hint is tricky, we could add another
>>> label to fix it like I suggested previously. Because
>>> we already use goto-based approaches to
>>> cleanup the resources, why not keeping
>>> consistent?
>>
>> I think we're rather pragmatic than striving to be consistent for the sake
>> of consistency. goto is not the nicest thing in the world, but we (unlike
>> other projects) use it where it makes sense to avoid if/else nesting
>> explosion. Here for the info it's not the most pragmatic option.
>>
>>> It will be easier for us to add a new
>>> "if" statement and handle the failure case in the future.
>>
>> Let's not overengineer things for hypothetical future.
>>
>>> For example, if we use his v1 proposal, we should do
>>> the cleanups again for info. But for goto-based
>>> version, we just add another label to do the
>>> cleanups and go to the new label for failure case. goto-based fix is what I insisted on. I copied my previous suggested fix here to clarify my opinion.
>>
>> Again, info is a loop-iteration-local variable, v1 fix making it truly local
>> is the way to go. If there are further cleanups added in the loop itself in
>> the future, they could hopefully keep being local to the loop as well.
>> Cleanup of info outside the loop iteration is breaking its real scope.
> 
> +1 to that.
> 
> I don't think it's such a big deal and both versions are ok, but I strongly
> prefer the original version (without introduction of a new label).
> 
> Please, feel free to use
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> with the original version.
> 
> Thanks!

I agree with Roman.
Hello, Andrew and Dave, Do you have any opinions?

The original version:
https://lore.kernel.org/linux-kernel/4184c61f-80f7-4adc-8929-c29f959cb8df@huawei.com/

Best regards,
Ridong


