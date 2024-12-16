Return-Path: <linux-kernel+bounces-447108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F16729F2D69
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05B237A2375
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC1B202C22;
	Mon, 16 Dec 2024 09:53:25 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3133120101F
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 09:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734342804; cv=none; b=MHvfbQtJO4XS5lCm2VrDxWVoazh5c66nwQf4PyFAo/4YQOV6adWN4I7aPd0S8/CB24vUuzyLuW4eMVcGLzdvBaww0e4X6xCTtaUbcfQdYoHtPCIK5424DznuI514b8YIjRsTlSKVswJV5qVr9kxVZdwAeU1fRu30RBOPn+lhgjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734342804; c=relaxed/simple;
	bh=/MLg2COHMjsZCod1ruY47lBuhT2RIi1o93WT9dXfDFY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QrXmnMdYngMUFRKT77cN1MRollrlu45pqBgeVY/h7WgpuAvZg987Rc72WZjf4SeNBGSKZ4f8Uz+3ruPrwcnWqUAsGkIQ93GepLyUJgF02Y8Cw+dYDqtheP3CLQ27Jn4Vuac5+AIkjk0Zq4s6RFgxdn3pdwCYDZ6YuNGXJvapRzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3a9d075bdc3so76298845ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 01:53:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734342802; x=1734947602;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fjvZ2fR7d5U5v00o1JgKQWfzqz7EVTL2oI8L3s5YqcE=;
        b=ch47qflLj+SeRig9ApoNSzE2QEAe1myYGvcwoCU1vGU5I0o5boPDXwpddrYwmxfls1
         jmBZ3cLsnbnWugN5Snh9ZMBF6suB1WUj3E5/nU/zXK2JrWsOw8LoPaIk3Gg9nB3sAZEk
         7fFDvJDQ65ooZW9vwhx4qBPyAAAxB+EztbjIoZgF1Yq+dEMBpeAvFfR8ce1OSSE7UJTQ
         IpvrZ+ONWow5Wpz6w7P0nHutFbEB4hhJc+aCEDb6yWd8caKRDVB6AxrBTGOhfcQ/hB1B
         Vb7sMPbaNFC3KILAM8M8m0OjdcYuEyS+LnF2/8BVU57kxrXY5OOCPhQln8SYfj7swgKq
         K3AA==
X-Forwarded-Encrypted: i=1; AJvYcCXI0r/6WKsfUYXHRMHUDVc+6PT4PuNTWdbuunf89CnAwtzjMVzKV74lKD9Ggd7fjmKI9bkANk04yA+b9bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoVRNXtyEiCU1Ploc2WU75H4CCReTHLoZ8OhDjtlbPVhEBN0eG
	CfBGM39gsgLw6YN9yedyb0HQZlRWMGnzsBymP0fUXed17m/0kM8fpbAKwT5xCWiuXdbN0SzkIQZ
	F5iK3+x8P35QCE0nCwQCQnWh76MZjt6c3tsfjKM626ZbzPUUCweqBQ9w=
X-Google-Smtp-Source: AGHT+IG/G6LOhXmDucogI9EtALgmvb5IlZcGI8ijU6zAcBdIy38k5V86u92tZSW75gS8pNoMOQGits6pkg0/WL8Rcz3CXWUwN0OH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2188:b0:3a7:8cc2:9a84 with SMTP id
 e9e14a558f8ab-3aff4619ab5mr123996095ab.5.1734342802382; Mon, 16 Dec 2024
 01:53:22 -0800 (PST)
Date: Mon, 16 Dec 2024 01:53:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675ff892.050a0220.37aaf.012a.GAE@google.com>
Subject: [syzbot] [tomoyo?] BUG: corrupted list in tomoyo_try_to_gc
From: syzbot <syzbot+e92661ab419d1a81b816@syzkaller.appspotmail.com>
To: jmorris@namei.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	penguin-kernel@I-love.SAKURA.ne.jp, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp, 
	tomoyo-dev-en@lists.osdn.me
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f92f4749861b Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=132a7b30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99a5586995ec03b2
dashboard link: https://syzkaller.appspot.com/bug?extid=e92661ab419d1a81b816
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b85403132ddc/disk-f92f4749.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/20613d034287/vmlinux-f92f4749.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d1ea80bf7e4e/bzImage-f92f4749.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e92661ab419d1a81b816@syzkaller.appspotmail.com

list_del corruption, ffff8880258fb100->next is NULL
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:52!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 9271 Comm: GC for TOMOYO Not tainted 6.13.0-rc2-syzkaller-00031-gf92f4749861b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:__list_del_entry_valid_or_report+0xea/0x1c0 lib/list_debug.c:52
Code: 0f 85 ae 00 00 00 48 8b 42 08 48 39 c6 75 5f b8 01 00 00 00 48 83 c4 18 c3 cc cc cc cc 48 c7 c7 c0 59 b1 8b e8 67 f9 da fc 90 <0f> 0b 48 c7 c7 20 5a b1 8b e8 58 f9 da fc 90 0f 0b 48 c7 c7 80 5a
RSP: 0018:ffffc900041c7e00 EFLAGS: 00010282
RAX: 0000000000000033 RBX: ffff8880258fb100 RCX: ffffffff8178d119
RDX: 0000000000000000 RSI: ffffffff817978a6 RDI: 0000000000000005
RBP: ffff8880258fb100 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: ffff8880258fb110
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000008
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555584206808 CR3: 000000007cd4a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 tomoyo_try_to_gc+0x21/0xcd0 security/tomoyo/gc.c:395
 tomoyo_collect_entry security/tomoyo/gc.c:599 [inline]
 tomoyo_gc_thread security/tomoyo/gc.c:619 [inline]
 tomoyo_gc_thread+0xd3b/0x1390 security/tomoyo/gc.c:612
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid_or_report+0xea/0x1c0 lib/list_debug.c:52
Code: 0f 85 ae 00 00 00 48 8b 42 08 48 39 c6 75 5f b8 01 00 00 00 48 83 c4 18 c3 cc cc cc cc 48 c7 c7 c0 59 b1 8b e8 67 f9 da fc 90 <0f> 0b 48 c7 c7 20 5a b1 8b e8 58 f9 da fc 90 0f 0b 48 c7 c7 80 5a
RSP: 0018:ffffc900041c7e00 EFLAGS: 00010282
RAX: 0000000000000033 RBX: ffff8880258fb100 RCX: ffffffff8178d119
RDX: 0000000000000000 RSI: ffffffff817978a6 RDI: 0000000000000005
RBP: ffff8880258fb100 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: ffff8880258fb110
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000008
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555584206808 CR3: 000000007cd4a000 CR4: 00000000003526f0
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

