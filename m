Return-Path: <linux-kernel+bounces-200632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F36798FB2B4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18B09B26FBA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073151474A3;
	Tue,  4 Jun 2024 12:47:27 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F9E146D7F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 12:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717505245; cv=none; b=IFpgiYpE5sYEYoWbrhIazBz4jke2Pfc/DtM9FV/Y0rCDrANEKVTt37Cym/OYghfkjh8bMiNvSpWepDWZ/Accg65hBKYPOd2bHGIpIf2hhpwDPXmmSaQa79eajSK8A7NxrcPHCg7m9VfKdIIJhMHKDEpozzMLExgmGS9m7fy1RXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717505245; c=relaxed/simple;
	bh=NISObnSudCej+8hdfqE7EJLxiFZrQe1AaJ3pR8W3V/Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Gf33vHOKOA751R5ndXky5tlf+ugquwDVUUKEDYK2RlRRRoxB/fCkQoHd7F+myFGq+8bMMqwQ98DfOHlV1WWCGtTZRuMCgIIaSdhd7FuzcH21wJNtAZoxSFWE73KCKEO4jls2ZYCKixJIqcDxp2+lLco0+qNFz8wgbJjWlo5hiuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3747f1b958bso57803785ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 05:47:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717505243; x=1718110043;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dr3ARtSXytznS7LEimUUkvVEtezO/cquAO5ZWoDP4Zw=;
        b=LKl/crEAqXUWADG2fTTwu7unaku92FIgLAjYSYhrlbe/BQgHwwTKoS20by7opkgsmy
         pl2+gHtd/gJUetd8jz/PKJux97OEmFB0vcAEkOXmZSUsTzTt59fmrlHeUZVXNvYibw9k
         DaNznINANBmJZI73Olgd8hAtQhC8LhciNWzB7+Z7NAp2C7RPWwi3SfO8JC9xNudIq6mG
         FQlt29lyuEVFG8LkBoxMQvfuBZtQhXWvbPcc8Lt0/5dcqBm0AQ52mov8yy7p1lnc0P7G
         AMCieIi1VGvuvdrXKIvyho9CIGjzlbLmhIoEwrlV/9ejI6av2U4dShLDxtQVpIqpGeY0
         bUmA==
X-Forwarded-Encrypted: i=1; AJvYcCVKv7IgQe43rThWI+9bCi0z55B3NULiMRIhx6j0k/tk5+uIf+RYbH2lEFz6S71OIM8KpnkePzH9Rpf+p+0rkHEg0EixTfW1HTyC4BvH
X-Gm-Message-State: AOJu0YxCO/a1SY8/b86BtE1KA0rZjDX8JnG1Bk+eCXFtk1hbvR2dOE6F
	VV2qd6E83yc7uqqLIb2FcVYCN/aj1hT8u4PVxDWZe80PjFyqixS0cDvG2x0OqcYetgFMlzYb3rP
	WjWeh3Jva6D49DXwnt6RibGOWpf90BJPEi3FdMobUk4GjDMioQCVmDnw=
X-Google-Smtp-Source: AGHT+IFXjzQhLpCVJeUsauvs6kLG6GF5/vPyRsj8aaAEQi5s5g5qWm54eC8HNFrMbICvYHGq7uOtq2Rf+RTD4eUEPZ8uZ8aGOmON
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26e:0:b0:36f:c675:fe8e with SMTP id
 e9e14a558f8ab-3748b9e5cb8mr8435835ab.4.1717505242992; Tue, 04 Jun 2024
 05:47:22 -0700 (PDT)
Date: Tue, 04 Jun 2024 05:47:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e8a796061a0fd949@google.com>
Subject: [syzbot] [kernfs?] INFO: task hung in kernfs_dop_revalidate (4)
From: syzbot <syzbot+da20d108162166514db6@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4a4be1ad3a6e Revert "vfs: Delete the associated dentry whe..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17012bd2980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9016f104992d69c
dashboard link: https://syzkaller.appspot.com/bug?extid=da20d108162166514db6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=150e4b0c980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c039c2980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e323e970d41d/disk-4a4be1ad.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f0dfe36102b9/vmlinux-4a4be1ad.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9ca35ad0fa6a/bzImage-4a4be1ad.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+da20d108162166514db6@syzkaller.appspotmail.com

