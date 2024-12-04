Return-Path: <linux-kernel+bounces-430490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0799F9E318F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 03:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74A5DB26951
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 02:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147FD824A3;
	Wed,  4 Dec 2024 02:45:31 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ABFF507
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 02:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733280330; cv=none; b=Z2bvXxkVH8dTXdpjKTkfhybiREtPrE0vwnoFiCgh+KXrIIYIBBc/K7Il9F3oUawlWX5HnVIT8+5tidrnG2VR8PBCMr15O4jASKxd17oaDHuylm5AZI1/K244lWW3nnN/2bxbLuCW48XA97lIzmLcCK/disSzrI4UTLC+rDOZm6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733280330; c=relaxed/simple;
	bh=KwJm3I/yL/xfbhbNiowEfFeg4udGdsYj/fEsNkpb0K4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RRjUn0PzGPhfq1TCLCdo/ZSmgzWYBzeHoTgKDE7PSqMvaAExR9TJWabKp/XcZR+7PvOM0KelOlPN9aoTncTEWHBrawetjqZUy/ExNFNuiEOPwXCPxlXmrKDYtwBvNYPCUr8+HdUCekP5UwGkz5UvdSfFJoiCjBCV/cczI8q9gdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a79088e7abso54484345ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 18:45:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733280326; x=1733885126;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5n+RRy64uhPLJdraxp/YI9ZI82dL9kmoF5z8ZlIF+RA=;
        b=IWhReZ3Fzk6DXtdzuuygmY+b22fhBxlPQawmsGL0srXVrTLA2toS+YyED/5KWSM7wm
         gXiFh/xj9YlnHun8ORQZMsMKEt6tu/WBettcQblCBlIZW/oR23wIQJ8HikyYsVe2nVDG
         X13OObe9gM6wuQC6KPzmzagRJ7MnNf+03+mceo9mtV9T/abj24CFn0n+fV7YXlpvbdQw
         +5kX/Lia5lCqLnoxJ20yNpvh4kQiyOrUxfrI391lGMazxjdRTn9V5pfL/u5sjXtwmFz0
         AHy5RchGuBTebHogb8JetAekpFbRBdi5rQPjNBq7gKiroSAM84jE/Qhlz9l/wFNo5vgM
         O1Ng==
X-Forwarded-Encrypted: i=1; AJvYcCXAzqz77H0HHV6OgYKzxb9w1opaxGzxkHqK5kKZUGwZPk0LfoQUMRSUlIZkvAsJd6Oo/hHruk82j8DM5KQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfOKQHeG//8uv5OjatOVc8sTLSRP7cF1Lfqhzioth2Uev61l4v
	0bDCXnQW9qhjWsNiU3oh/PA2i0S4IFMbQJlgLZZFXYakcU7rTjXqPCpHPe5uZq/RGmkjUN14gVN
	wycQcdy8xmabVvc0WQfJodDz6ASEeMGwXQNkTjxtT7lHfsmK5mWJ0kbs=
X-Google-Smtp-Source: AGHT+IGEF5aSXIOW+ZoDHPrleOLghl01/+F1JV5vR870hMJ+CZsAdaNfGUp9jgxodO/5quQ0ahOB49LfbZXCtQdt5ZjYrhY53jDF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e6:b0:3a7:8d8e:e760 with SMTP id
 e9e14a558f8ab-3a7f9a314a1mr53072805ab.4.1733280326464; Tue, 03 Dec 2024
 18:45:26 -0800 (PST)
Date: Tue, 03 Dec 2024 18:45:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674fc246.050a0220.17bd51.005b.GAE@google.com>
Subject: [syzbot] [mm?] INFO: rcu detected stall in sys_symlinkat (5)
From: syzbot <syzbot+9618c3b34a3062164a21@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cdd30ebb1b9f module: Convert symbol namespace to string li..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10122fc0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50c7a61469ce77e7
dashboard link: https://syzkaller.appspot.com/bug?extid=9618c3b34a3062164a21
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e29bc9ebf58c/disk-cdd30ebb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/09b856dcfafd/vmlinux-cdd30ebb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2f189038f206/bzImage-cdd30ebb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9618c3b34a3062164a21@syzkaller.appspotmail.com

