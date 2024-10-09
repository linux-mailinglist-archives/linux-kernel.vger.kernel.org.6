Return-Path: <linux-kernel+bounces-356631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DC199645D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FE3A1F229CA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B34189520;
	Wed,  9 Oct 2024 09:03:26 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C226487AE
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 09:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728464605; cv=none; b=BwdQxuwso9p6UN5UZ13k8BaSrppqQ+fRyEvDIp91GQVA5Lw6e6y4wC87dVKLIlvT0S2iuA18vOaLcMqYKTza91dPCiVfiapwJ8bQm0YM5dFrBsDotpRtMkwJXwz4fMa6GeUVBxxEusbQ7xlaXP0b5aaK160xWe4QG0nIbqqcXSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728464605; c=relaxed/simple;
	bh=4RxzKt9AdiqrZ3Sgb4kWJgk0XPTLw5NWgV4yIMXAUuE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=K2MItRawWcCLliHSCU3QxoTQVvatJKLbNB1CMjzC2qtK2lyjOzrqPt0MRTYzZY6mLTArqkNX8jTG3JMq4ayOv7rY1ySjF5g/jVX3LV67jIK6H9ugJH0vUAQItF4Cgruz6+4dNeVZTdMnu167rKmD1o3ef0KXNq11pJZ/Z1LDb1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a1925177fdso76776505ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 02:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728464603; x=1729069403;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3mgEOmnUX6coHhgRX9RRDK0ny28wu1T0TEIt8tmjoOA=;
        b=vmisb70zbxENUVXW07x1U3t8oDd/6xPXzo6f4B6sPWWcYiL1KV9YE1wLcr5q9odw9r
         AptXKFw/2baO3oeFmUKaLGMfL7p1cvuEwZdlu3W65oG+mQFyHXnL6B6OD43Bud4a1gKV
         8dMzJaLLhjVwhuRVjXYd0Tg0mB+gZRTNjw0j96WRK4sl7xLyf3f6O+GDtxY6GGrT6WcW
         zGPMsO+v44z9zdGnDKs7UB9U3KgE0paEmNpBjiiwaQLUJ6uNB0lWPHkrVxwOhQdxRq6/
         IeXeOeHjzn3HV/BwKjJ6m8f2T3NTtwyXX6MU6rBhDjxS05JZHyL7CqS03qPwpSaiSd6D
         4yGA==
X-Forwarded-Encrypted: i=1; AJvYcCXHs9sJVL5tTFBbZqvpL8RxG3gmtR2o4FoxeTzE/Cy2yJTCbyd7as5zcn5eWNg3+u5pikyFPx/iSdtTAoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHttg39h+oXi9vAEWudWlsxe6oLq1D1ldaMeTvb54LkbAiu3o9
	jVrOREsdLQLVKiTtcRx0kMsrHHwmbesxvjytRGIUhsdFnPAmW8QrTfjzpyBUoHRSEOPDeNeKPx9
	sEkrX/oLf5QWmyvUCZsh8C+lmPDOmoZwVm2TU0dh6TlPU6GhzSmuZY9k=
X-Google-Smtp-Source: AGHT+IG2Y/mzwL7g8buGQB9p0laeAgoTLzgQRjxMTrpLxXfKzCwD8bWUHXS6VxKVCilDHO0poIXZHGMGfhKyBifP7/ZX2bN7KOxk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16c8:b0:3a3:6b5d:7011 with SMTP id
 e9e14a558f8ab-3a397d10f3amr19353465ab.19.1728464603496; Wed, 09 Oct 2024
 02:03:23 -0700 (PDT)
Date: Wed, 09 Oct 2024 02:03:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670646db.050a0220.3f80e.0027.GAE@google.com>
Subject: [syzbot] [net?] KMSAN: uninit-value in slhc_remember
From: syzbot <syzbot+2ada1bc857496353be5a@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5b7c893ed5ed Merge tag 'ntfs3_for_6.12' of https://github...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=131de327980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=981fe2ff8a1e457a
dashboard link: https://syzkaller.appspot.com/bug?extid=2ada1bc857496353be5a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6bb953eff17f/disk-5b7c893e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0e63ae322aa8/vmlinux-5b7c893e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a0ed59d4302c/bzImage-5b7c893e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2ada1bc857496353be5a@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in slhc_remember+0x2e8/0x7b0 drivers/net/slip/slhc.c:666
 slhc_remember+0x2e8/0x7b0 drivers/net/slip/slhc.c:666
 ppp_receive_nonmp_frame+0xe45/0x35e0 drivers/net/ppp/ppp_generic.c:2455
 ppp_receive_frame drivers/net/ppp/ppp_generic.c:2372 [inline]
 ppp_do_recv+0x65f/0x40d0 drivers/net/ppp/ppp_generic.c:2212
 ppp_input+0x7dc/0xe60 drivers/net/ppp/ppp_generic.c:2327
 pppoe_rcv_core+0x1d3/0x720 drivers/net/ppp/pppoe.c:379
 sk_backlog_rcv+0x13b/0x420 include/net/sock.h:1113
 __release_sock+0x1da/0x330 net/core/sock.c:3072
 release_sock+0x6b/0x250 net/core/sock.c:3626
 pppoe_sendmsg+0x2b8/0xb90 drivers/net/ppp/pppoe.c:903
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x30f/0x380 net/socket.c:744
 ____sys_sendmsg+0x903/0xb60 net/socket.c:2602
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2656
 __sys_sendmmsg+0x3c1/0x960 net/socket.c:2742
 __do_sys_sendmmsg net/socket.c:2771 [inline]
 __se_sys_sendmmsg net/socket.c:2768 [inline]
 __x64_sys_sendmmsg+0xbc/0x120 net/socket.c:2768
 x64_sys_call+0xb6e/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:308
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4091 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_node_noprof+0x6bf/0xb80 mm/slub.c:4186
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:587
 __alloc_skb+0x363/0x7b0 net/core/skbuff.c:678
 alloc_skb include/linux/skbuff.h:1322 [inline]
 sock_wmalloc+0xfe/0x1a0 net/core/sock.c:2732
 pppoe_sendmsg+0x3a7/0xb90 drivers/net/ppp/pppoe.c:867
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x30f/0x380 net/socket.c:744
 ____sys_sendmsg+0x903/0xb60 net/socket.c:2602
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2656
 __sys_sendmmsg+0x3c1/0x960 net/socket.c:2742
 __do_sys_sendmmsg net/socket.c:2771 [inline]
 __se_sys_sendmmsg net/socket.c:2768 [inline]
 __x64_sys_sendmmsg+0xbc/0x120 net/socket.c:2768
 x64_sys_call+0xb6e/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:308
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 11151 Comm: syz.3.1054 Not tainted 6.12.0-rc2-syzkaller-00050-g5b7c893ed5ed #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
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

