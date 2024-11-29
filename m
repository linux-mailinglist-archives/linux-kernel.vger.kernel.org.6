Return-Path: <linux-kernel+bounces-424432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEF19DB452
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F042C167547
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 08:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2601547C9;
	Thu, 28 Nov 2024 08:52:29 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E393114D44D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 08:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732783948; cv=none; b=hhQC0iyE4RYHi+TXB3ow1rqu75kAsDs/3lWeMPIVJxwa5F9HPKaxIkneXHMHoCm+OWlmH6URPi10hzIQqDGm49N4zXszXt9IN/Z4G7eKzPRrScpA8P002W+aEkPv8PWXLRbgOPFIJuvNsc5j0zHC+qPatBgvktLc/CPHY3HGhZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732783948; c=relaxed/simple;
	bh=9aeeKu6QixX8Ubep9FzTiYmcEMSu6GG694fb3CSIdeo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KhTamtL9ywTcEguPS2fqH2AYsJAo/D65gjm0L8tWA7zFyQy3yPIou5wgLH1Z6tNkG2m3D/BAQvGLQAxNlwltCZ8xLKsiG8ydX43QC7xVpEj9h5t8avee88HCHPIV/0GCaPNnYgR7d4ISEKuktwyBdtIf0mFH/qysXvQDujKKF4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a7c729bfbaso6761485ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 00:52:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732783946; x=1733388746;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yvBcnI8rnZtXIC+LTjpwWNF/dj05PLjbCh520sjxNNI=;
        b=Llidv0Bzbm94uQiA9fuwOk/pbqGknUGF+waZK/DQWeaAU6mSrckzDX2V0+cPsbBIWO
         brm9BxP+1PEQoN4X/2RKFvyxYGSTLieyfgPx+pDUMsBl81xmI5rNij5OwaOQlcOF5rvt
         MhpGIP8Vfogy3PoSXJUYrkW/tRxNF8VCT8Z7EO1D/hYCvpC47CdC1K3/ZDJVCG9F2HB1
         go3n2Hmw56iEiwasfOuh9602uM4x4ddq63WAYesVR5zYGSFxVSHt5ze6IidkhDEwVN87
         BCE942ZNjj6pZracxm+QPiULmKdCZpOb3clAvDLUPNLuLWgKLgS2SYimboltgsczyHKJ
         rwJg==
X-Forwarded-Encrypted: i=1; AJvYcCXBR1FVdC6NcQYd8ExhbweJLrU0tZAaxdAyB7jvqFCD2mNydUZf1BiDy2qVml+eowP9fQWHV1f/41jRCI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw140qO3kL/knursNpBOpO62C9SUp/uUGauiXYYxvi5MCkfF8Qu
	A+jcVJc6HMq4+8Fhl2yX8FKGdCqZ39L50AuydnKJeMwgWsyyq8yNbrFroEz13fPxJq8lFjL9+g5
	+Y3lwAw2VNUVwxfr2UvvUhW8V9/rkMMsGmEGa3Ao1tIVaRt31ZuqL0fA=
X-Google-Smtp-Source: AGHT+IGcUUtjZcPL015R33RdJtRQ+YhJW4kzBLGFnyR17mg0FjNs3x0DziF7t6EcL//qOR59N25fCPEBMhgGw+oEryL0qxBoFEMF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1caf:b0:3a7:8720:9de8 with SMTP id
 e9e14a558f8ab-3a7c552677amr73853715ab.5.1732783946148; Thu, 28 Nov 2024
 00:52:26 -0800 (PST)
Date: Thu, 28 Nov 2024 00:52:26 -0800
In-Reply-To: <000000000000782b4706210a8dcd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67482f4a.050a0220.253251.0078.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] BUG: corrupted list in mgmt_pending_remove
From: syzbot <syzbot+cc0cc52e7f43dc9e6df1@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    5dfd7d940094 Merge branch 'bnxt_en-bug-fixes'
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=15a68f78580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=83e9a7f9e94ea674
dashboard link: https://syzkaller.appspot.com/bug?extid=cc0cc52e7f43dc9e6df1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=144ef530580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c5ef5f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f4aa5ee37bd1/disk-5dfd7d94.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d403277896b8/vmlinux-5dfd7d94.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8ac17fc5f4ae/bzImage-5dfd7d94.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cc0cc52e7f43dc9e6df1@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __list_del_entry_valid_or_report+0x2f/0x140 lib/list_debug.c:49
Read of size 8 at addr ffff8881436c1888 by task kworker/u9:2/5853

