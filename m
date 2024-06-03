Return-Path: <linux-kernel+bounces-199179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F548D8375
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FF1D2879B4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475AC12F5A5;
	Mon,  3 Jun 2024 13:05:36 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F2212E1CE
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 13:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717419935; cv=none; b=CfQJEE+SIeZG2GbPn3hjMWWC72jG/oGvv0Gk1cZcDeJB2hesWX94qige5kV93yv9jlGApI/LZln0IHNwBD/rmOoX9ESZTw4P7pMw5p47RhFxvaUeZifgWQNUjGRRb5DR+sMuXflyJMt3ykHaffekZ2ZI/idiF7CjkrfCyoim7F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717419935; c=relaxed/simple;
	bh=GGXIS43I0zsX8f75IYYSxjD+wpX63LnGIkMT2rm3gOY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qkS3wv6QpZvWw/we6xxHDQBmCHc1sbyeXp+b9f8O+v7DVQii/sppQUABsZiE/SBFVFGL73ycU6JDN8ZYklJKG7FtFhLgzLWevvquSJiuxvCtEqQY44S/Mob4u44QautfC2qVAr3Pdn2xU49NXgJoJ1SGssA+PQ+rSWbbWfXtPc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7e94cac3c71so566403839f.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 06:05:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717419933; x=1718024733;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lyApTqVpnjHFauUmZhI6S1Q/5ll7GTJ71tXhGvRdsj8=;
        b=EvYH678ZuB7X/YlSTwb7x0+oVNWq/I5yiKuTk47oQ4FU0yyRfZE1lYyz4mprSp6r52
         q2rqbtliJgkUMyHvIVLgohai6kAcRODua/BJ5KGZkWnapM01qeyTtoRfxEsAeSEA6cO3
         DhtQLIS0tlRMfQQ8VS6lIOM1Fx2MXarBw87n1B058EzsO/XdEsp/mojGMJsDZWGvxlPl
         KEpLXlLBV3Y2Ph+lHIlB10EYZeWlFVgx1FVsf08exP2JWxREdfv3Ia1ty6LgdqPORw77
         J00zvXLFgiQtBZaxQVja05nxl8Y/KJMVQ8O8s/ewGvw1/8LnurDjmXhCIVyQAwEAZ5pC
         QnLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZ7gbUqI9onaPsazN9j8stTQkalcZkdj5qizB2yRTwm81lo6O40O++slzu1iRMWxjHDv/63StPoXVVLzKxq4cobYEnEI2z1oeCPeWO
X-Gm-Message-State: AOJu0YzX7O/15KmPOclX/+UyhOuSDpqd4UUML6/bhh8CGx3BiVOkECGh
	SGJc/bct8mRwC8Fe+vxgKqli5lX0/Q/hlKfKTZph9TPUClZPiYPzi/8NjwbI5iot1F/veSj6BZv
	y4SJtitiv7ADxm7E/Hk3G6qJSzPVQYpaMLyo1UNdDQjumZkRy2P5Ajgc=
X-Google-Smtp-Source: AGHT+IH8MHINmDPBrb3n7A7puYV/A4rJgDT2psoeD5h5FTpxh5hvA0lOdtCOPdHGlgq3Yai2wguaGKouoHI9wcCcoIq7DCdbNGbI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3410:b0:7de:d6a0:d48b with SMTP id
 ca18e2360f4ac-7eafff21485mr35457239f.3.1717419933470; Mon, 03 Jun 2024
 06:05:33 -0700 (PDT)
Date: Mon, 03 Jun 2024 06:05:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000109e6b0619fbfd44@google.com>
Subject: [syzbot] [mm?] kernel panic: corrupted stack end in userfaultfd_ioctl
From: syzbot <syzbot+5a1cb2c00e895afca87e@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4a4be1ad3a6e Revert "vfs: Delete the associated dentry whe..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=104284f2980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd6024aedb15e15c
dashboard link: https://syzkaller.appspot.com/bug?extid=5a1cb2c00e895afca87e
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=124e1664980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15683162980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-4a4be1ad.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/75957361122b/vmlinux-4a4be1ad.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6c766b0ec377/Image-4a4be1ad.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5a1cb2c00e895afca87e@syzkaller.appspotmail.com

Kernel panic - not syncing: corrupted stack end detected inside scheduler
CPU: 1 PID: 3188 Comm: syz-executor396 Not tainted 6.10.0-rc1-syzkaller-00027-g4a4be1ad3a6e #0
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
 preempt_schedule_irq+0x3c/0x80 kernel/sched/core.c:7067
 arm64_preempt_schedule_irq arch/arm64/kernel/entry-common.c:301 [inline]
 __el1_irq arch/arm64/kernel/entry-common.c:539 [inline]
 el1_interrupt+0x4c/0x64 arch/arm64/kernel/entry-common.c:551
 el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:556
 el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:594
 __rcu_read_lock+0x0/0x14 kernel/rcu/tree_stall.h:125
 pte_offset_map_nolock+0x38/0xb0 mm/pgtable-generic.c:314
 move_pages_pte mm/userfaultfd.c:1160 [inline]
 move_pages+0x330/0x13a4 mm/userfaultfd.c:1733
 userfaultfd_move fs/userfaultfd.c:2016 [inline]
 userfaultfd_ioctl+0x6f4/0x1ed8 fs/userfaultfd.c:2134
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __arm64_sys_ioctl+0xac/0xf0 fs/ioctl.c:893
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

