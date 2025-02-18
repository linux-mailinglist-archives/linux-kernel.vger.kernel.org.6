Return-Path: <linux-kernel+bounces-519015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AAEA39719
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E18C7174676
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2220D2309A1;
	Tue, 18 Feb 2025 09:27:22 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B908122FAE1
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870841; cv=none; b=hrb6v5tGVGGh3zHdKHRO50+P/awtTTjo6v3ChtHRRSTlAOw7irJJWYae7xygOCIzostbUYwkWwcRFVSw2A5XQMVTVhQztHZgeY8BqOxYJ9Gr7gU0gL4IPn5PMK51L0MZjcJqswsi7UxonjgVht7LUVrM+wXfTAr/qwYsqkp9iLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870841; c=relaxed/simple;
	bh=6gKMuK8WXit7FeK9cZhE5ViRkVMpYTED/Z43vaEPf2s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=s49gFXrT46pW6mEf9fjx84Py8hwD/cUmPTf4La+/a7ArCAV7TBd9bE8WyO/FhhYayorCjHdCCxd2JgC6mAMl2obq7OG8F+0Z4c8IaxPLZMxF07D/7jWpNEODv7EN4xftWmexlwb72C10lAhc+YCHIlR2edoXTfi9XkzMoUQGh3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d18f21d271so32027635ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 01:27:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739870839; x=1740475639;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TwbkXJFJwJEC0GHXpD/ttd5kOK7YIzluCoP6mS4zyh4=;
        b=F4GINyazRGxCqqUIRkrgpqkqP3BqTmwTd9ufblkebBAOKcutzdBPnTxz6XpKH4FKrC
         HSw0keTkrulnp2BkQ7h8IzPzeCd9d/FD6tP8FzEvWR3lP1iWKiM1Zm6rXdcv6QFFji0T
         Bssm8hPB5jy26mlcwvQQJORFyuVEeVxee6n+eavJZMj3sP4UUhFO/mKHgWFDbS3V/Vo2
         cOVG0IXnhBlZjg1cSSEs8WrJZxAPIipbyfJCUtmvqptSO2J1t8Q8tngkNrOhf1jTLsM5
         iNpg0iXb1t+KvVMDs4umiAz+bRB3sSCwYQG3uXfTxM6Ra+me/9uEzDXfWyBtptRW8uwp
         JKcA==
X-Forwarded-Encrypted: i=1; AJvYcCX+823l5rZdefwCBGZF7mZr7r8mLbEB42X0r3nSOTpHHVLqeKlUOp5/+0UpVUJcvi0hxS45t6Ozvp2HlUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb/6XM3xqruYE9+FxDPFm+8Q4Cy3MZOFJWdmDaCdR9ZtLuoT4L
	fwZj2dTGloo93O9QuOZ9Gr7W9wURC7A6xZ5GLKhFfC59rXuIcxNk85+nD8j7jDISS1CgbW2C8mR
	a4U/kRfDVggLtZFV6B+LJLRG/fkUCKzWoCu9FAf3HKAUFoloDxqF3tDU=
X-Google-Smtp-Source: AGHT+IHrbFGrv57/vsQ1qXnZ6A9YBcD4gY7/wP51AZSyg8uH/0s40xHfoIe/Y6Co9W+ZgHN//+iGbHwTJLrXho8J74pDO7aJOkYz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184d:b0:3cf:bb11:a3a7 with SMTP id
 e9e14a558f8ab-3d280947db4mr109421565ab.17.1739870838798; Tue, 18 Feb 2025
 01:27:18 -0800 (PST)
Date: Tue, 18 Feb 2025 01:27:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b45276.050a0220.173698.004f.GAE@google.com>
Subject: [syzbot] [kernfs?] WARNING: suspicious RCU usage in kernfs_node_dentry
From: syzbot <syzbot+ecccecbc636b455f9084@syzkaller.appspotmail.com>
To: bigeasy@linutronix.de, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    253c82b3a2ce Add linux-next specific files for 20250217
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15141898580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f984ff1d92cb4017
dashboard link: https://syzkaller.appspot.com/bug?extid=ecccecbc636b455f9084
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=175b7da4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17141898580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/af8b0f79abb4/disk-253c82b3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/463f7d416e09/vmlinux-253c82b3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/07101e97dd04/bzImage-253c82b3.xz

The issue was bisected to:

commit 5b2fabf7fe8f745ff214ff003e6067b64f172271
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Thu Feb 13 14:50:20 2025 +0000

    kernfs: Acquire kernfs_rwsem in kernfs_node_dentry().

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15a9fda4580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17a9fda4580000
console output: https://syzkaller.appspot.com/x/log.txt?x=13a9fda4580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ecccecbc636b455f9084@syzkaller.appspotmail.com
Fixes: 5b2fabf7fe8f ("kernfs: Acquire kernfs_rwsem in kernfs_node_dentry().")

=============================
WARNING: suspicious RCU usage
6.14.0-rc2-next-20250217-syzkaller #0 Not tainted
-----------------------------
fs/kernfs/mount.c:243 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
3 locks held by syz-executor215/5837:
 #0: ffff88802ab0b870 (&fc->uapi_mutex){+.+.}-{4:4}, at: __do_sys_fsconfig fs/fsopen.c:465 [inline]
 #0: ffff88802ab0b870 (&fc->uapi_mutex){+.+.}-{4:4}, at: __se_sys_fsconfig+0x9b2/0xf60 fs/fsopen.c:344
 #1: ffff8880355560e0 (&type->s_umount_key#46){+.+.}-{4:4}, at: __super_lock fs/super.c:56 [inline]
 #1: ffff8880355560e0 (&type->s_umount_key#46){+.+.}-{4:4}, at: super_lock+0x196/0x400 fs/super.c:120
 #2: ffff88801bef7148 (&root->kernfs_rwsem){++++}-{4:4}, at: class_rwsem_read_constructor include/linux/rwsem.h:241 [inline]
 #2: ffff88801bef7148 (&root->kernfs_rwsem){++++}-{4:4}, at: kernfs_node_dentry+0xc3/0x2d0 fs/kernfs/mount.c:223

