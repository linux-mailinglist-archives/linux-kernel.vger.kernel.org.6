Return-Path: <linux-kernel+bounces-416646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B239D4835
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 08:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E1941F21FBE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 07:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A83155742;
	Thu, 21 Nov 2024 07:32:29 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2118A4206E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 07:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732174348; cv=none; b=cuma4UAN1RGbhihnWIFCgqzEGvrbWV3uDenlQSecMez5cEPD6nblwCAUASRvk7pU08wGIYlO6Kt205quqjVh1iF0dYSbvEOFVYbBoWUBCAYeyJh9wOxPYUuMp+605WDHLvnEfGUDH8BhrK9A/JzyIrfkxMGT/ozQFew37XTAzT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732174348; c=relaxed/simple;
	bh=CdQfI8FsszAmoYU5jnMgHCyHpThc/yrkBnDjDuM2W1g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HN2599n5lAVbi9jbDj3n9aExyCsPXhPBSBB6qbQABmCrPBx3fkgYoSeJgOI2tYfn/hrtYG+AYjDyPcQbZn4eAddpjKaRN9BvdUmWWRgY4USZ+aN0jafpyjVE8OeRv/pjGyv5s6B0Yf0UhYtnzPVR+Bqi/z5IwFiiDZ/EQXP6kI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a778ce76fbso6273315ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 23:32:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732174345; x=1732779145;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MqeeNY+vC3+zzBx/1f2Z6XhtBJkuH9JfZYXT3OxzA/U=;
        b=ZoIRxwFsBw7J2M8gdwmLoOGltpjknYKJB0Tl0Vv5Wp3Rk2Gkne24OIq90iQrkaoihJ
         r3YP5HD19EmEbSvCaYC7aOLUzJRW6tnNlgGKAcPHsK3iOmLlwsikhoq3RKRIaO6iuQFJ
         +7Lep9dvpM8ktkEDZ+Qs2xN4jinl/uWDzRwtCZByH2xv2eEiowURozIp8/BVhNK4yXKb
         XafAWMyt8Vahmwe9+RYQrY/w0jvJFiBJ6Bm2EbghCJX3TahxlvVXIUCkx4pA2YsKHF5M
         DF3Mer4hnIODityk+nOt4XtrLuWjlYBVcNxp5c/5hYCeG+ZkxxczL7xewlDL3ScQqbbU
         Ipug==
X-Forwarded-Encrypted: i=1; AJvYcCVu/Fdn11gzev/6vYCwl+9wi3uYtk7xWvtruzLKz37q2zJkpLqAn12a1zhQ1S7OlOfLRW4unbHo1obbaKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTrS/3LRrpeZk8Wkj6srLAiJueP4qEYB+iR7Sva58kaJigqh6b
	h/QGzKF6/YJ9emo58AxK/34OFKAqT2tkawnd0Nub/hBCilIJM1Injb432GvSuYyOz3iWLzt4DJE
	3nuf96RjUTGAEkS+MMu2wzSmu8JWLRqm6/n19khEMAhFEShNaJ49L9wA=
X-Google-Smtp-Source: AGHT+IFNYeDZXgrbmaW572nBxVzVTHoHs5dCMWYMg2UCzkcwRMPyNf3pGA66Q4wbLpHgFbjlI2L5HQ8KmCvgCXWeU5ulAGgmCqv7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144b:b0:3a7:70a4:6872 with SMTP id
 e9e14a558f8ab-3a786438182mr74217265ab.9.1732174345270; Wed, 20 Nov 2024
 23:32:25 -0800 (PST)
Date: Wed, 20 Nov 2024 23:32:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673ee209.050a0220.363a1b.00d6.GAE@google.com>
Subject: [syzbot] [mm?] possible deadlock in try_to_wake_up (7)
From: syzbot <syzbot+e5ebce0ffa64d4f9e0cb@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4a5df3796467 Merge tag 'mm-hotfixes-stable-2024-11-16-15-3..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=155c32c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9b216897c3460507
dashboard link: https://syzkaller.appspot.com/bug?extid=e5ebce0ffa64d4f9e0cb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9d63a0b7130f/disk-4a5df379.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b5fa43c492f5/vmlinux-4a5df379.xz
kernel image: https://storage.googleapis.com/syzbot-assets/553263ff3107/bzImage-4a5df379.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e5ebce0ffa64d4f9e0cb@syzkaller.appspotmail.com

