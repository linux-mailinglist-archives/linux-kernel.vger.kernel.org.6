Return-Path: <linux-kernel+bounces-423836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFC29DAD70
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 19:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4035A1664FE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 18:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB76201268;
	Wed, 27 Nov 2024 18:59:28 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883DC201256
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 18:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732733968; cv=none; b=DrqRIfvfXnFL+i4Ft4wAkT+ez3nDXIKk4xrV3k2fN1ik9ACMyAMiepX4UpiUmo02DLjUJbhIbUIVwkepl41U/aMam+aguyMGIFWCXvlUEkqr7llN1N7bP9oJpc7QPL49KeXfjn6C3VknVYKUUp/wDhbj22HFEGK4hgujJRyuh8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732733968; c=relaxed/simple;
	bh=40lUiaN459iuggylNK3f2Qj6uItAXAH7jJqIvj8Bd4A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MusDtvcJeAiLwA4q4defpfxIXANueGeniq/YxPlTiO3zVVD4Ko9up/LARC+kmWfcsgqHUbT7XtewZJy/PxA86NTmnnE8zYQeCQx+a2iiHot81eiYKYwNWHQDNPlT7EhglAUtXGHj3v7kPmKYv5KSGufhzcq6iUavRLyEa38XNLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-84188ac27bdso391468839f.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 10:59:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732733965; x=1733338765;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x8aoJG1J+Mzfjsr0UMWWrpmcrpeCHW/sD5odUmWCTuA=;
        b=UVT0M6HpVo8mj0+icB9DkfK/dciQRduqQGjH92jPuWwUzcYsHq40NlIUVvXuIjBQoK
         tqkSCfx7sEySKm8P8horu4KtV5bRvC2E8bQVnjke7HbBcAIHp4dwd3ywXgBy5luLme+v
         ElxmzZibdZvkmETbvifZBU2cHFL4Vkn8I5oOsIsyEdnH4yw3XXdRFBkEybSA5RPUoDJP
         XjZdC4s3Fhje7wTF7jWwXqrKrYtFRWOcF+73TKuigNd6QpYrI1E260/rAzeouer9WWOV
         kt6VEjTY7DW7FheOVqpLU5TvxHV6oCFsvuJ0ACZd7ew8GOcAn9fsrAOUMJ/BQZ0K29Re
         MkAw==
X-Forwarded-Encrypted: i=1; AJvYcCWjEGPCXP4ctx3/1BUvLOwMe3oyNaZzgKgsJ3FE4b7yX3jm4g1F/RGLeBtqoZR5tMP+T6gE/y8uq+zHlkE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh3ECYO+VJUe3ag2gS3yQjJg5AugPvCKEtJ2zGkBZBrE8havbJ
	t2J7sk+fM2W5so5blyq3iyfEUAAb0lfn3mFhqryeiNmZlH6zY9nMb3OQP6ZKgmxwdHiD8p6YtPl
	XBGV+Jjrtmijke/z4dSTrdmV/wNAMxa3isEyQf0GKhix/QxbiG9jAUT8=
X-Google-Smtp-Source: AGHT+IEexO3kH9xc1RgNPUm691bxryz1KbOmKQWLZYOQwv4EKHitlWvNbR7loTNLkiWA3WkIs2Z2E/5sFpF0WVCuOMYgp6eAWK8L
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2144:b0:3a7:7124:bd2c with SMTP id
 e9e14a558f8ab-3a7c55d9bddmr49874725ab.19.1732733965612; Wed, 27 Nov 2024
 10:59:25 -0800 (PST)
Date: Wed, 27 Nov 2024 10:59:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67476c0d.050a0220.253251.005e.GAE@google.com>
Subject: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_bkey_cmp_packed_inlined
 (2)
From: syzbot <syzbot+65b594f491e4023728b0@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7eef7e306d3c Merge tag 'for-6.13/dm-changes' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=131543c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c5486b9d7cc64830
dashboard link: https://syzkaller.appspot.com/bug?extid=65b594f491e4023728b0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12eb2f5f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2331c33a914b/disk-7eef7e30.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8e50ed828391/vmlinux-7eef7e30.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a942e199e781/bzImage-7eef7e30.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/94dbb977c302/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+65b594f491e4023728b0@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in bch2_bkey_cmp_packed_inlined+0x8d0/0xd50 fs/bcachefs/bkey_cmp.h:115
 bch2_bkey_cmp_packed_inlined+0x8d0/0xd50 fs/bcachefs/bkey_cmp.h:115
 bch2_sort_keys_keep_unwritten_whiteouts+0xf94/0x19d0 fs/bcachefs/bkey_sort.c:184
 __bch2_btree_node_write+0x3ae8/0x6830 fs/bcachefs/btree_io.c:2095
 bch2_btree_node_write+0xa5/0x2e0 fs/bcachefs/btree_io.c:2284
 btree_node_write_if_need fs/bcachefs/btree_io.h:151 [inline]
 btree_update_nodes_written fs/bcachefs/btree_update_interior.c:833 [inline]
 btree_interior_update_work+0x3c24/0x4870 fs/bcachefs/btree_update_interior.c:861
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3310
 worker_thread+0xea7/0x14f0 kernel/workqueue.c:3391
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 ___kmalloc_large_node+0x22c/0x370 mm/slub.c:4238
 __kmalloc_large_node_noprof+0x3f/0x1e0 mm/slub.c:4255
 __do_kmalloc_node mm/slub.c:4271 [inline]
 __kmalloc_node_noprof+0xc96/0x1250 mm/slub.c:4289
 __kvmalloc_node_noprof+0xc0/0x2d0 mm/util.c:650
 btree_node_data_alloc fs/bcachefs/btree_cache.c:153 [inline]
 __bch2_btree_node_mem_alloc+0x2be/0xa80 fs/bcachefs/btree_cache.c:198
 bch2_fs_btree_cache_init+0x4e4/0xb50 fs/bcachefs/btree_cache.c:653
 bch2_fs_alloc fs/bcachefs/super.c:917 [inline]
 bch2_fs_open+0x4d3a/0x5b40 fs/bcachefs/super.c:2065
 bch2_fs_get_tree+0x983/0x22d0 fs/bcachefs/fs.c:2157
 vfs_get_tree+0xb1/0x5a0 fs/super.c:1814
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3507
 path_mount+0x742/0x1f10 fs/namespace.c:3834
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x722/0x810 fs/namespace.c:4034
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:4034
 x64_sys_call+0x39bf/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 13 Comm: kworker/u8:1 Not tainted 6.12.0-syzkaller-09567-g7eef7e306d3c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: btree_update btree_interior_update_work
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

