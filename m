Return-Path: <linux-kernel+bounces-436699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0161F9E898A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 04:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4C221885F03
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 03:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01D81552EB;
	Mon,  9 Dec 2024 03:32:26 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738A474068
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 03:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733715146; cv=none; b=SqRxQWdIfVKB8h8TDlPJ4kDS7bXcKLD+kh7CHXso7UQJ+D8FkIoAIIXu2ld8w34rHEFU8jVobJBU7Jt7bJCrJPzR5Lr7rIhP8ZkRWUk9jPOfUHWdRqH9W/FXRrvsLb/3xeLVDnsw2n1pYEECgirFSvEkBeFidRvHwmzERZ5F/Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733715146; c=relaxed/simple;
	bh=/Q5cdUi3WQix6Y9InGstQ7/7AXRI2R063qfAgEYNq+4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=N+h1c3KQm4jTdM9ATV0ExbsGCY3hkwzcbtfWrTqMlluebUYdlYrLTTJ5gFuRdbuddM+TZZHv8SYwuNaK/CfqoqFplUhQOQeS+fdrcMrB3s5BQZgmIxIpftMqVzHiDkAwgWeF+ZzYZrJdyo8tyf2ztaw/M5KQxvSIe2A9tNuGtVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a7cf41b54eso79844625ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 19:32:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733715143; x=1734319943;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NeWZ1nDjK+1bPDNgbcwdmwgciUCjZI5S1RGJZlH8H+8=;
        b=XH+EunXFKFp+s5mb37lT4CWGbo1EO6wyKiF1+aokbtjvnT26+XbvFwao2v2E0S8VO0
         NDZBSCpWnYEvt/Ys5w11/AXGKumyn61+q+/CzPjYZgSNdUk4DuMNc0BB75R2bCyTHmWr
         mQ4at4/KVlPS6GloxNKsBZGk1MPv1WQZ7FHvmg/AfyAfNRgd72nxE9nDGY8NE84TxOI8
         zLf+4r/h3kzrUWDfnJe6HLs11bYP20QSLD5i7B00BD0S/quOAoUsGq3ZJYQXOdOODOw9
         El4b+aKdETAfJGI7Te3YnY8QvIWz0vuSNdokCg8WHATZ8DNRmVuiiD8shLneDhKO2nFQ
         ZFNQ==
X-Gm-Message-State: AOJu0YzQKwlTUf354BoAnJ6YYlOYSrxUkbmyl3tQda+xvw0gVov9xySs
	huIOBmQN4U8/ZaGp5IVa4zgmEAI6jiaOoal9BpABam7423w8FJ3wmc5ZRfq9MIvUif4W4u+oVrC
	3O1B3FEuhEqbnaYHB+9rBZJiHlIwyDZhvoCa5aA8AiqiHkkdjnIKslWrDOg==
X-Google-Smtp-Source: AGHT+IHhqUjSs8ASGBIgF76f9/MxAyMoE6Kte++sPVRKs+DwErSprh3W4s6DNiz3xvt2bAU8hn4gi4x+eM+hXI88DZGrggFuVi6T
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1386:b0:3a7:956c:61a4 with SMTP id
 e9e14a558f8ab-3a811db6322mr98193835ab.10.1733715143675; Sun, 08 Dec 2024
 19:32:23 -0800 (PST)
Date: Sun, 08 Dec 2024 19:32:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675664c7.050a0220.a30f1.018c.GAE@google.com>
Subject: [syzbot] [sound?] WARNING in snd_ctl_led_register
From: syzbot <syzbot+4e7919b09c67ffd198ae@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, perex@perex.cz, 
	syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    feffde684ac2 Merge tag 'for-6.13-rc1-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15ffe0f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50c7a61469ce77e7
dashboard link: https://syzkaller.appspot.com/bug?extid=4e7919b09c67ffd198ae
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-feffde68.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6135c7297e8e/vmlinux-feffde68.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6c154fdcc9cb/bzImage-feffde68.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4e7919b09c67ffd198ae@syzkaller.appspotmail.com

