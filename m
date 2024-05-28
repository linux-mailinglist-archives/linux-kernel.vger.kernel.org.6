Return-Path: <linux-kernel+bounces-192266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 169918D1AD9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6627BB285F8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B205E16D4CD;
	Tue, 28 May 2024 12:14:31 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32B817C74
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 12:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716898471; cv=none; b=SzlbGJbKUuYbI2Sh2Kthr55QnoJ4PznwaolwkvKrABeb4H5tbkf50f0IRlP2qiACnR72eu082ounSQ64IwIUCr2PVnsRu0euOHwsc6QGFs2utiS6wBDNJUvBi2OORIrovnhe0S1Ct3EZ66RIILyJxJ27DF6sOQZKlgtOe3nWyU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716898471; c=relaxed/simple;
	bh=LtSacNp57SLS4yfMkPy/88D4FhfTbHVjvWA6XgAic8g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dkc2v5MMTY4c4hpWFQvWlCOSVZf52Curhj0xyUAiJXE3MQrdr6tMOqlfqciZWb2no4/yLmfBH0rWLa61uS2xpUdq55qoVlax4KvW7TqW9u9BRa41xfZ/E3kO6G0WXLIouveL4yBLP5QsULvzDiZR2V44dNGzXn8XhzP8rvfx/w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-373809cc942so8798235ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 05:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716898469; x=1717503269;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nBoELtFaaD6dpHcqAfxGvFoe0UCtEZxtz5UswNCthsA=;
        b=jAbtxgKznVYB5KSDW3hUtf71yfMxzNJzYyoTJquVYeHYC4/S6mjtq3MkygO10C5DqF
         Wa2EXUG55lIeCtyCW8YmQ9UIe73vZgByJaPboIjB90o3XK3PsRP2ayLC2wA/67/5Y+mw
         3nGbKmxkD59+gAP4AojdH+b0C7itPDNbUjn/RBhjYYl5xB9r+zy1D9f23qCjVqARlTo+
         MRneEYmd8JBmNsEyaqsLM3mcUAxplkdZmaIU9VqNkoUORQggfgewRuyzoDs9U8oLL1JM
         EUlIDQGANpj+GRSVK0TJmFli2CgRlOyt4WzAHcjrsNmQF7B5h+D4qVq/JfrSl61VkfWY
         R/tA==
X-Forwarded-Encrypted: i=1; AJvYcCUjEQyJge6JaEpgy0ISXE4jaDGS11S15hPiHcmkQ23XT0nbPtdXK0nzmbmr6d+o5ZTc5/V74Wk+muJWlwLW2miMv3WzYzKdB8AlvCT7
X-Gm-Message-State: AOJu0Yxl0d+AuZPY4kWZalq7LzUMtwMANfO1JhD0vJp4Z6NAD9UZz2BA
	sb0CL/NeFOIgJQ7N7josQGEH1uYMsA97aAHuNrpnnizab/HjdEOJT4AfxjrtEzahAbxjcKgB9l/
	4MiWd166O4L7wFZXiEsJNr+XWW5EJK9hwA1y8F4gddVkCOk0jTSH/36I=
X-Google-Smtp-Source: AGHT+IEZez8jDjBPseG4a00I5tMK7mKP5gPkWs5c5IjUK5FA7v321QJbOXHSAw6y23ibBYv2mP3gmpzbubV99ICNpyBNL53eK4RI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca0d:0:b0:36c:4b17:e05d with SMTP id
 e9e14a558f8ab-3737b3fe339mr11151305ab.4.1716898468995; Tue, 28 May 2024
 05:14:28 -0700 (PDT)
Date: Tue, 28 May 2024 05:14:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005c31f5061982931c@google.com>
Subject: [syzbot] [kernel?] kernel panic: corrupted stack end in sys_clock_nanosleep
From: syzbot <syzbot+5262420a20b007a770ca@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, frederic@kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6d69b6c12fce Merge tag 'nfs-for-6.10-1' of git://git.linux..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11043952980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=21de3d423116c304
dashboard link: https://syzkaller.appspot.com/bug?extid=5262420a20b007a770ca
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=162b06e8980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ddd8fc980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-6d69b6c1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9fa4d7c3665d/vmlinux-6d69b6c1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/131ac291917c/Image-6d69b6c1.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5262420a20b007a770ca@syzkaller.appspotmail.com

Kernel panic - not syncing: corrupted stack end detected inside scheduler
CPU: 0 PID: 3188 Comm: syz-executor251 Not tainted 6.9.0-syzkaller-12124-g6d69b6c12fce #0
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x94/0xec arch/arm64/kernel/stacktrace.c:317
 show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:324
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x38/0x90 lib/dump_stack.c:114
 dump_stack+0x18/0x24 lib/dump_stack.c:123
 panic+0x39c/0x3d0 kernel/panic.c:347
 schedule_debug kernel/sched/core.c:5962 [inline]
 schedule+0x0/0x104 kernel/sched/core.c:6628
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x34/0x104 kernel/sched/core.c:6837
 do_nanosleep.constprop.0+0x7c/0x138 kernel/time/hrtimer.c:2028
 hrtimer_nanosleep+0xa4/0x114 kernel/time/hrtimer.c:2081
 common_nsleep+0x44/0x6c kernel/time/posix-timers.c:1350
 __do_sys_clock_nanosleep kernel/time/posix-timers.c:1396 [inline]
 __se_sys_clock_nanosleep kernel/time/posix-timers.c:1373 [inline]
 __arm64_sys_clock_nanosleep+0xcc/0x144 kernel/time/posix-timers.c:1373
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x48/0x118 arch/arm64/kernel/syscall.c:48
 el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:152
 el0_svc+0x34/0xf8 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:598
SMP: stopping secondary CPUs
Kernel Offset: disabled
CPU features: 0x00,00000006,8f17bd7c,1767f6bf
Memory Limit: none
Rebooting in 86400 seconds..


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