kauditd_printk_skb: 9 callbacks suppressed
audit: type=1800 audit(1731828236.598:84): pid=8906 uid=0 auid=4294967295 ses=4294967295 subj=_ op=collect_data cause=failed(directio) comm="syz.1.810" name="bus" dev="overlay" ino=1020 res=0 errno=0
audit: type=1800 audit(1731828236.698:85): pid=8913 uid=0 auid=4294967295 ses=4294967295 subj=_ op=collect_data cause=failed(directio) comm="syz.1.810" name="bus" dev="overlay" ino=1020 res=0 errno=0
======================================================
WARNING: possible circular locking dependency detected
6.12.0-rc7-syzkaller-00212-g4a5df3796467 #0 Not tainted
------------------------------------------------------
kauditd/29 is trying to acquire lock:
ffff88805b364618 (&p->pi_lock){-.-.}-{2:2}, at: class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:551 [inline]
ffff88805b364618 (&p->pi_lock){-.-.}-{2:2}, at: try_to_wake_up+0xbe/0x14b0 kernel/sched/core.c:4165

but task is already holding lock:
ffffffff8e813418 ((console_sem).lock){-.-.}-{2:2}, at: up+0x1d/0x90 kernel/locking/semaphore.c:187

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 ((console_sem).lock){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       down_trylock+0x20/0xa0 kernel/locking/semaphore.c:139
       __down_trylock_console_sem+0x109/0x250 kernel/printk/printk.c:326
       console_trylock kernel/printk/printk.c:2827 [inline]
       console_trylock_spinning kernel/printk/printk.c:1990 [inline]
       vprintk_emit+0x3d7/0xa10 kernel/printk/printk.c:2406
       _printk+0xd5/0x120 kernel/printk/printk.c:2432
       fail_dump lib/fault-inject.c:46 [inline]
       should_fail_ex+0x391/0x4e0 lib/fault-inject.c:154
       strncpy_from_user+0x36/0x260 lib/strncpy_from_user.c:118
       strncpy_from_user_nofault+0x71/0x140 mm/maccess.c:186
       bpf_probe_read_user_str_common kernel/trace/bpf_trace.c:215 [inline]
       ____bpf_probe_read_compat_str kernel/trace/bpf_trace.c:310 [inline]
       bpf_probe_read_compat_str+0xe9/0x180 kernel/trace/bpf_trace.c:306
       0xffffffffa0000859
       bpf_dispatcher_nop_func include/linux/bpf.h:1265 [inline]
       __bpf_prog_run include/linux/filter.h:701 [inline]
       bpf_prog_run include/linux/filter.h:708 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2316 [inline]
       bpf_trace_run2+0x2ec/0x540 kernel/trace/bpf_trace.c:2357
       trace_tlb_flush+0x118/0x140 include/trace/events/tlb.h:38
       switch_mm_irqs_off+0x77a/0xa70
       context_switch kernel/sched/core.c:5312 [inline]
       __schedule+0x10c7/0x4bd0 kernel/sched/core.c:6693
       preempt_schedule_notrace+0x100/0x140 kernel/sched/core.c:6965
       preempt_schedule_notrace_thunk+0x1a/0x30 arch/x86/entry/thunk.S:13
       rcu_is_watching+0x7e/0xb0 kernel/rcu/tree.c:738
       trace_lock_acquire include/trace/events/lock.h:24 [inline]
       lock_acquire+0xe3/0x550 kernel/locking/lockdep.c:5796
       rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
       rcu_read_lock include/linux/rcupdate.h:849 [inline]
       atomic_notifier_call_chain+0x43/0x180 kernel/notifier.c:230
       do_con_write+0xab1/0x4c30 drivers/tty/vt/vt.c:3086
       con_put_char+0x95/0xf0 drivers/tty/vt/vt.c:3442
       tty_put_char+0xe3/0x190 drivers/tty/tty_io.c:3167
       do_output_char+0x6b1/0x970 drivers/tty/n_tty.c:469
       process_output drivers/tty/n_tty.c:494 [inline]
       n_tty_write+0xe06/0x1230 drivers/tty/n_tty.c:2400
       iterate_tty_write drivers/tty/tty_io.c:1015 [inline]
       file_tty_write+0x546/0x9b0 drivers/tty/tty_io.c:1090
       new_sync_write fs/read_write.c:590 [inline]
       vfs_write+0xaeb/0xd30 fs/read_write.c:683
       ksys_write+0x183/0x2b0 fs/read_write.c:736
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&rq->__lock){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
       raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:598
       raw_spin_rq_lock kernel/sched/sched.h:1506 [inline]
       task_rq_lock+0xc6/0x360 kernel/sched/core.c:700
       cgroup_move_task+0x9b/0x5a0 kernel/sched/psi.c:1161
       css_set_move_task+0x72e/0x950 kernel/cgroup/cgroup.c:898
       cgroup_post_fork+0x256/0x880 kernel/cgroup/cgroup.c:6692
       copy_process+0x39e9/0x3d50 kernel/fork.c:2600
       kernel_clone+0x223/0x880 kernel/fork.c:2786
       user_mode_thread+0x132/0x1a0 kernel/fork.c:2864
       rest_init+0x23/0x300 init/main.c:712
       start_kernel+0x47f/0x500 init/main.c:1105
       x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:507
       x86_64_start_kernel+0x9f/0xa0 arch/x86/kernel/head64.c:488
       common_startup_64+0x13e/0x147

-> #0 (&p->pi_lock){-.-.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:551 [inline]
       try_to_wake_up+0xbe/0x14b0 kernel/sched/core.c:4165
       up+0x72/0x90 kernel/locking/semaphore.c:191
       __up_console_sem kernel/printk/printk.c:343 [inline]
       __console_unlock+0x123/0x1f0 kernel/printk/printk.c:2844
       __console_flush_and_unlock kernel/printk/printk.c:3241 [inline]
       console_unlock+0x18f/0x3b0 kernel/printk/printk.c:3279
       vprintk_emit+0x730/0xa10 kernel/printk/printk.c:2407
       _printk+0xd5/0x120 kernel/printk/printk.c:2432
       kauditd_printk_skb kernel/audit.c:546 [inline]
       kauditd_hold_skb+0x1be/0x210 kernel/audit.c:581
       kauditd_send_queue+0x2b1/0x310 kernel/audit.c:766
       kauditd_thread+0x74a/0x9b0 kernel/audit.c:890
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

Chain exists of:
  &p->pi_lock --> &rq->__lock --> (console_sem).lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock((console_sem).lock);
                               lock(&rq->__lock);
                               lock((console_sem).lock);
  lock(&p->pi_lock);

 *** DEADLOCK ***

1 lock held by kauditd/29:
 #0: ffffffff8e813418 ((console_sem).lock){-.-.}-{2:2}, at: up+0x1d/0x90 kernel/locking/semaphore.c:187

stack backtrace:
CPU: 1 UID: 0 PID: 29 Comm: kauditd Not tainted 6.12.0-rc7-syzkaller-00212-g4a5df3796467 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
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
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:551 [inline]
 try_to_wake_up+0xbe/0x14b0 kernel/sched/core.c:4165
 up+0x72/0x90 kernel/locking/semaphore.c:191
 __up_console_sem kernel/printk/printk.c:343 [inline]
 __console_unlock+0x123/0x1f0 kernel/printk/printk.c:2844
 __console_flush_and_unlock kernel/printk/printk.c:3241 [inline]
 console_unlock+0x18f/0x3b0 kernel/printk/printk.c:3279
 vprintk_emit+0x730/0xa10 kernel/printk/printk.c:2407
 _printk+0xd5/0x120 kernel/printk/printk.c:2432
 kauditd_printk_skb kernel/audit.c:546 [inline]
 kauditd_hold_skb+0x1be/0x210 kernel/audit.c:581
 kauditd_send_queue+0x2b1/0x310 kernel/audit.c:766
 kauditd_thread+0x74a/0x9b0 kernel/audit.c:890
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
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

