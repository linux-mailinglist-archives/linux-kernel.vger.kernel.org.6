Return-Path: <linux-kernel+bounces-260843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5F893AF34
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 11:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 422EB281D2A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951CD153BF7;
	Wed, 24 Jul 2024 09:45:34 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B1F14375C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 09:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721814334; cv=none; b=kFchdaW8zGuhaOYG9EFBTyQRbqGfnD3JbUxJIK1KCvl3lYNimo4729uhRdaIr4m1Bk0bW3u6xP1ZoWnIP/7Gr2bJqlZ7woQwg7MZPgTW4mwH+QIwBmeBKTl7kO/FwjU7Lt3tCvXNvUUZeU3LGDTZTKvA3FFy3mKcLSyl5vZ5rww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721814334; c=relaxed/simple;
	bh=8aIzCYRwOwUmw7oJDrQawrCy2E4NZiRH5To/4q/eZ7o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=n4g2RTyenZU3WO2KN/DlIu78veYVYPjIiPhnk0EzpTzdchTQb/vjHMLmgkA/yVWvG5+9LoiG//zLJ3rvbAeKyOVamGMew+fk6dwF2Gk+MM+XnyxPcdW5heKJjlxuR4pyoydOTiJze58+5ssOTyM0rhRxr4ICU/V4CSDr2L+5Fao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8051524c1f8so1099923339f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 02:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721814330; x=1722419130;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NmjwqPYMuxNEReWWJcD819IG0ZMFeKoGBsrLFK1PRkw=;
        b=Qwwk7MXPUzV4ORN+HoBVKffwpQKyDrNjFxLOtIKWmJXKioHFHn7lhpaALJfo750kTo
         nrDAbgR1iwPLmYVfglTStQat5+CJOoRzuPBl2xgRea8dTvELnfyeZEs5WZEwFJPLcDzu
         n8u2MletUP3H0VbYLODXtKydEwnP93gAGZfSn6fjpPbHNKa7IpR4bWiYXu3z13iC0GLC
         +MBax32jEccJqZR9mi6EuqWPBp1MEyi7KdYGXOEgKPrF/bpl+lEg/fjtAfCvubI8uNDF
         W9JMxxlcR4X5O6+rERm1zazu5FAEYr3o6ZTyb6pjCqLDrSrV4SV5vEpYDiG2UvVPR2vx
         G7kA==
X-Forwarded-Encrypted: i=1; AJvYcCWhwSK8GouU8j5zD/cCV8Y1YcvfAgVB3a3jjcSuMIL0YtrLaA2FNWOej613hcFNnBws3vugYylFbSnmi03bVsVpXWs/PhEVA7kRk5rO
X-Gm-Message-State: AOJu0YwQMeGIV5PqD+KmPqhNL8JnchNXzFSkkwhc0SYpAq+eOLdqBucz
	o/ztyN7l5K/zlN/hrFs8gLdB+yo8YfDa/g5j4uq+9C6t2baUqxqET+/qeRGsyv+w7eluB5jRpwy
	P24icdpdBU5PoWASCRswFpGkJv8pVNu1naPpirh4G3xJttGq2Xydewqs=
X-Google-Smtp-Source: AGHT+IFAeJUUCi3HUf81q73de8KuPKXwfZE7HIKneTn6/Mi9PKXcNTrWecSm8l8GULMLURZNNZJcKO5Kx9pltl9cyip2jWbbUxvu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a2:b0:381:b873:306b with SMTP id
 e9e14a558f8ab-39a1971a320mr1196995ab.6.1721814330487; Wed, 24 Jul 2024
 02:45:30 -0700 (PDT)
Date: Wed, 24 Jul 2024 02:45:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000089c945061dfb23e4@google.com>
Subject: [syzbot] [input?] [mm?] WARNING in get_taint
From: syzbot <syzbot+a34cc64ce2f703da7c62@syzkaller.appspotmail.com>
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    933069701c1b Merge tag '6.11-rc-smb3-server-fixes' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16a3dcb1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e5bbfd9a8c60696e
dashboard link: https://syzkaller.appspot.com/bug?extid=a34cc64ce2f703da7c62
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=119babfd980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c02411980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/8ead8862021c/non_bootable_disk-93306970.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/662be7a678a5/vmlinux-93306970.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1fc4540c602b/zImage-93306970.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a34cc64ce2f703da7c62@syzkaller.appspotmail.com

WARNING: CPU: 0 PID: 3006 at mm/page_alloc.c:4672 __alloc_pages_noprof+0xfbc/0x1170 mm/page_alloc.c:4672
Modules linked in:
Kernel panic - not syncing: kernel: panic_on_warn set ...
CPU: 0 UID: 0 PID: 3006 Comm: syz-executor872 Not tainted 6.10.0-syzkaller #0
Hardware name: ARM-Versatile Express
Call trace: 
[<818ef10c>] (dump_backtrace) from [<818ef208>] (show_stack+0x18/0x1c arch/arm/kernel/traps.c:257)
 r7:00000000 r6:82622804 r5:00000000 r4:81feb1a4
[<818ef1f0>] (show_stack) from [<8190c848>] (__dump_stack lib/dump_stack.c:93 [inline])
[<818ef1f0>] (show_stack) from [<8190c848>] (dump_stack_lvl+0x54/0x7c lib/dump_stack.c:119)
[<8190c7f4>] (dump_stack_lvl) from [<8190c888>] (dump_stack+0x18/0x1c lib/dump_stack.c:128)
 r5:00000000 r4:82863d0c
