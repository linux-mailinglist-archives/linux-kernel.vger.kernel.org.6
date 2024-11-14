Return-Path: <linux-kernel+bounces-409138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B53149C8858
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC12FB30F6C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 10:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F001F81AB;
	Thu, 14 Nov 2024 10:40:30 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D055118991E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 10:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731580829; cv=none; b=tfdXNjfN7shGqeHEh3OgcuYjjurViok1w6mR1MuHKsLX4oThFWyVvlg1jJRFKUINC4ExnBq7Y2zNNpUqH5N1W9eQWyo3tprEEIgQ2cmBCysc4mP8psP2jW6t0/rwdRe3W7PYVywX5Kafp1kEGsTy1WFZMsxR+2HGO5CfjEULVd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731580829; c=relaxed/simple;
	bh=hebrmXkhCY09OG8h8nGV0uOtICvEfbpG8iGrrMU9xw8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RDQ3nHwhyUV1wraEHntDmVJi8zeVqcliIEDHwH53xm6ZQ2hGunYO9gRnZdOPkotVCunB7f/ZQuVGJB7fWeUK8xNEajjabu9wb0spaK9PZ8+IJM2J/bHWeXrEzjxP3+AZnnTEFDnQoxPF+mdHFQ9ujMyOMW1jwgkn0fmmxvkYIZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a6ca616500so5265685ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 02:40:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731580827; x=1732185627;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EpQKVoCHR7S/IBsmhXUKOE1cWASKXA9mRVe4LwtSsA8=;
        b=PfjVOGzSxF1iuolNM4rFCzgJqold1BmccOWX0wQO2i++O+QP4Qh6zOWR/MXPMehwv/
         GFEhHXSK4KmzzGKOIQfIK4oJQNEY8LOOW2dC8JZxkzxpdkZT9T5s8HAqRnWhzuaZZBWj
         TiRD4/LRBW5BM/SVwZ3NZbDsQdO1YoYbmiFhgnwSawEAU8DbLy6yblwJhQ1fH2xlMwVp
         d37wougD67tPPsUpP42v1o3GSDKGWZbVt31WpVJPXq7C8DjxML5KgZ4GWMgJzC3HEAza
         +eg+o41Wx55oJyBy7NyamwMQqviI73f8ITGjeVxDkdTKd7xxAg84N78ZRyadcVMEmYDq
         SG+A==
X-Forwarded-Encrypted: i=1; AJvYcCX27VhSMYuzdJqn/PY9RiFan4HbtL5DawXs9VmJXznLtv+1bcjmNkVsTE+YqxCJyxG1Rb4bzzpaww/YtbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwEujU1WSibWuNlas5C2F0/OFDmmuu1hhQBGiYyYePqNqd4XmY
	6UUo7eY1au/LfldsxQodvpf6lbOgUxJg+DJVwBAHqPC70mb5VbI8n7s6qVzq4ZBlT5LXcRthHEE
	xh0wfZqkuYTrt2+uaL6ax1HdRpS342O1+pJgdjlCmciqJGHG+XPLvgYo=
X-Google-Smtp-Source: AGHT+IH38snHZpugJh/yH983zqKsVOwZbdixl4mY7r5cQJ5XXnavU66eqXKouJUw8ctrq6tpF+9BCwWKFI2IbH6enGPxVAT2H6GQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184d:b0:3a7:2b12:78dd with SMTP id
 e9e14a558f8ab-3a72b1279b5mr6172675ab.11.1731580826776; Thu, 14 Nov 2024
 02:40:26 -0800 (PST)
