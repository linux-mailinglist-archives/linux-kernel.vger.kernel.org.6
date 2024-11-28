Return-Path: <linux-kernel+bounces-424417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 333FC9DB41D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4869164A87
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 08:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8DB15383E;
	Thu, 28 Nov 2024 08:47:25 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2BB14F9FA
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 08:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732783645; cv=none; b=VXQ+NG0WYzixwDLoX89RJdGKRlKutipxN7aBI/q/wO741V+y4yrD8ta/2ykAwvYi5rG6konDW9ShlkSo2o6T4r3iCX590DvIw8HMml0MeSNUipHitXqpLuJCYCj6hpQ3toI7TB9VoGwMIICjcGUAkoPY5RGo5k4pKBbKJMoyn9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732783645; c=relaxed/simple;
	bh=5QCGGgNDq0aUhaO3Y8shi3DkZp4hYS2bJtiTif+a8Ok=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UVzToou7o9mlECElAZqCjZWPtGeaHcRZoyuuV5L1qDkhy7jontd/7OK2CZ8VVGTRNO452D+V55ZtsEZR4vem4M5wK7I6XCr7qa9xnPCXuUbKhZNOObfiEStyC0X9t5UGXeQjHOvERMZlNATiQrz6zae2p96uuvGOfXK/ZdlSgSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a78589df29so6182245ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 00:47:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732783642; x=1733388442;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GOJK1jGRDRI2t8rgFn96dBmI0Fc7yXAsftfXFPI8ueg=;
        b=mL5mJ7l6FgJVuuNf2FTmHNeLydbbKs+BdcjFHOoGjuD0iw5cyuT3mR6+yw5lDdxGBO
         qANR+wYnIhl9SmMRgoSZ13IFlutaDtZBmEVbOvuQrL9TqH5ZZulzI8eZefowAoNPvnrR
         4oxV0chfs54BIShZtspjjeJmaU0Fl41T1S3ppkNQ4iAf5smU0wf+kdGxQasxmbLdsiUC
         zAVr1PmK++nIMR1iSQftapOvI1qKBLD5DepbHu2c2k3wW/K5k18xBsf/IduvZ/V38/oy
         NsDg33TG4ZnN40WlmExGwrY+1Wf/iBgcFC6auRnChGIEX4HCJfpvGexvdaU6Dh0O4vW2
         9gTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVotMGA81Nxa9XxhTxDXmj7dUp2C+jDNnynRPxX/vAMj9PgoGRqT0U7uKMxtmtqWWeIgPkGjjli+1MQ3BI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVfTEtzCXcQ7ew1XvdxFb9vlQrMCbYSqqPZz6hkO3MKnd5tUYB
	35GFZGwf5YPDotQZYT+UCHBWcp3jJhJlLyxRxyhyGfn9qmNDIr1JmwfBaOLWSQDhIrjbeB3RxqE
	nz9t3SALRTC3AXGEGMouKwgfIY3Vlow7SIv2K00VffM/hdPOw700+LC8=
X-Google-Smtp-Source: AGHT+IEfd8YGM9TsdEbw/1tCH8zTkvNnHnSwk402xn6ZNunlsDU9pD0fQGYnyHcXA3ipbQNe9gwZG/Rix21+OI3vIH0lsEcBiB4h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216a:b0:3a7:78bd:e486 with SMTP id
 e9e14a558f8ab-3a7c552405fmr67208125ab.5.1732783642405; Thu, 28 Nov 2024
 00:47:22 -0800 (PST)
Date: Thu, 28 Nov 2024 00:47:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67482e1a.050a0220.253251.0076.GAE@google.com>
Subject: [syzbot] [kernel?] WARNING: refcount bug in device_move
From: syzbot <syzbot+7e94d6c5abca98373aee@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9f16d5e6f220 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10d90778580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e92fc420ca55fe33
dashboard link: https://syzkaller.appspot.com/bug?extid=7e94d6c5abca98373aee
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1d1a9389ec33/disk-9f16d5e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/32610b045488/vmlinux-9f16d5e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/673211d6a429/bzImage-9f16d5e6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7e94d6c5abca98373aee@syzkaller.appspotmail.com

