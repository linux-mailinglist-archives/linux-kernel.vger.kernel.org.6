Return-Path: <linux-kernel+bounces-265656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E931393F414
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59460B21697
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A890266A7;
	Mon, 29 Jul 2024 11:32:27 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C727278B4E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 11:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722252746; cv=none; b=NEcjQBWJbwJwwP0GQsd4DlFHgGBWmyjdQpeTlUvCVmAjbKoVyC0QmSN64cDcvg/Eiama4bwIJC0bhnboxrNF1uOPeN1VEeh5CoNfXL3tx+uscGN2j/5J74Ij3S8ulNS/HxDqbmLkixG9/avwgV7vg8Rpww4omKmoQ4530bNXdTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722252746; c=relaxed/simple;
	bh=1bNUwri/WQxo+1sNHpJECynmdmRIv5WM37oJO34cM10=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qjwhjWF5ZRIYwao9vUT0q7Kfl3662IP6VGBeh9x331cg4hikCgP/fbXIa7grQm8aCnfUzSaVuFIK/9DtdFI/AZeuqHUIBlZVEsdhDi1MXcRvcUekwjVliTMRcBCtmqMoZdJ9+bTBBYfm8aM3VyoPN1wydq8pd37mrEnHDAZSJho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f81dcb634so511920639f.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 04:32:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722252744; x=1722857544;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J1WgmY2KiYa0imgAqxwXhCgf/if3njUDi1OcTyi7x/c=;
        b=opIAFM91xbIvfy1B5KCY8y0kHk22+0K3Yrll054w4xlhq//xgkRG6dGTJ+2NOHPPYN
         CoO4zN+1tPgMnW5BkYslvgElEhhjDamz9oSPvUP510VCqKJI97mSVR9AfUOvYk7pFlE5
         cwF9ws0kG378mcwcbfla+VGTDlqxtJtzVowXS3PN26Q8STvNXvSHwnYjfyie3RTO51Ls
         Hjcapo2sU5Ls25sn2gCW+QsgNnkmQMUqwmb21z9VTOz4iAGlZeO9GWt23Bjsngl2lEkU
         RPSWrQQ79M1qx92IwgKTBqR8TZ9bvTMr6pwuKBL7iqbRIYWvi2yC6aHMdXxjnw9oWrGX
         lN1g==
X-Forwarded-Encrypted: i=1; AJvYcCXFbLTFOVyiYPlQESFsF+SYeURlvKYe7Mkune+zow0P+QVMKQg7CUFlha8hrf9dtNWULSwUfGmLzxKc6JGF91VZYkknYDsFDBTEhb4Z
X-Gm-Message-State: AOJu0YwhjylZSXXh3IYvK8lqBKCWViAL0ZJdxRMIdJinTJCxJTwnB4cz
	70o65T+MLXZlqOgkZd4aMz2Cja0ZBgNtkGZyyJO7Jc8ufgPp/PtN/Ux6FNp8yOts+dwH0cormfK
	2NALDn5u0fNZ6HJqObUggsPZ/XeWXFW+qxKH0Q5OLRwq6l+eQdvjWDcs=
X-Google-Smtp-Source: AGHT+IEwWP808qu0K5Adb8Te/Sdz3k+mQyfaCqRNv/Dd24LqgezN2wQYpwzLEesSS+9rPjzsofcJX0deTcgiLfkaP6PhQgmmzZmX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:218a:b0:4c2:2ad5:bfd0 with SMTP id
 8926c6da1cb9f-4c634e1a788mr308191173.0.1722252743944; Mon, 29 Jul 2024
 04:32:23 -0700 (PDT)
Date: Mon, 29 Jul 2024 04:32:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000043dc4061e61370a@google.com>
Subject: [syzbot] [usb?] KASAN: slab-use-after-free Read in hdm_disconnect
From: syzbot <syzbot+916742d5d24f6c254761@syzkaller.appspotmail.com>
To: christian.gromm@microchip.com, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, parthiban.veerasooran@microchip.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    933069701c1b Merge tag '6.11-rc-smb3-server-fixes' of git:..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=10ad0075980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f828342678294017
dashboard link: https://syzkaller.appspot.com/bug?extid=916742d5d24f6c254761
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1467b055980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16849cbd980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/22dd51445d03/disk-93306970.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f85f111961d5/vmlinux-93306970.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7971b4814e87/bzImage-93306970.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+916742d5d24f6c254761@syzkaller.appspotmail.com

usb 1-1: New USB device found, idVendor=0424, idProduct=c001, bcdDevice=1c.8f
usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-1: config 0 descriptor??
usb 1-1: USB disconnect, device number 2
==================================================================
BUG: KASAN: slab-use-after-free in hdm_disconnect+0x227/0x250 drivers/most/most_usb.c:1125
Read of size 8 at addr ffff88811314d898 by task kworker/0:1/9

