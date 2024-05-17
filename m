Return-Path: <linux-kernel+bounces-182161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC3A8C877E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 15:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D29D61C21923
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 13:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940C754FAF;
	Fri, 17 May 2024 13:54:36 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA4346B9A
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 13:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715954076; cv=none; b=bARAHHxZmZOpLMPZpnwY5bSOhC8rOTwUoiKQx3isSSiOFjooZ6/Sgnfsn9XPBxLIC8NM3qPgt7LZGBTE3c2mC5qpuUFCjS3J7HAlR3eyevqJcbifik4aD1RXxjBqtfpOBW3qKsZ2ZONT+5oL6qNZDDbB/LOGMdU+cu7pxl3mM7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715954076; c=relaxed/simple;
	bh=d5B6wu4PJwgE4+gEmazIiE4q1EyzjNwUaJMGd5ydVZo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bcj1NR+2av7UvVgMYpzBfRglvbQv1OWZ5WmPdDKkaWPa7/xQ6hIZwFNAdmNw7a6f5phro0WSXyrOrqILnZjEovchb3SA7rM2ZS547CQKPUAjiPIVSWp7B/9D8KWSXra/oawFLLCr1zW+5CgZThtTOJYiIdRvV8jqB/kTn8zu/Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7e1be009e6eso892259939f.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 06:54:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715954073; x=1716558873;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GRI7rMZcwU1RNVH7EUxut7F9F2EtbNepc7wNWtnYSV4=;
        b=XUG6rruQRAmSkSlO54U1rsfNJzXizE8UFD+dO0AYFKbmzB8j3V2ZksX6x20nQ6iOHZ
         ixJCaT+QJeztvKUpDF0r2xYlelc0QT8gsYHLBWd13TJUz4eG9alodAf+nV372kWG8ziZ
         xPLFGkjmKPoet41aeqJxftzKaQo84crj3ZVRlZ2csaiRgFO68Smuq01jG5i7BcahTwgh
         cKV6HewcXHWw/GyQK13fCuix2/0MS9vYfVMwFOTfbRmZzyi4D5OCfV/oX17WZpvAfZln
         b0dHSEBbVLwparRa5QJiwSmCZ+hsm9OU+SeEhh5RG07vpILo++gM8NjCewdKp65qjEEo
         u96w==
X-Forwarded-Encrypted: i=1; AJvYcCUZDfj/YjFIb4ngRbjr4q4ZLIW3OwrIcAVKA/mFW4gUuHf3bY9x0kKLD5lw02Yn8SU4OxXY1CN4bAo9/ET6tLEsWgZmy0kDAVzkSAUY
X-Gm-Message-State: AOJu0Yxl1BfsyQjdg8rhbr0KGxni/e6u6KznVbIsvLc61ZJ7c2fH/HwG
	6EY8L+ZIVLp8e32zwRmy0a2fn8AhAqc+mw+bcMRC+VWrcKK3Lc2tQUou843m3PHtLbnzaswrjXx
	OoM5bx8bvZPuS1Va1lZDqCBvWIbE/Yx2mVsNT1uiNFm/Oovh+aGY8OEc=
X-Google-Smtp-Source: AGHT+IF1pEZ5+bGSb50Vmm04V8USD5yJ/oDyU3gt5GwPswHgjBcRBmWjxFZfVPwyOM6k8Sx8fK2uCvHDW9rlzlM6RYokIUAot2n1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3f85:b0:7da:9d28:6578 with SMTP id
 ca18e2360f4ac-7e1b521c6famr79259239f.3.1715954073515; Fri, 17 May 2024
 06:54:33 -0700 (PDT)
