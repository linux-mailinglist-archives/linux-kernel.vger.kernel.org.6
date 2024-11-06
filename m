Return-Path: <linux-kernel+bounces-397618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 376739BDE20
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 06:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 621911C21D16
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 05:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2BC190696;
	Wed,  6 Nov 2024 05:02:21 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C7A2F50
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 05:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730869341; cv=none; b=ta4yqt8zBMb694zGl0cRMV17yhoRFRnd7/xDI90i/wTIhOsKxV+V5cI/3mj+3U1gufIv18pTZGDy1upQqZ3KOq0aF6FzfIPPi/GMgNlGWGy+cFsgAC+s7J2LT0GDXkKL6VmnU9M43kmKdIVk9hS9Hw3r7LocRRbJUhHClPNmv0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730869341; c=relaxed/simple;
	bh=S6HVl5YYmeNgzf4H120DElxRhniXzUnsxIFr8KZvG1Q=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=E2O89dzBM81ONAIlBzf6tsF8ugqnMjZt5Zh9Qm/eGKHJyY0rSXo57dzG1y+piXlsvGGiuaTj6Agoi3gFDunRz20ctAJ56837t43wfThLHg85aqb9F0En2ZZSrCiMPsdmwbVSkcND5GWhAahsU16PlbSW9GdiJrUAUxgt460z0p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83b6628a71fso588149239f.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 21:02:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730869338; x=1731474138;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+O0Kb3rEGozlsN+xaRfLtSu1aFI8EkV95LDgZv6n7G8=;
        b=vou1DKzCKrISfUr9UOauYNtMHsrmvny3xeiR8uLshLlz4tfGiV1NQUaLJyRRYXHhgw
         YH//e374m2QOmeVqtYKE0lTeuo1Hd4oufW+iEQOa6mJ7hdl43O5ib1tCB5v5VVOvV0Rt
         wDq8NEO3unAGmz7/05g/ObkLSJyx1gX0ntmJWzrUmBjQsQXKNNgcfWQfLJYBMKcmBTc0
         bFgscA/NIXSif5U/8YBEl0zHscikh0gwM22oiqPluttkmedJlK8NghsPBAPR5i85uNhu
         05gD0b7Blohk+I8l19dlnrvg4X/U6Lk/ROZzHhNsTbq5x+ryX2Jnb8fFBHqVLMVarQ2/
         TfMg==
X-Forwarded-Encrypted: i=1; AJvYcCWrG43NL+uXRXKuFXtXa6cm7TFfi4Y7jBTk74VC16/qSxpkhV5Bb/ZSQRwdQlUlGhWPir2qjJAdh3eEIs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrOMrTzQ0jcyFr3Ffg0jgPoUFvofLkJiA2ZKU5/JWD3VuqNeCw
	0jyyFbcqCuRq6pUNKgP9W+Ng6xajaQ/4mOx1/n4JvTNNFkPpfqPHpSKvT6kKprwcqM4vmBZ8+tL
	OVFtwcYzlhYL2Ra4i8HJrSxd8KwrLOGNce9M4gKrJBtYfkLSsxLibyE8=
X-Google-Smtp-Source: AGHT+IFKCCJhaixJy45QcK9k7ayQSOfba2re5g9XCOmmQiFPPBUyevkkPEeMRPp2hNRt3jPgUyXvnsQdOqbCgGoYa55w8c4Sxakz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2163:b0:39f:5efe:ae73 with SMTP id
 e9e14a558f8ab-3a5e2436614mr278689915ab.5.1730869338630; Tue, 05 Nov 2024
 21:02:18 -0800 (PST)
Date: Tue, 05 Nov 2024 21:02:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672af85a.050a0220.2edce.151c.GAE@google.com>
Subject: [syzbot] [hfs?] KMSAN: uninit-value in hfsplus_cat_bin_cmp_key
From: syzbot <syzbot+968ecf5dc01b3e0148ec@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6c52d4da1c74 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1069c987980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1edd801cefd6ca3e
dashboard link: https://syzkaller.appspot.com/bug?extid=968ecf5dc01b3e0148ec
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e2b55f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1469c987980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4b3257cc2711/disk-6c52d4da.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/826b93a55a16/vmlinux-6c52d4da.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e7be84048c24/bzImage-6c52d4da.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/1dd80244cd46/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+968ecf5dc01b3e0148ec@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 1024
=====================================================
BUG: KMSAN: uninit-value in hfsplus_cat_bin_cmp_key+0xf1/0x190 fs/hfsplus/catalog.c:36
 hfsplus_cat_bin_cmp_key+0xf1/0x190 fs/hfsplus/catalog.c:36
 hfs_find_rec_by_key+0xb1/0x240 fs/hfsplus/bfind.c:89
 __hfsplus_brec_find+0x26f/0x7b0 fs/hfsplus/bfind.c:124
 hfsplus_brec_find+0x445/0x970 fs/hfsplus/bfind.c:184
 hfsplus_brec_read+0x46/0x1a0 fs/hfsplus/bfind.c:211
 hfsplus_find_cat+0xdb/0x460 fs/hfsplus/catalog.c:202
 hfsplus_iget+0x729/0xae0 fs/hfsplus/super.c:82
 hfsplus_fill_super+0x151b/0x2700 fs/hfsplus/super.c:509
 mount_bdev+0x39a/0x520 fs/super.c:1679
 hfsplus_mount+0x4d/0x60 fs/hfsplus/super.c:647
 legacy_get_tree+0x114/0x290 fs/fs_context.c:662
 vfs_get_tree+0xb1/0x5a0 fs/super.c:1800
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3507
 path_mount+0x742/0x1f10 fs/namespace.c:3834
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x722/0x810 fs/namespace.c:4034
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:4034
 x64_sys_call+0x255a/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4091 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 __do_kmalloc_node mm/slub.c:4263 [inline]
 __kmalloc_noprof+0x661/0xf30 mm/slub.c:4276
 kmalloc_noprof include/linux/slab.h:882 [inline]
 hfsplus_find_init+0x95/0x1d0 fs/hfsplus/bfind.c:21
 hfsplus_iget+0x3c4/0xae0 fs/hfsplus/super.c:80
 hfsplus_fill_super+0x151b/0x2700 fs/hfsplus/super.c:509
 mount_bdev+0x39a/0x520 fs/super.c:1679
 hfsplus_mount+0x4d/0x60 fs/hfsplus/super.c:647
 legacy_get_tree+0x114/0x290 fs/fs_context.c:662
 vfs_get_tree+0xb1/0x5a0 fs/super.c:1800
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3507
 path_mount+0x742/0x1f10 fs/namespace.c:3834
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x722/0x810 fs/namespace.c:4034
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:4034
 x64_sys_call+0x255a/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 5784 Comm: syz-executor301 Not tainted 6.12.0-rc5-syzkaller-00181-g6c52d4da1c74 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
=====================================================


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