[<8190c870>] (dump_stack) from [<818efcb0>] (panic+0x120/0x358 kernel/panic.c:348)
[<818efb90>] (panic) from [<80241f4c>] (check_panic_on_warn kernel/panic.c:241 [inline])
[<818efb90>] (panic) from [<80241f4c>] (get_taint+0x0/0x1c kernel/panic.c:236)
 r3:8260c5c4 r2:00000001 r1:81fd3dfc r0:81fdb810
 r7:804b3e38
[<80241ed8>] (check_panic_on_warn) from [<802420a0>] (__warn+0x7c/0x180 kernel/panic.c:735)
[<80242024>] (__warn) from [<8024231c>] (warn_slowpath_fmt+0x178/0x1f4 kernel/panic.c:760)
 r8:00000009 r7:8200455c r6:df979c24 r5:841c3c00 r4:00000000
[<802421a8>] (warn_slowpath_fmt) from [<804b3e38>] (__alloc_pages_noprof+0xfbc/0x1170 mm/page_alloc.c:4672)
 r10:00000014 r9:840b0204 r8:ffffffff r7:841c3c00 r6:00000dc0 r5:00000000
 r4:00000000
[<804b2e7c>] (__alloc_pages_noprof) from [<804b8f38>] (__alloc_pages_node_noprof include/linux/gfp.h:269 [inline])
[<804b2e7c>] (__alloc_pages_noprof) from [<804b8f38>] (alloc_pages_node_noprof include/linux/gfp.h:296 [inline])
[<804b2e7c>] (__alloc_pages_noprof) from [<804b8f38>] (___kmalloc_large_node+0x50/0xac mm/slub.c:4103)
 r10:841c3c00 r9:840b0204 r8:ffffffff r7:804c0de8 r6:00000dc0 r5:00000000
 r4:00000014
[<804b8ee8>] (___kmalloc_large_node) from [<804b9b10>] (__kmalloc_large_node_noprof+0x24/0x114 mm/slub.c:4130)
 r7:804c0de8 r6:00000dc0 r5:ffffffff r4:80000002
[<804b9aec>] (__kmalloc_large_node_noprof) from [<804c0de8>] (__do_kmalloc_node mm/slub.c:4146 [inline])
[<804b9aec>] (__kmalloc_large_node_noprof) from [<804c0de8>] (__kmalloc_noprof+0x324/0x458 mm/slub.c:4170)
 r10:841c3c00 r9:840b0204 r8:841c3c00 r7:00000dc0 r6:84191400 r5:ffffffff
 r4:80000002
[<804c0ac4>] (__kmalloc_noprof) from [<80f696ec>] (kmalloc_noprof include/linux/slab.h:685 [inline])
[<804c0ac4>] (__kmalloc_noprof) from [<80f696ec>] (kzalloc_noprof include/linux/slab.h:807 [inline])
[<804c0ac4>] (__kmalloc_noprof) from [<80f696ec>] (input_mt_init_slots+0x60/0x1f0 drivers/input/input-mt.c:50)
 r10:841c3c00 r9:840b0204 r8:00000000 r7:00000000 r6:84191400 r5:00000000
 r4:80000002
[<80f6968c>] (input_mt_init_slots) from [<80f98f28>] (uinput_create_device drivers/input/misc/uinput.c:328 [inline])
[<80f6968c>] (input_mt_init_slots) from [<80f98f28>] (uinput_ioctl_handler+0x9c0/0xc54 drivers/input/misc/uinput.c:904)
 r8:00000000 r7:00000000 r6:840b0200 r5:00000000 r4:84191400
[<80f98568>] (uinput_ioctl_handler) from [<80f991d0>] (uinput_ioctl+0x14/0x18 drivers/input/misc/uinput.c:1075)
 r9:00000003 r8:83f446c0 r7:00000000 r6:83f446c0 r5:00000000 r4:00005501
[<80f991bc>] (uinput_ioctl) from [<8051a210>] (vfs_ioctl fs/ioctl.c:51 [inline])
[<80f991bc>] (uinput_ioctl) from [<8051a210>] (do_vfs_ioctl fs/ioctl.c:861 [inline])
[<80f991bc>] (uinput_ioctl) from [<8051a210>] (__do_sys_ioctl fs/ioctl.c:905 [inline])
[<80f991bc>] (uinput_ioctl) from [<8051a210>] (sys_ioctl+0x134/0xda4 fs/ioctl.c:893)
[<8051a0dc>] (sys_ioctl) from [<80200060>] (ret_fast_syscall+0x0/0x1c arch/arm/mm/proc-v7.S:67)
Exception stack(0xdf979fa8 to 0xdf979ff0)
9fa0:                   ffffffff 00000000 00000003 00005501 00000000 00000000
9fc0: ffffffff 00000000 0008e050 00000036 7ef58e0c 00000000 000f4240 00000000
9fe0: 7ef58c70 7ef58c60 00010abc 0002ec20
 r10:00000036 r9:841c3c00 r8:8020029c r7:00000036 r6:0008e050 r5:00000000
 r4:ffffffff
Rebooting in 86400 seconds..


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

