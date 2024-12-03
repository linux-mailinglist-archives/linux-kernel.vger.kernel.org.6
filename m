Return-Path: <linux-kernel+bounces-430204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7969E2DC5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D51F91638C1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C06207A2C;
	Tue,  3 Dec 2024 21:04:26 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F9E3987D
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 21:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733259865; cv=none; b=MjTB4+3w8oMc2oYcX/iSf5CsBl7mRKaECug728AOF0hReWoKTZPMu3WJ/iIB4rf2aSe4ssjFL5cCxiQ3EkhOz1f7STWSDMeJ6JpXVpdYh2bnKLFXVjp9+Z1MbuMP1hngLW3Pq3WaS6WpZJKcjowcO8xTyJObeVd2lK8UUbQhw2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733259865; c=relaxed/simple;
	bh=p9KGF1tXK96+xVWp6kAhNDeWzYhXNkfodD4r83i0sO4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SbVsD7wi8KPuIZmeoijUYzQfLga4Va7kXOVPsGcRL25rGTmHWQIUNdapy1RySDiAesTX3ypH6OVMG4KB4epqAjeMThjYckmbeSUMZuaHIW5GmSmqHdJuiszcVbTSaESRb2gHSM2nd3yXguXzFhsIEmj1c8yltCFLzXdrVTd8Uco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-843eb4505e7so965747239f.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 13:04:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733259863; x=1733864663;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q4yB23HjOn9fKvuVDGPwogtC6bYUn7JMXT+BNWoNBfA=;
        b=A8zfU0fTRRzkcZ1pL5vwY0yObc3ndHeUfMo6h5ZZcd4w25Y6ny0/XjDE5JyPckYbTl
         MAZZI18pHCaC05mNKtOs+9dw3T84/iRur0YxixenhxzObOtrw8FquIGvsCXdlB+sQRAq
         yrMrrPcUYd+FyvQOqtPXSsT871nh9SPGHNTYoCVDT8mZPpRW49Oa5ezkAh4Q8x9wkSAO
         oCrBhD4VFZKWR8OX9VPKwV0qFSRkCu6pkav/f4EUYewZSXDSCEscfi7B+qECxxuSCJ0U
         TwPbqcB1IQDHeT+wH0GnKnJTtrhtO9IKKOBX4AlPEbOM4/9qXa87H0Yf9Bl0f7pQty+5
         xX4A==
X-Gm-Message-State: AOJu0YzQoCrdkQhswidTcJCCEnAb6rn5Busrko+N++ZK9SmlE/p14KLQ
	JcHBvkJ4+3ONTVv2O3Hh0y/qj8jKxWFUu43qzjO1gxt3tg817xEFqg9I4NIXY4FaZi/QN9lh2u1
	XNbDaCnJnn2bdUuERjpj8fT4B2ScpXWl6/Deff2f02cqujuEA8eIavzzb+w==
X-Google-Smtp-Source: AGHT+IFnHaz9/ZmLepu9VwXCO1HNNHKzdU9GqRoSv0jw1Ks7HbO+kAxYXo7tiKzICIw3STzhLJoGUtstV/16cN1AvZl2wYylvr9x
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c54f:0:b0:3a7:4674:d637 with SMTP id
 e9e14a558f8ab-3a7fecb1df1mr28350215ab.3.1733259863443; Tue, 03 Dec 2024
 13:04:23 -0800 (PST)
Date: Tue, 03 Dec 2024 13:04:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674f7257.050a0220.17bd51.0051.GAE@google.com>
Subject: [syzbot] [kernel?] WARNING in notifier_chain_register (2)
From: syzbot <syzbot+8b5a4b73931f20e049d7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cdd30ebb1b9f module: Convert symbol namespace to string li..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1242efc0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50c7a61469ce77e7
dashboard link: https://syzkaller.appspot.com/bug?extid=8b5a4b73931f20e049d7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/658bd206f462/disk-cdd30ebb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/12cb86080d87/vmlinux-cdd30ebb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5181aac6587a/bzImage-cdd30ebb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8b5a4b73931f20e049d7@syzkaller.appspotmail.com

ubi0: attaching mtd0
ubi0: scanning is finished
------------[ cut here ]------------
notifier callback ubi_wl_reboot_notifier already registered
WARNING: CPU: 0 PID: 9647 at kernel/notifier.c:24 notifier_chain_register+0x29b/0x3f0 kernel/notifier.c:23
Modules linked in:
CPU: 0 UID: 0 PID: 9647 Comm: syz.5.633 Not tainted 6.13.0-rc1-syzkaller-00002-gcdd30ebb1b9f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:notifier_chain_register+0x29b/0x3f0 kernel/notifier.c:23
Code: f2 33 00 90 48 89 d8 48 c1 e8 03 42 80 3c 20 00 74 08 48 89 df e8 c5 d9 9e 00 48 8b 33 48 c7 c7 40 02 0a 8c e8 36 99 f4 ff 90 <0f> 0b 90 90 bb ef ff ff ff eb b4 e8 d5 f1 33 00 90 0f 0b 90 e9 36
RSP: 0018:ffffc9000bbe7948 EFLAGS: 00010246
RAX: 1aaf62e18450e600 RBX: ffff8880783ad8c8 RCX: 0000000000080000
RDX: ffffc90010051000 RSI: 0000000000009f08 RDI: 0000000000009f09
RBP: 0000000000000001 R08: ffffffff81601c02 R09: fffffbfff1cfa210
R10: dffffc0000000000 R11: fffffbfff1cfa210 R12: dffffc0000000000
R13: ffff8880783ad8c8 R14: dffffc0000000000 R15: ffffffff8f96cd48
FS:  00007f68a13f66c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2f616ff8 CR3: 0000000029dcc000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 __blocking_notifier_chain_register kernel/notifier.c:264 [inline]
 blocking_notifier_chain_register+0x61/0xc0 kernel/notifier.c:282
 ubi_wl_init+0x3396/0x3720 drivers/mtd/ubi/wl.c:1960
 ubi_attach+0x3e01/0x5b80 drivers/mtd/ubi/attach.c:1605
 ubi_attach_mtd_dev+0x1a3a/0x3540 drivers/mtd/ubi/build.c:1004
 ctrl_cdev_ioctl+0x346/0x570 drivers/mtd/ubi/cdev.c:1043
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf7/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f68a357ff19
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f68a13f6058 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f68a3746160 RCX: 00007f68a357ff19
RDX: 0000000020000502 RSI: 0000000040186f40 RDI: 0000000000000008
RBP: 00007f68a35f3986 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f68a3746160 R15: 00007ffca371fc38
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

