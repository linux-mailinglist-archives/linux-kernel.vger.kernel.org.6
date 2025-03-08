Return-Path: <linux-kernel+bounces-552174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE1DA5767F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 01:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE286189BFB9
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 00:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10C1136337;
	Sat,  8 Mar 2025 00:02:26 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18DC2E403
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 00:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741392146; cv=none; b=Y0kPLGHF26WS2eRv82tyWZnHdjQw8czMDrxWwMJ8VkoCNUCFHvOmx01X1qHroyqEEIE29Ye/shI5GjOQ/phm3hI+4/s9B7fJgtLwnkBfVwm2cq3W/9kfOgsSuaQTfek6WV+01BBwGNUM0DmMegGy6uc7jRHvNMBcmYgPF7fOT6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741392146; c=relaxed/simple;
	bh=sLislF94xHk24wwel7mTtFFvgnFuGaB8OXQSR1wX0nc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=B2YilsUXl5Vdb67Id+gsAOuosHCVLnteaVnjMweSN2UrvJtq8n/Kc5wRyiJMmj07CHFNZLtpJCwN71sODT6onUvpYADl5l0p5mjA3Y5OqpEhn+IGZv8l6Y0BHc1OcLa5FV7qTaTfShtMH0MRu9B4WPTiCOgMdMkOAJ0wumL+x5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d43621bb7eso23595875ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 16:02:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741392143; x=1741996943;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AuLj3jc7WhFkRmUNtZtha/zHxjczigUo/qyIy+IFFDI=;
        b=cTxytYEjQzVcKq55L2anMAX+2wgxDG4MBDgSdFUvXwSDnUzrxOq86IJCDDCnb9rI/P
         Tvevw+7vceQlETFPG8hYL45lJuEa9cnNawLdGyPIMvM/TY88Cy8ZTMZ+qwBtk6bzaanB
         OPlEFHhj+I+u5v5EfkSdt8f27e+c+LN3Nl++b+KkPRySnqKi65yhYsKIKjZLQ+np/LSX
         dC/tA5j1dz7vp4OdX428hosSoI1jaY9vewPB14Y4y3CCIrEc0xNK+ib4QIvsF3G5AkRw
         XBR39av03u3UfPQHf5yEaioMnQHsVkjo3RbpYS5HRZ3wQ0oXWl8fobtVAe86hvPInp0P
         lNpw==
X-Forwarded-Encrypted: i=1; AJvYcCWwpYYEaStoGZ+7Qk2/6SXu3j165ex1l5TdQCgDdFXsrcHMoqYL+y+lSCStHmBd7ryp61cC9c1Vwb1/MHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxId0fDIjEc21Qq2tELNRqmgSeoJHbsIxD0UmETftA7peJfJWFM
	8VatZTfooNx26LgFHzopHBF1zW+qMgSDfRtcS7dMaFmeYORxgncFUGgvqbJ2tiTIARoBrzkezEG
	SQlJQ2kpWDp6RyuI0MN5vgAKZRrd+IJSMaMJNuMIRWd6mMzioWMw3P4E=
X-Google-Smtp-Source: AGHT+IF6mfYjVWbglKioGrJwEZkC1UYR5VcbUi82L0JowqRGU6Wt3xj3JMHH5cGjj6Y3AcsmlOzSsoZVzsKLeIn5Jp+bZqFL+pKT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2147:b0:3d3:f72c:8fd8 with SMTP id
 e9e14a558f8ab-3d44aefd288mr19284545ab.6.1741392142798; Fri, 07 Mar 2025
 16:02:22 -0800 (PST)
Date: Fri, 07 Mar 2025 16:02:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67cb890e.050a0220.d8275.0230.GAE@google.com>
Subject: [syzbot] [bcachefs] WARNING: locking bug in d_set_mounted
From: syzbot <syzbot+e8e6750ec34e486f8413@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7eb172143d55 Linux 6.14-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=103b27a0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2040405600e83619
dashboard link: https://syzkaller.appspot.com/bug?extid=e8e6750ec34e486f8413
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-7eb17214.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c523e9304d89/vmlinux-7eb17214.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c4095fcd8582/bzImage-7eb17214.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e8e6750ec34e486f8413@syzkaller.appspotmail.com

