Return-Path: <linux-kernel+bounces-375242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDB59A9399
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 00:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A08681F22EE5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 22:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879E21FEFC0;
	Mon, 21 Oct 2024 22:58:09 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498FF1FBC99
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 22:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729551489; cv=none; b=S8wn3RhgWkxmu6GDouma48mKrNYbvKDsj6pZqv1a3ILF0769kEfBE2zkOmYonAxMezA7hFH9S/nmGLFlxZM8L6HhulHQStjIj+2qgLWAuC4GgykccVNi4WDatD62Je4HCYnnCT9wQvpxShLxW9OWjvTiXHGX+6VPSFCVAqO1ATY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729551489; c=relaxed/simple;
	bh=KmJZ2uc/h5rFIhwrvNBaEe1DWMXEkxAIfNS/rx1hMM8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZZeRsp5A9911xpw+J6v/SnuCFK0S2VLzeK2vPZYwwZVaCsKYijqanYIyD0H3W7CutbiBODztEUOgWjt6NAZMwnYVsP66ibxIm3oNMJJ75dJYxYmTMridBXb9UPyRrFg3Mw8nTlaGA6kMigeF/WoyZJFkgktzTLMOQd2Mt4rQcc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3b506c87cso51226885ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 15:58:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729551486; x=1730156286;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DHWAYU+4DBFNETSllk8MpHnFTxS9ZhvVpieq8R6SZ04=;
        b=wn0Dk0Nqq/QxhbI4ys9MviasSwtmBY2ACZ3FItMBQZz8MUF9pKPABXHEdhj0I3HM4U
         m98A2lW+nmDeUx1u3UZ+Z0z5Ci7gOYxzpIVrEBS3dC3tv/yxFdDCE/j1ItbR3XVIQP4U
         /fUaD9KR4an/JrkAt4Np0UnLQr0W78/6WYTldSGfbA30DqFNkBsSvGHTh3YI7csIuPdg
         k15gD0GQkiGvL5MChuGtFzBD5NdDBQopZKPCPfAJN793a2yNMxSfQQf2ljRGpT/fIjT8
         5oON865qSstUlekSk+u5f0JNufuhvJxNqhiwcoPq0i/TeocCaOCKVZKQvuEZaZtVsJ9U
         Palw==
X-Gm-Message-State: AOJu0YzdwaOx+kloZ9wwyYRqzvUVKpeY/Uyq9jra2zFe2uRbsF91UNV2
	MMVPFBKTYYRy/m+7gXNTfJLdAt/SPIuEKUWhRHwO0SHNEX5fACLfxlQGPJx12MC8GP99HSKKFM4
	5k3QIupCEv4tmMG8L9F2Gb3+WuBbcR2WqbGyP2Jl/AbxOYMYhilRb1ZA=
X-Google-Smtp-Source: AGHT+IHd1KM2NjTkSlWVwHEf0yQV0/ei+o0z92628rzMU5d+/4ogWQh/uzlu5UE3O7NKnEEnzCmjfyfxeU/VIGsscqOZONnWMbCk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fce:b0:3a2:5b:7065 with SMTP id
 e9e14a558f8ab-3a3f40a84b5mr117291215ab.18.1729551486394; Mon, 21 Oct 2024
 15:58:06 -0700 (PDT)
Date: Mon, 21 Oct 2024 15:58:06 -0700
In-Reply-To: <jNIH4ZA2ZGLmxdvNUp8naJb-lzH74Aze5x_HM6TUCMmwSPCokgQ5xK_7aZWjjf4lrUoNdESGBJofAY3IP8lbKT8XLrik07VmeLexhQh_Wsw=@proton.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6716dc7e.050a0220.10f4f4.00c3.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in bch2_journal_key_insert_take
From: syzbot <syzbot+47f334396d741f9cb1ce@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, pz010001011111@proton.me, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in bch2_copygc_stop

