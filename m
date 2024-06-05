Return-Path: <linux-kernel+bounces-203121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2288FD6BA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 21:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 213B31C25202
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 19:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913BD1527AA;
	Wed,  5 Jun 2024 19:47:36 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7937E1527A4
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 19:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717616856; cv=none; b=h/JdHiuAJQNBMODCrh2RnldiMhvpS6cyp+sJgZDBj3t8+7Iwlkh4LoBaJPoJLv+9tLBMa1SDs8HKfVn69fAXKB8Zu+HPp1xNnpc8XGb7/F26cOc1LJu+5suTL5mxja7v9s+VAJsCygIDNq9rZV9Qu8liwvqnt9R6j/xbxjtJL+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717616856; c=relaxed/simple;
	bh=YTnU1n3sULtM1ZMfXxWVf/tSWGyDjAabChlYZSnKixo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ClcrlDB40Nf0P/5sF36H0Pa8rwFO6w6RFZb2i4j/fOT7Axg9r1TE5C5B34M0yYhYlUpICX9PgQdAuIl1WBy17jRFvPuRpGSo/rOL9e0RIgWuwBWlZ+q8VfdZmG1MPle4yFmogwM+GjxNTX46dgBi/z1BVepoxPaG5bfcf1M7zS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-374b3e81d6dso1772015ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 12:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717616853; x=1718221653;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IdwCET/37TVCvJ/W4W4p7xUx65JOVtxaPRUYzhJRpEE=;
        b=Hw7gRHYeWBMFwSH7WTeOB0MdVzDrNKEY9AU/fyyOaYXuJtP31MxEzKz510RAZ6mFHc
         AVTRe5Iz7WXT5nC7cDHGYaGW0QoOKBltY7KU8coCEmE1WXr9ozMUB8Mxh/PvMIs6SvFS
         NY144L8BiVQJWqZY3XLaR4HLhMx588ESIvIsGhs3V6wKJ3vrci1zs2RhdQym18b8uubi
         tz6VFkdedAta91b6bfqx5U0qvoM9k610AEA3G2sN40R6wMBRq37EtPHQIcZFk9Zwr7Vj
         G+pasF9hXmgbU6oMltrUCKTEzOU052D/iqO2MVyTG65Vux2pxmR3KcZtqgF4uVwm36MD
         FuXg==
X-Forwarded-Encrypted: i=1; AJvYcCXyqDLTg6xBXv7YG9PzrY4Tolf8f0v6DNZ8A861zR9Osi69KcZ9J75mYL7oEMg0cja71nd+KWwplOHtu6RpoKEpxaS2grIVbYVAkZ7H
X-Gm-Message-State: AOJu0YwASQNjFimT+moKZRz7OCcVdAxEhVXnd+Zi7Q5cs9jey8fGAhbk
	/a5HhJ2wRgLoHGkq5yxM2NY208LptklXO35mRmW/tWRdXoW+/qfrFHuHsozwZoBqrtN9NCQKkKx
	mfKWLMLGyonCJaxnOnin+yuuyuvMNoi8aWF6ksZiXRPKPr3FxLfHxsh8=
X-Google-Smtp-Source: AGHT+IGp/bjWoqFJftSJRl8ZGmwwqAr8/RbwBrJnZ4+YElLRdBF2A84JRj45g32A+8dpKigrQYxSFJ+/eRHEbwC7VWYGPSJaE6cG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1909:b0:374:b161:a090 with SMTP id
 e9e14a558f8ab-374b1ef350dmr2354845ab.2.1717616853700; Wed, 05 Jun 2024
 12:47:33 -0700 (PDT)
Date: Wed, 05 Jun 2024 12:47:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006ce6c6061a29d6f5@google.com>
Subject: [syzbot] [ext4?] WARNING in ext4_mb_initialize_context
From: syzbot <syzbot+176b58b1d4ea28b1c947@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cc8ed4d0a848 Merge tag 'drm-fixes-2024-06-01' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=131d0e16980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=733cc7a95171d8e7
dashboard link: https://syzkaller.appspot.com/bug?extid=176b58b1d4ea28b1c947
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-cc8ed4d0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/36abdd995432/vmlinux-cc8ed4d0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5e4e0a6f67db/bzImage-cc8ed4d0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+176b58b1d4ea28b1c947@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: CPU: 2 PID: 5763 at kernel/locking/mutex.c:587 __mutex_lock_common kernel/locking/mutex.c:587 [inline]
WARNING: CPU: 2 PID: 5763 at kernel/locking/mutex.c:587 __mutex_lock+0x328/0x9c0 kernel/locking/mutex.c:752
Modules linked in:
CPU: 2 PID: 5763 Comm: syz-executor.2 Not tainted 6.10.0-rc1-syzkaller-00267-gcc8ed4d0a848 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:587 [inline]
RIP: 0010:__mutex_lock+0x328/0x9c0 kernel/locking/mutex.c:752
Code: d0 7c 08 84 d2 0f 85 50 06 00 00 8b 0d 25 df 03 05 85 c9 75 19 90 48 c7 c6 60 a4 2c 8b 48 c7 c7 c0 a2 2c 8b e8 09 ef 71 f6 90 <0f> 0b 90 90 90 e9 0d fe ff ff 4c 8d b5 60 ff ff ff 48 89 df 4c 89
RSP: 0018:ffffc90002eeee80 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffffe8ffad251290 RCX: ffffc9000c001000
RDX: 0000000000040000 RSI: ffffffff81510236 RDI: 0000000000000001
RBP: ffffc90002eeefa0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 000000002d2d2d2d R12: 1ffff920005dddda
R13: 0000000000000002 R14: dffffc0000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88802c200000(0063) knlGS:00000000f5eb4b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f73fd584 CR3: 0000000025738000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ext4_mb_group_or_file fs/ext4/mballoc.c:5788 [inline]
 ext4_mb_initialize_context+0x814/0xdf0 fs/ext4/mballoc.c:5832
 ext4_mb_new_blocks+0x96d/0x4e40 fs/ext4/mballoc.c:6206
 ext4_alloc_branch fs/ext4/indirect.c:340 [inline]
 ext4_ind_map_blocks+0x19fb/0x2810 fs/ext4/indirect.c:635
 ext4_map_blocks+0x878/0x17d0 fs/ext4/inode.c:625
 _ext4_get_block+0x250/0x5a0 fs/ext4/inode.c:765
 __block_write_begin_int+0x4fb/0x16e0 fs/buffer.c:2128
 ext4_convert_inline_data_to_extent fs/ext4/inline.c:607 [inline]
 ext4_try_to_write_inline_data+0x5ec/0x1350 fs/ext4/inline.c:739
 ext4_write_begin+0xc6f/0x1140 fs/ext4/inode.c:1143
 generic_perform_write+0x272/0x620 mm/filemap.c:4015
 ext4_buffered_write_iter+0x11f/0x3d0 fs/ext4/file.c:299
 ext4_file_write_iter+0x874/0x1a40 fs/ext4/file.c:698
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0x6b6/0x1140 fs/read_write.c:590
 ksys_pwrite64+0x176/0x1a0 fs/read_write.c:705
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf72c2579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f5eb45ac EFLAGS: 00000292
 ORIG_RAX: 00000000000000b5
RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 0000000020000140
RDX: 000000000000fdef RSI: 0000000008000c61 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


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

