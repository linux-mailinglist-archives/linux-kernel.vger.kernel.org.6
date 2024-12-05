Return-Path: <linux-kernel+bounces-433828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 272809E5DA0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1E9F283094
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08356226EF9;
	Thu,  5 Dec 2024 17:48:30 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA38225764
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 17:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733420909; cv=none; b=BALOPTerbBpqmfsZOUKYhdq4EsBDV+oYPwM5gj4UC3LX8xPOThXCJHRCUgEbpBwT5GxG3FKAoRYrGLJ5/yHEy4BOkeymmV2tzDBOtKGwVEDU2qaje63FfCCO8H7fC/+B4k+dJvVlXRQwnmPv5sFY2/l6/wSzETXvwlm+8UbT1fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733420909; c=relaxed/simple;
	bh=zmhlyzlC9GrRt9m5HfMlvC4SlViWXzkbUHgpOC6ThoY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=l7MCgXruyhboRT/avvivTqdGErI9ztN5AEl9HvHdCkc58QGMqEJuSEIF+BTmlTq8LXH1B+wFHjo7xmVPlS/cyitUt/ZrCQ8OUiekxA7GEK40wcN2c8TIJingw3jlZuG6tRTZFdCBwy8RGHqfPcI45FZfK7n5I5Yvb9FDsQ2LjVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a7a5031e75so11860685ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 09:48:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733420906; x=1734025706;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YDBm+FIRrPaNrma9sJHagiH/vbC7+T2v9kpxDfCts7k=;
        b=sdrm2/mKyCYa1HHvpFJc1dsAeCInktydsj399qbpMcj2Z8B6ENkYgak4idpfRXJotl
         oZ/ZHsWt2LB7FDZijwHKC53UMObjCNiegHqlnGbYelIvIDUUgboDCHWtFbvk45Rng3vL
         +UZHHTSWSFYqkdzKE1fHCwAbhyZ3GwTP78F4prIDjcqKUWw6gIrf18iu46v+xC4Bhejp
         6dF6VtpNi07QfPQu8wTYsESPETG+UAVwMnzKQ9I5hVFWx6mInengcktWlxzPKjVw9FoZ
         xVKi8UlIFJlCigADZ9kkgLA11K+69r0WXojua2VeY8C7cmRfQUp5T/IKuwo5lkI+cjAt
         KZww==
X-Forwarded-Encrypted: i=1; AJvYcCVlitXLNO7IZQeAVmLEEuu+b436RJLRGZXP1GiP5pSDWM8UTw5VX4CCKAGuH+mHJV1blp296TPx4UMsv88=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2lkmSmjx8Hf0d+0q3Fm8fVRbPRARKbWf33CqFrc3QFjNpg7kJ
	w0pXEho8AxvHZu27XxqqXojfENbzzAenJEwaZMF5klmtlh+TVrkXROdHvjdij4UfWs50jHVKlVb
	MjLJhQomYUh25Ya1crwtaXzEz1bHOYk997oGeUksLsgLWbeuPGAV6mtE=
X-Google-Smtp-Source: AGHT+IGsBblv1anhEkUDDc7YUKAm5SOXhkZTK1MNJlJ/6MoO/lg9YuBko+zRcQGXaDbcp4RgP5xA6Z/JfcyL9DoxikRckT+vGEae
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1988:b0:3a7:e67f:3c58 with SMTP id
 e9e14a558f8ab-3a811dab8a4mr3724625ab.3.1733420906142; Thu, 05 Dec 2024
 09:48:26 -0800 (PST)
Date: Thu, 05 Dec 2024 09:48:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6751e76a.050a0220.b4160.01e0.GAE@google.com>
Subject: [syzbot] [bcachefs?] kernel panic: trans should be locked, unlocked
 by bch2_btree_update_start
From: syzbot <syzbot+d540192e763531d307ff@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    feffde684ac2 Merge tag 'for-6.13-rc1-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1244e330580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50c7a61469ce77e7
dashboard link: https://syzkaller.appspot.com/bug?extid=d540192e763531d307ff
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ae28df980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15ae28df980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-feffde68.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6135c7297e8e/vmlinux-feffde68.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6c154fdcc9cb/bzImage-feffde68.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/493102bf66d5/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d540192e763531d307ff@syzkaller.appspotmail.com

  io_time[WRITE]    256
  fragmentation     0
  bp_start          8
0 transaction updates for bch2_moving_ctxt_init journal seq 0
  
Kernel panic - not syncing: trans should be locked, unlocked by bch2_btree_update_start+0x1168/0x14e0 fs/bcachefs/btree_update_interior.c:1268
CPU: 0 UID: 0 PID: 5432 Comm: syz-executor147 Not tainted 6.13.0-rc1-syzkaller-00025-gfeffde684ac2 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 panic+0x349/0x880 kernel/panic.c:354
 bch2_trans_unlocked_error+0x42/0x50 fs/bcachefs/btree_iter.c:1439
 bch2_trans_verify_not_unlocked fs/bcachefs/btree_iter.h:340 [inline]
 bch2_path_get+0x11ea/0x1520 fs/bcachefs/btree_iter.c:1720
 bch2_trans_iter_init_common fs/bcachefs/btree_iter.h:502 [inline]
 bch2_trans_node_iter_init+0x325/0x630 fs/bcachefs/btree_iter.c:2921
 bch2_move_btree+0x4b8/0xde0 fs/bcachefs/move.c:846
 bch2_scan_old_btree_nodes+0x14b/0x3c0 fs/bcachefs/move.c:995
 bch2_fs_recovery+0x34f5/0x39d0 fs/bcachefs/recovery.c:974
 bch2_fs_start+0x356/0x5b0 fs/bcachefs/super.c:1037
 bch2_fs_get_tree+0xd68/0x1710 fs/bcachefs/fs.c:2170
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f369224366a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd04f2f448 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffd04f2f460 RCX: 00007f369224366a
RDX: 00000000200058c0 RSI: 0000000020005900 RDI: 00007ffd04f2f460
RBP: 0000000000000004 R08: 00007ffd04f2f4a0 R09: 000000000000593f
R10: 0000000001000000 R11: 0000000000000282 R12: 0000000001000000
R13: 00007ffd04f2f4a0 R14: 0000000000000003 R15: 0000000001000000
 </TASK>
Kernel Offset: disabled
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

