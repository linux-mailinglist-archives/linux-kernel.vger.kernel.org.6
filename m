Return-Path: <linux-kernel+bounces-436487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC949E869C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 17:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28D361884D65
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 16:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7085E1714B5;
	Sun,  8 Dec 2024 16:41:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF38170A15
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 16:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733676066; cv=none; b=jlkvZAio/OvIBNZvEo/k3etXMVYjl2iJefjXJcSgSilNYBsHqvOHyMbDIClxlqB6/FIr+raAj/ufb5ZOc16J13AbBh15Enaj2BxySkCd/Nied/wf/R/yCMtaz6SpSuPRzHPWviAo8dm4zjIQ7nq74GlsYZBSlmRkSzXUx7UIJZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733676066; c=relaxed/simple;
	bh=QFLdevOoSZ45DF2brEL3btwgPVXk2kycNP3bU6gz6JY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mSvkzkypB+2ZPEyLKJN+E27CDdJtu+Mq3j7eWAZ6eg9cvABZM9mJzWWw0CBWNQKHUIguIhYHIT8pDbJntv6gktKhfEwCqtSpskDrcENz6DEcnZEsKzSw17Rez8Ehkcy1XSBOcOHowLkQcZa7CKOzrcm2gZSN8St78nrfpbVzqh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a9d075bdc3so11105305ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 08:41:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733676063; x=1734280863;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dRv5nsxctDHGBh6rKubGAGWr1J9kJaWY6m3B8Onl1KE=;
        b=U9AIcT0/DlvEr7PmU9fIEknu4+4gcN/sQGRZy2tNKjAc9r5BViLz+mcNYKjpSptw/Z
         yv/uciZ/xVnpK7CO3DTbzR+gbhNTWsnlmMXCgyVclIyGL6XU/GHAAaYinl8ekLswHfdn
         1zn77860xJygOSiOgolWkf7wL5IwSV4M8gpkOVD/GJp8deyph7kxM2oJOn+10Db+qb7b
         GAasvXSJjwSyWnkP7BHsudSLLMZprT6eGxGgrEiGbcOpJzrXpQvPa0y+vCDy/aOAqr0d
         VyurYVhUej/WVPUVRHdfuWQlRL9861ZSj3PA7dNFu18f9CRW1UEDiQNurvIXoElfRolH
         uIAA==
X-Gm-Message-State: AOJu0YwaNftfNEpruVNB3tLnpVwu8rbcRjdlF7EgA4rWNfTYo0G4CoHy
	0ztJc3TApQoblxsrK4/0D1esWyUhs8bBEywWFhiFGpSbVOV6AY4ZvVCmnGFLcTxjfWA7YZAUwko
	BM+EzhbSHPvNCUDcNT6U/8zPVh+MduANdYiqki4NbGw78mq6rl7Dq4bQ=
X-Google-Smtp-Source: AGHT+IHPVoAbyZ414vtQ/1ZEzrcld1szxWPtZondk/Xeeoe6pUHcSIlMQT+u7G/uZaz80S2kE7p7kbuyks+ScqdmX+P5lKN4kRO6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1448:b0:3a7:e0e6:65a5 with SMTP id
 e9e14a558f8ab-3a811d94896mr130365675ab.6.1733676063521; Sun, 08 Dec 2024
 08:41:03 -0800 (PST)
Date: Sun, 08 Dec 2024 08:41:03 -0800
In-Reply-To: <D66FXFUEV6V3.3SKKXVBD0Q1OY@getstate.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6755cc1f.050a0220.2477f.002b.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in mgmt_remove_adv_monitor_sync
From: syzbot <syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, mazin@getstate.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in mgmt_remove_adv_monitor_complete

============================================
WARNING: possible recursive locking detected
6.13.0-rc1-syzkaller-00337-g7503345ac5f5-dirty #0 Not tainted
--------------------------------------------
syz.2.7083/22215 is trying to acquire lock:
ffff888027fbc078 (&hdev->lock){+.+.}-{4:4}, at: mgmt_remove_adv_monitor_complete+0x87/0x5f0 net/bluetooth/mgmt.c:5524

but task is already holding lock:
ffff888027fbc078 (&hdev->lock){+.+.}-{4:4}, at: hci_dev_close_sync+0x5d4/0x11c0 net/bluetooth/hci_sync.c:5203

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&hdev->lock);
  lock(&hdev->lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

3 locks held by syz.2.7083/22215:
 #0: ffff888027fbcd80 (&hdev->req_lock){+.+.}-{4:4}, at: hci_dev_do_close net/bluetooth/hci_core.c:481 [inline]
 #0: ffff888027fbcd80 (&hdev->req_lock){+.+.}-{4:4}, at: hci_dev_close+0x10a/0x210 net/bluetooth/hci_core.c:508
 #1: ffff888027fbc078 (&hdev->lock){+.+.}-{4:4}, at: hci_dev_close_sync+0x5d4/0x11c0 net/bluetooth/hci_sync.c:5203
 #2: ffff888027fbc690 (&hdev->cmd_sync_work_lock){+.+.}-{4:4}, at: hci_cmd_sync_dequeue+0x44/0x3d0 net/bluetooth/hci_sync.c:887

stack backtrace:
CPU: 1 UID: 0 PID: 22215 Comm: syz.2.7083 Not tainted 6.13.0-rc1-syzkaller-00337-g7503345ac5f5-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_deadlock_bug+0x483/0x620 kernel/locking/lockdep.c:3037
 check_deadlock kernel/locking/lockdep.c:3089 [inline]
 validate_chain+0x15e2/0x5920 kernel/locking/lockdep.c:3891
 __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 __mutex_lock_common kernel/locking/mutex.c:585 [inline]
 __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
 mgmt_remove_adv_monitor_complete+0x87/0x5f0 net/bluetooth/mgmt.c:5524
 _hci_cmd_sync_cancel_entry net/bluetooth/hci_sync.c:645 [inline]
 hci_cmd_sync_dequeue+0x22b/0x3d0 net/bluetooth/hci_sync.c:890
 cmd_complete_rsp+0x4c/0x180 net/bluetooth/mgmt.c:1469
 mgmt_pending_foreach+0xd1/0x130 net/bluetooth/mgmt_util.c:259
 __mgmt_power_off+0x183/0x430 net/bluetooth/mgmt.c:9560
 hci_dev_close_sync+0x6d0/0x11c0 net/bluetooth/hci_sync.c:5211
 hci_dev_do_close net/bluetooth/hci_core.c:483 [inline]
 hci_dev_close+0x112/0x210 net/bluetooth/hci_core.c:508
 sock_do_ioctl+0x158/0x460 net/socket.c:1209
 sock_ioctl+0x626/0x8e0 net/socket.c:1328
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa1e5980849
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa1e6784058 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fa1e5b45fa0 RCX: 00007fa1e5980849
RDX: 0000000000000000 RSI: 00000000400448ca RDI: 0000000000000004
RBP: 00007fa1e59f3986 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fa1e5b45fa0 R15: 00007ffeddc0b198
 </TASK>


Tested on:

commit:         7503345a Merge tag 'block-6.13-20241207' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=115c14df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1362a5aee630ff34
dashboard link: https://syzkaller.appspot.com/bug?extid=479aff51bb361ef5aa18
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1113c820580000