usb 5-1: Quirk or no altset; falling back to MIDI 1.0
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 1
CPU: 0 UID: 0 PID: 5314 Comm: syz.0.0 Not tainted 6.13.0-rc1-syzkaller-00025-gfeffde684ac2 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 fail_dump lib/fault-inject.c:53 [inline]
 should_fail_ex+0x3b0/0x4e0 lib/fault-inject.c:154
 should_failslab+0xac/0x100 mm/failslab.c:46
 slab_pre_alloc_hook mm/slub.c:4057 [inline]
 slab_alloc_node mm/slub.c:4133 [inline]
 __do_kmalloc_node mm/slub.c:4282 [inline]
 __kmalloc_node_track_caller_noprof+0xdc/0x4c0 mm/slub.c:4302
 __kmemdup_nul mm/util.c:61 [inline]
 kstrdup+0x39/0xb0 mm/util.c:81
 __kernfs_new_node+0x9d/0x870 fs/kernfs/dir.c:620
 kernfs_new_node+0x137/0x240 fs/kernfs/dir.c:700
 kernfs_create_link+0xa5/0x1f0 fs/kernfs/symlink.c:39
 sysfs_do_create_link_sd+0x85/0x110 fs/sysfs/symlink.c:44
 snd_ctl_led_sysfs_add sound/core/control_led.c:671 [inline]
 snd_ctl_led_register+0x5a2/0x8c0 sound/core/control_led.c:347
 snd_ctl_dev_register+0xcb/0x140 sound/core/control.c:2300
 __snd_device_register sound/core/device.c:149 [inline]
 snd_device_register_all+0xc9/0x1a0 sound/core/device.c:197
 snd_card_register+0x1d9/0x6e0 sound/core/init.c:895
 try_to_register_card+0x2f9/0x3d0 sound/usb/card.c:766
 usb_audio_probe+0x1ae2/0x2100 sound/usb/card.c:931
 usb_probe_interface+0x641/0xbb0 drivers/usb/core/driver.c:396
 really_probe+0x2b8/0xad0 drivers/base/dd.c:658
 __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:800
 driver_probe_device+0x50/0x430 drivers/base/dd.c:830
 __device_attach_driver+0x2d6/0x530 drivers/base/dd.c:958
 bus_for_each_drv+0x24e/0x2e0 drivers/base/bus.c:459
 __device_attach+0x333/0x520 drivers/base/dd.c:1030
 proc_ioctl+0x463/0x650 drivers/usb/core/devio.c:2368
 usbdev_ioctl+0x2cf8/0x6120 drivers/usb/core/devio.c:2827
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8215d7ff19
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8216ad8058 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f8215f45fa0 RCX: 00007f8215d7ff19
RDX: 0000000020000200 RSI: 00000000c0105512 RDI: 0000000000000004
RBP: 00007f8216ad80a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 0000000000000000 R14: 00007f8215f45fa0 R15: 00007fff8889e228
 </TASK>
------------[ cut here ]------------
can't create symlink to controlC3 device
WARNING: CPU: 0 PID: 5314 at sound/core/control_led.c:672 snd_ctl_led_sysfs_add sound/core/control_led.c:671 [inline]
WARNING: CPU: 0 PID: 5314 at sound/core/control_led.c:672 snd_ctl_led_register+0x6b6/0x8c0 sound/core/control_led.c:347
Modules linked in:
CPU: 0 UID: 0 PID: 5314 Comm: syz.0.0 Not tainted 6.13.0-rc1-syzkaller-00025-gfeffde684ac2 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:snd_ctl_led_sysfs_add sound/core/control_led.c:671 [inline]
RIP: 0010:snd_ctl_led_register+0x6b6/0x8c0 sound/core/control_led.c:347
Code: b8 00 00 00 00 00 fc ff df 48 8b 4c 24 28 0f b6 04 01 84 c0 0f 85 01 01 00 00 41 8b 37 48 c7 c7 c0 76 00 8d e8 3b fc 0e f8 90 <0f> 0b 90 90 e9 fb fe ff ff e8 dc 54 4e f8 90 48 b8 00 00 00 00 00
RSP: 0018:ffffc9000d506ec0 EFLAGS: 00010246
RAX: 65b6d429077b2500 RBX: 00000000fffffff4 RCX: ffff888000a64880
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc9000d506fd0 R08: ffffffff81601c02 R09: fffffbfff1cfa210
R10: dffffc0000000000 R11: fffffbfff1cfa210 R12: ffff88801e30c1b0
R13: ffff888012157000 R14: 0000000000000001 R15: ffff88801e30c000
FS:  00007f8216ad86c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000557104264490 CR3: 0000000043c40000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 snd_ctl_dev_register+0xcb/0x140 sound/core/control.c:2300
 __snd_device_register sound/core/device.c:149 [inline]
 snd_device_register_all+0xc9/0x1a0 sound/core/device.c:197
 snd_card_register+0x1d9/0x6e0 sound/core/init.c:895
 try_to_register_card+0x2f9/0x3d0 sound/usb/card.c:766
 usb_audio_probe+0x1ae2/0x2100 sound/usb/card.c:931
 usb_probe_interface+0x641/0xbb0 drivers/usb/core/driver.c:396
 really_probe+0x2b8/0xad0 drivers/base/dd.c:658
 __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:800
 driver_probe_device+0x50/0x430 drivers/base/dd.c:830
 __device_attach_driver+0x2d6/0x530 drivers/base/dd.c:958
 bus_for_each_drv+0x24e/0x2e0 drivers/base/bus.c:459
 __device_attach+0x333/0x520 drivers/base/dd.c:1030
 proc_ioctl+0x463/0x650 drivers/usb/core/devio.c:2368
 usbdev_ioctl+0x2cf8/0x6120 drivers/usb/core/devio.c:2827
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8215d7ff19
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8216ad8058 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f8215f45fa0 RCX: 00007f8215d7ff19
RDX: 0000000020000200 RSI: 00000000c0105512 RDI: 0000000000000004
RBP: 00007f8216ad80a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 0000000000000000 R14: 00007f8215f45fa0 R15: 00007fff8889e228
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

