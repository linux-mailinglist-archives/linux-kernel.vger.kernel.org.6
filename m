Return-Path: <linux-kernel+bounces-373245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9599A5448
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 15:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ACAD1F21411
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 13:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2908219258A;
	Sun, 20 Oct 2024 13:18:09 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6F3B674
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 13:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729430288; cv=none; b=Be1zgOnt5QYt7bkFNDNta8WjR7DyU4Xce+NA1hPLS1aoFFTywAX5B+xV8/mLlysCRPVIkM1wFeo9yy5UuZAYS9XX3uhI5/EW3I28ndDzhFEQ/AGgi8OCSPagMTXYHjHWwsmSH2dfJYxcTLRRRVJELZLBu9aqET8Pu5DBByCWIoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729430288; c=relaxed/simple;
	bh=fvkm4v+i5TwzcbUGkymgXljGU/KYvOeEAJTWcro9n68=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NBWk3HJUoBw+/ievT+I212WwVlpYDU6XEy6DvNqulmbL9afuZskiO7bsAGiDAekN4gQnHAgF74EmbV7ruxjXjY1y6G3wz2CzEIBBVSU+dVTRpl1QsnCZlVnkHia6R4Q0NTAaAyzHCefJQYkysnIMEsZ2xpoqoxWpT3DQTc5ebtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3cc9fa12dso28534045ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 06:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729430286; x=1730035086;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RPxV8tGU+dvD/W4A3i9ljk9Xnt3TKIVF0Eadl4BjF/U=;
        b=XjLVCSbHe2zU+tQ+u+HSSQoWFssUURyUmellpsPUmu3bRjuVnVACia+A5yzQWLD+c6
         DaOuC8UzL5bVw8xjvzWpDxD3GhLR3nM1WIlU+iL6Uho4T6V7rvBqAQedMW1BGBLPFkMu
         enimakZ7OZqV8rBbD8wpaaz1WaI6zOPjGL55y+JaLOba8cZkFVdYGJ8NbOSXckrSolB1
         K1pFU7aWoH09DrcQevPLtSJrm9K+uXkEiBugFLDWpBjgaxOD3qkEtoXd2rtwNYnm/M8H
         icYOc1CuTa2GXGX80nhQ4UygRaRUXWQ0IJ+5HsXJ5XkOwmG3fmbbEcmjNxu4MLw7nhfK
         0iCw==
X-Gm-Message-State: AOJu0YwKD78EOzMQh2GWTVkNDsWssQuZ2KefZ/OMHAnkFMPQjOgN581l
	8AJ3zDALQ+eCkCvAP0OJg+C+5F3T7KG8oRO++D8azrq/y2ns8s+QmV3spKT9qMJMTdBDPpC2G2F
	mBofuify48hfjFNUwTEoIpYWe0/cH0gkqHyP5AJ6fZpoi82QRsb61OOY=
X-Google-Smtp-Source: AGHT+IFHWMrDRiiEso7OWbO8+x2A4v9omfGgMs2hZtKHO3sbEUSQUONrl+hr9ZnWYZyOLtyS6b2sjyqzY/YRN2QEm64kN+V/ReVF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3cc9:b0:3a2:aed1:1285 with SMTP id
 e9e14a558f8ab-3a3f3fc9a9bmr71557365ab.0.1729430285624; Sun, 20 Oct 2024
 06:18:05 -0700 (PDT)
Date: Sun, 20 Oct 2024 06:18:05 -0700
In-Reply-To: <Bx42aYpwIlfScXqal1denKS6tcNZtrc7xFTMYNGbIiw5OnuQL1UsjwMf5ZSxsmC9ech23ggVlKCNmAnCc9ewtxJ-WyJwX14aB4xx77pmAvU=@proton.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6715030d.050a0220.1e4b4d.0042.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in bch2_bucket_alloc_trans (2)
From: syzbot <syzbot+2b6a17991a6af64f9489@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, pz010001011111@proton.me, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in bch2_journal_reclaim_thread

INFO: task bch-reclaim/loo:6038 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc3-syzkaller-00420-g715ca9dd687f-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:bch-reclaim/loo state:D stack:28984 pid:6038  tgid:6038  ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x1843/0x4ae0 kernel/sched/core.c:6682
 __schedule_loop kernel/sched/core.c:6759 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6774
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6831
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 bch2_journal_reclaim_thread+0x167/0x560 fs/bcachefs/journal_reclaim.c:739
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e937e20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937e20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937e20 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6720
2 locks held by kworker/u8:5/999:
 #0: ffff8880b863ea58 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:593
 #1: ffffe8ffffc1c5c8 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x17c/0x7a0 kernel/sched/psi.c:937
2 locks held by kworker/u8:9/3035:
2 locks held by getty/4974:
 #0: ffff88802efa60a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
7 locks held by syz.0.15/6010:
1 lock held by bch-reclaim/loo/6038:
 #0: ffff8880657cb0a8 (&j->reclaim_lock){+.+.}-{3:3}, at: bch2_journal_reclaim_thread+0x167/0x560 fs/bcachefs/journal_reclaim.c:739

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.12.0-rc3-syzkaller-00420-g715ca9dd687f-dirty #0
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
CPU: 0 UID: 0 PID: 3035 Comm: kworker/u8:9 Not tainted 6.12.0-rc3-syzkaller-00420-g715ca9dd687f-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:filter_irq_stacks+0x4f/0xa0 kernel/stacktrace.c:397
Code: 90 e4 c7 8b 48 89 fb eb 0c 49 ff c7 48 83 c3 08 4d 39 fc 74 4f 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df 80 3c 08 00 <74> 08 48 89 df e8 97 d6 7a 00 4b 8b 04 fe 48 39 e8 72 0c 48 c7 c1
RSP: 0018:ffffc9000a16e9e8 EFLAGS: 00000246
RAX: 1ffff9200142dd60 RBX: ffffc9000a16eb00 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000011 RDI: ffffc9000a16ea80
RBP: ffffffff8be00230 R08: 000000000000001b R09: ffffc9000a16e9f0
R10: ffffc9000a16e950 R11: ffffffff8180a090 R12: 0000000000000011
R13: ffffffff8bc7e490 R14: ffffc9000a16ea80 R15: 0000000000000010
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055557255b808 CR3: 000000000e734000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 stack_depot_save_flags+0x29/0x830 lib/stackdepot.c:609
 kasan_save_stack+0x4f/0x60 mm/kasan/common.c:48
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
 kvfree_call_rcu+0xfc/0x790 kernel/rcu/tree.c:3810
 cfg80211_update_known_bss+0xb45/0x1590 net/wireless/scan.c:1891
 __cfg80211_bss_update+0x153/0x2030 net/wireless/scan.c:1938
 cfg80211_inform_single_bss_data+0xd82/0x2090 net/wireless/scan.c:2329
 cfg80211_inform_bss_data+0x3ce/0x5e70 net/wireless/scan.c:3184
 cfg80211_inform_bss_frame_data+0x3b8/0x720 net/wireless/scan.c:3279
 ieee80211_bss_info_update+0x8a7/0xbc0 net/mac80211/scan.c:226
 ieee80211_rx_bss_info net/mac80211/ibss.c:1100 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1579 [inline]
 ieee80211_ibss_rx_queued_mgmt+0x1962/0x2d70 net/mac80211/ibss.c:1606
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

commit:         715ca9dd Merge tag 'io_uring-6.12-20241019' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15b4425f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=78db40d8379956d9
dashboard link: https://syzkaller.appspot.com/bug?extid=2b6a17991a6af64f9489
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16b8425f980000


