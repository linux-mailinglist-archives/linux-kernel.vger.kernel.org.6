Return-Path: <linux-kernel+bounces-553515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50376A58ACE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 04:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4CAE3AB879
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 03:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF42D1ADC69;
	Mon, 10 Mar 2025 03:20:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEE2189B8C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 03:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741576806; cv=none; b=CksYiP/yyRLiekoyQ5jV94jbbqssNvjDHSAT7tqU6yhYrWz/VCeQhVP8RKgpayEltWion8EhWPbBIS6mnZomMPQXDqSBqrNeyi4ZoUrxyZ0ZPzjZutJgH002CUm3xfQlDQT909zUMVAUU1QrGs4k6wrMqibMSTggDoCBpCu/zD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741576806; c=relaxed/simple;
	bh=wHzOM9pMdmfpvwH9XboajoWlP9RmGlsJdAOKS2UrjTY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FlzUahByhxHDEiRvIe0DLSbPryNXg77Nx0UAOyjhYloFly7KETFftH+UD9OqWAyEa+f44nlPqHhwCcUJ76iA02ZptpcbRmRNsfI9RBTWD5AZEfhgvv6jzNGD1Ktuwf9aubdf62uiP55WRib4O5GeWJc3XNGEtZOUyQM2wUJAwxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d43541a706so22880825ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 20:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741576803; x=1742181603;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wBnmS1EEfxllnIMWtKHWQjyTIgyI/C7R7w2Z+ZaSLz8=;
        b=mxVPjvIprEGqhkosm34Kkfc7+UsDN0QQSxUl93h5WIjk7x7Hc6+fV7ZHErIxwfn4/2
         4evAQT3ipejQDYtk/XXyBvMnMpk5NL+jEWPK6S4jbfmI5nDkKbKNvvhNlri1zOIzNbRd
         MA4oHuZ00jbJzn0BEihaXkc8aK5hVQ1z8YgHpZ7vwCI2WLYR9HDFwbHPZAUl3NrLu4/M
         R3QH8u6O3snNZWIhHdojSfTuH6GMUXwEhwpZWqetDuQWLM9gpS5GqsywW4FIpGlZXr+x
         EXcMtKtB/lW9W6U6SwCw6Re6ni6Xyucndv1wTnFoWIM1kpxobac5/DSS6DBrb3XQTflX
         KJPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlsfns4RSQF1/bzr9vMY8wEkKIxZWOirgveeUKLmuyNmBxd65o5zji9Ra+BJI+i5Fvhs8p8HEn3wcsY70=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMU07wkXWl3PsWpTwdFg8lip4GGIRaILYH0ql2Um2LgjoizEdD
	RPOW0Iag/4YKsheX6BM2Yv+p6Rh+ZT5QBEEMcFaDtPz9Rb9GMe88+NU9aWis53C7Jys7qHQ5UMu
	gFI64pcZYrU+9XRguTPOhFjF+e+KrS7xtF+y04wYqLBYYpe4whGldqQg=
X-Google-Smtp-Source: AGHT+IHsM96ydviW0pW4cKHP8M9iVe/64vmy69dsn6ycu0NS62G8/qDF3Tp/USKyRTi4Ny+86C1QCCrNy7t/0gdvlxQtxdKFhdTd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c03:b0:3d4:3ab3:5574 with SMTP id
 e9e14a558f8ab-3d441957d7dmr152844065ab.3.1741576803644; Sun, 09 Mar 2025
 20:20:03 -0700 (PDT)