bridge0: received packet on veth0_to_bridge with own address as source address (addr:f6:0d:d1:1f:43:1f, vlan:0)
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P17120/1:b..l P5826/1:b..l
rcu: 	(detected by 0, t=10503 jiffies, g=46745, q=1382 ncpus=2)
task:syz-executor    state:R  running task     stack:22784 pid:5826  tgid:5826  ppid:5821   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x1850/0x4c30 kernel/sched/core.c:6756
 preempt_schedule_common+0x84/0xd0 kernel/sched/core.c:6935
 preempt_schedule+0xe1/0xf0 kernel/sched/core.c:6959
 preempt_schedule_thunk+0x1a/0x30 arch/x86/entry/thunk.S:12
 __raw_spin_unlock include/linux/spinlock_api_smp.h:143 [inline]
 _raw_spin_unlock+0x3e/0x50 kernel/locking/spinlock.c:186
 spin_unlock include/linux/spinlock.h:391 [inline]
 zap_pte_range mm/memory.c:1705 [inline]
 zap_pmd_range mm/memory.c:1753 [inline]
 zap_pud_range mm/memory.c:1782 [inline]
 zap_p4d_range mm/memory.c:1803 [inline]
 unmap_page_range+0x37fa/0x4230 mm/memory.c:1824
 unmap_vmas+0x3cc/0x5f0 mm/memory.c:1914
 exit_mmap+0x275/0xc20 mm/mmap.c:1667
 __mmput+0x115/0x3c0 kernel/fork.c:1353
 exit_mm+0x220/0x310 kernel/exit.c:570
 do_exit+0x9b2/0x28e0 kernel/exit.c:925
 do_group_exit+0x207/0x2c0 kernel/exit.c:1087
 get_signal+0x16b2/0x1750 kernel/signal.c:3017
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xce/0x340 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f11ba376197
RSP: 002b:00007ffcd6bba000 EFLAGS: 00000293 ORIG_RAX: 000000000000003d
RAX: fffffffffffffe00 RBX: 00000000000016dd RCX: 00007f11ba376197
RDX: 0000000040000000 RSI: 00007ffcd6bba03c RDI: 00000000ffffffff
RBP: 00007ffcd6bba03c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000008
R13: 0000000000000003 R14: 0000000000000009 R15: 0000000000000000
 </TASK>
task:syz-executor    state:R  running task     stack:26752 pid:17120 tgid:17120 ppid:5855   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x1850/0x4c30 kernel/sched/core.c:6756
 preempt_schedule_irq+0xfb/0x1c0 kernel/sched/core.c:7078
 irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_acquire+0x264/0x550 kernel/locking/lockdep.c:5853
Code: 2b 00 74 08 4c 89 f7 e8 5a ac 8f 00 f6 44 24 61 02 0f 85 85 01 00 00 41 f7 c7 00 02 00 00 74 01 fb 48 c7 44 24 40 0e 36 e0 45 <4b> c7 44 25 00 00 00 00 00 43 c7 44 25 09 00 00 00 00 43 c7 44 25
RSP: 0018:ffffc9000c7274e0 EFLAGS: 00000206
RAX: 0000000000000001 RBX: 1ffff920018e4ea8 RCX: ffff8880261146d8
RDX: dffffc0000000000 RSI: ffffffff8c0aa880 RDI: ffffffff8c5f63e0
RBP: ffffc9000c727630 R08: ffffffff942b8887 R09: 1ffffffff2857110
R10: dffffc0000000000 R11: fffffbfff2857111 R12: 1ffff920018e4ea4
R13: dffffc0000000000 R14: ffffc9000c727540 R15: 0000000000000246
 rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 rcu_read_lock include/linux/rcupdate.h:849 [inline]
 page_ext_get+0x3d/0x2a0 mm/page_ext.c:525
 __reset_page_owner+0x30/0x430 mm/page_owner.c:290
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0xdef/0x1130 mm/page_alloc.c:2657
 discard_slab mm/slub.c:2673 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:3142
 put_cpu_partial+0x17c/0x250 mm/slub.c:3217
 __slab_free+0x2ea/0x3d0 mm/slub.c:4468
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_kmalloc+0x23/0xb0 mm/kasan/common.c:385
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4283 [inline]
 __kmalloc_noprof+0x285/0x4c0 mm/slub.c:4295
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 tomoyo_encode2 security/tomoyo/realpath.c:45 [inline]
 tomoyo_encode+0x26f/0x540 security/tomoyo/realpath.c:80
 tomoyo_realpath_from_path+0x59e/0x5e0 security/tomoyo/realpath.c:283
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x2b7/0x740 security/tomoyo/file.c:822
 tomoyo_path_symlink+0xde/0x120 security/tomoyo/tomoyo.c:212
 security_path_symlink+0x16f/0x370 security/security.c:1979
 do_symlinkat+0x136/0x3a0 fs/namei.c:4693
 __do_sys_symlinkat fs/namei.c:4711 [inline]
 __se_sys_symlinkat fs/namei.c:4708 [inline]
 __x64_sys_symlinkat+0x95/0xb0 fs/namei.c:4708
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7d7137f497
RSP: 002b:00007f7d7166fdb8 EFLAGS: 00000206 ORIG_RAX: 000000000000010a
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7d7137f497
RDX: 00007f7d713f5087 RSI: 00000000ffffff9c RDI: 00007f7d7166fe40
RBP: 00007f7d7166fdec R08: 0000000000000017 R09: 00007f7d7166fb07
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000032
R13: 000000000004e774 R14: 000000000004e76a R15: 00007f7d7166fe40
 </TASK>
