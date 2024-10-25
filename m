Return-Path: <linux-kernel+bounces-381094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 363A69AFA45
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E14951F22B8D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 06:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56FD1B0F3F;
	Fri, 25 Oct 2024 06:48:33 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6BE18DF67
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 06:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729838913; cv=none; b=eRGiVQ/bJu7N7CnvagDV2Bv5au2cSf8Q55NpBiNiYPge87KlceakFtnvASYcfaLr5EfVX+0+3mS4cRgMRRtke83xluskseodltYjT74JMKbsBB1zEY3K9SKQLKjIjYz2i3CNafofQMryaAEVU4u/vqCfo2vZy80L+wYPqIwA2ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729838913; c=relaxed/simple;
	bh=NXJ5Q8l8Vi8Bo2tqa01yUQxn7Bzkn9FEZNVBr9+o5Uc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=onGj/4r1klkZw5uchheBkzT19CKwbw5ntjOwJ7PhlWmLkUo5z4rt70w9wnFTbZIW1/pe5zeW03oS0HlcoKNT31w0qmic1cB8a2Md0Sw0QuhheXW/ZJOAo3v4qfje9fH0NNyUlMOlryVmn2a/hwHcZtm4zfdqj54qLAlTt61Ub/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3c70e58bfso16769425ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 23:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729838910; x=1730443710;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kjpesi43ZtnpGfZMG7/6p241qNZ/QUOcTdIlkJa4kaE=;
        b=WTiZHwMsolVq52IVz26ncs/KByJAVT6iXO4Z0ixDUehGXEb1TIMQkQNXUvJuWtYIKg
         fBXOZD1CKYV2qeI9N6Vncv4UgGm8m4eu3eFsDUMdIxPspEXTjJB6KNhCKbosVRKG9OON
         QvVA6BwWNUK/i9f+2w1R4Gq9sPxPEaVXoI0GcfBPaGExsnUkBHjTK6EQcR0FyFszgen5
         gaNSgMgJdNZyhRNZbYmwFc7ol2hCBgwwoT7i3HFiSbzU8kQkRyGIX1ESERUUWlKA/BLb
         F+f99gYvSaiDaZRsc8AYp19X7yl4WZSh/CevscEK/qwLQ/4X3BNpB70BYqXG+1rYicBi
         Z7AQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0QR7aX/nxgoJgyeYsKSZu5h4R6EI7osEE76aC3Rzdco5ZtOz0ezX7O2zNF1zQykqpRKOaODSDCi0ScXM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk40xmThsnMQm1wNh2TsX/xERbX6qB4QEfBjXXJ1rFI9syEcpD
	5/sP449GlBsZmf8JWTTkUcz/xVO1e4eRfL6Opl1Rshfsv37OSVIm8Chk3LEa/ZVya/CcWdW9Ow5
	vzhY3pdx+mxtwkar73azxmH5BpNf4Bf81UnE3Ev+mIQWlpgE9Os5TQCQ=
X-Google-Smtp-Source: AGHT+IEUOZ+2LPDyfKS5+wy9it4t61yy3mYlMA0Eo0EQEaThVfgJMc4Ycjj8+vG46HRIheRggEwgvQ5eqN1qaKBOnYbr9+U8PnYo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aac:b0:3a3:9792:e9e8 with SMTP id
 e9e14a558f8ab-3a4d592c8famr91855645ab.5.1729838910123; Thu, 24 Oct 2024
 23:48:30 -0700 (PDT)
Date: Thu, 24 Oct 2024 23:48:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671b3f3e.050a0220.2eb763.00d4.GAE@google.com>
Subject: [syzbot] [bcachefs?] general protection fault in bch2_btree_path_traverse_one
From: syzbot <syzbot+e22007d6acb9c87c2362@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c2ee9f594da8 KVM: selftests: Fix build on on non-x86 archi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=126cd0a7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc6f8ce8c5369043
dashboard link: https://syzkaller.appspot.com/bug?extid=e22007d6acb9c87c2362
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=166cd0a7980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15378287980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-c2ee9f59.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8a3541902b13/vmlinux-c2ee9f59.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a00efacc2604/bzImage-c2ee9f59.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/1b5cb4a585a3/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e22007d6acb9c87c2362@syzkaller.appspotmail.com

