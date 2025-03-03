Return-Path: <linux-kernel+bounces-540930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4C5A4B687
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 04:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36C551883D7D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00AB1C84BF;
	Mon,  3 Mar 2025 03:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgWzHEaZ"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A74AD27
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 03:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740972550; cv=none; b=WCT1tKC/dCcIdC1/6Q3Ai4KpUo3SnAgh9lsvEJrD/M/VRdqqIZZD3YEVcaX6bG0/fQn+Iq3AKa8Ua6npJHFLXrkXnn6eEtMgWRelwVBHGe6LbKLUAX/C9Xgm9h0NfAP44QyITy7wjVqOzZSnakW/Oz/0l8lGGgBXNUvBY/zKS9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740972550; c=relaxed/simple;
	bh=PH+UgVpduJvVs4Sv/iL4r4yCTZGVDVkTj8oJSBImvMk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=EXzFBdAJ4sQRXufQ4vDuioD6NWNc+in/Z5af1i9K8Gg+JsXvFnOxA69klx8hRuCFLCg6ehj1FuloIBoQ0HXyMlM+tPV1EHUTCcN+ow0t0Te82iYiIiwKCnHJA4xxK4OtREFrLpz2qyMDrsne41cxzJSqmrukL3cMwD4ZfSby7vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BgWzHEaZ; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-724d1724657so2554208a34.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 19:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740972548; x=1741577348; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aWknhiFa0B4WqxpoLJBg7zPZQxK85hrLUV4++fYVOc4=;
        b=BgWzHEaZIct810VwTaUyEnri5NYETHJeiYKNoE3xGGE4cCXbq06v4du0CSM8fIZ3No
         4Qhq80HPdSfNtpBT7HSFgCkLi942/qQcGEHQZz2o0UkGtwoxVm089z5B3y5q18mhU0V1
         u9DV8skHh7yi5Z2oiQDdsaZO58UeRnqsz1tRBOhrGMszvPWZHcmKaKbZuPA/NpFsG5xC
         yKk4xIQZ7RHdAe/3vySHwfTsO+UUbsa9HKMt7jLq/XB8KMwxV7pVlq4x4Qlo8ahqksLQ
         FHTSJiRkrLpPPNw/aR9cW9T/rGMaoAoUKNgtawd4+f3qB6r+OZ0aPfc8wVs8d3asAi1j
         rRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740972548; x=1741577348;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aWknhiFa0B4WqxpoLJBg7zPZQxK85hrLUV4++fYVOc4=;
        b=Lx9HUZsONDR6qies4C0flNpsjaTi4NdVyUMP9zQaGkIJoXRyXrKqFaOaNSYZTLYkPd
         Ni6UWPQra51+LVyYGb+DfDFT6cdPcg+8WfoPnaN5TlGn2VdSugpMgVfUvAKUWnGMkK+u
         tJ+kNj4QWLkcHB/DNU7KjvtVx5NZhr3CgySF3S6CodEDbjQgf/9VYTOB18lskPt7l2As
         deS4cD15SSoYpYMHp8/F+io9BYHc2CZSrUjf9ARoWsnLkvyDT6iR01zWREix0mUnghGP
         0rfgorA2zhHmkwQpScWGjOdIBVUgiJ5cNg2PaINyk2Hy9Azr1rSDsXVNi9951HK6FWuD
         o/Xg==
X-Forwarded-Encrypted: i=1; AJvYcCVRDopgbRLNm/r3XZUZ8+ATjaq0XFcC5Zbc6rv5EeBv1lI9FVcYaGSiotpQOfK1XA4/EUNamkvYxFeWK9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYlzz85xDaW1HWs/5tTdegHwkM8uy+1Y3R72fHgwPO4WtjKzsx
	OGK5qnena4sADmVgGnmO+OF/C/dCwZ4PHnQZEBXQAd9IMbCpHURBCdzk9RP7mZhQ/EuRmy7DGt0
	TceKop8Rl0UpHeLI0ROvx2dEz6Ik=
