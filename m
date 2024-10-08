Return-Path: <linux-kernel+bounces-354426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E35D993D55
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 05:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823531C22E3D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 03:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BE0481C4;
	Tue,  8 Oct 2024 03:05:25 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202D7762D2
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 03:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728356724; cv=none; b=kZgrD8moq4JQTI1LfQnsA54dGAM5ri9irqaOi5BgACeBbNnqBP6H6KKS4Y+wyBxwsPpiSCvPi/goPM00WqJ66upYnB/PRDYZI/GeouW1YR3sidaNQZLxUSbifigV8x1OBh6ueu//UJKZTjbIqLQbUPevZBwOqTE+Lwin4tAaxyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728356724; c=relaxed/simple;
	bh=xgzPaapAgeL2GKG6MffSRUiz2mv0vCB7Y4qozpWQ2g8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lIvBonGPzGY1h2xqnWNej0beY1uGPbsAy9JpAg40MnfuU/un8AcKBogv8GFnFXn7OF3Iwd1oX4Xv2L6zbmx0HMr+8bxtrkjEJoxD2VxCQNQzyCdx4voocbtARUJyAUvWQMvxPnYesvxB8NwekrEOv6q4PwJmyFa6eq3oyqHUaT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82b930cd6b2so752988339f.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 20:05:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728356722; x=1728961522;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6hyPjBciPiuR+ISiT3/yVJJaBtBvP+OaBVaBC6WMepg=;
        b=udq+FiutptYrad8MdTr8CuXT10ExjzgrLLjijqvqm6/lAwAJBSYmrVC0d1S7L4HXSS
         4PVbxf+NwuRX1RN83zegGTAH/15umptnV/bwnF/TLU+6u4drrGI61BcJCjmXorDTVnA5
         YcsOb8HW3Y73kgG740rmgNV6HlyDIJYEnSkCvnL/DI6RmVn+quKZ9hbXYaX0AF5HCQUY
         pvby2UIZHi9LbPhsdRypxsImIr5kgqhyZBk0o2KSwG6sZ7nlIU+67HPIOMJQT+n1XZg3
         N8y2TVA4zDWW1IB8WIbNSKgNt0UdXchaCJ+dEghZfx7DeA6UUJTKo1BtSt3h9tqdc+lu
         KLIg==
X-Forwarded-Encrypted: i=1; AJvYcCUr6cMW/1HbmV3TcpCcp+ycybhxC633OisIxB0jsar/8fhXxLf7Q+F+zsSYooQBx2q2TUTqLXkzoKmCKKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBu5SRqJmCaWXS40xrTuu+7vjGB3skdjVWj6p/xJh9LU+IUOMR
	SozOfLyUXzQQexmU8JtaXiKo81My056kADDS2vJ9HsUwqNmuKq482S5GpWLAMe2y6VStmEi2Jl3
	EcDrBE7P0+Xp7BrQGzTfyqIyCa1gb0lncj0oiqwkf3ByIGgpbgc9DzP8=
X-Google-Smtp-Source: AGHT+IFSYhqiML3HGY+vdcChidhHXT7E/M2c6uBf5Y0S1WFUu2+E8sza3rCYpQWRjNQUQny+jCxzcSXzD6L0bBgyG+/Zfp9Fi78h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1846:b0:39d:2939:3076 with SMTP id
 e9e14a558f8ab-3a375bd2038mr126641345ab.25.1728356722167; Mon, 07 Oct 2024
 20:05:22 -0700 (PDT)
Date: Mon, 07 Oct 2024 20:05:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6704a172.050a0220.49194.0520.GAE@google.com>
Subject: [syzbot] [bcachefs?] WARNING in __bch2_fsck_err (2)
From: syzbot <syzbot+a3df02951b3139aec8eb@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5f5673607153 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=10cff580580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dedbcb1ff4387972
dashboard link: https://syzkaller.appspot.com/bug?extid=a3df02951b3139aec8eb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d5e307980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164433d0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/40172aed5414/disk-5f567360.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/58372f305e9d/vmlinux-5f567360.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d2aae6fa798f/Image-5f567360.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/1341ae90d594/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a3df02951b3139aec8eb@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 6422 at fs/bcachefs/error.c:242 __bch2_fsck_err+0x1bc8/0x278c fs/bcachefs/error.c:242
Modules linked in:
CPU: 1 UID: 0 PID: 6422 Comm: read_btree_node Not tainted 6.11.0-rc7-syzkaller-g5f5673607153 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __bch2_fsck_err+0x1bc8/0x278c fs/bcachefs/error.c:242
lr : __bch2_fsck_err+0x1bc8/0x278c fs/bcachefs/error.c:242
sp : ffff8000a4326740
x29: ffff8000a4326900 x28: ffff80008b92e200 x27: dfff800000000000
x26: 0000000000000001 x25: 0000000000000055 x24: ffff8000a43267e0
x23: 0000000000000000 x22: ffff8000a4326800 x21: 0000000000000055
x20: ffff0000dcb80000 x19: 0000000000000000 x18: ffff8000a4326200
x17: 000000000000cd00 x16: ffff800080569b84 x15: 0000000000000001
x14: 1ffff00014864cc8 x13: 0000000000000000 x12: 0000000000000000
x11: ffff700014864cc9 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000e3798000 x7 : 0000000000000000 x6 : 0000000000000000
x5 : ffff8000930c3640 x4 : 0000000000000008 x3 : ffff80008b41d320
x2 : 0000000000000001 x1 : 0000000000000008 x0 : 0000000000000001
Call trace:
 __bch2_fsck_err+0x1bc8/0x278c fs/bcachefs/error.c:242
 __bch2_bkey_fsck_err+0x7b0/0xea8 fs/bcachefs/error.c:436
 __bch2_bkey_validate+0x554/0x768
 bset_key_validate fs/bcachefs/btree_io.c:843 [inline]
 validate_bset_keys+0x724/0x1204 fs/bcachefs/btree_io.c:914
 bch2_btree_node_read_done+0x1a64/0x4ab4 fs/bcachefs/btree_io.c:1134
 btree_node_read_work+0x50c/0xe04 fs/bcachefs/btree_io.c:1323
 bch2_btree_node_read+0x1f50/0x280c fs/bcachefs/btree_io.c:1708
 bch2_btree_node_fill+0x8cc/0xfbc fs/bcachefs/btree_cache.c:886
 bch2_btree_node_get_noiter+0x7fc/0xbec fs/bcachefs/btree_cache.c:1155
 found_btree_node_is_readable fs/bcachefs/btree_node_scan.c:85 [inline]
 try_read_btree_node fs/bcachefs/btree_node_scan.c:190 [inline]
 read_btree_nodes_worker+0xdcc/0x1980 fs/bcachefs/btree_node_scan.c:239
 kthread+0x288/0x310 kernel/kthread.c:389
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
irq event stamp: 310
hardirqs last  enabled at (309): [<ffff800080a88010>] kasan_quarantine_put+0x1a0/0x1c8 mm/kasan/quarantine.c:234
hardirqs last disabled at (310): [<ffff80008b3363f4>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:470
softirqs last  enabled at (0): [<ffff8000801d498c>] copy_process+0x11f8/0x3264 kernel/fork.c:2319
softirqs last disabled at (0): [<0000000000000000>] 0x0
---[ end trace 0000000000000000 ]---
invalid bkey u64s 7 type xattr 1073741824:2097412339779176161:U32_MAX len 9568256 ver 0: user.xattr2:xattr2
  size != 0: delete?, fixing


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

