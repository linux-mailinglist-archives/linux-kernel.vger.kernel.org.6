Return-Path: <linux-kernel+bounces-513958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE66A350BD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E9EE1890AF2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BD426981F;
	Thu, 13 Feb 2025 21:56:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D60241673
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 21:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739483764; cv=none; b=pM8dj5AU+wnUHTSHVB65yzLuvwC0fI5IZNpWMszzRQvap6i+uZO2FNCRZE4OKEo6yYZeaV/yI5Mk+R4h27QK1/Tm2IvAOL3QC4oyC573WKgCDOP0kmUXaM4IqghuAQRrKBgL+JqIM4RDeatXnqf+fcWbfQqWOHX+4WZmerWh0II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739483764; c=relaxed/simple;
	bh=AcVFEZ5AOpRTySMcxzb7NunA5u/vltuRkowFk6iG0I0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GJIgsmOltvl50zZ2NmkjPkCeMVOyV1RnoNvr4a8QmDKa+9jVBwjqmDyIGEgSbh5mDM5K/GkbzKmpPDcl/RZViar5Qsf+FX425Snpm++2nrDtFpc94gsGUTCQAzWBaScql/hT7cF2g/cRbhfEcDS3XVFmfnoUIzgpD7Xc2aUUYXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ce3bbb2b9dso9261125ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 13:56:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739483762; x=1740088562;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XZLr94bZ+qtGEGXiAisgsopInXXV2Gu6e50W3A6RE8c=;
        b=tgXL+0ATa5AI7Edls+6qYeZ6fL/xGMCmJjZWsv03ISloVsjVHwUM/bQiE3ry5lMD5c
         GzcY8dzYwKXYDU+GI92Vnc8ogBefZ6jgzcIL2jsJkJS5wXv1ZnHLpZUrjoId2W/0o/do
         uLEsFxloIlsk2Q6FJUaOdlIVXTAIXNBdM9NXRjd5kVRvQ4pEwpgtoopnw0S6ouuExNZ0
         TVijHjPxgzyIliWsbh1IAULzoKdMxNjCt/tbFmqC4C73Ql7ATYb2QJrRfD2GO/mvI2yL
         tw10spuJJQfVLTkANbVD2l1WprPsBsmHhQTzN2YQ2zSJoDJeKq182nWAjBk/edmH2hz+
         kujQ==
X-Gm-Message-State: AOJu0Yz7n7GkykrTXQzJSbYg4fUHxuWZirVSaSAIwv01vZ0x8GzGgQom
	nwezZsFpQXnLX0JDVKGughaMCP6Y+Re1nrMSVWfZDbTSaipMro3qXA28p/hD+btdDKS7ArfuBbK
	TlDiQiKBeKUClr0wy07S6dnFLaMVn/9sDf3jdMvMCtpT6rUH6dAQWHG4=
X-Google-Smtp-Source: AGHT+IHmvG2WM0Q2YqAONYKnMM17/TH+tGPM8LfqFryWRupELrFqJfknDxH3oZW+B5rh19VlMIIOAQcSC23ycHs4C1z+dkXum/Hb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c569:0:b0:3cf:b9b8:5052 with SMTP id
 e9e14a558f8ab-3d18c21e82cmr46207995ab.3.1739483762076; Thu, 13 Feb 2025
 13:56:02 -0800 (PST)
Date: Thu, 13 Feb 2025 13:56:02 -0800
In-Reply-To: <CAMp3bLWfe3fx+c8D=N5Kb9Mrbp+7Sgiq=04NKsjFaxxjaHsZoQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ae6a72.050a0220.21dd3.0025.GAE@google.com>
Subject: Re: [syzbot] [modules?] KMSAN: uninit-value in __request_module (6)
From: syzbot <syzbot+1fcd957a82e3a1baa94d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, purvayeshi550@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in __request_module

=====================================================
BUG: KMSAN: uninit-value in string_nocheck lib/vsprintf.c:636 [inline]
BUG: KMSAN: uninit-value in string+0x3ec/0x5f0 lib/vsprintf.c:717
 string_nocheck lib/vsprintf.c:636 [inline]
 string+0x3ec/0x5f0 lib/vsprintf.c:717
 vsnprintf+0xa5d/0x1960 lib/vsprintf.c:2846
 __request_module+0x252/0x9f0 kernel/module/kmod.c:149
 team_mode_get drivers/net/team/team_core.c:480 [inline]
 team_change_mode drivers/net/team/team_core.c:607 [inline]
 team_mode_option_set+0x437/0x970 drivers/net/team/team_core.c:1401
 team_option_set drivers/net/team/team_core.c:375 [inline]
 team_nl_options_set_doit+0x1339/0x1f90 drivers/net/team/team_core.c:2661
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x1214/0x12c0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x375/0x650 net/netlink/af_netlink.c:2543
 genl_rcv+0x40/0x60 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1322 [inline]
 netlink_unicast+0xf52/0x1260 net/netlink/af_netlink.c:1348
 netlink_sendmsg+0x10da/0x11e0 net/netlink/af_netlink.c:1892
 sock_sendmsg_nosec net/socket.c:718 [inline]
 __sock_sendmsg+0x30f/0x380 net/socket.c:733
 ____sys_sendmsg+0x877/0xb60 net/socket.c:2573
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2627
 __sys_sendmsg net/socket.c:2659 [inline]
 __do_sys_sendmsg net/socket.c:2664 [inline]
 __se_sys_sendmsg net/socket.c:2662 [inline]
 __x64_sys_sendmsg+0x212/0x3c0 net/socket.c:2662
 x64_sys_call+0x2ed6/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:47
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
 netlink_alloc_large_skb+0x1b4/0x280 net/netlink/af_netlink.c:1196
 netlink_sendmsg+0xa96/0x11e0 net/netlink/af_netlink.c:1867
 sock_sendmsg_nosec net/socket.c:718 [inline]
 __sock_sendmsg+0x30f/0x380 net/socket.c:733
 ____sys_sendmsg+0x877/0xb60 net/socket.c:2573
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2627
 __sys_sendmsg net/socket.c:2659 [inline]
 __do_sys_sendmsg net/socket.c:2664 [inline]
 __se_sys_sendmsg net/socket.c:2662 [inline]
 __x64_sys_sendmsg+0x212/0x3c0 net/socket.c:2662
 x64_sys_call+0x2ed6/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 6614 Comm: syz.0.16 Not tainted 6.14.0-rc2-syzkaller-gab68d7eb7b1a-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
=====================================================


Tested on:

commit:         ab68d7eb Merge tag 'loongarch-fixes-6.14-1' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=122893f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48f90cac5eea091a
dashboard link: https://syzkaller.appspot.com/bug?extid=1fcd957a82e3a1baa94d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13a721a4580000


