Return-Path: <linux-kernel+bounces-449066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A3D9F493C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FA8E16EAAB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380FA1E5721;
	Tue, 17 Dec 2024 10:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGBk0shF"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221B51E3DC3
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 10:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734432756; cv=none; b=UClFcB1ju4vF38CIlCUqE/m3KCQNMtNSIwsmuPEYBVX4PUTwtHiNEnHBRuQg/TzeYGCvgzkPe9LcTor6vbOpE/YGwLP4O7TCGYofUUxP7B6CFDPdDmZwluXq9PLliU3k1Jhv5ZvJ/p6EP/EaEujSYP9D5Xh6DsXm1y1l/M/YCBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734432756; c=relaxed/simple;
	bh=Z97LDrUHV6xOJxL1whGVyd15jNkzFzloYR9BdyOqWwI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=pHouLEDTRYvUXLHstz+ABGF7/UTNSSOWzEoU9w41smB3lMRG8ZCiEje6OaBFxlziHufufsNIwlQlUgVkCF3OYf6ucr+udTU/n5+RBH50zJwV9z6kwg1c7C9sTS01ce4TeJVYqHmlWjzOMK6+LvjTkeEr0oTN2A55GZygHRYmWSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGBk0shF; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b6f1b54dc3so775578885a.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 02:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734432753; x=1735037553; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4IIEFIIQNV9IxPudhkzoZvjS7eY9wS1MlYBF/wLSbbw=;
        b=cGBk0shFdtMKBOaEJx6KDsQu7utb/kCIGjfYKwO7ptDn90rCVCxz1WehslXY5R9Lqz
         CJZpeq0E3+fJDE35InT7SS+CMkCgzNcXosytSuGpJD/Db47JvKur1ofAGhV/QBlGuPQF
         P7BzlIzSqJ0z1C+pgizp6cDQhbRtiftoYZ25GFD52ve4qITSLngxM08d3zQ9iar2O2Fe
         RVOl26021btrf5m+aP6TnoeJ5wPXwk4NRhpZLkpUEycUXkTR62bAVW/l6r3gJZ1UyTYC
         ygIeavra/Ajzk+0QOv1h8FjUAjlZSBSeVAMO7RQa9Tzrm3Wj+P5RUxPXDm8RuxrRk0sY
         kB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734432753; x=1735037553;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4IIEFIIQNV9IxPudhkzoZvjS7eY9wS1MlYBF/wLSbbw=;
        b=Un+fsB47j2sJrbfpwqd8RMh5d9DTiK3Q5cZ7/MQd6lBVi8yCQz1bPJ/hWyKI1I55+7
         GgPD4/6oMvHcaGapD0GyaSh0YogmK1LQS9PTHEWUyUchxE/ZFdySnOH6ICJqIBcPwwv4
         FB05y58gb7GCCXfXtUiTU39TCQRsSoSwzJ6tGB5EXuHgvVmBIs5ZalTj28p6rJqUonvJ
         ZZpuPXjLgDYah5d8a2OsKkKynIjfvHg3cmVVJUXzYQYtMPMUWB7CapBqdoaAdqYNnYzG
         dm6AooZiPi4eklg+zBfbP3o8MLtYwtPMfzpK8C3mZuQihlWewM5olb9brQvnE/QG1BHU
         yD4w==
X-Gm-Message-State: AOJu0YyzL5hdLN1zgw6MPnkOrwBPokkjk5gx1mO0ZHYADcGqVWpVKscW
	kWx94/ExeSH32/syQWBFDoT7AG+ArfyRcy2dEDB+t0Dp8KSsjDEfpPrmUcQf2il0HX022V5fnWw
	fj1xtrKVGSjzdC/oID46QOZ2F1lPZFrMDkMbmT7CkScQ=
X-Gm-Gg: ASbGncupwF3xIZAVGmx28kJe/1sFO7eDftnELF8ecOrt8FeQx6m4sMnVqtWY9eZVE3u
	AwyLJNr+FEcgif8Xd2SlwPUFCQgn21D9ftAxr+qo=