Date: Thu, 14 Nov 2024 02:40:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6735d39a.050a0220.1324f8.0096.GAE@google.com>
Subject: [syzbot] [net?] KMSAN: uninit-value in __vxlan_find_mac
From: syzbot <syzbot+35e7e2811bbe5777b20e@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    de2f378f2b77 Merge tag 'nfsd-6.12-4' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15b170c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e4580d62ee1893a5
dashboard link: https://syzkaller.appspot.com/bug?extid=35e7e2811bbe5777b20e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f0ff1d637186/disk-de2f378f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1515128a919f/vmlinux-de2f378f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6624bf235bc6/bzImage-de2f378f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+35e7e2811bbe5777b20e@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in __vxlan_find_mac+0x497/0x4e0
 __vxlan_find_mac+0x497/0x4e0
 vxlan_find_mac drivers/net/vxlan/vxlan_core.c:436 [inline]
 vxlan_xmit+0x1669/0x39f0 drivers/net/vxlan/vxlan_core.c:2753
 __netdev_start_xmit include/linux/netdevice.h:4928 [inline]
 netdev_start_xmit include/linux/netdevice.h:4937 [inline]
 xmit_one net/core/dev.c:3588 [inline]
 dev_hard_start_xmit+0x247/0xa20 net/core/dev.c:3604
 __dev_queue_xmit+0x3562/0x56d0 net/core/dev.c:4432
 dev_queue_xmit include/linux/netdevice.h:3094 [inline]
 __bpf_tx_skb net/core/filter.c:2152 [inline]
 __bpf_redirect_common net/core/filter.c:2196 [inline]
 __bpf_redirect+0x148c/0x1610 net/core/filter.c:2203
 ____bpf_clone_redirect net/core/filter.c:2477 [inline]
 bpf_clone_redirect+0x37e/0x500 net/core/filter.c:2447
 ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:2010
 __bpf_prog_run512+0xc5/0xf0 kernel/bpf/core.c:2253
 bpf_dispatcher_nop_func include/linux/bpf.h:1265 [inline]
 __bpf_prog_run include/linux/filter.h:701 [inline]
 bpf_prog_run include/linux/filter.h:708 [inline]
 bpf_test_run+0x546/0xd20 net/bpf/test_run.c:434
 bpf_prog_test_run_skb+0x182f/0x24d0 net/bpf/test_run.c:1095
 bpf_prog_test_run+0x5e5/0xa30 kernel/bpf/syscall.c:4266
 __sys_bpf+0x6aa/0xd90 kernel/bpf/syscall.c:5671
 __do_sys_bpf kernel/bpf/syscall.c:5760 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5758 [inline]
 __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5758
 x64_sys_call+0x2cce/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:322
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4091 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_node_noprof+0x6bf/0xb80 mm/slub.c:4186
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:587
 pskb_expand_head+0x226/0x1a60 net/core/skbuff.c:2275
 skb_ensure_writable+0x496/0x520 net/core/skbuff.c:6214
 __bpf_try_make_writable net/core/filter.c:1677 [inline]
 bpf_try_make_writable net/core/filter.c:1683 [inline]
 bpf_try_make_head_writable net/core/filter.c:1691 [inline]
 ____bpf_clone_redirect net/core/filter.c:2471 [inline]
 bpf_clone_redirect+0x1c5/0x500 net/core/filter.c:2447
 ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:2010
 __bpf_prog_run512+0xc5/0xf0 kernel/bpf/core.c:2253
 bpf_dispatcher_nop_func include/linux/bpf.h:1265 [inline]
 __bpf_prog_run include/linux/filter.h:701 [inline]
 bpf_prog_run include/linux/filter.h:708 [inline]
 bpf_test_run+0x546/0xd20 net/bpf/test_run.c:434
 bpf_prog_test_run_skb+0x182f/0x24d0 net/bpf/test_run.c:1095
 bpf_prog_test_run+0x5e5/0xa30 kernel/bpf/syscall.c:4266
 __sys_bpf+0x6aa/0xd90 kernel/bpf/syscall.c:5671
 __do_sys_bpf kernel/bpf/syscall.c:5760 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5758 [inline]
 __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5758
 x64_sys_call+0x2cce/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:322
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 8041 Comm: syz.2.760 Not tainted 6.12.0-rc6-syzkaller-00279-gde2f378f2b77 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
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

