Return-Path: <linux-kernel+bounces-231770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 193E5919DBD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 05:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C477E284EE9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 03:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7C4175AE;
	Thu, 27 Jun 2024 03:14:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931CE171B6
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 03:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719458045; cv=none; b=Kb7xfzzYdG1UySRJVSFJNcJ5JZJedBlRPXWQaOPTeGd18g6DV0KFYJEqeHIDlC7E1VT3PWsQY10/BwUDBL4S5cere7kWZE1cnXfe1yaCc5rWCqvJzPVE/VoQs2TVMfrldFY0If5Paytdr1a65qkwj7+h5TVzYPawDIfbl8W8eIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719458045; c=relaxed/simple;
	bh=4hmhL1fpUj+8NbMUexsHKBPR+W/JUHyUEkCqH2SkWn0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pVcr8Oq5JfWgZPugsCQnr4VHgUmf4D8K9bN0TteSmofqz8MujjrmL99Kt8rdveBs0dAv7VE+j3aMujEsTfh62/D/7Zr5VEEaSvC5WprW6NTNVJx2FvxSeKTq1mrCmiWGHJp7Ogw4Gi7VM9IRRQ7DazIq/udmnz6xaLjY0z3Ddpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7eb84511dbfso957443639f.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 20:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719458043; x=1720062843;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4m19GCgD63tPp3ZQjvDQshqnuirJm8OxbkCDh8bRuMM=;
        b=F1ZGv9Mgi/PhAzPB7hLAJV6mpEMUoonojpA9P5VicuA6Ku0GER3kUNisBpJr1xThrZ
         mCyt/CFHPoTsMTmCOXQdkixh56Kj1ChihoJAiFCZaokmjLdyA61bUw1S4zPkH205qW5q
         GdoXs3TclG+1rBUwKC77Ig4KgoEhIhByrVtxlC0w+GTCPHfXdlV4/kxAZUZ9d4h56c/z
         7yPGspLbRJRk4WwIbP8WUjzLhEeSxQncdDgbbAlPjy8YXA9vDFwcprnU1jJp4ZMDadq2
         kQV6iJTma+42JYL1YYgYbsEVKfI9afeeUE4+m1D+PLitwp3V3Z/hfbwosu27rmCZz+9g
         GR4w==
X-Gm-Message-State: AOJu0YywJTc37MLCMeWLz1lLeeovtkQzN6wYS7cbkQaHgEcUrOvt4G1g
	YmxDAR3I+J/fIjUK0GulzVnhJv5JxN+lFjiKDdKJaynEsfVHZfbTFsep6hFTtaOkfnKtdT78WMX
	nsL4drahqZvsi4G/htSZjXngAAndZ+/sAZEskljpvlkzjoutJDFVNJOQ=
X-Google-Smtp-Source: AGHT+IFEKPxH4CXQPajyJgvRGBnB2Uq8u7SKrJimWpBPZYob4VZKgp5fxurkPxsLHqmIZbyhSjyDhcWSyn9W1OC+Kf+AkflgrsY0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1688:b0:4b9:32f8:574f with SMTP id
 8926c6da1cb9f-4b9ed085e63mr787893173.5.1719458042789; Wed, 26 Jun 2024
 20:14:02 -0700 (PDT)
Date: Wed, 26 Jun 2024 20:14:02 -0700
In-Reply-To: <20240627025257.1496287-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d8d365061bd685a9@google.com>
Subject: Re: [syzbot] [jfs?] INFO: task hung in txBegin
From: syzbot <syzbot+eda89a33c5856f66f823@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in wb_writeback

INFO: task kworker/u8:6:1105 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc4-syzkaller-00148-g50736169ecc8-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:6    state:D stack:22288 pid:1105  tgid:1105  ppid:2      flags:0x00004000
Workqueue: writeback wb_workfn (flush-7:0)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x1796/0x49d0 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 rwsem_down_write_slowpath+0xeeb/0x13b0 kernel/locking/rwsem.c:1178
 __down_write_common+0x1af/0x200 kernel/locking/rwsem.c:1306
 wb_writeback+0x143/0xda0 fs/fs-writeback.c:2083
 wb_do_writeback fs/fs-writeback.c:2279 [inline]
 wb_workfn+0x410/0x1090 fs/fs-writeback.c:2319
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task syz-executor:5687 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc4-syzkaller-00148-g50736169ecc8-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:20288 pid:5687  tgid:5687  ppid:1      flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x1796/0x49d0 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 wb_wait_for_completion+0x166/0x290 fs/fs-writeback.c:216
 __writeback_inodes_sb_nr+0x2d2/0x380 fs/fs-writeback.c:2711
 sync_filesystem+0xa4/0x230 fs/sync.c:54
 generic_shutdown_super+0x72/0x2d0 fs/super.c:621
 kill_block_super+0x44/0x90 fs/super.c:1676
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1267
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6f9d87e257
RSP: 002b:00007fff1d6cb318 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f6f9d87e257
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007fff1d6cb3d0
RBP: 00007fff1d6cb3d0 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007fff1d6cc480
R13: 00007f6f9d8d96c6 R14: 000000000001846f R15: 0000000000000001
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #0: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6614
3 locks held by kworker/u8:6/1105:
 #0: ffff88801aef9148 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff88801aef9148 ((wq_completion)writeback){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90004117d00 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90004117d00 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffff88801cf800e0 (&type->s_umount_key#52){+.+.}-{3:3}, at: wb_writeback+0x143/0xda0 fs/fs-writeback.c:2083