Bluetooth: hci1: Opcode 0x0406 failed: -4
Bluetooth: hci1: Opcode 0x0406 failed: -4
Bluetooth: hci2: Opcode 0x0c1a failed: -4
Bluetooth: hci2: Opcode 0x0406 failed: -4
------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 0 PID: 10541 at lib/refcount.c:28 refcount_warn_saturate+0x15a/0x1d0 lib/refcount.c:28
Modules linked in:
CPU: 0 UID: 0 PID: 10541 Comm: syz.2.1919 Not tainted 6.12.0-syzkaller-09073-g9f16d5e6f220 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:refcount_warn_saturate+0x15a/0x1d0 lib/refcount.c:28
Code: e0 64 5f 8c e8 17 33 a9 fc 90 0f 0b 90 90 eb 99 e8 8b 8d e8 fc c6 05 d6 15 59 0b 01 90 48 c7 c7 40 65 5f 8c e8 f7 32 a9 fc 90 <0f> 0b 90 90 e9 76 ff ff ff e8 68 8d e8 fc c6 05 b0 15 59 0b 01 90
RSP: 0018:ffffc9000489ef38 EFLAGS: 00010246
RAX: dbe0113176482a00 RBX: ffff88801cbab078 RCX: 0000000000080000
RDX: ffffc9000bfea000 RSI: 000000000006023b RDI: 000000000006023c
RBP: 0000000000000003 R08: ffffffff815687d2 R09: fffffbfff1cfa8a0
R10: dffffc0000000000 R11: fffffbfff1cfa8a0 R12: ffff88801cbab060
R13: ffffffff85ee3a30 R14: 1ffff1100397560c R15: ffff88801cbab060
FS:  00007f4534f846c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe194e1ef7e CR3: 000000006ccf4000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __refcount_sub_and_test include/linux/refcount.h:275 [inline]
 __refcount_dec_and_test include/linux/refcount.h:307 [inline]
 refcount_dec_and_test include/linux/refcount.h:325 [inline]
 kref_put include/linux/kref.h:64 [inline]
 klist_dec_and_del+0x3ec/0x3f0 lib/klist.c:206
 klist_put lib/klist.c:217 [inline]
 klist_del lib/klist.c:230 [inline]
 klist_remove+0x25e/0x480 lib/klist.c:249
 device_move+0x1b4/0x710 drivers/base/core.c:4643
 hci_conn_del_sysfs+0xac/0x160 net/bluetooth/hci_sysfs.c:75
 hci_conn_cleanup net/bluetooth/hci_conn.c:174 [inline]
 hci_conn_del+0x8c4/0xc40 net/bluetooth/hci_conn.c:1164
 hci_abort_conn_sync+0x583/0xe00 net/bluetooth/hci_sync.c:5603
 hci_disconnect_all_sync+0x264/0x460 net/bluetooth/hci_sync.c:5626
 hci_suspend_sync+0x41a/0xca0 net/bluetooth/hci_sync.c:6103
 hci_suspend_dev+0x203/0x3e0 net/bluetooth/hci_core.c:2832
 hci_suspend_notifier+0xf2/0x2b0 net/bluetooth/hci_core.c:2412
 notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
 notifier_call_chain_robust kernel/notifier.c:128 [inline]
 blocking_notifier_call_chain_robust+0xe8/0x1e0 kernel/notifier.c:353
 pm_notifier_call_chain_robust+0x2c/0x60 kernel/power/main.c:102
 snapshot_open+0x19b/0x280 kernel/power/user.c:77
 misc_open+0x2cc/0x340 drivers/char/misc.c:165
 chrdev_open+0x521/0x600 fs/char_dev.c:414
 do_dentry_open+0xbe1/0x1b70 fs/open.c:945
 vfs_open+0x3e/0x330 fs/open.c:1075
 do_open fs/namei.c:3828 [inline]
 path_openat+0x2c84/0x3590 fs/namei.c:3987
 do_filp_open+0x27f/0x4e0 fs/namei.c:4014
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1402
 do_sys_open fs/open.c:1417 [inline]
 __do_sys_openat fs/open.c:1433 [inline]
 __se_sys_openat fs/open.c:1428 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1428
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f453417e819
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4534f84038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f4534335fa0 RCX: 00007f453417e819
RDX: 0000000000004000 RSI: 00000000200002c0 RDI: ffffffffffffff9c
RBP: 00007f45341f175e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f4534335fa0 R15: 00007ffc9eec0e38
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

