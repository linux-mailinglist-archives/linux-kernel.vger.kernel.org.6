Return-Path: <linux-kernel+bounces-369080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5A29A18B5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 04:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE3DB1F26964
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 02:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C90433DF;
	Thu, 17 Oct 2024 02:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="L2rk0MPl"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627FC2E634
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 02:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729132924; cv=none; b=SF3Cai/C2hHBMSNR3eJBl9j/ELgC4ZX3rizGvjllR2sPZEcjzn5XvodLPfMeZVb2/SpXz7wneFsJGH2u3/d6JRscURex9W6whNfIk3Z4Vhf1hN1SbyeOXlukycmK8b0CJ8qW4RuoyF7iCVMiMuJtLD8MHdaOQoQa8/38anjvtVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729132924; c=relaxed/simple;
	bh=QCal/2k4kBnNllWQFU9mDiLVAbzQ/8ODe9GJLXizcgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r0unbuCrS7vBbQTz6riTeePuO2Bi2Zt9zeAJWDKkCsPjHeKKhIW44SQUsI5vEscZvUC/NH/frMw49iibLlO7bZN3QiGqfIkzmXCbBiYVqujO+EYCXf+LG7zUtfa/3yWZYnpky/vkafwX7SOqMy2j2VYLuMsSPgC0GRpIGvshguM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=L2rk0MPl; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20cf3e36a76so4735695ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 19:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729132920; x=1729737720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K1BIKRK/lVyQlEbbjj6osyYbux0WSmyq1lT75N21fQM=;
        b=L2rk0MPlS4aws+xeu8wzBf82Q6S7Vlws/iA4pal4h3BQ5Th5fi2wEE/65uRXpJ+4Mu
         7/uAHdzzuotHVCuVp9MztVywfsO6OTP5v8BgaCed/MrItG83maVIbRR3xAuVMGf1naXD
         wt7R4zWKYzQNSC3oGDZ6yBP3KdsrZcYR7WkYAFJ4uKKdbxBRihL8eb70VQ4zO72I+55Y
         /tSiN2SseliBXdgg1txbvFSHY+t4Xks8fcXFmczHZh4L1C5cXcCNSepKD1uEkAtOV174
         EhQYwW2im4CObuKWoMePtKOmYgmkTok7DuZQ8023DAW1tg7nf47lsaaJ4C/TtwQqz/YA
         HxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729132920; x=1729737720;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K1BIKRK/lVyQlEbbjj6osyYbux0WSmyq1lT75N21fQM=;
        b=YNrKEpzKJcUs7qd0DTOC37WLf92YI0RfI0+tsZczZHqP/x3WU/5ehfrwq7dPxTvvps
         w3nDCK/Xxb89fzjWSIONmRmU30K/potJb+OfyCJDuiTA4qxKF0qYl00R5sJ7DCiHW86N
         P5P+05BltVJpnDoAiXdFjmp+XJWZBGns0yqsMKe0KLq8kSlirPcwtQ7yLLKidMEC6UFL
         KY4IvMDgv8fkCw2Zr2jcbEMoP5xtoApWMThxLjh3UoGaEUgq8Jx5lzFfSNtMHkSrqXEb
         fmDVAI1OoIJdNzWmngPRw506vkPmPntmor1QhEIutm/dQowu/1OoMhwhe5gk3cBg94/q
         YVLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVR566tYscG5/+/YxsXyiURH2ilv+NSdLixzhC9kynkTa6BxpGHEp2vtB/l6LCAsAdhlbqiQB/y0pIOQ9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhfADSpwdgdTacyEC+Byc/jKuUl+10QX1NueVDCldqao0/KZmS
	4Yr+6YetG4mavQxqAEvX6yBLyzYVzlbmKdTsrmZrNX2AUzCvanGv15+nYhEwiU4=
