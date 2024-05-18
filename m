Return-Path: <linux-kernel+bounces-182808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 719908C9023
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 11:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 131151F223E0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 09:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1280717555;
	Sat, 18 May 2024 09:21:31 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8004A2D
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 09:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716024090; cv=none; b=n+4hH3ELhfWiOJ+/kbKnEEIPm1WoHg61ioANowVbfvoe8TUd9DSq1kgiN2Q8kl3pdNbGqsDnBEjETzwFPA1OpA/9WOc3hzbo6nPRf1uxWHT6fZNP6VcPc9HxVvC0ht77FbiA0ngsrmz8D++k1W8o7MSOASuRrYjDANgjwDILv7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716024090; c=relaxed/simple;
	bh=ueENnLy6R1i73rLrw474/Wjb06OfO9OYMrw3+qQzOJM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Ha/1a7BDXLZc2CvArYM0i8NX1WjnmKsspHUpSLl1nRofSkOJ5pX+HkS4NalcEGQrFbDPUiqK7Dgxo/p/9Jamka3CyU4K34Iu4/RYHe8WeU/QC98XmsdPTdH1i+Nfh+UjGG944Z1iubMNx+LmJeEOknEvkzs64bXESk9NFMiaxxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7dabc125bddso1147941539f.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 02:21:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716024088; x=1716628888;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7u2sykXclLAuHjZeOQu7w1/FZzOCnzTGbTdJDxNLL/U=;
        b=DQUxaMpzXJeokz6XzfHqClZCUv3thDiBCd91QWrvfOGROi8NfY9ZJn/dYAS+gDEXWt
         +IEQA4TtSzYNWuoV+K1naLeZ7nGgVDZIq7iwiDq04Jo64NDXW3d3PEiYSKx2dklvoMAr
         bRATzievAxEE3WeZfkMTu05nO/KFVCybiX3QoICtguBSThqnv57mRKxQIxR6YWhEsAvp
         +Ot3o2D7I4rt5A1ac1VQJsViklVUsy7D+9UbAqvW4QaQTHcmgBEsM5Hd0iTVyf7Aiv2H
         HiPa4D2HMr/UCwtI8H6r/KsQFjgjSwS7AOnoSWGMP2DzaFPa+W6h1rjPu9DlzCtscaxm
         R6TA==
X-Forwarded-Encrypted: i=1; AJvYcCXqsBPyiGwKr39DZ2emmA/UyvuwoMNf9B6fSt0ke+0CPEEYpoPrOBTSZjIAT5Mb2yp8o+lk5UqnfN79WneN2yQJly9cnmMqwzZqtKDU
X-Gm-Message-State: AOJu0YzsubZfuYRgPJ6Yr2J6NESR45E3Yx/ZibQO6KqTPjriXcupy4yw
	LC6Zp4MzvGO0M81IBiYEgvXncfpv1yg5yZC2lYrJihqlpVOFMy+dYrNoYZZzt56nZ8YbOgOdO75
	+VomMLeRfpBUXarnEcjBDSQDGhMRPccy7sE07ObUnL620L1tcUGjqiu8=
X-Google-Smtp-Source: AGHT+IHjizWcP8MG9wxRuuBdba2WI1gcMyvUyfIgNCs8Sh48sJfXSchzsHoJfI/ii4Vx1kkGq+pS4+EwPoM8vBhnTbJ5YutdpVTY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8506:b0:488:9082:8dd0 with SMTP id
 8926c6da1cb9f-48957cb32aemr1631403173.0.1716024088396; Sat, 18 May 2024
 02:21:28 -0700 (PDT)
Date: Sat, 18 May 2024 02:21:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000037162f0618b6fefb@google.com>
Subject: [syzbot] [hfs?] KMSAN: uninit-value in copy_name
From: syzbot <syzbot+efde959319469ff8d4d7@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a5131c3fdf26 Merge tag 'x86-shstk-2024-05-13' of git://git..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16035b70980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=64e100d74625a6a5
dashboard link: https://syzkaller.appspot.com/bug?extid=efde959319469ff8d4d7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10314fbc980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11f47248980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/81edac548743/disk-a5131c3f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/42f67aa888e5/vmlinux-a5131c3f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2e5cf5b3704d/bzImage-a5131c3f.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/08efa6c23198/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+efde959319469ff8d4d7@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in sized_strscpy+0xc4/0x160
 sized_strscpy+0xc4/0x160
 copy_name+0x2af/0x320 fs/hfsplus/xattr.c:411
 hfsplus_listxattr+0x11e9/0x1a50 fs/hfsplus/xattr.c:750
 vfs_listxattr fs/xattr.c:493 [inline]
 listxattr+0x1f3/0x6b0 fs/xattr.c:840
 path_listxattr fs/xattr.c:864 [inline]
 __do_sys_listxattr fs/xattr.c:876 [inline]
 __se_sys_listxattr fs/xattr.c:873 [inline]
 __x64_sys_listxattr+0x16b/0x2f0 fs/xattr.c:873
 x64_sys_call+0x2ba0/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:195
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3877 [inline]
 slab_alloc_node mm/slub.c:3918 [inline]
 kmalloc_trace+0x57b/0xbe0 mm/slub.c:4065
 kmalloc include/linux/slab.h:628 [inline]
 hfsplus_listxattr+0x4cc/0x1a50 fs/hfsplus/xattr.c:699
 vfs_listxattr fs/xattr.c:493 [inline]
 listxattr+0x1f3/0x6b0 fs/xattr.c:840
 path_listxattr fs/xattr.c:864 [inline]
 __do_sys_listxattr fs/xattr.c:876 [inline]
 __se_sys_listxattr fs/xattr.c:873 [inline]
 __x64_sys_listxattr+0x16b/0x2f0 fs/xattr.c:873
 x64_sys_call+0x2ba0/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:195
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 PID: 5047 Comm: syz-executor429 Not tainted 6.9.0-syzkaller-01768-ga5131c3fdf26 #0
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

