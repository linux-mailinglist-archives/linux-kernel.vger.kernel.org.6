Return-Path: <linux-kernel+bounces-313103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A8696A054
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 16:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1925D1C21A49
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CD56F30F;
	Tue,  3 Sep 2024 14:24:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7664951C3E
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 14:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373446; cv=none; b=ExH/ZEMGr8T7rVaGRib6QqIo2MNtYbq2vy99Wf1Ua+LOQFUHceaRF18r4i24yKVP1MWWWmYP/6I5zvnATnfnu87xn+9+q2WX/VC6eKQije1pPP3gxzOktvJnYj0k1kAztPjkSE/Xg+D/vkWFWO9Q8ItfZdUq6Q1fBVfnHoH/aZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373446; c=relaxed/simple;
	bh=rbE7f7lEhO/NIIxMm2SBz6OukT6kPRN9hZFooAgDE80=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gBNru7It093B3vEUXu99W7DzVP25nxyxdO3MA1q+wwDwnMz4er1NKYHnM77jGqC4Fxla/QN0AaUlZjC/j3cjQ7f9ucXaYI37ncfPkLj4qDVZJL47A2y6Y2I2kDLFW+Mz4Zf0PO8nZMJeGH/78w4IrXY55PyFOyVdxccUb/vKgTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d2dbd9bebso63938215ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 07:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725373444; x=1725978244;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W2lJnvUj05dxrqOXSFeo9b5D1JGrL0BBUBLl8WTh16M=;
        b=ldpL+UJd6m2A6tDi8H8JIhBIpC34sdaUa0BCsNPTMJ4o4NQZ5ac2mdAGo/PaJOjAxk
         q3asx4ZhUBvyjhFbTejtM38NFXaTAv0eTfWZrzDQoXCw3tiEn6WavSLNkvi1hG/Xmwx7
         wMlKoZ1AQ2p3ZoaKe6KsRXShoPkP8322EaohqrwVdOIZ3AcSwKMhdTvXeccwBf1JlvNZ
         sip8HaHIbsPA5Y6+hM4NcC/mMALL5JQjn3n8glxZkK6+6wqhnm5rIeZfSIRxKUwQeTLh
         M55BeBH0VnR0tL3MZnb/OAQGEl0sq7MveCiDI5CG1T4dh7iWVohW4I0Mu1jDQY3mfdr7
         QDVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBXHhVi/mtU9kKU0hbjrqtWGOW/hO9p3p/gttpSryWvKR19go5c68nvT6Ih0ojFbioKosN9tvqC6ge37A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoTXywuS/tl5etHxkHPjjACt7c35qJVVk42SRO6MPpb557OZcd
	rGV1IBVFKTehAC5eV0pq128ofFESJgy9pG/rZOCWe7eg8eVmJ5nUPQB0G4Eb2yCiSYlvpp6ljrm
	n/uwRIAcm4fZXtyHqYekRFQQR8V3P+CVcemvyxCIMO2YgaCXE01balng=
X-Google-Smtp-Source: AGHT+IEJrGX/Mlc6RCZwuWX0ygqYkHm7y6YPRYxZeQKQciGNHzz6lKSkLegrJJfsNsJV20f4ZRr+0oQnV56KwHMeT0Ck7FMyY/sz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219b:b0:376:417e:c2ab with SMTP id
 e9e14a558f8ab-39f410beff2mr5409975ab.5.1725373443715; Tue, 03 Sep 2024
 07:24:03 -0700 (PDT)
Date: Tue, 03 Sep 2024 07:24:03 -0700
In-Reply-To: <tencent_DF6D237A296523A8E45177687763C6C2B305@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000037c3da062137cf02@google.com>
Subject: Re: [syzbot] [mptcp?] KASAN: slab-use-after-free Read in __timer_delete_sync
From: syzbot <syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in remove_anno_list_by_saddr

