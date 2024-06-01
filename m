Return-Path: <linux-kernel+bounces-197670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4FF8D6DA7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 05:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59F8C1F23254
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 03:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB245AD48;
	Sat,  1 Jun 2024 03:17:29 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B066B3C3C
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 03:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717211849; cv=none; b=ZpAaiwaSYSGWjWHGUJZ2l4nnjYrH7Z8Kzs6DiFQQl2QFTeNeg714aWpaIaaprss9dnuBljLqB1BugRGrvikjGd9tmltQnQkwdUu51Ny065E2DGu6sz9XIjuki4ReEak8Uwb9vVYRCDeDqf0y+5X+HlOZ8UVNX2MNq2gLI7pOzKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717211849; c=relaxed/simple;
	bh=4d29TZl4lTt26iOUm+MtEENjXd1VDbmni0MygB0n7jo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ftyPEfVLFv/R84n96FdCN97Z15RcHIb78CiMPb+jymuRDZUN+Cr4PvxZUEiNWQ1FMzDGT+jnN5zUiAvx/tuTcumMtzr1ssnMU4L5IR2xLOGPEi0rvUATDX8K3jKutewu2L0gukwfHPng3Si3nQrYETCd9/bwBwMLbDM8v2Ftrcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7e6e4a83282so321660639f.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 20:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717211847; x=1717816647;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D3sUsRK852V8Vvd/TxZEvRHW2eRrz/ZMQVRoNxaSsDM=;
        b=U6a37lQ94ybzcQmdWQ6ofk2XJBs8q6nbfbC0fVjqqYTvaawrjfU0us2QW64Khxcw43
         2ekPnngIhxDEAOgxAPwZaIC2HaDYUelbIf125wj+Iew57QoPMfHL+A+RM3zaUXrn4D8S
         giroERk/Kr+5z0HopI5/RvRmEhQWXXtlnYzTWDXkrtEC0UpIoBBdRmSbhsPQpP2vDsGj
         7NGtxxN2VMA74p0TgBQ6qWw6vAvNoVwUbjlqZTs54SLMivWCecMqpCW8Kh/nwU4YCxGB
         NmEpAH099fx94+7YYH+72ZZodzRnUJf82md5Inu64Wx1p4JBPnuFz/yQDy1XtrHrQZf+
         S7ng==
X-Forwarded-Encrypted: i=1; AJvYcCWJWM8Hki4fqnfeJXEfqCTlXczfM5H3BGFaPXmHtmIlNrJ6cv1BsKnI8zpJz+BHBMik72e1y+niN3LRormI9ncGSh49GmeMujEz/tNl
X-Gm-Message-State: AOJu0YykqUVX8l4354aZu4dc+2EjNXcRg9J8KLOSFYbOsckoECQKvus2
	D/8aYuXThtarh7wPBhDzZ64copmuZeMqqDwUJdj5zFkx2wu1hfOAwI7vrstXgGawzmdQiheB+0q
	3MTc80NttKmyz0sSJd8cCONcywekjnAlD3WFudHCHAke5ALY+jtbj+Xs=
X-Google-Smtp-Source: AGHT+IG7Nz/TBFuEpQWCC5JWwuNQSnb/H/iQIgdhXQdDwo3H7I/myjRvTrkzhq7swDaBy7CYH3XEZoZ29rFLJsa3/EAlB1tkwRgS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3406:b0:7ea:fc3b:3 with SMTP id
 ca18e2360f4ac-7eaffe9aae8mr23523239f.1.1717211846865; Fri, 31 May 2024
 20:17:26 -0700 (PDT)
