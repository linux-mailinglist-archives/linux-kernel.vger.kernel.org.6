Return-Path: <linux-kernel+bounces-201824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0D38FC400
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F14DFB22131
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 06:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F69918C321;
	Wed,  5 Jun 2024 06:56:31 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FBF19046E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 06:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717570590; cv=none; b=Wyi2h4W3Klouf2w3TfnhNOItpkERm9NK/S3Pk0X4flmKxgkcXrKtURuyTCBbXJ9p4adId/2A6ZjJtHgluMgDARQx7MKNfb8PddBIc0KoKMeyjQMiWM1GjB4vUu3mifif8J2iRF4eYFHM9DADlLWytki/BiHkNYgUKQ4Fylxg+X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717570590; c=relaxed/simple;
	bh=NHKmsHbmxaxmq/t5qOItAZcOd3PP1sLgh1/YDzV6OtM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=m4dlcj26n6l13DxPqlUGAsnl2I9RgDzGPmirl7+4YVdYBLBBw4QvoObi9cHNndjFGLM3fGwRwO3y4WZLMCZxdzfJD0sHD4H0k4tlErOFElef4HXdY/0nhO8Pne+D7d3Msws+E8MwDahJYFZFnSd4vWkDlvbBXd2H9/CMQpR4Ai4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-374a831d289so19714045ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 23:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717570588; x=1718175388;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a+22Nog8kQyyMDWaryrCDehipgD3m/ylHny5P6cbcV8=;
        b=lbZ0qj9MD6dyGEMvWxqg6I4MtzVjL1GOJgYNI01A801iEwXlsRyFfkqvnY6wp5Yqv2
         +sS7F39OIyLDnl9e+StnC95vzo0Vw2Uprn1wwcwBcyhVV7jsvUMh0tKSGLe0EA/9Was2
         vhQIyR5qmt2zDWkc/87prKTFsDiiFpX/IZk9DPfA0i7XorVhx9LYN7w/G9NLRZDa0Lvo
         OB3BSoCb17Tt1P5YSdr5sNZr2fn2jb4AnYKpLgUAVqzbdix6jIphWf4UEapk3F+p8JwT
         7ztp0JeZemJMWVBu1kmksGEXHD/hk8kuCHWkDPymS9azJpI1vgfodZAZpDnmmBiviU+H
         S18w==
X-Forwarded-Encrypted: i=1; AJvYcCV49pblipAD+SBVDRUrWjlMzFZbUwnsaCiheDjEp3Z+D2CmD7EB60hhKwO+f8HYWj0wChfSAG3NG9M++Pp/bFNOhui5O42wyvo2X9i2
X-Gm-Message-State: AOJu0YxNNF38HuJp06TdwuRappNhCcRDFSm0S0uJkojK0HGef6zAuFBu
	ex7emZFzfL+4TyaortU8/VS2zoGDkphrsnBsPJdn7Lfgz4Z60CQQsFsco4W8czTSvZAe1z0kzeq
	YR7ZUXBiBT/B6lAOQ7vyEjmiCWH9bOcnOfxdJDKE1nvZE7XCAdjd/90w=
X-Google-Smtp-Source: AGHT+IGF2NKMT0QCZAIh9zTQsnF7dh0kIhq6LR3RmJvCsubfL1ZWBaKM2qpvu3yqM4GH/qMBdlNUzMZjMs5ziuUsox6DsTq4H4Om
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c0d:b0:36c:4cc9:5923 with SMTP id
 e9e14a558f8ab-374b1ef2622mr919355ab.2.1717570588431; Tue, 04 Jun 2024
 23:56:28 -0700 (PDT)
Date: Tue, 04 Jun 2024 23:56:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cce9c0061a1f1071@google.com>
Subject: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_dirent_rename
From: syzbot <syzbot+ee45465624ceb2e49b50@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    614da38e2f7a Merge tag 'hid-for-linus-2024051401' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14bb8fd2980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5d2cbf33633f507
dashboard link: https://syzkaller.appspot.com/bug?extid=ee45465624ceb2e49b50
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/89eafb874b71/disk-614da38e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/356000512ad9/vmlinux-614da38e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/839c73939115/bzImage-614da38e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ee45465624ceb2e49b50@syzkaller.appspotmail.com

