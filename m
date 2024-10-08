Return-Path: <linux-kernel+bounces-355880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 066D7995858
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 22:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E71D1F2497E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A92B212D27;
	Tue,  8 Oct 2024 20:25:34 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D21E1E104B
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 20:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728419134; cv=none; b=C2kCt+j6wFO36OJncsQuevvRs8tjFgTaay5r2NVNGXjqoqs4ukyLJULU7xILRALLuBdX64pX35NNIz+4/lQE1cSzwPXVz4HtNi5fRH2uhs6KAVXRE52MRqySvxyL5RvOXs4FoyC1VT6AD3NIyWUT9KalpTA4Q9GRO11BWTb4tAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728419134; c=relaxed/simple;
	bh=J/Ki0n9pVsPFjcco3oQs1K8zbcPx0QGSRmfUSIcDaUQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QGKBktIC9sQ/tRzEDRcjZvuWSRlFyuOm9p1w0HqJV0cov9daUqOkoTABYrfZrfcotgRpNPUM4JIQV/2Gnk9DVLHPl62f59ISCsz00Ru4xHIQQBwTOIP7FxHDcOt7/xImieHqMrcfacKRkFYETjBc5g5AAD+qCSEos3TNOgBys1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3453139c0so80811525ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 13:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728419131; x=1729023931;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y2Ig2x9i0o9+c3myVbuwcuhtCLALXPCl/U00NODsczw=;
        b=YEkfh2AbOxbAMIERmAW2BdIG+jkO9HUklnVj/9Qz8kIIjK4TrmyN3i0R8Iode44zhp
         xzS6er8lqH5hsWpznVC8iA1fDhAv/RwzD56xrhceQiYyuVmaEGszINKwxFW/3XT79vw0
         EBckRMoFSJE+pZk4L+KisQxhmZeWd1Cdp/5k37nBekLrI/bfRYTyZaEbkdoABiyZqcP/
         PyEWpmAv1tkrMoE165p1VFaurQ8Qy76GVII2yO7mlceQTHnwDvonupk5MeiUtjZ3enN2
         QgYSylTCKom1/cqNYsMtxRvzIlOeAG+O/0BCiaxkSMRIy686LtGZY/NHIqG3yWndONim
         njvA==
X-Forwarded-Encrypted: i=1; AJvYcCXFrnHd9DY9gFWs5PBZoDVZ6CV7epU5MtJECiJpMkGX8HAlQHW1U5lVWoZw44VsT2C+E9XKTZ1zcLY8isE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVq2o0ew7gjBJFadP5PyuUBUm4algvcH460RnyDDy9R9+p/4Jx
	3uhqaf5+A9IrzJVO8P9pFEtdIUG9KGgAlOjVUExK+ys852JMwJxlX9EGT3l0/5mfmQ0LxRXr/rX
	In7bdTL1fQAY+CdlUEUL5atcpGUv2n5+XFlSLprV5Rum4HQp1gOxl1yw=
X-Google-Smtp-Source: AGHT+IF3VPH07G+IMeYqtS77I4JBQUhm3HHSv9uc+0ubfyDRzkRPsLeBVt5SlX6t/LvCex+VGDbHZCQPL05Mu1n2jQ/4q/i4SWsJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1561:b0:3a0:98b2:8f3b with SMTP id
 e9e14a558f8ab-3a397cfa93cmr1634735ab.7.1728419131082; Tue, 08 Oct 2024
 13:25:31 -0700 (PDT)
Date: Tue, 08 Oct 2024 13:25:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6705953b.050a0220.840ef.000b.GAE@google.com>
Subject: [syzbot] [mm?] WARNING in vms_complete_munmap_vmas
From: syzbot <syzbot+38c3a8b50658644abaca@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    80cb3fb61135 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=137aa7d0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9f31443a725c681
dashboard link: https://syzkaller.appspot.com/bug?extid=38c3a8b50658644abaca
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f94327980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=177aa7d0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f883f65fbfeb/disk-80cb3fb6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d950aa1c78a2/vmlinux-80cb3fb6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/972c4d758a0b/Image-80cb3fb6.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+38c3a8b50658644abaca@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6413 at mm/vma.c:1147 vms_complete_munmap_vmas+0x6f4/0x840 mm/vma.c:1147
Modules linked in:
CPU: 0 UID: 0 PID: 6413 Comm: syz-executor308 Not tainted 6.12.0-rc1-syzkaller-g80cb3fb61135 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : vms_complete_munmap_vmas+0x6f4/0x840 mm/vma.c:1147
lr : vms_complete_munmap_vmas+0x6f4/0x840 mm/vma.c:1147
sp : ffff80009bc27550
x29: ffff80009bc275a0 x28: ffff0000d695f800 x27: 0000000000000c00
x26: ffff0000d695fa00 x25: ffff80009bc277d0 x24: ffff0000d695f9f8
x23: ffff80009bc277c8 x22: 0000000000000021 x21: 00000000000010dd
x20: 1ffff00013784ef6 x19: dfff800000000000 x18: ffff80009bc26b60
x17: 000000000000d6db x16: ffff80008b3bde40 x15: 0000000000000010
x14: 1ffff00013784e84 x13: 0000000000000000 x12: 0000000000000000
x11: ffff700013784e94 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000c2c88000 x7 : 0000000000000000 x6 : 000000000000003f
x5 : 0000000000000040 x4 : ffffffffffffffe0 x3 : 0000000000000020
x2 : 0000000000000000 x1 : 0000000000000021 x0 : 0000000000000c00
Call trace:
 vms_complete_munmap_vmas+0x6f4/0x840 mm/vma.c:1147
 mmap_region+0xc68/0x1e28 mm/mmap.c:1533
 do_mmap+0x7e0/0xe00 mm/mmap.c:496
 vm_mmap_pgoff+0x1a0/0x38c mm/util.c:588
 ksys_mmap_pgoff+0x3f0/0x5c8 mm/mmap.c:542
 __do_sys_mmap arch/arm64/kernel/sys.c:28 [inline]
 __se_sys_mmap arch/arm64/kernel/sys.c:21 [inline]
 __arm64_sys_mmap+0xf8/0x110 arch/arm64/kernel/sys.c:21
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:732
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:750
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
irq event stamp: 8790
hardirqs last  enabled at (8789): [<ffff80008047a578>] se


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

