Return-Path: <linux-kernel+bounces-381655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F7E9B0211
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7240F1F23469
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 12:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAEC205E0E;
	Fri, 25 Oct 2024 12:19:37 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3139220263D
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 12:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729858777; cv=none; b=KGlXKVu1zIrnnPuI1Gq96z1ZeG0HOEAZT1l398ZFgvtFUDspcjOt96d5NhrsF1cvI9h2hTvtZaQ96FagQr1412WtZIF8Al1yk9mjkBdZrc9oLWKO6sWNrP+8gQFcbR2wbcofWD8XiLXEcF9bjP+OlY8+KXVpwR6HpMEdSo1PaZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729858777; c=relaxed/simple;
	bh=pMFVEzKWD6P3P5myDTcKhhd54zg+H7Lva5B8ujucrPY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OjJ530JejqHhOnTdoYB1pIDSFh/xbBe9rGBXXBvakayRQ2WngUYe/mqugz7tF5mbGduWcHSMdjZ6HWYhA8KOsPXfk8GJX1XtsWST6ReC3QWJF0x9gFgRoFOiStIIDA2iC48C0NR/7Mt1iOzPec5WPcZQVv5QCeR7SQFFPvDc8Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3a6afd01eso17442325ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 05:19:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729858774; x=1730463574;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sIsU4C8/mQHTI4yb5M/cpmsOZdKq3dkg5gMtXJeEvFM=;
        b=dLdLrm5gwBxL1uFQO3d8YBQkue7Pvt7kESW8mAAypcvh4an2+xCWQiYj5Mk+JvLMQ1
         b97C5OZGJBBBIV9h0CU6RYWMBxKQIFYyc2TrdOjfMPN5rK7QIWV8kZudjoYeiVAjl5ek
         ldZdRvcyLTP8fwAjp/oJ4t+R8EJX//QedBzNymY5vRkM6WCymHmOTXKBPK3QoA/1fXh+
         b5JSzrv5FL6Ua4Z/xYGGR/3nJFjvOyOctEdbun6haIkw1qvfqvFn2VR90CUQgwtC5A7w
         4FjlusIWo8l4/TzJWyr1fsnW72zbS/RwlKfweOWz7X0pmpe7+Pqa1xHCWg0X2W6PhkkC
         FzWA==
X-Forwarded-Encrypted: i=1; AJvYcCVHkki/k+LejP1AhCteAg0pXdoq/WIDBghZscZyOAvTBa4QxTj2kRY6pEpsI9jWhWqJ3VcUVY4s2qumuGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBwciT2PnePLW7S7BpjzDxTuKKfO7ZeCXgElcNcigj9GxmGepF
	Z+8LiZO4b2OX1uBea3gDTmsgSbIlrH4gezY99GJ5/Om0cB+cFPZajyOUrUqKPrc6fCKrt4XP2FO
	5q3p3sXDxaliLC80e9HdjE6NgZBHLBVFEIKviuJfI3Al+VhMLsS1Th5g=
X-Google-Smtp-Source: AGHT+IFFpzoFs6kbLBeH+fP1KLHkweu+LGMp/pYSdIfpLn1uFU70M5V70rJG5MfqsD1SczulVSfgkzluDO8xlNMjZTcIhTgKZtZg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:152c:b0:3a0:985b:ddb4 with SMTP id
 e9e14a558f8ab-3a4de7825fbmr57932285ab.2.1729858774295; Fri, 25 Oct 2024
 05:19:34 -0700 (PDT)
Date: Fri, 25 Oct 2024 05:19:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671b8cd6.050a0220.2e773.0001.GAE@google.com>
Subject: [syzbot] [bcachefs?] WARNING: locking bug in rcu_pending_pcpu_dequeue
From: syzbot <syzbot+e103923b16da1cda0ae0@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    15e7d45e786a Add linux-next specific files for 20241016
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13b56a40580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c36416f1c54640c0
dashboard link: https://syzkaller.appspot.com/bug?extid=e103923b16da1cda0ae0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cf2ad43c81cc/disk-15e7d45e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c85347a66a1c/vmlinux-15e7d45e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/648cf8e59c13/bzImage-15e7d45e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e103923b16da1cda0ae0@syzkaller.appspotmail.com

