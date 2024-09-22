Return-Path: <linux-kernel+bounces-335150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC5097E1ED
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 15:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AC811F212F1
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 13:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDE233E1;
	Sun, 22 Sep 2024 13:58:29 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CF8A23
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 13:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727013509; cv=none; b=kjpeZWyedCSOj4CV/j+SqUrw170XAO6tBc6n6UrbDvmgFVOBjc0Av5BwtibKPMo0nw7UGE1BwiNP5QiJd+2tXOlKj51IPf8AsqADlBIIcW+QdHH82+xoYHvd2+G5QbQzrDrczjcHICCjSBJjB86/suZtRKbAfIqObmougVbtiNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727013509; c=relaxed/simple;
	bh=gNw89nA/C05OLVy7A5XYqdZYsCLRKm08zgGKSlWDEFY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hiKuYg3oRLmPSm3fRdhrHliSA/GzZPIQIznrQ0uc93vW/Hcs2K9FlAFoJe2SS3nYAZNm2pK9LigBptGVVbnE2tjyEes7gbGjPPVlnDODiO+r6x06FTz/e1KvQrLunSR+wL0K3U6ImMLmAc/FZ5saIQ3dLTky/DCkBjgTIfGUoKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39fe9710b7fso58229135ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 06:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727013506; x=1727618306;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WuJBNqJzJ4KYbZNBr4rG9AefrRgvoDIAkWkxFCRgscs=;
        b=bxkUs0BmtHPJL8MSUuPruLC3NB//zGFcVHBCZ0CjnpYCDG/PoelE+9gFrT74cyPVX1
         mQTX0+QYbcbf0EkHe72v2PXUfNJrSt5h6UIRE/zlwFL07fCfLUMi0/LQhUXhtvN33ci9
         +K9x0pbNUnTbUnf5+9lUVqfFUgKLi6YTZGDCGr89s3R6RjhmTbqy/c9hDFS/VbqaXw93
         bMupHP55ICad6Rmv6nHSvFbg/zLoaWc3HYqUQsDhiXIechYOHwGfPwffMYtG6wEvAj5M
         AAJq1EXijjPO0X+TTkJJIbLPQ9MXT/e3+tFuGICMwyyySoYp1eYsLjjosHVvISfSrTlR
         yzxQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9Gf9KuD89a+trJ7YnegfaynbOShu/7SAqZ9d4yF1yCGXU17JonSs+4Heq57k3A6NTMvr3bjICnGby0TM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyfuXIsUm7ZTkGfwJp2D9YQ56TsjBkV7dtK61MB8qECYHxm0MA
	D6wGHQd7W14GyFXeuUDT3iGn6EpFqahnDeAox7a85dwEF9wRLAMcmVK6Vm6z3q4z4IXOeYmMjEe
	HHvr5REQtj3CiOh5OFyekNvAi1Q8lnEEzCEIFkYPId/LJsHmtqxq8mCA=
X-Google-Smtp-Source: AGHT+IGkTugyPV0KXwzkDmwsGN9IdJKGnO04XwTk0ZJrdTmcYTrgv92sgf/HHn4Anq2OABs/IPstmqbx1PZoxcjf3npeTegmxHCu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a69:b0:3a0:978b:e6b with SMTP id
 e9e14a558f8ab-3a0c8d38877mr73819865ab.21.1727013506654; Sun, 22 Sep 2024
 06:58:26 -0700 (PDT)
Date: Sun, 22 Sep 2024 06:58:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f02282.050a0220.1b7b75.0003.GAE@google.com>
Subject: [syzbot] [bcachefs?] kernel BUG in bch2_quota_check_limit
From: syzbot <syzbot+8364d1e040a88ed5657d@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4a39ac5b7d62 Merge tag 'random-6.12-rc1-for-linus' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1645db00580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd14c10ec1b6af25
dashboard link: https://syzkaller.appspot.com/bug?extid=8364d1e040a88ed5657d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-4a39ac5b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e77a3b8ac098/vmlinux-4a39ac5b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f8ee7a5fea46/bzImage-4a39ac5b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8364d1e040a88ed5657d@syzkaller.appspotmail.com

  fragmentation     0
  bp_start          8
  invalid data type (got 2 should be 7): delete?, fixing
bcachefs (loop0): flagging btree snapshots lost data
error reading btree root snapshots l=0: btree_node_read_error, fixing
bcachefs (loop0): will run btree node scan
bcachefs (loop0): scan_for_btree_nodes...
bch2_scan_for_btree_nodes: nodes found after overwrites:
  extents l=0 seq=1 journal_seq=4 cookie=b77ad9ee5a61c7f0 POS_MIN-SPOS_MAX ptr: 0:27:0 gen 0
  xattrs l=0 seq=1 journal_seq=4 cookie=1477538288e6fe55 POS_MIN-SPOS_MAX ptr: 0:31:0 gen 0
  lru l=0 seq=1 journal_seq=8796093022212 cookie=d19419031ca39bdb POS_MIN-SPOS_MAX ptr: 0:28:0 gen 0
  deleted_inodes l=0 seq=1 journal_seq=0 cookie=a34c10fbe2d33ffa POS_MIN-SPOS_MAX ptr: 0:42:0 gen 0
 done
bcachefs (loop0): check_topology...
bcachefs (loop0): btree root snapshots unreadable, must recover from scan
no nodes found for btree snapshots, continuing
 done
bcachefs (loop0): accounting_read... done
bcachefs (loop0): alloc_read... done
bcachefs (loop0): stripes_read... done
bcachefs (loop0): snapshots_read...
bcachefs (loop0): running explicit recovery pass reconstruct_snapshots (20), currently at snapshots_read (6)
 done
