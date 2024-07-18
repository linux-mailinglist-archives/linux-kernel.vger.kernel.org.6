Return-Path: <linux-kernel+bounces-256854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D42E937140
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 01:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CC631F21DD3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 23:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763FE145B16;
	Thu, 18 Jul 2024 23:46:31 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D5423B0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 23:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721346391; cv=none; b=rwN5tjVFG6RAa98fsrHWpOndV68dFZlL3dK17u5NwLvio2s34g/rE40hp0Al2YlBGdwl89ZU3ah4OeA9YNcR0ZiiAk4j8wwZp9rku242V5Ztz5jCyQyfU+FVy1nxjm8gl4DAMkjlsCYqc+K4ZSGnwq06p+WCO/+Py8CPAdrhZrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721346391; c=relaxed/simple;
	bh=gJmpshv4GAFBGAl9hzeD2tTQEdzcjyiHJyaEnhLXAWQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=k/AAhiEVleZFGbIiHsH6Na4LHxB93Cq1p0Qtv5S7MWIbzHcpt7v3G3dleuQoGD5OUO+Ug9tea4I1zkKcfoEfCwexgia4y0WYQ9TnEsvEIMQPHo08FFD1KQ7KHYQYi/9lLNZIQpmnPWt1+zb5qGXoIFBGt494/ningLY3TNvJVyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f66b3d69a8so192622139f.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 16:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721346388; x=1721951188;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JLJPeJicTo7Y3lkiKGygMKBIO5041ebchnwstxDTU0s=;
        b=IqHr1aYs1gKJI1FoGDjPYvQzCWRDpwK6rmYbMYJQwHnO7Pezd0JdOknIMKA3bGqDp5
         /R1y7S2oJQnzMFNv6823NPgtmlTSdGk/8fYdxEUEcauPhfpXUWJJRaeUdUvw4aXRENt6
         J//w2Myoi82GPnnvK7FkikeOmIT+hDUFYIgOn4dgYceOPE+VcNDD3SyQu09GRQcs3Tst
         haIlwvaVoHgFMDtkA9XZalk4RoSbh21Kkw9iMnLiuw2jJ/gRNdTgASyGdl9s1efQUHi8
         Cz08ZHF6+0cTPt8hWUwNpxAL2C1Poa2kTmvndUJKQ4Afcxz56aweKby2ZF70jnbujjDB
         YHXg==
X-Gm-Message-State: AOJu0Ywv+6LUx8fxFR9It/CJ3jOKMtveD2fYfpHQE6bU3MQ2r2Gj91oV
	kXvSRt/c7UOQIuR5UC67oGUgKup8MIg5sQHbV66iX/7EYV+uLnsJ0jVopSC6wA2UA4qVLtz/cT1
	z9+W3zCr/xqJx0YkazNqzJd8LMC3u6xIIQSdCoUoVtqlMwDClyVn2UYc=
X-Google-Smtp-Source: AGHT+IGggvxk4Lyq9KFhJqkQA3u3fOh2jhaNcH6n2fPSaLuiV8Le1xpf2/8TLhw/HpcEW/0ZvMiZn0SMvXt+w9nsMvZJZ0TkgBXI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8602:b0:4bb:ae73:2783 with SMTP id
 8926c6da1cb9f-4c2158e850fmr220752173.2.1721346388706; Thu, 18 Jul 2024
 16:46:28 -0700 (PDT)
Date: Thu, 18 Jul 2024 16:46:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000008d69a061d8e309d@google.com>
Subject: [syzbot] [kernel?] BUG: sleeping function called from invalid context
 in get_signal
From: syzbot <syzbot+6aa87a8fac30c3c9f11a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, luto@kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3fe121b62282 Add linux-next specific files for 20240712
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13b492e9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98dd8c4bab5cdce
dashboard link: https://syzkaller.appspot.com/bug?extid=6aa87a8fac30c3c9f11a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8c6fbf69718d/disk-3fe121b6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/39fc7e43dfc1/vmlinux-3fe121b6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0a78e70e4b4e/bzImage-3fe121b6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6aa87a8fac30c3c9f11a@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at include/linux/freezer.h:53
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 9483, name: syz.2.933
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
INFO: lockdep is turned off.
CPU: 0 UID: 0 PID: 9483 Comm: syz.2.933 Not tainted 6.10.0-rc7-next-20240712-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 __might_resched+0x5d4/0x780 kernel/sched/core.c:8526
 try_to_freeze include/linux/freezer.h:53 [inline]
 get_signal+0x1a8/0x1740 kernel/signal.c:2702
 arch_do_signal_or_restart+0x96/0x830 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7d27f75bd9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7d279ff0f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: 0000000000000001 RBX: 00007f7d28103f68 RCX: 00007f7d27f75bd9
RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00007f7d28103f6c
RBP: 00007f7d28103f60 R08: 7fffffffffffffff R09: 00007f7d279ff6c0
R10: ffffffffffffffff R11: 0000000000000246 R12: 00007f7d28103f6c
R13: 000000000000000b R14: 00007ffea17fd0c0 R15: 00007ffea17fd1a8
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

