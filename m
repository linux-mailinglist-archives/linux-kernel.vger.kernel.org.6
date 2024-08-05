Return-Path: <linux-kernel+bounces-274309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AFB94765C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C01FB20C99
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 07:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EF714A09C;
	Mon,  5 Aug 2024 07:53:34 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35961E505
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 07:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722844414; cv=none; b=M9lC7QNnb2Lk25AdTyfTq6SzW9CwCBnjaASG0+JfMe5BEIEFhj9ObTJ2svKw8X7s1NEOanNIxKcXHxsBEopFAWHo4xrBozPK545fDVlcjzaTRWVFFL1AQv2wdzHPhlqaCQvtY0uoQHiMzIhbBakmpKWZtlEtEQzmAehNwcsXkLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722844414; c=relaxed/simple;
	bh=eue99aTsVuzB0mRkhKmhak8Q96MasOpRkJWMc1UDFic=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CO56zYpBfrrM1z8EmyEtvDHY8KOg6c87f0txe/fzO+e6Zan59hsgd4WO/A5wB6DnJL4wlVWl6G8t0y4Owp9ygySm19SWyRnD1t5pyoZcC/ywyEeO6gH4p7wxazJImgQH2r7ayQ+V5KzXP1lGImTy6Ijl63SuylR3hDMy2bsJo2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39827d07ca7so178696125ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 00:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722844412; x=1723449212;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0lP8nWGXtQjOcrzLF9XcyPmaCAK4n7bbGrNmnZWOGIg=;
        b=vFCwDFBurLUgazDEloB3EJompzFDqnEX4lemzixa6MHSTJcl4sFZXq0qj8qMQXNgy4
         7adYsDBscnxWFjrXNZ2cwUpcUwCSqNEaFOAtqIze1PbajBE/xHkC9pDNQxffErC/gzW4
         pSKjVclR4XMcSDYWgbJEUkLKeoe4b783qHz5+Qq/j9DAb4eYwapQLwhAZ2eC62GWvIuk
         0hx1aHqAD/kfkoHLpHol1ocV0mUD4EBJ0FOeUiP7gBO2l8kWLbw3mtueNiVRohUDp/8p
         Vf7B8WbLBvjb03fSCHjjKc0f0xS8wCI+TvVfuFJQtoZyQU4pnJlcKo4GV7LTMRu3W3zs
         8LDw==
X-Forwarded-Encrypted: i=1; AJvYcCVtyx4/uewk9UwSCx7/JgG0uPcZyKzGKLCwPZSieZe2KYa9/9mwklizNnM4+Bh1nhz5gkK3KuTzIaDnwy1RlKQKXQeANtoLVqvWFzkC
X-Gm-Message-State: AOJu0YxxIoJhMLCemO9LPM2elcag6Srlyzjl5Y58ZjBXglPGkTVWjf1o
	0Bgk+MkZBtOnAzxzg18zW+gFz9mNkViwgpEYyO2hJMGxOAz2Ixi13MlS3mTUPcrlBIO9oHZjCag
	Fy+kIERtKm6/01lX/j/ac+7bACqAdB0Po+KVAmaTj657vRmJe90ee7/w=
X-Google-Smtp-Source: AGHT+IHENX4/xU1/CrvhmG6qrY0Fn/1VdAfrnt2VWh+u2ftuT/zi5P2HWbIP31Z5mE4vVtXrQag0ko7PAlLTghYM5E343B18GnKK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214b:b0:39a:ea86:12f2 with SMTP id
 e9e14a558f8ab-39b1fca07c2mr10353075ab.6.1722844412054; Mon, 05 Aug 2024
 00:53:32 -0700 (PDT)
Date: Mon, 05 Aug 2024 00:53:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002f2474061eeaf974@google.com>
Subject: [syzbot] [net?] WARNING in pppol2tp_release
From: syzbot <syzbot+0e85b10481d2f5478053@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, jchapman@katalix.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3608d6aca5e7 Merge branch 'dsa-en7581' into main
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=122d5b55980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fbd68ab0b66eda34
dashboard link: https://syzkaller.appspot.com/bug?extid=0e85b10481d2f5478053
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9d523e471f71/disk-3608d6ac.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ed20c68f58d7/vmlinux-3608d6ac.xz
kernel image: https://storage.googleapis.com/syzbot-assets/320eb8606813/bzImage-3608d6ac.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0e85b10481d2f5478053@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5467 at kernel/workqueue.c:2259 __queue_work+0xcd3/0xf50 kernel/workqueue.c:2258
Modules linked in:
CPU: 1 UID: 0 PID: 5467 Comm: syz.3.43 Not tainted 6.11.0-rc1-syzkaller-00247-g3608d6aca5e7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:__queue_work+0xcd3/0xf50 kernel/workqueue.c:2258
Code: ff e8 11 84 36 00 90 0f 0b 90 e9 1e fd ff ff e8 03 84 36 00 eb 13 e8 fc 83 36 00 eb 0c e8 f5 83 36 00 eb 05 e8 ee 83 36 00 90 <0f> 0b 90 48 83 c4 60 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc
RSP: 0018:ffffc90004607b48 EFLAGS: 00010093
RAX: ffffffff815ce274 RBX: ffff8880661fda00 RCX: ffff8880661fda00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff815cd6d4 R09: 0000000000000000
R10: ffffc90004607c20 R11: fffff520008c0f85 R12: ffff88802ac33800
R13: ffff88802ac339c0 R14: dffffc0000000000 R15: 0000000000000008
FS:  00005555713eb500(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000008 CR3: 000000001eda6000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 queue_work_on+0x1c2/0x380 kernel/workqueue.c:2392
 pppol2tp_release+0x163/0x230 net/l2tp/l2tp_ppp.c:445
 __sock_release net/socket.c:659 [inline]
 sock_close+0xbc/0x240 net/socket.c:1421
 __fput+0x24a/0x8a0 fs/file_table.c:422
 task_work_run+0x24f/0x310 kernel/task_work.c:228
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f061e9779f9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffff1c1fce8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 000000000001017d RCX: 00007f061e9779f9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007ffff1c1fdc0 R08: 0000000000000001 R09: 00007ffff1c1ffcf
R10: 00007f061e800000 R11: 0000000000000246 R12: 0000000000000032
R13: 00007ffff1c1fde0 R14: 00007ffff1c1fe00 R15: ffffffffffffffff
 </TASK>


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

