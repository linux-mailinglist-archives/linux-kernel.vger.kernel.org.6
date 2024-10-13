Return-Path: <linux-kernel+bounces-362889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 259B799BABF
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 20:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4ED31C20D3A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 18:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969B11494BF;
	Sun, 13 Oct 2024 18:19:27 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B85B36B
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 18:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728843567; cv=none; b=HOH0Bpsu/MjG48VMDHJ1vCV45ILYBVptdLY07qWy1sVVGPA9EBSaJNO+9qhuwMxJU83FvhFsFhkaNY+fGKi1TnIQUy2gbRbe/yP31May1sGInm4/L0QrjWVWUKNWy3T5MUgW7eQpvAqU0Y57EpMkbl5HXetmdlJKE7x+yYDdvjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728843567; c=relaxed/simple;
	bh=9etvFx7yX/ZsBToZEYffoAOOhfHzzk8pLG31IJceM8c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Db29rKYI73etRECbphRuyR5XCaE88f6NCRGVUpq2zvCmshAPtnyyAZcP4dysMNDqPVik4k5j3cjSIZg3wL6U4xqaXM9qGHSm+n0Ujoq3nX69Lr/wUr3b6xjL4ZvJkw+wyENM2kil+Lkr79NCpnLVEI2+OKCB7qh0JoknehJVM0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3c38d2b91so5782215ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 11:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728843564; x=1729448364;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xaF4XcpBOE9V7Z6TWObcGa0rmb9UlvcMo91J0iUggAA=;
        b=OpcRfqTS7xvwWMRRKq+q6wwxVlp8ELBXJT33LLcwyJ8ONx+Xhxgf7NX5RNSYYwMpFc
         Q5a9j7WqzimvcasDWZn7GAss4rS5nim/PGNmX/WqSVcz2yidzZbeZj6o9W3eAA+Lyc2f
         CL2QXLVc0cT0jNDUyNSXpTiz84hkukRtXblHy9zo5WBN9ncxZ5ocQ+Cgfbo70vm4Gzrv
         Hh6MphnKEg2BwZ5P6rpitHy/e1w/46WbAjVyyzzdYFblTH9j5pTkkFBAPHJVzzEIhK1y
         hmjk844muw/h9G1kcQbpHkEDwcKQdKNdq3KlUoFJV9gCVC8zaFtLv7lwBoo0RsWGMrZ3
         QYkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIlErGNLZ/Vth7vexQKuG0GBzLz/snMLKOgABxIuI+RSA9Kv9qtbDjO6gNocLfSJtVc4WoHwwcvgRMc4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YykirBkfGBFfufIN+2A4FFb5YYz2zqh/WKCryYZ1UEdbpGaiayX
	VAG1Wcw5hK1TsqmY+LzngIFGaTZ06ktNO3nHZOHJol5N8G4kz/cxg0ivuItQDW4MWnK4lKT7Zlj
	OGT7kQutvXKKJAjZuGd69aMVdolXYSFlXKaBz7XSWovz95A0SrZfJeTw=
X-Google-Smtp-Source: AGHT+IGbxZmju9/d8YkTLqDSx5JYszTXJL9kDcxpUUf+bFFQNpDL7KYeBWtqKxNJtOcC+O5NC4fABrO1VdxB5CrIvLvpV7gakF5r
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:198f:b0:3a3:9792:e9f5 with SMTP id
 e9e14a558f8ab-3a3bcd9589emr42996365ab.5.1728843564330; Sun, 13 Oct 2024
 11:19:24 -0700 (PDT)
Date: Sun, 13 Oct 2024 11:19:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670c0f2c.050a0220.3e960.0042.GAE@google.com>
Subject: [syzbot] [mm?] possible deadlock in vma_prepare
From: syzbot <syzbot+f25246115d09ea7e956b@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    33ce24234fca Add linux-next specific files for 20241008
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17670f07980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4750ca93740b938d
dashboard link: https://syzkaller.appspot.com/bug?extid=f25246115d09ea7e956b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ee8dc2df0c57/disk-33ce2423.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dc473c0fa06e/vmlinux-33ce2423.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4671f1ca2e61/bzImage-33ce2423.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f25246115d09ea7e956b@syzkaller.appspotmail.com

