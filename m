Return-Path: <linux-kernel+bounces-260404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 087F393A87E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 23:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8717B284363
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 21:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2B6143C6B;
	Tue, 23 Jul 2024 21:07:23 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DE7140384
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 21:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721768843; cv=none; b=a4k8d836KaHO902NfgloydhDe65IBWY7QBPB4c8wQKCc4AEJoDStaw2IF74+bedDjpUowCiiYOf3/LbwtCkVwPn+3SkoDEVpWeeI05vNd/olbzfRAEF7/nh3CE5X12hTowHsGPHHX7UHssXpNmSNAVmhQsWrCPrMwIRmhQuF+Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721768843; c=relaxed/simple;
	bh=685U6xRrk9Niks7TMgxDEgbUAvN4igfvtzi3ttrZAVc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HOR10aLLXV2BRuHJtydO4ZTqxM1rB/O1nl6xzWHiLMIuZawVy+Ut2ZPAgxCqSc8aVS8Wylq56sIIt89icKQ00lzFGOUoAXTdQoYReBiFYrAkLNdAxd91qlRObBWiVOH6TRMQGUQ9nTuhy6MQNrXYDIphJ3P9/R8ujs4R3o1MP/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-396fa3fe46cso94049205ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 14:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721768841; x=1722373641;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oKV5entdyuyqCkhse82tfmI5Y8Iw8p8fgLMn5aF7LYY=;
        b=kNjOyksdAHOeR7SPo0kP+JrJwzByzvsJM5dCbtclAWVRCSK2zdnbaXqbrvK9y3ctnA
         biaRvdk0Wo+gMPtUOgCl/pZGFEuBUU5OF4uvZGjprs0gH9lQpC611kHF9rFVwlgoa8fG
         wp7m+YcO8ZQcb+3/i4Bx71rumK69uBN2DPFwiOdjDFqBah3/En4tH82/0JVNI3taw+oG
         9GSvu0w8dr6zVyL698xWsYiu2A4+I4tp0z+G23EhCOaQKr7uAU1j0EmUamZcdGtqnfRQ
         eRFgEHpWnk6twwLIp+51rKuBBDKA8RIa3cPCifA/YdeHwYkSBwOHKkuKLL08psUUhbz2
         SB4w==
X-Forwarded-Encrypted: i=1; AJvYcCVCN02nu0dj9pfKRGmLvDtWkIWCI1UPxtCxEC0tKLWdYNjE4wg6wfEDaWqT79EoLXC76irN8Kp/u40SbdVGPghtOg9So+pcjoEXCFrp
X-Gm-Message-State: AOJu0YyLbywg9b/5Wh3gckiFbLsLaj+RwE+u7fe1g/+WNMknz3WU9Z1y
	9EL4hnegmpcaf/lLa9PeGUrqAMIHqggei3ASugXd4l6RCA6qwpnc5tTTlSpRbx1Qux8HPrC+9sk
	r0kCNCuJCZicH8ICMXGcXT1Srt2c5X7t3+6Lxm6bhu2fghFm/DDoxabg=
X-Google-Smtp-Source: AGHT+IGOq8EnuxF1rGOzUtWxHbKmi2JXzjtZG9okOXvtLB9HPN2u675AX7s7VarmG0LWlBdKGL89eD3FO0hynT/rZyGv80d7trby
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d82:b0:382:feb2:2117 with SMTP id
 e9e14a558f8ab-398e8b665f5mr4955245ab.6.1721768841150; Tue, 23 Jul 2024
 14:07:21 -0700 (PDT)
Date: Tue, 23 Jul 2024 14:07:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000029981d061df08c8d@google.com>
Subject: [syzbot] [bluetooth?] KMSAN: uninit-value in hci_rx_work
From: syzbot <syzbot+6ea290ba76d8c1eb1ac2@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2c9b3512402e Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12628cad980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6bfb33a8ad10458f
dashboard link: https://syzkaller.appspot.com/bug?extid=6ea290ba76d8c1eb1ac2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9593db3ad921/disk-2c9b3512.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/77c4ed0c2bb7/vmlinux-2c9b3512.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b1e492f9354b/bzImage-2c9b3512.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6ea290ba76d8c1eb1ac2@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in hci_scodata_packet net/bluetooth/hci_core.c:3835 [inline]
BUG: KMSAN: uninit-value in hci_rx_work+0x10a8/0x1130 net/bluetooth/hci_core.c:4039
 hci_scodata_packet net/bluetooth/hci_core.c:3835 [inline]
 hci_rx_work+0x10a8/0x1130 net/bluetooth/hci_core.c:4039
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3312
 worker_thread+0xea5/0x1520 kernel/workqueue.c:3390
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3985 [inline]
 slab_alloc_node mm/slub.c:4028 [inline]
 kmem_cache_alloc_node_noprof+0x6bf/0xb80 mm/slub.c:4071
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:583
 __alloc_skb+0x363/0x7b0 net/core/skbuff.c:674
 alloc_skb include/linux/skbuff.h:1320 [inline]
 bt_skb_alloc include/net/bluetooth/bluetooth.h:493 [inline]
 vhci_get_user drivers/bluetooth/hci_vhci.c:489 [inline]
 vhci_write+0x128/0x910 drivers/bluetooth/hci_vhci.c:609
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xb2f/0x1550 fs/read_write.c:590
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __ia32_sys_write+0x91/0xe0 fs/read_write.c:652
 ia32_sys_call+0x2e34/0x40d0 arch/x86/include/generated/asm/syscalls_32.h:5
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xb0/0x110 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/common.c:411
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:449
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

CPU: 1 PID: 5058 Comm: kworker/u9:6 Not tainted 6.10.0-syzkaller-11185-g2c9b3512402e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Workqueue: hci3 hci_rx_work
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

