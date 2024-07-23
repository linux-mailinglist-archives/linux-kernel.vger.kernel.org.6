Return-Path: <linux-kernel+bounces-260472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7053993A9D2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 01:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 943001C22358
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 23:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A141494C4;
	Tue, 23 Jul 2024 23:29:24 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9F713D60E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 23:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721777363; cv=none; b=hJiz9SGr+SZRIFD1sJo+LolIoIlIX8UBrMz7p9D93HOgAKa+cZx0osnQy+/ABktusxOHCU5BLC5WrmZQHKuLaM6TKOYuxDCLlnBxz/4YFfFP1hmbOBY55ZuNnuwdGucS5fO1hTeJi6WxPc+CHwWRTQUODzvu6tjaF9YHhoktPnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721777363; c=relaxed/simple;
	bh=btQmXp997rHfopDxJqLqRE2lS4SLF859cV78VYX3T7I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pEqr2oNB4niQO/j2Ge4lkp7qYS0Dtt5B5Q3e59MLJAdZI6ED0+S0Wp70mQhvWw/7b+XF1vw9+Gn2AXegpOGSdIbsKDaaUPk6yxZA/2FzrCk3Bj3olHz8OhXbbu4aVDiI6nzYKFapGvrRB8Dy8+w4CUnOFUZ/oM5qrwDGGw1/1KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-398ae4327f1so4461525ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 16:29:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721777361; x=1722382161;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7CPUv4J4bFYQQItjpDDWxxLlV+KM5ll2OkVFGe2ZEvY=;
        b=mwvlQvy2AKT0Qts8Uh4t45r/CTBv6l2346LG9rbjNAwzuJQ3L2zpQwUrGcGik50QTv
         ZPT+JNmp3wnYr5w8zwicyzg+/gsasJYgujQ5XypNAVH2aCwouwM1VeYERiFdU5XliSzg
         bkYIF5fRtEB5cCAtF4xFtIA4iUo/xWTOx0Uh0n2YKOF+ccWN/8IF+3M4BwgL0rs9ej6N
         W0tAZO1umquxe+KYf+cW1ffBzAqsQ/Y6uNDvau3PdXif44zJ5IkuP+JhRRDtJkHgqyYC
         UkBR0th8PUFHAKOEdH2WLDE36oKcqWLVZV3sZLuRPjj2+gjJormKasKhEXO22r4ryG8G
         28Zw==
X-Gm-Message-State: AOJu0YzarJ3YLMSIoJtr2Oq7bVqQQ9m8bxgIlK0+eX+xQOEbH8jRwgFW
	Q2LnFvyOFa4pNKB3H2O3KoyTcqSSRYxHjv+mZpsAsFVvLMchpq6hy98t+ynGqLFwtKm5GQF3e4C
	NUKO0PZYltZQ2Auevno9A4xhXTP3unk/hfE157GmV0qQhPe1dBfeolPg=
X-Google-Smtp-Source: AGHT+IFKjtC8RcF4Nc0ZrFVi1RC47ZZKYMwCqMRNDuru/q3WjVphiX6I/O/rN4uLwyuZcBrnFJCN+HVSNLHM2XSdnizAyMLqt+OA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d13:b0:396:256a:2e01 with SMTP id
 e9e14a558f8ab-39a1a76dcb3mr104865ab.1.1721777361290; Tue, 23 Jul 2024
 16:29:21 -0700 (PDT)
Date: Tue, 23 Jul 2024 16:29:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000000949c061df288c5@google.com>
Subject: [syzbot] [sound?] KMSAN: uninit-value in line6_midibuf_read
From: syzbot <syzbot+78eccfb8b3c9a85fc6c5@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, perex@perex.cz, 
	syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2c9b3512402e Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13b02fe9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6bfb33a8ad10458f