CPU: 1 UID: 0 PID: 5853 Comm: kworker/u9:2 Not tainted 6.12.0-syzkaller-05517-g5dfd7d940094 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: hci0 hci_cmd_sync_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 __list_del_entry_valid_or_report+0x2f/0x140 lib/list_debug.c:49
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_del include/linux/list.h:229 [inline]
 mgmt_pending_remove+0x26/0x1a0 net/bluetooth/mgmt_util.c:314
 mgmt_remove_adv_monitor_complete+0x2bf/0x550 net/bluetooth/mgmt.c:5522
 hci_cmd_sync_work+0x280/0x400 net/bluetooth/hci_sync.c:334
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 6082:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:257 [inline]
 __kmalloc_cache_noprof+0x19c/0x2c0 mm/slub.c:4295
 kmalloc_noprof include/linux/slab.h:879 [inline]
 kzalloc_noprof include/linux/slab.h:1015 [inline]
 mgmt_pending_new+0x65/0x250 net/bluetooth/mgmt_util.c:269
 mgmt_pending_add+0x36/0x120 net/bluetooth/mgmt_util.c:296
 remove_adv_monitor+0x102/0x1b0 net/bluetooth/mgmt.c:5557
 hci_mgmt_cmd+0xc47/0x11d0 net/bluetooth/hci_sock.c:1712
 hci_sock_sendmsg+0x7b8/0x11c0 net/bluetooth/hci_sock.c:1832
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:726
 sock_write_iter+0x2d7/0x3f0 net/socket.c:1147
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:679
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6085:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2342 [inline]
 slab_free mm/slub.c:4579 [inline]
 kfree+0x1a0/0x440 mm/slub.c:4727
 mgmt_pending_foreach+0xd1/0x130 net/bluetooth/mgmt_util.c:259
 mgmt_index_removed+0x133/0x390 net/bluetooth/mgmt.c:9467
 hci_sock_bind+0xcce/0x1150 net/bluetooth/hci_sock.c:1307
 __sys_bind_socket net/socket.c:1827 [inline]
 __sys_bind+0x1e4/0x290 net/socket.c:1858
 __do_sys_bind net/socket.c:1863 [inline]
 __se_sys_bind net/socket.c:1861 [inline]
 __x64_sys_bind+0x7a/0x90 net/socket.c:1861
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8881436c1880
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 8 bytes inside of
 freed 96-byte region [ffff8881436c1880, ffff8881436c18e0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1436c1
flags: 0x57ff00000000000(node=1|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 057ff00000000000 ffff88801b041280 dead000000000100 dead000000000122
raw: 0000000000000000 0000000080200020 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1, tgid 1 (swapper/0), ts 3012747150, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x3649/0x3790 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x140 mm/slub.c:2412
 allocate_slab+0x5a/0x2f0 mm/slub.c:2578
 new_slab mm/slub.c:2631 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3818
 __slab_alloc+0x58/0xa0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 __kmalloc_cache_noprof+0x1d5/0x2c0 mm/slub.c:4290
 kmalloc_noprof include/linux/slab.h:879 [inline]
 kzalloc_noprof include/linux/slab.h:1015 [inline]
 acpi_ut_evaluate_object+0x108/0x4a0 drivers/acpi/acpica/uteval.c:50
 acpi_ut_execute_HID+0xbf/0x3f0 drivers/acpi/acpica/utids.c:45
 acpi_get_object_info+0x328/0x1220 drivers/acpi/acpica/nsxfname.c:288
 acpi_set_pnp_ids drivers/acpi/scan.c:1410 [inline]
 acpi_init_device_object+0xbeb/0x31a0 drivers/acpi/scan.c:1829
 acpi_add_single_object+0x106/0x1e00 drivers/acpi/scan.c:1880
 acpi_bus_check_add+0x32b/0x980 drivers/acpi/scan.c:2181
 acpi_ns_walk_namespace+0x294/0x4f0
page_owner free stack trace missing

Memory state around the buggy address:
 ffff8881436c1780: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff8881436c1800: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>ffff8881436c1880: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                      ^
 ffff8881436c1900: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff8881436c1980: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

