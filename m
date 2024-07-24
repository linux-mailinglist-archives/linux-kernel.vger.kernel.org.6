Return-Path: <linux-kernel+bounces-260855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3F393AF78
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 11:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A90BB1C20E77
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A431A155759;
	Wed, 24 Jul 2024 09:56:30 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9395A1553B7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 09:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721814990; cv=none; b=bxK8dLMGI8usLzJCD+oWuVa7EN2H/dR9KWv7weLZYkqCNLh7aJckr0C32kbqcXgDTMiOIyyGmgLIAqCrwUgvdXzxCjnUxZCZGFGBYcf6RJ6FKYvQccFyfdIfa9hn3nJtCtxIda3wZGzhNDQDPtr7c/fAWyI4b65jiAPOqBSPN2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721814990; c=relaxed/simple;
	bh=sSJLCMpFH4vbNlcph5k+qJH1dL2+EkN/efPxaTcBxEg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZAZxqD7MwyGouQm8vfRr5O4OXNg3BKfXGJDRRMmCOXlYIowNbxMINvQkvjQGzOwrFeipfiKfSE7tULt4YykLdrGQ/XbcHsTA4Zt9SwynR1B3lQyknz4hGSPuDy9dg2T4dHWij28QMR91tzEoOsUw38+Eysr3kdBxqCYogsnOcZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39817c86dc1so81359825ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 02:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721814988; x=1722419788;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hdqMFB8uU7ImQxxB9QwOMhmQOoKFRjkQMGl26VZ40N8=;
        b=wkwUN7SSvhjtK7RrBtpEEWFQCRT1cgK3d05oZfYpCQBktlEkpUhzPO7YfSXiF1WJp5
         rbxeW5YIDREJblGKOmB4NCqrHj54GgZpfKkyO8jWxS+wSJgCd+AhUL7zJibC7gpuUwbU
         5PY/Xy6sKhoVUsBPD/AplcXkrOuqgSGHpwbIx40WVlth8Q4VAzlAWvNkUG8HiWbuThhC
         bhtQ/fihcN2ktrf5qdmZ17UrZPDsnDJCeCfxA/SroOy4Q5E2kbiguZm2YUU3TuM3cQVX
         NHF9TCfFvqjn8B+revhZDERVacza9JRoEgGv3vgWJ2GaBuiktHP4ImJA7KrmwgXozbr3
         Orww==
X-Forwarded-Encrypted: i=1; AJvYcCXidtl1dn3kt+HVknlsqJvZ4S1GVkxVPEdoy2RJg8zvYvaTNr8i+TiCFDJMGy+YskT+J1PAdWKWXx2BQBpuNT95MwDXYmM05S1uWRLm
X-Gm-Message-State: AOJu0YyopnhRTOyTYXUwCT+hjDnqZBHbz9mGUCQUobcdeR6NicuG6bmf
	PY8Lw6lGts6x4kIKK5ZNse5fdMP08/VVGl4bpvMOZhl7QZgX/cQrD8+wClnJgoNSufOkShPrWA0
	QavR2mYRJ/hZMVCE2QOxExtY4JFEZfp37Nc6lQc5M5fGrQt94CzvDIsQ=
X-Google-Smtp-Source: AGHT+IFE6SauzGiVh0EvU29OaXhet+9HlqZNcn1TQUPiXceUvTTA+gknbOY5WhuK8nHg/x6b65FqoAkN14uPE802CUoACmpiyquu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8e:b0:380:fd76:29e4 with SMTP id
 e9e14a558f8ab-39a194fcb1cmr1038775ab.4.1721814987752; Wed, 24 Jul 2024
 02:56:27 -0700 (PDT)
