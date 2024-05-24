Return-Path: <linux-kernel+bounces-189135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C92B8CEBAB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 23:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B650AB216AE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 21:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8094C84A53;
	Fri, 24 May 2024 21:06:30 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B116823D0
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 21:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716584790; cv=none; b=DyCnzsT00dlRr95rlZQZV7UAXVIIdk2T5ILN0B86atRmiWUEvwkM4/7q2KtIEs3llelTSxNd+Op69aXDW9bRAxDHQYqAY77l/Zvoy8kZ62VxYIn9yuVlz5tmBgRzxKsBhal1F6oh0mgxkpKIjelBWVcWCIsXU4aCI1dZr8uEPP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716584790; c=relaxed/simple;
	bh=2g5KmH/crh64CquZwkIFfn7OzNgqf1dSfm5ijaTvYmI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KcPGwnLFNyPfXjfQYn6DwZFWxrhMfZ4eX8BtYNsk890O2PvPqd+a/Q4pJqU+NIl08xgEL8PhewcPUgvDug/P4o1i6BQ1bTShbS2uOla+eJutQwyfY6pUJteWqIU+u2ityb4MTJW2gAPskE0/vpfFORLCYlMd8vBtWNtrqA47URk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-36fe7b4ca2eso36922205ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 14:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716584787; x=1717189587;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EbZccHYr0VHHqYDgpwcysVLwOm6ViDucV9pCBr7KlAo=;
        b=aCrcC7fCjFd8GzaKsToEAEdn1rKwV72EP5SVgVKnBjvKCf0JOPqz6dq3Gw/Z3sfhc0
         HmWKSVxX6i6x6OmhHJ30p4mTj+qp6PSFQIe9B7JBIIkb60bqWh3yfqsy9e6Kv9x7yidh
         yg4B9L/W3efMcoR23NkmE7pOoKg+R1eKaPomNOWpoFmc4SUMBEoS2N7XAD0JGNQtHoR4
         YYCEQY+4pKlyzDCDhhctJhhZ74gTXMay5AK0XAAx7H7lmCFiy+uzKP67W0/EZz06RIF/
         1aPIhgG3Iaz1e6Pe84bAXf05vdNZ+4Oaqzoa06J/wBh9IpRHkitf9qlExf6whU+ENusv
         PjAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFmG6fZF1irrBnkRZOdKIT/QIpbofScJfEOMvuz7+Vbm6mUoJ+1uFWTufHIL9yvMHB9FaEg42yuHFUvENLsR2Drv4+JLNxBf/AzOHk
X-Gm-Message-State: AOJu0YyBpbZDL3E60HFVR0oHrB0pgKICZ98vmRfIvX8Crlfm1vysCxmI
	m5N8vCh4ze+/JP2F+o7azFa8XR436GxSWNahXI2B0qSN7+ibmdLeXbVxmyiY6xZ4zvgrnWRM8uO
	ft/Nl+Mw+jiIndcMhgXtQvxanwU376jp+vCyDYckyX9wlHEyRSvKFuc4=
X-Google-Smtp-Source: AGHT+IEF7eCaOxp6PbCVCcZKQytu7Us07etK69PHytKkCmlzyu30k50iyWfqAqmM/48jCLmpC42nJyy8WUgdWH9eztuwH+sKfzt8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c247:0:b0:36c:852:9dc with SMTP id e9e14a558f8ab-3737b46721dmr2181805ab.6.1716584787627;
 Fri, 24 May 2024 14:06:27 -0700 (PDT)
Date: Fri, 24 May 2024 14:06:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007e604a0619398aa8@google.com>
Subject: [syzbot] [jfs?] BUG: unable to handle kernel paging request in txBeginAnon
From: syzbot <syzbot+4e89b5368baba8324e07@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fda5695d692c Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=104354b2980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=95dc1de8407c7270
dashboard link: https://syzkaller.appspot.com/bug?extid=4e89b5368baba8324e07
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1748ee42980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=155733e4980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/07f3214ff0d9/disk-fda5695d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/70e2e2c864e8/vmlinux-fda5695d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b259942a16dc/Image-fda5695d.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/abb93d88d631/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4e89b5368baba8324e07@syzkaller.appspotmail.com

 ... Log Wrap ... Log Wrap ... Log Wrap ...
 ... Log Wrap ... Log Wrap ... Log Wrap ...
jfs_dirty_inode called on read-only volume
Is remount racy?
Unable to handle kernel paging request at virtual address dfff800000000008
KASAN: null-ptr-deref in range [0x0000000000000040-0x0000000000000047]
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[dfff800000000008] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 6241 Comm: syz-executor389 Not tainted 6.9.0-rc7-syzkaller-gfda5695d692c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : generic_test_bit include/asm-generic/bitops/generic-non-atomic.h:128 [inline]
pc : txBeginAnon+0xac/0x154 fs/jfs/jfs_txnmgr.c:465
lr : spin_lock include/linux/spinlock.h:351 [inline]
lr : txBeginAnon+0x78/0x154 fs/jfs/jfs_txnmgr.c:458
sp : ffff80009b2171c0
x29: ffff80009b2171c0 x28: ffff800093828e48 x27: ffff800093828000
x26: ffff800093828000 x25: 0000000000000008 x24: 0000000000000150
x23: dfff800000000000 x22: 0000000000000001 x21: 0000000000000000
x20: 0000000000000040 x19: ffff80008f473720 x18: ffff80009b216e80
x17: 000000000000cc10 x16: ffff80008034c6cc x15: ffff700013642e20
x14: 1ffff00013642e20 x13: 0000000000000004 x12: ffffffffffffffff
x11: ffff700013642e20 x10: 1ffff00013642e20 x9 : abdcc8a6ab47b800
x8 : abdcc8a6ab47b800 x7 : 0000000000000000 x6 : 0000000000000000
x5 : 0000000000000020 x4 : 0000000000000000 x3 : ffff80008034c7fc
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000001
Call trace:
 txBeginAnon+0xac/0x154
 extAlloc+0xe8/0xdec fs/jfs/jfs_extent.c:78
 jfs_get_block+0x340/0xb98 fs/jfs/inode.c:248
 __block_write_begin_int+0x580/0x166c fs/buffer.c:2105
 __block_write_begin fs/buffer.c:2154 [inline]
 block_write_begin+0x98/0x11c fs/buffer.c:2213
 jfs_write_begin+0x44/0x88 fs/jfs/inode.c:299
 generic_perform_write+0x28c/0x588 mm/filemap.c:3974
 __generic_file_write_iter+0xfc/0x204 mm/filemap.c:4069
 generic_file_write_iter+0xb8/0x2b4 mm/filemap.c:4095
 do_iter_readv_writev+0x438/0x658
 vfs_writev+0x410/0xb58 fs/read_write.c:971
 do_pwritev fs/read_write.c:1072 [inline]
 __do_sys_pwritev2 fs/read_write.c:1131 [inline]
 __se_sys_pwritev2 fs/read_write.c:1122 [inline]
 __arm64_sys_pwritev2+0x1dc/0x2f0 fs/read_write.c:1122
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
Code: aa1803e0 97ffff65 aa1303e0 95922607 (38776b28) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	aa1803e0 	mov	x0, x24
   4:	97ffff65 	bl	0xfffffffffffffd98
   8:	aa1303e0 	mov	x0, x19
   c:	95922607 	bl	0x6489828
* 10:	38776b28 	ldrb	w8, [x25, x23] <-- trapping instruction


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

