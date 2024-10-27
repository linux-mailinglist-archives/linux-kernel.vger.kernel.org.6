Return-Path: <linux-kernel+bounces-383430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 674719B1B94
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 02:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B04CF1F217DB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 01:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D14CC8E0;
	Sun, 27 Oct 2024 01:10:36 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74068F6B
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 01:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729991436; cv=none; b=dVSeRvHSOIJVzsQAx42x08EDpigF/L6tsvsAEmUzILummOLttSc/EwAdIm97DiLsqoopWN7ciSpOxshMJBM0RDO2ny4O9qzlgBr/iZ8pyU4HqI1Gx7/LNhHxOJDesh4mfrzamOOVl3+D6DSALGCQEFW2JzoU0irXNCbdpLy6xD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729991436; c=relaxed/simple;
	bh=RVe5zB2v8sRHDPxZBzwzhebeG6gsX4agM1TUjewIrVc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Td6MGswwD5/iSyR/4/gr/i2MYvTgqycOx9YWqs8xc92V5lk8I0bn97T4izc5sukBshW4SrXluWmN0if3xadA+vNSXcArk9PzolivQaE2BQGQxPnkRx7TJ6oBWtR0MCkhxWO+eZPr/bL/oIQ+hToBno222Djrjjp2/x22TdUuG60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3e1ef9102so31387745ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 18:10:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729991432; x=1730596232;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hTIHbezt4reFwj95Pb6zRzUVs06JKt5WN8r4BEZS25Y=;
        b=YsiT4QD2WG+BN1TWL83xTrJh0gQGn4No+ejZmBtDvV4D2KNZysRu8Au/SPumt3bawH
         HaIpE/YxDeckEwWKLnoBtFZ28Z+6D+MW1ojWuPCCCU7tr1qHWKHIQrUp1NMVA49zEVmD
         B7nDiP02OOEDsfQw+ptmOMbOQpGGHkAGNnWmE0pyPAuXsosQD6t2T6wEDllLs3EdRorf
         KWtqVtDpy4keq5jv2GOiIN1g8iQ8mhitCSJ8VLkcbuT35Ebb0I/ERN35JsFZU9zxiJ9T
         QucHAhgwCJmPhJ2ObcI1HUV97mcfzGTYvjP3oSQl0xhc7r+imiJ5Gahh1Z1yix3/MsX0
         bOKw==
X-Forwarded-Encrypted: i=1; AJvYcCWRP3Dji5glUiqzsiNmGDUnVcBnPnMUfzEVk/rUBpqiKzAaO41dDKQ4FZPx8BEw9a2JpcE93fdfuO6srKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlDmHQOrcdz8dVZxoadXW8O/M7vcsSvT55LnzsvHpPXTzLW/cw
	INz09Ao7oJD2QOY5bTBuE70/XEdSovT99hNxhyAkhnQgFhMe+mboO9YbuaamKcjt3yObYhzDuL0
	tQ6bWgzcF27G84lzGXxrwuSs4gLXIv+802bHX35RDbkVorK/QMHbJTwY=
X-Google-Smtp-Source: AGHT+IEkDD9rh6XnYs19d1oNwKksln82HtCBI5JGOCntmV4RQoIfyHGv4vshUjydH8BhVokdFyEoiwq5vnzZq6ZpT3fsyuD/8caK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a67:b0:3a3:f8e3:6dbc with SMTP id
 e9e14a558f8ab-3a4ed2fbd93mr32746395ab.21.1729991432614; Sat, 26 Oct 2024
 18:10:32 -0700 (PDT)
Date: Sat, 26 Oct 2024 18:10:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671d9308.050a0220.2fdf0c.0232.GAE@google.com>
Subject: [syzbot] [bcachefs?] kernel BUG in bch2_bkey_pack_pos_lossy
From: syzbot <syzbot+e8bd437eb38c35c5f35a@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c2ee9f594da8 KVM: selftests: Fix build on on non-x86 archi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1051ca5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc6f8ce8c5369043
dashboard link: https://syzkaller.appspot.com/bug?extid=e8bd437eb38c35c5f35a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e1a640580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15344287980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-c2ee9f59.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8a3541902b13/vmlinux-c2ee9f59.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a00efacc2604/bzImage-c2ee9f59.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/e27719dd0715/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e8bd437eb38c35c5f35a@syzkaller.appspotmail.com