INFO: task udevd:4544 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc1-syzkaller-00027-g4a4be1ad3a6e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D
 stack:24048 pid:4544  tgid:4544  ppid:1      flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 rwsem_down_read_slowpath kernel/locking/rwsem.c:1086 [inline]
 __down_read_common kernel/locking/rwsem.c:1250 [inline]
 __down_read kernel/locking/rwsem.c:1263 [inline]
 down_read+0x705/0xa40 kernel/locking/rwsem.c:1528
 kernfs_dop_revalidate+0xd4/0x560 fs/kernfs/dir.c:1159
 lookup_fast+0x1f4/0x4a0
 walk_component fs/namei.c:2000 [inline]
 link_path_walk+0x60b/0xea0 fs/namei.c:2331
 path_openat+0x24a/0x3280 fs/namei.c:3803
 do_filp_open+0x235/0x490 fs/namei.c:3834
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1405
 do_sys_open fs/open.c:1420 [inline]
 __do_sys_openat fs/open.c:1436 [inline]
 __se_sys_openat fs/open.c:1431 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1431
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8b7f9169a4
RSP: 002b:00007fffdadb9fc0 EFLAGS: 00000246
 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00007f8b7f9169a4
RDX: 0000000000080000 RSI: 00007fffdadba0f8 RDI: 00000000ffffff9c
RBP: 00007fffdadba0f8 R08: 0000000000000008 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000080000
R13: 0000558fed691b42 R14: 0000000000000001 R15: 0000000000000000
 </TASK>
INFO: task syz-executor167:5156 blocked for more than 144 seconds.
      Not tainted 6.10.0-rc1-syzkaller-00027-g4a4be1ad3a6e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor167 state:D
 stack:21024 pid:5156  tgid:5156  ppid:5154   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 rwsem_down_read_slowpath kernel/locking/rwsem.c:1086 [inline]
 __down_read_common kernel/locking/rwsem.c:1250 [inline]
 __down_read kernel/locking/rwsem.c:1263 [inline]
 down_read+0x705/0xa40 kernel/locking/rwsem.c:1528
 kernfs_dop_revalidate+0xd4/0x560 fs/kernfs/dir.c:1159
 lookup_fast+0x1f4/0x4a0
 walk_component fs/namei.c:2000 [inline]
 link_path_walk+0x60b/0xea0 fs/namei.c:2331
 path_openat+0x24a/0x3280 fs/namei.c:3803
 do_filp_open+0x235/0x490 fs/namei.c:3834
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1405
 do_sys_open fs/open.c:1420 [inline]
 __do_sys_openat fs/open.c:1436 [inline]
 __se_sys_openat fs/open.c:1431 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1431
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7febd45d03e1
RSP: 002b:00007ffd172253b0 EFLAGS: 00000287 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007febd45d03e1
RDX: 0000000000090800 RSI: 00007febd461b14f RDI: 00000000ffffff9c
RBP: 0000000000000069 R08: 00000000095f7996 R09: 7fffffffffffffff
R10: 0000000000000000 R11: 0000000000000287 R12: 00007ffd1722543c
R13: 00007ffd17225450 R14: 00007ffd17225490 R15: 0000000000000067
 </TASK>
