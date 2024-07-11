Return-Path: <linux-kernel+bounces-249879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4AF92F10C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 23:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92907B21184
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85E719F49E;
	Thu, 11 Jul 2024 21:22:22 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A542C19EECC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 21:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720732942; cv=none; b=G1iWzq7sgmQNg+rcDD0J6ox88uIvQhWznk1LZ5/2C6YouzZ1RmCx74RgqPJ2bWaVHsz3x3lAKLtmERSS54lKPhw3VcWQEtqQjymJ1/JfaJjzLybBYzBz0OOM/1cK1gM3+auEBEcxbnV3PXUQZMH/SOCS+e/M58IHQonZN2Nzs2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720732942; c=relaxed/simple;
	bh=WKV7EiF49VXOjBCu3JN0/CxQ2+R52bXOaMWR+xNOswM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WJTSIy2Pc0WFvf1AQjYIEn7stozpL3ls1A9gVbwqr885abzYiJ4ZnYHOljoelprQ6VGkXzhPgAzzCQYJzoyCaZrlSw/tnRKMr1ocAs3h0+x64hrvYLIWtJwZhBEFFdRYXBv9OONgUClmCgweDBQrMwTbvaRKn8bJJrMFNKxQsYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-803621a51c9so133898839f.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 14:22:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720732940; x=1721337740;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V5KrRADqqgElSKDaJVoAI54QkDFHx1CP6gvtpZMLm/M=;
        b=mRgzDhvUEkfdWp6lR5m4rV4i5jHjvUgGa1X7EzacV20q8VvhYlM8Nkncr43qmeRJE3
         j4fRCOFLjJFuxo1lP8G8x86NlPwI8n8LJXo0Ojt7rKVnNe41DeeIV4sE+CQOrYLfcF4B
         FyB4Tdg5DrJRcZqAjICRjgG1TgOWxZ7ywxGTYX6/0cd0roHv9OGCTirdYT1PSMuDiVqo
         5ALqfjFNuxieIsKoTZINZSh4tfNII1FgvLi4N+sW5TRBdQaLOg1nYsiSsf5ugeweWvb3
         xHZSakquaNg6Ui48JP7ed0dIlOy3wfVeA3hGhzzDBnbIbvm658CJoFLNL820DJzaB1Bz
         npRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd8d0+RRM5mTA5hQfwXJBs3z7Sckb0wVTAfz74gkTrM7KI8oogGmXFQzr0Iv/2JiWLDS8e6P7mQGE7q42NvZmQHbLCASCBqaGV5xxX
X-Gm-Message-State: AOJu0YwuXh7vM6ke6D0HIQ1PSwTjIOSokSuOTXefcl8Rwk2/laXypMH4
	WtlewkoQSBG3rg/HVl94f0ZNPT3tWLM2o72I11ARqDOxTPt9p6ALqGW847cUqvNTvP0wK62YhLD
	rBVYFwxuIoZUN/Y+FOz6/wrLSBhzeMYBo9PlZiVgdjmQ7Kf5rHU3dfSA=
X-Google-Smtp-Source: AGHT+IG/f4T+jCURlZTMqk9+51lWxVpvgrsbO0jTM6JswnN2aKkLK4P1sishBdI+JOgG/O9OaFMP6dx24zevEDmbu+r4hlYHjqqs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:f87:b0:382:7ea4:af41 with SMTP id
 e9e14a558f8ab-38a5a459aefmr910365ab.6.1720732939726; Thu, 11 Jul 2024
 14:22:19 -0700 (PDT)
Date: Thu, 11 Jul 2024 14:22:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a0424f061cff5b6b@google.com>
Subject: [syzbot] [kernel?] WARNING: locking bug in sched_tick
From: syzbot <syzbot+6212b93592985c1211e8@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, frederic@kernel.org, 
	linux-kernel@vger.kernel.org, mingo@kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c6653f49e4fd Merge tag 'powerpc-6.10-4' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1785dd69980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=864caee5f78cab51