X-Google-Smtp-Source: AGHT+IGm8aebu5/aa73iTH2L7GtBiP9s3FtO0rK2pn/VaJhMneuBHI7dDoWxhSHHwQNhuVhfEHb+9zoPaMek4e8kKO4=
X-Received: by 2002:a05:6214:21a9:b0:6d4:18ce:117f with SMTP id
 6a1803df08f44-6dc8ca93ac0mr227289716d6.20.1734432752256; Tue, 17 Dec 2024
 02:52:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sam Sun <samsun1006219@gmail.com>
Date: Tue, 17 Dec 2024 18:52:21 +0800
Message-ID: <CAEkJfYMtSdM5HceNsXUDf5haghD5+o2e7Qv4OcuruL4tPg6OaQ@mail.gmail.com>
Subject: [Bug] KASAN: slab-use-after-free Read in zswap_decompress
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: syzkaller-bugs@googlegroups.com, akpm@linux-foundation.org, 
	chengming.zhou@linux.dev, Nhat Pham <nphamcs@gmail.com>, yosryahmed@google.com, 
	hannes@cmpxchg.org
Content-Type: text/plain; charset="UTF-8"

Dear developers and maintainers,

We encountered a slab-use-after-free bug while using our modified
syzkaller. Kernel crash log is listed below.

==================================================================
BUG: KASAN: slab-use-after-free in zswap_decompress+0x7d7/0x810 mm/zswap.c:988
Read of size 4 at addr ffff888027874044 by task kswapd0/92