INFO: task syz-executor167:5158 blocked for more than 145 seconds.
      Not tainted 6.10.0-rc1-syzkaller-00027-g4a4be1ad3a6e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor167 state:D
 stack:19248 pid:5158  tgid:5158  ppid:5153   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 rwsem_down_read_slowpath kernel/locking/rwsem.c:1086 [inline]
 __down_read_common kernel/locking/rwsem.c:1250 [inline]
 __down_read kernel/locking/rwsem.c:1263 [inline]
 down_read+0x705/0xa40 kernel/locking/rwsem.c:1528
 kernfs_dop_revalidate+0xd4/0x560 fs/kernfs/dir.c:1159
 lookup_fast+0x1f4/0x4a0
 walk_component fs/namei.c:2000 [inline]
 link_path_walk+0x60b/0xea0 fs/namei.c:2331
 path_openat+0x24a/0x3280 fs/namei.c:3803
 do_filp_open+0x235/0x490 fs/namei.c:3834
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1405
 do_sys_open fs/open.c:1420 [inline]
 __do_sys_openat fs/open.c:1436 [inline]
 __se_sys_openat fs/open.c:1431 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1431
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7febd45d03e1
RSP: 002b:00007ffd172253b0 EFLAGS: 00000287
 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007febd45d03e1
RDX: 0000000000090800 RSI: 00007febd461b14f RDI: 00000000ffffff9c
RBP: 000000000000006b R08: 000000002bee115c R09: 7fffffffffffffff
R10: 0000000000000000 R11: 0000000000000287 R12: 00007ffd1722543c
R13: 00007ffd17225450 R14: 00007ffd17225490 R15: 0000000000000069
 </TASK>
INFO: task syz-executor167:5157 blocked for more than 146 seconds.
      Not tainted 6.10.0-rc1-syzkaller-00027-g4a4be1ad3a6e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor167 state:D
 stack:20512 pid:5157  tgid:5157  ppid:5151   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 rwsem_down_read_slowpath kernel/locking/rwsem.c:1086 [inline]
 __down_read_common kernel/locking/rwsem.c:1250 [inline]
 __down_read kernel/locking/rwsem.c:1263 [inline]
 down_read+0x705/0xa40 kernel/locking/rwsem.c:1528
 kernfs_dop_revalidate+0xd4/0x560 fs/kernfs/dir.c:1159
 lookup_fast+0x1f4/0x4a0
 walk_component fs/namei.c:2000 [inline]
 link_path_walk+0x60b/0xea0 fs/namei.c:2331
 path_openat+0x24a/0x3280 fs/namei.c:3803
 do_filp_open+0x235/0x490 fs/namei.c:3834
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1405
 do_sys_open fs/open.c:1420 [inline]
 __do_sys_openat fs/open.c:1436 [inline]
 __se_sys_openat fs/open.c:1431 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1431
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7febd45d03e1
RSP: 002b:00007ffd172253b0 EFLAGS: 00000287
 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007febd45d03e1
RDX: 0000000000090800 RSI: 00007febd461b14f RDI: 00000000ffffff9c
RBP: 0000000000000068 R08: 000000000bbb6644 R09: 7fffffffffffffff
R10: 0000000000000000 R11: 0000000000000287 R12: 00007ffd1722543c
R13: 00007ffd17225450 R14: 00007ffd17225490 R15: 0000000000000066
 </TASK>
INFO: task syz-executor167:5155 blocked for more than 147 seconds.
      Not tainted 6.10.0-rc1-syzkaller-00027-g4a4be1ad3a6e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor167 state:D
 stack:21024 pid:5155  tgid:5155  ppid:5150   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 rwsem_down_read_slowpath kernel/locking/rwsem.c:1086 [inline]
 __down_read_common kernel/locking/rwsem.c:1250 [inline]
 __down_read kernel/locking/rwsem.c:1263 [inline]
 down_read+0x705/0xa40 kernel/locking/rwsem.c:1528
 kernfs_dop_revalidate+0xd4/0x560 fs/kernfs/dir.c:1159
 lookup_fast+0x1f4/0x4a0
 walk_component fs/namei.c:2000 [inline]
 link_path_walk+0x60b/0xea0 fs/namei.c:2331
 path_openat+0x24a/0x3280 fs/namei.c:3803
 do_filp_open+0x235/0x490 fs/namei.c:3834
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1405
 do_sys_open fs/open.c:1420 [inline]
 __do_sys_openat fs/open.c:1436 [inline]
 __se_sys_openat fs/open.c:1431 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1431
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7febd45d03e1
RSP: 002b:00007ffd172253b0 EFLAGS: 00000287
 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007febd45d03e1