X-Gm-Gg: ASbGncupWl1rgPAKp3IEAyX3fNNFV0uG8aNrpdUSzHZVZ1eQ2CofD4VemgkcPOTMB1j
	YZgGo0NOPFvdkGPFA8jACqQzKPOU65uBIbn4QcFPhttcpgHFCeMZ5JbEk9NQz/RZnmqJ4PqtFb5
	EfjGY5UhegWrKGV05AqgvzUkjBQw==
X-Google-Smtp-Source: AGHT+IF431HQo0sh51P/q4eWGcWUJ4aJPIzgNglznC/u/q9dI7YEsaGN6v6CFxn86/4fe3OwfJVuMhGQpjAQrHTEeWs=
X-Received: by 2002:a05:6830:1e76:b0:727:2fad:105a with SMTP id
 46e09a7af769-728ae56f48bmr9008452a34.1.1740972547972; Sun, 02 Mar 2025
 19:29:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Strforexc yn <strforexc@gmail.com>
Date: Mon, 3 Mar 2025 11:28:57 +0800
X-Gm-Features: AQ5f1Jo-WCLwzAVS6nUrg3Z8UlF4GpsTpf5wKbrsDhXE_5g5gQBskG_9H8erOog
Message-ID: <CA+HokZok8x=9Z=o0Y+hFWTNbeokM3Gmenq741HKqHOMLfarezw@mail.gmail.com>
Subject: =?UTF-8?Q?KASAN=3A_slab=2Duse=2Dafter=2Dfree_Read_in_hdm=5Fdisconnect_?=
	=?UTF-8?Q?=EF=BC=88_v6=2E14=2Drc4_kernel=EF=BC=89?=
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
	Christian Gromm <christian.gromm@microchip.com>, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Maintainers, When using our customized Syzkaller to fuzz the
latest Linux kernel, the following crashwas triggered.

Kernel commit: v6.14-rc4 (Commits on Feb 24, 2025)
Kernel Config : https://github.com/Strforexc/LinuxKernelbug/blob/main/.conf=
ig
Kernel Log=EF=BC=9A https://github.com/Strforexc/LinuxKernelbug/blob/main/s=
lab_uaf_read_gfs2_dis/log0
Reproduce.c:  https://github.com/Strforexc/LinuxKernelbug/blob/main/slab_ua=
f_read_hdm_disconnect/repro.cprog

KASAN detects a use-after-free read of size 8 at address
ffff88806e3c9898 in hdm_disconnect (drivers/most/most_usb.c:1125),
triggered by a USB disconnect event processed via the usb_hub_wq
workqueue.

This bug seems to have been reported and fixed in the old kernel,
which seems to be a regression issue? If you fix this issue, please
add the following tag to the commit:
Reported-by: Zhizhuo Tang strforexctzzchange@foxmail.com, Jianzhou
Zhao xnxc22xnxc22@qq.com, Haoran Liu <cherest_san@163.com>

usb 7-1: USB disconnect, device number 9
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-use-after-free in hdm_disconnect+0x227/0x250
drivers/most/most_usb.c:1125
Read of size 8 at addr ffff88806e3c9898 by task kworker/0:1/9