INFO: task syz-executor:5854 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc3-next-20241021-syzkaller-g63b3ff03d91a-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:21216 pid:5854  tgid:5854  ppid:1      flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x18af/0x4bd0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6782
 schedule_timeout+0xb0/0x290 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common kernel/sched/completion.c:116 [inline]
 wait_for_common kernel/sched/completion.c:127 [inline]
 wait_for_completion+0x355/0x620 kernel/sched/completion.c:148
 kthread_stop+0x19e/0x640 kernel/kthread.c:712
 bch2_copygc_stop+0x57/0x140 fs/bcachefs/movinggc.c:411
 __bch2_fs_read_only+0x47/0x430 fs/bcachefs/super.c:265
 bch2_fs_read_only+0xbb9/0x1270 fs/bcachefs/super.c:355
 __bch2_fs_stop+0x105/0x5c0 fs/bcachefs/super.c:620
 generic_shutdown_super+0x139/0x2d0 fs/super.c:642
 bch2_kill_sb+0x41/0x50 fs/bcachefs/fs.c:2278
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5c4a37f327
RSP: 002b:00007fff1d156ed8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f5c4a37f327
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007fff1d156f90
RBP: 00007fff1d156f90 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007fff1d158010
R13: 00007f5c4a3f0134 R14: 0000000000018b83 R15: 00007fff1d158050
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e939fa0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e939fa0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e939fa0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6720
2 locks held by getty/4988:
 #0: ffff88814befb0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900031232f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
2 locks held by syz-executor/5854:
 #0: ffff8880212ae0e0 (&type->s_umount_key#51){+.+.}-{3:3}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff8880212ae0e0 (&type->s_umount_key#51){+.+.}-{3:3}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff8880212ae0e0 (&type->s_umount_key#51){+.+.}-{3:3}, at: deactivate_super+0xb5/0xf0 fs/super.c:505
 #1: ffff888064900278 (&c->state_lock){+.+.}-{3:3}, at: __bch2_fs_stop+0xfd/0x5c0 fs/bcachefs/super.c:619

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.12.0-rc3-next-20241021-syzkaller-g63b3ff03d91a-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xff4/0x1040 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 2471 Comm: kworker/u8:7 Not tainted 6.12.0-rc3-next-20241021-syzkaller-g63b3ff03d91a-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:orc_ip arch/x86/kernel/unwind_orc.c:80 [inline]
RIP: 0010:__orc_find arch/x86/kernel/unwind_orc.c:102 [inline]
RIP: 0010:orc_find arch/x86/kernel/unwind_orc.c:227 [inline]
RIP: 0010:unwind_next_frame+0x6d5/0x22d0 arch/x86/kernel/unwind_orc.c:494
Code: 89 c1 48 c1 f9 02 48 c1 e8 3f 48 01 c8 48 83 e0 fe 49 8d 1c 46 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df 0f b6 04 08 <84> c0 75 27 48 63 03 48 01 d8 48 8d 4b 04 4c 39 f8 4c 0f 46 f1 48
RSP: 0018:ffffc900097e7090 EFLAGS: 00000a06
RAX: 0000000000000000 RBX: ffffffff9092dbe8 RCX: dffffc0000000000
RDX: 00000000000b0001 RSI: ffffffff913b0774 RDI: ffffffff81416920
RBP: ffffffff9092dbe8 R08: 0000000000000001 R09: ffffc900097e7250
R10: ffffc900097e71b0 R11: ffffffff8180a260 R12: ffffffff9092dbe8
R13: ffffffff9092dbe8 R14: ffffffff9092dbe8 R15: ffffffff8b2eca34
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f36f83ff000 CR3: 000000000e736000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 arch_stack_walk+0x11c/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4283 [inline]
 __kmalloc_noprof+0x285/0x4c0 mm/slub.c:4295
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 ieee802_11_parse_elems_full+0xdb/0x2880 net/mac80211/parse.c:958
 ieee802_11_parse_elems_crc net/mac80211/ieee80211_i.h:2384 [inline]
 ieee802_11_parse_elems net/mac80211/ieee80211_i.h:2391 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1575 [inline]
 ieee80211_ibss_rx_queued_mgmt+0x4c8/0x2d70 net/mac80211/ibss.c:1606
 ieee80211_iface_process_skb net/mac80211/iface.c:1603 [inline]
 ieee80211_iface_work+0x8a5/0xf20 net/mac80211/iface.c:1657
 cfg80211_wiphy_work+0x2db/0x490 net/wireless/core.c:440
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


Tested on:

commit:         63b3ff03 Add linux-next specific files for 20241021
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12215c87980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2da11284432f402
dashboard link: https://syzkaller.appspot.com/bug?extid=47f334396d741f9cb1ce
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14ae5c87980000


