Return-Path: <linux-kernel+bounces-521891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB18A3C387
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CD1E189CC5A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB961F460B;
	Wed, 19 Feb 2025 15:22:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4335F199237
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739978525; cv=none; b=FGdU5JWumGNJj6mJNuDSR1h2DLB3uRORMrI1hHNePVOI0GucgTjTC9lX2+OP4PVjoqzYB8oWVabb8tJzKT5lh485DRDZGAqbOJzMXjdW4SywDJQ/LjoqZvQcpIy+U0jzQ5s+Be8F0QvAAo8t0ArrZwRuqGKqdbonYXbflMmRjGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739978525; c=relaxed/simple;
	bh=4N9YU7DXKJzFyEmx0jv9ElThmWrBE1miv8K91qBPN4Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AeTP9e9gBSu0D43q2Ch26t+hQdBPH1DO9ke2F4ofyJK5Hyz4Zq7Oyne/f028/zaVu3qUwthBOngjOZBV0lKNH5B5XqqXdp8HkhjwgfH5sSQQFcQUvtZKrgTCnfd6YBaMxHmKzwPH/ADMvdP2I6Yb+XlqO5JZnBiZwzMM0AwSexQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d2a6ead92fso43078655ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 07:22:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739978523; x=1740583323;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OilmRa300duwRM9T9ZbrV1Ok0eif2kegAK0SF8cFU7k=;
        b=ovLmkOCSM9G5I7R9XiXoSkcXCz7bqQJ4O/JNyCYKR5soTHSVTdKZvh5BC17bqQHBYj
         xhanqB6tTn831teFcOAyaM+tDVnWm8C/jaK/Cqm+BqA1oIGe4NkO7eTK7yiUURUxlwCW
         ZpOqTOLppwZxrddxj+72xxafgxfrxnNIiEATo+R2Vj54l1MSwrKbegAsKpEq5nN6NfSj
         4MSdccqRuKUgs8OHAvR6N4lkbctVki5ElQujVP+g4DAXmMOhGwqPsYUaS9q1IUTeYyqT
         HukkRgKjeewRWalZy6+qAljyEH0NW/AXUIA9JitZ6qY6/TdMix2S7rzO4FM5fgOUYpeD
         QImw==
X-Forwarded-Encrypted: i=1; AJvYcCX1bwt/NoRfx1MheCanol+a5gisFJQwEBNF+O4Hgfb0pk9i6J3K8FU3OD6DG+Q+XK/usKenG1AEpkFwJ3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ86HTsVfPYg7OHsyYA1ofPdJCjc5Awwcxu4J2tADqBnr+FVhQ
	msUctreG3RjHaIV3x7Ss2isJ6p5nzW2DH+b5GHLLc72sVTrGljKwP7wJrIBXnSKwTbAfOp1gSUN
	OVJ3Lekg3kinp1SiPDA/J2RAHGByTGqCyTjsmVzxO+JBecggvAYi28kE=
X-Google-Smtp-Source: AGHT+IHpmpS3kQQIfIk7bNz/7QzzgRGsWjyAoU1brWCqeCYqadvxpRX5oZivbowrWaJ+TYOl5XTxryABVfyQDqiJVbnOVsd8c3Cc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d85:b0:3d2:75bc:71a with SMTP id
 e9e14a558f8ab-3d28078dc2cmr180909915ab.1.1739978523268; Wed, 19 Feb 2025
 07:22:03 -0800 (PST)
Date: Wed, 19 Feb 2025 07:22:03 -0800
In-Reply-To: <tencent_E04373696603AD045CB76C977726C7D36D05@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b5f71b.050a0220.14d86d.013b.GAE@google.com>
Subject: Re: [syzbot] [jfs?] KMSAN: uninit-value in diFree
From: syzbot <syzbot+df6cdcb35904203d2b6d@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in diFree

ERROR: (device loop0): diUpdatePMap: the iag is outside the map
ERROR: (device loop0): remounting filesystem as read-only
=====================================================
BUG: KMSAN: uninit-value in hex_dump_to_buffer+0x888/0x1100 lib/hexdump.c:171
 hex_dump_to_buffer+0x888/0x1100 lib/hexdump.c:171
 print_hex_dump+0x13d/0x3e0 lib/hexdump.c:276
 diFree+0x5ba/0x4350 fs/jfs/jfs_imap.c:878
 jfs_evict_inode+0x510/0x550 fs/jfs/inode.c:156
 evict+0x723/0xd10 fs/inode.c:796
 iput_final fs/inode.c:1946 [inline]
 iput+0x97b/0xdb0 fs/inode.c:1972
 txUpdateMap+0xf3e/0x1150 fs/jfs/jfs_txnmgr.c:2367
 txLazyCommit fs/jfs/jfs_txnmgr.c:2664 [inline]
 jfs_lazycommit+0x627/0x11d0 fs/jfs/jfs_txnmgr.c:2733
 kthread+0x6b9/0xef0 kernel/kthread.c:464
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4121 [inline]
 slab_alloc_node mm/slub.c:4164 [inline]
 __kmalloc_cache_noprof+0x8e3/0xdf0 mm/slub.c:4320
 kmalloc_noprof include/linux/slab.h:901 [inline]
 diMount+0x61/0x850 fs/jfs/jfs_imap.c:105
 jfs_mount+0xa8e/0x11d0 fs/jfs/jfs_mount.c:176
 jfs_fill_super+0xa47/0x17c0 fs/jfs/super.c:523
 get_tree_bdev_flags+0x6ec/0x910 fs/super.c:1636
 get_tree_bdev+0x37/0x50 fs/super.c:1659
 jfs_get_tree+0x34/0x40 fs/jfs/super.c:635
 vfs_get_tree+0xb1/0x5a0 fs/super.c:1814
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3560
 path_mount+0x742/0x1f10 fs/namespace.c:3887
 do_mount fs/namespace.c:3900 [inline]
 __do_sys_mount fs/namespace.c:4111 [inline]
 __se_sys_mount+0x71f/0x800 fs/namespace.c:4088
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:4088
 x64_sys_call+0x39bf/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 113 Comm: jfsCommit Not tainted 6.14.0-rc3-syzkaller-00060-g6537cfb395f3-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
=====================================================


Tested on:

commit:         6537cfb3 Merge tag 'sound-6.14-rc4' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=103f2fdf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8cf1217edc1cc7da
dashboard link: https://syzkaller.appspot.com/bug?extid=df6cdcb35904203d2b6d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13f49ae4580000