CPU: 0 UID: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.14.0-rc4 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1b0 lib/dump_stack.c:120
 print_address_description.constprop.0+0x2c/0x420 mm/kasan/report.c:408
 print_report+0xaa/0x270 mm/kasan/report.c:521
 kasan_report+0xbd/0x100 mm/kasan/report.c:634
 hdm_disconnect+0x227/0x250 drivers/most/most_usb.c:1125
 usb_unbind_interface+0x1e5/0x980 drivers/usb/core/driver.c:458
 device_remove+0x125/0x170 drivers/base/dd.c:569
 __device_release_driver drivers/base/dd.c:1273 [inline]
 device_release_driver_internal+0x443/0x620 drivers/base/dd.c:1296
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:579
 device_del+0x395/0x9e0 drivers/base/core.c:3854
 usb_disable_device+0x360/0x7b0 drivers/usb/core/message.c:1418
 usb_disconnect+0x2db/0x930 drivers/usb/core/hub.c:2316
 hub_port_connect+0x1f7/0x2730 drivers/usb/core/hub.c:5373
 hub_port_connect_change+0x27c/0x7f0 drivers/usb/core/hub.c:5673
 port_event+0xe3d/0x1220 drivers/usb/core/hub.c:5833
 hub_event+0x517/0xca0 drivers/usb/core/hub.c:5915
 process_one_work+0x109d/0x18c0 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3317 [inline]
 worker_thread+0x677/0xe90 kernel/workqueue.c:3398
 kthread+0x3b3/0x760 kernel/kthread.c:464
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 9:
 kasan_save_stack+0x24/0x50 mm/kasan/common.c:47
 kasan_save_track+0x14/0x40 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xba/0xc0 mm/kasan/common.c:394
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 hdm_probe+0xb7/0x18b0 drivers/most/most_usb.c:959
 usb_probe_interface+0x30b/0x9e0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x252/0xaa0 drivers/base/dd.c:658
 __driver_probe_device+0x1df/0x460 drivers/base/dd.c:800
 driver_probe_device+0x49/0x120 drivers/base/dd.c:830
 __device_attach_driver+0x1e3/0x2f0 drivers/base/dd.c:958
 bus_for_each_drv+0x14c/0x1e0 drivers/base/bus.c:462
 __device_attach+0x1f2/0x4d0 drivers/base/dd.c:1030
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:537
 device_add+0xc5e/0x1490 drivers/base/core.c:3665
 usb_set_configuration+0x11a5/0x1c50 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0xbf/0x120 drivers/usb/core/generic.c:250
 usb_probe_device+0xed/0x3e0 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x252/0xaa0 drivers/base/dd.c:658
 __driver_probe_device+0x1df/0x460 drivers/base/dd.c:800
 driver_probe_device+0x49/0x120 drivers/base/dd.c:830
 __device_attach_driver+0x1e3/0x2f0 drivers/base/dd.c:958
 bus_for_each_drv+0x14c/0x1e0 drivers/base/bus.c:462
 __device_attach+0x1f2/0x4d0 drivers/base/dd.c:1030
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:537
 device_add+0xc5e/0x1490 drivers/base/core.c:3665
 usb_new_device+0x8f4/0x1430 drivers/usb/core/hub.c:2663
 hub_port_connect+0x1122/0x2730 drivers/usb/core/hub.c:5533
 hub_port_connect_change+0x27c/0x7f0 drivers/usb/core/hub.c:5673
 port_event+0xe3d/0x1220 drivers/usb/core/hub.c:5833
 hub_event+0x517/0xca0 drivers/usb/core/hub.c:5915
 process_one_work+0x109d/0x18c0 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3317 [inline]
 worker_thread+0x677/0xe90 kernel/workqueue.c:3398
 kthread+0x3b3/0x760 kernel/kthread.c:464
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 9:
 kasan_save_stack+0x24/0x50 mm/kasan/common.c:47
 kasan_save_track+0x14/0x40 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x80 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x54/0x80 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4609 [inline]
 kfree+0x12e/0x420 mm/slub.c:4757
 device_release+0xa6/0x240 drivers/base/core.c:2567
 kobject_cleanup+0x136/0x410 lib/kobject.c:689
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0xf0/0x130 lib/kobject.c:737
 put_device drivers/base/core.c:3773 [inline]
 device_unregister+0x30/0xc0 drivers/base/core.c:3896
 hdm_disconnect+0x10b/0x250 drivers/most/most_usb.c:1123
 usb_unbind_interface+0x1e5/0x980 drivers/usb/core/driver.c:458
 device_remove+0x125/0x170 drivers/base/dd.c:569
 __device_release_driver drivers/base/dd.c:1273 [inline]
 device_release_driver_internal+0x443/0x620 drivers/base/dd.c:1296
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:579
 device_del+0x395/0x9e0 drivers/base/core.c:3854
 usb_disable_device+0x360/0x7b0 drivers/usb/core/message.c:1418
 usb_disconnect+0x2db/0x930 drivers/usb/core/hub.c:2316
 hub_port_connect+0x1f7/0x2730 drivers/usb/core/hub.c:5373
 hub_port_connect_change+0x27c/0x7f0 drivers/usb/core/hub.c:5673
 port_event+0xe3d/0x1220 drivers/usb/core/hub.c:5833
 hub_event+0x517/0xca0 drivers/usb/core/hub.c:5915
 process_one_work+0x109d/0x18c0 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3317 [inline]
 worker_thread+0x677/0xe90 kernel/workqueue.c:3398
 kthread+0x3b3/0x760 kernel/kthread.c:464
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff88806e3c8000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 6296 bytes inside of
 freed 8192-byte region [ffff88806e3c8000, ffff88806e3ca000)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x6e3c8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