bcachefs (loop2): snapshots_read... done
bcachefs (loop2): journal_replay... done
bcachefs (loop2): resume_logged_ops... done
bcachefs (loop2): going read-write
bcachefs (loop2): done starting filesystem
=====================================================
BUG: KMSAN: uninit-value in dirent_is_visible fs/bcachefs/dirent.c:85 [inline]
BUG: KMSAN: uninit-value in is_visible_key fs/bcachefs/str_hash.h:159 [inline]
BUG: KMSAN: uninit-value in bch2_hash_lookup_in_snapshot fs/bcachefs/str_hash.h:177 [inline]
BUG: KMSAN: uninit-value in bch2_hash_lookup fs/bcachefs/str_hash.h:202 [inline]
BUG: KMSAN: uninit-value in bch2_dirent_rename+0x2227/0x54d0 fs/bcachefs/dirent.c:332
 dirent_is_visible fs/bcachefs/dirent.c:85 [inline]
 is_visible_key fs/bcachefs/str_hash.h:159 [inline]
 bch2_hash_lookup_in_snapshot fs/bcachefs/str_hash.h:177 [inline]
 bch2_hash_lookup fs/bcachefs/str_hash.h:202 [inline]
 bch2_dirent_rename+0x2227/0x54d0 fs/bcachefs/dirent.c:332
 bch2_rename_trans+0xb24/0x2680 fs/bcachefs/fs-common.c:416
 bch2_rename2+0x265c/0x2e40 fs/bcachefs/fs.c:669
 vfs_rename+0x1d9a/0x2280 fs/namei.c:4887
 do_renameat2+0x18cc/0x1d50 fs/namei.c:5044
 __do_sys_renameat2 fs/namei.c:5078 [inline]
 __se_sys_renameat2 fs/namei.c:5075 [inline]
 __x64_sys_renameat2+0x153/0x200 fs/namei.c:5075
 x64_sys_call+0x2993/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:317
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __kmalloc_large_node+0x231/0x370 mm/slub.c:3994
 __do_kmalloc_node mm/slub.c:4027 [inline]
 __kmalloc_node+0xb10/0x10c0 mm/slub.c:4046
 kmalloc_node include/linux/slab.h:648 [inline]
 kvmalloc_node+0xc0/0x2d0 mm/util.c:634
 kvmalloc include/linux/slab.h:766 [inline]
 btree_bounce_alloc fs/bcachefs/btree_io.c:118 [inline]
 bch2_btree_node_read_done+0x4e68/0x75e0 fs/bcachefs/btree_io.c:1185
 btree_node_read_work+0x8a5/0x1eb0 fs/bcachefs/btree_io.c:1324
 bch2_btree_node_read+0x3d42/0x4b50
 __bch2_btree_root_read fs/bcachefs/btree_io.c:1748 [inline]
 bch2_btree_root_read+0xa6c/0x13d0 fs/bcachefs/btree_io.c:1772
 read_btree_roots+0x454/0xee0 fs/bcachefs/recovery.c:457
 bch2_fs_recovery+0x7b6a/0x93e0 fs/bcachefs/recovery.c:785
 bch2_fs_start+0x7b2/0xbd0 fs/bcachefs/super.c:1043
 bch2_fs_open+0x152a/0x15f0 fs/bcachefs/super.c:2105
 bch2_mount+0x90d/0x1d90 fs/bcachefs/fs.c:1906
 legacy_get_tree+0x114/0x290 fs/fs_context.c:662
 vfs_get_tree+0xa7/0x570 fs/super.c:1779
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3352
 path_mount+0x742/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3875
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:3875
 x64_sys_call+0x2bf4/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 PID: 8627 Comm: syz-executor.2 Not tainted 6.9.0-syzkaller-02707-g614da38e2f7a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
=====================================================


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

