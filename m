Return-Path: <linux-kernel+bounces-412008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C141E9D0252
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 08:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3536AB239B8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 07:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70ED97BB0A;
	Sun, 17 Nov 2024 07:17:26 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9B12B9DD
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 07:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731827846; cv=none; b=jUhL8+l4u6BQxKAi5X9sYtDBSclc2ib+RCJMhCB7v2PH4eX1oOQ5UEmqAO/TuI459EZ/zm3lZYpSZsS5Dxpl8SUM57VJJgL2AtIrOVQnlTf7Vz2f7mhVwt0D/UoGs8nBjh4i5cC93Zv4RKEf/3Lk5v3yhpsqtmkEaSzdY+K34xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731827846; c=relaxed/simple;
	bh=J9xo0eDjjWl6nYWn3GkKYXXbRW+xqRQnTm0Dylsv+W0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=M09l9kdwHEiSvujg99cF/QgMio0hXBz8GMs1HNnVcGR/gEiem03CXTa2YtrHaZ3fnjktRW3iO4umyZamzA9mtzH86yATH0KQT8m/O7v0JbMc+MimLJmhw8lh07uhs+ncFcd1mwAFD+/ebx3Q0vjUx4lhdUc3s4B5KYdVzDxJ3Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83aa904b231so217360739f.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 23:17:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731827843; x=1732432643;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9g9FL2vtw746ImnieEUrrscr7c4cCXXlHJDI8dzEecs=;
        b=c0XMX4NoDzcwIn+N028GkgXTjOkcAq3ePc5Owfy+0CodSHVfp9xrE1Hdzys9Ih8/jP
         YcXplZ7qwkbDCQ+sdA60GDOtdRseIuxED2F9G211RJpsBRumlRsmwskvxgiR+B9mrlD6
         atqM56clSwNja+z1ZzEZSA91d64FsOhcl6YoF/394msGqgHJqm9vNw7ueVu+0WX9iUW4
         lKKMqbijaiSNaw2b4i8zm7uM0WCA2KNVnqGJqtrWKb/5kAMzMCJ3tbWk3xrIV9orRwJK
         j4aL/U/X27ztKlCMzvertNRCJAMcI3FzYQhmJmZr3tW+L7dmaB6xjttEYl4eG9XoqYom
         HI0g==
X-Forwarded-Encrypted: i=1; AJvYcCX4U26TYuMFrurY8lbpE0UQzpNnnOygMdgGRD60RGvprxQxarJYZL+muM7qJskIFNWMzZuj4JpO07IvzWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVvhYcIvbgoknkjuyqqBV1hJFyMIuof9Sm1ClBYyJoexZGkWNn
	Pdj57KoDzwy4H/HyBGg+CWWp84CsB2V88OsUtWoIsRwRGukn0ohr2LsV3Oe4niOMxVwqNhxaSxk
	WfEk5C9SrCZcoWmEAmEmQjMY0gOUpNIHGprlWBtTYy89j67jwG+URoU0=
X-Google-Smtp-Source: AGHT+IFP3Is8EwEVSWbcBxUXcFQ8uqHZie0oXoS31tzssqe3YWdGOm9OwUtOr9Y5yPw3mF6DxRyEmVAaReMKLjtoFXxbHYuZcgHg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8d:b0:3a6:b445:dc9c with SMTP id
 e9e14a558f8ab-3a747ff7fc7mr106747335ab.3.1731827843528; Sat, 16 Nov 2024
 23:17:23 -0800 (PST)
Date: Sat, 16 Nov 2024 23:17:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67399883.050a0220.e1c64.0010.GAE@google.com>
Subject: [syzbot] [net?] WARNING: locking bug in try_to_wake_up (2)
From: syzbot <syzbot+6ac735cc9f9ce6ec2f74@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e8bdb3c8be08 Merge tag 'riscv-for-linus-6.12-rc8' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11231378580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2aeec8c0b2e420c
dashboard link: https://syzkaller.appspot.com/bug?extid=6ac735cc9f9ce6ec2f74
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e2da80861e22/disk-e8bdb3c8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e048d2585df1/vmlinux-e8bdb3c8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/203d0f852ba3/bzImage-e8bdb3c8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6ac735cc9f9ce6ec2f74@syzkaller.appspotmail.com

Bluetooth: hci4: unexpected cc 0x1001 length: 249 > 9
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 0 PID: 5857 at kernel/locking/lockdep.c:232 hlock_class kernel/locking/lockdep.c:232 [inline]
WARNING: CPU: 0 PID: 5857 at kernel/locking/lockdep.c:232 check_wait_context kernel/locking/lockdep.c:4826 [inline]
WARNING: CPU: 0 PID: 5857 at kernel/locking/lockdep.c:232 __lock_acquire+0x58c/0x2050 kernel/locking/lockdep.c:5152
Modules linked in:
CPU: 0 UID: 0 PID: 5857 Comm: kworker/u9:7 Not tainted 6.12.0-rc7-syzkaller-00189-ge8bdb3c8be08 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Workqueue: hci4 hci_cmd_work
RIP: 0010:hlock_class kernel/locking/lockdep.c:232 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4826 [inline]
RIP: 0010:__lock_acquire+0x58c/0x2050 kernel/locking/lockdep.c:5152
Code: 00 00 83 3d b5 db ac 0e 00 75 23 90 48 c7 c7 60 c9 0a 8c 48 c7 c6 00 cc 0a 8c e8 0f 7d e5 ff 48 ba 00 00 00 00 00 fc ff df 90 <0f> 0b 90 90 90 31 db 48 81 c3 c4 00 00 00 48 89 d8 48 c1 e8 03 0f
RSP: 0018:ffffc90004d17670 EFLAGS: 00010046
RAX: 8e05c886ad1f6a00 RBX: 0000000000000d68 RCX: ffff88803572bc00
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000014 R08: ffffffff8155e312 R09: 1ffff110170c519a
R10: dffffc0000000000 R11: ffffed10170c519b R12: ffff88803572bc00
R13: 0000000000000d68 R14: 1ffff11006ae58f4 R15: ffff88803572c7a0
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30b1eff8 CR3: 000000006d8fc000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
 raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:598
 raw_spin_rq_lock kernel/sched/sched.h:1506 [inline]
 rq_lock kernel/sched/sched.h:1805 [inline]
 ttwu_queue kernel/sched/core.c:3951 [inline]
 try_to_wake_up+0x81e/0x14b0 kernel/sched/core.c:4281
 autoremove_wake_function+0x16/0x110 kernel/sched/wait.c:384
 __wake_up_common kernel/sched/wait.c:89 [inline]
 __wake_up_common_lock+0x132/0x1e0 kernel/sched/wait.c:106
 vhci_send_frame+0xe1/0x150 drivers/bluetooth/hci_vhci.c:83
 hci_send_frame+0x1fb/0x380 net/bluetooth/hci_core.c:3042
 hci_send_cmd_sync net/bluetooth/hci_core.c:4069 [inline]
 hci_cmd_work+0x123/0x6c0 net/bluetooth/hci_core.c:4098
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
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