CPU: 0 UID: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.10.0-syzkaller-g933069701c1b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 hdm_disconnect+0x227/0x250 drivers/most/most_usb.c:1125
 usb_unbind_interface+0x1e8/0x970 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:568 [inline]
 device_remove+0x122/0x170 drivers/base/dd.c:560
 __device_release_driver drivers/base/dd.c:1270 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1293
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:574
 device_del+0x396/0x9f0 drivers/base/core.c:3868
 usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1418
 usb_disconnect+0x2e1/0x920 drivers/usb/core/hub.c:2304
 hub_port_connect drivers/usb/core/hub.c:5361 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x1be4/0x4f50 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf20 kernel/workqueue.c:3390
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 9:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x8f/0xa0 mm/kasan/common.c:387
 kmalloc_noprof include/linux/slab.h:681 [inline]
 kzalloc_noprof include/linux/slab.h:807 [inline]
 hdm_probe+0xb3/0x1880 drivers/most/most_usb.c:959
 usb_probe_interface+0x309/0x9d0 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:578 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:656
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:798
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:828
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:956
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1028
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:532
 device_add+0x114b/0x1a70 drivers/base/core.c:3679
 usb_set_configuration+0x10cb/0x1c50 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0xb1/0x110 drivers/usb/core/generic.c:254
 usb_probe_device+0xec/0x3e0 drivers/usb/core/driver.c:294
 call_driver_probe drivers/base/dd.c:578 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:656
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:798
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:828
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:956
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1028
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:532
 device_add+0x114b/0x1a70 drivers/base/core.c:3679
 usb_new_device+0xd90/0x1a10 drivers/usb/core/hub.c:2651
 hub_port_connect drivers/usb/core/hub.c:5521 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x2e66/0x4f50 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf20 kernel/workqueue.c:3390
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 9:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
 __kasan_slab_free+0x14/0x30 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2252 [inline]
 slab_free mm/slub.c:4473 [inline]
 kfree+0x10b/0x380 mm/slub.c:4594
 device_release+0xa1/0x240 drivers/base/core.c:2581
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1fa/0x5b0 lib/kobject.c:737
 put_device drivers/base/core.c:3787 [inline]
 device_unregister+0x2f/0xc0 drivers/base/core.c:3910
 hdm_disconnect+0x10b/0x250 drivers/most/most_usb.c:1123
 usb_unbind_interface+0x1e8/0x970 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:568 [inline]
 device_remove+0x122/0x170 drivers/base/dd.c:560
 __device_release_driver drivers/base/dd.c:1270 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1293
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:574
 device_del+0x396/0x9f0 drivers/base/core.c:3868
 usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1418
 usb_disconnect+0x2e1/0x920 drivers/usb/core/hub.c:2304
 hub_port_connect drivers/usb/core/hub.c:5361 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x1be4/0x4f50 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf20 kernel/workqueue.c:3390
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff88811314c000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 6296 bytes inside of
 freed 8192-byte region [ffff88811314c000, ffff88811314e000)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x113148
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x200000000000040(head|node=0|zone=2)
page_type: 0xfdffffff(slab)
raw: 0200000000000040 ffff888100042280 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000020002 00000001fdffffff 0000000000000000
head: 0200000000000040 ffff888100042280 dead000000000122 0000000000000000
head: 0000000000000000 0000000000020002 00000001fdffffff 0000000000000000
head: 0200000000000003 ffffea00044c5201 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 2644, tgid 2644 (syz-executor274), ts 44471884834, free_ts 39926477070
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1493
 prep_new_page mm/page_alloc.c:1501 [inline]
 get_page_from_freelist+0x1311/0x25f0 mm/page_alloc.c:3438
 __alloc_pages_noprof+0x21e/0x2290 mm/page_alloc.c:4696
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x4e/0xf0 mm/slub.c:2321
 allocate_slab mm/slub.c:2484 [inline]
 new_slab+0x84/0x260 mm/slub.c:2537
 ___slab_alloc+0xdac/0x1870 mm/slub.c:3723
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3813
 __slab_alloc_node mm/slub.c:3866 [inline]
 slab_alloc_node mm/slub.c:4025 [inline]
 __kmalloc_cache_noprof+0x27a/0x2c0 mm/slub.c:4184
 kmalloc_noprof include/linux/slab.h:681 [inline]
 audit_log_d_path+0xce/0x1e0 kernel/audit.c:2148
 dump_common_audit_data security/lsm_audit.c:250 [inline]
 common_lsm_audit+0x7bf/0x2220 security/lsm_audit.c:458
 slow_avc_audit+0x17d/0x210 security/selinux/avc.c:781
 avc_xperms_audit security/selinux/avc.c:427 [inline]
 avc_has_extended_perms+0x9c6/0xf90 security/selinux/avc.c:1087
 ioctl_has_perm.constprop.0.isra.0+0x2f0/0x470 security/selinux/hooks.c:3692
 selinux_file_ioctl+0x180/0x270 security/selinux/hooks.c:3740
 security_file_ioctl+0x75/0xc0 security/security.c:2791
 __do_sys_ioctl fs/ioctl.c:901 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0xbb/0x220 fs/ioctl.c:893
page last free pid 2505 tgid 2505 stack trace:
 create_dummy_stack mm/page_owner.c:94 [inline]
 register_dummy_stack+0x8a/0xd0 mm/page_owner.c:100
 init_page_owner+0x48/0xbe0 mm/page_owner.c:118
 invoke_init_callbacks mm/page_ext.c:148 [inline]
 page_ext_init+0x730/0xc40 mm/page_ext.c:507
 mm_core_init+0x202/0x240 mm/mm_init.c:2680

Memory state around the buggy address:
 ffff88811314d780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88811314d800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88811314d880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff88811314d900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88811314d980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

