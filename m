Return-Path: <linux-kernel+bounces-198611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 409AD8D7AFA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 07:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96243B219FA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 05:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D432135A;
	Mon,  3 Jun 2024 05:27:22 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BCC19F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 05:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717392441; cv=none; b=tINC+qgtJBg5WSnzKSKkzaXFxOB/QGdqjfOPAcp9pMG1gblckPbKE5FOWHoksAypiwHsMo/5hx6YXgQG7LloKXJ7zkcT2Bduhv6XD8ss3xJvAE6ag/1M89/urlWBLNyXULDLbivL7PPc6/ex/zTLQXqLMcj8sDv3Xz/iCA5KakM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717392441; c=relaxed/simple;
	bh=dZY4QtqmpNCJm010A7q8C7WI1+KMr19iGiuAZoDVQhA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=IRHMlJlltYit4ysIxrivOB8p/0cp6fFT4VKJHuUSpkGbJ/i/FFnsOQKdeSMhN261o3va5KjbMF0JxG7lYrDJvLE0Rp2MjvmyRCCBo4AbRsvD/aZ+EHStDwPgnKpvMj+BfbEFSyybOKGxPnoCx/iovHr3yjgyN0jLt4pHB3HJ22E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-374914d7836so17591955ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 22:27:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717392439; x=1717997239;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SpN0VCg3ODxSv0BljhMZAMpv0wCsUBGfYbN1gVZocoQ=;
        b=NWDQjqpA8DnTpepf2xhXK5+Ei65mDTMkmXRzPiQ6Pt6trS+7kYBdlkDH0G556799ed
         W1V6MJzH+wugCNKDqOd7Lmnl/N2M5uWMjDXbVMFR1LFSHAv9cnORUzBSApABqggwlGtu
         Uk09bUV4GB9eGxzm5vBeHLRzU3MphXw1Q3GJfjLxq02wCh9HpfVTt7Ss10xy+5CLUItk
         M5M5lfBkQ81j9Grfk896eiLc4kafIIgVMnkZBSos55tpl0XnoGik1k0NDBJm7bo2BaJK
         duqeQCCWXNcMaQxFCfw60vf5YINVstSPG0X/3qSksCdrGwtC47eq3J6hb0Ej/44ullam
         3SFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWm4Vm3e8MzLriidYB+af5JIxu7h/Q15j3fGed2zNt2ifAh0pun8sGfiGHY2p2qglb96baUKaaowcZtM3yJwIbXVrYEohebF/JVlkci
X-Gm-Message-State: AOJu0YyPJoA1EYgqW7T8CqLkR0NCWmzm6XWgyx2o23WZpoIIb+pZFl4e
	RvoHuqy2PN44tESS4w9T2EBQ1N7bzOGpKJusysGc1XYp1rxqsXdMLLLF/mctTLUCx1wsezhn558
	IopkgRgf5fjrT/18I4R4NOaygloeBGSIP5e9O5Zpmr61LohrutpRoNbU=
X-Google-Smtp-Source: AGHT+IEZ5R+Y976o5RaCchwXLxbGBKJa/fb3nsrzth5SMitsCfs4m3tcqwsKdkwemowUvbR+ZkRiPoD0bRw+vvsPjmyeiccDKFzf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d93:b0:374:a422:bb7 with SMTP id
 e9e14a558f8ab-374a4220f54mr170915ab.2.1717392439026; Sun, 02 Jun 2024
 22:27:19 -0700 (PDT)
Date: Sun, 02 Jun 2024 22:27:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000044b63c0619f5960d@google.com>
Subject: [syzbot] [hwmon?] kernel panic: corrupted stack end in hub_event (3)
From: syzbot <syzbot+fda41ea3324f13031be5@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jdelvare@suse.com, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux@roeck-us.net, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1613e604df0c Linux 6.10-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=12338b3c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=71e27a66e3476b52
dashboard link: https://syzkaller.appspot.com/bug?extid=fda41ea3324f13031be5
compiler:       riscv64-linux-gnu-gcc (Debian 12.2.0-13) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: riscv64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/a741b348759c/non_bootable_disk-1613e604.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e531dbb975b3/vmlinux-1613e604.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f0f763ab94b0/Image-1613e604.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fda41ea3324f13031be5@syzkaller.appspotmail.com