bcachefs (loop0): stripes_read... done
bcachefs (loop0): snapshots_read... done
bcachefs (loop0): check_allocations... done
bcachefs (loop0): going read-write
bcachefs (loop0): journal_replay...
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000013: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000098-0x000000000000009f]
CPU: 0 UID: 0 PID: 5090 Comm: syz-executor250 Not tainted 6.12.0-rc4-syzkaller-00047-gc2ee9f594da8 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:btree_path_lock_root fs/bcachefs/btree_iter.c:732 [inline]
RIP: 0010:bch2_btree_path_traverse_one+0x94a/0x2940 fs/bcachefs/btree_iter.c:1170
Code: 89 44 24 60 42 80 3c 20 00 74 08 4c 89 ef e8 cd ea e5 fd 49 8b 45 00 48 89 44 24 48 48 8d 90 98 00 00 00 48 89 d0 48 c1 e8 03 <42> 0f b6 04 20 84 c0 48 89 94 24 80 00 00 00 0f 85 ee 10 00 00 4c
RSP: 0018:ffffc9000aebcf40 EFLAGS: 00010202
RAX: 0000000000000013 RBX: 0000000000000000 RCX: ffff8880008da440
RDX: 0000000000000098 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000aebd230 R08: ffffffff8418b260 R09: ffffffff841892d9
R10: 0000000000000002 R11: ffff8880008da440 R12: dffffc0000000000
R13: ffff888041d014d8 R14: ffff888040254408 R15: 000000000000110b
FS:  0000555564217380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005564fb1350d0 CR3: 0000000040b92000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bch2_btree_path_traverse fs/bcachefs/btree_iter.h:247 [inline]
 __bch2_btree_iter_peek fs/bcachefs/btree_iter.c:2197 [inline]
 bch2_btree_iter_peek_upto+0xb58/0x70e0 fs/bcachefs/btree_iter.c:2297
 bch2_btree_iter_peek_upto_type fs/bcachefs/btree_iter.h:685 [inline]
 bch2_bucket_alloc_freelist fs/bcachefs/alloc_foreground.c:491 [inline]
 bch2_bucket_alloc_trans+0x1122/0x3a50 fs/bcachefs/alloc_foreground.c:644
 bch2_bucket_alloc_set_trans+0x517/0xd30 fs/bcachefs/alloc_foreground.c:804
 __open_bucket_add_buckets+0x10dc/0x1b60 fs/bcachefs/alloc_foreground.c:1049
 open_bucket_add_buckets+0x33a/0x410 fs/bcachefs/alloc_foreground.c:1093
 bch2_alloc_sectors_start_trans+0xce9/0x2030
 __bch2_btree_node_alloc fs/bcachefs/btree_update_interior.c:343 [inline]
 bch2_btree_reserve_get+0x612/0x1890 fs/bcachefs/btree_update_interior.c:554
 bch2_btree_update_start+0xe56/0x14e0 fs/bcachefs/btree_update_interior.c:1252
 bch2_btree_split_leaf+0x123/0x840 fs/bcachefs/btree_update_interior.c:1850
 bch2_trans_commit_error+0x212/0x1390 fs/bcachefs/btree_trans_commit.c:942
 __bch2_trans_commit+0x7ead/0x93c0 fs/bcachefs/btree_trans_commit.c:1140
 bch2_trans_commit fs/bcachefs/btree_update.h:184 [inline]
 bch2_journal_replay+0x1a3a/0x2a40 fs/bcachefs/recovery.c:318
 bch2_run_recovery_pass+0xf0/0x1e0 fs/bcachefs/recovery_passes.c:185
 bch2_run_recovery_passes+0x387/0x870 fs/bcachefs/recovery_passes.c:232
 bch2_fs_recovery+0x25cc/0x39c0 fs/bcachefs/recovery.c:862
 bch2_fs_start+0x356/0x5b0 fs/bcachefs/super.c:1036
 bch2_fs_get_tree+0xd68/0x1710 fs/bcachefs/fs.c:2174
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4a8f435cba
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc0b30fb48 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffc0b30fb60 RCX: 00007f4a8f435cba
RDX: 00000000200058c0 RSI: 0000000020005900 RDI: 00007ffc0b30fb60
RBP: 0000000000000004 R08: 00007ffc0b30fba0 R09: 00000000000058dd
R10: 0000000000010000 R11: 0000000000000282 R12: 0000000000010000
R13: 00007ffc0b30fba0 R14: 0000000000000003 R15: 0000000001000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:btree_path_lock_root fs/bcachefs/btree_iter.c:732 [inline]
RIP: 0010:bch2_btree_path_traverse_one+0x94a/0x2940 fs/bcachefs/btree_iter.c:1170
Code: 89 44 24 60 42 80 3c 20 00 74 08 4c 89 ef e8 cd ea e5 fd 49 8b 45 00 48 89 44 24 48 48 8d 90 98 00 00 00 48 89 d0 48 c1 e8 03 <42> 0f b6 04 20 84 c0 48 89 94 24 80 00 00 00 0f 85 ee 10 00 00 4c
RSP: 0018:ffffc9000aebcf40 EFLAGS: 00010202
RAX: 0000000000000013 RBX: 0000000000000000 RCX: ffff8880008da440
RDX: 0000000000000098 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000aebd230 R08: ffffffff8418b260 R09: ffffffff841892d9
R10: 0000000000000002 R11: ffff8880008da440 R12: dffffc0000000000
R13: ffff888041d014d8 R14: ffff888040254408 R15: 000000000000110b
FS:  0000555564217380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005564fb1350d0 CR3: 0000000040b92000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	89 44 24 60          	mov    %eax,0x60(%rsp)
   4:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1)
   9:	74 08                	je     0x13
   b:	4c 89 ef             	mov    %r13,%rdi
   e:	e8 cd ea e5 fd       	call   0xfde5eae0
  13:	49 8b 45 00          	mov    0x0(%r13),%rax
  17:	48 89 44 24 48       	mov    %rax,0x48(%rsp)
  1c:	48 8d 90 98 00 00 00 	lea    0x98(%rax),%rdx
  23:	48 89 d0             	mov    %rdx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 0f b6 04 20       	movzbl (%rax,%r12,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	48 89 94 24 80 00 00 	mov    %rdx,0x80(%rsp)
  38:	00
  39:	0f 85 ee 10 00 00    	jne    0x112d
  3f:	4c                   	rex.WR


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

