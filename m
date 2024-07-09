Return-Path: <linux-kernel+bounces-245321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE8C92B132
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35CFC282388
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6FA145A08;
	Tue,  9 Jul 2024 07:34:25 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA31F143752
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 07:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720510465; cv=none; b=rsRKw5L4cOP4rGcaqXPp0cfNwNvuxW5LH+mz4C9tuztReGUThDDVdv448YtR8/t59PH0pZR6LxvY1PduBxbERaY2mtqW5GHl+7P85vZ8TQFgzpQwt3H4TUZSnw5XsU2I1QsfmNWMHAMCykUk+TuC03XA1sxZjhyN7gHEDE4WeVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720510465; c=relaxed/simple;
	bh=4hxmwXyCUESMlQ9wT1HjK4hk6LZ5RJQq4cZCuIXAh48=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OfEap8+gs54uC2HEDYbPg8UR7RIx9tRrBkgyZTEr+VCL6heN16Za3VyGphaDt3tFZxW9Nsd2hRC3tGD4Y9QHuepo0pnPpgbbdrJHfvu7c/H79Im9VPcEgWTQJXNn/TDN5Wl+IvxgU6LMtjrdhfTOM3KwEUmjotbFjg3mGf/oJfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-37613924eefso58521975ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 00:34:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720510463; x=1721115263;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ALjQGdbNHVaPJ1ynC8GfH+CoSsrbpmUoa8b0ZipILqc=;
        b=CQWxFOQh086lh0NucrAhZ4B+HtfxK7WlokhghTyJRN++we+7Ogd1Keos6IkAfjFZZM
         QFxUb3p7HF1LDIhtB33yL5XTr1lI2+501EtDXZW8n2YpHp26s4rsyykxNCjFCVQ2xYsg
         uhiuXOrD3//HIftmEQiM6tBEGxSSDkQfgJqdJBg6womcnuMjsEw9rK9TvvoSwzAMb7Jt
         AhWT7Fc+XtwVy8FzGTtVmL7OC3p+6Tc1U06jK4mZK0K+5F4CiNbAUMu+WgAjoNQNhGb0
         Q6CZwLe4FnjMBaCdtRj2r9EVADCV6CIjwHs41SI+VBpvjLK2ibL31f8wcaicRXy6GrU0
         ziHw==
X-Forwarded-Encrypted: i=1; AJvYcCWfNai51SeZxVwJPRSqzjEq37IqWpzr8pOxzsqw+nT1EoXjw1TTRZi2KE+7OHMuk5KeIlb9gwW3AunwRs1CgYLGk1uD9VmN5pMVAxR2
X-Gm-Message-State: AOJu0Yyect7s+KtlZMKjMvXCOCyaXfryFmOtjBEMQS/ksSsgaZ96vYBB
	zzhiiaPWWUywgWDVjDuxUqJxY6D+T/odFazdXMyaTFgIM7zE9i6tp03nEyuekcRak1+UBLOKVe6
	tLwRoqjxSLMRfqJte/EBhHZZSnFb/YuMiyb+qXgYoLigbsEBmxTvBN/A=
X-Google-Smtp-Source: AGHT+IFOzh4mDnzJn5EChuu9V2MaOZcz7A43/i/YlVSgfTsAD4DOI//cfxhgTWGsLI1puc/9Ewy/ntfDUmsqfvol+A2sz/7nYFgZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:da4a:0:b0:382:6a83:f4fc with SMTP id
 e9e14a558f8ab-38a59aaf125mr208645ab.5.1720510462971; Tue, 09 Jul 2024
 00:34:22 -0700 (PDT)
Date: Tue, 09 Jul 2024 00:34:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fa6583061ccb8e3d@google.com>
Subject: [syzbot] [bluetooth?] WARNING in __hci_cmd_sync_sk
From: syzbot <syzbot+f52b6db1fe57bfb08d49@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    256abd8e550c Linux 6.10-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14e81031980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=42a432cfd0e579e0
dashboard link: https://syzkaller.appspot.com/bug?extid=f52b6db1fe57bfb08d49
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4b52809e32ca/disk-256abd8e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6c71e8f0eab4/vmlinux-256abd8e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fdcc77cd0018/bzImage-256abd8e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f52b6db1fe57bfb08d49@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 16659 at kernel/workqueue.c:2282 __queue_work+0xc5e/0xee0 kernel/workqueue.c:2281
Modules linked in:
CPU: 0 PID: 16659 Comm: syz-executor Not tainted 6.10.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:__queue_work+0xc5e/0xee0 kernel/workqueue.c:2281
Code: ff e8 76 83 36 00 90 0f 0b 90 e9 20 fd ff ff e8 68 83 36 00 eb 13 e8 61 83 36 00 eb 0c e8 5a 83 36 00 eb 05 e8 53 83 36 00 90 <0f> 0b 90 48 83 c4 58 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc
RSP: 0018:ffffc9000ecef810 EFLAGS: 00010093
RAX: ffffffff815fa35f RBX: ffff888061d45a00 RCX: ffff888061d45a00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff815f9833 R09: 0000000000000000
R10: ffffc9000ecef8e0 R11: fffff52001d9df1d R12: ffff8880648631c0
R13: dffffc0000000000 R14: ffff888064863000 R15: 0000000000000008
FS:  000055555f45a500(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f755bb04030 CR3: 0000000052a18000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 queue_work_on+0x1c2/0x380 kernel/workqueue.c:2411
 queue_work include/linux/workqueue.h:621 [inline]
 hci_cmd_sync_run net/bluetooth/hci_sync.c:145 [inline]
 __hci_cmd_sync_sk+0x7b1/0x1130 net/bluetooth/hci_sync.c:167
 __hci_cmd_sync_status_sk net/bluetooth/hci_sync.c:252 [inline]
 __hci_cmd_sync_status+0x37/0x130 net/bluetooth/hci_sync.c:278
 hci_dev_cmd+0x51c/0xa50 net/bluetooth/hci_core.c:747
 sock_do_ioctl+0x158/0x460 net/socket.c:1222
 sock_ioctl+0x629/0x8e0 net/socket.c:1341
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3a54b757db
Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
RSP: 002b:00007ffee9a9ba60 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f3a54b757db
RDX: 00007ffee9a9bad8 RSI: 00000000400448dd RDI: 0000000000000003
RBP: 000055555f45a4a8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000001 R14: 0000000000000005 R15: 0000000000000009
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