microsoft 0003:045E:07DA.0005: unknown main item tag 0x0
microsoft 0003:045E:07DA.0005: unknown main item tag 0x0
microsoft 0003:045E:07DA.0005: unknown main item tag 0x0
microsoft 0003:045E:07DA.0005: unknown main item tag 0x0
Kernel panic - not syncing: corrupted stack end detected inside scheduler
CPU: 0 PID: 16261 Comm: kworker/0:2 Not tainted 6.10.0-rc1-syzkaller-g1613e604df0c #0
Hardware name: riscv-virtio,qemu (DT)
Workqueue: usb_hub_wq hub_event
Call Trace:
[<ffffffff8000f6f8>] dump_backtrace+0x2e/0x3c arch/riscv/kernel/stacktrace.c:129
[<ffffffff85c29e7c>] show_stack+0x34/0x40 arch/riscv/kernel/stacktrace.c:135
[<ffffffff85c83b6a>] __dump_stack lib/dump_stack.c:88 [inline]
[<ffffffff85c83b6a>] dump_stack_lvl+0x108/0x196 lib/dump_stack.c:114
[<ffffffff85c83c14>] dump_stack+0x1c/0x24 lib/dump_stack.c:123
[<ffffffff85c2aa42>] panic+0x382/0x800 kernel/panic.c:347
[<ffffffff85c92b18>] schedule_debug kernel/sched/core.c:5962 [inline]
[<ffffffff85c92b18>] __schedule+0x342e/0x3486 kernel/sched/core.c:6628
[<ffffffff85c930cc>] preempt_schedule_common kernel/sched/core.c:6924 [inline]
[<ffffffff85c930cc>] preempt_schedule+0xd2/0x1e2 kernel/sched/core.c:6948
[<ffffffff80c0afdc>] idr_preload_end include/linux/idr.h:174 [inline]
[<ffffffff80c0afdc>] __kernfs_new_node+0x7ac/0x8ee fs/kernfs/dir.c:636
[<ffffffff80c0f740>] kernfs_new_node+0x14e/0x200 fs/kernfs/dir.c:700
[<ffffffff80c10aa2>] kernfs_create_dir_ns+0x3e/0x172 fs/kernfs/dir.c:1061
[<ffffffff80c1a1bc>] sysfs_create_dir_ns+0x132/0x276 fs/sysfs/dir.c:59
[<ffffffff85baa520>] create_dir lib/kobject.c:73 [inline]
[<ffffffff85baa520>] kobject_add_internal+0x26c/0x8aa lib/kobject.c:240
[<ffffffff85bab7c2>] kobject_add_varg lib/kobject.c:374 [inline]
[<ffffffff85bab7c2>] kobject_add+0x12e/0x1ea lib/kobject.c:426
[<ffffffff8272744c>] class_dir_create_and_add drivers/base/core.c:3264 [inline]
[<ffffffff8272744c>] get_device_parent+0x340/0x45c drivers/base/core.c:3315
[<ffffffff8272d234>] device_add+0x1b0/0x181a drivers/base/core.c:3645
[<ffffffff83ae7f46>] __power_supply_register+0x96a/0x12c6 drivers/power/supply/power_supply_core.c:1418
[<ffffffff83ae88ca>] power_supply_register+0x28/0x36 drivers/power/supply/power_supply_core.c:1488
[<ffffffff8425b596>] hidinput_setup_battery.isra.0+0x5be/0xb16 drivers/hid/hid-input.c:589
[<ffffffff84260a08>] hidinput_configure_usage drivers/hid/hid-input.c:993 [inline]
[<ffffffff84260a08>] hidinput_configure_usages drivers/hid/hid-input.c:2267 [inline]
[<ffffffff84260a08>] hidinput_connect+0x2f9c/0x8ce0 drivers/hid/hid-input.c:2334
[<ffffffff84253a5e>] hid_connect+0x126a/0x16be drivers/hid/hid-core.c:2194
[<ffffffff84253f68>] hid_hw_start drivers/hid/hid-core.c:2309 [inline]
[<ffffffff84253f68>] hid_hw_start+0xb6/0x13c drivers/hid/hid-core.c:2300
[<ffffffff842deb40>] ms_probe+0x15e/0x4f2 drivers/hid/hid-microsoft.c:391
[<ffffffff84254616>] __hid_device_probe drivers/hid/hid-core.c:2633 [inline]
[<ffffffff84254616>] hid_device_probe+0x2a4/0x3f2 drivers/hid/hid-core.c:2670
[<ffffffff827382e2>] call_driver_probe drivers/base/dd.c:578 [inline]
[<ffffffff827382e2>] really_probe+0x232/0x9be drivers/base/dd.c:656
[<ffffffff82738c42>] __driver_probe_device+0x1d4/0x3f2 drivers/base/dd.c:798
[<ffffffff82738ec0>] driver_probe_device+0x60/0x1ce drivers/base/dd.c:828
[<ffffffff82739210>] __device_attach_driver+0x1e2/0x2fc drivers/base/dd.c:956
[<ffffffff82732b4e>] bus_for_each_drv+0x142/0x1da drivers/base/bus.c:457
[<ffffffff82739e32>] __device_attach+0x1c4/0x462 drivers/base/dd.c:1028
[<ffffffff8273a458>] device_initial_probe+0x1c/0x26 drivers/base/dd.c:1077
[<ffffffff827355d0>] bus_probe_device+0x15c/0x192 drivers/base/bus.c:532
[<ffffffff8272e15c>] device_add+0x10d8/0x181a drivers/base/core.c:3721
[<ffffffff8424d8b6>] hid_add_device+0x374/0x9d8 drivers/hid/hid-core.c:2816
[<ffffffff843a0728>] usbhid_probe+0xa52/0xf86 drivers/hid/usbhid/hid-core.c:1429
[<ffffffff832d8336>] usb_probe_interface+0x2d8/0x8c6 drivers/usb/core/driver.c:399
[<ffffffff827382e2>] call_driver_probe drivers/base/dd.c:578 [inline]
[<ffffffff827382e2>] really_probe+0x232/0x9be drivers/base/dd.c:656
[<ffffffff82738c42>] __driver_probe_device+0x1d4/0x3f2 drivers/base/dd.c:798
[<ffffffff82738ec0>] driver_probe_device+0x60/0x1ce drivers/base/dd.c:828
[<ffffffff82739210>] __device_attach_driver+0x1e2/0x2fc drivers/base/dd.c:956
[<ffffffff82732b4e>] bus_for_each_drv+0x142/0x1da drivers/base/bus.c:457
[<ffffffff82739e32>] __device_attach+0x1c4/0x462 drivers/base/dd.c:1028
[<ffffffff8273a458>] device_initial_probe+0x1c/0x26 drivers/base/dd.c:1077
[<ffffffff827355d0>] bus_probe_device+0x15c/0x192 drivers/base/bus.c:532
[<ffffffff8272e15c>] device_add+0x10d8/0x181a drivers/base/core.c:3721
[<ffffffff832d1c6c>] usb_set_configuration+0xf08/0x19dc drivers/usb/core/message.c:2210
[<ffffffff832f9692>] usb_generic_driver_probe+0xae/0x128 drivers/usb/core/generic.c:254
[<ffffffff832d3906>] usb_probe_device+0xd6/0x360 drivers/usb/core/driver.c:294
[<ffffffff827382e2>] call_driver_probe drivers/base/dd.c:578 [inline]
[<ffffffff827382e2>] really_probe+0x232/0x9be drivers/base/dd.c:656
[<ffffffff82738c42>] __driver_probe_device+0x1d4/0x3f2 drivers/base/dd.c:798
[<ffffffff82738ec0>] driver_probe_device+0x60/0x1ce drivers/base/dd.c:828
[<ffffffff82739210>] __device_attach_driver+0x1e2/0x2fc drivers/base/dd.c:956
[<ffffffff82732b4e>] bus_for_each_drv+0x142/0x1da drivers/base/bus.c:457
[<ffffffff82739e32>] __device_attach+0x1c4/0x462 drivers/base/dd.c:1028
[<ffffffff8273a458>] device_initial_probe+0x1c/0x26 drivers/base/dd.c:1077
[<ffffffff827355d0>] bus_probe_device+0x15c/0x192 drivers/base/bus.c:532
[<ffffffff8272e15c>] device_add+0x10d8/0x181a drivers/base/core.c:3721
[<ffffffff832ad9fa>] usb_new_device+0x960/0x1750 drivers/usb/core/hub.c:2651
[<ffffffff832b4022>] hub_port_connect drivers/usb/core/hub.c:5521 [inline]
[<ffffffff832b4022>] hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
[<ffffffff832b4022>] port_event drivers/usb/core/hub.c:5821 [inline]
[<ffffffff832b4022>] hub_event+0x2a2a/0x4a5c drivers/usb/core/hub.c:5903
[<ffffffff8012d1ea>] process_one_work+0x938/0x1d5c kernel/workqueue.c:3231
[<ffffffff8012ebcc>] process_scheduled_works kernel/workqueue.c:3312 [inline]
[<ffffffff8012ebcc>] worker_thread+0x5be/0xe24 kernel/workqueue.c:3393
[<ffffffff8014d7b4>] kthread+0x28c/0x3a6 kernel/kthread.c:389
[<ffffffff85ca884e>] ret_from_fork+0xe/0x1c arch/riscv/kernel/entry.S:232
SMP: stopping secondary CPUs
Rebooting in 86400 seconds..


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

