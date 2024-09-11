Return-Path: <linux-kernel+bounces-324130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D03EA97483E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 04:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ABD21F220A9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 02:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3C641A84;
	Wed, 11 Sep 2024 02:39:29 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD663FB30
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 02:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726022369; cv=none; b=P6ltfcj6abvceOivKk5+nzpvZsTFc8ZkS9eN6ZdUuTb1q0JRi942WshoU7/YtkmfL1t4uPzDsIRv1vFuOoux4E6gbiCgJmjeJW4SwV4fjeuShXFhRcX22rW9U9gyvPKuLh1yUnZyCstbrKmEKoq1NDJY982M+xkEzH0SA5/v350=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726022369; c=relaxed/simple;
	bh=++ZRCoInTBLKm+pSs03/a8TFxw6wkp3kqIou5r+e0eQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UOFEDPywFE3Nvj2QWYgcfv9oppNmCjP7okxx+TjwsdMFzNghm2uNIzvn6i23pV0YaqJHP95NXi/mQMSLQnI0hz66P6R3ylR6Tf9TChNET/VEKh0IzjaVtwmDt+H7zAS12l5ct+sVpsEpzlvp00oS86TgL+d2vzbd0BjPvxrKAQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a050af2717so29716005ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 19:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726022366; x=1726627166;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wnw9XDtTGWHLyImo1mxGgXqbPU7vJqK/MVyOf9pYnHs=;
        b=u7RMYC0IQHjtGElGD5FaJkmgDAWtp7Q4pQMcc+GSAFpssqPhgwsM/dXjAcg+7LFYTx
         oN2wubmzDp2FHeXu+ov4lL2TFUde68BDsKIeRJOqdmAw+FloeDNAARWrfveDFZhrikzl
         GlRxDABrke6LSS3ImPkAwITuCzMDcD/tRlgesUlPQQXQSp2lBJdgrm9b5DGEi2a4DTYl
         X3SF4ZXNJaFrVOYJ7F6GCBZx2+e8b80Jl5mAfwS+vqrahVLdNeHGwlO+YyKF2S0smxH+
         AaEdJX3Xu/6bpT7+pD+Drlz5ye8STgM3aKiYhlXoqn2i4HiPEe7xHkU8H7e1SQLt9lQC
         y5Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWE8Cd1PtOSwtLgqJdgvrlTDVJrHaD0vJoy6Xf3zyxHYTFIT9gM+cf2B3kiylm1pj7bx8HvgPTey+jmULI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsa55w3Pt9jPheR1b1UUuF3cvv9n8u4y+lOQ5RmgLsCW54Nny/
	X8ujX9UnNWKH15ndfgBZQhOV7VmHIeH3fTqa/Db7pDSm/OxdfDyxItu7TXk6zX7YgUhPaoVV611
	jZ2dYvKviTodPIfh/iAtrQwpR/RVGQGL6G05fmg1SWP7YOxR/YYIkmfk=
X-Google-Smtp-Source: AGHT+IFh1IzJDI+YnTZVnxAhYYEDxo7i34o3nXyJt65WBE8x3cY7wyYXQ1NIGcrHDXcx0EW6xBHE2c4f3v922mNc7ZuHWaigscs+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1846:b0:3a0:4d1f:519c with SMTP id
 e9e14a558f8ab-3a0741f7ddbmr17002365ab.3.1726022366440; Tue, 10 Sep 2024
 19:39:26 -0700 (PDT)
