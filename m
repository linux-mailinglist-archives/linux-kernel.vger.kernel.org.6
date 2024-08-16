Return-Path: <linux-kernel+bounces-289038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFEE95417B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 08:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8245E1C21EAC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 06:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AE68063C;
	Fri, 16 Aug 2024 06:06:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B024923D7
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 06:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723788366; cv=none; b=G6Yiwpjd9YO6nYrGEHFD3SGms3CzsVAvVJixJD0Bv7IBDKfOZBMj1aLA8uCaj4rWKRWMxB57NvzwOWSiv99gT6Jjr+p1IHIArXGboPagyQ8AlU2OD1/VgJz7GHuyKuauX/PNKgndwdP1ErMMe1RJaq7znf3Tw8e1CspLYApie5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723788366; c=relaxed/simple;
	bh=tvM4V+kFWSTNw4g92Gi2qnR7RZ8JO/RPvvGYsXMVHlQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FM62Apr/qNUdw5By1KnC8SyyGAOfuErVXHZXbT3qFrM3zVZ1KG17DqUymSQA6s5hThdZ0W/c5Xs/9fciZQ+RsEA4ck0kmyQNqnEhbyCEB3ovYfGq20vb0tbn33OW50EFQRmdYxG2XOPF+TfBmAq2EFLF2h36d0XbTg0asCPpBUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f99a9111fso174801439f.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 23:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723788364; x=1724393164;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GwSCLpnT9T89QDSxCCihzkUT34TsLa28jxgLL89hK+M=;
        b=YCoLEODYsAOr+EoBRiEnyvtR85w7M8oM6+YHU1uZKevDLdXM9HWToJ4mh4aZHbhiQr
         pe/C+pg6po6gWb8AcuRSq/a6byMnq6NgomfOgO4RWk9zFBv97dpax3vfuNUj4gIy8rqc
         6WKGtjnLlRsKbWJJG314mDsRkqurWXS5UlOTTDp2/jfwNbliv02kzNlKZybN9q0Ae1Pp
         S7ij3HjBUkPaYi7TQ3aS5ezdkfVvxoVnWrxNck6PfTNMUsRtYy0OGv44oYJfCCtvmm3s
         Tn/OZ+gcg+cIHx0SdCS20otAh9lb+r/EXlNWOrFv7cJjFkMlDgpd6omHJAIRFTFevbdc
         TP6g==
X-Gm-Message-State: AOJu0Yxn33cWtXxr4pBylmPCjKT+j4U1PgwLgmLCqI7bmDHX9LuxqMY/
	OTIODEtjl+XcWl0Mc3v/6GwT+ZRkIaALJbsSrohAUGbrDQvJXgopMgWU4i1n0KMCaGjK9XN7muc
	Ce/IGvqlJYET6TnRIqBJF2FKfDMqdj9eDpEBwQc1CQS5PW1KZBk5Q2mQ=
X-Google-Smtp-Source: AGHT+IEmbm0FmQV7Jt1raM/EFAjgWD1uN1OujxRCYs1Ym9fwbV+qcJH7cRBKmLCq0V5SRiYh99dq1QvJCBmMC1w58ZP170rSBgbr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2182:b0:4c2:7f96:6f2 with SMTP id
 8926c6da1cb9f-4cce16ce235mr38339173.4.1723788363139; Thu, 15 Aug 2024
 23:06:03 -0700 (PDT)
Date: Thu, 15 Aug 2024 23:06:03 -0700
In-Reply-To: <20240816054904.4016904-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000d9d23061fc6c1ad@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_iget
From: syzbot <syzbot+5bdd4953bc58c8fbd6eb@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in ocfs2_read_blocks_sync

INFO: task syz.0.15:5591 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc3-syzkaller-00060-gd07b43284ab3-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.15        state:D stack:22832 pid:5591  tgid:5590  ppid:5536   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 io_schedule+0x8d/0x110 kernel/sched/core.c:7401
 bit_wait_io+0x12/0xd0 kernel/sched/wait_bit.c:209
 __wait_on_bit+0xb0/0x2f0 kernel/sched/wait_bit.c:49
 out_of_line_wait_on_bit+0x1d5/0x260 kernel/sched/wait_bit.c:64
 wait_on_buffer include/linux/buffer_head.h:415 [inline]
 ocfs2_read_blocks_sync+0xc51/0xfe0 fs/ocfs2/buffer_head_io.c:183
 ocfs2_read_locked_inode fs/ocfs2/inode.c:503 [inline]
 ocfs2_iget+0xa3a/0x2120 fs/ocfs2/inode.c:159
 ocfs2_init_global_system_inodes+0xc6/0x730 fs/ocfs2/super.c:437
 ocfs2_initialize_super fs/ocfs2/super.c:2250 [inline]
 ocfs2_fill_super+0x3068/0x5880 fs/ocfs2/super.c:994
 mount_bdev+0x20a/0x2d0 fs/super.c:1679
 legacy_get_tree+0xee/0x190 fs/fs_context.c:662
 vfs_get_tree+0x90/0x2a0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3472
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7eff18d7b0ba
RSP: 002b:00007eff19a76e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007eff19a76ef0 RCX: 00007eff18d7b0ba
RDX: 0000000020004480 RSI: 00000000200044c0 RDI: 00007eff19a76eb0
RBP: 0000000020004480 R08: 00007eff19a76ef0 R09: 0000000002800400
R10: 0000000002800400 R11: 0000000000000246 R12: 00000000200044c0
R13: 00007eff19a76eb0 R14: 0000000000004481 R15: 00000000200001c0
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/25:
 #0: ffffffff8e9382e0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #0: ffffffff8e9382e0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #0: ffffffff8e9382e0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6626
2 locks held by kswapd0/72:
2 locks held by getty/4888:
 #0: ffff88801b6c10a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000039b2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6ac/0x1e00 drivers/tty/n_tty.c:2211
1 lock held by syz.0.15/5591:
 #0: ffff8880429de0e0 (&type->s_umount_key#52/1){+.+.}-{3:3}, at: alloc_super+0x221/0x9d0 fs/super.c:344

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 25 Comm: khungtaskd Not tainted 6.11.0-rc3-syzkaller-00060-gd07b43284ab3-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xfee/0x1030 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


Tested on:

commit:         d07b4328 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12e04605980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7229118d88b4a71b
dashboard link: https://syzkaller.appspot.com/bug?extid=5bdd4953bc58c8fbd6eb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14c516d5980000


