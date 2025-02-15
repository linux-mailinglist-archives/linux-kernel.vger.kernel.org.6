Return-Path: <linux-kernel+bounces-516379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8094A37062
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 20:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B8831890592
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 19:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADC61EE019;
	Sat, 15 Feb 2025 19:26:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F2E1A9B58
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 19:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739647565; cv=none; b=Ycc/TAMyg5qIMzbwtXours+24+DRTxWIRlsJbnPpVVphjYNgS9SzC59h++uE+1Y+0O5n7KemduZHwppB9wkhunKThe0LZ84bOtfI5mbyozsNWmPlB/qj9SsE2Dn4xMBjeC7jM3MN1ntMhyElqmzVd1NmhdrobfKPMtCNaUqDX8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739647565; c=relaxed/simple;
	bh=QFDOIGqVG3OaK9BFd54IG1zfKf+O6oDDSIgyNKNCzgA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JWJ6RVYQLCOJIXdyT2kvXZabUKxE1jD5yr/kKL8nXIWMj0pI/nieIL11KAwtZJvWp6Grnp+Cb2cMmWQTsKdgqiQztI8fub6xRp8znwwA+AI58uawen1abBcFVgN6GS8ZehIk/RjV36Yc6c+PW8nAfqAUDPJ6K2YcCzgCRAUbNxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ce81a40f5cso53202045ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 11:26:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739647563; x=1740252363;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lge3+MFxdQLOEv6Bj71Qxa7coFnMI4tbf6hDS9EroMw=;
        b=sOrA9ddpwlni6SWPB1rv5KSoy4qKQXNV2poN4DdEgNZZ90oLfnJkyN0oMoOaSfcIiG
         Wn8XWDt6TA9BnJlbymSw0nEJ6jRowZtM2QbPkCDUcWZkcyHy4PeaPfb9WeeOj46MSHl8
         MmurEWYpV9UgTJUO9poQdd01DnuYrWehBeMnn6MImvJfXrdS8IRdgTzqj3Yo9b6PeZ+M
         vp6MRIBOhRYKzE8NC3nD60TRW7EZGO1SLaaQq/DaI8EQiCAHw+O7wwI0GbqUsNmRLC/Y
         f8ZMYGqunvNlW2kYI04ojLqMchvHivOG40ZZnHXH9h7x3qx35SswhXMISkLKQifJw+fI
         CIuQ==
X-Gm-Message-State: AOJu0Yxz3YI7354OL5S9LiwpZgcpuMgj9mjZkE+Z5Fz3KJm4j/6RrMZE
	NSbWWP05w1LQQE5+/puDNCi1OwXEH+UBPkP7x/7DgkXu7lbhjW+WcORJTwB/hGqQ+G60OuIcY8i
	uPvXQlBGUjz2HCgZko+TeunsFi8ZD4kMFitnUGTCkc15746z4UKfJ4nM=
X-Google-Smtp-Source: AGHT+IEOBwmkOW8eC0/vXf/t1gKhqh++QvK6SGC8gCG3M+aDBLiKH/aSYfYg7QUNPibHfRqwo5Sb3usTYGUQkGZlsbApA4sWp9qV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8b:b0:3cf:c8bf:3b87 with SMTP id
 e9e14a558f8ab-3d28076c338mr27686285ab.1.1739647563012; Sat, 15 Feb 2025
 11:26:03 -0800 (PST)
Date: Sat, 15 Feb 2025 11:26:02 -0800
In-Reply-To: <CAMp3bLV_i_7hQSmBH==x4EkDeKsfRdZD3FOnQj=278Lvi45P5w@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b0ea4a.050a0220.6f0b7.0019.GAE@google.com>
Subject: Re: [syzbot] [ppp?] KMSAN: uninit-value in ppp_sync_send (2)
From: syzbot <syzbot+29fc8991b0ecb186cf40@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, purvayeshi550@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in ppp_sync_send

=====================================================
BUG: KMSAN: uninit-value in ppp_sync_txmunge drivers/net/ppp/ppp_synctty.c:517 [inline]
BUG: KMSAN: uninit-value in ppp_sync_send+0x21c/0xb00 drivers/net/ppp/ppp_synctty.c:569
 ppp_sync_txmunge drivers/net/ppp/ppp_synctty.c:517 [inline]
 ppp_sync_send+0x21c/0xb00 drivers/net/ppp/ppp_synctty.c:569
 ppp_channel_bridge_input drivers/net/ppp/ppp_generic.c:2280 [inline]
 ppp_input+0x1f1/0xe60 drivers/net/ppp/ppp_generic.c:2304
 pppoe_rcv_core+0x1d3/0x720 drivers/net/ppp/pppoe.c:379
 sk_backlog_rcv+0x13b/0x420 include/net/sock.h:1122
 __release_sock+0x1da/0x330 net/core/sock.c:3106
 release_sock+0x6b/0x250 net/core/sock.c:3660
 pppoe_sendmsg+0xb35/0xc50 drivers/net/ppp/pppoe.c:903
 sock_sendmsg_nosec net/socket.c:718 [inline]
 __sock_sendmsg+0x30f/0x380 net/socket.c:733
 ____sys_sendmsg+0x903/0xb60 net/socket.c:2573
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2627
 __sys_sendmmsg+0x2ff/0x880 net/socket.c:2716
 __do_sys_sendmmsg net/socket.c:2743 [inline]
 __se_sys_sendmmsg net/socket.c:2740 [inline]
 __x64_sys_sendmmsg+0xbc/0x120 net/socket.c:2740
 x64_sys_call+0x33c2/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:308
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4121 [inline]
 slab_alloc_node mm/slub.c:4164 [inline]
 kmem_cache_alloc_node_noprof+0x907/0xe00 mm/slub.c:4216
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:587
 __alloc_skb+0x363/0x7b0 net/core/skbuff.c:678
 alloc_skb include/linux/skbuff.h:1331 [inline]
 sock_wmalloc+0xfe/0x1a0 net/core/sock.c:2746
 pppoe_sendmsg+0x385/0xc50 drivers/net/ppp/pppoe.c:867
 sock_sendmsg_nosec net/socket.c:718 [inline]
 __sock_sendmsg+0x30f/0x380 net/socket.c:733
 ____sys_sendmsg+0x903/0xb60 net/socket.c:2573
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2627
 __sys_sendmmsg+0x2ff/0x880 net/socket.c:2716
 __do_sys_sendmmsg net/socket.c:2743 [inline]
 __se_sys_sendmmsg net/socket.c:2740 [inline]
 __x64_sys_sendmmsg+0xbc/0x120 net/socket.c:2740
 x64_sys_call+0x33c2/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:308
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 6825 Comm: syz.0.16 Not tainted 6.14.0-rc2-syzkaller-00281-g496659003dac-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
=====================================================


Tested on:

commit:         49665900 Merge tag 'i2c-for-6.14-rc3' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1177e7df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=92e8820bdc5f2bf2
dashboard link: https://syzkaller.appspot.com/bug?extid=29fc8991b0ecb186cf40
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14dacbf8580000


