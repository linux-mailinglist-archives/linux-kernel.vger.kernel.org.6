Return-Path: <linux-kernel+bounces-388076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC989B5A30
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 04:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61C4DB22B7A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 03:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B06D1953AD;
	Wed, 30 Oct 2024 03:07:35 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6849214E2E2
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 03:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730257654; cv=none; b=Zl+El5RQL04ImzTxW1C+JfUT8N+mVe4XyS6qbci8IRDyBggLsuCQ3XOXhyVaaRK41pNbJaki0/bkRR3kyEj8yqgrZcA/VFArQ+R6Jn9YiK/zDrLnIB3io+UDc/RNJ4nsNmQs013GZ60seK+pYsLGCXsbVV21+EshUWlXPjklL3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730257654; c=relaxed/simple;
	bh=LSEIK8xvBP86QTS9CqW2S2RhNziMW17rZko1AxEpAD0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=eYBEhHNSdZA0LpRfUnu5rXEidA5qEGkgqZmG1EnMsUK/Fpt0Q5xF8B4cTflvUcmUrtBfSoPuciRG+5le1DCtN+lbT1FbkOABo5eSVhNu7efimWD0xBK9wlIBoreN8m1dMcc09TylswXc+nDkhfJi4GQ9DLo6yzGeCHAktWgL1rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3fa97f09cso63429735ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 20:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730257650; x=1730862450;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wflp7UzWGx52ZyPQl2M3ufxPdBReyCR2SVIH2nComRs=;
        b=nXnMZX6HZNRW9xkXaF5Q4lT1udrnZhgTRYC7ioO1VWUxUP38ywdc6qkurQCTiEG7eE
         PQ5PqpP6Ns4EZRvRzmCpAqPd2aIEVi+ZsKNRx8FcwJ8PIDLZrtODG0lMGXf4ELJz3/aJ
         FXr7ZZvL3XQxVgmIhHr1dvKnjtAH8FXSD7jG+bdHagPqGtuPH6AmM6vvMr0cRQ62lDvQ
         Iz4XHgMpVSEYThajqzueOShUpFtjuIR229FEIA3N7fy2jXm14AfQcYo6EJpHAwP8XqPJ
         ex/AdVMzwN9rSFw68wgZmxNekcUS3XodzBRaBxgXia/pjvEVecO/gplCFzPcBbr8X6nk
         +SAg==
X-Forwarded-Encrypted: i=1; AJvYcCWLi2DXBuDsMEQlniApBoeRuXj2QO3oDgUUt3zXstziivUb5E6fydysN0SmacU4P4DUIR5P2D3vg6WTf04=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2NdMAqAZ7feosAvKoJzmU8WdaqAWxwYMCLBEyz3xGzbFnk+ZE
	qf4EiFqPyqE4nHa2l+i6dDt5vq2ySEJprXOWgvoBf761fh+bZPUC5eBmGfdUwjQp0EbPDoxTaTq
	jL6FGMM0dunUgLY1o6U+5BPyTfyDTxkEWWoIUZ5LRrMKo3JV5V7E2WqQ=
X-Google-Smtp-Source: AGHT+IHSh0cz+1GgZxzjmV99yE1mzrfqrd04UcDgl2yvmpn6RQrhk78mklqRnf7QkcBUVDJZcYztRQYxoENZ4sEwSqooxRbytc50
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a22:b0:3a0:bd91:3842 with SMTP id
 e9e14a558f8ab-3a4ed3628d7mr127440775ab.24.1730257650605; Tue, 29 Oct 2024
 20:07:30 -0700 (PDT)
Date: Tue, 29 Oct 2024 20:07:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6721a2f2.050a0220.4735a.0266.GAE@google.com>
Subject: [syzbot] [mm?] INFO: rcu detected stall in kthreadd (2)
From: syzbot <syzbot+bb0c3b50c40032b58091@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org, pasha.tatashin@soleen.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6d858708d465 Merge branch 'net-ethernet-freescale-use-pa-t..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=119e7287980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e7f0cac6eaefe81d
dashboard link: https://syzkaller.appspot.com/bug?extid=bb0c3b50c40032b58091
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13d44230580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15666f57980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/88c678a36ec8/disk-6d858708.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b19b4fbbd593/vmlinux-6d858708.xz
kernel image: https://storage.googleapis.com/syzbot-assets/18fef9c3fe20/bzImage-6d858708.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bb0c3b50c40032b58091@syzkaller.appspotmail.com

sched: DL replenish lagged too much
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P2/1:b..l
rcu: 	(detected by 0, t=10503 jiffies, g=7697, q=2518875 ncpus=2)
task:kthreadd        state:R  running task     stack:24560 pid:2     tgid:2     ppid:0      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6682
 preempt_schedule_irq+0xfb/0x1c0 kernel/sched/core.c:7004
 irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:check_kcov_mode kernel/kcov.c:194 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x37/0x70 kernel/kcov.c:217