CPU: 1 UID: 0 PID: 92 Comm: kswapd0 Not tainted 6.12.0-09435-g2c22dc1ee3a1 #11
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.16.1-0-g3208b098f51a-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1b0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xc0/0x5e0 mm/kasan/report.c:489
 kasan_report+0xbd/0xf0 mm/kasan/report.c:602
 zswap_decompress+0x7d7/0x810 mm/zswap.c:988
 zswap_writeback_entry+0x1e9/0x860 mm/zswap.c:1058
 shrink_memcg_cb+0x213/0x360 mm/zswap.c:1163
 __list_lru_walk_one+0x15e/0x490 mm/list_lru.c:301
 list_lru_walk_one+0x3e/0x50 mm/list_lru.c:338
 list_lru_shrink_walk include/linux/list_lru.h:240 [inline]
 zswap_shrinker_scan+0x135/0x220 mm/zswap.c:1197
 do_shrink_slab+0x44e/0x1190 mm/shrinker.c:437
 shrink_slab_memcg mm/shrinker.c:550 [inline]
 shrink_slab+0xb61/0x12a0 mm/shrinker.c:628
 shrink_one+0x4ad/0x7c0 mm/vmscan.c:4836
 shrink_many mm/vmscan.c:4897 [inline]
 lru_gen_shrink_node mm/vmscan.c:4975 [inline]
 shrink_node+0x269a/0x3d60 mm/vmscan.c:5956
 kswapd_shrink_node mm/vmscan.c:6785 [inline]
 balance_pgdat+0xbe5/0x18c0 mm/vmscan.c:6977
 kswapd+0x6ff/0xd60 mm/vmscan.c:7246
 kthread+0x2ca/0x3b0 kernel/kthread.c:389
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 1:
 kasan_save_stack+0x24/0x50 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4283 [inline]
 __kmalloc_noprof+0x212/0x530 mm/slub.c:4295
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 __acomp_request_alloc_noprof include/crypto/internal/acompress.h:75 [inline]
 acomp_request_alloc+0x46/0x110 crypto/acompress.c:131
 zswap_cpu_comp_prepare+0x1f4/0x470 mm/zswap.c:840
 cpuhp_invoke_callback+0x26d/0x9d0 kernel/cpu.c:204
 cpuhp_issue_call+0x1c1/0x8d0 kernel/cpu.c:2375
 __cpuhp_state_add_instance_cpuslocked+0x26a/0x3c0 kernel/cpu.c:2437
 __cpuhp_state_add_instance+0xd7/0x2e0 kernel/cpu.c:2458
 cpuhp_state_add_instance include/linux/cpuhotplug.h:386 [inline]
 zswap_pool_create+0x2c3/0x5c0 mm/zswap.c:288
 __zswap_pool_create_fallback mm/zswap.c:356 [inline]
 zswap_setup+0x3a5/0x820 mm/zswap.c:1781
 zswap_init+0x2d/0x40 mm/zswap.c:1817
 do_one_initcall+0x111/0x6d0 init/main.c:1266
 do_initcall_level init/main.c:1328 [inline]
 do_initcalls init/main.c:1344 [inline]
 do_basic_setup init/main.c:1363 [inline]
 kernel_init_freeable+0x5ae/0x8a0 init/main.c:1577
 kernel_init+0x1e/0x2d0 init/main.c:1466
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 25:
 kasan_save_stack+0x24/0x50 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x54/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2338 [inline]
 slab_free mm/slub.c:4598 [inline]
 kfree+0x14e/0x4d0 mm/slub.c:4746
 zswap_cpu_comp_dead+0xe3/0x1c0 mm/zswap.c:874
 cpuhp_invoke_callback+0x564/0x9d0 kernel/cpu.c:216
 __cpuhp_invoke_callback_range+0x104/0x220 kernel/cpu.c:965
 cpuhp_invoke_callback_range kernel/cpu.c:989 [inline]
 cpuhp_down_callbacks kernel/cpu.c:1382 [inline]
 _cpu_down+0x41d/0xef0 kernel/cpu.c:1443
 __cpu_down_maps_locked+0x6f/0x90 kernel/cpu.c:1473
 work_for_cpu_fn+0x55/0xa0 kernel/workqueue.c:6719
 process_one_work+0x9a2/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x677/0xe90 kernel/workqueue.c:3391
 kthread+0x2ca/0x3b0 kernel/kthread.c:389
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff888027874000
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 68 bytes inside of
 freed 96-byte region [ffff888027874000, ffff888027874060)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x27874
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801b041280 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000200020 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask
0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1, tgid
1 (swapper/0), ts 20389586985, free_ts 18720773637
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2e7/0x350 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0xe4e/0x2b20 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x219/0x21f0 mm/page_alloc.c:4751
 alloc_pages_mpol_noprof+0x2b6/0x600 mm/mempolicy.c:2265
 alloc_slab_page mm/slub.c:2408 [inline]
 allocate_slab mm/slub.c:2574 [inline]
 new_slab+0x2d5/0x420 mm/slub.c:2627
 ___slab_alloc+0xbb7/0x1850 mm/slub.c:3815
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3905
 __slab_alloc_node mm/slub.c:3980 [inline]
 slab_alloc_node mm/slub.c:4141 [inline]
 __do_kmalloc_node mm/slub.c:4282 [inline]
 __kmalloc_noprof+0x2ac/0x530 mm/slub.c:4295
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 __acomp_request_alloc_noprof include/crypto/internal/acompress.h:75 [inline]
 acomp_request_alloc+0x46/0x110 crypto/acompress.c:131
 zswap_cpu_comp_prepare+0x1f4/0x470 mm/zswap.c:840
 cpuhp_invoke_callback+0x26d/0x9d0 kernel/cpu.c:204
 cpuhp_issue_call+0x1c1/0x8d0 kernel/cpu.c:2375
 __cpuhp_state_add_instance_cpuslocked+0x26a/0x3c0 kernel/cpu.c:2437
 __cpuhp_state_add_instance+0xd7/0x2e0 kernel/cpu.c:2458
 cpuhp_state_add_instance include/linux/cpuhotplug.h:386 [inline]
 zswap_pool_create+0x2c3/0x5c0 mm/zswap.c:288
 __zswap_pool_create_fallback mm/zswap.c:356 [inline]
 zswap_setup+0x3a5/0x820 mm/zswap.c:1781
