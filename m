Return-Path: <linux-kernel+bounces-341843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 719B7988701
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 16:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0FF91F2230F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 14:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB7113BAF1;
	Fri, 27 Sep 2024 14:22:34 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54484138490
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 14:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727446954; cv=none; b=Ld4KErmhhaKsnQl4tRKajc15wBQs3Kqyn7hdOV25puzWHkBvf8cNxIdfcGMM+IPrJAO/QTSunXgm5VfYVmYqgR7h1i8yN4eLR4yEE/R4oSl6nGOdT6B1t32gUgsy1PlyeNwud6w68ab6WQtp+fpqLk1icJHQCzrzU3u0kMfItGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727446954; c=relaxed/simple;
	bh=aIhht4PG68qhRfY6HBtQm3jSEVcyG9Is78AbjW13dpc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MGEZQqjjR49rIPw7AjT6der/WcX3DFYTVT3ij5Q4lqSW3HmFXJ7USLoeUC14jvHxDnUlcGLjTvORGpGQHTjre6wfUmSVpQCM2M0uvqih0+oXl84j9oXYX3l/6RnXd3WtHS4DP5883I4iAwRYngx0ae1VG6HiHamC4F/gQz6gU0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8324396d0abso220263439f.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 07:22:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727446951; x=1728051751;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pQvv9V/jjUoYbB6kLmOvJiieuB/iUQwkX+2sB6oQSNk=;
        b=jbQRqS5J9C6wrO85GSChdCBc0SwJcRHLUUloZkSOfasM9HJLW9AB44IXt3ud77jQAo
         pnVt4bst2EmZYpOaBzodi5odHVDb6XQvxFQ6IMOZ1qVk7X6Xwve8dZpUB7U2Z+K54afB
         iM2Xwhf4LUYq1m4hQhpFiB1SEPnSTinhHKeH5Xc5JTNGl0qFjyBEI8czgptQSCzGQ6oM
         3SrTMhao4KzYknjYwCX6V2LYKo70UuH0LxA79SZyc8Pu8s8OjH+NqhnWTs5A/sYNVYcS
         28gt0PPyCrNtmN9smxityA4yyT+bOgtoum46k6PwN3FGkLYi4aZYuOD8FstYfKO5uRlH
         vMMA==
X-Forwarded-Encrypted: i=1; AJvYcCUJzh6ANX+uo9KXdVYK54Y4JZw6rZ+lUejJvXJdU/9kxv3nwx3kYbzT85r+iMcjWnORjnZujrBRdseOrsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlkAo4wc0YH4VF1IdOFe9rgn7Nfe3BTXyHK8vCMSFU0PhOF937
	zNvQXD3s4jiKy+ZC9G76WoNBGJLvGp9t1xAQdzPWwa2Hxl3AmATWn09Dkye+pLnrJlKIG/UfrX3
	LEM56cBTlOcKbAH8f2b+EJPoqO7We+P390Eb7/5mHAu6JfFIh8MH+eBQ=
X-Google-Smtp-Source: AGHT+IFaPG9P8yNET5Pe7AZcXVYyi/C5S2auebhjEWfVj2jbXu3tpYOGcPHmlOiI8wvKMqv1Z4GdtYiC04x7OQeM+Qw0Ym4mUgaP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4c:0:b0:3a3:449b:5989 with SMTP id
 e9e14a558f8ab-3a3452ba439mr32011415ab.21.1727446951528; Fri, 27 Sep 2024
 07:22:31 -0700 (PDT)
Date: Fri, 27 Sep 2024 07:22:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f6bfa7.050a0220.38ace9.0019.GAE@google.com>
Subject: [syzbot] [btrfs?] general protection fault in btrfs_update_reloc_root
From: syzbot <syzbot+283673dbc38527ef9f3d@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    932d2d1fcb2b Merge tag 'dlm-6.12' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=179a3177980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c208b3605ba9ec44
dashboard link: https://syzkaller.appspot.com/bug?extid=283673dbc38527ef9f3d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-932d2d1f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fbcb7198214b/vmlinux-932d2d1f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/418eaebf4817/bzImage-932d2d1f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+283673dbc38527ef9f3d@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
BTRFS: device fsid c9fe44da-de57-406a-8241-57ec7d4412cf devid 1 transid 8 /dev/loop0 (7:0) scanned by syz.0.0 (5111)
BTRFS info (device loop0): first mount of filesystem c9fe44da-de57-406a-8241-57ec7d4412cf
BTRFS info (device loop0): using crc32c (crc32c-intel) checksum algorithm
BTRFS info (device loop0): disk space caching is enabled
BTRFS warning (device loop0): space cache v1 is being deprecated and will be removed in a future release, please use -o space_cache=v2
BTRFS info (device loop0): rebuilding free space tree
BTRFS info (device loop0): disabling free space tree
BTRFS info (device loop0): clearing compat-ro feature flag for FREE_SPACE_TREE (0x1)
BTRFS info (device loop0): clearing compat-ro feature flag for FREE_SPACE_TREE_VALID (0x2)
BTRFS info (device loop0): balance: start -d -m
BTRFS info (device loop0): relocating block group 6881280 flags data|metadata
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 1
CPU: 0 UID: 0 PID: 5111 Comm: syz.0.0 Not tainted 6.11.0-syzkaller-05442-g932d2d1fcb2b #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 fail_dump lib/fault-inject.c:52 [inline]
 should_fail_ex+0x3b0/0x4e0 lib/fault-inject.c:153
 should_failslab+0xac/0x100 mm/failslab.c:45
 slab_pre_alloc_hook mm/slub.c:4039 [inline]
 slab_alloc_node mm/slub.c:4115 [inline]
 kmem_cache_alloc_noprof+0x6c/0x2a0 mm/slub.c:4142
 start_transaction+0x830/0x1670 fs/btrfs/transaction.c:676
 prepare_to_relocate+0x31f/0x4c0 fs/btrfs/relocation.c:3642
 relocate_block_group+0x169/0xd20 fs/btrfs/relocation.c:3678
 btrfs_relocate_block_group+0x77d/0xd90 fs/btrfs/relocation.c:4150
 btrfs_relocate_chunk+0x12c/0x3b0 fs/btrfs/volumes.c:3376
 __btrfs_balance+0x1b0f/0x26b0 fs/btrfs/volumes.c:4160
 btrfs_balance+0xbdc/0x10c0 fs/btrfs/volumes.c:4537
 btrfs_ioctl_balance+0x493/0x7c0 fs/btrfs/ioctl.c:3673
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9ff217def9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9ff2edc038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f9ff2335f80 RCX: 00007f9ff217def9
RDX: 0000000020000180 RSI: 00000000c4009420 RDI: 0000000000000004
RBP: 00007f9ff2edc090 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 0000000000000000 R14: 00007f9ff2335f80 R15: 00007ffcf8ef9128
 </TASK>
