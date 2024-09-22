Return-Path: <linux-kernel+bounces-335081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A144497E0D0
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 11:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC76E1C208AF
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 09:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B5413DDB9;
	Sun, 22 Sep 2024 09:57:24 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BF67DA83
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 09:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726999043; cv=none; b=jYivksIrl+Ht/xy+F2+hWEdmmdw5OLUsIJ9kuJSJ/84w863pDTrACCh4dTMUtGS8STkD7VZO2al+/s08zsNIZleufNbPAZs/30cMGhJ9sgdHAhBJJS/PofebAxYpW8JrWulAuBTVm1byIIThrhCO3AJ1mAYPFKsS+rqUop975c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726999043; c=relaxed/simple;
	bh=ZzRSJ8M+LaeAt9rZ3Kg/IHaxRUgGTiPGyTlbJ04Luyo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TMAx3bpdjbJUr7w139CvHpDh020e46x97qcqW0snmxNMoKz5dEt0KxUa8h0mpTSkZ/Vhs3eXEH/4mSfGEnLJPI7e/W/hsrJfeQI7ejWXP3oBGR9mCKWrEA3qYez9V0dTERQovv1Gb8+Q5oblO9aIodIojZr9dxdsfzL9lDqsM4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a0a71b7d90so49023065ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 02:57:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726999041; x=1727603841;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8MM4Pp4Tr16XtxlXuua1TFnUHS+16Pve1ppnYYoVUo0=;
        b=a6UpcSzeGyqg90biAFy93O9HAROsjb5OskM7DbT5U5VnUkROHr2yyjwt9dA5za51YR
         fsvJdjlQTpBZuWhZbawIA1zrb7yi5T5kym2CBxB++DmxaSOaf2bvRgHsi9eDfv4d26Rg
         py5SeDTx+mzAaRO3Y+oFcPyHGkCDfYCSzkAtqOh2gDgA9EiqWX07J9Kv3sBkvzdhN5+W
         o+Sj/YhvJff5bzXpfpUBPmBHICk/yQtMUGH7XLIyGz4cjaiwb3xf6uUm9UofxSH9fYYC
         DjrHI5FO5naNwlZwXw6MOqNV8ngrNovgyBW5nyVf/KkCnVfWIOnAsdTlOB14X9VYoucJ
         0QnQ==
X-Forwarded-Encrypted: i=1; AJvYcCV57CSp6aP23daVh7md92EDB8/DQtuTt90JPv85D71oYyrMGAuJUdYtln8fHKKp7VQqlb0sbX8yf5jlkOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEsx3KWT+asdNoEQQLbrhbez4sJ5Eql8KR3WU0agZ32pjYy7Kv
	jAUZg5oLQce/5Gd5qW07jPtgU+DSWZ9tLP9pD+SZ56WutgomIhb5aeabRE6ty0fTgZUfafxGtgc
	UQqAU+9E6p0sT+cUyEtfurFQitRADdZyUSQyfuIy/q74mjhFOYbLgM4U=
X-Google-Smtp-Source: AGHT+IG3xN1P6FKkYCjbJReYj/LyqpG5c5jeAcTR+cLA5TdFspR8fckhn46WBLLUXtuO43hFcxcZT47yGlEeDF5MOi98qvysDx+M
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b26:b0:3a0:a385:9128 with SMTP id
 e9e14a558f8ab-3a0c9cf9163mr63661855ab.6.1726999041218; Sun, 22 Sep 2024
 02:57:21 -0700 (PDT)