Date: Fri, 17 May 2024 06:54:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000000cc8f0618a6b15d@google.com>
Subject: [syzbot] [udf?] possible deadlock in udf_setsize
From: syzbot <syzbot+0333a6f4b88bcd68a62f@syzkaller.appspotmail.com>
To: jack@suse.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a38297e3fb01 Linux 6.9
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13228d24980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=edefe34e4544d70e
dashboard link: https://syzkaller.appspot.com/bug?extid=0333a6f4b88bcd68a62f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-a38297e3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/eb6ef4d9e74f/vmlinux-a38297e3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ce2fb6bcfd40/bzImage-a38297e3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0333a6f4b88bcd68a62f@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.9.0-syzkaller #0 Not tainted
------------------------------------------------------
kswapd0/110 is trying to acquire lock:
ffff88804a5cbdf0 (mapping.invalidate_lock#4){++++}-{3:3}, at: filemap_invalidate_lock include/linux/fs.h:840 [inline]
ffff88804a5cbdf0 (mapping.invalidate_lock#4){++++}-{3:3}, at: udf_setsize+0x256/0x1180 fs/udf/inode.c:1254

but task is already holding lock:
ffffffff8d937180 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x166/0x1a10 mm/vmscan.c:6782

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:3698 [inline]
       fs_reclaim_acquire+0x102/0x160 mm/page_alloc.c:3712
       might_alloc include/linux/sched/mm.h:312 [inline]
       prepare_alloc_pages.constprop.0+0x155/0x560 mm/page_alloc.c:4346
       __alloc_pages+0x194/0x2460 mm/page_alloc.c:4564
       alloc_pages_mpol+0x275/0x610 mm/mempolicy.c:2264
       folio_alloc+0x1e/0x40 mm/mempolicy.c:2342
       filemap_alloc_folio+0x3ba/0x490 mm/filemap.c:984
       __filemap_get_folio+0x527/0xa90 mm/filemap.c:1926
       filemap_fault+0x610/0x38c0 mm/filemap.c:3299
       __do_fault+0x10a/0x490 mm/memory.c:4531
       do_shared_fault mm/memory.c:4954 [inline]
       do_fault mm/memory.c:5028 [inline]
       do_pte_missing mm/memory.c:3880 [inline]
       handle_pte_fault mm/memory.c:5300 [inline]
       __handle_mm_fault+0x3148/0x4a80 mm/memory.c:5441
       handle_mm_fault+0x476/0xa00 mm/memory.c:5606
       do_user_addr_fault+0x426/0x1030 arch/x86/mm/fault.c:1331
       handle_page_fault arch/x86/mm/fault.c:1474 [inline]
       exc_page_fault+0x5c/0xc0 arch/x86/mm/fault.c:1532
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

-> #0 (mapping.invalidate_lock#4){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
       down_write+0x3a/0x50 kernel/locking/rwsem.c:1579
       filemap_invalidate_lock include/linux/fs.h:840 [inline]
       udf_setsize+0x256/0x1180 fs/udf/inode.c:1254
       udf_evict_inode+0x361/0x590 fs/udf/inode.c:144
       evict+0x2ed/0x6c0 fs/inode.c:667
       iput_final fs/inode.c:1741 [inline]
       iput.part.0+0x5a8/0x7f0 fs/inode.c:1767
       iput+0x5c/0x80 fs/inode.c:1757
       dentry_unlink_inode+0x295/0x440 fs/dcache.c:400
       __dentry_kill+0x1d0/0x600 fs/dcache.c:603
       shrink_kill fs/dcache.c:1048 [inline]
       shrink_dentry_list+0x140/0x5d0 fs/dcache.c:1075
       prune_dcache_sb+0xeb/0x150 fs/dcache.c:1156
       super_cache_scan+0x32a/0x550 fs/super.c:221
       do_shrink_slab+0x44f/0x11c0 mm/shrinker.c:435
       shrink_slab_memcg mm/shrinker.c:548 [inline]
       shrink_slab+0xa87/0x1310 mm/shrinker.c:626
       shrink_one+0x493/0x7c0 mm/vmscan.c:4774
       shrink_many mm/vmscan.c:4835 [inline]
       lru_gen_shrink_node+0x89f/0x1750 mm/vmscan.c:4935
       shrink_node mm/vmscan.c:5894 [inline]
       kswapd_shrink_node mm/vmscan.c:6704 [inline]
       balance_pgdat+0x10d1/0x1a10 mm/vmscan.c:6895
       kswapd+0x5ea/0xbf0 mm/vmscan.c:7164
       kthread+0x2c1/0x3a0 kernel/kthread.c:388
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(mapping.invalidate_lock#4);
                               lock(fs_reclaim);
  lock(mapping.invalidate_lock#4);

 *** DEADLOCK ***

2 locks held by kswapd0/110:
 #0: ffffffff8d937180 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x166/0x1a10 mm/vmscan.c:6782
 #1: ffff88801cd260e0 (&type->s_umount_key#57){++++}-{3:3}, at: super_trylock_shared fs/super.c:561 [inline]
 #1: ffff88801cd260e0 (&type->s_umount_key#57){++++}-{3:3}, at: super_cache_scan+0x96/0x550 fs/super.c:196

stack backtrace:
CPU: 2 PID: 110 Comm: kswapd0 Not tainted 6.9.0-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 down_write+0x3a/0x50 kernel/locking/rwsem.c:1579
 filemap_invalidate_lock include/linux/fs.h:840 [inline]
 udf_setsize+0x256/0x1180 fs/udf/inode.c:1254
 udf_evict_inode+0x361/0x590 fs/udf/inode.c:144
 evict+0x2ed/0x6c0 fs/inode.c:667
 iput_final fs/inode.c:1741 [inline]
 iput.part.0+0x5a8/0x7f0 fs/inode.c:1767
 iput+0x5c/0x80 fs/inode.c:1757
 dentry_unlink_inode+0x295/0x440 fs/dcache.c:400
 __dentry_kill+0x1d0/0x600 fs/dcache.c:603
 shrink_kill fs/dcache.c:1048 [inline]
 shrink_dentry_list+0x140/0x5d0 fs/dcache.c:1075
 prune_dcache_sb+0xeb/0x150 fs/dcache.c:1156
 super_cache_scan+0x32a/0x550 fs/super.c:221
 do_shrink_slab+0x44f/0x11c0 mm/shrinker.c:435
 shrink_slab_memcg mm/shrinker.c:548 [inline]
 shrink_slab+0xa87/0x1310 mm/shrinker.c:626
 shrink_one+0x493/0x7c0 mm/vmscan.c:4774
 shrink_many mm/vmscan.c:4835 [inline]
 lru_gen_shrink_node+0x89f/0x1750 mm/vmscan.c:4935
 shrink_node mm/vmscan.c:5894 [inline]
 kswapd_shrink_node mm/vmscan.c:6704 [inline]
 balance_pgdat+0x10d1/0x1a10 mm/vmscan.c:6895
 kswapd+0x5ea/0xbf0 mm/vmscan.c:7164
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
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

