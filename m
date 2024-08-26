Return-Path: <linux-kernel+bounces-301152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 707ED95ED09
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 11:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25E431F22125
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6905C143886;
	Mon, 26 Aug 2024 09:24:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B7C2F34
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 09:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724664244; cv=none; b=nHvSNmP4t7czjH8zr5dnzPVMNyXQkMvLP7mGUOVXlDp9Ehhmh1gIRKypbef65zVxoYtPYIVqcKJs3BJKXK1d/9pjVhexde2COonNKwU2Ltk0iMI4soFw3bQQE9t1rg/YmKoex68ZPPEo4KnwY+Hr3pBmUibG79kfqbSsGUZ0mCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724664244; c=relaxed/simple;
	bh=8h1WFEKRjIEGz2Fj0U4d5i4qAhYdoYVS30SZlgnBIE8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FQ/8+aCkVI5Ex6TiTAdhLq6x0KJqr0cOptt/jcwYQwbjVyV0nK0lTsW6UDh16Niomp+EZ5H70vRt7voQcNkDiqHsrACL0BzePHRv3zeN+zljL0Wbsq/KgltUtab2ZMKa9AKzsU12WMtyoGDUf1oB2bZmSgidciBWL//NGBEF+Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-824e12631c3so385770739f.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 02:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724664241; x=1725269041;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ER0NtE4l4C7XNjLcheduuAEeBURI9b0znRG/oN8+kWc=;
        b=hgwZwGuvgl12ZmG8CvOZHKpxDPZ9y71uVpU85tTE8Sb7R1JSGSi7CZK11H4v0f8NaY
         XTJS+V1rfgSazKh/gYJk6DAwn0yM0tulZ5ps3xDYYMZPTI+6jJWyvOuI6rE2c/fzwUsb
         YWwjd5Pyki1HNB5ncMtKrmnSXe2pAwKi14UDn19vTkSH8zCw1qYGCAHaULzlOSga7TtF
         DOaCWpZlAjP/cK6F+f3hXO8KzZxQ/tu0MtJnKBzyHel6wnhWyi+lCUPQkBB5+MXmwr0R
         g2+PfyoU0r+hcYoCBiWjAwp5sbvSOZZFupLtYPqk79vGDqFF6om6gv7EosAgbNfmtkoY
         muIw==
X-Gm-Message-State: AOJu0YwBieHLsfMpsU4auhAJaa9ADo6mLJ3S89vBPjitgwFuumOVNLV9
	nU6rGnH0TMVXYdJQlI1CbqB/q2xOTl0WTBzi+7Bd4RtrrdzigqpJQQXv6vBnJ5AaDbC42rfb+2W
	je/ISrwugvdUrfIEFZmXykB71t8I/IBVS29Ival/MBkX3V2akiHl0VFk=
X-Google-Smtp-Source: AGHT+IGi9VrlJYm5tpsY7F7RZGr+8IF7V4g49LE9dbiFCcY4CVWC9k2doLXpoyiU6pxK2OwqyIXpoByl4JS6mC4HwtHRhTWFB2bg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2102:b0:4c2:a865:133a with SMTP id
 8926c6da1cb9f-4ce6ea72e2cmr394297173.1.1724664241498; Mon, 26 Aug 2024
 02:24:01 -0700 (PDT)
Date: Mon, 26 Aug 2024 02:24:01 -0700
In-Reply-To: <20240826090243.1744030-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000078bbf6062092afd3@google.com>
Subject: Re: [syzbot] [jfs?] KASAN: slab-use-after-free Read in lmLogInit
From: syzbot <syzbot+d16facb00df3f446511c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in jfs_flush_journal

INFO: task syz.0.15:5770 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc3-syzkaller-00306-gdf6cbc62cc9b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.15        state:D stack:25840 pid:5770  tgid:5755  ppid:5599   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 jfs_flush_journal+0x72c/0xec0 fs/jfs/jfs_logmgr.c:1573
 jfs_sync_fs+0x80/0xa0 fs/jfs/super.c:684
 sync_filesystem+0x1c8/0x230 fs/sync.c:66
 jfs_remount+0x136/0x6b0 fs/jfs/super.c:432
 reconfigure_super+0x445/0x880 fs/super.c:1083
 do_remount fs/namespace.c:3012 [inline]
 path_mount+0xc22/0xfa0 fs/namespace.c:3791
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc3f097b0ba
RSP: 002b:00007fc3f17a4e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fc3f17a4ef0 RCX: 00007fc3f097b0ba
RDX: 00000000200001c0 RSI: 00000000200002c0 RDI: 0000000000000000
RBP: 00000000200001c0 R08: 00007fc3f17a4ef0 R09: 0000000000108020
R10: 0000000000108020 R11: 0000000000000246 R12: 00000000200002c0
R13: 00007fc3f17a4eb0 R14: 0000000000000000 R15: 0000000020000400
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/25:
 #0: ffffffff8e9382e0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #0: ffffffff8e9382e0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #0: ffffffff8e9382e0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6626
1 lock held by kswapd0/78:
2 locks held by getty/4895:
 #0: ffff88801e8360a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000039b2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6ac/0x1e00 drivers/tty/n_tty.c:2211
1 lock held by syz.0.15/5770:
 #0: ffff888012b560e0 (&type->s_umount_key#54){+.+.}-{3:3}, at: do_remount fs/namespace.c:3009 [inline]
 #0: ffff888012b560e0 (&type->s_umount_key#54){+.+.}-{3:3}, at: path_mount+0xbdb/0xfa0 fs/namespace.c:3791
1 lock held by syz.0.346/6961:
1 lock held by syz.4.347/6964:
2 locks held by syz.2.348/6967:
2 locks held by syz.1.349/6970:
2 locks held by syz.5.350/6972:

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 25 Comm: khungtaskd Not tainted 6.11.0-rc3-syzkaller-00306-gdf6cbc62cc9b-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xff4/0x1040 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


Tested on:

commit:         df6cbc62 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=156aff87980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7229118d88b4a71b
dashboard link: https://syzkaller.appspot.com/bug?extid=d16facb00df3f446511c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11ee53d5980000


