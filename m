Return-Path: <linux-kernel+bounces-446554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE559F260B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 21:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E9A1164B75
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 20:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62071BC9F6;
	Sun, 15 Dec 2024 20:34:23 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D891B0F33
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 20:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734294863; cv=none; b=WGAlEPSSvWqajwexRr4yWAu2QGSd25bRfp5djY6o3kJfJQvlIIWKuqN4Qr6mSTNvxvoYE0FvWGzbiKyOF3VgpeoueAkO/xF9YTAS/O1JWspdVlj3XlpIU5/Pxb7n70FCKhcw8PqtlJKepFolxYjRwDCLRguMBAuFuXi3xlp7sfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734294863; c=relaxed/simple;
	bh=Waxxm3a03RHGWskTJV98NxUCkL7ROLnmm6efw8OOYHc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WQXRTlzi9mND8auwfzbsTCBzg3u9Z2YPKDxxjBs2ARbkxIvvvmEjJvIkrWdABx5HPc9xKktqbk7E+0vrjnMjGVz1EfCsZ5Jc6ZGOfLdc3arr5qU80MMUVpcHAczFz1g8s8izRxPpyZXkUq8FyVb+87XZWIXfisay0/OUa9TzZmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-844d54c3e62so606925639f.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 12:34:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734294860; x=1734899660;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5dSjkkiQNsIWrWIqrh0S/fXKzopFI5nimNNSb7MyngE=;
        b=EU+VY0Av1f90v1BPwavnysXKu5Yxm+Jg9ast4ZHChuwYoHfYKFGNraiGi0FfFWonye
         S63yS0ZHoOE/FCBiSTxNjkdBT3lWPopxd14YR+XSTI/B2O2d5uhCUTyfNu2PMy2S375l
         uLBmK/2Wq+75uj3ZsXCcHGpy9iDf/N99YNS+r1ihlO92odjtufQ5rv4lV3B2v84ewx2k
         eaQ8Cmt2MHYoUHosUcnl9BJ4cme4/eeBoLoyXPjV7gUAFz+ecfSHSJ4dzsAmtvQ0l1Cp
         s5y6/6CYmtuTFSN5QbJX8/CSz3PhI9IJESmpzxgrso2Cp1duXCqWjIlSzo+ne/jUUbrN
         V7kg==
X-Gm-Message-State: AOJu0YwUlf14WkVdpcqSy+cJIR0G3UBvg4ICtNcDbzIP+bHn3kzeCSnU
	+3fqxwwnZAmYmPk0MuaWewKE131EIqIp7pXmORk0d6ZxaMcHD6pWMomDlHXENNbOKV2MFqLN3Gg
	DBeYsLuwgPUqCJu3BTnC0vk2qUlVZqRluWE2HD0bueherM22goJfqv0nVaQ==
X-Google-Smtp-Source: AGHT+IEfjwrujsZStOAZTnTtsItcJk3oZFrIZ6DB3Gp0HviM7eUu07ATY/n75HfkE5f83Zo+SUDdMUGTQE64hkvRzRImQJGgqAd5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1561:b0:3a7:6e72:fbb3 with SMTP id
 e9e14a558f8ab-3afeda2e98emr104856965ab.4.1734294860681; Sun, 15 Dec 2024
 12:34:20 -0800 (PST)
Date: Sun, 15 Dec 2024 12:34:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675f3d4c.050a0220.37aaf.0104.GAE@google.com>
Subject: [syzbot] [trace?] WARNING in tracing_buffers_mmap_close
From: syzbot <syzbot+ddc001b92c083dbf2b97@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f92f4749861b Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15d92cdf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99a5586995ec03b2
dashboard link: https://syzkaller.appspot.com/bug?extid=ddc001b92c083dbf2b97
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12de78f8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17d92cdf980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b85403132ddc/disk-f92f4749.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/20613d034287/vmlinux-f92f4749.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d1ea80bf7e4e/bzImage-f92f4749.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ddc001b92c083dbf2b97@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5829 at kernel/trace/trace.c:8464 tracing_buffers_mmap_close kernel/trace/trace.c:8464 [inline]
WARNING: CPU: 1 PID: 5829 at kernel/trace/trace.c:8464 tracing_buffers_mmap_close+0xe3/0x130 kernel/trace/trace.c:8459
Modules linked in:
CPU: 1 UID: 0 PID: 5829 Comm: syz-executor210 Not tainted 6.13.0-rc2-syzkaller-00031-gf92f4749861b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:tracing_buffers_mmap_close kernel/trace/trace.c:8464 [inline]
RIP: 0010:tracing_buffers_mmap_close+0xe3/0x130 kernel/trace/trace.c:8459
Code: 75 46 48 8b 7b 08 e8 7c 85 ff ff 31 ff 89 c3 89 c6 e8 21 63 fb ff 85 db 75 0a 48 83 c4 08 5b e9 d3 60 fb ff e8 ce 60 fb ff 90 <0f> 0b 90 48 83 c4 08 5b e9 c0 60 fb ff e8 bb e7 5d 00 eb 87 e8 e4
RSP: 0018:ffffc90003857bb8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 00000000ffffffed RCX: ffffffff819ddd0f
RDX: ffff8880339f3c00 RSI: ffffffff819ddd22 RDI: 0000000000000005
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000ffffffed R11: 0000000000000000 R12: ffffffff819ddc40
R13: 0000000000000001 R14: ffff88807610a548 R15: 0000000000000ff9
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f44ec4e1110 CR3: 000000000db7e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 vma_close mm/internal.h:147 [inline]
 remove_vma+0x91/0x1b0 mm/vma.c:380
 exit_mmap+0x4e2/0xb20 mm/mmap.c:1692
 __mmput+0x12a/0x4c0 kernel/fork.c:1353
 mmput+0x62/0x70 kernel/fork.c:1375
 exit_mm kernel/exit.c:570 [inline]
 do_exit+0x9bf/0x2d70 kernel/exit.c:925
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1087
 __do_sys_exit_group kernel/exit.c:1098 [inline]
 __se_sys_exit_group kernel/exit.c:1096 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1096
 x64_sys_call+0x151f/0x1720 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f44ec464b49
Code: Unable to access opcode bytes at 0x7f44ec464b1f.
RSP: 002b:00007ffc68920f08 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f44ec464b49
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
RBP: 00007f44ec4e02b0 R08: ffffffffffffffb8 R09: 0000000100000000
R10: 0000000000000012 R11: 0000000000000246 R12: 00007f44ec4e02b0
R13: 0000000000000000 R14: 00007f44ec4e0d00 R15: 00007f44ec436160
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