RDX: 0000000000090800 RSI: 00007febd461b14f RDI: 00000000ffffff9c
RBP: 000000000000006b R08: 0000000024e66dc2 R09: 7fffffffffffffff
R10: 0000000000000000 R11: 0000000000000287 R12: 00007ffd1722543c
R13: 00007ffd17225450 R14: 00007ffd17225490 R15: 0000000000000069
 </TASK>
INFO: task syz-executor167:5159 blocked for more than 148 seconds.
      Not tainted 6.10.0-rc1-syzkaller-00027-g4a4be1ad3a6e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor167 state:D
 stack:21024 pid:5159  tgid:5159  ppid:5152   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 rwsem_down_read_slowpath kernel/locking/rwsem.c:1086 [inline]
 __down_read_common kernel/locking/rwsem.c:1250 [inline]
 __down_read kernel/locking/rwsem.c:1263 [inline]
 down_read+0x705/0xa40 kernel/locking/rwsem.c:1528
 kernfs_dop_revalidate+0xd4/0x560 fs/kernfs/dir.c:1159
 lookup_fast+0x1f4/0x4a0
 walk_component fs/namei.c:2000 [inline]
 link_path_walk+0x60b/0xea0 fs/namei.c:2331
 path_openat+0x24a/0x3280 fs/namei.c:3803
 do_filp_open+0x235/0x490 fs/namei.c:3834
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1405
 do_sys_open fs/open.c:1420 [inline]
 __do_sys_openat fs/open.c:1436 [inline]
 __se_sys_openat fs/open.c:1431 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1431
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7febd45d03e1
RSP: 002b:00007ffd172253b0 EFLAGS: 00000287
 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007febd45d03e1
RDX: 0000000000090800 RSI: 00007febd461b14f RDI: 00000000ffffff9c
RBP: 000000000000006b R08: 00000000128cac2c R09: 7fffffffffffffff
R10: 0000000000000000 R11: 0000000000000287 R12: 00007ffd1722543c
R13: 00007ffd17225450 R14: 00007ffd17225490 R15: 0000000000000069
 </TASK>
INFO: task kworker/0:5:5179 blocked for more than 149 seconds.
      Not tainted 6.10.0-rc1-syzkaller-00027-g4a4be1ad3a6e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:5     state:D
 stack:21328 pid:5179  tgid:5179  ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event

Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 rwsem_down_write_slowpath+0xeeb/0x13b0 kernel/locking/rwsem.c:1178
 __down_write_common+0x1af/0x200 kernel/locking/rwsem.c:1306
 kernfs_add_one+0x9a/0x8b0 fs/kernfs/dir.c:778
 kernfs_create_dir_ns+0xd9/0x120 fs/kernfs/dir.c:1071
 sysfs_create_dir_ns+0x189/0x3a0 fs/sysfs/dir.c:59
 create_dir lib/kobject.c:73 [inline]
 kobject_add_internal+0x435/0x8d0 lib/kobject.c:240
 kobject_add_varg lib/kobject.c:374 [inline]
 kobject_add+0x152/0x220 lib/kobject.c:426
 device_add+0x4e5/0xbf0 drivers/base/core.c:3659
 usb_new_device+0x104a/0x19a0 drivers/usb/core/hub.c:2651
 hub_port_connect drivers/usb/core/hub.c:5521 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x2d6a/0x5150 drivers/usb/core/hub.c:5903
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task syz-executor167:5709 blocked for more than 150 seconds.
      Not tainted 6.10.0-rc1-syzkaller-00027-g4a4be1ad3a6e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor167 state:D
 stack:26736 pid:5709  tgid:5709  ppid:5156   flags:0x00024006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 rwsem_down_write_slowpath+0xeeb/0x13b0 kernel/locking/rwsem.c:1178
 __down_write_common+0x1af/0x200 kernel/locking/rwsem.c:1306
 kernfs_remove_by_name_ns+0x7a/0x160 fs/kernfs/dir.c:1689
 module_remove_driver+0x59/0x1c0 drivers/base/module.c:100
 bus_remove_driver+0x1fb/0x320 drivers/base/bus.c:743
 usb_gadget_unregister_driver+0x4e/0x70 drivers/usb/gadget/udc/core.c:1733
 raw_release+0xf9/0x1e0 drivers/usb/gadget/legacy/raw_gadget.c:462
 __fput+0x406/0x8b0 fs/file_table.c:422
 __do_sys_close fs/open.c:1555 [inline]
 __se_sys_close fs/open.c:1540 [inline]
 __x64_sys_close+0x7f/0x110 fs/open.c:1540
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7febd45cf880
RSP: 002b:00007ffd17225418 EFLAGS: 00000202
 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007febd45cf880
