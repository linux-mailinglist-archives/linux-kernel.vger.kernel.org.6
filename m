Return-Path: <linux-kernel+bounces-334586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB1897D94D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 19:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23E76B235EF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 17:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8C31802A8;
	Fri, 20 Sep 2024 17:35:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F5D17DFE8
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 17:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726853705; cv=none; b=oNVQu9Xi0VbACI3XgDlVAp7xihbc1c6td+piCczqt2aBMNSCXIvHBKG49WYwSqf0Edm7yQRn8YUSbm8iS+zbI9o0FislkH0zyjc2Ip9kgST6eJQ9JAq3GFGTCci7+/ncFRf1bIGbAY6elaK9KA3hFzhNGnd4Tnt5U9Y8DXkJB9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726853705; c=relaxed/simple;
	bh=/KAdyufEKhKG0cg8Vvs5zpjccKwUDHyXzj9xiAssOmQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=L00d31Mklr4/xSbPRB1yBgt5DfcL8pj5qtQyghShjz5uJcVoUS1ldnQ2GUhUdugqhR+tRMFHSrMsy+xU8RTwbwTlt0Grd9gEriIx+jq/HUEokU75Mc/ZFk9+gJQgtgfWxXF1XP04tuzyQeDqF+J0G2ej0YEQslCZxCTGRx/tMc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a0cb7141adso10281995ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 10:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726853703; x=1727458503;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rqTB8EnAXJCN7qVKidSsNqv2QpgDXSX0aoxpXM++fhw=;
        b=qPeQCkyhGHB8eInl/9RiuDdsSbGXkiHyHpbxBiq8n73qV1/22VYq7IYoRtOET04l2v
         ZLVfMbDu/wz+59Hmo/CJuxTY6j7CUFgmtDMbxZ3HOJa4fG83r1Xg1Lq3hWRvRJNEEsL0
         KQwSWUl2Zu5MrwfXG8VZi3AhjUsW3vSgZeLbedOpYwqCA/Rn0S0h0yuqUUWPh7YzdKLF
         4X1XYA32/SZ5akUz3qW0GjD8DlbgovJDWdV3F7nLUcgHKzmAFG4g1kg+Q6GcH4uV8YaP
         knntTXnVmaIpbq+MzUYHAUsnNqNlkKFSOZejFwGSftBVtqSyfGU5uXaab7unvGuSI+hE
         1h5A==
X-Forwarded-Encrypted: i=1; AJvYcCWitTIiq9EJ+5oq+VpBqe/C5LCors1b0BJdmZi8/q/YERTsRp2KumzWy1NtzqJ1R+H52HwPQ71CxVsakUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPWd1vhJR0Iisq381Z4orYRPJgZJoVk+2yygVWRA+TQBtpswLd
	6M4VsrSljNsMym3UHsJ+Bcn6rHCrsPRd/oo8PsNJBStAJn6l5RGMfe/VXqbCHu/IKPVR5QY9yaG
	m3h8K4GydvkbzXy4k3FmG1sPnA7bS3ytdBbdfIo2EkcbbKgMUcjOSe7A=
X-Google-Smtp-Source: AGHT+IHRWGbi/We0MCVHyOuaZ2XtNEYgthX5T28/KKJJcBHzRaoNJRnlB2R+h9pqmYM0XOHcJaPZiwNs8l3SEsUl/FCcIyG2MWBm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c01:b0:3a0:c7f9:29e2 with SMTP id
 e9e14a558f8ab-3a0c9d6ff9bmr38925035ab.19.1726853703222; Fri, 20 Sep 2024
 10:35:03 -0700 (PDT)
Date: Fri, 20 Sep 2024 10:35:03 -0700
In-Reply-To: <20240920171409.4054-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66edb247.050a0220.3195df.0001.GAE@google.com>
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Read in iov_iter_advance
From: syzbot <syzbot+7c48153a9d788824044b@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: sleeping function called from invalid context in mempool_alloc_noprof