ima: No TPM chip found, activating TPM-bypass!
Loading compiled-in module X.509 certificates
Loaded X.509 cert 'Build time autogenerated kernel key: 5a5c91671060ad0cbe3fbddde7d37e27f262e8ee'
ima: Allocated hash algorithm: sha256
ima: No architecture policies found
evm: Initialising EVM extended attributes:
evm: security.selinux (disabled)
evm: security.SMACK64 (disabled)
evm: security.SMACK64EXEC (disabled)
evm: security.SMACK64TRANSMUTE (disabled)
evm: security.SMACK64MMAP (disabled)
evm: security.apparmor
evm: security.ima
evm: security.capability
evm: HMAC attrs: 0x1
PM:   Magic number: 12:674:139
video4linux video39: hash matches
nfc nfc1: hash matches
block ram4: hash matches
acpi device:10: hash matches
printk: legacy console [netcon0] enabled
netconsole: network logging started
gtp: GTP module loaded (pdp ctx size 128 bytes)
rdma_rxe: loaded
cfg80211: Loading compiled-in X.509 certificates for regulatory database
Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
clk: Disabling unused clocks
ALSA device list:
  #0: Dummy 1
  #1: Loopback 1
  #2: Virtual MIDI Card 1
md: Waiting for all devices to be available before autodetect
md: If you don't use raid, use raid=noautodetect
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
EXT4-fs (sda1): mounted filesystem b4773fba-1738-4da0-8a90-0fe043d0a496 ro with ordered data mode. Quota mode: none.
VFS: Mounted root (ext4 filesystem) readonly on device 8:1.
devtmpfs: mounted
Freeing unused kernel image (initmem) memory: 26724K
Write protecting the kernel read-only data: 219136k
Freeing unused kernel image (rodata/data gap) memory: 1100K
x86/mm: Checked W+X mappings: passed, no W+X pages found.
x86/mm: Checking user space page tables
x86/mm: Checked W+X mappings: passed, no W+X pages found.
Failed to set sysctl parameter 'max_rcu_stall_to_panic=1': parameter not found
Run /sbin/init as init process

======================================================
WARNING: possible circular locking dependency detected
6.12.0-rc2-next-20241008-syzkaller #0 Not tainted
------------------------------------------------------
init/1 is trying to acquire lock:
ffff88802fece5c8 (&anon_vma->rwsem){++++}-{3:3}, at: anon_vma_lock_write include/linux/rmap.h:121 [inline]
ffff88802fece5c8 (&anon_vma->rwsem){++++}-{3:3}, at: vma_prepare+0x26c/0x4c0 mm/vma.c:181