RDX: 0000000000000000 RSI: 00007ffd17225380 RDI: 0000000000000004
RBP: 0000000000000000 R08: 000000000000000f R09: 00007ffd17225117
R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffd1722543c
R13: 00007ffd17225450 R14: 00007ffd17225490 R15: 0000000000000067
 </TASK>
INFO: task syz-executor167:5710 blocked for more than 151 seconds.
      Not tainted 6.10.0-rc1-syzkaller-00027-g4a4be1ad3a6e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor167 state:D
 stack:25488 pid:5710  tgid:5710  ppid:5157   flags:0x00024006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 rwsem_down_write_slowpath+0xeeb/0x13b0 kernel/locking/rwsem.c:1178
 __down_write_common+0x1af/0x200 kernel/locking/rwsem.c:1306
 kernfs_remove_by_name_ns+0x7a/0x160 fs/kernfs/dir.c:1689
 remove_bind_files drivers/base/bus.c:600 [inline]
 bus_remove_driver+0x26c/0x320 drivers/base/bus.c:738
 usb_gadget_unregister_driver+0x4e/0x70 drivers/usb/gadget/udc/core.c:1733
 raw_release+0xf9/0x1e0 drivers/usb/gadget/legacy/raw_gadget.c:462
 __fput+0x406/0x8b0 fs/file_table.c:422
 __do_sys_close fs/open.c:1555 [inline]
 __se_sys_close fs/open.c:1540 [inline]
 __x64_sys_close+0x7f/0x110 fs/open.c:1540
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7febd45cf880
RSP: 002b:00007ffd17225418 EFLAGS: 00000202
 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007febd45cf880
RDX: 0000000000000000 RSI: 00007ffd17225380 RDI: 0000000000000004
RBP: 0000000000000000 R08: 000000000000000f R09: 00007ffd17225117
R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffd1722543c
R13: 00007ffd17225450 R14: 00007ffd17225490 R15: 0000000000000066
 </TASK>
INFO: task syz-executor167:5711 blocked for more than 152 seconds.
      Not tainted 6.10.0-rc1-syzkaller-00027-g4a4be1ad3a6e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor167 state:D
 stack:25440 pid:5711  tgid:5711  ppid:5159   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 rwsem_down_write_slowpath+0xeeb/0x13b0 kernel/locking/rwsem.c:1178
 __down_write_common+0x1af/0x200 kernel/locking/rwsem.c:1306
 kernfs_remove_by_name_ns+0x7a/0x160 fs/kernfs/dir.c:1689
 remove_bind_files drivers/base/bus.c:600 [inline]
 bus_remove_driver+0x26c/0x320 drivers/base/bus.c:738
 usb_gadget_unregister_driver+0x4e/0x70 drivers/usb/gadget/udc/core.c:1733
 raw_release+0xf9/0x1e0 drivers/usb/gadget/legacy/raw_gadget.c:462
 __fput+0x406/0x8b0 fs/file_table.c:422
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa27/0x27e0 kernel/exit.c:874
 do_group_exit+0x207/0x2c0 kernel/exit.c:1023
 get_signal+0x16a1/0x1740 kernel/signal.c:2909


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

