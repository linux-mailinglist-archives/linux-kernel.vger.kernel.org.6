Return-Path: <linux-kernel+bounces-234419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B3591C66B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB66D1F217B0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 19:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0936F2E7;
	Fri, 28 Jun 2024 19:11:27 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06FE54662
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 19:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719601887; cv=none; b=Ulmyf3OCmVt1+lYfPyTAYHQ91W6cR4PuvYkA1v9PZtWjYTR2EXqA8EM3Tp+3rknkLc8G+SkIw7gqeFUgCgUJd8fsjbUiRfef0fgqMz0+LrTzwRU4+neVOQPUlPt8nwj5yf0zO62qxAYzApuOhDlqcZJEsyk9+hznDT+4D/RT6VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719601887; c=relaxed/simple;
	bh=wFzgCRFd8siRimBjoFV4ItZQbSjPKRNPg606qE6IJD8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=J3sAbWExZbb/2Pxwk4VJHvDzxgfyPyPij4HTSUV/LIKDuxTuRaPqtgYiToOjL7UPGill3PepMrHOFLG5EBcrITlj4BYWGDZRsy8wLAa6GKoqT4k2NnXcmizyZ/9tBTU4+xPSE5arvyAZzga/GMpEvU5e1ODHSgHx5yYCAtAuJmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-37714b7f378so11286595ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 12:11:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719601885; x=1720206685;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/hoVeAj2C8prfsKLK5imkQWrZU/n0oVcLXZLPyc0dMI=;
        b=Uj2/Ppj2z4D/vOvdS8ytg1GyKKHieYXnOMPD596D384Jx+KIGb6iPRL9abXWKJA2AD
         hO0RWPbZ/pHVrNez/JHrS3MCYbbJ84lP7DNyQ14zgRZZDG/PHAf8ddWDQZ0PygRUY0rp
         QSeb2oNrys8xo9nXaL/rhzvPI19plJB/7X3pBCz0vY80ubdyPPuNiam/Em8gcE7hROsk
         WIvT2F/jm+ysalIbgMzwHPXVz2sRBosFb5vCy+pZZND14oA87YtcHzVVtr/wu4C0rJjD
         04NJNE99pE/OIuqtGv/OwB++ZihaBM9pCblD4T+7BDReRwnHP0VMSua2S0usA2svfQOq
         dYIg==
X-Forwarded-Encrypted: i=1; AJvYcCW48V+8H1+qoJLfocUGVOnKHbFkqy7JLO+/P1I+nAXCjkHFxYnUeMjtO/ep7VMVemUdIHqg9y0PJp7bh95M18KqH/vXLSmMsO4ADl/Q
X-Gm-Message-State: AOJu0YxpTHAwJSLRito9/VtofMP4RQ2Pa/NZacSfs+jp9DZzgvX6yuPM
	NYQ04R/GBM3nXBxPz1aZ2F2glmLds7XexZ9nSL5I3A2buD1xx+KJF593eELLW+FWzGXCrg5Ff7C
	GLrq3On8AcgBlF10XShYXd4LPTM0d0/ezAEcLH8avZO/CpSuvU7zYgus=
X-Google-Smtp-Source: AGHT+IGOk+K3c9GsS+3ej5hvlIIRgseFL/KQptry+4h5mmexqMtwpW7bp2cbnXDhZffrVtDs1Bg+Zy0uhVn9duDi62FaBkOjk2fn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c05:b0:36c:5c1b:2051 with SMTP id
 e9e14a558f8ab-3763f73e127mr13566545ab.6.1719601885178; Fri, 28 Jun 2024
 12:11:25 -0700 (PDT)
Date: Fri, 28 Jun 2024 12:11:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000857d35061bf803c4@google.com>
Subject: [syzbot] [virt?] [net?] upstream test error: KMSAN: uninit-value in virtnet_poll
From: syzbot <syzbot+35b9a14142dd62084eb9@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, eperezma@redhat.com, 
	jasowang@redhat.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	mst@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    626737a5791b Merge tag 'pinctrl-v6.10-2' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1373f72e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12ff58d525e7b8f9
