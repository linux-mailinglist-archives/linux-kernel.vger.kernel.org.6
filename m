Return-Path: <linux-kernel+bounces-443925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E9E9EFDB0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D2F2164105
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A041ABECF;
	Thu, 12 Dec 2024 20:53:35 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC4554723
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 20:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734036815; cv=none; b=toO6bw3gPmNmKpd/qD+TC6XHKa4agHo9BNu55eZ/LmZCPpEt7fAXXoIqT/NUNMVSNjKC7LP/p0yYkZC6c26pLdwtuXC+Q9pClxW7YJnGhKQLa2ltFwG/7uFSPoj53RK4EDVUs1457S8tkRWJ1hQNMHY1TLSc3Nktza5WH2ZdCjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734036815; c=relaxed/simple;
	bh=90zsgfNyEA0soUTRq2/zVQmf8gv4uGz6upO5C01Mz/s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FyljsPs26tyahVdxBAwJH/04yUgrFfg+lGHthdSHVfxWm7ktM0Z/rzSyAOl6PciSyQ4x45Ss3tbnemQ5MNG6wenRjBz5ey4nUHjUXOe/emlMoD6xtpG/PuIXtJjSc8IdTArCuW23iy29qVgt9DjVZig4gywjP3op+4jTLIv7O00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3a7e4bfae54so10352025ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 12:53:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734036812; x=1734641612;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2hbvWjKqPP1qsg4dKWn1bkxaqNABr3frYovaiNPZY7E=;
        b=aLFsj22tAEUhWXgxD6AzbrBlWxgJMkM4G+jyoyxWo+rJm4kBsLEencvjgGGMvHDVcM
         luselL/rc/UoyV+mPJpqKIie8/8wCfOI8YigRty41nVDrjWIDf1wJvVokn8G0MrtX3Rp
         YL4u/5IfNaqKCvmPI2piU8mEz77HTU4zUDiJ9KHZvdXJWXw6qw1xVQE03YpmABTNe7xJ
         cFhMqCd087trjnXPSD4ZQFqHo0t/uSGDhraQdvtZcalUO2Rm//N6QDIsN5btrBwV4m7V
         IMcSNDfIDEzbhsbBb3WS6kavWxbRjouAgWFjVXDaxl/m2U5Oy3r09UFfXV8zcvptB+lB
         B+8g==
X-Gm-Message-State: AOJu0YyFM6/sQdRWBtW6qLS1sdTUspCBJmEsPd2Yw5m4inxfnZVTZUrd
	T23uVQgq9N/3ZdCm4Iq2sHpmKU92Yb/LSw9J107qa0sLx/pVxG7x58rg6/caUzWxysS2VbdHJ4c
	WgcJCpDd1IzQszSeQMdAq3bp+wI9FRSGWmfbuz00bWYmnys8MjbYozmgjmA==
X-Google-Smtp-Source: AGHT+IGmov1xtidN7m5njnidm/lmbmvC/DUhzpPswMUHg7L9oufCugv8IiL8Set/TpdEJ6kQXDt6I+I+kzAkt/t2eQRbDMr9KUew
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c5:b0:3a7:6d14:cc29 with SMTP id
 e9e14a558f8ab-3aff470fe92mr3202685ab.1.1734036812698; Thu, 12 Dec 2024
 12:53:32 -0800 (PST)
Date: Thu, 12 Dec 2024 12:53:32 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675b4d4c.050a0220.599f4.00ba.GAE@google.com>
Subject: [syzbot] [kernel?] WARNING in notifier_call_chain (2)
From: syzbot <syzbot+c81bea693d8cd125f5f2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    231825b2e1ff Revert "unicode: Don't special case ignorable..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1019ebe8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b874549ac3d0b012
dashboard link: https://syzkaller.appspot.com/bug?extid=c81bea693d8cd125f5f2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/09aec3e43efa/disk-231825b2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/41d874d46d24/vmlinux-231825b2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d92b7bdbbe5c/bzImage-231825b2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c81bea693d8cd125f5f2@syzkaller.appspotmail.com

------------[ cut here ]------------
Invalid notifier called!
WARNING: CPU: 1 PID: 24239 at kernel/notifier.c:79 notifier_call_chain+0x395/0x410 kernel/notifier.c:79
Modules linked in:
CPU: 1 UID: 0 PID: 24239 Comm: init Not tainted 6.13.0-rc2-syzkaller-00036-g231825b2e1ff #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:notifier_call_chain+0x395/0x410 kernel/notifier.c:79
Code: 00 44 89 f8 48 83 c4 30 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc e8 79 27 34 00 90 48 c7 c7 20 13 6c 8b e8 cc 72 f4 ff 90 <0f> 0b 90 90 e9 70 fd ff ff e8 5d 27 34 00 90 0f 0b 90 e9 2e fe ff
RSP: 0018:ffffc9000b5d7cc8 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff88807d6558c8 RCX: ffffffff815a5079
RDX: ffff88806677a440 RSI: ffffffff815a5086 RDI: 0000000000000001
RBP: 00000000fffffffd R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 000000000006dc30 R12: dffffc0000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f27f7527500(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005575df75b600 CR3: 0000000031b0c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 blocking_notifier_call_chain kernel/notifier.c:380 [inline]
 blocking_notifier_call_chain+0x69/0xa0 kernel/notifier.c:368
 kernel_shutdown_prepare kernel/reboot.c:299 [inline]
 kernel_power_off+0x1c/0xb0 kernel/reboot.c:702
 __do_sys_reboot+0x376/0x3e0 kernel/reboot.c:777
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f27f76808b4
Code: f0 ff ff 73 01 c3 48 8b 0d 71 55 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d 00 f0 ff ff 76 10 48 8b 15 45 55 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007fff502ede88 EFLAGS: 00000246 ORIG_RAX: 00000000000000a9
RAX: ffffffffffffffda RBX: 000000000000000c RCX: 00007f27f76808b4
RDX: 000000004321fedc RSI: 0000000028121969 RDI: 00000000fee1dead
RBP: 000000004321fedc R08: 0000000000000000 R09: 0000000000000000
R10: 00007fff502ede60 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff502edee8 R14: 000055e8723c1169 R15: 00007f27f785ea80
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