BTRFS info (device loop0): balance: ended with status: -12
Oops: general protection fault, probably for non-canonical address 0xdffffc00000000cc: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000660-0x0000000000000667]
CPU: 0 UID: 0 PID: 5111 Comm: syz.0.0 Not tainted 6.11.0-syzkaller-05442-g932d2d1fcb2b #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:btrfs_update_reloc_root+0x362/0xa80 fs/btrfs/relocation.c:926
Code: e8 03 42 80 3c 20 00 74 08 4c 89 f7 e8 07 da 34 fe bb 65 06 00 00 49 03 1e 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <0f> b6 04 08 84 c0 4c 8b 64 24 18 0f 85 c9 05 00 00 0f b6 1b 31 ff
RSP: 0018:ffffc9000316f700 EFLAGS: 00010207
RAX: 00000000000000cc RBX: 0000000000000665 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000003 RDI: 00000000ffffffff
RBP: ffffc9000316f810 R08: ffffffff83c687df R09: fffff5200062def4
R10: dffffc0000000000 R11: fffff5200062def4 R12: dffffc0000000000
R13: 0000000000000001 R14: ffff8880008111d0 R15: ffff888035802038
FS:  00007f9ff2edc6c0(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9fe73f9000 CR3: 000000003feac000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 commit_fs_roots+0x2ee/0x720 fs/btrfs/transaction.c:1496
 btrfs_commit_transaction+0xfaf/0x3740 fs/btrfs/transaction.c:2430
 del_balance_item fs/btrfs/volumes.c:3678 [inline]
 reset_balance_state+0x25e/0x3c0 fs/btrfs/volumes.c:3742
 btrfs_balance+0xead/0x10c0 fs/btrfs/volumes.c:4574
 btrfs_ioctl_balance+0x493/0x7c0 fs/btrfs/ioctl.c:3673
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9ff217def9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9ff2edc038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f9ff2335f80 RCX: 00007f9ff217def9
RDX: 0000000020000180 RSI: 00000000c4009420 RDI: 0000000000000004
RBP: 00007f9ff2edc090 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 0000000000000000 R14: 00007f9ff2335f80 R15: 00007ffcf8ef9128
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:btrfs_update_reloc_root+0x362/0xa80 fs/btrfs/relocation.c:926
Code: e8 03 42 80 3c 20 00 74 08 4c 89 f7 e8 07 da 34 fe bb 65 06 00 00 49 03 1e 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <0f> b6 04 08 84 c0 4c 8b 64 24 18 0f 85 c9 05 00 00 0f b6 1b 31 ff
RSP: 0018:ffffc9000316f700 EFLAGS: 00010207
RAX: 00000000000000cc RBX: 0000000000000665 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000003 RDI: 00000000ffffffff
RBP: ffffc9000316f810 R08: ffffffff83c687df R09: fffff5200062def4
R10: dffffc0000000000 R11: fffff5200062def4 R12: dffffc0000000000
R13: 0000000000000001 R14: ffff8880008111d0 R15: ffff888035802038
FS:  00007f9ff2edc6c0(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055e5284b79b2 CR3: 000000003feac000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	e8 03 42 80 3c       	call   0x3c804208
   5:	20 00                	and    %al,(%rax)
   7:	74 08                	je     0x11
   9:	4c 89 f7             	mov    %r14,%rdi
   c:	e8 07 da 34 fe       	call   0xfe34da18
  11:	bb 65 06 00 00       	mov    $0x665,%ebx
  16:	49 03 1e             	add    (%r14),%rbx
  19:	48 89 d8             	mov    %rbx,%rax
  1c:	48 c1 e8 03          	shr    $0x3,%rax
  20:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  27:	fc ff df
* 2a:	0f b6 04 08          	movzbl (%rax,%rcx,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
  35:	0f 85 c9 05 00 00    	jne    0x604
  3b:	0f b6 1b             	movzbl (%rbx),%ebx
  3e:	31 ff                	xor    %edi,%edi


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