dashboard link: https://syzkaller.appspot.com/bug?extid=35b9a14142dd62084eb9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b5c2e4152e89/disk-626737a5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4847a4cfa180/vmlinux-626737a5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/18f05d5ddcb1/bzImage-626737a5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+35b9a14142dd62084eb9@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in receive_mergeable drivers/net/virtio_net.c:1847 [inline]
BUG: KMSAN: uninit-value in receive_buf+0x2620/0x6070 drivers/net/virtio_net.c:1973
 virtnet_receive drivers/net/virtio_net.c:2277 [inline]
 virtnet_poll+0xd1c/0x23c0 drivers/net/virtio_net.c:2380
 __napi_poll+0xe7/0x980 net/core/dev.c:6722
 handle_softirqs+0x1ce/0x800 kernel/softirq.c:554
 common_interrupt+0x94/0xa0 arch/x86/kernel/irq.c:278
 asm_common_interrupt+0x2b/0x40 arch/x86/include/asm/idtentry.h:693
 kmsan_get_metadata+0x189/0x1d0
 kmsan_get_shadow_origin_ptr+0x4d/0xb0 mm/kmsan/shadow.c:102
 get_shadow_origin_ptr mm/kmsan/instrumentation.c:36 [inline]
 __msan_metadata_ptr_for_load_8+0x24/0x40 mm/kmsan/instrumentation.c:92
 unwind_get_return_address_ptr+0x6a/0x100 arch/x86/kernel/unwind_frame.c:28
 update_stack_state+0x206/0x270 arch/x86/kernel/unwind_frame.c:251
 unwind_next_frame+0x19a/0x470 arch/x86/kernel/unwind_frame.c:315
 arch_stack_walk+0x1ec/0x2d0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0xaa/0xe0 kernel/stacktrace.c:122
 kmsan_save_stack_with_flags mm/kmsan/core.c:74 [inline]
 kmsan_internal_poison_memory+0x49/0x90 mm/kmsan/core.c:58
 kmsan_slab_alloc+0xdf/0x160 mm/kmsan/hooks.c:68
 slab_post_alloc_hook mm/slub.c:3947 [inline]
 slab_alloc_node mm/slub.c:4001 [inline]
 __do_kmalloc_node mm/slub.c:4121 [inline]
 __kmalloc_noprof+0x660/0xf30 mm/slub.c:4135
 kmalloc_noprof include/linux/slab.h:664 [inline]
 tomoyo_realpath_from_path+0x104/0xaa0 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x1ef/0xc50 security/tomoyo/file.c:771
 tomoyo_file_open+0x271/0x360 security/tomoyo/tomoyo.c:334
 security_file_open+0x9a/0xc60 security/security.c:2962
 do_dentry_open+0x5b1/0x22b0 fs/open.c:942
 vfs_open+0x49/0x60 fs/open.c:1089
 do_open fs/namei.c:3650 [inline]
 path_openat+0x4ab0/0x5b70 fs/namei.c:3807
 do_filp_open+0x20e/0x590 fs/namei.c:3834
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1405
 do_sys_open fs/open.c:1420 [inline]
 __do_sys_openat fs/open.c:1436 [inline]
 __se_sys_openat fs/open.c:1431 [inline]
 __x64_sys_openat+0x2a1/0x310 fs/open.c:1431
 x64_sys_call+0x128b/0x3b90 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __alloc_pages_noprof+0x9d6/0xe70 mm/page_alloc.c:4701
 alloc_pages_mpol_noprof+0x299/0x990 mm/mempolicy.c:2265
 alloc_pages_noprof+0x1bf/0x1e0 mm/mempolicy.c:2336
 skb_page_frag_refill+0x2bf/0x7c0 net/core/sock.c:2920
 virtnet_rq_alloc+0x43/0xbb0 drivers/net/virtio_net.c:882
 add_recvbuf_mergeable drivers/net/virtio_net.c:2128 [inline]
 try_fill_recv+0x3f0/0x2f50 drivers/net/virtio_net.c:2173
 virtnet_open+0x1cc/0xb00 drivers/net/virtio_net.c:2452
 __dev_open+0x546/0x6f0 net/core/dev.c:1472
 __dev_change_flags+0x309/0x9a0 net/core/dev.c:8781
 dev_change_flags+0x8e/0x1d0 net/core/dev.c:8853
 devinet_ioctl+0x13ec/0x22c0 net/ipv4/devinet.c:1177
 inet_ioctl+0x4bd/0x6d0 net/ipv4/af_inet.c:1003
 sock_do_ioctl+0xb7/0x540 net/socket.c:1222
 sock_ioctl+0x727/0xd70 net/socket.c:1341
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0x261/0x450 fs/ioctl.c:893
 __x64_sys_ioctl+0x96/0xe0 fs/ioctl.c:893
 x64_sys_call+0x18c0/0x3b90 arch/x86/include/generated/asm/syscalls_64.h:17
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 PID: 4794 Comm: rm Not tainted 6.10.0-rc5-syzkaller-00012-g626737a5791b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
=====================================================


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