page last free pid 54 tgid 54 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0x714/0x10c0 mm/page_alloc.c:2657
 vfree+0x17e/0x890 mm/vmalloc.c:3382
 delayed_vfree_work+0x57/0x70 mm/vmalloc.c:3303
 process_one_work+0x9a2/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x677/0xe90 kernel/workqueue.c:3391
 kthread+0x2ca/0x3b0 kernel/kthread.c:389
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff888027873f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888027873f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888027874000: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                                           ^
 ffff888027874080: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
 ffff888027874100: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
==================================================================
We also find a similar bug report in function zswap_store(), listed as below:

==================================================================
BUG: KASAN: slab-use-after-free in zswap_compress mm/zswap.c:925 [inline]
BUG: KASAN: slab-use-after-free in zswap_store_page mm/zswap.c:1426 [inline]
BUG: KASAN: slab-use-after-free in zswap_store+0x2307/0x25e0 mm/zswap.c:1533
Read of size 4 at addr ffff8880219f6b44 by task kswapd0/88

CPU: 1 UID: 0 PID: 88 Comm: kswapd0 Tainted: G     U
6.12.0-09435-g2c22dc1ee3a1 #11
Tainted: [U]=USER
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.16.1-0-g3208b098f51a-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1b0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xc0/0x5e0 mm/kasan/report.c:489
 kasan_report+0xbd/0xf0 mm/kasan/report.c:602
 zswap_compress mm/zswap.c:925 [inline]
 zswap_store_page mm/zswap.c:1426 [inline]
 zswap_store+0x2307/0x25e0 mm/zswap.c:1533
 swap_writepage+0x3a8/0xe50 mm/page_io.c:279
 pageout+0x3b9/0xa90 mm/vmscan.c:689
 shrink_folio_list+0x2988/0x4340 mm/vmscan.c:1367
 evict_folios+0x72b/0x1a10 mm/vmscan.c:4593
 try_to_shrink_lruvec+0x62b/0xa60 mm/vmscan.c:4789
 shrink_one+0x417/0x7c0 mm/vmscan.c:4834
 shrink_many mm/vmscan.c:4897 [inline]
 lru_gen_shrink_node mm/vmscan.c:4975 [inline]
 shrink_node+0x269a/0x3d60 mm/vmscan.c:5956
 kswapd_shrink_node mm/vmscan.c:6785 [inline]
 balance_pgdat+0xbe5/0x18c0 mm/vmscan.c:6977
 kswapd+0x6ff/0xd60 mm/vmscan.c:7246
 kthread+0x2ca/0x3b0 kernel/kthread.c:389
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 1:
 kasan_save_stack+0x24/0x50 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4283 [inline]
 __kmalloc_noprof+0x212/0x530 mm/slub.c:4295
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 __acomp_request_alloc_noprof include/crypto/internal/acompress.h:75 [inline]
 acomp_request_alloc+0x46/0x110 crypto/acompress.c:131
 zswap_cpu_comp_prepare+0x1f4/0x470 mm/zswap.c:840
 cpuhp_invoke_callback+0x26d/0x9d0 kernel/cpu.c:204
 cpuhp_issue_call+0x1c1/0x8d0 kernel/cpu.c:2375
 __cpuhp_state_add_instance_cpuslocked+0x26a/0x3c0 kernel/cpu.c:2437
 __cpuhp_state_add_instance+0xd7/0x2e0 kernel/cpu.c:2458
 cpuhp_state_add_instance include/linux/cpuhotplug.h:386 [inline]
 zswap_pool_create+0x2c3/0x5c0 mm/zswap.c:288
 __zswap_pool_create_fallback mm/zswap.c:356 [inline]
 zswap_setup+0x3a5/0x820 mm/zswap.c:1781
 zswap_init+0x2d/0x40 mm/zswap.c:1817
 do_one_initcall+0x111/0x6d0 init/main.c:1266
 do_initcall_level init/main.c:1328 [inline]
 do_initcalls init/main.c:1344 [inline]
 do_basic_setup init/main.c:1363 [inline]
 kernel_init_freeable+0x5ae/0x8a0 init/main.c:1577
 kernel_init+0x1e/0x2d0 init/main.c:1466
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 901:
 kasan_save_stack+0x24/0x50 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x54/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2338 [inline]
 slab_free mm/slub.c:4598 [inline]
 kfree+0x14e/0x4d0 mm/slub.c:4746
 zswap_cpu_comp_dead+0xe3/0x1c0 mm/zswap.c:874
 cpuhp_invoke_callback+0x564/0x9d0 kernel/cpu.c:216
 __cpuhp_invoke_callback_range+0x104/0x220 kernel/cpu.c:965
 cpuhp_invoke_callback_range kernel/cpu.c:989 [inline]
 cpuhp_down_callbacks kernel/cpu.c:1382 [inline]
 _cpu_down+0x41d/0xef0 kernel/cpu.c:1443
 __cpu_down_maps_locked+0x6f/0x90 kernel/cpu.c:1473
 work_for_cpu_fn+0x55/0xa0 kernel/workqueue.c:6719
 process_one_work+0x9a2/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x677/0xe90 kernel/workqueue.c:3391
 kthread+0x2ca/0x3b0 kernel/kthread.c:389
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff8880219f6b00
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 68 bytes inside of
 freed 96-byte region [ffff8880219f6b00, ffff8880219f6b60)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x219f6