ksm flags: 0x4fff00000000040(head|node=3D1|zone=3D1|lastcpupid=3D0x7ff)
page_type: f5(slab)
raw: 04fff00000000040 ffff88801b442280 ffffea0001242000 dead000000000003
raw: 0000000000000000 0000000080020002 00000000f5000000 0000000000000000
head: 04fff00000000040 ffff88801b442280 ffffea0001242000 dead000000000003
head: 0000000000000000 0000000080020002 00000000f5000000 0000000000000000
head: 04fff00000000003 ffffea0001b8f201 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask
0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEM=
ALLOC),
pid 16917, tgid 16916 (syz.6.368), ts 182425166303, free_ts
182208588085
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1a3/0x1d0 mm/page_alloc.c:1551
 prep_new_page mm/page_alloc.c:1559 [inline]
 get_page_from_freelist+0x8a5/0xfa0 mm/page_alloc.c:3477
 __alloc_frozen_pages_noprof+0x1d8/0x3b0 mm/page_alloc.c:4739
 alloc_pages_mpol+0x1f2/0x550 mm/mempolicy.c:2270
 alloc_slab_page mm/slub.c:2423 [inline]
 allocate_slab+0x229/0x310 mm/slub.c:2587
 ___slab_alloc+0x7f3/0x12b0 mm/slub.c:3826
 __slab_alloc.constprop.0+0x56/0xc0 mm/slub.c:3916
 __slab_alloc_node mm/slub.c:3991 [inline]
 slab_alloc_node mm/slub.c:4152 [inline]
 __kmalloc_cache_noprof+0x280/0x450 mm/slub.c:4320
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 cryptomgr_schedule_probe+0x92/0xab0 crypto/algboss.c:87
 cryptomgr_notify+0x49/0x70 crypto/algboss.c:225
 notifier_call_chain+0xd7/0x250 kernel/notifier.c:85
 blocking_notifier_call_chain+0x6b/0xb0 kernel/notifier.c:380
 crypto_probing_notify crypto/api.c:322 [inline]
 crypto_alg_mod_lookup+0x350/0x500 crypto/api.c:352
 crypto_type_has_alg+0x2d/0xa0 crypto/algapi.c:1006
 xfrm_probe_algs+0x16b/0x400 net/xfrm/xfrm_algo.c:825
 pfkey_register+0xef/0x270 net/key/af_key.c:1701
page last free pid 5211 tgid 5211 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_frozen_pages+0x71f/0xff0 mm/page_alloc.c:2660
 __put_partials+0x13b/0x190 mm/slub.c:3153
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x50/0x130 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x1a5/0x1f0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x6f/0xa0 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4115 [inline]
 slab_alloc_node mm/slub.c:4164 [inline]
 kmem_cache_alloc_noprof+0x167/0x400 mm/slub.c:4171
 getname_flags+0xd2/0x620 fs/namei.c:139
 do_sys_openat2+0xf2/0x1d0 fs/open.c:1422
 do_sys_open fs/open.c:1443 [inline]
 __do_sys_openat fs/open.c:1459 [inline]
 __se_sys_openat fs/open.c:1454 [inline]
 __x64_sys_openat+0x140/0x200 fs/open.c:1454
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcb/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88806e3c9780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88806e3c9800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88806e3c9880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff88806e3c9900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88806e3c9980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Regards,
Zhizhuo Tang

