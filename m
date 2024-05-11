Return-Path: <linux-kernel+bounces-176454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 833E38C3021
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 09:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D36BEB23425
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 07:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6649A11190;
	Sat, 11 May 2024 07:42:24 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFC3C14F
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 07:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715413343; cv=none; b=cl0Qu9cVbzi6SAtgn47bJpJ/sVlGA1L5ibn34jTts4mhlg0wtRHqm9Mi3dbb65+KMItk9D81PDFNawQQd0vDsAVXeq50TiJAvVNECNN7N7xz2zzbFToBjEGH02RTBz+DbXl/5QRi6wORT4trrhVjHNCZ9J3qiFWMFntXS3hbE9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715413343; c=relaxed/simple;
	bh=DJ+ahY8k1hsu3UuAWA4qRxgrTw2KQYc0pIraZJfq3aM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fqNA5VP5Ha1uh6wxXrf2cEVT3V1A6WbfYSNQhhr0QnSZp9qBMvDl/p7nwcaIDr1QlDojDXq7IVCjMUB1oFypLpo2acDJZVJGocSHU7E6RUSmJRzx3ckPCQUxdXKyOb8rXas6IwP68RKfaRH+PJIsmfJs5Z6WIyQlgt9h2wnIwMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7e1849aee8cso302345239f.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 00:42:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715413342; x=1716018142;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iFznellkm9GiBKTCQDDoZetHffWPBfuIR1Bg2E3W1cU=;
        b=QO01f5BQdV+M/8yliD4YiRgK0TuOf2aZcDaVmK/m4WXU1fHS4EbTBqcn2rWkY7ZZmX
         tHkQZK+ZEDfKQeR3+gCDC1IxsvkVmR6JO8tXaAl9uIK7fSKLxOX/L5Q1PqqcqnY14t2C
         1bEhHAq/TNl0CVuaDXCaWKolqzKnL2IjaiDR/eXUKodr+FzjghgH2ehuy7j63cvBcpMW
         VzIDS+3J9E1DX2AjDbmSHcxZVvdOp/87rB2jr3KA51JCR8GaQSpIEDPJ5YHZUajDUb5U
         HzHSmWRi89LX5C2ElmofHHspg8ejONtNoe6SeExOeYebt/PRH2K/exngkwdRHvSxDwHm
         EBBA==
X-Forwarded-Encrypted: i=1; AJvYcCXlxKZKgIAPiPmk4t2zfrknAwB92Jh2Zx6r2/AaXinZcGTLRVk6a0Cxw1uBx2JHCdrl7U/j0ZQGsRwumHsB0/KSgofpf7SPY1Tk2YAl
X-Gm-Message-State: AOJu0YwaTXgiKGStje/x4xn50KB0f97y2gTLiPgae99BparHBbNGs259
	emJPR2PR/pItr4wPadjpgGiL79h5Z2HayjMid3Y5GsU5OfKbxIjQPKgxmTjDRi3jri3qhb1VNir
	C420DFadpFyOfVOygMUsvdnKQ/6rNZOHRk9blw+xV6MfCalDikJc6qQE=
X-Google-Smtp-Source: AGHT+IHLRYndwIsgwysKZ/B0ln6RjuF8xlvJ7OzeZe2DZTD/g/QYXOUYHPIEO3eEivMRSTR2MxZjhXmcBR5M+fjS+Cvtf34gM/Os
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8523:b0:488:59cc:eb41 with SMTP id
 8926c6da1cb9f-48959eb6a06mr333731173.3.1715413339759; Sat, 11 May 2024
 00:42:19 -0700 (PDT)
Date: Sat, 11 May 2024 00:42:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c27c85061828ca26@google.com>
Subject: [syzbot] [fuse?] WARNING in fuse_request_end
From: syzbot <syzbot+da4ed53f6a834e1bf57f@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    dccb07f2914c Merge tag 'for-6.9-rc7-tag' of git://git.kern..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1239f9a8980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d14c12b661fb43
dashboard link: https://syzkaller.appspot.com/bug?extid=da4ed53f6a834e1bf57f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177a30f4980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=119603c0980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bc129693f2cc/disk-dccb07f2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cf12611cfdc7/vmlinux-dccb07f2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/311fbc1afd69/bzImage-dccb07f2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+da4ed53f6a834e1bf57f@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5085 at fs/fuse/dev.c:300 fuse_request_end+0x5ce/0x6b0 fs/fuse/dev.c:300
Modules linked in:
CPU: 0 PID: 5085 Comm: syz-executor277 Not tainted 6.9.0-rc7-syzkaller-00012-gdccb07f2914c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:fuse_request_end+0x5ce/0x6b0 fs/fuse/dev.c:300
Code: 58 1d 88 fe e9 3c fe ff ff e8 4e 1d 88 fe 49 89 dd e9 94 fe ff ff e8 41 1d 88 fe 90 0f 0b 90 e9 cb fc ff ff e8 33 1d 88 fe 90 <0f> 0b 90 e9 fe fc ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 89
RSP: 0018:ffffc90003417978 EFLAGS: 00010293
RAX: ffffffff830deb4d RBX: 0000000000000b0d RCX: ffff88807afd8000
RDX: 0000000000000000 RSI: 0000000000000100 RDI: 0000000000000000
RBP: 0000000000000100 R08: ffffffff830de846 R09: 1ffff1100f165e06
R10: dffffc0000000000 R11: ffffed100f165e07 R12: dffffc0000000000
R13: ffff888078b2f000 R14: 1ffff1100f165e06 R15: ffff888078b2f030
FS:  000055555ecc7380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200001c0 CR3: 000000007dd4e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 fuse_dev_do_read+0xf3a/0x11f0 fs/fuse/dev.c:1334
 fuse_dev_read+0x173/0x220 fs/fuse/dev.c:1367
 call_read_iter include/linux/fs.h:2104 [inline]
 new_sync_read fs/read_write.c:395 [inline]
 vfs_read+0x97b/0xb70 fs/read_write.c:476
 ksys_read+0x1a0/0x2c0 fs/read_write.c:619
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f38033cd369
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff67cac408 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007fff67cac5d8 RCX: 00007f38033cd369
RDX: 0000000000002020 RSI: 0000000020000340 RDI: 0000000000000003
RBP: 00007f3803440610 R08: 00007fff67cac5d8 R09: 00007fff67cac5d8
R10: 00007fff67cac5d8 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff67cac5c8 R14: 0000000000000001 R15: 0000000000000001
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