bcachefs (loop0): check_allocations...
btree ptr not marked in member info btree allocated bitmap
  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq 75277f57b0c8c24 written 32 min_key POS_MIN durability: 1 ptr: 0:26:0 gen 0, fixing
btree ptr not marked in member info btree allocated bitmap
  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq 19bc58a6c09b6540 written 24 min_key POS_MIN durability: 1 ptr: 0:38:0 gen 0, fixing
btree ptr not marked in member info btree allocated bitmap
  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c18f4a4face03c6 written 24 min_key POS_MIN durability: 1 ptr: 0:41:0 gen 0, fixing
btree ptr not marked in member info btree allocated bitmap
  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq 7675f41d391e5d36 written 16 min_key POS_MIN durability: 1 ptr: 0:35:0 gen 0, fixing
btree ptr not marked in member info btree allocated bitmap
  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq 9a831b4a3f983356 written 32 min_key POS_MIN durability: 1 ptr: 0:29:0 gen 0, fixing
bucket 0:14 gen 0 has wrong data_type: got free, should be journal, fixing
bucket 0:14 gen 0 data type journal has wrong dirty_sectors: got 0, should be 256, fixing
bucket 0:32 gen 0 has wrong data_type: got btree, should be need_discard, fixing
bucket 0:32 gen 0 data type need_discard has wrong dirty_sectors: got 256, should be 0, fixing
 done
bcachefs (loop0): going read-write
bcachefs (loop0): journal_replay... done
bcachefs (loop0): reconstruct_snapshots...
snapshot node 4294967295 from tree 4294967295 missing, recreating
 done
bcachefs (loop0): resume_logged_ops... done
bcachefs (loop0): delete_dead_inodes... done
bcachefs (loop0): reading quotas
bcachefs (loop0): quotas done
bcachefs (loop0): done starting filesystem
------------[ cut here ]------------
kernel BUG at fs/bcachefs/quota.c:232!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5114 Comm: syz.0.0 Not tainted 6.11.0-syzkaller-05319-g4a39ac5b7d62 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:bch2_quota_check_limit+0xd48/0xd70 fs/bcachefs/quota.c:232
Code: de e8 ac 96 b0 00 e9 9b fa ff ff e8 12 df 55 fd 48 c7 c7 50 30 f6 8e 48 89 de e8 93 96 b0 00 e9 d8 fa ff ff e8 f9 de 55 fd 90 <0f> 0b e8 f1 de 55 fd 90 0f 0b e8 e9 de 55 fd 90 0f 0b e8 e1 de 55
RSP: 0018:ffffc9000316f370 EFLAGS: 00010283
RAX: ffffffff843e0007 RBX: 0000000000000000 RCX: 0000000000040000
RDX: ffffc900031b1000 RSI: 0000000000032dc1 RDI: 0000000000032dc2
RBP: fffffffffffffff8 R08: ffffffff843df34f R09: fffffffffffffff8
R10: dffffc0000000000 R11: fffffbfff2037f36 R12: ffff88803b985000
R13: 0000000000000000 R14: fffffffffffffff8 R15: ffffc9000316f4a0
FS:  00007f74ca8fb6c0(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055611ee8b958 CR3: 0000000035cea000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bch2_quota_acct+0x3f9/0x750 fs/bcachefs/quota.c:299
 bch2_i_sectors_acct fs/bcachefs/fs-io.h:138 [inline]
 bchfs_truncate+0x984/0xc70 fs/bcachefs/fs-io.c:484
 notify_change+0xbca/0xe90 fs/attr.c:503
 do_truncate+0x220/0x310 fs/open.c:65
 handle_truncate fs/namei.c:3395 [inline]
 do_open fs/namei.c:3778 [inline]
 path_openat+0x2e1e/0x3590 fs/namei.c:3933
 do_filp_open+0x235/0x490 fs/namei.c:3960
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_creat fs/open.c:1506 [inline]
 __se_sys_creat fs/open.c:1500 [inline]
 __x64_sys_creat+0x123/0x170 fs/open.c:1500
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f74c9b7def9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f74ca8fb038 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007f74c9d35f80 RCX: 00007f74c9b7def9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020001180
RBP: 00007f74c9bf0b76 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f74c9d35f80 R15: 00007fffa9737808
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bch2_quota_check_limit+0xd48/0xd70 fs/bcachefs/quota.c:232
Code: de e8 ac 96 b0 00 e9 9b fa ff ff e8 12 df 55 fd 48 c7 c7 50 30 f6 8e 48 89 de e8 93 96 b0 00 e9 d8 fa ff ff e8 f9 de 55 fd 90 <0f> 0b e8 f1 de 55 fd 90 0f 0b e8 e9 de 55 fd 90 0f 0b e8 e1 de 55
RSP: 0018:ffffc9000316f370 EFLAGS: 00010283
RAX: ffffffff843e0007 RBX: 0000000000000000 RCX: 0000000000040000
RDX: ffffc900031b1000 RSI: 0000000000032dc1 RDI: 0000000000032dc2
RBP: fffffffffffffff8 R08: ffffffff843df34f R09: fffffffffffffff8
R10: dffffc0000000000 R11: fffffbfff2037f36 R12: ffff88803b985000
R13: 0000000000000000 R14: fffffffffffffff8 R15: ffffc9000316f4a0
FS:  00007f74ca8fb6c0(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb45c78c96e CR3: 0000000035cea000 CR4: 0000000000350ef0
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

