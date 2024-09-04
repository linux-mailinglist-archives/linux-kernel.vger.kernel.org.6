Return-Path: <linux-kernel+bounces-314481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C45F96B3DF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1021285741
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959CC17C9AD;
	Wed,  4 Sep 2024 08:04:09 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E19C17A59D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 08:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725437046; cv=none; b=hvlGbXSPMknfpGBM18fQvldNiW1z33Q/BoXiJ9Je4f4mher2S1HxnECpqRp5Kg2hs0yj0TpKypooaDleXoR+3ZomYgF4WZ+bYKIX2BCeygDNW7NJg6fyB/Y7Ou4Lv9Rm4h/sAhaU4DH+YLHN2d1FKWRV8AfkFLs6kuflqXltEQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725437046; c=relaxed/simple;
	bh=p+65Xe9QnWrP8yhV9woMpYOTXpHyTE0qcLFO27WJpEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=B/QssvgTDijq2fLCeepYIrPWcH4L72Pice0+QEnxoyX/0jHxkdv9v/2ivIedyclNVGwpa0Zbm2VQc2snS5CqezdFT23ZfrYcosGrDnyLe6c+SI+GUEIh4bNgSNvbnGWjeHnqHP3rxrtn+JnL53wlBgUsMdgFXp53X0UBSWkAXjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WzFP15k1sz2Dbgn;
	Wed,  4 Sep 2024 16:03:33 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id E6AEA1A0188;
	Wed,  4 Sep 2024 16:03:53 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Sep 2024 16:03:53 +0800
Message-ID: <3e158999-c93a-a4e3-85a9-2d6bfc1ccee7@huawei.com>
Date: Wed, 4 Sep 2024 16:03:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] static_call: Handle module init failure correctly in
 static_call_del_module()
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, Josh Poimboeuf <jpoimboe@kernel.org>
References: <87cylj7v6x.ffs@tglx>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <87cylj7v6x.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/9/4 15:08, Thomas Gleixner wrote:
> On Wed, Sep 04 2024 at 11:32, Jinjie Ruan wrote:
>> On 2024/9/4 6:58, Thomas Gleixner wrote:
>>> +		/*
>>> +		 * If the key was not updated due to a memory allocation
>>> +		 * failure in __static_call_init() then treating key::sites
>>> +		 * as key::mods in the code below would cause random memory
>>> +		 * access and #GP. In that case all subsequent sites have
>>> +		 * not been touched either, so stop iterating.
>>> +		 */
>>> +		if (static_call_key_sites(key))
>>> +			break;
>>> +
>>
>> Hi, Thomas,
>>
>> This patch seems not solve the issue, with this patch, the below problem
>> also occurs when inject fault when modprobe amdgpu:
> 
> That's a different problem.
> 
>  Oops: general protection fault, probably for
>  non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN NOPTI
> 
> It's dereferencing a NULL pointer at 0x1. That's odd because bit 0 is
> set, which looks like a sites pointer. So static_call_key_sites() should
> return true, but obviously does not. So how does that happen?
> 
> It can't be a built-in key, so it's a module local one with key::sites
> == 0x1. So static_call_key_sites() sees bit 0 set, and then returns
> key::sites & ~0x01, which is obviously NULL. So the condition is false
> and the code below uses key::mods == 0x1....
> 
> So the check must be:
> 
> 	if (!static_call_key_has_mods(key))
>         	break;

Hi, Thomas,

with this patch, the issue not occurs again，

but there are some memory leak here same to the following problem:

Link:
https://lore.kernel.org/all/20221112114602.1268989-4-liushixin2@huawei.com/

