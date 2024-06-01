Return-Path: <linux-kernel+bounces-197789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BB38D6F29
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 11:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15F0E284605
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 09:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89D314E2F4;
	Sat,  1 Jun 2024 09:34:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614A47E766
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 09:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717234446; cv=none; b=NLNjAnGE/F9kcN2KmGAQkkDA+B7yBVA3o34xHYUKCxV3t+ZSORiXrWTQu92G5bjM2i+ULX7lyLhoNX065AjdC4WImqYrvp1mov+dbRhEHlNXPwz/YooqZ+xzhxC45QqaFKiqrdSYfIjMmNiRvGHdnJSbHULESrVpZ7rwVnzotYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717234446; c=relaxed/simple;
	bh=yjjrW47qvGctUcKUlXIP7UELDrzQ5ZlbAcfVW4A335M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rR7kCgmy+EtzNV2Pwd97JGq48/euGM9aZgHkpNKJ4nidA5h2ks6NByJ6JFMiW6xZhRjCMtgw6fW37hcIBdN730EfdP0vrODZWL8Q5SZkurYGrpcMj9Of/v/E/ba9lPVW3RveQB8dbmd/xgg+1rL7sE6qeSEcopQcHQoffvVWP/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7eb01189491so196071839f.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 02:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717234443; x=1717839243;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iOcx2iLfY74qHsDUdAzED208EjvmBh5puzvRlTclLoo=;
        b=FYYV6YbZGbXcNX7iZGNHPhM9r6sME66SdOxUVC3k0onzmj2FpvTTKvoSUm12TOCkuT
         wHm0ymxZ95um8yUD4NlTbbRpctuECWNVThhILzioYc7T7/SlirckiZ4mCRweAyB/Cnec
         X/PyIzWJWPe7DB/yMB10XdL1/Ujrry3GIcVPMqBht41XM0kKbxGzz1y1kISDWfe1pQZy
         u5y305s/rpbeOHH2YUrhglIuRrDI1a+iZXgQyaZx7XkJMkpjebH4xyYgCVFKQbbfVGX9
         kv2UvG5wd1IG4PI3X1+hAQUYpIIy0GlEX48bZUaiZYsjVtxmrDzQCvMWh53pLikHHcyD
         /psQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGwwVmh28ck98zFWaw/xRvkyYMsCawtb5IEKA9QuHUZLKZfFDD6aCd80yKHsG1pv2dgwtPOcBk380vNgC5qhjZOBr+n585OUynUdiw
X-Gm-Message-State: AOJu0Yzd89NYX4DlARU1ogtcljKMEJUo+2+ulehWIQ2wdc84ofsrRk7U
	mHxHKEFnR5yXkStwB8cVCgHIskEqWnw1/4+1Qv5UC4e86lcy3nPNzX/b+PKDp/45ymek+NNNWAC
	aynrq6Xw6UoNulpi+Ho0MOV3bCAI1h83VJzT/pKSIGRW1iQD0VRZ/cjQ=
X-Google-Smtp-Source: AGHT+IFRs2X0Q88sMHC1nWF7YPDURBlcRPsGPeYDkORLfRZ9uRjf7B0nlO8WPgBdcagYhwSIqap9ETqipqGIeURjjq/Yn5qrl48B
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3406:b0:7e2:b00:2264 with SMTP id
 ca18e2360f4ac-7eafff319b2mr23328439f.2.1717234443537; Sat, 01 Jun 2024
 02:34:03 -0700 (PDT)
Date: Sat, 01 Jun 2024 02:34:03 -0700
In-Reply-To: <20240601090702.3550-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000000dfdb0619d0cd68@google.com>
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in kcompactd (2)
From: syzbot <syzbot+54594368fbd5a4f1754a@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in batadv_nc_worker

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P1272/1:b..l
rcu: 	(detected by 1, t=10502 jiffies, g=17369, q=1047 ncpus=2)
task:kworker/u8:8    state:R  running task     stack:22656 pid:1272  tgid:1272  ppid:2      flags:0x00004000
Workqueue: bat_events batadv_nc_worker
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0xf15/0x5d00 kernel/sched/core.c:6745
 preempt_schedule_irq+0x51/0x90 kernel/sched/core.c:7067
 irqentry_exit+0x36/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_acquire+0x1f2/0x560 kernel/locking/lockdep.c:5722
