Return-Path: <linux-kernel+bounces-559621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11944A5F65E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F9543BA78C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FA7267B9C;
	Thu, 13 Mar 2025 13:50:32 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA51341760
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741873831; cv=none; b=IY4Kjvmp1UZmE32WKPcDMi6+8MkpWdpdOM87IVC4icigAeaHb6r2Tl5wutQ0RqnhFz/x/Dcg3D+bX5HYgCBi0LQBqKz91SpD1NJG6cSnx3PPVCo3wqAOjCp06XAkIUKC1SE072Rx3pwf4/oqwoVRVjmHY0Eg9MxQv3Ioqu1CVUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741873831; c=relaxed/simple;
	bh=fsbA3flqjiSRKRKKVR/1lA5ZNITyKzORGhe+k6vGBzI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eauQUHXE23jMJSPYFGujIqapL3ZszT5TRO0D7CXI+Y8K+ytu12IVDsg+KmIfz3Y3L306x690wEPxbteeRJB8ejm4CI9ExfMk26Rk6OH/Vtwj8uJOSpzDoTtp39pagwi8qE59jga+kE61KHdhuAMNwzb+BWzHzUC1IhkcSLowvvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-85b34bd03c4so145077139f.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 06:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741873829; x=1742478629;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9BiYmPcS+/15f+yr76+Ue+91J5LjrqFo50ToEVZ9+m0=;
        b=DqeYajDkHAZwiUSZuePcz4b0sCMyz0A+/+9TDW3IY23nB4M34BsBkWbl047qsjHkjj
         0T7hiNpq4MMGN877RH0BlFK8EbgnN2eMjK97QV5rdvJHfwh+A/vQNA1Ny5+6dEtMXBd1
         Klt6AfJSSwdm7n68NcaT8u/7Nyowq3T/OCOia/G7XdzJ88S6y7SufVXi5eCw18atD15j
         TsOXVEBu+KnHK+VTTYt6fnRzv0bXJHF/gb8/H2NdSNQ8trNyEmHeBEoiOr1q2PoyJ9NA
         KHLJhUm5hqfMwMJamV3c7tM+1LK2KaVXFjRlxQCyCxjxpYLCcr5rsVQc4PpTGFprXY8p
         5Vtw==
X-Forwarded-Encrypted: i=1; AJvYcCVnac6FdG5bDEle/vIltNpEgkO/PnEqcIL1Xush/NtEUqa2cUNa40uxQtWPjADaErK4C17QxvRFZlZulTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkMwQ0Zv3zWehTqvrs9YeZKGg1OfziWQiWOCbgAfBNYwbEA8RJ
	NY0ddKrH4kqVj5aNSuQM0qoRw5UpsMNCxyhmhWVY+2seN0Oa4utxQbv+nHgbjA47jEtDPaBBqFC
	I48vk+/S2F6Hi3rjcBJrfN67aEFeAtIUfZamQIbUvJNjI7VyNDNcj7Rg=
X-Google-Smtp-Source: AGHT+IG9wNcQHEi8QkSfQ7QqqK877DISuSyGA7l7g3ZRyEdUy8gP7jwTv/1S7DE2wfq0jBrfz3QTv4FEu/IycTtyg814flVtQ0+h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4b2:b0:3d4:6f37:3724 with SMTP id
 e9e14a558f8ab-3d46f37380emr70150375ab.18.1741873828969; Thu, 13 Mar 2025
 06:50:28 -0700 (PDT)
Date: Thu, 13 Mar 2025 06:50:28 -0700
In-Reply-To: <679f3464.050a0220.d7c5a.006d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d2e2a4.050a0220.14e108.0035.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] possible deadlock in ocfs2_finish_quota_recovery
From: syzbot <syzbot+f59a1ae7b7227c859b8f@syzkaller.appspotmail.com>
To: jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    b7f94fcf5546 Merge tag 'sched_ext-for-6.14-rc6-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=113addb0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=efbd4e7089941bb6
dashboard link: https://syzkaller.appspot.com/bug?extid=f59a1ae7b7227c859b8f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1695e698580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12a6e04c580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-b7f94fcf.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/961a37fe09ad/vmlinux-b7f94fcf.xz
kernel image: https://storage.googleapis.com/syzbot-assets/483b4fd1ba55/bzImage-b7f94fcf.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c0b6b6f0715a/mount_0.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=14a6e04c580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f59a1ae7b7227c859b8f@syzkaller.appspotmail.com