2 locks held by getty/4837:
 #0: ffff88802b0160a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b5/0x1e10 drivers/tty/n_tty.c:2211
1 lock held by syz-executor/5687:
 #0: ffff88801cf800e0 (&type->s_umount_key#52){+.+.}-{3:3}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff88801cf800e0 (&type->s_umount_key#52){+.+.}-{3:3}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff88801cf800e0 (&type->s_umount_key#52){+.+.}-{3:3}, at: deactivate_super+0xb5/0xf0 fs/super.c:505

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 30 Comm: khungtaskd Not tainted 6.10.0-rc4-syzkaller-00148-g50736169ecc8-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xfde/0x1020 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 3962 Comm: kworker/u8:10 Not tainted 6.10.0-rc4-syzkaller-00148-g50736169ecc8-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:preempt_count arch/x86/include/asm/preempt.h:26 [inline]
RIP: 0010:check_kcov_mode kernel/kcov.c:173 [inline]
RIP: 0010:write_comp_data kernel/kcov.c:236 [inline]
RIP: 0010:__sanitizer_cov_trace_switch+0x9d/0x120 kernel/kcov.c:341
Code: 00 00 4d 85 d2 0f 84 8b 00 00 00 4c 8b 4c 24 20 65 4c 8b 1c 25 80 d4 03 00 31 d2 eb 08 48 ff c2 49 39 d2 74 71 4c 8b 74 d6 10 <65> 8b 05 c4 a9 6d 7e a9 00 01 ff 00 74 11 a9 00 01 00 00 74 de 41
RSP: 0018:ffffc9000c266798 EFLAGS: 00000212
RAX: 0000000000000000 RBX: 0000000000000016 RCX: ffff88802e735a00
RDX: 000000000000001b RSI: ffffffff8f8548d0 RDI: 0000000000000003
RBP: ffffc9000c266bb0 R08: 0000000000000001 R09: ffffffff8afbe03a
R10: 0000000000000028 R11: ffff88802e735a00 R12: ffff888021f2e02f
R13: dffffc0000000000 R14: 000000000000007f R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000556005801600 CR3: 000000000e132000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 _ieee802_11_parse_elems_full+0x6da/0x49f0 net/mac80211/parse.c:215
 ieee802_11_parse_elems_full+0xde7/0x2870 net/mac80211/parse.c:902
 ieee802_11_parse_elems_crc net/mac80211/ieee80211_i.h:2332 [inline]
 ieee802_11_parse_elems net/mac80211/ieee80211_i.h:2339 [inline]
 ieee80211_inform_bss+0x15f/0x1080 net/mac80211/scan.c:79
 rdev_inform_bss net/wireless/rdev-ops.h:418 [inline]
 cfg80211_inform_single_bss_data+0x1121/0x2360 net/wireless/scan.c:2293
 cfg80211_inform_bss_data+0x3dd/0x5a70 net/wireless/scan.c:3117
 cfg80211_inform_bss_frame_data+0x3bc/0x720 net/wireless/scan.c:3207
 ieee80211_bss_info_update+0x8a7/0xbc0 net/mac80211/scan.c:226
 ieee80211_rx_bss_info net/mac80211/ibss.c:1099 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1578 [inline]
 ieee80211_ibss_rx_queued_mgmt+0x1962/0x2d70 net/mac80211/ibss.c:1605
 ieee80211_iface_process_skb net/mac80211/iface.c:1603 [inline]
 ieee80211_iface_work+0x8a3/0xf10 net/mac80211/iface.c:1657
 cfg80211_wiphy_work+0x221/0x260 net/wireless/core.c:437
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


Tested on:

commit:         50736169 Merge tag 'for-6.10-rc4-tag' of git://git.ker..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11f12b3e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12f98862a3c0c799
dashboard link: https://syzkaller.appspot.com/bug?extid=eda89a33c5856f66f823
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=148dfb01980000