Code: c1 05 9a bf 96 7e 83 f8 01 0f 85 ea 02 00 00 9c 58 f6 c4 02 0f 85 d5 02 00 00 48 85 ed 74 01 fb 48 b8 00 00 00 00 00 fc ff df <48> 01 c3 48 c7 03 00 00 00 00 48 c7 43 08 00 00 00 00 48 8b 84 24
RSP: 0018:ffffc90004bafaa0 EFLAGS: 00000206
RAX: dffffc0000000000 RBX: 1ffff92000975f56 RCX: 0000000072d6c7e4
RDX: 0000000000000001 RSI: ffffffff8b2cb0e0 RDI: ffffffff8b8ffec0
RBP: 0000000000000200 R08: 0000000000000000 R09: fffffbfff284d658
R10: ffffffff9426b2c7 R11: 0000000000000002 R12: 0000000000000000
R13: 0000000000000000 R14: ffffffff8dbb18e0 R15: 0000000000000000
 rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 rcu_read_lock include/linux/rcupdate.h:781 [inline]
 batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:408 [inline]
 batadv_nc_worker+0x16e/0x10f0 net/batman-adv/network-coding.c:719
 process_one_work+0x9fb/0x1b60 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: rcu_preempt kthread starved for 2809 jiffies! g17369 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:I stack:27680 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0xf15/0x5d00 kernel/sched/core.c:6745
 preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:6924
 preempt_schedule_thunk+0x1a/0x30 arch/x86/entry/thunk.S:12
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
 _raw_spin_unlock_irqrestore+0x61/0x80 kernel/locking/spinlock.c:194
 __debug_object_init+0x34a/0x480 lib/debugobjects.c:645
 init_timer_on_stack_key kernel/time/timer.c:859 [inline]
 schedule_timeout+0x102/0x2a0 kernel/time/timer.c:2579
 rcu_gp_fqs_loop+0x1eb/0xb00 kernel/rcu/tree.c:2000
 rcu_gp_kthread+0x271/0x380 kernel/rcu/tree.c:2202
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 1 PID: 61 Comm: kworker/u8:4 Not tainted 6.10.0-rc1-syzkaller-00267-gcc8ed4d0a848-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:preempt_count_sub+0x63/0x160 kernel/sched/core.c:5909
Code: 57 13 85 c9 75 1b 65 8b 05 52 5f a6 7e 89 c2 81 e2 ff ff ff 7f 39 d3 7f 17 81 fb fe 00 00 00 76 71 f7 db 65 01 1d 35 5f a6 7e <5b> c3 cc cc cc cc 90 e8 a1 bd 22 03 85 c0 74 51 48 c7 c0 d4 94 e4
RSP: 0018:ffffc90000a17da8 EFLAGS: 00000293
RAX: 0000000080000303 RBX: 00000000ffffffff RCX: 0000000000000000
RDX: 0000000000000303 RSI: ffffffff813cd885 RDI: 0000000000000001
RBP: ffffc90000a18ea0 R08: 0000000000000006 R09: ffffc90000a18df8
R10: ffffc90000a18ea0 R11: ffff8880b93293d8 R12: ffffc90000a11000
R13: ffffc90000a19000 R14: ffffc90000a18ea8 R15: ffffc90000a18df8
FS:  0000000000000000(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd06bfb0000 CR3: 000000007dec4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 unwind_next_frame+0x11ef/0x23a0 arch/x86/kernel/unwind_orc.c:672
 arch_stack_walk+0x100/0x170 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x95/0xd0 kernel/stacktrace.c:122
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:4121 [inline]
 __kmalloc_noprof+0x1ec/0x410 mm/slub.c:4134
 kmalloc_noprof include/linux/slab.h:664 [inline]
 kzalloc_noprof include/linux/slab.h:778 [inline]
 ieee802_11_parse_elems_full+0xea/0x15d0 net/mac80211/parse.c:880
 ieee802_11_parse_elems_crc net/mac80211/ieee80211_i.h:2330 [inline]
 ieee802_11_parse_elems net/mac80211/ieee80211_i.h:2337 [inline]
 ieee80211_inform_bss+0xfd/0x1140 net/mac80211/scan.c:79
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
 ieee80211_tasklet_handler+0xee/0x150 net/mac80211/main.c:441
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
RIP: 0010:__sanitizer_cov_trace_switch+0x30/0x90 kernel/kcov.c:320
Code: 41 55 41 54 49 89 fc 55 48 89 f5 53 48 8b 46 08 48 83 f8 20 74 6b 77 48 48 83 f8 08 74 5b 48 83 f8 10 75 2f 41 bd 03 00 00 00 <4c> 8b 75 00 31 db 4d 85 f6 74 1e 48 8b 74 dd 10 4c 89 e2 4c 89 ef
RSP: 0018:ffffc900015c6ea8 EFLAGS: 00000246
RAX: 0000000000000008 RBX: ffffc900015c6f58 RCX: 0000000000000001
RDX: ffff888017790000 RSI: ffffffff8b29c9c0 RDI: 0000000000000002
RBP: ffffffff8b29c9c0 R08: 0000000000000001 R09: 0000000000000009
R10: 0000000000000005 R11: 0000000000000003 R12: 0000000000000002
R13: 0000000000000001 R14: ffffffff907080da R15: 0000000000000002
 unwind_next_frame+0x789/0x23a0 arch/x86/kernel/unwind_orc.c:581
 arch_stack_walk+0x100/0x170 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x95/0xd0 kernel/stacktrace.c:122
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:4121 [inline]
 __kmalloc_noprof+0x1ec/0x410 mm/slub.c:4134
 kmalloc_noprof include/linux/slab.h:664 [inline]
 kzalloc_noprof include/linux/slab.h:778 [inline]
 cfg80211_inform_single_bss_data+0x530/0x1f70 net/wireless/scan.c:2249
 cfg80211_inform_bss_data+0x205/0x39d0 net/wireless/scan.c:3101
 cfg80211_inform_bss_frame_data+0x271/0x7c0 net/wireless/scan.c:3191
 ieee80211_bss_info_update+0x311/0xab0 net/mac80211/scan.c:226
 ieee80211_rx_bss_info net/mac80211/ibss.c:1099 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1578 [inline]
 ieee80211_ibss_rx_queued_mgmt+0x1898/0x2f40 net/mac80211/ibss.c:1605
 ieee80211_iface_process_skb net/mac80211/iface.c:1605 [inline]
 ieee80211_iface_work+0xc07/0xf00 net/mac80211/iface.c:1659
 cfg80211_wiphy_work+0x255/0x330 net/wireless/core.c:437
 process_one_work+0x9fb/0x1b60 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


Tested on:

commit:         cc8ed4d0 Merge tag 'drm-fixes-2024-06-01' of https://g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1096541c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=238430243a58f702
dashboard link: https://syzkaller.appspot.com/bug?extid=54594368fbd5a4f1754a
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16007026980000


