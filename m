Return-Path: <linux-kernel+bounces-178945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 355968C59A1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 18:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBD6F281B33
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D8E17F396;
	Tue, 14 May 2024 16:19:43 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F6517F36C
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 16:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715703582; cv=none; b=i+3DpxFiAzZgZWSvmeIr95FG0ESUnDsk9WeYno1/YcdltWsPLqKR0070xYcicsYyDj/4UhP+OQV17c3yBxeSHcyhbF+mPbU/lFB3s79w+ZgPaCrM2btSjD/3hb/Cohb6PavYcRpqCk5uwARrILwFp3zs69Hy/PzcmPv1Cm9VCUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715703582; c=relaxed/simple;
	bh=XX6+dxVy+4o/yd6QLiRr3wWYuJ71u2GdWgHbNNXLIVE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XPVf/lsiZixCeP2NObJhFN84Y1oanS5H0+fYfDhSGIhQfTD3YohFx82KTSGET4HYK1wM9H+E+EXIJT7SCP1wLe+hBZqbqe+CPq9qAAqyR8Uus9RTrVoxAza6ah+3aqSnp5FXH9q2K9BOjn3y6QNPS/MXfOO6VduYgH/iTrm5mCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7e1c22e7280so529870539f.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 09:19:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715703580; x=1716308380;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MO/4TFXTo82vRQIeR2AHB5QsAO4BJa3Ijz/+ShqFgUA=;
        b=P4DrP/igrbif1YokS5INd3rhcuDXnGSH3kuFkZ7rL+143AS8lWT0PAPsB35k7ppp3t
         ujCPGkypgNv+nDLZQsIS7Vgg1HGWjlN4gwgmVQRfPpeyYvFiJMxp8W3i06nyaJP8Jxq9
         nEu5RdTzd2d86bomOTY+0kFcm2l9Pg88uNYTK4fp9qPqJkeDyUt/oAHneIWioT3OxgC+
         H3acSY7rd0cLqbglZqLUCe0ynL2NIuaRnI0onxd/313cGb18EFMvaDDZFh9A35zMorqo
         Wi7J2kdnhYCEXqBc3s2aGdewMyEeaegkUjECIVOtPnz8MjXRO+Ym4cHokuvzf46KK2gd
         fVUg==
X-Forwarded-Encrypted: i=1; AJvYcCWIxeZzm8OAEDR4hDlvoDINDUChRg7VEOJO7Ig2hEXdHLZ+0xPcXTMoSprClzwLhvAMsqilICBQPnZ+tUS2PpDCCLUP1A1HzZPlUWyd
X-Gm-Message-State: AOJu0YxoJMKzCxOb0xKlaijmdsqWO67rmbHj4cK1CaqZJkn0I0tGt5FF
	KhYYaHrOImT1f57wytcf8n8DiPVicCdPZ4W4A6b8Sp7+lYXBE2p22agGRbkofa7ggzxsfm1IY3C
	YWM5qUCXvAL5+2FBm7/LQnp+gLLoNYNFkV0toLRLOCrjcquBc4Y28vgk=
X-Google-Smtp-Source: AGHT+IHEx2XMewJWlxwYR3zxerwTCvuWGfabY4D2C6mCWTnC33WIcQWz3ePSksg6efCeDrv4hRPMkdpsaQoXJBV+NgqT3fYnNwtN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8305:b0:488:59cc:eb5b with SMTP id
 8926c6da1cb9f-48958afa76fmr917085173.3.1715703580239; Tue, 14 May 2024
 09:19:40 -0700 (PDT)