rcu: rcu_preempt kthread starved for 10574 jiffies! g46745 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:26072 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x1850/0x4c30 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6848
 schedule_timeout+0x15a/0x290 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x2df/0x1330 kernel/rcu/tree.c:2045
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:2247
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.13.0-rc1-syzkaller-00002-gcdd30ebb1b9f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:refdst_drop include/net/dst.h:262 [inline]
RIP: 0010:skb_dst_drop include/net/dst.h:275 [inline]
RIP: 0010:br_drop_fake_rtable include/linux/netfilter_bridge.h:24 [inline]
RIP: 0010:br_dev_queue_push_xmit+0x1ed/0x900 net/bridge/br_forward.c:39
Code: 8b 74 24 10 eb 70 e8 82 96 06 f7 49 bc 00 00 00 00 00 fc ff df 4c 8b 74 24 10 eb 5a 4c 89 ee 48 83 e6 01 31 ff e8 43 9b 06 f7 <49> 83 e5 01 4c 8b 7c 24 18 48 8b 5c 24 20 75 0f e8 4e 96 06 f7 4c
RSP: 0018:ffffc90000156400 EFLAGS: 00000246
RAX: 0000000000000100 RBX: 0000000000000010 RCX: ffff88801d2bda00
RDX: ffff88801d2bda00 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc900001564f0 R08: ffffffff8a98dbbd R09: 1ffffffff20328be
R10: dffffc0000000000 R11: fffffbfff20328bf R12: 1ffff11030e4419b
R13: ffff88805e720f99 R14: ffff88805e720f98 R15: ffff88805e720fd0
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555676e35c8 CR3: 000000002913e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 </IRQ>
 <TASK>
 NF_HOOK+0x700/0x7c0 include/linux/netfilter.h:314
 br_nf_post_routing+0xa20/0xe80 net/bridge/br_netfilter_hooks.c:997
 nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
 nf_hook_slow+0xc3/0x220 net/netfilter/core.c:626
 nf_hook include/linux/netfilter.h:269 [inline]
 NF_HOOK+0x2a7/0x460 include/linux/netfilter.h:312
 br_forward_finish+0xd8/0x130 net/bridge/br_forward.c:66
 br_nf_forward_finish+0xb49/0xfb0 net/bridge/br_netfilter_hooks.c:693
 NF_HOOK+0x700/0x7c0 include/linux/netfilter.h:314
 br_nf_forward_ip+0x61e/0x7b0 net/bridge/br_netfilter_hooks.c:747
 nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
 nf_hook_slow+0xc3/0x220 net/netfilter/core.c:626
 nf_hook include/linux/netfilter.h:269 [inline]
 NF_HOOK+0x2a7/0x460 include/linux/netfilter.h:312
 __br_forward+0x489/0x660 net/bridge/br_forward.c:115
 deliver_clone net/bridge/br_forward.c:131 [inline]
 maybe_deliver+0xb3/0x150 net/bridge/br_forward.c:190
 br_flood+0x2e4/0x660 net/bridge/br_forward.c:236
 br_handle_frame_finish+0x18ba/0x1fe0 net/bridge/br_input.c:215
 br_nf_hook_thresh+0x472/0x590
 br_nf_pre_routing_finish_ipv6+0xaa0/0xdd0
 NF_HOOK include/linux/netfilter.h:314 [inline]
 br_nf_pre_routing_ipv6+0x379/0x770 net/bridge/br_netfilter_ipv6.c:184
 nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
 nf_hook_bridge_pre net/bridge/br_input.c:277 [inline]
 br_handle_frame+0x9fd/0x1530 net/bridge/br_input.c:424
 __netif_receive_skb_core+0x14eb/0x4690 net/core/dev.c:5566
 __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
 __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
 process_backlog+0x662/0x15b0 net/core/dev.c:6117
 __napi_poll+0xcb/0x490 net/core/dev.c:6877
 napi_poll net/core/dev.c:6946 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:7068
 handle_softirqs+0x2d4/0x9b0 kernel/softirq.c:554
 run_ksoftirqd+0xca/0x130 kernel/softirq.c:943
 smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:f6:0d:d1:1f:43:1f, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:f6:0d:d1:1f:43:1f, vlan:0)
net_ratelimit: 33548 callbacks suppressed
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:f6:0d:d1:1f:43:1f, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:f6:0d:d1:1f:43:1f, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)


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