dashboard link: https://syzkaller.appspot.com/bug?extid=78eccfb8b3c9a85fc6c5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ee34ad980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1157b8ad980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f8543636ba6c/disk-2c9b3512.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/403c612b7ac5/vmlinux-2c9b3512.xz
kernel image: https://storage.googleapis.com/syzbot-assets/88dc686d170a/bzImage-2c9b3512.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+78eccfb8b3c9a85fc6c5@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in line6_midibuf_read+0x76b/0x1050 sound/usb/line6/midibuf.c:185
 line6_midibuf_read+0x76b/0x1050 sound/usb/line6/midibuf.c:185
 line6_data_received+0x4be/0x7e0 sound/usb/line6/driver.c:306
 __usb_hcd_giveback_urb+0x572/0x840 drivers/usb/core/hcd.c:1650
 usb_hcd_giveback_urb+0x157/0x720 drivers/usb/core/hcd.c:1734
 dummy_timer+0xd3f/0x6aa0 drivers/usb/gadget/udc/dummy_hcd.c:1987
 __run_hrtimer kernel/time/hrtimer.c:1689 [inline]
 __hrtimer_run_queues+0x564/0xe40 kernel/time/hrtimer.c:1753
 hrtimer_interrupt+0x3ab/0x1490 kernel/time/hrtimer.c:1815
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0xa6/0x3a0 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x7e/0x90 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1f/0x30 arch/x86/include/asm/idtentry.h:702
 __preempt_count_dec_and_test arch/x86/include/asm/preempt.h:94 [inline]
 rcu_read_unlock_sched include/linux/rcupdate.h:954 [inline]
 pfn_valid include/linux/mmzone.h:2032 [inline]
 kmsan_virt_addr_valid arch/x86/include/asm/kmsan.h:94 [inline]
 virt_to_page_or_null+0xf2/0x150 mm/kmsan/shadow.c:75
 kmsan_get_metadata+0x146/0x1d0 mm/kmsan/shadow.c:143
 kmsan_get_shadow_origin_ptr+0x4d/0xb0 mm/kmsan/shadow.c:102
 get_shadow_origin_ptr mm/kmsan/instrumentation.c:36 [inline]
 __msan_metadata_ptr_for_load_8+0x24/0x40 mm/kmsan/instrumentation.c:92
 on_stack+0x57/0x1b0
 update_stack_state+0xc1/0x270 arch/x86/kernel/unwind_frame.c:228
 unwind_next_frame+0x19a/0x470 arch/x86/kernel/unwind_frame.c:315
 arch_stack_walk+0x1ec/0x2d0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0xaa/0xe0 kernel/stacktrace.c:122
 kmsan_save_stack_with_flags mm/kmsan/core.c:74 [inline]
 kmsan_internal_chain_origin+0x57/0xd0 mm/kmsan/core.c:183
 __msan_chain_origin+0xc3/0x150 mm/kmsan/instrumentation.c:251
 skb_clone+0x460/0x550 net/core/skbuff.c:2066
 __tcp_transmit_skb+0x433/0x4880 net/ipv4/tcp_output.c:1312
 tcp_transmit_skb net/ipv4/tcp_output.c:1484 [inline]
 tcp_write_xmit+0x3a3d/0x8f00 net/ipv4/tcp_output.c:2829
 __tcp_push_pending_frames+0xc4/0x380 net/ipv4/tcp_output.c:3014
 tcp_push+0x755/0x7a0 net/ipv4/tcp.c:747
 tcp_sendmsg_locked+0x619d/0x6e20 net/ipv4/tcp.c:1322
 tcp_sendmsg+0x49/0x90 net/ipv4/tcp.c:1354
 inet_sendmsg+0x142/0x280 net/ipv4/af_inet.c:853
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x267/0x380 net/socket.c:745
 sock_write_iter+0x368/0x3d0 net/socket.c:1160
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xb2f/0x1550 fs/read_write.c:590
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 x64_sys_call+0x3490/0x3c10 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3985 [inline]
 slab_alloc_node mm/slub.c:4028 [inline]
 __do_kmalloc_node mm/slub.c:4148 [inline]
 __kmalloc_noprof+0x661/0xf30 mm/slub.c:4161
 kmalloc_noprof include/linux/slab.h:685 [inline]
 line6_midibuf_init+0x43/0x180 sound/usb/line6/midibuf.c:51
 line6_init_midi+0x3e7/0x670 sound/usb/line6/midi.c:284
 line6_init_cap_control+0x54e/0x770 sound/usb/line6/driver.c:704
 line6_probe+0xeae/0x1120 sound/usb/line6/driver.c:797
 pod_probe+0x79/0x90 sound/usb/line6/pod.c:522
 usb_probe_interface+0xd6f/0x1350 drivers/usb/core/driver.c:399
 really_probe+0x4db/0xd90 drivers/base/dd.c:656
 __driver_probe_device+0x2ab/0x5d0 drivers/base/dd.c:798
 driver_probe_device+0x72/0x890 drivers/base/dd.c:828
 __device_attach_driver+0x568/0x9e0 drivers/base/dd.c:956
 bus_for_each_drv+0x403/0x620 drivers/base/bus.c:457
 __device_attach+0x3c1/0x650 drivers/base/dd.c:1028
 device_initial_probe+0x32/0x40 drivers/base/dd.c:1077
 bus_probe_device+0x3dc/0x5c0 drivers/base/bus.c:532
 device_add+0x13aa/0x1ba0 drivers/base/core.c:3679
 usb_set_configuration+0x31c9/0x38d0 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0x109/0x2a0 drivers/usb/core/generic.c:254
 usb_probe_device+0x3a7/0x690 drivers/usb/core/driver.c:294
 really_probe+0x4db/0xd90 drivers/base/dd.c:656
 __driver_probe_device+0x2ab/0x5d0 drivers/base/dd.c:798
 driver_probe_device+0x72/0x890 drivers/base/dd.c:828
 __device_attach_driver+0x568/0x9e0 drivers/base/dd.c:956
 bus_for_each_drv+0x403/0x620 drivers/base/bus.c:457
 __device_attach+0x3c1/0x650 drivers/base/dd.c:1028
 device_initial_probe+0x32/0x40 drivers/base/dd.c:1077
 bus_probe_device+0x3dc/0x5c0 drivers/base/bus.c:532
 device_add+0x13aa/0x1ba0 drivers/base/core.c:3679
 usb_new_device+0x15f4/0x2470 drivers/usb/core/hub.c:2651
 hub_port_connect drivers/usb/core/hub.c:5521 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x4ff8/0x72d0 drivers/usb/core/hub.c:5903
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3312
 worker_thread+0xea5/0x1520 kernel/workqueue.c:3390
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

CPU: 0 PID: 5052 Comm: sshd Not tainted 6.10.0-syzkaller-11185-g2c9b3512402e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
=====================================================


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