BUG: sleeping function called from invalid context at include/linux/sched/mm.h:337
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6020, name: syz.0.15
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
2 locks held by syz.0.15/6020:
 #0: ffff888071360500 (&ctx->wb_lock){+.+.}-{3:3}, at: netfs_writepages+0xb8/0xb90 fs/netfs/write_issue.c:509
 #1: ffff888143aea528 (&rreq->lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #1: ffff888143aea528 (&rreq->lock){+.+.}-{2:2}, at: netfs_write_folio+0x5a9/0x19b0 fs/netfs/write_issue.c:431
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 0 UID: 0 PID: 6020 Comm: syz.0.15 Not tainted 6.11.0-syzkaller-07341-gbaeb9a7d8b60-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:119
 __might_resched+0x3c0/0x5e0 kernel/sched/core.c:8547
 might_alloc include/linux/sched/mm.h:337 [inline]
 mempool_alloc_noprof+0x1e8/0x390 mm/mempool.c:392
 netfs_alloc_subrequest+0xc1/0x3c0 fs/netfs/objects.c:186
 netfs_prepare_write fs/netfs/write_issue.c:157 [inline]
 netfs_advance_write fs/netfs/write_issue.c:279 [inline]
 netfs_advance_write+0x3b0/0xbd0 fs/netfs/write_issue.c:259
 netfs_write_folio+0xb62/0x19b0 fs/netfs/write_issue.c:471
 netfs_writepages+0x2ba/0xb90 fs/netfs/write_issue.c:544
 do_writepages+0x1a6/0x7f0 mm/page-writeback.c:2683
 filemap_fdatawrite_wbc mm/filemap.c:397 [inline]
 filemap_fdatawrite_wbc+0x148/0x1c0 mm/filemap.c:387
 __filemap_fdatawrite_range+0xba/0x100 mm/filemap.c:430
 v9fs_dir_release+0x429/0x590 fs/9p/vfs_dir.c:219
 __fput+0x3f9/0xb60 fs/file_table.c:431
 task_work_run+0x151/0x250 kernel/task_work.c:228
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x27b/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbfe037def9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc8aec11f8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007fbfe0537a80 RCX: 00007fbfe037def9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007fbfe0537a80 R08: 0000000000000000 R09: 00007ffc8aec14ef
R10: 000000000003fd88 R11: 0000000000000246 R12: 00000000000239d8
R13: 00007ffc8aec1300 R14: 0000000000000032 R15: ffffffffffffffff
 </TASK>

============================================
WARNING: possible recursive locking detected
6.11.0-syzkaller-07341-gbaeb9a7d8b60-dirty #0 Tainted: G        W         
--------------------------------------------
syz.0.15/6020 is trying to acquire lock:
ffff888143aea528 (&rreq->lock){+.+.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff888143aea528 (&rreq->lock){+.+.}-{2:2}, at: netfs_prepare_write fs/netfs/write_issue.c:191 [inline]
ffff888143aea528 (&rreq->lock){+.+.}-{2:2}, at: netfs_advance_write fs/netfs/write_issue.c:279 [inline]
ffff888143aea528 (&rreq->lock){+.+.}-{2:2}, at: netfs_advance_write+0x6c8/0xbd0 fs/netfs/write_issue.c:259

but task is already holding lock:
ffff888143aea528 (&rreq->lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
ffff888143aea528 (&rreq->lock){+.+.}-{2:2}, at: netfs_write_folio+0x5a9/0x19b0 fs/netfs/write_issue.c:431

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&rreq->lock);
  lock(&rreq->lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by syz.0.15/6020:
 #0: ffff888071360500 (&ctx->wb_lock){+.+.}-{3:3}, at: netfs_writepages+0xb8/0xb90 fs/netfs/write_issue.c:509
 #1: ffff888143aea528 (&rreq->lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #1: ffff888143aea528 (&rreq->lock){+.+.}-{2:2}, at: netfs_write_folio+0x5a9/0x19b0 fs/netfs/write_issue.c:431

stack backtrace:
CPU: 0 UID: 0 PID: 6020 Comm: syz.0.15 Tainted: G        W          6.11.0-syzkaller-07341-gbaeb9a7d8b60-dirty #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 print_deadlock_bug+0x2e3/0x410 kernel/locking/lockdep.c:3034
 check_deadlock kernel/locking/lockdep.c:3086 [inline]
 validate_chain kernel/locking/lockdep.c:3888 [inline]
 __lock_acquire+0x2185/0x3ce0 kernel/locking/lockdep.c:5199
 lock_acquire kernel/locking/lockdep.c:5822 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5787
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
 _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 netfs_prepare_write fs/netfs/write_issue.c:191 [inline]
 netfs_advance_write fs/netfs/write_issue.c:279 [inline]
 netfs_advance_write+0x6c8/0xbd0 fs/netfs/write_issue.c:259
 netfs_write_folio+0xb62/0x19b0 fs/netfs/write_issue.c:471
 netfs_writepages+0x2ba/0xb90 fs/netfs/write_issue.c:544
 do_writepages+0x1a6/0x7f0 mm/page-writeback.c:2683
 filemap_fdatawrite_wbc mm/filemap.c:397 [inline]
 filemap_fdatawrite_wbc+0x148/0x1c0 mm/filemap.c:387
 __filemap_fdatawrite_range+0xba/0x100 mm/filemap.c:430
 v9fs_dir_release+0x429/0x590 fs/9p/vfs_dir.c:219
 __fput+0x3f9/0xb60 fs/file_table.c:431
 task_work_run+0x151/0x250 kernel/task_work.c:228
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x27b/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbfe037def9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc8aec11f8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007fbfe0537a80 RCX: 00007fbfe037def9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007fbfe0537a80 R08: 0000000000000000 R09: 00007ffc8aec14ef
R10: 000000000003fd88 R11: 0000000000000246 R12: 00000000000239d8
R13: 00007ffc8aec1300 R14: 0000000000000032 R15: ffffffffffffffff
 </TASK>


Tested on:

commit:         baeb9a7d Merge tag 'sched-rt-2024-09-17' of git://git...
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ master
console output: https://syzkaller.appspot.com/x/log.txt?x=10b0a427980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a0a1caedf9d578f
dashboard link: https://syzkaller.appspot.com/bug?extid=7c48153a9d788824044b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1499bf00580000


