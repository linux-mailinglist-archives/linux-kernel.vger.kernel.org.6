Return-Path: <linux-kernel+bounces-526196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 206E1A3FB71
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B90487AD8CA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F831F1506;
	Fri, 21 Feb 2025 16:28:27 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6681A1E1C36
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 16:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740155307; cv=none; b=eSSR1I2GOPTEa0rxYhWJU18fZispOkAIXMfOo5RElB6d7hRN9pBbUuUZhvJEYqX6qIcJvNipbTPMKyoCqv9TgUZ9osJhU/v3S3HbAx37IIbcOMSsMJJqQkg2U+cbg3SMA3bUC3VK5NOwZvekhXtv4j/cUVWPXjQj/q8DNC4xjXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740155307; c=relaxed/simple;
	bh=IFyRaxnksTikEg16zT4m0PF1U2wjeedNFQ74L2w/DFk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FP8I0xYka645aMSNCFUDAJVzOxEVH42rHMKEcePQIePNSPwFWuHlnt50G7W7nzBVPlAmC7rh0YOq8XuEXZeoSzizB9rPCpjiCMNbjLAnHqVU8PPEvKs/tTDdfyip3HCjWIw6BOXr2AWSyH7zErwkHhY9q1oyMZVmSl8nY4mlY3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d2a6ead92fso39964365ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 08:28:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740155304; x=1740760104;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P4FIgKAJ8qW9otoz+L0WcUkpV//3BW026ovT2i8giEs=;
        b=OerJWijnK+izv2vZEq/8/6ETadATS5WwNKBy7sNx5QU0SiV7YRPN5gb3xSyqSRSBNq
         VldWt76gG1Q87PUt5AVyfKxQc9eYNyHIcmFRbJDIsTE6Btp0uVK4uunfOKuyFagoNVob
         +8XombHBcYiEpzt8HYUJdinjwUOQP1ATmcvXKQThYkc/KCxvYKjPbFZfyAhp3BGJOwr9
         ZF48WwKYZVkafVpzhEDoIaNiLRP/3ayzXkjV9G+I8KhK8Zm8JGgxp3a4L/h4ahzwKp4a
         FeznVMfnu733hwBDE8T0+o/2nZH+bGgjKOl0UE8nHSmI8KY2rk44E9dsfZ6f3qEXLv1C
         tf4g==
X-Forwarded-Encrypted: i=1; AJvYcCWvdA7QerF/KTZd4UbMFH/oO/h8Cf4beZCko0UmIeG3lMjpZIPGJojd+g8GKsA/Au/3k/OpzOLY/JbPApU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyIV5OX28WK37+So/Sjhk04uvpgzkfWg393T1dc5gqjGmeZWn+
	UZ5Y4pl3a/a2yNjWq54TUSrfkoyDJhppeLkFKsu5N5+8B2ynXVlnzBulthtFU7QZ56QHIlroL8Z
	/cBr9kQOV9AvmwN/XttbSJQh9XtpVl3H/irqoSXug4PkkITYwTrcoxkU=
X-Google-Smtp-Source: AGHT+IFzSCoq9Rb6XF3wKptknxyMCMA8A3eEbLAggswhPSjJOQZlLSrz6TFBd2rW+kYqDSOrxuco9ku6mEMtMA2I/D1xVOEg86OK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1526:b0:3d0:4a82:3f43 with SMTP id
 e9e14a558f8ab-3d2cb43281cmr37014775ab.5.1740155304493; Fri, 21 Feb 2025
 08:28:24 -0800 (PST)
Date: Fri, 21 Feb 2025 08:28:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b8a9a8.050a0220.14d86d.057a.GAE@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in btrfs_free_fs_info (2)
From: syzbot <syzbot+bbbdd6d6efbfc5174561@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0ad2507d5d93 Linux 6.14-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=179ae898580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6cc40dfe827ffb85
dashboard link: https://syzkaller.appspot.com/bug?extid=bbbdd6d6efbfc5174561
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6bb4d4755dce/disk-0ad2507d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/57594e8f74d9/vmlinux-0ad2507d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a4f2442a20b1/bzImage-0ad2507d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bbbdd6d6efbfc5174561@syzkaller.appspotmail.com

assertion failed: percpu_counter_sum_positive(em_counter) == 0, in fs/btrfs/disk-io.c:1266
------------[ cut here ]------------
kernel BUG at fs/btrfs/disk-io.c:1266!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 5826 Comm: syz-executor Not tainted 6.14.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
RIP: 0010:btrfs_free_fs_info+0x35c/0x360 fs/btrfs/disk-io.c:1266
Code: e9 89 00 20 fe e8 74 f4 dc fd 48 c7 c7 80 2a 6c 8c 48 c7 c6 c0 30 6c 8c 48 c7 c2 00 2b 6c 8c b9 f2 04 00 00 e8 75 3e 42 fd 90 <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f
RSP: 0018:ffffc900041d7d50 EFLAGS: 00010246
RAX: 000000000000005a RBX: 0000000000000004 RCX: 472f5d3ce77a5400
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000000000001 R08: ffffffff81a1102c R09: 1ffff9200083af44
R10: dffffc0000000000 R11: fffff5200083af45 R12: dffffc0000000000
R13: 1ffff11005ec2bc3 R14: ffff88807e594000 R15: ffff88807e595150
FS:  00005555839d1500(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055acae0e8160 CR3: 000000005f838000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1413
 task_work_run+0x24f/0x310 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x13f/0x340 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbb69b8e117
Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffca0e02598 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007fbb69c0e08c RCX: 00007fbb69b8e117
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffca0e02650
RBP: 00007ffca0e02650 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffca0e036e0
R13: 00007fbb69c0e08c R14: 0000000000010d6a R15: 00007ffca0e03720
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:btrfs_free_fs_info+0x35c/0x360 fs/btrfs/disk-io.c:1266
Code: e9 89 00 20 fe e8 74 f4 dc fd 48 c7 c7 80 2a 6c 8c 48 c7 c6 c0 30 6c 8c 48 c7 c2 00 2b 6c 8c b9 f2 04 00 00 e8 75 3e 42 fd 90 <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f
RSP: 0018:ffffc900041d7d50 EFLAGS: 00010246
RAX: 000000000000005a RBX: 0000000000000004 RCX: 472f5d3ce77a5400
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000000000001 R08: ffffffff81a1102c R09: 1ffff9200083af44
R10: dffffc0000000000 R11: fffff5200083af45 R12: dffffc0000000000
R13: 1ffff11005ec2bc3 R14: ffff88807e594000 R15: ffff88807e595150
FS:  00005555839d1500(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fae2d970220 CR3: 000000005f838000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

