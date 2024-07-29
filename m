Return-Path: <linux-kernel+bounces-265154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D05C93ED60
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADA151F22411
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 06:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6648884A5B;
	Mon, 29 Jul 2024 06:25:26 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537CA83A07
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 06:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722234325; cv=none; b=UQdDmBT/W5qmxwKuoSZxaNoGAOeM2Yc1rAh1XISC1UErA2+a1jkzT/jBQwFkcoMyFs6HesyVa5dtb3efVnkD9Qlu4bNWJMdSqMFnPDwcHiG3UvOgLkvGGCfLsctqnwFGYjYSU7YP2dVojfFzm8quXL+yfElcclZhI2ChAbbekkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722234325; c=relaxed/simple;
	bh=w0jJF3WTrhgW1Cdze0NpOz/DAT1DCo3vI3JC6dU1CZ0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Et5+clDdZ/6wZ2qCiPz0LqLJRRFdBXYrv6ph6uWWwvi/aCgA6XqzZ63LhZXJ83KWsTPRk6FI5z9C8lC3rju3E38WqEKmJ3BwhIbZP3gp8EDBzoAOng3bWa49HNiSlSJic0pVrNBomBhNp5Cpfkb+IyOcYtpuH40RrmeXI7/2gvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f99a9111fso271861039f.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 23:25:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722234323; x=1722839123;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l9TJexnCfhAzTqLIsZlaoF0POVuvzO1ul1CoZ2gTpV8=;
        b=aqj0sMBySpW0AUF5XSgDpv1VSyg4RHxH+y0uxXaD737p3l4doqJBzOoynICweQbkbH
         vI9mW50Ehz2TxL4YxqvPQcATMSV3cLoM7p9YA6OzRK9BaL7mejLkaX9iz4NVB5w/nC6F
         Hyx1QyKNPUz5oAQdCezFwbSOWZ0lfNDkGsvhXKv0JEz0PwA4iJCC3lNSoefNzi/CYUNJ
         rGOOHMUrN3DE9yAoKYlF0kRqVv4w1wsYsMv3WKN0yxEGIJqTLxfncBkeFTkAkvttzkXE
         t90u3tumMsrSExXbC2hcF13uXHTIPFVbSxZ0HylrGkRcY0TaSXRg+UhCLNPISenczOZ/
         98QA==
X-Forwarded-Encrypted: i=1; AJvYcCUR76cLZnVKr5JRMNRxH2BM/G0U4eO4qNUe523ktZHg7Wm2uwj/C/5yyklV6MqWGUP35+h5kjMVvBcT88uL74zxwn16DwvBjtEsEbms
X-Gm-Message-State: AOJu0YwKjwLrBany4niyua6pStp2h3xk/BcOcWeaCWWaepDthp4wVZFv
	6rEVm6WRyJKXvdiE4TCQ2WCR9xho0iEGT+Vxca3uGsvbwUokkmrN3NP4JpN8wS1jHSAiiulkEuP
	o0Z88jcwwN6YV72twVzxArBfJX/KyPPbHRORmr8JMbIZJFFC3FC4rDm8=
X-Google-Smtp-Source: AGHT+IGMBmVfcB5rvOBEfNdPlEQOkFrr2KFMFArS66cYwyZtvzXd6Yq8Z17/1Db/bi7cuGqsQPUCYnF4Pkhh9JbZQTMFGpl1MGeL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d15:b0:398:b1d3:7c9d with SMTP id
 e9e14a558f8ab-39aec4104e8mr3847775ab.3.1722234323334; Sun, 28 Jul 2024
 23:25:23 -0700 (PDT)
Date: Sun, 28 Jul 2024 23:25:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000100920061e5ced31@google.com>
Subject: [syzbot] [ntfs3?] WARNING: locking bug in evict (2)
From: syzbot <syzbot+1b5e257b523f3e0be7d2@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d1e9a63dcd72 Merge tag 'vfs-6.11-rc1.fixes.2' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=165b609d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8e1cc76f0e8412d3
dashboard link: https://syzkaller.appspot.com/bug?extid=1b5e257b523f3e0be7d2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=157d7145980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8941969dc925/disk-d1e9a63d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0b29cfd6d8ee/vmlinux-d1e9a63d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/106b1d908823/bzImage-d1e9a63d.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/e3d201c6ed53/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/177c61e1ae2e/mount_7.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1b5e257b523f3e0be7d2@syzkaller.appspotmail.com

loop1: detected capacity change from 0 to 4096
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 0 PID: 5593 at kernel/locking/lockdep.c:231 hlock_class kernel/locking/lockdep.c:231 [inline]
WARNING: CPU: 0 PID: 5593 at kernel/locking/lockdep.c:231 check_wait_context kernel/locking/lockdep.c:4797 [inline]
WARNING: CPU: 0 PID: 5593 at kernel/locking/lockdep.c:231 __lock_acquire+0x925/0x2040 kernel/locking/lockdep.c:5092
Modules linked in:
CPU: 0 UID: 0 PID: 5593 Comm: syz.1.106 Not tainted 6.10.0-syzkaller-12261-gd1e9a63dcd72 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:hlock_class kernel/locking/lockdep.c:231 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4797 [inline]
RIP: 0010:__lock_acquire+0x925/0x2040 kernel/locking/lockdep.c:5092
Code: 00 00 83 3d 8c ab 3e 0e 00 75 23 90 48 c7 c7 40 d4 ca 8b 48 c7 c6 e0 d6 ca 8b e8 e6 d5 e5 ff 48 ba 00 00 00 00 00 fc ff df 90 <0f> 0b 90 90 90 31 db 48 8d ab c4 00 00 00 48 89 e8 48 c1 e8 03 0f
RSP: 0018:ffffc900048d7650 EFLAGS: 00010046
RAX: c75590ab2862fe00 RBX: 0000000000001b00 RCX: ffff888026c0bc00
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000ffffffff R08: ffffffff81559342 R09: 1ffff1101728519a
R10: dffffc0000000000 R11: ffffed101728519b R12: 0000000000000000
R13: ffff888026c0c6ff R14: 0000000000000000 R15: ffff888026c0c6ff
FS:  00007f25674c56c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2566759120 CR3: 000000005b364000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 inode_sb_list_del fs/inode.c:506 [inline]
 evict+0x161/0x630 fs/inode.c:658
 ntfs_fill_super+0x3e27/0x4730 fs/ntfs3/super.c:1467
 get_tree_bdev+0x3f7/0x570 fs/super.c:1624
 vfs_get_tree+0x90/0x2a0 fs/super.c:1789
 do_new_mount+0x2be/0xb40 fs/namespace.c:3472
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f256677761a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 7e 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f25674c4e78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f25674c4f00 RCX: 00007f256677761a
RDX: 0000000020000080 RSI: 000000002001f740 RDI: 00007f25674c4ec0
RBP: 0000000020000080 R08: 00007f25674c4f00 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000002001f740
R13: 00007f25674c4ec0 R14: 000000000001f6fb R15: 00000000200000c0
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

