Return-Path: <linux-kernel+bounces-541514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E6BA4BDC8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 385061721AC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7581F5437;
	Mon,  3 Mar 2025 11:09:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C071F4161
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000146; cv=none; b=e3lX4GT5km9pHdrw+y8C5b5g63Tfdznxn/Ocjpm3r5eGKV15Petb0dru1VyTqn2oVPvX4WmdYheJpaqCby8qN2xYVO8Udq8upx3UEn4h5Ns8XTj7cV0ybiKunw0L8NZvgXyZFkMoJ/nqe8f/VV7dlhS0y/S4gcqvIhBeybZiQr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000146; c=relaxed/simple;
	bh=5tsFwlp85Jhoy+DmbRuKSUiS3O2f5zboxKzY9YyrJYI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=X6lo0nmjH/aCYvcCvlwjXzYcXe1GvV8cvg/9W4697WuGxI0pXKxKwgz0OOzUqN0A/LbqidnBzPjTx+R9Y13zVRQdTEt2w9G535QCf90bXCHiCnXBkCVeZeG7Oeudi6/5xRXIrybghmyoe5WO4YSq1HkGqI4uuz1hIzg6mNL8cjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d2a40e470fso39828185ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 03:09:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741000144; x=1741604944;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2xPMUUNySFQoktsp0WJkc55bEq7X3wIcglwMk4oPrv0=;
        b=Tw3t77Ug+/cL1UbIHtb8P8WuFoiqG1rnfiWjRpmOba/WmsojC+Sp+a46phCGGKV9zB
         8kyfo9CzJMrcdTdyezIQ5YU9QDy04xjYCZezC0ntDXL4/hjjaD2NasGJrN5Lo+I99+Zj
         ZSZcOMN/fRpUqumBphGxE1qwNz1DSts5kw+uGWwQ2O67l1z20CKBvSfdf2Xlyorc3EUA
         4Pclvfhhmx490IdSD1VaH6XyugS4YedLjjym1OyH9Sl6t8O16IOgif0aAQYFiAyXgOHj
         O7SZR2Icvw1mmTsLmQQbSSaEyWmJi7Z+V+UHmUSOvvJEJx/hOLfKh7gWsV/HWkzyOJQw
         jSNA==
X-Forwarded-Encrypted: i=1; AJvYcCWALUZDlW33Z7CxZky71GfeKZW0gw3XcnLsuTRaRWmyea2JrXmsjKloJsFOi2uUXnfL1HRO/Y+mWut33g0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHCqFvP5caHLCFyrtlGzAVeic/YmF8HgBPRO2JWUb4SoQrNU91
	7RLsO8ZxBvZmZ9yUmSp6oPQELzEgY9I2sC2pkcJKcD4ZHL3hmaVdOL2LOY78l7Qwe9pqqoE3hFg
	mzJ73AxNeLqPMXsVJvMZ11jCZ/EAgpJ0edUUIhoqTygvI830Tb/kFmyo=
X-Google-Smtp-Source: AGHT+IFn9NRJyxYT3JK/1YyQfS4rb/SO3mEKuO/B19A5yqTqu5mi80rjBc3sZVpe9lek2e4ipFTFKL6XRDbL1pXM/sdrbL312g5d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:320c:b0:3d1:883c:6e86 with SMTP id
 e9e14a558f8ab-3d3e6e39bf2mr125471285ab.8.1741000143989; Mon, 03 Mar 2025
 03:09:03 -0800 (PST)
Date: Mon, 03 Mar 2025 03:09:03 -0800
In-Reply-To: <20250303105413.2938-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c58dcf.050a0220.1dee4d.0128.GAE@google.com>
Subject: Re: [syzbot] [netfilter?] KASAN: slab-use-after-free Read in
 nf_tables_trans_destroy_work (2)
From: syzbot <syzbot+5d8c5789c8cb076b2c25@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: bad unlock balance in nf_tables_abort

=====================================
WARNING: bad unlock balance detected!
6.14.0-rc5-syzkaller-g7eb172143d55-dirty #0 Not tainted
-------------------------------------
syz.0.20/6539 is trying to release lock (&nft_net->commit_mutex) at:
[<ffffffff898b345d>] nf_tables_module_autoload net/netfilter/nf_tables_api.c:10962 [inline]
[<ffffffff898b345d>] nf_tables_abort+0x29fd/0x3d60 net/netfilter/nf_tables_api.c:11254
but there are no more locks to release!

other info that might help us debug this:
no locks held by syz.0.20/6539.

stack backtrace:
CPU: 3 UID: 0 PID: 6539 Comm: syz.0.20 Not tainted 6.14.0-rc5-syzkaller-g7eb172143d55-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_unlock_imbalance_bug kernel/locking/lockdep.c:5289 [inline]
 print_unlock_imbalance_bug+0x1aa/0x1f0 kernel/locking/lockdep.c:5263
 __lock_release kernel/locking/lockdep.c:5528 [inline]
 lock_release+0x525/0x6f0 kernel/locking/lockdep.c:5872
 __mutex_unlock_slowpath+0xa3/0x6a0 kernel/locking/mutex.c:891
 nf_tables_module_autoload net/netfilter/nf_tables_api.c:10962 [inline]
 nf_tables_abort+0x29fd/0x3d60 net/netfilter/nf_tables_api.c:11254
 nfnetlink_rcv_batch+0xabb/0x24e0 net/netfilter/nfnetlink.c:568
 nfnetlink_rcv_skb_batch net/netfilter/nfnetlink.c:647 [inline]
 nfnetlink_rcv+0x3c3/0x430 net/netfilter/nfnetlink.c:665
 netlink_unicast_kernel net/netlink/af_netlink.c:1312 [inline]
 netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1338
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1882
 sock_sendmsg_nosec net/socket.c:718 [inline]
 __sock_sendmsg net/socket.c:733 [inline]
 ____sys_sendmsg+0xaaf/0xc90 net/socket.c:2573
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2627
 __sys_sendmsg+0x16e/0x220 net/socket.c:2659
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8dd078d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8dd1634038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f8dd09a5fa0 RCX: 00007f8dd078d169
RDX: 0000000000000000 RSI: 000040000000c2c0 RDI: 0000000000000003
RBP: 00007f8dd080e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f8dd09a5fa0 R15: 00007fff3449f258
 </TASK>


Tested on:

commit:         7eb17214 Linux 6.14-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1382a464580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=da4b04ae798b7ef6
dashboard link: https://syzkaller.appspot.com/bug?extid=5d8c5789c8cb076b2c25
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=125ca464580000