bcachefs (loop0): check_snapshots...
snapshot points to missing/incorrect tree:
  u64s 8 type snapshot 0:4294967295:0 len 0 ver 0: is_subvol 1 deleted 0 parent          0 children          0          0 subvol 1 tree 0, fixing
snapshot points to missing/incorrect tree:
  u64s 8 type snapshot 0:4294967295:0 len 0 ver 0: is_subvol 1 deleted 0 parent          0 children          0          0 subvol 1 tree 0, fixing
 done
bcachefs (loop0): check_subvols... done
bcachefs (loop0): check_subvol_children... done
bcachefs (loop0): delete_dead_snapshots... done
bcachefs (loop0): check_inodes... done
bcachefs (loop0): check_extents... done
bcachefs (loop0): check_indirect_extents... done
bcachefs (loop0): check_dirents... done
bcachefs (loop0): check_xattrs... done
bcachefs (loop0): check_root... done
bcachefs (loop0): check_unreachable_inodes... done
bcachefs (loop0): check_subvolume_structure... done
bcachefs (loop0): check_directory_structure... done
bcachefs (loop0): check_nlinks... done
bcachefs (loop0): resume_logged_ops... done
bcachefs (loop0): delete_dead_inodes... done
bcachefs (loop0): set_fs_needs_rebalance... done
bcachefs (loop0): Fixed errors, running fsck a second time to verify fs is clean
bcachefs (loop0): check_alloc_info... done
bcachefs (loop0): check_lrus... done
bcachefs (loop0): check_btree_backpointers... done
bcachefs (loop0): check_backpointers_to_extents... done
bcachefs (loop0): check_extents_to_backpointers... done
bcachefs (loop0): check_alloc_to_lru_refs... done
bcachefs (loop0): bucket_gens_init... done
bcachefs (loop0): check_snapshot_trees... done
bcachefs (loop0): check_snapshots... done
bcachefs (loop0): check_subvols... done
bcachefs (loop0): check_subvol_children... done
bcachefs (loop0): delete_dead_snapshots... done
bcachefs (loop0): check_inodes... done
bcachefs (loop0): check_extents... done
bcachefs (loop0): check_indirect_extents... done
bcachefs (loop0): check_dirents... done
bcachefs (loop0): check_xattrs... done
bcachefs (loop0): check_root... done
bcachefs (loop0): check_unreachable_inodes... done
bcachefs (loop0): check_subvolume_structure... done
bcachefs (loop0): check_directory_structure... done
bcachefs (loop0): check_nlinks... done
bcachefs (loop0): resume_logged_ops... done
bcachefs (loop0): delete_dead_inodes... done
bcachefs (loop0): set_fs_needs_rebalance... done
bcachefs (loop0): done starting filesystem
=============================
[ BUG: Invalid wait context ]
6.14.0-rc5-syzkaller #0 Not tainted
-----------------------------
syz.0.0/5320 is trying to lock:
ffff888044d000d0 (&data->fib_lock){+.+.}-{4:4}, at: spin_lock include/linux/spinlock.h:351 [inline]
ffff888044d000d0 (&data->fib_lock){+.+.}-{4:4}, at: d_set_mounted+0xb7/0x280 fs/dcache.c:1416
other info that might help us debug this:
context-{5:5}
4 locks held by syz.0.0/5320:
 #0: ffff88804518bd90 (&type->i_mutex_dir_key#5){++++}-{4:4}, at: inode_lock include/linux/fs.h:877 [inline]
 #0: ffff88804518bd90 (&type->i_mutex_dir_key#5){++++}-{4:4}, at: do_lock_mount+0x112/0x3a0 fs/namespace.c:2655
 #1: ffffffff8ec82a70 (namespace_sem){++++}-{4:4}, at: namespace_lock fs/namespace.c:1753 [inline]
 #1: ffffffff8ec82a70 (namespace_sem){++++}-{4:4}, at: do_lock_mount+0x153/0x3a0 fs/namespace.c:2661
 #2: ffffffff8e815750 (rename_lock){+.+.}-{3:3}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #2: ffffffff8e815750 (rename_lock){+.+.}-{3:3}, at: write_seqlock include/linux/seqlock.h:876 [inline]
 #2: ffffffff8e815750 (rename_lock){+.+.}-{3:3}, at: d_set_mounted+0x30/0x280 fs/dcache.c:1413
 #3: ffffffff8e815708 (rename_lock.seqcount){+.+.}-{0:0}, at: get_mountpoint+0x220/0x440 fs/namespace.c:946
