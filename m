Return-Path: <linux-kernel+bounces-199180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D32D18D8376
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85FF6286EAB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A298B12FB2A;
	Mon,  3 Jun 2024 13:05:36 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0BF12EBCA
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 13:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717419936; cv=none; b=mZqdH/dCTverndrwBTxuzbpdLoYmtwJrcd0KBf9szrVxTaQAYJuGy3LABrAaol0wWuzm/oei8oE1ZfQwDUM+i0FRzzhgmsA/Y4Vq0o0++evSlMhwnF9hzw8TaM1j6/H3k4JhZaKslxDxQA7CwLGiG0KTkl43Hi3g6cfbhb8PXLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717419936; c=relaxed/simple;
	bh=kwXisx3FChpIdq6riPDIHN7Hpyg71rGb5Cy66/vGrUk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=C9gmVXT2tPK9mQ5B2TYPp5dw+cGyZYiccSddFEHEEheSzM914oSmY6SUjTpXPeitz3b7V2Rl7eukzBgNybuH2yGSEhuHh05QnGOp/TKHWxjoCiqhCfcxqABJtmua/7KYTN7k/HZ7oyyWmYHl0VBvD6jYK9khldRBCqtRcnfqGC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3737b6fc28fso38411895ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 06:05:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717419933; x=1718024733;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3In1caMHcBatVDW10Ufogn0gt1LzxAc09r1QBMG0KHs=;
        b=ny+nMjpEBFLfg/Ig7xsZSgarOP4tUbsnvYgu0ii3MxJMC3yur1lYuH2o1TYJphzuBz
         9/c6mlvdyl3IzFPhlOnQ9iBxueVyAIDhTH+EQXJ1OBbPmIHGnW1wTI94rkgKrBTNicWi
         WFyeQQada+Q/qWS0ijalK3ehPZExtd3AYwSH7KNipJLHMV7dZ5dmVDBN25WUs5Zu1Uca
         MaeUmqZt7Cf56P8lp8PYaFSolXS9WfPfv/4rK9MlS/P5Y9Ws1zeKIn2WcyMjUhQrH4ft
         4p93YzWwgJ8ZQ35tQ+xSt2Nshzq1MGaMr2ajOZmU8ccDi+Y1tsttoQQqwhrF7BNeiXwg
         f6HA==
X-Forwarded-Encrypted: i=1; AJvYcCXPkgR+W0tDLftoJqlSkmwrctaTOGNVqkeoh0l1d4cnv0Os/a0X/g9stEF3LEQZ5RVCaB9HLv5j8DRSEGghD5+UULgLPE1bggmM9HPM
X-Gm-Message-State: AOJu0YyzaKbikJDbEFsxNBK4eoRbufjqnqnTKJ1YqYgDN6Kv+/XnaoRb
	9gh6jI6iuGlfRcKCfwD4zvmla4KUHcJvCgc+Coxu0RwOTnkaHm331AoNXHIoMaJW0mc3/uNc2lF
	h/f9lYO4ADM/qnYAaAGjqCh5wIi8QGdj3Kx1z0KqeyDTyUp0iT/VxGZg=
X-Google-Smtp-Source: AGHT+IFKN/zN6uKn7iRKWStWfc6K5wFO1iCjkuQtB0/fSIf7gsI1ftXNPrnL8Aoa2I5NOPeWFDkaCGlUEO61kIyLBA7bC6XWGkQp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2390:b0:4b5:14e4:3ae with SMTP id
 8926c6da1cb9f-4b514e406b3mr444499173.2.1717419933729; Mon, 03 Jun 2024
 06:05:33 -0700 (PDT)
Date: Mon, 03 Jun 2024 06:05:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001496dc0619fbfdda@google.com>
Subject: [syzbot] [bcachefs?] UBSAN: array-index-out-of-bounds in lock_timer_base
From: syzbot <syzbot+6a038377f0a594d7d44e@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    83814698cf48 Merge tag 'powerpc-6.10-2' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1654ce06980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=733cc7a95171d8e7
dashboard link: https://syzkaller.appspot.com/bug?extid=6a038377f0a594d7d44e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-83814698.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7042fdcb685d/vmlinux-83814698.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9f795e13834f/bzImage-83814698.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6a038377f0a594d7d44e@syzkaller.appspotmail.com

bcachefs (loop0): shutdown complete, journal seq 18
bcachefs (loop0): marking filesystem clean
bcachefs (loop0): shutdown complete
------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in kernel/time/timer.c:962:9
index 24 is out of range for type 'long unsigned int [8]'
CPU: 0 PID: 11510 Comm: syz-executor.0 Not tainted 6.10.0-rc1-syzkaller-00304-g83814698cf48 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:114
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_out_of_bounds+0x110/0x150 lib/ubsan.c:429
 get_timer_cpu_base kernel/time/timer.c:962 [inline]
 get_timer_base kernel/time/timer.c:991 [inline]
 lock_timer_base+0x206/0x220 kernel/time/timer.c:1050
 __try_to_del_timer_sync+0x8d/0x170 kernel/time/timer.c:1506
 __timer_delete_sync+0xf4/0x1b0 kernel/time/timer.c:1665
 del_timer_sync include/linux/timer.h:185 [inline]
 cleanup_srcu_struct+0x124/0x520 kernel/rcu/srcutree.c:659
 bch2_fs_btree_iter_exit+0x46e/0x630 fs/bcachefs/btree_iter.c:3410
 __bch2_fs_free fs/bcachefs/super.c:556 [inline]
 bch2_fs_release+0x117/0x820 fs/bcachefs/super.c:603
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1fa/0x5b0 lib/kobject.c:737
 deactivate_locked_super+0xbe/0x1a0 fs/super.c:473
 deactivate_super+0xde/0x100 fs/super.c:506
 cleanup_mnt+0x222/0x450 fs/namespace.c:1267
 task_work_run+0x14e/0x250 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x278/0x2a0 kernel/entry/common.c:218
 __do_fast_syscall_32+0x80/0x120 arch/x86/entry/common.c:389
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf72bc579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ffba0958 EFLAGS: 00000292 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ffba0a00 RCX: 0000000000000009
RDX: 00000000f7412ff4 RSI: 00000000f7363361 RDI: 00000000ffba1aa4
RBP: 00000000ffba0a00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
---[ end trace ]---
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


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