Date: Tue, 10 Sep 2024 19:39:26 -0700
In-Reply-To: <000000000000cb121205ef615844@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000006c6260621cee6ed@google.com>
Subject: Re: [syzbot] [ntfs3?] possible deadlock in ntfs_fallocate
From: syzbot <syzbot+adacb2b0c896bc427962@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    8d8d276ba2fb Merge tag 'trace-v6.11-rc6' of git://git.kern..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10a5e807980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1c9e296880039df9
dashboard link: https://syzkaller.appspot.com/bug?extid=adacb2b0c896bc427962
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13e9fbc7980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1573a100580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/29807f1973f6/disk-8d8d276b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/172d57aa7f61/vmlinux-8d8d276b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/021cabf6f499/bzImage-8d8d276b.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/3ada4caf0079/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/7777f8d9c410/mount_7.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+adacb2b0c896bc427962@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.11.0-rc7-syzkaller-00020-g8d8d276ba2fb #0 Not tainted
------------------------------------------------------
syz-executor399/5227 is trying to acquire lock:
ffff8880758351c8 (&ni->ni_lock/4){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1110 [inline]
ffff8880758351c8 (&ni->ni_lock/4){+.+.}-{3:3}, at: ntfs_fallocate+0x5ca/0x1280 fs/ntfs3/file.c:564

but task is already holding lock:
ffff888075835600 (mapping.invalidate_lock#3){++++}-{3:3}, at: filemap_invalidate_lock include/linux/fs.h:845 [inline]
ffff888075835600 (mapping.invalidate_lock#3){++++}-{3:3}, at: ntfs_fallocate+0x3c7/0x1280 fs/ntfs3/file.c:549

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (mapping.invalidate_lock#3){++++}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1526
       filemap_invalidate_lock_shared include/linux/fs.h:855 [inline]
       filemap_fault+0x658/0x1760 mm/filemap.c:3302
       __do_fault+0x135/0x460 mm/memory.c:4655
       do_shared_fault mm/memory.c:5121 [inline]
       do_fault mm/memory.c:5195 [inline]
       do_pte_missing mm/memory.c:3947 [inline]
       handle_pte_fault+0x1176/0x6fc0 mm/memory.c:5521
       __handle_mm_fault mm/memory.c:5664 [inline]
       handle_mm_fault+0x1056/0x1ad0 mm/memory.c:5832
       do_user_addr_fault arch/x86/mm/fault.c:1338 [inline]
       handle_page_fault arch/x86/mm/fault.c:1481 [inline]
       exc_page_fault+0x459/0x8c0 arch/x86/mm/fault.c:1539
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

-> #2 (&vma->vm_lock->lock){++++}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       down_write+0x99/0x220 kernel/locking/rwsem.c:1579
       vma_start_write include/linux/mm.h:747 [inline]
       vma_link+0x270/0x4f0 mm/mmap.c:457
       insert_vm_struct+0x2f7/0x410 mm/mmap.c:3484
       __bprm_mm_init fs/exec.c:291 [inline]
       bprm_mm_init fs/exec.c:395 [inline]
       alloc_bprm+0x81f/0xda0 fs/exec.c:1623
       kernel_execve+0x99/0xa50 fs/exec.c:2052
       try_to_run_init_process init/main.c:1395 [inline]
       kernel_init+0xed/0x2b0 init/main.c:1523
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #1 (&mm->mmap_lock){++++}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       __might_fault+0xc6/0x120 mm/memory.c:6387
       _inline_copy_to_user include/linux/uaccess.h:176 [inline]
       _copy_to_user+0x2a/0xb0 lib/usercopy.c:26
       copy_to_user include/linux/uaccess.h:209 [inline]
       fiemap_fill_next_extent+0x235/0x410 fs/ioctl.c:145
       ni_fiemap+0x4f5/0x1910 fs/ntfs3/frecord.c:1993
       ntfs_fiemap+0x132/0x180 fs/ntfs3/file.c:1279
       ioctl_fiemap fs/ioctl.c:220 [inline]
       do_vfs_ioctl+0x1c07/0x2e50 fs/ioctl.c:841
       __do_sys_ioctl fs/ioctl.c:905 [inline]
       __se_sys_ioctl+0x81/0x170 fs/ioctl.c:893
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&ni->ni_lock/4){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3133 [inline]
       check_prevs_add kernel/locking/lockdep.c:3252 [inline]
       validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
       __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       ni_lock fs/ntfs3/ntfs_fs.h:1110 [inline]
       ntfs_fallocate+0x5ca/0x1280 fs/ntfs3/file.c:564
       vfs_fallocate+0x553/0x6c0 fs/open.c:334
       do_vfs_ioctl+0x2592/0x2e50 fs/ioctl.c:886
       __do_sys_ioctl fs/ioctl.c:905 [inline]
       __se_sys_ioctl+0x81/0x170 fs/ioctl.c:893
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &ni->ni_lock/4 --> &vma->vm_lock->lock --> mapping.invalidate_lock#3

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(mapping.invalidate_lock#3);
                               lock(&vma->vm_lock->lock);
                               lock(mapping.invalidate_lock#3);
  lock(&ni->ni_lock/4);

 *** DEADLOCK ***

3 locks held by syz-executor399/5227:
 #0: ffff888031898420 (sb_writers#9){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2882 [inline]
 #0: ffff888031898420 (sb_writers#9){.+.+}-{0:0}, at: vfs_fallocate+0x4ea/0x6c0 fs/open.c:333
 #1: ffff888075835460 (&sb->s_type->i_mutex_key#14){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:800 [inline]
 #1: ffff888075835460 (&sb->s_type->i_mutex_key#14){+.+.}-{3:3}, at: ntfs_fallocate+0x2e0/0x1280 fs/ntfs3/file.c:535
 #2: ffff888075835600 (mapping.invalidate_lock#3){++++}-{3:3}, at: filemap_invalidate_lock include/linux/fs.h:845 [inline]
 #2: ffff888075835600 (mapping.invalidate_lock#3){++++}-{3:3}, at: ntfs_fallocate+0x3c7/0x1280 fs/ntfs3/file.c:549

stack backtrace:
CPU: 0 UID: 0 PID: 5227 Comm: syz-executor399 Not tainted 6.11.0-rc7-syzkaller-00020-g8d8d276ba2fb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2186
 check_prev_add kernel/locking/lockdep.c:3133 [inline]
 check_prevs_add kernel/locking/lockdep.c:3252 [inline]
 validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
 __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 ni_lock fs/ntfs3/ntfs_fs.h:1110 [inline]
 ntfs_fallocate+0x5ca/0x1280 fs/ntfs3/file.c:564
 vfs_fallocate+0x553/0x6c0 fs/open.c:334
 do_vfs_ioctl+0x2592/0x2e50 fs/ioctl.c:886
 __do_sys_ioctl fs/ioctl.c:905 [inline]
 __se_sys_ioctl+0x81/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7cf99c7c99
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc8fd1f9c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7cf99c7c99
RDX: 0000000020000000 RSI: 0000000040305829 RDI: 0000000000000006
RBP: 0000000000000000 R08: 0000000000000000 R09: 00007ffc8fd1fa00
R10: 00007ffc8fd1f9d0 R11: 0000000000000246 R12: 00007ffc8fd1fa00
R13: 00007ffc8fd1fc88 R14: 431bde82d7b634db R15: 00007f7cf9a1003b
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

