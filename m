Return-Path: <linux-kernel+bounces-415156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F00C69D3219
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 03:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0FAB284084
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 02:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F27D1369AA;
	Wed, 20 Nov 2024 02:12:35 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6741F18035
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 02:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732068755; cv=none; b=hUnO8L0Wj4nLmpKQymDaDk4SmMAwdimbM6Mad998ho+fAIi+hiSuRR14AVjSFqiBITe9i1RqaRfH4UQ10KCSBorKwq+XQVKdwfpTde2gEGoEP8TqDfYazoGzrfC8PU4QPxTZYC+GAwuHqUD/foF7r8PF/DoPLNr5EjPvksT+FXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732068755; c=relaxed/simple;
	bh=kQcOcRvQKSaMOIc9LbCpHY8D4PL8/gepal6C6F8Wdl0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VtE2mJ7zO6BOfTJtrGcqJ3NDMEaAYwQcOFPAzPdbLqeXCh/7RU8XzIrD1EgMC9qHB1fZGLB9d7pdDf8tVW8HH3dw3FtLjOsFKEhNQr4VksSXOFYrjR0rpLezupKSNXEr6XV5Q8/nBPF9TeVSrdqyzZ5scuhGErirI18Ftlw7JCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a780532c0eso13524975ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 18:12:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732068751; x=1732673551;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QR3IiHCmMAS135ipOKesGNIEoHwl29VS/YRgRzlZ4yw=;
        b=eKmVrAA8V4gMPJ1LpdgDY8ozKgMxl4PYEX+SM1vxb85+s1uCAMb9QQUbKYCL3HC+oI
         RCbCJpFhJZZ/HgAdPn9bqnC0GqG1TLHjmbK70M/e9BCYlGYbYNuF3t7/gPVNRsZzUdyp
         iOZETcF1XbRMmsaEAutxLfOxN2Y3EAhweelAAg3+ZesseIMrAhMbCtWcNcr7ClTJtnuI
         BrzrT4VwoWdlMcpvf95m9yn/rNn0YkRAIanLKjEVws2yidxh+nFqykYV+jCT7Xcsczqn
         ePtphsoiIYczYuaTK/6iPRMUv2O8UCW7xHNNCoqMMVFMeVL6ZrdY70/iC9IdEXxOe0C/
         4ckA==
X-Forwarded-Encrypted: i=1; AJvYcCU4CZ6xOfdGYQTcEFNzBxFquPeHlJ77m1TsUcfH5CKYtVpYDNWsPGDEDLuHUtBkjc1Kwhtiw/e7/NwTBbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIzmN3cMb/GpPLkF7G3Q/NqU/tM8mdan4ife7WfnWwy5TXrYrG
	3twKXszhlBYlJG8ha/3nSsAA6e5nhTNbBL7Kq/4OcMRDzez79EE+K0BDcMtLln4YTWvobIHQ7dL
	a6kIJo+pKM1IWJoglIZPvnCwDa81H9NpQsW75C8vTtYKt4Y5Mr+Y5Ymg=
X-Google-Smtp-Source: AGHT+IH9shiaE+yKmaGMU51r4agwrcCfBZPko5ipP/a1Dtj4ljHucqIpH5zgMXyAgX9MxiNNBG1kYQdnvv66EMcKuYGpQsANruX9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1605:b0:3a6:af24:b8c4 with SMTP id
 e9e14a558f8ab-3a78658d7b6mr13104145ab.20.1732068751560; Tue, 19 Nov 2024
 18:12:31 -0800 (PST)
Date: Tue, 19 Nov 2024 18:12:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673d458f.050a0220.363a1b.0003.GAE@google.com>
Subject: [syzbot] [btrfs?] WARNING in btrfs_release_global_block_rsv (2)
From: syzbot <syzbot+48ed002119c0f19daf63@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f868cd251776 Merge tag 'drm-fixes-2024-11-16' of https://g..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12dc1b5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1503500c6f615d24
dashboard link: https://syzkaller.appspot.com/bug?extid=48ed002119c0f19daf63
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11dfd130580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15dfd130580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/66a42ffd702c/disk-f868cd25.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b0bd620eb146/vmlinux-f868cd25.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6d14a828c8cb/bzImage-f868cd25.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/28ab3d88b5f1/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/f64e4ef84354/mount_1.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+48ed002119c0f19daf63@syzkaller.appspotmail.com

BTRFS info (device loop1): last unmount of filesystem b65e5074-7275-4634-a025-a4403a9281c2
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5830 at fs/btrfs/block-rsv.c:459 btrfs_release_global_block_rsv+0x261/0x270 fs/btrfs/block-rsv.c:459
Modules linked in:
CPU: 1 UID: 0 PID: 5830 Comm: syz-executor323 Not tainted 6.12.0-rc7-syzkaller-00187-gf868cd251776 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
RIP: 0010:btrfs_release_global_block_rsv+0x261/0x270 fs/btrfs/block-rsv.c:459
Code: 0f 0b 90 e9 0c ff ff ff e8 2c 0d bd fd 90 0f 0b 90 e9 36 ff ff ff e8 1e 0d bd fd 90 0f 0b 90 e9 67 ff ff ff e8 10 0d bd fd 90 <0f> 0b 90 eb 89 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
RSP: 0018:ffffc90003baf9b8 EFLAGS: 00010293
RAX: ffffffff83d7dca0 RBX: ffffffffffff0000 RCX: ffff888035a31e00
RDX: 0000000000000000 RSI: ffffffffffff0000 RDI: 0000000000000000
RBP: 0000000000000001 R08: ffffffff83d7dc25 R09: 1ffff1100540de01
R10: dffffc0000000000 R11: ffffed100540de02 R12: ffff88802a06a000
R13: 1ffff1100540d42e R14: ffff8880336f4400 R15: dffffc0000000000
FS:  000055558bffa3c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb775400000 CR3: 000000007e426000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_free_block_groups+0xc3c/0x1080 fs/btrfs/block-group.c:4472
 close_ctree+0x772/0xd60 fs/btrfs/disk-io.c:4378
 generic_shutdown_super+0x139/0x2d0 fs/super.c:642
 kill_anon_super+0x3b/0x70 fs/super.c:1237
 btrfs_kill_super+0x41/0x50 fs/btrfs/super.c:2114
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 ptrace_notify+0x2d2/0x380 kernel/signal.c:2404
 ptrace_report_syscall include/linux/ptrace.h:415 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:477 [inline]
 syscall_exit_work+0xc6/0x190 kernel/entry/common.c:173
 syscall_exit_to_user_mode_prepare kernel/entry/common.c:200 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:205 [inline]
 syscall_exit_to_user_mode+0x279/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb77d64c1e7
Code: 08 00 48 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b0 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffe158a5b88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fb77d64c1e7
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffe158a5c40
RBP: 00007ffe158a5c40 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000206 R12: 00007ffe158a6cf0
R13: 000055558bffb700 R14: 431bde82d7b634db R15: 00007ffe158a6c94
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

