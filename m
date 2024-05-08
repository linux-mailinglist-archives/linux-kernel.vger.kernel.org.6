Return-Path: <linux-kernel+bounces-172677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F2C8BF546
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 06:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0FFA28643B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 04:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F05C147;
	Wed,  8 May 2024 04:35:31 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F5B28F4
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 04:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715142931; cv=none; b=h33fDqRlYhjs8UnFZzsTzvbIW6MBa4Whg6GYU25mmrEFx1wJVX1h50k1fqTay/BN+dkVUjTKYzXlY4wlucs3Mk2w83sSt9YkTsyVrCdc6PGUQVH0LZc+SmO+eLHt6glIK6I+Qi2JEB4IgSmG08n6HAtRKdWD1qz9J1YH6NIv3Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715142931; c=relaxed/simple;
	bh=tBt3yhVHGb/4uGputKqfaz5VHh8s1DIkvoEMGayoy2g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=H3ftLw4WxiUwJ5GVvNUkMnglhW681YIKDFEl/FPMN1rKO3XLq6wwMT0KMjAXsSYMLtRdd/E7Nlu7V3NG3/H9U/M2z/sweRCIbUGvigOsycj6y6Meet+uhYCkemZNsy2tpikBFoLuxeCrax20b2NK7VtDGXBoQsPs8Q1x1ZSrJA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7ddf08e17e4so38035839f.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 21:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715142929; x=1715747729;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gYGJ+AKnJIy5eoNQymc74MUAHte87l6iG8qoHTBakjU=;
        b=F6zvj+ethee0enTke0NaQp6quQ5MmDp/JHX6PZYErgMw1QvE2LNk01G0XRFbba5LDP
         SsUrvy+AujkRuSeMGZQ31biijb86H24RHzMvPKBjo0BssLbw7AESsVkWjg1jO0DVUzPF
         +hDj1FAqBsrnxXha8C4hHxjQ2M/MGbo+Ves29aWBkoIm4/SKdeK/XTmYpH/drMST+YU/
         Y/PxZ/ftSaZ3jEzK9huOYoJRQA8NEcm/68LFd2dRWgRezsXQM3J/V3qOI18amAFjKXim
         bNILRdN+Pix2othpMow36y38YIBajNJ/7tJZLhq9sELdpZtsZGu98vqOszKQBpSGMYMq
         U0sg==
X-Forwarded-Encrypted: i=1; AJvYcCX6lQon5okZ1INLx7MWXtRwPZhHiO54rkKw+2lPgrqPMxDi6mfujPbHnrOmeA4brg2olqAdNmS7Cey3DKow78HCiq610WotZPKZwP93
X-Gm-Message-State: AOJu0YyC2yc8LQEDJkLCaXQMIG/CegYXm1cHv08mGapwbksNChhLh9mo
	WlSdjmXncc//bBCHDj6epZ3ecKSzDsGs0rpXF4H5ZAogaz+49TYIr+ICcwFsXGgadcjbw0f+B3E
	1iRgMZHPJXTJSvB26QvGsZ0RVn+rPJrGnBVAtkhAFzdiNbXin5SZBWLQ=
X-Google-Smtp-Source: AGHT+IHJrbl7T0TKvLIkMzzk3V0aEFmBSj3K8dNK37Y98UBkMozHgn1kQXWJO+B03G6oBGCpUJQz95A+Owxu6pGBE1GgZa/rSSmL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d8c:b0:7d9:b860:3e54 with SMTP id
 ca18e2360f4ac-7e18f6844c7mr4307039f.2.1715142929145; Tue, 07 May 2024
 21:35:29 -0700 (PDT)
Date: Tue, 07 May 2024 21:35:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000007f2d20617e9d56f@google.com>
Subject: [syzbot] [kernfs?] WARNING in kernfs_new_node (2)
From: syzbot <syzbot+8db86fbe642e61a8ee00@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3d25a941ea50 Merge tag 'block-6.9-20240503' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=177ed51f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3714fc09f933e505
dashboard link: https://syzkaller.appspot.com/bug?extid=8db86fbe642e61a8ee00
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e03ace4a616f/disk-3d25a941.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/14bf616395b8/vmlinux-3d25a941.xz
kernel image: https://storage.googleapis.com/syzbot-assets/197f0e10a223/bzImage-3d25a941.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8db86fbe642e61a8ee00@syzkaller.appspotmail.com

usb 1-1: Direct firmware load for ueagle-atm/eagleI.fw failed with error -2
usb 1-1: Falling back to sysfs fallback for: ueagle-atm/eagleI.fw
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5150 at fs/kernfs/dir.c:526 kernfs_get fs/kernfs/dir.c:526 [inline]
WARNING: CPU: 1 PID: 5150 at fs/kernfs/dir.c:526 kernfs_new_node+0x1d8/0x240 fs/kernfs/dir.c:703
Modules linked in:
CPU: 1 PID: 5150 Comm: kworker/1:4 Not tainted 6.9.0-rc6-syzkaller-00227-g3d25a941ea50 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: events request_firmware_work_func
RIP: 0010:kernfs_get fs/kernfs/dir.c:526 [inline]
RIP: 0010:kernfs_new_node+0x1d8/0x240 fs/kernfs/dir.c:703
Code: 74 08 48 89 ef e8 08 18 c4 ff 48 89 5d 00 4c 89 f0 48 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 59 6c 5f ff 90 <0f> 0b 90 eb a0 89 e9 80 e1 07 fe c1 38 c1 0f 8c 62 fe ff ff 48 89
RSP: 0018:ffffc900042bf578 EFLAGS: 00010293
RAX: ffffffff8236a467 RBX: ffff8880665f0d20 RCX: ffff88807cd43c00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff8236a404 R09: 1ffff1100ccbe1a4
R10: dffffc0000000000 R11: ffffed100ccbe1a5 R12: 00000000000041ed
R13: 0000000000000000 R14: ffff88807bf364b0 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055abc7e81a18 CR3: 000000007e9fe000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kernfs_create_dir_ns+0x43/0x120 fs/kernfs/dir.c:1061
 sysfs_create_dir_ns+0x189/0x3a0 fs/sysfs/dir.c:59
 create_dir lib/kobject.c:73 [inline]
 kobject_add_internal+0x435/0x8d0 lib/kobject.c:240
 kobject_add_varg lib/kobject.c:374 [inline]
 kobject_add+0x152/0x220 lib/kobject.c:426
 class_dir_create_and_add drivers/base/core.c:3263 [inline]
 get_device_parent+0x391/0x410 drivers/base/core.c:3314
 device_add+0x331/0xca0 drivers/base/core.c:3644
 fw_load_sysfs_fallback drivers/base/firmware_loader/fallback.c:86 [inline]
 fw_load_from_user_helper drivers/base/firmware_loader/fallback.c:162 [inline]
 firmware_fallback_sysfs+0x307/0x9e0 drivers/base/firmware_loader/fallback.c:238
 _request_firmware+0xcf5/0x12b0 drivers/base/firmware_loader/main.c:914
 request_firmware_work_func+0x12a/0x280 drivers/base/firmware_loader/main.c:1165
 process_one_work kernel/workqueue.c:3267 [inline]
 process_scheduled_works+0xa10/0x17c0 kernel/workqueue.c:3348
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3429
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
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

