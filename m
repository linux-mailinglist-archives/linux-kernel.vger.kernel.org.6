Return-Path: <linux-kernel+bounces-427538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA4F9E028A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F3E7169034
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342071FECD5;
	Mon,  2 Dec 2024 12:54:28 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AC11FECD1
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 12:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733144067; cv=none; b=W4mgHRjHt3wxWNI0r/cmJDY0Qi6ClbUkQ+gy0n8KQw/Ib41wMQTlG8jgvE1bT9YJKfrPi5KhpL/RNJbvpxI/6pXT3w4CDEr+AElPZrIzmW6ow0GabiyH/QRowDtVKUfc8K6DxY9vFAt/+s/umdcCQ30i+sAdjJ12osggULv6KOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733144067; c=relaxed/simple;
	bh=ZCFTzitm8WDx9MV4GVhrVdaIMkyujyGmtRhLKMcgVjM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pyXicLR4nhzT1wx+qvb1tT8wsIcJiMJM8B1xMTAuL+NxRlHOM+Ei7KGaezm7JTOKWY8qfGW61JdiiZJjxiTBfzlg+yle6enGQ+r3mRdTlA0NmPiB6tD903iprwgo1FeIZqwWssXKi93jQnKlOJvrMTZ8F2FKE9E5Jnsp3MRm1ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a78c40fa96so36371155ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 04:54:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733144065; x=1733748865;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IBBFBJDa32RUIKQFH0JCV3u7qklWJQA6cnv7lwRT634=;
        b=eZYpQFC5ZW6hHRw3RTNXnImThv5YIrUKiqLmL5PSc/VOE+Cb6EtQH45uS6PCViOrCw
         lYWu5f/zMOhOo49i9gnTmYcQGeCJA2SM6k1VBZvZROZzPGaUWy1m07d60Uxmb/Qdv+q1
         QttDjkAH44WzWhXsKTtiDroQQ5zg7qG1TitM3VihPY9qjLhMQdXV9XasFa89wOuKIncp
         e118ukkb3hns5e9SuZQWKm0cxlImT3PN3mGpkDeHdImWfhPecujAvnCwEGJcEh/gr6KS
         2RKGoVI/nUiYTrPwuqbap/nCFWfWZbY3uNSQF6Hgk7j3Ev8IXRX2vZCJfMsPoFqp2CA5
         uhIg==
X-Forwarded-Encrypted: i=1; AJvYcCWbC1BhEA3NJlHhXAAQE11djhxNbheNAasYLGsMQjgndcYNdSXuBLO0dZ4Jne7h8dhpP4AQYp6LMKZMd08=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXaVDPCWlF5iZa+KoTJOaZ+KtRdZn+pAGDGBUgWliGCMs0rc63
	OzptVmfI6O9JBieBc+1ivJ7GrhDGPRx5soF0h7c3+sLblPnZVwtuK3U2PkjJYYR6Y0yCCWCJVJo
	4uVzm2NrSajo/GydwK+/faXdZ5HclL/zeTthJxUHb89l5nbjJ3poYIJU=
X-Google-Smtp-Source: AGHT+IF+Hl0bNH/drwOVUlhkjJqhTwfxSMYDVcRotUlchcu9Wp4EE0wgsAmXVDZO4b1kawMj1JFL7dSTxhvC4H8ZrJRxQ+h/XDP8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa5:b0:3a7:e286:a560 with SMTP id
 e9e14a558f8ab-3a7e286a85fmr98594595ab.2.1733144065233; Mon, 02 Dec 2024
 04:54:25 -0800 (PST)
Date: Mon, 02 Dec 2024 04:54:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674dae01.050a0220.48a03.0025.GAE@google.com>
Subject: [syzbot] [ntfs3?] WARNING: nested lock was not taken in
 ntfs_fill_super (3)
From: syzbot <syzbot+a86ba8468e1f414dce00@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    40384c840ea1 Linux 6.13-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12c000f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ad7dafcfaa48849c
dashboard link: https://syzkaller.appspot.com/bug?extid=a86ba8468e1f414dce00
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1576d5e8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/32ee9cd04555/disk-40384c84.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e7894cd1da27/vmlinux-40384c84.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2129df5d769f/bzImage-40384c84.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/8e5370ea11d8/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a86ba8468e1f414dce00@syzkaller.appspotmail.com