while marking u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq 1db8f60c84bb244c written 8 min_key POS_MIN durability: 1 ptr: 0:42:0 gen 0, fixing
bucket 0:0 gen 0 has wrong data_type: got free, should be sb, fixing
bucket 0:0 gen 0 data type sb has wrong dirty_sectors: got 0, should be 256, fixing
------------[ cut here ]------------
Looking for class "->lock" with key rcu_pending_init.__key, but found a different class "&p->lock" with the same key
WARNING: CPU: 1 PID: 5348 at kernel/locking/lockdep.c:939 look_up_lock_class+0xdc/0x170 kernel/locking/lockdep.c:936
Modules linked in:
CPU: 1 UID: 0 PID: 5348 Comm: syz.2.3 Not tainted 6.12.0-rc3-next-20241016-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:look_up_lock_class+0xdc/0x170 kernel/locking/lockdep.c:936
Code: 01 0f 85 8a 00 00 00 c6 05 85 31 3b 04 01 90 49 8b 16 49 8b 76 18 48 8b 8b b8 00 00 00 48 c7 c7 60 f0 0a 8c e8 c5 9c 89 f5 90 <0f> 0b 90 90 eb 61 90 e8 c8 d2 ed f8 e8 53 d7 a8 f5 48 c7 c7 a0 ef
RSP: 0018:ffffc900042dd810 EFLAGS: 00010046
RAX: a3cf1fd56a819d00 RBX: ffffffff93cc6b10 RCX: 0000000000040000
RDX: ffffc90009742000 RSI: 000000000003ffff RDI: 0000000000040000
RBP: ffffc900042dd920 R08: ffffffff8155d7b2 R09: 1ffff110170e519a
R10: dffffc0000000000 R11: ffffed10170e519b R12: ffffe8ffffd748a0
R13: ffffe8ffffd748a0 R14: ffffe8ffffd748a0 R15: ffffffff9a5954a0
FS:  00007f2715b246c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555c28f0cb00 CR3: 0000000077a9a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 register_lock_class+0x102/0x980 kernel/locking/lockdep.c:1290
 __lock_acquire+0xf0/0x2050 kernel/locking/lockdep.c:5077
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
 _raw_spin_lock_irq+0xd3/0x120 kernel/locking/spinlock.c:170
 spin_lock_irq include/linux/spinlock.h:376 [inline]
 rcu_pending_pcpu_dequeue+0x29/0x2b0 fs/bcachefs/rcu_pending.c:524
 bkey_cached_alloc fs/bcachefs/btree_key_cache.c:143 [inline]
 btree_key_cache_create fs/bcachefs/btree_key_cache.c:220 [inline]
 btree_key_cache_fill+0x43a/0x2920 fs/bcachefs/btree_key_cache.c:309
 bch2_btree_path_traverse_cached+0x84e/0xbe0 fs/bcachefs/btree_key_cache.c:361
 bch2_btree_path_traverse_one+0x45d/0x2900 fs/bcachefs/btree_iter.c:1144
 bch2_btree_path_traverse fs/bcachefs/btree_iter.h:249 [inline]
 bch2_trans_update_get_key_cache+0x6c0/0x1230 fs/bcachefs/btree_update.c:494
 bch2_trans_update+0x9b1/0x2550 fs/bcachefs/btree_update.c:539
 bch2_alloc_write_key fs/bcachefs/btree_gc.c:886 [inline]
 bch2_gc_alloc_done fs/bcachefs/btree_gc.c:896 [inline]
 bch2_check_allocations+0x4574/0x7350 fs/bcachefs/btree_gc.c:1138
 bch2_run_recovery_pass+0xf0/0x1e0 fs/bcachefs/recovery_passes.c:216
 bch2_run_recovery_passes+0x27e/0x9a0 fs/bcachefs/recovery_passes.c:280
 bch2_fs_recovery+0x25cc/0x39a0 fs/bcachefs/recovery.c:892
 bch2_fs_start+0x356/0x5b0 fs/bcachefs/super.c:1037
 bch2_fs_get_tree+0xd68/0x1710 fs/bcachefs/fs.c:2174
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4055 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4032
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2714d7f79a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2715b23e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f2715b23ef0 RCX: 00007f2714d7f79a
RDX: 0000000020000040 RSI: 0000000020000080 RDI: 00007f2715b23eb0
RBP: 0000000020000040 R08: 00007f2715b23ef0 R09: 0000000002200006
R10: 0000000002200006 R11: 0000000000000246 R12: 0000000020000080
R13: 00007f2715b23eb0 R14: 00000000000059d2 R15: 0000000020000740
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