Date: Tue, 14 May 2024 09:19:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000070b5f806186c5eb0@google.com>
Subject: [syzbot] [crypto?] [bcachefs?] general protection fault in crypto_skcipher_encrypt
From: syzbot <syzbot+2e3cb81b5d1fe18a374b@syzkaller.appspotmail.com>
To: davem@davemloft.net, herbert@gondor.apana.org.au, 
	kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    75fa778d74b7 Add linux-next specific files for 20240510
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17c88d24980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ccdd3ebd6715749a
dashboard link: https://syzkaller.appspot.com/bug?extid=2e3cb81b5d1fe18a374b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d3705c980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=109afc20980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ad9391835bcf/disk-75fa778d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d827b3da9a26/vmlinux-75fa778d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8f32f0182388/bzImage-75fa778d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/94099facd0b3/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2e3cb81b5d1fe18a374b@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
bcachefs (loop0): mounting version 1.7: mi_btree_bitmap opts=metadata_checksum=none,data_checksum=none,nojournal_transaction_names
bcachefs (loop0): recovering from clean shutdown, journal seq 10
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000004: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
CPU: 1 PID: 5093 Comm: syz-executor398 Not tainted 6.9.0-rc7-next-20240510-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:crypto_skcipher_alg include/crypto/skcipher.h:375 [inline]
RIP: 0010:crypto_skcipher_encrypt+0x45/0x130 crypto/skcipher.c:637
Code: 21 fd 49 8d 5e 40 48 89 d8 48 c1 e8 03 42 80 3c 20 00 74 08 48 89 df e8 69 2c 87 fd 48 8b 1b 48 8d 7b 18 48 89 f8 48 c1 e8 03 <42> 80 3c 20 00 74 05 e8 4f 2c 87 fd 4c 8b 7b 18 48 83 c3 04 48 89
RSP: 0018:ffffc900024fdd98 EFLAGS: 00010202
RAX: 0000000000000004 RBX: 0000000000000008 RCX: ffff88802a9d1e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000020
RBP: ffffc900024fe330 R08: ffffc900024fde9f R09: 0000000000000000
R10: ffffc900024fde90 R11: fffff5200049fbd4 R12: dffffc0000000000
R13: dffffc0000000000 R14: ffffc900024fde60 R15: 1ffff9200049fbc4
FS:  000055557e03c380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000080 CR3: 000000002c426000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 do_encrypt_sg fs/bcachefs/checksum.c:108 [inline]
 do_encrypt+0x66b/0x7d0 fs/bcachefs/checksum.c:150
 gen_poly_key fs/bcachefs/checksum.c:191 [inline]
 bch2_checksum+0x1f8/0x730 fs/bcachefs/checksum.c:227
 bch2_btree_node_read_done+0x1a3a/0x6770 fs/bcachefs/btree_io.c:1069
 btree_node_read_work+0x68b/0x1260 fs/bcachefs/btree_io.c:1340
 bch2_btree_node_read+0x2467/0x2a40
 __bch2_btree_root_read fs/bcachefs/btree_io.c:1764 [inline]
 bch2_btree_root_read+0x61e/0x970 fs/bcachefs/btree_io.c:1788
 read_btree_roots+0x22d/0x7b0 fs/bcachefs/recovery.c:472
 bch2_fs_recovery+0x2346/0x3700 fs/bcachefs/recovery.c:800
 bch2_fs_start+0x356/0x5b0 fs/bcachefs/super.c:1031
 bch2_fs_open+0xa8d/0xdf0 fs/bcachefs/super.c:2123
 bch2_mount+0x71d/0x1320 fs/bcachefs/fs.c:1917
 legacy_get_tree+0xee/0x190 fs/fs_context.c:662
 vfs_get_tree+0x90/0x2a0 fs/super.c:1780
 do_new_mount+0x2be/0xb40 fs/namespace.c:3352
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f72c7b448ba
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffde59ed9d8 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffde59ed9f0 RCX: 00007f72c7b448ba
RDX: 0000000020011a00 RSI: 0000000020011a40 RDI: 00007ffde59ed9f0
RBP: 0000000000000004 R08: 00007ffde59eda30 R09: 00000000000119f1
R10: 0000000001200014 R11: 0000000000000282 R12: 0000000001200014
R13: 00007ffde59eda30 R14: 0000000000000003 R15: 0000000001000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:crypto_skcipher_alg include/crypto/skcipher.h:375 [inline]
RIP: 0010:crypto_skcipher_encrypt+0x45/0x130 crypto/skcipher.c:637
Code: 21 fd 49 8d 5e 40 48 89 d8 48 c1 e8 03 42 80 3c 20 00 74 08 48 89 df e8 69 2c 87 fd 48 8b 1b 48 8d 7b 18 48 89 f8 48 c1 e8 03 <42> 80 3c 20 00 74 05 e8 4f 2c 87 fd 4c 8b 7b 18 48 83 c3 04 48 89
RSP: 0018:ffffc900024fdd98 EFLAGS: 00010202
RAX: 0000000000000004 RBX: 0000000000000008 RCX: ffff88802a9d1e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000020
RBP: ffffc900024fe330 R08: ffffc900024fde9f R09: 0000000000000000
R10: ffffc900024fde90 R11: fffff5200049fbd4 R12: dffffc0000000000
R13: dffffc0000000000 R14: ffffc900024fde60 R15: 1ffff9200049fbc4
FS:  000055557e03c380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000080 CR3: 000000002c426000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	21 fd                	and    %edi,%ebp
   2:	49 8d 5e 40          	lea    0x40(%r14),%rbx
   6:	48 89 d8             	mov    %rbx,%rax
   9:	48 c1 e8 03          	shr    $0x3,%rax
   d:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1)
  12:	74 08                	je     0x1c
  14:	48 89 df             	mov    %rbx,%rdi
  17:	e8 69 2c 87 fd       	call   0xfd872c85
  1c:	48 8b 1b             	mov    (%rbx),%rbx
  1f:	48 8d 7b 18          	lea    0x18(%rbx),%rdi
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2f:	74 05                	je     0x36
  31:	e8 4f 2c 87 fd       	call   0xfd872c85
  36:	4c 8b 7b 18          	mov    0x18(%rbx),%r15
  3a:	48 83 c3 04          	add    $0x4,%rbx
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89


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

