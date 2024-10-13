Return-Path: <linux-kernel+bounces-362832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3D299B9B8
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 16:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FCE21F21721
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 14:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B3514659A;
	Sun, 13 Oct 2024 14:27:27 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE38413C670
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 14:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728829647; cv=none; b=I8Jx8rE4wpCwjrxiQBvK2VMT7PihrYTYkoaTXGstMP5wzxS2sLlNcWcao9lGr1Rf65g9FO/68bpkEkGdhSOTrXK+lgU14o1g63YTg7QIin4msOsE0RTDXWDZDHShyRJ9upt++WtXPpxmhOkZs0pp7imC0bSzM3dvf0usxJQe8xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728829647; c=relaxed/simple;
	bh=x4Y6Ly8yE3kIQ6uMsPLxBIoPG0ZxJPEEmP4VbEVSNwA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Q/X83dun/4omPOH+GszizjyJKVvqBQjtfMCP5QVSaIPRzt3TlnoK+oaOtabb4iw6EwSM6HLZpkyRXOAihc3X+CMxwQYZySLTuOHFmtZODTo8qg9HrGJRaxXMS32jnsr1D3pftnxnrPDfCMVzwZ06xdDA8iQwu+CZNYIfoEGoLE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3b7129255so33838965ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 07:27:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728829645; x=1729434445;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rw61GrKwmSlkI2cBvmihtPvil1IAJQ13vEZc82GslPo=;
        b=SC2frLkKx37o282fBWDfTNUKMKCYAoSuRMbB+urhpP6i4u8gQMKEziHpUyr0fVBLgX
         8ydRPMX+tLJGJ9uTxxHZ34Ie1cVrG1MntuDRnPo3BPmszOz1dU/7bJbBN5SaCar0zqXt
         2+Dj9PzLjOj9jq08YeR63sluJTtyrdpTDRBa72EPagVxAzM2Y2mycrwJTJp8Hwli8hmX
         xkDUY7s0o+BPQydq0uQvhc3SxTVxiIyfID091pcggqM0bGgm5Z2d0b/Vb48mRvzOIchJ
         +dPtAY1Pb+5XDbgKJqF/Yauv8uGNvLx7m3fLn6aIIuncDPSeRox9Uwxg1VxDT+W6+s6k
         LhRg==
X-Forwarded-Encrypted: i=1; AJvYcCV9NQZr/q2OhT/I9wnCmMtEaGUvzs+94AxI8Fklp3gtI3v8z78YRnmUOmWNgCUJ8FXMzQH9LxST8XxiaUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKwWElhRh14Rls910xIj25IZm/RsatriN8qyRhEmwypKd31TNi
	JBdeTYZj1PBY6z7KRCqoQ5IVPUyYLcnBj2OsAmL6M9FkFUO2cgaSAajqopcqDXmvibMB8OkM1oJ
	KHxuO9sbdxIYsonTc5Cxzm0Ns7J2dvd2YGr01qh8DDcNqfgswyS1+Pu4=
X-Google-Smtp-Source: AGHT+IFoAJAgNQVkY81pFzqLM2Pr+kEQ237KvyhTx2N8/DD2uSu/oPi82mIqy+ht/dmi7S98SbOatCWpBsRZlcm9JZwumFRBT7ZE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1786:b0:3a3:b1c4:8197 with SMTP id
 e9e14a558f8ab-3a3b6053e14mr62708855ab.23.1728829644945; Sun, 13 Oct 2024
 07:27:24 -0700 (PDT)
Date: Sun, 13 Oct 2024 07:27:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670bd8cc.050a0220.4cbc0.0031.GAE@google.com>
Subject: [syzbot] [bcachefs?] kernel panic: bcachefs (loop3): panic after error
From: syzbot <syzbot+e6ea15c610261d2106ba@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    75b607fab38d Merge tag 'sched_ext-for-6.12-rc2-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10d35780580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a3fccdd0bb995
dashboard link: https://syzkaller.appspot.com/bug?extid=e6ea15c610261d2106ba
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14560f07980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/283eaf72a57c/disk-75b607fa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a721235f5b80/vmlinux-75b607fa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f5219ace4d70/bzImage-75b607fa.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c65430058ea3/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e6ea15c610261d2106ba@syzkaller.appspotmail.com

bcachefs (loop3): starting version 1.7: mi_btree_bitmap opts=errors=panic,metadata_checksum=crc64,data_checksum=none,compression=lz4,background_compression=gzip,no_splitbrain_check,nocow
superblock marked clean but clean section not present, shutting down
Kernel panic - not syncing: bcachefs (loop3): panic after error
CPU: 1 UID: 0 PID: 5433 Comm: syz.3.18 Not tainted 6.12.0-rc2-syzkaller-00058-g75b607fab38d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 panic+0x349/0x880 kernel/panic.c:354
 bch2_inconsistent_error+0x146/0x150 fs/bcachefs/error.c:26
 __bch2_fsck_err+0x1167/0x15f0 fs/bcachefs/error.c:422
 bch2_read_superblock_clean+0x3b4/0x520 fs/bcachefs/sb-clean.c:152
 bch2_fs_recovery+0x1f4/0x39c0 fs/bcachefs/recovery.c:639
 bch2_fs_start+0x356/0x5b0 fs/bcachefs/super.c:1037
 bch2_fs_get_tree+0xd68/0x1710 fs/bcachefs/fs.c:2080
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4055 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4032
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb67417f79a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb674f20e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fb674f20ef0 RCX: 00007fb67417f79a
RDX: 00000000200058c0 RSI: 0000000020000100 RDI: 00007fb674f20eb0
RBP: 00000000200058c0 R08: 00007fb674f20ef0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000020000100
R13: 00007fb674f20eb0 R14: 0000000000005957 R15: 0000000020000080
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