============================================
WARNING: possible recursive locking detected
6.11.0-rc6-syzkaller-00019-g67784a74e258-dirty #0 Not tainted
--------------------------------------------
syz.1.16/6115 is trying to acquire lock:
ffff888028c116a0 (&msk->pm.lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff888028c116a0 (&msk->pm.lock){+.-.}-{2:2}, at: mptcp_pm_del_add_timer net/mptcp/pm_netlink.c:338 [inline]
ffff888028c116a0 (&msk->pm.lock){+.-.}-{2:2}, at: remove_anno_list_by_saddr+0x24/0x190 net/mptcp/pm_netlink.c:1464

but task is already holding lock:
ffff888028c116a0 (&msk->pm.lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff888028c116a0 (&msk->pm.lock){+.-.}-{2:2}, at: mptcp_pm_remove_addrs_and_subflows net/mptcp/pm_netlink.c:1682 [inline]
ffff888028c116a0 (&msk->pm.lock){+.-.}-{2:2}, at: mptcp_nl_remove_addrs_list net/mptcp/pm_netlink.c:1719 [inline]
ffff888028c116a0 (&msk->pm.lock){+.-.}-{2:2}, at: mptcp_pm_nl_flush_addrs_doit+0x509/0xd80 net/mptcp/pm_netlink.c:1760

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&msk->pm.lock);
  lock(&msk->pm.lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

4 locks held by syz.1.16/6115:
 #0: ffffffff8fcf14b0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8fcf1368 (genl_mutex){+.+.}-{3:3}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8fcf1368 (genl_mutex){+.+.}-{3:3}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8fcf1368 (genl_mutex){+.+.}-{3:3}, at: genl_rcv_msg+0x121/0xec0 net/netlink/genetlink.c:1209
 #2: ffff888028c10e98 (sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1607 [inline]
 #2: ffff888028c10e98 (sk_lock-AF_INET6){+.+.}-{0:0}, at: mptcp_nl_remove_addrs_list net/mptcp/pm_netlink.c:1718 [inline]
 #2: ffff888028c10e98 (sk_lock-AF_INET6){+.+.}-{0:0}, at: mptcp_pm_nl_flush_addrs_doit+0x4d0/0xd80 net/mptcp/pm_netlink.c:1760
 #3: ffff888028c116a0 (&msk->pm.lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
 #3: ffff888028c116a0 (&msk->pm.lock){+.-.}-{2:2}, at: mptcp_pm_remove_addrs_and_subflows net/mptcp/pm_netlink.c:1682 [inline]
 #3: ffff888028c116a0 (&msk->pm.lock){+.-.}-{2:2}, at: mptcp_nl_remove_addrs_list net/mptcp/pm_netlink.c:1719 [inline]
 #3: ffff888028c116a0 (&msk->pm.lock){+.-.}-{2:2}, at: mptcp_pm_nl_flush_addrs_doit+0x509/0xd80 net/mptcp/pm_netlink.c:1760

stack backtrace:
CPU: 0 UID: 0 PID: 6115 Comm: syz.1.16 Not tainted 6.11.0-rc6-syzkaller-00019-g67784a74e258-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 check_deadlock kernel/locking/lockdep.c:3061 [inline]
 validate_chain+0x15d3/0x5900 kernel/locking/lockdep.c:3855
 __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
 _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 mptcp_pm_del_add_timer net/mptcp/pm_netlink.c:338 [inline]
 remove_anno_list_by_saddr+0x24/0x190 net/mptcp/pm_netlink.c:1464
 mptcp_pm_remove_addrs_and_subflows net/mptcp/pm_netlink.c:1689 [inline]
 mptcp_nl_remove_addrs_list net/mptcp/pm_netlink.c:1719 [inline]
 mptcp_pm_nl_flush_addrs_doit+0x689/0xd80 net/mptcp/pm_netlink.c:1760
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2597
 ___sys_sendmsg net/socket.c:2651 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2680
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb336579eb9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb3372d5038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fb336715f80 RCX: 00007fb336579eb9
RDX: 0000000001000000 RSI: 0000000020000300 RDI: 0000000000000003
RBP: 00007fb3365e793e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fb336715f80 R15: 00007fb33683fa28
 </TASK>


Tested on:

commit:         67784a74 Merge tag 'ata-6.11-rc7' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13ab2a8f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=660f6eb11f9c7dc5
dashboard link: https://syzkaller.appspot.com/bug?extid=f3a31fb909db9b2a5c4d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1377f28f980000


