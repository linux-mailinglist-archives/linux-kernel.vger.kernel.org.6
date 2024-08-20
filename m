Return-Path: <linux-kernel+bounces-294308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4963E958C00
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 18:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 001E4284361
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698DD196D9E;
	Tue, 20 Aug 2024 16:14:22 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F53191F89
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 16:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724170461; cv=none; b=Pqj0tyroEaSFRD0wPeefCY2tt5Gzl5Rowf5BzKLFrI3s/31J4fbcoEl7gv6ISv4GymZLP3hIC04/Ps1mFrl608XeWR8YxG2kRn9WupMN2SwfwtUAkBICc6dkXEnmcqZQphDoosXd4PyzdhhL6Ot96ILtlIVDHY4VvT41C7LiNHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724170461; c=relaxed/simple;
	bh=qmZpPKQssSnnxVOOf/JACZt6HrTa+op4bgSqZtBmIjU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hMjf/JS1/VNJOjhzl1gDM5aBAmqcIrv3qt73nc3K0A/dasG6jDey4jz0ylTT3yr+HWdaqBUu9ufre2I+Y1B3OJj1+OxEfGBIxN6NdBXz3atMuz0NpkQSu53heXNzIDE4LpvS0u0es0PvQjjitXwHtVrv51WVHV/ovqyyDhEB7WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f8edd7370so565125139f.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724170459; x=1724775259;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ruz1Bs6j5ttCVVhb4eh5czXf5C2pkJtQnCzRj8OeSvo=;
        b=nH8ryC6qmWRq+lzvFoM+AL/utCwR0YP07w36RABnRx37M+OCw1cRg/abIk5IKAdshn
         es5g4Bo4iY3/RFbfpPDW4Y1Hz7tICMtlA8l1qPCj7il7zHBqfnI9NQ9lgomOnbi6dIlf
         PMn6sGFmLY1gwyijqhEJ1oU5HpSX+ZSF3q7q926Plm5Wp29EG6t9M50lTFUjY+NdV9qc
         +jPSLO03h0oD8rc6J+pG2sNz9K9vIQWV8vxOmdz3EzAK8afN+d4FZkzdPeoNuURP0BAM
         LePD7a2jlSCmVUif4O24O+wmgsV8L3SNwoN4+2j+Z+oO1k5I+h4kNOQsgSj8YVAFhLvv
         gjzQ==
X-Gm-Message-State: AOJu0Yz+zZWoTMCu//KQFMZ4AIRUS8zFv4JDBG2pqAca0VUSjaFbKKVv
	ieJh7DlVdz8s3dUpOZCRxXnLhk4UaOf+oTEf65P4z+RI5//mtrwAVk+cvWWDmg9J9ckI6CeLg12
	RqKgEE9VeBNstidQzDNRck6RFHn9i2rBZQDrnstFnYXGZs1iAGKM7FOI=
X-Google-Smtp-Source: AGHT+IESViIfWhahL6BOilW1yp4MonyV5DsFwzovDNHvSihQxP3Ge2mlFrs4rqBqDf2atcZttTMdbKV91bFUNRoV7dpvZTIg+qHA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:860b:b0:4b7:c9b5:6765 with SMTP id
 8926c6da1cb9f-4cce16eb89dmr936185173.5.1724170459333; Tue, 20 Aug 2024
 09:14:19 -0700 (PDT)
Date: Tue, 20 Aug 2024 09:14:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c2d38506201fb72e@google.com>
Subject: [syzbot] [kernel?] kernel panic: stack is corrupted in __schedule (4)
From: syzbot <syzbot+107a9ed6ac26198d4907@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, luto@kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2c8159388952 Merge tag 'rust-fixes-6.9' of https://github...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1301d2f8980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3d46aa9d7a44f40d
dashboard link: https://syzkaller.appspot.com/bug?extid=107a9ed6ac26198d4907
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c3e1ea802fa3/disk-2c815938.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/08cefa730085/vmlinux-2c815938.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8631cb2022d3/bzImage-2c815938.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+107a9ed6ac26198d4907@syzkaller.appspotmail.com

loop2: detected capacity change from 0 to 4096
Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: __schedule+0x2482/0x4a00
CPU: 1 PID: 16674 Comm: syz-executor.2 Not tainted 6.9.0-rc5-syzkaller-00355-g2c8159388952 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 panic+0x349/0x860 kernel/panic.c:348
 __stack_chk_fail+0x15/0x20 kernel/panic.c:780
 __schedule+0x2482/0x4a00
 preempt_schedule_irq+0xfb/0x1c0 kernel/sched/core.c:7068
 irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
 asm_sysvec_reschedule_ipi+0x1a/0x20 arch/x86/include/asm/idtentry.h:707
RIP: 0010:write_inode_now+0x0/0x260 fs/fs-writeback.c:2801
Code: 96 cd 7f ff e9 9f fe ff ff e8 8c cd 7f ff 90 0f 0b 90 eb a2 e8 71 4c 61 09 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 55 48 89 e5 41 57 41 56 41 55 41 54 53 48 83 e4 e0 48
RSP: 0018:ffffc900110f78a8 EFLAGS: 00000286
RAX: 0000000080000000 RBX: dffffc0000000000 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8880603af850
RBP: 0000000000000010 R08: ffff8880603af8db R09: 1ffff1100c075f1b
R10: dffffc0000000000 R11: ffffed100c075f1c R12: ffff8880603af928
R13: ffff8880603af850 R14: ffff8880603afa58 R15: ffff8880603af8d8
 iput_final fs/inode.c:1728 [inline]
 iput+0x5d7/0x930 fs/inode.c:1767
 ntfs_fill_super+0x3ff0/0x49c0 fs/ntfs3/super.c:1480
 get_tree_bdev+0x3f7/0x570 fs/super.c:1614
 vfs_get_tree+0x90/0x2a0 fs/super.c:1779
 do_new_mount+0x2be/0xb40 fs/namespace.c:3352
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f745fe7f5aa
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 09 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7460babef8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f7460babf80 RCX: 00007f745fe7f5aa
RDX: 000000002001f700 RSI: 000000002001f740 RDI: 00007f7460babf40
RBP: 000000002001f700 R08: 00007f7460babf80 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 000000002001f740
R13: 00007f7460babf40 R14: 000000000001f6cc R15: 000000002001f780
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	7f ff                	jg     0x1
   2:	e9 9f fe ff ff       	jmp    0xfffffea6
   7:	e8 8c cd 7f ff       	call   0xff7fcd98
   c:	90                   	nop
   d:	0f 0b                	ud2
   f:	90                   	nop
  10:	eb a2                	jmp    0xffffffb4
  12:	e8 71 4c 61 09       	call   0x9614c88
  17:	90                   	nop
  18:	90                   	nop
  19:	90                   	nop
  1a:	90                   	nop
  1b:	90                   	nop
  1c:	90                   	nop
  1d:	90                   	nop
  1e:	90                   	nop
  1f:	90                   	nop
  20:	90                   	nop
  21:	90                   	nop
  22:	90                   	nop
  23:	90                   	nop
  24:	90                   	nop
  25:	90                   	nop
  26:	90                   	nop
  27:	90                   	nop
* 28:	f3 0f 1e fa          	endbr64 <-- trapping instruction
  2c:	55                   	push   %rbp
  2d:	48 89 e5             	mov    %rsp,%rbp
  30:	41 57                	push   %r15
  32:	41 56                	push   %r14
  34:	41 55                	push   %r13
  36:	41 54                	push   %r12
  38:	53                   	push   %rbx
  39:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
  3d:	48                   	rex.W


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