Date: Wed, 24 Jul 2024 02:56:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b6d882061dfb4aa6@google.com>
Subject: [syzbot] [wireless?] KMSAN: uninit-value in cfg80211_inform_bss_frame_data
From: syzbot <syzbot+0f3afa93b91202f21939@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    933069701c1b Merge tag '6.11-rc-smb3-server-fixes' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=106cf811980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c062b3d00b275b52
dashboard link: https://syzkaller.appspot.com/bug?extid=0f3afa93b91202f21939
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/11dcaf5ed4bb/disk-93306970.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6b2d786e6c09/vmlinux-93306970.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c6cd729a2bbd/bzImage-93306970.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0f3afa93b91202f21939@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in cfg80211_find_elem_match net/wireless/scan.c:1364 [inline]
BUG: KMSAN: uninit-value in cfg80211_find_elem include/net/cfg80211.h:6858 [inline]
BUG: KMSAN: uninit-value in cfg80211_inform_bss_frame_data+0x3e3/0x9e0 net/wireless/scan.c:3225
 cfg80211_find_elem_match net/wireless/scan.c:1364 [inline]
 cfg80211_find_elem include/net/cfg80211.h:6858 [inline]
 cfg80211_inform_bss_frame_data+0x3e3/0x9e0 net/wireless/scan.c:3225
 ieee80211_bss_info_update+0x900/0xad0 net/mac80211/scan.c:226
 ieee80211_scan_rx+0x8f6/0xbd0 net/mac80211/scan.c:340
 __ieee80211_rx_handle_packet net/mac80211/rx.c:5225 [inline]
 ieee80211_rx_list+0x55c9/0x6690 net/mac80211/rx.c:5462
 ieee80211_rx_napi+0x84/0x3f0 net/mac80211/rx.c:5485
 ieee80211_rx include/net/mac80211.h:5124 [inline]
 ieee80211_handle_queued_frames+0x1a8/0x340 net/mac80211/main.c:439
 ieee80211_tasklet_handler+0x25/0x30 net/mac80211/main.c:458
 tasklet_action_common+0x395/0xd50 kernel/softirq.c:785
 tasklet_action+0x2d/0x40 kernel/softirq.c:811
 handle_softirqs+0x1ce/0x800 kernel/softirq.c:554
 __do_softirq+0x14/0x1a kernel/softirq.c:588
 do_softirq+0x9a/0x100 kernel/softirq.c:455
 __local_bh_enable_ip+0x9f/0xb0 kernel/softirq.c:382
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:908 [inline]
 __dev_queue_xmit+0x2692/0x5610 net/core/dev.c:4450
 dev_queue_xmit include/linux/netdevice.h:3105 [inline]
 __netlink_deliver_tap_skb net/netlink/af_netlink.c:307 [inline]
 __netlink_deliver_tap+0x84c/0xc90 net/netlink/af_netlink.c:325
 netlink_deliver_tap net/netlink/af_netlink.c:338 [inline]
 __netlink_sendskb net/netlink/af_netlink.c:1275 [inline]
 netlink_sendskb+0x23c/0x270 net/netlink/af_netlink.c:1284
 netlink_unicast+0x70e/0x1260 net/netlink/af_netlink.c:1372
 nlmsg_unicast include/net/netlink.h:1158 [inline]
 netlink_ack+0xb04/0xe80 net/netlink/af_netlink.c:2512
 netlink_rcv_skb+0x510/0x650 net/netlink/af_netlink.c:2556
 genl_rcv+0x40/0x60 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0xf52/0x1260 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x10da/0x11e0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x30f/0x380 net/socket.c:745
 __sys_sendto+0x685/0x830 net/socket.c:2204
 __do_sys_sendto net/socket.c:2216 [inline]
 __se_sys_sendto net/socket.c:2212 [inline]
 __x64_sys_sendto+0x125/0x1d0 net/socket.c:2212
 x64_sys_call+0x3799/0x3c10 arch/x86/include/generated/asm/syscalls_64.h:45
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3994 [inline]
 slab_alloc_node mm/slub.c:4037 [inline]
 kmem_cache_alloc_node_noprof+0x6bf/0xb80 mm/slub.c:4080
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:583
 __alloc_skb+0x363/0x7b0 net/core/skbuff.c:674
 alloc_skb include/linux/skbuff.h:1320 [inline]
 hwsim_cloned_frame_received_nl+0x311/0x1360 drivers/net/wireless/virtual/mac80211_hwsim.c:5850
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x1214/0x12c0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x375/0x650 net/netlink/af_netlink.c:2550
 genl_rcv+0x40/0x60 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0xf52/0x1260 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x10da/0x11e0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x30f/0x380 net/socket.c:745
 __sys_sendto+0x685/0x830 net/socket.c:2204
 __do_sys_sendto net/socket.c:2216 [inline]
 __se_sys_sendto net/socket.c:2212 [inline]
 __x64_sys_sendto+0x125/0x1d0 net/socket.c:2212
 x64_sys_call+0x3799/0x3c10 arch/x86/include/generated/asm/syscalls_64.h:45
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 9452 Comm: syz.4.940 Not tainted 6.10.0-syzkaller-11840-g933069701c1b #0
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

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