ntfs3(loop0): Different NTFS sector size (2048) and media sector size (512).
==================================
WARNING: Nested lock was not taken
6.13.0-rc1-syzkaller #0 Not tainted
----------------------------------
syz.0.167/6410 is trying to lock:
ffff88805d36f110 (&sb->s_type->i_lock_key#34){+.+.}-{3:3}, at: spin_lock include/linux/spinlock.h:351 [inline]
ffff88805d36f110 (&sb->s_type->i_lock_key#34){+.+.}-{3:3}, at: iput_final fs/inode.c:1935 [inline]
ffff88805d36f110 (&sb->s_type->i_lock_key#34){+.+.}-{3:3}, at: iput fs/inode.c:1972 [inline]
ffff88805d36f110 (&sb->s_type->i_lock_key#34){+.+.}-{3:3}, at: iput+0x63e/0x890 fs/inode.c:1958

but this task is not holding:
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 0 UID: 0 PID: 6410 Comm: syz.0.167 Not tainted 6.13.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:print_lock_nested_lock_not_held kernel/locking/lockdep.c:5049 [inline]
RIP: 0010:__lock_acquire+0x1241/0x3c40 kernel/locking/lockdep.c:5217
Code: fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 08 21 00 00 48 b8 00 00 00 00 00 fc ff df 49 8b 5f 18 48 8d 7b 18 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 db 20 00 00 48 8b 73 18 48 c7 c7 20 0c 6d 8b e8
RSP: 0018:ffffc9000524f820 EFLAGS: 00010016
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff81794fa9
RDX: 0000000000000003 RSI: ffffffff8179f976 RDI: 0000000000000018
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000002 R11: 7369687420747562 R12: ffff888025af8000
R13: ffff888025af8000 R14: ffffed1004b5f15b R15: ffff888025af8b08
FS:  00007f4e610c96c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555577de8608 CR3: 000000005eac8000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 iput_final fs/inode.c:1935 [inline]
 iput fs/inode.c:1972 [inline]
 iput+0x63e/0x890 fs/inode.c:1958
 ntfs_fill_super+0x331c/0x4190 fs/ntfs3/super.c:1472
 get_tree_bdev_flags+0x38e/0x620 fs/super.c:1636
 vfs_get_tree+0x92/0x380 fs/super.c:1814
 do_new_mount fs/namespace.c:3507 [inline]
 path_mount+0x14e6/0x1f20 fs/namespace.c:3834
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount fs/namespace.c:4034 [inline]
 __x64_sys_mount+0x294/0x320 fs/namespace.c:4034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4e60381fea
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4e610c8e88 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f4e610c8f10 RCX: 00007f4e60381fea
RDX: 00000000200000c0 RSI: 000000002001f3c0 RDI: 00007f4e610c8ed0
RBP: 00000000200000c0 R08: 00007f4e610c8f10 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000002001f3c0
R13: 00007f4e610c8ed0 R14: 000000000001f393 R15: 00000000200001c0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:print_lock_nested_lock_not_held kernel/locking/lockdep.c:5049 [inline]
RIP: 0010:__lock_acquire+0x1241/0x3c40 kernel/locking/lockdep.c:5217
Code: fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 08 21 00 00 48 b8 00 00 00 00 00 fc ff df 49 8b 5f 18 48 8d 7b 18 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 db 20 00 00 48 8b 73 18 48 c7 c7 20 0c 6d 8b e8
RSP: 0018:ffffc9000524f820 EFLAGS: 00010016
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff81794fa9
RDX: 0000000000000003 RSI: ffffffff8179f976 RDI: 0000000000000018
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000002 R11: 7369687420747562 R12: ffff888025af8000
R13: ffff888025af8000 R14: ffffed1004b5f15b R15: ffff888025af8b08
FS:  00007f4e610c96c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555577de8608 CR3: 000000005eac8000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess), 3 bytes skipped:
   0:	48 c1 ea 03          	shr    $0x3,%rdx
   4:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   8:	0f 85 08 21 00 00    	jne    0x2116
   e:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  15:	fc ff df
  18:	49 8b 5f 18          	mov    0x18(%r15),%rbx
  1c:	48 8d 7b 18          	lea    0x18(%rbx),%rdi
  20:	48 89 fa             	mov    %rdi,%rdx
  23:	48 c1 ea 03          	shr    $0x3,%rdx
* 27:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2b:	0f 85 db 20 00 00    	jne    0x210c
  31:	48 8b 73 18          	mov    0x18(%rbx),%rsi
  35:	48 c7 c7 20 0c 6d 8b 	mov    $0xffffffff8b6d0c20,%rdi
  3c:	e8                   	.byte 0xe8


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