Date: Sun, 22 Sep 2024 02:57:21 -0700
In-Reply-To: <000000000000a53ecf061f700fbf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66efea01.050a0220.3195df.0097.GAE@google.com>
Subject: Re: [syzbot] [usb?] KMSAN: uninit-value in bcmp (3)
From: syzbot <syzbot+0399100e525dd9696764@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    88264981f208 Merge tag 'sched_ext-for-6.12' of git://git.k..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1559dca9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=547de13ee0a4d284
dashboard link: https://syzkaller.appspot.com/bug?extid=0399100e525dd9696764
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b7b080580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11c9de9f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d83fc781c223/disk-88264981.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1ed4c5969fba/vmlinux-88264981.xz
kernel image: https://storage.googleapis.com/syzbot-assets/76a67bd894be/bzImage-88264981.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0399100e525dd9696764@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in memcmp lib/string.c:665 [inline]
BUG: KMSAN: uninit-value in bcmp+0xc3/0x1c0 lib/string.c:697
 memcmp lib/string.c:665 [inline]
 bcmp+0xc3/0x1c0 lib/string.c:697
 iowarrior_callback+0x3fe/0xa30 drivers/usb/misc/iowarrior.c:185
 __usb_hcd_giveback_urb+0x572/0x840 drivers/usb/core/hcd.c:1650
 usb_hcd_giveback_urb+0x157/0x720 drivers/usb/core/hcd.c:1734
 dummy_timer+0xd3f/0x6aa0 drivers/usb/gadget/udc/dummy_hcd.c:1987
 __run_hrtimer kernel/time/hrtimer.c:1691 [inline]
 __hrtimer_run_queues+0x564/0xe40 kernel/time/hrtimer.c:1755
 hrtimer_interrupt+0x3ab/0x1490 kernel/time/hrtimer.c:1817
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1026 [inline]
 __sysvec_apic_timer_interrupt+0xa6/0x3a0 arch/x86/kernel/apic/apic.c:1043
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1037 [inline]
 sysvec_apic_timer_interrupt+0x40/0x90 arch/x86/kernel/apic/apic.c:1037
 asm_sysvec_apic_timer_interrupt+0x1f/0x30 arch/x86/include/asm/idtentry.h:702
 __msan_metadata_ptr_for_store_8+0x34/0x40 mm/kmsan/instrumentation.c:94
 ___bpf_prog_run+0x7f2a/0xe0f0
 __bpf_prog_run32+0xc2/0xf0 kernel/bpf/core.c:2251
 bpf_dispatcher_nop_func include/linux/bpf.h:1257 [inline]
 __bpf_prog_run include/linux/filter.h:701 [inline]
 bpf_prog_run include/linux/filter.h:708 [inline]
 bpf_prog_run_pin_on_cpu include/linux/filter.h:725 [inline]
 bpf_prog_run_clear_cb include/linux/filter.h:966 [inline]
 run_filter+0x150/0x3f0 net/packet/af_packet.c:2148
 packet_rcv+0x636/0x2050 net/packet/af_packet.c:2221
 deliver_skb net/core/dev.c:2239 [inline]
 deliver_ptype_list_skb net/core/dev.c:2254 [inline]
 __netif_receive_skb_core+0x53f9/0x6c90 net/core/dev.c:5613
 __netif_receive_skb_list_core+0x31e/0x1670 net/core/dev.c:5737
 __netif_receive_skb_list net/core/dev.c:5804 [inline]
 netif_receive_skb_list_internal+0x1085/0x1700 net/core/dev.c:5895
 gro_normal_list include/net/gro.h:515 [inline]
 napi_complete_done+0x42e/0x890 net/core/dev.c:6246
 virtqueue_napi_complete drivers/net/virtio_net.c:697 [inline]
 virtnet_poll+0x5cb8/0x6b30 drivers/net/virtio_net.c:2825
 __napi_poll+0xe7/0x980 net/core/dev.c:6771
 napi_poll net/core/dev.c:6840 [inline]
 net_rx_action+0xa5a/0x19b0 net/core/dev.c:6962
 handle_softirqs+0x1a0/0x7c0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0x68/0x120 kernel/softirq.c:637
 irq_exit_rcu+0x12/0x20 kernel/softirq.c:649
 common_interrupt+0x97/0xb0 arch/x86/kernel/irq.c:278
 asm_common_interrupt+0x2b/0x40 arch/x86/include/asm/idtentry.h:693
 kmsan_get_shadow_origin_ptr+0x4d/0xb0 mm/kmsan/shadow.c:102
 get_shadow_origin_ptr mm/kmsan/instrumentation.c:38 [inline]
 __msan_metadata_ptr_for_store_8+0x27/0x40 mm/kmsan/instrumentation.c:94
 unwind_next_frame+0x8d/0x360 arch/x86/kernel/unwind_frame.c:298
 arch_stack_walk+0x1ab/0x260 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0xaa/0xe0 kernel/stacktrace.c:122
 kmsan_save_stack_with_flags mm/kmsan/core.c:73 [inline]
 kmsan_internal_chain_origin+0x57/0xd0 mm/kmsan/core.c:182
 kmsan_internal_memmove_metadata+0x17b/0x230 mm/kmsan/core.c:138
 __msan_memcpy+0x108/0x1c0 mm/kmsan/instrumentation.c:200
 sock_write_iter+0x38b/0x3d0 net/socket.c:1167
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xb28/0x1540 fs/read_write.c:683
 ksys_write+0x20f/0x4c0 fs/read_write.c:736
 __do_sys_write fs/read_write.c:748 [inline]
 __se_sys_write fs/read_write.c:745 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:745
 x64_sys_call+0x306a/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4092 [inline]
 slab_alloc_node mm/slub.c:4135 [inline]
 __do_kmalloc_node mm/slub.c:4264 [inline]
 __kmalloc_noprof+0x661/0xf30 mm/slub.c:4277
 kmalloc_noprof include/linux/slab.h:882 [inline]
 kmalloc_array_noprof include/linux/slab.h:923 [inline]
 iowarrior_probe+0x10ea/0x1b90 drivers/usb/misc/iowarrior.c:836
 usb_probe_interface+0xd6f/0x1350 drivers/usb/core/driver.c:399
 really_probe+0x4db/0xd90 drivers/base/dd.c:657
 __driver_probe_device+0x2ab/0x5d0 drivers/base/dd.c:799
 driver_probe_device+0x72/0x890 drivers/base/dd.c:829
 __device_attach_driver+0x568/0x9e0 drivers/base/dd.c:957
 bus_for_each_drv+0x403/0x620 drivers/base/bus.c:457
 __device_attach+0x3c1/0x650 drivers/base/dd.c:1029
 device_initial_probe+0x32/0x40 drivers/base/dd.c:1078
 bus_probe_device+0x3dc/0x5c0 drivers/base/bus.c:532
 device_add+0x13aa/0x1ba0 drivers/base/core.c:3682
 usb_set_configuration+0x31c9/0x38d0 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0x109/0x2a0 drivers/usb/core/generic.c:254
 usb_probe_device+0x3a7/0x690 drivers/usb/core/driver.c:294
 really_probe+0x4db/0xd90 drivers/base/dd.c:657
 __driver_probe_device+0x2ab/0x5d0 drivers/base/dd.c:799
 driver_probe_device+0x72/0x890 drivers/base/dd.c:829
 __device_attach_driver+0x568/0x9e0 drivers/base/dd.c:957
 bus_for_each_drv+0x403/0x620 drivers/base/bus.c:457
 __device_attach+0x3c1/0x650 drivers/base/dd.c:1029
 device_initial_probe+0x32/0x40 drivers/base/dd.c:1078
 bus_probe_device+0x3dc/0x5c0 drivers/base/bus.c:532
 device_add+0x13aa/0x1ba0 drivers/base/core.c:3682
 usb_new_device+0x15f4/0x2470 drivers/usb/core/hub.c:2651
 hub_port_connect drivers/usb/core/hub.c:5521 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x4ffb/0x72d0 drivers/usb/core/hub.c:5903
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3310
 worker_thread+0xea7/0x14f0 kernel/workqueue.c:3391
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

CPU: 0 UID: 0 PID: 5170 Comm: sshd Not tainted 6.11.0-syzkaller-08481-g88264981f208 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