unreferenced object 0xff11000104078480 (size 32):
  comm "modprobe", pid 16978, jiffies 4295928553
  hex dump (first 32 bytes):
    61 6d 64 67 70 75 5f 73 79 6e 63 5f 65 6e 74 72  amdgpu_sync_entr
    79 00 07 04 01 00 11 ff 00 00 00 00 00 00 00 00  y...............
  backtrace (crc 86f0f2f0):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<00000000c53a6d7f>] 0xffffffffc01503a2
    [<00000000c68a3256>] 0xffffffffc0058026
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff1100000432b600 (size 32):
  comm "modprobe", pid 16994, jiffies 4295929985
  hex dump (first 32 bytes):
    61 6d 64 67 70 75 5f 73 79 6e 63 5f 65 6e 74 72  amdgpu_sync_entr
    79 00 32 04 00 00 11 ff 00 00 00 00 00 00 00 00  y.2.............
  backtrace (crc 32209446):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<00000000c53a6d7f>] 0xffffffffc01503a2
    [<00000000c68a3256>] 0xffffffffc0058026
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff11000115b24ac0 (size 32):
  comm "modprobe", pid 17010, jiffies 4295931422
  hex dump (first 32 bytes):
    61 6d 64 67 70 75 5f 73 79 6e 63 5f 65 6e 74 72  amdgpu_sync_entr
    79 00 b2 15 01 00 11 ff 02 00 00 00 01 00 00 00  y...............
  backtrace (crc b9fe288c):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<00000000c53a6d7f>] 0xffffffffc01503a2
    [<00000000c68a3256>] 0xffffffffc0058026
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff1100010196bc40 (size 32):
  comm "modprobe", pid 17032, jiffies 4295933559
  hex dump (first 32 bytes):
    61 6d 64 67 70 75 5f 73 79 6e 63 5f 65 6e 74 72  amdgpu_sync_entr
    79 00 96 01 01 00 11 ff 00 00 00 00 00 00 00 00  y...............
  backtrace (crc e311731b):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<00000000c53a6d7f>] 0xffffffffc01503a2
    [<00000000c68a3256>] 0xffffffffc0058026
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff11000009b4ee40 (size 32):
  comm "modprobe", pid 17038, jiffies 4295934300
  hex dump (first 32 bytes):
    61 6d 64 67 70 75 5f 73 79 6e 63 5f 65 6e 74 72  amdgpu_sync_entr
    79 00 b4 09 00 00 11 ff 00 00 00 00 00 00 00 00  y...............
  backtrace (crc ebd506c):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<00000000c53a6d7f>] 0xffffffffc01503a2
    [<00000000c68a3256>] 0xffffffffc0058026
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff1100000a3fe300 (size 32):
  comm "modprobe", pid 17044, jiffies 4295935011
  hex dump (first 32 bytes):
    61 6d 64 67 70 75 5f 73 79 6e 63 5f 65 6e 74 72  amdgpu_sync_entr
    79 00 3f 0a 00 00 11 ff 00 00 00 fc ff df 41 57  y.?...........AW
  backtrace (crc b6459b1e):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<00000000c53a6d7f>] 0xffffffffc01503a2
    [<00000000c68a3256>] 0xffffffffc0058026
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff11000007ef52c0 (size 32):
  comm "modprobe", pid 17050, jiffies 4295935726
  hex dump (first 32 bytes):
    61 6d 64 67 70 75 5f 73 79 6e 63 5f 65 6e 74 72  amdgpu_sync_entr
    79 00 ef 07 00 00 11 ff 00 00 00 00 00 00 00 00  y...............
  backtrace (crc 9c68acac):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<00000000c53a6d7f>] 0xffffffffc01503a2
    [<00000000c68a3256>] 0xffffffffc0058026
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff1100000798b980 (size 32):
  comm "modprobe", pid 17066, jiffies 4295937149
  hex dump (first 32 bytes):
    61 6d 64 67 70 75 5f 73 79 6e 63 5f 65 6e 74 72  amdgpu_sync_entr
    79 00 98 07 00 00 11 ff 00 00 00 00 00 00 00 00  y...............
  backtrace (crc 13cab529):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<00000000c53a6d7f>] 0xffffffffc01503a2
    [<00000000c68a3256>] 0xffffffffc0058026
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff11000006d79100 (size 32):
  comm "modprobe", pid 17072, jiffies 4295937871
  hex dump (first 32 bytes):
    61 6d 64 67 70 75 5f 73 79 6e 63 5f 65 6e 74 72  amdgpu_sync_entr
    79 00 d7 06 00 00 11 ff 34 0a 0e 00 00 00 00 00  y.......4.......
  backtrace (crc 468c4c12):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<00000000c53a6d7f>] 0xffffffffc01503a2
    [<00000000c68a3256>] 0xffffffffc0058026
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff1100000eb6d300 (size 32):
  comm "modprobe", pid 17088, jiffies 4295939305
  hex dump (first 32 bytes):
    61 6d 64 67 70 75 5f 73 79 6e 63 5f 65 6e 74 72  amdgpu_sync_entr
    79 00 b6 0e 00 00 11 ff 44 24 08 89 0c 24 e8 9d  y.......D$...$..
  backtrace (crc 39abd416):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<00000000c53a6d7f>] 0xffffffffc01503a2
    [<00000000c68a3256>] 0xffffffffc0058026
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff11000001029680 (size 32):
  comm "modprobe", pid 17114, jiffies 4295941403
  hex dump (first 32 bytes):
    61 6d 64 67 70 75 5f 73 79 6e 63 5f 65 6e 74 72  amdgpu_sync_entr
    79 00 02 01 00 00 11 ff 00 00 00 00 00 00 00 00  y...............
  backtrace (crc 84d963e1):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<00000000c53a6d7f>] 0xffffffffc01503a2
    [<00000000c68a3256>] 0xffffffffc0058026
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff11000101919f80 (size 32):
  comm "modprobe", pid 17130, jiffies 4295942829
  hex dump (first 32 bytes):
    61 6d 64 67 70 75 5f 73 79 6e 63 5f 65 6e 74 72  amdgpu_sync_entr
    79 00 91 01 01 00 11 ff 00 00 00 00 00 00 00 00  y...............
  backtrace (crc 86dcd9db):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<00000000c53a6d7f>] 0xffffffffc01503a2
    [<00000000c68a3256>] 0xffffffffc0058026
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff11000108634800 (size 32):
  comm "modprobe", pid 17136, jiffies 4295943552
  hex dump (first 32 bytes):
    61 6d 64 67 70 75 5f 73 79 6e 63 5f 65 6e 74 72  amdgpu_sync_entr
    79 00 63 08 01 00 11 ff 00 00 00 00 00 00 00 00  y.c.............
  backtrace (crc 893b4b39):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<00000000c53a6d7f>] 0xffffffffc01503a2
    [<00000000c68a3256>] 0xffffffffc0058026
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff110000051d5640 (size 32):
  comm "modprobe", pid 17142, jiffies 4295944268
  hex dump (first 32 bytes):
    61 6d 64 67 70 75 5f 73 79 6e 63 5f 65 6e 74 72  amdgpu_sync_entr
    79 00 1d 05 00 00 11 ff 00 00 00 00 00 fc ff df  y...............
  backtrace (crc 4dd0396e):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<00000000c53a6d7f>] 0xffffffffc01503a2
    [<00000000c68a3256>] 0xffffffffc0058026
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff110001013def40 (size 32):
  comm "modprobe", pid 17148, jiffies 4295944996
  hex dump (first 32 bytes):
    61 6d 64 67 70 75 5f 73 79 6e 63 5f 65 6e 74 72  amdgpu_sync_entr
    79 00 3d 01 01 00 11 ff 40 2b 0d 00 00 00 d4 ff  y.=.....@+......
  backtrace (crc 72d18c0f):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<00000000c53a6d7f>] 0xffffffffc01503a2
    [<00000000c68a3256>] 0xffffffffc0058026
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff11000102f95280 (size 32):
  comm "modprobe", pid 17154, jiffies 4295945705
  hex dump (first 32 bytes):
    61 6d 64 67 70 75 5f 73 79 6e 63 5f 65 6e 74 72  amdgpu_sync_entr
    79 00 f9 02 01 00 11 ff 00 00 00 00 00 00 00 00  y...............
  backtrace (crc 8492240a):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<00000000c53a6d7f>] 0xffffffffc01503a2
    [<00000000c68a3256>] 0xffffffffc0058026
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff1100000a957fc0 (size 32):
  comm "modprobe", pid 17170, jiffies 4295947128
  hex dump (first 32 bytes):
    61 6d 64 67 70 75 5f 73 79 6e 63 5f 65 6e 74 72  amdgpu_sync_entr
    79 00 95 0a 00 00 11 ff 65 63 6b 00 00 00 00 00  y.......eck.....
  backtrace (crc a37aa232):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<00000000c53a6d7f>] 0xffffffffc01503a2
    [<00000000c68a3256>] 0xffffffffc0058026
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff1100000ec1d300 (size 32):
  comm "modprobe", pid 17186, jiffies 4295948570
  hex dump (first 32 bytes):
    61 6d 64 67 70 75 5f 73 79 6e 63 5f 65 6e 74 72  amdgpu_sync_entr
    79 00 c1 0e 00 00 11 ff 69 6e 69 73 68 00 00 00  y.......inish...
  backtrace (crc 66341c55):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<00000000c53a6d7f>] 0xffffffffc01503a2
    [<00000000c68a3256>] 0xffffffffc0058026
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff11000108066ac0 (size 32):
  comm "modprobe", pid 17212, jiffies 4295950745
  hex dump (first 32 bytes):
    61 6d 64 67 70 75 5f 73 79 6e 63 5f 65 6e 74 72  amdgpu_sync_entr
    79 00 06 08 01 00 11 ff 00 00 00 00 00 00 00 00  y...............
  backtrace (crc 8145aa7d):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<00000000c53a6d7f>] 0xffffffffc01503a2
    [<00000000c68a3256>] 0xffffffffc0058026
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff110000125e2980 (size 32):
  comm "modprobe", pid 17218, jiffies 4295951462
  hex dump (first 32 bytes):
    61 6d 64 67 70 75 5f 73 79 6e 63 5f 65 6e 74 72  amdgpu_sync_entr
    79 00 5e 12 00 00 11 ff 00 00 00 00 00 00 00 00  y.^.............
  backtrace (crc 80eaf345):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<00000000c53a6d7f>] 0xffffffffc01503a2
    [<00000000c68a3256>] 0xffffffffc0058026
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff11000002460380 (size 32):
  comm "modprobe", pid 17264, jiffies 4295954895
  hex dump (first 32 bytes):
    61 6d 64 67 70 75 5f 73 79 6e 63 5f 65 6e 74 72  amdgpu_sync_entr
    79 00 00 00 00 00 00 00 00 ed 1e 00 00 00 d4 ff  y...............
  backtrace (crc aaffd3fe):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<00000000c53a6d7f>] 0xffffffffc01503a2
    [<00000000c68a3256>] 0xffffffffc0058026
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff11000009b4e180 (size 32):
  comm "modprobe", pid 17290, jiffies 4295957017
  hex dump (first 32 bytes):
    61 6d 64 67 70 75 5f 73 79 6e 63 5f 65 6e 74 72  amdgpu_sync_entr
    79 00 b4 09 00 00 11 ff 00 00 00 00 00 00 00 00  y...............
  backtrace (crc ebd506c):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<00000000c53a6d7f>] 0xffffffffc01503a2
    [<00000000c68a3256>] 0xffffffffc0058026
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff110000040cf140 (size 32):
  comm "modprobe", pid 17306, jiffies 4295958400
  hex dump (first 32 bytes):
    61 6d 64 67 70 75 5f 73 79 6e 63 5f 65 6e 74 72  amdgpu_sync_entr
    79 00 0c 04 00 00 11 ff 00 00 00 00 00 00 00 00  y...............
  backtrace (crc 526d8572):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<00000000c53a6d7f>] 0xffffffffc01503a2
    [<00000000c68a3256>] 0xffffffffc0058026
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff11000006d77f80 (size 32):
  comm "modprobe", pid 17322, jiffies 4295959804
  hex dump (first 32 bytes):
    61 6d 64 67 70 75 5f 73 79 6e 63 5f 65 6e 74 72  amdgpu_sync_entr
    79 00 d7 06 00 00 11 ff f4 11 0e 00 00 00 00 00  y...............
  backtrace (crc 59f3c311):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<00000000c53a6d7f>] 0xffffffffc01503a2
    [<00000000c68a3256>] 0xffffffffc0058026
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff110001013d3180 (size 32):
  comm "modprobe", pid 17398, jiffies 4295965375
  hex dump (first 32 bytes):
    61 6d 64 67 70 75 5f 73 79 6e 63 5f 65 6e 74 72  amdgpu_sync_entr
    79 00 3d 01 01 00 11 ff 69 6e 69 73 68 00 00 00  y.=.....inish...
  backtrace (crc 99084885):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<00000000c53a6d7f>] 0xffffffffc01503a2
    [<00000000c68a3256>] 0xffffffffc0058026
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff1100000f1826c0 (size 32):
  comm "modprobe", pid 17414, jiffies 4295966816
  hex dump (first 32 bytes):
    61 6d 64 67 70 75 5f 73 79 6e 63 5f 65 6e 74 72  amdgpu_sync_entr
    79 00 18 0f 00 00 11 ff 00 00 00 00 00 00 00 00  y...............
  backtrace (crc caba89a6):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<00000000c53a6d7f>] 0xffffffffc01503a2
    [<00000000c68a3256>] 0xffffffffc0058026
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff11000100d2a240 (size 32):
  comm "modprobe", pid 17450, jiffies 4295969601
  hex dump (first 32 bytes):
    61 6d 64 67 70 75 5f 73 79 6e 63 5f 65 6e 74 72  amdgpu_sync_entr
    79 00 d2 00 01 00 11 ff 00 00 00 00 00 00 00 00  y...............
  backtrace (crc 6692d274):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<00000000c53a6d7f>] 0xffffffffc01503a2
    [<00000000c68a3256>] 0xffffffffc0058026
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff1100000524ea40 (size 32):
  comm "modprobe", pid 17466, jiffies 4295971059
  hex dump (first 32 bytes):
    61 6d 64 67 70 75 5f 73 79 6e 63 5f 65 6e 74 72  amdgpu_sync_entr
    79 00 24 05 00 00 11 ff 2b 00 00 00 00 00 00 00  y.$.....+.......
  backtrace (crc d5da4419):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<00000000c53a6d7f>] 0xffffffffc01503a2
    [<00000000c68a3256>] 0xffffffffc0058026
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff11000102f957c0 (size 32):
  comm "modprobe", pid 17482, jiffies 4295972468
  hex dump (first 32 bytes):
    61 6d 64 67 70 75 5f 73 79 6e 63 5f 65 6e 74 72  amdgpu_sync_entr
    79 00 f9 02 01 00 11 ff 00 00 00 00 00 00 00 00  y...............
  backtrace (crc 8492240a):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<00000000c53a6d7f>] 0xffffffffc01503a2
    [<00000000c68a3256>] 0xffffffffc0058026
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff110001072e3d00 (size 32):
  comm "modprobe", pid 17526, jiffies 4295976765
  hex dump (first 32 bytes):
    61 6d 64 67 70 75 5f 73 79 6e 63 5f 65 6e 74 72  amdgpu_sync_entr
    79 00 2e 07 01 00 11 ff 00 00 00 00 00 00 00 00  y...............
  backtrace (crc 580819a6):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<00000000c53a6d7f>] 0xffffffffc01503a2
    [<00000000c68a3256>] 0xffffffffc0058026
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff1100000a3fdb60 (size 16):
  comm "modprobe", pid 17578, jiffies 4295981003
  hex dump (first 16 bytes):
    61 6d 64 67 70 75 5f 66 65 6e 63 65 00 00 11 ff  amdgpu_fence....
  backtrace (crc e15a7d50):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<000000009827d27d>] 0xffffffffc00c8052
    [<00000000d74769dd>] 0xffffffffc0058038
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff11000005e51280 (size 16):
  comm "modprobe", pid 17594, jiffies 4295982450
  hex dump (first 16 bytes):
    61 6d 64 67 70 75 5f 66 65 6e 63 65 00 00 11 ff  amdgpu_fence....
  backtrace (crc e15a7d50):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<000000009827d27d>] 0xffffffffc00c8052
    [<00000000d74769dd>] 0xffffffffc0058038
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff110000071a1b60 (size 16):
  comm "modprobe", pid 17609, jiffies 4295983945
  hex dump (first 16 bytes):
    61 6d 64 67 70 75 5f 66 65 6e 63 65 00 00 11 ff  amdgpu_fence....
  backtrace (crc e15a7d50):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<000000009827d27d>] 0xffffffffc00c8052
    [<00000000d74769dd>] 0xffffffffc0058038
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff1100010f4a2ae0 (size 16):
  comm "modprobe", pid 17646, jiffies 4295986890
  hex dump (first 16 bytes):
    61 6d 64 67 70 75 5f 66 65 6e 63 65 00 00 11 ff  amdgpu_fence....
  backtrace (crc e15a7d50):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<000000009827d27d>] 0xffffffffc00c8052
    [<00000000d74769dd>] 0xffffffffc0058038
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff1100000f20bd80 (size 16):
  comm "modprobe", pid 17662, jiffies 4295988248
  hex dump (first 16 bytes):
    61 6d 64 67 70 75 5f 66 65 6e 63 65 00 00 11 ff  amdgpu_fence....
  backtrace (crc e15a7d50):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<000000009827d27d>] 0xffffffffc00c8052
    [<00000000d74769dd>] 0xffffffffc0058038
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff11000100d26a00 (size 16):
  comm "modprobe", pid 17718, jiffies 4295992419
  hex dump (first 16 bytes):
    61 6d 64 67 70 75 5f 66 65 6e 63 65 00 00 11 ff  amdgpu_fence....
  backtrace (crc e15a7d50):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<000000009827d27d>] 0xffffffffc00c8052
    [<00000000d74769dd>] 0xffffffffc0058038
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff1100010152d240 (size 16):
  comm "modprobe", pid 17734, jiffies 4295993810
  hex dump (first 16 bytes):
    61 6d 64 67 70 75 5f 66 65 6e 63 65 00 00 00 00  amdgpu_fence....
  backtrace (crc 9f81b1cd):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<000000009827d27d>] 0xffffffffc00c8052
    [<00000000d74769dd>] 0xffffffffc0058038
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff110001013ce0a0 (size 16):
  comm "modprobe", pid 17750, jiffies 4295995280
  hex dump (first 16 bytes):
    61 6d 64 67 70 75 5f 66 65 6e 63 65 00 00 11 ff  amdgpu_fence....
  backtrace (crc e15a7d50):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<000000009827d27d>] 0xffffffffc00c8052
    [<00000000d74769dd>] 0xffffffffc0058038
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff11000005e51dc0 (size 16):
  comm "modprobe", pid 17756, jiffies 4295996002
  hex dump (first 16 bytes):
    61 6d 64 67 70 75 5f 66 65 6e 63 65 00 00 11 ff  amdgpu_fence....
  backtrace (crc e15a7d50):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<000000009827d27d>] 0xffffffffc00c8052
    [<00000000d74769dd>] 0xffffffffc0058038
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff11000008b1bf80 (size 16):
  comm "modprobe", pid 17782, jiffies 4295998115
  hex dump (first 16 bytes):
    61 6d 64 67 70 75 5f 66 65 6e 63 65 00 00 11 ff  amdgpu_fence....
  backtrace (crc e15a7d50):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<000000009827d27d>] 0xffffffffc00c8052
    [<00000000d74769dd>] 0xffffffffc0058038
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff11000114116820 (size 16):
  comm "modprobe", pid 17798, jiffies 4295999501
  hex dump (first 16 bytes):
    61 6d 64 67 70 75 5f 66 65 6e 63 65 00 00 11 ff  amdgpu_fence....
  backtrace (crc e15a7d50):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<000000009827d27d>] 0xffffffffc00c8052
    [<00000000d74769dd>] 0xffffffffc0058038
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff1100011101d5e0 (size 16):
  comm "modprobe", pid 17825, jiffies 4296001629
  hex dump (first 16 bytes):
    61 6d 64 67 70 75 5f 66 65 6e 63 65 00 00 11 ff  amdgpu_fence....
  backtrace (crc e15a7d50):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<000000009827d27d>] 0xffffffffc00c8052
    [<00000000d74769dd>] 0xffffffffc0058038
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff11000009718320 (size 16):
  comm "modprobe", pid 17831, jiffies 4296002346
  hex dump (first 16 bytes):
    61 6d 64 67 70 75 5f 66 65 6e 63 65 00 00 11 ff  amdgpu_fence....
  backtrace (crc e15a7d50):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<000000009827d27d>] 0xffffffffc00c8052
    [<00000000d74769dd>] 0xffffffffc0058038
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff1100011515d660 (size 16):
  comm "modprobe", pid 17847, jiffies 4296003774
  hex dump (first 16 bytes):
    61 6d 64 67 70 75 5f 66 65 6e 63 65 00 00 11 ff  amdgpu_fence....
  backtrace (crc e15a7d50):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<000000009827d27d>] 0xffffffffc00c8052
    [<00000000d74769dd>] 0xffffffffc0058038
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff11000114a85080 (size 16):
  comm "modprobe", pid 17854, jiffies 4296004484
  hex dump (first 16 bytes):
    61 6d 64 67 70 75 5f 66 65 6e 63 65 00 00 11 ff  amdgpu_fence....
  backtrace (crc e15a7d50):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<000000009827d27d>] 0xffffffffc00c8052
    [<00000000d74769dd>] 0xffffffffc0058038
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff1100000eb139a0 (size 16):
  comm "modprobe", pid 17860, jiffies 4296005214
  hex dump (first 16 bytes):
    61 6d 64 67 70 75 5f 66 65 6e 63 65 00 00 11 ff  amdgpu_fence....
  backtrace (crc e15a7d50):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<000000009827d27d>] 0xffffffffc00c8052
    [<00000000d74769dd>] 0xffffffffc0058038
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff11000009718b60 (size 16):
  comm "modprobe", pid 17876, jiffies 4296006637
  hex dump (first 16 bytes):
    61 6d 64 67 70 75 5f 66 65 6e 63 65 00 00 11 ff  amdgpu_fence....
  backtrace (crc e15a7d50):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<000000009827d27d>] 0xffffffffc00c8052
    [<00000000d74769dd>] 0xffffffffc0058038
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff11000005b81fc0 (size 16):
  comm "modprobe", pid 17892, jiffies 4296008053
  hex dump (first 16 bytes):
    61 6d 64 67 70 75 5f 66 65 6e 63 65 00 00 11 ff  amdgpu_fence....
  backtrace (crc e15a7d50):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<000000009827d27d>] 0xffffffffc00c8052
    [<00000000d74769dd>] 0xffffffffc0058038
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff110000071a1b40 (size 16):
  comm "modprobe", pid 17898, jiffies 4296008778
  hex dump (first 16 bytes):
    61 6d 64 67 70 75 5f 66 65 6e 63 65 00 00 11 ff  amdgpu_fence....
  backtrace (crc e15a7d50):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<000000009827d27d>] 0xffffffffc00c8052
    [<00000000d74769dd>] 0xffffffffc0058038
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff1100000f20bb00 (size 16):
  comm "modprobe", pid 17904, jiffies 4296009509
  hex dump (first 16 bytes):
    61 6d 64 67 70 75 5f 66 65 6e 63 65 00 00 11 ff  amdgpu_fence....
  backtrace (crc e15a7d50):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<000000009827d27d>] 0xffffffffc00c8052
    [<00000000d74769dd>] 0xffffffffc0058038
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff1100000df76200 (size 16):
  comm "modprobe", pid 17930, jiffies 4296011592
  hex dump (first 16 bytes):
    61 6d 64 67 70 75 5f 66 65 6e 63 65 00 00 11 ff  amdgpu_fence....
  backtrace (crc e15a7d50):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<000000009827d27d>] 0xffffffffc00c8052
    [<00000000d74769dd>] 0xffffffffc0058038
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff110000064b1ba0 (size 16):
  comm "modprobe", pid 17965, jiffies 4296014396
  hex dump (first 16 bytes):
    61 6d 64 67 70 75 5f 66 65 6e 63 65 00 00 11 ff  amdgpu_fence....
  backtrace (crc e15a7d50):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<000000009827d27d>] 0xffffffffc00c8052
    [<00000000d74769dd>] 0xffffffffc0058038
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff110001011cbe80 (size 16):
  comm "modprobe", pid 17971, jiffies 4296015146
  hex dump (first 16 bytes):
    61 6d 64 67 70 75 5f 66 65 6e 63 65 00 00 11 ff  amdgpu_fence....
  backtrace (crc e15a7d50):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<000000009827d27d>] 0xffffffffc00c8052
    [<00000000d74769dd>] 0xffffffffc0058038
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff1100000f073bc0 (size 16):
  comm "modprobe", pid 17987, jiffies 4296016566
  hex dump (first 16 bytes):
    61 6d 64 67 70 75 5f 66 65 6e 63 65 00 00 11 ff  amdgpu_fence....
  backtrace (crc e15a7d50):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<000000009827d27d>] 0xffffffffc00c8052
    [<00000000d74769dd>] 0xffffffffc0058038
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff11000107214fe0 (size 16):
  comm "modprobe", pid 18003, jiffies 4296017979
  hex dump (first 16 bytes):
    61 6d 64 67 70 75 5f 66 65 6e 63 65 00 00 11 ff  amdgpu_fence....
  backtrace (crc e15a7d50):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<000000009827d27d>] 0xffffffffc00c8052
    [<00000000d74769dd>] 0xffffffffc0058038
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff1100000df769c0 (size 16):
  comm "modprobe", pid 18019, jiffies 4296019396
  hex dump (first 16 bytes):
    61 6d 64 67 70 75 5f 66 65 6e 63 65 00 00 11 ff  amdgpu_fence....
  backtrace (crc e15a7d50):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<000000009827d27d>] 0xffffffffc00c8052
    [<00000000d74769dd>] 0xffffffffc0058038
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff1100010f4a28a0 (size 16):
  comm "modprobe", pid 18035, jiffies 4296020834
  hex dump (first 16 bytes):
    61 6d 64 67 70 75 5f 66 65 6e 63 65 00 00 11 ff  amdgpu_fence....
  backtrace (crc e15a7d50):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<000000009827d27d>] 0xffffffffc00c8052
    [<00000000d74769dd>] 0xffffffffc0058038
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff1100000383b980 (size 16):
  comm "modprobe", pid 18041, jiffies 4296021552
  hex dump (first 16 bytes):
    61 6d 64 67 70 75 5f 66 65 6e 63 65 00 00 11 ff  amdgpu_fence....
  backtrace (crc e15a7d50):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<000000009827d27d>] 0xffffffffc00c8052
    [<00000000d74769dd>] 0xffffffffc0058038
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff110000023b4e60 (size 16):
  comm "modprobe", pid 18047, jiffies 4296022306
  hex dump (first 16 bytes):
    61 6d 64 67 70 75 5f 66 65 6e 63 65 00 00 11 ff  amdgpu_fence....
  backtrace (crc e15a7d50):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<000000009827d27d>] 0xffffffffc00c8052
    [<00000000d74769dd>] 0xffffffffc0058038
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff11000008b1b940 (size 16):
  comm "modprobe", pid 18053, jiffies 4296023061
  hex dump (first 16 bytes):
    61 6d 64 67 70 75 5f 66 65 6e 63 65 00 00 11 ff  amdgpu_fence....
  backtrace (crc e15a7d50):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<000000009827d27d>] 0xffffffffc00c8052
    [<00000000d74769dd>] 0xffffffffc0058038
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff1100010b8d64c0 (size 16):
  comm "modprobe", pid 18059, jiffies 4296023783
  hex dump (first 16 bytes):
    61 6d 64 67 70 75 5f 66 65 6e 63 65 00 00 11 ff  amdgpu_fence....
  backtrace (crc e15a7d50):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<000000009827d27d>] 0xffffffffc00c8052
    [<00000000d74769dd>] 0xffffffffc0058038
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff110001151a1ac0 (size 16):
  comm "modprobe", pid 18075, jiffies 4296025098
  hex dump (first 16 bytes):
    61 6d 64 67 70 75 5f 66 65 6e 63 65 00 00 11 ff  amdgpu_fence....
  backtrace (crc e15a7d50):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<000000009827d27d>] 0xffffffffc00c8052
    [<00000000d74769dd>] 0xffffffffc0058038
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150
unreferenced object 0xff110000050fcea0 (size 16):
  comm "modprobe", pid 18101, jiffies 4296027230
  hex dump (first 16 bytes):
    61 6d 64 67 70 75 5f 66 65 6e 63 65 00 00 11 ff  amdgpu_fence....
  backtrace (crc e15a7d50):
    [<000000001b48c137>] __kmalloc_node_track_caller_noprof+0x33c/0x410
    [<000000003ab002c7>] kstrdup+0x3f/0x80
    [<00000000479d3195>] kstrdup_const+0x39/0x60
    [<000000005f96320e>] kvasprintf_const+0xf9/0x190
    [<00000000725db2e2>] kobject_set_name_vargs+0x5a/0x150
    [<00000000745aee9e>] kobject_init_and_add+0xcd/0x170
    [<00000000c0d3244b>] sysfs_slab_add+0x172/0x210
    [<00000000a6c0a88d>] __kmem_cache_create+0x215/0x5c0
    [<0000000081d00250>] kmem_cache_create_usercopy+0x213/0x340
    [<000000006d9fd37f>] kmem_cache_create+0x11/0x20
    [<000000009827d27d>] 0xffffffffc00c8052
    [<00000000d74769dd>] 0xffffffffc0058038
    [<00000000b58b0e32>] do_one_initcall+0xdc/0x550
    [<0000000040a69501>] do_init_module+0x241/0x630
    [<00000000bca76796>] load_module+0x52be/0x63e0
    [<000000006d613fc0>] init_module_from_file+0xe6/0x150


> 
> I missed the module local case completely in my analysis. Can you please
> modify the condition and retest?
> 
> Thanks,
> 
>         tglx
> 
> 
> 
> 
> 

