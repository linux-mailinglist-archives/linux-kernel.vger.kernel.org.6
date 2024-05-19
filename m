Return-Path: <linux-kernel+bounces-183021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3838C935E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 06:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22D7528183A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 04:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3F0E552;
	Sun, 19 May 2024 04:14:25 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD96EAEB
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 04:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716092064; cv=none; b=B9vhimQp7v1tQs4IyUcofYj+G4OYs7YIZcVu3nSu5CmcPBKl7SgkJ1X81vyZjOAgBIT6WKBhtnQsjBD5CcS9/zEP8u6atdsXXau1ZoCp6sPwm1xBh01M3Y7t1VEi6oXTCaRPXyQc8WnJux969KC9ZN1kQjNFIyaKIZBAnlbWsHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716092064; c=relaxed/simple;
	bh=tdQVZ4AwAXdSXyEHSvXRkCBni9f/234ybjzp3MRcQqQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iqEfxhddRrOFEYeIQ4l7FyNNQoAlUImNovl/tcl4UqrJZJmaGgZlrQXnigt0V3hbPj/Gn6emN9D4lckfdNkCDvpEX09vaTclyijYxErs5Eh7lQu51G8ApFLBkKQpNPygLK45upkhnveOQHuvhAVd2uMX16iVPiJiZl2BXu+8qwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7e1b65780b7so1148840239f.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 21:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716092062; x=1716696862;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Gv4btGU5EuwRMiUPysUsMEKq89JnY7Oo+TqSlvmw9c=;
        b=mtfLkZICSAqA2HkxjSWfzvu90rOtx3qHYIclRp9O2FdiaX2k1vYWpUBlR+ozfy/hg5
         VKPn85yPeptejATSZfMp0R+qfuxwJmb8bOOR/LKVNE8Om26QLYDwLhYbULw5uXRAMD+V
         Yw/NpwAvAy22ZGDHAFGZ4kgDrxQWCmx4KXPKtrIGTPZZTwbxb3sQK0vOR+96G1K/mZcZ
         G7WItlXg3xP+j83sLm/okXItVKl6OZW30b4dUW7hr+C1Z2m++LvQCW79+yF1IHxE1qcr
         LdOsXjtFyW4ooCx08V/KmWS8EbEXeUedyfXLkAGmDj0I6ZzaphNGouGxVJlQcnpY4nI/
         9BYA==
X-Forwarded-Encrypted: i=1; AJvYcCU9pGLm3wpC+UeagTFiz4dCr3GqvBsI5s+ySaJqfaJ/8TwzflZabcHGUW1k3sbWs1dWzLnRRR0CEIyNIztgL+6DNDyLtXItu00X8BnZ
X-Gm-Message-State: AOJu0YyBoeS51S5h6flm9tAHITR8RtzcUof978U35J8mwC4OGWK2NyXa
	nTsvZ0gATATywt/xP3TYqhieLc1igVVWSxuTSsBpE5ywwvpuJYtZsJAvdTAr9zo4T47XF3CEFzH
	lpmgBilcMydnQ7UWg9B6Nx5Ir4Ocvv4zqJ5JNfSX42mMkj3FLpznRCUM=
X-Google-Smtp-Source: AGHT+IGOILSPvfl3mS+DAYPhdxoShA1epXCEzg5FC715Lkg5fj8xD2F/3PT1qfJHumM4U9U33sXrw9nnnXCqTGEYPTpcS+lPRLDW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b8e:b0:7de:e16b:4b81 with SMTP id
 ca18e2360f4ac-7e1b5209a83mr216278139f.2.1716092062700; Sat, 18 May 2024
 21:14:22 -0700 (PDT)
Date: Sat, 18 May 2024 21:14:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cca85f0618c6d150@google.com>
Subject: [syzbot] [bcachefs?] kernel panic: not locked: inodes NUM:ADDR:NUM cached
From: syzbot <syzbot+95db43b0a06f157ee865@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fda5695d692c Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=158084e0980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=95dc1de8407c7270
dashboard link: https://syzkaller.appspot.com/bug?extid=95db43b0a06f157ee865
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10c1a96c980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15fffdd4980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/07f3214ff0d9/disk-fda5695d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/70e2e2c864e8/vmlinux-fda5695d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b259942a16dc/Image-fda5695d.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d58e9154055c/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+95db43b0a06f157ee865@syzkaller.appspotmail.com

path: idx  2 ref 1:0 P S btree=dirents l=0 pos 1073741824:2251139105009357257:U32_MAX locks 0 bch2_trans_iter_init fs/bcachefs/btree_iter.h:489 [inline]
path: idx  2 ref 1:0 P S btree=dirents l=0 pos 1073741824:2251139105009357257:U32_MAX locks 0 bch2_hash_lookup_in_snapshot+0x150/0x564 fs/bcachefs/str_hash.h:173
path: idx  1 ref 0:0 P S btree=subvolumes l=0 pos 0:1:0 locks 0 bch2_trans_iter_init fs/bcachefs/btree_iter.h:489 [inline]
path: idx  1 ref 0:0 P S btree=subvolumes l=0 pos 0:1:0 locks 0 __bch2_bkey_get_iter+0xe4/0x248 fs/bcachefs/btree_iter.h:548
transaction updates for bch2_lookup journal seq 0
Kernel panic - not syncing: not locked: inodes 0:1073741826:0 cached
CPU: 1 PID: 6237 Comm: syz-executor197 Not tainted 6.9.0-rc7-syzkaller-gfda5695d692c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:317
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:324
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:114
 dump_stack+0x1c/0x28 lib/dump_stack.c:123
 panic+0x30c/0x894 kernel/panic.c:348
 bch2_assert_pos_locked+0x890/0x8dc fs/bcachefs/btree_iter.c:367
 bch2_inode_update_after_write+0x184/0x88c fs/bcachefs/fs.c:59
 bch2_vfs_inode_init+0xac/0x640 fs/bcachefs/fs.c:1448
 bch2_lookup_trans fs/bcachefs/fs.c:419 [inline]
 bch2_lookup+0x918/0xbcc fs/bcachefs/fs.c:437
 lookup_one_qstr_excl+0x108/0x230 fs/namei.c:1607
 do_renameat2+0x51c/0xe40 fs/namei.c:4978
 __do_sys_renameat2 fs/namei.c:5071 [inline]
 __se_sys_renameat2 fs/namei.c:5068 [inline]
 __arm64_sys_renameat2+0xe0/0xfc fs/namei.c:5068
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
SMP: stopping secondary CPUs
Kernel Offset: disabled
CPU features: 0x00,00000103,80100128,42017203
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