Date: Fri, 31 May 2024 20:17:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002304860619cb8aa1@google.com>
Subject: [syzbot] [mm?] INFO: rcu detected stall in kcompactd (2)
From: syzbot <syzbot+54594368fbd5a4f1754a@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2bfcfd584ff5 Merge tag 'pmdomain-v6.10-rc1' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15099734980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=238430243a58f702
dashboard link: https://syzkaller.appspot.com/bug?extid=54594368fbd5a4f1754a
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ccc672980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17314572980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/261f1cc4b66a/disk-2bfcfd58.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e0a2dd5351d9/vmlinux-2bfcfd58.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dab3ffb1a0d4/bzImage-2bfcfd58.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+54594368fbd5a4f1754a@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	(detected by 1, t=10502 jiffies, g=9993, q=77 ncpus=2)
rcu: All QSes seen, last rcu_preempt kthread activity 1800 (4294972632-4294970832), jiffies_till_next_fqs=1, root ->qsmask 0x0
rcu: rcu_preempt kthread starved for 1800 jiffies! g9993 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:27680 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0xf15/0x5d00 kernel/sched/core.c:6745
 preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:6924
 preempt_schedule_thunk+0x1a/0x30 arch/x86/entry/thunk.S:12
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
 _raw_spin_unlock_irqrestore+0x61/0x80 kernel/locking/spinlock.c:194
 rcu_gp_fqs_loop+0x217/0xb00 kernel/rcu/tree.c:2000
 rcu_gp_kthread+0x271/0x380 kernel/rcu/tree.c:2202
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 1 PID: 34 Comm: kcompactd0 Not tainted 6.10.0-rc1-syzkaller-00013-g2bfcfd584ff5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x31/0x80 kernel/locking/spinlock.c:194
Code: f5 53 48 8b 74 24 10 48 89 fb 48 83 c7 18 e8 26 68 80 f6 48 89 df e8 0e e5 80 f6 f7 c5 00 02 00 00 75 23 9c 58 f6 c4 02 75 37 <bf> 01 00 00 00 e8 25 27 72 f6 65 8b 05 b6 86 18 75 85 c0 74 16 5b
RSP: 0018:ffffc90000a18248 EFLAGS: 00000246
RAX: 0000000000000006 RBX: ffffffff94ca7948 RCX: 1ffffffff2857134
RDX: 0000000000000000 RSI: ffffffff8b2cade0 RDI: ffffffff8b8fffc0
RBP: 0000000000000286 R08: 0000000000000001 R09: fffffbfff284d670
R10: ffffffff9426b387 R11: 0000000000000002 R12: ffffffff94ca7940
R13: 0000000000000000 R14: 0000000000000000 R15: ffff888059c72800
FS:  0000000000000000(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff8f455d78 CR3: 0000000049512000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 __debug_check_no_obj_freed lib/debugobjects.c:998 [inline]
 debug_check_no_obj_freed+0x328/0x600 lib/debugobjects.c:1019
 slab_free_hook mm/slub.c:2162 [inline]
 slab_free mm/slub.c:4436 [inline]
 kfree+0x284/0x3b0 mm/slub.c:4557
 ieee80211_inform_bss+0x76e/0x1140 net/mac80211/scan.c:160
 rdev_inform_bss net/wireless/rdev-ops.h:418 [inline]
 cfg80211_inform_single_bss_data+0x893/0x1f70 net/wireless/scan.c:2277
 cfg80211_inform_bss_data+0x205/0x39d0 net/wireless/scan.c:3101
 cfg80211_inform_bss_frame_data+0x271/0x7c0 net/wireless/scan.c:3191
 ieee80211_bss_info_update+0x311/0xab0 net/mac80211/scan.c:226
 ieee80211_scan_rx+0x47c/0xad0 net/mac80211/scan.c:340
 __ieee80211_rx_handle_packet net/mac80211/rx.c:5222 [inline]
 ieee80211_rx_list+0x1be1/0x2e90 net/mac80211/rx.c:5459
 ieee80211_rx_napi+0xdd/0x400 net/mac80211/rx.c:5482
 ieee80211_rx include/net/mac80211.h:5093 [inline]
 ieee80211_tasklet_handler+0xd6/0x130 net/mac80211/main.c:438
 tasklet_action_common.constprop.0+0x24c/0x3e0 kernel/softirq.c:785
 handle_softirqs+0x216/0x8f0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xbb/0x120 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:free_object lib/debugobjects.c:423 [inline]
RIP: 0010:debug_object_free+0x294/0x500 lib/debugobjects.c:866
Code: 4d 89 6c 24 08 48 8b 7c 24 10 48 89 ce 48 b8 00 01 00 00 00 00 ad de 48 89 03 48 83 c0 22 48 89 43 08 e8 ff 6b 61 06 48 89 df <e8> e7 d0 ff ff 0f b6 05 e0 df 3f 10 84 c0 0f 85 13 fe ff ff 8b 05
RSP: 0018:ffffc90000aa7bb0 EFLAGS: 00000286
RAX: 0000000080000000 RBX: ffff88805aa2d070 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff8b2cade0 RDI: ffff88805aa2d070
RBP: ffffc90000aa7ca0 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff8fe45e57 R11: 0000000000000000 R12: ffff888021d9be00
R13: ffffffff94d302d8 R14: ffffc90000aa7cd0 R15: 1ffff92000154f7a
 destroy_timer_on_stack kernel/time/timer.c:866 [inline]
 schedule_timeout+0x14f/0x2a0 kernel/time/timer.c:2585
 kcompactd+0xad3/0xde0 mm/compaction.c:3199
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
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

