Return-Path: <linux-kernel+bounces-341874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B12988796
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 16:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6840A1F223F6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 14:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129BA1C0DE7;
	Fri, 27 Sep 2024 14:53:30 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9F61C0DDB
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 14:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727448809; cv=none; b=o7W/ld7n+Ooqr7BUQlONz9N+w0Txn38G/jIXLq2lsRdGY1Ke9wQbbU3bWFS27ZinRkwP86pka1VhLnTZl+yi8aQ3WEPNkQNYC3Ash6LvsCpFp3WUsAY3DKyD94O2skVSNSIDnbb3mEJRlIaZID7c4ocLVnk41gRCGiwoesG+Q6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727448809; c=relaxed/simple;
	bh=HaX/MQx1zNcIHLfx6OG1HhNLa8dC2O4MTlK7wLnEgJw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=er/LDa76DOEn/59yEZN//UOYzWhROc49hq0CmwpBtum1RUC+KUEXnXs42yEtKZWyoF5cLagEnGcAupXeDB/vk77GR10mQKhiBmNWKBUbHs+Z/KwsN9vhjqJKNPqC7OPhklsX8J84Zk3DIMmRdu7uDibf3BROkG0T+o/uj66m7hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82cfb2e416eso238358039f.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 07:53:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727448807; x=1728053607;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=INg9NDGbJndgApL4ta3KYfHMik711xYxdB14onZZNkM=;
        b=KY2hwjC+j/KHHZ1nvS50vgJcAmLa0T1fJGjQO1RdqMVM60d8vIW0N8Y63XEIuAA2fc
         Qgzp+srfiKM/kA/hVs5KyjX00RhZBlXXTjpPxJRqTULawWN6GKmA16PQXY9Rz7eV8scC
         Kkz+tEyoJa4kXqy/EohJnD8eUB7NQnwEON0vHwGK1S2sbS5keZ0rqGHjzndQem4PJ85+
         Pka8mazCnsiFSC9mwvCcVKaYGk6UhO1CsYIT6oQ1IXfQRmXG/gDMjIu36I49PQ9Q+6Er
         3xRqDmXPDuLfO9st7ravB1z9dyNiqEnBz2F5db/kIzLHDCavTbiOuyt9KmUZV1KI+X0K
         JIEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDJm4YgFxHztx3g3yzxVo1r78byeIiV51Al1Ih0vFYWGsjQmAeNstcohPJBjGqVzameIx1SmrJgiXvLhE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+m8drbM+UD3IsNhQeqvy1N9PLTWcADL25l7pAB3T4iKZ6ALqB
	RvOSH+J/KfKacpCmiMvgZp0lE2IXyywFHQVl/VzavAc8Y499pg9ZNZrEBUkty+0+PaTPAohgQHA
	8bOCa2Q8oMbQF3I9fqM2DA2LBmrJDPT2OA3yawUXXEFPGwAR8fsWk7v8=
X-Google-Smtp-Source: AGHT+IHIUcpYtJFgSP7pDy5XgukcodOG+wBBK/L59AFlPJQxsc2QKzR35Blq4RzUjYQRWd3myrD5J0AkyOk9IN0/XkOe0NkeMsiK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d84:b0:3a2:74eb:91fa with SMTP id
 e9e14a558f8ab-3a3451c1b12mr31149485ab.25.1727448807297; Fri, 27 Sep 2024
 07:53:27 -0700 (PDT)
Date: Fri, 27 Sep 2024 07:53:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f6c6e7.050a0220.38ace9.0024.GAE@google.com>
Subject: [syzbot] [bluetooth?] BUG: corrupted list in _hci_cmd_sync_cancel_entry
From: syzbot <syzbot+01fdb2cc3f0b4ddcfcf1@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a430d95c5efa Merge tag 'lsm-pr-20240911' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=136ba607980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=44d46e514184cd24
dashboard link: https://syzkaller.appspot.com/bug?extid=01fdb2cc3f0b4ddcfcf1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bdf130384fad/disk-a430d95c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c62ff195641a/vmlinux-a430d95c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4069702199e2/bzImage-a430d95c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+01fdb2cc3f0b4ddcfcf1@syzkaller.appspotmail.com

list_del corruption, ffff88801febb580->next is LIST_POISON1 (dead000000000100)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:56!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 8278 Comm: kworker/u9:2 Not tainted 6.11.0-syzkaller-02574-ga430d95c5efa #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: hci2 hci_conn_timeout
RIP: 0010:__list_del_entry_valid_or_report+0x108/0x1c0 lib/list_debug.c:56
Code: c7 c7 80 1b b1 8b e8 c7 c6 dd fc 90 0f 0b 48 c7 c7 e0 1b b1 8b e8 b8 c6 dd fc 90 0f 0b 48 c7 c7 40 1c b1 8b e8 a9 c6 dd fc 90 <0f> 0b 48 89 ca 48 c7 c7 a0 1c b1 8b e8 97 c6 dd fc 90 0f 0b 48 89
RSP: 0018:ffffc90003a1fbe0 EFLAGS: 00010286
RAX: 000000000000004e RBX: ffff88801febb580 RCX: ffffffff816c6699
RDX: 0000000000000000 RSI: ffffffff816cf7b6 RDI: 0000000000000005
RBP: ffff88805f5a8000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: ffff88801febb588
R13: dffffc0000000000 R14: ffff88805f5a8618 R15: ffff88801febb580
FS:  0000000000000000(0000) GS:ffff8880b8900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000202f5000 CR3: 0000000060a82000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_del include/linux/list.h:229 [inline]
 _hci_cmd_sync_cancel_entry.constprop.0+0x80/0x1d0 net/bluetooth/hci_sync.c:643
 hci_cmd_sync_cancel_entry net/bluetooth/hci_sync.c:847 [inline]
 hci_cmd_sync_dequeue_once net/bluetooth/hci_sync.c:866 [inline]
 hci_cancel_connect_sync+0x103/0x2c0 net/bluetooth/hci_sync.c:6844
 hci_abort_conn+0x163/0x340 net/bluetooth/hci_conn.c:2948
 hci_conn_timeout+0x1ab/0x220 net/bluetooth/hci_conn.c:576
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid_or_report+0x108/0x1c0 lib/list_debug.c:56
Code: c7 c7 80 1b b1 8b e8 c7 c6 dd fc 90 0f 0b 48 c7 c7 e0 1b b1 8b e8 b8 c6 dd fc 90 0f 0b 48 c7 c7 40 1c b1 8b e8 a9 c6 dd fc 90 <0f> 0b 48 89 ca 48 c7 c7 a0 1c b1 8b e8 97 c6 dd fc 90 0f 0b 48 89
RSP: 0018:ffffc90003a1fbe0 EFLAGS: 00010286
RAX: 000000000000004e RBX: ffff88801febb580 RCX: ffffffff816c6699
RDX: 0000000000000000 RSI: ffffffff816cf7b6 RDI: 0000000000000005
RBP: ffff88805f5a8000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: ffff88801febb588
R13: dffffc0000000000 R14: ffff88805f5a8618 R15: ffff88801febb580
FS:  0000000000000000(0000) GS:ffff8880b8900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000202f5000 CR3: 0000000060a82000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

