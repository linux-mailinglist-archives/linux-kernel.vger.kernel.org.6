Return-Path: <linux-kernel+bounces-289702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98288954ABB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F3F4B21728
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA041B86EA;
	Fri, 16 Aug 2024 13:07:23 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4F616EC0E
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 13:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723813642; cv=none; b=JbidioUm2XPYMTbw0GejiNHJcSQKP2gxU2EQk4ULTkHx5WlkPmK1hFlDF2ZWZnDnN1RdCYzhYrtdZCz7DCObpivCgx/Dj/QrcGHgo9mjdXDQg5d9clMSgDA/CF17d2GUiLLZzuUQNnOFTSoP8f6EuD3U8taubrXY2yREATs4nuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723813642; c=relaxed/simple;
	bh=L0HmvgiYBapFgYk2WLFw55WRD/kTFaqhncFko4ZwkBE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mNHzaGEmF/TSxHHoGN6gaxqhhiA3QoqQMdVV3uRi8zr8honkkOqT7oSzl/nMIPE/I3XGgjvM2Inko+fw6QEnikjNeouXwVoP+ug1S5eWAvOSveNY4kH8Qzc1JJyI08nbEWljyJjHPCegBbk85wy4aes/HlkuPnQGsrZbUX067wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f8c78cc66so196080939f.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 06:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723813640; x=1724418440;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TyMkDBKqyj36JPXBuwBod4T135oilhSCwmX1ZPtj3sQ=;
        b=EIwjKEheYxTT/YhDiAXJRRMnvIpB5RufS+IrPDftgrKjAnVaHjjneurlghgPN6s0S5
         Rsz2u0H4lRr4IllNs1uJwAfcBatJEytH+E3K0PuHIXi9DOx3Aw4pgQTp0HHz5SQEAsYI
         LyJR6qatFy2VUZfcYSyM8S5lISbbPn+uEggbfuNo+TpFH7TgSFW4B0jaRXaW1ZETGi8h
         FX0GNcifLQu82FWNe3ece+vZfzUdVdWASfhSoArhx6BjHmunq4Xh3x61OWRiVlkDJ8hW
         LZWKcRtAcb7TdyC0cyahc/i0vMN88wf8qG/Tg/+y1FMpGXu3jfWroDS8Ac1K97F+vziP
         qtxw==
X-Forwarded-Encrypted: i=1; AJvYcCXw1BInfR/1o+zsWG2Y+hd2VSReb+bEBtFpHEMA2TkDYKtPhKi+q0ysmZRAUFMoYlioWfz3e4dG2qsP5WxzNUZu3B1AkVQ1vDVLz9oL
X-Gm-Message-State: AOJu0Yy3gNG1J3TtfPioKodsl+6c5ywi8K42y60MlbWuaJqnVkZ5scpW
	h6hPWD6V/MdRua8m92A5V6tKVhI7mpTb8yXik/GGU+kMkLytAx4rC8AuzQjW6x3LuliT4/iMhiu
	8/z5JzFThV9MVMU9SR4Q/CTTgiG4/WR2FoEkoPZKqzli1XY6sTBvuMoE=
X-Google-Smtp-Source: AGHT+IGjua6JpoA+z6hx7QNHNQWcC3nh3FhqFDLriCJMoggKSjfiVcWyOYnNmx2110f3aMUdrYWbMJ3JMYk2qD+7LpGfD+ik3ARN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3410:b0:7f6:1e9c:d6f4 with SMTP id
 ca18e2360f4ac-824f271e077mr10873139f.3.1723813640070; Fri, 16 Aug 2024
 06:07:20 -0700 (PDT)
Date: Fri, 16 Aug 2024 06:07:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000acfa76061fcca330@google.com>
Subject: [syzbot] [ntfs3?] kernel panic: stack is corrupted in vprintk_emit
From: syzbot <syzbot+4d2aaeff9eb5a2cfec70@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d7a5aa4b3c00 Merge tag 'perf-tools-fixes-for-v6.11-2024-08..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1451b6d5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7229118d88b4a71b
dashboard link: https://syzkaller.appspot.com/bug?extid=4d2aaeff9eb5a2cfec70
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1450656b980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1391c35d980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-d7a5aa4b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/af15738cca6c/vmlinux-d7a5aa4b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/62dacb1384ee/bzImage-d7a5aa4b.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/9787f2a8ed93/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4d2aaeff9eb5a2cfec70@syzkaller.appspotmail.com

ntfs3: loop0: Different NTFS sector size (1024) and media sector size (512).
ntfs3: loop0: Failed to load $UpCase (-22).
Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: vprintk_emit+0x764/0x770
CPU: 0 UID: 0 PID: 5459 Comm: syz-executor295 Not tainted 6.11.0-rc3-syzkaller-00156-gd7a5aa4b3c00 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 panic+0x349/0x860 kernel/panic.c:348
 __stack_chk_fail+0x15/0x20 kernel/panic.c:821
 vprintk_emit+0x764/0x770
 _printk+0xd5/0x120 kernel/printk/printk.c:2373
 ntfs_printk+0x3ad/0x420 fs/ntfs3/super.c:93
 ntfs_fill_super+0x2eb8/0x4730
 get_tree_bdev+0x3f7/0x570 fs/super.c:1635
 vfs_get_tree+0x90/0x2a0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3472
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb031d0492a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 1e 09 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffce447eda8 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fb031d0492a
RDX: 000000002001f800 RSI: 000000002001f840 RDI: 00007ffce447edf0
RBP: 0000000000000004 R08: 00007ffce447ee30 R09: 000000000001f825
R10: 0000000000000801 R11: 0000000000000286 R12: 00007ffce447edf0
R13: 00007ffce447ee30 R14: 0000000000000003 R15: 0000000000200000
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

