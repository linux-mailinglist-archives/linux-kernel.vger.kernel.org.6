Return-Path: <linux-kernel+bounces-312147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2499692AE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 06:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6393C282CB4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 04:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161321CF28E;
	Tue,  3 Sep 2024 04:03:25 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212321CDFAE
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 04:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725336204; cv=none; b=YihRGcRlEatvm7U7xTimHSbnF6bimDUZO28xh9SErMlUS1qbaulBpUUcgVkSubd4yrdiM/ihgd3a4xuRfpWgJDZHd634Sz+IzMYj98PkGdPN+JXJpy8Mgts/tN/UH0BjWYpCs4Xpl85h2eYRrSBuj9pp4WiH6yiek/iKBKUZ/is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725336204; c=relaxed/simple;
	bh=3DVyBQQSxw+DaF0Tvku13o9jnSR2iRYfV6GGKEvuAhY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=o2kyjrf79VEaBlbI/9qwu5DxxxLm5hRHn9V0v37UYifc9lmRjUFtsT/c0UF+1jqAA6HbVUlyn5aY1H+ci6fRe+MsxgtVOeoxumrOLPhpqzFqva1jcqvPtMehhacqmy2zXmVweaVB1bQ3i76yccQ0+CnyKSNt/TJqG/jCmLmqK1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39f4f43b818so22143295ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 21:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725336202; x=1725941002;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PRu/ehkcfoxHuabFtsJ4qkhHQn3xPQjo9rYWKQxBFPg=;
        b=IZRkJ7cryeUfWtkiPR0MdEgeBfGoU6u+1aPPrEn6AIPjbvltTAyJwUqEakTyRLWcKI
         tjFE5j9pvXplSeUc4g47aqVdS3kfyFTdwWgIJ3QOq0RBs/Nnz+E+1uBxzbCo8QqMozcK
         lSptPd5jF1bJIU1V3MnAyx5x7EqPXhKDIgN+6mBnZ+kXMW0l3XgLBjX6ODjygiRDppNV
         wPubn2fjwInkLw7evWju05xDjLKeqB9aR95H+MBK8vzcwV+3GMPvs/4dLtZBwQkW1KUR
         BwZS7yM0Mk9xXcyerwAdBwrVvQV3dDZzxv3KDyR+X8XrhjywE/f4IJnilpw52F3hxnO6
         jpfw==
X-Forwarded-Encrypted: i=1; AJvYcCVIRm/5AxkDSlzSCDjPi8d6Mh+Wq5C9afw5Boca9/LGy6CdRy2IvtEQ4Nrz8pv4ryKNd6wJ7tZ8yiHHxO8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4oVJpyj+5tDKeRBHnC7IohmVPtGUzIaoZOT3uZoqM/G2Y/zgO
	g9/HjSzzmBQEHgvbqekGTNLkBNiU7EnxTC10sevmxxUkqATNoidptVb3ehRUkZkuinSFBTaOnM2
	FnPTnx4KkUMHW0wZowB5qQ3aPX1NvKsqjPH91E552SMMRrJ+nrC0sSak=
X-Google-Smtp-Source: AGHT+IFmd2CzI3jFIENT6kfyko0tux6vbzdEg6trD/WMvcO8cAfFSkHxcnH4zllEdGlSPNnJzcCy1OiNV5jI1oviTjo2nmjHC08V
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:152d:b0:376:3fad:bb7c with SMTP id
 e9e14a558f8ab-39f38add4b3mr9096585ab.1.1725336202191; Mon, 02 Sep 2024
 21:03:22 -0700 (PDT)
Date: Mon, 02 Sep 2024 21:03:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000073383906212f236a@google.com>
Subject: [syzbot] [usb?] WARNING in rtl8150_open/usb_submit_urb
From: syzbot <syzbot+d7e968426f644b567e31@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, petkan@nucleusys.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fc88bb116179 usb: roles: add lockdep class key to struct u..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=17b89e97980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f470942baada45b1
dashboard link: https://syzkaller.appspot.com/bug?extid=d7e968426f644b567e31
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16bb5463980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=150ca88f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5b06342088f5/disk-fc88bb11.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e881a8c2cb53/vmlinux-fc88bb11.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4bf14d7b61d4/bzImage-fc88bb11.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d7e968426f644b567e31@syzkaller.appspotmail.com

------------[ cut here ]------------
usb 1-1: BOGUS urb xfer, pipe 3 != type 1
WARNING: CPU: 1 PID: 2586 at drivers/usb/core/urb.c:503 usb_submit_urb+0xe4b/0x1730 drivers/usb/core/urb.c:503
Modules linked in:
CPU: 1 UID: 0 PID: 2586 Comm: dhcpcd Not tainted 6.11.0-rc4-syzkaller-00069-gfc88bb116179 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:usb_submit_urb+0xe4b/0x1730 drivers/usb/core/urb.c:503
Code: 84 3c 02 00 00 e8 05 e4 fc fc 4c 89 ef e8 fd 25 d7 fe 45 89 e0 89 e9 4c 89 f2 48 89 c6 48 c7 c7 20 5d a0 87 e8 46 e6 c2 fc 90 <0f> 0b 90 90 e9 e9 f8 ff ff e8 d7 e3 fc fc 49 81 c4 c0 05 00 00 e9
RSP: 0018:ffffc9000441f740 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff888112487a00 RCX: ffffffff811a99a9
RDX: ffff88810df6ba80 RSI: ffffffff811a99b6 RDI: 0000000000000001
RBP: 0000000000000003 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000001
R13: ffff8881023bf0a8 R14: ffff888112452a20 R15: ffff888112487a7c
FS:  00007fc04eea5740(0000) GS:ffff8881f6300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0a1de9f870 CR3: 000000010dbd0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 rtl8150_open+0x300/0xe30 drivers/net/usb/rtl8150.c:733
 __dev_open+0x2d4/0x4e0 net/core/dev.c:1474
 __dev_change_flags+0x561/0x720 net/core/dev.c:8838
 dev_change_flags+0x8f/0x160 net/core/dev.c:8910
 devinet_ioctl+0x127a/0x1f10 net/ipv4/devinet.c:1177
 inet_ioctl+0x3aa/0x3f0 net/ipv4/af_inet.c:1003
 sock_do_ioctl+0x116/0x280 net/socket.c:1222
 sock_ioctl+0x22e/0x6c0 net/socket.c:1341
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc04ef73d49
Code: 5c c3 48 8d 44 24 08 48 89 54 24 e0 48 89 44 24 c0 48 8d 44 24 d0 48 89 44 24 c8 b8 10 00 00 00 c7 44 24 b8 10 00 00 00 0f 05 <41> 89 c0 3d 00 f0 ff ff 76 10 48 8b 15 ae 60 0d 00 f7 d8 41 83 c8
RSP: 002b:00007ffdc6648808 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fc04eea56c0 RCX: 00007fc04ef73d49
RDX: 00007ffdc66589f8 RSI: 0000000000008914 RDI: 0000000000000005
RBP: 00007ffdc6668bb8 R08: 00007ffdc66589b8 R09: 00007ffdc6658968
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffdc66589f8 R14: 0000000000000028 R15: 0000000000008914
 </TASK>


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