Date: Sun, 09 Mar 2025 20:20:03 -0700
In-Reply-To: <20250310021249.2624454-1-luyun@kylinos.cn>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ce5a63.050a0220.3d01d1.0008.GAE@google.com>
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in mas_preallocate (2)
From: syzbot <syzbot+882589c97d51a9de68eb@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, liam.howlett@oracle.com, 
	linux-kernel@vger.kernel.org, luyun@kylinos.cn, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in worker_thread

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	(detected by 0, t=10506 jiffies, g=14277, q=1212 ncpus=2)
rcu: All QSes seen, last rcu_preempt kthread activity 10506 (4294962116-4294951610), jiffies_till_next_fqs=1, root ->qsmask 0x0
rcu: rcu_preempt kthread starved for 10506 jiffies! g14277 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:25784 pid:18    tgid:18    ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 schedule_timeout+0x15a/0x290 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x2df/0x1330 kernel/rcu/tree.c:2024
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:2226
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 1162 Comm: kworker/u8:8 Not tainted 6.14.0-rc6-syzkaller-g80e54e84911a-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:memset_orig+0x75/0xb0 arch/x86/lib/memset_64.S:90
Code: 89 47 30 48 89 47 38 48 8d 7f 40 75 d8 0f 1f 84 00 00 00 00 00 89 d1 83 e1 38 74 14 c1 e9 03 66 0f 1f 44 00 00 ff c9 48 89 07 <48> 8d 7f 08 75 f5 83 e2 07 74 0a ff ca 88 07 48 8d 7f 01 75 f6 4c
RSP: 0018:ffffc90000a28cd0 EFLAGS: 00000002
RAX: 0000000000000000 RBX: 1ffff110170e58ca RCX: 0000000000000001
RDX: 0000000000000018 RSI: 0000000000000000 RDI: ffff8880286e5348
RBP: 1ffff110050dca68 R08: ffff8880286e5357 R09: 0000000000000000
R10: ffff8880286e5340 R11: ffffed10050dca6b R12: ffff8880b872c650
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff8880286e5340
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc8509ffd58 CR3: 0000000032a00000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 rb_link_node include/linux/rbtree.h:63 [inline]
 rb_add_cached include/linux/rbtree.h:182 [inline]
 timerqueue_add+0x200/0x290 lib/timerqueue.c:40
 __run_hrtimer kernel/time/hrtimer.c:1818 [inline]
 __hrtimer_run_queues+0x6cb/0xd30 kernel/time/hrtimer.c:1865
 hrtimer_interrupt+0x403/0xa40 kernel/time/hrtimer.c:1927
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1038 [inline]
 __sysvec_apic_timer_interrupt+0x110/0x420 arch/x86/kernel/apic/apic.c:1055
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:stack_trace_consume_entry+0x5/0x280 kernel/stacktrace.c:83
Code: ff ff ff e8 bd b4 4c 0a 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 <41> 57 41 56 41 55 41 54 53 48 83 ec 18 48 89 fb 48 ba 00 00 00 00
RSP: 0018:ffffc90003d9f330 EFLAGS: 00000282
RAX: ffffffff8129d67a RBX: ffffc90003d9f340 RCX: ffffffff917cc000
RDX: ffffffff9197e501 RSI: ffffffff8129d67a RDI: ffffc90003d9f420
RBP: ffffc90003d9f3d0 R08: ffffc90003d9f39f R09: 0000000000000000
R10: ffffc90003d9f390 R11: ffffffff81ab43c0 R12: ffff888026f63c00
R13: ffffffff81ab43c0 R14: ffffc90003d9f420 R15: 0000000000000000
 arch_stack_walk+0x10e/0x150 arch/x86/kernel/stacktrace.c:27
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4609 [inline]
 kfree+0x196/0x430 mm/slub.c:4757
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1582 [inline]
 ieee80211_ibss_rx_queued_mgmt+0x1b25/0x2d70 net/mac80211/ibss.c:1608
 ieee80211_iface_process_skb net/mac80211/iface.c:1612 [inline]
 ieee80211_iface_work+0x8dc/0xf90 net/mac80211/iface.c:1666
 cfg80211_wiphy_work+0x2f0/0x490 net/wireless/core.c:435
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3319
 worker_thread+0x870/0xd30 kernel/workqueue.c:3400
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


Tested on:

commit:         80e54e84 Linux 6.14-rc6
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=102d9fa0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cefb44c3bbe3e2a0
dashboard link: https://syzkaller.appspot.com/bug?extid=882589c97d51a9de68eb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14999fa0580000


