Return-Path: <linux-kernel+bounces-189016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A3E8CE9F4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 20:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6A761C23793
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 18:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F9F4C631;
	Fri, 24 May 2024 18:32:32 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6212E4AEF7
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 18:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575551; cv=none; b=qQ/MivYrA/hSTIcUlk/L2h+tG4E3h2wZm6BOHgBHrAPeukAcnc7/IXvMtHihMZpNQidsaJ0B+p8bMRlwzXF96WH5cy2Y92FfKFSnyhNhXR2KXiLBxwmmcyQfAsPuvSjI52CmDiyWzXH7n5Vc2BocK+8GwLKKim3C2tRUOEGYh8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575551; c=relaxed/simple;
	bh=5msJXS/dtKh3iOFppa8Cw0vW4deFvLyYforwtcAeIEc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=i+mZ164KlyMGciea9VP1wnNSc1eh7AE3wzSfCbqfFEyBk60SVUInsT0kC0F9zLKKzwQWroPOegZTZ19zVVCsUDPbjEC8JDhUNfvIq8a/K2QHrmZ4EsHCkGth/3vyuW2UQvLfS2Ro/0EEK+cKsDQfSBNkX7MgKlBCiAeK1Vh81b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7e92491e750so77639439f.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 11:32:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716575549; x=1717180349;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2R68mPgV+niEy7m8e9z+aOUhhRPmas2QR3yP8VqiXbg=;
        b=uEJsQSiNIxeoMvIlWxefR42+aEXamx/fArk+x9Fa8yaQNpATmft7MAh8cYek1YJpA7
         zxiEPwawzGIH3W2hDqPUb7RqvaxuUCatP/fKIXb9OnwVURd5RT5NFndtzamt7y1wMjQT
         yrfeF54lxqYHQHNfOg62RxDT4b9tPTFn12KQqlM5GSBm6Oqo5cqNM00CEYMKp70mHwtt
         oSmmRuItNuztzkJuIUGkweAZ9fP4SQypnCmJOEDPe8jd3FruY2GzguqZkwzRZJGWeBQ5
         tv4j9EVWJd4wVelDTkpefqd99kIJvO6Xk0g+EUvY/eT6d5XfeuIMzgnVgwUEMTBZ6Rvk
         Dvuw==
X-Forwarded-Encrypted: i=1; AJvYcCWBkBo1u2VivCtqb3/ZDSS7mcS4PNMV0J6u94CBpptH0xzoj6ZlYNhO+EAE1SLzf8LJjtdNk14vwovBQSOaeIN/M6RtjffVt9OzVIJU
X-Gm-Message-State: AOJu0YwgAPMPSVahzp6+b9QMlq5GHyyM4NvyWycRz/4upME7siKKcgQi
	At+/vL7Y8JCbtQpMORxVBiKMMxmNnwaN4lWuwVwZFjW/4Do6cQ6xJQGhQ7yiz556oaftpzjwbsS
	hWoa6ERd32gAIlvYbSKuMYiiZcAVUflCT7hpj88z8X5tET4EifoSHLPs=
X-Google-Smtp-Source: AGHT+IHfvW1MnyNVZokVzVh9uIYkP+1usWLG6aoc/PW1ZBB8HxPNzXUyNoI894fDJfHvPC5p6BqUt+R9gcRAGZDKaALBC55CYRln
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:a58e:0:b0:49d:f18c:de57 with SMTP id
 8926c6da1cb9f-4b03a21155amr98719173.0.1716575549613; Fri, 24 May 2024
 11:32:29 -0700 (PDT)
Date: Fri, 24 May 2024 11:32:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dd79ba0619376337@google.com>
Subject: [syzbot] [bcachefs?] kernel panic: not locked: inodes NUM:NUM:NUM cached
From: syzbot <syzbot+b01867e789ff58727a77@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fda5695d692c Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=145455cc980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=95dc1de8407c7270
dashboard link: https://syzkaller.appspot.com/bug?extid=b01867e789ff58727a77
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15bba634980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17d2a5cc980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/07f3214ff0d9/disk-fda5695d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/70e2e2c864e8/vmlinux-fda5695d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b259942a16dc/Image-fda5695d.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a396b8da95e5/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b01867e789ff58727a77@syzkaller.appspotmail.com

path: idx  2 ref 1:0 P S btree=dirents l=0 pos 4096:6783475523080972787:U32_MAX locks 0 bch2_trans_iter_init fs/bcachefs/btree_iter.h:489 [inline]
path: idx  2 ref 1:0 P S btree=dirents l=0 pos 4096:6783475523080972787:U32_MAX locks 0 bch2_hash_lookup_in_snapshot+0x150/0x564 fs/bcachefs/str_hash.h:173
path: idx  1 ref 0:0 P S btree=subvolumes l=0 pos 0:1:0 locks 0 bch2_trans_iter_init fs/bcachefs/btree_iter.h:489 [inline]
path: idx  1 ref 0:0 P S btree=subvolumes l=0 pos 0:1:0 locks 0 __bch2_bkey_get_iter+0xe4/0x248 fs/bcachefs/btree_iter.h:548
transaction updates for bch2_lookup journal seq 0
Kernel panic - not syncing: not locked: inodes 0:4101:0 cached
CPU: 1 PID: 6245 Comm: syz-executor964 Not tainted 6.9.0-rc7-syzkaller-gfda5695d692c #0
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
 lookup_open fs/namei.c:3475 [inline]
 open_last_lookups fs/namei.c:3566 [inline]
 path_openat+0xc90/0x2830 fs/namei.c:3796
 do_filp_open+0x1bc/0x3cc fs/namei.c:3826
 do_sys_openat2+0x124/0x1b8 fs/open.c:1406
 do_sys_open fs/open.c:1421 [inline]
 __do_sys_openat fs/open.c:1437 [inline]
 __se_sys_openat fs/open.c:1432 [inline]
 __arm64_sys_openat+0x1f0/0x240 fs/open.c:1432
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