dashboard link: https://syzkaller.appspot.com/bug?extid=6212b93592985c1211e8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cb0dd3b0fc75/disk-c6653f49.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ed91ee4fa1ee/vmlinux-c6653f49.xz
kernel image: https://storage.googleapis.com/syzbot-assets/567a4c1329fc/bzImage-c6653f49.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6212b93592985c1211e8@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 1 PID: 3650 at kernel/locking/lockdep.c:232 hlock_class kernel/locking/lockdep.c:232 [inline]
WARNING: CPU: 1 PID: 3650 at kernel/locking/lockdep.c:232 check_wait_context kernel/locking/lockdep.c:4773 [inline]
WARNING: CPU: 1 PID: 3650 at kernel/locking/lockdep.c:232 __lock_acquire+0x573/0x1fd0 kernel/locking/lockdep.c:5087
Modules linked in:
CPU: 1 PID: 3650 Comm: kworker/u8:10 Not tainted 6.10.0-rc6-syzkaller-00223-gc6653f49e4fd #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:hlock_class kernel/locking/lockdep.c:232 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4773 [inline]
RIP: 0010:__lock_acquire+0x573/0x1fd0 kernel/locking/lockdep.c:5087
Code: 00 00 83 3d 0e 08 3b 0e 00 75 23 90 48 c7 c7 e0 b9 ca 8b 48 c7 c6 80 bc ca 8b e8 18 e2 e5 ff 48 ba 00 00 00 00 00 fc ff df 90 <0f> 0b 90 90 90 31 db 48 81 c3 c4 00 00 00 48 89 d8 48 c1 e8 03 0f
RSP: 0018:ffffc90000a189b0 EFLAGS: 00010046
RAX: 83a97af55935d700 RBX: 0000000000001ef0 RCX: ffff88802d523c00
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000014 R08: ffffffff81585822 R09: 1ffff110172a519a
R10: dffffc0000000000 R11: ffffed10172a519b R12: 0000000000000001
R13: ffff88802d523c00 R14: 0000000000000014 R15: ffff88802d5247a0
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000454b8000 CR4: 0000000000350ef0
Call Trace:
 <IRQ>
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
 raw_spin_rq_lock_nested+0xb0/0x140 kernel/sched/core.c:567
 raw_spin_rq_lock kernel/sched/sched.h:1406 [inline]
 rq_lock kernel/sched/sched.h:1702 [inline]
 sched_tick+0xa9/0x730 kernel/sched/core.c:5678
 update_process_times+0x202/0x230 kernel/time/timer.c:2490
 tick_sched_handle kernel/time/tick-sched.c:276 [inline]
 tick_nohz_handler+0x37c/0x500 kernel/time/tick-sched.c:297
 __run_hrtimer kernel/time/hrtimer.c:1689 [inline]
 __hrtimer_run_queues+0x553/0xd50 kernel/time/hrtimer.c:1753
 hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1815
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x112/0x3f0 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0xd8/0x140 kernel/locking/spinlock.c:194
Code: 9c 8f 44 24 20 42 80 3c 23 00 74 08 4c 89 f7 e8 8e 17 6b f6 f6 44 24 21 02 75 52 41 f7 c7 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> 53 d8 d4 f5 65 8b 05 64 0f 73 74 85 c0 74 43 48 c7 04 24 0e 36
RSP: 0018:ffffc9000af86b60 EFLAGS: 00000206
RAX: 83a97af55935d700 RBX: 1ffff920015f0d70 RCX: ffffffff8172da6a
RDX: dffffc0000000000 RSI: ffffffff8bcabb40 RDI: 0000000000000001
RBP: ffffc9000af86bf0 R08: ffffffff92fa763f R09: 1ffffffff25f4ec7
R10: dffffc0000000000 R11: fffffbfff25f4ec8 R12: dffffc0000000000
R13: 1ffff920015f0d6c R14: ffffc9000af86b80 R15: 0000000000000246
 debug_object_activate+0x3e4/0x510 lib/debugobjects.c:726
 debug_rcu_head_queue kernel/rcu/rcu.h:227 [inline]
 kvfree_call_rcu+0x99/0x790 kernel/rcu/tree.c:3772
 cfg80211_update_known_bss+0xb39/0x1500 net/wireless/scan.c:1862
 __cfg80211_bss_update+0x150/0x20c0 net/wireless/scan.c:1908
 cfg80211_inform_single_bss_data+0xfd6/0x2360 net/wireless/scan.c:2289
 cfg80211_inform_bss_data+0x3dd/0x5a70 net/wireless/scan.c:3117
 cfg80211_inform_bss_frame_data+0x3bc/0x720 net/wireless/scan.c:3207
 ieee80211_bss_info_update+0x8a7/0xbc0 net/mac80211/scan.c:226
 ieee80211_rx_bss_info net/mac80211/ibss.c:1099 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1578 [inline]
 ieee80211_ibss_rx_queued_mgmt+0x1962/0x2d70 net/mac80211/ibss.c:1605
 ieee80211_iface_process_skb net/mac80211/iface.c:1603 [inline]
 ieee80211_iface_work+0x8a3/0xf10 net/mac80211/iface.c:1657
 cfg80211_wiphy_work+0x223/0x260 net/wireless/core.c:437
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0xa2e/0x1830 kernel/workqueue.c:3329
 worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
----------------
Code disassembly (best guess):
   0:	9c                   	pushf
   1:	8f 44 24 20          	pop    0x20(%rsp)
   5:	42 80 3c 23 00       	cmpb   $0x0,(%rbx,%r12,1)
   a:	74 08                	je     0x14
   c:	4c 89 f7             	mov    %r14,%rdi
   f:	e8 8e 17 6b f6       	call   0xf66b17a2
  14:	f6 44 24 21 02       	testb  $0x2,0x21(%rsp)
  19:	75 52                	jne    0x6d
  1b:	41 f7 c7 00 02 00 00 	test   $0x200,%r15d
  22:	74 01                	je     0x25
  24:	fb                   	sti
  25:	bf 01 00 00 00       	mov    $0x1,%edi
* 2a:	e8 53 d8 d4 f5       	call   0xf5d4d882 <-- trapping instruction
  2f:	65 8b 05 64 0f 73 74 	mov    %gs:0x74730f64(%rip),%eax        # 0x74730f9a
  36:	85 c0                	test   %eax,%eax
  38:	74 43                	je     0x7d
  3a:	48                   	rex.W
  3b:	c7                   	.byte 0xc7
  3c:	04 24                	add    $0x24,%al
  3e:	0e                   	(bad)
  3f:	36                   	ss


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