stack backtrace:
CPU: 0 UID: 0 PID: 5837 Comm: syz-executor215 Not tainted 6.14.0-rc2-next-20250217-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 lockdep_rcu_suspicious+0x226/0x340 kernel/locking/lockdep.c:6847
 kernfs_node_dentry+0x24b/0x2d0 fs/kernfs/mount.c:243
 cgroup_do_get_tree+0x248/0x390 kernel/cgroup/cgroup.c:2233
 cgroup_get_tree+0xbb/0x230 kernel/cgroup/cgroup.c:2272
 vfs_get_tree+0x90/0x2b0 fs/super.c:1759
 vfs_cmd_create+0xa0/0x1f0 fs/fsopen.c:225
 __do_sys_fsconfig fs/fsopen.c:467 [inline]
 __se_sys_fsconfig+0xa33/0xf60 fs/fsopen.c:344
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f09e41a2de9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe4f61eba8 EFLAGS: 00000246 ORIG_RAX: 00000000000001af
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f09e41a2de9
RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f09e41ec036
R13: 00007ffe4f61ebe0 R14: 00007ffe4f61ec20 R15: 0000000000000000
 </TASK>

============================================
WARNING: possible recursive locking detected
6.14.0-rc2-next-20250217-syzkaller #0 Not tainted
--------------------------------------------
syz-executor215/5837 is trying to acquire lock:
ffff88801bef7148 (&root->kernfs_rwsem){++++}-{4:4}, at: kernfs_dop_revalidate+0xa2/0x5d0 fs/kernfs/dir.c:1178

but task is already holding lock:
ffff88801bef7148 (&root->kernfs_rwsem){++++}-{4:4}, at: class_rwsem_read_constructor include/linux/rwsem.h:241 [inline]
ffff88801bef7148 (&root->kernfs_rwsem){++++}-{4:4}, at: kernfs_node_dentry+0xc3/0x2d0 fs/kernfs/mount.c:223

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&root->kernfs_rwsem);
  lock(&root->kernfs_rwsem);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

3 locks held by syz-executor215/5837:
 #0: ffff88802ab0b870 (&fc->uapi_mutex){+.+.}-{4:4}, at: __do_sys_fsconfig fs/fsopen.c:465 [inline]
 #0: ffff88802ab0b870 (&fc->uapi_mutex){+.+.}-{4:4}, at: __se_sys_fsconfig+0x9b2/0xf60 fs/fsopen.c:344
 #1: ffff8880355560e0 (&type->s_umount_key#46){+.+.}-{4:4}, at: __super_lock fs/super.c:56 [inline]
 #1: ffff8880355560e0 (&type->s_umount_key#46){+.+.}-{4:4}, at: super_lock+0x196/0x400 fs/super.c:120
 #2: ffff88801bef7148 (&root->kernfs_rwsem){++++}-{4:4}, at: class_rwsem_read_constructor include/linux/rwsem.h:241 [inline]
 #2: ffff88801bef7148 (&root->kernfs_rwsem){++++}-{4:4}, at: kernfs_node_dentry+0xc3/0x2d0 fs/kernfs/mount.c:223

stack backtrace:
CPU: 1 UID: 0 PID: 5837 Comm: syz-executor215 Not tainted 6.14.0-rc2-next-20250217-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_deadlock_bug+0x483/0x620 kernel/locking/lockdep.c:3039
 check_deadlock kernel/locking/lockdep.c:3091 [inline]
 validate_chain+0x15e2/0x5920 kernel/locking/lockdep.c:3893
 __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5228
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
 down_read+0xb1/0xa40 kernel/locking/rwsem.c:1524
 kernfs_dop_revalidate+0xa2/0x5d0 fs/kernfs/dir.c:1178
 d_revalidate fs/namei.c:923 [inline]
 lookup_dcache fs/namei.c:1651 [inline]
 lookup_one_unlocked+0x23b/0x2d0 fs/namei.c:2972
 lookup_one_positive_unlocked fs/namei.c:3003 [inline]
 lookup_positive_unlocked+0x2b/0xb0 fs/namei.c:3043
 kernfs_node_dentry+0x139/0x2d0 fs/kernfs/mount.c:244
 cgroup_do_get_tree+0x248/0x390 kernel/cgroup/cgroup.c:2233
 cgroup_get_tree+0xbb/0x230 kernel/cgroup/cgroup.c:2272
 vfs_get_tree+0x90/0x2b0 fs/super.c:1759
 vfs_cmd_create+0xa0/0x1f0 fs/fsopen.c:225
 __do_sys_fsconfig fs/fsopen.c:467 [inline]
 __se_sys_fsconfig+0xa33/0xf60 fs/fsopen.c:344
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f09e41a2de9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe4f61eba8 EFLAGS: 00000246 ORIG_RAX: 00000000000001af
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f09e41a2de9
RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f09e41ec036
R13: 00007ffe4f61ebe0 R14: 00007ffe4f61ec20 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