bcachefs (loop0): alloc_read... done
bcachefs (loop0): stripes_read... done
bcachefs (loop0): snapshots_read... done
bcachefs (loop0): check_allocations...
------------[ cut here ]------------
kernel BUG at fs/bcachefs/bkey.c:130!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5096 Comm: syz-executor440 Not tainted 6.12.0-rc4-syzkaller-00047-gc2ee9f594da8 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:pack_state_finish fs/bcachefs/bkey.c:130 [inline]
RIP: 0010:bch2_bkey_pack_pos_lossy+0x1956/0x1990 fs/bcachefs/bkey.c:525
Code: fd 90 0f 0b e8 5b b8 83 fd 90 0f 0b e8 53 b8 83 fd 90 0f 0b e8 4b b8 83 fd 90 0f 0b e8 43 b8 83 fd 90 0f 0b e8 3b b8 83 fd 90 <0f> 0b e8 33 47 b5 07 e8 2e b8 83 fd 90 0f 0b e8 26 b8 83 fd 90 0f
RSP: 0018:ffffc90002c3dd20 EFLAGS: 00010293
RAX: ffffffff84111fa5 RBX: ffffc90802c3e0b8 RCX: ffff88801fa9a440
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90002c3df58 R08: ffffffff84110ea6 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff8880408320c0 R14: 0000000000000000 R15: ffffc90002c3e0c0
FS:  0000555561411380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055cccf015d88 CR3: 0000000040a32000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bch2_btree_node_iter_init+0x894/0x4280 fs/bcachefs/bset.c:1313
 __btree_path_level_init fs/bcachefs/btree_iter.c:615 [inline]
 bch2_btree_path_level_init+0x4d2/0x9f0 fs/bcachefs/btree_iter.c:635
 btree_path_lock_root fs/bcachefs/btree_iter.c:769 [inline]
 bch2_btree_path_traverse_one+0x10de/0x2940 fs/bcachefs/btree_iter.c:1170
 bch2_btree_path_traverse fs/bcachefs/btree_iter.h:247 [inline]
 __bch2_btree_iter_peek fs/bcachefs/btree_iter.c:2197 [inline]
 bch2_btree_iter_peek_upto+0xb58/0x70e0 fs/bcachefs/btree_iter.c:2297
 bch2_btree_iter_peek_upto_type fs/bcachefs/btree_iter.h:685 [inline]
 bch2_gc_btree fs/bcachefs/btree_gc.c:670 [inline]
 bch2_gc_btrees fs/bcachefs/btree_gc.c:729 [inline]
 bch2_check_allocations+0x1a8b/0x6e80 fs/bcachefs/btree_gc.c:1123
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
RIP: 0033:0x7f354cc85c3a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff33d28828 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fff33d28840 RCX: 00007f354cc85c3a
RDX: 00000000200058c0 RSI: 0000000020005900 RDI: 00007fff33d28840
RBP: 0000000000000004 R08: 00007fff33d28880 R09: 0000000000005932
R10: 0000000000010000 R11: 0000000000000282 R12: 0000000000010000
R13: 00007fff33d28880 R14: 0000000000000003 R15: 0000000001000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:pack_state_finish fs/bcachefs/bkey.c:130 [inline]
RIP: 0010:bch2_bkey_pack_pos_lossy+0x1956/0x1990 fs/bcachefs/bkey.c:525
Code: fd 90 0f 0b e8 5b b8 83 fd 90 0f 0b e8 53 b8 83 fd 90 0f 0b e8 4b b8 83 fd 90 0f 0b e8 43 b8 83 fd 90 0f 0b e8 3b b8 83 fd 90 <0f> 0b e8 33 47 b5 07 e8 2e b8 83 fd 90 0f 0b e8 26 b8 83 fd 90 0f
RSP: 0018:ffffc90002c3dd20 EFLAGS: 00010293
RAX: ffffffff84111fa5 RBX: ffffc90802c3e0b8 RCX: ffff88801fa9a440
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90002c3df58 R08: ffffffff84110ea6 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff8880408320c0 R14: 0000000000000000 R15: ffffc90002c3e0c0
FS:  0000555561411380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055cccf015d88 CR3: 0000000040a32000 CR4: 0000000000352ef0
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