anon flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801b041280 ffffea0000887d00 dead000000000005
raw: 0000000000000000 0000000000200020 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask
0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1, tgid
1 (swapper/0), ts 15792736110, free_ts 14433067061
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2e7/0x350 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0xe4e/0x2b20 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x219/0x21f0 mm/page_alloc.c:4751
 alloc_pages_mpol_noprof+0x2b6/0x600 mm/mempolicy.c:2265
 alloc_slab_page mm/slub.c:2408 [inline]
 allocate_slab mm/slub.c:2574 [inline]
 new_slab+0x2d5/0x420 mm/slub.c:2627
 ___slab_alloc+0xbb7/0x1850 mm/slub.c:3815
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3905
 __slab_alloc_node mm/slub.c:3980 [inline]
 slab_alloc_node mm/slub.c:4141 [inline]
 __kmalloc_cache_noprof+0x280/0x410 mm/slub.c:4309
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 usb_hub_create_port_device+0xbb/0xde0 drivers/usb/core/port.c:743
 hub_configure drivers/usb/core/hub.c:1710 [inline]
 hub_probe+0x1ceb/0x2fc0 drivers/usb/core/hub.c:1965
 usb_probe_interface+0x314/0x9f0 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x252/0xa90 drivers/base/dd.c:658
 __driver_probe_device+0x1df/0x450 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
 __device_attach_driver+0x1db/0x2f0 drivers/base/dd.c:958
 bus_for_each_drv+0x14c/0x1d0 drivers/base/bus.c:459
page last free pid 25 tgid 25 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0x714/0x10c0 mm/page_alloc.c:2657
 vfree+0x17e/0x890 mm/vmalloc.c:3382
 delayed_vfree_work+0x57/0x70 mm/vmalloc.c:3303
 process_one_work+0x9a2/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x677/0xe90 kernel/workqueue.c:3391
 kthread+0x2ca/0x3b0 kernel/kthread.c:389
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff8880219f6a00: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
 ffff8880219f6a80: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
>ffff8880219f6b00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                                           ^
 ffff8880219f6b80: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
 ffff8880219f6c00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
==================================================================
If you have any questions, please contact us.

Best Regards,
Yue

