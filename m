Return-Path: <linux-kernel+bounces-318401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 615DC96ED37
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16E821F23CA7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA55C155CB0;
	Fri,  6 Sep 2024 08:10:52 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0E43C463
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 08:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725610252; cv=none; b=r1SX6w5YRuQRaB+sva9IdW3yOvPthe0zhvlxbca3ITx9nLFRk2x4ny+N6YG1vQzcL72lVZqfIpvEIvCZlFzirtT7eDO89Joa0GW7EtZGrhCHjzi4to8YqV5Bxi9hVSfRvPV2W3D9JqKrjGX6r84g9Vv6Y0hv6SR9RURHpYUoDZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725610252; c=relaxed/simple;
	bh=d+Xhfe9tVMzf1ELXoOHGey4VLyjkXYAYbyHhQN+qk+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MKn9vc7o/Op9reZdc4pIjuWpLrTal/Mx9GuK0oydU2Pi4KhclbwdlIzEHC4/1eojlKLCsGUIkRHRwa+2wi16mOTEifxd6ts0cJkkHFLswoGajOKwwT+/S8hoAWNOnLY+HBdOH7J+AQif1hUp8cwE8ba35ur26EwIxYVvNP+TWJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4X0TPy4nbMzfbjV;
	Fri,  6 Sep 2024 16:08:38 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id C0E3C1800D1;
	Fri,  6 Sep 2024 16:10:46 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 6 Sep 2024 16:10:46 +0800
Message-ID: <68b86f66-cd00-bb7d-b8bb-5a94e8dd1ea2@huawei.com>
Date: Fri, 6 Sep 2024 16:10:45 +0800
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
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC: Liu Shixin <liushixin2@huawei.com>, Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton
	<akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin
	<roman.gushchin@linux.dev>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20221112114602.1268989-1-liushixin2@huawei.com>
 <20221112114602.1268989-4-liushixin2@huawei.com>
 <3780a622-03f2-4cfe-5705-0e9d0be61d57@huawei.com>
 <CAB=+i9SiiH7JN1tTrmO6FS+HqQcKnwoAs3O2PKxfPy2parM8WA@mail.gmail.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <CAB=+i9SiiH7JN1tTrmO6FS+HqQcKnwoAs3O2PKxfPy2parM8WA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/9/5 21:59, Hyeonggon Yoo wrote:
> On Thu, Sep 5, 2024 at 12:41 PM Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>>
>>
>>
>> On 2022/11/12 19:46, Liu Shixin wrote:
>>> There is a memory leak of kobj->name in sysfs_slab_add():
>>>
>>>  unreferenced object 0xffff88817e446440 (size 32):
>>>    comm "insmod", pid 4085, jiffies 4296564501 (age 126.272s)
>>>    hex dump (first 32 bytes):
>>>      75 62 69 66 73 5f 69 6e 6f 64 65 5f 73 6c 61 62  ubifs_inode_slab
>>>      00 65 44 7e 81 88 ff ff 00 00 00 00 00 00 00 00  .eD~............
>>>    backtrace:
>>>      [<000000005b30fbbd>] __kmalloc_node_track_caller+0x4e/0x150
>>>      [<000000002f70da0c>] kstrdup_const+0x4b/0x80
>>>      [<00000000c6712c61>] kobject_set_name_vargs+0x2f/0xb0
>>>      [<00000000b151218e>] kobject_init_and_add+0xb0/0x120
>>>      [<00000000e56a4cf5>] sysfs_slab_add+0x17d/0x220
>>>      [<000000009326fd57>] __kmem_cache_create+0x406/0x590
>>>      [<00000000dde33cff>] kmem_cache_create_usercopy+0x1fc/0x300
>>>      [<00000000fe90cedb>] kmem_cache_create+0x12/0x20
>>>      [<000000007a6531c8>] 0xffffffffa02d802d
>>>      [<000000000e3b13c7>] do_one_initcall+0x87/0x2a0
>>>      [<00000000995ecdcf>] do_init_module+0xdf/0x320
>>>      [<000000008821941f>] load_module+0x2f98/0x3330
>>>      [<00000000ef51efa4>] __do_sys_finit_module+0x113/0x1b0
>>>      [<000000009339fbce>] do_syscall_64+0x35/0x80
>>>      [<000000006b7f2033>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
>>
>>
>> Hi，every one,
> 
> Hi.
> 
>> I found the same problem and it solve this problem with the patch, is
>> there any plan to update the patch and solve it.
> 
> What kernel version do you use,

6.11.0-rc6

> and when do you encounter it or how do you reproduce it?

Hi, Hyeonggon,

Thank you, I encounter it when doing inject fault test while modprobe
amdgpu.ko.

> 
> --
> Hyeonggon

