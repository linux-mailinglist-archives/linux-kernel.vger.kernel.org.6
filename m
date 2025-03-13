Return-Path: <linux-kernel+bounces-559199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 000E7A5F0D3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 350B117BD7A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345122661A6;
	Thu, 13 Mar 2025 10:26:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CF6261583
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741861576; cv=none; b=VfqHHzSUhmRxeMEBOugTDoEU1ZD1JTHUmFg7Pc1dL+cStfBsWApAa7cs1JMnCCQC8jH3VVDjlRO0K2jUELWTwG2ykXA8x1uiyVI13fYFSkXC1AewmLrJX5XtD3DZUYBfMZeYd0lc4p7U28N8ufjYrnvpOZ540mqIK0DogiZz7+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741861576; c=relaxed/simple;
	bh=z7CqThBczvjvxtOlWP95Tr+Y10KiMrM4BMTNhqAwDU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HXO8waBhfYZAwCogGnBEmyyXnXgwC3gsXgDagTEZFb38hK2vwuKUU1vy+vHXsX89bmr1+fBAPW7b2ogq23wHpH+DeTDcRX0rEPTcNO7wuDoDzGrhvY3mWS41rsxjB8rumjDPNwq8UzD89CIhg7yddSJ8D2DxmnyLDHyRzcTDDoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BE1F1516;
	Thu, 13 Mar 2025 03:26:24 -0700 (PDT)