but task is already holding lock:
ffff888025b4d608 (&mapping->i_mmap_rwsem){+.+.}-{3:3}, at: i_mmap_lock_write include/linux/fs.h:507 [inline]
ffff888025b4d608 (&mapping->i_mmap_rwsem){+.+.}-{3:3}, at: vma_prepare+0x13e/0x4c0 mm/vma.c:167

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&mapping->i_mmap_rwsem){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       down_write+0x99/0x220 kernel/locking/rwsem.c:1577
       i_mmap_lock_write include/linux/fs.h:507 [inline]
       dma_resv_lockdep+0x4ec/0x8e0 drivers/dma-buf/dma-resv.c:794
       do_one_initcall+0x248/0x880 init/main.c:1266
       do_initcall_level+0x157/0x210 init/main.c:1328
       do_initcalls+0x3f/0x80 init/main.c:1344
       kernel_init_freeable+0x435/0x5d0 init/main.c:1577
       kernel_init+0x1d/0x2b0 init/main.c:1466
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #1 (fs_reclaim){+.+.}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       __fs_reclaim_acquire mm/page_alloc.c:3870 [inline]
       fs_reclaim_acquire+0x88/0x140 mm/page_alloc.c:3884
       might_alloc include/linux/sched/mm.h:327 [inline]
       prepare_alloc_pages+0x147/0x5d0 mm/page_alloc.c:4529
       __alloc_pages_noprof+0x166/0x6c0 mm/page_alloc.c:4758
       alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
       pagetable_alloc_noprof include/linux/mm.h:2898 [inline]
       pmd_alloc_one_noprof include/asm-generic/pgalloc.h:138 [inline]
       __pmd_alloc+0x91/0x620 mm/memory.c:6342
       pmd_alloc include/linux/mm.h:2861 [inline]
       alloc_new_pmd mm/mremap.c:96 [inline]
       move_page_tables+0x1c37/0x1f80 mm/mremap.c:610
       relocate_vma_down+0x3ff/0x630 mm/mmap.c:2308
       setup_arg_pages+0x668/0xc10 fs/exec.c:810
       load_elf_binary+0xb7d/0x2710 fs/binfmt_elf.c:1014
       search_binary_handler fs/exec.c:1752 [inline]
       exec_binprm fs/exec.c:1794 [inline]
       bprm_execve+0xaf8/0x1770 fs/exec.c:1845
       kernel_execve+0x931/0xa50 fs/exec.c:2012
       try_to_run_init_process init/main.c:1394 [inline]
       kernel_init+0xed/0x2b0 init/main.c:1522
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (&anon_vma->rwsem){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       down_write+0x99/0x220 kernel/locking/rwsem.c:1577
       anon_vma_lock_write include/linux/rmap.h:121 [inline]
       vma_prepare+0x26c/0x4c0 mm/vma.c:181
       __split_vma+0x9b7/0xc50 mm/vma.c:419
       split_vma mm/vma.c:460 [inline]
       vma_modify+0x153a/0x1a80 mm/vma.c:1433
       vma_modify_flags+0x3a9/0x420 mm/vma.c:1451
       mprotect_fixup+0x45a/0xaa0 mm/mprotect.c:664
       do_mprotect_pkey+0x8e0/0xd80 mm/mprotect.c:838
       __do_sys_mprotect mm/mprotect.c:859 [inline]
       __se_sys_mprotect mm/mprotect.c:856 [inline]
       __x64_sys_mprotect+0x80/0x90 mm/mprotect.c:856
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &anon_vma->rwsem --> fs_reclaim --> &mapping->i_mmap_rwsem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&mapping->i_mmap_rwsem);
                               lock(fs_reclaim);
                               lock(&mapping->i_mmap_rwsem);
  lock(&anon_vma->rwsem);

 *** DEADLOCK ***

2 locks held by init/1:
 #0: ffff88802e138198 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:122 [inline]
 #0: ffff88802e138198 (&mm->mmap_lock){++++}-{3:3}, at: do_mprotect_pkey+0x21b/0xd80 mm/mprotect.c:740
 #1: ffff888025b4d608 (&mapping->i_mmap_rwsem){+.+.}-{3:3}, at: i_mmap_lock_write include/linux/fs.h:507 [inline]
 #1: ffff888025b4d608 (&mapping->i_mmap_rwsem){+.+.}-{3:3}, at: vma_prepare+0x13e/0x4c0 mm/vma.c:167

stack backtrace:
CPU: 0 UID: 0 PID: 1 Comm: init Not tainted 6.12.0-rc2-next-20241008-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
 __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 down_write+0x99/0x220 kernel/locking/rwsem.c:1577
 anon_vma_lock_write include/linux/rmap.h:121 [inline]
 vma_prepare+0x26c/0x4c0 mm/vma.c:181
 __split_vma+0x9b7/0xc50 mm/vma.c:419
 split_vma mm/vma.c:460 [inline]
 vma_modify+0x153a/0x1a80 mm/vma.c:1433
 vma_modify_flags+0x3a9/0x420 mm/vma.c:1451
 mprotect_fixup+0x45a/0xaa0 mm/mprotect.c:664
 do_mprotect_pkey+0x8e0/0xd80 mm/mprotect.c:838
 __do_sys_mprotect mm/mprotect.c:859 [inline]
 __se_sys_mprotect mm/mprotect.c:856 [inline]
 __x64_sys_mprotect+0x80/0x90 mm/mprotect.c:856
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7347f7dbb7
Code: 00 00 00 b8 0b 00 00 00 0f 05 48 3d 01 f0 ff ff 73 01 c3 48 8d 0d b9 46 01 00 f7 d8 89 01 48 83 c8 ff c3 b8 0a 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8d 0d 99 46 01 00 f7 d8 89 01 48 83
RSP: 002b:00007ffde248d688 EFLAGS: 00000206 ORIG_RAX: 000000000000000a
RAX: ffffffffffffffda RBX: 00007f7347f5a5c0 RCX: 00007f7347f7dbb7
RDX: 0000000000000001 RSI: 0000000000004000 RDI: 00007f7347e84000
RBP: 00007ffde248d7a0 R08: 00007ffde2480000 R09: 00007f7347f91ab0
R10: 00007f7347ceaab8 R11: 0000000000000206 R12: 00007f7347f5a5c0
R13: 00007f7347f85eda R14: 00007f7347e87bf8 R15: 00007f7347e87b70
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