ocfs2: Finishing quota recovery on device (7,0) for slot 0
======================================================
WARNING: possible circular locking dependency detected
6.14.0-rc6-syzkaller-00022-gb7f94fcf5546 #0 Not tainted
------------------------------------------------------
kworker/u4:10/1087 is trying to acquire lock:
ffff88803c49e0e0 (&type->s_umount_key#42){++++}-{4:4}, at: ocfs2_finish_quota_recovery+0x15c/0x22a0 fs/ocfs2/quota_local.c:603

but task is already holding lock:
ffffc900026ffc60 ((work_completion)(&journal->j_recovery_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
ffffc900026ffc60 ((work_completion)(&journal->j_recovery_work)){+.+.}-{0:0}, at: process_scheduled_works+0x9c6/0x18e0 kernel/workqueue.c:3319

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 ((work_completion)(&journal->j_recovery_work)){+.+.}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
       process_one_work kernel/workqueue.c:3214 [inline]
       process_scheduled_works+0x9e4/0x18e0 kernel/workqueue.c:3319
       worker_thread+0x870/0xd30 kernel/workqueue.c:3400
       kthread+0x7a9/0x920 kernel/kthread.c:464
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #1 ((wq_completion)ocfs2_wq){+.+.}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
       touch_wq_lockdep_map+0xc7/0x170 kernel/workqueue.c:3907
       __flush_workqueue+0x14a/0x1280 kernel/workqueue.c:3949
       ocfs2_shutdown_local_alloc+0x109/0xa90 fs/ocfs2/localalloc.c:380
       ocfs2_dismount_volume+0x202/0x910 fs/ocfs2/super.c:1822
       generic_shutdown_super+0x139/0x2d0 fs/super.c:642
       kill_block_super+0x44/0x90 fs/super.c:1710
       deactivate_locked_super+0xc4/0x130 fs/super.c:473
       cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1413
       task_work_run+0x24f/0x310 kernel/task_work.c:227
       resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
       exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
       exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
       __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
       syscall_exit_to_user_mode+0x13f/0x340 kernel/entry/common.c:218
       do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&type->s_umount_key#42){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3163 [inline]
       check_prevs_add kernel/locking/lockdep.c:3282 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3906
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5228
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1524
       ocfs2_finish_quota_recovery+0x15c/0x22a0 fs/ocfs2/quota_local.c:603
       ocfs2_complete_recovery+0x17c1/0x25c0 fs/ocfs2/journal.c:1357
       process_one_work kernel/workqueue.c:3238 [inline]
       process_scheduled_works+0xabe/0x18e0 kernel/workqueue.c:3319
       worker_thread+0x870/0xd30 kernel/workqueue.c:3400
       kthread+0x7a9/0x920 kernel/kthread.c:464
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

Chain exists of:
  &type->s_umount_key#42 --> (wq_completion)ocfs2_wq --> (work_completion)(&journal->j_recovery_work)

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock((work_completion)(&journal->j_recovery_work));
                               lock((wq_completion)ocfs2_wq);
                               lock((work_completion)(&journal->j_recovery_work));
  rlock(&type->s_umount_key#42);

 *** DEADLOCK ***

2 locks held by kworker/u4:10/1087:
 #0: ffff8880403eb148 ((wq_completion)ocfs2_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff8880403eb148 ((wq_completion)ocfs2_wq){+.+.}-{0:0}, at: process_scheduled_works+0x98b/0x18e0 kernel/workqueue.c:3319
 #1: ffffc900026ffc60 ((work_completion)(&journal->j_recovery_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc900026ffc60 ((work_completion)(&journal->j_recovery_work)){+.+.}-{0:0}, at: process_scheduled_works+0x9c6/0x18e0 kernel/workqueue.c:3319

stack backtrace:
CPU: 0 UID: 0 PID: 1087 Comm: kworker/u4:10 Not tainted 6.14.0-rc6-syzkaller-00022-gb7f94fcf5546 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: ocfs2_wq ocfs2_complete_recovery
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2076
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2208
 check_prev_add kernel/locking/lockdep.c:3163 [inline]
 check_prevs_add kernel/locking/lockdep.c:3282 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3906
 __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5228
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
 down_read+0xb1/0xa40 kernel/locking/rwsem.c:1524
 ocfs2_finish_quota_recovery+0x15c/0x22a0 fs/ocfs2/quota_local.c:603
 ocfs2_complete_recovery+0x17c1/0x25c0 fs/ocfs2/journal.c:1357
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xabe/0x18e0 kernel/workqueue.c:3319
 worker_thread+0x870/0xd30 kernel/workqueue.c:3400
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