Code: 00 d8 03 00 65 8b 15 a0 f0 6e 7e 81 e2 00 01 ff 00 74 11 81 fa 00 01 00 00 75 35 83 b9 1c 16 00 00 00 74 2c 8b 91 f8 15 00 00 <83> fa 02 75 21 48 8b 91 00 16 00 00 48 8b 32 48 8d 7e 01 8b 89 fc
RSP: 0018:ffffc900000775d0 EFLAGS: 00000246
RAX: ffffffff820b6c02 RBX: dffffc0000000000 RCX: ffff8881404a9e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000040
RBP: dffffc0000000000 R08: ffffffff820b6bd8 R09: 1ffffffff2859900
R10: dffffc0000000000 R11: fffffbfff2859901 R12: ffff88801e1605d0
R13: 1ffffffff34887b4 R14: 0000000000000000 R15: 0000000000000000
 __page_table_check_zero+0x102/0x350 mm/page_table_check.c:153
 page_table_check_free include/linux/page_table_check.h:41 [inline]
 free_pages_prepare mm/page_alloc.c:1109 [inline]
 free_unref_page+0xd0f/0xf20 mm/page_alloc.c:2638
 discard_slab mm/slub.c:2677 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:3145
 put_cpu_partial+0x17c/0x250 mm/slub.c:3220
 __slab_free+0x2ea/0x3d0 mm/slub.c:4449
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_kmalloc+0x23/0xb0 mm/kasan/common.c:385
 kasan_kmalloc include/linux/kasan.h:257 [inline]
 __do_kmalloc_node mm/slub.c:4264 [inline]
 __kmalloc_noprof+0x1fc/0x400 mm/slub.c:4276
 kmalloc_noprof include/linux/slab.h:882 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 lsm_blob_alloc security/security.c:685 [inline]
 lsm_cred_alloc security/security.c:702 [inline]
 security_prepare_creds+0x53/0x360 security/security.c:3240
 prepare_creds+0x467/0x640 kernel/cred.c:242
 copy_creds+0x109/0x9c0 kernel/cred.c:312
 copy_process+0x9df/0x3d50 kernel/fork.c:2237
 kernel_clone+0x226/0x8f0 kernel/fork.c:2784
 kernel_thread+0x1bc/0x240 kernel/fork.c:2846
 create_kthread kernel/kthread.c:412 [inline]
 kthreadd+0x60d/0x810 kernel/kthread.c:767
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: rcu_preempt kthread starved for 9045 jiffies! g7697 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:21840 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6682
 __schedule_loop kernel/sched/core.c:6759 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6774
 schedule_timeout+0x1be/0x310 kernel/time/timer.c:2615
 rcu_gp_fqs_loop+0x2df/0x1330 kernel/rcu/tree.c:2045
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:2247
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 24 Comm: ksoftirqd/1 Not tainted 6.12.0-rc2-syzkaller-00631-g6d858708d465 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:check_preemption_disabled+0x42/0x120 lib/smp_processor_id.c:55
Code: 08 65 8b 1d dc d2 3c 74 65 8b 05 d1 d2 3c 74 a9 ff ff ff 7f 74 26 65 48 8b 04 25 28 00 00 00 48 3b 44 24 08 0f 85 ce 00 00 00 <89> d8 48 83 c4 10 5b 41 5c 41 5e 41 5f c3 cc cc cc cc 48 c7 04 24
RSP: 0018:ffffc900001e69e8 EFLAGS: 00000246
RAX: bcc40fbadd619200 RBX: 0000000000000001 RCX: ffffffff817056d4
RDX: 0000000000000000 RSI: ffffffff8c60fb00 RDI: ffffffff8c60fac0
RBP: ffffc900001e6b88 R08: ffffffff901d11af R09: 1ffffffff203a235
R10: dffffc0000000000 R11: fffffbfff203a236 R12: 1ffff9200003cd50
R13: dffffc0000000000 R14: 0000000000000000 R15: ffffffff8a4c39a4
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3e012ad198 CR3: 000000000e734000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 rcu_is_watching_curr_cpu include/linux/context_tracking.h:128 [inline]
 rcu_is_watching+0x15/0xb0 kernel/rcu/tree.c:737
 trace_lock_acquire include/trace/events/lock.h:24 [inline]
 lock_acquire+0xe3/0x550 kernel/locking/lockdep.c:5796
 rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 rcu_read_lock include/linux/rcupdate.h:849 [inline]
 l3mdev_master_ifindex include/net/l3mdev.h:69 [inline]
 ip_route_me_harder+0x571/0x1360 net/ipv4/netfilter.c:49
 synproxy_send_tcp+0x356/0x6c0 net/netfilter/nf_synproxy_core.c:431
 synproxy_send_client_synack+0x8b8/0xf30 net/netfilter/nf_synproxy_core.c:484
 nft_synproxy_eval_v4+0x3ca/0x610 net/netfilter/nft_synproxy.c:59
 nft_synproxy_do_eval+0x362/0xa60 net/netfilter/nft_synproxy.c:141
 expr_call_ops_eval net/netfilter/nf_tables_core.c:240 [inline]
 nft_do_chain+0x4ad/0x1da0 net/netfilter/nf_tables_core.c:288
 nft_do_chain_inet+0x418/0x6b0 net/netfilter/nft_chain_filter.c:161
 nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
 nf_hook_slow+0xc3/0x220 net/netfilter/core.c:626
 nf_hook include/linux/netfilter.h:269 [inline]
 NF_HOOK+0x29e/0x450 include/linux/netfilter.h:312
 NF_HOOK+0x3a4/0x450 include/linux/netfilter.h:314
 __netif_receive_skb_one_core net/core/dev.c:5668 [inline]
 __netif_receive_skb+0x2bf/0x650 net/core/dev.c:5781
 process_backlog+0x662/0x15b0 net/core/dev.c:6113
 __napi_poll+0xcb/0x490 net/core/dev.c:6834
 napi_poll net/core/dev.c:6903 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:7025
 handle_softirqs+0x2c5/0x980 kernel/softirq.c:554
 run_ksoftirqd+0xca/0x130 kernel/softirq.c:927
 smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
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

