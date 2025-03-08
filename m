Return-Path: <linux-kernel+bounces-552165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 848EEA5766B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 01:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C957B1898CE0
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 00:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28066F06A;
	Sat,  8 Mar 2025 00:00:27 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECF3ECF
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 00:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741392027; cv=none; b=VUQrdMWrmcRuX/jpGDNR5TtMXTZjtilMf7orUhZ022uzwpL0S6KM41xghLgo4Kz3Hyxu6zOUwfZBCX8WfZhny9R85+NNFSSjLLx/XQsMcSGGXsgCRescBstEv8Jbxe1VmrorVbfnaQOz2AVyBlG4VTnEWYsDEU/ZqwmXl8HuJtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741392027; c=relaxed/simple;
	bh=RZZHTTxJNgNohtZa1gzDCjg9oeP77kPAHt/LM0u4iM0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EF9uftwaxFspzWYYHac/RyQBE+AvtLSC75Qm719UXURUH4gwtT34ZuFM3kzF0fuOXjBCli485xAU3oeIWBq5vuf9j1av0cyZIN5dv7FdPzoHowogLgxOemujw+ZvC5XYzHNLMfDMqD3Wbjz33/g0cihgrHy6UMmM8u9I8iwk+HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-85adcf079f9so183741739f.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 16:00:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741392025; x=1741996825;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qhQiBx2XYY54oyRylvoG6VkmFq/MljCpnjHyDU43HyQ=;
        b=Rq700hZex+ArGl6BCgS0+4BkGE8IyNleSBactOmV/9YAVRUNb+Hi3RquuYMUF0OmZI
         pLnDcnG7nGawQx1QfmA3lZI5HNAPRkNK1QRKWFNJTCxRvOtKFwEenpMZmXPKB4t7xRHe
         P4EeeEIA2aK8uqW2w0e5DAHoDcj2vnq34JKOldaoWLrK98ZO7ALoO+VZ2xK4tEeVLRnW
         kBa9MHtJJFRZG52rrc/kD6DuxMIPiMetHbc97zJa+EUi/eNZEONPrm3L7byLK8W+cf7U
         Pl1ZAB2NZ0ZnWEeG0PtyQfSZuuDdn/db+XxqjDQ/KxQQ19QzOHBXvYGLSpmIAXXfzwrA
         WtNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhfBdgz2TxnM6FtcLLTfbDNc1t0BnfrHOgyHSKVHvSd/zcFhbYNap7DltKANLqJgmfZLDca0sj2dnKVnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTunouiCn9OuT9WSdhcTcd53Mhg5JQDuaehHQJY79J+dDLwRBo
	Vbu7+IU3NzZObGkUM8Pr9o9bdKhF9bRAEZCHo/CzGQC8YevfBNlidrLnVdjYyM6NGcvTBD9auqa
	yQ0SJAzW1qkUxhwiUET7ki8sLQKe8tCP4oZ+iLJT++lDuR+t5GOwn4RY=
X-Google-Smtp-Source: AGHT+IFuXSZNH7lFGeb2uC0o3NbegtdSNLltHPGb24D67kfSiB2v58DHRJ34JaRhGi/lHGS2RGeUzPrEkc/ah40XwSaIH6NJnpLT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:741:b0:3cf:bac5:d90c with SMTP id
 e9e14a558f8ab-3d441a06f4dmr78268705ab.18.1741392024490; Fri, 07 Mar 2025
 16:00:24 -0800 (PST)
Date: Fri, 07 Mar 2025 16:00:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67cb8898.050a0220.d8275.022a.GAE@google.com>
Subject: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in dbAllocAG (2)
From: syzbot <syzbot+fe8264911355151c487f@syzkaller.appspotmail.com>
To: axboe@kernel.dk, jfs-discussion@lists.sourceforge.net, kristian@klausen.dk, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7eb172143d55 Linux 6.14-rc5
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12dc6464580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=523d3ff8e053340a
dashboard link: https://syzkaller.appspot.com/bug?extid=fe8264911355151c487f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16dc6464580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1336afb8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0e7164e018a2/disk-7eb17214.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/30ec438ad743/vmlinux-7eb17214.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9b0e3bf8e8fd/bzImage-7eb17214.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/68478e58b8d0/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=14dc6464580000)

The issue was bisected to:

commit 2b9ac22b12a266eb4fec246a07b504dd4983b16b
Author: Kristian Klausen <kristian@klausen.dk>
Date:   Fri Jun 18 11:51:57 2021 +0000

    loop: Fix missing discard support when using LOOP_CONFIGURE

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=112be464580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=132be464580000
console output: https://syzkaller.appspot.com/x/log.txt?x=152be464580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fe8264911355151c487f@syzkaller.appspotmail.com
Fixes: 2b9ac22b12a2 ("loop: Fix missing discard support when using LOOP_CONFIGURE")

loop0: detected capacity change from 0 to 32768
------------[ cut here ]------------
UBSAN: shift-out-of-bounds in fs/jfs/jfs_dmap.c:1400:9
shift exponent -335544310 is negative
CPU: 0 UID: 0 PID: 5822 Comm: syz-executor130 Not tainted 6.14.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_shift_out_of_bounds+0x3c8/0x420 lib/ubsan.c:468
 dbAllocAG+0x1087/0x10b0 fs/jfs/jfs_dmap.c:1400
 dbDiscardAG+0x352/0xa20 fs/jfs/jfs_dmap.c:1613
 jfs_ioc_trim+0x45a/0x6b0 fs/jfs/jfs_discard.c:105
 jfs_ioctl+0x2cd/0x3e0 fs/jfs/ioctl.c:131
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7feb3a0bab19
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd2811fb58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007feb3a0bab19
RDX: 0000400000000080 RSI: 00000000c0185879 RDI: 0000000000000004
RBP: 00007feb3a1335f0 R08: 000055557eb534c0 R09: 000055557eb534c0
R10: 0000000000005ef0 R11: 0000000000000246 R12: 00007ffd2811fb80
R13: 00007ffd2811fda8 R14: 431bde82d7b634db R15: 00007feb3a10303b
 </TASK>
---[ end trace ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