stack backtrace:
CPU: 0 UID: 0 PID: 5320 Comm: syz.0.0 Not tainted 6.14.0-rc5-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4828 [inline]
 check_wait_context kernel/locking/lockdep.c:4900 [inline]
 __lock_acquire+0x15a8/0x2100 kernel/locking/lockdep.c:5178
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 d_set_mounted+0xb7/0x280 fs/dcache.c:1416
 get_mountpoint+0x220/0x440 fs/namespace.c:946
 do_lock_mount+0x2cf/0x3a0 fs/namespace.c:2682
 lock_mount fs/namespace.c:2697 [inline]
 do_new_mount_fc fs/namespace.c:3497 [inline]
 do_new_mount+0x43d/0xb40 fs/namespace.c:3562
 do_mount fs/namespace.c:3900 [inline]
 __do_sys_mount fs/namespace.c:4111 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4088
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fedc178e90a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fedc25bde68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fedc25bdef0 RCX: 00007fedc178e90a
RDX: 00004000000005c0 RSI: 0000400000000180 RDI: 00007fedc25bdeb0
RBP: 00004000000005c0 R08: 00007fedc25bdef0 R09: 0000000000000010
R10: 0000000000000010 R11: 0000000000000246 R12: 0000400000000180
R13: 00007fedc25bdeb0 R14: 00000000000059c4 R15: 0000400000000500
 </TASK>
==================================================================
BUG: KASAN: wild-memory-access in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: wild-memory-access in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: wild-memory-access in __lock_acquire+0xc94/0x2100 kernel/locking/lockdep.c:5198
Read of size 8 at addr 1fffffff9099d930 by task syz.0.0/5320

CPU: 0 UID: 0 PID: 5320 Comm: syz.0.0 Not tainted 6.14.0-rc5-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_report+0xe3/0x5b0 mm/kasan/report.c:524
 kasan_report+0x143/0x180 mm/kasan/report.c:634
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 __lock_acquire+0xc94/0x2100 kernel/locking/lockdep.c:5198
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 d_set_mounted+0xb7/0x280 fs/dcache.c:1416
 get_mountpoint+0x220/0x440 fs/namespace.c:946
 do_lock_mount+0x2cf/0x3a0 fs/namespace.c:2682
 lock_mount fs/namespace.c:2697 [inline]
 do_new_mount_fc fs/namespace.c:3497 [inline]
 do_new_mount+0x43d/0xb40 fs/namespace.c:3562
 do_mount fs/namespace.c:3900 [inline]
 __do_sys_mount fs/namespace.c:4111 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4088
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fedc178e90a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fedc25bde68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fedc25bdef0 RCX: 00007fedc178e90a
RDX: 00004000000005c0 RSI: 0000400000000180 RDI: 00007fedc25bdeb0
RBP: 00004000000005c0 R08: 00007fedc25bdef0 R09: 0000000000000010
R10: 0000000000000010 R11: 0000000000000246 R12: 0000400000000180
R13: 00007fedc25bdeb0 R14: 00000000000059c4 R15: 0000400000000500
 </TASK>
==================================================================


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