Received: from [10.162.42.23] (K4MQJ0H1H2.blr.arm.com [10.162.42.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D91713F694;
	Thu, 13 Mar 2025 03:26:10 -0700 (PDT)
Message-ID: <76e11ff2-0247-4221-b95a-d73998c8cea7@arm.com>
Date: Thu, 13 Mar 2025 15:56:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/vmalloc: Move free_vm_area(area) from the
 __vmalloc_area_node function to the __vmalloc_node_range_noprof function
To: "Lai, Yi" <yi1.lai@linux.intel.com>, Liu Ye <liuye@kylinos.cn>
Cc: akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, yi1.lai@intel.com
References: <20250303015702.319416-1-liuye@kylinos.cn>
 <Z9Ki0cBBJSiaD6rF@ly-workstation>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <Z9Ki0cBBJSiaD6rF@ly-workstation>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/03/25 2:48 pm, Lai, Yi wrote:
> On Mon, Mar 03, 2025 at 09:57:02AM +0800, Liu Ye wrote:
>> Moved free_vm_area from the __vmalloc_area_node function to the
>> __vmalloc_node_range_noprof function so that allocation and freeing
>> of the area can be paired in one function for better readability.
>>
>> Signed-off-by: Liu Ye <liuye@kylinos.cn>
>> ---
>>   mm/vmalloc.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>> index a6e7acebe9ad..dc658d4af181 100644
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -3651,7 +3651,6 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>>   		warn_alloc(gfp_mask, NULL,
>>   			"vmalloc error: size %lu, failed to allocated page array size %lu",
>>   			nr_small_pages * PAGE_SIZE, array_size);
>> -		free_vm_area(area);
>>   		return NULL;
>>   	}
>>   
>> @@ -3844,8 +3843,10 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
>>   
>>   	/* Allocate physical pages and map them into vmalloc space. */
>>   	ret = __vmalloc_area_node(area, gfp_mask, prot, shift, node);
>> -	if (!ret)
>> +	if (!ret) {
>> +		free_vm_area(area);
>>   		goto fail;
>> +	}
>>   
>>   	/*
>>   	 * Mark the pages as accessible, now that they are mapped.
>> -- 
>> 2.25.1
>>
> 
> Another issue is also bisected to this commit: there is KASAN: slab-use-after-free Read in io_create_region
> 
> 
> Syzkaller repro code:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250313_124102_io_create_region/repro.c
> Syzkaller repro syscall steps:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250313_124102_io_create_region/repro.prog
> Syzkaller report:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250313_124102_io_create_region/repro.report
> Issue dmesg:
> https://github.com/laifryiee/syzkaller_logs/blob/main/250313_124102_io_create_region/eea255893718268e1ab852fb52f70c613d109b99_dmesg.log
> 
> "
> [   24.707888]  __asan_report_load8_noabort+0x18/0x20
> [   24.707895]  __vmalloc_node_range_noprof+0x1344/0x1420
> [   24.707901]  ? __lock_acquire+0x1bad/0x5d60
> [   24.707915]  ? io_create_region+0x6ca/0xe00
> [   24.707933]  ? __pfx___vmalloc_node_range_noprof+0x10/0x10
> [   24.707940]  ? debug_smp_processor_id+0x20/0x30
> [   24.707958]  __kvmalloc_node_noprof+0x2a9/0x6a0
> [   24.707969]  ? io_create_region+0x6ca/0xe00
> [   24.707979]  ? io_create_region+0x6ca/0xe00
> [   24.707992]  io_create_region+0x6ca/0xe00
> [   24.708002]  ? io_create_region+0x6ca/0xe00
> [   24.708015]  ? __pfx_io_create_region+0x10/0x10
> [   24.708025]  ? __this_cpu_preempt_check+0x21/0x30
> [   24.708035]  ? lock_release+0x440/0x870
> [   24.708046]  ? __pfx_lock_release+0x10/0x10
> [   24.708056]  io_create_region_mmap_safe+0xaf/0x150
> [   24.708067]  ? __pfx_io_create_region_mmap_safe+0x10/0x10
> [   24.708081]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
> [   24.708096]  __do_sys_io_uring_register+0xb90/0x2b10
> [   24.708110]  ? __pfx___do_sys_io_uring_register+0x10/0x10
> [   24.708127]  ? trace_hardirqs_on+0x51/0x60
> [   24.708145]  ? __audit_syscall_entry+0x39c/0x500
> [   24.708157]  __x64_sys_io_uring_register+0x9f/0x100
> [   24.708168]  ? syscall_trace_enter+0x14d/0x280
> [   24.708179]  x64_sys_call+0x1eef/0x2150
> [   24.708188]  do_syscall_64+0x6d/0x140
> [   24.708199]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   24.708206] RIP: 0033:0x7f9276c3ee5d
> [   24.708217] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 93 af 1b 00 f7 d8 64 89 01 48
> [   24.708224] RSP: 002b:00007ffd41ff7c18 EFLAGS: 00000202 ORIG_RAX: 00000000000001ab
> [   24.708234] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9276c3ee5d
> [   24.708238] RDX: 0000000020003300 RSI: 0000000000000022 RDI: 0000000000000003
> [   24.708242] RBP: 00007ffd41ff7c30 R08: 00007ffd41ff7c30 R09: 00007ffd41ff7c30
> [   24.708246] R10: 0000000000000001 R11: 0000000000000202 R12: 00007ffd41ff7d88
> [   24.708250] R13: 00000000004017f5 R14: 0000000000403e08 R15: 00007f9276f77000
> [   24.708260]  </TASK>
> [   24.708262]
> [   24.719961] Allocated by task 1208:
> [   24.720136]  kasan_save_stack+0x2c/0x60
> [   24.720336]  kasan_save_track+0x18/0x40
> [   24.720529]  kasan_save_alloc_info+0x3c/0x50
> [   24.720744]  __kasan_kmalloc+0x88/0xa0
> [   24.720933]  __kmalloc_cache_node_noprof+0x1d0/0x470
> [   24.721174]  __get_vm_area_node+0xf7/0x260
> [   24.721380]  __vmalloc_node_range_noprof+0x25c/0x1420
> [   24.721622]  __kvmalloc_node_noprof+0x2a9/0x6a0
> [   24.721848]  io_create_region+0x6ca/0xe00
> [   24.722049]  io_create_region_mmap_safe+0xaf/0x150
> [   24.722291]  __do_sys_io_uring_register+0xb90/0x2b10
> [   24.722539]  __x64_sys_io_uring_register+0x9f/0x100
> [   24.722782]  x64_sys_call+0x1eef/0x2150
> [   24.722976]  do_syscall_64+0x6d/0x140
> [   24.723159]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   24.723405]
> [   24.723491] Freed by task 1208:
> [   24.723648]  kasan_save_stack+0x2c/0x60
> [   24.723841]  kasan_save_track+0x18/0x40
> [   24.724035]  kasan_save_free_info+0x3f/0x60
> [   24.724247]  __kasan_slab_free+0x3d/0x60
> [   24.724450]  kfree+0x28d/0x440
> [   24.724610]  vfree+0x2ce/0x910
> [   24.724769]  __vmalloc_node_range_noprof+0xeca/0x1420
> [   24.725017]  __kvmalloc_node_noprof+0x2a9/0x6a0
> [   24.725240]  io_create_region+0x6ca/0xe00
> [   24.725442]  io_create_region_mmap_safe+0xaf/0x150
> [   24.725682]  __do_sys_io_uring_register+0xb90/0x2b10
> [   24.725934]  __x64_sys_io_uring_register+0x9f/0x100
> [   24.726177]  x64_sys_call+0x1eef/0x2150
> [   24.726365]  do_syscall_64+0x6d/0x140
> [   24.726549]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   24.726796]
> [   24.726882] The buggy address belongs to the object at ffff8880166bfb80
> [   24.726882]  which belongs to the cache kmalloc-64 of size 64
> [   24.727442] The buggy address is located 8 bytes inside of
> [   24.727442]  freed 64-byte region [ffff8880166bfb80, ffff8880166bfbc0)
> [   24.727990]
> [   24.728078] The buggy address belongs to the physical page:
> [   24.728344] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x166bf
> [   24.728712] anon flags: 0xfffffc0000000(node=0|zone=1|lastcpupid=0x1fffff)
> [   24.729034] page_type: f5(slab)
> [   24.729196] raw: 000fffffc0000000 ffff88800d4418c0 0000000000000000 dead000000000001
> [   24.729562] raw: 0000000000000000 0000000080200020 00000000f5000000 0000000000000000
> [   24.729922] page dumped because: kasan: bad access detected
> [   24.730189]
> [   24.730274] Memory state around the buggy address:
> [   24.730503]  ffff8880166bfa80: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> [   24.730839]  ffff8880166bfb00: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> [   24.731179] >ffff8880166bfb80: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> [   24.731518]                       ^
> [   24.731696]  ffff8880166bfc00: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> [   24.732032]  ffff8880166bfc80: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> [   24.732369] ==================================================================
> [   24.732787] Disabling lock debugging due to kernel taint
> [   24.734673] ------------[ cut here ]------------
> [   24.734907] Trying to vfree() bad address (00000000ea48f0e7)
> [   24.735229] WARNING: CPU: 0 PID: 1207 at mm/vmalloc.c:3231 remove_vm_area+0x1c2/0x220
> [   24.735601] Modules linked in:
> [   24.735760] CPU: 0 UID: 0 PID: 1207 Comm: repro Tainted: G    B               6.14.0-rc6-next-20250311-eea255893718 #1
> [   24.736307] Tainted: [B]=BAD_PAGE
> [   24.736477] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [   24.737002] RIP: 0010:remove_vm_area+0x1c2/0x220
> [   24.737230] Code: c3 cc cc cc cc e8 7e e2 a4 ff 49 81 ee 00 10 00 00 e9 51 ff ff ff e8 6d e2 a4 ff 4c 89 e6 48 c7 c7 a0 eb fa 85 e8 ce 71 63 ff <0f> 0b 45 31 ed eb bb 45 31 ed eb b6 e8 ed d2 0f 00 e9 10 ff ff ff
> [   24.738072] RSP: 0000:ffff88804dbc78b8 EFLAGS: 00010292
> "
> 
> Hope this cound be insightful to you.
> 
> Regards,
> Yi Lai
> 


I guess this trace is something else, butiIf __vmalloc_area_node() fails 
while allocating physical memory (after we have allocated the pages 
array), you call vfree(area->addr), and then the patch does a 
free_vm_area() again, causing a double free.


