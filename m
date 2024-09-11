Return-Path: <linux-kernel+bounces-325090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3A69754E4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E075B2796D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EE019CC2D;
	Wed, 11 Sep 2024 13:59:21 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51B719C564
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726063161; cv=none; b=nIJG2FoRyVQl6KkwL3ZkH8xHotNBbX382g83rs26kxojzjpO4MyyrrqHFWFgw+S/J+PnWi1K1H2BNzfly3gp/W4gdP2tBabUuEjjipVsw+WrJ+TMb+7IriCNvZfqEn8hmmth4b9lLthbIRkTMUEt4J12kGUytBAgz9Dff2Ktbe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726063161; c=relaxed/simple;
	bh=j/IOnyIDuox47ClSTUNzfwKZIVR3liYG+wB+hgxQfss=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=a26SLnEJh704A8nCi4WEE+qV0pCHvMnwppGRNzNBrNgwyVKYW9ZohZWJtAwPQ/TnQOII4KYIZqjexirp6MoTwL7sJV8s0pwT9ZcIvONlJOcxenLMfP84G9r8b4bBSy7Ww2z0QdLvBcODQQMADjqYGxPi5EGO3VOEE0Iho87jcCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a04c905651so94911405ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 06:59:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726063159; x=1726667959;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iyFSjWPsVOn4jot16e15VF13cbZtKB2RZwrXgLJVpIs=;
        b=QqkE56rnc1IzEAJPgLTd2n0Q7euZiSoJVOKdH5Ncp3b9NMyZMko4FTyL7XWQYDFvyF
         8kuR4NaXX2oW47QI9cTbHxxpuE7Oq23UgQtylxtvlCbZipAGtvpJHxNx0O3+M7Jp/iyD
         WMJmnK8JSHHG4NWll5SoSAxZ5UcYY49iaA2wC6e6NbAfSIw6OkBRND9Bt1GjieuSWPrn
         6skYpOgsTsZwvuZPZ0lXyGud6/2PxvBrU7XU0H1wCRJSfSzQS/Uof/u8+IMGB50hsvQv
         znZVozFxK9djzKOpPlnsSLDs3IqvDWNzQt3l0604lOoIEhwNpVnFR7twI3R5GcFdvl47
         f1cw==
X-Forwarded-Encrypted: i=1; AJvYcCUC2wB5OFxo7aTu/rLj09fVb8REb+Y8GKW2iMcyNk1MtZ/6PCcT8AiMyi4k0uKmRYg09Couv9eAPdwu4yA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJPf/vzxW/lVEpss03yAJ9F5lg1ECWPC7GBsgEpi85zvzQQQaV
	rTpHJ/+HoPHiD24IzITZCsF4JpUnA/e77R1akQGcmCNrDX0BiPRLFSBOGrI9O4J31kunuQPzSWr
	J4KO345AktgjpdkdZqd+4+N9BexJPwNzFCJQLOqabxyvkSiZZggiuQ4w=
X-Google-Smtp-Source: AGHT+IHCax3tASed1rU34Ah0qudPhtB1RGSc/HnK4mmJeBkYaGKzhZbvAr1AsvbFj/vUqH+9+0fmI1tVQH2fBKH4vnx7i7z5uKRB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b27:b0:3a0:4c75:3aed with SMTP id
 e9e14a558f8ab-3a04f0ee4c4mr216510885ab.25.1726063158765; Wed, 11 Sep 2024
 06:59:18 -0700 (PDT)
Date: Wed, 11 Sep 2024 06:59:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007038c00621d865b7@google.com>
Subject: [syzbot] [usb?] INFO: task hung in adu_release
From: syzbot <syzbot+b67c1b86d4e644a5cb6d@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9c0c11bb87b0 xhci: support setting interrupt moderation IM..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=13a0189f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4a1ccb5ad00c3ba6
dashboard link: https://syzkaller.appspot.com/bug?extid=b67c1b86d4e644a5cb6d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ae6ffb980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d41cb6c3e427/disk-9c0c11bb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1beec7548c8b/vmlinux-9c0c11bb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/66b2bb190ac1/bzImage-9c0c11bb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b67c1b86d4e644a5cb6d@syzkaller.appspotmail.com

INFO: task syz.0.63:3967 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc6-syzkaller-g9c0c11bb87b0 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.63        state:D stack:27872 pid:3967  tgid:3961  ppid:3214   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xcda/0x2f80 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 usb_kill_urb.part.0+0x1ca/0x250 drivers/usb/core/urb.c:713
 usb_kill_urb+0x83/0xa0 drivers/usb/core/urb.c:702
 adu_abort_transfers drivers/usb/misc/adutux.c:129 [inline]
 adu_release_internal drivers/usb/misc/adutux.c:302 [inline]
 adu_release+0x545/0x720 drivers/usb/misc/adutux.c:331
 __fput+0x408/0xbb0 fs/file_table.c:422
 task_work_run+0x14e/0x250 kernel/task_work.c:228
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xaa3/0x2b30 kernel/exit.c:882
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1031
 get_signal+0x25fb/0x2770 kernel/signal.c:2917
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x147/0x260 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6e0ed1cef9
RSP: 002b:00007f6e0e71b0e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007f6e0eed62e8 RCX: 00007f6e0ed1cef9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f6e0eed62e8
RBP: 00007f6e0eed62e0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6e0eed62ec
R13: 0000000000000000 R14: 00007ffcc5944490 R15: 00007ffcc5944578
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff88ebb660 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #0: ffffffff88ebb660 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #0: ffffffff88ebb660 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6626
2 locks held by getty/2606:
 #0: ffff888108adf0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900000432f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc8/0x1490 drivers/tty/n_tty.c:2211
1 lock held by syz.0.63/3967:
 #0: ffffffff89ad3688 (adutux_mutex){+.+.}-{3:3}, at: adu_release+0xcf/0x720 drivers/usb/misc/adutux.c:323
2 locks held by syz.0.110/4656:
 #0: ffffffff899affb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x27/0x2f0 drivers/usb/core/file.c:38
 #1: ffffffff89ad3688 (adutux_mutex){+.+.}-{3:3}, at: adu_open+0x5d/0x820 drivers/usb/misc/adutux.c:236
2 locks held by syz.0.110/4657:
 #0: ffffffff899affb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x27/0x2f0 drivers/usb/core/file.c:38
 #1: ffffffff89ad3688 (adutux_mutex){+.+.}-{3:3}, at: adu_open+0x5d/0x820 drivers/usb/misc/adutux.c:236
2 locks held by syz.0.110/4658:
 #0: ffffffff899affb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x27/0x2f0 drivers/usb/core/file.c:38
 #1: ffffffff89ad3688 (adutux_mutex){+.+.}-{3:3}, at: adu_open+0x5d/0x820 drivers/usb/misc/adutux.c:236

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.11.0-rc6-syzkaller-g9c0c11bb87b0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 nmi_cpu_backtrace+0x27b/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xf0c/0x1240 kernel/hung_task.c:379
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
NMI backtrace for cpu 0 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:106 [inline]
NMI backtrace for cpu 0 skipped: idling at acpi_safe_halt+0x1a/0x20 drivers/acpi/processor_idle.c:111


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