X-Google-Smtp-Source: AGHT+IE54qey3aGUb3jqg9df+lA+OMYh63XkTCVMBDHoYb11kasUi8gE10TLShZg2L52kUsUhY9fkA==
X-Received: by 2002:a05:6a21:a24c:b0:1d5:119b:3ab with SMTP id adf61e73a8af0-1d8bcf0dd07mr28474993637.11.1729132920430;
        Wed, 16 Oct 2024 19:42:00 -0700 (PDT)
Received: from [10.84.149.95] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e3e08d6b19sm609833a91.28.2024.10.16.19.41.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 19:41:59 -0700 (PDT)
Message-ID: <94ed7edb-604e-42ff-924e-631980ca3c5e@bytedance.com>
Date: Thu, 17 Oct 2024 10:41:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: shrinker: avoid memleak in alloc_shrinker_info
Content-Language: en-US
To: Muchun Song <muchun.song@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>, chenridong <chenridong@huawei.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Ridong Chen <chenridong@huaweicloud.com>, akpm@linux-foundation.org,
 david@fromorbit.com, roman.gushchin@linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, wangweiyang2@huawei.com
References: <270ca4d5-b35f-4533-87c9-dc15e7b00f6f@suse.cz>
 <55B22931-34E1-4DAF-B392-A48EC2A9EE1A@linux.dev>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <55B22931-34E1-4DAF-B392-A48EC2A9EE1A@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/10/16 22:22, Muchun Song wrote:
> 
> 
>> On Oct 16, 2024, at 20:13, Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> ﻿On 10/14/24 11:20, Muchun Song wrote:
>>>
>>>
>>>>> On Oct 14, 2024, at 17:04, chenridong <chenridong@huawei.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2024/10/14 16:43, Muchun Song wrote:
>>>>>> On Oct 14, 2024, at 16:13, Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 10/14/24 08:53, Chen Ridong wrote:
>>>>>>> From: Chen Ridong <chenridong@huawei.com>
>>>>>>>
>>>>>>> A memleak was found as bellow:
>>>>>>>
>>>>>>> unreferenced object 0xffff8881010d2a80 (size 32):
>>>>>>> comm "mkdir", pid 1559, jiffies 4294932666
>>>>>>> hex dump (first 32 bytes):
>>>>>>>    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>>>>>>    40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  @...............
>>>>>>> backtrace (crc 2e7ef6fa):
>>>>>>>    [<ffffffff81372754>] __kmalloc_node_noprof+0x394/0x470
>>>>>>>    [<ffffffff813024ab>] alloc_shrinker_info+0x7b/0x1a0
>>>>>>>    [<ffffffff813b526a>] mem_cgroup_css_online+0x11a/0x3b0
>>>>>>>    [<ffffffff81198dd9>] online_css+0x29/0xa0
>>>>>>>    [<ffffffff811a243d>] cgroup_apply_control_enable+0x20d/0x360
>>>>>>>    [<ffffffff811a5728>] cgroup_mkdir+0x168/0x5f0
>>>>>>>    [<ffffffff8148543e>] kernfs_iop_mkdir+0x5e/0x90
>>>>>>>    [<ffffffff813dbb24>] vfs_mkdir+0x144/0x220
>>>>>>>    [<ffffffff813e1c97>] do_mkdirat+0x87/0x130
>>>>>>>    [<ffffffff813e1de9>] __x64_sys_mkdir+0x49/0x70
>>>>>>>    [<ffffffff81f8c928>] do_syscall_64+0x68/0x140
>>>>>>>    [<ffffffff8200012f>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>>>>>
>>>>>>> In the alloc_shrinker_info function, when shrinker_unit_alloc return
>>>>>>> err, the info won't be freed. Just fix it.
>>>>>>>
>>>>>>> Fixes: 307bececcd12 ("mm: shrinker: add a secondary array for shrinker_info::{map, nr_deferred}")
>>>>>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>>>>>> ---
>>>>>>> mm/shrinker.c | 1 +
>>>>>>> 1 file changed, 1 insertion(+)
>>>>>>>
>>>>>>> diff --git a/mm/shrinker.c b/mm/shrinker.c
>>>>>>> index dc5d2a6fcfc4..92270413190d 100644
>>>>>>> --- a/mm/shrinker.c
>>>>>>> +++ b/mm/shrinker.c
>>>>>>> @@ -97,6 +97,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>>>>>>>
>>>>>>> err:
>>>>>>> mutex_unlock(&shrinker_mutex);
>>>>>>> + kvfree(info);
>>>>>>> free_shrinker_info(memcg);
>>>>>>> return -ENOMEM;
>>>>>>> }
>>>>>>
>>>>>> There are two scenarios when "goto err:" gets called
>>>>>>
>>>>>> - When shrinker_info allocations fails, no kvfree() is required
>>>>>> - but after this change kvfree() would be called even
>>>>>> when the allocation had failed originally, which does
>>>>>>    not sound right
>>>>> Yes. In this case, @info is NULL and kvfree could handle NULL.
>>>>> It seems strange but the final behaviour correct.
>>>>>>
>>>>>> - shrinker_unit_alloc() fails, kvfree() is actually required
>>>>>>
>>>>>> I guess kvfree() should be called just after shrinker_unit_alloc()
>>>>>> fails but before calling into "goto err".
>>>>> We could do it like this, which avoids ambiguity (if someone ignores
>>>>> that kvfree could handle NULL). Something like:
>>>>> --- a/mm/shrinker.c
>>>>> +++ b/mm/shrinker.c
>>>>> @@ -88,13 +88,14 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>>>>>                         goto err;
>>>>>                 info->map_nr_max = shrinker_nr_max;
>>>>>                 if (shrinker_unit_alloc(info, NULL, nid))
>>>>> -                       goto err;
>>>>> +                       goto free;
>>>>>                 rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
>>>>>         }
>>>>>         mutex_unlock(&shrinker_mutex);
>>>>>         return ret;
>>>>> -
>>>>> +free:
>>>>> +       kvfree(info);
>>>>> err:
>>>>>         mutex_unlock(&shrinker_mutex);
>>>>>         free_shrinker_info(memcg);
>>>>> Thanks.
>>>>>>
>>>>>> But curious, should not both kvzalloc_node()/kvfree() be avoided
>>>>>> while inside mutex lock to avoid possible lockdep issues ?
>>>> How about:
>>>>
>>>> diff --git a/mm/shrinker.c b/mm/shrinker.c
>>>> index dc5d2a6fcfc4..7baee7f00497 100644
>>>> --- a/mm/shrinker.c
>>>> +++ b/mm/shrinker.c
>>>> @@ -87,9 +87,9 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>>>>                 if (!info)
>>>>                         goto err;
>>>>                 info->map_nr_max = shrinker_nr_max;
>>>> +               rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
>>>>                 if (shrinker_unit_alloc(info, NULL, nid))
>>>>                         goto err;
>>>> -               rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
>>>>         }
>>>>         mutex_unlock(&shrinker_mutex);
>>>
>>> No. We should make sure the @info is fully initialized before others
>>> could see it. That's why rcu_assign_pointer is used here.
>>
>> If the info is immediately visible, is the failure cleanup
>> free_shrinker_info() safe? It uses kvfree(info) and not kvfree_rcu(), and
>> shrinker_unit_free() is also doing kfree().
> 
> Qi told me that the @info will not visible immediately yesterday.
> So non-rcu-based kvfree is safe. Even if this fix could

Yes, alloc_shrinker_info() is only called by mem_cgroup_css_online(). At
this time, the memcg is not online yet, so it is not visible to 
shrink_slab(). And free_shrinker_info() is also called by 
mem_cgroup_css_free(),
the memcg has already been offline. The shrinker_unit_free() is
also called by expand_one_shrinker_info(), but the shrinker_info 'new'
is also not visible at that time. So non-rcu-based kvfree is safe.

> work properly, it’s a bit strange for me to use
> rcu_assign_pointer to assign the @info without full initialization to it.

Agree.

> 
> Muchun,
> Thanks.
> 
>>
>>>>
>>>> I think this is concise.
>>>>
>>>> Best regards,
>>>> Ridong
>>>
>>>
>>

