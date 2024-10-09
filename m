Return-Path: <linux-kernel+bounces-357748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9C3997529
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 20:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02770B22125
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5CB1E0E18;
	Wed,  9 Oct 2024 18:55:29 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F397198A0D
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 18:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728500128; cv=none; b=U/KvStU1RwM6fBi+ZThA/3PFQj6KHwCEjPGMAfeoLkyvb7wwGUydik6OfWxpQ8PzE5qe4s3U2bFQfGbEA6z1R2yDRB/eyzefMHX2xemK1ISJetBDW38RNP4z7sZYRA+pi66BMFnR373EtnYKsnRtorFeSZMfzdm7w3Jf6FGs+zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728500128; c=relaxed/simple;
	bh=ILzxRfAfHH+xFxX/Cf2A8zfeKsIelMpNCaO2Sz59Nuo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gWyaX1UGtpafjcCMtw8xlkqvTzDDIiTJb9h7GlWeBFAY4znHS6D3XVLU71KEkUQIWxXtb6DzkS5ZvIapk2w3OpX1ui8wu1IoM7joaE3TVD6JPHURA4RPjYyf2wlMitHArEAhwkGF4SkVXZssi9hqgPjx5Km/JDaPTrSlx3lcDKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a0ce4692a4so1334935ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 11:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728500126; x=1729104926;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a2xYr9xVFTAqHGtSEFJ/Xyk8Q+Pr3Bx5SlYvO23peo0=;
        b=eaB54/i4kr5mfimwV6Ei0UHielLoTmX7MiRk3NStydgr5aEeKuTvK+wq4hjfg62qUz
         FTLTIYAolpfWGh2yHEoa30a3ZUWcFcw9DVy/anVMGPKTZNs41dUPXjJ7wlBnrFirsARJ
         lht/n7CoBy7V0RHozuTQZTGKHhKJyL1485DlFXsjUjlE5nP1YYwrbAADU+YH9hP1/q+x
         J4Z6itS3mcuV8vE3YQ6ldqh4LEerSWwD4I82Gcm0jbLbpnOPqZc7iTHrlfNttfXikZpf
         ywEdNiJ6Nunf0M6+pbC9chIgJbLWjtUODVdJznjApO557+7yjWN4i7uzZ/gE9ruv2LWK
         /2GQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHwD2lZSAFX1qX6Ux0QsaILNYK5iWgso2FyAe7qRoNxPBjjNYyICc5u0JU/3G6H+MhAz6vXAs0OF9wxU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwY/LOoU7O8sS9s5B7OCajomty6eivdkCczbZl2JqAeHhM2LBj
	8U6WvZ6MPxcx86UJ/vU1jP6dfdQtc9b11a0GnT2A+YnFAAp+fl+Xlty+5hCe5ct8jw3nGIBHmEP
	EYGVzKeEsKe7bee+3Jjc9qmSaJLhVXjAtM+1jvEYbIZPvFkxrnM6/Tng=
X-Google-Smtp-Source: AGHT+IGLOxW5BdtEIwtH55sohFj4cFtR4kcnA7LSXITw8dpGaVFOY7jGpS74atxt8WWhBllMLxZDbnJ+XFvS2f9IJ/aQERLSu6Sg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1949:b0:3a2:762b:faf0 with SMTP id
 e9e14a558f8ab-3a3a70d7681mr3916065ab.11.1728500126434; Wed, 09 Oct 2024
 11:55:26 -0700 (PDT)
Date: Wed, 09 Oct 2024 11:55:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6706d19e.050a0220.67064.0050.GAE@google.com>
Subject: [syzbot] [ppp?] KMSAN: uninit-value in ppp_async_push (4)
From: syzbot <syzbot+1d121645899e7692f92a@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1868f9d0260e Merge tag 'for-linux-6.12-ofs1' of git://git...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13730e07980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=acaa65be5f19fc5a
dashboard link: https://syzkaller.appspot.com/bug?extid=1d121645899e7692f92a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=127f8080580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14b86c27980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/51af83d2907b/disk-1868f9d0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4cd235c942a6/vmlinux-1868f9d0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a321106ef897/bzImage-1868f9d0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1d121645899e7692f92a@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in ppp_async_encode drivers/net/ppp/ppp_async.c:545 [inline]
BUG: KMSAN: uninit-value in ppp_async_push+0xb4f/0x2660 drivers/net/ppp/ppp_async.c:675
 ppp_async_encode drivers/net/ppp/ppp_async.c:545 [inline]
 ppp_async_push+0xb4f/0x2660 drivers/net/ppp/ppp_async.c:675
 ppp_async_send+0x130/0x1b0 drivers/net/ppp/ppp_async.c:634
 ppp_channel_bridge_input drivers/net/ppp/ppp_generic.c:2280 [inline]
 ppp_input+0x1f1/0xe60 drivers/net/ppp/ppp_generic.c:2304
 pppoe_rcv_core+0x1d3/0x720 drivers/net/ppp/pppoe.c:379
 sk_backlog_rcv+0x13b/0x420 include/net/sock.h:1113
 __release_sock+0x1da/0x330 net/core/sock.c:3072
 release_sock+0x6b/0x250 net/core/sock.c:3626
 pppoe_sendmsg+0x2b8/0xb90 drivers/net/ppp/pppoe.c:903
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x30f/0x380 net/socket.c:745
 ____sys_sendmsg+0x903/0xb60 net/socket.c:2603
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2657
 __sys_sendmmsg+0x3be/0x950 net/socket.c:2743
 __do_sys_sendmmsg net/socket.c:2772 [inline]
 __se_sys_sendmmsg net/socket.c:2769 [inline]
 __x64_sys_sendmmsg+0xbc/0x120 net/socket.c:2769
 x64_sys_call+0xb6e/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:308
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4092 [inline]
 slab_alloc_node mm/slub.c:4135 [inline]
 kmem_cache_alloc_node_noprof+0x6bf/0xb80 mm/slub.c:4187
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:587
 __alloc_skb+0x363/0x7b0 net/core/skbuff.c:678
 alloc_skb include/linux/skbuff.h:1322 [inline]
 sock_wmalloc+0xfe/0x1a0 net/core/sock.c:2732
 pppoe_sendmsg+0x3a7/0xb90 drivers/net/ppp/pppoe.c:867
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x30f/0x380 net/socket.c:745
 ____sys_sendmsg+0x903/0xb60 net/socket.c:2603
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2657
 __sys_sendmmsg+0x3be/0x950 net/socket.c:2743
 __do_sys_sendmmsg net/socket.c:2772 [inline]
 __se_sys_sendmmsg net/socket.c:2769 [inline]
 __x64_sys_sendmmsg+0xbc/0x120 net/socket.c:2769
 x64_sys_call+0xb6e/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:308
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 5200 Comm: syz-executor848 Not tainted 6.11.0-syzkaller-07462-g1868f9d0260e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
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

